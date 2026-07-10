DataSources.PCUIFormationDataSource = DataSourceHelpers.ListSetup("PCUIFormationDataSource", function(f1_arg0)
	local f1_local0 = {}
	table.insert(f1_local0, {
		models = {
			name = 0xEEF690E6416EA77,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF6A0E6416EC2A,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF690E6416EA77,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF6A0E6416EC2A,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF690E6416EA77,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF6A0E6416EC2A,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF690E6416EA77,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF6A0E6416EC2A,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF690E6416EA77,
			desc = "No Desc",
		},
		properties = {},
	})
	table.insert(f1_local0, {
		models = {
			name = 0xEEF6A0E6416EC2A,
			desc = "No Desc",
		},
		properties = {},
	})
	return f1_local0
end, true)
CoD.PC_UI_FormationMenu = InheritFrom(CoD.Menu)
LUI.createMenu.PC_UI_FormationMenu = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_UI_FormationMenu", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.PC_UI_FormationMenu)
	self.soundSet = "none"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.ignoreCursor = true
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setImage(RegisterImage(0x4BF88A437F4C579))
	self:addElement(Background)
	self.Background = Background
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		SendMenuResponse(self, "PC_UI_FormationMenu", "success", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0xB2EF56B4AF147B8, nil, "ESCAPE")
		return true
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.PC_UI_FormationMenu.__onClose = function(f5_arg0) end
