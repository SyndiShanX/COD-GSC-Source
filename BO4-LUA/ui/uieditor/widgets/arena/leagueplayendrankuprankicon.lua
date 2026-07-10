require("x64:c8f0a033b64cc47")
CoD.LeaguePlayEndRankUpRankIcon = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEndRankUpRankIcon.__defaultWidth = 450
CoD.LeaguePlayEndRankUpRankIcon.__defaultHeight = 543
CoD.LeaguePlayEndRankUpRankIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEndRankUpRankIcon)
	self.id = "LeaguePlayEndRankUpRankIcon"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Flare = LUI.UIImage.new(0.5, 0.5, -400, 400, 0.5, 0.5, -140, 60)
	Flare:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Flare:setAlpha(0)
	Flare:setZRot(90)
	Flare:setScale(0, 0)
	Flare:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_flare"))
	Flare:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Flare:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Flare)
	self.Flare = Flare
	local FireStreakIcon = LUI.UIImage.new(0, 0, -31, 481, 0, 0, -31, 481)
	FireStreakIcon:setScale(1.5, 1.5)
	FireStreakIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	FireStreakIcon:setShaderVector(0, 4, 4, 0, 0)
	FireStreakIcon:setShaderVector(1, 8, 0, 0, 0)
	FireStreakIcon:linkToElementModel(self, "leaguePlayFirestreakIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FireStreakIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FireStreakIcon)
	self.FireStreakIcon = FireStreakIcon
	local RankIcon = LUI.UIImage.new(0.5, 0.5, -225, 225, 0, 0, 0, 450)
	RankIcon:linkToElementModel(self, "leaguePlayIconLarge", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local CurrentRank = CoD.LeaguePlayEndRankUpRank.new(f1_arg0, f1_arg1, 0, 0, 125, 325, 0, 0, 472, 544)
	CurrentRank:linkToElementModel(self, nil, false, function(model)
		CurrentRank:setModel(model, f1_arg1)
	end)
	self:addElement(CurrentRank)
	self.CurrentRank = CurrentRank
	self:linkToElementModel(self, "leaguePlayIconLarge", true, function(model)
		local f5_local0 = self
		PlayClip(self, "RankUp", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEndRankUpRankIcon.__resetProperties = function(f6_arg0)
	f6_arg0.FireStreakIcon:completeAnimation()
	f6_arg0.RankIcon:completeAnimation()
	f6_arg0.Flare:completeAnimation()
	f6_arg0.FireStreakIcon:setAlpha(1)
	f6_arg0.FireStreakIcon:setScale(1.5, 1.5)
	f6_arg0.RankIcon:setAlpha(1)
	f6_arg0.RankIcon:setScale(1, 1)
	f6_arg0.Flare:setAlpha(0)
	f6_arg0.Flare:setScale(0, 0)
end
CoD.LeaguePlayEndRankUpRankIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(320, Enum[@"luitween"][@"luitween_ease_in"])
					f9_arg0:setAlpha(1)
					f9_arg0:setScale(1.6, 1.6)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f8_arg0:beginAnimation(180)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.FireStreakIcon:beginAnimation(500)
			f7_arg0.FireStreakIcon:setAlpha(0)
			f7_arg0.FireStreakIcon:setScale(1, 1)
			f7_arg0.FireStreakIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.FireStreakIcon:registerEventHandler("transition_complete_keyframe", f7_local0)
			local f7_local1 = function(f10_arg0)
				f10_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_out"])
				f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.RankIcon:beginAnimation(500)
			f7_arg0.RankIcon:setAlpha(1)
			f7_arg0.RankIcon:setScale(1, 1)
			f7_arg0.RankIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.RankIcon:registerEventHandler("transition_complete_keyframe", f7_local1)
		end,
		RankUp = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(50)
					f13_arg0:setAlpha(0)
					f13_arg0:setScale(0, 0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f12_arg0:beginAnimation(30)
				f12_arg0:setAlpha(1)
				f12_arg0:setScale(2, 1)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.Flare:beginAnimation(770)
			f11_arg0.Flare:setAlpha(0)
			f11_arg0.Flare:setScale(0, 0)
			f11_arg0.Flare:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.Flare:registerEventHandler("transition_complete_keyframe", f11_local0)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_in"])
					f15_arg0:setAlpha(1)
					f15_arg0:setScale(1.6, 1.6)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.FireStreakIcon:beginAnimation(800)
				f11_arg0.FireStreakIcon:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FireStreakIcon:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.FireStreakIcon:completeAnimation()
			f11_arg0.FireStreakIcon:setAlpha(0)
			f11_arg0.FireStreakIcon:setScale(1, 1)
			f11_local1(f11_arg0.FireStreakIcon)
			local f11_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						local f18_local0 = function(f19_arg0)
							f19_arg0:beginAnimation(20)
							f19_arg0:setScale(1, 1)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
						end
						f18_arg0:beginAnimation(29)
						f18_arg0:setAlpha(1)
						f18_arg0:setScale(1.02, 1.02)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(199)
					f17_arg0:setAlpha(0.87)
					f17_arg0:setScale(0.96, 0.96)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f11_arg0.RankIcon:beginAnimation(600)
				f11_arg0.RankIcon:setScale(4, 4)
				f11_arg0.RankIcon:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.RankIcon:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f11_arg0.RankIcon:completeAnimation()
			f11_arg0.RankIcon:setAlpha(0)
			f11_arg0.RankIcon:setScale(1, 1)
			f11_local2(f11_arg0.RankIcon)
		end,
	},
}
CoD.LeaguePlayEndRankUpRankIcon.__onClose = function(f20_arg0)
	f20_arg0.FireStreakIcon:close()
	f20_arg0.RankIcon:close()
	f20_arg0.CurrentRank:close()
end
