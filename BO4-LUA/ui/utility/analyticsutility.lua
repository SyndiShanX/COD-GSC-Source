require("lua/shared/luaenum")
require("ui/utility/overlayutility")
require("ui/utility/surveyutility")
CoD.AnalyticsUtility = {}
CoD.AnalyticsUtility.SurveyResult = LuaEnum.createEnum("Yes", "No", "SkipRead", "SkipBack")
CoD.AnalyticsUtility.RecordPostMatchSurveyResult = function(f1_arg0, f1_arg1)
	local f1_local0 = {
		surveyId = 1,
	}
	local f1_local1 = CoD.AnalyticsUtility.Surveys[f1_local0.surveyId]
	Engine[0xDE279ECDDDD966](f1_arg0, @"hash_70A892033B9AD63", {
		version = f1_local1.version,
		survey_id = Engine[@"hash_4F9F1239CFD921FE"](f1_local1.surveyID),
		survey_order = f1_local1.order[1] .. f1_local1.order[2] .. f1_local1.order[3],
		answer_id = f1_arg1,
		match_id = Engine[@"hash_6D52E2360F482280"](),
		quitter = CoD.AnalyticsUtility.IsQuitter(f1_arg0),
	})
end
CoD.AnalyticsUtility.PostMatchSurveyButtonAction = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	CoD.AnalyticsUtility.RecordPostMatchSurveyResult(f2_arg2, f2_arg3)
	GoBack(f2_arg0, f2_arg2)
end
CoD.AnalyticsUtility.shuffle = function(f3_arg0)
	local f3_local0 = #f3_arg0
	while 2 <= f3_local0 do
		local f3_local1 = math.random(f3_local0)
		local f3_local2 = f3_arg0[f3_local1]
		f3_arg0[f3_local1] = f3_arg0[f3_local0]
		f3_arg0[f3_local0] = f3_local2
		f3_local0 = f3_local0 - 1
	end
	return f3_arg0
end
CoD.AnalyticsUtility.Surveys = {}
CoD.AnalyticsUtility.Surveys[1] = {
	buttons = {
		{
			displayText = "menu/skip_caps1",
			actionGamepad = function(f4_arg0, f4_arg1)
				CoD.AnalyticsUtility.PostMatchSurveyButtonAction(f4_arg0, nil, f4_arg1, CoD.AnalyticsUtility.SurveyResult.SkipRead)
			end,
			actionKBM = function(f5_arg0, f5_arg1, f5_arg2)
				CoD.AnalyticsUtility.PostMatchSurveyButtonAction(f5_arg0:getMenu(), f5_arg1, f5_arg2, CoD.AnalyticsUtility.SurveyResult.SkipRead)
			end,
		},
		{
			displayText = "menu/yes_caps",
			actionGamepad = function(f6_arg0, f6_arg1)
				CoD.AnalyticsUtility.PostMatchSurveyButtonAction(f6_arg0, nil, f6_arg1, CoD.AnalyticsUtility.SurveyResult.Yes)
			end,
			actionKBM = function(f7_arg0, f7_arg1, f7_arg2)
				CoD.AnalyticsUtility.PostMatchSurveyButtonAction(f7_arg0:getMenu(), f7_arg1, f7_arg2, CoD.AnalyticsUtility.SurveyResult.Yes)
			end,
		},
		{
			displayText = @"menu/no_caps",
			actionGamepad = function(f8_arg0, f8_arg1)
				CoD.AnalyticsUtility.PostMatchSurveyButtonAction(f8_arg0, nil, f8_arg1, CoD.AnalyticsUtility.SurveyResult.No)
			end,
			actionKBM = function(f9_arg0, f9_arg1, f9_arg2)
				CoD.AnalyticsUtility.PostMatchSurveyButtonAction(f9_arg0:getMenu(), f9_arg1, f9_arg2, CoD.AnalyticsUtility.SurveyResult.No)
			end,
		},
	},
	order = CoD.AnalyticsUtility.shuffle({
		1,
		2,
		3,
	}),
	surveyID = "menu/fun_survey",
	version = 1,
}
CoD.AnalyticsUtility.GoBack = function()
	return function(f11_arg0, f11_arg1)
		CoD.AnalyticsUtility.RecordPostMatchSurveyResult(f11_arg1, CoD.AnalyticsUtility.SurveyResult.SkipBack)
		GoBack(f11_arg0, f11_arg1)
	end
