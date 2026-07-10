CoD.ScrStk_CombatEfficiencyBackGlow = InheritFrom(LUI.UIElement)
CoD.ScrStk_CombatEfficiencyBackGlow.__defaultWidth = 318
CoD.ScrStk_CombatEfficiencyBackGlow.__defaultHeight = 370
CoD.ScrStk_CombatEfficiencyBackGlow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_CombatEfficiencyBackGlow)
	self.id = "ScrStk_CombatEfficiencyBackGlow"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 0, 0, 318, 0, 0, 0, 370)
	Image0:setRGB(0, 0.46, 1)
	Image0:setImage(RegisterImage(0x5BE416E17DAB33B))
	self:addElement(Image0)
	self.Image0 = Image0
	self:mergeStateConditions({
		{
			stateName = "CombatReady",
			condition = function(menu, element, event)
				return IsSpecificGadgetInUse(f1_arg1, element, "gadget_combat_efficiency")
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
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
CoD.ScrStk_CombatEfficiencyBackGlow.__resetProperties = function(f5_arg0)
	f5_arg0.Image0:completeAnimation()
	f5_arg0.Image0:setAlpha(1)
end
CoD.ScrStk_CombatEfficiencyBackGlow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Image0:completeAnimation()
			f6_arg0.Image0:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Image0)
		end,
	},
	CombatReady = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1790, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
					f9_arg0:setAlpha(0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.Image0:beginAnimation(190, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f7_arg0.Image0:setAlpha(1)
				f7_arg0.Image0:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Image0:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.Image0:completeAnimation()
			f7_arg0.Image0:setAlpha(0)
			f7_local0(f7_arg0.Image0)
		end,
	},
}
