CoD.WeaponAttributeUberInfo = InheritFrom(LUI.UIElement)
CoD.WeaponAttributeUberInfo.__defaultWidth = 250
CoD.WeaponAttributeUberInfo.__defaultHeight = 64
CoD.WeaponAttributeUberInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponAttributeUberInfo)
	self.id = "WeaponAttributeUberInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UberHeaderText = LUI.UIText.new(0, 0, 0, 144, 0, 0, 31, 49)
	UberHeaderText:setRGB(0.39, 0.39, 0.39)
	UberHeaderText:setText(LocalizeToUpperString(0x912DE50663D611C))
	UberHeaderText:setTTF("ttmussels_regular")
	UberHeaderText:setLetterSpacing(4)
	UberHeaderText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(UberHeaderText)
	self.UberHeaderText = UberHeaderText
	local UberAttachmentName = LUI.UIText.new(0, 0, 243.5, 373.5, 0, 0, 31, 49)
	UberAttachmentName:setTTF("ttmussels_demibold")
	UberAttachmentName:setLetterSpacing(3)
	UberAttachmentName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UberAttachmentName:linkToElementModel(self, "uberName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			UberAttachmentName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(UberAttachmentName)
	self.UberAttachmentName = UberAttachmentName
	local UberAttachmentIcon = LUI.UIFixedAspectRatioImage.new(0, 0, 170, 218, 0, 0, 16, 64)
	UberAttachmentIcon:linkToElementModel(self, "uberImage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			UberAttachmentIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(UberAttachmentIcon)
	self.UberAttachmentIcon = UberAttachmentIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "uberName")
			end,
		},
	})
	self:linkToElementModel(self, "uberName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "uberName",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponAttributeUberInfo.__resetProperties = function(f6_arg0)
	f6_arg0.UberAttachmentName:completeAnimation()
	f6_arg0.UberHeaderText:completeAnimation()
	f6_arg0.UberAttachmentIcon:completeAnimation()
	f6_arg0.UberAttachmentName:setAlpha(1)
	f6_arg0.UberHeaderText:setAlpha(1)
	f6_arg0.UberAttachmentIcon:setAlpha(1)
end
CoD.WeaponAttributeUberInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.UberHeaderText:completeAnimation()
			f7_arg0.UberHeaderText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.UberHeaderText)
			f7_arg0.UberAttachmentName:completeAnimation()
			f7_arg0.UberAttachmentName:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.UberAttachmentName)
			f7_arg0.UberAttachmentIcon:completeAnimation()
			f7_arg0.UberAttachmentIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.UberAttachmentIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.UberHeaderText:completeAnimation()
			f8_arg0.UberHeaderText:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.UberHeaderText)
			f8_arg0.UberAttachmentName:completeAnimation()
			f8_arg0.UberAttachmentName:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.UberAttachmentName)
		end,
	},
}
CoD.WeaponAttributeUberInfo.__onClose = function(f9_arg0)
	f9_arg0.UberAttachmentName:close()
	f9_arg0.UberAttachmentIcon:close()
end
