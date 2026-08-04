require("ui/uieditor/widgets/callingcards/callingcards_asset_pirates_sword")
CoD.CallingCards_Asset_Pirates_armwithsword = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_Pirates_armwithsword.__defaultWidth = 10
CoD.CallingCards_Asset_Pirates_armwithsword.__defaultHeight = 10
CoD.CallingCards_Asset_Pirates_armwithsword.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_Pirates_armwithsword)
	self.id = "CallingCards_Asset_Pirates_armwithsword"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local sword = CoD.CallingCards_Asset_Pirates_sword.new(f1_arg0, f1_arg1, 0, 0, -239, -229, 0, 0, 5, 15)
	self:addElement(sword)
	self.sword = sword
	local armwithsword = LUI.UIImage.new(0, 0, -259, 21, 0, 0, -42, 62)
	armwithsword:setImage(RegisterImage("uie_ui_icon_callingcards_pirates_arm1"))
	self:addElement(armwithsword)
	self.armwithsword = armwithsword
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_Pirates_armwithsword.__resetProperties = function(f2_arg0)
	f2_arg0.sword:completeAnimation()
	f2_arg0.sword:setZRot(0)
end
CoD.CallingCards_Asset_Pirates_armwithsword.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1300, Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:setZRot(-56)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.sword:beginAnimation(1700, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.sword:setZRot(-10)
				f3_arg0.sword:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.sword:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.sword:completeAnimation()
			f3_arg0.sword:setZRot(-55)
			f3_local0(f3_arg0.sword)
		end,
	},
}
CoD.CallingCards_Asset_Pirates_armwithsword.__onClose = function(f7_arg0)
	f7_arg0.sword:close()
end
