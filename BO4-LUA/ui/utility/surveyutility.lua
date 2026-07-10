CoD.SurveyUtility = {}
CoD.SurveyUtility.GetAARSurveyType = function()
	local f1_local0 = Engine[@"getlobbymainmode"]()
	if f1_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] then
		if LuaUtils.IsArenaPublicGame() then
			return Enum[@"surveytype"][@"hash_39C29FF5FD1A1A8C"]
		else
			return Enum[@"surveytype"][@"hash_5643D8CABE3C78B2"]
		end
	elseif f1_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
		return Enum[@"surveytype"][@"hash_74FC6F1FD23A171E"]
	elseif f1_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
		return Enum[@"surveytype"][@"hash_4A6900E33A2623FA"]
	else
		return nil
	end
end
CoD.SurveyUtility.GetIntroSurveyType = function()
	local f2_local0 = Engine[@"getlobbymainmode"]()
	if f2_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] then
		if LuaUtils.IsArenaPublicGame() then
			return Enum[@"surveytype"][@"hash_7E44CE1C86C2E982"]
		else
			return Enum[@"surveytype"][@"hash_39B7ED8B31C66B88"]
		end
	elseif f2_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
		return Enum[@"surveytype"][@"hash_67DEDB07DD9AAFFC"]
	elseif f2_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
		return Enum[@"surveytype"][@"hash_7D61D949562AB120"]
	else
		return nil
	end
end
CoD.SurveyUtility.OpenSurvey = function(f3_arg0, f3_arg1, f3_arg2)
	if Engine[@"sessionmode_ispubliconlinegame"]() == false then
		return false
	elseif f3_arg0 and f3_arg0:getParent() == nil then
		return false
	elseif f3_arg2 == nil then
		return false
	end
	local f3_local0 = Engine[@"getsurvey"](f3_arg2, math.random())
	if f3_local0 == nil then
		return false
	elseif f3_local0.randomizeButtonOrder == true then
		CoD.AnalyticsUtility.shuffle(f3_local0.responseOptions)
	end
	CoD.SurveyUtility.BuildSurveyTable(f3_local0)
	local f3_local1 = DataSources.SurveyQuestion.getModel(f3_arg1)
	f3_local1.answered:set(false)
	OpenOverlay(f3_arg0, "Survey", f3_arg1)
	return true
end
CoD.SurveyUtility.GetSurveyTable = function()
	return CoD.SurveyUtility.SurveyTable
end
CoD.SurveyUtility.BuildSurveyTable = function(f5_arg0)
	CoD.SurveyUtility.SurveyTable = f5_arg0
end
CoD.SurveyUtility.TestOpenSurvey = function(f6_arg0, f6_arg1)
	CoD.SurveyUtility.BuildSurveyTable({
		title = @"hash_65C8B3FBEB3A367E",
		description = @"hash_234FA766E33F1A64",
		responseOptions = {
			@"menu/decline",
			@"menu/10_points",
			@"menu/1_flag",
			@"menu/specialist_outfit",
			@"hash_C9EBE411155B7FC",
		},
	})
	local f6_local0 = DataSources.SurveyQuestion.getModel(f6_arg1)
	f6_local0.answered:set(false)
	return OpenOverlay(f6_arg0, "Survey", f6_arg1)
end
CoD.SurveyUtility.SendSurveyDlogResponse = function(f7_arg0, f7_arg1)
	local f7_local0 = CoD.SurveyUtility.GetSurveyTable()
	local f7_local1 = DataSources.SurveyQuestion.getModel(f7_arg1)
	f7_local1.answered:set(true)
	f7_local1 = f7_local0.title
	local f7_local2 = f7_arg0:getModel()
	f7_local2 = f7_local2.optionText:get()
	local f7_local3 = Engine[@"hash_6D52E2360F482280"]()
	local f7_local4 = Engine[@"currentsessionmode"]()
	local f7_local5 = false
	Engine[0xDE279ECDDDD966](f7_arg1, @"hash_5218DD882E1DEBD5", {
		[@"survey_name"] = f7_local1,
		[@"response"] = f7_local2,
		[@"hash_4274D6DC485E5069"] = f7_local3,
		[@"session_mode"] = f7_local4,
	})
