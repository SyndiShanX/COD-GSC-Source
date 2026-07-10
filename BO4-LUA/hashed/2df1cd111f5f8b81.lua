CoD.PC_Korea_Event_Day_Progression = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Day_Progression.__defaultWidth = 112
CoD.PC_Korea_Event_Day_Progression.__defaultHeight = 112
CoD.PC_Korea_Event_Day_Progression.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Day_Progression)
	self.id = "PC_Korea_Event_Day_Progression"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EmptyStarImage = LUI.UIImage.new(0.5, 0.5, -48, 48, 0.5, 0.5, -53, 43)
	EmptyStarImage:setRGB(0.8, 0.8, 0.8)
	EmptyStarImage:setImage(RegisterImage(0x348714DC6D56380))
	self:addElement(EmptyStarImage)
	self.EmptyStarImage = EmptyStarImage
	local StarImage = LUI.UIImage.new(0.5, 0.5, -48, 48, 0.5, 0.5, -53, 43)
	StarImage:setAlpha(0)
	StarImage:setImage(RegisterImage(0x78D95A993908FDE))
	StarImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x98A2728B4675FB5))
	StarImage:setShaderVector(0, 0, 0, 0, 0)
	StarImage:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(StarImage)
	self.StarImage = StarImage
	local ReceiveStar = LUI.UIElement.new(0, 0, 40, 72, 0, 0, 112, 144)
	self:addElement(ReceiveStar)
	self.ReceiveStar = ReceiveStar
	self:mergeStateConditions({
		{
			stateName = "ReceiveStar",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCompleted")
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showCompletedAnimation")
					if f2_local0 then
						f2_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventCurrentDayProgression.showStarCompletedAnimation")
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCompleted")
			end,
		},
		{
			stateName = "Failed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isFailed")
			end,
		},
	})
	self:linkToElementModel(self, "isCompleted", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isCompleted",
		})
	end)
	self:linkToElementModel(self, "showCompletedAnimation", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showCompletedAnimation",
		})
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["PCKoreaEventCurrentDayProgression.showStarCompletedAnimation"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "PCKoreaEventCurrentDayProgression.showStarCompletedAnimation",
		})
	end, false)
	self:linkToElementModel(self, "isFailed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isFailed",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_Event_Day_Progression.__resetProperties = function(f9_arg0)
	f9_arg0.EmptyStarImage:completeAnimation()
	f9_arg0.ReceiveStar:completeAnimation()
	f9_arg0.StarImage:completeAnimation()
	f9_arg0.EmptyStarImage:setAlpha(1)
	f9_arg0.ReceiveStar:setPlaySoundDirect(false)
	f9_arg0.StarImage:setRGB(1, 1, 1)
	f9_arg0.StarImage:setAlpha(0)
	f9_arg0.StarImage:setScale(1, 1)
	f9_arg0.StarImage:setShaderVector(0, 0, 0, 0, 0)
	f9_arg0.StarImage:setShaderVector(1, -46.8, 0, 0, 0)
end
CoD.PC_Korea_Event_Day_Progression.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.EmptyStarImage:completeAnimation()
			f10_arg0.EmptyStarImage:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.EmptyStarImage)
		end,
	},
	ReceiveStar = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								f16_arg0:beginAnimation(1120)
								f16_arg0:setShaderVector(0, 1, 0, 0, 0)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
							end
							f15_arg0:beginAnimation(340)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(89)
						f14_arg0:setScale(1, 1)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(9)
					f13_arg0:setAlpha(1)
					f13_arg0:setScale(1.27, 1.27)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f12_arg0:beginAnimation(260)
				f12_arg0:setAlpha(0.96)
				f12_arg0:setScale(1.3, 1.3)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.StarImage:beginAnimation(3000)
			f11_arg0.StarImage:setRGB(1, 1, 1)
			f11_arg0.StarImage:setAlpha(0)
			f11_arg0.StarImage:setScale(0.1, 0.1)
			f11_arg0.StarImage:setShaderVector(0, 0, 0, 0, 0)
			f11_arg0.StarImage:setShaderVector(1, -46.8, 0, 0, 0)
			f11_arg0.StarImage:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.StarImage:registerEventHandler("transition_complete_keyframe", f11_local0)
			local f11_local1 = function(f17_arg0)
				f11_arg0.ReceiveStar:beginAnimation(3000)
				f11_arg0.ReceiveStar:setPlaySoundDirect(true)
				f11_arg0.ReceiveStar:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ReceiveStar:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("uin_igr_receivestar", f11_arg1)
					f11_arg0.clipFinished(element, event)
				end)
			end
			f11_arg0.ReceiveStar:completeAnimation()
			f11_arg0.ReceiveStar:setPlaySoundDirect(false)
			f11_local1(f11_arg0.ReceiveStar)
		end,
	},
	Completed = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(990)
					f21_arg0:setShaderVector(0, 1.17, 0, 0, 0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.StarImage:beginAnimation(2650)
				f19_arg0.StarImage:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.StarImage:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.StarImage:completeAnimation()
			f19_arg0.StarImage:setRGB(1, 1, 1)
			f19_arg0.StarImage:setAlpha(1)
			f19_arg0.StarImage:setShaderVector(0, -0.06, 0, 0, 0)
			f19_arg0.StarImage:setShaderVector(1, -46.8, 0, 0, 0)
			f19_local0(f19_arg0.StarImage)
			f19_arg0.nextClip = "DefaultClip"
		end,
	},
	Failed = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.EmptyStarImage:completeAnimation()
			f22_arg0.EmptyStarImage:setAlpha(0.5)
			f22_arg0.clipFinished(f22_arg0.EmptyStarImage)
			f22_arg0.StarImage:completeAnimation()
			f22_arg0.StarImage:setRGB(0.8, 0.8, 0.8)
			f22_arg0.clipFinished(f22_arg0.StarImage)
		end,
	},
}
