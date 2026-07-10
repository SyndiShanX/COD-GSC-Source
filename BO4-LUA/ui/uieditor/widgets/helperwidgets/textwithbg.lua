CoD.TextWithBg = InheritFrom(LUI.UIElement)
CoD.TextWithBg.__defaultWidth = 306
CoD.TextWithBg.__defaultHeight = 57
CoD.TextWithBg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TextWithBg)
	self.id = "TextWithBg"
	self.soundSet = "HUD"
	local Bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Bg:setRGB(0, 0, 0)
	self:addElement(Bg)
	self.Bg = Bg
	local Text = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -16.5, 16.5)
	Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Text:setTTF("dinnext_regular")
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Text)
	self.Text = Text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
