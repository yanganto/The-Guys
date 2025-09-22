{ source, stdenv, zola, build-params }:
  stdenv.mkDerivation rec {
    pname = "The-Guys";
    version = "0.1.0";
    src = builtins.toString source;
    nativeBuildInputs = [ zola ];
    buildPhase = ''
      ${zola}/bin/zola build ${build-params}
    '';
    installPhase = "cp -r public $out";
}
