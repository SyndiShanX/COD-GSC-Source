CoD.ClanInboxAcceptedWidget = InheritFrom(LUI.UIElement)
CoD.ClanInboxAcceptedWidget.__defaultWidth = 100
CoD.ClanInboxAcceptedWidget.__defaultHeight = 50
CoD.ClanInboxAcceptedWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ClanInboxAcceptedWidget)
	self.id = "ClanInboxAcceptedWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AcceptedText = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 30)
	AcceptedText:setRGB(0, 1, 0)
	AcceptedText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3D0E687E8FBC95C7"))
	AcceptedText:setTTF("default")
	AcceptedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	AcceptedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(AcceptedText)
	self.AcceptedText = AcceptedText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNil(self, f1_arg1, "accepted")
			end,
		},
	})
	self:linkToElementModel(self, "accepted", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "accepted",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ClanInboxAcceptedWidget.__resetProperties = function(f4_arg0)
	f4_arg0.AcceptedText:completeAnimation()
	f4_arg0.AcceptedText:setAlpha(1)
end
CoD.ClanInboxAcceptedWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.AcceptedText:completeAnimation()
			f6_arg0.AcceptedText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AcceptedText)
		end,
	},
}
