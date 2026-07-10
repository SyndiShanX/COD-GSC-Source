
CoD.Menu = InheritFrom( LUI.UIElement )
CoD.InGameMenu = InheritFrom( CoD.Menu )
CoD.Menu.PriorityMenusOpen = {
	0,
	0,
	0,
	0
}
CoD.Menu.SpinnerIsActive = false
CoD.Menu.__infiniteFreeCursorSnapDistance = -1
CoD.Menu.NewFromState = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	if f1_arg0 == nil then
		error( "LUI Error: Attempted to create a menu without a name." )
	end
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	if LUI.DEV then
		self.__priorModelCount = Engine[@"getmodelusage"]() or 0
	end
	self:setClass( CoD.Menu )
	if nil ~= CoD.Menu.ModelToUse then
		self:setModel( CoD.Menu.ModelToUse, f1_arg1 )
	end
	f1_arg0 = CoD.Menu.OverwriteMenuName or f1_arg0
	self.menuName = f1_arg0
	self.id = "Menu." .. f1_arg0
	self.__openMenuCallbacks = {}
	self.__elementsPendingUpdateState = {}
	if RegisterOpenedMenu then
		RegisterOpenedMenu( self, f1_arg0 )
	end
	if self.menuName == "DOA_INGAME_PAUSE" then
		CoD.isDOAPauseMenuOpen = true
	end
	CoD.Menu.AddToCurrMenuNameList( self.menuName )
	CoD.FreeCursorUtility.SetAllowFreeCursorSnappingWithinDistance( self, 100 )
	if not f1_arg1 then
		f1_arg1 = Engine[@"getprimarycontroller"]()
	end
	if CursorInputEnabledForBuild( f1_arg1 ) then
		self.__focusableElementPaths = {}
		self:subscribeToGlobalModel( f1_arg1, "FreeCursor", "position", CoD.Menu.FreeCursorPositionUpdateFn( self, f1_arg1 ), true )
		if CoD.isPC then
			self.__lastInputChangeFrame = 0
		end
		self.inputFocusSupport = CoD.isPC
	end
	return self
end
CoD.Menu.ChangeInputFocus = function ( f2_arg0, f2_arg1, f2_arg2 )
	if not CoD.isPC then
		return nil
	elseif not f2_arg0.inputFocusSupport then
		return nil
	elseif f2_arg2 and f2_arg2.__giveInputFocusToParent then
		f2_arg2 = f2_arg2:getParent()
	end
	if f2_arg2 and not f2_arg2:canTakeInputFocus() then
		f2_arg2 = nil
	end
	if f2_arg2 ~= f2_arg0.currentInputFocus then
		local f2_local0 = f2_arg0.currentInputFocus
		if f2_local0 then
			f2_local0:processEvent( {
				name = "lose_input_focus",
				controller = f2_arg1,
				isMouse = true,
				isMouseFocus = f2_local0 == CoD.GetMouseFocus( f2_arg1 )
			} )
			if not f2_arg2 then
				f2_arg0:processEvent( {
					name = "clear_recorded_inputfocus",
					controller = f2_arg1
				} )
			end
		end
		if f2_arg2 then
			assert( f2_arg2:processEvent( {
				name = "gain_input_focus",
				controller = f2_arg1,
				isMouse = true,
				isMouseFocus = f2_arg2 == CoD.GetMouseFocus( f2_arg1 )
			} ) )
		end
		f2_arg0.currentInputFocus = f2_arg2
	end
end
CoD.Menu.ChangeFocusedElement = function ( f3_arg0, f3_arg1, f3_arg2, f3_arg3 )
	if f3_arg0.ContextualMenu and f3_arg2 and f3_arg2 ~= f3_arg0.ContextualMenu and not CoD.Menu.IsAncestorOf( f3_arg0.ContextualMenu, f3_arg2 ) then
		if f3_arg3 and CoD.Menu.IsAncestorOf( f3_arg0.ContextualMenu, CoD.GetMouseFocus( f3_arg1 ) ) then
			f3_arg2 = CoD.GetMouseFocus( f3_arg1 )
		else
			f3_arg2 = nil
		end
	end
	if f3_arg2 ~= CoD.GetMouseFocus( f3_arg1 ) then
		if CoD.isPC then
			f3_arg0:CaptureMouseAndLockFocus( f3_arg1, nil )
		end
		local f3_local0 = CoD.GetMouseFocus( f3_arg1 )
		LUI.lastFocusByKeyboard = f3_arg3
		local f3_local1 = CoD.isPC and f3_arg2 ~= nil
		if IsMouseOrKeyboard( f3_arg1 ) and f3_arg0.buttonModel and f3_arg0.buttonModel[Enum[@"luibutton"][@"lui_key_xba_pscross"]] and f3_arg0.buttonModel[Enum[@"luibutton"][@"lui_key_xba_pscross"]].flags then
			f3_arg0.buttonModel[Enum[@"luibutton"][@"lui_key_xba_pscross"]].flags:set( 0 )
		end
		if f3_arg2 then
			local f3_local2 = f3_arg2:processEvent( {
				name = "gain_focus",
				controller = f3_arg1,
				isMouse = true,
				disableUpdateCursorFocus = f3_local1
			} )
			f3_arg2:playSound( "gain_focus" )
			assert( f3_local2 )
		end
		CoD.SetCurrentMouseFocus( f3_arg1, f3_arg2 )
		if CoD.isPC then
			CoD.FreeCursorUtility.UpdateFreeCursorState( f3_arg0, f3_arg1, f3_arg2 )
		end
		if f3_local0 then
			f3_local0:processEvent( {
				name = "lose_focus",
				controller = f3_arg1,
				isMouse = true
			} )
			if not f3_arg2 then
				f3_arg0:processEvent( {
					name = "clear_recorded_focus",
					controller = f3_arg1
				} )
			end
		end
	end
end
CoD.Menu.CaptureMouseAndLockFocus = function ( f4_arg0, f4_arg1, f4_arg2 )
	assert( CoD.isPC )
	local f4_local0 = assert
	local f4_local1
	if f4_arg0.__lockedFocus ~= nil and f4_arg2 ~= nil then
		f4_local1 = false
	else
		f4_local1 = true
	end
	f4_local0( f4_local1 )
	if f4_arg0.__lockedFocus and not f4_arg2 then
		if f4_arg0.__mouseCaptureSubscription then
			f4_arg0:removeSubscription( f4_arg0.__mouseCaptureSubscription )
		end
		f4_arg0.__mouseCaptureSubscription = nil
		Engine[@"hash_4D1619221CBAF878"]( f4_arg1, false )
	elseif f4_arg2 and not f4_arg0.__lockedFocus then
		f4_local0 = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f4_arg1 ), "MouseCaptured" )
		if f4_local0:get() == nil then
			f4_local0:set( false )
		end
		assert( not f4_arg0.__mouseCaptureSubscription )
		f4_arg0.__mouseCaptureSubscription = f4_arg0:subscribeToModel( f4_local0, function ( model, f5_arg1 )
			if f4_arg0.__lockedFocus and not model:get() then
				f4_arg0:DispatchMouseCaptureLostEvent( f4_arg1 )
				
			else
				return f4_arg0:dispatchEventToChildren( {
					name = "mouse_capture_lost",
					controller = f4_arg1
				} )
			end
		end, false )
		Engine[@"hash_4D1619221CBAF878"]( f4_arg1, true )
	end
	f4_arg0.__lockedFocus = f4_arg2
end
CoD.Menu.GetLockedFocusElement = function ( f6_arg0 )
	return f6_arg0.__lockedFocus
end
CoD.Menu.DispatchMouseCaptureLostEvent = function ( f7_arg0, f7_arg1 )
	if f7_arg0.__lockedFocus then
		f7_arg0.__lockedFocus:processEvent( {
			name = "mouse_capture_lost",
			controller = f7_arg1
		} )
	end
	f7_arg0:CaptureMouseAndLockFocus( f7_arg1, nil )
end
CoD.Menu.ChangeMouseCursorType = function ( f8_arg0, f8_arg1 )
	local f8_local0 = CoD.GetMouseFocus( f8_arg1 )
	if not f8_local0 or f8_local0.__forceCursorTypeNormal then
		Engine[@"setmousecursor"]( Enum[@"cursortype"][@"hash_17CEDA982668284"] )
	elseif f8_local0.__xcamRotationWidget then
		Engine[@"setmousecursor"]( Enum[@"cursortype"][@"hash_68DDB59390F48283"] )
	elseif CoD.PCUtility.HasContextualMenuActionInStack( f8_local0, f8_arg0, f8_arg1 ) then
		Engine[@"setmousecursor"]( Enum[@"cursortype"][@"hash_22BC29F6508402B0"] )
	else
		Engine[@"setmousecursor"]( Enum[@"cursortype"][@"hash_4B16AEBDF3238E15"] )
	end
end
CoD.Menu.setInputOverrideElement = function ( f9_arg0, f9_arg1, f9_arg2 )
	f9_arg0.__inputOverrideElement = f9_arg1
	if f9_arg1 then
		f9_arg1.__overrideFn = f9_arg2
	end
end
CoD.Menu.isInputOverridenForElement = function ( f10_arg0, f10_arg1 )
	if not CoD.isPC or not f10_arg0.__inputOverrideElement then
		return false
	end
	local f10_local0 = f10_arg0.__inputOverrideElement.__overrideFn
	if f10_local0 then
		if f10_arg1 ~= nil then
			if f10_arg0.__inputOverrideElement ~= f10_arg1 then
				f10_local0 = not f10_arg0.__inputOverrideElement:isParentOf( f10_arg1 )
			else
				f10_local0 = false
			end
		else
			f10_local0 = true
		end
	end
	return f10_local0
end
CoD.Menu.FreeCursorPositionUpdateFn = function ( f11_arg0, f11_arg1 )
	return function ( f12_arg0 )
		if not IsFreeCursorActiveAndVisible( f11_arg1 ) and IsGamepad( f11_arg1 ) then
			return 
		elseif f11_arg0.occludedBy or Engine[@"waitingforkeybind"]( f11_arg1 ) or f11_arg0.ignoreCursor then
			return 
		elseif CoD.isPC and CoD.Menu.IsPriorityMenuOpen( f11_arg1 ) and not f11_arg0._isPriorityMenu then
			return 
		end
		local f12_local0, f12_local1 = f12_arg0:get()
		local f12_local2 = f11_arg0:getRoot()
		if f12_local2 and f12_local2.name then
			local f12_local3 = {
				insidePerc = 0
			}
			local f12_local4 = nil
			local f12_local5 = CoD.GetMouseFocus( f11_arg1 )
			local f12_local6 = Engine[0x4B06D9D6B673AA]( f11_arg1 )
			if not IsMouseOrKeyboard( f11_arg1 ) and f12_local5 and f11_arg0:isParentOf( f12_local5 ) then
				local f12_local7 = f12_local5
				local f12_local8 = true
				local f12_local9 = false
				while f12_local7 do
					if not f12_local7:allowsCursorMove() then
						f12_local8 = false
						break
					elseif f12_local7 == f11_arg0 then
						f12_local9 = true
						break
					end
					f12_local7 = f12_local7:getParent()
				end
				if f12_local9 and f12_local8 then
					local f12_local10 = f12_local5:cursorInsideElementPerc( f11_arg1, f12_local2.name, f12_local0, f12_local1 )
					if f12_local10 > 0 then
						f12_local3.insidePerc = f12_local10
						f12_local3.elem = f12_local5
					end
				end
			end
			if not f12_local3.elem and f11_arg0.__freeCursorSnapDistance and IsGamepad( f11_arg1 ) then
				local f12_local7, f12_local8 = nil
				if f12_local6 then
					if f11_arg0:isParentOf( f12_local6 ) then
						f12_local7, f12_local8 = f12_local6:cursorDistanceToElement( f11_arg1, f12_local2.name, f12_local0, f12_local1 )
						if f11_arg0.__freeCursorSnapDistance ~= CoD.Menu.__infiniteFreeCursorSnapDistance and f11_arg0.__freeCursorSnapDistance < f12_local7 then
							Engine[@"hash_718F7786899BA625"]( f11_arg1 )
							f12_local6 = nil
						end
					else
						Engine[@"hash_718F7786899BA625"]( f11_arg1 )
						f12_local6 = nil
					end
				end
				f12_local4 = {
					elem = f12_local6,
					nearestDistance = f12_local7
				}
				if not f12_local4.elem and f11_arg0.__freeCursorSnapDistance ~= CoD.Menu.__infiniteFreeCursorSnapDistance then
					f12_local4.nearestDistance = f11_arg0.__freeCursorSnapDistance
				end
			end
			f11_arg0:cursorMoved( f11_arg1, f12_local0, f12_local1, f11_arg0.__focusableElementPaths, f12_local2.name, f12_local3, f12_local4 )
			if f12_local3.elem ~= f12_local5 and not f11_arg0.__lockedFocus then
				f12_local5 = f12_local3.elem
				if not IsUsingKeyboardNavigation( f11_arg1 ) or Dvar[@"hash_26A8F90E2C78062E"]:get() then
					f11_arg0:ChangeFocusedElement( f11_arg1, f12_local3.elem, false )
				end
			end
			if f11_arg0.__freeCursorSnapDistance then
				local f12_local7 = f12_local5
				if not f12_local7 and f12_local4 and f12_local4.elem and (f11_arg0.__freeCursorSnapDistance == CoD.Menu.__infiniteFreeCursorSnapDistance or f12_local4.nearestDistance <= f11_arg0.__freeCursorSnapDistance) then
					f12_local7 = f12_local4.elem
				end
				if f12_local7 and f12_local7 ~= f12_local6 then
					Engine[@"hash_3F160A977AB91A46"]( f11_arg1, f12_local7 )
				end
			end
			local f12_local7 = CoD.GetMouseFocus( f11_arg1 )
			if CoD.isPC and f12_local7 ~= nil and not f11_arg0.__ignoreNextMouseDrag then
				local f12_local8 = Engine[@"getmodelforcontroller"]( f11_arg1 )
				local f12_local9 = CoD.BitUtility.IsBitwiseAndNonZero( f12_local8["KeyPressBits.MOUSE1"]:get(), Enum[@"luibuttonflags"][@"flag_down"] )
				local f12_local10 = Engine[@"getmodelforcontroller"]( f11_arg1 )
				local f12_local11 = CoD.BitUtility.IsBitwiseAndNonZero( f12_local10["KeyPressBits.MOUSE2"]:get(), Enum[@"luibuttonflags"][@"flag_down"] )
				local f12_local12 = Engine[@"getmodelforcontroller"]( f11_arg1 )
				if f12_local7.m_eventHandlers.leftmousedrag ~= nil and (f12_local9 or CoD.BitUtility.IsBitwiseAndNonZero( f12_local12.ButtonBits[Enum[@"luibutton"][@"lui_key_xba_pscross"]]:get(), Enum[@"luibuttonflags"][@"flag_down"] )) then
					f12_local7.m_eventHandlers:leftmousedrag( {
						name = "leftmousedrag",
						controller = f11_arg1,
						root = f12_local2,
						x = f12_local0,
						y = f12_local1
					} )
				end
				if f12_local7.m_eventHandlers.rightmousedrag ~= nil and f12_local11 then
					f12_local7.m_eventHandlers:rightmousedrag( {
						name = "rightmousedrag",
						controller = f11_arg1,
						root = f12_local2,
						x = f12_local0,
						y = f12_local1
					} )
				end
			elseif CoD.isPC and f11_arg0.__ignoreNextMouseDrag then
				f11_arg0.__ignoreNextMouseDrag = nil
			end
			if CoD.isPC then
				f11_arg0:ChangeMouseCursorType( f11_arg1 )
			end
		end
	end
	
