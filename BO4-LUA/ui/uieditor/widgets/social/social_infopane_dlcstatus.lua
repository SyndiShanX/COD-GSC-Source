CoD.Social_InfoPane_DLCStatus = InheritFrom(LUI.UIElement)
CoD.Social_InfoPane_DLCStatus.__defaultWidth = 200
CoD.Social_InfoPane_DLCStatus.__defaultHeight = 20
CoD.Social_InfoPane_DLCStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_InfoPane_DLCStatus)
	self.id = "Social_InfoPane_DLCStatus"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DLCText = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0.5, 16.5)
	DLCText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B9675B360750903"))
	DLCText:setTTF("dinnext_regular")
	DLCText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	DLCText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(DLCText)
	self.DLCText = DLCText
	self:mergeStateConditions({
		{
			stateName = "RequiresDLC",
			condition = function(menu, element, event)
				return CoD.SocialUtility.IsPartyMissingDLCFriendRequires(f1_arg1, element)
			end,
		},
		{
			stateName = "Limited",
			condition = function(menu, element, event)
				return CoD.SocialUtility.IsPartyMissingDLCFriendUsing(f1_arg1, element)
			end,
		},
	})
	self:linkToElementModel(self, " playlist", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = " playlist",
		})
	end)
	self:linkToElementModel(self, "mapId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "mapId",
		})
	end)
	self:linkToElementModel(self, "lobbyDLCBits", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lobbyDLCBits",
		})
	end)
	self:linkToElementModel(self, "joinable", true, function(model)
		local f7_local0 = self
		UpdateSelfState(self, f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_InfoPane_DLCStatus.__resetProperties = function(f8_arg0)
	f8_arg0.DLCText:completeAnimation()
	f8_arg0.DLCText:setAlpha(1)
	f8_arg0.DLCText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B9675B360750903"))
end
CoD.Social_InfoPane_DLCStatus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.DLCText:completeAnimation()
			f9_arg0.DLCText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DLCText)
		end,
	},
	RequiresDLC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.DLCText:completeAnimation()
			f10_arg0.DLCText:setAlpha(1)
			f10_arg0.DLCText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B9675B360750903"))
			f10_arg0.clipFinished(f10_arg0.DLCText)
		end,
	},
	Limited = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.DLCText:completeAnimation()
			f11_arg0.DLCText:setAlpha(1)
			f11_arg0.DLCText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7B2A7066FD394420"))
			f11_arg0.clipFinished(f11_arg0.DLCText)
		end,
	},
}
