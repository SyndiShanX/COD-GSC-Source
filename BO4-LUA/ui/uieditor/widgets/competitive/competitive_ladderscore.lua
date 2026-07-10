CoD.Competitive_ladderScore = InheritFrom(LUI.UIElement)
CoD.Competitive_ladderScore.__defaultWidth = 300
CoD.Competitive_ladderScore.__defaultHeight = 105
CoD.Competitive_ladderScore.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Competitive_ladderScore)
	self.id = "Competitive_ladderScore"
	self.soundSet = "default"
	local PLUS2 = LUI.UIText.new(0.5, 0.5, -46, 187, 0.5, 0.5, -48.5, 56.5)
	PLUS2:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	PLUS2:setScale(1.25, 1.25)
	PLUS2:setText(200)
	PLUS2:setTTF("0arame_mono_stencil")
	PLUS2:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	PLUS2:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(PLUS2)
	self.PLUS2 = PLUS2
	local PLUS = LUI.UIText.new(0, 0, 3, 63, 0.5, 0.5, -52.5, 52.5)
	PLUS:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	PLUS:setScale(1.25, 1.25)
	PLUS:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/plus"))
	PLUS:setTTF("0arame_mono_stencil")
	PLUS:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	PLUS:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_center"]))
	PLUS:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(PLUS)
	self.PLUS = PLUS
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
