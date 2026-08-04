require("ui/uieditor/widgets/pc/utility/verticallistspacer")
CoD.DirectorQuitButtonContainer = InheritFrom(LUI.UIElement)
CoD.DirectorQuitButtonContainer.__defaultWidth = 274
CoD.DirectorQuitButtonContainer.__defaultHeight = 36
CoD.DirectorQuitButtonContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, true)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.DirectorQuitButtonContainer)
	self.id = "DirectorQuitButtonContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setAlpha(0)
	self:addElement(BG)
	self.BG = BG
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 266, 274, 0.5, 0.5, -25.5, 25.5)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local QuitText = LUI.UIText.new(0, 0, 205, 255, 0.5, 0.5, -7.5, 10.5)
	QuitText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	QuitText:setAlpha(0.35)
	QuitText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x6AE6A4370C4AB65))
	QuitText:setTTF("default")
	QuitText:setLetterSpacing(6)
	QuitText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(QuitText)
	self.QuitText = QuitText
	local QuitIcon = LUI.UIImage.new(0, 0, 171, 196, 0.5, 0.5, -13.5, 11.5)
	QuitIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	QuitIcon:setAlpha(0.55)
	QuitIcon:setImage(RegisterImage("uie_director_main_quit_icon"))
	self:addElement(QuitIcon)
	self.QuitIcon = QuitIcon
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 153, 161, 0.5, 0.5, -25.5, 25.5)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		OpenPCQuit(self, f2_arg1, self, f2_arg2)
		return true
	end, function(f3_arg0, f3_arg1, f3_arg2)
		CoD.Menu.SetButtonLabel(f3_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorQuitButtonContainer.__resetProperties = function(f4_arg0)
	f4_arg0.QuitIcon:completeAnimation()
	f4_arg0.QuitText:completeAnimation()
	f4_arg0.QuitIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f4_arg0.QuitIcon:setAlpha(0.55)
	f4_arg0.QuitText:setAlpha(0.35)
end
CoD.DirectorQuitButtonContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.QuitText:completeAnimation()
			f6_arg0.QuitText:setAlpha(0.8)
			f6_arg0.clipFinished(f6_arg0.QuitText)
			f6_arg0.QuitIcon:completeAnimation()
			f6_arg0.QuitIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f6_arg0.QuitIcon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.QuitIcon)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.QuitText:beginAnimation(100)
				f7_arg0.QuitText:setAlpha(0.8)
				f7_arg0.QuitText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.QuitText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.QuitText:completeAnimation()
			f7_arg0.QuitText:setAlpha(0.35)
			f7_local0(f7_arg0.QuitText)
			local f7_local1 = function(f9_arg0)
				f7_arg0.QuitIcon:beginAnimation(100)
				f7_arg0.QuitIcon:setAlpha(1)
				f7_arg0.QuitIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.QuitIcon:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.QuitIcon:completeAnimation()
			f7_arg0.QuitIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f7_arg0.QuitIcon:setAlpha(0.55)
			f7_local1(f7_arg0.QuitIcon)
		end,
		LoseFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				f10_arg0.QuitText:beginAnimation(150)
				f10_arg0.QuitText:setAlpha(0.35)
				f10_arg0.QuitText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.QuitText:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.QuitText:completeAnimation()
			f10_arg0.QuitText:setAlpha(0.8)
			f10_local0(f10_arg0.QuitText)
			local f10_local1 = function(f12_arg0)
				f10_arg0.QuitIcon:beginAnimation(150)
				f10_arg0.QuitIcon:setAlpha(0.55)
				f10_arg0.QuitIcon:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.QuitIcon:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.QuitIcon:completeAnimation()
			f10_arg0.QuitIcon:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f10_arg0.QuitIcon:setAlpha(1)
			f10_local1(f10_arg0.QuitIcon)
		end,
	},
}
CoD.DirectorQuitButtonContainer.__onClose = function(f13_arg0)
	f13_arg0.Spacer:close()
	f13_arg0.Spacer2:close()
end
