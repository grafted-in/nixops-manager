
{ targetEnv ? "virtualbox" } :
  let
        region = "us-gov-west-1";
        zone = "us-gov-west-1a";
        accessKeyId = "default";
  machine = 
    { config, pkgs, resources, ... }:{
      imports = 
    (if targetEnv == "ec2" then 
    [<nixpkgs/nixos/modules/virtualisation/amazon-image.nix>] else []) ++ 
      [ <nixpkgs/nixos/modules/profiles/minimal.nix> ];
    deployment.targetEnv = targetEnv;
    deployment.ec2 = {
        keyPair = resources.ec2KeyPairs.my-key-pair;
        ebsInitialRootDiskSize = 30;
        ebsOptimized = true;
        associatePublicIpAddress = true;
        ami = "ami-bb7618da";
        inherit region zone accessKeyId; 
        instanceType = "t3.large";
    };
    ec2.hvm = true;
    boot.initrd.postDeviceCommands= ''
    ${pkgs.e2fsprogs}/sbin/e2fsck -fp /dev/disk/by-label/nixos
    ${pkgs.e2fsprogs}/sbin/resize2fs /dev/disk/by-label/nixos
  '';

    deployment.virtualbox.memorySize = 4096; # megabytes
    deployment.virtualbox.vcpu = 2; # number of cpus
    deployment.virtualbox.headless = true;

    networking.extraHosts = "${config.networking.privateIPv4} api.kube";
    services.kubernetes = {
      easyCerts = true;
      addons.dashboard.enable = true;
      roles = ["master" "node"];
      apiserver = {
        securePort = 443;
        advertiseAddress = config.networking.privateIPv4;
      };
      masterAddress = "api.kube";
    };
    services.dockerRegistry.enable = true;
    environment.systemPackages = with pkgs; [
      kompose kubectl
      vim e2fsprogs
    ];
    networking.firewall.allowedTCPPorts = [22 443 ];
    users.users.root.openssh.authorizedKeys = {
      keyFiles = [  ];
    };
  };
  in {
  kubemaster = machine;

  network.description = "kubenixops";
  network.enableRollback = true;
  resources = if targetEnv == "ec2" then {
    ec2KeyPairs.my-key-pair = { inherit region accessKeyId; };
  }else {};

}
