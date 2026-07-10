require("x64:4cee61320cd1f1b")
CoD.StartMenu_CurrencyCounts = InheritFrom(LUI.UIElement)
CoD.StartMenu_CurrencyCounts.__defaultWidth = 310
CoD.StartMenu_CurrencyCounts.__defaultHeight = 80
CoD.StartMenu_CurrencyCounts.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_CurrencyCounts)
	self.id = "StartMenu_CurrencyCounts"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_arg0, f1_arg1, 0, 0, 110, 214, 0, 0, 0, 80)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "codPoints", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f2_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	local vial = LUI.UIImage.new(0, 0, 0, 38, 0.5, 0.5, -21.5, 16.5)
	vial:setImage(RegisterImage(0x5FBFE58B2BB38AC))
	self:addElement(vial)
	self.vial = vial
	local vialCount = LUI.UIText.new(0, 0, 41, 110, 0.5, 0.5, -16.5, 16.5)
	vialCount:setText(SetValueIfNumberEqualTo(-1, "-", 0))
	vialCount:setTTF("default")
	vialCount:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(vialCount)
	self.vialCount = vialCount
	self:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsLootReady(f1_arg1) and IsCommerceEnabledOnPC()
			end,
		},
		{
			stateName = "ShownOnlyCODPoints",
			condition = function(menu, element, event)
				return IsLootReady(f1_arg1) and AreCodPointsEnabled(f1_arg1)
			end,
		},
		{
			stateName = "ShownOnlyVials",
			condition = function(menu, element, event)
				return IsLootReady(f1_arg1) and not AreCodPointsEnabled(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["LootStreamProgress.currentLootXP"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LootStreamProgress.currentLootXP",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_CurrencyCounts.__resetProperties = function(f8_arg0)
	f8_arg0.vial:completeAnimation()
	f8_arg0.vialCount:completeAnimation()
	f8_arg0.StartMenuCODpoints:completeAnimation()
	f8_arg0.vial:setLeftRight(0, 0, 0, 38)
	f8_arg0.vial:setAlpha(1)
	f8_arg0.vialCount:setLeftRight(0, 0, 41, 110)
	f8_arg0.vialCount:setAlpha(1)
	f8_arg0.StartMenuCODpoints:setAlpha(1)
end
CoD.StartMenu_CurrencyCounts.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.StartMenuCODpoints:completeAnimation()
			f9_arg0.StartMenuCODpoints:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.StartMenuCODpoints)
			f9_arg0.vial:completeAnimation()
			f9_arg0.vial:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.vial)
			f9_arg0.vialCount:completeAnimation()
			f9_arg0.vialCount:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.vialCount)
		end,
	},
	Shown = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	ShownOnlyCODPoints = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.vial:completeAnimation()
			f11_arg0.vial:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.vial)
			f11_arg0.vialCount:completeAnimation()
			f11_arg0.vialCount:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.vialCount)
		end,
	},
	ShownOnlyVials = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.StartMenuCODpoints:completeAnimation()
			f12_arg0.StartMenuCODpoints:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.StartMenuCODpoints)
			f12_arg0.vial:completeAnimation()
			f12_arg0.vial:setLeftRight(0, 0, 200, 238)
			f12_arg0.clipFinished(f12_arg0.vial)
			f12_arg0.vialCount:completeAnimation()
			f12_arg0.vialCount:setLeftRight(0, 0, 241, 310)
			f12_arg0.clipFinished(f12_arg0.vialCount)
		end,
	},
}
CoD.StartMenu_CurrencyCounts.__onClose = function(f13_arg0)
	f13_arg0.StartMenuCODpoints:close()
end
