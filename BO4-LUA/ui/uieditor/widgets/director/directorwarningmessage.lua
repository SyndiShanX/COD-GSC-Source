require("x64:7dacefed967e3df")
CoD.DirectorWarningMessage = InheritFrom(LUI.UIElement)
CoD.DirectorWarningMessage.__defaultWidth = 382
CoD.DirectorWarningMessage.__defaultHeight = 55
CoD.DirectorWarningMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BlackMarketUtility.SetupTierSkipModels(f1_arg1, f1_arg0)
	self:setClass(CoD.DirectorWarningMessage)
	self.id = "DirectorWarningMessage"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.CommonBackingWithBrackets.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local Description = LUI.UIText.new(0.05, 0.95, 0, 0, 0.35, 0.35, -8, 8)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[0xF9F1239CFD921FE](0x9EFE6AE2751120B))
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local WarningIcon = LUI.UIImage.new(0, 0, -41, -9, 0.5, 0.5, -16, 16)
	WarningIcon:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
	WarningIcon:setImage(RegisterImage(0x1F10DEAAEFC50A4))
	self:addElement(WarningIcon)
	self.WarningIcon = WarningIcon
	self:mergeStateConditions({
		{
			stateName = "Visible_SR",
			condition = function(menu, element, event)
				return CoD.WZUtility[0xE6C072866FEDB9F]()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.playlistId"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.playlistId",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorWarningMessage.__resetProperties = function(f4_arg0)
	f4_arg0.Backing:completeAnimation()
	f4_arg0.Description:completeAnimation()
	f4_arg0.WarningIcon:completeAnimation()
	f4_arg0.Backing:setAlpha(1)
	f4_arg0.Description:setAlpha(1)
	f4_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0x9EFE6AE2751120B))
	f4_arg0.WarningIcon:setAlpha(1)
end
CoD.DirectorWarningMessage.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.Backing:completeAnimation()
			f5_arg0.Backing:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Backing)
			f5_arg0.Description:completeAnimation()
			f5_arg0.Description:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Description)
			f5_arg0.WarningIcon:completeAnimation()
			f5_arg0.WarningIcon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WarningIcon)
		end,
	},
	Visible_SR = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.Description:completeAnimation()
			f6_arg0.Description:setAlpha(1)
			f6_arg0.Description:setText(Engine[0xF9F1239CFD921FE](0x9EFE6AE2751120B))
			f6_arg0.clipFinished(f6_arg0.Description)
			f6_arg0.WarningIcon:completeAnimation()
			f6_arg0.WarningIcon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.WarningIcon)
		end,
	},
}
CoD.DirectorWarningMessage.__onClose = function(f7_arg0)
	f7_arg0.Backing:close()
end
