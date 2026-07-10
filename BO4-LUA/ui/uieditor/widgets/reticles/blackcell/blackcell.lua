require("x64:b0d9426ff0854aa")
CoD.BlackCell = InheritFrom(LUI.UIElement)
CoD.BlackCell.__defaultWidth = 1920
CoD.BlackCell.__defaultHeight = 1080
CoD.BlackCell.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.HUDUtility.SetUpReticle(self, f1_arg1)
	self:setClass(CoD.BlackCell)
	self.id = "BlackCell"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local internal = CoD.BlackCellInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	internal:setAlpha(0)
	internal:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", nil, function(model)
		internal:setModel(model, f1_arg1)
	end)
	self:addElement(internal)
	self.internal = internal
	self:mergeStateConditions({
		{
			stateName = "ADS",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "lookingDownSights")
				if f3_local0 then
					if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644]) then
						f3_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x79E684E90DF4625])
					else
						f3_local0 = true
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.lookingDownSights, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lookingDownSights",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x79E684E90DF4625]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x79E684E90DF4625],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BlackCell.__resetProperties = function(f7_arg0)
	f7_arg0.internal:completeAnimation()
	f7_arg0.internal:setAlpha(0)
end
CoD.BlackCell.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	ADS = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.internal:completeAnimation()
			f9_arg0.internal:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.internal)
		end,
	},
}
CoD.BlackCell.__onClose = function(f10_arg0)
	f10_arg0.internal:close()
end
