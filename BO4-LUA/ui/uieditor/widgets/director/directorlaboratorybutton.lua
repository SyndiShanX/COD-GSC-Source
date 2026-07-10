require("x64:19825e759c0fc6c")
require("x64:2e6578419b866ab")
require("x64:f91cf6839d25705")
require("x64:7553d3c19005336")
CoD.DirectorLaboratoryButton = InheritFrom(LUI.UIElement)
CoD.DirectorLaboratoryButton.__defaultWidth = 354
CoD.DirectorLaboratoryButton.__defaultHeight = 110
CoD.DirectorLaboratoryButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLaboratoryButton)
	self.id = "DirectorLaboratoryButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorLaboratoryButtonInternal = CoD.DirectorLaboratoryButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorLaboratoryButtonInternal:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorLaboratoryButtonInternal, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsPlayerAGuest(controller) then
			PlaySoundAlias("uin_toggle_generic")
			OpenOverlay(self, "Laboratory", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPlayerAGuest(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_96D9A8F7540D6B6", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(DirectorLaboratoryButtonInternal)
	self.DirectorLaboratoryButtonInternal = DirectorLaboratoryButtonInternal
	local ZMDoubleNPWidget = CoD.ZMDoubleNPWidget.new(f1_arg0, f1_arg1, 0, 0, 26, 71, 0, 0, -52, -7)
	self:addElement(ZMDoubleNPWidget)
	self.ZMDoubleNPWidget = ZMDoubleNPWidget
	local DirectorLobbyTierSkipNotification = CoD.DirectorLobbyTierSkipNotification.new(f1_arg0, f1_arg1, 0, 0, 0, 354, 0, 0, -70, -10)
	DirectorLobbyTierSkipNotification:setAlpha(0)
	self:addElement(DirectorLobbyTierSkipNotification)
	self.DirectorLobbyTierSkipNotification = DirectorLobbyTierSkipNotification
	self:mergeStateConditions({
		{
			stateName = "DailyTierSkipHidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewInfoShown")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsLobbyNetworkModeLive()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.DirectorZMLoadoutPreview.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.ZMLoadoutPreviewInfoShown, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "ZMLoadoutPreviewInfoShown",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorLaboratoryButtonInternal.id = "DirectorLaboratoryButtonInternal"
	self.__defaultFocus = DirectorLaboratoryButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLaboratoryButton.__resetProperties = function(f9_arg0)
	f9_arg0.DirectorLaboratoryButtonInternal:completeAnimation()
	f9_arg0.ZMDoubleNPWidget:completeAnimation()
	f9_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
	f9_arg0.DirectorLaboratoryButtonInternal:setAlpha(1)
	f9_arg0.DirectorLaboratoryButtonInternal:setScale(1, 1)
	f9_arg0.ZMDoubleNPWidget:setAlpha(1)
	f9_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
end
CoD.DirectorLaboratoryButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.DirectorLaboratoryButtonInternal:completeAnimation()
			f11_arg0.DirectorLaboratoryButtonInternal:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.DirectorLaboratoryButtonInternal)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.DirectorLaboratoryButtonInternal:beginAnimation(150)
				f12_arg0.DirectorLaboratoryButtonInternal:setScale(1.05, 1.05)
				f12_arg0.DirectorLaboratoryButtonInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.DirectorLaboratoryButtonInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.DirectorLaboratoryButtonInternal:completeAnimation()
			f12_arg0.DirectorLaboratoryButtonInternal:setScale(1, 1)
			f12_local0(f12_arg0.DirectorLaboratoryButtonInternal)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.DirectorLaboratoryButtonInternal:beginAnimation(100)
				f14_arg0.DirectorLaboratoryButtonInternal:setScale(1, 1)
				f14_arg0.DirectorLaboratoryButtonInternal:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.DirectorLaboratoryButtonInternal:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.DirectorLaboratoryButtonInternal:completeAnimation()
			f14_arg0.DirectorLaboratoryButtonInternal:setScale(1.05, 1.05)
			f14_local0(f14_arg0.DirectorLaboratoryButtonInternal)
		end,
	},
	DailyTierSkipHidden = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.ZMDoubleNPWidget:completeAnimation()
			f16_arg0.ZMDoubleNPWidget:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ZMDoubleNPWidget)
			f16_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f16_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.DirectorLobbyTierSkipNotification)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.DirectorLaboratoryButtonInternal:completeAnimation()
			f17_arg0.DirectorLaboratoryButtonInternal:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.DirectorLaboratoryButtonInternal)
			f17_arg0.ZMDoubleNPWidget:completeAnimation()
			f17_arg0.ZMDoubleNPWidget:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ZMDoubleNPWidget)
			f17_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f17_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.DirectorLobbyTierSkipNotification)
		end,
	},
}
CoD.DirectorLaboratoryButton.__onClose = function(f18_arg0)
	f18_arg0.DirectorLaboratoryButtonInternal:close()
	f18_arg0.ZMDoubleNPWidget:close()
	f18_arg0.DirectorLobbyTierSkipNotification:close()
end
