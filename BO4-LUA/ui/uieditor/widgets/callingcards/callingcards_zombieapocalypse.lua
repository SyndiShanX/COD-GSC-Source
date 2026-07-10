CoD[0x1C8E42E011D260E] = InheritFrom(LUI.UIElement)
CoD[0x1C8E42E011D260E].__defaultWidth = 960
CoD[0x1C8E42E011D260E].__defaultHeight = 240
CoD[0x1C8E42E011D260E].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x1C8E42E011D260E])
	self.id = "CallingCards_zombieapocalypse"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0xD6E6311DEC75E89))
	self:addElement(bg)
	self.bg = bg
	local zombie1 = LUI.UIImage.new(0, 0, 0, 312, 0, 0, 0, 240)
	zombie1:setImage(RegisterImage(0x7D73D97F0A020EF))
	self:addElement(zombie1)
	self.zombie1 = zombie1
	local man1 = LUI.UIImage.new(0, 0, 213, 629, 0, 0, 24, 240)
	man1:setImage(RegisterImage(0x6A21FA8B9005F90))
	self:addElement(man1)
	self.man1 = man1
	local man2 = LUI.UIImage.new(0, 0, 451, 787, 0, 0, -15, 265)
	man2:setImage(RegisterImage(0x6A222A8B90064A9))
	self:addElement(man2)
	self.man2 = man2
	local headblood = LUI.UIImage.new(0, 0, 624, 960, 0, 0, -35, 245)
	headblood:setImage(RegisterImage(0xBE0F9F891C59FB4))
	self:addElement(headblood)
	self.headblood = headblood
	local head = LUI.UIImage.new(0, 0, 811, 931, 0, 0, -15, 105)
	head:setImage(RegisterImage(0x9AA19C587127898))
	self:addElement(head)
	self.head = head
	local armblood = LUI.UIImage.new(0, 0, 563.5, 979.5, 0, 0, 86, 302)
	armblood:setImage(RegisterImage(0xEA1798592DF7F4E))
	self:addElement(armblood)
	self.armblood = armblood
	local zombiearm = LUI.UIImage.new(0, 0, 723.5, 979.5, 0, 0, 145, 265)
	zombiearm:setImage(RegisterImage(0x354B65D9AFC3DA0))
	self:addElement(zombiearm)
	self.zombiearm = zombiearm
	local smoke = LUI.UIImage.new(0, 0, 144, 960, 0, 0, 105, 241)
	smoke:setImage(RegisterImage(0x88002FBFB6ADBB7))
	self:addElement(smoke)
	self.smoke = smoke
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x1C8E42E011D260E].__resetProperties = function(f2_arg0)
	f2_arg0.zombie1:completeAnimation()
	f2_arg0.man1:completeAnimation()
	f2_arg0.man2:completeAnimation()
	f2_arg0.head:completeAnimation()
	f2_arg0.zombiearm:completeAnimation()
	f2_arg0.smoke:completeAnimation()
	f2_arg0.armblood:completeAnimation()
	f2_arg0.headblood:completeAnimation()
	f2_arg0.zombie1:setLeftRight(0, 0, 0, 312)
	f2_arg0.man1:setLeftRight(0, 0, 213, 629)
	f2_arg0.man2:setLeftRight(0, 0, 451, 787)
	f2_arg0.man2:setTopBottom(0, 0, -15, 265)
	f2_arg0.head:setLeftRight(0, 0, 811, 931)
	f2_arg0.head:setTopBottom(0, 0, -15, 105)
	f2_arg0.zombiearm:setLeftRight(0, 0, 723.5, 979.5)
	f2_arg0.smoke:setLeftRight(0, 0, 144, 960)
	f2_arg0.armblood:setLeftRight(0, 0, 563.5, 979.5)
	f2_arg0.headblood:setLeftRight(0, 0, 624, 960)
end
CoD[0x1C8E42E011D260E].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(8)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f5_arg0:setLeftRight(0, 0, 0, 312)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.zombie1:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.zombie1:setLeftRight(0, 0, -67, 245)
				f3_arg0.zombie1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.zombie1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.zombie1:completeAnimation()
			f3_arg0.zombie1:setLeftRight(0, 0, 0, 312)
			f3_local0(f3_arg0.zombie1)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f7_arg0:setLeftRight(0, 0, 213, 629)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.man1:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.man1:setLeftRight(0, 0, 192, 608)
				f3_arg0.man1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.man1:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.man1:completeAnimation()
			f3_arg0.man1:setLeftRight(0, 0, 213, 629)
			f3_local1(f3_arg0.man1)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f9_arg0:setLeftRight(0, 0, 451, 787)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.man2:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.man2:setLeftRight(0, 0, 475, 811)
				f3_arg0.man2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.man2:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.man2:completeAnimation()
			f3_arg0.man2:setLeftRight(0, 0, 451, 787)
			f3_arg0.man2:setTopBottom(0, 0, -20, 260)
			f3_local2(f3_arg0.man2)
			local f3_local3 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f11_arg0:setLeftRight(0, 0, 624, 960)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.headblood:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.headblood:setLeftRight(0, 0, 659, 995)
				f3_arg0.headblood:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.headblood:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.headblood:completeAnimation()
			f3_arg0.headblood:setLeftRight(0, 0, 624, 960)
			f3_local3(f3_arg0.headblood)
			local f3_local4 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f13_arg0:setLeftRight(0, 0, 811, 931)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.head:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.head:setLeftRight(0, 0, 886, 1006)
				f3_arg0.head:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.head:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.head:completeAnimation()
			f3_arg0.head:setLeftRight(0, 0, 811, 931)
			f3_arg0.head:setTopBottom(0, 0, -15, 105)
			f3_local4(f3_arg0.head)
			local f3_local5 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f15_arg0:setLeftRight(0, 0, 563.5, 979.5)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.armblood:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.armblood:setLeftRight(0, 0, 635, 1051)
				f3_arg0.armblood:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.armblood:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.armblood:completeAnimation()
			f3_arg0.armblood:setLeftRight(0, 0, 563.5, 979.5)
			f3_local5(f3_arg0.armblood)
			local f3_local6 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f17_arg0:setLeftRight(0, 0, 718.5, 974.5)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.zombiearm:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.zombiearm:setLeftRight(0, 0, 768.5, 1024.5)
				f3_arg0.zombiearm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.zombiearm:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f3_arg0.zombiearm:completeAnimation()
			f3_arg0.zombiearm:setLeftRight(0, 0, 718.5, 974.5)
			f3_local6(f3_arg0.zombiearm)
			local f3_local7 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f19_arg0:setLeftRight(0, 0, 0, 816)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.smoke:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.smoke:setLeftRight(0, 0, 44, 860)
				f3_arg0.smoke:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.smoke:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f3_arg0.smoke:completeAnimation()
			f3_arg0.smoke:setLeftRight(0, 0, 0, 816)
			f3_local7(f3_arg0.smoke)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
