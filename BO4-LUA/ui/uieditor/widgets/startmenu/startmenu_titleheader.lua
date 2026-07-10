require("x64:f6482b855bfca9f")
CoD.StartMenu_TitleHeader = InheritFrom(LUI.UIElement)
CoD.StartMenu_TitleHeader.__defaultWidth = 102
CoD.StartMenu_TitleHeader.__defaultHeight = 20
CoD.StartMenu_TitleHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 6, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.StartMenu_TitleHeader)
	self.id = "StartMenu_TitleHeader"
	self.soundSet = "CAC"
	self.anyChildUsesUpdateState = true
	local HeaderText = LUI.UIText.new(0, 0, 0, 102, 0.5, 0.5, -12.5, 12.5)
	HeaderText:setText("")
	HeaderText:setTTF("ttmussels_regular")
	HeaderText:setLetterSpacing(1.5)
	HeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(HeaderText)
	self.HeaderText = HeaderText
	local NewIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 0, 0, 108, 126, 0.5, 0.5, -9, 9)
	NewIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLive() and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	local f1_local3 = NewIcon
	local f1_local4 = NewIcon.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f3_arg0)
		f1_arg0:updateElementState(NewIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local3 = NewIcon
	f1_local4 = NewIcon.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(NewIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	NewIcon:linkToElementModel(NewIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(NewIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	self:addElement(NewIcon)
	self.NewIcon = NewIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_TitleHeader.__onClose = function(f6_arg0)
	f6_arg0.NewIcon:close()
end
