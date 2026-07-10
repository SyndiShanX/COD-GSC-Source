CoD.BowLauncherReticle_Dot = InheritFrom(LUI.UIElement)
CoD.BowLauncherReticle_Dot.__defaultWidth = 160
CoD.BowLauncherReticle_Dot.__defaultHeight = 160
CoD.BowLauncherReticle_Dot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BowLauncherReticle_Dot)
	self.id = "BowLauncherReticle_Dot"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CenterDot = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CenterDot:setAlpha(0)
	CenterDot:setImage(RegisterImage(@"uie_bowlauncher_center_dot"))
	self:addElement(CenterDot)
	self.CenterDot = CenterDot
	local dot = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	dot:setImage(RegisterImage(@"uie_ui_hud_reticles_bowlauncher_hipfire_dot"))
	self:addElement(dot)
	self.dot = dot
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThanOrEqualTo(f1_arg1, "CurrentWeapon", "currentShotCharge", 0.9)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.currentShotCharge, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "currentShotCharge",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BowLauncherReticle_Dot.__resetProperties = function(f4_arg0)
	f4_arg0.CenterDot:completeAnimation()
	f4_arg0.dot:completeAnimation()
	f4_arg0.CenterDot:setLeftRight(0, 1, 0, 0)
	f4_arg0.CenterDot:setTopBottom(0, 1, 0, 0)
	f4_arg0.dot:setLeftRight(0, 1, 0, 0)
	f4_arg0.dot:setTopBottom(0, 1, 0, 0)
end
CoD.BowLauncherReticle_Dot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.CenterDot:completeAnimation()
			f5_arg0.CenterDot:setLeftRight(0, 1, 1, -1)
			f5_arg0.CenterDot:setTopBottom(0, 1, 1, -1)
			f5_arg0.clipFinished(f5_arg0.CenterDot)
			f5_arg0.dot:completeAnimation()
			f5_arg0.dot:setLeftRight(0, 1, 0, 0)
			f5_arg0.dot:setTopBottom(0, 1, 0, 0)
			f5_arg0.clipFinished(f5_arg0.dot)
		end,
	},
	Locked = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
