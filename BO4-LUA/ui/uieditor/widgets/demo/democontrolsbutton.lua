require("x64:f6720200fee8f1f")
require("x64:4fb5d5732c72812")
require("x64:2675595fa323085")
CoD.DemoControlsButton = InheritFrom(LUI.UIElement)
CoD.DemoControlsButton.__defaultWidth = 38
CoD.DemoControlsButton.__defaultHeight = 76
CoD.DemoControlsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoControlsButton)
	self.id = "DemoControlsButton"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BorderThin = CoD.BorderThin.new(f1_arg0, f1_arg1, 0.5, 0.5, -19, 19, 0.5, 0.5, -38, 0)
	self:addElement(BorderThin)
	self.BorderThin = BorderThin
	local icon = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -34, -4)
	self:addElement(icon)
	self.icon = icon
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 1, 1, -40, 2)
	progressRing:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	progressRing:setScale(0.7, 0.7)
	progressRing:linkToElementModel(self, "buttonPromptState", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			progressRing:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local buttonPromptImage = LUI.UIImage.new(0.5, 0.5, -16, 14, 0, 0, 42, 72)
	buttonPromptImage:setScale(0.75, 0.75)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	buttonPromptImage:linkToElementModel(self, "buttonPromptImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -15, 15, 0.5, 0.5, -34, -4)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self.icon:linkToElementModel(self, "icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			icon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "DisabledKBM",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1)
			end,
		},
		{
			stateName = "ShowProgressRing",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showProgressRing") and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
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
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f11_arg1)
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "showProgressRing", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showProgressRing",
		})
	end)
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoControlsButton.__resetProperties = function(f14_arg0)
	f14_arg0.progressRing:completeAnimation()
	f14_arg0.icon:completeAnimation()
	f14_arg0.buttonPromptImage:completeAnimation()
	f14_arg0.BorderThin:completeAnimation()
	f14_arg0.emptyFocusable:completeAnimation()
	f14_arg0.progressRing:setAlpha(1)
	f14_arg0.icon:setTopBottom(0.5, 0.5, -34, -4)
	f14_arg0.icon:setRGB(1, 1, 1)
	f14_arg0.icon:setAlpha(1)
	f14_arg0.icon:setScale(1, 1)
	f14_arg0.buttonPromptImage:setAlpha(1)
	f14_arg0.BorderThin:setTopBottom(0.5, 0.5, -38, 0)
	f14_arg0.BorderThin:setRGB(1, 1, 1)
	f14_arg0.BorderThin:setAlpha(1)
	f14_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -34, -4)
end
CoD.DemoControlsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.progressRing:completeAnimation()
			f15_arg0.progressRing:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.progressRing)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.icon:completeAnimation()
			f16_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f16_arg0.icon:setScale(1.2, 1.2)
			f16_arg0.clipFinished(f16_arg0.icon)
			f16_arg0.progressRing:completeAnimation()
			f16_arg0.progressRing:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.progressRing)
		end,
	},
	DisabledKBM = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			f17_arg0.BorderThin:completeAnimation()
			f17_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f17_arg0.BorderThin:setRGB(0, 0, 0)
			f17_arg0.BorderThin:setAlpha(0.2)
			f17_arg0.clipFinished(f17_arg0.BorderThin)
			f17_arg0.icon:completeAnimation()
			f17_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f17_arg0.icon:setRGB(0, 0, 0)
			f17_arg0.icon:setAlpha(0.2)
			f17_arg0.clipFinished(f17_arg0.icon)
			f17_arg0.progressRing:completeAnimation()
			f17_arg0.progressRing:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.progressRing)
			f17_arg0.buttonPromptImage:completeAnimation()
			f17_arg0.buttonPromptImage:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.buttonPromptImage)
			f17_arg0.emptyFocusable:completeAnimation()
			f17_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f17_arg0.clipFinished(f17_arg0.emptyFocusable)
		end,
	},
	Disabled = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.BorderThin:completeAnimation()
			f18_arg0.BorderThin:setRGB(0, 0, 0)
			f18_arg0.BorderThin:setAlpha(0.2)
			f18_arg0.clipFinished(f18_arg0.BorderThin)
			f18_arg0.icon:completeAnimation()
			f18_arg0.icon:setRGB(0, 0, 0)
			f18_arg0.icon:setAlpha(0.2)
			f18_arg0.clipFinished(f18_arg0.icon)
			f18_arg0.progressRing:completeAnimation()
			f18_arg0.progressRing:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.progressRing)
			f18_arg0.buttonPromptImage:completeAnimation()
			f18_arg0.buttonPromptImage:setAlpha(0.2)
			f18_arg0.clipFinished(f18_arg0.buttonPromptImage)
		end,
	},
	ShowProgressRing = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.progressRing:completeAnimation()
			f19_arg0.progressRing:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.progressRing)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.icon:completeAnimation()
			f20_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f20_arg0.icon:setScale(1.2, 1.2)
			f20_arg0.clipFinished(f20_arg0.icon)
			f20_arg0.progressRing:completeAnimation()
			f20_arg0.progressRing:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.progressRing)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(5)
			f21_arg0.BorderThin:completeAnimation()
			f21_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f21_arg0.clipFinished(f21_arg0.BorderThin)
			f21_arg0.icon:completeAnimation()
			f21_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f21_arg0.clipFinished(f21_arg0.icon)
			f21_arg0.progressRing:completeAnimation()
			f21_arg0.progressRing:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.progressRing)
			f21_arg0.buttonPromptImage:completeAnimation()
			f21_arg0.buttonPromptImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.buttonPromptImage)
			f21_arg0.emptyFocusable:completeAnimation()
			f21_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f21_arg0.clipFinished(f21_arg0.emptyFocusable)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.BorderThin:completeAnimation()
			f22_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f22_arg0.clipFinished(f22_arg0.BorderThin)
			f22_arg0.icon:completeAnimation()
			f22_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f22_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f22_arg0.icon:setScale(1.2, 1.2)
			f22_arg0.clipFinished(f22_arg0.icon)
			f22_arg0.progressRing:completeAnimation()
			f22_arg0.progressRing:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.progressRing)
			f22_arg0.buttonPromptImage:completeAnimation()
			f22_arg0.buttonPromptImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.buttonPromptImage)
			f22_arg0.emptyFocusable:completeAnimation()
			f22_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f22_arg0.clipFinished(f22_arg0.emptyFocusable)
		end,
	},
}
if not CoD.isPC then
	CoD.DemoControlsButton.__clipsPerState.DefaultState.ChildFocus = nil
	CoD.DemoControlsButton.__clipsPerState.ShowProgressRing.ChildFocus = nil
	CoD.DemoControlsButton.__clipsPerState.DefaultStateKBM.ChildFocus = nil
end
CoD.DemoControlsButton.__onClose = function(f23_arg0)
	f23_arg0.BorderThin:close()
	f23_arg0.icon:close()
	f23_arg0.progressRing:close()
	f23_arg0.buttonPromptImage:close()
	f23_arg0.emptyFocusable:close()
end
