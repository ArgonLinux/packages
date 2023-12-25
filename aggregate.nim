import std/[os, osproc, strutils], 
       libarpm/io,
       libarpm/package_format/package_info

proc handlePkg*(dir: string) =
  info "Found directory \"" & dir & "\"!"
  assert fileExists(dir / "build.sh")
  assert fileExists(dir / "info.toml")

  let packageInfo = packageInfo(
    readFile(dir / "info.toml")
  )
  
  let res = execCmd(
    "sh " & dir / "build.sh"
  )
  
  if res != 0:
    error "Unable to build package \"" & packageInfo.info.name & "\"! Build script exited with non-zero exit code " & $res & "!"
    quit 1

proc main =
  info "Beginning package aggregator!"
  for kind, file in walkDir(getCurrentDir()):
    if kind == pcDir:
      if "bin-pkgs" in file:
        continue

      let splitted = file.split('/')
      if splitted[splitted.len-1].startsWith('.'):
        continue

      handlePkg(file)

  info "Done!"

when isMainModule:
  main()
