{ stdenv, fetchFromGitHub, git, gnugrep, less, makeWrapper }:

stdenv.mkDerivation rec {
  name = "git-recall-${version}";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Fakerr";
    repo = "git-recall";
    rev = "v${version}";
    sha256 = "1r3zj57vgi34qb60z3gz5d10qjls1871g3mkavs2qhi4xvk2ndls";
  };
  
  dontBuild = true;
  
  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 git-recall $out/bin/
    wrapProgram $out/bin/git-recall \
      --prefix PATH : "${stdenv.lib.makeBinPath [ git gnugrep less ]}"
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/Fakerr/git-recall;
    description = "An interactive way to peruse your git history from the terminal";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [ maintainers.Fakerr ];
  };
}
