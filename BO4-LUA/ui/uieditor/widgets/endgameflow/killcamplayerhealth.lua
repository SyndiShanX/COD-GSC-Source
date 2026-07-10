require("x64:b86237f42f877c0")
require("x64:93a575a7ca17e04")
CoD.KillcamPlayerHealth = InheritFrom(LUI.UIElement)
CoD.KillcamPlayerHealth.__defaultWidth = 400
CoD.KillcamPlayerHealth.__defaultHeight = 32
CoD.KillcamPlayerHealth.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamPlayerHealth)
	self.id = "KillcamPlayerHealth"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backer = LUI.UIImage.new(0, 0, 19, 321, 0, 0, 10, 23)
	Backer:setRGB(0, 0, 0)
	Backer:setAlpha(0.7)
	self:addElement(Backer)
	self.Backer = Backer
	local ArmorBar = CoD.ArmorBarKillCam.new(f1_arg0, f1_arg1, 0, 0, 22.5, 316.5, 0, 0, 2, 6)
	ArmorBar:linkToElementModel(self, nil, false, function(model)
		ArmorBar:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorBar)
	self.ArmorBar = ArmorBar
	local HealthBar = CoD.HealthBar.new(f1_arg0, f1_arg1, 0, 0, 20.5, 319.5, 0, 0, 8.5, 24.5)
	HealthBar.Backer:setAlpha(0)
	HealthBar.HealthFill:setRGB(ColorSet.FriendlyHealthBar.r, ColorSet.FriendlyHealthBar.g, ColorSet.FriendlyHealthBar.b)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local HealthValue = LUI.UIText.new(0, 0, 328, 392, 0, 0, 3, 29)
	HealthValue:setTTF("0arame_mono_stencil")
	HealthValue:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	HealthValue:setLetterSpacing(2)
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			HealthValue:setText(f4_local0)
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	local LeftLed02 = LUI.UIImage.new(0, 0, 158, 339, 0, 0, -4, 36)
	LeftLed02:setRGB(0, 0, 0)
	LeftLed02:setAlpha(0.17)
	LeftLed02:setScale(0.94, 0.94)
	LeftLed02:setImage(RegisterImage(0x832BA507D0E7663))
	LeftLed02:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	LeftLed02:setShaderVector(0, 0, 0.89, 0, 0)
	LeftLed02:setShaderVector(1, 0, 0, 0, 0)
	LeftLed02:setShaderVector(2, 0.39, 0.63, 0, 0)
	LeftLed02:setShaderVector(3, 0, 0, 0, 0)
	LeftLed02:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LeftLed02)
	self.LeftLed02 = LeftLed02
	local LeftLed01 = LUI.UIImage.new(0, 0, 6, 187, 0, 0, -4, 36)
	LeftLed01:setRGB(0, 0, 0)
	LeftLed01:setAlpha(0.17)
	LeftLed01:setScale(0.94, 0.94)
	LeftLed01:setImage(RegisterImage(0x832BA507D0E7663))
	LeftLed01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	LeftLed01:setShaderVector(0, 0, 1, 0, 0)
	LeftLed01:setShaderVector(1, 0, 0, 0, 0)
	LeftLed01:setShaderVector(2, 0.36, 0.63, 0, 0)
	LeftLed01:setShaderVector(3, 0, 0, 0, 0)
	LeftLed01:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LeftLed01)
	self.LeftLed01 = LeftLed01
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	CoD.HealthUtility.InitHealthBarLossPulse(self, self.HealthBar, f1_arg1, CoD.KillcamHealthBarPulse, f1_arg0)
	return self
end
CoD.KillcamPlayerHealth.__onClose = function(f5_arg0)
	f5_arg0.ArmorBar:close()
	f5_arg0.HealthBar:close()
	f5_arg0.HealthValue:close()
end
