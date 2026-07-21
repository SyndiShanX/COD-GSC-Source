/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_ai.gsc
***********************************************/

init_spawnfunctions() {}

tunnels_spawnfunctions() {
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::tunnels_combat);
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::tunnels_flashlight_management);
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::tunnels_shotgun_guy_accuracy_management);
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::tunnels_door_guy_fire_aware);
  scripts\engine\sp\utility::add_global_spawn_function("axis", ::tunnels_shaft_molotov_giveth);
  thread basement_player_rush_handler();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_ceiling_guy", ::basement_ceiling_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("first_cell_guy", ::basement_first_cell_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("right_flank_runner", ::basement_right_flank_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("right_flank_surprise", ::basement_right_flank_surprise);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_door_surprise", ::basement_door_surprise_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_runner", ::basement_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_coward", ::basement_coward);
  scripts\engine\sp\utility::array_spawn_function_targetname("basement_sneak_1_spawner", ::basement_sneak_1_animated);
  scripts\engine\sp\utility::array_spawn_function_targetname("basement_sneak_1_backup_spawner", ::basement_sneak_1_backup);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_final_guy", ::basement_final_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_spotter", ::storage_spotter);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_runner", ::storage_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_ambusher", ::storage_ambusher);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_ambush_runner", ::storage_ambush_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_ambusher_blind_fire", ::storage_ambusher_blind_fire);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_lmg_camper", ::storage_lmg_camper);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_lmg_room_guy", ::storage_lmg_room_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_advancer", ::storage_advancer_mg_aware);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_lmg_guy", ::storage_lmg_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("first_storage_MG_nest_guy", ::storage_mg_nest_first_guy);
  scripts\engine\utility::array_thread(getEntArray("shaft_enemy_kill_trigger", "targetname"), ::enemy_death_by_fire_think);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_wave_1", ::shaft_wave_1_guy_fire_aware);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_chaser", ::shaft_chaser_fire_aware);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_follower", ::shaft_follower);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_propane_kick_guy", ::shaft_propane_kick_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_fall_victim", ::shaft_fall_victim);
  var_0 = getEnt("basement_runner_spawner_trig", "targetname");
  var_0 scripts\engine\utility::trigger_off();
}

friendly_nvg_setup() {
  if(!issubstr(self.headmodel, "_nvg") && (!isDefined(self.hatmodel) || !issubstr(self.hatmodel, "_nvg"))) {
    return;
  }
  if(isDefined(self.hatmodel))
    self.nvgmodel_off = self.hatmodel;
  else
    self.nvgmodel_off = self.headmodel;

  if(isDefined(self.animname) && self.animname == "price")
    self.nvgmodel_on = scripts\engine\sp\utility::getmodel("price_nvgs_on");
  else
    self.nvgmodel_on = scripts\engine\sp\utility::getmodel("generic_nvgs_on");
}

tunnels_shotgun_guy_accuracy_management() {
  self endon("death");
  self endon("entitydeleted");

  if(!issubstr(self.classname, "_shotgun")) {
    return;
  }
  thread tunnels_shotgun_guy_accuracy_debug();
  thread tunnels_shotgun_guy_monitor_weapon_fire();
  wait 0.1;
  var_0 = 10;

  for(;;) {
    self.baseaccuracy = 0.1;
    self.shotgun_rest = 1;

    for(;;) {
      if(isDefined(self.enemy) && isPlayer(self.enemy) && self cansee(level.player)) {
        break;
      }

      wait 0.05;
    }

    self waittill("weapon_fired");
    wait 0.05;
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::reset_baseaccuracy();
    self.shotgun_rest = 0;

    while(gettime() - self.last_weapon_fire_time < var_0 * 1000)
      wait 0.1;
  }
}

tunnels_shotgun_guy_accuracy_debug() {
  self endon("death");
  self endon("entitydeleted");

  for(;;)
    self waittill("weapon_fired");
}

tunnels_shotgun_guy_monitor_weapon_fire() {
  self endon("death");
  self endon("entitydeleted");
  self.last_weapon_fire_time = gettime();

  for(;;) {
    self waittill("weapon_fired");
    self.last_weapon_fire_time = gettime();
    wait 0.05;
  }
}

enemy_death_by_fire_think() {
  self endon("entitydeleted");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);
    var_0 thread enemy_death_by_fire(1);
    wait 0.05;
  }
}

enemy_death_by_fire(var_0) {
  self endon("death");
  var_1 = 256;

  if(istrue(var_0)) {
    if(isDefined(self) && isai(self) && isalive(self) && !isDefined(self._blackboard.isburning)) {
      var_2 = distance(level.player.origin, self.origin);

      if(var_2 > var_1) {
        thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_burn_death_scream();
        thread scripts\sp\equipment\molotov::molotovburnenemy(self, 1, self.origin + (0, 0, 8), level.player);
      }
    }
  } else {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_burn_death_scream();
    thread scripts\sp\equipment\molotov::molotovburnenemy(self, 1, self.origin + (0, 0, 8), level.player);
  }
}

basement_player_rush_handler() {
  scripts\engine\utility::flag_init("player_rushing_in_basement");
  scripts\engine\utility::array_thread(getEntArray("basement_rush_trig", "targetname"), ::player_rush_think);
}

player_rush_think() {
  self endon("entitydeleted");
  var_0 = self;
  var_1 = getEnt(self.target, "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  var_3 = float(self.script_noteworthy);
  var_0 waittill("trigger");
  var_4 = gettime();
  var_1 waittill("trigger");

  if(gettime() - var_4 < var_3 * 1000) {
    return;
  }
  scripts\engine\utility::flag_set("player_rushing_in_basement");
  var_5 = getaiarray("axis");
  var_6 = 0;

  foreach(var_8 in var_5) {
    if(isalive(var_8) && var_8 istouching(var_2) && istrue(var_8.reacts_to_rush)) {
      var_8 thread zdt_rush_guy();
      var_6++;
    }
  }
}

tunnels_combat() {
  self.spawn_time = gettime();

  if(scripts\engine\utility::flag("wolf_killed") || !scripts\sp\starts::is_after_start("downstairs")) {
    self.noarmor = 1;
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "first_blast")
    var_0 = 0.75;
  else
    var_0 = 1.5;

  self.original_baseaccuracy = var_0;
  self.baseaccuracy = var_0;

  if(scripts\engine\utility::flag("entered_shaft"))
    self.forcebalconydeath = 1;

  self.noloot = 1;
  thread tunnels_baseaccuracy_when_player_on_ladder_or_in_smoke_or_above_player_in_shaft();
}

tunnels_baseaccuracy_when_player_on_ladder_or_in_smoke_or_above_player_in_shaft() {
  self endon("death");
  var_0 = 0.5;
  var_1 = 200;
  var_2 = 0.1;
  var_3 = 0;

  for(;;) {
    wait 0.25;

    if(istrue(self.shotgun_rest)) {
      continue;
    }
    if(!isDefined(self.enemy) || !isPlayer(self.enemy)) {
      continue;
    }
    var_4 = 0;
    var_5 = self.baseaccuracy;

    if(is_above_player_in_shaft()) {
      var_6 = self.origin[2] - level.player.origin[2];

      if(var_6 > var_1)
        var_5 = var_0;
      else {
        var_7 = clamp(1 - var_6 / var_1, 0, 1);
        var_8 = self.original_baseaccuracy - var_0;
        var_5 = var_0 + var_8 * var_7;
      }

      var_4 = 1;
    }

    if(is_player_on_ladder_with_distance_check(120)) {
      var_5 = min(var_5, var_2);
      var_4 = 1;
    }

    if(is_not_safe_from_smoke()) {
      var_5 = min(var_5, var_3);
      var_4 = 1;
    }

    if(var_4) {
      self.baseaccuracy = var_5;
      continue;
    }

    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::reset_baseaccuracy();
  }
}

is_above_player_in_shaft() {
  var_0 = getEnt("shaft_top_level_enemy_grabber", "targetname");
  return self istouching(var_0) && self.origin[2] > level.player.origin[2];
}

is_player_on_ladder_with_distance_check(var_0) {
  var_1 = scripts\engine\utility::distance_2d_squared(self getEye(), level.player getEye()) > var_0 * var_0;
  return level.player isonladder() && var_1;
}

is_not_safe_from_smoke() {
  return !istrue(level.player_is_safe_from_smoke);
}

shutup_when_hit() {
  var_0 = scripts\engine\utility::waittill_any_return("damage", "death");

  if(isDefined(self)) {
    self stoploopsound();
    self stopsounds();
  }
}

get_alive_enemies() {
  var_0 = [];
  var_1 = getaiarray("axis");

  if(!isDefined(var_1) || var_1.size == 0)
    return var_0;

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3))
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

battlechatter_off_spawn_func() {
  self endon("death");

  while(!istrue(self.battlechatterallowed))
    wait 0.1;

  waitframe();
  scripts\engine\sp\utility::set_battlechatter(0);
}

tunnels_flashlight_management() {
  if(istrue(self.script_noflashlight)) {
    return;
  }
  if(isDefined(self.script_friendname) && (self.script_friendname == "hadir" || self.script_friendname == "wolf" || self.script_friendname == "Clacker")) {
    return;
  }
  if(scripts\engine\utility::flag("entered_shaft") || !scripts\engine\utility::flag("flare_in_fire")) {
    return;
  }
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "storage_spotter")
      return;
  }

  thread flashlight_management();
}

