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
	Glow:setImage(RegisterImage(@"uie_korea_igrperks_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Glow:setShaderVector(0, 0, 0, 0, 0)
	Glow:setupNineSliceShader(40, 40)
	self:addElement(Glow)
	self.Glow = Glow
	local RewardPopUp = LUI.UIImage.new(0.5, 0.5, -362, 362, 0.5, 0.5, -362, 362)
	RewardPopUp:setRGB(0, 0, 0)
	self:addElement(RewardPopUp)
	self.RewardPopUp = RewardPopUp
	local RewardItemImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RewardItemImage:setImage(RegisterImage(@"hash_49F43DEC3185DE44"))
	self:addElement(RewardItemImage)
	self.RewardItemImage = RewardItemImage
	local IncludeRewardItemImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage:setAlpha(0)
	IncludeRewardItemImage:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_1"))
	self:addElement(IncludeRewardItemImage)
	self.IncludeRewardItemImage = IncludeRewardItemImage
	local IncludeRewardItemImage4 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage4:setAlpha(0)
	IncludeRewardItemImage4:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_4"))
	self:addElement(IncludeRewardItemImage4)
	self.IncludeRewardItemImage4 = IncludeRewardItemImage4
	local IncludeRewardItemImage3 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage3:setAlpha(0)
	IncludeRewardItemImage3:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_3"))
	self:addElement(IncludeRewardItemImage3)
	self.IncludeRewardItemImage3 = IncludeRewardItemImage3
	local IncludeRewardItemImage2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	IncludeRewardItemImage2:setAlpha(0)
	IncludeRewardItemImage2:setImage(RegisterImage(@"uie_ui_icon_igrevent_reward_2"))
	self:addElement(IncludeRewardItemImage2)
	self.IncludeRewardItemImage2 = IncludeRewardItemImage2
	local TitleBG = LUI.UIImage.new(0.5, 0.5, -370, 370, 0.93, 0.93, -60, 60)
	TitleBG:setImage(RegisterImage(@"uie_pc_igrevent_popup_reward_title_bg"))
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local UnlockedTextBox = LUI.UIText.new(0.5, 0.5, -357, 357, 1, 1, -68, -38)
	UnlockedTextBox:setRGB(0, 0, 0)
	UnlockedTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_76651EB45C4C8896"))
	UnlockedTextBox:setTTF("ttmussels_demibold")
	UnlockedTextBox:setLetterSpacing(4)
	UnlockedTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	UnlockedTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(UnlockedTextBox)
	self.UnlockedTextBox = UnlockedTextBox
	local ItemNameTextBox = LUI.UIText.new(0.5, 0.5, -353.5, 353.5, 1, 1, -34, -7)
	ItemNameTextBox:setRGB(0, 0, 0)
	ItemNameTextBox:setText("")
	ItemNameTextBox:setTTF("ttmussels_regular")
	ItemNameTextBox:setLetterSpacing(4)
	ItemNameTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ItemNameTextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ItemNameTextBox)
	self.ItemNameTextBox = ItemNameTextBox
	local Bracket = LUI.UIImage.new(-0, 1, 0, 0, 0, 0, -2, 10)
	Bracket:setZRot(180)
	Bracket:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	Bracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Bracket:setShaderVector(0, 0, 0, 0, 0)
	Bracket:setupNineSliceShader(20, 8)
	self:addElement(Bracket)
	self.Bracket = Bracket
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
