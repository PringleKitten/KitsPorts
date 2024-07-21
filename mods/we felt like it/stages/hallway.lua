function onCreate()
    setProperty('skipCountdown', true)
	makeLuaSprite('backrooms', 'background/hallway/backrooms');
    scaleObject("backrooms", 1, 1)
    screenCenter('backrooms', 'xy')
    doTweenY('bg', 'backrooms', -130, 0.00001, 'linear')
    addLuaSprite('backrooms', false);
    initLuaShader('death')
    setSpriteShader('backrooms', 'death')
    setShaderBool('backrooms', 'repeatX', true) -- if you want repeated X
    setShaderFloatArray('backrooms', 'speed', {17, 0}) -- speed
    setShaderFloatArray('backrooms', 'actualSize', {7626, 1095})
    setShaderFloatArray('backrooms', 'backdropPosition', {0,0})

    makeAnimatedLuaSprite('smiler', 'background/hallway/smiler', 1800, 600);
    addAnimationByPrefix("smiler", "smiler", "idle",24,true)
    addLuaSprite('smiler', true);

    makeAnimatedLuaSprite('markbody', 'background/hallway/markbody', 2270, 620);
    addAnimationByPrefix("markbody", "markbody", "running",24,true)
    addLuaSprite('markbody', false); 
    
    initLuaShader('VCRDistortionEffect')
    makeLuaSprite('VCRDistortionEffect')
    makeGraphic('VCRDistortionEffect',0.06,0.06)
    
    setSpriteShader('VCRDistortionEffect', 'VCRDistortionEffect')
    runHaxeCode([[
        // shader on game
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject('VCRDistortionEffect').shader)]);
    ]])
    makeLuaSprite("dark", 'background/hallway/dark')
    screenCenter('dark', 'xy')
    setProperty('dark.alpha', 0.5)
    addLuaSprite('dark', true)

    makeLuaSprite("lightpass", 'background/hallway/lightpass', 800, -125)
    scaleObject('lightpass', 5.5, 2)
    setProperty('lightpass.alpha', 0.8)
    setSpriteShader('lightpass', 'death')
    setShaderBool('lightpass', 'repeatX', true) -- if you want repeated X
    setShaderFloatArray('lightpass', 'speed', {12, 0}) -- speed
    setShaderFloatArray('lightpass', 'actualSize', {3072, 1024})
    setShaderFloatArray('lightpass', 'backdropPosition', {0,0})
    addLuaSprite('lightpass', true)

    makeAnimatedLuaSprite("shootit", 'background/hallway/im_sorry_for_torturing_you_tormented')
    setProperty('shootit.alpha', 0)
    addAnimationByPrefix("shootit", "opener", "open text", 22, false)
    addAnimationByPrefix("shootit", "loop", "funny", 22, true)
    addAnimationByPrefix("shootit", "closer", "closes", 22, false)
    scaleObject("shootit", 1, 1)
    setObjectCamera("shootit", 'other')
    screenCenter("shootit", 'xy')
    addLuaSprite("shootit", true)
    
    makeAnimatedLuaSprite("sr", 'background/hallway/start_running')
    setProperty('sr.alpha', 0)
    addAnimationByPrefix("sr", "sr", "start runnin mate", 24, false)
    scaleObject("sr", 1, 1)
    setObjectCamera("sr", 'other')
    screenCenter("sr", 'xy')
    addLuaSprite("sr", true)

    makeLuaSprite('bars', 'background/hallway/bars', 0,0)
    setObjectCamera('bars', 'other')
    screenCenter("bars")
    addLuaSprite('bars', true)
    setProperty('bars.alpha',0)
    
    makeLuaSprite('button', 'background/hallway/button',0,580)
    setObjectCamera("button", 'other')
    scaleObject("button", 0.7, 0.7)
    addLuaSprite("button",true)

    setProperty('camHUD.alpha', 1)
    setProperty('dad.alpha', 1)
    setProperty('boyfriend.alpha', 1)
    setProperty('markbody.alpha', 1)
    setProperty('backrooms.alpha', 1)
    setProperty('lightpass.alpha', 1)
    setProperty('smiler.alpha', 1)
    setProperty('pillar.alpha', 1)
