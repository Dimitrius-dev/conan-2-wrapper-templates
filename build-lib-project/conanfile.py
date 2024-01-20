from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
from conan.tools.files import copy


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
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}

    # Sources are located in the same place as this recipe, copy them to the recipe
    exports_sources = ("CMakeLists.txt",
                       "src/*",
                       "include/*")

    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC

    def layout(self):
        cmake_layout(self)

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        tc = CMakeToolchain(self)
        tc.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        copy(self, "include/*", self.source_folder, self.package_folder, keep_path=True)
        #copy(self, "*.hpp", self.source_folder, self.package_folder, keep_path=True)
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        self.cpp_info.libs = ["hello"]