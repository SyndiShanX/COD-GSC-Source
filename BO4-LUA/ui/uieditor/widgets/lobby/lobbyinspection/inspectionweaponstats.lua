require("x64:c5bb2f76a96c9ce")
CoD.InspectionWeaponStats = InheritFrom(LUI.UIElement)
CoD.InspectionWeaponStats.__defaultWidth = 722
CoD.InspectionWeaponStats.__defaultHeight = 89
CoD.InspectionWeaponStats.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionWeaponStats)
	self.id = "InspectionWeaponStats"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WepaonTotalStat02 = CoD.InspectionPlayerStats.new(f1_arg0, f1_arg1, 0, 0, 174, 374, 0, 0, 0, 89)
	self:addElement(WepaonTotalStat02)
	self.WepaonTotalStat02 = WepaonTotalStat02
	local WepaonTotalStat03 = CoD.InspectionPlayerStats.new(f1_arg0, f1_arg1, 0, 0, 348, 548, 0, 0, 0, 89)
	self:addElement(WepaonTotalStat03)
	self.WepaonTotalStat03 = WepaonTotalStat03
	local WepaonTotalStat04 = CoD.InspectionPlayerStats.new(f1_arg0, f1_arg1, 0, 0, 522, 722, 0, 0, 0, 89)
	self:addElement(WepaonTotalStat04)
	self.WepaonTotalStat04 = WepaonTotalStat04
	local WepaonTotalStat01 = CoD.InspectionPlayerStats.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 0, 0, 0, 89)
	self:addElement(WepaonTotalStat01)
	self.WepaonTotalStat01 = WepaonTotalStat01
	local Divider01 = LUI.UIImage.new(0, 0, 187, 188, 0, 0, 24, 44)
	Divider01:setRGB(0.92, 0.92, 0.92)
	Divider01:setAlpha(0.02)
	self:addElement(Divider01)
	self.Divider01 = Divider01
	local Divider02 = LUI.UIImage.new(0, 0, 361, 362, 0, 0, 24, 44)
	Divider02:setRGB(0.92, 0.92, 0.92)
	Divider02:setAlpha(0.02)
	self:addElement(Divider02)
	self.Divider02 = Divider02
	local Divider03 = LUI.UIImage.new(0, 0, 536, 537, 0, 0, 24, 44)
	Divider03:setRGB(0.92, 0.92, 0.92)
	Divider03:setAlpha(0.02)
	self:addElement(Divider03)
	self.Divider03 = Divider03
	self:mergeStateConditions({
		{
			stateName = "FNF",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestone(f1_arg1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionWeaponStats.__resetProperties = function(f3_arg0)
	f3_arg0.Divider03:completeAnimation()
	f3_arg0.Divider02:completeAnimation()
	f3_arg0.Divider01:completeAnimation()
	f3_arg0.WepaonTotalStat01:completeAnimation()
	f3_arg0.WepaonTotalStat04:completeAnimation()
	f3_arg0.WepaonTotalStat03:completeAnimation()
	f3_arg0.WepaonTotalStat02:completeAnimation()
	f3_arg0.Divider03:setAlpha(0.02)
	f3_arg0.Divider02:setAlpha(0.02)
	f3_arg0.Divider01:setAlpha(0.02)
	f3_arg0.WepaonTotalStat01:setAlpha(1)
	f3_arg0.WepaonTotalStat04:setAlpha(1)
	f3_arg0.WepaonTotalStat03:setAlpha(1)
	f3_arg0.WepaonTotalStat02:setAlpha(1)
end
CoD.InspectionWeaponStats.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	FNF = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(7)
			f5_arg0.WepaonTotalStat02:completeAnimation()
			f5_arg0.WepaonTotalStat02:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WepaonTotalStat02)
			f5_arg0.WepaonTotalStat03:completeAnimation()
			f5_arg0.WepaonTotalStat03:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WepaonTotalStat03)
			f5_arg0.WepaonTotalStat04:completeAnimation()
			f5_arg0.WepaonTotalStat04:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WepaonTotalStat04)
			f5_arg0.WepaonTotalStat01:completeAnimation()
			f5_arg0.WepaonTotalStat01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.WepaonTotalStat01)
			f5_arg0.Divider01:completeAnimation()
			f5_arg0.Divider01:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Divider01)
			f5_arg0.Divider02:completeAnimation()
			f5_arg0.Divider02:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Divider02)
			f5_arg0.Divider03:completeAnimation()
			f5_arg0.Divider03:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Divider03)
		end,
	},
}
CoD.InspectionWeaponStats.__onClose = function(f6_arg0)
	f6_arg0.WepaonTotalStat02:close()
	f6_arg0.WepaonTotalStat03:close()
	f6_arg0.WepaonTotalStat04:close()
	f6_arg0.WepaonTotalStat01:close()
end
