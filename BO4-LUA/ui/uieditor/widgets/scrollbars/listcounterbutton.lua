require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmaincorners")
require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
CoD.listCounterButton = InheritFrom(LUI.UIElement)
CoD.listCounterButton.__defaultWidth = 50
CoD.listCounterButton.__defaultHeight = 50
CoD.listCounterButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.listCounterButton)
	self.id = "listCounterButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonBG = LUI.UIImage.new(0, 1, 6, -6, 0, 1, 6, -6)
	ButtonBG:setRGB(0, 0, 0)
	ButtonBG:setAlpha(0)
	self:addElement(ButtonBG)
	self.ButtonBG = ButtonBG
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 1, 6, -6, 0, 1, 6, -6)
	Corner:setAlpha(0)
	self:addElement(Corner)
	self.Corner = Corner
	local SelectorOverlay = LUI.UIImage.new(0, 1, 6, -6, 0, 1, 6, -6)
	SelectorOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectorOverlay:setAlpha(0)
	self:addElement(SelectorOverlay)
	self.SelectorOverlay = SelectorOverlay
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 6, -6, 0, 1, 6, -6)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local WhiteTriangle = LUI.UIImage.new(0.5, 0.5, -10, 10, 0.5, 0.5, -6, 6)
	WhiteTriangle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_BE6E734C31AE757"))
	self:addElement(WhiteTriangle)
	self.WhiteTriangle = WhiteTriangle
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "FreeCursor",
			condition = function(menu, element, event)
				return IsFreeCursorActiveAndVisible(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.usingCursorInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.hidden, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local7(f1_local6, f1_local8.activeKeys, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.listCounterButton.__resetProperties = function(f8_arg0)
	f8_arg0.WhiteTriangle:completeAnimation()
	f8_arg0.ButtonBG:completeAnimation()
	f8_arg0.Frame:completeAnimation()
	f8_arg0.Corner:completeAnimation()
	f8_arg0.SelectorOverlay:completeAnimation()
	f8_arg0.WhiteTriangle:setRGB(1, 1, 1)
	f8_arg0.WhiteTriangle:setAlpha(1)
	f8_arg0.ButtonBG:setAlpha(0)
	f8_arg0.Frame:setAlpha(0)
	f8_arg0.Corner:setAlpha(0)
	f8_arg0.SelectorOverlay:setAlpha(0)
end
CoD.listCounterButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.WhiteTriangle:completeAnimation()
			f10_arg0.WhiteTriangle:setRGB(1, 0.41, 0)
			f10_arg0.clipFinished(f10_arg0.WhiteTriangle)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.WhiteTriangle:completeAnimation()
			f11_arg0.WhiteTriangle:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.WhiteTriangle)
		end,
	},
	Disabled = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.WhiteTriangle:completeAnimation()
			f12_arg0.WhiteTriangle:setRGB(0.31, 0.29, 0.24)
			f12_arg0.WhiteTriangle:setAlpha(0.8)
			f12_arg0.clipFinished(f12_arg0.WhiteTriangle)
		end,
	},
	FreeCursor = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.ButtonBG:completeAnimation()
			f13_arg0.ButtonBG:setAlpha(0.4)
			f13_arg0.clipFinished(f13_arg0.ButtonBG)
			f13_arg0.Corner:completeAnimation()
			f13_arg0.Corner:setAlpha(0.4)
			f13_arg0.clipFinished(f13_arg0.Corner)
			f13_arg0.Frame:completeAnimation()
			f13_arg0.Frame:setAlpha(0.2)
			f13_arg0.clipFinished(f13_arg0.Frame)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.ButtonBG:completeAnimation()
			f14_arg0.ButtonBG:setAlpha(0.4)
			f14_arg0.clipFinished(f14_arg0.ButtonBG)
			f14_arg0.Corner:completeAnimation()
			f14_arg0.Corner:setAlpha(0.6)
			f14_arg0.clipFinished(f14_arg0.Corner)
			f14_arg0.SelectorOverlay:completeAnimation()
			f14_arg0.SelectorOverlay:setAlpha(0.1)
			f14_arg0.clipFinished(f14_arg0.SelectorOverlay)
			f14_arg0.Frame:completeAnimation()
			f14_arg0.Frame:setAlpha(0.5)
			f14_arg0.clipFinished(f14_arg0.Frame)
			f14_arg0.WhiteTriangle:completeAnimation()
			f14_arg0.WhiteTriangle:setRGB(1, 0.41, 0)
			f14_arg0.clipFinished(f14_arg0.WhiteTriangle)
		end,
		GainFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.ButtonBG:completeAnimation()
			f15_arg0.ButtonBG:setAlpha(0.4)
			f15_arg0.clipFinished(f15_arg0.ButtonBG)
			local f15_local0 = function(f16_arg0)
				f15_arg0.Corner:beginAnimation(150)
				f15_arg0.Corner:setAlpha(0.6)
				f15_arg0.Corner:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Corner:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Corner:completeAnimation()
			f15_arg0.Corner:setAlpha(0.4)
			f15_local0(f15_arg0.Corner)
			local f15_local1 = function(f17_arg0)
				f15_arg0.SelectorOverlay:beginAnimation(150)
				f15_arg0.SelectorOverlay:setAlpha(0.1)
				f15_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.SelectorOverlay:completeAnimation()
			f15_arg0.SelectorOverlay:setAlpha(0)
			f15_local1(f15_arg0.SelectorOverlay)
			local f15_local2 = function(f18_arg0)
				f15_arg0.Frame:beginAnimation(150)
				f15_arg0.Frame:setAlpha(0.5)
				f15_arg0.Frame:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Frame:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Frame:completeAnimation()
			f15_arg0.Frame:setAlpha(0.2)
			f15_local2(f15_arg0.Frame)
			local f15_local3 = function(f19_arg0)
				f15_arg0.WhiteTriangle:beginAnimation(150)
				f15_arg0.WhiteTriangle:setRGB(1, 0.41, 0)
				f15_arg0.WhiteTriangle:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.WhiteTriangle:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.WhiteTriangle:completeAnimation()
			f15_arg0.WhiteTriangle:setRGB(1, 1, 1)
			f15_local3(f15_arg0.WhiteTriangle)
		end,
		LoseFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.ButtonBG:completeAnimation()
			f20_arg0.ButtonBG:setAlpha(0.4)
			f20_arg0.clipFinished(f20_arg0.ButtonBG)
			local f20_local0 = function(f21_arg0)
				f20_arg0.Corner:beginAnimation(100)
				f20_arg0.Corner:setAlpha(0.4)
				f20_arg0.Corner:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Corner:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Corner:completeAnimation()
			f20_arg0.Corner:setAlpha(0.6)
			f20_local0(f20_arg0.Corner)
			local f20_local1 = function(f22_arg0)
				f20_arg0.SelectorOverlay:beginAnimation(100)
				f20_arg0.SelectorOverlay:setAlpha(0)
				f20_arg0.SelectorOverlay:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.SelectorOverlay:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.SelectorOverlay:completeAnimation()
			f20_arg0.SelectorOverlay:setAlpha(0.1)
			f20_local1(f20_arg0.SelectorOverlay)
			local f20_local2 = function(f23_arg0)
				f20_arg0.Frame:beginAnimation(100)
				f20_arg0.Frame:setAlpha(0.2)
				f20_arg0.Frame:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Frame:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Frame:completeAnimation()
			f20_arg0.Frame:setAlpha(0.5)
			f20_local2(f20_arg0.Frame)
			local f20_local3 = function(f24_arg0)
				f20_arg0.WhiteTriangle:beginAnimation(100)
				f20_arg0.WhiteTriangle:setRGB(1, 1, 1)
				f20_arg0.WhiteTriangle:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.WhiteTriangle:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.WhiteTriangle:completeAnimation()
			f20_arg0.WhiteTriangle:setRGB(1, 0.41, 0)
			f20_local3(f20_arg0.WhiteTriangle)
		end,
	},
}
if not CoD.isPC then
	CoD.listCounterButton.__clipsPerState.DefaultState.Focus = nil
end
CoD.listCounterButton.__onClose = function(f25_arg0)
	f25_arg0.Corner:close()
	f25_arg0.Frame:close()
end
