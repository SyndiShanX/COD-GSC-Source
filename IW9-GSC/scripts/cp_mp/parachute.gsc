/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\parachute.gsc
***********************************************/

initparachutedvars() {
  setdvarifuninitialized("scr_parachute_redeploy_min_height", 256);
  setdvarifuninitialized("scr_parachute_redeploy_input_type", 0);
  setdvarifuninitialized("scr_parachute_auto_kick_map_center", (0, 0, 0));
  setdvarifuninitialized("scr_parachute_camera_transition_mode", 2);
  setdvarifuninitialized("scr_parachute_ffsm_enabled", 1);
  setdvarifuninitialized("scr_parachute_hint_enabled", 1);
  setdvarifuninitialized("scr_parachute_hint_zdrop", 0.5);
  setdvarifuninitialized("scr_parachute_hint_zoffset", 0.0);
  setdvarifuninitialized("scr_parachute_hint_zvelscale", 0.0);
  setdvarifuninitialized("scr_parachute_hint_zlimit", 5000.0);
  setdvarifuninitialized("scr_parachute_hint_xyvelscale_high", 10.0);
  setdvarifuninitialized("scr_parachute_hint_xyvelscale_low", 2.0);
  setdvarifuninitialized("scr_parachute_hint_xyvelscale_maxheight", 10000.0);
  setdvarifuninitialized("scr_parachute_hint_xylimit", 7500.0);
  setdvarifuninitialized("scr_parachute_hint_falling_xyratio", -2.0);
  level.parachutecancutautodeploy = getdvarint("dvar_FF604C5295C4E36C", 1);
  level.parachutecancutparachute = getdvarint("dvar_5F25FD4C8FC1A759", 1);
  level.parachuteinitfinished = 1;
  level.activeparachuters = [];

  if(!isDefined(level.dontshootwhileparachuting))
    level.dontshootwhileparachuting = 1;

  if(!isDefined(level.freefallstartcb))
    level.freefallstartcb = ::freefallstartdefault;

  if(!isDefined(level.parachuteopencb))
    level.parachuteopencb = ::parachuteopendefault;

  if(!isDefined(level.parachutecompletecb))
    level.parachutecompletecb = ::parachutecompletedefault;

  if(!isDefined(level.parachutetakeweaponscb))
    level.parachutetakeweaponscb = ::leaveweaponsdefaultfunc;

  if(!isDefined(level.parachuterestoreweaponscb))
    level.parachuterestoreweaponscb = ::norestoreweaponsdefaultfunc;

  if(!isDefined(level.parachuteprelaststandfunc))
    level.parachuteprelaststandfunc = ::parachuteprelaststandfunction;

  level.skydivestreamhintdvars = spawnStruct();
  level.skydivestreamhintdvars.streamhintenabled = getdvarint("scr_parachute_hint_enabled", 1);
  level.skydivestreamhintdvars.xyvelscale_high = getdvarfloat("scr_parachute_hint_xyvelscale_high", 0.0);
  level.skydivestreamhintdvars.xyvelscale_low = getdvarfloat("scr_parachute_hint_xyvelscale_low", 0.0);
  level.skydivestreamhintdvars.xyvelscale_maxheight = getdvarfloat("scr_parachute_hint_xyvelscale_maxheight", 0.0);
  level.skydivestreamhintdvars.xylimit = getdvarfloat("scr_parachute_hint_xylimit", 0.0);
  level.skydivestreamhintdvars.zdrop = getdvarfloat("scr_parachute_hint_zdrop", 0.0);
  level.skydivestreamhintdvars.zoffset = getdvarfloat("scr_parachute_hint_zoffset", 0.0);
  level.skydivestreamhintdvars.zvelscale = getdvarfloat("scr_parachute_hint_zvelscale", 0.0);
  level.skydivestreamhintdvars.zlimit = getdvarfloat("scr_parachute_hint_zlimit", 0.0);
  level.skydivestreamhintdvars.falling_xyratio = getdvarfloat("scr_parachute_hint_falling_xyratio", 0.0);
}

