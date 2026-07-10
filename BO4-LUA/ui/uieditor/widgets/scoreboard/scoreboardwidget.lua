require("x64:dd8758410e5f999")
CoD.ScoreboardWidget = InheritFrom(LUI.UIElement)
CoD.ScoreboardWidget.__defaultWidth = 1920
CoD.ScoreboardWidget.__defaultHeight = 1080
CoD.ScoreboardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ScoreboardUtility.SetScoreboardUIModels(f1_arg1)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "CodCaster")
	CoD.BaseUtility.InitControllerModel(f1_arg1, "CodCaster.showCodCasterScoreboard", false)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ScoreboardWidget)
	self.id = "ScoreboardWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TabbedScoreboard = CoD.TabbedScoreboard.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	self:addElement(TabbedScoreboard)
	self.TabbedScoreboard = TabbedScoreboard
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
			end,
		},
		{
			stateName = "ForceVisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "forceScoreboard", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.forceScoreboard, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f6_arg2, f6_arg3, f6_arg4)
		if IsSelfInState(self, "DefaultState") then
			SetLoseFocusToSelf(self, controller)
		else
			SetFocusToSelf(self, controller)
		end
	end)
	TabbedScoreboard.id = "TabbedScoreboard"
	self.__defaultFocus = TabbedScoreboard
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.HUDUtility.AddCustomGainFocusWidget(self, self.TabbedScoreboard)
	return self
end
CoD.ScoreboardWidget.__resetProperties = function(f7_arg0)
	f7_arg0.TabbedScoreboard:completeAnimation()
	f7_arg0.TabbedScoreboard:setAlpha(1)
end
CoD.ScoreboardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.TabbedScoreboard:completeAnimation()
			f8_arg0.TabbedScoreboard:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TabbedScoreboard)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.TabbedScoreboard:completeAnimation()
			f9_arg0.TabbedScoreboard:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.TabbedScoreboard)
		end,
	},
	ForceVisible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.TabbedScoreboard:completeAnimation()
			f10_arg0.TabbedScoreboard:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.TabbedScoreboard)
		end,
	},
}
CoD.ScoreboardWidget.__onClose = function(f11_arg0)
	f11_arg0.TabbedScoreboard:close()
end