end
CoD.OverlayUtility.AddSystemOverlay("PostMatchSurveyPC", {
	menuName = "SystemOverlay_Compact",
	title = @"menu/survey_1",
	description = Engine[@"hash_4F9F1239CFD921FE"](@"menu/survey_intro"),
	categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.AnalyticsUtility.GoBack,
	listDatasource = function(f12_arg0)
		DataSources.PostMatchSurveyOptionsList = DataSourceHelpers.ListSetup("PostMatchSurveyOptionsList", function(f13_arg0)
			local f13_local0 = {}
			local f13_local1 = function(f14_arg0, f14_arg1)
				return {
					models = {
						displayText = f14_arg0,
					},
					properties = {
						action = f14_arg1,
					},
				}
			end
			local f13_local2 = CoD.AnalyticsUtility.Surveys[1]
			local f13_local3 = f13_local2.order
			for f13_local4 = 1, #f13_local3, 1 do
				local f13_local7 = f13_local2.buttons[f13_local3[f13_local4]]
				table.insert(f13_local0, f13_local1(f13_local7.displayText, f13_local7.actionKBM))
			end
			return f13_local0
		end, true)
		return "PostMatchSurveyOptionsList"
	end,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f15_arg0)
		return CoD.AnalyticsUtility.Surveys[1].buttons[1].actionGamepad
	end,
	[CoD.OverlayUtility.aCrossPromptText] = function(f16_arg0)
		return CoD.AnalyticsUtility.Surveys[1].buttons[1].displayText
	end,
	[CoD.OverlayUtility.xSquarePromptFn] = function(f17_arg0)
		return CoD.AnalyticsUtility.Surveys[1].buttons[2].actionGamepad
	end,
	[CoD.OverlayUtility.xSquarePromptText] = function(f18_arg0)
		return CoD.AnalyticsUtility.Surveys[1].buttons[2].displayText
	end,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f19_arg0)
		return CoD.AnalyticsUtility.Surveys[1].buttons[3].actionGamepad
	end,
	[CoD.OverlayUtility.bCirclePromptText] = function(f20_arg0)
		return CoD.AnalyticsUtility.Surveys[1].buttons[3].displayText
	end,
})
CoD.OverlayUtility.AddAutoDetectOverlay("PostMatchSurvey", {
	menuName = "SystemOverlay_Full",
	title = @"menu/survey_1",
	frameWidget = "CoD.systemOverlay_Compact_BasicFrame",
	description = Engine[@"hash_4F9F1239CFD921FE"](@"menu/survey_intro"),
	categoryType = CoD.OverlayUtility.OverlayTypes.Connection,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.AnalyticsUtility.GoBack,
	options = function()
		local f21_local0 = {}
		local f21_local1 = CoD.AnalyticsUtility.Surveys[1]
		local f21_local2 = f21_local1.order
		for f21_local3 = 1, #f21_local2, 1 do
			local f21_local6 = f21_local1.buttons[f21_local2[f21_local3]]
			table.insert(f21_local0, {
				text = f21_local6.displayText,
				action = f21_local6.actionGamepad,
			})
		end
		return f21_local0
	end,
})
CoD.AnalyticsUtility.SurveyShouldShow = function(f22_arg0, f22_arg1)
	local f22_local0 = CoD.GetCurrentPlayerStats(f22_arg1)
	if f22_local0 and f22_local0.AfterActionReportStats and f22_local0.AfterActionReportStats.surveyId then
		local f22_local1 = tonumber(f22_local0.AfterActionReportStats.surveyId:get())
		local f22_local2 = Engine[@"hash_6D52E2360F482280"]()
		if f22_local2 == Engine[@"numbertouint64"](0) then
			return false, false
		else
			local f22_local3 = Engine.CreateModel(Engine.GetModelForController(f22_arg1), "lobbyRoot.lastMatchID")
			local f22_local4 = Engine.GetModelValue(f22_local3)
			Engine.SetModelValue(f22_local3, f22_local2)
			if f22_local4 ~= nil and f22_local2 == f22_local4 then
				return false, false
			elseif f22_local1 == 0 then
				if CoD.AnalyticsUtility.IsQuitter(f22_arg1) then
					return (Dvar.survey_chance:get() or 0) >= math.random(), false
				else
					return false, true
				end
			else
				return true, false
			end
		end
	else
		return false, true
	end
end
CoD.AnalyticsUtility.IsQuitter = function(f23_arg0)
	if Engine.CurrentSessionMode() == Enum.eModes.mode_multiplayer then
		local f23_local0 = Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.quitGameFlag")
		return f23_local0 and f23_local0:get() ~= LuaEnum.QUIT_FLAG.HAS_NOT_QUIT
	else
		return false
	end
end
CoD.AnalyticsUtility.ShouldShowMatchSurvey = function(f24_arg0, f24_arg1)
	return CoD.AnalyticsUtility.SurveyShouldShow(f24_arg0, f24_arg1)
end
CoD.AnalyticsUtility.ShowMatchSurvey = function(menu, controller)
	local self = LUI.UITimer.new(0, "open_survey", true, menu)
	menu:registerEventHandler("open_survey", function(element, event)
		if CoD.isPC then
			CoD.OverlayUtility.CreateOverlay(controller, element, "PostMatchSurveyPC")
		else
			CoD.OverlayUtility.CreateOverlay(controller, element, "PostMatchSurvey")
		end
	end)
	menu:addElement(self)
end
CoD.AnalyticsUtility.ShowMatchSurveyIfNecessary = function(f27_arg0, f27_arg1)
	local f27_local0, f27_local1 = CoD.AnalyticsUtility.ShouldShowMatchSurvey(f27_arg0, f27_arg1)
	if f27_local0 then
		CoD.AnalyticsUtility.ShowMatchSurvey(f27_arg0, f27_arg1)
	elseif f27_local1 == true then
		local f27_local2 = CoD.SurveyUtility.GetAARSurveyType()
		if f27_local2 then
			CoD.SurveyUtility.OpenSurvey(f27_arg0, f27_arg1, f27_local2)
		end
	end
end
CoD.AnalyticsUtility.GoBackAndShowMatchSurveyIfNecessary = function(f28_arg0, f28_arg1)
	CoD.AnalyticsUtility.ShowMatchSurveyIfNecessary(GoBack(f28_arg0, f28_arg1), f28_arg1)
end
