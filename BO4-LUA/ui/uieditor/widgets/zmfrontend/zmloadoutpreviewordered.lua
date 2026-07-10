CoD.ZMLoadoutPreviewOrdered = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreviewOrdered.__defaultWidth = 1218
CoD.ZMLoadoutPreviewOrdered.__defaultHeight = 452
CoD.ZMLoadoutPreviewOrdered.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreviewOrdered)
	self.id = "ZMLoadoutPreviewOrdered"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMLoadoutPreviewFrame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	ZMLoadoutPreviewFrame:setLeftRight(0.5, 0.5, -609, -337)
	ZMLoadoutPreviewFrame:setTopBottom(1, 1, -452, 0)
	self:addElement(ZMLoadoutPreviewFrame)
	self.ZMLoadoutPreviewFrame = ZMLoadoutPreviewFrame
	ZMLoadoutPreviewFrame.id = "ZMLoadoutPreviewFrame"
	self.__defaultFocus = ZMLoadoutPreviewFrame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMLoadoutPreviewOrdered.__resetProperties = function(f2_arg0)
	f2_arg0.ZMLoadoutPreviewFrame:completeAnimation()
	f2_arg0.ZMLoadoutPreviewFrame:setLeftRight(0.5, 0.5, -609, -337)
end
CoD.ZMLoadoutPreviewOrdered.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Left = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ZMLoadoutPreviewFrame:completeAnimation()
			f4_arg0.ZMLoadoutPreviewFrame:setLeftRight(0.5, 0.5, -609, -337)
			f4_arg0.clipFinished(f4_arg0.ZMLoadoutPreviewFrame)
		end,
	},
	LeftCenter = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ZMLoadoutPreviewFrame:completeAnimation()
			f5_arg0.ZMLoadoutPreviewFrame:setLeftRight(0.5, 0.5, -294, -22)
			f5_arg0.clipFinished(f5_arg0.ZMLoadoutPreviewFrame)
		end,
	},
	RightCenter = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ZMLoadoutPreviewFrame:completeAnimation()
			f6_arg0.ZMLoadoutPreviewFrame:setLeftRight(0.5, 0.5, 22, 294)
			f6_arg0.clipFinished(f6_arg0.ZMLoadoutPreviewFrame)
		end,
	},
	Right = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ZMLoadoutPreviewFrame:completeAnimation()
			f7_arg0.ZMLoadoutPreviewFrame:setLeftRight(0.5, 0.5, 337, 609)
			f7_arg0.clipFinished(f7_arg0.ZMLoadoutPreviewFrame)
		end,
	},
}
CoD.ZMLoadoutPreviewOrdered.__onClose = function(f8_arg0)
	f8_arg0.ZMLoadoutPreviewFrame:close()
end
