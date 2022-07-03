import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("PointBody").extends(gfx.sprite)

function PointBody:init(x,y,dx,dy,mass)
    PointBody.super.init(self)
    self.x = x
    self.y = y
    self.dx = dx
    self.dy = dy
    self.mass = mass

    local r = 3
    local img = gfx.image.new(r*2, r*2)
    gfx.pushContext(img)
        gfx.fillCircleAtPoint(r,r,r)
    gfx.popContext()
    self:setImage(img)

    self:moveTo(x,y)
    self:add()
end

function PointBody:accelerate(ax, ay)
    self.dx += ax
    self.dy += ay
end

function PointBody:update()
    self:moveTo(self.x + self.dx, self.y + self.dy)
end