flashlight_management() {
  self endon("death");

  if(isDefined(self.script_parameters) && self.script_parameters == "force_flashlight") {
    scripts\sp\nvg\nvg_ai::flashlight_on();
    return;
  }

  scripts\sp\nvg\nvg_ai::flashlight_off();
  var_0 = cos(30);
  var_1 = 0.1;
  var_2 = 2;

  for(;;) {
    while(nullweapon(self.weapon))
      wait(var_1);

    if(is_aimming_at_enemy(var_0) || is_aimming_forward(var_0)) {
      if(!istrue(self.flashlight)) {
        scripts\sp\nvg\nvg_ai::flashlight_on();
        wait(var_2);
      }
    } else if(istrue(self.flashlight))
      scripts\sp\nvg\nvg_ai::flashlight_off();

    wait(var_1);
  }
}

is_aimming_at_enemy(var_0) {
  var_1 = "tag_weapon_right";

  if(isDefined(self.enemy) && (isPlayer(self.enemy) || isai(self.enemy)) && isalive(self.enemy)) {
    var_2 = ["j_mainroot", "j_spine4", "tag_eye"];

    foreach(var_4 in var_2) {
      if(!nullweapon(self.weapon) && isalive(self.enemy) && scripts\engine\utility::within_fov(self getEye(), self gettagangles(var_1), self.enemy gettagorigin(var_4), var_0))
        return 1;
    }
  }

  return 0;
}

is_aimming_forward(var_0) {
  var_1 = "tag_weapon_right";
  var_2 = (0, self gettagangles("TAG_ORIGIN")[1], 0);
  var_3 = vectorNormalize(anglesToForward(var_2)) * 32;
  var_4 = self getEye() + var_3;
  var_5 = self getEye();
  var_6 = self gettagangles(var_1);

  if(!nullweapon(self.weapon) && scripts\engine\utility::within_fov(var_5, var_6, var_4, var_0))
    return 1;

  return 0;
}

tunnels_ar_guys_force_ak47() {
  if(!issubstr(self.classname, "_ar")) {
    return;
  }
  if(scripts\engine\utility::flag("wolf_killed")) {
    return;
  }
  if(isDefined(self.script_noteworthy) && issubstr(self.script_noteworthy, "storage_ambusher")) {
    return;
  }
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "basement_ceiling_guy") {
    return;
  }
  if(isDefined(self.script_friendname) && (self.script_friendname == "hadir" || self.script_friendname == "wolf" || self.script_friendname == "Clacker")) {
    return;
  }
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::enemy_force_ak47();
}

tunnels_door_guy_fire_aware() {
  self endon("death");

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "opendoor")) {
    scripts\common\utility::demeanor_override("sprint");
    var_0 = strtok(self.script_parameters, "_")[1];
    var_1 = getEntArray(var_0, "targetname");
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::scripted_door_open(var_0, 0);
    wait 6;
    scripts\common\utility::clear_demeanor_override();
    thread fire_aware();
  }
}

tunnels_shaft_molotov_giveth() {
  self endon("death");

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "opendoor")) {
    return;
  }
  var_0 = 3;
  var_1 = get_touching_goal_vol();

  if(isDefined(var_1) && isDefined(var_1.targetname) && int(strtok(var_1.targetname, "_")[2]) >= var_0) {
    scripts\engine\sp\utility::set_grenadeweapon("molotov");

    if(scripts\engine\utility::cointoss())
      self.grenadeammo = 1;
    else
      self.grenadeammo = 2;

    self.grenadesafedist = 300;
  }
}

basement_footsteps(var_0, var_1, var_2) {
  wait(var_1);

  if(!isDefined(self)) {
    return;
  }
  var_3 = undefined;

  if(var_0 == "short") {
    var_4 = [];
    var_4[0] = "scn_aq_fs_running_tunnels_short_01";
    var_4[1] = "scn_aq_fs_running_tunnels_short_02";
    var_4[2] = "scn_aq_fs_running_tunnels_short_03";
    var_3 = scripts\engine\utility::random(var_4);
  } else if(var_0 == "long") {
    var_5 = [];
    var_5[0] = "scn_aq_fs_running_tunnels_long_01";
    var_5[1] = "scn_aq_fs_running_tunnels_long_02";
    var_3 = scripts\engine\utility::random(var_5);
  } else
    return;

  self playsoundatviewheight(var_3);
  var_7 = 5;
  thread stop_sound_when_slowed(var_7, var_2);
  var_8 = scripts\engine\utility::waittill_any_return("death", "entitydeleted", var_2);

  if(isDefined(self))
    self stopsounds();
}

stop_sound_when_slowed(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_1))
    self endon(var_1);

  var_2 = 0.25;
  var_3 = self.origin;
  var_4 = 0;
  var_0 = var_0 * var_2;

  for(;;) {
    wait(var_2);
    var_4 = length2d(self.origin - var_3) / var_2;
    var_3 = self.origin;

    if(var_4 < var_0) {
      self stopsounds();
      return;
    }
  }
}

basement_sneak_1() {
  self endon("death");
  self endon("entitydeleted");
  self.meleechargedistvsplayer = 48;
  scripts\engine\sp\utility::set_goal_radius(28);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  thread basement_footsteps("short", 0.35);
  thread basement_sneak_1_backup_spawn();
  self waittill("goal");
  var_0 = getnode("basement_sneak_node", "targetname");
  self setgoalpos(var_0.origin);
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread basement_left_flank_camper();
}

basement_sneak_1_animated() {
  self endon("death");
  self endon("entitydeleted");
  self.meleechargedistvsplayer = 48;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_sequence(["dx_vom_aq1_tunnels_hunt_62", "dx_vom_aq2_tunnels_hunt_64"], 1);
  self.animname = "basement_right_to_left_runner";
  self.allowdeath = 1;
  var_0 = scripts\engine\utility::getStruct("basement_right_to_left", "targetname");
  thread basement_footsteps("short", 0.35);
  thread basement_sneak_1_backup_spawn();
  var_0 thread scripts\common\anim::anim_single_solo(self, "basement_run");
  waitframe();
  var_1 = 0.37;
  self setanimtime(scripts\engine\utility::getanim("basement_run"), var_1);
  self waittillmatch("single anim", "end");
  self clearenemy();
  var_2 = getnode("basement_sneak_node", "targetname");
  self setgoalpos(var_2.origin);
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread basement_left_flank_camper();
}

basement_sneak_1_backup_spawn() {
  var_0 = scripts\engine\utility::waittill_any_return("death", "goal");

  if(isDefined(var_0) && var_0 == "death") {
    var_1 = getEnt("basement_sneak_1_backup", "targetname");
    var_1 notify("trigger", level.player);
  }
}

basement_sneak_1_backup() {
  self endon("death");
  self endon("entitydeleted");
  self.meleechargedistvsplayer = 48;
  self notify("behavior_reset");
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_goal_radius(32);
  var_0 = getnode("basement_sneak_node", "targetname");
  self setgoalpos(var_0.origin);
  self waittill("goal");
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread basement_left_flank_camper();
}

ai_slice_settings() {
  self.pathenemyfightdist = 48;
  self._blackboard.reacquiresteptime = 0;
  self.meleechargedistvsplayer = 80;
  self.aggressivemode = 1;
  self.cautiouslookaheaddist = 92.0;
  scripts\engine\utility::set_cautious_navigation(1);
  scripts\common\ai::set_gunpose("disable");
  self.combatmode = "no_cover";
}

basement_final_guy() {
  self endon("death");
  self waittill("goal");
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread ai_slice_settings();
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\utility::set_movement_speed(60);
  var_0 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var_0);
  scripts\engine\sp\utility::set_goal_radius(32);
  wait 5;
  scripts\common\ai::reset_gunpose();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::set_movement_speed(160);
}

basement_first_cell_guy() {
  self endon("death");
  level.basement_first_cell_guy = self;
  thread ai_slice_settings();
  self.meleechargedistvsplayer = 80;
  scripts\engine\sp\utility::set_goal_radius(32);
  thread spawn_right_flank_run_early_on_death_and_look_at_struct();
  var_0 = 16;
  var_1 = 50;
  thread monitor_enemy_been_seen(var_1);
  var_2 = getnodearray("basement_camper_exit_to", "targetname");
  var_3 = scripts\engine\utility::getclosest(self.origin, var_2, 300);
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_4 = getEnt(var_3.target, "targetname");
    thread basement_guy_wake_by_trigger(var_4);
    var_0 = 60;
  }

  scripts\engine\utility::set_cautious_navigation(0);
  scripts\common\utility::demeanor_override("sprint");
  thread first_cell_look_at_watch();
  wait(var_1 / 1000 + 0.05);
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittill_any_timeout, var_0, "bullethit", "grenade danger", "damage");
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittill_any_timeout, var_0, "enemybeenseen", "bulletwhizby", "wakebytrigger");
  scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "first_cell_look_at");
  scripts\engine\sp\utility::do_wait_any();
  scripts\engine\utility::ent_flag_init("blind_fire_finished");
  thread basement_first_cell_guy_canned_once();
  var_5 = 120;

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) < var_5) {
      self notify("blind_fire_right_stop_all");
      break;
    }

    if(scripts\engine\utility::flag("first_cell_guy_passed")) {
      break;
    }

    if(scripts\engine\utility::ent_flag("blind_fire_finished")) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\sp\utility::anim_stopanimScripted();
  scripts\common\utility::clear_demeanor_override();
  scripts\engine\utility::set_cautious_navigation(1);
  var_6 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var_6);
  scripts\engine\sp\utility::set_goal_radius(32);
  thread tunnels_notify_first_cell_guy_death();
  scripts\engine\utility::flag_wait("first_cell_guy_passed");
  scripts\common\ai::reset_gunpose();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::set_movement_speed(160);

  if(isDefined(level.farah) && isalive(level.farah))
    level.farah getenemyinfo(self);
}

