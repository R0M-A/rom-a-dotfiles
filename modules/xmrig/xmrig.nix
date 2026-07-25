{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Memtest86+
  boot.loader.systemd-boot.memtest86.enable = true;

  #CPU Model-Specific Registers (MSR) module
  hardware.cpu.x86.msr = {
    enable = true;
    settings.allow-writes = "on";
  };

  boot.kernelParams = [
    "transparent_hugepage=never"
    "hugepagesz=1G"
    "hugepages=2" # change to the number you want or at least the number of NUMA nodes
  ];

  #   programs.ryzen-monitor-ng.enable = true;
  environment.systemPackages = with pkgs; [
    monero-gui
    monero-cli

    ##### Monitoring #####
    #     ryzen-monitor-ng #
    #     zenmonitor # Nice and simple, keeps max and min, all values look correct
    (pkgs.callPackage ./zenmonitor.nix { })
    (pkgs.callPackage ./ryzen-monitor.nix { }) # sudo ryzen_monitor -c --t-power --t-electrical --t-memory
    cpu-x
    #     ryzenadj #Fam19h: unsupported model 33 Only Ryzen Mobile Series are supported
    #     corectrl # Lacks everything needed
    #     conky # Cool but couldn't find use
    # sudo monitor_cpu -f # lost of broken stuff, but it does give PPT, TDC, EDC limits

    ##### Benchmarking #####
    xmrig # sudo xmrig --randomx-1gb-pages/--1gb-pages --bench=10M --threads=30 #sudo -> msr, 1GB pages are a slight optimization, 10M lasts ~7-8mins on R9 5950x, always use 1 or 2 less threads than MAX
    y-cruncher
    sysbench
  ];
  #   ++ [ inputs.personal-nixpkgs.legacyPackages.${pkgs.system}.ryzen-monitor-ng ];

#   services.xmrig = {
#     enable = true;
#     settings = {
#       autosave = true;
#       cpu = true;
#       opencl = false;
#       cuda = false;
#       pools = [
#         {
#           url = "pool.supportxmr.com:443";
#           user = "42j6rhZc12uDPsLN45M5xgFarMxomgqRrcu32vhXiT4oVU4WhHNrn4SCJWg2YmyMKuWFqtz3iBBY2CBsK13UCL6fC3G3ekF"; # Rudar - Domagoj
#           keepalive = true;
#           tls = true;
#         }
#       ];
#     };
#   };

  ##### Miner #####
  #   services.monero = {
  #     enable = true;
  #     prune = false;
  #     dataDir = "/mnt/Magare/XMR";
  #     banlist = builtins.fetchurl {
  #       # Ideally https://gui.xmr.pm/files/block.txt and https://github.com/Boog900/monero-ban-list/blob/main/ban_list.txt
  #       url = "https://raw.githubusercontent.com/Boog900/monero-ban-list/refs/heads/main/ban_list.txt";
  #       hash = "";
  #     };
  #     extraConfig = "--enforce-dns-checkpointing --enable-dns-blocklist";
  #     mining = {
  #       enable = true;
  #       threads = 30;
  #       address = "42j6rhZc12uDPsLN45M5xgFarMxomgqRrcu32vhXiT4oVU4WhHNrn4SCJWg2YmyMKuWFqtz3iBBY2CBsK13UCL6fC3G3ekF"; # Rudar - Domagoj
  #     };
  #   };
}

################# CO magic
# taskset -c 0 sysbench cpu --time=60 run
