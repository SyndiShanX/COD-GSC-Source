require("x64:a5345e91e58dd3b")
require("x64:b9363c1b28d579c")
require("x64:28e0a7b4222359a")
CoD.ArenaEventProgressButtonInternalLeaguePlay = InheritFrom(LUI.UIElement)
CoD.ArenaEventProgressButtonInternalLeaguePlay.__defaultWidth = 382
CoD.ArenaEventProgressButtonInternalLeaguePlay.__defaultHeight = 70
CoD.ArenaEventProgressButtonInternalLeaguePlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventProgressButtonInternalLeaguePlay)
	self.id = "ArenaEventProgressButtonInternalLeaguePlay"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Rank = CoD.ArenaEventProgressButtonRank.new(f1_arg0, f1_arg1, 0, 0, 8, 166, 0, 0, 35, 67)
	Rank:setAlpha(0)
	self:addElement(Rank)
	self.Rank = Rank
	local EventTitle = LUI.UIText.new(0, 0, 9, 229, 0, 0, 6, 26)
	EventTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	EventTitle:setText(LocalizeToUpperString(@"hash_2A81622B007EDBAA"))
	EventTitle:setTTF("ttmussels_regular")
	EventTitle:setLetterSpacing(2)
	EventTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(EventTitle)
	self.EventTitle = EventTitle
	local NoDivisionIndicator = LUI.UIText.new(0, 0, 9, 209, 0, 0, 30, 67)
	NoDivisionIndicator:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	NoDivisionIndicator:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B5B44160430E38B"))
	NoDivisionIndicator:setTTF("ttmussels_demibold")
	NoDivisionIndicator:setLetterSpacing(5)
	NoDivisionIndicator:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NoDivisionIndicator:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(NoDivisionIndicator)
	self.NoDivisionIndicator = NoDivisionIndicator
	local NoDivisionIndicatorAdd = LUI.UIText.new(0, 0, 9, 209, 0, 0, 30, 67)
	NoDivisionIndicatorAdd:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	NoDivisionIndicatorAdd:setAlpha(0)
	NoDivisionIndicatorAdd:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B5B44160430E38B"))
	NoDivisionIndicatorAdd:setTTF("ttmussels_demibold")
	NoDivisionIndicatorAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3336C1AE82B1520A"))
	NoDivisionIndicatorAdd:setLetterSpacing(5)
	NoDivisionIndicatorAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NoDivisionIndicatorAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(NoDivisionIndicatorAdd)
	self.NoDivisionIndicatorAdd = NoDivisionIndicatorAdd
	local ArenaEventProgressButtonDailyBonus = CoD.ArenaEventProgressButtonDailyBonus.new(f1_arg0, f1_arg1, 0, 0, 238, 382, 0, 0, 0, 70)
	self:addElement(ArenaEventProgressButtonDailyBonus)
	self.ArenaEventProgressButtonDailyBonus = ArenaEventProgressButtonDailyBonus
	local qualificaiton = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	qualificaiton:setLeftRight(0, 0, 20, 388)
	qualificaiton:setTopBottom(0, 0, 16.5, 80.5)
	qualificaiton:setAlpha(0)
	qualificaiton:setScale(0.4, 0.4)
	qualificaiton:setWidgetType(CoD.AAR_LeaguePlay_PlacementPip)
	qualificaiton:setHorizontalCount(5)
	qualificaiton:setSpacing(12)
	qualificaiton:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	qualificaiton:setDataSource("LeaguePlayPlacementPips")
	self:addElement(qualificaiton)
	self.qualificaiton = qualificaiton
	local MatchesPlayedText2 = LUI.UIText.new(0, 0, -16, 67, 0, 0, 33.5, 60.5)
	MatchesPlayedText2:setRGB(0.92, 0.92, 0.92)
	MatchesPlayedText2:setAlpha(0)
	MatchesPlayedText2:setText(CoD.ArenaLeaguePlayUtility.GetCompletedPlacementMatchesString(f1_arg1, @"menu/empty"))
	MatchesPlayedText2:setTTF("ttmussels_demibold")
	MatchesPlayedText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	MatchesPlayedText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MatchesPlayedText2)
	self.MatchesPlayedText2 = MatchesPlayedText2
	local MatchesPlayedText = LUI.UIText.new(0, 0, 67, 191, 0, 0, 33.5, 60.5)
	MatchesPlayedText:setRGB(0.53, 0.53, 0.53)
	MatchesPlayedText:setAlpha(0)
	MatchesPlayedText:setText(CoD.ArenaLeaguePlayUtility.GetCompletedPlacementMatchesProgressString(f1_arg1, 0xC973F0F3138027))
	MatchesPlayedText:setTTF("ttmussels_demibold")
	MatchesPlayedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MatchesPlayedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(MatchesPlayedText)
	self.MatchesPlayedText = MatchesPlayedText
	local OverlayPattern = LUI.UIImage.new(0.5, 0.5, -186.5, 187.5, 0.5, 0.5, -30.5, 30.5)
	OverlayPattern:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OverlayPattern:setAlpha(0.05)
	OverlayPattern:setImage(RegisterImage(@"hash_7FC21A8215EA012B"))
	OverlayPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	OverlayPattern:setShaderVector(0, 0, 0, 0, 0)
	OverlayPattern:setupNineSliceShader(4, 4)
	self:addElement(OverlayPattern)
	self.OverlayPattern = OverlayPattern
	self:mergeStateConditions({
		{
			stateName = "LadderQualification",
			condition = function(menu, element, event)
				return not CoD.ArenaLeaguePlayUtility.HasPlayerCompletedPlacementMatches(f1_arg1)
			end,
		},
		{
			stateName = "Unranked",
			condition = function(menu, element, event)
				return not CoD.ArenaLeaguePlayUtility.HasOneMatchPlayed(self, f1_arg1)
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12["LeaguePlayLadder.entityLadderRank"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LeaguePlayLadder.entityLadderRank",
		})
	end, false)
	qualificaiton.id = "qualificaiton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventProgressButtonInternalLeaguePlay.__resetProperties = function(f5_arg0)
	f5_arg0.NoDivisionIndicator:completeAnimation()
	f5_arg0.NoDivisionIndicatorAdd:completeAnimation()
	f5_arg0.Rank:completeAnimation()
	f5_arg0.EventTitle:completeAnimation()
	f5_arg0.qualificaiton:completeAnimation()
	f5_arg0.MatchesPlayedText:completeAnimation()
	f5_arg0.MatchesPlayedText2:completeAnimation()
	f5_arg0.NoDivisionIndicator:setAlpha(1)
	f5_arg0.NoDivisionIndicatorAdd:setAlpha(0)
	f5_arg0.Rank:setAlpha(0)
	f5_arg0.EventTitle:setLeftRight(0, 0, 9, 229)
	f5_arg0.EventTitle:setText(LocalizeToUpperString(@"hash_2A81622B007EDBAA"))
	f5_arg0.qualificaiton:setLeftRight(0, 0, 20, 388)
	f5_arg0.qualificaiton:setTopBottom(0, 0, 16.5, 80.5)
	f5_arg0.qualificaiton:setAlpha(0)
	f5_arg0.MatchesPlayedText:setLeftRight(0, 0, 67, 191)
	f5_arg0.MatchesPlayedText:setTopBottom(0, 0, 33.5, 60.5)
	f5_arg0.MatchesPlayedText:setAlpha(0)
	f5_arg0.MatchesPlayedText2:setLeftRight(0, 0, -16, 67)
	f5_arg0.MatchesPlayedText2:setTopBottom(0, 0, 33.5, 60.5)
	f5_arg0.MatchesPlayedText2:setAlpha(0)
end
CoD.ArenaEventProgressButtonInternalLeaguePlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.Rank:completeAnimation()
			f6_arg0.Rank:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Rank)
			f6_arg0.EventTitle:completeAnimation()
			f6_arg0.EventTitle:setText(LocalizeToUpperString(@"hash_2A81622B007EDBAA"))
			f6_arg0.clipFinished(f6_arg0.EventTitle)
			f6_arg0.NoDivisionIndicator:completeAnimation()
			f6_arg0.NoDivisionIndicator:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NoDivisionIndicator)
			f6_arg0.NoDivisionIndicatorAdd:completeAnimation()
			f6_arg0.NoDivisionIndicatorAdd:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NoDivisionIndicatorAdd)
			f6_arg0.qualificaiton:completeAnimation()
			f6_arg0.qualificaiton:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.qualificaiton)
		end,
	},
	LadderQualification = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(5)
			f7_arg0.EventTitle:completeAnimation()
			f7_arg0.EventTitle:setLeftRight(0, 0, 9, 229)
			f7_arg0.EventTitle:setText(LocalizeToUpperString(@"hash_1C1FB7F2F4555459"))
			f7_arg0.clipFinished(f7_arg0.EventTitle)
			f7_arg0.NoDivisionIndicator:completeAnimation()
			f7_arg0.NoDivisionIndicator:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.NoDivisionIndicator)
			f7_arg0.qualificaiton:completeAnimation()
			f7_arg0.qualificaiton:setLeftRight(0, 0, -26, 334)
			f7_arg0.qualificaiton:setTopBottom(0, 0, 18, 82)
			f7_arg0.qualificaiton:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.qualificaiton)
			f7_arg0.MatchesPlayedText2:completeAnimation()
			f7_arg0.MatchesPlayedText2:setLeftRight(0, 0, -44, 39)
			f7_arg0.MatchesPlayedText2:setTopBottom(0, 0, 37, 62)
			f7_arg0.MatchesPlayedText2:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.MatchesPlayedText2)
			f7_arg0.MatchesPlayedText:completeAnimation()
			f7_arg0.MatchesPlayedText:setLeftRight(0, 0, 39, 163)
			f7_arg0.MatchesPlayedText:setTopBottom(0, 0, 37, 62)
			f7_arg0.MatchesPlayedText:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.MatchesPlayedText)
		end,
	},
	Unranked = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.EventTitle:completeAnimation()
			f8_arg0.EventTitle:setLeftRight(0, 0, 9, 229)
			f8_arg0.clipFinished(f8_arg0.EventTitle)
			f8_arg0.NoDivisionIndicatorAdd:completeAnimation()
			f8_arg0.NoDivisionIndicatorAdd:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.NoDivisionIndicatorAdd)
			f8_arg0.qualificaiton:completeAnimation()
			f8_arg0.qualificaiton:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.qualificaiton)
		end,
	},
}
CoD.ArenaEventProgressButtonInternalLeaguePlay.__onClose = function(f9_arg0)
	f9_arg0.Rank:close()
	f9_arg0.ArenaEventProgressButtonDailyBonus:close()
	f9_arg0.qualificaiton:close()
end
