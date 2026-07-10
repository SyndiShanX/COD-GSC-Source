require("x64:16a177adf215eab")
require("x64:c6dd2c6b206676f")
require("x64:49a95828346bc1b")
require("x64:40aa7774ab8472c")
require("x64:edc2e1aae07ab05")
CoD.CamoListSelectionWidget = InheritFrom(LUI.UIElement)
CoD.CamoListSelectionWidget.__defaultWidth = 1214
CoD.CamoListSelectionWidget.__defaultHeight = 400
CoD.CamoListSelectionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CamoListSelectionWidget)
	self.id = "CamoListSelectionWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local PaintjobGrid = CoD.PaintjobOptionGrid.new(f1_arg0, f1_arg1, 0, 0, 884, 1154, 0, 0, 25, 375)
	self:addElement(PaintjobGrid)
	self.PaintjobGrid = PaintjobGrid
	local MasteryGrid = CoD.MasteryOptionsContainer.new(f1_arg0, f1_arg1, 0, 0, 673, 878, 0, 0, 25, 375)
	self:addElement(MasteryGrid)
	self.MasteryGrid = MasteryGrid
	local TechnicalGrid = CoD.TechnicalOptionGrid.new(f1_arg0, f1_arg1, 0, 0, 393, 665, 0, 0, 25, 375)
	self:addElement(TechnicalGrid)
	self.TechnicalGrid = TechnicalGrid
	local PerformanceGrid = CoD.PerformanceOptionGrid.new(f1_arg0, f1_arg1, 0, 0, -9, 383, 0, 0, 25, 375)
	PerformanceGrid.Label:setText(LocalizeToUpperString(@"hash_E28A07E0C69E9E9"))
	self:addElement(PerformanceGrid)
	self.PerformanceGrid = PerformanceGrid
	local LootBaseOptionGrid = CoD.LootBaseOptionGrid.new(f1_arg0, f1_arg1, 0, 0, 0, 1214, 0, 0, 24, 374)
	LootBaseOptionGrid:setAlpha(0)
	LootBaseOptionGrid.Label:setText(LocalizeToUpperString(@"hash_3F602F1BAFC731B5"))
	self:addElement(LootBaseOptionGrid)
	self.LootBaseOptionGrid = LootBaseOptionGrid
	self:mergeStateConditions({
		{
			stateName = "NotLive",
			condition = function(menu, element, event)
				return not IsLive()
			end,
		},
		{
			stateName = "BlackMarket",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.IsBlackMarketCamoFilter()
			end,
		},
		{
			stateName = "NotCurrentModeFilter",
			condition = function(menu, element, event)
				return not CoD.WeaponOptionsUtility.IsInCurrentModeFilter(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "TempHideZMMastery",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.ShouldHideMasteryCamos(menu)
			end,
		},
		{
			stateName = "HidePaintjobGrid",
			condition = function(menu, element, event)
				return CoD.WeaponOptionsUtility.ShouldHidePaintjobCamos(menu, f1_arg1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNetworkMode"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["WeaponPersonalization.listUpdate"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "WeaponPersonalization.listUpdate",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f10_arg2, f10_arg3, f10_arg4)
		if IsSelfInState(self, "BlackMarket") then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.LootBaseOptionGrid)
		else
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.PerformanceGrid)
		end
	end)
	PaintjobGrid.id = "PaintjobGrid"
	MasteryGrid.id = "MasteryGrid"
	TechnicalGrid.id = "TechnicalGrid"
	PerformanceGrid.id = "PerformanceGrid"
	LootBaseOptionGrid.id = "LootBaseOptionGrid"
	self.__defaultFocus = PerformanceGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CamoListSelectionWidget.__resetProperties = function(f11_arg0)
	f11_arg0.MasteryGrid:completeAnimation()
	f11_arg0.PaintjobGrid:completeAnimation()
	f11_arg0.TechnicalGrid:completeAnimation()
	f11_arg0.PerformanceGrid:completeAnimation()
	f11_arg0.LootBaseOptionGrid:completeAnimation()
	f11_arg0.MasteryGrid:setAlpha(1)
	f11_arg0.PaintjobGrid:setLeftRight(0, 0, 884, 1154)
	f11_arg0.PaintjobGrid:setAlpha(1)
	f11_arg0.TechnicalGrid:setAlpha(1)
	f11_arg0.PerformanceGrid:setAlpha(1)
	f11_arg0.LootBaseOptionGrid:setAlpha(0)
end
CoD.CamoListSelectionWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	NotLive = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.PaintjobGrid:completeAnimation()
			f13_arg0.PaintjobGrid:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PaintjobGrid)
			f13_arg0.MasteryGrid:completeAnimation()
			f13_arg0.MasteryGrid:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.MasteryGrid)
		end,
	},
	BlackMarket = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.PaintjobGrid:completeAnimation()
			f14_arg0.PaintjobGrid:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PaintjobGrid)
			f14_arg0.MasteryGrid:completeAnimation()
			f14_arg0.MasteryGrid:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.MasteryGrid)
			f14_arg0.TechnicalGrid:completeAnimation()
			f14_arg0.TechnicalGrid:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.TechnicalGrid)
			f14_arg0.PerformanceGrid:completeAnimation()
			f14_arg0.PerformanceGrid:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.PerformanceGrid)
			f14_arg0.LootBaseOptionGrid:completeAnimation()
			f14_arg0.LootBaseOptionGrid:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.LootBaseOptionGrid)
		end,
	},
	NotCurrentModeFilter = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.PaintjobGrid:completeAnimation()
			f15_arg0.PaintjobGrid:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PaintjobGrid)
			f15_arg0.MasteryGrid:completeAnimation()
			f15_arg0.MasteryGrid:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.MasteryGrid)
		end,
	},
	TempHideZMMastery = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.PaintjobGrid:completeAnimation()
			f16_arg0.PaintjobGrid:setLeftRight(0, 0, 698, 968)
			f16_arg0.PaintjobGrid:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.PaintjobGrid)
			f16_arg0.MasteryGrid:completeAnimation()
			f16_arg0.MasteryGrid:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.MasteryGrid)
		end,
	},
	HidePaintjobGrid = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.PaintjobGrid:completeAnimation()
			f17_arg0.PaintjobGrid:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.PaintjobGrid)
		end,
	},
}
CoD.CamoListSelectionWidget.__onClose = function(f18_arg0)
	f18_arg0.PaintjobGrid:close()
	f18_arg0.MasteryGrid:close()
	f18_arg0.TechnicalGrid:close()
	f18_arg0.PerformanceGrid:close()
	f18_arg0.LootBaseOptionGrid:close()
end
