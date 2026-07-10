require("x64:900411928432cff")
CoD.StoreFeaturedCenterButton = InheritFrom(LUI.UIElement)
CoD.StoreFeaturedCenterButton.__defaultWidth = 324
CoD.StoreFeaturedCenterButton.__defaultHeight = 324
CoD.StoreFeaturedCenterButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StoreFeaturedCenterButton)
	self.id = "StoreFeaturedCenterButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local itemImage = CoD.StoreFeaturedCenterButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 324, 0, 0, 0, 324)
	itemImage:linkToElementModel(self, nil, false, function(model)
		itemImage:setModel(model, f1_arg1)
	end)
	self:addElement(itemImage)
	self.itemImage = itemImage
	self:mergeStateConditions({
		{
			stateName = "Large",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "large")
			end,
		},
	})
	self:linkToElementModel(self, "large", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "large",
		})
	end)
	itemImage.id = "itemImage"
	self.__defaultFocus = itemImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StoreFeaturedCenterButton.__resetProperties = function(f5_arg0)
	f5_arg0.itemImage:completeAnimation()
	f5_arg0.itemImage:setLeftRight(0, 0, 0, 324)
	f5_arg0.itemImage:setTopBottom(0, 0, 0, 324)
	f5_arg0.itemImage:setScale(1, 1)
end
CoD.StoreFeaturedCenterButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.itemImage:completeAnimation()
			f6_arg0.itemImage:setLeftRight(0, 0, 0, 324)
			f6_arg0.itemImage:setTopBottom(0, 0, 0, 324)
			f6_arg0.itemImage:setScale(1, 1)
			f6_arg0.clipFinished(f6_arg0.itemImage)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.itemImage:completeAnimation()
			f7_arg0.itemImage:setScale(1.03, 1.03)
			f7_arg0.clipFinished(f7_arg0.itemImage)
		end,
		GainChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.itemImage:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f8_arg0.itemImage:setScale(1.03, 1.03)
				f8_arg0.itemImage:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.itemImage:completeAnimation()
			f8_arg0.itemImage:setScale(1, 1)
			f8_local0(f8_arg0.itemImage)
		end,
		LoseChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.itemImage:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f10_arg0.itemImage:setScale(1, 1)
				f10_arg0.itemImage:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.itemImage:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.itemImage:completeAnimation()
			f10_arg0.itemImage:setScale(1.03, 1.03)
			f10_local0(f10_arg0.itemImage)
		end,
	},
	Large = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.itemImage:completeAnimation()
			f12_arg0.itemImage:setLeftRight(0, 0, 0, 680)
			f12_arg0.itemImage:setTopBottom(0, 0, 0, 680)
			f12_arg0.clipFinished(f12_arg0.itemImage)
		end,
	},
}
CoD.StoreFeaturedCenterButton.__onClose = function(f13_arg0)
	f13_arg0.itemImage:close()
end
