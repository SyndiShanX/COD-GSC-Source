require("x64:8d1adc2235d1aa2")
require("x64:2cc2c5b13552602")
require("x64:ec068c738d259b9")
CoD.AmmoWidgetWZ = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZ.__defaultWidth = 591
CoD.AmmoWidgetWZ.__defaultHeight = 112
CoD.AmmoWidgetWZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.tankState", 0)
	self:setClass(CoD.AmmoWidgetWZ)
	self.id = "AmmoWidgetWZ"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 160, 588, 0, 0, 23, 89)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local PanelDark = LUI.UIImage.new(0, 0, 297, 589, 0, 0, 23.5, 84.5)
	PanelDark:setRGB(0.18, 0.17, 0.16)
	PanelDark:setAlpha(0.94)
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local PanelLight = LUI.UIImage.new(0, 0, 228, 297, 0, 0, 23.5, 84.5)
	PanelLight:setRGB(0.22, 0.21, 0.19)
	PanelLight:setAlpha(0.75)
	self:addElement(PanelLight)
	self.PanelLight = PanelLight
	local PanelLight2 = LUI.UIImage.new(0, 0, 160, 229, 0, 0, 23.5, 84.5)
	PanelLight2:setRGB(0.22, 0.21, 0.19)
	PanelLight2:setAlpha(0.75)
	self:addElement(PanelLight2)
	self.PanelLight2 = PanelLight2
	local goldenGlint = LUI.UIImage.new(0, 0, 297, 588, 0, 0, 23, 89)
	goldenGlint:setRGB(0.95, 0.76, 0.31)
	goldenGlint:setAlpha(0)
	goldenGlint:setMaterial(LUI.UIImage.GetCachedMaterial(0xDCEC3F40C67FD03))
	goldenGlint:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(goldenGlint)
	self.goldenGlint = goldenGlint
	local StorageSlot = CoD.AmmoWidgetWZ_StorageSlot.new(f1_arg0, f1_arg1, 0, 0, 160, 258, 0, 0, 22, 90)
	StorageSlot:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "storage", function(model)
		StorageSlot:setModel(model, f1_arg1)
	end)
	self:addElement(StorageSlot)
	self.StorageSlot = StorageSlot
	local Frame = LUI.UIImage.new(0, 0, 146, 602, 0, 0, 14, 98)
	Frame:setImage(RegisterImage(0x192903FBEA50B36))
	self:addElement(Frame)
	self.Frame = Frame
	local LEDgraph = LUI.UIImage.new(0, 0, 358.5, 586.5, 0, 0, 23, 87)
	LEDgraph:setRGB(0, 0, 0)
	LEDgraph:setAlpha(0.2)
	LEDgraph:setImage(RegisterImage(0xC841C84F3674732))
	self:addElement(LEDgraph)
	self.LEDgraph = LEDgraph
	local GlowWeapon = LUI.UIImage.new(0, 0, 459, 652, 0, 0, -24.5, 108.5)
	GlowWeapon:setAlpha(0.03)
	GlowWeapon:setImage(RegisterImage(0xD9665F2DAD5E915))
	GlowWeapon:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowWeapon)
	self.GlowWeapon = GlowWeapon
	local StockAmmoWidget2 = CoD.AmmoWidget_StockAmmo.new(f1_arg0, f1_arg1, 0, 0, 336, 533, 0, 0, -15.5, 96.5)
	StockAmmoWidget2:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", nil, function(model)
		StockAmmoWidget2:setModel(model, f1_arg1)
	end)
	self:addElement(StockAmmoWidget2)
	self.StockAmmoWidget2 = StockAmmoWidget2
	local WeaponAmmoCount = CoD.AmmoWidgetWZ_WeaponInfo.new(f1_arg0, f1_arg1, 0, 0, 620, 859, 0, 0, 50, 146)
	WeaponAmmoCount:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", nil, function(model)
		WeaponAmmoCount:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponAmmoCount)
	self.WeaponAmmoCount = WeaponAmmoCount
	local goldenBullet = LUI.UIImage.new(0, 0, 310.5, 342.5, 0, 0, 98, 106)
	goldenBullet:setRGB(0.91, 0.69, 0.16)
	goldenBullet:setImage(RegisterImage(0x6137E42475D0CF1))
	self:addElement(goldenBullet)
	self.goldenBullet = goldenBullet
	local LEDarmor = LUI.UIImage.new(0, 0, 295.5, 359.5, 0, 0, 21, 85)
	LEDarmor:setRGB(0, 0, 0)
	LEDarmor:setAlpha(0.2)
	LEDarmor:setImage(RegisterImage(0xE543F2886150754))
	self:addElement(LEDarmor)
	self.LEDarmor = LEDarmor
	local LED = LUI.UIImage.new(0, 0, 161.5, 229.5, 0, 0, 20, 88)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.2)
	LED:setImage(RegisterImage(0xD9A4F6492B1AE8B))
	self:addElement(LED)
	self.LED = LED
	self:mergeStateConditions({
		{
			stateName = "GoldenBullet",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "goldenBullet", 1)
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local16(f1_local15, f1_local17.goldenBullet, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "goldenBullet",
		})
	end, false)
	StockAmmoWidget2.id = "StockAmmoWidget2"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetWZ.__resetProperties = function(f7_arg0)
	f7_arg0.goldenBullet:completeAnimation()
	f7_arg0.goldenGlint:completeAnimation()
	f7_arg0.goldenBullet:setAlpha(1)
	f7_arg0.goldenGlint:setAlpha(0)
	f7_arg0.goldenGlint:setMaterial(LUI.UIImage.GetCachedMaterial(0xDCEC3F40C67FD03))
	f7_arg0.goldenGlint:setShaderVector(0, 0, 0, 0, 0)
