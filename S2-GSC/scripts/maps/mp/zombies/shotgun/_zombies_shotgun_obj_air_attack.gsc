/*******************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_obj_air_attack.gsc
*******************************************************************************/

sg_init_obj_air_attack() {
  common_scripts\utility::flag_init("flag_flak_cannons_powered_on");
  common_scripts\utility::flag_init("flag_flak_cannons_ready");
  common_scripts\utility::flag_init("flag_players_have_won");
  common_scripts\utility::_id_092C("plane_death", "vfx/vehicle/p47_death");
  common_scripts\utility::_id_092C("zmb_isl_aa_gun_gk_energy", "vfx/map/mp_zombie_island/zmb_isl_aa_gun_gk_energy");
  common_scripts\utility::_id_092C("zmb_stuka_turret_dirt_impact", "vfx/zombie/zmb_stuka_turret_dirt_impact");
  common_scripts\utility::_id_092C("zmb_clouds_puff_static", "vfx/map/mp_zombie_island/zmb_clouds_puff_static");
  common_scripts\utility::_id_092C("zmb_isl_enemy_plane_tracer", "vfx/map/mp_zombie_island/zmb_isl_enemy_plane_tracer");
  aa_gun_trap_init();
  aa_gun_power_init();
  aud_air_attack_init();
  plane_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("air_attack", ::run_air_attack, 120, 0, 1);
}

run_air_attack(var_0) {
  air_attack_set_rules();
  level notify("air_attack_start");
  level thread air_attack_score_counter();
  level thread air_attack_wave_handler();
  level thread air_attack_cloud_handler();
  [var_2, var_3] = level common_scripts\utility::_id_A70E(level, "flag_players_have_won", level, "sg_obj_timeout");

  if(var_2 == "flag_players_have_won")
    return 1;
  else {
    common_scripts\utility::flag_set("flag_players_have_won");
    return 0;
  }
}

air_attack_skip_cleanup() {
  level endon("flag_players_have_won");
  level endon("sg_obj_timeout");
  level waittill("skipWave");
  common_scripts\utility::flag_set("flag_players_have_won");
}

air_attack_set_rules() {
  level.aagun_ee_difficulty = level.players.size;

  if(level.aagun_ee_difficulty == 1)
    level.points_to_win = 10;

  if(level.aagun_ee_difficulty == 2)
    level.points_to_win = 12;

  if(level.aagun_ee_difficulty >= 3)
    level.points_to_win = 13;
}

air_attack_adjust_rules() {
  var_0 = level.aagun_ee_difficulty;
  var_1 = level.players.size;

  if(var_1 >= var_0) {
    if(var_1 == 2)
      level.points_to_win = 12;

    if(var_1 >= 3)
      level.points_to_win = 13;
  }
}

air_attack_score_counter() {
  while(level.current_score <= level.points_to_win) {
    level waittill("air_attack_plane_killed");
    level.current_score++;
  }

  level notify("air_attack_all_planes_destroyed");
  common_scripts\utility::flag_set("flag_players_have_won");
}

air_attack_cloud_handler() {
  var_0 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_a", "targetname");
  var_1 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_b", "targetname");
  var_2 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_c", "targetname");
  var_3 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_d", "targetname");
  var_4 = common_scripts\utility::_id_46B7("struct_cloud_fx_spawner_f", "targetname");

  foreach(var_6 in var_0)
  playFX(common_scripts\utility::_id_44F5("zmb_clouds_puff_static"), var_6.origin, (1, 1, 0));

  foreach(var_6 in var_1)
  playFX(common_scripts\utility::_id_44F5("zmb_clouds_puff_static"), var_6.origin, (1, -1, 0));

  foreach(var_6 in var_2)
  playFX(common_scripts\utility::_id_44F5("zmb_clouds_puff_static"), var_6.origin, (-1, -1, 0));

  foreach(var_6 in var_3)
  playFX(common_scripts\utility::_id_44F5("zmb_clouds_puff_static"), var_6.origin, (-1, 1, 0));

  foreach(var_6 in var_4)
  playFX(common_scripts\utility::_id_44F5("zmb_clouds_puff_static"), var_6.origin, (0, -1, 0));
}

