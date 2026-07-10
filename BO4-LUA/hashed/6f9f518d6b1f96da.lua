require("x64:a0a8f1663892a0d")
require("x64:bba2468877eebe1")
require("x64:400d223b0a524c1")
require("x64:e496e1615b73244")
require("x64:455868bb803d8b6")
CoD.ItemShopRarityBackgroundStream = InheritFrom(LUI.UIElement)
CoD.ItemShopRarityBackgroundStream.__defaultWidth = 240
CoD.ItemShopRarityBackgroundStream.__defaultHeight = 240
CoD.ItemShopRarityBackgroundStream.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopRarityBackgroundStream)
	self.id = "ItemShopRarityBackgroundStream"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local Ultra = CoD.ItemShopRarityBackgroundStream_Ultra.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Ultra:linkToElementModel(self, nil, false, function(model)
		Ultra:setModel(model, f1_arg1)
	end)
	self:addElement(Ultra)
	self.Ultra = Ultra
	local Epic = CoD.ItemShopRarityBackgroundStream_Epic.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Epic:setAlpha(0)
	Epic:linkToElementModel(self, nil, false, function(model)
		Epic:setModel(model, f1_arg1)
	end)
	self:addElement(Epic)
	self.Epic = Epic
	local Legendary = CoD.ItemShopRarityBackgroundStream_Legendary.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Legendary:setAlpha(0)
	Legendary:linkToElementModel(self, nil, false, function(model)
		Legendary:setModel(model, f1_arg1)
	end)
	self:addElement(Legendary)
	self.Legendary = Legendary
	local Rare = CoD.ItemShopRarityBackgroundStream_Rare.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Rare:setAlpha(0)
	Rare:linkToElementModel(self, nil, false, function(model)
		Rare:setModel(model, f1_arg1)
	end)
	self:addElement(Rare)
	self.Rare = Rare
	local Common = CoD.ItemShopRarityBackgroundStream_Common.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Common:setAlpha(0)
	Common:linkToElementModel(self, nil, false, function(model)
		Common:setModel(model, f1_arg1)
	end)
	self:addElement(Common)
	self.Common = Common
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopRarityBackgroundStream.__resetProperties = function(f8_arg0)
	f8_arg0.Common:completeAnimation()
	f8_arg0.Rare:completeAnimation()
	f8_arg0.Legendary:completeAnimation()
	f8_arg0.Epic:completeAnimation()
	f8_arg0.Ultra:completeAnimation()
	f8_arg0.Common:setAlpha(0)
	f8_arg0.Rare:setAlpha(0)
	f8_arg0.Legendary:setAlpha(0)
	f8_arg0.Epic:setAlpha(0)
	f8_arg0.Ultra:setAlpha(1)
end
CoD.ItemShopRarityBackgroundStream.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Common = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Rare:completeAnimation()
			f10_arg0.Rare:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Rare)
			f10_arg0.Common:completeAnimation()
			f10_arg0.Common:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Common)
		end,
	},
	Rare = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Rare:completeAnimation()
			f11_arg0.Rare:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Rare)
		end,
	},
	Legendary = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Legendary:completeAnimation()
			f12_arg0.Legendary:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Legendary)
		end,
	},
	Epic = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.Epic:completeAnimation()
			f13_arg0.Epic:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Epic)
			f13_arg0.Legendary:completeAnimation()
			f13_arg0.Legendary:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Legendary)
		end,
	},
	Ultra = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.Ultra:completeAnimation()
			f14_arg0.Ultra:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.Ultra)
			f14_arg0.Legendary:completeAnimation()
			f14_arg0.Legendary:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Legendary)
		end,
	},
}
CoD.ItemShopRarityBackgroundStream.__onClose = function(f15_arg0)
	f15_arg0.Image:close()
	f15_arg0.Ultra:close()
	f15_arg0.Epic:close()
	f15_arg0.Legendary:close()
	f15_arg0.Rare:close()
	f15_arg0.Common:close()
end
