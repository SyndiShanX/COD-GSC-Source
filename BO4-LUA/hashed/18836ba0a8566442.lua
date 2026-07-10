require("x64:873fc8f46f1c83d")
require("x64:520741f3ea4f371")
require("x64:cad83847652b611")
require("x64:a11dcc0303a7d74")
require("x64:34c4191dcc044e6")
CoD.ItemShopRarityBackground = InheritFrom(LUI.UIElement)
CoD.ItemShopRarityBackground.__defaultWidth = 240
CoD.ItemShopRarityBackground.__defaultHeight = 240
CoD.ItemShopRarityBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopRarityBackground)
	self.id = "ItemShopRarityBackground"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Ultra = CoD.AARTierRewardBackground_Ultra.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Ultra:setAlpha(0)
	Ultra:linkToElementModel(self, nil, false, function(model)
		Ultra:setModel(model, f1_arg1)
	end)
	self:addElement(Ultra)
	self.Ultra = Ultra
	local Epic = CoD.AARTierRewardBackground_Epic.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Epic:setAlpha(0)
	Epic:linkToElementModel(self, nil, false, function(model)
		Epic:setModel(model, f1_arg1)
	end)
	self:addElement(Epic)
	self.Epic = Epic
	local Legendary = CoD.AARTierRewardBackground_Legendary.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Legendary:setAlpha(0)
	Legendary:linkToElementModel(self, nil, false, function(model)
		Legendary:setModel(model, f1_arg1)
	end)
	self:addElement(Legendary)
	self.Legendary = Legendary
	local Rare = CoD.AARTierRewardBackground_Rare.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Rare:setAlpha(0)
	Rare:linkToElementModel(self, nil, false, function(model)
		Rare:setModel(model, f1_arg1)
	end)
	self:addElement(Rare)
	self.Rare = Rare
	local Common = CoD.AARTierRewardBackground_Common.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
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
CoD.ItemShopRarityBackground.__resetProperties = function(f7_arg0)
	f7_arg0.Common:completeAnimation()
	f7_arg0.Rare:completeAnimation()
	f7_arg0.Legendary:completeAnimation()
	f7_arg0.Common:setAlpha(0)
	f7_arg0.Rare:setAlpha(0)
	f7_arg0.Legendary:setAlpha(0)
end
CoD.ItemShopRarityBackground.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Common = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Common:completeAnimation()
			f9_arg0.Common:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Common)
		end,
	},
	Rare = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Rare:completeAnimation()
			f10_arg0.Rare:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Rare)
		end,
	},
	Legendary = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Legendary:completeAnimation()
			f11_arg0.Legendary:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Legendary)
		end,
	},
	Epic = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Legendary:completeAnimation()
			f12_arg0.Legendary:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Legendary)
		end,
	},
	Ultra = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Legendary:completeAnimation()
			f13_arg0.Legendary:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Legendary)
		end,
	},
}
CoD.ItemShopRarityBackground.__onClose = function(f14_arg0)
	f14_arg0.Ultra:close()
	f14_arg0.Epic:close()
	f14_arg0.Legendary:close()
	f14_arg0.Rare:close()
	f14_arg0.Common:close()
end
