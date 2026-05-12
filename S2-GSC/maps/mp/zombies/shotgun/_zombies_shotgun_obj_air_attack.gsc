/***********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_obj_air_attack.gsc
***********************************************************************/

sg_init_obj_air_attack() {
  common_scripts\utility::func_3C87("flag_flak_cannons_powered_on");
  common_scripts\utility::func_3C87("flag_flak_cannons_ready");
  common_scripts\utility::func_3C87("flag_players_have_won");
  common_scripts\utility::func_92C("plane_death", "vfx/vehicle/p47_death");
  common_scripts\utility::func_92C("zmb_isl_aa_gun_gk_energy", "vfx/map/mp_zombie_island/zmb_isl_aa_gun_gk_energy");
  common_scripts\utility::func_92C("zmb_stuka_turret_dirt_impact", "vfx/zombie/zmb_stuka_turret_dirt_impact");
  common_scripts\utility::func_92C("zmb_clouds_puff_static", "vfx/map/mp_zombie_island/zmb_clouds_puff_static");
  common_scripts\utility::func_92C("zmb_isl_enemy_plane_tracer", "vfx/map/mp_zombie_island/zmb_isl_enemy_plane_tracer");
  aa_gun_trap_init();
  aa_gun_power_init();
  aud_air_attack_init();
  plane_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("air_attack", ::run_air_attack, 120, 0, 1);
}

run_air_attack(param_00) {
  air_attack_set_rules();
  level notify("air_attack_start");
  level thread air_attack_score_counter();
  level thread air_attack_wave_handler();
  level thread air_attack_cloud_handler();
  var_01 = level common_scripts\utility::func_A70E(level, "flag_players_have_won", level, "sg_obj_timeout");
  var_02 = var_01[0];
  var_03 = var_01[1];
  if(var_02 == "flag_players_have_won") {
    return 1;
  }

  common_scripts\utility::func_3C8F("flag_players_have_won");
  return 0;
}

air_attack_skip_cleanup() {
  level endon("flag_players_have_won");
  level endon("sg_obj_timeout");
  level waittill("skipWave");
  common_scripts\utility::func_3C8F("flag_players_have_won");
}

air_attack_set_rules() {
  level.aagun_ee_difficulty = level.var_744A.size;
  if(level.aagun_ee_difficulty == 1) {
    level.points_to_win = 10;
  }

  if(level.aagun_ee_difficulty == 2) {
    level.points_to_win = 12;
  }

  if(level.aagun_ee_difficulty >= 3) {
    level.points_to_win = 13;
  }
}

air_attack_adjust_rules() {
  var_00 = level.aagun_ee_difficulty;
  var_01 = level.var_744A.size;
  if(var_01 >= var_00) {
    if(var_01 == 2) {
      level.points_to_win = 12;
    }

    if(var_01 >= 3) {
      level.points_to_win = 13;
    }
  }
}

air_attack_score_counter() {
  while(level.current_score <= level.points_to_win) {
    level waittill("air_attack_plane_killed");
    level.current_score++;
  }

  level notify("air_attack_all_planes_destroyed");
  common_scripts\utility::func_3C8F("flag_players_have_won");
}

air_attack_cloud_handler() {
  var_00 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_a", "targetname");
  var_01 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_b", "targetname");
  var_02 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_c", "targetname");
  var_03 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_d", "targetname");
  var_04 = common_scripts\utility::func_46B7("struct_cloud_fx_spawner_f", "targetname");
  foreach(var_06 in var_00) {
    playFX(common_scripts\utility::func_44F5("zmb_clouds_puff_static"), var_06.var_116, (1, 1, 0));
  }

  foreach(var_06 in var_01) {
    playFX(common_scripts\utility::func_44F5("zmb_clouds_puff_static"), var_06.var_116, (1, -1, 0));
  }

  foreach(var_06 in var_02) {
    playFX(common_scripts\utility::func_44F5("zmb_clouds_puff_static"), var_06.var_116, (-1, -1, 0));
  }

  foreach(var_06 in var_03) {
    playFX(common_scripts\utility::func_44F5("zmb_clouds_puff_static"), var_06.var_116, (-1, 1, 0));
  }

  foreach(var_06 in var_04) {
    playFX(common_scripts\utility::func_44F5("zmb_clouds_puff_static"), var_06.var_116, (0, -1, 0));
  }
}

