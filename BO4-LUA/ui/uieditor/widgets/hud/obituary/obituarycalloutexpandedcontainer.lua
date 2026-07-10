require("x64:3a05768cead8908")
require("x64:6e2cb43535b7b42")
CoD.ObituaryCalloutExpandedContainer = InheritFrom(LUI.UIElement)
CoD.ObituaryCalloutExpandedContainer.__defaultWidth = 800
CoD.ObituaryCalloutExpandedContainer.__defaultHeight = 80
CoD.ObituaryCalloutExpandedContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ObituaryCalloutExpandedContainer)
	self.id = "ObituaryCalloutExpandedContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local DamageDealtBackingBlur = LUI.UIImage.new(0.5, 0.5, -252.5, 252.5, 0.5, 0.5, -69, 2)
	DamageDealtBackingBlur:setRGB(0, 0, 0)
	DamageDealtBackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	DamageDealtBackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(DamageDealtBackingBlur)
	self.DamageDealtBackingBlur = DamageDealtBackingBlur
	local DamageDealtBacking = LUI.UIImage.new(0.5, 0.5, -252.5, 252.5, 0.5, 0.5, -69, 2)
	DamageDealtBacking:setRGB(0, 0, 0)
	DamageDealtBacking:setAlpha(0.5)
	self:addElement(DamageDealtBacking)
	self.DamageDealtBacking = DamageDealtBacking
	local ObituaryKillerIdentity = CoD.ObituaryKillerIdentity.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, -40, 40)
	ObituaryKillerIdentity:mergeStateConditions({
		{
			stateName = "NoRank",
			condition = function(menu, element, event)
				return not IsPublicOnlineGame()
			end,
		},
	})
	local f1_local4 = ObituaryKillerIdentity
	local ContribText = ObituaryKillerIdentity.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	ContribText(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(ObituaryKillerIdentity, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ObituaryKillerIdentity.KillerLabel:setText(LocalizeToUpperString(0x161ED05A4E04839))
	ObituaryKillerIdentity:linkToElementModel(self, nil, false, function(model)
		ObituaryKillerIdentity:setModel(model, f1_arg1)
	end)
	ObituaryKillerIdentity:linkToElementModel(self, "xuid", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ObituaryKillerIdentity.AttackerEmblem:setupPlayerEmblemByXUID(f5_local0)
		end
	end)
	ObituaryKillerIdentity:linkToElementModel(self, "clientNum", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ObituaryKillerIdentity.PlayerName:setText(GetClientName(f1_arg1, f6_local0))
		end
	end)
	ObituaryKillerIdentity:linkToElementModel(self, "clientNum", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ObituaryKillerIdentity.ClanName:setText(CoD.SocialUtility.CleanGamerTag(GetClientClantag(f1_arg1, f7_local0)))
		end
	end)
	ObituaryKillerIdentity:linkToElementModel(self, "rank", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ObituaryKillerIdentity.Rank:setText(CoD.BaseUtility.AlreadyLocalized(f8_local0))
		end
	end)
	ObituaryKillerIdentity:linkToElementModel(self, "rankIcon", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ObituaryKillerIdentity.RankIcon:setImage(RegisterImage(f9_local0))
		end
	end)
	self:addElement(ObituaryKillerIdentity)
	self.ObituaryKillerIdentity = ObituaryKillerIdentity
	ContribText = CoD.ObituaryEKIAContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, -66.5, -39.5)
	ContribText:linkToElementModel(self, nil, false, function(model)
		ContribText:setModel(model, f1_arg1)
	end)
	self:addElement(ContribText)
	self.ContribText = ContribText
	ObituaryKillerIdentity.id = "ObituaryKillerIdentity"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ObituaryCalloutExpandedContainer.__onClose = function(f11_arg0)
	f11_arg0.ObituaryKillerIdentity:close()
	f11_arg0.ContribText:close()
end
