/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\safehouse\safehouse_guard.gsc
*********************************************************/

#using_animtree("");

function level_guardinit() {
  level.guard = spawnStruct();
  level.guard.ai = [];
  level.guard.civilians = [];
  level.guard.corpses = [];
  level.guard.alerted = spawnStruct();
  level.guard.alerted.ai = [];
  level.guard.alerted.volumes = [];
  level.guard.alerted.civilians = [];
  level.guard.alerted.civiliancowerindex = 0;
  level.guard.dialogue = spawnStruct();
  level.guard.dialogue.cooldown = [];
  level.guard.dialogue.voicemaxindex = 3;
  level.guard.dialogue.voicelastindex = 0;
  level.guard.reactionindex = 0;
  level.guard.proximitydata = spawnStruct();
  level.guard.proximitydata.warningnames = ["Look", "Suspicious", "Threat", "Melee", "Fight"];
  level.guard.proximitydata.warningfunctions = [ &level_guardactionlook, &level_guardactionsuspicious, &level_guardactionthreat, &level_guardactionmelee, &level_guardactionfight];
  level.guard.proximitydata.warningtimers = [0, 0, 1, 2, 2];
  level.guard.proximitydata.warningsounds = [undefined, "ui_stealth_threat_low_lp", "ui_stealth_threat_high_lp", "ui_stealth_threat_high_lp", "ui_stealth_threat_high_lp"];
  level.guard.proximitydata.warningcooldowntimers = [2, 3, 4, 4, undefined];
  level.guard.proximitydata.warningradiisq = [57600, 10000, 10000, 10000, 10000];
  level.guard.proximitydata.warningradiusoverridefunctions = [ &scripts\sp\maps\safehouse\safehouse_utility::get_script_radius, &scripts\sp\maps\safehouse\safehouse_utility::get_radius, &scripts\sp\maps\safehouse\safehouse_utility::get_radius, &scripts\sp\maps\safehouse\safehouse_utility::get_radius, &scripts\sp\maps\safehouse\safehouse_utility::get_radius];
  level.guard.proximitydata.warningrumbletypes = [undefined, "light_1s", "damage_light", "damage_heavy", "damage_heavy"];
  level.guard.proximitydata.warningcinderblockradii = [600, 40, 40, 40, 40];
  level.guard.proximitydata.warningsoundentities = [];
  level.guard.proximitydata.warningsoundindex = 0;

  for(var_0 = 0; var_0 < level.guard.proximitydata.warningnames.size; var_0++) {
    var_1 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
    var_1 linkTo(level.player);
    level.guard.proximitydata.warningsoundentities = scripts\engine\utility::array_add(level.guard.proximitydata.warningsoundentities, var_1);
  }

  level.scr_anim["level_guard"]["level_guardThreatToCasual"] = % reb_stl_alert_to_patrol;
  level.scr_anim["level_guard"]["level_guardCasualToThreat0"] = $reb_stl_trans_patrol_to_exposed_idle;
  level.scr_anim["level_guard"]["level_guardCasualToThreat1"] = % sh_003_soldier_idle_react03_spetz01;
  level.scr_anim["level_guard"]["level_guardCasualToThreat2"] = % sh_003_soldier_idle_react03_spetz02;
  level.scr_anim["level_guard"]["level_guardCasualToThreat3"] = % sh_003_soldier_idle_react03_spetz03;
  level.scr_anim["level_guard"]["level_guardIdle0"][0] = % reb_stl_patrol_idle02;
  level.scr_anim["level_guard"]["level_guardIdle1"][0] = % sh_003_soldier_idle01_spetz01;
  level.scr_anim["level_guard"]["level_guardIdle2"][0] = % sh_003_soldier_idle01_spetz02;
  level.scr_anim["level_guard"]["level_guardIdle3"][0] = % sh_003_soldier_idle01_spetz03;
  level.scr_anim["level_guard"]["level_guardIdleLook0"][0] = % reb_stl_patrol_idle02;
  level.scr_anim["level_guard"]["level_guardIdleLook1"][0] = % sh_003_soldier_idle01_b_spetz01;
  level.scr_anim["level_guard"]["level_guardIdleLook2"][0] = % sh_003_soldier_idle01_b_spetz02;
  level.scr_anim["level_guard"]["level_guardIdleLook3"][0] = % sh_003_soldier_idle01_b_spetz03;
  level.scr_anim["level_guard"]["level_guardMelee"] = % hm_grnd_red_exposed_stand_melee01_ar;
  var_2 = level_guardgetreactionanimations();

  foreach(var_5, var_4 in var_2) {
    level.scr_anim["level_guard"]["level_guardReact" + var_5] = var_4;
  }

  var_6 = level_guardgetcivilianalertedanimations();

  foreach(var_8 in var_6) {
    level.scr_anim["level_guardCivilian"]["level_guardCivilianAlerted" + var_5][0] = var_8;
  }

  thread level_guardplayerunsilencedshotlogic();
  thread level_guardplayerthrewoffhandlogic();
  thread level_guardfightalertguardslogic();
  thread level_guardfightalertnearbycivilianslogic();
  thread level_guardfightvolumealertcivilianslogic();
  thread level_guardallalertedcivilianslogic();
  scripts\engine\utility::flag_init("level_guardsStealthBroken");
  scripts\engine\utility::flag_init("level_guardsAllAlerted");
  scripts\engine\utility::flag_init("level_guardInstantDetectPlayer");
}

function level_guardlogic(var_0, var_1, var_2, var_3) {
  level endon("level_guardEndLogic");
  var_0 endon("level_guardEndLogic");
  var_0 endon("death");
  var_0 endon("start_context_melee");

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_0.script_count)) {
    var_0.script_count = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  level_guardaddai(var_0);
  var_0.guard = spawnStruct();
  var_0.guard.animationorigin = var_0 scripts\engine\utility::spawn_script_origin();
  thread level_guardcleanupanimationoriginlogic(var_0);

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
    var_0 scripts\engine\sp\utility::set_goalRadius(32);
    var_0 scripts\engine\sp\utility::set_ignoreall(1);
    var_0 scripts\engine\sp\utility::set_ignoreme(1);
    var_0.dontevershoot = 1;
    var_0.dontmelee = 1;
    var_0.diequietly = 1;
    var_0 actoraimassistoff();
    thread level_guarddoggrowllogic(var_0);
  } else {
    var_0 scripts\engine\sp\utility::set_ignoreall(1);
    var_0 scripts\engine\sp\utility::set_ignoreme(1);
    var_0 scripts\engine\sp\utility::set_goalRadius(32);
    var_0.noloot = 1;
    var_0.ignoresuppression = 1;
    var_0.disableplayeradsloscheck = 1;
    var_0.disablebulletwhizbyreaction = 1;
    var_0.disablelongdeath = 1;
    var_0.newenemyreactiondistsq = 0;
    var_0.diequietly = 1;
    var_0.script_forcegoal = 1;
    var_0.allowdeath = 1;
    var_0 scripts\engine\sp\utility::set_baseaccuracy(6);
    var_0 allowedstances("stand");
    var_0 scripts\engine\sp\utility::disable_long_death();
    var_0 scripts\engine\sp\utility::set_battlechatter(0);
    var_0 scripts\common\ai::set_gunpose("disable");
    var_0 scripts\common\utility::demeanor_override("casual_gun");
    var_0 scripts\engine\sp\utility::disable_surprise();
    var_0 enablescriptedlookat(0);

    if(istrue(var_3)) {
      level_guardassignweapon(var_0);
    }
  }

  var_0.guard.playermeleeseencount = 0;
  var_0.guard.playerjumpseencount = 0;
  var_0.guard.playerweapondrawnseencount = 0;
  var_0.guard.meleecount = 0;
  var_0.guard.playerseenproneduration = 0;
  level.guard.dialogue.voicelastindex = scripts\engine\math::wrap(0, level.guard.dialogue.voicemaxindex - 1, level.guard.dialogue.voicelastindex + 1);
  var_0.guard.voiceindex = level.guard.dialogue.voicelastindex;
  GscBinSkip4(0x35, var_0);
}

function level_guardplayerproximitylogic(var_0, var_1) {
  level endon("level_guardEndLogic");
  level endon("level_guardEndProximityLogic");
  var_0 endon("level_guardEndLogic");
  var_0 endon("death");
  var_0 endon("start_context_melee");
  var_0 endon("level_guardFight");
  var_0 endon("level_guardEndProximityLogic");
  var_0.guard.proximitydata = spawnStruct();
  var_0.guard.proximitydata.currentwarningindex = 0;
  var_0.guard.proximitydata.warningcooldowntime = 0;
  var_0.guard.proximitydata.previouswarningcooldowntime = 0;
  var_0.guard.proximitydata.playertimenearai = 0;
  var_0.guard.proximitydata.aicanseeplayer = 0;
  var_0.guard.proximitydata.aitoplayerdistancesq = 0;
  var_0.guard.proximitydata.playerinaiwarning = 0;
  var_0.guard.proximitydata.previousplayerorigin = level.player.origin;
  var_0.guard.proximitydata.previousplayertimenearai = 0;
  var_0.guard.proximitydata.originalorigin = var_0.origin;
  var_0.guard.proximitydata.originalangles = var_0.angles;
  var_0.guard.proximitydata.overridewarningindex = undefined;
  var_0.guard.proximitydata.previousoverridewarningindex = undefined;

  if(!istrue(var_1)) {
    var_0.animname = "level_guard";
  }

  if(!var_1 && level_isguardanimated(var_0)) {
    var_0 linkTo(var_0.guard.animationorigin);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var_0.guard.animationorigin, var_0, "level_guardIdle" + var_0.script_count);
    goto LOC_000001d4;
  }

  var_0.guard.animationorigin linkTo(var_0);

  for(;;) {
    var_0.guard.proximitydata.aitoplayerdistancesq = distancesquared(var_0.origin, level.player.origin);
    var_0.guard.proximitydata.aicanseeplayer = sighttracepassed(var_0 getEye(), level.player getEye(), 0, level.player, 1);
    var_2 = level_guardgethighestwarningguardwithinwarningsharerange(var_0);

    if(isDefined(var_0.guard.proximitydata.overridewarningindex)) {
      if(!scripts\engine\utility::is_equal(var_0.guard.proximitydata.overridewarningindex, var_0.guard.proximitydata.previousoverridewarningindex)) {
        var_3 = level.guard.proximitydata.warningfunctions[var_0.guard.proximitydata.overridewarningindex];
        GscBinSkip1(0x74, var_3, var_0, 1, var_1);
      }
    } else {
      if(isDefined(var_1.guard.proximitydata.previousoverridewarningindex)) {
        var_3 = level.guard.proximitydata.warningfunctions[var_1.guard.proximitydata.previousoverridewarningindex];
        GscBinSkip1(0x74, var_3, var_1, 0, var_2);
      }

      if(level_guardplayerproximityshouldforcemelee(var_2)) {
        level_guardplayerproximityforcemelee(var_2);
      } else if(level_guardplayerproximityshouldforcethreat(var_2)) {
        level_guardplayerproximityforcethreat(var_2);
      } else {
        level_guardplayerproximityinwarninglogic(var_2);
      }

      if(level_guardplayerproximityshouldincreasewarning(var_2)) {
        level_guardproximityincreasewarning(var_2, var_3);
      } else if(level_guardplayerproximityshouldcooldownwarning(var_2)) {
        level_guardplayerproximitycooldownwarning(var_2, var_3);
      }
    }

    var_2.guard.proximitydata.previousplayerorigin = level.player.origin;
    var_2.guard.proximitydata.previousplayertimenearai = var_2.guard.proximitydata.playertimenearai;
    var_2.guard.proximitydata.previousoverridewarningindex = var_2.guard.proximitydata.overridewarningindex;
    level.guard.proximitydata.playerwasholdingcinderblock = scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();
    waitframe();
  }
}

