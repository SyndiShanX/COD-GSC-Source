require("x64:b7079cabff5b7aa")
CoD.ui_icon_callingcards_stpatricks1 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_stpatricks1.__defaultWidth = 960
CoD.ui_icon_callingcards_stpatricks1.__defaultHeight = 240
CoD.ui_icon_callingcards_stpatricks1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_stpatricks1)
	self.id = "ui_icon_callingcards_stpatricks1"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0x4BD4CD811A5D5E0))
	self:addElement(bg)
	self.bg = bg
	local clouds = LUI.UIImage.new(0, 0, -168.5, 1061.5, 0, 0, -148, 364)
	clouds:setImage(RegisterImage(0x8A183B208FB1BD))
	self:addElement(clouds)
	self.clouds = clouds
	local speedlines = CoD.ui_icon_callingcards_stpatricks_speedlines.new(f1_arg0, f1_arg1, 0, 0, -135, 1095, 0, 0, -265.5, 462.5)
	self:addElement(speedlines)
	self.speedlines = speedlines
	local ruin = LUI.UIImage.new(0, 0, 358, 566, 0, 0, 8, 232)
	ruin:setScale(0.5, 0.5)
	ruin:setImage(RegisterImage(0x92F7B0959183DE9))
	self:addElement(ruin)
	self.ruin = ruin
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_stpatricks1.__resetProperties = function(f2_arg0)
	f2_arg0.speedlines:completeAnimation()
	f2_arg0.clouds:completeAnimation()
	f2_arg0.ruin:completeAnimation()
	f2_arg0.speedlines:setAlpha(1)
	f2_arg0.speedlines:setZRot(0)
	f2_arg0.speedlines:setScale(1, 1)
	f2_arg0.clouds:setLeftRight(0, 0, -168.5, 1061.5)
	f2_arg0.clouds:setScale(1, 1)
	f2_arg0.ruin:setScale(0.5, 0.5)
end
CoD.ui_icon_callingcards_stpatricks1.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				f3_arg0.clouds:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.clouds:setLeftRight(0, 0, -158.5, 1071.5)
				f3_arg0.clouds:setScale(0.9, 0.9)
				f3_arg0.clouds:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.clouds:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.clouds:completeAnimation()
			f3_arg0.clouds:setLeftRight(0, 0, -138.5, 1091.5)
			f3_arg0.clouds:setScale(1, 1)
			f3_local0(f3_arg0.clouds)
			local f3_local1 = function(f5_arg0)
				f3_arg0.speedlines:playClip("DefaultClip")
				f3_arg0.speedlines:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.speedlines:setAlpha(0.6)
				f3_arg0.speedlines:setScale(1, 1)
				f3_arg0.speedlines:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.speedlines:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("DefaultClip")
					f3_arg0.clipFinished(element, event)
				end)
			end
			f3_arg0.speedlines:completeAnimation()
			f3_arg0.speedlines:setAlpha(0.4)
			f3_arg0.speedlines:setZRot(0)
			f3_arg0.speedlines:setScale(0.7, 0.7)
			f3_local1(f3_arg0.speedlines)
			local f3_local2 = function(f7_arg0)
				f3_arg0.ruin:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.ruin:setScale(2, 2)
				f3_arg0.ruin:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ruin:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.ruin:completeAnimation()
			f3_arg0.ruin:setScale(0.7, 0.7)
			f3_local2(f3_arg0.ruin)
		end,
	},
}
CoD.ui_icon_callingcards_stpatricks1.__onClose = function(f8_arg0)
	f8_arg0.speedlines:close()
end