first_cell_look_at_watch() {
  self endon("death");
  var_0 = getEnt("first_cell_look_at_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname").origin;
  var_0 waittill("trigger");

  while(!scripts\engine\sp\utility::player_looking_at(var_1, 0.95))
    wait 0.05;

  self notify("first_cell_look_at");
}

basement_first_cell_guy_canned_once() {
  self endon("death");
  self endon("entitydeleted");
  self endon("blind_fire_right_stop_all");
  self.allowdeath = 1;
  self.animname = "basement_firstcell";
  var_0 = scripts\engine\utility::getStruct("basement_blind_fire_right", "targetname");
  thread farah_first_cell_guy_warn_vo();
  var_0 scripts\sp\anim::anim_reach_solo(self, "blind_fire_right");
  scripts\engine\utility::delaythread(0.25, scripts\engine\sp\utility::smart_dialogue, "dx_vom_aq2_tunnels_ambusher_20");
  var_0 scripts\common\anim::anim_single_solo(self, "blind_fire_right");
  scripts\engine\utility::ent_flag_set("blind_fire_finished");
}

farah_first_cell_guy_warn_vo() {
  level endon("left_alcove_enemy");
  var_0 = anglesToForward(level.player.angles);
  var_1 = self.origin - level.player.origin;
  var_2 = scripts\engine\math::anglebetweenvectorssigned(var_0, var_1, (0, 0, 1));

  if(var_2 < 20 && var_2 > -110)
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_basement_tunnel_combat1_50", 2, 0.5);

  scripts\engine\sp\utility::waittill_dead(scripts\engine\utility::array_removedead([self, level.first_blast_enemy]));
  scripts\engine\utility::flag_wait("basement_runner_gone");
  wait 0.3;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(0.6, 3);

  if(istrue(level.runner_got_away)) {
    level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_tunnels_hunt_16", 1, 2);
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_hunt_19");
    level.runner_got_away = undefined;
  } else
    level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_tunnels_hunt_20", 1, 2);

  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_basement_tunnel_trips_10");
}

spawn_right_flank_run_early_on_death_and_look_at_struct() {
  var_0 = getEnt("right_flank_surprise_spawner_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct("right_flank_surprise_lookat_spawn", "targetname").origin;
  var_0 endon("death");
  var_0 endon("trigger");
  var_0 endon("entitydeleted");
  self waittill("death");
  wait 1.5;

  while(!scripts\engine\sp\utility::player_looking_at(var_1, 0.94))
    wait 0.2;

  if(isDefined(var_0))
    var_0 notify("trigger");
}

tunnels_notify_first_cell_guy_death() {
  level endon("first_cell_guy_passed");
  self waittill("death");
  scripts\engine\utility::flag_set("first_cell_guy_passed");
}

basement_right_flank_runner() {
  self endon("death");
  level.basement_right_flank_runner = self;
  scripts\engine\sp\utility::set_goal_radius(28);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  thread basement_footsteps("short", 0.35);
  self waittill("goal");
  self clearenemy();
  scripts\engine\sp\utility::set_pacifist(1);
  thread send_running_if_player_skipped_farah_ceiling_scene();
  self waittill("right_flank_goto");
  self.right_flank_running = 1;
  thread scripts\engine\sp\utility::set_ignoreall(1);
  scripts\engine\utility::delaythread(2, scripts\engine\sp\utility::set_ignoreall, 0);
  self.target = "right_flank_run_node";
  thread scripts\sp\spawner::go_to_node();
  thread basement_footsteps("short", 0.8);
  enemy_turn_off_lantern(3);
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 220);
}

enemy_turn_off_lantern(var_0) {
  var_1 = scripts\engine\utility::getStruct("right_flank_latern_shoot_at", "targetname").origin;
  wait(var_0);
  radiusdamage(var_1, 4, 100, 99, level.player, "MOD_PISTOL_BULLET");
}

send_running_if_player_skipped_farah_ceiling_scene() {
  self endon("death");
  self endon("right_flank_goto");
  scripts\engine\utility::flag_wait("right_flank_goto");

  if(istrue(level.farah_ceiling_takedown_scene_on)) {
    return;
  }
  self notify("right_flank_goto");
}

basement_right_flank_surprise() {
  if(scripts\engine\utility::flag("player_passed_right_flank")) {
    return;
  }
  thread enemy_turn_off_lantern(0.05);
  thread zdt_rush_guy();
  self waittill("death");
  scripts\engine\utility::flag_set("basement_right_flank_surpise_dealt");
}

coward_buddy_whisper() {
  scripts\engine\utility::waittill_any("death", "entitydeleted");
  wait 0.75;

  if(isDefined(level.basement_coward) && isalive(level.basement_coward) && !istrue(level.basement_coward.escape_now))
    level.basement_coward thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound("dx_vom_aq2_tunnels_ambusher_20");
}

basement_door_surprise_guy() {
  level.basement_door_guy = self;
  thread zdt_rush_guy();
  self waittill("death");
  scripts\engine\utility::flag_set("basement_door_guy_dealt");
  thread scripts\engine\sp\utility::autosave_now();
}

basement_runner() {
  self endon("death");
  self notify("behavior_reset");
  self endon("behavior_reset");

  if(!isDefined(level.basement_runners))
    level.basement_runners = [];

  level.basement_runners[level.basement_runners.size] = self;
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(16);
  wait 0.5;
  var_0 = getEnt("basement_runner_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname").origin;

  for(;;) {
    if(self hasenemybeenseen(50) || self cansee(level.player)) {
      break;
    }

    if(isDefined(var_0) && level.player istouching(var_0) && scripts\engine\sp\utility::player_looking_at(var_1, 0.9)) {
      break;
    }

    if(istrue(var_0.skipped)) {
      break;
    }

    if(istrue(self.escape_now)) {
      break;
    }

    wait 0.05;
  }

  var_2 = randomfloatrange(1, 1.6);
  thread basement_footsteps("long", var_2);

  if(isDefined(level.basement_runners[0]) && level.basement_runners[0] == self)
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound("dx_vom_aq1_tunnels_search_112");

  var_3 = getnode("basement_coward_node", "targetname");
  self setgoalnode(var_3);
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\common\utility::demeanor_override("sprint");
  self.combatmode = "no_cover";
  self.script_combatmode = "no_cover";
  self waittill("goal");
  var_4 = 750;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, var_4);
}

basement_coward() {
  self endon("death");
  self notify("behavior_reset");
  self endon("behavior_reset");
  level.basement_coward = self;
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_goal_radius(32);
  self waittill("goal");
  thread dont_shoot_player_in_the_back();
  thread coward_monitor_if_player_is_close(200);
  thread coward_monitor_if_player_shot_at();
  thread coward_monitor_if_player_look_at();
  var_0 = scripts\engine\utility::waittill_any_return("bulletwhizby", "bullethit", "player_too_close", "player_shot_at", "player_look_at", "weapon_fired");
  thread basement_footsteps("long", 0.5, "damage");
  self.escape_now = 1;

  if(isDefined(level.basement_runners)) {
    foreach(var_2 in level.basement_runners) {
      if(isDefined(var_2) && isalive(var_2))
        var_2.escape_now = 1;
    }
  }

  if(isDefined(var_0) && var_0 == "weapon_fired") {
    thread scripts\engine\sp\utility::set_ignoreall(1);
    scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::set_ignoreall, 0);
  }

  scripts\engine\sp\utility::set_goal_radius(32);
  self.target = "basement_coward_node";
  thread scripts\sp\spawner::go_to_node();
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  scripts\engine\sp\utility::set_grenadeammo(0);
  self waittill("goal");
  var_4 = 400;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, var_4);
}

miss_player_in_the_back(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_0))
    self endon(var_0);

  if(!isDefined(var_2))
    var_2 = 99999;

  if(!isDefined(var_1))
    var_1 = 128;

  while(var_2 > 0) {
    if(scripts\engine\sp\utility::player_looking_at(self getEye(), 0.8) || self hasenemybeenseen(50)) {
      break;
    }

    if(scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin) < var_1 * var_1) {
      break;
    }

    self.baseaccuracy = 0.2;
    var_2 = var_2 - 0.1;
    wait 0.1;
  }

  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::reset_baseaccuracy();
}

