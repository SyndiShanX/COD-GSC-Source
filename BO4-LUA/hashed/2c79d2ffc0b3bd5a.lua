require("x64:477e76e9238f584")
require("x64:e3fbf24cbcafdec")
require("x64:7cbfa407a04c94a")
CoD.BountyHunterPackageTierInternal = InheritFrom(LUI.UIElement)
CoD.BountyHunterPackageTierInternal.__defaultWidth = 345
CoD.BountyHunterPackageTierInternal.__defaultHeight = 127
CoD.BountyHunterPackageTierInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterPackageTierInternal)
	self.id = "BountyHunterPackageTierInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.BountyHunterTierBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 345, 0, 1, 0, 0)
	Backing:linkToElementModel(self, nil, false, function(model)
		Backing:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Backing, "childFocusGained", function(element)
		CoD.BountyHunterUtility.SetCurrentPreviewedPackage(element, f1_arg0)
	end)
	self:addElement(Backing)
	self.Backing = Backing
	local Item1 = CoD.BountyHunterPackageTierItem.new(f1_arg0, f1_arg1, 0, 0, 0, 115, 0.5, 0.5, -57.5, 57.5)
	Item1:linkToElementModel(self, "item1", false, function(model)
		Item1:setModel(model, f1_arg1)
	end)
	self:addElement(Item1)
	self.Item1 = Item1
	local Item2 = CoD.BountyHunterPackageTierItem.new(f1_arg0, f1_arg1, 0, 0, 116, 231, 0.5, 0.5, -57.5, 57.5)
	Item2:linkToElementModel(self, "item2", false, function(model)
		Item2:setModel(model, f1_arg1)
	end)
	self:addElement(Item2)
	self.Item2 = Item2
	local Item3 = CoD.BountyHunterPackageTierItem.new(f1_arg0, f1_arg1, 0, 0, 231, 346, 0.5, 0.5, -57.5, 57.5)
	Item3:linkToElementModel(self, "item3", false, function(model)
		Item3:setModel(model, f1_arg1)
	end)
	self:addElement(Item3)
	self.Item3 = Item3
	local BountyHunterDollars = CoD.BountyHunterDollars.new(f1_arg0, f1_arg1, 0, 0, 3, 73, 0, 0, 3.5, 21.5)
	BountyHunterDollars:linkToElementModel(self, nil, false, function(model)
		BountyHunterDollars:setModel(model, f1_arg1)
	end)
	self:addElement(BountyHunterDollars)
	self.BountyHunterDollars = BountyHunterDollars
	self:mergeStateConditions({
		{
			stateName = "OneItem",
			condition = function(menu, element, event)
				local f8_local0
				if not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "item3.trackTier", 0) then
					f8_local0 = not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "item2.trackTier", 0)
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
		{
			stateName = "TwoItems",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "item3.trackTier", 0)
			end,
		},
		{
			stateName = "ThreeItems",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "item3.trackTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item3.trackTier",
		})
	end)
	self:linkToElementModel(self, "item2.trackTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item2.trackTier",
		})
	end)
	Backing.id = "Backing"
	self.__defaultFocus = Backing
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPackageTierInternal.__resetProperties = function(f13_arg0)
	f13_arg0.Item2:completeAnimation()
	f13_arg0.Item3:completeAnimation()
	f13_arg0.Backing:completeAnimation()
	f13_arg0.Item2:setAlpha(1)
	f13_arg0.Item3:setAlpha(1)
	f13_arg0.Backing:setLeftRight(0, 0, 0, 345)
end
CoD.BountyHunterPackageTierInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	OneItem = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.Backing:completeAnimation()
			f15_arg0.Backing:setLeftRight(0, 0, 0, 127)
			f15_arg0.clipFinished(f15_arg0.Backing)
			f15_arg0.Item2:completeAnimation()
			f15_arg0.Item2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Item2)
			f15_arg0.Item3:completeAnimation()
			f15_arg0.Item3:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Item3)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setLeftRight(0, 0, 0, 127)
			f16_arg0.clipFinished(f16_arg0.Backing)
			f16_arg0.Item2:completeAnimation()
			f16_arg0.Item2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Item2)
			f16_arg0.Item3:completeAnimation()
			f16_arg0.Item3:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Item3)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.Backing:completeAnimation()
			f17_arg0.Backing:setLeftRight(0, 0, 0, 127)
			f17_arg0.clipFinished(f17_arg0.Backing)
			f17_arg0.Item2:completeAnimation()
			f17_arg0.Item2:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Item2)
			f17_arg0.Item3:completeAnimation()
			f17_arg0.Item3:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Item3)
		end,
		LoseChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.Backing:completeAnimation()
			f18_arg0.Backing:setLeftRight(0, 0, 0, 127)
			f18_arg0.clipFinished(f18_arg0.Backing)
			f18_arg0.Item2:completeAnimation()
			f18_arg0.Item2:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Item2)
			f18_arg0.Item3:completeAnimation()
			f18_arg0.Item3:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Item3)
		end,
	},
	TwoItems = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setLeftRight(0, 0, 0, 254)
			f19_arg0.clipFinished(f19_arg0.Backing)
			f19_arg0.Item3:completeAnimation()
			f19_arg0.Item3:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Item3)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.Backing:completeAnimation()
			f20_arg0.Backing:setLeftRight(0, 0, 0, 254)
			f20_arg0.clipFinished(f20_arg0.Backing)
			f20_arg0.Item3:completeAnimation()
			f20_arg0.Item3:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Item3)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.Backing:completeAnimation()
			f21_arg0.Backing:setLeftRight(0, 0, 0, 254)
			f21_arg0.clipFinished(f21_arg0.Backing)
			f21_arg0.Item3:completeAnimation()
			f21_arg0.Item3:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Item3)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.Backing:completeAnimation()
			f22_arg0.Backing:setLeftRight(0, 0, 0, 254)
			f22_arg0.clipFinished(f22_arg0.Backing)
			f22_arg0.Item3:completeAnimation()
			f22_arg0.Item3:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Item3)
		end,
	},
	ThreeItems = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.BountyHunterPackageTierInternal.__onClose = function(f24_arg0)
	f24_arg0.Backing:close()
	f24_arg0.Item1:close()
	f24_arg0.Item2:close()
	f24_arg0.Item3:close()
	f24_arg0.BountyHunterDollars:close()
end
