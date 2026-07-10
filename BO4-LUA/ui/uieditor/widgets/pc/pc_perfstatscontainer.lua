require("x64:2afa491a35484d6")
CoD.PC_PerfStatsContainer = InheritFrom(LUI.UIElement)
CoD.PC_PerfStatsContainer.__defaultWidth = 1000
CoD.PC_PerfStatsContainer.__defaultHeight = 15
CoD.PC_PerfStatsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.PC_PerfStatsContainer)
	self.id = "PC_PerfStatsContainer"
	self.soundSet = "default"
	local Framerate = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 0, 93, 0, 0, 0, 15)
	Framerate.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3FC9D018B3560041"))
	Framerate:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showFPS", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Framerate:setAlpha(f2_local0)
		end
	end)
	Framerate:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.framerateCounter", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(Framerate, f1_arg1, "PCTelemetry.framerateCounter", @"hash_3FC9D018B3560041", @"hash_583A0261B143DFE7")
	end)
	self:addElement(Framerate)
	self.Framerate = Framerate
	local Ping = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 98, 191, 0, 0, 0, 15)
	Ping.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_71D6076526ACB9ED"))
	Ping:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showPing", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Ping:setAlpha(f4_local0)
		end
	end)
	Ping:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.ping", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(Ping, f1_arg1, "PCTelemetry.ping", @"hash_71D6076526ACB9ED", @"hash_4F957C5D767CC11B")
	end)
	self:addElement(Ping)
	self.Ping = Ping
	local GPUTemperature = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 196, 289, 0, 0, 0, 15)
	GPUTemperature.Label.__Text_Color = function()
		GPUTemperature.Label:setRGB(RedForHighGPUTemperature(self, f1_arg1, ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b))
	end
	GPUTemperature.Label.__Text_Color()
	GPUTemperature.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6947E8112027DC63"))
	GPUTemperature:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showGPUTemp", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			GPUTemperature:setAlpha(f7_local0)
		end
	end)
	GPUTemperature:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.GPUTemperature", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(GPUTemperature, f1_arg1, "PCTelemetry.GPUTemperature", @"hash_6947E8112027DC63", @"hash_4EFA8FC00871DCC9")
	end)
	self:addElement(GPUTemperature)
	self.GPUTemperature = GPUTemperature
	local GPUTime = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 294, 387, 0, 0, 0, 15)
	GPUTime.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_753F6CA872F841F6"))
	GPUTime:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showGPUTime", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			GPUTime:setAlpha(f9_local0)
		end
	end)
	GPUTime:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.GPUTime", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(GPUTime, f1_arg1, "PCTelemetry.GPUTime", @"hash_753F6CA872F841F6", @"hash_43F5D2E263EA11BC")
	end)
	self:addElement(GPUTime)
	self.GPUTime = GPUTime
	local CPUClient = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 392, 485, 0, 0, 0, 15)
	CPUClient.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_124312CFF5BE0980"))
	CPUClient:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showCPUClientTime", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CPUClient:setAlpha(f11_local0)
		end
	end)
	CPUClient:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.CPUClientTime", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(CPUClient, f1_arg1, "PCTelemetry.CPUClientTime", @"hash_124312CFF5BE0980", 0x0)
	end)
	self:addElement(CPUClient)
	self.CPUClient = CPUClient
	local CPURender = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 490, 583, 0, 0, 0, 15)
	CPURender.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_15E3881717DAB659"))
	CPURender:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showCPURenderTime", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			CPURender:setAlpha(f13_local0)
		end
	end)
	CPURender:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.CPURenderTime", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(CPURender, f1_arg1, "PCTelemetry.CPURenderTime", @"hash_15E3881717DAB659", 0x0)
	end)
	self:addElement(CPURender)
	self.CPURender = CPURender
	local VRAM = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 588, 681, 0, 0, 0, 15)
	VRAM.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_272EA91A24216166"))
	VRAM:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showVRAM", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			VRAM:setAlpha(f15_local0)
		end
	end)
	VRAM:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.VRAMUsed", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(VRAM, f1_arg1, "PCTelemetry.VRAMUsed", @"hash_272EA91A24216166", @"hash_55DD2B239F8D45CC")
	end)
	self:addElement(VRAM)
	self.VRAM = VRAM
	local SoundMuted = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 686, 779, 0, 0, 0, 15)
	SoundMuted.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_35C01ADC09C16596"))
	SoundMuted:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showSoundMuted", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			SoundMuted:setAlpha(f17_local0)
		end
	end)
	SoundMuted:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.SoundMuted", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(SoundMuted, f1_arg1, "", @"hash_35C01ADC09C16596", @"hash_35C01ADC09C16596")
	end)
	self:addElement(SoundMuted)
	self.SoundMuted = SoundMuted
	local VoiceSuspended = CoD.PC_TelemetryItem.new(f1_arg0, f1_arg1, 0, 0, 784, 877, 0, 0, 0, 15)
	VoiceSuspended.Label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_628A1D8932CB1CD6"))
	VoiceSuspended:subscribeToGlobalModel(f1_arg1, "PCTelemetry", "showVoiceSuspended", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			VoiceSuspended:setAlpha(f19_local0)
		end
	end)
	VoiceSuspended:subscribeToGlobalModel(f1_arg1, "GlobalModel", "PCTelemetry.showVoiceSuspended", function(model)
		CoD.PCUtility.SetTextFromTelemetryModel(VoiceSuspended, f1_arg1, "", @"hash_628A1D8932CB1CD6", @"hash_628A1D8932CB1CD6")
	end)
	self:addElement(VoiceSuspended)
	self.VoiceSuspended = VoiceSuspended
	local f1_local10 = GPUTemperature
	local f1_local11 = GPUTemperature.subscribeToModel
	local f1_local12 = Engine[@"getglobalmodel"]()
	f1_local11(f1_local10, f1_local12["PCTelemetry.GPUTemperature"], GPUTemperature.Label.__Text_Color)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_PerfStatsContainer.__onClose = function(f21_arg0)
	f21_arg0.Framerate:close()
	f21_arg0.Ping:close()
	f21_arg0.GPUTemperature:close()
	f21_arg0.GPUTime:close()
	f21_arg0.CPUClient:close()
	f21_arg0.CPURender:close()
	f21_arg0.VRAM:close()
	f21_arg0.SoundMuted:close()
	f21_arg0.VoiceSuspended:close()
end
