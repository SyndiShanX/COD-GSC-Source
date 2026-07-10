require("x64:be456922ade4fa6")
CoD.Social_PartySettingsButton = InheritFrom(LUI.UIElement)
CoD.Social_PartySettingsButton.__defaultWidth = 301
CoD.Social_PartySettingsButton.__defaultHeight = 218
CoD.Social_PartySettingsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_PartySettingsButton)
	self.id = "Social_PartySettingsButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SocialPartySettingsButtonInternal = CoD.Social_PartySettingsButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 301, 0, 0, 0, 218)
	SocialPartySettingsButtonInternal:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:addElement(SocialPartySettingsButtonInternal)
	self.SocialPartySettingsButtonInternal = SocialPartySettingsButtonInternal
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsPartyLeader(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.privateClient.isHost"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.gameClient.isHost"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
		})
	end, false)
	SocialPartySettingsButtonInternal.id = "SocialPartySettingsButtonInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_PartySettingsButton.__resetProperties = function(f8_arg0)
	f8_arg0.SocialPartySettingsButtonInternal:completeAnimation()
	f8_arg0.SocialPartySettingsButtonInternal:setAlpha(1)
	f8_arg0.SocialPartySettingsButtonInternal:setScale(1, 1)
end
CoD.Social_PartySettingsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.SocialPartySettingsButtonInternal:completeAnimation()
			f10_arg0.SocialPartySettingsButtonInternal:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.SocialPartySettingsButtonInternal)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.SocialPartySettingsButtonInternal:beginAnimation(200)
				f11_arg0.SocialPartySettingsButtonInternal:setScale(1.05, 1.05)
				f11_arg0.SocialPartySettingsButtonInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.SocialPartySettingsButtonInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.SocialPartySettingsButtonInternal:completeAnimation()
			f11_arg0.SocialPartySettingsButtonInternal:setScale(1, 1)
			f11_local0(f11_arg0.SocialPartySettingsButtonInternal)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.SocialPartySettingsButtonInternal:beginAnimation(200)
				f13_arg0.SocialPartySettingsButtonInternal:setScale(1, 1)
				f13_arg0.SocialPartySettingsButtonInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SocialPartySettingsButtonInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SocialPartySettingsButtonInternal:completeAnimation()
			f13_arg0.SocialPartySettingsButtonInternal:setScale(1.05, 1.05)
			f13_local0(f13_arg0.SocialPartySettingsButtonInternal)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.SocialPartySettingsButtonInternal:completeAnimation()
			f15_arg0.SocialPartySettingsButtonInternal:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SocialPartySettingsButtonInternal)
		end,
	},
}
CoD.Social_PartySettingsButton.__onClose = function(f16_arg0)
	f16_arg0.SocialPartySettingsButtonInternal:close()
end
