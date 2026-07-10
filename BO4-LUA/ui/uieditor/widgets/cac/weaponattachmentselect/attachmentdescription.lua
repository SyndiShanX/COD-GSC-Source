CoD.AttachmentDescription = InheritFrom(LUI.UIElement)
CoD.AttachmentDescription.__defaultWidth = 200
CoD.AttachmentDescription.__defaultHeight = 18
CoD.AttachmentDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttachmentDescription)
	self.id = "AttachmentDescription"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Description = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 18)
	Description:setTTF("ttmussels_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:setBackingType(2)
	Description:setBackingColor(0, 0, 0)
	Description:setBackingAlpha(0.3)
	Description:linkToElementModel(self, "description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Description:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	self:mergeStateConditions({
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "stateLeft")
			end,
		},
	})
	self:linkToElementModel(self, "stateLeft", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stateLeft",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttachmentDescription.__resetProperties = function(f5_arg0)
	f5_arg0.Description:completeAnimation()
	f5_arg0.Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
end
CoD.AttachmentDescription.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Left = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Description:completeAnimation()
			f7_arg0.Description:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
			f7_arg0.clipFinished(f7_arg0.Description)
		end,
	},
}
CoD.AttachmentDescription.__onClose = function(f8_arg0)
	f8_arg0.Description:close()
end
