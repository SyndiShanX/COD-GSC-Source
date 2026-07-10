require("x64:d6f270af29a0a26")
require("x64:8293fdfde8af5f3")
require("x64:8da86d2d6ffd5a8")
CoD.mp_revive_prompt = InheritFrom(CoD.Menu)
LUI.createMenu.mp_revive_prompt = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("mp_revive_prompt", f1_arg0)
	local f1_local1 = self
	CoD.HUDUtility.InitLuiElemSelfModel(self, "clamped", false)
	CoD.HUDUtility.InitLuiElemSelfModel(self, "direction", 0)
	self:setClass(CoD.mp_revive_prompt)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local prompt = LUI.UIText.new(0, 0, -48, 86, 0, 0, -44.5, -16.5)
	prompt:setAlpha(0)
	prompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_48FE93EDC5208D8"))
	prompt:setTTF("ttmussels_demibold")
	prompt:setLetterSpacing(1)
	prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(prompt)
	self.prompt = prompt
	local playerName = LUI.UIText.new(0, 0, -129, 139, 0, 0, -94.5, -64.5)
	playerName:setRGB(0.13, 0.87, 0.94)
	playerName:setTTF("notosans_bold")
	playerName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	playerName:setShaderVector(0, 0.4, 0, 0, 0)
	playerName:setShaderVector(1, 0, 0, 0, 0)
	playerName:setShaderVector(2, 0, 0, 0, 0.5)
	playerName:setLetterSpacing(1)
	playerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	playerName:linkToElementModel(self, "clientnum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			playerName:setText(GetClientName(f1_arg0, f2_local0))
		end
	end)
	self:addElement(playerName)
	self.playerName = playerName
	local bleedOutHealth0 = CoD.bleedOutHealthMP.new(f1_local1, f1_arg0, 0, 1, -105, 105, 0, 1, -105, 105)
	bleedOutHealth0:setScale(0.5, 0.5)
	bleedOutHealth0:linkToElementModel(self, nil, false, function(model)
		bleedOutHealth0:setModel(model, f1_arg0)
	end)
	self:addElement(bleedOutHealth0)
	self.bleedOutHealth0 = bleedOutHealth0
	local clamparrow = CoD.bleedOutClampedArrow.new(f1_local1, f1_arg0, 0.5, 0.5, -211, 179, 0.5, 0.5, -59, 37)
	clamparrow:setAlpha(0.4)
	clamparrow:setScale(0.5, 0.5)
	clamparrow:linkToElementModel(self, "direction", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			clamparrow:setZRot(f4_local0)
		end
	end)
	self:addElement(clamparrow)
	self.clamparrow = clamparrow
	local revivingText = LUI.UIText.new(0, 0, -300, 300, 0, 0, 85, 110)
	revivingText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_66326FF81589A75B"))
	revivingText:setTTF("ttmussels_regular")
	revivingText:setLetterSpacing(2)
	revivingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	revivingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	revivingText:setBackingType(1)
	revivingText:setBackingWidget(CoD.ObituaryBlurBacking, f1_local1, f1_arg0)
	revivingText:setBackingAlpha(0.99)
	revivingText:setBackingXPadding(10)
	revivingText:setBackingYPadding(2)
	self:addElement(revivingText)
	self.revivingText = revivingText
	local reviveNameLine = LUI.UIImage.new(0, 0, 92, 415, 0, 0, -15, -8)
	reviveNameLine:setAlpha(0)
	reviveNameLine:setImage(RegisterImage(@"uie_ui_hud_revive_name_seperator"))
	self:addElement(reviveNameLine)
	self.reviveNameLine = reviveNameLine
	local iconarrow = LUI.UIImage.new(0, 0, -31.5, 32.5, 0, 0, 25.5, 89.5)
	iconarrow:setAlpha(0.55)
	iconarrow:setScale(0.75, 0.75)
	iconarrow:setImage(RegisterImage(@"uie_ui_hud_revive_arrow"))
	self:addElement(iconarrow)
	self.iconarrow = iconarrow
	self:mergeStateConditions({
		{
			stateName = "Clamped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "clamped")
			end,
		},
		{
			stateName = "Invisible_Reviving",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg0, "reviveProgress", 0)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:linkToElementModel(self, "clamped", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clamped",
		})
	end)
	self:linkToElementModel(self, "reviveProgress", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "reviveProgress",
		})
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local9 = self
	CoD.HUDUtility.LinkSetupEntityContainerToModel(self, "clientnum", true, true, 0, 0, 30)
	CoD.WZUtility.SetupLastStandClientModelUpdate(f1_local1, self, f1_arg0)
	return self
