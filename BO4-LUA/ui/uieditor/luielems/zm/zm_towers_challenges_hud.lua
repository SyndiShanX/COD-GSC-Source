CoD.zm_towers_challenges_hud = InheritFrom(CoD.Menu)
CoD.zm_towers_challenges_hud.__stateMap = {
	"DefaultState",
	"Hidden",
}
LUI.createMenu.zm_towers_challenges_hud = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_towers_challenges_hud", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_towers_challenges_hud)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ChallengeText = LUI.UIText.new(0, 0, 83, 368, 0, 0, 440, 473)
	ChallengeText:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	ChallengeText:setTTF("default")
	ChallengeText:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	ChallengeText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ChallengeText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ChallengeText:linkToElementModel(self, "challenge_text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ChallengeText:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(ChallengeText)
	self.ChallengeText = ChallengeText
	local ChallengeProgress = LUI.UIText.new(0, 0, 83, 128, 0, 0, 530.5, 575.5)
	ChallengeProgress:setRGB(1, 0.94, 0.04)
	ChallengeProgress:setAlpha(0)
	ChallengeProgress:setTTF("skorzhen")
	ChallengeProgress:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	ChallengeProgress:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ChallengeProgress:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ChallengeProgress:linkToElementModel(self, "progress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ChallengeProgress:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(ChallengeProgress)
	self.ChallengeProgress = ChallengeProgress
	local TextOf = LUI.UIText.new(0, 0, 128, 184, 0, 0, 530.5, 575.5)
	TextOf:setRGB(1, 0.95, 0.04)
	TextOf:setAlpha(0)
	TextOf:setText(Engine[0xF9F1239CFD921FE](0x1FEEEE687293F9F))
	TextOf:setTTF("skorzhen")
	TextOf:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	TextOf:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextOf:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextOf)
	self.TextOf = TextOf
	local RequiredProgress = LUI.UIText.new(0, 0, 184, 242, 0, 0, 530.5, 575.5)
	RequiredProgress:setRGB(1, 0.95, 0.04)
	RequiredProgress:setAlpha(0)
	RequiredProgress:setTTF("skorzhen")
	RequiredProgress:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RequiredProgress:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RequiredProgress:linkToElementModel(self, "required_goal", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RequiredProgress:setText(CoD.BaseUtility.AlreadyLocalized(f4_local0))
		end
	end)
	self:addElement(RequiredProgress)
	self.RequiredProgress = RequiredProgress
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	SizeToSafeArea(self, f1_arg0)
	return self
end
CoD.zm_towers_challenges_hud.__resetProperties = function(f5_arg0)
	f5_arg0.ChallengeText:completeAnimation()
	f5_arg0.ChallengeProgress:completeAnimation()
	f5_arg0.TextOf:completeAnimation()
	f5_arg0.RequiredProgress:completeAnimation()
	f5_arg0.ChallengeText:setLeftRight(0, 0, 83, 368)
	f5_arg0.ChallengeText:setTopBottom(0, 0, 440, 473)
	f5_arg0.ChallengeProgress:setLeftRight(0, 0, 83, 128)
	f5_arg0.ChallengeProgress:setTopBottom(0, 0, 530.5, 575.5)
	f5_arg0.ChallengeProgress:setRGB(1, 0.94, 0.04)
	f5_arg0.ChallengeProgress:setAlpha(0)
	f5_arg0.TextOf:setLeftRight(0, 0, 128, 184)
	f5_arg0.TextOf:setTopBottom(0, 0, 530.5, 575.5)
	f5_arg0.TextOf:setRGB(1, 0.95, 0.04)
	f5_arg0.TextOf:setAlpha(0)
	f5_arg0.RequiredProgress:setLeftRight(0, 0, 184, 242)
	f5_arg0.RequiredProgress:setTopBottom(0, 0, 530.5, 575.5)
	f5_arg0.RequiredProgress:setAlpha(0)
end
CoD.zm_towers_challenges_hud.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.ChallengeText:completeAnimation()
			f6_arg0.ChallengeText:setLeftRight(0, 0, 83, 381)
			f6_arg0.ChallengeText:setTopBottom(0, 0, 440, 473)
			f6_arg0.clipFinished(f6_arg0.ChallengeText)
			f6_arg0.ChallengeProgress:completeAnimation()
			f6_arg0.ChallengeProgress:setLeftRight(0, 0, 57, 105)
			f6_arg0.ChallengeProgress:setTopBottom(0, 0, 510, 555)
			f6_arg0.ChallengeProgress:setRGB(1, 0.89, 0.04)
			f6_arg0.ChallengeProgress:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.ChallengeProgress)
			f6_arg0.TextOf:completeAnimation()
			f6_arg0.TextOf:setLeftRight(0, 0, 129, 171)
			f6_arg0.TextOf:setTopBottom(0, 0, 510, 555)
			f6_arg0.TextOf:setRGB(1, 0.89, 0.04)
			f6_arg0.TextOf:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TextOf)
			f6_arg0.RequiredProgress:completeAnimation()
			f6_arg0.RequiredProgress:setLeftRight(0, 0, 173.5, 221.5)
			f6_arg0.RequiredProgress:setTopBottom(0, 0, 510, 555)
			f6_arg0.RequiredProgress:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.RequiredProgress)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			f7_arg0.ChallengeText:completeAnimation()
			f7_arg0.ChallengeText:setLeftRight(0, 0, 83, 368)
			f7_arg0.ChallengeText:setTopBottom(0, 0, 440, 473)
			f7_arg0.clipFinished(f7_arg0.ChallengeText)
			f7_arg0.ChallengeProgress:completeAnimation()
			f7_arg0.ChallengeProgress:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ChallengeProgress)
			f7_arg0.TextOf:completeAnimation()
			f7_arg0.TextOf:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TextOf)
			f7_arg0.RequiredProgress:completeAnimation()
			f7_arg0.RequiredProgress:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.RequiredProgress)
		end,
	},
}
CoD.zm_towers_challenges_hud.__onClose = function(f8_arg0)
	f8_arg0.ChallengeText:close()
	f8_arg0.ChallengeProgress:close()
	f8_arg0.RequiredProgress:close()
end