end
CoD.Menu.MouseButtonCallbackFunction = function ( f13_arg0, f13_arg1, f13_arg2, f13_arg3 )
	local f13_local0 = function ( f14_arg0 )
		local f14_local0
		if f14_arg0 ~= "MOUSE1" and f14_arg0 ~= "MOUSE2" and f14_arg0 ~= "MOUSE3" then
			f14_local0 = false
		else
			f14_local0 = true
		end
		return f14_local0
	end
	
	if not f13_local0( f13_arg2 ) then
		return false
	elseif f13_arg0.occludedBy or Engine[@"waitingforkeybind"]( f13_arg1 ) or f13_arg0.ignoreCursor or f13_arg0.m_disableAllButtonActions then
		return false
	elseif CoD.Menu.SpinnerIsActive or CoD.Menu.IsPriorityMenuOpen( f13_arg1 ) and not f13_arg0._isPriorityMenu then
		return false
	end
	f13_local0 = DataSources.FreeCursor.getModel( f13_arg1 )
	local f13_local0, f13_local1 = f13_local0.position:get()
	local f13_local2 = CoD.BitUtility.IsBitwiseAndNonZero( f13_arg3:get(), Enum[@"luibuttonflags"][@"flag_down"] )
	local f13_local3 = CoD.BitUtility.IsBitwiseAndNonZero( f13_arg3:get(), Enum[@"luibuttonflags"][@"flag_isrepeat"] )
	local f13_local4 = "mouseup"
	if f13_local2 then
		f13_local4 = "mousedown"
	end
	local f13_local5 = "left"
	if f13_arg2 == "MOUSE3" then
		f13_local5 = "middle"
	elseif f13_arg2 == "MOUSE2" then
		f13_local5 = "right"
	end
	if f13_local3 then
		return false
	elseif f13_local2 then
		local f13_local6 = CoD.GetMouseFocus( f13_arg1 )
		f13_arg0.__ignoreNextMouseDrag = true
		CoD.FreeCursorUtility.RetriggerCursorPositionNoDelay( f13_arg0, f13_arg1 )
		if f13_local6 ~= CoD.GetMouseFocus( f13_arg1 ) then
			return true
		end
	end
	if f13_arg0.inputFocusSupport and f13_local2 and not CoD.BitUtility.IsBitwiseAndNonZero( f13_arg3:get(), Enum[@"luibuttonflags"][@"hash_4715085B24AAB606"] ) then
		local f13_local7 = true
		local f13_local8 = CoD.GetMouseFocus( f13_arg1 )
		if f13_local8 and f13_arg0:isParentOf( f13_local8 ) then
			if f13_local8.__giveInputFocusToParent then
				f13_local8 = f13_local8:getParent()
			end
			if f13_local8 and f13_local8:canTakeInputFocus() then
				if f13_arg0.currentInputFocus and f13_local8:isParentOf( f13_arg0.currentInputFocus ) then
					local f13_local9 = f13_arg0:getRoot()
					if Engine[@"ismouseinsideelement"]( f13_arg1, f13_arg0, f13_local9.name, f13_local0, f13_local1 ) then
						f13_arg0:ChangeInputFocus( f13_arg1, f13_arg0.currentInputFocus )
						f13_local7 = false
					else
						f13_arg0:ChangeInputFocus( f13_arg1, f13_local8 )
						f13_local7 = false
					end
				else
					f13_arg0:ChangeInputFocus( f13_arg1, f13_local8 )
					f13_local7 = false
				end
			end
		end
		if f13_local7 and (f13_local8 == nil or f13_local8.keepOldInputFocusOnClick == nil or f13_local8.keepOldInputFocusOnClick) then
			f13_arg0:ChangeInputFocus( f13_arg1, nil )
		end
	end
	local f13_local7 = nil
	if CoD.GetMouseFocus( f13_arg1 ) ~= nil then
		local f13_local8 = CoD.GetMouseFocus( f13_arg1 )
		f13_local7 = f13_local8:MouseButtonEvent( {
			name = f13_local4,
			button = f13_local5,
			controller = f13_arg1,
			x = f13_local0,
			y = f13_local1
		} )
	end
	if f13_local2 then
		if f13_arg0.ContextualMenu and not f13_arg0.ContextualMenu:IsMouseInsideElement( f13_arg1 ) then
			CoD.PCWidgetUtility.CloseContextualMenu( f13_arg0, f13_arg1 )
		end
		if CoD.PCUtility.ChatClientContainer and f13_arg0[CoD.PCUtility.ChatClientContainer.id] and f13_arg2 == "MOUSE1" and (not f13_arg0.ContextualMenu or not f13_arg0.ContextualMenu:IsMouseInsideElement( f13_arg1 )) then
			local f13_local8 = CoD.ChatClientUtility.GetCurrentChattingModel( f13_arg1 )
			if f13_local8 and f13_local8:get() and not f13_arg0[CoD.PCUtility.ChatClientContainer.id]:IsMouseInsideElement( f13_arg1 ) then
				if CoD.GetMouseFocus( f13_arg1 ) then
					local f13_local9 = CoD.GetMouseFocus( f13_arg1 )
					if not f13_local9.__isChatToggleButton then
					
					elseif CoD.PCUtility.FrontendBattlenetContainer and f13_arg0[CoD.PCUtility.FrontendBattlenetContainer.id] and f13_arg2 == "MOUSE1" then
						local f13_local8 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel( f13_arg1 )
						if f13_local8 and f13_local8:get() and not f13_arg0[CoD.PCUtility.FrontendBattlenetContainer.id].emptyFocusable:IsMouseInsideElement( f13_arg1 ) then
							if CoD.GetMouseFocus( f13_arg1 ) then
								local f13_local9 = CoD.GetMouseFocus( f13_arg1 )
								if not f13_local9.__isFrontendBattlenetToggleButton then
								
								else
									return f13_local7
								end
							end
							CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility( f13_arg0, f13_arg0, f13_arg1 )
						end
					end
				end
				f13_local8:set( false )
			end
		end
		elseif CoD.PCUtility.FrontendBattlenetContainer and f13_arg0[CoD.PCUtility.FrontendBattlenetContainer.id] and f13_arg2 == "MOUSE1" then
			local f13_local8 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel( f13_arg1 )
			if f13_local8 and f13_local8:get() and not f13_arg0[CoD.PCUtility.FrontendBattlenetContainer.id].emptyFocusable:IsMouseInsideElement( f13_arg1 ) then
				if CoD.GetMouseFocus( f13_arg1 ) then
					local f13_local9 = CoD.GetMouseFocus( f13_arg1 )
					if not f13_local9.__isFrontendBattlenetToggleButton then
					
					else
						return f13_local7
					end
				end
				CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility( f13_arg0, f13_arg0, f13_arg1 )
			end
	end
	return f13_local7
end
CoD.Menu.SetAsPriority = function ( f15_arg0, f15_arg1 )
	if not f15_arg0._isPriorityMenu then
		CoD.Menu.PriorityMenusOpen[f15_arg1 + 1] = CoD.Menu.PriorityMenusOpen[f15_arg1 + 1] + 1
		f15_arg0._isPriorityMenu = true
	end
end
CoD.Menu.SetAsNotPriority = function ( f16_arg0, f16_arg1 )
	if f16_arg0._isPriorityMenu then
		CoD.Menu.PriorityMenusOpen[f16_arg1 + 1] = CoD.Menu.PriorityMenusOpen[f16_arg1 + 1] - 1
		f16_arg0._isPriorityMenu = false
	end
end
CoD.Menu.IsPriorityMenuOpen = function ( f17_arg0 )
	if CoD.isFrontend then
		for f17_local0 = 1, #CoD.Menu.PriorityMenusOpen, 1 do
			if CoD.Menu.PriorityMenusOpen[f17_local0] > 0 then
				return true
			end
		end
		return false
	else
		return CoD.Menu.PriorityMenusOpen[f17_arg0 + 1] > 0
	end
end
CoD.Menu.NewForUIEditor = function ( f18_arg0, f18_arg1 )
	local f18_local0 = CoD.Menu.NewFromState( f18_arg0, f18_arg1 )
	f18_local0.buttonModel = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f18_arg1 ), f18_local0.menuName .. ".buttonPrompts" )
	if CoD.isPC or CoD.IsShoutcaster( f18_arg1 ) then
		f18_local0.keyModel = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f18_arg1 ), f18_local0.menuName .. ".keyPrompts" )
	end
	return f18_local0
end
CoD.Menu.close = function ( f19_arg0 )
	local f19_local0 = f19_arg0:getOwner()
	if not f19_local0 then
		f19_local0 = Engine[@"getprimarycontroller"]()
	end
	if f19_arg0.menuName == "DOA_INGAME_PAUSE" then
		CoD.isDOAPauseMenuOpen = false
	end
	CoD.Menu.RemoveFromCurrMenuNameList( f19_arg0.menuName )
	if f19_arg0._isPriorityMenu then
		CoD.Menu.PriorityMenusOpen[f19_local0 + 1] = CoD.Menu.PriorityMenusOpen[f19_local0 + 1] - 1
	end
	if UnregisterOpenedMenu then
		UnregisterOpenedMenu( f19_arg0, f19_arg0.menuName )
	end
	if f19_arg0.occludedBy ~= nil and f19_arg0.occludedBy.occludedMenu == f19_arg0 then
		f19_arg0.occludedBy.occludedMenu = f19_arg0.occludedMenu
	end
	if f19_arg0.occludedMenu ~= nil and f19_arg0.occludedMenu.occludedBy == f19_arg0 then
		if f19_arg0.occludedBy ~= nil then
			f19_arg0.occludedMenu.occludedBy = f19_arg0.occludedBy
		else
			if IsGameTypeDOA() and Engine[@"issplitscreen"]() then
				f19_arg0.occludedMenu:setOwner( f19_arg0:getOwner() )
			end
			f19_arg0.occludedMenu:processEvent( {
				name = "occlusion_change",
				occluded = false,
				occludedBy = f19_arg0
			} )
		end
	end
	if f19_arg0:getSoundSet() then
		f19_arg0:playSound( "menu_close" )
	end
	if CoD.GetMouseFocus( f19_local0 ) and f19_arg0:isParentOf( CoD.GetMouseFocus( f19_local0 ) ) then
		CoD.SetCurrentMouseFocus( f19_local0, nil )
	end
	if DataSources.FreeCursor.getButtonPromptsModel( f19_local0 ) == f19_arg0.buttonModel then
		DataSources.FreeCursor.registerButtonPrompts( f19_local0, nil )
	end
	CoD.MetricsUtility.CloseMenu( f19_arg0 )
	CoD.Menu.super.close( f19_arg0 )
	Engine[@"unsubscribeandfreemodel"]( Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f19_local0 ), f19_arg0.menuName .. ".buttonPrompts" ) )
	f19_arg0.buttonModel = nil
	if CoD.isPC then
		if f19_arg0.__lockedFocus then
			f19_arg0:DispatchMouseCaptureLostEvent( f19_local0 )
		end
		Engine[@"unsubscribeandfreemodel"]( Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f19_local0 ), f19_arg0.menuName .. ".keyPrompts" ) )
		f19_arg0.keyModel = nil
		local f19_local1 = f19_arg0
		local f19_local2 = f19_arg0.removeSubscription
		local f19_local3 = Engine[@"getmodelforcontroller"]( f19_local0 )
		f19_local2( f19_local1, f19_local3["KeyPressBits.MOUSE1"] )
		f19_local1 = f19_arg0
		f19_local2 = f19_arg0.removeSubscription
		f19_local3 = Engine[@"getmodelforcontroller"]( f19_local0 )
		f19_local2( f19_local1, f19_local3["KeyPressBits.MOUSE2"] )
		f19_local1 = f19_arg0
		f19_local2 = f19_arg0.removeSubscription
		f19_local3 = Engine[@"getmodelforcontroller"]( f19_local0 )
		f19_local2( f19_local1, f19_local3["KeyPressBits.MOUSE3"] )
	end
	if LUI.DEV then
		DebugPrint( "Menu " .. f19_arg0.menuName .. " model change = " .. Engine[@"getmodelusage"]() or 0 - f19_arg0.__priorModelCount )
		for f19_local2 = 1, #LUI.currentMouseFocus, 1 do
			assert( not CoD.Menu.IsAncestorOf( f19_arg0, LUI.currentMouseFocus[f19_local2] ) )
		end
	end
end
CoD.Menu.TransitionCompleteAnimatePopupOut = function ( f20_arg0, f20_arg1 )
	f20_arg0:goBack( f20_arg0:getOwner() )
end
CoD.Menu.DoesMenuExist = function ( f21_arg0 )
	return LUI.createMenu[f21_arg0] ~= nil
end
CoD.Menu.safeCreateMenu = function ( f22_arg0, f22_arg1, f22_arg2 )
	Engine[@"gcstop"]()
	Engine[@"beginpixevent"]( "createMenu('" .. f22_arg0 .. "')" )
	local f22_local0 = LUI.createMenu[f22_arg0]
	if f22_local0 == nil then
		if LUI.DEV then
			error( "LUI Error: no createMenu function for menu '" .. f22_arg0 .. "'" )
		end
		Engine[@"endpixevent"]()
		return nil
	else
		local f22_local1 = f22_local0( f22_arg1, f22_arg2 )
		CoD.MetricsUtility.OpenMenu( f22_local1 )
		Engine[@"gcrestart"]()
		Engine[@"endpixevent"]()
		return f22_local1
	end
end
CoD.Menu.DebugCloseMenu = function ( f23_arg0 )
	f23_arg0:close()
end
CoD.Menu.DebugReload = function ( f24_arg0, f24_arg1 )
	if f24_arg0.occludedBy then
		return 
	elseif f24_arg0.menuName == "FreeCursor" then
		return 
	end
	local f24_local0 = f24_arg0.m_ownerController
	if not f24_local0 then
		f24_local0 = Engine[@"getprimarycontroller"]()
	end
	local f24_local1 = f24_arg0:getNextSibling()
	local f24_local2 = f24_arg0:getParent()
	local f24_local3 = f24_arg0.m_ownerController
	local f24_local4 = f24_arg0.occludedMenu
	local f24_local5 = f24_arg0.previousMenuName
	CoD.Menu.ModelToUse = f24_arg0:getModel()
	local f24_local6 = f24_arg0.menuName
	CoD.Menu.DebugCloseMenu( f24_arg0 )
	f24_arg0 = nil
	if f24_local6 == "MessageDialogBox" then
		CoD.Menu.ModelToUse = nil
		return 
	end
	local f24_local7 = CoD.Menu.safeCreateMenu( f24_local6, f24_local0 )
	CoD.Menu.ModelToUse = nil
	f24_local7.m_ownerController = f24_local3
	f24_local7.occludedMenu = f24_local4
	f24_local7.previousMenuName = f24_local5
	if f24_local1 ~= nil then
		f24_local7:addElementBefore( f24_local1 )
	elseif f24_local2 ~= nil then
		f24_local2:addElement( f24_local7 )
	end
	f24_local7:updateBlur()
	f24_local7:menuOpened( f24_local0, f24_local7 )
end
CoD.Menu.goBack = function ( f25_arg0, f25_arg1 )
	if f25_arg0:getSoundSet() then
		f25_arg0:playSound( "menu_go_back" )
	end
	return f25_arg0:returnToPreviousMenu( f25_arg1 )
end
CoD.Menu.OcclusionChange = function ( f26_arg0, f26_arg1 )
	local f26_local0 = f26_arg1.controller
	if f26_local0 == nil then
		f26_local0 = f26_arg0:getOwner()
	end
	if f26_local0 == nil then
		f26_local0 = Engine[@"getprimarycontroller"]()
	end
	if CoD.PCWidgetUtility then
		CoD.PCWidgetUtility.CloseContextualMenu( f26_arg0, f26_local0 )
	end
	if CoD.isPC then
		CoD.PCBattlenetUtility.CloseBattlenetMenu( f26_arg0, f26_arg0, f26_local0, false )
	end
	if f26_arg1.occluded then
		if not f26_arg0.occludedBy and Engine[@"usingfreecursor"]() then
			f26_arg0:saveState( f26_local0 )
			f26_arg0:ChangeFocusedElement( f26_local0, nil, true )
		end
		if CoD.isPC then
			f26_arg0:processEvent( {
				name = "clear_recorded_pcinputfocus",
				controller = f26_local0
			} )
			if f26_arg0.lastPCInputFocusElemEvent and f26_arg0.lastPCInputFocusElemEvent.id == "ChatClientInputTextBoxField" then
				f26_arg0.lastPCInputFocusElemEvent = nil
			end
			assert( f26_arg0.lastPCInputFocusElemEvent == nil )
			if f26_arg0.__lockedFocus then
				f26_arg0:DispatchMouseCaptureLostEvent( f26_local0 )
			end
			CoD.FreeCursorUtility.ForceCloseDetailedView( f26_arg0, f26_local0 )
		end
		if f26_arg0.id == "Menu.Lobby" and f26_arg1.occludedBy.id == "Menu.Spinner" then
			local f26_local1 = f26_arg0.occludedBy
			f26_arg0.occludedBy = f26_arg1.occludedBy
			if f26_local1 then
				f26_local1:setOccludedMenu( f26_arg0.occludedBy )
			else
				f26_arg0.m_inputDisabled = true
			end
		elseif f26_arg0.occludedBy then
			local f26_local1 = f26_arg0
			repeat
				f26_local1 = f26_local1.occludedBy
			until not f26_local1.occludedBy
			f26_arg1.occludedBy:setOccludedMenu( f26_local1 )
			f26_local1.occludedBy = f26_arg1.occludedBy
			f26_arg0.m_inputDisabled = true
		else
			f26_arg0.occludedBy = f26_arg1.occludedBy
			f26_arg0.m_inputDisabled = true
		end
		if CoD.isPC and (not f26_arg0.occludedBy or not CoD.OverlayUtility.Overlays[f26_arg0.occludedBy.menuName]) then
			CoD.PCUtility.MigrateStickyElementsForward( f26_arg0.occludedBy, f26_local0 )
		end
	elseif f26_arg0.occludedBy == nil or f26_arg1.occludedBy.id == f26_arg0.occludedBy.id then
		if CoD.isPC and (not f26_arg0.occludedBy or not CoD.OverlayUtility.Overlays[f26_arg0.occludedBy.menuName]) then
			CoD.PCUtility.MigrateStickyElementsBackward( f26_arg0.occludedBy, f26_local0 )
		end
		f26_arg0.m_inputDisabled = nil
		local f26_local1 = f26_arg0.occludedBy
		if f26_local1 then
			f26_local1 = f26_arg0.occludedBy.animateInFromOffset ~= nil
		end
		f26_arg0.occludedBy = nil
		if f26_local1 then
			CoD.Menu.UpdateAllButtonPrompts( f26_arg0, f26_arg0:getOwner() )
		end
		if f26_arg0.updateBlur then
			f26_arg0:updateBlur()
		end
		if Engine[@"usingfreecursor"]() then
			DataSources.FreeCursor.registerButtonPrompts( f26_arg0:getOwner(), f26_arg0.buttonModel )
			CoD.FreeCursorUtility.RetriggerCursorPosition( f26_arg0, f26_arg0:getOwner() )
		end
		if IsGamepadOrKeyboardNavigation( f26_local0 ) and not f26_arg0:restoreState( f26_local0 ) then
			f26_arg0:CheckDefaultFocus( f26_arg0:getOwner() )
		end
	end