air_attack_wave_handler() {
  var_0 = [1, 2, 3, 4];

  while(!common_scripts\utility::_id_3C77("flag_players_have_won")) {
    var_1 = common_scripts\utility::random(var_0);
    var_0 = common_scripts\utility::_id_0F93(var_0, var_1);

    if(var_0.size <= 0)
      var_0 = [1, 2, 3, 4];

    switch (var_1) {
      case 1:
        air_attack_adjust_rules();
        level.wave_a = _func_1DC("plane_start_node_a", "targetname");
        var_2 = level.wave_a air_attack_spawn_plane_wave();
        break;
      case 2:
        air_attack_adjust_rules();
        level.wave_b = _func_1DC("plane_start_node_b", "targetname");
        var_2 = level.wave_b air_attack_spawn_plane_wave();
        break;
      case 3:
        air_attack_adjust_rules();
        level.wave_c = _func_1DC("plane_start_node_c", "targetname");
        var_2 = level.wave_c air_attack_spawn_plane_wave();
        break;
      case 4:
        air_attack_adjust_rules();
        level.wave_d = _func_1DC("plane_start_node_d", "targetname");
        var_2 = level.wave_d air_attack_spawn_plane_wave();
        break;
      default:
        break;
    }

    wait 30;
  }
}

air_attack_spawn_plane_wave() {
  var_0 = [];
  var_1 = 0;

  foreach(var_3 in self) {
    var_4 = var_3 plane_spawn_plane();
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_4);
  }

  var_6 = var_0[0].targetname;
  thread air_attack_bonus_point_counter(var_0, var_6);
  return var_0;
}

air_attack_bonus_point_counter(var_0, var_1) {
  var_2 = 0;
  thread air_attack_plane_cleaner(var_0);

  while(var_0.size >= 0) {
    level waittill(var_1);
    var_2++;

    if(var_2 >= 6) {
      level.current_score = level.current_score + 1;
      break;
    }

    wait 1;
  }
}

air_attack_plane_cleaner(var_0) {
  while(var_0.size >= 0) {
    var_0 = common_scripts\utility::_id_0FA0(var_0);
    wait 0.5;
  }
}

aa_gun_trap_init() {
  var_0 = common_scripts\utility::_id_46B7("aa_gun_trap", "targetname");

  foreach(var_2 in var_0) {
    var_2 aa_gun_trap_prep();
    var_2 thread aa_gun_use_think();
  }

  foreach(var_5 in aa_gun_get_all_turrets())
  var_5 thread aa_gun_manage_swaps();
}

aa_gun_get_all_turrets() {
  return getEntArray("tur_flak_gun", "script_noteworthy");
}

aa_gun_trap_prep() {
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");
  self._id_1176 = [];

  foreach(var_2 in var_0) {
    switch (var_2._id_0165) {
      case "trig_use":
        self._id_9D65 = var_2;
        self._id_9D65.hint_string_available = &"ZOMBIE_ISLAND_BUY_FLAK";
        self._id_9D65.hint_string_unavailable = &"ZOMBIE_ISLAND_FLAK_DISABLED";
        self._id_9D65.hint_string_no_power = &"ZOMBIES_REQUIRES_POWER";
        var_2 _meth_80CE(self._id_9D65.hint_string_unavailable);
        var_2 common_scripts\utility::_id_9D9F();
        break;
      case "tur_flak_gun":
        self._id_9EDD = var_2;
        break;
      case "flak_cannon_attack_points":
        self._id_1176 = common_scripts\utility::_id_0F6F(self._id_1176, var_2);
        break;
      case "sbm_wall":
        self.wall_model = var_2;
        self.wall_model.health = 500;
        self.wall_model common_scripts\utility::_id_3799("this_turret_is_done");
        break;
    }
  }

  self.wall_model thread aa_gun_close_gate();
}

