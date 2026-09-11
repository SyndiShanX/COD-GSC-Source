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

  for(var0 = 0; var0 < level.guard.proximitydata.warningnames.size; var0++) {
    var1 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
    var1 linkTo(level.player);
    level.guard.proximitydata.warningsoundentities = scripts\engine\utility::array_add(level.guard.proximitydata.warningsoundentities, var1);
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
  var2 = level_guardgetreactionanimations();

  foreach(var5, var4 in var2) {
    level.scr_anim["level_guard"]["level_guardReact" + var5] = var4;
  }

  var6 = level_guardgetcivilianalertedanimations();

  foreach(var8 in var6) {
    level.scr_anim["level_guardCivilian"]["level_guardCivilianAlerted" + var5][0] = var8;
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

function level_guardlogic(var0, var1, var2, var3) {
  level endon("level_guardEndLogic");
  var0 endon("level_guardEndLogic");
  var0 endon("death");
  var0 endon("start_context_melee");

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var0.script_count)) {
    var0.script_count = 0;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  level_guardaddai(var0);
  var0.guard = spawnStruct();
  var0.guard.animationorigin = var0 scripts\engine\utility::spawn_script_origin();
  thread level_guardcleanupanimationoriginlogic(var0);

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
    var0 scripts\engine\sp\utility::set_goalRadius(32);
    var0 scripts\engine\sp\utility::set_ignoreall(1);
    var0 scripts\engine\sp\utility::set_ignoreme(1);
    var0.dontevershoot = 1;
    var0.dontmelee = 1;
    var0.diequietly = 1;
    var0 actoraimassistoff();
    thread level_guarddoggrowllogic(var0);
  } else {
    var0 scripts\engine\sp\utility::set_ignoreall(1);
    var0 scripts\engine\sp\utility::set_ignoreme(1);
    var0 scripts\engine\sp\utility::set_goalRadius(32);
    var0.noloot = 1;
    var0.ignoresuppression = 1;
    var0.disableplayeradsloscheck = 1;
    var0.disablebulletwhizbyreaction = 1;
    var0.disablelongdeath = 1;
    var0.newenemyreactiondistsq = 0;
    var0.diequietly = 1;
    var0.script_forcegoal = 1;
    var0.allowdeath = 1;
    var0 scripts\engine\sp\utility::set_baseaccuracy(6);
    var0 allowedstances("stand");
    var0 scripts\engine\sp\utility::disable_long_death();
    var0 scripts\engine\sp\utility::set_battlechatter(0);
    var0 scripts\common\ai::set_gunpose("disable");
    var0 scripts\common\utility::demeanor_override("casual_gun");
    var0 scripts\engine\sp\utility::disable_surprise();
    var0 enablescriptedlookat(0);

    if(istrue(var3)) {
      level_guardassignweapon(var0);
    }
  }

  var0.guard.playermeleeseencount = 0;
  var0.guard.playerjumpseencount = 0;
  var0.guard.playerweapondrawnseencount = 0;
  var0.guard.meleecount = 0;
  var0.guard.playerseenproneduration = 0;
  level.guard.dialogue.voicelastindex = scripts\engine\math::wrap(0, level.guard.dialogue.voicemaxindex - 1, level.guard.dialogue.voicelastindex + 1);
  var0.guard.voiceindex = level.guard.dialogue.voicelastindex;
  GscBinSkip4(0x35, var0);
}

function level_guardplayerproximitylogic(var0, var1) {
  level endon("level_guardEndLogic");
  level endon("level_guardEndProximityLogic");
  var0 endon("level_guardEndLogic");
  var0 endon("death");
  var0 endon("start_context_melee");
  var0 endon("level_guardFight");
  var0 endon("level_guardEndProximityLogic");
  var0.guard.proximitydata = spawnStruct();
  var0.guard.proximitydata.currentwarningindex = 0;
  var0.guard.proximitydata.warningcooldowntime = 0;
  var0.guard.proximitydata.previouswarningcooldowntime = 0;
  var0.guard.proximitydata.playertimenearai = 0;
  var0.guard.proximitydata.aicanseeplayer = 0;
  var0.guard.proximitydata.aitoplayerdistancesq = 0;
  var0.guard.proximitydata.playerinaiwarning = 0;
  var0.guard.proximitydata.previousplayerorigin = level.player.origin;
  var0.guard.proximitydata.previousplayertimenearai = 0;
  var0.guard.proximitydata.originalorigin = var0.origin;
  var0.guard.proximitydata.originalangles = var0.angles;
  var0.guard.proximitydata.overridewarningindex = undefined;
  var0.guard.proximitydata.previousoverridewarningindex = undefined;

  if(!istrue(var1)) {
    var0.animname = "level_guard";
  }

  if(!var1 && level_isguardanimated(var0)) {
    var0 linkTo(var0.guard.animationorigin);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0.guard.animationorigin, var0, "level_guardIdle" + var0.script_count);
    goto LOC_000001d4;
  }

  var0.guard.animationorigin linkTo(var0);

  for(;;) {
    var0.guard.proximitydata.aitoplayerdistancesq = distancesquared(var0.origin, level.player.origin);
    var0.guard.proximitydata.aicanseeplayer = sighttracepassed(var0 getEye(), level.player getEye(), 0, level.player, 1);
    var2 = level_guardgethighestwarningguardwithinwarningsharerange(var0);

    if(isDefined(var0.guard.proximitydata.overridewarningindex)) {
      if(!scripts\engine\utility::is_equal(var0.guard.proximitydata.overridewarningindex, var0.guard.proximitydata.previousoverridewarningindex)) {
        var3 = level.guard.proximitydata.warningfunctions[var0.guard.proximitydata.overridewarningindex];
        GscBinSkip1(0x74, var3, var0, 1, var1);
      }
    } else {
      if(isDefined(var1.guard.proximitydata.previousoverridewarningindex)) {
        var3 = level.guard.proximitydata.warningfunctions[var1.guard.proximitydata.previousoverridewarningindex];
        GscBinSkip1(0x74, var3, var1, 0, var2);
      }

      if(level_guardplayerproximityshouldforcemelee(var2)) {
        level_guardplayerproximityforcemelee(var2);
      } else if(level_guardplayerproximityshouldforcethreat(var2)) {
        level_guardplayerproximityforcethreat(var2);
      } else {
        level_guardplayerproximityinwarninglogic(var2);
      }

      if(level_guardplayerproximityshouldincreasewarning(var2)) {
        level_guardproximityincreasewarning(var2, var3);
      } else if(level_guardplayerproximityshouldcooldownwarning(var2)) {
        level_guardplayerproximitycooldownwarning(var2, var3);
      }
    }

    var2.guard.proximitydata.previousplayerorigin = level.player.origin;
    var2.guard.proximitydata.previousplayertimenearai = var2.guard.proximitydata.playertimenearai;
    var2.guard.proximitydata.previousoverridewarningindex = var2.guard.proximitydata.overridewarningindex;
    level.guard.proximitydata.playerwasholdingcinderblock = scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();
    waitframe();
  }
}

function level_guardplayerfightvolumecheck(var0) {
  level endon("level_guardEndLogic");
  var0 endon("level_guardEndLogic");
  var0 endon("death");
  var0 endon("start_context_melee");
  var0 endon("level_guardFight");
  jumpiftrue(isDefined(var0.script_linkto)) LOC_00000032;
  return;
}

