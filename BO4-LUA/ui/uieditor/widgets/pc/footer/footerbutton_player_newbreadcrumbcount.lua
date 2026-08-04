require("ui/uieditor/widgets/cac/newbreadcrumbcount")
CoD.FooterButton_Player_NewBreadcrumbCount = InheritFrom(LUI.UIElement)
CoD.FooterButton_Player_NewBreadcrumbCount.__defaultWidth = 9
CoD.FooterButton_Player_NewBreadcrumbCount.__defaultHeight = 54
CoD.FooterButton_Player_NewBreadcrumbCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButton_Player_NewBreadcrumbCount)
	self.id = "FooterButton_Player_NewBreadcrumbCount"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	local newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, -3, 16, 0, 0, -5, 13)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.ShouldShowTheMenuBreadcrumb(element, f1_arg1)
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
	newIcon:setYRot(180)
	newIcon:setScale(0.85, 0.85)
	self:addElement(newIcon)
	self.newIcon = newIcon
	self:linkToElementModel(self, "height", true, function(model)
		local f4_local0 = self
		SetVerticaListSpacerHeight(self, model)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_Player_NewBreadcrumbCount.__onClose = function(f5_arg0)
	f5_arg0.newIcon:close()
end
