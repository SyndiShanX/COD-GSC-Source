CoD.ChooseClassOverlay = InheritFrom(LUI.UIElement)
CoD.ChooseClassOverlay.__defaultWidth = 1920
CoD.ChooseClassOverlay.__defaultHeight = 1080
CoD.ChooseClassOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChooseClassOverlay)
	self.id = "ChooseClassOverlay"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BgOverlayTopWildcard = LUI.UIImage.new(-0.12, 1.12, 0, 0, 0, 1, 0, 0)
	BgOverlayTopWildcard:setRGB(0, 0, 0)
	BgOverlayTopWildcard:setAlpha(0)
	BgOverlayTopWildcard:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	BgOverlayTopWildcard:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(BgOverlayTopWildcard)
	self.BgOverlayTopWildcard = BgOverlayTopWildcard
	local BgOverlayRightPerks = LUI.UIImage.new(0.5, 0.5, 707, 1201, 1, 1, -515, 1)
	BgOverlayRightPerks:setRGB(0, 0, 0)
	BgOverlayRightPerks:setAlpha(0)
	BgOverlayRightPerks:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayRightPerks)
	self.BgOverlayRightPerks = BgOverlayRightPerks
	local BgOverlayBottomPerks = LUI.UIImage.new(0.5, 0.5, 325, 707, 1, 1, -295, 1)
	BgOverlayBottomPerks:setRGB(0, 0, 0)
	BgOverlayBottomPerks:setAlpha(0)
	BgOverlayBottomPerks:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayBottomPerks)
	self.BgOverlayBottomPerks = BgOverlayBottomPerks
	local BgOverlayLeftPerks = LUI.UIImage.new(0.5, 0.5, -1200, 325, 1, 1, -515, 1)
	BgOverlayLeftPerks:setRGB(0, 0, 0)
	BgOverlayLeftPerks:setAlpha(0)
	BgOverlayLeftPerks:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayLeftPerks)
	self.BgOverlayLeftPerks = BgOverlayLeftPerks
	local BgOverlayMiddlePerks = LUI.UIImage.new(0.5, 0.5, 325, 707, 1, 1, -515, -295)
	BgOverlayMiddlePerks:setRGB(0, 0, 0)
	BgOverlayMiddlePerks:setAlpha(0)
	BgOverlayMiddlePerks:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayMiddlePerks)
	self.BgOverlayMiddlePerks = BgOverlayMiddlePerks
	local BgOverlayLeftSecondary = LUI.UIImage.new(0.5, 0.5, -1200, -305, 1, 1, -515, 1)
	BgOverlayLeftSecondary:setRGB(0, 0, 0)
	BgOverlayLeftSecondary:setAlpha(0)
	BgOverlayLeftSecondary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayLeftSecondary)
	self.BgOverlayLeftSecondary = BgOverlayLeftSecondary
	local BgOverlayRightSecondary = LUI.UIImage.new(0.5, 0.5, 66, 1200, 1, 1, -515, 1)
	BgOverlayRightSecondary:setRGB(0, 0, 0)
	BgOverlayRightSecondary:setAlpha(0)
	BgOverlayRightSecondary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayRightSecondary)
	self.BgOverlayRightSecondary = BgOverlayRightSecondary
	local BgOverlayBottomSecondary = LUI.UIImage.new(0.5, 0.5, -305, 66, 1, 1, -91, 1)
	BgOverlayBottomSecondary:setRGB(0, 0, 0)
	BgOverlayBottomSecondary:setAlpha(0)
	BgOverlayBottomSecondary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayBottomSecondary)
	self.BgOverlayBottomSecondary = BgOverlayBottomSecondary
	local BgOverlayMiddleSecondary = LUI.UIImage.new(0.5, 0.5, -305, 66, 1, 1, -515, -91)
	BgOverlayMiddleSecondary:setRGB(0, 0, 0)
	BgOverlayMiddleSecondary:setAlpha(0)
	BgOverlayMiddleSecondary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayMiddleSecondary)
	self.BgOverlayMiddleSecondary = BgOverlayMiddleSecondary
	local BgOverlayLeftPrimary = LUI.UIImage.new(0.5, 0.5, -1200, -685, 1, 1, -515, 1)
	BgOverlayLeftPrimary:setRGB(0, 0, 0)
	BgOverlayLeftPrimary:setAlpha(0)
	BgOverlayLeftPrimary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayLeftPrimary)
	self.BgOverlayLeftPrimary = BgOverlayLeftPrimary
	local BgOverlayMiddlePrimary = LUI.UIImage.new(0.5, 0.5, -685, -317, 1, 1, -515, -91)
	BgOverlayMiddlePrimary:setRGB(0, 0, 0)
	BgOverlayMiddlePrimary:setAlpha(0)
	BgOverlayMiddlePrimary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayMiddlePrimary)
	self.BgOverlayMiddlePrimary = BgOverlayMiddlePrimary
	local BgOverlayBottomPrimary = LUI.UIImage.new(0.5, 0.5, -685, -317, 1, 1, -91, 1)
	BgOverlayBottomPrimary:setRGB(0, 0, 0)
	BgOverlayBottomPrimary:setAlpha(0)
	BgOverlayBottomPrimary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayBottomPrimary)
	self.BgOverlayBottomPrimary = BgOverlayBottomPrimary
	local BgOverlayRightPrimary = LUI.UIImage.new(0.5, 0.5, -317.5, 1199.5, 1, 1, -515, 1)
	BgOverlayRightPrimary:setRGB(0, 0, 0)
	BgOverlayRightPrimary:setAlpha(0)
	BgOverlayRightPrimary:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	self:addElement(BgOverlayRightPrimary)
	self.BgOverlayRightPrimary = BgOverlayRightPrimary
	local BgOverlayTop = LUI.UIImage.new(-0.12, 1.12, 0, 0, 1, 1, -1080, -515)
	BgOverlayTop:setRGB(0, 0, 0)
	BgOverlayTop:setAlpha(0)
	BgOverlayTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_multiply"))
	BgOverlayTop:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(BgOverlayTop)
	self.BgOverlayTop = BgOverlayTop
	self:mergeStateConditions({
		{
			stateName = "WildcardPrimary",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "WildcardMenuOpen") and CoD.BonuscardUtility.IsBonuscardModifiedEnumPrimary(f1_arg1)
			end,
		},
		{
			stateName = "WildcardSecondary",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "WildcardMenuOpen") and CoD.BonuscardUtility.IsBonuscardModifiedEnumSecondary(f1_arg1)
			end,
		},
		{
			stateName = "WildcardPerks",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "WildcardMenuOpen") and CoD.BonuscardUtility.IsBonuscardModifiedEnumPerks(f1_arg1)
			end,
		},
		{
			stateName = "WildcardOverlay",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "WildcardMenuOpen")
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local16(f1_local15, f1_local17.WildcardMenuOpen, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "WildcardMenuOpen",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local16(f1_local15, f1_local17.BonuscardModifiedSlotEnum, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "BonuscardModifiedSlotEnum",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChooseClassOverlay.__resetProperties = function(f10_arg0)
	f10_arg0.BgOverlayTop:completeAnimation()
	f10_arg0.BgOverlayLeftPrimary:completeAnimation()
	f10_arg0.BgOverlayRightPrimary:completeAnimation()
	f10_arg0.BgOverlayMiddlePrimary:completeAnimation()
	f10_arg0.BgOverlayBottomPrimary:completeAnimation()
	f10_arg0.BgOverlayRightSecondary:completeAnimation()
	f10_arg0.BgOverlayLeftSecondary:completeAnimation()
	f10_arg0.BgOverlayMiddleSecondary:completeAnimation()
	f10_arg0.BgOverlayBottomSecondary:completeAnimation()
	f10_arg0.BgOverlayLeftPerks:completeAnimation()
	f10_arg0.BgOverlayBottomPerks:completeAnimation()
	f10_arg0.BgOverlayRightPerks:completeAnimation()
	f10_arg0.BgOverlayMiddlePerks:completeAnimation()
	f10_arg0.BgOverlayTopWildcard:completeAnimation()
	f10_arg0.BgOverlayTop:setAlpha(0)
	f10_arg0.BgOverlayLeftPrimary:setLeftRight(0.5, 0.5, -1200, -685)
	f10_arg0.BgOverlayLeftPrimary:setAlpha(0)
	f10_arg0.BgOverlayRightPrimary:setLeftRight(0.5, 0.5, -317.5, 1199.5)
	f10_arg0.BgOverlayRightPrimary:setAlpha(0)
	f10_arg0.BgOverlayMiddlePrimary:setAlpha(0)
	f10_arg0.BgOverlayBottomPrimary:setAlpha(0)
	f10_arg0.BgOverlayRightSecondary:setLeftRight(0.5, 0.5, 66, 1200)
	f10_arg0.BgOverlayRightSecondary:setAlpha(0)
	f10_arg0.BgOverlayLeftSecondary:setLeftRight(0.5, 0.5, -1200, -305)
	f10_arg0.BgOverlayLeftSecondary:setAlpha(0)
	f10_arg0.BgOverlayMiddleSecondary:setAlpha(0)
	f10_arg0.BgOverlayBottomSecondary:setAlpha(0)
	f10_arg0.BgOverlayLeftPerks:setLeftRight(0.5, 0.5, -1200, 325)
	f10_arg0.BgOverlayLeftPerks:setAlpha(0)
	f10_arg0.BgOverlayBottomPerks:setAlpha(0)
	f10_arg0.BgOverlayRightPerks:setLeftRight(0.5, 0.5, 707, 1201)
	f10_arg0.BgOverlayRightPerks:setAlpha(0)
	f10_arg0.BgOverlayMiddlePerks:setAlpha(0)
	f10_arg0.BgOverlayTopWildcard:setAlpha(0)
end
CoD.ChooseClassOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	WildcardPrimary = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.BgOverlayLeftPrimary:completeAnimation()
			f12_arg0.BgOverlayLeftPrimary:setLeftRight(0.5, 0.5, -1936, -685)
			f12_arg0.BgOverlayLeftPrimary:setAlpha(0.9)
			f12_arg0.clipFinished(f12_arg0.BgOverlayLeftPrimary)
			local f12_local0 = function(f13_arg0)
				f12_arg0.BgOverlayMiddlePrimary:beginAnimation(200)
				f12_arg0.BgOverlayMiddlePrimary:setAlpha(0)
				f12_arg0.BgOverlayMiddlePrimary:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BgOverlayMiddlePrimary:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.BgOverlayMiddlePrimary:completeAnimation()
			f12_arg0.BgOverlayMiddlePrimary:setAlpha(0.9)
			f12_local0(f12_arg0.BgOverlayMiddlePrimary)
			f12_arg0.BgOverlayBottomPrimary:completeAnimation()
			f12_arg0.BgOverlayBottomPrimary:setAlpha(0.9)
			f12_arg0.clipFinished(f12_arg0.BgOverlayBottomPrimary)
			f12_arg0.BgOverlayRightPrimary:completeAnimation()
			f12_arg0.BgOverlayRightPrimary:setLeftRight(0.5, 0.5, -317.5, 1943.5)
			f12_arg0.BgOverlayRightPrimary:setAlpha(0.9)
			f12_arg0.clipFinished(f12_arg0.BgOverlayRightPrimary)
			f12_arg0.BgOverlayTop:completeAnimation()
			f12_arg0.BgOverlayTop:setAlpha(0.9)
			f12_arg0.clipFinished(f12_arg0.BgOverlayTop)
		end,
	},
	WildcardSecondary = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.BgOverlayLeftSecondary:completeAnimation()
			f14_arg0.BgOverlayLeftSecondary:setLeftRight(0.5, 0.5, -2388, -305)
			f14_arg0.BgOverlayLeftSecondary:setAlpha(0.9)
			f14_arg0.clipFinished(f14_arg0.BgOverlayLeftSecondary)
			f14_arg0.BgOverlayRightSecondary:completeAnimation()
			f14_arg0.BgOverlayRightSecondary:setLeftRight(0.5, 0.5, 66, 2395)
			f14_arg0.BgOverlayRightSecondary:setAlpha(0.9)
			f14_arg0.clipFinished(f14_arg0.BgOverlayRightSecondary)
			f14_arg0.BgOverlayBottomSecondary:completeAnimation()
			f14_arg0.BgOverlayBottomSecondary:setAlpha(0.9)
			f14_arg0.clipFinished(f14_arg0.BgOverlayBottomSecondary)
			local f14_local0 = function(f15_arg0)
				f14_arg0.BgOverlayMiddleSecondary:beginAnimation(200)
				f14_arg0.BgOverlayMiddleSecondary:setAlpha(0)
				f14_arg0.BgOverlayMiddleSecondary:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.BgOverlayMiddleSecondary:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.BgOverlayMiddleSecondary:completeAnimation()
			f14_arg0.BgOverlayMiddleSecondary:setAlpha(0.9)
			f14_local0(f14_arg0.BgOverlayMiddleSecondary)
			f14_arg0.BgOverlayTop:completeAnimation()
			f14_arg0.BgOverlayTop:setAlpha(0.9)
			f14_arg0.clipFinished(f14_arg0.BgOverlayTop)
		end,
	},
	WildcardPerks = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(5)
			f16_arg0.BgOverlayRightPerks:completeAnimation()
			f16_arg0.BgOverlayRightPerks:setLeftRight(0.5, 0.5, 707, 2395)
			f16_arg0.BgOverlayRightPerks:setAlpha(0.8)
			f16_arg0.clipFinished(f16_arg0.BgOverlayRightPerks)
			f16_arg0.BgOverlayBottomPerks:completeAnimation()
			f16_arg0.BgOverlayBottomPerks:setAlpha(0.8)
			f16_arg0.clipFinished(f16_arg0.BgOverlayBottomPerks)
			f16_arg0.BgOverlayLeftPerks:completeAnimation()
			f16_arg0.BgOverlayLeftPerks:setLeftRight(0.5, 0.5, -2394, 325)
			f16_arg0.BgOverlayLeftPerks:setAlpha(0.8)
			f16_arg0.clipFinished(f16_arg0.BgOverlayLeftPerks)
			local f16_local0 = function(f17_arg0)
				f16_arg0.BgOverlayMiddlePerks:beginAnimation(200)
				f16_arg0.BgOverlayMiddlePerks:setAlpha(0)
				f16_arg0.BgOverlayMiddlePerks:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.BgOverlayMiddlePerks:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.BgOverlayMiddlePerks:completeAnimation()
			f16_arg0.BgOverlayMiddlePerks:setAlpha(0.8)
			f16_local0(f16_arg0.BgOverlayMiddlePerks)
			f16_arg0.BgOverlayTop:completeAnimation()
			f16_arg0.BgOverlayTop:setAlpha(0.8)
			f16_arg0.clipFinished(f16_arg0.BgOverlayTop)
		end,
	},
	WildcardOverlay = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.BgOverlayTopWildcard:completeAnimation()
			f18_arg0.BgOverlayTopWildcard:setAlpha(0.8)
			f18_arg0.clipFinished(f18_arg0.BgOverlayTopWildcard)
			f18_arg0.BgOverlayTop:completeAnimation()
			f18_arg0.BgOverlayTop:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.BgOverlayTop)
		end,
	},
}
