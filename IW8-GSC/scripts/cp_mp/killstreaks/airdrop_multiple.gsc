/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\airdrop_multiple.gsc
**********************************************************/

function airdrop_multiple_init() {
  level.cratedropdata.ac130s = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_multiple", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_multiple", "init")]]();
  }

  airdrop_multiple_initanimations();
}

#using_animtree("");

function airdrop_multiple_initanimations() {
  var_0 = "care_package_drop_multiple";
  var_1 = undefined;
  var_1 = "ac130";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = $mp_eadrop_acharlie130;
  level.scr_animname[var_1][var_0] = "mp_eadrop_acharlie130";
  var_1 = "care_package_1";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % mp_eadrop_cpkg_01;
  level.scr_animname[var_1][var_0] = "mp_eadrop_cpkg_01";
  var_1 = "care_package_2";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % mp_eadrop_cpkg_02;
  level.scr_animname[var_1][var_0] = "mp_eadrop_cpkg_02";
  var_1 = "care_package_3";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % mp_eadrop_cpkg_03;
  level.scr_animname[var_1][var_0] = "mp_eadrop_cpkg_03";
  var_1 = "care_package_chute_1";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % mp_eadrop_parachute_01;
  level.scr_animname[var_1][var_0] = "mp_eadrop_parachute_01";
  var_1 = "care_package_chute_2";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % mp_eadrop_parachute_02;
  level.scr_animname[var_1][var_0] = "mp_eadrop_parachute_02";
  var_1 = "care_package_chute_3";
  level.scr_animtree[var_1] = #animtree;
  level.scr_anim[var_1][var_0] = % mp_eadrop_parachute_03;
  level.scr_animname[var_1][var_0] = "mp_eadrop_parachute_03";
}

function airdrop_multiple_dropcrates(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(level.cratedropdata.ac130s.size >= 2) {
    if(isDefined(var_0) && isDefined(var_5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var_5.mpstreaksysteminfo, "other");
      }
    }

    return;
  }

  var_6 = [];
  var_7 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_8 = 3;
  var_9 = undefined;

  if(isDefined(var_5.cratetype)) {
    var_7 = var_5.cratetype;
  }

  if(isDefined(var_5.numcrates)) {
    var_8 = var_5.numcrates;
  }

  if(isDefined(var_5.usephysics)) {
    var_9 = var_5.usephysics;
  }

  for(var_10 = 0; var_10 < var_8; var_10++) {
    var_11 = undefined;

    if(var_6.size > 0) {
      var_11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(var_6);
    } else {
      var_11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
    }

    var_6 = var_11;
  }

  var_12 = airdrop_multiple_getcratedropcaststart(var_2);
  var_13 = var_3 * (0, 1, 0);

  if(isDefined(var_5.scenenodeoffset) && isvector(var_5.scenenodeoffset)) {
    var_12 += var_5.scenenodeoffset;
  }

  var_14 = spawn("script_model", var_12);
  var_14.angles = var_13;
  var_14 setModel("tag_origin");
  var_14.owner = var_0;
  var_14.team = var_1;
  var_14.hasowner = isDefined(var_0);
  var_14.latestanimendtime = -1;
  var_0 thread scripts\cp_mp\killstreaks\airdrop::br_c130spawndone(var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), "used_airdrop_multiple", var_0);
  }

  airdrop_multiple_createac130(var_14);
  var_14.crates = [];
  var_14.chutes = [];

  for(var_10 = 0; var_10 < var_8; var_10++) {
    var_15 = undefined;

    switch (var_10) {
      case 0:
        var_15 = "care_package_1";
        break;
      case 1:
        var_15 = "care_package_2";
        break;
      case 2:
        var_15 = "care_package_3";
        break;
    }

    var_16 = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(var_6[var_10], 0);
    var_17 = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(var_0, var_1, var_7, var_4, var_9, 0, var_16, var_5, var_14, var_15, "care_package_drop_multiple");

    if(!isDefined(var_17)) {
      break;
    }

    var_15 = undefined;

    switch (var_10) {
      case 0:
        var_15 = "care_package_chute_1";
        break;
      case 1:
        var_15 = "care_package_chute_2";
        break;
      case 2:
        var_15 = "care_package_chute_3";
        break;
    }

    if(isDefined(var_17)) {
      var_18 = scripts\cp_mp\killstreaks\airdrop::createchuteforscripteddrop(var_14, var_17, var_15, "care_package_drop_multiple");
      var_18 setscriptablepartstate("visibility", "hide", 0);
    }
  }

  if(var_14.crates.size < var_8) {
    thread airdrop_multiple_watchdropcratesend();
    return undefined;
  }

  thread airdrop_multiple_watchdropcrates();
  return var_14;
}

function airdrop_multiple_watchdropcrates() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.ac130, "care_package_drop_multiple");

  foreach(var_1 in self.crates) {
    scripts\common\anim::anim_first_frame_solo(var_1, "care_package_drop_multiple");
  }

  foreach(var_4 in self.chutes) {
    scripts\common\anim::anim_first_frame_solo(var_4, "care_package_drop_multiple");
  }

  airdrop_multiple_watchdropcratesinternal();
  thread airdrop_multiple_watchdropcratesend();
}

