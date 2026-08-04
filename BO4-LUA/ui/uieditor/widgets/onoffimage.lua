CoD.onOffImage = InheritFrom(LUI.UIElement)
CoD.onOffImage.__defaultWidth = 96
CoD.onOffImage.__defaultHeight = 96
CoD.onOffImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.onOffImage)
	self.id = "onOffImage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	image:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(image)
	self.image = image
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.FreeCursorUtility.UseSelfWidthIfElementVisible(self, self.image)
	CoD.FreeCursorUtility.UseSelfHeightIfElementVisible(self, self.image)
	return self
end
CoD.onOffImage.__resetProperties = function(f2_arg0)
	f2_arg0.image:completeAnimation()
	f2_arg0.image:setLeftRight(0, 1, 0, 0)
	f2_arg0.image:setTopBottom(0, 1, 0, 0)
	f2_arg0.image:setAlpha(1)
end
CoD.onOffImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.image:completeAnimation()
			f3_arg0.image:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.image)
		end,
		On = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.image:completeAnimation()
			f4_arg0.image:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.image)
		end,
	},
	On = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.image:completeAnimation()
			f5_arg0.image:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.image)
		end,
		DefaultState = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.image:completeAnimation()
			f6_arg0.image:setLeftRight(0, 1, 0, 0)
			f6_arg0.image:setTopBottom(0, 1, 0, 0)
			f6_arg0.image:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.image)
		end,
	},
}
CoD.onOffImage.__onClose = function(f7_arg0)
	f7_arg0.image:close()
end
