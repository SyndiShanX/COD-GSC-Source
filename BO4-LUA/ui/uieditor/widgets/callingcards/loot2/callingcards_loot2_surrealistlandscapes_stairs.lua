require("x64:c8af151fdab05a0")
CoD.callingcards_loot2_surrealistlandscapes_stairs = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_surrealistlandscapes_stairs.__defaultWidth = 512
CoD.callingcards_loot2_surrealistlandscapes_stairs.__defaultHeight = 240
CoD.callingcards_loot2_surrealistlandscapes_stairs.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_surrealistlandscapes_stairs)
	self.id = "callingcards_loot2_surrealistlandscapes_stairs"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local stairs = LUI.UIImage.new(0, 0, 0, 512, 0, 0, 0, 240)
	stairs:setImage(RegisterImage(0xE4270E32F580058))
	self:addElement(stairs)
	self.stairs = stairs
	local ball = CoD.callingcards_loot2_surrealistlandscapes_ball.new(f1_arg0, f1_arg1, 0, 0, 208, 256, 0, 0, 76, 124)
	self:addElement(ball)
	self.ball = ball
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_loot2_surrealistlandscapes_stairs.__resetProperties = function(f2_arg0)
	f2_arg0.ball:completeAnimation()
	f2_arg0.ball:setLeftRight(0, 0, 208, 256)
	f2_arg0.ball:setTopBottom(0, 0, 76, 124)
end
CoD.callingcards_loot2_surrealistlandscapes_stairs.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setTopBottom(0, 0, 76, 124)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.ball:playClip("DefaultClip")
				f3_arg0.ball:beginAnimation(1500, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.ball:setTopBottom(0, 0, 32, 80)
				f3_arg0.ball:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ball:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ball:completeAnimation()
			f3_arg0.ball:setLeftRight(0, 0, 208, 256)
			f3_arg0.ball:setTopBottom(0, 0, 76, 124)
			f3_local0(f3_arg0.ball)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_loot2_surrealistlandscapes_stairs.__onClose = function(f7_arg0)
	f7_arg0.ball:close()
end
