require("x64:50ce70a16679544")
require("x64:2085c7508126617")
require("x64:4929df020ef5e09")
CoD.vhud_hcdx_hud = InheritFrom(LUI.UIElement)
CoD.vhud_hcdx_hud.__defaultWidth = 1920
CoD.vhud_hcdx_hud.__defaultHeight = 1080
CoD.vhud_hcdx_hud.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hcdx_hud)
	self.id = "vhud_hcdx_hud"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	self.vignette02 = LUI.UIElement.createFake()
	local f1_local2 = nil
	self.TiledShaderImage = LUI.UIElement.createFake()
	local CompassGroupMPContainer = CoD.CompassGroupMPContainer.new(f1_arg0, f1_arg1, 0, 0, 77, 427, 0, 0, 68, 418)
	CompassGroupMPContainer:mergeStateConditions({
		{
			stateName = "InvisibleVehicle",
			condition = function(menu, element, event)
				local f2_local0
				if not IsWarzone() then
					f2_local0 = AlwaysFalse()
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	local vhudhcxdtimebar = CompassGroupMPContainer
	local HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["hudItems.playerSpawned"], function(f3_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA]], function(f4_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f5_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f6_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f7_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f8_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f9_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f10_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f11_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f12_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f13_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f14_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f15_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f16_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f17_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f18_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6.PlayerSettingsUpdate, function(f20_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["factions.isCoDCaster"], function(f21_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = DataSources.CodCaster.getModel(f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6.profileSettingsUpdated, function(f22_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["CodCaster.showFullScreenMap"], function(f23_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "CodCaster.showFullScreenMap",
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6.forceScoreboard, function(f24_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	vhudhcxdtimebar = CompassGroupMPContainer
	HUDPCVehicle = CompassGroupMPContainer.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	HUDPCVehicle(vhudhcxdtimebar, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f25_arg0)
		f1_arg0:updateElementState(CompassGroupMPContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	self:addElement(CompassGroupMPContainer)
	self.CompassGroupMPContainer = CompassGroupMPContainer
	HUDPCVehicle = nil
	HUDPCVehicle = CoD.HUD_PC_Vehicle.new(f1_arg0, f1_arg1, 0.5, 0.5, -325, 325, 1, 1, -275, -210)
	HUDPCVehicle:linkToElementModel(self, nil, false, function(model)
		HUDPCVehicle:setModel(model, f1_arg1)
	end)
	self:addElement(HUDPCVehicle)
	self.HUDPCVehicle = HUDPCVehicle
	vhudhcxdtimebar = CoD.vhud_hcxd_timebar.new(f1_arg0, f1_arg1, 1, 1, -362, 0, 1, 1, -94, 0)
	vhudhcxdtimebar:linkToElementModel(self, nil, false, function(model)
		vhudhcxdtimebar:setModel(model, f1_arg1)
	end)
	self:addElement(vhudhcxdtimebar)
	self.vhudhcxdtimebar = vhudhcxdtimebar
	f1_local6 = nil
	self.ButtonLayout = LUI.UIElement.createFake()
	local FuiLayoutTL = LUI.UIImage.new(0, 0, 120, 40, 0, 0, 120, 24)
	FuiLayoutTL:setAlpha(0.15)
	FuiLayoutTL:setXRot(180)
	FuiLayoutTL:setYRot(180)
	FuiLayoutTL:setImage(RegisterImage(0x5338AA8246DD618))
	FuiLayoutTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FuiLayoutTL)
	self.FuiLayoutTL = FuiLayoutTL
	local StripeL = LUI.UIImage.new(0, 0, 134, 354, 0, 0, 34.5, 44.5)
	StripeL:setAlpha(0.05)
	StripeL:setImage(RegisterImage(0x5AFE39B9B2E68FE))
	StripeL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(StripeL)
	self.StripeL = StripeL
	local StripeR = LUI.UIImage.new(1, 1, -353, -133, 0, 0, 34.5, 44.5)
	StripeR:setAlpha(0.05)
	StripeR:setImage(RegisterImage(0x5AFE39B9B2E68FE))
	StripeR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(StripeR)
	self.StripeR = StripeR
	local FuiLayoutTR = LUI.UIImage.new(1, 1, -120, -40, 0, 0, 120, 24)
	FuiLayoutTR:setAlpha(0.15)
	FuiLayoutTR:setXRot(180)
	FuiLayoutTR:setYRot(180)
	FuiLayoutTR:setImage(RegisterImage(0x5338AA8246DD618))
	FuiLayoutTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FuiLayoutTR)
	self.FuiLayoutTR = FuiLayoutTR
	self:mergeStateConditions({
		{
			stateName = "CodCasterHidden",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "TheaterMode",
			condition = function(menu, element, event)
				return IsPC() and IsInTheaterMode()
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["factions.isCoDCaster"], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local12(f1_local11, f1_local13["lobbyRoot.lobbyNav"], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	if IsMouseOrKeyboard(f1_arg1) then
		ReplaceElementWithFake(self, "ButtonLayout")
	end
	return self
end
CoD.vhud_hcdx_hud.__resetProperties = function(f32_arg0)
	f32_arg0.CompassGroupMPContainer:completeAnimation()
	f32_arg0.HUDPCVehicle:completeAnimation()
	f32_arg0.ButtonLayout:completeAnimation()
	f32_arg0.CompassGroupMPContainer:setAlpha(1)
	f32_arg0.HUDPCVehicle:setAlpha(1)
	f32_arg0.ButtonLayout:setAlpha(1)
end
CoD.vhud_hcdx_hud.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
	},
	CodCasterHidden = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.CompassGroupMPContainer:completeAnimation()
			f34_arg0.CompassGroupMPContainer:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.CompassGroupMPContainer)
			f34_arg0.HUDPCVehicle:completeAnimation()
			f34_arg0.HUDPCVehicle:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.HUDPCVehicle)
			f34_arg0.ButtonLayout:completeAnimation()
			f34_arg0.ButtonLayout:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ButtonLayout)
		end,
	},
	TheaterMode = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.CompassGroupMPContainer:completeAnimation()
			f35_arg0.CompassGroupMPContainer:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.CompassGroupMPContainer)
			f35_arg0.HUDPCVehicle:completeAnimation()
			f35_arg0.HUDPCVehicle:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.HUDPCVehicle)
			f35_arg0.ButtonLayout:completeAnimation()
			f35_arg0.ButtonLayout:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.ButtonLayout)
		end,
	},
}
CoD.vhud_hcdx_hud.__onClose = function(f36_arg0)
	f36_arg0.CompassGroupMPContainer:close()
	f36_arg0.HUDPCVehicle:close()
	f36_arg0.vhudhcxdtimebar:close()
	f36_arg0.ButtonLayout:close()
end
