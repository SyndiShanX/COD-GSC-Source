require("x64:ec94048bad1fbac")
require("x64:2bf3da84e7ff2d3")
CoD.Armory_AttachmentInfo = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentInfo.__defaultWidth = 753
CoD.Armory_AttachmentInfo.__defaultHeight = 107
CoD.Armory_AttachmentInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_AttachmentInfo)
	self.id = "Armory_AttachmentInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DirectorDividerWithGradient = CoD.DirectorDividerWithGradient.new(f1_arg0, f1_arg1, 0, 0, 1, 401, 0, 0, 69.5, 70.5)
	DirectorDividerWithGradient:setRGB(0.39, 0.39, 0.39)
	self:addElement(DirectorDividerWithGradient)
	self.DirectorDividerWithGradient = DirectorDividerWithGradient
	local UnlockDescription = CoD.onOffText.new(f1_arg0, f1_arg1, 0, 0, 0, 347, 0, 0, -9, 9)
	UnlockDescription:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ZMLoadoutUtility.IsArmoryAttachmentItemLocked(menu, element, f1_arg1)
			end,
		},
	})
	UnlockDescription:linkToElementModel(UnlockDescription, "itemIndex", true, function(model)
		f1_arg0:updateElementState(UnlockDescription, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	UnlockDescription:setRGB(0.39, 0.39, 0.39)
	UnlockDescription.TextBox:setTTF("ttmussels_regular")
	UnlockDescription:linkToElementModel(self, nil, false, function(model)
		UnlockDescription:setModel(model, f1_arg1)
	end)
	UnlockDescription:linkToElementModel(self, "itemIndex", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			UnlockDescription.TextBox:setText(CoD.BaseUtility.AlreadyLocalized(CoD.ZMLoadoutUtility.GetArmoryAttachmentUnlockDescription(f1_arg0, f1_arg1, f5_local0)))
		end
	end)
	self:addElement(UnlockDescription)
	self.UnlockDescription = UnlockDescription
	local AttachmentDescription = LUI.UIText.new(0, 0, 0, 600, 0, 0, 87, 105)
	AttachmentDescription:setRGB(0.8, 0.79, 0.78)
	AttachmentDescription:setTTF("dinnext_regular")
	AttachmentDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AttachmentDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	AttachmentDescription:linkToElementModel(self, "description", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			AttachmentDescription:setText(f6_local0)
		end
	end)
	self:addElement(AttachmentDescription)
	self.AttachmentDescription = AttachmentDescription
	local AttachmentName = LUI.UIText.new(0, 0, 0, 753, 0, 0, 32.5, 64.5)
	AttachmentName:setRGB(0.58, 0.85, 1)
	AttachmentName:setTTF("ttmussels_demibold")
	AttachmentName:setLetterSpacing(14)
	AttachmentName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AttachmentName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	AttachmentName:linkToElementModel(self, "displayName", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			AttachmentName:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self:addElement(AttachmentName)
	self.AttachmentName = AttachmentName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Armory_AttachmentInfo.__onClose = function(f8_arg0)
	f8_arg0.DirectorDividerWithGradient:close()
	f8_arg0.UnlockDescription:close()
	f8_arg0.AttachmentDescription:close()
	f8_arg0.AttachmentName:close()
end
