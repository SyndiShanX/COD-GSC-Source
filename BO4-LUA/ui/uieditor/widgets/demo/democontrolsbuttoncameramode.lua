require("x64:f6720200fee8f1f")
require("x64:4fb5d5732c72812")
require("x64:2675595fa323085")
local PostLoadFunc = function(self, controller, menu)
	self.mode:subscribeToGlobalModel(controller, "Demo", "cameraMode", function(model)
		local f2_local0 = Engine[0x614D394F6F9A18D](model)
		if f2_local0 then
			local f2_local1 = 0x3EF6A41762515E9
			if f2_local0 == Enum[0xF432DF404208022][0x448CED16817146D] then
				f2_local1 = 0xD52B52EF950D3EF
			elseif f2_local0 == Enum[0xF432DF404208022][0xFCA80C27FBE8269] then
				f2_local1 = 0x134DF9F49965B8C
			elseif f2_local0 == Enum[0xF432DF404208022][0x3B1995A6E46FA28] then
				f2_local1 = 0xBBB247300B3AE21
			end
			self.mode:setText(Engine[0xF9F1239CFD921FE](f2_local1))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", function(element)
		element.mode:close()
	end)
end
CoD.DemoControlsButtonCameraMode = InheritFrom(LUI.UIElement)
CoD.DemoControlsButtonCameraMode.__defaultWidth = 38
CoD.DemoControlsButtonCameraMode.__defaultHeight = 76
CoD.DemoControlsButtonCameraMode.new = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	local self = LUI.UIElement.new(f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7, f4_arg8, f4_arg9)
	self:setClass(CoD.DemoControlsButtonCameraMode)
	self.id = "DemoControlsButtonCameraMode"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f4_arg0:addElementToPendingUpdateStateList(self)
	local BorderThin = CoD.BorderThin.new(f4_arg0, f4_arg1, 0, 0, 0, 38, 0, 0, 0, 38)
	self:addElement(BorderThin)
	self.BorderThin = BorderThin
	local Backing = LUI.UIImage.new(0.5, 0.5, -19, 19, 0, 0, 23.5, 36.5)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.85)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Backing:setShaderVector(0, 0.05, 0.05, 0.05, 0.05)
	self:addElement(Backing)
	self.Backing = Backing
	local icon = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -34.5, -17.5)
	self:addElement(icon)
	self.icon = icon
	local mode = LUI.UIText.new(0.5, 0.5, -19, 19, 0.5, 0.5, -14.5, -0.5)
	mode:setScale(0.9, 0.9)
	mode:setText(LocalizeToUpperString(0xBBB247300B3AE21))
	mode:setTTF("dinnext_regular")
	mode:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	mode:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(mode)
	self.mode = mode
	local progressRing = CoD.ButtonProgressRingContainer.new(f4_arg0, f4_arg1, 0.5, 0.5, -21, 21, 1, 1, -40, 2)
	progressRing:setAlpha(0)
	progressRing:setScale(0.7, 0.7)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f4_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local buttonPromptImage = LUI.UIImage.new(0.5, 0.5, -15, 15, 0, 0, 42, 72)
	buttonPromptImage:setScale(0.75, 0.75)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f4_arg0, f4_arg1, 0.5, 0.5, -15, 15, 0.5, 0.5, -34, -4)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self.icon:linkToElementModel(self, "icon", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			icon:setImage(RegisterImage(f6_local0))
		end
	end)
	self.buttonPromptImage:linkToElementModel(self, "buttonPromptImage", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			buttonPromptImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "DisabledKBM",
			condition = function(menu, element, event)
				return IsDisabled(element, f4_arg1) and IsMouseOrKeyboard(f4_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f4_arg1)
			end,
		},
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f4_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f4_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f4_arg0
		f4_arg0:updateElementState(self, f12_arg1)
	end)
	local f4_local8 = self
	local f4_local9 = self.subscribeToModel
	local f4_local10 = Engine[0x4DF5CFBC1771947](f4_arg1)
	f4_local9(f4_local8, f4_local10.LastInput, function(f13_arg0)
		f4_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f4_arg0,
			controller = f4_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f4_arg1, f4_arg0)
	end
	return self
end
CoD.DemoControlsButtonCameraMode.__resetProperties = function(f14_arg0)
	f14_arg0.icon:completeAnimation()
	f14_arg0.mode:completeAnimation()
	f14_arg0.buttonPromptImage:completeAnimation()
	f14_arg0.progressRing:completeAnimation()
	f14_arg0.emptyFocusable:completeAnimation()
	f14_arg0.Backing:completeAnimation()
	f14_arg0.BorderThin:completeAnimation()
	f14_arg0.icon:setTopBottom(0.5, 0.5, -34.5, -17.5)
	f14_arg0.icon:setRGB(1, 1, 1)
	f14_arg0.icon:setAlpha(1)
	f14_arg0.icon:setYRot(0)
	f14_arg0.icon:setScale(1, 1)
	f14_arg0.mode:setTopBottom(0.5, 0.5, -14.5, -0.5)
	f14_arg0.mode:setRGB(1, 1, 1)
	f14_arg0.mode:setAlpha(1)
	f14_arg0.buttonPromptImage:setAlpha(1)
	f14_arg0.progressRing:setAlpha(0)
	f14_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -34, -4)
	f14_arg0.Backing:setTopBottom(0, 0, 23.5, 36.5)
	f14_arg0.BorderThin:setTopBottom(0, 0, 0, 38)
