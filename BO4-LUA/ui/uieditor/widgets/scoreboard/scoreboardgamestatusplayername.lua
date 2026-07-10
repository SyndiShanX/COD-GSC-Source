CoD.ScoreboardGameStatusPlayerName = InheritFrom(LUI.UIElement)
CoD.ScoreboardGameStatusPlayerName.__defaultWidth = 250
CoD.ScoreboardGameStatusPlayerName.__defaultHeight = 33
CoD.ScoreboardGameStatusPlayerName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardGameStatusPlayerName)
	self.id = "ScoreboardGameStatusPlayerName"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerName = LUI.UIText.new(0, 0, 0, 250, 0, 0, 0, 33)
	PlayerName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PlayerName:setTTF("notosans_regular")
	PlayerName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	PlayerName:setBackingType(2)
	PlayerName:setBackingColor(0, 0, 0)
	PlayerName:setBackingAlpha(0.9)
	PlayerName:setBackingXPadding(6)
	PlayerName:setBackingYPadding(3)
	PlayerName:linkToElementModel(self, "scoreboard.playerName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerName:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	self:mergeStateConditions({
		{
			stateName = "SelfPlayer",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, element)
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardGameStatusPlayerName.__resetProperties = function(f5_arg0)
	f5_arg0.PlayerName:completeAnimation()
	f5_arg0.PlayerName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
end
CoD.ScoreboardGameStatusPlayerName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	SelfPlayer = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PlayerName:completeAnimation()
			f7_arg0.PlayerName:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f7_arg0.clipFinished(f7_arg0.PlayerName)
		end,
	},
}
CoD.ScoreboardGameStatusPlayerName.__onClose = function(f8_arg0)
	f8_arg0.PlayerName:close()
end