function level_guardplayerproximityshouldforcemelee(var0) {
  if(level.player islinked()) {
    return false;
  }

  if(level_guardislabordriver(var0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon()) {
    return false;
  }

  var1 = var0.guard.proximitydata.currentwarningindex;
  var2 = var0.guard.proximitydata.aitoplayerdistancesq;
  var3 = var1 >= 3;

  if(var3) {
    return false;
  }

  var4 = var2 <= 2025;

  if(!var4) {
    return false;
  }

  return true;
}

function level_guardplayerproximityforcemelee(var0) {
  var0.guard.proximitydata.currentwarningindex = 3;
  var0.guard.proximitydata.playertimenearai = level.guard.proximitydata.warningtimers[var0.guard.proximitydata.currentwarningindex];
  var0.guard.proximitydata.playerinaiwarning = 1;
}

function level_guardplayerproximityshouldforcethreat(var0) {
  if(level.player islinked()) {
    return false;
  }

  if(level_guardislabordriver(var0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon()) {
    return false;
  }

  var1 = var0.guard.proximitydata.currentwarningindex >= 2;

  if(var1) {
    return false;
  }

  var2 = istrue(var0.script_dist_only);

  if(!var2) {
    return false;
  }

  if(!var0.guard.proximitydata.aicanseeplayer) {
    return false;
  }

  var3 = var0.angles;
  var4 = var0 getEye();
  var5 = level.player getEye();
  var6 = scripts\engine\utility::within_fov(var4, var3, var5, 0);

  if(!var6) {
    return false;
  }

  var7 = var0.guard.proximitydata.aitoplayerdistancesq;
  var8 = var0.script_dist_only * var0.script_dist_only;
  var9 = var7 <= var8;

  if(!var9) {
    return false;
  }

  return true;
}

function level_isguardinforcethreatvolume(var0) {
  var1 = level_getguardforcethreatvolumes();
  var2 = [];

  foreach(var4 in var1) {
    var5 = var4 scripts\engine\utility::get_linked_ents();

    if(scripts\engine\utility::array_contains(var5, var0)) {
      var2 = scripts\engine\utility::array_add(var2, var4);
    }
  }

  if(!var2.size) {
    return false;
  }

  foreach(var8 in var2) {
    if(level.player istouching(var8)) {
      return true;
    }
  }

  return false;
}

function level_guardplayerproximityforcethreat(var0) {
  var0.guard.proximitydata.currentwarningindex = 2;
  var0.guard.proximitydata.playertimenearai = level.guard.proximitydata.warningtimers[var0.guard.proximitydata.currentwarningindex];
  var0.guard.proximitydata.playerinaiwarning = 1;
}

function level_guardproximityforcetohigherwarning(var0, var1) {
  var2 = var1 - 1;
  var0.guard.proximitydata.currentwarningindex = var2;
  var0.guard.proximitydata.playertimenearai = level.guard.proximitydata.warningtimers[var2];
  var0.guard.proximitydata.playerinaiwarning = 1;
}

function level_guardplayerproximityinwarninglogic(var0) {
  var1 = var0.guard.proximitydata.currentwarningindex;
  var2 = var0.guard.proximitydata.aicanseeplayer;
  var3 = var0.guard.proximitydata.previousplayerorigin;
  var4 = var0.guard.proximitydata.aitoplayerdistancesq;
  var5 = level.guard.proximitydata.warningradiusoverridefunctions[var1];
  var6 = [[var5]](var0);
  var7 = level_guardislabordriver(var0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();
  var8 = level.guard.proximitydata.warningcinderblockradii[var1];

  if(isDefined(var8) && var7) {
    var9 = squared(var8);
  } else if(isDefined(var7)) {
    var9 = squared(var7);
  } else {
    var9 = level.guard.proximitydata.warningradiisq[var3];
  }

  var10 = anglesToForward(var2.angles);
  var11 = vectorNormalize(level.player getEye() - var2 getEye());
  var12 = vectordot(var11, var10);
  var13 = var12 >= 0.34202;
  var14 = var6 <= var9;
  var15 = distancesquared(var5, var2.origin);
  var16 = distancesquared(level.player.origin, var2.origin);
  var17 = var16 > var15;
  var18 = level_guardisplayerinhiddenvolume();
  var2.guard.proximitydata.playerinaiwarning = var4 && var13 && var14 && !var18;

  if(var2.guard.proximitydata.playerinaiwarning) {
    var22 = level.guard.proximitydata.warningrumbletypes[var3];

    if(isDefined(var22)) {
      level.player playRumbleOnEntity(var22);
    }

    if(!var17) {
      var2.guard.proximitydata.playertimenearai += 0.05;
    }
  }

  var23 = var3 - 1;
  var2.guard.proximitydata.previouswarningcooldowntime = var2.guard.proximitydata.warningcooldowntime;

  if(var23 >= 0) {
    var24 = level.guard.proximitydata.warningradiusoverridefunctions[var23];
    var25 = [[var24]](var2);
    var26 = level.guard.proximitydata.warningcinderblockradii[var23];

    if(isDefined(var26) && var9) {
      var27 = squared(var26);
    } else if(isDefined(var26)) {
      var27 = squared(var26);
    } else {
      var27 = level.guard.proximitydata.warningradiisq[var25];
    }

    var28 = var4.guard.proximitydata.aitoplayerdistancesq <= var27;

    if(!var6) {
      var4.guard.proximitydata.warningcooldowntime = 0;
      return;
    }

    if(!var28) {
      var4.guard.proximitydata.warningcooldowntime = max(var4.guard.proximitydata.warningcooldowntime - 0.05, 0);
      return;
    }

    return;
  }
}

function level_guardarenearbyguardsathigherwarning(var0) {
  var1 = level_guardgethighestwarningguardwithinwarningsharerange(var0);
  return isDefined(var1);
}

function level_guardgethighestwarningguardwithinwarningsharerange(var0) {
  var1 = level_guardgetguardswithinwarningsharerange(var0);
  var2 = [];

  foreach(var4 in var1) {
    if(!isDefined(var4.guard.proximitydata)) {
      continue;
    }

    var5 = var4.guard.proximitydata.currentwarningindex > var0.guard.proximitydata.currentwarningindex;

    if(!var5) {
      continue;
    }

    var6 = var4.guard.proximitydata.currentwarningindex - 1;
    var7 = level.guard.proximitydata.warningradiusoverridefunctions[var6];
    var8 = [[var7]](var4);
    var9 = level.guard.proximitydata.warningcinderblockradii[var6];
    var10 = level_guardislabordriver(var4) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();

    if(isDefined(var9) && var10) {
      var11 = squared(var9);
    } else if(isDefined(var8)) {
      var11 = squared(var8);
    } else {
      var11 = level.guard.proximitydata.warningradiisq[var6];
    }

    var12 = var4.guard.proximitydata.aitoplayerdistancesq <= var11;

    if(!var12) {
      continue;
    }

    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  if(!var2.size) {
    return undefined;
  }

  var14 = 0;
  var15 = undefined;

  foreach(var17 in var2) {
    var18 = var17.guard.proximitydata.currentwarningindex;

    if(var18 > var14) {
      var14 = var18;
      var15 = var17;
    }
  }

  return var15;
}

function level_guardgetguardswithinwarningsharerange(var0) {
  var1 = 400;
  var2 = level_getguards();
  var3 = [];

  foreach(var5 in var2) {
    var6 = distance(var5.origin, var0.origin);

    if(var6 > var1) {
      continue;
    }

    var3 = scripts\engine\utility::array_add(var3, var5);
  }

  return var3;
}

function level_guardplayerproximityshouldincreasewarning(var0) {
  if(level.player islinked()) {
    return false;
  }

  if(level_guardisplayerinhiddenvolume()) {
    return false;
  }

  if(!var0.guard.proximitydata.playerinaiwarning) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon() && !level.guard.proximitydata.playerwasholdingcinderblock) {
    return false;
  }

  var1 = var0.guard.proximitydata.currentwarningindex;
  var2 = level.guard.proximitydata.warningtimers[var1];

  if(var0.guard.proximitydata.playertimenearai >= var2) {
    return true;
  }

  return false;
}

function level_gethighestguardwarningindex(var0) {
  var1 = level_getguards();

  if(isDefined(var0)) {
    var1 = scripts\engine\utility::array_remove(var1, var0);
  }

  var2 = 0;

  foreach(var4 in var1) {
    if(!isDefined(var4.guard.proximitydata)) {
      continue;
    }

    if(var4.guard.proximitydata.currentwarningindex <= var2) {
      continue;
    }

    var2 = var4.guard.proximitydata.currentwarningindex;
  }

  return var2;
}

function level_guardproximityincreasewarning(var0, var1) {
  var2 = var0.guard.proximitydata.currentwarningindex;
  var3 = var0.guard.proximitydata.aicanseeplayer;
  var4 = var0.guard.proximitydata.previousplayerorigin;
  var5 = var0.guard.proximitydata.aitoplayerdistancesq;
  var6 = level.guard.proximitydata.warningfunctions[var2];

  if(isDefined(var6)) {
    GscBinSkip1(0x74, var6, var0, 1, var1);
  }

  var7 = level.guard.proximitydata.warningcooldowntimers[var2];

  if(isDefined(var7)) {
    var0.guard.proximitydata.warningcooldowntime = level.guard.proximitydata.warningcooldowntimers[var2];
  }

  var8 = var2 + 1;
  var9 = level.guard.proximitydata.warningradiusoverridefunctions[var8];
  var10 = [[var9]](var0);
  var11 = level_guardislabordriver(var0) && scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon();
  var12 = level.guard.proximitydata.warningcinderblockradii[var8];

  if(isDefined(var12) && var11) {
    var13 = squared(var12);
  } else if(isDefined(var11)) {
    var13 = squared(var11);
  } else {
    var13 = level.guard.proximitydata.warningradiisq[var10];
  }

  var14 = var7 <= var13;
  var2.guard.proximitydata.playertimenearai = 0;
  var2.guard.proximitydata.previousplayertimenearai = 0;
  var2.guard.proximitydata.currentwarningindex = var10;
  var15 = level.guard.proximitydata.warningsounds[var4];

  if(isDefined(var15) && var4 > level.guard.proximitydata.warningsoundindex) {
    var16 = level.guard.proximitydata.warningsoundentities[var4];
    var16 stoploopsound();
    var16 scalevolume(1, 0.05);
    var16 scripts\engine\utility::delaycall(0.05, &playloopsound, var15);
    level.guard.proximitydata.warningsoundindex = var4;
    thread level_guardcleanupwarningsoundondeathlogic(var2);
    return;
  }
}

function level_guardcleanupwarningsoundondeathlogic(var0) {
  var0 endon("entitydeleted");
  var0 endon("level_guardFight");
  var0 waittill("death");
  var1 = level_gethighestguardwarningindex(var0);
  var2 = var0.guard.proximitydata.currentwarningindex - 1;
  var3 = var2 >= var1;

  if(var3) {
    foreach(var5 in level.guard.proximitydata.warningsoundentities) {
      var5 scalevolume(0, 1.5);
    }

    level.guard.proximitydata.warningsoundindex = 0;
    return;
  }
}

function level_guardplayerproximityshouldcooldownwarning(var0) {
  var1 = var0.guard.proximitydata.currentwarningindex;

  if(level_guardplayerproximityshouldforcemelee(var0)) {
    return false;
  }

  if(scripts\sp\maps\safehouse\safehouse::player_holdingcinderblockweapon() && !level.guard.proximitydata.playerwasholdingcinderblock) {
    return true;
  }

  var2 = anglesToForward(var0.angles);
  var3 = vectorNormalize(level.player getEye() - var0 getEye());
  var4 = vectordot(var3, var2);
  var5 = var4 >= 0.34202;

  if(!var5 && !var0.guard.proximitydata.aicanseeplayer && var0.guard.proximitydata.previouswarningcooldowntime) {
    return true;
  }

  var6 = var0.guard.proximitydata.previouswarningcooldowntime > var0.guard.proximitydata.warningcooldowntime;

  if(!var0.guard.proximitydata.warningcooldowntime && var6) {
    return true;
  }

  return false;
}

function level_guardplayerproximitycooldownwarning(var0, var1) {
  var2 = var0.guard.proximitydata.currentwarningindex - 1;
  var3 = level.guard.proximitydata.warningfunctions[var2];

  if(isDefined(var3)) {
    GscBinSkip1(0x74, var3, var0, 0, var1);
  }

  var4 = level_gethighestguardwarningindex(var0);
  var5 = var2 >= var4;

  if(var5) {
    foreach(var7 in level.guard.proximitydata.warningsoundentities) {
      var7 scalevolume(0, 1.5);
    }

    level.guard.proximitydata.warningsoundindex = 0;
  }

  var0.guard.proximitydata.currentwarningindex = 0;
  var0.guard.proximitydata.playertimenearai = 0;
  var0.guard.proximitydata.warningcooldowntime = 0;
  var0.guard.proximitydata.previouswarningcooldowntime = 0;
}

function level_guardactionlook(var0, var1, var2) {
  level endon("level_guardEndLogic");
  var0 endon("level_guardEndLogic");
  var0 endon("death");
  var0 endon("start_context_melee");
  var0 endon("level_guardFight");

  if(var1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
      return;
    }

    var0 enablescriptedlookat(1);

    if(!var2 && level_isguardanimated(var0)) {
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
      thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0.guard.animationorigin, var0, "level_guardIdleLook" + var0.script_count);
      return;
    }

    var0.ht_on = 1;
    var0 scripts\common\utility::lookatentity(level.player);
    return;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var0, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var0, 0);
    return;
  }

  var0 enablescriptedlookat(0);

  if(!var2 && level_isguardanimated(var0)) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0.guard.animationorigin, var0, "level_guardIdle" + var0.script_count);
    return;
  }

  var0.ht_on = undefined;
  var0 scripts\common\utility::lookatentity();
}

