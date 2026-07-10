CoD.PC_BnetStore_DevsLogos = InheritFrom(LUI.UIElement)
CoD.PC_BnetStore_DevsLogos.__defaultWidth = 1920
CoD.PC_BnetStore_DevsLogos.__defaultHeight = 25
CoD.PC_BnetStore_DevsLogos.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.PC_BnetStore_DevsLogos)
	self.id = "PC_BnetStore_DevsLogos"
	self.soundSet = "default"
	local PublishedBy = LUI.UIText.new(0, 0, 694.5, 794.5, 0, 0, 7, 25)
	PublishedBy:setAlpha(0.1)
	PublishedBy:setText(LocalizeToUpperString(@"hash_747FC15FF6D0BE"))
	PublishedBy:setTTF("dinnext_regular")
	PublishedBy:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(PublishedBy)
	self.PublishedBy = PublishedBy
	local ActivisionLogo = LUI.UIFixedAspectRatioImage.new(0, 0, 798.5, 905.5, 0, 0, 0, 25)
	ActivisionLogo:setRGB(0.5, 0.5, 0.5)
	ActivisionLogo:setImage(RegisterImage(@"uie_pc_bnetstore_activisionlogo"))
	self:addElement(ActivisionLogo)
	self.ActivisionLogo = ActivisionLogo
	local DevelopedBy = LUI.UIText.new(0, 0, 909.5, 1019.5, 0, 0, 7, 25)
	DevelopedBy:setAlpha(0.1)
	DevelopedBy:setText(LocalizeToUpperString(@"hash_44F5C1473561F4C4"))
	DevelopedBy:setTTF("dinnext_regular")
	DevelopedBy:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(DevelopedBy)
	self.DevelopedBy = DevelopedBy
	local TreyarchLogo = LUI.UIFixedAspectRatioImage.new(0, 0, 1023.5, 1118.5, 0, 0, 0, 25)
	TreyarchLogo:setRGB(0.5, 0.5, 0.5)
	TreyarchLogo:setImage(RegisterImage(@"uie_pc_bnetstore_treyarchlogo"))
	self:addElement(TreyarchLogo)
	self.TreyarchLogo = TreyarchLogo
	local BeenoxLogo = LUI.UIFixedAspectRatioImage.new(0, 0, 1122.5, 1225.5, 0, 0, 0, 25)
	BeenoxLogo:setRGB(0.5, 0.5, 0.5)
	BeenoxLogo:setImage(RegisterImage(@"uie_pc_bnetstore_beenoxlogo"))
	self:addElement(BeenoxLogo)
	self.BeenoxLogo = BeenoxLogo
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
