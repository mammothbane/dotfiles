{ pkgs, ... }:
{
  imports = [
    ./wrap-setuid.nix
  ];

  home.packages = with pkgs; [
    # utilities
    coreutils
    binutils
    diffutils
    findutils
    patchelf
    gnugrep
    gnutar
    gawk
    bashInteractive
    less
    which
    file
    flock
    acl
    gnupatch
    gnused

    # runtime system
    systemd
    procps
    utillinux
    kmod
    pciutils
    usbutils
    lshw

    # compression
    lzma
    bzip2
    unzip
    gzip

    # libs
    openssl
    glibcLocales

    # fs
    e2fsprogs
    iotop
    dosfstools
    ntfs3g

    # network
    nmap
    socat
    wget
    curl
    inetutils
    iproute
    iputils
    netcat-gnu
    openssh
    dnsutils

    # newer/specialized find and transform
    fd
    ripgrep
    jq
    yaml2json
    dos2unix

    # debugging, tracing
    rr
    gdb
    strace
    linuxPackages.perf

    # programming
    python3
    rustup
    ghc
    gocode
    cmake

    # nix
    nixFlakes
    nix-index
    arion
    nix-du
    nix-tree
    nix-bisect.defaultPackage.${pkgs.system}
    # cachix

    # misc / discretionary
    youtube-dl
    _1password
    # neuron
    cordless
    ncspot
    graphviz

    # yubikey / gpg
    gnupg
    yubikey-manager
    yubikey-personalization

    # tulip
    tulip.dump
    tulip.restore
  ];
}
