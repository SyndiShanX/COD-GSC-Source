require("x64:ebfe24f09f3e978")
require("x64:59b8c4dd2a923d8")
require("x64:4306f8a26f77715")
CoD.LaboratorySpecialOffers = InheritFrom(LUI.UIElement)
CoD.LaboratorySpecialOffers.__defaultWidth = 480
CoD.LaboratorySpecialOffers.__defaultHeight = 350
CoD.LaboratorySpecialOffers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratorySpecialOffers)
	self.id = "LaboratorySpecialOffers"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialOffers = LUI.UIList.new(f1_arg0, f1_arg1, 16, 0, nil, false, false, false, false)
	SpecialOffers:setLeftRight(0, 0, 0, 482)
	SpecialOffers:setTopBottom(0, 0, 62.5, 212.5)
	SpecialOffers:setWidgetType(CoD.LaboratoryListItem)
	SpecialOffers:setHorizontalCount(3)
	SpecialOffers:setSpacing(16)
	SpecialOffers:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialOffers:setFilter(function(f2_arg0)
		return f2_arg0.specialOffer:get() == true
	end)
	SpecialOffers:setDataSource("ZMLaboratoryNPItemList")
	local LaboratoryOffersHeader = SpecialOffers
	local StoneTiledBacking = SpecialOffers.subscribeToModel
	local TextBox = Engine[0x4DF5CFBC1771947](f1_arg1)
	StoneTiledBacking(LaboratoryOffersHeader, TextBox["Laboratory.animState"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	LaboratoryOffersHeader = SpecialOffers
	StoneTiledBacking = SpecialOffers.subscribeToModel
	TextBox = Engine[0x4DF5CFBC1771947](f1_arg1)
	StoneTiledBacking(LaboratoryOffersHeader, TextBox["Laboratory.disableInput"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	SpecialOffers:registerEventHandler("list_item_gain_focus", function(element, event)
		local f5_local0 = nil
		CoD.ZMLaboratoryUtility.ClientScriptNotifyFocusChanged(self, element, f1_arg1, f1_arg0)
		return f5_local0
	end)
	SpecialOffers:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SpecialOffers, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			ProcessListAction(self, element, controller, menu)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") then
			CoD.ZMLaboratoryUtility.CacheOfferButtonModel(controller, element, menu)
			OpenPopup(self, "PurchasePlasma", controller, element:getModel())
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Laboratory.animState", CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING) and not CoD.ZMLaboratoryUtility.CanPurchase(controller, element) and CoD.ModelUtility.IsModelValueEqualTo(controller, "Laboratory.disableInput", 0) and IsBooleanDvarSet("laboratory_codpoints_enabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(SpecialOffers)
	self.SpecialOffers = SpecialOffers
	StoneTiledBacking = LUI.UIImage.new(0, 0, 0, 480, 0.09, 0.09, -30, 6)
	StoneTiledBacking:setRGB(0.83, 0.11, 0.01)
	StoneTiledBacking:setAlpha(0)
	StoneTiledBacking:setImage(RegisterImage(0x33757173B476ACD))
	StoneTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	StoneTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	StoneTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(StoneTiledBacking)
	self.StoneTiledBacking = StoneTiledBacking
	LaboratoryOffersHeader = CoD.LaboratoryOffersHeader.new(f1_arg0, f1_arg1, 0, 0, -30, 510, 0, 0, -20, 23)
	LaboratoryOffersHeader.Divider.R:setScale(1, 1)
	LaboratoryOffersHeader.Divider.L:setScale(1, 1)
	self:addElement(LaboratoryOffersHeader)
	self.LaboratoryOffersHeader = LaboratoryOffersHeader
	TextBox = LUI.UIText.new(0, 0, -30, 506, 0, 0, -14, 23)
	TextBox:setRGB(0.58, 0.85, 1)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0x715BBA8DDB1B644))
	TextBox:setTTF("skorzhen")
	TextBox:setLetterSpacing(3)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return ListElementHasElements(self.SpecialOffers)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f10_arg1)
	end)
	SpecialOffers.id = "SpecialOffers"
	self.__defaultFocus = SpecialOffers
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratorySpecialOffers.__resetProperties = function(f11_arg0)
	f11_arg0.SpecialOffers:completeAnimation()
	f11_arg0.TextBox:completeAnimation()
	f11_arg0.LaboratoryOffersHeader:completeAnimation()
	f11_arg0.StoneTiledBacking:completeAnimation()
	f11_arg0.SpecialOffers:setAlpha(1)
	f11_arg0.TextBox:setAlpha(1)
	f11_arg0.LaboratoryOffersHeader:setAlpha(1)
	f11_arg0.StoneTiledBacking:setAlpha(0)
end
CoD.LaboratorySpecialOffers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.SpecialOffers:completeAnimation()
			f12_arg0.SpecialOffers:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.SpecialOffers)
			f12_arg0.StoneTiledBacking:completeAnimation()
			f12_arg0.StoneTiledBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.StoneTiledBacking)
			f12_arg0.LaboratoryOffersHeader:completeAnimation()
			f12_arg0.LaboratoryOffersHeader:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.LaboratoryOffersHeader)
			f12_arg0.TextBox:completeAnimation()
			f12_arg0.TextBox:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TextBox)
		end,
	},
	Visible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.SpecialOffers:completeAnimation()
			f13_arg0.SpecialOffers:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.SpecialOffers)
			f13_arg0.StoneTiledBacking:completeAnimation()
			f13_arg0.StoneTiledBacking:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.StoneTiledBacking)
			f13_arg0.LaboratoryOffersHeader:completeAnimation()
			f13_arg0.LaboratoryOffersHeader:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.LaboratoryOffersHeader)
			f13_arg0.TextBox:completeAnimation()
			f13_arg0.TextBox:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.TextBox)
		end,
	},
}
CoD.LaboratorySpecialOffers.__onClose = function(f14_arg0)
	f14_arg0.SpecialOffers:close()
	f14_arg0.LaboratoryOffersHeader:close()
end
