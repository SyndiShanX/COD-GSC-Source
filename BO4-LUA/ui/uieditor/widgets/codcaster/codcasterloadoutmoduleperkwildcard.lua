require("x64:48782e5f4b7d1c9")
require("x64:56366ce3f806699")
CoD.CodCasterLoadoutModulePerkWildcard = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutModulePerkWildcard.__defaultWidth = 110
CoD.CodCasterLoadoutModulePerkWildcard.__defaultHeight = 75
CoD.CodCasterLoadoutModulePerkWildcard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutModulePerkWildcard)
	self.id = "CodCasterLoadoutModulePerkWildcard"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local CodCasterLoadoutWildcardBackground = CoD.CodCasterLoadoutWildcardBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 0, 76)
	self:addElement(CodCasterLoadoutWildcardBackground)
	self.CodCasterLoadoutWildcardBackground = CodCasterLoadoutWildcardBackground
	local CodCasterLoadoutWildcardList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	CodCasterLoadoutWildcardList:setLeftRight(0, 0, 9, 34)
	CodCasterLoadoutWildcardList:setTopBottom(0, 0, 5, 65)
	CodCasterLoadoutWildcardList:setWidgetType(CoD.CodCasterLoadoutWildcard)
	CodCasterLoadoutWildcardList:setSpacing(8)
	CodCasterLoadoutWildcardList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CodCasterLoadoutWildcardList:setDataSource("WildcardPerksList")
	CodCasterLoadoutWildcardList:subscribeToGlobalModel(f1_arg1, "PerController", "wildcards.customCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterLoadoutWildcardList:setHorizontalCount(f2_local0)
		end
	end)
	self:addElement(CodCasterLoadoutWildcardList)
	self.CodCasterLoadoutWildcardList = CodCasterLoadoutWildcardList
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutWildcardList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f3_local0, f3_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "wildcards.anyWildcardChanged", function(model)
		local f4_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutWildcardList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f4_local0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "CodCaster.profileSettingsUpdated", function(model)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "wildcards.customCount", function(model)
		local f6_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutWildcardList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f6_local0, f1_arg1)
	end)
	CodCasterLoadoutWildcardList.id = "CodCasterLoadoutWildcardList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutModulePerkWildcard.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.CodCasterLoadoutWildcardBackground:close()
	f8_arg0.CodCasterLoadoutWildcardList:close()
end