startfreefall(_id_BDA1DE83E1856735, _id_EB0C093D4B21E9DD, _id_32DCB143B4EB723A, _id_928936FD7C1BFF02, _id_F9EB100D9C645F51, _id_C017D2557D7B9C53) {
  self._id_6A984A8887A1A08B = 0;

  if(getdvarint("scr_parachute_ffsm_enabled", 0)) {
    thread freefallfromplanestatemachine(_id_BDA1DE83E1856735, _id_EB0C093D4B21E9DD, _id_32DCB143B4EB723A, _id_928936FD7C1BFF02, _id_F9EB100D9C645F51, _id_C017D2557D7B9C53);
    return;
  }

  self endon("death_or_disconnect");
  thread parachutemidairdeathwatcher();
  self skydive_interrupt();

  if(!isDefined(_id_C017D2557D7B9C53))
    _id_C017D2557D7B9C53 = 1;

  if(!istrue(level.parachuteinitfinished))
    initparachutedvars();

  if(!isDefined(level.dontshootwhileparachuting))
    level.dontshootwhileparachuting = 1;

  if(!isDefined(level.freefallstartcb))
    level.freefallstartcb = ::freefallstartdefault;

  if(!isDefined(level.parachuteopencb))
    level.parachuteopencb = ::parachuteopendefault;

  if(!isDefined(level.parachutecompletecb))
    level.parachutecompletecb = ::parachutecompletedefault;

  if(!isDefined(level.parachutetakeweaponscb))
    level.parachutetakeweaponscb = ::leaveweaponsdefaultfunc;

  if(!isDefined(level.parachuterestoreweaponscb))
    level.parachuterestoreweaponscb = ::norestoreweaponsdefaultfunc;

  if(!isDefined(_id_BDA1DE83E1856735))
    _id_BDA1DE83E1856735 = 4.0;

  if(_id_C017D2557D7B9C53)
    self[[level.parachutetakeweaponscb]]();

  self[[level.freefallstartcb]]();

  if(isparachutegametype())
    self setclientomnvar("ui_br_altimeter_state", 1);

  if(!isDefined(_id_32DCB143B4EB723A))
    self notifyonplayercommand("open_parachute", "+gostand");

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(_id_928936FD7C1BFF02))
    self setvelocity(_id_928936FD7C1BFF02);

  self skydive_beginfreefall();

  if(getdvarint("scr_parachute_camera_transition_mode", 1) != 2)
    self skydive_setforcethirdpersonstatus(1);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (!istrue(_id_F9EB100D9C645F51) || (getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk" || getDvar("dvar_7611A2790A0BF7FE", "") == "resurgence")) && getdvarint("dvar_B99E3B3C6154CED8", 1))
    thread infilparachutevfx(getdvarint("dvar_96E4167DD77B8CEE", 1) == 1 && (getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk" || getDvar("dvar_7611A2790A0BF7FE", "") == "resurgence"));

  if(!istrue(_id_EB0C093D4B21E9DD))
    wait(_id_BDA1DE83E1856735);

  thread pullchute(_id_32DCB143B4EB723A, _id_EB0C093D4B21E9DD);
}

infilparachutevfx(_id_4E5940A26EB12680) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player = self;
  wait 1.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "ftue_triggerTip"))
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "ftue_triggerTip")]]("br_ftue_parachute");

  _id_9E50CEF01527FF79 = "enabled";

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.brinfilsmokesuffix))
    _id_9E50CEF01527FF79 = _id_9E50CEF01527FF79 + self.operatorcustomization.brinfilsmokesuffix;

  player setscriptablepartstate("skydiveVfx", _id_9E50CEF01527FF79, 0);
  player setisinfilskydive(1);
  wait 2.0;

  while(isalive(player) && !player shoulddisableskydivevfx())
    wait 0.25;

  if(_id_4E5940A26EB12680) {
    while(isalive(player)) {
      _id_AA4F5EA34DFE428B = istrue(player.inlaststand);
      _id_31C5DAC60B438208 = player isonground() || player _meth_E40102956C887F7C() || player _meth_415FE9EECA7B2E2B();
      _id_A2B5F51A86D266AD = player isonladder();
      _id_B48E997E59346E83 = !scripts\cp_mp\utility\player_utility::isreallyalive(player);
      binvehicle = player _meth_793F941D7DFF15ED();
      _id_15D3F6CDD6F19D4D = player _meth_9CC921A57FF4DEB5();

      if(_id_AA4F5EA34DFE428B || _id_31C5DAC60B438208 || _id_A2B5F51A86D266AD || _id_B48E997E59346E83 || binvehicle || _id_15D3F6CDD6F19D4D) {
        break;
      }

      wait 0.25;
    }
  }

  player setscriptablepartstate("skydiveVfx", "default", 0);
  player setisinfilskydive(0);
}

riotshield_attach_parachute(_id_F8EE3E194415C066, _id_A6EF975DA2DDFF4B) {
  _id_8F79D15EFB6089C2 = undefined;

  if(_id_F8EE3E194415C066) {
    self.riotshieldmodel = _id_A6EF975DA2DDFF4B;
    _id_8F79D15EFB6089C2 = "tag_weapon_right";
  } else {
    self.riotshieldmodelstowed = _id_A6EF975DA2DDFF4B;
    _id_8F79D15EFB6089C2 = "tag_shield_back";
  }

  self attachshieldmodel(_id_A6EF975DA2DDFF4B, _id_8F79D15EFB6089C2);
  self.hasriotshield = riotshield_hasweapon_parachute();
}

riotshield_getmodel_parachute() {
  return "weapon_wm_riotshield";
}

riotshield_hasweapon_parachute() {
  result = 0;
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    if(isriotshield_parachute(weapon)) {
      result = 1;
      break;
    }
  }

  return result;
}

isriotshield_parachute(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon))
    return 0;

  if(isstring(weapon) && weapon == "none")
    return 0;

  return weapontype(weapon) == "riotshield";
}

isparachutegametype() {
  return isDefined(level.gametype) && (scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || level.gametype == "arm" || level.gametype == "bigctf" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "war" || level.gametype == "missions" || level.gametype == "trial" || level.gametype == "brtdm" || level.gametype == "brtdm_mgl");
}

getc130height() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_heightoverride))
    return level.br_level.c130_heightoverride;

  return 24000;
}

getc130airdropheight() {
  if(isDefined(level.c130airdrop_heightoverride))
    return level.c130airdrop_heightoverride;

  return 24000;
}

getc130sealevel() {
  if(isDefined(level.br_level) && isDefined(level.br_level.c130_sealeveloverride))
    return level.br_level.c130_sealeveloverride;

  return 650;
}

