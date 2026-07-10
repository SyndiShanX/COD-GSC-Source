require("x64:34778f864da9dda")
CoD.WarzoneMapKeyItem = InheritFrom(LUI.UIElement)
CoD.WarzoneMapKeyItem.__defaultWidth = 256
CoD.WarzoneMapKeyItem.__defaultHeight = 40
CoD.WarzoneMapKeyItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.WarzoneMapKeyItem)
	self.id = "WarzoneMapKeyItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ControllerDependentTextBox = nil
	ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0, 0, 0, 0, 0, 0, 19, 41)
	ControllerDependentTextBox:setAlpha(0)
	ControllerDependentTextBox.GamepadText:setText("")
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	local Image = LUI.UIImage.new(0, 0, 10, 46, 0, 0, 2.5, 38.5)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	Image:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local Action = LUI.UIText.new(0, 0, 56, 256, 0, 0, 7, 34)
	Action:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Action:setTTF("ttmussels_regular")
	Action:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Action:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Action)
	self.Action = Action
	self:mergeStateConditions({
		{
			stateName = "Available",
			condition = function(menu, element, event)
				return not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "NotAvailablePC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneMapKeyItem.__resetProperties = function(f7_arg0)
	f7_arg0.Image:completeAnimation()
	f7_arg0.Action:completeAnimation()
	f7_arg0.ControllerDependentTextBox:completeAnimation()
	f7_arg0.Image:setLeftRight(0, 0, 10, 46)
	f7_arg0.Image:setAlpha(1)
	f7_arg0.Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	f7_arg0.Image:setShaderVector(0, 1, 0, 0, 0)
	f7_arg0.Action:setLeftRight(0, 0, 56, 256)
	f7_arg0.Action:setAlpha(1)
	f7_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 0)
	f7_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 19, 41)
	f7_arg0.ControllerDependentTextBox:setAlpha(0)
end
CoD.WarzoneMapKeyItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Image:completeAnimation()
			f8_arg0.Image:setAlpha(0.1)
			f8_arg0.Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
			f8_arg0.Image:setShaderVector(0, 0, 0, 0, 0)
			f8_arg0.clipFinished(f8_arg0.Image)
			f8_arg0.Action:completeAnimation()
			f8_arg0.Action:setAlpha(0.1)
			f8_arg0.clipFinished(f8_arg0.Action)
		end,
	},
	Available = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.ControllerDependentTextBox:completeAnimation()
			f10_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 89)
			f10_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 17, 39)
			f10_arg0.ControllerDependentTextBox:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.ControllerDependentTextBox)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setLeftRight(0, 0, 10, 10)
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.Action:completeAnimation()
			f10_arg0.Action:setLeftRight(0, 0, 78, 183)
			f10_arg0.clipFinished(f10_arg0.Action)
		end,
	},
	NotAvailablePC = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.ControllerDependentTextBox:completeAnimation()
			f11_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 89)
			f11_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 17, 39)
			f11_arg0.ControllerDependentTextBox:setAlpha(0.1)
			f11_arg0.clipFinished(f11_arg0.ControllerDependentTextBox)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setLeftRight(0, 0, 10, 10)
			f11_arg0.Image:setAlpha(0)
			f11_arg0.Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
			f11_arg0.Image:setShaderVector(0, 0, 0, 0, 0)
			f11_arg0.clipFinished(f11_arg0.Image)
			f11_arg0.Action:completeAnimation()
			f11_arg0.Action:setLeftRight(0, 0, 78, 183)
			f11_arg0.Action:setAlpha(0.1)
			f11_arg0.clipFinished(f11_arg0.Action)
		end,
	},
}
CoD.WarzoneMapKeyItem.__onClose = function(f12_arg0)
	f12_arg0.ControllerDependentTextBox:close()
end