function level_guardplayerfightvolumecheck(var_0) {
  level endon("level_guardEndLogic");
  var_0 endon("level_guardEndLogic");
  var_0 endon("death");
  var_0 endon("start_context_melee");
  var_0 endon("level_guardFight");
  jumpiftrue(isDefined(var_0.script_linkto)) LOC_00000032;
  return;
}

function level_guardplayerproximityshouldforcemelee(var_0) {
  if(level.player islinked()) {
    return false;
  }

  if(level_guardislabordriver(var_0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon()) {
    return false;
  }

  var_1 = var_0.guard.proximitydata.currentwarningindex;
  var_2 = var_0.guard.proximitydata.aitoplayerdistancesq;
  var_3 = var_1 >= 3;

  if(var_3) {
    return false;
  }

  var_4 = var_2 <= 2025;

  if(!var_4) {
    return false;
  }

  return true;
}

function level_guardplayerproximityforcemelee(var_0) {
  var_0.guard.proximitydata.currentwarningindex = 3;
  var_0.guard.proximitydata.playertimenearai = level.guard.proximitydata.warningtimers[var_0.guard.proximitydata.currentwarningindex];
  var_0.guard.proximitydata.playerinaiwarning = 1;
}

function level_guardplayerproximityshouldforcethreat(var_0) {
  if(level.player islinked()) {
    return false;
  }

  if(level_guardislabordriver(var_0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon()) {
    return false;
  }

  var_1 = var_0.guard.proximitydata.currentwarningindex >= 2;

  if(var_1) {
    return false;
  }

  var_2 = istrue(var_0.script_dist_only);

  if(!var_2) {
    return false;
  }

  if(!var_0.guard.proximitydata.aicanseeplayer) {
    return false;
  }

  var_3 = var_0.angles;
  var_4 = var_0 getEye();
  var_5 = level.player getEye();
  var_6 = scripts\engine\utility::within_fov(var_4, var_3, var_5, 0);

  if(!var_6) {
    return false;
  }

  var_7 = var_0.guard.proximitydata.aitoplayerdistancesq;
  var_8 = var_0.script_dist_only * var_0.script_dist_only;
  var_9 = var_7 <= var_8;

  if(!var_9) {
    return false;
  }

  return true;
}

function level_isguardinforcethreatvolume(var_0) {
  var_1 = level_getguardforcethreatvolumes();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\engine\utility::get_linked_ents();

    if(scripts\engine\utility::array_contains(var_5, var_0)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
    }
  }

  if(!var_2.size) {
    return false;
  }

  foreach(var_8 in var_2) {
    if(level.player istouching(var_8)) {
      return true;
    }
  }

  return false;
}

function level_guardplayerproximityforcethreat(var_0) {
  var_0.guard.proximitydata.currentwarningindex = 2;
  var_0.guard.proximitydata.playertimenearai = level.guard.proximitydata.warningtimers[var_0.guard.proximitydata.currentwarningindex];
  var_0.guard.proximitydata.playerinaiwarning = 1;
}

function level_guardproximityforcetohigherwarning(var_0, var_1) {
  var_2 = var_1 - 1;
  var_0.guard.proximitydata.currentwarningindex = var_2;
  var_0.guard.proximitydata.playertimenearai = level.guard.proximitydata.warningtimers[var_2];
  var_0.guard.proximitydata.playerinaiwarning = 1;
}

function level_guardplayerproximityinwarninglogic(var_0) {
  var_1 = var_0.guard.proximitydata.currentwarningindex;
  var_2 = var_0.guard.proximitydata.aicanseeplayer;
  var_3 = var_0.guard.proximitydata.previousplayerorigin;
  var_4 = var_0.guard.proximitydata.aitoplayerdistancesq;
  var_5 = level.guard.proximitydata.warningradiusoverridefunctions[var_1];
  var_6 = [[var_5]](var_0);
  var_7 = level_guardislabordriver(var_0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();
  var_8 = level.guard.proximitydata.warningcinderblockradii[var_1];

  if(isDefined(var_8) && var_7) {
    var_9 = squared(var_8);
  } else if(isDefined(var_7)) {
    var_9 = squared(var_7);
  } else {
    var_9 = level.guard.proximitydata.warningradiisq[var_3];
  }

  var_10 = anglesToForward(var_2.angles);
  var_11 = vectorNormalize(level.player getEye() - var_2 getEye());
  var_12 = vectordot(var_11, var_10);
  var_13 = var_12 >= 0.34202;
  var_14 = var_6 <= var_9;
  var_15 = distancesquared(var_5, var_2.origin);
  var_16 = distancesquared(level.player.origin, var_2.origin);
  var_17 = var_16 > var_15;
  var_18 = level_guardisplayerinhiddenvolume();
  var_2.guard.proximitydata.playerinaiwarning = var_4 && var_13 && var_14 && !var_18;

  if(var_2.guard.proximitydata.playerinaiwarning) {
    var_22 = level.guard.proximitydata.warningrumbletypes[var_3];

    if(isDefined(var_22)) {
      level.player playRumbleOnEntity(var_22);
    }

    if(!var_17) {
      var_2.guard.proximitydata.playertimenearai += 0.05;
    }
  }

  var_23 = var_3 - 1;
  var_2.guard.proximitydata.previouswarningcooldowntime = var_2.guard.proximitydata.warningcooldowntime;

  if(var_23 >= 0) {
    var_24 = level.guard.proximitydata.warningradiusoverridefunctions[var_23];
    var_25 = [[var_24]](var_2);
    var_26 = level.guard.proximitydata.warningcinderblockradii[var_23];

    if(isDefined(var_26) && var_9) {
      var_27 = squared(var_26);
    } else if(isDefined(var_26)) {
      var_27 = squared(var_26);
    } else {
      var_27 = level.guard.proximitydata.warningradiisq[var_25];
    }

    var_28 = var_4.guard.proximitydata.aitoplayerdistancesq <= var_27;

    if(!var_6) {
      var_4.guard.proximitydata.warningcooldowntime = 0;
      return;
    }

    if(!var_28) {
      var_4.guard.proximitydata.warningcooldowntime = max(var_4.guard.proximitydata.warningcooldowntime - 0.05, 0);
      return;
    }

    return;
  }
}

function level_guardarenearbyguardsathigherwarning(var_0) {
  var_1 = level_guardgethighestwarningguardwithinwarningsharerange(var_0);
  return isDefined(var_1);
}

function level_guardgethighestwarningguardwithinwarningsharerange(var_0) {
  var_1 = level_guardgetguardswithinwarningsharerange(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.guard.proximitydata)) {
      continue;
    }

    var_5 = var_4.guard.proximitydata.currentwarningindex > var_0.guard.proximitydata.currentwarningindex;

    if(!var_5) {
      continue;
    }

    var_6 = var_4.guard.proximitydata.currentwarningindex - 1;
    var_7 = level.guard.proximitydata.warningradiusoverridefunctions[var_6];
    var_8 = [[var_7]](var_4);
    var_9 = level.guard.proximitydata.warningcinderblockradii[var_6];
    var_10 = level_guardislabordriver(var_4) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();

    if(isDefined(var_9) && var_10) {
      var_11 = squared(var_9);
    } else if(isDefined(var_8)) {
      var_11 = squared(var_8);
    } else {
      var_11 = level.guard.proximitydata.warningradiisq[var_6];
    }

    var_12 = var_4.guard.proximitydata.aitoplayerdistancesq <= var_11;

    if(!var_12) {
      continue;
    }

    var_2 = scripts\engine\utility::array_add(var_2, var_4);
  }

  if(!var_2.size) {
    return undefined;
  }

  var_14 = 0;
  var_15 = undefined;

  foreach(var_17 in var_2) {
    var_18 = var_17.guard.proximitydata.currentwarningindex;

    if(var_18 > var_14) {
      var_14 = var_18;
      var_15 = var_17;
    }
  }

  return var_15;
}

function level_guardgetguardswithinwarningsharerange(var_0) {
  var_1 = 400;
  var_2 = level_getguards();
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = distance(var_5.origin, var_0.origin);

    if(var_6 > var_1) {
      continue;
    }

    var_3 = scripts\engine\utility::array_add(var_3, var_5);
  }

  return var_3;
}

function level_guardplayerproximityshouldincreasewarning(var_0) {
  if(level.player islinked()) {
    return false;
  }

  if(level_guardisplayerinhiddenvolume()) {
    return false;
  }

  if(!var_0.guard.proximitydata.playerinaiwarning) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon() && !level.guard.proximitydata.playerwasholdingcinderblock) {
    return false;
  }

  var_1 = var_0.guard.proximitydata.currentwarningindex;
  var_2 = level.guard.proximitydata.warningtimers[var_1];

  if(var_0.guard.proximitydata.playertimenearai >= var_2) {
    return true;
  }

  return false;
}

