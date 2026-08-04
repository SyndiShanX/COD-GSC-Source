CoD.FE_HelpItemsLabel = InheritFrom(LUI.UIElement)
CoD.FE_HelpItemsLabel.__defaultWidth = 30
CoD.FE_HelpItemsLabel.__defaultHeight = 30
CoD.FE_HelpItemsLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_HelpItemsLabel)
	self.id = "FE_HelpItemsLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local newImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	newImage:setImage(RegisterImage("uie_t7_menu_frontend_helptag"))
	self:addElement(newImage)
	self.newImage = newImage
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FE_HelpItemsLabel.__resetProperties = function(f4_arg0)
	f4_arg0.newImage:completeAnimation()
	f4_arg0.newImage:setAlpha(1)
end
CoD.FE_HelpItemsLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.newImage:completeAnimation()
			f5_arg0.newImage:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.newImage)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