function level_guardactionsuspicious(var0, var1, var2) {
  level endon("level_guardEndLogic");
  var0 endon("level_guardEndLogic");
  var0 endon("death");
  var0 endon("start_context_melee");
  var0 endon("level_guardFight");

  if(var1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var0, 1);
      var0 scripts\common\utility::lookatentity(level.player);
      var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var0 scripts\engine\sp\utility::set_ignoreall(0);
      return;
    }

    var0 enablescriptedlookat(1);

    if(!var2 && level_isguardanimated(var0)) {
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
      thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0.guard.animationorigin, var0, "level_guardIdleLook" + var0.script_count);
      return;
    }

    var0.ht_on = 1;
    var0 scripts\common\utility::lookatentity(level.player);
    return;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var0, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var0, 0);
    var0 scripts\common\utility::lookatentity();
    var0 scripts\engine\sp\utility::set_ignoreall(1);
    return;
  }

  var0 enablescriptedlookat(0);

  if(!var2 && level_isguardanimated(var0)) {
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0.guard.animationorigin, var0, "level_guardIdle" + var0.script_count);
    return;
  }

  var0.ht_on = undefined;
  var0 scripts\common\utility::lookatentity();
}

function level_guardactionthreat(var0, var1, var2) {
  level endon("level_guardEndLogic");
  var0 endon("level_guardEndLogic");
  var0 endon("death");
  var0 endon("start_context_melee");
  var0 endon("level_guardFight");

  if(var1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var0, 1);
      var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var0 scripts\engine\sp\utility::set_ignoreall(0);
      return;
    }

    var3 = var0.script_dialogue;

    if(isDefined(var3)) {
      var4 = var3;
    } else {
      jumpiffalse(level_guardislabordriver(var1)) LOC_00000092;
      var5 = level_guardgetlabordriverthreatlines();
      var4 = var5[var1.guard.voiceindex];
      goto LOC_000000ad;
    }

    LOC_000000ad:
      level_guardplaydialogue(var2, var4, "threat");
    var2 scripts\common\utility::clear_demeanor_override();
    var2 enablescriptedlookat(0);

    if(!var4 && level_isguardanimated(var2)) {
      level_guardactionthreatanimationlogic(var2, level.player.origin, var4);
    }

    var2.dontevershoot = 1;
    var2.dontmelee = 1;
    var2 notify("stop_going_to_node");
    var2 setgoalpos(var2.origin);
    var2 scripts\engine\sp\utility::set_ignoreall(0);
    var2 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    return;
  }

  var4.script_count = 0;

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var4)) {
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var4, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var4, 0);
    var4 scripts\engine\sp\utility::set_ignoreall(1);
    return;
  }

  var4 scripts\common\utility::demeanor_override("casual_gun");
  var7 = level_guardgetlaughlines();
  var8 = var7[var4.guard.voiceindex];
  level_guardplaydialogue(var4, var8, "laugh", 15000);

  if(!var4 && level_isguardanimated(var4)) {
    var4.guard.animationorigin.angles = var4.angles;
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var4);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var4.guard.animationorigin, var4, "level_guardThreatToCasual", "level_guardIdle" + var4.script_count);
  }

  var4 scripts\engine\sp\utility::set_ignoreall(1);
  var4.dontevershoot = 0;
  var4.dontmelee = 0;

  if(isDefined(var4.currentnode)) {
    var4 thread scripts\sp\spawner::go_to_node_internal(var4.currentnode);
    return;
  }
}

function level_guardgetlabordriverthreatlines() {
  return ["dx_vom_ru1_construction_soldiermen_10", "dx_vom_ru2_construction_soldiermen_60", "dx_vom_ru3_construction_soldiermen_80"];
}

function level_guardgetthreatlines() {
  return ["dx_vom_ru1_construction_soldiermen_10", "dx_vom_ru2_construction_soldierwomen_40", "dx_vom_ru3_construction_soldiermen_90"];
}

function level_guardactionthreatanimationlogic(var0, var1, var2) {
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var3 = scripts\engine\utility::flatten_vector(var1 - var0.origin);
  var4 = vectortoangles(var3);
  var0.guard.animationorigin.origin = var0.origin;
  var0.guard.animationorigin.angles = var0.angles;

  if(var2 || !level_isguardanimated(var0)) {
    var0.guard.animationorigin unlink();
  }

  var0 linkTo(var0.guard.animationorigin);
  var5 = "level_guardCasualToThreat" + var0.script_count;
  var6 = getanimlength(var0 scripts\engine\utility::getanim(var5));
  var0.guard.animationorigin rotateTo(var4, var6);
  var0.guard.animationorigin scripts\common\anim::anim_single_solo(var0, var5);
  var0 unlink();

  if(var2 || !level_isguardanimated(var0)) {
    var0.guard.animationorigin linkTo(var0);
    return;
  }
}

function level_guardactionmelee(var0, var1, var2) {
  level endon("level_guardEndLogic");
  var0 endon("level_guardEndLogic");
  var0 endon("death");
  var0 endon("start_context_melee");
  var0 endon("level_guardFight");

  if(var1) {
    if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
      scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var0, 1);
      var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var0 scripts\engine\sp\utility::set_ignoreall(0);
      return;
    }

    var3 = level_guardgetmeleelines();
    var4 = var3[var0.guard.voiceindex];
    level_guardplaydialogue(var0, var4, "melee");
    var0 notify("stop_going_to_node");
    var0 setgoalpos(var0.origin);
    var0 scripts\common\utility::clear_demeanor_override();
    var0.dontevershoot = 1;
    var0.dontmelee = 1;
    var0 scripts\engine\sp\utility::set_ignoreall(0);
    var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var0 scripts\common\utility::lookatentity();

    if(!level_guardplayerinmeleerange(var0)) {
      return;
    }

    if(var2) {
      return;
    }

    var5 = scripts\engine\utility::flatten_vector(level.player.origin - var0.origin);
    var6 = vectortoangles(var5);
    var0.guard.animationorigin.origin = var0.origin;
    var0.guard.animationorigin.angles = var6;
    var0 stopanimScripted();
    var0.animname = "level_guard";
    var0.guard.animationorigin thread scripts\common\anim::anim_single_solo(var0, "level_guardMelee");
    var7 = getanimlength(var0 scripts\engine\utility::getanim("level_guardMelee"));
    var8 = 0.6;
    wait var8;

    if(level_guardplayerinmeleerange(var0)) {
      var9 = vectorNormalize(level.player.origin - var0.origin) * 200;
      level.player setvelocity(var9);
      level.player scripts\sp\utility::do_damage(50, var0.origin);
      level.player playSound("melee_character_vestlight_medium_steel_pri_0_fatal_plr");
      screenshake(var0.origin, 21, 10, 12, 1.7, 0, 0.75, 0, 0.6, 0.6, 0.5);
      var0.guard.meleecount++;

      if(var0.guard.meleecount >= 2) {
        thread level_guardfight(var0, 0);
        return;
      }

      return;
    }

    return;
  }

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var7)) {
    var7.script_count = 0;
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var7, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var7, 0);
    var7 scripts\engine\sp\utility::set_ignoreall(1);
    return;
  }

  var7.script_count = 0;
  var10 = level_guardgetlaughlines();
  var11 = var10[var7.guard.voiceindex];
  level_guardplaydialogue(var7, var11, "laugh", 15000);
  var7 scripts\common\utility::demeanor_override("casual_gun");

  if(!var9 && level_isguardanimated(var7)) {
    var7.guard.animationorigin.angles = var7.angles;
    scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var7);
    thread scripts\sp\maps\safehouse\safehouse_utility::animation_singleintoloop(var7.guard.animationorigin, var7, "level_guardThreatToCasual", "level_guardIdle" + var7.script_count);
  }

  var7 scripts\engine\sp\utility::set_ignoreall(1);
  var7.dontevershoot = 0;
  var7.dontmelee = 0;
  var7 scripts\common\utility::lookatentity();
  var7 unlink();

  if(isDefined(var7.currentnode)) {
    var7 thread scripts\sp\spawner::go_to_node_internal(var7.currentnode);
    return;
  }
}

