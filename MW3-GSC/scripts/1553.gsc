/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1553.gsc
**************************************/

_id_3CE1() {
  precachestring(&"SP_KILLSTREAKS_CAPTURING_CRATE");
  precacheshader("progress_bar_fill");
  precacheshader("progress_bar_bg");
  precacheshader("dpad_killstreak_carepackage");
  precacheshader("specialty_carepackage");
  precachestring(&"SP_KILLSTREAKS_SHAREPACKAGE_TITLE");
  precachestring(&"SP_KILLSTREAKS_SHAREPACKAGE_DESC");
  precachestring(&"SP_KILLSTREAKS_CRATE_HIJACK_TITLE");
  precachestring(&"SP_KILLSTREAKS_CRATE_HIJACK_DESC");
  precachestring(&"SP_KILLSTREAKS_EARNED_AIRDROP");
  precachestring(&"SP_KILLSTREAKS_NAME_AIRDROP");
  precacheitem("killstreak_sentry_sp");
  precacheshader("specialty_sentry_gun_crate");
  precacheshader("specialty_airdrop_sentry_minigun");
  precachestring(&"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY");
  precachestring(&"SP_KILLSTREAKS_SENTRY_PICKUP");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_SENTRY");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_SENTRY");
  precacheshader("specialty_stalker");
  precacheshader("specialty_longersprint");
  precacheshader("specialty_fastreload");
  precacheshader("specialty_quickdraw");
  precacheshader("specialty_steadyaim");
  precachestring(&"SP_KILLSTREAKS_SPECIALTY_LONGERSPRINT_PICKUP");
  precachestring(&"SP_KILLSTREAKS_SPECIALTY_FASTRELOAD_PICKUP");
  precachestring(&"SP_KILLSTREAKS_SPECIALTY_QUICKDRAW_PICKUP");
  precachestring(&"SP_KILLSTREAKS_SPECIALTY_BULLETACCURACY_PICKUP");
  precachestring(&"SP_KILLSTREAKS_SPECIALTY_STALKER_PICKUP");
  precacheitem("c4");
  precacheshader("hud_icon_c4");
  precachestring(&"SP_KILLSTREAKS_EARNED_AIRDROP_C4");
  precachestring(&"SP_KILLSTREAKS_C4_PICKUP");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_C4");
  precacheshader("waypoint_ammo_friendly");
  precachestring(&"PLATFORM_RESUPPLY");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_AMMO");
  precacheitem("remote_missile_detonator");
  precacheitem("remote_missile");
  precacheshader("dpad_killstreak_hellfire_missile");
  precacheshader("specialty_predator_missile");
  precachestring(&"SP_KILLSTREAKS_EARNED_PREDATOR_MISSILE");
  precachestring(&"SP_KILLSTREAKS_REMOTEMISSILE_PICKUP");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_AIRDROP_REMOTEMISSILE");
  precachestring(&"SP_KILLSTREAKS_REWARDNAME_REMOTEMISSILE");
  precacheshader("specialty_nuke");
}

_id_3CE2() {
  level._id_3CE3 = spawnStruct();
  level._id_3CE3._id_3CE4 = [];
  var_0 = common_scripts\utility::getstruct("map_center", "targetname");
  level.mapcenter = var_0.origin;
  common_scripts\utility::array_thread(level.players, ::_id_3CE7);

  if(!_id_0614::_id_3BA2()) {
    _id_0614::_id_3B9D();
  }
  _id_3CE5();
  level._id_3CE3._id_3BA1 = 1;
}

