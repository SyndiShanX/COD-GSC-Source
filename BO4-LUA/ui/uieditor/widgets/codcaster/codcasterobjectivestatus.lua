require("x64:95a97da93538517")
require("x64:cf052d7532754d9")
require("x64:5dc6cf80349818a")
require("x64:5972a15b60b6833")
require("x64:c5031fde3726237")
require("x64:8a228085bff138c")
require("x64:6ae8165b7fb8565")
CoD.CodCasterObjectiveStatus = InheritFrom(LUI.UIElement)
CoD.CodCasterObjectiveStatus.__defaultWidth = 520
CoD.CodCasterObjectiveStatus.__defaultHeight = 64
CoD.CodCasterObjectiveStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.CodCasterUtility.InitDataSources(self, f1_arg1)
	self:setClass(CoD.CodCasterObjectiveStatus)
	self.id = "CodCasterObjectiveStatus"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CodCasterObjectiveStatusControl = CoD.CodCasterObjectiveStatusControl.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0.49, 0.49, -48, 16)
	CodCasterObjectiveStatusControl:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsGameTypeEqualToString("control")
			end,
		},
	})
	local CodCasterObjectiveStatusHardpoint = CodCasterObjectiveStatusControl
	local CodCasterObjectiveStatusLifeCount = CodCasterObjectiveStatusControl.subscribeToModel
	local CodCasterObjectiveStatusSD = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatusLifeCount(CodCasterObjectiveStatusHardpoint, CodCasterObjectiveStatusSD["hudItems.codcaster.ObjectiveB.progress"], function(f3_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatusControl, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.codcaster.ObjectiveB.progress",
		})
	end, false)
	CodCasterObjectiveStatusHardpoint = CodCasterObjectiveStatusControl
	CodCasterObjectiveStatusLifeCount = CodCasterObjectiveStatusControl.subscribeToModel
	CodCasterObjectiveStatusSD = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatusLifeCount(CodCasterObjectiveStatusHardpoint, CodCasterObjectiveStatusSD["hudItems.codcaster.ObjectiveA.progress"], function(f4_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatusControl, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.codcaster.ObjectiveA.progress",
		})
	end, false)
	self:addElement(CodCasterObjectiveStatusControl)
	self.CodCasterObjectiveStatusControl = CodCasterObjectiveStatusControl
	CodCasterObjectiveStatusLifeCount = CoD.CodCasterObjectiveStatusLifeCount.new(f1_arg0, f1_arg1, 0.5, 0.5, -260, 260, 0.5, 0.5, 4, 36)
	self:addElement(CodCasterObjectiveStatusLifeCount)
	self.CodCasterObjectiveStatusLifeCount = CodCasterObjectiveStatusLifeCount
	CodCasterObjectiveStatusHardpoint = CoD.CodCasterObjectiveStatusHardpoint.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0.5, 0.5, -48, 16)
	CodCasterObjectiveStatusHardpoint:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsGameTypeEqualToString("koth")
			end,
		},
	})
	self:addElement(CodCasterObjectiveStatusHardpoint)
	self.CodCasterObjectiveStatusHardpoint = CodCasterObjectiveStatusHardpoint
	CodCasterObjectiveStatusSD = CoD.CodCasterObjectiveStatusSD.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0.49, 0.49, -48, 16)
	CodCasterObjectiveStatusSD:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsGameTypeEqualToString("sd")
			end,
		},
	})
	local CodCasterObjectiveStatusCTF = CodCasterObjectiveStatusSD
	local CodCasterObjectiveStatusDomination = CodCasterObjectiveStatusSD.subscribeToModel
	local CodCasterObjectiveStatusSafeGuard = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatusDomination(CodCasterObjectiveStatusCTF, CodCasterObjectiveStatusSafeGuard["HUDItems.codcaster.BombA"], function(f7_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatusSD, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "HUDItems.codcaster.BombA",
		})
	end, false)
	CodCasterObjectiveStatusCTF = CodCasterObjectiveStatusSD
	CodCasterObjectiveStatusDomination = CodCasterObjectiveStatusSD.subscribeToModel
	CodCasterObjectiveStatusSafeGuard = Engine[0x4DF5CFBC1771947](f1_arg1)
	CodCasterObjectiveStatusDomination(CodCasterObjectiveStatusCTF, CodCasterObjectiveStatusSafeGuard["HUDItems.codcaster.BombB"], function(f8_arg0)
		f1_arg0:updateElementState(CodCasterObjectiveStatusSD, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "HUDItems.codcaster.BombB",
		})
	end, false)
	self:addElement(CodCasterObjectiveStatusSD)
	self.CodCasterObjectiveStatusSD = CodCasterObjectiveStatusSD
	CodCasterObjectiveStatusDomination = CoD.CodCasterObjectiveStatusDomination.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0.44, 0.44, -48, 16)
	CodCasterObjectiveStatusDomination:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsGameTypeEqualToString("dom")
			end,
		},
	})
	self:addElement(CodCasterObjectiveStatusDomination)
	self.CodCasterObjectiveStatusDomination = CodCasterObjectiveStatusDomination
	CodCasterObjectiveStatusCTF = CoD.CodCasterObjectiveStatusCTF.new(f1_arg0, f1_arg1, 0.5, 0.5, -206, 206, 0.5, 0.5, -38, 26)
	CodCasterObjectiveStatusCTF:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsGameTypeEqualToString("ctf")
			end,
		},
	})
	self:addElement(CodCasterObjectiveStatusCTF)
	self.CodCasterObjectiveStatusCTF = CodCasterObjectiveStatusCTF
	CodCasterObjectiveStatusSafeGuard = CoD.CodCasterObjectiveStatusSafeGuard.new(f1_arg0, f1_arg1, 0, 0, 178, 342, 0, 0, -8.5, 35.5)
	CodCasterObjectiveStatusSafeGuard:mergeStateConditions({
		{
			stateName = "HiddenCodcaster",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsGameTypeEqualToString("escort")
			end,
		},
	})
	CodCasterObjectiveStatusSafeGuard:setScale(0.5, 0.5)
	self:addElement(CodCasterObjectiveStatusSafeGuard)
	self.CodCasterObjectiveStatusSafeGuard = CodCasterObjectiveStatusSafeGuard
	self.__on_menuOpened_self = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		local f12_local0 = self
		UpdateSelfElementState(f12_arg2, self.CodCasterObjectiveStatusSD, f12_arg1)
		UpdateSelfElementState(f12_arg2, self.CodCasterObjectiveStatusHardpoint, f12_arg1)
		UpdateSelfElementState(f12_arg2, self.CodCasterObjectiveStatusControl, f12_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterObjectiveStatus.__resetProperties = function(f14_arg0)
	f14_arg0.CodCasterObjectiveStatusSD:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusHardpoint:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusControl:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusLifeCount:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusDomination:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusCTF:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusSafeGuard:completeAnimation()
	f14_arg0.CodCasterObjectiveStatusSD:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusHardpoint:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusControl:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusLifeCount:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusDomination:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusCTF:setAlpha(1)
	f14_arg0.CodCasterObjectiveStatusSafeGuard:setAlpha(1)
end
CoD.CodCasterObjectiveStatus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.CodCasterObjectiveStatusControl:completeAnimation()
			f15_arg0.CodCasterObjectiveStatusControl:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CodCasterObjectiveStatusControl)
			f15_arg0.CodCasterObjectiveStatusLifeCount:completeAnimation()
			f15_arg0.CodCasterObjectiveStatusLifeCount:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CodCasterObjectiveStatusLifeCount)
			f15_arg0.CodCasterObjectiveStatusHardpoint:completeAnimation()
			f15_arg0.CodCasterObjectiveStatusHardpoint:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CodCasterObjectiveStatusHardpoint)
			f15_arg0.CodCasterObjectiveStatusSD:completeAnimation()
			f15_arg0.CodCasterObjectiveStatusSD:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CodCasterObjectiveStatusSD)
			f15_arg0.CodCasterObjectiveStatusDomination:completeAnimation()
			f15_arg0.CodCasterObjectiveStatusDomination:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CodCasterObjectiveStatusDomination)
			f15_arg0.CodCasterObjectiveStatusCTF:completeAnimation()
			f15_arg0.CodCasterObjectiveStatusCTF:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CodCasterObjectiveStatusCTF)
			f15_arg0.CodCasterObjectiveStatusSafeGuard:completeAnimation()
			f15_arg0.CodCasterObjectiveStatusSafeGuard:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CodCasterObjectiveStatusSafeGuard)
		end,
	},
	Visible = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CodCasterObjectiveStatus.__onClose = function(f17_arg0)
	f17_arg0.__on_close_removeOverrides()
	f17_arg0.CodCasterObjectiveStatusControl:close()
	f17_arg0.CodCasterObjectiveStatusLifeCount:close()
	f17_arg0.CodCasterObjectiveStatusHardpoint:close()
	f17_arg0.CodCasterObjectiveStatusSD:close()
	f17_arg0.CodCasterObjectiveStatusDomination:close()
	f17_arg0.CodCasterObjectiveStatusCTF:close()
	f17_arg0.CodCasterObjectiveStatusSafeGuard:close()
end
