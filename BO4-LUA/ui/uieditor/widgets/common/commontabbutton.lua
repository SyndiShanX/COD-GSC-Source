require("x64:eeb1847d838c6b1")
require("x64:dbb04b55fa27ac6")
CoD.CommonTabButton = InheritFrom(LUI.UIElement)
CoD.CommonTabButton.__defaultWidth = 234
CoD.CommonTabButton.__defaultHeight = 35
CoD.CommonTabButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonTabButton)
	self.id = "CommonTabButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local internal = CoD.CACTabButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	internal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(self, f1_arg1)
			end,
		},
	})
	local f1_local2 = internal
	local newIcon = internal.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	newIcon(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(internal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	internal:linkToElementModel(internal, "disabled", true, function(model)
		f1_arg0:updateElementState(internal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	internal:linkToElementModel(self, nil, false, function(model)
		internal:setModel(model, f1_arg1)
	end)
	internal:linkToElementModel(self, nil, false, function(model)
		internal.RestrictedIcon:setModel(model, f1_arg1)
	end)
	internal:linkToElementModel(self, "tabName", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			internal.Text:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	internal:linkToElementModel(self, "tabName", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			internal.TextFocus:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	self:addElement(internal)
	self.internal = internal
	newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, 212, 230, 0.5, 0.5, -23.5, -5.5)
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
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			newIcon:setModel(f11_local0, f1_arg1)
		end
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	internal.id = "internal"
	self.__defaultFocus = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonTabButton.__onClose = function(f12_arg0)
	f12_arg0.internal:close()
	f12_arg0.newIcon:close()
end