function level_gethighestguardwarningindex(var_0) {
  var_1 = level_getguards();

  if(isDefined(var_0)) {
    var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  }

  var_2 = 0;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4.guard.proximitydata)) {
      continue;
    }

    if(var_4.guard.proximitydata.currentwarningindex <= var_2) {
      continue;
    }

    var_2 = var_4.guard.proximitydata.currentwarningindex;
  }

  return var_2;
}

function level_guardproximityincreasewarning(var_0, var_1) {
  var_2 = var_0.guard.proximitydata.currentwarningindex;
  var_3 = var_0.guard.proximitydata.aicanseeplayer;
  var_4 = var_0.guard.proximitydata.previousplayerorigin;
  var_5 = var_0.guard.proximitydata.aitoplayerdistancesq;
  var_6 = level.guard.proximitydata.warningfunctions[var_2];

  if(isDefined(var_6)) {
    GscBinSkip1(0x74, var_6, var_0, 1, var_1);
  }

  var_7 = level.guard.proximitydata.warningcooldowntimers[var_2];

  if(isDefined(var_7)) {
    var_0.guard.proximitydata.warningcooldowntime = level.guard.proximitydata.warningcooldowntimers[var_2];
  }

  var_8 = var_2 + 1;
  var_9 = level.guard.proximitydata.warningradiusoverridefunctions[var_8];
  var_10 = [[var_9]](var_0);
  var_11 = level_guardislabordriver(var_0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();
  var_12 = level.guard.proximitydata.warningcinderblockradii[var_8];

  if(isDefined(var_12) && var_11) {
    var_13 = squared(var_12);
  } else if(isDefined(var_11)) {
    var_13 = squared(var_11);
  } else {
    var_13 = level.guard.proximitydata.warningradiisq[var_10];
  }

  var_14 = var_7 <= var_13;
  var_2.guard.proximitydata.playertimenearai = 0;
  var_2.guard.proximitydata.previousplayertimenearai = 0;
  var_2.guard.proximitydata.currentwarningindex = var_10;
  var_15 = level.guard.proximitydata.warningsounds[var_4];

  if(isDefined(var_15) && var_4 > level.guard.proximitydata.warningsoundindex) {
    var_16 = level.guard.proximitydata.warningsoundentities[var_4];
    var_16 stoploopsound();
    var_16 scalevolume(1, 0.05);
    var_16 scripts\engine\utility::delaycall(0.05, &playloopsound, var_15);
    level.guard.proximitydata.warningsoundindex = var_4;
    thread level_guardcleanupwarningsoundondeathlogic(var_2);
    return;
  }
}

function level_guardcleanupwarningsoundondeathlogic(var_0) {
  var_0 endon("entitydeleted");
  var_0 endon("level_guardFight");
  var_0 waittill("death");
  var_1 = level_gethighestguardwarningindex(var_0);
  var_2 = var_0.guard.proximitydata.currentwarningindex - 1;
  var_3 = var_2 >= var_1;

  if(var_3) {
    foreach(var_5 in level.guard.proximitydata.warningsoundentities) {
      var_5 scalevolume(0, 1.5);
    }

    level.guard.proximitydata.warningsoundindex = 0;
    return;
  }
}

function level_guardplayerproximityshouldcooldownwarning(var_0) {
  var_1 = var_0.guard.proximitydata.currentwarningindex;

  if(level_guardplayerproximityshouldforcemelee(var_0)) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon() && !level.guard.proximitydata.playerwasholdingcinderblock) {
    return true;
  }

  var_2 = anglesToForward(var_0.angles);
  var_3 = vectorNormalize(level.player getEye() - var_0 getEye());
  var_4 = vectordot(var_3, var_2);
  var_5 = var_4 >= 0.34202;

  if(!var_5 && !var_0.guard.proximitydata.aicanseeplayer && var_0.guard.proximitydata.previouswarningcooldowntime) {
    return true;
  }

  var_6 = var_0.guard.proximitydata.previouswarningcooldowntime > var_0.guard.proximitydata.warningcooldowntime;

  if(!var_0.guard.proximitydata.warningcooldowntime && var_6) {
    return true;
  }

  return false;
}

function level_guardplayerproximitycooldownwarning(var_0, var_1) {
  var_2 = var_0.guard.proximitydata.currentwarningindex - 1;
  var_3 = level.guard.proximitydata.warningfunctions[var_2];

  if(isDefined(var_3)) {
    GscBinSkip1(0x74, var_3, var_0, 0, var_1);
  }

  var_4 = level_gethighestguardwarningindex(var_0);
  var_5 = var_2 >= var_4;

  if(var_5) {
    foreach(var_7 in level.guard.proximitydata.warningsoundentities) {
      var_7 scalevolume(0, 1.5);
    }

    level.guard.proximitydata.warningsoundindex = 0;
  }

  var_0.guard.proximitydata.currentwarningindex = 0;
  var_0.guard.proximitydata.playertimenearai = 0;
  var_0.guard.proximitydata.warningcooldowntime = 0;
  var_0.guard.proximitydata.previouswarningcooldowntime = 0;
}

function level_guardactionlook(var_0, var_1, var_2) {
  level endon("level_guardEndLogic");
  var_0 endon("level_guardEndLogic");
  var_0 endon("death");
  var_0 endon("start_context_melee");
  var_0 endon("level_guardFight");

  if(var_1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
      return;
    }

    var_0 enablescriptedlookat(1);

    if(!var_2 && level_isguardanimated(var_0)) {
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
      thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var_0.guard.animationorigin, var_0, "level_guardIdleLook" + var_0.script_count);
      return;
    }

    var_0.ht_on = 1;
    var_0 scripts\common\utility::lookatentity(level.player);
    return;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var_0, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var_0, 0);
    return;
  }

  var_0 enablescriptedlookat(0);

  if(!var_2 && level_isguardanimated(var_0)) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var_0.guard.animationorigin, var_0, "level_guardIdle" + var_0.script_count);
    return;
  }

  var_0.ht_on = undefined;
  var_0 scripts\common\utility::lookatentity();
}

function level_guardactionsuspicious(var_0, var_1, var_2) {
  level endon("level_guardEndLogic");
  var_0 endon("level_guardEndLogic");
  var_0 endon("death");
  var_0 endon("start_context_melee");
  var_0 endon("level_guardFight");

  if(var_1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var_0, 1);
      var_0 scripts\common\utility::lookatentity(level.player);
      var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var_0 scripts\engine\sp\utility::set_ignoreall(0);
      return;
    }

    var_0 enablescriptedlookat(1);

    if(!var_2 && level_isguardanimated(var_0)) {
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
      thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var_0.guard.animationorigin, var_0, "level_guardIdleLook" + var_0.script_count);
      return;
    }

    var_0.ht_on = 1;
    var_0 scripts\common\utility::lookatentity(level.player);
    return;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var_0, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var_0, 0);
    var_0 scripts\common\utility::lookatentity();
    var_0 scripts\engine\sp\utility::set_ignoreall(1);
    return;
  }

  var_0 enablescriptedlookat(0);

  if(!var_2 && level_isguardanimated(var_0)) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var_0.guard.animationorigin, var_0, "level_guardIdle" + var_0.script_count);
    return;
  }

  var_0.ht_on = undefined;
  var_0 scripts\common\utility::lookatentity();
}

function level_guardactionthreat(var_0, var_1, var_2) {
  level endon("level_guardEndLogic");
  var_0 endon("level_guardEndLogic");
  var_0 endon("death");
  var_0 endon("start_context_melee");
  var_0 endon("level_guardFight");

  if(var_1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var_0, 1);
      var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var_0 scripts\engine\sp\utility::set_ignoreall(0);
      return;
    }

    var_3 = var_0.script_dialogue;

    if(isDefined(var_3)) {
      var_4 = var_3;
    } else {
      jumpiffalse(level_guardislabordriver(var_1)) LOC_00000092;
      var_5 = level_guardgetlabordriverthreatlines();
      var_4 = var_5[var_1.guard.voiceindex];
      goto LOC_000000ad;
    }

    LOC_000000ad:
      level_guardplaydialogue(var_2, var_4, "threat");
    var_2 scripts\common\utility::clear_demeanor_override();
    var_2 enablescriptedlookat(0);

    if(!var_4 && level_isguardanimated(var_2)) {
      level_guardactionthreatanimationlogic(var_2, level.player.origin, var_4);
    }

    var_2.dontevershoot = 1;
    var_2.dontmelee = 1;
    var_2 notify("stop_going_to_node");
    var_2 setgoalpos(var_2.origin);
    var_2 scripts\engine\sp\utility::set_ignoreall(0);
    var_2 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    return;
  }

  var_4.script_count = 0;

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_4)) {
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var_4, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var_4, 0);
    var_4 scripts\engine\sp\utility::set_ignoreall(1);
    return;
  }

  var_4 scripts\common\utility::demeanor_override("casual_gun");
  var_7 = level_guardgetlaughlines();
  var_8 = var_7[var_4.guard.voiceindex];
  level_guardplaydialogue(var_4, var_8, "laugh", 15000);

  if(!var_4 && level_isguardanimated(var_4)) {
    var_4.guard.animationorigin.angles = var_4.angles;
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_4);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var_4.guard.animationorigin, var_4, "level_guardThreatToCasual", "level_guardIdle" + var_4.script_count);
  }

  var_4 scripts\engine\sp\utility::set_ignoreall(1);
  var_4.dontevershoot = 0;
  var_4.dontmelee = 0;

  if(isDefined(var_4.currentnode)) {
    var_4 thread scripts\sp\spawner::go_to_node_internal(var_4.currentnode);
    return;
  }
}

function level_guardgetlabordriverthreatlines() {
  return ["dx_vom_ru1_construction_soldiermen_10", "dx_vom_ru2_construction_soldiermen_60", "dx_vom_ru3_construction_soldiermen_80"];
}

function level_guardgetthreatlines() {
  return ["dx_vom_ru1_construction_soldiermen_10", "dx_vom_ru2_construction_soldierwomen_40", "dx_vom_ru3_construction_soldiermen_90"];
}

function level_guardactionthreatanimationlogic(var_0, var_1, var_2) {
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
  var_3 = scripts\engine\utility::flatten_vector(var_1 - var_0.origin);
  var_4 = vectortoangles(var_3);
  var_0.guard.animationorigin.origin = var_0.origin;
  var_0.guard.animationorigin.angles = var_0.angles;

  if(var_2 || !level_isguardanimated(var_0)) {
    var_0.guard.animationorigin unlink();
  }

  var_0 linkTo(var_0.guard.animationorigin);
  var_5 = "level_guardCasualToThreat" + var_0.script_count;
  var_6 = getanimlength(var_0 scripts\engine\utility::getanim(var_5));
  var_0.guard.animationorigin rotateTo(var_4, var_6);
  var_0.guard.animationorigin scripts\common\anim::anim_single_solo(var_0, var_5);
  var_0 unlink();

  if(var_2 || !level_isguardanimated(var_0)) {
    var_0.guard.animationorigin linkTo(var_0);
    return;
  }
}

