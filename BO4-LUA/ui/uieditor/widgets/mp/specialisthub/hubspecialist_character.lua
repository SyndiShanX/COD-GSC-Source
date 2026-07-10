require("x64:b74a28cf56c198b")
CoD.HubSpecialist_character = InheritFrom(LUI.UIElement)
CoD.HubSpecialist_character.__defaultWidth = 152
CoD.HubSpecialist_character.__defaultHeight = 173
CoD.HubSpecialist_character.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("currentShowcasedCharacterIndex")
	self:setClass(CoD.HubSpecialist_character)
	self.id = "HubSpecialist_character"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialistCharacter = CoD.HubSpecialist_character_internal.new(f1_arg0, f1_arg1, 0, 0, -46, 198, 0, 0, -16, 218)
	SpecialistCharacter:linkToElementModel(self, nil, false, function(model)
		SpecialistCharacter:setModel(model, f1_arg1)
	end)
	self:addElement(SpecialistCharacter)
	self.SpecialistCharacter = SpecialistCharacter
	SpecialistCharacter.id = "SpecialistCharacter"
	self.__defaultFocus = SpecialistCharacter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubSpecialist_character.__resetProperties = function(f3_arg0)
	f3_arg0.SpecialistCharacter:completeAnimation()
	f3_arg0.SpecialistCharacter:setScale(1, 1)
end
CoD.HubSpecialist_character.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.SpecialistCharacter:completeAnimation()
			f4_arg0.SpecialistCharacter:setScale(0.98, 0.98)
			f4_arg0.clipFinished(f4_arg0.SpecialistCharacter)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.SpecialistCharacter:completeAnimation()
			f5_arg0.SpecialistCharacter:setScale(1.03, 1.03)
			f5_arg0.clipFinished(f5_arg0.SpecialistCharacter)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.SpecialistCharacter:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f6_arg0.SpecialistCharacter:setScale(1.03, 1.03)
				f6_arg0.SpecialistCharacter:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.SpecialistCharacter:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.SpecialistCharacter:completeAnimation()
			f6_arg0.SpecialistCharacter:setScale(0.98, 0.98)
			f6_local0(f6_arg0.SpecialistCharacter)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.SpecialistCharacter:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f8_arg0.SpecialistCharacter:setScale(0.98, 0.98)
				f8_arg0.SpecialistCharacter:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SpecialistCharacter:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SpecialistCharacter:completeAnimation()
			f8_arg0.SpecialistCharacter:setScale(1.03, 1.03)
			f8_local0(f8_arg0.SpecialistCharacter)
		end,
	},
}
CoD.HubSpecialist_character.__onClose = function(f10_arg0)
	f10_arg0.SpecialistCharacter:close()
end
