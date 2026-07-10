require("x64:5f74ee71e1ed6da")
CoD.CodCasterFakeMap = InheritFrom(LUI.UIElement)
CoD.CodCasterFakeMap.__defaultWidth = 790
CoD.CodCasterFakeMap.__defaultHeight = 903
CoD.CodCasterFakeMap.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterFakeMap)
	self.id = "CodCasterFakeMap"
	self.soundSet = "ChooseDecal"
	local Border = CoD.BorderBakedSolid.new(f1_arg0, f1_arg1, 0, 0, 0, 790, 0, 0, 186, 687)
	self:addElement(Border)
	self.Border = Border
	local Map = LUI.UIImage.new(0, 0, -101.5, 921.5, 0, 0, 103.5, 852.5)
	Map:setImage(RegisterImage(0x78FC4615307333F))
	self:addElement(Map)
	self.Map = Map
	local ObjA = LUI.UIImage.new(0, 0, 115, 163, 0, 0, 451.5, 499.5)
	ObjA:setImage(RegisterImage(0x24C57F8DB0BFCE6))
	ObjA:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team1.teamColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ObjA:setRGB(f2_local0)
		end
	end)
	self:addElement(ObjA)
	self.ObjA = ObjA
	local ObjB = LUI.UIImage.new(0, 0, 405, 453, 0, 0, 448, 496)
	ObjB:setImage(RegisterImage(0x58FBDC4C0C829B1))
	self:addElement(ObjB)
	self.ObjB = ObjB
	local ObjC = LUI.UIImage.new(0, 0, 668, 716, 0, 0, 430, 478)
	ObjC:setImage(RegisterImage(0x484B59524AE2B0))
	ObjC:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team2.teamColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ObjC:setRGB(f3_local0)
		end
	end)
	self:addElement(ObjC)
	self.ObjC = ObjC
	local Friendly1 = LUI.UIImage.new(0, 0, 357, 405, 0, 0, 467, 515)
	Friendly1:setZRot(-29)
	Friendly1:setImage(RegisterImage(0x5AE9DCC3F499F1B))
	Friendly1:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team1.teamColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Friendly1:setRGB(f4_local0)
		end
	end)
	self:addElement(Friendly1)
	self.Friendly1 = Friendly1
	local Friendly2 = LUI.UIImage.new(0, 0, 226, 274, 0, 0, 395, 443)
	Friendly2:setZRot(-19)
	Friendly2:setImage(RegisterImage(0x62166FEA11C739))
	Friendly2:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team1.teamColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Friendly2:setRGB(f5_local0)
		end
	end)
	self:addElement(Friendly2)
	self.Friendly2 = Friendly2
	local Friendly3 = LUI.UIImage.new(0, 0, 67, 115, 0, 0, 451.5, 499.5)
	Friendly3:setZRot(-90)
	Friendly3:setImage(RegisterImage(0x62166FEA11C739))
	Friendly3:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team1.teamColor", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Friendly3:setRGB(f6_local0)
		end
	end)
	self:addElement(Friendly3)
	self.Friendly3 = Friendly3
	local Enemy1 = LUI.UIImage.new(0, 0, 474, 522, 0, 0, 324, 372)
	Enemy1:setZRot(110)
	Enemy1:setImage(RegisterImage(0x5AE9DCC3F499F1B))
	Enemy1:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team2.teamColor", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Enemy1:setRGB(f7_local0)
		end
	end)
	self:addElement(Enemy1)
	self.Enemy1 = Enemy1
	local Enemy2 = LUI.UIImage.new(0, 0, 701, 749, 0, 0, 462, 510)
	Enemy2:setZRot(90)
	Enemy2:setImage(RegisterImage(0x5AE9DCC3F499F1B))
	Enemy2:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team2.teamColor", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Enemy2:setRGB(f8_local0)
		end
	end)
	self:addElement(Enemy2)
	self.Enemy2 = Enemy2
	local Obit = LUI.UIImage.new(0, 0, 390, 420, 0, 0, 406.5, 436.5)
	Obit:setImage(RegisterImage(0xB73FD6B1D4A1BAF))
	Obit:subscribeToGlobalModel(f1_arg1, "TeamIdentity", "team2.teamColor", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Obit:setRGB(f9_local0)
		end
	end)
	self:addElement(Obit)
	self.Obit = Obit
	local Title = LUI.UIText.new(0, 0, 3, 301, 0, 0, 152, 173)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setText(LocalizeToUpperString(0x194BEAC8760BF0C))
	Title:setTTF("ttmussels_regular")
	Title:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	Title:setShaderVector(0, 0.08, 0, 0, 0)
	Title:setShaderVector(1, 0, 0, 0, 0)
	Title:setShaderVector(2, 1, 0, 0, 0)
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterFakeMap.__onClose = function(f10_arg0)
	f10_arg0.Border:close()
	f10_arg0.ObjA:close()
	f10_arg0.ObjC:close()
	f10_arg0.Friendly1:close()
	f10_arg0.Friendly2:close()
	f10_arg0.Friendly3:close()
	f10_arg0.Enemy1:close()
	f10_arg0.Enemy2:close()
	f10_arg0.Obit:close()
end