air_attack_wave_handler() {
  var_00 = [1, 2, 3, 4];
  while(!common_scripts\utility::func_3C77("flag_players_have_won")) {
    var_01 = common_scripts\utility::func_7A33(var_00);
    var_00 = common_scripts\utility::func_F93(var_00, var_01);
    if(var_00.size <= 0) {
      var_00 = [1, 2, 3, 4];
    }

    switch (var_01) {
      case 1:
        air_attack_adjust_rules();
        level.wave_a = function_01DC("plane_start_node_a", "targetname");
        var_02 = level.wave_a air_attack_spawn_plane_wave();
        break;

      case 2:
        air_attack_adjust_rules();
        level.wave_b = function_01DC("plane_start_node_b", "targetname");
        var_02 = level.wave_b air_attack_spawn_plane_wave();
        break;

      case 3:
        air_attack_adjust_rules();
        level.wave_c = function_01DC("plane_start_node_c", "targetname");
        var_02 = level.wave_c air_attack_spawn_plane_wave();
        break;

      case 4:
        air_attack_adjust_rules();
        level.wave_d = function_01DC("plane_start_node_d", "targetname");
        var_02 = level.wave_d air_attack_spawn_plane_wave();
        break;

      default:
        break;
    }

    wait(30);
  }
}

air_attack_spawn_plane_wave() {
  var_00 = [];
  var_01 = 0;
  foreach(var_03 in self) {
    var_04 = var_03 plane_spawn_plane();
    var_00 = common_scripts\utility::func_F6F(var_00, var_04);
  }

  var_06 = var_00[0].var_1A5;
  thread air_attack_bonus_point_counter(var_00, var_06);
  return var_00;
}

air_attack_bonus_point_counter(param_00, param_01) {
  var_02 = 0;
  thread air_attack_plane_cleaner(param_00);
  while(param_00.size >= 0) {
    level waittill(param_01);
    var_02++;
    if(var_02 >= 6) {
      level.current_score = level.current_score + 1;
      break;
    }

    wait(1);
  }
}

air_attack_plane_cleaner(param_00) {
  while(param_00.size >= 0) {
    param_00 = common_scripts\utility::func_FA0(param_00);
    wait(0.5);
  }
}

aa_gun_trap_init() {
  var_00 = common_scripts\utility::func_46B7("aa_gun_trap", "targetname");
  foreach(var_02 in var_00) {
    var_02 aa_gun_trap_prep();
    var_02 thread aa_gun_use_think();
  }

  foreach(var_05 in aa_gun_get_all_turrets()) {
    var_05 thread aa_gun_manage_swaps();
  }
}

aa_gun_get_all_turrets() {
  return getEntArray("tur_flak_gun", "script_noteworthy");
}

aa_gun_trap_prep() {
  var_00 = common_scripts\utility::func_44BE(self.var_1A2, "targetname");
  self.var_1176 = [];
  foreach(var_02 in var_00) {
    switch (var_02.var_165) {
      case "trig_use":
        self.var_9D65 = var_02;
        self.var_9D65.hint_string_available = &"ZOMBIE_ISLAND_BUY_FLAK";
        self.var_9D65.hint_string_unavailable = &"ZOMBIE_ISLAND_FLAK_DISABLED";
        self.var_9D65.hint_string_no_power = &"ZOMBIES_REQUIRES_POWER";
        var_02 sethintstring(self.var_9D65.hint_string_unavailable);
        var_02 common_scripts\utility::func_9D9F();
        break;

      case "tur_flak_gun":
        self.var_9EDD = var_02;
        break;

      case "flak_cannon_attack_points":
        self.var_1176 = common_scripts\utility::func_F6F(self.var_1176, var_02);
        break;

      case "sbm_wall":
        self.wall_model = var_02;
        self.wall_model.var_BC = 500;
        self.wall_model common_scripts\utility::func_3799("this_turret_is_done");
        break;
    }
  }

  self.wall_model thread aa_gun_close_gate();
}

