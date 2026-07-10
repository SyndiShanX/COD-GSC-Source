require("x64:4d93bb99b7ba66a")
CoD.rocketLauncherReticle_UI3D = InheritFrom(LUI.UIElement)
CoD.rocketLauncherReticle_UI3D.__defaultWidth = 768
CoD.rocketLauncherReticle_UI3D.__defaultHeight = 768
CoD.rocketLauncherReticle_UI3D.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.rocketLauncherReticle_UI3D)
	self.id = "rocketLauncherReticle_UI3D"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local internal = CoD.rocketLauncherReticle_UI3D_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	internal:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f1_arg1, "CurrentWeapon", "lockedOnEnemy", Enum[0xF041D1802ECFE69][0x86864C292F49B19])
			end,
		},
	})
	local f1_local2 = internal
	local f1_local3 = internal.subscribeToModel
	local f1_local4 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.lockedOnEnemy, function(f3_arg0)
		f1_arg0:updateElementState(internal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lockedOnEnemy",
		})
	end, false)
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 3, 768, 768)
	internal:setUI3DWindow(3)
	self:addElement(internal)
	self.internal = internal
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.rocketLauncherReticle_UI3D.__resetProperties = function(f6_arg0)
	f6_arg0.internal:completeAnimation()
	f6_arg0.internal:setAlpha(1)
end
CoD.rocketLauncherReticle_UI3D.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.internal:completeAnimation()
			f8_arg0.internal:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.internal)
		end,
	},
}
CoD.rocketLauncherReticle_UI3D.__onClose = function(f9_arg0)
	f9_arg0.internal:close()
end
