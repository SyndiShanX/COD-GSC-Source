require("x64:f78acfcbc465bba")
require("x64:63f4ca61fff21cd")
require("x64:d802126c917b3")
CoD.VoDPreviewWidget = InheritFrom(LUI.UIElement)
CoD.VoDPreviewWidget.__defaultWidth = 192
CoD.VoDPreviewWidget.__defaultHeight = 108
CoD.VoDPreviewWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VoDPreviewWidget)
	self.id = "VoDPreviewWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	Frame:setLeftRight(0, 1, 4, -4)
	Frame:setTopBottom(0, 1, 4, -4)
	Frame:changeFrameWidget(CoD.VoDPreviewWidgetImage)
	Frame:linkToElementModel(self, nil, false, function(model)
		Frame:setModel(model, f1_arg1)
	end)
	self:addElement(Frame)
	self.Frame = Frame
	local Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Lines:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	self:addElement(Lines)
	self.Lines = Lines
	self:mergeStateConditions({
		{
			stateName = "NoMovie",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "lowResVideo.movieName")
			end,
		},
		{
			stateName = "NoFocus",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "lowResVideo.movieName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lowResVideo.movieName",
		})
	end)
	Frame.id = "Frame"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VoDPreviewWidget.__resetProperties = function(f6_arg0)
	f6_arg0.Frame:completeAnimation()
end
CoD.VoDPreviewWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Frame:completeAnimation()
			f7_arg0.Frame:changeFrameWidget(CoD.VoDPreviewWidgetImage)
			f7_arg0.clipFinished(f7_arg0.Frame)
		end,
		Focus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Frame:completeAnimation()
			f8_arg0.Frame:changeFrameWidget(CoD.VoDPreviewWidgetVideo)
			f8_arg0.clipFinished(f8_arg0.Frame)
		end,
	},
	NoMovie = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Frame:completeAnimation()
			f9_arg0.Frame:changeFrameWidget(CoD.VoDPreviewWidgetImage)
			f9_arg0.clipFinished(f9_arg0.Frame)
		end,
	},
	NoFocus = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Frame:completeAnimation()
			f10_arg0.Frame:changeFrameWidget(CoD.VoDPreviewWidgetImage)
			f10_arg0.clipFinished(f10_arg0.Frame)
		end,
	},
}
CoD.VoDPreviewWidget.__onClose = function(f11_arg0)
	f11_arg0.Frame:close()
	f11_arg0.Lines:close()
end
