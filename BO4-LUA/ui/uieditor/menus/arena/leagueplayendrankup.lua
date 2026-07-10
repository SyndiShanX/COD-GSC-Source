require("x64:1e4812bc9d39ec5")
require("x64:a6546f96b82647c")
require("x64:939447bca75089e")
require("x64:262d0aefdc18620")
require("x64:d6ecdf7755aeddc")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:f027dcc6409e42c")
CoD.LeaguePlayEndRankUp = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlayEndRankUp = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlayEndRankUp", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LeaguePlayEndRankUp)
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
	local LadderRows = CoD.leaguePlayEndRankladder.new(f1_local1, f1_arg0, 0.5, 0.5, -449, 449, 0, 0, 657, 877)
	LadderRows:setAlpha(0)
	self:addElement(LadderRows)
	self.LadderRows = LadderRows
	local LeaguePlayEndrankupplacement = CoD.LeaguePlayEndrankupplacement.new(f1_local1, f1_arg0, 0.5, 0.5, -302, 302, 0.5, 0.5, -260, 90)
	self:addElement(LeaguePlayEndrankupplacement)
	self.LeaguePlayEndrankupplacement = LeaguePlayEndrankupplacement
	local leaguePlayEndRankTitle = CoD.leaguePlayEndRankTitle.new(f1_local1, f1_arg0, 0.5, 0.5, -200, 200, 0, 0, 198.5, 251.5)
	self:addElement(leaguePlayEndRankTitle)
	self.leaguePlayEndRankTitle = leaguePlayEndRankTitle
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader.subtitle.subtitle:setText("")
	CommonHeader:subscribeToGlobalModel(f1_arg0, "Arena", "arenaTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local EventEnd = LUI.UIText.new(0.5, 0.5, -150, 150, 1, 1, -224, -203)
	EventEnd:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EventEnd:setAlpha(0)
	EventEnd:setText(Engine[0xF9F1239CFD921FE](0x461D2627AF5B94))
	EventEnd:setTTF("ttmussels_regular")
	EventEnd:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	EventEnd:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(EventEnd)
	self.EventEnd = EventEnd
	local PCButton = nil
	PCButton = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, 650, 890, 0.8, 0.8, 27, 107)
	PCButton.OptionText:setText(LocalizeToUpperString(0x6393FF34EA56966))
	PCButton:linkToElementModel(self, "image", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			PCButton.Icon:setImage(RegisterImage(f6_local0))
		end
	end)
	PCButton:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCButton, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.ArenaLeaguePlayUtility.DisplayRankUpIfPossible(menu, self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCButton)
	self.PCButton = PCButton
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.ArenaLeaguePlayUtility.DisplayRankUpIfPossible(menu, self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, "ui_confirm")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		if IsPC() then
			CoD.ArenaLeaguePlayUtility.DisplayRankUpIfPossible(menu, self, controller)
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
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	LadderRows.id = "LadderRows"
	LeaguePlayEndrankupplacement.id = "LeaguePlayEndrankupplacement"
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
	local f1_local13 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.LeaguePlayEndRankUp.__resetProperties = function(f14_arg0)
	f14_arg0.leaguePlayEndRankTitle:completeAnimation()
	f14_arg0.LeaguePlayEndrankupplacement:completeAnimation()
	f14_arg0.arenaLeaguePlayBg:completeAnimation()
	f14_arg0.leaguePlayEndRankTitle:setAlpha(1)
	f14_arg0.LeaguePlayEndrankupplacement:setAlpha(1)
	f14_arg0.arenaLeaguePlayBg:setAlpha(1)
end
CoD.LeaguePlayEndRankUp.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f15_arg0.arenaLeaguePlayBg:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f15_arg0.arenaLeaguePlayBg:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.arenaLeaguePlayBg:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.arenaLeaguePlayBg:completeAnimation()
			f15_arg0.arenaLeaguePlayBg:setAlpha(1)
			f15_local0(f15_arg0.arenaLeaguePlayBg)
			local f15_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.LeaguePlayEndrankupplacement:beginAnimation(350)
				f15_arg0.LeaguePlayEndrankupplacement:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.LeaguePlayEndrankupplacement:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f15_arg0.LeaguePlayEndrankupplacement:completeAnimation()
			f15_arg0.LeaguePlayEndrankupplacement:setAlpha(0)
			f15_local1(f15_arg0.LeaguePlayEndrankupplacement)
			local f15_local2 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.leaguePlayEndRankTitle:beginAnimation(100)
				f15_arg0.leaguePlayEndRankTitle:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.leaguePlayEndRankTitle:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f15_arg0.leaguePlayEndRankTitle:completeAnimation()
			f15_arg0.leaguePlayEndRankTitle:setAlpha(0)
			f15_local2(f15_arg0.leaguePlayEndRankTitle)
		end,
	},
}
CoD.LeaguePlayEndRankUp.__onClose = function(f21_arg0)
	f21_arg0.arenaLeaguePlayBg:close()
	f21_arg0.FooterContainerFrontendRight:close()
	f21_arg0.LadderRows:close()
	f21_arg0.LeaguePlayEndrankupplacement:close()
	f21_arg0.leaguePlayEndRankTitle:close()
	f21_arg0.CommonHeader:close()
	f21_arg0.BackingGrayMediumLeft:close()
	f21_arg0.PCButton:close()
end
