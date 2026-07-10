require("x64:c7393046816f760")
require("x64:5be072bd539a5e")
require("x64:ebeb04182312df4")
CoD.Prestige_LevelProgressWidget = InheritFrom(LUI.UIElement)
CoD.Prestige_LevelProgressWidget.__defaultWidth = 1108
CoD.Prestige_LevelProgressWidget.__defaultHeight = 94
CoD.Prestige_LevelProgressWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_LevelProgressWidget)
	self.id = "Prestige_LevelProgressWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BodyBacker = LUI.UIImage.new(0, 0, 74, 1108, 0, 0, 0, 94)
	BodyBacker:setRGB(0.1, 0.1, 0.1)
	BodyBacker:setAlpha(0.2)
	self:addElement(BodyBacker)
	self.BodyBacker = BodyBacker
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 74, 1108, 0, 0, 0, 94)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local LevelMeterBgTint = LUI.UIImage.new(0, 0, 149, 1097, 0.5, 0.5, -0.5, 3.5)
	LevelMeterBgTint:setRGB(0.92, 0.92, 0.92)
	LevelMeterBgTint:setAlpha(0.05)
	self:addElement(LevelMeterBgTint)
	self.LevelMeterBgTint = LevelMeterBgTint
	local LevelMeterBg = LUI.UIImage.new(0, 0, 146, 1100, 0.5, 0.5, -10.5, 13.5)
	LevelMeterBg:setImage(RegisterImage(0x61E8EB53DFEF82B))
	LevelMeterBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	LevelMeterBg:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(LevelMeterBg)
	self.LevelMeterBg = LevelMeterBg
	local RankIcon = LUI.UIImage.new(0, 0, 0, 148, 0, 0, -29.5, 118.5)
	RankIcon:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankIcon:setImage(RegisterImage(CoD.PlayerStatsUtility.GetRankIconLarge(f1_arg0, f1_arg1, f2_local0)))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local LevelMeterBar = LUI.UIImage.new(-0.65, -0.65, 869.5, 1818.5, 0.5, 0.5, -3.5, 6.5)
	LevelMeterBar:setRGB(0.47, 0.47, 0.47)
	LevelMeterBar:setAlpha(0)
	LevelMeterBar:setImage(RegisterImage(0x4F8DEF85850B5DD))
	LevelMeterBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	LevelMeterBar:setShaderVector(0, 0, 1, 0, 0)
	LevelMeterBar:setShaderVector(1, 0, 0, 0, 0)
	LevelMeterBar:setShaderVector(2, 0, 1, 0, 0)
	LevelMeterBar:setShaderVector(3, 0, 0, 0, 0)
	LevelMeterBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LevelMeterBar)
	self.LevelMeterBar = LevelMeterBar
	local EarnedXP = CoD.CommonWipeMeterWithGlow.new(f1_arg0, f1_arg1, 0, 0, 148, 1097, 0.5, 0.5, -10, 14)
	EarnedXP.Meter:setRGB(1, 0.73, 0)
	EarnedXP.Meter:setImage(RegisterImage(0x6D2FBF31F53910C))
	EarnedXP.MeterAdd:setAlpha(0.3)
	EarnedXP.MeterAdd:setImage(RegisterImage(0x6D2FBF31F53910C))
	EarnedXP.MeterGlow:setRGB(0.39, 0.18, 0)
	EarnedXP.MeterGlow:setImage(RegisterImage(0xA7D61A3302B55D0))
	EarnedXP:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", "progress", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EarnedXP.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	EarnedXP:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", "progress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EarnedXP.MeterAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	EarnedXP:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", "progress", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			EarnedXP.MeterGlow:setShaderVector(0, CoD.GetVectorComponentFromString(f5_local0, 1), CoD.GetVectorComponentFromString(f5_local0, 2), CoD.GetVectorComponentFromString(f5_local0, 3), CoD.GetVectorComponentFromString(f5_local0, 4))
		end
	end)
	self:addElement(EarnedXP)
	self.EarnedXP = EarnedXP
	local RankProgressBar = LUI.UIImage.new(0, 0, 148, 1097, 0, 0, 44.5, 52.5)
	RankProgressBar:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	RankProgressBar:setAlpha(0)
	RankProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	RankProgressBar:setShaderVector(1, 0, 0, 0, 0)
	RankProgressBar:setShaderVector(2, 1, 0, 0, 0)
	RankProgressBar:setShaderVector(3, 0, 0, 0, 0)
	RankProgressBar:setShaderVector(4, 0, 0, 0, 0)
	RankProgressBar:subscribeToGlobalModel(f1_arg1, "XPProgressionBar", "progress", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RankProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	self:addElement(RankProgressBar)
	self.RankProgressBar = RankProgressBar
	local NextLevelText = LUI.UIText.new(0, 0, 829, 1094, 0, 0, 65, 83)
	NextLevelText:setRGB(0.9, 0.89, 0.78)
	NextLevelText:setAlpha(0.3)
	NextLevelText:setTTF("ttmussels_regular")
	NextLevelText:setLetterSpacing(2)
	NextLevelText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	NextLevelText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NextLevelText:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			NextLevelText:setText(CoD.PrestigeUtility.GetNextLevelText(f1_arg0, f1_arg1, f7_local0))
		end
	end)
	self:addElement(NextLevelText)
	self.NextLevelText = NextLevelText
	local ProgressText = LUI.UIText.new(0, 0, 152, 575, 0, 0, 65, 83)
	ProgressText:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ProgressText:setAlpha(0.3)
	ProgressText:setTTF("ttmussels_regular")
	ProgressText:setLetterSpacing(2)
	ProgressText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ProgressText:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ProgressText:setText(CoD.PlayerStatsUtility.GetCurrentXPOverNextRankXP(f1_arg0, f8_local0))
		end
	end)
	self:addElement(ProgressText)
	self.ProgressText = ProgressText
	local RankName = CoD.Prestige_LevelProgress_Rank.new(f1_arg0, f1_arg1, 0, 0, 152, 706, 0, 0, 13, 38)
	self:addElement(RankName)
	self.RankName = RankName
	local CornerBottomRight = LUI.UIImage.new(1, 1, -2, 2, 1, 1, -2, 2)
	CornerBottomRight:setAlpha(0.2)
	CornerBottomRight:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerBottomRight)
	self.CornerBottomRight = CornerBottomRight
	local CornerTopRight = LUI.UIImage.new(1, 1, -2, 2, 0, 0, -2, 2)
	CornerTopRight:setAlpha(0.2)
	CornerTopRight:setImage(RegisterImage(0xCD2D51C614BCB51))
	self:addElement(CornerTopRight)
	self.CornerTopRight = CornerTopRight
	local SquareOthers = CoD.AARLevelCommonBoxes.new(f1_arg0, f1_arg1, 0, 0, 1054, 1102, 0, 0, 2.5, 15.5)
	SquareOthers:setAlpha(0.2)
	self:addElement(SquareOthers)
	self.SquareOthers = SquareOthers
	self:mergeStateConditions({
		{
			stateName = "MaxPrestige",
			condition = function(menu, element, event)
				return IsMaxPrestigeLevel(f1_arg1) and CoD.PrestigeUtility.isMaxRank(menu)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_LevelProgressWidget.__resetProperties = function(f10_arg0)
	f10_arg0.ProgressText:completeAnimation()
	f10_arg0.RankProgressBar:completeAnimation()
	f10_arg0.EarnedXP:completeAnimation()
	f10_arg0.ProgressText:setAlpha(0.3)
	f10_arg0.RankProgressBar:setAlpha(0)
	f10_arg0.EarnedXP:setAlpha(1)
end
CoD.Prestige_LevelProgressWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	MaxPrestige = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.EarnedXP:completeAnimation()
			f12_arg0.EarnedXP:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.EarnedXP)
			f12_arg0.RankProgressBar:completeAnimation()
			f12_arg0.RankProgressBar:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RankProgressBar)
			f12_arg0.ProgressText:completeAnimation()
			f12_arg0.ProgressText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ProgressText)
		end,
	},
}
CoD.Prestige_LevelProgressWidget.__onClose = function(f13_arg0)
	f13_arg0.RankIcon:close()
	f13_arg0.EarnedXP:close()
	f13_arg0.RankProgressBar:close()
	f13_arg0.NextLevelText:close()
	f13_arg0.ProgressText:close()
	f13_arg0.RankName:close()
	f13_arg0.SquareOthers:close()
end
