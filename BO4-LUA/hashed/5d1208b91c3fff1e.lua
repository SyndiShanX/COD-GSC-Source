CoD.HealthDOT = InheritFrom(LUI.UIElement)
CoD.HealthDOT.__defaultWidth = 100
CoD.HealthDOT.__defaultHeight = 28
CoD.HealthDOT.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthDOT)
	self.id = "HealthDOT"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local damage = LUI.UIText.new(0, 0, 0, 100, 0, 0, 0, 26)
	damage:setRGB(0.94, 0.07, 0.09)
	damage:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_18841A02137AEEDE"))
	damage:setTTF("0arame_mono_stencil")
	damage:setLetterSpacing(2)
	damage:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	damage:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(damage)
	self.damage = damage
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f2_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"damage_over_time") then
			CoD.HUDUtility.SetDOTDamage(self.damage, model, @"hash_18841A02137AEEDE")
			PlayClip(self, "Damaged", f1_arg1)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HealthDOT.__resetProperties = function(f3_arg0)
	f3_arg0.damage:completeAnimation()
	f3_arg0.damage:setLeftRight(0, 0, 0, 100)
	f3_arg0.damage:setTopBottom(0, 0, 0, 26)
	f3_arg0.damage:setAlpha(1)
end
CoD.HealthDOT.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.damage:completeAnimation()
			f4_arg0.damage:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.damage)
		end,
		Damaged = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(99)
						f8_arg0:setTopBottom(0, 0, 33, 61)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(200)
					f7_arg0:setTopBottom(0, 0, 22, 50)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.damage:beginAnimation(100)
				f5_arg0.damage:setAlpha(1)
				f5_arg0.damage:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.damage:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.damage:completeAnimation()
			f5_arg0.damage:setLeftRight(0, 0, 0, 100)
			f5_arg0.damage:setTopBottom(0, 0, 0, 28)
			f5_arg0.damage:setAlpha(0)
			f5_local0(f5_arg0.damage)
		end,
	},
}
