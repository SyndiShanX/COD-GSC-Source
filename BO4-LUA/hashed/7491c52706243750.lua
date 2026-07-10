CoD.SpawnRegionName = InheritFrom(LUI.UIElement)
CoD.SpawnRegionName.__defaultWidth = 80
CoD.SpawnRegionName.__defaultHeight = 80
CoD.SpawnRegionName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnRegionName)
	self.id = "SpawnRegionName"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DangerBacking = LUI.UIImage.new(0, 0, -16.5, 96.5, 0, 0, 66, 90)
	DangerBacking:setRGB(0.1, 0.1, 0.1)
	DangerBacking:setAlpha(0)
	self:addElement(DangerBacking)
	self.DangerBacking = DangerBacking
	local DangerText = LUI.UIText.new(0, 0, -39.5, 119.5, 0, 0, 68, 88)
	DangerText:setRGB(1, 0, 0)
	DangerText:setAlpha(0)
	DangerText:setText(Engine[0xF9F1239CFD921FE](0x57915A72383BA7C))
	DangerText:setTTF("0arame_mono_stencil")
	DangerText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DangerText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DangerText)
	self.DangerText = DangerText
	local TimerBacking = LUI.UIImage.new(0, 0, -16.5, 96.5, 0, 0, 91.5, 128.5)
	TimerBacking:setRGB(0.1, 0.1, 0.1)
	TimerBacking:setAlpha(0)
	self:addElement(TimerBacking)
	self.TimerBacking = TimerBacking
	local HardpointTimer = LUI.UIText.new(0, 0, 13.5, 66.5, 0, 0, 91.5, 128.5)
	HardpointTimer:setAlpha(0)
	HardpointTimer:setTTF("default")
	HardpointTimer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	HardpointTimer:setupBombTimer(0, true)
	self:addElement(HardpointTimer)
	self.HardpointTimer = HardpointTimer
	local SpawnBeaconIcon = LUI.UIImage.new(0, 0, 16, 64, 0, 0, 16, 64)
	SpawnBeaconIcon:setImage(RegisterImage(0x5C6AA755A21F500))
	self:addElement(SpawnBeaconIcon)
	self.SpawnBeaconIcon = SpawnBeaconIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnRegionName.__resetProperties = function(f2_arg0)
	f2_arg0.DangerBacking:completeAnimation()
	f2_arg0.DangerText:completeAnimation()
	f2_arg0.HardpointTimer:completeAnimation()
	f2_arg0.TimerBacking:completeAnimation()
	f2_arg0.DangerBacking:setRGB(0.1, 0.1, 0.1)
	f2_arg0.DangerBacking:setAlpha(0)
	f2_arg0.DangerText:setLeftRight(0, 0, -39.5, 119.5)
	f2_arg0.DangerText:setTopBottom(0, 0, 68, 88)
	f2_arg0.DangerText:setRGB(1, 0, 0)
	f2_arg0.DangerText:setAlpha(0)
	f2_arg0.DangerText:setText(Engine[0xF9F1239CFD921FE](0x57915A72383BA7C))
	f2_arg0.HardpointTimer:setLeftRight(0, 0, 13.5, 66.5)
	f2_arg0.HardpointTimer:setTopBottom(0, 0, 91.5, 128.5)
	f2_arg0.HardpointTimer:setAlpha(0)
	f2_arg0.TimerBacking:setAlpha(0)
end
CoD.SpawnRegionName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.DangerBacking:completeAnimation()
			f3_arg0.DangerBacking:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.DangerBacking)
			f3_arg0.DangerText:completeAnimation()
			f3_arg0.DangerText:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.DangerText)
		end,
	},
	Destroyed = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.DangerBacking:completeAnimation()
			f4_arg0.DangerBacking:setRGB(0.15, 0.15, 0.15)
			f4_arg0.DangerBacking:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DangerBacking)
			f4_arg0.DangerText:completeAnimation()
			f4_arg0.DangerText:setLeftRight(0, 0, -39.5, 119.5)
			f4_arg0.DangerText:setTopBottom(0, 0, 69, 89)
			f4_arg0.DangerText:setRGB(0.58, 0.58, 0.58)
			f4_arg0.DangerText:setAlpha(0)
			f4_arg0.DangerText:setText(Engine[0xF9F1239CFD921FE](0x5630C8431CF6803))
			f4_arg0.clipFinished(f4_arg0.DangerText)
		end,
	},
	ThreatLow = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.DangerBacking:completeAnimation()
			f5_arg0.DangerBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.DangerBacking)
			f5_arg0.DangerText:completeAnimation()
			f5_arg0.DangerText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.DangerText)
		end,
	},
	ThreatMedium = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.DangerBacking:completeAnimation()
			f6_arg0.DangerBacking:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DangerBacking)
			f6_arg0.DangerText:completeAnimation()
			f6_arg0.DangerText:setRGB(1, 0.61, 0)
			f6_arg0.DangerText:setAlpha(0)
			f6_arg0.DangerText:setText(Engine[0xF9F1239CFD921FE](0xE1A66DD4446C000))
			f6_arg0.clipFinished(f6_arg0.DangerText)
		end,
	},
	ThreatHigh = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.DangerBacking:completeAnimation()
			f7_arg0.DangerBacking:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.DangerBacking)
			f7_arg0.DangerText:completeAnimation()
			f7_arg0.DangerText:setLeftRight(0, 0, -39.5, 119.5)
			f7_arg0.DangerText:setTopBottom(0, 0, 68, 88)
			f7_arg0.DangerText:setRGB(1, 0, 0)
			f7_arg0.DangerText:setAlpha(0)
			f7_arg0.DangerText:setText(Engine[0xF9F1239CFD921FE](0x57915A72383BA7C))
			f7_arg0.clipFinished(f7_arg0.DangerText)
		end,
	},
	DisabledEMP = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.DangerBacking:completeAnimation()
			f8_arg0.DangerBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DangerBacking)
			f8_arg0.DangerText:completeAnimation()
			f8_arg0.DangerText:setRGB(0.58, 0.58, 0.58)
			f8_arg0.DangerText:setAlpha(0)
			f8_arg0.DangerText:setText(Engine[0xF9F1239CFD921FE](0x94EB0E3329EDF5F))
			f8_arg0.clipFinished(f8_arg0.DangerText)
			f8_arg0.TimerBacking:completeAnimation()
			f8_arg0.TimerBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TimerBacking)
			f8_arg0.HardpointTimer:completeAnimation()
			f8_arg0.HardpointTimer:setLeftRight(0, 0, 13.5, 66.5)
			f8_arg0.HardpointTimer:setTopBottom(0, 0, 91.5, 128.5)
			f8_arg0.HardpointTimer:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.HardpointTimer)
		end,
	},
	ManualDisabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.DangerBacking:completeAnimation()
			f9_arg0.DangerBacking:setRGB(0.15, 0.15, 0.15)
			f9_arg0.DangerBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DangerBacking)
			f9_arg0.DangerText:completeAnimation()
			f9_arg0.DangerText:setLeftRight(0, 0, -39.5, 119.5)
			f9_arg0.DangerText:setTopBottom(0, 0, 69, 89)
			f9_arg0.DangerText:setRGB(0.58, 0.58, 0.58)
			f9_arg0.DangerText:setAlpha(0)
			f9_arg0.DangerText:setText(Engine[0xF9F1239CFD921FE](0xA1B60EEA7D768AB))
			f9_arg0.clipFinished(f9_arg0.DangerText)
		end,
	},
}
