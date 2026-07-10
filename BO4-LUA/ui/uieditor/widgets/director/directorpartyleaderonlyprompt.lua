CoD.DirectorPartyLeaderOnlyPrompt = InheritFrom(LUI.UIElement)
CoD.DirectorPartyLeaderOnlyPrompt.__defaultWidth = 200
CoD.DirectorPartyLeaderOnlyPrompt.__defaultHeight = 24
CoD.DirectorPartyLeaderOnlyPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPartyLeaderOnlyPrompt)
	self.id = "DirectorPartyLeaderOnlyPrompt"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PartyLeaderOnlyPrompt = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -9, 9)
	PartyLeaderOnlyPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5B71C5E80EBFDD82"))
	PartyLeaderOnlyPrompt:setTTF("ttmussels_regular")
	PartyLeaderOnlyPrompt:setLetterSpacing(2)
	PartyLeaderOnlyPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PartyLeaderOnlyPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PartyLeaderOnlyPrompt:setBackingType(2)
	PartyLeaderOnlyPrompt:setBackingColor(0, 0, 0)
	PartyLeaderOnlyPrompt:setBackingAlpha(0.5)
	PartyLeaderOnlyPrompt:setBackingXPadding(4)
	PartyLeaderOnlyPrompt:setBackingYPadding(1)
	self:addElement(PartyLeaderOnlyPrompt)
	self.PartyLeaderOnlyPrompt = PartyLeaderOnlyPrompt
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	self:appendEventHandler("on_session_start", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	self:appendEventHandler("on_session_end", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.gameClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.privateClient.update"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPartyLeaderOnlyPrompt.__resetProperties = function(f9_arg0)
	f9_arg0.PartyLeaderOnlyPrompt:completeAnimation()
	f9_arg0.PartyLeaderOnlyPrompt:setAlpha(1)
end
CoD.DirectorPartyLeaderOnlyPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.PartyLeaderOnlyPrompt:completeAnimation()
			f10_arg0.PartyLeaderOnlyPrompt:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PartyLeaderOnlyPrompt)
		end,
	},
	Invisible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.PartyLeaderOnlyPrompt:completeAnimation()
			f11_arg0.PartyLeaderOnlyPrompt:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PartyLeaderOnlyPrompt)
		end,
	},
	Visible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