aa_gun_use_think() {
  self._id_9D65._id_267B = 750;
  level waittill("air_attack_start");
  self._id_9D65 common_scripts\utility::_id_9DA3();
  self._id_9D65 _meth_80CE(self._id_9D65.hint_string_no_power);
  common_scripts\utility::_id_3C9F("flag_flak_cannons_powered_on");
  self.wall_model thread aa_gun_open_gate();
  self._id_9D65 _meth_80CE(self._id_9D65.hint_string_available);
  thread aa_gun_wait_for_use();
  var_0 = undefined;

  for(;;) {
    level waittill("aa_gun_request", var_1, var_2);

    if(isDefined(var_2) && var_2 != self) {
      continue;
    }
    if(!isPlayer(var_1)) {
      if(common_scripts\utility::_id_562E(var_1))
        aa_gun_set_locked();

      self._id_9D65 _meth_80CE(self._id_9D65.hint_string_available);
      continue;
    } else
      var_0 = var_1;

    if(!var_0 maps\mp\gametypes\zombies::_id_11C2(self._id_9D65._id_267B)) {
      var_0 thread _id_054E::_id_0695("needmoney");
      continue;
    } else {
      self._id_9D65 common_scripts\utility::_id_9D9F();
      self.wall_model thread aa_gun_close_gate();
      self.wall_model aa_gun_set_player_using(var_0, self._id_9EDD);
      var_3 = ["zombie_generic", "zombie_berserker"];
      self.wall_model thread maps\mp\mp_zombies_attack_object::create_inanimate_zombie_enemy(3, 400, "this_turret_is_done", 1024, 512, ::aa_gun_terminate_nuke, [::aa_gun_player_left_listen, ::aa_gun_player_death_listen, ::aa_gun_player_disconnect_listen], self._id_1176, var_3, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"], var_0);
      self.wall_model common_scripts\utility::_id_379C("this_turret_is_done");
      self.wall_model aa_gun_unset_player_using(var_0, self._id_9EDD);
      self.wall_model common_scripts\utility::_id_3796("this_turret_is_done");
      playFX(level._effect["zmb_isl_aa_gun_gk_energy"], self.wall_model.origin, anglesToForward(self.wall_model.angles));
      var_0 _id_0378::_id_8D74("aud_stunning_burst_use");
      self.wall_model thread aa_gun_open_gate();
      wait 1;
      self._id_9D65 common_scripts\utility::_id_9DA3();
      self._id_9D65 _meth_80CE(self._id_9D65.hint_string_unavailable);
      wait 12.5;
      aa_gun_set_locked();
      self._id_9D65 _meth_80CE(self._id_9D65.hint_string_available);
    }
  }
}

aa_gun_power_init() {
  level.aagun_switches_on = 0;
  var_0 = common_scripts\utility::_id_46B7("aagun_switch", "targetname");

  foreach(var_2 in var_0) {
    var_2 aa_gun_power_switch_init();
    var_2 thread aa_gun_power_switch_think();
  }
}

aa_gun_power_switch_init() {
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");
  var_1 = _func_21F("power_switch_aagun", "targetname");
  self.computer_panels = common_scripts\utility::_id_4461(self.origin, var_1);
  self.computer_panels _meth_83FA("cbreaker", "standby_idle");
  self.computer_panels _meth_83FA("light_red", "on");
  self.computer_panels _meth_83FA("light_green", "off");
  self.computer_panels _meth_83FA("light_power", "off");
  self.computer_panels _meth_83FA("light_graph", "off");

  foreach(var_3 in var_0) {
    switch (var_3._id_0165) {
      case "use_trigger":
        self._id_9D65 = var_3;
        self._id_9D65 _meth_80CE(&"ZOMBIES_POWER_ON");
        self._id_9D65 common_scripts\utility::_id_9D9F();
        break;
    }
  }
}

aa_gun_power_switch_think() {
  level waittill("air_attack_start");
  self._id_9D65 common_scripts\utility::_id_9DA3();

  for(;;) {
    self._id_9D65 waittill("trigger", var_0);
    level.aagun_switches_on++;
    self._id_9D65 common_scripts\utility::_id_9D9F();
    self._id_9D65 _meth_80CE(&"ZOMBIES_EMPTY_STRING");
    self.computer_panels _meth_83FA("cbreaker", "ready");
    self.computer_panels _meth_83FA("light_red", "off");
    self.computer_panels _meth_83FA("light_green", "on");
    self.computer_panels _meth_83FA("light_power", "on");
    self.computer_panels _meth_83FA("light_graph", "on");
    common_scripts\utility::flag_set("flag_flak_cannons_powered_on");
  }
}

aa_gun_set_locked() {
  while(common_scripts\utility::_id_562E(level.aa_guns_locked)) {
    self._id_9D65 _meth_80CE(self._id_9D65.hint_string_unavailable);
    wait 0.125;
  }
}

aa_gun_wait_for_use() {
  for(;;) {
    self._id_9D65 waittill("trigger", var_0);
    level notify("aa_gun_request", var_0, self);
  }
}

aa_gun_lock_turrets(var_0) {
  level.aa_guns_locked = var_0;
  level notify("aa_gun_request", var_0);
}

#using_animtree("animated_props_zombies_DLC1");

aa_gun_close_gate() {
  self _meth_8276("s2_zom_flak_gun_gate_close");
  _id_0378::_id_8D74("flak_gun_gate_up");
  wait(_func_065(%s2_zom_flak_gun_gate_open));
  self _meth_8276("s2_zom_flak_gun_gate_close_idle");
}

aa_gun_open_gate() {
  self _meth_8276("s2_zom_flak_gun_gate_open");
  _id_0378::_id_8D74("flak_gun_gate_down");
  wait(_func_065(%s2_zom_flak_gun_gate_open));
  self _meth_8276("s2_zom_flak_gun_gate_open_idle");
}

aa_gun_terminate_nuke() {
  var_0 = _id_0547::_id_408F();
  var_1 = 0;

  foreach(var_3 in common_scripts\utility::_id_40B0(self.origin, var_0, undefined, undefined, 200)) {
    if(_id_0547::_id_5565(var_3._id_0A4B, "zombie_generic") || _id_0547::_id_5565(var_3._id_0A4B, "zombie_berserker"))
      var_3 _id_056D::_id_5A86();
  }
}

aa_gun_set_player_using(var_0, var_1) {
  self.turret_player = var_0;
  self._id_9EDD = var_1;
  var_0._id_00CE = 1;
  var_0.on_aa_gun = 1;
  var_1 _meth_8093(var_0);
  var_0._id_480F = 1;
  var_0 _meth_82FF("ui_zm_turret_health", 1);
  var_0 _meth_80EB();
  wait 1.5;
  var_0 _meth_80EC();
}

aa_gun_unset_player_using(var_0, var_1) {
  var_0._id_00CE = 0;
  var_0.on_aa_gun = 0;
  var_0 _meth_85E9();
  var_0._id_480F = 0;
  var_0 _meth_82FF("ui_zm_turret_health", 0);
  var_0 notify("left_aa_gun");
}

aa_gun_timeout_listen(var_0) {
  self endon(var_0);
  wait 15;
}

aa_gun_player_left_listen(var_0) {
  self endon(var_0);
  self._id_9EDD waittill("turret_deactivate");
}

aa_gun_player_death_listen(var_0) {
  self endon(var_0);

  while(isDefined(self.turret_player) && isalive(self.turret_player) && !common_scripts\utility::_id_562E(self.turret_player._id_5728))
    waitframe();
}

aa_gun_player_disconnect_listen(var_0) {
  self endon(var_0);
  self.turret_player waittill("disconnect");
}

aa_gun_capture_turret_fire(var_0) {
  self endon("death");
  level endon("game_ended");
  self endon("turretownerchange");

  for(;;) {
    self waittill("turret_fire", var_1);

    if(!isDefined(var_1[0])) {
      continue;
    }
    thread plane_flak_projectile_zombie_proximity_detonate(var_1[0], var_0);
    level notify("flak_projectile_fired", var_1[0], var_0);
  }
}

aa_gun_manage_swaps() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("turretownerchange");
    var_0 = self _meth_80E2();

    if(isDefined(var_0) && isPlayer(var_0))
      thread aa_gun_capture_turret_fire(var_0);
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
  var_0 = "ger_bomber_stuka_hub";
  var_1 = "ger_bomber_stuka_vista";
  var_2 = _func_2CD(self.origin, self.angles, var_0, var_1);
  var_2.targetname = self.targetname;
  level.active_planes[level.active_planes.size] = var_2;
  var_2 _meth_80B1();
  var_2 notify("forward");
  var_2._id_01C7 = "forward";
  var_2._id_01C1 = "forward";
  var_2._id_17DC = 0;
  var_2._id_931A = "forward";
  var_2 _id_0378::_id_8D74("aud_plane_spawn");
  var_2 thread plane_gun_think();
  var_2 _meth_827C(self);
  var_2 thread plane_vehicle_paths_non_heli(self);
  var_2 thread maps\mp\gametypes\_damage::_id_8676(100);
  var_2.health = 60;
  var_2.damagecallback = ::plane_on_damage;
  var_2 thread plane_handle_flak_projectile_proximity();
  var_2 thread plane_cleanup();
  return var_2;
}

