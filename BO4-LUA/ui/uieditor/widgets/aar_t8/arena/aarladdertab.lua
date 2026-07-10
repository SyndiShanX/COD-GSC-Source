require("x64:f00a10fc8301da2")
require("x64:ac2be45871b06fe")
require("x64:9e8b930117f8921")
require("x64:a876df622faedff")
require("x64:410e708eaf33033")
CoD.AARLadderTab = InheritFrom(LUI.UIElement)
CoD.AARLadderTab.__defaultWidth = 1920
CoD.AARLadderTab.__defaultHeight = 900
CoD.AARLadderTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARLadderTab)
	self.id = "AARLadderTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 42, 877)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local TiledPlusGrid = LUI.UIImage.new(0, 0, -160.5, 1861.5, 0, 0, -85.5, 856.5)
	TiledPlusGrid:setAlpha(0.05)
	TiledPlusGrid:setImage(RegisterImage(0x6E37BAE22631294))
	TiledPlusGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledPlusGrid:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid)
	self.TiledPlusGrid = TiledPlusGrid
	local PerformBg = LUI.UIImage.new(0, 0, 823, 1721, 0, 0, 210, 710)
	PerformBg:setAlpha(0.8)
	PerformBg:setImage(RegisterImage(0xF95A1671A1AB874))
	PerformBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PerformBg:setShaderVector(0, 0, 0, 0, 0)
	PerformBg:setupNineSliceShader(344, 136)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local AARGameInfo = CoD.AARGameInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -1437, 483, 0, 0, 80.5, 280.5)
	AARGameInfo:mergeStateConditions({
		{
			stateName = "Draw",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	AARGameInfo:linkToElementModel(AARGameInfo, "lastMatchOutcome", true, function(model)
		f1_arg0:updateElementState(AARGameInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lastMatchOutcome",
		})
	end)
	AARGameInfo:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", nil, function(model)
		AARGameInfo:setModel(model, f1_arg1)
	end)
	self:addElement(AARGameInfo)
	self.AARGameInfo = AARGameInfo
	local AARLeaguePlayLadderWidget = CoD.AAR_LeaguePlayLadderWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -137, 761, 0, 0, 205, 705)
	self:addElement(AARLeaguePlayLadderWidget)
	self.AARLeaguePlayLadderWidget = AARLeaguePlayLadderWidget
	local VictoryPoints = CoD.LeaguePlay_AAR_PointPanel.new(f1_arg0, f1_arg1, 0.5, 0.5, -763, -363, 0, 0, 209, 709)
	VictoryPoints:linkToElementModel(self, nil, false, function(model)
		VictoryPoints:setModel(model, f1_arg1)
	end)
	self:addElement(VictoryPoints)
	self.VictoryPoints = VictoryPoints
	local Line = LUI.UIImage.new(0, 0, 709, 711, 0, 0, 208.5, 710.5)
	Line:setAlpha(0.05)
	Line:setImage(RegisterImage(0xC49B0C8991A541F))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Line:setShaderVector(0, 0, 0, 0, 0)
	Line:setupNineSliceShader(4, 8)
	self:addElement(Line)
	self.Line = Line
	local ArenaLeaguePlayLadderSkillDivision = CoD.ArenaLeaguePlay_LadderSkillDivision.new(f1_arg0, f1_arg1, 0, 0, 822, 1720, 0, 0, 76.5, 172.5)
	self:addElement(ArenaLeaguePlayLadderSkillDivision)
	self.ArenaLeaguePlayLadderSkillDivision = ArenaLeaguePlayLadderSkillDivision
	self:mergeStateConditions({
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_ARENA_LEAGUE_PLAY_LADDER) and IsArenaMode()
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["AAR.activeTab"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local9, f1_local11["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	AARLeaguePlayLadderWidget.id = "AARLeaguePlayLadderWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARLadderTab.__resetProperties = function(f9_arg0)
	f9_arg0.AARGameInfo:completeAnimation()
	f9_arg0.AARLeaguePlayLadderWidget:completeAnimation()
	f9_arg0.AarMpBacking:completeAnimation()
	f9_arg0.VictoryPoints:completeAnimation()
	f9_arg0.TiledPlusGrid:completeAnimation()
	f9_arg0.PerformBg:completeAnimation()
	f9_arg0.Line:completeAnimation()
	f9_arg0.ArenaLeaguePlayLadderSkillDivision:completeAnimation()
	f9_arg0.AARGameInfo:setAlpha(1)
	f9_arg0.AARLeaguePlayLadderWidget:setAlpha(1)
	f9_arg0.AarMpBacking:setAlpha(1)
	f9_arg0.VictoryPoints:setAlpha(1)
	f9_arg0.TiledPlusGrid:setAlpha(0.05)
	f9_arg0.PerformBg:setAlpha(0.8)
	f9_arg0.Line:setAlpha(0.05)
	f9_arg0.ArenaLeaguePlayLadderSkillDivision:setAlpha(1)
end
CoD.AARLadderTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(8)
			f10_arg0.AarMpBacking:completeAnimation()
			f10_arg0.AarMpBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.AarMpBacking)
			f10_arg0.TiledPlusGrid:completeAnimation()
			f10_arg0.TiledPlusGrid:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TiledPlusGrid)
			f10_arg0.PerformBg:completeAnimation()
			f10_arg0.PerformBg:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.PerformBg)
			f10_arg0.AARGameInfo:completeAnimation()
			f10_arg0.AARGameInfo:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.AARGameInfo)
			f10_arg0.AARLeaguePlayLadderWidget:completeAnimation()
			f10_arg0.AARLeaguePlayLadderWidget:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.AARLeaguePlayLadderWidget)
			f10_arg0.VictoryPoints:completeAnimation()
			f10_arg0.VictoryPoints:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VictoryPoints)
			f10_arg0.Line:completeAnimation()
			f10_arg0.Line:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Line)
			f10_arg0.ArenaLeaguePlayLadderSkillDivision:completeAnimation()
			f10_arg0.ArenaLeaguePlayLadderSkillDivision:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ArenaLeaguePlayLadderSkillDivision)
		end,
	},
	Arena = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			local f11_local0 = function(f12_arg0)
				f11_arg0.AarMpBacking:beginAnimation(150)
				f11_arg0.AarMpBacking:setAlpha(1)
				f11_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.AarMpBacking:completeAnimation()
			f11_arg0.AarMpBacking:setAlpha(0)
			f11_local0(f11_arg0.AarMpBacking)
			local f11_local1 = function(f13_arg0)
				f13_arg0:beginAnimation(150)
				f13_arg0:setAlpha(0.8)
				f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.PerformBg:beginAnimation(220)
			f11_arg0.PerformBg:setAlpha(0)
			f11_arg0.PerformBg:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.PerformBg:registerEventHandler("transition_complete_keyframe", f11_local1)
			local f11_local2 = function(f14_arg0)
				f14_arg0:beginAnimation(150)
				f14_arg0:setAlpha(1)
				f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.AARGameInfo:beginAnimation(100)
			f11_arg0.AARGameInfo:setAlpha(0)
			f11_arg0.AARGameInfo:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.AARGameInfo:registerEventHandler("transition_complete_keyframe", f11_local2)
			local f11_local3 = function(f15_arg0)
				f15_arg0:beginAnimation(150)
				f15_arg0:setAlpha(1)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.AARLeaguePlayLadderWidget:beginAnimation(250)
			f11_arg0.AARLeaguePlayLadderWidget:setAlpha(0)
			f11_arg0.AARLeaguePlayLadderWidget:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.AARLeaguePlayLadderWidget:registerEventHandler("transition_complete_keyframe", f11_local3)
			local f11_local4 = function(f16_arg0)
				f16_arg0:beginAnimation(150)
				f16_arg0:setAlpha(1)
				f16_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.VictoryPoints:beginAnimation(100)
			f11_arg0.VictoryPoints:setAlpha(0)
			f11_arg0.VictoryPoints:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.VictoryPoints:registerEventHandler("transition_complete_keyframe", f11_local4)
			local f11_local5 = function(f17_arg0)
				f17_arg0:beginAnimation(150)
				f17_arg0:setAlpha(1)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ArenaLeaguePlayLadderSkillDivision:beginAnimation(100)
			f11_arg0.ArenaLeaguePlayLadderSkillDivision:setAlpha(0)
			f11_arg0.ArenaLeaguePlayLadderSkillDivision:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.ArenaLeaguePlayLadderSkillDivision:registerEventHandler("transition_complete_keyframe", f11_local5)
		end,
	},
}
CoD.AARLadderTab.__onClose = function(f18_arg0)
	f18_arg0.AarMpBacking:close()
	f18_arg0.AARGameInfo:close()
	f18_arg0.AARLeaguePlayLadderWidget:close()
	f18_arg0.VictoryPoints:close()
	f18_arg0.ArenaLeaguePlayLadderSkillDivision:close()
end