steerfalling(_id_0D051BB0593DB1E4) {
  _id_80E7F25C27613389 = spawn("script_model", self.origin);
  _id_80E7F25C27613389.angles = self.angles;
  _id_80E7F25C27613389 setModel("viewhands_base_iw8");
  _id_80E7F25C27613389 hide();
  self playerlinktodelta(_id_80E7F25C27613389, "tag_player");
  steerfallinginternal(_id_80E7F25C27613389, _id_0D051BB0593DB1E4);
  _id_80E7F25C27613389 delete();
}

steerfallinginternal(_id_80E7F25C27613389, _id_0D051BB0593DB1E4) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_complete");
  self notify("steerFalling()");
  self endon("steerFalling()");
  _id_AA7A541D584BFB8F = 13.8;
  _id_041BA641096FD5E9 = 0.0001;
  _id_817BEAB23F026D04 = -1350.0;
  _id_393260F42C7893CB = 1400.0;
  _id_FA4DFAC825A92D66 = 1600.0;
  _id_B16089157712C28D = -100.0;

  if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "bigctf") {
    _id_817BEAB23F026D04 = -1750.0;
    _id_393260F42C7893CB = 400.0;
    _id_FA4DFAC825A92D66 = 400.0;
  }

  if(isDefined(_id_0D051BB0593DB1E4)) {
    _id_393260F42C7893CB = _id_393260F42C7893CB * _id_0D051BB0593DB1E4;
    _id_FA4DFAC825A92D66 = _id_FA4DFAC825A92D66 * _id_0D051BB0593DB1E4;
  }

  _id_B1DA74CE505DD34A = level.framedurationseconds * _id_041BA641096FD5E9;
  _id_80E7F25C27613389.vel = (0, 0, _id_B16089157712C28D);
  waitframe();
  _id_948EDC0858691623 = getdvarint("bg_gravity");
  _id_5F5F04187AF565B0 = (0, 0, 0);

  for(;;) {
    _id_F619FE4A4E1D4868 = self getnormalizedmovement();
    _id_58724D69CA657B30 = _id_F619FE4A4E1D4868[0];
    _id_58724E69CA657D63 = _id_F619FE4A4E1D4868[1];
    _id_3C70A7175FBFA3FC = self getplayerangles(1);
    _id_3DD30364951F9FCB = anglesToForward(_id_3C70A7175FBFA3FC) * _id_58724D69CA657B30;
    _id_3DD30264951F9D98 = anglestoright(_id_3C70A7175FBFA3FC) * _id_58724E69CA657D63;
    _id_8C78CDD73A605B74 = _id_3DD30264951F9D98 + _id_3DD30364951F9FCB;
    _id_C068649575851BDF = vectorNormalize(_id_8C78CDD73A605B74) * _id_FA4DFAC825A92D66;
    _id_5F5F04187AF565B0 = _id_5F5F04187AF565B0 + vectorNormalize(_id_C068649575851BDF - _id_5F5F04187AF565B0) * level.framedurationseconds * _id_393260F42C7893CB;
    _id_5F5F04187AF565B0 = _id_5F5F04187AF565B0 - _id_5F5F04187AF565B0 * length(_id_5F5F04187AF565B0) * _id_B1DA74CE505DD34A;
    _id_E925941037B2689C = _id_80E7F25C27613389.vel[2] - _id_AA7A541D584BFB8F * 39.37 * level.framedurationseconds;
    _id_E925941037B2689C = max(_id_817BEAB23F026D04, _id_E925941037B2689C);
    _id_3AE149AD9D0D0D54 = (0, 0, _id_E925941037B2689C);
    _id_80E7F25C27613389.vel = _id_3AE149AD9D0D0D54 + _id_5F5F04187AF565B0;
    _id_80E7F25C27613389.origin = _id_80E7F25C27613389.origin + level.framedurationseconds * _id_80E7F25C27613389.vel;
    _id_8F24116D9F017E9A = sqrt(_id_80E7F25C27613389.vel[0] * _id_80E7F25C27613389.vel[0] + _id_80E7F25C27613389.vel[1] * _id_80E7F25C27613389.vel[1]);
    _id_2C34526903066260 = veltomph(_id_80E7F25C27613389.vel[2] * -1);
    _id_A356040E48E00766 = veltomph(_id_8F24116D9F017E9A);
    _id_1B9AB28B471EED2E = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", _id_1B9AB28B471EED2E);
      self setclientomnvar("ui_br_altimeter_vertical_speed", int(_id_2C34526903066260));
      self setclientomnvar("ui_br_altimeter_horizontal_speed", int(_id_A356040E48E00766));
    }

    waitframe();
  }
}

veltomph(v) {
  _id_360E0B041DF08CAC = v * 0.05682;
  return _id_360E0B041DF08CAC;
}

steerparachuting(_id_0D051BB0593DB1E4) {
  _id_80E7F25C27613389 = spawn("script_model", self.origin);
  _id_80E7F25C27613389.angles = self.angles;
  _id_80E7F25C27613389 setModel("viewhands_base_iw8");
  _id_80E7F25C27613389 hide();
  self playerlinktodelta(_id_80E7F25C27613389, "tag_player");
  steerparachutinginternal(_id_80E7F25C27613389, _id_0D051BB0593DB1E4);
  _id_80E7F25C27613389 delete();
}

