require("x64:eeb1847d838c6b1")
require("x64:dbb04b55fa27ac6")
CoD.CACTextTab = InheritFrom(LUI.UIElement)
CoD.CACTextTab.__defaultWidth = 240
CoD.CACTextTab.__defaultHeight = 35
CoD.CACTextTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACTextTab)
	self.id = "CACTextTab"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CACTabButtonInternal = CoD.CACTabButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CACTabButtonInternal:linkToElementModel(self, nil, false, function(model)
		CACTabButtonInternal.RestrictedIcon:setModel(model, f1_arg1)
	end)
	CACTabButtonInternal:linkToElementModel(self, "name", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CACTabButtonInternal.Text:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	CACTabButtonInternal:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CACTabButtonInternal.TextFocus:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(CACTabButtonInternal)
	self.CACTabButtonInternal = CACTabButtonInternal
	local newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, 218, 236, 0.5, 0.5, -26.5, -8.5)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	newIcon:linkToElementModel(self, "breadcrumb", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			newIcon:setModel(f7_local0, f1_arg1)
		end
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrTrue(self, f1_arg1, "available")
			end,
		},
	})
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	CACTabButtonInternal.id = "CACTabButtonInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CACTextTab.__resetProperties = function(f10_arg0)
	f10_arg0.CACTabButtonInternal:completeAnimation()
	f10_arg0.CACTabButtonInternal:setAlpha(1)
end
CoD.CACTextTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		Active = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.CACTabButtonInternal:completeAnimation()
			f12_arg0.CACTabButtonInternal:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.CACTabButtonInternal)
		end,
	},
	Unavailable = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CACTextTab.__onClose = function(f14_arg0)
	f14_arg0.CACTabButtonInternal:close()
	f14_arg0.newIcon:close()
end
