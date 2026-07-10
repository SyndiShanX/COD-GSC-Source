require("x64:f2d4920f28ccd3c")
CoD.WarzoneInventoryHintItems = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryHintItems.__defaultWidth = 100
CoD.WarzoneInventoryHintItems.__defaultHeight = 100
CoD.WarzoneInventoryHintItems.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryHintItems)
	self.id = "WarzoneInventoryHintItems"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backingImage = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	backingImage:setRGB(0.12, 0.12, 0.12)
	backingImage:setAlpha(0)
	backingImage:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_all_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			backingImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(backingImage)
	self.backingImage = backingImage
	local backingImage2 = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	backingImage2:setRGB(0, 0, 0)
	backingImage2:setAlpha(0.9)
	backingImage2:setImage(RegisterImage(0x30BBCD6E666199B))
	self:addElement(backingImage2)
	self.backingImage2 = backingImage2
	local backingImage3 = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	backingImage3:setRGB(0.51, 0.51, 0.51)
	backingImage3:setImage(RegisterImage(0xBE388304168E99F))
	self:addElement(backingImage3)
	self.backingImage3 = backingImage3
	local upImage = CoD.WarzoneDpadButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	upImage:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "open") then
					f3_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "canUseQuickInventory")
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	local leftImage = upImage
	local downImage = upImage.subscribeToModel
	local rightImage = DataSources.WarzoneInventory.getModel(f1_arg1)
	downImage(leftImage, rightImage.open, function(f4_arg0)
		f1_arg0:updateElementState(upImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "open",
		})
	end, false)
	leftImage = upImage
	downImage = upImage.subscribeToModel
	rightImage = DataSources.WarzoneInventory.getModel(f1_arg1)
	downImage(leftImage, rightImage.canUseQuickInventory, function(f5_arg0)
		f1_arg0:updateElementState(upImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "canUseQuickInventory",
		})
	end, false)
	self:addElement(upImage)
	self.upImage = upImage
	downImage = CoD.WarzoneDpadButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	downImage:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "open")
			end,
		},
	})
	rightImage = downImage
	leftImage = downImage.subscribeToModel
	local EMPbacker = DataSources.WarzoneInventory.getModel(f1_arg1)
	leftImage(rightImage, EMPbacker.open, function(f7_arg0)
		f1_arg0:updateElementState(downImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "open",
		})
	end, false)
	downImage:setZRot(180)
	self:addElement(downImage)
	self.downImage = downImage
	leftImage = CoD.WarzoneDpadButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	leftImage:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "open") and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "canNavigateLeft")
			end,
		},
		{
			stateName = "VisibleForCallout",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "open")
			end,
		},
	})
	EMPbacker = leftImage
	rightImage = leftImage.subscribeToModel
	local EMP = DataSources.WarzoneInventory.getModel(f1_arg1)
	rightImage(EMPbacker, EMP.open, function(f10_arg0)
		f1_arg0:updateElementState(leftImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "open",
		})
	end, false)
	EMPbacker = leftImage
	rightImage = leftImage.subscribeToModel
	EMP = DataSources.WarzoneInventory.getModel(f1_arg1)
	rightImage(EMPbacker, EMP.canNavigateLeft, function(f11_arg0)
		f1_arg0:updateElementState(leftImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "canNavigateLeft",
		})
	end, false)
	leftImage:setZRot(90)
	self:addElement(leftImage)
	self.leftImage = leftImage
	rightImage = CoD.WarzoneDpadButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	rightImage:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "open") and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "canNavigateRight")
			end,
		},
		{
			stateName = "VisibleForCallout",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "WarzoneInventory", "open")
			end,
		},
	})
	EMP = rightImage
	EMPbacker = rightImage.subscribeToModel
	local f1_local10 = DataSources.WarzoneInventory.getModel(f1_arg1)
	EMPbacker(EMP, f1_local10.open, function(f14_arg0)
		f1_arg0:updateElementState(rightImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "open",
		})
	end, false)
	EMP = rightImage
	EMPbacker = rightImage.subscribeToModel
	f1_local10 = DataSources.WarzoneInventory.getModel(f1_arg1)
	EMPbacker(EMP, f1_local10.canNavigateRight, function(f15_arg0)
		f1_arg0:updateElementState(rightImage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "canNavigateRight",
		})
	end, false)
	rightImage:setZRot(270)
	self:addElement(rightImage)
	self.rightImage = rightImage
	EMPbacker = LUI.UIImage.new(0, 0, 6, 94, 0, 0, 8, 92)
	EMPbacker:setAlpha(0)
	EMPbacker:setImage(RegisterImage(0x60A7390618CBB74))
	self:addElement(EMPbacker)
	self.EMPbacker = EMPbacker
	EMP = LUI.UIImage.new(0, 0, 6, 94, 0, 0, 7, 91)
	EMP:setAlpha(0)
	EMP:setImage(RegisterImage(0xB3436B57B647EA3))
	EMP:setMaterial(LUI.UIImage.GetCachedMaterial(0xC284ECCBDADEF0B))
	EMP:setShaderVector(0, 35.93, 0, 0, 0)
	EMP:setShaderVector(1, 0.83, 0, 0, 0)
	EMP:setShaderVector(2, 0.49, 0, 0, 0)
	self:addElement(EMP)
	self.EMP = EMP
	self:mergeStateConditions({
		{
			stateName = "TabbedMultiPickupActive",
			condition = function(menu, element, event)
				local f16_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xC9FADA56582F80F])
				if f16_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
						f16_local0 = IsIntDvarNonZero("tabbedMultiItemPickup")
					else
						f16_local0 = false
					end
				end
				return f16_local0
			end,
		},
		{
			stateName = "MultiPickupActive",
			condition = function(menu, element, event)
				local f17_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[0x163CDAE6010C493][0xC9FADA56582F80F])
				if f17_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) then
						f17_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					else
						f17_local0 = false
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				local f18_local0
				if
					not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
					and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1999FA50941A83B])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
				then
					f18_local0 = not CoD.CodCasterUtility.CodCasterEnabledAndProfileVarEqualTo(f1_arg1, "shoutcaster_ds_inventory", false)
				else
					f18_local0 = false
				end
				return f18_local0
			end,
		},
	})
	local f1_local11 = self
	f1_local10 = self.subscribeToModel
	local f1_local12 = DataSources.MultiItemPickup.getModel(f1_arg1)
	f1_local10(f1_local11, f1_local12.status, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "status",
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local11, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1999FA50941A83B]], function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1999FA50941A83B],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local10 = self
	CoD.WZUtility.SetUpPlayClipOnCustomFunction(self, "DefaultClip", f1_arg1, "_cancelInventoryHints")
	CoD.WZUtility.SetUpPlayClipOnCustomFunction(self, "DefaultClip", f1_arg1, "_showInventoryHints")
	CoD.WZUtility.SetUpPlayClipOnCustomFunction(self, "ShowAndFadeOut", f1_arg1, "_showInventoryHints_NoEquip")
	return self
