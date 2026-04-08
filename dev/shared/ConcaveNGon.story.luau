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
	local points = {}
	for i = 1, 8 do
		local angle = math.rad((i - 1) * 360 / 8)
		points[i] = Package.Point.Vertex.new(Vector3.new(math.sin(angle) * 5, 10+i*0.5, math.cos(angle) * 5), Vector3.yAxis)
	end
	local face = Package.Face.ConcaveNGon.new(points)

	local instList = Package.Face.Any.debug(face)

	return function()
		for i, v in instList do
			v:Destroy()
		end
	end
end
