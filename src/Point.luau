--!strict
-- Services
-- Packages
-- Modules
-- Types
-- Constants
-- Variables
-- References
-- Private Functions
-- Class
local Point = {}
export type BasicPoint = {
	Type: "Basic",
	Position: Vector3,
}
Point.Basic = {}
function Point.Basic.new(position: Vector3): BasicPoint
	local out = {
		Type = "Basic" :: "Basic",
		Position = position,
	}
	table.freeze(out)
	return out
end

export type VertexPoint = {
	Type: "Vertex",
	Position: Vector3,
	Normal: Vector3,
}
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

export type RotatedPoint = {
	Type: "Rotated",
	Position: Vector3,
	Up: Vector3,
	Normal: Vector3,
}
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

export type Point = VertexPoint | RotatedPoint | BasicPoint
Point.Any = {}

return Point