end
CoD.mp_revive_prompt.__resetProperties = function(f10_arg0)
	f10_arg0.playerName:completeAnimation()
	f10_arg0.prompt:completeAnimation()
	f10_arg0.bleedOutHealth0:completeAnimation()
	f10_arg0.clamparrow:completeAnimation()
	f10_arg0.revivingText:completeAnimation()
	f10_arg0.reviveNameLine:completeAnimation()
	f10_arg0.iconarrow:completeAnimation()
	f10_arg0.playerName:setAlpha(1)
	f10_arg0.prompt:setAlpha(0)
	f10_arg0.bleedOutHealth0:setAlpha(1)
	f10_arg0.clamparrow:setAlpha(0.4)
	f10_arg0.revivingText:setLeftRight(0, 0, -300, 300)
	f10_arg0.revivingText:setTopBottom(0, 0, 85, 110)
	f10_arg0.revivingText:setAlpha(1)
	f10_arg0.reviveNameLine:setAlpha(0)
	f10_arg0.iconarrow:setAlpha(0.55)
end
CoD.mp_revive_prompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(7)
			f11_arg0.prompt:completeAnimation()
			f11_arg0.prompt:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.prompt)
			f11_arg0.playerName:completeAnimation()
			f11_arg0.playerName:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.playerName)
			f11_arg0.bleedOutHealth0:completeAnimation()
			f11_arg0.bleedOutHealth0:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.bleedOutHealth0)
			f11_arg0.clamparrow:completeAnimation()
			f11_arg0.clamparrow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.clamparrow)
			f11_arg0.revivingText:completeAnimation()
			f11_arg0.revivingText:setLeftRight(0, 0, -300, 300)
			f11_arg0.revivingText:setTopBottom(0, 0, 180, 260)
			f11_arg0.revivingText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.revivingText)
			f11_arg0.reviveNameLine:completeAnimation()
			f11_arg0.reviveNameLine:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.reviveNameLine)
			f11_arg0.iconarrow:completeAnimation()
			f11_arg0.iconarrow:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.iconarrow)
		end,
	},
	Clamped = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.prompt:completeAnimation()
			f12_arg0.prompt:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.prompt)
			f12_arg0.playerName:completeAnimation()
			f12_arg0.playerName:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.playerName)
			f12_arg0.revivingText:completeAnimation()
			f12_arg0.revivingText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.revivingText)
			f12_arg0.reviveNameLine:completeAnimation()
			f12_arg0.reviveNameLine:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.reviveNameLine)
			f12_arg0.iconarrow:completeAnimation()
			f12_arg0.iconarrow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.iconarrow)
		end,
	},
	Invisible_Reviving = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(7)
			f13_arg0.prompt:completeAnimation()
			f13_arg0.prompt:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.prompt)
			f13_arg0.playerName:completeAnimation()
			f13_arg0.playerName:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.playerName)
			f13_arg0.bleedOutHealth0:completeAnimation()
			f13_arg0.bleedOutHealth0:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bleedOutHealth0)
			f13_arg0.clamparrow:completeAnimation()
			f13_arg0.clamparrow:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.clamparrow)
			f13_arg0.revivingText:completeAnimation()
			f13_arg0.revivingText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.revivingText)
			f13_arg0.reviveNameLine:completeAnimation()
			f13_arg0.reviveNameLine:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.reviveNameLine)
			f13_arg0.iconarrow:completeAnimation()
			f13_arg0.iconarrow:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.iconarrow)
		end,
	},
	Visible = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.clamparrow:completeAnimation()
			f14_arg0.clamparrow:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.clamparrow)
			f14_arg0.revivingText:completeAnimation()
			f14_arg0.revivingText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.revivingText)
		end,
	},
}
CoD.mp_revive_prompt.__onClose = function(f15_arg0)
	f15_arg0.playerName:close()
	f15_arg0.bleedOutHealth0:close()
	f15_arg0.clamparrow:close()
end
