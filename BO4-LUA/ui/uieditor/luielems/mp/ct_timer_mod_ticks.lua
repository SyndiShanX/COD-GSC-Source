CoD.ct_timer_mod_ticks = InheritFrom(CoD.Menu)
CoD.ct_timer_mod_ticks.__stateMap = {
	"DefaultState",
	"plus",
	"minus",
	"plus_destroyedobj",
	"plus_dogkill",
	"plus_killedwarlord",
	"plus_multikill",
}
LUI.createMenu.ct_timer_mod_ticks = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_timer_mod_ticks", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_timer_mod_ticks)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local modTimeBonus = LUI.UIText.new(0.5, 0.5, 90, 809, 0.5, 0.5, -290, -210)
	modTimeBonus:setRGB(0.13, 0.87, 0.94)
	modTimeBonus:setAlpha(0)
	modTimeBonus:setScale(0.8, 0.8)
	modTimeBonus:setTTF("default")
	modTimeBonus:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	modTimeBonus:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	modTimeBonus:linkToElementModel(self, "timeMod", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			modTimeBonus:setText(Engine[0xF9F1239CFD921FE](CoD.CTUtility.LocalizeTimeBonus(0x9F904FB34DE1ADD, f2_local0)))
		end
	end)
	self:addElement(modTimeBonus)
	self.modTimeBonus = modTimeBonus
	local TimeBonusDogKill = LUI.UIText.new(0.5, 0.5, 10, 729, 0.5, 0.5, -440, -360)
	TimeBonusDogKill:setRGB(0.13, 0.87, 0.94)
	TimeBonusDogKill:setAlpha(0)
	TimeBonusDogKill:setScale(0.8, 0.8)
	TimeBonusDogKill:setTTF("default")
	TimeBonusDogKill:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimeBonusDogKill:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TimeBonusDogKill:linkToElementModel(self, "timeMod", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TimeBonusDogKill:setText(Engine[0xF9F1239CFD921FE](CoD.CTUtility.LocalizeTimeBonus(0x92D3042676927B4, f3_local0)))
		end
	end)
	self:addElement(TimeBonusDogKill)
	self.TimeBonusDogKill = TimeBonusDogKill
	local TimeBonusDestroyedObj = LUI.UIText.new(0.5, 0.5, 10, 729, 0.5, 0.5, -440, -360)
	TimeBonusDestroyedObj:setRGB(0.13, 0.87, 0.94)
	TimeBonusDestroyedObj:setAlpha(0)
	TimeBonusDestroyedObj:setScale(0.8, 0.8)
	TimeBonusDestroyedObj:setTTF("default")
	TimeBonusDestroyedObj:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimeBonusDestroyedObj:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TimeBonusDestroyedObj:linkToElementModel(self, "timeMod", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TimeBonusDestroyedObj:setText(Engine[0xF9F1239CFD921FE](CoD.CTUtility.LocalizeTimeBonus(0x99407BFA9F9AA1E, f4_local0)))
		end
	end)
	self:addElement(TimeBonusDestroyedObj)
	self.TimeBonusDestroyedObj = TimeBonusDestroyedObj
	local TimeBonusKilledWarlord = LUI.UIText.new(0.5, 0.5, 10, 729, 0.5, 0.5, -440, -360)
	TimeBonusKilledWarlord:setRGB(0.13, 0.87, 0.94)
	TimeBonusKilledWarlord:setAlpha(0)
	TimeBonusKilledWarlord:setScale(0.8, 0.8)
	TimeBonusKilledWarlord:setTTF("default")
	TimeBonusKilledWarlord:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimeBonusKilledWarlord:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TimeBonusKilledWarlord:linkToElementModel(self, "timeMod", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TimeBonusKilledWarlord:setText(Engine[0xF9F1239CFD921FE](CoD.CTUtility.LocalizeTimeBonus(0x79BCB8C86A7AA44, f5_local0)))
		end
	end)
	self:addElement(TimeBonusKilledWarlord)
	self.TimeBonusKilledWarlord = TimeBonusKilledWarlord
	local TimeBonusMultiKill = LUI.UIText.new(0.5, 0.5, 10, 729, 0.5, 0.5, -440, -360)
	TimeBonusMultiKill:setRGB(0.13, 0.87, 0.94)
	TimeBonusMultiKill:setAlpha(0)
	TimeBonusMultiKill:setScale(0.8, 0.8)
	TimeBonusMultiKill:setTTF("default")
	TimeBonusMultiKill:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimeBonusMultiKill:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TimeBonusMultiKill:linkToElementModel(self, "timeMod", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TimeBonusMultiKill:setText(Engine[0xF9F1239CFD921FE](CoD.CTUtility.LocalizeTimeBonus(0xB5D76F3013A39BF, f6_local0)))
		end
	end)
	self:addElement(TimeBonusMultiKill)
	self.TimeBonusMultiKill = TimeBonusMultiKill
	local modTimePenalty = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, -340, -260)
	modTimePenalty:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
	modTimePenalty:setAlpha(0)
	modTimePenalty:setScale(0.8, 0.8)
	modTimePenalty:setTTF("default")
	modTimePenalty:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	modTimePenalty:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	modTimePenalty:linkToElementModel(self, "timeMod", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			modTimePenalty:setText(Engine[0xF9F1239CFD921FE](CoD.CTUtility.LocalizeTimeBonus(0xBB69798EC9E5475, f7_local0)))
		end
	end)
	self:addElement(modTimePenalty)
	self.modTimePenalty = modTimePenalty
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.ct_timer_mod_ticks.__resetProperties = function(f8_arg0)
	f8_arg0.modTimeBonus:completeAnimation()
	f8_arg0.modTimePenalty:completeAnimation()
	f8_arg0.TimeBonusDestroyedObj:completeAnimation()
	f8_arg0.TimeBonusDogKill:completeAnimation()
	f8_arg0.TimeBonusKilledWarlord:completeAnimation()
	f8_arg0.TimeBonusMultiKill:completeAnimation()
	f8_arg0.modTimeBonus:setLeftRight(0.5, 0.5, 90, 809)
	f8_arg0.modTimeBonus:setTopBottom(0.5, 0.5, -290, -210)
	f8_arg0.modTimeBonus:setRGB(0.13, 0.87, 0.94)
	f8_arg0.modTimeBonus:setAlpha(0)
	f8_arg0.modTimePenalty:setLeftRight(0.5, 0.5, -960, 960)
	f8_arg0.modTimePenalty:setTopBottom(0.5, 0.5, -340, -260)
	f8_arg0.modTimePenalty:setAlpha(0)
	f8_arg0.TimeBonusDestroyedObj:setLeftRight(0.5, 0.5, 10, 729)
	f8_arg0.TimeBonusDestroyedObj:setTopBottom(0.5, 0.5, -440, -360)
	f8_arg0.TimeBonusDestroyedObj:setAlpha(0)
	f8_arg0.TimeBonusDogKill:setLeftRight(0.5, 0.5, 10, 729)
	f8_arg0.TimeBonusDogKill:setTopBottom(0.5, 0.5, -440, -360)
	f8_arg0.TimeBonusDogKill:setAlpha(0)
	f8_arg0.TimeBonusKilledWarlord:setLeftRight(0.5, 0.5, 10, 729)
	f8_arg0.TimeBonusKilledWarlord:setTopBottom(0.5, 0.5, -440, -360)
	f8_arg0.TimeBonusKilledWarlord:setAlpha(0)
	f8_arg0.TimeBonusMultiKill:setLeftRight(0.5, 0.5, 10, 729)
	f8_arg0.TimeBonusMultiKill:setTopBottom(0.5, 0.5, -440, -360)
	f8_arg0.TimeBonusMultiKill:setRGB(0.13, 0.87, 0.94)
	f8_arg0.TimeBonusMultiKill:setAlpha(0)
	f8_arg0.TimeBonusMultiKill:setScale(0.8, 0.8)
