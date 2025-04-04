close()
local startX, startY = 0, 0
local targetX, targetY = 0, 0
local startWidth, startHeight = 0, 0
local targetWidth, targetHeight = 0, 0
local offsetX, offsetY = 0, 0  -- New offset variables
local duration = 0
local elapsed = 0
local tweenActiveX = false
local tweenActiveY = false
local sizeTweenActive = false
local easeType = 'linear'

function onStepHit()
    if curStep % 2 == 0 then
        local stepMove = 1 * stepCrochet / 1000
        --runTimer('doit', stepMove)
    end
end

--function onTimerCompleted(tag)
--    if tag == 'doit' then
--        local stepMove = 2 * stepCrochet/1000
--        if not did then
--            doTweenWindowX(-200, stepMove, 'expoOut')
--            doTweenWindowY(-100, stepMove, 'expoOut')
--            did = true
--        else
--            doTweenWindowX(200, stepMove, 'sineIn')
--            doTweenWindowY(100, stepMove, 'sineIn')
--            did = false
--        end
--    end
--end

local easeFunctions = {
    linear = function(t) return t end,
    -- Ease-In versions
    sineIn = function(t) return 1 - math.cos((t * math.pi) / 2) end,
    quadIn = function(t) return t * t end,
    cubicIn = function(t) return t * t * t end,
    quartIn = function(t) return t * t * t * t end,
    quintIn = function(t) return t * t * t * t * t end,
    expoIn = function(t) return (t == 0) and 0 or (2 ^ (10 * (t - 1))) end,
    circIn = function(t) return 1 - math.sqrt(1 - t * t) end,
    backIn = function(t) 
        local c1 = 1.70158
        return t * t * ((c1 + 1) * t - c1) 
    end,
    elasticIn = function(t) 
        if t == 0 or t == 1 then return t end
        local p = 0.3
        return -(2 ^ (10 * (t - 1))) * math.sin((t - 1.075) * (2 * math.pi) / p)
    end,
    bounceIn = function(t)
        return 1 - easeFunctions.bounce(1 - t)
    end,

    -- Ease-Out versions
    sineOut = function(t) return math.sin((t * math.pi) / 2) end,
    quadOut = function(t) return -t * (t - 2) end,
    cubicOut = function(t) return (t - 1) * (t - 1) * (t - 1) + 1 end,
    quartOut = function(t) return 1 - (t - 1) * (t - 1) * (t - 1) * (t - 1) end,
    quintOut = function(t) return 1 - (t - 1) * (t - 1) * (t - 1) * (t - 1) * (t - 1) end,
    expoOut = function(t) return 1 - (2 ^ (-10 * t)) end,
    circOut = function(t) return math.sqrt(1 - (t - 1) * (t - 1)) end,
    backOut = function(t) 
        local c1 = 1.70158
        return 1 + c1 * (t - 1) * (t - 1) * ((c1 + 1) * (t - 1) + c1) 
    end,
    elasticOut = function(t) 
        if t == 0 or t == 1 then return t end
        local p = 0.3
        return (2 ^ (-10 * t)) * math.sin((t - 0.075) * (2 * math.pi) / p) + 1
    end,
    bounceOut = function(t)
        return easeFunctions.bounce(1 - t)
    end,
    sineInOut = function(t) return (1 - math.cos(math.pi * t)) / 2 end,
    quadInOut = function(t)
        if t < 0.5 then return 2 * t * t end
        return -1 + (4 - 2 * t) * t
    end,
    cubicInOut = function(t)
        if t < 0.5 then return 4 * t * t * t end
        return (t - 1) * (2 * t - 2) * (2 * t - 2) + 1
    end,
    quartInOut = function(t)
        if t < 0.5 then return 8 * t * t * t * t end
        return 1 - (2 - 2 * t) * (2 - 2 * t) * (2 - 2 * t) * (2 - 2 * t)
    end,
    quintInOut = function(t)
        if t < 0.5 then return 16 * t * t * t * t * t end
        return 1 - (2 - 2 * t) * (2 - 2 * t) * (2 - 2 * t) * (2 - 2 * t) * (2 - 2 * t)
    end,
    expoInOut = function(t) 
        if t == 0 then return 0 end
        if t == 1 then return 1 end
        if t < 0.5 then return 2 ^ (10 * (2 * t - 1)) / 2 end
        return (2 - 2 ^ (-10 * (2 * t - 1))) / 2
    end,
    circInOut = function(t)
        if t < 0.5 then return (1 - math.sqrt(1 - 4 * t * t)) / 2 end
        return (math.sqrt(1 - (2 * t - 1) * (2 * t - 1)) + 1) / 2
    end,
    backInOut = function(t) 
        local c1 = 1.70158
        if t < 0.5 then
            return 2 * t * t * ((c1 + 1) * 2 * t - c1) / 2
        end
        return 1 + 2 * (t - 1) * (t - 1) * ((c1 + 1) * (t - 1) + c1) / 2
    end,
    elasticInOut = function(t)
        if t == 0 or t == 1 then return t end
        local p = 0.45
        if t < 0.5 then
            return -(2 ^ (10 * (2 * t - 1))) * math.sin((2 * t - 1 - 0.075) * (2 * math.pi) / p) / 2
        end
        return (2 ^ (-10 * (2 * t - 1))) * math.sin((2 * t - 1 - 0.075) * (2 * math.pi) / p) / 2 + 1
    end,
    bounceInOut = function(t)
        if t < 0.5 then return easeFunctions.bounceIn(t * 2) / 2 end
        return easeFunctions.bounceOut(t * 2 - 1) / 2 + 0.5
    end
}

