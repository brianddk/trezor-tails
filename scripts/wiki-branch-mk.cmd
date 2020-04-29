@echo off
setlocal
set prefix=https://github.com/
set prefix=gh.brianddk:
set org=brianddk
set repo=trezor-tails
goto:main

:create-branch
  REM git clone %prefix%%org%/%repo%.git
  pushd %repo%
  REM git config --local user.name brianddk
  REM git config --local user.email brianddk@users.noreply.github.com
  REM git remote add wiki %prefix%%org%/%repo%.wiki.git
  git fetch wiki
  git checkout --orphan wiki
  git rm --cached -r .
  git clean -d -f
  git merge wiki/master
  git push -u origin wiki
  popd
  exit /b

:merge-branch-to-wiki
  pushd %repo%
  REM git branch -D wiki-master
  REM git remote rm wiki
  REM git remote add wiki %prefix%%org%/%repo%.wiki.git
  git fetch wiki
  git branch wiki-master wiki/master
  git checkout wiki-master
  git merge origin/wiki
  git push wiki wiki-master:master
  popd
  exit /b
  
:merge-wiki-to-branch
  pushd %repo%
  REM git remote rm wiki
  REM git remote add wiki %prefix%%org%/%repo%.wiki.git
  git fetch wiki
  git checkout wiki
  git merge wiki/master
  git push origin wiki:wiki
  popd
  exit /b

:clobber-wiki-with-branch
  pushd %repo%
  REM git remote rm wiki
  REM git remote add wiki %prefix%%org%/%repo%.wiki.git
  git fetch wiki
  git checkout wiki
  git push --force wiki wiki:master
  popd
  exit /b

:main
  call :create-branch
  REM call :merge-branch-to-wiki
  REM call :merge-wiki-to-branch
  goto:eof
  
:error
  echo There were errors
endlocal
