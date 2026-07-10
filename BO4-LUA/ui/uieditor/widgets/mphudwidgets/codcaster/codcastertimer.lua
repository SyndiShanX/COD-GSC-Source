CoD.CodCasterTimer = InheritFrom(LUI.UIElement)
CoD.CodCasterTimer.__defaultWidth = 108
CoD.CodCasterTimer.__defaultHeight = 54
CoD.CodCasterTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterTimer)
	self.id = "CodCasterTimer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameTimer = LUI.UIText.new(0.5, 0.5, -46, 46, 0, 0, 6, 31)
	GameTimer:setTTF("ttmussels_demibold")
	GameTimer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GameTimer:setupGameTimer()
	GameTimer:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(GameTimer)
	self.GameTimer = GameTimer
	local NoTimeLimit = LUI.UIText.new(0.5, 0.5, -54, 54, 0, 0, 9, 27)
	NoTimeLimit:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_18E8304D25283DA6"))
	NoTimeLimit:setTTF("ttmussels_demibold")
	NoTimeLimit:setLetterSpacing(-0.5)
	NoTimeLimit:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	NoTimeLimit:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(NoTimeLimit)
	self.NoTimeLimit = NoTimeLimit
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0) and not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLow", 1)
			end,
		},
		{
			stateName = "TimeLow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "gameScore.gameTimeEnd", 0)
			end,
		},
		{
			stateName = "NoTimeLimit",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "gameScore.gameTimeLimit", 0)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["gameScore.gameTimeEnd"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "gameScore.gameTimeEnd",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["gameScore.gameTimeLow"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "gameScore.gameTimeLow",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["gameScore.gameTimeLimit"], function(f7_arg0)
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
CoD.CodCasterTimer.__resetProperties = function(f8_arg0)
	f8_arg0.GameTimer:completeAnimation()
	f8_arg0.NoTimeLimit:completeAnimation()
	f8_arg0.GameTimer:setRGB(1, 1, 1)
	f8_arg0.GameTimer:setAlpha(1)
	f8_arg0.NoTimeLimit:setAlpha(1)
end
CoD.CodCasterTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.GameTimer:completeAnimation()
			f9_arg0.GameTimer:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.GameTimer)
			f9_arg0.NoTimeLimit:completeAnimation()
			f9_arg0.NoTimeLimit:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.NoTimeLimit)
		end,
	},
	Active = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.NoTimeLimit:completeAnimation()
			f10_arg0.NoTimeLimit:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.NoTimeLimit)
		end,
	},
	TimeLow = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.GameTimer:completeAnimation()
			f11_arg0.GameTimer:setRGB(1, 0, 0)
			f11_arg0.clipFinished(f11_arg0.GameTimer)
			f11_arg0.NoTimeLimit:completeAnimation()
			f11_arg0.NoTimeLimit:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.NoTimeLimit)
		end,
	},
	NoTimeLimit = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.GameTimer:completeAnimation()
			f12_arg0.GameTimer:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.GameTimer)
		end,
	},
}
