CoD.BlackJacksShopCardStackSunset = InheritFrom(LUI.UIElement)
CoD.BlackJacksShopCardStackSunset.__defaultWidth = 64
CoD.BlackJacksShopCardStackSunset.__defaultHeight = 512
CoD.BlackJacksShopCardStackSunset.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BlackJacksShopCardStackSunset)
	self.id = "BlackJacksShopCardStackSunset"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -256, 256)
	Image:setImage(RegisterImage(@"hash_5C1151517416D65C"))
	self:addElement(Image)
	self.Image = Image
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
				if f2_local0 then
					f2_local0 = IsMenuPropertyValue(menu, "_currentTab", "itemshop")
					if f2_local0 then
						f2_local0 = not CoD.ModelUtility.IsSelfModelValueNilOrTrue(element, f1_arg1, "emptyItem")
					end
				end
				return f2_local0
			end,
		},
	})
	self:linkToElementModel(self, "emptyItem", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "emptyItem",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BlackJacksShopCardStackSunset.__resetProperties = function(f4_arg0)
	f4_arg0.Image:completeAnimation()
	f4_arg0.Image:setAlpha(1)
end
CoD.BlackJacksShopCardStackSunset.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Image:completeAnimation()
			f5_arg0.Image:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Image)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Image:completeAnimation()
			f6_arg0.Image:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Image)
		end,
	},
}