end
CoD.Menu.AddButtonPromptModel = function ( f27_arg0, f27_arg1, f27_arg2, f27_arg3 )
	local f27_local0 = Engine[@"getmodel"]( f27_arg0.buttonModel, f27_arg2 )
	if not f27_local0 then
		f27_local0 = Engine[@"createmodel"]( f27_arg0.buttonModel, f27_arg2 )
		Engine[@"setmodelvalue"]( f27_local0, f27_arg3 or Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"] )
	end
	if CoD.isPC and f27_local0 then
		if not Engine[@"getmodel"]( f27_local0, "Button" ) then
			Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f27_local0, "Button" ), f27_arg2 )
		end
		if not f27_local0.TooltipLabel then
			local f27_local1 = f27_local0:create( "TooltipLabel" )
			f27_local1:set( "" )
		end
	end
	if not f27_local0.Label then
		local f27_local1 = f27_local0:create( "Label" )
		f27_local1:set( 0x0 )
	end
	if not f27_local0.flags then
		local f27_local1 = f27_local0:create( "flags" )
		f27_local1:set( 0 )
	end
	if not f27_local0.buttonBit then
		local f27_local1 = Engine[@"getmodelforcontroller"]( f27_arg1 )
		f27_local1 = f27_local1.ButtonBits[f27_arg2]
		if f27_local1.progress ~= nil then
			local f27_local2 = f27_local0:create( "buttonBit" )
			f27_local2:set( f27_local1 )
		end
	end
end
CoD.Menu.AddPCKeyPromptModel = function ( f28_arg0, f28_arg1, f28_arg2, f28_arg3 )
	if CoD.IsShoutcaster( f28_arg1 ) and f28_arg0.menuName == "hud_safearea" and f28_arg0.keyModel == nil then
		f28_arg0.keyModel = Engine[@"createmodel"]( Engine[@"getmodelforcontroller"]( f28_arg1 ), f28_arg0.menuName .. ".keyPrompts" )
	end
	if not f28_arg0.keyModel then
		return 
	end
	local f28_local0 = Engine[@"getmodel"]( f28_arg0.keyModel, f28_arg2 )
	if not f28_local0 then
		f28_local0 = Engine[@"createmodel"]( f28_arg0.keyModel, f28_arg2 )
		Engine[@"setmodelvalue"]( f28_local0, f28_arg3 or Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"] )
	end
	if CoD.isPC and f28_local0 and not Engine[@"getmodel"]( f28_local0, "Button" ) then
		Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f28_local0, "Button" ), f28_arg2 )
	end
	if not f28_local0.Label then
		local f28_local1 = f28_local0:create( "Label" )
		f28_local1:set( 0x0 )
	end
	if not f28_local0.flags then
		local f28_local1 = f28_local0:create( "flags" )
		f28_local1:set( 0 )
	end
	if not f28_local0.buttonBit then
		local f28_local1 = Engine[@"getmodelforcontroller"]( f28_arg1 )
		f28_local1 = f28_local1.KeyPressBits[f28_arg2]
		if f28_local1 and f28_local1.progress ~= nil then
			local f28_local2 = f28_local0:create( "buttonBit" )
			f28_local2:set( f28_local1 )
		end
	end
end
CoD.Menu.SetButtonPromptState = function ( f29_arg0, f29_arg1, f29_arg2, f29_arg3 )
	if f29_arg0 and f29_arg0.buttonModel and f29_arg2 ~= Enum[@"luibutton"][@"lui_key_none"] then
		local f29_local0 = f29_arg0.buttonModel:create( f29_arg2 )
		if f29_local0:set( f29_arg3 ) and f29_local0.flags then
			local f29_local1 = f29_local0.flags:get()
			if CoD.BitUtility.IsBitwiseAndNonZero( f29_local1, Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] ) or CoD.BitUtility.IsBitwiseAndNonZero( f29_local1, Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] ) then
				Engine[@"hash_27CD221DF1911DD1"]( f29_arg1, f29_arg2 )
			end
		end
	end
	if Engine[@"usingfreecursor"]() then
		DataSources.FreeCursor.updateActivePrompts( f29_arg0:getOwner() )
	end
end
CoD.Menu.FindElementInLastFocusedEvent = function ( f30_arg0, f30_arg1 )
	local f30_local0 = f30_arg0.lastFocusedElemEvent
	if f30_local0 and f30_local0.idStack then
		local f30_local1 = f30_arg0
		local f30_local2 = 2
		while f30_local0 ~= nil do
			for f30_local3 = f30_local2, #f30_local0.idStack, 1 do
				f30_local1 = f30_local1[f30_local0.idStack[f30_local3]]
				if not f30_local1 then
					return 
				elseif f30_local1 == f30_arg1 then
					return f30_local0, f30_local3
				end
			end
			f30_local2 = 1
			if f30_local0 then
				f30_local0 = f30_local0.originalEvent
			end
		end
	end
end
CoD.Menu.GetLastFocusedEventElementForFn = function ( f31_arg0, f31_arg1, f31_arg2, f31_arg3 )
	local f31_local0 = f31_arg1
	if f31_arg3 == #f31_arg2.idStack and f31_arg2.originalEvent then
		local f31_local1 = f31_arg2.originalEvent
		local f31_local2 = f31_arg1[f31_local1.idStack[1]]
		if f31_local2 then
			if f31_local2.__passButtonPress then
				if f31_local1.idStack[2] then
					f31_local0 = f31_local2[f31_local1.idStack[2]] or f31_local0
				end
			else
				f31_local0 = f31_local2
			end
		end
	elseif f31_arg2.idStack[f31_arg3 + 1] then
		local f31_local1 = f31_arg1[f31_arg2.idStack[f31_arg3 + 1]]
		if f31_local1 then
			if f31_local1.__passButtonPress then
				if f31_arg2.idStack[f31_arg3 + 2] then
					f31_local0 = f31_local1[f31_arg2.idStack[f31_arg3 + 2]] or f31_local0
				end
			else
				f31_local0 = f31_local1
			end
		end
	end
	return f31_local0
end
CoD.Menu.GetElementAndFunctionTableForButton = function ( f32_arg0, f32_arg1, f32_arg2, f32_arg3, f32_arg4 )
	local f32_local0 = function ( f33_arg0, f33_arg1, f33_arg2 )
		return {
			element = f33_arg0,
			fn = f33_arg1,
			sourceElement = f33_arg2
		}
	end
	
	local f32_local1 = {}
	local f32_local2 = f32_arg0
	local f32_local3 = f32_arg0.lastFocusedElemEvent
	if (CoD.isPC or f32_arg4 ~= nil and CoD.IsShoutcaster( f32_arg4 )) and f32_arg3 and f32_arg0.lastPCInputFocusElemEvent ~= nil and (not f32_arg0.letMouse1Through or f32_arg1 ~= "MOUSE1") and (Engine[@"lastinput_mouse"]( f32_arg4 ) or Engine[@"hash_267ACA658A43FBD"]( f32_arg4 )) then
		f32_local3 = f32_arg0.lastPCInputFocusElemEvent
	end
	if f32_local3 and f32_local3.idStack then
		local f32_local4 = f32_local3
		local f32_local5 = f32_arg0
		local f32_local6 = 2
		while f32_local4 ~= nil do
			for f32_local7 = f32_local6, #f32_local4.idStack, 1 do
				f32_local5 = f32_local5[f32_local4.idStack[f32_local7]]
				if not f32_local5 then
					f32_local4 = nil
					break
				end
				f32_local2 = f32_local5
				if f32_local5[f32_arg2] and f32_local5[f32_arg2][f32_arg1] then
					local f32_local10 = f32_arg0:GetLastFocusedEventElementForFn( f32_local5, f32_local4, f32_local7 )
					if not f32_local5.isGridLayout or not f32_local10.__doNotPassButtonPressToGridLayout then
						table.insert( f32_local1, 1, f32_local0( f32_local10, f32_local5[f32_arg2][f32_arg1], f32_local5 ) )
					end
				end
			end
			f32_local6 = 1
			if f32_local4 then
				f32_local4 = f32_local4.originalEvent
			end
		end
	end
	if f32_arg0[f32_arg2] and f32_arg0[f32_arg2][f32_arg1] then
		table.insert( f32_local1, f32_local0( f32_local2, f32_arg0[f32_arg2][f32_arg1], f32_arg0 ) )
	end
	return f32_local1
end
CoD.Menu.AnyButtonConditionTrue = function ( f34_arg0, f34_arg1, f34_arg2, f34_arg3 )
	for f34_local4, f34_local5 in ipairs( f34_arg1:GetElementAndFunctionTableForButton( f34_arg3, "conditionFunctions" ) ) do
		local f34_local3 = f34_local5.fn
		if f34_local3 then
			f34_local3 = f34_local5.fn( f34_local5.element, f34_arg1, f34_arg2 )
		end
		if f34_local3 then
			return true
		end
	end
	return false
end
CoD.Menu.UpdateButtonShownState = function ( f35_arg0, f35_arg1, f35_arg2, f35_arg3 )
	local f35_local0 = f35_arg1:GetElementAndFunctionTableForButton( f35_arg3, "conditionFunctions" )
	local f35_local1 = Enum[@"luibuttonpromptstates"][@"flag_hide_prompts"]
	if f35_arg1.showButtonDisabled and f35_arg1.showButtonDisabled[f35_arg3] then
		f35_local1 = Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"]
	end
	for f35_local6, f35_local7 in ipairs( f35_local0 ) do
		local f35_local5 = f35_local7.fn
		if f35_local5 then
			f35_local5 = f35_local7.fn( f35_local7.element, f35_arg1, f35_arg2 )
		end
		if f35_local5 then
			f35_local1 = Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"]
			break
		elseif f35_local1 ~= Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"] and f35_local7.element and f35_local7.element.showButtonDisabled and f35_local7.element.showButtonDisabled[f35_arg3] then
			f35_local1 = Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"]
		end
	end
	if f35_local1 == Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"] and f35_arg1.occludedBy and f35_arg1.occludedBy.animateInFromOffset then
		f35_local1 = Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"]
	end
	f35_arg1:SetButtonPromptState( f35_arg2, f35_arg3, f35_local1 )
end
CoD.Menu.SetButtonLabel = function ( f36_arg0, f36_arg1, f36_arg2, f36_arg3, f36_arg4 )
	local f36_local0 = f36_arg0.buttonModel[f36_arg1]
	if f36_arg1 ~= Enum[@"luibutton"][@"lui_key_none"] and f36_local0 then
		local f36_local1 = f36_local0.Label
		if f36_local1 then
			if f36_arg2 == @"hash_128080D5840E11B2" then
				f36_local1:set( @"menu/overlay_label" )
			else
				f36_local1:set( f36_arg2 or 0x0 )
				if CoD.isPC then
					CoD.PCUtil.SetupButtonLabelForPC( f36_arg2, f36_local0 )
				end
			end
		end
		if not f36_arg3 then
			f36_arg3 = 0
		end
		if not Engine[@"usingfreecursor"]() then
			f36_arg3 = CoD.BitUtility.ClearBit( f36_arg3, Enum[@"luibuttonpromptflags"][@"bpf_contextual"] )
		end
		local f36_local2 = f36_local0.flags
		if f36_local2 then
			f36_local2:set( f36_arg3 or 0 )
		end
		if Engine[@"usingfreecursor"]() then
			DataSources.FreeCursor.updateActivePrompts( f36_arg0:getOwner() )
		end
	end
	if CoD.isPC and f36_arg4 ~= nil and f36_arg0.keyModel ~= nil and f36_arg0.keyModel[f36_arg4] ~= nil then
		local f36_local1 = f36_arg0.keyModel[f36_arg4]
		if not f36_arg3 then
			f36_arg3 = 0
		end
		if not Engine[@"usingfreecursor"]() then
			f36_arg3 = CoD.BitUtility.ClearBit( f36_arg3, Enum[@"luibuttonpromptflags"][@"bpf_contextual"] )
		end
		if f36_arg3 & Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] > 0 then
			f36_arg3 = f36_arg3 - Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"]
		end
		if f36_arg3 & Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] > 0 then
			f36_arg3 = f36_arg3 - Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"]
		end
		local f36_local2 = f36_local1.flags
		if f36_local2 then
			f36_local2:set( f36_arg3 or 0 )
		end
		if Engine[@"usingfreecursor"]() then
			DataSources.FreeCursor.updateActivePrompts( f36_arg0:getOwner() )
		end
	end
end
CoD.Menu.ClearButtonLabel = function ( f37_arg0, f37_arg1, f37_arg2 )
	local f37_local0, f37_local1 = nil
	if f37_arg2 then
		if CoD.isPC then
			f37_local0 = f37_arg0.keyModel[f37_arg1]
		else
			return 
		end
	else
		f37_local0 = f37_arg0.buttonModel[f37_arg1]
	end
	assert( f37_local0 ~= nil )
	f37_local1 = f37_local0.flags
	if f37_local1 then
		f37_local1:set( 0 )
	end
	if Engine[@"usingfreecursor"]() then
		DataSources.FreeCursor.updateActivePrompts( f37_arg0:getOwner() )
	end
end
CoD.Menu.LeftNavigationChoose = function ( f38_arg0, f38_arg1, f38_arg2 )
	if f38_arg0 == nil then
		local f38_local0 = -1000000000
		local f38_local1 = nil
		for f38_local5, f38_local6 in pairs( f38_arg1 ) do
			local f38_local7 = f38_local6:getCenter()
			if f38_local7 and f38_local0 < f38_local7.x then
				f38_local0 = f38_local7.x
				f38_local1 = f38_local6
			end
		end
		return f38_local1
	else
		local f38_local0 = 1000000
		local f38_local1 = nil
		local f38_local2 = false
		local f38_local3 = 3
		local f38_local4 = f38_arg0:getCenter()
		local f38_local5, f38_local6, f38_local7, f38_local8 = nil
		f38_local5, f38_local6, f38_local7, f38_local8 = Engine[@"hash_3695399A0E06EC35"]( f38_arg2, f38_arg0 )
		local f38_local9 = 0.1
		f38_local5 = f38_local5 - 1
		f38_local7 = f38_local7 + 1
		local f38_local10 = f38_local6 - (f38_local6 - f38_local8) * f38_local9
		local f38_local11 = f38_local8 + (f38_local6 - f38_local8) * f38_local9
		for f38_local30, f38_local31 in pairs( f38_arg1 ) do
			if f38_local31 ~= f38_arg0 then
				local f38_local15, f38_local16, f38_local17, f38_local18 = nil
				f38_local15, f38_local16, f38_local17, f38_local18 = Engine[@"hash_3695399A0E06EC35"]( f38_arg2, f38_local31 )
				local f38_local19 = f38_local16 - (f38_local16 - f38_local18) * f38_local9
				local f38_local20 = f38_local18 + (f38_local16 - f38_local18) * f38_local9
				local f38_local21 = f38_local31:getCenter()
				local f38_local22
				if f38_local15 >= f38_local7 or f38_local5 >= f38_local17 or f38_local17 - f38_local3 >= f38_local4.x then
					f38_local22 = false
				else
					f38_local22 = true
				end
				local f38_local23 = f38_local17 < f38_local5
				local f38_local24
				if f38_local19 >= f38_local11 or f38_local10 >= f38_local20 then
					f38_local24 = false
				else
					f38_local24 = true
				end
				if not (f38_local2 or not f38_local23) or f38_local24 and (f38_local22 or f38_local23) then
					local f38_local25 = f38_local5 - f38_local17
					local f38_local26
					if f38_local24 then
						f38_local26 = 0
						if not f38_local26 then
						
						else
							local f38_local27 = f38_local25 + f38_local26 * 10
							if f38_local22 and not f38_local2 then
								f38_local0 = f38_local27
								f38_local1 = f38_local31
								f38_local2 = true
							end
							if f38_local22 or not f38_local2 then
								if f38_local27 < f38_local0 - f38_local3 then
									f38_local0 = f38_local27
									f38_local1 = f38_local31
								end
								if f38_local27 < f38_local0 + f38_local3 then
									if f38_local1 then
										if f38_local26 == 0 then
											local f38_local28 = f38_local21.y
											local f38_local29 = f38_local1:getCenter()
											if f38_local28 < f38_local29.y then
												f38_local0 = f38_local27
												f38_local1 = f38_local31
											end
										end
									end
									f38_local0 = f38_local27
									f38_local1 = f38_local31
								end
							end
						end
					end
					f38_local26 = math.min( math.abs( f38_local16 - f38_local8 ), math.abs( f38_local6 - f38_local18 ) )
				end
			end
		end
		return f38_local1
	end
