CoD.WarzoneInventoryUnlockMissionObjectiveBG = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryUnlockMissionObjectiveBG.__defaultWidth = 100
CoD.WarzoneInventoryUnlockMissionObjectiveBG.__defaultHeight = 19
CoD.WarzoneInventoryUnlockMissionObjectiveBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryUnlockMissionObjectiveBG)
	self.id = "WarzoneInventoryUnlockMissionObjectiveBG"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local failedIcon = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 1.5, 17.5)
	failedIcon:setAlpha(0)
	failedIcon:setImage(RegisterImage(@"hash_54E1F97403E7D551"))
	failedIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(failedIcon)
	self.failedIcon = failedIcon
	local completedIcon = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 1.5, 17.5)
	completedIcon:setAlpha(0)
	completedIcon:setScale(0.9, 0.9)
	completedIcon:setImage(RegisterImage(@"hash_282143D1E9623675"))
	completedIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(completedIcon)
	self.completedIcon = completedIcon
	local FrontendFrame02 = LUI.UIImage.new(0, 0, 0.5, 15.5, 0, 0, 2, 17)
	FrontendFrame02:setAlpha(0)
	FrontendFrame02:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	self:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", CoD.WZUtility.ObjectiveStates.COMPLETED)
			end,
		},
		{
			stateName = "Failed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "state", CoD.WZUtility.ObjectiveStates.FAILED)
			end,
		},
		{
			stateName = "InProgress",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.ModelUtility.IsSelfModelValueNil(element, f1_arg1, "description") then
					f4_local0 = not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "description", 0x0)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
	})
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	self:linkToElementModel(self, "description", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "description",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryUnlockMissionObjectiveBG.__resetProperties = function(f7_arg0)
	f7_arg0.completedIcon:completeAnimation()
	f7_arg0.FrontendFrame02:completeAnimation()
	f7_arg0.failedIcon:completeAnimation()
	f7_arg0.completedIcon:setAlpha(0)
	f7_arg0.FrontendFrame02:setAlpha(0)
	f7_arg0.failedIcon:setAlpha(0)
end
CoD.WarzoneInventoryUnlockMissionObjectiveBG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Completed = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.completedIcon:completeAnimation()
			f9_arg0.completedIcon:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.completedIcon)
			f9_arg0.FrontendFrame02:completeAnimation()
			f9_arg0.FrontendFrame02:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.FrontendFrame02)
		end,
	},
	Failed = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.failedIcon:completeAnimation()
			f10_arg0.failedIcon:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.failedIcon)
			f10_arg0.FrontendFrame02:completeAnimation()
			f10_arg0.FrontendFrame02:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.FrontendFrame02)
		end,
	},
	InProgress = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.failedIcon:completeAnimation()
			f11_arg0.failedIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.failedIcon)
			f11_arg0.completedIcon:completeAnimation()
			f11_arg0.completedIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.completedIcon)
			f11_arg0.FrontendFrame02:completeAnimation()
			f11_arg0.FrontendFrame02:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FrontendFrame02)
		end,
	},
}
