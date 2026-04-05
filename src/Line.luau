--!strict
-- Services
-- Packages
-- Modules
local Point = require(script.Parent.Point)
-- Types
export type Point = Point.Point
export type VertexPoint = Point.VertexPoint
export type RotatedPoint = Point.RotatedPoint
export type BasicPoint = Point.BasicPoint
-- Constants
-- Variables
-- References
-- Private Functions
-- Class
local Line = {}

export type StraightLine = {
	Type: "Straight",
	P1: VertexPoint,
	P2: VertexPoint,
	Offset: Vector3,
}
Line.Straight = {}

function Line.Straight.new(p1: VertexPoint, p2: VertexPoint): Line
	local out = {
		Type = "Straight" :: "Straight",
		P1 = p1,
		P2 = p2,
		Offset = p2.Position - p1.Position,
	} :: StraightLine
	table.freeze(out)
	return out
end

export type QuadraticBezierLine = {
	Type: "QuadraticBezier",
	P1: VertexPoint,
	P2: VertexPoint,
	Intersection: BasicPoint,
}

Line.QuadraticBezier = {}
function Line.QuadraticBezier.new(p1: VertexPoint, p2: VertexPoint, intersection: BasicPoint): QuadraticBezierLine
	local out = {
		Type = "QuadraticBezier" :: "QuadraticBezier",
		P1 = p1,
		P2 = p2,
		Intersection = intersection,
	} :: QuadraticBezierLine
	table.freeze(out)
	return out
end

export type Line = StraightLine | QuadraticBezierLine
Line.Any = {}

return Line
