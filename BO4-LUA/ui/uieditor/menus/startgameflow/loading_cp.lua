require("ui/uieditor/widgets/startgameflow/loadingscreensharedcpzm")
CoD.Loading_CP = InheritFrom(CoD.Menu)
LUI.createMenu.Loading_CP = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Loading_CP", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Loading_CP)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local LoadingScreenSharedCPZM = CoD.LoadingScreenSharedCPZM.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(LoadingScreenSharedCPZM)
	self.LoadingScreenSharedCPZM = LoadingScreenSharedCPZM
	self:registerEventHandler("loading_startplay", function(element, event)
		local f2_local0 = nil
		CoD.HUDUtility.StartPlay(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum.LUIButton[@"lui_key_xba_pscross"], "ESCAPE", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		CoD.HUDUtility.StartPlay(f3_arg0, f3_arg2)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ESCAPE")
		return false
	end, false)
	LoadingScreenSharedCPZM.id = "LoadingScreenSharedCPZM"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Loading_CP.__resetProperties = function(f5_arg0)
	f5_arg0.LoadingScreenSharedCPZM:completeAnimation()
	f5_arg0.LoadingScreenSharedCPZM:setAlpha(1)
end
CoD.Loading_CP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Close = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.LoadingScreenSharedCPZM:beginAnimation(300)
				f7_arg0.LoadingScreenSharedCPZM:setAlpha(0)
				f7_arg0.LoadingScreenSharedCPZM:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.LoadingScreenSharedCPZM:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.LoadingScreenSharedCPZM:completeAnimation()
			f7_arg0.LoadingScreenSharedCPZM:setAlpha(1)
			f7_local0(f7_arg0.LoadingScreenSharedCPZM)
		end,
	},
}
CoD.Loading_CP.__onClose = function(f9_arg0)
	f9_arg0.LoadingScreenSharedCPZM:close()
end