_id_3CE5() {
  level.uiparent = spawnStruct();
  level.uiparent.horzalign = "left";
  level.uiparent.vertalign = "top";
  level.uiparent.alignx = "left";
  level.uiparent.aligny = "top";
  level.uiparent.x = 0;
  level.uiparent.y = 0;
  level.uiparent.width = 0;
  level.uiparent.height = 0;
  level.uiparent.children = [];
  level.fontheight = 12;
  level.hud["allies"] = spawnStruct();
  level.hud["axis"] = spawnStruct();
  level.primaryprogressbary = -61;
  level.primaryprogressbarx = 0;
  level.primaryprogressbarheight = 9;
  level.primaryprogressbarwidth = 120;
  level.primaryprogressbartexty = -75;
  level.primaryprogressbartextx = 0;
  level.primaryprogressbarfontsize = 0.6;
  level.teamprogressbary = 32;
  level.teamprogressbarheight = 14;
  level.teamprogressbarwidth = 192;
  level.teamprogressbartexty = 8;
  level.teamprogressbarfontsize = 1.65;

  if(issplitscreen()) {
    level.lowertextyalign = "BOTTOM";
    level.lowertexty = -76;
    level.lowertextfontsize = 1.14;
  } else {
    level.lowertextyalign = "CENTER";
    level.lowertexty = 70;
    level.lowertextfontsize = 1.6;
  }
}

_id_3CE6() {
  return isDefined(level._id_3CE3) && isDefined(level._id_3CE3._id_3BA1);
}

_id_3CE7() {
  self._id_3CE3 = spawnStruct();
  self._id_3CE3.killstreaks = [];
  thread _id_3CF5();

  if(!isDefined(self._id_1FB6)) {
    self._id_1FB6 = 4;
  }
  thread _id_0612::_id_3C4F();
}

