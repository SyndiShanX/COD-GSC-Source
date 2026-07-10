require("x64:235c8e60fecf1a")
require("x64:ee845b827f7f55a")
require("x64:9ef341c462d4032")
require("x64:7610254bee05fe0")
require("x64:f315f285d876794")
require("x64:2675595fa323085")
CoD.DirectorLobbyMember = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyMember.__defaultWidth = 68
CoD.DirectorLobbyMember.__defaultHeight = 68
CoD.DirectorLobbyMember.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyMember)
	self.id = "DirectorLobbyMember"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomStartButton = CoD.DirectorButtonAdd.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorCustomStartButton:setAlpha(0)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	local DirectorLobbyMemberInternal = CoD.DirectorLobbyMemberInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 68, 0, 0, 0, 68)
	DirectorLobbyMemberInternal:linkToElementModel(self, nil, false, function(model)
		DirectorLobbyMemberInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorLobbyMemberInternal)
	self.DirectorLobbyMemberInternal = DirectorLobbyMemberInternal
	local sizeElement = LUI.UIImage.new(0, 0, 0, 68, 0, 0, 0, 68)
	sizeElement:setAlpha(0)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	local contextualMenuFocus = nil
	contextualMenuFocus = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, -0.5, 63.5, 0, 0, 0, 70)
	self:addElement(contextualMenuFocus)
	self.contextualMenuFocus = contextualMenuFocus
	local DirectorPartyBar = CoD.DirectorPartyBarHorizontal.new(f1_arg0, f1_arg1, 0, 0, 31.5, 36.5, 0, 0, 41, 109)
	DirectorPartyBar:setZRot(90)
	DirectorPartyBar:linkToElementModel(self, "info", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorPartyBar:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(DirectorPartyBar)
	self.DirectorPartyBar = DirectorPartyBar
	local DirectorPartyLeader = CoD.DirectorPartyLeader.new(f1_arg0, f1_arg1, 0, 0, 0.5, 20.5, 0, 0, 0, 20)
	DirectorPartyLeader:linkToElementModel(self, "info", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorPartyLeader:setModel(f4_local0, f1_arg1)
		end
	end)
	self:addElement(DirectorPartyLeader)
	self.DirectorPartyLeader = DirectorPartyLeader
	self:mergeStateConditions({
		{
			stateName = "AlwaysExpand",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.SHOW_EXPANDED)
			end,
		},
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLAN()
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "xuid", Engine[0x9073FBE2D48C156]("0"))
			end,
		},
	})
	self:linkToElementModel(self, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNetworkMode"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f12_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	self:linkToElementModel(self, "clientListFlags", true, function(model, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsPC() and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(self, controller, "xuid", Engine[0x9073FBE2D48C156]("0")) and not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) then
			SetSelectedFriendXUID(self, element, controller)
			OpenOverlay(self, "Social_PlayerDetailsPopup", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(self, controller, "xuid", Engine[0x9073FBE2D48C156]("0")) and not CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, controller, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xE0254269ED8FFD3, nil, nil)
			return true
		else
			return false
		end
	end, false)
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	DirectorLobbyMemberInternal.id = "DirectorLobbyMemberInternal"
	if CoD.isPC then
		contextualMenuFocus.id = "contextualMenuFocus"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
		DisableKeyboardNavigationByElement(self.contextualMenuFocus)
	end
	return self
end
CoD.DirectorLobbyMember.__resetProperties = function(f18_arg0)
	f18_arg0.sizeElement:completeAnimation()
	f18_arg0.contextualMenuFocus:completeAnimation()
	f18_arg0.DirectorCustomStartButton:completeAnimation()
	f18_arg0.DirectorLobbyMemberInternal:completeAnimation()
	f18_arg0.sizeElement:setLeftRight(0, 0, 0, 68)
	f18_arg0.contextualMenuFocus:setLeftRight(0, 0, -0.5, 63.5)
	f18_arg0.DirectorCustomStartButton:setAlpha(0)
	f18_arg0.DirectorCustomStartButton:setScale(1, 1)
	f18_arg0.DirectorLobbyMemberInternal:setAlpha(1)
end
CoD.DirectorLobbyMember.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	AlwaysExpand = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.sizeElement:completeAnimation()
			f20_arg0.sizeElement:setLeftRight(0, 0, 0, 326)
			f20_arg0.clipFinished(f20_arg0.sizeElement)
			f20_arg0.contextualMenuFocus:completeAnimation()
			f20_arg0.contextualMenuFocus:setLeftRight(0, 0, -0.5, 371.5)
			f20_arg0.clipFinished(f20_arg0.contextualMenuFocus)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.DirectorCustomStartButton:completeAnimation()
			f21_arg0.DirectorCustomStartButton:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.DirectorCustomStartButton)
			f21_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f21_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.DirectorLobbyMemberInternal)
			f21_arg0.sizeElement:completeAnimation()
			f21_arg0.sizeElement:setLeftRight(0, 0, 0, 68)
			f21_arg0.clipFinished(f21_arg0.sizeElement)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.DirectorCustomStartButton:completeAnimation()
			f22_arg0.DirectorCustomStartButton:setAlpha(1)
			f22_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f22_arg0.clipFinished(f22_arg0.DirectorCustomStartButton)
			f22_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f22_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.DirectorLobbyMemberInternal)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			local f23_local0 = function(f24_arg0)
				f23_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f23_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f23_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.DirectorCustomStartButton:completeAnimation()
			f23_arg0.DirectorCustomStartButton:setAlpha(1)
			f23_arg0.DirectorCustomStartButton:setScale(1, 1)
			f23_local0(f23_arg0.DirectorCustomStartButton)
			f23_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f23_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.DirectorLobbyMemberInternal)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f25_arg0.DirectorCustomStartButton:setScale(1, 1)
				f25_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.DirectorCustomStartButton:completeAnimation()
			f25_arg0.DirectorCustomStartButton:setAlpha(1)
			f25_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f25_local0(f25_arg0.DirectorCustomStartButton)
			f25_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f25_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.DirectorLobbyMemberInternal)
		end,
	},
	Empty = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f27_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DirectorLobbyMemberInternal)
			f27_arg0.sizeElement:completeAnimation()
			f27_arg0.sizeElement:setLeftRight(0, 0, 0, 68)
			f27_arg0.clipFinished(f27_arg0.sizeElement)
		end,
	},
}
CoD.DirectorLobbyMember.__onClose = function(f28_arg0)
	f28_arg0.DirectorCustomStartButton:close()
	f28_arg0.DirectorLobbyMemberInternal:close()
	f28_arg0.contextualMenuFocus:close()
	f28_arg0.DirectorPartyBar:close()
	f28_arg0.DirectorPartyLeader:close()
end
