require("x64:2037ac2dcb09150")
CoD.ZMSpecialWeapon_StageDescription = InheritFrom(LUI.UIElement)
CoD.ZMSpecialWeapon_StageDescription.__defaultWidth = 600
CoD.ZMSpecialWeapon_StageDescription.__defaultHeight = 107
CoD.ZMSpecialWeapon_StageDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMSpecialWeapon_StageDescription)
	self.id = "ZMSpecialWeapon_StageDescription"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Divider = CoD.ZMSpecialWeapon_StageDescriptionInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 44.5, 107.5)
	Divider:linkToElementModel(self, "stageModel", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Divider:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(Divider)
	self.Divider = Divider
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNil(element, f1_arg1, "stageModel")
			end,
		},
	})
	self:linkToElementModel(self, "stageModel", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stageModel",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMSpecialWeapon_StageDescription.__resetProperties = function(f5_arg0)
	f5_arg0.Divider:completeAnimation()
	f5_arg0.Divider:setAlpha(1)
end
CoD.ZMSpecialWeapon_StageDescription.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Divider:completeAnimation()
			f7_arg0.Divider:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Divider)
		end,
	},
}
CoD.ZMSpecialWeapon_StageDescription.__onClose = function(f8_arg0)
	f8_arg0.Divider:close()
end
