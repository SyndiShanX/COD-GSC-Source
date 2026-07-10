require("x64:1394ae5e9cdcb54")
require("x64:673b9bfc92c298b")
CoD.InspectionPlayerList = InheritFrom(LUI.UIElement)
CoD.InspectionPlayerList.__defaultWidth = 1920
CoD.InspectionPlayerList.__defaultHeight = 70
CoD.InspectionPlayerList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 30, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.InspectionPlayerList)
	self.id = "InspectionPlayerList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0.5, 0.5, -665.5, -465.5, 0.5, 0.5, -17, 17)
	LB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BDCD5292604F434"))
	LB.GamepadPrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(LB)
	self.LB = LB
	local PartyList = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	PartyList:setLeftRight(0, 0, 524.5, 1395.5)
	PartyList:setTopBottom(0, 0, 0, 68)
	PartyList:setWidgetType(CoD.DirectorLobbyMember)
	PartyList:setHorizontalCount(12)
	PartyList:setSpacing(5)
	PartyList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PartyList:setBackingWidgetYPadding(-7)
	PartyList:setDataSource("DirectorLobbyListAll")
	PartyList:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		UpdatePlayerInspection(self, element, f1_arg1)
		SetSelectedFriendXUID(self, element, f1_arg1)
		UpdatePlayerInspectionWeapon(self, element, f1_arg1)
		return f2_local0
	end)
	self:addElement(PartyList)
	self.PartyList = PartyList
	local RB = CoD.BumperButtonWithKeyMouseText.new(f1_arg0, f1_arg1, 0, 0, 1425.5, 1625.5, 0.5, 0.5, -17, 17)
	RB.GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5BFED5292621DA9A"))
	self:addElement(RB)
	self.RB = RB
	self:mergeStateConditions({
		{
			stateName = "HiddenArena",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.GridAndListUtility.ListElementHasAtLeastNumElements(self.PartyList, 2) and not CoD.ArenaUtility.ArenaMatchSet(self) then
					f3_local0 = IsArenaMode()
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.GridAndListUtility.ListElementHasAtLeastNumElements(self.PartyList, 2)
			end,
		},
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				local f5_local0
				if not CoD.ArenaUtility.ArenaMatchSet(self) then
					f5_local0 = IsArenaMode()
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.publicLobby.stage"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsSelfInState(self, "HiddenArena") then
			SetListDataSource(self.PartyList, "DirectorPartyList")
			UpdateSelfState(self, controller)
		elseif IsSelfInState(self, "Hidden") then
			SetListDataSource(self.PartyList, "DirectorLobbyListAll")
			UpdateSelfState(self, controller)
		elseif IsSelfInState(self, "Arena") then
			SetListDataSource(self.PartyList, "DirectorPartyList")
			UpdateSelfState(self, controller)
		elseif IsSelfInState(self, "DefaultState") then
			SetListDataSource(self.PartyList, "DirectorLobbyListAll")
			UpdateSelfState(self, controller)
		end
	end)
	PartyList.id = "PartyList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	EnableNavigation(self, "PartyList")
	CoD.GridAndListUtility.AddBumperNavigation(f1_arg0, PartyList, f1_arg1)
	return self
end
CoD.InspectionPlayerList.__resetProperties = function(f10_arg0)
	f10_arg0.RB:completeAnimation()
	f10_arg0.PartyList:completeAnimation()
	f10_arg0.LB:completeAnimation()
	f10_arg0.RB:setAlpha(1)
	f10_arg0.PartyList:setAlpha(1)
	f10_arg0.LB:setAlpha(1)
end
CoD.InspectionPlayerList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	HiddenArena = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.LB:completeAnimation()
			f12_arg0.LB:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.LB)
			f12_arg0.PartyList:completeAnimation()
			f12_arg0.PartyList:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PartyList)
			f12_arg0.RB:completeAnimation()
			f12_arg0.RB:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RB)
		end,
	},
	Hidden = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.LB:completeAnimation()
			f13_arg0.LB:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LB)
			f13_arg0.PartyList:completeAnimation()
			f13_arg0.PartyList:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PartyList)
			f13_arg0.RB:completeAnimation()
			f13_arg0.RB:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RB)
		end,
	},
	Arena = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.InspectionPlayerList.__onClose = function(f15_arg0)
	f15_arg0.LB:close()
	f15_arg0.PartyList:close()
	f15_arg0.RB:close()
end
