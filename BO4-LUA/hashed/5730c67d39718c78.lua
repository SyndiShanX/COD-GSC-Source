require("x64:94dab3a4d2d79b2")
require("x64:e757ecab77bdc64")
require("x64:c354b0a26f3b5f9")
CoD.PC_Store_Refund_Korea_Product_Image = InheritFrom(LUI.UIElement)
CoD.PC_Store_Refund_Korea_Product_Image.__defaultWidth = 349
CoD.PC_Store_Refund_Korea_Product_Image.__defaultHeight = 202
CoD.PC_Store_Refund_Korea_Product_Image.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Store_Refund_Korea_Product_Image)
	self.id = "PC_Store_Refund_Korea_Product_Image"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGProductImage = LUI.UIImage.new(0.5, 0.5, -99.5, 99.5, 0.5, 0.5, -100, 99)
	BGProductImage:setAlpha(0.8)
	BGProductImage:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonbgtile"))
	BGProductImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BGProductImage:setShaderVector(0, 0, 0, 0, 0)
	BGProductImage:setupNineSliceShader(100, 100)
	self:addElement(BGProductImage)
	self.BGProductImage = BGProductImage
	local ProductImage = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -100, 100)
	ProductImage:linkToElementModel(self, "ProductImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProductImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ProductImage)
	self.ProductImage = ProductImage
	local BorderImage = LUI.UIImage.new(0.5, 0.5, -101, 101, 0.5, 0.5, -101, 101)
	BorderImage:setImage(RegisterImage(@"uie_ui_zm_laboratory_buttonframe"))
	BorderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BorderImage:setShaderVector(0, 0, 0, 0, 0)
	BorderImage:setupNineSliceShader(10, 10)
	self:addElement(BorderImage)
	self.BorderImage = BorderImage
	local StartMenuSmallTierLevel = CoD.StartMenu_SmallTierLevel.new(f1_arg0, f1_arg1, 0.5, 0.5, -175, 175, 0.5, 0.5, -102, -22)
	self:addElement(StartMenuSmallTierLevel)
	self.StartMenuSmallTierLevel = StartMenuSmallTierLevel
	local Box = LUI.UIImage.new(0.5, 0.5, -257.5, 257.5, 0.5, 0.5, -165, 165)
	Box:setRGB(0.28, 0.34, 0.37)
	Box:setAlpha(0.2)
	self:addElement(Box)
	self.Box = Box
	local TiledShaderImage2 = LUI.UIImage.new(0.5, 0.5, -251, 250, 0.5, 0.5, 31.5, 90.5)
	TiledShaderImage2:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	TiledShaderImage2:setAlpha(0.3)
	TiledShaderImage2:setImage(RegisterImage(@"uie_ui_menu_store_repeat_dot_pattern"))
	TiledShaderImage2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage2:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage2:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage2)
	self.TiledShaderImage2 = TiledShaderImage2
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0.5, 0.5, -257.5, 257.5, 0.5, 0.5, -165, 165)
	DotCorner9Slice:setAlpha(0.1)
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local TiersImage = LUI.UIImage.new(0.5, 0.5, -252.5, 252.5, 0.5, 0.5, 30.5, 89.5)
	TiersImage:setRGB(0, 0, 0)
	TiersImage:setAlpha(0.3)
	self:addElement(TiersImage)
	self.TiersImage = TiersImage
	local Tiers = LUI.UIText.new(0.5, 0.5, -232.5, 232.5, 0.5, 0.5, 36.5, 84.5)
	Tiers:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	Tiers:setText("")
	Tiers:setTTF("ttmussels_demibold")
	Tiers:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_593F361CC41C94AF"))
	Tiers:setShaderVector(0, 0.8, 0, 0, 0)
	Tiers:setShaderVector(1, 0, 0, 0, 0)
	Tiers:setShaderVector(2, 1, 0.3, 0, 0.3)
	Tiers:setLetterSpacing(4)
	Tiers:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Tiers:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Tiers)
	self.Tiers = Tiers
	local pointer = CoD.SupplyChainBumperPointers.new(f1_arg0, f1_arg1, 0.5, 0.5, 232, 264, 0.5, 0.5, 9, 89)
	pointer:setRGB(0.84, 0.82, 0.75)
	pointer:setAlpha(0.8)
	self:addElement(pointer)
	self.pointer = pointer
	local pointer2 = CoD.SupplyChainBumperPointers.new(f1_arg0, f1_arg1, 0.5, 0.5, -264, -232, 0.5, 0.5, 9, 89)
	pointer2:setRGB(0.84, 0.82, 0.75)
	pointer2:setAlpha(0.8)
	pointer2:setScale(-1, 1)
	self:addElement(pointer2)
	self.pointer2 = pointer2
	local FrontendFrameSelected = LUI.UIImage.new(0.5, 0.5, -184, 184, 0.5, 0.5, -94, -18)
	FrontendFrameSelected:setRGB(0.42, 0.69, 0.94)
	FrontendFrameSelected:setAlpha(0.4)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	self:mergeStateConditions({
		{
			stateName = "IsContract",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "IsContract")
			end,
		},
		{
			stateName = "Tiers",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "IsTiers")
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "productImage", @"blacktransparent")
			end,
		},
	})
	self:linkToElementModel(self, "IsContract", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "IsContract",
		})
	end)
	self:linkToElementModel(self, "IsTiers", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "IsTiers",
		})
	end)
	self:linkToElementModel(self, "productImage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "productImage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Store_Refund_Korea_Product_Image.__resetProperties = function(f9_arg0)
	f9_arg0.Tiers:completeAnimation()
	f9_arg0.TiersImage:completeAnimation()
	f9_arg0.DotCorner9Slice:completeAnimation()
	f9_arg0.TiledShaderImage2:completeAnimation()
	f9_arg0.Box:completeAnimation()
	f9_arg0.StartMenuSmallTierLevel:completeAnimation()
	f9_arg0.pointer:completeAnimation()
	f9_arg0.pointer2:completeAnimation()
	f9_arg0.FrontendFrameSelected:completeAnimation()
	f9_arg0.BorderImage:completeAnimation()
	f9_arg0.ProductImage:completeAnimation()
	f9_arg0.BGProductImage:completeAnimation()
	f9_arg0.Tiers:setAlpha(1)
	f9_arg0.TiersImage:setAlpha(0.3)
	f9_arg0.DotCorner9Slice:setAlpha(0.1)
	f9_arg0.TiledShaderImage2:setAlpha(0.3)
	f9_arg0.Box:setAlpha(0.2)
	f9_arg0.StartMenuSmallTierLevel:setAlpha(1)
	f9_arg0.pointer:setAlpha(0.8)
	f9_arg0.pointer2:setAlpha(0.8)
	f9_arg0.FrontendFrameSelected:setAlpha(0.4)
	f9_arg0.BorderImage:setLeftRight(0.5, 0.5, -101, 101)
	f9_arg0.BorderImage:setTopBottom(0.5, 0.5, -101, 101)
	f9_arg0.BorderImage:setAlpha(1)
	f9_arg0.ProductImage:setLeftRight(0.5, 0.5, -100, 100)
	f9_arg0.ProductImage:setTopBottom(0.5, 0.5, -100, 100)
	f9_arg0.ProductImage:setAlpha(1)
	f9_arg0.BGProductImage:setAlpha(0.8)
end
CoD.PC_Store_Refund_Korea_Product_Image.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(9)
			f10_arg0.StartMenuSmallTierLevel:completeAnimation()
			f10_arg0.StartMenuSmallTierLevel:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.StartMenuSmallTierLevel)
			f10_arg0.Box:completeAnimation()
			f10_arg0.Box:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Box)
			f10_arg0.TiledShaderImage2:completeAnimation()
			f10_arg0.TiledShaderImage2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TiledShaderImage2)
			f10_arg0.DotCorner9Slice:completeAnimation()
			f10_arg0.DotCorner9Slice:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DotCorner9Slice)
			f10_arg0.TiersImage:completeAnimation()
			f10_arg0.TiersImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TiersImage)
			f10_arg0.Tiers:completeAnimation()
			f10_arg0.Tiers:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Tiers)
			f10_arg0.pointer:completeAnimation()
			f10_arg0.pointer:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.pointer)
			f10_arg0.pointer2:completeAnimation()
			f10_arg0.pointer2:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.pointer2)
			f10_arg0.FrontendFrameSelected:completeAnimation()
			f10_arg0.FrontendFrameSelected:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FrontendFrameSelected)
		end,
	},
	IsContract = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(12)
			f11_arg0.BGProductImage:completeAnimation()
			f11_arg0.BGProductImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BGProductImage)
			f11_arg0.ProductImage:completeAnimation()
			f11_arg0.ProductImage:setLeftRight(0.5, 0.5, -314, 286)
			f11_arg0.ProductImage:setTopBottom(0.5, 0.5, -160, 140)
			f11_arg0.clipFinished(f11_arg0.ProductImage)
			f11_arg0.BorderImage:completeAnimation()
			f11_arg0.BorderImage:setLeftRight(0.5, 0.5, -177.5, 177.5)
			f11_arg0.BorderImage:setTopBottom(0.5, 0.5, -102, 102)
			f11_arg0.BorderImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BorderImage)
			f11_arg0.StartMenuSmallTierLevel:completeAnimation()
			f11_arg0.StartMenuSmallTierLevel:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.StartMenuSmallTierLevel)
			f11_arg0.Box:completeAnimation()
			f11_arg0.Box:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Box)
			f11_arg0.TiledShaderImage2:completeAnimation()
			f11_arg0.TiledShaderImage2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TiledShaderImage2)
			f11_arg0.DotCorner9Slice:completeAnimation()
			f11_arg0.DotCorner9Slice:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DotCorner9Slice)
			f11_arg0.TiersImage:completeAnimation()
			f11_arg0.TiersImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TiersImage)
			f11_arg0.Tiers:completeAnimation()
			f11_arg0.Tiers:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Tiers)
			f11_arg0.pointer:completeAnimation()
			f11_arg0.pointer:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.pointer)
			f11_arg0.pointer2:completeAnimation()
			f11_arg0.pointer2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.pointer2)
			f11_arg0.FrontendFrameSelected:completeAnimation()
			f11_arg0.FrontendFrameSelected:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.FrontendFrameSelected)
		end,
	},
	Tiers = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(9)
			f12_arg0.BGProductImage:completeAnimation()
			f12_arg0.BGProductImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BGProductImage)
			f12_arg0.ProductImage:completeAnimation()
			f12_arg0.ProductImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ProductImage)
			f12_arg0.BorderImage:completeAnimation()
			f12_arg0.BorderImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BorderImage)
			f12_arg0.StartMenuSmallTierLevel:completeAnimation()
			f12_arg0.StartMenuSmallTierLevel:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.StartMenuSmallTierLevel)
			f12_arg0.Box:completeAnimation()
			f12_arg0.Box:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.Box)
			f12_arg0.TiledShaderImage2:completeAnimation()
			f12_arg0.TiledShaderImage2:setAlpha(0.3)
			f12_arg0.clipFinished(f12_arg0.TiledShaderImage2)
			f12_arg0.DotCorner9Slice:completeAnimation()
			f12_arg0.DotCorner9Slice:setAlpha(0.1)
			f12_arg0.clipFinished(f12_arg0.DotCorner9Slice)
			f12_arg0.TiersImage:completeAnimation()
			f12_arg0.TiersImage:setAlpha(0.3)
			f12_arg0.clipFinished(f12_arg0.TiersImage)
			f12_arg0.Tiers:completeAnimation()
			f12_arg0.Tiers:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Tiers)
		end,
	},
	Empty = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(12)
			f13_arg0.BGProductImage:completeAnimation()
			f13_arg0.BGProductImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BGProductImage)
			f13_arg0.ProductImage:completeAnimation()
			f13_arg0.ProductImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ProductImage)
			f13_arg0.BorderImage:completeAnimation()
			f13_arg0.BorderImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.BorderImage)
			f13_arg0.StartMenuSmallTierLevel:completeAnimation()
			f13_arg0.StartMenuSmallTierLevel:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.StartMenuSmallTierLevel)
			f13_arg0.Box:completeAnimation()
			f13_arg0.Box:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Box)
			f13_arg0.TiledShaderImage2:completeAnimation()
			f13_arg0.TiledShaderImage2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.TiledShaderImage2)
			f13_arg0.DotCorner9Slice:completeAnimation()
			f13_arg0.DotCorner9Slice:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DotCorner9Slice)
			f13_arg0.TiersImage:completeAnimation()
			f13_arg0.TiersImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.TiersImage)
			f13_arg0.Tiers:completeAnimation()
			f13_arg0.Tiers:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Tiers)
			f13_arg0.pointer:completeAnimation()
			f13_arg0.pointer:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.pointer)
			f13_arg0.pointer2:completeAnimation()
			f13_arg0.pointer2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.pointer2)
			f13_arg0.FrontendFrameSelected:completeAnimation()
			f13_arg0.FrontendFrameSelected:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrontendFrameSelected)
		end,
	},
}
CoD.PC_Store_Refund_Korea_Product_Image.__onClose = function(f14_arg0)
	f14_arg0.ProductImage:close()
	f14_arg0.StartMenuSmallTierLevel:close()
	f14_arg0.DotCorner9Slice:close()
	f14_arg0.pointer:close()
	f14_arg0.pointer2:close()
end