end
CoD.Menu.RightNavigationChoose = function ( f39_arg0, f39_arg1, f39_arg2 )
	if f39_arg0 == nil then
		local f39_local0 = 1000000000
		local f39_local1 = nil
		for f39_local5, f39_local6 in pairs( f39_arg1 ) do
			local f39_local7 = f39_local6:getCenter()
			if f39_local7 and f39_local7.x < f39_local0 then
				f39_local0 = f39_local7.x
				f39_local1 = f39_local6
			end
		end
		return f39_local1
	else
		local f39_local0 = 1000000
		local f39_local1 = nil
		local f39_local2 = false
		local f39_local3 = 3
		local f39_local4 = f39_arg0:getCenter()
		local f39_local5, f39_local6, f39_local7, f39_local8 = nil
		f39_local5, f39_local6, f39_local7, f39_local8 = Engine[@"hash_3695399A0E06EC35"]( f39_arg2, f39_arg0 )
		local f39_local9 = 0.1
		f39_local5 = f39_local5 - 1
		f39_local7 = f39_local7 + 1
		local f39_local10 = f39_local6 - (f39_local6 - f39_local8) * f39_local9
		local f39_local11 = f39_local8 + (f39_local6 - f39_local8) * f39_local9
		for f39_local30, f39_local31 in pairs( f39_arg1 ) do
			if f39_local31 ~= f39_arg0 then
				local f39_local15, f39_local16, f39_local17, f39_local18 = nil
				f39_local15, f39_local16, f39_local17, f39_local18 = Engine[@"hash_3695399A0E06EC35"]( f39_arg2, f39_local31 )
				local f39_local19 = f39_local16 - (f39_local16 - f39_local18) * f39_local9
				local f39_local20 = f39_local18 + (f39_local16 - f39_local18) * f39_local9
				local f39_local21 = f39_local31:getCenter()
				local f39_local22
				if f39_local15 >= f39_local7 or f39_local5 >= f39_local17 or f39_local4.x >= f39_local15 + f39_local3 then
					f39_local22 = false
				else
					f39_local22 = true
				end
				local f39_local23 = f39_local7 < f39_local15
				local f39_local24
				if f39_local19 >= f39_local11 or f39_local10 >= f39_local20 then
					f39_local24 = false
				else
					f39_local24 = true
				end
				if not (f39_local2 or not f39_local23) or f39_local24 and (f39_local22 or f39_local23) then
					local f39_local25 = f39_local15 - f39_local7
					local f39_local26
					if f39_local24 then
						f39_local26 = 0
						if not f39_local26 then
						
						else
							local f39_local27 = f39_local25 + f39_local26 * 10
							if f39_local22 and not f39_local2 then
								f39_local0 = f39_local27
								f39_local1 = f39_local31
								f39_local2 = true
							end
							if f39_local22 or not f39_local2 then
								if f39_local27 < f39_local0 - f39_local3 then
									f39_local0 = f39_local27
									f39_local1 = f39_local31
								end
								if f39_local27 < f39_local0 + f39_local3 then
									if f39_local1 then
										if f39_local26 == 0 then
											local f39_local28 = f39_local21.y
											local f39_local29 = f39_local1:getCenter()
											if f39_local28 < f39_local29.y then
												f39_local0 = f39_local27
												f39_local1 = f39_local31
											end
										end
									end
									f39_local0 = f39_local27
									f39_local1 = f39_local31
								end
							end
						end
					end
					f39_local26 = math.min( math.abs( f39_local16 - f39_local8 ), math.abs( f39_local6 - f39_local18 ) )
				end
			end
		end
		return f39_local1
	end
end
CoD.Menu.UpNavigationChoose = function ( f40_arg0, f40_arg1, f40_arg2 )
	if f40_arg0 == nil then
		local f40_local0 = 1000000000
		local f40_local1 = nil
		for f40_local5, f40_local6 in pairs( f40_arg1 ) do
			local f40_local7 = f40_local6:getCenter()
			if f40_local7 and f40_local7.y < f40_local0 then
				f40_local0 = f40_local7.y
				f40_local1 = f40_local6
			end
		end
		return f40_local1
	else
		local f40_local0 = 3
		local f40_local1 = 3
		local f40_local2 = 1000000
		local f40_local3 = nil
		local f40_local4 = 1000000
		local f40_local5 = nil
		local f40_local6 = f40_arg0:getCenter()
		local f40_local7, f40_local8, f40_local9, f40_local10 = nil
		f40_local7, f40_local8, f40_local9, f40_local10 = Engine[@"hash_3695399A0E06EC35"]( f40_arg2, f40_arg0 )
		local f40_local11 = {
			x = (f40_local7 + f40_local9) / 2,
			y = f40_local8
		}
		for f40_local29, f40_local30 in pairs( f40_arg1 ) do
			if f40_local30 ~= f40_arg0 then
				local f40_local15 = f40_local30:getCenter()
				if f40_local15 then
					local f40_local16, f40_local17, f40_local18, f40_local19 = nil
					f40_local16, f40_local17, f40_local18, f40_local19 = Engine[@"hash_3695399A0E06EC35"]( f40_arg2, f40_local30 )
					local f40_local20 = {
						x = f40_local16,
						y = f40_local19
					}
					local f40_local21 = {
						x = f40_local18,
						y = f40_local19
					}
					local f40_local22 = (f40_local16 + f40_local18) / 2
					local f40_local23 = math.abs( f40_local19 - f40_local11.y )
					local f40_local24 = false
					if f40_local7 >= f40_local22 or f40_local22 >= f40_local9 then
						if f40_local11.x < f40_local20.x then
							f40_local23 = f40_local23 + f40_local0 * (f40_local20.x - f40_local11.x)
							f40_local24 = true
						elseif f40_local21.x < f40_local11.x then
							f40_local23 = f40_local23 + f40_local0 * (f40_local11.x - f40_local21.x)
							f40_local24 = true
						end
					end
					local f40_local25 = math.abs( f40_local6.x - f40_local15.x )
					local f40_local26 = math.abs( f40_local6.y - f40_local15.y )
					if f40_local15.y < f40_local6.y then
						if not f40_local24 or 2 * f40_local25 < f40_local26 then
							if f40_local23 < f40_local2 - f40_local1 then
								f40_local2 = f40_local23
								f40_local3 = f40_local30
							end
							if f40_local23 < f40_local2 + f40_local1 then
								if f40_local3 then
									local f40_local27 = f40_local15.x
									local f40_local28 = f40_local3:getCenter()
									if f40_local27 < f40_local28.x then
										f40_local2 = f40_local23
										f40_local3 = f40_local30
									end
								end
								f40_local2 = f40_local23
								f40_local3 = f40_local30
							end
						end
						if f40_local23 < f40_local4 - f40_local1 then
							f40_local4 = f40_local23
							f40_local5 = f40_local30
						end
					end
				end
			end
		end
		if f40_local3 then
			return f40_local3
		elseif f40_local5 then
			return f40_local5
		end
	end
end
CoD.Menu.DownNavigationChoose = function ( f41_arg0, f41_arg1, f41_arg2 )
	if f41_arg0 == nil then
		local f41_local0 = -1000000000
		local f41_local1 = nil
		for f41_local5, f41_local6 in pairs( f41_arg1 ) do
			local f41_local7 = f41_local6:getCenter()
			if f41_local7 and f41_local0 < f41_local7.y then
				f41_local0 = f41_local7.y
				f41_local1 = f41_local6
			end
		end
		return f41_local1
	else
		local f41_local0 = 3
		local f41_local1 = 3
		local f41_local2 = 1000000
		local f41_local3 = nil
		local f41_local4 = 1000000
		local f41_local5 = nil
		local f41_local6 = f41_arg0:getCenter()
		if not f41_local6 then
			return 
		end
		local f41_local7, f41_local8, f41_local9, f41_local10 = nil
		f41_local7, f41_local8, f41_local9, f41_local10 = Engine[@"hash_3695399A0E06EC35"]( f41_arg2, f41_arg0 )
		local f41_local11 = {
			x = (f41_local7 + f41_local9) / 2,
			y = f41_local10
		}
		for f41_local29, f41_local30 in pairs( f41_arg1 ) do
			if f41_local30 ~= f41_arg0 then
				local f41_local15 = f41_local30:getCenter()
				if f41_local15 ~= nil then
					local f41_local16, f41_local17, f41_local18, f41_local19 = nil
					f41_local16, f41_local17, f41_local18, f41_local19 = Engine[@"hash_3695399A0E06EC35"]( f41_arg2, f41_local30 )
					local f41_local20 = {
						x = f41_local16,
						y = f41_local17
					}
					local f41_local21 = {
						x = f41_local18,
						y = f41_local17
					}
					local f41_local22 = (f41_local16 + f41_local18) / 2
					local f41_local23 = math.abs( f41_local17 - f41_local11.y )
					local f41_local24 = false
					if f41_local7 >= f41_local22 or f41_local22 >= f41_local9 then
						if f41_local11.x < f41_local20.x then
							f41_local23 = f41_local23 + f41_local0 * (f41_local20.x - f41_local11.x)
							f41_local24 = true
						elseif f41_local21.x < f41_local11.x then
							f41_local23 = f41_local23 + f41_local0 * (f41_local11.x - f41_local21.x)
							f41_local24 = true
						end
					end
					local f41_local25 = math.abs( f41_local6.x - f41_local15.x )
					local f41_local26 = math.abs( f41_local6.y - f41_local15.y )
					if f41_local6.y < f41_local15.y then
						if not f41_local24 or 2 * f41_local25 < f41_local26 then
							if f41_local23 < f41_local2 - f41_local1 then
								f41_local2 = f41_local23
								f41_local3 = f41_local30
							end
							if f41_local23 < f41_local2 + f41_local1 then
								if f41_local3 then
									local f41_local27 = f41_local15.x
									local f41_local28 = f41_local3:getCenter()
									if f41_local27 < f41_local28.x then
										f41_local2 = f41_local23
										f41_local3 = f41_local30
									end
								end
								f41_local2 = f41_local23
								f41_local3 = f41_local30
							end
						end
						if f41_local23 < f41_local4 - f41_local1 then
							f41_local4 = f41_local23
							f41_local5 = f41_local30
						end
					end
				end
			end
		end
		if f41_local3 then
			return f41_local3
		elseif f41_local5 then
			return f41_local5
		end
	end
end
CoD.Menu.TraverseResult = LuaEnum.createEnum( "continue", "stop" )
CoD.Menu.ChooseBestFocus = function ( f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4 )
	if f42_arg3 == "left" then
		return CoD.Menu.LeftNavigationChoose( f42_arg1, f42_arg2, f42_arg4 )
	elseif f42_arg3 == "right" then
		return CoD.Menu.RightNavigationChoose( f42_arg1, f42_arg2, f42_arg4 )
	elseif f42_arg3 == "up" then
		return CoD.Menu.UpNavigationChoose( f42_arg1, f42_arg2, f42_arg4 )
	elseif f42_arg3 == "down" then
		return CoD.Menu.DownNavigationChoose( f42_arg1, f42_arg2, f42_arg4 )
	else
		assert( false )
	end
end
CoD.Menu.TraverseFocusInDirection = function ( f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4, f43_arg5, f43_arg6 )
	if f43_arg2:getUseStencil() then
		local f43_local0, f43_local1, f43_local2, f43_local3 = f43_arg2:getRect()
		if f43_arg5 ~= nil then
			f43_arg5 = CoD.Menu.IntersectElementRect( f43_arg2, f43_arg5, f43_arg6 )
		else
			f43_arg5 = f43_local0 and {
				left = f43_local0,
				top = f43_local1,
				right = f43_local2,
				bottom = f43_local3
			}
		end
	end
	local f43_local0 = nil
	if f43_arg5 ~= nil and CoD.Menu.IntersectElementRect( f43_arg2, f43_arg5, f43_arg6 ) == nil then
		return CoD.Menu.TraverseResult.continue, nil
	elseif f43_arg2.__isKeyboardnavigationRedirect and f43_arg3 ~= nil then
		local f43_local1 = f43_arg2.CustomNavigation[f43_arg3]
		if f43_local1 ~= nil and not f43_local1:isFocusable() then
			f43_local1 = CoD.BaseUtility.FindSingleFocusableDescendant( f43_local1, true )
		end
		if f43_local1 ~= nil and f43_local1:isFocusable() and not f43_local1.m_disableKeyboardNavigation and f43_local1:allowsCursorMove() then
			return CoD.Menu.TraverseResult.continue, f43_arg2
		end
	end
	if f43_arg2.m_disableKeyboardNavigation or not f43_arg2:allowsCursorMove() then
		return CoD.Menu.TraverseResult.continue, nil
	elseif f43_arg2.__focusNavigationElementCallback and f43_arg2:__focusNavigationElementCallback() and (not f43_arg1 or not CoD.Menu.IsAncestorOf( f43_arg2, f43_arg1 )) then
		return CoD.Menu.TraverseResult.continue, f43_arg2
	elseif f43_arg2.m_cannotBeSelectedByDefaultNavigation and f43_arg1 and not f43_arg2:isParentOf( f43_arg1 ) then
		return CoD.Menu.TraverseResult.continue, nil
	elseif f43_arg2:isFocusable() then
		return CoD.Menu.TraverseResult.continue, f43_arg2
	end
	local f43_local1 = nil
	local f43_local2 = {}
	for f43_local8, f43_local9 in ipairs( f43_arg4 ) do
		local f43_local10 = f43_arg2[f43_local9.id]
		if f43_local10 ~= nil then
			local f43_local6, f43_local7 = CoD.Menu.TraverseFocusInDirection( f43_arg0, f43_arg1, f43_local10, f43_arg3, f43_local9.focusableElementPaths, f43_arg5, f43_arg6 )
			if f43_local6 == CoD.Menu.TraverseResult.stop then
				return f43_local6, f43_local7
			end
			table.insert( f43_local2, f43_local7 )
		end
	end
	f43_local1 = CoD.Menu.ChooseBestFocus( f43_arg0, f43_arg1, f43_local2, f43_arg3, f43_arg6 )
	if f43_local1 == nil and f43_arg2.CustomNavigation ~= nil and f43_arg2.CustomNavigation[f43_arg3] ~= nil and f43_arg1 ~= nil and CoD.Menu.IsAncestorOf( f43_arg2, f43_arg1 ) then
		return CoD.Menu.TraverseResult.stop, f43_arg2
	end
	return CoD.Menu.TraverseResult.continue, f43_local1
end
CoD.Menu.handleDefaultNavigation = function ( f44_arg0, f44_arg1, f44_arg2, f44_arg3 )
	local f44_local0 = CoD.GetMouseFocus( f44_arg2 )
	if f44_arg0.ContextualMenu and not CoD.Menu.IsAncestorOf( f44_arg0.ContextualMenu, f44_local0 ) then
		f44_local0 = f44_arg0.ContextualMenu
	end
	if CoD.isPC and f44_local0 == nil then
		
	else
		
	end
	if f44_local0 and not CoD.Menu.IsAncestorOf( f44_arg0, f44_local0 ) then
		f44_local0 = nil
	end
	if f44_local0 ~= nil and f44_local0.CustomNavigation then
		local f44_local1 = f44_local0.CustomNavigation[f44_arg3]
		if f44_local1 ~= nil and f44_local1:isFocusable() then
			f44_arg0:ChangeFocusedElement( f44_arg2, f44_local1, true )
			return 
		end
	end
	if f44_local0 and f44_local0:getRect() == nil then
		f44_local0 = nil
	end
	local f44_local1, f44_local2 = CoD.Menu.TraverseFocusInDirection( f44_arg0, f44_local0, f44_arg0, f44_arg3, f44_arg0.__focusableElementPaths, nil, f44_arg2 )
	local f44_local3 = function ( f45_arg0, f45_arg1 )
		if f45_arg0[1] == nil then
			return nil
		end
		local f45_local0 = nil
		local f45_local1 = 2000000000
		for f45_local5, f45_local6 in ipairs( f45_arg0 ) do
			local f45_local7 = f45_local6:getCenter()
			local f45_local8 = (f45_local7.x - f45_arg1.x) * (f45_local7.x - f45_arg1.x) + (f45_local7.y - f45_arg1.y) * (f45_local7.y - f45_arg1.y)
			if f45_local8 < f45_local1 then
				f45_local0 = f45_local6
				f45_local1 = f45_local8
			end
		end
		return f45_local0
	end
	
	local f44_local4 = function ( f46_arg0 )
		if f46_arg0.__isKeyboardnavigationRedirect then
			f46_arg0 = f46_arg0.CustomNavigation[f44_arg3]
			if not f46_arg0:isFocusable() then
				local f46_local0 = {}
				CoD.BaseUtility.FindAllFocusableDescendant( f46_arg0, true, f46_local0 )
				f46_arg0 = f44_local3( f46_local0, f46_arg0:getCenter() )
				local f46_local1 = assert
				local f46_local2
				if f46_arg0 then
					f46_local2 = not f46_arg0.__isKeyboardnavigationRedirect
				else
					f46_local2 = true
				end
				f46_local1( f46_local2 )
			end
		elseif f46_arg0.__focusNavigationElementCallback ~= nil then
			f46_arg0 = f46_arg0:__focusNavigationElementCallback()
		end
		if not f46_arg0:isFocusable() and f46_arg0.CustomNavigation ~= nil and f46_arg0.CustomNavigation[f44_arg3] ~= nil then
			local f46_local0 = f46_arg0.CustomNavigation[f44_arg3]
			if f46_local0:isFocusable() and not f46_local0.m_disableKeyboardNavigation then
				f46_arg0 = f46_local0
			else
				f46_arg0 = CoD.BaseUtility.FindSingleFocusableDescendant( f46_local0, true )
			end
		end
		if f46_arg0 ~= nil then
			f44_arg0:ChangeFocusedElement( f44_arg2, f46_arg0, true )
		end
	end
	
	if f44_local2 ~= nil then
		f44_local4( f44_local2 )
	elseif f44_local0 then
		f44_arg0:ChangeFocusedElement( f44_arg2, f44_local0, true )
	end
end
CoD.Menu.CanHandleNavigationInput = function ( f47_arg0 )
	if f47_arg0.__lastInputChangeFrame == Engine[@"hash_4C60FB88F484616D"]() and f47_arg0.lastFocusedElemEvent and f47_arg0.lastFocusedElemEvent.idStack then
		return false
	else
		return true
	end