function level_guardactionmelee(var_0, var_1, var_2) {
  level endon("level_guardEndLogic");
  var_0 endon("level_guardEndLogic");
  var_0 endon("death");
  var_0 endon("start_context_melee");
  var_0 endon("level_guardFight");

  if(var_1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var_0, 1);
      var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var_0 scripts\engine\sp\utility::set_ignoreall(0);
      return;
    }

    var_3 = level_guardgetmeleelines();
    var_4 = var_3[var_0.guard.voiceindex];
    level_guardplaydialogue(var_0, var_4, "melee");
    var_0 notify("stop_going_to_node");
    var_0 setgoalpos(var_0.origin);
    var_0 scripts\common\utility::clear_demeanor_override();
    var_0.dontevershoot = 1;
    var_0.dontmelee = 1;
    var_0 scripts\engine\sp\utility::set_ignoreall(0);
    var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var_0 scripts\common\utility::lookatentity();

    if(!level_guardplayerinmeleerange(var_0)) {
      return;
    }

    if(var_2) {
      return;
    }

    var_5 = scripts\engine\utility::flatten_vector(level.player.origin - var_0.origin);
    var_6 = vectortoangles(var_5);
    var_0.guard.animationorigin.origin = var_0.origin;
    var_0.guard.animationorigin.angles = var_6;
    var_0 stopanimScripted();
    var_0.animname = "level_guard";
    var_0.guard.animationorigin thread scripts\common\anim::anim_single_solo(var_0, "level_guardMelee");
    var_7 = getanimlength(var_0 scripts\engine\utility::getanim("level_guardMelee"));
    var_8 = 0.6;
    wait var_8;

    if(level_guardplayerinmeleerange(var_0)) {
      var_9 = vectorNormalize(level.player.origin - var_0.origin) * 200;
      level.player setvelocity(var_9);
      level.player scripts\sp\utility::do_damage(50, var_0.origin);
      level.player playSound("melee_character_vestlight_medium_steel_pri_0_fatal_plr");
      screenshake(var_0.origin, 21, 10, 12, 1.7, 0, 0.75, 0, 0.6, 0.6, 0.5);
      var_0.guard.meleecount++;

      if(var_0.guard.meleecount >= 2) {
        thread level_guardfight(var_0, 0);
        return;
      }

      return;
    }

    return;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_7)) {
    var_7.script_count = 0;
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var_7, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var_7, 0);
    var_7 scripts\engine\sp\utility::set_ignoreall(1);
    return;
  }

  var_7.script_count = 0;
  var_10 = level_guardgetlaughlines();
  var_11 = var_10[var_7.guard.voiceindex];
  level_guardplaydialogue(var_7, var_11, "laugh", 15000);
  var_7 scripts\common\utility::demeanor_override("casual_gun");

  if(!var_9 && level_isguardanimated(var_7)) {
    var_7.guard.animationorigin.angles = var_7.angles;
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_7);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var_7.guard.animationorigin, var_7, "level_guardThreatToCasual", "level_guardIdle" + var_7.script_count);
  }

  var_7 scripts\engine\sp\utility::set_ignoreall(1);
  var_7.dontevershoot = 0;
  var_7.dontmelee = 0;
  var_7 scripts\common\utility::lookatentity();
  var_7 unlink();

  if(isDefined(var_7.currentnode)) {
    var_7 thread scripts\sp\spawner::go_to_node_internal(var_7.currentnode);
    return;
  }
}

function level_guardgetmeleelines() {
  return ["dx_vom_ru1_market_soldierpush_30", "dx_vom_ru2_construction_soldiermen_50", "dx_vom_ru3_construction_soldierwomen_90"];
}

function level_guardgetlaughlines() {
  return ["dx_vom_ru1_construction_ruconvo1_100", "dx_vom_ru1_construction_ruconvo1_100", "dx_vom_ru1_construction_ruconvo1_100"];
}

function level_guardactionfight(var_0, var_1, var_2) {
  if(var_1) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
      var_3 = level_guardgetfightlines();
      var_4 = var_3[var_0.guard.voiceindex];
      level_guardplaydialogue(var_0, var_4, "fight");
    }

    scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(86);
    thread level_guardfight(var_0, 0);
    return;
  }
}

function level_guardgetfightlines() {
  return ["dx_cbc_ru1_reaction_hostile_burst", "dx_cbc_ru1_reaction_hostile_burst", "dx_cbc_ru1_reaction_hostile_burst"];
}

function level_guardplaydialogue(var_0, var_1, var_2, var_3) {
  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
    return;
  }

  if(!isDefined(level.guard.dialogue.cooldown[var_2])) {
    level.guard.dialogue.cooldown[var_2] = 0;
  }

  var_4 = gettime();

  if(var_4 < level.guard.dialogue.cooldown[var_2]) {
    return;
  }

  if(!isDefined(var_3)) {
    var_3 = 7000;
  }

  level.guard.dialogue.cooldown[var_2] = var_4 + var_3;

  if(!isDefined(var_0.animname)) {
    var_0.animname = "level_guard";
  }

  var_0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue(var_1);
}

function level_guardfightalertnearbyguards(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0.origin;
  var_7 = var_0 getEye();

  if(level.player ismeleeing()) {
    var_3 = 0;
  }

  var_8 = level_getguards();
  var_8 = scripts\engine\utility::array_remove(var_8, var_0);

  if(!var_8.size) {
    return;
  }

  var_8 = sortbydistance(var_8, var_6);

  foreach(var_10 in var_8) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isalive(var_10)) {
      continue;
    }

    var_11 = distance(var_6, var_10.origin);
    var_12 = var_11 <= 200;

    if(!var_12) {
      var_13 = var_10 getEye();
      var_14 = var_7;
      var_15 = sighttracepassed(var_13, var_14, 0, level.player, 1);

      if(!var_15) {
        continue;
      }

      var_16 = var_11 <= var_1;

      if(!var_16) {
        continue;
      }

      var_17 = abs(var_13[2] - var_14[2]);
      var_18 = var_17 < 100;

      if(var_4 && !var_18) {
        continue;
      }

      var_19 = anglesToForward(var_10.angles);
      var_20 = vectorNormalize(var_14 - var_13);
      var_21 = vectordot(var_20, var_19);
      var_22 = var_21 >= 0.34202;

      if(var_2 && !var_22) {
        continue;
      }
    }

    thread level_guardfight(var_10, var_3);
    var_23 = randomfloatrange(0.1, 0.2);
    wait var_23;
  }
}

function level_guardplayerweapondrawnlogic(var_0) {
  var_0 endon("level_guardFight");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.player scripts\engine\utility::spawn_script_origin();
  var_3 linkTo(level.player);
  thread level_guardplayerweapondrawncleanupsoundlogic(var_0, var_3);

  for(;;) {
    waitframe();

    if(!level_guardcanseeplayerdrawnweapon(var_0)) {
      if(var_1) {
        var_3 scalevolume(0, 1.5);
        var_1 = 0;
        var_0 scripts\common\utility::lookatentity();
      }

      var_2 = max(var_2 - 0.05, 0);
      continue;
    }

    level.player playRumbleOnEntity("damage_heavy");
    var_4 = distance(var_0.origin, level.player.origin);
    var_5 = var_4 <= 250;

    if(!var_2 && !var_5) {
      scripts\engine\sp\utility::display_hint_forced("holster_weapon", 5, undefined, level.player, "weapon_fired");
      var_3 scalevolume(1, 0);
      var_3 playLoopSound("ui_stealth_threat_high_lp");
      var_1 = 1;
      var_0.guard.playerweapondrawnseencount++;

      if(var_0.guard.playerweapondrawnseencount >= 3) {
        var_6 = scripts\sp\maps\safehouse\safehouse_utility::level_getsafehousecustomdeathhintindex();

        if(scripts\engine\utility::is_equal(var_6, 90)) {
          scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(87);
        } else {
          scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(85);
        }

        if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
          var_0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_cbc_ru2_combat_location_resp_crate", 0.25, var_0, "death");
        }

        thread level_guardfight(var_0, 0);
        return;
      }

      var_0 scripts\common\utility::lookatentity(level.player);
    }

    var_2 += 0.05;
    var_7 = scripts\engine\math::normalize_value(250, 950, var_4);
    var_8 = scripts\engine\math::factor_value(1, 3.5, var_7);
    var_9 = var_2 >= var_8;
    var_10 = level.player attackButtonPressed();

    if(var_5 || var_9 || var_10) {
      var_6 = scripts\sp\maps\safehouse\safehouse_utility::level_getsafehousecustomdeathhintindex();

      if(scripts\engine\utility::is_equal(var_6, 90)) {
        scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(87);
      } else {
        scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(85);
      }

      if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
        var_0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_cbc_ru2_combat_location_resp_crate", 0.2, var_0, "death");
      }

      thread level_guardfight(var_0, 0);
      break;
    }
  }
}

function level_guardplayerweapondrawncleanupsoundlogic(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any("level_guardFight", "damage", "death", "entitydeleted");
  var_1 thread scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
}

function level_guardplayergrenadethrowinglogic(var_0) {
  var_0 endon("level_guardFight");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.player scripts\engine\utility::spawn_script_origin();
  var_3 linkTo(level.player);
  thread level_guardplayergrenadethrowcleanupsoundlogic(var_0, var_3);

  for(;;) {
    waitframe();

    if(!level_guardcanseeplayergrenadethrowing(var_0)) {
      if(var_1) {
        var_3 scalevolume(0, 1.5);
        var_1 = 0;
        var_0 scripts\common\utility::lookatentity();
      }

      var_2 = max(var_2 - 0.05, 0);
      continue;
    }

    level.player playRumbleOnEntity("damage_heavy");
    var_4 = distancesquared(var_0.origin, level.player.origin);
    var_5 = var_4 <= 90000;

    if(!var_2 && !var_5) {
      var_6 = ["offhand_fired", "offhand_end", "actionslot 1"];
      scripts\engine\sp\utility::display_hint("holster_grenade", 5, undefined, level.player, var_6);
      var_3 scalevolume(1, 0);
      var_3 playLoopSound("ui_stealth_threat_high_lp");
      var_1 = 1;
      var_0 scripts\common\utility::lookatentity(level.player);
    }

    var_2 += 0.05;
    var_7 = scripts\engine\math::normalize_value(90000, 1690000, var_4);
    var_8 = scripts\engine\math::factor_value(1, 4, var_7);
    var_9 = var_2 >= var_8;
    GscBinSkip4(0x35, var_0);
  }
}