aa_gun_use_think() {
  self.var_9D65.var_267B = 750;
  level waittill("air_attack_start");
  self.var_9D65 common_scripts\utility::func_9DA3();
  self.var_9D65 sethintstring(self.var_9D65.hint_string_no_power);
  common_scripts\utility::func_3C9F("flag_flak_cannons_powered_on");
  self.wall_model thread aa_gun_open_gate();
  self.var_9D65 sethintstring(self.var_9D65.hint_string_available);
  thread aa_gun_wait_for_use();
  var_00 = undefined;
  for(;;) {
    level waittill("aa_gun_request", var_01, var_02);
    if(isDefined(var_02) && var_02 != self) {
      continue;
    }

    if(!isPlayer(var_01)) {
      if(common_scripts\utility::func_562E(var_01)) {
        aa_gun_set_locked();
      }

      self.var_9D65 sethintstring(self.var_9D65.hint_string_available);
      continue;
    } else {
      var_00 = var_01;
    }

    if(!var_00 maps\mp\gametypes\zombies::func_11C2(self.var_9D65.var_267B)) {
      var_00 thread lib_054E::func_695("needmoney");
      continue;
    } else {
      self.var_9D65 common_scripts\utility::func_9D9F();
      self.wall_model thread aa_gun_close_gate();
      self.wall_model aa_gun_set_player_using(var_00, self.var_9EDD);
      var_03 = ["zombie_generic", "zombie_berserker"];
      self.wall_model thread maps\mp\mp_zombies_attack_object::create_inanimate_zombie_enemy(3, 400, "this_turret_is_done", 1024, 512, ::aa_gun_terminate_nuke, [::aa_gun_player_left_listen, ::aa_gun_player_death_listen, ::aa_gun_player_disconnect_listen], self.var_1176, var_03, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"], var_00);
      self.wall_model common_scripts\utility::func_379C("this_turret_is_done");
      self.wall_model aa_gun_unset_player_using(var_00, self.var_9EDD);
      self.wall_model common_scripts\utility::func_3796("this_turret_is_done");
      playFX(level.var_611["zmb_isl_aa_gun_gk_energy"], self.wall_model.var_116, anglesToForward(self.wall_model.var_1D));
      var_00 lib_0378::func_8D74("aud_stunning_burst_use");
      self.wall_model thread aa_gun_open_gate();
      wait(1);
      self.var_9D65 common_scripts\utility::func_9DA3();
      self.var_9D65 sethintstring(self.var_9D65.hint_string_unavailable);
      wait(12.5);
      aa_gun_set_locked();
      self.var_9D65 sethintstring(self.var_9D65.hint_string_available);
    }
  }
}

aa_gun_power_init() {
  level.aagun_switches_on = 0;
  var_00 = common_scripts\utility::func_46B7("aagun_switch", "targetname");
  foreach(var_02 in var_00) {
    var_02 aa_gun_power_switch_init();
    var_02 thread aa_gun_power_switch_think();
  }
}

aa_gun_power_switch_init() {
  var_00 = common_scripts\utility::func_44BE(self.var_1A2, "targetname");
  var_01 = function_021F("power_switch_aagun", "targetname");
  self.computer_panels = common_scripts\utility::func_4461(self.var_116, var_01);
  self.computer_panels setscriptablepartstate("cbreaker", "standby_idle");
  self.computer_panels setscriptablepartstate("light_red", "on");
  self.computer_panels setscriptablepartstate("light_green", "off");
  self.computer_panels setscriptablepartstate("light_power", "off");
  self.computer_panels setscriptablepartstate("light_graph", "off");
  foreach(var_03 in var_00) {
    switch (var_03.var_165) {
      case "use_trigger":
        self.var_9D65 = var_03;
        self.var_9D65 sethintstring(&"ZOMBIES_POWER_ON");
        self.var_9D65 common_scripts\utility::func_9D9F();
        break;
    }
  }
}

aa_gun_power_switch_think() {
  level waittill("air_attack_start");
  self.var_9D65 common_scripts\utility::func_9DA3();
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    level.aagun_switches_on++;
    self.var_9D65 common_scripts\utility::func_9D9F();
    self.var_9D65 sethintstring(&"ZOMBIES_EMPTY_STRING");
    self.computer_panels setscriptablepartstate("cbreaker", "ready");
    self.computer_panels setscriptablepartstate("light_red", "off");
    self.computer_panels setscriptablepartstate("light_green", "on");
    self.computer_panels setscriptablepartstate("light_power", "on");
    self.computer_panels setscriptablepartstate("light_graph", "on");
    common_scripts\utility::func_3C8F("flag_flak_cannons_powered_on");
  }
}

aa_gun_set_locked() {
  while(common_scripts\utility::func_562E(level.aa_guns_locked)) {
    self.var_9D65 sethintstring(self.var_9D65.hint_string_unavailable);
    wait(0.125);
  }
}

aa_gun_wait_for_use() {
  for(;;) {
    self.var_9D65 waittill("trigger", var_00);
    level notify("aa_gun_request", var_00, self);
  }
}

aa_gun_lock_turrets(param_00) {
  level.aa_guns_locked = param_00;
  level notify("aa_gun_request", param_00);
}

aa_gun_close_gate() {
  self scriptmodelplayanim("s2_zom_flak_gun_gate_close");
  lib_0378::func_8D74("flak_gun_gate_up");
  wait(getanimlength(%s2_zom_flak_gun_gate_open));
  self scriptmodelplayanim("s2_zom_flak_gun_gate_close_idle");
}

