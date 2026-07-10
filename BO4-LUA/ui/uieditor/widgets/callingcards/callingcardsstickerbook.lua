require("x64:53d782d70c0c790")
require("x64:5e92c71fe0e5747")
require("x64:79fe6ac43673588")
require("x64:76f82c814686c59")
require("x64:c438d75d63d852f")
require("x64:38c11a77e96e48c")
local PostLoadFunc = function(self, controller)
	self:registerEventHandler("update_tier_list", function(element, event)
		element.CallingCardProfiler.TierList:updateDataSource()
	end)
end
CoD.CallingCardsStickerbook = InheritFrom(LUI.UIElement)
CoD.CallingCardsStickerbook.__defaultWidth = 1696
CoD.CallingCardsStickerbook.__defaultHeight = 850
CoD.CallingCardsStickerbook.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f3_arg1, "hudItems.callingCardProfilingType", "default")
	CoD.BaseUtility.InitControllerModelIfNotSet(f3_arg1, "hudItems.evalEquippedCard", 0)
	self:setClass(CoD.CallingCardsStickerbook)
	self.id = "CallingCardsStickerbook"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f3_arg0:addElementToPendingUpdateStateList(self)
	local CardGrid = LUI.UIList.new(f3_arg0, f3_arg1, 20, 0, nil, true, false, false, false)
	CardGrid:setLeftRight(0, 0, 32, 1152)
	CardGrid:setTopBottom(0.5, 0.5, -375, 375)
	CardGrid:setWidgetType(CoD.CallingCards_CardWidget)
	CardGrid:setHorizontalCount(3)
	CardGrid:setVerticalCount(7)
	CardGrid:setSpacing(20)
	CardGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CardGrid:setVerticalCounter(CoD.verticalCounter)
	CardGrid:setDataSource("CallingCardsSorted")
	CardGrid:linkToElementModel(CardGrid, "isLocked", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	CardGrid:linkToElementModel(CardGrid, "trialLocked", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	CardGrid:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.ChallengesUtility.UpdateCallingCardProfilerType(f3_arg1, element)
		return f6_local0
	end)
	CardGrid:registerEventHandler("list_item_lose_focus", function(element, event)
		local f7_local0 = nil
		CoD.BreadcrumbUtility.SetCallingCardsAsOld(f3_arg0, element, f3_arg1)
		return f7_local0
	end)
	CardGrid:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f3_arg0:AddButtonCallbackFunction(CardGrid, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isLocked") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CallingCards_SetPlayerBackground(menu, element, controller)
			ForceNotifyModel(controller, "hudItems.evalEquippedCard")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "isLocked") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CardGrid)
	self.CardGrid = CardGrid
	local TitleBG = CoD.Challenges_FrameWidget_TitleBackground.new(f3_arg0, f3_arg1, 0, 0, 1152, 1685, 0, 0, 31, 709)
	TitleBG.HeaderStripeBot:setAlpha(0.5)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local CallingCardProfiler = CoD.Challenges_CallingCardProfiler.new(f3_arg0, f3_arg1, 1, 1, -534.5, -9.5, 0, 0, 50, 774)
	self:addElement(CallingCardProfiler)
	self.CallingCardProfiler = CallingCardProfiler
	local CallingCardProfilerGlobal = CoD.ChallengesCallingCardProfilerGlobal.new(f3_arg0, f3_arg1, 1, 1, -534.5, -9.5, 0, 0, 50, 774)
	self:addElement(CallingCardProfilerGlobal)
	self.CallingCardProfilerGlobal = CallingCardProfilerGlobal
	local SelfIdentityBadgePreview = CoD.SelfIdentityBadgePreview.new(f3_arg0, f3_arg1, 0, 0, 1161.5, 1685.5, 0, 0, 710, 800)
	SelfIdentityBadgePreview:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f3_arg1, "trialLocked")
			end,
		},
	})
	SelfIdentityBadgePreview:linkToElementModel(SelfIdentityBadgePreview, "trialLocked", true, function(model)
		f3_arg0:updateElementState(SelfIdentityBadgePreview, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	self:addElement(SelfIdentityBadgePreview)
	self.SelfIdentityBadgePreview = SelfIdentityBadgePreview
	CallingCardProfiler:linkToElementModel(CardGrid, nil, false, function(model)
		CallingCardProfiler:setModel(model, f3_arg1)
	end)
	CallingCardProfilerGlobal:linkToElementModel(CardGrid, nil, false, function(model)
		CallingCardProfilerGlobal:setModel(model, f3_arg1)
	end)
	SelfIdentityBadgePreview:linkToElementModel(CardGrid, nil, false, function(model)
		SelfIdentityBadgePreview:setModel(model, f3_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "ProfilingGlobalCard",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f3_arg1, "hudItems.callingCardProfilingType", "global")
			end,
		},
	})
	local f3_local6 = self
	local f3_local7 = self.subscribeToModel
	local f3_local8 = Engine[0x4DF5CFBC1771947](f3_arg1)
	f3_local7(f3_local6, f3_local8["hudItems.callingCardProfilingType"], function(f17_arg0)
		f3_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f17_arg0:get(),
			modelName = "hudItems.callingCardProfilingType",
		})
	end, false)
	self.__on_menuOpened_self = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
		local f18_local0 = self
		if IsPC() and HasProperty(f18_arg2, "callingCardShowcaseSlot") then
			CoD.PCUtility.LockUIShortcutInput(f18_arg2, f18_arg1)
		end
	end
	f3_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	CardGrid.id = "CardGrid"
	CallingCardProfiler.id = "CallingCardProfiler"
	CallingCardProfilerGlobal.id = "CallingCardProfilerGlobal"
	SelfIdentityBadgePreview.id = "SelfIdentityBadgePreview"
	self.__defaultFocus = CardGrid
	self.__on_close_removeOverrides = function()
		f3_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.CallingCardsStickerbook.__resetProperties = function(f20_arg0)
	f20_arg0.CallingCardProfilerGlobal:completeAnimation()
	f20_arg0.CallingCardProfiler:completeAnimation()
	f20_arg0.CallingCardProfilerGlobal:setAlpha(1)
	f20_arg0.CallingCardProfiler:setAlpha(1)
end
CoD.CallingCardsStickerbook.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.CallingCardProfilerGlobal:completeAnimation()
			f21_arg0.CallingCardProfilerGlobal:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CallingCardProfilerGlobal)
		end,
	},
	ProfilingGlobalCard = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.CallingCardProfiler:completeAnimation()
			f22_arg0.CallingCardProfiler:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CallingCardProfiler)
		end,
	},
}
CoD.CallingCardsStickerbook.__onClose = function(f23_arg0)
	f23_arg0.__on_close_removeOverrides()
	f23_arg0.CallingCardProfiler:close()
	f23_arg0.CallingCardProfilerGlobal:close()
	f23_arg0.SelfIdentityBadgePreview:close()
	f23_arg0.CardGrid:close()
	f23_arg0.TitleBG:close()
end
