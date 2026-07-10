CoD.Codcaster_timer_nl = InheritFrom(LUI.UIElement)
CoD.Codcaster_timer_nl.__defaultWidth = 100
CoD.Codcaster_timer_nl.__defaultHeight = 27
CoD.Codcaster_timer_nl.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Codcaster_timer_nl)
	self.id = "Codcaster_timer_nl"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameTimerShadow = LUI.UIText.new(0, 0, 1, 101, 0, 0, -3, 31)
	GameTimerShadow:setRGB(0, 0, 0)
	GameTimerShadow:setTTF("ttmussels_demibold")
	GameTimerShadow:setLineSpacing(-1)
	GameTimerShadow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GameTimerShadow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	GameTimerShadow:setupGameTimer()
	GameTimerShadow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(GameTimerShadow)
	self.GameTimerShadow = GameTimerShadow
	local GameTimer = LUI.UIText.new(0, 0, 0, 100, 0, 0, -4, 30)
	GameTimer:setTTF("ttmussels_demibold")
	GameTimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GameTimer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	GameTimer:setupGameTimer()
	GameTimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(GameTimer)
	self.GameTimer = GameTimer
	local NotimerShadow = LUI.UIText.new(0, 0, 0.5, 100.5, 0, 0, 5, 21)
	NotimerShadow:setRGB(0, 0, 0)
	NotimerShadow:setText(Engine[0xF9F1239CFD921FE](0x8E8304D25283DA6))
	NotimerShadow:setTTF("ttmussels_demibold")
	NotimerShadow:setLetterSpacing(-1)
	NotimerShadow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NotimerShadow:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(NotimerShadow)
	self.NotimerShadow = NotimerShadow
	local Notimer = LUI.UIText.new(0, 0, 0, 100, 0, 0, 4.5, 20.5)
	Notimer:setText(Engine[0xF9F1239CFD921FE](0x8E8304D25283DA6))
	Notimer:setTTF("ttmussels_demibold")
	Notimer:setLetterSpacing(-1)
	Notimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Notimer:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Notimer)
	self.Notimer = Notimer
	self:mergeStateConditions({
		{
			stateName = "active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0) and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLow", 1)
			end,
		},
		{
			stateName = "timelow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0)
			end,
		},
		{
			stateName = "notimelimit",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLimit", 0)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["gameScore.gameTimeEnd"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "gameScore.gameTimeEnd",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["gameScore.gameTimeLow"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "gameScore.gameTimeLow",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["gameScore.gameTimeLimit"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "gameScore.gameTimeLimit",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Codcaster_timer_nl.__resetProperties = function(f8_arg0)
	f8_arg0.Notimer:completeAnimation()
	f8_arg0.NotimerShadow:completeAnimation()
	f8_arg0.GameTimer:completeAnimation()
	f8_arg0.Notimer:setAlpha(1)
	f8_arg0.NotimerShadow:setAlpha(1)
	f8_arg0.GameTimer:setRGB(1, 1, 1)
end
CoD.Codcaster_timer_nl.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	active = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.NotimerShadow:completeAnimation()
			f10_arg0.NotimerShadow:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.NotimerShadow)
			f10_arg0.Notimer:completeAnimation()
			f10_arg0.Notimer:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Notimer)
		end,
	},
	timelow = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.GameTimer:completeAnimation()
			f11_arg0.GameTimer:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
			f11_arg0.clipFinished(f11_arg0.GameTimer)
			f11_arg0.NotimerShadow:completeAnimation()
			f11_arg0.NotimerShadow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.NotimerShadow)
			f11_arg0.Notimer:completeAnimation()
			f11_arg0.Notimer:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Notimer)
		end,
	},
	notimelimit = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
