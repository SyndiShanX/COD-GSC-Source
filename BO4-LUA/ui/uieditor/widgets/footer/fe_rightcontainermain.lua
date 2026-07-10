require("x64:9d0474cb8fa24b1")
CoD.fe_RightContainerMain = InheritFrom(LUI.UIElement)
CoD.fe_RightContainerMain.__defaultWidth = 1305
CoD.fe_RightContainerMain.__defaultHeight = 48
CoD.fe_RightContainerMain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 50, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.fe_RightContainerMain)
	self.id = "fe_RightContainerMain"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Image0 = LUI.UIImage.new(0, 0, 1301, 1305, 0, 0, -54, 138)
	Image0:setAlpha(0)
	self:addElement(Image0)
	self.Image0 = Image0
	local Username = LUI.UIText.new(0, 0, 555, 1065, 1, 1, -40, -13)
	Username:setText(GetFirstSignedInController())
	Username:setTTF("ttmussels_regular")
	Username:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Username)
	self.Username = Username
	local feFooterButtonPromptWithContainer0 = CoD.fe_FooterButtonPromptWithContainerMain.new(f1_arg0, f1_arg1, 0, 0, 1115, 1251, 1, 1, -72.5, 19.5)
	feFooterButtonPromptWithContainer0.label:setText(LocalizeToUpperString(0xC2DF00C35019DD3))
	feFooterButtonPromptWithContainer0:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			feFooterButtonPromptWithContainer0.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	feFooterButtonPromptWithContainer0:linkToElementModel(self, "" .. Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], false, function(model)
		feFooterButtonPromptWithContainer0:setModel(model, f1_arg1)
	end)
	self:addElement(feFooterButtonPromptWithContainer0)
	self.feFooterButtonPromptWithContainer0 = feFooterButtonPromptWithContainer0
	feFooterButtonPromptWithContainer0.id = "feFooterButtonPromptWithContainer0"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.LobbyUtility.SetTextToDurangoSignedInString(self, Username)
	return self
end
CoD.fe_RightContainerMain.__onClose = function(f4_arg0)
	f4_arg0.Username:close()
	f4_arg0.feFooterButtonPromptWithContainer0:close()
end
