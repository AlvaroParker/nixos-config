{
  description = "Node.js dev shell with specific Prisma version";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-25.05"; };

    # Pinned nixpkgs for prisma only
    old-prisma-nixpkgs = {
      url = "github:NixOS/nixpkgs/c57fe374c322a1adbf35a3a89fda854930fdc445";
      flake = false;
    };
  };

  outputs = { nixpkgs, old-prisma-nixpkgs, ... }: {
    devShells.x86_64-linux.default = let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      prismaPkgs = import old-prisma-nixpkgs { inherit system; };

    in pkgs.mkShell {
      name = "nodejs-shell";

      buildInputs = with pkgs; [
        package-version-server
        nodejs
        openssl
        turbo
        nodePackages.yarn
        nodePackages.typescript
        nodePackages.prettier
        nodePackages.eslint

        # From older pinned nixpkgs
        prismaPkgs.prisma
        prismaPkgs.prisma-engines
      ];

      packages = [
        pkgs.nodejs
        pkgs.ngrok
        prismaPkgs.nodePackages.prisma
        prismaPkgs.prisma-engines
      ];

      shellHook = ''
        export PRISMA_QUERY_ENGINE_BINARY=${prismaPkgs.prisma-engines}/bin/query-engine
        export PRISMA_QUERY_ENGINE_LIBRARY=${prismaPkgs.prisma-engines}/lib/libquery_engine.node
        export PRISMA_SCHEMA_ENGINE_BINARY=${prismaPkgs.prisma-engines}/bin/schema-engine
        export PRISMA_FMT_BINARY=${prismaPkgs.prisma-engines}/bin/prisma-fmt
        export PRISMA_INTROSPECTION_ENGINE_BINARY=${prismaPkgs.prisma-engines}/bin/schema-engine
      '';
    };
  };
}
