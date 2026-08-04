CoD.PC_EULA_Pages = InheritFrom(LUI.UIElement)
CoD.PC_EULA_Pages.__defaultWidth = 160
CoD.PC_EULA_Pages.__defaultHeight = 30
CoD.PC_EULA_Pages.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_EULA_Pages)
	self.id = "PC_EULA_Pages"
	self.soundSet = "none"
	local pageText = LUI.UIText.new(0, 0, 0, 160, 0, 0, 0, 30)
	pageText:setRGB(0.78, 0.74, 0.67)
	pageText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A205700391CF3AD"))
	pageText:setTTF("default")
	pageText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	pageText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(pageText)
	self.pageText = pageText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
