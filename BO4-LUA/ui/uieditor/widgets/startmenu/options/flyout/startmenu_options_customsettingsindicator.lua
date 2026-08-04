CoD.StartMenu_Options_CustomSettingsIndicator = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_CustomSettingsIndicator.__defaultWidth = 15
CoD.StartMenu_Options_CustomSettingsIndicator.__defaultHeight = 100
CoD.StartMenu_Options_CustomSettingsIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("GametypeSettings.Update")
	self:setClass(CoD.StartMenu_Options_CustomSettingsIndicator)
	self.id = "StartMenu_Options_CustomSettingsIndicator"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.84, 0.47, 0.17)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local Base = LUI.UIImage.new(-0.83, 1.83, 0, 0, -0.04, 1.04, 0, 0)
	Base:setRGB(0.84, 0.47, 0.17)
	Base:setImage(RegisterImage("uie_ui_menu_customgame_indicator"))
	Base:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	Base:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(Base)
	self.Base = Base
	local Focus = LUI.UIImage.new(-0.83, 1.83, 0, 0, -0.04, 1.04, 0, 0)
	Focus:setRGB(0.84, 0.47, 0.17)
	Focus:setAlpha(0)
	Focus:setImage(RegisterImage("uie_ui_menu_customgame_indicator_focused"))
	Focus:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Focus:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Focus)
	self.Focus = Focus
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_CustomSettingsIndicator.__resetProperties = function(f2_arg0)
	f2_arg0.Backing:completeAnimation()
	f2_arg0.Base:completeAnimation()
	f2_arg0.Focus:completeAnimation()
	f2_arg0.Backing:setAlpha(0)
	f2_arg0.Base:setAlpha(1)
	f2_arg0.Focus:setAlpha(0)
end
CoD.StartMenu_Options_CustomSettingsIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Backing:completeAnimation()
			f3_arg0.Backing:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Backing)
			f3_arg0.Base:completeAnimation()
			f3_arg0.Base:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Base)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Base:completeAnimation()
			f4_arg0.Base:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Base)
			f4_arg0.Focus:completeAnimation()
			f4_arg0.Focus:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Focus)
		end,
	},
}