end
CoD.WarzoneInventoryHintItems.__resetProperties = function(f33_arg0)
	f33_arg0.backingImage:completeAnimation()
	f33_arg0.rightImage:completeAnimation()
	f33_arg0.leftImage:completeAnimation()
	f33_arg0.downImage:completeAnimation()
	f33_arg0.upImage:completeAnimation()
	f33_arg0.backingImage2:completeAnimation()
	f33_arg0.backingImage3:completeAnimation()
	f33_arg0.EMP:completeAnimation()
	f33_arg0.EMPbacker:completeAnimation()
	f33_arg0.backingImage:setAlpha(0)
	f33_arg0.rightImage:setAlpha(1)
	f33_arg0.leftImage:setAlpha(1)
	f33_arg0.downImage:setAlpha(1)
	f33_arg0.upImage:setAlpha(1)
	f33_arg0.backingImage2:setAlpha(0.9)
	f33_arg0.backingImage3:setAlpha(1)
	f33_arg0.EMP:setAlpha(0)
	f33_arg0.EMPbacker:setAlpha(0)
end
CoD.WarzoneInventoryHintItems.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			f34_arg0.backingImage:completeAnimation()
			f34_arg0.backingImage:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.backingImage)
		end,
		ShowAndFadeOut = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(5)
			local f35_local0 = function(f36_arg0)
				f35_arg0.backingImage:beginAnimation(3500)
				f35_arg0.backingImage:setAlpha(0)
				f35_arg0.backingImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.backingImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.backingImage:completeAnimation()
			f35_arg0.backingImage:setAlpha(1)
			f35_local0(f35_arg0.backingImage)
			local f35_local1 = function(f37_arg0)
				f35_arg0.upImage:beginAnimation(3500)
				f35_arg0.upImage:setAlpha(0)
				f35_arg0.upImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.upImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.upImage:completeAnimation()
			f35_arg0.upImage:setAlpha(1)
			f35_local1(f35_arg0.upImage)
			local f35_local2 = function(f38_arg0)
				f35_arg0.downImage:beginAnimation(3500)
				f35_arg0.downImage:setAlpha(0)
				f35_arg0.downImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.downImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.downImage:completeAnimation()
			f35_arg0.downImage:setAlpha(1)
			f35_local2(f35_arg0.downImage)
			local f35_local3 = function(f39_arg0)
				f35_arg0.leftImage:beginAnimation(3500)
				f35_arg0.leftImage:setAlpha(0)
				f35_arg0.leftImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.leftImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.leftImage:completeAnimation()
			f35_arg0.leftImage:setAlpha(1)
			f35_local3(f35_arg0.leftImage)
			local f35_local4 = function(f40_arg0)
				f35_arg0.rightImage:beginAnimation(3500)
				f35_arg0.rightImage:setAlpha(0)
				f35_arg0.rightImage:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.rightImage:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.rightImage:completeAnimation()
			f35_arg0.rightImage:setAlpha(0.91)
			f35_local4(f35_arg0.rightImage)
		end,
		Hidden = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(5)
			f41_arg0.backingImage:completeAnimation()
			f41_arg0.backingImage:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.backingImage)
			f41_arg0.upImage:completeAnimation()
			f41_arg0.upImage:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.upImage)
			f41_arg0.downImage:completeAnimation()
			f41_arg0.downImage:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.downImage)
			f41_arg0.leftImage:completeAnimation()
			f41_arg0.leftImage:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.leftImage)
			f41_arg0.rightImage:completeAnimation()
			f41_arg0.rightImage:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.rightImage)
		end,
	},
	TabbedMultiPickupActive = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(7)
			f42_arg0.backingImage:completeAnimation()
			f42_arg0.backingImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.backingImage)
			f42_arg0.backingImage2:completeAnimation()
			f42_arg0.backingImage2:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.backingImage2)
			f42_arg0.backingImage3:completeAnimation()
			f42_arg0.backingImage3:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.backingImage3)
			f42_arg0.upImage:completeAnimation()
			f42_arg0.upImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.upImage)
			f42_arg0.downImage:completeAnimation()
			f42_arg0.downImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.downImage)
			f42_arg0.leftImage:completeAnimation()
			f42_arg0.leftImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.leftImage)
			f42_arg0.rightImage:completeAnimation()
			f42_arg0.rightImage:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.rightImage)
		end,
	},
	MultiPickupActive = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(5)
			f43_arg0.backingImage:completeAnimation()
			f43_arg0.backingImage:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.backingImage)
			f43_arg0.upImage:completeAnimation()
			f43_arg0.upImage:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.upImage)
			f43_arg0.downImage:completeAnimation()
			f43_arg0.downImage:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.downImage)
			f43_arg0.leftImage:completeAnimation()
			f43_arg0.leftImage:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.leftImage)
			f43_arg0.rightImage:completeAnimation()
			f43_arg0.rightImage:setAlpha(0)
			f43_arg0.clipFinished(f43_arg0.rightImage)
		end,
	},
	EMP = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.backingImage:completeAnimation()
			f44_arg0.backingImage:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.backingImage)
			f44_arg0.EMPbacker:completeAnimation()
			f44_arg0.EMPbacker:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.EMPbacker)
			f44_arg0.EMP:completeAnimation()
			f44_arg0.EMP:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.EMP)
		end,
		ShowAndFadeOut = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(5)
			local f45_local0 = function(f46_arg0)
				f45_arg0.backingImage:beginAnimation(3500)
				f45_arg0.backingImage:setAlpha(0)
				f45_arg0.backingImage:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.backingImage:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.backingImage:completeAnimation()
			f45_arg0.backingImage:setAlpha(1)
			f45_local0(f45_arg0.backingImage)
			local f45_local1 = function(f47_arg0)
				f45_arg0.upImage:beginAnimation(3500)
				f45_arg0.upImage:setAlpha(0)
				f45_arg0.upImage:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.upImage:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.upImage:completeAnimation()
			f45_arg0.upImage:setAlpha(1)
			f45_local1(f45_arg0.upImage)
			local f45_local2 = function(f48_arg0)
				f45_arg0.downImage:beginAnimation(3500)
				f45_arg0.downImage:setAlpha(0)
				f45_arg0.downImage:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.downImage:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.downImage:completeAnimation()
			f45_arg0.downImage:setAlpha(1)
			f45_local2(f45_arg0.downImage)
			local f45_local3 = function(f49_arg0)
				f45_arg0.leftImage:beginAnimation(3500)
				f45_arg0.leftImage:setAlpha(0)
				f45_arg0.leftImage:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.leftImage:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.leftImage:completeAnimation()
			f45_arg0.leftImage:setAlpha(1)
			f45_local3(f45_arg0.leftImage)
			local f45_local4 = function(f50_arg0)
				f45_arg0.rightImage:beginAnimation(3500)
				f45_arg0.rightImage:setAlpha(0)
				f45_arg0.rightImage:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.rightImage:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
			end
			f45_arg0.rightImage:completeAnimation()
			f45_arg0.rightImage:setAlpha(0.91)
			f45_local4(f45_arg0.rightImage)
		end,
		Hidden = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(5)
			f51_arg0.backingImage:completeAnimation()
			f51_arg0.backingImage:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.backingImage)
			f51_arg0.upImage:completeAnimation()
			f51_arg0.upImage:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.upImage)
			f51_arg0.downImage:completeAnimation()
			f51_arg0.downImage:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.downImage)
			f51_arg0.leftImage:completeAnimation()
			f51_arg0.leftImage:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.leftImage)
			f51_arg0.rightImage:completeAnimation()
			f51_arg0.rightImage:setAlpha(0)
			f51_arg0.clipFinished(f51_arg0.rightImage)
		end,
	},
}
CoD.WarzoneInventoryHintItems.__onClose = function(f52_arg0)
	f52_arg0.backingImage:close()
	f52_arg0.upImage:close()
	f52_arg0.downImage:close()
	f52_arg0.leftImage:close()
	f52_arg0.rightImage:close()
end
