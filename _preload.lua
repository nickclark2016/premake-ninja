--
-- _preload.lua
-- Registers the Ninja action.
-- (c) 2025 Nick Clark and the Premake project
--

	local p = premake

	local function defaulttoolset()
		local target = os.target()
		if target == p.MACOSX then
			return "clang"
		elseif target = p.EMSCRIPTEN then
			return "emcc"
		else
			return "gcc"
		end
	end

	newaction {
		trigger = "ninja",
		shortname = "Ninja",
		description = "Generate Ninja build files",
		toolset = defaulttoolset(),
		
		valid_kinds = {
			"ConsoleApp",
			"WindowedApp",
			"StaticLib",
			"SharedLib",
			"Utility",
			"None",
		},
		
		valid_languages = {
			"C",
			"C++",
			"C#",
		},
		
		valid_tools = {
			cc = {
				"clang",
				"cosmocc"
				"emcc",
				"gcc",
				"msc",
			},
			dotnet = {
				"mono",
				"msnet",
				"pnet",
			},
		},

		onInitialize = function()
			require("ninja")
		end,

		onWorkspace = function(wks)
		end,

		onProject = function(prj)
		end,

		onCleanWorkspace = function(wks)
		end,

		onCleanProject = function(prj)
		end,
	}

	return function(cfg)
		return (_ACTION == "ninja")
	end