@echo off
setlocal enabledelayedexpansion

:: go to app-server root directory
cd %~dp0..

:: create the log directory
mkdir logs

:: setup Java options
set JAVA_OPTIONS=%JAVA_OPTIONS% -Xmx512m

:: run Java
java -jar start.jar %JAVA_OPTIONS%
