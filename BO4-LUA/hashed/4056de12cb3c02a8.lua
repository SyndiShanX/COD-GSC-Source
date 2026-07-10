require("x64:aa4a875e6d01dd8")
require("x64:4461ca91e78a5d5")
CoD[0x6DF244A87F06B10] = InheritFrom(LUI.UIElement)
CoD[0x6DF244A87F06B10].__defaultWidth = 960
CoD[0x6DF244A87F06B10].__defaultHeight = 240
CoD[0x6DF244A87F06B10].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x6DF244A87F06B10])
	self.id = "ui_icon_callingcards_fairytales"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0x8F5098864EC8D99))
	self:addElement(background)
	self.background = background
	local gret = LUI.UIImage.new(0, 0, 260, 372, 0, 0, 120, 256)
	gret:setImage(RegisterImage(0xEF36F178745B32A))
	self:addElement(gret)
	self.gret = gret
	local hans = LUI.UIImage.new(0, 0, 112, 240, 0, 0, 91, 251)
	hans:setImage(RegisterImage(0xA698AFF80406902))
	self:addElement(hans)
	self.hans = hans
	local arm = CoD.ui_icon_callingcards_fairytales_armgroup.new(f1_arg0, f1_arg1, 0, 0, 792, 802, 0, 0, 96, 106)
	self:addElement(arm)
	self.arm = arm
	local smoke = CoD.ui_icon_callingcards_fairytales_flames.new(f1_arg0, f1_arg1, 0, 0, 792, 822, 0, 0, 91, 121)
	self:addElement(smoke)
	self.smoke = smoke
	local largesmoke = LUI.UIImage.new(0, 0, -211.5, 548.5, 0, 0, -86, 298)
	largesmoke:setImage(RegisterImage(0x657CCC3058DCB02))
	largesmoke:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(largesmoke)
	self.largesmoke = largesmoke
	local largesmoke2 = LUI.UIImage.new(0, 0, 580, 1340, 0, 0, -86, 298)
	largesmoke2:setAlpha(0)
	largesmoke2:setImage(RegisterImage(0x657CCC3058DCB02))
	largesmoke2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(largesmoke2)
	self.largesmoke2 = largesmoke2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x6DF244A87F06B10].__resetProperties = function(f2_arg0)
	f2_arg0.arm:completeAnimation()
	f2_arg0.gret:completeAnimation()
	f2_arg0.hans:completeAnimation()
	f2_arg0.smoke:completeAnimation()
	f2_arg0.largesmoke:completeAnimation()
	f2_arg0.largesmoke2:completeAnimation()
	f2_arg0.arm:setZRot(0)
	f2_arg0.gret:setLeftRight(0, 0, 260, 372)
	f2_arg0.gret:setTopBottom(0, 0, 120, 256)
	f2_arg0.gret:setZRot(0)
	f2_arg0.hans:setLeftRight(0, 0, 112, 240)
	f2_arg0.hans:setTopBottom(0, 0, 91, 251)
	f2_arg0.hans:setZRot(0)
	f2_arg0.largesmoke:setLeftRight(0, 0, -211.5, 548.5)
	f2_arg0.largesmoke:setAlpha(1)
	f2_arg0.largesmoke2:setLeftRight(0, 0, 580, 1340)
	f2_arg0.largesmoke2:setAlpha(0)
end
CoD[0x6DF244A87F06B10].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(6)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2010, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setLeftRight(0, 0, 245, 357)
					f5_arg0:setZRot(19)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.gret:beginAnimation(990, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.gret:setLeftRight(0, 0, 196, 308)
				f3_arg0.gret:setZRot(-11)
				f3_arg0.gret:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gret:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.gret:completeAnimation()
			f3_arg0.gret:setLeftRight(0, 0, 245, 357)
			f3_arg0.gret:setTopBottom(0, 0, 126, 262)
			f3_arg0.gret:setZRot(19)
			f3_local0(f3_arg0.gret)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(2300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f7_arg0:setLeftRight(0, 0, 150, 278)
					f7_arg0:setTopBottom(0, 0, 96, 256)
					f7_arg0:setZRot(11)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.hans:beginAnimation(700, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.hans:setLeftRight(0, 0, 76, 204)
				f3_arg0.hans:setTopBottom(0, 0, 106, 266)
				f3_arg0.hans:setZRot(-10)
				f3_arg0.hans:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hans:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.hans:completeAnimation()
			f3_arg0.hans:setLeftRight(0, 0, 150, 278)
			f3_arg0.hans:setTopBottom(0, 0, 96, 256)
			f3_arg0.hans:setZRot(11)
			f3_local1(f3_arg0.hans)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f9_arg0:setZRot(-8)
					f9_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.arm:playClip("DefaultClip")
				f3_arg0.arm:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.arm:setZRot(2)
				f3_arg0.arm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arm:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.arm:completeAnimation()
			f3_arg0.arm:setZRot(-8)
			f3_local2(f3_arg0.arm)
			f3_arg0.smoke:completeAnimation()
			f3_arg0.smoke:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.smoke)
			local f3_local3 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(1500)
					f12_arg0:setLeftRight(0, 0, 366, 1126)
					f12_arg0:setAlpha(0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.largesmoke:beginAnimation(1500)
				f3_arg0.largesmoke:setLeftRight(0, 0, 77.25, 837.25)
				f3_arg0.largesmoke:setAlpha(1)
				f3_arg0.largesmoke:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.largesmoke:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.largesmoke:completeAnimation()
			f3_arg0.largesmoke:setLeftRight(0, 0, -211.5, 548.5)
			f3_arg0.largesmoke:setAlpha(0)
			f3_local3(f3_arg0.largesmoke)
			local f3_local4 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(1500)
					f14_arg0:setLeftRight(0, 0, -166, 594)
					f14_arg0:setAlpha(0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.largesmoke2:beginAnimation(1500)
				f3_arg0.largesmoke2:setLeftRight(0, 0, 207, 967)
				f3_arg0.largesmoke2:setAlpha(1)
				f3_arg0.largesmoke2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.largesmoke2:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.largesmoke2:completeAnimation()
			f3_arg0.largesmoke2:setLeftRight(0, 0, 580, 1340)
			f3_arg0.largesmoke2:setAlpha(0)
			f3_local4(f3_arg0.largesmoke2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0x6DF244A87F06B10].__onClose = function(f15_arg0)
	f15_arg0.arm:close()
	f15_arg0.smoke:close()
end
