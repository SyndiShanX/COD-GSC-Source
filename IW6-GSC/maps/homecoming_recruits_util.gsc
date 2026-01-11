/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_recruits_util.gsc
*********************************************/

setup_player_for_animated_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    if(!isDefined(var_1)) {
      var_1 = 60;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = level.player.origin;
  }

  if(!isDefined(var_3)) {
    var_3 = level.player.angles;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  var_7 = maps\_utility::spawn_anim_model("player_rig", var_2);
  level.player_rig = var_7;
  var_7.angles = var_3;
  var_7.animname = "player_rig";

  if(isDefined(var_6)) {
    var_8 = maps\_utility::spawn_anim_model(var_6);
  } else {
    var_8 = common_scripts\utility::spawn_tag_origin();
  }

  level.player_mover = var_8;
  var_8.origin = var_2;
  var_8.angles = var_3;
  var_7 linkto(var_8);

  if(var_0) {
    level.player playerlinktodelta(var_7, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
  }

  if(var_4) {
    thread player_animated_sequence_restrictions(var_5);
  }
}

player_animated_sequence_restrictions(var_0) {
  if(isDefined(var_0) && var_0) {
    level.player waittill("notify_player_animated_sequence_restrictions");
  }

  level.player.disablereload = 1;
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player disableweaponswitch();
  level.player allowcrouch(0);
  level.player allowjump(0);
  level.player allowmelee(0);
  level.player allowprone(0);
  level.player allowsprint(0);
}

player_animated_sequence_cleanup(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0 && (!isDefined(level.player.early_weapon_enabled) || !level.player.early_weapon_enabled)) {
    level.player.early_weapon_enabled = undefined;
    level.player.disablereload = 0;
    level.player enableweapons();
    level.player enableoffhandweapons();
    level.player enableweaponswitch();
  }

  level.player allowcrouch(1);
  level.player allowjump(1);
  level.player allowmelee(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player unlink();

  if(isDefined(level.player_mover)) {
    level.player_mover delete();
  }

  if(isDefined(level.player_rig)) {
    level.player_rig delete();
  }
}

hc_hide_hud() {
  level.hc_hud = 1;
  level.hc_hud_ammocounterhide = getdvarint("ammoCounterHide");
  level.hc_hud_actionslotshide = getdvarint("actionSlotsHide");
  level.hc_hud_showstance = getdvarint("hud_showStance");
  level.hc_hud_compass = getdvarint("compass");
  level.hc_hud_g_friendlynamedist = getdvarint("g_friendlyNameDist");
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  setsaveddvar("compass", 0);
  setsaveddvar("g_friendlyNameDist", 0);
}

hc_show_previous_hud() {
  if(!isDefined(level.hc_hud)) {
    return;
  }
  setsaveddvar("ammoCounterHide", level.hc_hud_ammocounterhide);
  setsaveddvar("actionSlotsHide", level.hc_hud_actionslotshide);
  setsaveddvar("hud_showStance", level.hc_hud_showstance);
  setsaveddvar("compass", level.hc_hud_compass);
  setsaveddvar("g_friendlyNameDist", level.hc_hud_g_friendlynamedist);
  level.hc_hud = undefined;
  level.hc_hud_ammocounterhide = undefined;
  level.hc_hud_actionslotshide = undefined;
  level.hc_hud_showstance = undefined;
  level.hc_hud_compass = undefined;
  level.hc_hud_g_friendlynamedist = undefined;
}

player_sway() {
  self endon("death");
  level.player_sway_weight = 0.55;
  level.player_wind_weight = 0.11;
  level.player_ground_ref_mover = maps\_utility::spawn_anim_model("player_rig");
  level.player_ground_ref_mover.origin = level.player.origin;
  level.player_ground_ref_mover hide();
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_0.origin = level.player_ground_ref_mover gettagorigin("tag_player");
  var_0.angles = level.player_ground_ref_mover gettagangles("tag_player");
  var_0 linkto(level.player_ground_ref_mover, "tag_player");
  level.player playersetgroundreferenceent(var_0);
  wait 0.5;
  thread player_sway_loop(level.player_ground_ref_mover);
  thread player_sway_loop(self);
}

player_sway_loop(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 setanim(level.scr_anim["player_rig"]["player_sway_static"], level.player_sway_weight);
    var_0 setanim(level.scr_anim["player_rig"]["player_wind_static"], level.player_wind_weight);
    var_1 = level.player_sway_weight + level.player_wind_weight;

    if(var_1 > 1) {
      var_1 = 1;
    }

    var_0 setanim(level.scr_anim["player_rig"]["player_nosway_static"], 1 - var_1);
    wait(level.timestep);
  }
}

player_sway_blendto(var_0, var_1) {
  level endon("notify_change_player_sway");

  if(!isDefined(var_0) || var_0 == 0) {
    var_0 = level.timestep;
  }

  var_2 = level.player_sway_weight;
  var_3 = var_1 - level.player_sway_weight;

  for(var_4 = var_3 * (level.timestep / var_0); var_0 > 0; var_0 = var_0 - level.timestep) {
    var_2 = var_2 + var_4;

    if(var_2 > 1) {
      var_2 = 1;
    }

    if(var_2 < 0) {
      var_2 = 0;
    }

    level.player_sway_weight = var_2;
    wait(level.timestep);
  }

  level.player_sway_weight = var_1;
  level notify("notify_sway_blend_complete");
}

player_wind_blendto(var_0, var_1) {
  level endon("notify_change_player_wind");

  if(!isDefined(var_0) || var_0 == 0) {
    var_0 = level.timestep;
  }

  var_2 = level.player_wind_weight;
  var_3 = var_1 - level.player_wind_weight;

  for(var_4 = var_3 * (level.timestep / var_0); var_0 > 0; var_0 = var_0 - level.timestep) {
    var_2 = var_2 + var_4;

    if(var_2 > 1) {
      var_2 = 1;
    }

    if(var_2 < 0) {
      var_2 = 0;
    }

    level.player_wind_weight = var_2;
    wait(level.timestep);
  }

  level.player_wind_weight = var_1;
  level notify("notify_wind_blend_complete");
}

heli_shake(var_0) {
  earthquake(0.25, 4, level.player.origin, 1600);
  level.player playrumbleonentity("damage_heavy");
  level.player screenshakeonentity(randomfloatrange(0.125, 0.175), randomfloatrange(0.125, 0.175), randomfloatrange(0.125, 0.175), 60, 0, 2, 500, 8, 12, 12, 1.8);
  var_1 = maps\_utility::get_rumble_ent();
  var_1.intensity = 0;
  player_rumble_bump(var_1, 0.7, 0.15, 0.1, 0.0, 1.3, "notify_rumble_bump");
  player_rumble_bump(var_1, 0.15, 0, 0.1, 0.0, 1.5, "notify_rumble_bump");
}

player_rumble_bump(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    level notify(var_6);
    level endon(var_6);
  }

  var_0 thread maps\_utility::rumble_ramp_to(var_1, var_3);
  wait(var_3 + var_4);
  var_0 thread maps\_utility::rumble_ramp_to(var_2, var_5);
  wait(var_5);
}