plane_cleanup() {
  wait 4;

  for(;;) {
    if(isDefined(self) && self._id_01C4 <= 0) {
      level.active_planes = common_scripts\utility::_id_0F93(level.active_planes, self);
      self notify("death");
      self delete();
      break;
    }

    wait 3;
  }
}

plane_damage_player() {
  self endon("death");
  var_0 = _func_18E("vol_plane_damage_area", "targetname");

  while(common_scripts\utility::_id_3794("turret_on")) {
    var_1 = self.origin;
    var_2 = anglesToForward(self _meth_8181("TAG_MUZZLE_FX_1"));
    var_3 = 10000;
    var_4 = 180;
    var_5 = bulletTrace(self gettagorigin("TAG_MUZZLE_FX_1"), var_1 + var_2 * var_3, 0, undefined, 1, 1, 0, 0, 0, 0, 0);

    if(isDefined(var_5["position"])) {
      var_6 = var_5["position"];
      var_7 = _id_0547::_id_408F();
      var_7 = _func_1AC(var_7, var_6, var_4, 1);

      foreach(var_9 in var_7) {
        if(_func_07E(var_6 + (0, 0, 25), var_9 getEye(), 0))
          var_9 _meth_8059(80, self.origin);
      }

      var_11 = _func_1AC(level.players, var_6, var_4, 1);

      foreach(var_13 in var_11) {
        if(_func_07E(var_6 + (0, 0, 25), var_13.origin, 0) || _func_07E(var_6 + (0, 0, 25), var_13 gettagorigin("j_spine4"), 0) || _func_07E(var_6 + (0, 0, 25), var_13 getEye(), 0)) {
          var_13 _meth_8059(23, self.origin);
          var_13 notify("aagun_damage");
        }
      }
    }

    wait 0.22;
  }
}

