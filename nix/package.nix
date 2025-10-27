{ source, stdenv, zola, sub-path ? null }:
  stdenv.mkDerivation rec {
    pname = "The-Guys";
    version = "0.1.0";
    src = builtins.toString source;
    nativeBuildInputs = [ zola ];
    buildPhase = if sub-path == null then
      "${zola}/bin/zola build --minify"
    else
    ''
      cd content
      find . -type f -exec sed -i 's#"/img/#"${sub-path}img/#g' {} \;
      find . -type f -exec sed -i 's#"/logo/#"${sub-path}logo/#g' {} \;
      cd ../sass
      find . -type f -exec sed -i 's#/img/#${sub-path}img/#g' {} \;
      find . -type f -exec sed -i 's#/fonts/#${sub-path}fonts/#g' {} \;
      cd ..
      ${zola}/bin/zola build -u ${sub-path}
    '';
    installPhase = "cp -r public $out";
}
