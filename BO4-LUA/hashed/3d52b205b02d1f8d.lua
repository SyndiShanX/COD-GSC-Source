require("x64:2352848a3a3cbb")
require("x64:9ca67a3916a7ab6")
CoD.GameEndScore_DeathCamPrompt = InheritFrom(LUI.UIElement)
CoD.GameEndScore_DeathCamPrompt.__defaultWidth = 202
CoD.GameEndScore_DeathCamPrompt.__defaultHeight = 123
CoD.GameEndScore_DeathCamPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_DeathCamPrompt)
	self.id = "GameEndScore_DeathCamPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DeathCamLabel = CoD.WarzoneDeathCamLabelButton.new(f1_arg0, f1_arg1, 0, 0, 32, 486, 0, 0, 80, 120)
	self:addElement(DeathCamLabel)
	self.DeathCamLabel = DeathCamLabel
	local ButtonIcon = CoD.ButtonIcon.new(f1_arg0, f1_arg1, 0, 0, 0, 30, 0, 0, 84, 114)
	ButtonIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ButtonIcon:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ButtonIcon.buttonImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(ButtonIcon)
	self.ButtonIcon = ButtonIcon
	local WaypointBacker = LUI.UIImage.new(0.5, 0.5, -53, 23, 0.5, 0.5, -73, 3)
	WaypointBacker:setImage(RegisterImage(0x8DDD1FDE43242E1))
	self:addElement(WaypointBacker)
	self.WaypointBacker = WaypointBacker
	local WaypointPattern = LUI.UIImage.new(0.5, 0.5, -53, 23, 0.5, 0.5, -73, 3)
	WaypointPattern:setRGB(0.13, 0.87, 0.94)
	WaypointPattern:setAlpha(0.75)
	WaypointPattern:setImage(RegisterImage(0x159D9B7B7294C91))
	WaypointPattern:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	WaypointPattern:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(WaypointPattern)
	self.WaypointPattern = WaypointPattern
	local YouText = LUI.UIText.new(0.5, 0.5, -44, 14, 0, 0, 16.5, 37.5)
	YouText:setText(LocalizeToUpperString(0x4657C39C60632A0))
	YouText:setTTF("ttmussels_demibold")
	YouText:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	YouText:setShaderVector(0, 0.5, 0, 0, 0)
	YouText:setShaderVector(1, 0, 0, 0, 0)
	YouText:setShaderVector(2, 0, 0, 0, 0.5)
	YouText:setLetterSpacing(2)
	YouText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	YouText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(YouText)
	self.YouText = YouText
	local Arrows = LUI.UIImage.new(0.5, 0.5, -31, 1, 0, 0, 54.5, 86.5)
	Arrows:setImage(RegisterImage(0xAB17136E34541E3))
	Arrows:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Arrows:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Arrows)
	self.Arrows = Arrows
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.CanShowWarzoneKillcam(f1_arg1) and not IsPC()
			end,
		},
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.GameEndScoreUtility.CanShowWarzoneKillcam(f1_arg1)
			end,
		},
		{
			stateName = "VisiblePCGamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1) and CoD.GameEndScoreUtility.CanShowWarzoneKillcam(f1_arg1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.aliveTeammateCount, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "aliveTeammateCount",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["gameScore.hasPlayedDeathCam"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "gameScore.hasPlayedDeathCam",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["gameScore.currentState"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f13_arg1)
	end)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_DeathCamPrompt.__resetProperties = function(f15_arg0)
	f15_arg0.YouText:completeAnimation()
	f15_arg0.ButtonIcon:completeAnimation()
	f15_arg0.DeathCamLabel:completeAnimation()
	f15_arg0.WaypointBacker:completeAnimation()
	f15_arg0.WaypointPattern:completeAnimation()
	f15_arg0.Arrows:completeAnimation()
	f15_arg0.YouText:setAlpha(1)
	f15_arg0.ButtonIcon:setAlpha(1)
	f15_arg0.DeathCamLabel:setLeftRight(0, 0, 32, 486)
	f15_arg0.DeathCamLabel:setTopBottom(0, 0, 80, 120)
	f15_arg0.DeathCamLabel:setAlpha(1)
	f15_arg0.WaypointBacker:setAlpha(1)
	f15_arg0.WaypointPattern:setAlpha(0.75)
	f15_arg0.Arrows:setAlpha(1)
	f15_arg0.Arrows:setShaderVector(0, 1, 0, 0, 0)
end
CoD.GameEndScore_DeathCamPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(6)
			f16_arg0.DeathCamLabel:completeAnimation()
			f16_arg0.DeathCamLabel:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.DeathCamLabel)
			f16_arg0.ButtonIcon:completeAnimation()
			f16_arg0.ButtonIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ButtonIcon)
			f16_arg0.WaypointBacker:completeAnimation()
			f16_arg0.WaypointBacker:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.WaypointBacker)
			f16_arg0.WaypointPattern:completeAnimation()
			f16_arg0.WaypointPattern:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.WaypointPattern)
			f16_arg0.YouText:completeAnimation()
			f16_arg0.YouText:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.YouText)
			f16_arg0.Arrows:completeAnimation()
			f16_arg0.Arrows:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Arrows)
		end,
	},
	Visible = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(200)
					f19_arg0:setAlpha(0.75)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.WaypointPattern:beginAnimation(200)
				f17_arg0.WaypointPattern:setAlpha(1)
				f17_arg0.WaypointPattern:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.WaypointPattern:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.WaypointPattern:completeAnimation()
			f17_arg0.WaypointPattern:setAlpha(0.75)
			f17_local0(f17_arg0.WaypointPattern)
			local f17_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(200)
					f21_arg0:setShaderVector(0, 1, 0, 0, 0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.Arrows:beginAnimation(200)
				f17_arg0.Arrows:setShaderVector(0, 2, 0, 0, 0)
				f17_arg0.Arrows:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Arrows:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f17_arg0.Arrows:completeAnimation()
			f17_arg0.Arrows:setShaderVector(0, 1, 0, 0, 0)
			f17_local1(f17_arg0.Arrows)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.DeathCamLabel:completeAnimation()
			f22_arg0.DeathCamLabel:setLeftRight(0.5, 0.5, -101, 353)
			f22_arg0.DeathCamLabel:setTopBottom(0.5, 0.5, 18.5, 58.5)
			f22_arg0.clipFinished(f22_arg0.DeathCamLabel)
			f22_arg0.ButtonIcon:completeAnimation()
			f22_arg0.ButtonIcon:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ButtonIcon)
		end,
	},
	VisiblePCGamepad = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.DeathCamLabel:completeAnimation()
			f23_arg0.DeathCamLabel:setLeftRight(0.5, 0.5, -69, 385)
			f23_arg0.DeathCamLabel:setTopBottom(0.5, 0.5, 18.5, 58.5)
			f23_arg0.clipFinished(f23_arg0.DeathCamLabel)
			f23_arg0.ButtonIcon:completeAnimation()
			f23_arg0.ButtonIcon:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.ButtonIcon)
		end,
	},
}
CoD.GameEndScore_DeathCamPrompt.__onClose = function(f24_arg0)
	f24_arg0.DeathCamLabel:close()
	f24_arg0.ButtonIcon:close()
end
