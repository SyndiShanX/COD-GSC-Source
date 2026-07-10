require("x64:d4ed3fd8d1fcc4a")
require("x64:3ba04808afffc05")
require("x64:6c12f6ba8c17683")
require("x64:a8fa0931078710f")
require("x64:54d6e487f51c873")
require("x64:c418071bb8e356d")
require("x64:68620bd37717808")
require("x64:23da585bef956c6")
require("x64:8f2d36d6c8b8d7a")
require("x64:53e44c2824eae")
require("x64:8200d5b8b521830")
require("x64:fe7d2635b839f62")
require("x64:63613c420a64e58")
require("x64:3e83eb30e215c66")
CoD.Hud = InheritFrom(CoD.Menu)
LUI.createMenu.Hud = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Hud", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitControllerModel(f1_arg0, "displayTop3Players", 0)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "hudItems.showSpawnSelect")
	SetProperty(self, "disableKeyboardNavigation", true)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "isInPrematchPeriod", 0)
	CoD.BlackMarketUtility.InitInGameContractRecord(f1_arg0, f1_local1)
	self:setClass(CoD.Hud)
	self.soundSet = "HUD"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local ArmorOverlayContainer0 = CoD.ArmorOverlayContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	ArmorOverlayContainer0:setAlpha(0.75)
	self:addElement(ArmorOverlayContainer0)
	self.ArmorOverlayContainer0 = ArmorOverlayContainer0
	local SafeAreaContainerBack = CoD.Hud_SafeAreaContainer_Back.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SafeAreaContainerBack:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(SafeAreaContainerBack)
	self.SafeAreaContainerBack = SafeAreaContainerBack
	local WaypointContainer = CoD.DynamicContainerWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(WaypointContainer)
	self.WaypointContainer = WaypointContainer
	local OverheadNameContainer = CoD.DynamicContainerWidget.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(OverheadNameContainer)
	self.OverheadNameContainer = OverheadNameContainer
	local OutOfBounds = CoD.OutOfBounds.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	OutOfBounds:mergeStateConditions({
		{
			stateName = "IsOutOfBounds",
			condition = function(menu, element, event)
				return IsOutOfBounds(f1_arg0)
			end,
		},
	})
	local Stuck = OutOfBounds
	local PreMatchTimer = OutOfBounds.subscribeToModel
	local proximityAlarm = Engine[0x4DF5CFBC1771947](f1_arg0)
	PreMatchTimer(Stuck, proximityAlarm["hudItems.outOfBoundsEndTime"], function(f4_arg0)
		f1_local1:updateElementState(OutOfBounds, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.outOfBoundsEndTime",
		})
	end, false)
	Stuck = OutOfBounds
	PreMatchTimer = OutOfBounds.subscribeToModel
	proximityAlarm = Engine[0x4DF5CFBC1771947](f1_arg0)
	PreMatchTimer(Stuck, proximityAlarm.displayTop3Players, function(f5_arg0)
		f1_local1:updateElementState(OutOfBounds, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "displayTop3Players",
		})
	end, false)
	self:addElement(OutOfBounds)
	self.OutOfBounds = OutOfBounds
	PreMatchTimer = LUI.UIText.new(0.5, 0.5, -101, 101, 0, 0, 449, 539)
	PreMatchTimer:setAlpha(0)
	PreMatchTimer:setTTF("default")
	PreMatchTimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(PreMatchTimer)
	self.PreMatchTimer = PreMatchTimer
	Stuck = CoD.Stuck.new(f1_local1, f1_arg0, 0.5, 0.5, -48, 208, 1, 1, -360, -104)
	self:addElement(Stuck)
	self.Stuck = Stuck
	proximityAlarm = CoD.ProximityAlarm.new(f1_local1, f1_arg0, 0.5, 0.5, -187.5, 187.5, 0.5, 0.5, 103, 161)
	self:addElement(proximityAlarm)
	self.proximityAlarm = proximityAlarm
	local CaptureCrate = CoD.CaptureCrate.new(f1_local1, f1_arg0, 0.5, 0.5, -223, 227, 0.5, 0.5, -248, -152)
	self:addElement(CaptureCrate)
	self.CaptureCrate = CaptureCrate
	local ThrustMeterContainer0 = CoD.ThrustMeterContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -127.5, 127.5, 0.5, 0.5, 161, 221)
	self:addElement(ThrustMeterContainer0)
	self.ThrustMeterContainer0 = ThrustMeterContainer0
	local SprintMeterContainer = CoD.SprintMeterContainer.new(f1_local1, f1_arg0, 0, 0, 417, 672, 0, 0, 480, 540)
	SprintMeterContainer:setXRot(180)
	SprintMeterContainer:setZRot(-90)
	self:addElement(SprintMeterContainer)
	self.SprintMeterContainer = SprintMeterContainer
	local DeadSpectate = CoD.DeadSpectate.new(f1_local1, f1_arg0, 0.5, 0.5, -225, 225, 1, 1, -305, -215)
	DeadSpectate:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f6_local0
				if Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xC57360571B0917E]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
					f6_local0 = IsPC()
					if f6_local0 then
						f6_local0 = not IsWarzone()
					end
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f7_local0
				if Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xC57360571B0917E]) and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
					f7_local0 = not IsWarzone()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	local SafeAreaContainerFront = DeadSpectate
	local ConsoleCenter = DeadSpectate.subscribeToModel
	local FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6]], function(f8_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xDFB7B5BCEFCABF6],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f9_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f10_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f11_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f12_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f13_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f14_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E]], function(f15_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xC57360571B0917E],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x4DF5CFBC1771947](f1_arg0)
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f16_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	SafeAreaContainerFront = DeadSpectate
	ConsoleCenter = DeadSpectate.subscribeToModel
	FactionInfo = Engine[0x8DF2E5447F384B9]()
	ConsoleCenter(SafeAreaContainerFront, FactionInfo["lobbyRoot.lobbyNav"], function(f17_arg0)
		f1_local1:updateElementState(DeadSpectate, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(DeadSpectate)
	self.DeadSpectate = DeadSpectate
	ConsoleCenter = CoD.CenterConsole.new(f1_local1, f1_arg0, 0.5, 0.5, -555, 555, 0, 0, 96.5, 243.5)
	self:addElement(ConsoleCenter)
	self.ConsoleCenter = ConsoleCenter
	SafeAreaContainerFront = CoD.Hud_SafeAreaContainer_Front.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SafeAreaContainerFront:registerEventHandler("menu_loaded", function(element, event)
		local f18_local0 = nil
		if element.menuLoaded then
			f18_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f18_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f18_local0 then
			f18_local0 = element:dispatchEventToChildren(event)
		end
		return f18_local0
	end)
	self:addElement(SafeAreaContainerFront)
	self.SafeAreaContainerFront = SafeAreaContainerFront
	FactionInfo = CoD.FactionInfo.new(f1_local1, f1_arg0, 0, 0, 749, 1175, 0, 0, 54, 330)
	self:addElement(FactionInfo)
	self.FactionInfo = FactionInfo
	local SubtitlesContainer = CoD.SubtitlesContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -555, 555, 1, 1, -468, -321)
	self:addElement(SubtitlesContainer)
	self.SubtitlesContainer = SubtitlesContainer
	self:mergeStateConditions({
		{
			stateName = "HideWaypoints",
			condition = function(menu, element, event)
				local f19_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
				if not f19_local0 then
					if Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA76381CC97F0253]) then
						f19_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
						if not f19_local0 then
							f19_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						end
					else
						f19_local0 = true
					end
				end
				return f19_local0
			end,
		},
		{
			stateName = "HideWaypointsAndNames",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg0, "hudItems.showSpawnSelect", 1)
			end,
		},
		{
			stateName = "Multiplayer",
			condition = function(menu, element, event)
				return IsMultiplayer()
			end,
		},
	})
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f22_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA76381CC97F0253]], function(f23_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA76381CC97F0253],
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f24_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local19(f1_local18, f1_local20["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f25_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local19(f1_local18, f1_local20["hudItems.showSpawnSelect"], function(f26_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f26_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[0x8DF2E5447F384B9]()
	f1_local19(f1_local18, f1_local20["lobbyRoot.lobbyNav"], function(f27_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f27_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local18 = self
	f1_local19 = self.subscribeToModel
	f1_local20 = Engine[0x8DF2E5447F384B9]()
	f1_local19(f1_local18, f1_local20["lobbyRoot.lobbyNav"], function(f28_arg0, f28_arg1)
		CoD.Menu.UpdateButtonShownState(f28_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
	end, false)
	self:registerEventHandler("hud_boot", function(self, event)
		local f29_local0 = nil
		if ShouldBootUpHUD(f1_arg0, f1_local1) then
		else
		end
		if not f29_local0 then
			f29_local0 = self:dispatchEventToChildren(event)
		end
		return f29_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], nil, function(element, menu, controller, model)
		if CoD.ScoreboardUtility.CanShowScoreboard(controller) then
			CoD.ScoreboardUtility.ShowScoreboard(controller)
			return true
		elseif CoD.ScoreboardUtility.CanHideScoreboard(controller) and not IsWarzone() then
			CoD.ScoreboardUtility.HideScoreboard(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ScoreboardUtility.CanShowScoreboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x0, nil, nil)
			return false
		elseif CoD.ScoreboardUtility.CanHideScoreboard(controller) and not IsWarzone() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "PerController", "scriptNotify", function(model)
		local f32_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x9FB0A7FE2E8EC41) and IsInPrematchPeriod(f1_arg0) and not IsCampaign() then
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x9FB0A7FE2E8EC41) and not IsInPrematchPeriod(f1_arg0) and not IsCampaign() then
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xB0B843215635D02) and not IsWarzone() then
			CreatePrematchTimer(self, f1_arg0, model)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x14431C3CAF07786) then
			SetControllerModelValue(f1_arg0, "isInPrematchPeriod", 0)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x59653257FE765B6) then
			CreatePrematchTimer(self, f1_arg0, model)
			TryBootHUD(self, "0")
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0x739C4BD5BAF83BC) then
			CoD.BlackMarketUtility.RecordCompletedContractInGame(f1_arg0, model, f1_local1)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, 0xB04B1CB4B3498D0) then
			CoD.BlackMarketUtility.UpdateInGameContractRecord(f1_arg0, model, f1_local1)
		end
	end)
	DeadSpectate.id = "DeadSpectate"
	SafeAreaContainerFront.id = "SafeAreaContainerFront"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	f1_local19 = self
	CoD.HUDUtility.InitWaypointHandlers(f1_local1, self, f1_arg0, "WaypointContainer", "SafeAreaContainerBack.ObjectiveInfoWidgetContainer")
	CoD.HUDUtility.InitOverheadNames(self, f1_arg0, "OverheadNameContainer")
	SetProperty(self, "m_inputDisabled", true)
	SetProperty(self, "preserveLuiButton", {
		[Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1]] = true,
	})
	SetAllowCursorMovement(f1_local1, false)
	CoD.HUDUtility.SetupWaypointContainerParent(WaypointContainer)
	f1_local19 = DeadSpectate
	if IsPC() then
		SizeToHudArea(f1_local19, f1_arg0)
	end
	return self
