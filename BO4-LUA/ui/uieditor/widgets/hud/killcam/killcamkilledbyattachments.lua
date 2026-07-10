require("x64:3ecca05fa5114fd")
CoD.KillcamKilledByAttachments = InheritFrom(LUI.UIElement)
CoD.KillcamKilledByAttachments.__defaultWidth = 375
CoD.KillcamKilledByAttachments.__defaultHeight = 70
CoD.KillcamKilledByAttachments.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.KillcamKilledByAttachments)
	self.id = "KillcamKilledByAttachments"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AttachmentsFirstThree = CoD.KillcamKilledByAttachmentsLine.new(f1_arg0, f1_arg1, 1, 1, -375, 0, 0, 0, 0, 35)
	AttachmentsFirstThree:mergeStateConditions({
		{
			stateName = "ExtraAttachments",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	AttachmentsFirstThree:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment0", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AttachmentsFirstThree.Attachment0.Attachment:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	AttachmentsFirstThree:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment1", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			AttachmentsFirstThree.Attachment1.Attachment:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	AttachmentsFirstThree:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment2", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			AttachmentsFirstThree.Attachment2.Attachment:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(AttachmentsFirstThree)
	self.AttachmentsFirstThree = AttachmentsFirstThree
	local AttachmentsLastThree = CoD.KillcamKilledByAttachmentsLine.new(f1_arg0, f1_arg1, 1, 1, -375, 0, 0, 0, 35, 70)
	AttachmentsLastThree:mergeStateConditions({
		{
			stateName = "ExtraAttachments",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	AttachmentsLastThree:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment3", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			AttachmentsLastThree.Attachment0.Attachment:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	AttachmentsLastThree:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment4", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			AttachmentsLastThree.Attachment1.Attachment:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	AttachmentsLastThree:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.attachment5", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			AttachmentsLastThree.Attachment2.Attachment:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	self:addElement(AttachmentsLastThree)
	self.AttachmentsLastThree = AttachmentsLastThree
	self:mergeStateConditions({
		{
			stateName = "HasExtraAttachments",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(f1_arg1, "HUDItems", "killcamWeapon.attachment3")
			end,
		},
		{
			stateName = "HasAttachments",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(f1_arg1, "HUDItems", "killcamWeapon.attachment0")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5["killcamWeapon.attachment3"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "killcamWeapon.attachment3",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5["killcamWeapon.attachment0"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "killcamWeapon.attachment0",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KillcamKilledByAttachments.__resetProperties = function(f14_arg0)
	f14_arg0.AttachmentsLastThree:completeAnimation()
	f14_arg0.AttachmentsFirstThree:completeAnimation()
	f14_arg0.AttachmentsLastThree:setAlpha(1)
	f14_arg0.AttachmentsFirstThree:setAlpha(1)
end
CoD.KillcamKilledByAttachments.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.AttachmentsFirstThree:completeAnimation()
			f15_arg0.AttachmentsFirstThree:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.AttachmentsFirstThree)
			f15_arg0.AttachmentsLastThree:completeAnimation()
			f15_arg0.AttachmentsLastThree:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.AttachmentsLastThree)
		end,
	},
	HasExtraAttachments = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	HasAttachments = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.AttachmentsLastThree:completeAnimation()
			f17_arg0.AttachmentsLastThree:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.AttachmentsLastThree)
		end,
	},
}
CoD.KillcamKilledByAttachments.__onClose = function(f18_arg0)
	f18_arg0.AttachmentsFirstThree:close()
	f18_arg0.AttachmentsLastThree:close()
end
