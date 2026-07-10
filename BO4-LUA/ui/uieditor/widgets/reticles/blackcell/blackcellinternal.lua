require("x64:888675f0490913")
require("x64:ac47d277b50b88f")
require("x64:5e9cbf7380a884d")
require("x64:ca0eb707e29487a")
require("x64:e83ff1effe38ef5")
CoD.BlackCellInternal = InheritFrom(LUI.UIElement)
CoD.BlackCellInternal.__defaultWidth = 1920
CoD.BlackCellInternal.__defaultHeight = 1080
CoD.BlackCellInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BlackCellInternal)
	self.id = "BlackCellInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local OverlayBG = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	OverlayBG:setImage(RegisterImage(0x7B025D6C2CA1C9B))
	self:addElement(OverlayBG)
	self.OverlayBG = OverlayBG
	local CenterReticle = CoD.CenterReticle.new(f1_arg0, f1_arg1, 0.5, 0.5, -820, 820, 0.5, 0.5, -371, 371)
	CenterReticle:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(f1_arg1, "CurrentWeapon", "lockedOnEnemy", Enum[0xF041D1802ECFE69][0x86864C292F49B19])
			end,
		},
	})
	local TeamMateLockOn = CenterReticle
	local HorizontalCompassBlackCell = CenterReticle.subscribeToModel
	local Timer = DataSources.CurrentWeapon.getModel(f1_arg1)
	HorizontalCompassBlackCell(TeamMateLockOn, Timer.lockedOnEnemy, function(f3_arg0)
		f1_arg0:updateElementState(CenterReticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lockedOnEnemy",
		})
	end, false)
	CenterReticle:setScale(0.66, 0.66)
	self:addElement(CenterReticle)
	self.CenterReticle = CenterReticle
	HorizontalCompassBlackCell = CoD.HorizontalCompassBlackCell.new(f1_arg0, f1_arg1, 0.5, 0.5, -335, 341, 0, 0, 128, 240)
	self:addElement(HorizontalCompassBlackCell)
	self.HorizontalCompassBlackCell = HorizontalCompassBlackCell
	TeamMateLockOn = CoD.TeamMateLockOn.new(f1_arg0, f1_arg1, 0, 0, 318, 521, 0.5, 0.5, -78, 76)
	self:addElement(TeamMateLockOn)
	self.TeamMateLockOn = TeamMateLockOn
	Timer = CoD.Timer.new(f1_arg0, f1_arg1, 1, 1, -483, -338, 0.5, 0.5, -62, -2)
	Timer:setScale(0.9, 0.9)
	self:addElement(Timer)
	self.Timer = Timer
	local Target = CoD.Target.new(f1_arg0, f1_arg1, 1, 1, -488, -356, 0.5, 0.5, 18, 78)
	Target:setScale(0.9, 0.9)
	self:addElement(Target)
	self.Target = Target
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BlackCellInternal.__onClose = function(f4_arg0)
	f4_arg0.CenterReticle:close()
	f4_arg0.HorizontalCompassBlackCell:close()
	f4_arg0.TeamMateLockOn:close()
	f4_arg0.Timer:close()
	f4_arg0.Target:close()
end
