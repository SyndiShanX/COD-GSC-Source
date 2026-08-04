CoD.PC_StartMenu_Options_Controls_KeyVisual = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Controls_KeyVisual.__defaultWidth = 128
CoD.PC_StartMenu_Options_Controls_KeyVisual.__defaultHeight = 37
CoD.PC_StartMenu_Options_Controls_KeyVisual.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Controls_KeyVisual)
	self.id = "PC_StartMenu_Options_Controls_KeyVisual"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KeyText = LUI.UIText.new(0, 1, 8, -8, 0, 0, 6.5, 30.5)
	KeyText:setRGB(0.92, 0.92, 0.92)
	KeyText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	KeyText:setTTF("notosans_regular")
	KeyText:setLetterSpacing(1)
	KeyText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	KeyText:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	LUI.OverrideFunction_CallOriginalFirst(KeyText, "setText", function(element, controller) end)
	self:addElement(KeyText)
	self.KeyText = KeyText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_Controls_KeyVisual.__resetProperties = function(f3_arg0)
	f3_arg0.KeyText:completeAnimation()
	f3_arg0.KeyText:setAlpha(1)
end
CoD.PC_StartMenu_Options_Controls_KeyVisual.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.KeyText:completeAnimation()
			f4_arg0.KeyText:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.KeyText)
		end,
	},
}
