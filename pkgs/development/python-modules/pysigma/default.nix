{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchpatch
, poetry-core
, pyparsing
, pytestCheckHook
, pythonOlder
, pyyaml
}:

buildPythonPackage rec {
  pname = "pysigma";
  version = "0.4.5";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "SigmaHQ";
    repo = "pySigma";
    rev = "v${version}";
    hash = "sha256-jZPimSkJ6qTs0kEMVhP9Gnxu0jxA0cmgdn5++CevgIM=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    pyparsing
    pyyaml
  ];

  checkInputs = [
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace 'pyparsing = "^3.0.7"' 'pyparsing = "*"' \
  '';

  pythonImportsCheck = [
    "sigma"
  ];

  meta = with lib; {
    description = "Library to parse and convert Sigma rules into queries";
    homepage = "https://github.com/SigmaHQ/pySigma";
    license = with licenses; [ lgpl21Only ];
    maintainers = with maintainers; [ fab ];
  };
}