end
function onCreatePost()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true);
    setPropertyFromClass('GameOverSubstate', 'characterName', 'mark-dead')
    setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'gameOver-rfyl')
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', nil)
    setPropertyFromClass('GameOverSubstate', 'endSoundName', nil)
    setProperty('camHUD.alpha', 0)
    setProperty('dad.alpha', 0)
    setProperty('boyfriend.alpha', 0)
    setProperty('markbody.alpha', 0)
    setProperty('backrooms.alpha', 0)
    setProperty('lightpass.alpha', 0)
    setProperty('smiler.alpha', 0)
    setProperty('pillar.alpha', 0)
end
function onUpdate()
    setShaderFloat('VCRDistortionEffect', 'iTime', os.clock())
    if botPlay then
        setTextString('botplayTxt', 'Run '..os.getenv('USERNAME'))
    end
end
function onStepHit()
    if curStep == 2 then
        setProperty('shootit.alpha', 1)
        playAnim("shootit", "opener")
    elseif curStep == 10 then
        playAnim("shootit", "loop")
    elseif curStep == 48 then
        playAnim("shootit", "closer")
    end
    if getProperty('shootit.animation.curAnim.finished') and getProperty('shootit.animation.curAnim.name') == 'closer' then
        removeLuaSprite("shootit")
    end
    if curStep == 112 then
        setProperty('dad.alpha', 1)
    elseif curStep == 121 then
        setProperty('sr.alpha', 1)
        playAnim("sr", "sr")
    elseif curStep == 128 then
        removeLuaSprite("sr")
        makeLuaText('howto', 'PRESS SPACE TO SHOOT', 300, 0, 550)
        scaleObject("howto", 2.2, 2)
        screenCenter("howto",'x')
        addLuaText("howto")
        makeLuaText('howtos', 'PRESS S BUTTON FOR MOBILE', 300, -50, 550)
        scaleObject('howtos', 1.5,1.5)
        addLuaText("howtos")
        doTweenAlpha("cH", "camHUD", 1, 0.6, "linear")
        doTweenAlpha("dad", "dad", 1, 0.6, "linear")
        doTweenAlpha("bf", "boyfriend", 1, 0.6, "linear")
        doTweenAlpha("mb", "markbody", 1, 0.6, "linear")
        doTweenAlpha("br", "backrooms", 1, 0.6, "linear")
        doTweenAlpha("lp", "lightpass", 1, 0.6, "linear")
        doTweenAlpha("sm", "smiler", 1, 0.6, "linear")
        doTweenAlpha("pir", "pillar", 1, 0.6, "linear")
    elseif curStep == 180 then
        doTweenAlpha("howto", "howto", 0, 0.5, "linear")
        doTweenAlpha("howtos", "howtos", 0, 0.5, "linear")
    elseif curStep == 256 then
        removeLuaText("howto")
        removeLuaText("howtos")
        doTweenAlpha("dad", "dad", 0, 0.6, "linear")
        doTweenAlpha("bf", "boyfriend", 0, 0.6, "linear")
        doTweenAlpha("mb", "markbody", 0, 0.4, "linear")
        doTweenAlpha("br", "backrooms", 0, 0.6, "linear")
        doTweenAlpha("lp", "lightpass", 0, 0.6, "linear")
        doTweenAlpha("sm", "smiler", 0, 0.6, "linear")
        doTweenAlpha("pir", "pillar", 0, 0.6, "linear")
    elseif curStep == 277 then
        setProperty('camHUD.alpha', 0)
        setProperty('bars.alpha',1)
        doTweenY('ba1', 'bars.scale', 1.1, 0.1, 'quadInOut')
        makeLuaText('smilef', 'SMILE FOR US', 200, 0, 500)
        scaleObject("smilef", 3, 3)
        setTextColor("smilef", "ff0000")
        setObjectCamera("smilef", 'other')
        screenCenter('smilef', 'x')
        addLuaText("smilef")
    elseif curStep == 287 then
        doTweenAlpha("cH", "camHUD", 1, 0.6, "linear")
        doTweenAlpha("dad", "dad", 1, 0.6, "linear")
        doTweenAlpha("bf", "boyfriend", 1, 0.6, "linear")
        doTweenAlpha("mb", "markbody", 1, 0.6, "linear")
        doTweenAlpha("br", "backrooms", 1, 0.6, "linear")
        doTweenAlpha("lp", "lightpass", 1, 0.6, "linear")
        doTweenAlpha("sm", "smiler", 1, 0.6, "linear")
        doTweenAlpha("pir", "pillar", 1, 0.6, "linear")
        removeLuaText("smilef")
        doTweenY('ba', 'bars.scale', 10, 0.1, 'quadInOut')
    elseif curStep == 300 then
        removeLuaSprite('bars')
    elseif curStep == 928 then
        noteTweenAlpha("o1",0,0,0.4,"linear");
        noteTweenAlpha("o2",1,0,0.4,"linear");
        noteTweenAlpha("o3",2,0,0.4,"linear");
        noteTweenAlpha("o4",3,0,0.4,"linear");
        noteTweenAlpha("o5",4,0,0.4,"linear");
        noteTweenAlpha("o6",5,0,0.4,"linear");
        noteTweenAlpha("o7",6,0,0.4,"linear");
        noteTweenAlpha("o8",7,0,0.4,"linear");
        doTweenAlpha('1aa','healthBar', 0, 0.4,'linear');
		doTweenAlpha('1ab','healthBarBG', 0, 0.4,'linear');
		doTweenAlpha('1ac','iconP1', 0, 0.4,'linear');
		doTweenAlpha('1ad','iconP2', 0, 0.4,'linear');
		doTweenAlpha('1ae','scoreTxt', 0, 0.4,'linear');
		doTweenAlpha('1af','timeBar', 0, 0.4,'linear');
		doTweenAlpha('1ag','timeTxt', 0, 0.4,'linear');
        doTweenAlpha('2aa','timeBar', 0,0.4,'linear');
        doTweenAlpha('2ab','timeBarBG', 0,0.4,'linear');
        doTweenAlpha('2ac','timeTxt',0,0.4,'linear');
        cameraFlash('game','0xFFFFFF',0.5,true)
    elseif curStep == 996 then
        noteTweenAlpha("o1",0,1,0.4,"linear");
        noteTweenAlpha("o2",1,1,0.4,"linear");
        noteTweenAlpha("o3",2,1,0.4,"linear");
        noteTweenAlpha("o4",3,1,0.4,"linear");
        noteTweenAlpha("o5",4,1,0.4,"linear");
        noteTweenAlpha("o6",5,1,0.4,"linear");
        noteTweenAlpha("o7",6,1,0.4,"linear");
        noteTweenAlpha("o8",7,1,0.4,"linear");
    elseif curStep == 1184 then
        doTweenAlpha('1aa','healthBar', 1, 0.4,'linear');
		doTweenAlpha('1ab','healthBarBG', 1, 0.4,'linear');
		doTweenAlpha('1ac','iconP1', 1, 0.4,'linear');
		doTweenAlpha('1ad','iconP2', 1, 0.4,'linear');
		doTweenAlpha('1ae','scoreTxt', 1, 0.4,'linear');
		doTweenAlpha('1af','timeBar', 1, 0.4,'linear');
		doTweenAlpha('1ag','timeTxt', 1, 0.4,'linear');
        doTweenAlpha('2aa','timeBar', 1,0.4,'linear')
        doTweenAlpha('2ab','timeBarBG', 1,0.4,'linear')
        doTweenAlpha('2ac','timeTxt', 1,0.4,'linear')
    end
end

function onUpdatePost()
    local speed = getShaderFloatArray('backrooms', 'speed')
    local oldPos = getShaderFloatArray('backrooms', 'backdropPosition')
    setShaderFloatArray('backrooms', 'backdropPosition', {
        oldPos[1] + speed[1],
        oldPos[2] + speed[2]
    })

    local speed2 = getShaderFloatArray('lightpass', 'speed')
    local oldPos2 = getShaderFloatArray('lightpass', 'backdropPosition')
    setShaderFloatArray('lightpass', 'backdropPosition', {
        oldPos2[1] + speed2[1],
        oldPos2[2] + speed2[2]
    })
end