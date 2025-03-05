--
-- ninja_cpp.lua
-- Functions for writing C++ projects to Ninja build files.
-- (c) 2025 Nick Clark and the Premake project
--

	local ninja = premake.modules.ninja;
	ninja.cpp = {}

	local ncpp = ninja.cpp


	function ncpp.generate(cfg)
		ninja.header(cfg)
	end

