require("ui/uieditor/widgets/header/headerlinescontainer")
require("ui/uieditor/widgets/store/storecommontextbacking")
CoD.Footer_BG = InheritFrom(LUI.UIElement)
CoD.Footer_BG.__defaultWidth = 1920
CoD.Footer_BG.__defaultHeight = 54
CoD.Footer_BG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Footer_BG)
	self.id = "Footer_BG"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGSceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGSceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGSceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGSceneBlur)
	self.BGSceneBlur = BGSceneBlur
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.07, 0.07, 0.07)
	BG:setAlpha(0.95)
	self:addElement(BG)
	self.BG = BG
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local TopBar = LUI.UIImage.new(-0.01, 1.01, -30, 30, 0, 0, 0, 3)
	TopBar:setRGB(0.63, 0.63, 0.67)
	TopBar:setAlpha(0.7)
	TopBar:setImage(RegisterImage("uie_ui_menu_cac_primary_button_top_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	TopBar:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local BackingBlack = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 45, 157)
	BackingBlack:setRGB(0.02, 0.02, 0.02)
	self:addElement(BackingBlack)
	self.BackingBlack = BackingBlack
	local BackingGrayMediumLeft = CoD.HeaderLinesContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 45, 157)
	BackingGrayMediumLeft:setRGB(0.2, 0.2, 0.2)
	BackingGrayMediumLeft:setZRot(180)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local GrainBG01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 45, 157)
	GrainBG01:setAlpha(0.5)
	GrainBG01:setImage(RegisterImage("uie_ui_menu_director_grain_bg01"))
	GrainBG01:setMaterial(LUI.UIImage.GetCachedMaterial("ui_multiply"))
	self:addElement(GrainBG01)
	self.GrainBG01 = GrainBG01
	self:mergeStateConditions({
		{
			stateName = "HideBacking",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Footer_BG.__onClose = function(f3_arg0)
	f3_arg0.DotTiledBacking:close()
	f3_arg0.BackingGrayMediumLeft:close()
end
