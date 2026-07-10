require("x64:a7c4cf84718519f")
require("x64:29187ea00d726c3")
CoD.PC_Achievements_TotalPoints = InheritFrom(LUI.UIElement)
CoD.PC_Achievements_TotalPoints.__defaultWidth = 339
CoD.PC_Achievements_TotalPoints.__defaultHeight = 29
CoD.PC_Achievements_TotalPoints.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 7, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.PC_Achievements_TotalPoints)
	self.id = "PC_Achievements_TotalPoints"
	self.soundSet = "default"
	local TotalPoints = LUI.UIText.new(0.5, 0.5, 9.5, 169.5, 0.5, 0.5, -7, 12)
	TotalPoints:setRGB(0.8, 0.8, 0.8)
	TotalPoints:setAlpha(0.35)
	TotalPoints:setText(LocalizeToUpperString(0xA3BAB954D979BB))
	TotalPoints:setTTF("ttmussels_regular")
	TotalPoints:setLetterSpacing(6)
	TotalPoints:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(TotalPoints)
	self.TotalPoints = TotalPoints
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 167, 172, 0.5, 0.5, -14.5, 14.5)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	local CurrentProgressValue = LUI.UIText.new(0.5, 0.5, -59.5, -9.5, 0.5, 0.5, -11, 13)
	CurrentProgressValue:setRGB(0.71, 0.68, 0.65)
	CurrentProgressValue:setTTF("ttmussels_demibold")
	CurrentProgressValue:setLetterSpacing(3)
	CurrentProgressValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CurrentProgressValue:subscribeToGlobalModel(f1_arg1, "PCTotalAchievementsScore", "score", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentProgressValue:setText(f2_local0)
		end
	end)
	self:addElement(CurrentProgressValue)
	self.CurrentProgressValue = CurrentProgressValue
	local Slash = LUI.UIText.new(0.5, 0.5, -76.5, -66.5, 0.5, 0.5, -12, 13)
	Slash:setRGB(0.69, 0.67, 0.62)
	Slash:setText(CoD.BaseUtility.AlreadyLocalized("/"))
	Slash:setTTF("ttmussels_regular")
	Slash:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Slash)
	self.Slash = Slash
	local TotalProgressValue = LUI.UIText.new(0.5, 0.5, -133.5, -83.5, 0.5, 0.5, -11, 14)
	TotalProgressValue:setRGB(0.69, 0.67, 0.62)
	TotalProgressValue:setTTF("ttmussels_regular")
	TotalProgressValue:setLetterSpacing(2)
	TotalProgressValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TotalProgressValue:subscribeToGlobalModel(f1_arg1, "PCTotalAchievementsScore", "maxScore", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TotalProgressValue:setText(f3_local0)
		end
	end)
	self:addElement(TotalProgressValue)
	self.TotalProgressValue = TotalProgressValue
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 24, 29, 0.5, 0.5, -14.5, 14.5)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local CircularProgress = CoD.PC_Achievements_TotalPoints_CircularProgress.new(f1_arg0, f1_arg1, 0, 0, -11, 17, 0.5, 0.5, -14, 14)
	self:addElement(CircularProgress)
	self.CircularProgress = CircularProgress
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Achievements_TotalPoints.__onClose = function(f4_arg0)
	f4_arg0.Spacer2:close()
	f4_arg0.CurrentProgressValue:close()
	f4_arg0.TotalProgressValue:close()
	f4_arg0.Spacer:close()
	f4_arg0.CircularProgress:close()
end
