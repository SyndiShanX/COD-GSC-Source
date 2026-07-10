require("x64:eeba57f916954d1")
require("x64:228a7baa572b047")
require("x64:b046df181a7627c")
require("x64:b9ad3e1e7c33125")
require("x64:c7e896ee4bc3f8")
CoD.ChallengesCallingCardProfilerGlobal = InheritFrom(LUI.UIElement)
CoD.ChallengesCallingCardProfilerGlobal.__defaultWidth = 525
CoD.ChallengesCallingCardProfilerGlobal.__defaultHeight = 732
CoD.ChallengesCallingCardProfilerGlobal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesCallingCardProfilerGlobal)
	self.id = "ChallengesCallingCardProfilerGlobal"
	self.soundSet = "FrontendMain"
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
	local CardIconLockOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 131)
	CardIconLockOverlay:setRGB(0, 0, 0)
	CardIconLockOverlay:setAlpha(0.8)
	self:addElement(CardIconLockOverlay)
	self.CardIconLockOverlay = CardIconLockOverlay
	local Subtitle = CoD.StartMenu_Identity_SubTitle.new(f1_arg0, f1_arg1, 0.5, 0.5, -129, 129, 0, 0, 358, 388)
	Subtitle:setAlpha(0)
	Subtitle:linkToElementModel(self, "tierStatus", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Subtitle.SubtitleText:setText(f3_local0)
		end
	end)
	self:addElement(Subtitle)
	self.Subtitle = Subtitle
	local EmblemName = LUI.UIText.new(0, 0, 16, 510, 0, 0, 152.5, 185.5)
	EmblemName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmblemName:setTTF("ttmussels_regular")
	EmblemName:setLetterSpacing(2)
	EmblemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EmblemName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	EmblemName:linkToElementModel(self, "title", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EmblemName:setText(ConvertToUpperString(f4_local0))
		end
	end)
	self:addElement(EmblemName)
	self.EmblemName = EmblemName
	local EmblemSubtitle = LUI.UIText.new(0, 1, 18, -18, 0, 0, 299, 317)
	EmblemSubtitle:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	EmblemSubtitle:setTTF("dinnext_regular")
	EmblemSubtitle:setLetterSpacing(0.5)
	EmblemSubtitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EmblemSubtitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	EmblemSubtitle:linkToElementModel(self, "description", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EmblemSubtitle:setText(f5_local0)
		end
	end)
	self:addElement(EmblemSubtitle)
	self.EmblemSubtitle = EmblemSubtitle
	local WZBar = CoD.ChallengesGlobalProgressBar.new(f1_arg0, f1_arg1, 0, 0, 15, 510, 0, 0, 470, 492)
	WZBar:linkToElementModel(self, "wzProgress", false, function(model)
		WZBar:setModel(model, f1_arg1)
	end)
	self:addElement(WZBar)
	self.WZBar = WZBar
	local ZMBar = CoD.ChallengesGlobalProgressBar.new(f1_arg0, f1_arg1, 0, 0, 15, 510, 0, 0, 428, 450)
	ZMBar:linkToElementModel(self, "zmProgress", false, function(model)
		ZMBar:setModel(model, f1_arg1)
	end)
	self:addElement(ZMBar)
	self.ZMBar = ZMBar
	local MPBar = CoD.ChallengesGlobalProgressBar.new(f1_arg0, f1_arg1, 0, 0, 15, 510, 0, 0, 388, 410)
	MPBar:linkToElementModel(self, "mpProgress", false, function(model)
		MPBar:setModel(model, f1_arg1)
	end)
	self:addElement(MPBar)
	self.MPBar = MPBar
	local TotalProgressFracText = LUI.UIText.new(0.5, 0.5, -19.5, 19.5, 0, 0, 207.5, 252.5)
	TotalProgressFracText:setTTF("default")
	TotalProgressFracText:setLetterSpacing(2)
	TotalProgressFracText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TotalProgressFracText:linkToElementModel(self, "statFractionText", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			TotalProgressFracText:setText(f9_local0)
		end
	end)
	self:addElement(TotalProgressFracText)
	self.TotalProgressFracText = TotalProgressFracText
	local MasterBarBase = LUI.UIImage.new(0.5, 0.5, -247.5, 247.5, 0, 0, 295, 318)
	MasterBarBase:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	MasterBarBase:setAlpha(0.02)
	self:addElement(MasterBarBase)
	self.MasterBarBase = MasterBarBase
	local MasterBarBorder = LUI.UIImage.new(0.5, 0.5, -247.5, 247.5, 0, 0, 294, 317)
	MasterBarBorder:setAlpha(0.1)
	MasterBarBorder:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	MasterBarBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	MasterBarBorder:setShaderVector(0, 0, 0, 0, 0)
	MasterBarBorder:setupNineSliceShader(12, 12)
	self:addElement(MasterBarBorder)
	self.MasterBarBorder = MasterBarBorder
	local MasterBar = LUI.UIImage.new(0.03, 0.97, 1, -1, 0, 0.03, 296, 294)
	MasterBar:setRGB(1, 0.36, 0)
	MasterBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	MasterBar:setShaderVector(1, 0, 0, 0, 0)
	MasterBar:setShaderVector(2, 1, 0, 0, 0)
	MasterBar:setShaderVector(3, 0, 0, 0, 0)
	MasterBar:setShaderVector(4, 0, 0, 0, 0)
	MasterBar:linkToElementModel(self, "percentComplete", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			MasterBar:setShaderVector(0, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4))
		end
	end)
	self:addElement(MasterBar)
	self.MasterBar = MasterBar
	local MasterFraction = LUI.UIText.new(1, 1, -58, -19, 0, 0, 298, 316)
	MasterFraction:setTTF("default")
	MasterFraction:setLetterSpacing(2)
	MasterFraction:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	MasterFraction:linkToElementModel(self, "statFractionText", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			MasterFraction:setText(f11_local0)
		end
	end)
	self:addElement(MasterFraction)
	self.MasterFraction = MasterFraction
	local GameModeZM = LUI.UIText.new(0, 0, 19, 471, 0, 0, 430, 450)
	GameModeZM:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GameModeZM:setText(LocalizeToUpperString(@"menu/zombies"))
	GameModeZM:setTTF("ttmussels_regular")
	GameModeZM:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameModeZM:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GameModeZM)
	self.GameModeZM = GameModeZM
	local GameModeWZ = LUI.UIText.new(0, 0, 19, 471, 0, 0, 472, 492)
	GameModeWZ:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GameModeWZ:setText(LocalizeToUpperString(@"menu/warzone"))
	GameModeWZ:setTTF("ttmussels_regular")
	GameModeWZ:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameModeWZ:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GameModeWZ)
	self.GameModeWZ = GameModeWZ
	local GameModeMP = LUI.UIText.new(0, 0, 17, 469, 0, 0, 390, 410)
	GameModeMP:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GameModeMP:setText(LocalizeToUpperString(@"menu/multiplayer"))
	GameModeMP:setTTF("ttmussels_regular")
	GameModeMP:setLetterSpacing(1)
	GameModeMP:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameModeMP:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GameModeMP)
	self.GameModeMP = GameModeMP
	local TitleBg = LUI.UIImage.new(0.5, 0.5, -22.5, 22.5, 0, 0, 42, 87)
	TitleBg:setRGB(0, 0, 0)
	TitleBg:setAlpha(0.85)
	TitleBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	TitleBg:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(TitleBg)
	self.TitleBg = TitleBg
	local PixelGridTiledBacking = LUI.UIImage.new(0.5, 0.5, -21.5, 21.5, 0, 0, 43, 86)
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
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "trialLocked")
			end,
		},
	})
	TrialWidget:linkToElementModel(TrialWidget, "trialLocked", true, function(model)
		f1_arg0:updateElementState(TrialWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	TrialWidget:setAlpha(0)
	TrialWidget:linkToElementModel(self, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "LockedMasterCard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.profilingMasterCallingCard", 0) and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "UnlockedMasterCard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.profilingMasterCallingCard", 0)
			end,
		},
	})
	local f1_local22 = self
	local f1_local23 = self.subscribeToModel
	local f1_local24 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local23(f1_local22, f1_local24["hudItems.profilingMasterCallingCard"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.profilingMasterCallingCard",
		})
	end, false)
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
	return self