aa_gun_open_gate() {
  self scriptmodelplayanim("s2_zom_flak_gun_gate_open");
  lib_0378::func_8D74("flak_gun_gate_down");
  wait(getanimlength(%s2_zom_flak_gun_gate_open));
  self scriptmodelplayanim("s2_zom_flak_gun_gate_open_idle");
}

aa_gun_terminate_nuke() {
  var_00 = lib_0547::func_408F();
  var_01 = 0;
  foreach(var_03 in common_scripts\utility::func_40B0(self.var_116, var_00, undefined, undefined, 200)) {
    if(lib_0547::func_5565(var_03.var_A4B, "zombie_generic") || lib_0547::func_5565(var_03.var_A4B, "zombie_berserker")) {
      var_03 lib_056D::func_5A86();
    }
  }
}

aa_gun_set_player_using(param_00, param_01) {
  self.turret_player = param_00;
  self.var_9EDD = param_01;
  param_00.var_CE = 1;
  param_00.on_aa_gun = 1;
  param_01 useby(param_00);
  param_00.var_480F = 1;
  param_00 setclientomnvar("ui_zm_turret_health", 1);
  param_00 method_80EB();
  wait(1.5);
  param_00 method_80EC();
}

aa_gun_unset_player_using(param_00, param_01) {
  param_00.var_CE = 0;
  param_00.on_aa_gun = 0;
  param_00 method_85E9();
  param_00.var_480F = 0;
  param_00 setclientomnvar("ui_zm_turret_health", 0);
  param_00 notify("left_aa_gun");
}

aa_gun_timeout_listen(param_00) {
  self endon(param_00);
  wait(15);
}

aa_gun_player_left_listen(param_00) {
  self endon(param_00);
  self.var_9EDD waittill("turret_deactivate");
}

aa_gun_player_death_listen(param_00) {
  self endon(param_00);
  while(isDefined(self.turret_player) && isalive(self.turret_player) && !common_scripts\utility::func_562E(self.turret_player.var_5728)) {
    wait 0.05;
  }
}

aa_gun_player_disconnect_listen(param_00) {
  self endon(param_00);
  self.turret_player waittill("disconnect");
}

aa_gun_capture_turret_fire(param_00) {
  self endon("death");
  level endon("game_ended");
  self endon("turretownerchange");
  for(;;) {
    self waittill("turret_fire", var_01);
    if(!isDefined(var_01[0])) {
      continue;
    }

    thread plane_flak_projectile_zombie_proximity_detonate(var_01[0], param_00);
    level notify("flak_projectile_fired", var_01[0], param_00);
  }
}

aa_gun_manage_swaps() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("turretownerchange");
    var_00 = self method_80E2();
    if(isDefined(var_00) && isPlayer(var_00)) {
      thread aa_gun_capture_turret_fire(var_00);
    }
  }
}

plane_init() {
  level.current_score = 0;
  level.points_to_win = 9999;
  level.aagun_ee_difficulty = 0;
  level.current_score = 0;
  level.active_planes = [];
}

plane_spawn_plane() {
  var_00 = "ger_bomber_stuka_hub";
  var_01 = "ger_bomber_stuka_vista";
  var_02 = spawnhelicopter(self.var_116, self.var_1D, var_00, var_01);
  var_02.var_1A5 = self.var_1A5;
  level.active_planes[level.active_planes.size] = var_02;
  var_02 method_80B1();
  var_02 notify("forward");
  var_02.var_1C7 = "forward";
  var_02.var_1C1 = "forward";
  var_02.var_17DC = 0;
  var_02.var_931A = "forward";
  var_02 lib_0378::func_8D74("aud_plane_spawn");
  var_02 thread plane_gun_think();
  var_02 startpath(self);
  var_02 thread plane_vehicle_paths_non_heli(self);
  var_02 thread maps\mp\gametypes\_damage::func_8676(100);
  var_02.var_BC = 60;
  var_02.var_29B5 = ::plane_on_damage;
  var_02 thread plane_handle_flak_projectile_proximity();
  var_02 thread plane_cleanup();
  return var_02;
}

plane_cleanup() {
  wait(4);
  for(;;) {
    if(isDefined(self) && self.var_1C4 <= 0) {
      level.active_planes = common_scripts\utility::func_F93(level.active_planes, self);
      self notify("death");
      self delete();
      break;
    }

    wait(3);
  }
}

