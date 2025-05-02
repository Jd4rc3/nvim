{ pkgs ? import <nixpkgs> {} }:

let
  openssl = pkgs.openssl;
in
pkgs.mkShell {
  buildInputs = [
    openssl
    pkgs.pkg-config
    pkgs.rustc
    pkgs.cargo
  ];

  shellHook = ''
    export OPENSSL_LIB_DIR=${openssl.out}/lib
    export OPENSSL_INCLUDE_DIR=${openssl.dev}/include
    export PKG_CONFIG_PATH=${openssl.dev}/lib/pkgconfig
    export OPENSSL_STATIC=0
  '';
}

