--!strict
-- Services
-- Packages
-- Modules
local Point = require(script.Parent.Point)
local Util = require(script.Parent.Util)
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
do
	Line.Straight = {}

	function Line.Straight.new(p1: VertexPoint, p2: VertexPoint): StraightLine
		local out = {
			Type = "Straight" :: "Straight",
			P1 = p1,
			P2 = p2,
			Offset = p2.Position - p1.Position,
		} :: StraightLine
		table.freeze(out)
		return out
	end

	function Line.Straight.eq(a: StraightLine, b: StraightLine): boolean
		if a.Type ~= b.Type then
			return false
		end
		if Point.Vertex.eq(a.P1, b.P1) then
			return Point.Vertex.eq(a.P2, b.P2)
		elseif Point.Vertex.eq(a.P1, b.P2) then
			return Point.Vertex.eq(a.P2, b.P1)
		end
		return false
	end

	function Line.Straight.magnitude(line: StraightLine): number
		return line.Offset.Magnitude
	end
end

export type QuadraticBezierLine = {
	Type: "QuadraticBezier",
	P1: VertexPoint,
	P2: VertexPoint,
	Intersection: BasicPoint,
}
do
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

	function Line.QuadraticBezier.eq(a: QuadraticBezierLine, b: QuadraticBezierLine): boolean
		if a.Type ~= b.Type then
			return false
		end
		if not Point.Basic.eq(a.Intersection, b.Intersection) then
			return false
		end
		if Point.Vertex.eq(a.P1, b.P1) then
			return Point.Vertex.eq(a.P2, b.P2)
		elseif Point.Vertex.eq(a.P1, b.P2) then
			return Point.Vertex.eq(a.P2, b.P1)
		end
		return false
	end

	function Line.QuadraticBezier.magnitude(line: QuadraticBezierLine): number
		return Util.getBezierLength(line.P1.Position, line.Intersection.Position, line.P2.Position, 1)
	end
end

export type Line = StraightLine | QuadraticBezierLine
do
	Line.Any = {}

	function Line.Any.eq(a: Line, b: Line): boolean
		local subModule = Line[a.Type] :: any
		assert(subModule.eq, `missing eq for type "{a.Type}"`)
		return subModule.eq(a, b)
	end

	function Line.Any.magnitude(line: Line): boolean
		local subModule = Line[line.Type] :: any
		assert(subModule.magnitude, `missing magnitude for type "{line.Type}"`)
		return subModule.magnitude(line)
	end
end

return Line
