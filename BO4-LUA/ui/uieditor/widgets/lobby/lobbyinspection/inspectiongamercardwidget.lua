require("x64:92825f665d84b75")
require("x64:2675595fa323085")
CoD.InspectionGamerCardWidget = InheritFrom(LUI.UIElement)
CoD.InspectionGamerCardWidget.__defaultWidth = 348
CoD.InspectionGamerCardWidget.__defaultHeight = 87
CoD.InspectionGamerCardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionGamerCardWidget)
	self.id = "InspectionGamerCardWidget"
	self.soundSet = "ModeSelection"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InspectionGamerCardInternalWidget0 = CoD.InspectionGamerCardInternalWidget.new(f1_arg0, f1_arg1, 0.24, 0.24, -83.5, 264.5, 0.36, 0.36, -31, 56)
	InspectionGamerCardInternalWidget0:linkToElementModel(self, nil, false, function(model)
		InspectionGamerCardInternalWidget0:setModel(model, f1_arg1)
	end)
	self:addElement(InspectionGamerCardInternalWidget0)
	self.InspectionGamerCardInternalWidget0 = InspectionGamerCardInternalWidget0
	local FELabelSubHeadingE0 = LUI.UIText.new(0, 0, 15, 469, 0, 0, 41, 66)
	FELabelSubHeadingE0:setTTF("notosans_regular")
	FELabelSubHeadingE0:setLetterSpacing(0.5)
	FELabelSubHeadingE0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FELabelSubHeadingE0:setBackingType(3)
	FELabelSubHeadingE0:setBackingColor(0, 0, 0)
	FELabelSubHeadingE0:setBackingAlpha(0.7)
	FELabelSubHeadingE0:setBackingXPadding(16)
	FELabelSubHeadingE0:setBackingYPadding(2)
	FELabelSubHeadingE0:setBackingImage(RegisterImage(0xB859C0EB4552E05))
	FELabelSubHeadingE0:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	FELabelSubHeadingE0:setBackingShaderVector(0, 0, 0, 0, 0)
	FELabelSubHeadingE0:setupBackingNineSliceShader(24, 6)
	FELabelSubHeadingE0:linkToElementModel(self, "clantag", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FELabelSubHeadingE0:setText(f3_local0)
		end
	end)
	self:addElement(FELabelSubHeadingE0)
	self.FELabelSubHeadingE0 = FELabelSubHeadingE0
	local FELabelSubHeadingE1 = LUI.UIText.new(0, 0, 15, 469, 0, 0, 14, 39)
	FELabelSubHeadingE1.__Color = function()
		FELabelSubHeadingE1:setRGB(CoD.DirectorUtility.LobbyPlayerColorByXUIDElseDefaultSelfModel(self:getModel(), "xuid", 1, 1, 1))
	end
	FELabelSubHeadingE1.__Color()
	FELabelSubHeadingE1:setTTF("notosans_bold")
	FELabelSubHeadingE1:setLetterSpacing(0.5)
	FELabelSubHeadingE1:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FELabelSubHeadingE1:setBackingType(3)
	FELabelSubHeadingE1:setBackingColor(0, 0, 0)
	FELabelSubHeadingE1:setBackingAlpha(0.7)
	FELabelSubHeadingE1:setBackingXPadding(16)
	FELabelSubHeadingE1:setBackingYPadding(2)
	FELabelSubHeadingE1:setBackingImage(RegisterImage(0xB859C0EB4552E05))
	FELabelSubHeadingE1:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	FELabelSubHeadingE1:setBackingShaderVector(0, 0, 0, 0, 0)
	FELabelSubHeadingE1:setupBackingNineSliceShader(24, 6)
	FELabelSubHeadingE1:linkToElementModel(self, "gamertag", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FELabelSubHeadingE1:setText(CoD.SocialUtility.CleanGamerTag(f5_local0))
		end
	end)
	self:addElement(FELabelSubHeadingE1)
	self.FELabelSubHeadingE1 = FELabelSubHeadingE1
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	FELabelSubHeadingE1:linkToElementModel(self, "xuid", true, FELabelSubHeadingE1.__Color)
	InspectionGamerCardInternalWidget0.id = "InspectionGamerCardInternalWidget0"
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionGamerCardWidget.__onClose = function(f6_arg0)
	f6_arg0.InspectionGamerCardInternalWidget0:close()
	f6_arg0.FELabelSubHeadingE0:close()
	f6_arg0.FELabelSubHeadingE1:close()
	f6_arg0.emptyFocusable:close()
end
