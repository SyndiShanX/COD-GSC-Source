require("x64:1e4812bc9d39ec5")
require("x64:1af160e2fc32808")
require("x64:ea67ece3d7f7c7b")
require("x64:19c1945d2e472b0")
CoD.LeaguePlayLeaderboardTab = InheritFrom(LUI.UIElement)
CoD.LeaguePlayLeaderboardTab.__defaultWidth = -922
CoD.LeaguePlayLeaderboardTab.__defaultHeight = 1080
CoD.LeaguePlayLeaderboardTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayLeaderboardTab)
	self.id = "LeaguePlayLeaderboardTab"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AARPerformBg2 = LUI.UIImage.new(0, 0, 240, 1677, 0, 0, 120, 216)
	AARPerformBg2:setAlpha(0.5)
	AARPerformBg2:setImage(RegisterImage(@"uie_ui_menu_aar_perform_repeat_bg"))
	AARPerformBg2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	AARPerformBg2:setShaderVector(0, 0, 0, 0, 0)
	AARPerformBg2:setupNineSliceShader(344, 136)
	self:addElement(AARPerformBg2)
	self.AARPerformBg2 = AARPerformBg2
	local arenaLeaguePlayBg = CoD.arenaLeaguePlayBg.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(arenaLeaguePlayBg)
	self.arenaLeaguePlayBg = arenaLeaguePlayBg
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 240, 1677, 0, 0, 216, 962)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.TiledShaderImage:setAlpha(0.5)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FuiBox02Right = LUI.UIImage.new(0, 0, 1638, 1672, 0, 0, 159, 125)
	FuiBox02Right:setAlpha(0.2)
	FuiBox02Right:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_fui_box01"))
	FuiBox02Right:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FuiBox02Right:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FuiBox02Right)
	self.FuiBox02Right = FuiBox02Right
	local TiledwhiteNoiseBacking = LUI.UIImage.new(0, 0, 240, 1677, 0, 0, 120, 216)
	TiledwhiteNoiseBacking:setAlpha(0.02)
	TiledwhiteNoiseBacking:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local BGDotPatternLarge2 = LUI.UIImage.new(0, 0, 240, 1677, 0, 0, 214, 218)
	BGDotPatternLarge2:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline_tiled"))
	BGDotPatternLarge2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	BGDotPatternLarge2:setShaderVector(0, 0, 0, 0, 0)
	BGDotPatternLarge2:setupNineSliceShader(32, 4)
	self:addElement(BGDotPatternLarge2)
	self.BGDotPatternLarge2 = BGDotPatternLarge2
	local Line = LUI.UIImage.new(0, 0, 1235.5, 1239.5, 0, 0, 299.5, 907.5)
	Line:setAlpha(0.05)
	Line:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	Line:setShaderVector(0, 0, 0, 0, 0)
	Line:setupNineSliceShader(4, 8)
	self:addElement(Line)
	self.Line = Line
	local LeaguePlayLeaderboardInfoPane = CoD.LeaguePlayLeaderboard_InfoPane.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(LeaguePlayLeaderboardInfoPane)
	self.LeaguePlayLeaderboardInfoPane = LeaguePlayLeaderboardInfoPane
	local LeaguePlayLeaderboard = CoD.LeaguePlayLeaderboard.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(LeaguePlayLeaderboard)
	self.LeaguePlayLeaderboard = LeaguePlayLeaderboard
	local BottomBracket9Slice = LUI.UIImage.new(0, 0, 239, 1678, 0, 0, 954, 962)
	BottomBracket9Slice:setAlpha(0.5)
	BottomBracket9Slice:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	LeaguePlayLeaderboardInfoPane:linkToElementModel(LeaguePlayLeaderboard.LeaderboardEntries, nil, false, function(model)
		LeaguePlayLeaderboardInfoPane:setModel(model, f1_arg1)
	end)
	LeaguePlayLeaderboard:linkToElementModel(LeaguePlayLeaderboard.LeaderboardEntries, nil, false, function(model)
		LeaguePlayLeaderboard:setModel(model, f1_arg1)
	end)
	LeaguePlayLeaderboardInfoPane.id = "LeaguePlayLeaderboardInfoPane"
	LeaguePlayLeaderboard.id = "LeaguePlayLeaderboard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local11 = self
	f1_local11 = LeaguePlayLeaderboardInfoPane
	return self
end
CoD.LeaguePlayLeaderboardTab.__resetProperties = function(f4_arg0)
	f4_arg0.LeaguePlayLeaderboardInfoPane:completeAnimation()
	f4_arg0.LeaguePlayLeaderboard:completeAnimation()
	f4_arg0.arenaLeaguePlayBg:completeAnimation()
	f4_arg0.LeaguePlayLeaderboardInfoPane:setAlpha(1)
	f4_arg0.LeaguePlayLeaderboard:setAlpha(1)
	f4_arg0.arenaLeaguePlayBg:setAlpha(1)
end
CoD.LeaguePlayLeaderboardTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				f5_arg0.arenaLeaguePlayBg:beginAnimation(100)
				f5_arg0.arenaLeaguePlayBg:setAlpha(1)
				f5_arg0.arenaLeaguePlayBg:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.arenaLeaguePlayBg:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.arenaLeaguePlayBg:completeAnimation()
			f5_arg0.arenaLeaguePlayBg:setAlpha(0)
			f5_local0(f5_arg0.arenaLeaguePlayBg)
			local f5_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.LeaguePlayLeaderboardInfoPane:beginAnimation(150)
				f5_arg0.LeaguePlayLeaderboardInfoPane:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.LeaguePlayLeaderboardInfoPane:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f5_arg0.LeaguePlayLeaderboardInfoPane:completeAnimation()
			f5_arg0.LeaguePlayLeaderboardInfoPane:setAlpha(0)
			f5_local1(f5_arg0.LeaguePlayLeaderboardInfoPane)
			local f5_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.LeaguePlayLeaderboard:beginAnimation(100)
				f5_arg0.LeaguePlayLeaderboard:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.LeaguePlayLeaderboard:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f5_arg0.LeaguePlayLeaderboard:completeAnimation()
			f5_arg0.LeaguePlayLeaderboard:setAlpha(0)
			f5_local2(f5_arg0.LeaguePlayLeaderboard)
		end,
	},
}
CoD.LeaguePlayLeaderboardTab.__onClose = function(f11_arg0)
	f11_arg0.LeaguePlayLeaderboardInfoPane:close()
	f11_arg0.LeaguePlayLeaderboard:close()
	f11_arg0.arenaLeaguePlayBg:close()
	f11_arg0.DotTiledBacking:close()
end
