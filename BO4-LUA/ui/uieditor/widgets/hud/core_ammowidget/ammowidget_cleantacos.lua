require("x64:12b4bc8b9d0b461")
CoD.AmmoWidget_CleanTacos = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_CleanTacos.__defaultWidth = 105
CoD.AmmoWidget_CleanTacos.__defaultHeight = 105
CoD.AmmoWidget_CleanTacos.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_CleanTacos)
	self.id = "AmmoWidget_CleanTacos"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backplate = LUI.UIImage.new(0, 0, 15, 107, 0, 0, 20.5, 84.5)
	backplate:setImage(RegisterImage(0xDD08B725AA00DD6))
	self:addElement(backplate)
	self.backplate = backplate
	local TacoImage = LUI.UIImage.new(0, 0, 3, 119, 0, 0, 6.5, 98.5)
	TacoImage:setImage(RegisterImage(0xE964C548DC2ADB7))
	self:addElement(TacoImage)
	self.TacoImage = TacoImage
	local PanelGlow = LUI.UIImage.new(0, 0, -24, 127, 0, 0, -22, 131)
	PanelGlow:setRGB(0.08, 0.17, 0.56)
	PanelGlow:setAlpha(0.9)
	PanelGlow:setImage(RegisterImage(0x5BE416E17DAB33B))
	PanelGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PanelGlow)
	self.PanelGlow = PanelGlow
	local TacoCount = CoD.AmmoWidget_CleanTacosCountText.new(f1_arg0, f1_arg1, 0, 0, 24, 75, 0, 0, 62.5, 78.5)
	TacoCount:subscribeToGlobalModel(f1_arg1, "HUDItems", "cleanCarryCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TacoCount.NumberCount:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(TacoCount)
	self.TacoCount = TacoCount
	self:mergeStateConditions({
		{
			stateName = "Shamrock",
			condition = function(menu, element, event)
				return IsGametypeSettingsValue("enableStPatty", 1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_CleanTacos.__resetProperties = function(f4_arg0)
	f4_arg0.TacoImage:completeAnimation()
	f4_arg0.PanelGlow:completeAnimation()
	f4_arg0.TacoImage:setImage(RegisterImage(0xE964C548DC2ADB7))
	f4_arg0.PanelGlow:setRGB(0.08, 0.17, 0.56)
end
CoD.AmmoWidget_CleanTacos.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Shamrock = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.TacoImage:completeAnimation()
			f6_arg0.TacoImage:setImage(RegisterImage(0x173D4867E8A1E4B))
			f6_arg0.clipFinished(f6_arg0.TacoImage)
			f6_arg0.PanelGlow:completeAnimation()
			f6_arg0.PanelGlow:setRGB(0.08, 0.56, 0.16)
			f6_arg0.clipFinished(f6_arg0.PanelGlow)
		end,
	},
}
CoD.AmmoWidget_CleanTacos.__onClose = function(f7_arg0)
	f7_arg0.TacoCount:close()
end
