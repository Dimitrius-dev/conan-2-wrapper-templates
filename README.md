# Conan template
___
#### Project guide show the use packet manager Conan 2.0 for c/c++ projects.
___
Official guide: https://docs.conan.io/2/
  
Other languages:
+ [rus](./doc/README_RUS.md)
___
### Desription
Conan 2.0 packet manager is similar to Maven. Maven is a packet manager for classic Java projects

### Install conan
```
pip install conan
```

In conan all data is contained in repositories. Every repository has massive of packets.
Every packet is a library.
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
|  |  +--packet #1 (library bild)
|  |  +--packet #2 (library bild)
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
