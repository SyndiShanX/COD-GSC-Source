require("x64:a969a8392712433")
CoD.ItemShopCyclePrompts = InheritFrom(LUI.UIElement)
CoD.ItemShopCyclePrompts.__defaultWidth = 938
CoD.ItemShopCyclePrompts.__defaultHeight = 184
CoD.ItemShopCyclePrompts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopCyclePrompts)
	self.id = "ItemShopCyclePrompts"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RightPageOver2 = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -469, -402, 0, 0, 68, 113)
	RightPageOver2:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RightPageOver2.ControllerImage:setImage(RegisterImage(f2_local0))
		end
	end)
	RightPageOver2:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightPageOver2, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_trigger_slide")
		SetFocusedTierModelValue(controller, "5", "decrement")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(RightPageOver2)
	self.RightPageOver2 = RightPageOver2
	local Pointer2 = LUI.UIImage.new(0.5, 0.5, 354, 442, 0, 0, 0, 184)
	Pointer2:setAlpha(0.8)
	Pointer2:setZRot(180)
	Pointer2:setImage(RegisterImage(@"uie_ui_menu_item_shop_tier_pointer_large"))
	Pointer2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Pointer2)
	self.Pointer2 = Pointer2
	local Pointer = LUI.UIImage.new(0.5, 0.5, -443, -355, 0, 0, 0, 184)
	Pointer:setAlpha(0.8)
	Pointer:setImage(RegisterImage(@"uie_ui_menu_item_shop_tier_pointer_large"))
	Pointer:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Pointer)
	self.Pointer = Pointer
	local RightPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 401.5, 468.5, 0, 0, 73, 118)
	RightPageOver.KeyMouseImage:setImage(RegisterImage(@"uie_bumperright"))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f6_local0))
		end
	end)
	RightPageOver:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightPageOver, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_trigger_slide")
		SetFocusedTierModelValue(controller, "5", "increment")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "totalRewardCount", 6)
			end,
		},
	})
	self:linkToElementModel(self, "totalRewardCount", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalRewardCount",
		})
	end)
	if CoD.isPC then
		RightPageOver2.id = "RightPageOver2"
	end
	if CoD.isPC then
		RightPageOver.id = "RightPageOver"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopCyclePrompts.__resetProperties = function(f12_arg0)
	f12_arg0.RightPageOver:completeAnimation()
	f12_arg0.Pointer:completeAnimation()
	f12_arg0.Pointer2:completeAnimation()
	f12_arg0.RightPageOver2:completeAnimation()
	f12_arg0.RightPageOver:setAlpha(1)
	f12_arg0.Pointer:setAlpha(0.8)
	f12_arg0.Pointer2:setAlpha(0.8)
	f12_arg0.RightPageOver2:setAlpha(1)
end
CoD.ItemShopCyclePrompts.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.RightPageOver2:completeAnimation()
			f13_arg0.RightPageOver2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RightPageOver2)
			f13_arg0.Pointer2:completeAnimation()
			f13_arg0.Pointer2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Pointer2)
			f13_arg0.Pointer:completeAnimation()
			f13_arg0.Pointer:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Pointer)
			f13_arg0.RightPageOver:completeAnimation()
			f13_arg0.RightPageOver:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RightPageOver)
		end,
	},
	Show = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.RightPageOver2:completeAnimation()
			f14_arg0.RightPageOver2:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.RightPageOver2)
			f14_arg0.Pointer2:completeAnimation()
			f14_arg0.Pointer2:setAlpha(0.8)
			f14_arg0.clipFinished(f14_arg0.Pointer2)
			f14_arg0.Pointer:completeAnimation()
			f14_arg0.Pointer:setAlpha(0.8)
			f14_arg0.clipFinished(f14_arg0.Pointer)
			f14_arg0.RightPageOver:completeAnimation()
			f14_arg0.RightPageOver:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.RightPageOver)
		end,
	},
}
CoD.ItemShopCyclePrompts.__onClose = function(f15_arg0)
	f15_arg0.RightPageOver2:close()
	f15_arg0.RightPageOver:close()
end