end
CoD.Menu.AddPCNavigationHandler = function ( f48_arg0, f48_arg1 )
	if not f48_arg1 then
		f48_arg1 = f48_arg0:getOwner()
	end
	if f48_arg0.buttonModel == nil then
		return 
	else
		CoD.Menu.AddButtonCallbackFunction( f48_arg0, f48_arg0, f48_arg1, Enum[@"luibutton"][@"lui_key_up"], "ui_navup", function ( element, menu, controller, f49_arg3 )
			if not menu.m_disableNavigation and menu:AcceptGamePadButtonInputFromModelCallback( controller ) and CoD.Menu.CanHandleNavigationInput( menu ) then
				return menu:handleDefaultNavigation( element, controller, "up" )
			else
				return false
			end
		end )
		CoD.Menu.AddButtonCallbackFunction( f48_arg0, f48_arg0, f48_arg1, Enum[@"luibutton"][@"lui_key_down"], "ui_navdown", function ( element, menu, controller, f50_arg3 )
			if not menu.m_disableNavigation and menu:AcceptGamePadButtonInputFromModelCallback( controller ) and CoD.Menu.CanHandleNavigationInput( menu ) then
				return menu:handleDefaultNavigation( element, controller, "down" )
			else
				return false
			end
		end )
		CoD.Menu.AddButtonCallbackFunction( f48_arg0, f48_arg0, f48_arg1, Enum[@"luibutton"][@"lui_key_left"], "ui_navleft", function ( element, menu, controller, f51_arg3 )
			if not menu.m_disableNavigation and menu:AcceptGamePadButtonInputFromModelCallback( controller ) and CoD.Menu.CanHandleNavigationInput( menu ) then
				return menu:handleDefaultNavigation( element, controller, "left" )
			else
				return false
			end
		end )
		CoD.Menu.AddButtonCallbackFunction( f48_arg0, f48_arg0, f48_arg1, Enum[@"luibutton"][@"lui_key_right"], "ui_navright", function ( element, menu, controller, f52_arg3 )
			if not menu.m_disableNavigation and menu:AcceptGamePadButtonInputFromModelCallback( controller ) and CoD.Menu.CanHandleNavigationInput( menu ) then
				return menu:handleDefaultNavigation( element, controller, "right" )
			else
				return false
			end
		end )
	end
end
CoD.Menu.AddNavigationHandler = function ( f53_arg0, f53_arg1, f53_arg2 )
	
end
CoD.Menu.SendButtonPressToParentFromChild = function ( f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4 )
	local f54_local0 = f54_arg1:getParent()
	while f54_local0 do
		if f54_local0.buttonFunctions and f54_local0.buttonFunctions[f54_arg3] and f54_local0.buttonFunctions[f54_arg3]( f54_arg1, f54_arg0, f54_arg2, f54_arg4 ) then
			return 
		end
		f54_arg1 = f54_local0
		f54_local0 = f54_local0:getParent()
	end
end
CoD.Menu.SendButtonPressToParent = function ( f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4, f55_arg5 )
	local f55_local0 = f55_arg1:getParent()
	while f55_local0 do
		if f55_local0.buttonFunctions and f55_local0.buttonFunctions[f55_arg4] then
			f55_local0.buttonFunctions[f55_arg4]( f55_arg2, f55_arg0, f55_arg3, f55_arg5 )
		end
		f55_local0 = f55_local0:getParent()
	end
end
CoD.Menu.HandleButtonPress = function ( f56_arg0, f56_arg1, f56_arg2, f56_arg3, f56_arg4 )
	if CoD.isPC then
		if f56_arg0.ContextualMenu and (f56_arg2 == Enum[@"luibutton"][@"lui_key_xbb_pscircle"] or f56_arg2 == Enum[@"luibutton"][@"hash_64D2505E19049444"]) then
			CoD.PCWidgetUtility.CloseContextualMenu( f56_arg0, f56_arg1 )
			Engine[@"setmodelvalue"]( f56_arg3, 0 )
			return true
		elseif CoD.PCUtility.ChatClientContainer and f56_arg2 == Enum[@"luibutton"][@"lui_key_xbb_pscircle"] then
			local f56_local0 = CoD.ChatClientUtility.GetCurrentChattingModel( f56_arg1 )
			if f56_local0 and f56_local0:get() then
				f56_local0:set( false )
				return true
			end
		end
		if CoD.PCUtility.FrontendBattlenetContainer and f56_arg2 == Enum[@"luibutton"][@"lui_key_xbb_pscircle"] and f56_arg0.id ~= "Menu.Social_PlayerDetailsPopup" and f56_arg0.id ~= "Menu.ReportPlayer" then
			local f56_local0 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel( f56_arg1 )
			if f56_local0 and f56_local0:get() then
				CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility( f56_arg0, f56_arg0, f56_arg1 )
				return true
			end
		end
	end
	if Engine[@"iscontrollerbeingused"]( f56_arg1 ) or f56_arg0.unusedControllerAllowed then
		local f56_local0 = f56_arg0:GetElementAndFunctionTableForButton( f56_arg2, "buttonFunctions" )
		local f56_local1 = 0
		local f56_local2 = 0
		local f56_local3 = false
		if #f56_local0 > 0 and (not f56_arg0.buttonModel or not f56_arg0.buttonModel[f56_arg2] or not f56_arg0.buttonModel[f56_arg2].flags) then
			return 
		end
		for f56_local7, f56_local8 in ipairs( f56_local0 ) do
			local f56_local9 = f56_arg0.buttonModel[f56_arg2].flags:get()
			local f56_local10 = CoD.BitUtility.IsBitwiseAndNonZero( f56_local9, Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] )
			local f56_local11 = CoD.BitUtility.IsBitwiseAndNonZero( f56_local9, Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] )
			local f56_local12 = CoD.BitUtility.IsBitwiseAndNonZero( f56_arg3:get() | f56_arg4, Enum[@"luibuttonflags"][@"hash_4715085B24AAB606"] )
			local f56_local13 = CoD.BitUtility.IsBitwiseAndNonZero( f56_arg3:get() | f56_arg4, Enum[@"luibuttonflags"][@"hash_5DD6E7E17ACBF288"] )
			if (f56_local10 or f56_local11) and not f56_local12 and not f56_local13 and not CoD.BitUtility.IsBitwiseAndNonZero( f56_arg3:get() | f56_arg4, Enum[@"luibuttonflags"][@"flag_isrepeat"] ) then
				f56_local1 = f56_local1 + 1
				Engine[@"hash_7AD22E2D5C97FC6B"]( f56_arg1, f56_local9 >> Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], f56_arg2, f56_local11 )
			end
			if not (f56_local10 ~= f56_local12 or f56_local11 ~= f56_local13) or f56_local11 and f56_local12 then
				if not f56_local3 and f56_arg0:isInputOverridenForElement( f56_local8.sourceElement or f56_local8.element ) then
					f56_local3 = true
					if f56_arg0.__inputOverrideElement:__overrideFn( f56_arg0, f56_arg1, nil, f56_arg2 ) then
						Engine[@"setmodelvalue"]( f56_arg3, 0 )
						break
					end
				end
				if f56_local8.fn( f56_local8.element, f56_arg0, f56_arg1, f56_arg3 ) then
					if f56_arg0.preserveLuiButton == nil or f56_arg0.preserveLuiButton[f56_arg2] == nil then
						Engine[@"setmodelvalue"]( f56_arg3, 0 )
						break
					end
				end
				f56_local2 = f56_local2 + 1
			end
			f56_local2 = f56_local2 + 1
		end
		if CoD.isPC and f56_arg0:isInputOverridenForElement( nil ) and #f56_local0 == 0 then
			f56_arg0.__inputOverrideElement:__overrideFn( f56_arg0, f56_arg1, nil, f56_arg2 )
		end
		if f56_local1 + f56_local2 < #f56_local0 and (f56_arg0.preserveLuiButton == nil or f56_arg0.preserveLuiButton[f56_arg2] == nil) then
			Engine[@"setmodelvalue"]( f56_arg3, 0 )
		end
	else
		if IsGameTypeDOA() and Engine[@"issplitscreen"]() then
			f56_arg0:setOwner( f56_arg1 )
		end
		f56_arg0:processEvent( {
			name = "unused_gamepad_button",
			controller = f56_arg1
		} )
	end
end
CoD.Menu.HandlePCKeyPress = function ( f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4, f57_arg5 )
	if not f57_arg0.keyModel then
		return false
	elseif not f57_arg5 then
		f57_arg5 = 0
	end
	if f57_arg0.ContextualMenu and f57_arg2 == "ESCAPE" then
		CoD.PCWidgetUtility.CloseContextualMenu( f57_arg0, f57_arg1 )
		return true
	elseif CoD.isPC then
		if CoD.PCUtility.ChatClientContainer and f57_arg0[CoD.PCUtility.ChatClientContainer.id] and f57_arg2 == "ESCAPE" then
			local f57_local0 = CoD.ChatClientUtility.GetCurrentChattingModel( f57_arg1 )
			if f57_local0 and f57_local0:get() then
				f57_local0:set( false )
				Engine[@"setmodelvalue"]( f57_arg3, 0 )
				return true
			end
		end
		if CoD.PCUtility.FrontendBattlenetContainer and f57_arg0[CoD.PCUtility.FrontendBattlenetContainer.id] and f57_arg2 == "ESCAPE" then
			local f57_local0 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel( f57_arg1 )
			if f57_local0 and f57_local0:get() then
				if CoD.PCBattlenetUtility.AddFriendMenuBattlenetIsActive( f57_arg1 ) then
					CoD.PCBattlenetUtility.ToggleBattlenetAddFriendMenuVisibility( f57_arg1 )
				else
					CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility( f57_arg0, f57_arg0, f57_arg1 )
				end
				Engine[@"setmodelvalue"]( f57_arg3, 0 )
				return true
			end
		end
		if CoD.DirectorUtility.IsLoadoutPreviewWidgetShown( f57_arg1 ) and f57_arg2 == "ESCAPE" then
			CoD.DirectorUtility.HideLoadoutPreview( f57_arg1 )
			return true
		end
	end
	local f57_local0 = false
	local f57_local1 = false
	if Engine[@"iscontrollerbeingused"]( f57_arg1 ) or f57_arg0.unusedControllerAllowed then
		local f57_local2 = f57_arg0:GetElementAndFunctionTableForButton( f57_arg2, "buttonFunctions", true, f57_arg1 )
		local f57_local3 = 0
		local f57_local4 = 0
		for f57_local18, f57_local19 in ipairs( f57_local2 ) do
			if f57_arg0.keyModel[f57_arg2] then
				local f57_local8 = f57_arg0.keyModel[f57_arg2].flags
				local f57_local9 = f57_arg0.keyModel[f57_arg2].flags:get()
			end
			local f57_local10 = f57_local8 and f57_local9 or 0
			local f57_local11 = CoD.BitUtility.IsBitwiseAndNonZero( f57_local10, Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] )
			local f57_local12 = CoD.BitUtility.IsBitwiseAndNonZero( f57_local10, Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] )
			local f57_local13 = CoD.BitUtility.IsBitwiseAndNonZero( f57_arg3:get() | f57_arg5, Enum[@"luibuttonflags"][@"hash_4715085B24AAB606"] )
			local f57_local14 = CoD.BitUtility.IsBitwiseAndNonZero( f57_arg3:get() | f57_arg5, Enum[@"luibuttonflags"][@"hash_5DD6E7E17ACBF288"] )
			if f57_local11 and not Engine[@"hash_4795EC9C818FACDF"]( f57_arg1, f57_arg2 ) then
				f57_local11 = false
			end
			if (f57_local11 or f57_local12) and not f57_local13 and not f57_local14 then
				f57_local0 = true
				f57_local3 = f57_local3 + 1
				Engine[@"hash_7959D466B3459B3A"]( f57_arg1, f57_local10 >> Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], f57_arg2, f57_local12, f57_arg4 )
			end
			if not (f57_local11 ~= f57_local13 or f57_local12 ~= f57_local14) or f57_local12 and f57_local13 then
				if not f57_local1 then
					local f57_local15 = f57_arg0
					local f57_local16 = f57_arg0.isInputOverridenForElement
					local f57_local17 = f57_local19.sourceElement
					if not f57_local17 then
						f57_local17 = f57_local19.element
					end
					if f57_local16( f57_local15, f57_local17 ) then
						f57_local1 = true
						if f57_arg0.__inputOverrideElement:__overrideFn( f57_arg0, f57_arg1, f57_arg2, f57_arg4 ) then
							Engine[@"setmodelvalue"]( f57_arg3, 0 )
							f57_local0 = true
							break
						end
					end
				end
				if f57_local19.fn( f57_local19.element, f57_arg0, f57_arg1, f57_arg3 ) then
					f57_local0 = true
					if f57_arg0.preserveLuiButton == nil or f57_arg0.preserveLuiButton[f57_arg2] == nil then
						Engine[@"setmodelvalue"]( f57_arg3, 0 )
						break
					end
				end
				f57_local4 = f57_local4 + 1
			end
			f57_local4 = f57_local4 + 1
		end
		if f57_arg0:isInputOverridenForElement( nil ) and #f57_local2 == 0 then
			f57_arg0.__inputOverrideElement:__overrideFn( f57_arg0, f57_arg1, f57_arg2, f57_arg4 )
		end
		if f57_local3 + f57_local4 < #f57_local2 and (f57_arg0.preserveLuiButton == nil or f57_arg0.preserveLuiButton[f57_arg2] == nil) then
			Engine[@"setmodelvalue"]( f57_arg3, 0 )
		end
	end
	return f57_local0
end
CoD.Menu.IsAncestorOf = function ( f58_arg0, f58_arg1 )
	local f58_local0 = f58_arg1
	while f58_local0 do
		f58_local0 = f58_local0:getParent()
		if f58_local0 == f58_arg0 then
			return true
		end
	end
	return false
end
CoD.Menu.UnsubscribeFromControllerSubscriptionsForElement = function ( f59_arg0, f59_arg1 )
	if not f59_arg0.controllerSubscriptions then
		return 
	end
	for f59_local0 = #f59_arg0.controllerSubscriptions, 1, -1 do
		local f59_local3 = f59_arg0.controllerSubscriptions[f59_local0].element
		if f59_arg1 == f59_local3 or CoD.Menu.IsAncestorOf( f59_arg1, f59_local3 ) then
			f59_arg0:removeSubscription( f59_arg0.controllerSubscriptions[f59_local0].subscription )
			table.remove( f59_arg0.controllerSubscriptions, f59_local0 )
		end
	end
	if f59_arg0.buttonSubscriptions then
		if #f59_arg0.controllerSubscriptions == 0 then
			f59_arg0.buttonSubscriptions = nil
		else
			error( "Trying to reset buttonSubscriptions but controllerSubscriptions is not 0 in menu" .. f59_arg0.id )
		end
	end
