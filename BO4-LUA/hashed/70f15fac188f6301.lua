CoD.PC_Korea_Event_PopUp_Reward = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_PopUp_Reward.__defaultWidth = 724
CoD.PC_Korea_Event_PopUp_Reward.__defaultHeight = 724
CoD.PC_Korea_Event_PopUp_Reward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_PopUp_Reward)
	self.id = "PC_Korea_Event_PopUp_Reward"
	self.soundSet = "default"
	local Glow = LUI.UIImage.new(-0.02, 1.02, 0, 0, -0.02, 1.02, 0, 0)
	Glow:setRGB(0.82, 1, 0.49)
	Glow:setImage(RegisterImage(0xC8FFEE47F8B6B31))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Glow:setShaderVector(0, 0, 0, 0, 0)
	Glow:setupNineSliceShader(40, 40)
	self:addElement(Glow)
	self.Glow = Glow
	local RewardPopUp = LUI.UIImage.new(0.5, 0.5, -362, 362, 0.5, 0.5, -362, 362)
	RewardPopUp:setRGB(0, 0, 0)
	self:addElement(RewardPopUp)
	self.RewardPopUp = RewardPopUp
	local RewardItemImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RewardItemImage:setImage(RegisterImage(0x9F43DEC3185DE44))
	self:addElement(RewardItemImage)
	self.RewardItemImage = RewardItemImage
	local IncludeRewardItemImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage:setAlpha(0)
	IncludeRewardItemImage:setImage(RegisterImage(0xCA98E2B6402251C))
	self:addElement(IncludeRewardItemImage)
	self.IncludeRewardItemImage = IncludeRewardItemImage
	local IncludeRewardItemImage4 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage4:setAlpha(0)
	IncludeRewardItemImage4:setImage(RegisterImage(0xCA98B2B64022003))
	self:addElement(IncludeRewardItemImage4)
	self.IncludeRewardItemImage4 = IncludeRewardItemImage4
	local IncludeRewardItemImage3 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage3:setAlpha(0)
	IncludeRewardItemImage3:setImage(RegisterImage(0xCA9902B64022882))
	self:addElement(IncludeRewardItemImage3)
	self.IncludeRewardItemImage3 = IncludeRewardItemImage3
	local IncludeRewardItemImage2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage2:setAlpha(0)
	IncludeRewardItemImage2:setImage(RegisterImage(0xCA9912B64022A35))
	self:addElement(IncludeRewardItemImage2)
	self.IncludeRewardItemImage2 = IncludeRewardItemImage2
	local TitleBG = LUI.UIImage.new(0.5, 0.5, -370, 370, 0.93, 0.93, -60, 60)
	TitleBG:setImage(RegisterImage(0x5C0E8389511B30B))
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local UnlockedTextBox = LUI.UIText.new(0.5, 0.5, -357, 357, 1, 1, -68, -38)
	UnlockedTextBox:setRGB(0, 0, 0)
	UnlockedTextBox:setText(Engine[0xF9F1239CFD921FE](0x6651EB45C4C8896))
	UnlockedTextBox:setTTF("ttmussels_demibold")
	UnlockedTextBox:setLetterSpacing(4)
	UnlockedTextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	UnlockedTextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(UnlockedTextBox)
	self.UnlockedTextBox = UnlockedTextBox
	local ItemNameTextBox = LUI.UIText.new(0.5, 0.5, -353.5, 353.5, 1, 1, -34, -7)
	ItemNameTextBox:setRGB(0, 0, 0)
	ItemNameTextBox:setText("")
	ItemNameTextBox:setTTF("ttmussels_regular")
	ItemNameTextBox:setLetterSpacing(4)
	ItemNameTextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ItemNameTextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ItemNameTextBox)
	self.ItemNameTextBox = ItemNameTextBox
	local Bracket = LUI.UIImage.new(-0, 1, 0, 0, 0, 0, -2, 10)
	Bracket:setZRot(180)
	Bracket:setImage(RegisterImage(0xC325BED3F226657))
	Bracket:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Bracket:setShaderVector(0, 0, 0, 0, 0)
	Bracket:setupNineSliceShader(20, 8)
	self:addElement(Bracket)
	self.Bracket = Bracket
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
