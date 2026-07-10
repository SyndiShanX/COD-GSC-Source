CoD.CharacterSelection_CharacterRestrictedWarning = InheritFrom(LUI.UIElement)
CoD.CharacterSelection_CharacterRestrictedWarning.__defaultWidth = 64
CoD.CharacterSelection_CharacterRestrictedWarning.__defaultHeight = 64
CoD.CharacterSelection_CharacterRestrictedWarning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CharacterSelection_CharacterRestrictedWarning)
	self.id = "CharacterSelection_CharacterRestrictedWarning"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WarningIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	WarningIcon:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
	WarningIcon:setAlpha(0)
	WarningIcon:setImage(RegisterImage(0x1F10DEAAEFC50A4))
	self:addElement(WarningIcon)
	self.WarningIcon = WarningIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility[0x7B96724B9CBB296](element, f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.playlistId"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.playlistId",
		})
	end, false)
	self:linkToElementModel(self, "characterIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CharacterSelection_CharacterRestrictedWarning.__resetProperties = function(f5_arg0)
	f5_arg0.WarningIcon:completeAnimation()
	f5_arg0.WarningIcon:setAlpha(0)
end
CoD.CharacterSelection_CharacterRestrictedWarning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.WarningIcon:completeAnimation()
			f6_arg0.WarningIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.WarningIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.WarningIcon:completeAnimation()
			f7_arg0.WarningIcon:setAlpha(0.99)
			f7_arg0.clipFinished(f7_arg0.WarningIcon)
		end,
	},
}
