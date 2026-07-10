require("x64:f9a084583eafff2")
require("x64:5cacb2759b30b85")
require("x64:7f38bcc06e29100")
CoD[0xC823B1D75860E03] = InheritFrom(LUI.UIElement)
CoD[0xC823B1D75860E03].__defaultWidth = 960
CoD[0xC823B1D75860E03].__defaultHeight = 240
CoD[0xC823B1D75860E03].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xC823B1D75860E03])
	self.id = "ui_icon_callingcards_assassin"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0x7BF15DB5C38AE19))
	self:addElement(background)
	self.background = background
	local fastlines = CoD.ui_icon_callingcards_assassin_fastlines.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(fastlines)
	self.fastlines = fastlines
	local bentarm = CoD.ui_icon_callingcards_assassin_victim.new(f1_arg0, f1_arg1, 0, 0, 0, 384, 0, 0, 8, 504)
	self:addElement(bentarm)
	self.bentarm = bentarm
	local hand = CoD.ui_icon_callingcards_assassin_attackergroup.new(f1_arg0, f1_arg1, 0, 0, 227.5, 1196.5, 0, 0, 0, 312)
	self:addElement(hand)
	self.hand = hand
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0xC823B1D75860E03].__resetProperties = function(f2_arg0)
	f2_arg0.hand:completeAnimation()
	f2_arg0.bentarm:completeAnimation()
	f2_arg0.fastlines:completeAnimation()
	f2_arg0.hand:setLeftRight(0, 0, 227.5, 1196.5)
	f2_arg0.bentarm:setLeftRight(0, 0, 0, 384)
end
CoD[0xC823B1D75860E03].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.fastlines:completeAnimation()
			f3_arg0.fastlines:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.fastlines)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setLeftRight(0, 0, -74, 310)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.bentarm:playClip("DefaultClip")
				f3_arg0.bentarm:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.bentarm:setLeftRight(0, 0, -22.5, 361.5)
				f3_arg0.bentarm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bentarm:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bentarm:completeAnimation()
			f3_arg0.bentarm:setLeftRight(0, 0, -74, 310)
			f3_local0(f3_arg0.bentarm)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f8_arg0:setLeftRight(0, 0, 202, 1171)
					f8_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.hand:playClip("DefaultClip")
				f3_arg0.hand:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.hand:setLeftRight(0, 0, 118, 1087)
				f3_arg0.hand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hand:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.hand:completeAnimation()
			f3_arg0.hand:setLeftRight(0, 0, 202, 1171)
			f3_local1(f3_arg0.hand)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0xC823B1D75860E03].__onClose = function(f10_arg0)
	f10_arg0.fastlines:close()
	f10_arg0.bentarm:close()
	f10_arg0.hand:close()
end
