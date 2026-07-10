require("x64:4fe38baf1672b2b")
CoD.ScannerReticle_UI3D = InheritFrom(LUI.UIElement)
CoD.ScannerReticle_UI3D.__defaultWidth = 600
CoD.ScannerReticle_UI3D.__defaultHeight = 600
CoD.ScannerReticle_UI3D.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScannerReticle_UI3D)
	self.id = "ScannerReticle_UI3D"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScannerReticleInternal = CoD.ScannerReticle_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 600)
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 3, 600, 600)
	ScannerReticleInternal:setUI3DWindow(3)
	ScannerReticleInternal:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", nil, function(model)
		ScannerReticleInternal:setModel(model, f1_arg1)
	end)
	self:addElement(ScannerReticleInternal)
	self.ScannerReticleInternal = ScannerReticleInternal
	self:mergeStateConditions({
		{
			stateName = "EMPActive",
			condition = function(menu, element, event)
				return IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScannerReticle_UI3D.__resetProperties = function(f5_arg0)
	f5_arg0.ScannerReticleInternal:completeAnimation()
	f5_arg0.ScannerReticleInternal:setAlpha(1)
end
CoD.ScannerReticle_UI3D.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	EMPActive = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.ScannerReticleInternal:completeAnimation()
			f7_arg0.ScannerReticleInternal:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ScannerReticleInternal)
		end,
	},
}
CoD.ScannerReticle_UI3D.__onClose = function(f8_arg0)
	f8_arg0.ScannerReticleInternal:close()
end
