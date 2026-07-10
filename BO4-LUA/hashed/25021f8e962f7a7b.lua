require("x64:acbed692442191c")
require("x64:9dbf14a95b962c1")
CoD.zm_red_available_item_text = InheritFrom(LUI.UIElement)
CoD.zm_red_available_item_text.__defaultWidth = 252
CoD.zm_red_available_item_text.__defaultHeight = 20
CoD.zm_red_available_item_text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_red_available_item_text)
	self.id = "zm_red_available_item_text"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonCornerPips = CoD.CommonCornerPips02.new(f1_arg0, f1_arg1, 0, 1, -10, 10, 0, 1, -5, 5)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local AvailableItemText = CoD.zm_red_available_item_text_internal.new(f1_arg0, f1_arg1, 0, 0, 0, 252, 0, 0, 0, 20)
	self:addElement(AvailableItemText)
	self.AvailableItemText = AvailableItemText
	self:mergeStateConditions({
		{
			stateName = "RewardWhite",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "tributeAvailable", 1)
			end,
		},
		{
			stateName = "RewardBlue",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "tributeAvailable", 2)
			end,
		},
		{
			stateName = "RewardPurple",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "tributeAvailable", 3)
			end,
		},
		{
			stateName = "RewardOrange",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "tributeAvailable", 4)
			end,
		},
	})
	self:linkToElementModel(self, "tributeAvailable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "tributeAvailable",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.zm_red_available_item_text.__resetProperties = function(f7_arg0)
	f7_arg0.CommonCornerPips:completeAnimation()
	f7_arg0.AvailableItemText:completeAnimation()
	f7_arg0.CommonCornerPips:setAlpha(1)
	f7_arg0.AvailableItemText:setAlpha(1)
	f7_arg0.AvailableItemText.ItemText:setRGB(1, 1, 1)
	f7_arg0.AvailableItemText.ItemText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7BF4567204B3D868"))
end
CoD.zm_red_available_item_text.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.CommonCornerPips:completeAnimation()
			f8_arg0.CommonCornerPips:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CommonCornerPips)
			f8_arg0.AvailableItemText:completeAnimation()
			f8_arg0.AvailableItemText:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.AvailableItemText)
		end,
	},
	RewardWhite = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.AvailableItemText:completeAnimation()
			f9_arg0.AvailableItemText.ItemText:completeAnimation()
			f9_arg0.AvailableItemText.ItemText:setRGB(1, 1, 1)
			f9_arg0.AvailableItemText.ItemText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7BF4567204B3D868"))
			f9_arg0.clipFinished(f9_arg0.AvailableItemText)
		end,
	},
	RewardBlue = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.AvailableItemText:completeAnimation()
			f10_arg0.AvailableItemText.ItemText:completeAnimation()
			f10_arg0.AvailableItemText.ItemText:setRGB(ColorSet.BlackMarketRare.r, ColorSet.BlackMarketRare.g, ColorSet.BlackMarketRare.b)
			f10_arg0.AvailableItemText.ItemText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B6DCC4FBAE3C78B"))
			f10_arg0.clipFinished(f10_arg0.AvailableItemText)
		end,
	},
	RewardPurple = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.AvailableItemText:completeAnimation()
			f11_arg0.AvailableItemText.ItemText:completeAnimation()
			f11_arg0.AvailableItemText.ItemText:setRGB(ColorSet.BlackMarketLegendary.r, ColorSet.BlackMarketLegendary.g, ColorSet.BlackMarketLegendary.b)
			f11_arg0.AvailableItemText.ItemText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_DE5F0AC13FF4A95"))
			f11_arg0.clipFinished(f11_arg0.AvailableItemText)
		end,
	},
	RewardOrange = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.AvailableItemText:completeAnimation()
			f12_arg0.AvailableItemText.ItemText:completeAnimation()
			f12_arg0.AvailableItemText.ItemText:setRGB(ColorSet.BlackMarketEpic.r, ColorSet.BlackMarketEpic.g, ColorSet.BlackMarketEpic.b)
			f12_arg0.AvailableItemText.ItemText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6128F0307929BE25"))
			f12_arg0.clipFinished(f12_arg0.AvailableItemText)
		end,
	},
}
CoD.zm_red_available_item_text.__onClose = function(f13_arg0)
	f13_arg0.CommonCornerPips:close()
	f13_arg0.AvailableItemText:close()
end
