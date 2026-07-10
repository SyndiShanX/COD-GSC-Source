require("x64:2d0c3ab47b56fc3")
CoD.ui_icon_callingcards_assassin_victim = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_assassin_victim.__defaultWidth = 384
CoD.ui_icon_callingcards_assassin_victim.__defaultHeight = 496
CoD.ui_icon_callingcards_assassin_victim.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_assassin_victim)
	self.id = "ui_icon_callingcards_assassin_victim"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local victim = LUI.UIImage.new(0, 0, 0, 384, 0, 0, 0, 496)
	victim:setImage(RegisterImage(@"uie_ui_icon_callingcards_assassin_victim"))
	self:addElement(victim)
	self.victim = victim
	local bentarm = CoD.ui_icon_callingcards_assassin_bentarm.new(f1_arg0, f1_arg1, 0, 0, 285, 295, 0, 0, 171.5, 181.5)
	bentarm:setZRot(-9)
	self:addElement(bentarm)
	self.bentarm = bentarm
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_assassin_victim.__resetProperties = function(f2_arg0)
	f2_arg0.bentarm:completeAnimation()
	f2_arg0.bentarm:setZRot(-9)
end
CoD.ui_icon_callingcards_assassin_victim.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1800)
						f6_arg0:setZRot(-9)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(200)
					f5_arg0:setZRot(56)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.bentarm:beginAnimation(1000)
				f3_arg0.bentarm:setZRot(14)
				f3_arg0.bentarm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bentarm:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bentarm:completeAnimation()
			f3_arg0.bentarm:setZRot(-9)
			f3_local0(f3_arg0.bentarm)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_assassin_victim.__onClose = function(f7_arg0)
	f7_arg0.bentarm:close()
end