end
CoD.ct_timer_mod_ticks.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.modTimeBonus:completeAnimation()
			f9_arg0.modTimeBonus:setLeftRight(0.5, 0.5, 90, 809)
			f9_arg0.modTimeBonus:setTopBottom(0.5, 0.5, -290, -210)
			f9_arg0.clipFinished(f9_arg0.modTimeBonus)
			f9_arg0.modTimePenalty:completeAnimation()
			f9_arg0.modTimePenalty:setLeftRight(0.5, 0.5, -960, 960)
			f9_arg0.modTimePenalty:setTopBottom(0.5, 0.5, -340, -260)
			f9_arg0.clipFinished(f9_arg0.modTimePenalty)
		end,
	},
	plus = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(810)
					f12_arg0:setTopBottom(0.5, 0.5, -490, -410)
					f12_arg0:setAlpha(0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.modTimeBonus:beginAnimation(190)
				f10_arg0.modTimeBonus:setAlpha(1)
				f10_arg0.modTimeBonus:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.modTimeBonus:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.modTimeBonus:completeAnimation()
			f10_arg0.modTimeBonus:setLeftRight(0.5, 0.5, 10, 729)
			f10_arg0.modTimeBonus:setTopBottom(0.5, 0.5, -440, -360)
			f10_arg0.modTimeBonus:setRGB(ColorSet.FriendlyBlue_Muted.r, ColorSet.FriendlyBlue_Muted.g, ColorSet.FriendlyBlue_Muted.b)
			f10_arg0.modTimeBonus:setAlpha(0)
			f10_local0(f10_arg0.modTimeBonus)
		end,
	},
	minus = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f16_arg0:setTopBottom(0.5, 0.5, -190, -110)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(810)
					f15_arg0:setTopBottom(0.5, 0.5, -209.77, -129.77)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.modTimePenalty:beginAnimation(190)
				f13_arg0.modTimePenalty:setAlpha(1)
				f13_arg0.modTimePenalty:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.modTimePenalty:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.modTimePenalty:completeAnimation()
			f13_arg0.modTimePenalty:setLeftRight(0.5, 0.5, -960, 960)
			f13_arg0.modTimePenalty:setTopBottom(0.5, 0.5, -340, -260)
			f13_arg0.modTimePenalty:setAlpha(0)
			f13_local0(f13_arg0.modTimePenalty)
		end,
	},
	plus_destroyedobj = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(810)
					f19_arg0:setTopBottom(0.5, 0.5, -490, -410)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.TimeBonusDestroyedObj:beginAnimation(190)
				f17_arg0.TimeBonusDestroyedObj:setAlpha(1)
				f17_arg0.TimeBonusDestroyedObj:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.TimeBonusDestroyedObj:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.TimeBonusDestroyedObj:completeAnimation()
			f17_arg0.TimeBonusDestroyedObj:setLeftRight(0.5, 0.5, 10, 809)
			f17_arg0.TimeBonusDestroyedObj:setTopBottom(0.5, 0.5, -440, -360)
			f17_arg0.TimeBonusDestroyedObj:setAlpha(0)
			f17_local0(f17_arg0.TimeBonusDestroyedObj)
		end,
	},
	plus_dogkill = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(810)
					f22_arg0:setTopBottom(0.5, 0.5, -490, -410)
					f22_arg0:setAlpha(0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.TimeBonusDogKill:beginAnimation(190)
				f20_arg0.TimeBonusDogKill:setTopBottom(0.5, 0.5, -449.5, -369.5)
				f20_arg0.TimeBonusDogKill:setAlpha(1)
				f20_arg0.TimeBonusDogKill:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.TimeBonusDogKill:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.TimeBonusDogKill:completeAnimation()
			f20_arg0.TimeBonusDogKill:setLeftRight(0.5, 0.5, 10, 729)
			f20_arg0.TimeBonusDogKill:setTopBottom(0.5, 0.5, -440, -360)
			f20_arg0.TimeBonusDogKill:setAlpha(0)
			f20_local0(f20_arg0.TimeBonusDogKill)
		end,
	},
	plus_killedwarlord = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(810)
					f25_arg0:setTopBottom(0.5, 0.5, -490, -410)
					f25_arg0:setAlpha(0)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
				end
				f23_arg0.TimeBonusKilledWarlord:beginAnimation(190)
				f23_arg0.TimeBonusKilledWarlord:setTopBottom(0.5, 0.5, -449.5, -369.5)
				f23_arg0.TimeBonusKilledWarlord:setAlpha(1)
				f23_arg0.TimeBonusKilledWarlord:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.TimeBonusKilledWarlord:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f23_arg0.TimeBonusKilledWarlord:completeAnimation()
			f23_arg0.TimeBonusKilledWarlord:setLeftRight(0.5, 0.5, 10, 809)
			f23_arg0.TimeBonusKilledWarlord:setTopBottom(0.5, 0.5, -440, -360)
			f23_arg0.TimeBonusKilledWarlord:setAlpha(0)
			f23_local0(f23_arg0.TimeBonusKilledWarlord)
		end,
	},
	plus_multikill = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(810)
					f28_arg0:setTopBottom(0.5, 0.5, -490, -410)
					f28_arg0:setAlpha(0)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.TimeBonusMultiKill:beginAnimation(190)
				f26_arg0.TimeBonusMultiKill:setTopBottom(0.5, 0.5, -449.5, -369.5)
				f26_arg0.TimeBonusMultiKill:setAlpha(1)
				f26_arg0.TimeBonusMultiKill:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.TimeBonusMultiKill:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.TimeBonusMultiKill:completeAnimation()
			f26_arg0.TimeBonusMultiKill:setLeftRight(0.5, 0.5, 10, 809)
			f26_arg0.TimeBonusMultiKill:setTopBottom(0.5, 0.5, -440, -360)
			f26_arg0.TimeBonusMultiKill:setRGB(ColorSet.PlayerGreen.r, ColorSet.PlayerGreen.g, ColorSet.PlayerGreen.b)
			f26_arg0.TimeBonusMultiKill:setAlpha(0)
			f26_arg0.TimeBonusMultiKill:setScale(0.8, 0.8)
			f26_local0(f26_arg0.TimeBonusMultiKill)
		end,
	},
}
CoD.ct_timer_mod_ticks.__onClose = function(f29_arg0)
	f29_arg0.modTimeBonus:close()
	f29_arg0.TimeBonusDogKill:close()
	f29_arg0.TimeBonusDestroyedObj:close()
	f29_arg0.TimeBonusKilledWarlord:close()
	f29_arg0.TimeBonusMultiKill:close()
	f29_arg0.modTimePenalty:close()
end
