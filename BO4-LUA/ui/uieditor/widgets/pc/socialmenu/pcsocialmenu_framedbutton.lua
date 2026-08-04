require("ui/uieditor/widgets/emptyfocusable")
CoD.PCSocialMenu_FramedButton = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_FramedButton.__defaultWidth = 412
CoD.PCSocialMenu_FramedButton.__defaultHeight = 32
CoD.PCSocialMenu_FramedButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_FramedButton)
	self.id = "PCSocialMenu_FramedButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AddFriendButton = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 32)
	AddFriendButton:setRGB(0.1, 0.1, 0.1)
	self:addElement(AddFriendButton)
	self.AddFriendButton = AddFriendButton
	local AddAFriendText = LUI.UIText.new(0, 0, 7.5, 405.5, 0, 0, 6.5, 27.5)
	AddAFriendText:setRGB(0.61, 0.61, 0.61)
	AddAFriendText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7D438E3FDF01C4DD"))
	AddAFriendText:setTTF("notosans_regular")
	AddAFriendText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	AddAFriendText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(AddAFriendText)
	self.AddAFriendText = AddAFriendText
	local ButtonBorderBottom = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -1, 0)
	ButtonBorderBottom:setAlpha(0.15)
	self:addElement(ButtonBorderBottom)
	self.ButtonBorderBottom = ButtonBorderBottom
	local ButtonBorderTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 1)
	ButtonBorderTop:setAlpha(0.15)
	self:addElement(ButtonBorderTop)
	self.ButtonBorderTop = ButtonBorderTop
	local ButtonBorderRight = LUI.UIImage.new(1, 1, -1, 0, 0, 1, 0, 0)
	ButtonBorderRight:setAlpha(0.15)
	self:addElement(ButtonBorderRight)
	self.ButtonBorderRight = ButtonBorderRight
	local ButtonBorderLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 32)
	ButtonBorderLeft:setAlpha(0.15)
	self:addElement(ButtonBorderLeft)
	self.ButtonBorderLeft = ButtonBorderLeft
	local ButtonDotTopRight = LUI.UIImage.new(1, 1, -1, 0, 0, 0, 0, 1)
	self:addElement(ButtonDotTopRight)
	self.ButtonDotTopRight = ButtonDotTopRight
	local ButtonDotTopLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	self:addElement(ButtonDotTopLeft)
	self.ButtonDotTopLeft = ButtonDotTopLeft
	local ButtonDotBottomRight = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	self:addElement(ButtonDotBottomRight)
	self.ButtonDotBottomRight = ButtonDotBottomRight
	local ButtonDotBottomLeft = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 31, 32)
	self:addElement(ButtonDotBottomLeft)
	self.ButtonDotBottomLeft = ButtonDotBottomLeft
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	emptyFocusable.id = "emptyFocusable"
	self.__defaultFocus = emptyFocusable
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_FramedButton.__resetProperties = function(f2_arg0)
	f2_arg0.AddAFriendText:completeAnimation()
	f2_arg0.AddFriendButton:completeAnimation()
	f2_arg0.emptyFocusable:completeAnimation()
	f2_arg0.ButtonDotTopRight:completeAnimation()
	f2_arg0.ButtonDotBottomRight:completeAnimation()
	f2_arg0.ButtonDotBottomLeft:completeAnimation()
	f2_arg0.ButtonDotTopLeft:completeAnimation()
	f2_arg0.AddAFriendText:setRGB(0.61, 0.61, 0.61)
	f2_arg0.AddAFriendText:setAlpha(1)
	f2_arg0.AddAFriendText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7D438E3FDF01C4DD"))
	f2_arg0.AddFriendButton:setRGB(0.1, 0.1, 0.1)
	f2_arg0.AddFriendButton:setAlpha(1)
	f2_arg0.emptyFocusable:setRGB(1, 1, 1)
	f2_arg0.ButtonDotTopRight:setAlpha(1)
	f2_arg0.ButtonDotBottomRight:setAlpha(1)
	f2_arg0.ButtonDotBottomLeft:setAlpha(1)
	f2_arg0.ButtonDotTopLeft:setAlpha(1)
