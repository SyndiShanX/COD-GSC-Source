require("x64:2675595fa323085")
CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.__defaultWidth = 100
CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.__defaultHeight = 1080
CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz)
	self.id = "PC_StartMenu_Options_SafeAreaBorder_Horiz"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HandleBG = LUI.UIImage.new(0, 0, 20, 45, 0.5, 0.5, -60, 60)
	HandleBG:setAlpha(0.15)
	self:addElement(HandleBG)
	self.HandleBG = HandleBG
	local HandleBG2 = LUI.UIImage.new(0, 0, 32, 33, 0.5, 0.5, -35.5, 35.5)
	HandleBG2:setRGB(0, 0, 0)
	HandleBG2:setAlpha(0.3)
	self:addElement(HandleBG2)
	self.HandleBG2 = HandleBG2
	local Border = LUI.UIImage.new(0, 0, 0, 1, 0, 1, 0, 0)
	Border:setAlpha(0.15)
	self:addElement(Border)
	self.Border = Border
	local emptyFocusableClic = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 100, -100)
	self:addElement(emptyFocusableClic)
	self.emptyFocusableClic = emptyFocusableClic
	emptyFocusableClic.id = "emptyFocusableClic"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	SetFocusToElement(self, "emptyFocusable", f1_arg1)
	f1_local5 = emptyFocusableClic
	SetFocusToElement(self, "emptyFocusableClic", f1_arg1)
	return self
end
CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.__resetProperties = function(f2_arg0)
	f2_arg0.Border:completeAnimation()
	f2_arg0.HandleBG:completeAnimation()
	f2_arg0.Border:setLeftRight(0, 0, 0, 1)
	f2_arg0.Border:setAlpha(0.15)
	f2_arg0.HandleBG:setAlpha(0.15)
