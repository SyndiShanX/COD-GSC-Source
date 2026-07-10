CoD.PC_Achievements_TotalPoints_CircularProgress = InheritFrom(LUI.UIElement)
CoD.PC_Achievements_TotalPoints_CircularProgress.__defaultWidth = 28
CoD.PC_Achievements_TotalPoints_CircularProgress.__defaultHeight = 28
CoD.PC_Achievements_TotalPoints_CircularProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Achievements_TotalPoints_CircularProgress)
	self.id = "PC_Achievements_TotalPoints_CircularProgress"
	self.soundSet = "default"
	local TotalProgressRing = LUI.UIImage.new(0.5, 0.5, -14, 14, 0.5, 0.5, -14, 14)
	TotalProgressRing:setRGB(0.71, 0.68, 0.65)
	TotalProgressRing:setImage(RegisterImage(@"uie_ui_icon_controller_radial_fill_hud"))
	TotalProgressRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	TotalProgressRing:setShaderVector(1, 0.5, 0, 0, 0)
	TotalProgressRing:setShaderVector(2, 0.5, 0, 0, 0)
	TotalProgressRing:setShaderVector(3, 0, 1, 0, 0)
	TotalProgressRing:setShaderVector(4, 0, 0, 0, 0)
	TotalProgressRing:subscribeToGlobalModel(f1_arg1, "PCTotalAchievementsScore", "progress", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TotalProgressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(TotalProgressRing)
	self.TotalProgressRing = TotalProgressRing
	local TotalProgressRingBG = LUI.UIImage.new(0.5, 0.5, -14, 14, 0.5, 0.5, -14, 14)
	TotalProgressRingBG:setAlpha(0.03)
	TotalProgressRingBG:setImage(RegisterImage(@"uie_ui_icon_controller_radial_fill_hud"))
	self:addElement(TotalProgressRingBG)
	self.TotalProgressRingBG = TotalProgressRingBG
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Achievements_TotalPoints_CircularProgress.__onClose = function(f3_arg0)
	f3_arg0.TotalProgressRing:close()
end
