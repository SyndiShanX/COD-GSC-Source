require("x64:45c3699dabd929")
CoD.LiveEventViewerStreamerCount = InheritFrom(LUI.UIElement)
CoD.LiveEventViewerStreamerCount.__defaultWidth = 235
CoD.LiveEventViewerStreamerCount.__defaultHeight = 39
CoD.LiveEventViewerStreamerCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LiveEventViewerStreamerCount)
	self.id = "LiveEventViewerStreamerCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local streamerCountIcon = LUI.UIImage.new(1, 1, -236, -198, 1, 1, -38, 0)
	streamerCountIcon:setImage(RegisterImage(@"uie_twitch_streamers_white"))
	self:addElement(streamerCountIcon)
	self.streamerCountIcon = streamerCountIcon
	local streamerCount = CoD.ArabicAlignTextBox.new(f1_arg0, f1_arg1, 1, 1, -198, 0, 1, 1, -35.5, -2.5)
	streamerCount.textBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	streamerCount:subscribeToGlobalModel(f1_arg1, "LiveEventViewer", "viewers", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			streamerCount.textBox:setText(f2_local0)
		end
	end)
	self:addElement(streamerCount)
	self.streamerCount = streamerCount
	self:mergeStateConditions({
		{
			stateName = "NoViewers",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("liveEventViewer.viewers", 0)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["liveEventViewer.viewers"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "liveEventViewer.viewers",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LiveEventViewerStreamerCount.__resetProperties = function(f5_arg0)
	f5_arg0.streamerCountIcon:completeAnimation()
	f5_arg0.streamerCount:completeAnimation()
	f5_arg0.streamerCountIcon:setAlpha(1)
	f5_arg0.streamerCount:setAlpha(1)
end
CoD.LiveEventViewerStreamerCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	NoViewers = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.streamerCountIcon:completeAnimation()
			f7_arg0.streamerCountIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.streamerCountIcon)
			f7_arg0.streamerCount:completeAnimation()
			f7_arg0.streamerCount:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.streamerCount)
		end,
	},
}
CoD.LiveEventViewerStreamerCount.__onClose = function(f8_arg0)
	f8_arg0.streamerCount:close()
end