steerparachutinginternal(_id_80E7F25C27613389, _id_0D051BB0593DB1E4) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("freefall_complete");
  self endon("parachute_landed");
  self notify("steerFalling()");
  self endon("steerFalling()");
  _id_998FD4B607B8174E = 100.0;
  _id_D86BCC969A419E41 = -200.0;
  _id_D866FE3EBB06E803 = 600.0;
  _id_2EEA432F6E468AB2 = 240.0;
  _id_388B5F929FEE9772 = 120.0;
  _id_B02D7A2ABE83A9EF = 60.0;
  _id_6AD7CB3F09B4C201 = 48;
  _id_A5337F8300110201 = 35.0;
  _id_5B1764B1412948FE = 700.0;
  _id_92517CD227297246 = 100.0;
  _id_290F01F649F1E57E = 600.0;
  _id_71BEA2CDD6EB1010 = 300.0;
  _id_2AFA890495DCED11 = 100.0;
  _id_9D628820B95F3BED = -150.0;

  if(level.gametype == "arm" || level.gametype == "bigctf" || level.gametype == "conflict" || level.gametype == "risk")
    _id_9D628820B95F3BED = -200.0;

  if(isDefined(_id_0D051BB0593DB1E4)) {
    _id_998FD4B607B8174E = _id_998FD4B607B8174E * _id_0D051BB0593DB1E4;
    _id_D86BCC969A419E41 = _id_D86BCC969A419E41 * _id_0D051BB0593DB1E4;
    _id_D866FE3EBB06E803 = _id_D866FE3EBB06E803 * _id_0D051BB0593DB1E4;
    _id_2EEA432F6E468AB2 = _id_2EEA432F6E468AB2 * _id_0D051BB0593DB1E4;
    _id_388B5F929FEE9772 = _id_388B5F929FEE9772 * _id_0D051BB0593DB1E4;
    _id_B02D7A2ABE83A9EF = _id_B02D7A2ABE83A9EF * _id_0D051BB0593DB1E4;
    _id_5B1764B1412948FE = _id_5B1764B1412948FE * _id_0D051BB0593DB1E4;
    _id_290F01F649F1E57E = _id_290F01F649F1E57E * _id_0D051BB0593DB1E4;
    _id_71BEA2CDD6EB1010 = _id_71BEA2CDD6EB1010 * _id_0D051BB0593DB1E4;
    _id_2AFA890495DCED11 = _id_2AFA890495DCED11 * _id_0D051BB0593DB1E4;
  }

  _id_D7BD29AB98F4F1A2 = 100.0;
  _id_648B9956418A7253 = 0;
  _id_924E22DB76C21025 = 0;
  _id_80E7F25C27613389.vel = (0, 0, 0);

  for(;;) {
    _id_F619FE4A4E1D4868 = self getnormalizedmovement();
    _id_58724D69CA657B30 = _id_F619FE4A4E1D4868[0];
    _id_58724E69CA657D63 = _id_F619FE4A4E1D4868[1];
    _id_3C70A7175FBFA3FC = self getplayerangles(1);
    _id_20AF753DED3657E1 = anglesToForward(_id_3C70A7175FBFA3FC);
    _id_62E90A79072C4846 = anglestoright(_id_3C70A7175FBFA3FC);
    _id_65678A4C23282859 = scripts\engine\utility::ter_op(_id_58724D69CA657B30 > 0, _id_2EEA432F6E468AB2, _id_388B5F929FEE9772);
    _id_D7BD29AB98F4F1A2 = _id_D7BD29AB98F4F1A2 + _id_58724D69CA657B30 * _id_65678A4C23282859 * level.framedurationseconds;
    _id_D7BD29AB98F4F1A2 = _id_D7BD29AB98F4F1A2 + _id_B02D7A2ABE83A9EF * level.framedurationseconds * scripts\engine\utility::sign(_id_998FD4B607B8174E - _id_D7BD29AB98F4F1A2);
    _id_D7BD29AB98F4F1A2 = clamp(_id_D7BD29AB98F4F1A2, _id_D86BCC969A419E41, _id_D866FE3EBB06E803);
    _id_82BC834CEAC5A4D4 = -1 * _id_58724D69CA657B30 * _id_A5337F8300110201;
    _id_648B9956418A7253 = _id_648B9956418A7253 + scripts\engine\utility::sign(_id_82BC834CEAC5A4D4 - _id_648B9956418A7253) * _id_6AD7CB3F09B4C201 * level.framedurationseconds;
    _id_7677F3EB70B218E0 = rotatepointaroundvector(_id_62E90A79072C4846, _id_20AF753DED3657E1, _id_648B9956418A7253);
    _id_54E4EAB74AFE520A = _id_D7BD29AB98F4F1A2 * _id_7677F3EB70B218E0;
    _id_3B93DFD1E0DD8D07 = _id_20AF753DED3657E1 * _id_2AFA890495DCED11 + (0, 0, _id_9D628820B95F3BED);
    _id_924E22DB76C21025 = _id_924E22DB76C21025 + _id_290F01F649F1E57E * level.framedurationseconds * _id_58724E69CA657D63;
    _id_924E22DB76C21025 = _id_924E22DB76C21025 - _id_71BEA2CDD6EB1010 * level.framedurationseconds * scripts\engine\utility::sign(_id_924E22DB76C21025);
    _id_924E22DB76C21025 = clamp(_id_924E22DB76C21025, -1 * _id_5B1764B1412948FE, _id_5B1764B1412948FE);
    _id_BC87083848248BE5 = _id_924E22DB76C21025 * _id_62E90A79072C4846;
    _id_C3B8A869A54DA74A = _id_92517CD227297246 * abs(_id_58724E69CA657D63);
    _id_BC87083848248BE5 = _id_BC87083848248BE5 + (0, 0, -1 * _id_C3B8A869A54DA74A);
    _id_80E7F25C27613389.vel = _id_54E4EAB74AFE520A + _id_BC87083848248BE5 + _id_3B93DFD1E0DD8D07;
    _id_80E7F25C27613389.origin = _id_80E7F25C27613389.origin + _id_80E7F25C27613389.vel * level.framedurationseconds;
    _id_8F24116D9F017E9A = sqrt(_id_80E7F25C27613389.vel[0] * _id_80E7F25C27613389.vel[0] + _id_80E7F25C27613389.vel[1] * _id_80E7F25C27613389.vel[1]);
    _id_2C34526903066260 = max(0, veltomph(_id_80E7F25C27613389.vel[2] * -1));
    _id_A356040E48E00766 = max(0, veltomph(_id_8F24116D9F017E9A));
    _id_1B9AB28B471EED2E = min(1, (self.origin[2] - getc130sealevel()) / (getc130height() - getc130sealevel()));

    if(isparachutegametype()) {
      self setclientomnvar("ui_br_altimeter_height", _id_1B9AB28B471EED2E);
      self setclientomnvar("ui_br_altimeter_vertical_speed", int(_id_2C34526903066260));
      self setclientomnvar("ui_br_altimeter_horizontal_speed", int(_id_A356040E48E00766));
    }

    waitframe();
  }
}

