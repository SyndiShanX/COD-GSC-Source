require("x64:6e2e9d279c569a7")
CoD.Armory_AttachmentInfoContainer = InheritFrom(LUI.UIElement)
CoD.Armory_AttachmentInfoContainer.__defaultWidth = 753
CoD.Armory_AttachmentInfoContainer.__defaultHeight = 107
CoD.Armory_AttachmentInfoContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_AttachmentInfoContainer)
	self.id = "Armory_AttachmentInfoContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AttachmentInfo = CoD.Armory_AttachmentInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 753, 0, 0, 0, 107)
	self:addElement(AttachmentInfo)
	self.AttachmentInfo = AttachmentInfo
	local OpticInfo = CoD.Armory_AttachmentInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 753, 0, 0, 0, 107)
	OpticInfo:setAlpha(0)
	self:addElement(OpticInfo)
	self.OpticInfo = OpticInfo
	self:mergeStateConditions({
		{
			stateName = "NoSelection",
			condition = function(menu, element, event)
				local f2_local0
				if not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "armoryAttachmentListFocus") and not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "armoryOpticListFocus") then
					f2_local0 = IsPC()
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "OpticInfo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "armoryOpticListFocus")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.armoryAttachmentListFocus, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "armoryAttachmentListFocus",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.armoryOpticListFocus, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "armoryOpticListFocus",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Armory_AttachmentInfoContainer.__resetProperties = function(f6_arg0)
	f6_arg0.AttachmentInfo:completeAnimation()
	f6_arg0.OpticInfo:completeAnimation()
	f6_arg0.AttachmentInfo:setAlpha(1)
	f6_arg0.OpticInfo:setAlpha(0)
end
CoD.Armory_AttachmentInfoContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	NoSelection = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.AttachmentInfo:completeAnimation()
			f8_arg0.AttachmentInfo:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.AttachmentInfo)
			f8_arg0.OpticInfo:completeAnimation()
			f8_arg0.OpticInfo:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.OpticInfo)
		end,
	},
	OpticInfo = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.AttachmentInfo:completeAnimation()
			f9_arg0.AttachmentInfo:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AttachmentInfo)
			f9_arg0.OpticInfo:completeAnimation()
			f9_arg0.OpticInfo:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.OpticInfo)
		end,
	},
}
if not CoD.isPC then
	CoD.Armory_AttachmentInfoContainer.__clipsPerState.NoSelection.DefaultClip = nil
end
CoD.Armory_AttachmentInfoContainer.__onClose = function(f10_arg0)
	f10_arg0.AttachmentInfo:close()
	f10_arg0.OpticInfo:close()
end