plane_gun_think() {
  self endon("death");
  common_scripts\utility::_id_3799("turret_on");
  common_scripts\utility::_id_3799("turret_off");
  common_scripts\utility::_id_379C("turret_on");
  var_0 = self gettagorigin("TAG_MUZZLE_FX_1");
  var_1 = self gettagorigin("TAG_MUZZLE_FX_2");
  common_scripts\utility::_id_379C("turret_on");
  _id_0378::_id_8D74("aud_plane_firing");
  thread plane_damage_player();

  while(common_scripts\utility::_id_3794("turret_on")) {
    _func_147(common_scripts\utility::_id_44F5("zmb_isl_enemy_plane_tracer"), self, "TAG_MUZZLE_FX_1");
    _func_147(common_scripts\utility::_id_44F5("zmb_isl_enemy_plane_tracer"), self, "TAG_MUZZLE_FX_2");
    wait 0.2;
  }
}

plane_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("air_attack_plane_killed");

  if(common_scripts\utility::_id_562E(self.findingacrashpath)) {
    return;
  }
  if(isDefined(var_1._id_01D1) && !isPlayer(var_1))
    var_1 = var_1 _meth_80E2();

  if(isDefined(self._id_6E74))
    var_12 = self._id_6E74;
  else
    var_12 = self;

  if(var_5 != "turretweapon_ger_btry_flak38_mp_zombie" && var_5 != "bazooka_mp" && var_5 != "panzerschreck_mp" && var_5 != "fliegerfaust_zm" && var_5 != "fliegerfaust_pap_zm")
    var_2 = 1;

  var_12.health = var_12.health - var_2;

  if(var_12.health <= 0) {
    if(isDefined(var_1)) {
      var_1 _id_04C7::_id_A102("killshot");

      if(isDefined(level.zmb_events_player_destroyed_stuka))
        var_1 thread[[level.zmb_events_player_destroyed_stuka]]();
    }

    if(isDefined(var_5) && isPlayer(var_1))
      var_1 notify("plane_crashy", var_5);

    var_12 plane_crashy();
  } else if(isDefined(var_1))
    var_1 _id_04C7::_id_A102("standard");
}

plane_on_death(var_0, var_1, var_2, var_3) {
  self endon("death");
  self._id_1180 = var_0;
}

