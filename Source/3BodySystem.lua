import "PointBody"


class ("ThreeBodySystem").extends()

function ThreeBodySystem:init()
    ThreeBodySystem.super.init(self)
    self.bodies = {
        PointBody(10,10,0,0,10),
        PointBody(20,10,0,0,10),
        PointBody(30,10,0,0,10)
    }
end

function ThreeBodySystem:update()
    self.bodies[1]:accelerate(0,1)
end
