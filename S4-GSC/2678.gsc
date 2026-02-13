/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2678.gsc
*************************************************/

_id_8E2C() {
  if(istrue(self._id_ED21)) {
    _id_6FF4();
  }
}

_id_8E2E(var_0) {
  switch (var_0) {
    case 1:
    default:
      return "popup_safeguard_levelup";
    case 2:
      return "icon_ks_heli_attack_hud";
    case 8:
    case 3:
      return "icon_ks_air_super_hud";
    case 4:
      return "icon_ks_jugg_hud";
    case 5:
      return "icon_ks_sat_com_hud";
    case 6:
      return "popup_safeguard_revived";
    case 7:
      return "icon_ks_skylark_uav_hud";
    case 9:
      return "icon_ks_sentry_gun_hud";
    case 10:
      return "icon_ks_maniac_hud";
  }
}

_id_8E2D(var_0) {
  switch (var_0) {
    case 1:
    default:
      return &"MP/HOLD_TO_EQUIP_TACOPS_SPAWNER";
    case 2:
      return &"MP/HOLD_TO_EQUIP_TACOPS_COPTER";
    case 8:
    case 3:
      return &"MP/HOLD_TO_EQUIP_TACOPS_ARTILLERY";
    case 4:
      return &"MP/HOLD_TO_EQUIP_TACOPS_JUGG";
    case 5:
      return &"MP/HOLD_TO_EQUIP_TACOPS_SPOTTER";
    case 6:
      return &"MP/HOLD_TO_EQUIP_TACOPS_MEDIC";
    case 7:
      return &"MP/HOLD_TO_EQUIP_TACOPS_STEALTH";
    case 9:
      return &"MP/HOLD_TO_EQUIP_TACOPS_TURRET";
    case 10:
      return &"MP/HOLD_TO_EQUIP_TACOPS_GAS";
  }
}

_id_526F(var_0) {
  foreach(var_2 in var_0) {
    var_2 _id_526E();
  }
}

_id_827D() {
  level._id_EFAE = [];
  level._id_EFAE["allies"] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  level._id_EFAE["axis"] = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  level thread _id_9A30();
}

_id_405A(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_1);
  var_4 setModel("prop_suitcase_bomb");
  var_4._id_8E2F = var_0;
  var_4._id_5F03 = var_2;

  if(!istrue(var_3)) {
    var_4 _id_526E();
  }

  if(!isDefined(level._id_ED20)) {
    level._id_ED20 = [];
  }

  level._id_ED20[level._id_ED20.size] = var_4;
}

_id_526E() {
  self makeuseable();
  thread _id_ED13();
  var_0 = _id_8E2E(self._id_8E2F);
  self._id_413F = _id_4007(var_0, self._id_5F03);
  _id_07D6::_id_D8D1(&"MP/PLANTING_EXPLOSIVE");
  self sethintstring(_id_8E2D(self._id_8E2F));
  self _meth_83A1(0);
  level thread _id_ED12(self);
}

_id_ED13() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_D8CD(self._id_5F03);
    level waittill("joined_team");
  }
}

_id_D8CD(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0 || isDefined(var_2._id_ED10)) {
      self disableplayeruse(var_2);
      continue;
    }

    self _meth_80E0(var_2);
  }
}

