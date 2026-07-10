require("x64:3d3abfba105a95")
require("x64:978e56ada3acd1c")
require("x64:4565d12133afcc3")
require("x64:d93d55bb6418607")
CoD.PC_Achievements = InheritFrom(LUI.UIElement)
CoD.PC_Achievements.__defaultWidth = 1920
CoD.PC_Achievements.__defaultHeight = 780
CoD.PC_Achievements.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Achievements)
	self.id = "PC_Achievements"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backer:setRGB(0.67, 0.67, 0.67)
	Backer:setAlpha(0.02)
	self:addElement(Backer)
	self.Backer = Backer
	local Border = LUI.UIImage.new(0, 1, -72, 72, 0.5, 0.5, -360, 360)
	Border:setRGB(0.8, 0.76, 0.7)
	Border:setAlpha(0.03)
	Border:setImage(RegisterImage(@"uie_highlight_border_line"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(6, 6)
	self:addElement(Border)
	self.Border = Border
	local AchievementList = CoD.PC_VScrollList.new(f1_arg0, f1_arg1, 0.5, 0.5, -862, 158, 0.5, 0.5, -360, 360)
	AchievementList:mergeStateConditions({
		{
			stateName = "ClipToList",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	AchievementList.ScrollView.View:setWidgetType(CoD.PC_Achievement)
	AchievementList.ScrollView.View:setVerticalCount(102)
	AchievementList.ScrollView.View:setSpacing(-12)
	AchievementList.ScrollView.View:setDataSource("PCAchievement")
	LUI.OverrideFunction_CallOriginalFirst(AchievementList, "setModel", function(element, controller)
		CoD.PCAchievementsUtility.PrepareAchievementProgressBar(f1_arg1, controller, self.DetailView)
	end)
	self:addElement(AchievementList)
	self.AchievementList = AchievementList
	local DetailView = CoD.PC_AchievementDetailView.new(f1_arg0, f1_arg1, 0.5, 0.5, 217, 705, 0.5, 0.5, -316.5, 316.5)
	DetailView:mergeStateConditions({
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.PCAchievementsUtility.IsAchievementCompleted(self.AchievementList, f1_arg1)
			end,
		},
	})
	DetailView:linkToElementModel(DetailView, "refreshWidget", true, function(model)
		f1_arg0:updateElementState(DetailView, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refreshWidget",
		})
	end)
	DetailView:appendEventHandler("<datasourceChange>PCAchievement", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DetailView, f6_arg1)
	end)
	self:addElement(DetailView)
	self.DetailView = DetailView
	local TotalPoints = CoD.PC_Achievements_TotalPoints.new(f1_arg0, f1_arg1, 0.5, 0.5, 365, 704, 0, 0, 790, 819)
	self:addElement(TotalPoints)
	self.TotalPoints = TotalPoints
	DetailView:linkToElementModel(AchievementList.ScrollView.View, nil, false, function(model)
		DetailView:setModel(model, f1_arg1)
	end)
	DetailView:linkToElementModel(AchievementList.ScrollView.View, "progressBarRatio", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DetailView.ProgressBar.ProgressBarFiller:setShaderVector(0, CoD.GetVectorComponentFromString(f8_local0, 1), CoD.GetVectorComponentFromString(f8_local0, 2), CoD.GetVectorComponentFromString(f8_local0, 3), CoD.GetVectorComponentFromString(f8_local0, 4))
		end
	end)
	DetailView:linkToElementModel(AchievementList.ScrollView.View, "currentValue", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			DetailView.CurrentProgressValue:setText(f9_local0)
		end
	end)
	DetailView:linkToElementModel(AchievementList.ScrollView.View, "maxValue", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			DetailView.TotalProgressValue:setText(f10_local0)
		end
	end)
	DetailView:linkToElementModel(AchievementList.ScrollView.View, "image", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DetailView.AchievementIcon:setImage(RegisterImage(f11_local0))
		end
	end)
	DetailView:linkToElementModel(AchievementList.ScrollView.View, "name", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			DetailView.Description.Name:setText(LocalizeToUpperString(f12_local0))
		end
	end)
	DetailView:linkToElementModel(AchievementList.ScrollView.View, "desc", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			DetailView.Description.Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f13_local0))
		end
	end)
	DetailView:linkToElementModel(AchievementList.ScrollView.View, "score", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			DetailView.Points.ScoreValue:setText(f14_local0)
		end
	end)
	AchievementList.id = "AchievementList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	SizeToWidthOfScreen(Backer, f1_arg1)
	SizeToWidthOfScreen(Border, f1_arg1)
	CoD.PCWidgetUtility.SetMouseWheelScrollUnit(AchievementList, 75)
	return self
end
CoD.PC_Achievements.__resetProperties = function(f15_arg0)
	f15_arg0.AchievementList:completeAnimation()
	f15_arg0.DetailView:completeAnimation()
	f15_arg0.TotalPoints:completeAnimation()
	f15_arg0.AchievementList:setAlpha(1)
	f15_arg0.DetailView:setAlpha(1)
	f15_arg0.TotalPoints:setAlpha(1)
end
CoD.PC_Achievements.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_both"])
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.AchievementList:beginAnimation(50)
				f16_arg0.AchievementList:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.AchievementList:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.AchievementList:completeAnimation()
			f16_arg0.AchievementList:setAlpha(0)
			f16_local0(f16_arg0.AchievementList)
			local f16_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(149, Enum[@"luitween"][@"luitween_ease_both"])
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.DetailView:beginAnimation(300)
				f16_arg0.DetailView:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.DetailView:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f16_arg0.DetailView:completeAnimation()
			f16_arg0.DetailView:setAlpha(0)
			f16_local1(f16_arg0.DetailView)
			local f16_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(139, Enum[@"luitween"][@"luitween_ease_both"])
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.TotalPoints:beginAnimation(500)
				f16_arg0.TotalPoints:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.TotalPoints:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f16_arg0.TotalPoints:completeAnimation()
			f16_arg0.TotalPoints:setAlpha(0)
			f16_local2(f16_arg0.TotalPoints)
		end,
	},
}
CoD.PC_Achievements.__onClose = function(f23_arg0)
	f23_arg0.DetailView:close()
	f23_arg0.Backer:close()
	f23_arg0.Border:close()
	f23_arg0.AchievementList:close()
	f23_arg0.TotalPoints:close()
end