plane_damage_player() {
  self endon("death");
  var_00 = getent("vol_plane_damage_area", "targetname");
  while(common_scripts\utility::func_3794("turret_on")) {
    var_01 = self.var_116;
    var_02 = anglesToForward(self gettagangles("TAG_MUZZLE_FX_1"));
    var_03 = 10000;
    var_04 = 180;
    var_05 = bulletTrace(self gettagorigin("TAG_MUZZLE_FX_1"), var_01 + var_02 * var_03, 0, undefined, 1, 1, 0, 0, 0, 0, 0);
    if(isDefined(var_05["position"])) {
      var_06 = var_05["position"];
      var_07 = lib_0547::func_408F();
      var_07 = function_01AC(var_07, var_06, var_04, 1);
      foreach(var_09 in var_07) {
        if(bullettracepassed(var_06 + (0, 0, 25), var_09 getEye(), 0)) {
          var_09 dodamage(80, self.var_116);
        }
      }

      var_0B = function_01AC(level.var_744A, var_06, var_04, 1);
      foreach(var_0D in var_0B) {
        if(bullettracepassed(var_06 + (0, 0, 25), var_0D.var_116, 0) || bullettracepassed(var_06 + (0, 0, 25), var_0D gettagorigin("j_spine4"), 0) || bullettracepassed(var_06 + (0, 0, 25), var_0D getEye(), 0)) {
          var_0D dodamage(23, self.var_116);
          var_0D notify("aagun_damage");
        }
      }
    }

    wait(0.22);
  }
}

plane_gun_think() {
  self endon("death");
  common_scripts\utility::func_3799("turret_on");
  common_scripts\utility::func_3799("turret_off");
  common_scripts\utility::func_379C("turret_on");
  var_00 = self gettagorigin("TAG_MUZZLE_FX_1");
  var_01 = self gettagorigin("TAG_MUZZLE_FX_2");
  common_scripts\utility::func_379C("turret_on");
  lib_0378::func_8D74("aud_plane_firing");
  thread plane_damage_player();
  while(common_scripts\utility::func_3794("turret_on")) {
    playFXOnTag(common_scripts\utility::func_44F5("zmb_isl_enemy_plane_tracer"), self, "TAG_MUZZLE_FX_1");
    playFXOnTag(common_scripts\utility::func_44F5("zmb_isl_enemy_plane_tracer"), self, "TAG_MUZZLE_FX_2");
    wait(0.2);
  }
}

plane_on_damage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  self endon("air_attack_plane_killed");
  if(common_scripts\utility::func_562E(self.findingacrashpath)) {
    return;
  }

  if(isDefined(param_01.maxhealth) && !isPlayer(param_01)) {
    param_01 = param_01 method_80E2();
  }

  if(isDefined(self.var_6E74)) {
    var_0C = self.var_6E74;
  } else {
    var_0C = self;
  }

  if(param_05 != "turretweapon_ger_btry_flak38_mp_zombie" && param_05 != "bazooka_mp" && param_05 != "panzerschreck_mp" && param_05 != "fliegerfaust_zm" && param_05 != "fliegerfaust_pap_zm") {
    param_02 = 1;
  }

  var_0C.var_BC = var_0C.var_BC - param_02;
  if(var_0C.var_BC <= 0) {
    if(isDefined(param_01)) {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("killshot");
      if(isDefined(level.zmb_events_player_destroyed_stuka)) {
        param_01 thread[[level.zmb_events_player_destroyed_stuka]]();
      }
    }

    if(isDefined(param_05) && isPlayer(param_01)) {
      param_01 notify("plane_crashy", param_05);
    }

    var_0C plane_crashy();
    return;
  }

  if(isDefined(param_01)) {
    param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard");
  }
}

plane_on_death(param_00, param_01, param_02, param_03) {
  self endon("death");
  self.var_1180 = param_00;
}

plane_crashy() {
  if(common_scripts\utility::func_562E(self.findingacrashpath)) {
    return;
  }

  if(!isDefined(self.var_272B) || self.var_272B == 0) {
    self.var_272B = 1;
    self notify("crashing");
    lib_0378::func_8D74("aud_plane_tailspin");
    if(common_scripts\utility::func_562E(self.mustfindacrashpath)) {
      self.findingacrashpath = 1;
      plane_wait_for_valid_crash_path();
    }

    var_00 = self.var_2944;
    if(isDefined(var_00) && isDefined(var_00.var_81EF)) {
      self.crashingspecial = 1;
      var_00 = self.var_2944;
      plane_goto_linkto_path(var_00);
      wait 0.05;
      self waittill("reached_dynamic_path_end");
      common_scripts\utility::func_379A("plane_crashed");
      return;
    } else {
      var_01 = randomfloatrange(-90, 90);
      var_02 = (0, cos(var_01), sin(var_01));
      var_03 = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000));
      var_04 = 1.2;
      self method_8224(level.var_721C.var_116 + var_03, self method_8283() * var_04, var_02);
    }

    common_scripts\utility::func_A74B("veh_collision", randomfloatrange(0.5, 3));
  }

  if(!isDefined(self.crashingspecial) || self.crashingspecial == 0) {
    plane_go_boom();
  }
}

