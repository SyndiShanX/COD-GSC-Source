require("x64:606418af42696c8")
CoD.ArchivesVideoButton = InheritFrom(LUI.UIElement)
CoD.ArchivesVideoButton.__defaultWidth = 510
CoD.ArchivesVideoButton.__defaultHeight = 42
CoD.ArchivesVideoButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArchivesVideoButton)
	self.id = "ArchivesVideoButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArchivesVideoButtonInternal = CoD.ArchivesVideoButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ArchivesVideoButtonInternal.ButtonFrame.FocusGlow:setScale(1, 0.8)
	ArchivesVideoButtonInternal:linkToElementModel(self, nil, false, function(model)
		ArchivesVideoButtonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(ArchivesVideoButtonInternal)
	self.ArchivesVideoButtonInternal = ArchivesVideoButtonInternal
	local ButtonText = LUI.UIText.new(0.5, 0.5, -245, 245, 0.5, 0.5, -10, 10)
	ButtonText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ButtonText:setAlpha(0)
	ButtonText:setTTF("ttmussels_regular")
	ButtonText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ButtonText:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ButtonText:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(ButtonText)
	self.ButtonText = ButtonText
	local MatureContentText = LUI.UIText.new(0, 1, 5, -5, 0, 0, 5, 38)
	MatureContentText:setRGB(0.5, 0.5, 0.5)
	MatureContentText:setAlpha(0)
	MatureContentText:setText(LocalizeToUpperString(@"hash_C52F8F8D0D51561"))
	MatureContentText:setTTF("ttmussels_demibold")
	MatureContentText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MatureContentText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(MatureContentText)
	self.MatureContentText = MatureContentText
	local lockImage = LUI.UIImage.new(1, 1, -55, -5, 0.5, 0.5, -25, 25)
	lockImage:setAlpha(0)
	lockImage:setScale(0.6, 0.6)
	lockImage:setImage(RegisterImage(@"uie_ui_icon_global_lock"))
	self:addElement(lockImage)
	self.lockImage = lockImage
	self:mergeStateConditions({
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "matureContent") and not CoD.CTUtility.IsMatureContent(f1_arg1)
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "unlocked")
			end,
		},
	})
	self:linkToElementModel(self, "matureContent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "matureContent",
		})
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["storageGlobalRoot.user_settings"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	ArchivesVideoButtonInternal.id = "ArchivesVideoButtonInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArchivesVideoButton.__resetProperties = function(f9_arg0)
	f9_arg0.lockImage:completeAnimation()
	f9_arg0.ArchivesVideoButtonInternal:completeAnimation()
	f9_arg0.ButtonText:completeAnimation()
	f9_arg0.MatureContentText:completeAnimation()
	f9_arg0.lockImage:setAlpha(0)
	f9_arg0.lockImage:setScale(0.6, 0.6)
	f9_arg0.ArchivesVideoButtonInternal:setScale(1, 1)
	f9_arg0.ArchivesVideoButtonInternal.ButtonText:setAlpha(1)
	f9_arg0.ButtonText:setAlpha(0)
	f9_arg0.ButtonText:setScale(1, 1)
	f9_arg0.MatureContentText:setAlpha(0)
end
CoD.ArchivesVideoButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.ArchivesVideoButtonInternal:completeAnimation()
			f11_arg0.ArchivesVideoButtonInternal:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.ArchivesVideoButtonInternal)
			f11_arg0.ButtonText:completeAnimation()
			f11_arg0.ButtonText:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.ButtonText)
			f11_arg0.lockImage:completeAnimation()
			f11_arg0.lockImage:setScale(0.63, 0.63)
			f11_arg0.clipFinished(f11_arg0.lockImage)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ArchivesVideoButtonInternal:beginAnimation(200)
				f12_arg0.ArchivesVideoButtonInternal:setScale(1.05, 1.05)
				f12_arg0.ArchivesVideoButtonInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ArchivesVideoButtonInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ArchivesVideoButtonInternal:completeAnimation()
			f12_arg0.ArchivesVideoButtonInternal:setScale(1, 1)
			f12_local0(f12_arg0.ArchivesVideoButtonInternal)
			local f12_local1 = function(f14_arg0)
				f12_arg0.ButtonText:beginAnimation(200)
				f12_arg0.ButtonText:setScale(1.05, 1.05)
				f12_arg0.ButtonText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ButtonText:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ButtonText:completeAnimation()
			f12_arg0.ButtonText:setScale(1, 1)
			f12_local1(f12_arg0.ButtonText)
			local f12_local2 = function(f15_arg0)
				f12_arg0.lockImage:beginAnimation(200)
				f12_arg0.lockImage:setScale(0.63, 0.63)
				f12_arg0.lockImage:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.lockImage:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.lockImage:completeAnimation()
			f12_arg0.lockImage:setScale(0.6, 0.6)
			f12_local2(f12_arg0.lockImage)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				f16_arg0.ArchivesVideoButtonInternal:beginAnimation(200)
				f16_arg0.ArchivesVideoButtonInternal:setScale(1, 1)
				f16_arg0.ArchivesVideoButtonInternal:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ArchivesVideoButtonInternal:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ArchivesVideoButtonInternal:completeAnimation()
			f16_arg0.ArchivesVideoButtonInternal:setScale(1.05, 1.05)
			f16_local0(f16_arg0.ArchivesVideoButtonInternal)
			local f16_local1 = function(f18_arg0)
				f16_arg0.ButtonText:beginAnimation(200)
				f16_arg0.ButtonText:setScale(1, 1)
				f16_arg0.ButtonText:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ButtonText:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.ButtonText:completeAnimation()
			f16_arg0.ButtonText:setScale(1.05, 1.05)
			f16_local1(f16_arg0.ButtonText)
			local f16_local2 = function(f19_arg0)
				f16_arg0.lockImage:beginAnimation(200)
				f16_arg0.lockImage:setScale(0.6, 0.6)
				f16_arg0.lockImage:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.lockImage:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.lockImage:completeAnimation()
			f16_arg0.lockImage:setScale(0.63, 0.63)
			f16_local2(f16_arg0.lockImage)
		end,
	},
	MatureContentFiltered = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			f20_arg0.ArchivesVideoButtonInternal:completeAnimation()
			f20_arg0.ArchivesVideoButtonInternal.ButtonText:completeAnimation()
			f20_arg0.ArchivesVideoButtonInternal.ButtonText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ArchivesVideoButtonInternal)
			f20_arg0.ButtonText:completeAnimation()
			f20_arg0.ButtonText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ButtonText)
			f20_arg0.MatureContentText:completeAnimation()
			f20_arg0.MatureContentText:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.MatureContentText)
			f20_arg0.lockImage:completeAnimation()
			f20_arg0.lockImage:setAlpha(0.2)
			f20_arg0.clipFinished(f20_arg0.lockImage)
		end,
	},
	Classified = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.lockImage:completeAnimation()
			f21_arg0.lockImage:setAlpha(0.2)
			f21_arg0.clipFinished(f21_arg0.lockImage)
		end,
	},
}
CoD.ArchivesVideoButton.__onClose = function(f22_arg0)
	f22_arg0.ArchivesVideoButtonInternal:close()
	f22_arg0.ButtonText:close()
end