end
CoD.ChallengesCallingCardProfilerGlobal.__resetProperties = function(f20_arg0)
	f20_arg0.MasterFraction:completeAnimation()
	f20_arg0.MasterBar:completeAnimation()
	f20_arg0.MasterBarBorder:completeAnimation()
	f20_arg0.MasterBarBase:completeAnimation()
	f20_arg0.CardIconLockOverlay:completeAnimation()
	f20_arg0.TitleBg:completeAnimation()
	f20_arg0.PixelGridTiledBacking:completeAnimation()
	f20_arg0.LockedIcon:completeAnimation()
	f20_arg0.TrialWidget:completeAnimation()
	f20_arg0.ZMBar:completeAnimation()
	f20_arg0.WZBar:completeAnimation()
	f20_arg0.TotalProgressFracText:completeAnimation()
	f20_arg0.EmblemSubtitle:completeAnimation()
	f20_arg0.MPBar:completeAnimation()
	f20_arg0.GameModeMP:completeAnimation()
	f20_arg0.GameModeWZ:completeAnimation()
	f20_arg0.GameModeZM:completeAnimation()
	f20_arg0.MasterFraction:setAlpha(1)
	f20_arg0.MasterBar:setAlpha(1)
	f20_arg0.MasterBarBorder:setAlpha(0.1)
	f20_arg0.MasterBarBase:setAlpha(0.02)
	f20_arg0.CardIconLockOverlay:setAlpha(0.8)
	f20_arg0.TitleBg:setAlpha(0.85)
	f20_arg0.PixelGridTiledBacking:setAlpha(0.15)
	f20_arg0.LockedIcon:setAlpha(1)
	f20_arg0.TrialWidget:setAlpha(0)
	f20_arg0.TrialWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_262486486346EC3F"))
	f20_arg0.ZMBar:setAlpha(1)
	f20_arg0.WZBar:setAlpha(1)
	f20_arg0.TotalProgressFracText:setAlpha(1)
	f20_arg0.EmblemSubtitle:setTopBottom(0, 0, 299, 317)
	f20_arg0.MPBar:setAlpha(1)
	f20_arg0.GameModeMP:setAlpha(1)
	f20_arg0.GameModeWZ:setAlpha(1)
	f20_arg0.GameModeZM:setAlpha(1)
