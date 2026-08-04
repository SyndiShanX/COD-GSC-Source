require("x64:a53799ae85f0491")
require("ui/uieditor/widgets/lobby/common/layoutelements/commonbglayoutelement02")
require("ui/uieditor/widgets/scoreboard/tabbedscoreboardfuibox")
require("ui/uieditor/widgets/startmenu/startmenu_button_callingcards")
require("ui/uieditor/widgets/startmenu/startmenu_button_emblem")
require("ui/uieditor/widgets/startmenu/startmenu_button_hero")
require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_button_lg")
CoD.StartMenu_Identity = InheritFrom(LUI.UIElement)
CoD.StartMenu_Identity.__defaultWidth = 1920
CoD.StartMenu_Identity.__defaultHeight = 780
CoD.StartMenu_Identity.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "CallingCardsIdentity.DataDownloaded")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "CallingCardsIdentity.GetPublicProfileComplete")
	self:setClass(CoD.StartMenu_Identity)
	self.id = "StartMenu_Identity"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EmblemEditor = CoD.StartMenu_Button_Hero.new(f1_arg0, f1_arg1, 0.5, 0.5, -564, 108, 0.5, 0.5, -341, -11)
	EmblemEditor:mergeStateConditions({
		{
			stateName = "WZTrialUpsell",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestone(f1_arg1)
			end,
		},
		{
			stateName = "OnlineOnly",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.Emblems_IsEnabled(element, f1_arg1)
			end,
		},
		{
			stateName = "ComingSoon",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "UGCDisabled",
			condition = function(menu, element, event)
				return IsUserContentRestricted(f1_arg1)
			end,
		},
	})
	EmblemEditor.ButtonInternal.imageContainer.ImageContainer:setImage(RegisterImage("uie_ui_menu_start_menu_emblem"))
	EmblemEditor.ButtonInternal.Title:setText("")
	EmblemEditor.ButtonInternal.Subtitle.SubtitleText:setText(LocalizeHash("menu/emblem_editor_caps"))
	local Emblems = EmblemEditor
	local Paintshop = EmblemEditor.subscribeToModel
	local CallingCards = Engine.GetGlobalModel()
	Paintshop(Emblems, CallingCards["lobbyRoot.lobbyNetworkMode"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	Emblems = EmblemEditor
	Paintshop = EmblemEditor.subscribeToModel
	CallingCards = Engine.GetGlobalModel()
	Paintshop(Emblems, CallingCards["lobbyRoot.lobbyNav"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	EmblemEditor:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(EmblemEditor, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		if IsGameTrial() then
			OpenPopup(self, "WZTrialUpsellPopup", f10_arg2, nil)
			return true
		elseif IsLive() and not IsUserContentRestricted(f10_arg2) then
			OpenEmblemSelect(self, f10_arg0, f10_arg2, Enum.StorageFileType[@"storage_emblems"], f10_arg1, "true")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f11_arg0, f11_arg1, f11_arg2)
		if IsGameTrial() then
			CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsLive() and not IsUserContentRestricted(f11_arg2) then
			CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(EmblemEditor)
	self.EmblemEditor = EmblemEditor
	Paintshop = CoD.StartMenu_Button_Hero.new(f1_arg0, f1_arg1, 0.5, 0.5, -564, 108, 0.5, 0.5, 15.5, 346.5)
	Paintshop:mergeStateConditions({
		{
			stateName = "WZTrialUpsell",
			condition = function(menu, element, event)
				return IsGameTrial()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestone(f1_arg1)
			end,
		},
		{
			stateName = "OnlineOnly",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.Paintjobs_IsEnabled(element, f1_arg1)
			end,
		},
		{
			stateName = "ComingSoon",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "UGCDisabled",
			condition = function(menu, element, event)
				return IsUserContentRestricted(f1_arg1)
			end,
		},
	})
	Paintshop.ButtonInternal.imageContainer.ImageContainer:setImage(RegisterImage("uie_ui_menu_start_menu_paintshop"))
	Paintshop.ButtonInternal.Title:setText("")
	Paintshop.ButtonInternal.Subtitle.SubtitleText:setText(LocalizeHash("menu/paintshop_caps"))
	CallingCards = Paintshop
	Emblems = Paintshop.subscribeToModel
	local f1_local5 = Engine.GetGlobalModel()
	Emblems(CallingCards, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	CallingCards = Paintshop
	Emblems = Paintshop.subscribeToModel
	f1_local5 = Engine.GetGlobalModel()
	Emblems(CallingCards, f1_local5["lobbyRoot.lobbyNav"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	Paintshop:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Paintshop, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
		if IsGameTrial() then
			OpenPopup(self, "WZTrialUpsellPopup", f20_arg2, nil)
			return true
		elseif IsLive() and not IsUserContentRestricted(f20_arg2) and IsInDefaultState(f20_arg0) then
			CoD.CraftUtility.OpenPaintjobWeaponSelection(self, f20_arg0, f20_arg2, "", f20_arg1)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f21_arg0, f21_arg1, f21_arg2)
		if IsGameTrial() then
			CoD.Menu.SetButtonLabel(f21_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif IsLive() and not IsUserContentRestricted(f21_arg2) and IsInDefaultState(f21_arg0) then
			CoD.Menu.SetButtonLabel(f21_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Paintshop)
	self.Paintshop = Paintshop
	Emblems = CoD.StartMenu_Button_Emblem.new(f1_arg0, f1_arg1, 0.5, 0.5, 144, 564, 0.5, 0.5, -341, 79)
	Emblems:mergeStateConditions({
		{
			stateName = "UGCDisabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	Emblems.ButtonInternal.Title:setText("")
	Emblems.ButtonInternal.Subtitle.SubtitleText:setText(LocalizeHash("menu/emblems_caps"))
	Emblems:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge.xuid", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			Emblems.ButtonInternal.emblem0:setupPlayerEmblemByXUID(f23_local0)
		end
	end)
	f1_local5 = Emblems
	CallingCards = Emblems.subscribeToModel
	local ClanTagPC = Engine.GetGlobalModel()
	CallingCards(f1_local5, ClanTagPC["lobbyRoot.lobbyNetworkMode"], function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	f1_local5 = Emblems
	CallingCards = Emblems.subscribeToModel
	ClanTagPC = Engine.GetGlobalModel()
	CallingCards(f1_local5, ClanTagPC["lobbyRoot.lobbyNav"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	Emblems:registerEventHandler("gain_focus", function(element, event)
		local f26_local0 = nil
		if element.gainFocus then
			f26_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f26_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f26_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Emblems, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		if IsLive() and not IsUserContentRestricted(f27_arg2) then
			OpenEmblemSelect(self, f27_arg0, f27_arg2, Enum.StorageFileType[@"storage_emblems"], f27_arg1, "false")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
			OpenEmblemSelect(self, f27_arg0, f27_arg2, Enum.StorageFileType[@"storage_default_emblems"], f27_arg1, "false")
			PlaySoundAlias("uin_toggle_generic")
			return true
		end
	end, function(f28_arg0, f28_arg1, f28_arg2)
		CoD.Menu.SetButtonLabel(f28_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(Emblems)
	self.Emblems = Emblems
	CallingCards = CoD.StartMenu_Button_CallingCards.new(f1_arg0, f1_arg1, 0.5, 0.5, 144, 564, 0.5, 0.5, 100, 213)
	CallingCards:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Spinning",
			condition = function(menu, element, event)
				return IsLive() and not CallingCards_IsGetPublicProfileComplete(element, f1_arg1)
			end,
		},
	})
	ClanTagPC = CallingCards
	f1_local5 = CallingCards.subscribeToModel
	local CornerPipTR = Engine.GetGlobalModel()
	f1_local5(ClanTagPC, CornerPipTR["lobbyRoot.lobbyNetworkMode"], function(f31_arg0)
		f1_arg0:updateElementState(CallingCards, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	ClanTagPC = CallingCards
	f1_local5 = CallingCards.subscribeToModel
	CornerPipTR = Engine.GetGlobalModel()
	f1_local5(ClanTagPC, CornerPipTR["lobbyRoot.lobbyNav"], function(f32_arg0)
		f1_arg0:updateElementState(CallingCards, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ClanTagPC = CallingCards
	f1_local5 = CallingCards.subscribeToModel
	CornerPipTR = Engine.GetModelForController(f1_arg1)
	f1_local5(ClanTagPC, CornerPipTR["CallingCardsIdentity.GetPublicProfileComplete"], function(f33_arg0)
		f1_arg0:updateElementState(CallingCards, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "CallingCardsIdentity.GetPublicProfileComplete",
		})
	end, false)
	CallingCards.Backing.Title:setText("")
	CallingCards.Backing.Subtitle.SubtitleText:setText(LocalizeHash("menu/calling_cards_caps"))
	CallingCards:registerEventHandler("gain_focus", function(element, event)
		local f34_local0 = nil
		if element.gainFocus then
			f34_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f34_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f34_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CallingCards, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
		if IsInDefaultState(f35_arg0) then
			OpenCallingCards(self, f35_arg0, f35_arg2, "", f35_arg1)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f36_arg0, f36_arg1, f36_arg2)
		if IsInDefaultState(f36_arg0) then
			CoD.Menu.SetButtonLabel(f36_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	CallingCards:subscribeToGlobalModel(f1_arg1, "PerController", "CallingCardsIdentity.GetPublicProfileComplete", function(model)
		local f37_local0 = CallingCards
		if IsLive() then
			CallingCards_EmblemGetProfile(f1_arg0, f37_local0, f1_arg1)
		end
	end)
	self:addElement(CallingCards)
	self.CallingCards = CallingCards
	f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.ClanTag = f1_local5
	ClanTagPC = nil
	ClanTagPC = CoD.PC_StartMenu_Button_LG.new(f1_arg0, f1_arg1, 0.5, 0.5, 144, 564, 0.5, 0.5, 233.5, 346.5)
	self:addElement(ClanTagPC)
	self.ClanTagPC = ClanTagPC
	CornerPipTR = LUI.UIImage.new(0.5, 0.5, 578, 602, 0.5, 0.5, -384, -360)
	CornerPipTR:setAlpha(0.05)
	CornerPipTR:setZRot(-90)
	CornerPipTR:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPipTR)
	self.CornerPipTR = CornerPipTR
	local CornerPipTL = LUI.UIImage.new(0.5, 0.5, -602, -578, 0.5, 0.5, -384, -360)
	CornerPipTL:setAlpha(0.05)
	CornerPipTL:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPipTL)
	self.CornerPipTL = CornerPipTL
	local CornerPipBR = LUI.UIImage.new(0.5, 0.5, 580, 604, 0.5, 0.5, 365.5, 389.5)
	CornerPipBR:setAlpha(0.05)
	CornerPipBR:setZRot(180)
	CornerPipBR:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPipBR)
	self.CornerPipBR = CornerPipBR
	local CornerPipBL = LUI.UIImage.new(0.5, 0.5, -602, -578, 0.5, 0.5, 365.5, 389.5)
	CornerPipBL:setAlpha(0.05)
	CornerPipBL:setZRot(90)
	CornerPipBL:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPipBL)
	self.CornerPipBL = CornerPipBL
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0.5, 0.5, 454, 566, 0.5, 0.5, -361.5, -345.5)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local LayoutElement02 = CoD.CommonBgLayoutElement02.new(f1_arg0, f1_arg1, 0.5, 0.5, -111, 193, 0.5, 0.5, 276.5, 352.5)
	LayoutElement02:setZoom(100)
	LayoutElement02:setScale(0.3, 0.3)
	self:addElement(LayoutElement02)
	self.LayoutElement02 = LayoutElement02
	EmblemEditor.id = "EmblemEditor"
	Paintshop.id = "Paintshop"
	Emblems.id = "Emblems"
	CallingCards.id = "CallingCards"
	f1_local5.id = "ClanTag"
	if CoD.isPC then
		ClanTagPC.id = "ClanTagPC"
	end
	self.__defaultFocus = Emblems
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Identity.__resetProperties = function(f38_arg0)
	f38_arg0.EmblemEditor:completeAnimation()
	f38_arg0.Paintshop:completeAnimation()
	f38_arg0.Emblems:completeAnimation()
	f38_arg0.CallingCards:completeAnimation()
	f38_arg0.ClanTag:completeAnimation()
	f38_arg0.ClanTagPC:completeAnimation()
	f38_arg0.EmblemEditor:setAlpha(1)
	f38_arg0.Paintshop:setAlpha(1)
	f38_arg0.Emblems:setAlpha(1)
	f38_arg0.CallingCards:setAlpha(1)
	f38_arg0.ClanTag:setAlpha(1)
	f38_arg0.ClanTagPC:setAlpha(1)
end
CoD.StartMenu_Identity.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(5)
			local f39_local0 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					f41_arg0:beginAnimation(150)
					f41_arg0:setAlpha(1)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.EmblemEditor:beginAnimation(50)
				f39_arg0.EmblemEditor:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.EmblemEditor:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f39_arg0.EmblemEditor:completeAnimation()
			f39_arg0.EmblemEditor:setAlpha(0)
			f39_local0(f39_arg0.EmblemEditor)
			local f39_local1 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					f43_arg0:beginAnimation(150)
					f43_arg0:setAlpha(1)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.Paintshop:beginAnimation(50)
				f39_arg0.Paintshop:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Paintshop:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f39_arg0.Paintshop:completeAnimation()
			f39_arg0.Paintshop:setAlpha(0)
			f39_local1(f39_arg0.Paintshop)
			local f39_local2 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(150)
					f45_arg0:setAlpha(1)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.Emblems:beginAnimation(250)
				f39_arg0.Emblems:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.Emblems:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f39_arg0.Emblems:completeAnimation()
			f39_arg0.Emblems:setAlpha(0.01)
			f39_local2(f39_arg0.Emblems)
			local f39_local3 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					f47_arg0:beginAnimation(139)
					f47_arg0:setAlpha(1)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.CallingCards:beginAnimation(270)
				f39_arg0.CallingCards:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.CallingCards:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f39_arg0.CallingCards:completeAnimation()
			f39_arg0.CallingCards:setAlpha(0)
			f39_local3(f39_arg0.CallingCards)
			local f39_local4 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					f49_arg0:beginAnimation(149)
					f49_arg0:setAlpha(1)
					f49_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						f39_arg0.clipFinished(element, event)
					end)
				end
				f39_arg0.ClanTag:beginAnimation(300)
				f39_arg0.ClanTag:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.ClanTag:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f39_arg0.ClanTag:completeAnimation()
			f39_arg0.ClanTag.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f39_arg0.ClanTag:setAlpha(0)
			f39_local4(f39_arg0.ClanTag)
			local f39_local5 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(149)
					f52_arg0:setAlpha(1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.ClanTagPC:beginAnimation(300)
				f39_arg0.ClanTagPC:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.ClanTagPC:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f39_arg0.ClanTagPC:completeAnimation()
			f39_arg0.ClanTagPC:setAlpha(0)
			f39_local5(f39_arg0.ClanTagPC)
		end,
	},
}
CoD.StartMenu_Identity.__onClose = function(f53_arg0)
	f53_arg0.EmblemEditor:close()
	f53_arg0.Paintshop:close()
	f53_arg0.Emblems:close()
	f53_arg0.CallingCards:close()
	f53_arg0.ClanTag:close()
	f53_arg0.ClanTagPC:close()
	f53_arg0.TabbedScoreboardFuiBox:close()
	f53_arg0.LayoutElement02:close()
end