_id_3CE8(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(issubstr(var_0, "specialty_")) {
    var_1 = "airdrop_marker_mp";
    var_2 = ::_id_3CFD;
    var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP";
    var_3 = "UK_1mc_achieve_carepackage";
    var_4 = "UK_1mc_use_carepackage";
    var_5 = "specialty_carepackage";
    var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
    var_9 = ::_id_3D00;

    switch (var_0) {
      case "specialty_longersprint":
        var_7 = "specialty_longersprint";
        var_8 = &"SP_KILLSTREAKS_SPECIALTY_LONGERSPRINT_PICKUP";
        break;
      case "specialty_fastreload":
        var_7 = "specialty_fastreload";
        var_8 = &"SP_KILLSTREAKS_SPECIALTY_FASTRELOAD_PICKUP";
        break;
      case "specialty_quickdraw":
        var_7 = "specialty_quickdraw";
        var_8 = &"SP_KILLSTREAKS_SPECIALTY_QUICKDRAW_PICKUP";
        break;
      case "specialty_detectexplosive":
        var_7 = "specialty_bombsquad";
        var_8 = &"SP_KILLSTREAKS_SPECIALTY_DETECTEXPLOSIVE_PICKUP";
        break;
      case "specialty_bulletaccuracy":
        var_7 = "specialty_steadyaim";
        var_8 = &"SP_KILLSTREAKS_SPECIALTY_BULLETACCURACY_PICKUP";
        break;
      case "specialty_stalker":
        var_7 = "specialty_stalker";
        var_8 = &"SP_KILLSTREAKS_SPECIALTY_STALKER_PICKUP";
        break;
      default:
        return;
    }
  } else {
    switch (var_0) {
      case "carepackage":
        var_1 = "airdrop_marker_mp";
        var_2 = ::_id_3CFD;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "specialty_carepackage";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
        var_7 = "dpad_killstreak_carepackage";
        var_8 = &"SP_KILLSTREAKS_NAME_AIRDROP";
        var_9 = undefined;
        break;
      case "carepackage_sentry":
        var_1 = "airdrop_marker_mp";
        var_2 = ::_id_3CFD;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_SENTRY";
        var_3 = "UK_1mc_deploy_sentry";
        var_4 = undefined;
        var_5 = "specialty_airdrop_sentry_minigun";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY";
        var_7 = "specialty_sentry_gun_crate";
        var_8 = &"SP_KILLSTREAKS_SENTRY_PICKUP";
        var_9 = undefined;
        break;
      case "sentry":
        var_1 = "killstreak_sentry_sp";
        var_2 = ::_id_3D02;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_SENTRY";

        if(getdvarint("survival_chaos") == 1) {
          var_3 = "cm_bp_cp_sentrygun";
        } else {
          var_3 = "UK_1mc_deploy_sentry";
        }
        var_4 = undefined;
        var_5 = "specialty_airdrop_sentry_minigun";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY";
        var_7 = "specialty_sentry_gun_crate";
        var_8 = &"SP_KILLSTREAKS_SENTRY_PICKUP";
        var_9 = undefined;
        break;
      case "sentry_gl":
        var_1 = "killstreak_sentry_sp";
        var_2 = ::_id_3D03;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_SENTRY";
        var_3 = "UK_1mc_deploy_sentry";
        var_4 = undefined;
        var_5 = "specialty_airdrop_sentry_minigun";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP_SENTRY";
        var_7 = "specialty_sentry_gun_crate";
        var_8 = &"SP_KILLSTREAKS_SENTRY_PICKUP";
        var_9 = undefined;
        break;
      case "carepackage_remote_missile":
        var_1 = "airdrop_marker_mp";
        var_2 = ::_id_3CFD;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_REMOTEMISSILE";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "specialty_predator_missile";
        var_6 = &"SP_KILLSTREAKS_";
        var_7 = "dpad_killstreak_carepackage";
        var_8 = &"SP_KILLSTREAKS_NAME_AIRDROP";
        var_9 = undefined;
        break;
      case "remote_missile":
        var_1 = "remote_missile_detonator";
        var_2 = ::_id_3CFA;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_REMOTEMISSILE";
        var_3 = "UK_1mc_achieve_hellfire";
        var_4 = "UK_1mc_use_hellfire";
        var_5 = "specialty_predator_missile";
        var_6 = &"SP_KILLSTREAKS_EARNED_PREDATOR_MISSILE";
        var_7 = "dpad_killstreak_hellfire_missile";
        var_8 = &"SP_KILLSTREAKS_REMOTEMISSILE_PICKUP";
        var_9 = undefined;
        break;
      case "carepackage_c4":
        var_1 = "airdrop_marker_mp";
        var_2 = ::_id_3CFD;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_C4";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "hud_icon_c4";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP_C4";
        var_7 = "hud_icon_c4";
        var_8 = &"SP_KILLSTREAKS_C4_PICKUP";
        var_9 = ::_id_3D01;
        break;
      case "carepackage_ammo":
        var_1 = "airdrop_marker_mp";
        var_2 = ::_id_3CFD;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_AMMO";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "specialty_carepackage";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
        var_7 = "waypoint_ammo_friendly";
        var_8 = &"PLATFORM_RESUPPLY";
        var_9 = ::_id_3CFF;
        break;
      case "carepackage_precision_airstrike":
        var_1 = "airdrop_marker_mp";
        var_2 = ::_id_3CFD;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_PRECISION_AIRSTRIKE";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "specialty_precision_airstrike";
        var_6 = &"SP_KILLSTREAKS_EARNED_PRECISION_AIRSTRIKE";
        var_7 = "dpad_killstreak_carepackage";
        var_8 = &"SP_KILLSTREAKS_PRECISION_AIRSTRIKE_PICKUP";
        var_9 = undefined;
        break;
      case "precision_airstrike":
        var_1 = "killstreak_precision_airstrike_sp";
        var_2 = ::_id_3D05;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_PRECISION_AIRSTRIKE";
        var_3 = "UK_1mc_achieve_airstrike";
        var_4 = "UK_1mc_use_airstrike";
        var_5 = "specialty_precision_airstrike";
        var_6 = &"SP_KILLSTREAKS_EARNED_PRECISION_AIRSTRIKE";
        var_7 = "dpad_killstreak_precision_airstrike";
        var_8 = &"SP_KILLSTREAKS_PRECISION_AIRSTRIKE_PICKUP";
        var_9 = undefined;
        break;
      case "carepackage_stealth_airstrike":
        var_1 = "airdrop_marker_mp";
        var_2 = ::_id_3CFD;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_STEALTH_AIRSTRIKE";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "specialty_stealth_bomber";
        var_6 = &"SP_KILLSTREAKS_EARNED_STEALTH_AIRSTRIKE";
        var_7 = "dpad_killstreak_carepackage";
        var_8 = &"SP_KILLSTREAKS_STEALTH_AIRSTRIKE_PICKUP";
        var_9 = undefined;
        break;
      case "stealth_airstrike":
        var_1 = "killstreak_stealth_airstrike_sp";
        var_2 = ::_id_3D05;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_STEALTH_AIRSTRIKE";
        var_3 = "UK_1mc_achieve_airstrike";
        var_4 = "UK_1mc_use_airstrike";
        var_5 = "specialty_stealth_bomber";
        var_6 = &"SP_KILLSTREAKS_EARNED_STEALTH_AIRSTRIKE";
        var_7 = "dpad_killstreak_stealth_bomber";
        var_8 = &"SP_KILLSTREAKS_STEALTH_AIRSTRIKE_PICKUP";
        var_9 = undefined;
        break;
      default:
        return;
    }
  }

  var_11 = spawnStruct();
  var_11.streaktype = var_0;
  var_11.weaponname = var_1;
  var_11._id_3CE9 = var_2;
  var_11._id_3CEA = var_10;
  var_11._id_3CEB = var_3;
  var_11._id_3CEC = var_4;
  var_11._id_3CED = var_5;
  var_11._id_3CEE = var_6;
  var_11._id_3BC5 = var_7;
  var_11._id_3BC6 = var_8;
  var_11._id_3BBE = var_9;
  level._id_3CE3._id_3CE4[var_0] = var_11;
  _id_3CEF(var_3, var_4);
}

