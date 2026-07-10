require("x64:de41b5dda8306fc")
require("x64:5bf5dd18266b70b")
CoD.CallingCards_Asset_Pirates_Pirate = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Pirates_Pirate.__defaultWidth = 918
CoD.CallingCards_Asset_Pirates_Pirate.__defaultHeight = 280
CoD.CallingCards_Asset_Pirates_Pirate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Pirates_Pirate)
	self.id = "CallingCards_Asset_Pirates_Pirate"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local armwithsword = CoD.CallingCards_Asset_Pirates_armwithsword.new(f1_arg0, f1_arg1, 0, 0, 604, 614, 0, 0, 155.5, 165.5)
	armwithsword:setZRot(-14)
	self:addElement(armwithsword)
	self.armwithsword = armwithsword
	local armwithgun = CoD.CallingCards_Asset_Pirates_armwithgun.new(f1_arg0, f1_arg1, 0, 0, 717.5, 727.5, 0, 0, 145.5, 155.5)
	armwithgun:setZRot(9)
	self:addElement(armwithgun)
	self.armwithgun = armwithgun
	local piratebody = LUI.UIImage.new(0, 0, 517.5, 750.5, 0, 0, 0, 280)
	piratebody:setImage(RegisterImage(0x9285FBAE26567BF))
	self:addElement(piratebody)
	self.piratebody = piratebody
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_Pirates_Pirate.__resetProperties = function(f2_arg0)
	f2_arg0.armwithsword:completeAnimation()
	f2_arg0.armwithgun:completeAnimation()
	f2_arg0.armwithsword:setZRot(-14)
	f2_arg0.armwithgun:setZRot(9)
end
CoD.CallingCards_Asset_Pirates_Pirate.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f5_arg0:setZRot(-15)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.armwithsword:playClip("DefaultClip")
				f3_arg0.armwithsword:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.armwithsword:setZRot(8)
				f3_arg0.armwithsword:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.armwithsword:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.armwithsword:completeAnimation()
			f3_arg0.armwithsword:setZRot(-15)
			f3_local0(f3_arg0.armwithsword)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(2000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f8_arg0:setZRot(-15)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.armwithgun:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.armwithgun:setZRot(6)
				f3_arg0.armwithgun:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.armwithgun:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.armwithgun:completeAnimation()
			f3_arg0.armwithgun:setZRot(-15)
			f3_local1(f3_arg0.armwithgun)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.CallingCards_Asset_Pirates_Pirate.__onClose = function(f9_arg0)
	f9_arg0.armwithsword:close()
	f9_arg0.armwithgun:close()
end