function level_guardgetmeleelines() {
  return ["dx_vom_ru1_market_soldierpush_30", "dx_vom_ru2_construction_soldiermen_50", "dx_vom_ru3_construction_soldierwomen_90"];
}

function level_guardgetlaughlines() {
  return ["dx_vom_ru1_construction_ruconvo1_100", "dx_vom_ru1_construction_ruconvo1_100", "dx_vom_ru1_construction_ruconvo1_100"];
}

function level_guardactionfight(var0, var1, var2) {
  if(var1) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
      var3 = level_guardgetfightlines();
      var4 = var3[var0.guard.voiceindex];
      level_guardplaydialogue(var0, var4, "fight");
    }

    scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(86);
    thread level_guardfight(var0, 0);
    return;
  }
}

function level_guardgetfightlines() {
  return ["dx_cbc_ru1_reaction_hostile_burst", "dx_cbc_ru1_reaction_hostile_burst", "dx_cbc_ru1_reaction_hostile_burst"];
}

function level_guardplaydialogue(var0, var1, var2, var3) {
  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
    return;
  }

  if(!isDefined(level.guard.dialogue.cooldown[var2])) {
    level.guard.dialogue.cooldown[var2] = 0;
  }

  var4 = gettime();

  if(var4 < level.guard.dialogue.cooldown[var2]) {
    return;
  }

  if(!isDefined(var3)) {
    var3 = 7000;
  }

  level.guard.dialogue.cooldown[var2] = var4 + var3;

  if(!isDefined(var0.animname)) {
    var0.animname = "level_guard";
  }

  var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue(var1);
}

function level_guardfightalertnearbyguards(var0, var1, var2, var3, var4, var5) {
  var6 = var0.origin;
  var7 = var0 getEye();

  if(level.player ismeleeing()) {
    var3 = 0;
  }

  var8 = level_getguards();
  var8 = scripts\engine\utility::array_remove(var8, var0);

  if(!var8.size) {
    return;
  }

  var8 = sortbydistance(var8, var6);

  foreach(var10 in var8) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isalive(var10)) {
      continue;
    }

    var11 = distance(var6, var10.origin);
    var12 = var11 <= 200;

    if(!var12) {
      var13 = var10 getEye();
      var14 = var7;
      var15 = sighttracepassed(var13, var14, 0, level.player, 1);

      if(!var15) {
        continue;
      }

      var16 = var11 <= var1;

      if(!var16) {
        continue;
      }

      var17 = abs(var13[2] - var14[2]);
      var18 = var17 < 100;

      if(var4 && !var18) {
        continue;
      }

      var19 = anglesToForward(var10.angles);
      var20 = vectorNormalize(var14 - var13);
      var21 = vectordot(var20, var19);
      var22 = var21 >= 0.34202;

      if(var2 && !var22) {
        continue;
      }
    }

    thread level_guardfight(var10, var3);
    var23 = randomfloatrange(0.1, 0.2);
    wait var23;
  }
}

function level_guardplayerweapondrawnlogic(var0) {
  var0 endon("level_guardFight");
  var1 = 0;
  var2 = 0;
  var3 = level.player scripts\engine\utility::spawn_script_origin();
  var3 linkTo(level.player);
  thread level_guardplayerweapondrawncleanupsoundlogic(var0, var3);

  for(;;) {
    waitframe();

    if(!level_guardcanseeplayerdrawnweapon(var0)) {
      if(var1) {
        var3 scalevolume(0, 1.5);
        var1 = 0;
        var0 scripts\common\utility::lookatentity();
      }

      var2 = max(var2 - 0.05, 0);
      continue;
    }

    level.player playRumbleOnEntity("damage_heavy");
    var4 = distance(var0.origin, level.player.origin);
    var5 = var4 <= 250;

    if(!var2 && !var5) {
      scripts\engine\sp\utility::display_hint_forced("holster_weapon", 5, undefined, level.player, "weapon_fired");
      var3 scalevolume(1, 0);
      var3 playLoopSound("ui_stealth_threat_high_lp");
      var1 = 1;
      var0.guard.playerweapondrawnseencount++;

      if(var0.guard.playerweapondrawnseencount >= 3) {
        var6 = scripts\sp\maps\safehouse\safehouse_utility::level_getsafehousecustomdeathhintindex();

        if(scripts\engine\utility::is_equal(var6, 90)) {
          scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(87);
        } else {
          scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(85);
        }

        if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
          var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_cbc_ru2_combat_location_resp_crate", 0.25, var0, "death");
        }

        thread level_guardfight(var0, 0);
        return;
      }

      var0 scripts\common\utility::lookatentity(level.player);
    }

    var2 += 0.05;
    var7 = scripts\engine\math::normalize_value(250, 950, var4);
    var8 = scripts\engine\math::factor_value(1, 3.5, var7);
    var9 = var2 >= var8;
    var10 = level.player attackButtonPressed();

    if(var5 || var9 || var10) {
      var6 = scripts\sp\maps\safehouse\safehouse_utility::level_getsafehousecustomdeathhintindex();

      if(scripts\engine\utility::is_equal(var6, 90)) {
        scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(87);
      } else {
        scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(85);
      }

      if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
        var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_cbc_ru2_combat_location_resp_crate", 0.2, var0, "death");
      }

      thread level_guardfight(var0, 0);
      break;
    }
  }
}

function level_guardplayerweapondrawncleanupsoundlogic(var0, var1) {
  var0 scripts\engine\utility::waittill_any("level_guardFight", "damage", "death", "entitydeleted");
  var1 thread scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
}

function level_guardplayergrenadethrowinglogic(var0) {
  var0 endon("level_guardFight");
  var1 = 0;
  var2 = 0;
  var3 = level.player scripts\engine\utility::spawn_script_origin();
  var3 linkTo(level.player);
  thread level_guardplayergrenadethrowcleanupsoundlogic(var0, var3);

  for(;;) {
    waitframe();

    if(!level_guardcanseeplayergrenadethrowing(var0)) {
      if(var1) {
        var3 scalevolume(0, 1.5);
        var1 = 0;
        var0 scripts\common\utility::lookatentity();
      }

      var2 = max(var2 - 0.05, 0);
      continue;
    }

    level.player playRumbleOnEntity("damage_heavy");
    var4 = distancesquared(var0.origin, level.player.origin);
    var5 = var4 <= 90000;

    if(!var2 && !var5) {
      var6 = ["offhand_fired", "offhand_end", "actionslot 1"];
      scripts\engine\sp\utility::display_hint("holster_grenade", 5, undefined, level.player, var6);
      var3 scalevolume(1, 0);
      var3 playLoopSound("ui_stealth_threat_high_lp");
      var1 = 1;
      var0 scripts\common\utility::lookatentity(level.player);
    }

    var2 += 0.05;
    var7 = scripts\engine\math::normalize_value(90000, 1690000, var4);
    var8 = scripts\engine\math::factor_value(1, 4, var7);
    var9 = var2 >= var8;
    GscBinSkip4(0x35, var0);
  }
}

function level_guardplayergrenadethrowcleanupsoundlogic(var0, var1) {
  var0 scripts\engine\utility::waittill_any("level_guardFight", "damage", "death", "entitydeleted");
  var1 thread scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
}

function level_guardseeplayergrenadethrowlogic(var0) {
  level endon("level_guardEndLogic");
  level.player endon("offhand_end");
  var0 endon("level_guardEndLogic");
  level.player waittill("offhand_fired");
  level_guardsawplayergrenadealertlogic(var0);
}

function level_guardsawplayergrenadealertlogic(var0) {
  scripts\sp\maps\safehouse\safehouse_utility::level_setcustomdeathhintindex(96);

  if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
    var0 thread scripts\sp\maps\safehouse\safehouse_utility::dialogue("dx_cbc_ru2_combat_location_resp_crate", 0.25, var0, "death");
  }

  thread level_guardfight(var0, 0);
}

