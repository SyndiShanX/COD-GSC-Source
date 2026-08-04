require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_stpatricks1")
require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_stpatricks2")
CoD.ui_icon_callingcards_stpatricks = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_stpatricks.__defaultWidth = 960
CoD.ui_icon_callingcards_stpatricks.__defaultHeight = 240
CoD.ui_icon_callingcards_stpatricks.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_stpatricks)
	self.id = "ui_icon_callingcards_stpatricks"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local icon1 = CoD.ui_icon_callingcards_stpatricks1.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(icon1)
	self.icon1 = icon1
	local uiiconcallingcardsstpatricks = CoD.ui_icon_callingcards_stpatricks2.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(uiiconcallingcardsstpatricks)
	self.uiiconcallingcardsstpatricks = uiiconcallingcardsstpatricks
	local blank = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	blank:setRGB(0, 0.15, 0.02)
	self:addElement(blank)
	self.blank = blank
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_stpatricks.__resetProperties = function(f2_arg0)
	f2_arg0.icon1:completeAnimation()
	f2_arg0.uiiconcallingcardsstpatricks:completeAnimation()
	f2_arg0.blank:completeAnimation()
	f2_arg0.uiiconcallingcardsstpatricks:setAlpha(1)
	f2_arg0.blank:setAlpha(1)
end
CoD.ui_icon_callingcards_stpatricks.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.icon1:completeAnimation()
			f3_arg0.icon1:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.icon1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(10)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.uiiconcallingcardsstpatricks:beginAnimation(840)
				f3_arg0.uiiconcallingcardsstpatricks:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.uiiconcallingcardsstpatricks:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.uiiconcallingcardsstpatricks:completeAnimation()
			f3_arg0.uiiconcallingcardsstpatricks:setAlpha(0)
			f3_local0(f3_arg0.uiiconcallingcardsstpatricks)
			local f3_local1 = function(f7_arg0)
				f7_arg0:beginAnimation(149)
				f7_arg0:setAlpha(1)
				f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.blank:beginAnimation(3200)
			f3_arg0.blank:setAlpha(0)
			f3_arg0.blank:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.blank:registerEventHandler("transition_complete_keyframe", f3_local1)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ui_icon_callingcards_stpatricks.__onClose = function(f8_arg0)
	f8_arg0.icon1:close()
	f8_arg0.uiiconcallingcardsstpatricks:close()
end
