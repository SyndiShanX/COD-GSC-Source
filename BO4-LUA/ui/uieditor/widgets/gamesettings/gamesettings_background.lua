require("x64:eda152e1d10147a")
require("x64:3e7363f43bb91")
require("x64:3dd43113c4e1bd6")
CoD.GameSettings_Background = InheritFrom(LUI.UIElement)
CoD.GameSettings_Background.__defaultWidth = 1920
CoD.GameSettings_Background.__defaultHeight = 1080
CoD.GameSettings_Background.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_Background)
	self.id = "GameSettings_Background"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local StartMenuBackground0 = CoD.StartMenu_Background.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuBackground0)
	self.StartMenuBackground0 = StartMenuBackground0
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingTint:setRGB(0.09, 0.09, 0.09)
	BackingTint:setAlpha(0.8)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local BackingNoise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingNoise:setAlpha(0.5)
	BackingNoise:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local FEButtonPanelShaderContainer0 = CoD.FE_ButtonPanelShaderContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	FEButtonPanelShaderContainer0:setRGB(0.31, 0.31, 0.31)
	self:addElement(FEButtonPanelShaderContainer0)
	self.FEButtonPanelShaderContainer0 = FEButtonPanelShaderContainer0
	local MenuFrame = CoD.GenericMenuFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_BB7AA7A26F39DFA"))
	MenuFrame:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_Background.__onClose = function(f3_arg0)
	f3_arg0.StartMenuBackground0:close()
	f3_arg0.FEButtonPanelShaderContainer0:close()
	f3_arg0.MenuFrame:close()
end
