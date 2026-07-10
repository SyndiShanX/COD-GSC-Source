require("x64:ce485b24bba006e")
CoD.EmblemEditorPCLegend_Shortcuts = InheritFrom(LUI.UIElement)
CoD.EmblemEditorPCLegend_Shortcuts.__defaultWidth = 1680
CoD.EmblemEditorPCLegend_Shortcuts.__defaultHeight = 260
CoD.EmblemEditorPCLegend_Shortcuts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorPCLegend_Shortcuts)
	self.id = "EmblemEditorPCLegend_Shortcuts"
	self.soundSet = "default"
	local Shortcut = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -840, -520, 0.5, 0.5, -130, -80)
	Shortcut.KeyPrompt.keybind:setText(Engine[0xF9F1239CFD921FE](0x179662091387B23))
	Shortcut.Text.Text:setText(LocalizeToUpperString(0x2C331BE453CDAEF))
	self:addElement(Shortcut)
	self.Shortcut = Shortcut
	local PCTheaterKeyboardShortcut = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -840, -520, 0.5, 0.5, -78, -28)
	PCTheaterKeyboardShortcut.KeyPrompt.keybind:setText(Engine[0xF9F1239CFD921FE](0x179682091387E89))
	PCTheaterKeyboardShortcut.Text.Text:setText(LocalizeToUpperString(0x8B64A5838C604CF))
	self:addElement(PCTheaterKeyboardShortcut)
	self.PCTheaterKeyboardShortcut = PCTheaterKeyboardShortcut
	local PCTheaterKeyboardShortcut2 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -840, -520, 0.5, 0.5, -23, 27)
	PCTheaterKeyboardShortcut2.KeyPrompt.keybind:setText(Engine[0xF9F1239CFD921FE](0x179672091387CD6))
	PCTheaterKeyboardShortcut2.Text.Text:setText(LocalizeToUpperString(0x73BFA7879AB1AFB))
	self:addElement(PCTheaterKeyboardShortcut2)
	self.PCTheaterKeyboardShortcut2 = PCTheaterKeyboardShortcut2
	local PCTheaterKeyboardShortcut3 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, -180, 0.5, 0.5, -23, 27)
	PCTheaterKeyboardShortcut3.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_cutlayer}]"))
	PCTheaterKeyboardShortcut3.Text.Text:setText(LocalizeToUpperString(0x5464A3F4DF44C12))
	self:addElement(PCTheaterKeyboardShortcut3)
	self.PCTheaterKeyboardShortcut3 = PCTheaterKeyboardShortcut3
	local PCTheaterKeyboardShortcut4 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, -180, 0.5, 0.5, -78, -28)
	PCTheaterKeyboardShortcut4.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_3}]"))
	PCTheaterKeyboardShortcut4.Text.Text:setText(LocalizeToUpperString(0xAF5A7BE3F2E5B4))
	self:addElement(PCTheaterKeyboardShortcut4)
	self.PCTheaterKeyboardShortcut4 = PCTheaterKeyboardShortcut4
	local PCTheaterKeyboardShortcut5 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, -180, 0.5, 0.5, -130, -80)
	PCTheaterKeyboardShortcut5.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_copylayer}]"))
	PCTheaterKeyboardShortcut5.Text.Text:setText(LocalizeToUpperString(0xE59D47EA5E6ADB))
	self:addElement(PCTheaterKeyboardShortcut5)
	self.PCTheaterKeyboardShortcut5 = PCTheaterKeyboardShortcut5
	local PCTheaterKeyboardShortcut6 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, -180, 0.5, 0.5, 29, 79)
	PCTheaterKeyboardShortcut6.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_open}]"))
	PCTheaterKeyboardShortcut6.Text.Text:setText(LocalizeToUpperString(0xE3B3C6130E3F5E6))
	self:addElement(PCTheaterKeyboardShortcut6)
	self.PCTheaterKeyboardShortcut6 = PCTheaterKeyboardShortcut6
	local PCTheaterKeyboardShortcut7 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -160, 160, 0.5, 0.5, 29, 79)
	PCTheaterKeyboardShortcut7.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_toggleoutline}]"))
	PCTheaterKeyboardShortcut7.Text.Text:setText(LocalizeToUpperString(0x1C8C92FF05D1E02))
	self:addElement(PCTheaterKeyboardShortcut7)
	self.PCTheaterKeyboardShortcut7 = PCTheaterKeyboardShortcut7
	local PCTheaterKeyboardShortcut8 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -160, 160, 0.5, 0.5, -130, -80)
	PCTheaterKeyboardShortcut8.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_nexttab}]"))
	PCTheaterKeyboardShortcut8.Text.Text:setText(LocalizeToUpperString(0xC5454BB1B70DD54))
	self:addElement(PCTheaterKeyboardShortcut8)
	self.PCTheaterKeyboardShortcut8 = PCTheaterKeyboardShortcut8
	local PCTheaterKeyboardShortcut9 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -160, 160, 0.5, 0.5, -78, -28)
	PCTheaterKeyboardShortcut9.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_prevtab}]"))
	PCTheaterKeyboardShortcut9.Text.Text:setText(LocalizeToUpperString(0xFAF01AC3FA8F6E1))
	self:addElement(PCTheaterKeyboardShortcut9)
	self.PCTheaterKeyboardShortcut9 = PCTheaterKeyboardShortcut9
	local PCTheaterKeyboardShortcut10 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, -160, 160, 0.5, 0.5, -23, 27)
	PCTheaterKeyboardShortcut10.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_1}]"))
	PCTheaterKeyboardShortcut10.Text.Text:setText(LocalizeToUpperString(0x6CE39B8AAE490FC))
	self:addElement(PCTheaterKeyboardShortcut10)
	self.PCTheaterKeyboardShortcut10 = PCTheaterKeyboardShortcut10
	local PCTheaterKeyboardShortcut11 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 180, 500, 0.5, 0.5, 29, 79)
	PCTheaterKeyboardShortcut11.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_layerbottom}]"))
	PCTheaterKeyboardShortcut11.Text.Text:setText(LocalizeToUpperString(0xCD67DEBE479D01))
	self:addElement(PCTheaterKeyboardShortcut11)
	self.PCTheaterKeyboardShortcut11 = PCTheaterKeyboardShortcut11
	local PCTheaterKeyboardShortcut12 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 180, 500, 0.5, 0.5, -130, -80)
	PCTheaterKeyboardShortcut12.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_loweropacity}]"))
	PCTheaterKeyboardShortcut12.Text.Text:setText(LocalizeToUpperString(0xABDE746CBF32C0B))
	self:addElement(PCTheaterKeyboardShortcut12)
	self.PCTheaterKeyboardShortcut12 = PCTheaterKeyboardShortcut12
	local PCTheaterKeyboardShortcut13 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 180, 500, 0.5, 0.5, -78, -28)
	PCTheaterKeyboardShortcut13.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_raiseopacity}]"))
	PCTheaterKeyboardShortcut13.Text.Text:setText(LocalizeToUpperString(0xCA9444A7FF90A73))
	self:addElement(PCTheaterKeyboardShortcut13)
	self.PCTheaterKeyboardShortcut13 = PCTheaterKeyboardShortcut13
	local PCTheaterKeyboardShortcut14 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 180, 500, 0.5, 0.5, -23, 27)
	PCTheaterKeyboardShortcut14.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_layertop}]"))
	PCTheaterKeyboardShortcut14.Text.Text:setText(LocalizeToUpperString(0x9EA9FBA1D9EE194))
	self:addElement(PCTheaterKeyboardShortcut14)
	self.PCTheaterKeyboardShortcut14 = PCTheaterKeyboardShortcut14
	local PCTheaterKeyboardShortcut15 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 520, 840, 0.5, 0.5, -23, 27)
	PCTheaterKeyboardShortcut15.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_link}]"))
	PCTheaterKeyboardShortcut15.Text.Text:setText(LocalizeToUpperString(0x461F717A25E447B))
	self:addElement(PCTheaterKeyboardShortcut15)
	self.PCTheaterKeyboardShortcut15 = PCTheaterKeyboardShortcut15
	local PCTheaterKeyboardShortcut16 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 520, 840, 0.5, 0.5, -78, -28)
	PCTheaterKeyboardShortcut16.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_remove}]"))
	PCTheaterKeyboardShortcut16.Text.Text:setText(LocalizeToUpperString(0xA1DEAEC5B0FFB0F))
	self:addElement(PCTheaterKeyboardShortcut16)
	self.PCTheaterKeyboardShortcut16 = PCTheaterKeyboardShortcut16
	local PCTheaterKeyboardShortcut17 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 520, 840, 0.5, 0.5, -130, -80)
	PCTheaterKeyboardShortcut17.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_newlayer}]"))
	PCTheaterKeyboardShortcut17.Text.Text:setText(LocalizeToUpperString(0xE183CF1F7D46A06))
	self:addElement(PCTheaterKeyboardShortcut17)
	self.PCTheaterKeyboardShortcut17 = PCTheaterKeyboardShortcut17
	local PCTheaterKeyboardShortcut18 = CoD.PC_Theater_Keyboard_Shortcut.new(f1_arg0, f1_arg1, 0.5, 0.5, 520, 840, 0.5, 0.5, 29, 79)
	PCTheaterKeyboardShortcut18.KeyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_group}]"))
	PCTheaterKeyboardShortcut18.Text.Text:setText(LocalizeToUpperString(0xC94DB02C0AF2E2F))
	self:addElement(PCTheaterKeyboardShortcut18)
	self.PCTheaterKeyboardShortcut18 = PCTheaterKeyboardShortcut18
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorPCLegend_Shortcuts.__onClose = function(f2_arg0)
	f2_arg0.Shortcut:close()
	f2_arg0.PCTheaterKeyboardShortcut:close()
	f2_arg0.PCTheaterKeyboardShortcut2:close()
	f2_arg0.PCTheaterKeyboardShortcut3:close()
	f2_arg0.PCTheaterKeyboardShortcut4:close()
	f2_arg0.PCTheaterKeyboardShortcut5:close()
	f2_arg0.PCTheaterKeyboardShortcut6:close()
	f2_arg0.PCTheaterKeyboardShortcut7:close()
	f2_arg0.PCTheaterKeyboardShortcut8:close()
	f2_arg0.PCTheaterKeyboardShortcut9:close()
	f2_arg0.PCTheaterKeyboardShortcut10:close()
	f2_arg0.PCTheaterKeyboardShortcut11:close()
	f2_arg0.PCTheaterKeyboardShortcut12:close()
	f2_arg0.PCTheaterKeyboardShortcut13:close()
	f2_arg0.PCTheaterKeyboardShortcut14:close()
	f2_arg0.PCTheaterKeyboardShortcut15:close()
	f2_arg0.PCTheaterKeyboardShortcut16:close()
	f2_arg0.PCTheaterKeyboardShortcut17:close()
	f2_arg0.PCTheaterKeyboardShortcut18:close()
end
