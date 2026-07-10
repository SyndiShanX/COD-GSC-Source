require("x64:1e4812bc9d39ec5")
require("x64:6e89585b0aec491")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:f027dcc6409e42c")
CoD.LeaguePlayEndRankUpAnim = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlayEndRankUpAnim = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlayEndRankUpAnim", f1_arg0)
	local f1_local1 = self
	CoD.ArenaLeaguePlayUtility.SetupRankUpInfo(f1_local1, f1_arg0)
	self:setClass(CoD.LeaguePlayEndRankUpAnim)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlurBg = LUI.UIImage.new(-0.5, 1.5, 0, 0, 0.5, 1.5, -540, -540)
	BlurBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BlurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBg)
	self.BlurBg = BlurBg
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.8)
	self:addElement(Backing)
	self.Backing = Backing
	local arenaLeaguePlayBg = CoD.arenaLeaguePlayBg.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(arenaLeaguePlayBg)
	self.arenaLeaguePlayBg = arenaLeaguePlayBg
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
	local MainCornerL = LUI.UIImage.new(0.5, 0.5, -784, -754, 0, 0, 146, 176)
	MainCornerL:setAlpha(0.04)
	MainCornerL:setYRot(180)
	MainCornerL:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(MainCornerL)
	self.MainCornerL = MainCornerL
	local MainCornerR = LUI.UIImage.new(0.5, 0.5, 756, 786, 0, 0, 145, 175)
	MainCornerR:setAlpha(0.04)
	MainCornerR:setImage(RegisterImage(0xBCB7451C0F2DE33))
	self:addElement(MainCornerR)
	self.MainCornerR = MainCornerR
	local LeaguePlayEndrankupAnimInternal = CoD.LeaguePlayEndrankupAnimInternal.new(f1_local1, f1_arg0, 0.5, 0.5, -300, 300, 0.5, 0.5, -400, 400)
	LeaguePlayEndrankupAnimInternal:subscribeToGlobalModel(f1_arg0, "LeaguePlay", nil, function(model)
		LeaguePlayEndrankupAnimInternal:setModel(model, f1_arg0)
	end)
	self:addElement(LeaguePlayEndrankupAnimInternal)
	self.LeaguePlayEndrankupAnimInternal = LeaguePlayEndrankupAnimInternal
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader.subtitle.subtitle:setText("")
	CommonHeader:subscribeToGlobalModel(f1_arg0, "Arena", "arenaTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, 650, 890, 0.8, 0.8, 27, 107)
	PCButton.OptionText:setText(LocalizeToUpperString(0x6393FF34EA56966))
	PCButton:linkToElementModel(self, "image", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			PCButton.Icon:setImage(RegisterImage(f7_local0))
		end
	end)
	PCButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.ArenaLeaguePlayUtility.OpenLeaguePlayRankRewardsIfPossible(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, "ui_confirm")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			CoD.ArenaLeaguePlayUtility.OpenLeaguePlayRankRewardsIfPossible(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.ArenaLeaguePlayUtility.PopulateLeaguePlayDatasources(f1_arg0)
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	if CoD.isPC then
		PCButton.id = "PCButton"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local12 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.ArenaLeaguePlayUtility.AnimateRankUp(f1_local1, f1_arg0)
	CoD.ArenaLeaguePlayUtility.SetInitialRankRubyState(f1_local1, self.LeaguePlayEndrankupAnimInternal, f1_arg0)
	return self
end
CoD.LeaguePlayEndRankUpAnim.__resetProperties = function(f16_arg0)
	f16_arg0.LeaguePlayEndrankupAnimInternal:completeAnimation()
	f16_arg0.LeaguePlayEndrankupAnimInternal:setAlpha(1)
end
CoD.LeaguePlayEndRankUpAnim.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.LeaguePlayEndrankupAnimInternal:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f17_arg0.LeaguePlayEndrankupAnimInternal:setAlpha(1)
				f17_arg0.LeaguePlayEndrankupAnimInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.LeaguePlayEndrankupAnimInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.LeaguePlayEndrankupAnimInternal:completeAnimation()
			f17_arg0.LeaguePlayEndrankupAnimInternal:setAlpha(0)
			f17_local0(f17_arg0.LeaguePlayEndrankupAnimInternal)
		end,
	},
}
CoD.LeaguePlayEndRankUpAnim.__onClose = function(f19_arg0)
	f19_arg0.arenaLeaguePlayBg:close()
	f19_arg0.FooterContainerFrontendRight:close()
	f19_arg0.LeaguePlayEndrankupAnimInternal:close()
	f19_arg0.CommonHeader:close()
	f19_arg0.BackingGrayMediumLeft:close()
	f19_arg0.PCButton:close()
end
