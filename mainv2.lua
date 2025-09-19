FrameTimePassed = 0
FrameTimeToPass = 0.25
TileSize = 80
Frame = 1
CloudsPos = 0
Fullscreen = false
Momentum = 0
TimePassed = 0
TimeToPass = 0.5
Grav = 0
PlayerX = 475
PlayerY=  435
Direction = "forwards"
State = "Ground"
CameraX = 0
CameraY = 0
Acceleration = 400

function love.load()
Char_forwards = love.graphics.newImage("gob_mid.png")
Char_left = love.graphics.newImage("gob_left.png")
Char_right = love.graphics.newImage("gob_right.png")
Bg = love.graphics.newImage("background_v2.png")
Mg = love.graphics.newImage("middleground.png")
Ground = love.graphics.newImage("ground_v2.png")
Char_airforwards = love.graphics.newImage("air_mid.png")
Char_airleft = love.graphics.newImage("air_left.png")
Char_airright = love.graphics.newImage("air_right.png")
Char_runright_frame1 = love.graphics.newImage("runframe1_right.png")
Char_runright_frame2 = love.graphics.newImage("runframe2_right.png")
Char_runleft_frame1 = love.graphics.newImage("runframe1_left.png")
Char_runleft_frame2 = love.graphics.newImage("runframe2_left.png")
Topleft = love.graphics.newImage("topleft.png")
Topright = love.graphics.newImage("topright.png")
Topmid = love.graphics.newImage("topmid.png")
end
function love.draw()
    if Fullscreen == true then
        love.graphics.scale(1.5,1.5)
    else if fullscreen == false then
        love.graphics.scale(1,1)
    end
    end
    love.graphics.setDefaultFilter("nearest", "nearest", 5)
    love.graphics.draw(Bg, CloudsPos + CameraX / 3, 0 + CameraY / 3)
    love.graphics.draw(Bg, CloudsPos + 800 + CameraX / 3, 0 + CameraY / 3)
    love.graphics.draw(Bg, CloudsPos - 800 + CameraX / 3, 0 + CameraY / 3)
    love.graphics.draw(Mg, 0 + CameraX / 2, 0 + CameraY / 2)
    love.graphics.draw(Mg, 800 + CameraX / 2, 0 + CameraY / 2)
    love.graphics.draw(Mg, -800 + CameraX / 2, 0 + CameraY / 2)


    if Direction == "forwards" then
        if State == "ground" then
            love.graphics.draw(Char_forwards,PlayerX + CameraX ,PlayerY + CameraY)
        end
        if State == "air" then
            love.graphics.draw(Char_airforwards,PlayerX + CameraX ,PlayerY + CameraY)
        end
    
    else if Direction == "left" then
        
        if State == "ground" then
             if Frame == 1 then
                love.graphics.draw(Char_runleft_frame1,PlayerX + CameraX ,PlayerY + CameraY)
            else if Frame == 2 then
                love.graphics.draw(Char_runleft_frame2,PlayerX + CameraX ,PlayerY + CameraY)
            end
        end
    end
        if State == "air" then
            love.graphics.draw(Char_airleft,PlayerX + CameraX ,PlayerY + CameraY)
        end
    
    else if Direction == "right" then
        if State == "ground" then
            if Frame == 1 then
                love.graphics.draw(Char_runright_frame1,PlayerX + CameraX ,PlayerY + CameraY)
            else if Frame == 2 then
                love.graphics.draw(Char_runright_frame2,PlayerX + CameraX ,PlayerY + CameraY)
            end
        end
            
        end
        if State == "air" then
            love.graphics.draw(Char_airright,PlayerX + CameraX ,PlayerY + CameraY)
        end
    
    end
end

end
love.graphics.draw(Topmid, 475 + CameraX, 515 + CameraY)
love.graphics.draw(Topmid, 475 - TileSize + CameraX, 515 + CameraY)
love.graphics.draw(Topmid,475 + TileSize + CameraX, 515 + CameraY)
love.graphics.draw(Topright, 475 + TileSize * 2 + CameraX, 515 + CameraY)
love.graphics.draw(Topleft, 475 - TileSize * 2 + CameraX, 515 + CameraY)
end

love.window.setTitle( "game" )


function love.keypressed(key)
    if key == "f11" then
        
        if Fullscreen == true then
            love.window.setFullscreen (false)
        end
        if Fullscreen == false then
            love.window.setFullscreen(true)
        end
        if Fullscreen == false then
            Fullscreen = true
        else
            Fullscreen = false
        end
    end
       
    if key == "space" and PlayerY >= 430 then
        Grav = -600
    end
end







function love.update(dt)

if Grav <= 0 then
    State = "air"
end

    PlayerY = PlayerY + Grav * dt
    if Grav <= 500 then
         Grav = Grav + 1500 * dt
    end
   


TimePassed = TimePassed + dt
if TimePassed >= TimeToPass then
    Direction = "forwards"
end
FrameTimeToPass = 10 / (Momentum / 4)
if FrameTimeToPass < 0 then
    FrameTimeToPass = FrameTimeToPass / -1
end

FrameTimePassed = FrameTimePassed + dt
if  FrameTimePassed >= FrameTimeToPass then
    if Frame == 1 then
        Frame = 2
        FrameTimePassed = 0
    else if Frame == 2 then
        Frame = 1
        FrameTimePassed = 0
    end
    end
end

if love.keyboard.isDown("a") then
    TimePassed = 0
    Direction = "left"
    Momentum = Momentum - Acceleration * dt
end

if love.keyboard.isDown("d") then
    TimePassed = 0
    Direction = "right"
    Momentum = Momentum + Acceleration * dt
end

PlayerX = PlayerX + Momentum * dt

if Momentum < 0 and not love.keyboard.isDown("a") then
    Momentum = Momentum + 800 * dt
else if Momentum > 0 and not love.keyboard.isDown("d")then
    Momentum = Momentum - 800 * dt
end

if love.keyboard.isDown("a") and love.keyboard.isDown("d") then
    Direction = "forwards"
    if Momentum > 0 then
        Momentum = Momentum - 800 * dt
    end
math.floor(Momentum)
    if Momentum < 0 then
        Momentum = Momentum + 800 * dt
    end
    

end

CloudsPos = CloudsPos + 10 * dt

if CloudsPos >= 800 then
    CloudsPos = 0
end


if Momentum >= Acceleration then
    Momentum = Acceleration
end
if Momentum <= -Acceleration then
    Momentum = -Acceleration
end
end

if Fullscreen == false then
    CameraX = -PlayerX + 350
    CameraY = -PlayerY / 1.5 + 200
end

if Fullscreen == true then
    CameraX = -PlayerX + 575
    CameraY = -PlayerY / 1.5 + 300
end


if PlayerY >= 435 then
    State = "ground"
    Grav = 0
    PlayerY = 435
end

end
