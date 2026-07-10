require("x64:6eed72e6ec8da5d")
require("x64:d1a5ef064d0dc15")
require("x64:ab8025bd81e5292")
require("x64:c15ecc89a7a6ff0")
CoD.lmgInfiniteReticle_UI3D_Internal = InheritFrom(LUI.UIElement)
CoD.lmgInfiniteReticle_UI3D_Internal.__defaultWidth = 321
CoD.lmgInfiniteReticle_UI3D_Internal.__defaultHeight = 138
CoD.lmgInfiniteReticle_UI3D_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.lmgInfiniteReticle_UI3D_Internal)
	self.id = "lmgInfiniteReticle_UI3D_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bg0 = LUI.UIImage.new(0, 0, -15, 337, 0, 0, -17, 160)
	Bg0:setAlpha(0.25)
	Bg0:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_bg"))
	Bg0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bg0)
	self.Bg0 = Bg0
	local Bg = LUI.UIImage.new(0, 0, -17, 334, 0, 0, -16, 161)
	Bg:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_bg_add"))
	Bg:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bg)
	self.Bg = Bg
	local AmmoBarTop = CoD.lmgInfiniteReticle_AmmoBar.new(f1_arg0, f1_arg1, 0, 0, 67, 255, 0, 0, 44, 68)
	AmmoBarTop:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "ammoInClip", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			AmmoBarTop.ammoFull:setShaderVector(0, ScaleVectorComponents(2, 1, 1, 1, CoD.HUDUtility.GetAmmoWipePercentageClipFull(f1_arg1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))))
		end
	end)
	self:addElement(AmmoBarTop)
	self.AmmoBarTop = AmmoBarTop
	local AmmoBarBottom = CoD.lmgInfiniteReticle_AmmoBar.new(f1_arg0, f1_arg1, 0, 0, 67, 255, 0, 0, 70, 92)
	AmmoBarBottom:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "ammoInClip", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AmmoBarBottom.ammoFull:setShaderVector(0, ScaleVectorComponents(2, 1, 1, 1, AddToVector(-0.5, 0, 0, 0, CoD.HUDUtility.GetAmmoWipePercentageClipFull(f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))))
		end
	end)
	self:addElement(AmmoBarBottom)
	self.AmmoBarBottom = AmmoBarBottom
	local Status = CoD.lmgInfiniteReticle_Status.new(f1_arg0, f1_arg1, 0, 0, 62, 264, 0, 0, 9, 43)
	Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4ADE90237E6498C0"))
	self:addElement(Status)
	self.Status = Status
	local lmgInfiniteReticleExtras = CoD.lmgInfiniteReticle_Extras.new(f1_arg0, f1_arg1, 0, 0, 68, 261, 0, 0, 97, 124)
	lmgInfiniteReticleExtras:setScale(1.05, 1.05)
	self:addElement(lmgInfiniteReticleExtras)
	self.lmgInfiniteReticleExtras = lmgInfiniteReticleExtras
	local lightRight = LUI.UIImage.new(0, 0, 242, 336, 0, 0, 5, 134)
	lightRight:setYRot(180)
	lightRight:setImage(RegisterImage(@"uie_t7_weapon_lmg_lights_02"))
	lightRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(lightRight)
	self.lightRight = lightRight
	local lightsLeft = LUI.UIImage.new(0, 0, -17, 77, 0, 0, 5, 134)
	lightsLeft:setImage(RegisterImage(@"uie_t7_weapon_lmg_lights_02"))
	lightsLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(lightsLeft)
	self.lightsLeft = lightsLeft
	local lmgInfiniteReticlelightLeft = CoD.lmgInfiniteReticle_light.new(f1_arg0, f1_arg1, 0.5, 0.5, -177, -83, 0.5, 0.5, -65, 64)
	self:addElement(lmgInfiniteReticlelightLeft)
	self.lmgInfiniteReticlelightLeft = lmgInfiniteReticlelightLeft
	local lmgInfiniteReticlelightRight = CoD.lmgInfiniteReticle_light.new(f1_arg0, f1_arg1, 0.5, 0.5, 81, 175, 0.5, 0.5, -65, 64)
	lmgInfiniteReticlelightRight:setYRot(180)
	self:addElement(lmgInfiniteReticlelightRight)
	self.lmgInfiniteReticlelightRight = lmgInfiniteReticlelightRight
	local Bg10 = LUI.UIImage.new(0, 0, -17, 334, 0, 0, -16, 161)
	Bg10:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_bg_add2"))
	Bg10:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bg10)
	self.Bg10 = Bg10
	local Bg100 = LUI.UIImage.new(0, 0, -17, 334, 0, 0, -16, 161)
	Bg100:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_bg_add2"))
	Bg100:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bg100)
	self.Bg100 = Bg100
	local lightsLeft0 = LUI.UIImage.new(0, 0, -17, 77, 0, 0, 5, 134)
	lightsLeft0:setAlpha(0)
	lightsLeft0:setImage(RegisterImage(@"uie_t7_weapon_lmg_lights_02"))
	lightsLeft0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(lightsLeft0)
	self.lightsLeft0 = lightsLeft0
	local lightRight0 = LUI.UIImage.new(0, 0, 242, 336, 0, 0, 5, 134)
	lightRight0:setAlpha(0)
	lightRight0:setYRot(180)
	lightRight0:setImage(RegisterImage(@"uie_t7_weapon_lmg_lights_02"))
	lightRight0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(lightRight0)
	self.lightRight0 = lightRight0
	self:mergeStateConditions({
		{
			stateName = "LowAmmoPrinting",
			condition = function(menu, element, event)
				return IsLowAmmoClip(f1_arg1) and CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lmgInfiniteState", Enum[@"lmginfinitestate"][@"lmg_infinite_state_printing"])
			end,
		},
		{
			stateName = "Printing",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lmgInfiniteState", Enum[@"lmginfinitestate"][@"lmg_infinite_state_printing"])
			end,
		},
		{
			stateName = "EmptyMagazine",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lmgInfiniteState", Enum[@"lmginfinitestate"][@"lmg_infinite_state_empty"])
			end,
		},
		{
			stateName = "Last25",
			condition = function(menu, element, event)
				return IsLowAmmoClip(f1_arg1)
			end,
		},
		{
			stateName = "WeaponFiring",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lmgInfiniteState", Enum[@"lmginfinitestate"][@"lmg_infinite_state_firing"])
			end,
		},
		{
			stateName = "MagazineFull",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lmgInfiniteState", Enum[@"lmginfinitestate"][@"lmg_infinite_state_full"])
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local16(f1_local15, f1_local17.ammoLow, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "ammoLow",
		})
	end, false)
	self:linkToElementModel(self, "lmgInfiniteState", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lmgInfiniteState",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.lmgInfiniteReticle_UI3D_Internal.__resetProperties = function(f12_arg0)
	f12_arg0.Bg0:completeAnimation()
	f12_arg0.Status:completeAnimation()
	f12_arg0.AmmoBarTop:completeAnimation()
	f12_arg0.AmmoBarBottom:completeAnimation()
	f12_arg0.lightRight:completeAnimation()
	f12_arg0.lightsLeft:completeAnimation()
	f12_arg0.lightRight0:completeAnimation()
	f12_arg0.lightsLeft0:completeAnimation()
	f12_arg0.lmgInfiniteReticlelightLeft:completeAnimation()
	f12_arg0.lmgInfiniteReticlelightRight:completeAnimation()
	f12_arg0.lmgInfiniteReticleExtras:completeAnimation()
	f12_arg0.Bg:completeAnimation()
	f12_arg0.Bg10:completeAnimation()
	f12_arg0.Bg100:completeAnimation()
	f12_arg0.Bg0:setRGB(1, 1, 1)
	f12_arg0.Bg0:setAlpha(0.25)
	f12_arg0.Bg0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	f12_arg0.Status:setRGB(1, 1, 1)
	f12_arg0.Status.FrameTop:setRGB(1, 1, 1)
	f12_arg0.Status.FrameBottom:setRGB(1, 1, 1)
	f12_arg0.Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4ADE90237E6498C0"))
	f12_arg0.AmmoBarTop.ammoFull:setRGB(0.33, 0.95, 0.81)
	f12_arg0.AmmoBarBottom.ammoFull:setRGB(0.33, 0.95, 0.81)
	f12_arg0.lightRight:setRGB(1, 1, 1)
	f12_arg0.lightRight:setAlpha(1)
	f12_arg0.lightsLeft:setRGB(1, 1, 1)
	f12_arg0.lightsLeft:setAlpha(1)
	f12_arg0.lightRight0:setRGB(1, 1, 1)
	f12_arg0.lightRight0:setAlpha(0)
	f12_arg0.lightsLeft0:setRGB(1, 1, 1)
	f12_arg0.lightsLeft0:setAlpha(0)
	f12_arg0.lmgInfiniteReticlelightLeft:setAlpha(1)
	f12_arg0.lmgInfiniteReticlelightRight:setAlpha(1)
	f12_arg0.lmgInfiniteReticleExtras:setRGB(1, 1, 1)
	f12_arg0.Bg:setRGB(1, 1, 1)
	f12_arg0.Bg10:setRGB(1, 1, 1)
	f12_arg0.Bg100:setRGB(1, 1, 1)
end
CoD.lmgInfiniteReticle_UI3D_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Bg0:completeAnimation()
			f13_arg0.Bg0:setAlpha(0.38)
			f13_arg0.clipFinished(f13_arg0.Bg0)
		end,
	},
	LowAmmoPrinting = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.AmmoBarTop:completeAnimation()
			f14_arg0.AmmoBarTop.ammoFull:completeAnimation()
			f14_arg0.AmmoBarTop.ammoFull:setRGB(1, 0, 0)
			f14_arg0.clipFinished(f14_arg0.AmmoBarTop)
			f14_arg0.AmmoBarBottom:completeAnimation()
			f14_arg0.AmmoBarBottom.ammoFull:completeAnimation()
			f14_arg0.AmmoBarBottom.ammoFull:setRGB(1, 0, 0)
			f14_arg0.clipFinished(f14_arg0.AmmoBarBottom)
			f14_arg0.Status:completeAnimation()
			f14_arg0.Status.Status:completeAnimation()
			f14_arg0.Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2E1F5BC23CBDE755"))
			f14_arg0.clipFinished(f14_arg0.Status)
		end,
	},
	Printing = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.AmmoBarTop:completeAnimation()
			f15_arg0.clipFinished(f15_arg0.AmmoBarTop)
			f15_arg0.AmmoBarBottom:completeAnimation()
			f15_arg0.clipFinished(f15_arg0.AmmoBarBottom)
			f15_arg0.Status:completeAnimation()
			f15_arg0.Status.Status:completeAnimation()
			f15_arg0.Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2E1F5BC23CBDE755"))
			f15_arg0.clipFinished(f15_arg0.Status)
			f15_arg0.lightRight:completeAnimation()
			f15_arg0.lightRight:setAlpha(0.65)
			f15_arg0.clipFinished(f15_arg0.lightRight)
			f15_arg0.lightsLeft:completeAnimation()
			f15_arg0.lightsLeft:setAlpha(0.65)
			f15_arg0.clipFinished(f15_arg0.lightsLeft)
			f15_arg0.lightsLeft0:completeAnimation()
			f15_arg0.lightsLeft0:setAlpha(0.1)
			f15_arg0.clipFinished(f15_arg0.lightsLeft0)
			f15_arg0.lightRight0:completeAnimation()
			f15_arg0.lightRight0:setAlpha(0.1)
			f15_arg0.clipFinished(f15_arg0.lightRight0)
		end,
		MagazineFull = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(6)
			f16_arg0.AmmoBarTop:completeAnimation()
			f16_arg0.clipFinished(f16_arg0.AmmoBarTop)
			f16_arg0.AmmoBarBottom:completeAnimation()
			f16_arg0.clipFinished(f16_arg0.AmmoBarBottom)
			local f16_local0 = function(f17_arg0)
				f16_arg0.lightRight:beginAnimation(590)
				f16_arg0.lightRight:setAlpha(1)
				f16_arg0.lightRight:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.lightRight:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.lightRight:completeAnimation()
			f16_arg0.lightRight:setAlpha(0.5)
			f16_local0(f16_arg0.lightRight)
			local f16_local1 = function(f18_arg0)
				f16_arg0.lightsLeft:beginAnimation(590)
				f16_arg0.lightsLeft:setAlpha(1)
				f16_arg0.lightsLeft:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.lightsLeft:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.lightsLeft:completeAnimation()
			f16_arg0.lightsLeft:setAlpha(0.5)
			f16_local1(f16_arg0.lightsLeft)
			local f16_local2 = function(f19_arg0)
				f16_arg0.lmgInfiniteReticlelightLeft:beginAnimation(590)
				f16_arg0.lmgInfiniteReticlelightLeft:setAlpha(0)
				f16_arg0.lmgInfiniteReticlelightLeft:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.lmgInfiniteReticlelightLeft:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.lmgInfiniteReticlelightLeft:completeAnimation()
			f16_arg0.lmgInfiniteReticlelightLeft:setAlpha(1)
			f16_local2(f16_arg0.lmgInfiniteReticlelightLeft)
			local f16_local3 = function(f20_arg0)
				f16_arg0.lmgInfiniteReticlelightRight:beginAnimation(590)
				f16_arg0.lmgInfiniteReticlelightRight:setAlpha(0)
				f16_arg0.lmgInfiniteReticlelightRight:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.lmgInfiniteReticlelightRight:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.lmgInfiniteReticlelightRight:completeAnimation()
			f16_arg0.lmgInfiniteReticlelightRight:setAlpha(1)
			f16_local3(f16_arg0.lmgInfiniteReticlelightRight)
		end,
	},
	EmptyMagazine = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(14)
			f21_arg0.Bg0:completeAnimation()
			f21_arg0.Bg0:setRGB(1, 0, 0)
			f21_arg0.Bg0:setAlpha(1)
			f21_arg0.Bg0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
			f21_arg0.clipFinished(f21_arg0.Bg0)
			f21_arg0.Bg:completeAnimation()
			f21_arg0.Bg:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.Bg)
			f21_arg0.AmmoBarTop:completeAnimation()
			f21_arg0.AmmoBarTop.ammoFull:completeAnimation()
			f21_arg0.AmmoBarTop.ammoFull:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.AmmoBarTop)
			f21_arg0.AmmoBarBottom:completeAnimation()
			f21_arg0.AmmoBarBottom.ammoFull:completeAnimation()
			f21_arg0.AmmoBarBottom.ammoFull:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.AmmoBarBottom)
			f21_arg0.Status:completeAnimation()
			f21_arg0.Status.FrameTop:completeAnimation()
			f21_arg0.Status.FrameBottom:completeAnimation()
			f21_arg0.Status.Status:completeAnimation()
			f21_arg0.Status:setRGB(1, 0, 0)
			f21_arg0.Status.FrameTop:setRGB(1, 0, 0)
			f21_arg0.Status.FrameBottom:setRGB(1, 0, 0)
			f21_arg0.Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_74D7427BD9FB2F2"))
			f21_arg0.clipFinished(f21_arg0.Status)
			f21_arg0.lmgInfiniteReticleExtras:completeAnimation()
			f21_arg0.lmgInfiniteReticleExtras:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.lmgInfiniteReticleExtras)
			f21_arg0.lightRight:completeAnimation()
			f21_arg0.lightRight:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.lightRight)
			f21_arg0.lightsLeft:completeAnimation()
			f21_arg0.lightsLeft:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.lightsLeft)
			f21_arg0.lmgInfiniteReticlelightLeft:completeAnimation()
			f21_arg0.lmgInfiniteReticlelightLeft:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.lmgInfiniteReticlelightLeft)
			f21_arg0.lmgInfiniteReticlelightRight:completeAnimation()
			f21_arg0.lmgInfiniteReticlelightRight:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.lmgInfiniteReticlelightRight)
			f21_arg0.Bg10:completeAnimation()
			f21_arg0.Bg10:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.Bg10)
			f21_arg0.Bg100:completeAnimation()
			f21_arg0.Bg100:setRGB(1, 0, 0)
			f21_arg0.clipFinished(f21_arg0.Bg100)
			f21_arg0.lightsLeft0:completeAnimation()
			f21_arg0.lightsLeft0:setRGB(1, 0, 0)
			f21_arg0.lightsLeft0:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.lightsLeft0)
			f21_arg0.lightRight0:completeAnimation()
			f21_arg0.lightRight0:setRGB(1, 0, 0)
			f21_arg0.lightRight0:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.lightRight0)
		end,
	},
	Last25 = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.AmmoBarTop:completeAnimation()
			f22_arg0.AmmoBarTop.ammoFull:completeAnimation()
			f22_arg0.AmmoBarTop.ammoFull:setRGB(1, 0, 0)
			f22_arg0.clipFinished(f22_arg0.AmmoBarTop)
			f22_arg0.AmmoBarBottom:completeAnimation()
			f22_arg0.AmmoBarBottom.ammoFull:completeAnimation()
			f22_arg0.AmmoBarBottom.ammoFull:setRGB(1, 0, 0)
			f22_arg0.clipFinished(f22_arg0.AmmoBarBottom)
			f22_arg0.Status:completeAnimation()
			f22_arg0.Status.Status:completeAnimation()
			f22_arg0.Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_11805DFD9DFF5613"))
			f22_arg0.clipFinished(f22_arg0.Status)
		end,
	},
	WeaponFiring = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(7)
			f23_arg0.AmmoBarTop:completeAnimation()
			f23_arg0.clipFinished(f23_arg0.AmmoBarTop)
			f23_arg0.AmmoBarBottom:completeAnimation()
			f23_arg0.clipFinished(f23_arg0.AmmoBarBottom)
			f23_arg0.Status:completeAnimation()
			f23_arg0.Status.Status:completeAnimation()
			f23_arg0.Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_11805DFD9DFF5613"))
			f23_arg0.clipFinished(f23_arg0.Status)
			f23_arg0.lmgInfiniteReticlelightLeft:completeAnimation()
			f23_arg0.lmgInfiniteReticlelightLeft:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.lmgInfiniteReticlelightLeft)
			f23_arg0.lmgInfiniteReticlelightRight:completeAnimation()
			f23_arg0.lmgInfiniteReticlelightRight:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.lmgInfiniteReticlelightRight)
			f23_arg0.lightsLeft0:completeAnimation()
			f23_arg0.lightsLeft0:setAlpha(0.15)
			f23_arg0.clipFinished(f23_arg0.lightsLeft0)
			f23_arg0.lightRight0:completeAnimation()
			f23_arg0.lightRight0:setAlpha(0.15)
			f23_arg0.clipFinished(f23_arg0.lightRight0)
		end,
	},
	MagazineFull = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(7)
			f24_arg0.AmmoBarTop:completeAnimation()
			f24_arg0.clipFinished(f24_arg0.AmmoBarTop)
			f24_arg0.AmmoBarBottom:completeAnimation()
			f24_arg0.clipFinished(f24_arg0.AmmoBarBottom)
			f24_arg0.Status:completeAnimation()
			f24_arg0.Status.Status:completeAnimation()
			f24_arg0.Status.Status:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4ADE90237E6498C0"))
			f24_arg0.clipFinished(f24_arg0.Status)
			f24_arg0.lmgInfiniteReticlelightLeft:completeAnimation()
			f24_arg0.lmgInfiniteReticlelightLeft:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.lmgInfiniteReticlelightLeft)
			f24_arg0.lmgInfiniteReticlelightRight:completeAnimation()
			f24_arg0.lmgInfiniteReticlelightRight:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.lmgInfiniteReticlelightRight)
			f24_arg0.lightsLeft0:completeAnimation()
			f24_arg0.lightsLeft0:setAlpha(0.15)
			f24_arg0.clipFinished(f24_arg0.lightsLeft0)
			f24_arg0.lightRight0:completeAnimation()
			f24_arg0.lightRight0:setAlpha(0.15)
			f24_arg0.clipFinished(f24_arg0.lightRight0)
		end,
	},
}
CoD.lmgInfiniteReticle_UI3D_Internal.__onClose = function(f25_arg0)
	f25_arg0.AmmoBarTop:close()
	f25_arg0.AmmoBarBottom:close()
	f25_arg0.Status:close()
	f25_arg0.lmgInfiniteReticleExtras:close()
	f25_arg0.lmgInfiniteReticlelightLeft:close()
	f25_arg0.lmgInfiniteReticlelightRight:close()
end