function level_guardcanseeplayerdrawnweapon(var0) {
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

  var1 = distance(var0.origin, level.player.origin);
  var2 = var1 <= 950;

  if(!var2) {
    return false;
  }

  var3 = var0 getEye();
  var4 = level.player getEye();
  var5 = sighttracepassed(var3, var4, 0, level.player, 1);

  if(!var5) {
    return false;
  }

  var6 = anglesToForward(var0.angles);
  var7 = vectorNormalize(var4 - var3);
  var8 = vectordot(var7, var6);

  if(var1 <= 250) {
    var9 = 0.34202;
  } else {
    var9 = 0.819152;
  }

  var10 = var9 >= var9;

  if(!var10) {
    return false;
  }

  return true;
}

function level_guardcanseeplayergrenadethrowing(var0) {
  if(!level.player isthrowinggrenade()) {
    return false;
  }

  var1 = distance(var0.origin, level.player.origin);
  var2 = var1 <= 950;

  if(!var2) {
    return false;
  }

  var3 = var0 getEye();
  var4 = level.player getEye();
  var5 = sighttracepassed(var3, var4, 0, level.player, 1);

  if(!var5) {
    return false;
  }

  var6 = anglesToForward(var0.angles);
  var7 = vectorNormalize(var4 - var3);
  var8 = vectordot(var7, var6);
  var9 = var8 >= 0.819152;

  if(!var9) {
    return false;
  }

  return true;
}

function level_guardfight(var0, var1) {
  var0 endon("death");
  var0 endon("entitydeleted");

  foreach(var3 in level.guard.proximitydata.warningsoundentities) {
    var3 scalevolume(0, 1.5);
  }

  var5 = level_getalertedguards();

  if(scripts\engine\utility::array_contains(var5, var0)) {
    return;
  }

  var0 notify("level_guardFight");
  var0 notify("stop_going_to_node");
  var0 unlink();
  scripts\sp\maps\safehouse\safehouse_utility::ai_endpathlogic(var0);
  level_guardremoveai(var0);
  level_guardaddalertedai(var0);
  level notify("level_guardFight", var0);
  level_guardhideholesightblockerclips();
  thread level_guardfightshowsightblockerclipslogic(var0);

  if(scripts\sp\maps\safehouse\safehouse_utility::ai_isdog(var0)) {
    var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var0 scripts\engine\sp\utility::set_ignoreall(0);
    var0 scripts\engine\sp\utility::set_ignoreme(0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcebark(var0, 0);
    scripts\sp\maps\safehouse\safehouse_utility::ai_dogforcegrowl(var0, 0);
    thread scripts\sp\maps\safehouse\safehouse_utility::ai_dogfightbarklogic(var0);
    var0.dontevershoot = 0;
    var0.dontmelee = 0;
  } else {
    if(!istrue(var0.script_deathchain)) {
      var0 scripts\engine\sp\utility::anim_stopanimScripted();
      scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
    }

    if(var1 && !istrue(var0.script_nosurprise)) {
      level_guardreactlogic(var0, level.player.origin);
      var6 = level_guardfightlines();
      var7 = scripts\engine\utility::random(var6);
      level_guardplaydialogue(var0, var7, "fight");
    }

    var0 scripts\common\utility::clear_demeanor_override();
    var0 scripts\engine\sp\utility::set_ignoreall(0);
    var0 scripts\engine\sp\utility::set_ignoreme(0);
    var0 scripts\sp\maps\safehouse\safehouse_utility::ai_resetstances();
    var0 scripts\common\utility::lookatentity();
    var0 getenemyinfo(level.player);
    var0.script_forcegoal = undefined;
    var0 scripts\engine\sp\utility::set_goalRadius(512);
    var0 scripts\common\ai::gun_recall();
    var0 scripts\engine\sp\utility::set_baseaccuracy(3);
    var0.aggressivemode = 1;
    var0.lastenemysightpos = level.player.origin;
    var0 scripts\engine\sp\utility::set_battlechatter(1);
    var0 scripts\engine\sp\utility::disable_surprise();
    var0 scripts\engine\sp\utility::set_favoriteenemy(level.player);
    var0 clearentitytarget();
    var0 scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::set_grenadeammo, 2);
    var0.dontevershoot = 0;
    var0.dontmelee = 0;
  }

  var0 setgoalentity(level.player);
  var0.goalheight = 80;
}

function level_guardfightlines() {
  return ["dx_cst_ru1_combat_generic_10", "dx_cst_ru2_combat_generic_10", "dx_cst_ru3_combat_generic_10"];
}

function level_guardfightalertguardslogic() {
  for(;;) {
    level waittill("level_guardFight", var0);

    if(istrue(var0.script_engage) && level_getguards().size > 1) {
      level_guardsetallalerted(var0.origin);
    }

    level_guardfightalertnearbyguards(var0, 300, 0, 1, 0, "guard_fight_nearby_instant");
    level_guardfightalertnearbyguards(var0, 500, 1, 0, 0, "guard_fight_nearby_fov");
  }
}

function level_guardallalertedcivilianslogic() {
  for(;;) {
    level waittill("level_guardsAllAlerted");
    var0 = level_guardgetcivilians();

    foreach(var2 in var0) {
      thread level_guardcivilianalertedlogic(var2);
    }
  }
}

function level_guardfightalertnearbycivilianslogic() {
  for(;;) {
    level waittill("level_guardFight", var0);

    if(!isDefined(var0)) {
      continue;
    }

    thread level_guardfightalertnearbycivilians(var0.origin);
  }
}

function level_guardfightvolumealertcivilianslogic() {
  level waittill("level_guardVolumeAlerted", var0);
  var1 = level_guardgetciviliansingroupvolumes(var0);

  foreach(var3 in var1) {
    level_guardcivilianalertedlogic(var3);
  }
}

function level_guardfightalertnearbycivilians(var0) {
  var1 = 0.05;
  var2 = 0.1;
  var3 = level_guardgetcivilians();
  var3 = sortbydistance(var3, var0);

  foreach(var5 in var3) {
    if(!isDefined(var5)) {
      continue;
    }

    if(!isalive(var5)) {
      continue;
    }

    if(distance(var5.origin, var0) > 600) {
      continue;
    }

    level_guardcivilianalertedlogic(var5);
    wait randomfloatrange(var1, var2);
  }
}

function level_guardfightshowsightblockerclipslogic(var0) {
  var0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  var1 = level_getalertedguards();

  if(var1.size) {
    return;
  }

  level_guardshowholesightblockerclips();
}

function level_guardfightmusiclogic() {
  var0 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  var0 linkTo(level.player);
  var1 = 2;
  var2 = 1;
  var3 = 3;

  for(;;) {
    level waittill("level_guardFight");
    wait var1;

    if(!level_getalertedguards().size) {
      continue;
    }

    level_waittillplayerclearedalertedguards();
  }
}

function level_guardplayerinmeleerange(var0) {
  return distancesquared(var0.origin, level.player.origin) <= 10000;
}

function level_guardislabordriver(var0) {
  return scripts\engine\utility::is_equal(var0.script_parameters, "level_guardLaborDriver");
}

function level_guarddamagelogic(var0) {
  var0 endon("level_guardFight");

  for(;;) {
    var0 waittill("damage", var1, var2);

    if(!isDefined(var2)) {
      return;
    }

    if(var2 != level.player) {
      return;
    }

    var3 = var0.origin;
    var4 = level_guardgetdamagelines();
    var5 = var4[var0.guard.voiceindex];
    level_guardplaydialogue(var0, var5, "damage");
    thread level_guardfight(var0, 1);
    break;
  }
}

function level_guardgetdamagelines() {
  return ["dx_cst_ru1_damage_generic_10", "dx_cst_ru2_damage_generic_10", "dx_cst_ru3_damage_generic_10"];
}

function level_guardwhizbylogic(var0) {
  var0 endon("level_guardFight");

  for(;;) {
    var0 waittill("bulletwhizby");
    var1 = var0 getEye();
    var2 = level.player getEye();
    var3 = scripts\engine\trace::create_shotclip_contents();
    var4 = scripts\engine\trace::ray_trace_detail_passed(var1, var2, [level.player, var0], var3);

    if(!var4) {
      continue;
    }

    var5 = distancesquared(level.player.origin, var0.origin);

    if(var5 <= 30625) {
      break;
    }

    var6 = anglesToForward(level.player getplayerangles());
    var7 = vectorNormalize(var0 getEye() - level.player getEye());
    var8 = vectordot(var7, var6);
    var9 = var8 >= 0.939693;

    if(!var9) {
      continue;
    }

    break;
  }

  var10 = level_guardgetwhizbylines();
  var11 = var10[var0.guard.voiceindex];
  level_guardplaydialogue(var0, var11, "whizby");
  thread level_guardfight(var0, 1);
}

function level_guardgetwhizbylines() {
  return ["dx_cst_ru1_bulletwhizby_generic_10", "dx_cst_ru2_bulletwhizby_generic_10", "dx_cst_ru3_bulletwhizby_generic_10"];
}

