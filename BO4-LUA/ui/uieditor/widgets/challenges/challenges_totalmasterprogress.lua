require("x64:eeba57f916954d1")
require("x64:228a7baa572b047")
require("x64:19c1945d2e472b0")
CoD.Challenges_TotalMasterProgress = InheritFrom(LUI.UIElement)
CoD.Challenges_TotalMasterProgress.__defaultWidth = 1175
CoD.Challenges_TotalMasterProgress.__defaultHeight = 100
CoD.Challenges_TotalMasterProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_TotalMasterProgress)
	self.id = "Challenges_TotalMasterProgress"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.01)
	FrameBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local LightOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LightOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LightOverlay:setAlpha(0.01)
	self:addElement(LightOverlay)
	self.LightOverlay = LightOverlay
	local MasterCallingCardIcon = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 1, 1, -456, 84, 0.5, 0.5, -45.5, 45.5)
	MasterCallingCardIcon.CardIconFrame:setScale(0.68, 1)
	MasterCallingCardIcon:subscribeToGlobalModel(f1_arg1, "MasterCallingCard", nil, function(model)
		MasterCallingCardIcon:setModel(model, f1_arg1)
	end)
	self:addElement(MasterCallingCardIcon)
	self.MasterCallingCardIcon = MasterCallingCardIcon
	local CallingCardLockOverlay = LUI.UIImage.new(0, 0, 805.5, 1172.5, 0, 0, 5, 95)
	CallingCardLockOverlay:setRGB(0, 0, 0)
	CallingCardLockOverlay:setAlpha(0)
	self:addElement(CallingCardLockOverlay)
	self.CallingCardLockOverlay = CallingCardLockOverlay
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0.68, 6, 4, 0.05, 0.95, 1, -1)
	DotTiledBacking:setAlpha(0.15)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local ProgressBorder = LUI.UIImage.new(0, 0.68, 4, 6, 0.05, 0.95, -1, 1)
	ProgressBorder:setAlpha(0.1)
	ProgressBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	ProgressBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ProgressBorder:setShaderVector(0, 0, 0, 0, 0)
	ProgressBorder:setupNineSliceShader(12, 12)
	self:addElement(ProgressBorder)
	self.ProgressBorder = ProgressBorder
	local ProgressBar = LUI.UIImage.new(0, 0.68, 6, 4, 0.06, 0.94, 0, 0)
	ProgressBar:setRGB(1, 0.36, 0)
	ProgressBar:setAlpha(0.15)
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:linkToElementModel(self, "percentComplete", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local LockIconBacking = LUI.UIImage.new(0.73, 0.73, 105.5, 145.5, 0, 0, 30, 70)
	LockIconBacking:setRGB(0, 0, 0)
	LockIconBacking:setAlpha(0.85)
	LockIconBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	LockIconBacking:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(LockIconBacking)
	self.LockIconBacking = LockIconBacking
	local LockIconBackingTexture = LUI.UIImage.new(0.74, 0.74, 101.5, 141.5, 0, 0, 30, 70)
	LockIconBackingTexture:setAlpha(0.15)
	LockIconBackingTexture:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	LockIconBackingTexture:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	LockIconBackingTexture:setShaderVector(0, 0, 0, 0, 0)
	LockIconBackingTexture:setupNineSliceShader(128, 128)
	self:addElement(LockIconBackingTexture)
	self.LockIconBackingTexture = LockIconBackingTexture
	local LockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 1, 1, -204, -168, 0.5, 0.5, -18, 18)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local CallingCardDescription = LUI.UIText.new(0, 0, 24, 780, 0, 0, 62.5, 80.5)
	CallingCardDescription:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	CallingCardDescription:setTTF("dinnext_regular")
	CallingCardDescription:setLetterSpacing(0.5)
	CallingCardDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CallingCardDescription:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CallingCardDescription:setText(CoD.BaseUtility.AlreadyLocalized(f4_local0))
		end
	end)
	self:addElement(CallingCardDescription)
	self.CallingCardDescription = CallingCardDescription
	local CallingCardName = LUI.UIText.new(0, 0, 24, 479, 0, 0, 21.5, 57.5)
	CallingCardName:setTTF("ttmussels_regular")
	CallingCardName:setLetterSpacing(4)
	CallingCardName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CallingCardName:linkToElementModel(self, "title", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CallingCardName:setText(ConvertToUpperString(f5_local0))
		end
	end)
	self:addElement(CallingCardName)
	self.CallingCardName = CallingCardName
	local CornerPip = LUI.UIImage.new(0, 0, 0, 15, 1, 1, -15, 0)
	CornerPip:setAlpha(0.15)
	CornerPip:setZRot(-90)
	CornerPip:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip)
	self.CornerPip = CornerPip
	local CornerPip4 = LUI.UIImage.new(1, 1, -15, 0, 1, 1, -15, 0)
	CornerPip4:setAlpha(0.15)
	CornerPip4:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip4)
	self.CornerPip4 = CornerPip4
	local CornerPip3 = LUI.UIImage.new(0, 0, 0, 15, 0, 0, 0, 15)
	CornerPip3:setAlpha(0.15)
	CornerPip3:setZRot(180)
	CornerPip3:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip3)
	self.CornerPip3 = CornerPip3
	local CornerPip2 = LUI.UIImage.new(1, 1, -15, 0, 0, 0, 0, 15)
	CornerPip2:setAlpha(0.15)
	CornerPip2:setZRot(90)
	CornerPip2:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip2)
	self.CornerPip2 = CornerPip2
	local percentText = LUI.UIText.new(0.5, 0.5, 102, 192, 0.5, 0.5, -13.5, 13.5)
	percentText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	percentText:setAlpha(0.8)
	percentText:setTTF("dinnext_regular")
	percentText:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	percentText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	percentText:linkToElementModel(self, "percentComplete", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			percentText:setText(NumberAsPercentRounded(f6_local0))
		end
	end)
	self:addElement(percentText)
	self.percentText = percentText
	local CompletedImage = LUI.UIImage.new(0, 0, 642, 702, 0.5, 0.5, -30, 30)
	CompletedImage:setAlpha(0)
	CompletedImage:setImage(RegisterImage(@"uie_ui_icon_challenges_complete_small"))
	self:addElement(CompletedImage)
	self.CompletedImage = CompletedImage
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "isLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	MasterCallingCardIcon.id = "MasterCallingCardIcon"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_TotalMasterProgress.__resetProperties = function(f10_arg0)
	f10_arg0.LockedIcon:completeAnimation()
	f10_arg0.LockIconBacking:completeAnimation()
	f10_arg0.LockIconBackingTexture:completeAnimation()
	f10_arg0.CallingCardLockOverlay:completeAnimation()
	f10_arg0.ProgressBar:completeAnimation()
	f10_arg0.CallingCardName:completeAnimation()
	f10_arg0.percentText:completeAnimation()
	f10_arg0.CompletedImage:completeAnimation()
	f10_arg0.LockedIcon:setAlpha(1)
	f10_arg0.LockIconBacking:setAlpha(0.85)
	f10_arg0.LockIconBackingTexture:setAlpha(0.15)
	f10_arg0.CallingCardLockOverlay:setAlpha(0)
	f10_arg0.ProgressBar:setAlpha(0.15)
	f10_arg0.CallingCardName:setRGB(1, 1, 1)
	f10_arg0.percentText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f10_arg0.CompletedImage:setAlpha(0)
