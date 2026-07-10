require("x64:10239005cc36b68")
require("x64:8a3543a913958f1")
require("x64:c08a2aab18ca343")
CoD.BM_DailyContract = InheritFrom(LUI.UIElement)
CoD.BM_DailyContract.__defaultWidth = 550
CoD.BM_DailyContract.__defaultHeight = 1080
CoD.BM_DailyContract.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_DailyContract)
	self.id = "BM_DailyContract"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledBacking = LUI.UIImage.new(-0, 1, 0, 0, 0, 0, 190, 826)
	TiledBacking:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TiledBacking:setAlpha(0.8)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local BottomDarkening = LUI.UIImage.new(-0, 0.99, 3, 3, 1, 1, -396.5, -254.5)
	BottomDarkening:setRGB(0.09, 0.08, 0.06)
	BottomDarkening:setAlpha(0.41)
	self:addElement(BottomDarkening)
	self.BottomDarkening = BottomDarkening
	local CompletedBox = LUI.UIImage.new(0.5, 0.5, -261, 262, 0.5, 0.5, -326.5, 131.5)
	CompletedBox:setRGB(0.4, 0.55, 0.22)
	CompletedBox:setAlpha(0)
	self:addElement(CompletedBox)
	self.CompletedBox = CompletedBox
	local GridTiled = LUI.UIImage.new(0.04, 0.04, -20, 528, 1, 1, -887, -254)
	GridTiled:setAlpha(0.05)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local Backer = LUI.UIImage.new(0.5, 0.5, -58.5, 59.5, 0, 0, 285, 403)
	Backer:setRGB(0.09, 0.09, 0.09)
	Backer:setScale(2.5, 2.5)
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(0x15B163CA03FCE8B))
	Backer:setShaderVector(0, 40, 10, 0, 0)
	Backer:setShaderVector(1, 100, 100, 0, 0)
	Backer:setShaderVector(2, 0.1, 0.05, 0, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local Backer2 = LUI.UIImage.new(0.5, 0.5, -58.5, 59.5, 0, 0, 285, 403)
	Backer2:setRGB(0, 0, 0)
	Backer2:setAlpha(0.98)
	Backer2:setScale(2.5, 2.5)
	Backer2:setMaterial(LUI.UIImage.GetCachedMaterial(0x15B163CA03FCE8B))
	Backer2:setShaderVector(0, 40, 10, 0, 0)
	Backer2:setShaderVector(1, 100, 100, 0, 0)
	Backer2:setShaderVector(2, 0.1, 0.05, 0, 0)
	self:addElement(Backer2)
	self.Backer2 = Backer2
	local Art = LUI.UIImage.new(0.5, 0.5, -228, 228, 0, 0, 194, 690)
	Art:setImage(RegisterImage(0x6776621F1A63CDD))
	Art:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Art)
	self.Art = Art
	local DescriptionTint2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 190, 684)
	DescriptionTint2:setRGB(0.39, 0.39, 0.39)
	DescriptionTint2:setAlpha(0.04)
	self:addElement(DescriptionTint2)
	self.DescriptionTint2 = DescriptionTint2
	local BMContractProgress = CoD.BM_ContractProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 190, 590)
	BMContractProgress:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
	})
	BMContractProgress:linkToElementModel(BMContractProgress, "completed", true, function(model)
		f1_arg0:updateElementState(BMContractProgress, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	BMContractProgress:linkToElementModel(self, nil, false, function(model)
		BMContractProgress:setModel(model, f1_arg1)
	end)
	self:addElement(BMContractProgress)
	self.BMContractProgress = BMContractProgress
	local BMActiveContractItemRewardsContainer = CoD.BM_ActiveContractItemRewardsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -250, 250, 0, 0, 684, 812)
	BMActiveContractItemRewardsContainer:linkToElementModel(self, nil, false, function(model)
		BMActiveContractItemRewardsContainer:setModel(model, f1_arg1)
	end)
	self:addElement(BMActiveContractItemRewardsContainer)
	self.BMActiveContractItemRewardsContainer = BMActiveContractItemRewardsContainer
	local Name = LUI.UIText.new(0.14, 0.86, 6, -6, 0, 0, 568, 600)
	Name:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Name:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	Name:linkToElementModel(self, "displayName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Description = LUI.UIText.new(0.05, 0.95, 42, -42, 0, 0, 604, 620)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "description", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Description:setText(f7_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 1, -6, 6, 0, 0, 677, 697)
	ButtonTopLine9Slice:setAlpha(0.11)
	ButtonTopLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local TextBox2 = LUI.UIText.new(0, 0, 57, 600, 0, 0, 164, 182)
	TextBox2:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	TextBox2:setAlpha(0)
	TextBox2:setTTF("ttmussels_regular")
	TextBox2:setLetterSpacing(2)
	TextBox2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox2:subscribeToGlobalModel(f1_arg1, "Contracts", "dailyExpirationTime", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			TextBox2:setText(LocalizeIntoStringIfNotEmpty(0x69797CFAD4CAB0C, f8_local0))
		end
	end)
	self:addElement(TextBox2)
	self.TextBox2 = TextBox2
	local TopStripeWipe = LUI.UIImage.new(0, 0, 0, 696, 0, 0, 188, 204)
	TopStripeWipe:setImage(RegisterImage(0xA0F654633E4C64E))
	TopStripeWipe:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	TopStripeWipe:setShaderVector(0, 0, 0.79, 0, 0)
	TopStripeWipe:setShaderVector(1, 0, 0, 0, 0)
	TopStripeWipe:setShaderVector(2, 0, 1, 0, 0)
	TopStripeWipe:setShaderVector(3, 0, 0, 0, 0)
	TopStripeWipe:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(TopStripeWipe)
	self.TopStripeWipe = TopStripeWipe
	local TopStripeWipe4 = LUI.UIImage.new(0, 0, 0, 696, 0, 0, 188, 204)
	TopStripeWipe4:setImage(RegisterImage(0xA0F654633E4C64E))
	TopStripeWipe4:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	TopStripeWipe4:setShaderVector(0, 0, 0.79, 0, 0)
	TopStripeWipe4:setShaderVector(1, 0, 0, 0, 0)
	TopStripeWipe4:setShaderVector(2, 0, 1, 0, 0)
	TopStripeWipe4:setShaderVector(3, 0, 0, 0, 0)
	TopStripeWipe4:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(TopStripeWipe4)
	self.TopStripeWipe4 = TopStripeWipe4
	local TopStripeWipe2 = LUI.UIImage.new(0, 0, 0, 696, 0, 0, 812, 828)
	TopStripeWipe2:setImage(RegisterImage(0xA0F654633E4C64E))
	TopStripeWipe2:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	TopStripeWipe2:setShaderVector(0, 0, 0.79, 0, 0)
	TopStripeWipe2:setShaderVector(1, 0, 0, 0, 0)
	TopStripeWipe2:setShaderVector(2, 0, 1, 0, 0)
	TopStripeWipe2:setShaderVector(3, 0, 0, 0, 0)
	TopStripeWipe2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(TopStripeWipe2)
	self.TopStripeWipe2 = TopStripeWipe2
	local TopStripeWipe3 = LUI.UIImage.new(0, 0, 0, 696, 0, 0, 812, 828)
	TopStripeWipe3:setImage(RegisterImage(0xA0F654633E4C64E))
	TopStripeWipe3:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	TopStripeWipe3:setShaderVector(0, 0, 0.79, 0, 0)
	TopStripeWipe3:setShaderVector(1, 0, 0, 0, 0)
	TopStripeWipe3:setShaderVector(2, 0, 1, 0, 0)
	TopStripeWipe3:setShaderVector(3, 0, 0, 0, 0)
	TopStripeWipe3:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(TopStripeWipe3)
	self.TopStripeWipe3 = TopStripeWipe3
	local BMContractReveal = CoD.BM_ContractReveal.new(f1_arg0, f1_arg1, 0, 0, 1, 550, 0, 0, 190, 826)
	self:addElement(BMContractReveal)
	self.BMContractReveal = BMContractReveal
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
	})
	self:linkToElementModel(self, "completed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "Contracts.dailyContractsExpired", function(model)
		local f12_local0 = self
		if CoD.ModelUtility.IsModelValueTrue(f1_arg1, "Contracts.dailyContractsExpired") then
			PlayClipOnElement(self, {
				elementName = "BMContractReveal",
				clipName = "New",
			}, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_DailyContract.__resetProperties = function(f13_arg0)
	f13_arg0.Description:completeAnimation()
	f13_arg0.Name:completeAnimation()
	f13_arg0.BMActiveContractItemRewardsContainer:completeAnimation()
	f13_arg0.BMContractProgress:completeAnimation()
	f13_arg0.TextBox2:completeAnimation()
	f13_arg0.Backer2:completeAnimation()
	f13_arg0.Backer:completeAnimation()
	f13_arg0.CompletedBox:completeAnimation()
	f13_arg0.Description:setAlpha(1)
	f13_arg0.Name:setAlpha(1)
	f13_arg0.BMActiveContractItemRewardsContainer:setAlpha(1)
	f13_arg0.BMContractProgress:setAlpha(1)
	f13_arg0.TextBox2:setAlpha(0)
	f13_arg0.Backer2:setAlpha(0.98)
	f13_arg0.Backer:setAlpha(1)
	f13_arg0.CompletedBox:setAlpha(0)
end
CoD.BM_DailyContract.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.Backer:completeAnimation()
			f15_arg0.Backer:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Backer)
			f15_arg0.Backer2:completeAnimation()
			f15_arg0.Backer2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Backer2)
			f15_arg0.BMContractProgress:completeAnimation()
			f15_arg0.BMContractProgress:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BMContractProgress)
			f15_arg0.BMActiveContractItemRewardsContainer:completeAnimation()
			f15_arg0.BMActiveContractItemRewardsContainer:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.BMActiveContractItemRewardsContainer)
			f15_arg0.Name:completeAnimation()
			f15_arg0.Name:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Name)
			f15_arg0.Description:completeAnimation()
			f15_arg0.Description:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Description)
			f15_arg0.TextBox2:completeAnimation()
			f15_arg0.TextBox2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TextBox2)
		end,
	},
	Completed = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.CompletedBox:completeAnimation()
			f16_arg0.CompletedBox:setAlpha(0.02)
			f16_arg0.clipFinished(f16_arg0.CompletedBox)
			f16_arg0.TextBox2:completeAnimation()
			f16_arg0.TextBox2:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TextBox2)
		end,
	},
}
CoD.BM_DailyContract.__onClose = function(f17_arg0)
	f17_arg0.BMContractProgress:close()
	f17_arg0.BMActiveContractItemRewardsContainer:close()
	f17_arg0.Name:close()
	f17_arg0.Description:close()
	f17_arg0.TextBox2:close()
	f17_arg0.BMContractReveal:close()
end
