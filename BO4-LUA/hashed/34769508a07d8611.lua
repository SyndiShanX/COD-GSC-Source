require("x64:e5724ea40c9bd4e")
require("x64:34778f864da9dda")
CoD.WarzoneMapKeyItemWithMarker = InheritFrom(LUI.UIElement)
CoD.WarzoneMapKeyItemWithMarker.__defaultWidth = 256
CoD.WarzoneMapKeyItemWithMarker.__defaultHeight = 40
CoD.WarzoneMapKeyItemWithMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneMapKeyItemWithMarker)
	self.id = "WarzoneMapKeyItemWithMarker"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ControllerDependentTextBox = nil
	ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0, 0, 0, 0, 0, 0, 19, 41)
	ControllerDependentTextBox:setAlpha(0)
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	local Image = LUI.UIImage.new(0, 0, 0, 36, 0, 0, 2, 38)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	Image:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local Action = LUI.UIText.new(0, 0, 46, 222, 0, 0, 6.5, 33.5)
	Action:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Action:setTTF("ttmussels_regular")
	Action:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Action:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Action)
	self.Action = Action
	local WarzonePlayerMarker = CoD.WarzonePlayerMarker.new(f1_arg0, f1_arg1, 0, 0, 222, 254, 0, 0, 4, 36)
	WarzonePlayerMarker:subscribeToGlobalModel(f1_arg1, "PerController", "clientModel", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WarzonePlayerMarker:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(WarzonePlayerMarker)
	self.WarzonePlayerMarker = WarzonePlayerMarker
	self:mergeStateConditions({
		{
			stateName = "NotAvailablePC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "NotAvailable",
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
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneMapKeyItemWithMarker.__resetProperties = function(f8_arg0)
	f8_arg0.Image:completeAnimation()
	f8_arg0.ControllerDependentTextBox:completeAnimation()
	f8_arg0.Action:completeAnimation()
	f8_arg0.WarzonePlayerMarker:completeAnimation()
	f8_arg0.Image:setAlpha(1)
	f8_arg0.Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	f8_arg0.Image:setShaderVector(0, 1, 0, 0, 0)
	f8_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 0)
	f8_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 19, 41)
	f8_arg0.ControllerDependentTextBox:setAlpha(0)
	f8_arg0.Action:setLeftRight(0, 0, 46, 222)
	f8_arg0.Action:setAlpha(1)
	f8_arg0.WarzonePlayerMarker:setLeftRight(0, 0, 222, 254)
	f8_arg0.WarzonePlayerMarker:setAlpha(1)
end
CoD.WarzoneMapKeyItemWithMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	NotAvailablePC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.ControllerDependentTextBox:completeAnimation()
			f10_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 88)
			f10_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 18, 40)
			f10_arg0.ControllerDependentTextBox:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.ControllerDependentTextBox)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.Action:completeAnimation()
			f10_arg0.Action:setLeftRight(0, 0, 78, 183)
			f10_arg0.Action:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.Action)
			f10_arg0.WarzonePlayerMarker:completeAnimation()
			f10_arg0.WarzonePlayerMarker:setLeftRight(0, 0, 220, 252)
			f10_arg0.WarzonePlayerMarker:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.WarzonePlayerMarker)
		end,
	},
	NotAvailable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setAlpha(0.15)
			f11_arg0.Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
			f11_arg0.Image:setShaderVector(0, 0, 0, 0, 0)
			f11_arg0.clipFinished(f11_arg0.Image)
			f11_arg0.Action:completeAnimation()
			f11_arg0.Action:setAlpha(0.15)
			f11_arg0.clipFinished(f11_arg0.Action)
			f11_arg0.WarzonePlayerMarker:completeAnimation()
			f11_arg0.WarzonePlayerMarker:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.WarzonePlayerMarker)
		end,
	},
	PC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.ControllerDependentTextBox:completeAnimation()
			f12_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 88)
			f12_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 18, 40)
			f12_arg0.ControllerDependentTextBox:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ControllerDependentTextBox)
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Image)
			f12_arg0.Action:completeAnimation()
			f12_arg0.Action:setLeftRight(0, 0, 78, 183)
			f12_arg0.clipFinished(f12_arg0.Action)
			f12_arg0.WarzonePlayerMarker:completeAnimation()
			f12_arg0.WarzonePlayerMarker:setLeftRight(0, 0, 220, 252)
			f12_arg0.clipFinished(f12_arg0.WarzonePlayerMarker)
		end,
	},
}
CoD.WarzoneMapKeyItemWithMarker.__onClose = function(f13_arg0)
	f13_arg0.ControllerDependentTextBox:close()
	f13_arg0.WarzonePlayerMarker:close()
end
