CoD.WarzoneWingsuitOverlay = InheritFrom(LUI.UIElement)
CoD.WarzoneWingsuitOverlay.__defaultWidth = 1920
CoD.WarzoneWingsuitOverlay.__defaultHeight = 1080
CoD.WarzoneWingsuitOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneWingsuitOverlay)
	self.id = "WarzoneWingsuitOverlay"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local altitudeValue = LUI.UIText.new(0.5, 0.5, -240, -40, 0, 0, 167, 204)
	altitudeValue:setTTF("default")
	altitudeValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	altitudeValue:setBackingType(2)
	altitudeValue:setBackingColor(0, 0, 0)
	altitudeValue:setBackingAlpha(0.4)
	altitudeValue:setBackingXPadding(5)
	altitudeValue:subscribeToGlobalModel(f1_arg1, "HUDItems", "altitude", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			altitudeValue:setText(FormatNumberAsString(0, f2_local0))
		end
	end)
	self:addElement(altitudeValue)
	self.altitudeValue = altitudeValue
	local altitudeTitle = LUI.UIText.new(0.5, 0.5, -240, -40, 0, 0, 130, 167)
	altitudeTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BD23A68618982EF"))
	altitudeTitle:setTTF("default")
	altitudeTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	altitudeTitle:setBackingType(2)
	altitudeTitle:setBackingColor(0, 0, 0)
	altitudeTitle:setBackingAlpha(0.4)
	altitudeTitle:setBackingXPadding(5)
	self:addElement(altitudeTitle)
	self.altitudeTitle = altitudeTitle
	local speedTitle = LUI.UIText.new(0.5, 0.5, 40, 240, 0, 0, 130, 167)
	speedTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_43755C926654C027"))
	speedTitle:setTTF("default")
	speedTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	speedTitle:setBackingType(2)
	speedTitle:setBackingColor(0, 0, 0)
	speedTitle:setBackingAlpha(0.4)
	speedTitle:setBackingXPadding(5)
	self:addElement(speedTitle)
	self.speedTitle = speedTitle
	local speedValue = LUI.UIText.new(0.5, 0.5, 40, 240, 0, 0, 167, 204)
	speedValue:setTTF("default")
	speedValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	speedValue:setBackingType(2)
	speedValue:setBackingColor(0, 0, 0)
	speedValue:setBackingAlpha(0.4)
	speedValue:setBackingXPadding(5)
	speedValue:subscribeToGlobalModel(f1_arg1, "HUDItems", "speed", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			speedValue:setText(FormatNumberAsString(0, f3_local0))
		end
	end)
	self:addElement(speedValue)
	self.speedValue = speedValue
	self:mergeStateConditions({
		{
			stateName = "TEMPHideBecauseThereIsntADesign",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsVisibilityBitSet(f1_arg1, Enum[@"uivisibilitybit"][@"hash_76A5D7E9BC6BF325"])
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_76A5D7E9BC6BF325"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"hash_76A5D7E9BC6BF325"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneWingsuitOverlay.__resetProperties = function(f7_arg0)
	f7_arg0.speedValue:completeAnimation()
	f7_arg0.speedTitle:completeAnimation()
	f7_arg0.altitudeTitle:completeAnimation()
	f7_arg0.altitudeValue:completeAnimation()
	f7_arg0.speedValue:setAlpha(1)
	f7_arg0.speedTitle:setAlpha(1)
	f7_arg0.altitudeTitle:setAlpha(1)
	f7_arg0.altitudeValue:setAlpha(1)
end
CoD.WarzoneWingsuitOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	TEMPHideBecauseThereIsntADesign = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.altitudeValue:completeAnimation()
			f9_arg0.altitudeValue:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.altitudeValue)
			f9_arg0.altitudeTitle:completeAnimation()
			f9_arg0.altitudeTitle:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.altitudeTitle)
			f9_arg0.speedTitle:completeAnimation()
			f9_arg0.speedTitle:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.speedTitle)
			f9_arg0.speedValue:completeAnimation()
			f9_arg0.speedValue:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.speedValue)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.altitudeValue:completeAnimation()
			f10_arg0.altitudeValue:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.altitudeValue)
			f10_arg0.altitudeTitle:completeAnimation()
			f10_arg0.altitudeTitle:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.altitudeTitle)
			f10_arg0.speedTitle:completeAnimation()
			f10_arg0.speedTitle:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.speedTitle)
			f10_arg0.speedValue:completeAnimation()
			f10_arg0.speedValue:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.speedValue)
		end,
	},
}
CoD.WarzoneWingsuitOverlay.__onClose = function(f11_arg0)
	f11_arg0.altitudeValue:close()
	f11_arg0.speedValue:close()
end
