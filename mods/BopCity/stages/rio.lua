function onCreate()
    setProperty('defaultCamZoom', 0.66)
    setProperty('camGame.zoom', 0.66)
    setProperty("skipCountdown", true)
  
    makeLuaSprite("overlay",'bg/rio/rio', -745,-250)
    addLuaSprite("overlay")
    setObjectCamera('overlay', 'camother')
    setBlendMode("overlay", "add")
    setProperty('overlay.alpha', 0.6)
    makeLuaSprite('text','bg/rio/text', 550,400)
	addLuaSprite('text',true)
	setObjectCamera('text', 'camother')
end