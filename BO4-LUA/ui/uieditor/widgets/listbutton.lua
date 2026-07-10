require("x64:d7e092479c7b82c")
require("x64:efcc4f6f419a2c2")
CoD.ListButton = InheritFrom(LUI.UIElement)
CoD.ListButton.__defaultWidth = 540
CoD.ListButton.__defaultHeight = 52
CoD.ListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ListButton)
	self.id = "ListButton"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 22, 540, 0, 0, 0, 52)
	Background:setRGB(0.11, 0.14, 0.2)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local Text = CoD.button_internal.new(f1_arg0, f1_arg1, 0, 0, 45, 540, 0, 0, 0, 52)
	Text:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Text.Text0:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Text)
	self.Text = Text
	local SelectionIndicator = CoD.Border.new(f1_arg0, f1_arg1, 0, 0, 12, 18, 0, 0, 0, 52)
	SelectionIndicator:setRGB(1, 0.41, 0)
	SelectionIndicator:setAlpha(0)
	self:addElement(SelectionIndicator)
	self.SelectionIndicator = SelectionIndicator
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ListButton.__resetProperties = function(f3_arg0)
	f3_arg0.SelectionIndicator:completeAnimation()
	f3_arg0.Background:completeAnimation()
	f3_arg0.Text:completeAnimation()
	f3_arg0.SelectionIndicator:setAlpha(0)
	f3_arg0.Background:setAlpha(0)
	f3_arg0.Text:setAlpha(1)
end
CoD.ListButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		LoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Background:beginAnimation(150)
				f5_arg0.Background:setAlpha(0)
				f5_arg0.Background:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Background:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setAlpha(1)
			f5_local0(f5_arg0.Background)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Text:beginAnimation(150)
				f5_arg0.Text:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Text:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Text:completeAnimation()
			f5_arg0.Text:setAlpha(1)
			f5_local1(f5_arg0.Text)
			local f5_local2 = function(f8_arg0)
				f5_arg0.SelectionIndicator:beginAnimation(150)
				f5_arg0.SelectionIndicator:setAlpha(0)
				f5_arg0.SelectionIndicator:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.SelectionIndicator:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.SelectionIndicator:completeAnimation()
			f5_arg0.SelectionIndicator:setAlpha(1)
			f5_local2(f5_arg0.SelectionIndicator)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Background:beginAnimation(150)
				f9_arg0.Background:setAlpha(1)
				f9_arg0.Background:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Background:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Background:completeAnimation()
			f9_arg0.Background:setAlpha(0)
			f9_local0(f9_arg0.Background)
			local f9_local1 = function(f11_arg0)
				f9_arg0.SelectionIndicator:beginAnimation(150)
				f9_arg0.SelectionIndicator:setAlpha(1)
				f9_arg0.SelectionIndicator:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SelectionIndicator:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SelectionIndicator:completeAnimation()
			f9_arg0.SelectionIndicator:setAlpha(0)
			f9_local1(f9_arg0.SelectionIndicator)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.Background:beginAnimation(500)
				f12_arg0.Background:setAlpha(0.75)
				f12_arg0.Background:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Background:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.Background:completeAnimation()
			f12_arg0.Background:setAlpha(1)
			f12_local0(f12_arg0.Background)
			local f12_local1 = function(f15_arg0)
				f12_arg0.Text:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f12_arg0.Text:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Text:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Text:completeAnimation()
			f12_arg0.Text:setAlpha(0.8)
			f12_local1(f12_arg0.Text)
			f12_arg0.nextClip = "Focus"
		end,
	},
}
CoD.ListButton.__onClose = function(f16_arg0)
	f16_arg0.Text:close()
	f16_arg0.SelectionIndicator:close()
end
