require("ui/uieditor/widgets/common/commonidentitywidgetstreamlinedinternal")
CoD.CommonIdentityWidgetStreamlined = InheritFrom(LUI.UIElement)
CoD.CommonIdentityWidgetStreamlined.__defaultWidth = 530
CoD.CommonIdentityWidgetStreamlined.__defaultHeight = 40
CoD.CommonIdentityWidgetStreamlined.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.CommonIdentityWidgetStreamlined)
	self.id = "CommonIdentityWidgetStreamlined"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IdentityWidgetStreamlined = CoD.CommonIdentityWidgetStreamlinedInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 530, 0, 0, 0, 40)
	IdentityWidgetStreamlined:linkToElementModel(self, nil, false, function(model)
		IdentityWidgetStreamlined:setModel(model, f1_arg1)
	end)
	self:addElement(IdentityWidgetStreamlined)
	self.IdentityWidgetStreamlined = IdentityWidgetStreamlined
	self:mergeStateConditions({
		{
			stateName = "PCIngame",
			condition = function(menu, element, event)
				return IsPC() and IsInGame()
			end,
		},
		{
			stateName = "PCCODPointsPopup",
			condition = function(menu, element, event)
				return IsPC() and AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	if InFrontend() then
		CoD.BaseUtility.SelfHidesBuildInfo(self)
	end
	return self
end
CoD.CommonIdentityWidgetStreamlined.__resetProperties = function(f5_arg0)
	f5_arg0.IdentityWidgetStreamlined:completeAnimation()
	f5_arg0.IdentityWidgetStreamlined:setLeftRight(0, 0, 0, 530)
	f5_arg0.IdentityWidgetStreamlined.membername.TiledwhiteNoiseBacking:setAlpha(0.02)
end
CoD.CommonIdentityWidgetStreamlined.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	PCIngame = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.IdentityWidgetStreamlined:completeAnimation()
			f7_arg0.IdentityWidgetStreamlined:setLeftRight(0, 0, -153, 377)
			f7_arg0.clipFinished(f7_arg0.IdentityWidgetStreamlined)
		end,
	},
	PCCODPointsPopup = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.IdentityWidgetStreamlined:completeAnimation()
			f8_arg0.IdentityWidgetStreamlined.membername.TiledwhiteNoiseBacking:completeAnimation()
			f8_arg0.IdentityWidgetStreamlined.membername.TiledwhiteNoiseBacking:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.IdentityWidgetStreamlined)
		end,
	},
}
CoD.CommonIdentityWidgetStreamlined.__onClose = function(f9_arg0)
	f9_arg0.IdentityWidgetStreamlined:close()
end
