require("ui/uieditor/widgets/startgameflow/loadingscreensharedcpzm")
require("ui/uieditor/widgets/pc/notifications/pc_notif_container")
CoD.Loading_ZM = InheritFrom(CoD.Menu)
LUI.createMenu.Loading_ZM = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Loading_ZM", f1_arg0)
	local f1_local1 = self
	CoD.MapUtility.PlayMapLoadingMusic()
	CoD.BaseUtility.InitGlobalModel("mapLoaded", false)
	self:setClass(CoD.Loading_ZM)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BlackBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBackground:setRGB(0, 0, 0)
	BlackBackground:setAlpha(0)
	self:addElement(BlackBackground)
	self.BlackBackground = BlackBackground
	local LoadingScreenSharedCPZM = CoD.LoadingScreenSharedCPZM.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(LoadingScreenSharedCPZM)
	self.LoadingScreenSharedCPZM = LoadingScreenSharedCPZM
	local BlackFadeOut = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackFadeOut:setRGB(0, 0, 0)
	BlackFadeOut:setAlpha(0)
	self:addElement(BlackFadeOut)
	self.BlackFadeOut = BlackFadeOut
	local PCNotifContainer = nil
	PCNotifContainer = CoD.PC_Notif_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 470, 920, 0, 0, 106, 206)
	self:addElement(PCNotifContainer)
	self.PCNotifContainer = PCNotifContainer
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine.GetGlobalModel()
	f1_local7(f1_local6, f1_local8.mapLoaded, function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum.LUIButton[@"lui_key_none"])
	end, false)
	self:registerEventHandler("loading_startplay", function(element, event)
		local f3_local0 = nil
		CoD.HUDUtility.StartPlay(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:registerEventHandler("loading_nomovie_startplay", function(element, event)
		local f4_local0 = nil
		if IsZombies() and IsSplitscreenAndInGame(f1_arg0) then
			CoD.HUDUtility.StartPlay(element, f1_arg0)
			HideWidget(element)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:registerEventHandler("loading_displaycontinue", function(element, event)
		local f5_local0 = nil
		SetGlobalModelValueTrue("mapLoaded")
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		if CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") then
			CoD.HUDUtility.StartPlay(f6_arg0, f6_arg2)
			return true
		else
		end
	end, function(f7_arg0, f7_arg1, f7_arg2)
		if CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") then
			CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_none"], "ESCAPE", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") then
			CoD.HUDUtility.StartPlay(f8_arg0, f8_arg2)
			return true
		else
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		if CoD.ModelUtility.IsGlobalModelValueTrue("mapLoaded") then
			CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "ESCAPE")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			LockInput(self, f1_arg0, false)
			CoD.PCUtility.UnlockUIShortcutInput(f1_local1, f1_arg0)
		else
			LockInput(self, f1_arg0, false)
		end
	end)
	LoadingScreenSharedCPZM.id = "LoadingScreenSharedCPZM"
	if CoD.isPC then
		PCNotifContainer.id = "PCNotifContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	if IsPC() then
		LockInput(self, f1_arg0, true)
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
		SetGlobalModelValueTrue("mapLoaded")
	end
	return self
end
CoD.Loading_ZM.__resetProperties = function(f11_arg0)
	f11_arg0.BlackBackground:completeAnimation()
	f11_arg0.LoadingScreenSharedCPZM:completeAnimation()
	f11_arg0.BlackFadeOut:completeAnimation()
	f11_arg0.BlackBackground:setAlpha(0)
	f11_arg0.LoadingScreenSharedCPZM:setAlpha(1)
	f11_arg0.BlackFadeOut:setAlpha(0)
end
CoD.Loading_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.BlackBackground:completeAnimation()
			f12_arg0.BlackBackground:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.BlackBackground)
		end,
		Close = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(9)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.BlackBackground:beginAnimation(250)
				f13_arg0.BlackBackground:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.BlackBackground:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.BlackBackground:completeAnimation()
			f13_arg0.BlackBackground:setAlpha(1)
			f13_local0(f13_arg0.BlackBackground)
			local f13_local1 = function(f16_arg0)
				f13_arg0.LoadingScreenSharedCPZM:beginAnimation(250)
				f13_arg0.LoadingScreenSharedCPZM:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.LoadingScreenSharedCPZM:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.LoadingScreenSharedCPZM:completeAnimation()
			f13_arg0.LoadingScreenSharedCPZM:setAlpha(0)
			f13_local1(f13_arg0.LoadingScreenSharedCPZM)
			local f13_local2 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(250)
					f18_arg0:setAlpha(0)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.BlackFadeOut:beginAnimation(250)
				f13_arg0.BlackFadeOut:setAlpha(1)
				f13_arg0.BlackFadeOut:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.BlackFadeOut:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f13_arg0.BlackFadeOut:completeAnimation()
			f13_arg0.BlackFadeOut:setAlpha(0)
			f13_local2(f13_arg0.BlackFadeOut)
		end,
	},
}
CoD.Loading_ZM.__onClose = function(f19_arg0)
	f19_arg0.LoadingScreenSharedCPZM:close()
	f19_arg0.PCNotifContainer:close()
end
