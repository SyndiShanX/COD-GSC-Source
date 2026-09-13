/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\lbravo.gsc
***********************************************/

#using_animtree("vehicles");

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("lbravo", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_deathmodel("veh8_mil_air_lbravo");
  scripts\common\vehicle_build::build_deathfx("vfx/core/expl/fire_smoke_trail_l.vfx", "tag_exhaust", "lbravo_helicopter_dying_loop", undefined, undefined, 1, 0.5, 1, undefined);
  scripts\common\vehicle_build::build_rocket_deathfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx", "tag_origin", "exp_helicopter_fuel", undefined, undefined, 0, 0, 0);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_treadfx(classname, "default", "vfx/code/tread/heli_dust_sml.vfx");
  scripts\common\vehicle_build::build_life(800);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims);
  scripts\common\vehicle_build::build_light(classname, "red_white_blink_belly", "tag_origin", "vfx/iw8/core/lbravo/vfx_lbravo_blinking_lights.vfx", "running");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::build_bulletshield(1);
  scripts\common\vehicle_build::build_is_helicopter();
  scripts\common\vehicle_build::build_drive(%lbravo_rotors, undefined, 0, 3.0);

  if(classname == "script_vehicle_iw8_lbravo_guns" || classname == "script_vehicle_iw8_lbravo_guns_east" || classname == "script_vehicle_iw8_lbravo_guns_east_no_dyn_bones") {
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
  self._id_1B59B3D32F056466 = 1;

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
  _id_5947DFAD4810C891 = self.maxhealth / 3;
  self.d1_health = _id_5947DFAD4810C891;
  self.d2_health = _id_5947DFAD4810C891 * 1.75;
  self.d3_health = _id_5947DFAD4810C891 * 2.5;
  self.d4_health = _id_5947DFAD4810C891 * 3;
  self.hover_states["healthy"] = (100, 80, 80);
  self.hover_states["damaged_1"] = (100, 160, 100);
  self.hover_states["damaged_2"] = (150, 400, 200);
  self.hover_states["damaged_3"] = (150, 400, 200);
  self sethoverparams(self.hover_states[self.state][0], self.hover_states[self.state][1], self.hover_states[self.state][2]);

  while(isalive(self)) {
    self waittill("damage", damage, attacker, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, _id_DDD80F5D1DA23C60, partname);

    if(scripts\engine\utility::is_equal(attacker, level.player)) {
      if(damage > 1 && custom_hdromeo_check())
        damage = 2000;

      if(!scripts\engine\utility::is_equal(partname, "tag_origin"))
        damage = damage / 2;

      if(damage < 40)
        damage = 40;

      self.stored_damage = self.stored_damage + damage;
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
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 8; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[2].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[3].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[4].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[5].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[6].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[7].canshootinvehicle = 1;
  _id_E4B7E99A96C8829F[0].idle = % reb_vh_lbravo_pilot_idle_search01;
  _id_E4B7E99A96C8829F[0].idle_anim = "reb_vh_lbravo_pilot_idle_search01";
  _id_E4B7E99A96C8829F[1].idle = % reb_vh_lbravo_copilot_idle_search01;
  _id_E4B7E99A96C8829F[1].idle_anim = "reb_vh_lbravo_copilot_idle_search01";
  _id_E4B7E99A96C8829F[2].idle = % reb_vh_lbravo_guy1_idle_search01;
  _id_E4B7E99A96C8829F[3].idle = % reb_vh_lbravo_guy2_idle_search01;
  _id_E4B7E99A96C8829F[4].idle = % reb_vh_lbravo_guy3_idle_search01;
  _id_E4B7E99A96C8829F[5].idle = % reb_vh_lbravo_guy4_idle_search01;
  _id_E4B7E99A96C8829F[6].idle = % reb_vh_lbravo_guy5_idle_search01;
  _id_E4B7E99A96C8829F[7].idle = % reb_vh_lbravo_guy6_idle_search01;
  _id_E4B7E99A96C8829F[0].sittag = "tag_pilot1";
  _id_E4B7E99A96C8829F[1].sittag = "tag_pilot2";
  _id_E4B7E99A96C8829F[2].sittag = "tag_passenger1";
  _id_E4B7E99A96C8829F[3].sittag = "tag_passenger2";
  _id_E4B7E99A96C8829F[4].sittag = "tag_passenger3";
  _id_E4B7E99A96C8829F[5].sittag = "tag_passenger4";
  _id_E4B7E99A96C8829F[6].sittag = "tag_passenger5";
  _id_E4B7E99A96C8829F[7].sittag = "tag_passenger6";
  _id_E4B7E99A96C8829F[2].getout = % reb_vh_lbravo_guy1_exit_combat_idle;
  _id_E4B7E99A96C8829F[3].getout = % reb_vh_lbravo_guy2_exit_combat_idle;
  _id_E4B7E99A96C8829F[4].getout = % reb_vh_lbravo_guy3_exit_combat_idle;
  _id_E4B7E99A96C8829F[5].getout = % reb_vh_lbravo_guy4_exit_combat_idle;
  _id_E4B7E99A96C8829F[6].getout = % reb_vh_lbravo_guy5_exit_combat_idle;
  _id_E4B7E99A96C8829F[7].getout = % reb_vh_lbravo_guy6_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[2].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[3].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[4].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[5].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[6].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[7].vehicle_death_ragdoll = 1;
  _id_E4B7E99A96C8829F[0].death_impulse = 1;
  _id_E4B7E99A96C8829F[1].death_impulse = 1;
  _id_E4B7E99A96C8829F[2].death_impulse = 1;
  _id_E4B7E99A96C8829F[3].death_impulse = 1;
  _id_E4B7E99A96C8829F[4].death_impulse = 1;
  _id_E4B7E99A96C8829F[5].death_impulse = 1;
  _id_E4B7E99A96C8829F[6].death_impulse = 1;
  _id_E4B7E99A96C8829F[7].death_impulse = 1;
  return _id_E4B7E99A96C8829F;
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {}

unload_groups() {
  unload_groups = [];
  unload_groups["both"] = [];
  unload_groups["left"] = [];
  unload_groups["right"] = [];
  unload_groups["all"] = [0, 1, 2, 3, 4, 5, 6, 7];
  unload_groups["both"] = [2, 3, 4, 5, 6, 7];
  unload_groups["left"] = [2, 3, 4];
  unload_groups["right"] = [5, 6, 7];
  unload_groups["default"] = unload_groups["both"];
  return unload_groups;
}