require("x64:c8f44477e40f994")
require("x64:cbc3f2d1c9436dd")
CoD[@"hash_4BD13AC1448D9700"] = InheritFrom(LUI.UIElement)
CoD[@"hash_4BD13AC1448D9700"].__defaultWidth = 960
CoD[@"hash_4BD13AC1448D9700"].__defaultHeight = 240
CoD[@"hash_4BD13AC1448D9700"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_4BD13AC1448D9700"])
	self.id = "CallingCards_Asset_vilains"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = CoD.CallingCards_Asset_vilains_sky.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(bg)
	self.bg = bg
	local bgplanes = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 168)
	bgplanes:setImage(RegisterImage(@"hash_3C327825904C9BE7"))
	self:addElement(bgplanes)
	self.bgplanes = bgplanes
	local frontplane = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 72, 240)
	frontplane:setImage(RegisterImage(@"hash_69D600B6992FF0F4"))
	self:addElement(frontplane)
	self.frontplane = frontplane
	local victim = LUI.UIImage.new(0, 0, 194.5, 346.5, 0, 0, 72, 256)
	victim:setImage(RegisterImage(@"hash_777FCFF7F5E8EBBB"))
	self:addElement(victim)
	self.victim = victim
	local vilain = LUI.UIImage.new(0, 0, 513, 969, 0, 0, -8, 272)
	vilain:setImage(RegisterImage(@"hash_E8DFE06491652E0"))
	self:addElement(vilain)
	self.vilain = vilain
	local flames = CoD.CallingCards_Asset_vilains_fire.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 72, 240)
	self:addElement(flames)
	self.flames = flames
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_4BD13AC1448D9700"].__resetProperties = function(f2_arg0)
	f2_arg0.flames:completeAnimation()
	f2_arg0.bg:completeAnimation()
	f2_arg0.bgplanes:completeAnimation()
	f2_arg0.frontplane:completeAnimation()
	f2_arg0.victim:completeAnimation()
	f2_arg0.vilain:completeAnimation()
	f2_arg0.bgplanes:setLeftRight(0, 0, 0, 960)
	f2_arg0.frontplane:setTopBottom(0, 0, 72, 240)
	f2_arg0.victim:setLeftRight(0, 0, 194.5, 346.5)
	f2_arg0.victim:setTopBottom(0, 0, 72, 256)
	f2_arg0.vilain:setLeftRight(0, 0, 513, 969)
	f2_arg0.vilain:setTopBottom(0, 0, -8, 272)
end
CoD[@"hash_4BD13AC1448D9700"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(6)
			f3_arg0.bg:completeAnimation()
			f3_arg0.bg:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.bg)
			local f3_local0 = function(f4_arg0)
				f3_arg0.bgplanes:beginAnimation(3000)
				f3_arg0.bgplanes:setLeftRight(0, 0, 960, 1920)
				f3_arg0.bgplanes:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bgplanes:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.bgplanes:completeAnimation()
			f3_arg0.bgplanes:setLeftRight(0, 0, -960, 0)
			f3_local0(f3_arg0.bgplanes)
			local f3_local1 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f6_arg0:setTopBottom(0, 0, 72, 240)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.frontplane:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.frontplane:setTopBottom(0, 0, 82.5, 250.5)
				f3_arg0.frontplane:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.frontplane:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.frontplane:completeAnimation()
			f3_arg0.frontplane:setTopBottom(0, 0, 72, 240)
			f3_local1(f3_arg0.frontplane)
			local f3_local2 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_out"])
					f8_arg0:setLeftRight(0, 0, 194.5, 346.5)
					f8_arg0:setTopBottom(0, 0, 72, 256)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.victim:beginAnimation(1000, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.victim:setLeftRight(0, 0, 235, 387)
				f3_arg0.victim:setTopBottom(0, 0, 82, 266)
				f3_arg0.victim:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.victim:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.victim:completeAnimation()
			f3_arg0.victim:setLeftRight(0, 0, 194.5, 346.5)
			f3_arg0.victim:setTopBottom(0, 0, 72, 256)
			f3_local2(f3_arg0.victim)
			local f3_local3 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_out"])
					f10_arg0:setLeftRight(0, 0, 513, 969)
					f10_arg0:setTopBottom(0, 0, -8, 272)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.vilain:beginAnimation(2000, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.vilain:setLeftRight(0, 0, 456.5, 912.5)
				f3_arg0.vilain:setTopBottom(0, 0, 5.5, 285.5)
				f3_arg0.vilain:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.vilain:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.vilain:completeAnimation()
			f3_arg0.vilain:setLeftRight(0, 0, 513, 969)
			f3_arg0.vilain:setTopBottom(0, 0, -8, 272)
			f3_local3(f3_arg0.vilain)
			f3_arg0.flames:completeAnimation()
			f3_arg0.flames:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.flames)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_4BD13AC1448D9700"].__onClose = function(f11_arg0)
	f11_arg0.bg:close()
	f11_arg0.flames:close()
end
