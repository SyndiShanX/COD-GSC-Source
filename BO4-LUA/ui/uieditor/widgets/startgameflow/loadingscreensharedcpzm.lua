require("ui/uieditor/widgets/hud/movieplayback/moviesubtitles")
require("ui/uieditor/widgets/loadinganimation/loadingscreenskipprompt")
require("ui/uieditor/widgets/notifications/xp/doublexpiconsleftaligned")
require("ui/uieditor/widgets/startgameflow/loadingscreentalkerwidgetcpzm")
CoD.LoadingScreenSharedCPZM = InheritFrom(LUI.UIElement)
CoD.LoadingScreenSharedCPZM.__defaultWidth = 1920
CoD.LoadingScreenSharedCPZM.__defaultHeight = 1080
CoD.LoadingScreenSharedCPZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.HUDUtility.InitLoadingMovie(f1_arg1)
	self:setClass(CoD.LoadingScreenSharedCPZM)
	self.id = "LoadingScreenSharedCPZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local loadingImageOrMovie = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	loadingImageOrMovie:setRGB(0, 0, 0)
	self:addElement(loadingImageOrMovie)
	self.loadingImageOrMovie = loadingImageOrMovie
	local label = CoD.LoadingScreenSkipPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	label:registerEventHandler("loading_displaycontinue", function(element, event)
		local f2_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) then
			SetElementState(self, element, f1_arg1, "VisiblePC")
		else
			SetElementState(self, element, f1_arg1, "Visible")
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(label)
	self.label = label
	local Team1PlayerList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	Team1PlayerList:setLeftRight(0.5, 0.5, -864, -534)
	Team1PlayerList:setTopBottom(0, 0, 174, 306)
	Team1PlayerList:setWidgetType(CoD.LoadingScreenTalkerWidgetCPZM)
	Team1PlayerList:setVerticalCount(4)
	Team1PlayerList:setSpacing(8)
	Team1PlayerList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Team1PlayerList:setDataSource("LoadingScreenPlayerListTeam1")
	self:addElement(Team1PlayerList)
	self.Team1PlayerList = Team1PlayerList
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 192, -192, 0, 0, 1004, 1028)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local loadingBarBG = LUI.UIImage.new(0, 1, 198, -198, 0, 0, 1010, 1022)
	loadingBarBG:setRGB(0.2, 0.2, 0.2)
	loadingBarBG:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(loadingBarBG)
	self.loadingBarBG = loadingBarBG
	local loadingBar = LUI.UIImage.new(0, 1, 186, -186, 0, 0, 1000, 1032)
	loadingBar:setRGB(0.6, 0.6, 0.6)
	loadingBar:setImage(RegisterImage("uie_ui_menu_loadingbar_fill_zm"))
	loadingBar:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	loadingBar:setShaderVector(1, 0, 0, 0, 0)
	loadingBar:setShaderVector(2, 1, 0, 0, 0)
	loadingBar:setShaderVector(3, 0, 0, 0, 0)
	loadingBar:setShaderVector(4, 0, 0, 0, 0)
	loadingBar:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "loadedFraction", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			loadingBar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(loadingBar)
	self.loadingBar = loadingBar
	local loadingBarAdd = LUI.UIImage.new(0, 1, 186, -186, 0, 0, 1004, 1028)
	loadingBarAdd:setRGB(0.6, 0.6, 0.6)
	loadingBarAdd:setImage(RegisterImage("uie_ui_menu_loadingbar_fill_zm"))
	loadingBarAdd:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe"))
	loadingBarAdd:setShaderVector(1, 0, 0, 0, 0)
	loadingBarAdd:setShaderVector(2, 1, 0, 0, 0)
	loadingBarAdd:setShaderVector(3, 0, 0, 0, 0)
	loadingBarAdd:setShaderVector(4, 0, 0, 0, 0)
	loadingBarAdd:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "loadedFraction", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			loadingBarAdd:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(loadingBarAdd)
	self.loadingBarAdd = loadingBarAdd
	local Status = LUI.UIText.new(1, 1, -553, -198, 1, 1, -47, -23)
	Status:setRGB(0.87, 0.9, 0.9)
	Status:setTTF("default")
	Status:setLetterSpacing(-1)
	Status:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	Status:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "statusText", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Status:setText(f5_local0)
		end
	end)
	self:addElement(Status)
	self.Status = Status
	local MapName = LUI.UIText.new(0, 0, 96, 1234, 0, 0, 54, 98)
	MapName:setRGB(0.8, 0.11, 0.11)
	MapName:setTTF("skorzhen")
	MapName:setLetterSpacing(-1)
	MapName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	MapName:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "mapName", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MapName:setText(f6_local0)
		end
	end)
	self:addElement(MapName)
	self.MapName = MapName
	local Location = LUI.UIText.new(0, 0, 96, 690, 0, 0, 139, 171)
	Location:setRGB(0.87, 0.9, 0.9)
	Location:setTTF("skorzhen")
	Location:setLetterSpacing(-1)
	Location:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Location:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "location", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Location:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(Location)
	self.Location = Location
	local GameType = LUI.UIText.new(0, 0, 96, 690, 0, 0, 104, 136)
	GameType:setRGB(0.58, 0.85, 1)
	GameType:setTTF("skorzhen")
	GameType:setLetterSpacing(-1)
	GameType:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GameType:subscribeToGlobalModel(f1_arg1, "LoadingScreenTeamInfo", "gameType", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			GameType:setText(f8_local0)
		end
	end)
	self:addElement(GameType)
	self.GameType = GameType
	local cinematicSubtitles = CoD.MovieSubtitles.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(cinematicSubtitles)
	self.cinematicSubtitles = cinematicSubtitles
	local DoubleXPIconsLeftAligned = CoD.DoubleXPIconsLeftAligned.new(f1_arg0, f1_arg1, 0.5, 0.5, -774, -558, 1, 1, -152, -80)
	self:addElement(DoubleXPIconsLeftAligned)
	self.DoubleXPIconsLeftAligned = DoubleXPIconsLeftAligned
	self:mergeStateConditions({
		{
			stateName = "Movie",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsMovieShowing(f1_arg1)
			end,
		},
	})
	Team1PlayerList.id = "Team1PlayerList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local14 = self
	if IsZombies() then
		CoD.ZMStoryUtility.SetSelectedStoryOnLoad()
	end
	CoD.HUDUtility.InitLoadingImageOrMovie(loadingImageOrMovie, f1_arg1)
	return self
