CoD.PC_ConnectionQueuingOverlay = InheritFrom(LUI.UIElement)
CoD.PC_ConnectionQueuingOverlay.__defaultWidth = 1920
CoD.PC_ConnectionQueuingOverlay.__defaultHeight = 285
CoD.PC_ConnectionQueuingOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "PCConnectionQueue.ConnectionQueueRemainingtime")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "PCConnectionQueue.ConnectionQueuePosition")
	SetControllerModelValue(f1_arg1, "PCConnectionQueue.ConnectionQueueRemainingtime", 0)
	SetControllerModelValue(f1_arg1, "PCConnectionQueue.ConnectionQueuePosition", 0)
	self:setClass(CoD.PC_ConnectionQueuingOverlay)
	self.id = "PC_ConnectionQueuingOverlay"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.1, 0.9, 0, 0)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0.1, 0.9, 0, 0)
	backing:setRGB(0.08, 0.08, 0.08)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0.9, 0.9, 0, 20)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0.1, 0.1, -20, 0)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local TopBar = LUI.UIImage.new(0, 1, 0, 0, 0.05, 0.05, 0, 8)
	TopBar:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local BottomBar = LUI.UIImage.new(0, 1, 0, 0, 0.95, 0.95, -8, 0)
	BottomBar:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	BottomBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	BottomBar:setShaderVector(0, 2, 1, 0, 0)
	BottomBar:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(BottomBar)
	self.BottomBar = BottomBar
	local Header = LUI.UIText.new(0.5, 0.5, -324.5, 324.5, 0.2, 0.2, 0, 30)
	Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7C51866DCC22F69A"))
	Header:setTTF("ttmussels_demibold")
	Header:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Header)
	self.Header = Header
	local QueuingText = LUI.UIText.new(0.5, 0.5, -325, 325, 0.38, 0.38, 0, 18)
	QueuingText:setTTF("ttmussels_regular")
	QueuingText:setLetterSpacing(1)
	QueuingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	QueuingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	QueuingText.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			QueuingText:setText(CoD.PCUtility.LocalizeConnectionQueueMessage(f1_arg1, f2_local0))
		end
	end
	QueuingText:linkToElementModel(self, "ConnectionQueueRemainingtime", true, QueuingText.__String_Reference)
	QueuingText.__String_Reference_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.ConnectionQueueRemainingtime
		end
		if f3_local0 then
			QueuingText.__String_Reference(f3_local0)
		end
	end
	self:addElement(QueuingText)
	self.QueuingText = QueuingText
	local f1_local9 = QueuingText
	local f1_local10 = QueuingText.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["PCConnectionQueue.ConnectionQueueRemainingtime"], QueuingText.__String_Reference_FullPath)
	f1_local9 = QueuingText
	f1_local10 = QueuingText.subscribeToModel
	f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local9, f1_local11["PCConnectionQueue.ConnectionQueuePosition"], QueuingText.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_ConnectionQueuingOverlay.__resetProperties = function(f5_arg0)
	f5_arg0.backing:completeAnimation()
	f5_arg0.NoiseTiledBacking:completeAnimation()
	f5_arg0.backing:setAlpha(0.7)
	f5_arg0.NoiseTiledBacking:setAlpha(0.65)
end
CoD.PC_ConnectionQueuingOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(100)
						f9_arg0:setAlpha(0.7)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(70)
					f8_arg0:setAlpha(0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.NoiseTiledBacking:beginAnimation(30)
				f6_arg0.NoiseTiledBacking:setAlpha(0.7)
				f6_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.NoiseTiledBacking:completeAnimation()
			f6_arg0.NoiseTiledBacking:setAlpha(0)
			f6_local0(f6_arg0.NoiseTiledBacking)
			local f6_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							f13_arg0:beginAnimation(39)
							f13_arg0:setAlpha(0.9)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
						end
						f12_arg0:beginAnimation(100)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(70)
					f11_arg0:setAlpha(0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f6_arg0.backing:beginAnimation(30)
				f6_arg0.backing:setAlpha(0.7)
				f6_arg0.backing:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.backing:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f6_arg0.backing:completeAnimation()
			f6_arg0.backing:setAlpha(0)
			f6_local1(f6_arg0.backing)
		end,
	},
	PC = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(100)
						f17_arg0:setAlpha(0.7)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(70)
					f16_arg0:setAlpha(0)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f14_arg0.NoiseTiledBacking:beginAnimation(30)
				f14_arg0.NoiseTiledBacking:setAlpha(0.7)
				f14_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setAlpha(0)
			f14_local0(f14_arg0.NoiseTiledBacking)
			local f14_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							f21_arg0:beginAnimation(39)
							f21_arg0:setAlpha(0.5)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
						end
						f20_arg0:beginAnimation(100)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(70)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f14_arg0.backing:beginAnimation(30)
				f14_arg0.backing:setAlpha(0.15)
				f14_arg0.backing:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.backing:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f14_arg0.backing:completeAnimation()
			f14_arg0.backing:setAlpha(0)
			f14_local1(f14_arg0.backing)
		end,
	},
}
CoD.PC_ConnectionQueuingOverlay.__onClose = function(f22_arg0)
	f22_arg0.QueuingText:close()
end
