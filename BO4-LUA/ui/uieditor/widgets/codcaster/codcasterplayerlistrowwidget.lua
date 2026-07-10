require("x64:f3e6ddb93f27bec")
require("x64:a4c30ab07b8c22f")
require("x64:b672d66c458dc7f")
require("x64:cf05df8e6110793")
require("x64:1e6a720fa965a6a")
require("x64:d73fbe78518a345")
local PostLoadFunc = function(self, controller)
	self:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "objectivesUpdated"), function(model)
		local f2_local0 = self:getModel()
		if f2_local0 then
			local f2_local1 = Engine[0x40E824FE270E174](f2_local0, "clientNum")
			if f2_local1 then
				local f2_local2 = Engine[0x614D394F6F9A18D](f2_local1)
				self.ObjectiveStatus:setImage(RegisterImage(GetPlayerListObjectiveImage(controller, f2_local2)))
				self.ObjectiveStatus:setRGB(GetPlayerListObjectiveColor(controller, f2_local2))
			end
		end
	end)
end
CoD.CodCasterPlayerListRowWidget = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerListRowWidget.__defaultWidth = 404
CoD.CodCasterPlayerListRowWidget.__defaultHeight = 18
CoD.CodCasterPlayerListRowWidget.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	self:setClass(CoD.CodCasterPlayerListRowWidget)
	self.id = "CodCasterPlayerListRowWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f3_arg0:addElementToPendingUpdateStateList(self)
	local statsbg = LUI.UIImage.new(1, 1, -194, 0, 0, 0, 0, 18)
	statsbg:setRGB(0, 0, 0)
	self:addElement(statsbg)
	self.statsbg = statsbg
	local BlackBar = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 16)
	BlackBar:setAlpha(0.8)
	BlackBar:setImage(RegisterImage(0x97941765AC1B3BE))
	BlackBar:linkToElementModel(self, "clientNum", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BlackBar:setRGB(TeamColorFromPlayerIndex(f3_arg1, f4_local0))
		end
	end)
	self:addElement(BlackBar)
	self.BlackBar = BlackBar
	local highlight = CoD.CodCasterPlayerListRowHighlight.new(f3_arg0, f3_arg1, 0.5, 0.5, -202, 202, 0, 0, 0, 16)
	highlight:linkToElementModel(self, nil, false, function(model)
		highlight:setModel(model, f3_arg1)
	end)
	self:addElement(highlight)
	self.highlight = highlight
	local freebg = LUI.UIImage.new(0.5, 0.5, -202, 202, 0, 0, 0, 16)
	freebg:setAlpha(0)
	freebg:setImage(RegisterImage(0xBD8D43404DC456))
	self:addElement(freebg)
	self.freebg = freebg
	local focus = LUI.UIImage.new(0, 0, -2, 502, 0, 0, -6, 34)
	focus:setAlpha(0)
	focus:setImage(RegisterImage(0x9C9B7154A05B453))
	self:addElement(focus)
	self.focus = focus
	local ScoreboardRowDeathIcon = LUI.UIImage.new(0, 0, 13, 41, 0.5, 0.5, -16, 12)
	ScoreboardRowDeathIcon:setScale(0.65, 0.65)
	ScoreboardRowDeathIcon:linkToElementModel(self, "clientNum", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ScoreboardRowDeathIcon:setupClientStatusImage(f6_local0)
		end
	end)
	self:addElement(ScoreboardRowDeathIcon)
	self.ScoreboardRowDeathIcon = ScoreboardRowDeathIcon
	local Score01 = CoD.PlayerListRowKillandDeathValue.new(f3_arg0, f3_arg1, 0, 0, 250, 345, 0, 0, 1, 16)
	Score01:setAlpha(0.6)
	Score01:linkToElementModel(self, "clientNumScoreInfoUpdated", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Score01.Score01:setText(GetCodcasterPlayerListKD(f3_arg1, f7_local0))
		end
	end)
	self:addElement(Score01)
	self.Score01 = Score01
	local DeadIcon = LUI.UIImage.new(0, 0, 17, 37, 0.5, 0.5, -11, 9)
	DeadIcon:setScale(0.85, 0.75)
	DeadIcon:setImage(RegisterImage(0x9E55E6818C34348))
	self:addElement(DeadIcon)
	self.DeadIcon = DeadIcon
	local ObjectiveStatus = CoD.CodCasterPortraitObjectiveStatus.new(f3_arg0, f3_arg1, 0, 0, -5, 59, 0.5, 0.5, -33, 31)
	ObjectiveStatus:setScale(0.2, 0.2)
	ObjectiveStatus:linkToElementModel(self, nil, false, function(model)
		ObjectiveStatus:setModel(model, f3_arg1)
	end)
	self:addElement(ObjectiveStatus)
	self.ObjectiveStatus = ObjectiveStatus
	local Gamertag = CoD.CodCasterPlayerListRowWidgetText.new(f3_arg0, f3_arg1, 0, 0, 41, 206, 0, 0, 0.5, 15.5)
	Gamertag:linkToElementModel(self, nil, false, function(model)
		Gamertag:setModel(model, f3_arg1)
	end)
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	local Score0100 = CoD.PlayerListRowValue.new(f3_arg0, f3_arg1, 0, 0, 359.5, 406.5, 0, 0, 0.5, 15.5)
	Score0100:setAlpha(0.6)
	Score0100:linkToElementModel(self, "clientNumScoreInfoUpdated", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Score0100.Score0100:setText(CoD.CodCasterUtility.ScoreByGametype(f3_arg1, f10_local0))
		end
	end)
	self:addElement(Score0100)
	self.Score0100 = Score0100
	local Score010 = CoD.PlayerListRowValue.new(f3_arg0, f3_arg1, 0, 0, 327.5, 374.5, 0, 0, 0.5, 15.5)
	Score010:setAlpha(0.6)
	Score010:linkToElementModel(self, "currentStreak", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Score010.Score0100:setText(GetScoreboardCurrentStreak(f3_arg1, f11_local0))
		end
	end)
	self:addElement(Score010)
	self.Score010 = Score010
	local PlayerListRowHealthValue = CoD.PlayerListRowHealthValue.new(f3_arg0, f3_arg1, 0, 0, 206, 253, 0, 0, 0.5, 15.5)
	PlayerListRowHealthValue:setAlpha(0.6)
	PlayerListRowHealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			PlayerListRowHealthValue.HealthValue:setRGB(CoD.CodCasterUtility.HealthColor(f12_local0))
		end
	end)
	PlayerListRowHealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			PlayerListRowHealthValue.HealthValue:setText(CoD.BaseUtility.AlreadyLocalized(f13_local0))
		end
	end)
	self:addElement(PlayerListRowHealthValue)
	self.PlayerListRowHealthValue = PlayerListRowHealthValue
	self:mergeStateConditions({
		{
			stateName = "IsSelfNextDead",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsSelfNext(element, f3_arg1) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f3_arg1, "health.healthValue", 0)
			end,
		},
		{
			stateName = "IsSelf",
			condition = function(menu, element, event)
				return IsScoreboardPlayerSelf(element, f3_arg1)
			end,
		},
		{
			stateName = "PlayerDead",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f3_arg1, "health.healthValue", 0)
			end,
		},
		{
			stateName = "IsSelfNext",
			condition = function(menu, element, event)
				return CoD.CodCasterUtility.IsSelfNext(element, f3_arg1)
			end,
		},
	})
	local f3_local14 = self
	local f3_local15 = self.subscribeToModel
	local f3_local16 = Engine[0x4DF5CFBC1771947](f3_arg1)
	f3_local15(f3_local14, f3_local16["hudItems.codcaster.nextClient"], function(f18_arg0)
		f3_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.codcaster.nextClient",
		})
	end, false)
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f3_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	self:linkToElementModel(self, "clientNum", true, function(model)
		f3_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	f3_local14 = self
	f3_local15 = self.subscribeToModel
	f3_local16 = Engine[0x4DF5CFBC1771947](f3_arg1)
	f3_local15(f3_local14, f3_local16["deadSpectator.playerIndex"], function(f21_arg0)
		f3_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f21_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	f3_local14 = self
	f3_local15 = self.subscribeToModel
	f3_local16 = Engine[0x4DF5CFBC1771947](f3_arg1)
	f3_local15(f3_local14, f3_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f22_arg0)
		f3_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	self.__on_menuOpened_self = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
		local f23_local0 = self
		CoD.CodCasterUtility.ScoreByGametypeInit(self.Score0100)
		CoD.CodCasterUtility.ForcePlayerListEntryUpdate(self, f23_arg1)
	end
	f3_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	Gamertag.id = "Gamertag"
	self.__on_close_removeOverrides = function()
		f3_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.CodCasterPlayerListRowWidget.__resetProperties = function(f25_arg0)
	f25_arg0.highlight:completeAnimation()
	f25_arg0.focus:completeAnimation()
	f25_arg0.DeadIcon:completeAnimation()
	f25_arg0.ScoreboardRowDeathIcon:completeAnimation()
	f25_arg0.freebg:completeAnimation()
	f25_arg0.BlackBar:completeAnimation()
	f25_arg0.Score0100:completeAnimation()
	f25_arg0.Score010:completeAnimation()
	f25_arg0.Score01:completeAnimation()
	f25_arg0.PlayerListRowHealthValue:completeAnimation()
	f25_arg0.highlight:setRGB(1, 1, 1)
	f25_arg0.highlight:setAlpha(1)
	f25_arg0.focus:setRGB(1, 1, 1)
	f25_arg0.focus:setAlpha(0)
	f25_arg0.DeadIcon:setAlpha(1)
	f25_arg0.ScoreboardRowDeathIcon:setAlpha(1)
	f25_arg0.freebg:setRGB(1, 1, 1)
	f25_arg0.freebg:setAlpha(0)
	f25_arg0.BlackBar:setAlpha(0.8)
	f25_arg0.Score0100:setAlpha(0.6)
	f25_arg0.Score010:setAlpha(0.6)
	f25_arg0.Score01:setAlpha(0.6)
	f25_arg0.PlayerListRowHealthValue:setAlpha(0.6)
end
CoD.CodCasterPlayerListRowWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			f26_arg0.highlight:completeAnimation()
			f26_arg0.highlight:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.highlight)
			f26_arg0.focus:completeAnimation()
			f26_arg0.focus:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
			f26_arg0.clipFinished(f26_arg0.focus)
			f26_arg0.ScoreboardRowDeathIcon:completeAnimation()
			f26_arg0.ScoreboardRowDeathIcon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ScoreboardRowDeathIcon)
			f26_arg0.DeadIcon:completeAnimation()
			f26_arg0.DeadIcon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DeadIcon)
		end,
	},
	IsSelfNextDead = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.highlight:completeAnimation()
			f27_arg0.highlight:setRGB(1, 1, 1)
			f27_arg0.highlight:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.highlight)
			f27_arg0.freebg:completeAnimation()
			f27_arg0.freebg:setRGB(1, 1, 1)
			f27_arg0.freebg:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.freebg)
			f27_arg0.ScoreboardRowDeathIcon:completeAnimation()
			f27_arg0.ScoreboardRowDeathIcon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ScoreboardRowDeathIcon)
			f27_arg0.DeadIcon:completeAnimation()
			f27_arg0.DeadIcon:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.DeadIcon)
		end,
		Focus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(6)
			f28_arg0.BlackBar:completeAnimation()
			f28_arg0.BlackBar:setAlpha(0.8)
			f28_arg0.clipFinished(f28_arg0.BlackBar)
			f28_arg0.focus:completeAnimation()
			f28_arg0.focus:setAlpha(0.5)
			f28_arg0.clipFinished(f28_arg0.focus)
			f28_arg0.Score01:completeAnimation()
			f28_arg0.Score01:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Score01)
			f28_arg0.Score0100:completeAnimation()
			f28_arg0.Score0100:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Score0100)
			f28_arg0.Score010:completeAnimation()
			f28_arg0.Score010:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Score010)
			f28_arg0.PlayerListRowHealthValue:completeAnimation()
			f28_arg0.PlayerListRowHealthValue:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.PlayerListRowHealthValue)
		end,
	},
	IsSelf = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.focus:completeAnimation()
			f29_arg0.focus:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.focus)
			f29_arg0.ScoreboardRowDeathIcon:completeAnimation()
			f29_arg0.ScoreboardRowDeathIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ScoreboardRowDeathIcon)
			f29_arg0.DeadIcon:completeAnimation()
			f29_arg0.DeadIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.DeadIcon)
		end,
		Focus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(6)
			f30_arg0.BlackBar:completeAnimation()
			f30_arg0.BlackBar:setAlpha(0.8)
			f30_arg0.clipFinished(f30_arg0.BlackBar)
			f30_arg0.focus:completeAnimation()
			f30_arg0.focus:setAlpha(0.5)
			f30_arg0.clipFinished(f30_arg0.focus)
			f30_arg0.Score01:completeAnimation()
			f30_arg0.Score01:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Score01)
			f30_arg0.Score0100:completeAnimation()
			f30_arg0.Score0100:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Score0100)
			f30_arg0.Score010:completeAnimation()
			f30_arg0.Score010:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Score010)
			f30_arg0.PlayerListRowHealthValue:completeAnimation()
			f30_arg0.PlayerListRowHealthValue:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.PlayerListRowHealthValue)
		end,
	},
	PlayerDead = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.highlight:completeAnimation()
			f31_arg0.highlight:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.highlight)
			f31_arg0.ScoreboardRowDeathIcon:completeAnimation()
			f31_arg0.ScoreboardRowDeathIcon:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ScoreboardRowDeathIcon)
			f31_arg0.DeadIcon:completeAnimation()
			f31_arg0.DeadIcon:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.DeadIcon)
		end,
	},
	IsSelfNext = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(4)
			f32_arg0.highlight:completeAnimation()
			f32_arg0.highlight:setRGB(1, 1, 1)
			f32_arg0.highlight:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.highlight)
			f32_arg0.freebg:completeAnimation()
			f32_arg0.freebg:setRGB(1, 1, 1)
			f32_arg0.freebg:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.freebg)
			f32_arg0.ScoreboardRowDeathIcon:completeAnimation()
			f32_arg0.ScoreboardRowDeathIcon:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ScoreboardRowDeathIcon)
			f32_arg0.DeadIcon:completeAnimation()
			f32_arg0.DeadIcon:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.DeadIcon)
		end,
		Focus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(6)
			f33_arg0.BlackBar:completeAnimation()
			f33_arg0.BlackBar:setAlpha(0.8)
			f33_arg0.clipFinished(f33_arg0.BlackBar)
			f33_arg0.focus:completeAnimation()
			f33_arg0.focus:setAlpha(0.5)
			f33_arg0.clipFinished(f33_arg0.focus)
			f33_arg0.Score01:completeAnimation()
			f33_arg0.Score01:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Score01)
			f33_arg0.Score0100:completeAnimation()
			f33_arg0.Score0100:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Score0100)
			f33_arg0.Score010:completeAnimation()
			f33_arg0.Score010:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Score010)
			f33_arg0.PlayerListRowHealthValue:completeAnimation()
			f33_arg0.PlayerListRowHealthValue:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.PlayerListRowHealthValue)
		end,
	},
}
CoD.CodCasterPlayerListRowWidget.__onClose = function(f34_arg0)
	f34_arg0.__on_close_removeOverrides()
	f34_arg0.BlackBar:close()
	f34_arg0.highlight:close()
	f34_arg0.ScoreboardRowDeathIcon:close()
	f34_arg0.Score01:close()
	f34_arg0.ObjectiveStatus:close()
	f34_arg0.Gamertag:close()
	f34_arg0.Score0100:close()
	f34_arg0.Score010:close()
	f34_arg0.PlayerListRowHealthValue:close()
end
