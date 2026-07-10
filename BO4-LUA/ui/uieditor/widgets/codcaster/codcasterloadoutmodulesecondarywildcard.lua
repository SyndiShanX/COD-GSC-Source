require("x64:48782e5f4b7d1c9")
require("x64:56366ce3f806699")
CoD.CodCasterLoadoutModuleSecondaryWildcard = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutModuleSecondaryWildcard.__defaultWidth = 110
CoD.CodCasterLoadoutModuleSecondaryWildcard.__defaultHeight = 75
CoD.CodCasterLoadoutModuleSecondaryWildcard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutModuleSecondaryWildcard)
	self.id = "CodCasterLoadoutModuleSecondaryWildcard"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local CodCasterLoadoutWildcardBackground = CoD.CodCasterLoadoutWildcardBackground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 76)
	self:addElement(CodCasterLoadoutWildcardBackground)
	self.CodCasterLoadoutWildcardBackground = CodCasterLoadoutWildcardBackground
	local CodCasterLoadoutWildcards = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	CodCasterLoadoutWildcards:setLeftRight(0, 0, 9, 34)
	CodCasterLoadoutWildcards:setTopBottom(0, 0, 5, 65)
	CodCasterLoadoutWildcards:setWidgetType(CoD.CodCasterLoadoutWildcard)
	CodCasterLoadoutWildcards:setSpacing(6)
	CodCasterLoadoutWildcards:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CodCasterLoadoutWildcards:setDataSource("WildcardSecondaryList")
	CodCasterLoadoutWildcards:subscribeToGlobalModel(f1_arg1, "PerController", "wildcards.secondaryCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterLoadoutWildcards:setHorizontalCount(f2_local0)
		end
	end)
	self:addElement(CodCasterLoadoutWildcards)
	self.CodCasterLoadoutWildcards = CodCasterLoadoutWildcards
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutWildcards, true, true, true)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, f3_local0, f3_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "wildcards.anyWildcardChanged", function(model)
		local f4_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutWildcards, true, true, true)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, f4_local0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "CodCaster.profileSettingsUpdated", function(model)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "wildcards.secondaryCount", function(model)
		local f6_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutWildcards, true, true, true)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, f6_local0, f1_arg1)
	end)
	CodCasterLoadoutWildcards.id = "CodCasterLoadoutWildcards"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutModuleSecondaryWildcard.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.CodCasterLoadoutWildcardBackground:close()
	f8_arg0.CodCasterLoadoutWildcards:close()
end
