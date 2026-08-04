require("ui/uieditor/widgets/pc/pc_achievement_completedtick")
require("ui/uieditor/widgets/pc/pc_achievementdetailedview_points_bg")
require("ui/uieditor/widgets/pc/utility/verticallistspacer")
CoD.PC_AchievementDetailedView_Points = InheritFrom(LUI.UIElement)
CoD.PC_AchievementDetailedView_Points.__defaultWidth = 175
CoD.PC_AchievementDetailedView_Points.__defaultHeight = 40
CoD.PC_AchievementDetailedView_Points.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.PC_AchievementDetailedView_Points)
	self.id = "PC_AchievementDetailedView_Points"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = CoD.PC_AchievementDetailedView_Points_BG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BG)
	self.BG = BG
	local CompletedTick = CoD.PC_Achievement_CompletedTick.new(f1_arg0, f1_arg1, 0, 0, -40, -20, 0, 0, 0, 40)
	CompletedTick:setAlpha(0)
	CompletedTick.BG:setRGB(0.86, 0.74, 0.25)
	CompletedTick.TabBacking:setAlpha(0.15)
	self:addElement(CompletedTick)
	self.CompletedTick = CompletedTick
	local Spacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 155, 175, 0, 1, 0, 0)
	self:addElement(Spacer3)
	self.Spacer3 = Spacer3
	local ScoreValue = LUI.UIText.new(0, 0, -20, 48, 0, 0, 4, 37)
	ScoreValue:setRGB(0.33, 0.33, 0.32)
	ScoreValue:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	ScoreValue:setTTF("ttmussels_regular")
	ScoreValue:setLetterSpacing(3)
	ScoreValue:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(ScoreValue)
	self.ScoreValue = ScoreValue
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 48, 58, 0, 1, 0, 0)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	local Points = LUI.UIText.new(0, 0, 58, 155, 0, 0, 15, 32)
	Points:setRGB(0.33, 0.33, 0.32)
	Points:setText(LocalizeToUpperString("achievements/points"))
	Points:setTTF("ttmussels_regular")
	Points:setLetterSpacing(4)
	Points:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(Points)
	self.Points = Points
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, -60, -40, 0, 1, 0, 0)
	self:addElement(Spacer)
	self.Spacer = Spacer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementDetailedView_Points.__resetProperties = function(f2_arg0)
	f2_arg0.BG:completeAnimation()
	f2_arg0.CompletedTick:completeAnimation()
	f2_arg0.ScoreValue:completeAnimation()
	f2_arg0.Points:completeAnimation()
	f2_arg0.CompletedTick:setAlpha(0)
	f2_arg0.ScoreValue:setRGB(0.33, 0.33, 0.32)
	f2_arg0.Points:setRGB(0.33, 0.33, 0.32)
end
CoD.PC_AchievementDetailedView_Points.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.BG:completeAnimation()
			f3_arg0.BG:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.BG)
			f3_arg0.CompletedTick:completeAnimation()
			f3_arg0.CompletedTick:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.CompletedTick)
		end,
		Completed = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.BG:completeAnimation()
			f4_arg0.BG:playClip("Completed")
			f4_arg0.clipFinished(f4_arg0.BG)
			f4_arg0.CompletedTick:completeAnimation()
			f4_arg0.CompletedTick:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.CompletedTick)
			f4_arg0.ScoreValue:completeAnimation()
			f4_arg0.ScoreValue:setRGB(0.88, 0.86, 0.81)
			f4_arg0.clipFinished(f4_arg0.ScoreValue)
			f4_arg0.Points:completeAnimation()
			f4_arg0.Points:setRGB(0.64, 0.63, 0.59)
			f4_arg0.clipFinished(f4_arg0.Points)
		end,
	},
}
CoD.PC_AchievementDetailedView_Points.__onClose = function(f5_arg0)
	f5_arg0.BG:close()
	f5_arg0.CompletedTick:close()
	f5_arg0.Spacer3:close()
	f5_arg0.Spacer2:close()
	f5_arg0.Spacer:close()
end
