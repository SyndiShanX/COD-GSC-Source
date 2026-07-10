require("x64:c98cfa25d10d264")
require("x64:131dc032e61f49a")
require("x64:3df117288f991b5")
CoD.Footer_IGRPerksList = InheritFrom(LUI.UIElement)
CoD.Footer_IGRPerksList.__defaultWidth = 720
CoD.Footer_IGRPerksList.__defaultHeight = 260
CoD.Footer_IGRPerksList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Footer_IGRPerksList)
	self.id = "Footer_IGRPerksList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Backing = CoD.IGRPerksListBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local Title = CoD.IGRPerksListTitle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 60)
	self:addElement(Title)
	self.Title = Title
	local IGRPerk4 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 60, 124)
	IGRPerk4.PerkLogo:setImage(RegisterImage(0x5763B7981A030C))
	IGRPerk4.PerkText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_47610559D290D868"))
	self:addElement(IGRPerk4)
	self.IGRPerk4 = IGRPerk4
	local IGRPerk = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 350, 700, 0, 0, 60, 124)
	IGRPerk.PerkLogo:setImage(RegisterImage(@"hash_6C1460CF69AB482B"))
	IGRPerk.PerkText:setText(CoD.PCKoreaUtility.InjectBonusCredits(@"hash_1327C56902BCB8A5"))
	self:addElement(IGRPerk)
	self.IGRPerk = IGRPerk
	local IGRPerk3 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 124, 188)
	IGRPerk3.PerkLogo:setImage(RegisterImage(@"hash_5CFD527F0E4A01CE"))
	IGRPerk3.PerkText:setText(CoD.PCKoreaUtility.InjectBonusXP(@"hash_1D38DFFC56710A2B"))
	self:addElement(IGRPerk3)
	self.IGRPerk3 = IGRPerk3
	local IGRPerk2 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 188, 252)
	IGRPerk2.PerkLogo:setImage(RegisterImage(@"hash_58FBBCE5058992F3"))
	IGRPerk2.PerkText:setText(CoD.PCKoreaUtility.InjectBonusGunXP(@"hash_6936FCC81C9EE8D0"))
	self:addElement(IGRPerk2)
	self.IGRPerk2 = IGRPerk2
	local IGRPerk6 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 350, 700, 0, 0, 124, 188)
	IGRPerk6.PerkLogo:setImage(RegisterImage(@"hash_33C39A58A11F906E"))
	IGRPerk6.PerkText:setText(CoD.PCKoreaUtility.InjectBonusMerits(@"hash_33B9E184FC8CDACD"))
	self:addElement(IGRPerk6)
	self.IGRPerk6 = IGRPerk6
	local IGRPerk5 = CoD.IGRPerkElement.new(f1_arg0, f1_arg1, 0, 0, 350, 700, 0, 0, 188, 252)
	IGRPerk5.PerkLogo:setImage(RegisterImage(@"hash_4F762F7D1E478A24"))
	IGRPerk5.PerkText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2998B6D9C673F0E"))
	self:addElement(IGRPerk5)
	self.IGRPerk5 = IGRPerk5
	Backing.id = "Backing"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Footer_IGRPerksList.__onClose = function(f2_arg0)
	f2_arg0.Backing:close()
	f2_arg0.Title:close()
	f2_arg0.IGRPerk4:close()
	f2_arg0.IGRPerk:close()
	f2_arg0.IGRPerk3:close()
	f2_arg0.IGRPerk2:close()
	f2_arg0.IGRPerk6:close()
	f2_arg0.IGRPerk5:close()
end
