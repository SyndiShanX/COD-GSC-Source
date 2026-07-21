/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: vehicle\lbravo.gsc
***********************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  scripts\common\vehicle_build::build_template("lbravo", var_0, var_1, var_2);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_lbravo");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l.vfx", "tag_exhaust", "hind_helicopter_dying_loop", undefined, undefined, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_rocket_deathfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx", "tag_origin", "exp_helicopter_fuel", undefined, undefined, 0, 0, 0);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_treadfx(var_2, "default", "vfx/code/tread/heli_dust_default.vfx");
  scripts\common\vehicle_build::build_life(800);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims);
  scripts\common\vehicle_build::build_light(var_2, "red_white_blink_belly", "tag_origin", "vfx/iw8/core/lbravo/vfx_lbravo_blinking_lights.vfx", "running");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
  scripts\common\vehicle_build::build_drive(%lbravo_rotors, undefined, 0, 3.0);

  if(var_2 == "script_vehicle_iw8_lbravo_guns" || var_2 == "script_vehicle_iw8_lbravo_guns_east" || var_2 == "script_vehicle_iw8_lbravo_guns_east_no_dyn_bones") {
    scripts\common\vehicle_build::build_turret("iw8_vehicle_mg_50cal_heli", "tag_minigun_left", "veh8_mil_air_lbravo_minigun_left", "auto_nonai", 40, 0);
    scripts\common\vehicle_build::build_turret("iw8_vehicle_mg_50cal_heli", "tag_minigun_right", "veh8_mil_air_lbravo_minigun_right", "auto_nonai", 40, 0);
  }

  if(scripts\common\utility::issp()) {
    if(isDefined(level.littlebird_bulletdamage)) {
      level._effect["damaged_1"] = loadfx("vfx/iw8/core/lbravo/vfx_lbravo_body_damage_1.vfx");
      level._effect["damaged_2"] = loadfx("vfx/iw8/core/lbravo/vfx_lbravo_body_damage_2.vfx");
      level._effect["damaged_3"] = loadfx("vfx/iw8/core/lbravo/vfx_lbravo_body_damage_3.vfx");
    }
  }
}

init_local() {
  self.unload_land_offset = 112;
  self.unload_hover_offset = 120;
  self.script_badplace = 0;
  thread scripts\common\vehicle::vehicle_lights_on("running");
  thread handle_scriptable_vfx();
  self.vehicleanimalias = "lbravo";
  self.vehicledisableturningwhileshooting = 1;
  self.vehicledisableweaponreloading = 1;

  if(scripts\common\utility::issp() && isDefined(level.littlebird_bulletdamage))
    thread littlebird_damage_function();
}

handle_scriptable_vfx() {
  self endon("death");

  if(scripts\common\utility::issp() || scripts\common\utility::iscp()) {
    scripts\engine\utility::flag_wait("scriptables_ready");
    self setscriptablepartstate("engine", "on");
    self setscriptablepartstate("vector_field", "on");
  }
}

littlebird_damage_function() {
  self endon("death");
  self.stored_damage = 0;
  self.state = "healthy";
  waitframe();
  var_0 = self.maxhealth / 3;
  self.d1_health = var_0;
  self.d2_health = var_0 * 1.75;
  self.d3_health = var_0 * 2.5;
  self.d4_health = var_0 * 3;
  self.hover_states["healthy"] = (100, 80, 80);
  self.hover_states["damaged_1"] = (100, 160, 100);
  self.hover_states["damaged_2"] = (150, 400, 200);
  self.hover_states["damaged_3"] = (150, 400, 200);
  self sethoverparams(self.hover_states[self.state][0], self.hover_states[self.state][1], self.hover_states[self.state][2]);

  while(isalive(self)) {
    self waittill("damage", var_1, var_2, var_3, var_3, var_3, var_3, var_3, var_4);

    if(scripts\engine\utility::is_equal(var_2, level.player)) {
      if(var_1 > 1 && custom_hdromeo_check())
        var_1 = 2000;

      if(!scripts\engine\utility::is_equal(var_4, "tag_origin"))
        var_1 = var_1 / 2;

      if(var_1 < 40)
        var_1 = 40;

      self.stored_damage = self.stored_damage + var_1;
    }

    check_littlebird_damage_states();
    waitframe();
  }
}

