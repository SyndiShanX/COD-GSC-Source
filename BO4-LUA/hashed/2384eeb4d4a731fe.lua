require("x64:6947112378e931b")
require("x64:3d9024ee4cc688b")
CoD.WZObituaryCalloutContainer = InheritFrom(LUI.UIElement)
CoD.WZObituaryCalloutContainer.__defaultWidth = 280
CoD.WZObituaryCalloutContainer.__defaultHeight = 30
CoD.WZObituaryCalloutContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.WZObituaryCalloutContainer)
	self.id = "WZObituaryCalloutContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StyleText = CoD.WZObituaryCalloutContainerStyle.new(f1_arg0, f1_arg1, 0, 0, -135, 415, 0, 0, 0, 26)
	StyleText:linkToElementModel(self, nil, false, function(model)
		StyleText:setModel(model, f1_arg1)
	end)
	self:addElement(StyleText)
	self.StyleText = StyleText
	local ContribText = CoD.WZObituaryCalloutContainerDamageDealt.new(f1_arg0, f1_arg1, 0.5, 0.5, -110.5, 110.5, 0.5, 0.5, 15, 41)
	ContribText:linkToElementModel(self, nil, false, function(model)
		ContribText:setModel(model, f1_arg1)
	end)
	self:addElement(ContribText)
	self.ContribText = ContribText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "style", 0)
			end,
		},
		{
			stateName = "HiddenSquadKilled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "style", 4)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:linkToElementModel(self, "style", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "style",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZObituaryCalloutContainer.__resetProperties = function(f8_arg0)
	f8_arg0.ContribText:completeAnimation()
	f8_arg0.StyleText:completeAnimation()
	f8_arg0.ContribText:setTopBottom(0.5, 0.5, 15, 41)
	f8_arg0.ContribText:setAlpha(1)
	f8_arg0.StyleText:setTopBottom(0, 0, 0, 26)
	f8_arg0.StyleText:setAlpha(1)
end
CoD.WZObituaryCalloutContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.StyleText:completeAnimation()
			f10_arg0.StyleText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.StyleText)
			f10_arg0.ContribText:completeAnimation()
			f10_arg0.ContribText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ContribText)
		end,
	},
	HiddenSquadKilled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.StyleText:completeAnimation()
			f11_arg0.StyleText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.StyleText)
			f11_arg0.ContribText:completeAnimation()
			f11_arg0.ContribText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ContribText)
		end,
	},
	PC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.StyleText:completeAnimation()
			f12_arg0.StyleText:setTopBottom(0, 0, -21, 5)
			f12_arg0.clipFinished(f12_arg0.StyleText)
			f12_arg0.ContribText:completeAnimation()
			f12_arg0.ContribText:setTopBottom(0.5, 0.5, -6, 20)
			f12_arg0.clipFinished(f12_arg0.ContribText)
		end,
	},
}
CoD.WZObituaryCalloutContainer.__onClose = function(f13_arg0)
	f13_arg0.StyleText:close()
	f13_arg0.ContribText:close()
end