dont_shoot_player_in_the_back(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(var_0))
    self endon(var_0);

  if(!isDefined(var_2))
    var_2 = 99999;

  if(!isDefined(var_1))
    var_1 = 128;

  while(var_2 > 0) {
    if(scripts\engine\sp\utility::player_looking_at(self getEye(), 0.8) || self hasenemybeenseen(50)) {
      break;
    }

    if(scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin) < var_1 * var_1) {
      break;
    }

    thread scripts\engine\sp\utility::enable_dontevershoot();
    var_2 = var_2 - 0.1;
    wait 0.1;
  }

  thread scripts\engine\sp\utility::disable_dontevershoot();
  return;
}

coward_monitor_if_player_is_close(var_0) {
  self notify("coward_monitor_if_player_is_close");
  self endon("coward_monitor_if_player_is_close");
  self endon("death");

  for(;;) {
    if(distancesquared(level.player.origin, self.origin) < var_0 * var_0) {
      break;
    }

    wait 0.1;
  }

  self notify("player_too_close");
}

coward_monitor_if_player_shot_at() {
  self notify("coward_monitor_if_player_shot_at");
  self endon("coward_monitor_if_player_shot_at");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  self notify("player_shot_at");
}

coward_monitor_if_player_look_at() {
  self notify("coward_monitor_if_player_look_at");
  self endon("coward_monitor_if_player_look_at");
  self endon("death");

  for(;;) {
    if(scripts\engine\sp\utility::player_looking_at(self getEye(), 0.75)) {
      break;
    }

    wait 0.05;
  }

  self notify("player_look_at");
}

zdt_rush_guy(var_0) {
  self endon("death");
  self notify("behavior_reset");
  self endon("behavior_reset");
  self.rushing_player = 1;
  self.aggressivemode = 1;
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  wait 0.05;
  self setgoalentity(level.player, 500);
  scripts\engine\sp\utility::set_goal_radius(32);

  if(!istrue(var_0))
    self.meleechargedistvsplayer = 75;

  self.combatmode = "no_cover";
  self.script_combatmode = "no_cover";
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_grenadeammo(0);
  var_1 = 180;

  for(;;) {
    if(distancesquared(self.origin, level.player.origin) < var_1 * var_1) {
      var_2 = [];
      var_2[var_2.size] = "dx_vom_aq1_tunnels_search_210";
      var_2[var_2.size] = "dx_vom_aq1_tunnels_search_220";
      var_2[var_2.size] = "dx_vom_aq2_tunnels_search_230";
      var_2[var_2.size] = "dx_vom_aq2_tunnels_search_240";
      var_2[var_2.size] = "dx_vom_aq1_tunnels_search_250";
      thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound(scripts\engine\utility::random(var_2));
      break;
    }

    wait 0.2;
  }
}

basement_ceiling_guy() {
  var_0 = getnode("ceiling_escape_node", "targetname");
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\common\utility::demeanor_override("sprint");
  level.basement_ceiling_guy = self;
  var_1 = 150;

  if(self.script_parameters == "ceiling_guy1") {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::enemy_force_pistol();
    thread delete_basement_runner_wait_trig();
    thread basement_ceiling_ignoreme_think();
    scripts\engine\sp\utility::set_grenadeammo(2);
    var_1 = 225;
  }

  if(self.script_parameters == "ceiling_guy3") {
    self.disablepistol = 1;
    childthread ceiling_guy_warning_shots();
    thread ceiling_guy_corpse_tripwire();
    thread ceiling_guy_run_away_if_losses_player(8);
    scripts\engine\sp\utility::set_grenadeammo(0);
    var_1 = 150;
  }

  thread enemy_delay_shooting(0.75);
  self waittill("goal");
  wait 0.5;
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(32);
  thread ceiling_stance_think(var_0, var_1);
  thread scripts\engine\sp\utility::name_hide();
  self waittill("death");

  if(isDefined(self) && isDefined(self.origin)) {
    var_2 = getnodesinradius(self.origin - (0, 0, 20), 48, 0, 64);
    var_3 = undefined;

    if(isDefined(var_2) && var_2.size > 0)
      var_3 = var_2[0];

    var_4 = self gettagorigin("j_chest");

    if(!isDefined(var_4))
      var_4 = self.origin;

    var_5 = 32;

    if(isDefined(var_3) && distancesquared(var_3.origin, var_4) < var_5 * var_5) {
      if(isnodeoccupied(var_3) && isDefined(showcinematicletterboxing(var_3)) && showcinematicletterboxing(var_3) == self) {
        self.animname = "ceiling_" + strtok(self.script_parameters, "_")[1];
        self.deathanim = level.scr_anim[self.animname]["ceiling_death"];
        self.ceiling_custom_death_success = 1;
      }
    }
  }

  if(istrue(self.ceiling_custom_death_success))
    self notify("ceiling_corpse_tripwire");
  else
    self notify("ceiling_corpse_tripwire_failed");
}

ceiling_guy_warning_shots() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt("ceiling_enemy_shoot_at", "targetname");
  scripts\engine\utility::flag_wait("ceiling_warning_shots");
  wait 0.65;

  for(var_1 = 1; !self hasenemybeenseen(50) && var_1 > 0; var_1 = var_1 - var_2) {
    self shoot(1, var_0);
    var_2 = randomfloatrange(0.15, 0.25);
    wait(var_2);
  }

  wait 0.3;
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_tunnels_hunt_74", 1);
}

ceiling_infinite_ammo() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    wait 2;
    self.bulletsinclip = 30;
  }
}

ceiling_guy_run_away_if_losses_player(var_0) {
  self endon("death");
  self endon("entitydeleted");

  while(!self cansee(level.player))
    wait 0.1;

  for(;;) {
    while(self cansee(level.player))
      wait 0.1;

    var_1 = gettime();

    while(!self cansee(level.player)) {
      if(gettime() - var_1 > var_0 * 1000) {
        self.escape_now = 1;
        return;
      }

      wait 0.1;
    }

    wait 0.05;
  }
}

enemy_delay_shooting(var_0) {
  self endon("death");
  scripts\engine\sp\utility::enable_dontevershoot();

  while(!self cansee(level.player) && !self cansee(level.farah))
    wait 0.05;

  wait 0.2;
  var_1 = cos(20);

  if(!scripts\engine\sp\utility::player_looking_at(self getEye(), var_1, 1))
    wait(var_0);

  scripts\engine\sp\utility::disable_dontevershoot();
}

basement_ceiling_ignoreme_think() {
  self endon("death");
  self.ignoreme = 1;
  var_0 = self.health;

  while(isDefined(level.farah) && isalive(level.farah)) {
    if(self.health != var_0) {
      break;
    }

    if(distance2dsquared(self.origin, level.farah.origin) < 72900) {
      break;
    }

    if(distance2dsquared(self.origin, level.player.origin) < 72900) {
      break;
    }

    wait 0.25;
  }

  self.ignoreme = 0;
}

delete_basement_runner_wait_trig() {
  self waittill("death");
  var_0 = getEnt("basement_runner_trig", "targetname");

  if(isDefined(var_0))
    var_0.skipped = 1;
}

basement_ceiling_guy_flashlight() {
  scripts\sp\nvg\nvg_ai::flashlight_off();
  childthread ceiling_guy_flashlight_helper();

  for(;;) {
    self waittill("weapon_fired");
    self.last_weapon_fire_time = gettime();

    if(!istrue(self.flashlight))
      scripts\sp\nvg\nvg_ai::flashlight_on();
  }
}

ceiling_guy_flashlight_helper() {
  var_0 = 1;

  for(;;) {
    waitframe();

    if(!isDefined(self.last_weapon_fire_time)) {
      continue;
    }
    if(gettime() - self.last_weapon_fire_time > var_0 * 1000 && istrue(self.flashlight))
      scripts\sp\nvg\nvg_ai::flashlight_off();
  }
}

ceiling_guy_corpse_tripwire() {
  self endon("ceiling_corpse_tripwire_failed");
  self waittill("ceiling_corpse_tripwire");
  wait 1.25;
  var_0 = getEnt("basement_left_flank_tripwire_setoff_trig", "script_noteworthy");

  if(isDefined(var_0))
    var_0 notify("trigger", level.farah);
}

basement_guy() {
  self endon("death");
  self.reacts_to_rush = 1;
}

basement_left_flank_camper(var_0) {
  self endon("death");
  thread ai_slice_settings();
  scripts\engine\sp\utility::set_goal_radius(32);
  var_1 = 16;
  var_2 = 50;
  thread monitor_enemy_been_seen(var_2);
  var_3 = getnodearray("basement_camper_exit_to", "targetname");
  var_4 = scripts\engine\utility::getclosest(self.origin, var_3, 300);
  var_5 = undefined;

  if(isDefined(var_4)) {
    var_5 = getEnt(var_4.target, "targetname");
    thread basement_guy_wake_by_trigger(var_5);
    var_1 = 60;
  }

  thread basement_left_flank_camper_long_death_think();
  wait(var_2 / 1000 + 0.05);
  var_6 = scripts\engine\utility::waittill_any_timeout(var_1, "bullethit", "grenade danger", "damage", "enemybeenseen", "wakebytrigger");
  level notify("left_alcove_enemy");

  if(!level.player scripts\engine\trace::can_see_origin(self getEye(), 0))
    level.farah scripts\engine\utility::delaythread(0.3, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter, "dx_vom_far_basement_tunnel_combat1_40", 1, 1);

  if(istrue(var_0)) {
    var_7 = length(level.player getvelocity());
    var_8 = clamp(var_7, 60, 120);
  } else
    var_8 = 60;

  scripts\engine\utility::set_movement_speed(var_8);
  var_9 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var_9);
  scripts\engine\sp\utility::set_goal_radius(32);
  wait(var_1);
  scripts\common\ai::reset_gunpose();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::set_movement_speed(160);
}

