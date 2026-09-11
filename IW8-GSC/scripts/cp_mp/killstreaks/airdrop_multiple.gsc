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
  var0 = "care_package_drop_multiple";
  var1 = undefined;
  var1 = "ac130";
  level.scr_animtree[var1] = #animtree;
  level.scr_anim[var1][var0] = $mp_eadrop_acharlie130;
  level.scr_animname[var1][var0] = "mp_eadrop_acharlie130";
  var1 = "care_package_1";
  level.scr_animtree[var1] = #animtree;
  level.scr_anim[var1][var0] = % mp_eadrop_cpkg_01;
  level.scr_animname[var1][var0] = "mp_eadrop_cpkg_01";
  var1 = "care_package_2";
  level.scr_animtree[var1] = #animtree;
  level.scr_anim[var1][var0] = % mp_eadrop_cpkg_02;
  level.scr_animname[var1][var0] = "mp_eadrop_cpkg_02";
  var1 = "care_package_3";
  level.scr_animtree[var1] = #animtree;
  level.scr_anim[var1][var0] = % mp_eadrop_cpkg_03;
  level.scr_animname[var1][var0] = "mp_eadrop_cpkg_03";
  var1 = "care_package_chute_1";
  level.scr_animtree[var1] = #animtree;
  level.scr_anim[var1][var0] = % mp_eadrop_parachute_01;
  level.scr_animname[var1][var0] = "mp_eadrop_parachute_01";
  var1 = "care_package_chute_2";
  level.scr_animtree[var1] = #animtree;
  level.scr_anim[var1][var0] = % mp_eadrop_parachute_02;
  level.scr_animname[var1][var0] = "mp_eadrop_parachute_02";
  var1 = "care_package_chute_3";
  level.scr_animtree[var1] = #animtree;
  level.scr_anim[var1][var0] = % mp_eadrop_parachute_03;
  level.scr_animname[var1][var0] = "mp_eadrop_parachute_03";
}

function airdrop_multiple_dropcrates(var0, var1, var2, var3, var4, var5) {
  if(level.cratedropdata.ac130s.size >= 2) {
    if(isDefined(var0) && isDefined(var5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
        var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var5.mpstreaksysteminfo, "other");
      }
    }

    return;
  }

  var6 = [];
  var7 = scripts\engine\utility::ter_op(isDefined(var0), "killstreak", "killstreak_no_owner");
  var8 = 3;
  var9 = undefined;

  if(isDefined(var5.cratetype)) {
    var7 = var5.cratetype;
  }

  if(isDefined(var5.numcrates)) {
    var8 = var5.numcrates;
  }

  if(isDefined(var5.usephysics)) {
    var9 = var5.usephysics;
  }

  for(var10 = 0; var10 < var8; var10++) {
    var11 = undefined;

    if(var6.size > 0) {
      var11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(var6);
    } else {
      var11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
    }

    var6 = var11;
  }

  var12 = airdrop_multiple_getcratedropcaststart(var2);
  var13 = var3 * (0, 1, 0);

  if(isDefined(var5.scenenodeoffset) && isvector(var5.scenenodeoffset)) {
    var12 += var5.scenenodeoffset;
  }

  var14 = spawn("script_model", var12);
  var14.angles = var13;
  var14 setModel("tag_origin");
  var14.owner = var0;
  var14.team = var1;
  var14.hasowner = isDefined(var0);
  var14.latestanimendtime = -1;
  var0 thread scripts\cp_mp\killstreaks\airdrop::br_c130spawndone(var5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), "used_airdrop_multiple", var0);
  }

  airdrop_multiple_createac130(var14);
  var14.crates = [];
  var14.chutes = [];

  for(var10 = 0; var10 < var8; var10++) {
    var15 = undefined;

    switch (var10) {
      case 0:
        var15 = "care_package_1";
        break;
      case 1:
        var15 = "care_package_2";
        break;
      case 2:
        var15 = "care_package_3";
        break;
    }

    var16 = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(var6[var10], 0);
    var17 = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(var0, var1, var7, var4, var9, 0, var16, var5, var14, var15, "care_package_drop_multiple");

    if(!isDefined(var17)) {
      break;
    }

    var15 = undefined;

    switch (var10) {
      case 0:
        var15 = "care_package_chute_1";
        break;
      case 1:
        var15 = "care_package_chute_2";
        break;
      case 2:
        var15 = "care_package_chute_3";
        break;
    }

    if(isDefined(var17)) {
      var18 = scripts\cp_mp\killstreaks\airdrop::createchuteforscripteddrop(var14, var17, var15, "care_package_drop_multiple");
      var18 setscriptablepartstate("visibility", "hide", 0);
    }
  }

  if(var14.crates.size < var8) {
    thread airdrop_multiple_watchdropcratesend();
    return undefined;
  }

  thread airdrop_multiple_watchdropcrates();
  return var14;
}

