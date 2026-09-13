/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\nvg.gsc
***********************************************/

runnvg() {
  _id_3B64EB40368C1450::nuke("nvg");

  if(!scripts\mp\flags::gameflag("prematch_done") && isDefined(self.infil)) {
    _id_3B64EB40368C1450::set("runNVG", "nvg", 0);
    thread allownvgsatmatchstart();
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("runNVG");

  if(!isDefined(self.pers["useNVG"]))
    self.pers["useNVG"] = 0;

  if(!isDefined(self.pers["killstreak_forcedNVGOff"]))
    self.pers["killstreak_forcedNVGOff"] = 0;

  thread _id_CA7EB80548414E31();
  thread _id_389F3670051FB40D();
  thread nvg_monitor();
}

allownvgsatmatchstart() {
  self notify("allowNVGsAtMatchStart");
  self endon("allowNVGsAtMatchStart");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("runNVG");
}

clearnvg(_id_D82B5FC6A04B17F3) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    if(_id_D82B5FC6A04B17F3)
      self detach(self.nvg3rdpersonmodel, "j_head");

    self.nvg3rdpersonmodel = undefined;
  }
}

savenvgstate() {
  if(self isnightvisionon())
    self.pers["useNVG"] = 1;
  else if(!self isnightvisionon() && !istrue(self.pers["killstreak_forcedNVGOff"]))
    self.pers["useNVG"] = 0;
}

nvg_monitor() {
  self notify("nvg_monitor");
  self endon("nvg_monitor");
  self endon("disconnect");
  _id_941CDE8837521CFF = gettime();

  for(;;) {
    result = scripts\engine\utility::waittill_any_return_3("night_vision_on", "night_vision_off", "death");

    if(!isDefined(result)) {
      continue;
    }
    if(result == "death") {
      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "dmz") {
        self nightvisionviewoff(1);
        _id_4CA8E54D359CF04A(0);
      }

      break;
    }

    enabled = result == "night_vision_on";
    _id_4CA8E54D359CF04A(enabled);
  }
}

_id_4CA8E54D359CF04A(_id_E60552DD6ABCC4AA) {
  savenvgstate();
  nvg_update3rdperson(_id_E60552DD6ABCC4AA);

  if(istrue(_id_E60552DD6ABCC4AA))
    level notify("player_enabled_nvgs");

  _id_57A8AA1600B3E550(_id_E60552DD6ABCC4AA);
  _id_2A3902259F88E70E = gettime();
  duration = _id_2A3902259F88E70E - scripts\engine\utility::ter_op(isDefined(self._id_B6C830F1879E400F), self._id_941CDE8837521CFF, 0);
  scripts\mp\analyticslog::logevent_nvgtoggled(gettime(), self.lifeid, self.origin, _id_E60552DD6ABCC4AA, duration, "none");
  self._id_941CDE8837521CFF = _id_2A3902259F88E70E;
}

_id_CA7EB80548414E31() {
  level endon("game_ended");
  self notify("nvg_monitorBlocking");
  self endon("nvg_monitorBlocking");
  thread _id_B229E871FDDF36D0();
  self endon("disconnect");

  for(;;) {
    self waittill("pickup_object");
    childthread _id_DFFE59707D84C40F();

    if(scripts\engine\utility::is_player_gamepad_enabled())
      _id_B8159504F369A68D(0);

    scripts\engine\utility::waittill_any_5("manual_drop", "force_manual_drop", "manual_drop_cleanup", "bomb_planted", "death");

    if(scripts\engine\utility::is_player_gamepad_enabled())
      _id_B8159504F369A68D(1);
  }
}

_id_B229E871FDDF36D0() {
  self endon("nvg_monitorBlocking");
  self endon("disconnect");
  level waittill("start_game_ended");

  if(isDefined(self))
    _id_B8159504F369A68D(0);
}

_id_57A8AA1600B3E550(_id_E60552DD6ABCC4AA) {
  _id_6DDD66EE8722807B = scripts\engine\utility::ter_op(istrue(_id_E60552DD6ABCC4AA), "on", "off");
  self setscriptablepartstate("3PLight", _id_6DDD66EE8722807B, 0);
}

_id_389F3670051FB40D() {
  level endon("game_ended");
  self notify("nvg_monitor3PLight");
  self endon("nvg_monitor3PLight");
  self endon("disconnect");
  self endon("death");

  for(;;) {
    childthread _id_D8E93127577A3812("grenade_pullback");
    childthread _id_D8E93127577A3812("weapon_switch");
    childthread _id_D8E93127577A3812("offhand_end");
    self waittill("nvg_checkWeapon", _id_DD515FCF025B2E79);

    if(!isDefined(_id_DD515FCF025B2E79) || !_id_ADD04ED347410264(_id_DD515FCF025B2E79))
      _id_18D34F9BB2010A02(1);
    else
      _id_18D34F9BB2010A02(0);

    if(istrue(self.pers["useNVG"]))
      _id_57A8AA1600B3E550(_id_7B70C15687FD673C());
  }
}

