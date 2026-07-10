CoD.CallingCardImage = InheritFrom(LUI.UIElement)
CoD.CallingCardImage.__defaultWidth = 129
CoD.CallingCardImage.__defaultHeight = 147
CoD.CallingCardImage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCardImage)
	self.id = "CallingCardImage"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0.21, 0.79, 0, 0)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	Image:setShaderVector(0, 0.5, 0, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "category", 0xA1163B4DB78960A)
			end,
		},
	})
	self:linkToElementModel(self, "category", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "category",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCardImage.__resetProperties = function(f4_arg0)
	f4_arg0.Image:completeAnimation()
	f4_arg0.Image:setAlpha(1)
end
CoD.CallingCardImage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Image)
		end,
	},
	Show = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Image)
		end,
	},
}
