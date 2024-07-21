function onCreate()
    makeLuaSprite('bars', 'background/hallway/bars', 0,0)
    setObjectCamera('bars', 'game')
    scaleObject("bars", 1, 10)
    screenCenter("bars")
    addLuaSprite('bars', true)
    setProperty('bars.alpha',0)
end

function onUpdate()
    setScrollFactor("bars", 0, 0)
end

function onBeatHit()
    if curBeat == 96 then
        doTweenZoom('cg', 'camGame', 1.3, 13)
        cameraFlash('other','0xFFFFFF',0.5,true)
        setProperty('bars.alpha',1)
        doTweenY('ba1', 'bars.scale', 1.4, 0.1, 'quadInOut')
    elseif curBeat == 132 then        
        doTweenY('ba', 'bars.scale', 10, 0.1, 'quadInOut')
        doTweenZoom('cg', 'camGame', 0.9, 0.2)
    elseif curBeat == 134 then
        setProperty('bars.alpha',0)
    elseif curBeat == 164 then
        setProperty('bars.alpha',1)
        doTweenY('ba1', 'bars.scale', 1.4, 0.1, 'quadInOut')
    end
end

function onTweenCompleted(tag)
    if tag == 'cg' then
        setProperty('defaultCamZoom', getProperty('camGame.zoom'))
    end
end