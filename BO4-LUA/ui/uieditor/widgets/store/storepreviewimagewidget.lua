CoD.StorePreviewImageWidget = InheritFrom(LUI.UIElement)
CoD.StorePreviewImageWidget.__defaultWidth = 579
CoD.StorePreviewImageWidget.__defaultHeight = 381
CoD.StorePreviewImageWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StorePreviewImageWidget)
	self.id = "StorePreviewImageWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local previewImage = LUI.UIImage.new(0, 1, 2, 2, 0, 1, 2, 2)
	previewImage:linkToElementModel(self, "productImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			previewImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(previewImage)
	self.previewImage = previewImage
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return HideProductNameAndDesc()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StorePreviewImageWidget.__resetProperties = function(f4_arg0)
	f4_arg0.previewImage:completeAnimation()
	f4_arg0.previewImage:setAlpha(1)
end
CoD.StorePreviewImageWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hide = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.previewImage:completeAnimation()
			f6_arg0.previewImage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.previewImage)
		end,
	},
}
CoD.StorePreviewImageWidget.__onClose = function(f7_arg0)
	f7_arg0.previewImage:close()
end
