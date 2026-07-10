CoD.OIC_LifePip = InheritFrom(LUI.UIElement)
CoD.OIC_LifePip.__defaultWidth = 43
CoD.OIC_LifePip.__defaultHeight = 43
CoD.OIC_LifePip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OIC_LifePip)
	self.id = "OIC_LifePip"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0.5, 0.5, -18.5, 18.5, 0.5, 0.5, -18.5, 18.5)
	Image:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_icon_lives"))
	self:addElement(Image)
	self.Image = Image
	self:mergeStateConditions({
		{
			stateName = "Off",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "on")
			end,
		},
	})
	self:linkToElementModel(self, "on", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "on",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OIC_LifePip.__resetProperties = function(f4_arg0)
	f4_arg0.Image:completeAnimation()
	f4_arg0.Image:setAlpha(1)
end
CoD.OIC_LifePip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Off = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(0.05)
			f6_arg0.clipFinished(f6_arg0.Image)
		end,
	},
}
