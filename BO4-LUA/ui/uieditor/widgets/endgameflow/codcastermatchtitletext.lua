require("x64:e6cc0e76ed868e0")
CoD.CODCasterMatchTitleText = InheritFrom(LUI.UIElement)
CoD.CODCasterMatchTitleText.__defaultWidth = 856
CoD.CODCasterMatchTitleText.__defaultHeight = 64
CoD.CODCasterMatchTitleText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CODCasterMatchTitleText)
	self.id = "CODCasterMatchTitleText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local killcamTitleCODCaster = LUI.UIText.new(0, 0, 0, 856, 0, 0, 0, 64)
	killcamTitleCODCaster:setAlpha(0)
	killcamTitleCODCaster:setScale(1.02, 1.02)
	killcamTitleCODCaster:setText(LocalizeToUpperString(0x4EFA5F5678040E7))
	killcamTitleCODCaster:setTTF("ttmussels_regular")
	killcamTitleCODCaster:setLetterSpacing(14)
	killcamTitleCODCaster:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	killcamTitleCODCaster:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			killcamTitleCODCaster:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(killcamTitleCODCaster)
	self.killcamTitleCODCaster = killcamTitleCODCaster
	local killcamTitle = LUI.UIText.new(0, 0, 0, 856, 0, 0, 0, 64)
	killcamTitle:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	killcamTitle:setAlpha(0)
	killcamTitle:setScale(1.02, 1.02)
	killcamTitle:setText(LocalizeToUpperString(0x4EFA5F5678040E7))
	killcamTitle:setTTF("ttmussels_regular")
	killcamTitle:setLetterSpacing(14)
	killcamTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(killcamTitle)
	self.killcamTitle = killcamTitle
	self:mergeStateConditions({
		{
			stateName = "CODCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["factions.isCoDCaster"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CODCasterMatchTitleText.__resetProperties = function(f5_arg0)
	f5_arg0.killcamTitle:completeAnimation()
	f5_arg0.killcamTitleCODCaster:completeAnimation()
	f5_arg0.killcamTitle:setAlpha(0)
	f5_arg0.killcamTitleCODCaster:setAlpha(0)
end
CoD.CODCasterMatchTitleText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.killcamTitleCODCaster:completeAnimation()
			f6_arg0.killcamTitleCODCaster:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.killcamTitleCODCaster)
			f6_arg0.killcamTitle:completeAnimation()
			f6_arg0.killcamTitle:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.killcamTitle)
		end,
	},
	CODCaster = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.killcamTitleCODCaster:completeAnimation()
			f7_arg0.killcamTitleCODCaster:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.killcamTitleCODCaster)
			f7_arg0.killcamTitle:completeAnimation()
			f7_arg0.killcamTitle:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.killcamTitle)
		end,
	},
}
CoD.CODCasterMatchTitleText.__onClose = function(f8_arg0)
	f8_arg0.killcamTitleCODCaster:close()
end