end
CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Active = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.HandleBG:beginAnimation(100)
				f4_arg0.HandleBG:setAlpha(0.8)
				f4_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.HandleBG:completeAnimation()
			f4_arg0.HandleBG:setAlpha(0.3)
			f4_local0(f4_arg0.HandleBG)
			local f4_local1 = function(f6_arg0)
				f4_arg0.Border:beginAnimation(100)
				f4_arg0.Border:setAlpha(0.8)
				f4_arg0.Border:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Border:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.Border:completeAnimation()
			f4_arg0.Border:setAlpha(0.3)
			f4_local1(f4_arg0.Border)
		end,
		Inactive = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.HandleBG:beginAnimation(100)
				f7_arg0.HandleBG:setAlpha(0.15)
				f7_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.HandleBG:completeAnimation()
			f7_arg0.HandleBG:setAlpha(0.3)
			f7_local0(f7_arg0.HandleBG)
			local f7_local1 = function(f9_arg0)
				f7_arg0.Border:beginAnimation(100)
				f7_arg0.Border:setAlpha(0.15)
				f7_arg0.Border:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Border:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Border:completeAnimation()
			f7_arg0.Border:setLeftRight(0, 0, 0, 1)
			f7_arg0.Border:setAlpha(0.3)
			f7_local1(f7_arg0.Border)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.HandleBG:completeAnimation()
			f10_arg0.HandleBG:setAlpha(0.6)
			f10_arg0.clipFinished(f10_arg0.HandleBG)
			f10_arg0.Border:completeAnimation()
			f10_arg0.Border:setAlpha(0.6)
			f10_arg0.clipFinished(f10_arg0.Border)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.HandleBG:beginAnimation(100)
				f11_arg0.HandleBG:setAlpha(0.6)
				f11_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.HandleBG:completeAnimation()
			f11_arg0.HandleBG:setAlpha(0.15)
			f11_local0(f11_arg0.HandleBG)
			local f11_local1 = function(f13_arg0)
				f11_arg0.Border:beginAnimation(100)
				f11_arg0.Border:setAlpha(0.6)
				f11_arg0.Border:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Border:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Border:completeAnimation()
			f11_arg0.Border:setAlpha(0.15)
			f11_local1(f11_arg0.Border)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.HandleBG:beginAnimation(100)
				f14_arg0.HandleBG:setAlpha(0.15)
				f14_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.HandleBG:completeAnimation()
			f14_arg0.HandleBG:setAlpha(0.6)
			f14_local0(f14_arg0.HandleBG)
			local f14_local1 = function(f16_arg0)
				f14_arg0.Border:beginAnimation(100)
				f14_arg0.Border:setAlpha(0.15)
				f14_arg0.Border:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Border:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Border:completeAnimation()
			f14_arg0.Border:setAlpha(0.6)
			f14_local1(f14_arg0.Border)
		end,
	},
	Active = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.HandleBG:completeAnimation()
			f17_arg0.HandleBG:setAlpha(0.8)
			f17_arg0.clipFinished(f17_arg0.HandleBG)
			f17_arg0.Border:completeAnimation()
			f17_arg0.Border:setAlpha(0.8)
			f17_arg0.clipFinished(f17_arg0.Border)
		end,
		DefaultState = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				f18_arg0.HandleBG:beginAnimation(100)
				f18_arg0.HandleBG:setAlpha(0.3)
				f18_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.HandleBG:completeAnimation()
			f18_arg0.HandleBG:setAlpha(0.8)
			f18_local0(f18_arg0.HandleBG)
			local f18_local1 = function(f20_arg0)
				f18_arg0.Border:beginAnimation(100)
				f18_arg0.Border:setAlpha(0.3)
				f18_arg0.Border:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Border:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Border:completeAnimation()
			f18_arg0.Border:setAlpha(0.8)
			f18_local1(f18_arg0.Border)
		end,
		Inactive = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.HandleBG:beginAnimation(100)
				f21_arg0.HandleBG:setAlpha(0.15)
				f21_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.HandleBG:completeAnimation()
			f21_arg0.HandleBG:setAlpha(0.8)
			f21_local0(f21_arg0.HandleBG)
			local f21_local1 = function(f23_arg0)
				f21_arg0.Border:beginAnimation(100)
				f21_arg0.Border:setAlpha(0.15)
				f21_arg0.Border:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.Border:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.Border:completeAnimation()
			f21_arg0.Border:setLeftRight(0, 0, 0, 1)
			f21_arg0.Border:setAlpha(0.8)
			f21_local1(f21_arg0.Border)
		end,
	},
	Inactive = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.HandleBG:completeAnimation()
			f24_arg0.HandleBG:setAlpha(0.15)
			f24_arg0.clipFinished(f24_arg0.HandleBG)
			f24_arg0.Border:completeAnimation()
			f24_arg0.Border:setLeftRight(0, 0, 0, 1)
			f24_arg0.Border:setAlpha(0.15)
			f24_arg0.clipFinished(f24_arg0.Border)
		end,
		DefaultState = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.HandleBG:beginAnimation(100)
				f25_arg0.HandleBG:setAlpha(0.3)
				f25_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.HandleBG:completeAnimation()
			f25_arg0.HandleBG:setAlpha(0.15)
			f25_local0(f25_arg0.HandleBG)
			local f25_local1 = function(f27_arg0)
				f25_arg0.Border:beginAnimation(100)
				f25_arg0.Border:setAlpha(0.3)
				f25_arg0.Border:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Border:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.Border:completeAnimation()
			f25_arg0.Border:setLeftRight(0, 0, 0, 1)
			f25_arg0.Border:setAlpha(0.15)
			f25_local1(f25_arg0.Border)
		end,
		Active = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			local f28_local0 = function(f29_arg0)
				f28_arg0.HandleBG:beginAnimation(100)
				f28_arg0.HandleBG:setAlpha(0.8)
				f28_arg0.HandleBG:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.HandleBG:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.HandleBG:completeAnimation()
			f28_arg0.HandleBG:setAlpha(0.15)
			f28_local0(f28_arg0.HandleBG)
			local f28_local1 = function(f30_arg0)
				f28_arg0.Border:beginAnimation(100)
				f28_arg0.Border:setAlpha(0.8)
				f28_arg0.Border:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Border:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.Border:completeAnimation()
			f28_arg0.Border:setLeftRight(0, 0, 0, 1)
			f28_arg0.Border:setAlpha(0.15)
			f28_local1(f28_arg0.Border)
		end,
	},
}
CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.__onClose = function(f31_arg0)
	f31_arg0.emptyFocusableClic:close()
end
