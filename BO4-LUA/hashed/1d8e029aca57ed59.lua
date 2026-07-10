require("x64:6fdeb9eb1239c18")
require("x64:8d2cf73e51e9eb2")
require("x64:445c36edf7e511d")
require("x64:20629a2e70ddf60")
CoD.ButtonFrame_MeritRecord = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_MeritRecord.__defaultWidth = 647
CoD.ButtonFrame_MeritRecord.__defaultHeight = 381
CoD.ButtonFrame_MeritRecord.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.PrestigeUtility.ClearHasPrestigedStatus(self, f1_arg1)
	self:setClass(CoD.ButtonFrame_MeritRecord)
	self.id = "ButtonFrame_MeritRecord"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RankInfo = CoD.ButtonFrame_RankInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0.5, 0.5, -177, 23)
	RankInfo:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return not IsAtXPCap(f1_arg1)
			end,
		},
		{
			stateName = "WarzoneMaxRank",
			condition = function(menu, element, event)
				return IsAtXPCap(f1_arg1)
			end,
		},
	})
	RankInfo.LevelText:setText(LocalizeToUpperString(@"hash_53547050A22D0BD0"))
	RankInfo:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RankInfo.RankText:setRGB(CoD.PlayerStatsUtility.GetRankColor(f1_arg0, f4_local0))
		end
	end)
	RankInfo:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RankInfo.RankText:setText(CoD.PlayerStatsUtility.GetRank(f1_arg0, f5_local0))
		end
	end)
	RankInfo:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RankInfo.RankIconLarge:setImage(RegisterImage(CoD.PlayerStatsUtility.GetRankIconLarge(f1_arg0, f1_arg1, f6_local0)))
		end
	end)
	RankInfo:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RankInfo.RankTitle:setText(LocalizeToUpperString(CoD.PrestigeUtility.GetPrestigeMenuRankTitle(f1_arg0, f7_local0)))
		end
	end)
	self:addElement(RankInfo)
	self.RankInfo = RankInfo
	local Scorebacking = LUI.UIImage.new(0.5, 0.5, -313, 313, 0, 0, 211, 371)
	Scorebacking:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Scorebacking:setAlpha(0.04)
	self:addElement(Scorebacking)
	self.Scorebacking = Scorebacking
	local MeritsText = LUI.UIText.new(0, 0, 256, 373, 0, 0, 189.5, 207.5)
	MeritsText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	MeritsText:setText(LocalizeToUpperString(@"hash_41A6986D07D40B76"))
	MeritsText:setTTF("ttmussels_regular")
	MeritsText:setLetterSpacing(1)
	MeritsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(MeritsText)
	self.MeritsText = MeritsText
	local TotalMeritsText = LUI.UIText.new(0, 0, 496, 635, 0, 0, 189.5, 207.5)
	TotalMeritsText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TotalMeritsText:setText(LocalizeToUpperString(@"hash_32FD7986ED047F25"))
	TotalMeritsText:setTTF("ttmussels_regular")
	TotalMeritsText:setLetterSpacing(1)
	TotalMeritsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TotalMeritsText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(TotalMeritsText)
	self.TotalMeritsText = TotalMeritsText
	local KillMerits = CoD.PlayerStatsMerits.new(f1_arg0, f1_arg1, 0, 0, 23, 523, 0, 0, 218.5, 237.5)
	KillMerits.TypeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_16B234CB46B5ACD4"))
	KillMerits:subscribeToGlobalModel(f1_arg1, "PlayerBarracksMerits", "kills", function(model)
		KillMerits:setModel(model, f1_arg1)
	end)
	self:addElement(KillMerits)
	self.KillMerits = KillMerits
	local PlacementMerits = CoD.PlayerStatsMerits.new(f1_arg0, f1_arg1, 0, 0, 23, 523, 0, 0, 247, 265)
	PlacementMerits.TypeText:setText(LocalizeToUpperString(@"hash_6971770DEFE5452D"))
	PlacementMerits:subscribeToGlobalModel(f1_arg1, "PlayerBarracksMerits", "top5", function(model)
		PlacementMerits:setModel(model, f1_arg1)
	end)
	self:addElement(PlacementMerits)
	self.PlacementMerits = PlacementMerits
	local WinMerits = CoD.PlayerStatsMerits.new(f1_arg0, f1_arg1, 0, 0, 23, 523, 0, 0, 276, 294)
	WinMerits.TypeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4585891326C1258C"))
	WinMerits:subscribeToGlobalModel(f1_arg1, "PlayerBarracksMerits", "wins", function(model)
		WinMerits:setModel(model, f1_arg1)
	end)
	self:addElement(WinMerits)
	self.WinMerits = WinMerits
	local ChallengeMerits = CoD.PlayerStatsMerits.new(f1_arg0, f1_arg1, 0, 0, 23, 523, 0, 0, 305, 323)
	ChallengeMerits.TypeText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_99CD580A52B2E53"))
	ChallengeMerits:subscribeToGlobalModel(f1_arg1, "PlayerBarracksMerits", "challenges", function(model)
		ChallengeMerits:setModel(model, f1_arg1)
	end)
	self:addElement(ChallengeMerits)
	self.ChallengeMerits = ChallengeMerits
	local TotalMeritsValue = LUI.UIText.new(0, 0, 463.5, 663.5, 0, 0, 259.5, 293.5)
	TotalMeritsValue:setRGB(0.69, 0.56, 0.04)
	TotalMeritsValue.__String_Reference = function()
		TotalMeritsValue:setText(CoD.PlayerStatsUtility.GetPlayerStorageStat(f1_arg0, @"rankxp", ""))
	end
	TotalMeritsValue.__String_Reference()
	TotalMeritsValue:setTTF("default")
	TotalMeritsValue:setLetterSpacing(2)
	TotalMeritsValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(TotalMeritsValue)
	self.TotalMeritsValue = TotalMeritsValue
	local RankProgress = CoD.ButtonFrame_XPMeterInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 302, 0.5, 0.5, 129.5, 180.5)
	RankProgress.CurrentXPText:setText("")
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			RankProgress.CurrentXPMeter.Meter:setShaderVector(0, CoD.PlayerStatsUtility.GetCurrentRankProgress(f1_arg0, CoD.GetVectorComponentFromString(f13_local0, 1), CoD.GetVectorComponentFromString(f13_local0, 2), CoD.GetVectorComponentFromString(f13_local0, 3), CoD.GetVectorComponentFromString(f13_local0, 4)))
		end
	end)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			RankProgress.CurrentXPMeter.MeterGlow:setShaderVector(0, CoD.PlayerStatsUtility.GetCurrentRankProgress(f1_arg0, CoD.GetVectorComponentFromString(f14_local0, 1), CoD.GetVectorComponentFromString(f14_local0, 2), CoD.GetVectorComponentFromString(f14_local0, 3), CoD.GetVectorComponentFromString(f14_local0, 4)))
		end
	end)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			RankProgress.NeededXPText:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PrestigeUtility.GetNextLevelXPText(f1_arg0, f1_arg1, CoD.PlayerStatsUtility.GetXPToNextRank(f1_arg0, f15_local0))))
		end
	end)
	RankProgress:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			RankProgress.RankIcon:setImage(RegisterImage(CoD.PlayerStatsUtility.GetNextRankIcon(f1_arg0, f16_local0)))
		end
	end)
	self:addElement(RankProgress)
	self.RankProgress = RankProgress
	local Divider = LUI.UIImage.new(0, 0, 23.5, 483.5, 0, 0, 241, 242)
	Divider:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Divider:setAlpha(0.08)
	self:addElement(Divider)
	self.Divider = Divider
	local Divider2 = LUI.UIImage.new(0, 0, 23.5, 483.5, 0, 0, 270, 271)
	Divider2:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Divider2:setAlpha(0.08)
	self:addElement(Divider2)
	self.Divider2 = Divider2
	local Divider3 = LUI.UIImage.new(0, 0, 23.5, 483.5, 0, 0, 299, 300)
	Divider3:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Divider3:setAlpha(0.08)
	self:addElement(Divider3)
	self.Divider3 = Divider3
	local Divider4 = LUI.UIImage.new(0, 0, 23.5, 483.5, 0, 0, 327, 328)
	Divider4:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Divider4:setAlpha(0.08)
	self:addElement(Divider4)
	self.Divider4 = Divider4
	local BracketTop = LUI.UIImage.new(0.5, 0.5, -316, 316, 0, 0, 207.5, 215.5)
	BracketTop:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	BracketTop:setZRot(180)
	BracketTop:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BracketTop:setShaderVector(0, 0, 0, 0, 0)
	BracketTop:setupNineSliceShader(16, 4)
	self:addElement(BracketTop)
	self.BracketTop = BracketTop
	local MaxLevelNotify = CoD.ButtonFrame_MaxLevelNotify.new(f1_arg0, f1_arg1, 0, 0, 23.5, 623.5, 0, 0, 247, 347)
	MaxLevelNotify:setAlpha(0)
	self:addElement(MaxLevelNotify)
	self.MaxLevelNotify = MaxLevelNotify
	local f1_local17 = TotalMeritsValue
	local f1_local18 = TotalMeritsValue.subscribeToModel
	local f1_local19 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local18(f1_local17, f1_local19["PrestigeMenuInfo.hasPrestiged"], TotalMeritsValue.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "PrestigeReady",
			condition = function(menu, element, event)
				local f17_local0 = IsAtXPCap(f1_arg1)
				if f17_local0 then
					if not IsMaxPrestigeLevel(f1_arg1) then
						f17_local0 = not CoD.PrestigeUtility.ShouldHidePrestigeButton(f1_arg1)
					else
						f17_local0 = false
					end
				end
				return f17_local0
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		local f18_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_MeritRecord.__resetProperties = function(f19_arg0)
	f19_arg0.MaxLevelNotify:completeAnimation()
	f19_arg0.BracketTop:completeAnimation()
	f19_arg0.Divider4:completeAnimation()
	f19_arg0.Divider3:completeAnimation()
	f19_arg0.Divider2:completeAnimation()
	f19_arg0.Divider:completeAnimation()
	f19_arg0.RankProgress:completeAnimation()
	f19_arg0.TotalMeritsValue:completeAnimation()
	f19_arg0.ChallengeMerits:completeAnimation()
	f19_arg0.WinMerits:completeAnimation()
	f19_arg0.PlacementMerits:completeAnimation()
	f19_arg0.KillMerits:completeAnimation()
	f19_arg0.TotalMeritsText:completeAnimation()
	f19_arg0.MeritsText:completeAnimation()
	f19_arg0.Scorebacking:completeAnimation()
	f19_arg0.MaxLevelNotify:setAlpha(0)
	f19_arg0.BracketTop:setAlpha(1)
	f19_arg0.Divider4:setAlpha(0.08)
	f19_arg0.Divider3:setAlpha(0.08)
	f19_arg0.Divider2:setAlpha(0.08)
	f19_arg0.Divider:setAlpha(0.08)
	f19_arg0.RankProgress:setAlpha(1)
	f19_arg0.TotalMeritsValue:setAlpha(1)
	f19_arg0.ChallengeMerits:setAlpha(1)
	f19_arg0.WinMerits:setAlpha(1)
	f19_arg0.PlacementMerits:setAlpha(1)
	f19_arg0.KillMerits:setAlpha(1)
	f19_arg0.TotalMeritsText:setAlpha(1)
	f19_arg0.MeritsText:setAlpha(1)
	f19_arg0.Scorebacking:setAlpha(0.04)
end
CoD.ButtonFrame_MeritRecord.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	PrestigeReady = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(15)
			f21_arg0.Scorebacking:completeAnimation()
			f21_arg0.Scorebacking:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Scorebacking)
			f21_arg0.MeritsText:completeAnimation()
			f21_arg0.MeritsText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.MeritsText)
			f21_arg0.TotalMeritsText:completeAnimation()
			f21_arg0.TotalMeritsText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TotalMeritsText)
			f21_arg0.KillMerits:completeAnimation()
			f21_arg0.KillMerits:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.KillMerits)
			f21_arg0.PlacementMerits:completeAnimation()
			f21_arg0.PlacementMerits:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PlacementMerits)
			f21_arg0.WinMerits:completeAnimation()
			f21_arg0.WinMerits:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.WinMerits)
			f21_arg0.ChallengeMerits:completeAnimation()
			f21_arg0.ChallengeMerits:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ChallengeMerits)
			f21_arg0.TotalMeritsValue:completeAnimation()
			f21_arg0.TotalMeritsValue:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.TotalMeritsValue)
			f21_arg0.RankProgress:completeAnimation()
			f21_arg0.RankProgress:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.RankProgress)
			f21_arg0.Divider:completeAnimation()
			f21_arg0.Divider:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Divider)
			f21_arg0.Divider2:completeAnimation()
			f21_arg0.Divider2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Divider2)
			f21_arg0.Divider3:completeAnimation()
			f21_arg0.Divider3:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Divider3)
			f21_arg0.Divider4:completeAnimation()
			f21_arg0.Divider4:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Divider4)
			f21_arg0.BracketTop:completeAnimation()
			f21_arg0.BracketTop:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.BracketTop)
			f21_arg0.MaxLevelNotify:completeAnimation()
			f21_arg0.MaxLevelNotify:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.MaxLevelNotify)
		end,
	},
}
CoD.ButtonFrame_MeritRecord.__onClose = function(f22_arg0)
	f22_arg0.RankInfo:close()
	f22_arg0.KillMerits:close()
	f22_arg0.PlacementMerits:close()
	f22_arg0.WinMerits:close()
	f22_arg0.ChallengeMerits:close()
	f22_arg0.TotalMeritsValue:close()
	f22_arg0.RankProgress:close()
	f22_arg0.MaxLevelNotify:close()
end
