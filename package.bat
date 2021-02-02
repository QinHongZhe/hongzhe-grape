REM windows package

REM package
REM mvn clean install -Dmaven.test.skip=true

REM del dist
rmdir dist /s /q

REM create dist
mkdir dist
mkdir dist\plugins
mkdir dist\pluginConfig

REM copy main program and config
xcopy grape-core\grape-server\target\grape-server-*-exec.jar dist /s /i
xcopy grape-core\grape-server\src\main\resources\application-prod.yml dist /s
xcopy grape-core\grape-server\src\main\resources\log\logging-config.xml dist /s

REM copy plugin and config
xcopy grape-plugins\grape-plugin-system-tools\target\*-jar-with-dependencies.jar dist\plugins /s
xcopy grape-plugins\grape-plugin-system-tools\src\main\resources\*-prod.yml dist\pluginConfig /s

# copy bin
xcopy bin\* dist\ /s

cd dist

REM run main
rename grape-server-*-exec.jar grape-server.jar
rename application-prod.yml application.yml
