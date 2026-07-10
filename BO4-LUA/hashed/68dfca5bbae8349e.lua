require("x64:9e155239e6593c")
CoD.BountyHunterPreviewDollars = InheritFrom(LUI.UIElement)
CoD.BountyHunterPreviewDollars.__defaultWidth = 150
CoD.BountyHunterPreviewDollars.__defaultHeight = 33
CoD.BountyHunterPreviewDollars.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterPreviewDollars)
	self.id = "BountyHunterPreviewDollars"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonSubheaderBG = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0, 0, -3, 367, 0, 0, -1.5, 34.5)
	CommonSubheaderBG.NoiseTiledBacking3:setAlpha(0)
	self:addElement(CommonSubheaderBG)
	self.CommonSubheaderBG = CommonSubheaderBG
	local Purchased = LUI.UIText.new(0, 0, 0, 200, -0, 1, 0, 0)
	Purchased:setRGB(0.76, 0.92, 0.59)
	Purchased:setAlpha(0)
	Purchased:setText(Engine[0xF9F1239CFD921FE](0x162FE5AE72BC9F7))
	Purchased:setTTF("ttmussels_regular")
	Purchased:setLetterSpacing(4)
	Purchased:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Purchased:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Purchased)
	self.Purchased = Purchased
	local Cost = LUI.UIText.new(0, 0, 22, 222, -0, 1, 0, 0)
	Cost:setRGB(0.76, 0.92, 0.59)
	Cost:setTTF("ttmussels_regular")
	Cost:setLetterSpacing(4)
	Cost:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Cost:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Cost:linkToElementModel(self, "buyCost", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Cost:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(Cost)
	self.Cost = Cost
	local CostSign = LUI.UIText.new(0, 0, 0, 22, 0, 1, 0, 0)
	CostSign:setRGB(0.76, 0.92, 0.59)
	CostSign:setText(CoD.BaseUtility.AlreadyLocalized("$"))
	CostSign:setTTF("ttmussels_regular")
	CostSign:setLetterSpacing(4)
	CostSign:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CostSign:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CostSign)
	self.CostSign = CostSign
	self:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.HasPreviewBeenPurchased(self, menu)
			end,
		},
	})
	self:linkToElementModel(self, "packageID", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "packageID",
		})
	end)
	self:linkToElementModel(self, "trackModel", true, function(model)
		if self["__stateValidation_trackModel->tierPurchased"] then
			self:removeSubscription(self["__stateValidation_trackModel->tierPurchased"])
			self["__stateValidation_trackModel->tierPurchased"] = nil
		end
		if model then
			local f5_local0 = model:get()
			local f5_local1 = model:get()
			model = f5_local0 and f5_local1.tierPurchased
		end
		if model then
			self["__stateValidation_trackModel->tierPurchased"] = self:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(self, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "trackModel->tierPurchased",
				})
			end)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterPreviewDollars.__resetProperties = function(f7_arg0)
	f7_arg0.CostSign:completeAnimation()
	f7_arg0.Purchased:completeAnimation()
	f7_arg0.CommonSubheaderBG:completeAnimation()
	f7_arg0.Cost:completeAnimation()
	f7_arg0.CostSign:setAlpha(1)
	f7_arg0.Purchased:setRGB(0.76, 0.92, 0.59)
	f7_arg0.Purchased:setAlpha(0)
	f7_arg0.CommonSubheaderBG:setRGB(1, 1, 1)
	f7_arg0.CommonSubheaderBG.NoiseTiledBacking:setRGB(0.48, 0.59, 0.41)
	f7_arg0.CommonSubheaderBG.NoiseTiledBacking3:setRGB(0.75, 0.92, 0.59)
	f7_arg0.CommonSubheaderBG.NoiseTiledBacking2:setRGB(0.75, 0.92, 0.59)
	f7_arg0.Cost:setRGB(0.76, 0.92, 0.59)
	f7_arg0.Cost:setAlpha(1)
end
CoD.BountyHunterPreviewDollars.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Purchased = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.CommonSubheaderBG:completeAnimation()
			f9_arg0.CommonSubheaderBG.NoiseTiledBacking:completeAnimation()
			f9_arg0.CommonSubheaderBG.NoiseTiledBacking3:completeAnimation()
			f9_arg0.CommonSubheaderBG.NoiseTiledBacking2:completeAnimation()
			f9_arg0.CommonSubheaderBG:setRGB(1, 1, 1)
			f9_arg0.CommonSubheaderBG.NoiseTiledBacking:setRGB(0.56, 0.59, 0.55)
			f9_arg0.CommonSubheaderBG.NoiseTiledBacking3:setRGB(0.88, 0.92, 0.84)
			f9_arg0.CommonSubheaderBG.NoiseTiledBacking2:setRGB(0.88, 0.92, 0.84)
			f9_arg0.clipFinished(f9_arg0.CommonSubheaderBG)
			f9_arg0.Purchased:completeAnimation()
			f9_arg0.Purchased:setRGB(0.89, 0.92, 0.87)
			f9_arg0.Purchased:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Purchased)
			f9_arg0.Cost:completeAnimation()
			f9_arg0.Cost:setRGB(0.76, 0.92, 0.59)
			f9_arg0.Cost:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Cost)
			f9_arg0.CostSign:completeAnimation()
			f9_arg0.CostSign:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CostSign)
		end,
	},
}
CoD.BountyHunterPreviewDollars.__onClose = function(f10_arg0)
	f10_arg0.CommonSubheaderBG:close()
	f10_arg0.Cost:close()
end
