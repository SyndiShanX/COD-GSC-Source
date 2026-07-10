require("x64:98f1288a89a9af6")
require("x64:7fea65b501dd29d")
require("x64:be167ee86fcf99d")
require("x64:16e48ac85df931c")
CoD.DirectorFindGamePlaylistInfoDescriptionPanel = InheritFrom(LUI.UIElement)
CoD.DirectorFindGamePlaylistInfoDescriptionPanel.__defaultWidth = 540
CoD.DirectorFindGamePlaylistInfoDescriptionPanel.__defaultHeight = 535
CoD.DirectorFindGamePlaylistInfoDescriptionPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFindGamePlaylistInfoDescriptionPanel)
	self.id = "DirectorFindGamePlaylistInfoDescriptionPanel"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 1, 0, 0)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local TiledBacking = LUI.UIImage.new(0, 0, 0, 540, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local PlaylistInfo = CoD.DirectorFindGamePlaylistInfoVerticalLayoutMP.new(f1_arg0, f1_arg1, 1, 1, -539, -15, 0, 0, 4, 159)
	PlaylistInfo:linkToElementModel(self, nil, false, function(model)
		PlaylistInfo:setModel(model, f1_arg1)
	end)
	self:addElement(PlaylistInfo)
	self.PlaylistInfo = PlaylistInfo
	local LayoutElementBR2 = LUI.UIImage.new(1, 1, -52, -20, 1, 1, -52, -20)
	LayoutElementBR2:setAlpha(0.2)
	LayoutElementBR2:setZRot(-90)
	LayoutElementBR2:setImage(RegisterImage(0x34B575F15CDD376))
	LayoutElementBR2:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	LayoutElementBR2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(LayoutElementBR2)
	self.LayoutElementBR2 = LayoutElementBR2
	local DoubleXPIcons = CoD.DoubleXPIconsCenterAligned.new(f1_arg0, f1_arg1, 0, 0, 162, 378, 1, 1, -92, -20)
	DoubleXPIcons:setAlpha(0)
	DoubleXPIcons:linkToElementModel(self, nil, false, function(model)
		DoubleXPIcons:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPIcons)
	self.DoubleXPIcons = DoubleXPIcons
	local MissingDLCNotification = CoD.MissingDLCNotification.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 1, 1, -52, -1)
	MissingDLCNotification:linkToElementModel(self, nil, false, function(model)
		MissingDLCNotification:setModel(model, f1_arg1)
	end)
	self:addElement(MissingDLCNotification)
	self.MissingDLCNotification = MissingDLCNotification
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorFindGamePlaylistInfoDescriptionPanel.__onClose = function(f5_arg0)
	f5_arg0.CommonDetailPanel:close()
	f5_arg0.PlaylistInfo:close()
	f5_arg0.DoubleXPIcons:close()
	f5_arg0.MissingDLCNotification:close()
end
