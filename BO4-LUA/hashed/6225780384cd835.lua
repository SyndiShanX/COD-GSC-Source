require("x64:24aaa148cf7f36c")
CoD.ui_icon_callingcards_assassin_fastlines = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_assassin_fastlines.__defaultWidth = 960
CoD.ui_icon_callingcards_assassin_fastlines.__defaultHeight = 240
CoD.ui_icon_callingcards_assassin_fastlines.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_assassin_fastlines)
	self.id = "ui_icon_callingcards_assassin_fastlines"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fastlines = CoD.ui_icon_callingcards_assassin_fastlinesgroup.new(f1_arg0, f1_arg1, 0, 0, 0, 2496, 0, 0, 0, 240)
	self:addElement(fastlines)
	self.fastlines = fastlines
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_assassin_fastlines.__resetProperties = function(f2_arg0)
	f2_arg0.fastlines:completeAnimation()
	f2_arg0.fastlines:setLeftRight(0, 0, 0, 2496)
end
CoD.ui_icon_callingcards_assassin_fastlines.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.fastlines:beginAnimation(3000)
				f3_arg0.fastlines:setLeftRight(0, 0, -1664, 832)
				f3_arg0.fastlines:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.fastlines:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.fastlines:completeAnimation()
			f3_arg0.fastlines:setLeftRight(0, 0, 0, 2496)
			f3_local0(f3_arg0.fastlines)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_assassin_fastlines.__onClose = function(f5_arg0)
	f5_arg0.fastlines:close()
end
