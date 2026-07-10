CoD.PlayerPortraitFocusBottom = InheritFrom(LUI.UIElement)
CoD.PlayerPortraitFocusBottom.__defaultWidth = 132
CoD.PlayerPortraitFocusBottom.__defaultHeight = 16
CoD.PlayerPortraitFocusBottom.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerPortraitFocusBottom)
	self.id = "PlayerPortraitFocusBottom"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bottomselector = LUI.UIImage.new(0.5, 0.5, -66, 66, 0, 0, 0, 16)
	bottomselector:setAlpha(0)
	bottomselector:setImage(RegisterImage(0x1250D548347B092))
	bottomselector:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			bottomselector:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(bottomselector)
	self.bottomselector = bottomselector
	self:mergeStateConditions({
		{
			stateName = "PlayerSelected",
			condition = function(menu, element, event)
				return IsScoreboardPlayerSelf(element, f1_arg1)
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
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["deadSpectator.playerIndex"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerPortraitFocusBottom.__resetProperties = function(f7_arg0)
	f7_arg0.bottomselector:completeAnimation()
	f7_arg0.bottomselector:setAlpha(0)
end
CoD.PlayerPortraitFocusBottom.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	PlayerSelected = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.bottomselector:completeAnimation()
			f9_arg0.bottomselector:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.bottomselector)
		end,
	},
}
CoD.PlayerPortraitFocusBottom.__onClose = function(f10_arg0)
	f10_arg0.bottomselector:close()
end
