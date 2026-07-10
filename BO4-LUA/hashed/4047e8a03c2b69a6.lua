require("x64:5f8cf56752aa71b")
require("x64:a6c788fd067cb9")
require("x64:147880f65713969")
CoD.ZMTalismanStatusButtonInternal = InheritFrom(LUI.UIElement)
CoD.ZMTalismanStatusButtonInternal.__defaultWidth = 216
CoD.ZMTalismanStatusButtonInternal.__defaultHeight = 216
CoD.ZMTalismanStatusButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMTalismanStatusButtonInternal)
	self.id = "ZMTalismanStatusButtonInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Talisman = CoD.ZMTalismanSlot.new(f1_arg0, f1_arg1, 0, 0, 63, 153, 0, 0, 63, 153)
	Talisman:linkToElementModel(self, nil, false, function(model)
		Talisman:setModel(model, f1_arg1)
	end)
	self:addElement(Talisman)
	self.Talisman = Talisman
	local BannerBG = LUI.UIImage.new(0.5, 0.5, -45, 45, 1, 1, -61, -16)
	BannerBG:setImage(RegisterImage(@"hash_2A938C74C48DDB56"))
	self:addElement(BannerBG)
	self.BannerBG = BannerBG
	local Brackets = LUI.UIImage.new(0, 0, 0, 216, 0, 0, 0, 216)
	Brackets:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	Brackets:setAlpha(0.5)
	Brackets:setImage(RegisterImage(@"hash_661E31A40BB33DD9"))
	self:addElement(Brackets)
	self.Brackets = Brackets
	local Dots = LUI.UIImage.new(0, 0, 0, 216, 0, 0, 0, 216)
	Dots:setRGB(0.59, 0.13, 0.13)
	Dots:setAlpha(0.3)
	Dots:setImage(RegisterImage(@"hash_4EC502DE0EAF1860"))
	self:addElement(Dots)
	self.Dots = Dots
	local ElixirCount = CoD.EquippedBGBCount.new(f1_arg0, f1_arg1, 0.5, 0.5, -39, 39, 1, 1, -57, -33)
	ElixirCount:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsCACItemConsumable(menu, element, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"])
			end,
		},
	})
	ElixirCount:linkToElementModel(ElixirCount, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ElixirCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	ElixirCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ElixirCount:linkToElementModel(self, nil, false, function(model)
		ElixirCount:setModel(model, f1_arg1)
	end)
	ElixirCount:linkToElementModel(self, "itemIndex", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ElixirCount.Count:setText(CoD.CACUtility.GetConsumableCountFromIndex(f1_arg1, f1_arg0, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"], f6_local0))
		end
	end)
	self:addElement(ElixirCount)
	self.ElixirCount = ElixirCount
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 41.5, -40.5, 0, 1, 39.5, -44.5)
	CommonButtonOutline:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsLive()
			end,
		},
	})
	local f1_local7 = CommonButtonOutline
	local Lock = CommonButtonOutline.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	Lock(f1_local7, f1_local9["lobbyRoot.lobbyNetworkMode"], function(f8_arg0)
		f1_arg0:updateElementState(CommonButtonOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local7 = CommonButtonOutline
	Lock = CommonButtonOutline.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	Lock(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(CommonButtonOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CommonButtonOutline:setZRot(45)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	Lock = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	Lock:setAlpha(0)
	Lock:setImage(RegisterImage(@"uie_ui_icon_global_lock"))
	self:addElement(Lock)
	self.Lock = Lock
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not IsLive()
			end,
		},
	})
	f1_local9 = self
	f1_local7 = self.subscribeToModel
	local f1_local10 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local9, f1_local10["lobbyRoot.lobbyNetworkMode"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local9 = self
	f1_local7 = self.subscribeToModel
	f1_local10 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local9, f1_local10["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CommonButtonOutline.id = "CommonButtonOutline"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMTalismanStatusButtonInternal.__resetProperties = function(f13_arg0)
	f13_arg0.Talisman:completeAnimation()
	f13_arg0.Brackets:completeAnimation()
	f13_arg0.Dots:completeAnimation()
	f13_arg0.Lock:completeAnimation()
	f13_arg0.BannerBG:completeAnimation()
	f13_arg0.ElixirCount:completeAnimation()
	f13_arg0.Talisman:setAlpha(1)
	f13_arg0.Talisman:setScale(1, 1)
	f13_arg0.Brackets:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	f13_arg0.Brackets:setAlpha(0.5)
	f13_arg0.Brackets:setScale(1, 1)
	f13_arg0.Dots:setRGB(0.59, 0.13, 0.13)
	f13_arg0.Dots:setAlpha(0.3)
	f13_arg0.Dots:setScale(1, 1)
	f13_arg0.Lock:setAlpha(0)
	f13_arg0.BannerBG:setAlpha(1)
	f13_arg0.ElixirCount:setAlpha(1)
end
CoD.ZMTalismanStatusButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.Talisman:completeAnimation()
			f15_arg0.Talisman:setScale(1.02, 1.02)
			f15_arg0.clipFinished(f15_arg0.Talisman)
			f15_arg0.Brackets:completeAnimation()
			f15_arg0.Brackets:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f15_arg0.Brackets:setAlpha(0.8)
			f15_arg0.Brackets:setScale(1.02, 1.02)
			f15_arg0.clipFinished(f15_arg0.Brackets)
			f15_arg0.Dots:completeAnimation()
			f15_arg0.Dots:setRGB(0.89, 0.12, 0.12)
			f15_arg0.Dots:setAlpha(1)
			f15_arg0.Dots:setScale(1.02, 1.02)
			f15_arg0.clipFinished(f15_arg0.Dots)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Talisman:beginAnimation(200)
				f16_arg0.Talisman:setScale(1.02, 1.02)
				f16_arg0.Talisman:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Talisman:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Talisman:completeAnimation()
			f16_arg0.Talisman:setScale(1, 1)
			f16_local0(f16_arg0.Talisman)
			local f16_local1 = function(f18_arg0)
				f16_arg0.Brackets:beginAnimation(200)
				f16_arg0.Brackets:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f16_arg0.Brackets:setAlpha(0.8)
				f16_arg0.Brackets:setScale(1.02, 1.02)
				f16_arg0.Brackets:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Brackets:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Brackets:completeAnimation()
			f16_arg0.Brackets:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
			f16_arg0.Brackets:setAlpha(0.5)
			f16_arg0.Brackets:setScale(1, 1)
			f16_local1(f16_arg0.Brackets)
			local f16_local2 = function(f19_arg0)
				f16_arg0.Dots:beginAnimation(200)
				f16_arg0.Dots:setRGB(0.89, 0.12, 0.12)
				f16_arg0.Dots:setAlpha(1)
				f16_arg0.Dots:setScale(1.02, 1.02)
				f16_arg0.Dots:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Dots:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Dots:completeAnimation()
			f16_arg0.Dots:setRGB(0.59, 0.13, 0.13)
			f16_arg0.Dots:setAlpha(0.3)
			f16_arg0.Dots:setScale(1, 1)
			f16_local2(f16_arg0.Dots)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				f20_arg0.Talisman:beginAnimation(200)
				f20_arg0.Talisman:setScale(1, 1)
				f20_arg0.Talisman:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Talisman:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Talisman:completeAnimation()
			f20_arg0.Talisman:setScale(1.02, 1.02)
			f20_local0(f20_arg0.Talisman)
			local f20_local1 = function(f22_arg0)
				f20_arg0.Brackets:beginAnimation(200)
				f20_arg0.Brackets:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
				f20_arg0.Brackets:setAlpha(0.5)
				f20_arg0.Brackets:setScale(1, 1)
				f20_arg0.Brackets:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Brackets:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Brackets:completeAnimation()
			f20_arg0.Brackets:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f20_arg0.Brackets:setAlpha(0.8)
			f20_arg0.Brackets:setScale(1.02, 1.02)
			f20_local1(f20_arg0.Brackets)
			local f20_local2 = function(f23_arg0)
				f20_arg0.Dots:beginAnimation(200)
				f20_arg0.Dots:setRGB(0.59, 0.13, 0.13)
				f20_arg0.Dots:setAlpha(0.3)
				f20_arg0.Dots:setScale(1, 1)
				f20_arg0.Dots:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Dots:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Dots:completeAnimation()
			f20_arg0.Dots:setRGB(0.89, 0.12, 0.12)
			f20_arg0.Dots:setAlpha(1)
			f20_arg0.Dots:setScale(1.02, 1.02)
			f20_local2(f20_arg0.Dots)
		end,
	},
	Locked = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.Talisman:completeAnimation()
			f24_arg0.Talisman:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Talisman)
			f24_arg0.BannerBG:completeAnimation()
			f24_arg0.BannerBG:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.BannerBG)
			f24_arg0.ElixirCount:completeAnimation()
			f24_arg0.ElixirCount:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ElixirCount)
			f24_arg0.Lock:completeAnimation()
			f24_arg0.Lock:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.Lock)
		end,
	},
}
CoD.ZMTalismanStatusButtonInternal.__onClose = function(f25_arg0)
	f25_arg0.Talisman:close()
	f25_arg0.ElixirCount:close()
	f25_arg0.CommonButtonOutline:close()
end
