require("x64:8293fdfde8af5f3")
require("x64:12d3ff0a1b8cdca")
CoD.prototype_self_revive = InheritFrom(CoD.Menu)
LUI.createMenu.prototype_self_revive = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("prototype_self_revive", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.prototype_self_revive)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local reviveProgress = CoD.WarzoneUseTimerProgress.new(f1_local1, f1_arg0, 0.5, 0.5, -240, 240, 0.5, 0.5, 258.5, 276.5)
	reviveProgress:setAlpha(0)
	reviveProgress:subscribeToGlobalModel(f1_arg0, "HUDItems", "laststand.reviveProgress", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CoD.BaseUtility.SmoothLinearInterpolateClientTime(f1_arg0, "reviveProgress", model, f2_local0)
			reviveProgress.progressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(reviveProgress)
	self.reviveProgress = reviveProgress
	local revivePrompt = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 816.5, 852.5)
	revivePrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2F4302124C18B6F"))
	revivePrompt:setTTF("ttmussels_regular")
	revivePrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	revivePrompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	revivePrompt:setBackingType(1)
	revivePrompt:setBackingWidget(CoD.ObituaryBlurBacking, f1_local1, f1_arg0)
	revivePrompt:setBackingAlpha(0.99)
	revivePrompt:setBackingXPadding(14)
	self:addElement(revivePrompt)
	self.revivePrompt = revivePrompt
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.prototype_self_revive.__onClose = function(f3_arg0)
	f3_arg0.reviveProgress:close()
end
