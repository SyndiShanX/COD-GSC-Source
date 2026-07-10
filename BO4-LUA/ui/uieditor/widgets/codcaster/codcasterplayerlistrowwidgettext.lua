require("x64:c5ca210e8cd6906")
CoD.CodCasterPlayerListRowWidgetText = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerListRowWidgetText.__defaultWidth = 165
CoD.CodCasterPlayerListRowWidgetText.__defaultHeight = 15
CoD.CodCasterPlayerListRowWidgetText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPlayerListRowWidgetText)
	self.id = "CodCasterPlayerListRowWidgetText"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GamerTag = CoD.CodCasterPlayerListRowWidgetTextInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 165, 0.5, 0.5, -7.5, 7.5)
	GamerTag:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	GamerTag:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GamerTag.Gamertag:setText(GetClientNameAndClanTag(f1_arg1, f2_local0))
		end
	end)
	self:addElement(GamerTag)
	self.GamerTag = GamerTag
	self:mergeStateConditions({
		{
			stateName = "IsSelfNextDead",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsSelfNext(element, f1_arg1) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
		{
			stateName = "IsSelf",
			condition = function(menu, element, event)
				return IsScoreboardPlayerSelf(element, f1_arg1)
			end,
		},
		{
			stateName = "PlayerDead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
			end,
		},
		{
			stateName = "IsSelfNext",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsSelfNext(element, f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.codcaster.nextClient"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.codcaster.nextClient",
		})
	end, false)
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["deadSpectator.playerIndex"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPlayerListRowWidgetText.__resetProperties = function(f12_arg0)
	f12_arg0.GamerTag:completeAnimation()
	f12_arg0.GamerTag:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	f12_arg0.GamerTag:setAlpha(1)
end
CoD.CodCasterPlayerListRowWidgetText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.GamerTag:completeAnimation()
			f13_arg0.GamerTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f13_arg0.GamerTag:setAlpha(0.6)
			f13_arg0.clipFinished(f13_arg0.GamerTag)
		end,
	},
	IsSelfNextDead = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.GamerTag:completeAnimation()
			f14_arg0.GamerTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f14_arg0.GamerTag:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.GamerTag)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.GamerTag:completeAnimation()
			f15_arg0.GamerTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f15_arg0.GamerTag:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.GamerTag)
		end,
	},
	IsSelf = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.GamerTag:completeAnimation()
			f16_arg0.GamerTag:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f16_arg0.clipFinished(f16_arg0.GamerTag)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.GamerTag:completeAnimation()
			f17_arg0.GamerTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f17_arg0.clipFinished(f17_arg0.GamerTag)
		end,
	},
	PlayerDead = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.GamerTag:completeAnimation()
			f18_arg0.GamerTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f18_arg0.GamerTag:setAlpha(0.6)
			f18_arg0.clipFinished(f18_arg0.GamerTag)
		end,
	},
	IsSelfNext = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.GamerTag:completeAnimation()
			f19_arg0.GamerTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f19_arg0.GamerTag:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.GamerTag)
		end,
		Focus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.GamerTag:completeAnimation()
			f20_arg0.GamerTag:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
			f20_arg0.GamerTag:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.GamerTag)
		end,
	},
}
CoD.CodCasterPlayerListRowWidgetText.__onClose = function(f21_arg0)
	f21_arg0.GamerTag:close()
end
