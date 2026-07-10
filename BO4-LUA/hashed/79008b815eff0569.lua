CoD.TrialTimer = InheritFrom(LUI.UIElement)
CoD.TrialTimer.__defaultWidth = 248
CoD.TrialTimer.__defaultHeight = 138
CoD.TrialTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TrialTimer)
	self.id = "TrialTimer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local timerBG = LUI.UIImage.new(0.5, 0.5, -124, 124, 0, 0, 26, 138)
	timerBG:setAlpha(0.75)
	timerBG:setImage(RegisterImage(0x26C7CC0E249563E))
	self:addElement(timerBG)
	self.timerBG = timerBG
	local objBg = LUI.UIImage.new(0.5, 0.5, -70.5, 70.5, 0, 0, 42.5, 111.5)
	objBg:setImage(RegisterImage(0x75D661B612187DF))
	self:addElement(objBg)
	self.objBg = objBg
	local TimerText2 = LUI.UIText.new(0.5, 0.5, -105, 1295, 0, 0, 11.5, 32.5)
	TimerText2:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	TimerText2:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	TimerText2:setTTF("skorzhen")
	TimerText2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimerText2:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TimerText2:setBackingType(2)
	TimerText2:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	TimerText2:setBackingXPadding(7)
	TimerText2:setBackingYPadding(7)
	TimerText2:setBackingImage(RegisterImage(0x75D661B612187DF))
	self:addElement(TimerText2)
	self.TimerText2 = TimerText2
	local TimerText = LUI.UIText.new(0.5, 0.5, -105, 1295, 0, 0, 11.5, 32.5)
	TimerText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	TimerText:setTTF("skorzhen")
	TimerText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimerText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TimerText)
	self.TimerText = TimerText
	local Timer = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 62.5, 113.5)
	Timer:setRGB(0.96, 0.66, 0)
	Timer:setTTF("skorzhen")
	Timer:setMaterial(LUI.UIImage.GetCachedMaterial(0x336C1AE82B1520A))
	Timer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Timer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Timer:subscribeToGlobalModel(f1_arg1, "ZMHud", "trialsTimer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Timer:setupEndTimer(f2_local0)
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	self:mergeStateConditions({
		{
			stateName = "CenteredTimerText",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TrialTimer.__resetProperties = function(f4_arg0)
	f4_arg0.TimerText:completeAnimation()
	f4_arg0.TimerText2:completeAnimation()
	f4_arg0.TimerText:setLeftRight(0.5, 0.5, -105, 1295)
	f4_arg0.TimerText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	f4_arg0.TimerText2:setLeftRight(0.5, 0.5, -105, 1295)
	f4_arg0.TimerText2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
end
CoD.TrialTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	CenteredTimerText = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.TimerText2:completeAnimation()
			f6_arg0.TimerText2:setLeftRight(0.5, 0.5, -700, 700)
			f6_arg0.TimerText2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
			f6_arg0.clipFinished(f6_arg0.TimerText2)
			f6_arg0.TimerText:completeAnimation()
			f6_arg0.TimerText:setLeftRight(0.5, 0.5, -700, 700)
			f6_arg0.TimerText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
			f6_arg0.clipFinished(f6_arg0.TimerText)
		end,
	},
}
CoD.TrialTimer.__onClose = function(f7_arg0)
	f7_arg0.Timer:close()
end
