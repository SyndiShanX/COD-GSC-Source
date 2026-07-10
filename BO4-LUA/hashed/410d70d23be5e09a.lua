CoD.WarzoneKilledByName = InheritFrom(LUI.UIElement)
CoD.WarzoneKilledByName.__defaultWidth = 800
CoD.WarzoneKilledByName.__defaultHeight = 45
CoD.WarzoneKilledByName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 8, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WarzoneKilledByName)
	self.id = "WarzoneKilledByName"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KilledBy = LUI.UIText.new(0, 0, 240, 398, 0, 0, 0, 45)
	KilledBy:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5384588C2F4949A5"))
	KilledBy:setTTF("ttmussels_demibold")
	KilledBy:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	KilledBy:setShaderVector(0, 0, 0, 0, 0)
	KilledBy:setShaderVector(1, 0, 0, 0, 1)
	KilledBy:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(KilledBy)
	self.KilledBy = KilledBy
	local KillerName = LUI.UIText.new(0, 0, 406, 560, 0, 0, 0, 45)
	KillerName:setRGB(0.98, 0.69, 0.26)
	KillerName:setTTF("notosans_bold")
	KillerName:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	KillerName:setShaderVector(0, 0, 0, 0, 0)
	KillerName:setShaderVector(1, 0, 0, 0, 1)
	KillerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	KillerName:subscribeToGlobalModel(f1_arg1, "Attacker", "name", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			KillerName:setText(CoD.SocialUtility.CleanGamerTag(f2_local0))
		end
	end)
	self:addElement(KillerName)
	self.KillerName = KillerName
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneKilledByName.__resetProperties = function(f5_arg0)
	f5_arg0.KillerName:completeAnimation()
	f5_arg0.KilledBy:completeAnimation()
	f5_arg0.KillerName:setAlpha(1)
	f5_arg0.KilledBy:setAlpha(1)
end
CoD.WarzoneKilledByName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.KilledBy:completeAnimation()
			f7_arg0.KilledBy:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.KilledBy)
			f7_arg0.KillerName:completeAnimation()
			f7_arg0.KillerName:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.KillerName)
		end,
	},
}
CoD.WarzoneKilledByName.__onClose = function(f8_arg0)
	f8_arg0.KillerName:close()
end
