CoD.AARSquadHeader = InheritFrom(LUI.UIElement)
CoD.AARSquadHeader.__defaultWidth = 1250
CoD.AARSquadHeader.__defaultHeight = 20
CoD.AARSquadHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSquadHeader)
	self.id = "AARSquadHeader"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Player = LUI.UIText.new(0, 0, 69.5, 540.5, 0.5, 0.5, -10, 10)
	Player:setRGB(0.7, 0.7, 0.7)
	Player:setText(Engine[0xF9F1239CFD921FE](0x89CF1420A8398FE))
	Player:setTTF("0arame_mono_stencil")
	Player:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Player:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Player)
	self.Player = Player
	local Number = LUI.UIText.new(0, 0, 0, 60, 0.5, 0.5, -10, 10)
	Number:setRGB(0.7, 0.7, 0.7)
	Number:setText(Engine[0xF9F1239CFD921FE](0x1F2CC836CC2EF55))
	Number:setTTF("0arame_mono_stencil")
	Number:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Number:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Number)
	self.Number = Number
	local Kills = LUI.UIText.new(0, 0, 542.5, 678.5, 0.5, 0.5, -10, 10)
	Kills:setRGB(0.7, 0.7, 0.7)
	Kills:setText(Engine[0xF9F1239CFD921FE](0x6B234CB46B5ACD4))
	Kills:setTTF("0arame_mono_stencil")
	Kills:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Kills:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Kills)
	self.Kills = Kills
	local LongestKill = LUI.UIText.new(0, 0, 685.5, 821.5, 0.5, 0.5, -10, 10)
	LongestKill:setRGB(0.7, 0.7, 0.7)
	LongestKill:setText(Engine[0xF9F1239CFD921FE](0xD502116B555E30B))
	LongestKill:setTTF("0arame_mono_stencil")
	LongestKill:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LongestKill:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(LongestKill)
	self.LongestKill = LongestKill
	local Damage = LUI.UIText.new(0, 0, 828.5, 964.5, 0.5, 0.5, -10, 10)
	Damage:setRGB(0.7, 0.7, 0.7)
	Damage:setText(Engine[0xF9F1239CFD921FE](0x61100A6B91B62C1))
	Damage:setTTF("0arame_mono_stencil")
	Damage:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Damage:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Damage)
	self.Damage = Damage
	local Revives = LUI.UIText.new(0, 0, 969.5, 1105.5, 0.5, 0.5, -10, 10)
	Revives:setRGB(0.7, 0.7, 0.7)
	Revives:setText(Engine[0xF9F1239CFD921FE](0xCBE7CE1498F9D76))
	Revives:setTTF("0arame_mono_stencil")
	Revives:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Revives:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Revives)
	self.Revives = Revives
	local CleanUps = LUI.UIText.new(0, 0, 1112.5, 1248.5, 0.5, 0.5, -10, 10)
	CleanUps:setRGB(0.7, 0.7, 0.7)
	CleanUps:setText(Engine[0xF9F1239CFD921FE](0x45C50B4E30324A4))
	CleanUps:setTTF("0arame_mono_stencil")
	CleanUps:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CleanUps:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(CleanUps)
	self.CleanUps = CleanUps
	self:mergeStateConditions({
		{
			stateName = "Deposit",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("warzone_deposit", f1_arg1)
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSquadHeader.__resetProperties = function(f3_arg0)
	f3_arg0.LongestKill:completeAnimation()
	f3_arg0.LongestKill:setText(Engine[0xF9F1239CFD921FE](0xD502116B555E30B))
end
CoD.AARSquadHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Deposit = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LongestKill:completeAnimation()
			f5_arg0.LongestKill:setText(Engine[0xF9F1239CFD921FE](0x899455D1DF9CE06))
			f5_arg0.clipFinished(f5_arg0.LongestKill)
		end,
	},
}
