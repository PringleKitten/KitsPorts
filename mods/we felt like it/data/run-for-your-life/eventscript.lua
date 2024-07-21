local newh = 0
local str = 0.15

function onEvent(n,v1,v2)
    if n == 'Alternate Attack' then
        defaultCamZoom = getProperty('defaultCamZoom')
        if mustHitSection then
            setProperty('boyfriendCameraOffset[0]', -600)
        else
            setProperty('opponentCameraOffset[0]', 500)
        end
        canPause = false;
		doTweenZoom('game', 'camGame', 0.70, 0.5, 'quadInOut')
        doTweenX('smilerX', 'smiler', 2300, 1.35, 'expoIn')
        doTweenX('entityX', 'dad', 2300, 1.35, 'expoIn')
		SHOOT = true
        runTimer('shooting', 1.5)
    end
end
function mouseOverlaps(tag, camera)
    x = getMouseX(camera or 'camHUD')
    y = getMouseY(camera or 'camHUD')
    return (x > getProperty(tag..'.x') and y > getProperty(tag..'.y') and x < (getProperty(tag..'.x') + getProperty(tag..'.width')) and y < (getProperty(tag..'.y') + getProperty(tag..'.height')))
  end
function onUpdate()
    if mouseOverlaps('button', 'camOther') and mouseClicked("left") then
        buttonLOL = true
    else
        buttonLOL = false
    end
    setShaderFloat("filmGrain", "iTime", os.clock())
    setShaderFloat("filmGrain", "strength", 10)
    if curBeat > 31 then
    if keyJustPressed('space') or buttonLOL then
        if SHOOT then
            cancelTween('smilerX')
            cancelTween('entityX')

            doTweenX('smilerXback', 'smiler', 1500, 0.4, 'expoOut')
            doTweenX('entityXback', 'dad', 1300, 0.4, 'expoIn')
        end
        playSound('gunshotmark')
        characterPlayAnim("boyfriend", "shooting", true)
        hp = getProperty('health')
        newh = hp-str
        SHOOT = false
        setProperty('health', newh)
        str = str+0.03
        buttonLOL = false
    end
    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
        setProperty('markbody.alpha', 0)
    else
        setProperty('markbody.alpha', 1)
    end
    end
end

function onTimerCompleted(tag)
    if tag == 'shooting' and SHOOT then
        setProperty('health', 0)
        if practice then
            runHaxeCode([[
            FlxG.stage.window.alert('You cant run even with cheats BOO PRACTICE MODE USER EAT CRAP CHEATER YOU SUCK HAHAHAHAHAA (youre not safe)','YOU CANT RUN YOU CANT RUN YOU CANT RUN YOU CANT RUN ');
            ]])
            os.exit()
        end
    end
    doTweenZoom('game', 'camGame', 0.8, 0.3, 'quadInOut')
    setProperty('opponentCameraOffset[0]', 0)
    setProperty('boyfriendCameraOffset[0]', 0)
end

function onTweenCompleted(tag)
    if tag == 'game' then
        setProperty("defaultCamZoom",getProperty('camGame.zoom'))
    end
end