end
CoD.DemoControlsButtonCameraMode.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.icon:completeAnimation()
			f15_arg0.icon:setAlpha(1)
			f15_arg0.icon:setYRot(0)
			f15_arg0.clipFinished(f15_arg0.icon)
			f15_arg0.mode:completeAnimation()
			f15_arg0.mode:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.mode)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.icon:completeAnimation()
			f16_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f16_arg0.icon:setAlpha(1)
			f16_arg0.icon:setYRot(0)
			f16_arg0.icon:setScale(1.2, 1.2)
			f16_arg0.clipFinished(f16_arg0.icon)
			f16_arg0.mode:completeAnimation()
			f16_arg0.mode:setRGB(0.92, 0.89, 0.72)
			f16_arg0.mode:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.mode)
		end,
	},
	DisabledKBM = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(7)
			f17_arg0.BorderThin:completeAnimation()
			f17_arg0.BorderThin:setTopBottom(0, 0, 19, 57)
			f17_arg0.clipFinished(f17_arg0.BorderThin)
			f17_arg0.Backing:completeAnimation()
			f17_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f17_arg0.clipFinished(f17_arg0.Backing)
			f17_arg0.icon:completeAnimation()
			f17_arg0.icon:setTopBottom(0.5, 0.5, -15.5, 1.5)
			f17_arg0.icon:setRGB(0.7, 0.7, 0.7)
			f17_arg0.clipFinished(f17_arg0.icon)
			f17_arg0.mode:completeAnimation()
			f17_arg0.mode:setTopBottom(0.5, 0.5, 4.5, 18.5)
			f17_arg0.mode:setRGB(0.7, 0.7, 0.7)
			f17_arg0.clipFinished(f17_arg0.mode)
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
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.icon:completeAnimation()
			f18_arg0.icon:setRGB(0.7, 0.7, 0.7)
			f18_arg0.clipFinished(f18_arg0.icon)
			f18_arg0.mode:completeAnimation()
			f18_arg0.mode:setRGB(0.7, 0.7, 0.7)
			f18_arg0.clipFinished(f18_arg0.mode)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(7)
			f19_arg0.BorderThin:completeAnimation()
			f19_arg0.BorderThin:setTopBottom(0, 0, 19, 57)
			f19_arg0.clipFinished(f19_arg0.BorderThin)
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f19_arg0.clipFinished(f19_arg0.Backing)
			f19_arg0.icon:completeAnimation()
			f19_arg0.icon:setTopBottom(0.5, 0.5, -15.5, 1.5)
			f19_arg0.icon:setAlpha(1)
			f19_arg0.icon:setYRot(0)
			f19_arg0.clipFinished(f19_arg0.icon)
			f19_arg0.mode:completeAnimation()
			f19_arg0.mode:setTopBottom(0.5, 0.5, 4.5, 18.5)
			f19_arg0.mode:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.mode)
			f19_arg0.progressRing:completeAnimation()
			f19_arg0.progressRing:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.progressRing)
			f19_arg0.buttonPromptImage:completeAnimation()
			f19_arg0.buttonPromptImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.buttonPromptImage)
			f19_arg0.emptyFocusable:completeAnimation()
			f19_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f19_arg0.clipFinished(f19_arg0.emptyFocusable)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(7)
			f20_arg0.BorderThin:completeAnimation()
			f20_arg0.BorderThin:setTopBottom(0, 0, 19, 57)
			f20_arg0.clipFinished(f20_arg0.BorderThin)
			f20_arg0.Backing:completeAnimation()
			f20_arg0.Backing:setTopBottom(0, 0, 42.5, 55.5)
			f20_arg0.clipFinished(f20_arg0.Backing)
			f20_arg0.icon:completeAnimation()
			f20_arg0.icon:setTopBottom(0.5, 0.5, -15.5, 1.5)
			f20_arg0.icon:setRGB(0.92, 0.89, 0.72)
			f20_arg0.icon:setAlpha(1)
			f20_arg0.icon:setYRot(0)
			f20_arg0.icon:setScale(1.2, 1.2)
			f20_arg0.clipFinished(f20_arg0.icon)
			f20_arg0.mode:completeAnimation()
			f20_arg0.mode:setTopBottom(0.5, 0.5, 4.5, 18.5)
			f20_arg0.mode:setRGB(0.92, 0.89, 0.72)
			f20_arg0.mode:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.mode)
			f20_arg0.progressRing:completeAnimation()
			f20_arg0.progressRing:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.progressRing)
			f20_arg0.buttonPromptImage:completeAnimation()
			f20_arg0.buttonPromptImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.buttonPromptImage)
			f20_arg0.emptyFocusable:completeAnimation()
			f20_arg0.emptyFocusable:setTopBottom(0.5, 0.5, -15, 15)
			f20_arg0.clipFinished(f20_arg0.emptyFocusable)
		end,
	},
}
if not CoD.isPC then
	CoD.DemoControlsButtonCameraMode.__clipsPerState.DefaultState.ChildFocus = nil
	CoD.DemoControlsButtonCameraMode.__clipsPerState.DefaultStateKBM.ChildFocus = nil
end
CoD.DemoControlsButtonCameraMode.__onClose = function(f21_arg0)
	f21_arg0.BorderThin:close()
	f21_arg0.icon:close()
	f21_arg0.progressRing:close()
	f21_arg0.buttonPromptImage:close()
	f21_arg0.emptyFocusable:close()
end
