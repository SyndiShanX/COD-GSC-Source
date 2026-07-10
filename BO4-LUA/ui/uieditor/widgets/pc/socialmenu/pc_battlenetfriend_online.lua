require("x64:f315f285d876794")
require("x64:891695c75906b3c")
require("x64:2675595fa323085")
require("x64:a637e411019b270")
CoD.PC_BattlenetFriend_Online = InheritFrom(LUI.UIElement)
CoD.PC_BattlenetFriend_Online.__defaultWidth = 400
CoD.PC_BattlenetFriend_Online.__defaultHeight = 60
CoD.PC_BattlenetFriend_Online.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BattlenetFriend_Online)
	self.id = "PC_BattlenetFriend_Online"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IMG_Background = LUI.UIImage.new(0.02, 0.99, 0, 0, 0, 1, 0, 0)
	IMG_Background:setRGB(0.07, 0.07, 0.07)
	IMG_Background:setAlpha(0)
	IMG_Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(IMG_Background)
	self.IMG_Background = IMG_Background
	local ProgramImage = LUI.UIImage.new(0.11, 0.11, -0.5, 39.5, 0.5, 0.5, -22, 18)
	ProgramImage:linkToElementModel(self, "battlenetProgramId", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgramImage:setImage(RegisterImage(CoD.PCUtility.GetBNetPresenceProgramImage(f2_local0)))
		end
	end)
	self:addElement(ProgramImage)
	self.ProgramImage = ProgramImage
	local TXTPlayerStatus = LUI.UIText.new(0.23, 0.23, 0, 298, 0.49, 0.49, 0, 15)
	TXTPlayerStatus:setRGB(0.59, 0.59, 0.59)
	TXTPlayerStatus:setTTF("notosans_regular")
	TXTPlayerStatus:setLetterSpacing(1)
	TXTPlayerStatus:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TXTPlayerStatus:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TXTPlayerStatus:linkToElementModel(self, "presenceString", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TXTPlayerStatus:setText(f3_local0)
		end
	end)
	self:addElement(TXTPlayerStatus)
	self.TXTPlayerStatus = TXTPlayerStatus
	local TXTPending = LUI.UIText.new(0.23, 0.23, 0, 298, 0.49, 0.49, 0, 15)
	TXTPending:setRGB(0.59, 0.59, 0.59)
	TXTPending:setAlpha(0)
	TXTPending:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_33DD0EE1DB9F6A1C"))
	TXTPending:setTTF("notosans_regular")
	TXTPending:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TXTPending:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TXTPending)
	self.TXTPending = TXTPending
	local IMG_PlayerStatusIcon = LUI.UIImage.new(0.16, 0.16, 0, 40, 0.44, 0.44, 0, 40)
	IMG_PlayerStatusIcon:setImage(RegisterImage(@"uie_sliderbar_handle_alt"))
	IMG_PlayerStatusIcon:linkToElementModel(self, "battlenetPresence", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			IMG_PlayerStatusIcon:setRGB(CoD.PCBattlenetUtility.BattleNetStatusToColor(f4_local0))
		end
	end)
	self:addElement(IMG_PlayerStatusIcon)
	self.IMG_PlayerStatusIcon = IMG_PlayerStatusIcon
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0, 1, 0, 0)
	emptyFocusable:linkToElementModel(self, "identityBadge", false, function(model)
		emptyFocusable:setModel(model, f1_arg1)
	end)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local DirectorLobbyLeader = CoD.DirectorLobbyLeader.new(f1_arg0, f1_arg1, 0.08, 0.08, 2, 11, 0.1, 0.1, 2, 42)
	self:addElement(DirectorLobbyLeader)
	self.DirectorLobbyLeader = DirectorLobbyLeader
	local TXTPlayerTag = CoD.PC_BattlenetFriend_NameAndRealId.new(f1_arg0, f1_arg1, 0.23, 0.23, 0, 300, 0, 0, 5.5, 26.5)
	TXTPlayerTag:linkToElementModel(self, nil, false, function(model)
		TXTPlayerTag:setModel(model, f1_arg1)
	end)
	self:addElement(TXTPlayerTag)
	self.TXTPlayerTag = TXTPlayerTag
	self:mergeStateConditions({
		{
			stateName = "InviteInMyPartyPending",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "partyInviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING)
			end,
		},
		{
			stateName = "Normal",
			condition = function(menu, element, event)
				return not IsCurrentLanguageKoreanOrTraditionalChinese()
			end,
		},
		{
			stateName = "InviteInMyPartyPendingNormal",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "partyInviteStatus", CoD.PCWidgetUtility.SocialInviteStatus.PENDING) and not IsCurrentLanguageKoreanOrTraditionalChinese()
			end,
		},
	})
	self:linkToElementModel(self, "partyInviteStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "partyInviteStatus",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11.LastInput, function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) then
			SetSelectedFriendXUID(self, element, controller)
			OpenOverlay(self, "Social_PlayerDetailsPopup", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_1E0254269ED8FFD3", nil, nil)
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
	f1_local10 = self
	CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	ActivateTextStencilCulling(TXTPlayerStatus)
	ActivateTextStencilCulling(TXTPending)
	return self
end
CoD.PC_BattlenetFriend_Online.__resetProperties = function(f15_arg0)
	f15_arg0.TXTPlayerStatus:completeAnimation()
	f15_arg0.IMG_Background:completeAnimation()
	f15_arg0.TXTPending:completeAnimation()
	f15_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 298)
	f15_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, 0, 15)
	f15_arg0.TXTPlayerStatus:setAlpha(1)
	f15_arg0.IMG_Background:setAlpha(0)
	f15_arg0.TXTPending:setLeftRight(0.23, 0.23, 0, 298)
	f15_arg0.TXTPending:setTopBottom(0.49, 0.49, 0, 15)
	f15_arg0.TXTPending:setAlpha(0)
