CoD.LeaguePlayEndRankUpRank = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEndRankUpRank.__defaultWidth = 200
CoD.LeaguePlayEndRankUpRank.__defaultHeight = 72
CoD.LeaguePlayEndRankUpRank.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEndRankUpRank)
	self.id = "LeaguePlayEndRankUpRank"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CurrentRank = LUI.UIText.new(0.5, 0.5, -100, 100, 1, 1, -72, 0)
	CurrentRank:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	CurrentRank:setTTF("ttmussels_demibold")
	CurrentRank:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	CurrentRank:setShaderVector(0, 0.3, 0, 0, 0)
	CurrentRank:setShaderVector(1, 0, 0, 0, 0)
	CurrentRank:setShaderVector(2, 0.4, 0.3, 0, 0.6)
	CurrentRank:setLetterSpacing(8)
	CurrentRank:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CurrentRank:linkToElementModel(self, "leaguePlayRank", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CurrentRank:setText(ToUpper(LocalizeStringWithParameter(0x47AC0462E4B2132, f2_local0)))
		end
	end)
	self:addElement(CurrentRank)
	self.CurrentRank = CurrentRank
	self:linkToElementModel(self, "leaguePlayRank", true, function(model)
		local f3_local0 = self
		PlayClip(self, "RankUp", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEndRankUpRank.__resetProperties = function(f4_arg0)
	f4_arg0.CurrentRank:completeAnimation()
	f4_arg0.CurrentRank:setAlpha(1)
end
CoD.LeaguePlayEndRankUpRank.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.CurrentRank:beginAnimation(500)
				f5_arg0.CurrentRank:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CurrentRank:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.CurrentRank:completeAnimation()
			f5_arg0.CurrentRank:setAlpha(0)
			f5_local0(f5_arg0.CurrentRank)
		end,
		RankUp = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
						f11_arg0:setAlpha(1)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(199)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.CurrentRank:beginAnimation(500)
				f8_arg0.CurrentRank:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CurrentRank:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.CurrentRank:completeAnimation()
			f8_arg0.CurrentRank:setAlpha(0)
			f8_local0(f8_arg0.CurrentRank)
		end,
	},
}
CoD.LeaguePlayEndRankUpRank.__onClose = function(f12_arg0)
	f12_arg0.CurrentRank:close()
end
