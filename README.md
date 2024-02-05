# Conan template
___
#### Project guide show the use package manager Conan 2.0 for c/c++ projects.
___
Official guide: https://docs.conan.io/2/
  
Other languages:
+ [eng](./README.md)
+ [rus](./doc/README_RUS.md)
___
### Desription
This project-guide is designed to integrate ```conan 2.0 package manager with special ready-made project templates``` to C++ development.  
Conan 2.0 package manager is similar to Maven. Maven is a package manager for classic Java projects

## Install required tools
Install ```pip``` for further dependencies

### Install conan
```
pip install conan
```
### Install custom develop team settings set by using command
```
conan config install [custom_conan_settings_zip_url]
```
Example: ```conan config install http://127.0.0.1:8000/conan_settings.zip```

The custom_conan_settings_url is a link to zip archive. The archive consist of few files:
+ ```remotes.json``` - list of remotes conan repositories 
+ ```settings_user.yml``` - additional custom settings file to the main settings.yml. Used to validate profile values


In conan all data is contained in repositories. Every repository has massive of packages.
Every package is a library.
There are two types of repository:
+ Local (client - local cache)
+ Remote (official - conancenter or custom (custom_server https://docs.conan.io/2/reference/config_files/remotes.html) )

Local repository is used on local computer.  
Remote repository os used on server with dedicated ip.

Repository's data hierarchy
```
+--+-lib example 0.0.1 (library version)
|  |
|  +--+-revision #1 (library revision)
|  |  |
|  |  +--package #1 (library bild)
|  |  +--package #2 (library bild)
|  |
|  +--+-revision #2 . . .
|     | . . .
|
+--+-lib example 0.0.2 (library version)
   | . . .
```
Firstly in order to use conan, create ```profile```. Profile has set of settings of your system.
This is mandatory requirement to use lib compiling with conan.  
User edits profile. So profile data is not verified by any automatic system.

Create profile
```
conan profile detect --force
```
Show path to profile with name ```default```
```
conan profile path default
```
Templates:
+ [Create library](./build-lib-project/README.md)
+ [Use library](build-executable-project/doc/README.md)
+ [Custom library server](conan-server/doc/README.md)
