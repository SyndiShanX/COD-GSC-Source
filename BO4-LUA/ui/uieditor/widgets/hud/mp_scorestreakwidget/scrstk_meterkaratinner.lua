require("x64:266f2c0c39e9736")
CoD.ScrStk_MeterKaratInner = InheritFrom(LUI.UIElement)
CoD.ScrStk_MeterKaratInner.__defaultWidth = 18
CoD.ScrStk_MeterKaratInner.__defaultHeight = 40
CoD.ScrStk_MeterKaratInner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_MeterKaratInner)
	self.id = "ScrStk_MeterKaratInner"
	self.soundSet = "HUD"
	local ScrStkCombatEfficiencyScrollFX000 = CoD.ScrStk_CombatEfficiencyScrollFX.new(f1_arg0, f1_arg1, 0.5, 0.5, -9, 9, 0, 1, 4, -26)
	ScrStkCombatEfficiencyScrollFX000:setXRot(180)
	ScrStkCombatEfficiencyScrollFX000:setZRot(90)
	self:addElement(ScrStkCombatEfficiencyScrollFX000)
	self.ScrStkCombatEfficiencyScrollFX000 = ScrStkCombatEfficiencyScrollFX000
	local ScrStkCombatEfficiencyScrollFX0000 = CoD.ScrStk_CombatEfficiencyScrollFX.new(f1_arg0, f1_arg1, 0.5, 0.5, -9, 9, 0, 1, 23, -7)
	ScrStkCombatEfficiencyScrollFX0000:setZRot(90)
	self:addElement(ScrStkCombatEfficiencyScrollFX0000)
	self.ScrStkCombatEfficiencyScrollFX0000 = ScrStkCombatEfficiencyScrollFX0000
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScrStk_MeterKaratInner.__onClose = function(f2_arg0)
	f2_arg0.ScrStkCombatEfficiencyScrollFX000:close()
	f2_arg0.ScrStkCombatEfficiencyScrollFX0000:close()
end