isskydivestatedisabled() {
  return isDefined(self.ffsm_state) && (self.ffsm_state == 5 || self.ffsm_state == 6);
}

enablemanualpullchute(_id_13B817862FC50131) {
  self endon("death_or_disconnect");

  if(isDefined(_id_13B817862FC50131) && _id_13B817862FC50131 > 0) {
    self skydive_setdeploymentstatus(0);
    self skydive_setbasejumpingstatus(0);
    wait(_id_13B817862FC50131);
  }

  if(isDefined(self)) {
    if(isskydivestatedisabled()) {
      return;
    }
    self skydive_setdeploymentstatus(1);
    self skydive_setbasejumpingstatus(1);
  }
}

pullchute(_id_32DCB143B4EB723A, _id_EB0C093D4B21E9DD, _id_4A8A64090DDB9C62) {
  self endon("death_or_disconnect");
  thread enablemanualpullchute(3);
  self waittill("skydive_deployparachute");
  self skydive_setdeploymentstatus(0);
  self notify("freefall_complete");

  if(isparachutegametype())
    self setclientomnvar("ui_br_altimeter_state", 2);

  if(!istrue(level.dontshootwhileparachuting))
    self[[level.parachuteopencb]]();

  thread startparachute();
}

parachutedamagemonitor(parachute) {
  self endon("death_or_disconnect");
  self endon("parachute_complete");
  parachute endon("death");
  parachute setCanDamage(1);
  damage = undefined;
  attacker = undefined;
  direction_vec = undefined;
  meansofdeath = undefined;
  modelname = undefined;
  tagname = undefined;
  partname = undefined;
  idflags = undefined;
  objweapon = undefined;
  origin = undefined;
  angles = undefined;
  normal = undefined;
  inflictor = undefined;
  parachute.shotstaken = 0;

  for(;;) {
    parachute waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(meansofdeath)) {
      if(scripts\engine\utility::isbulletdamage(meansofdeath))
        parachute.shotstaken++;
    }
  }
}

startparachute() {
  self endon("death_or_disconnect");

  if(getdvarint("scr_parachute_camera_transition_mode", 1) == 1)
    self skydive_setforcethirdpersonstatus(0);

  self waittill("skydive_end");
  self.ignorefalldamagetime = gettime() + 5000;

  if(istrue(self.delayswaploadout))
    self.delayswaploadout = 0;

  waitframe();
  self[[level.parachuterestoreweaponscb]]();

  if(istrue(level.dontshootwhileparachuting))
    self[[level.parachutecompletecb]]();

  self notify("parachute_landed");
  self skydive_setforcethirdpersonstatus(0);
  self notify("parachute_complete");
  self animscriptsetinputparamreplicationstatus(0);

  if(isparachutegametype())
    self setclientomnvar("ui_br_altimeter_state", 0);

  if(isparachutegametype()) {
    if(isDefined(level.onfirstlandcallback))
      self[[level.onfirstlandcallback]](self);
  }
}

parachutemidairdeathwatcher() {
  self endon("parachute_complete");
  self waittill("death");

  if(isparachutegametype())
    self setclientomnvar("ui_br_altimeter_state", 0);
}

freefallstartdefault() {
  self disableusability();
}

parachuteopendefault() {}

parachutecompletedefault() {
  self enableusability();

  if(isDefined(level.modespecificparachutecompletecb))
    self[[level.modespecificparachutecompletecb]]();

  self.jumptype = undefined;
}

getautodeploynorm() {
  return 0.25;
}

spawnorbitcamera() {
  self cameraset("camera_custom_orbit_0_noremote");
}

removeorbitcamera() {
  self cameradefault();
}

leaveweaponsdefaultfunc() {}

norestoreweaponsdefaultfunc() {}