end
CoD.Hud.__resetProperties = function(f33_arg0)
	f33_arg0.WaypointContainer:completeAnimation()
	f33_arg0.OverheadNameContainer:completeAnimation()
	f33_arg0.WaypointContainer:setAlpha(1)
	f33_arg0.OverheadNameContainer:setAlpha(1)
end
CoD.Hud.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
	},
	HideWaypoints = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.WaypointContainer:completeAnimation()
			f35_arg0.WaypointContainer:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.WaypointContainer)
		end,
	},
	HideWaypointsAndNames = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.WaypointContainer:completeAnimation()
			f36_arg0.WaypointContainer:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.WaypointContainer)
			f36_arg0.OverheadNameContainer:completeAnimation()
			f36_arg0.OverheadNameContainer:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.OverheadNameContainer)
		end,
	},
	Multiplayer = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Hud.__onClose = function(f38_arg0)
	f38_arg0.ArmorOverlayContainer0:close()
	f38_arg0.SafeAreaContainerBack:close()
	f38_arg0.WaypointContainer:close()
	f38_arg0.OverheadNameContainer:close()
	f38_arg0.OutOfBounds:close()
	f38_arg0.Stuck:close()
	f38_arg0.proximityAlarm:close()
	f38_arg0.CaptureCrate:close()
	f38_arg0.ThrustMeterContainer0:close()
	f38_arg0.SprintMeterContainer:close()
	f38_arg0.DeadSpectate:close()
	f38_arg0.ConsoleCenter:close()
	f38_arg0.SafeAreaContainerFront:close()
	f38_arg0.FactionInfo:close()
	f38_arg0.SubtitlesContainer:close()
end
