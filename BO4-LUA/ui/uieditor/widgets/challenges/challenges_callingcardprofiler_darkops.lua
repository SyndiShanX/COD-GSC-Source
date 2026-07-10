require("x64:eeba57f916954d1")
require("x64:228a7baa572b047")
require("x64:a1e2d7b19f5deb0")
require("x64:c7e896ee4bc3f8")
CoD.Challenges_CallingCardProfiler_DarkOps = InheritFrom(LUI.UIElement)
CoD.Challenges_CallingCardProfiler_DarkOps.__defaultWidth = 525
CoD.Challenges_CallingCardProfiler_DarkOps.__defaultHeight = 732
CoD.Challenges_CallingCardProfiler_DarkOps.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.darkOpsModeIcon", 0x0)
	self:setClass(CoD.Challenges_CallingCardProfiler_DarkOps)
	self.id = "Challenges_CallingCardProfiler_DarkOps"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardIconBorder = LUI.UIImage.new(0.5, 0.5, -262.5, 262.5, 0, 0, 0, 129)
	CardIconBorder:setAlpha(0.15)
	CardIconBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	CardIconBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	CardIconBorder:setShaderVector(0, 0, 0, 0, 0)
	CardIconBorder:setupNineSliceShader(12, 12)
	self:addElement(CardIconBorder)
	self.CardIconBorder = CardIconBorder
	local CardIcon = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 131)
	CardIcon:linkToElementModel(self, nil, false, function(model)
		CardIcon:setModel(model, f1_arg1)
	end)
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
	local CardIconLockOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 129)
	CardIconLockOverlay:setRGB(0, 0, 0)
	CardIconLockOverlay:setAlpha(0)
	self:addElement(CardIconLockOverlay)
	self.CardIconLockOverlay = CardIconLockOverlay
	local StartMenuframenoBG0 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG0)
	self.StartMenuframenoBG0 = StartMenuframenoBG0
	local DarkOpsIcon = LUI.UIImage.new(0.5, 0.5, -130.5, 130.5, 0, 0, 281, 542)
	DarkOpsIcon:subscribeToGlobalModel(f1_arg1, "HUDItems", "darkOpsModeIcon", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DarkOpsIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(DarkOpsIcon)
	self.DarkOpsIcon = DarkOpsIcon
	local DarkOpsTitle = LUI.UIText.new(0, 1, 16, -16, 0, 0, 525, 561)
	DarkOpsTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DarkOpsTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"challenge/darkops"))
	DarkOpsTitle:setTTF("ttmussels_regular")
	DarkOpsTitle:setLetterSpacing(4)
	DarkOpsTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DarkOpsTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(DarkOpsTitle)
	self.DarkOpsTitle = DarkOpsTitle
	local DarkOpsDescription = LUI.UIText.new(0, 1, 18, -18, 0, 0, 568, 586)
	DarkOpsDescription:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	DarkOpsDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_15D737062BC2C280"))
	DarkOpsDescription:setTTF("dinnext_regular")
	DarkOpsDescription:setLetterSpacing(1)
	DarkOpsDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DarkOpsDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DarkOpsDescription)
	self.DarkOpsDescription = DarkOpsDescription
	local EmblemDescription = LUI.UIText.new(0, 1, 18, -18, 0, 0, 200.5, 218.5)
	EmblemDescription:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	EmblemDescription:setTTF("dinnext_regular")
	EmblemDescription:setLetterSpacing(1)
	EmblemDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EmblemDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	EmblemDescription:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EmblemDescription:setText(f4_local0)
		end
	end)
	self:addElement(EmblemDescription)
	self.EmblemDescription = EmblemDescription
	local ChallengeName = LUI.UIText.new(0, 0, 15, 510, 0, 0, 152.5, 185.5)
	ChallengeName:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ChallengeName:setTTF("ttmussels_regular")
	ChallengeName:setLetterSpacing(2)
	ChallengeName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ChallengeName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ChallengeName:linkToElementModel(self, "title", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ChallengeName:setText(ConvertToUpperString(f5_local0))
		end
	end)
	self:addElement(ChallengeName)
	self.ChallengeName = ChallengeName
	local TitleBg = LUI.UIImage.new(0.5, 0.5, -261, 261, 0, 0, 42, 87)
	TitleBg:setRGB(0, 0, 0)
	TitleBg:setAlpha(0.85)
	TitleBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	TitleBg:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(TitleBg)
	self.TitleBg = TitleBg
	local PixelGridTiledBacking = LUI.UIImage.new(0.5, 0.5, -261, 261, 0, 0, 43, 86)
	PixelGridTiledBacking:setAlpha(0.15)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local LockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -18, 18, 0, 0, 46.5, 82.5)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -257.5, 257.5, 1, 1, -40, -5)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
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
	CardIcon.id = "CardIcon"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local14 = self
	CoD.ChallengesUtility.SetDarkOpsModeIcon(f1_arg1)
	return self
end
CoD.Challenges_CallingCardProfiler_DarkOps.__resetProperties = function(f8_arg0)
	f8_arg0.LockedIcon:completeAnimation()
	f8_arg0.TitleBg:completeAnimation()
	f8_arg0.TrialWidget:completeAnimation()
	f8_arg0.CardIcon:completeAnimation()
	f8_arg0.LockedIcon:setAlpha(1)
	f8_arg0.TitleBg:setAlpha(0.85)
	f8_arg0.TrialWidget:setAlpha(0)
	f8_arg0.TrialWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_262486486346EC3F"))
	f8_arg0.CardIcon:setAlpha(1)
end
CoD.Challenges_CallingCardProfiler_DarkOps.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.TitleBg:completeAnimation()
			f9_arg0.TitleBg:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TitleBg)
			f9_arg0.LockedIcon:completeAnimation()
			f9_arg0.LockedIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LockedIcon)
			f9_arg0.TrialWidget:completeAnimation()
			f9_arg0.TrialWidget:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.TrialWidget)
		end,
	},
	Locked = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.CardIcon:completeAnimation()
			f10_arg0.CardIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CardIcon)
			f10_arg0.TrialWidget:completeAnimation()
			f10_arg0.TrialWidget.InfoText:completeAnimation()
			f10_arg0.TrialWidget:setAlpha(1)
			f10_arg0.TrialWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3B98899150D5FB25"))
			f10_arg0.clipFinished(f10_arg0.TrialWidget)
		end,
	},
}
CoD.Challenges_CallingCardProfiler_DarkOps.__onClose = function(f11_arg0)
	f11_arg0.CardIcon:close()
	f11_arg0.StartMenuframenoBG0:close()
	f11_arg0.DarkOpsIcon:close()
	f11_arg0.EmblemDescription:close()
	f11_arg0.ChallengeName:close()
	f11_arg0.LockedIcon:close()
	f11_arg0.TrialWidget:close()
end
