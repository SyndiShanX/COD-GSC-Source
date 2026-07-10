CoD.ReticleColorSlot = InheritFrom(LUI.UIElement)
CoD.ReticleColorSlot.__defaultWidth = 110
CoD.ReticleColorSlot.__defaultHeight = 80
CoD.ReticleColorSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReticleColorSlot)
	self.id = "ReticleColorSlot"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.2)
	self:addElement(Backing)
	self.Backing = Backing
	local Image = LUI.UIImage.new(0, 0, 15, 95, 0, 0, 0, 80)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	Image:setShaderVector(0, 0.5, 0.5, 0, 0)
	Image:setShaderVector(1, 1, 1, 0, 0)
	Image:setShaderVector(2, 0, 0, 0, 0)
	Image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local EquippedMarkerBG = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -9, 35)
	EquippedMarkerBG:setAlpha(0)
	EquippedMarkerBG:setZoom(4)
	EquippedMarkerBG:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_bg"))
	EquippedMarkerBG:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(EquippedMarkerBG)
	self.EquippedMarkerBG = EquippedMarkerBG
	local EquippedMarkerTick = LUI.UIImage.new(1, 1, -35, 9, 0, 0, -9, 35)
	EquippedMarkerTick:setAlpha(0)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	local LockedX = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LockedX:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	LockedX:setAlpha(0)
	LockedX:setImage(RegisterImage(@"uie_spawnselect_crosshair_auto"))
	self:addElement(LockedX)
	self.LockedX = LockedX
	local LockedIcon = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	LockedIcon:setAlpha(0)
	LockedIcon:setImage(RegisterImage(@"uie_icon_locks_lock_01"))
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Previewing",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsReticlePreviewing(f1_arg1, element, menu)
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f7_arg1)
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReticleColorSlot.__resetProperties = function(f9_arg0)
	f9_arg0.EquippedMarkerTick:completeAnimation()
	f9_arg0.EquippedMarkerBG:completeAnimation()
	f9_arg0.Backing:completeAnimation()
	f9_arg0.LockedX:completeAnimation()
	f9_arg0.LockedIcon:completeAnimation()
	f9_arg0.Image:completeAnimation()
	f9_arg0.EquippedMarkerTick:setAlpha(0)
	f9_arg0.EquippedMarkerBG:setAlpha(0)
	f9_arg0.Backing:setRGB(0, 0, 0)
	f9_arg0.Backing:setAlpha(0.2)
	f9_arg0.LockedX:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	f9_arg0.LockedX:setAlpha(0)
	f9_arg0.LockedIcon:setRGB(1, 1, 1)
	f9_arg0.LockedIcon:setAlpha(0)
	f9_arg0.Image:setRGB(1, 1, 1)
	f9_arg0.Image:setAlpha(1)
end
CoD.ReticleColorSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		Active = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setRGB(0.41, 0.41, 0.41)
			f11_arg0.clipFinished(f11_arg0.Backing)
			f11_arg0.EquippedMarkerBG:completeAnimation()
			f11_arg0.EquippedMarkerBG:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.EquippedMarkerBG)
			f11_arg0.EquippedMarkerTick:completeAnimation()
			f11_arg0.EquippedMarkerTick:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.EquippedMarkerTick)
		end,
	},
	Locked = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setRGB(0.29, 0.29, 0.29)
			f12_arg0.clipFinished(f12_arg0.Image)
			f12_arg0.LockedX:completeAnimation()
			f12_arg0.LockedX:setRGB(0.29, 0.29, 0.29)
			f12_arg0.LockedX:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.LockedX)
			f12_arg0.LockedIcon:completeAnimation()
			f12_arg0.LockedIcon:setRGB(0.29, 0.29, 0.29)
			f12_arg0.LockedIcon:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.LockedIcon)
		end,
	},
	Previewing = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Backing)
			f13_arg0.Image:completeAnimation()
			f13_arg0.Image:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Image)
		end,
	},
	KBM = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		Active = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.Backing:completeAnimation()
			f15_arg0.Backing:setRGB(0.41, 0.41, 0.41)
			f15_arg0.clipFinished(f15_arg0.Backing)
			f15_arg0.EquippedMarkerBG:completeAnimation()
			f15_arg0.EquippedMarkerBG:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.EquippedMarkerBG)
			f15_arg0.EquippedMarkerTick:completeAnimation()
			f15_arg0.EquippedMarkerTick:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.EquippedMarkerTick)
		end,
		Focus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setRGB(0.41, 0.41, 0.41)
			f16_arg0.clipFinished(f16_arg0.Backing)
			f16_arg0.LockedIcon:completeAnimation()
			f16_arg0.LockedIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.LockedIcon)
		end,
	},
}
CoD.ReticleColorSlot.__onClose = function(f17_arg0)
	f17_arg0.Image:close()
end
