require("x64:f5618b9151603a5")
require("x64:34778f864da9dda")
CoD.WarzoneMapKeyItemWithPlayerIcon = InheritFrom(LUI.UIElement)
CoD.WarzoneMapKeyItemWithPlayerIcon.__defaultWidth = 256
CoD.WarzoneMapKeyItemWithPlayerIcon.__defaultHeight = 40
CoD.WarzoneMapKeyItemWithPlayerIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.WarzoneMapKeyItemWithPlayerIcon)
	self.id = "WarzoneMapKeyItemWithPlayerIcon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ControllerDependentTextBox = nil
	ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0, 0, 0, 0, 0, 0, 19, 41)
	ControllerDependentTextBox:setAlpha(0)
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	local Image = LUI.UIImage.new(0, 0, 10, 46, 0, 0, 2, 38)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	Image:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local Action = LUI.UIText.new(0, 0, 56, 226, 0, 0, 7, 34)
	Action:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Action:setTTF("ttmussels_regular")
	Action:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Action:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Action)
	self.Action = Action
	local WarzonePlayerArrow = CoD.WarzonePlayerArrow.new(f1_arg0, f1_arg1, 0, 0, 233, 266, 0.5, 0.5, -16.5, 16.5)
	WarzonePlayerArrow.arrow.__arrow_Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			WarzonePlayerArrow.arrow:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f2_local0))
		end
	end
	WarzonePlayerArrow:subscribeToGlobalModel(f1_arg1, "PerClient", "clientNum", WarzonePlayerArrow.arrow.__arrow_Color)
	WarzonePlayerArrow.arrow.__arrow_Color_FullPath = function()
		local f3_local0 = DataSources.PerClient.getModel(f1_arg1)
		f3_local0 = f3_local0.clientNum
		if f3_local0 then
			WarzonePlayerArrow.arrow.__arrow_Color(f3_local0)
		end
	end
	self:addElement(WarzonePlayerArrow)
	self.WarzonePlayerArrow = WarzonePlayerArrow
	WarzonePlayerArrow:linkToElementModel(self, "team", true, WarzonePlayerArrow.arrow.__arrow_Color_FullPath)
	local f1_local5 = WarzonePlayerArrow
	local f1_local6 = WarzonePlayerArrow.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["profile.colorblindMode"], WarzonePlayerArrow.arrow.__arrow_Color_FullPath)
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
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f7_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneMapKeyItemWithPlayerIcon.__resetProperties = function(f9_arg0)
	f9_arg0.Image:completeAnimation()
	f9_arg0.ControllerDependentTextBox:completeAnimation()
	f9_arg0.Action:completeAnimation()
	f9_arg0.Image:setAlpha(1)
	f9_arg0.Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	f9_arg0.Image:setShaderVector(0, 1, 0, 0, 0)
	f9_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 0)
	f9_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 19, 41)
	f9_arg0.ControllerDependentTextBox:setAlpha(0)
	f9_arg0.Action:setLeftRight(0, 0, 56, 226)
	f9_arg0.Action:setAlpha(1)
end
CoD.WarzoneMapKeyItemWithPlayerIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	NotAvailablePC = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.ControllerDependentTextBox:completeAnimation()
			f11_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 88)
			f11_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 18, 40)
			f11_arg0.ControllerDependentTextBox:setAlpha(0.1)
			f11_arg0.clipFinished(f11_arg0.ControllerDependentTextBox)
			f11_arg0.Image:completeAnimation()
			f11_arg0.Image:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Image)
			f11_arg0.Action:completeAnimation()
			f11_arg0.Action:setLeftRight(0, 0, 78, 183)
			f11_arg0.Action:setAlpha(0.1)
			f11_arg0.clipFinished(f11_arg0.Action)
		end,
	},
	NotAvailable = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setAlpha(0.15)
			f12_arg0.Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
			f12_arg0.Image:setShaderVector(0, 0, 0, 0, 0)
			f12_arg0.clipFinished(f12_arg0.Image)
			f12_arg0.Action:completeAnimation()
			f12_arg0.Action:setAlpha(0.15)
			f12_arg0.clipFinished(f12_arg0.Action)
		end,
	},
	PC = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.ControllerDependentTextBox:completeAnimation()
			f13_arg0.ControllerDependentTextBox:setLeftRight(0, 0, 0, 88)
			f13_arg0.ControllerDependentTextBox:setTopBottom(0, 0, 18, 40)
			f13_arg0.ControllerDependentTextBox:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.ControllerDependentTextBox)
			f13_arg0.Image:completeAnimation()
			f13_arg0.Image:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Image)
			f13_arg0.Action:completeAnimation()
			f13_arg0.Action:setLeftRight(0, 0, 78, 183)
			f13_arg0.clipFinished(f13_arg0.Action)
		end,
	},
}
CoD.WarzoneMapKeyItemWithPlayerIcon.__onClose = function(f14_arg0)
	f14_arg0.ControllerDependentTextBox:close()
	f14_arg0.WarzonePlayerArrow:close()
end
