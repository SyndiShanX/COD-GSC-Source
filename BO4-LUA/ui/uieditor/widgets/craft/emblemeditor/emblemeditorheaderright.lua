CoD.EmblemEditorHeaderRight = InheritFrom(LUI.UIElement)
CoD.EmblemEditorHeaderRight.__defaultWidth = 320
CoD.EmblemEditorHeaderRight.__defaultHeight = 37
CoD.EmblemEditorHeaderRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorHeaderRight)
	self.id = "EmblemEditorHeaderRight"
	self.soundSet = "default"
	local text = LUI.UIText.new(0, 0, 1.5, 319.5, 0, 0, 4, 19)
	text:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_463E51BFF17859F1"))
	text:setTTF("ttmussels_demibold")
	text:setLetterSpacing(6)
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(text)
	self.text = text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
