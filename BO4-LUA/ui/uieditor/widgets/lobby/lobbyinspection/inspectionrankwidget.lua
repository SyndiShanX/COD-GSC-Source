require("x64:d83ec465c09ecf7")
CoD.InspectionRankWidget = InheritFrom(LUI.UIElement)
CoD.InspectionRankWidget.__defaultWidth = 256
CoD.InspectionRankWidget.__defaultHeight = 256
CoD.InspectionRankWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionRankWidget)
	self.id = "InspectionRankWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RankBg = LUI.UIImage.new(0, 0, 0, 256, 0, 0, 0, 256)
	RankBg:setRGB(0.45, 0.45, 0.45)
	RankBg:setAlpha(0)
	self:addElement(RankBg)
	self.RankBg = RankBg
	local RankIcon = LUI.UIImage.new(0.5, 0.5, -90, 90, 0, 0, 16, 196)
	RankIcon:setAlpha(0.8)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local PlayerLevel = LUI.UIText.new(0, 0, 28, 228, 0, 0, 199.5, 247.5)
	PlayerLevel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	PlayerLevel:setTTF("dinnext_regular")
	PlayerLevel:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	PlayerLevel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayerLevel)
	self.PlayerLevel = PlayerLevel
	local PrestigeLevelNum = CoD.InspectionPrestigeLevel.new(f1_arg0, f1_arg1, 0, 0, -72, 328, 0, 0, 219.5, 240.5)
	self:addElement(PrestigeLevelNum)
	self.PrestigeLevelNum = PrestigeLevelNum
	self:mergeStateConditions({
		{
			stateName = "FNF",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestone(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionRankWidget.__resetProperties = function(f3_arg0)
	f3_arg0.PrestigeLevelNum:completeAnimation()
	f3_arg0.PlayerLevel:completeAnimation()
	f3_arg0.RankIcon:completeAnimation()
	f3_arg0.RankBg:completeAnimation()
	f3_arg0.PrestigeLevelNum:setAlpha(1)
	f3_arg0.PlayerLevel:setAlpha(1)
	f3_arg0.RankIcon:setAlpha(0.8)
	f3_arg0.RankBg:setAlpha(0)
end
CoD.InspectionRankWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	FNF = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.RankBg:completeAnimation()
			f5_arg0.RankBg:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RankBg)
			f5_arg0.RankIcon:completeAnimation()
			f5_arg0.RankIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.RankIcon)
			f5_arg0.PlayerLevel:completeAnimation()
			f5_arg0.PlayerLevel:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PlayerLevel)
			f5_arg0.PrestigeLevelNum:completeAnimation()
			f5_arg0.PrestigeLevelNum:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.PrestigeLevelNum)
		end,
	},
}
CoD.InspectionRankWidget.__onClose = function(f6_arg0)
	f6_arg0.PrestigeLevelNum:close()
end