end
CoD.SurveyUtility.CloseSurvey = function(f8_arg0, f8_arg1)
	local f8_local0 = DataSources.SurveyQuestion.getModel(f8_arg1)
	if not f8_local0.answered:get() then
		f8_local0 = CoD.SurveyUtility.GetSurveyTable()
		local f8_local1 = f8_local0.title
		local f8_local2 = nil
		local f8_local3 = Engine[@"hash_6D52E2360F482280"]()
		local f8_local4 = Engine[@"currentsessionmode"]()
		local f8_local5 = true
		Engine[0xDE279ECDDDD966](f8_arg1, @"hash_5218DD882E1DEBD5", {
			[@"survey_name"] = f8_local1,
			[@"response"] = f8_local2,
			[@"hash_4274D6DC485E5069"] = f8_local3,
			[@"session_mode"] = f8_local4,
		})
	end
	GoBack(f8_arg0, f8_arg1)
end
CoD.SurveyUtility.SelectRatingOption = function(f9_arg0, f9_arg1)
	local f9_local0 = f9_arg0:getModel()
	local f9_local1 = Engine[@"getmodelforcontroller"](f9_arg1)
	local f9_local2 = "SurveyResponseOptions."
	local f9_local3 = f9_local0.responseOptionIndex
	f9_local1[f9_local2 .. REG5:get()].selectedIndex:set(f9_local0.ratingIndex:get())
end
CoD.SurveyUtility.SetupSelectedIndexSubscription = function(f10_arg0, f10_arg1)
	local f10_local0 = f10_arg0:getModel()
	if f10_local0 then
		local f10_local1 = Engine[@"getmodelforcontroller"](f10_arg1)
		local f10_local2 = "SurveyResponseOptions."
		local f10_local3 = f10_local0.responseOptionIndex
		local f10_local4 = f10_local1[f10_local2 .. f10_local4:get()].selectedIndex
		if f10_arg0._selectedIndexSub then
			f10_arg0:removeSubscription(f10_arg0._selectedIndexSub)
		end
		f10_arg0._selectedIndexSub = f10_arg0:subscribeToModel(f10_local4, function(model)
			if model and model:get() then
				if f10_local0.ratingIndex:get() <= model:get() then
					f10_local0.isSelected:set(true)
				else
					f10_local0.isSelected:set(false)
				end
			end
		end, false)
	end
end
DataSources.SurveyQuestion = {
	getModel = function(f12_arg0)
		local f12_local0 = Engine[@"getmodelforcontroller"](f12_arg0)
		local f12_local1 = f12_local0:create("SurveyQuestion")
		local f12_local2 = CoD.SurveyUtility.GetSurveyTable()
		local f12_local3 = f12_local1:create("questionText")
		f12_local3:set(f12_local2.title)
		f12_local3 = f12_local1:create("questionSubText")
		f12_local3:set(f12_local2.description)
		f12_local3 = f12_local1:create("responseWidget")
		f12_local3:set("CoD.SurveyResponseList")
		f12_local1:create("answered")
		return f12_local1
	end,
}
DataSources.SurveyResponseOptions = ListHelper_SetupDataSource("SurveyResponseOptions", function(f13_arg0, f13_arg1)
	local f13_local0 = Engine[@"getmodelforcontroller"](f13_arg0)
	local f13_local1 = CoD.SurveyUtility.GetSurveyTable()
	local f13_local2 = {}
	for f13_local6, f13_local7 in ipairs(f13_local1.responseOptions) do
		table.insert(f13_local2, {
			models = {
				optionText = f13_local7,
				selectedIndex = -1,
				singleRatingQuestion = false,
			},
		})
	end
	return f13_local2
end, true)
