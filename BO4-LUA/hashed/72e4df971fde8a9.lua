require("x64:be779d5e87238aa")
CoD.PC_BountyHunterBuy_BackButton = InheritFrom(LUI.UIElement)
CoD.PC_BountyHunterBuy_BackButton.__defaultWidth = 200
CoD.PC_BountyHunterBuy_BackButton.__defaultHeight = 60
CoD.PC_BountyHunterBuy_BackButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BountyHunterBuy_BackButton)
	self.id = "PC_BountyHunterBuy_BackButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 1, 1, -60, 0)
	Button.ButtonContainer.Title:setText(LocalizeToUpperString(0x6C253CF816B40B5))
	self:addElement(Button)
	self.Button = Button
	local GamepadTitle = LUI.UIText.new(0, 0, 54, 254, 0.5, 0.5, -10.5, 11.5)
	GamepadTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GamepadTitle:setAlpha(0)
	GamepadTitle:setText(Engine[0xF9F1239CFD921FE](0x6C253CF816B40B5))
	GamepadTitle:setTTF("ttmussels_demibold")
	GamepadTitle:setLetterSpacing(3)
	GamepadTitle:setLineSpacing(1)
	GamepadTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(GamepadTitle)
	self.GamepadTitle = GamepadTitle
	local GamepadPrompt = LUI.UIImage.new(0, 0, 12, 44, 0.5, 0.5, -17.5, 14.5)
	GamepadPrompt:setAlpha(0)
	GamepadPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GamepadPrompt:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(GamepadPrompt)
	self.GamepadPrompt = GamepadPrompt
	self:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	Button.id = "Button"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_BountyHunterBuy_BackButton.__resetProperties = function(f6_arg0)
	f6_arg0.Button:completeAnimation()
	f6_arg0.GamepadTitle:completeAnimation()
	f6_arg0.GamepadPrompt:completeAnimation()
	f6_arg0.Button:setAlpha(1)
	f6_arg0.GamepadTitle:setAlpha(0)
	f6_arg0.GamepadPrompt:setAlpha(0)
end
CoD.PC_BountyHunterBuy_BackButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Button:completeAnimation()
			f7_arg0.Button:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Button)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Button:completeAnimation()
			f8_arg0.Button:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Button)
		end,
	},
	Gamepad = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.Button:completeAnimation()
			f9_arg0.Button:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Button)
			f9_arg0.GamepadTitle:completeAnimation()
			f9_arg0.GamepadTitle:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.GamepadTitle)
			f9_arg0.GamepadPrompt:completeAnimation()
			f9_arg0.GamepadPrompt:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.GamepadPrompt)
		end,
	},
}
CoD.PC_BountyHunterBuy_BackButton.__onClose = function(f10_arg0)
	f10_arg0.Button:close()
	f10_arg0.GamepadPrompt:close()
end
