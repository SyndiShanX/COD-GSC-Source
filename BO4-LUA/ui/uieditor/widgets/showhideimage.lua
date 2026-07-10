CoD.showHideImage = InheritFrom(LUI.UIElement)
CoD.showHideImage.__defaultWidth = 96
CoD.showHideImage.__defaultHeight = 96
CoD.showHideImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.showHideImage)
	self.id = "showHideImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(image)
	self.image = image
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f2_arg2, f2_arg3, f2_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.FreeCursorUtility.UseSelfWidthIfElementVisible(self, self.image)
	CoD.FreeCursorUtility.UseSelfHeightIfElementVisible(self, self.image)
	return self
end
CoD.showHideImage.__resetProperties = function(f3_arg0)
	f3_arg0.image:completeAnimation()
	f3_arg0.image:setAlpha(1)
end
CoD.showHideImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.image:completeAnimation()
			f4_arg0.image:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.image)
		end,
	},
	Show = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.showHideImage.__onClose = function(f6_arg0)
	f6_arg0.image:close()
end