plane_crashy() {
  if(common_scripts\utility::_id_562E(self.findingacrashpath)) {
    return;
  }
  if(!isDefined(self._id_272B) || self._id_272B == 0) {
    self._id_272B = 1;
    self notify("crashing");
    _id_0378::_id_8D74("aud_plane_tailspin");

    if(common_scripts\utility::_id_562E(self.mustfindacrashpath)) {
      self.findingacrashpath = 1;
      plane_wait_for_valid_crash_path();
    }

    var_0 = self._id_2944;

    if(isDefined(var_0) && isDefined(var_0.script_exploder)) {
      self.crashingspecial = 1;
      var_0 = self._id_2944;
      plane_goto_linkto_path(var_0);
      waitframe();
      self waittill("reached_dynamic_path_end");
      common_scripts\utility::_id_379A("plane_crashed");
      return;
    } else {
      var_1 = _func_0A5(-90, 90);
      var_2 = (0, _func_0A7(var_1), _func_0A6(var_1));
      var_3 = (_func_0A5(-1000, 1000), _func_0A5(-1000, 1000), _func_0A5(-1000, 1000));
      var_4 = 1.2;
      self _meth_8224(level.player.origin + var_3, self _meth_8283() * var_4, var_2);
    }

    common_scripts\utility::waittill_notify_or_timeout("veh_collision", _func_0A5(0.5, 3.0));
  }

  if(!isDefined(self.crashingspecial) || self.crashingspecial == 0)
    plane_go_boom();
}

plane_wait_for_valid_crash_path() {
  self endon("plane_got_away");

  for(;;) {
    if(isDefined(self._id_2944) && isDefined(self._id_2944.script_exploder)) {
      var_0 = _func_1DC(self._id_2944.script_exploder, "script_linkname");

      if(var_0.size > 0) {
        break;
      }
    }

    waitframe();
  }

  return 1;
}

plane_go_boom(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = anglesToForward(self.angles);

  if(!common_scripts\utility::_id_562E(var_0)) {
    playFX(level._effect["plane_death"], self.origin, var_1);
    _id_0378::_id_8D74("aud_plane_explode", self.origin);
  }

  level notify(self.targetname);
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
    level waittill("flak_projectile_fired", var_0, var_1);

    if(!isDefined(var_0)) {
      continue;
    }
    thread plane_flak_projectile_proximity_detonate(var_0, var_1);
  }
}

plane_flak_projectile_zombie_proximity_detonate(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_2 = 64;
  var_3 = common_scripts\utility::_id_4461(var_0.origin, _id_0547::_id_408F());

  for(;;) {
    if(isDefined(var_3) && _func_0E1(var_3 getEye(), var_0.origin) < var_2 && _func_0AE(var_0.origin[2] - var_3.origin[2]) < 120) {
      var_1 _id_04C7::_id_A102("standard");
      var_0 _meth_8561("turretweapon_ger_btry_flak38_mp_zombie", var_1, var_0);
      break;
    }

    waitframe();
  }
}

plane_flak_projectile_proximity_detonate(var_0, var_1) {
  self endon("death");
  self endon("crashing");
  var_1 endon("disconnect");
  level endon("game_ended");
  var_0 endon("death");
  var_2 = 250000;

  for(;;) {
    var_3 = self.origin;
    var_4 = distancesquared(var_0.origin, var_3);

    if(var_4 < var_2) {
      var_0 notify("plane_death");
      self _meth_8059(500, var_3, var_1, var_0, "MOD_PROJECTILE", var_0._id_A9E0);
      var_0 _meth_81D6();
    }

    waitframe();
  }
}

plane_get_from_vehicle_node(var_0) {
  return _func_1DB(var_0, "targetname");
}

plane_get_from_vehicle_node_reverse(var_0) {
  var_1 = _func_1DB(var_0, "targetname");
  var_2 = var_1 _meth_8650();
  return var_2 _meth_8650();
}

plane_get_path_getfunc(var_0) {
  var_1 = ::plane_get_from_vehicle_node;
  return var_1;
}

plane_get_path_getfunc_reverse(var_0) {
  var_1 = ::plane_get_from_vehicle_node_reverse;
  return var_1;
}

plane_death_roll_on() {
  if(self.health > 0)
    self._id_7ED6 = 1;
}

plane_death_roll_off() {
  self._id_7ED6 = undefined;
  self notify("deathrolloff");
}

plane_goto_linkto_path(var_0) {
  waittillframeend;

  if(isDefined(var_0) && isDefined(var_0.script_exploder)) {
    var_1 = _func_1DC(var_0.script_exploder, "script_linkname");

    if(isDefined(var_1) && isDefined(var_1[0])) {
      thread plane_vehicle_paths_non_heli(var_1[0]);
      self _meth_827C(var_1[0]);
    }
  }
}

