require("x64:6c3d775b9bb460e")
require("x64:4e0bfd4092177e1")
require("x64:cebbbd9d9d61e8f")
CoD.CodCasterLoadoutSecondary = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutSecondary.__defaultWidth = 501
CoD.CodCasterLoadoutSecondary.__defaultHeight = 75
CoD.CodCasterLoadoutSecondary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(true)
	self:setClass(CoD.CodCasterLoadoutSecondary)
	self.id = "CodCasterLoadoutSecondary"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterLoadoutModuleSecondaryWildcard = CoD.CodCasterLoadoutModuleSecondaryWildcard.new(f1_arg0, f1_arg1, 0, 0, 169, 279, 0, 0, 4, 79)
	self:addElement(CodCasterLoadoutModuleSecondaryWildcard)
	self.CodCasterLoadoutModuleSecondaryWildcard = CodCasterLoadoutModuleSecondaryWildcard
	local CodCasterLoadoutModuleSecondaryAttachments = CoD.CodCasterLoadoutModuleSecondaryAttachment.new(f1_arg0, f1_arg1, 0, 0, 279, 389, 0, 0, 4, 80)
	self:addElement(CodCasterLoadoutModuleSecondaryAttachments)
	self.CodCasterLoadoutModuleSecondaryAttachments = CodCasterLoadoutModuleSecondaryAttachments
	local CodCasterLoadoutModuleSecondaryWeapon = CoD.CodCasterLoadoutSecondaryWeapon.new(f1_arg0, f1_arg1, 0, 0, 389, 501, 0, 0, 4, 80)
	self:addElement(CodCasterLoadoutModuleSecondaryWeapon)
	self.CodCasterLoadoutModuleSecondaryWeapon = CodCasterLoadoutModuleSecondaryWeapon
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
	CodCasterLoadoutModuleSecondaryWildcard.id = "CodCasterLoadoutModuleSecondaryWildcard"
	CodCasterLoadoutModuleSecondaryAttachments.id = "CodCasterLoadoutModuleSecondaryAttachments"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutSecondary.__resetProperties = function(f8_arg0)
	f8_arg0.CodCasterLoadoutModuleSecondaryWeapon:completeAnimation()
	f8_arg0.CodCasterLoadoutModuleSecondaryAttachments:completeAnimation()
	f8_arg0.CodCasterLoadoutModuleSecondaryWildcard:completeAnimation()
	f8_arg0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(1)
	f8_arg0.CodCasterLoadoutModuleSecondaryAttachments:setAlpha(1)
	f8_arg0.CodCasterLoadoutModuleSecondaryWildcard:setAlpha(1)
end
CoD.CodCasterLoadoutSecondary.__clipsPerState = {
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
			f10_arg0.CodCasterLoadoutModuleSecondaryWildcard:completeAnimation()
			f10_arg0.CodCasterLoadoutModuleSecondaryWildcard:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModuleSecondaryWildcard)
			f10_arg0.CodCasterLoadoutModuleSecondaryAttachments:completeAnimation()
			f10_arg0.CodCasterLoadoutModuleSecondaryAttachments:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModuleSecondaryAttachments)
			f10_arg0.CodCasterLoadoutModuleSecondaryWeapon:completeAnimation()
			f10_arg0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CodCasterLoadoutModuleSecondaryWeapon)
		end,
	},
	HiddenInHeist = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.CodCasterLoadoutModuleSecondaryWildcard:completeAnimation()
			f11_arg0.CodCasterLoadoutModuleSecondaryWildcard:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModuleSecondaryWildcard)
			f11_arg0.CodCasterLoadoutModuleSecondaryAttachments:completeAnimation()
			f11_arg0.CodCasterLoadoutModuleSecondaryAttachments:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModuleSecondaryAttachments)
			f11_arg0.CodCasterLoadoutModuleSecondaryWeapon:completeAnimation()
			f11_arg0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CodCasterLoadoutModuleSecondaryWeapon)
		end,
	},
	HiddenInOIC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.CodCasterLoadoutModuleSecondaryWildcard:completeAnimation()
			f12_arg0.CodCasterLoadoutModuleSecondaryWildcard:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModuleSecondaryWildcard)
			f12_arg0.CodCasterLoadoutModuleSecondaryAttachments:completeAnimation()
			f12_arg0.CodCasterLoadoutModuleSecondaryAttachments:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModuleSecondaryAttachments)
			f12_arg0.CodCasterLoadoutModuleSecondaryWeapon:completeAnimation()
			f12_arg0.CodCasterLoadoutModuleSecondaryWeapon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CodCasterLoadoutModuleSecondaryWeapon)
		end,
	},
}
CoD.CodCasterLoadoutSecondary.__onClose = function(f13_arg0)
	f13_arg0.__on_close_removeOverrides()
	f13_arg0.CodCasterLoadoutModuleSecondaryWildcard:close()
	f13_arg0.CodCasterLoadoutModuleSecondaryAttachments:close()
	f13_arg0.CodCasterLoadoutModuleSecondaryWeapon:close()
end
