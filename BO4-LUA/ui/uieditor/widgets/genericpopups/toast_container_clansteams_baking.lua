require("ui/uieditor/widgets/genericpopups/loot_bonustoastgenericbacking")
CoD.Toast_Container_ClansTeams_Baking = InheritFrom(LUI.UIElement)
CoD.Toast_Container_ClansTeams_Baking.__defaultWidth = 340
CoD.Toast_Container_ClansTeams_Baking.__defaultHeight = 80
CoD.Toast_Container_ClansTeams_Baking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Toast_Container_ClansTeams_Baking)
	self.id = "Toast_Container_ClansTeams_Baking"
	self.soundSet = "default"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local ToastBacking = CoD.Loot_BonusToastGenericBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ToastBacking:setRGB(ColorSet.SelectedGreen.r, ColorSet.SelectedGreen.g, ColorSet.SelectedGreen.b)
	self:addElement(ToastBacking)
	self.ToastBacking = ToastBacking
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Toast_Container_ClansTeams_Baking.__onClose = function(f2_arg0)
	f2_arg0.ToastBacking:close()
end
