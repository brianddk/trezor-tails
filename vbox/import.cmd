@echo off
:: [rights]  Copyright 2020 brianddk at github https://github.com/brianddk
:: [license] Apache 2.0 License https://www.apache.org/licenses/LICENSE-2.0
:: [repo]    github.com/brianddk/trezor-tails/tree/scratch
:: [btc]     BTC-b32: bc1qwc2203uym96u0nmq04pcgqfs9ldqz9l3mz8fpj
:: [tipjar]  github.com/brianddk/trezor-tails/blob/scratch/vbox/import.cmd
:: [req]     https://tails.boum.org/install
setlocal
set imgfile=%~1
set imgbase=%~n1
set vmname=%~2
set template=%~dp0template.ovf
echo %template%
if "%imgfile%" == "" goto :failed
if "%vmname%" == "" goto :failed
where VBoxManage 2>&1 1>NUL || goto :failed
set cmd=VBoxManage import "%template%" --vsys 0 --vmname "%vmname%" ^^^| findstr /C:"Suggested VM base folder"
for /f usebackq^ delims^=^"^ tokens^=2 %%I in (`%cmd%`) do set basepath=%%I
pushd "%basepath%\%vmname%"
VBoxManage convertfromraw "%imgfile%" "%imgbase%.vdi"
VBoxManage modifymedium disk "%imgbase%.vdi" --resize 16384
VBoxManage storageattach "%vmname%"  ^
  --medium "%imgbase%.vdi"           ^
  --storagectl USB                   ^
  --port 0                           ^
  --type hdd                         ^
  --hotpluggable on
popd

goto:eof
:failed
echo FAILED
echo.
echo Usage:
echo   %0 <imgfile> <vmname>