custom_hdromeo_check() {
  if(scripts\engine\utility::is_equal(level.player.currentweapon.basename, "iw8_sn_hdromeo_ballistics") || scripts\engine\utility::is_equal(level.player.currentweapon.basename, "iw8_sn_hdromeo_ballistics_quickraise"))
    return 1;
  else
    return 0;
}

check_littlebird_damage_states() {
  switch (self.state) {
    case "healthy":
      if(self.stored_damage > self.d1_health) {
        self.state = "damaged_1";
        do_state_change();
      }

      break;
    case "damaged_1":
      if(self.stored_damage > self.d2_health) {
        self.state = "damaged_2";
        do_state_change();
      }

      break;
    case "damaged_2":
      if(self.stored_damage > self.d3_health) {
        self.state = "damaged_3";
        do_state_change();
      }

      break;
    case "damaged_3":
      if(self.stored_damage > self.d4_health) {
        self.state = "dead";
        self.script_bulletshield = undefined;
        self dodamage(self.health - self.healthbuffer + 1, self.origin);
      }

      break;
  }
}

do_state_change() {
  playFXOnTag(scripts\engine\utility::getfx(self.state), self, "tag_origin");
  self sethoverparams(self.hover_states[self.state][0], self.hover_states[self.state][1], self.hover_states[self.state][2]);
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 8; var_1++)
    var_0[var_1] = spawnStruct();

  var_0[0].canshootinvehicle = 0;
  var_0[1].canshootinvehicle = 0;
  var_0[2].canshootinvehicle = 1;
  var_0[3].canshootinvehicle = 1;
  var_0[4].canshootinvehicle = 1;
  var_0[5].canshootinvehicle = 1;
  var_0[6].canshootinvehicle = 1;
  var_0[7].canshootinvehicle = 1;
  var_0[0].idle = % reb_vh_lbravo_pilot_idle_search01;
  var_0[0].idle_anim = "reb_vh_lbravo_pilot_idle_search01";
  var_0[1].idle = % reb_vh_lbravo_copilot_idle_search01;
  var_0[1].idle_anim = "reb_vh_lbravo_copilot_idle_search01";
  var_0[2].idle = % reb_vh_lbravo_guy1_idle_search01;
  var_0[3].idle = % reb_vh_lbravo_guy2_idle_search01;
  var_0[4].idle = % reb_vh_lbravo_guy3_idle_search01;
  var_0[5].idle = % reb_vh_lbravo_guy4_idle_search01;
  var_0[6].idle = % reb_vh_lbravo_guy5_idle_search01;
  var_0[7].idle = % reb_vh_lbravo_guy6_idle_search01;
  var_0[0].sittag = "tag_pilot1";
  var_0[1].sittag = "tag_pilot2";
  var_0[2].sittag = "tag_passenger1";
  var_0[3].sittag = "tag_passenger2";
  var_0[4].sittag = "tag_passenger3";
  var_0[5].sittag = "tag_passenger4";
  var_0[6].sittag = "tag_passenger5";
  var_0[7].sittag = "tag_passenger6";
  var_0[2].getout = % reb_vh_lbravo_guy1_exit_combat_idle;
  var_0[3].getout = % reb_vh_lbravo_guy2_exit_combat_idle;
  var_0[4].getout = % reb_vh_lbravo_guy3_exit_combat_idle;
  var_0[5].getout = % reb_vh_lbravo_guy4_exit_combat_idle;
  var_0[6].getout = % reb_vh_lbravo_guy5_exit_combat_idle;
  var_0[7].getout = % reb_vh_lbravo_guy6_exit_combat_idle;
  var_0[0].death_no_ragdoll = 1;
  var_0[1].death_no_ragdoll = 1;
  var_0[2].vehicle_death_ragdoll = 1;
  var_0[3].vehicle_death_ragdoll = 1;
  var_0[4].vehicle_death_ragdoll = 1;
  var_0[5].vehicle_death_ragdoll = 1;
  var_0[6].vehicle_death_ragdoll = 1;
  var_0[7].vehicle_death_ragdoll = 1;
  return var_0;
}

set_vehicle_anims(var_0) {}

unload_groups() {
  var_0 = [];
  var_0["both"] = [];
  var_0["left"] = [];
  var_0["right"] = [];
  var_0["all"] = [0, 1, 2, 3, 4, 5, 6, 7];
  var_0["both"] = [2, 3, 4, 5, 6, 7];
  var_0["left"] = [2, 3, 4];
  var_0["right"] = [5, 6, 7];
  var_0["default"] = var_0["both"];
  return var_0;
}