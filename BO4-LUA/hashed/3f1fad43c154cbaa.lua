CoD.SpawnTimerNew = InheritFrom(LUI.UIElement)
CoD.SpawnTimerNew.__defaultWidth = 210
CoD.SpawnTimerNew.__defaultHeight = 210
CoD.SpawnTimerNew.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnTimerNew)
	self.id = "SpawnTimerNew"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backer = LUI.UIImage.new(0, 0.51, 51, 51, 0, 0.51, 51, 51)
	backer:setRGB(0, 0, 0)
	backer:setAlpha(0.6)
	backer:setImage(RegisterImage(0xF52F421F52D0B40))
	self:addElement(backer)
	self.backer = backer
	local TimeText = LUI.UIText.new(0.5, 0.5, -32, 32, 0.5, 0.5, -14, 16)
	TimeText:setAlpha(0)
	TimeText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	TimeText:setTTF("0arame_mono_stencil")
	TimeText:setLetterSpacing(2)
	TimeText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TimeText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(TimeText)
	self.TimeText = TimeText
	local TextBox = LUI.UIText.new(0, 0, 5, 205, 0, 0, 150, 168)
	TextBox:setRGB(0.7, 0.7, 0.7)
	TextBox:setAlpha(0)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x97D2D83C3F46EE5))
	TextBox:setTTF("0arame_mono_stencil")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local fui = LUI.UIImage.new(0, 0, 40.5, 169.5, 0, 0, 40.5, 169.5)
	fui:setAlpha(0)
	fui:setImage(RegisterImage(0xA3DD2D35024623C))
	self:addElement(fui)
	self.fui = fui
	local ClockBacking = LUI.UIImage.new(0, 0.43, 60, 60, 0, 0.43, 60, 60)
	ClockBacking:setImage(RegisterImage(0xA95033F5A0FFE7D))
	self:addElement(ClockBacking)
	self.ClockBacking = ClockBacking
	local Clock = LUI.UIImage.new(0, 0, 0, 210, 0, 0, 0, 210)
	Clock:setImage(RegisterImage(0x7178A7AED7645A8))
	Clock:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	Clock:setShaderVector(0, SetVectorComponent(0, 0, 1, 0.1, 0, 0))
	Clock:setShaderVector(1, 0.5, 0, 0, 0)
	Clock:setShaderVector(2, 0.5, 0, 0, 0)
	Clock:setShaderVector(3, 0, 0, 0, 0)
	Clock:setShaderVector(4, 10, 0.03, 0, 0)
	self:addElement(Clock)
	self.Clock = Clock
	local ClockGlow = LUI.UIImage.new(0, 0, 0, 210, 0, 0, 0, 210)
	ClockGlow:setRGB(0.92, 0.89, 0.72)
	ClockGlow:setImage(RegisterImage(0x7178A7AED7645A8))
	ClockGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x9AD9C230B10C37))
	ClockGlow:setShaderVector(0, SetVectorComponent(0, 0, 1, 0.1, 0, 0))
	ClockGlow:setShaderVector(1, 0.5, 0, 0, 0)
	ClockGlow:setShaderVector(2, 0.5, 0, 0, 0)
	ClockGlow:setShaderVector(3, 0, 0, 0, 0)
	ClockGlow:setShaderVector(4, 10, 0.03, 0, 0)
	self:addElement(ClockGlow)
	self.ClockGlow = ClockGlow
	local timerNumberBacking = LUI.UIImage.new(0, 0, 67, 143, 0, 0, 66.5, 142.5)
	timerNumberBacking:setImage(RegisterImage(0x77491BFE490D947))
	self:addElement(timerNumberBacking)
	self.timerNumberBacking = timerNumberBacking
	local PrematchTimer = LUI.UIText.new(0.5, 0.5, -28, 28, 0.52, 0.52, -25.5, 19.5)
	PrematchTimer:setRGB(0.92, 0.92, 0.92)
	PrematchTimer:setTTF("0arame_mono_stencil")
	PrematchTimer:setLetterSpacing(2)
	PrematchTimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PrematchTimer:subscribeToGlobalModel(f1_arg1, "HUDItems", "spawnSelectEndTime", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PrematchTimer:setupPrematchTimer(f2_local0)
		end
	end)
	self:addElement(PrematchTimer)
	self.PrematchTimer = PrematchTimer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local10 = self
	CoD.SpawnSelectionUtility.SetupSpawnTimer(self, f1_arg1, f1_arg0)
	return self
end
CoD.SpawnTimerNew.__resetProperties = function(f3_arg0)
	f3_arg0.TimeText:completeAnimation()
	f3_arg0.PrematchTimer:completeAnimation()
	f3_arg0.TextBox:completeAnimation()
	f3_arg0.ClockGlow:completeAnimation()
	f3_arg0.backer:completeAnimation()
	f3_arg0.Clock:completeAnimation()
	f3_arg0.ClockBacking:completeAnimation()
	f3_arg0.timerNumberBacking:completeAnimation()
	f3_arg0.TimeText:setAlpha(0)
	f3_arg0.PrematchTimer:setAlpha(1)
	f3_arg0.TextBox:setAlpha(0)
	f3_arg0.ClockGlow:setLeftRight(0, 0, 0, 210)
	f3_arg0.ClockGlow:setTopBottom(0, 0, 0, 210)
	f3_arg0.ClockGlow:setAlpha(1)
	f3_arg0.backer:setAlpha(0.6)
	f3_arg0.Clock:setAlpha(1)
	f3_arg0.ClockBacking:setAlpha(1)
	f3_arg0.timerNumberBacking:setAlpha(1)
end
CoD.SpawnTimerNew.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TimeText:completeAnimation()
			f4_arg0.TimeText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TimeText)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(8)
			f5_arg0.backer:completeAnimation()
			f5_arg0.backer:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.backer)
			f5_arg0.TimeText:completeAnimation()
			f5_arg0.TimeText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TimeText)
			f5_arg0.TextBox:completeAnimation()
			f5_arg0.TextBox:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TextBox)
			f5_arg0.ClockBacking:completeAnimation()
			f5_arg0.ClockBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ClockBacking)
			f5_arg0.Clock:completeAnimation()
			f5_arg0.Clock:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Clock)
			f5_arg0.ClockGlow:completeAnimation()
			f5_arg0.ClockGlow:setLeftRight(0, 0, 0, 210)
			f5_arg0.ClockGlow:setTopBottom(0, 0, 0, 210)
			f5_arg0.ClockGlow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ClockGlow)
			f5_arg0.timerNumberBacking:completeAnimation()
			f5_arg0.timerNumberBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.timerNumberBacking)
			f5_arg0.PrematchTimer:completeAnimation()
			f5_arg0.PrematchTimer:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PrematchTimer)
		end,
	},
}
CoD.SpawnTimerNew.__onClose = function(f6_arg0)
	f6_arg0.PrematchTimer:close()
end
