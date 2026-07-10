CoD.leaguePlayEndRankRulesRewards = InheritFrom(LUI.UIElement)
CoD.leaguePlayEndRankRulesRewards.__defaultWidth = 210
CoD.leaguePlayEndRankRulesRewards.__defaultHeight = 350
CoD.leaguePlayEndRankRulesRewards.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.leaguePlayEndRankRulesRewards)
	self.id = "leaguePlayEndRankRulesRewards"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WhiteBacking = LUI.UIImage.new(0, 0, 0, 210, 0, 0, 0, 350)
	WhiteBacking:setAlpha(0.02)
	WhiteBacking:setImage(RegisterImage(0x7167D8C33A06020))
	WhiteBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	WhiteBacking:setShaderVector(0, 0, 0, 0, 0)
	WhiteBacking:setupNineSliceShader(64, 64)
	self:addElement(WhiteBacking)
	self.WhiteBacking = WhiteBacking
	local DarkBacking = LUI.UIImage.new(0, 0, 0, 210, 0, 0, 263, 350)
	DarkBacking:setAlpha(0.25)
	DarkBacking:setImage(RegisterImage(0x34839E8065B1E53))
	DarkBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	DarkBacking:setShaderVector(0, 0, 0, 0, 0)
	DarkBacking:setupNineSliceShader(196, 88)
	self:addElement(DarkBacking)
	self.DarkBacking = DarkBacking
	local infoBracketBot = LUI.UIImage.new(0, 0, -1, 211, 0, 0, 343.5, 351.5)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local DotLine = LUI.UIImage.new(0, 0, -1, 210, 0, 0, 261, 265)
	DotLine:setAlpha(0.2)
	DotLine:setImage(RegisterImage(0xB20AD7A31239369))
	DotLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	DotLine:setShaderVector(0, 0, 0, 0, 0)
	DotLine:setupNineSliceShader(16, 4)
	self:addElement(DotLine)
	self.DotLine = DotLine
	local Top25 = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 205.5, 232.5)
	Top25:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Top25:setText(Engine[0xF9F1239CFD921FE](0xD0694434493E4B6))
	Top25:setTTF("ttmussels_demibold")
	Top25:setLetterSpacing(2)
	Top25:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Top25:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Top25)
	self.Top25 = Top25
	local Reward = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 276, 297)
	Reward:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Reward:setText(LocalizeToUpperString(0xAE84A67016185))
	Reward:setTTF("ttmussels_demibold")
	Reward:setLetterSpacing(6)
	Reward:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Reward:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Reward)
	self.Reward = Reward
	local BronzeRankIcon = LUI.UIImage.new(0, 0, 5, 205, 0, 0, 0, 200)
	BronzeRankIcon:setImage(RegisterImage(0xF6D3B20E1974FD1))
	self:addElement(BronzeRankIcon)
	self.BronzeRankIcon = BronzeRankIcon
	local TopTriangle = LUI.UIImage.new(0, 0, -18.5, 50.5, 0, 0, 111, 144)
	TopTriangle:setRGB(0, 0, 0)
	TopTriangle:setAlpha(0)
	TopTriangle:setZRot(90)
	TopTriangle:setImage(RegisterImage(0xE8103AAF0932DB4))
	self:addElement(TopTriangle)
	self.TopTriangle = TopTriangle
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.leaguePlayEndRankRulesRewards.__resetProperties = function(f2_arg0)
	f2_arg0.Reward:completeAnimation()
	f2_arg0.Top25:completeAnimation()
	f2_arg0.Reward:setTopBottom(0, 0, 276, 297)
	f2_arg0.Top25:setTopBottom(0, 0, 205.5, 232.5)
end
CoD.leaguePlayEndRankRulesRewards.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Top25:completeAnimation()
			f4_arg0.Top25:setTopBottom(0, 0, 205.5, 227.5)
			f4_arg0.clipFinished(f4_arg0.Top25)
			f4_arg0.Reward:completeAnimation()
			f4_arg0.Reward:setTopBottom(0, 0, 276, 292)
			f4_arg0.clipFinished(f4_arg0.Reward)
		end,
	},
}
