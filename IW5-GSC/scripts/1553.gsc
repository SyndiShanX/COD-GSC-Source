/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1553.gsc
**************************************/

sp_killstreaks_global_preload() {
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

sp_killstreaks_init() {
  level.ks = spawnStruct();
  level.ks.killstreaktypes = [];
  var_0 = common_scripts\utility::getStruct("map_center", "targetname");
  level.mapcenter = var_0.origin;
  common_scripts\utility::array_thread(level.players, ::sp_killstreaks_player_init);

  if(!maps/_sp_airdrop::sp_airdrop_init_done()) {
    maps/_sp_airdrop::sp_airdrop_init();
  }
  sp_killstreaks_hud_init();
  level.ks.globalinitdone = 1;
}

sp_killstreaks_hud_init() {
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

sp_killstreaks_init_done() {
  return isDefined(level.ks) && isDefined(level.ks.globalinitdone);
}

sp_killstreaks_player_init() {
  self.ks = spawnStruct();
  self.ks.killstreaks = [];
  thread sp_killstreak_use_waiter();

  if(!isDefined(self.remotemissile_actionslot)) {
    self.remotemissile_actionslot = 4;
  }
  thread maps/_remotemissile_utility::remotemissile_no_autoreload();
}

add_sp_killstreak(var_0) {
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
    var_2 = ::sp_killstreak_carepackage_main;
    var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP";
    var_3 = "UK_1mc_achieve_carepackage";
    var_4 = "UK_1mc_use_carepackage";
    var_5 = "specialty_carepackage";
    var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
    var_9 = ::sp_killstreak_perk_crateopen;

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
        var_2 = ::sp_killstreak_carepackage_main;
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
        var_2 = ::sp_killstreak_carepackage_main;
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
        var_2 = ::sp_killstreak_autosentry_main;
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
        var_2 = ::sp_killstreak_autosentry_gl_main;
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
        var_2 = ::sp_killstreak_carepackage_main;
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
        var_2 = ::sp_killstreak_remotemissile_main;
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
        var_2 = ::sp_killstreak_carepackage_main;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_C4";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "hud_icon_c4";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP_C4";
        var_7 = "hud_icon_c4";
        var_8 = &"SP_KILLSTREAKS_C4_PICKUP";
        var_9 = ::sp_killstreak_c4_crateopen;
        break;
      case "carepackage_ammo":
        var_1 = "airdrop_marker_mp";
        var_2 = ::sp_killstreak_carepackage_main;
        var_10 = "SP_KILLSTREAKS_REWARDNAME_AIRDROP_AMMO";
        var_3 = "UK_1mc_achieve_carepackage";
        var_4 = "UK_1mc_use_carepackage";
        var_5 = "specialty_carepackage";
        var_6 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
        var_7 = "waypoint_ammo_friendly";
        var_8 = &"PLATFORM_RESUPPLY";
        var_9 = ::sp_killstreak_ammo_crateopen;
        break;
      case "carepackage_precision_airstrike":
        var_1 = "airdrop_marker_mp";
        var_2 = ::sp_killstreak_carepackage_main;
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
        var_2 = ::sp_killstreak_airstrike_main;
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
        var_2 = ::sp_killstreak_carepackage_main;
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
        var_2 = ::sp_killstreak_airstrike_main;
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
  var_11.streakfunc = var_2;
  var_11.menurewarddesc = var_10;
  var_11.achievevo = var_3;
  var_11.usevo = var_4;
  var_11.splashicon = var_5;
  var_11.splashhint = var_6;
  var_11.crateicon = var_7;
  var_11.cratehint = var_8;
  var_11.crateopenfunc = var_9;
  level.ks.killstreaktypes[var_0] = var_11;
  add_killstreak_radio_dialogue(var_3, var_4);
}

add_killstreak_radio_dialogue(var_0, var_1) {
  if(!isDefined(level.scr_radio)) {
    level.scr_radio = [];
  }
  var_2[0] = var_0;
  var_2[1] = var_1;

  foreach(var_4 in var_2) {
    if(!maps\_utility::array_contains(level.scr_radio, var_4) && isDefined(var_4)) {
      level.scr_radio[var_4] = var_4;
    }
  }
}

sp_killstreak_exists(var_0) {
  foreach(var_3, var_2 in level.ks.killstreaktypes) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

get_sp_killstreak_info(var_0) {
  var_1 = level.ks.killstreaktypes[var_0];
  return var_1;
}

give_sp_killstreak(var_0, var_1) {
  if(!isDefined(self.ks.killstreaks[0])) {
    self.ks.killstreaks[0] = var_0;
  } else {
    var_2 = [];
    var_2[0] = var_0;

    foreach(var_4 in self.ks.killstreaks) {}
    var_2[var_2.size] = var_4;

    self.ks.killstreaks = var_2;
  }

  activate_current_sp_killstreak(var_1);
}

activate_current_sp_killstreak(var_0) {
  var_1 = self.ks.killstreaks[0];
  var_2 = get_sp_killstreak_info(var_1);
  self giveweapon(var_2.weaponname);
  self setactionslot(4, "weapon", var_2.weaponname);

  if(var_1 == "remote_missile") {
    maps\_remotemissile::enable_uav(1, var_2.weaponname);
  }
  if(!isDefined(var_0) || !var_0) {
    thread maps\_utility::radio_dialogue(var_2.achievevo);
  }
}

take_sp_killstreak(var_0) {
  var_1 = 0;

  foreach(var_5, var_3 in self.ks.killstreaks) {
    if(var_3 == var_0) {
      self.ks.killstreaks = common_scripts\utility::array_remove(self.ks.killstreaks, var_0);

      if(var_5 == 0) {
        var_4 = get_sp_killstreak_info(var_0);
        self takeweapon(var_4.weaponname);
      }

      var_1 = 1;
      break;
    }
  }

  if(has_any_killstreak()) {
    activate_current_sp_killstreak();
  }
}

has_any_killstreak() {
  return self.ks.killstreaks.size;
}

has_killstreak(var_0) {
  if(has_any_killstreak()) {
    foreach(var_2 in self.ks.killstreaks) {
      if(var_0 == var_2) {
        return 1;
      }
    }
  }

  return 0;
}

sp_killstreak_use_waiter() {
  self endon("death");

  for(;;) {
    self.ks.lastweaponused = self getcurrentweapon();
    self waittill("weapon_change", var_0);

    if(!isalive(self)) {
      continue;
    }
    var_1 = self.ks.killstreaks[0];

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = get_sp_killstreak_info(var_1);

    if(isDefined(var_2.weaponname)) {
      if(var_0 != var_2.weaponname) {
        continue;
      }
    }

    waittillframeend;
    var_3 = sp_killstreak_use_pressed(var_2);

    if(var_3) {
      used_sp_killstreak(var_2);
      take_sp_killstreak(var_1);
    } else if(!isDefined(self.carrying_pickedup_sentry) || !self.carrying_pickedup_sentry) {
      post_killstreak_weapon_switchback();
    }
    if(maps\_utility::is_survival()) {
      wait 0.05;

      if(isDefined(self.sentry_placement_failed) && self.sentry_placement_failed) {
        give_sp_killstreak(var_1, 1);
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

sp_killstreak_use_pressed(var_0) {
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

  if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed") && isridekillstreak(var_1)) {
    iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
    return 0;
  }

  if(!common_scripts\utility::isweaponenabled()) {
    return 0;
  }
  if(!self[[var_0.streakfunc]](var_0)) {
    return 0;
  }
  return 1;
}

used_sp_killstreak(var_0) {
  self playlocalsound("weap_c4detpack_trigger_plr");

  if(isDefined(var_0.usevo) && var_0.streaktype != "remote_missile") {
    thread maps\_utility::radio_dialogue(var_0.usevo);
  }
}

post_killstreak_weapon_switchback() {
  if(maps\_utility::is_player_down(self)) {
    return;
  }
  if(isDefined(self.ks.lastweaponused)) {
    if(self.ks.lastweaponused == "none") {
      var_0 = self getweaponslistprimaries();
      self switchtoweapon(var_0[0]);
    } else {
      self switchtoweapon(self.ks.lastweaponused);
    }
  }
}

sp_killstreak_remotemissile_main(var_0) {
  var_1 = var_0.weaponname;
  self.remotemissilefired = 0;
  thread sp_killstreak_remotemissile_waitforfire(var_0.usevo);

  while(self.using_uav) {
    wait 0.05;
  }
  self notify("stopped_using_uav");
  return self.remotemissilefired;
}

sp_killstreak_remotemissile_waitforfire(var_0) {
  self endon("stopped_using_uav");
  self waittill("player_fired_remote_missile");
  self.remotemissilefired = 1;
  thread maps\_utility::radio_dialogue(var_0);
}

sp_killstreak_carepackage_main(var_0) {
  var_1 = sp_carepackage_select_reward(var_0);
  var_2 = maps/_sp_airdrop::sp_try_use_airdrop(var_1);

  if(!var_2) {
    return 0;
  }
  return 1;
}

sp_carepackage_select_reward(var_0) {
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
  return getweightedchanceroll(var_1, var_2);
}

sp_killstreak_ammo_crateopen() {
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

sp_killstreak_perk_crateopen(var_0) {
  thread maps/_so_survival_perks::give_perk(var_0);
}

sp_killstreak_c4_crateopen() {
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

sp_killstreak_autosentry_main(var_0) {
  common_scripts / _sentry::givesentry("sentry_minigun");
  thread sentry_cancel_notify();
  self notifyonplayercommand("controller_sentry_cancel", "+actionslot 4");
  self notifyonplayercommand("controller_sentry_cancel", "weapnext");
  common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled");
  post_killstreak_weapon_switchback();
  return 1;
}

sp_killstreak_autosentry_gl_main(var_0) {
  common_scripts / _sentry::givesentry("sentry_gun");
  thread sentry_cancel_notify();
  self notifyonplayercommand("controller_sentry_cancel", "+actionslot 4");
  self notifyonplayercommand("controller_sentry_cancel", "weapnext");
  common_scripts\utility::waittill_any("sentry_placement_finished", "sentry_placement_canceled");
  post_killstreak_weapon_switchback();
  return 1;
}

sentry_cancel_notify() {
  self endon("sentry_placement_canceled");
  self endon("sentry_placement_finished");
  self waittill("controller_sentry_cancel");

  if(!isDefined(self.carrying_pickedup_sentry) || !self.carrying_pickedup_sentry) {
    self notify("sentry_placement_canceled");
  }
}

sp_killstreak_airstrike_main(var_0) {
  var_1 = var_0.streaktype;
  var_2 = "default";

  if(var_1 == "precision_airstrike") {
    var_2 = "precision";
  } else if(var_1 == "stealth_airstrike") {
    var_2 = "stealth";
  }
  var_3 = maps/_sp_airstrike::try_use_airstrike(var_2);
  post_killstreak_weapon_switchback();
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

getweightedchanceroll(var_0, var_1) {
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