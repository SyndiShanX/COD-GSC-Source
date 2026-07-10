require("x64:d22d3654b78ec39")
require("x64:13d5a17c4f0faca")
require("x64:a3a4f3b51153287")
require("x64:1bd88f5d2b4f0ca")
CoD.DirectorMapAndGameType = InheritFrom(LUI.UIElement)
CoD.DirectorMapAndGameType.__defaultWidth = 356
CoD.DirectorMapAndGameType.__defaultHeight = 200
CoD.DirectorMapAndGameType.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.theaterDataDownloaded")
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.theaterDownloadPercent")
	self:setClass(CoD.DirectorMapAndGameType)
	self.id = "DirectorMapAndGameType"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapVoteNoDemoSelected = CoD.MapVoteNoDemoSelected.new(f1_arg0, f1_arg1, 0, 0, 0, 356, 0, 0, 0, 200)
	self:addElement(MapVoteNoDemoSelected)
	self.MapVoteNoDemoSelected = MapVoteNoDemoSelected
	local MapImage = CoD.DirectorMapAndGameTypeContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 356, 0, 0, 0, 200)
	MapImage:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage.DirectorMapAndGameInternal.MapImage:setImage(RegisterImage(MapNameToMapImage(f2_local0)))
		end
	end)
	MapImage:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MapImage.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label:setText(CoD.GameTypeUtility.GameTypeXHashToLocalizedGameType(f3_local0))
		end
	end)
	MapImage:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MapImage.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(MapNameToLocalizedMapName(f4_local0))
		end
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local FileshareSpinner = CoD.FileshareSpinner.new(f1_arg0, f1_arg1, 0.5, 0.5, -48, 48, 0.5, 0.5, -36, 60)
	FileshareSpinner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	FileshareSpinner:setAlpha(0)
	self:addElement(FileshareSpinner)
	self.FileshareSpinner = FileshareSpinner
	local DownloadPercent = LUI.UIText.new(0.5, 0.5, -186.5, 186.5, 0, 0, 149, 187)
	DownloadPercent:setAlpha(0)
	DownloadPercent:setTTF("default")
	DownloadPercent:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DownloadPercent:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DownloadPercent:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "theaterDownloadPercent", function(model)
		if model:get() ~= nil then
			DownloadPercent:setText(FileshareGetDownloadProgress())
		end
	end)
	self:addElement(DownloadPercent)
	self.DownloadPercent = DownloadPercent
	local TeamName = LUI.UIText.new(0, 0, 149.5, 349.5, 0, 0, 163, 193)
	TeamName:setTTF("default")
	TeamName:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	TeamName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TeamName:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			TeamName:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.MapUtility.GetMapTeamNameFromMapID(f7_local0)))
		end
	end)
	self:addElement(TeamName)
	self.TeamName = TeamName
	local PCTooltipExceptionWidget = nil
	PCTooltipExceptionWidget = CoD.PC_TooltipExceptionWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -178, 178, 1, 1, -28, 0)
	PCTooltipExceptionWidget:setAlpha(0)
	PCTooltipExceptionWidget.Tip:setText(LocalizeToUpperString(@"hash_11496B17DC3093F9"))
	self:addElement(PCTooltipExceptionWidget)
	self.PCTooltipExceptionWidget = PCTooltipExceptionWidget
	self:mergeStateConditions({
		{
			stateName = "NoDemoSelected",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorTheater(f1_arg1) and not IsFilmSelected()
			end,
		},
		{
			stateName = "DemoSelectedDownloading",
			condition = function(menu, element, event)
				local f9_local0 = CoD.DirectorUtility.ShowDirectorTheater(f1_arg1)
				if f9_local0 then
					f9_local0 = IsFilmSelected()
					if f9_local0 then
						f9_local0 = not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.theaterDownloadPercent", 99)
					end
				end
				return f9_local0
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.theaterDataDownloaded"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.theaterDataDownloaded",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.theaterDownloadPercent"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.theaterDownloadPercent",
		})
	end, false)
	MapVoteNoDemoSelected.id = "MapVoteNoDemoSelected"
	MapImage.id = "MapImage"
	self.__defaultFocus = MapImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorMapAndGameType.__resetProperties = function(f13_arg0)
	f13_arg0.MapVoteNoDemoSelected:completeAnimation()
	f13_arg0.MapImage:completeAnimation()
	f13_arg0.DownloadPercent:completeAnimation()
	f13_arg0.FileshareSpinner:completeAnimation()
	f13_arg0.PCTooltipExceptionWidget:completeAnimation()
	f13_arg0.TeamName:completeAnimation()
	f13_arg0.MapVoteNoDemoSelected:setAlpha(1)
	f13_arg0.MapImage:setAlpha(1)
	f13_arg0.DownloadPercent:setAlpha(0)
	f13_arg0.FileshareSpinner:setAlpha(0)
	f13_arg0.PCTooltipExceptionWidget:setAlpha(0)
	f13_arg0.TeamName:setLeftRight(0, 0, 149.5, 349.5)
	f13_arg0.TeamName:setTopBottom(0, 0, 163, 193)
	f13_arg0.TeamName:setAlpha(1)
