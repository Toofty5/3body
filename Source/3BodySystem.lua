import "PointBody"

local pd = playdate
local gfx = pd.graphics

class ("ThreeBodySystem").extends()

function ThreeBodySystem:init(n)
    ThreeBodySystem.super.init(self)
    self.bodies = {}
    --generate three random bodies
    for i = 1, n or 3 do
        local x = math.random(400)
        local y = math.random(240)
        table.insert(self.bodies, PointBody(x,y,0,0,100))
    end

    --normalize and center view to center of mass.
    self:normalize()
    gfx.setDrawOffset(pd.display.getWidth()/2,pd.display.getHeight()/2)
end



-- move all bodies so that center of mass is at origin.  this should be able to stay the same throughout the simulation.
function ThreeBodySystem:normalize()
    local sum_x, sum_y, sum_mass = 0,0,0

    for i,body in pairs(self.bodies) do
        sum_x += body.x * body.mass
        sum_y += body.y * body.mass
        sum_mass += body.mass
    end

    local center_x = sum_x / sum_mass
    local center_y = sum_y / sum_mass

    for i, body in pairs(self.bodies) do
        body:moveBy(-center_x, -center_y)
    end
end

--get the new x and y for each body, and then move simultaneously
function ThreeBodySystem:simulate()
    self:normalize()

    -- local r1 = self.one_body(self.bodies[1], {self.bodies[2], self.bodies[3]})
    -- local r2 = self.one_body(self.bodies[2], {self.bodies[1], self.bodies[3]})
    -- local r3 = self.one_body(self.bodies[3], {self.bodies[1], self.bodies[2]})

    -- self.bodies[1]:accelerate(r1.x,r1.y)
    -- self.bodies[2]:accelerate(r2.x,r2.y)
    -- self.bodies[3]:accelerate(r3.x,r3.y)

    for i, this_body in ipairs(self.bodies) do
        local others = {table.unpack(self.bodies,1,i-1), table.unpack(self.bodies,i+1)}
        local r1 = self.one_body(this_body, others)
        print(i, r1.x, r1.y)
        this_body:accelerate(r1.x, r1.y)
    end


end

-- calculates distance from origin
local function norm(x,y)
    return math.sqrt(x^2 + y^2)
end

--calculate new position for a single body given an array of others
function ThreeBodySystem.one_body(this_body,other_bodies)
    local GRAV <const> = 1 -- gravitational coefficient
    local x_total, y_total = 0,0

    for i,body in pairs(other_bodies) do
       local x1, y1, m1 = this_body.x, this_body.y, this_body.mass
       local x2, y2, m2 = body.x, body.y, body.mass
       local new_x = x1 ~= x2 and (GRAV * m2) * (x1 - x2) / norm(x1-x2, y1-y2)^3 or 0
       local new_y = y1 ~= y2 and (GRAV * m2) * (y1 - y2) / norm(x1-x2, y1-y2)^3 or 0
       x_total -= new_x
       y_total -= new_y

    end
    x_total = cap_accel(x_total)
    y_total = cap_accel(y_total)

    print(x_total, y_total)
    return { x=x_total, y=y_total }
end

function cap_accel(x)
    local MAX_ACCEL = 0.25 
    return math.max(math.min(MAX_ACCEL,x),-MAX_ACCEL)
end


function ThreeBodySystem:update()
    self:simulate()
end


    
