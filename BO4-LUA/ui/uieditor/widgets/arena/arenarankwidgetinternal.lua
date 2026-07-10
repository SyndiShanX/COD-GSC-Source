CoD.ArenaRankWidgetInternal = InheritFrom(LUI.UIElement)
CoD.ArenaRankWidgetInternal.__defaultWidth = 128
CoD.ArenaRankWidgetInternal.__defaultHeight = 128
CoD.ArenaRankWidgetInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaRankWidgetInternal)
	self.id = "ArenaRankWidgetInternal"
	self.soundSet = "none"
	local FireStreakIcon = LUI.UIImage.new(-0.5, 1.5, 0, 0, -0.5, 1.5, 0, 0)
	FireStreakIcon:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	FireStreakIcon:setShaderVector(0, 4, 4, 0, 0)
	FireStreakIcon:setShaderVector(1, 10, 0, 0, 0)
	FireStreakIcon:linkToElementModel(self, "leaguePlayFirestreakIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FireStreakIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FireStreakIcon)
	self.FireStreakIcon = FireStreakIcon
	local RankIcon = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	RankIcon:linkToElementModel(self, "leaguePlayIconLarge", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaRankWidgetInternal.__onClose = function(f4_arg0)
	f4_arg0.FireStreakIcon:close()
	f4_arg0.RankIcon:close()
end
