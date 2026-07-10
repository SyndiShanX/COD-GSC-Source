require("x64:f0229e4dd8ebd15")
require("x64:1e4812bc9d39ec5")
require("x64:aad8c6cb8c21870")
require("x64:d6ecdf7755aeddc")
require("x64:71d2a0ed724628e")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:19c1945d2e472b0")
CoD.ArenaSkillEvaluationPlacementMenu = InheritFrom(CoD.Menu)
LUI.createMenu.ArenaSkillEvaluationPlacementMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ArenaSkillEvaluationPlacementMenu", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ArenaSkillEvaluationPlacementMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BlurBg = LUI.UIImage.new(-0.5, 1.5, 0, 0, 0, 1, 0, 0)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.8)
	self:addElement(Backing)
	self.Backing = Backing
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.BGSceneBlur:setAlpha(0)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_D762908B71F5449"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local HeaderStripe = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	HeaderStripe:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		elseif IsPC() then
			SizeToWidthOfScreen(element, f1_arg0)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(HeaderStripe)
	self.HeaderStripe = HeaderStripe
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	local AARPerformBg2 = LUI.UIImage.new(0.5, 0.5, -720, 717, 0.5, 0.5, -420, -324)
	AARPerformBg2:setAlpha(0.5)
	AARPerformBg2:setImage(RegisterImage(@"uie_ui_menu_aar_perform_repeat_bg"))
	AARPerformBg2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	AARPerformBg2:setShaderVector(0, 0, 0, 0, 0)
	AARPerformBg2:setupNineSliceShader(344, 136)
	self:addElement(AARPerformBg2)
	self.AARPerformBg2 = AARPerformBg2
	local arenaLeaguePlayBg = CoD.arenaLeaguePlayBg.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(arenaLeaguePlayBg)
	self.arenaLeaguePlayBg = arenaLeaguePlayBg
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_local1, f1_arg0, 0.5, 0.5, -720, 717, 0.5, 0.5, -324, 422)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.TiledShaderImage:setAlpha(0.5)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FuiBox02Right = LUI.UIImage.new(0.5, 0.5, 678, 712, 0.5, 0.5, -381, -415)
	FuiBox02Right:setAlpha(0.2)
	FuiBox02Right:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local TiledwhiteNoiseBacking = LUI.UIImage.new(0.5, 0.5, -720, 717, 0.5, 0.5, -420, -324)
	TiledwhiteNoiseBacking:setAlpha(0.02)
	TiledwhiteNoiseBacking:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local BGDotPatternLarge2 = LUI.UIImage.new(0.5, 0.5, -720, 717, 0.5, 0.5, -326, -322)
	BGDotPatternLarge2:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	BGDotPatternLarge2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	BGDotPatternLarge2:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge2:setupNineSliceShader(32, 4)
	self:addElement(BGDotPatternLarge2)
	self.BGDotPatternLarge2 = BGDotPatternLarge2
	local BottomBracket9Slice = LUI.UIImage.new(0.5, 0.5, -721, 718, 0.5, 0.5, 414, 422)
	BottomBracket9Slice:setAlpha(0.2)
	BottomBracket9Slice:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local Line = LUI.UIImage.new(0.5, 0.5, 275.5, 279.5, 0.5, 0.5, -240.5, 367.5)
	Line:setAlpha(0.05)
	Line:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Line:setShaderVector(0, 0, 0, 0, 0)
	Line:setupNineSliceShader(4, 8)
	self:addElement(Line)
	self.Line = Line
	local ArenaInfoWidget = CoD.ArenaInfoWidget.new(f1_local1, f1_arg0, 0.5, 0.5, 327, 676, 0.5, 0.5, -272, 363)
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge.xuid", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ArenaInfoWidget.arenaFlameStreak:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetPlayerFireStreak(f7_local0)))
		end
	end)
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge.xuid", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ArenaInfoWidget.Icon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankIconFromXuid(f8_local0)))
		end
	end)
	ArenaInfoWidget.SkillIcon.__SkillIcon_Image = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			ArenaInfoWidget.SkillIcon:setImage(RegisterImage(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerSkillDivisionIconFromXuid(f9_local0)))
		end
	end
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge.xuid", ArenaInfoWidget.SkillIcon.__SkillIcon_Image)
	ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath = function()
		local f10_local0 = DataSources.PerController.getModel(f1_arg0)
		f10_local0 = f10_local0["identityBadge.xuid"]
		if f10_local0 then
			ArenaInfoWidget.SkillIcon.__SkillIcon_Image(f10_local0)
		end
	end
	ArenaInfoWidget.Rank.__xuid = function(f11_arg0)
		local f11_local0 = f11_arg0:get()
		if f11_local0 ~= nil then
			ArenaInfoWidget.Rank:setText(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerRankFromXuid(f11_local0))
		end
	end
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge.xuid", ArenaInfoWidget.Rank.__xuid)
	ArenaInfoWidget.Rank.__xuid_FullPath = function()
		local f12_local0 = DataSources.PerController.getModel(f1_arg0)
		f12_local0 = f12_local0["identityBadge.xuid"]
		if f12_local0 then
			ArenaInfoWidget.Rank.__xuid(f12_local0)
		end
	end
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge.xuid", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ArenaInfoWidget.WinStreak.WinStreak:setText(CoD.ArenaLeaguePlayUtility.GetPlayerBestCurrentEventGameStreakFromXuid(f13_local0))
		end
	end)
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge.xuid", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			ArenaInfoWidget.Emblem:setupPlayerEmblemByXUID(f14_local0)
		end
	end)
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge", function(model)
		ArenaInfoWidget.CallingCard:setModel(model, f1_arg0)
	end)
	ArenaInfoWidget:subscribeToGlobalModel(f1_arg0, "PerController", "identityBadge.gamertag", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			ArenaInfoWidget.Name:setText(f16_local0)
		end
	end)
	self:addElement(ArenaInfoWidget)
	self.ArenaInfoWidget = ArenaInfoWidget
	local ArenaSkillEvaluationWidget = CoD.ArenaSkillEvaluationWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -721, 239, 0.5, 0.5, -356, 384)
	ArenaSkillEvaluationWidget.Bg:setAlpha(0)
	self:addElement(ArenaSkillEvaluationWidget)
	self.ArenaSkillEvaluationWidget = ArenaSkillEvaluationWidget
	local f1_local18 = ArenaInfoWidget
	local f1_local19 = ArenaInfoWidget.subscribeToModel
	local f1_local20 = DataSources.LobbyRoot.getModel(f1_arg0)
	f1_local19(f1_local18, f1_local20.lobbyNav, ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local18 = ArenaInfoWidget
	f1_local19 = ArenaInfoWidget.subscribeToModel
	f1_local20 = DataSources.LobbyRoot.getModel(f1_arg0)
	f1_local19(f1_local18, f1_local20["privateClient.update"], ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local18 = ArenaInfoWidget
	f1_local19 = ArenaInfoWidget.subscribeToModel
	f1_local20 = DataSources.LobbyRoot.getModel(f1_arg0)
	f1_local19(f1_local18, f1_local20["gameClient.update"], ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local18 = ArenaInfoWidget
	f1_local19 = ArenaInfoWidget.subscribeToModel
	f1_local20 = Engine[@"getglobalmodel"]()
	f1_local19(f1_local18, f1_local20["PartyPrivacy.privacy"], ArenaInfoWidget.SkillIcon.__SkillIcon_Image_FullPath)
	f1_local18 = ArenaInfoWidget
	f1_local19 = ArenaInfoWidget.subscribeToModel
	f1_local20 = DataSources.LobbyRoot.getModel(f1_arg0)
	f1_local19(f1_local18, f1_local20.lobbyNav, ArenaInfoWidget.Rank.__xuid_FullPath)
	f1_local18 = ArenaInfoWidget
	f1_local19 = ArenaInfoWidget.subscribeToModel
	f1_local20 = DataSources.LobbyRoot.getModel(f1_arg0)
	f1_local19(f1_local18, f1_local20["privateClient.update"], ArenaInfoWidget.Rank.__xuid_FullPath)
	f1_local18 = ArenaInfoWidget
	f1_local19 = ArenaInfoWidget.subscribeToModel
	f1_local20 = DataSources.LobbyRoot.getModel(f1_arg0)
	f1_local19(f1_local18, f1_local20["gameClient.update"], ArenaInfoWidget.Rank.__xuid_FullPath)
	f1_local18 = ArenaInfoWidget
	f1_local19 = ArenaInfoWidget.subscribeToModel
	f1_local20 = Engine[@"getglobalmodel"]()
	f1_local19(f1_local18, f1_local20["PartyPrivacy.privacy"], ArenaInfoWidget.Rank.__xuid_FullPath)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
		return true
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	ArenaInfoWidget.id = "ArenaInfoWidget"
	ArenaSkillEvaluationWidget.id = "ArenaSkillEvaluationWidget"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.ArenaSkillEvaluationPlacementMenu.__onClose = function(f19_arg0)
	f19_arg0.FooterContainerFrontendRight:close()
	f19_arg0.CommonHeader:close()
	f19_arg0.HeaderStripe:close()
	f19_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
	f19_arg0.arenaLeaguePlayBg:close()
	f19_arg0.DotTiledBacking:close()
	f19_arg0.ArenaInfoWidget:close()
	f19_arg0.ArenaSkillEvaluationWidget:close()
end
