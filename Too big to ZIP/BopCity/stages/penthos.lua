local thickness = 80
local directory = 'bg/penthos/'
local allowedRotation = false
local desiredAngle = 0
local timer = 0
local video
local penthosDance
local heStares

function onCreate()
    setProperty('skipCountdown', true)
    setProperty('camGame.alpha', 0)
    -- Background Elements
    makeLuaSprite('red', directory .. 'red', -900, -1550)
    scaleObject('red', 0.7, 0.7)
    addLuaSprite('red', false)

    makeLuaSprite('goodIntro', directory .. 'bop', 0, 0)
    scaleObject('goodIntro', 0.7, 0.7)
    addLuaSprite('goodIntro', true)

    makeLuaSprite('badIntro', directory .. 'evil', 0, 0)
    scaleObject('badIntro', 0.7, 0.7)
    addLuaSprite('badIntro', true)

    setObjectCamera('goodIntro', 'other')
    setObjectCamera('badIntro', 'other')
    setProperty('badIntro.alpha', 0)
    setProperty('goodIntro.alpha', 0)
    screenCenter('goodIntro', 'xy')
    screenCenter('badIntro', 'xy')

    makeLuaSprite('stage', directory .. 'stage', -600, -50)
    scaleObject('stage', 0.7, 0.7)
    addLuaSprite('stage', false)

    makeLuaSprite('chair', directory .. 'chair', -50, -50)
    scaleObject('chair', 0.7, 0.7)
    addLuaSprite('chair', false)
    doTweenY('chairTween', 'chair', -75, 1.67, 'sineInOut')

    makeLuaSprite('table', directory .. 'table', 1500, -50)
    scaleObject('table', 0.7, 0.7)
    addLuaSprite('table', false)
    doTweenY('tableTween', 'table', -75, 2.5, 'sineInOut')

    makeLuaSprite('mask', directory .. 'mask', 2000, 250)
    scaleObject('mask', 0.7, 0.7)
    
    addLuaSprite('mask', false)
    doTweenY('maskTween', 'mask', 300, 4, 'sineInOut')

    -- Animated Particles
    addParticles('particles1', 'fireparticles', -300, 50, 3, 3, 20, 0.6)
    addParticles('particles2', 'fireparticles', 1000, -50, 3.5, 3.5, 24, 0.4)
    addParticles('particles3', 'fireparticles', -100, -350, 3.5, 3.5, 22, 0.2, true)
    addParticles('particles4', 'fireparticles', 800, 550, 4, 4, 20, 0.4)
    addParticles('particles5', 'fireparticles', -400, 650, 4, 4, 20, 0.7)
    addParticles('particles6', 'fireparticles', -900, 530, 4, 4, 21, 0.7)

    -- Static Filter
    makeAnimatedLuaSprite('staticFilter', directory .. 'statid', -800, -750)
    addAnimationByPrefix('staticFilter', 'idle', 'idle', 22, true)
    scaleObject('staticFilter', 3.5, 3)
    setProperty('staticFilter.alpha', 0.07)
    addLuaSprite('staticFilter', true)

    -- He Stares Animation
    makeAnimatedLuaSprite('heStares', directory .. 'penhead', 900, 800)
    addAnimationByPrefix('heStares', 'L', 'look1', 24, false)
    addAnimationByPrefix('heStares', 'R', 'look2', 24, false)
    setProperty('heStares.alpha', 0)
    playAnim('heStares', 'L', true)
    addLuaSprite('heStares', false)

    -- Cinematic Bars
    makeLuaSprite('b_up', '', 0, 0)
    makeGraphic('b_up', screenWidth, thickness, '000000')
    setObjectCamera('b_up', 'hud')
    addLuaSprite('b_up', true)

    makeLuaSprite('b_down', '', 0, screenHeight - thickness)
    makeGraphic('b_down', screenWidth, thickness, '000000')
    setObjectCamera('b_down', 'hud')
    addLuaSprite('b_down', true)
end

function addParticles(name, sprite, x, y, scaleX, scaleY, frameRate, alpha, flipX)
    makeAnimatedLuaSprite(name, directory .. sprite, x, y)
    addAnimationByPrefix(name, 'burn', 'burn', frameRate, true)
    scaleObject(name, scaleX, scaleY)
    setProperty(name .. '.alpha', alpha)
    if flipX then
        setProperty(name .. '.flipX', true)
    end
    addLuaSprite(name, false)
end

function onCreatePost()
    -- Dance Animation
    makeAnimatedLuaSprite('penthosDance', directory .. 'IShowIndie', getProperty('dad.x'), getProperty('dad.y') - 50)
    addAnimationByPrefix('penthosDance', 'bounce', 'bounce', 54, true)
    setProperty('penthosDance.alpha', 0)
    scaleObject('penthosDance', 3, 3)
    addLuaSprite('penthosDance', false)

    setProperty('camHUD.alpha', 0)
end

function onUpdatePost(elapsed)
    timer = timer + elapsed
    setShaderFloat('staticFilter', 'iTime', timer)

    if allowedRotation then
        local targetAngle = (curSection > 0) and desiredAngle or 0
        setProperty('camGame.angle', lerp(getProperty('camGame.angle'), targetAngle, elapsed * 2.4))
    end
end

function onSongStart()
    doTweenAlpha('fadeInGoodIntro', 'goodIntro', 1, 2, 'linear')
end

function onBeatHit()
    if getProperty('penthosDance.alpha') == 1 then
        playAnim('penthosDance', 'bounce', true)
    end
    if curBeat == 342 then
        setProperty('camZoomingMult', 1)
    end
end

function onMoveCamera(char)
    local isDad = (char == 'dad')
    desiredAngle = isDad and -2 or 2
    playAnim('heStares', isDad and 'L' or 'R', true)
end

local rannn = false

function onEvent(name, v1, v2)
    if name == 'chat' then
        if not rannn then
            setProperty('penthosDance.alpha', 1)
            setProperty('dad.alpha', 0)
            rannn = true
        elseif rannn then
            setProperty('penthosDance.alpha', 0)
            setProperty('dad.alpha', 1)
            rannn = false
        end
    elseif name == 'badFade' then
        doTweenAlpha('fadeOutGood', 'goodIntro', 0.01, 1.5, 'linear')
        doTweenAlpha('fadeInBad', 'badIntro', 1, 1.5, 'linear')
    elseif name == 'introfade' then
        setProperty('defaultCamZoom', 1)
    elseif name == 'introApp' then
        cancelTween('fadeInBad')
        cancelTween('fadeOutGood')
        setProperty('badIntro.alpha', 0)
        setProperty('goodIntro.alpha', 0)
        setProperty('camGame.alpha', 1)
        setProperty('camHUD.alpha', 1)
        setProperty('camHUD.zoom', 2)
        allowedRotation = true
    elseif name == 'video' then
        startVideo('aethospen', false)
        setObjectCamera('videoCutscene', 'hud')
        setProperty('camZoomingMult', 0)
    elseif name == 'headPea' then
        doTweenY('heStaresUp', 'heStares', -300, 1.7, 'backOut')
        setProperty('heStares.alpha', 1)
    end
end