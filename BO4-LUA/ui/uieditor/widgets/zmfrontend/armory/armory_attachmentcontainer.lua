require("x64:915bfc400ee19b")
require("x64:18183b7c4f53828")
CoD.Armory_AttachmentContainer = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentContainer.__defaultWidth = 1500
CoD.Armory_AttachmentContainer.__defaultHeight = 300
CoD.Armory_AttachmentContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 40, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.Armory_AttachmentContainer)
	self.id = "Armory_AttachmentContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OpticsList = CoD.Armory_OpticsList.new(f1_arg0, f1_arg1, 0, 0, 80, 580, 0, 0, 0, 300)
	OpticsList:linkToElementModel(self, nil, false, function(model)
		OpticsList:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(OpticsList, "childFocusGained", function(element)
		SetControllerModelValue(f1_arg1, "armoryOpticListFocus", true)
		SetControllerModelValue(f1_arg1, "armoryAttachmentListFocus", false)
	end)
	LUI.OverrideFunction_CallOriginalFirst(OpticsList, "childFocusLost", function(element)
		SetControllerModelValue(f1_arg1, "armoryOpticListFocus", false)
	end)
	self:addElement(OpticsList)
	self.OpticsList = OpticsList
	local AttachmentList = CoD.Armory_AttachmentList.new(f1_arg0, f1_arg1, 0, 0, 620, 1420, 0, 0, 0, 300)
	AttachmentList:linkToElementModel(self, nil, false, function(model)
		AttachmentList:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(AttachmentList, "childFocusGained", function(element)
		SetControllerModelValue(f1_arg1, "armoryOpticListFocus", false)
		SetControllerModelValue(f1_arg1, "armoryAttachmentListFocus", true)
	end)
	LUI.OverrideFunction_CallOriginalFirst(AttachmentList, "childFocusLost", function(element)
		SetControllerModelValue(f1_arg1, "armoryAttachmentListFocus", false)
	end)
	self:addElement(AttachmentList)
	self.AttachmentList = AttachmentList
	self:mergeStateConditions({
		{
			stateName = "NoAttachments",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showAttachmentPips")
			end,
		},
		{
			stateName = "NoOptics",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasOpticSlot")
			end,
		},
	})
	self:linkToElementModel(self, "showAttachmentPips", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showAttachmentPips",
		})
	end)
	self:linkToElementModel(self, "hasOpticSlot", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasOpticSlot",
		})
	end)
	OpticsList.id = "OpticsList"
	AttachmentList.id = "AttachmentList"
	self.__defaultFocus = OpticsList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	CoD.ZMLoadoutUtility.SetModelToArmoryWeaponItemModel(self, f1_arg1, f1_arg0)
	return self
end
CoD.Armory_AttachmentContainer.__resetProperties = function(f12_arg0)
	f12_arg0.OpticsList:completeAnimation()
	f12_arg0.AttachmentList:completeAnimation()
	f12_arg0.OpticsList:setAlpha(1)
	f12_arg0.AttachmentList:setAlpha(1)
end
CoD.Armory_AttachmentContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	NoAttachments = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.OpticsList:completeAnimation()
			f14_arg0.OpticsList:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.OpticsList)
			f14_arg0.AttachmentList:completeAnimation()
			f14_arg0.AttachmentList:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.AttachmentList)
		end,
	},
	NoOptics = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.OpticsList:completeAnimation()
			f15_arg0.OpticsList:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.OpticsList)
		end,
	},
}
CoD.Armory_AttachmentContainer.__onClose = function(f16_arg0)
	f16_arg0.OpticsList:close()
	f16_arg0.AttachmentList:close()
end
