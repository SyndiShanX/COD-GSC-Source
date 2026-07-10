CoD.CompassGroupMPSmoke = InheritFrom(LUI.UIElement)
CoD.CompassGroupMPSmoke.__defaultWidth = 424
CoD.CompassGroupMPSmoke.__defaultHeight = 424
CoD.CompassGroupMPSmoke.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassGroupMPSmoke)
	self.id = "CompassGroupMPSmoke"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local smokeGrenadeEffect = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	smokeGrenadeEffect:setMaterial(LUI.UIImage.GetCachedMaterial(0x83C485F153D0720))
	smokeGrenadeEffect:subscribeToGlobalModel(f1_arg1, "HUDItems", "smokeEffect", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			smokeGrenadeEffect:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(smokeGrenadeEffect)
	self.smokeGrenadeEffect = smokeGrenadeEffect
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "HUDItems", "smokeEffect", 0)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.smokeEffect, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "smokeEffect",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassGroupMPSmoke.__resetProperties = function(f5_arg0)
	f5_arg0.smokeGrenadeEffect:completeAnimation()
	f5_arg0.smokeGrenadeEffect:setAlpha(1)
end
CoD.CompassGroupMPSmoke.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.smokeGrenadeEffect:completeAnimation()
			f6_arg0.smokeGrenadeEffect:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.smokeGrenadeEffect)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CompassGroupMPSmoke.__onClose = function(f8_arg0)
	f8_arg0.smokeGrenadeEffect:close()
end