end
CoD.Menu.AddButtonCallbackFunction = function ( f60_arg0, f60_arg1, f60_arg2, f60_arg3, f60_arg4, f60_arg5, f60_arg6, f60_arg7 )
	if not f60_arg1.buttonFunctions then
		f60_arg1.buttonFunctions = {}
	end
	if not f60_arg1.conditionFunctions then
		f60_arg1.conditionFunctions = {}
	end
	if not f60_arg1.showButtonDisabled then
		f60_arg1.showButtonDisabled = {}
	end
	if not f60_arg1.__autoButtonCallback then
		f60_arg1.__autoButtonCallback = {}
	end
	if not f60_arg0.showButtonDisabled then
		f60_arg0.showButtonDisabled = {}
	end
	if not f60_arg0.buttonSubscriptions then
		f60_arg0.buttonSubscriptions = {}
	end
	if not f60_arg0.controllerSubscriptions then
		f60_arg0.controllerSubscriptions = {}
	end
	if CoD.isPC and CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner then
		if CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner.callbacks == nil then
			CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner.callbacks = {}
		end
		local f60_local0
		if f60_arg1 ~= f60_arg0 then
			f60_local0 = nil
		else
			f60_local0 = true
		end
		table.insert( CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner.callbacks, {
			menu = f60_arg0,
			element = f60_arg1,
			controller = f60_arg2,
			luiButton = f60_arg3,
			pcKey = f60_arg4,
			func = f60_arg5,
			conditionFunc = f60_arg6,
			showDisabled = f60_arg7,
			elementIsMenu = f60_local0
		} )
	end
	if f60_arg3 ~= Enum[@"luibutton"][@"lui_key_none"] then
		f60_arg1.buttonFunctions[f60_arg3] = f60_arg5
		f60_arg1.conditionFunctions[f60_arg3] = f60_arg6
		f60_arg1.showButtonDisabled[f60_arg3] = f60_arg7
		f60_arg0.showButtonDisabled[f60_arg3] = f60_arg0.showButtonDisabled[f60_arg3] or f60_arg7
		if CoD.isPC and f60_arg4 ~= nil then
			f60_arg0:AddPCKeyPromptModel( f60_arg2, f60_arg4 )
		end
		f60_arg0:AddButtonPromptModel( f60_arg2, f60_arg3 )
		CoD.Menu.UpdateButtonShownState( f60_arg1, f60_arg0, f60_arg2, f60_arg3 )
		local f60_local0 = f60_arg2
		local f60_local1 = f60_arg2
		if f60_arg0.anyControllerAllowed then
			f60_local0 = 0
			f60_local1 = Engine[@"getmaxlocalcontrollers"]() - 1
		end
		if not f60_arg0.buttonSubscriptions[f60_arg3] then
			for f60_local2 = f60_local0, f60_local1, 1 do
				local f60_local5 = f60_local2
				f60_arg0.buttonSubscriptions[f60_arg3] = true
				local f60_local6 = Engine[@"getmodelforcontroller"]( f60_local5 )
				f60_local6 = f60_local6.ButtonBits[f60_arg3]
				local f60_local7 = f60_local6
				table.insert( f60_arg0.controllerSubscriptions, {
					element = f60_arg1,
					subscription = f60_arg0:subscribeToModel( f60_local6, function ( f61_arg0 )
						if f60_arg3 == Enum[@"luibutton"][@"lui_key_xba_pscross"] and f60_arg0:MouseButtonCallbackFunction( f60_arg2, "MOUSE1", f61_arg0 ) then
							return 
						elseif (not f60_arg0.occludedBy or f60_arg0._isPriorityMenu) and not CoD.Menu.SpinnerIsActive and (not CoD.Menu.IsPriorityMenuOpen( f60_local5 ) or f60_arg0._isPriorityMenu) and CoD.BitUtility.IsBitwiseAndNonZero( Engine[@"getmodelvalue"]( f61_arg0 ), Enum[@"luibuttonflags"][@"flag_down"] ) and not f60_arg0.m_disableAllButtonActions then
							CoD.Menu.HandleButtonPress( f60_arg0, f60_local5, f60_arg3, f61_arg0, 0 )
						end
					end
					, false )
				} )
			end
		end
	end
	if (CoD.isPC or CoD.IsShoutcaster( f60_arg2 )) and f60_arg4 ~= nil then
		if not f60_arg0.keyPressSubscriptions then
			f60_arg0.keyPressSubscriptions = {}
		end
		if not f60_arg0.__lastRepeatFrame then
			f60_arg0.__lastRepeatFrame = {}
		end
		f60_arg1.buttonFunctions[f60_arg4] = f60_arg5
		f60_arg1.conditionFunctions[f60_arg4] = f60_arg6
		f60_arg1.showButtonDisabled[f60_arg4] = f60_arg7
		f60_arg0.showButtonDisabled[f60_arg4] = f60_arg0.showButtonDisabled[f60_arg4] or f60_arg7
		local f60_local0 = Engine[@"getmodel"]( f60_arg0.buttonModel, f60_arg3 )
		if f60_local0 then
			Engine[@"setmodelvalue"]( Engine[@"createmodel"]( f60_local0, "KeyShortcut" ), f60_arg4 )
		end
		f60_arg0:AddPCKeyPromptModel( f60_arg2, f60_arg4 )
		local f60_local1 = {
			"ui_navup",
			"ui_navdown",
			"ui_navright",
			"ui_navleft"
		}
		local f60_local2 = false
		for f60_local6, f60_local7 in ipairs( f60_local1 ) do
			if f60_arg4 == f60_local7 then
				f60_local2 = true
				break
			end
		end
		if not f60_arg0.keyPressSubscriptions[f60_arg4] then
			f60_arg0.keyPressSubscriptions[f60_arg4] = true
			f60_local3 = Engine[@"getmodel"]( Engine[@"getmodelforcontroller"]( f60_arg2 ), "KeyPressBits." .. f60_arg4 )
			if not f60_local3 then
				f60_local3 = Engine[@"hash_7A9FCAD7BE6FA349"]( f60_arg4, f60_arg2 )
			end
			if f60_local3 ~= nil then
				table.insert( f60_arg0.controllerSubscriptions, {
					element = f60_arg1,
					subscription = f60_arg0:subscribeToModel( f60_local3, function ( f62_arg0 )
						if not f60_arg0:MouseButtonCallbackFunction( f60_arg2, f60_arg4, f62_arg0 ) and CoD.Menu.CanProcessPCKeyPress( f60_arg0, f62_arg0, f60_arg2, f60_local2, f60_arg4 ) then
							CoD.Menu.HandlePCKeyPress( f60_arg0, f60_arg2, f60_arg4, f62_arg0, f60_arg3 )
						end
					end
					, false )
				} )
			end
		end
		if f60_arg1.__autoButtonCallback[f60_arg4] then
			f60_arg1.__autoButtonCallback[f60_arg4] = nil
		end
	end
	if CoD.isPC then
		if f60_arg3 == Enum[@"luibutton"][@"lui_key_xbb_pscircle"] and (not f60_arg1.buttonFunctions.ESCAPE or not f60_arg1.__autoButtonCallback or f60_arg1.__autoButtonCallback.ESCAPE) and not f60_arg1.__disableAutoButtonCallback then
			f60_arg0:AddButtonCallbackFunction( f60_arg1, f60_arg2, Enum[@"luibutton"][@"lui_key_none"], "ESCAPE", f60_arg5, f60_arg6, f60_arg7 )
			f60_arg1.__autoButtonCallback.ESCAPE = true
		end
		if f60_arg3 == Enum[@"luibutton"][@"lui_key_xba_pscross"] and (not f60_arg1.buttonFunctions.ui_confirm or not f60_arg1.__autoButtonCallback or f60_arg1.__autoButtonCallback.ui_confirm) and not f60_arg1.__disableAutoButtonCallback then
			f60_arg0:AddButtonCallbackFunction( f60_arg1, f60_arg2, Enum[@"luibutton"][@"lui_key_none"], "ui_confirm", f60_arg5, f60_arg6, f60_arg7 )
			f60_arg1.__autoButtonCallback.ui_confirm = true
		end
		if f60_arg3 == Enum[@"luibutton"][@"lui_key_xba_pscross"] and f60_arg1 ~= f60_arg0 and (not f60_arg1.buttonFunctions.MOUSE1 or not f60_arg1.__autoButtonCallback or f60_arg1.__autoButtonCallback.MOUSE1) and not f60_arg1.__disableAutoButtonCallback then
			f60_arg0:AddButtonCallbackFunction( f60_arg1, f60_arg2, Enum[@"luibutton"][@"lui_key_none"], "MOUSE1", f60_arg5, f60_arg6, f60_arg7 )
			f60_arg1.__autoButtonCallback.MOUSE1 = true
		end
	end
end
CoD.Menu.GamepadButton = function ( f63_arg0, f63_arg1 )
	if f63_arg0.m_inputDisabled then
		return 
	elseif (f63_arg0.anyControllerAllowed or Engine[@"iscontrollerbeingused"]( f63_arg1.controller ) or f63_arg0.unusedControllerAllowed) and (not f63_arg0.m_ownerController or f63_arg0.m_ownerController == f63_arg1.controller) then
		return f63_arg0:dispatchEventToChildren( f63_arg1 )
	else
		local f63_local0 = f63_arg1.name
		f63_arg1.name = "unused_gamepad_button"
		local f63_local1 = f63_arg0:processEvent( f63_arg1 )
		f63_arg1.name = f63_local0
		return f63_local1
	end
end
CoD.Menu.RemoveFromCurrMenuNameList = function ( f64_arg0 )
	if f64_arg0 == nil or f64_arg0 == "" then
		return 
	end
	local f64_local0 = Dvar[@"ui_currmenunamelist"]:get()
	if not f64_local0 then
		return 
	end
	local f64_local1 = ""
	for f64_local5 in string.gmatch( f64_local0, "[^%s,]+" ) do
		if f64_arg0 ~= f64_local5 then
			if f64_local1 ~= "" then
				f64_local1 = f64_local1 .. ", "
			end
			f64_local1 = f64_local1 .. f64_local5
		end
	end
	Dvar[@"ui_currmenunamelist"]:set( f64_local1 )
end
CoD.Menu.AddToCurrMenuNameList = function ( f65_arg0 )
	if LUI.DEV == nil or f65_arg0 == nil or f65_arg0 == "" then
		return 
	end
	local f65_local0 = Dvar[@"ui_currmenunamelist"]:get()
	if not f65_local0 or f65_local0 == "" then
		Dvar[@"ui_currmenunamelist"]:set( f65_arg0 )
		return 
	end
	for f65_local4 in string.gmatch( f65_local0, "[^%s,]+" ) do
		if f65_local4 == f65_arg0 then
			return 
		end
	end
	Dvar[@"ui_currmenunamelist"]:set( f65_local0 .. ", " .. f65_arg0 )
end
CoD.Menu.openMenuAsChild = function ( f66_arg0, f66_arg1, f66_arg2, f66_arg3 )
	local f66_local0 = CoD.Menu.safeCreateMenu( f66_arg1, f66_arg2, f66_arg3 )
	local f66_local1 = f66_arg0:getParent()
	f66_local1:addElement( f66_local0 )
	f66_local0:menuOpened( f66_arg2, f66_local0 )
	return f66_local0
end
CoD.Menu.openMenu = function ( f67_arg0, f67_arg1, f67_arg2, f67_arg3 )
	local f67_local0 = CoD.Menu.safeCreateMenu( f67_arg1, f67_arg2, f67_arg3 )
	if f67_local0.previousMenuName == nil then
		f67_local0:setPreviousMenu( f67_arg0.menuName, f67_arg0.userData )
	end
	if f67_arg0.occludedMenu then
		f67_local0:setOccludedMenu( f67_arg0.occludedMenu )
	end
	local f67_local1 = f67_arg0:getParent()
	f67_local1:addElement( f67_local0 )
	f67_local0:menuOpened( f67_arg2, f67_local0 )
	return f67_local0
end
CoD.Menu.replaceMenu = function ( f68_arg0, f68_arg1, f68_arg2, f68_arg3, f68_arg4, f68_arg5, f68_arg6, f68_arg7 )
	local f68_local0 = CoD.Menu.safeCreateMenu( f68_arg1, f68_arg2, f68_arg3 )
	if f68_local0.previousMenuName == nil then
		f68_local0:setPreviousMenu( f68_arg5, f68_arg4 )
	end
	if f68_arg6 then
		f68_local0:setOccludedMenu( f68_arg6 )
	end
	f68_arg7:addElement( f68_local0 )
	f68_local0:menuOpened( f68_arg2, f68_local0 )
	return f68_local0
end
CoD.Menu.ModalDialogInfo = {}
CoD.Menu.ModalDialogInfo.Options = {}
CoD.Menu.openPopup = function ( f69_arg0, f69_arg1, f69_arg2, f69_arg3, f69_arg4 )
	local f69_local0 = CoD.Menu.safeCreateMenu( f69_arg1, f69_arg2, f69_arg3 )
	if not f69_local0 then
		return nil
	end
	f69_local0:setOccludedMenu( f69_arg0 )
	if f69_local0.animateInFromOffset then
		CoD.Menu.UpdateAllButtonPrompts( f69_arg0, f69_arg2 )
	end
	REG6.addElement( f69_arg4 or f69_arg0:getParent(), f69_local0 )
	f69_local0:menuOpened( f69_arg2, f69_local0 )
	return f69_local0
end
CoD.Menu.openOverlay = function ( f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4 )
	f70_arg0:saveState( f70_arg2 )
	local f70_local0 = CoD.Menu.openPopup( f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4 )
	if f70_local0.occludedMenu ~= nil and not f70_local0.occludedMenu._isPriorityMenu then
		f70_local0.occludedMenu:setAlpha( 0 )
	end
	f70_local0.m_isOverlay = true
	return f70_local0
end
CoD.Menu.returnToPreviousMenu = function ( f71_arg0, f71_arg1 )
	local f71_local0 = nil
	if f71_arg0.previousMenuName then
		local f71_local1 = f71_arg0:getParent()
		local f71_local2 = f71_arg0.previousMenuName
		local f71_local3 = f71_arg0.previousUserData
		local f71_local4 = f71_arg0.occludedMenu
		if not f71_local4 then
			f71_arg0:close()
			f71_arg0 = nil
		end
		local f71_local5 = CoD.Menu.safeCreateMenu( f71_local2, f71_arg1, f71_local3 )
		f71_local1:addElement( f71_local5 )
		if f71_local4 then
			f71_local5:setOccludedMenu( f71_local4 )
		end
		f71_local0 = f71_local5
		if f71_local0 then
			f71_local0:menuOpened( f71_arg1, f71_local0 )
		end
	elseif f71_arg0.occludedMenu then
		if IsGameTypeDOA() and Engine[@"issplitscreen"]() then
			f71_arg0.occludedMenu:setOwner( f71_arg1 )
		end
		f71_arg0.occludedMenu:processEvent( {
			name = "occlusion_change",
			occluded = false,
			occludedBy = f71_arg0,
			controller = f71_arg1
		} )
		f71_local0 = f71_arg0.occludedMenu
	end
	if CoD.isPC then
		CoD.FreeCursorUtility.ForceCloseDetailedView( f71_arg0, f71_arg1 )
	end
	if f71_arg0 ~= nil then
		if f71_arg0.occludedMenu then
			f71_arg0.occludedMenu.occludedBy = f71_arg0.occludedBy
		end
		f71_arg0:close()
	end
	if f71_local0 and not f71_local0.occludedBy then
		f71_local0:setAlpha( 1 )
	end
	return f71_local0
end
CoD.Menu.setOccludedMenu = function ( f72_arg0, f72_arg1 )
	f72_arg0.occludedMenu = f72_arg1
	if f72_arg1 then
		f72_arg1:processEvent( {
			name = "occlusion_change",
			occluded = true,
			occludedBy = f72_arg0
		} )
	end
	f72_arg0:updateBlur()
end
CoD.Menu.setOwner = function ( f73_arg0, f73_arg1 )
	if CoD.isWIIU then
		f73_arg0:setOwnerControllerIndex( f73_arg1 )
	end
	f73_arg0.m_ownerController = f73_arg1
end
CoD.Menu.getOwner = function ( f74_arg0 )
	return f74_arg0.m_ownerController
end
CoD.Menu.setPreviousMenu = function ( f75_arg0, f75_arg1, f75_arg2 )
	f75_arg0.previousMenuName = f75_arg1
	f75_arg0.previousUserData = f75_arg2
end
CoD.Menu.updateBlur = function ( f76_arg0 )
	local f76_local0 = f76_arg0:getOwner() or 0
	if Engine[@"isingame"]() then
		if f76_arg0.occludedMenu then
			if f76_arg0.disableBlur == true then
				Engine[@"blurworld"]( f76_local0, 0 )
			else
				Engine[@"blurworld"]( f76_local0, 2 )
			end
			if not f76_arg0.disableInputLock then
				Engine[@"lockinput"]( f76_local0, true )
				Engine[@"setuiactive"]( f76_local0, true )
			end
		else
			if CoD.isMultiplayer and not Engine[@"isdemoplaying"]() and not CoD.PlayerRoleUtility.IsPositionDraftStage( f76_local0, CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_NONE ) then
				return 
			end
			Engine[@"blurworld"]( f76_local0, 0 )
			if not f76_arg0.disableInputLock then
				Engine[@"lockinput"]( f76_local0, false )
				Engine[@"setuiactive"]( f76_local0, false )
			end
		end
	elseif f76_arg0.disableBlur ~= nil and f76_arg0.disableBlur == true then
		return 
	elseif not f76_arg0.occludedMenu then
		f76_arg0:setBlur( false )
	end
end
CoD.Menu.MenuChanged = function ( f77_arg0, f77_arg1 )
	if f77_arg0.occludedBy then
		if f77_arg0.occludedMenu == f77_arg1.prevMenu then
			f77_arg0:setOccludedMenu( f77_arg1.nextMenu )
		end
		return 
	elseif f77_arg0.occludedMenu then
		f77_arg0.previousMenuName = nil
		f77_arg0:goBack( f77_arg1.controller )
		f77_arg0.occludedMenu:processEvent( f77_arg1 )
	end
end
CoD.Menu.UserSignedOut = function ( f78_arg0, f78_arg1 )
	if f78_arg0.occludedBy or not IsInGame() and f78_arg1.controller ~= f78_arg0:getOwner() then
		return 
	elseif f78_arg0.occludedMenu then
		f78_arg0.previousMenuName = nil
		f78_arg0:goBack( f78_arg1.controller )
		f78_arg0.occludedMenu:processEvent( f78_arg1 )
	end
end
CoD.Menu.ResolutionChanged = function ( f79_arg0, f79_arg1 )
	if f79_arg1.resolutionChanged and not f79_arg0.occludedBy then
		f79_arg0:processEvent( {
			name = "occlusion_change",
			occluded = false,
			occludedBy = f79_arg0
		} )
	end
	f79_arg0:processEvent( {
		name = "options_refresh",
		controller = f79_arg1.controller
	} )
end
CoD.Menu.OpenRefetchWADConfirmationPopup = function ( f80_arg0, f80_arg1 )
	if not f80_arg0.occludedBy then
		f80_arg0:openPopup( f80_arg1.popupName, f80_arg1.controller )
		return true
	else
		
	end
end
CoD.Menu.OpenTexturePackConfirmationPopup = function ( f81_arg0, f81_arg1 )
	if not f81_arg0.occludedBy then
		f81_arg0:openPopup( f81_arg1.popupName, f81_arg1.controller )
		return true
	else
		
	end
end
CoD.Menu.OpenKeyboardTextFieldPopup = function ( f82_arg0, f82_arg1 )
	if CoD.isPC and not f82_arg0.occludedBy then
		local f82_local0 = OpenPopup( f82_arg0, "KeyboardTextField", f82_arg1.controller )
		return true
	else
		
	end
end
CoD.Menu.OpenPopupEventHandler = function ( f83_arg0, f83_arg1 )
	if f83_arg0.occludedBy then
		if f83_arg1.recursive then
			return 
		else
			return 
		end
	elseif f83_arg0.menuName ~= f83_arg1.popupName then
		f83_arg0:openPopup( f83_arg1.popupName, f83_arg1.controller )
	end
	return true
