require("x64:156d841adc02c80")
require("x64:d802126c917b3")
CoD.MOTD_VoDPreviewWidget = InheritFrom(LUI.UIElement)
CoD.MOTD_VoDPreviewWidget.__defaultWidth = 1392
CoD.MOTD_VoDPreviewWidget.__defaultHeight = 680
CoD.MOTD_VoDPreviewWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ModelUtility.SetGlobalDatasourceModelValue(f1_arg1, "HLSPlayback", "haveStarted", false)
	self:setClass(CoD.MOTD_VoDPreviewWidget)
	self.id = "MOTD_VoDPreviewWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	Frame:setLeftRight(0, 0, 0, 1212)
	Frame:setTopBottom(0, 0, 0, 680)
	Frame:subscribeToGlobalModel(f1_arg1, "MOTDVoDPreview", "frame", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Frame:changeFrameWidget(f2_local0)
		end
	end)
	Frame:linkToElementModel(self, "vod", false, function(model)
		Frame:setModel(model, f1_arg1)
	end)
	self:addElement(Frame)
	self.Frame = Frame
	local Backing = LUI.UIImage.new(0, 0, 0, 1212, 0, 0, 0, 680)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local SpinnerLoadingAnimation = CoD.SpinnerLoadingAnimation.new(f1_arg0, f1_arg1, 0, 0, 574, 638, 0, 0, 308, 372)
	self:addElement(SpinnerLoadingAnimation)
	self.SpinnerLoadingAnimation = SpinnerLoadingAnimation
	self:mergeStateConditions({
		{
			stateName = "Loading",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HLSPlayback", "haveStarted", 0)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.HLSPlayback.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.haveStarted, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "haveStarted",
		})
	end, false)
	Frame.id = "Frame"
	self.__defaultFocus = Frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_VoDPreviewWidget.__resetProperties = function(f6_arg0)
	f6_arg0.SpinnerLoadingAnimation:completeAnimation()
	f6_arg0.Backing:completeAnimation()
	f6_arg0.SpinnerLoadingAnimation:setRGB(1, 1, 1)
	f6_arg0.SpinnerLoadingAnimation:setAlpha(1)
	f6_arg0.Backing:setAlpha(0)
end
CoD.MOTD_VoDPreviewWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.SpinnerLoadingAnimation:completeAnimation()
			f7_arg0.SpinnerLoadingAnimation:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.SpinnerLoadingAnimation)
		end,
	},
	Loading = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Backing:completeAnimation()
			f8_arg0.Backing:setAlpha(0.6)
			f8_arg0.clipFinished(f8_arg0.Backing)
			local f8_local0 = function(f9_arg0)
				f8_arg0.SpinnerLoadingAnimation:beginAnimation(300)
				f8_arg0.SpinnerLoadingAnimation:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.SpinnerLoadingAnimation:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.SpinnerLoadingAnimation:completeAnimation()
			f8_arg0.SpinnerLoadingAnimation:setRGB(1, 1, 1)
			f8_arg0.SpinnerLoadingAnimation:setAlpha(1)
			f8_local0(f8_arg0.SpinnerLoadingAnimation)
		end,
	},
}
CoD.MOTD_VoDPreviewWidget.__onClose = function(f10_arg0)
	f10_arg0.Frame:close()
	f10_arg0.SpinnerLoadingAnimation:close()
end
