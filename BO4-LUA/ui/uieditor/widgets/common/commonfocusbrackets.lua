CoD.CommonFocusBrackets = InheritFrom(LUI.UIElement)
CoD.CommonFocusBrackets.__defaultWidth = 128
CoD.CommonFocusBrackets.__defaultHeight = 128
CoD.CommonFocusBrackets.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonFocusBrackets)
	self.id = "CommonFocusBrackets"
	self.soundSet = "FrontendMain"
	local FocusBracketTopLeft = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	FocusBracketTopLeft:setImage(RegisterImage(@"hash_4A9708B82FE1CB1D"))
	FocusBracketTopLeft:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(FocusBracketTopLeft)
	self.FocusBracketTopLeft = FocusBracketTopLeft
	local FocusBracketTopLeft3 = LUI.UIImage.new(0, 0, 0, 24, 1, 1, -24, 0)
	FocusBracketTopLeft3:setImage(RegisterImage(@"hash_23DC6565E1FF0015"))
	FocusBracketTopLeft3:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(FocusBracketTopLeft3)
	self.FocusBracketTopLeft3 = FocusBracketTopLeft3
	local FocusBracketTopLeft2 = LUI.UIImage.new(1, 1, -24, 0, 0, 0, 0, 24)
	FocusBracketTopLeft2:setImage(RegisterImage(@"hash_2AEB834D1A73FF56"))
	FocusBracketTopLeft2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(FocusBracketTopLeft2)
	self.FocusBracketTopLeft2 = FocusBracketTopLeft2
	local FocusBracketTopLeft4 = LUI.UIImage.new(1, 1, -24, 0, 1, 1, -24, 0)
	FocusBracketTopLeft4:setImage(RegisterImage(@"hash_3CA7475BC4D2AAEE"))
	FocusBracketTopLeft4:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(FocusBracketTopLeft4)
	self.FocusBracketTopLeft4 = FocusBracketTopLeft4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