plane_wait_for_valid_crash_path() {
  self endon("plane_got_away");
  for(;;) {
    if(isDefined(self.var_2944) && isDefined(self.var_2944.var_81EF)) {
      var_00 = function_01DC(self.var_2944.var_81EF, "script_linkname");
      if(var_00.size > 0) {
        break;
      }
    }

    wait 0.05;
  }

  return 1;
}

plane_go_boom(param_00) {
  if(!isDefined(self)) {
    return;
  }

  var_01 = anglesToForward(self.var_1D);
  if(!common_scripts\utility::func_562E(param_00)) {
    playFX(level.var_611["plane_death"], self.var_116, var_01);
    lib_0378::func_8D74("aud_plane_explode", self.var_116);
  }

  level notify(self.var_1A5);
  level notify("air_attack_plane_killed");
  self notify("delete");
  waittillframeend;
  self delete();
  self notify("air_attack_plane_killed");
}

plane_handle_flak_projectile_proximity() {
  level endon("game_ended");
  self endon("death");
  self endon("crashing");
  for(;;) {
    level waittill("flak_projectile_fired", var_00, var_01);
    if(!isDefined(var_00)) {
      continue;
    }

    thread plane_flak_projectile_proximity_detonate(var_00, var_01);
  }
}

plane_flak_projectile_zombie_proximity_detonate(param_00, param_01) {
  param_01 endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  var_02 = 64;
  var_03 = common_scripts\utility::func_4461(param_00.var_116, lib_0547::func_408F());
  for(;;) {
    if(isDefined(var_03) && distance2d(var_03 getEye(), param_00.var_116) < var_02 && abs(param_00.var_116[2] - var_03.var_116[2]) < 120) {
      param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard");
      param_00 detonateusingweapon("turretweapon_ger_btry_flak38_mp_zombie", param_01, param_00);
      break;
    }

    wait 0.05;
  }
}

plane_flak_projectile_proximity_detonate(param_00, param_01) {
  self endon("death");
  self endon("crashing");
  param_01 endon("disconnect");
  level endon("game_ended");
  param_00 endon("death");
  var_02 = 250000;
  for(;;) {
    var_03 = self.var_116;
    var_04 = distancesquared(param_00.var_116, var_03);
    if(var_04 < var_02) {
      param_00 notify("plane_death");
      self dodamage(500, var_03, param_01, param_00, "MOD_PROJECTILE", param_00.var_A9E0);
      param_00 method_81D6();
    }

    wait 0.05;
  }
}

plane_get_from_vehicle_node(param_00) {
  return getvehiclenode(param_00, "targetname");
}

plane_get_from_vehicle_node_reverse(param_00) {
  var_01 = getvehiclenode(param_00, "targetname");
  var_02 = var_01 method_8650();
  return var_02 method_8650();
}

plane_get_path_getfunc(param_00) {
  var_01 = ::plane_get_from_vehicle_node;
  return var_01;
}

plane_get_path_getfunc_reverse(param_00) {
  var_01 = ::plane_get_from_vehicle_node_reverse;
  return var_01;
}

plane_death_roll_on() {
  if(self.var_BC > 0) {
    self.var_7ED6 = 1;
  }
}

plane_death_roll_off() {
  self.var_7ED6 = undefined;
  self notify("deathrolloff");
}

plane_goto_linkto_path(param_00) {
  waittillframeend;
  if(isDefined(param_00) && isDefined(param_00.var_81EF)) {
    var_01 = function_01DC(param_00.var_81EF, "script_linkname");
    if(isDefined(var_01) && isDefined(var_01[0])) {
      thread plane_vehicle_paths_non_heli(var_01[0]);
      self startpath(var_01[0]);
    }
  }
}

plane_node_wait(param_00, param_01, param_02) {
  if(self.var_1146 == param_00 && !isDefined(param_01)) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  if(isDefined(self.var_A01E)) {
    var_03 = "node_wait_triggered" + self.var_A01E;
  } else {
    var_03 = "node_wait_triggered";
  }

  if(!isDefined(param_00.var_9DBB) || param_00.var_9DBB != gettime()) {
    var_04 = spawnStruct();
    plane_wait_til_node_wait_triggered(var_04, var_03, param_00, param_02);
    var_04 waittill(var_03);
  }

  param_00.var_9DBB = undefined;
}

