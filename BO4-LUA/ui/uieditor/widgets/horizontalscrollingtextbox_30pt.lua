CoD.horizontalScrollingTextBox_30pt = InheritFrom(LUI.UIElement)
CoD.horizontalScrollingTextBox_30pt.__defaultWidth = 900
CoD.horizontalScrollingTextBox_30pt.__defaultHeight = 51
CoD.horizontalScrollingTextBox_30pt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.horizontalScrollingTextBox_30pt)
	self.id = "horizontalScrollingTextBox_30pt"
	self.soundSet = "default"
	local textBox = LUI.UIText.new(0, 0, 0, 900, 1, 1, -45, 0)
	textBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	textBox:setTTF("default")
	textBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	textBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	textBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(textBox)
	self.textBox = textBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.TextUtility.SetupHorizontalScrollingWidget(self, f1_arg1)
	return self
end