function level_guardplayergrenadethrowcleanupsoundlogic(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any("level_guardFight", "damage", "death", "entitydeleted");
  var_1 thread scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
}

function level_guardseeplayergrenadethrowlogic(var_0) {
  level endon("level_guardEndLogic");
  level.player endon("offhand_end");
  var_0 endon("level_guardEndLogic");
  level.player waittill("offhand_fired");
  level_guardsawplayergrenadealertlogic(var_0);
}

function level_guardsawplayergrenadealertlogic(var_0) {
  scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(96);

  if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
    var_0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_cbc_ru2_combat_location_resp_crate", 0.25, var_0, "death");
  }

  thread level_guardfight(var_0, 0);
}

function level_guardcanseeplayerdrawnweapon(var_0) {
  if(scripts\sp\maps\safehouse\safehouse::player_holdingemptyweapon()) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse::player_holdingholsteredweapon()) {
    return false;
  }

  if(level.player isswitchingweapon()) {
    return false;
  }

  if(level.player isonladder()) {
    return false;
  }

  if(scripts\engine\utility::flag("level_guardInstantDetectPlayer")) {
    return false;
  }

  var_1 = distance(var_0.origin, level.player.origin);
  var_2 = var_1 <= 950;

  if(!var_2) {
    return false;
  }

  var_3 = var_0 getEye();
  var_4 = level.player getEye();
  var_5 = sighttracepassed(var_3, var_4, 0, level.player, 1);

  if(!var_5) {
    return false;
  }

  var_6 = anglesToForward(var_0.angles);
  var_7 = vectorNormalize(var_4 - var_3);
  var_8 = vectordot(var_7, var_6);

  if(var_1 <= 250) {
    var_9 = 0.34202;
  } else {
    var_9 = 0.819152;
  }

  var_10 = var_9 >= var_9;

  if(!var_10) {
    return false;
  }

  return true;
}

function level_guardcanseeplayergrenadethrowing(var_0) {
  if(!level.player isthrowinggrenade()) {
    return false;
  }

  var_1 = distance(var_0.origin, level.player.origin);
  var_2 = var_1 <= 950;

  if(!var_2) {
    return false;
  }

  var_3 = var_0 getEye();
  var_4 = level.player getEye();
  var_5 = sighttracepassed(var_3, var_4, 0, level.player, 1);

  if(!var_5) {
    return false;
  }

  var_6 = anglesToForward(var_0.angles);
  var_7 = vectorNormalize(var_4 - var_3);
  var_8 = vectordot(var_7, var_6);
  var_9 = var_8 >= 0.819152;

  if(!var_9) {
    return false;
  }

  return true;
}

function level_guardfight(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("entitydeleted");

  foreach(var_3 in level.guard.proximitydata.warningsoundentities) {
    var_3 scalevolume(0, 1.5);
  }

  var_5 = level_getalertedguards();

  if(scripts\engine\utility::array_contains(var_5, var_0)) {
    return;
  }

  var_0 notify("level_guardFight");
  var_0 notify("stop_going_to_node");
  var_0 unlink();
  scripts\sp\maps\safehouse\safehouse_utility::ai_endpathlogic(var_0);
  level_guardremoveai(var_0);
  level_guardaddalertedai(var_0);
  level notify("level_guardFight", var_0);
  level_guardhideholesightblockerclips();
  thread level_guardfightshowsightblockerclipslogic(var_0);

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var_0)) {
    var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var_0 scripts\engine\sp\utility::set_ignoreall(0);
    var_0 scripts\engine\sp\utility::set_ignoreme(0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var_0, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var_0, 0);
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_dogfightbarklogic(var_0);
    var_0.dontevershoot = 0;
    var_0.dontmelee = 0;
  } else {
    if(!istrue(var_0.script_deathchain)) {
      var_0 scripts\engine\sp\utility::anim_stopanimScripted();
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
    }

    if(var_1 && !istrue(var_0.script_nosurprise)) {
      level_guardreactlogic(var_0, level.player.origin);
      var_6 = level_guardfightlines();
      var_7 = scripts\engine\utility::random(var_6);
      level_guardplaydialogue(var_0, var_7, "fight");
    }

    var_0 scripts\common\utility::clear_demeanor_override();
    var_0 scripts\engine\sp\utility::set_ignoreall(0);
    var_0 scripts\engine\sp\utility::set_ignoreme(0);
    var_0 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
    var_0 scripts\common\utility::lookatentity();
    var_0 getenemyinfo(level.player);
    var_0.script_forcegoal = undefined;
    var_0 scripts\engine\sp\utility::set_goalRadius(512);
    var_0 scripts\common\ai::gun_recall();
    var_0 scripts\engine\sp\utility::set_baseaccuracy(3);
    var_0.aggressivemode = 1;
    var_0.lastenemysightpos = level.player.origin;
    var_0 scripts\engine\sp\utility::set_battlechatter(1);
    var_0 scripts\engine\sp\utility::disable_surprise();
    var_0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var_0 clearentitytarget();
    var_0 scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::set_grenadeammo, 2);
    var_0.dontevershoot = 0;
    var_0.dontmelee = 0;
  }

  var_0 setgoalentity(level.player);
  var_0.goalheight = 80;
}

function level_guardfightlines() {
  return ["dx_cst_ru1_combat_generic_10", "dx_cst_ru2_combat_generic_10", "dx_cst_ru3_combat_generic_10"];
}

function level_guardfightalertguardslogic() {
  for(;;) {
    level waittill("level_guardFight", var_0);

    if(istrue(var_0.script_engage) && level_getguards().size > 1) {
      level_guardsetallalerted(var_0.origin);
    }

    level_guardfightalertnearbyguards(var_0, 300, 0, 1, 0, "guard_fight_nearby_instant");
    level_guardfightalertnearbyguards(var_0, 500, 1, 0, 0, "guard_fight_nearby_fov");
  }
}

function level_guardallalertedcivilianslogic() {
  for(;;) {
    level waittill("level_guardsAllAlerted");
    var_0 = level_guardgetcivilians();

    foreach(var_2 in var_0) {
      thread level_guardcivilianalertedlogic(var_2);
    }
  }
}

function level_guardfightalertnearbycivilianslogic() {
  for(;;) {
    level waittill("level_guardFight", var_0);

    if(!isDefined(var_0)) {
      continue;
    }

    thread level_guardfightalertnearbycivilians(var_0.origin);
  }
}

function level_guardfightvolumealertcivilianslogic() {
  level waittill("level_guardVolumeAlerted", var_0);
  var_1 = level_guardgetciviliansingroupvolumes(var_0);

  foreach(var_3 in var_1) {
    level_guardcivilianalertedlogic(var_3);
  }
}

function level_guardfightalertnearbycivilians(var_0) {
  var_1 = 0.05;
  var_2 = 0.1;
  var_3 = level_guardgetcivilians();
  var_3 = sortbydistance(var_3, var_0);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }

    if(!isalive(var_5)) {
      continue;
    }

    if(distance(var_5.origin, var_0) > 600) {
      continue;
    }

    level_guardcivilianalertedlogic(var_5);
    wait randomfloatrange(var_1, var_2);
  }
}

function level_guardfightshowsightblockerclipslogic(var_0) {
  var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  var_1 = level_getalertedguards();

  if(var_1.size) {
    return;
  }

  level_guardshowholesightblockerclips();
}

function level_guardfightmusiclogic() {
  var_0 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  var_0 linkTo(level.player);
  var_1 = 2;
  var_2 = 1;
  var_3 = 3;

  for(;;) {
    level waittill("level_guardFight");
    wait var_1;

    if(!level_getalertedguards().size) {
      continue;
    }

    level_waittillplayerclearedalertedguards();
  }
}

function level_guardplayerinmeleerange(var_0) {
  return distancesquared(var_0.origin, level.player.origin) <= 10000;
}

function level_guardislabordriver(var_0) {
  return scripts\engine\utility::is_equal(var_0.script_parameters, "level_guardLaborDriver");
}

function level_guarddamagelogic(var_0) {
  var_0 endon("level_guardFight");

  for(;;) {
    var_0 waittill("damage", var_1, var_2);

    if(!isDefined(var_2)) {
      return;
    }

    if(var_2 != level.player) {
      return;
    }

    var_3 = var_0.origin;
    var_4 = level_guardgetdamagelines();
    var_5 = var_4[var_0.guard.voiceindex];
    level_guardplaydialogue(var_0, var_5, "damage");
    thread level_guardfight(var_0, 1);
    break;
  }
}

function level_guardgetdamagelines() {
  return ["dx_cst_ru1_damage_generic_10", "dx_cst_ru2_damage_generic_10", "dx_cst_ru3_damage_generic_10"];
}

function level_guardwhizbylogic(var_0) {
  var_0 endon("level_guardFight");

  for(;;) {
    var_0 waittill("bulletwhizby");
    var_1 = var_0 getEye();
    var_2 = level.player getEye();
    var_3 = scripts\engine\trace::create_shotclip_contents();
    var_4 = scripts\engine\trace::ray_trace_detail_passed(var_1, var_2, [level.player, var_0], var_3);

    if(!var_4) {
      continue;
    }

    var_5 = distancesquared(level.player.origin, var_0.origin);

    if(var_5 <= 30625) {
      break;
    }

    var_6 = anglesToForward(level.player getplayerangles());
    var_7 = vectorNormalize(var_0 getEye() - level.player getEye());
    var_8 = vectordot(var_7, var_6);
    var_9 = var_8 >= 0.939693;

    if(!var_9) {
      continue;
    }

    break;
  }

  var_10 = level_guardgetwhizbylines();
  var_11 = var_10[var_0.guard.voiceindex];
  level_guardplaydialogue(var_0, var_11, "whizby");
  thread level_guardfight(var_0, 1);
}

function level_guardgetwhizbylines() {
  return ["dx_cst_ru1_bulletwhizby_generic_10", "dx_cst_ru2_bulletwhizby_generic_10", "dx_cst_ru3_bulletwhizby_generic_10"];
}

