CoD.ReservesRevealDupeIcon = InheritFrom(LUI.UIElement)
CoD.ReservesRevealDupeIcon.__defaultWidth = 20
CoD.ReservesRevealDupeIcon.__defaultHeight = 20
CoD.ReservesRevealDupeIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReservesRevealDupeIcon)
	self.id = "ReservesRevealDupeIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RerollIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RerollIcon:setRGB(0.54, 0.87, 0.31)
	RerollIcon:setImage(RegisterImage(@"hash_7B259D817A83EFDB"))
	self:addElement(RerollIcon)
	self.RerollIcon = RerollIcon
	local RerollIconPulse = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RerollIconPulse:setRGB(0.54, 0.87, 0.31)
	RerollIconPulse:setAlpha(0)
	RerollIconPulse:setImage(RegisterImage(@"hash_7B259D817A83EFDB"))
	RerollIconPulse:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(RerollIconPulse)
	self.RerollIconPulse = RerollIconPulse
	local DupeIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DupeIcon:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	DupeIcon:setImage(RegisterImage(@"hash_F395928C19E9B99"))
	self:addElement(DupeIcon)
	self.DupeIcon = DupeIcon
	local DupeIconPulse = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DupeIconPulse:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	DupeIconPulse:setAlpha(0)
	DupeIconPulse:setImage(RegisterImage(@"hash_F395928C19E9B99"))
	DupeIconPulse:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DupeIconPulse)
	self.DupeIconPulse = DupeIconPulse
	self:mergeStateConditions({
		{
			stateName = "Dupe",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dupe")
			end,
		},
		{
			stateName = "Reroll",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "reroll")
			end,
		},
	})
	self:linkToElementModel(self, "dupe", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dupe",
		})
	end)
	self:linkToElementModel(self, "reroll", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reroll",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "DupeMeterPulse", "pulseDupeIcon", function(model)
		if CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "dupe") and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DupeMeterPulse", "pulseDupeIcon") then
			PlayClip(self, "Pulse", f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "DupeMeterPulse", "pulseRerollIcon", function(model)
		if CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "reroll") and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DupeMeterPulse", "pulseRerollIcon") then
			PlayClip(self, "Pulse", f1_arg1)
		end
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReservesRevealDupeIcon.__resetProperties = function(f8_arg0)
	f8_arg0.RerollIcon:completeAnimation()
	f8_arg0.DupeIcon:completeAnimation()
	f8_arg0.DupeIconPulse:completeAnimation()
	f8_arg0.RerollIconPulse:completeAnimation()
	f8_arg0.RerollIcon:setAlpha(1)
	f8_arg0.DupeIcon:setAlpha(1)
	f8_arg0.DupeIconPulse:setAlpha(0)
	f8_arg0.DupeIconPulse:setScale(1, 1)
	f8_arg0.RerollIconPulse:setAlpha(0)
	f8_arg0.RerollIconPulse:setScale(1, 1)
end
CoD.ReservesRevealDupeIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.RerollIcon:completeAnimation()
			f9_arg0.RerollIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RerollIcon)
			f9_arg0.DupeIcon:completeAnimation()
			f9_arg0.DupeIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DupeIcon)
		end,
	},
	Dupe = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.RerollIcon:completeAnimation()
			f10_arg0.RerollIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RerollIcon)
		end,
		Pulse = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.RerollIcon:completeAnimation()
			f11_arg0.RerollIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.RerollIcon)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
					f13_arg0:setAlpha(0)
					f13_arg0:setScale(3, 3)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.DupeIconPulse:beginAnimation(100)
				f11_arg0.DupeIconPulse:setAlpha(1)
				f11_arg0.DupeIconPulse:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DupeIconPulse:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.DupeIconPulse:completeAnimation()
			f11_arg0.DupeIconPulse:setAlpha(0)
			f11_arg0.DupeIconPulse:setScale(1, 1)
			f11_local0(f11_arg0.DupeIconPulse)
		end,
	},
	Reroll = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.DupeIcon:completeAnimation()
			f14_arg0.DupeIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.DupeIcon)
		end,
		Pulse = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(310, Enum[@"luitween"][@"luitween_ease_out"])
					f17_arg0:setAlpha(0)
					f17_arg0:setScale(3, 3)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.RerollIconPulse:beginAnimation(90)
				f15_arg0.RerollIconPulse:setAlpha(1)
				f15_arg0.RerollIconPulse:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.RerollIconPulse:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.RerollIconPulse:completeAnimation()
			f15_arg0.RerollIconPulse:setAlpha(0)
			f15_arg0.RerollIconPulse:setScale(1, 1)
			f15_local0(f15_arg0.RerollIconPulse)
			f15_arg0.DupeIcon:completeAnimation()
			f15_arg0.DupeIcon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DupeIcon)
		end,
	},
}
