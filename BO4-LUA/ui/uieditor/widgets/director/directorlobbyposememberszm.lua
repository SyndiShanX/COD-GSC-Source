require("x64:6d20cd5e7e2072b")
require("x64:d4ed3fd8d1fcc4a")
require("x64:310a25e996d432a")
CoD.DirectorLobbyPoseMembersZM = InheritFrom(LUI.UIElement)
CoD.DirectorLobbyPoseMembersZM.__defaultWidth = 1920
CoD.DirectorLobbyPoseMembersZM.__defaultHeight = 1080
CoD.DirectorLobbyPoseMembersZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.DirectorUtility.HideLoadoutPreview(f1_arg1)
	self:setClass(CoD.DirectorLobbyPoseMembersZM)
	self.id = "DirectorLobbyPoseMembersZM"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCharacterButtonZM1 = CoD.DirectorCharacterButtonZM.new(f1_arg0, f1_arg1, 0.5, 0.5, -858, -586, 1, 1, -760, -381)
	DirectorCharacterButtonZM1:subscribeToGlobalModel(f1_arg1, "DirectorCharacterButtonZMList", "1", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DirectorCharacterButtonZM1:setModel(f2_local0, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DirectorCharacterButtonZM1, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		UpdateElementState(self, "ZMLoadoutPreviewFrame", controller)
	end)
	self:addElement(DirectorCharacterButtonZM1)
	self.DirectorCharacterButtonZM1 = DirectorCharacterButtonZM1
	local DirectorCharacterButtonZM2 = CoD.DirectorCharacterButtonZM.new(f1_arg0, f1_arg1, 0.5, 0.5, -542, -270, 1, 1, -760, -381)
	DirectorCharacterButtonZM2:subscribeToGlobalModel(f1_arg1, "DirectorCharacterButtonZMList", "2", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorCharacterButtonZM2:setModel(f4_local0, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DirectorCharacterButtonZM2, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		UpdateElementState(self, "ZMLoadoutPreviewFrame", controller)
	end)
	self:addElement(DirectorCharacterButtonZM2)
	self.DirectorCharacterButtonZM2 = DirectorCharacterButtonZM2
	local DirectorCharacterButtonZM3 = CoD.DirectorCharacterButtonZM.new(f1_arg0, f1_arg1, 0.5, 0.5, -226, 46, 1, 1, -760, -381)
	DirectorCharacterButtonZM3:subscribeToGlobalModel(f1_arg1, "DirectorCharacterButtonZMList", "3", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DirectorCharacterButtonZM3:setModel(f6_local0, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DirectorCharacterButtonZM3, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		UpdateElementState(self, "ZMLoadoutPreviewFrame", controller)
	end)
	self:addElement(DirectorCharacterButtonZM3)
	self.DirectorCharacterButtonZM3 = DirectorCharacterButtonZM3
	local DirectorCharacterButtonZM4 = CoD.DirectorCharacterButtonZM.new(f1_arg0, f1_arg1, 0.5, 0.5, 90, 362, 1, 1, -760, -381)
	DirectorCharacterButtonZM4:subscribeToGlobalModel(f1_arg1, "DirectorCharacterButtonZMList", "4", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DirectorCharacterButtonZM4:setModel(f8_local0, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(DirectorCharacterButtonZM4, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		UpdateElementState(self, "ZMLoadoutPreviewFrame", controller)
	end)
	self:addElement(DirectorCharacterButtonZM4)
	self.DirectorCharacterButtonZM4 = DirectorCharacterButtonZM4
	local overheadNameContainerZM = CoD.DynamicContainerWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(overheadNameContainerZM)
	self.overheadNameContainerZM = overheadNameContainerZM
	local ZMLoadoutPreviewFrame = CoD.ZMLoadoutPreviewOrdered.new(f1_arg0, f1_arg1, 0.5, 0.5, -856, 362, 1, 1, -833, -381)
	ZMLoadoutPreviewFrame:mergeStateConditions({
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return IsElementInState(self.DirectorCharacterButtonZM1, "LoadoutPreviewLocal")
			end,
		},
		{
			stateName = "LeftCenter",
			condition = function(menu, element, event)
				return IsElementInState(self.DirectorCharacterButtonZM2, "LoadoutPreviewLocal")
			end,
		},
		{
			stateName = "RightCenter",
			condition = function(menu, element, event)
				return IsElementInState(self.DirectorCharacterButtonZM3, "LoadoutPreviewLocal")
			end,
		},
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return IsElementInState(self.DirectorCharacterButtonZM4, "LoadoutPreviewLocal")
			end,
		},
	})
	self:addElement(ZMLoadoutPreviewFrame)
	self.ZMLoadoutPreviewFrame = ZMLoadoutPreviewFrame
	self:mergeStateConditions({
		{
			stateName = "BotsAllowed",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "MapVote.mapVoteMapNext", function(model)
		local f15_local0 = self
		DataSourceHelperRecreate(f1_arg1, "DirectorCharacterButtonZMList")
	end)
	DirectorCharacterButtonZM1.id = "DirectorCharacterButtonZM1"
	DirectorCharacterButtonZM2.id = "DirectorCharacterButtonZM2"
	DirectorCharacterButtonZM3.id = "DirectorCharacterButtonZM3"
	DirectorCharacterButtonZM4.id = "DirectorCharacterButtonZM4"
	ZMLoadoutPreviewFrame.id = "ZMLoadoutPreviewFrame"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.ZombieUtility.SubscribeToLobbyClientInfo(f1_arg0, f1_arg1)
	CoD.LobbyUtility.InitOverheadNamesZM(f1_arg0, f1_arg1, overheadNameContainerZM)
	return self
end
CoD.DirectorLobbyPoseMembersZM.__onClose = function(f16_arg0)
	f16_arg0.DirectorCharacterButtonZM1:close()
	f16_arg0.DirectorCharacterButtonZM2:close()
	f16_arg0.DirectorCharacterButtonZM3:close()
	f16_arg0.DirectorCharacterButtonZM4:close()
	f16_arg0.overheadNameContainerZM:close()
	f16_arg0.ZMLoadoutPreviewFrame:close()
end
