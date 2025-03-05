require "ninja"

workspace "HelloNinjaWorkspace"
	configurations { "Debug", "Release" }
	platforms { "x86", "x86_64" }
	location "build"

	project "HelloNinjaProject"
		kind "ConsoleApp"
		language "C++"
		files { "src/main.cpp" }
		targetdir "bin/%{cfg.buildcfg}"

		filter "configurations:Debug"
			defines { "DEBUG" }
			symbols "On"

		filter "configurations:Release"
			defines { "NDEBUG" }
			optimize "On"