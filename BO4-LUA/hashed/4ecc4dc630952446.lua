CoD.Prestige_LevelRewardsHeader = InheritFrom(LUI.UIElement)
CoD.Prestige_LevelRewardsHeader.__defaultWidth = 128
CoD.Prestige_LevelRewardsHeader.__defaultHeight = 37
CoD.Prestige_LevelRewardsHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_LevelRewardsHeader)
	self.id = "Prestige_LevelRewardsHeader"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeaderBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HeaderBackground:setRGB(0.14, 0.14, 0.14)
	self:addElement(HeaderBackground)
	self.HeaderBackground = HeaderBackground
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.09, 1.09, -3, -3)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local HeaderStripeBot = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 34, 37)
	HeaderStripeBot:setAlpha(0)
	HeaderStripeBot:setImage(RegisterImage(0xC7A051F5EFC70E5))
	HeaderStripeBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	HeaderStripeBot:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripeBot:setupNineSliceShader(22, 4)
	self:addElement(HeaderStripeBot)
	self.HeaderStripeBot = HeaderStripeBot
	local HeaderStripeTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 3)
	HeaderStripeTop:setImage(RegisterImage(0xC7A051F5EFC70E5))
	HeaderStripeTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	HeaderStripeTop:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripeTop:setupNineSliceShader(22, 4)
	self:addElement(HeaderStripeTop)
	self.HeaderStripeTop = HeaderStripeTop
	self:mergeStateConditions({
		{
			stateName = "LevelAchieved",
			condition = function(menu, element, event)
				local f2_local0
				if not IsMaxPrestigeLevel(f1_arg1) then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "rankAchieved")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "MasterPrestige",
			condition = function(menu, element, event)
				return IsMaxPrestigeLevel(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "rankAchieved", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rankAchieved",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_LevelRewardsHeader.__resetProperties = function(f5_arg0)
	f5_arg0.HeaderBackground:completeAnimation()
	f5_arg0.HeaderStripeTop:completeAnimation()
	f5_arg0.HeaderStripeBot:completeAnimation()
	f5_arg0.HeaderBackground:setRGB(0.14, 0.14, 0.14)
	f5_arg0.HeaderStripeTop:setAlpha(1)
	f5_arg0.HeaderStripeBot:setAlpha(0)
end
CoD.Prestige_LevelRewardsHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.HeaderBackground:completeAnimation()
			f6_arg0.HeaderBackground:setRGB(0.14, 0.14, 0.14)
			f6_arg0.clipFinished(f6_arg0.HeaderBackground)
			f6_arg0.HeaderStripeTop:completeAnimation()
			f6_arg0.HeaderStripeTop:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.HeaderStripeTop)
		end,
	},
	LevelAchieved = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.HeaderBackground:completeAnimation()
			f7_arg0.HeaderBackground:setRGB(0.31, 0.31, 0.31)
			f7_arg0.clipFinished(f7_arg0.HeaderBackground)
			f7_arg0.HeaderStripeTop:completeAnimation()
			f7_arg0.HeaderStripeTop:setAlpha(0.6)
			f7_arg0.clipFinished(f7_arg0.HeaderStripeTop)
		end,
	},
	MasterPrestige = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.HeaderBackground:completeAnimation()
			f8_arg0.HeaderBackground:setRGB(0.1, 0.1, 0.1)
			f8_arg0.clipFinished(f8_arg0.HeaderBackground)
			f8_arg0.HeaderStripeBot:completeAnimation()
			f8_arg0.HeaderStripeBot:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.HeaderStripeBot)
		end,
	},
}
