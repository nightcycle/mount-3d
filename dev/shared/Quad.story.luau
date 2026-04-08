--!strict
-- Services
-- Packages
local Package = require(game.ReplicatedStorage.Packages.package)
-- Modules
-- Types
-- Constants
-- Variables
-- References
-- Private Functions
-- Class
return function()
	local face = Package.Face.Quad.new(
		Package.Point.Vertex.new(Vector3.new(3, 10, -4), Vector3.yAxis),
		Package.Point.Basic.new(Vector3.new(0, 8, -4)),
		Package.Point.Vertex.new(Vector3.new(-2, 12, 2), Vector3.yAxis),
		Package.Point.Basic.new(Vector3.new(3, 10, 0))
	)

	local instList = Package.Face.Any.debug(face)

	return function()
		for i, v in instList do
			v:Destroy()
		end
	end
end
