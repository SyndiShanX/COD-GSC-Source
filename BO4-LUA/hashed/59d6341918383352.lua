require("x64:e272191e46af824")
require("x64:dc74d5014cfb5b9")
require("x64:2fffefea131705b")
require("x64:d0fe15b75d77a7")
CoD.BMTallItemContainer = InheritFrom(LUI.UIElement)
CoD.BMTallItemContainer.__defaultWidth = 240
CoD.BMTallItemContainer.__defaultHeight = 510
CoD.BMTallItemContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BMTallItemContainer)
	self.id = "BMTallItemContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CardStack = CoD.BlackJacksShopCardStackSunset.new(f1_arg0, f1_arg1, 0.5, 0.5, 88, 152, 0.5, 0.5, -256, 256)
	CardStack:linkToElementModel(self, nil, false, function(model)
		CardStack:setModel(model, f1_arg1)
	end)
	self:addElement(CardStack)
	self.CardStack = CardStack
	local BMTallItem = CoD.BMTallItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -120, 120, 0.5, 0.5, -255, 255)
	BMTallItem:linkToElementModel(self, nil, false, function(model)
		BMTallItem:setModel(model, f1_arg1)
	end)
	self:addElement(BMTallItem)
	self.BMTallItem = BMTallItem
	local ItemHintText = CoD.CommonToolTip.new(f1_arg0, f1_arg1, 0.5, 0.5, -135, 135, 1, 1, 52, 97)
	ItemHintText:mergeStateConditions({
		{
			stateName = "Mouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
			end,
		},
		{
			stateName = "CenterAlign",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemHintText:setAlpha(0)
	ItemHintText:linkToElementModel(self, "toolTipText", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ItemHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](f7_local0))
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local BMStackPips = CoD.BMStackPips.new(f1_arg0, f1_arg1, 0, 0, 90, 150, 0, 0, 529.5, 541.5)
	BMStackPips:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f8_local0 = IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
				if f8_local0 then
					f8_local0 = IsMenuPropertyValue(menu, "_currentTab", "itemshop")
					if f8_local0 then
						if not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "emptyItem") then
							f8_local0 = CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "BMTallItem")
						else
							f8_local0 = false
						end
					end
				end
				return f8_local0
			end,
		},
	})
	BMStackPips:linkToElementModel(BMStackPips, "emptyItem", true, function(model)
		f1_arg0:updateElementState(BMStackPips, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "emptyItem",
		})
	end)
	BMStackPips:appendEventHandler("record_curr_focused_elem_id", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(BMStackPips, f10_arg1)
	end)
	BMStackPips:setAlpha(0)
	BMStackPips:linkToElementModel(self, nil, false, function(model)
		BMStackPips:setModel(model, f1_arg1)
	end)
	self:addElement(BMStackPips)
	self.BMStackPips = BMStackPips
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		UpdateSelfElementState(f1_arg0, self.BMStackPips, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusLost", function(element)
		UpdateSelfElementState(f1_arg0, self.BMStackPips, f1_arg1)
	end)
	BMTallItem.id = "BMTallItem"
	self.__defaultFocus = BMTallItem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BMTallItemContainer.__resetProperties = function(f15_arg0)
	f15_arg0.BMTallItem:completeAnimation()
	f15_arg0.ItemHintText:completeAnimation()
	f15_arg0.BMStackPips:completeAnimation()
	f15_arg0.BMTallItem:setScale(1, 1)
	f15_arg0.ItemHintText:setAlpha(0)
	f15_arg0.BMStackPips:setAlpha(0)
end
CoD.BMTallItemContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.BMTallItem:completeAnimation()
			f17_arg0.BMTallItem:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.BMTallItem)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(199)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.ItemHintText:beginAnimation(10000)
				f17_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.ItemHintText:completeAnimation()
			f17_arg0.ItemHintText:setAlpha(1)
			f17_local0(f17_arg0.ItemHintText)
			f17_arg0.BMStackPips:completeAnimation()
			f17_arg0.BMStackPips:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.BMStackPips)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				f20_arg0.BMTallItem:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f20_arg0.BMTallItem:setScale(1.05, 1.05)
				f20_arg0.BMTallItem:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.BMTallItem:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.BMTallItem:completeAnimation()
			f20_arg0.BMTallItem:setScale(1, 1)
			f20_local0(f20_arg0.BMTallItem)
			local f20_local1 = function(f22_arg0)
				f20_arg0.ItemHintText:beginAnimation(200)
				f20_arg0.ItemHintText:setAlpha(1)
				f20_arg0.ItemHintText:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.ItemHintText:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.ItemHintText:completeAnimation()
			f20_arg0.ItemHintText:setAlpha(0)
			f20_local1(f20_arg0.ItemHintText)
			f20_arg0.BMStackPips:completeAnimation()
			f20_arg0.BMStackPips:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.BMStackPips)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.BMTallItem:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f23_arg0.BMTallItem:setScale(1, 1)
				f23_arg0.BMTallItem:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.BMTallItem:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.BMTallItem:completeAnimation()
			f23_arg0.BMTallItem:setScale(1.05, 1.05)
			f23_local0(f23_arg0.BMTallItem)
		end,
	},
	PC = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BMTallItemContainer.__onClose = function(f26_arg0)
	f26_arg0.CardStack:close()
	f26_arg0.BMTallItem:close()
	f26_arg0.ItemHintText:close()
	f26_arg0.BMStackPips:close()
end
