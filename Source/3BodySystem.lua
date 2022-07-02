import "PointBody"


class ("ThreeBodySystem").extends()

function ThreeBodySystem:init()
    bodies = {
        body1 = PointBody(10,10,0,0,10),
        body2 = PointBody(20,10,0,0,10),
        body3 = PointBody(30,10,0,0,10)
    }
end

function ThreeBodySystem:update()
    self.body1:accelerate(0,10)
end