basement_left_flank_camper_long_death_think() {
  self endon("death");
  self endon("entitydeleted");
  self.forcelongdeath = 4;
  scripts\engine\utility::flag_clear("left_flank_camper_disable_long_death");
  scripts\engine\utility::flag_wait("left_flank_camper_disable_long_death");
  scripts\engine\sp\utility::disable_long_death();
}

basement_guy_wake_by_trigger(var_0) {
  self endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  if(isDefined(var_0.script_noteworthy))
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound(var_0.script_noteworthy);

  self notify("wakebytrigger");
}

ceiling_stance_think(var_0, var_1) {
  self endon("death");

  for(;;) {
    self allowedstances("prone");

    if(isDefined(level.player) && (distance2d(level.player.origin, self.origin) < var_1 || istrue(self.escape_now))) {
      self allowedstances("crouch", "stand");
      scripts\common\utility::demeanor_override("sprint");
      scripts\engine\sp\utility::set_goal_node(var_0);
      scripts\engine\sp\utility::set_goal_radius(16);
      self waittill("goal");
      self delete();
      return;
    }

    wait 0.25;
  }
}

player_call_out_ceiling_guy_on_damage() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isDefined(var_1) || var_1 != level.player || issubstr(var_4, "MOD_GRENADE")) {
      wait 0.05;
      continue;
    }

    wait 0.25;

    if(istrue(level.zd30_ambush_nest_called_out)) {
      return;
    }
    level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::smart_dialogue_no_combat("dx_vom_alx_tunnels_hunt_72", 4, 2.5);
    level.zd30_ambush_nest_called_out = 1;
    return;
  }
}

storage_spotter() {
  self endon("death");
  level.storage_spotter = self;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.animname = "storage_spotter";
  self.allowdeath = 1;
  self.health = 10;
  var_0 = scripts\engine\utility::getStruct("storage_spotter", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0 thread scripts\common\anim::anim_first_frame_solo(self, "storage_spotter_run");

  while(!scripts\engine\sp\utility::player_looking_at(var_1.origin, 0.9) && !self hasenemybeenseen(50)) {
    if(scripts\engine\utility::flag("storage_reached")) {
      break;
    }

    wait 0.05;
  }

  var_2 = getEnt("storage_runner_trig", "targetname");
  var_2 thread scripts\engine\sp\utility::notify_delay("trigger", 0.85);
  var_0 thread scripts\common\anim::anim_single_solo(self, "storage_spotter_run");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim("storage_spotter_run"), 0.1);
  var_3 = scripts\engine\utility::getStruct("teapot_whisper", "targetname");
  var_4 = var_3.origin;
  var_5 = var_4 + anglesToForward(var_3.angles) * 160;
  scripts\engine\utility::delaythread(1, scripts\engine\utility::play_sound_in_space, "dx_vom_aq1_tunnels_search_112", var_5);
  self.ignoreall = 0;
  self.ignoreme = 0;
  var_6 = gettime();
  var_7 = getanimlength(scripts\engine\utility::getanim("storage_spotter_run"));
  thread coward_monitor_if_player_is_close(200);
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittill_any, "damage", "bulletwhizby", "bullethit", "player_too_close");
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittillmatch_any_return, "single anim", "end");
  scripts\engine\sp\utility::do_wait_any();

  if((gettime() - var_6) / 1000 < var_7 * 1000) {
    scripts\engine\sp\utility::anim_stopanimScripted();

    if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) < 40000) {
      scripts\common\utility::demeanor_override("cqb");
      scripts\engine\sp\utility::set_favoriteenemy(level.player);
      self cleargoalvolume();
      self setgoalentity(level.player, 500);
      scripts\engine\sp\utility::set_goal_radius(128);
      scripts\engine\sp\utility::set_battlechatter(1);
      return;
    }
  }

  var_8 = getnode("storage_spotter_goto", "targetname");
  scripts\engine\sp\utility::set_goal_pos(var_8.origin);
  scripts\engine\sp\utility::set_goal_radius(32);
  wait 0.05;
  thread storage_runner(0);
}

storage_runner(var_0) {
  self endon("death");

  if(!isDefined(level.storage_runners))
    level.storage_runners = [];

  level.storage_runners[level.storage_runners.size] = self;
  self.storage_runner = 1;
  scripts\common\utility::demeanor_override("sprint");
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread coward_monitor_if_player_is_close(200);
  thread coward_monitor_if_player_shot_at();

  if(!isDefined(var_0) || var_0)
    thread basement_footsteps("long", 2.35, "runner_awaken");

  var_1 = scripts\engine\utility::waittill_any_return("goal", "bulletwhizby", "bullethit", "grenade danger", "player_too_close", "player_shot_at");
  self notify("runner_awaken");
  self.ignoreall = 0;
  self.ignoreme = 0;

  if(!istrue(self.cleared_storage) && isDefined(var_1) && (var_1 == "player_shot_at" || var_1 == "bullethit" || var_1 == "player_too_close" || var_1 == "bulletwhizby")) {
    scripts\common\utility::clear_demeanor_override();
    scripts\common\utility::demeanor_override("cqb");
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    self cleargoalvolume();
    self setgoalentity(level.player, 500);
    scripts\engine\sp\utility::set_goal_radius(128);
    self.going_to_player = 1;
    wait 2;

    if(!istrue(level.storage_runners_woke)) {
      level.storage_runners_woke = 1;
      scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound("dx_vom_aq2_tunnels_ambusher_20");
      wait 2;
      scripts\engine\sp\utility::set_battlechatter(1);
    }

    return;
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 500);
}

storage_ambusher_prep() {
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::enemy_force_ak47_bright_muzzleflash();
  scripts\engine\sp\utility::set_goal_radius(32);
  self allowedstances("crouch");
  scripts\engine\sp\utility::enable_dontevershoot();
  self.ignoreall = 1;
  self.ignoreme = 1;
}

storage_ambusher_attack() {
  self allowedstances("stand", "crouch", "prone");
  scripts\engine\sp\utility::disable_dontevershoot();
  self.ignoreall = 0;
  self.ignoreme = 0;
}

storage_ambush_runner() {
  self endon("death");
  self endon("entitydeleted");
  level.storage_ambush_runner = self;
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\common\utility::demeanor_override("sprint");
  scripts\common\ai::disable_arrivals();
  self waittill("goal");
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(16);
  self.ignoreall = 1;
  self.ignoreme = 1;
  var_0 = scripts\engine\utility::waittill_any_return("run_now", "bulletwhizby", "bullethit", "grenade danger", "damage");

  if(!isDefined(var_0) || var_0 != "run_now") {
    self.ignoreall = 0;
    self.ignoreme = 0;
  }

  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  var_1 = getnode("storage_room_2_goto_delete_node", "targetname");
  scripts\engine\sp\utility::set_goal_pos(var_1.origin);
  thread basement_footsteps("long", 0.5);
  self waittill("goal");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 300);
}

storage_ambusher() {
  self endon("death");
  scripts\engine\utility::ent_flag_init("advance");
  scripts\engine\sp\utility::set_grenadeammo(0);

  if(isDefined(self.script_parameters) && self.script_parameters == "left_guy")
    level.storage_ambusher_left_guy = self;

  if(isDefined(self.script_parameters) && self.script_parameters == "coward") {
    wait 2;
    self delete();
  } else {
    storage_ambusher_prep();
    level scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "storage_ambush");
    level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_ambush_failsafe");
    level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
    scripts\engine\sp\utility::do_wait_any();
    wait 1.5;
    thread storage_ambusher_fake_shoot("end_fake_shoot");
    storage_ambusher_attack();
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::set_original_baseaccuracy(0.35);
    storage_ambusher_advance_watch(2, 0.5);
    self notify("end_fake_shoot");

    if(isDefined(self.script_parameters) && self.script_parameters == "left_guy")
      storage_ambusher_advance();
    else {
      self getenemyinfo(level.player);

      if(scripts\engine\utility::flag("storage_room_2_entered")) {
        scripts\engine\sp\utility::set_goal_radius(200);
        wait 2;
        var_0 = getEnt("storage_flank_weapon_watch", "targetname");

        while(level.player istouching(var_0))
          wait 0.25;

        wait(randomintrange(4, 10));
        zdt_rush_guy();
        return;
      }

      var_1 = randomintrange(8, 12);
      scripts\engine\utility::flag_wait_or_timeout("storage_room_2_entered", var_1);
      self setgoalentity(level.player, 50);
      scripts\engine\sp\utility::set_goal_radius(128);
    }
  }
}

