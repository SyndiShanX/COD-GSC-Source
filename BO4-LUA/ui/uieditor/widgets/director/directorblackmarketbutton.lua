require("x64:8521e10695dbe4b")
require("x64:f26e61036f85224")
require("x64:5361fa275903692")
require("x64:f91cf6839d25705")
CoD.DirectorBlackMarketButton = InheritFrom(LUI.UIElement)
CoD.DirectorBlackMarketButton.__defaultWidth = 354
CoD.DirectorBlackMarketButton.__defaultHeight = 110
CoD.DirectorBlackMarketButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorBlackMarketButton)
	self.id = "DirectorBlackMarketButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local tierProgress = CoD.DirectorBlackMarketButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	tierProgress:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(tierProgress, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		OpenQuarterMaster(self, element, controller, "", menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(tierProgress)
	self.tierProgress = tierProgress
	local BlackMarketContract = CoD.DirectorBlackMarketButtonInternal_v2.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	BlackMarketContract:setAlpha(0)
	BlackMarketContract:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BlackMarketContract, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		OpenQuarterMaster(self, element, controller, "", menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(BlackMarketContract)
	self.BlackMarketContract = BlackMarketContract
	local DirectorLobbyTierSkipNotification = CoD.DirectorLobbyTierSkipNotification.new(f1_arg0, f1_arg1, 0, 0, 0, 354, 0, 0, -69, -9)
	DirectorLobbyTierSkipNotification:setAlpha(0)
	self:addElement(DirectorLobbyTierSkipNotification)
	self.DirectorLobbyTierSkipNotification = DirectorLobbyTierSkipNotification
	local DirectorLobbyPartyTierBoost = CoD.DirectorLobbyPartyTierBoost.new(f1_arg0, f1_arg1, 0, 0, 0, 354, 0, 0, -66, -6)
	self:addElement(DirectorLobbyPartyTierBoost)
	self.DirectorLobbyPartyTierBoost = DirectorLobbyPartyTierBoost
	tierProgress.id = "tierProgress"
	BlackMarketContract.id = "BlackMarketContract"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorBlackMarketButton.__resetProperties = function(f8_arg0)
	f8_arg0.tierProgress:completeAnimation()
	f8_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
	f8_arg0.BlackMarketContract:completeAnimation()
	f8_arg0.tierProgress:setAlpha(1)
	f8_arg0.tierProgress:setScale(1, 1)
	f8_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
	f8_arg0.BlackMarketContract:setAlpha(0)
	f8_arg0.BlackMarketContract:setScale(1, 1)
end
CoD.DirectorBlackMarketButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.tierProgress:completeAnimation()
			f10_arg0.tierProgress:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.tierProgress)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.tierProgress:beginAnimation(150)
				f11_arg0.tierProgress:setScale(1.05, 1.05)
				f11_arg0.tierProgress:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.tierProgress:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.tierProgress:completeAnimation()
			f11_arg0.tierProgress:setScale(1, 1)
			f11_local0(f11_arg0.tierProgress)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.tierProgress:beginAnimation(100)
				f13_arg0.tierProgress:setScale(1, 1)
				f13_arg0.tierProgress:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.tierProgress:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.tierProgress:completeAnimation()
			f13_arg0.tierProgress:setScale(1.05, 1.05)
			f13_local0(f13_arg0.tierProgress)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.tierProgress:completeAnimation()
			f15_arg0.tierProgress:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.tierProgress)
			f15_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f15_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DirectorLobbyTierSkipNotification)
		end,
	},
	Contract = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.tierProgress:completeAnimation()
			f16_arg0.tierProgress:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.tierProgress)
			f16_arg0.BlackMarketContract:completeAnimation()
			f16_arg0.BlackMarketContract:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BlackMarketContract)
			f16_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f16_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.DirectorLobbyTierSkipNotification)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.tierProgress:completeAnimation()
			f17_arg0.tierProgress:setAlpha(1)
			f17_arg0.tierProgress:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.tierProgress)
			f17_arg0.BlackMarketContract:completeAnimation()
			f17_arg0.BlackMarketContract:setAlpha(0)
			f17_arg0.BlackMarketContract:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.BlackMarketContract)
			f17_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f17_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.DirectorLobbyTierSkipNotification)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			local f18_local0 = function(f19_arg0)
				f18_arg0.tierProgress:beginAnimation(150)
				f18_arg0.tierProgress:setScale(1.05, 1.05)
				f18_arg0.tierProgress:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.tierProgress:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.tierProgress:completeAnimation()
			f18_arg0.tierProgress:setAlpha(1)
			f18_arg0.tierProgress:setScale(1, 1)
			f18_local0(f18_arg0.tierProgress)
			local f18_local1 = function(f20_arg0)
				f18_arg0.BlackMarketContract:beginAnimation(150)
				f18_arg0.BlackMarketContract:setScale(1.05, 1.05)
				f18_arg0.BlackMarketContract:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.BlackMarketContract:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.BlackMarketContract:completeAnimation()
			f18_arg0.BlackMarketContract:setAlpha(0)
			f18_arg0.BlackMarketContract:setScale(1, 1)
			f18_local1(f18_arg0.BlackMarketContract)
			f18_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f18_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.DirectorLobbyTierSkipNotification)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			local f21_local0 = function(f22_arg0)
				f21_arg0.tierProgress:beginAnimation(100)
				f21_arg0.tierProgress:setScale(1, 1)
				f21_arg0.tierProgress:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.tierProgress:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.tierProgress:completeAnimation()
			f21_arg0.tierProgress:setAlpha(1)
			f21_arg0.tierProgress:setScale(1.05, 1.05)
			f21_local0(f21_arg0.tierProgress)
			local f21_local1 = function(f23_arg0)
				f21_arg0.BlackMarketContract:beginAnimation(100)
				f21_arg0.BlackMarketContract:setScale(1, 1)
				f21_arg0.BlackMarketContract:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.BlackMarketContract:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.BlackMarketContract:completeAnimation()
			f21_arg0.BlackMarketContract:setAlpha(0)
			f21_arg0.BlackMarketContract:setScale(1.05, 1.05)
			f21_local1(f21_arg0.BlackMarketContract)
			f21_arg0.DirectorLobbyTierSkipNotification:completeAnimation()
			f21_arg0.DirectorLobbyTierSkipNotification:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.DirectorLobbyTierSkipNotification)
		end,
	},
}
CoD.DirectorBlackMarketButton.__onClose = function(f24_arg0)
	f24_arg0.tierProgress:close()
	f24_arg0.BlackMarketContract:close()
	f24_arg0.DirectorLobbyTierSkipNotification:close()
	f24_arg0.DirectorLobbyPartyTierBoost:close()
end
