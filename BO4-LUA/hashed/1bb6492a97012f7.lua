CoD.Hud_ZM_PlayerDeadMarker = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_PlayerDeadMarker.__defaultWidth = 256
CoD.Hud_ZM_PlayerDeadMarker.__defaultHeight = 128
CoD.Hud_ZM_PlayerDeadMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_PlayerDeadMarker)
	self.id = "Hud_ZM_PlayerDeadMarker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Disabled = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Disabled:setImage(RegisterImage(0x69BEFB7E55FBA50))
	self:addElement(Disabled)
	self.Disabled = Disabled
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dead")
			end,
		},
	})
	self:linkToElementModel(self, "dead", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dead",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_PlayerDeadMarker.__resetProperties = function(f4_arg0)
	f4_arg0.Disabled:completeAnimation()
	f4_arg0.Disabled:setAlpha(1)
end
CoD.Hud_ZM_PlayerDeadMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Disabled:completeAnimation()
			f5_arg0.Disabled:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Disabled)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Disabled:completeAnimation()
			f6_arg0.Disabled:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Disabled)
		end,
	},
}
