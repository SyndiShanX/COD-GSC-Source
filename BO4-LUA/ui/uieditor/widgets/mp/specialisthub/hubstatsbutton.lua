require("x64:cf5be000450821a")
CoD.HubStatsButton = InheritFrom(LUI.UIElement)
CoD.HubStatsButton.__defaultWidth = 393
CoD.HubStatsButton.__defaultHeight = 177
CoD.HubStatsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubStatsButton)
	self.id = "HubStatsButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HubStatsButtonInternal = CoD.HubStatsButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 393, 0, 0, 0, 177)
	HubStatsButtonInternal:linkToElementModel(self, nil, false, function(model)
		HubStatsButtonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(HubStatsButtonInternal)
	self.HubStatsButtonInternal = HubStatsButtonInternal
	HubStatsButtonInternal.id = "HubStatsButtonInternal"
	self.__defaultFocus = HubStatsButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubStatsButton.__resetProperties = function(f3_arg0)
	f3_arg0.HubStatsButtonInternal:completeAnimation()
	f3_arg0.HubStatsButtonInternal:setScale(1, 1)
end
CoD.HubStatsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.HubStatsButtonInternal:completeAnimation()
			f4_arg0.HubStatsButtonInternal:setScale(1, 1)
			f4_arg0.clipFinished(f4_arg0.HubStatsButtonInternal)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.HubStatsButtonInternal:completeAnimation()
			f5_arg0.HubStatsButtonInternal:setScale(1.02, 1.03)
			f5_arg0.clipFinished(f5_arg0.HubStatsButtonInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.HubStatsButtonInternal:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
				f6_arg0.HubStatsButtonInternal:setScale(1.02, 1.03)
				f6_arg0.HubStatsButtonInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.HubStatsButtonInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.HubStatsButtonInternal:completeAnimation()
			f6_arg0.HubStatsButtonInternal:setScale(1, 1)
			f6_local0(f6_arg0.HubStatsButtonInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.HubStatsButtonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f8_arg0.HubStatsButtonInternal:setScale(1, 1)
				f8_arg0.HubStatsButtonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.HubStatsButtonInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.HubStatsButtonInternal:completeAnimation()
			f8_arg0.HubStatsButtonInternal:setScale(1.02, 1.03)
			f8_local0(f8_arg0.HubStatsButtonInternal)
		end,
	},
}
CoD.HubStatsButton.__onClose = function(f10_arg0)
	f10_arg0.HubStatsButtonInternal:close()
end
