require("x64:868f60ef6139e7d")
require("x64:ce8d57df5286d4a")
require("x64:381a4c321d8728e")
CoD.freeCursorInfoPanel = InheritFrom(LUI.UIElement)
CoD.freeCursorInfoPanel.__defaultWidth = 405
CoD.freeCursorInfoPanel.__defaultHeight = 963
CoD.freeCursorInfoPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorInfoPanel)
	self.id = "freeCursorInfoPanel"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TooltipActionPrompt = CoD.TooltipActionPrompt.new(f1_arg0, f1_arg1, 0, 0, 5, 410, 0, 0, 377, 754)
	TooltipActionPrompt:setAlpha(0)
	TooltipActionPrompt:linkToElementModel(self, nil, false, function(model)
		TooltipActionPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(TooltipActionPrompt)
	self.TooltipActionPrompt = TooltipActionPrompt
	local IdentityPanel = CoD.freeCursorIdentityPanel.new(f1_arg0, f1_arg1, 0, 0, 5, 374, 0, 0, 754, 843)
	IdentityPanel:setAlpha(0)
	IdentityPanel:linkToElementModel(self, nil, false, function(model)
		IdentityPanel:setModel(model, f1_arg1)
	end)
	self:addElement(IdentityPanel)
	self.IdentityPanel = IdentityPanel
	local TooltipFeatureTitle = CoD.TooltipFeatureTitle.new(f1_arg0, f1_arg1, 0, 0, 5, 430, 0, 0, 5, 377)
	TooltipFeatureTitle:linkToElementModel(self, nil, false, function(model)
		TooltipFeatureTitle:setModel(model, f1_arg1)
	end)
	self:addElement(TooltipFeatureTitle)
	self.TooltipFeatureTitle = TooltipFeatureTitle
	self:mergeStateConditions({
		{
			stateName = "FeatureArchetype",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.FEATURE_TITLE)
			end,
		},
		{
			stateName = "ActionPrompt",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.ACTION_PROMPT)
			end,
		},
		{
			stateName = "Identity",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "tooltipArchetype", CoD.FreeCursorUtility.TooltipArchetypes.IDENTITY)
			end,
		},
	})
	self:linkToElementModel(self, "tooltipArchetype", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tooltipArchetype",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.detailedView", function(model)
		local f9_local0 = self
		if IsGamepad(f1_arg1) then
			CoD.FreeCursorUtility.AnimateToVerticalTopLayout(self, f1_arg1, 200)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.detailedViewPC", function(model)
		local f10_local0 = self
		if IsMouseOrKeyboard(f1_arg1) then
			CoD.FreeCursorUtility.AnimateToVerticalTopLayout(self, f1_arg1, 0)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.updated", function(model)
		local f11_local0 = self
		CoD.FreeCursorUtility.AnimateToVerticalTopLayout(self, f1_arg1, 0)
	end)
	TooltipActionPrompt.id = "TooltipActionPrompt"
	IdentityPanel.id = "IdentityPanel"
	TooltipFeatureTitle.id = "TooltipFeatureTitle"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.FreeCursorUtility.UseMaxVisibleChildWidth(self)
	CoD.FreeCursorUtility.UseVisibleChildrenHeight(self)
	SetElementProperty(self.TooltipActionPrompt, "inCompactView", true)
	SetElementProperty(self.TooltipFeatureTitle, "inCompactView", true)
	CoD.FreeCursorUtility.SetCustomPadding(self, f1_arg1, 10, 10, 0, 0)
	return self
end
CoD.freeCursorInfoPanel.__resetProperties = function(f12_arg0)
	f12_arg0.TooltipFeatureTitle:completeAnimation()
	f12_arg0.TooltipActionPrompt:completeAnimation()
	f12_arg0.IdentityPanel:completeAnimation()
	f12_arg0.TooltipFeatureTitle:setAlpha(1)
	f12_arg0.TooltipActionPrompt:setAlpha(0)
	f12_arg0.IdentityPanel:setAlpha(0)
end
CoD.freeCursorInfoPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.TooltipActionPrompt:completeAnimation()
			f13_arg0.TooltipActionPrompt:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.TooltipActionPrompt)
			f13_arg0.TooltipFeatureTitle:completeAnimation()
			f13_arg0.TooltipFeatureTitle:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.TooltipFeatureTitle)
		end,
	},
	FeatureArchetype = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.TooltipFeatureTitle:beginAnimation(150)
				f14_arg0.TooltipFeatureTitle:setAlpha(1)
				f14_arg0.TooltipFeatureTitle:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.TooltipFeatureTitle:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.TooltipFeatureTitle:completeAnimation()
			f14_arg0.TooltipFeatureTitle:setAlpha(0.01)
			f14_local0(f14_arg0.TooltipFeatureTitle)
		end,
	},
	ActionPrompt = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.TooltipActionPrompt:completeAnimation()
			f16_arg0.TooltipActionPrompt:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.TooltipActionPrompt)
			f16_arg0.TooltipFeatureTitle:completeAnimation()
			f16_arg0.TooltipFeatureTitle:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TooltipFeatureTitle)
		end,
	},
	Identity = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.IdentityPanel:completeAnimation()
			f17_arg0.IdentityPanel:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.IdentityPanel)
			f17_arg0.TooltipFeatureTitle:completeAnimation()
			f17_arg0.TooltipFeatureTitle:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TooltipFeatureTitle)
		end,
	},
}
CoD.freeCursorInfoPanel.__onClose = function(f18_arg0)
	f18_arg0.TooltipActionPrompt:close()
	f18_arg0.IdentityPanel:close()
	f18_arg0.TooltipFeatureTitle:close()
end
