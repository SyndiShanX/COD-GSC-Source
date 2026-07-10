require("x64:ebfe24f09f3e978")
require("x64:59b8c4dd2a923d8")
require("x64:4306f8a26f77715")
CoD.LaboratoryRegularOffers = InheritFrom(LUI.UIElement)
CoD.LaboratoryRegularOffers.__defaultWidth = 480
CoD.LaboratoryRegularOffers.__defaultHeight = 350
CoD.LaboratoryRegularOffers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryRegularOffers)
	self.id = "LaboratoryRegularOffers"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LaboratoryOffersHeader = CoD.LaboratoryOffersHeader.new(f1_arg0, f1_arg1, 0, 0, -30, 510, 0, 0, -20, 23)
	LaboratoryOffersHeader.Divider.R:setScale(1, 1)
	LaboratoryOffersHeader.Divider.L:setScale(1, 1)
	self:addElement(LaboratoryOffersHeader)
	self.LaboratoryOffersHeader = LaboratoryOffersHeader
	local RegularOffers = LUI.UIList.new(f1_arg0, f1_arg1, 16, 0, nil, false, false, false, false)
	RegularOffers:setLeftRight(0, 0, 0, 482)
	RegularOffers:setTopBottom(0, 0, 62.5, 212.5)
	RegularOffers:setWidgetType(CoD.LaboratoryListItem)
	RegularOffers:setHorizontalCount(3)
	RegularOffers:setSpacing(16)
	RegularOffers:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RegularOffers:setFilter(function(f2_arg0)
		return f2_arg0.specialOffer:get() == false
	end)
	RegularOffers:setDataSource("ZMLaboratoryNPItemList")
	local f1_local3 = RegularOffers
	local TextBox = RegularOffers.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	TextBox(f1_local3, f1_local5["Laboratory.animState"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	f1_local3 = RegularOffers
	TextBox = RegularOffers.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	TextBox(f1_local3, f1_local5["Laboratory.disableInput"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	RegularOffers:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.ZMLaboratoryUtility.ClientScriptNotifyFocusChanged(self, element, f1_arg1, f1_arg0)
		return f5_local0
	end)
	RegularOffers:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RegularOffers, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			ProcessListAction(self, element, controller, menu)
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") then
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			OpenPopup(self, "PurchasePlasma", controller, element:getModel())
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			local f7_local0 = OpenSystemOverlay
			local f7_local1 = self
			local f7_local2 = menu
			local f7_local3 = controller
			local f7_local4 = "NotEnoughNPPopup"
			local f7_local5 = {}
			local f7_local6 = element:getModel()
			f7_local5.npRequired = f7_local6.plasmaPrice:get()
			f7_local0(f7_local1, f7_local2, f7_local3, f7_local4, f7_local5)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(RegularOffers)
	self.RegularOffers = RegularOffers
	TextBox = LUI.UIText.new(0, 0, -26, 510, 0, 0, -15.5, 21.5)
	TextBox:setRGB(0.58, 0.85, 1)
	TextBox:setText(LocalizeToUpperString(@"hash_27B562F0618E2CB7"))
	TextBox:setTTF("skorzhen")
	TextBox:setLetterSpacing(3)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	RegularOffers.id = "RegularOffers"
	self.__defaultFocus = RegularOffers
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryRegularOffers.__resetProperties = function(f10_arg0)
	f10_arg0.RegularOffers:completeAnimation()
	f10_arg0.RegularOffers:setAlpha(1)
end
CoD.LaboratoryRegularOffers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.RegularOffers:completeAnimation()
			f12_arg0.RegularOffers:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RegularOffers)
		end,
	},
}
CoD.LaboratoryRegularOffers.__onClose = function(f13_arg0)
	f13_arg0.LaboratoryOffersHeader:close()
	f13_arg0.RegularOffers:close()
end
