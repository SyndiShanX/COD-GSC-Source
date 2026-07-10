require("x64:22bf0e10b899d2b")
CoD.StartMenu_Options_Network_StatusOverview_Wrapper = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Network_StatusOverview_Wrapper.__defaultWidth = 700
CoD.StartMenu_Options_Network_StatusOverview_Wrapper.__defaultHeight = 112
CoD.StartMenu_Options_Network_StatusOverview_Wrapper.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Network_StatusOverview_Wrapper)
	self.id = "StartMenu_Options_Network_StatusOverview_Wrapper"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsNetworkStatusOverview = CoD.StartMenu_Options_Network_StatusOverview.new(f1_arg0, f1_arg1, 0, 0, 0, 700, 0, 0, 0, 112)
	self:addElement(StartMenuOptionsNetworkStatusOverview)
	self.StartMenuOptionsNetworkStatusOverview = StartMenuOptionsNetworkStatusOverview
	self.StartMenuOptionsNetworkStatusOverview:linkToElementModel(self, nil, false, function(model)
		StartMenuOptionsNetworkStatusOverview:setModel(model, f1_arg1)
	end)
	StartMenuOptionsNetworkStatusOverview.id = "StartMenuOptionsNetworkStatusOverview"
	self.__defaultFocus = StartMenuOptionsNetworkStatusOverview
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Network_StatusOverview_Wrapper.__resetProperties = function(f3_arg0)
	f3_arg0.StartMenuOptionsNetworkStatusOverview:completeAnimation()
	f3_arg0.StartMenuOptionsNetworkStatusOverview:setScale(1, 1)
end
CoD.StartMenu_Options_Network_StatusOverview_Wrapper.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.StartMenuOptionsNetworkStatusOverview:completeAnimation()
			f5_arg0.StartMenuOptionsNetworkStatusOverview:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.StartMenuOptionsNetworkStatusOverview)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.StartMenuOptionsNetworkStatusOverview:beginAnimation(200)
				f6_arg0.StartMenuOptionsNetworkStatusOverview:setScale(1.05, 1.05)
				f6_arg0.StartMenuOptionsNetworkStatusOverview:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.StartMenuOptionsNetworkStatusOverview:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.StartMenuOptionsNetworkStatusOverview:completeAnimation()
			f6_arg0.StartMenuOptionsNetworkStatusOverview:setScale(1, 1)
			f6_local0(f6_arg0.StartMenuOptionsNetworkStatusOverview)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.StartMenuOptionsNetworkStatusOverview:beginAnimation(200)
				f8_arg0.StartMenuOptionsNetworkStatusOverview:setScale(1, 1)
				f8_arg0.StartMenuOptionsNetworkStatusOverview:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.StartMenuOptionsNetworkStatusOverview:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.StartMenuOptionsNetworkStatusOverview:completeAnimation()
			f8_arg0.StartMenuOptionsNetworkStatusOverview:setScale(1.05, 1.05)
			f8_local0(f8_arg0.StartMenuOptionsNetworkStatusOverview)
		end,
	},
}
CoD.StartMenu_Options_Network_StatusOverview_Wrapper.__onClose = function(f10_arg0)
	f10_arg0.StartMenuOptionsNetworkStatusOverview:close()
end
