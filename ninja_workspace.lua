--
-- ninja_workspace.lua
-- Functions for writing workspaces to Ninja build files.
-- (c) 2025 Nick Clark and the Premake project
--

	local p = premake
	local ninja = p.modules.ninja


--
-- Generate a Ninja workspace file.
--
-- @param wks
--    The workspace object representing the current workspace.
--

	function ninja.generateworkspace(wks)
		p.eol("\n")

		ninja.header(wks)

		-- Build configuration mappings
		-- Write projects
		-- Write phonies
		-- Write project rules
		-- Write clean rules
		-- Write help rule
	end