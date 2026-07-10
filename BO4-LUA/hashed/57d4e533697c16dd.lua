CoD.PositionDraft_Searching = InheritFrom(LUI.UIElement)
CoD.PositionDraft_Searching.__defaultWidth = 240
CoD.PositionDraft_Searching.__defaultHeight = 20
CoD.PositionDraft_Searching.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_Searching)
	self.id = "PositionDraft_Searching"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Searching = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -10, 10)
	Searching:setText(LocalizeToUpperString(0x2660F4D87BFCE63))
	Searching:setTTF("ttmussels_regular")
	Searching:setLetterSpacing(1)
	Searching:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Searching:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Searching)
	self.Searching = Searching
	self:mergeStateConditions({
		{
			stateName = "CustomGame",
			condition = function(menu, element, event)
				return IsLobbyMode(Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_Searching.__resetProperties = function(f4_arg0)
	f4_arg0.Searching:completeAnimation()
	f4_arg0.Searching:setLeftRight(0, 1, 0, 0)
	f4_arg0.Searching:setTopBottom(0.5, 0.5, -10, 10)
	f4_arg0.Searching:setText(LocalizeToUpperString(0x2660F4D87BFCE63))
end
CoD.PositionDraft_Searching.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Searching:completeAnimation()
			f5_arg0.Searching:setLeftRight(0, 1, 1, 1)
			f5_arg0.Searching:setTopBottom(0, 0, 0.5, 26.5)
			f5_arg0.Searching:setText(LocalizeToUpperString(0x2660F4D87BFCE63))
			f5_arg0.clipFinished(f5_arg0.Searching)
		end,
	},
	CustomGame = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Searching:completeAnimation()
			f6_arg0.Searching:setLeftRight(0, 1, 1, 1)
			f6_arg0.Searching:setTopBottom(0, 0, 0.5, 26.5)
			f6_arg0.Searching:setText(LocalizeToUpperString(0x32A61A3D616BB1E))
			f6_arg0.clipFinished(f6_arg0.Searching)
		end,
	},
}
