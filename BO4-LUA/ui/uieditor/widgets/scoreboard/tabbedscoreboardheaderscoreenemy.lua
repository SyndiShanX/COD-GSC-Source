CoD.TabbedScoreboardHeaderScoreEnemy = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderScoreEnemy.__defaultWidth = 153
CoD.TabbedScoreboardHeaderScoreEnemy.__defaultHeight = 64
CoD.TabbedScoreboardHeaderScoreEnemy.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardHeaderScoreEnemy)
	self.id = "TabbedScoreboardHeaderScoreEnemy"
	self.soundSet = "default"
	local EnemyKills = LUI.UIText.new(0, 0, 0, 153, 0, 0, 0, 64)
	EnemyKills:setTTF("0arame_mono_stencil")
	EnemyKills:setLetterSpacing(2)
	EnemyKills:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EnemyKills:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	EnemyKills:linkToElementModel(self, "factionScore", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnemyKills:setText(f2_local0)
		end
	end)
	self:addElement(EnemyKills)
	self.EnemyKills = EnemyKills
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeaderScoreEnemy.__onClose = function(f3_arg0)
	f3_arg0.EnemyKills:close()
end
