require("x64:c7b665b749178c8")
require("x64:8cd770250906213")
require("x64:1590f9a531858e0")
require("x64:5f8cf56752aa71b")
require("x64:1f846296f1a1b81")
CoD.StoreCategoryButton = InheritFrom(LUI.UIElement)
CoD.StoreCategoryButton.__defaultWidth = 324
CoD.StoreCategoryButton.__defaultHeight = 80
CoD.StoreCategoryButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StoreCategoryButton)
	self.id = "StoreCategoryButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BoxButtonLrgInactive = CoD.cac_ButtonBoxLrgInactive.new(f1_arg0, f1_arg1, 0, 1, -3, 3, 0, 1, -3, 3)
	BoxButtonLrgInactive:setAlpha(0)
	self:addElement(BoxButtonLrgInactive)
	self.BoxButtonLrgInactive = BoxButtonLrgInactive
	local BoxButtonLrgIdle = CoD.cac_ButtonBoxLrgIdle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	BoxButtonLrgIdle:setAlpha(0)
	self:addElement(BoxButtonLrgIdle)
	self.BoxButtonLrgIdle = BoxButtonLrgIdle
	local itemImageBg = LUI.UIImage.new(0, 0, 1, 79, 0.5, 0.5, -38.5, 39.5)
	itemImageBg:setRGB(0.06, 0.08, 0.1)
	itemImageBg:setAlpha(0)
	self:addElement(itemImageBg)
	self.itemImageBg = itemImageBg
	local itemName = CoD.cac_ListButtonLabel.new(f1_arg0, f1_arg1, 0, 0, 104, 296, 0, 0, 25.5, 55.5)
	itemName:setAlpha(0)
	itemName:linkToElementModel(self, "categoryNameRefXhash", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			itemName.itemName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(itemName)
	self.itemName = itemName
	local itemImage = LUI.UIImage.new(0, 0, 9.5, 70.5, 0.5, 0.5, -28.5, 28.5)
	itemImage:setAlpha(0)
	itemImage:linkToElementModel(self, "imageName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			itemImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(itemImage)
	self.itemImage = itemImage
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 0, 2, 321, 0, 0, 3.5, 77.5)
	CommonButtonOutline:setAlpha(0)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "categoryNameRefXhash", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "categoryNameRefXhash", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	CommonButtonOutline.id = "CommonButtonOutline"
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	self.__defaultFocus = DirectorSelectButtonMiniInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StoreCategoryButton.__resetProperties = function(f6_arg0)
	f6_arg0.BoxButtonLrgInactive:completeAnimation()
	f6_arg0.BoxButtonLrgIdle:completeAnimation()
	f6_arg0.itemImageBg:completeAnimation()
	f6_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f6_arg0.itemImage:completeAnimation()
	f6_arg0.itemName:completeAnimation()
	f6_arg0.BoxButtonLrgInactive:setLeftRight(0, 1, -3, 3)
	f6_arg0.BoxButtonLrgInactive:setTopBottom(0, 1, -3, 3)
	f6_arg0.BoxButtonLrgIdle:setRGB(1, 1, 1)
	f6_arg0.itemImageBg:setAlpha(0)
	f6_arg0.itemImageBg:setZoom(0)
	f6_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
	f6_arg0.itemImage:setAlpha(0)
	f6_arg0.itemName:setAlpha(0)
end
CoD.StoreCategoryButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.BoxButtonLrgInactive:completeAnimation()
			f7_arg0.BoxButtonLrgInactive:setLeftRight(0, 1, -4, 0)
			f7_arg0.BoxButtonLrgInactive:setTopBottom(0, 1, -3, 3)
			f7_arg0.clipFinished(f7_arg0.BoxButtonLrgInactive)
			f7_arg0.BoxButtonLrgIdle:completeAnimation()
			f7_arg0.BoxButtonLrgIdle:setRGB(0.6, 0.6, 0.6)
			f7_arg0.clipFinished(f7_arg0.BoxButtonLrgIdle)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.itemImageBg:beginAnimation(200)
				f8_arg0.itemImageBg:setAlpha(0)
				f8_arg0.itemImageBg:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.itemImageBg:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.itemImageBg:completeAnimation()
			f8_arg0.itemImageBg:setAlpha(1)
			f8_local0(f8_arg0.itemImageBg)
			local f8_local1 = function(f10_arg0)
				f8_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f8_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
				f8_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f8_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f8_local1(f8_arg0.DirectorSelectButtonMiniInternal)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.itemImageBg:beginAnimation(200, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_out"])
				f11_arg0.itemImageBg:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.itemImageBg:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.itemImageBg:completeAnimation()
			f11_arg0.itemImageBg:setZoom(0)
			f11_local0(f11_arg0.itemImageBg)
			local f11_local1 = function(f13_arg0)
				f11_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f11_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f11_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f11_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f11_local1(f11_arg0.DirectorSelectButtonMiniInternal)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.BoxButtonLrgIdle:completeAnimation()
			f14_arg0.BoxButtonLrgIdle:setRGB(1, 1, 1)
			f14_arg0.clipFinished(f14_arg0.BoxButtonLrgIdle)
			f14_arg0.itemImage:completeAnimation()
			f14_arg0.itemImage:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.itemImage)
			f14_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f14_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f14_arg0.clipFinished(f14_arg0.DirectorSelectButtonMiniInternal)
		end,
		Active = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.BoxButtonLrgIdle:completeAnimation()
			f15_arg0.BoxButtonLrgIdle:setRGB(1, 1, 1)
			f15_arg0.clipFinished(f15_arg0.BoxButtonLrgIdle)
			f15_arg0.itemImage:completeAnimation()
			f15_arg0.itemImage:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.itemImage)
			f15_arg0.DirectorSelectButtonMiniInternal:beginAnimation(240)
			f15_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f15_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
			f15_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
		end,
	},
	NoListFocus = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.itemImageBg:completeAnimation()
			f16_arg0.itemImageBg:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.itemImageBg)
			f16_arg0.itemName:completeAnimation()
			f16_arg0.itemName:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.itemName)
			f16_arg0.itemImage:completeAnimation()
			f16_arg0.itemImage:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.itemImage)
			f16_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f16_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f16_arg0.clipFinished(f16_arg0.DirectorSelectButtonMiniInternal)
		end,
		Active = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.BoxButtonLrgInactive:completeAnimation()
			f17_arg0.BoxButtonLrgInactive:setLeftRight(0, 1, -4, 0)
			f17_arg0.BoxButtonLrgInactive:setTopBottom(0, 1, -3, 3)
			f17_arg0.clipFinished(f17_arg0.BoxButtonLrgInactive)
			f17_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f17_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
}
CoD.StoreCategoryButton.__onClose = function(f18_arg0)
	f18_arg0.BoxButtonLrgInactive:close()
	f18_arg0.BoxButtonLrgIdle:close()
	f18_arg0.itemName:close()
	f18_arg0.itemImage:close()
	f18_arg0.CommonButtonOutline:close()
	f18_arg0.DirectorSelectButtonMiniInternal:close()
end
