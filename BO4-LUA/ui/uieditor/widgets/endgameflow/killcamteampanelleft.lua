CoD.KIllcamTeamPanelLeft = InheritFrom(LUI.UIElement)
CoD.KIllcamTeamPanelLeft.__defaultWidth = 444
CoD.KIllcamTeamPanelLeft.__defaultHeight = 69
CoD.KIllcamTeamPanelLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.KIllcamTeamPanelLeft)
	self.id = "KIllcamTeamPanelLeft"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BottomBackplateLeft = LUI.UIImage.new(0, 0, 0, 386, 0, 0, 0.5, 68.5)
	BottomBackplateLeft:setAlpha(0)
	BottomBackplateLeft:setZRot(180)
	BottomBackplateLeft:setImage(RegisterImage(@"hash_5C87BEF5640733AB"))
	self:addElement(BottomBackplateLeft)
	self.BottomBackplateLeft = BottomBackplateLeft
	local CallingCardHighlightLeft1 = LUI.UIImage.new(0, 0, 50, 436, 0, 0, 0, 68)
	CallingCardHighlightLeft1:setRGB(ColorSet.EnemyScorestreakTarget.r, ColorSet.EnemyScorestreakTarget.g, ColorSet.EnemyScorestreakTarget.b)
	CallingCardHighlightLeft1:setAlpha(0.5)
	CallingCardHighlightLeft1:setZRot(180)
	CallingCardHighlightLeft1:setImage(RegisterImage(@"uie_ui_hud_highlight2"))
	CallingCardHighlightLeft1:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(CallingCardHighlightLeft1)
	self.CallingCardHighlightLeft1 = CallingCardHighlightLeft1
	local CallingCardGridPatternLeft = LUI.UIImage.new(0, 0, -4, 382, 0, 0, 0.5, 68.5)
	CallingCardGridPatternLeft:setRGB(0.65, 0.02, 0.02)
	CallingCardGridPatternLeft:setZRot(180)
	CallingCardGridPatternLeft:setImage(RegisterImage(@"hash_1684DCF03A2BF70F"))
	CallingCardGridPatternLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	CallingCardGridPatternLeft:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(CallingCardGridPatternLeft)
	self.CallingCardGridPatternLeft = CallingCardGridPatternLeft
	local CallingCardHighlightLeft2 = LUI.UIImage.new(0, 0, 58, 444, 0, 0, 0.5, 68.5)
	CallingCardHighlightLeft2:setRGB(0.74, 0.02, 0.02)
	CallingCardHighlightLeft2:setAlpha(0.8)
	CallingCardHighlightLeft2:setZRot(180)
	CallingCardHighlightLeft2:setImage(RegisterImage(@"uie_ui_hud_highlight"))
	self:addElement(CallingCardHighlightLeft2)
	self.CallingCardHighlightLeft2 = CallingCardHighlightLeft2
	local CallingCardFlareLeft = LUI.UIImage.new(0, 0, -3, 383, 0, 0, 0.5, 68.5)
	CallingCardFlareLeft:setRGB(0.8, 0.34, 0.34)
	CallingCardFlareLeft:setZRot(180)
	CallingCardFlareLeft:setImage(RegisterImage(@"hash_4C0D64C8709CA1C"))
	CallingCardFlareLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(CallingCardFlareLeft)
	self.CallingCardFlareLeft = CallingCardFlareLeft
	self:mergeStateConditions({
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
				if not f2_local0 then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
				end
				return f2_local0
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KIllcamTeamPanelLeft.__resetProperties = function(f5_arg0)
	f5_arg0.CallingCardGridPatternLeft:completeAnimation()
	f5_arg0.BottomBackplateLeft:completeAnimation()
	f5_arg0.CallingCardHighlightLeft2:completeAnimation()
	f5_arg0.CallingCardHighlightLeft1:completeAnimation()
	f5_arg0.CallingCardFlareLeft:completeAnimation()
	f5_arg0.CallingCardGridPatternLeft:setLeftRight(0, 0, -4, 382)
	f5_arg0.CallingCardGridPatternLeft:setAlpha(1)
	f5_arg0.BottomBackplateLeft:setAlpha(0)
	f5_arg0.CallingCardHighlightLeft2:setAlpha(0.8)
	f5_arg0.CallingCardHighlightLeft1:setAlpha(0.5)
	f5_arg0.CallingCardFlareLeft:setAlpha(1)
end
CoD.KIllcamTeamPanelLeft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.BottomBackplateLeft:completeAnimation()
			f6_arg0.BottomBackplateLeft:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BottomBackplateLeft)
			f6_arg0.CallingCardHighlightLeft1:completeAnimation()
			f6_arg0.CallingCardHighlightLeft1:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingCardHighlightLeft1)
			f6_arg0.CallingCardGridPatternLeft:completeAnimation()
			f6_arg0.CallingCardGridPatternLeft:setLeftRight(0, 0, 1.5, 380.5)
			f6_arg0.CallingCardGridPatternLeft:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingCardGridPatternLeft)
			f6_arg0.CallingCardHighlightLeft2:completeAnimation()
			f6_arg0.CallingCardHighlightLeft2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingCardHighlightLeft2)
			f6_arg0.CallingCardFlareLeft:completeAnimation()
			f6_arg0.CallingCardFlareLeft:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.CallingCardFlareLeft)
		end,
	},
	Killcam = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