end
CoD.DirectorMapAndGameType.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.MapVoteNoDemoSelected:completeAnimation()
			f14_arg0.MapVoteNoDemoSelected:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.MapVoteNoDemoSelected)
			f14_arg0.MapImage:completeAnimation()
			f14_arg0.MapImage:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.MapImage)
			f14_arg0.FileshareSpinner:completeAnimation()
			f14_arg0.FileshareSpinner:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.FileshareSpinner)
			f14_arg0.DownloadPercent:completeAnimation()
			f14_arg0.DownloadPercent:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.DownloadPercent)
			f14_arg0.PCTooltipExceptionWidget:completeAnimation()
			f14_arg0.PCTooltipExceptionWidget:setAlpha(1)
			f14_arg0.PCTooltipExceptionWidget:playClip("DefaultClip")
			f14_arg0.clipFinished(f14_arg0.PCTooltipExceptionWidget)
		end,
	},
	NoDemoSelected = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(5)
			f15_arg0.MapVoteNoDemoSelected:completeAnimation()
			f15_arg0.MapVoteNoDemoSelected:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.MapVoteNoDemoSelected)
			f15_arg0.MapImage:completeAnimation()
			f15_arg0.MapImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.MapImage)
			f15_arg0.FileshareSpinner:completeAnimation()
			f15_arg0.FileshareSpinner:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.FileshareSpinner)
			f15_arg0.DownloadPercent:completeAnimation()
			f15_arg0.DownloadPercent:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DownloadPercent)
			f15_arg0.TeamName:completeAnimation()
			f15_arg0.TeamName:setLeftRight(0, 0, 251.5, 451.5)
			f15_arg0.TeamName:setTopBottom(0, 0, 216, 241)
			f15_arg0.TeamName:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TeamName)
		end,
	},
	DemoSelectedDownloading = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(5)
			f16_arg0.MapVoteNoDemoSelected:completeAnimation()
			f16_arg0.MapVoteNoDemoSelected:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.MapVoteNoDemoSelected)
			f16_arg0.MapImage:completeAnimation()
			f16_arg0.MapImage:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.MapImage)
			f16_arg0.FileshareSpinner:completeAnimation()
			f16_arg0.FileshareSpinner:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.FileshareSpinner)
			f16_arg0.DownloadPercent:completeAnimation()
			f16_arg0.DownloadPercent:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.DownloadPercent)
			f16_arg0.TeamName:completeAnimation()
			f16_arg0.TeamName:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamName)
		end,
	},
}
CoD.DirectorMapAndGameType.__onClose = function(f17_arg0)
	f17_arg0.MapVoteNoDemoSelected:close()
	f17_arg0.MapImage:close()
	f17_arg0.FileshareSpinner:close()
	f17_arg0.DownloadPercent:close()
	f17_arg0.TeamName:close()
	f17_arg0.PCTooltipExceptionWidget:close()
end
