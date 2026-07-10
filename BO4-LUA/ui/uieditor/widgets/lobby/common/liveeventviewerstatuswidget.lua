CoD.LiveEventViewerStatusWidget = InheritFrom(LUI.UIElement)
CoD.LiveEventViewerStatusWidget.__defaultWidth = 76
CoD.LiveEventViewerStatusWidget.__defaultHeight = 37
CoD.LiveEventViewerStatusWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.LiveEventViewerStatusWidget)
	self.id = "LiveEventViewerStatusWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local liveLabel = LUI.UIText.new(0, 0, 38, 77, 0.5, 0.5, -19, 19)
	liveLabel:setText(Engine[0xF9F1239CFD921FE](0x4AD4D7A985521CF))
	liveLabel:setTTF("default")
	liveLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(liveLabel)
	self.liveLabel = liveLabel
	local liveCircle = LUI.UIImage.new(0, 0, 0, 30, 0.5, 0.5, -15, 15)
	liveCircle:setRGB(1, 0, 0)
	liveCircle:setMaterial(LUI.UIImage.GetCachedMaterial(0x50BD503A1EC49C7))
	liveCircle:setShaderVector(0, 8, 2, 0, 0)
	liveCircle:setShaderVector(1, 20, 20, 0, 0)
	liveCircle:setShaderVector(2, 0.2, 0.2, 0, 0)
	self:addElement(liveCircle)
	self.liveCircle = liveCircle
	self:mergeStateConditions({
		{
			stateName = "Live",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToEnum("liveEventViewer.liveState", Enum[0x2F0D281157F67C6][0xE232211FE48ADBF])
			end,
		},
		{
			stateName = "Replay",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToEnum("liveEventViewer.liveState", Enum[0x2F0D281157F67C6][0xDD0743E74B029A2])
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["liveEventViewer.liveState"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "liveEventViewer.liveState",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LiveEventViewerStatusWidget.__resetProperties = function(f5_arg0)
	f5_arg0.liveCircle:completeAnimation()
	f5_arg0.liveLabel:completeAnimation()
	f5_arg0.liveCircle:setRGB(1, 0, 0)
	f5_arg0.liveCircle:setAlpha(1)
	f5_arg0.liveLabel:setAlpha(1)
	f5_arg0.liveLabel:setText(Engine[0xF9F1239CFD921FE](0x4AD4D7A985521CF))
end
CoD.LiveEventViewerStatusWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.liveLabel:completeAnimation()
			f6_arg0.liveLabel:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.liveLabel)
			f6_arg0.liveCircle:completeAnimation()
			f6_arg0.liveCircle:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.liveCircle)
		end,
		ShowPrompts = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Live = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Replay = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.liveLabel:completeAnimation()
			f9_arg0.liveLabel:setText(Engine[0xF9F1239CFD921FE](0xD9EF34E16C4EB58))
			f9_arg0.clipFinished(f9_arg0.liveLabel)
			f9_arg0.liveCircle:completeAnimation()
			f9_arg0.liveCircle:setRGB(0.02, 1, 0)
			f9_arg0.clipFinished(f9_arg0.liveCircle)
		end,
	},
}
