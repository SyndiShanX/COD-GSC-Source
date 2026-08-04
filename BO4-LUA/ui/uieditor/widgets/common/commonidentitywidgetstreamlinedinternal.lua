require("ui/uieditor/widgets/common/commonidentitymembernamestreamlined")
require("ui/uieditor/widgets/common/commonplasmacurrency")
require("x64:d516fec83a97b65")
require("ui/uieditor/widgets/startmenu/startmenu_codpoints")
CoD.CommonIdentityWidgetStreamlinedInternal = InheritFrom(LUI.UIElement)
CoD.CommonIdentityWidgetStreamlinedInternal.__defaultWidth = 530
CoD.CommonIdentityWidgetStreamlinedInternal.__defaultHeight = 40
CoD.CommonIdentityWidgetStreamlinedInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonIdentityWidgetStreamlinedInternal)
	self.id = "CommonIdentityWidgetStreamlinedInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LootCaseCount = CoD.IdentityLootCaseCount.new(f1_arg0, f1_arg1, 0, 0, 82, 186, 0, 0, 2, 40)
	LootCaseCount:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootCaseCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LootCaseCount.CaseCount:setText(SetValueIfNumberEqualTo(-1, "-", f2_local0))
		end
	end)
	LootCaseCount:subscribeToGlobalModel(f1_arg1, "ReservesItemCounts", "lootCaseCount", function(model)
		CoD.BlackMarketUtility.UpdateLootCaseCountWidget(LootCaseCount, f1_arg1, model:get())
	end)
	self:addElement(LootCaseCount)
	self.LootCaseCount = LootCaseCount
	local vialCount = CoD.CommonPlasmaCurrency.new(f1_arg0, f1_arg1, 0, 0, 82, 186, 0, 0, 2, 40)
	vialCount:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "plasma", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			vialCount.vialCount:setText(SetValueIfNumberEqualTo(-1, "-", f4_local0))
		end
	end)
	self:addElement(vialCount)
	self.vialCount = vialCount
	local StartMenuCODpoints = CoD.StartMenu_CODpoints.new(f1_arg0, f1_arg1, 0, 0, 196, 300, 0, 0, -20, 60)
	StartMenuCODpoints:subscribeToGlobalModel(f1_arg1, "LootStreamProgress", "codPoints", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			StartMenuCODpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f5_local0))
		end
	end)
	self:addElement(StartMenuCODpoints)
	self.StartMenuCODpoints = StartMenuCODpoints
	local membername = CoD.CommonIdentityMemberNameStreamlined.new(f1_arg0, f1_arg1, 0, 0, 310, 530, 0, 0, 9.5, 30.5)
	membername:linkToElementModel(self, nil, false, function(model)
		membername:setModel(model, f1_arg1)
	end)
	self:addElement(membername)
	self.membername = membername
	self:mergeStateConditions({
		{
			stateName = "ShowPlasma",
			condition = function(menu, element, event)
				local f7_local0 = IsZombies()
				if f7_local0 then
					if not IsMainModeInvalid() then
						f7_local0 = IsLobbyNetworkModeLive()
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine.GetGlobalModel()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetGlobalModel()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyMainMode"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		if IsPC() and IsInGame() then
			HideWidget(self.membername)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	f1_local6 = StartMenuCODpoints
	if IsPC() and IsGameTrial() then
		ReplaceElementWithFake(self, "StartMenuCODpoints")
	end
	return self
end
CoD.CommonIdentityWidgetStreamlinedInternal.__resetProperties = function(f11_arg0)
	f11_arg0.vialCount:completeAnimation()
	f11_arg0.vialCount:setAlpha(1)
end
CoD.CommonIdentityWidgetStreamlinedInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.vialCount:completeAnimation()
			f12_arg0.vialCount:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.vialCount)
		end,
	},
	ShowPlasma = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CommonIdentityWidgetStreamlinedInternal.__onClose = function(f14_arg0)
	f14_arg0.LootCaseCount:close()
	f14_arg0.vialCount:close()
	f14_arg0.StartMenuCODpoints:close()
	f14_arg0.membername:close()
end
