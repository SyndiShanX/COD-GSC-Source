CoD.GameEndScoreRoundText = InheritFrom(LUI.UIElement)
CoD.GameEndScoreRoundText.__defaultWidth = 200
CoD.GameEndScoreRoundText.__defaultHeight = 129
CoD.GameEndScoreRoundText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreRoundText)
	self.id = "GameEndScoreRoundText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RoundScore = LUI.UIText.new(0, 0, 0, 200, 0, 0, 19.5, 109.5)
	RoundScore:setText(3)
	RoundScore:setTTF("0arame_mono_stencil")
	RoundScore:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	RoundScore:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RoundScore:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RoundScore)
	self.RoundScore = RoundScore
	self:mergeStateConditions({
		{
			stateName = "AnimateIn",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "GameScore", "showSwitchingSides") then
					f2_local0 = CoD.GameEndScoreUtility.ShowOutcomeWithScoreTransition(f1_arg1)
					if f2_local0 then
						f2_local0 = not CoD.GameEndScoreUtility.ShowScoreInsteadOfPips(f1_arg1)
					end
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.GameEndScoreUtility.ShowScoreInsteadOfPips(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.GameScore.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.showSwitchingSides, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "showSwitchingSides",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.forceScoreboard, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["gameScore.currentState"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["gameScore.roundWinLimit"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "gameScore.roundWinLimit",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreRoundText.__resetProperties = function(f12_arg0)
	f12_arg0.RoundScore:completeAnimation()
	f12_arg0.RoundScore:setAlpha(1)
end
CoD.GameEndScoreRoundText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.RoundScore:completeAnimation()
			f13_arg0.RoundScore:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RoundScore)
		end,
	},
	AnimateIn = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.RoundScore:beginAnimation(400)
				f14_arg0.RoundScore:setAlpha(1)
				f14_arg0.RoundScore:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.RoundScore:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.RoundScore:completeAnimation()
			f14_arg0.RoundScore:setAlpha(0)
			f14_local0(f14_arg0.RoundScore)
		end,
	},
	Visible = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.RoundScore:completeAnimation()
			f16_arg0.RoundScore:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.RoundScore)
		end,
	},
}
