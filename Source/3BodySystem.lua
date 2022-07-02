import "PointBody"

local pd = playdate
local gfx = pd.graphics

class ("ThreeBodySystem").extends()

function ThreeBodySystem:init()
    ThreeBodySystem.super.init(self)
    self.bodies = {
        PointBody(10,10,0,0,10),
        PointBody(20,35,0,0,10),
        PointBody(90,10,0,0,10)
    }

    --normalize and center view to center of mass.
    self:normalize()
    gfx.setDrawOffset(pd.display.getWidth()/2,pd.display.getHeight()/2)



end

-- move all bodies so that center of mass is at origin.  this should be able to stay the same throughout the simulation.
function ThreeBodySystem:normalize()
    --this seems unnecessary but hopefully I'll find a better way?
    local x1,y1,m1 =    self.bodies[1].x,
                        self.bodies[1].y,
                        self.bodies[1].mass
    local x2,y2,m2 =    self.bodies[2].x,
                        self.bodies[2].y,
                        self.bodies[2].mass
    local x3,y3,m3 =    self.bodies[3].x,
                        self.bodies[3].y,
                        self.bodies[3].mass
    
    
    center_x = (m1*x1 + m2*x2 + m3*x3) / (m1+m2+m3)
    center_y = (m1*y1 + m2*y2 + m3*y3) / (m1+m2+m3)

    for i, body in pairs(self.bodies) do
        body:moveTo(body.x-center_x, body.y-center_y)
    end

end


function ThreeBodySystem:update()
    self.bodies[1]:accelerate(0,1)
    self.bodies[2]:accelerate(0,2)
    self.bodies[3]:accelerate(0,3)
end
