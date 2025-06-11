{ pkgs, ... }:

pkgs.mkShell {
  name = "nodejs-shell";
  buildInputs = with pkgs; [
    package-version-server
    nodejs
    openssl
    turbo
    prisma
    prisma-engines
    nodePackages.yarn
    nodePackages.typescript
    nodePackages.prettier
    nodePackages.eslint

  ];
  # export PRISMA_MIGRATION_ENGINE_BINARY="${pkgs.prisma-engines}/bin/migration-engine"
  # export PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING=1
  packages = [ pkgs.nodejs pkgs.nodePackages.prisma pkgs.prisma-engines ];
  shellHook = ''
    export PRISMA_QUERY_ENGINE_BINARY=${pkgs.prisma-engines}/bin/query-engine
    export PRISMA_QUERY_ENGINE_LIBRARY=${pkgs.prisma-engines}/lib/libquery_engine.node
    export PRISMA_MIGRATION_ENGINE_BINARY=${pkgs.prisma-engines}/bin/schema-engine
    export PRISMA_SCHEMA_ENGINE_BINARY=${pkgs.prisma-engines}/bin/schema-engine
    export PRISMA_FMT_BINARY=${pkgs.prisma-engines}/bin/prisma-fmt
    export PRISMA_INTROSPECTION_ENGINE_BINARY=${pkgs.prisma-engines}/bin/schema-engine

  '';
}