function level_guardcorpsedetectlogic(var_0) {
  var_0 endon("level_guardFight");
  var_1 = 500;
  var_2 = 0.5;

  for(;;) {
    wait var_2;
    var_3 = level_guardgetcorpses();
    var_4 = var_0 getEye();

    foreach(var_6 in var_3) {
      var_7 = var_6.origin;
      var_8 = sighttracepassed(var_4, var_7, 0, level.player);

      if(!var_8) {
        continue;
      }

      var_9 = scripts\engine\utility::within_fov(var_4, var_0.angles, var_7, 0.5);

      if(!var_9) {
        continue;
      }

      var_10 = distance(var_4, var_7);

      if(var_10 > var_1) {
        continue;
      }

      var_11 = level_guardgetcorpselines();
      var_12 = var_11[var_0.guard.voiceindex];
      level_guardplaydialogue(var_0, var_12, "corpse");
      thread level_guardfight(var_0, 1);
    }
  }
}

function level_guardgetcorpselines() {
  return ["dx_cst_ru1_saw_corpse_10", "dx_cst_ru2_saw_corpse_10", "dx_cst_ru3_saw_corpse_10"];
}

function level_guarddeathalertotherslogic(var_0) {
  level endon("level_guardEndLogic");
  var_0 endon("entitydeleted");
  var_0 endon("level_guardEndLogic");
  var_0 waittill("death", var_1);

  if(!isDefined(var_1)) {
    return;
  }

  if(var_1 != level.player) {
    return;
  }

  level_guardspawncorpsestruct(var_0);
  thread level_guardfightalertnearbyguards(var_0, 300, 0, 1, 1, "nearby_death");
}

function level_guardspawncorpsestruct(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin + (0, 0, 10);
  level.guard.corpses = scripts\engine\utility::array_add(level.guard.corpses, var_1);
}

function level_guardgetcorpses() {
  return level.guard.corpses;
}

function level_guardclearcorpses() {
  level.guard.corpses = [];
}

function level_guardreactlogic(var_0, var_1, var_2) {
  var_0 endon("damage");
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_3 = 0.05;
  var_4 = 0.15;
  wait randomfloatrange(var_3, var_4);

  if(!isalive(var_0)) {
    return;
  }

  var_0.guard.animationorigin.origin = var_0.origin;
  var_0.guard.animationorigin.angles = var_0.angles;
  var_5 = scripts\engine\utility::flatten_vector(var_1 - var_0.origin);
  var_6 = vectortoangles(var_5);

  if(!level_isguardanimated(var_0)) {
    var_0.guard.animationorigin unlink();
  }

  var_0 linkTo(var_0.guard.animationorigin);
  var_0.animname = "level_guard";
  var_7 = "level_guardReact" + level.guard.reactionindex;
  level.guard.reactionindex = scripts\engine\math::wrap(0, level_guardgetreactionanimations().size - 1, level.guard.reactionindex + 1);
  var_8 = getanimlength(var_0 scripts\engine\utility::getanim(var_7));
  var_0.guard.animationorigin rotateTo(var_6, var_8);
  thread level_guardreactdamagelogic(var_0);
  var_0.guard.animationorigin scripts\common\anim::anim_single_solo(var_0, var_7);
  var_0 unlink();

  if(!level_isguardanimated(var_0)) {
    var_0.guard.animationorigin linkTo(var_0);
    return;
  }
}

function level_guardreactdamagelogic(var_0) {
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var_0, "end");
  var_0 endon("end");
  var_0 endon("death");
  var_0 waittill("damage", var_1, var_2, var_3, var_4);
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
  var_0 kill(var_4, var_2);
}

function level_guardshootalertotherslogic(var_0) {
  for(;;) {
    var_0 waittill("shooting");

    if(!scripts\engine\utility::is_equal(var_0.enemy, level.player)) {
      continue;
    }

    if(!level_guardisentitytouchinganygroupvolume(var_0) || !level_guardisentitytouchinganygroupvolume(level.player)) {
      level_guardsetallalerted(var_0.origin);
      continue;
    }

    level_alertguardsinentitygroupvolumes(var_0, 1);
    level_alertguardsinentitygroupvolumes(level.player, 1);
  }
}

function level_guardseenplayerpronelogic(var_0) {
  var_0 endon("level_guardFight");
  var_1 = 1.5;
  var_2 = 2.5;

  for(var_3 = 0;; var_3 = 1) {
    waitframe();

    if(!level_guardcanseeplayerprone(var_0)) {
      if(isDefined(var_0.guard.proximitydata) && var_3) {
        var_4 = randomfloatrange(var_1, var_2);
        wait var_4;
        var_0.guard.proximitydata.overridewarningindex = undefined;
      }

      var_3 = 0;
      continue;
    }

    var_0.guard.playerseenproneduration += 0.05;

    if(var_0.guard.playerseenproneduration >= 5) {
      thread level_guardfight(var_0, 0);
      return;
    }

    level.player playRumbleOnEntity("damage_heavy");

    if(!isDefined(var_0.guard.proximitydata)) {
      var_3 = 1;
      continue;
    }

    if(!var_3) {
      var_5 = level_guardgetseenplayeractgoofylines();
      var_6 = var_5[var_0.guard.voiceindex];
      level_guardplaydialogue(var_0, var_6, "player_goofy");
      var_0.guard.proximitydata.overridewarningindex = 2;
    }
  }
}

function level_guardgetseenplayeractgoofylines() {
  return ["dx_vom_ru1_construction_carry_10", "dx_vom_ru2_construction_soldiermen_40", "dx_vom_ru3_construction_carry_30"];
}

function level_guardgetplayerpronelines() {
  return ["dx_vom_ru1_construction_carry_10", "dx_vom_ru2_return_disperse_20", "dx_vom_ru3_construction_carry_30"];
}

function level_guardcanseeplayerprone(var_0) {
  if(scripts\engine\utility::flag("level_guardInstantDetectPlayer")) {
    return false;
  }

  if(!scripts\sp\maps\safehouse\safehouse_utility::player_isprone()) {
    return false;
  }

  var_1 = var_0 getEye();
  var_2 = level.player getEye();
  var_3 = sighttracepassed(var_1, var_2, 0, level.player);

  if(!var_3) {
    return false;
  }

  var_4 = distance(level.player.origin, var_0.origin);

  if(var_4 > 400) {
    return false;
  }

  var_5 = scripts\engine\utility::within_fov(var_1, var_0.angles, var_2, 0.5);

  if(!var_5) {
    return false;
  }

  return true;
}

function level_guardseenplayermeleelogic(var_0) {
  var_0 endon("level_guardFight");
  var_1 = 3.5;

  for(;;) {
    level.player waittill("melee_swipe_start");

    if(scripts\engine\utility::flag("level_guardInstantDetectPlayer")) {
      continue;
    }

    var_2 = var_0 getEye();
    var_3 = level.player getEye();
    var_4 = sighttracepassed(var_2, var_3, 0, level.player);

    if(!var_4) {
      continue;
    }

    var_5 = scripts\engine\utility::within_fov(var_2, var_0.angles, var_3, 0.5);

    if(!var_5) {
      continue;
    }

    var_6 = scripts\engine\utility::within_fov(var_3, level.player.angles, var_2, 0.34202);

    if(!var_6) {
      continue;
    }

    var_7 = distance(level.player.origin, var_0.origin);

    if(var_7 > 600) {
      continue;
    }

    var_0.guard.playermeleeseencount++;

    if(var_0.guard.playermeleeseencount >= 2) {
      thread level_guardfight(var_0, 0);
      return;
    }

    thread level_guardseenplayermeleeeffectslogic();
    var_8 = level_guardgetseenplayermeleelines();
    var_9 = var_8[var_0.guard.voiceindex];
    level_guardplaydialogue(var_0, var_9, "player_melee");

    if(!isDefined(var_0.guard.proximitydata)) {
      continue;
    }

    var_0.guard.proximitydata.overridewarningindex = 2;
    wait var_1;
    var_0.guard.proximitydata.overridewarningindex = undefined;
  }
}

function level_guardgetseenplayermeleelines() {
  return ["dx_vom_ru1_construction_soldiermen_20", "dx_vom_ru2_market_soldierpush_40", "dx_vom_ru3_construction_soldierwomen_90"];
}

function level_guardseenplayermeleeeffectslogic() {
  var_0 = 2;
  var_1 = 1;
  var_2 = scripts\engine\sp\utility::get_rumble_ent();
  var_2 scripts\engine\sp\utility::set_rumble_intensity(1);
  var_3 = level.player scripts\engine\utility::spawn_script_origin();
  var_3 linkTo(level.player);
  var_3 playLoopSound("ui_stealth_threat_high_lp");
  wait var_0;
  var_2 scripts\engine\sp\utility::rumble_ramp_off(var_1);
  var_3 scripts\engine\sp\utility::sound_fade_and_delete(var_1, 1);
}

function level_guardseenplayerjumplogic(var_0) {
  var_0 endon("level_guardFight");
  var_1 = 3.5;

  for(;;) {
    level.player waittill("jump_pressed");

    if(scripts\engine\utility::flag("level_guardInstantDetectPlayer")) {
      continue;
    }

    var_2 = var_0 getEye();
    var_3 = level.player getEye();
    var_4 = sighttracepassed(var_2, var_3, 0, level.player);

    if(!var_4) {
      continue;
    }

    var_5 = scripts\engine\utility::within_fov(var_2, var_0.angles, var_3, 0.5);

    if(!var_5) {
      continue;
    }

    var_6 = distance(level.player.origin, var_0.origin);

    if(var_6 > 300) {
      continue;
    }

    var_0.guard.playerjumpseencount++;

    if(var_0.guard.playerjumpseencount <= 1) {
      thread level_guardseenplayerjumpeffectslogic();
      continue;
    }

    if(var_0.guard.playerjumpseencount >= 3) {
      thread level_guardfight(var_0, 0);
      return;
    }

    thread level_guardseenplayerjumpeffectslogic();
    var_7 = level_guardgetseenplayeractgoofylines();
    var_8 = var_7[var_0.guard.voiceindex];
    level_guardplaydialogue(var_0, var_8, "player_goofy");

    if(!isDefined(var_0.guard.proximitydata)) {
      continue;
    }

    var_0.guard.proximitydata.overridewarningindex = 2;
    wait var_1;
    var_0.guard.proximitydata.overridewarningindex = undefined;
  }
}

