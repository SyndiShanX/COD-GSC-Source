require("ui/uieditor/widgets/emptyfocusable")
require("ui/uieditor/widgets/pc/craft/craftactionsliderwidget")
require("ui/uieditor/widgets/pc/sliderbar_editbox")
CoD.CraftActionSlider = InheritFrom(LUI.UIElement)
CoD.CraftActionSlider.__defaultWidth = 375
CoD.CraftActionSlider.__defaultHeight = 60
CoD.CraftActionSlider.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftActionSlider)
	self.id = "CraftActionSlider"
	self.soundSet = "SelectColor"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setAlpha(0.95)
	Background:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	Background:setShaderVector(0, 0, 0, 0, 0)
	Background:setupNineSliceShader(196, 88)
	self:addElement(Background)
	self.Background = Background
	local BackingFocus = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingFocus:setRGB(0.84, 0.82, 0.74)
	BackingFocus:setAlpha(0)
	self:addElement(BackingFocus)
	self.BackingFocus = BackingFocus
	local EditBox = CoD.SliderBar_EditBox.new(f1_arg0, f1_arg1, 0, 0, 315, 375, 0, 0, 0, 60)
	EditBox.PCHighlightBorder:setAlpha(0.3)
	self:addElement(EditBox)
	self.EditBox = EditBox
	local CraftActionSliderWidget = CoD.CraftActionSliderWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 315, 0, 0, 0, 60)
	CraftActionSliderWidget:linkToElementModel(self, nil, false, function(model)
		CraftActionSliderWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CraftActionSliderWidget)
	self.CraftActionSliderWidget = CraftActionSliderWidget
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.5, -187.5, 187.5, 0.5, 0.5, -30, 30)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self:mergeStateConditions({
		{
			stateName = "Disabled",
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
	EditBox.id = "EditBox"
	CraftActionSliderWidget.id = "CraftActionSliderWidget"
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	if IsPC() then
		CoD.PCUtility.CraftActionSliderBindDrag(self, self.CraftActionSliderWidget, f1_arg1, f1_arg0)
		CoD.PCUtility.SetCraftActionStatusModel(self, self.CraftActionSliderWidget, f1_arg1, f1_arg0)
		CoD.PCUtility.SetSliderValueModel(self, self.CraftActionSliderWidget, f1_arg1, f1_arg0)
		CoD.PCUtility.CraftLockFocusOnDrag(self.CraftActionSliderWidget, f1_arg1, f1_arg0)
		CoD.PCUtility.CraftActionSliderSetInputBox(self, self.EditBox, f1_arg1, f1_arg0)
		CoD.PCUtility.SetElementEditBoxMaxChar(self.EditBox, 4)
	end
	return self
end
CoD.CraftActionSlider.__resetProperties = function(f5_arg0)
	f5_arg0.EditBox:completeAnimation()
	f5_arg0.BackingFocus:completeAnimation()
	f5_arg0.EditBox:setTopBottom(0, 0, 0, 60)
	f5_arg0.BackingFocus:setAlpha(0)
end
CoD.CraftActionSlider.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.EditBox:completeAnimation()
			f6_arg0.EditBox:setTopBottom(0, 0, 0, 60)
			f6_arg0.clipFinished(f6_arg0.EditBox)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.BackingFocus:completeAnimation()
			f7_arg0.BackingFocus:setAlpha(0.03)
			f7_arg0.clipFinished(f7_arg0.BackingFocus)
			f7_arg0.EditBox:completeAnimation()
			f7_arg0.EditBox:setTopBottom(0, 0, 0, 60)
			f7_arg0.clipFinished(f7_arg0.EditBox)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.BackingFocus:beginAnimation(200)
				f8_arg0.BackingFocus:setAlpha(0.03)
				f8_arg0.BackingFocus:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.BackingFocus:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.BackingFocus:completeAnimation()
			f8_arg0.BackingFocus:setAlpha(0)
			f8_local0(f8_arg0.BackingFocus)
			f8_arg0.EditBox:completeAnimation()
			f8_arg0.EditBox:setTopBottom(0, 0, 0, 60)
			f8_arg0.clipFinished(f8_arg0.EditBox)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				f10_arg0.BackingFocus:beginAnimation(200)
				f10_arg0.BackingFocus:setAlpha(0)
				f10_arg0.BackingFocus:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.BackingFocus:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.BackingFocus:completeAnimation()
			f10_arg0.BackingFocus:setAlpha(0.03)
			f10_local0(f10_arg0.BackingFocus)
			f10_arg0.EditBox:completeAnimation()
			f10_arg0.EditBox:setTopBottom(0, 0, 0, 60)
			f10_arg0.clipFinished(f10_arg0.EditBox)
		end,
	},
	Disabled = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CraftActionSlider.__onClose = function(f13_arg0)
	f13_arg0.EditBox:close()
	f13_arg0.CraftActionSliderWidget:close()
	f13_arg0.emptyFocusable:close()
end
