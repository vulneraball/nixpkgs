{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, nix
, nlohmann_json
, boost
, graphviz
, Security
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "nix-du";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "symphorien";
    repo = "nix-du";
    rev = "v${version}";
    sha256 = "sha256-Ft0j9kcR5HTSX0K09OKZMIUz25PR/isqZQIKmlNjqNE=";
  };

  cargoSha256 = "sha256-x+NONRKF7b0tADG2flgBKo32wx/TyXm7Z0bd9ZbbES8=";

  doCheck = true;
  nativeCheckInputs = [ nix graphviz ];

  buildInputs = [
    boost
    nix
    nlohmann_json
  ] ++ lib.optionals stdenv.isDarwin [ Security ];

  nativeBuildInputs = [ pkg-config rustPlatform.bindgenHook ];

  meta = with lib; {
    description = "A tool to determine which gc-roots take space in your nix store";
    homepage = "https://github.com/symphorien/nix-du";
    license = licenses.lgpl3Only;
    maintainers = [ maintainers.symphorien ];
    platforms = platforms.unix;
  };
}
