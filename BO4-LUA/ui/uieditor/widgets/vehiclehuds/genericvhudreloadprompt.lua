CoD.genericVHUDReloadPrompt = InheritFrom(LUI.UIElement)
CoD.genericVHUDReloadPrompt.__defaultWidth = 526
CoD.genericVHUDReloadPrompt.__defaultHeight = 37
CoD.genericVHUDReloadPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUDReloadPrompt)
	self.id = "genericVHUDReloadPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReloadingText = LUI.UIText.new(0, 1, 0, 0, 1, 2, -10, -10)
	ReloadingText:setText(LocalizeToUpperString(@"hash_73C4EEC8614F780F"))
	ReloadingText:setTTF("ttmussels_regular")
	ReloadingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ReloadingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ReloadingText)
	self.ReloadingText = ReloadingText
	self:mergeStateConditions({
		{
			stateName = "Reloading",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showAmmo") and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "ammoReloading", 1)
			end,
		},
	})
	self:linkToElementModel(self, "showAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showAmmo",
		})
	end)
	self:linkToElementModel(self, "ammoReloading", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoReloading",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUDReloadPrompt.__resetProperties = function(f5_arg0)
	f5_arg0.ReloadingText:completeAnimation()
	f5_arg0.ReloadingText:setTopBottom(1, 2, -10, -10)
	f5_arg0.ReloadingText:setAlpha(1)
end
CoD.genericVHUDReloadPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ReloadingText:completeAnimation()
			f6_arg0.ReloadingText:setTopBottom(0.5, 0.5, -18.5, 18.5)
			f6_arg0.ReloadingText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ReloadingText)
		end,
	},
	Reloading = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(500)
					f9_arg0:setAlpha(0.5)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.ReloadingText:beginAnimation(500)
				f7_arg0.ReloadingText:setAlpha(1)
				f7_arg0.ReloadingText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ReloadingText:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.ReloadingText:completeAnimation()
			f7_arg0.ReloadingText:setAlpha(0.5)
			f7_local0(f7_arg0.ReloadingText)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
}
