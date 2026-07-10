require("x64:ed08db6bc172b67")
require("x64:1bd88f5d2b4f0ca")
CoD.DirectorGameRules = InheritFrom(LUI.UIElement)
CoD.DirectorGameRules.__defaultWidth = 356
CoD.DirectorGameRules.__defaultHeight = 200
CoD.DirectorGameRules.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorGameRules)
	self.id = "DirectorGameRules"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameRules = CoD.DirectorGameRulesContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 356, 0, 0, 0, 200)
	self:addElement(GameRules)
	self.GameRules = GameRules
	local PCTooltipExceptionWidget = nil
	PCTooltipExceptionWidget = CoD.PC_TooltipExceptionWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -178, 178, 1, 1, -28, 0)
	PCTooltipExceptionWidget:setAlpha(0)
	PCTooltipExceptionWidget.Tip:setText(LocalizeToUpperString(0xBB7AA7A26F39DFA))
	self:addElement(PCTooltipExceptionWidget)
	self.PCTooltipExceptionWidget = PCTooltipExceptionWidget
	GameRules.id = "GameRules"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorGameRules.__resetProperties = function(f2_arg0)
	f2_arg0.GameRules:completeAnimation()
	f2_arg0.PCTooltipExceptionWidget:completeAnimation()
	f2_arg0.GameRules:setAlpha(1)
	f2_arg0.GameRules:setScale(1, 1)
	f2_arg0.PCTooltipExceptionWidget:setTopBottom(1, 1, -28, 0)
	f2_arg0.PCTooltipExceptionWidget:setAlpha(0)
	f2_arg0.PCTooltipExceptionWidget.Tip:setAlpha(1)
end
CoD.DirectorGameRules.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.GameRules:completeAnimation()
			f3_arg0.GameRules:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.GameRules)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.GameRules:completeAnimation()
			f4_arg0.GameRules:setAlpha(1)
			f4_arg0.GameRules:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.GameRules)
			f4_arg0.PCTooltipExceptionWidget:completeAnimation()
			f4_arg0.PCTooltipExceptionWidget:setAlpha(1)
			f4_arg0.PCTooltipExceptionWidget:playClip("cFocus")
			f4_arg0.clipFinished(f4_arg0.PCTooltipExceptionWidget)
		end,
		LoseChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.GameRules:beginAnimation(150)
				f5_arg0.GameRules:setScale(1, 1)
				f5_arg0.GameRules:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.GameRules:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.GameRules:completeAnimation()
			f5_arg0.GameRules:setScale(1.05, 1.05)
			f5_local0(f5_arg0.GameRules)
			local f5_local1 = function(f7_arg0)
				f5_arg0.PCTooltipExceptionWidget:playClip("cLoseFocus")
				f5_arg0.PCTooltipExceptionWidget:beginAnimation(150)
				f5_arg0.PCTooltipExceptionWidget.Tip:beginAnimation(150)
				f5_arg0.PCTooltipExceptionWidget:setTopBottom(1, 1, -1, 0)
				f5_arg0.PCTooltipExceptionWidget:setAlpha(0)
				f5_arg0.PCTooltipExceptionWidget.Tip:setAlpha(0)
				f5_arg0.PCTooltipExceptionWidget:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.PCTooltipExceptionWidget:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cLoseFocus")
					f5_arg0.clipFinished(element, event)
				end)
			end
			f5_arg0.PCTooltipExceptionWidget:completeAnimation()
			f5_arg0.PCTooltipExceptionWidget.Tip:completeAnimation()
			f5_arg0.PCTooltipExceptionWidget:setTopBottom(1, 1, -28, 0)
			f5_arg0.PCTooltipExceptionWidget:setAlpha(1)
			f5_arg0.PCTooltipExceptionWidget.Tip:setAlpha(1)
			f5_local1(f5_arg0.PCTooltipExceptionWidget)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.GameRules:beginAnimation(150)
				f9_arg0.GameRules:setScale(1.05, 1.05)
				f9_arg0.GameRules:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.GameRules:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.GameRules:completeAnimation()
			f9_arg0.GameRules:setScale(1, 1)
			f9_local0(f9_arg0.GameRules)
			local f9_local1 = function(f11_arg0)
				f9_arg0.PCTooltipExceptionWidget:playClip("cGainFocus")
				f9_arg0.PCTooltipExceptionWidget:beginAnimation(150)
				f9_arg0.PCTooltipExceptionWidget.Tip:beginAnimation(150)
				f9_arg0.PCTooltipExceptionWidget:setTopBottom(1, 1, -28, 0)
				f9_arg0.PCTooltipExceptionWidget:setAlpha(1)
				f9_arg0.PCTooltipExceptionWidget.Tip:setAlpha(1)
				f9_arg0.PCTooltipExceptionWidget:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.PCTooltipExceptionWidget:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("cGainFocus")
					f9_arg0.clipFinished(element, event)
				end)
			end
			f9_arg0.PCTooltipExceptionWidget:completeAnimation()
			f9_arg0.PCTooltipExceptionWidget.Tip:completeAnimation()
			f9_arg0.PCTooltipExceptionWidget:setTopBottom(1, 1, -1, 0)
			f9_arg0.PCTooltipExceptionWidget:setAlpha(0)
			f9_arg0.PCTooltipExceptionWidget.Tip:setAlpha(0)
			f9_local1(f9_arg0.PCTooltipExceptionWidget)
		end,
	},
	Invisible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.GameRules:completeAnimation()
			f13_arg0.GameRules:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.GameRules)
		end,
	},
}
CoD.DirectorGameRules.__onClose = function(f14_arg0)
	f14_arg0.GameRules:close()
	f14_arg0.PCTooltipExceptionWidget:close()
end
