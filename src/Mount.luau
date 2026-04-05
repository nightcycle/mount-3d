--!strict
-- Services
-- Packages
-- Modules
local Line = require(script.Parent.Line)
local Point = require(script.Parent.Point)
local Util = require(script.Parent.Util)
-- Types
export type Line = Line.Line
export type Point = Point.Point
export type VertexPoint = Point.VertexPoint
export type DecorationConstructor = (origin: CFrame, scale: number, rotation: number, wobble: number) -> FillResult
export type FillInfo =
	{
		Type: "Surface",
		Thickness: number?,
	}
	| {
		Type: "Splatter",
		Count: number,
		Scale: NumberRange?,
		Rotation: NumberRange?,
		Wobble: NumberRange?,
		Constructor: DecorationConstructor,
	}
	| {
		Type: "Grid",
		Count: number,
		Scale: NumberRange?,
		Rotation: NumberRange?,
		Wobble: NumberRange?,
		Translation: NumberRange?,
		Constructor: DecorationConstructor,
	}
export type FillResult = {
	Instances: { Instance },
	Parts: { [BasePart]: CFrame },
}
-- Constants
local CONSTANTS = require(script.Parent.CONSTANTS)
-- Variables
-- References
-- Private Functions
-- Class
local Mount = {}

type TriangleMount = {
	Type: "Triangle",
	A: VertexPoint,
	B: VertexPoint,
	C: VertexPoint,
	Normal: Vector3,
	Up: Vector3,
}

Mount.Triangle = {}

function Mount.Triangle.new(a: VertexPoint, b: VertexPoint, c: VertexPoint, normal: Vector3, up: Vector3): TriangleMount
	local mount = {
		Type = "Triangle" :: "Triangle",
		A = a,
		B = b,
		C = c,
		Normal = normal,
		Up = up,
	}
	table.freeze(mount)
	return mount
end

function Mount.Triangle.fill(mount: TriangleMount, fill: FillInfo, rng: Random?): FillResult
	if fill.Type == "Surface" then
		local a, aCF, b, bCF = Util.fillTriangle(
			mount.A.Position,
			mount.B.Position,
			mount.C.Position,
			mount.Normal,
			fill.Thickness or CONSTANTS.MIN_THICKNESS
		)
		return {
			Instances = { a, b },
			Parts = {
				[a] = aCF,
				[b] = bCF,
			},
		}
	-- elseif fill.Type == "Splatter" then
	else
		error(`unsupported type: "{fill.Type}"`)
	end
end

function Mount.Triangle.getEdges(mount: TriangleMount): { Line }
	return {
		Line.Straight.new(mount.A, mount.B),
		Line.Straight.new(mount.B, mount.C),
		Line.Straight.new(mount.C, mount.A),
	}
end

export type Mount = TriangleMount

Mount.Any = {}

function Mount.Any.fill(mount: Mount, fill: FillInfo, rng: Random?): FillResult
	local subModule = Mount[mount.Type] :: any
	assert(subModule.fill, `missing fill for type "{mount.Type}"`)
	return subModule.fill(mount, fill, rng)
end

return Mount