plane_wait_til_node_wait_triggered(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  var_05 = param_02;
  while(isDefined(param_02) && var_04 < 3) {
    var_04++;
    thread plane_node_wait_triggered(param_00, param_01, param_02);
    if(!isDefined(param_02.var_1A2)) {
      return;
    }

    param_02 = [[param_03]](param_02.var_1A2);
  }
}

plane_node_wait_triggered(param_00, param_01, param_02) {
  self endon("newpath");
  self endon("death");
  param_00 endon(param_01);
  param_02 waittill("trigger");
  param_02.var_9DBB = gettime();
  waittillframeend;
  param_00 notify(param_01);
}

plane_vehicle_paths_non_heli(param_00) {
  self notify("newpath");
  if(isDefined(param_00)) {
    self.var_1146 = param_00;
  }

  var_01 = self.var_1146;
  self.var_2944 = self.var_1146;
  if(!isDefined(var_01)) {
    return;
  }

  self endon("newpath");
  self endon("death");
  var_02 = var_01;
  var_03 = undefined;
  var_04 = var_01;
  var_05 = plane_get_path_getfunc(var_01);
  var_06 = plane_get_path_getfunc_reverse(var_01);
  if(self.var_1C1 == "reverse") {
    var_07 = var_06;
  } else {
    var_07 = var_06;
  }

  while(isDefined(var_04)) {
    plane_node_wait(var_04, var_03, var_07);
    if(!isDefined(self)) {
      return;
    }

    self.var_2944 = var_04;
    if(isDefined(var_04.var_165)) {
      self notify(var_04.var_165);
      self notify("noteworthy", var_04.var_165);
    }

    waittillframeend;
    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_04.var_8272)) {
      var_04.var_8186 = var_04.var_8272;
      var_04.var_8272 = undefined;
    }

    if(isDefined(var_04.var_8186)) {
      var_08 = var_04.var_8187;
      if(isDefined(var_08)) {
        level maps\mp\_utility::func_2CED(var_08, ::common_scripts\_exploder::func_392A, var_04.var_8186);
      } else {
        level common_scripts\_exploder::func_392A(var_04.var_8186);
      }
    }

    if(isDefined(var_04.var_81A0)) {
      common_scripts\utility::func_3C8F(var_04.var_81A0);
    }

    if(isDefined(var_04.var_8183)) {
      common_scripts\utility::func_379A(var_04.var_8183);
    }

    if(isDefined(var_04.var_8182)) {
      common_scripts\utility::func_3796(var_04.var_8182);
    }

    if(isDefined(var_04.var_819B)) {
      common_scripts\utility::func_3C7B(var_04.var_819B);
    }

    if(isDefined(var_04.var_165)) {
      if(var_04.var_165 == "godon") {
        self.var_480F = 1;
      }

      if(var_04.var_165 == "godoff") {
        self.var_480F = 0;
      }

      if(var_04.var_165 == "engineoff") {
        self method_828D();
      }
    }

    if(isDefined(var_04.var_8145)) {
      self.var_8145 = var_04.var_8145;
    }

    if(isDefined(var_04.var_8121)) {
      self.var_8121 = var_04.var_8121;
    }

    if(isDefined(var_04.var_82B2)) {
      self.var_82B2 = var_04.var_82B2;
    }

    if(isDefined(var_04.var_82C1)) {
      self notify("turning", var_04.var_82C1);
    }

    if(isDefined(var_04.var_8150)) {
      if(var_04.var_8150 == 0) {
        thread plane_death_roll_off();
      } else {
        thread plane_death_roll_on();
      }
    }

    if(isDefined(var_04.var_82D4)) {
      if(isDefined(var_04.var_8260) && var_04.var_8260 == "queue") {
        self.var_7889 = 1;
      }
    }

    if(isDefined(var_04.var_812B)) {
      self.var_1C0 = var_04.var_812B;
    }

    if(isDefined(var_04.var_8265)) {
      self.var_1C3 = var_04.var_8265;
    }

    if(isDefined(var_04.var_8262)) {
      self.var_1C1 = var_04.var_8262;
    }

    if(isDefined(var_04.var_8184)) {
      var_09 = 35;
      if(isDefined(var_04.var_8151)) {
        var_09 = var_04.var_8151;
      }

      self method_8280(0, var_09);
      common_scripts\utility::func_379C(var_04.var_8184);
      if(!isDefined(self)) {
        return;
      }

      var_0A = 60;
      if(isDefined(var_04.var_80F6)) {
        var_0A = var_04.var_80F6;
      }

      self method_8293(var_0A);
    }

    var_03 = var_04;
    if(!isDefined(var_04.var_1A2)) {
      break;
    }

    if(self.var_1C1 == "reverse") {
      var_07 = var_06;
    } else {
      var_07 = var_05;
    }

    var_04 = [[var_07]](var_04.var_1A2);
    if(!isDefined(var_04)) {
      var_04 = var_03;
      break;
    } else if(!isDefined(var_04.var_1A2) || isDefined(var_04.var_82CA)) {
      var_0B = max(0.01, length(self method_8289()));
      var_0C = distance(self.var_116, var_04.var_116);
      var_0D = max(0.01, var_0C / var_0B);
      self notify("about_to_stop", var_0D);
    }
  }

  self notify("reached_dynamic_path_end");
  if(isDefined(self.var_82D3)) {
    self notify("delete");
    waittillframeend;
    self delete();
    return;
  }

  thread plane_goto_linkto_path(var_04);
}