end
CoD.Menu.OpenPlayercard = function ( f84_arg0, f84_arg1 )
	if f84_arg0.occludedBy then
		return 
	elseif Engine[@"isuserguest"]( f84_arg1.controller ) then
		f84_arg0:openPopup( "popup_guest_contentrestricted", f84_arg1.controller )
		return 
	elseif f84_arg0.menuName ~= "FriendPopup" and f84_arg0.menuName ~= "MainMenu" then
		CoD.FriendPopup.SelectedPlayerXuid = f84_arg1.selectedPlayerXuid
		CoD.FriendPopup.SelectedPlayerName = f84_arg1.selectedFriendName
		f84_arg0:openPopup( "FriendPopup", f84_arg1.controller )
	end
	return true
end
CoD.Menu.updateButtonPromptBarsForSplitscreen = function ( f85_arg0 )
	
end
CoD.Menu.CanProcessPCKeyPress = function ( f86_arg0, f86_arg1, f86_arg2, f86_arg3, f86_arg4 )
	local f86_local0
	if not f86_arg0.occludedBy and (not CoD.Menu.IsPriorityMenuOpen( f86_arg2 ) or f86_arg0._isPriorityMenu) and not CoD.Menu.SpinnerIsActive then
		f86_local0 = CoD.BitUtility.IsBitwiseAndNonZero( Engine[@"getmodelvalue"]( f86_arg1 ), Enum[@"luibuttonflags"][@"flag_down"] )
		if f86_local0 then
			f86_local0 = not f86_arg0.m_disableAllButtonActions
		end
	else
		f86_local0 = false
	end
	if f86_local0 then
		local f86_local1 = CoD.BitUtility.IsBitwiseAndNonZero( f86_arg1:get(), Enum[@"luibuttonflags"][@"flag_isrepeat"] )
		local f86_local2 = Engine[@"hash_4C60FB88F484616D"]()
		if not f86_arg3 then
			f86_local0 = not f86_local1
		elseif f86_local1 then
			f86_local0 = f86_arg0.__lastRepeatFrame[f86_arg4] ~= f86_local2
		else
			f86_local0 = true
		end
		if f86_local1 then
			f86_arg0.__lastRepeatFrame[f86_arg4] = f86_local2
		end
	end
	return f86_local0
end
CoD.Menu.OpenFrontendSaveGameWarningPopup = function ( f87_arg0, f87_arg1 )
	f87_arg0:openPopup( "FrontendSaveGameWarningPopup", Engine[@"getprimarycontroller"](), f87_arg1 )
end
CoD.Menu.OpenFrontendSaveGameErrorPopup = function ( f88_arg0, f88_arg1 )
	f88_arg0:openPopup( "FrontendSaveGameErrorPopup", Engine[@"getprimarycontroller"](), f88_arg1 )
end
CoD.Menu.addElementToPendingUpdateStateList = function ( f89_arg0, f89_arg1 )
	table.insert( f89_arg0.__elementsPendingUpdateState, f89_arg1 )
end
CoD.Menu.updateElementState = function ( f90_arg0, f90_arg1, f90_arg2 )
	if not f90_arg0.__loaded or f90_arg0.__elementsPendingUpdateState and LuaUtils.FindItemInArray( f90_arg0.__elementsPendingUpdateState, f90_arg1 ) then
		return 
	end
	local f90_local0 = nil
	if f90_arg1.stateConditions then
		for f90_local4, f90_local5 in ipairs( f90_arg1.stateConditions ) do
			if not f90_local5.condition or f90_local5.condition( f90_arg0, f90_arg1, f90_arg2 ) then
				f90_local0 = f90_local5.stateName
				break
			end
		end
	end
	if not f90_local0 then
		f90_local0 = "DefaultState"
	end
	assert( f90_arg2.controller ~= nil )
	if (f90_arg2.initialSetup or f90_local0 ~= f90_arg1.currentState) and f90_arg1:setState( f90_arg2.controller, f90_local0, false, f90_arg2.initialSetup ) and f90_arg1:isInFocus() then
		f90_arg1:playClip( "Focus" )
	end
	if f90_arg1.__updateChildrenOnStateUpdate and f90_arg2.name ~= "update_state" then
		local f90_local2 = LUI.ShallowCopy( f90_arg2 )
		f90_local2.name = "update_state"
		f90_local2.forceDispatch = true
		f90_arg1:dispatchEventToChildren( f90_local2 )
	end
end
CoD.Menu.removeButtonPrompt = function ( f91_arg0, f91_arg1, f91_arg2 )
	local f91_local0 = f91_arg0["buttonPrompt_" .. f91_arg1]
	if f91_local0 then
		if f91_local0.elementThatAddedButtonPrompt and f91_local0.elementThatAddedButtonPrompt ~= f91_arg2 then
			return 
		end
		f91_local0:close()
	end
end
CoD.Menu.OpenMenu = function ( f92_arg0, f92_arg1 )
	if f92_arg0.occludedMenu then
		return 
	elseif f92_arg0.menuName == f92_arg1.menuName then
		return 
	else
		local f92_local0 = f92_arg0.userData
		local f92_local1 = f92_arg0.menuName
		local f92_local2 = f92_arg0.occludedMenu
		local f92_local3 = f92_arg0:getParent()
		f92_arg0:close()
		local f92_local4 = f92_arg0:replaceMenu( f92_arg1.menuName, f92_arg1.controller, nil, nil, f92_local1, f92_local2, f92_local3 )
		local f92_local5 = f92_local4:getParent()
		f92_local5:processEvent( {
			name = "menu_changed",
			prevMenu = f92_arg0,
			nextMenu = f92_local4,
			controller = f92_arg1.controller
		} )
	end
end
CoD.Menu.setSessionMode = function ( f93_arg0, f93_arg1 )
	f93_arg0._sessionMode = f93_arg1
end
CoD.Menu.getSessionMode = function ( f94_arg0 )
	return f94_arg0._sessionMode
end
CoD.Menu.GetNavigationForMenu = function ( f95_arg0, f95_arg1 )
	if not CoD.MenuNavigation then
		return 
	end
	local f95_local0 = CoD.MenuNavigation[f95_arg0]
	if not f95_local0 then
		return 
	end
	for f95_local1 = #f95_local0, 1, -1 do
		local f95_local4 = f95_local0[f95_local1]
		for f95_local5 = #f95_local4, 1, -1 do
			if f95_local4[f95_local5] == f95_arg1 then
				return f95_local1, f95_local5
			end
		end
	end
end
CoD.Menu.GetNavigationForMenuToMenu = function ( f96_arg0, f96_arg1, f96_arg2 )
	if not CoD.MenuNavigation then
		return 
	end
	local f96_local0 = CoD.MenuNavigation[f96_arg0]
	if not f96_local0 then
		return 
	end
	for f96_local1 = #f96_local0, 1, -1 do
		local f96_local4 = f96_local0[f96_local1]
		for f96_local5 = #f96_local4, 1, -1 do
			if f96_local4[f96_local5] == f96_arg1 then
				for f96_local8 = f96_local5 - 1, 1, -1 do
					if f96_local4[f96_local8] == f96_arg2 then
						return f96_local1, f96_local8
					end
				end
			end
		end
	end
end
CoD.Menu.RatGetMenuInfo = function ( f97_arg0, f97_arg1 )
	if Rat ~= nil then
		Rat.HandleGetRatMenuInfo( f97_arg0, f97_arg1 )
	end
end
CoD.Menu.RatFindListItem = function ( f98_arg0, f98_arg1 )
	if Rat ~= nil then
		Rat.HandleFindListItem( f98_arg0, f98_arg1 )
	end
end
CoD.Menu.UpdateAllButtonPrompts = function ( f99_arg0, f99_arg1 )
	if f99_arg0.buttonSubscriptions ~= nil then
		for f99_local3, f99_local4 in pairs( f99_arg0.buttonSubscriptions ) do
			CoD.Menu.UpdateButtonShownState( nil, f99_arg0, f99_arg1, f99_local3 )
		end
	end
end
CoD.Menu.RecordCurrFocusedElemID = function ( f100_arg0, f100_arg1 )
	if f100_arg1.idStack then
		table.insert( f100_arg1.idStack, 1, f100_arg0.id )
	end
	local f100_local0 = f100_arg1.controller
	if f100_local0 == nil then
		f100_local0 = f100_arg0:getOwner()
	end
	if f100_local0 == nil then
		f100_local0 = Engine[@"getprimarycontroller"]()
	end
	local f100_local1 = "childFocusLost"
	local f100_local2 = "isInFocus"
	local f100_local3 = "childFocusGained"
	local f100_local4 = "lastFocusedElemEvent"
	if f100_arg1.name == "record_inputfocus_elem_id" then
		f100_local1 = "childPCInputFocusLost"
		f100_local2 = "isInPCInputFocus"
		f100_local3 = "childPCInputFocusGained"
		f100_local4 = "lastPCInputFocusElemEvent"
	end
	local f100_local5 = f100_arg1
	local f100_local6 = 1
	local f100_local7 = nil
	local f100_local8 = f100_arg0[f100_local4]
	if f100_local8 then
		f100_local8 = function ( f101_arg0, f101_arg1, f101_arg2, f101_arg3 )
			for f101_local4, f101_local5 in ipairs( f101_arg0.idStack ) do
				if f101_arg3 == nil then
					f101_arg3 = f100_arg0
				end
				local f101_local3 = f101_arg3
				f101_arg3 = f101_arg3[f101_local5]
				if not f101_arg3 then
					return 
				elseif not f101_arg2 and (not f101_arg1 or not f101_arg1.idStack or f101_arg1.idStack[f101_local4] ~= f101_local5) then
					f101_arg2 = true
					f100_local5 = f101_arg1
					f100_local6 = f101_local4
					f100_local7 = f101_local3
				end
				if f101_arg2 then
					f101_arg3[f100_local1]( f101_arg3 )
				end
			end
			if f101_arg0.originalEvent then
				f100_local8( f101_arg0.originalEvent, f101_arg1.originalEvent or {}, f101_arg2, f101_arg3 )
			end
		end
		
		if f100_arg0[f100_local4].idStack then
			f100_local8( f100_arg0[f100_local4], f100_arg1, false, nil )
		end
	end
	if f100_local5 then
		f100_local8 = f100_local5.idStack
		if f100_local8 then
			local f100_local9 = function ( f102_arg0, f102_arg1, f102_arg2 )
				for f102_local0 = f102_arg1, #f102_arg0.idStack, 1 do
					if not f102_arg2 then
						f102_arg2 = f100_arg0
					else
						f102_arg2 = f102_arg2[f102_arg0.idStack[f102_local0]]
					end
					if not f102_arg2 or f102_arg2[f100_local2]( f102_arg2 ) then
						return 
					end
					f102_arg2[f100_local3]( f102_arg2 )
				end
				if f102_arg0.originalEvent then
					f100_local8( f102_arg0.originalEvent, 1, f102_arg2 )
				end
			end
			
			f100_local9( f100_local5, f100_local6, f100_local7 )
		end
	end
	f100_local8 = f100_arg1.leaf
	local f100_local9 = f100_arg1.disableUpdateCursorFocus
	local f100_local10 = f100_arg1
	while f100_local10 ~= nil do
		f100_local10.leaf = nil
		f100_local10.disableUpdateCursorFocus = nil
		f100_local10.menu = nil
		f100_local10 = f100_local10.originalEvent
	end
	f100_arg1 = LuaReadOnlyTables.ReadOnlyTable( LUI.DeepCopy( f100_arg1 ) )
	if f100_arg1.name == "record_inputfocus_elem_id" then
		if f100_arg1.idStack then
			f100_arg0.lastPCInputFocusElemEvent = f100_arg1
		else
			f100_arg0.lastPCInputFocusElemEvent = nil
		end
	else
		f100_arg0[f100_local4] = f100_arg1
		if CoD.isPC and f100_arg1.name == "record_curr_focused_elem_id" then
			f100_arg0.__waitingForFocusClear = false
			if not f100_local9 then
				if CoD.GetMouseFocus( f100_local0 ) and CoD.GetMouseFocus( f100_local0 ) ~= f100_local8 then
					local f100_local11 = CoD.GetMouseFocus( f100_local0 )
					f100_local11:processEvent( {
						name = "lose_focus",
						controller = f100_local0,
						fromRecordCurrFocusedElem = true
					} )
				end
				CoD.SetCurrentMouseFocus( f100_local0, f100_local8 )
			end
			if f100_arg0.__lockedFocus then
				f100_arg0:DispatchMouseCaptureLostEvent( f100_local0 )
			end
		end
	end
	if nil ~= LUI.DEV and f100_arg1.name == "record_curr_focused_elem_id" then
		local f100_local11 = ""
		if Dvar[@"ui_currfocuslist"]:exists() then
			local f100_local12 = ""
			if f100_arg0.lastFocusedElemEvent and f100_arg0.lastFocusedElemEvent.idStack then
				local f100_local13 = f100_arg0.lastFocusedElemEvent
				local f100_local14 = f100_arg0
				local f100_local15 = 2
				f100_local11 = f100_arg0.id .. "(" .. (f100_arg0.currentState or "none") .. ")"
				while f100_local13 ~= nil do
					for f100_local16 = f100_local15, #f100_local13.idStack, 1 do
						f100_local14 = f100_local14[f100_local13.idStack[f100_local16]]
						if not f100_local14 then
							f100_local12 = f100_local12 .. ".<not found>"
							f100_local11 = f100_local11 .. ".<not found>"
							break
						end
						f100_local12 = f100_local12 .. "." .. f100_local14.id
						f100_local11 = f100_local11 .. "." .. f100_local14.id .. "(" .. (f100_local14.currentState or "none") .. ")"
					end
					if not f100_local14 then
						
					end
					f100_local13 = f100_local13.originalEvent
					f100_local15 = 1
				end
			end
			Dvar[@"ui_currfocuslist"]:set( f100_local12 )
		end
		if Dvar[@"ui_currfocusstates"]:exists() then
			Dvar[@"ui_currfocusstates"]:set( f100_local11 )
		end
	end
	if f100_arg1.controller ~= nil then
		CoD.Menu.UpdateAllButtonPrompts( f100_arg0, f100_arg1.controller )
	end
	return true
end
CoD.Menu.ClearRecordedFocus = function ( f103_arg0, f103_arg1 )
	f103_arg0:RecordCurrFocusedElemID( {
		name = "record_curr_focused_elem_id",
		controller = f103_arg1.controller,
		disableUpdateCursorFocus = f103_arg1.disableUpdateCursorFocus
	} )
	return true
end
CoD.Menu.ClearRecordedInputFocus = function ( f104_arg0, f104_arg1 )
	f104_arg0:RecordCurrFocusedElemID( {
		name = "record_inputfocus_elem_id",
		controller = f104_arg1.controller
	} )
end
CoD.Menu.DelayedClearRecordedFocus = function ( f105_arg0, f105_arg1 )
	local f105_local0 = function ( f106_arg0 )
		if f106_arg0.__waitingForFocusClear then
			f106_arg0:RecordCurrFocusedElemID( {
				name = "record_curr_focused_elem_id",
				controller = f105_arg1.controller
			} )
		end
		f106_arg0.__waitingForFocusClear = false
	end
	
	if not f105_arg0.__waitingForFocusClear then
		f105_arg0.__waitingForFocusClear = true
		f105_arg0:addElement( LUI.UITimer.newElementTimer( 0, true, f105_local0, f105_arg0 ) )
	end
end
CoD.Menu.UpdatePendingElements = function ( f107_arg0, f107_arg1 )
	while f107_arg0.__elementsPendingUpdateState[1] ~= nil do
		local f107_local0 = f107_arg0.__elementsPendingUpdateState
		f107_arg0.__elementsPendingUpdateState = {}
		for f107_local4, f107_local5 in ipairs( f107_local0 ) do
			f107_arg0:updateElementState( f107_local5, f107_arg1 )
		end
	end
end
CoD.Menu.menuLoaded = function ( f108_arg0, f108_arg1 )
	f108_arg0.__loaded = true
	local f108_local0 = f108_arg0:dispatchEventToChildren( f108_arg1 )
	CoD.Menu.UpdatePendingElements( f108_arg0, f108_arg1 )
	return f108_local0
end
CoD.Menu.menuOpened = function ( f109_arg0, f109_arg1, f109_arg2, f109_arg3 )
	local f109_local0 = f109_arg0.__opened
	f109_arg0.__opened = true
	if not f109_arg0.occludedBy and not f109_arg0.ignoreCursor then
		CoD.FreeCursorUtility.RetriggerCursorPosition( f109_arg0, f109_arg0:getOwner() )
		DataSources.FreeCursor.registerButtonPrompts( f109_arg0:getOwner(), f109_arg0.buttonModel )
	end
	if not f109_arg0.pcNavigationHandlerRegistered and not f109_arg0.disableKeyboardNavigation then
		CoD.Menu.AddPCNavigationHandler( f109_arg0, f109_arg0:getOwner() )
		f109_arg0.pcNavigationHandlerRegistered = true
		if not f109_arg3 and CoD.isPC then
			CoD.FreeCursorUtility.ForceCloseDetailedView( f109_arg0, f109_arg1 )
		end
	end
	if not f109_local0 and f109_arg0.__defaultFocus then
		if IsGamepad( f109_arg1 ) then
			if not f109_arg0.__defaultFocusTimer then
				f109_arg0.__defaultFocusTimer = LUI.UITimer.newElementTimer( 0, true, function ()
					f109_arg0.__defaultFocusTimer = nil
					if not f109_arg0:restoreState( f109_arg1 ) and f109_arg0:getParent() then
						f109_arg0.__defaultFocus:processEvent( {
							name = "gain_focus",
							controller = f109_arg1,
							menu = f109_arg0,
							moveCursor = true
						} )
					end
				end )
				f109_arg0:addElement( f109_arg0.__defaultFocusTimer )
				goto basicblock_16:
			end
		elseif CoD.isPC then
			f109_arg0:DelayedCheckDefaultFocusImpl( f109_arg0.__defaultFocus, f109_arg1, false, 0 )
			while #f109_arg0.__openMenuCallbacks > 0 do
				local f109_local1 = f109_arg0.__openMenuCallbacks
				f109_arg0.__openMenuCallbacks = {}
				while #f109_local1 > 0 do
					local f109_local2 = f109_local1[1]
					f109_local2( f109_arg0, f109_arg1, f109_arg2, f109_arg3 )
					if f109_local1[1] == f109_local2 then
						table.remove( f109_local1, 1 )
					end
				end
			end
		end
	end