_id_D8E93127577A3812(_id_4B9AB96C345311A6) {
  self endon("nvg_checkWeapon");
  self waittill(_id_4B9AB96C345311A6, weapon);
  self notify("nvg_checkWeapon", weapon);
}

_id_7B70C15687FD673C() {
  _id_A8DF187EF07439E1 = istrue(self._id_A81B0BEBE46E1039);
  return _id_A8DF187EF07439E1;
}

_id_18D34F9BB2010A02(_id_A8DF187EF07439E1) {
  if(_id_A8DF187EF07439E1)
    self._id_A81B0BEBE46E1039 = 1;
  else
    self._id_A81B0BEBE46E1039 = undefined;
}

_id_ADD04ED347410264(weapon) {
  if(!isDefined(weapon.basename))
    return 0;

  switch (weapon.basename) {
    case "hb_sensor_mp":
    case "ks_remote_map_mp":
    case "super_remote_device_mp":
    case "ks_remote_device_mp":
    case "super_remote_map_mp":
    case "iw9_me_riotshield_mp":
      return 1;
    default:
      return 0;
  }
}

_id_DFFE59707D84C40F() {
  self endon("manual_drop");
  self endon("force_manual_drop");
  self notify("nvg_monitoringGamePad");
  self endon("nvg_monitoringGamePad");

  for(;;) {
    self waittill("input_type_changed");
    _id_B8159504F369A68D(!scripts\engine\utility::is_player_gamepad_enabled());
  }
}

_id_B8159504F369A68D(_id_BD138DE99B3B3507) {
  if(_id_BD138DE99B3B3507)
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("blockNVGs");
  else
    _id_3B64EB40368C1450::set("blockNVGs", "nvg", 0);
}

nvg_get3rdpersonupmodel() {
  _id_2626C56CE4ECC11B = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head]))
    _id_2626C56CE4ECC11B = level.nvgheadoverrides[self.operatorcustomization.head]["up"];

  _id_3474B4E818850C46 = getDvar("dvar_59FBD1482230B72F");

  if(isDefined(_id_3474B4E818850C46) && _id_3474B4E818850C46 != "")
    _id_2626C56CE4ECC11B = _id_3474B4E818850C46;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_2626C56CE4ECC11B = undefined;
  else if(!isDefined(_id_2626C56CE4ECC11B))
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_1_up";
  else if(_id_2626C56CE4ECC11B == "nvg_2")
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_2_up";
  else if(_id_2626C56CE4ECC11B == "nvg_3")
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_3_up";
  else if(_id_2626C56CE4ECC11B == "nvg_4")
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_3_up";
  else if(_id_2626C56CE4ECC11B == "none")
    _id_2626C56CE4ECC11B = undefined;
  else
    _id_2626C56CE4ECC11B = "offhand_wm_nvgquad_mp_1_up";

  return _id_2626C56CE4ECC11B;
}

nvg_get3rdpersondownmodel() {
  _id_4E05BAF0BB66C66E = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head]))
    _id_4E05BAF0BB66C66E = level.nvgheadoverrides[self.operatorcustomization.head]["down"];

  _id_3474B4E818850C46 = getDvar("dvar_59FBD1482230B72F");

  if(isDefined(_id_3474B4E818850C46) && _id_3474B4E818850C46 != "")
    _id_4E05BAF0BB66C66E = _id_3474B4E818850C46;

  if(!isDefined(_id_4E05BAF0BB66C66E))
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_1";
  else if(_id_4E05BAF0BB66C66E == "nvg_2")
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_2";
  else if(_id_4E05BAF0BB66C66E == "nvg_3")
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_3";
  else if(_id_4E05BAF0BB66C66E == "nvg_4")
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_4";
  else if(_id_4E05BAF0BB66C66E == "none")
    _id_4E05BAF0BB66C66E = undefined;
  else
    _id_4E05BAF0BB66C66E = "offhand_wm_nvgquad_mp_1";

  return _id_4E05BAF0BB66C66E;
}

nvg_update3rdperson(enabled) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    self detach(self.nvg3rdpersonmodel, "j_head");
    self.nvg3rdpersonmodel = undefined;
  }

  if(getdvarint("dvar_0E3E35EC6CD674CA", 0) == 1) {
    return;
  }
  if(enabled) {
    _id_4E05BAF0BB66C66E = nvg_get3rdpersondownmodel();

    if(isDefined(_id_4E05BAF0BB66C66E)) {
      self.nvg3rdpersonmodel = _id_4E05BAF0BB66C66E;
      self attach(self.nvg3rdpersonmodel, "j_head");
      return;
    }
  } else {
    _id_2626C56CE4ECC11B = nvg_get3rdpersonupmodel();

    if(isDefined(_id_2626C56CE4ECC11B)) {
      self.nvg3rdpersonmodel = _id_2626C56CE4ECC11B;
      self attach(self.nvg3rdpersonmodel, "j_head");
    }
  }
}

_id_258C5E445C8B7F80() {
  return scripts\cp_mp\utility\game_utility::_id_D2D2B803A7B741A4() && !_id_2D9D24F7C63AC143::_id_8B121DD10A442DD2() && !istrue(self.gulag);
}