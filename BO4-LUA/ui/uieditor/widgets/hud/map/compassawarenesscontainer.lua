require("x64:a3dbd6e630f2045")
CoD.CompassAwarenessContainer = InheritFrom(LUI.UIElement)
CoD.CompassAwarenessContainer.__defaultWidth = 330
CoD.CompassAwarenessContainer.__defaultHeight = 330
CoD.CompassAwarenessContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassAwarenessContainer)
	self.id = "CompassAwarenessContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TopLeft = CoD.CompassAwarenessRingSegment.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 0, 330)
	TopLeft:setZRot(60)
	TopLeft:subscribeToGlobalModel(f1_arg1, "HUDItems", "awareness.seg5", function(model)
		TopLeft:setModel(model, f1_arg1)
	end)
	self:addElement(TopLeft)
	self.TopLeft = TopLeft
	local BotLeft = CoD.CompassAwarenessRingSegment.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 0, 330)
	BotLeft:setZRot(120)
	BotLeft:subscribeToGlobalModel(f1_arg1, "HUDItems", "awareness.seg4", function(model)
		BotLeft:setModel(model, f1_arg1)
	end)
	self:addElement(BotLeft)
	self.BotLeft = BotLeft
	local BotCenter = CoD.CompassAwarenessRingSegment.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 0, 330)
	BotCenter:setZRot(180)
	BotCenter:subscribeToGlobalModel(f1_arg1, "HUDItems", "awareness.seg3", function(model)
		BotCenter:setModel(model, f1_arg1)
	end)
	self:addElement(BotCenter)
	self.BotCenter = BotCenter
	local BotRight = CoD.CompassAwarenessRingSegment.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 0, 330)
	BotRight:setZRot(240)
	BotRight:subscribeToGlobalModel(f1_arg1, "HUDItems", "awareness.seg2", function(model)
		BotRight:setModel(model, f1_arg1)
	end)
	self:addElement(BotRight)
	self.BotRight = BotRight
	local TopRight = CoD.CompassAwarenessRingSegment.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 0, 330)
	TopRight:setZRot(300)
	TopRight:subscribeToGlobalModel(f1_arg1, "HUDItems", "awareness.seg1", function(model)
		TopRight:setModel(model, f1_arg1)
	end)
	self:addElement(TopRight)
	self.TopRight = TopRight
	local TopCenter = CoD.CompassAwarenessRingSegment.new(f1_arg0, f1_arg1, 0, 0, 0, 330, 0, 0, 0, 330)
	TopCenter:subscribeToGlobalModel(f1_arg1, "HUDItems", "awareness.seg0", function(model)
		TopCenter:setModel(model, f1_arg1)
	end)
	self:addElement(TopCenter)
	self.TopCenter = TopCenter
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "huditems.awareness", 1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["huditems.awareness"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "huditems.awareness",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassAwarenessContainer.__resetProperties = function(f10_arg0)
	f10_arg0.TopLeft:completeAnimation()
	f10_arg0.TopCenter:completeAnimation()
	f10_arg0.TopRight:completeAnimation()
	f10_arg0.BotRight:completeAnimation()
	f10_arg0.BotCenter:completeAnimation()
	f10_arg0.BotLeft:completeAnimation()
	f10_arg0.TopLeft:setAlpha(1)
	f10_arg0.TopCenter:setAlpha(1)
	f10_arg0.TopRight:setAlpha(1)
	f10_arg0.BotRight:setAlpha(1)
	f10_arg0.BotCenter:setAlpha(1)
	f10_arg0.BotLeft:setAlpha(1)
end
CoD.CompassAwarenessContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.TopLeft:completeAnimation()
			f11_arg0.TopLeft:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.TopLeft)
			f11_arg0.BotLeft:completeAnimation()
			f11_arg0.BotLeft:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.BotLeft)
			f11_arg0.BotCenter:completeAnimation()
			f11_arg0.BotCenter:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.BotCenter)
			f11_arg0.BotRight:completeAnimation()
			f11_arg0.BotRight:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.BotRight)
			f11_arg0.TopRight:completeAnimation()
			f11_arg0.TopRight:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.TopRight)
			f11_arg0.TopCenter:completeAnimation()
			f11_arg0.TopCenter:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.TopCenter)
		end,
	},
	Invisible = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			f12_arg0.TopLeft:completeAnimation()
			f12_arg0.TopLeft:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TopLeft)
			f12_arg0.BotLeft:completeAnimation()
			f12_arg0.BotLeft:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BotLeft)
			f12_arg0.BotCenter:completeAnimation()
			f12_arg0.BotCenter:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BotCenter)
			f12_arg0.BotRight:completeAnimation()
			f12_arg0.BotRight:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.BotRight)
			f12_arg0.TopRight:completeAnimation()
			f12_arg0.TopRight:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TopRight)
			f12_arg0.TopCenter:completeAnimation()
			f12_arg0.TopCenter:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TopCenter)
		end,
	},
}
CoD.CompassAwarenessContainer.__onClose = function(f13_arg0)
	f13_arg0.TopLeft:close()
	f13_arg0.BotLeft:close()
	f13_arg0.BotCenter:close()
	f13_arg0.BotRight:close()
	f13_arg0.TopRight:close()
	f13_arg0.TopCenter:close()
end
