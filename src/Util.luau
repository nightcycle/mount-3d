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
local Util = {}

function Util.getInstance(className: string): Instance
	return Instance.new(className)
end

function Util.fillTriangle(
	a: Vector3,
	b: Vector3,
	c: Vector3,
	normal: Vector3,
	thickness: number
): (WedgePart, CFrame, WedgePart, CFrame)
	local w1 = Util.getInstance("WedgePart") :: WedgePart
	local w2 = Util.getInstance("WedgePart") :: WedgePart

	-- Render the 3D triangle
	local ab, ac, bc = b - a, c - a, c - b
	local abd, acd, bcd = ab:Dot(ab), ac:Dot(ac), bc:Dot(bc)

	if abd > acd and abd > bcd then
		c, a = a, c
	elseif acd > bcd and acd > abd then
		a, b = b, a
	end

	ab, ac, bc = b - a, c - a, c - b

	local right = ac:Cross(ab).Unit
	local up = bc:Cross(right).Unit
	local back = bc.Unit

	local height = math.abs(ab:Dot(up))

	w1.Size = Vector3.new(thickness, height, math.abs(ab:Dot(back)))
	w2.Size = Vector3.new(thickness, height, math.abs(ac:Dot(back)))

	return w1,
		CFrame.fromMatrix((a + b) / 2, right, up, back) + normal * (-thickness / 2),
		w2,
		CFrame.fromMatrix((a + c) / 2, -right, up, -back) + normal * (-thickness / 2)
end

return Util