function level_guardcorpsedetectlogic(var0) {
  var0 endon("level_guardFight");
  var1 = 500;
  var2 = 0.5;

  for(;;) {
    wait var2;
    var3 = level_guardgetcorpses();
    var4 = var0 getEye();

    foreach(var6 in var3) {
      var7 = var6.origin;
      var8 = sighttracepassed(var4, var7, 0, level.player);

      if(!var8) {
        continue;
      }

      var9 = scripts\engine\utility::within_fov(var4, var0.angles, var7, 0.5);

      if(!var9) {
        continue;
      }

      var10 = distance(var4, var7);

      if(var10 > var1) {
        continue;
      }

      var11 = level_guardgetcorpselines();
      var12 = var11[var0.guard.voiceindex];
      level_guardplaydialogue(var0, var12, "corpse");
      thread level_guardfight(var0, 1);
    }
  }
}

function level_guardgetcorpselines() {
  return ["dx_cst_ru1_saw_corpse_10", "dx_cst_ru2_saw_corpse_10", "dx_cst_ru3_saw_corpse_10"];
}

function level_guarddeathalertotherslogic(var0) {
  level endon("level_guardEndLogic");
  var0 endon("entitydeleted");
  var0 endon("level_guardEndLogic");
  var0 waittill("death", var1);

  if(!isDefined(var1)) {
    return;
  }

  if(var1 != level.player) {
    return;
  }

  level_guardspawncorpsestruct(var0);
  thread level_guardfightalertnearbyguards(var0, 300, 0, 1, 1, "nearby_death");
}

function level_guardspawncorpsestruct(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin + (0, 0, 10);
  level.guard.corpses = scripts\engine\utility::array_add(level.guard.corpses, var1);
}

function level_guardgetcorpses() {
  return level.guard.corpses;
}

function level_guardclearcorpses() {
  level.guard.corpses = [];
}

function level_guardreactlogic(var0, var1, var2) {
  var0 endon("damage");
  var0 endon("death");
  var0 endon("entitydeleted");
  var3 = 0.05;
  var4 = 0.15;
  wait randomfloatrange(var3, var4);

  if(!isalive(var0)) {
    return;
  }

  var0.guard.animationorigin.origin = var0.origin;
  var0.guard.animationorigin.angles = var0.angles;
  var5 = scripts\engine\utility::flatten_vector(var1 - var0.origin);
  var6 = vectortoangles(var5);

  if(!level_isguardanimated(var0)) {
    var0.guard.animationorigin unlink();
  }

  var0 linkTo(var0.guard.animationorigin);
  var0.animname = "level_guard";
  var7 = "level_guardReact" + level.guard.reactionindex;
  level.guard.reactionindex = scripts\engine\math::wrap(0, level_guardgetreactionanimations().size - 1, level.guard.reactionindex + 1);
  var8 = getanimlength(var0 scripts\engine\utility::getanim(var7));
  var0.guard.animationorigin rotateTo(var6, var8);
  thread level_guardreactdamagelogic(var0);
  var0.guard.animationorigin scripts\common\anim::anim_single_solo(var0, var7);
  var0 unlink();

  if(!level_isguardanimated(var0)) {
    var0.guard.animationorigin linkTo(var0);
    return;
  }
}

function level_guardreactdamagelogic(var0) {
  thread scripts\sp\maps\safehouse\safehouse_utility::animation_notifyonnotetrack(var0, "end");
  var0 endon("end");
  var0 endon("death");
  var0 waittill("damage", var1, var2, var3, var4);
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var0 kill(var4, var2);
}

function level_guardshootalertotherslogic(var0) {
  for(;;) {
    var0 waittill("shooting");

    if(!scripts\engine\utility::is_equal(var0.enemy, level.player)) {
      continue;
    }

    if(!level_guardisentitytouchinganygroupvolume(var0) || !level_guardisentitytouchinganygroupvolume(level.player)) {
      level_guardsetallalerted(var0.origin);
      continue;
    }

    level_alertguardsinentitygroupvolumes(var0, 1);
    level_alertguardsinentitygroupvolumes(level.player, 1);
  }
}

function level_guardseenplayerpronelogic(var0) {
  var0 endon("level_guardFight");
  var1 = 1.5;
  var2 = 2.5;

  for(var3 = 0;; var3 = 1) {
    waitframe();

    if(!level_guardcanseeplayerprone(var0)) {
      if(isDefined(var0.guard.proximitydata) && var3) {
        var4 = randomfloatrange(var1, var2);
        wait var4;
        var0.guard.proximitydata.overridewarningindex = undefined;
      }

      var3 = 0;
      continue;
    }

    var0.guard.playerseenproneduration += 0.05;

    if(var0.guard.playerseenproneduration >= 5) {
      thread level_guardfight(var0, 0);
      return;
    }

    level.player playRumbleOnEntity("damage_heavy");

    if(!isDefined(var0.guard.proximitydata)) {
      var3 = 1;
      continue;
    }

    if(!var3) {
      var5 = level_guardgetseenplayeractgoofylines();
      var6 = var5[var0.guard.voiceindex];
      level_guardplaydialogue(var0, var6, "player_goofy");
      var0.guard.proximitydata.overridewarningindex = 2;
    }
  }
}

function level_guardgetseenplayeractgoofylines() {
  return ["dx_vom_ru1_construction_carry_10", "dx_vom_ru2_construction_soldiermen_40", "dx_vom_ru3_construction_carry_30"];
}

function level_guardgetplayerpronelines() {
  return ["dx_vom_ru1_construction_carry_10", "dx_vom_ru2_return_disperse_20", "dx_vom_ru3_construction_carry_30"];
}

function level_guardcanseeplayerprone(var0) {
  if(scripts\engine\utility::flag("level_guardInstantDetectPlayer")) {
    return false;
  }

  if(!scripts\sp\maps\safehouse\safehouse_utility::player_isprone()) {
    return false;
  }

  var1 = var0 getEye();
  var2 = level.player getEye();
  var3 = sighttracepassed(var1, var2, 0, level.player);

  if(!var3) {
    return false;
  }

  var4 = distance(level.player.origin, var0.origin);

  if(var4 > 400) {
    return false;
  }

  var5 = scripts\engine\utility::within_fov(var1, var0.angles, var2, 0.5);

  if(!var5) {
    return false;
  }

  return true;
}

function level_guardseenplayermeleelogic(var0) {
  var0 endon("level_guardFight");
  var1 = 3.5;

  for(;;) {
    level.player waittill("melee_swipe_start");

    if(scripts\engine\utility::flag("level_guardInstantDetectPlayer")) {
      continue;
    }

    var2 = var0 getEye();
    var3 = level.player getEye();
    var4 = sighttracepassed(var2, var3, 0, level.player);

    if(!var4) {
      continue;
    }

    var5 = scripts\engine\utility::within_fov(var2, var0.angles, var3, 0.5);

    if(!var5) {
      continue;
    }

    var6 = scripts\engine\utility::within_fov(var3, level.player.angles, var2, 0.34202);

    if(!var6) {
      continue;
    }

    var7 = distance(level.player.origin, var0.origin);

    if(var7 > 600) {
      continue;
    }

    var0.guard.playermeleeseencount++;

    if(var0.guard.playermeleeseencount >= 2) {
      thread level_guardfight(var0, 0);
      return;
    }

    thread level_guardseenplayermeleeeffectslogic();
    var8 = level_guardgetseenplayermeleelines();
    var9 = var8[var0.guard.voiceindex];
    level_guardplaydialogue(var0, var9, "player_melee");

    if(!isDefined(var0.guard.proximitydata)) {
      continue;
    }

    var0.guard.proximitydata.overridewarningindex = 2;
    wait var1;
    var0.guard.proximitydata.overridewarningindex = undefined;
  }
}

function level_guardgetseenplayermeleelines() {
  return ["dx_vom_ru1_construction_soldiermen_20", "dx_vom_ru2_market_soldierpush_40", "dx_vom_ru3_construction_soldierwomen_90"];
}

function level_guardseenplayermeleeeffectslogic() {
  var0 = 2;
  var1 = 1;
  var2 = scripts\engine\sp\utility::get_rumble_ent();
  var2 scripts\engine\sp\utility::set_rumble_intensity(1);
  var3 = level.player scripts\engine\utility::spawn_script_origin();
  var3 linkTo(level.player);
  var3 playLoopSound("ui_stealth_threat_high_lp");
  wait var0;
  var2 scripts\engine\sp\utility::rumble_ramp_off(var1);
  var3 scripts\engine\sp\utility::sound_fade_and_delete(var1, 1);
}

function level_guardseenplayerjumplogic(var0) {
  var0 endon("level_guardFight");
  var1 = 3.5;

  for(;;) {
    level.player waittill("jump_pressed");

    if(scripts\engine\utility::flag("level_guardInstantDetectPlayer")) {
      continue;
    }

    var2 = var0 getEye();
    var3 = level.player getEye();
    var4 = sighttracepassed(var2, var3, 0, level.player);

    if(!var4) {
      continue;
    }

    var5 = scripts\engine\utility::within_fov(var2, var0.angles, var3, 0.5);

    if(!var5) {
      continue;
    }

    var6 = distance(level.player.origin, var0.origin);

    if(var6 > 300) {
      continue;
    }

    var0.guard.playerjumpseencount++;

    if(var0.guard.playerjumpseencount <= 1) {
      thread level_guardseenplayerjumpeffectslogic();
      continue;
    }

    if(var0.guard.playerjumpseencount >= 3) {
      thread level_guardfight(var0, 0);
      return;
    }

    thread level_guardseenplayerjumpeffectslogic();
    var7 = level_guardgetseenplayeractgoofylines();
    var8 = var7[var0.guard.voiceindex];
    level_guardplaydialogue(var0, var8, "player_goofy");

    if(!isDefined(var0.guard.proximitydata)) {
      continue;
    }

    var0.guard.proximitydata.overridewarningindex = 2;
    wait var1;
    var0.guard.proximitydata.overridewarningindex = undefined;
  }
}

