require("x64:4dd8ed3b5fa53ee")
require("x64:1d77dc64d266f16")
require("x64:90fe125bfbaef27")
require("x64:72db0ff3759607")
require("x64:1e4812bc9d39ec5")
require("x64:77ba7854ef912d2")
require("x64:8bcba6e8ab239a2")
require("x64:d6ecdf7755aeddc")
require("x64:f00ee5237577857")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:2cf4ad39ea2c548")
CoD.LeaguePlayOverview = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlayOverview = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlayOverview", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LeaguePlayOverview)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlackBGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBGBlur:setRGB(0, 0, 0)
	BlackBGBlur:setAlpha(0)
	BlackBGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlackBGBlur:setShaderVector(0, 0.01, 0.5, 0, 0)
	self:addElement(BlackBGBlur)
	self.BlackBGBlur = BlackBGBlur
	local BlackBGOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBGOverlay:setRGB(0, 0, 0)
	BlackBGOverlay:setAlpha(0.5)
	self:addElement(BlackBGOverlay)
	self.BlackBGOverlay = BlackBGOverlay
	local ItemShopBackgroundBlur = CoD.ItemShopBackgroundBlur.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ItemShopBackgroundBlur)
	self.ItemShopBackgroundBlur = ItemShopBackgroundBlur
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
	local TopTiledBG = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -488, 475)
	TopTiledBG:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TopTiledBG:setAlpha(0.01)
	TopTiledBG:setImage(RegisterImage(0x7167D8C33A06020))
	TopTiledBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TopTiledBG:setShaderVector(0, 0, 0, 0, 0)
	TopTiledBG:setupNineSliceShader(64, 64)
	self:addElement(TopTiledBG)
	self.TopTiledBG = TopTiledBG
	local CurrentEventImage = LUI.UIImage.new(0.5, 0.5, -960, 0, 0.5, 0.5, -488.5, -96.5)
	CurrentEventImage:setAlpha(0.35)
	CurrentEventImage:setImage(RegisterImage(0x7BF16DA64DC086E))
	self:addElement(CurrentEventImage)
	self.CurrentEventImage = CurrentEventImage
	local AARPerformBg = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -489.5, -96.5)
	AARPerformBg:setAlpha(0.5)
	AARPerformBg:setImage(RegisterImage(0xF95A1671A1AB874))
	AARPerformBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	AARPerformBg:setShaderVector(0, 0, 0, 0, 0)
	AARPerformBg:setupNineSliceShader(344, 136)
	self:addElement(AARPerformBg)
	self.AARPerformBg = AARPerformBg
	local arenaLeaguePlayBg = CoD.arenaLeaguePlayBg.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(arenaLeaguePlayBg)
	self.arenaLeaguePlayBg = arenaLeaguePlayBg
	local CompetitiveOverviewProSeries = CoD.CompetitiveOverviewProSerie.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(CompetitiveOverviewProSeries)
	self.CompetitiveOverviewProSeries = CompetitiveOverviewProSeries
	local ModeRulesButton = CoD.CommonButtonGeneric.new(f1_local1, f1_arg0, 0.5, 0.5, -300, 0, 0.5, 0.5, 352, 422)
	ModeRulesButton.ButtonGeneric.MiddleText:setText(LocalizeToUpperString(0xF02855900FC19D5))
	ModeRulesButton.ButtonGeneric.MiddleTextFocus:setText(LocalizeToUpperString(0xF02855900FC19D5))
	ModeRulesButton:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(ModeRulesButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenPopup(self, "LeaguePlayGameModeRules", controller)
		PlaySoundAlias("uin_party_ease_slide")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(ModeRulesButton)
	self.ModeRulesButton = ModeRulesButton
	local ContentRulesButton = CoD.CommonButtonGeneric.new(f1_local1, f1_arg0, 0.5, 0.5, -638, -338, 0.5, 0.5, 352, 422)
	ContentRulesButton.ButtonGeneric.MiddleText:setText(LocalizeToUpperString(0xF794CE5D3A3BE33))
	ContentRulesButton.ButtonGeneric.MiddleTextFocus:setText(LocalizeToUpperString(0xF794CE5D3A3BE33))
	ContentRulesButton:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_local1:AddButtonCallbackFunction(ContentRulesButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenPopup(self, "LeaguePlayContentRules", controller)
		PlaySoundAlias("uin_party_ease_slide")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(ContentRulesButton)
	self.ContentRulesButton = ContentRulesButton
	local FuiBox02Right = LUI.UIImage.new(0.5, 0.5, 912.5, 946.5, 0.5, 0.5, -142.5, -108.5)
	FuiBox02Right:setAlpha(0.05)
	FuiBox02Right:setImage(RegisterImage(0x811A80C0AADA825))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local TiledPlusGrid = LUI.UIImage.new(0.5, 0.5, -1096, 960, 0.5, 0.5, -558, -96)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local RankRulesButton = CoD.CommonButtonGeneric.new(f1_local1, f1_arg0, 0.5, 0.5, -638, -338, 0.5, 0.5, -214, -142)
	RankRulesButton.ButtonGeneric.MiddleText:setText(LocalizeToUpperString(0xEED661A0489A4FF))
	RankRulesButton.ButtonGeneric.MiddleTextFocus:setText(LocalizeToUpperString(0xEED661A0489A4FF))
	RankRulesButton:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f9_local0
	end)
	f1_local1:AddButtonCallbackFunction(RankRulesButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenPopup(self, "LeaguePlayRankRules", controller)
		PlaySoundAlias("uin_party_ease_slide")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(RankRulesButton)
	self.RankRulesButton = RankRulesButton
	local TopTriangle = LUI.UIImage.new(0.5, 0.5, -680, -588, 0.5, 0.5, -97, -53)
	TopTriangle:setRGB(0, 0, 0)
	TopTriangle:setAlpha(0.3)
	TopTriangle:setImage(RegisterImage(0xE8103AAF0932DB4))
	self:addElement(TopTriangle)
	self.TopTriangle = TopTriangle
	local NextEventBar = LUI.UIImage.new(0.5, 0.5, 214, 218, 0.5, 0.5, -439, -139)
	NextEventBar:setAlpha(0.4)
	NextEventBar:setImage(RegisterImage(0xC082CFCA3C180E5))
	NextEventBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NextEventBar:setShaderVector(0, 0, 0, 0, 0)
	NextEventBar:setupNineSliceShader(24, 24)
	self:addElement(NextEventBar)
	self.NextEventBar = NextEventBar
	local NextEventBar2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 440, 444)
	NextEventBar2:setAlpha(0.4)
	NextEventBar2:setImage(RegisterImage(0xC082CFCA3C180E5))
	NextEventBar2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NextEventBar2:setShaderVector(0, 0, 0, 0, 0)
	NextEventBar2:setupNineSliceShader(24, 24)
	self:addElement(NextEventBar2)
	self.NextEventBar2 = NextEventBar2
	local NextEventTriangle = LUI.UIImage.new(0.5, 0.5, 147, 239, 0.5, 0.5, -311, -267)
	NextEventTriangle:setRGB(0, 0, 0)
	NextEventTriangle:setAlpha(0.4)
	NextEventTriangle:setZRot(-90)
	NextEventTriangle:setImage(RegisterImage(0xE8103AAF0932DB4))
	self:addElement(NextEventTriangle)
	self.NextEventTriangle = NextEventTriangle
	local NextEvent = CoD.LeaguePlayEventTimeInfo.new(f1_local1, f1_arg0, 0.5, 0.5, 255, 1055, 0.5, 0.5, -409, -169)
	NextEvent:mergeStateConditions({
		{
			stateName = "NextEvent",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local Header = NextEvent
	local CurrentEvent = NextEvent.subscribeToModel
	local BackingGrayMediumLeft = Engine[0x8DF2E5447F384B9]()
	CurrentEvent(Header, BackingGrayMediumLeft["lobbyPlaylist.name"], function(f13_arg0)
		f1_local1:updateElementState(NextEvent, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	Header = NextEvent
	CurrentEvent = NextEvent.subscribeToModel
	BackingGrayMediumLeft = Engine[0x8DF2E5447F384B9]()
	CurrentEvent(Header, BackingGrayMediumLeft["lobbyRoot.lobbyNav"], function(f14_arg0)
		f1_local1:updateElementState(NextEvent, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(NextEvent)
	self.NextEvent = NextEvent
	CurrentEvent = CoD.LeaguePlayEventTimeInfo.new(f1_local1, f1_arg0, 0.5, 0.5, -830, -30, 0.5, 0.5, -409, -169)
	CurrentEvent:mergeStateConditions({
		{
			stateName = "NextEvent",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	BackingGrayMediumLeft = CurrentEvent
	Header = CurrentEvent.subscribeToModel
	local SkillDivisionsButton = Engine[0x8DF2E5447F384B9]()
	Header(BackingGrayMediumLeft, SkillDivisionsButton["lobbyPlaylist.name"], function(f16_arg0)
		f1_local1:updateElementState(CurrentEvent, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	BackingGrayMediumLeft = CurrentEvent
	Header = CurrentEvent.subscribeToModel
	SkillDivisionsButton = Engine[0x8DF2E5447F384B9]()
	Header(BackingGrayMediumLeft, SkillDivisionsButton["lobbyRoot.lobbyNav"], function(f17_arg0)
		f1_local1:updateElementState(CurrentEvent, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(CurrentEvent)
	self.CurrentEvent = CurrentEvent
	Header = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	Header.subtitle.subtitle:setAlpha(0)
	Header:subscribeToGlobalModel(f1_arg0, "Arena", "arenaTitle", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			Header.subtitle.StageTitle:setText(LocalizeToUpperString(f18_local0))
		end
	end)
	Header:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			Header.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f19_local0))
		end
	end)
	Header:registerEventHandler("menu_loaded", function(element, event)
		local f20_local0 = nil
		if element.menuLoaded then
			f20_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f20_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f20_local0 then
			f20_local0 = element:dispatchEventToChildren(event)
		end
		return f20_local0
	end)
	self:addElement(Header)
	self.Header = Header
	BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f21_local0 = nil
		if element.menuLoaded then
			f21_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f21_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f21_local0 then
			f21_local0 = element:dispatchEventToChildren(event)
		end
		return f21_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	SkillDivisionsButton = CoD.CommonButtonGeneric.new(f1_local1, f1_arg0, 0.5, 0.5, -300, 0, 0.5, 0.5, -212.5, -142.5)
	SkillDivisionsButton.ButtonGeneric.MiddleText:setText(LocalizeToUpperString(0x92A27F7A5B7166D))
	SkillDivisionsButton.ButtonGeneric.MiddleTextFocus:setText(LocalizeToUpperString(0x92A27F7A5B7166D))
	SkillDivisionsButton:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f22_local0
	end)
	f1_local1:AddButtonCallbackFunction(SkillDivisionsButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		OpenPopup(self, "LeaguePlaySkillDivisionRules", controller)
		PlaySoundAlias("uin_party_ease_slide")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(SkillDivisionsButton)
	self.SkillDivisionsButton = SkillDivisionsButton
	self:mergeStateConditions({
		{
			stateName = "Unranked",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0x185075D2D3D8497])
			end,
		},
		{
			stateName = "ShowSkillDivisions",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local f1_local25 = self
	local f1_local26 = self.subscribeToModel
	local f1_local27 = Engine[0x8DF2E5447F384B9]()
	f1_local26(f1_local25, f1_local27["lobbyPlaylist.name"], function(f27_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f27_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local25 = self
	f1_local26 = self.subscribeToModel
	f1_local27 = Engine[0x8DF2E5447F384B9]()
	f1_local26(f1_local25, f1_local27["lobbyRoot.lobbyNav"], function(f28_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f28_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	CompetitiveOverviewProSeries.id = "CompetitiveOverviewProSeries"
	ModeRulesButton.id = "ModeRulesButton"
	ContentRulesButton.id = "ContentRulesButton"
	RankRulesButton.id = "RankRulesButton"
	SkillDivisionsButton.id = "SkillDivisionsButton"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = RankRulesButton
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.LeaguePlayOverview.__resetProperties = function(f32_arg0)
	f32_arg0.CompetitiveOverviewProSeries:completeAnimation()
	f32_arg0.ModeRulesButton:completeAnimation()
	f32_arg0.ContentRulesButton:completeAnimation()
	f32_arg0.AARPerformBg:completeAnimation()
	f32_arg0.CurrentEventImage:completeAnimation()
	f32_arg0.CurrentEvent:completeAnimation()
	f32_arg0.NextEvent:completeAnimation()
	f32_arg0.TopTriangle:completeAnimation()
	f32_arg0.RankRulesButton:completeAnimation()
	f32_arg0.NextEventBar:completeAnimation()
	f32_arg0.NextEventTriangle:completeAnimation()
	f32_arg0.SkillDivisionsButton:completeAnimation()
	f32_arg0.CompetitiveOverviewProSeries:setAlpha(1)
	f32_arg0.ModeRulesButton:setAlpha(1)
	f32_arg0.ContentRulesButton:setAlpha(1)
	f32_arg0.AARPerformBg:setAlpha(0.5)
	f32_arg0.CurrentEventImage:setAlpha(0.35)
	f32_arg0.CurrentEvent:setAlpha(1)
	f32_arg0.NextEvent:setAlpha(1)
	f32_arg0.TopTriangle:setAlpha(0.3)
	f32_arg0.RankRulesButton:setAlpha(1)
	f32_arg0.NextEventBar:setAlpha(0.4)
	f32_arg0.NextEventTriangle:setAlpha(0.4)
	f32_arg0.SkillDivisionsButton:setAlpha(1)
end
CoD.LeaguePlayOverview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(12)
			local f33_local0 = function(f34_arg0)
				f33_arg0.CurrentEventImage:beginAnimation(100)
				f33_arg0.CurrentEventImage:setAlpha(0.5)
				f33_arg0.CurrentEventImage:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.CurrentEventImage:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.CurrentEventImage:completeAnimation()
			f33_arg0.CurrentEventImage:setAlpha(0)
			f33_local0(f33_arg0.CurrentEventImage)
			local f33_local1 = function(f35_arg0)
				f33_arg0.AARPerformBg:beginAnimation(100)
				f33_arg0.AARPerformBg:setAlpha(0.5)
				f33_arg0.AARPerformBg:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.AARPerformBg:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
			end
			f33_arg0.AARPerformBg:completeAnimation()
			f33_arg0.AARPerformBg:setAlpha(0)
			f33_local1(f33_arg0.AARPerformBg)
			local f33_local2 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					local f37_local0 = function(f38_arg0)
						f38_arg0:beginAnimation(149)
						f38_arg0:setAlpha(1)
						f38_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
					end
					f37_arg0:beginAnimation(150)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
				end
				f33_arg0.CompetitiveOverviewProSeries:beginAnimation(50)
				f33_arg0.CompetitiveOverviewProSeries:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.CompetitiveOverviewProSeries:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f33_arg0.CompetitiveOverviewProSeries:completeAnimation()
			f33_arg0.CompetitiveOverviewProSeries:setAlpha(0)
			f33_local2(f33_arg0.CompetitiveOverviewProSeries)
			local f33_local3 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						f41_arg0:beginAnimation(150)
						f41_arg0:setAlpha(1)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
					end
					f40_arg0:beginAnimation(200)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f33_arg0.ModeRulesButton:beginAnimation(50)
				f33_arg0.ModeRulesButton:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.ModeRulesButton:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f33_arg0.ModeRulesButton:completeAnimation()
			f33_arg0.ModeRulesButton:setAlpha(0)
			f33_local3(f33_arg0.ModeRulesButton)
			local f33_local4 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(149)
						f44_arg0:setAlpha(1)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(180)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f33_arg0.ContentRulesButton:beginAnimation(50)
				f33_arg0.ContentRulesButton:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.ContentRulesButton:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f33_arg0.ContentRulesButton:completeAnimation()
			f33_arg0.ContentRulesButton:setAlpha(0)
			f33_local4(f33_arg0.ContentRulesButton)
			local f33_local5 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(150)
					f46_arg0:setAlpha(1)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.RankRulesButton:beginAnimation(80)
				f33_arg0.RankRulesButton:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.RankRulesButton:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f33_arg0.RankRulesButton:completeAnimation()
			f33_arg0.RankRulesButton:setAlpha(0)
			f33_local5(f33_arg0.RankRulesButton)
			local f33_local6 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					f48_arg0:beginAnimation(150)
					f48_arg0:setAlpha(0.3)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.TopTriangle:beginAnimation(80)
				f33_arg0.TopTriangle:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.TopTriangle:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f33_arg0.TopTriangle:completeAnimation()
			f33_arg0.TopTriangle:setAlpha(0)
			f33_local6(f33_arg0.TopTriangle)
			local f33_local7 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(150)
					f50_arg0:setAlpha(0.4)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.NextEventBar:beginAnimation(130)
				f33_arg0.NextEventBar:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.NextEventBar:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f33_arg0.NextEventBar:completeAnimation()
			f33_arg0.NextEventBar:setAlpha(0)
			f33_local7(f33_arg0.NextEventBar)
			local f33_local8 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(150)
					f52_arg0:setAlpha(0.4)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.NextEventTriangle:beginAnimation(130)
				f33_arg0.NextEventTriangle:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.NextEventTriangle:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f33_arg0.NextEventTriangle:completeAnimation()
			f33_arg0.NextEventTriangle:setAlpha(0)
			f33_local8(f33_arg0.NextEventTriangle)
			local f33_local9 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					f54_arg0:beginAnimation(150)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.NextEvent:beginAnimation(130)
				f33_arg0.NextEvent:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.NextEvent:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f33_arg0.NextEvent:completeAnimation()
			f33_arg0.NextEvent:setAlpha(0)
			f33_local9(f33_arg0.NextEvent)
			local f33_local10 = function(f55_arg0)
				local f55_local0 = function(f56_arg0)
					f56_arg0:beginAnimation(150)
					f56_arg0:setAlpha(1)
					f56_arg0:registerEventHandler("transition_complete_keyframe", f33_arg0.clipFinished)
				end
				f33_arg0.CurrentEvent:beginAnimation(80)
				f33_arg0.CurrentEvent:registerEventHandler("interrupted_keyframe", f33_arg0.clipInterrupted)
				f33_arg0.CurrentEvent:registerEventHandler("transition_complete_keyframe", f55_local0)
			end
			f33_arg0.CurrentEvent:completeAnimation()
			f33_arg0.CurrentEvent:setAlpha(0)
			f33_local10(f33_arg0.CurrentEvent)
			f33_arg0.SkillDivisionsButton:completeAnimation()
			f33_arg0.SkillDivisionsButton:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.SkillDivisionsButton)
		end,
	},
	Unranked = {
		DefaultClip = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(12)
			local f57_local0 = function(f58_arg0)
				f57_arg0.CurrentEventImage:beginAnimation(100)
				f57_arg0.CurrentEventImage:setAlpha(0.5)
				f57_arg0.CurrentEventImage:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.CurrentEventImage:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.CurrentEventImage:completeAnimation()
			f57_arg0.CurrentEventImage:setAlpha(0)
			f57_local0(f57_arg0.CurrentEventImage)
			local f57_local1 = function(f59_arg0)
				f57_arg0.AARPerformBg:beginAnimation(100)
				f57_arg0.AARPerformBg:setAlpha(0.5)
				f57_arg0.AARPerformBg:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.AARPerformBg:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
			end
			f57_arg0.AARPerformBg:completeAnimation()
			f57_arg0.AARPerformBg:setAlpha(0)
			f57_local1(f57_arg0.AARPerformBg)
			local f57_local2 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					local f61_local0 = function(f62_arg0)
						f62_arg0:beginAnimation(149)
						f62_arg0:setAlpha(1)
						f62_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
					end
					f61_arg0:beginAnimation(150)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
				end
				f57_arg0.CompetitiveOverviewProSeries:beginAnimation(50)
				f57_arg0.CompetitiveOverviewProSeries:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.CompetitiveOverviewProSeries:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f57_arg0.CompetitiveOverviewProSeries:completeAnimation()
			f57_arg0.CompetitiveOverviewProSeries:setAlpha(0)
			f57_local2(f57_arg0.CompetitiveOverviewProSeries)
			local f57_local3 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					local f64_local0 = function(f65_arg0)
						f65_arg0:beginAnimation(150)
						f65_arg0:setAlpha(1)
						f65_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
					end
					f64_arg0:beginAnimation(200)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
				end
				f57_arg0.ModeRulesButton:beginAnimation(50)
				f57_arg0.ModeRulesButton:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.ModeRulesButton:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f57_arg0.ModeRulesButton:completeAnimation()
			f57_arg0.ModeRulesButton:setAlpha(0)
			f57_local3(f57_arg0.ModeRulesButton)
			local f57_local4 = function(f66_arg0)
				local f66_local0 = function(f67_arg0)
					local f67_local0 = function(f68_arg0)
						f68_arg0:beginAnimation(149)
						f68_arg0:setAlpha(1)
						f68_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
					end
					f67_arg0:beginAnimation(180)
					f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
				end
				f57_arg0.ContentRulesButton:beginAnimation(50)
				f57_arg0.ContentRulesButton:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.ContentRulesButton:registerEventHandler("transition_complete_keyframe", f66_local0)
			end
			f57_arg0.ContentRulesButton:completeAnimation()
			f57_arg0.ContentRulesButton:setAlpha(0)
			f57_local4(f57_arg0.ContentRulesButton)
			f57_arg0.RankRulesButton:completeAnimation()
			f57_arg0.RankRulesButton:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.RankRulesButton)
			local f57_local5 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					f70_arg0:beginAnimation(150)
					f70_arg0:setAlpha(0.3)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
				end
				f57_arg0.TopTriangle:beginAnimation(80)
				f57_arg0.TopTriangle:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.TopTriangle:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f57_arg0.TopTriangle:completeAnimation()
			f57_arg0.TopTriangle:setAlpha(0)
			f57_local5(f57_arg0.TopTriangle)
			local f57_local6 = function(f71_arg0)
				local f71_local0 = function(f72_arg0)
					f72_arg0:beginAnimation(150)
					f72_arg0:setAlpha(0.4)
					f72_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
				end
				f57_arg0.NextEventBar:beginAnimation(130)
				f57_arg0.NextEventBar:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.NextEventBar:registerEventHandler("transition_complete_keyframe", f71_local0)
			end
			f57_arg0.NextEventBar:completeAnimation()
			f57_arg0.NextEventBar:setAlpha(0)
			f57_local6(f57_arg0.NextEventBar)
			local f57_local7 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					f74_arg0:beginAnimation(150)
					f74_arg0:setAlpha(0.4)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
				end
				f57_arg0.NextEventTriangle:beginAnimation(130)
				f57_arg0.NextEventTriangle:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.NextEventTriangle:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f57_arg0.NextEventTriangle:completeAnimation()
			f57_arg0.NextEventTriangle:setAlpha(0)
			f57_local7(f57_arg0.NextEventTriangle)
			local f57_local8 = function(f75_arg0)
				local f75_local0 = function(f76_arg0)
					f76_arg0:beginAnimation(150)
					f76_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
				end
				f57_arg0.NextEvent:beginAnimation(130)
				f57_arg0.NextEvent:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.NextEvent:registerEventHandler("transition_complete_keyframe", f75_local0)
			end
			f57_arg0.NextEvent:completeAnimation()
			f57_arg0.NextEvent:setAlpha(0)
			f57_local8(f57_arg0.NextEvent)
			local f57_local9 = function(f77_arg0)
				local f77_local0 = function(f78_arg0)
					f78_arg0:beginAnimation(150)
					f78_arg0:setAlpha(1)
					f78_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
				end
				f57_arg0.CurrentEvent:beginAnimation(80)
				f57_arg0.CurrentEvent:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.CurrentEvent:registerEventHandler("transition_complete_keyframe", f77_local0)
			end
			f57_arg0.CurrentEvent:completeAnimation()
			f57_arg0.CurrentEvent:setAlpha(0)
			f57_local9(f57_arg0.CurrentEvent)
			f57_arg0.SkillDivisionsButton:completeAnimation()
			f57_arg0.SkillDivisionsButton:setAlpha(0)
			f57_arg0.clipFinished(f57_arg0.SkillDivisionsButton)
		end,
	},
	ShowSkillDivisions = {
		DefaultClip = function(f79_arg0, f79_arg1)
			f79_arg0:__resetProperties()
			f79_arg0:setupElementClipCounter(12)
			local f79_local0 = function(f80_arg0)
				f79_arg0.CurrentEventImage:beginAnimation(100)
				f79_arg0.CurrentEventImage:setAlpha(0.5)
				f79_arg0.CurrentEventImage:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.CurrentEventImage:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
			end
			f79_arg0.CurrentEventImage:completeAnimation()
			f79_arg0.CurrentEventImage:setAlpha(0)
			f79_local0(f79_arg0.CurrentEventImage)
			local f79_local1 = function(f81_arg0)
				f79_arg0.AARPerformBg:beginAnimation(100)
				f79_arg0.AARPerformBg:setAlpha(0.5)
				f79_arg0.AARPerformBg:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.AARPerformBg:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
			end
			f79_arg0.AARPerformBg:completeAnimation()
			f79_arg0.AARPerformBg:setAlpha(0)
			f79_local1(f79_arg0.AARPerformBg)
			local f79_local2 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					local f83_local0 = function(f84_arg0)
						f84_arg0:beginAnimation(149)
						f84_arg0:setAlpha(1)
						f84_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
					end
					f83_arg0:beginAnimation(150)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
				end
				f79_arg0.CompetitiveOverviewProSeries:beginAnimation(50)
				f79_arg0.CompetitiveOverviewProSeries:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.CompetitiveOverviewProSeries:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f79_arg0.CompetitiveOverviewProSeries:completeAnimation()
			f79_arg0.CompetitiveOverviewProSeries:setAlpha(0)
			f79_local2(f79_arg0.CompetitiveOverviewProSeries)
			local f79_local3 = function(f85_arg0)
				local f85_local0 = function(f86_arg0)
					local f86_local0 = function(f87_arg0)
						f87_arg0:beginAnimation(150)
						f87_arg0:setAlpha(1)
						f87_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
					end
					f86_arg0:beginAnimation(200)
					f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
				end
				f79_arg0.ModeRulesButton:beginAnimation(50)
				f79_arg0.ModeRulesButton:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.ModeRulesButton:registerEventHandler("transition_complete_keyframe", f85_local0)
			end
			f79_arg0.ModeRulesButton:completeAnimation()
			f79_arg0.ModeRulesButton:setAlpha(0)
			f79_local3(f79_arg0.ModeRulesButton)
			local f79_local4 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					local f89_local0 = function(f90_arg0)
						f90_arg0:beginAnimation(149)
						f90_arg0:setAlpha(1)
						f90_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
					end
					f89_arg0:beginAnimation(180)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
				end
				f79_arg0.ContentRulesButton:beginAnimation(50)
				f79_arg0.ContentRulesButton:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.ContentRulesButton:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f79_arg0.ContentRulesButton:completeAnimation()
			f79_arg0.ContentRulesButton:setAlpha(0)
			f79_local4(f79_arg0.ContentRulesButton)
			local f79_local5 = function(f91_arg0)
				local f91_local0 = function(f92_arg0)
					f92_arg0:beginAnimation(150)
					f92_arg0:setAlpha(1)
					f92_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f79_arg0.RankRulesButton:beginAnimation(80)
				f79_arg0.RankRulesButton:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.RankRulesButton:registerEventHandler("transition_complete_keyframe", f91_local0)
			end
			f79_arg0.RankRulesButton:completeAnimation()
			f79_arg0.RankRulesButton:setAlpha(0)
			f79_local5(f79_arg0.RankRulesButton)
			local f79_local6 = function(f93_arg0)
				local f93_local0 = function(f94_arg0)
					f94_arg0:beginAnimation(150)
					f94_arg0:setAlpha(0.3)
					f94_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f79_arg0.TopTriangle:beginAnimation(80)
				f79_arg0.TopTriangle:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.TopTriangle:registerEventHandler("transition_complete_keyframe", f93_local0)
			end
			f79_arg0.TopTriangle:completeAnimation()
			f79_arg0.TopTriangle:setAlpha(0)
			f79_local6(f79_arg0.TopTriangle)
			local f79_local7 = function(f95_arg0)
				local f95_local0 = function(f96_arg0)
					f96_arg0:beginAnimation(150)
					f96_arg0:setAlpha(0.4)
					f96_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f79_arg0.NextEventBar:beginAnimation(130)
				f79_arg0.NextEventBar:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.NextEventBar:registerEventHandler("transition_complete_keyframe", f95_local0)
			end
			f79_arg0.NextEventBar:completeAnimation()
			f79_arg0.NextEventBar:setAlpha(0)
			f79_local7(f79_arg0.NextEventBar)
			local f79_local8 = function(f97_arg0)
				local f97_local0 = function(f98_arg0)
					f98_arg0:beginAnimation(150)
					f98_arg0:setAlpha(0.4)
					f98_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f79_arg0.NextEventTriangle:beginAnimation(130)
				f79_arg0.NextEventTriangle:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.NextEventTriangle:registerEventHandler("transition_complete_keyframe", f97_local0)
			end
			f79_arg0.NextEventTriangle:completeAnimation()
			f79_arg0.NextEventTriangle:setAlpha(0)
			f79_local8(f79_arg0.NextEventTriangle)
			local f79_local9 = function(f99_arg0)
				local f99_local0 = function(f100_arg0)
					f100_arg0:beginAnimation(150)
					f100_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f79_arg0.NextEvent:beginAnimation(130)
				f79_arg0.NextEvent:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.NextEvent:registerEventHandler("transition_complete_keyframe", f99_local0)
			end
			f79_arg0.NextEvent:completeAnimation()
			f79_arg0.NextEvent:setAlpha(0)
			f79_local9(f79_arg0.NextEvent)
			local f79_local10 = function(f101_arg0)
				local f101_local0 = function(f102_arg0)
					f102_arg0:beginAnimation(150)
					f102_arg0:setAlpha(1)
					f102_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f79_arg0.CurrentEvent:beginAnimation(80)
				f79_arg0.CurrentEvent:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.CurrentEvent:registerEventHandler("transition_complete_keyframe", f101_local0)
			end
			f79_arg0.CurrentEvent:completeAnimation()
			f79_arg0.CurrentEvent:setAlpha(0)
			f79_local10(f79_arg0.CurrentEvent)
			local f79_local11 = function(f103_arg0)
				local f103_local0 = function(f104_arg0)
					f104_arg0:beginAnimation(150)
					f104_arg0:setAlpha(1)
					f104_arg0:registerEventHandler("transition_complete_keyframe", f79_arg0.clipFinished)
				end
				f79_arg0.SkillDivisionsButton:beginAnimation(80)
				f79_arg0.SkillDivisionsButton:registerEventHandler("interrupted_keyframe", f79_arg0.clipInterrupted)
				f79_arg0.SkillDivisionsButton:registerEventHandler("transition_complete_keyframe", f103_local0)
			end
			f79_arg0.SkillDivisionsButton:completeAnimation()
			f79_arg0.SkillDivisionsButton:setAlpha(0)
			f79_local11(f79_arg0.SkillDivisionsButton)
		end,
	},
}
CoD.LeaguePlayOverview.__onClose = function(f105_arg0)
	f105_arg0.ItemShopBackgroundBlur:close()
	f105_arg0.FooterContainerFrontendRight:close()
	f105_arg0.arenaLeaguePlayBg:close()
	f105_arg0.CompetitiveOverviewProSeries:close()
	f105_arg0.ModeRulesButton:close()
	f105_arg0.ContentRulesButton:close()
	f105_arg0.RankRulesButton:close()
	f105_arg0.NextEvent:close()
	f105_arg0.CurrentEvent:close()
	f105_arg0.Header:close()
	f105_arg0.BackingGrayMediumLeft:close()
	f105_arg0.SkillDivisionsButton:close()
end
