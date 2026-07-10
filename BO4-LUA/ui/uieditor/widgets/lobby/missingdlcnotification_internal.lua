require("x64:bd993eb9f8429b0")
CoD.MissingDLCNotification_Internal = InheritFrom(LUI.UIElement)
CoD.MissingDLCNotification_Internal.__defaultWidth = 540
CoD.MissingDLCNotification_Internal.__defaultHeight = 50
CoD.MissingDLCNotification_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MissingDLCNotification_Internal)
	self.id = "MissingDLCNotification_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 9, 41, 0, 0, 9, 41)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local Description = CoD.MissingDLCNotification_TextInternal.new(f1_arg0, f1_arg1, 0, 1, 48, -8, 0, 0, 18, 32)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(Description)
	self.Description = Description
	self:mergeStateConditions({
		{
			stateName = "SelfWarning",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.SocialUtility.IsSelfMissingRequiredDLCForElementPlaylist(f1_arg1, element) then
					f2_local0 = CoD.SocialUtility.IsSelfMissingUsedDLCForElementPlaylist(f1_arg1, element)
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "SelfError",
			condition = function(menu, element, event)
				return CoD.SocialUtility.IsSelfMissingRequiredDLCForElementPlaylist(f1_arg1, element)
			end,
		},
		{
			stateName = "HostWarning",
			condition = function(menu, element, event)
				return CoD.SocialUtility.IsPartyMissingUsedDLCForElementPlaylist(f1_arg1, element) and not CoD.SocialUtility.IsPartyMissingRequiredDLCForElementPlaylist(f1_arg1, element)
			end,
		},
		{
			stateName = "HostError",
			condition = function(menu, element, event)
				return CoD.SocialUtility.IsPartyMissingRequiredDLCForElementPlaylist(f1_arg1, element)
			end,
		},
	})
	self:linkToElementModel(self, "playlist", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "playlist",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5["privateClient.count"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "privateClient.count",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MissingDLCNotification_Internal.__resetProperties = function(f8_arg0)
	f8_arg0.buttonPromptImage:completeAnimation()
	f8_arg0.Description:completeAnimation()
	f8_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f8_arg0.buttonPromptImage:setAlpha(1)
	f8_arg0.Description:setAlpha(1)
	f8_arg0.Description.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A201C5CBA235AA1"))
end
CoD.MissingDLCNotification_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.buttonPromptImage:completeAnimation()
			f9_arg0.buttonPromptImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonPromptImage)
			f9_arg0.Description:completeAnimation()
			f9_arg0.Description:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Description)
		end,
	},
	SelfWarning = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.buttonPromptImage:completeAnimation()
			f10_arg0.buttonPromptImage:setRGB(1, 0.92, 0)
			f10_arg0.buttonPromptImage:setAlpha(1)
			f10_arg0.buttonPromptImage:setImage(RegisterImage(@"uie_warning_triangle"))
			f10_arg0.clipFinished(f10_arg0.buttonPromptImage)
			f10_arg0.Description:completeAnimation()
			f10_arg0.Description.label:completeAnimation()
			f10_arg0.Description.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_14F58D4AE79E74EA"))
			f10_arg0.clipFinished(f10_arg0.Description)
		end,
	},
	SelfError = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.buttonPromptImage:completeAnimation()
			f11_arg0.buttonPromptImage:setRGB(1, 0, 0)
			f11_arg0.buttonPromptImage:setAlpha(1)
			f11_arg0.buttonPromptImage:setImage(RegisterImage(@"uie_warning_triangle"))
			f11_arg0.clipFinished(f11_arg0.buttonPromptImage)
			f11_arg0.Description:completeAnimation()
			f11_arg0.Description.label:completeAnimation()
			f11_arg0.Description.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3443A3EED032BF80"))
			f11_arg0.clipFinished(f11_arg0.Description)
		end,
	},
	HostWarning = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.buttonPromptImage:completeAnimation()
			f12_arg0.buttonPromptImage:setRGB(1, 0.92, 0)
			f12_arg0.buttonPromptImage:setAlpha(1)
			f12_arg0.buttonPromptImage:setImage(RegisterImage(@"uie_warning_triangle"))
			f12_arg0.clipFinished(f12_arg0.buttonPromptImage)
			f12_arg0.Description:completeAnimation()
			f12_arg0.Description.label:completeAnimation()
			f12_arg0.Description.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D4EDB8B4FEE365F"))
			f12_arg0.clipFinished(f12_arg0.Description)
		end,
	},
	HostError = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.buttonPromptImage:completeAnimation()
			f13_arg0.buttonPromptImage:setRGB(1, 0, 0)
			f13_arg0.buttonPromptImage:setAlpha(1)
			f13_arg0.buttonPromptImage:setImage(RegisterImage(@"uie_warning_triangle"))
			f13_arg0.clipFinished(f13_arg0.buttonPromptImage)
			f13_arg0.Description:completeAnimation()
			f13_arg0.Description.label:completeAnimation()
			f13_arg0.Description:setAlpha(1)
			f13_arg0.Description.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A201C5CBA235AA1"))
			f13_arg0.clipFinished(f13_arg0.Description)
		end,
	},
}
CoD.MissingDLCNotification_Internal.__onClose = function(f14_arg0)
	f14_arg0.Description:close()
end
