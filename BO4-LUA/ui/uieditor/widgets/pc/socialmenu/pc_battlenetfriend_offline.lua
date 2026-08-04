require("ui/uieditor/menus/social/social_playerdetailspopup")
require("ui/uieditor/widgets/emptyfocusable")
CoD.PC_BattlenetFriend_Offline = InheritFrom(LUI.UIElement)
CoD.PC_BattlenetFriend_Offline.__defaultWidth = 400
CoD.PC_BattlenetFriend_Offline.__defaultHeight = 60
CoD.PC_BattlenetFriend_Offline.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BattlenetFriend_Offline)
	self.id = "PC_BattlenetFriend_Offline"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IMG_Background = LUI.UIImage.new(0.02, 0.99, 0, 0, 0, 1, 0, 0)
	IMG_Background:setRGB(0.07, 0.07, 0.07)
	IMG_Background:setAlpha(0)
	IMG_Background:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(IMG_Background)
	self.IMG_Background = IMG_Background
	local ProgramImage = LUI.UIImage.new(0.11, 0.11, 0, 40, 0.5, 0.5, -22, 18)
	ProgramImage:setImage(RegisterImage("uie_social_friendlist_offline_icon"))
	self:addElement(ProgramImage)
	self.ProgramImage = ProgramImage
	local TXTPlayerTag = LUI.UIText.new(0.23, 0.23, 0, 253, 0, 0, 6, 27)
	TXTPlayerTag:setRGB(0.4, 0.4, 0.4)
	TXTPlayerTag:setTTF("notosans_light")
	TXTPlayerTag:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	TXTPlayerTag:linkToElementModel(self, "identityBadge.gamertag", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TXTPlayerTag:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(TXTPlayerTag)
	self.TXTPlayerTag = TXTPlayerTag
	local TXTPlayerStatus = LUI.UIText.new(0.23, 0.23, 0, 298, 0.49, 0.49, 0, 15)
	TXTPlayerStatus:setRGB(0.59, 0.59, 0.59)
	TXTPlayerStatus:setTTF("notosans_regular")
	TXTPlayerStatus:setLetterSpacing(1)
	TXTPlayerStatus:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	TXTPlayerStatus:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	TXTPlayerStatus:linkToElementModel(self, "presenceString", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TXTPlayerStatus:setText(f3_local0)
		end
	end)
	self:addElement(TXTPlayerStatus)
	self.TXTPlayerStatus = TXTPlayerStatus
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:linkToElementModel(self, "identityBadge", false, function(model)
		emptyFocusable:setModel(model, f1_arg1)
	end)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self:mergeStateConditions({
		{
			stateName = "Normal",
			condition = function(menu, element, event)
				return not IsCurrentLanguageKorean()
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"])
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if IsGamepad(f8_arg2) then
			SetSelectedFriendXUID(self, f8_arg0, f8_arg2)
			OpenOverlay(self, "Social_PlayerDetailsPopup", f8_arg2, nil)
			return true
		else
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		if IsGamepad(f9_arg2) then
			CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], @"hash_1E0254269ED8FFD3", nil, nil)
			return true
		else
			return false
		end
	end, false)
	emptyFocusable.id = "emptyFocusable"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	ActivateTextStencilCulling(TXTPlayerTag)
	ActivateTextStencilCulling(TXTPlayerStatus)
	return self
end
CoD.PC_BattlenetFriend_Offline.__resetProperties = function(f10_arg0)
	f10_arg0.TXTPlayerTag:completeAnimation()
	f10_arg0.TXTPlayerStatus:completeAnimation()
	f10_arg0.IMG_Background:completeAnimation()
	f10_arg0.TXTPlayerTag:setRGB(0.4, 0.4, 0.4)
	f10_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 298)
	f10_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, 0, 15)
	f10_arg0.IMG_Background:setAlpha(0)
end
CoD.PC_BattlenetFriend_Offline.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.TXTPlayerTag:completeAnimation()
			f11_arg0.TXTPlayerTag:setRGB(0.4, 0.4, 0.4)
			f11_arg0.clipFinished(f11_arg0.TXTPlayerTag)
			f11_arg0.TXTPlayerStatus:completeAnimation()
			f11_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 302)
			f11_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, -2, 10)
			f11_arg0.clipFinished(f11_arg0.TXTPlayerStatus)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.IMG_Background:completeAnimation()
			f12_arg0.IMG_Background:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.IMG_Background)
			f12_arg0.TXTPlayerStatus:completeAnimation()
			f12_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 300)
			f12_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, -2, 10)
			f12_arg0.clipFinished(f12_arg0.TXTPlayerStatus)
		end,
	},
	Normal = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.TXTPlayerStatus:completeAnimation()
			f13_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, 0, 15)
			f13_arg0.clipFinished(f13_arg0.TXTPlayerStatus)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.IMG_Background:completeAnimation()
			f14_arg0.IMG_Background:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.IMG_Background)
			f14_arg0.TXTPlayerStatus:completeAnimation()
			f14_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, 0, 15)
			f14_arg0.clipFinished(f14_arg0.TXTPlayerStatus)
		end,
	},
}
CoD.PC_BattlenetFriend_Offline.__onClose = function(f15_arg0)
	f15_arg0.TXTPlayerTag:close()
	f15_arg0.TXTPlayerStatus:close()
	f15_arg0.emptyFocusable:close()
end