function doTweenWindowX(x, time, ease)
    startX = getPropertyFromClass('openfl.Lib', 'application.window.x')
    targetX = x
    duration = time
    elapsed = 0
    easeType = ease or 'linear'
    tweenActiveX = true
end

function doTweenWindowY(y, time, ease)
    startY = getPropertyFromClass('openfl.Lib', 'application.window.y')
    targetY = y
    duration = time
    elapsed = 0
    easeType = ease or 'linear'
    tweenActiveY = true
end

function doTweenWindowSize(width, height, time, ease, offsetXParam, offsetYParam)
    -- Set the new offset parameters
    offsetX = offsetXParam or 0
    offsetY = offsetYParam or 0

    -- Calculate the window's starting position
    startWidth = getPropertyFromClass('openfl.Lib', 'application.window.width')
    startHeight = getPropertyFromClass('openfl.Lib', 'application.window.height')

    targetWidth = width
    targetHeight = height

    -- Starting position centered
    startX = getPropertyFromClass('openfl.Lib', 'application.window.x')
    startY = getPropertyFromClass('openfl.Lib', 'application.window.y')

    -- Adjust the target position considering the offsets
    targetX = startX + offsetX
    targetY = startY + offsetY

    duration = time
    elapsed = 0
    easeType = ease or 'linear'
    sizeTweenActive = true
end

function onUpdate(elapsedTime)
    -- Tween window X position
    if tweenActiveX then
        elapsed = elapsed + elapsedTime
        local t = math.min(elapsed / duration, 1)

        -- Apply easing
        local easedT = easeFunctions[easeType] and easeFunctions[easeType](t) or t

        -- Lerp position for X
        local newX = startX + (targetX - startX) * easedT
        setPropertyFromClass('openfl.Lib', 'application.window.x', newX)

        if t == 1 then
            tweenActiveX = false
        end
    end

    -- Tween window Y position
    if tweenActiveY then
        elapsed = elapsed + elapsedTime
        local t = math.min(elapsed / duration, 1)

        -- Apply easing
        local easedT = easeFunctions[easeType] and easeFunctions[easeType](t) or t

        -- Lerp position for Y
        local newY = startY + (targetY - startY) * easedT
        setPropertyFromClass('openfl.Lib', 'application.window.y', newY)

        if t == 1 then
            tweenActiveY = false
        end
    end

    -- Tween window size (centered with offset)
    if sizeTweenActive then
        elapsed = elapsed + elapsedTime
        local t = math.min(elapsed / duration, 1)

        -- Apply easing
        local easedT = easeFunctions[easeType] and easeFunctions[easeType](t) or t

        -- Lerp size
        local newWidth = startWidth + (targetWidth - startWidth) * easedT
        local newHeight = startHeight + (targetHeight - startHeight) * easedT

        -- Adjust position to keep centered with the offset
        local deltaWidth = (newWidth - startWidth) / 2
        local deltaHeight = (newHeight - startHeight) / 2
        local newX = startX - deltaWidth + offsetX  -- Adjust for offset
        local newY = startY - deltaHeight + offsetY  -- Adjust for offset

        setPropertyFromClass('openfl.Lib', 'application.window.x', newX)
        setPropertyFromClass('openfl.Lib', 'application.window.y', newY)
        setPropertyFromClass('openfl.Lib', 'application.window.width', newWidth)
        setPropertyFromClass('openfl.Lib', 'application.window.height', newHeight)

        if t == 1 then
            sizeTweenActive = false
        end
    end
end