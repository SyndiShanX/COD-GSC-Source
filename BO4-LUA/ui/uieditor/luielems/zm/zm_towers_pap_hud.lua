require("x64:1833dc97a387a38")
CoD.zm_towers_pap_hud = InheritFrom(CoD.Menu)
LUI.createMenu.zm_towers_pap_hud = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_towers_pap_hud", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_towers_pap_hud)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local title = LUI.UIText.new(0, 0, 1610.5, 1892.5, 0, 0, 412.5, 449.5)
	title:setRGB(0.93, 0.85, 0.03)
	title:setScale(0.75, 0.75)
	title:setText(Engine[0xF9F1239CFD921FE](0x97FED8769504E5E))
	title:setTTF("default")
	title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(title)
	self.title = title
	local danuComplete = CoD.towers_pap_head.new(f1_local1, f1_arg0, 0, 0, 1720.5, 1816.5, 0, 0, 431, 527)
	danuComplete:mergeStateConditions({
		{
			stateName = "Acquired",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "danu_acquired", 1)
			end,
		},
	})
	danuComplete:linkToElementModel(danuComplete, "danu_acquired", true, function(model)
		f1_local1:updateElementState(danuComplete, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "danu_acquired",
		})
	end)
	danuComplete:setRGB(0.17, 0.98, 0.01)
	danuComplete:setScale(0.5, 0.5)
	danuComplete:linkToElementModel(self, nil, false, function(model)
		danuComplete:setModel(model, f1_arg0)
	end)
	self:addElement(danuComplete)
	self.danuComplete = danuComplete
	local raComplete = CoD.towers_pap_head.new(f1_local1, f1_arg0, 0, 0, 1720.5, 1816.5, 0, 0, 486, 582)
	raComplete:mergeStateConditions({
		{
			stateName = "Acquired",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "ra_acquired", 1)
			end,
		},
	})
	raComplete:linkToElementModel(raComplete, "ra_acquired", true, function(model)
		f1_local1:updateElementState(raComplete, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "ra_acquired",
		})
	end)
	raComplete:setRGB(1, 0.01, 0)
	raComplete:setScale(0.5, 0.5)
	raComplete:linkToElementModel(self, nil, false, function(model)
		raComplete:setModel(model, f1_arg0)
	end)
	self:addElement(raComplete)
	self.raComplete = raComplete
	local zeusComplete = CoD.towers_pap_head.new(f1_local1, f1_arg0, 0, 0, 1671.5, 1767.5, 0, 0, 431, 527)
	zeusComplete:mergeStateConditions({
		{
			stateName = "Acquired",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "zeus_acquired", 1)
			end,
		},
	})
	zeusComplete:linkToElementModel(zeusComplete, "zeus_acquired", true, function(model)
		f1_local1:updateElementState(zeusComplete, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "zeus_acquired",
		})
	end)
	zeusComplete:setRGB(0.83, 0.37, 1)
	zeusComplete:setScale(0.5, 0.5)
	zeusComplete:linkToElementModel(self, nil, false, function(model)
		zeusComplete:setModel(model, f1_arg0)
	end)
	self:addElement(zeusComplete)
	self.zeusComplete = zeusComplete
	local zeusComplete2 = CoD.towers_pap_head.new(f1_local1, f1_arg0, 0, 0, 1672.5, 1768.5, 0, 0, 486, 582)
	zeusComplete2:mergeStateConditions({
		{
			stateName = "Acquired",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "odin_acquired", 1)
			end,
		},
	})
	zeusComplete2:linkToElementModel(zeusComplete2, "odin_acquired", true, function(model)
		f1_local1:updateElementState(zeusComplete2, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "odin_acquired",
		})
	end)
	zeusComplete2:setRGB(0, 0.84, 1)
	zeusComplete2:setScale(0.5, 0.5)
	zeusComplete2:linkToElementModel(self, nil, false, function(model)
		zeusComplete2:setModel(model, f1_arg0)
	end)
	self:addElement(zeusComplete2)
	self.zeusComplete2 = zeusComplete2
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
CoD.zm_towers_pap_hud.__onClose = function(f14_arg0)
	f14_arg0.danuComplete:close()
	f14_arg0.raComplete:close()
	f14_arg0.zeusComplete:close()
	f14_arg0.zeusComplete2:close()
end
