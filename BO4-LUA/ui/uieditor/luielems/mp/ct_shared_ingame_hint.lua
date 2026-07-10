CoD.ct_shared_ingame_hint = InheritFrom(CoD.Menu)
CoD.ct_shared_ingame_hint.__stateMap = {
	"DefaultState",
	"FadeOut",
	"green",
	"grey",
	"red",
	"green_fadeout",
	"grey_fadeout",
	"red_fadeout",
	"red_paused",
	"red_paused_fadeout",
}
LUI.createMenu.ct_shared_ingame_hint = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ct_shared_ingame_hint", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ct_shared_ingame_hint)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local InGameHint = LUI.UIText.new(0.5, 0.5, -600, 600, 0.5, 0.5, 185, 200)
	InGameHint:setAlpha(0.95)
	InGameHint:setTTF("ttmussels_regular")
	InGameHint:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	InGameHint:setLetterSpacing(3)
	InGameHint:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	InGameHint:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	InGameHint:setBackingType(2)
	InGameHint:setBackingAlpha(0.95)
	InGameHint:setBackingXPadding(50)
	InGameHint:setBackingYPadding(10)
	InGameHint:setBackingImage(RegisterImage(@"uie_ui_hud_core_match_begins_banner"))
	InGameHint:linkToElementModel(self, "inGameHint", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			InGameHint:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(InGameHint)
	self.InGameHint = InGameHint
	local fakePrompt = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, 265, 300)
	fakePrompt:setAlpha(0)
	fakePrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3D9839F8FF9FDC54"))
	fakePrompt:setTTF("default")
	fakePrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	fakePrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(fakePrompt)
	self.fakePrompt = fakePrompt
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
CoD.ct_shared_ingame_hint.__resetProperties = function(f3_arg0)
	f3_arg0.InGameHint:completeAnimation()
	f3_arg0.fakePrompt:completeAnimation()
	f3_arg0.InGameHint:setLeftRight(0.5, 0.5, -600, 600)
	f3_arg0.InGameHint:setTopBottom(0.5, 0.5, 185, 200)
	f3_arg0.InGameHint:setRGB(1, 1, 1)
	f3_arg0.InGameHint:setAlpha(0.95)
	f3_arg0.InGameHint:setScale(1, 1)
	f3_arg0.InGameHint:setBackingColor(1, 1, 1)
	f3_arg0.fakePrompt:setAlpha(0)
