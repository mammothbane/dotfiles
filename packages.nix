{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jq
    ripgrep
    fd
    xclip
    iotop
    curl
    socat
    wget
    youtube-dl
    nmap
    gnupg
    yaml2json
    coreutils
    unzip
    bashInteractive
    less
    file
    binutils
    which
    gnugrep
    gnutar
    openssh
    patchelf
    findutils
    gawk
    utillinux
    bzip2
    e2fsprogs
    diffutils
    flock
    acl
    gzip
    inetutils
    iproute
    iputils
    kmod
    dosfstools
    ntfs3g
    netcat-gnu
    gnupatch
    procps
    rr
    gdb
    gnused
    strace
    linuxPackages.perf
    lzma
    gzip
    systemd
    cmake
    dos2unix

    openssl

    _1password
    # neuron

    nixUnstable
    nix-index
    arion
    # cachix

    cordless
    ncspot

    glibcLocales

    python3
    rustup
    elixir_1_10
    ghc

    gocode

    pinentry

    tulip.dump
    tulip.restore
  ];
}