storage_ambusher_advance_watch(var_0, var_1) {
  self endon("death");
  wait(var_0);
  var_2 = scripts\engine\utility::getStruct("storage_ambush_advance_look_at", "targetname").origin;

  for(;;) {
    while(!scripts\engine\sp\utility::player_looking_at(var_2)) {
      if(scripts\engine\utility::flag("storage_room_2_entered") || scripts\engine\utility::flag("storage_flank_weapon_fired")) {
        break;
      }

      wait 0.05;
    }

    var_3 = 0;

    while(scripts\engine\sp\utility::player_looking_at(var_2)) {
      if(scripts\engine\utility::flag("storage_room_2_entered") || scripts\engine\utility::flag("storage_flank_weapon_fired")) {
        break;
      }

      var_3 = var_3 + 0.05;
      wait 0.05;

      if(var_3 >= var_1) {
        scripts\engine\utility::ent_flag_set("advance");
        return;
      }
    }

    if(scripts\engine\utility::flag("storage_room_2_entered") || scripts\engine\utility::flag("storage_flank_weapon_fired")) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::ent_flag_set("advance");
}

storage_ambusher_advance() {
  ai_slice_settings();
  scripts\engine\utility::set_movement_speed(60);
  self setgoalentity(level.player, 50);
  scripts\engine\sp\utility::set_goal_radius(32);
  wait 4.5;
  scripts\engine\utility::set_cautious_navigation(0);
  scripts\common\ai::reset_gunpose();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::set_movement_speed(160);
}

storage_ambusher_blind_fire() {
  self endon("death");
  level.storage_ambusher_blind_fire_guy = self;
  scripts\engine\utility::ent_flag_init("advance");
  storage_ambusher_prep();
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\utility::ent_flag_init("blind_fire_start");
  self actoraimassistoff();
  self.allowdeath = 1;
  thread storage_ambusher_blind_fire_anim("storage_ambusher", "blind_fire_right", 2, 4);
  waitframe();
  level scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "storage_ambush");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_ambush_failsafe");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
  scripts\engine\sp\utility::do_wait_any();
  wait 1;
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::set_original_baseaccuracy(0.35);
  scripts\engine\utility::ent_flag_set("blind_fire_start");
  storage_ambusher_attack();
  thread storage_ambusher_advance_watch(2, 0.5);

  if(isDefined(level.storage_ambusher_left_guy) && isalive(level.storage_ambusher_left_guy))
    level.storage_ambusher_left_guy scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "death");

  scripts\engine\sp\utility::add_wait(scripts\engine\utility::ent_flag_wait, "advance");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_room_2_entered");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
  scripts\engine\sp\utility::do_wait_any();
  self notify("blind_fire_right_stop_all");
  self notify("blind_fire_right_stop_idle");
  waitframe();
  self stopanimScripted();

  if(scripts\engine\utility::ent_flag("advance"))
    storage_ambusher_advance();
  else {
    self actoraimassiston();
    self getenemyinfo(level.player);
    scripts\engine\sp\utility::set_goal_radius(256);

    if(scripts\engine\utility::flag("storage_flank_weapon_fired"))
      wait 8;

    var_0 = getEnt("storage_flank_weapon_watch", "targetname");

    while(level.player istouching(var_0))
      wait 1;

    zdt_rush_guy();
  }
}

storage_ambusher_blind_fire_anim(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("entitydeleted");
  self endon(var_1 + "_stop_all");
  thread god_until_damage_by_player();

  if(!isDefined(var_2))
    var_2 = 5.0;

  if(!isDefined(var_3))
    var_3 = 8.0;

  self.animname = var_0;
  var_4 = scripts\engine\utility::getStruct(var_1, "targetname");

  for(;;) {
    var_5 = randomfloatrange(var_2, var_3);
    var_4 thread scripts\common\anim::anim_loop_solo(self, var_1 + "_idle", var_1 + "_stop_idle");
    wait(var_5);
    scripts\engine\utility::ent_flag_wait("blind_fire_start");
    var_4 notify(var_1 + "_stop_idle");
    var_4 scripts\common\anim::anim_single_solo(self, var_1);
  }
}

god_until_damage_by_player() {
  scripts\common\ai::magic_bullet_shield();
  thread player_shot_monitor();
  scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "shot_by_player");
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::ent_flag_wait, "blind_fire_start");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_player_flanking");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_room_2_entered");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
  scripts\engine\sp\utility::do_wait_any();
  scripts\common\ai::stop_magic_bullet_shield();
}

player_shot_monitor() {
  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      self notify("shot_by_player");
      return;
    }
  }
}

storage_ambusher_fake_shoot(var_0) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var_0))
    self endon(var_0);

  var_1 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("storage_ambusher_fake_shoot_at", "targetname")).origin;
  var_2 = spawn("script_origin", var_1);
  thread shoot_at_ent_delete_on_flag(var_2, var_0);

  for(;;) {
    if(!storage_ambusher_fake_can_shoot(var_0)) {
      self clearentitytarget();
      scripts\engine\sp\utility::set_favoriteenemy(level.player);
      wait 0.05;

      while(!storage_ambusher_fake_can_shoot(var_0))
        wait 0.2;
    }

    var_2.origin = get_random_pos(var_1, 0, 32);
    wait 0.05;

    if(!isDefined(var_2)) {
      return;
    }
    self setentitytarget(var_2, 1);
    wait(randomfloatrange(0.1, 0.2));
  }
}

shoot_at_ent_delete_on_flag(var_0, var_1) {
  self waittill(var_1);
  waitframe();

  if(isDefined(self) && isalive(self)) {
    self clearentitytarget();
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
  }

  var_0 delete();
}

get_random_pos(var_0, var_1, var_2) {
  var_3 = randomintrange(var_1, var_2);
  var_4 = self.origin - var_0;
  var_5 = anglestoleft(vectortoangles(var_4)) * var_3;
  var_6 = anglestoright(vectortoangles(var_4)) * var_3;
  var_7 = var_6;

  if(scripts\engine\utility::cointoss())
    var_7 = var_5;

  return var_0 + var_7;
}

storage_ambusher_fake_can_shoot(var_0) {
  var_1 = length2d(level.player.origin, self.origin);

  if(var_1 < 128)
    self notify(var_0);

  if(!self cansee(level.player) && var_1 > 128)
    return 1;

  return 0;
}

storage_advancer_mg_aware() {
  self endon("death");
  var_0 = undefined;

  if(isDefined(self.target))
    var_0 = getnode(self.target, "targetname");

  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  scripts\engine\sp\utility::set_goal_radius(32);

  if(isDefined(var_0))
    scripts\engine\sp\utility::set_goal_node(var_0);
  else {
    var_1 = getEnt("storage_room_3", "targetname");
    self setgoalvolume(var_1);
  }

  while(isDefined(level.storage_mg_guy) && isalive(level.storage_mg_guy))
    wait 0.2;

  var_2 = randomintrange(128, 256);
  self setgoalentity(level.player, 1000);
  scripts\engine\sp\utility::set_goal_radius(var_2);
}

storage_advancer() {
  self endon("death");
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  thread storage_advance_now();
  level endon("storage_advance_now");

  while(!self hasenemybeenseen(1000)) {
    wait 0.05;

    if(scripts\engine\utility::flag("in_storage_mg_nest")) {
      if(scripts\engine\sp\utility::player_looking_at(self.origin, 0.75) && scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin) < 160000)
        thread zdt_rush_guy();
      else {
        scripts\engine\sp\utility::set_goal_pos(getnode("lmg_node", "targetname").origin);
        wait 0.25;
        thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 700);
      }

      return;
    }
  }

  level notify("storage_advance_now");
}

storage_advance_now() {
  self endon("death");
  self endon("entitydeleted");
  level waittill("storage_advance_now");
  var_0 = getEnt("storage_room_2c", "targetname");
  var_1 = getEnt("storage_room_3", "targetname");
  wait(randomint(6));

  if(!level.player istouching(var_1)) {
    self cleargoalvolume();
    self setgoalvolumeauto(var_0);
    self waittill("goal");
    wait 8;
  }

  var_2 = randomintrange(128, 256);
  self setgoalentity(level.player, 1000);
  scripts\engine\sp\utility::set_goal_radius(var_2);
}

flashbang_immunity(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 3.5;

  self.flashbangimmunity = 1;

  if(isDefined(var_1))
    level scripts\engine\utility::waittill_any_timeout(var_0, var_1);
  else
    wait(var_0);

  self.flashbangimmunity = undefined;
}

storage_lmg_guy() {
  self endon("death");
  self endon("entitydeleted");
  level.storage_lmg = self;
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(32);
  self allowedstances("crouch");
  self.ignoreall = 1;
  self.ignoreme = 1;
  scripts\engine\utility::flag_wait("storage_final_room_reached");
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::set_original_baseaccuracy(0.5);
  self allowedstances("stand", "crouch");
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var_0 = getnode("lmg_node", "targetname");
  scripts\engine\sp\utility::set_goal_node(var_0);
  scripts\engine\utility::waittill_any_timeout(1, "damage", "goal");
  self.ignoreall = 0;
  self.ignoreme = 0;
}