takeweaponsdefaultfunc() {
  if(isDefined(self.primaryweaponobj)) {
    self.primaryweaponclipammo = self getweaponammoclip(self.primaryweaponobj);
    self.primaryweaponstockammo = self getweaponammostock(self.primaryweaponobj);
  }

  if(isDefined(self.secondaryweaponobj)) {
    self.secondaryweaponclipammo = self getweaponammoclip(self.secondaryweaponobj);
    self.secondaryweaponstockammo = self getweaponammostock(self.secondaryweaponobj);
  }

  gunless = makeweapon("iw9_me_fists_mp");
  _id_F9F3100428A6E476 = makeweapon("none");
  self.weaponlist = self.primaryweapons;
  self clearaccessory();

  if(!self hasweapon(gunless))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(gunless, undefined, undefined, 1);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.weaponlist.size; _id_AC0E594AC96AA3A8++) {
    weapon = self.weaponlist[_id_AC0E594AC96AA3A8];

    if(isDefined(weapon) && !issameweapon(gunless, weapon) && !issameweapon(_id_F9F3100428A6E476, weapon))
      self takeweapon(weapon);
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(gunless, 1);
}

restoreweaponsdefaultfunc() {
  self takeweapon(self.weaponlist[0]);
  self clearaccessory();

  if(isDefined(self.primaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.primaryweaponobj, undefined, undefined, 0);

    if(isDefined(self.primaryweaponclipammo)) {
      self setweaponammoclip(self.primaryweaponobj, self.primaryweaponclipammo);
      self setweaponammostock(self.primaryweaponobj, self.primaryweaponstockammo);
    }
  }

  if(isDefined(self.secondaryweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self.secondaryweaponobj, undefined, undefined, 1);

    if(isDefined(self.primaryweaponclipammo)) {
      self setweaponammoclip(self.secondaryweaponobj, self.secondaryweaponclipammo);
      self setweaponammostock(self.secondaryweaponobj, self.secondaryweaponstockammo);
    }
  }

  self.weaponlist = self getweaponslistprimaries();

  if(isDefined(self.weaponlist[0]))
    scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0]);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0]))
    self.primaryweaponobj = self.weaponlist[0];

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1]))
    self.secondaryweaponobj = self.weaponlist[1];
}

playerwatchforredeploy() {
  level endon("game_ended");
  self endon("disconnect");

  if(scripts\common\utility::iscp())
    self endon("death");

  _id_1F32658706C07DC8 = getdvarfloat("scr_parachute_redeploy_min_height", 256);
  _id_3C2EE4BED7DF269D = 0;
  self.redeployenabled = 1;

  for(;;) {
    if(istrue(self.redeployenabled) && !self isonground() && scripts\cp_mp\utility\player_utility::_isalive() && !self isskydiving() && !self islinked() && !istrue(self.carrying)) {
      _id_7C999FC0722653C3 = 0;

      switch (getdvarint("scr_parachute_redeploy_input_type", 0)) {
        case 0:
          if(_id_3C2EE4BED7DF269D == 0 && self jumpbuttonPressed())
            _id_7C999FC0722653C3 = 1;

          break;
        case 1:
          if(self jumpbuttonPressed() && _id_3C2EE4BED7DF269D + 500 < gettime())
            _id_7C999FC0722653C3 = 1;

          break;
        case 2:
          if(!isDefined(self.doublejumpdetected))
            thread watchfordoublejump();

          if(istrue(self.doublejumpdetected))
            _id_7C999FC0722653C3 = 1;

          break;
        default:
          break;
      }

      if(_id_7C999FC0722653C3) {
        _id_F9CF6C85797F2B98 = scripts\common\utility::groundpos(self.origin);
        _id_C14047C4299F9C74 = self.origin[2] - _id_F9CF6C85797F2B98[2];

        if(_id_C14047C4299F9C74 > _id_1F32658706C07DC8) {
          self notify("skydive_deployparachute");
          self skydive_deployparachute();
        }
      }
    }

    if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!self jumpbuttonPressed())
        _id_3C2EE4BED7DF269D = 0;
      else if(_id_3C2EE4BED7DF269D == 0)
        _id_3C2EE4BED7DF269D = gettime();
    } else
      _id_3C2EE4BED7DF269D = 0;

    waitframe();
  }
}

