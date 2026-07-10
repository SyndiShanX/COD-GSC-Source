require("x64:1ef3663f11c21fa")
CoD.Hud_ZM_Trial_Shame = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_Trial_Shame.__defaultWidth = 202
CoD.Hud_ZM_Trial_Shame.__defaultHeight = 239
CoD.Hud_ZM_Trial_Shame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_Trial_Shame)
	self.id = "Hud_ZM_Trial_Shame"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local frame = LUI.UIImage.new(0.5, 0.5, -70, 70, 0, 0, 26.5, 166.5)
	frame:setImage(RegisterImage(0xD7C4340C612D07C))
	self:addElement(frame)
	self.frame = frame
	local Portrait = CoD.ZombiesPortrait.new(f1_arg0, f1_arg1, 0.5, 0.5, -80, 80, 0, 0, 18, 178)
	Portrait:setScale(0.55, 0.55)
	Portrait:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD79DB5C45AD6024))
	Portrait:setShaderVector(0, 50, 0, 0, 0)
	Portrait:setShaderVector(1, 100, 100, 0, 0)
	Portrait:setShaderVector(2, 0.1, 0.1, 0, 0)
	Portrait.Portrait:setShaderVector(0, 0.4, 0, 0, 0)
	self:addElement(Portrait)
	self.Portrait = Portrait
	local Skull = LUI.UIImage.new(0, 0, 53, 149, 0, 0, 131.5, 227.5)
	Skull:setImage(RegisterImage(0xE4DE8D9B8388B9F))
	self:addElement(Skull)
	self.Skull = Skull
	local Gamertag = LUI.UIText.new(0.5, 0.5, -101, 101, 0, 0, 209, 237)
	Gamertag:setText("")
	Gamertag:setTTF("notosans_regular")
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ZombieUtility.ShouldShowFailurePlayer(f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["ZMHudGlobal.trials.failurePlayer"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "ZMHudGlobal.trials.failurePlayer",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_Trial_Shame.__resetProperties = function(f4_arg0)
	f4_arg0.Skull:completeAnimation()
	f4_arg0.frame:completeAnimation()
	f4_arg0.Gamertag:completeAnimation()
	f4_arg0.Portrait:completeAnimation()
	f4_arg0.Skull:setAlpha(1)
	f4_arg0.frame:setAlpha(1)
	f4_arg0.Gamertag:setAlpha(1)
	f4_arg0.Portrait:setAlpha(1)
end
CoD.Hud_ZM_Trial_Shame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.frame:completeAnimation()
			f6_arg0.frame:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.frame)
			f6_arg0.Portrait:completeAnimation()
			f6_arg0.Portrait:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Portrait)
			f6_arg0.Skull:completeAnimation()
			f6_arg0.Skull:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Skull)
			f6_arg0.Gamertag:completeAnimation()
			f6_arg0.Gamertag:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Gamertag)
		end,
	},
}
CoD.Hud_ZM_Trial_Shame.__onClose = function(f7_arg0)
	f7_arg0.Portrait:close()
end
