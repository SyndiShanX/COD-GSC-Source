require("x64:be37b1a86741023")
require("x64:8b667e4e3087d0a")
CoD.CodCasterLoadoutModuleSecondaryAttachment = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutModuleSecondaryAttachment.__defaultWidth = 110
CoD.CodCasterLoadoutModuleSecondaryAttachment.__defaultHeight = 76
CoD.CodCasterLoadoutModuleSecondaryAttachment.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutModuleSecondaryAttachment)
	self.id = "CodCasterLoadoutModuleSecondaryAttachment"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local CodCasterLoadoutAttachmentsBackground = CoD.CodCasterLoadoutAttachmentsBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 0, 76)
	self:addElement(CodCasterLoadoutAttachmentsBackground)
	self.CodCasterLoadoutAttachmentsBackground = CodCasterLoadoutAttachmentsBackground
	local CodCasterLoadoutAttachments = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	CodCasterLoadoutAttachments:setLeftRight(0, 0, 4, 64)
	CodCasterLoadoutAttachments:setTopBottom(0, 0, 6, 66)
	CodCasterLoadoutAttachments:setWidgetType(CoD.CodCasterLoadoutSecondaryAttachment)
	CodCasterLoadoutAttachments:setSpacing(0)
	CodCasterLoadoutAttachments:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CodCasterLoadoutAttachments:setDataSource("SecondaryWeaponAttachmentImageList")
	CodCasterLoadoutAttachments:subscribeToGlobalModel(f1_arg1, "PerController", "secondaryWeapon.attachmentCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CodCasterLoadoutAttachments:setHorizontalCount(f2_local0)
		end
	end)
	self:addElement(CodCasterLoadoutAttachments)
	self.CodCasterLoadoutAttachments = CodCasterLoadoutAttachments
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutAttachments, true, true, true)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, f3_local0, f3_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "deadSpectator.playerIndex", function(model)
		local f4_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutAttachments, true, true, true)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, f4_local0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "secondaryWeapon.attachmentCount", function(model)
		local f5_local0 = self
		CoD.GridAndListUtility.UpdateDataSource(self.CodCasterLoadoutAttachments, true, true, true)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, f5_local0, f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "CodCaster.profileSettingsUpdated", function(model)
		CoD.CodCasterUtility.UpdateSecondaryWeaponListSizeAndModel(self, self, f1_arg1)
	end)
	CodCasterLoadoutAttachments.id = "CodCasterLoadoutAttachments"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterLoadoutModuleSecondaryAttachment.__onClose = function(f8_arg0)
	f8_arg0.__on_close_removeOverrides()
	f8_arg0.CodCasterLoadoutAttachmentsBackground:close()
	f8_arg0.CodCasterLoadoutAttachments:close()
end
