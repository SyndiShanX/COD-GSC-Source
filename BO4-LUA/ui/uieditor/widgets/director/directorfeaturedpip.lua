require("x64:76fa323de4745ba")
CoD.DirectorFeaturedPip = InheritFrom(LUI.UIElement)
CoD.DirectorFeaturedPip.__defaultWidth = 54
CoD.DirectorFeaturedPip.__defaultHeight = 22
CoD.DirectorFeaturedPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFeaturedPip)
	self.id = "DirectorFeaturedPip"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FeaturedPipCurrentBracket = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 22)
	FeaturedPipCurrentBracket:setAlpha(0)
	FeaturedPipCurrentBracket:setImage(RegisterImage(0xA2CE59E7B7605F))
	FeaturedPipCurrentBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FeaturedPipCurrentBracket)
	self.FeaturedPipCurrentBracket = FeaturedPipCurrentBracket
	local FeaturedPipEmpty = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 22)
	FeaturedPipEmpty:setAlpha(0.25)
	FeaturedPipEmpty:setImage(RegisterImage(0x4C042BC6C9D43A9))
	self:addElement(FeaturedPipEmpty)
	self.FeaturedPipEmpty = FeaturedPipEmpty
	local FeaturedPipCurrent = LUI.UIImage.new(0, 0, 0, 54, 0, 0, 0, 22)
	FeaturedPipCurrent:setRGB(0.93, 0.81, 0.03)
	FeaturedPipCurrent:setAlpha(0)
	FeaturedPipCurrent:setImage(RegisterImage(0x9D0184504FDF2CD))
	FeaturedPipCurrent:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	FeaturedPipCurrent:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FeaturedPipCurrent)
	self.FeaturedPipCurrent = FeaturedPipCurrent
	local FeaturedPipGlow = LUI.UIImage.new(0, 0, 4, 50, 0, 0, 4.5, 17.5)
	FeaturedPipGlow:setRGB(0.89, 0.45, 0.04)
	FeaturedPipGlow:setAlpha(0)
	FeaturedPipGlow:setImage(RegisterImage(0x69CF640F22433BA))
	FeaturedPipGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FeaturedPipGlow:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(FeaturedPipGlow)
	self.FeaturedPipGlow = FeaturedPipGlow
	local FeaturedPipGlow2 = LUI.UIImage.new(0, 0, 12, 42, 0, 0, 8.5, 13.5)
	FeaturedPipGlow2:setAlpha(0)
	FeaturedPipGlow2:setImage(RegisterImage(0x69CF640F22433BA))
	FeaturedPipGlow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	FeaturedPipGlow2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FeaturedPipGlow2)
	self.FeaturedPipGlow2 = FeaturedPipGlow2
	local Image = LUI.UIImage.new(0, 0, 4, 50, 0, 0, 4.5, 17.5)
	Image:setRGB(0.89, 0.45, 0.04)
	Image:setAlpha(0)
	Image:setImage(RegisterImage(0x69CF640F22433BA))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Image:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local RestrictedItemWarning = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -15, 15, 0, 0, -20, 5)
	RestrictedItemWarning:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isRestricted")
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	local f1_local8 = RestrictedItemWarning
	local f1_local9 = RestrictedItemWarning.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(RestrictedItemWarning, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RestrictedItemWarning:linkToElementModel(RestrictedItemWarning, "isRestricted", true, function(model)
		f1_arg0:updateElementState(RestrictedItemWarning, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isRestricted",
		})
	end)
	self:addElement(RestrictedItemWarning)
	self.RestrictedItemWarning = RestrictedItemWarning
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorFeaturedPip.__resetProperties = function(f5_arg0)
	f5_arg0.FeaturedPipEmpty:completeAnimation()
	f5_arg0.FeaturedPipCurrent:completeAnimation()
	f5_arg0.FeaturedPipCurrentBracket:completeAnimation()
	f5_arg0.FeaturedPipGlow:completeAnimation()
	f5_arg0.FeaturedPipGlow2:completeAnimation()
	f5_arg0.FeaturedPipEmpty:setRGB(1, 1, 1)
	f5_arg0.FeaturedPipEmpty:setAlpha(0.25)
	f5_arg0.FeaturedPipCurrent:setAlpha(0)
	f5_arg0.FeaturedPipCurrentBracket:setAlpha(0)
	f5_arg0.FeaturedPipGlow:setAlpha(0)
	f5_arg0.FeaturedPipGlow2:setRGB(1, 1, 1)
	f5_arg0.FeaturedPipGlow2:setAlpha(0)
end
CoD.DirectorFeaturedPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.FeaturedPipEmpty:completeAnimation()
			f6_arg0.FeaturedPipEmpty:setRGB(1, 1, 1)
			f6_arg0.clipFinished(f6_arg0.FeaturedPipEmpty)
		end,
		Active = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(5)
			f7_arg0.FeaturedPipCurrentBracket:completeAnimation()
			f7_arg0.FeaturedPipCurrentBracket:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.FeaturedPipCurrentBracket)
			f7_arg0.FeaturedPipEmpty:completeAnimation()
			f7_arg0.FeaturedPipEmpty:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FeaturedPipEmpty)
			f7_arg0.FeaturedPipCurrent:completeAnimation()
			f7_arg0.FeaturedPipCurrent:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FeaturedPipCurrent)
			f7_arg0.FeaturedPipGlow:completeAnimation()
			f7_arg0.FeaturedPipGlow:setAlpha(0.1)
			f7_arg0.clipFinished(f7_arg0.FeaturedPipGlow)
			f7_arg0.FeaturedPipGlow2:completeAnimation()
			f7_arg0.FeaturedPipGlow2:setRGB(0.95, 0.93, 0.35)
			f7_arg0.FeaturedPipGlow2:setAlpha(0.5)
			f7_arg0.clipFinished(f7_arg0.FeaturedPipGlow2)
		end,
	},
}
CoD.DirectorFeaturedPip.__onClose = function(f8_arg0)
	f8_arg0.RestrictedItemWarning:close()
end
