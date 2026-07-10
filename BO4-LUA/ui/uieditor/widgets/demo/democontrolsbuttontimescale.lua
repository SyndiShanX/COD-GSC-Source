require("x64:f6720200fee8f1f")
require("x64:4fb5d5732c72812")
require("x64:2675595fa323085")
CoD.DemoControlsButtonTimeScale = InheritFrom(LUI.UIElement)
CoD.DemoControlsButtonTimeScale.__defaultWidth = 38
CoD.DemoControlsButtonTimeScale.__defaultHeight = 76
CoD.DemoControlsButtonTimeScale.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoControlsButtonTimeScale)
	self.id = "DemoControlsButtonTimeScale"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BorderThin = CoD.BorderThin.new(f1_arg0, f1_arg1, 0.5, 0.5, -19, 19, 0.5, 0.5, -38, 0)
	self:addElement(BorderThin)
	self.BorderThin = BorderThin
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0, 0, -2, 40, 1, 1, -40, 2)
	progressRing:setAlpha(0)
	progressRing:setScale(0.75, 0.75)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local buttonPromptImage = LUI.UIImage.new(0.5, 0.5, -16, 14, 0, 0, 42, 72)
	buttonPromptImage:setScale(0.75, 0.75)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local icon = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -34, -4)
	self:addElement(icon)
	self.icon = icon
	local Backing = LUI.UIImage.new(0.5, 0.5, -19, 19, 0, 0, 23.5, 36.5)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.85)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	Backing:setShaderVector(0, 0.05, 0.05, 0.05, 0.05)
	self:addElement(Backing)
	self.Backing = Backing
	local timescale = LUI.UIText.new(0.5, 0.5, -19, 19, 0.5, 0.5, -15, -1)
	timescale:setScale(0.9, 0.9)
	timescale:setTTF("dinnext_regular")
	timescale:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	timescale:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	timescale:subscribeToGlobalModel(f1_arg1, "Demo", "timeScale", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			timescale:setText(DemoGetTimeScaleString(f3_local0))
		end
	end)
	self:addElement(timescale)
	self.timescale = timescale
	local x = LUI.UIText.new(0.5, 0.5, -17.5, -3.5, 0.5, 0.5, -15.5, -1.5)
	x:setText(CoD.BaseUtility.AlreadyLocalized("x"))
	x:setTTF("dinnext_regular")
	x:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	x:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(x)
	self.x = x
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -15, 15, 0.5, 0.5, -34, -4)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self.buttonPromptImage:linkToElementModel(self, "buttonPromptImage", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
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
			stateName = "ShowTimeScaleValueKBM",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTimescale") and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "ShowTimeScaleValue",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTimescale")
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
	self:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f12_arg1)
	end)
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11.LastInput, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:linkToElementModel(self, "showTimescale", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showTimescale",
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
CoD.DemoControlsButtonTimeScale.__resetProperties = function(f15_arg0)
	f15_arg0.timescale:completeAnimation()
	f15_arg0.x:completeAnimation()
	f15_arg0.icon:completeAnimation()
	f15_arg0.Backing:completeAnimation()
	f15_arg0.buttonPromptImage:completeAnimation()
	f15_arg0.progressRing:completeAnimation()
	f15_arg0.emptyFocusable:completeAnimation()
	f15_arg0.BorderThin:completeAnimation()
	f15_arg0.timescale:setTopBottom(0.5, 0.5, -15, -1)
	f15_arg0.timescale:setRGB(1, 1, 1)
	f15_arg0.timescale:setAlpha(1)
	f15_arg0.x:setTopBottom(0.5, 0.5, -15.5, -1.5)
	f15_arg0.x:setRGB(1, 1, 1)
	f15_arg0.x:setAlpha(1)
	f15_arg0.icon:setLeftRight(0.5, 0.5, -15, 15)
	f15_arg0.icon:setTopBottom(0.5, 0.5, -34, -4)
	f15_arg0.icon:setRGB(1, 1, 1)
	f15_arg0.icon:setAlpha(1)
	f15_arg0.icon:setScale(1, 1)
	f15_arg0.Backing:setTopBottom(0, 0, 23.5, 36.5)
	f15_arg0.Backing:setAlpha(0.85)
	f15_arg0.buttonPromptImage:setAlpha(1)
	f15_arg0.progressRing:setAlpha(0)
	f15_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -34, -4)
	f15_arg0.BorderThin:setTopBottom(0.5, 0.5, -38, 0)
	f15_arg0.BorderThin:setAlpha(1)
