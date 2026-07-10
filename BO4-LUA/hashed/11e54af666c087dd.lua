require("x64:acbf06924421e35")
require("x64:749d647a1f62c93")
require("x64:9e0119b0fcb0fb8")
require("x64:a9da787adb62c2a")
CoD.SpawnRegionMarker = InheritFrom(LUI.UIElement)
CoD.SpawnRegionMarker.__defaultWidth = 100
CoD.SpawnRegionMarker.__defaultHeight = 100
CoD.SpawnRegionMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnRegionMarker)
	self.id = "SpawnRegionMarker"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 20.5, 281.5, 0, 0, 27, 73)
	Background:setRGB(0.07, 0.07, 0.07)
	self:addElement(Background)
	self.Background = Background
	local NoiseBacking = LUI.UIImage.new(0, 0, 20.5, 281.5, 0, 0, 27, 73)
	NoiseBacking:setAlpha(0.85)
	NoiseBacking:setImage(RegisterImage(0xC082CFCA3C180E5))
	NoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseBacking:setupNineSliceShader(24, 24)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	local TiledShaderImage = LUI.UIImage.new(0, 0, 20.5, 281.5, 0, 0, 27, 73)
	TiledShaderImage:setAlpha(0.6)
	TiledShaderImage:setImage(RegisterImage(0x4B6FFA90272070E))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 20.5, 281.5, 0, 0, 27, 73)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local SpawnSelectIconBg = CoD.SpawnSelectLocationMarker.new(f1_arg0, f1_arg1, 0, 0, -49, 149, 0, 0, -14, 114)
	self:addElement(SpawnSelectIconBg)
	self.SpawnSelectIconBg = SpawnSelectIconBg
	local SpawnSelectPulse = CoD.SpawnRegionPulse.new(f1_arg0, f1_arg1, 0, 0, -70, 170, 0, 0, -64, 164)
	self:addElement(SpawnSelectPulse)
	self.SpawnSelectPulse = SpawnSelectPulse
	local AutoSpawnPoint = CoD.SpawnRegionAutoSpawn.new(f1_arg0, f1_arg1, 0, 0, 10, 90, 0, 0, 10, 90)
	self:addElement(AutoSpawnPoint)
	self.AutoSpawnPoint = AutoSpawnPoint
	local Label = LUI.UIText.new(0, 0, 81, 281, 0, 0, 38.5, 63.5)
	Label:setRGB(0.89, 0.85, 0.85)
	Label:setText(Engine[0xF9F1239CFD921FE](0x97D2D83C3F46EE5))
	Label:setTTF("0arame_mono_stencil")
	Label:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Label:setShaderVector(0, 1.3, 0, 0, 0)
	Label:setShaderVector(1, -0.06, 0, 0, 0)
	Label:setShaderVector(2, 0, 0, 0, 1)
	Label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Label:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Label)
	self.Label = Label
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.SpawnSelectionUtility.IsSpawnRegionVisible(f1_arg1, element) then
					f2_local0 = AlwaysFalse()
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
	})
	self:linkToElementModel(self, "visStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "visStatus",
		})
	end)
	SpawnSelectIconBg.id = "SpawnSelectIconBg"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnRegionMarker.__resetProperties = function(f4_arg0)
	f4_arg0.SpawnSelectPulse:completeAnimation()
	f4_arg0.AutoSpawnPoint:completeAnimation()
	f4_arg0.SpawnSelectIconBg:completeAnimation()
	f4_arg0.Label:completeAnimation()
	f4_arg0.TiledShaderImage:completeAnimation()
	f4_arg0.NoiseBacking:completeAnimation()
	f4_arg0.CommonCornerPips:completeAnimation()
	f4_arg0.Background:completeAnimation()
	f4_arg0.SpawnSelectPulse:setAlpha(1)
	f4_arg0.SpawnSelectPulse:setScale(1, 1)
	f4_arg0.AutoSpawnPoint:setAlpha(1)
	f4_arg0.AutoSpawnPoint:setScale(1, 1)
	f4_arg0.SpawnSelectIconBg:setAlpha(1)
	f4_arg0.SpawnSelectIconBg:setScale(1, 1)
	f4_arg0.Label:setAlpha(1)
	f4_arg0.Label:setBackingXPadding(5)
	f4_arg0.TiledShaderImage:setAlpha(0.6)
	f4_arg0.NoiseBacking:setAlpha(0.85)
	f4_arg0.CommonCornerPips:setAlpha(1)
	f4_arg0.Background:setAlpha(1)
