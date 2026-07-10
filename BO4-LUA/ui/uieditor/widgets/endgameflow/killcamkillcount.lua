CoD.KillcamKillCount = InheritFrom(LUI.UIElement)
CoD.KillcamKillCount.__defaultWidth = 120
CoD.KillcamKillCount.__defaultHeight = 120
CoD.KillcamKillCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KillcamKillCount)
	self.id = "KillcamKillCount"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KillCountBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(KillCountBacking)
	self.KillCountBacking = KillCountBacking
	local Numbers = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	Numbers:setRGB(0.06, 0.06, 0.06)
	Numbers:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4323579690CF719"))
	Numbers:setTTF("ttmussels_demibold")
	Numbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Numbers:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(Numbers)
	self.Numbers = Numbers
	local KillCountBit = LUI.UIImage.new(0, 0, 2, 4, 0, 0, 2, 4)
	KillCountBit:setRGB(0.06, 0.06, 0.06)
	self:addElement(KillCountBit)
	self.KillCountBit = KillCountBit
	local KillCountBit2 = LUI.UIImage.new(0, 0, 116, 118, 0, 0, 2, 4)
	KillCountBit2:setRGB(0.06, 0.06, 0.06)
	self:addElement(KillCountBit2)
	self.KillCountBit2 = KillCountBit2
	local KillCountBit3 = LUI.UIImage.new(0, 0, 116, 118, 0, 0, 116, 118)
	KillCountBit3:setRGB(0.06, 0.06, 0.06)
	self:addElement(KillCountBit3)
	self.KillCountBit3 = KillCountBit3
	local KillCountBit4 = LUI.UIImage.new(0, 0, 2, 4, 0, 0, 116, 118)
	KillCountBit4:setRGB(0.06, 0.06, 0.06)
	self:addElement(KillCountBit4)
	self.KillCountBit4 = KillCountBit4
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamKillCount.__resetProperties = function(f2_arg0)
	f2_arg0.Numbers:completeAnimation()
	f2_arg0.Numbers:setRGB(0.06, 0.06, 0.06)
	f2_arg0.Numbers:setAlpha(1)
end
CoD.KillcamKillCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Start = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.Numbers:beginAnimation(260)
				f4_arg0.Numbers:setAlpha(1)
				f4_arg0.Numbers:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Numbers:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.Numbers:completeAnimation()
			f4_arg0.Numbers:setAlpha(0)
			f4_local0(f4_arg0.Numbers)
		end,
	},
	WinTime = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Numbers:completeAnimation()
			f6_arg0.Numbers:setRGB(0.05, 1, 0)
			f6_arg0.Numbers:setAlpha(0.7)
			f6_arg0.clipFinished(f6_arg0.Numbers)
		end,
	},
	LossTime = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Numbers:completeAnimation()
			f7_arg0.Numbers:setRGB(1, 0.01, 0)
			f7_arg0.Numbers:setAlpha(0.7)
			f7_arg0.clipFinished(f7_arg0.Numbers)
		end,
	},
}
