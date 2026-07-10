CoD.BM_BountyRequirementContainer = InheritFrom(LUI.UIElement)
CoD.BM_BountyRequirementContainer.__defaultWidth = 1920
CoD.BM_BountyRequirementContainer.__defaultHeight = 330
CoD.BM_BountyRequirementContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_BountyRequirementContainer)
	self.id = "BM_BountyRequirementContainer"
	self.soundSet = "none"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	Backing:setAlpha(0.15)
	self:addElement(Backing)
	self.Backing = Backing
	local BountyRequirement = LUI.UIText.new(0, 0, 120, 689, 0, 0, 23.5, 62.5)
	BountyRequirement:setText(Engine[0xF9F1239CFD921FE](0xB778C58492E1282))
	BountyRequirement:setTTF("ttmussels_demibold")
	BountyRequirement:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	BountyRequirement:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(BountyRequirement)
	self.BountyRequirement = BountyRequirement
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
