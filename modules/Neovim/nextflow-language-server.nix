# Packages the official Nextflow language server.
#
# Upstream distributes the server as a fat jar on GitHub Releases. Building it
# from source needs Gradle *plus* a checkout of the Nextflow repo sitting next
# to it (see upstream's Makefile), which is unpleasant to make hermetic. Pinning
# the released artifact by URL + hash gives you the same reproducibility
# guarantee with far less machinery. If you genuinely need a source build, see
# the note at the bottom of this file.
{
  lib,
  stdenvNoCC,
  fetchurl,
  makeWrapper,
  jdk17,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "nextflow-language-server";

  # Language server versions track Nextflow's release scheme (YY.MM.patch), but
  # the patch numbers are independent of Nextflow's own patch numbers.
  version = "26.04.3";

  src = fetchurl {
    url = "https://github.com/nextflow-io/language-server/releases/download/v${finalAttrs.version}/language-server-all.jar";
    hash = "sha256-IM+jT24gLWuLq9jXhiAs4A4NObcMzsMpDiqz+9ArwBY=";
  };

  dontUnpack = true;

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/java/language-server-all.jar"

    makeWrapper ${lib.getExe' jdk17 "java"} "$out/bin/nextflow-language-server" \
      --add-flags "-jar $out/share/java/language-server-all.jar"

    runHook postInstall
  '';

  meta = {
    description = "Language server for Nextflow scripts and config files";
    homepage = "https://github.com/nextflow-io/language-server";
    license = lib.licenses.asl20;
    mainProgram = "nextflow-language-server";
    sourceProvenance = [lib.sourceTypes.binaryBytecode];
    platforms = lib.platforms.unix;
  };
})
# ----------------------------------------------------------------------------
# If you want a true source build instead:
#
#   - clone nextflow-io/language-server AND nextflow-io/nextflow (the build
#     expects ../nextflow as a sibling directory)
#   - the Gradle build needs network access, so you need an offline dependency
#     set: either pkgs.gradle + a `mitm-cache` / `gradle2nix` style lockfile, or
#     a fixed-output derivation that populates GRADLE_USER_HOME.
