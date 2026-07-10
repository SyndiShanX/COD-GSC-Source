require("x64:3a3b7481aa116b4")
CoD.LeaguePlayEventEndDelayLobbyMessage = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEventEndDelayLobbyMessage.__defaultWidth = 512
CoD.LeaguePlayEventEndDelayLobbyMessage.__defaultHeight = 150
CoD.LeaguePlayEventEndDelayLobbyMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEventEndDelayLobbyMessage)
	self.id = "LeaguePlayEventEndDelayLobbyMessage"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Description = LUI.UIText.new(0, 0, 6, 507, 0, 0, 34, 55)
	Description:setRGB(0.92, 0.92, 0.92)
	Description:setText(Engine[0xF9F1239CFD921FE](0xFD414AFDE92218B))
	Description:setTTF("ttmussels_regular")
	Description:setLetterSpacing(2)
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:setBackingType(1)
	Description:setBackingWidget(CoD.CommonPixelBackingWithTopPadding, f1_arg0, f1_arg1)
	Description:setBackingColor(0, 0, 0)
	Description:setBackingXPadding(8)
	Description:setBackingYPadding(8)
	self:addElement(Description)
	self.Description = Description
	local Title = LUI.UIText.new(0, 0, 6, 294, 0, 0, 5, 29)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(Engine[0xF9F1239CFD921FE](0xA7353E18F1D3EA2))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(2)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Title)
	self.Title = Title
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ArenaLeaguePlayUtility.IsProcessingLeagueID()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.Arena.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.processingEvent, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "processingEvent",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEventEndDelayLobbyMessage.__resetProperties = function(f4_arg0)
	f4_arg0.Description:completeAnimation()
	f4_arg0.Title:completeAnimation()
	f4_arg0.Description:setAlpha(1)
	f4_arg0.Title:setAlpha(1)
end
CoD.LeaguePlayEventEndDelayLobbyMessage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Description:completeAnimation()
			f5_arg0.Description:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Description)
			f5_arg0.Title:completeAnimation()
			f5_arg0.Title:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Title)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.Description:completeAnimation()
			f6_arg0.Description:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Description)
			f6_arg0.Title:completeAnimation()
			f6_arg0.Title:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Title)
		end,
	},
}
