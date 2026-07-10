require("x64:6bc78104fdabeed")
require("x64:d5b07693679e0b6")
CoD.DirectorFeaturedCarousel = InheritFrom(LUI.UIElement)
CoD.DirectorFeaturedCarousel.__defaultWidth = 541
CoD.DirectorFeaturedCarousel.__defaultHeight = 142
CoD.DirectorFeaturedCarousel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFeaturedCarousel)
	self.id = "DirectorFeaturedCarousel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorFeaturedItem = CoD.DirectorFeaturedItem.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorFeaturedItem:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.GridAndListUtility.DisableAutoScrolling(f1_arg1, element)
		return f2_local0
	end)
	DirectorFeaturedItem:registerEventHandler("lose_focus", function(element, event)
		local f3_local0 = nil
		if element.loseFocus then
			f3_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f3_local0 = element.super:loseFocus(event)
		end
		CoD.GridAndListUtility.ReEnableAutoScrolling(f1_arg1, element)
		return f3_local0
	end)
	self:addElement(DirectorFeaturedItem)
	self.DirectorFeaturedItem = DirectorFeaturedItem
	local Box = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -30, 0)
	Box:setRGB(0, 0, 0)
	Box:setAlpha(0.8)
	self:addElement(Box)
	self.Box = Box
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -31, 0)
	TiledBacking:setRGB(0.67, 0.67, 0.67)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local RotatingGraphicPips = CoD.DirectorFeaturedAccentCarousel.new(f1_arg0, f1_arg1, 0.5, 0.5, -290.5, 290.5, 1, 1, -34, 3)
	self:addElement(RotatingGraphicPips)
	self.RotatingGraphicPips = RotatingGraphicPips
	local IdentityBracketBot = LUI.UIImage.new(0, 1.01, -3, -3, 0, 0, -2, 10)
	IdentityBracketBot:setAlpha(0.15)
	IdentityBracketBot:setImage(RegisterImage(0x5D6BC90D2477559))
	IdentityBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	IdentityBracketBot:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(IdentityBracketBot)
	self.IdentityBracketBot = IdentityBracketBot
	local IdentityBracketBot2 = LUI.UIImage.new(-0.01, 1.01, 0, 0, 1, 1, -10, 2)
	IdentityBracketBot2:setAlpha(0.15)
	IdentityBracketBot2:setZRot(180)
	IdentityBracketBot2:setImage(RegisterImage(0x5D6BC90D2477559))
	IdentityBracketBot2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	IdentityBracketBot2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(IdentityBracketBot2)
	self.IdentityBracketBot2 = IdentityBracketBot2
	DirectorFeaturedItem:linkToElementModel(RotatingGraphicPips.PipsGrid, nil, false, function(model)
		DirectorFeaturedItem:setModel(model, f1_arg1)
	end)
	DirectorFeaturedItem:linkToElementModel(RotatingGraphicPips.PipsGrid, "iconBackground", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DirectorFeaturedItem.GamemodeBackground:setImage(RegisterImage(f5_local0))
		end
	end)
	DirectorFeaturedItem:linkToElementModel(RotatingGraphicPips.PipsGrid, "name", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DirectorFeaturedItem.Header:setText(ToUpper(f6_local0))
		end
	end)
	self:registerEventHandler("grid_item_changed", function(self, event)
		local f7_local0 = nil
		UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
		return f7_local0
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		if IsInDefaultState(element) then
		else
		end
	end)
	if CoD.isPC then
		DirectorFeaturedItem.id = "DirectorFeaturedItem"
	end
	RotatingGraphicPips.id = "RotatingGraphicPips"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.BaseUtility.SetUpPassCustomFunctionToChild(self, self.RotatingGraphicPips, f1_arg1, f1_arg0, "_activateFeaturedWidget")
	return self
end
CoD.DirectorFeaturedCarousel.__resetProperties = function(f9_arg0)
	f9_arg0.RotatingGraphicPips:completeAnimation()
	f9_arg0.DirectorFeaturedItem:completeAnimation()
	f9_arg0.Box:completeAnimation()
	f9_arg0.TiledBacking:completeAnimation()
	f9_arg0.IdentityBracketBot:completeAnimation()
	f9_arg0.IdentityBracketBot2:completeAnimation()
	f9_arg0.RotatingGraphicPips:setAlpha(1)
	f9_arg0.DirectorFeaturedItem:setAlpha(1)
	f9_arg0.Box:setAlpha(0.8)
	f9_arg0.TiledBacking:setAlpha(1)
	f9_arg0.IdentityBracketBot:setAlpha(0.15)
	f9_arg0.IdentityBracketBot2:setAlpha(0.15)
end
CoD.DirectorFeaturedCarousel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.DirectorFeaturedItem:completeAnimation()
			f11_arg0.DirectorFeaturedItem:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DirectorFeaturedItem)
			f11_arg0.Box:completeAnimation()
			f11_arg0.Box:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Box)
			f11_arg0.TiledBacking:completeAnimation()
			f11_arg0.TiledBacking:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TiledBacking)
			f11_arg0.RotatingGraphicPips:completeAnimation()
			f11_arg0.RotatingGraphicPips:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.RotatingGraphicPips)
			f11_arg0.IdentityBracketBot:completeAnimation()
			f11_arg0.IdentityBracketBot:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.IdentityBracketBot)
			f11_arg0.IdentityBracketBot2:completeAnimation()
			f11_arg0.IdentityBracketBot2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.IdentityBracketBot2)
		end,
	},
}
CoD.DirectorFeaturedCarousel.__onClose = function(f12_arg0)
	f12_arg0.DirectorFeaturedItem:close()
	f12_arg0.RotatingGraphicPips:close()
end