set_off_storage_propane_tanks() {
  var_0 = getEnt("storage_lmg_danger_zone", "targetname");

  if(level.player istouching(var_0)) {
    return;
  }
  if(isDefined(level.storage_3rd_room_propanes)) {
    foreach(var_2 in level.storage_3rd_room_propanes) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_2 setscriptablepartstate("base", "fire");
    }
  }
}

storage_lmg_room_guy() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_grenadeammo(0);
}

storage_lmg_camper() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\sp\utility::set_goal_radius(32);
  self waittill("goal");
  thread screams_when_seeing_enemy();

  while(!self hasenemybeenseen(500))
    wait 0.25;

  wait 2;
  var_0 = getnode("storage_mg_crawl_node", "targetname");
  scripts\engine\sp\utility::set_goal_pos(var_0.origin);
  wait 3;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 700);
}

screams_when_seeing_enemy() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    if(self cansee(level.player) && isDefined(self.enemy) && self.enemy == level.player) {
      break;
    }

    wait 0.1;
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound("dx_vom_aq2_tunnels_ambusher_20");
}

monitor_enemy_been_seen(var_0, var_1, var_2) {
  self endon("death");
  self notify("enemybeenseen_monitoring");
  self endon("enemybeenseen_monitoring");

  if(!isDefined(var_1) || var_1)
    thread can_player_see_any_part_of_enemy();

  for(;;) {
    while(!self hasenemybeenseen(var_0))
      wait 0.05;

    if(isDefined(var_2)) {
      var_3 = 0;

      while(self hasenemybeenseen(var_0)) {
        var_3 = var_3 + 0.05;
        wait 0.05;

        if(var_3 > var_2) {
          break;
        }
      }

      if(var_3 < var_2)
        continue;
    }

    self notify("enemybeenseen");
    wait 0.1;
  }
}

can_player_see_any_part_of_enemy() {
  self endon("death");

  for(;;) {
    var_0 = anglesToForward(level.player getplayerangles());
    var_1 = level.player getEye();
    var_2 = var_1 + var_0 * 1500;

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_knee_le"), 2, 4))
      self notify("enemybeenseen");

    wait 0.05;

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_knee_ri"), 2, 4))
      self notify("enemybeenseen");

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_elbow_le"), 2, 4))
      self notify("enemybeenseen");

    wait 0.05;

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_elbow_ri"), 2, 4))
      self notify("enemybeenseen");

    wait 0.05;
  }
}

storage_mg_nest_first_guy() {
  self endon("death");
  self.ignoreme = 1;
  thread ai_slice_settings();
  scripts\engine\utility::set_movement_speed(160);
  var_0 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var_0);
  scripts\engine\sp\utility::set_goal_radius(64);

  while(!scripts\engine\sp\utility::player_looking_at(self getEye())) {
    wait 0.05;
    var_1 = 200;

    if(isDefined(level.farah) && isalive(level.farah) && scripts\engine\utility::distance_2d_squared(level.farah.origin, self.origin) < var_1 * var_1) {
      break;
    }
  }

  self.ignoreme = 0;
}

mine_responder() {
  self endon("death");
  scripts\engine\sp\utility::set_goal_radius(32);
  thread battlechatter_off_spawn_func();

  while(!self hasenemybeenseen(2000))
    wait 0.25;

  wait 0.5;

  if(!istrue(level.mine_responder_calling_out)) {
    level.mine_responder_calling_out = 1;
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound("dx_cbc_aq3_command_attack");
  }

  scripts\engine\sp\utility::set_battlechatter(1);
}

mine_patroller() {
  self endon("death");
  self endon("stealth_combat");

  if(!isDefined(self.stealth) || !isDefined(self.script_stealthgroup) || self.script_stealthgroup != "shaft_patrol_water") {
    return;
  }
  scripts\engine\sp\utility::set_battlechatter(0);

  if(!scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_has_pistol())
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::enemy_force_pistol();

  var_0 = scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::get_active_oil_fires();

  if(isDefined(var_0) && var_0.size > 0) {
    var_1 = sortbydistance(var_0, self.origin)[0];
    thread investigate_oil_fire(var_1);
  }

  wait 0.1;
  scripts\sp\nvg\nvg_ai::flashlight_on();
}

investigate_oil_fire(var_0, var_1) {
  self notify("investigating_oil_fire");
  self endon("investigating_oil_fire");
  self endon("death");
  self endon("stealth_combat");
  var_0 endon("oil_fire_out");
  var_2 = 35;

  for(var_3 = 6; var_2 > 0; var_2 = var_2 - var_3) {
    if(isDefined(var_1))
      var_4 = var_1.origin;
    else
      var_4 = scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::get_investigate_point_in_oil_fire(var_0);

    self aieventlistenerevent("investigate", level.player, var_4);
    wait(var_3);
  }
}

shaft_propane_toss_guy() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = 50;
  thread monitor_enemy_been_seen(var_0);
  thread shaft_top_ladder_escaper_wakeup();
  scripts\engine\utility::waittill_any("goal", "enemybeenseen");
  var_1 = scripts\engine\utility::waittill_any_return("bullethit", "bulletwhizby", "enemybeenseen", "wakeup");
  scripts\engine\utility::flag_set("shaft_propane_toss");
  var_2 = getnode("shaft_top_ladder_escaper_node", "targetname");
  scripts\engine\sp\utility::set_goal_node(var_2);
  scripts\engine\sp\utility::set_goal_radius(48);
  wait 8;
  self setgoalentity(level.player, 50);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\engine\sp\utility::set_goal_radius(100);
}

detonate_after_time(var_0) {
  wait(var_0);
  radiusdamage(self.origin, 10, 100, 99);
  waitframe();
  level.player playRumbleOnEntity("light_1s");
}

get_anim_frac_from_time(var_0, var_1) {
  var_2 = getanimlength(scripts\engine\utility::getanim(var_0));
  return var_1 / var_2;
}

shaft_propane_from_model_and_set_state(var_0, var_1) {
  self waittillmatch("single anim", "end");
  var_2 = getscriptablearray(var_0, "targetname")[0];
  var_2.origin = self.origin;
  var_2.angles = self.angles;
  var_2 setscriptablepartstate("base", "fire");
  self delete();
}

shaft_propane_kick_guy() {
  self endon("death");
  self endon("entitydeleted");
  scripts\common\utility::demeanor_override("sprint");
  var_0 = getEnt("shaft_propane_kick_trig", "targetname");
  var_0 waittill("trigger");

  if(!scripts\engine\utility::flag("shaft_propane_kick_detonated")) {
    shaft_propane_kick_anim();

    if(scripts\engine\utility::flag("shaft_propane_kick_detonated"))
      self stopanimScripted();
  }

  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\engine\sp\utility::set_goal_radius(100);
  var_1 = getnode("shaft_propane_kick_node", "script_noteworthy");
  scripts\engine\sp\utility::set_goal_node(var_1);

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(self.origin, var_1.origin) > 1024) {
      self.deathanim = undefined;
      return;
    }

    wait 0.05;
  }
}

shaft_propane_kick_anim() {
  self endon("death");
  self endon("is_burning");
  thread shaft_propane_kick_cancel_if_burning_or_hurt();
  var_0 = 1.33;
  self.allowdeath = 1;
  self.animname = "shaft_propane_kick_guy";
  var_1 = scripts\engine\utility::getStruct("propane_kick", "targetname");
  self.deathanim = level.scr_anim[self.animname]["falling_death"];
  var_2 = getscriptablearray("shaft_propane_kick_scriptable", "targetname")[0];
  var_2.animname = "shaft_propane_kick";
  var_2 scripts\engine\sp\utility::assign_animtree();
  var_2 thread propane_reset_position(var_1);
  scripts\engine\utility::flag_set("shaft_propane_kicked");
  var_1 thread scripts\common\anim::anim_single_solo(self, "propane_kick");
  var_1 thread scripts\sp\anim::anim_set_rate([self, var_2], "propane_kick", var_0);
  level.player scripts\engine\utility::delaycall(0.6, ::playrumbleonentity, "heavy_1s");
  var_2 thread shaft_propane_state_change("shaft_propane_kick_detonated", 3);
  var_1 thread anim_single_solo_scriptable(var_2, "propane_kick");
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittillmatch_any_return, "single anim", "end");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "shaft_propane_kick_detonated");
  scripts\engine\sp\utility::do_wait_any();

  if(scripts\engine\utility::flag("shaft_propane_kick_detonated"))
    var_2 stopanimScripted();
}

propane_reset_position(var_0) {
  self endon("death");
  self endon("entitydeleted");
  wait 0.5;
  var_1 = getstartorigin(var_0.origin, var_0.angles, scripts\engine\utility::getanim("propane_kick"));
  var_2 = getstartangles(var_0.origin, var_0.angles, scripts\engine\utility::getanim("propane_kick"));
  self.origin = var_1;
  self.angles = var_2;
}

shaft_propane_kick_cancel_if_burning_or_hurt() {
  self endon("death");

  for(;;) {
    if(istrue(self._blackboard.isburning)) {
      self notify("is_burning");
      return;
    }

    wait 0.1;
  }
}