function level_guardseenplayerjumpeffectslogic() {
  var_0 = 1.5;
  var_1 = 1.5;
  var_2 = scripts\engine\sp\utility::get_rumble_ent();
  var_2 scripts\engine\sp\utility::set_rumble_intensity(1);
  var_3 = level.player scripts\engine\utility::spawn_script_origin();
  var_3 linkTo(level.player);
  var_3 playLoopSound("ui_stealth_threat_high_lp");
  wait var_0;
  var_2 scripts\engine\sp\utility::rumble_ramp_off(var_1);
  var_3 scripts\engine\sp\utility::sound_fade_and_delete(var_1, 1);
}

function level_guardmeleedalertotherslogic(var_0) {
  for(;;) {
    var_0 waittill("melee_attack");

    if(!level_guardisentitytouchinganygroupvolume(var_0) || !level_guardisentitytouchinganygroupvolume(level.player)) {
      level_guardsetallalerted(var_0.origin);
      continue;
    }

    level_alertguardsinentitygroupvolumes(var_0, 1);
    level_alertguardsinentitygroupvolumes(level.player, 1);
  }
}

function level_guardsetallalerted(var_0) {
  var_1 = level_getguards();

  if(isDefined(var_0)) {
    var_1 = sortbydistance(var_1, var_0);
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(!isalive(var_3)) {
      continue;
    }

    var_4 = level_getentitytouchinggroupvolumes(var_3);
    level_setgroupvolumesalerted(var_4);

    if(istrue(var_3.script_killspawner)) {
      var_3 scripts\engine\sp\utility::ai_ragdoll_immediate();
      continue;
    }

    thread level_guardfight(var_3, 0);
  }

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    scripts\engine\utility::flag_set("level_guardsStealthBroken");
    thread level_guardsalertedclearstealthflaglogic();
  }

  scripts\engine\utility::flag_set("level_guardsAllAlerted");
  scripts\engine\utility::flag_set("disable_autosaves");
}

function level_guardcivilianlogic(var_0) {
  level_guardaddcivilian(var_0);
  thread level_guardciviliandeathalertotherslogic(var_0);
}

function level_guardciviliandeathalertotherslogic(var_0) {
  var_0 endon("entitydeleted");

  for(;;) {
    var_0 waittill("death", var_1);

    if(!scripts\engine\utility::is_equal(var_1, level.player)) {
      continue;
    }

    level_guardciviliandeathalertnearbyguards(var_0, 300, 0, 1, 0, "civilian_damaged_nearby_instant");
    level_guardciviliandeathalertnearbyguards(var_0, 800, 1, 0, 0, "civilian_damaged_nearby_fov");
    level_guardciviliandeathalertnearbycivilians(var_0, 300, 0, 0, "civilian_damaged_nearby_instant");
    level_guardciviliandeathalertnearbycivilians(var_0, 800, 1, 0, "civilian_damaged_nearby_fov");
  }
}

function level_guardciviliandeathalertnearbyguards(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    return;
  }

  var_6 = var_0.origin;
  var_7 = var_0 gettagorigin("J_HEAD");
  var_8 = level_getguards();
  var_8 = scripts\engine\utility::array_remove(var_8, var_0);

  if(!var_8.size) {
    return;
  }

  var_8 = sortbydistance(var_8, var_6);

  foreach(var_10 in var_8) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isalive(var_10)) {
      continue;
    }

    var_11 = distance(var_6, var_10.origin);
    var_12 = var_11 <= 200;

    if(!var_12) {
      var_13 = var_10 getEye();
      var_14 = var_7;
      var_15 = sighttracepassed(var_13, var_14, 0, level.player, 1);

      if(!var_15) {
        continue;
      }

      var_16 = var_11 <= var_1;

      if(!var_16) {
        continue;
      }

      var_17 = abs(var_13[2] - var_14[2]);
      var_18 = var_17 < 100;

      if(var_4 && !var_18) {
        continue;
      }

      var_19 = anglesToForward(var_10.angles);
      var_20 = vectorNormalize(var_14 - var_13);
      var_21 = vectordot(var_20, var_19);
      var_22 = var_21 >= 0.34202;

      if(var_2 && !var_22) {
        continue;
      }
    }

    thread level_guardfight(var_10, 1);
    var_23 = randomfloatrange(0.1, 0.2);
    wait var_23;
  }
}

function level_guardciviliandeathalertnearbycivilians(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }

  var_5 = var_0.origin;
  var_6 = var_0 gettagorigin("J_HEAD");
  var_7 = level_guardgetcivilians();
  var_7 = scripts\engine\utility::array_remove(var_7, var_0);

  if(!var_7.size) {
    return;
  }

  var_7 = sortbydistance(var_7, var_5);

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      return 0;
    }

    if(!isalive(var_9)) {
      return 0;
    }

    var_10 = distance(var_5, var_9.origin);
    var_11 = var_9 gettagorigin("J_HEAD");
    var_12 = var_5;
    var_13 = var_10 <= var_1;

    if(!var_13) {
      continue;
    }

    var_14 = abs(var_11[2] - var_12[2]);
    var_15 = var_14 < 100;

    if(var_3 && !var_15) {
      continue;
    }

    var_16 = anglesToForward(var_9.angles);
    var_17 = vectorNormalize(var_12 - var_11);
    var_18 = vectordot(var_17, var_16);
    var_19 = var_18 >= 0.34202;

    if(var_2 && !var_19) {
      continue;
    }

    level_guardcivilianalertedlogic(var_9);
    var_20 = randomfloatrange(0.1, 0.2);
    wait var_20;
  }
}

function level_guardcivilianalertedlogic(var_0) {
  var_1 = level_guardgetalertedcivilians();

  if(scripts\engine\utility::array_contains(var_1, var_0)) {
    return;
  }

  level_guardremovecivilian(var_0);
  level_guardaddalertedcivilian(var_0);

  if(istrue(var_0.script_threshold)) {
    return;
  }

  if(istrue(var_0.script_killspawner)) {
    var_0 scripts\engine\sp\utility::ai_ragdoll_immediate();
    return;
  }

  var_0 notify("level_civilianAlerted");
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
  var_0.script_pushable = 1;
  var_0.pushable = 1;
  var_2 = level_guardgetcivilianalertedanimation(var_0);

  if(!isDefined(var_2)) {
    var_0.animname = "level_guardCivilian";
    level.guard.alerted.civiliancowerindex = scripts\engine\math::wrap(0, level_guardgetcivilianalertedanimations().size - 1, level.guard.alerted.civiliancowerindex + 1);
    var_2 = "level_guardCivilianAlerted" + level.guard.alerted.civiliancowerindex;
  }

  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var_0, var_0, var_2);
  var_3 = var_0 scripts\engine\utility::getanim(var_2)[0];
  var_4 = getanimlength(var_3);
  var_5 = randomfloat(var_4) / var_4;
  var_0 scripts\engine\utility::delaycall(0.05, &setanimtime, var_3, var_5);
}

function level_guardsetcivilianalertedanimation(var_0, var_1) {
  var_0.alertedanimationname = var_1;
}

function level_guardgetcivilianalertedanimation(var_0) {
  return var_0.alertedanimationname;
}

function level_guardaddcivilian(var_0) {
  level.guard.civilians = scripts\engine\utility::array_add(level.guard.civilians, var_0);
}

function level_guardremovecivilian(var_0) {
  level.guard.civilians = scripts\engine\utility::array_remove(level.guard.civilians, var_0);
}

function level_guardgetcivilians() {
  return scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(level.guard.civilians);
}

function level_guardaddalertedcivilian(var_0) {
  level.guard.alerted.civilians = scripts\engine\utility::array_add(level.guard.alerted.civilians, var_0);
}

function level_guardgetalertedcivilians() {
  return scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(level.guard.alerted.civilians);
}

function level_guardclearallalerted() {
  scripts\engine\utility::flag_clear("level_guardsAllAlerted");
  scripts\engine\utility::flag_clear("level_guardsStealthBroken");
  scripts\engine\utility::flag_clear("disable_autosaves");
}

function level_guardplayerunsilencedshotlogic() {
  for(;;) {
    level.player waittill("begin_firing");
    var_0 = level_getguards().size == 0;

    if(var_0) {
      continue;
    }

    if(scripts\sp\maps\safehouse\safehouse::player_holdingsilencedweapon()) {
      continue;
    }

    if(level_guardisentitytouchinganygroupvolume(level.player)) {
      level_alertguardsinentitygroupvolumes(level.player, 1);
      continue;
    }

    level_guardsetallalerted(level.player.origin);
  }
}

function level_guardplayerthrewoffhandlogic() {
  for(;;) {
    level.player waittill("grenade_fire", var_0);
    var_1 = level_getguards().size == 0;

    if(var_1) {
      continue;
    }

    thread level_guardplayerthrownoffhandalertlogic(var_0);
  }
}

function level_guardplayerthrownoffhandalertlogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("missile_stuck");
  var_1 = 50;

  for(;;) {
    var_2 = level_getguards();

    foreach(var_4 in var_2) {
      if(distance(var_4 getEye(), var_0.origin) > var_1) {
        continue;
      }

      var_5 = var_4 getEye();
      var_6 = level.player getEye();
      var_7 = scripts\engine\trace::create_shotclip_contents();
      var_8 = scripts\engine\trace::ray_trace_detail_passed(var_5, var_6, [level.player, var_4], var_7);

      if(!var_8) {
        continue;
      }

      thread level_guardfight(var_4, 1);
    }

    waitframe();
  }
}

function level_teleportguard(var_0, var_1, var_2, var_3) {
  var_0 forceteleport(var_1, var_2);
  var_0.guard.animationorigin.origin = var_1;
  var_0.guard.animationorigin.angles = var_2;

  if(istrue(var_3)) {
    level_resetguardlogic(var_0);
    return;
  }
}

function level_resetguardlogic(var_0) {
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var_0);
  ai_endguardlogic(var_0);
  waitframe();
  level_guardlogic(var_0, 1, 0);
}

function level_isaiguard(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isalive(var_0)) {
    return false;
  }

  return isDefined(var_0.guard);
}

function level_isguardanimated(var_0) {
  return isDefined(var_0.script_animation) && istrue(int(var_0.script_animation));
}

function level_guardisplayerinhiddenvolume() {
  var_0 = level_getguardplayerhiddenvolumes();

  foreach(var_2 in var_0) {
    if(!level.player istouching(var_2)) {
      continue;
    }

    return true;
  }

  return false;
}

