require("x64:c136b2e24378a7")
require("x64:1d8bce033cf1036")
require("x64:e0a59bda074d3b")
require("x64:29187ea00d726c3")
CoD.Toast_Container_ClansTeams = InheritFrom(LUI.UIElement)
CoD.Toast_Container_ClansTeams.__defaultWidth = 340
CoD.Toast_Container_ClansTeams.__defaultHeight = 80
CoD.Toast_Container_ClansTeams.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.Toast_Container_ClansTeams)
	self.id = "Toast_Container_ClansTeams"
	self.soundSet = "ChooseDecal"
	local Backing = CoD.Toast_Container_ClansTeams_Baking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 69, 84, 0.5, 0.5, -25.5, 25.5)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	local CheckmarkBaking = CoD.Toast_Container_ClansTeams_Checkmark.new(f1_arg0, f1_arg1, 0, 0, 84, 112, 0, 0, 14, 66)
	self:addElement(CheckmarkBaking)
	self.CheckmarkBaking = CheckmarkBaking
	local Spacer3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 112, 124, 0.5, 0.5, -25.5, 25.5)
	self:addElement(Spacer3)
	self.Spacer3 = Spacer3
	local NotifText = CoD.Toast_Container_Texts.new(f1_arg0, f1_arg1, 0, 0, 122, 256, -0.03, 0.98, 17, -11)
	NotifText:linkToElementModel(self, nil, false, function(model)
		NotifText:setModel(model, f1_arg1)
	end)
	NotifText:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NotifText.NotifText:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	NotifText:linkToElementModel(self, "kicker", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NotifText.NotifTextMain:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(NotifText)
	self.NotifText = NotifText
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0.1, 0.1, 222, 237, 0.5, 0.5, -25.5, 25.5)
	self:addElement(Spacer)
	self.Spacer = Spacer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Toast_Container_ClansTeams.__onClose = function(f5_arg0)
	f5_arg0.Backing:close()
	f5_arg0.Spacer2:close()
	f5_arg0.CheckmarkBaking:close()
	f5_arg0.Spacer3:close()
	f5_arg0.NotifText:close()
	f5_arg0.Spacer:close()
end
