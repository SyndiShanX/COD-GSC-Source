require("x64:6d00856fffb788b")
require("x64:e6cc0e76ed868e0")
CoD.KillcamHeader = InheritFrom(LUI.UIElement)
CoD.KillcamHeader.__defaultWidth = 1920
CoD.KillcamHeader.__defaultHeight = 140
CoD.KillcamHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamHeader)
	self.id = "KillcamHeader"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RespawnPrompt = LUI.UIText.new(1, 1, -1608, -450, 0, 0, 38, 88)
	RespawnPrompt:setRGB(0.92, 0.92, 0.92)
	RespawnPrompt:setScale(0.55, 0.55)
	RespawnPrompt:setTTF("0arame_mono_stencil")
	RespawnPrompt:setLetterSpacing(3)
	RespawnPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RespawnPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	RespawnPrompt.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			RespawnPrompt:setText(LocalizeToUpperString(KillCamAllowRespawnToString(f1_arg1, f2_local0)))
		end
	end
	RespawnPrompt:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamAllowRespawn", RespawnPrompt.__String_Reference)
	RespawnPrompt.__String_Reference_FullPath = function()
		local f3_local0 = DataSources.HUDItems.getModel(f1_arg1)
		f3_local0 = f3_local0.killcamAllowRespawn
		if f3_local0 then
			RespawnPrompt.__String_Reference(f3_local0)
		end
	end
	self:addElement(RespawnPrompt)
	self.RespawnPrompt = RespawnPrompt
	local killcamTitle = LUI.UIText.new(0, 0, 16, 691, 0, 0, 6, 70)
	killcamTitle:setRGB(0.91, 0.78, 0.28)
	killcamTitle:setScale(1.02, 1.02)
	killcamTitle:setText(LocalizeToUpperString(@"hash_3E4A1361965A5300"))
	killcamTitle:setTTF("ttmussels_regular")
	killcamTitle:setLetterSpacing(14)
	killcamTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	killcamTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	killcamTitle:setBackingType(1)
	killcamTitle:setBackingWidget(CoD.KIllcam_Title, f1_arg0, f1_arg1)
	killcamTitle:setBackingXPadding(68)
	killcamTitle:setBackingYPadding(18)
	self:addElement(killcamTitle)
	self.killcamTitle = killcamTitle
	local KilledByWeapon = CoD.KillcamKilledByWeapon.new(f1_arg0, f1_arg1, 1, 1, -650, -150, 0, 0, 38, 88)
	self:addElement(KilledByWeapon)
	self.KilledByWeapon = KilledByWeapon
	RespawnPrompt:appendEventHandler("input_source_changed", RespawnPrompt.__String_Reference_FullPath)
	local f1_local4 = RespawnPrompt
	local f1_local5 = RespawnPrompt.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, RespawnPrompt.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f4_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
				if f4_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) then
						f4_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "FinalKillcam",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_final_killcam"])
			end,
		},
		{
			stateName = "RoundEndingKillcam",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
			end,
		},
		{
			stateName = "PlayOfTheMatch",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
			end,
		},
		{
			stateName = "NemesisKillcam",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		if IsElementInState(element, "Killcam") then
			PlayClipOnElement(self, {
				elementName = "Glitch",
				clipName = "GlitchSmall2Slow",
			}, controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamHeader.__resetProperties = function(f15_arg0)
	f15_arg0.RespawnPrompt:completeAnimation()
	f15_arg0.RespawnPrompt:setAlpha(1)
end
CoD.KillcamHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.RespawnPrompt:completeAnimation()
			f16_arg0.RespawnPrompt:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.RespawnPrompt)
		end,
	},
	Killcam = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.RespawnPrompt:completeAnimation()
			f17_arg0.RespawnPrompt:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.RespawnPrompt)
		end,
	},
	FinalKillcam = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.RespawnPrompt:completeAnimation()
			f18_arg0.RespawnPrompt:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.RespawnPrompt)
		end,
	},
	RoundEndingKillcam = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.RespawnPrompt:completeAnimation()
			f19_arg0.RespawnPrompt:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.RespawnPrompt)
		end,
	},
	PlayOfTheMatch = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.RespawnPrompt:completeAnimation()
			f20_arg0.RespawnPrompt:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.RespawnPrompt)
		end,
	},
	NemesisKillcam = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.RespawnPrompt:completeAnimation()
			f21_arg0.RespawnPrompt:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.RespawnPrompt)
		end,
	},
}
CoD.KillcamHeader.__onClose = function(f22_arg0)
	f22_arg0.RespawnPrompt:close()
	f22_arg0.KilledByWeapon:close()
end
