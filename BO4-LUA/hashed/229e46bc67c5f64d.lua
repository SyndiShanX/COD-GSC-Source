require("x64:76c57f67fbf4558")
CoD.WeaponVariantPip = InheritFrom(LUI.UIElement)
CoD.WeaponVariantPip.__defaultWidth = 16
CoD.WeaponVariantPip.__defaultHeight = 16
CoD.WeaponVariantPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponVariantPip)
	self.id = "WeaponVariantPip"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PipBack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PipBack:setImage(RegisterImage(@"uie_ui_menu_pip01_bg"))
	self:addElement(PipBack)
	self.PipBack = PipBack
	local PipFront = CoD.WeaponVariantPipInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	PipFront:linkToElementModel(self, nil, false, function(model)
		PipFront:setModel(model, f1_arg1)
	end)
	self:addElement(PipFront)
	self.PipFront = PipFront
	self:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "selected")
			end,
		},
	})
	self:linkToElementModel(self, "selected", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selected",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponVariantPip.__resetProperties = function(f5_arg0)
	f5_arg0.PipBack:completeAnimation()
	f5_arg0.PipFront:completeAnimation()
	f5_arg0.PipBack:setAlpha(1)
	f5_arg0.PipFront:setAlpha(1)
end
CoD.WeaponVariantPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.PipBack:completeAnimation()
			f6_arg0.PipBack:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.PipBack)
			f6_arg0.PipFront:completeAnimation()
			f6_arg0.PipFront:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.PipFront)
		end,
		Active = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.PipBack:completeAnimation()
			f7_arg0.PipBack:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PipBack)
			f7_arg0.PipFront:completeAnimation()
			f7_arg0.PipFront:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PipFront)
		end,
	},
	Selected = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.PipBack:completeAnimation()
			f8_arg0.PipBack:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.PipBack)
		end,
		Active = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.PipBack:completeAnimation()
			f9_arg0.PipBack:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.PipBack)
		end,
	},
}
CoD.WeaponVariantPip.__onClose = function(f10_arg0)
	f10_arg0.PipFront:close()
end
