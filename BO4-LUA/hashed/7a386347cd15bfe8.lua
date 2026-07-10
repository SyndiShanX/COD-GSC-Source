CoD.SurveyResponseListItem = InheritFrom(LUI.UIElement)
CoD.SurveyResponseListItem.__defaultWidth = 373
CoD.SurveyResponseListItem.__defaultHeight = 70
CoD.SurveyResponseListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SurveyResponseListItem)
	self.id = "SurveyResponseListItem"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 373, 0, 0, 0, 70)
	Background:setRGB(0.11, 0.1, 0.1)
	self:addElement(Background)
	self.Background = Background
	local OptionText = LUI.UIText.new(0, 0, 21, 352, 0, 0, 17, 53)
	OptionText:setTTF("default")
	OptionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	OptionText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	OptionText:linkToElementModel(self, "optionText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			OptionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(OptionText)
	self.OptionText = OptionText
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.SurveyQuestion.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.answered, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "SurveyQuestion", "answered") then
			CoD.SurveyUtility.SendSurveyDlogResponse(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "SurveyQuestion", "answered") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SurveyResponseListItem.__resetProperties = function(f6_arg0)
	f6_arg0.Background:completeAnimation()
	f6_arg0.Background:setRGB(0.11, 0.1, 0.1)
end
CoD.SurveyResponseListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Background:completeAnimation()
			f8_arg0.Background:setRGB(0.25, 0.24, 0.23)
			f8_arg0.clipFinished(f8_arg0.Background)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Background:beginAnimation(100)
				f9_arg0.Background:setRGB(0.25, 0.24, 0.23)
				f9_arg0.Background:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Background:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Background:completeAnimation()
			f9_arg0.Background:setRGB(0.11, 0.1, 0.1)
			f9_local0(f9_arg0.Background)
		end,
		LoseFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Background:beginAnimation(100)
				f11_arg0.Background:setRGB(0.11, 0.1, 0.1)
				f11_arg0.Background:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Background:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Background:completeAnimation()
			f11_arg0.Background:setRGB(0.25, 0.24, 0.23)
			f11_local0(f11_arg0.Background)
		end,
	},
}
CoD.SurveyResponseListItem.__onClose = function(f13_arg0)
	f13_arg0.OptionText:close()
end
