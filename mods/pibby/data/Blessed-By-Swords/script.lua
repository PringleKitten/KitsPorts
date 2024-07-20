function onSongStart()
    setProperty('dark.origin.x', 800)
    setProperty('dark.origin.y', 200)
    setProperty('light.origin.x', 800)
    setProperty('light.origin.y', 200)
    setProperty('bulb.origin.x', 1380)
    setProperty('bulb.origin.y', 700)
    doTweenAlpha('light', 'light', 0, 0.25, 'bounceInOut')
end
   function onUpdate(elapsed)
    local songPos = getPropertyFromClass('Conductor', 'songPosition') / 300 * 1
    
    setProperty('light.angle', math.sin(songPos)*5)
    setProperty('dark.angle', math.sin(songPos)*5)
    setProperty('bulb.angle', math.sin(songPos)*5)
    end

    function onTweenCompleted(tag)
        if tag == 'light' then
            doTweenAlpha('light2', 'light', 0.8, 0.25, 'bounceInOut')
        end
        if tag == 'light2' then
            doTweenAlpha('light', 'light', 0, 0.25, 'bounceInOut')
        end
    end

    local shaderName = "3D"
function onStepHit()
if curBeat == 1 then 
  
    shaderCoordFix() -- initialize a fix for textureCoord when resizing game window

    makeLuaSprite("tempShader0")

    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        var shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
        game.getLuaObject("tempShader0").shader = shader0; // setting it into temporary sprite so luas can set its shader uniforms/properties
        return;
    ]])
    end
end  
function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end

function onCreatePost()
    add3DEffect('camgame')
    add3DEffect('camhud', false)
end