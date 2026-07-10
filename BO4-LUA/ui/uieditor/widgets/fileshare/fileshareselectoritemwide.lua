require("x64:b192f2ad99871d9")
require("x64:a9255c570c68aa8")
CoD.FileshareSelectorItemWide = InheritFrom(LUI.UIElement)
CoD.FileshareSelectorItemWide.__defaultWidth = 327
CoD.FileshareSelectorItemWide.__defaultHeight = 186
CoD.FileshareSelectorItemWide.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FileshareSelectorItemWide)
	self.id = "FileshareSelectorItemWide"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.FileshareSelectorItemWideInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -163.5, 163.5, 0.5, 0.5, -93, 93)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local alertTriangle = LUI.UIImage.new(0, 0, 147.5, 179.5, 0, 0, 77, 109)
	alertTriangle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	alertTriangle:setAlpha(0)
	alertTriangle:setImage(RegisterImage(@"warning_triangle"))
	self:addElement(alertTriangle)
	self.alertTriangle = alertTriangle
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.FileshareUtility.IsInvalidFile(f1_arg1, element)
			end,
		},
	})
	Button.id = "Button"
	self.__defaultFocus = Button
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FileshareSelectorItemWide.__resetProperties = function(f4_arg0)
	f4_arg0.NoiseTiledBacking:completeAnimation()
	f4_arg0.Frame:completeAnimation()
	f4_arg0.Button:completeAnimation()
	f4_arg0.alertTriangle:completeAnimation()
	f4_arg0.NoiseTiledBacking:setAlpha(0)
	f4_arg0.Frame:setAlpha(0)
	f4_arg0.Button:setAlpha(1)
	f4_arg0.Button:setScale(1, 1)
	f4_arg0.alertTriangle:setAlpha(0)
end
CoD.FileshareSelectorItemWide.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.Button:completeAnimation()
			f5_arg0.Button:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Button)
			f5_arg0.NoiseTiledBacking:completeAnimation()
			f5_arg0.NoiseTiledBacking:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.NoiseTiledBacking)
			f5_arg0.Frame:completeAnimation()
			f5_arg0.Frame:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Frame)
			f5_arg0.alertTriangle:completeAnimation()
			f5_arg0.alertTriangle:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.alertTriangle)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Button:completeAnimation()
			f6_arg0.Button:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.Button)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Button:beginAnimation(200)
				f7_arg0.Button:setScale(1.05, 1.05)
				f7_arg0.Button:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Button:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Button:completeAnimation()
			f7_arg0.Button:setScale(1, 1)
			f7_local0(f7_arg0.Button)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Button:beginAnimation(200)
				f9_arg0.Button:setScale(1, 1)
				f9_arg0.Button:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Button:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Button:completeAnimation()
			f9_arg0.Button:setScale(1.05, 1.05)
			f9_local0(f9_arg0.Button)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.Button:completeAnimation()
			f11_arg0.Button:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Button)
			f11_arg0.NoiseTiledBacking:completeAnimation()
			f11_arg0.NoiseTiledBacking:setAlpha(0.85)
			f11_arg0.clipFinished(f11_arg0.NoiseTiledBacking)
			f11_arg0.Frame:completeAnimation()
			f11_arg0.Frame:setAlpha(0.25)
			f11_arg0.clipFinished(f11_arg0.Frame)
			f11_arg0.alertTriangle:completeAnimation()
			f11_arg0.alertTriangle:setAlpha(0.5)
			f11_arg0.clipFinished(f11_arg0.alertTriangle)
		end,
	},
}
CoD.FileshareSelectorItemWide.__onClose = function(f12_arg0)
	f12_arg0.Button:close()
	f12_arg0.Frame:close()
end
