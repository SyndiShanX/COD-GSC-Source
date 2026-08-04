require("ui/uieditor/widgets/callingcards/callingcards_asset_zombies_astronaut")
CoD.callingcards_zombies = InheritFrom(LUI.UIElement)
CoD.callingcards_zombies.__defaultWidth = 960
CoD.callingcards_zombies.__defaultHeight = 240
CoD.callingcards_zombies.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_zombies)
	self.id = "CallingCards_zombies"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage("uie_ui_icon_callingcard_zombie_bg"))
	self:addElement(bg)
	self.bg = bg
	local astronaut = CoD.CallingCards_Asset_zombies_astronaut.new(f1_arg0, f1_arg1, 0, 0, 53.5, 445.5, 0, 0, 0, 240)
	self:addElement(astronaut)
	self.astronaut = astronaut
	local smoke = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	smoke:setImage(RegisterImage("uie_ui_icon_callingcard_zombie_smoke"))
	smoke:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(smoke)
	self.smoke = smoke
	local bun2 = LUI.UIImage.new(0, 0, 664, 960, 0, 0, 80, 248)
	bun2:setImage(RegisterImage(@"hash_4839BD840D8C0B97"))
	self:addElement(bun2)
	self.bun2 = bun2
	local lettus = LUI.UIImage.new(0, 0, 664, 960, 0, 0, 52, 260)
	lettus:setImage(RegisterImage(@"hash_2DD89D11E5A6D3AD"))
	self:addElement(lettus)
	self.lettus = lettus
	local cheese = LUI.UIImage.new(0, 0, 664, 960, 0, 0, 32, 240)
	cheese:setImage(RegisterImage("uie_ui_icon_callingcard_zombie_cheese"))
	self:addElement(cheese)
	self.cheese = cheese
	local tomato = LUI.UIImage.new(0, 0, 656.5, 888.5, 0, 0, 48, 192)
	tomato:setImage(RegisterImage("uie_ui_icon_callingcard_zombie_tomato"))
	self:addElement(tomato)
	self.tomato = tomato
	local burger = LUI.UIImage.new(0, 0, 690.5, 922.5, 0, 0, 6, 126)
	burger:setImage(RegisterImage("uie_ui_icon_callingcard_zombie_burger"))
	self:addElement(burger)
	self.burger = burger
	local bun1 = LUI.UIImage.new(0, 0, 656.5, 888.5, 0, 0, 0, 80)
	bun1:setImage(RegisterImage(@"hash_4839BE840D8C0D4A"))
	self:addElement(bun1)
	self.bun1 = bun1
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_zombies.__resetProperties = function(f2_arg0)
	f2_arg0.astronaut:completeAnimation()
	f2_arg0.bun1:completeAnimation()
	f2_arg0.burger:completeAnimation()
	f2_arg0.tomato:completeAnimation()
	f2_arg0.cheese:completeAnimation()
	f2_arg0.lettus:completeAnimation()
	f2_arg0.bun2:completeAnimation()
	f2_arg0.astronaut:setLeftRight(0, 0, 53.5, 445.5)
	f2_arg0.bun1:setTopBottom(0, 0, 0, 80)
	f2_arg0.burger:setTopBottom(0, 0, 6, 126)
	f2_arg0.tomato:setTopBottom(0, 0, 48, 192)
	f2_arg0.cheese:setTopBottom(0, 0, 32, 240)
	f2_arg0.lettus:setTopBottom(0, 0, 52, 260)
	f2_arg0.bun2:setTopBottom(0, 0, 80, 248)
end
CoD.callingcards_zombies.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(7)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setLeftRight(0, 0, 53.5, 445.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.astronaut:playClip("DefaultClip")
				f3_arg0.astronaut:beginAnimation(1500)
				f3_arg0.astronaut:setLeftRight(0, 0, 28.5, 420.5)
				f3_arg0.astronaut:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.astronaut:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.astronaut:completeAnimation()
			f3_arg0.astronaut:setLeftRight(0, 0, 53.5, 445.5)
			f3_local0(f3_arg0.astronaut)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1600, Enum[@"luitween"][@"luitween_ease_out"])
					f8_arg0:setTopBottom(0, 0, 80, 248)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bun2:beginAnimation(1400, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.bun2:setTopBottom(0, 0, 130, 298)
				f3_arg0.bun2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bun2:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.bun2:completeAnimation()
			f3_arg0.bun2:setTopBottom(0, 0, 80, 248)
			f3_local1(f3_arg0.bun2)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1400, Enum[@"luitween"][@"luitween_ease_out"])
					f10_arg0:setTopBottom(0, 0, 52, 260)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.lettus:beginAnimation(1600, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.lettus:setTopBottom(0, 0, 104, 312)
				f3_arg0.lettus:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lettus:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.lettus:completeAnimation()
			f3_arg0.lettus:setTopBottom(0, 0, 52, 260)
			f3_local2(f3_arg0.lettus)
			local f3_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(1200, Enum[@"luitween"][@"luitween_ease_out"])
					f12_arg0:setTopBottom(0, 0, 32, 240)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.cheese:beginAnimation(1800, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.cheese:setTopBottom(0, 0, 57, 265)
				f3_arg0.cheese:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cheese:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.cheese:completeAnimation()
			f3_arg0.cheese:setTopBottom(0, 0, 32, 240)
			f3_local3(f3_arg0.cheese)
			local f3_local4 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(1600, Enum[@"luitween"][@"luitween_ease_out"])
					f14_arg0:setTopBottom(0, 0, 48, 192)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.tomato:beginAnimation(1400, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.tomato:setTopBottom(0, 0, 28, 172)
				f3_arg0.tomato:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.tomato:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.tomato:completeAnimation()
			f3_arg0.tomato:setTopBottom(0, 0, 48, 192)
			f3_local4(f3_arg0.tomato)
			local f3_local5 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(1800, Enum[@"luitween"][@"luitween_ease_out"])
					f16_arg0:setTopBottom(0, 0, 6, 126)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.burger:beginAnimation(1200, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.burger:setTopBottom(0, 0, -24, 96)
				f3_arg0.burger:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.burger:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f3_arg0.burger:completeAnimation()
			f3_arg0.burger:setTopBottom(0, 0, 6, 126)
			f3_local5(f3_arg0.burger)
			local f3_local6 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_out"])
					f18_arg0:setTopBottom(0, 0, 0, 80)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.bun1:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.bun1:setTopBottom(0, 0, -42, 38)
				f3_arg0.bun1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bun1:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.bun1:completeAnimation()
			f3_arg0.bun1:setTopBottom(0, 0, 0, 80)
			f3_local6(f3_arg0.bun1)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_zombies.__onClose = function(f19_arg0)
	f19_arg0.astronaut:close()
end
