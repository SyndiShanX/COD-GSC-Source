CoD.PositionDraft_EnemyStatus = InheritFrom(LUI.UIElement)
CoD.PositionDraft_EnemyStatus.__defaultWidth = 400
CoD.PositionDraft_EnemyStatus.__defaultHeight = 90
CoD.PositionDraft_EnemyStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "Clients.enemyCount")
	self:setClass(CoD.PositionDraft_EnemyStatus)
	self.id = "PositionDraft_EnemyStatus"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EnemiesReadyBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 6.5, 68.5)
	EnemiesReadyBackground:setRGB(0, 0, 0)
	EnemiesReadyBackground:setAlpha(0.7)
	EnemiesReadyBackground:setYRot(180)
	self:addElement(EnemiesReadyBackground)
	self.EnemiesReadyBackground = EnemiesReadyBackground
	local EnemiesReady = LUI.UIText.new(0, 0.9, 0, 0, 0.52, 0.52, -8, 16)
	EnemiesReady:setRGB(0.92, 0.92, 0.92)
	EnemiesReady:setText(Engine[0xF9F1239CFD921FE](0x675EA06AE086251))
	EnemiesReady:setTTF("ttmussels_regular")
	EnemiesReady:setLetterSpacing(1)
	EnemiesReady:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	EnemiesReady:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(EnemiesReady)
	self.EnemiesReady = EnemiesReady
	local WaitingForEnemyTeamBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 2, 43)
	WaitingForEnemyTeamBackground:setRGB(0.72, 0.65, 0.5)
	WaitingForEnemyTeamBackground:setAlpha(0)
	WaitingForEnemyTeamBackground:setYRot(180)
	WaitingForEnemyTeamBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	WaitingForEnemyTeamBackground:setShaderVector(0, 1.1, 0, 0, 0)
	WaitingForEnemyTeamBackground:setShaderVector(1, 0.71, 0, 0, 0)
	WaitingForEnemyTeamBackground:setShaderVector(2, 1, 0, 0, 0)
	WaitingForEnemyTeamBackground:setShaderVector(3, 0, 0, 0, 0)
	WaitingForEnemyTeamBackground:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(WaitingForEnemyTeamBackground)
	self.WaitingForEnemyTeamBackground = WaitingForEnemyTeamBackground
	local WaitingForEnemyTeam = LUI.UIText.new(0, 0.9, 0, 0, 0.52, 0.52, -36.5, -12.5)
	WaitingForEnemyTeam:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	WaitingForEnemyTeam:setText(Engine[0xF9F1239CFD921FE](0xCB55EDAFFF81C41))
	WaitingForEnemyTeam:setTTF("ttmussels_demibold")
	WaitingForEnemyTeam:setLetterSpacing(3)
	WaitingForEnemyTeam:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	WaitingForEnemyTeam:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(WaitingForEnemyTeam)
	self.WaitingForEnemyTeam = WaitingForEnemyTeam
	local LineTop01 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 6, 7)
	LineTop01:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LineTop01:setAlpha(0.5)
	self:addElement(LineTop01)
	self.LineTop01 = LineTop01
	local Pip01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 16, 17)
	Pip01:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Pip01:setAlpha(0.5)
	self:addElement(Pip01)
	self.Pip01 = Pip01
	local Corner01 = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 6, 12)
	Corner01:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Corner01:setAlpha(0.5)
	self:addElement(Corner01)
	self.Corner01 = Corner01
	self:mergeStateConditions({
		{
			stateName = "WaitingForEnemyTeam",
			condition = function(menu, element, event)
				return TeamIsReady(f1_arg1) and not EnemyTeamIsReady(f1_arg1)
			end,
		},
		{
			stateName = "NoEnemies",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["Clients.clientCount"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "Clients.clientCount",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["Clients.clientReadyCount"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "Clients.clientReadyCount",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_EnemyStatus.__resetProperties = function(f6_arg0)
	f6_arg0.WaitingForEnemyTeamBackground:completeAnimation()
	f6_arg0.WaitingForEnemyTeam:completeAnimation()
	f6_arg0.EnemiesReadyBackground:completeAnimation()
	f6_arg0.EnemiesReady:completeAnimation()
	f6_arg0.Pip01:completeAnimation()
	f6_arg0.LineTop01:completeAnimation()
	f6_arg0.Corner01:completeAnimation()
	f6_arg0.WaitingForEnemyTeamBackground:setAlpha(0)
	f6_arg0.WaitingForEnemyTeam:setAlpha(1)
	f6_arg0.EnemiesReadyBackground:setAlpha(0.7)
	f6_arg0.EnemiesReady:setAlpha(1)
	f6_arg0.Pip01:setAlpha(0.5)
	f6_arg0.LineTop01:setAlpha(0.5)
	f6_arg0.Corner01:setAlpha(0.5)
end
CoD.PositionDraft_EnemyStatus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.WaitingForEnemyTeamBackground:completeAnimation()
			f7_arg0.WaitingForEnemyTeamBackground:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.WaitingForEnemyTeamBackground)
			f7_arg0.WaitingForEnemyTeam:completeAnimation()
			f7_arg0.WaitingForEnemyTeam:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.WaitingForEnemyTeam)
		end,
	},
	WaitingForEnemyTeam = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.WaitingForEnemyTeamBackground:completeAnimation()
			f8_arg0.WaitingForEnemyTeamBackground:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.WaitingForEnemyTeamBackground)
			f8_arg0.WaitingForEnemyTeam:completeAnimation()
			f8_arg0.WaitingForEnemyTeam:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.WaitingForEnemyTeam)
		end,
	},
	NoEnemies = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(7)
			f9_arg0.EnemiesReadyBackground:completeAnimation()
			f9_arg0.EnemiesReadyBackground:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.EnemiesReadyBackground)
			f9_arg0.EnemiesReady:completeAnimation()
			f9_arg0.EnemiesReady:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.EnemiesReady)
			f9_arg0.WaitingForEnemyTeamBackground:completeAnimation()
			f9_arg0.WaitingForEnemyTeamBackground:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.WaitingForEnemyTeamBackground)
			f9_arg0.WaitingForEnemyTeam:completeAnimation()
			f9_arg0.WaitingForEnemyTeam:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.WaitingForEnemyTeam)
			f9_arg0.LineTop01:completeAnimation()
			f9_arg0.LineTop01:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LineTop01)
			f9_arg0.Pip01:completeAnimation()
			f9_arg0.Pip01:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Pip01)
			f9_arg0.Corner01:completeAnimation()
			f9_arg0.Corner01:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Corner01)
		end,
	},
}