end
CoD.Menu.addMenuOpenedCallback = function ( f111_arg0, f111_arg1 )
	table.insert( f111_arg0.__openMenuCallbacks, f111_arg1 )
end
CoD.Menu.removeMenuOpenedCallback = function ( f112_arg0, f112_arg1 )
	for f112_local3, f112_local4 in ipairs( f112_arg0.__openMenuCallbacks ) do
		if f112_local4 == f112_arg1 then
			table.remove( f112_arg0.__openMenuCallbacks, f112_local3 )
			break
		end
	end
end
CoD.Menu.CheckDefaultFocus = function ( f113_arg0, f113_arg1 )
	f113_arg0:DelayedCheckDefaultFocusImpl( f113_arg0, f113_arg1, false, 0 )
end
function FindDefaultFocusable( f114_arg0 )
	if not f114_arg0:allowsCursorMove() then
		return nil
	end
	local f114_local0 = nil
	local f114_local1 = f114_arg0:getFirstChild()
	if f114_local1 == nil then
		return nil
	end
	while f114_local1 ~= nil do
		if f114_local1.__defaultFocus then
			return f114_local1.__defaultFocus
		end
		f114_local1 = f114_local1:getNextSibling()
	end
	f114_local1 = f114_arg0:getFirstChild()
	while f114_local1 ~= nil do
		f114_local0 = FindDefaultFocusable( f114_local1 )
		if f114_local0 ~= nil then
			return f114_local0
		end
		f114_local1 = f114_local1:getNextSibling()
	end
	return nil
end
CoD.Menu.DelayedCheckDefaultFocusImpl = function ( f115_arg0, f115_arg1, f115_arg2, f115_arg3, f115_arg4 )
	local f115_local0 = function ()
		if f115_arg0.__waitingForDefaultFocus then
			f115_arg0:CheckDefaultFocusInternal( f115_arg1, f115_arg2, f115_arg3 )
		end
		f115_arg0.__waitingForDefaultFocus = false
		f115_arg0:removeElement( f115_arg0.__focusTimerElement )
		f115_arg0.__focusTimerElement = nil
	end
	
	if not f115_arg0.__waitingForDefaultFocus or f115_arg3 and f115_arg4 > 0 then
		f115_arg0.__waitingForDefaultFocus = true
		if f115_arg0.__focusTimerElement then
			f115_arg0.__focusTimerElement:close()
			f115_arg0.__focusTimerElement = nil
		end
		f115_arg0.__focusTimerElement = LUI.UITimer.newElementTimer( f115_arg4, true, f115_local0 )
		f115_arg0:addElement( f115_arg0.__focusTimerElement )
	end
end
CoD.Menu.CheckDefaultFocusInternal = function ( f117_arg0, f117_arg1, f117_arg2, f117_arg3 )
	if not f117_arg1:isVisible() or IsGamepad( f117_arg2 ) or not IsUsingKeyboardNavigation( f117_arg2 ) then
		return 
	elseif f117_arg1:allowsCursorMove() and f117_arg1:isFocusable() then
		f117_arg0:ChangeFocusedElement( f117_arg2, f117_arg1, true )
		return 
	elseif f117_arg0.occludedBy then
		return 
	end
	local f117_local0 = f117_arg1.getDefaultFocus or f117_arg1.__defaultFocus
	if not f117_arg3 and CoD.GetMouseFocus( f117_arg2 ) ~= nil and CoD.Menu.IsAncestorOf( f117_arg1, CoD.GetMouseFocus( f117_arg2 ) ) then
		return 
	elseif f117_local0 and type( f117_local0 ) == "function" then
		f117_local0 = f117_local0()
	end
	if f117_local0 and not f117_local0:allowsCursorMove() then
		return nil
	elseif not f117_local0 then
		f117_local0 = FindDefaultFocusable( f117_arg1 )
		if f117_local0 and type( f117_local0 ) == "function" then
			f117_local0 = f117_local0()
		end
		if not f117_local0 then
			f117_local0 = CoD.BaseUtility.FindSingleFocusableDescendant( f117_arg1, true )
			if f117_local0 then
				f117_arg0:ChangeFocusedElement( f117_arg2, f117_local0, true )
			end
			return 
		end
	end
	assert( f117_local0 ~= nil )
	f117_arg0:CheckDefaultFocusInternal( f117_local0, f117_arg2, f117_arg3 )
end
CoD.Menu.subscribeToCurrAnimationModel = function ( f118_arg0 )
	f118_arg0:subscribeToModel( Engine[@"createmodel"]( f118_arg0:getModel(), "current_animation" ), function ( model )
		local f119_local0 = Engine[@"getmodelvalue"]( model )
		if f119_local0 then
			if f119_local0 == "" and f118_arg0.lastAnimPlayed then
				f119_local0 = f118_arg0.lastAnimPlayed
			elseif f119_local0 ~= "" then
				f118_arg0.lastAnimPlayed = f119_local0
			end
			f118_arg0:playClip( f119_local0 )
		end
	end )
end
CoD.Menu.subscribeToCloseMenuModel = function ( f120_arg0 )
	local f120_local0 = Engine[@"getprimarycontroller"]()
	local f120_local1 = f120_arg0:getModel( f120_local0, "close_current_menu" )
	if f120_local1 then
		f120_arg0:subscribeToModel( f120_local1, function ( model )
			local f121_local0 = Engine[@"getmodelvalue"]( model )
			if f121_local0 and f121_local0 == 1 then
				if CoD.isPC and f120_arg0.menuName == "BountyHunterBuy" then
					CoD.ChatClientUtility.SetIsInBountyHunterMenu( false )
					CoD.PCUtility.MigrateStickyElementsBackwardFromStack( f120_arg0, f120_local0 )
					local f121_local1 = CoD.ChatClientUtility.GetCurrentChattingModel( f120_local0 )
					f121_local1:set( false )
				end
				f120_arg0:close()
			end
		end )
	end
end
CoD.Menu.subscribeToStateModel = function ( f122_arg0, f122_arg1 )
	local f122_local0 = f122_arg0:getModel()
	f122_local0 = f122_local0._state
	if f122_local0 and f122_arg0.__stateMap then
		f122_arg0:subscribeToModel( f122_local0, function ( model )
			local f123_local0 = (Engine[@"getmodelvalue"]( model ) or 0) + 1
			if f122_arg0.__stateMap[f123_local0] then
				f122_arg0:setState( f122_arg1, f122_arg0.__stateMap[f123_local0] )
			end
		end, true )
	end
end
local f0_local0 = function ( f124_arg0, f124_arg1 )
	return f124_arg0 == f124_arg1.id
end
CoD.Menu.AppendPrecreatedIdStack = function ( f125_arg0, f125_arg1 )
	local f125_local0 = f125_arg0[f125_arg1.id]
	repeat
		f125_local0 = f125_local0:getNextFocusableSibling()
		if not f125_local0 then
			table.insert( f125_arg0.__focusableElementPaths, 1, f125_arg1 )
		else
			local f125_local1 = LuaUtils.FindItemInArray( f125_arg0.__focusableElementPaths, f125_local0.id, f0_local0 )
		end
	until f125_local1
	table.insert( f125_arg0.__focusableElementPaths, f125_local1 + 1, f125_arg1 )
end
CoD.Menu.RegisterFocusableElement = function ( f126_arg0, f126_arg1 )
	local f126_local0 = f126_arg0.__focusableElementPaths
	local f126_local1 = f126_arg1.idStack
	local f126_local2 = f126_arg0
	for f126_local9, f126_local10 in ipairs( f126_local1 ) do
		local f126_local11 = LuaUtils.FindItemInArray( f126_local0, f126_local10, f0_local0 )
		if f126_local11 then
			f126_local0 = f126_local0[f126_local11].focusableElementPaths
			if f126_local2 then
				f126_local2 = f126_local2[f126_local10]
			end
		end
		local f126_local6 = {
			id = f126_local10,
			focusableElementPaths = {}
		}
		if f126_local2 then
			if not f126_local2[f126_local10] then
				table.insert( f126_local0, 1, f126_local6 )
			else
				local f126_local7 = f126_local2[f126_local10]
				repeat
					f126_local7 = f126_local7:getNextFocusableSibling()
					if not f126_local7 then
						table.insert( f126_local0, 1, f126_local6 )
					end
					local f126_local8 = LuaUtils.FindItemInArray( f126_local0, f126_local7.id, f0_local0 )
				until f126_local8
				table.insert( f126_local0, f126_local8 + 1, f126_local6 )
			end
			f126_local0 = f126_local6.focusableElementPaths
			f126_local2 = f126_local2[f126_local10]
		end
		table.insert( f126_local0, f126_local6 )
		f126_local0 = f126_local6.focusableElementPaths
	end
end
CoD.Menu.UnregisterFocusableElement = function ( f127_arg0, f127_arg1 )
	local f127_local0 = f127_arg0.__focusableElementPaths
	local f127_local1 = f127_arg1.idStack
	for f127_local5, f127_local6 in ipairs( f127_local1 ) do
		local f127_local7 = LuaUtils.FindItemInArray( f127_local0, f127_local6, f0_local0 )
		if f127_local7 then
			if f127_local5 < #f127_local1 then
				f127_local0 = f127_local0[f127_local7]
			end
			if #f127_local0[f127_local7].focusableElementPaths == 0 then
				table.remove( f127_local0, f127_local7 )
			end
		end
	end
end
CoD.Menu.IntersectElementRect = function ( f128_arg0, f128_arg1, f128_arg2 )
	local f128_local0, f128_local1, f128_local2, f128_local3 = Engine[@"hash_3695399A0E06EC35"]( f128_arg2, f128_arg0 )
	local f128_local4 = math.max( f128_local0, f128_arg1.left )
	local f128_local5 = math.min( f128_local2, f128_arg1.right )
	if f128_local5 <= f128_local4 then
		return nil
	else
		local f128_local6 = math.max( f128_local1, f128_arg1.top )
		local f128_local7 = math.min( f128_local3, f128_arg1.bottom )
		if f128_local7 <= f128_local6 then
			return nil
		else
			return {
				left = f128_local4,
				top = f128_local6,
				right = f128_local5,
				bottom = f128_local7
			}
		end
	end
end
CoD.Menu.sendInitializationEvents = function ( f129_arg0, f129_arg1, f129_arg2 )
	if f129_arg0.__loaded then
		local f129_local0 = {
			name = "menu_loaded",
			controller = f129_arg1,
			menu = f129_arg0
		}
		f129_arg2:processEvent( f129_local0 )
		CoD.Menu.UpdatePendingElements( f129_arg0, f129_local0 )
	end
	if f129_arg0.__opened then
		f129_arg0:menuOpened( f129_arg1, f129_arg0 )
	end
end
CoD.Menu.getSaveStateTable = function ( f130_arg0, f130_arg1 )
	local f130_local0 = nil
	if f130_arg0.lastFocusedElemEvent and f130_arg0.lastFocusedElemEvent.id then
		if not f130_local0 then
			f130_local0 = {}
		end
		f130_local0.id = f130_arg0.lastFocusedElemEvent.id
		f130_local0.saveEvent = f130_arg0.lastFocusedElemEvent
	end
	if f130_arg1 and CursorInputEnabledForBuild( f130_arg1 ) and not f130_arg0.ignoreCursor then
		if not f130_local0 then
			f130_local0 = {}
		end
		local f130_local1 = DataSources.FreeCursor.getModel( f130_arg1 )
		f130_local0.x, f130_local0.y = f130_local1.position:get()
	end
	return f130_local0
end
CoD.Menu.saveState = function ( f131_arg0, f131_arg1 )
	LUI.savedMenuStates[f131_arg0.id] = f131_arg0:getSaveStateTable( f131_arg1 )
end
CoD.Menu.restoreState = function ( f132_arg0, f132_arg1 )
	if Engine[@"getdvarbool"]( "rat_playback_enabled" ) then
		return 
	elseif CoD.isPC and f132_arg1 == nil then
		local f132_local0 = f132_arg0:getMenu()
		f132_arg1 = f132_local0:getOwner()
	end
	local f132_local0 = LUI.savedMenuStates[f132_arg0.id]
	if f132_local0 then
		if f132_local0.x and not f132_arg0.ignoreCursor and IsGamepad( f132_arg1 ) and IsFreeCursorActiveAndVisible( f132_arg1 ) then
			Engine[@"hash_6300AA5B40C6FE50"]( f132_arg1, f132_local0.x, f132_local0.y )
			return true
		elseif f132_local0.id then
			return f132_arg0:processEvent( {
				name = "restore_focus",
				id = f132_local0.id,
				data = f132_local0.data,
				saveEvent = f132_local0.saveEvent,
				controller = f132_arg1
			} )
		end
	end
end
CoD.Menu.clearSavedState = function ( f133_arg0 )
	if not f133_arg0:isIDNamed() then
		error( "LUI Error: Tried to save menu state, but element has no name: " .. f133_arg0:getFullID() )
		return 
	else
		LUI.savedMenuStates[f133_arg0.id] = nil
	end
end
CoD.Menu:registerEventHandler( "debug_reload", CoD.Menu.DebugReload )
CoD.Menu:registerEventHandler( "occlusion_change", CoD.Menu.OcclusionChange )
CoD.Menu:registerEventHandler( "open_menu", CoD.Menu.OpenMenu )
CoD.Menu:registerEventHandler( "gamepad_button", CoD.Menu.GamepadButton )
CoD.Menu:registerEventHandler( "menu_changed", CoD.Menu.MenuChanged )
CoD.Menu:registerEventHandler( "signed_out", CoD.Menu.UserSignedOut )
CoD.Menu:registerEventHandler( "close_all_popups", CoD.Menu.MenuChanged )
CoD.Menu:registerEventHandler( "open_refetch_wad_confirmation_popup", CoD.Menu.OpenRefetchWADConfirmationPopup )
CoD.Menu:registerEventHandler( "open_texture_pack_confirmation_popup", CoD.Menu.OpenTexturePackConfirmationPopup )
CoD.Menu:registerEventHandler( "open_keyboard_text_field_popup", CoD.Menu.OpenKeyboardTextFieldPopup )
CoD.Menu:registerEventHandler( "open_popup", CoD.Menu.OpenPopupEventHandler )
CoD.Menu:registerEventHandler( "open_overlay", CoD.Menu.OpenOverlay )
CoD.Menu:registerEventHandler( "open_friend_popup", CoD.Menu.OpenPlayercard )
CoD.Menu:registerEventHandler( "set_action_prompt_string", CoD.Menu.SetActionPromptString )
CoD.Menu:registerEventHandler( "resolution_changed", CoD.Menu.ResolutionChanged )
CoD.Menu:registerEventHandler( "rat_get_menu_info_internal", CoD.Menu.RatGetMenuInfo )
CoD.Menu:registerEventHandler( "rat_find_list_item_internal", CoD.Menu.RatFindListItem )
CoD.Menu:registerEventHandler( "record_curr_focused_elem_id", CoD.Menu.RecordCurrFocusedElemID )
CoD.Menu:registerEventHandler( "record_inputfocus_elem_id", CoD.Menu.RecordCurrFocusedElemID )
CoD.Menu:registerEventHandler( "clear_recorded_focus", CoD.Menu.ClearRecordedFocus )
CoD.Menu:registerEventHandler( "clear_recorded_inputfocus", CoD.Menu.ClearRecordedInputFocus )
CoD.Menu:registerEventHandler( "delayed_clear_recorded_focus", CoD.Menu.DelayedClearRecordedFocus )
CoD.Menu:registerEventHandler( "menu_loaded", CoD.Menu.menuLoaded )
CoD.Menu:registerEventHandler( "register_focusable_element", CoD.Menu.RegisterFocusableElement )
CoD.Menu:registerEventHandler( "unregister_focusable_element", CoD.Menu.UnregisterFocusableElement )
CoD.InGameMenu.CloseAllInGameMenus = function ( f134_arg0, f134_arg1 )
	if Engine[@"canpausegame"]() and not Engine[@"isdemoplaying"]() then
		if CoD.InGameMenu.m_unpauseDisabled == nil then
			CoD.InGameMenu.m_unpauseDisabled = {}
		end
		CoD.InGameMenu.m_unpauseDisabled[f134_arg1.controller + 1] = 0
	end
	f134_arg0:dispatchEventToChildren( f134_arg1 )
	if not f134_arg0.m_inputDisabled then
		f134_arg0.previousMenuName = nil
		f134_arg0:goBack()
		if f134_arg0.occludedMenu then
			f134_arg0.occludedMenu:processEvent( f134_arg1 )
		end
	end
end
CoD.InGameMenu:registerEventHandler( "close_all_ingame_menus", CoD.InGameMenu.CloseAllInGameMenus )
