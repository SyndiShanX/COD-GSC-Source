require("x64:2051412fc9f510b")
CoD.CodCasterPortraitPlayerListEntrySpecialistHead = InheritFrom(LUI.UIElement)
CoD.CodCasterPortraitPlayerListEntrySpecialistHead.__defaultWidth = 133
CoD.CodCasterPortraitPlayerListEntrySpecialistHead.__defaultHeight = 96
CoD.CodCasterPortraitPlayerListEntrySpecialistHead.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPortraitPlayerListEntrySpecialistHead)
	self.id = "CodCasterPortraitPlayerListEntrySpecialistHead"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterPortraitPlayerListEntrySpecialistHeadIcon = CoD.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.new(f1_arg0, f1_arg1, 0.06, 1.06, -8, -8, 0.09, 1.09, -9, -9)
	CodCasterPortraitPlayerListEntrySpecialistHeadIcon:setScale(1.3, 1.3)
	self:addElement(CodCasterPortraitPlayerListEntrySpecialistHeadIcon)
	self.CodCasterPortraitPlayerListEntrySpecialistHeadIcon = CodCasterPortraitPlayerListEntrySpecialistHeadIcon
	self:mergeStateConditions({
		{
			stateName = "PlayerDead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
	})
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	f1_local2 = CodCasterPortraitPlayerListEntrySpecialistHeadIcon
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.CodCasterPortraitPlayerListEntrySpecialistHead.__resetProperties = function(f4_arg0)
	f4_arg0.CodCasterPortraitPlayerListEntrySpecialistHeadIcon:completeAnimation()
	f4_arg0.CodCasterPortraitPlayerListEntrySpecialistHeadIcon:setRGB(1, 1, 1)
end
CoD.CodCasterPortraitPlayerListEntrySpecialistHead.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	PlayerDead = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.CodCasterPortraitPlayerListEntrySpecialistHeadIcon:completeAnimation()
			f6_arg0.CodCasterPortraitPlayerListEntrySpecialistHeadIcon:setRGB(0.24, 0.24, 0.24)
			f6_arg0.clipFinished(f6_arg0.CodCasterPortraitPlayerListEntrySpecialistHeadIcon)
		end,
	},
}
CoD.CodCasterPortraitPlayerListEntrySpecialistHead.__onClose = function(f7_arg0)
	f7_arg0.CodCasterPortraitPlayerListEntrySpecialistHeadIcon:close()
end
