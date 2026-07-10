require("x64:7cced5eedbb6965")
CoD[0x1F7D0795C43A08E] = InheritFrom(LUI.UIElement)
CoD[0x1F7D0795C43A08E].__defaultWidth = 960
CoD[0x1F7D0795C43A08E].__defaultHeight = 240
CoD[0x1F7D0795C43A08E].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x1F7D0795C43A08E])
	self.id = "CallingCards_WeaponProficiencyMaster"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0x88D6EC151BAB1B3))
	self:addElement(background)
	self.background = background
	local bullet2 = CoD.CallingCards_CowboyBounce.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(bullet2)
	self.bullet2 = bullet2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x1F7D0795C43A08E].__resetProperties = function(f2_arg0)
	f2_arg0.background:completeAnimation()
	f2_arg0.bullet2:completeAnimation()
	f2_arg0.background:setAlpha(1)
	f2_arg0.bullet2:setLeftRight(0, 0, 0, 960)
	f2_arg0.bullet2:setTopBottom(0, 0, 0, 240)
	f2_arg0.bullet2:setScale(1, 1)
end
CoD[0x1F7D0795C43A08E].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.background:completeAnimation()
			f3_arg0.background:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.background)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:playClip("DefaultClip")
						f6_arg0:beginAnimation(89)
						f6_arg0:setTopBottom(0, 0, 9, 189)
						f6_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
							element:playClip("DefaultClip")
							f3_arg0.clipFinished(element, event)
						end)
					end
					f5_arg0:playClip("DefaultClip")
					f5_arg0:beginAnimation(180)
					f5_arg0:setTopBottom(0, 0, 0, 180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.bullet2:playClip("DefaultClip")
				f3_arg0.bullet2:beginAnimation(20)
				f3_arg0.bullet2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bullet2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bullet2:completeAnimation()
			f3_arg0.bullet2:setLeftRight(0, 0, 0, 720)
			f3_arg0.bullet2:setTopBottom(0, 0, -1, 179)
			f3_arg0.bullet2:setScale(1.1, 1.1)
			f3_local0(f3_arg0.bullet2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0x1F7D0795C43A08E].__onClose = function(f8_arg0)
	f8_arg0.bullet2:close()
end
