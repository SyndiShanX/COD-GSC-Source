require("x64:d5101de353b0ea9")
require("x64:be66d9365a7c497")
require("x64:c28f92be0d05a85")
CoD.CodCasterLoadoutTalents = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutTalents.__defaultWidth = 800
CoD.CodCasterLoadoutTalents.__defaultHeight = 75
CoD.CodCasterLoadoutTalents.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(true)
	self:setClass(CoD.CodCasterLoadoutTalents)
	self.id = "CodCasterLoadoutTalents"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterLoadoutModuleEquipment = CoD.CodCasterLoadoutModuleEquipment.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 3, 78)
	self:addElement(CodCasterLoadoutModuleEquipment)
	self.CodCasterLoadoutModuleEquipment = CodCasterLoadoutModuleEquipment
	local CodCasterLoadoutModulePerk = CoD.CodCasterLoadoutModulePerk.new(f1_arg0, f1_arg1, 0, 0, 112, 222, 0, 0, 3, 78)
	self:addElement(CodCasterLoadoutModulePerk)
	self.CodCasterLoadoutModulePerk = CodCasterLoadoutModulePerk
	local CodCasterLoadoutModulePerkWildcard = CoD.CodCasterLoadoutModulePerkWildcard.new(f1_arg0, f1_arg1, 0, 0, 224, 334, 0, 0, 3, 78)
	self:addElement(CodCasterLoadoutModulePerkWildcard)
	self.CodCasterLoadoutModulePerkWildcard = CodCasterLoadoutModulePerkWildcard
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playercard", 1)
			end,
		},
		{
			stateName = "HiddenInHeist",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.GameTypeIsBounty(f1_arg1)
			end,
		},
		{
			stateName = "HiddenInOIC",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("oic")
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.profileSettingsUpdated, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self.__on_menuOpened_self = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		local f6_local0 = self
		UpdateSelfState(self, f6_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	CodCasterLoadoutModuleEquipment.id = "CodCasterLoadoutModuleEquipment"
	CodCasterLoadoutModulePerk.id = "CodCasterLoadoutModulePerk"
	CodCasterLoadoutModulePerkWildcard.id = "CodCasterLoadoutModulePerkWildcard"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutTalents.__resetProperties = function(f8_arg0)
	f8_arg0.CodCasterLoadoutModulePerkWildcard:completeAnimation()
	f8_arg0.CodCasterLoadoutModulePerk:completeAnimation()
	f8_arg0.CodCasterLoadoutModuleEquipment:completeAnimation()
	f8_arg0.CodCasterLoadoutModulePerkWildcard:setAlpha(1)
	f8_arg0.CodCasterLoadoutModulePerk:setAlpha(1)
	f8_arg0.CodCasterLoadoutModuleEquipment:setAlpha(1)
end
CoD.CodCasterLoadoutTalents.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.CodCasterLoadoutModuleEquipment:completeAnimation()
			f10_arg0.CodCasterLoadoutModuleEquipment:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModuleEquipment)
			f10_arg0.CodCasterLoadoutModulePerk:completeAnimation()
			f10_arg0.CodCasterLoadoutModulePerk:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModulePerk)
			f10_arg0.CodCasterLoadoutModulePerkWildcard:completeAnimation()
			f10_arg0.CodCasterLoadoutModulePerkWildcard:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModulePerkWildcard)
		end,
	},
	HiddenInHeist = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.CodCasterLoadoutModuleEquipment:completeAnimation()
			f11_arg0.CodCasterLoadoutModuleEquipment:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModuleEquipment)
			f11_arg0.CodCasterLoadoutModulePerk:completeAnimation()
			f11_arg0.CodCasterLoadoutModulePerk:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModulePerk)
			f11_arg0.CodCasterLoadoutModulePerkWildcard:completeAnimation()
			f11_arg0.CodCasterLoadoutModulePerkWildcard:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModulePerkWildcard)
		end,
	},
	HiddenInOIC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.CodCasterLoadoutModuleEquipment:completeAnimation()
			f12_arg0.CodCasterLoadoutModuleEquipment:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModuleEquipment)
			f12_arg0.CodCasterLoadoutModulePerk:completeAnimation()
			f12_arg0.CodCasterLoadoutModulePerk:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModulePerk)
			f12_arg0.CodCasterLoadoutModulePerkWildcard:completeAnimation()
			f12_arg0.CodCasterLoadoutModulePerkWildcard:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModulePerkWildcard)
		end,
	},
}
CoD.CodCasterLoadoutTalents.__onClose = function(f13_arg0)
	f13_arg0.__on_close_removeOverrides()
	f13_arg0.CodCasterLoadoutModuleEquipment:close()
	f13_arg0.CodCasterLoadoutModulePerk:close()
	f13_arg0.CodCasterLoadoutModulePerkWildcard:close()
end
