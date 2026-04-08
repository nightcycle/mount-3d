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
	local tri = Package.Face.Triangle.new(
		Package.Point.Vertex.new(Vector3.new(0, 10, 0), Vector3.yAxis),
		Package.Point.Vertex.new(Vector3.new(0, 10, 10), Vector3.yAxis),
		Package.Point.Vertex.new(Vector3.new(5, 10, 10), Vector3.yAxis),
		Vector3.yAxis
	)

	local instList = Package.Face.Any.debug(tri)

	return function()
		for i, v in instList do
			v:Destroy()
		end
	end
end
