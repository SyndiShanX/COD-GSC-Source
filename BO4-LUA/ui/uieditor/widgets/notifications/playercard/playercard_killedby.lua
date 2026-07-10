require("x64:7aa6f93320ca609")
require("x64:efce9ac22be8e9f")
require("x64:e201e7e41431aa7")
require("x64:3e7363f43bb91")
require("x64:1d8e482adfc7305")
require("x64:8d3de31d16f3fdf")
CoD.PlayerCard_KilledBy = InheritFrom(LUI.UIElement)
CoD.PlayerCard_KilledBy.__defaultWidth = 462
CoD.PlayerCard_KilledBy.__defaultHeight = 90
CoD.PlayerCard_KilledBy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerCard_KilledBy)
	self.id = "PlayerCard_KilledBy"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeroShot = LUI.UIFixedAspectRatioImage.new(0, 0, 438, 562, 0.5, 0.5, -86, 86)
	HeroShot.__Image = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			HeroShot:setImage(RegisterImage(GetPositionDraftIconByIndex(f2_local0)))
		end
	end
	HeroShot:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model, f3_arg1)
		if f3_arg1["__HeroShot.__Image_predictedClientModel->characterIndex"] then
			f3_arg1:removeSubscription(f3_arg1["__HeroShot.__Image_predictedClientModel->characterIndex"])
			f3_arg1["__HeroShot.__Image_predictedClientModel->characterIndex"] = nil
		end
		if model then
			local f3_local0 = model:get()
			local f3_local1 = model:get()
			model = f3_local0 and f3_local1.characterIndex
		end
		if model then
			f3_arg1["__HeroShot.__Image_predictedClientModel->characterIndex"] = f3_arg1:subscribeToModel(model, HeroShot.__Image)
		end
	end)
	self:addElement(HeroShot)
	self.HeroShot = HeroShot
	local CallingCardImage = CoD.CallingCards_BasicImage.new(f1_arg0, f1_arg1, 0, 0, 138, 456, 0, 0, 3, 85)
	self:addElement(CallingCardImage)
	self.CallingCardImage = CallingCardImage
	local LeftPanel = CoD.FE_ButtonPanelShaderContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 136, 0, 0, 3, 85)
	LeftPanel:setRGB(0.5, 0.5, 0.5)
	self:addElement(LeftPanel)
	self.LeftPanel = LeftPanel
	local Top3PlayerScoreBlurBox0 = CoD.Top3PlayerScoreBlurBox.new(f1_arg0, f1_arg1, 0, 0, 0, 136, 0, 0, 3, 85)
	Top3PlayerScoreBlurBox0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scene_blur_pass_2_highquality"))
	Top3PlayerScoreBlurBox0:setShaderVector(0, 10, 10, 0, 0)
	self:addElement(Top3PlayerScoreBlurBox0)
	self.Top3PlayerScoreBlurBox0 = Top3PlayerScoreBlurBox0
	local VSpanel = CoD.FE_ButtonPanel.new(f1_arg0, f1_arg1, 0, 0, 0, 136, 0, 0, 3, 85)
	VSpanel:setRGB(0, 0, 0)
	VSpanel:setAlpha(0.5)
	self:addElement(VSpanel)
	self.VSpanel = VSpanel
	local Panel = CoD.FE_PanelNoBlur.new(f1_arg0, f1_arg1, 0, 0, 139, 205, 0, 0, 41, 71)
	Panel:setRGB(0, 0, 0)
	Panel:setAlpha(0.6)
	self:addElement(Panel)
	self.Panel = Panel
	local ClanTag = CoD.PlayerCard_Label.new(f1_arg0, f1_arg1, 0, 0, 138, 209, 0, 0, 39, 67)
	ClanTag.Panel:setAlpha(0.6)
	ClanTag:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByEntNum", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ClanTag:setAlpha(HideIfEmptyString(f4_local0))
		end
	end)
	ClanTag:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByEntNum", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ClanTag.itemName:setText(GetClientClantag(f1_arg1, f5_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(ClanTag, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 1)
	end)
	self:addElement(ClanTag)
	self.ClanTag = ClanTag
	local HeroBacking = LUI.UIImage.new(0, 0, -3, 93, 0, 0, -12, 96)
	HeroBacking:setAlpha(0)
	HeroBacking:setImage(RegisterImage(@"uie_img_t7_hud_widget_playercard_playerbacking"))
	HeroBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(HeroBacking)
	self.HeroBacking = HeroBacking
	local PlayerEmblem = LUI.UIImage.new(0, 0, 0, 136, 0, 0, 3, 85)
	self:addElement(PlayerEmblem)
	self.PlayerEmblem = PlayerEmblem
	local TopLeftPip = LUI.UIImage.new(0, 0, -29, -5, 0, 0, -4, 8)
	TopLeftPip:setImage(RegisterImage(@"uie_t7_menu_cac_pixelblurred"))
	TopLeftPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopLeftPip)
	self.TopLeftPip = TopLeftPip
	local BotLeftPip = LUI.UIImage.new(0, 0, -29, -5, 0, 0, 80, 92)
	BotLeftPip:setImage(RegisterImage(@"uie_t7_menu_cac_pixelblurred"))
	BotLeftPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BotLeftPip)
	self.BotLeftPip = BotLeftPip
	local TopRightPip = LUI.UIImage.new(0, 0, 459, 483, 0, 0, -3, 9)
	TopRightPip:setZRot(180)
	TopRightPip:setImage(RegisterImage(@"uie_t7_menu_cac_pixelblurred"))
	TopRightPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopRightPip)
	self.TopRightPip = TopRightPip
	local BotRightPip = LUI.UIImage.new(0, 0, 459, 483, 0, 0, 80, 92)
	BotRightPip:setZRot(180)
	BotRightPip:setImage(RegisterImage(@"uie_t7_menu_cac_pixelblurred"))
	BotRightPip:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BotRightPip)
	self.BotRightPip = BotRightPip
	local NameText = LUI.UIText.new(0, 0, 139, 339, 0, 0, 5, 35)
	NameText:setTTF("notosans_bold")
	NameText:setLetterSpacing(1)
	NameText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NameText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	NameText:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByEntNum", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			NameText:setText(CoD.SocialUtility.CleanGamerTag(GetClientName(f1_arg1, f7_local0)))
		end
	end)
	self:addElement(NameText)
	self.NameText = NameText
	self:mergeStateConditions({
		{
			stateName = "HideHeroShot",
			condition = function(menu, element, event)
				return not CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
			end,
		},
		{
			stateName = "Emblem",
			condition = function(menu, element, event)
				return not IsLobbyNetworkModeLAN()
			end,
		},
		{
			stateName = "Calingcard",
			condition = function(menu, element, event)
				return IsLobbyNetworkModeLAN()
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local16(f1_local15, f1_local17["hudItems.showSpawnSelect"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[@"getglobalmodel"]()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.killedByEntNum", function(model)
		local f13_local0 = self
		CoD.DeathCamUtility.SetKilledByPlayerVisuals(self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerCard_KilledBy.__resetProperties = function(f14_arg0)
	f14_arg0.HeroShot:completeAnimation()
	f14_arg0.LeftPanel:completeAnimation()
	f14_arg0.BotRightPip:completeAnimation()
	f14_arg0.TopRightPip:completeAnimation()
	f14_arg0.ClanTag:completeAnimation()
	f14_arg0.PlayerEmblem:completeAnimation()
	f14_arg0.HeroBacking:completeAnimation()
	f14_arg0.BotLeftPip:completeAnimation()
	f14_arg0.TopLeftPip:completeAnimation()
	f14_arg0.HeroShot:setAlpha(1)
	f14_arg0.LeftPanel:setLeftRight(0, 0, 0, 136)
	f14_arg0.LeftPanel:setTopBottom(0, 0, 3, 85)
	f14_arg0.LeftPanel:setAlpha(1)
	f14_arg0.BotRightPip:setLeftRight(0, 0, 459, 483)
	f14_arg0.BotRightPip:setTopBottom(0, 0, 80, 92)
	f14_arg0.TopRightPip:setLeftRight(0, 0, 459, 483)
	f14_arg0.TopRightPip:setTopBottom(0, 0, -3, 9)
	f14_arg0.ClanTag:setLeftRight(0, 0, 138, 209)
	f14_arg0.ClanTag:setTopBottom(0, 0, 39, 67)
	f14_arg0.PlayerEmblem:setLeftRight(0, 0, 0, 136)
	f14_arg0.PlayerEmblem:setTopBottom(0, 0, 3, 85)
	f14_arg0.PlayerEmblem:setAlpha(1)
	f14_arg0.HeroBacking:setLeftRight(0, 0, -3, 93)
	f14_arg0.HeroBacking:setTopBottom(0, 0, -12, 96)
	f14_arg0.BotLeftPip:setLeftRight(0, 0, -29, -5)
	f14_arg0.BotLeftPip:setTopBottom(0, 0, 80, 92)
	f14_arg0.TopLeftPip:setLeftRight(0, 0, -29, -5)
	f14_arg0.TopLeftPip:setTopBottom(0, 0, -4, 8)
end
CoD.PlayerCard_KilledBy.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	HideHeroShot = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.HeroShot:completeAnimation()
			f16_arg0.HeroShot:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.HeroShot)
		end,
	},
	Emblem = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.LeftPanel:completeAnimation()
			f17_arg0.LeftPanel:setLeftRight(0, 0, 0, 136)
			f17_arg0.LeftPanel:setTopBottom(0, 0, 3.5, 84.5)
			f17_arg0.clipFinished(f17_arg0.LeftPanel)
		end,
	},
	Calingcard = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(8)
			f18_arg0.LeftPanel:completeAnimation()
			f18_arg0.LeftPanel:setLeftRight(0, 0, 132, 268)
			f18_arg0.LeftPanel:setTopBottom(0, 0, 3, 85)
			f18_arg0.LeftPanel:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.LeftPanel)
			f18_arg0.ClanTag:completeAnimation()
			f18_arg0.ClanTag:setLeftRight(0, 0, 135, 206)
			f18_arg0.ClanTag:setTopBottom(0, 0, 39, 69)
			f18_arg0.clipFinished(f18_arg0.ClanTag)
			f18_arg0.HeroBacking:completeAnimation()
			f18_arg0.HeroBacking:setLeftRight(0, 0, 127, 223)
			f18_arg0.HeroBacking:setTopBottom(0, 0, -12, 96)
			f18_arg0.clipFinished(f18_arg0.HeroBacking)
			f18_arg0.PlayerEmblem:completeAnimation()
			f18_arg0.PlayerEmblem:setLeftRight(0, 0, 132, 268)
			f18_arg0.PlayerEmblem:setTopBottom(0, 0, 3, 85)
			f18_arg0.PlayerEmblem:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.PlayerEmblem)
			f18_arg0.TopLeftPip:completeAnimation()
			f18_arg0.TopLeftPip:setLeftRight(0, 0, 109, 133)
			f18_arg0.TopLeftPip:setTopBottom(0, 0, -4, 8)
			f18_arg0.clipFinished(f18_arg0.TopLeftPip)
			f18_arg0.BotLeftPip:completeAnimation()
			f18_arg0.BotLeftPip:setLeftRight(0, 0, 109, 133)
			f18_arg0.BotLeftPip:setTopBottom(0, 0, 80, 92)
			f18_arg0.clipFinished(f18_arg0.BotLeftPip)
			f18_arg0.TopRightPip:completeAnimation()
			f18_arg0.TopRightPip:setLeftRight(0, 0, 455, 479)
			f18_arg0.TopRightPip:setTopBottom(0, 0, -3, 9)
			f18_arg0.clipFinished(f18_arg0.TopRightPip)
			f18_arg0.BotRightPip:completeAnimation()
			f18_arg0.BotRightPip:setLeftRight(0, 0, 455, 479)
			f18_arg0.BotRightPip:setTopBottom(0, 0, 80, 92)
			f18_arg0.clipFinished(f18_arg0.BotRightPip)
		end,
	},
}
CoD.PlayerCard_KilledBy.__onClose = function(f19_arg0)
	f19_arg0.HeroShot:close()
	f19_arg0.CallingCardImage:close()
	f19_arg0.LeftPanel:close()
	f19_arg0.Top3PlayerScoreBlurBox0:close()
	f19_arg0.VSpanel:close()
	f19_arg0.Panel:close()
	f19_arg0.ClanTag:close()
	f19_arg0.NameText:close()
end