end
CoD.AmmoWidgetWZ.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.goldenBullet:completeAnimation()
			f8_arg0.goldenBullet:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.goldenBullet)
		end,
		GoldenBullet = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(199)
						f12_arg0:setAlpha(0)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(500)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.goldenGlint:beginAnimation(300)
				f9_arg0.goldenGlint:setShaderVector(0, 1, 0, 0, 0)
				f9_arg0.goldenGlint:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.goldenGlint:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.goldenGlint:completeAnimation()
			f9_arg0.goldenGlint:setAlpha(0.3)
			f9_arg0.goldenGlint:setMaterial(LUI.UIImage.GetCachedMaterial(0xDCEC3F40C67FD03))
			f9_arg0.goldenGlint:setShaderVector(0, 0, 0, 0, 0)
			f9_local0(f9_arg0.goldenGlint)
			local f9_local1 = function(f13_arg0)
				f9_arg0.goldenBullet:beginAnimation(300)
				f9_arg0.goldenBullet:setAlpha(1)
				f9_arg0.goldenBullet:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.goldenBullet:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.goldenBullet:completeAnimation()
			f9_arg0.goldenBullet:setAlpha(0)
			f9_local1(f9_arg0.goldenBullet)
		end,
	},
	GoldenBullet = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		PulseEnding = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.goldenBullet:beginAnimation(500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f15_arg0.goldenBullet:setAlpha(0.3)
				f15_arg0.goldenBullet:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.goldenBullet:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.goldenBullet:completeAnimation()
			f15_arg0.goldenBullet:setAlpha(1)
			f15_local0(f15_arg0.goldenBullet)
			f15_arg0.nextClip = "PulseEnding"
		end,
		DefaultState = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.goldenBullet:beginAnimation(200)
				f18_arg0.goldenBullet:setAlpha(0)
				f18_arg0.goldenBullet:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.goldenBullet:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.goldenBullet:completeAnimation()
			f18_arg0.goldenBullet:setAlpha(1)
			f18_local0(f18_arg0.goldenBullet)
		end,
	},
}
CoD.AmmoWidgetWZ.__onClose = function(f20_arg0)
	f20_arg0.StorageSlot:close()
	f20_arg0.StockAmmoWidget2:close()
	f20_arg0.WeaponAmmoCount:close()
end
