require("x64:acbf06924421e35")
CoD.WZTeamScoreboard_TeammateNumber = InheritFrom(LUI.UIElement)
CoD.WZTeamScoreboard_TeammateNumber.__defaultWidth = 52
CoD.WZTeamScoreboard_TeammateNumber.__defaultHeight = 52
CoD.WZTeamScoreboard_TeammateNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamScoreboard_TeammateNumber)
	self.id = "WZTeamScoreboard_TeammateNumber"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IDBacker = LUI.UIImage.new(0.5, 0.5, -17, 17, 0.5, 0.5, -17.5, 16.5)
	IDBacker:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
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
	local Tint = LUI.UIImage.new(0, 1, 10, -10, 0, 1, 10, -10)
	Tint:setAlpha(0.5)
	Tint:setImage(RegisterImage(0x4B6FFA90272070E))
	Tint:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Tint:setShaderVector(0, 0, 0, 0, 0)
	Tint:setupNineSliceShader(24, 24)
	self:addElement(Tint)
	self.Tint = Tint
	local IDNumber2 = LUI.UIText.new(0.5, 0.5, -26.5, 25.5, 0.5, 0.5, -13, 14)
	IDNumber2:setRGB(0.92, 0.92, 0.92)
	IDNumber2:setTTF("ttmussels_demibold")
	IDNumber2:setMaterial(LUI.UIImage.GetCachedMaterial(0x336C1AE82B1520A))
	IDNumber2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	IDNumber2:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	IDNumber2:linkToElementModel(self, "teammateIndex", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			IDNumber2:setText(StringAdd(1, CoD.BaseUtility.AlreadyLocalized(f4_local0)))
		end
	end)
	self:addElement(IDNumber2)
	self.IDNumber2 = IDNumber2
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0.5, 0.5, -16.5, 16.5, 0.5, 0.5, -17, 16)
	CommonCornerPips:setAlpha(0.4)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	IDBacker:linkToElementModel(self, "team", true, IDBacker.__Color_FullPath)
	local f1_local5 = IDBacker
	local f1_local6 = IDBacker.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["profile.colorblindMode"], IDBacker.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "DeadDisconnected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnumEitherValue(element, f1_arg1, "inGamePlayerStatus", Enum[0x4A07561A78E340B][0xC233F1FA9F35C02], Enum[0x4A07561A78E340B][0x58F9A363F8FBB07])
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
CoD.WZTeamScoreboard_TeammateNumber.__resetProperties = function(f7_arg0)
	f7_arg0.IDBacker:completeAnimation()
	f7_arg0.Tint:completeAnimation()
	f7_arg0.IDNumber2:completeAnimation()
	f7_arg0.CommonCornerPips:completeAnimation()
	f7_arg0.IDBacker:setAlpha(1)
	f7_arg0.Tint:setAlpha(0.5)
	f7_arg0.IDNumber2:setRGB(0.92, 0.92, 0.92)
	f7_arg0.CommonCornerPips:setAlpha(0.4)
end
CoD.WZTeamScoreboard_TeammateNumber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	DeadDisconnected = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			local f9_local0 = function(f10_arg0)
				f9_arg0.IDBacker:beginAnimation(200)
				f9_arg0.IDBacker:setAlpha(0.3)
				f9_arg0.IDBacker:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.IDBacker:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.IDBacker:completeAnimation()
			f9_arg0.IDBacker:setAlpha(1)
			f9_local0(f9_arg0.IDBacker)
			local f9_local1 = function(f11_arg0)
				f9_arg0.Tint:beginAnimation(200)
				f9_arg0.Tint:setAlpha(0)
				f9_arg0.Tint:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Tint:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Tint:completeAnimation()
			f9_arg0.Tint:setAlpha(1)
			f9_local1(f9_arg0.Tint)
			local f9_local2 = function(f12_arg0)
				f9_arg0.IDNumber2:beginAnimation(200)
				f9_arg0.IDNumber2:setRGB(0.33, 0.33, 0.33)
				f9_arg0.IDNumber2:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.IDNumber2:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.IDNumber2:completeAnimation()
			f9_arg0.IDNumber2:setRGB(0.92, 0.92, 0.92)
			f9_local2(f9_arg0.IDNumber2)
			local f9_local3 = function(f13_arg0)
				f9_arg0.CommonCornerPips:beginAnimation(200)
				f9_arg0.CommonCornerPips:setAlpha(0.1)
				f9_arg0.CommonCornerPips:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.CommonCornerPips:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.CommonCornerPips:completeAnimation()
			f9_arg0.CommonCornerPips:setAlpha(0.4)
			f9_local3(f9_arg0.CommonCornerPips)
		end,
	},
}
CoD.WZTeamScoreboard_TeammateNumber.__onClose = function(f14_arg0)
	f14_arg0.IDBacker:close()
	f14_arg0.IDNumber2:close()
	f14_arg0.CommonCornerPips:close()
end
