require("x64:1e1a53313536ac3")
CoD.RankUpNotificationTile = InheritFrom(LUI.UIElement)
CoD.RankUpNotificationTile.__defaultWidth = 300
CoD.RankUpNotificationTile.__defaultHeight = 45
CoD.RankUpNotificationTile.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RankUpNotificationTile)
	self.id = "RankUpNotificationTile"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CACvarientTitlePanel0 = CoD.CAC_varientTitlePanel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 45)
	CACvarientTitlePanel0:setAlpha(0.5)
	LUI.OverrideFunction_CallOriginalFirst(CACvarientTitlePanel0, "setText", function(element, controller)
		ScaleWidgetToLabelWrapped(self, element, 0, 0)
	end)
	self:addElement(CACvarientTitlePanel0)
	self.CACvarientTitlePanel0 = CACvarientTitlePanel0
	local Text = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 45)
	Text:setTTF("default")
	Text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Text)
	self.Text = Text
	self.Text:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Text:setText(f3_local0)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.RankUpNotificationTile.__resetProperties = function(f4_arg0)
	f4_arg0.CACvarientTitlePanel0:completeAnimation()
	f4_arg0.CACvarientTitlePanel0:setAlpha(0.5)
end
CoD.RankUpNotificationTile.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CACvarientTitlePanel0:completeAnimation()
			f5_arg0.CACvarientTitlePanel0:setAlpha(0.25)
			f5_arg0.clipFinished(f5_arg0.CACvarientTitlePanel0)
		end,
	},
}
CoD.RankUpNotificationTile.__onClose = function(f6_arg0)
	f6_arg0.CACvarientTitlePanel0:close()
	f6_arg0.Text:close()
end