shaft_propane_state_change(var_0, var_1) {
  level endon(var_0);

  if(isDefined(var_1))
    wait(var_1);

  self setscriptablepartstate("base", "no_col");

  if(isDefined(self))
    self setscriptablepartstate("base", "fire");
}

anim_single_solo_scriptable(var_0, var_1, var_2, var_3) {
  thread scripts\common\notetrack::start_notetrack_wait(var_0, "single anim", var_1, var_0.animname, var_0 scripts\engine\utility::getanim(var_1));
  thread scripts\sp\anim::animscriptdonotetracksthread(var_0, "single anim", var_1);

  if(isDefined(var_2) && isDefined(var_3))
    var_0 setflaggedanim("single anim", var_0 scripts\engine\utility::getanim(var_1), 1, var_2, var_3);
  else
    var_0 setflaggedanim("single anim", var_0 scripts\engine\utility::getanim(var_1));
}

shaft_top_ladder_escaper() {
  self endon("death");
  self.ignoreall = 1;
  scripts\engine\sp\utility::disable_surprise();
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\common\utility::demeanor_override("sprint");
  self waittill("goal");
  var_0 = getnode("shaft_top_ladder_escaper_node", "targetname");
  scripts\engine\sp\utility::set_goal_node(var_0);
  scripts\engine\sp\utility::set_goal_radius(32);
  var_1 = 50;
  thread monitor_enemy_been_seen(var_1);
  thread shaft_top_ladder_escaper_wakeup();
  scripts\engine\utility::waittill_any("goal", "enemybeenseen");
  var_2 = scripts\engine\utility::waittill_any_return("bullethit", "bulletwhizby", "enemybeenseen", "wakeup");

  if(isDefined(var_2) && (var_2 == "enemybeenseen" || var_2 == "wakeup"))
    self.ignoreall = 1;
  else
    self.ignoreall = 0;

  var_0 = getnode("despawn_node", "script_noteworthy");
  scripts\engine\sp\utility::set_goal_node(var_0);
  var_2 = scripts\engine\utility::waittill_any_return("bullethit", "grenade danger", "bulletwhizby");
  self.ignoreall = 0;
}

shaft_top_ladder_escaper_wakeup() {
  self endon("death");

  for(;;) {
    if(scripts\engine\sp\utility::player_looking_at(self getEye(), 0.7, 1)) {
      break;
    }

    if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) < 40000) {
      break;
    }

    wait 0.05;
  }

  self notify("wakeup");
}

shaft_fall_victim() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = getEnt("shaft_fall_victim_touching", "targetname");
  self waittill("goal");
  wait 1;

  if(!self istouching(var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::getStruct("shaft_fall_victim_propane", "targetname");
  var_2 = getclosestpointonnavmesh(var_1.origin);
  var_3 = getscriptablearray("shaft_fall_victim_propane_scriptable", "targetname")[0];

  if(!isDefined(var_3) || !isDefined(var_3.model) || var_3.model == "") {
    wait 1;

    while(scripts\engine\sp\utility::player_looking_at(self.origin, 0.7, 1))
      wait 0.05;

    thread shaft_fall_victim_burn();
    return;
  }

  var_4 = var_3.model;
  var_3 setscriptablepartstate("base", "script_ignite", 1);
  scripts\engine\sp\utility::set_goal_pos(var_2);
  scripts\engine\sp\utility::set_goal_radius(64);
  scripts\engine\utility::waittill_any_timeout(1.75, "goal");

  while(var_3.model != "")
    wait 0.05;

  thread shaft_fall_victim_burn();
}

shaft_fall_victim_burn() {
  ai_detachall();
  thread scripts\asm\soldier\death::handleburndeathmodelswap();
  thread scripts\asm\soldier\death::handleburndeathvfx();
  waitframe();
  scripts\sp\utility::do_damage(self.health + 9999, self.origin, level.player, level.player, "MOD_FIRE", "molotov");
}

ai_detachall() {
  self detachall();
  self.headmodel = undefined;
  self.hatmodel = undefined;
}

shaft_wave_1_guy_fire_aware() {
  self endon("death");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::enemy_force_ak47();
  self.spawn_time = gettime();
  var_0 = get_touching_goal_vol();

  if(!isDefined(var_0))
    var_0 = level.shaft_vols[1];

  set_new_goal_vol(var_0);
  wait 0.05;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::set_original_baseaccuracy(1);

  while(!isDefined(level.player.cur_shaft_level_index) || level.player.cur_shaft_level_index < 2)
    wait 1;

  thread fire_aware();
}

shaft_wave_1_guys_management() {
  while(!isDefined(level.mine_carts) || !isDefined(level.mine_carts["mine_cart"]))
    wait 0.25;

  level.mine_carts["mine_cart"] waittill("pushed");

  for(;;) {
    wait 0.5;
    var_0 = get_alive_wave_1_guys();

    if(var_0.size == 0) {
      continue;
    }
    var_1 = 0;

    foreach(var_3 in var_0) {
      var_4 = var_3 getgoalvolume();

      if(!isDefined(var_4) || var_4 != level.shaft_vols[1])
        var_1++;
    }

    if(var_1 == 0) {
      var_6 = var_0[0];
      var_6 cleargoalvolume();
      var_6 setgoalentity(level.player);
      var_6 scripts\engine\sp\utility::set_goal_radius(500);
      var_6 waittill("death");
      wait(randomintrange(30, 45));
    }
  }
}

get_alive_wave_1_guys() {
  var_0 = [];
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(isalive(var_3) && isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "shaft_wave_1")
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

shaft_chaser_fire_aware(var_0) {
  self endon("death");
  wait 0.05;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::set_original_baseaccuracy(1);

  if(isDefined(var_0))
    self.goalradius = var_0;
  else
    self.goalradius = 64;

  for(;;) {
    if(isDefined(level.shaft_fire_on_level) && isDefined(level.player.cur_shaft_level_index) && level.shaft_fire_on_level >= level.player.cur_shaft_level_index) {
      var_1 = int(min(level.shaft_vols.size - 1, level.shaft_fire_on_level + 1));
      set_new_goal_vol(level.shaft_vols[var_1]);
    } else
      self setgoalpos(level.player.origin);

    wait 0.05;
  }
}

shaft_follower() {
  self endon("death");
  thread fire_aware("go_for_player");

  for(;;) {
    var_0 = isDefined(self.enemy) && self.enemy == level.player;
    var_1 = self hasenemybeenseen(500);
    var_2 = scripts\engine\sp\utility::player_looking_at(self getEye(), 0.7);

    if(var_0 && var_1) {
      break;
    }

    wait 0.2;
  }

  wait 1.75;
  self notify("go_for_player");
  zdt_rush_guy();
}

fire_aware(var_0) {
  self endon("death");

  if(isDefined(var_0))
    self endon(var_0);

  var_1 = get_touching_goal_vol();

  if(isDefined(var_1) && !isDefined(self.target))
    set_new_goal_vol(var_1);

  while(!isDefined(level.shaft_fire_on_level))
    wait 1;

  for(;;) {
    var_2 = get_touching_goal_vol_index();
    var_1 = get_touching_goal_vol();

    if(level.shaft_fire_on_level >= var_2) {
      if(isDefined(level.player.cur_shaft_level_index) && level.player.cur_shaft_level_index > var_2) {
        var_3 = getnodesinradius(self.origin, 512, 0, 96);

        if(isDefined(var_3) && var_3.size > 0) {
          var_4 = sortbydistance(var_3, self.origin)[0];
          self setgoalnode(var_4);
          scripts\engine\utility::waittill_any_timeout(4, "goal");
        } else {
          scripts\engine\sp\utility::set_goal_pos(self.origin);
          wait 0.5;
        }

        if(isDefined(var_1) && isDefined(var_1.targetname)) {
          var_5 = scripts\engine\utility::getStruct(var_1.targetname, "script_noteworthy");

          if(isDefined(var_5))
            scripts\engine\sp\utility::set_goal_pos(var_5.origin);
        }

        scripts\engine\sp\utility::set_goal_radius(32);
        scripts\engine\utility::waittill_any_timeout(5, "goal");
        enemy_death_by_fire(0);
        return;
      } else {
        var_6 = int(min(level.shaft_vols.size - 1, level.shaft_fire_on_level + 1));
        set_new_goal_vol(level.shaft_vols[var_6]);
      }
    }

    wait 2;
  }
}

set_new_goal_vol(var_0) {
  self endon("death");
  self cleargoalvolume();
  self setgoalpos(self.origin);
  waitframe();
  self setgoalvolumeauto(var_0);
}

get_touching_goal_vol() {
  foreach(var_2, var_1 in level.shaft_vols) {
    if(self istouching(var_1))
      return var_1;
  }

  return undefined;
}

get_touching_goal_vol_index() {
  var_0 = undefined;

  foreach(var_3, var_2 in level.shaft_vols) {
    if(self istouching(var_2))
      var_0 = var_3;
  }

  if(!isDefined(var_0)) {
    var_4 = scripts\engine\utility::getclosest(self.origin, level.shaft_vols);

    foreach(var_3, var_6 in level.shaft_vols) {
      if(isDefined(var_6) && var_6 == var_4)
        var_0 = var_3;
    }
  }

  return var_0;
}