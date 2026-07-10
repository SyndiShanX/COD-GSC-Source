CoD.AARGametypeHeader = InheritFrom(LUI.UIElement)
CoD.AARGametypeHeader.__defaultWidth = 1000
CoD.AARGametypeHeader.__defaultHeight = 150
CoD.AARGametypeHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARGametypeHeader)
	self.id = "AARGametypeHeader"
	self.soundSet = "none"
	local GametypeImage = LUI.UIImage.new(0, 0, 0, 120, 0, 0, 0, 120)
	GametypeImage:setAlpha(0.5)
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	local GametypeGlow = LUI.UIText.new(0, 0, 136, 991, 0, 0, 25, 100)
	GametypeGlow:setRGB(0.9, 0.89, 0.78)
	GametypeGlow:setAlpha(0)
	GametypeGlow:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/victory"))
	GametypeGlow:setTTF("ttmussels_demibold")
	GametypeGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	GametypeGlow:setShaderVector(0, 0.6, 0, 0, 0)
	GametypeGlow:setShaderVector(1, 0, 0, 0, 0)
	GametypeGlow:setShaderVector(2, 1, 1, 1, 0.6)
	GametypeGlow:setLetterSpacing(10)
	GametypeGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GametypeGlow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GametypeGlow)
	self.GametypeGlow = GametypeGlow
	local Gametype = LUI.UIText.new(0, 0, 132, 1000, 0, 0, 24, 99)
	Gametype:setRGB(0.9, 0.89, 0.78)
	Gametype:setAlpha(0.5)
	Gametype:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/victory"))
	Gametype:setTTF("ttmussels_demibold")
	Gametype:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Gametype:setLetterSpacing(10)
	Gametype:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Gametype:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Gametype)
	self.Gametype = Gametype
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