_id_3CEF(var_0, var_1) {
  if(!isDefined(level._id_11BB)) {
    level._id_11BB = [];
  }
  var_2[0] = var_0;
  var_2[1] = var_1;

  foreach(var_4 in var_2) {
    if(!maps\_utility::_id_0AD1(level._id_11BB, var_4) && isDefined(var_4)) {
      level._id_11BB[var_4] = var_4;
    }
  }
}

_id_3CF0(var_0) {
  foreach(var_3, var_2 in level._id_3CE3._id_3CE4) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_3BC4(var_0) {
  var_1 = level._id_3CE3._id_3CE4[var_0];
  return var_1;
}

_id_3BBF(var_0, var_1) {
  if(!isDefined(self._id_3CE3.killstreaks[0])) {
    self._id_3CE3.killstreaks[0] = var_0;
  } else {
    var_2 = [];
    var_2[0] = var_0;

    foreach(var_4 in self._id_3CE3.killstreaks) {}
    var_2[var_2.size] = var_4;

    self._id_3CE3.killstreaks = var_2;
  }

  _id_3CF1(var_1);
}

_id_3CF1(var_0) {
  var_1 = self._id_3CE3.killstreaks[0];
  var_2 = _id_3BC4(var_1);
  self giveweapon(var_2.weaponname);
  self setactionslot(4, "weapon", var_2.weaponname);

  if(var_1 == "remote_missile") {
    maps\_remotemissile::_id_3BE5(1, var_2.weaponname);
  }
  if(!isDefined(var_0) || !var_0) {
    thread maps\_utility::_id_11F4(var_2._id_3CEB);
  }
}

_id_3CF2(var_0) {
  var_1 = 0;

  foreach(var_5, var_3 in self._id_3CE3.killstreaks) {
    if(var_3 == var_0) {
      self._id_3CE3.killstreaks = common_scripts\utility::array_remove(self._id_3CE3.killstreaks, var_0);

      if(var_5 == 0) {
        var_4 = _id_3BC4(var_0);
        self takeweapon(var_4.weaponname);
      }

      var_1 = 1;
      break;
    }
  }

  if(_id_3CF3()) {
    _id_3CF1();
  }
}

_id_3CF3() {
  return self._id_3CE3.killstreaks.size;
}

_id_3CF4(var_0) {
  if(_id_3CF3()) {
    foreach(var_2 in self._id_3CE3.killstreaks) {
      if(var_0 == var_2) {
        return 1;
      }
    }
  }

  return 0;
}

_id_3CF5() {
  self endon("death");

  for(;;) {
    self._id_3CE3._id_3CF6 = self getcurrentweapon();
    self waittill("weapon_change", var_0);

    if(!isalive(self)) {
      continue;
    }
    var_1 = self._id_3CE3.killstreaks[0];

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = _id_3BC4(var_1);

    if(isDefined(var_2.weaponname)) {
      if(var_0 != var_2.weaponname) {
        continue;
      }
    }

    waittillframeend;
    var_3 = _id_3CF7(var_2);

    if(var_3) {
      _id_3CF8(var_2);
      _id_3CF2(var_1);
    } else if(!isDefined(self._id_00D3) || !self._id_00D3) {
      _id_3CF9();
    }
    if(maps\_utility::_id_12DC()) {
      wait 0.05;

      if(isDefined(self._id_3CAF) && self._id_3CAF) {
        _id_3BBF(var_1, 1);
      }
    }

    if(self getcurrentweapon() == "none") {
      while(self getcurrentweapon() == "none") {
        wait 0.05;
      }
      waittillframeend;
    }
  }
}

_id_3CF7(var_0) {
  var_1 = var_0.streaktype;

  if(!self isonground() && iscarrykillstreak(var_1)) {
    return 0;
  }
  if(isusingremote()) {
    return 0;
  }
  if(isDefined(self.selectinglocation)) {
    return 0;
  }
  if(self isusingturret() && (isridekillstreak(var_1) || iscarrykillstreak(var_1))) {
    iprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
    return 0;
  }

  if(maps\_utility::_id_133C("laststand_downed") && maps\_utility::_id_1008("laststand_downed") && isridekillstreak(var_1)) {
    iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
    return 0;
  }

  if(!common_scripts\utility::isweaponenabled()) {
    return 0;
  }
  if(!self[[var_0._id_3CE9]](var_0)) {
    return 0;
  }
  return 1;
}

_id_3CF8(var_0) {
  self playlocalsound("weap_c4detpack_trigger_plr");

  if(isDefined(var_0._id_3CEC) && var_0.streaktype != "remote_missile") {
    thread maps\_utility::_id_11F4(var_0._id_3CEC);
  }
}

_id_3CF9() {
  if(maps\_utility::_id_1A43(self)) {
    return;
  }
  if(isDefined(self._id_3CE3._id_3CF6)) {
    if(self._id_3CE3._id_3CF6 == "none") {
      var_0 = self getweaponslistprimaries();
      self switchtoweapon(var_0[0]);
    } else {
      self switchtoweapon(self._id_3CE3._id_3CF6);
    }
  }
}

_id_3CFA(var_0) {
  var_1 = var_0.weaponname;
  self._id_3CFB = 0;
  thread _id_3CFC(var_0._id_3CEC);

  while(self._id_3B10) {
    wait 0.05;
  }
  self notify("stopped_using_uav");
  return self._id_3CFB;
}

_id_3CFC(var_0) {
  self endon("stopped_using_uav");
  self waittill("player_fired_remote_missile");
  self._id_3CFB = 1;
  thread maps\_utility::_id_11F4(var_0);
}

_id_3CFD(var_0) {
  var_1 = _id_3CFE(var_0);
  var_2 = _id_0614::_id_3BA3(var_1);

  if(!var_2) {
    return 0;
  }
  return 1;
}

_id_3CFE(var_0) {
  if(issubstr(var_0.streaktype, "specialty_")) {
    return var_0.streaktype;
  }
  if(var_0.streaktype == "carepackage_c4") {
    return "carepackage_c4";
  } else if(var_0.streaktype == "carepackage_remote_missile") {
    return "remote_missile";
  } else if(var_0.streaktype == "carepackage_sentry") {
    return "sentry";
  } else if(var_0.streaktype == "carepackage_ammo") {
    return "carepackage_ammo";
  } else if(var_0.streaktype == "carepackage_precision_airstrike") {
    return "precision_airstrike";
  } else if(var_0.streaktype == "carepackage_stealth_airstrike") {
    return "stealth_airstrike";
  }
  var_1 = [];
  var_2 = [];
  var_1[var_1.size] = "sentry";
  var_2["sentry"] = 5;
  var_1[var_1.size] = "remote_missile";
  var_2["remote_missile"] = 15;
  var_1[var_1.size] = "precision_airstrike";
  var_2["precision_airstrike"] = 10;
  var_1[var_1.size] = "stealth_airstrike";
  var_2["stealth_airstrike"] = 10;
  var_1[var_1.size] = "carepackage_c4";
  var_2["carepackage_c4"] = 5;
  var_1[var_1.size] = "carepackage_ammo";
  var_2["carepackage_ammo"] = 5;
  return _id_0BC0(var_1, var_2);
}

_id_3CFF() {
  self playlocalsound("ammo_crate_use");
  refillammo();
}

refillammo() {
  var_0 = self getweaponslistall();

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "grenade")) {
      if(self getammocount(var_2) >= 1) {
        continue;
      }
    }

    self givemaxammo(var_2);
  }
}

