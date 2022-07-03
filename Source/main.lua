import "3BodySystem"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = pd.graphics

local system = ThreeBodySystem()

function pd.update()
    system:update()
    gfx.sprite.update()
end