CoD.WZTeamPlayerInfoNumber = InheritFrom(LUI.UIElement)
CoD.WZTeamPlayerInfoNumber.__defaultWidth = 23
CoD.WZTeamPlayerInfoNumber.__defaultHeight = 23
CoD.WZTeamPlayerInfoNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamPlayerInfoNumber)
	self.id = "WZTeamPlayerInfoNumber"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IDBacker = LUI.UIImage.new(0.5, 0.5, -10, 10, 0.5, 0.5, -10, 10)
	IDBacker:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	IDBacker:setShaderVector(0, 0.05, 0.05, 0.05, 0.05)
	IDBacker.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			IDBacker:setRGB(CoD.WZUtility.TeamPlayerColorForTeammateIndex(f1_arg1, f2_local0))
		end
	end
	IDBacker:linkToElementModel(self, "teammateIndex", true, IDBacker.__Color)
	IDBacker.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.teammateIndex
		end
		if f3_local0 then
			IDBacker.__Color(f3_local0)
		end
	end
	self:addElement(IDBacker)
	self.IDBacker = IDBacker
	local IDNumber2 = LUI.UIText.new(0.5, 0.5, -10, 10, 0, 0, 2, 22)
	IDNumber2:setTTF("ttmussels_demibold")
	IDNumber2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3336C1AE82B1520A"))
	IDNumber2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	IDNumber2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	IDNumber2:linkToElementModel(self, "teammateIndex", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			IDNumber2:setText(StringAdd(1, CoD.BaseUtility.AlreadyLocalized(f4_local0)))
		end
	end)
	self:addElement(IDNumber2)
	self.IDNumber2 = IDNumber2
	IDBacker:linkToElementModel(self, "team", true, IDBacker.__Color_FullPath)
	local f1_local3 = IDBacker
	local f1_local4 = IDBacker.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["profile.colorblindMode"], IDBacker.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "DeadDisconnected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue(element, f1_arg1, "inGamePlayerStatus", Enum[@"hash_14A07561A78E340B"][@"hash_3C233F1FA9F35C02"], Enum[@"hash_14A07561A78E340B"][@"hash_358F9A363F8FBB07"])
			end,
		},
	})
	self:linkToElementModel(self, "inGamePlayerStatus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "inGamePlayerStatus",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamPlayerInfoNumber.__resetProperties = function(f7_arg0)
	f7_arg0.IDBacker:completeAnimation()
	f7_arg0.IDBacker:setAlpha(1)
end
CoD.WZTeamPlayerInfoNumber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	DeadDisconnected = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.IDBacker:completeAnimation()
			f9_arg0.IDBacker:setAlpha(0.39)
			f9_arg0.clipFinished(f9_arg0.IDBacker)
		end,
	},
}
CoD.WZTeamPlayerInfoNumber.__onClose = function(f10_arg0)
	f10_arg0.IDBacker:close()
	f10_arg0.IDNumber2:close()
end