_id_3D00(var_0) {
  thread _id_0615::_id_3C53(var_0);
}

_id_3D01() {
  if(!self hasweapon("c4")) {
    self giveweapon("c4");
    self setactionslot(2, "weapon", "c4");
  } else {
    if(self getfractionmaxammo("c4") == 1) {
      return;
    }
    var_0 = self getweaponammostock("c4");
    self setweaponammostock("c4", var_0 + 4);
  }
}

_id_3D02(var_0) {
  common_scripts / _sentry::givesentry("sentry_minigun");
  thread _id_3D04();
  self notifyonplayercommand("controller_sentry_cancel", "+actionslot 4");
  self notifyonplayercommand("controller_sentry_cancel", "weapnext");
  common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled");
  _id_3CF9();
  return 1;
}

_id_3D03(var_0) {
  common_scripts / _sentry::givesentry("sentry_gun");
  thread _id_3D04();
  self notifyonplayercommand("controller_sentry_cancel", "+actionslot 4");
  self notifyonplayercommand("controller_sentry_cancel", "weapnext");
  common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled");
  _id_3CF9();
  return 1;
}

_id_3D04() {
  self endon("sentry_placement_canceled");
  self endon("sentry_placement_finished");
  self waittill("controller_sentry_cancel");

  if(!isDefined(self._id_00D3) || !self._id_00D3) {
    self notify("sentry_placement_canceled");
  }
}