function airdrop_multiple_watchdropcrates() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.ac130, "care_package_drop_multiple");

  foreach(var1 in self.crates) {
    scripts\common\anim::anim_first_frame_solo(var1, "care_package_drop_multiple");
  }

  foreach(var4 in self.chutes) {
    scripts\common\anim::anim_first_frame_solo(var4, "care_package_drop_multiple");
  }

  airdrop_multiple_watchdropcratesinternal();
  thread airdrop_multiple_watchdropcratesend();
}

function airdrop_multiple_watchdropcratesinternal() {
  var0 = undefined;

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

    if(!isDefined(var0)) {
      var0 = 1;
    } else {
      jumpiffalse(var0) LOC_00000141;
      jumpiffalse(isDefined(self.ac130)) LOC_0000008f;
      thread airdrop_multiple_ac130firstframe();
      thread scripts\common\anim::anim_single_solo(self.ac130, "care_package_drop_multiple");

      foreach(var2 in self.crates) {
        if(isDefined(var2)) {
          var2.friendlymodel setscriptablepartstate("visibility", "show", 0);

          if(isDefined(var2.enemymodel)) {
            var2.enemymodel setscriptablepartstate("visibility", "show", 0);
          }

          thread scripts\common\anim::anim_single_solo(var2, "care_package_drop_multiple");
        }
      }

      foreach(var5 in self.chutes) {
        if(isDefined(var5)) {
          var5 show();
          thread scripts\common\anim::anim_single_solo(var5, "care_package_drop_multiple");
        }
      }

      var0 = 0;
      goto LOC_00000340;
    }

    waitframe();
  }
}

function airdrop_multiple_watchdropcratesend() {
  if(isDefined(self.ac130)) {
    thread airdrop_multiple_destroyac130();
  }

  foreach(var1 in self.crates) {
    if(isDefined(var1)) {
      var1 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }

  foreach(var4 in self.chutes) {
    if(isDefined(var4)) {
      var4 thread scripts\cp_mp\killstreaks\airdrop::destroychute();
    }
  }

  self delete();
}

function airdrop_multiple_createac130(var0) {
  var1 = spawn("script_model", var0.origin);
  var1.angles = var0.angles;
  var1.owner = var0.owner;
  var1.team = var0.team;
  var1.scenenode = var0;
  var0.ac130 = var1;
  var1 setModel("veh8_mil_air_acharlie130_ks_carrier");
  var1 scriptmoveroutline();
  var1 scriptmoverthermal();
  var1 setotherent(var0.owner);
  var1 setentityowner(var0.owner);
  var1 hide();
  airdrop_multiple_addac130tolist(var1);
  var1.animname = "ac130";
  var1 scripts\common\anim::setanimtree();
  var2 = level.scr_anim["ac130"]["care_package_drop_multiple"];
  var1.animendtime = gettime() + getanimlength(var2) * 1000;
  var0.latestanimendtime = scripts\engine\utility::ter_op(var1.animendtime > var0.latestanimendtime, var1.animendtime, var0.latestanimendtime);
  var3 = -1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var3 = var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", var0.team, 1, 1, 1);
  }

  if(var3 != -1) {
    var1.minimapid = var3;
  }

  return var1;
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

function airdrop_multiple_deleteac130(var0) {
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

  if(isDefined(var0) && var0 > 0) {
    wait var0;
  }

  self delete();
}

function airdrop_multiple_ac130handledamage(var0) {
  if(isDefined(var0.attacker) && isPlayer(var0.attacker)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
      var0.attacker[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("");
    }
  }

  return false;
}

function airdrop_multiple_ac130handlefataldamage(var0) {
  if(isPlayer(var0.attacker)) {
    var1 = 0;

    if(level.teambased && var0.attacker.team == self.team) {
      var1 = 1;
    } else if(var0.attacker == self.owner) {
      var1 = 1;
    }

    if(!var1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
        GscBinSkip1(0x74, scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash"), "callout_destroyed_ac130", var0.attacker);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
        var0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("kill", var0.objweapon, 400);
      }
    }
  }

  airdrop_multiple_destroyac130();
}

function airdrop_multiple_getcratedropcaststart(var0) {
  var0 *= (1, 1, 0);
  var0 += (0, 0, scripts\cp_mp\killstreaks\airdrop::getscriptedhelidropheightbase() + 200);
  var0 += (0, 0, level.cratedropdata.ac130s.size * 300);
  return var0;
}

function airdrop_multiple_getdropheight() {
  return level.cratedropdata.ac130height + level.cratedropdata.ac130s.size * level.cratedropdata.ac130heightoffset;
}

function airdrop_multiple_addac130tolist(var0) {
  var1 = var0 getentitynumber();
  level.cratedropdata.ac130s[var1] = var0;
}

function airdrop_multiple_removeac130fromlist(var0) {
  level.cratedropdata.ac130s[var0] = undefined;
}