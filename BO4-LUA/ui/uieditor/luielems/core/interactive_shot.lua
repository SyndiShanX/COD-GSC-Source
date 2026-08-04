CoD.interactive_shot = InheritFrom(CoD.Menu)
LUI.createMenu.interactive_shot = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("interactive_shot", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.interactive_shot)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local TextBox = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 681, 741)
	TextBox:setTTF("default")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	TextBox:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
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
CoD.interactive_shot.__onClose = function(f3_arg0)
	f3_arg0.TextBox:close()
end