_id_3D05(var_0) {
  var_1 = var_0.streaktype;
  var_2 = "default";

  if(var_1 == "precision_airstrike") {
    var_2 = "precision";
  } else if(var_1 == "stealth_airstrike") {
    var_2 = "stealth";
  }
  var_3 = _id_0617::_id_3CD9(var_2);
  _id_3CF9();
  return var_3;
}

isusingremote() {
  return isDefined(self.usingremote);
}

isridekillstreak(var_0) {
  switch (var_0) {
    case "predator_missile":
    case "helicopter_mk19":
    case "helicopter_minigun":
    case "ac130":
      return 1;
    default:
      return 0;
  }
}

iscarrykillstreak(var_0) {
  switch (var_0) {
    case "sentry_gl":
    case "sentry":
      return 1;
    default:
      return 0;
  }
}

deadlykillstreak(var_0) {
  switch (var_0) {
    case "harrier_airstrike":
    case "predator_missile":
    case "stealth_airstrike":
    case "precision_airstrike":
    case "ac130":
      return 1;
  }

  return 0;
}

_id_0BC0(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(var_1[var_5] <= 0) {
      continue;
    }
    var_6 = randomint(var_1[var_5]);

    if(isDefined(var_2) && var_1[var_2] >= 100) {
      if(var_1[var_5] < 100) {
        continue;
      }
    } else {
      if(var_1[var_5] >= 100) {
        var_2 = var_5;
        var_3 = var_6;
        continue;
      }

      if(var_6 > var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}