require("x64:19c1945d2e472b0")
CoD.GameEndScoreMatchBonusTitle = InheritFrom(LUI.UIElement)
CoD.GameEndScoreMatchBonusTitle.__defaultWidth = 400
CoD.GameEndScoreMatchBonusTitle.__defaultHeight = 53
CoD.GameEndScoreMatchBonusTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreMatchBonusTitle)
	self.id = "GameEndScoreMatchBonusTitle"
	self.soundSet = "default"
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 53)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local MatchBonusTitle = LUI.UIText.new(0.5, 0.5, -250, 250, 0, 0, 5, 50)
	MatchBonusTitle:setRGB(0.92, 0.92, 0.92)
	MatchBonusTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6BDD551B4B6FFA4"))
	MatchBonusTitle:setTTF("ttmussels_demibold")
	MatchBonusTitle:setLetterSpacing(2)
	MatchBonusTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MatchBonusTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MatchBonusTitle)
	self.MatchBonusTitle = MatchBonusTitle
	local PipTL = LUI.UIImage.new(0, 0, -4.5, 3.5, 0, 0, -4.5, 3.5)
	PipTL:setImage(RegisterImage(@"hash_6364778639313CE9"))
	PipTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipTL)
	self.PipTL = PipTL
	local PipBR = LUI.UIImage.new(1, 1, -4.5, 3.5, 1, 1, -4.5, 3.5)
	PipBR:setImage(RegisterImage(@"hash_6364778639313CE9"))
	PipBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipBR)
	self.PipBR = PipBR
	local PipBL = LUI.UIImage.new(0, 0, -4, 4, 1, 1, -4.5, 3.5)
	PipBL:setImage(RegisterImage(@"hash_6364778639313CE9"))
	PipBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipBL)
	self.PipBL = PipBL
	local PipTR = LUI.UIImage.new(1, 1, -4.5, 3.5, 0, 0, -4.5, 3.5)
	PipTR:setImage(RegisterImage(@"hash_6364778639313CE9"))
	PipTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PipTR)
	self.PipTR = PipTR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreMatchBonusTitle.__onClose = function(f2_arg0)
	f2_arg0.StoreCommonTextBacking:close()
end