watchfordoublejump() {
  level endon("game_ended");
  self endon("disconnect");
  self.doublejumpdetected = 0;

  for(;;) {
    if(self jumpbuttonPressed()) {
      _id_0E5486D00EBBA6E9 = gettime();
      _id_2B69EBF1AEB9C653 = 0;
      waitframe();

      for(;;) {
        if(!self jumpbuttonPressed()) {
          if(gettime() < _id_0E5486D00EBBA6E9 + 500 && !self isonground())
            _id_2B69EBF1AEB9C653 = gettime();

          break;
        }

        if(gettime() > _id_0E5486D00EBBA6E9 + 500) {
          break;
        }

        waitframe();
      }

      if(_id_2B69EBF1AEB9C653 == 0) {
        continue;
      }
      waitframe();

      for(;;) {
        if(self jumpbuttonPressed()) {
          if(gettime() < _id_2B69EBF1AEB9C653 + 500 && !self isonground()) {
            self.doublejumpdetected = 1;
            waitframe();
            self.doublejumpdetected = 0;
          }

          break;
        }

        if(gettime() > _id_2B69EBF1AEB9C653 + 500) {
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

parachuteprelaststandfunction() {
  player = self;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(isDefined(player.ffsm_state) && (player.ffsm_state == 1 || player.ffsm_state == 2)) {
      player ffsm_landed_stateenter();
      player.ffsm_state = 3;
    }
  } else if(scripts\common\utility::iscp()) {
    player setclientomnvar("ui_br_altimeter_state", 0);
    player ffsm_landed_stateenter(1);
  }
}

updateparachutestreamhint() {
  player = self;
  velocity = player getvelocity();
  _id_EAC21B0AD618DF9D = clamp(player.origin[2], 0, level.skydivestreamhintdvars.xyvelscale_maxheight) / level.skydivestreamhintdvars.xyvelscale_maxheight;
  _id_E86082FB50387E1D = level.skydivestreamhintdvars.xyvelscale_low + (level.skydivestreamhintdvars.xyvelscale_high - level.skydivestreamhintdvars.xyvelscale_low) * _id_EAC21B0AD618DF9D;
  _id_941CADC9D7B59DC9 = velocity * (1, 1, 0);
  _id_9854DC90EE9DA402 = length(_id_941CADC9D7B59DC9);
  _id_CBC44AA5555239A3 = _id_941CADC9D7B59DC9 * _id_E86082FB50387E1D;
  _id_22133650825CD26B = _id_9854DC90EE9DA402 * _id_E86082FB50387E1D;

  if(_id_22133650825CD26B > level.skydivestreamhintdvars.xylimit)
    _id_CBC44AA5555239A3 = _id_CBC44AA5555239A3 * (level.skydivestreamhintdvars.xylimit / _id_22133650825CD26B);

  _id_81F6DDA3FD92E0B4 = 0;
  _id_81F6DDA3FD92E0B4 = _id_81F6DDA3FD92E0B4 - player.origin[2] * level.skydivestreamhintdvars.zdrop;
  _id_81F6DDA3FD92E0B4 = _id_81F6DDA3FD92E0B4 + level.skydivestreamhintdvars.zoffset;
  _id_81F6DDA3FD92E0B4 = _id_81F6DDA3FD92E0B4 + velocity[2] * level.skydivestreamhintdvars.zvelscale;
  _id_81F6DDA3FD92E0B4 = clamp(_id_81F6DDA3FD92E0B4, -1 * level.skydivestreamhintdvars.zlimit, 0);
  _id_B20B88EBDFC7194F = 1;

  if(_id_9854DC90EE9DA402 < level.skydivestreamhintdvars.falling_xyratio * velocity[2])
    _id_B20B88EBDFC7194F = 2;

  player _meth_670863FC4008C3D8(player.origin + (_id_CBC44AA5555239A3[0], _id_CBC44AA5555239A3[1], _id_81F6DDA3FD92E0B4), _id_B20B88EBDFC7194F);
}

freefallfromplanestatemachine(_id_BDA1DE83E1856735, _id_EB0C093D4B21E9DD, _id_32DCB143B4EB723A, _id_928936FD7C1BFF02, _id_F9EB100D9C645F51, _id_C017D2557D7B9C53) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("freeFallFromPlaneStateMachine");
  self endon("freeFallFromPlaneStateMachine");
  player = self;
  player.ffsm_state = 1;
  player.ffsm_isgulagrespawn = istrue(_id_F9EB100D9C645F51);
  player.ffsm_nextstreamhinttime = 0;
  player ffsm_introsetup(_id_BDA1DE83E1856735, _id_EB0C093D4B21E9DD, _id_32DCB143B4EB723A, _id_928936FD7C1BFF02, _id_C017D2557D7B9C53);
  player ffsm_skydive_stateenter();
  starttime = gettime();

  for(;;) {
    if(player isskydiving() || starttime + 2000 < gettime() || player isskydivestatedisabled()) {
      break;
    }

    waitframe();
  }

  for(;;) {
    if(level.skydivestreamhintdvars.streamhintenabled && player.ffsm_nextstreamhinttime < gettime()) {
      player updateparachutestreamhint();
      player.ffsm_nextstreamhinttime = gettime() + 500;
    }

    if(player isinfreefall() && player.ffsm_state != 1) {
      player ffsm_skydive_stateenter();
      player.ffsm_state = 1;
    }

    if(player isparachuting() && player.ffsm_state != 2) {
      player ffsm_parachuteopen_stateenter();
      player.ffsm_state = 2;
    }

    if(!player isskydiving() && player.ffsm_state != 3 && player.ffsm_state != 4 && player.ffsm_state != 6 || player.ffsm_state == 5) {
      player ffsm_landed_stateenter();

      if(player.ffsm_state != 5)
        player.ffsm_state = 3;
      else
        player.ffsm_state = 6;
    }

    _id_AA4F5EA34DFE428B = istrue(player.inlaststand);
    _id_31C5DAC60B438208 = (player isonground() || player _meth_E40102956C887F7C() || player _meth_415FE9EECA7B2E2B()) && (player.ffsm_state == 3 || player isskydivestatedisabled());
    _id_A2B5F51A86D266AD = player isonladder();
    _id_B48E997E59346E83 = !scripts\cp_mp\utility\player_utility::isreallyalive(player);
    binvehicle = player _meth_793F941D7DFF15ED();
    _id_15D3F6CDD6F19D4D = player _meth_9CC921A57FF4DEB5();

    if(_id_AA4F5EA34DFE428B || _id_31C5DAC60B438208 || _id_A2B5F51A86D266AD || _id_B48E997E59346E83 || binvehicle || _id_15D3F6CDD6F19D4D) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "ftue_trigger_landed_hint"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "ftue_trigger_landed_hint")]]();

      player ffsm_onground_stateenter();
      player.ffsm_state = undefined;
      player.ffsm_isgulagrespawn = undefined;
      player.ffsm_nextstreamhinttime = undefined;

      if(_id_A2B5F51A86D266AD)
        player skydive_interrupt();

      return;
    }

    waitframe();
  }
}

