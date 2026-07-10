require("x64:ff22b286a167aad")
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item.__defaultWidth = 64
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item.__defaultHeight = 64
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item)
	self.id = "Hud_ZM_LastStand_Bleedout_Perk_Bar_Item"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local MetalFrame = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	MetalFrame:setImage(RegisterImage(0xAED94B38E8B3347))
	MetalFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	MetalFrame:setShaderVector(0, 0, 0, 0, 0)
	MetalFrame:setupNineSliceShader(14, 14)
	self:addElement(MetalFrame)
	self.MetalFrame = MetalFrame
	local PerkIcon = CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item_Perk.new(f1_arg0, f1_arg1, 0, 0, 0, 64, 0, 0, 0, 64)
	PerkIcon:linkToElementModel(self, nil, false, function(model)
		PerkIcon:setModel(model, f1_arg1)
	end)
	self:addElement(PerkIcon)
	self.PerkIcon = PerkIcon
	local PerkIconOveralay = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	PerkIconOveralay:setRGB(1, 0.98, 0.73)
	PerkIconOveralay:setAlpha(0)
	PerkIconOveralay:setZRot(90)
	PerkIconOveralay:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	PerkIconOveralay:setShaderVector(0, 1, 0, 0, 0)
	PerkIconOveralay:setShaderVector(1, 0, 0, 0, 0)
	PerkIconOveralay:setShaderVector(3, 0, 0, 0, 0)
	PerkIconOveralay:setShaderVector(4, 0, 0, 0, 0)
	PerkIconOveralay:linkToElementModel(self, "bleedoutProgress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PerkIconOveralay:setShaderVector(2, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(PerkIconOveralay)
	self.PerkIconOveralay = PerkIconOveralay
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_LastStand_Bleedout_Perk_Bar_Item.__onClose = function(f4_arg0)
	f4_arg0.PerkIcon:close()
	f4_arg0.PerkIconOveralay:close()
end