function level_guardseenplayerjumpeffectslogic() {
  var0 = 1.5;
  var1 = 1.5;
  var2 = scripts\engine\sp\utility::get_rumble_ent();
  var2 scripts\engine\sp\utility::set_rumble_intensity(1);
  var3 = level.player scripts\engine\utility::spawn_script_origin();
  var3 linkTo(level.player);
  var3 playLoopSound("ui_stealth_threat_high_lp");
  wait var0;
  var2 scripts\engine\sp\utility::rumble_ramp_off(var1);
  var3 scripts\engine\sp\utility::sound_fade_and_delete(var1, 1);
}

function level_guardmeleedalertotherslogic(var0) {
  for(;;) {
    var0 waittill("melee_attack");

    if(!level_guardisentitytouchinganygroupvolume(var0) || !level_guardisentitytouchinganygroupvolume(level.player)) {
      level_guardsetallalerted(var0.origin);
      continue;
    }

    level_alertguardsinentitygroupvolumes(var0, 1);
    level_alertguardsinentitygroupvolumes(level.player, 1);
  }
}

function level_guardsetallalerted(var0) {
  var1 = level_getguards();

  if(isDefined(var0)) {
    var1 = sortbydistance(var1, var0);
  }

  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    if(!isalive(var3)) {
      continue;
    }

    var4 = level_getentitytouchinggroupvolumes(var3);
    level_setgroupvolumesalerted(var4);

    if(istrue(var3.script_killspawner)) {
      var3 scripts\engine\sp\utility::ai_ragdoll_immediate();
      continue;
    }

    thread level_guardfight(var3, 0);
  }

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    scripts\engine\utility::flag_set("level_guardsStealthBroken");
    thread level_guardsalertedclearstealthflaglogic();
  }

  scripts\engine\utility::flag_set("level_guardsAllAlerted");
  scripts\engine\utility::flag_set("disable_autosaves");
}

function level_guardcivilianlogic(var0) {
  level_guardaddcivilian(var0);
  thread level_guardciviliandeathalertotherslogic(var0);
}

function level_guardciviliandeathalertotherslogic(var0) {
  var0 endon("entitydeleted");

  for(;;) {
    var0 waittill("death", var1);

    if(!scripts\engine\utility::is_equal(var1, level.player)) {
      continue;
    }

    level_guardciviliandeathalertnearbyguards(var0, 300, 0, 1, 0, "civilian_damaged_nearby_instant");
    level_guardciviliandeathalertnearbyguards(var0, 800, 1, 0, 0, "civilian_damaged_nearby_fov");
    level_guardciviliandeathalertnearbycivilians(var0, 300, 0, 0, "civilian_damaged_nearby_instant");
    level_guardciviliandeathalertnearbycivilians(var0, 800, 1, 0, "civilian_damaged_nearby_fov");
  }
}

function level_guardciviliandeathalertnearbyguards(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var0)) {
    return;
  }

  var6 = var0.origin;
  var7 = var0 gettagorigin("J_HEAD");
  var8 = level_getguards();
  var8 = scripts\engine\utility::array_remove(var8, var0);

  if(!var8.size) {
    return;
  }

  var8 = sortbydistance(var8, var6);

  foreach(var10 in var8) {
    if(!scripts\sp\maps\safehouse\safehouse_utility::ai_isalive(var10)) {
      continue;
    }

    var11 = distance(var6, var10.origin);
    var12 = var11 <= 200;

    if(!var12) {
      var13 = var10 getEye();
      var14 = var7;
      var15 = sighttracepassed(var13, var14, 0, level.player, 1);

      if(!var15) {
        continue;
      }

      var16 = var11 <= var1;

      if(!var16) {
        continue;
      }

      var17 = abs(var13[2] - var14[2]);
      var18 = var17 < 100;

      if(var4 && !var18) {
        continue;
      }

      var19 = anglesToForward(var10.angles);
      var20 = vectorNormalize(var14 - var13);
      var21 = vectordot(var20, var19);
      var22 = var21 >= 0.34202;

      if(var2 && !var22) {
        continue;
      }
    }

    thread level_guardfight(var10, 1);
    var23 = randomfloatrange(0.1, 0.2);
    wait var23;
  }
}

function level_guardciviliandeathalertnearbycivilians(var0, var1, var2, var3, var4) {
  if(!isDefined(var0)) {
    return;
  }

  var5 = var0.origin;
  var6 = var0 gettagorigin("J_HEAD");
  var7 = level_guardgetcivilians();
  var7 = scripts\engine\utility::array_remove(var7, var0);

  if(!var7.size) {
    return;
  }

  var7 = sortbydistance(var7, var5);

  foreach(var9 in var7) {
    if(!isDefined(var9)) {
      return 0;
    }

    if(!isalive(var9)) {
      return 0;
    }

    var10 = distance(var5, var9.origin);
    var11 = var9 gettagorigin("J_HEAD");
    var12 = var5;
    var13 = var10 <= var1;

    if(!var13) {
      continue;
    }

    var14 = abs(var11[2] - var12[2]);
    var15 = var14 < 100;

    if(var3 && !var15) {
      continue;
    }

    var16 = anglesToForward(var9.angles);
    var17 = vectorNormalize(var12 - var11);
    var18 = vectordot(var17, var16);
    var19 = var18 >= 0.34202;

    if(var2 && !var19) {
      continue;
    }

    level_guardcivilianalertedlogic(var9);
    var20 = randomfloatrange(0.1, 0.2);
    wait var20;
  }
}

function level_guardcivilianalertedlogic(var0) {
  var1 = level_guardgetalertedcivilians();

  if(scripts\engine\utility::array_contains(var1, var0)) {
    return;
  }

  level_guardremovecivilian(var0);
  level_guardaddalertedcivilian(var0);

  if(istrue(var0.script_threshold)) {
    return;
  }

  if(istrue(var0.script_killspawner)) {
    var0 scripts\engine\sp\utility::ai_ragdoll_immediate();
    return;
  }

  var0 notify("level_civilianAlerted");
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  var0.script_pushable = 1;
  var0.pushable = 1;
  var2 = level_guardgetcivilianalertedanimation(var0);

  if(!isDefined(var2)) {
    var0.animname = "level_guardCivilian";
    level.guard.alerted.civiliancowerindex = scripts\engine\math::wrap(0, level_guardgetcivilianalertedanimations().size - 1, level.guard.alerted.civiliancowerindex + 1);
    var2 = "level_guardCivilianAlerted" + level.guard.alerted.civiliancowerindex;
  }

  thread scripts\sp\maps\safehouse\safehouse_utility::animation_loop(var0, var0, var2);
  var3 = var0 scripts\engine\utility::getanim(var2)[0];
  var4 = getanimlength(var3);
  var5 = randomfloat(var4) / var4;
  var0 scripts\engine\utility::delaycall(0.05, &setanimtime, var3, var5);
}

function level_guardsetcivilianalertedanimation(var0, var1) {
  var0.alertedanimationname = var1;
}

function level_guardgetcivilianalertedanimation(var0) {
  return var0.alertedanimationname;
}

function level_guardaddcivilian(var0) {
  level.guard.civilians = scripts\engine\utility::array_add(level.guard.civilians, var0);
}

function level_guardremovecivilian(var0) {
  level.guard.civilians = scripts\engine\utility::array_remove(level.guard.civilians, var0);
}

function level_guardgetcivilians() {
  return scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(level.guard.civilians);
}

function level_guardaddalertedcivilian(var0) {
  level.guard.alerted.civilians = scripts\engine\utility::array_add(level.guard.alerted.civilians, var0);
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
    var0 = level_getguards().size == 0;

    if(var0) {
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
    level.player waittill("grenade_fire", var0);
    var1 = level_getguards().size == 0;

    if(var1) {
      continue;
    }

    thread level_guardplayerthrownoffhandalertlogic(var0);
  }
}

function level_guardplayerthrownoffhandalertlogic(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 endon("missile_stuck");
  var1 = 50;

  for(;;) {
    var2 = level_getguards();

    foreach(var4 in var2) {
      if(distance(var4 getEye(), var0.origin) > var1) {
        continue;
      }

      var5 = var4 getEye();
      var6 = level.player getEye();
      var7 = scripts\engine\trace::create_shotclip_contents();
      var8 = scripts\engine\trace::ray_trace_detail_passed(var5, var6, [level.player, var4], var7);

      if(!var8) {
        continue;
      }

      thread level_guardfight(var4, 1);
    }

    waitframe();
  }
}

function level_teleportguard(var0, var1, var2, var3) {
  var0 forceteleport(var1, var2);
  var0.guard.animationorigin.origin = var1;
  var0.guard.animationorigin.angles = var2;

  if(istrue(var3)) {
    level_resetguardlogic(var0);
    return;
  }
}

