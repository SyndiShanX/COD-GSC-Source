/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_swim_player.gsc
*****************************************************/

init_player_swim() {
  precacheshellshock("underwater_swim");
  precachemodel("shpg_viewmodel_scuba_mask");
  precacheitem("aps_underwater");
  level._effect["swim_flashlight_plr"] = loadfx("vfx/moments/ship_graveyard/vfx_flashlight_underwater");
  level._effect["swim_flashlight_particles"] = loadfx("vfx/moments/ship_graveyard/ocean_particulate_player_light");
}

init_player_swim_anims() {}

give_underwater_weapon() {
  self takeallweapons();
  self giveweapon("aps_underwater+swim");
  self givemaxammo("aps_underwater+swim");
  self switchtoweapon("aps_underwater+swim");
  thread flashlight();
  self disableweaponpickup();
}

shellshock_forever() {}

enable_player_swim() {
  setsaveddvar("cg_footsteps", 0);
  setsaveddvar("cg_equipmentSounds", 0);
  setsaveddvar("cg_landingSounds", 0);
  give_underwater_weapon();
  thread shellshock_forever();
  self enableslowaim(0.5, 0.5);
  level.water_current = (0, 0, 0);
  level.drift_vec = (0, 0, 0);
  thread moving_water();
  self.player_mover = common_scripts\utility::spawn_tag_origin();
  maps\_underwater::player_scuba_mask();
  thread maps\_underwater::player_scuba();
  maps\_underwater::underwater_hud_enable(1);
  thread dynamic_dof(250);
  self allowswim(1);
}

disable_player_swim() {
  self allowswim(0);
}

moving_water() {
  var_0 = getEntArray("moving_water_flags", "script_noteworthy");

  foreach(var_2 in var_0) {
    thread moving_water_flag(var_2);
  }
}

moving_water_flag(var_0) {
  var_1 = 4;
  var_2 = getent(var_0.target, "targetname");
  var_3 = anglesToForward(var_2.angles) * var_1;

  for(;;) {
    common_scripts\utility::flag_wait(var_0.script_flag);
    level.water_current = var_3;
    common_scripts\utility::flag_waitopen(var_0.script_flag);
    level.water_current = (0, 0, 0);
  }
}

player_swim_anims() {}

flashlight() {
  wait 0.1;

  if(!isDefined(self.playerfxorg)) {
    self.fxtag = common_scripts\utility::spawn_tag_origin();
    self.fxtag.origin = self getEye();
    self.fxtag.origin = self.fxtag.origin - (0, 0, 32);
    self.fxtag linktoplayerview(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  } else
    self.fxtag = self.playerfxorg;

  thread flashlight_toggle();
}

flashlight_toggle() {
  self.fxtag endon("death");

  if(!maps\_utility::ent_flag_exist("flashlight_on")) {
    maps\_utility::ent_flag_init("flashlight_on");
  }

  thread particle_loop();
  self endon("death");

  for(;;) {
    common_scripts\utility::waittill_either("toggle_flashlight", "toggle_flashlight_on");

    if(level.start_point != "fallon") {
      self playSound("shipg_plyr_flashlight_on");
    }

    playFXOnTag(common_scripts\utility::getfx("swim_flashlight_plr"), self.fxtag, "tag_origin");
    maps\_utility::ent_flag_set("flashlight_on");
    wait 0.5;
    common_scripts\utility::waittill_either("toggle_flashlight", "toggle_flashlight_off");
    self playSound("shipg_plyr_flashlight_off");
    stopFXOnTag(common_scripts\utility::getfx("swim_flashlight_plr"), self.fxtag, "tag_origin");
    maps\_utility::ent_flag_clear("flashlight_on");
    wait 1;
  }
}

particle_loop() {
  self.fxtag endon("death");

  while(isalive(level.player)) {
    if(maps\_utility::ent_flag("flashlight_on")) {
      playFXOnTag(common_scripts\utility::getfx("swim_flashlight_particles"), self.fxtag, "tag_origin");
      wait 0.3;
      continue;
    }

    if(isalive(level.player)) {
      maps\_utility::ent_flag_wait("flashlight_on");
    }
  }
}

dynamic_dof(var_0) {
  if(!maps\_utility::is_gen4()) {
    return;
  }
  self endon("stop_dynamic_dof");

  for(;;) {
    wait 0.05;

    if(common_scripts\utility::flag("pause_dynamic_dof")) {
      wait 0.05;
      continue;
    }

    var_1 = self playerads();

    if(var_1 > 0.0) {
      continue;
    }
    var_2 = getdvarfloat("ads_dof_tracedist", 4096);
    var_3 = getdvarfloat("ads_dof_nearStartScale", 0.25);
    var_4 = getdvarfloat("ads_dof_nearEndScale", 0.85);
    var_5 = getdvarfloat("ads_dof_farStartScale", 1.15);
    var_6 = getdvarfloat("ads_dof_farEndScale", 3);
    var_7 = getdvarfloat("ads_dof_nearBlur", 4);
    var_8 = getdvarfloat("ads_dof_farBlur", 2.5);
    var_9 = self getEye();
    var_10 = self getplayerangles();

    if(isDefined(self.dof_ref_ent)) {
      var_11 = combineangles(self.dof_ref_ent.angles, var_10);
    } else {
      var_11 = var_10;
    }

    var_12 = vectornormalize(anglesToForward(var_11));
    var_13 = bulletTrace(var_9, var_9 + var_12 * var_2, 1, self, 1);
    var_14 = getaiarray("axis");

    if(var_13["fraction"] == 1) {
      var_2 = 2048;
      var_15 = 256;
      var_16 = var_2 * var_5 * 2;
    } else {
      var_2 = distance(var_9, var_13["position"]);

      if(var_2 > var_0) {
        maps\_art::dof_disable_script(0.5);
        continue;
      }

      var_15 = var_2 * var_3;
      var_16 = var_2 * var_5;
    }

    foreach(var_18 in var_14) {
      var_19 = vectornormalize(var_18.origin - var_9);
      var_20 = vectordot(var_12, var_19);

      if(var_20 < 0.923) {
        continue;
      }
      var_21 = distance(var_9, var_18.origin);

      if(var_21 - 30 < var_15) {
        var_15 = var_21 - 30;
      }

      if(var_21 + 30 > var_16) {
        var_16 = var_21 + 30;
      }
    }

    if(var_15 > var_16) {
      var_15 = var_16 - 256;
    }

    if(var_15 > var_2) {
      var_15 = var_2 - 30;
    }

    if(var_15 < 1) {
      var_15 = 1;
    }

    if(var_16 < var_2) {
      var_16 = var_2;
    }

    var_23 = var_15 * var_3;
    var_24 = var_16 * var_6;
    maps\_art::dof_enable_script(var_23, var_15, var_7, var_16, var_24, var_8, 0.5);
  }

  wait 0.05;
}