end
CoD.ct_shared_ingame_hint.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.InGameHint:beginAnimation(1000, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f4_arg0.InGameHint:setAlpha(1)
				f4_arg0.InGameHint:setScale(0.9, 0.9)
				f4_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.InGameHint:completeAnimation()
			f4_arg0.InGameHint:setAlpha(0)
			f4_arg0.InGameHint:setScale(0.7, 0.7)
			f4_local0(f4_arg0.InGameHint)
		end,
	},
	FadeOut = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.InGameHint:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
				f6_arg0.InGameHint:setAlpha(0)
				f6_arg0.InGameHint:setScale(0.5, 0.5)
				f6_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.InGameHint:completeAnimation()
			f6_arg0.InGameHint:setAlpha(1)
			f6_arg0.InGameHint:setScale(0.9, 0.9)
			f6_local0(f6_arg0.InGameHint)
		end,
	},
	green = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.InGameHint:beginAnimation(1000, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f8_arg0.InGameHint:setAlpha(1)
				f8_arg0.InGameHint:setScale(1.35, 1.35)
				f8_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.InGameHint:completeAnimation()
			f8_arg0.InGameHint:setAlpha(0)
			f8_arg0.InGameHint:setScale(0.7, 0.7)
			f8_local0(f8_arg0.InGameHint)
		end,
	},
	grey = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.InGameHint:beginAnimation(1000, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f10_arg0.InGameHint:setAlpha(1)
				f10_arg0.InGameHint:setScale(1.2, 1.2)
				f10_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.InGameHint:completeAnimation()
			f10_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f10_arg0.InGameHint:setAlpha(0)
			f10_arg0.InGameHint:setScale(0.7, 0.7)
			f10_arg0.InGameHint:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
			f10_local0(f10_arg0.InGameHint)
		end,
		prompted = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.InGameHint:beginAnimation(1000)
				f12_arg0.InGameHint:setAlpha(1)
				f12_arg0.InGameHint:setScale(1.2, 1.2)
				f12_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.InGameHint:completeAnimation()
			f12_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f12_arg0.InGameHint:setAlpha(0)
			f12_arg0.InGameHint:setScale(0.7, 0.7)
			f12_arg0.InGameHint:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
			f12_local0(f12_arg0.InGameHint)
			f12_arg0.fakePrompt:completeAnimation()
			f12_arg0.fakePrompt:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.fakePrompt)
		end,
	},
	red = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.InGameHint:beginAnimation(1000, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f14_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Muted.r, ColorSet.EnemyOrange_Muted.g, ColorSet.EnemyOrange_Muted.b)
				f14_arg0.InGameHint:setAlpha(1)
				f14_arg0.InGameHint:setScale(1.5, 1.5)
				f14_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.InGameHint:completeAnimation()
			f14_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f14_arg0.InGameHint:setAlpha(0)
			f14_arg0.InGameHint:setScale(0.7, 0.7)
			f14_arg0.InGameHint:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
			f14_local0(f14_arg0.InGameHint)
		end,
	},
	green_fadeout = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.InGameHint:beginAnimation(500)
				f16_arg0.InGameHint:setAlpha(0)
				f16_arg0.InGameHint:setScale(1, 1)
				f16_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.InGameHint:completeAnimation()
			f16_arg0.InGameHint:setAlpha(1)
			f16_arg0.InGameHint:setScale(1.35, 1.35)
			f16_local0(f16_arg0.InGameHint)
		end,
	},
	grey_fadeout = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.InGameHint:beginAnimation(500)
				f18_arg0.InGameHint:setAlpha(0)
				f18_arg0.InGameHint:setScale(1, 1)
				f18_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.InGameHint:completeAnimation()
			f18_arg0.InGameHint:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f18_arg0.InGameHint:setAlpha(1)
			f18_arg0.InGameHint:setScale(1.2, 1.2)
			f18_local0(f18_arg0.InGameHint)
		end,
	},
	red_fadeout = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.InGameHint:beginAnimation(500)
				f20_arg0.InGameHint:setAlpha(0)
				f20_arg0.InGameHint:setScale(1, 1)
				f20_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.InGameHint:completeAnimation()
			f20_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Muted.r, ColorSet.EnemyOrange_Muted.g, ColorSet.EnemyOrange_Muted.b)
			f20_arg0.InGameHint:setAlpha(1)
			f20_arg0.InGameHint:setScale(1.2, 1.2)
			f20_local0(f20_arg0.InGameHint)
		end,
	},
	red_paused = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.InGameHint:beginAnimation(1000, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
				f22_arg0.InGameHint:setTopBottom(0.5, 0.5, 105, 135)
				f22_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Muted.r, ColorSet.EnemyOrange_Muted.g, ColorSet.EnemyOrange_Muted.b)
				f22_arg0.InGameHint:setAlpha(1)
				f22_arg0.InGameHint:setScale(1.3, 1.3)
				f22_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.InGameHint:completeAnimation()
			f22_arg0.InGameHint:setLeftRight(0.5, 0.5, -960, 960)
			f22_arg0.InGameHint:setTopBottom(0.5, 0.5, 112.5, 127.5)
			f22_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
			f22_arg0.InGameHint:setAlpha(0)
			f22_arg0.InGameHint:setScale(0.7, 0.7)
			f22_arg0.InGameHint:setBackingColor(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
			f22_local0(f22_arg0.InGameHint)
		end,
	},
	red_paused_fadeout = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.InGameHint:beginAnimation(500)
				f24_arg0.InGameHint:setAlpha(0)
				f24_arg0.InGameHint:setScale(1, 1)
				f24_arg0.InGameHint:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.InGameHint:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.InGameHint:completeAnimation()
			f24_arg0.InGameHint:setLeftRight(0.5, 0.5, -960, 960)
			f24_arg0.InGameHint:setTopBottom(0.5, 0.5, 105, 135)
			f24_arg0.InGameHint:setRGB(ColorSet.EnemyOrange_Muted.r, ColorSet.EnemyOrange_Muted.g, ColorSet.EnemyOrange_Muted.b)
			f24_arg0.InGameHint:setAlpha(1)
			f24_arg0.InGameHint:setScale(1.3, 1.3)
			f24_local0(f24_arg0.InGameHint)
		end,
	},
}
CoD.ct_shared_ingame_hint.__onClose = function(f26_arg0)
	f26_arg0.InGameHint:close()
end
