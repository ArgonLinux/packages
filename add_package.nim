# nim c -d:release -d:speed -d:flto -d:danger -r ./add_package.nim
# just a note

import std/[os, json, parseopt], libarpm/[io], libarpm/parsers/[maintainer, licenses]

proc main =
  var 
    opt = initOptParser()

  let
    repo = ask("Repository Name")
    name = ask("Package Name")
    version = ask("Version")
    license = ask("License")
    maintainer = ask("Maintainer String (libarpm-maintainer-spec-compliant)")
  
  # This will quit the program if the license/maintainer is invalid.
  discard parseLicense(license)
  discard parseMaintainer(maintainer)
  
  info "Opening repository file: " & repo & ".json"
  let data = readFile(repo & ".json")
    .parseJson()

  data["packages"].add(
    %* {
      "name": name,
      "license": license,
      "version": version,
      "maintainer": maintainer,
      "depends": [],
      "optional_depends": [],
      "provides": [],
      "files": []
    }
  )

  writeFile(repo & ".json", data.pretty())

  info "Done. You'll need to add dependencies, optional dependencies, package provides and files manually."

when isMainModule:
  main()
