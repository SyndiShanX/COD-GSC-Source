CoD.CommonIdentityMemberNameStreamlined = InheritFrom(LUI.UIElement)
CoD.CommonIdentityMemberNameStreamlined.__defaultWidth = 241
CoD.CommonIdentityMemberNameStreamlined.__defaultHeight = 28
CoD.CommonIdentityMemberNameStreamlined.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonIdentityMemberNameStreamlined)
	self.id = "CommonIdentityMemberNameStreamlined"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TiledwhiteNoiseBacking = LUI.UIImage.new(0, 0, -4, 442, 0, 0, -9.5, 33.5)
	TiledwhiteNoiseBacking:setAlpha(0.02)
	TiledwhiteNoiseBacking:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	TiledwhiteNoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledwhiteNoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledwhiteNoiseBacking:setupNineSliceShader(64, 64)
	self:addElement(TiledwhiteNoiseBacking)
	self.TiledwhiteNoiseBacking = TiledwhiteNoiseBacking
	local gamertag = LUI.UIText.new(0, 0, 4, 217, 0.5, 0.5, -10, 12)
	gamertag:setTTF("notosans_bold")
	gamertag:setLetterSpacing(0.5)
	gamertag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	gamertag:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	gamertag.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			gamertag:setText(CoD.SocialUtility.CleanGamerTag(PrependClanTagToHostname(self:getModel(), f2_local0)))
		end
	end
	gamertag:linkToElementModel(self, "gamertag", true, gamertag.__String_Reference)
	gamertag.__String_Reference_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.gamertag
		end
		if f3_local0 then
			gamertag.__String_Reference(f3_local0)
		end
	end
	self:addElement(gamertag)
	self.gamertag = gamertag
	gamertag:linkToElementModel(self, "clantag", true, gamertag.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "DefaultState_PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonIdentityMemberNameStreamlined.__resetProperties = function(f5_arg0)
	f5_arg0.TiledwhiteNoiseBacking:completeAnimation()
	f5_arg0.TiledwhiteNoiseBacking:setLeftRight(0, 0, -4, 442)
end
CoD.CommonIdentityMemberNameStreamlined.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultState_PC = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TiledwhiteNoiseBacking:beginAnimation(190)
			f7_arg0.TiledwhiteNoiseBacking:setLeftRight(0, 1, 0, 0)
			f7_arg0.TiledwhiteNoiseBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
			f7_arg0.TiledwhiteNoiseBacking:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
		end,
	},
}
CoD.CommonIdentityMemberNameStreamlined.__onClose = function(f8_arg0)
	f8_arg0.gamertag:close()
end
