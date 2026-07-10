require("x64:2675595fa323085")
require("x64:bdc4956715f81d7")
require("x64:b79410dc8d1ea84")
CoD.CyclingList_ItemControl = InheritFrom(LUI.UIElement)
CoD.CyclingList_ItemControl.__defaultWidth = 348
CoD.CyclingList_ItemControl.__defaultHeight = 65
CoD.CyclingList_ItemControl.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CyclingList_ItemControl)
	self.id = "CyclingList_ItemControl"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local center = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 335, 0, 1, 0, 0)
	self:addElement(center)
	self.center = center
	local TextBox = LUI.UIText.new(0, 0.58, 6, 6, 0.5, 0.5, -10.5, 10.5)
	TextBox:setRGB(0.76, 0.76, 0.76)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	TextBox:setTTF("ttmussels_regular")
	TextBox:setLetterSpacing(1)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local right = CoD.CyclingList_Arrow.new(f1_arg0, f1_arg1, 1, 1, -68, 0, 0, 1, 0, 0)
	right:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return IsSelfInState(self, "RightArrowHidden")
			end,
		},
	})
	self:addElement(right)
	self.right = right
	local left = CoD.CyclingList_Arrow.new(f1_arg0, f1_arg1, 1, 1, -135, -67, 0, 1, 0, 0)
	left:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return IsSelfInState(self, "LeftArrowHidden")
			end,
		},
	})
	left:setZRot(180)
	self:addElement(left)
	self.left = left
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 0, 0, 214, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	local OptionCountBorder = LUI.UIImage.new(0, 0, 0, 214, 1, 1, -5, -1)
	OptionCountBorder:setAlpha(0.05)
	OptionCountBorder:setImage(RegisterImage(0x1B69BB6285C5BBB))
	OptionCountBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0x31E7B3C72564429))
	OptionCountBorder:setShaderVector(0, 0, 0, 0.55, 0.13)
	OptionCountBorder:setShaderVector(2, 0, 1, 0, 1)
	OptionCountBorder:setupNineSliceShader(25, 4)
	OptionCountBorder:linkToElementModel(self, "optionCount", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			OptionCountBorder:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	self:addElement(OptionCountBorder)
	self.OptionCountBorder = OptionCountBorder
	local CurrentOptionBorder = LUI.UIImage.new(0, 0, 0, 214, 1, 1, -5, -1)
	CurrentOptionBorder:setRGB(0.8, 0.8, 0.8)
	CurrentOptionBorder:setImage(RegisterImage(0x1B69BB6285C5BBB))
	CurrentOptionBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0x31E7B3C72564429))
	CurrentOptionBorder:setShaderVector(0, 0, 0, 0.55, 0.13)
	CurrentOptionBorder:setupNineSliceShader(25, 4)
	CurrentOptionBorder:linkToElementModel(self, "optionCount", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CurrentOptionBorder:setShaderVector(1, SetVectorComponent(2, 1, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4)))
		end
	end)
	CurrentOptionBorder:linkToElementModel(self, "currentValue", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CurrentOptionBorder:setShaderVector(2, CoD.PCWidgetUtility.GetSettingSliderPagination(self, self:getModel(), CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4)))
		end
	end)
	self:addElement(CurrentOptionBorder)
	self.CurrentOptionBorder = CurrentOptionBorder
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsElementInState(element, "DefaultState") then
			SetElementStateByElementName(self, "left", controller, "DefaultState")
			SetElementStateByElementName(self, "right", controller, "DefaultState")
		elseif IsElementInState(element, "ArrowsHidden") then
			SetElementStateByElementName(self, "left", controller, "Hidden")
			SetElementStateByElementName(self, "right", controller, "Hidden")
		else
			UpdateElementState(self, "left", controller)
			UpdateElementState(self, "right", controller)
		end
	end)
	center.id = "center"
	right.id = "right"
	left.id = "left"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	DisableKeyboardNavigationByElement(self.right)
	DisableKeyboardNavigationByElement(self.left)
	SetElementProperty(self.left, "_isLeft", true)
	CoD.PCWidgetUtility.EnableShrinkToFit(TextBox)
	return self
end
CoD.CyclingList_ItemControl.__resetProperties = function(f8_arg0)
	f8_arg0.left:completeAnimation()
	f8_arg0.right:completeAnimation()
	f8_arg0.TextBox:completeAnimation()
	f8_arg0.left:setAlpha(1)
	f8_arg0.right:setAlpha(1)
	f8_arg0.TextBox:setAlpha(1)
end
CoD.CyclingList_ItemControl.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Unavailable = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.TextBox:completeAnimation()
			f10_arg0.TextBox:setAlpha(0.3)
			f10_arg0.clipFinished(f10_arg0.TextBox)
			f10_arg0.right:completeAnimation()
			f10_arg0.right:setAlpha(0.3)
			f10_arg0.clipFinished(f10_arg0.right)
			f10_arg0.left:completeAnimation()
			f10_arg0.left:setAlpha(0.3)
			f10_arg0.clipFinished(f10_arg0.left)
		end,
	},
	ArrowsHidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.right:completeAnimation()
			f11_arg0.right:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.right)
			f11_arg0.left:completeAnimation()
			f11_arg0.left:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.left)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.right:completeAnimation()
			f12_arg0.right:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.right)
			f12_arg0.left:completeAnimation()
			f12_arg0.left:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.left)
		end,
	},
	LeftArrowHidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	RightArrowHidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CyclingList_ItemControl.__onClose = function(f15_arg0)
	f15_arg0.center:close()
	f15_arg0.TextBox:close()
	f15_arg0.right:close()
	f15_arg0.left:close()
	f15_arg0.PCHighlightBorder:close()
	f15_arg0.OptionCountBorder:close()
	f15_arg0.CurrentOptionBorder:close()
end
