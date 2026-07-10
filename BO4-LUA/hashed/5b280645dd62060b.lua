require("x64:8000cbfee2bb369")
require("x64:8023284fd9ac6a8")
require("x64:51ec0b965f0f5")
CoD.SpawnSelectKillcamFrame = InheritFrom(LUI.UIElement)
CoD.SpawnSelectKillcamFrame.__defaultWidth = 1890
CoD.SpawnSelectKillcamFrame.__defaultHeight = 832
CoD.SpawnSelectKillcamFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectKillcamFrame)
	self.id = "SpawnSelectKillcamFrame"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Layout = CoD.SpawnSelectKillcamFrame_BGLayout.new(f1_arg0, f1_arg1, 0.5, 0.5, -945, 945, 0.5, 0.5, -416, 416)
	self:addElement(Layout)
	self.Layout = Layout
	local LayoutElements = CoD.SpawnSelectKillcamFrame_BGLayoutElements.new(f1_arg0, f1_arg1, 0.5, 0.5, -945, 945, 0.5, 0.5, -416, 416)
	self:addElement(LayoutElements)
	self.LayoutElements = LayoutElements
	local LayoutLines = LUI.UIImage.new(0, 0, 0, 1888, 0, 0, 0, 48)
	LayoutLines:setAlpha(0)
	LayoutLines:setImage(RegisterImage(0x16D3BA67D51FFAA))
	LayoutLines:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	LayoutLines:setShaderVector(0, 0, 1, 0, 0)
	LayoutLines:setShaderVector(1, 0, 0, 0, 0)
	LayoutLines:setShaderVector(2, 0, 1, 0, 0)
	LayoutLines:setShaderVector(3, 0, 0, 0, 0)
	LayoutLines:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LayoutLines)
	self.LayoutLines = LayoutLines
	local Ready = LUI.UIText.new(0, 0, 99.5, 141.5, 0, 0, 67, 77)
	Ready:setRGB(0.35, 0.52, 0.62)
	Ready:setText(CoD.BaseUtility.AlreadyLocalized("RDY"))
	Ready:setTTF("0arame_mono_stencil")
	Ready:setLetterSpacing(2)
	Ready:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Ready:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Ready)
	self.Ready = Ready
	local LayoutStripe = LUI.UIImage.new(0, 0, 75, 1821, 0, 0, 776, 832)
	LayoutStripe:setAlpha(0)
	LayoutStripe:setImage(RegisterImage(0xE4F4A25FB519F6))
	LayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	LayoutStripe:setShaderVector(0, 0, 1, 0, 0)
	LayoutStripe:setShaderVector(1, 0, 0, 0, 0)
	LayoutStripe:setShaderVector(2, 0, 1, 0, 0)
	LayoutStripe:setShaderVector(3, 0, 0, 0, 0)
	LayoutStripe:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LayoutStripe)
	self.LayoutStripe = LayoutStripe
	local System = LUI.UIText.new(0, 0, 99.5, 223.5, 0, 0, 57, 67)
	System:setRGB(0.35, 0.52, 0.62)
	System:setText(CoD.BaseUtility.AlreadyLocalized("SYS: 003A"))
	System:setTTF("0arame_mono_stencil")
	System:setLetterSpacing(2)
	System:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	System:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(System)
	self.System = System
	local Online = LUI.UIText.new(0, 0, 195.5, 249.5, 0, 0, 360, 370)
	Online:setRGB(0.35, 0.52, 0.62)
	Online:setText(Engine[0xF9F1239CFD921FE](0x8E783C525F2FA8))
	Online:setTTF("0arame_mono_stencil")
	Online:setLetterSpacing(2)
	Online:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Online:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Online)
	self.Online = Online
	local BarRight = LUI.UIImage.new(0, 0, 1700, 1758, 0, 0, 328, 356)
	BarRight:setImage(RegisterImage(0x1A7EE226176D9CB))
	self:addElement(BarRight)
	self.BarRight = BarRight
	local BarLeft = LUI.UIImage.new(0, 0, 128, 186, 0, 0, 328, 356)
	BarLeft:setImage(RegisterImage(0x1A7EE226176D9CB))
	self:addElement(BarLeft)
	self.BarLeft = BarLeft
	local RedDot = LUI.UIImage.new(0, 0, 1725, 1749, 0, 0, 94, 118)
	RedDot:setAlpha(0.3)
	RedDot:setImage(RegisterImage(0xC66A732DA072CFD))
	self:addElement(RedDot)
	self.RedDot = RedDot
	local layoutRight = CoD.SpawnSelectKillcamFrameLayoutRight.new(f1_arg0, f1_arg1, 0, 0, 1792, 1882, 0, 0, -40.5, 884.5)
	self:addElement(layoutRight)
	self.layoutRight = layoutRight
	local layoutLeft = CoD.SpawnSelectKillcamFrameLayoutRight.new(f1_arg0, f1_arg1, 0, 0, 8, 98, 0, 0, -102.5, 822.5)
	layoutLeft:setZRot(180)
	self:addElement(layoutLeft)
	self.layoutLeft = layoutLeft
	local MapName = LUI.UIText.new(0, 0, 138.5, 349.5, 0, 0, 756.5, 778.5)
	MapName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	MapName:setAlpha(0.8)
	MapName:setText(ToUpper(GetMapName()))
	MapName:setTTF("dinnext_regular")
	MapName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	MapName:setShaderVector(0, 0.3, 0, 0, 0)
	MapName:setShaderVector(1, 0, 0, 0, 0)
	MapName:setShaderVector(2, 0.9, 0.8, 0.7, 0.5)
	MapName:setLetterSpacing(6)
	MapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(MapName)
	self.MapName = MapName
	local MapLocation = LUI.UIText.new(0, 0, 348.5, 548.5, 0, 0, 765.5, 775.5)
	MapLocation:setAlpha(0)
	MapLocation:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	MapLocation:setTTF("dinnext_regular")
	MapLocation:setLetterSpacing(2)
	MapLocation:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapLocation:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(MapLocation)
	self.MapLocation = MapLocation
	local Operation = LUI.UIText.new(0, 0, 348.5, 548.5, 0, 0, 756.5, 766.5)
	Operation:setAlpha(0)
	Operation:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Operation:setTTF("dinnext_regular")
	Operation:setLetterSpacing(2)
	Operation:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Operation:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Operation)
	self.Operation = Operation
	self:mergeStateConditions({
		{
			stateName = "Killcam",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 1)
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.killcamActive", 0)
					if f2_local0 then
						f2_local0 = PropertyIsTrue(self, "killcamFullscreen")
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showSpawnSelect", 0)
			end,
		},
		{
			stateName = "KillcamFullscreen",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["hudItems.showSpawnSelect"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["hudItems.killcamActive"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.killcamActive",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsSelfInState(self, "DefaultState") and IsPC() and not IsGamepad(controller) then
			LockInputHUD(self, controller, true)
		elseif not IsSelfInState(self, "DefaultState") and IsPC() then
			LockInputHUD(self, controller, false)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsPC() then
			LockInputHUD(self, f1_arg1, false)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		local f9_local0 = self
		if IsPC() and IsSelfInState(self, "DefaultState") and IsGamepad(f1_arg1) then
			LockInputHUD(self, f1_arg1, false)
		elseif IsPC() and IsSelfInState(self, "DefaultState") and not IsGamepad(f1_arg1) then
			LockInputHUD(self, f1_arg1, true)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnSelectKillcamFrame.__resetProperties = function(f10_arg0)
	f10_arg0.LayoutStripe:completeAnimation()
	f10_arg0.BarRight:completeAnimation()
	f10_arg0.BarLeft:completeAnimation()
	f10_arg0.Ready:completeAnimation()
	f10_arg0.LayoutLines:completeAnimation()
	f10_arg0.RedDot:completeAnimation()
	f10_arg0.MapName:completeAnimation()
	f10_arg0.LayoutElements:completeAnimation()
	f10_arg0.Online:completeAnimation()
	f10_arg0.System:completeAnimation()
	f10_arg0.layoutRight:completeAnimation()
	f10_arg0.layoutLeft:completeAnimation()
	f10_arg0.Layout:completeAnimation()
	f10_arg0.LayoutStripe:setAlpha(0)
	f10_arg0.LayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	f10_arg0.LayoutStripe:setShaderVector(0, 0, 1, 0, 0)
	f10_arg0.LayoutStripe:setShaderVector(1, 0, 0, 0, 0)
	f10_arg0.LayoutStripe:setShaderVector(2, 0, 1, 0, 0)
	f10_arg0.LayoutStripe:setShaderVector(3, 0, 0, 0, 0)
	f10_arg0.LayoutStripe:setShaderVector(4, 0, 0, 0, 0)
	f10_arg0.BarRight:setLeftRight(0, 0, 1700, 1758)
	f10_arg0.BarRight:setAlpha(1)
	f10_arg0.BarLeft:setLeftRight(0, 0, 128, 186)
	f10_arg0.BarLeft:setAlpha(1)
	f10_arg0.Ready:setAlpha(1)
	f10_arg0.LayoutLines:setAlpha(0)
	f10_arg0.LayoutLines:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	f10_arg0.LayoutLines:setShaderVector(0, 0, 1, 0, 0)
	f10_arg0.LayoutLines:setShaderVector(1, 0, 0, 0, 0)
	f10_arg0.LayoutLines:setShaderVector(2, 0, 1, 0, 0)
	f10_arg0.LayoutLines:setShaderVector(3, 0, 0, 0, 0)
	f10_arg0.LayoutLines:setShaderVector(4, 0, 0, 0, 0)
	f10_arg0.RedDot:setAlpha(0.3)
	f10_arg0.MapName:setAlpha(0.8)
	f10_arg0.LayoutElements:setAlpha(1)
	f10_arg0.Online:setAlpha(1)
	f10_arg0.System:setAlpha(1)
	f10_arg0.Layout:setAlpha(1)
end
CoD.SpawnSelectKillcamFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(9)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										local f18_local0 = function(f19_arg0)
											f19_arg0:beginAnimation(800)
											f19_arg0:setAlpha(0)
											f19_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
										end
										f18_arg0:beginAnimation(399)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
									end
									f17_arg0:beginAnimation(800)
									f17_arg0:setAlpha(0.2)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(1000)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(799)
							f15_arg0:setAlpha(0)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(400)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(799)
					f13_arg0:setAlpha(0.2)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f11_arg0.LayoutElements:beginAnimation(1000)
				f11_arg0.LayoutElements:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LayoutElements:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.LayoutElements:completeAnimation()
			f11_arg0.LayoutElements:setAlpha(0)
			f11_local0(f11_arg0.LayoutElements)
			local f11_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(3000)
					f21_arg0:setAlpha(0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.LayoutLines:beginAnimation(3000)
				f11_arg0.LayoutLines:setAlpha(1)
				f11_arg0.LayoutLines:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LayoutLines:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f11_arg0.LayoutLines:completeAnimation()
			f11_arg0.LayoutLines:setAlpha(0)
			f11_local1(f11_arg0.LayoutLines)
			local f11_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							local f25_local0 = function(f26_arg0)
								local f26_local0 = function(f27_arg0)
									local f27_local0 = function(f28_arg0)
										local f28_local0 = function(f29_arg0)
											local f29_local0 = function(f30_arg0)
												f30_arg0:beginAnimation(500)
												f30_arg0:setAlpha(1)
												f30_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
											end
											f29_arg0:beginAnimation(500)
											f29_arg0:setAlpha(0.5)
											f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
										end
										f28_arg0:beginAnimation(1000)
										f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
									end
									f27_arg0:beginAnimation(500)
									f27_arg0:setAlpha(1)
									f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
								end
								f26_arg0:beginAnimation(500)
								f26_arg0:setAlpha(0.5)
								f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
							end
							f25_arg0:beginAnimation(1000)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
						end
						f24_arg0:beginAnimation(500)
						f24_arg0:setAlpha(1)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(500)
					f23_arg0:setAlpha(0.5)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f11_arg0.Ready:beginAnimation(1000)
				f11_arg0.Ready:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Ready:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f11_arg0.Ready:completeAnimation()
			f11_arg0.Ready:setAlpha(1)
			f11_local2(f11_arg0.Ready)
			local f11_local3 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							local f34_local0 = function(f35_arg0)
								local f35_local0 = function(f36_arg0)
									local f36_local0 = function(f37_arg0)
										local f37_local0 = function(f38_arg0)
											f38_arg0:beginAnimation(800, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
											f38_arg0:setAlpha(0)
											f38_arg0:setShaderVector(0, 0.5, 0.5, 0, 0)
											f38_arg0:setShaderVector(1, 0, 0, 0, 0)
											f38_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
										end
										f37_arg0:beginAnimation(399)
										f37_arg0:setShaderVector(0, 0.12, 0.88, 0, 0)
										f37_arg0:setShaderVector(1, 0.38, 0.38, 0, 0)
										f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
									end
									f36_arg0:beginAnimation(800, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
									f36_arg0:setAlpha(0.1)
									f36_arg0:setShaderVector(0, 0, 1, 0, 0)
									f36_arg0:setShaderVector(1, 0.5, 0.5, 0, 0)
									f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
								end
								f35_arg0:beginAnimation(1000)
								f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
							end
							f34_arg0:beginAnimation(799, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
							f34_arg0:setAlpha(0)
							f34_arg0:setShaderVector(0, 0.5, 0.5, 0, 0)
							f34_arg0:setShaderVector(1, 0, 0, 0, 0)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
						end
						f33_arg0:beginAnimation(400)
						f33_arg0:setShaderVector(0, 0.12, 0.87, 0, 0)
						f33_arg0:setShaderVector(1, 0.37, 0.37, 0, 0)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(799, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f32_arg0:setAlpha(0.1)
					f32_arg0:setShaderVector(0, 0, 1, 0, 0)
					f32_arg0:setShaderVector(1, 0.5, 0.5, 0, 0)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f11_arg0.LayoutStripe:beginAnimation(1000)
				f11_arg0.LayoutStripe:setAlpha(0)
				f11_arg0.LayoutStripe:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.LayoutStripe:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f11_arg0.LayoutStripe:completeAnimation()
			f11_arg0.LayoutStripe:setAlpha(1)
			f11_arg0.LayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f11_arg0.LayoutStripe:setShaderVector(0, 0.5, 0.5, 0, 0)
			f11_arg0.LayoutStripe:setShaderVector(1, 0, 0, 0, 0)
			f11_arg0.LayoutStripe:setShaderVector(2, 0, 1, 0, 0)
			f11_arg0.LayoutStripe:setShaderVector(3, 0, 0, 0, 0)
			f11_arg0.LayoutStripe:setShaderVector(4, 0, 0, 0, 0)
			f11_local3(f11_arg0.LayoutStripe)
			local f11_local4 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						local f41_local0 = function(f42_arg0)
							local f42_local0 = function(f43_arg0)
								local f43_local0 = function(f44_arg0)
									local f44_local0 = function(f45_arg0)
										local f45_local0 = function(f46_arg0)
											local f46_local0 = function(f47_arg0)
												local f47_local0 = function(f48_arg0)
													local f48_local0 = function(f49_arg0)
														f49_arg0:beginAnimation(449)
														f49_arg0:setAlpha(1)
														f49_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
													end
													f48_arg0:beginAnimation(449)
													f48_arg0:setAlpha(0.5)
													f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
												end
												f47_arg0:beginAnimation(450)
												f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
											end
											f46_arg0:beginAnimation(449)
											f46_arg0:setAlpha(1)
											f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
										end
										f45_arg0:beginAnimation(450)
										f45_arg0:setAlpha(0.5)
										f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
									end
									f44_arg0:beginAnimation(750)
									f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
								end
								f43_arg0:beginAnimation(450)
								f43_arg0:setAlpha(1)
								f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
							end
							f42_arg0:beginAnimation(450)
							f42_arg0:setAlpha(0.5)
							f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
						end
						f41_arg0:beginAnimation(500)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
					end
					f40_arg0:beginAnimation(449)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f39_arg0:beginAnimation(450)
				f39_arg0:setAlpha(0.5)
				f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f11_arg0.Online:beginAnimation(900)
			f11_arg0.Online:setAlpha(1)
			f11_arg0.Online:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.Online:registerEventHandler("transition_complete_keyframe", f11_local4)
			local f11_local5 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					local f51_local0 = function(f52_arg0)
						local f52_local0 = function(f53_arg0)
							local f53_local0 = function(f54_arg0)
								local f54_local0 = function(f55_arg0)
									local f55_local0 = function(f56_arg0)
										local f56_local0 = function(f57_arg0)
											local f57_local0 = function(f58_arg0)
												local f58_local0 = function(f59_arg0)
													local f59_local0 = function(f60_arg0)
														local f60_local0 = function(f61_arg0)
															f61_arg0:beginAnimation(99)
															f61_arg0:setAlpha(0.1)
															f61_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
														end
														f60_arg0:beginAnimation(100)
														f60_arg0:setAlpha(1)
														f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
													end
													f59_arg0:beginAnimation(1150)
													f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
												end
												f58_arg0:beginAnimation(100)
												f58_arg0:setAlpha(0.1)
												f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
											end
											f57_arg0:beginAnimation(99)
											f57_arg0:setAlpha(1)
											f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
										end
										f56_arg0:beginAnimation(1450)
										f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
									end
									f55_arg0:beginAnimation(99)
									f55_arg0:setAlpha(0.1)
									f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
								end
								f54_arg0:beginAnimation(100)
								f54_arg0:setAlpha(1)
								f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
							end
							f53_arg0:beginAnimation(1199)
							f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
						end
						f52_arg0:beginAnimation(100)
						f52_arg0:setAlpha(0.1)
						f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
					end
					f51_arg0:beginAnimation(100)
					f51_arg0:setAlpha(1)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
				end
				f11_arg0.BarRight:beginAnimation(650)
				f11_arg0.BarRight:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f11_arg0.BarRight:completeAnimation()
			f11_arg0.BarRight:setAlpha(0.1)
			f11_local5(f11_arg0.BarRight)
			local f11_local6 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					local f63_local0 = function(f64_arg0)
						local f64_local0 = function(f65_arg0)
							local f65_local0 = function(f66_arg0)
								local f66_local0 = function(f67_arg0)
									local f67_local0 = function(f68_arg0)
										local f68_local0 = function(f69_arg0)
											local f69_local0 = function(f70_arg0)
												local f70_local0 = function(f71_arg0)
													local f71_local0 = function(f72_arg0)
														local f72_local0 = function(f73_arg0)
															f73_arg0:beginAnimation(100)
															f73_arg0:setAlpha(0.1)
															f73_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
														end
														f72_arg0:beginAnimation(99)
														f72_arg0:setAlpha(1)
														f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
													end
													f71_arg0:beginAnimation(839)
													f71_arg0:registerEventHandler("transition_complete_keyframe", f71_local0)
												end
												f70_arg0:beginAnimation(100)
												f70_arg0:setAlpha(0.1)
												f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
											end
											f69_arg0:beginAnimation(100)
											f69_arg0:setAlpha(1)
											f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
										end
										f68_arg0:beginAnimation(1750)
										f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
									end
									f67_arg0:beginAnimation(99)
									f67_arg0:setAlpha(0.1)
									f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
								end
								f66_arg0:beginAnimation(100)
								f66_arg0:setAlpha(1)
								f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
							end
							f65_arg0:beginAnimation(1200)
							f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
						end
						f64_arg0:beginAnimation(99, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f64_arg0:setAlpha(0.1)
						f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
					end
					f63_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f63_arg0:setAlpha(1)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
				end
				f11_arg0.BarLeft:beginAnimation(500)
				f11_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f11_arg0.BarLeft:completeAnimation()
			f11_arg0.BarLeft:setAlpha(0.1)
			f11_local6(f11_arg0.BarLeft)
			local f11_local7 = function(f74_arg0)
				local f74_local0 = function(f75_arg0)
					local f75_local0 = function(f76_arg0)
						local f76_local0 = function(f77_arg0)
							local f77_local0 = function(f78_arg0)
								local f78_local0 = function(f79_arg0)
									f79_arg0:beginAnimation(1000)
									f79_arg0:setAlpha(0.3)
									f79_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
								end
								f78_arg0:beginAnimation(1000)
								f78_arg0:setAlpha(1)
								f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
							end
							f77_arg0:beginAnimation(1000)
							f77_arg0:registerEventHandler("transition_complete_keyframe", f77_local0)
						end
						f76_arg0:beginAnimation(1000)
						f76_arg0:setAlpha(0.3)
						f76_arg0:registerEventHandler("transition_complete_keyframe", f76_local0)
					end
					f75_arg0:beginAnimation(1000)
					f75_arg0:setAlpha(1)
					f75_arg0:registerEventHandler("transition_complete_keyframe", f75_local0)
				end
				f11_arg0.RedDot:beginAnimation(1000)
				f11_arg0.RedDot:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.RedDot:registerEventHandler("transition_complete_keyframe", f74_local0)
			end
			f11_arg0.RedDot:completeAnimation()
			f11_arg0.RedDot:setAlpha(0.3)
			f11_local7(f11_arg0.RedDot)
			local f11_local8 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					local f81_local0 = function(f82_arg0)
						local f82_local0 = function(f83_arg0)
							local f83_local0 = function(f84_arg0)
								local f84_local0 = function(f85_arg0)
									f85_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
									f85_arg0:setAlpha(0.5)
									f85_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
								end
								f84_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
								f84_arg0:setAlpha(0.3)
								f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
							end
							f83_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
							f83_arg0:setAlpha(0.5)
							f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
						end
						f82_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
						f82_arg0:setAlpha(0.3)
						f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
					end
					f81_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f81_arg0:setAlpha(0.5)
					f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
				end
				f11_arg0.MapName:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f11_arg0.MapName:setAlpha(0.3)
				f11_arg0.MapName:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.MapName:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f11_arg0.MapName:completeAnimation()
			f11_arg0.MapName:setAlpha(0.5)
			f11_local8(f11_arg0.MapName)
			f11_arg0.nextClip = "DefaultClip"
		end,
		Intro = function(f86_arg0, f86_arg1)
			f86_arg0:__resetProperties()
			f86_arg0:setupElementClipCounter(13)
			local f86_local0 = function(f87_arg0)
				local f87_local0 = function(f88_arg0)
					local f88_local0 = function(f89_arg0)
						local f89_local0 = function(f90_arg0)
							f90_arg0:beginAnimation(29)
							f90_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
						end
						f89_arg0:beginAnimation(80)
						f89_arg0:setAlpha(1)
						f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
					end
					f88_arg0:beginAnimation(120)
					f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
				end
				f86_arg0.Layout:beginAnimation(30)
				f86_arg0.Layout:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.Layout:registerEventHandler("transition_complete_keyframe", f87_local0)
			end
			f86_arg0.Layout:completeAnimation()
			f86_arg0.Layout:setAlpha(0)
			f86_local0(f86_arg0.Layout)
			local f86_local1 = function(f91_arg0)
				local f91_local0 = function(f92_arg0)
					local f92_local0 = function(f93_arg0)
						local f93_local0 = function(f94_arg0)
							f94_arg0:beginAnimation(130)
							f94_arg0:setAlpha(0)
							f94_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
						end
						f93_arg0:beginAnimation(50)
						f93_arg0:registerEventHandler("transition_complete_keyframe", f93_local0)
					end
					f92_arg0:beginAnimation(49)
					f92_arg0:setAlpha(1)
					f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
				end
				f91_arg0:beginAnimation(80)
				f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
			end
			f86_arg0.LayoutElements:beginAnimation(120)
			f86_arg0.LayoutElements:setAlpha(0)
			f86_arg0.LayoutElements:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
			f86_arg0.LayoutElements:registerEventHandler("transition_complete_keyframe", f86_local1)
			local f86_local2 = function(f95_arg0)
				local f95_local0 = function(f96_arg0)
					local f96_local0 = function(f97_arg0)
						local f97_local0 = function(f98_arg0)
							f98_arg0:beginAnimation(69)
							f98_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
						end
						f97_arg0:beginAnimation(310)
						f97_arg0:setAlpha(0)
						f97_arg0:registerEventHandler("transition_complete_keyframe", f97_local0)
					end
					f96_arg0:beginAnimation(89, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f96_arg0:setShaderVector(0, 0, 1, 0, 0)
					f96_arg0:registerEventHandler("transition_complete_keyframe", f96_local0)
				end
				f86_arg0.LayoutLines:beginAnimation(30)
				f86_arg0.LayoutLines:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.LayoutLines:registerEventHandler("transition_complete_keyframe", f95_local0)
			end
			f86_arg0.LayoutLines:completeAnimation()
			f86_arg0.LayoutLines:setAlpha(1)
			f86_arg0.LayoutLines:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f86_arg0.LayoutLines:setShaderVector(0, 0.5, 0.5, 0, 0)
			f86_arg0.LayoutLines:setShaderVector(1, 0, 0, 0, 0)
			f86_arg0.LayoutLines:setShaderVector(2, 0, 1, 0, 0)
			f86_arg0.LayoutLines:setShaderVector(3, 0, 0, 0, 0)
			f86_arg0.LayoutLines:setShaderVector(4, 0, 0, 0, 0)
			f86_local2(f86_arg0.LayoutLines)
			local f86_local3 = function(f99_arg0)
				local f99_local0 = function(f100_arg0)
					f100_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f100_arg0:setAlpha(1)
					f100_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
				end
				f86_arg0.Ready:beginAnimation(440)
				f86_arg0.Ready:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.Ready:registerEventHandler("transition_complete_keyframe", f99_local0)
			end
			f86_arg0.Ready:completeAnimation()
			f86_arg0.Ready:setAlpha(0)
			f86_local3(f86_arg0.Ready)
			local f86_local4 = function(f101_arg0)
				local f101_local0 = function(f102_arg0)
					local f102_local0 = function(f103_arg0)
						local f103_local0 = function(f104_arg0)
							f104_arg0:beginAnimation(69)
							f104_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
						end
						f103_arg0:beginAnimation(310)
						f103_arg0:setAlpha(0)
						f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
					end
					f102_arg0:beginAnimation(89, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f102_arg0:setShaderVector(0, 0, 1, 0, 0)
					f102_arg0:registerEventHandler("transition_complete_keyframe", f102_local0)
				end
				f86_arg0.LayoutStripe:beginAnimation(30)
				f86_arg0.LayoutStripe:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.LayoutStripe:registerEventHandler("transition_complete_keyframe", f101_local0)
			end
			f86_arg0.LayoutStripe:completeAnimation()
			f86_arg0.LayoutStripe:setAlpha(0.2)
			f86_arg0.LayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f86_arg0.LayoutStripe:setShaderVector(0, 0.5, 0.5, 0, 0)
			f86_arg0.LayoutStripe:setShaderVector(1, 0, 0, 0, 0)
			f86_arg0.LayoutStripe:setShaderVector(2, 0, 1, 0, 0)
			f86_arg0.LayoutStripe:setShaderVector(3, 0, 0, 0, 0)
			f86_arg0.LayoutStripe:setShaderVector(4, 0, 0, 0, 0)
			f86_local4(f86_arg0.LayoutStripe)
			local f86_local5 = function(f105_arg0)
				local f105_local0 = function(f106_arg0)
					f106_arg0:beginAnimation(60, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f106_arg0:setAlpha(1)
					f106_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
				end
				f86_arg0.System:beginAnimation(380)
				f86_arg0.System:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.System:registerEventHandler("transition_complete_keyframe", f105_local0)
			end
			f86_arg0.System:completeAnimation()
			f86_arg0.System:setAlpha(0)
			f86_local5(f86_arg0.System)
			local f86_local6 = function(f107_arg0)
				f107_arg0:beginAnimation(120, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f107_arg0:setAlpha(1)
				f107_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
			end
			f86_arg0.Online:beginAnimation(380)
			f86_arg0.Online:setAlpha(0)
			f86_arg0.Online:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
			f86_arg0.Online:registerEventHandler("transition_complete_keyframe", f86_local6)
			local f86_local7 = function(f108_arg0)
				local f108_local0 = function(f109_arg0)
					f109_arg0:beginAnimation(60, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f109_arg0:setLeftRight(0, 0, 1700, 1758)
					f109_arg0:setAlpha(1)
					f109_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
				end
				f86_arg0.BarRight:beginAnimation(160)
				f86_arg0.BarRight:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f108_local0)
			end
			f86_arg0.BarRight:completeAnimation()
			f86_arg0.BarRight:setLeftRight(0, 0, 1960, 2018)
			f86_arg0.BarRight:setAlpha(0.1)
			f86_local7(f86_arg0.BarRight)
			local f86_local8 = function(f110_arg0)
				local f110_local0 = function(f111_arg0)
					f111_arg0:beginAnimation(60, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f111_arg0:setLeftRight(0, 0, 128, 186)
					f111_arg0:setAlpha(1)
					f111_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
				end
				f86_arg0.BarLeft:beginAnimation(140)
				f86_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f110_local0)
			end
			f86_arg0.BarLeft:completeAnimation()
			f86_arg0.BarLeft:setLeftRight(0, 0, -129, -71)
			f86_arg0.BarLeft:setAlpha(0.1)
			f86_local8(f86_arg0.BarLeft)
			local f86_local9 = function(f112_arg0)
				local f112_local0 = function(f113_arg0)
					f113_arg0:beginAnimation(50)
					f113_arg0:setAlpha(0.3)
					f113_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
				end
				f112_arg0:beginAnimation(49)
				f112_arg0:setAlpha(1)
				f112_arg0:registerEventHandler("transition_complete_keyframe", f112_local0)
			end
			f86_arg0.RedDot:beginAnimation(200)
			f86_arg0.RedDot:setAlpha(0)
			f86_arg0.RedDot:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
			f86_arg0.RedDot:registerEventHandler("transition_complete_keyframe", f86_local9)
			f86_arg0.layoutRight:completeAnimation()
			f86_arg0.layoutRight:playClip("Intro")
			f86_arg0.clipFinished(f86_arg0.layoutRight)
			f86_arg0.layoutLeft:completeAnimation()
			f86_arg0.layoutLeft:playClip("Intro")
			f86_arg0.clipFinished(f86_arg0.layoutLeft)
			local f86_local10 = function(f114_arg0)
				local f114_local0 = function(f115_arg0)
					local f115_local0 = function(f116_arg0)
						f116_arg0:beginAnimation(40)
						f116_arg0:setAlpha(0.5)
						f116_arg0:registerEventHandler("transition_complete_keyframe", f86_arg0.clipFinished)
					end
					f115_arg0:beginAnimation(109)
					f115_arg0:setAlpha(0.8)
					f115_arg0:registerEventHandler("transition_complete_keyframe", f115_local0)
				end
				f86_arg0.MapName:beginAnimation(150)
				f86_arg0.MapName:registerEventHandler("interrupted_keyframe", f86_arg0.clipInterrupted)
				f86_arg0.MapName:registerEventHandler("transition_complete_keyframe", f114_local0)
			end
			f86_arg0.MapName:completeAnimation()
			f86_arg0.MapName:setAlpha(0)
			f86_local10(f86_arg0.MapName)
		end,
	},
	Killcam = {
		DefaultClip = function(f117_arg0, f117_arg1)
			f117_arg0:__resetProperties()
			f117_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f118_arg0, f118_arg1)
			f118_arg0:__resetProperties()
			f118_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f119_arg0, f119_arg1)
			f119_arg0:__resetProperties()
			f119_arg0:setupElementClipCounter(6)
			local f119_local0 = function(f120_arg0)
				local f120_local0 = function(f121_arg0)
					local f121_local0 = function(f122_arg0)
						local f122_local0 = function(f123_arg0)
							f123_arg0:beginAnimation(299)
							f123_arg0:setAlpha(0)
							f123_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
						end
						f122_arg0:beginAnimation(1300)
						f122_arg0:registerEventHandler("transition_complete_keyframe", f122_local0)
					end
					f121_arg0:beginAnimation(600, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f121_arg0:setShaderVector(0, 0, 1, 0, 0)
					f121_arg0:registerEventHandler("transition_complete_keyframe", f121_local0)
				end
				f119_arg0.LayoutLines:beginAnimation(600)
				f119_arg0.LayoutLines:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.LayoutLines:registerEventHandler("transition_complete_keyframe", f120_local0)
			end
			f119_arg0.LayoutLines:completeAnimation()
			f119_arg0.LayoutLines:setAlpha(1)
			f119_arg0.LayoutLines:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f119_arg0.LayoutLines:setShaderVector(0, 0.5, 0.5, 0, 0)
			f119_arg0.LayoutLines:setShaderVector(1, 0, 0, 0, 0)
			f119_arg0.LayoutLines:setShaderVector(2, 0, 1, 0, 0)
			f119_arg0.LayoutLines:setShaderVector(3, 0, 0, 0, 0)
			f119_arg0.LayoutLines:setShaderVector(4, 0, 0, 0, 0)
			f119_local0(f119_arg0.LayoutLines)
			local f119_local1 = function(f124_arg0)
				local f124_local0 = function(f125_arg0)
					f125_arg0:beginAnimation(299)
					f125_arg0:setAlpha(1)
					f125_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
				end
				f119_arg0.Ready:beginAnimation(2500)
				f119_arg0.Ready:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.Ready:registerEventHandler("transition_complete_keyframe", f124_local0)
			end
			f119_arg0.Ready:completeAnimation()
			f119_arg0.Ready:setAlpha(0)
			f119_local1(f119_arg0.Ready)
			local f119_local2 = function(f126_arg0)
				local f126_local0 = function(f127_arg0)
					local f127_local0 = function(f128_arg0)
						local f128_local0 = function(f129_arg0)
							f129_arg0:beginAnimation(299)
							f129_arg0:setAlpha(0)
							f129_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
						end
						f128_arg0:beginAnimation(1300)
						f128_arg0:registerEventHandler("transition_complete_keyframe", f128_local0)
					end
					f127_arg0:beginAnimation(600, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f127_arg0:setShaderVector(0, 0, 1, 0, 0)
					f127_arg0:registerEventHandler("transition_complete_keyframe", f127_local0)
				end
				f119_arg0.LayoutStripe:beginAnimation(600)
				f119_arg0.LayoutStripe:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.LayoutStripe:registerEventHandler("transition_complete_keyframe", f126_local0)
			end
			f119_arg0.LayoutStripe:completeAnimation()
			f119_arg0.LayoutStripe:setAlpha(1)
			f119_arg0.LayoutStripe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f119_arg0.LayoutStripe:setShaderVector(0, 0.5, 0.5, 0, 0)
			f119_arg0.LayoutStripe:setShaderVector(1, 0, 0, 0, 0)
			f119_arg0.LayoutStripe:setShaderVector(2, 0, 1, 0, 0)
			f119_arg0.LayoutStripe:setShaderVector(3, 0, 0, 0, 0)
			f119_arg0.LayoutStripe:setShaderVector(4, 0, 0, 0, 0)
			f119_local2(f119_arg0.LayoutStripe)
			local f119_local3 = function(f130_arg0)
				local f130_local0 = function(f131_arg0)
					f131_arg0:beginAnimation(299)
					f131_arg0:setAlpha(1)
					f131_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
				end
				f119_arg0.System:beginAnimation(2500)
				f119_arg0.System:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.System:registerEventHandler("transition_complete_keyframe", f130_local0)
			end
			f119_arg0.System:completeAnimation()
			f119_arg0.System:setAlpha(0)
			f119_local3(f119_arg0.System)
			local f119_local4 = function(f132_arg0)
				local f132_local0 = function(f133_arg0)
					f133_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f133_arg0:setLeftRight(0, 0, 1674, 1732)
					f133_arg0:setAlpha(1)
					f133_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
				end
				f119_arg0.BarRight:beginAnimation(1100)
				f119_arg0.BarRight:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.BarRight:registerEventHandler("transition_complete_keyframe", f132_local0)
			end
			f119_arg0.BarRight:completeAnimation()
			f119_arg0.BarRight:setLeftRight(0, 0, 1960, 2018)
			f119_arg0.BarRight:setAlpha(0.1)
			f119_local4(f119_arg0.BarRight)
			local f119_local5 = function(f134_arg0)
				local f134_local0 = function(f135_arg0)
					f135_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f135_arg0:setLeftRight(0, 0, 131, 189)
					f135_arg0:setAlpha(1)
					f135_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
				end
				f119_arg0.BarLeft:beginAnimation(1100)
				f119_arg0.BarLeft:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.BarLeft:registerEventHandler("transition_complete_keyframe", f134_local0)
			end
			f119_arg0.BarLeft:completeAnimation()
			f119_arg0.BarLeft:setLeftRight(0, 0, -129, -71)
			f119_arg0.BarLeft:setAlpha(0.1)
			f119_local5(f119_arg0.BarLeft)
		end,
	},
	KillcamFullscreen = {
		DefaultClip = function(f136_arg0, f136_arg1)
			f136_arg0:__resetProperties()
			f136_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.SpawnSelectKillcamFrame.__onClose = function(f137_arg0)
	f137_arg0.Layout:close()
	f137_arg0.LayoutElements:close()
	f137_arg0.layoutRight:close()
	f137_arg0.layoutLeft:close()
end