end
CoD.LoadingScreenSharedCPZM.__resetProperties = function(f10_arg0)
	f10_arg0.loadingBar:completeAnimation()
	f10_arg0.Team1PlayerList:completeAnimation()
	f10_arg0.Location:completeAnimation()
	f10_arg0.MapName:completeAnimation()
	f10_arg0.GameType:completeAnimation()
	f10_arg0.loadingBarAdd:completeAnimation()
	f10_arg0.label:completeAnimation()
	f10_arg0.DoubleXPIconsLeftAligned:completeAnimation()
	f10_arg0.loadingBarBG:completeAnimation()
	f10_arg0.Status:completeAnimation()
	f10_arg0.NoiseTiledBacking:completeAnimation()
	f10_arg0.loadingBar:setAlpha(1)
	f10_arg0.Team1PlayerList:setLeftRight(0.5, 0.5, -864, -534)
	f10_arg0.Team1PlayerList:setTopBottom(0, 0, 174, 306)
	f10_arg0.Location:setAlpha(1)
	f10_arg0.MapName:setAlpha(1)
	f10_arg0.GameType:setAlpha(1)
	f10_arg0.loadingBarAdd:setTopBottom(0, 0, 1004, 1028)
	f10_arg0.loadingBarAdd:setAlpha(1)
	f10_arg0.label:setAlpha(1)
	f10_arg0.DoubleXPIconsLeftAligned:setAlpha(1)
	f10_arg0.loadingBarBG:setAlpha(1)
	f10_arg0.Status:setAlpha(1)
	f10_arg0.NoiseTiledBacking:setAlpha(1)
