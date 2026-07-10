require("x64:b20339e832dc8eb")
CoD.SpecialistDossierButton = InheritFrom(LUI.UIElement)
CoD.SpecialistDossierButton.__defaultWidth = 510
CoD.SpecialistDossierButton.__defaultHeight = 43
CoD.SpecialistDossierButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistDossierButton)
	self.id = "SpecialistDossierButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialistPersonalizationButtonOptionInternal = CoD.SpecialistPersonalizationButtonOptionInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	SpecialistPersonalizationButtonOptionInternal.Header:setText("")
	self:addElement(SpecialistPersonalizationButtonOptionInternal)
	self.SpecialistPersonalizationButtonOptionInternal = SpecialistPersonalizationButtonOptionInternal
	local ButtonText = LUI.UIText.new(0.03, 1, 5, -5, 0, 0, 9.5, 33.5)
	ButtonText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ButtonText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	ButtonText:setTTF("ttmussels_demibold")
	ButtonText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ButtonText)
	self.ButtonText = ButtonText
	local MatureContentText = LUI.UIText.new(0, 1, 5, -5, 0, 0, 5, 38)
	MatureContentText:setRGB(0.5, 0.5, 0.5)
	MatureContentText:setAlpha(0)
	MatureContentText:setText(LocalizeToUpperString(0xC52F8F8D0D51561))
	MatureContentText:setTTF("ttmussels_demibold")
	MatureContentText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MatureContentText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(MatureContentText)
	self.MatureContentText = MatureContentText
	local lockImage = LUI.UIImage.new(1, 1, -55, -5, 0.5, 0.5, -25, 25)
	lockImage:setAlpha(0)
	lockImage:setScale(0.6, 0.6)
	lockImage:setImage(RegisterImage(0xE1E7C490B2BA4FB))
	self:addElement(lockImage)
	self.lockImage = lockImage
	self:mergeStateConditions({
		{
			stateName = "PCKorea15Plus",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	SpecialistPersonalizationButtonOptionInternal.id = "SpecialistPersonalizationButtonOptionInternal"
	self.__defaultFocus = SpecialistPersonalizationButtonOptionInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistDossierButton.__resetProperties = function(f5_arg0)
	f5_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
	f5_arg0.ButtonText:completeAnimation()
	f5_arg0.MatureContentText:completeAnimation()
	f5_arg0.lockImage:completeAnimation()
	f5_arg0.SpecialistPersonalizationButtonOptionInternal:setAlpha(1)
	f5_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
	f5_arg0.ButtonText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f5_arg0.ButtonText:setAlpha(1)
	f5_arg0.ButtonText:setScale(1, 1)
	f5_arg0.MatureContentText:setAlpha(0)
	f5_arg0.MatureContentText:setScale(1, 1)
	f5_arg0.lockImage:setAlpha(0)
	f5_arg0.lockImage:setScale(0.6, 0.6)
end
CoD.SpecialistDossierButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			f7_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f7_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
			f7_arg0.clipFinished(f7_arg0.SpecialistPersonalizationButtonOptionInternal)
			f7_arg0.ButtonText:completeAnimation()
			f7_arg0.ButtonText:setScale(1.05, 1.05)
			f7_arg0.clipFinished(f7_arg0.ButtonText)
			f7_arg0.MatureContentText:completeAnimation()
			f7_arg0.MatureContentText:setScale(1.05, 1.05)
			f7_arg0.clipFinished(f7_arg0.MatureContentText)
			f7_arg0.lockImage:completeAnimation()
			f7_arg0.lockImage:setScale(0.63, 0.63)
			f7_arg0.clipFinished(f7_arg0.lockImage)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			local f8_local0 = function(f9_arg0)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:beginAnimation(200)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f8_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
			f8_local0(f8_arg0.SpecialistPersonalizationButtonOptionInternal)
			local f8_local1 = function(f10_arg0)
				f8_arg0.ButtonText:beginAnimation(200)
				f8_arg0.ButtonText:setScale(1.05, 1.05)
				f8_arg0.ButtonText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ButtonText:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.ButtonText:completeAnimation()
			f8_arg0.ButtonText:setScale(1, 1)
			f8_local1(f8_arg0.ButtonText)
			local f8_local2 = function(f11_arg0)
				f8_arg0.MatureContentText:beginAnimation(200)
				f8_arg0.MatureContentText:setScale(1.05, 1.05)
				f8_arg0.MatureContentText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.MatureContentText:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.MatureContentText:completeAnimation()
			f8_arg0.MatureContentText:setScale(1, 1)
			f8_local2(f8_arg0.MatureContentText)
			local f8_local3 = function(f12_arg0)
				f8_arg0.lockImage:beginAnimation(200)
				f8_arg0.lockImage:setScale(0.63, 0.63)
				f8_arg0.lockImage:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.lockImage:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.lockImage:completeAnimation()
			f8_arg0.lockImage:setScale(0.6, 0.6)
			f8_local3(f8_arg0.lockImage)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				f13_arg0.SpecialistPersonalizationButtonOptionInternal:beginAnimation(200)
				f13_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
				f13_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f13_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
			f13_local0(f13_arg0.SpecialistPersonalizationButtonOptionInternal)
			local f13_local1 = function(f15_arg0)
				f13_arg0.ButtonText:beginAnimation(200)
				f13_arg0.ButtonText:setScale(1, 1)
				f13_arg0.ButtonText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ButtonText:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ButtonText:completeAnimation()
			f13_arg0.ButtonText:setScale(1.05, 1.05)
			f13_local1(f13_arg0.ButtonText)
			local f13_local2 = function(f16_arg0)
				f13_arg0.MatureContentText:beginAnimation(200)
				f13_arg0.MatureContentText:setScale(1, 1)
				f13_arg0.MatureContentText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.MatureContentText:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.MatureContentText:completeAnimation()
			f13_arg0.MatureContentText:setScale(1.05, 1.05)
			f13_local2(f13_arg0.MatureContentText)
			local f13_local3 = function(f17_arg0)
				f13_arg0.lockImage:beginAnimation(200)
				f13_arg0.lockImage:setScale(0.6, 0.6)
				f13_arg0.lockImage:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.lockImage:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.lockImage:completeAnimation()
			f13_arg0.lockImage:setScale(0.63, 0.63)
			f13_local3(f13_arg0.lockImage)
		end,
	},
	PCKorea15Plus = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f18_arg0.SpecialistPersonalizationButtonOptionInternal:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.SpecialistPersonalizationButtonOptionInternal)
			f18_arg0.ButtonText:completeAnimation()
			f18_arg0.ButtonText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ButtonText)
			f18_arg0.MatureContentText:completeAnimation()
			f18_arg0.MatureContentText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.MatureContentText)
			f18_arg0.lockImage:completeAnimation()
			f18_arg0.lockImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.lockImage)
		end,
	},
	MatureContentFiltered = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.ButtonText:completeAnimation()
			f19_arg0.ButtonText:setRGB(0.5, 0.5, 0.5)
			f19_arg0.ButtonText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.ButtonText)
			f19_arg0.MatureContentText:completeAnimation()
			f19_arg0.MatureContentText:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.MatureContentText)
			f19_arg0.lockImage:completeAnimation()
			f19_arg0.lockImage:setAlpha(0.2)
			f19_arg0.clipFinished(f19_arg0.lockImage)
		end,
	},
	Classified = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.ButtonText:completeAnimation()
			f20_arg0.ButtonText:setRGB(0.5, 0.5, 0.5)
			f20_arg0.clipFinished(f20_arg0.ButtonText)
			f20_arg0.lockImage:completeAnimation()
			f20_arg0.lockImage:setAlpha(0.2)
			f20_arg0.clipFinished(f20_arg0.lockImage)
		end,
	},
}
CoD.SpecialistDossierButton.__onClose = function(f21_arg0)
	f21_arg0.SpecialistPersonalizationButtonOptionInternal:close()
end
