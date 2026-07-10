require("x64:e5180b86bb45920")
CoD.MP_HardcoreScorestreakWidget = InheritFrom(LUI.UIElement)
CoD.MP_HardcoreScorestreakWidget.__defaultWidth = 300
CoD.MP_HardcoreScorestreakWidget.__defaultHeight = 37
CoD.MP_HardcoreScorestreakWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.currentHCStreakName", "")
	self:setClass(CoD.MP_HardcoreScorestreakWidget)
	self.id = "MP_HardcoreScorestreakWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Panel = CoD.ScoreInfo_PanelScale.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, -2)
	Panel:setRGB(0.64, 0.67, 0.7)
	self:addElement(Panel)
	self.Panel = Panel
	local text = LUI.UIText.new(0, 0, 15, 289, 0, 0, 0, 38)
	text:setTTF("default")
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	text:subscribeToGlobalModel(f1_arg1, "HUDItems", "currentHCStreakName", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			text:setText(f2_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(text, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 0)
	end)
	self:addElement(text)
	self.text = text
	self:subscribeToGlobalModel(f1_arg1, "PerController", "hudItems.currentHCStreakName", function(model)
		local f4_local0 = self
		if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.currentHCStreakName", "") then
			PlayClip(self, "Show", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MP_HardcoreScorestreakWidget.__resetProperties = function(f5_arg0)
	f5_arg0.Panel:completeAnimation()
	f5_arg0.text:completeAnimation()
	f5_arg0.Panel:setAlpha(1)
	f5_arg0.text:setAlpha(1)
end
CoD.MP_HardcoreScorestreakWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Panel:completeAnimation()
			f6_arg0.Panel:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Panel)
			f6_arg0.text:completeAnimation()
			f6_arg0.text:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.text)
		end,
		Show = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(290, Enum[@"luitween"][@"luitween_bounce"])
						f10_arg0:setAlpha(0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(1770)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.Panel:beginAnimation(150)
				f7_arg0.Panel:setAlpha(1)
				f7_arg0.Panel:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Panel:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.Panel:completeAnimation()
			f7_arg0.Panel:setAlpha(0)
			f7_local0(f7_arg0.Panel)
			local f7_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						f13_arg0:beginAnimation(290, Enum[@"luitween"][@"luitween_bounce"])
						f13_arg0:setAlpha(0)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f12_arg0:beginAnimation(1719)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f11_arg0:beginAnimation(150)
				f11_arg0:setAlpha(1)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f7_arg0.text:beginAnimation(50)
			f7_arg0.text:setAlpha(0)
			f7_arg0.text:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.text:registerEventHandler("transition_complete_keyframe", f7_local1)
		end,
	},
}
CoD.MP_HardcoreScorestreakWidget.__onClose = function(f14_arg0)
	f14_arg0.Panel:close()
	f14_arg0.text:close()
end