end
CoD.PCSocialMenu_FramedButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.AddFriendButton:beginAnimation(100)
				f4_arg0.AddFriendButton:setRGB(0.2, 0.2, 0.2)
				f4_arg0.AddFriendButton:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.AddFriendButton:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.AddFriendButton:completeAnimation()
			f4_arg0.AddFriendButton:setRGB(0.1, 0.1, 0.1)
			f4_local0(f4_arg0.AddFriendButton)
			local f4_local1 = function(f6_arg0)
				f4_arg0.AddAFriendText:beginAnimation(100)
				f4_arg0.AddAFriendText:setRGB(1, 1, 1)
				f4_arg0.AddAFriendText:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.AddAFriendText:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.AddAFriendText:completeAnimation()
			f4_arg0.AddAFriendText:setRGB(0.61, 0.61, 0.61)
			f4_local1(f4_arg0.AddAFriendText)
		end,
		ChildLoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				f7_arg0.AddFriendButton:beginAnimation(100)
				f7_arg0.AddFriendButton:setRGB(0.1, 0.1, 0.1)
				f7_arg0.AddFriendButton:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AddFriendButton:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.AddFriendButton:completeAnimation()
			f7_arg0.AddFriendButton:setRGB(0.2, 0.2, 0.2)
			f7_local0(f7_arg0.AddFriendButton)
			local f7_local1 = function(f9_arg0)
				f7_arg0.AddAFriendText:beginAnimation(100)
				f7_arg0.AddAFriendText:setRGB(0.61, 0.61, 0.61)
				f7_arg0.AddAFriendText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AddAFriendText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.AddAFriendText:completeAnimation()
			f7_arg0.AddAFriendText:setRGB(1, 1, 1)
			f7_local1(f7_arg0.AddAFriendText)
			f7_arg0.emptyFocusable:completeAnimation()
			f7_arg0.emptyFocusable:setRGB(1, 1, 1)
			f7_arg0.clipFinished(f7_arg0.emptyFocusable)
		end,
	},
	CouldNotSend = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(6)
			f10_arg0.AddFriendButton:completeAnimation()
			f10_arg0.AddFriendButton:setRGB(0.08, 0.08, 0.08)
			f10_arg0.AddFriendButton:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.AddFriendButton)
			f10_arg0.AddAFriendText:completeAnimation()
			f10_arg0.AddAFriendText:setAlpha(0.3)
			f10_arg0.clipFinished(f10_arg0.AddAFriendText)
			f10_arg0.ButtonDotTopRight:completeAnimation()
			f10_arg0.ButtonDotTopRight:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.ButtonDotTopRight)
			f10_arg0.ButtonDotTopLeft:completeAnimation()
			f10_arg0.ButtonDotTopLeft:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.ButtonDotTopLeft)
			f10_arg0.ButtonDotBottomRight:completeAnimation()
			f10_arg0.ButtonDotBottomRight:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.ButtonDotBottomRight)
			f10_arg0.ButtonDotBottomLeft:completeAnimation()
			f10_arg0.ButtonDotBottomLeft:setAlpha(0.1)
			f10_arg0.clipFinished(f10_arg0.ButtonDotBottomLeft)
		end,
	},
	SendRequest = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.AddAFriendText:beginAnimation(10)
			f11_arg0.AddAFriendText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x1DA964B91BD7062))
			f11_arg0.AddAFriendText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.AddAFriendText:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.AddFriendButton:beginAnimation(100)
				f12_arg0.AddFriendButton:setRGB(0.2, 0.2, 0.2)
				f12_arg0.AddFriendButton:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.AddFriendButton:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.AddFriendButton:completeAnimation()
			f12_arg0.AddFriendButton:setRGB(0.1, 0.1, 0.1)
			f12_local0(f12_arg0.AddFriendButton)
			local f12_local1 = function(f14_arg0)
				f12_arg0.AddAFriendText:beginAnimation(100)
				f12_arg0.AddAFriendText:setRGB(1, 1, 1)
				f12_arg0.AddAFriendText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.AddAFriendText:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.AddAFriendText:completeAnimation()
			f12_arg0.AddAFriendText:setRGB(0.61, 0.61, 0.61)
			f12_arg0.AddAFriendText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x1DA964B91BD7062))
			f12_local1(f12_arg0.AddAFriendText)
		end,
		ChildLoseFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f15_arg0.AddFriendButton:beginAnimation(100)
				f15_arg0.AddFriendButton:setRGB(0.1, 0.1, 0.1)
				f15_arg0.AddFriendButton:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.AddFriendButton:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.AddFriendButton:completeAnimation()
			f15_arg0.AddFriendButton:setRGB(0.2, 0.2, 0.2)
			f15_local0(f15_arg0.AddFriendButton)
			local f15_local1 = function(f17_arg0)
				f15_arg0.AddAFriendText:beginAnimation(100)
				f15_arg0.AddAFriendText:setRGB(0.61, 0.61, 0.61)
				f15_arg0.AddAFriendText:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.AddAFriendText:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.AddAFriendText:completeAnimation()
			f15_arg0.AddAFriendText:setRGB(1, 1, 1)
			f15_local1(f15_arg0.AddAFriendText)
			f15_arg0.emptyFocusable:completeAnimation()
			f15_arg0.emptyFocusable:setRGB(1, 1, 1)
			f15_arg0.clipFinished(f15_arg0.emptyFocusable)
		end,
	},
}
CoD.PCSocialMenu_FramedButton.__onClose = function(f18_arg0)
	f18_arg0.emptyFocusable:close()
end
