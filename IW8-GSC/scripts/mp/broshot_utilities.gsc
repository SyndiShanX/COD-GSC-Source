/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\broshot_utilities.gsc
***********************************************/

function processepictaunt(var0, var1, var2) {
  if(var1 >= 0 && isDefined(level.camera_bro_shot.char_loc)) {
    var3 = level.camera_bro_shot.char_loc[var1].origin;
    var4 = level.camera_bro_shot.char_loc[var1].angles;

    if(isDefined(level.overridebroslot)) {
      var1 = level.overridebroslot - 1;
    }
  } else {
    var3 = level.charactercac.origin;
    var4 = level.charactercac.angles;
    var3 = 0;
  }

  if(tauntinprogress(var3)) {
    return;
  }

  processtauntsound(var2);
  deleteepictauntprops(var3);
  var5 = [];
  var6 = [];
  var7 = [];
  var8 = [];
  var9 = [];
  var10 = [];
  var11 = [];
  var12 = [];
  var13 = 0;
  var14 = 0;
  var15 = [];
  var16 = [];
  var17 = [];
  var18 = [];
  var19 = [];
  var20 = 0;
  var21 = 0;
  var22 = [];
  var23 = [];
  var24 = [];
  var25 = [];
  var26 = 0;
  var27 = [];
  var28 = 0;

  switch (var2) {
    case "IW7_mp_taunt_ftl_1st_kills_456":
      if(var4 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var7 = 10;
        var23 = 0.85;
        var23 = 2.05;
        var23 = 1.15;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_2nd_kills_456":
      if(var4 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var7 = 10;
        var23 = 1.1;
        var23 = 2.7;
        var23 = 1.467;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_3rd_kills_456":
      if(var4 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var7 = 10;
        var23 = 1.03;
        var23 = 2.76;
        var23 = 1.43;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_cod_champs":
      var7 = 7.834;
      break;
    case "iw7_mp_taunt_super_blackhole":
      var7 = 7;

      for(var29 = 0; var29 < 20; var29++) {
        var22 = 2.6 + var29 * 0.1;
      }

      break;
    case "iw7_mp_taunt_epic_grenade_toss_back01":
      var7 = 8;
      var22 = 5.7;
      var22 = 6.15;
      var22 = 6.6;
      break;
    case "iw7_mp_taunt_super_warfighter_at_screen":
      var7 = 6.6;
      var22 = 1;
      var22 = 1.2;
      var22 = 1.4;
      var22 = 1.6;
      var22 = 1.8;
      var22 = 2;
      var22 = 2.2;
      var22 = 2.4;
      break;
    case "iw7_mp_taunt_bio_spike":
      var7 = 6.6;
      var22 = 1.65;
      var22 = 2.05;
      break;
    case "iw7_mp_taunt_synaptic_reaper_3rd":
    case "iw7_mp_taunt_synaptic_reaper_2nd":
    case "iw7_mp_taunt_synaptic_reaper":
      var7 = 6.6;
      var21 = 2;
      break;
    case "iw7_mp_taunt_killstreak_scorcher":
      var5 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var6 = "iw7_mp_taunt_killstreak_scorcher_scorcher01";
      var7 = 6.6;
      var5 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var6 = "iw7_mp_taunt_killstreak_scorcher_scorcher02";
      var7 = 6.6;
      var5 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var6 = "iw7_mp_taunt_killstreak_scorcher_scorcher03";
      var7 = 6.6;
      var21 = 3;
      var28 = 1;
      break;
    case "iw7_mp_taunt_killstreak_c8":
      var5 = "mp_robot_c8";
      var6 = "iw7_mp_taunt_killstreak_c8_robot";
      var7 = 5.5;
      var8 = [];
      var8[0] = "weapon_c8_shield_top_mp";
      var8[1] = "weapon_c8_shield_bottom_mp";
      var9 = [];
      var9[0] = "j_wristshield";
      var9[1] = "j_wristbtmshield";
      var21 = 1.67;
      var22 = 5.15;
      break;
    case "IW7_mp_taunt_killstreak_apex01":
      var5 = "veh_mil_air_ca_oblivion_drone_mp";
      var6 = "IW7_mp_taunt_killstreak_apex01_apex";
      var7 = 5;
      var22 = 2;
      var22 = 2.4;
      var22 = 2.6;
      var22 = 3.2;
      var22 = 3.6;
      var22 = 3.8;
      break;
    case "iw7_mp_taunt_killstreak_thor":
      var5 = "veh_mil_air_thor_wm";
      var5 = "sdf_mp_cruise_missile_01";
      var5 = "un_mp_jackal_exterior_missile";
      var5 = "un_mp_jackal_exterior_missile";
      var5 = "un_mp_jackal_exterior_missile";
      var5 = "un_mp_jackal_exterior_missile";
      var5 = "un_mp_jackal_exterior_missile";
      var6 = "iw7_mp_taunt_killstreak_thor_prop";
      var6 = "iw7_mp_taunt_killstreak_thor_missile01";
      var6 = "iw7_mp_taunt_killstreak_thor_missile02";
      var6 = "iw7_mp_taunt_killstreak_thor_missile03";
      var6 = "iw7_mp_taunt_killstreak_thor_missile04";
      var6 = "iw7_mp_taunt_killstreak_thor_missile05";
      var6 = "iw7_mp_taunt_killstreak_thor_missile05";
      var7 = 7.47;
      var7 = 3.76;
      var7 = 4.7;
      var7 = 4.7;
      var7 = 4.7;
      var7 = 4.7;
      var7 = 4.7;
      var13 = 1;
      var14 = 1.5;
      var21 = 4.5;
      var28 = 1;
      break;
    case "IW7_mp_taunt_adrenaline":
      var5 = "equipment_mp_nanoshot_wm";
      var6 = "IW7_mp_taunt_adrenaline_nano";
      var7 = 10;
      var22 = 7.5;
      break;
    case "iw7_mp_taunt_super_shootdown":
      var5 = "veh_mil_air_un_uav";
      var6 = "iw7_mp_taunt_super_shootdown_uav";
      var7 = 6;
      var22 = 3.75;
      break;
    case "IW7_mp_taunt_phantom_cloak_3rd":
    case "IW7_mp_taunt_phantom_cloak_2nd":
    case "IW7_mp_taunt_phantom_cloak":
      var10 = "cloak";
      var11 = "on";
      var12 = 0.01;
      var10 = "cloak";
      var11 = "off";
      var12 = 1.5;
      var10 = "cloak";
      var11 = "on";
      var12 = 3.2;
      var10 = "cloak";
      var11 = "off";
      var12 = 4.7;
      var7 = 5.1;
      var13 = 1;
      var14 = 2;
      break;
    case "iw7_mp_taunt_super_merc_steeldragon":
      var15 = 0.466;
      var16 = 2.85;
      var17 = "tag_accessory_right";
      var18 = "tag_accessory_left";
      var19 = "vfx_taunt_steel_dragon";
      var7 = 4;
      var22 = 0.5;
      var22 = 0.7;
      var22 = 0.9;
      var22 = 1;
      var22 = 1.2;
      var22 = 1.4;
      var22 = 1.6;
      var22 = 1.8;
      var22 = 2;
      var22 = 2.2;
      var22 = 2.4;
      var22 = 2.7;
      var22 = 2.9;
      var22 = 3.1;
      break;
    case "iw7_mp_taunt_killstreak_laser_strike":
      var7 = 12;
      var24 = "vfx_bombard_antigrav_pre_expl";
      var24 = "vfx_bombard_projectile_trail";
      var26 = 0.2;
      var25 = (0, 80, 0);
      var25 = (75, 140, 0);
      var25 = (-165, 250, 0);
      var25 = (50, 200, 0);
      var25 = (155, 250, 0);
      var25 = (-75, 140, 0);
      var25 = (-50, 200, 0);
      var27 = 1;
      var27 = 1;
      var27 = 3.5;
      var22 = 3.5;
      var22 = 3.7;
      var22 = 3.9;
      var22 = 4.1;
      var22 = 4.3;
      var22 = 4.5;
      var22 = 4.7;
      var22 = 4.9;
      break;
    default:
      return;
  }

  level.broshotepictauntprops[var3] = [];
  level.broshotepictauntsubprops[var3] = [];

  if(var4 && var13) {
    if(!isDefined(level.queuedtaunts)) {
      level.queuedtaunts = [];
    }

    if(isDefined(level.queuedtaunts[var2])) {
      var30 = gettime() - level.queuedtaunts[var2];

      if(var30 < var14 * 1000) {
        wait var14 - var30 / 1000;
      }
    }

    level.queuedtaunts[var2] = gettime();
  }

  var31 = (0, 0, 0);

  if(var28 && isDefined(level.upsidedowntaunts) && level.upsidedowntaunts == 1) {
    var31 = (180, 180, 0);
  }

  for(var29 = 0; var29 < var5.size; var29++) {
    var32 = spawn("script_model", var3);
    var32 setModel(var5[var29]);
    var32.angles = var4 + var31;
    var32 notsolid();
    var32 dontinterpolate();
    var32 scriptmodelplayanimdeltamotion(var6[var29]);

    if(!isDefined(level.broshotepictauntprops)) {
      level.broshotepictauntprops = [];
    }

    level.broshotepictauntprops[var3][var29] = var32;

    if(!(isDefined(var8[var29]) && isarray(var8[var29]))) {
      continue;
    }

    level.broshotepictauntsubprops[var3] = [];

    for(var33 = 0; var33 < var8[var29].size; var33++) {
      var34 = spawn("script_model", var3);
      var34 setModel(var8[var29][var33]);
      var34.angles = var4 + var31;
      var34 notsolid();
      var34 dontinterpolate();
      var34 linkTo(var32, var9[var29][var33], (0, 0, 0), (0, 0, 0));
      level.broshotepictauntsubprops[var3][var33] = var34;
    }
  }

  var35 = 0;

  for(var29 = 0; var29 < var7.size; var29++) {
    var35 = max(var35, var7[var29]);
  }

  for(var29 = 0; var29 < var10.size; var29++) {
    thread doepictauntscriptablestep(var4, var3, var10[var29], var11[var29], var12[var29]);
  }

  if(var4 == 0) {
    var36 = getplayercharacter(-1);
  } else {
    var36 = getplayercharacter(var4);
  }

  if(var3 != 0) {
    for(var32 = 0; var32 < var16.size; var32++) {
      thread playbeamfx(var16[var32], var17[var32], var20[var32], var18[var32], var19[var32], var36);
    }
  }

  if(var3 != 0 && var21 > 0) {
    thread doshellshock(var21);
  }

  if(var3 != 0 && var22 > 0) {
    thread doearthquake(var22, 1);
  }

  for(var32 = 0; var32 < var23.size; var32++) {
    thread doearthquake(var23[var32], 0);
  }

  for(var32 = 0; var32 < var24.size; var32++) {
    thread dodisintegrate(var24[var32], var32);
  }

  for(var32 = 0; var32 < var26.size; var32++) {
    var37 = anglesToForward(level.camera_bro_shot.basecam.angles);
    var38 = vectorNormalize((var37[0], var37[1], 0));
    var39 = vectorcross(var38, (0, 0, 1));
    var40 = var38 * var26[var32][1];
    var41 = var39 * var26[var32][0];
    var42 = var40 + var41;

    if(var3 != 0) {
      var43 = level.camera_bro_shot.char_loc[0].origin;
    } else {
      var43 = var4;
    }

    for(var34 = 0; var34 < var25.size; var34++) {
      thread dospawnvfx(var25[var34], var28[var34] + var27 * var32, var42, var43);
    }
  }

  thread cleanupepictauntprops(var4, var36, var3);
}

function dospawnvfx(var0, var1, var2, var3) {
  self endon("cancel_taunt_cleanup");
  wait var1;
  var4 = var3 + var2;
  var5 = spawnfx(level._effect[var0], var4);

  if(isDefined(var5)) {
    triggerfx(var5);
    thread delayfxdelete(var5);
    return;
  }
}

function delayfxdelete(var0) {
  self endon("cancel_taunt_cleanup");
  wait var0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function dodisintegrate(var0, var1) {
  self endon("cancel_taunt_cleanup");
  wait var0;

  if(isDefined(level.topplayers[var1 + 3])) {
    level.topplayers[var1 + 3].bro hide(1);
    return;
  }
}

function playbeamfx(var0, var1, var2, var3, var4, var5) {
  self endon("cancel_taunt_cleanup");
  wait var0;
  var6 = playfxontagsbetweenclients(level._effect[var2], var5, var3, var5, var4);
  thread cleanupbeamfx(var6, var1);
}

function cleanupbeamfx(var0, var1) {
  waittill_notify_or_timeout("cancel_taunt_cleanup", var1);
  var0 delete();
}

function waittill_notify_or_timeout(var0, var1) {
  self endon(var0);
  wait var1;
}

function doearthquake(var0, var1) {
  self endon("cancel_taunt_cleanup");

  if(!isDefined(level.players)) {
    return;
  }

  wait var0;

  foreach(var3 in level.players) {
    if(isbot(var3)) {
      continue;
    }

    if(var1) {
      var3 earthquakeforplayer(0.5, 0.65, var3.origin, 1000);
      continue;
    }

    var3 earthquakeforplayer(0.15, 0.25, var3.origin, 1000);
  }
}

function doshellshock(var0) {
  self endon("cancel_taunt_cleanup");
  wait var0;

  foreach(var2 in level.players) {
    if(isbot(var2)) {}
  }
}

function getplayercharacter(var0) {
  if(var0 == -1) {
    var1 = level.charactercac;
  } else {
    var1 = level.topplayers[var1].bro;
  }

  return var1;
}

function doepictauntscriptablestep(var0, var1, var2, var3, var4) {
  if(var0 == 0) {
    var1 = -1;
  }

  self endon("cancel_taunt_cleanup");
  thread listenepictauntscriptablecancel(var1, var2);
  wait var4;
  var5 = getplayercharacter(var1);

  if(!isDefined(var5)) {
    return;
  }

  var5 setscriptablepartstate(var2, var3, 0);
}

function listenepictauntscriptablecancel(var0, var1) {
  self waittill("cancel_taunt_cleanup");
  var2 = getplayercharacter(var0);
  var2 setscriptablepartstate(var1, "offImmediate", 0);
}

function respawnclientcharacter() {
  var0 = level.charactercac.angles;
  var1 = level.charactercac.origin;
  level.charactercac delete();
  level.charactercac = spawn("script_character", var1, 0, 0, 1, "MPClientCharacter");
  level.charactercac.angles = var0;
  deleteepictauntprops(0);

  if(isDefined(level.last_taunt_sfx)) {
    self stoplocalsound(level.last_taunt_sfx);

    if(soundexists(level.last_taunt_sfx + "_lsrs")) {
      self stoplocalsound(level.last_taunt_sfx + "_lsrs");
    }

    if(soundexists(level.last_taunt_sfx + "_lfe")) {
      self stoplocalsound(level.last_taunt_sfx + "_lfe");
    }

    level.last_taunt_sfx = undefined;
    return;
  }
}

function tauntinprogress(var0) {
  return isDefined(level.broshotepictauntprops) && isarray(level.broshotepictauntprops) && isDefined(level.broshotepictauntprops[var0]) && level.broshotepictauntprops[var0].size > 0;
}

function cleanupepictauntprops(var0, var1, var2) {
  self endon("cancel_taunt_cleanup");
  wait var1;
  level.taunts_done = 1;
  deleteepictauntprops(var0);
}

function deleteepictauntprops(var0) {
  if(tauntinprogress(var0)) {
    for(var1 = 0; var1 < level.broshotepictauntprops[var0].size; var1++) {
      if(isDefined(level.broshotepictauntprops[var0][var1])) {
        level.broshotepictauntprops[var0][var1] scriptmodelclearanim();
        level.broshotepictauntprops[var0][var1] delete();
      }
    }

    level.broshotepictauntprops[var0] = [];

    if(isDefined(level.broshotepictauntsubprops[var0]) && isarray(level.broshotepictauntsubprops[var0])) {
      for(var1 = 0; var1 < level.broshotepictauntsubprops[var0].size; var1++) {
        if(isDefined(level.broshotepictauntsubprops[var0][var1])) {
          level.broshotepictauntsubprops[var0][var1] scriptmodelclearanim();
          level.broshotepictauntsubprops[var0][var1] delete();
        }
      }

      level.broshotepictauntsubprops[var0] = [];
    }
  }

  self notify("cancel_taunt_cleanup");
}

function processtauntsound(var0) {
  if(!soundexists(var0)) {
    return;
  }

  if(!isDefined(level.taunts_done)) {
    level.taunts_done = 0;
  }

  if(!isDefined(level.taunts_used)) {
    level.taunts_used = [];
  }

  if(soundexists(var0)) {
    if(isDefined(level.last_taunt_sfx)) {
      self stoplocalsound(level.last_taunt_sfx);

      if(soundexists(level.last_taunt_sfx + "_lsrs")) {
        self stoplocalsound(level.last_taunt_sfx + "_lsrs");
      }

      if(soundexists(level.last_taunt_sfx + "_lfe")) {
        self stoplocalsound(level.last_taunt_sfx + "_lfe");
      }

      level.last_taunt_sfx = undefined;
    }

    playepicbroshotsound(var0);
    level.taunts_used[level.taunts_used.size] = var0;
    level.last_taunt_sfx = var0;
    return;
  }

  if(soundexists(var0 + "_quiet")) {
    if(!array_contains(level.taunts_used, var0)) {
      playepicbroshotsound(var0 + "_quiet");
      level.taunts_used[level.taunts_used.size] = var0;
      level.last_taunt_sfx = var0 + "_quiet";
      return;
    }

    return;
  }
}

function playepicbroshotsound(var0) {
  if(isDefined(level.players)) {
    foreach(var2 in level.players) {
      if(!isbot(var2)) {
        var2 playlocalsound(var0);
      }
    }

    return;
  }

  self playlocalsound(var0);
}

function array_contains(var0, var1) {
  if(var0.size <= 0) {
    return false;
  }

  foreach(var3 in var0) {
    if(var3 == var1) {
      return true;
    }
  }

  return false;
}