function level_getguardplayerhiddenvolumes() {
  return getEntArray("level_guardPlayerHiddenVolume", "targetname");
}

function level_alertguardsinentitygroupvolumes(var_0, var_1) {
  var_2 = level_getentitytouchinggroupvolumes(var_0);
  level_setgroupvolumesalerted(var_2);
  var_3 = level_getguardsingroupvolumes(var_2);
  var_3 = sortbydistance(var_3, var_0.origin);

  if(!var_3.size) {
    var_4 = level_getalertedguards();

    if(var_4.size && !scripts\engine\utility::flag("level_guardsStealthBroken")) {
      scripts\engine\utility::flag_set("level_guardsStealthBroken");
      scripts\engine\utility::flag_set("disable_autosaves");
      thread level_guardsalertedclearstealthflaglogic();
    }

    return;
  }

  foreach(var_6 in var_4) {
    if(istrue(var_6.script_killspawner)) {
      var_6 scripts\engine\sp\utility::ai_ragdoll_immediate();
      continue;
    }

    thread level_guardfight(var_6, var_2);
  }

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    scripts\engine\utility::flag_set("level_guardsStealthBroken");
    scripts\engine\utility::flag_set("disable_autosaves");
    thread level_guardsalertedclearstealthflaglogic();
    return;
  }
}

function level_getguardsingroupvolumes(var_0) {
  var_1 = level_getguards();

  foreach(var_3 in var_1) {
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_3 istouching(var_6)) {
        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  return var_1;
}

function level_guardgetciviliansingroupvolumes(var_0) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  var_1 = level_guardgetcivilians();

  foreach(var_3 in var_1) {
    var_4 = 0;

    foreach(var_6 in var_0) {
      if(var_3 istouching(var_6)) {
        var_4 = 1;
        break;
      }
    }

    if(!var_4) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  return var_1;
}

function level_guardisentitytouchinganygroupvolume(var_0) {
  var_1 = level_getentitytouchinggroupvolumes(var_0);
  return var_1.size > 0;
}

function level_getentitytouchinggroupvolumes(var_0) {
  var_1 = level_getguardgroupvolumes();

  foreach(var_3 in var_1) {
    if(var_0 istouching(var_3)) {
      continue;
    }

    var_1 = scripts\engine\utility::array_remove(var_1, var_3);
  }

  return var_1;
}

function level_setgroupvolumesalertedbygroupname(var_0) {
  var_1 = level_getguardgroupvolumes();

  foreach(var_3 in var_1) {
    if(!scripts\engine\utility::is_equal(var_3.groupname, var_0)) {
      continue;
    }

    level_setgroupvolumesalerted(var_3);
  }
}

function level_setgroupvolumesalerted(var_0) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_2 in var_0) {
    if(level_isgroupvolumealerted(var_2)) {
      continue;
    }

    level notify("level_guardVolumeAlerted", var_2);

    if(isDefined(var_2.groupname)) {
      level notify("level_guardVolumeAlerted" + var_2.groupname);
    }

    var_3 = var_2 scripts\engine\sp\utility::get_linked_spawners();
    var_4 = scripts\engine\sp\utility::array_spawn(var_3, 0, 1);

    foreach(var_6 in var_4) {
      level_guardassignweapon(var_6);
      thread level_guardfight(var_6, 0);
    }

    level.guard.alerted.volumes = scripts\engine\utility::array_add(level.guard.alerted.volumes, var_2);
  }
}

function level_setclearalertedgroupnamevolumes(var_0) {
  var_1 = level_getalertedgroupvolumes();

  foreach(var_3 in var_1) {
    if(!scripts\engine\utility::is_equal(var_3.groupname, var_0)) {
      continue;
    }

    level.guard.alerted.volumes = scripts\engine\utility::array_remove(level.guard.alerted.volumes, var_3);
  }
}

function level_guardsalertedclearstealthflaglogic() {
  level notify("level_guardAlertedClearFlagLogic");
  level endon("level_guardAlertedClearFlagLogic");
  level_waittillplayerclearedalertedguards();
  scripts\engine\utility::flag_clear("level_guardsStealthBroken");
  scripts\engine\utility::flag_clear("disable_autosaves");
}

function level_getguardforcethreatvolumes() {
  return getEntArray("level_guardThreatVolume", "targetname");
}

function level_getguardgroupvolumes() {
  return getEntArray("level_guardGroupVolume", "targetname");
}

function level_getalertedgroupvolumes() {
  return level.guard.alerted.volumes;
}

function level_isgroupvolumealerted(var_0) {
  var_1 = level_getalertedgroupvolumes();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3, var_0)) {
      return true;
    }
  }

  return false;
}

function level_isgroupnamevolumealerted(var_0) {
  var_1 = level_getalertedgroupvolumes();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.groupname, var_0)) {
      return true;
    }
  }

  return false;
}

function level_waittillplayerclearedalertedguards() {
  while(level_getalertedguards().size) {
    waitframe();
  }

  level notify("level_guardPlayerClearedAlerted");
}

function level_guarddoggrowllogic(var_0) {
  var_0 endon("death");
  var_1 = 1.5;
  var_2 = 2.5;

  for(;;) {
    if(!istrue(var_0.forcegrowl)) {
      waitframe();
      continue;
    }

    var_0 playSound("anml_dog_growl", "ai_guardDogGrowl", 1);
    var_0 waittill("ai_guardDogGrowl");
    var_3 = randomfloatrange(var_1, var_2);
    wait var_3;
  }
}

function level_guardcleanupanimationoriginlogic(var_0) {
  var_0 scripts\engine\utility::waittill_any("entitydeleted", "death", "start_context_melee");

  if(!isDefined(var_0.guard.animationorigin)) {
    return;
  }

  var_0.guard.animationorigin delete();
}

function level_getguards() {
  return scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(level.guard.ai);
}

function level_getallguards() {
  var_0 = level_getguards();
  var_1 = level_getalertedguards();
  return scripts\engine\sp\utility::array_merge(var_0, var_1);
}

function level_allguardsdead() {
  return level_getallguards().size == 0;
}

function level_guardaddai(var_0) {
  level.guard.ai = scripts\engine\utility::array_add(level.guard.ai, var_0);
}

function level_guardremoveai(var_0) {
  level.guard.ai = scripts\engine\utility::array_remove(level.guard.ai, var_0);
}

function level_guardaddalertedai(var_0) {
  level.guard.alerted.ai = scripts\engine\utility::array_add(level.guard.alerted.ai, var_0);
}

function level_guardisalerted(var_0) {
  var_1 = level_getalertedguards();
  return scripts\engine\utility::array_contains(var_1, var_0);
}

function level_addguardsalertedfunction(var_0, var_1) {
  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  if(isDefined(var_1)) {
    var_1 endon("entitydeleted");
    var_1 endon("death");
  }

  scripts\engine\utility::flag_wait("level_guardsStealthBroken");
  GscBinSkip1(0x74, var_0);
}

function level_getalertedguards() {
  return scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(level.guard.alerted.ai);
}

function level_endallguardlogic() {
  level notify("level_guardEndLogic");
}

function level_endallguardproximitylogic() {
  level notify("level_guardEndProximityLogic");
}

function level_guardgetreactionanimations() {
  return [%reb_stl_react_whizby_8, %reb_stl_alert_idle_react_md_8, %reb_stl_alert_idle_react_lg_8, %reb_stl_patrol_idle_react_smed_8, %reb_stl_alert_idle_react_smed_8];
}

function level_guardgetcivilianalertedanimations() {
  return [%sh_022_marketplace_react_ads_idle_civ03, %sh_022_marketplace_react_ads_idle_civ04, %sh_022_marketplace_react_ads_idle_civ05, %sh_022_marketplace_react_ads_idle_civ06];
}

function level_guardassignweapon(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = ["iw8_ar_akilo47", "iw8_sm_uzulu", "iw8_sm_beta", "iw8_sm_mpapa7", "iw8_sh_romeo870"];
  GscBinSkip1(0x45, "iw8_ar_akilo47", 40);
}

function level_guardgetholesightblockerclips() {
  return getEntArray("level_guardHoleSightBlockerClip", "targetname");
}

function level_guardhideholesightblockerclips() {
  var_0 = level_guardgetholesightblockerclips();

  foreach(var_2 in var_0) {
    var_2 hide();
  }
}

function level_guardshowholesightblockerclips() {
  var_0 = level_guardgetholesightblockerclips();

  foreach(var_2 in var_0) {
    var_2 show();
  }
}

function level_guardsinstantlydetectplayerlogic() {
  level endon("level_guardInstantDetectedEndLogic");
  scripts\engine\utility::flag_set("level_guardInstantDetectPlayer");

  for(;;) {
    waitframe();
    var_0 = level_getguards();

    foreach(var_2 in var_0) {
      if(!level_guardinstantdetectcanseeplayer(var_2)) {
        continue;
      }

      level_guardsetallalerted(var_2.origin);
      break;
    }
  }
}

function level_guardsendinstantdetectedlogic() {
  level notify("level_guardInstantDetectPlayer");
  scripts\engine\utility::flag_clear("level_guardInstantDetectPlayer");
}

function level_getguardsinstantdetectplayerhiddenvolumes() {
  return getEntArray("level_enemiesDetectPlayerHiddenVolume", "targetname");
}

function level_guardinstantdetectcanseeplayer(var_0) {
  var_1 = level_getguardsinstantdetectplayerhiddenvolumes();

  foreach(var_3 in var_1) {
    if(level.player istouching(var_3)) {
      return false;
    }
  }

  var_5 = var_0 getEye();
  var_6 = level.player getEye();
  var_7 = sighttracepassed(var_5, var_6, 0, level.player);

  if(!var_7) {
    return false;
  }

  var_8 = scripts\engine\utility::within_fov(var_5, var_0.angles, var_6, 0.5);

  if(!var_8) {
    return false;
  }

  var_9 = distance(level.player.origin, var_0.origin);

  if(var_9 > 650) {
    return false;
  }

  return true;
}

function ai_endguardproximitylogic(var_0) {
  var_0 notify("level_guardEndProximityLogic");
}

function ai_endguardlogic(var_0) {
  var_0 notify("level_guardEndLogic");
  level_guardremoveai(var_0);
}

function ai_isguard(var_0) {
  var_1 = level_getguards();
  return scripts\engine\utility::array_contains(var_1, var_0);
}