plane_track_damage(param_00, param_01) {
  plane_waittill_damage_from("turretweapon_ger_btry_flak38_mp_zombie");
}

plane_waittill_damage_from(param_00) {
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isDefined(var_0A) || !issubstr(var_0A, param_00)) {
      continue;
    }

    break;
  }
}

aud_air_attack_init() {
  lib_0378::func_8DC7("flak_gun_gate_up", ::aud_aa_gun_gate_up);
  lib_0378::func_8DC7("flak_gun_gate_down", ::aud_aa_gun_gate_down);
  lib_0378::func_8DC7("aud_plane_mission_start", ::aud_plane_mission_start);
  lib_0378::func_8DC7("aud_plane_spawn", ::aud_plane_spawn);
  lib_0378::func_8DC7("aud_plane_firing", ::aud_plane_firing);
  lib_0378::func_8DC7("aud_plane_damage_player", ::aud_plane_damage_player);
  lib_0378::func_8DC7("aud_plane_tailspin", ::aud_plane_tailspin);
  lib_0378::func_8DC7("aud_plane_explode", ::aud_plane_explode);
}

aud_aa_gun_gate_up() {
  var_00 = self;
  lib_0380::func_288B("zmb_flak_gun_gate_up", undefined, var_00);
}

aud_aa_gun_gate_down() {
  var_00 = self;
  lib_0380::func_288B("zmb_flak_gun_gate_down", undefined, var_00);
}

aud_plane_mission_start() {
  level endon("stop_plane_int_submix");
  for(;;) {
    foreach(var_01 in level.var_744A) {
      if(var_01.current_volume_is_interior) {
        var_01 method_8626("isl_plane_interior_mix");
        continue;
      }

      var_01 method_8627("isl_plane_interior_mix");
    }

    wait(0.2);
  }
}

aud_plane_spawn() {
  var_00 = self;
  foreach(var_02 in level.var_744A) {
    var_02 thread aud_plane_spawn_watcher(var_00);
  }
}

aud_plane_spawn_watcher(param_00) {
  param_00 endon("death");
  var_01 = self;
  while(1 && isDefined(param_00)) {
    var_02 = distance(param_00.var_116, var_01.var_116);
    if(var_02 <= 8000) {
      var_03 = lib_0380::func_288B("plane_flyby", undefined, param_00);
      lib_0380::func_288F(var_03, param_00, "plane_sound_done");
      param_00 waittill("plane_sound_done");
    }

    wait(0.3);
  }
}

aud_plane_firing() {
  self endon("death");
  var_00 = self;
  while(common_scripts\utility::func_3794("turret_on")) {
    lib_0380::func_288B("veh_stuka_mg_shot", undefined, var_00);
    wait(0.1);
  }
}

aud_plane_damage_player() {
  var_00 = self;
  lib_0380::func_2888("bullet_large_flesh_plr");
  if(lib_0378::func_8D1B(0.3)) {
    wait(0.1);
    var_01 = var_00.var_116 + (randomintrange(25, 50), randomintrange(25, 50), var_00.var_116[2]);
    lib_0380::func_2889("whizby_near", undefined, var_00.var_116);
  }
}

aud_plane_tailspin() {
  self endon("death");
  var_00 = self;
  lib_0380::func_288D("plane_destruct_death_pop", undefined, var_00, undefined, undefined, 0.1);
}

aud_plane_explode(param_00) {
  lib_0380::func_2889("plane_destruct_exp_close", undefined, param_00);
}