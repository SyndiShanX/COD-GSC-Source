require("x64:1e6b0f5445ff806")
CoD.WeaponAttachmentContainer = InheritFrom(LUI.UIElement)
CoD.WeaponAttachmentContainer.__defaultWidth = 800
CoD.WeaponAttachmentContainer.__defaultHeight = 300
CoD.WeaponAttachmentContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponAttachmentContainer)
	self.id = "WeaponAttachmentContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GeneralAttachmentContainer = CoD.GeneralAttachmentContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0, 0, 30, 330)
	self:addElement(GeneralAttachmentContainer)
	self.GeneralAttachmentContainer = GeneralAttachmentContainer
	self:mergeStateConditions({
		{
			stateName = "NoUber",
			condition = function(menu, element, event)
				return CoD.WeaponAttachmentsUtility.DoesWeaponHaveUberAttachment(menu, element) and not CoD.WeaponAttachmentsUtility.ShouldShowWeaponUberInfo(menu)
			end,
		},
	})
	self.__on_menuOpened_self = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = self
		CoD.WeaponAttachmentsUtility.UpdateAttachmentContainerLayout(self, f3_arg1, f3_arg2)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	GeneralAttachmentContainer.id = "GeneralAttachmentContainer"
	self.__defaultFocus = GeneralAttachmentContainer
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponAttachmentContainer.__onClose = function(f5_arg0)
	f5_arg0.__on_close_removeOverrides()
	f5_arg0.GeneralAttachmentContainer:close()
end
