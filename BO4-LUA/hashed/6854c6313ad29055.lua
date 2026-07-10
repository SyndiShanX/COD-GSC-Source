CoD.Tcm_Splash = InheritFrom(LUI.UIElement)
CoD.Tcm_Splash.__defaultWidth = 1009
CoD.Tcm_Splash.__defaultHeight = 300
CoD.Tcm_Splash.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tcm_Splash)
	self.id = "Tcm_Splash"
	self.soundSet = "default"
	local EnterTheArenaTextShadow = LUI.UIText.new(0, 0, 4, 1009, 0, 0, 134, 240)
	EnterTheArenaTextShadow:setRGB(0, 0, 0)
	EnterTheArenaTextShadow:setTTF("skorzhen")
	EnterTheArenaTextShadow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	EnterTheArenaTextShadow:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "tcm.active", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnterTheArenaTextShadow:setText(CoD.ZombieUtility.GetTcmTitle(f2_local0))
		end
	end)
	self:addElement(EnterTheArenaTextShadow)
	self.EnterTheArenaTextShadow = EnterTheArenaTextShadow
	local EnterTheArenaText = LUI.UIText.new(0, 0, 0, 1005, 0, 0, 130, 236)
	EnterTheArenaText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EnterTheArenaText:setTTF("skorzhen")
	EnterTheArenaText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	EnterTheArenaText:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "tcm.active", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnterTheArenaText:setText(CoD.ZombieUtility.GetTcmTitle(f3_local0))
		end
	end)
	self:addElement(EnterTheArenaText)
	self.EnterTheArenaText = EnterTheArenaText
	local TcmTextShadow = LUI.UIText.new(0, 0, 186, 823, 0, 0, 260, 297)
	TcmTextShadow:setRGB(0, 0, 0)
	TcmTextShadow:setText(Engine[0xF9F1239CFD921FE](0x2F7BDC1E839FE4F))
	TcmTextShadow:setTTF("default")
	TcmTextShadow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TcmTextShadow)
	self.TcmTextShadow = TcmTextShadow
	local TcmText = LUI.UIText.new(0, 0, 184, 821, 0, 0, 258, 295)
	TcmText:setRGB(ColorSet.ZombiePlayerDown.r, ColorSet.ZombiePlayerDown.g, ColorSet.ZombiePlayerDown.b)
	TcmText:setText(Engine[0xF9F1239CFD921FE](0x2F7BDC1E839FE4F))
	TcmText:setTTF("default")
	TcmText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(TcmText)
	self.TcmText = TcmText
	local Medal = LUI.UIImage.new(0, 0, 438.5, 566.5, 0, 0, 0, 128)
	Medal:setImage(RegisterImage(0x7C4737D3F6488AE))
	self:addElement(Medal)
	self.Medal = Medal
	local DescriptionDivider = LUI.UIImage.new(0.5, 0.5, -352, 348, 0, 0, 247, 249)
	DescriptionDivider:setRGB(ColorSet.ResistanceHigh.r, ColorSet.ResistanceHigh.g, ColorSet.ResistanceHigh.b)
	self:addElement(DescriptionDivider)
	self.DescriptionDivider = DescriptionDivider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Tcm_Splash.__onClose = function(f4_arg0)
	f4_arg0.EnterTheArenaTextShadow:close()
	f4_arg0.EnterTheArenaText:close()
end