end
CoD.ChallengesCallingCardProfilerGlobal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(9)
			f21_arg0.CardIconLockOverlay:completeAnimation()
			f21_arg0.CardIconLockOverlay:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CardIconLockOverlay)
			f21_arg0.MasterBarBase:completeAnimation()
			f21_arg0.MasterBarBase:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.MasterBarBase)
			f21_arg0.MasterBarBorder:completeAnimation()
			f21_arg0.MasterBarBorder:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.MasterBarBorder)
			f21_arg0.MasterBar:completeAnimation()
			f21_arg0.MasterBar:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.MasterBar)
			f21_arg0.MasterFraction:completeAnimation()
			f21_arg0.MasterFraction:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.MasterFraction)
			f21_arg0.TitleBg:completeAnimation()
			f21_arg0.TitleBg:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TitleBg)
			f21_arg0.PixelGridTiledBacking:completeAnimation()
			f21_arg0.PixelGridTiledBacking:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PixelGridTiledBacking)
			f21_arg0.LockedIcon:completeAnimation()
			f21_arg0.LockedIcon:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.LockedIcon)
			f21_arg0.TrialWidget:completeAnimation()
			f21_arg0.TrialWidget:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.TrialWidget)
		end,
	},
	LockedMasterCard = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(10)
			f22_arg0.CardIconLockOverlay:completeAnimation()
			f22_arg0.CardIconLockOverlay:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CardIconLockOverlay)
			f22_arg0.EmblemSubtitle:completeAnimation()
			f22_arg0.EmblemSubtitle:setTopBottom(0, 0, 206, 224)
			f22_arg0.clipFinished(f22_arg0.EmblemSubtitle)
			f22_arg0.WZBar:completeAnimation()
			f22_arg0.WZBar:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.WZBar)
			f22_arg0.ZMBar:completeAnimation()
			f22_arg0.ZMBar:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ZMBar)
			f22_arg0.MPBar:completeAnimation()
			f22_arg0.MPBar:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.MPBar)
			f22_arg0.TotalProgressFracText:completeAnimation()
			f22_arg0.TotalProgressFracText:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.TotalProgressFracText)
			f22_arg0.GameModeZM:completeAnimation()
			f22_arg0.GameModeZM:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.GameModeZM)
			f22_arg0.GameModeWZ:completeAnimation()
			f22_arg0.GameModeWZ:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.GameModeWZ)
			f22_arg0.GameModeMP:completeAnimation()
			f22_arg0.GameModeMP:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.GameModeMP)
			f22_arg0.TrialWidget:completeAnimation()
			f22_arg0.TrialWidget.InfoText:completeAnimation()
			f22_arg0.TrialWidget:setAlpha(1)
			f22_arg0.TrialWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3B98899150D5FB25"))
			f22_arg0.clipFinished(f22_arg0.TrialWidget)
		end,
	},
	Locked = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(6)
			f23_arg0.CardIconLockOverlay:completeAnimation()
			f23_arg0.CardIconLockOverlay:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.CardIconLockOverlay)
			f23_arg0.MasterBarBase:completeAnimation()
			f23_arg0.MasterBarBase:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MasterBarBase)
			f23_arg0.MasterBarBorder:completeAnimation()
			f23_arg0.MasterBarBorder:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MasterBarBorder)
			f23_arg0.MasterBar:completeAnimation()
			f23_arg0.MasterBar:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MasterBar)
			f23_arg0.MasterFraction:completeAnimation()
			f23_arg0.MasterFraction:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.MasterFraction)
			f23_arg0.TrialWidget:completeAnimation()
			f23_arg0.TrialWidget.InfoText:completeAnimation()
			f23_arg0.TrialWidget:setAlpha(1)
			f23_arg0.TrialWidget.InfoText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3B98899150D5FB25"))
			f23_arg0.clipFinished(f23_arg0.TrialWidget)
		end,
	},
	UnlockedMasterCard = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(13)
			f24_arg0.CardIconLockOverlay:completeAnimation()
			f24_arg0.CardIconLockOverlay:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.CardIconLockOverlay)
			f24_arg0.EmblemSubtitle:completeAnimation()
			f24_arg0.EmblemSubtitle:setTopBottom(0, 0, 206, 224)
			f24_arg0.clipFinished(f24_arg0.EmblemSubtitle)
			f24_arg0.WZBar:completeAnimation()
			f24_arg0.WZBar:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.WZBar)
			f24_arg0.ZMBar:completeAnimation()
			f24_arg0.ZMBar:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ZMBar)
			f24_arg0.MPBar:completeAnimation()
			f24_arg0.MPBar:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.MPBar)
			f24_arg0.TotalProgressFracText:completeAnimation()
			f24_arg0.TotalProgressFracText:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.TotalProgressFracText)
			f24_arg0.GameModeZM:completeAnimation()
			f24_arg0.GameModeZM:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.GameModeZM)
			f24_arg0.GameModeWZ:completeAnimation()
			f24_arg0.GameModeWZ:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.GameModeWZ)
			f24_arg0.GameModeMP:completeAnimation()
			f24_arg0.GameModeMP:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.GameModeMP)
			f24_arg0.TitleBg:completeAnimation()
			f24_arg0.TitleBg:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.TitleBg)
			f24_arg0.PixelGridTiledBacking:completeAnimation()
			f24_arg0.PixelGridTiledBacking:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PixelGridTiledBacking)
			f24_arg0.LockedIcon:completeAnimation()
			f24_arg0.LockedIcon:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.LockedIcon)
			f24_arg0.TrialWidget:completeAnimation()
			f24_arg0.TrialWidget:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.TrialWidget)
		end,
	},
}
CoD.ChallengesCallingCardProfilerGlobal.__onClose = function(f25_arg0)
	f25_arg0.CardIcon:close()
	f25_arg0.Subtitle:close()
	f25_arg0.EmblemName:close()
	f25_arg0.EmblemSubtitle:close()
	f25_arg0.WZBar:close()
	f25_arg0.ZMBar:close()
	f25_arg0.MPBar:close()
	f25_arg0.TotalProgressFracText:close()
	f25_arg0.MasterBar:close()
	f25_arg0.MasterFraction:close()
	f25_arg0.LockedIcon:close()
	f25_arg0.TrialWidget:close()
end
