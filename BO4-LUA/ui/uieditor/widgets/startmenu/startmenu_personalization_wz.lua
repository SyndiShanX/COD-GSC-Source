require("x64:abbd658ce01510c")
require("x64:185563fab2ddf96")
CoD.StartMenu_Personalization_WZ = InheritFrom(LUI.UIElement)
CoD.StartMenu_Personalization_WZ.__defaultWidth = 1920
CoD.StartMenu_Personalization_WZ.__defaultHeight = 780
CoD.StartMenu_Personalization_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Personalization_WZ)
	self.id = "StartMenu_Personalization_WZ"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameWidget = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	FrameWidget:setLeftRight(0.5, 0.5, -71, 835)
	FrameWidget:setTopBottom(0.5, 0.5, -367, 433)
	LUI.OverrideFunction_CallOriginalFirst(FrameWidget, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "CommonInformationFrame")
	end)
	LUI.OverrideFunction_CallOriginalFirst(FrameWidget, "createFrameWidget", function(element, controller)
		CoD.PlayerRoleUtility.SetWZStartMenuPersonalizationCustomLeftFocus(element, self.options)
	end)
	self:addElement(FrameWidget)
	self.FrameWidget = FrameWidget
	local WZCharacterInfoContainer = CoD.WZCharacterInfoContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -683, -290, 0.5, 0.5, 71, 231)
	WZCharacterInfoContainer.CharacterSelectionCharacterInfo.CharacterFullName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	WZCharacterInfoContainer:subscribeToGlobalModel(f1_arg1, "WZCharacterInfo", "infoModel", function(model)
		CoD.WZUtility.SetElementModelToControllerModelValue(WZCharacterInfoContainer, f1_arg1, "WZCharacterInfo.infoModel")
	end)
	self:addElement(WZCharacterInfoContainer)
	self.WZCharacterInfoContainer = WZCharacterInfoContainer
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 13, 0, nil, false, false, false, false)
	options:setLeftRight(0.5, 0.5, -683, -290)
	options:setTopBottom(0.5, 0.5, -336, -103)
	options:setWidgetType(CoD.SpecialistPersonalizationButtonOption)
	options:setVerticalCount(3)
	options:setSpacing(13)
	options:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	options:setDataSource("WZCharacterCategories")
	options:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local4 = options
	local f1_local5 = options.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	options:registerEventHandler("input_source_changed", function(element, event)
		local f7_local0 = nil
		CoD.GridAndListUtility.SetListActiveOnFocusPCBehavior(element, f1_arg1)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetCurrentElementAsActive(self, element, controller)
			ProcessListAction(self, element, controller, menu)
			return true
		else
			ProcessListAction(self, element, controller, menu)
			return true
		end
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(options)
	self.options = options
	FrameWidget:linkToElementModel(options, nil, false, function(model)
		FrameWidget:setModel(model, f1_arg1)
	end)
	FrameWidget:linkToElementModel(options, "personalizeFrameWidget", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			FrameWidget:changeFrameWidget(f12_local0)
		end
	end)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.StartMenuBreadcrumbs.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6["personalization.breadcrumbCount"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "StartMenuBreadcrumbs", "personalization.breadcrumbCount", 0) and not IsPC() then
			CoD.BreadcrumbUtility.ClearAllPersonalizationBreadcrumbs(menu, controller)
			UpdateElementState(self, "specialists", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "StartMenuBreadcrumbs", "personalization.breadcrumbCount", 0) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_65619D8212EDA599", nil, nil)
			return true
		else
			return false
		end
	end, false)
	FrameWidget.id = "FrameWidget"
	options.id = "options"
	self.__defaultFocus = FrameWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	f1_local5 = options
	CoD.GridAndListUtility.SetListActiveOnFocusPCBehavior(f1_local5, f1_arg1)
	CoD.GridAndListUtility.ActivateListPCSelectionBehavior(f1_local5)
	return self
end
CoD.StartMenu_Personalization_WZ.__resetProperties = function(f16_arg0)
	f16_arg0.options:completeAnimation()
	f16_arg0.FrameWidget:completeAnimation()
	f16_arg0.WZCharacterInfoContainer:completeAnimation()
	f16_arg0.options:setAlpha(1)
	f16_arg0.FrameWidget:setAlpha(1)
	f16_arg0.WZCharacterInfoContainer:setAlpha(1)
end
CoD.StartMenu_Personalization_WZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(149)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.FrameWidget:beginAnimation(300)
				f17_arg0.FrameWidget:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FrameWidget:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.FrameWidget:completeAnimation()
			f17_arg0.FrameWidget:setAlpha(0)
			f17_local0(f17_arg0.FrameWidget)
			local f17_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(150)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.WZCharacterInfoContainer:beginAnimation(100)
				f17_arg0.WZCharacterInfoContainer:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.WZCharacterInfoContainer:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f17_arg0.WZCharacterInfoContainer:completeAnimation()
			f17_arg0.WZCharacterInfoContainer:setAlpha(0)
			f17_local1(f17_arg0.WZCharacterInfoContainer)
			local f17_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(150)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.options:beginAnimation(50)
				f17_arg0.options:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.options:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f17_arg0.options:completeAnimation()
			f17_arg0.options:setAlpha(0)
			f17_local2(f17_arg0.options)
		end,
	},
}
CoD.StartMenu_Personalization_WZ.__onClose = function(f24_arg0)
	f24_arg0.FrameWidget:close()
	f24_arg0.WZCharacterInfoContainer:close()
	f24_arg0.options:close()
end
