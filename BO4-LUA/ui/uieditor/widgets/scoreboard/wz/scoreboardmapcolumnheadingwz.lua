CoD.ScoreboardMapColumnHeadingWZ = InheritFrom(LUI.UIElement)
CoD.ScoreboardMapColumnHeadingWZ.__defaultWidth = 112
CoD.ScoreboardMapColumnHeadingWZ.__defaultHeight = 40
CoD.ScoreboardMapColumnHeadingWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardMapColumnHeadingWZ)
	self.id = "ScoreboardMapColumnHeadingWZ"
	self.soundSet = "default"
	local Section = LUI.UIText.new(0, 1, 0, 0, 0, 0, 8, 34)
	Section:setRGB(0.92, 0.92, 0.92)
	Section:setAlpha(0.7)
	Section:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Section:setTTF("ttmussels_demibold")
	Section:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Section:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Section)
	self.Section = Section
	local BetweenColumns = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 40)
	BetweenColumns:setRGB(0, 0, 0)
	self:addElement(BetweenColumns)
	self.BetweenColumns = BetweenColumns
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
