require("x64:95d27f6a0761cf2")
require("x64:d839165a1df7115")
require("x64:a6efdb3220b56db")
CoD.CodCasterLoadoutPrimary = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutPrimary.__defaultWidth = 501
CoD.CodCasterLoadoutPrimary.__defaultHeight = 75
CoD.CodCasterLoadoutPrimary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(true)
	self:setClass(CoD.CodCasterLoadoutPrimary)
	self.id = "CodCasterLoadoutPrimary"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterLoadoutModulePrimaryWildcard = CoD.CodCasterLoadoutModulePrimaryWildcard.new(f1_arg0, f1_arg1, 0, 0, 169, 279, 0, 0, 4, 79)
	self:addElement(CodCasterLoadoutModulePrimaryWildcard)
	self.CodCasterLoadoutModulePrimaryWildcard = CodCasterLoadoutModulePrimaryWildcard
	local CodCasterLoadoutModulePrimaryAttachments = CoD.CodCasterLoadoutModulePrimaryAttachment.new(f1_arg0, f1_arg1, 0, 0, 279, 389, 0, 0, 4, 80)
	self:addElement(CodCasterLoadoutModulePrimaryAttachments)
	self.CodCasterLoadoutModulePrimaryAttachments = CodCasterLoadoutModulePrimaryAttachments
	local CodCasterLoadoutModulePrimaryWeapon = CoD.CodCasterLoadoutPrimaryWeapon.new(f1_arg0, f1_arg1, 0, 0, 389, 501, 0, 0, 4, 80)
	self:addElement(CodCasterLoadoutModulePrimaryWeapon)
	self.CodCasterLoadoutModulePrimaryWeapon = CodCasterLoadoutModulePrimaryWeapon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_qs_playerhud", 1)
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
	CodCasterLoadoutModulePrimaryWildcard.id = "CodCasterLoadoutModulePrimaryWildcard"
	CodCasterLoadoutModulePrimaryAttachments.id = "CodCasterLoadoutModulePrimaryAttachments"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutPrimary.__resetProperties = function(f8_arg0)
	f8_arg0.CodCasterLoadoutModulePrimaryAttachments:completeAnimation()
	f8_arg0.CodCasterLoadoutModulePrimaryWildcard:completeAnimation()
	f8_arg0.CodCasterLoadoutModulePrimaryWeapon:completeAnimation()
	f8_arg0.CodCasterLoadoutModulePrimaryAttachments:setAlpha(1)
	f8_arg0.CodCasterLoadoutModulePrimaryWildcard:setAlpha(1)
	f8_arg0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(1)
end
CoD.CodCasterLoadoutPrimary.__clipsPerState = {
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
			f10_arg0.CodCasterLoadoutModulePrimaryWildcard:completeAnimation()
			f10_arg0.CodCasterLoadoutModulePrimaryWildcard:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModulePrimaryWildcard)
			f10_arg0.CodCasterLoadoutModulePrimaryAttachments:completeAnimation()
			f10_arg0.CodCasterLoadoutModulePrimaryAttachments:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModulePrimaryAttachments)
			f10_arg0.CodCasterLoadoutModulePrimaryWeapon:completeAnimation()
			f10_arg0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModulePrimaryWeapon)
		end,
	},
	HiddenInHeist = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.CodCasterLoadoutModulePrimaryWildcard:completeAnimation()
			f11_arg0.CodCasterLoadoutModulePrimaryWildcard:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModulePrimaryWildcard)
			f11_arg0.CodCasterLoadoutModulePrimaryAttachments:completeAnimation()
			f11_arg0.CodCasterLoadoutModulePrimaryAttachments:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModulePrimaryAttachments)
			f11_arg0.CodCasterLoadoutModulePrimaryWeapon:completeAnimation()
			f11_arg0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModulePrimaryWeapon)
		end,
	},
	HiddenInOIC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.CodCasterLoadoutModulePrimaryWildcard:completeAnimation()
			f12_arg0.CodCasterLoadoutModulePrimaryWildcard:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModulePrimaryWildcard)
			f12_arg0.CodCasterLoadoutModulePrimaryAttachments:completeAnimation()
			f12_arg0.CodCasterLoadoutModulePrimaryAttachments:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModulePrimaryAttachments)
			f12_arg0.CodCasterLoadoutModulePrimaryWeapon:completeAnimation()
			f12_arg0.CodCasterLoadoutModulePrimaryWeapon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModulePrimaryWeapon)
		end,
	},
}
CoD.CodCasterLoadoutPrimary.__onClose = function(f13_arg0)
	f13_arg0.__on_close_removeOverrides()
	f13_arg0.CodCasterLoadoutModulePrimaryWildcard:close()
	f13_arg0.CodCasterLoadoutModulePrimaryAttachments:close()
	f13_arg0.CodCasterLoadoutModulePrimaryWeapon:close()
end
