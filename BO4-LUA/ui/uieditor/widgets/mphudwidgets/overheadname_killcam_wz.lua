require("x64:93a575a7ca17e04")
require("x64:9f7790271138ea3")
CoD.OverheadName_Killcam_WZ = InheritFrom(LUI.UIElement)
CoD.OverheadName_Killcam_WZ.__defaultWidth = 200
CoD.OverheadName_Killcam_WZ.__defaultHeight = 30
CoD.OverheadName_Killcam_WZ.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OverheadName_Killcam_WZ)
	self.id = "OverheadName_Killcam_WZ"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local YouCircle = LUI.UIImage.new(0.5, 0.5, -32, 32, 0, 0, -71, -7)
	YouCircle:setRGB(0, 0.76, 1)
	YouCircle:setImage(RegisterImage(@"uie_ui_menu_cac_selection_circle"))
	self:addElement(YouCircle)
	self.YouCircle = YouCircle
	local YouText = LUI.UIText.new(0, 0, 71, 129, 0, 0, -49.5, -28.5)
	YouText:setText(LocalizeToUpperString(@"wz/you"))
	YouText:setTTF("default")
	YouText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	YouText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(YouText)
	self.YouText = YouText
	local PlayerNameAndClanTag = CoD.OverheadName_PlayerNameAndClanTag.new(f1_arg0, f1_arg1, 0, 0, 32.5, 167.5, 0, 0, 15, 45)
	PlayerNameAndClanTag:setRGB(0, 0.76, 1)
	PlayerNameAndClanTag:linkToElementModel(self, nil, false, function(model)
		PlayerNameAndClanTag:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerNameAndClanTag)
	self.PlayerNameAndClanTag = PlayerNameAndClanTag
	local HealthBar = CoD.HealthBar.new(f1_arg0, f1_arg1, 0, 0, 31, 169, 0, 0, 0, 16)
	HealthBar:linkToElementModel(self, nil, false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OverheadName_Killcam_WZ.__onClose = function(f4_arg0)
	f4_arg0.PlayerNameAndClanTag:close()
	f4_arg0.HealthBar:close()
end
