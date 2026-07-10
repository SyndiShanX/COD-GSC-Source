require("x64:f6482b855bfca9f")
CoD.CategoryHeader = InheritFrom(LUI.UIElement)
CoD.CategoryHeader.__defaultWidth = 102
CoD.CategoryHeader.__defaultHeight = 20
CoD.CategoryHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 6, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CategoryHeader)
	self.id = "CategoryHeader"
	self.soundSet = "CAC"
	self.anyChildUsesUpdateState = true
	local header = LUI.UIText.new(0, 0, 0, 75, 0.5, 0.5, -8, 8)
	header:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_463E51BFF17859F1"))
	header:setTTF("ttmussels_regular")
	header:setLetterSpacing(3.5)
	header:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(header)
	self.header = header
	local newIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 0, 0, 81, 99, 0.5, 0.5, -9, 9)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = IsLive()
				if f2_local0 then
					if not IsInGame() then
						f2_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local f1_local3 = newIcon
	local f1_local4 = newIcon.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f3_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local3 = newIcon
	f1_local4 = newIcon.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	newIcon:linkToElementModel(self, nil, false, function(model)
		newIcon:setModel(model, f1_arg1)
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CategoryHeader.__onClose = function(f7_arg0)
	f7_arg0.newIcon:close()
end
