require("x64:19c1945d2e472b0")
require("x64:4858a496499ed06")
CoD.vhud_attack_helicopter_flare_counter = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_flare_counter.__defaultWidth = 148
CoD.vhud_attack_helicopter_flare_counter.__defaultHeight = 118
CoD.vhud_attack_helicopter_flare_counter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_flare_counter)
	self.id = "vhud_attack_helicopter_flare_counter"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local BackingFillAnim = LUI.UIImage.new(0.03, 0.03, -1, 140, 0.03, 0.03, 0, 99)
	BackingFillAnim:setRGB(0.13, 0.13, 0.13)
	BackingFillAnim:setAlpha(0.9)
	BackingFillAnim:setZRot(180)
	BackingFillAnim:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	BackingFillAnim:setShaderVector(0, 1, 0, 0, 0)
	BackingFillAnim:setShaderVector(1, 0, 0, 0, 0)
	BackingFillAnim:setShaderVector(2, 1, 0, 0, 0)
	BackingFillAnim:setShaderVector(3, 0.05, 0, 0, 0)
	BackingFillAnim:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(BackingFillAnim)
	self.BackingFillAnim = BackingFillAnim
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 3.5, 144.5, 0, 0, 3.5, 102.5)
	DotTiledBacking:setAlpha(0.5)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FlareName = LUI.UIText.new(0.5, 0.5, -41.5, 38.5, 1, 1, -12, 6)
	FlareName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	FlareName:setTTF("ttmussels_demibold")
	FlareName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FlareName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(FlareName)
	self.FlareName = FlareName
	local FlareFrameInuseGlow = LUI.UIImage.new(0, 0, -4, 152, 0, 0, -4, 122)
	FlareFrameInuseGlow:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_weapon_frame_inuse_glow"))
	self:addElement(FlareFrameInuseGlow)
	self.FlareFrameInuseGlow = FlareFrameInuseGlow
	local FlareFrameInuse = LUI.UIImage.new(0, 0, 0, 148, 0, 0, 0, 118)
	FlareFrameInuse:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_weapon_frame_inuse"))
	self:addElement(FlareFrameInuse)
	self.FlareFrameInuse = FlareFrameInuse
	local flare = CoD.vhud_attack_helicopter_flare.new(f1_arg0, f1_arg1, 0, 0, 49.5, 99.5, 0, 0, 14, 94)
	flare:mergeStateConditions({
		{
			stateName = "Inactive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "flareCount", 0)
			end,
		},
	})
	flare:linkToElementModel(flare, "flareCount", true, function(model)
		f1_arg0:updateElementState(flare, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flareCount",
		})
	end)
	flare:linkToElementModel(self, nil, false, function(model)
		flare:setModel(model, f1_arg1)
	end)
	self:addElement(flare)
	self.flare = flare
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_flare_counter.__onClose = function(f5_arg0)
	f5_arg0.DotTiledBacking:close()
	f5_arg0.flare:close()
end
