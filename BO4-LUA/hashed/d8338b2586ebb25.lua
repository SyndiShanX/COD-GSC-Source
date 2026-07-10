require("x64:9e7be51d884ab71")
require("x64:e201e7e41431aa7")
CoD.MP_ObjectiveNotificationWidget = InheritFrom(LUI.UIElement)
CoD.MP_ObjectiveNotificationWidget.__defaultWidth = 1919
CoD.MP_ObjectiveNotificationWidget.__defaultHeight = 272
CoD.MP_ObjectiveNotificationWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetupObjectiveNotificationWidget(self, f1_arg1)
	self:setClass(CoD.MP_ObjectiveNotificationWidget)
	self.id = "MP_ObjectiveNotificationWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 0, 860, 1060, 0, 0, -6, 194)
	Icon:subscribeToGlobalModel(f1_arg1, "PerController", "gametypeObjectiveIcon", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local GameTypeHintText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -959.5, 959.5, 0, 0, 320, 368)
	GameTypeHintText.MatchText:setAlpha(1)
	GameTypeHintText.MatchText:setTTF("ttmussels_demibold")
	GameTypeHintText.MatchText:setLetterSpacing(1)
	GameTypeHintText:subscribeToGlobalModel(f1_arg1, "PerController", "gametypeObjectiveHint", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GameTypeHintText.MatchText:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(GameTypeHintText)
	self.GameTypeHintText = GameTypeHintText
	local GameTypeText = LUI.UIText.new(0.5, 0.5, -864, 864, 0, 0, 203, 298)
	GameTypeText:setTTF("ttmussels_regular")
	GameTypeText:setLetterSpacing(-6.7)
	GameTypeText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GameTypeText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	GameTypeText:setBackingType(1)
	GameTypeText:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	GameTypeText:setBackingColor(0, 0, 0)
	GameTypeText:setBackingAlpha(0.9)
	GameTypeText:setBackingXPadding(24)
	GameTypeText:subscribeToGlobalModel(f1_arg1, "PerController", "gametypeObjective", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GameTypeText:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(GameTypeText)
	self.GameTypeText = GameTypeText
	self:mergeStateConditions({
		{
			stateName = "ShowNotification",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "showGametypeObjectiveHint")
				if f5_local0 then
					f5_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "gameTypeAttackers")
					if f5_local0 then
						f5_local0 = IsIntDvarNonZero("mp_prototype")
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "ShowNotificationDefenders",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "showGametypeObjectiveHint") and IsIntDvarNonZero("mp_prototype")
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.showGametypeObjectiveHint, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "showGametypeObjectiveHint",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.gameTypeAttackers, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "gameTypeAttackers",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MP_ObjectiveNotificationWidget.__resetProperties = function(f9_arg0)
	f9_arg0.GameTypeHintText:completeAnimation()
	f9_arg0.Icon:completeAnimation()
	f9_arg0.GameTypeHintText:setAlpha(1)
	f9_arg0.Icon:setAlpha(1)
end
CoD.MP_ObjectiveNotificationWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Icon:completeAnimation()
			f10_arg0.Icon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Icon)
			f10_arg0.GameTypeHintText:completeAnimation()
			f10_arg0.GameTypeHintText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.GameTypeHintText)
		end,
	},
	ShowNotification = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
						f14_arg0:setAlpha(0)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(1500)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f11_arg0.Icon:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f11_arg0.Icon:setAlpha(1)
				f11_arg0.Icon:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Icon:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.Icon:completeAnimation()
			f11_arg0.Icon:setAlpha(0)
			f11_local0(f11_arg0.Icon)
			local f11_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
						f17_arg0:setAlpha(0)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(1500)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f11_arg0.GameTypeHintText:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f11_arg0.GameTypeHintText:setAlpha(1)
				f11_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f11_arg0.GameTypeHintText:completeAnimation()
			f11_arg0.GameTypeHintText:setAlpha(0)
			f11_local1(f11_arg0.GameTypeHintText)
		end,
	},
	ShowNotificationDefenders = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					local f20_local0 = function(f21_arg0)
						f21_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
						f21_arg0:setAlpha(0)
						f21_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
					end
					f20_arg0:beginAnimation(1500)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
				end
				f18_arg0.Icon:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f18_arg0.Icon:setAlpha(1)
				f18_arg0.Icon:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Icon:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.Icon:completeAnimation()
			f18_arg0.Icon:setAlpha(0)
			f18_local0(f18_arg0.Icon)
			local f18_local1 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						f24_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
						f24_arg0:setAlpha(0)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
					end
					f23_arg0:beginAnimation(1500)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f18_arg0.GameTypeHintText:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f18_arg0.GameTypeHintText:setAlpha(1)
				f18_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f18_arg0.GameTypeHintText:completeAnimation()
			f18_arg0.GameTypeHintText:setAlpha(0)
			f18_local1(f18_arg0.GameTypeHintText)
		end,
	},
}
CoD.MP_ObjectiveNotificationWidget.__onClose = function(f25_arg0)
	f25_arg0.Icon:close()
	f25_arg0.GameTypeHintText:close()
	f25_arg0.GameTypeText:close()
end
