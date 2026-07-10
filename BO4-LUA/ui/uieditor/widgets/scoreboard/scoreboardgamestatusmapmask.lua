require("x64:1bf9bc8c9454687")
CoD.ScoreboardGameStatusMapMask = InheritFrom(LUI.UIElement)
CoD.ScoreboardGameStatusMapMask.__defaultWidth = 1000
CoD.ScoreboardGameStatusMapMask.__defaultHeight = 490
CoD.ScoreboardGameStatusMapMask.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardGameStatusMapMask)
	self.id = "ScoreboardGameStatusMapMask"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScoreboardGameStatusMap = CoD.ScoreboardGameStatusMap.new(f1_arg0, f1_arg1, 0, 0, 0, 1000, 0, 0, -36.5, 526.5)
	ScoreboardGameStatusMap:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_5C212964B40FA826"))
	self:addElement(ScoreboardGameStatusMap)
	self.ScoreboardGameStatusMap = ScoreboardGameStatusMap
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_MAP)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["scoreboardInfo.activeTab"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
CoD.ScoreboardGameStatusMapMask.__resetProperties = function(f4_arg0)
	f4_arg0.ScoreboardGameStatusMap:completeAnimation()
	f4_arg0.ScoreboardGameStatusMap:setAlpha(1)
end
CoD.ScoreboardGameStatusMapMask.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ScoreboardGameStatusMap:completeAnimation()
			f5_arg0.ScoreboardGameStatusMap:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ScoreboardGameStatusMap)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ScoreboardGameStatusMap:completeAnimation()
			f6_arg0.ScoreboardGameStatusMap:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.ScoreboardGameStatusMap)
		end,
	},
}
CoD.ScoreboardGameStatusMapMask.__onClose = function(f7_arg0)
	f7_arg0.ScoreboardGameStatusMap:close()
end
