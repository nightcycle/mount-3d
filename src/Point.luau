--!strict
-- Services
-- Packages
-- Modules
local Util = require(script.Parent.Util)
-- Types
-- Constants
local CONSTANTS = require(script.Parent.CONSTANTS)
-- Variables
-- References
-- Private Functions
-- Class
local Point = {}
export type BasicPoint = {
	Type: "Basic",
	Position: Vector3,
}
do
	Point.Basic = {}

	function Point.Basic.new(position: Vector3): BasicPoint
		local out = {
			Type = "Basic" :: "Basic",
			Position = position,
		}
		table.freeze(out)
		return out
	end

	function Point.Basic.eq(a: BasicPoint, b: BasicPoint): boolean
		if a.Type ~= b.Type then
			return false
		end
		return Util.positionEq(a.Position, b.Position)
	end
end

export type VertexPoint = {
	Type: "Vertex",
	Position: Vector3,
	Normal: Vector3,
}
do
	Point.Vertex = {}

	function Point.Vertex.new(position: Vector3, normal: Vector3): VertexPoint
		local out = {
			Type = "Vertex" :: "Vertex",
			Position = position,
			Normal = normal,
		}
		table.freeze(out)
		return out
	end

	function Point.Vertex.eq(a: VertexPoint, b: VertexPoint): boolean
		if a.Type ~= b.Type then
			return false
		end
		return Util.positionEq(a.Position, b.Position) and a.Normal:FuzzyEq(b.Normal, CONSTANTS.FUZZY_EQ.EPSILON)
	end
end

export type RotatedPoint = {
	Type: "Rotated",
	Position: Vector3,
	Up: Vector3,
	Normal: Vector3,
}
do
	Point.Rotated = {}

	function Point.Rotated.new(position: Vector3, normal: Vector3, up: Vector3): RotatedPoint
		local out = {
			Type = "Rotated" :: "Rotated",
			Position = position,
			Normal = normal,
			Up = up,
		}
		table.freeze(out)
		return out
	end

	function Point.Rotated.eq(a: RotatedPoint, b: RotatedPoint): boolean
		if a.Type ~= b.Type then
			return false
		end
		return Util.positionEq(a.Position, b.Position)
			and a.Normal:FuzzyEq(b.Normal, CONSTANTS.FUZZY_EQ.EPSILON)
			and a.Up:FuzzyEq(b.Up, CONSTANTS.FUZZY_EQ.EPSILON)
	end
end

export type Point = VertexPoint | RotatedPoint | BasicPoint
do
	Point.Any = {}

	function Point.Any.eq(a: Point, b: Point): boolean
		local subModule = Point[a.Type] :: any
		assert(subModule.eq, `missing eq for type "{a.Type}"`)
		return subModule.eq(a, b)
	end
end

return Point
