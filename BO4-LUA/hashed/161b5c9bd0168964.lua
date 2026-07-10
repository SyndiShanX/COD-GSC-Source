CoD.SpawnSelectInfoArrow = InheritFrom(LUI.UIElement)
CoD.SpawnSelectInfoArrow.__defaultWidth = 14
CoD.SpawnSelectInfoArrow.__defaultHeight = 8
CoD.SpawnSelectInfoArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectInfoArrow)
	self.id = "SpawnSelectInfoArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpawnWarningArrow03 = LUI.UIImage.new(0, 0, 0, 6, 0, 0, 0, 8)
	SpawnWarningArrow03:setRGB(1, 0, 0)
	SpawnWarningArrow03:setImage(RegisterImage(0xCC0A39499C4FD76))
	self:addElement(SpawnWarningArrow03)
	self.SpawnWarningArrow03 = SpawnWarningArrow03
	local SpawnWarningArrow02 = LUI.UIImage.new(0, 0, 4, 10, 0, 0, 0, 8)
	SpawnWarningArrow02:setRGB(1, 0, 0)
	SpawnWarningArrow02:setImage(RegisterImage(0xCC0A39499C4FD76))
	self:addElement(SpawnWarningArrow02)
	self.SpawnWarningArrow02 = SpawnWarningArrow02
	local SpawnWarningArrow01 = LUI.UIImage.new(0, 0, 8, 14, 0, 0, 0, 8)
	SpawnWarningArrow01:setRGB(1, 0, 0)
	SpawnWarningArrow01:setImage(RegisterImage(0xCC0A39499C4FD76))
	self:addElement(SpawnWarningArrow01)
	self.SpawnWarningArrow01 = SpawnWarningArrow01
	self:mergeStateConditions({
		{
			stateName = "ThreatHigh",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "gamemodeFlags", 2)
			end,
		},
		{
			stateName = "ThreatLow",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "gamemodeFlags", 1)
			end,
		},
		{
			stateName = "Destroyed",
			condition = function(menu, element, event)
				return not CoD.SpawnSelectionUtility.IsSpawnBeaconActive(f1_arg1, element)
			end,
		},
	})
	self:linkToElementModel(self, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnSelectInfoArrow.__resetProperties = function(f7_arg0)
	f7_arg0.SpawnWarningArrow01:completeAnimation()
	f7_arg0.SpawnWarningArrow02:completeAnimation()
	f7_arg0.SpawnWarningArrow03:completeAnimation()
	f7_arg0.SpawnWarningArrow01:setRGB(1, 0, 0)
	f7_arg0.SpawnWarningArrow01:setAlpha(1)
	f7_arg0.SpawnWarningArrow02:setRGB(1, 0, 0)
	f7_arg0.SpawnWarningArrow02:setAlpha(1)
	f7_arg0.SpawnWarningArrow03:setRGB(1, 0, 0)
	f7_arg0.SpawnWarningArrow03:setAlpha(1)
end
CoD.SpawnSelectInfoArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.SpawnWarningArrow03:completeAnimation()
			f8_arg0.SpawnWarningArrow03:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SpawnWarningArrow03)
			f8_arg0.SpawnWarningArrow02:completeAnimation()
			f8_arg0.SpawnWarningArrow02:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SpawnWarningArrow02)
			f8_arg0.SpawnWarningArrow01:completeAnimation()
			f8_arg0.SpawnWarningArrow01:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.SpawnWarningArrow01)
		end,
	},
	ThreatHigh = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(500)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(200)
					f11_arg0:setAlpha(0.2)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.SpawnWarningArrow03:beginAnimation(400)
				f9_arg0.SpawnWarningArrow03:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SpawnWarningArrow03:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.SpawnWarningArrow03:completeAnimation()
			f9_arg0.SpawnWarningArrow03:setRGB(1, 0, 0)
			f9_arg0.SpawnWarningArrow03:setAlpha(0)
			f9_local0(f9_arg0.SpawnWarningArrow03)
			local f9_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(200)
					f14_arg0:setAlpha(0.4)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.SpawnWarningArrow02:beginAnimation(200)
				f9_arg0.SpawnWarningArrow02:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SpawnWarningArrow02:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f9_arg0.SpawnWarningArrow02:completeAnimation()
			f9_arg0.SpawnWarningArrow02:setAlpha(0)
			f9_local1(f9_arg0.SpawnWarningArrow02)
			local f9_local2 = function(f15_arg0)
				f9_arg0.SpawnWarningArrow01:beginAnimation(200)
				f9_arg0.SpawnWarningArrow01:setAlpha(0.6)
				f9_arg0.SpawnWarningArrow01:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SpawnWarningArrow01:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SpawnWarningArrow01:completeAnimation()
			f9_arg0.SpawnWarningArrow01:setAlpha(0)
			f9_local2(f9_arg0.SpawnWarningArrow01)
			f9_arg0.nextClip = "DefaultClip"
		end,
	},
	ThreatLow = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						f19_arg0:beginAnimation(500)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
					end
					f18_arg0:beginAnimation(1000)
					f18_arg0:setAlpha(0.2)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f16_arg0.SpawnWarningArrow03:beginAnimation(2000)
				f16_arg0.SpawnWarningArrow03:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SpawnWarningArrow03:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.SpawnWarningArrow03:completeAnimation()
			f16_arg0.SpawnWarningArrow03:setRGB(0.87, 0.72, 0.14)
			f16_arg0.SpawnWarningArrow03:setAlpha(0)
			f16_local0(f16_arg0.SpawnWarningArrow03)
			local f16_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(1000)
					f21_arg0:setAlpha(0.4)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.SpawnWarningArrow02:beginAnimation(1000)
				f16_arg0.SpawnWarningArrow02:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SpawnWarningArrow02:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f16_arg0.SpawnWarningArrow02:completeAnimation()
			f16_arg0.SpawnWarningArrow02:setRGB(0.87, 0.72, 0.14)
			f16_arg0.SpawnWarningArrow02:setAlpha(0)
			f16_local1(f16_arg0.SpawnWarningArrow02)
			local f16_local2 = function(f22_arg0)
				f16_arg0.SpawnWarningArrow01:beginAnimation(1000)
				f16_arg0.SpawnWarningArrow01:setAlpha(0.6)
				f16_arg0.SpawnWarningArrow01:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SpawnWarningArrow01:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.SpawnWarningArrow01:completeAnimation()
			f16_arg0.SpawnWarningArrow01:setRGB(0.87, 0.72, 0.14)
			f16_arg0.SpawnWarningArrow01:setAlpha(0)
			f16_local2(f16_arg0.SpawnWarningArrow01)
			f16_arg0.nextClip = "DefaultClip"
		end,
	},
	Destroyed = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			f23_arg0.SpawnWarningArrow03:completeAnimation()
			f23_arg0.SpawnWarningArrow03:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f23_arg0.SpawnWarningArrow03:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpawnWarningArrow03)
			f23_arg0.SpawnWarningArrow02:completeAnimation()
			f23_arg0.SpawnWarningArrow02:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f23_arg0.SpawnWarningArrow02:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpawnWarningArrow02)
			f23_arg0.SpawnWarningArrow01:completeAnimation()
			f23_arg0.SpawnWarningArrow01:setRGB(ColorSet.Disabled.r, ColorSet.Disabled.g, ColorSet.Disabled.b)
			f23_arg0.SpawnWarningArrow01:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.SpawnWarningArrow01)
			f23_arg0.nextClip = "DefaultClip"
		end,
	},
}