function airdrop_multiple_watchdropcratesinternal() {
  var_0 = undefined;

  while(gettime() <= self.latestanimendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team) {
              self.ownerjoinedteam = 1;
            }
          }
        } else {
          self.ownerdisconnected = 1;
        }
      }
    }

    if(!isDefined(var_0)) {
      var_0 = 1;
    } else {
      jumpiffalse(var_0) LOC_00000141;
      jumpiffalse(isDefined(self.ac130)) LOC_0000008f;
      thread airdrop_multiple_ac130firstframe();
      thread scripts\common\anim::anim_single_solo(self.ac130, "care_package_drop_multiple");

      foreach(var_2 in self.crates) {
        if(isDefined(var_2)) {
          var_2.friendlymodel setscriptablepartstate("visibility", "show", 0);

          if(isDefined(var_2.enemymodel)) {
            var_2.enemymodel setscriptablepartstate("visibility", "show", 0);
          }

          thread scripts\common\anim::anim_single_solo(var_2, "care_package_drop_multiple");
        }
      }

      foreach(var_5 in self.chutes) {
        if(isDefined(var_5)) {
          var_5 show();
          thread scripts\common\anim::anim_single_solo(var_5, "care_package_drop_multiple");
        }
      }

      var_0 = 0;
      goto LOC_00000340;
    }

    waitframe();
  }
}

function airdrop_multiple_watchdropcratesend() {
  if(isDefined(self.ac130)) {
    thread airdrop_multiple_destroyac130();
  }

  foreach(var_1 in self.crates) {
    if(isDefined(var_1)) {
      var_1 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }

  foreach(var_4 in self.chutes) {
    if(isDefined(var_4)) {
      var_4 thread scripts\cp_mp\killstreaks\airdrop::destroychute();
    }
  }

  self delete();
}

function airdrop_multiple_createac130(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1.scenenode = var_0;
  var_0.ac130 = var_1;
  var_1 setModel("veh8_mil_air_acharlie130_ks_carrier");
  var_1 scriptmoveroutline();
  var_1 scriptmoverthermal();
  var_1 setotherent(var_0.owner);
  var_1 setentityowner(var_0.owner);
  var_1 hide();
  airdrop_multiple_addac130tolist(var_1);
  var_1.animname = "ac130";
  var_1 scripts\common\anim::setanimtree();
  var_2 = level.scr_anim["ac130"]["care_package_drop_multiple"];
  var_1.animendtime = gettime() + getanimlength(var_2) * 1000;
  var_0.latestanimendtime = scripts\engine\utility::ter_op(var_1.animendtime > var_0.latestanimendtime, var_1.animendtime, var_0.latestanimendtime);
  var_3 = -1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_3 = var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", var_0.team, 1, 1, 1);
  }

  if(var_3 != -1) {
    var_1.minimapid = var_3;
  }

  return var_1;
}

function airdrop_multiple_ac130firstframe() {
  self show();
  self playLoopSound("iw8_bradley_drop_c130");
  self setscriptablepartstate("lights2", "on", 0);
  self setscriptablepartstate("contrails", "on", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_multiple", "monitorDamage")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_multiple", "monitorDamage")]](1000, "hitequip", &airdrop_multiple_ac130handlefataldamage, &airdrop_multiple_ac130handledamage, 1);
    return;
  }
}

function airdrop_multiple_destroyac130() {
  airdrop_multiple_deleteac130();
}

function airdrop_multiple_deleteac130(var_0) {
  self notify("death");

  if(isDefined(self.scenenode)) {
    self.scenenode.ac130 = undefined;
  }

  airdrop_multiple_removeac130fromlist(self getentitynumber());
  self.scenenode = undefined;
  self.animendtime = undefined;
  self stoploopsound();

  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  self delete();
}

function airdrop_multiple_ac130handledamage(var_0) {
  if(isDefined(var_0.attacker) && isPlayer(var_0.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
      var_0.attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("");
    }
  }

  return false;
}

function airdrop_multiple_ac130handlefataldamage(var_0) {
  if(isPlayer(var_0.attacker)) {
    var_1 = 0;

    if(level.teambased && var_0.attacker.team == self.team) {
      var_1 = 1;
    } else if(var_0.attacker == self.owner) {
      var_1 = 1;
    }

    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
        GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), "callout_destroyed_ac130", var_0.attacker);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
        var_0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("kill", var_0.objweapon, 400);
      }
    }
  }

  airdrop_multiple_destroyac130();
}

function airdrop_multiple_getcratedropcaststart(var_0) {
  var_0 *= (1, 1, 0);
  var_0 += (0, 0, scripts\cp_mp\killstreaks\airdrop::getscriptedhelidropheightbase() + 200);
  var_0 += (0, 0, level.cratedropdata.ac130s.size * 300);
  return var_0;
}

function airdrop_multiple_getdropheight() {
  return level.cratedropdata.ac130height + level.cratedropdata.ac130s.size * level.cratedropdata.ac130heightoffset;
}

function airdrop_multiple_addac130tolist(var_0) {
  var_1 = var_0 getentitynumber();
  level.cratedropdata.ac130s[var_1] = var_0;
}

function airdrop_multiple_removeac130fromlist(var_0) {
  level.cratedropdata.ac130s[var_0] = undefined;
}