ffsm_introsetup(_id_BDA1DE83E1856735, _id_EB0C093D4B21E9DD, _id_32DCB143B4EB723A, _id_928936FD7C1BFF02, _id_C017D2557D7B9C53) {
  self skydive_interrupt();

  if(!istrue(level.parachuteinitfinished))
    initparachutedvars();

  if(!isDefined(_id_BDA1DE83E1856735))
    _id_BDA1DE83E1856735 = 4.0;

  if(!isDefined(_id_C017D2557D7B9C53))
    _id_C017D2557D7B9C53 = 1;

  if(_id_C017D2557D7B9C53 && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    self[[level.parachutetakeweaponscb]]();

  self[[level.freefallstartcb]]();

  if(!isDefined(_id_32DCB143B4EB723A))
    self notifyonplayercommand("open_parachute", "+gostand");

  self animscriptsetinputparamreplicationstatus(1);

  if(isDefined(_id_928936FD7C1BFF02))
    self setvelocity(_id_928936FD7C1BFF02);

  self skydive_beginfreefall();

  if(getdvarint("scr_parachute_camera_transition_mode", 1) != 2)
    self skydive_setforcethirdpersonstatus(1);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && (!istrue(self.ffsm_isgulagrespawn) || getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm") || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk" || getDvar("dvar_7611A2790A0BF7FE", "") == "resurgence")
    thread infilparachutevfx(getdvarint("dvar_96E4167DD77B8CEE", 1) == 1 && (getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm" || getDvar("dvar_7611A2790A0BF7FE", "") == "plunder" || getDvar("dvar_7611A2790A0BF7FE", "") == "risk" || getDvar("dvar_7611A2790A0BF7FE", "") == "resurgence"));

  if(istrue(_id_EB0C093D4B21E9DD))
    thread enablemanualpullchute(0);
  else
    thread enablemanualpullchute(_id_BDA1DE83E1856735);

  self[[level.parachuterestoreweaponscb]]();
}

ffsm_skydive_stateenter() {
  if(isparachutegametype()) {
    self setclientomnvar("ui_br_altimeter_state", 1);
    level.activeparachuters[self getxuid()] = self;
  }

  if(!self.ffsm_isgulagrespawn) {
    _id_9E50CEF01527FF79 = "enabled";

    if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.brinfilsmokesuffix))
      _id_9E50CEF01527FF79 = _id_9E50CEF01527FF79 + self.operatorcustomization.brinfilsmokesuffix;
  }
}

ffsm_parachuteopen_stateenter() {
  self notify("freefall_complete");

  if(isDefined(self.jump_music) && self.jump_music == 1) {
    _id_FBA2E07D75159AE9 = _id_7AB5B649FA408138::_id_17EE301CF0B5BA85("br_plane_jump_parachute");
    self setplayermusicstate(_id_FBA2E07D75159AE9);
    self.jump_music = 0;
  }

  level.activeparachuters[self getxuid()] = self;

  if(isparachutegametype())
    self setclientomnvar("ui_br_altimeter_state", 2);

  if(!istrue(level.dontshootwhileparachuting))
    self[[level.parachuteopencb]]();
}

ffsm_landed_stateenter(_id_83E33C8931D52D73) {
  self.ignorefalldamagetime = gettime() + 5000;

  if(istrue(self.delayswaploadout))
    self.delayswaploadout = 0;

  if(istrue(level.dontshootwhileparachuting))
    self[[level.parachutecompletecb]]();

  self notify("parachute_landed");
  self skydive_setforcethirdpersonstatus(0);

  if(!isskydivestatedisabled())
    self skydive_setbasejumpingstatus(1);

  if(istrue(self.restoreriotshieldonland)) {
    riotshield_attach_parachute(self.restoreriotshieldonland == 1, riotshield_getmodel_parachute());
    self.restoreriotshieldonland = undefined;
  }

  level.activeparachuters[self getxuid()] = undefined;
  self notify("parachute_complete");
  self animscriptsetinputparamreplicationstatus(0);
}

ffsm_onground_stateenter() {
  self._id_6A984A8887A1A08B = 1;

  if(level.skydivestreamhintdvars.streamhintenabled)
    self clearadditionalstreampos();

  if(isparachutegametype()) {
    level.activeparachuters[self getxuid()] = undefined;
    self setclientomnvar("ui_br_altimeter_state", 0);
    thread playlandingbreath();

    if(isDefined(level.onfirstlandcallback))
      self[[level.onfirstlandcallback]](self);
  }
}

playlandingbreath() {
  self endon("death_or_disconnect");
  wait 0.3;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](self)) {
      self playlocalsound("plr_breath_land_parachute", self);
      self playsoundonmovingent("breath_land_parachute_npc");
    }
  }
}

parachutecleanup() {
  player = self;
  player skydive_interrupt();

  if(isDefined(player.parachute))
    player.parachute delete();
}