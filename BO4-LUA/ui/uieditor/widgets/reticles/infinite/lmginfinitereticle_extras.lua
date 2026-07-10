CoD.lmgInfiniteReticle_Extras = InheritFrom(LUI.UIElement)
CoD.lmgInfiniteReticle_Extras.__defaultWidth = 177
CoD.lmgInfiniteReticle_Extras.__defaultHeight = 27
CoD.lmgInfiniteReticle_Extras.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.lmgInfiniteReticle_Extras)
	self.id = "lmgInfiniteReticle_Extras"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local extras = LUI.UIImage.new(0, 0, 0, 34, 0, 0, 0, 15)
	extras:setAlpha(0.5)
	extras:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras1"))
	extras:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras)
	self.extras = extras
	local extras0 = LUI.UIImage.new(0, 0, 93, 127, 0, 0, 0, 15)
	extras0:setAlpha(0.5)
	extras0:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras1"))
	extras0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras0)
	self.extras0 = extras0
	local extras00 = LUI.UIImage.new(0, 0, 1, 30, 0, 0, 10, 25)
	extras00:setAlpha(0.5)
	extras00:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras1"))
	extras00:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras00)
	self.extras00 = extras00
	local extras000 = LUI.UIImage.new(0, 0, 95, 123, 0, 0, 10, 25)
	extras000:setAlpha(0.5)
	extras000:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras1"))
	extras000:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras000)
	self.extras000 = extras000
	local extras001 = LUI.UIImage.new(0, 0, 99, 176, 0, 0, 4, 15)
	extras001:setAlpha(0.75)
	extras001:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras4"))
	extras001:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras001)
	self.extras001 = extras001
	local extras0010 = LUI.UIImage.new(0, 0, 99, 152, 0, 0, 15, 27)
	extras0010:setAlpha(0.75)
	extras0010:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras6"))
	extras0010:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras0010)
	self.extras0010 = extras0010
	local extras00100 = LUI.UIImage.new(0, 0, 6, 59, 0, 0, 5, 14)
	extras00100:setAlpha(0.75)
	extras00100:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras3"))
	extras00100:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras00100)
	self.extras00100 = extras00100
	local extras001000 = LUI.UIImage.new(0, 0, 6, 60, 0, 0, 15, 27)
	extras001000:setAlpha(0.75)
	extras001000:setImage(RegisterImage(@"uie_t7_weapon_lmg_screen_extras5"))
	extras001000:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(extras001000)
	self.extras001000 = extras001000
	self:mergeStateConditions({
		{
			stateName = "Printing",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lmgInfiniteState", Enum[@"lmginfinitestate"][@"lmg_infinite_state_printing"])
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
		{
			stateName = "EmptyMagazine",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lmgInfiniteState", Enum[@"lmginfinitestate"][@"lmg_infinite_state_empty"])
			end,
		},
	})
	self:linkToElementModel(self, "lmgInfiniteState", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lmgInfiniteState",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
