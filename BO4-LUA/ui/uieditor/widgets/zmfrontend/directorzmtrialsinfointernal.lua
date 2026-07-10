require("x64:e3afa26bf197ec1")
CoD.DirectorZMTrialsInfoInternal = InheritFrom(LUI.UIElement)
CoD.DirectorZMTrialsInfoInternal.__defaultWidth = 1920
CoD.DirectorZMTrialsInfoInternal.__defaultHeight = 1080
CoD.DirectorZMTrialsInfoInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorZMTrialsInfoInternal)
	self.id = "DirectorZMTrialsInfoInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Trials = LUI.UIText.new(0.5, 0.5, -750, -144, 0.5, 0.5, -426, -354)
	Trials:setTTF("ttmussels_demibold")
	Trials:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Trials:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Trials:subscribeToGlobalModel(f1_arg1, "ZMLobbyExclusions", "ZMPlaylistTab", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Trials:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f2_local0))
		end
	end)
	self:addElement(Trials)
	self.Trials = Trials
	local TrialsIcon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -860, -760, 0.5, 0.5, -454, -354)
	TrialsIcon:setStretchedDimension(4)
	TrialsIcon:subscribeToGlobalModel(f1_arg1, "ZMLobbyExclusions", "ZMPlaylistTab", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TrialsIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f3_local0)))
		end
	end)
	self:addElement(TrialsIcon)
	self.TrialsIcon = TrialsIcon
	local TrialsDesc = LUI.UIText.new(0.5, 0.5, -860, -360, 0.5, 0.5, -274, -244)
	TrialsDesc:setTTF("ttmussels_regular")
	TrialsDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TrialsDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TrialsDesc:subscribeToGlobalModel(f1_arg1, "ZMLobbyExclusions", "ZMPlaylistTab", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TrialsDesc:setText(CoD.GameTypeUtility.GameTypeToLocalizeDesc(f4_local0))
		end
	end)
	self:addElement(TrialsDesc)
	self.TrialsDesc = TrialsDesc
	local Line = LUI.UIImage.new(0.5, 0.5, -860, -360, 0.5, 0.5, -294, -292)
	Line:setAlpha(0.25)
	self:addElement(Line)
	self.Line = Line
	local TrialsInfo = CoD.DirectorZMTrialsInfoDescriptionTall.new(f1_arg0, f1_arg1, 0.5, 0.5, -300, 890, 0.5, 0.5, -355, 341)
	TrialsInfo:mergeStateConditions({
		{
			stateName = "Variant1",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsFocusedPlaylistTrialVariant(1)
			end,
		},
	})
	local f1_local6 = TrialsInfo
	local f1_local7 = TrialsInfo.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["ZMLobbyExclusions.focusedPlaylistID"], function(f6_arg0)
		f1_arg0:updateElementState(TrialsInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "ZMLobbyExclusions.focusedPlaylistID",
		})
	end, false)
	TrialsInfo:setScale(1.1, 1.1)
	self:addElement(TrialsInfo)
	self.TrialsInfo = TrialsInfo
	TrialsInfo.id = "TrialsInfo"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorZMTrialsInfoInternal.__onClose = function(f7_arg0)
	f7_arg0.Trials:close()
	f7_arg0.TrialsIcon:close()
	f7_arg0.TrialsDesc:close()
	f7_arg0.TrialsInfo:close()
end
