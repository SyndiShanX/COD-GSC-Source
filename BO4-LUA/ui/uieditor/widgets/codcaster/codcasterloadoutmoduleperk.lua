require("x64:222cfc05e2b18bf")
require("x64:a31000bac763c70")
CoD.CodCasterLoadoutModulePerk = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutModulePerk.__defaultWidth = 110
CoD.CodCasterLoadoutModulePerk.__defaultHeight = 75
CoD.CodCasterLoadoutModulePerk.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutModulePerk)
	self.id = "CodCasterLoadoutModulePerk"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local CodCasterLoadoutPerkBackground = CoD.CodCasterLoadoutPerkBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 0, 76)
	self:addElement(CodCasterLoadoutPerkBackground)
	self.CodCasterLoadoutPerkBackground = CodCasterLoadoutPerkBackground
	local CodCasterLoadoutPerkList = LUI.UIList.new(f1_arg0, f1_arg1, -5, 0, nil, false, false, false, false)
	CodCasterLoadoutPerkList:setLeftRight(0, 0, 2, 62)
	CodCasterLoadoutPerkList:setTopBottom(0, 0, 5, 65)
	CodCasterLoadoutPerkList:setWidgetType(CoD.CodCasterLoadoutPerks)
	CodCasterLoadoutPerkList:setSpacing(-5)
	CodCasterLoadoutPerkList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CodCasterLoadoutPerkList:setDataSource("PerkList")
	CodCasterLoadoutPerkList:subscribeToGlobalModel(f1_arg1, "PerController", "talents.perkCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterLoadoutPerkList:setHorizontalCount(f2_local0)
		end
	end)
	self:addElement(CodCasterLoadoutPerkList)
	self.CodCasterLoadoutPerkList = CodCasterLoadoutPerkList
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutPerkList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f3_local0, f3_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "talents.anyTalentChanged", function(model)
		local f4_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutPerkList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f4_local0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "CodCaster.profileSettingsUpdated", function(model)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "talents.count", function(model)
		local f6_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutPerkList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f6_local0, f1_arg1)
	end)
	CodCasterLoadoutPerkList.id = "CodCasterLoadoutPerkList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutModulePerk.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.CodCasterLoadoutPerkBackground:close()
	f8_arg0.CodCasterLoadoutPerkList:close()
end