plane_node_wait(var_0, var_1, var_2) {
  if(self._id_1146 == var_0 && !isDefined(var_1)) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  if(isDefined(self._id_A01E))
    var_3 = "node_wait_triggered" + self._id_A01E;
  else
    var_3 = "node_wait_triggered";

  if(!isDefined(var_0._id_9DBB) || var_0._id_9DBB != gettime()) {
    var_4 = spawnStruct();
    plane_wait_til_node_wait_triggered(var_4, var_3, var_0, var_2);
    var_4 waittill(var_3);
  }

  var_0._id_9DBB = undefined;
}

plane_wait_til_node_wait_triggered(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  for(var_5 = var_2; isDefined(var_2) && var_4 < 3; var_2 = [[var_3]](var_2.target)) {
    var_4++;
    thread plane_node_wait_triggered(var_0, var_1, var_2);

    if(!isDefined(var_2.target))
      return;
  }
}

plane_node_wait_triggered(var_0, var_1, var_2) {
  self endon("newpath");
  self endon("death");
  var_0 endon(var_1);
  var_2 waittill("trigger");
  var_2._id_9DBB = gettime();
  waittillframeend;
  var_0 notify(var_1);
}

plane_vehicle_paths_non_heli(var_0) {
  self notify("newpath");

  if(isDefined(var_0))
    self._id_1146 = var_0;

  var_1 = self._id_1146;
  self._id_2944 = self._id_1146;

  if(!isDefined(var_1)) {
    return;
  }
  self endon("newpath");
  self endon("death");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = plane_get_path_getfunc(var_1);
  var_6 = plane_get_path_getfunc_reverse(var_1);

  if(self._id_01C1 == "reverse")
    var_7 = var_6;
  else
    var_7 = var_5;

  while(isDefined(var_4)) {
    plane_node_wait(var_4, var_3, var_7);

    if(!isDefined(self)) {
      return;
    }
    self._id_2944 = var_4;

    if(isDefined(var_4._id_0165)) {
      self notify(var_4._id_0165);
      self notify("noteworthy", var_4._id_0165);
    }

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_4._id_8272)) {
      var_4._id_8186 = var_4._id_8272;
      var_4._id_8272 = undefined;
    }

    if(isDefined(var_4._id_8186)) {
      var_8 = var_4._id_8187;

      if(isDefined(var_8))
        level maps\mp\_utility::_id_2CED(var_8, common_scripts\_exploder::exploder, var_4._id_8186);
      else
        level common_scripts\_exploder::exploder(var_4._id_8186);
    }

    if(isDefined(var_4._id_81A0))
      common_scripts\utility::flag_set(var_4._id_81A0);

    if(isDefined(var_4._id_8183))
      common_scripts\utility::_id_379A(var_4._id_8183);

    if(isDefined(var_4._id_8182))
      common_scripts\utility::_id_3796(var_4._id_8182);

    if(isDefined(var_4._id_819B))
      common_scripts\utility::_id_3C7B(var_4._id_819B);

    if(isDefined(var_4._id_0165)) {
      if(var_4._id_0165 == "godon")
        self._id_480F = 1;

      if(var_4._id_0165 == "godoff")
        self._id_480F = 0;

      if(var_4._id_0165 == "engineoff")
        self _meth_828D();
    }

    if(isDefined(var_4._id_8145))
      self._id_8145 = var_4._id_8145;

    if(isDefined(var_4._id_8121))
      self._id_8121 = var_4._id_8121;

    if(isDefined(var_4._id_82B2))
      self._id_82B2 = var_4._id_82B2;

    if(isDefined(var_4._id_82C1))
      self notify("turning", var_4._id_82C1);

    if(isDefined(var_4._id_8150)) {
      if(var_4._id_8150 == 0)
        thread plane_death_roll_off();
      else
        thread plane_death_roll_on();
    }

    if(isDefined(var_4._id_82D4)) {
      if(isDefined(var_4._id_8260) && var_4._id_8260 == "queue")
        self._id_7889 = 1;
    }

    if(isDefined(var_4._id_812B))
      self._id_01C0 = var_4._id_812B;

    if(isDefined(var_4._id_8265))
      self._id_01C3 = var_4._id_8265;

    if(isDefined(var_4._id_8262))
      self._id_01C1 = var_4._id_8262;

    if(isDefined(var_4._id_8184)) {
      var_9 = 35;

      if(isDefined(var_4._id_8151))
        var_9 = var_4._id_8151;

      self _meth_8280(0, var_9);
      common_scripts\utility::_id_379C(var_4._id_8184);

      if(!isDefined(self)) {
        return;
      }
      var_10 = 60;

      if(isDefined(var_4.script_accel))
        var_10 = var_4.script_accel;

      self _meth_8293(var_10);
    }

    var_3 = var_4;

    if(!isDefined(var_4.target)) {
      break;
    }

    if(self._id_01C1 == "reverse")
      var_7 = var_6;
    else
      var_7 = var_5;

    var_4 = [[var_7]](var_4.target);

    if(!isDefined(var_4)) {
      var_4 = var_3;
      break;
    } else if(!isDefined(var_4.target) || isDefined(var_4._id_82CA)) {
      var_11 = max(0.01, length(self _meth_8289()));
      var_12 = distance(self.origin, var_4.origin);
      var_13 = max(0.01, var_12 / var_11);
      self notify("about_to_stop", var_13);
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_82D3)) {
    self notify("delete");
    waittillframeend;
    self delete();
  } else
    thread plane_goto_linkto_path(var_4);
}

