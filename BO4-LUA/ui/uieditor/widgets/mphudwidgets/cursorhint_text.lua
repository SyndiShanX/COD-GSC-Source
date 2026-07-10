CoD.cursorhint_text = InheritFrom(LUI.UIElement)
CoD.cursorhint_text.__defaultWidth = 522
CoD.cursorhint_text.__defaultHeight = 30
CoD.cursorhint_text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cursorhint_text)
	self.id = "cursorhint_text"
	self.soundSet = "HUD"
	local CursorHintText = LUI.UIText.new(0.5, 0.5, -259, 263, 0, 0, 0, 30)
	CursorHintText:setTTF("ttmussels_regular")
	CursorHintText:setLetterSpacing(0.5)
	CursorHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CursorHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CursorHintText:setBackingType(2)
	CursorHintText:setBackingColor(0, 0, 0)
	CursorHintText:setBackingAlpha(0.65)
	CursorHintText:setBackingXPadding(8)
	CursorHintText:subscribeToGlobalModel(f1_arg1, "HUDItems", "cursorHintText", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CursorHintText:setText(CoD.BaseUtility.LocalizeIfXHash(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(CursorHintText, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWrapped(self, element, 5, 0)
	end)
	self:addElement(CursorHintText)
	self.CursorHintText = CursorHintText
	local CursorHintText2 = LUI.UIText.new(0.5, 0.5, -259, 263, 0, 0, 39, 63)
	CursorHintText2:setTTF("ttmussels_demibold")
	CursorHintText2:setLetterSpacing(1)
	CursorHintText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CursorHintText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CursorHintText2:subscribeToGlobalModel(f1_arg1, "HUDItems", "cursorHintTextLine2", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CursorHintText2:setText(CoD.BaseUtility.LocalizeIfXHash(f4_local0))
		end
	end)
	self:addElement(CursorHintText2)
	self.CursorHintText2 = CursorHintText2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.cursorhint_text.__onClose = function(f5_arg0)
	f5_arg0.CursorHintText:close()
	f5_arg0.CursorHintText2:close()
end
