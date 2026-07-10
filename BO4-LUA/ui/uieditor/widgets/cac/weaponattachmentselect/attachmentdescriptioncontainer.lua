require("x64:2a69462aa4245ee")
CoD.AttachmentDescriptionContainer = InheritFrom(LUI.UIElement)
CoD.AttachmentDescriptionContainer.__defaultWidth = 200
CoD.AttachmentDescriptionContainer.__defaultHeight = 30
CoD.AttachmentDescriptionContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttachmentDescriptionContainer)
	self.id = "AttachmentDescriptionContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Connector = LUI.UIImage.new(0, 0, 150, 239, 0, 0, 0, 30)
	Connector:setAlpha(0)
	Connector:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aar_segment"))
	Connector:setShaderVector(0, 1, 0, 0, 0)
	Connector:setShaderVector(1, 0.7, 0, 0, 0)
	Connector:setShaderVector(2, 0.25, 0, 0, 0)
	self:addElement(Connector)
	self.Connector = Connector
	local Header = CoD.AttachmentDescriptionHeader.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 0, 0, 0, 30)
	Header:setAlpha(0)
	Header:linkToElementModel(self, nil, false, function(model)
		Header:setModel(model, f1_arg1)
	end)
	self:addElement(Header)
	self.Header = Header
	self:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.WeaponAttachmentsUtility.ShouldShowAttachmentFlyout(menu, element, f1_arg1) and not CoD.WeaponAttachmentsUtility.ShouldHideBaseAttachmentFlyout(menu, element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "attachmentInFocus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "attachmentInFocus",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttachmentDescriptionContainer.__resetProperties = function(f5_arg0)
	f5_arg0.Header:completeAnimation()
	f5_arg0.Connector:completeAnimation()
	f5_arg0.Header:setAlpha(0)
	f5_arg0.Connector:setAlpha(0)
end
CoD.AttachmentDescriptionContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Full = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(99)
					f9_arg0:setAlpha(1)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.Connector:beginAnimation(140)
				f7_arg0.Connector:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Connector:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.Connector:completeAnimation()
			f7_arg0.Connector:setAlpha(0)
			f7_local0(f7_arg0.Connector)
			local f7_local1 = function(f10_arg0)
				f7_arg0.Header:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
				f7_arg0.Header:setAlpha(1)
				f7_arg0.Header:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Header:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Header:completeAnimation()
			f7_arg0.Header:setAlpha(0)
			f7_local1(f7_arg0.Header)
		end,
	},
	Full = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Connector:completeAnimation()
			f11_arg0.Connector:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Connector)
			f11_arg0.Header:completeAnimation()
			f11_arg0.Header:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Header)
		end,
	},
}
CoD.AttachmentDescriptionContainer.__onClose = function(f12_arg0)
	f12_arg0.Header:close()
end
