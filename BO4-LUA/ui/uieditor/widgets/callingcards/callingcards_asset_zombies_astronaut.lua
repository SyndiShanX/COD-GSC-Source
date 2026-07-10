require("x64:992cd9d81359ad7")
CoD.CallingCards_Asset_zombies_astronaut = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_zombies_astronaut.__defaultWidth = 392
CoD.CallingCards_Asset_zombies_astronaut.__defaultHeight = 240
CoD.CallingCards_Asset_zombies_astronaut.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_zombies_astronaut)
	self.id = "CallingCards_Asset_zombies_astronaut"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local astronaut = LUI.UIImage.new(0, 0, 0, 392, 0, 0, 0, 240)
	astronaut:setImage(RegisterImage(0x1F1548BBF6B8059))
	self:addElement(astronaut)
	self.astronaut = astronaut
	local arm = CoD.CallingCards_Asset_zombies_arm.new(f1_arg0, f1_arg1, 0, 0, 249, 279, 0, 0, 138.5, 168.5)
	self:addElement(arm)
	self.arm = arm
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_zombies_astronaut.__resetProperties = function(f2_arg0)
	f2_arg0.arm:completeAnimation()
	f2_arg0.arm:setZRot(0)
end
CoD.CallingCards_Asset_zombies_astronaut.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setZRot(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.arm:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.arm:setZRot(-18)
				f3_arg0.arm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arm:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.arm:completeAnimation()
			f3_arg0.arm:setZRot(0)
			f3_local0(f3_arg0.arm)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.CallingCards_Asset_zombies_astronaut.__onClose = function(f6_arg0)
	f6_arg0.arm:close()
end
