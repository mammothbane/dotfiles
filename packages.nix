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

    # nix
    nixFlakes
    nix-index
    arion
    # cachix

    # programming
    python3
    rustup
    ghc
    gocode

    # misc / discretionary
    gnupg
    youtube-dl
    _1password
    # neuron
    cordless
    ncspot
    cmake

    # tulip
    tulip.dump
    tulip.restore
  ];
}
