require("x64:b05c0560a46ef7d")
require("x64:cde4eb6b60deb3a")
CoD.WarzoneUseTimerRevivePlayer = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerRevivePlayer.__defaultWidth = 600
CoD.WarzoneUseTimerRevivePlayer.__defaultHeight = 36
CoD.WarzoneUseTimerRevivePlayer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 8, true)
	self:setAlignment(LUI.Alignment.Center)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.lastStand.revivingClientNum", 0)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.WarzoneUseTimerRevivePlayer)
	self.id = "WarzoneUseTimerRevivePlayer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReviveBannerBG = CoD.WarzoneUseTimerRevivePlayerBG.new(f1_arg0, f1_arg1, -0.01, 1.01, 0, 0, 0.5, 0.5, -18.5, 18.5)
	self:addElement(ReviveBannerBG)
	self.ReviveBannerBG = ReviveBannerBG
	local UseText = LUI.UIText.new(0, 0, 17.5, 217.5, 0, 0, 3, 33)
	UseText:setText(Engine[0xF9F1239CFD921FE](0x6326FF81589A75B))
	UseText:setTTF("ttmussels_regular")
	UseText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(UseText)
	self.UseText = UseText
	local Image = CoD.WarzoneUseTimerPlayerIcon.new(f1_arg0, f1_arg1, 0, 0, 225.5, 261.5, 0, 0, 0, 36)
	self:addElement(Image)
	self.Image = Image
	local PlayerName = LUI.UIText.new(0, 0, 269.5, 582.5, 0, 0, 3, 33)
	PlayerName:setTTF("notosans_regular")
	PlayerName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerName:subscribeToGlobalModel(f1_arg1, "HUDItems", "laststand.revivingClientNum", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerName:setText(GetClientNameAndClanTag(f1_arg1, f2_local0))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	self:mergeStateConditions({
		{
			stateName = "NonWZ",
			condition = function(menu, element, event)
				return not IsWarzone()
			end,
		},
		{
			stateName = "PlatoonNonTeam",
			condition = function(menu, element, event)
				return CoD.WZUtility.ShouldHidePlatoonReviveNumber(f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.lastStand.revivingClientNum"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.lastStand.revivingClientNum",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneUseTimerRevivePlayer.__resetProperties = function(f7_arg0)
	f7_arg0.Image:completeAnimation()
	f7_arg0.Image:setAlpha(1)
end
CoD.WarzoneUseTimerRevivePlayer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	NonWZ = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Image)
		end,
	},
	PlatoonNonTeam = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
		end,
	},
}
CoD.WarzoneUseTimerRevivePlayer.__onClose = function(f11_arg0)
	f11_arg0.ReviveBannerBG:close()
	f11_arg0.Image:close()
	f11_arg0.PlayerName:close()
end