end
CoD.PC_BattlenetFriend_Online.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.TXTPlayerStatus:completeAnimation()
			f16_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 300)
			f16_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, -2, 10)
			f16_arg0.clipFinished(f16_arg0.TXTPlayerStatus)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.IMG_Background:completeAnimation()
			f17_arg0.IMG_Background:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.IMG_Background)
			f17_arg0.TXTPlayerStatus:completeAnimation()
			f17_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 300)
			f17_arg0.TXTPlayerStatus:setTopBottom(0.49, 0.49, -2, 10)
			f17_arg0.clipFinished(f17_arg0.TXTPlayerStatus)
		end,
	},
	InviteInMyPartyPending = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.TXTPlayerStatus:completeAnimation()
			f18_arg0.TXTPlayerStatus:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.TXTPlayerStatus)
			f18_arg0.TXTPending:completeAnimation()
			f18_arg0.TXTPending:setLeftRight(0.23, 0.23, 0, 300)
			f18_arg0.TXTPending:setTopBottom(0.49, 0.49, -2, 10)
			f18_arg0.TXTPending:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.TXTPending)
		end,
	},
	Normal = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.TXTPlayerStatus:completeAnimation()
			f19_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 298)
			f19_arg0.clipFinished(f19_arg0.TXTPlayerStatus)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.IMG_Background:completeAnimation()
			f20_arg0.IMG_Background:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.IMG_Background)
			f20_arg0.TXTPlayerStatus:completeAnimation()
			f20_arg0.TXTPlayerStatus:setLeftRight(0.23, 0.23, 0, 298)
			f20_arg0.clipFinished(f20_arg0.TXTPlayerStatus)
		end,
	},
	InviteInMyPartyPendingNormal = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.TXTPlayerStatus:completeAnimation()
			f21_arg0.TXTPlayerStatus:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TXTPlayerStatus)
			f21_arg0.TXTPending:completeAnimation()
			f21_arg0.TXTPending:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.TXTPending)
		end,
	},
}
CoD.PC_BattlenetFriend_Online.__onClose = function(f22_arg0)
	f22_arg0.ProgramImage:close()
	f22_arg0.TXTPlayerStatus:close()
	f22_arg0.TXTPending:close()
	f22_arg0.IMG_PlayerStatusIcon:close()
	f22_arg0.emptyFocusable:close()
	f22_arg0.DirectorLobbyLeader:close()
	f22_arg0.TXTPlayerTag:close()
end
