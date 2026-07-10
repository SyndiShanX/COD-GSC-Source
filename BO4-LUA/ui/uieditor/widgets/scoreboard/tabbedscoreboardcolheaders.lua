CoD.TabbedScoreboardColHeaders = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardColHeaders.__defaultWidth = 246
CoD.TabbedScoreboardColHeaders.__defaultHeight = 40
CoD.TabbedScoreboardColHeaders.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardColHeaders)
	self.id = "TabbedScoreboardColHeaders"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeftCol = LUI.UIText.new(0, 0, -5, 87, 0.5, 0.5, -9, 6)
	LeftCol:setRGB(0.7, 0.7, 0.7)
	LeftCol:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A75180BC7FDA8F5"))
	LeftCol:setTTF("0arame_mono_stencil")
	LeftCol:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	LeftCol:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(LeftCol)
	self.LeftCol = LeftCol
	local MidCol = LUI.UIText.new(0, 0, 77, 169, 0.5, 0.5, -9, 6)
	MidCol:setRGB(0.7, 0.7, 0.7)
	MidCol:setText("")
	MidCol:setTTF("0arame_mono_stencil")
	MidCol:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MidCol:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(MidCol)
	self.MidCol = MidCol
	local RightCol = LUI.UIText.new(0, 0, 159, 251, 0.5, 0.5, -9, 6)
	RightCol:setRGB(0.7, 0.7, 0.7)
	RightCol:setText("")
	RightCol:setTTF("0arame_mono_stencil")
	RightCol:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RightCol:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(RightCol)
	self.RightCol = RightCol
	local FFACol = LUI.UIText.new(0, 0, 241, 333, 0.5, 0.5, -9, 6)
	FFACol:setRGB(0.7, 0.7, 0.7)
	FFACol:setAlpha(0)
	FFACol:setText("")
	FFACol:setTTF("0arame_mono_stencil")
	FFACol:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FFACol:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(FFACol)
	self.FFACol = FFACol
	self:mergeStateConditions({
		{
			stateName = "VisibleFFA",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES) and not IsGametypeTeambased()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["scoreboardInfo.activeTab"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	if not IsGametypeTeambased() then
		CoD.ScoreboardUtility.SetRowHeader(f1_arg1, self.LeftCol, 0)
		CoD.ScoreboardUtility.SetRowHeader(f1_arg1, self.MidCol, 1)
		CoD.ScoreboardUtility.SetRowHeader(f1_arg1, self.RightCol, 2)
		CoD.ScoreboardUtility.SetRowHeader(f1_arg1, self.FFACol, 3)
	else
		CoD.ScoreboardUtility.SetRowHeader(f1_arg1, self.LeftCol, 0)
		CoD.ScoreboardUtility.SetRowHeader(f1_arg1, self.MidCol, 1)
		CoD.ScoreboardUtility.SetRowHeader(f1_arg1, self.RightCol, 2)
	end
	return self
end
CoD.TabbedScoreboardColHeaders.__resetProperties = function(f5_arg0)
	f5_arg0.LeftCol:completeAnimation()
	f5_arg0.FFACol:completeAnimation()
	f5_arg0.LeftCol:setAlpha(1)
	f5_arg0.FFACol:setAlpha(0)
end
CoD.TabbedScoreboardColHeaders.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.LeftCol:completeAnimation()
			f6_arg0.LeftCol:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.LeftCol)
		end,
	},
	VisibleFFA = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.FFACol:completeAnimation()
			f7_arg0.FFACol:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FFACol)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.TabbedScoreboardColHeaders.__onClose = function(f9_arg0)
	f9_arg0.LeftCol:close()
	f9_arg0.MidCol:close()
	f9_arg0.RightCol:close()
	f9_arg0.FFACol:close()
end
