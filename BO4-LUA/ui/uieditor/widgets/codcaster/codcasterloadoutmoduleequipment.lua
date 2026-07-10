require("x64:7af080d08bebcad")
require("x64:a31000bac763c70")
CoD.CodCasterLoadoutModuleEquipment = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutModuleEquipment.__defaultWidth = 110
CoD.CodCasterLoadoutModuleEquipment.__defaultHeight = 75
CoD.CodCasterLoadoutModuleEquipment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutModuleEquipment)
	self.id = "CodCasterLoadoutModuleEquipment"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local CodCasterLoadoutEquipmentBackground = CoD.CodCasterLoadoutEquipmentBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 0, 76)
	self:addElement(CodCasterLoadoutEquipmentBackground)
	self.CodCasterLoadoutEquipmentBackground = CodCasterLoadoutEquipmentBackground
	local CodCasterLoadoutEquipmentList = LUI.UIList.new(f1_arg0, f1_arg1, 1, 0, nil, false, false, false, false)
	CodCasterLoadoutEquipmentList:setLeftRight(0, 0, 1.5, 61.5)
	CodCasterLoadoutEquipmentList:setTopBottom(0, 0, 5, 65)
	CodCasterLoadoutEquipmentList:setWidgetType(CoD.CodCasterLoadoutPerks)
	CodCasterLoadoutEquipmentList:setSpacing(1)
	CodCasterLoadoutEquipmentList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CodCasterLoadoutEquipmentList:setBackingWidgetXPadding(1)
	CodCasterLoadoutEquipmentList:setDataSource("EquipmentList")
	CodCasterLoadoutEquipmentList:subscribeToGlobalModel(f1_arg1, "PerController", "talents.talentEquipmentCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterLoadoutEquipmentList:setHorizontalCount(f2_local0)
		end
	end)
	self:addElement(CodCasterLoadoutEquipmentList)
	self.CodCasterLoadoutEquipmentList = CodCasterLoadoutEquipmentList
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutEquipmentList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f3_local0, f3_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "talents.anyTalentChanged", function(model)
		local f4_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutEquipmentList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f4_local0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "CodCaster.profileSettingsUpdated", function(model)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, self, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "talents.talentEquipmentCount", function(model)
		local f6_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutEquipmentList, true, true, true)
		CoD.CodCasterUtility.UpdateTalentsListSizeAndModel(self, f6_local0, f1_arg1)
	end)
	CodCasterLoadoutEquipmentList.id = "CodCasterLoadoutEquipmentList"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutModuleEquipment.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.CodCasterLoadoutEquipmentBackground:close()
	f8_arg0.CodCasterLoadoutEquipmentList:close()
end
