require("x64:564ca313abeb19a")
CoD.TabletTak5_ConnectionText = InheritFrom(LUI.UIElement)
CoD.TabletTak5_ConnectionText.__defaultWidth = 160
CoD.TabletTak5_ConnectionText.__defaultHeight = 30
CoD.TabletTak5_ConnectionText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletTak5_ConnectionText)
	self.id = "TabletTak5_ConnectionText"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ConnectionText = LUI.UIText.new(0, 0, 0, 160, 0, 0, 6, 29)
	ConnectionText:setAlpha(0)
	ConnectionText:setText(LocalizeToUpperString(@"hash_341441168C405322"))
	ConnectionText:setTTF("dinnext_regular")
	ConnectionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ConnectionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ConnectionText)
	self.ConnectionText = ConnectionText
	local ConnectionAdd = LUI.UIText.new(0, 0, 0, 160, 0, 0, 6, 29)
	ConnectionAdd:setAlpha(0)
	ConnectionAdd:setText(LocalizeToUpperString(@"hash_341441168C405322"))
	ConnectionAdd:setTTF("dinnext_regular")
	ConnectionAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3336C1AE82B1520A"))
	ConnectionAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ConnectionAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ConnectionAdd)
	self.ConnectionAdd = ConnectionAdd
	local ConnectionData = LUI.UIImage.new(0, 0, 16, 144, 0, 0, 9, 23)
	ConnectionData:setImage(RegisterImage(@"uie_ui_hud_tak5_data_normal"))
	self:addElement(ConnectionData)
	self.ConnectionData = ConnectionData
	local ConnectionDataAdd = LUI.UIImage.new(0, 0, 16, 144, 0, 0, 9, 23)
	ConnectionDataAdd:setImage(RegisterImage(@"uie_ui_hud_tak5_data_normal"))
	ConnectionDataAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ConnectionDataAdd:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(ConnectionDataAdd)
	self.ConnectionDataAdd = ConnectionDataAdd
	local RightArrow = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 0, 0, 138, 203, 0, 0, -0.5, 30.5)
	RightArrow:setZRot(180)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	local LeftArrow = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 0, 0, -43, 22, 0, 0, -0.5, 30.5)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	self:mergeStateConditions({
		{
			stateName = "Linked",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "TeammateHealTargeting", "targetClientNum", LuaDefine.INVALID_CLIENT_INDEX)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.TeammateHealTargeting.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.targetClientNum, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "targetClientNum",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletTak5_ConnectionText.__resetProperties = function(f4_arg0)
	f4_arg0.ConnectionText:completeAnimation()
	f4_arg0.ConnectionData:completeAnimation()
	f4_arg0.ConnectionDataAdd:completeAnimation()
	f4_arg0.ConnectionAdd:completeAnimation()
	f4_arg0.ConnectionText:setAlpha(0)
	f4_arg0.ConnectionData:setAlpha(1)
	f4_arg0.ConnectionDataAdd:setAlpha(1)
	f4_arg0.ConnectionAdd:setAlpha(0)
end
CoD.TabletTak5_ConnectionText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.ConnectionText:completeAnimation()
			f5_arg0.ConnectionText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ConnectionText)
			f5_arg0.ConnectionAdd:completeAnimation()
			f5_arg0.ConnectionAdd:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ConnectionAdd)
			local f5_local0 = function(f6_arg0)
				f5_arg0.ConnectionData:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f5_arg0.ConnectionData:setAlpha(1)
				f5_arg0.ConnectionData:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ConnectionData:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ConnectionData:completeAnimation()
			f5_arg0.ConnectionData:setAlpha(0)
			f5_local0(f5_arg0.ConnectionData)
			local f5_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(200)
					f8_arg0:setAlpha(0.3)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.ConnectionDataAdd:beginAnimation(400)
				f5_arg0.ConnectionDataAdd:setAlpha(0.5)
				f5_arg0.ConnectionDataAdd:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ConnectionDataAdd:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f5_arg0.ConnectionDataAdd:completeAnimation()
			f5_arg0.ConnectionDataAdd:setAlpha(0)
			f5_local1(f5_arg0.ConnectionDataAdd)
		end,
	},
	Linked = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			local f9_local0 = function(f10_arg0)
				f9_arg0.ConnectionText:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f9_arg0.ConnectionText:setAlpha(1)
				f9_arg0.ConnectionText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ConnectionText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ConnectionText:completeAnimation()
			f9_arg0.ConnectionText:setAlpha(0)
			f9_local0(f9_arg0.ConnectionText)
			local f9_local1 = function(f11_arg0)
				f9_arg0.ConnectionAdd:beginAnimation(200)
				f9_arg0.ConnectionAdd:setAlpha(1)
				f9_arg0.ConnectionAdd:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ConnectionAdd:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.ConnectionAdd:completeAnimation()
			f9_arg0.ConnectionAdd:setAlpha(0)
			f9_local1(f9_arg0.ConnectionAdd)
			f9_arg0.ConnectionData:completeAnimation()
			f9_arg0.ConnectionData:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ConnectionData)
			f9_arg0.ConnectionDataAdd:completeAnimation()
			f9_arg0.ConnectionDataAdd:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ConnectionDataAdd)
		end,
	},
}
CoD.TabletTak5_ConnectionText.__onClose = function(f12_arg0)
	f12_arg0.RightArrow:close()
	f12_arg0.LeftArrow:close()
end
