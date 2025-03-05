--
-- test_ninja_workspace.lua
-- Tests for the Ninja workspace writer.
-- (c) 2025 Nick Clark and the Premake project
--

	local ninja = require 'ninja'
	local suite = test.declare('ninja_workspace')

	local p = premake

	local wks, prj


--
-- Setup
--

	function suite.setup()
		wks = test.createWorkspace()
		wks.location = "."
		prj = p.workspace.getproject(wks, 1)
	end


--
-- Test project subninja outputs
--

	function suite.projectSubninjaOutputs()
		ninja.projects(wks)
		test.capture [[
# Projects
subninja MyProject_debug.ninja
subninja MyProject_release.ninja
]]
	end