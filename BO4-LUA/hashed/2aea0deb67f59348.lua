require("x64:c77bf9b3abfcf0")
require("x64:29187ea00d726c3")
CoD.BountyHunterPreviewMultiItems = InheritFrom(LUI.UIElement)
CoD.BountyHunterPreviewMultiItems.__defaultWidth = 330
CoD.BountyHunterPreviewMultiItems.__defaultHeight = 320
CoD.BountyHunterPreviewMultiItems.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.BountyHunterPreviewMultiItems)
	self.id = "BountyHunterPreviewMultiItems"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Item1 = CoD.BountyHunterPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 0, 100)
	Item1:linkToElementModel(self, "item1", false, function(model)
		Item1:setModel(model, f1_arg1)
	end)
	self:addElement(Item1)
	self.Item1 = Item1
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 100, 120)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local Item2 = CoD.BountyHunterPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 120, 220)
	Item2:linkToElementModel(self, "item2", false, function(model)
		Item2:setModel(model, f1_arg1)
	end)
	self:addElement(Item2)
	self.Item2 = Item2
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 220, 240)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local Item3 = CoD.BountyHunterPreviewItem.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 240, 340)
	Item3:linkToElementModel(self, "item3", false, function(model)
		Item3:setModel(model, f1_arg1)
	end)
	self:addElement(Item3)
	self.Item3 = Item3
	self:mergeStateConditions({
		{
			stateName = "NoItem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathNil(self, f1_arg1, "item1")
			end,
		},
		{
			stateName = "PrimaryWeaponNotSelected",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsPreviewPackageWeaponNotSelected(self)
			end,
		},
		{
			stateName = "SecondaryWeaponNotSelected",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsPreviewPackageWeaponNotSelected(self)
			end,
		},
		{
			stateName = "SingleItem",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.IsPreviewPackageSingleItem(self)
			end,
		},
		{
			stateName = "DoubleItem",
			condition = function(menu, element, event)
				return not CoD.BountyHunterUtility.IsPreviewPackageTripleItem(self)
			end,
		},
	})
	self:linkToElementModel(self, "item1", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item1",
		})
	end)
	self:linkToElementModel(self, "packageID", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "packageID",
		})
	end)
	self:linkToElementModel(self, "item2.displayName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item2.displayName",
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
	self:linkToElementModel(self, "item3.displayName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item3.displayName",
		})
	end)
	self:linkToElementModel(self, "item3.trackTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "item3.trackTier",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPreviewMultiItems.__resetProperties = function(f16_arg0)
	f16_arg0.Item1:completeAnimation()
	f16_arg0.Item2:completeAnimation()
	f16_arg0.Item3:completeAnimation()
	f16_arg0.Item1:setAlpha(1)
	f16_arg0.Item2:setAlpha(1)
	f16_arg0.Item3:setAlpha(1)
end
CoD.BountyHunterPreviewMultiItems.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	NoItem = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.Item1:completeAnimation()
			f18_arg0.Item1:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Item1)
			f18_arg0.Item2:completeAnimation()
			f18_arg0.Item2:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Item2)
			f18_arg0.Item3:completeAnimation()
			f18_arg0.Item3:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Item3)
		end,
	},
	PrimaryWeaponNotSelected = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.Item1:completeAnimation()
			f19_arg0.Item1:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Item1)
			f19_arg0.Item2:completeAnimation()
			f19_arg0.Item2:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Item2)
			f19_arg0.Item3:completeAnimation()
			f19_arg0.Item3:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Item3)
		end,
	},
	SecondaryWeaponNotSelected = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.Item1:completeAnimation()
			f20_arg0.Item1:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Item1)
			f20_arg0.Item2:completeAnimation()
			f20_arg0.Item2:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Item2)
			f20_arg0.Item3:completeAnimation()
			f20_arg0.Item3:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Item3)
		end,
	},
	SingleItem = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.Item1:completeAnimation()
			f21_arg0.Item1:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Item1)
			f21_arg0.Item2:completeAnimation()
			f21_arg0.Item2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Item2)
			f21_arg0.Item3:completeAnimation()
			f21_arg0.Item3:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Item3)
		end,
	},
	DoubleItem = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.Item3:completeAnimation()
			f22_arg0.Item3:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Item3)
		end,
	},
}
CoD.BountyHunterPreviewMultiItems.__onClose = function(f23_arg0)
	f23_arg0.Item1:close()
	f23_arg0.VerticalListSpacer:close()
	f23_arg0.Item2:close()
	f23_arg0.VerticalListSpacer2:close()
	f23_arg0.Item3:close()
end
