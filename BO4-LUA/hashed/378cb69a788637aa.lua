require("x64:cde4eb6b60deb3a")
CoD.WarzoneUseTimerProgress = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerProgress.__defaultWidth = 480
CoD.WarzoneUseTimerProgress.__defaultHeight = 18
CoD.WarzoneUseTimerProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneUseTimerProgress)
	self.id = "WarzoneUseTimerProgress"
	self.soundSet = "default"
	local DotCorner9Slice = CoD.WarzoneUseTimerRevivePlayerBG.new(f1_arg0, f1_arg1, 0, 0, -7, 488, 0, 0, -5, 23)
	DotCorner9Slice:setScale(0.96, 1)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local progressBackground = LUI.UIImage.new(0, 0, 0, 480, 1, 1, -18, 0)
	progressBackground:setAlpha(0.6)
	progressBackground:setImage(RegisterImage(@"uie_ui_hud_wz_hud_revive_bar_empty"))
	self:addElement(progressBackground)
	self.progressBackground = progressBackground
	local progressBar = LUI.UIImage.new(0, 0, 1, 481, 1, 1, -19, 1)
	progressBar:setImage(RegisterImage(@"uie_ui_hud_wz_hud_revive_bar_fill"))
	progressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	progressBar:setShaderVector(0, 0.64, 0, 0, 0)
	progressBar:setShaderVector(1, 0, 0, 0, 0)
	progressBar:setShaderVector(2, 1, 0, 0, 0)
	progressBar:setShaderVector(3, 0, 0, 0, 0)
	progressBar:setShaderVector(4, 1, 0.05, 1, 0.05)
	self:addElement(progressBar)
	self.progressBar = progressBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneUseTimerProgress.__onClose = function(f2_arg0)
	f2_arg0.DotCorner9Slice:close()
end
