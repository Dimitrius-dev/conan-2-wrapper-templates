import os.path

from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
from conan.tools.files import copy
from conan.errors import ConanInvalidConfiguration


class hello(ConanFile):
    name = "hello"
    version = "0.0.1"

    # Optional metadata
    #license = "<Put the package license here>"
    author = "Dimitrius-dev dimabelovsergeevich@gmail.com"
    url = ""#"<Package recipe repository url here, for issues about the package>"
    description = "simple hello library"
    topics = ("<Put some tag here>", "<here>", "<and here>")

    # Binary configuration
    settings = "os", "compiler", "build_type", "arch"

    options = {
        "shared": [True, False],
        "fPIC": [True, False]
    }

    default_options = {
        "shared": False,
        "fPIC": True
    }

    is_header_only_lib = False

    def export_sources(self):
        copy(self, "*", os.path.join(self.recipe_folder, "conan_lib"), self.export_sources_folder, keep_path = True)

    def requirements(self):
        self.requires("spdlog/1.12.0")
        self.test_requires("gtest/1.14.0")
        pass
        #dependencies

    def validate(self):
        pass
        # if self.settings.os == "Windows":
        #     raise ConanInvalidConfiguration("Windows is not supported")

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
        cmake.configure()
        cmake.build()
        if not self.conf.get("tools.build:skip_test"):
            self.run(os.path.join("test", "test"))

    def package(self):
            copy(self, "include/*", self.source_folder, self.package_folder, keep_path=True)
            cmake = CMake(self)
            cmake.install()
            pass

    def deploy(self):
        copy(self, "*", self.package_folder, self.deploy_folder)

    def package_info(self):
        self.cpp_info.libs = [self.name]

        print(f'is_header_only_lib:{self.is_header_only_lib}')
        if self.is_header_only_lib:
            self.info.clear() # use it for header-only library, so the library has not any binaries for specific settings