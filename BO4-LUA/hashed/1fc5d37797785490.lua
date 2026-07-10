require("x64:934d3e795785e73")
require("x64:93945e49af17e9d")
require("x64:2012d3c45495393")
require("x64:e7022b38d489ba3")
require("x64:5c14ad695a9a1a8")
require("x64:9679faabe7638d9")
require("x64:3cceba23a026334")
require("x64:dba761763bfd768")
require("x64:60f4c9ffefbf94f")
require("x64:b9c6f6499cb39da")
require("x64:8819c673a5c0a5c")
CoD.vhud_gunship_recticle = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_recticle.__defaultWidth = 1920
CoD.vhud_gunship_recticle.__defaultHeight = 1080
CoD.vhud_gunship_recticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_recticle)
	self.id = "vhud_gunship_recticle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vehicleHudCommonLayout = CoD.vhud_layoutFuiElements.new(f1_arg0, f1_arg1, 0.5, 1.47, -935, -935, 0.5, 0.5, -506, 376)
	self:addElement(vehicleHudCommonLayout)
	self.vehicleHudCommonLayout = vehicleHudCommonLayout
	local layoutPlusGrid = CoD.vhud_layoutPlusGridLarge.new(f1_arg0, f1_arg1, 0.5, 0.5, -441.5, 441.5, 0.5, 0.5, -332.5, 334.5)
	self:addElement(layoutPlusGrid)
	self.layoutPlusGrid = layoutPlusGrid
	local CommonCenterFrame = CoD.vhud_CenterFrame.new(f1_arg0, f1_arg1, 0.5, 1.5, -958.5, -958.5, 0.5, 0.5, -458, 462)
	self:addElement(CommonCenterFrame)
	self.CommonCenterFrame = CommonCenterFrame
	local VehicleHp = CoD.vhud_gunship_health.new(f1_arg0, f1_arg1, 1, 1, -335.5, 17.5, 0.5, 0.5, 253, 486)
	VehicleHp:linkToElementModel(self, nil, false, function(model)
		VehicleHp:setModel(model, f1_arg1)
	end)
	self:addElement(VehicleHp)
	self.VehicleHp = VehicleHp
	local ButtonElements = CoD.vhud_gunship_button_all.new(f1_arg0, f1_arg1, 0.5, 0.5, -529, 529, 1, 1, -328, 0)
	self:addElement(ButtonElements)
	self.ButtonElements = ButtonElements
	local MessageBox = CoD.vhud_gunship_message.new(f1_arg0, f1_arg1, 0.5, 0.5, -249.5, 252.5, 1, 1, -256, 2)
	self:addElement(MessageBox)
	self.MessageBox = MessageBox
	local AltMeterL = CoD.vhud_hellstorm_AltWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 182, 402, 0.5, 0.5, -21.5, 11.5)
	AltMeterL:setYRot(6)
	AltMeterL:linkToElementModel(self, nil, false, function(model)
		AltMeterL:setModel(model, f1_arg1)
	end)
	self:addElement(AltMeterL)
	self.AltMeterL = AltMeterL
	local Speed = CoD.vhud_hellstorm_SpeedWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -398, -178, 0.5, 0.5, -16.5, 16.5)
	Speed:linkToElementModel(self, nil, false, function(model)
		Speed:setModel(model, f1_arg1)
	end)
	self:addElement(Speed)
	self.Speed = Speed
	local FlareCounter = CoD.vhud_gunship_flare_dock.new(f1_arg0, f1_arg1, 0, 0, 394.5, 650.5, 0.5, 0.5, 12.5, 146.5)
	FlareCounter:linkToElementModel(self, nil, false, function(model)
		FlareCounter:setModel(model, f1_arg1)
	end)
	self:addElement(FlareCounter)
	self.FlareCounter = FlareCounter
	local MultiReticle = CoD.vhud_gunship_multi_reticle.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0.5, 0.5, -100, 100)
	MultiReticle:mergeStateConditions({
		{
			stateName = "Ammo40mm",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "selectedWeapon", 2)
			end,
		},
		{
			stateName = "Ammo25mm",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "selectedWeapon", 3)
			end,
		},
	})
	MultiReticle:linkToElementModel(MultiReticle, "selectedWeapon", true, function(model)
		f1_arg0:updateElementState(MultiReticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selectedWeapon",
		})
	end)
	MultiReticle:linkToElementModel(self, nil, false, function(model)
		MultiReticle:setModel(model, f1_arg1)
	end)
	self:addElement(MultiReticle)
	self.MultiReticle = MultiReticle
	local AmmoDock = CoD.vhud_gunship_ammo_dock.new(f1_arg0, f1_arg1, 1, 1, -646, -390, 0.5, 0.5, 12.5, 146.5)
	AmmoDock:mergeStateConditions({
		{
			stateName = "Ammo40mm",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "selectedWeapon", 2)
			end,
		},
		{
			stateName = "Ammo25mm",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "selectedWeapon", 3)
			end,
		},
	})
	AmmoDock:linkToElementModel(AmmoDock, "selectedWeapon", true, function(model)
		f1_arg0:updateElementState(AmmoDock, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "selectedWeapon",
		})
	end)
	AmmoDock:linkToElementModel(self, nil, false, function(model)
		AmmoDock:setModel(model, f1_arg1)
	end)
	self:addElement(AmmoDock)
	self.AmmoDock = AmmoDock
	self:mergeStateConditions({
		{
			stateName = "HiddenCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local13(f1_local12, f1_local14["factions.isCoDCaster"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local13 = self
	if IsPC() then
		SizeToHudArea(self.CommonCenterFrame, f1_arg1)
	end
	f1_local13 = VehicleHp
	if IsPC() then
		SizeToHudArea(f1_local13, f1_arg1)
	end
	return self
end
CoD.vhud_gunship_recticle.__resetProperties = function(f16_arg0)
	f16_arg0.MultiReticle:completeAnimation()
	f16_arg0.layoutPlusGrid:completeAnimation()
	f16_arg0.AmmoDock:completeAnimation()
	f16_arg0.FlareCounter:completeAnimation()
	f16_arg0.vehicleHudCommonLayout:completeAnimation()
	f16_arg0.ButtonElements:completeAnimation()
	f16_arg0.MultiReticle:setAlpha(1)
	f16_arg0.layoutPlusGrid:setAlpha(1)
	f16_arg0.AmmoDock:setAlpha(1)
	f16_arg0.FlareCounter:setAlpha(1)
	f16_arg0.vehicleHudCommonLayout:setAlpha(1)
	f16_arg0.ButtonElements:setAlpha(1)
end
CoD.vhud_gunship_recticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							local f21_local0 = function(f22_arg0)
								local f22_local0 = function(f23_arg0)
									f23_arg0:beginAnimation(19)
									f23_arg0:setAlpha(1)
									f23_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
								end
								f22_arg0:beginAnimation(20)
								f22_arg0:setAlpha(0)
								f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
							end
							f21_arg0:beginAnimation(19)
							f21_arg0:setAlpha(0.9)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
						end
						f20_arg0:beginAnimation(20)
						f20_arg0:setAlpha(0)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(19)
					f19_arg0:setAlpha(0.9)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f17_arg0.vehicleHudCommonLayout:beginAnimation(100)
				f17_arg0.vehicleHudCommonLayout:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.vehicleHudCommonLayout:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.vehicleHudCommonLayout:completeAnimation()
			f17_arg0.vehicleHudCommonLayout:setAlpha(0)
			f17_local0(f17_arg0.vehicleHudCommonLayout)
			local f17_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(100)
					f25_arg0:setAlpha(1)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.layoutPlusGrid:beginAnimation(100)
				f17_arg0.layoutPlusGrid:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.layoutPlusGrid:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f17_arg0.layoutPlusGrid:completeAnimation()
			f17_arg0.layoutPlusGrid:setAlpha(0)
			f17_local1(f17_arg0.layoutPlusGrid)
			local f17_local2 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(100)
					f27_arg0:setAlpha(1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.FlareCounter:beginAnimation(100)
				f17_arg0.FlareCounter:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.FlareCounter:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f17_arg0.FlareCounter:completeAnimation()
			f17_arg0.FlareCounter:setAlpha(0)
			f17_local2(f17_arg0.FlareCounter)
			local f17_local3 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(50)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.MultiReticle:beginAnimation(250)
				f17_arg0.MultiReticle:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.MultiReticle:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f17_arg0.MultiReticle:completeAnimation()
			f17_arg0.MultiReticle:setAlpha(0)
			f17_local3(f17_arg0.MultiReticle)
			local f17_local4 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(100)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.AmmoDock:beginAnimation(100)
				f17_arg0.AmmoDock:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AmmoDock:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f17_arg0.AmmoDock:completeAnimation()
			f17_arg0.AmmoDock:setAlpha(0)
			f17_local4(f17_arg0.AmmoDock)
		end,
	},
	HiddenCodCaster = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.ButtonElements:completeAnimation()
			f32_arg0.ButtonElements:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ButtonElements)
		end,
	},
}
CoD.vhud_gunship_recticle.__onClose = function(f33_arg0)
	f33_arg0.vehicleHudCommonLayout:close()
	f33_arg0.layoutPlusGrid:close()
	f33_arg0.CommonCenterFrame:close()
	f33_arg0.VehicleHp:close()
	f33_arg0.ButtonElements:close()
	f33_arg0.MessageBox:close()
	f33_arg0.AltMeterL:close()
	f33_arg0.Speed:close()
	f33_arg0.FlareCounter:close()
	f33_arg0.MultiReticle:close()
	f33_arg0.AmmoDock:close()
end