function level_resetguardlogic(var0) {
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\sp\maps\safehouse\safehouse_utility::animation_stoploop(var0);
  ai_endguardlogic(var0);
  waitframe();
  level_guardlogic(var0, 1, 0);
}

function level_isaiguard(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isalive(var0)) {
    return false;
  }

  return isDefined(var0.guard);
}

function level_isguardanimated(var0) {
  return isDefined(var0.script_animation) && istrue(int(var0.script_animation));
}

function level_guardisplayerinhiddenvolume() {
  var0 = level_getguardplayerhiddenvolumes();

  foreach(var2 in var0) {
    if(!level.player istouching(var2)) {
      continue;
    }

    return true;
  }

  return false;
}

function level_getguardplayerhiddenvolumes() {
  return getEntArray("level_guardPlayerHiddenVolume", "targetname");
}

function level_alertguardsinentitygroupvolumes(var0, var1) {
  var2 = level_getentitytouchinggroupvolumes(var0);
  level_setgroupvolumesalerted(var2);
  var3 = level_getguardsingroupvolumes(var2);
  var3 = sortbydistance(var3, var0.origin);

  if(!var3.size) {
    var4 = level_getalertedguards();

    if(var4.size && !scripts\engine\utility::flag("level_guardsStealthBroken")) {
      scripts\engine\utility::flag_set("level_guardsStealthBroken");
      scripts\engine\utility::flag_set("disable_autosaves");
      thread level_guardsalertedclearstealthflaglogic();
    }

    return;
  }

  foreach(var6 in var4) {
    if(istrue(var6.script_killspawner)) {
      var6 scripts\engine\sp\utility::ai_ragdoll_immediate();
      continue;
    }

    thread level_guardfight(var6, var2);
  }

  if(!scripts\engine\utility::flag("level_guardsStealthBroken")) {
    scripts\engine\utility::flag_set("level_guardsStealthBroken");
    scripts\engine\utility::flag_set("disable_autosaves");
    thread level_guardsalertedclearstealthflaglogic();
    return;
  }
}

function level_getguardsingroupvolumes(var0) {
  var1 = level_getguards();

  foreach(var3 in var1) {
    var4 = 0;

    foreach(var6 in var0) {
      if(var3 istouching(var6)) {
        var4 = 1;
        break;
      }
    }

    if(!var4) {
      var1 = scripts\engine\utility::array_remove(var1, var3);
    }
  }

  return var1;
}

function level_guardgetciviliansingroupvolumes(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  var1 = level_guardgetcivilians();

  foreach(var3 in var1) {
    var4 = 0;

    foreach(var6 in var0) {
      if(var3 istouching(var6)) {
        var4 = 1;
        break;
      }
    }

    if(!var4) {
      var1 = scripts\engine\utility::array_remove(var1, var3);
    }
  }

  return var1;
}

function level_guardisentitytouchinganygroupvolume(var0) {
  var1 = level_getentitytouchinggroupvolumes(var0);
  return var1.size > 0;
}

function level_getentitytouchinggroupvolumes(var0) {
  var1 = level_getguardgroupvolumes();

  foreach(var3 in var1) {
    if(var0 istouching(var3)) {
      continue;
    }

    var1 = scripts\engine\utility::array_remove(var1, var3);
  }

  return var1;
}

function level_setgroupvolumesalertedbygroupname(var0) {
  var1 = level_getguardgroupvolumes();

  foreach(var3 in var1) {
    if(!scripts\engine\utility::is_equal(var3.groupname, var0)) {
      continue;
    }

    level_setgroupvolumesalerted(var3);
  }
}

function level_setgroupvolumesalerted(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var2 in var0) {
    if(level_isgroupvolumealerted(var2)) {
      continue;
    }

    level notify("level_guardVolumeAlerted", var2);

    if(isDefined(var2.groupname)) {
      level notify("level_guardVolumeAlerted" + var2.groupname);
    }

    var3 = var2 scripts\engine\sp\utility::get_linked_spawners();
    var4 = scripts\engine\sp\utility::array_spawn(var3, 0, 1);

    foreach(var6 in var4) {
      level_guardassignweapon(var6);
      thread level_guardfight(var6, 0);
    }

    level.guard.alerted.volumes = scripts\engine\utility::array_add(level.guard.alerted.volumes, var2);
  }
}

function level_setclearalertedgroupnamevolumes(var0) {
  var1 = level_getalertedgroupvolumes();

  foreach(var3 in var1) {
    if(!scripts\engine\utility::is_equal(var3.groupname, var0)) {
      continue;
    }

    level.guard.alerted.volumes = scripts\engine\utility::array_remove(level.guard.alerted.volumes, var3);
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

function level_isgroupvolumealerted(var0) {
  var1 = level_getalertedgroupvolumes();

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3, var0)) {
      return true;
    }
  }

  return false;
}

function level_isgroupnamevolumealerted(var0) {
  var1 = level_getalertedgroupvolumes();

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.groupname, var0)) {
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

function level_guarddoggrowllogic(var0) {
  var0 endon("death");
  var1 = 1.5;
  var2 = 2.5;

  for(;;) {
    if(!istrue(var0.forcegrowl)) {
      waitframe();
      continue;
    }

    var0 playSound("anml_dog_growl", "ai_guardDogGrowl", 1);
    var0 waittill("ai_guardDogGrowl");
    var3 = randomfloatrange(var1, var2);
    wait var3;
  }
}

function level_guardcleanupanimationoriginlogic(var0) {
  var0 scripts\engine\utility::waittill_any("entitydeleted", "death", "start_context_melee");

  if(!isDefined(var0.guard.animationorigin)) {
    return;
  }

  var0.guard.animationorigin delete();
}

function level_getguards() {
  return scripts\sp\maps\safehouse\safehouse_utility::array_removedeaddyingorundefined(level.guard.ai);
}

function level_getallguards() {
  var0 = level_getguards();
  var1 = level_getalertedguards();
  return scripts\engine\sp\utility::array_merge(var0, var1);
}

function level_allguardsdead() {
  return level_getallguards().size == 0;
}

function level_guardaddai(var0) {
  level.guard.ai = scripts\engine\utility::array_add(level.guard.ai, var0);
}

function level_guardremoveai(var0) {
  level.guard.ai = scripts\engine\utility::array_remove(level.guard.ai, var0);
}

function level_guardaddalertedai(var0) {
  level.guard.alerted.ai = scripts\engine\utility::array_add(level.guard.alerted.ai, var0);
}

function level_guardisalerted(var0) {
  var1 = level_getalertedguards();
  return scripts\engine\utility::array_contains(var1, var0);
}

function level_addguardsalertedfunction(var0, var1) {
  if(scripts\engine\utility::flag("level_guardsStealthBroken")) {
    return;
  }

  if(isDefined(var1)) {
    var1 endon("entitydeleted");
    var1 endon("death");
  }

  scripts\engine\utility::flag_wait("level_guardsStealthBroken");
  GscBinSkip1(0x74, var0);
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

function level_guardassignweapon(var0) {
  var1 = [];
  var2 = [];
  var3 = ["iw8_ar_akilo47", "iw8_sm_uzulu", "iw8_sm_beta", "iw8_sm_mpapa7", "iw8_sh_romeo870"];
  GscBinSkip1(0x45, "iw8_ar_akilo47", 40);
}

function level_guardgetholesightblockerclips() {
  return getEntArray("level_guardHoleSightBlockerClip", "targetname");
}

function level_guardhideholesightblockerclips() {
  var0 = level_guardgetholesightblockerclips();

  foreach(var2 in var0) {
    var2 hide();
  }
}

function level_guardshowholesightblockerclips() {
  var0 = level_guardgetholesightblockerclips();

  foreach(var2 in var0) {
    var2 show();
  }
}

function level_guardsinstantlydetectplayerlogic() {
  level endon("level_guardInstantDetectedEndLogic");
  scripts\engine\utility::flag_set("level_guardInstantDetectPlayer");

  for(;;) {
    waitframe();
    var0 = level_getguards();

    foreach(var2 in var0) {
      if(!level_guardinstantdetectcanseeplayer(var2)) {
        continue;
      }

      level_guardsetallalerted(var2.origin);
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

function level_guardinstantdetectcanseeplayer(var0) {
  var1 = level_getguardsinstantdetectplayerhiddenvolumes();

  foreach(var3 in var1) {
    if(level.player istouching(var3)) {
      return false;
    }
  }

  var5 = var0 getEye();
  var6 = level.player getEye();
  var7 = sighttracepassed(var5, var6, 0, level.player);

  if(!var7) {
    return false;
  }

  var8 = scripts\engine\utility::within_fov(var5, var0.angles, var6, 0.5);

  if(!var8) {
    return false;
  }

  var9 = distance(level.player.origin, var0.origin);

  if(var9 > 650) {
    return false;
  }

  return true;
}

function ai_endguardproximitylogic(var0) {
  var0 notify("level_guardEndProximityLogic");
}

function ai_endguardlogic(var0) {
  var0 notify("level_guardEndLogic");
  level_guardremoveai(var0);
}

function ai_isguard(var0) {
  var1 = level_getguards();
  return scripts\engine\utility::array_contains(var1, var0);
}