CoD.WZTeamPlayerIsTarget = InheritFrom(LUI.UIElement)
CoD.WZTeamPlayerIsTarget.__defaultWidth = 30
CoD.WZTeamPlayerIsTarget.__defaultHeight = 30
CoD.WZTeamPlayerIsTarget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamPlayerIsTarget)
	self.id = "WZTeamPlayerIsTarget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BountyIndicator = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	BountyIndicator:setImage(RegisterImage(@"uie_ui_hud_wz_hud_bounty"))
	self:addElement(BountyIndicator)
	self.BountyIndicator = BountyIndicator
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dead") then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isSpectreRisingTarget")
				else
					f2_local0 = false
				end
				return f2_local0
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
	self:linkToElementModel(self, "isSpectreRisingTarget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isSpectreRisingTarget",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamPlayerIsTarget.__resetProperties = function(f5_arg0)
	f5_arg0.BountyIndicator:completeAnimation()
	f5_arg0.BountyIndicator:setAlpha(1)
end
CoD.WZTeamPlayerIsTarget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.BountyIndicator:completeAnimation()
			f6_arg0.BountyIndicator:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BountyIndicator)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
