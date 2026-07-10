CoD.AAR_LeaguePlay_PlacementPip = InheritFrom(LUI.UIElement)
CoD.AAR_LeaguePlay_PlacementPip.__defaultWidth = 64
CoD.AAR_LeaguePlay_PlacementPip.__defaultHeight = 64
CoD.AAR_LeaguePlay_PlacementPip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AAR_LeaguePlay_PlacementPip)
	self.id = "AAR_LeaguePlay_PlacementPip"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bg = LUI.UIImage.new(0.5, 1.5, -32, -32, 0.5, 1.5, -32, -32)
	Bg:setRGB(0, 0, 0)
	Bg:setAlpha(0.5)
	self:addElement(Bg)
	self.Bg = Bg
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(16, 16)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local FrontendFrameAdd = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrameAdd:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrameAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrameAdd:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameAdd:setupNineSliceShader(16, 16)
	self:addElement(FrontendFrameAdd)
	self.FrontendFrameAdd = FrontendFrameAdd
	local dashBacking = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	dashBacking:setScale(1.5, 1.5)
	dashBacking:setImage(RegisterImage(0x4BB3E0B0E9A1D7E))
	self:addElement(dashBacking)
	self.dashBacking = dashBacking
	local Empty = LUI.UIImage.new(0, 1, -8, 8, 0, 1, -8, 8)
	Empty:setScale(0.67, 0.67)
	Empty:setImage(RegisterImage(0xF53DA84C7B770BF))
	Empty:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Empty)
	self.Empty = Empty
	local dash = LUI.UIImage.new(0, 0, 0, 64, 0, 0, 0, 64)
	dash:setScale(1.5, 1.5)
	dash:setImage(RegisterImage(0xEEB4FB140EAEAC))
	self:addElement(dash)
	self.dash = dash
	self:mergeStateConditions({
		{
			stateName = "Off",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "on")
			end,
		},
	})
	self:linkToElementModel(self, "on", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "on",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AAR_LeaguePlay_PlacementPip.__resetProperties = function(f4_arg0)
	f4_arg0.Bg:completeAnimation()
	f4_arg0.dash:completeAnimation()
	f4_arg0.dashBacking:completeAnimation()
	f4_arg0.Bg:setRGB(0, 0, 0)
	f4_arg0.Bg:setAlpha(0.5)
	f4_arg0.dash:setAlpha(1)
	f4_arg0.dashBacking:setAlpha(1)
end
CoD.AAR_LeaguePlay_PlacementPip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Bg:completeAnimation()
			f5_arg0.Bg:setAlpha(0.5)
			f5_arg0.clipFinished(f5_arg0.Bg)
		end,
	},
	Off = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Bg:completeAnimation()
			f6_arg0.Bg:setRGB(0.16, 0.16, 0.16)
			f6_arg0.clipFinished(f6_arg0.Bg)
			f6_arg0.dashBacking:completeAnimation()
			f6_arg0.dashBacking:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.dashBacking)
			f6_arg0.dash:completeAnimation()
			f6_arg0.dash:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.dash)
		end,
		DefaultState = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Bg:beginAnimation(200)
				f7_arg0.Bg:setRGB(0, 0, 0)
				f7_arg0.Bg:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Bg:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Bg:completeAnimation()
			f7_arg0.Bg:setRGB(0.16, 0.16, 0.16)
			f7_arg0.Bg:setAlpha(0.5)
			f7_local0(f7_arg0.Bg)
			local f7_local1 = function(f9_arg0)
				f7_arg0.dashBacking:beginAnimation(200)
				f7_arg0.dashBacking:setAlpha(1)
				f7_arg0.dashBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.dashBacking:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.dashBacking:completeAnimation()
			f7_arg0.dashBacking:setAlpha(0)
			f7_local1(f7_arg0.dashBacking)
			local f7_local2 = function(f10_arg0)
				f7_arg0.dash:beginAnimation(200)
				f7_arg0.dash:setAlpha(1)
				f7_arg0.dash:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.dash:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.dash:completeAnimation()
			f7_arg0.dash:setAlpha(0)
			f7_local2(f7_arg0.dash)
		end,
	},
}