plane_track_damage(var_0, var_1) {
  plane_waittill_damage_from("turretweapon_ger_btry_flak38_mp_zombie");
}

plane_waittill_damage_from(var_0) {
  self _meth_82C3(1);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_10) || !issubstr(var_10, var_0)) {
      continue;
    }
    break;
  }
}

aud_air_attack_init() {
  _id_0378::_id_8DC7("flak_gun_gate_up", ::aud_aa_gun_gate_up);
  _id_0378::_id_8DC7("flak_gun_gate_down", ::aud_aa_gun_gate_down);
  _id_0378::_id_8DC7("aud_plane_mission_start", ::aud_plane_mission_start);
  _id_0378::_id_8DC7("aud_plane_spawn", ::aud_plane_spawn);
  _id_0378::_id_8DC7("aud_plane_firing", ::aud_plane_firing);
  _id_0378::_id_8DC7("aud_plane_damage_player", ::aud_plane_damage_player);
  _id_0378::_id_8DC7("aud_plane_tailspin", ::aud_plane_tailspin);
  _id_0378::_id_8DC7("aud_plane_explode", ::aud_plane_explode);
}

aud_aa_gun_gate_up() {
  var_0 = self;
  _id_0380::_id_288B("zmb_flak_gun_gate_up", undefined, var_0);
}

aud_aa_gun_gate_down() {
  var_0 = self;
  _id_0380::_id_288B("zmb_flak_gun_gate_down", undefined, var_0);
}

aud_plane_mission_start() {
  level endon("stop_plane_int_submix");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1.current_volume_is_interior) {
        var_1 _meth_8626("isl_plane_interior_mix");
        continue;
      }

      var_1 _meth_8627("isl_plane_interior_mix");
    }

    wait 0.2;
  }
}

aud_plane_spawn() {
  var_0 = self;

  foreach(var_2 in level.players)
  var_2 thread aud_plane_spawn_watcher(var_0);
}

aud_plane_spawn_watcher(var_0) {
  var_0 endon("death");
  var_1 = self;

  while(1 && isDefined(var_0)) {
    var_2 = distance(var_0.origin, var_1.origin);

    if(var_2 <= 8000) {
      var_3 = _id_0380::_id_288B("plane_flyby", undefined, var_0);
      _id_0380::_id_288F(var_3, var_0, "plane_sound_done");
      var_0 waittill("plane_sound_done");
    }

    wait 0.3;
  }
}

aud_plane_firing() {
  self endon("death");
  var_0 = self;

  while(common_scripts\utility::_id_3794("turret_on")) {
    _id_0380::_id_288B("veh_stuka_mg_shot", undefined, var_0);
    wait 0.1;
  }
}

aud_plane_damage_player() {
  var_0 = self;
  _id_0380::_id_2888("bullet_large_flesh_plr");

  if(_id_0378::_id_8D1B(0.3)) {
    wait 0.1;
    var_1 = var_0.origin + (_func_0A4(25, 50), _func_0A4(25, 50), var_0.origin[2]);
    _id_0380::_id_2889("whizby_near", undefined, var_0.origin);
  }
}

aud_plane_tailspin() {
  self endon("death");
  var_0 = self;
  _id_0380::_id_288D("plane_destruct_death_pop", undefined, var_0, undefined, undefined, 0.1);
}

aud_plane_explode(var_0) {
  _id_0380::_id_2889("plane_destruct_exp_close", undefined, var_0);
}