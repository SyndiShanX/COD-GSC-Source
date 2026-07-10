require("x64:9f7790271138ea3")
require("x64:330cd3bfe28d4dc")
require("x64:ac5421509a88487")
CoD.OverheadName_WZ_NameAndNumber = InheritFrom(LUI.UIElement)
CoD.OverheadName_WZ_NameAndNumber.__defaultWidth = 164
CoD.OverheadName_WZ_NameAndNumber.__defaultHeight = 33
CoD.OverheadName_WZ_NameAndNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.OverheadName_WZ_NameAndNumber)
	self.id = "OverheadName_WZ_NameAndNumber"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OverheadNameWZCash = CoD.OverheadNameWZCash.new(f1_arg0, f1_arg1, 0, 0, -20, 12, 0, 0, -2, 30)
	OverheadNameWZCash:linkToElementModel(self, nil, false, function(model)
		OverheadNameWZCash:setModel(model, f1_arg1)
	end)
	self:addElement(OverheadNameWZCash)
	self.OverheadNameWZCash = OverheadNameWZCash
	local Image = CoD.OverheadName_WZ_PlayerNumber.new(f1_arg0, f1_arg1, 0, 0, 17, 44, 0, 0, 0, 27)
	Image:linkToElementModel(self, nil, false, function(model)
		Image:setModel(model, f1_arg1)
	end)
	self:addElement(Image)
	self.Image = Image
	local PlayerNameAndClanTag = CoD.OverheadName_PlayerNameAndClanTag.new(f1_arg0, f1_arg1, 0, 0, 49, 184, 0, 0, 3, 33)
	PlayerNameAndClanTag.ClanTag:setMaterial(LUI.UIImage.GetCachedMaterial(0x6250C6FCAC36BD4))
	PlayerNameAndClanTag.ClanTag:setShaderVector(0, 0.2, 0, 0, 0)
	PlayerNameAndClanTag.ClanTag:setShaderVector(1, 0, 0, 0, 1)
	PlayerNameAndClanTag.PlayerName:setMaterial(LUI.UIImage.GetCachedMaterial(0x6250C6FCAC36BD4))
	PlayerNameAndClanTag.PlayerName:setShaderVector(0, 0.2, 0, 0, 0)
	PlayerNameAndClanTag.PlayerName:setShaderVector(1, 0, 0, 0, 1)
	PlayerNameAndClanTag:linkToElementModel(self, nil, false, function(model)
		PlayerNameAndClanTag:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerNameAndClanTag)
	self.PlayerNameAndClanTag = PlayerNameAndClanTag
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OverheadName_WZ_NameAndNumber.__resetProperties = function(f5_arg0)
	f5_arg0.Image:completeAnimation()
	f5_arg0.Image:setAlpha(1)
end
CoD.OverheadName_WZ_NameAndNumber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	HideNumber = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Image:completeAnimation()
			f7_arg0.Image:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Image)
		end,
	},
}
CoD.OverheadName_WZ_NameAndNumber.__onClose = function(f8_arg0)
	f8_arg0.OverheadNameWZCash:close()
	f8_arg0.Image:close()
	f8_arg0.PlayerNameAndClanTag:close()
end
