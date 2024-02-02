import os.path

from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
from conan.tools.files import copy
from conan.errors import ConanInvalidConfiguration


class helloLib(ConanFile):
    name = "hello"
    version = "0.0.1"

    # Optional metadata
    #license = "<Put the package license here>"
    author = "Dimitrius-dev dimabelovsergeevich@gmail.com"
    url = "<Package recipe repository url here, for issues about the package>"
    description = "simple hello library"
    topics = ("<Put some tag here>", "<here>", "<and here>")

    # Binary configuration
    settings = "os", "compiler", "build_type", "arch"

    options = {
        "shared": [True, False],
        "fPIC": [True, False],
        "debug_lib_flags": ["", "ANY"],
        "release_lib_flags": ["", "ANY"]
    }

    default_options = {
        "shared": False,
        "fPIC": True,
        "debug_lib_flags": "",
        "release_lib_flags": "ANY"
    }

    def export_sources(self):
        copy(self, "*", os.path.join(self.recipe_folder, "lib"), self.export_sources_folder, keep_path = True)

    def requirements(self):
        self.requires("spdlog/1.12.0")
        pass
        #dependencies
        #self.test_requires("gtest/1.11.0")

    def validate(self):
        if self.settings.os == "Windows":
            raise ConanInvalidConfiguration("Windows is not supported")

    def config_options(self):
        pass
        #if self.settings.os == "Windows":
        #    del self.options.fPIC

    # def layout(self):
    #     pass
    #     #cmake_layout(self)

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        tc = CMakeToolchain(self)
        tc.generate()

    def build(self):
        cmake = CMake(self)

        cmake_variables = {
            "CMAKE_CXX_FLAGS": ""
        }

        #print(f"current build type - {self.settings.build_type}")
        if self.settings.build_type == "Release": cmake_variables["CMAKE_CXX_FLAGS"] = self.options.release_lib_flags
        if self.settings.build_type == "Debug": cmake_variables["CMAKE_CXX_FLAGS"] = self.options.debug_lib_flags

        cmake.configure()
        cmake.build()

    def package(self):
        copy(self, "include/*", self.source_folder, self.package_folder, keep_path=True)
        cmake = CMake(self)
        cmake.install()

    # def imports(self):
    #     self.copy("*.dll", "", "bin")
    #     self.copy("*.dylib", "", "lib")

    def package_info(self):
        self.cpp_info.libs = [self.name]

    # use it for header-only library, so the library has not any binaries for specific settings
    # def package_id(self):
    #     self.info.clear()