end
CoD.Challenges_TotalMasterProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.LockIconBacking:completeAnimation()
			f11_arg0.LockIconBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.LockIconBacking)
			f11_arg0.LockIconBackingTexture:completeAnimation()
			f11_arg0.LockIconBackingTexture:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.LockIconBackingTexture)
			f11_arg0.LockedIcon:completeAnimation()
			f11_arg0.LockedIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.LockedIcon)
		end,
	},
	Locked = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.CallingCardLockOverlay:completeAnimation()
			f12_arg0.CallingCardLockOverlay:setAlpha(0.85)
			f12_arg0.clipFinished(f12_arg0.CallingCardLockOverlay)
		end,
	},
	Completed = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(7)
			f13_arg0.ProgressBar:completeAnimation()
			f13_arg0.ProgressBar:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ProgressBar)
			f13_arg0.LockIconBacking:completeAnimation()
			f13_arg0.LockIconBacking:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LockIconBacking)
			f13_arg0.LockIconBackingTexture:completeAnimation()
			f13_arg0.LockIconBackingTexture:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LockIconBackingTexture)
			f13_arg0.LockedIcon:completeAnimation()
			f13_arg0.LockedIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LockedIcon)
			f13_arg0.CallingCardName:completeAnimation()
			f13_arg0.CallingCardName:setRGB(ColorSet.T8_PC_CHAT_PARTY.r, ColorSet.T8_PC_CHAT_PARTY.g, ColorSet.T8_PC_CHAT_PARTY.b)
			f13_arg0.clipFinished(f13_arg0.CallingCardName)
			f13_arg0.percentText:completeAnimation()
			f13_arg0.percentText:setRGB(ColorSet.T8_PC_CHAT_PARTY.r, ColorSet.T8_PC_CHAT_PARTY.g, ColorSet.T8_PC_CHAT_PARTY.b)
			f13_arg0.clipFinished(f13_arg0.percentText)
			f13_arg0.CompletedImage:completeAnimation()
			f13_arg0.CompletedImage:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.CompletedImage)
		end,
	},
}
CoD.Challenges_TotalMasterProgress.__onClose = function(f14_arg0)
	f14_arg0.MasterCallingCardIcon:close()
	f14_arg0.DotTiledBacking:close()
	f14_arg0.ProgressBar:close()
	f14_arg0.LockedIcon:close()
	f14_arg0.CallingCardDescription:close()
	f14_arg0.CallingCardName:close()
	f14_arg0.percentText:close()
end
