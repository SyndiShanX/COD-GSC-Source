require("x64:1cb861bc950b9a8")
require("x64:1cb891bc950bec1")
CoD.CodCasterObjectiveStatusSD = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatusSD.__defaultWidth = 412
CoD.CodCasterObjectiveStatusSD.__defaultHeight = 64
CoD.CodCasterObjectiveStatusSD.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterObjectiveStatusSD)
	self.id = "CodCasterObjectiveStatusSD"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BombB = CoD.codcasterBombB.new(f1_arg0, f1_arg1, 0, 0, 196.5, 256.5, 0, 0, -1, 59)
	self:addElement(BombB)
	self.BombB = BombB
	local BombA = CoD.codcasterBombA.new(f1_arg0, f1_arg1, 0, 0, 155.5, 215.5, 0, 0, -1, 59)
	self:addElement(BombA)
	self.BombA = BombA
	local BombA2 = CoD.codcasterBombA.new(f1_arg0, f1_arg1, 0, 0, 155.5, 215.5, 0, 0, -1, 59)
	self:addElement(BombA2)
	self.BombA2 = BombA2
	local BombB2 = CoD.codcasterBombB.new(f1_arg0, f1_arg1, 0, 0, 196.5, 256.5, 0, 0, -1, 59)
	self:addElement(BombB2)
	self.BombB2 = BombB2
	local glow = LUI.UIImage.new(0.5, 0.5, -16, 16, 0.5, 0.5, -16, 16)
	glow:setAlpha(0)
	glow:setImage(RegisterImage(@"uie_codcaster_objectifstatusglow"))
	self:addElement(glow)
	self.glow = glow
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "BombA",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "HUDItems.codcaster.BombA", 1)
			end,
		},
		{
			stateName = "BombB",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "HUDItems.codcaster.BombB", 1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["HUDItems.codcaster.BombA"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "HUDItems.codcaster.BombA",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["HUDItems.codcaster.BombB"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "HUDItems.codcaster.BombB",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsSelfInState(self, "BombA") then
			PlayClip(self, "ATop", controller)
		elseif IsSelfInState(self, "BombB") then
			PlayClip(self, "topB", controller)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatusSD.__resetProperties = function(f8_arg0)
	f8_arg0.BombA:completeAnimation()
	f8_arg0.BombB:completeAnimation()
	f8_arg0.BombB2:completeAnimation()
	f8_arg0.BombA2:completeAnimation()
	f8_arg0.glow:completeAnimation()
	f8_arg0.BombA:setLeftRight(0, 0, 155.5, 215.5)
	f8_arg0.BombA:setRGB(1, 1, 1)
	f8_arg0.BombA:setAlpha(1)
	f8_arg0.BombA:setScale(1, 1)
	f8_arg0.BombB:setLeftRight(0, 0, 196.5, 256.5)
	f8_arg0.BombB:setAlpha(1)
	f8_arg0.BombB:setScale(1, 1)
	f8_arg0.BombB2:setLeftRight(0, 0, 196.5, 256.5)
	f8_arg0.BombB2:setAlpha(1)
	f8_arg0.BombB2:setScale(1, 1)
	f8_arg0.BombA2:setLeftRight(0, 0, 155.5, 215.5)
	f8_arg0.BombA2:setAlpha(1)
	f8_arg0.BombA2:setScale(1, 1)
	f8_arg0.glow:setTopBottom(0.5, 0.5, -16, 16)
	f8_arg0.glow:setAlpha(0)
	f8_arg0.glow:setScale(1, 1)
end
CoD.CodCasterObjectiveStatusSD.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.BombB:completeAnimation()
			f10_arg0.BombB:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BombB)
			f10_arg0.BombA:completeAnimation()
			f10_arg0.BombA:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BombA)
			f10_arg0.BombA2:completeAnimation()
			f10_arg0.BombA2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BombA2)
			f10_arg0.BombB2:completeAnimation()
			f10_arg0.BombB2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BombB2)
		end,
	},
	BombA = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ATop = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_both"])
					f14_arg0:setLeftRight(0, 0, 176, 236)
					f14_arg0:setAlpha(0)
					f14_arg0:setScale(1, 1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.BombB:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f12_arg0.BombB:setLeftRight(0, 0, 186.64, 246.64)
				f12_arg0.BombB:setAlpha(0.52)
				f12_arg0.BombB:setScale(0.8, 0.8)
				f12_arg0.BombB:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BombB:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.BombB:completeAnimation()
			f12_arg0.BombB:setLeftRight(0, 0, 196.5, 256.5)
			f12_arg0.BombB:setAlpha(1)
			f12_arg0.BombB:setScale(1, 1)
			f12_local0(f12_arg0.BombB)
			local f12_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_both"])
					f16_arg0:setLeftRight(0, 0, 176, 236)
					f16_arg0:setScale(1, 1)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.BombA:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f12_arg0.BombA:setLeftRight(0, 0, 165.1, 225.1)
				f12_arg0.BombA:setScale(1.2, 1.2)
				f12_arg0.BombA:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BombA:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f12_arg0.BombA:completeAnimation()
			f12_arg0.BombA:setLeftRight(0, 0, 155, 215)
			f12_arg0.BombA:setRGB(1, 1, 1)
			f12_arg0.BombA:setScale(1, 1)
			f12_local1(f12_arg0.BombA)
			f12_arg0.BombA2:completeAnimation()
			f12_arg0.BombA2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BombA2)
			f12_arg0.BombB2:completeAnimation()
			f12_arg0.BombB2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BombB2)
			local f12_local2 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_out"])
					f18_arg0:setAlpha(0)
					f18_arg0:setScale(1.25, 1.25)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f17_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_ease_both"])
				f17_arg0:setAlpha(1)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f12_arg0.glow:beginAnimation(410)
			f12_arg0.glow:setTopBottom(0.5, 0.5, -19, 13)
			f12_arg0.glow:setAlpha(0)
			f12_arg0.glow:setScale(1, 1)
			f12_arg0.glow:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
			f12_arg0.glow:registerEventHandler("transition_complete_keyframe", f12_local2)
		end,
	},
	BombB = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		topB = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.BombB:completeAnimation()
			f20_arg0.BombB:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.BombB)
			f20_arg0.BombA:completeAnimation()
			f20_arg0.BombA:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.BombA)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_both"])
					f22_arg0:setLeftRight(0, 0, 176, 236)
					f22_arg0:setAlpha(0)
					f22_arg0:setScale(1, 1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.BombA2:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f20_arg0.BombA2:setLeftRight(0, 0, 165.36, 225.36)
				f20_arg0.BombA2:setAlpha(0.52)
				f20_arg0.BombA2:setScale(0.8, 0.8)
				f20_arg0.BombA2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BombA2:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.BombA2:completeAnimation()
			f20_arg0.BombA2:setLeftRight(0, 0, 155.5, 215.5)
			f20_arg0.BombA2:setAlpha(1)
			f20_arg0.BombA2:setScale(1, 1)
			f20_local0(f20_arg0.BombA2)
			local f20_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(210, Enum[@"luitween"][@"luitween_ease_both"])
					f24_arg0:setLeftRight(0, 0, 176, 236)
					f24_arg0:setScale(1, 1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.BombB2:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f20_arg0.BombB2:setLeftRight(0, 0, 186.64, 246.64)
				f20_arg0.BombB2:setScale(1.2, 1.2)
				f20_arg0.BombB2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BombB2:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f20_arg0.BombB2:completeAnimation()
			f20_arg0.BombB2:setLeftRight(0, 0, 196.5, 256.5)
			f20_arg0.BombB2:setScale(1, 1)
			f20_local1(f20_arg0.BombB2)
			local f20_local2 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						f27_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_both"])
						f27_arg0:setAlpha(0)
						f27_arg0:setScale(1.25, 1.25)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
					end
					f26_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_ease_both"])
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f20_arg0.glow:beginAnimation(410)
				f20_arg0.glow:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.glow:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f20_arg0.glow:completeAnimation()
			f20_arg0.glow:setTopBottom(0.5, 0.5, -19, 13)
			f20_arg0.glow:setAlpha(0)
			f20_arg0.glow:setScale(1, 1)
			f20_local2(f20_arg0.glow)
		end,
	},
}
CoD.CodCasterObjectiveStatusSD.__onClose = function(f28_arg0)
	f28_arg0.BombB:close()
	f28_arg0.BombA:close()
	f28_arg0.BombA2:close()
	f28_arg0.BombB2:close()
end
