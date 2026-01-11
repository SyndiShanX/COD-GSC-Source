/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\iplane_code.gsc
*****************************************************/

zerog() {
  var_0 = 12;
  var_1 = 16;
  var_2 = 6;
  level endon("kill_free_fall");
  level waittill("start_freefall");
  level.zerog_origin = common_scripts\utility::getstruct("all_plane_origin", "targetname");
  var_3 = randomfloatrange(0.25, 0.75);
  wait(var_3);
  wait 0.25;
  setsaveddvar("phys_gravityChangeWakeupRadius", 3200);
  setsaveddvar("ragdoll_max_life", 3600000);
}

in_air_sequence() {}

player_on_back() {
  var_0 = getent("player_on_back_pre_one", "targetname");
  var_1 = getent("player_on_back_one", "targetname");
  var_2 = getent("r_plane_player_climb_one", "targetname");
  var_3 = getEntArray("player_on_back", "targetname");
  var_4 = common_scripts\utility::getclosest(level.player.origin, var_3);
  var_5 = spawn("script_model", var_4.origin);
  var_5 setModel("tag_origin");
  var_5 linkto(level.plane_core);
  level.chair_vargas_2.reference maps\_utility::anim_stopanimscripted();
  level.vargas allowedstances("crouch");
  common_scripts\utility::flag_set("ground_rotate_ref");
  var_6 = getent("c17_left_wing", "targetname");
  playFX(common_scripts\utility::getfx("aerial_explosion_large"), var_6.origin + (0, -200, -40));
  level.player shellshock("hijack_minor", 4.0);
  level.plane_core maps\iplane::batman_rotate_plane();
}

anim_first_roll_everyone() {
  level.mccoy_anim_org maps\_utility::anim_stopanimscripted();
  level.kersey_anim_org maps\_utility::anim_stopanimscripted();
  level.elias hide();
  level.hesh hide();
  level.merrick hide();
  level.elias = spawn("script_origin", level.elias.origin);
  level.elias.origin = level.elias.origin + (0, 0, 90);
  level.mccoy_anim_org.origin = level.mccoy_anim_org.origin + (120, 0, 150);
  level.kersey_anim_org.origin = level.kersey_anim_org.origin + (20, 0, 70);
}

give_player_p99_back() {
  wait 0.6;
  level.player giveweapon("p99");
  level.player setweaponammoclip("p99", 5);
  level.player setweaponammostock("p99", 5);
  level.player enableweapons();
  level.player switchtoweapon("p99");
}

move_primary_light(var_0) {
  thread move_with_plane(var_0);
  var_0 setlightintensity(1.5);
}

move_with_plane(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(level.plane_core);
  var_0 endon("kill_light");

  for(;;) {
    var_0 moveto(var_1.origin, 0.05);
    wait 0.05;
  }
}

kill_angles_when_anim_done(var_0) {
  wait(var_0);
  level.player playersetgroundreferenceent(undefined);
}

pause_smoke_fx() {
  var_0 = [];
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("interior_ceiling_smoke"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("interior_ceiling_smoke2"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::getfxarraybyid("interior_ceiling_smoke3"));
  level waittill("volumetrics_setup");

  for(;;) {
    common_scripts\utility::flag_wait("pause_plane_fx");

    foreach(var_2 in var_0) {
      var_2 common_scripts\utility::pauseeffect();
    }

    common_scripts\utility::flag_waitopen("pause_plane_fx");

    foreach(var_2 in var_0) {
      var_2 maps\_utility::restarteffect();
    }
  }
}

fake_rotate_of_ai() {}

physics_of_objects_in_plane() {
  level endon("iplane_done");
  level.orig_phys_gravity = getdvar("phys_gravity");
  var_0 = getEntArray("zerog_physics", "targetname");

  foreach(var_2 in var_0) {
    physicsexplosionsphere(var_2.origin, 64, 32, 0.01);
  }

  setphysicsgravitydir((0, 0, -0.02));
  wait 0.3;
  setphysicsgravitydir((0.02, 0.05, -1));
  wait 2;
  setphysicsgravitydir((0.05, -0.05, 1));
  var_4 = 0;
  setsaveddvar("phys_gravity", 0);

  for(;;) {
    setsaveddvar("phys_gravity", -5);
    var_5 = randomfloatrange(1.3, 3.3);
    var_4++;

    if(var_4 == 1) {
      setphysicsgravitydir((-0.02, 0.03, 0.01));
    }

    if(var_4 == 2) {
      setphysicsgravitydir((0, 0, -1));
    }

    if(var_4 == 3) {
      setphysicsgravitydir((0, -0.01, 0.01));
    }

    if(var_4 == 4) {
      setsaveddvar("phys_gravity", level.orig_phys_gravity);
    }

    if(var_4 == 5) {
      var_4 = 0;
      setphysicsgravitydir((0.03, 0, 0.05));
    }

    foreach(var_2 in var_0) {
      physicsexplosionsphere(var_2.origin, 150, 75, 0.01);
    }

    wait(var_5);
  }
}

crawl_hurt_pulse() {
  thread crawl_breath_start();
  level waittill("clear_hurt_pulses");
}

pitch_and_roll() {
  self endon("stop_bob");
  self endon("death");
  var_0 = self;
  var_1 = (0, 0, 0);
  var_2 = 20;

  if(isDefined(var_0.script_max_left_angle)) {
    var_2 = var_0.script_max_left_angle;
  }

  var_3 = var_2 * 0.5;
  var_4 = 4;

  if(isDefined(var_0.script_duration)) {
    var_4 = var_0.script_duration;
  }

  var_5 = var_4 * 0.5;
  var_0 = undefined;

  for(;;) {
    var_6 = (0, randomfloatrange(var_3, var_2), randomfloatrange(var_3, var_2));
    var_7 = randomfloatrange(var_5, var_4);
    self rotateto(var_1 + var_6, var_7, var_7 * 0.2, var_7 * 0.2);
    self waittill("rotatedone");
    self rotateto(var_1 - var_6, var_7, var_7 * 0.2, var_7 * 0.2);
    self waittill("rotatedone");
  }
}

crawl_breath_start() {
  level endon("crawl_breath_recover");
  level.player maps\_utility::play_sound_on_entity("breathing_hurt_start");

  for(;;) {
    wait(randomfloatrange(1.7, 3));
    level.player maps\_utility::play_sound_on_entity("breathing_hurt");
  }
}

light_follow_plane(var_0) {
  self endon("kill_light");
  var_1 = self.origin - var_0.origin;

  for(;;) {
    self moveto(var_0.origin + var_1, 0.05);
    wait 0.05;
  }
}