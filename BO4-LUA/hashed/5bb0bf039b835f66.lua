require("x64:ce485b24bba006e")
CoD.PC_Theater_Keyboard_Shortcut_Container = InheritFrom(LUI.UIElement)
CoD.PC_Theater_Keyboard_Shortcut_Container.__defaultWidth = 280
CoD.PC_Theater_Keyboard_Shortcut_Container.__defaultHeight = 50
CoD.PC_Theater_Keyboard_Shortcut_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Theater_Keyboard_Shortcut_Container)
	self.id = "PC_Theater_Keyboard_Shortcut_Container"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0.17, 0.16, 0.15)
	Image:setAlpha(0.5)
	self:addElement(Image)
	self.Image = Image
	local Shortcut = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0, 1, 10, -10, 0.5, 0.5, -25, 25)
	Shortcut:setAlpha(0.8)
	Shortcut:setScale(0.9, 0.9)
	Shortcut.KeyPrompt.Border:setAlpha(0.3)
	Shortcut:linkToElementModel(self, nil, false, function(model)
		Shortcut:setModel(model, f1_arg1)
	end)
	Shortcut:linkToElementModel(self, "keyprompt", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Shortcut.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	Shortcut:linkToElementModel(self, "text", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Shortcut.Text.Text:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Shortcut)
	self.Shortcut = Shortcut
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Theater_Keyboard_Shortcut_Container.__onClose = function(f5_arg0)
	f5_arg0.Shortcut:close()
end
