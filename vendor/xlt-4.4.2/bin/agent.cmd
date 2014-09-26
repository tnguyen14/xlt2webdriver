@echo off
setlocal enabledelayedexpansion

:: setup basic paths
set AGENT_HOME=%CD%
set AGENT_CONFIG_DIR=%AGENT_HOME%\config
cd /d %~dp0\..
set XLT_HOME=%CD%
cd /d %AGENT_HOME%

:: setup Java class path
set CLASSPATH=%AGENT_HOME%\patches\classes;%AGENT_HOME%\patches\lib\*;%XLT_HOME%\target\classes;%XLT_HOME%\lib\*;%AGENT_HOME%\classes;%AGENT_HOME%\lib\*

:: setup other Java options
set JAVA_OPTIONS=
rem set JAVA_OPTIONS=%JAVA_OPTIONS% -Djava.endorsed.dirs="%XLT_HOME%"
set JAVA_OPTIONS=%JAVA_OPTIONS% -Dcom.xceptance.xlt.home="%XLT_HOME%"
set JAVA_OPTIONS=%JAVA_OPTIONS% -Dcom.xceptance.xlt.agent.home="%AGENT_HOME%"
set JAVA_OPTIONS=%JAVA_OPTIONS% -Dlog4j.configuration="file:%AGENT_CONFIG_DIR%\log4j.properties"
set JAVA_OPTIONS=%JAVA_OPTIONS% -Dorg.apache.xml.dtm.DTMManager=org.apache.xml.dtm.ref.DTMManagerDefault
rem set JAVA_OPTIONS=%JAVA_OPTIONS% -agentlib:jdwp=transport=dt_socket,address=localhost:6666,server=y,suspend=n
set JAVA_OPTIONS=%JAVA_OPTIONS% -cp "%CLASSPATH%"

:: append custom Java options
set JVM_CFG_FILE=%AGENT_CONFIG_DIR%\jvmargs.cfg

if exist "%JVM_CFG_FILE%" (
    for /f "eol=# delims=" %%o in ('type "%JVM_CFG_FILE%"') do set JAVA_OPTIONS=!JAVA_OPTIONS! %%o
)

:: run Java
echo java %JAVA_OPTIONS% com.xceptance.xlt.agent.Main %* > results\agentCmdLine
java %JAVA_OPTIONS% com.xceptance.xlt.agent.Main %*
