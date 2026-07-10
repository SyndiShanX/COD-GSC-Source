require("x64:d03017b72a4f0bb")
require("x64:413629d25e31f4c")
require("x64:d2b07b098532876")
CoD.vhud_gunship_internal = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_internal.__defaultWidth = 1920
CoD.vhud_gunship_internal.__defaultHeight = 1080
CoD.vhud_gunship_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_internal)
	self.id = "vhud_gunship_internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local layoutDotlineGrid = CoD.vhud_layoutDotlineGrid.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -580.5, 584.5)
	layoutDotlineGrid:setAlpha(0.8)
	self:addElement(layoutDotlineGrid)
	self.layoutDotlineGrid = layoutDotlineGrid
	local Vignette2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Vignette2:setAlpha(0.5)
	Vignette2:setImage(RegisterImage(0x230978B05B19B))
	self:addElement(Vignette2)
	self.Vignette2 = Vignette2
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledShaderImage:setAlpha(0.5)
	TiledShaderImage:setImage(RegisterImage(0xEDF02F55208D0A6))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(64, 64)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local f1_local4 = nil
	self.vehicleHudFractal2 = LUI.UIElement.createFake()
	local vehicleHudFractal3 = nil
	vehicleHudFractal3 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	vehicleHudFractal3:setAlpha(0.8)
	vehicleHudFractal3:setImage(RegisterImage(0x97F91C840F8AD9D))
	self:addElement(vehicleHudFractal3)
	self.vehicleHudFractal3 = vehicleHudFractal3
	local f1_local6 = nil
	self.Vignette = LUI.UIElement.createFake()
	local f1_local7 = nil
	self.vehicleHudFractal = LUI.UIElement.createFake()
	local vhudgunshiprecticle = CoD.vhud_gunship_recticle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudgunshiprecticle:linkToElementModel(self, nil, false, function(model)
		vhudgunshiprecticle:setModel(model, f1_arg1)
	end)
	self:addElement(vhudgunshiprecticle)
	self.vhudgunshiprecticle = vhudgunshiprecticle
	local GunshipButtonPrompt = CoD.vhud_gunship_buttonPrompt.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	GunshipButtonPrompt:linkToElementModel(self, nil, false, function(model)
		GunshipButtonPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(GunshipButtonPrompt)
	self.GunshipButtonPrompt = GunshipButtonPrompt
	self:mergeStateConditions({
		{
			stateName = "HiddenCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["factions.isCoDCaster"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	f1_local11 = vhudgunshiprecticle
	if IsPC() then
		SizeToHudArea(f1_local11, f1_arg1)
	end
	f1_local11 = GunshipButtonPrompt
	if IsPC() then
		SizeToHudArea(f1_local11, f1_arg1)
	end
	return self
end
CoD.vhud_gunship_internal.__resetProperties = function(f6_arg0)
	f6_arg0.GunshipButtonPrompt:completeAnimation()
	f6_arg0.GunshipButtonPrompt:setAlpha(1)
end
CoD.vhud_gunship_internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenCodCaster = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.GunshipButtonPrompt:completeAnimation()
			f8_arg0.GunshipButtonPrompt:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GunshipButtonPrompt)
		end,
	},
}
CoD.vhud_gunship_internal.__onClose = function(f9_arg0)
	f9_arg0.layoutDotlineGrid:close()
	f9_arg0.vhudgunshiprecticle:close()
	f9_arg0.GunshipButtonPrompt:close()
end