end
CoD.SpawnRegionMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(5)
			f5_arg0.TiledShaderImage:completeAnimation()
			f5_arg0.TiledShaderImage:setAlpha(0.6)
			f5_arg0.clipFinished(f5_arg0.TiledShaderImage)
			f5_arg0.SpawnSelectIconBg:completeAnimation()
			f5_arg0.SpawnSelectIconBg:playClip("DefaultClip")
			f5_arg0.clipFinished(f5_arg0.SpawnSelectIconBg)
			f5_arg0.SpawnSelectPulse:completeAnimation()
			f5_arg0.SpawnSelectPulse:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.SpawnSelectPulse)
			f5_arg0.AutoSpawnPoint:completeAnimation()
			f5_arg0.AutoSpawnPoint:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.AutoSpawnPoint)
			f5_arg0.Label:completeAnimation()
			f5_arg0.Label:setBackingXPadding(5)
			f5_arg0.clipFinished(f5_arg0.Label)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.TiledShaderImage:completeAnimation()
			f6_arg0.TiledShaderImage:setAlpha(0.9)
			f6_arg0.clipFinished(f6_arg0.TiledShaderImage)
			f6_arg0.SpawnSelectIconBg:completeAnimation()
			f6_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
			f6_arg0.SpawnSelectIconBg:playClip("Focused")
			f6_arg0.clipFinished(f6_arg0.SpawnSelectIconBg)
			f6_arg0.SpawnSelectPulse:completeAnimation()
			f6_arg0.SpawnSelectPulse:setAlpha(1)
			f6_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
			f6_arg0.clipFinished(f6_arg0.SpawnSelectPulse)
			f6_arg0.AutoSpawnPoint:completeAnimation()
			f6_arg0.AutoSpawnPoint:setAlpha(1)
			f6_arg0.AutoSpawnPoint:setScale(1.2, 1.2)
			f6_arg0.clipFinished(f6_arg0.AutoSpawnPoint)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			local f7_local0 = function(f8_arg0)
				f7_arg0.TiledShaderImage:beginAnimation(100)
				f7_arg0.TiledShaderImage:setAlpha(0.9)
				f7_arg0.TiledShaderImage:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.TiledShaderImage:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.TiledShaderImage:completeAnimation()
			f7_arg0.TiledShaderImage:setAlpha(0.6)
			f7_local0(f7_arg0.TiledShaderImage)
			local f7_local1 = function(f9_arg0)
				f7_arg0.SpawnSelectIconBg:playClip("TransitionGainFocus")
				f7_arg0.SpawnSelectIconBg:beginAnimation(100)
				f7_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
				f7_arg0.SpawnSelectIconBg:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SpawnSelectIconBg:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("TransitionGainFocus")
					f7_arg0.clipFinished(element, event)
				end)
			end
			f7_arg0.SpawnSelectIconBg:completeAnimation()
			f7_arg0.SpawnSelectIconBg:setScale(1, 1)
			f7_local1(f7_arg0.SpawnSelectIconBg)
			local f7_local2 = function(f11_arg0)
				f7_arg0.SpawnSelectPulse:beginAnimation(100)
				f7_arg0.SpawnSelectPulse:setAlpha(1)
				f7_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
				f7_arg0.SpawnSelectPulse:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SpawnSelectPulse:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SpawnSelectPulse:completeAnimation()
			f7_arg0.SpawnSelectPulse:setAlpha(0)
			f7_arg0.SpawnSelectPulse:setScale(1, 1)
			f7_local2(f7_arg0.SpawnSelectPulse)
			local f7_local3 = function(f12_arg0)
				f7_arg0.AutoSpawnPoint:beginAnimation(100)
				f7_arg0.AutoSpawnPoint:setScale(1.2, 1.2)
				f7_arg0.AutoSpawnPoint:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AutoSpawnPoint:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.AutoSpawnPoint:completeAnimation()
			f7_arg0.AutoSpawnPoint:setAlpha(1)
			f7_arg0.AutoSpawnPoint:setScale(1, 1)
			f7_local3(f7_arg0.AutoSpawnPoint)
		end,
		LoseFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				f13_arg0.TiledShaderImage:beginAnimation(100)
				f13_arg0.TiledShaderImage:setAlpha(0.6)
				f13_arg0.TiledShaderImage:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.TiledShaderImage:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.TiledShaderImage:completeAnimation()
			f13_arg0.TiledShaderImage:setAlpha(0.9)
			f13_local0(f13_arg0.TiledShaderImage)
			local f13_local1 = function(f15_arg0)
				f13_arg0.SpawnSelectIconBg:playClip("TransitionLoseFocus")
				f13_arg0.SpawnSelectIconBg:beginAnimation(100)
				f13_arg0.SpawnSelectIconBg:setScale(1, 1)
				f13_arg0.SpawnSelectIconBg:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SpawnSelectIconBg:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("TransitionLoseFocus")
					f13_arg0.clipFinished(element, event)
				end)
			end
			f13_arg0.SpawnSelectIconBg:completeAnimation()
			f13_arg0.SpawnSelectIconBg:setAlpha(1)
			f13_arg0.SpawnSelectIconBg:setScale(1.2, 1.2)
			f13_local1(f13_arg0.SpawnSelectIconBg)
			local f13_local2 = function(f17_arg0)
				f13_arg0.SpawnSelectPulse:beginAnimation(100)
				f13_arg0.SpawnSelectPulse:setAlpha(0)
				f13_arg0.SpawnSelectPulse:setScale(1, 1)
				f13_arg0.SpawnSelectPulse:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SpawnSelectPulse:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SpawnSelectPulse:completeAnimation()
			f13_arg0.SpawnSelectPulse:setAlpha(1)
			f13_arg0.SpawnSelectPulse:setScale(1.2, 1.2)
			f13_local2(f13_arg0.SpawnSelectPulse)
			local f13_local3 = function(f18_arg0)
				f13_arg0.AutoSpawnPoint:beginAnimation(100)
				f13_arg0.AutoSpawnPoint:setScale(1, 1)
				f13_arg0.AutoSpawnPoint:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.AutoSpawnPoint:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.AutoSpawnPoint:completeAnimation()
			f13_arg0.AutoSpawnPoint:setAlpha(1)
			f13_arg0.AutoSpawnPoint:setScale(1.2, 1.2)
			f13_local3(f13_arg0.AutoSpawnPoint)
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(8)
			f19_arg0.Background:completeAnimation()
			f19_arg0.Background:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Background)
			f19_arg0.NoiseBacking:completeAnimation()
			f19_arg0.NoiseBacking:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.NoiseBacking)
			f19_arg0.TiledShaderImage:completeAnimation()
			f19_arg0.TiledShaderImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.TiledShaderImage)
			f19_arg0.CommonCornerPips:completeAnimation()
			f19_arg0.CommonCornerPips:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CommonCornerPips)
			f19_arg0.SpawnSelectIconBg:completeAnimation()
			f19_arg0.SpawnSelectIconBg:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.SpawnSelectIconBg)
			f19_arg0.SpawnSelectPulse:completeAnimation()
			f19_arg0.SpawnSelectPulse:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.SpawnSelectPulse)
			f19_arg0.AutoSpawnPoint:completeAnimation()
			f19_arg0.AutoSpawnPoint:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.AutoSpawnPoint)
			f19_arg0.Label:completeAnimation()
			f19_arg0.Label:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Label)
		end,
	},
}
CoD.SpawnRegionMarker.__onClose = function(f20_arg0)
	f20_arg0.CommonCornerPips:close()
	f20_arg0.SpawnSelectIconBg:close()
	f20_arg0.SpawnSelectPulse:close()
	f20_arg0.AutoSpawnPoint:close()
end
