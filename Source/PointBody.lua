import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = pd.graphics

class("PointBody").extends(Sprite)

function PointBody:init(x,y,dx,dy,mass)
    PointBody.super.init()
    self.x = x
    self.y = y
    self.dx = dx
    self.dy = dy
    self.mass = mass
    self:moveTo(x,y)
    self:add()

end

function PointBody:update()
    self:moveTo(x+dx,y+dy)
end

function PointBody:accelerate(ax, ay)
    self.dx += ax
    self.dy += ay
end