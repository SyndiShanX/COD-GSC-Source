require("x64:a32324224e0a0ac")
CoD.CharacterSelection_CustomCharacterButton = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_CustomCharacterButton.__defaultWidth = 300
CoD.CharacterSelection_CustomCharacterButton.__defaultHeight = 480
CoD.CharacterSelection_CustomCharacterButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_CustomCharacterButton)
	self.id = "CharacterSelection_CustomCharacterButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CharacterSelectionCustomCharacterButtonInternal = CoD.CharacterSelection_CustomCharacterButton_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0.5, 0.5, -240, 240)
	CharacterSelectionCustomCharacterButtonInternal:mergeStateConditions({
		{
			stateName = "SelectedNoPersonalization",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsCurrentCharacterDefault(f1_arg1) and IsSelfInState(self, "NoPersonalize")
			end,
		},
		{
			stateName = "NoPersonalization",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NoPersonalize")
			end,
		},
	})
	CharacterSelectionCustomCharacterButtonInternal:linkToElementModel(self, nil, false, function(model)
		CharacterSelectionCustomCharacterButtonInternal:setModel(model, f1_arg1)
	end)
	CharacterSelectionCustomCharacterButtonInternal:linkToElementModel(self, "name", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CharacterSelectionCustomCharacterButtonInternal.Name:setText(CoD.SocialUtility.CleanGamerTag(f5_local0))
		end
	end)
	CharacterSelectionCustomCharacterButtonInternal:linkToElementModel(self, "icon", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CharacterSelectionCustomCharacterButtonInternal.FullBodyPortrait:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(CharacterSelectionCustomCharacterButtonInternal)
	self.CharacterSelectionCustomCharacterButtonInternal = CharacterSelectionCustomCharacterButtonInternal
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		UpdateSelfElementState(f1_arg0, element, controller)
	end)
	CharacterSelectionCustomCharacterButtonInternal.id = "CharacterSelectionCustomCharacterButtonInternal"
	self.__defaultFocus = CharacterSelectionCustomCharacterButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_CustomCharacterButton.__resetProperties = function(f8_arg0)
	f8_arg0.CharacterSelectionCustomCharacterButtonInternal:completeAnimation()
	f8_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1, 1)
end
CoD.CharacterSelection_CustomCharacterButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.CharacterSelectionCustomCharacterButtonInternal:completeAnimation()
			f10_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.CharacterSelectionCustomCharacterButtonInternal)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.CharacterSelectionCustomCharacterButtonInternal:beginAnimation(200)
				f11_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1.05, 1.05)
				f11_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.CharacterSelectionCustomCharacterButtonInternal:completeAnimation()
			f11_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1, 1)
			f11_local0(f11_arg0.CharacterSelectionCustomCharacterButtonInternal)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.CharacterSelectionCustomCharacterButtonInternal:beginAnimation(200)
				f13_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1, 1)
				f13_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.CharacterSelectionCustomCharacterButtonInternal:completeAnimation()
			f13_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1.05, 1.05)
			f13_local0(f13_arg0.CharacterSelectionCustomCharacterButtonInternal)
		end,
	},
	NoPersonalize = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.CharacterSelectionCustomCharacterButtonInternal:completeAnimation()
			f16_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.CharacterSelectionCustomCharacterButtonInternal)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.CharacterSelectionCustomCharacterButtonInternal:beginAnimation(200)
				f17_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1.05, 1.05)
				f17_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.CharacterSelectionCustomCharacterButtonInternal:completeAnimation()
			f17_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1, 1)
			f17_local0(f17_arg0.CharacterSelectionCustomCharacterButtonInternal)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.CharacterSelectionCustomCharacterButtonInternal:beginAnimation(200)
				f19_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1, 1)
				f19_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CharacterSelectionCustomCharacterButtonInternal:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.CharacterSelectionCustomCharacterButtonInternal:completeAnimation()
			f19_arg0.CharacterSelectionCustomCharacterButtonInternal:setScale(1.05, 1.05)
			f19_local0(f19_arg0.CharacterSelectionCustomCharacterButtonInternal)
		end,
	},
}
CoD.CharacterSelection_CustomCharacterButton.__onClose = function(f21_arg0)
	f21_arg0.CharacterSelectionCustomCharacterButtonInternal:close()
end
