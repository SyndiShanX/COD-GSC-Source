require("x64:d7e092479c7b82c")
CoD.Toast_Container_FactionReward = InheritFrom(LUI.UIElement)
CoD.Toast_Container_FactionReward.__defaultWidth = 340
CoD.Toast_Container_FactionReward.__defaultHeight = 80
CoD.Toast_Container_FactionReward.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Toast_Container_FactionReward)
	self.id = "Toast_Container_FactionReward"
	self.soundSet = "none"
	local blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Border = CoD.Border.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.18, 1, 0.13)
	self:addElement(Border)
	self.Border = Border
	local PurchasedImage = LUI.UIFixedAspectRatioImage.new(0, 0, 5, 80, 0, 0, 2.5, 77.5)
	PurchasedImage:setImage(RegisterImage(@"hash_54261D1AFA690431"))
	self:addElement(PurchasedImage)
	self.PurchasedImage = PurchasedImage
	local NotifText = LUI.UIText.new(0, 0, 80, 335, 0.5, 0.5, -16.5, 16.5)
	NotifText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	NotifText:setTTF("ttmussels_demibold")
	NotifText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NotifText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(NotifText)
	self.NotifText = NotifText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Toast_Container_FactionReward.__onClose = function(f2_arg0)
	f2_arg0.Border:close()
end
