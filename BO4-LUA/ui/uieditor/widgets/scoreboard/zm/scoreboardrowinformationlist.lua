require("ui/uieditor/widgets/zmfrontend/zmtabbedscoreboardstatbox")
CoD.ScoreboardRowInformationList = InheritFrom(LUI.UIElement)
CoD.ScoreboardRowInformationList.__defaultWidth = 800
CoD.ScoreboardRowInformationList.__defaultHeight = 60
CoD.ScoreboardRowInformationList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardRowInformationList)
	self.id = "ScoreboardRowInformationList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ClanAndGamerName = LUI.UIText.new(0, 0, 0, 250, 0, 0, 20, 40)
	ClanAndGamerName:setRGB(0.92, 0.92, 0.92)
	ClanAndGamerName:setTTF("notosans_bold")
	ClanAndGamerName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ClanAndGamerName:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	ClanAndGamerName:linkToElementModel(self, "scoreboard.playerName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ClanAndGamerName:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(ClanAndGamerName)
	self.ClanAndGamerName = ClanAndGamerName
	local Divider01 = LUI.UIImage.new(0, 0, 257, 261, 0, 0, 6, 54)
	Divider01:setImage(RegisterImage(@"hash_284CF831D4ADD5C3"))
	Divider01:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Divider01)
	self.Divider01 = Divider01
	local StatBox1 = CoD.ZMTabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 0, 0, 268, 428, 0.5, 0.5, -26, 34)
	StatBox1:setRGB(0.92, 0.92, 0.92)
	StatBox1:setScale(0.8, 0.8)
	StatBox1:linkToElementModel(self, nil, false, function(model)
		StatBox1:setModel(model, f1_arg1)
	end)
	StatBox1:linkToElementModel(self, "scoreboard.col1", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			StatBox1.Value:setText(CoD.ZombieUtility.FormatNumbersWithDelimetersIfGametype(f1_arg1, "zstandard", f4_local0))
		end
	end)
	self:addElement(StatBox1)
	self.StatBox1 = StatBox1
	local Divider02 = LUI.UIImage.new(0, 0, 435, 439, 0, 0, 6, 54)
	Divider02:setImage(RegisterImage(@"hash_284CF831D4ADD5C3"))
	Divider02:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Divider02)
	self.Divider02 = Divider02
	local StatBox2 = CoD.ZMTabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 0, 0, 446, 526, 0.5, 0.5, -26, 34)
	StatBox2:setRGB(0.92, 0.92, 0.92)
	StatBox2:setScale(0.8, 0.8)
	StatBox2:linkToElementModel(self, nil, false, function(model)
		StatBox2:setModel(model, f1_arg1)
	end)
	StatBox2:linkToElementModel(self, "scoreboard.col2", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			StatBox2.Value:setText(f6_local0)
		end
	end)
	self:addElement(StatBox2)
	self.StatBox2 = StatBox2
	local Divider03 = LUI.UIImage.new(0, 0, 533, 537, 0, 0, 6, 54)
	Divider03:setImage(RegisterImage(@"hash_284CF831D4ADD5C3"))
	Divider03:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Divider03)
	self.Divider03 = Divider03
	local StatBox3 = CoD.ZMTabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 0, 0, 544, 624, 0.5, 0.5, -26, 34)
	StatBox3:setRGB(0.92, 0.92, 0.92)
	StatBox3:setScale(0.8, 0.8)
	StatBox3:linkToElementModel(self, nil, false, function(model)
		StatBox3:setModel(model, f1_arg1)
	end)
	StatBox3:linkToElementModel(self, "scoreboard.col3", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			StatBox3.Value:setText(f8_local0)
		end
	end)
	self:addElement(StatBox3)
	self.StatBox3 = StatBox3
	local Divider04 = LUI.UIImage.new(0, 0, 631, 635, 0, 0, 6, 54)
	Divider04:setImage(RegisterImage(@"hash_284CF831D4ADD5C3"))
	Divider04:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Divider04)
	self.Divider04 = Divider04
	local StatBox4 = CoD.ZMTabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 0, 0, 642, 722, 0.5, 0.5, -26, 34)
	StatBox4:setRGB(0.92, 0.92, 0.92)
	StatBox4:setScale(0.8, 0.8)
	StatBox4:linkToElementModel(self, nil, false, function(model)
		StatBox4:setModel(model, f1_arg1)
	end)
	StatBox4:linkToElementModel(self, "scoreboard.footer1", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			StatBox4.Value:setText(f10_local0)
		end
	end)
	self:addElement(StatBox4)
	self.StatBox4 = StatBox4
	local Divider05 = LUI.UIImage.new(0, 0, 729, 733, 0, 0, 6, 54)
	Divider05:setImage(RegisterImage(@"hash_284CF831D4ADD5C3"))
	Divider05:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Divider05)
	self.Divider05 = Divider05
	local StatBox5 = CoD.ZMTabbedScoreboardStatBox.new(f1_arg0, f1_arg1, 0, 0, 740, 820, 0.5, 0.5, -26, 34)
	StatBox5:setRGB(0.92, 0.92, 0.92)
	StatBox5:setScale(0.8, 0.8)
	StatBox5:linkToElementModel(self, nil, false, function(model)
		StatBox5:setModel(model, f1_arg1)
	end)
	StatBox5:linkToElementModel(self, "scoreboard.footer2", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			StatBox5.Value:setText(f12_local0)
		end
	end)
	self:addElement(StatBox5)
	self.StatBox5 = StatBox5
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardRowInformationList.__onClose = function(f13_arg0)
	f13_arg0.ClanAndGamerName:close()
	f13_arg0.StatBox1:close()
	f13_arg0.StatBox2:close()
	f13_arg0.StatBox3:close()
	f13_arg0.StatBox4:close()
	f13_arg0.StatBox5:close()
end
