require("x64:bce07fcd345de2a")
CoD.EmblemEditorColorTypeHeader = InheritFrom(LUI.UIElement)
CoD.EmblemEditorColorTypeHeader.__defaultWidth = 1020
CoD.EmblemEditorColorTypeHeader.__defaultHeight = 45
CoD.EmblemEditorColorTypeHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorColorTypeHeader)
	self.id = "EmblemEditorColorTypeHeader"
	self.soundSet = "SelectColor"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local colorTypeHeader = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 0, 320, 0, 0, 0, 45)
	colorTypeHeader.text:setText(Engine[0xF9F1239CFD921FE](0x1CFC542812AB4D9))
	self:addElement(colorTypeHeader)
	self.colorTypeHeader = colorTypeHeader
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorColorTypeHeader.__resetProperties = function(f2_arg0)
	f2_arg0.colorTypeHeader:completeAnimation()
	f2_arg0.colorTypeHeader:setLeftRight(0, 0, 0, 320)
	f2_arg0.colorTypeHeader.text:setText(Engine[0xF9F1239CFD921FE](0x1CFC542812AB4D9))
end
CoD.EmblemEditorColorTypeHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.colorTypeHeader:completeAnimation()
			f3_arg0.colorTypeHeader.text:completeAnimation()
			f3_arg0.colorTypeHeader:setLeftRight(0, 0, 70, 390)
			f3_arg0.colorTypeHeader.text:setText(Engine[0xF9F1239CFD921FE](0xC4976856521A15E))
			f3_arg0.clipFinished(f3_arg0.colorTypeHeader)
		end,
	},
	Gradient = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.colorTypeHeader:completeAnimation()
			f4_arg0.colorTypeHeader.text:completeAnimation()
			f4_arg0.colorTypeHeader:setLeftRight(0, 0, 70, 390)
			f4_arg0.colorTypeHeader.text:setText(Engine[0xF9F1239CFD921FE](0xC4976856521A15E))
			f4_arg0.clipFinished(f4_arg0.colorTypeHeader)
		end,
	},
	Solid = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.colorTypeHeader:completeAnimation()
			f5_arg0.colorTypeHeader:setLeftRight(0, 0, 30, 350)
			f5_arg0.clipFinished(f5_arg0.colorTypeHeader)
		end,
	},
	Mixer = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.colorTypeHeader:completeAnimation()
			f6_arg0.colorTypeHeader.text:completeAnimation()
			f6_arg0.colorTypeHeader:setLeftRight(0, 0, 70, 390)
			f6_arg0.colorTypeHeader.text:setText(Engine[0xF9F1239CFD921FE](0x18A7DE2D378A687))
			f6_arg0.clipFinished(f6_arg0.colorTypeHeader)
		end,
	},
}
CoD.EmblemEditorColorTypeHeader.__onClose = function(f7_arg0)
	f7_arg0.colorTypeHeader:close()
end
