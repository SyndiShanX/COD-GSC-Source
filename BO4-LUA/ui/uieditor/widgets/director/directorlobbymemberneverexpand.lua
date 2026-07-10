require("x64:235c8e60fecf1a")
require("x64:8092b0c86b8a86c")
require("x64:9ef341c462d4032")
require("x64:7610254bee05fe0")
require("x64:f315f285d876794")
require("x64:2675595fa323085")
CoD.DirectorLobbyMemberNeverExpand = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyMemberNeverExpand.__defaultWidth = 68
CoD.DirectorLobbyMemberNeverExpand.__defaultHeight = 68
CoD.DirectorLobbyMemberNeverExpand.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbyMemberNeverExpand)
	self.id = "DirectorLobbyMemberNeverExpand"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomStartButton = CoD.DirectorButtonAdd.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorCustomStartButton:setAlpha(0)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	local DirectorLobbyMemberInternal = CoD.DirectorLobbyMemberInternalNeverExpand.new(f1_arg0, f1_arg1, 0, 0, 0, 68, 0, 0, 0, 68)
	DirectorLobbyMemberInternal:linkToElementModel(self, nil, false, function(model)
		DirectorLobbyMemberInternal:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorLobbyMemberInternal)
	self.DirectorLobbyMemberInternal = DirectorLobbyMemberInternal
	local contextualMenuFocus = nil
	contextualMenuFocus = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, -0.5, 63.5, 0, 0, 0, 70)
	contextualMenuFocus:linkToElementModel(self, nil, false, function(model)
		contextualMenuFocus:setModel(model, f1_arg1)
	end)
	self:addElement(contextualMenuFocus)
	self.contextualMenuFocus = contextualMenuFocus
	local DirectorPartyBar = CoD.DirectorPartyBarHorizontal.new(f1_arg0, f1_arg1, 0, 0, 31.5, 36.5, 0, 0, 41, 109)
	DirectorPartyBar:setZRot(90)
	DirectorPartyBar:linkToElementModel(self, "info", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorPartyBar:setModel(f4_local0, f1_arg1)
		end
	end)
	self:addElement(DirectorPartyBar)
	self.DirectorPartyBar = DirectorPartyBar
	local DirectorPartyLeader = CoD.DirectorPartyLeader.new(f1_arg0, f1_arg1, 0, 0, 0.5, 20.5, 0, 0, 0, 20)
	DirectorPartyLeader:linkToElementModel(self, "info", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DirectorPartyLeader:setModel(f5_local0, f1_arg1)
		end
	end)
	self:addElement(DirectorPartyLeader)
	self.DirectorPartyLeader = DirectorPartyLeader
	self:mergeStateConditions({
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
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNetworkMode"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f10_arg0)
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
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f13_arg0, f13_arg1)
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
	f1_local7 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
		DisableKeyboardNavigationByElement(self.contextualMenuFocus)
	end
	return self
end
CoD.DirectorLobbyMemberNeverExpand.__resetProperties = function(f18_arg0)
	f18_arg0.DirectorCustomStartButton:completeAnimation()
	f18_arg0.DirectorLobbyMemberInternal:completeAnimation()
	f18_arg0.DirectorCustomStartButton:setAlpha(0)
	f18_arg0.DirectorCustomStartButton:setScale(1, 1)
	f18_arg0.DirectorLobbyMemberInternal:setAlpha(1)
end
CoD.DirectorLobbyMemberNeverExpand.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.DirectorCustomStartButton:completeAnimation()
			f20_arg0.DirectorCustomStartButton:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.DirectorCustomStartButton)
			f20_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f20_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DirectorLobbyMemberInternal)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.DirectorCustomStartButton:completeAnimation()
			f21_arg0.DirectorCustomStartButton:setAlpha(1)
			f21_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.DirectorCustomStartButton)
			f21_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f21_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.DirectorLobbyMemberInternal)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f22_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f22_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.DirectorCustomStartButton:completeAnimation()
			f22_arg0.DirectorCustomStartButton:setAlpha(1)
			f22_arg0.DirectorCustomStartButton:setScale(1, 1)
			f22_local0(f22_arg0.DirectorCustomStartButton)
			f22_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f22_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.DirectorLobbyMemberInternal)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f24_arg0.DirectorCustomStartButton:setScale(1, 1)
				f24_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.DirectorCustomStartButton:completeAnimation()
			f24_arg0.DirectorCustomStartButton:setAlpha(1)
			f24_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f24_local0(f24_arg0.DirectorCustomStartButton)
			f24_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f24_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DirectorLobbyMemberInternal)
		end,
	},
	Empty = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.DirectorLobbyMemberInternal:completeAnimation()
			f26_arg0.DirectorLobbyMemberInternal:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DirectorLobbyMemberInternal)
		end,
	},
}
CoD.DirectorLobbyMemberNeverExpand.__onClose = function(f27_arg0)
	f27_arg0.DirectorCustomStartButton:close()
	f27_arg0.DirectorLobbyMemberInternal:close()
	f27_arg0.contextualMenuFocus:close()
	f27_arg0.DirectorPartyBar:close()
	f27_arg0.DirectorPartyLeader:close()
end