_id_ED12(var_0) {
  level endon("game_ended");
  var_0 waittill("trigger", var_1);
  var_1._id_ED10 = var_0._id_8E2F;
  var_2 = [];

  switch (var_0._id_8E2F) {
    case 1:
    default:
      if(var_1.team == "allies") {
        _id_0A75::_id_BEC0("dx_mpb_ovl_rolesa_beacons", var_1);
      } else {
        _id_0A75::_id_BEC0("dx_mpb_aqcm_rolesb_beacons", var_1);
      }

      var_1 scripts\mp\supers::givesuper("super_tac_ops_spawn");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tac_ops_spawn";
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_COMMAND_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_COMMAND_2";
      break;
    case 5:
      if(var_1.team == "allies") {
        _id_0A75::_id_BEC0("dx_mpb_ovl_rolesa_sigint", var_1);
      } else {
        _id_0A75::_id_BEC0("dx_mpb_aqcm_rolesb_intel", var_1);
      }

      var_1 _id_711B();
      var_1 scripts\mp\supers::givesuper("super_tacops_uav");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_uav";
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_SIGINT_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_SIGINT_2";
      var_2[2] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_SIGINT_3";
      break;
    case 2:
      _id_0A75::_id_BEC0("dx_mpb_ovl_rolesa_jtac", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_heli");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_heli";
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_AIR_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_AIR_2";
      break;
    case 10:
      _id_0A75::_id_BEC0("dx_mpb_aqcm_rolesb_bio", var_1);
      var_1 scripts\mp\supers::givesuper("super_tac_ops_gas");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tac_ops_gas";
      var_1._id_ED0E = 1;
      var_2[0] = &"MISC_MESSAGES_MP_TO_ALLY_ROLE_GAS_1";
      var_2[1] = &"MISC_MESSAGES_MP_TO_ALLY_ROLE_GAS_2";
      break;
    case 8:
    case 3:
      _id_0A75::_id_BEC0("dx_mpb_ovl_rolesa_artillery", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_artillery");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_artillery";
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ARTILLERY_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ARTILLERY_2";
      break;
    case 4:
      _id_0A75::_id_BEC0("dx_mpb_ovl_rolesa_armor", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_juggernaut");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_juggernaut";
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_JUGG_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_JUGG_2";
      break;
    case 7:
      _id_0A75::_id_BEC0("dx_mpb_aqcm_rolesb_scout", var_1);
      var_1 _id_6FF4();
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_STEALTH_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_STEALTH_2";
      break;
    case 6:
      if(var_1.team == "allies") {
        _id_0A75::_id_BEC0("dx_mpb_ovl_rolesa_medic8", var_1);
      } else {
        _id_0A75::_id_BEC0("dx_mpb_aqcm_rolesb_medic", var_1);
      }

      var_1 scripts\mp\supers::givesuper("super_tac_ops_supply_pack");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tac_ops_supply_pack";
      var_1._id_ED19 = 1;
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_MEDIC_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_MEDIC_2";
      break;
    case 9:
      _id_0A75::_id_BEC0("dx_mpb_aqcm_rolesb_engineer", var_1);
      var_1 scripts\mp\supers::givesuper("super_tacops_turret");
      var_1 scripts\mp\supers::_id_6FF9(400000);
      var_1.pers["tac_ops_super"] = "super_tacops_turret";
      var_2[0] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ENGINEER_1";
      var_2[1] = &"MISC_MESSAGES_MP/TO_ALLY_ROLE_ENGINEER_2";
      break;
  }

  var_1 thread _id_480C(var_2);
  var_1 _id_4AF1();
  var_0 delete();
}

_id_6FF4() {
  self._id_ED21 = 1;
  scripts\mp\utility\perk::_id_6FC2("specialty_coldblooded");
  scripts\mp\utility\perk::_id_6FC2("specialty_tracker_jammer");
  scripts\mp\utility\perk::_id_6FC2("specialty_blindeye");
  scripts\mp\utility\perk::_id_6FC2("specialty_engineer");
  scripts\mp\utility\perk::_id_6FC2("specialty_ghost");
}

_id_480C(var_0) {
  foreach(var_2 in var_0) {
    scripts\mp\gametypes\tac_ops::_id_F8D0(var_2, 5);
    wait 0.5;
  }
}

_id_4AF1() {
  for(var_0 = 0; var_0 < level._id_ED20.size; var_0++) {
    if(isDefined(level._id_ED20[var_0])) {
      level._id_ED20[var_0] disableplayeruse(self);
    }
  }

  var_1 = level._id_ED11[self.team];

  for(var_0 = 0; var_0 < var_1.size; var_0++) {
    if(isDefined(var_1[var_0])) {
      _id_07F9::_id_A89E(var_1[var_0], self);
    }
  }
}

_id_4007(var_0, var_1) {
  var_2 = _id_07F9::_id_C57D(10);

  if(var_2 == -1) {
    return -1;
  }

  _id_07F9::_id_A867(var_2, "invisible", (0, 0, 0), var_0);
  _id_07F9::_id_FB93(var_2, self);
  _id_07F9::_id_FB9E(var_2, "active");
  _id_07F9::_id_FB8F(var_2, var_0);

  if(isDefined(level._id_A91D)) {
    [[level._id_A91D]](var_2);
  }

  if(!isDefined(level._id_ED11)) {
    level._id_ED11 = [];
    level._id_ED11["allies"] = [];
    level._id_ED11["axis"] = [];
  }

  level._id_ED11[var_1][level._id_ED11[var_1].size] = var_2;
  _id_07F9::_id_A89F(var_2);

  foreach(var_4 in level.players) {
    if(isDefined(var_4.team) && var_4.team == var_1) {
      _id_07F9::_id_A89D(var_2, var_4);
      continue;
    }

    _id_07F9::_id_A89E(var_2, var_4);
  }

  return var_2;
}

_id_90D2() {
  if(!isDefined(level._id_ED11)) {
    return;
  }
  foreach(var_1 in level._id_ED11[self.team]) {
    _id_07F9::_id_A89D(var_1, self);
  }

  foreach(var_1 in level._id_ED11[scripts\mp\utility\game::_id_6BE2(self.team)[0]]) {
    _id_07F9::_id_A89E(var_1, self);
  }
}

_id_711B() {
  thread _id_E444();
}

_id_9A30() {
  level endon("game_ended");
  level._id_B7FF = [];
  level._id_B7FE["allies"] = [];
  level._id_B7FE["axis"] = [];
}

_id_9542() {
  level endon("game_ended");
  self endon("listenDisconnectSpotted");
  self waittill("disconnect");
  _id_C160(self);
}

_id_C160(var_0) {
  var_1 = var_0 getentitynumber();

  if(isDefined(level._id_B7FE["allies"][var_1])) {
    var_2 = level._id_B7FE["allies"][var_1];
    level._id_B7FE["allies"][var_1] = undefined;
    level._id_EFAE["allies"][level._id_EFAE["allies"].size] = var_2;
  }

  if(isDefined(level._id_B7FE["axis"][var_1])) {
    var_2 = level._id_B7FE["axis"][var_1];
    level._id_B7FE["axis"][var_1] = undefined;
    level._id_EFAE["axis"][level._id_EFAE["axis"].size] = var_2;
  }
}

_id_E435(var_0) {
  if(!isDefined(var_0._id_ED1F)) {
    var_0 thread _id_E431();
    var_0._id_ED1F = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
    var_1 = scripts\mp\utility\teams::_id_6DCA(scripts\mp\utility\game::_id_6BE2(var_0.team)[0], "players");

    foreach(var_3 in var_1) {}
  } else
    _id_C1AC(var_0);
}

_id_E431() {
  self endon("disconnect");
  self endon("refresh_spot_timer");
  level endon("game_ended");
  scripts\engine\utility::_id_108F5("death", 3);
  _id_FB28(self);
}

_id_C1AC(var_0) {
  var_0 notify("refresh_spot_timer");
  var_0 thread _id_E431();
}

_id_FB28(var_0) {
  if(!isDefined(var_0._id_ED1F)) {
    return;
  }
  var_1 = level._id_B7FE[scripts\mp\utility\game::_id_6BE2(var_0._id_ED1F)[0]];
  var_2 = scripts\mp\utility\teams::_id_6DCA(var_0._id_ED1F, "players");
  var_0._id_ED1F = undefined;

  foreach(var_4 in var_2) {}
}

_id_7374(var_0) {
  wait 5;

  if(isbot(var_0) == 0) {
    var_0 thread _id_E444();
  }
}

_id_E444() {
  for(;;) {
    var_0 = scripts\mp\utility\teams::_id_6DCA(scripts\mp\utility\game::_id_6BE2(self.team)[0], "players");

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || var_2 == self || !scripts\mp\utility\player::isreallyalive(var_2) || istrue(var_2._id_ED21)) {
        continue;
      }
      if(distancesquared(self getEye(), var_2 getEye()) < 7290000) {
        if(_func_0202(self getEye(), var_2 getEye(), 0, self)) {
          _id_E435(var_2);
        }
      }
    }

    wait 0.333;
  }
}

_id_F1D2(var_0) {
  if(!isDefined(level._id_ED24)) {
    level._id_ED24 = [];
  }

  if(!isDefined(level._id_ED24[var_0.owner.team])) {
    level._id_ED24[var_0.owner.team] = [];
  }

  var_1 = level._id_ED24[var_0.owner.team].size;

  if(var_1 >= 4) {
    var_2 = level._id_ED24[var_0.owner.team][0];
    level._id_ED24[var_0.owner.team] = ::scripts\engine\utility::array_remove_index(level._id_ED24[var_0.owner.team], 0);
    var_2 _id_4EA7();
  }

  var_0.team = var_0.owner.team;
  var_0._id_F17A = (var_0.angles[0], var_0.angles[1], 0);
  var_0 waittill("missile_stuck");
  var_3 = _id_4059(self, var_0.origin);
  var_1 = level._id_ED24[var_3.owner.team].size;
  level._id_ED24[var_0.owner.team][var_1] = var_3;
  var_0 delete();
}

_id_4EA7() {
  self delete();
}

_id_EB56() {
  level endon("game_ended");
  self waittill("death");
  _id_4EA7();
}

_id_24BA() {
  return 1;
}

_id_24BB() {
  self _meth_852A("tac_ops_supply_pack_grenade_mp");
  return 1;
}

_id_4059(var_0, var_1) {
  var_2 = "equipment";
  var_3 = 20;
  var_4 = 20;
  var_5 = spawn("script_model", var_1 + (0, 0, 10));
  var_6 = "equipment_resupply_bag";
  var_5 _meth_85AF();
  var_5 setModel(var_6);
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.type = var_2;
  var_7 = spawn("trigger_radius", var_1, 0, var_3, var_4);
  var_7 thread _id_10C10(var_5);
  var_7 thread _id_10C0F(var_5);
  return var_5;
}

_id_10C0F(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

_id_10C10(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1) || !isalive(var_1)) {
      continue;
    }
    level._id_ED24[var_0.team] = ::scripts\engine\utility::array_remove(level._id_ED24[var_0.team], var_0);
    var_1.health = var_1.maxhealth;
    scripts\mp\weapons::_id_CBAA(var_1);
    var_1 playsoundtoplayer("scavenger_pack_pickup", var_1, var_1);
    var_0 delete();
  }
}

_id_711A() {
  scripts\mp\supers::givesuper("super_tacops_heli", 1);
}

_id_FE79() {
  return 1;
}

_id_FE27() {
  return 1;
}

_id_FEEC() {
  return 1;
}

_id_10C23(var_0) {
  self endon("disconnect");
  self endon("microTurret_spawned");
  self endon("microTurret_end");
  self waittill("equip_deploy_end", var_1, var_2, var_3, var_4);
  scripts\mp\supers::_id_6FF9(400000);
}

_id_FEEF() {
  return 1;
}

_id_FE87() {
  thread scripts\mp\gametypes\cmd::_id_6FA8();
  return 1;
}