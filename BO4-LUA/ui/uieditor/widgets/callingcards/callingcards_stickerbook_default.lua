require("x64:53d782d70c0c790")
require("x64:5e92c71fe0e5747")
require("x64:38c11a77e96e48c")
CoD.CallingCards_Stickerbook_Default = InheritFrom(LUI.UIElement)
CoD.CallingCards_Stickerbook_Default.__defaultWidth = 1725
CoD.CallingCards_Stickerbook_Default.__defaultHeight = 780
CoD.CallingCards_Stickerbook_Default.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Stickerbook_Default)
	self.id = "CallingCards_Stickerbook_Default"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local CallingCardGrid = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, true, false, false, false)
	CallingCardGrid:setLeftRight(0, 0, 15, 1125)
	CallingCardGrid:setTopBottom(0, 0, 24, 744)
	CallingCardGrid:setWidgetType(CoD.CallingCards_CardWidget)
	CallingCardGrid:setHorizontalCount(3)
	CallingCardGrid:setVerticalCount(7)
	CallingCardGrid:setSpacing(15)
	CallingCardGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CallingCardGrid:setVerticalCounter(CoD.verticalCounter)
	CallingCardGrid:setDataSource("CallingCardsDefault")
	CallingCardGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		if IsElementInState(element, "New") then
			CoD.BreadcrumbUtility.SetCallingCardsAsOld(f1_arg0, element, f1_arg1)
		end
		return f2_local0
	end)
	CallingCardGrid:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CallingCardGrid, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsElementInState(element, "Locked") then
			CallingCards_SetPlayerBackground(menu, element, controller)
			PlaySoundSetSound(self, "action")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsElementInState(element, "Locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CallingCardGrid)
	self.CallingCardGrid = CallingCardGrid
	local CallingCardProfiler = CoD.Challenges_CallingCardProfiler.new(f1_arg0, f1_arg1, 1, 1, -568.5, -43.5, 0, 1, 21, -33)
	CallingCardProfiler:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "LockedOneTierNoXP",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "LockedOneTier",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local3 = CallingCardProfiler
	local f1_local4 = CallingCardProfiler.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.callingCardProfilingType"], function(f9_arg0)
		f1_arg0:updateElementState(CallingCardProfiler, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.callingCardProfilingType",
		})
	end, false)
	CallingCardProfiler:linkToElementModel(CallingCardProfiler, "isLocked", true, function(model)
		f1_arg0:updateElementState(CallingCardProfiler, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	CallingCardProfiler:linkToElementModel(CallingCardProfiler, "isBMClassified", true, function(model)
		f1_arg0:updateElementState(CallingCardProfiler, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMClassified",
		})
	end)
	self:addElement(CallingCardProfiler)
	self.CallingCardProfiler = CallingCardProfiler
	CallingCardProfiler:linkToElementModel(CallingCardGrid, nil, false, function(model)
		CallingCardProfiler:setModel(model, f1_arg1)
	end)
	CallingCardGrid.id = "CallingCardGrid"
	CallingCardProfiler.id = "CallingCardProfiler"
	self.__defaultFocus = CallingCardGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Stickerbook_Default.__onClose = function(f13_arg0)
	f13_arg0.CallingCardProfiler:close()
	f13_arg0.CallingCardGrid:close()
end
