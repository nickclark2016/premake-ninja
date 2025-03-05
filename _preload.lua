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
		elseif target == p.EMSCRIPTEN then
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
				"cosmocc",
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
			verbosef("Ninja initialized")
		end,

		onWorkspace = function(wks)
			p.escaper(p.modules.ninja.esc)
			
			wks.projects = table.filter(wks.projects, function(prj)
				return p.action.supports(prj.kind) and prj.kind ~= p.NONE
			end)

			local filename = p.modules.ninja.getninjafilename(wks, false)
			p.generate(wks, filename, p.modules.ninja.generateworkspace)
		end,

		onProject = function(prj)
			if not p.action.supports(prj.kind) or prj.kind == p.NONE then
				return
			end

			if p.project.isc(prj) or p.project.iscpp(prj) then
				for cfg in p.project.eachconfig(prj) do
					local filename = p.modules.ninja.getninjafilename(cfg, true)
					p.generate(cfg, filename, p.modules.ninja.cpp.generate)
				end
			end
		end,

		onCleanWorkspace = function(wks)
		end,

		onCleanProject = function(prj)
		end,
	}