function onCreate()
    setProperty('defaultCamZoom', 0.7)
    setProperty('camGame.zoom', 0.7)
    makeLuaSprite("bg",'bg/bloogy/hello', -245,-50)
    addLuaSprite("bg")
    scaleObject("bg", 1.2, 1.2)
end
