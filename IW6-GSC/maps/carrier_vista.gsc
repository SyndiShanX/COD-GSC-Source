/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_vista.gsc
*****************************************************/

vista_pre_load() {
  level.vista_vehicles = [];
  level.ally_support_jets = [];
  level.ally_support_jets = common_scripts\utility::array_combine(level.ally_support_jets, getEntArray("ally_c17_support_jet_01", "targetname"));
  level.ally_support_jets = common_scripts\utility::array_combine(level.ally_support_jets, getEntArray("ally_c17_support_jet_02", "targetname"));
  level.ally_support_jets = common_scripts\utility::array_combine(level.ally_support_jets, getEntArray("ally_c17_support_jet_03", "targetname"));
  level.ally_support_jets = common_scripts\utility::array_combine(level.ally_support_jets, getEntArray("ally_c17_support_jet_04", "targetname"));
  common_scripts\utility::array_thread(level.ally_support_jets, maps\_utility::hide_entity);
}

run_vista() {
  if(level.start_point == "run_to_sparrow" || level.start_point == "defend_sparrow" || level.start_point == "deck_victory" || level.start_point == "deck_tilt" || level.start_point == "outro") {
    return;
  }
  common_scripts\utility::flag_set("vista_effects_on");
  maps\_utility::ent_flag_init("start_bomb_run");
  common_scripts\utility::flag_init("start_bomb_run");
  common_scripts\utility::flag_init("flyover_sound_complete");
  thread run_c17_jet_flyers();
  thread sparrow_launchers();
  thread jet_phalanx_tracking();
}

sparrow_launchers() {}

jet_phalanx_tracking() {
  var_0 = ["enemy_phalanx_target1", "enemy_phalanx_target2", "enemy_phalanx_target3", "enemy_phalanx_target4", "enemy_phalanx_target5", "enemy_phalanx_target6"];

  foreach(var_2 in var_0) {
    maps\_utility::array_spawn_function_targetname(var_2, ::jet_phalanx_spawn_function, "tracking_start", "tracking_end");
  }

  var_4 = ["crr_phalanx_01", "crr_phalanx_01", "crr_phalanx_03", "crr_phalanx_04"];

  while(!common_scripts\utility::flag("defend_sparrow_platform")) {
    var_0 = common_scripts\utility::array_randomize(var_0);

    foreach(var_6 in var_0) {
      var_7 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_6);

      if(isDefined(var_7) && isalive(var_7)) {
        var_8 = var_4[randomint(var_4.size)];
        var_7 thread maps\carrier_code::phalanx_gun_fire_target(var_8, var_7, "tracking_start", "tracking_end", (0, 0, 0));
        var_7 thread ambient_jet_by_sound();
        var_7 common_scripts\utility::waittill_any("reached_dynamic_path_end", "death");
      }

      wait(randomfloatrange(0.1, 0.5));
    }
  }
}

ambient_jet_by_sound() {
  self endon("death");
  self endon("reached_dynamic_path_end");

  for(;;) {
    var_0 = distance(level.player.origin, self.origin);

    if(var_0 < 14000) {
      thread maps\_utility::play_sound_on_entity("carr_ambient_jet_by");
      return;
    }

    common_scripts\utility::waitframe();
  }
}

jet_phalanx_spawn_function(var_0, var_1) {
  self.ent_flag[var_0] = 0;
  self.ent_flag[var_1] = 0;
}

run_c17_jet_flyers() {
  thread maps\carrier_code::fake_vehicles_loop_until_endon(180, "ally_c17_bg_start_01", "crr_boeing_c17_vista", "post_osprey", 0, 0, 1, 1);
  maps\_utility::delaythread(randomintrange(5, 10), ::spawn_flyers, 1);
  maps\_utility::delaythread(randomintrange(20, 25), ::spawn_flyers, 2);
  maps\_utility::delaythread(randomintrange(20, 25), ::spawn_flyers, 3);
  maps\_utility::delaythread(randomintrange(5, 10), ::spawn_flyers, 4);
}

spawn_flyers(var_0) {
  thread maps\carrier_code::fake_vehicles_loop_until_endon(200, "ally_c17_bg_loop_0" + var_0, "crr_boeing_c17_vista", "post_osprey", 1, 2, 1);
}

clear_vista_vehicles() {
  foreach(var_1 in level.vista_vehicles) {
    if(isDefined(var_1) && var_1 maps\_vehicle::isvehicle() && isalive(var_1)) {
      maps\_utility::deleteent(var_1);
      continue;
    }

    if(isDefined(var_1)) {
      maps\_utility::deleteent(var_1);
    }
  }
}