require("x64:329a92dee2ea1ff")
CoD.AARMedalsTabInternal = InheritFrom(LUI.UIElement)
CoD.AARMedalsTabInternal.__defaultWidth = 1920
CoD.AARMedalsTabInternal.__defaultHeight = 900
CoD.AARMedalsTabInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARMedalsTabInternal)
	self.id = "AARMedalsTabInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MedalsTitleGlow = LUI.UIText.new(0.5, 0.5, -702, 859, 0, 0, -5.5, 69.5)
	MedalsTitleGlow:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
	MedalsTitleGlow:setAlpha(0)
	MedalsTitleGlow:setText(Engine[0xF9F1239CFD921FE](0x8F69F5BDD4F7C26))
	MedalsTitleGlow:setTTF("ttmussels_demibold")
	MedalsTitleGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	MedalsTitleGlow:setShaderVector(0, 0.6, 0, 0, 0)
	MedalsTitleGlow:setShaderVector(1, 0, 0, 0, 0)
	MedalsTitleGlow:setShaderVector(2, 0.9, 0.7, 0.3, 0.2)
	MedalsTitleGlow:setLetterSpacing(10)
	MedalsTitleGlow:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MedalsTitleGlow:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(MedalsTitleGlow)
	self.MedalsTitleGlow = MedalsTitleGlow
	local MedalsTitle = LUI.UIText.new(0.5, 0.5, -702, 859, 0, 0, -5.5, 69.5)
	MedalsTitle:setRGB(ColorSet.T8_FactionTier_InProgress.r, ColorSet.T8_FactionTier_InProgress.g, ColorSet.T8_FactionTier_InProgress.b)
	MedalsTitle:setAlpha(0)
	MedalsTitle:setText(Engine[0xF9F1239CFD921FE](0x8F69F5BDD4F7C26))
	MedalsTitle:setTTF("ttmussels_demibold")
	MedalsTitle:setLetterSpacing(10)
	MedalsTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MedalsTitle:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(MedalsTitle)
	self.MedalsTitle = MedalsTitle
	local GametypeImage = LUI.UIImage.new(0, 0, 95, 208, 0, 0, -72.5, 40.5)
	GametypeImage:setAlpha(0)
	GametypeImage:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "gametypeIcon", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GametypeImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	local GametypeAndMap = LUI.UIText.new(0, 0, 231, 1085, 0, 0, 11, 32)
	GametypeAndMap:setRGB(0.9, 0.89, 0.78)
	GametypeAndMap:setAlpha(0)
	GametypeAndMap:setTTF("dinnext_regular")
	GametypeAndMap:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GametypeAndMap:subscribeToGlobalModel(f1_arg1, "AARSummaryStats", "gametypeAndMap", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GametypeAndMap:setText(f3_local0)
		end
	end)
	self:addElement(GametypeAndMap)
	self.GametypeAndMap = GametypeAndMap
	local MedalTabsInternal = CoD.MedalsTabInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -386, 386)
	MedalTabsInternal.MedalsGrid:setDataSource("AARMedalsList")
	self:addElement(MedalTabsInternal)
	self.MedalTabsInternal = MedalTabsInternal
	MedalTabsInternal:linkToElementModel(MedalTabsInternal.MedalsGrid, nil, false, function(model)
		MedalTabsInternal.MedalPreviewWidget:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "NoMedals",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.MedalsGrid)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	MedalTabsInternal.id = "MedalTabsInternal"
	self.__defaultFocus = MedalTabsInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARMedalsTabInternal.__onClose = function(f7_arg0)
	f7_arg0.MedalTabsInternal:close()
	f7_arg0.GametypeImage:close()
	f7_arg0.GametypeAndMap:close()
end