end
CoD.DemoControlsButtonTimeScale.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.icon:completeAnimation()
			f16_arg0.icon:setLeftRight(0.5, 0.5, -15, 15)
			f16_arg0.icon:setTopBottom(0.5, 0.5, -34, -4)
			f16_arg0.icon:setRGB(1, 1, 1)
			f16_arg0.clipFinished(f16_arg0.icon)
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Backing)
			f16_arg0.timescale:completeAnimation()
			f16_arg0.timescale:setRGB(1, 1, 1)
			f16_arg0.timescale:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.timescale)
			f16_arg0.x:completeAnimation()
			f16_arg0.x:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.x)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
			f17_arg0.icon:completeAnimation()
			f17_arg0.icon:setLeftRight(0.5, 0.5, -15, 15)
			f17_arg0.icon:setTopBottom(0.5, 0.5, -34, -4)
			f17_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f17_arg0.icon:setScale(1.2, 1.2)
			f17_arg0.clipFinished(f17_arg0.icon)
			f17_arg0.Backing:completeAnimation()
			f17_arg0.Backing:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Backing)
			f17_arg0.timescale:completeAnimation()
			f17_arg0.timescale:setRGB(1, 1, 1)
			f17_arg0.timescale:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.timescale)
			f17_arg0.x:completeAnimation()
			f17_arg0.x:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.x)
		end,
	},
	DisabledKBM = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(8)
			f18_arg0.BorderThin:completeAnimation()
			f18_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f18_arg0.BorderThin:setAlpha(0.2)
			f18_arg0.clipFinished(f18_arg0.BorderThin)
			f18_arg0.progressRing:completeAnimation()
			f18_arg0.progressRing:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.progressRing)
			f18_arg0.buttonPromptImage:completeAnimation()
			f18_arg0.buttonPromptImage:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.buttonPromptImage)
			f18_arg0.icon:completeAnimation()
			f18_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f18_arg0.icon:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f18_arg0.icon:setAlpha(0.2)
			f18_arg0.clipFinished(f18_arg0.icon)
			f18_arg0.Backing:completeAnimation()
			f18_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f18_arg0.Backing:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Backing)
			f18_arg0.timescale:completeAnimation()
			f18_arg0.timescale:setTopBottom(0.5, 0.5, 4, 18)
			f18_arg0.timescale:setRGB(0.7, 0.7, 0.7)
			f18_arg0.timescale:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.timescale)
			f18_arg0.x:completeAnimation()
			f18_arg0.x:setTopBottom(0.5, 0.5, 3.5, 17.5)
			f18_arg0.x:setRGB(0.7, 0.7, 0.7)
			f18_arg0.x:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.x)
			f18_arg0.emptyFocusable:completeAnimation()
			f18_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f18_arg0.clipFinished(f18_arg0.emptyFocusable)
		end,
	},
	Disabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.icon:completeAnimation()
			f19_arg0.icon:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f19_arg0.clipFinished(f19_arg0.icon)
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Backing)
			f19_arg0.timescale:completeAnimation()
			f19_arg0.timescale:setRGB(0.7, 0.7, 0.7)
			f19_arg0.timescale:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.timescale)
			f19_arg0.x:completeAnimation()
			f19_arg0.x:setRGB(0.7, 0.7, 0.7)
			f19_arg0.x:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.x)
		end,
	},
	ShowTimeScaleValueKBM = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(8)
			f20_arg0.BorderThin:completeAnimation()
			f20_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f20_arg0.clipFinished(f20_arg0.BorderThin)
			f20_arg0.progressRing:completeAnimation()
			f20_arg0.progressRing:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.progressRing)
			f20_arg0.buttonPromptImage:completeAnimation()
			f20_arg0.buttonPromptImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.buttonPromptImage)
			f20_arg0.icon:completeAnimation()
			f20_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f20_arg0.icon:setRGB(1, 1, 1)
			f20_arg0.clipFinished(f20_arg0.icon)
			f20_arg0.Backing:completeAnimation()
			f20_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f20_arg0.Backing:setAlpha(0.8)
			f20_arg0.clipFinished(f20_arg0.Backing)
			f20_arg0.timescale:completeAnimation()
			f20_arg0.timescale:setTopBottom(0.5, 0.5, 4, 18)
			f20_arg0.timescale:setRGB(1, 1, 1)
			f20_arg0.timescale:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.timescale)
			f20_arg0.x:completeAnimation()
			f20_arg0.x:setTopBottom(0.5, 0.5, 3.5, 17.5)
			f20_arg0.x:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.x)
			f20_arg0.emptyFocusable:completeAnimation()
			f20_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f20_arg0.clipFinished(f20_arg0.emptyFocusable)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(8)
			f21_arg0.BorderThin:completeAnimation()
			f21_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f21_arg0.clipFinished(f21_arg0.BorderThin)
			f21_arg0.progressRing:completeAnimation()
			f21_arg0.progressRing:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.progressRing)
			f21_arg0.buttonPromptImage:completeAnimation()
			f21_arg0.buttonPromptImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.buttonPromptImage)
			f21_arg0.icon:completeAnimation()
			f21_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f21_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f21_arg0.icon:setScale(1.2, 1.2)
			f21_arg0.clipFinished(f21_arg0.icon)
			f21_arg0.Backing:completeAnimation()
			f21_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f21_arg0.Backing:setAlpha(0.8)
			f21_arg0.clipFinished(f21_arg0.Backing)
			f21_arg0.timescale:completeAnimation()
			f21_arg0.timescale:setTopBottom(0.5, 0.5, 4, 18)
			f21_arg0.timescale:setRGB(0.92, 0.89, 0.72)
			f21_arg0.timescale:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.timescale)
			f21_arg0.x:completeAnimation()
			f21_arg0.x:setTopBottom(0.5, 0.5, 3.5, 17.5)
			f21_arg0.x:setRGB(0.92, 0.89, 0.72)
			f21_arg0.x:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.x)
			f21_arg0.emptyFocusable:completeAnimation()
			f21_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f21_arg0.clipFinished(f21_arg0.emptyFocusable)
		end,
	},
	ShowTimeScaleValue = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.icon:completeAnimation()
			f22_arg0.icon:setRGB(1, 1, 1)
			f22_arg0.clipFinished(f22_arg0.icon)
			f22_arg0.Backing:completeAnimation()
			f22_arg0.Backing:setAlpha(0.8)
			f22_arg0.clipFinished(f22_arg0.Backing)
			f22_arg0.timescale:completeAnimation()
			f22_arg0.timescale:setRGB(1, 1, 1)
			f22_arg0.timescale:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.timescale)
			f22_arg0.x:completeAnimation()
			f22_arg0.x:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.x)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.icon:completeAnimation()
			f23_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f23_arg0.icon:setScale(1.2, 1.2)
			f23_arg0.clipFinished(f23_arg0.icon)
			f23_arg0.Backing:completeAnimation()
			f23_arg0.Backing:setAlpha(0.8)
			f23_arg0.clipFinished(f23_arg0.Backing)
			f23_arg0.timescale:completeAnimation()
			f23_arg0.timescale:setRGB(0.92, 0.89, 0.72)
			f23_arg0.timescale:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.timescale)
			f23_arg0.x:completeAnimation()
			f23_arg0.x:setRGB(0.92, 0.89, 0.72)
			f23_arg0.x:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.x)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(8)
			f24_arg0.BorderThin:completeAnimation()
			f24_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f24_arg0.clipFinished(f24_arg0.BorderThin)
			f24_arg0.progressRing:completeAnimation()
			f24_arg0.progressRing:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.progressRing)
			f24_arg0.buttonPromptImage:completeAnimation()
			f24_arg0.buttonPromptImage:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.buttonPromptImage)
			f24_arg0.icon:completeAnimation()
			f24_arg0.icon:setLeftRight(0.5, 0.5, -15, 15)
			f24_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f24_arg0.icon:setRGB(1, 1, 1)
			f24_arg0.clipFinished(f24_arg0.icon)
			f24_arg0.Backing:completeAnimation()
			f24_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f24_arg0.Backing:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Backing)
			f24_arg0.timescale:completeAnimation()
			f24_arg0.timescale:setTopBottom(0.5, 0.5, 3, 17)
			f24_arg0.timescale:setRGB(1, 1, 1)
			f24_arg0.timescale:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.timescale)
			f24_arg0.x:completeAnimation()
			f24_arg0.x:setTopBottom(0.5, 0.5, 3, 17)
			f24_arg0.x:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.x)
			f24_arg0.emptyFocusable:completeAnimation()
			f24_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f24_arg0.clipFinished(f24_arg0.emptyFocusable)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(8)
			f25_arg0.BorderThin:completeAnimation()
			f25_arg0.BorderThin:setTopBottom(0.5, 0.5, -19, 19)
			f25_arg0.clipFinished(f25_arg0.BorderThin)
			f25_arg0.progressRing:completeAnimation()
			f25_arg0.progressRing:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressRing)
			f25_arg0.buttonPromptImage:completeAnimation()
			f25_arg0.buttonPromptImage:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.buttonPromptImage)
			f25_arg0.icon:completeAnimation()
			f25_arg0.icon:setLeftRight(0.5, 0.5, -15, 15)
			f25_arg0.icon:setTopBottom(0.5, 0.5, -15, 15)
			f25_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f25_arg0.icon:setScale(1.2, 1.2)
			f25_arg0.clipFinished(f25_arg0.icon)
			f25_arg0.Backing:completeAnimation()
			f25_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f25_arg0.Backing:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Backing)
			f25_arg0.timescale:completeAnimation()
			f25_arg0.timescale:setTopBottom(0.5, 0.5, 3.5, 17.5)
			f25_arg0.timescale:setRGB(1, 1, 1)
			f25_arg0.timescale:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.timescale)
			f25_arg0.x:completeAnimation()
			f25_arg0.x:setTopBottom(0.5, 0.5, 3.5, 17.5)
			f25_arg0.x:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.x)
			f25_arg0.emptyFocusable:completeAnimation()
			f25_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f25_arg0.clipFinished(f25_arg0.emptyFocusable)
		end,
	},
}
if not CoD.isPC then
	CoD.DemoControlsButtonTimeScale.__clipsPerState.DefaultState.ChildFocus = nil
	CoD.DemoControlsButtonTimeScale.__clipsPerState.ShowTimeScaleValueKBM.ChildFocus = nil
	CoD.DemoControlsButtonTimeScale.__clipsPerState.ShowTimeScaleValue.ChildFocus = nil
	CoD.DemoControlsButtonTimeScale.__clipsPerState.DefaultStateKBM.ChildFocus = nil
end
CoD.DemoControlsButtonTimeScale.__onClose = function(f26_arg0)
	f26_arg0.BorderThin:close()
	f26_arg0.progressRing:close()
	f26_arg0.buttonPromptImage:close()
	f26_arg0.icon:close()
	f26_arg0.timescale:close()
	f26_arg0.emptyFocusable:close()
end
