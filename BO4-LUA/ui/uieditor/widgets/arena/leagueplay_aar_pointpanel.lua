require("x64:fe1159ce8fa444b")
require("x64:c9a3c9eb5d5ac59")
require("x64:564ca313abeb19a")
CoD.LeaguePlay_AAR_PointPanel = InheritFrom(LUI.UIElement)
CoD.LeaguePlay_AAR_PointPanel.__defaultWidth = 400
CoD.LeaguePlay_AAR_PointPanel.__defaultHeight = 500
CoD.LeaguePlay_AAR_PointPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlay_AAR_PointPanel)
	self.id = "LeaguePlay_AAR_PointPanel"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	blurBg:setAlpha(0)
	blurBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blurBg)
	self.blurBg = blurBg
	local DailyBonusArrow = LUI.UIImage.new(0, 0, 196.5, 204.5, 0, 0, 481, 497)
	DailyBonusArrow:setRGB(0.92, 0.92, 0.92)
	DailyBonusArrow:setAlpha(0.1)
	DailyBonusArrow:setZRot(90)
	DailyBonusArrow:setScale(2, 2)
	DailyBonusArrow:setImage(RegisterImage(@"uie_ui_hud_common_triangle"))
	self:addElement(DailyBonusArrow)
	self.DailyBonusArrow = DailyBonusArrow
	local RightArrowL = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 0, 0, -6, 59, 0, 0, 235.5, 266.5)
	RightArrowL:setAlpha(0.3)
	RightArrowL:setZRot(180)
	RightArrowL:setScale(0.6, 0.6)
	self:addElement(RightArrowL)
	self.RightArrowL = RightArrowL
	local RightArrowR = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 0, 0, 339.5, 404.5, 0, 0, 235.5, 266.5)
	RightArrowR:setAlpha(0.3)
	RightArrowR:setScale(0.6, 0.6)
	self:addElement(RightArrowR)
	self.RightArrowR = RightArrowR
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0.02, 1, 0, 0)
	TiledShaderImage:setRGB(0.92, 0.92, 0.92)
	TiledShaderImage:setAlpha(0.02)
	TiledShaderImage:setImage(RegisterImage(@"uie_ui_hud_vehicle_lightstrike_grid"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(33, 33)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local PerformBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PerformBg:setAlpha(0.8)
	PerformBg:setImage(RegisterImage(@"uie_ui_menu_aar_perform_repeat_bg"))
	PerformBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PerformBg:setShaderVector(0, 0, 0, 0, 0)
	PerformBg:setupNineSliceShader(344, 136)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local PerformBracketBlur = LUI.UIImage.new(0, 1, -3.5, 4.5, 1, 1, -14, 6)
	PerformBracketBlur:setAlpha(0.3)
	PerformBracketBlur:setImage(RegisterImage(@"uie_ui_menu_aar_perform_botline_blur"))
	PerformBracketBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	PerformBracketBlur:setShaderVector(0, 0, 0, 0, 0)
	PerformBracketBlur:setupNineSliceShader(174, 10)
	self:addElement(PerformBracketBlur)
	self.PerformBracketBlur = PerformBracketBlur
	local infoBracketBot = LUI.UIImage.new(0, 1, -1, 1, 1, 1, -7, 1)
	infoBracketBot:setAlpha(0.5)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local PlacementBonusPoints = CoD.AARLadderPoints.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 308, 458)
	PlacementBonusPoints:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "bonus", 0)
			end,
		},
	})
	PlacementBonusPoints:linkToElementModel(PlacementBonusPoints, "bonus", true, function(model)
		f1_arg0:updateElementState(PlacementBonusPoints, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bonus",
		})
	end)
	PlacementBonusPoints:linkToElementModel(self, nil, false, function(model)
		PlacementBonusPoints:setModel(model, f1_arg1)
	end)
	PlacementBonusPoints:linkToElementModel(self, "bonus", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PlacementBonusPoints.PointsTxt:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.ArenaLeaguePlayUtility.AARLadderBonusText(f1_arg1, f5_local0)))
		end
	end)
	PlacementBonusPoints:linkToElementModel(self, "bonus", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			PlacementBonusPoints.Points:setText(f6_local0)
		end
	end)
	self:addElement(PlacementBonusPoints)
	self.PlacementBonusPoints = PlacementBonusPoints
	local MatchAndBonusPoints = CoD.AARLadderPoints.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 44, 194)
	MatchAndBonusPoints.PlusMinus:setRGB(1, 1, 1)
	MatchAndBonusPoints.Points:setRGB(1, 1, 1)
	MatchAndBonusPoints.PointsAdd:setRGB(1, 1, 1)
	MatchAndBonusPoints:linkToElementModel(self, "points", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			MatchAndBonusPoints.Points:setText(CoD.BaseUtility.AlreadyLocalized(NumAbs(f7_local0)))
		end
	end)
	MatchAndBonusPoints:linkToElementModel(self, "points", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			MatchAndBonusPoints.PointsAdd:setText(CoD.BaseUtility.AlreadyLocalized(NumAbs(f8_local0)))
		end
	end)
	self:addElement(MatchAndBonusPoints)
	self.MatchAndBonusPoints = MatchAndBonusPoints
	local CommonSearchingBar = CoD.CommonSearchingBar.new(f1_arg0, f1_arg1, 0, 0, 270, 392, 0, 0, 13, 35)
	CommonSearchingBar:setAlpha(0.2)
	self:addElement(CommonSearchingBar)
	self.CommonSearchingBar = CommonSearchingBar
	local TopBar = LUI.UIImage.new(0, 0, 0, 400, 0, 0, 0, 9)
	TopBar:setRGB(0.92, 0.92, 0.92)
	TopBar:setAlpha(0.01)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local Sound = LUI.UIElement.new(0, 0, -155.5, -123.5, 0, 0, 470, 502)
	Sound:setPlaySoundDirect(true)
	self:addElement(Sound)
	self.Sound = Sound
	self:mergeStateConditions({
		{
			stateName = "Defeated",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "AARSummaryStats", "lastMatchOutcome", @"loss")
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = DataSources.AARSummaryStats.getModel(f1_arg1)
	f1_local15(f1_local14, f1_local16.lastMatchOutcome, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lastMatchOutcome",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlay_AAR_PointPanel.__resetProperties = function(f11_arg0)
	f11_arg0.CommonSearchingBar:completeAnimation()
	f11_arg0.DailyBonusArrow:completeAnimation()
	f11_arg0.RightArrowL:completeAnimation()
	f11_arg0.RightArrowR:completeAnimation()
	f11_arg0.PlacementBonusPoints:completeAnimation()
	f11_arg0.MatchAndBonusPoints:completeAnimation()
	f11_arg0.Sound:completeAnimation()
	f11_arg0.CommonSearchingBar:setAlpha(0.2)
	f11_arg0.DailyBonusArrow:setAlpha(0.1)
	f11_arg0.RightArrowL:setLeftRight(0, 0, -6, 59)
	f11_arg0.RightArrowL:setAlpha(0.3)
	f11_arg0.RightArrowR:setLeftRight(0, 0, 339.5, 404.5)
	f11_arg0.RightArrowR:setAlpha(0.3)
	f11_arg0.PlacementBonusPoints:setAlpha(1)
	f11_arg0.PlacementBonusPoints.Flare:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f11_arg0.MatchAndBonusPoints:setAlpha(1)
	f11_arg0.MatchAndBonusPoints.Flare:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f11_arg0.MatchAndBonusPoints.PlusMinus:setRGB(1, 1, 1)
	f11_arg0.MatchAndBonusPoints.PlusMinus:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/plus"))
	f11_arg0.MatchAndBonusPoints.PointsTxt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6436CFB031FD2F44"))
	f11_arg0.MatchAndBonusPoints.Points:setRGB(1, 1, 1)
	f11_arg0.MatchAndBonusPoints.PointsAdd:setRGB(1, 1, 1)
end
CoD.LeaguePlay_AAR_PointPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(7)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(149)
					f14_arg0:setAlpha(0.1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.DailyBonusArrow:beginAnimation(300)
				f12_arg0.DailyBonusArrow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.DailyBonusArrow:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.DailyBonusArrow:completeAnimation()
			f12_arg0.DailyBonusArrow:setAlpha(0)
			f12_local0(f12_arg0.DailyBonusArrow)
			local f12_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f16_arg0:setLeftRight(0, 0, -6, 59)
					f16_arg0:setAlpha(0.4)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.RightArrowL:beginAnimation(350)
				f12_arg0.RightArrowL:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.RightArrowL:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f12_arg0.RightArrowL:completeAnimation()
			f12_arg0.RightArrowL:setLeftRight(0, 0, -206, -141)
			f12_arg0.RightArrowL:setAlpha(0)
			f12_local1(f12_arg0.RightArrowL)
			local f12_local2 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(99, Enum[@"luitween"][@"luitween_ease_out"])
					f18_arg0:setLeftRight(0, 0, 339.5, 404.5)
					f18_arg0:setAlpha(0.4)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.RightArrowR:beginAnimation(350)
				f12_arg0.RightArrowR:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.RightArrowR:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f12_arg0.RightArrowR:completeAnimation()
			f12_arg0.RightArrowR:setLeftRight(0, 0, 539.5, 604.5)
			f12_arg0.RightArrowR:setAlpha(0)
			f12_local2(f12_arg0.RightArrowR)
			local f12_local3 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_out"])
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.PlacementBonusPoints:beginAnimation(500)
				f12_arg0.PlacementBonusPoints:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.PlacementBonusPoints:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f12_arg0.PlacementBonusPoints:completeAnimation()
			f12_arg0.PlacementBonusPoints.Flare:completeAnimation()
			f12_arg0.PlacementBonusPoints:setAlpha(0)
			f12_arg0.PlacementBonusPoints.Flare:setRGB(0.75, 0.92, 0.53)
			f12_local3(f12_arg0.PlacementBonusPoints)
			local f12_local4 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_out"])
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.MatchAndBonusPoints:beginAnimation(50)
				f12_arg0.MatchAndBonusPoints:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.MatchAndBonusPoints:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f12_arg0.MatchAndBonusPoints:completeAnimation()
			f12_arg0.MatchAndBonusPoints:setAlpha(0)
			f12_local4(f12_arg0.MatchAndBonusPoints)
			local f12_local5 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(149)
					f24_arg0:setAlpha(0.2)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.CommonSearchingBar:beginAnimation(300)
				f12_arg0.CommonSearchingBar:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CommonSearchingBar:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f12_arg0.CommonSearchingBar:completeAnimation()
			f12_arg0.CommonSearchingBar:setAlpha(0)
			f12_local5(f12_arg0.CommonSearchingBar)
			local f12_local6 = function(f25_arg0)
				f12_arg0.Sound:playSound("uin_wlh_victory", f12_arg1)
				f12_arg0.Sound:beginAnimation(500)
				f12_arg0.Sound:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("uin_wlh_placement_bonus", f12_arg1)
					f12_arg0.clipFinished(element, event)
				end)
			end
			f12_arg0.Sound:completeAnimation()
			f12_local6(f12_arg0.Sound)
		end,
	},
	Defeated = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(7)
			local f27_local0 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(149)
					f29_arg0:setAlpha(0.1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.DailyBonusArrow:beginAnimation(300)
				f27_arg0.DailyBonusArrow:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DailyBonusArrow:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f27_arg0.DailyBonusArrow:completeAnimation()
			f27_arg0.DailyBonusArrow:setAlpha(0)
			f27_local0(f27_arg0.DailyBonusArrow)
			local f27_local1 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(99)
					f31_arg0:setLeftRight(0, 0, -6, 59)
					f31_arg0:setAlpha(0.4)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.RightArrowL:beginAnimation(350)
				f27_arg0.RightArrowL:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.RightArrowL:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f27_arg0.RightArrowL:completeAnimation()
			f27_arg0.RightArrowL:setLeftRight(0, 0, -206, -141)
			f27_arg0.RightArrowL:setAlpha(0)
			f27_local1(f27_arg0.RightArrowL)
			local f27_local2 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(99)
					f33_arg0:setLeftRight(0, 0, 339.5, 404.5)
					f33_arg0:setAlpha(0.4)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.RightArrowR:beginAnimation(350)
				f27_arg0.RightArrowR:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.RightArrowR:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f27_arg0.RightArrowR:completeAnimation()
			f27_arg0.RightArrowR:setLeftRight(0, 0, 539.5, 604.5)
			f27_arg0.RightArrowR:setAlpha(0)
			f27_local2(f27_arg0.RightArrowR)
			local f27_local3 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(149)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.PlacementBonusPoints:beginAnimation(500)
				f27_arg0.PlacementBonusPoints:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.PlacementBonusPoints:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f27_arg0.PlacementBonusPoints:completeAnimation()
			f27_arg0.PlacementBonusPoints.Flare:completeAnimation()
			f27_arg0.PlacementBonusPoints:setAlpha(0)
			f27_arg0.PlacementBonusPoints.Flare:setRGB(0.75, 0.92, 0.53)
			f27_local3(f27_arg0.PlacementBonusPoints)
			local f27_local4 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(150)
					f37_arg0:setAlpha(1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.MatchAndBonusPoints:beginAnimation(50)
				f27_arg0.MatchAndBonusPoints:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.MatchAndBonusPoints:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f27_arg0.MatchAndBonusPoints:completeAnimation()
			f27_arg0.MatchAndBonusPoints.Flare:completeAnimation()
			f27_arg0.MatchAndBonusPoints.PlusMinus:completeAnimation()
			f27_arg0.MatchAndBonusPoints.PointsTxt:completeAnimation()
			f27_arg0.MatchAndBonusPoints.Points:completeAnimation()
			f27_arg0.MatchAndBonusPoints.PointsAdd:completeAnimation()
			f27_arg0.MatchAndBonusPoints:setAlpha(0)
			f27_arg0.MatchAndBonusPoints.Flare:setRGB(ColorSet.ResistanceLow.r, ColorSet.ResistanceLow.g, ColorSet.ResistanceLow.b)
			f27_arg0.MatchAndBonusPoints.PlusMinus:setRGB(0.55, 0, 0)
			f27_arg0.MatchAndBonusPoints.PlusMinus:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/minus"))
			f27_arg0.MatchAndBonusPoints.PointsTxt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E875FF3C976BA98"))
			f27_arg0.MatchAndBonusPoints.Points:setRGB(0.55, 0, 0)
			f27_arg0.MatchAndBonusPoints.PointsAdd:setRGB(0.55, 0, 0)
			f27_local4(f27_arg0.MatchAndBonusPoints)
			local f27_local5 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(149)
					f39_arg0:setAlpha(0.1)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
				end
				f27_arg0.CommonSearchingBar:beginAnimation(300)
				f27_arg0.CommonSearchingBar:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.CommonSearchingBar:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f27_arg0.CommonSearchingBar:completeAnimation()
			f27_arg0.CommonSearchingBar:setAlpha(0)
			f27_local5(f27_arg0.CommonSearchingBar)
			f27_arg0.Sound:completeAnimation()
			f27_arg0.Sound:playSound("uin_wlh_defeat", f27_arg1)
			f27_arg0.clipFinished(f27_arg0.Sound)
		end,
	},
}
CoD.LeaguePlay_AAR_PointPanel.__onClose = function(f40_arg0)
	f40_arg0.RightArrowL:close()
	f40_arg0.RightArrowR:close()
	f40_arg0.PlacementBonusPoints:close()
	f40_arg0.MatchAndBonusPoints:close()
	f40_arg0.CommonSearchingBar:close()
end
