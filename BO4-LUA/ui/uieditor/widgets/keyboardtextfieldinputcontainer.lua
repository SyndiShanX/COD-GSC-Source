require("x64:75777a3809eb976")
CoD.KeyboardTextFieldInputContainer = InheritFrom(LUI.UIElement)
CoD.KeyboardTextFieldInputContainer.__defaultWidth = 200
CoD.KeyboardTextFieldInputContainer.__defaultHeight = 72
CoD.KeyboardTextFieldInputContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KeyboardTextFieldInputContainer)
	self.id = "KeyboardTextFieldInputContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local nameBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	nameBackground:setRGB(0.5, 0.5, 0.5)
	nameBackground:setAlpha(0.5)
	self:addElement(nameBackground)
	self.nameBackground = nameBackground
	local inputText = LUI.UIText.new(0, 0.98, 5, 5, 0, 1, 0, 0)
	inputText:setText("")
	inputText:setTTF("notosans_regular")
	inputText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	inputText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(inputText)
	self.inputText = inputText
	local cursorText = CoD.KeyboardTextFieldInputCursor.new(f1_arg0, f1_arg1, 0, 0, -1, 194, 0, 1, 0, 0)
	self:addElement(cursorText)
	self.cursorText = cursorText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KeyboardTextFieldInputContainer.__onClose = function(f2_arg0)
	f2_arg0.cursorText:close()
end
