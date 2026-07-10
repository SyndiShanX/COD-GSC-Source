require("x64:e6338256b3eb635")
require("x64:acbf06924421e35")
require("x64:a24b28b508f6914")
CoD.SpecialistHeadquartersDossierProgress = InheritFrom(LUI.UIElement)
CoD.SpecialistHeadquartersDossierProgress.__defaultWidth = 800
CoD.SpecialistHeadquartersDossierProgress.__defaultHeight = 200
CoD.SpecialistHeadquartersDossierProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistHeadquartersDossierProgress)
	self.id = "SpecialistHeadquartersDossierProgress"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.2)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 800, 0, 0, 0, 200)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DossierProgress = LUI.UIText.new(0, 0, 10, 785, 0, 0, 5, 32)
	DossierProgress:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DossierProgress:setText(LocalizeToUpperString(@"hash_2328824525DBC0EA"))
	DossierProgress:setTTF("ttmussels_demibold")
	DossierProgress:setLetterSpacing(6)
	DossierProgress:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(DossierProgress)
	self.DossierProgress = DossierProgress
	local DossierProgressBulletPoint1 = CoD.DossierProgressBulletPoint.new(f1_arg0, f1_arg1, 0, 0, 10, 260, 0, 0, 49, 79)
	DossierProgressBulletPoint1:mergeStateConditions({
		{
			stateName = "CheckedKR15",
			condition = function(menu, element, event)
				local f2_local0 = IsPC()
				if f2_local0 then
					f2_local0 = CoD.PCKoreaUtility.ShowKorea15Plus()
					if f2_local0 then
						f2_local0 = CoD.BaseUtility.IsSelfInEitherState(self, "FinishedTutorialKR15", "CompletedKR15")
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInEitherState(self, "FinishedTutorial", "Completed")
			end,
		},
	})
	DossierProgressBulletPoint1.DossierProgressBulletPoint:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6271C65C6D7CABDA"))
	self:addElement(DossierProgressBulletPoint1)
	self.DossierProgressBulletPoint1 = DossierProgressBulletPoint1
	local DossierProgressBulletPoint3 = CoD.DossierProgressBulletPoint.new(f1_arg0, f1_arg1, 0, 0, 10, 260, 0, 0, 127, 157)
	DossierProgressBulletPoint3:mergeStateConditions({
		{
			stateName = "CheckedKR15",
			condition = function(menu, element, event)
				local f4_local0 = IsPC()
				if f4_local0 then
					f4_local0 = CoD.PCKoreaUtility.ShowKorea15Plus()
					if f4_local0 then
						f4_local0 = CoD.BaseUtility.IsSelfInState(self, "CompletedKR15")
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "Completed")
			end,
		},
	})
	DossierProgressBulletPoint3.DossierProgressBulletPoint:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6271C45C6D7CA874"))
	self:addElement(DossierProgressBulletPoint3)
	self.DossierProgressBulletPoint3 = DossierProgressBulletPoint3
	local DossierProgressBulletPoint2 = CoD.DossierProgressBulletPoint.new(f1_arg0, f1_arg1, 0, 0, 10, 260, 0, 0, 88, 118)
	DossierProgressBulletPoint2:mergeStateConditions({
		{
			stateName = "CheckedKR15",
			condition = function(menu, element, event)
				local f6_local0 = IsPC()
				if f6_local0 then
					f6_local0 = CoD.PCKoreaUtility.ShowKorea15Plus()
					if f6_local0 then
						f6_local0 = CoD.BaseUtility.IsSelfInEitherState(self, "FinishedTutorialKR15", "CompletedKR15")
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "Checked",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInEitherState(self, "FinishedTutorial", "Completed")
			end,
		},
	})
	DossierProgressBulletPoint2.DossierProgressBulletPoint:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6271C55C6D7CAA27"))
	self:addElement(DossierProgressBulletPoint2)
	self.DossierProgressBulletPoint2 = DossierProgressBulletPoint2
	local Complete = LUI.UIText.new(0, 0, 15, 790, 0, 0, 165, 195)
	Complete:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	Complete:setAlpha(0)
	Complete:setText(LocalizeToUpperString(@"menu/complete"))
	Complete:setTTF("ttmussels_regular")
	Complete:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Complete)
	self.Complete = Complete
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonCornerPips:setAlpha(0.2)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_arg0, f1_arg1, 0, 0, 678, 790, 0, 0, 180, 196)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	local DividerSolidBot = LUI.UIImage.new(0, 0, 12, 790, 0, 0, 35, 43)
	DividerSolidBot:setAlpha(0.2)
	DividerSolidBot:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	DividerSolidBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DividerSolidBot:setShaderVector(0, 0, 0, 0, 0)
	DividerSolidBot:setupNineSliceShader(16, 8)
	self:addElement(DividerSolidBot)
	self.DividerSolidBot = DividerSolidBot
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "CompletedKR15",
			condition = function(menu, element, event)
				local f9_local0 = IsPC()
				if f9_local0 then
					f9_local0 = CoD.PCKoreaUtility.ShowKorea15Plus()
					if f9_local0 then
						f9_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "complete")
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "complete")
			end,
		},
		{
			stateName = "FinishedTutorialKR15",
			condition = function(menu, element, event)
				local f11_local0 = IsPC()
				if f11_local0 then
					f11_local0 = CoD.PCKoreaUtility.ShowKorea15Plus()
					if f11_local0 then
						f11_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "finishedTutorial")
					end
				end
				return f11_local0
			end,
		},
		{
			stateName = "FinishedTutorial",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "finishedTutorial")
			end,
		},
		{
			stateName = "DefaultStateKR15",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.ShowKorea15Plus()
			end,
		},
	})
	self:linkToElementModel(self, "complete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	self:linkToElementModel(self, "finishedTutorial", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "finishedTutorial",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f16_arg2, f16_arg3, f16_arg4)
		UpdateElementState(self, "DossierProgressBulletPoint1", controller)
		UpdateElementState(self, "DossierProgressBulletPoint2", controller)
		UpdateElementState(self, "DossierProgressBulletPoint3", controller)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistHeadquartersDossierProgress.__resetProperties = function(f17_arg0)
	f17_arg0.Complete:completeAnimation()
	f17_arg0.DossierProgressBulletPoint3:completeAnimation()
	f17_arg0.DossierProgressBulletPoint2:completeAnimation()
	f17_arg0.DossierProgressBulletPoint1:completeAnimation()
	f17_arg0.DossierProgress:completeAnimation()
	f17_arg0.Backing:completeAnimation()
	f17_arg0.NoiseTiledBacking:completeAnimation()
	f17_arg0.TabbedScoreboardFuiBox:completeAnimation()
	f17_arg0.DividerSolidBot:completeAnimation()
	f17_arg0.Complete:setAlpha(0)
	f17_arg0.DossierProgressBulletPoint3:setTopBottom(0, 0, 127, 157)
	f17_arg0.DossierProgressBulletPoint3:setAlpha(1)
	f17_arg0.DossierProgressBulletPoint2:setAlpha(1)
	f17_arg0.DossierProgressBulletPoint1:setAlpha(1)
	f17_arg0.DossierProgress:setAlpha(1)
	f17_arg0.Backing:setAlpha(0.2)
	f17_arg0.NoiseTiledBacking:setAlpha(0.5)
	f17_arg0.TabbedScoreboardFuiBox:setAlpha(1)
	f17_arg0.DividerSolidBot:setAlpha(0.2)
end
CoD.SpecialistHeadquartersDossierProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(9)
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Backing)
			f19_arg0.NoiseTiledBacking:completeAnimation()
			f19_arg0.NoiseTiledBacking:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.NoiseTiledBacking)
			f19_arg0.DossierProgress:completeAnimation()
			f19_arg0.DossierProgress:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DossierProgress)
			f19_arg0.DossierProgressBulletPoint1:completeAnimation()
			f19_arg0.DossierProgressBulletPoint1:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DossierProgressBulletPoint1)
			f19_arg0.DossierProgressBulletPoint3:completeAnimation()
			f19_arg0.DossierProgressBulletPoint3:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DossierProgressBulletPoint3)
			f19_arg0.DossierProgressBulletPoint2:completeAnimation()
			f19_arg0.DossierProgressBulletPoint2:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DossierProgressBulletPoint2)
			f19_arg0.Complete:completeAnimation()
			f19_arg0.Complete:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Complete)
			f19_arg0.TabbedScoreboardFuiBox:completeAnimation()
			f19_arg0.TabbedScoreboardFuiBox:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TabbedScoreboardFuiBox)
			f19_arg0.DividerSolidBot:completeAnimation()
			f19_arg0.DividerSolidBot:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.DividerSolidBot)
		end,
	},
	CompletedKR15 = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.DossierProgressBulletPoint3:completeAnimation()
			f20_arg0.DossierProgressBulletPoint3:setTopBottom(0, 0, 88, 118)
			f20_arg0.clipFinished(f20_arg0.DossierProgressBulletPoint3)
			f20_arg0.DossierProgressBulletPoint2:completeAnimation()
			f20_arg0.DossierProgressBulletPoint2:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DossierProgressBulletPoint2)
			f20_arg0.Complete:completeAnimation()
			f20_arg0.Complete:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.Complete)
		end,
	},
	Completed = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.Complete:completeAnimation()
			f21_arg0.Complete:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Complete)
		end,
	},
	FinishedTutorialKR15 = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.DossierProgressBulletPoint3:completeAnimation()
			f22_arg0.DossierProgressBulletPoint3:setTopBottom(0, 0, 88, 118)
			f22_arg0.clipFinished(f22_arg0.DossierProgressBulletPoint3)
			f22_arg0.DossierProgressBulletPoint2:completeAnimation()
			f22_arg0.DossierProgressBulletPoint2:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.DossierProgressBulletPoint2)
		end,
	},
	FinishedTutorial = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStateKR15 = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.DossierProgressBulletPoint3:completeAnimation()
			f24_arg0.DossierProgressBulletPoint3:setTopBottom(0, 0, 88, 118)
			f24_arg0.clipFinished(f24_arg0.DossierProgressBulletPoint3)
			f24_arg0.DossierProgressBulletPoint2:completeAnimation()
			f24_arg0.DossierProgressBulletPoint2:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DossierProgressBulletPoint2)
		end,
	},
}
CoD.SpecialistHeadquartersDossierProgress.__onClose = function(f25_arg0)
	f25_arg0.DossierProgressBulletPoint1:close()
	f25_arg0.DossierProgressBulletPoint3:close()
	f25_arg0.DossierProgressBulletPoint2:close()
	f25_arg0.CommonCornerPips:close()
	f25_arg0.TabbedScoreboardFuiBox:close()
end