end
CoD.LoadingScreenSharedCPZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(8)
			f11_arg0.label:completeAnimation()
			f11_arg0.label:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.label)
			f11_arg0.Team1PlayerList:completeAnimation()
			f11_arg0.Team1PlayerList:setLeftRight(0.5, 0.5, -864, -579)
			f11_arg0.Team1PlayerList:setTopBottom(0, 0, 159, 289)
			f11_arg0.clipFinished(f11_arg0.Team1PlayerList)
			f11_arg0.loadingBar:completeAnimation()
			f11_arg0.loadingBar:setAlpha(0.8)
			f11_arg0.clipFinished(f11_arg0.loadingBar)
			f11_arg0.loadingBarAdd:completeAnimation()
			f11_arg0.loadingBarAdd:setTopBottom(0, 0, 1000, 1032)
			f11_arg0.clipFinished(f11_arg0.loadingBarAdd)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(500)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.MapName:beginAnimation(500)
				f11_arg0.MapName:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.MapName:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.MapName:completeAnimation()
			f11_arg0.MapName:setAlpha(0)
			f11_local0(f11_arg0.MapName)
			local f11_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(500)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.Location:beginAnimation(1500)
				f11_arg0.Location:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Location:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f11_arg0.Location:completeAnimation()
			f11_arg0.Location:setAlpha(0)
			f11_local1(f11_arg0.Location)
			local f11_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(500)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.GameType:beginAnimation(1000)
				f11_arg0.GameType:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.GameType:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f11_arg0.GameType:completeAnimation()
			f11_arg0.GameType:setAlpha(0)
			f11_local2(f11_arg0.GameType)
			local f11_local3 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(500)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.DoubleXPIconsLeftAligned:beginAnimation(2000)
				f11_arg0.DoubleXPIconsLeftAligned:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DoubleXPIconsLeftAligned:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f11_arg0.DoubleXPIconsLeftAligned:completeAnimation()
			f11_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
			f11_local3(f11_arg0.DoubleXPIconsLeftAligned)
		end,
	},
	Movie = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(10)
			f20_arg0.Team1PlayerList:completeAnimation()
			f20_arg0.Team1PlayerList:setLeftRight(0.5, 0.5, -864, -579)
			f20_arg0.Team1PlayerList:setTopBottom(0, 0, 54, 184)
			f20_arg0.clipFinished(f20_arg0.Team1PlayerList)
			f20_arg0.NoiseTiledBacking:completeAnimation()
			f20_arg0.NoiseTiledBacking:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.NoiseTiledBacking)
			f20_arg0.loadingBarBG:completeAnimation()
			f20_arg0.loadingBarBG:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.loadingBarBG)
			f20_arg0.loadingBar:completeAnimation()
			f20_arg0.loadingBar:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.loadingBar)
			f20_arg0.loadingBarAdd:completeAnimation()
			f20_arg0.loadingBarAdd:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.loadingBarAdd)
			f20_arg0.Status:completeAnimation()
			f20_arg0.Status:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Status)
			f20_arg0.MapName:completeAnimation()
			f20_arg0.MapName:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.MapName)
			f20_arg0.Location:completeAnimation()
			f20_arg0.Location:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Location)
			f20_arg0.GameType:completeAnimation()
			f20_arg0.GameType:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.GameType)
			f20_arg0.DoubleXPIconsLeftAligned:completeAnimation()
			f20_arg0.DoubleXPIconsLeftAligned:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DoubleXPIconsLeftAligned)
		end,
	},
}
CoD.LoadingScreenSharedCPZM.__onClose = function(f21_arg0)
	f21_arg0.loadingImageOrMovie:close()
	f21_arg0.label:close()
	f21_arg0.Team1PlayerList:close()
	f21_arg0.loadingBar:close()
	f21_arg0.loadingBarAdd:close()
	f21_arg0.Status:close()
	f21_arg0.MapName:close()
	f21_arg0.Location:close()
	f21_arg0.GameType:close()
	f21_arg0.cinematicSubtitles:close()
	f21_arg0.DoubleXPIconsLeftAligned:close()
end
