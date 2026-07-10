require("x64:12d199c0b6f6540")
CoD.ScoreboardButtonPrompts = InheritFrom(LUI.UIElement)
CoD.ScoreboardButtonPrompts.__defaultWidth = 256
CoD.ScoreboardButtonPrompts.__defaultHeight = 89
CoD.ScoreboardButtonPrompts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "scoreboardInfo.muteButtonPromptVisible", false)
	self:setClass(CoD.ScoreboardButtonPrompts)
	self.id = "ScoreboardButtonPrompts"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local mutePrompt = CoD.JoinButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 39, 0, 0, 25, 64)
	mutePrompt.KMprompt:setText(CoD.BaseUtility.AlreadyLocalized("J"))
	mutePrompt:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			mutePrompt.GpadButtonImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(mutePrompt)
	self.mutePrompt = mutePrompt
	local muteText = LUI.UIText.new(0, 0, 56, 256, 0, 0, 27, 64)
	muteText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	muteText:setTTF("default")
	muteText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	muteText:subscribeToGlobalModel(f1_arg1, "Scoreboard", "muteButtonPromptText", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			muteText:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(muteText)
	self.muteText = muteText
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "NotMutable",
			condition = function(menu, element, event)
				return ScoreboardMuteButtonPromptHidden(element, f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["scoreboardInfo.muteButtonPromptVisible"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "scoreboardInfo.muteButtonPromptVisible",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.forceScoreboard, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardButtonPrompts.__resetProperties = function(f8_arg0)
	f8_arg0.muteText:completeAnimation()
	f8_arg0.mutePrompt:completeAnimation()
	f8_arg0.muteText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f8_arg0.muteText:setAlpha(1)
	f8_arg0.mutePrompt:setRGB(1, 1, 1)
	f8_arg0.mutePrompt:setAlpha(1)
end
CoD.ScoreboardButtonPrompts.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.mutePrompt:completeAnimation()
			f10_arg0.mutePrompt:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.mutePrompt)
			f10_arg0.muteText:completeAnimation()
			f10_arg0.muteText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.muteText)
		end,
	},
	NotMutable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.mutePrompt:completeAnimation()
			f11_arg0.mutePrompt:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f11_arg0.mutePrompt:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.mutePrompt)
			f11_arg0.muteText:completeAnimation()
			f11_arg0.muteText:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f11_arg0.muteText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.muteText)
		end,
	},
}
CoD.ScoreboardButtonPrompts.__onClose = function(f12_arg0)
	f12_arg0.mutePrompt:close()
	f12_arg0.muteText:close()
end
