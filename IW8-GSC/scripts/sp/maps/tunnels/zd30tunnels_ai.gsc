/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\zd30tunnels_ai.gsc
******************************************************/

function init_spawnfunctions() {}

function tunnels_spawnfunctions() {
  scripts\engine\sp\utility::add_global_spawn_function("axis", &tunnels_combat);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &tunnels_flashlight_management);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &tunnels_shotgun_guy_accuracy_management);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &tunnels_door_guy_fire_aware);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &tunnels_shaft_molotov_giveth);
  thread basement_player_rush_handler();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_ceiling_guy", &basement_ceiling_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("first_cell_guy", &basement_first_cell_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("right_flank_runner", &basement_right_flank_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("right_flank_surprise", &basement_right_flank_surprise);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_door_surprise", &basement_door_surprise_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_runner", &basement_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_coward", &basement_coward);
  scripts\engine\sp\utility::array_spawn_function_targetname("basement_sneak_1_spawner", &basement_sneak_1_animated);
  scripts\engine\sp\utility::array_spawn_function_targetname("basement_sneak_1_backup_spawner", &basement_sneak_1_backup);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("basement_final_guy", &basement_final_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_spotter", &storage_spotter);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_runner", &storage_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_ambusher", &storage_ambusher);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_ambush_runner", &storage_ambush_runner);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_ambusher_blind_fire", &storage_ambusher_blind_fire);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_lmg_camper", &storage_lmg_camper);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_lmg_room_guy", &storage_lmg_room_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_advancer", &storage_advancer_mg_aware);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("storage_lmg_guy", &storage_lmg_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("first_storage_MG_nest_guy", &storage_mg_nest_first_guy);
  scripts\engine\utility::array_thread(getEntArray("shaft_enemy_kill_trigger", "targetname"), &enemy_death_by_fire_think);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_wave_1", &shaft_wave_1_guy_fire_aware);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_chaser", &shaft_chaser_fire_aware);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_follower", &shaft_follower);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_propane_kick_guy", &shaft_propane_kick_guy);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("shaft_fall_victim", &shaft_fall_victim);
  var0 = getEnt("basement_runner_spawner_trig", "targetname");
  var0 scripts\engine\utility::trigger_off();
}

function friendly_nvg_setup() {
  if(!issubstr(self.headmodel, "_nvg") && (!isDefined(self.hatmodel) || !issubstr(self.hatmodel, "_nvg"))) {
    return;
  }

  if(isDefined(self.hatmodel)) {
    self.nvgmodel_off = self.hatmodel;
  } else {
    self.nvgmodel_off = self.headmodel;
  }

  if(isDefined(self.animname) && self.animname == "price") {
    self.nvgmodel_on = scripts\engine\sp\utility::getmodel("price_nvgs_on");
    return;
  }

  self.nvgmodel_on = scripts\engine\sp\utility::getmodel("generic_nvgs_on");
}

function tunnels_shotgun_guy_accuracy_management() {
  self endon("death");
  self endon("entitydeleted");

  if(!issubstr(self.classname, "_shotgun")) {
    return;
  }

  thread tunnels_shotgun_guy_accuracy_debug();
  thread tunnels_shotgun_guy_monitor_weapon_fire();
  wait 0.1;
  var0 = 10;

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
    scripts\sp\maps\tunnels\zd30tunnels_utility::reset_baseaccuracy();
    self.shotgun_rest = 0;

    while(gettime() - self.last_weapon_fire_time < var0 * 1000) {
      wait 0.1;
    }
  }
}

function tunnels_shotgun_guy_accuracy_debug() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    self waittill("weapon_fired");
  }
}

function tunnels_shotgun_guy_monitor_weapon_fire() {
  self endon("death");
  self endon("entitydeleted");
  self.last_weapon_fire_time = gettime();

  for(;;) {
    self waittill("weapon_fired");
    self.last_weapon_fire_time = gettime();
    wait 0.05;
  }
}

function enemy_death_by_fire_think() {
  self endon("entitydeleted");
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);
    thread enemy_death_by_fire(var0);
    wait 0.05;
  }
}

function enemy_death_by_fire(var0) {
  self endon("death");
  var1 = 256;

  if(istrue(var0)) {
    if(isDefined(self) && isai(self) && isalive(self) && !isDefined(self._blackboard.isburning)) {
      var2 = distance(level.player.origin, self.origin);

      if(var2 > var1) {
        thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_burn_death_scream();
        thread scripts\sp\equipment\molotov::molotovburnenemy(self, 1, self.origin + (0, 0, 8), level.player);
        return;
      }

      return;
    }

    return;
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_burn_death_scream();
  thread scripts\sp\equipment\molotov::molotovburnenemy(self, 1, self.origin + (0, 0, 8), level.player);
}

function basement_player_rush_handler() {
  scripts\engine\utility::flag_init("player_rushing_in_basement");
  scripts\engine\utility::array_thread(getEntArray("basement_rush_trig", "targetname"), &player_rush_think);
}

function player_rush_think() {
  self endon("entitydeleted");
  var0 = self;
  var1 = getEnt(self.target, "targetname");
  var2 = getEnt(var1.target, "targetname");
  var3 = float(self.script_noteworthy);
  var0 waittill("trigger");
  var4 = gettime();
  var1 waittill("trigger");

  if(gettime() - var4 < var3 * 1000) {
    return;
  }

  scripts\engine\utility::flag_set("player_rushing_in_basement");
  var5 = getaiarray("axis");
  var6 = 0;

  foreach(var8 in var5) {
    if(isalive(var8) && var8 istouching(var2) && istrue(var8.reacts_to_rush)) {
      thread zdt_rush_guy();
      var6++;
    }
  }
}

function tunnels_combat() {
  self.spawn_time = gettime();

  if(scripts\engine\utility::flag("wolf_killed") || !scripts\sp\starts::is_after_start("downstairs")) {
    self.noarmor = 1;
    return;
  }

  if(isDefined(self.targetname) && self.targetname == "first_blast") {
    var0 = 0.75;
  } else {
    var0 = 1.5;
  }

  self.original_baseaccuracy = var0;
  self.baseaccuracy = var0;

  if(scripts\engine\utility::flag("entered_shaft")) {
    self.forcebalconydeath = 1;
  }

  self.noloot = 1;
  thread tunnels_baseaccuracy_when_player_on_ladder_or_in_smoke_or_above_player_in_shaft();
}

function tunnels_baseaccuracy_when_player_on_ladder_or_in_smoke_or_above_player_in_shaft() {
  self endon("death");
  var0 = 0.5;
  var1 = 200;
  var2 = 0.1;
  var3 = 0;

  for(;;) {
    wait 0.25;

    if(istrue(self.shotgun_rest)) {
      continue;
    }

    if(!isDefined(self.enemy) || !isPlayer(self.enemy)) {
      continue;
    }

    var4 = 0;
    var5 = self.baseaccuracy;

    if(is_above_player_in_shaft()) {
      var6 = self.origin[2] - level.player.origin[2];

      if(var6 > var1) {
        var5 = var0;
      } else {
        var7 = clamp(1 - var6 / var1, 0, 1);
        var8 = self.original_baseaccuracy - var0;
        var5 = var0 + var8 * var7;
      }

      var4 = 1;
    }

    if(is_player_on_ladder_with_distance_check(120)) {
      var5 = min(var5, var2);
      var4 = 1;
    }

    if(is_not_safe_from_smoke()) {
      var5 = min(var5, var3);
      var4 = 1;
    }

    if(var4) {
      self.baseaccuracy = var5;
      continue;
    }

    scripts\sp\maps\tunnels\zd30tunnels_utility::reset_baseaccuracy();
  }
}

function is_above_player_in_shaft() {
  var0 = getEnt("shaft_top_level_enemy_grabber", "targetname");
  return self istouching(var0) && self.origin[2] > level.player.origin[2];
}

function is_player_on_ladder_with_distance_check(var0) {
  var1 = scripts\engine\utility::distance_2d_squared(self getEye(), level.player getEye()) > var0 * var0;
  return level.player isonladder() && var1;
}

function is_not_safe_from_smoke() {
  return !istrue(level.player_is_safe_from_smoke);
}

function shutup_when_hit() {
  var0 = scripts\engine\utility::waittill_any_return("damage", "death");

  if(isDefined(self)) {
    self stoploopsound();
    self stopsounds();
    return;
  }
}

function get_alive_enemies() {
  var0 = [];
  var1 = getaiarray("axis");

  if(!isDefined(var1) || var1.size == 0) {
    return var0;
  }

  foreach(var3 in var1) {
    if(isDefined(var3) && isalive(var3)) {
      var0 = var3;
    }
  }

  return var0;
}

function battlechatter_off_spawn_func() {
  self endon("death");

  while(!istrue(self.battlechatterallowed)) {
    wait 0.1;
  }

  waitframe();
  scripts\engine\sp\utility::set_battlechatter(0);
}

function tunnels_flashlight_management() {
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
    if(self.script_noteworthy == "storage_spotter") {
      return;
    }
  }

  thread flashlight_management();
}

function flashlight_management() {
  self endon("death");

  if(isDefined(self.script_parameters) && self.script_parameters == "force_flashlight") {
    scripts\sp\nvg\nvg_ai::flashlight_on();
    return;
  }

  scripts\sp\nvg\nvg_ai::flashlight_off();
  var0 = cos(30);
  var1 = 0.1;
  var2 = 2;

  for(;;) {
    while(nullweapon(self.weapon)) {
      wait var1;
    }

    if(is_aimming_at_enemy(var0) || is_aimming_forward(var0)) {
      if(!istrue(self.flashlight)) {
        scripts\sp\nvg\nvg_ai::flashlight_on();
        wait var2;
      }
    } else if(istrue(self.flashlight)) {
      scripts\sp\nvg\nvg_ai::flashlight_off();
    }

    wait var1;
  }
}

function is_aimming_at_enemy(var0) {
  var1 = "tag_weapon_right";

  if(isDefined(self.enemy) && (isPlayer(self.enemy) || isai(self.enemy)) && isalive(self.enemy)) {
    var2 = ["j_mainroot", "j_spine4", "tag_eye"];

    foreach(var4 in var2) {
      if(!nullweapon(self.weapon) && isalive(self.enemy) && scripts\engine\utility::within_fov(self getEye(), self gettagangles(var1), self.enemy gettagorigin(var4), var0)) {
        return true;
      }
    }
  }

  return false;
}

function is_aimming_forward(var0) {
  var1 = "tag_weapon_right";
  var2 = (0, self gettagangles("TAG_ORIGIN")[1], 0);
  var3 = vectorNormalize(anglesToForward(var2)) * 32;
  var4 = self getEye() + var3;
  var5 = self getEye();
  var6 = self gettagangles(var1);

  if(!nullweapon(self.weapon) && scripts\engine\utility::within_fov(var5, var6, var4, var0)) {
    return true;
  }

  return false;
}

function tunnels_ar_guys_force_ak47() {
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

  scripts\sp\maps\tunnels\zd30tunnels_utility::enemy_force_ak47();
}

function tunnels_door_guy_fire_aware() {
  self endon("death");

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "opendoor")) {
    scripts\common\utility::demeanor_override("sprint");
    var0 = strtok(self.script_parameters, "_")[1];
    var1 = getEntArray(var0, "targetname");
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::scripted_door_open(var0, 0);
    wait 6;
    scripts\common\utility::clear_demeanor_override();
    thread fire_aware();
    return;
  }
}

function tunnels_shaft_molotov_giveth() {
  self endon("death");

  if(isDefined(self.script_parameters) && issubstr(self.script_parameters, "opendoor")) {
    return;
  }

  var0 = 3;
  var1 = get_touching_goal_vol();

  if(isDefined(var1) && isDefined(var1.targetname) && int(strtok(var1.targetname, "_")[2]) >= var0) {
    scripts\engine\sp\utility::set_grenadeweapon("molotov");

    if(scripts\engine\utility::cointoss()) {
      self.grenadeammo = 1;
    } else {
      self.grenadeammo = 2;
    }

    self.grenadesafedist = 300;
    return;
  }
}

function basement_footsteps(var0, var1, var2) {
  wait var1;

  if(!isDefined(self)) {
    return;
  }

  var3 = undefined;

  if(var0 == "short") {
    var4 = [];
    GscBinSkip0(0x2e, 0, "scn_aq_fs_running_tunnels_short_01");
  }

  if(var1 == "long") {
    var5 = [];
    GscBinSkip0(0x2e, 0, "scn_aq_fs_running_tunnels_long_01");
  }
}

function stop_sound_when_slowed(var0, var1) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var1)) {
    self endon(var1);
  }

  var2 = 0.25;
  var3 = self.origin;
  var4 = 0;
  var0 *= var2;

  for(;;) {
    wait var2;
    var4 = length2d(self.origin - var3) / var2;
    var3 = self.origin;

    if(var4 < var0) {
      self stopsounds();
      return;
    }
  }
}

function basement_sneak_1() {
  self endon("death");
  self endon("entitydeleted");
  self.meleechargedistvsplayer = 48;
  scripts\engine\sp\utility::set_goal_radius(28);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  thread basement_footsteps("short", 0.35);
  thread basement_sneak_1_backup_spawn();
  self waittill("goal");
  var0 = getnode("basement_sneak_node", "targetname");
  self setgoalpos(var0.origin);
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread basement_left_flank_camper();
}

function basement_sneak_1_animated() {
  self endon("death");
  self endon("entitydeleted");
  self.meleechargedistvsplayer = 48;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::say_sequence(["dx_vom_aq1_tunnels_hunt_62", "dx_vom_aq2_tunnels_hunt_64"], 1);
  self.animname = "basement_right_to_left_runner";
  self.allowdeath = 1;
  var0 = scripts\engine\utility::getStruct("basement_right_to_left", "targetname");
  thread basement_footsteps("short", 0.35);
  thread basement_sneak_1_backup_spawn();
  var0 thread scripts\common\anim::anim_single_solo(self, "basement_run");
  waitframe();
  var1 = 0.37;
  self setanimtime(scripts\engine\utility::getanim("basement_run"), var1);
  self waittillmatch("single anim", "end");
  self clearenemy();
  var2 = getnode("basement_sneak_node", "targetname");
  self setgoalpos(var2.origin);
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread basement_left_flank_camper();
}

function basement_sneak_1_backup_spawn() {
  var0 = scripts\engine\utility::waittill_any_return("death", "goal");

  if(isDefined(var0) && var0 == "death") {
    var1 = getEnt("basement_sneak_1_backup", "targetname");
    var1 notify("trigger", level.player);
    return;
  }
}

function basement_sneak_1_backup() {
  self endon("death");
  self endon("entitydeleted");
  self.meleechargedistvsplayer = 48;
  self notify("behavior_reset");
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_goal_radius(32);
  var0 = getnode("basement_sneak_node", "targetname");
  self setgoalpos(var0.origin);
  self waittill("goal");
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread basement_left_flank_camper();
}

function ai_slice_settings() {
  self.pathenemyfightdist = 48;
  self._blackboard.reacquiresteptime = 0;
  self.meleechargedistvsplayer = 80;
  self.aggressivemode = 1;
  self.cautiouslookaheaddist = 92;
  scripts\engine\utility::set_cautious_navigation(1);
  scripts\common\ai::set_gunpose("disable");
  self.combatmode = "no_cover";
}

function basement_final_guy() {
  self endon("death");
  self waittill("goal");
  scripts\engine\sp\utility::set_maxfaceenemydist(48);
  scripts\common\utility::clear_demeanor_override();
  thread ai_slice_settings();
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\utility::set_movement_speed(60);
  var0 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var0);
  scripts\engine\sp\utility::set_goal_radius(32);
  wait 5;
  scripts\common\ai::reset_gunpose();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::set_movement_speed(160);
}

function basement_first_cell_guy() {
  self endon("death");
  level.basement_first_cell_guy = self;
  thread ai_slice_settings();
  self.meleechargedistvsplayer = 80;
  scripts\engine\sp\utility::set_goal_radius(32);
  thread spawn_right_flank_run_early_on_death_and_look_at_struct();
  var0 = 16;
  var1 = 50;
  thread monitor_enemy_been_seen(var1);
  var2 = getnodearray("basement_camper_exit_to", "targetname");
  var3 = scripts\engine\utility::getclosest(self.origin, var2, 300);
  var4 = undefined;

  if(isDefined(var3)) {
    var4 = getEnt(var3.target, "targetname");
    thread basement_guy_wake_by_trigger(var4);
    var0 = 60;
  }

  scripts\engine\utility::set_cautious_navigation(0);
  scripts\common\utility::demeanor_override("sprint");
  thread first_cell_look_at_watch();
  wait var1 / 1000 + 0.05;
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any_timeout, var0, "bullethit", "grenade danger", "damage");
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any_timeout, var0, "enemybeenseen", "bulletwhizby", "wakebytrigger");
  scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "first_cell_look_at");
  scripts\engine\sp\utility::do_wait_any();
  scripts\engine\utility::ent_flag_init("blind_fire_finished");
  thread basement_first_cell_guy_canned_once();
  var5 = 120;

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) < var5) {
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
  var6 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var6);
  scripts\engine\sp\utility::set_goal_radius(32);
  thread tunnels_notify_first_cell_guy_death();
  scripts\engine\utility::flag_wait("first_cell_guy_passed");
  scripts\common\ai::reset_gunpose();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::set_movement_speed(160);

  if(isDefined(level.farah) && isalive(level.farah)) {
    level.farah getenemyinfo(self);
    return;
  }
}

function first_cell_look_at_watch() {
  self endon("death");
  var0 = getEnt("first_cell_look_at_trig", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname").origin;
  var0 waittill("trigger");

  while(!scripts\engine\sp\utility::player_looking_at(var1, 0.95)) {
    wait 0.05;
  }

  self notify("first_cell_look_at");
}

function basement_first_cell_guy_canned_once() {
  self endon("death");
  self endon("entitydeleted");
  self endon("blind_fire_right_stop_all");
  self.allowdeath = 1;
  self.animname = "basement_firstcell";
  var0 = scripts\engine\utility::getStruct("basement_blind_fire_right", "targetname");
  thread farah_first_cell_guy_warn_vo();
  var0 scripts\sp\anim::anim_reach_solo(self, "blind_fire_right");
  scripts\engine\utility::delaythread(0.25, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_aq2_tunnels_ambusher_20");
  var0 scripts\common\anim::anim_single_solo(self, "blind_fire_right");
  scripts\engine\utility::ent_flag_set("blind_fire_finished");
}

function farah_first_cell_guy_warn_vo() {
  level endon("left_alcove_enemy");
  var0 = anglesToForward(level.player.angles);
  var1 = self.origin - level.player.origin;
  var2 = scripts\engine\math::anglebetweenvectorssigned(var0, var1, (0, 0, 1));

  if(var2 < 20 && var2 > -110) {
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_far_basement_tunnel_combat1_50", 2, 0.5);
  }

  scripts\engine\sp\utility::waittill_dead(scripts\engine\utility::array_removedead([self, level.first_blast_enemy]));
  scripts\engine\utility::flag_wait("basement_runner_gone");
  wait 0.3;
  scripts\sp\maps\tunnels\zd30tunnels_utility::wait_combat_cooldown(0.6, 3);

  if(istrue(level.runner_got_away)) {
    level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_alx_tunnels_hunt_16", 1, 2);
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_far_tunnels_hunt_19");
    level.runner_got_away = undefined;
  } else {
    level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_alx_tunnels_hunt_20", 1, 2);
  }

  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_far_basement_tunnel_trips_10");
}

function spawn_right_flank_run_early_on_death_and_look_at_struct() {
  var0 = getEnt("right_flank_surprise_spawner_trig", "targetname");
  var1 = scripts\engine\utility::getStruct("right_flank_surprise_lookat_spawn", "targetname").origin;
  var0 endon("death");
  var0 endon("trigger");
  var0 endon("entitydeleted");
  self waittill("death");
  wait 1.5;

  while(!scripts\engine\sp\utility::player_looking_at(var1, 0.94)) {
    wait 0.2;
  }

  if(isDefined(var0)) {
    var0 notify("trigger");
    return;
  }
}

function tunnels_notify_first_cell_guy_death() {
  level endon("first_cell_guy_passed");
  self waittill("death");
  scripts\engine\utility::flag_set("first_cell_guy_passed");
}

function basement_right_flank_runner() {
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
  scripts\engine\utility::delaythread(2, &scripts\engine\sp\utility::set_ignoreall, 0);
  self.target = "right_flank_run_node";
  thread scripts\sp\spawner::go_to_node();
  thread basement_footsteps("short", 0.8);
  enemy_turn_off_lantern(3);
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, 220);
}

function enemy_turn_off_lantern(var0) {
  var1 = scripts\engine\utility::getStruct("right_flank_latern_shoot_at", "targetname").origin;
  wait var0;
  radiusdamage(var1, 4, 100, 99, level.player, "MOD_PISTOL_BULLET");
}

function send_running_if_player_skipped_farah_ceiling_scene() {
  self endon("death");
  self endon("right_flank_goto");
  scripts\engine\utility::flag_wait("right_flank_goto");

  if(istrue(level.farah_ceiling_takedown_scene_on)) {
    return;
  }

  self notify("right_flank_goto");
}

function basement_right_flank_surprise() {
  if(scripts\engine\utility::flag("player_passed_right_flank")) {
    return;
  }

  thread enemy_turn_off_lantern(0.05);
  thread zdt_rush_guy();
  self waittill("death");
  scripts\engine\utility::flag_set("basement_right_flank_surpise_dealt");
}

function coward_buddy_whisper() {
  scripts\engine\utility::waittill_any("death", "entitydeleted");
  wait 0.75;

  if(isDefined(level.basement_coward) && isalive(level.basement_coward) && !istrue(level.basement_coward.escape_now)) {
    level.basement_coward thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playSound("dx_vom_aq2_tunnels_ambusher_20");
    return;
  }
}

function basement_door_surprise_guy() {
  level.basement_door_guy = self;
  thread zdt_rush_guy();
  self waittill("death");
  scripts\engine\utility::flag_set("basement_door_guy_dealt");
  thread scripts\engine\sp\utility::autosave_now();
}

function basement_runner() {
  self endon("death");
  self notify("behavior_reset");
  self endon("behavior_reset");

  if(!isDefined(level.basement_runners)) {
    level.basement_runners = [];
  }

  level.basement_runners[level.basement_runners.size] = self;
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(16);
  wait 0.5;
  var0 = getEnt("basement_runner_trig", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname").origin;

  for(;;) {
    if(self hasenemybeenseen(50) || self cansee(level.player)) {
      break;
    }

    if(isDefined(var0) && level.player istouching(var0) && scripts\engine\sp\utility::player_looking_at(var1, 0.9)) {
      break;
    }

    if(istrue(var0.skipped)) {
      break;
    }

    if(istrue(self.escape_now)) {
      break;
    }

    wait 0.05;
  }

  var2 = randomfloatrange(1, 1.6);
  thread basement_footsteps("long", var2);

  if(isDefined(level.basement_runners[0]) && level.basement_runners[0] == self) {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playSound("dx_vom_aq1_tunnels_search_112");
  }

  var3 = getnode("basement_coward_node", "targetname");
  self setgoalnode(var3);
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\common\utility::demeanor_override("sprint");
  self.combatmode = "no_cover";
  self.script_combatmode = "no_cover";
  self waittill("goal");
  var4 = 750;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, var4);
}

function basement_coward() {
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
  var0 = scripts\engine\utility::waittill_any_return("bulletwhizby", "bullethit", "player_too_close", "player_shot_at", "player_look_at", "weapon_fired");
  thread basement_footsteps("long", 0.5, "damage");
  self.escape_now = 1;

  if(isDefined(level.basement_runners)) {
    foreach(var2 in level.basement_runners) {
      if(isDefined(var2) && isalive(var2)) {
        var2.escape_now = 1;
      }
    }
  }

  if(isDefined(var0) && var0 == "weapon_fired") {
    thread scripts\engine\sp\utility::set_ignoreall(1);
    scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::set_ignoreall, 0);
  }

  scripts\engine\sp\utility::set_goal_radius(32);
  self.target = "basement_coward_node";
  thread scripts\sp\spawner::go_to_node();
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  scripts\engine\sp\utility::set_grenadeammo(0);
  self waittill("goal");
  var4 = 400;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, var4);
}

function miss_player_in_the_back(var0, var1, var2) {
  self endon("death");

  if(isDefined(var0)) {
    self endon(var0);
  }

  if(!isDefined(var2)) {
    var2 = 99999;
  }

  if(!isDefined(var1)) {
    var1 = 128;
  }

  while(var2 > 0) {
    if(scripts\engine\sp\utility::player_looking_at(self getEye(), 0.8) || self hasenemybeenseen(50)) {
      break;
    }

    if(scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin) < var1 * var1) {
      break;
    }

    self.baseaccuracy = 0.2;
    var2 -= 0.1;
    wait 0.1;
  }

  scripts\sp\maps\tunnels\zd30tunnels_utility::reset_baseaccuracy();
}

function dont_shoot_player_in_the_back(var0, var1, var2) {
  self endon("death");

  if(isDefined(var0)) {
    self endon(var0);
  }

  if(!isDefined(var2)) {
    var2 = 99999;
  }

  if(!isDefined(var1)) {
    var1 = 128;
  }

  while(var2 > 0) {
    if(scripts\engine\sp\utility::player_looking_at(self getEye(), 0.8) || self hasenemybeenseen(50)) {
      break;
    }

    if(scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin) < var1 * var1) {
      break;
    }

    thread scripts\engine\sp\utility::enable_dontevershoot();
    var2 -= 0.1;
    wait 0.1;
  }

  thread scripts\engine\sp\utility::disable_dontevershoot();
}

function coward_monitor_if_player_is_close(var0) {
  self notify("coward_monitor_if_player_is_close");
  self endon("coward_monitor_if_player_is_close");
  self endon("death");

  for(;;) {
    if(distancesquared(level.player.origin, self.origin) < var0 * var0) {
      break;
    }

    wait 0.1;
  }

  self notify("player_too_close");
}

function coward_monitor_if_player_shot_at() {
  self notify("coward_monitor_if_player_shot_at");
  self endon("coward_monitor_if_player_shot_at");
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1);

    if(isDefined(var1) && isPlayer(var1)) {
      break;
    }
  }

  self notify("player_shot_at");
}

function coward_monitor_if_player_look_at() {
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

function zdt_rush_guy(var0) {
  self endon("death");
  self notify("behavior_reset");
  self endon("behavior_reset");
  self.rushing_player = 1;
  self.aggressivemode = 1;
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  wait 0.05;
  self setgoalentity(level.player, 500);
  scripts\engine\sp\utility::set_goal_radius(32);

  if(!istrue(var0)) {
    self.meleechargedistvsplayer = 75;
  }

  self.combatmode = "no_cover";
  self.script_combatmode = "no_cover";
  scripts\common\utility::demeanor_override("sprint");
  scripts\engine\sp\utility::set_grenadeammo(0);
  var1 = 180;

  for(;;) {
    if(distancesquared(self.origin, level.player.origin) < var1 * var1) {
      var2 = [];
      GscBinSkip0(0x2e, var2.size, "dx_vom_aq1_tunnels_search_210");
    }

    wait 0.2;
  }
}

function basement_ceiling_guy() {
  var0 = getnode("ceiling_escape_node", "targetname");
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\common\utility::demeanor_override("sprint");
  level.basement_ceiling_guy = self;
  var1 = 150;

  if(self.script_parameters == "ceiling_guy1") {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::enemy_force_pistol();
    thread delete_basement_runner_wait_trig();
    thread basement_ceiling_ignoreme_think();
    scripts\engine\sp\utility::set_grenadeammo(2);
    var1 = 225;
  }

  if(self.script_parameters == "ceiling_guy3") {
    self.disablepistol = 1;
    GscBinSkip4(0x35);
  }

  thread enemy_delay_shooting(0.75);
  self waittill("goal");
  wait 0.5;
  scripts\engine\sp\utility::set_goal_pos(self.origin);
  scripts\engine\sp\utility::set_goal_radius(32);
  thread ceiling_stance_think(var0, var1);
  thread scripts\engine\sp\utility::name_hide();
  self waittill("death");

  if(isDefined(self) && isDefined(self.origin)) {
    var2 = getnodesinradius(self.origin - (0, 0, 20), 48, 0, 64);
    var3 = undefined;

    if(isDefined(var2) && var2.size > 0) {
      var3 = var2[0];
    }

    var4 = self gettagorigin("j_chest");

    if(!isDefined(var4)) {
      var4 = self.origin;
    }

    var5 = 32;

    if(isDefined(var3) && distancesquared(var3.origin, var4) < var5 * var5) {
      if(isnodeoccupied(var3) && isDefined(showcinematicletterboxing(var3)) && showcinematicletterboxing(var3) == self) {
        self.animname = "ceiling_" + strtok(self.script_parameters, "_")[1];
        self.deathanim = level.scr_anim[self.animname]["ceiling_death"];
        self.ceiling_custom_death_success = 1;
      }
    }
  }

  if(istrue(self.ceiling_custom_death_success)) {
    self notify("ceiling_corpse_tripwire");
    return;
  }

  self notify("ceiling_corpse_tripwire_failed");
}

function ceiling_guy_warning_shots() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt("ceiling_enemy_shoot_at", "targetname");
  scripts\engine\utility::flag_wait("ceiling_warning_shots");
  wait 0.65;
  var1 = 1;

  while(!self hasenemybeenseen(50) && var1 > 0) {
    self shoot(1, var0);
    var2 = randomfloatrange(0.15, 0.25);
    wait var2;
    var1 -= var2;
  }

  wait 0.3;
  level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_far_tunnels_hunt_74", 1);
}

function ceiling_infinite_ammo() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    wait 2;
    self.bulletsinclip = 30;
  }
}

function ceiling_guy_run_away_if_losses_player(var0) {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    jumpiftrue(self cansee(level.player)) LOC_00000026;
    wait 0.1;
  }

  for(;;) {
    while(self cansee(level.player)) {
      wait 0.1;
    }

    var1 = gettime();

    while(!self cansee(level.player)) {
      if(gettime() - var1 > var0 * 1000) {
        self.escape_now = 1;
        return;
      }

      wait 0.1;
    }

    wait 0.05;
  }
}

function enemy_delay_shooting(var0) {
  self endon("death");
  scripts\engine\sp\utility::enable_dontevershoot();

  while(!self cansee(level.player) && !self cansee(level.farah)) {
    wait 0.05;
  }

  wait 0.2;
  var1 = cos(20);

  if(!scripts\engine\sp\utility::player_looking_at(self getEye(), var1, 1)) {
    wait var0;
  }

  scripts\engine\sp\utility::disable_dontevershoot();
}

function basement_ceiling_ignoreme_think() {
  self endon("death");
  self.ignoreme = 1;
  var0 = self.health;

  while(isDefined(level.farah) && isalive(level.farah)) {
    if(self.health != var0) {
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

function delete_basement_runner_wait_trig() {
  self waittill("death");
  var0 = getEnt("basement_runner_trig", "targetname");

  if(isDefined(var0)) {
    var0.skipped = 1;
    return;
  }
}

function basement_ceiling_guy_flashlight() {
  scripts\sp\nvg\nvg_ai::flashlight_off();
  GscBinSkip4(0x35);
}

function ceiling_guy_flashlight_helper() {
  var0 = 1;

  for(;;) {
    waitframe();

    if(!isDefined(self.last_weapon_fire_time)) {
      continue;
    }

    if(gettime() - self.last_weapon_fire_time > var0 * 1000 && istrue(self.flashlight)) {
      scripts\sp\nvg\nvg_ai::flashlight_off();
    }
  }
}

function ceiling_guy_corpse_tripwire() {
  self endon("ceiling_corpse_tripwire_failed");
  self waittill("ceiling_corpse_tripwire");
  wait 1.25;
  var0 = getEnt("basement_left_flank_tripwire_setoff_trig", "script_noteworthy");

  if(isDefined(var0)) {
    var0 notify("trigger", level.farah);
    return;
  }
}

function basement_guy() {
  self endon("death");
  self.reacts_to_rush = 1;
}

function basement_left_flank_camper(var0) {
  self endon("death");
  thread ai_slice_settings();
  scripts\engine\sp\utility::set_goal_radius(32);
  var1 = 16;
  var2 = 50;
  thread monitor_enemy_been_seen(var2);
  var3 = getnodearray("basement_camper_exit_to", "targetname");
  var4 = scripts\engine\utility::getclosest(self.origin, var3, 300);
  var5 = undefined;

  if(isDefined(var4)) {
    var5 = getEnt(var4.target, "targetname");
    thread basement_guy_wake_by_trigger(var5);
    var1 = 60;
  }

  thread basement_left_flank_camper_long_death_think();
  wait var2 / 1000 + 0.05;
  var6 = scripts\engine\utility::waittill_any_timeout(var1, "bullethit", "grenade danger", "damage", "enemybeenseen", "wakebytrigger");
  level notify("left_alcove_enemy");

  if(!level.player scripts\engine\trace::can_see_origin(self getEye(), 0)) {
    level.farah scripts\engine\utility::delaythread(0.3, &scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter, "dx_vom_far_basement_tunnel_combat1_40", 1, 1);
  }

  if(istrue(var0)) {
    var7 = length(level.player getvelocity());
    var8 = clamp(var7, 60, 120);
  } else {
    var8 = 60;
  }

  scripts\engine\utility::set_movement_speed(var8);
  var9 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var9);
  scripts\engine\sp\utility::set_goal_radius(32);
  wait var2;
  scripts\common\ai::reset_gunpose();
  scripts\engine\sp\utility::set_goal_radius(256);
  scripts\engine\utility::set_movement_speed(160);
}

function basement_left_flank_camper_long_death_think() {
  self endon("death");
  self endon("entitydeleted");
  self.forcelongdeath = 4;
  scripts\engine\utility::flag_clear("left_flank_camper_disable_long_death");
  scripts\engine\utility::flag_wait("left_flank_camper_disable_long_death");
  scripts\engine\sp\utility::disable_long_death();
}

function basement_guy_wake_by_trigger(var0) {
  self endon("death");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isDefined(var1) && isPlayer(var1)) {
      break;
    }
  }

  if(isDefined(var0.script_noteworthy)) {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playSound(var0.script_noteworthy);
  }

  self notify("wakebytrigger");
}

function ceiling_stance_think(var0, var1) {
  self endon("death");

  for(;;) {
    self allowedstances("prone");

    if(isDefined(level.player) && (distance2d(level.player.origin, self.origin) < var1 || istrue(self.escape_now))) {
      self allowedstances("crouch", "stand");
      scripts\common\utility::demeanor_override("sprint");
      scripts\engine\sp\utility::set_goal_node(var0);
      scripts\engine\sp\utility::set_goal_radius(16);
      self waittill("goal");
      self delete();
      return;
    }

    wait 0.25;
  }
}

function player_call_out_ceiling_guy_on_damage() {
  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4);

    if(!isDefined(var1) || var1 != level.player || issubstr(var4, "MOD_GRENADE")) {
      wait 0.05;
      continue;
    }

    wait 0.25;

    if(istrue(level.zd30_ambush_nest_called_out)) {
      return;
    }

    level.player thread scripts\sp\maps\tunnels\zd30tunnels_utility::smart_dialogue_no_combat("dx_vom_alx_tunnels_hunt_72", 4, 2.5);
    level.zd30_ambush_nest_called_out = 1;
    return;
  }
}

function storage_spotter() {
  self endon("death");
  level.storage_spotter = self;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.animname = "storage_spotter";
  self.allowdeath = 1;
  self.health = 10;
  var0 = scripts\engine\utility::getStruct("storage_spotter", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var0 thread scripts\common\anim::anim_first_frame_solo(self, "storage_spotter_run");

  while(!scripts\engine\sp\utility::player_looking_at(var1.origin, 0.9) && !self hasenemybeenseen(50)) {
    if(scripts\engine\utility::flag("storage_reached")) {
      break;
    }

    wait 0.05;
  }

  var2 = getEnt("storage_runner_trig", "targetname");
  var2 thread scripts\engine\sp\utility::notify_delay("trigger", 0.85);
  var0 thread scripts\common\anim::anim_single_solo(self, "storage_spotter_run");
  waitframe();
  self setanimtime(scripts\engine\utility::getanim("storage_spotter_run"), 0.1);
  var3 = scripts\engine\utility::getStruct("teapot_whisper", "targetname");
  var4 = var3.origin;
  var5 = var4 + anglesToForward(var3.angles) * 160;
  scripts\engine\utility::delaythread(1, &scripts\engine\utility::play_sound_in_space, "dx_vom_aq1_tunnels_search_112", var5);
  self.ignoreall = 0;
  self.ignoreme = 0;
  var6 = gettime();
  var7 = getanimlength(scripts\engine\utility::getanim("storage_spotter_run"));
  thread coward_monitor_if_player_is_close(200);
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any, "damage", "bulletwhizby", "bullethit", "player_too_close");
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittillmatch_any_return, "single anim", "end");
  scripts\engine\sp\utility::do_wait_any();

  if((gettime() - var6) / 1000 < var7 * 1000) {
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

  var8 = getnode("storage_spotter_goto", "targetname");
  scripts\engine\sp\utility::set_goal_pos(var8.origin);
  scripts\engine\sp\utility::set_goal_radius(32);
  wait 0.05;
  thread storage_runner(0);
}

function storage_runner(var0) {
  self endon("death");

  if(!isDefined(level.storage_runners)) {
    level.storage_runners = [];
  }

  level.storage_runners[level.storage_runners.size] = self;
  self.storage_runner = 1;
  scripts\common\utility::demeanor_override("sprint");
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread coward_monitor_if_player_is_close(200);
  thread coward_monitor_if_player_shot_at();

  if(!isDefined(var0) || var0) {
    thread basement_footsteps("long", 2.35, "runner_awaken");
  }

  var1 = scripts\engine\utility::waittill_any_return("goal", "bulletwhizby", "bullethit", "grenade danger", "player_too_close", "player_shot_at");
  self notify("runner_awaken");
  self.ignoreall = 0;
  self.ignoreme = 0;

  if(!istrue(self.cleared_storage) && isDefined(var1) && (var1 == "player_shot_at" || var1 == "bullethit" || var1 == "player_too_close" || var1 == "bulletwhizby")) {
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
      scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playSound("dx_vom_aq2_tunnels_ambusher_20");
      wait 2;
      scripts\engine\sp\utility::set_battlechatter(1);
    }

    return;
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, 500);
}

function storage_ambusher_prep() {
  scripts\sp\maps\tunnels\zd30tunnels_utility::enemy_force_ak47_bright_muzzleflash();
  scripts\engine\sp\utility::set_goal_radius(32);
  self allowedstances("crouch");
  scripts\engine\sp\utility::enable_dontevershoot();
  self.ignoreall = 1;
  self.ignoreme = 1;
}

function storage_ambusher_attack() {
  self allowedstances("stand", "crouch", "prone");
  scripts\engine\sp\utility::disable_dontevershoot();
  self.ignoreall = 0;
  self.ignoreme = 0;
}

function storage_ambush_runner() {
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
  var0 = scripts\engine\utility::waittill_any_return("run_now", "bulletwhizby", "bullethit", "grenade danger", "damage");

  if(!isDefined(var0) || var0 != "run_now") {
    self.ignoreall = 0;
    self.ignoreme = 0;
  }

  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  var1 = getnode("storage_room_2_goto_delete_node", "targetname");
  scripts\engine\sp\utility::set_goal_pos(var1.origin);
  thread basement_footsteps("long", 0.5);
  self waittill("goal");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, 300);
}

function storage_ambusher() {
  self endon("death");
  scripts\engine\utility::ent_flag_init("advance");
  scripts\engine\sp\utility::set_grenadeammo(0);

  if(isDefined(self.script_parameters) && self.script_parameters == "left_guy") {
    level.storage_ambusher_left_guy = self;
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "coward") {
    wait 2;
    self delete();
    return;
  }

  storage_ambusher_prep();
  level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "storage_ambush");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_ambush_failsafe");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
  scripts\engine\sp\utility::do_wait_any();
  wait 1.5;
  thread storage_ambusher_fake_shoot("end_fake_shoot");
  storage_ambusher_attack();
  scripts\sp\maps\tunnels\zd30tunnels_utility::set_original_baseaccuracy(0.35);
  storage_ambusher_advance_watch(2, 0.5);
  self notify("end_fake_shoot");

  if(isDefined(self.script_parameters) && self.script_parameters == "left_guy") {
    storage_ambusher_advance();
    return;
  }

  self getenemyinfo(level.player);

  if(scripts\engine\utility::flag("storage_room_2_entered")) {
    scripts\engine\sp\utility::set_goal_radius(200);
    wait 2;
    var0 = getEnt("storage_flank_weapon_watch", "targetname");

    while(level.player istouching(var0)) {
      wait 0.25;
    }

    wait randomintrange(4, 10);
    zdt_rush_guy();
    return;
  }

  var1 = randomintrange(8, 12);
  scripts\engine\utility::flag_wait_or_timeout("storage_room_2_entered", var1);
  self setgoalentity(level.player, 50);
  scripts\engine\sp\utility::set_goal_radius(128);
}

function storage_ambusher_advance_watch(var0, var1) {
  self endon("death");
  wait var0;
  var2 = scripts\engine\utility::getStruct("storage_ambush_advance_look_at", "targetname").origin;

  for(;;) {
    while(!scripts\engine\sp\utility::player_looking_at(var2)) {
      if(scripts\engine\utility::flag("storage_room_2_entered") || scripts\engine\utility::flag("storage_flank_weapon_fired")) {
        break;
      }

      wait 0.05;
    }

    var3 = 0;

    while(scripts\engine\sp\utility::player_looking_at(var2)) {
      if(scripts\engine\utility::flag("storage_room_2_entered") || scripts\engine\utility::flag("storage_flank_weapon_fired")) {
        break;
      }

      var3 += 0.05;
      wait 0.05;

      if(var3 >= var1) {
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

function storage_ambusher_advance() {
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

function storage_ambusher_blind_fire() {
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
  level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "storage_ambush");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_ambush_failsafe");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
  scripts\engine\sp\utility::do_wait_any();
  wait 1;
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\sp\maps\tunnels\zd30tunnels_utility::set_original_baseaccuracy(0.35);
  scripts\engine\utility::ent_flag_set("blind_fire_start");
  storage_ambusher_attack();
  thread storage_ambusher_advance_watch(2, 0.5);

  if(isDefined(level.storage_ambusher_left_guy) && isalive(level.storage_ambusher_left_guy)) {
    level.storage_ambusher_left_guy scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "death");
  }

  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::ent_flag_wait, "advance");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_room_2_entered");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
  scripts\engine\sp\utility::do_wait_any();
  self notify("blind_fire_right_stop_all");
  self notify("blind_fire_right_stop_idle");
  waitframe();
  self stopanimScripted();

  if(scripts\engine\utility::ent_flag("advance")) {
    storage_ambusher_advance();
    return;
  }

  self actoraimassiston();
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_goal_radius(256);

  if(scripts\engine\utility::flag("storage_flank_weapon_fired")) {
    wait 8;
  }

  var0 = getEnt("storage_flank_weapon_watch", "targetname");

  while(level.player istouching(var0)) {
    wait 1;
  }

  zdt_rush_guy();
}

function storage_ambusher_blind_fire_anim(var0, var1, var2, var3) {
  self endon("death");
  self endon("entitydeleted");
  self endon(var1 + "_stop_all");
  thread god_until_damage_by_player();

  if(!isDefined(var2)) {
    var2 = 5;
  }

  if(!isDefined(var3)) {
    var3 = 8;
  }

  self.animname = var0;
  var4 = scripts\engine\utility::getStruct(var1, "targetname");

  for(;;) {
    var5 = randomfloatrange(var2, var3);
    var4 thread scripts\common\anim::anim_loop_solo(self, var1 + "_idle", var1 + "_stop_idle");
    wait var5;
    scripts\engine\utility::ent_flag_wait("blind_fire_start");
    var4 notify(var1 + "_stop_idle");
    var4 scripts\common\anim::anim_single_solo(self, var1);
  }
}

function god_until_damage_by_player() {
  scripts\common\ai::magic_bullet_shield();
  thread player_shot_monitor();
  scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "shot_by_player");
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::ent_flag_wait, "blind_fire_start");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_player_flanking");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_room_2_entered");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_flank_weapon_fired");
  scripts\engine\sp\utility::do_wait_any();
  scripts\common\ai::stop_magic_bullet_shield();
}

function player_shot_monitor() {
  for(;;) {
    self waittill("damage", var0, var1);

    if(isDefined(var1) && isPlayer(var1)) {
      self notify("shot_by_player");
      return;
    }
  }
}

function storage_ambusher_fake_shoot(var0) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(var0)) {
    self endon(var0);
  }

  var1 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("storage_ambusher_fake_shoot_at", "targetname")).origin;
  var2 = spawn("script_origin", var1);
  thread shoot_at_ent_delete_on_flag(var2, var0);

  for(;;) {
    if(!storage_ambusher_fake_can_shoot(var0)) {
      self clearentitytarget();
      scripts\engine\sp\utility::set_favoriteenemy(level.player);
      wait 0.05;

      while(!storage_ambusher_fake_can_shoot(var0)) {
        wait 0.2;
      }
    }

    var2.origin = get_random_pos(var1, 0, 32);
    wait 0.05;

    if(!isDefined(var2)) {
      return;
    }

    self setentitytarget(var2, 1);
    wait randomfloatrange(0.1, 0.2);
  }
}

function shoot_at_ent_delete_on_flag(var0, var1) {
  self waittill(var1);
  waitframe();

  if(isDefined(self) && isalive(self)) {
    self clearentitytarget();
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
  }

  var0 delete();
}

function get_random_pos(var0, var1, var2) {
  var3 = randomintrange(var1, var2);
  var4 = self.origin - var0;
  var5 = anglestoleft(vectortoangles(var4)) * var3;
  var6 = anglestoright(vectortoangles(var4)) * var3;
  var7 = var6;

  if(scripts\engine\utility::cointoss()) {
    var7 = var5;
  }

  return var0 + var7;
}

function storage_ambusher_fake_can_shoot(var0) {
  var1 = length2d(level.player.origin, self.origin);

  if(var1 < 128) {
    self notify(var0);
  }

  if(!self cansee(level.player) && var1 > 128) {
    return true;
  }

  return false;
}

function storage_advancer_mg_aware() {
  self endon("death");
  var0 = undefined;

  if(isDefined(self.target)) {
    var0 = getnode(self.target, "targetname");
  }

  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  scripts\engine\sp\utility::set_goal_radius(32);

  if(isDefined(var0)) {
    scripts\engine\sp\utility::set_goal_node(var0);
  } else {
    var1 = getEnt("storage_room_3", "targetname");
    self setgoalvolume(var1);
  }

  while(isDefined(level.storage_mg_guy) && isalive(level.storage_mg_guy)) {
    wait 0.2;
  }

  var2 = randomintrange(128, 256);
  self setgoalentity(level.player, 1000);
  scripts\engine\sp\utility::set_goal_radius(var2);
}

function storage_advancer() {
  self endon("death");
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  thread storage_advance_now();
  level endon("storage_advance_now");

  while(!self hasenemybeenseen(1000)) {
    wait 0.05;

    if(scripts\engine\utility::flag("in_storage_mg_nest")) {
      if(scripts\engine\sp\utility::player_looking_at(self.origin, 0.75) && scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin) < 160000) {
        thread zdt_rush_guy();
        return;
      }

      scripts\engine\sp\utility::set_goal_pos(getnode("lmg_node", "targetname").origin);
      wait 0.25;
      thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, 700);
      return;
    }
  }

  level notify("storage_advance_now");
}

function storage_advance_now() {
  self endon("death");
  self endon("entitydeleted");
  level waittill("storage_advance_now");
  var0 = getEnt("storage_room_2c", "targetname");
  var1 = getEnt("storage_room_3", "targetname");
  wait randomint(6);

  if(!level.player istouching(var1)) {
    self cleargoalvolume();
    self setgoalvolumeauto(var0);
    self waittill("goal");
    wait 8;
  }

  var2 = randomintrange(128, 256);
  self setgoalentity(level.player, 1000);
  scripts\engine\sp\utility::set_goal_radius(var2);
}

function flashbang_immunity(var0, var1) {
  self endon("death");

  if(!isDefined(var0)) {
    var0 = 3.5;
  }

  self.flashbangimmunity = 1;

  if(isDefined(var1)) {
    level scripts\engine\utility::waittill_any_timeout(var0, var1);
  } else {
    wait var0;
  }

  self.flashbangimmunity = undefined;
}

function storage_lmg_guy() {
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
  scripts\sp\maps\tunnels\zd30tunnels_utility::set_original_baseaccuracy(0.5);
  self allowedstances("stand", "crouch");
  self getenemyinfo(level.player);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var0 = getnode("lmg_node", "targetname");
  scripts\engine\sp\utility::set_goal_node(var0);
  scripts\engine\utility::waittill_any_timeout(1, "damage", "goal");
  self.ignoreall = 0;
  self.ignoreme = 0;
}

function set_off_storage_propane_tanks() {
  var0 = getEnt("storage_lmg_danger_zone", "targetname");

  if(level.player istouching(var0)) {
    return;
  }

  if(isDefined(level.storage_3rd_room_propanes)) {
    foreach(var2 in level.storage_3rd_room_propanes) {
      if(!isDefined(var2)) {
        continue;
      }

      var2 setscriptablepartstate("base", "fire");
    }

    return;
  }
}

function storage_lmg_room_guy() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_grenadeammo(0);
}

function storage_lmg_camper() {
  self endon("death");
  self endon("entitydeleted");
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\sp\utility::set_goal_radius(32);
  self waittill("goal");
  thread screams_when_seeing_enemy();

  while(!self hasenemybeenseen(500)) {
    wait 0.25;
  }

  wait 2;
  var0 = getnode("storage_mg_crawl_node", "targetname");
  scripts\engine\sp\utility::set_goal_pos(var0.origin);
  wait 3;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, 700);
}

function screams_when_seeing_enemy() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    if(self cansee(level.player) && isDefined(self.enemy) && self.enemy == level.player) {
      break;
    }

    wait 0.1;
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playSound("dx_vom_aq2_tunnels_ambusher_20");
}

function monitor_enemy_been_seen(var0, var1, var2) {
  self endon("death");
  self notify("enemybeenseen_monitoring");
  self endon("enemybeenseen_monitoring");
  jumpiffalse(!isDefined(var1) || var1) LOC_0000002c;
  thread can_player_see_any_part_of_enemy();

  for(;;) {
    while(!self hasenemybeenseen(var0)) {
      wait 0.05;
    }

    if(isDefined(var2)) {
      var3 = 0;

      while(self hasenemybeenseen(var0)) {
        var3 += 0.05;
        wait 0.05;

        if(var3 > var2) {
          break;
        }
      }

      if(var3 < var2) {
        continue;
      }
    }

    self notify("enemybeenseen");
    wait 0.1;
  }
}

function can_player_see_any_part_of_enemy() {
  self endon("death");

  for(;;) {
    var0 = anglesToForward(level.player getplayerangles());
    var1 = level.player getEye();
    var2 = var1 + var0 * 1500;

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_knee_le"), 2, 4)) {
      self notify("enemybeenseen");
    }

    wait 0.05;

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_knee_ri"), 2, 4)) {
      self notify("enemybeenseen");
    }

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_elbow_le"), 2, 4)) {
      self notify("enemybeenseen");
    }

    wait 0.05;

    if(scripts\engine\trace::capsule_trace_passed(level.player getEye(), self gettagorigin("j_elbow_ri"), 2, 4)) {
      self notify("enemybeenseen");
    }

    wait 0.05;
  }
}

function storage_mg_nest_first_guy() {
  self endon("death");
  self.ignoreme = 1;
  thread ai_slice_settings();
  scripts\engine\utility::set_movement_speed(160);
  var0 = getclosestpointonnavmesh(level.player.origin);
  scripts\engine\sp\utility::set_goal_pos(var0);
  scripts\engine\sp\utility::set_goal_radius(64);

  while(!scripts\engine\sp\utility::player_looking_at(self getEye())) {
    wait 0.05;
    var1 = 200;

    if(isDefined(level.farah) && isalive(level.farah) && scripts\engine\utility::distance_2d_squared(level.farah.origin, self.origin) < var1 * var1) {
      break;
    }
  }

  self.ignoreme = 0;
}

function mine_responder() {
  self endon("death");
  scripts\engine\sp\utility::set_goal_radius(32);
  thread battlechatter_off_spawn_func();

  while(!self hasenemybeenseen(2000)) {
    wait 0.25;
  }

  wait 0.5;

  if(!istrue(level.mine_responder_calling_out)) {
    level.mine_responder_calling_out = 1;
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playSound("dx_cbc_aq3_command_attack");
  }

  scripts\engine\sp\utility::set_battlechatter(1);
}

function mine_patroller() {
  self endon("death");
  self endon("stealth_combat");

  if(!isDefined(self.stealth) || !isDefined(self.script_stealthgroup) || self.script_stealthgroup != "shaft_patrol_water") {
    return;
  }

  scripts\engine\sp\utility::set_battlechatter(0);

  if(!scripts\sp\maps\tunnels\zd30tunnels_utility::player_has_pistol()) {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::enemy_force_pistol();
  }

  var0 = scripts\sp\maps\tunnels\zd30tunnels_utility::get_active_oil_fires();

  if(isDefined(var0) && var0.size > 0) {
    var1 = sortbydistance(var0, self.origin)[0];
    thread investigate_oil_fire(var1);
  }

  wait 0.1;
  scripts\sp\nvg\nvg_ai::flashlight_on();
}

function investigate_oil_fire(var0, var1) {
  self notify("investigating_oil_fire");
  self endon("investigating_oil_fire");
  self endon("death");
  self endon("stealth_combat");
  var0 endon("oil_fire_out");
  var2 = 35;
  var3 = 6;

  while(var2 > 0) {
    if(isDefined(var1)) {
      var4 = var1.origin;
    } else {
      var4 = scripts\sp\maps\tunnels\zd30tunnels_utility::get_investigate_point_in_oil_fire(var0);
    }

    self aieventlistenerevent("investigate", level.player, var4);
    wait var3;
    var2 -= var3;
  }
}

function shaft_propane_toss_guy() {
  self endon("death");
  self endon("entitydeleted");
  var0 = 50;
  thread monitor_enemy_been_seen(var0);
  thread shaft_top_ladder_escaper_wakeup();
  scripts\engine\utility::waittill_any("goal", "enemybeenseen");
  var1 = scripts\engine\utility::waittill_any_return("bullethit", "bulletwhizby", "enemybeenseen", "wakeup");
  scripts\engine\utility::flag_set("shaft_propane_toss");
  var2 = getnode("shaft_top_ladder_escaper_node", "targetname");
  scripts\engine\sp\utility::set_goal_node(var2);
  scripts\engine\sp\utility::set_goal_radius(48);
  wait 8;
  self setgoalentity(level.player, 50);
  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\engine\sp\utility::set_goal_radius(100);
}

function detonate_after_time(var0) {
  wait var0;
  radiusdamage(self.origin, 10, 100, 99);
  waitframe();
  level.player playRumbleOnEntity("light_1s");
}

function get_anim_frac_from_time(var0, var1) {
  var2 = getanimlength(scripts\engine\utility::getanim(var0));
  return var1 / var2;
}

function shaft_propane_from_model_and_set_state(var0, var1) {
  self waittillmatch("single anim", "end");
  var2 = getscriptablearray(var0, "targetname")[0];
  var2.origin = self.origin;
  var2.angles = self.angles;
  var2 setscriptablepartstate("base", "fire");
  self delete();
}

function shaft_propane_kick_guy() {
  self endon("death");
  self endon("entitydeleted");
  scripts\common\utility::demeanor_override("sprint");
  var0 = getEnt("shaft_propane_kick_trig", "targetname");
  var0 waittill("trigger");

  if(!scripts\engine\utility::flag("shaft_propane_kick_detonated")) {
    shaft_propane_kick_anim();

    if(scripts\engine\utility::flag("shaft_propane_kick_detonated")) {
      self stopanimScripted();
    }
  }

  scripts\engine\sp\utility::set_favoriteenemy(level.player);
  scripts\engine\sp\utility::set_goal_radius(100);
  var1 = getnode("shaft_propane_kick_node", "script_noteworthy");
  scripts\engine\sp\utility::set_goal_node(var1);

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(self.origin, var1.origin) > 1024) {
      self.deathanim = undefined;
      return;
    }

    wait 0.05;
  }
}

function shaft_propane_kick_anim() {
  self endon("death");
  self endon("is_burning");
  thread shaft_propane_kick_cancel_if_burning_or_hurt();
  var0 = 1.33;
  self.allowdeath = 1;
  self.animname = "shaft_propane_kick_guy";
  var1 = scripts\engine\utility::getStruct("propane_kick", "targetname");
  self.deathanim = level.scr_anim[self.animname]["falling_death"];
  var2 = getscriptablearray("shaft_propane_kick_scriptable", "targetname")[0];
  var2.animname = "shaft_propane_kick";
  var2 scripts\engine\sp\utility::assign_animtree();
  thread propane_reset_position(var2);
  scripts\engine\utility::flag_set("shaft_propane_kicked");
  var1 thread scripts\common\anim::anim_single_solo(self, "propane_kick");
  var1 thread scripts\sp\anim::anim_set_rate([self, var2], "propane_kick", var0);
  level.player scripts\engine\utility::delaycall(0.6, &playrumbleonentity, "heavy_1s");
  thread shaft_propane_state_change(var2, "shaft_propane_kick_detonated");
  thread anim_single_solo_scriptable(var1, var2);
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittillmatch_any_return, "single anim", "end");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "shaft_propane_kick_detonated");
  scripts\engine\sp\utility::do_wait_any();

  if(scripts\engine\utility::flag("shaft_propane_kick_detonated")) {
    var2 stopanimScripted();
    return;
  }
}

function propane_reset_position(var0) {
  self endon("death");
  self endon("entitydeleted");
  wait 0.5;
  var1 = getstartorigin(var0.origin, var0.angles, scripts\engine\utility::getanim("propane_kick"));
  var2 = getstartangles(var0.origin, var0.angles, scripts\engine\utility::getanim("propane_kick"));
  self.origin = var1;
  self.angles = var2;
}

function shaft_propane_kick_cancel_if_burning_or_hurt() {
  self endon("death");

  for(;;) {
    if(istrue(self._blackboard.isburning)) {
      self notify("is_burning");
      return;
    }

    wait 0.1;
  }
}

function shaft_propane_state_change(var0, var1) {
  level endon(var0);

  if(isDefined(var1)) {
    wait var1;
  }

  self setscriptablepartstate("base", "no_col");

  if(isDefined(self)) {
    self setscriptablepartstate("base", "fire");
    return;
  }
}

function anim_single_solo_scriptable(var0, var1, var2, var3) {
  thread scripts\common\notetrack::start_notetrack_wait(var0, "single anim", var1, var0.animname, var0 scripts\engine\utility::getanim(var1));
  thread scripts\sp\anim::animscriptdonotetracksthread(var0, "single anim", var1);

  if(isDefined(var2) && isDefined(var3)) {
    var0 setflaggedanim("single anim", var0 scripts\engine\utility::getanim(var1), 1, var2, var3);
    return;
  }

  var0 setflaggedanim("single anim", var0 scripts\engine\utility::getanim(var1));
}

function shaft_top_ladder_escaper() {
  self endon("death");
  self.ignoreall = 1;
  scripts\engine\sp\utility::disable_surprise();
  scripts\engine\sp\utility::set_ignoresuppression(1);
  scripts\common\utility::demeanor_override("sprint");
  self waittill("goal");
  var0 = getnode("shaft_top_ladder_escaper_node", "targetname");
  scripts\engine\sp\utility::set_goal_node(var0);
  scripts\engine\sp\utility::set_goal_radius(32);
  var1 = 50;
  thread monitor_enemy_been_seen(var1);
  thread shaft_top_ladder_escaper_wakeup();
  scripts\engine\utility::waittill_any("goal", "enemybeenseen");
  var2 = scripts\engine\utility::waittill_any_return("bullethit", "bulletwhizby", "enemybeenseen", "wakeup");

  if(isDefined(var2) && (var2 == "enemybeenseen" || var2 == "wakeup")) {
    self.ignoreall = 1;
  } else {
    self.ignoreall = 0;
  }

  var0 = getnode("despawn_node", "script_noteworthy");
  scripts\engine\sp\utility::set_goal_node(var0);
  var2 = scripts\engine\utility::waittill_any_return("bullethit", "grenade danger", "bulletwhizby");
  self.ignoreall = 0;
}

function shaft_top_ladder_escaper_wakeup() {
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

function shaft_fall_victim() {
  self endon("death");
  self endon("entitydeleted");
  var0 = getEnt("shaft_fall_victim_touching", "targetname");
  self waittill("goal");
  wait 1;

  if(!self istouching(var0)) {
    return;
  }

  var1 = scripts\engine\utility::getStruct("shaft_fall_victim_propane", "targetname");
  var2 = getclosestpointonnavmesh(var1.origin);
  var3 = getscriptablearray("shaft_fall_victim_propane_scriptable", "targetname")[0];

  if(!isDefined(var3) || !isDefined(var3.model) || var3.model == "") {
    wait 1;

    while(scripts\engine\sp\utility::player_looking_at(self.origin, 0.7, 1)) {
      wait 0.05;
    }

    thread shaft_fall_victim_burn();
    return;
  }

  var4 = var3.model;
  var3 setscriptablepartstate("base", "script_ignite", 1);
  scripts\engine\sp\utility::set_goal_pos(var2);
  scripts\engine\sp\utility::set_goal_radius(64);
  scripts\engine\utility::waittill_any_timeout(1.75, "goal");

  while(var3.model != "") {
    wait 0.05;
  }

  thread shaft_fall_victim_burn();
}

function shaft_fall_victim_burn() {
  ai_detachall();
  thread scripts\asm\soldier\death::handleburndeathmodelswap();
  thread scripts\asm\soldier\death::handleburndeathvfx();
  waitframe();
  scripts\sp\utility::do_damage(self.health + 9999, self.origin, level.player, level.player, "MOD_FIRE", "molotov");
}

function ai_detachall() {
  self detachall();
  self.headmodel = undefined;
  self.hatmodel = undefined;
}

function shaft_wave_1_guy_fire_aware() {
  self endon("death");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::enemy_force_ak47();
  self.spawn_time = gettime();
  var0 = get_touching_goal_vol();

  if(!isDefined(var0)) {
    var0 = level.shaft_vols[1];
  }

  set_new_goal_vol(var0);
  wait 0.05;
  scripts\sp\maps\tunnels\zd30tunnels_utility::set_original_baseaccuracy(1);

  while(!isDefined(level.player.cur_shaft_level_index) || level.player.cur_shaft_level_index < 2) {
    wait 1;
  }

  thread fire_aware();
}

function shaft_wave_1_guys_management() {
  while(!isDefined(level.mine_carts) || !isDefined(level.mine_carts["mine_cart"])) {
    wait 0.25;
  }

  level.mine_carts["mine_cart"] waittill("pushed");

  for(;;) {
    wait 0.5;
    var0 = get_alive_wave_1_guys();

    if(var0.size == 0) {
      continue;
    }

    var1 = 0;

    foreach(var3 in var0) {
      var4 = var3 getgoalvolume();

      if(!isDefined(var4) || var4 != level.shaft_vols[1]) {
        var1++;
      }
    }

    if(var1 == 0) {
      var6 = var0[0];
      var6 cleargoalvolume();
      var6 setgoalentity(level.player);
      var6 scripts\engine\sp\utility::set_goal_radius(500);
      var6 waittill("death");
      wait randomintrange(30, 45);
    }
  }
}

function get_alive_wave_1_guys() {
  var0 = [];
  var1 = getaiarray("axis");

  foreach(var3 in var1) {
    if(isalive(var3) && isDefined(var3.script_noteworthy) && var3.script_noteworthy == "shaft_wave_1") {
      var0 = var3;
    }
  }

  return var0;
}

function shaft_chaser_fire_aware(var0) {
  self endon("death");
  wait 0.05;
  scripts\sp\maps\tunnels\zd30tunnels_utility::set_original_baseaccuracy(1);

  if(isDefined(var0)) {
    self.goalradius = var0;
  } else {
    self.goalradius = 64;
  }

  for(;;) {
    if(isDefined(level.shaft_fire_on_level) && isDefined(level.player.cur_shaft_level_index) && level.shaft_fire_on_level >= level.player.cur_shaft_level_index) {
      var1 = int(min(level.shaft_vols.size - 1, level.shaft_fire_on_level + 1));
      set_new_goal_vol(level.shaft_vols[var1]);
    } else {
      self setgoalpos(level.player.origin);
    }

    wait 0.05;
  }
}

function shaft_follower() {
  self endon("death");
  thread fire_aware("go_for_player");

  for(;;) {
    var0 = isDefined(self.enemy) && self.enemy == level.player;
    var1 = self hasenemybeenseen(500);
    var2 = scripts\engine\sp\utility::player_looking_at(self getEye(), 0.7);

    if(var0 && var1) {
      break;
    }

    wait 0.2;
  }

  wait 1.75;
  self notify("go_for_player");
  zdt_rush_guy();
}

function fire_aware(var0) {
  self endon("death");

  if(isDefined(var0)) {
    self endon(var0);
  }

  var1 = get_touching_goal_vol();

  if(isDefined(var1) && !isDefined(self.target)) {
    set_new_goal_vol(var1);
  }

  for(;;) {
    jumpiftrue(isDefined(level.shaft_fire_on_level)) LOC_0000003d;
    wait 1;
  }

  for(;;) {
    var2 = get_touching_goal_vol_index();
    var1 = get_touching_goal_vol();

    if(level.shaft_fire_on_level >= var2) {
      if(isDefined(level.player.cur_shaft_level_index) && level.player.cur_shaft_level_index > var2) {
        var3 = getnodesinradius(self.origin, 512, 0, 96);

        if(isDefined(var3) && var3.size > 0) {
          var4 = sortbydistance(var3, self.origin)[0];
          self setgoalnode(var4);
          scripts\engine\utility::waittill_any_timeout(4, "goal");
        } else {
          scripts\engine\sp\utility::set_goal_pos(self.origin);
          wait 0.5;
        }

        if(isDefined(var1) && isDefined(var1.targetname)) {
          var5 = scripts\engine\utility::getStruct(var1.targetname, "script_noteworthy");

          if(isDefined(var5)) {
            scripts\engine\sp\utility::set_goal_pos(var5.origin);
          }
        }

        scripts\engine\sp\utility::set_goal_radius(32);
        scripts\engine\utility::waittill_any_timeout(5, "goal");
        enemy_death_by_fire(0);
        return;
      } else {
        var6 = int(min(level.shaft_vols.size - 1, level.shaft_fire_on_level + 1));
        set_new_goal_vol(level.shaft_vols[var6]);
      }
    }

    wait 2;
  }
}

function set_new_goal_vol(var0) {
  self endon("death");
  self cleargoalvolume();
  self setgoalpos(self.origin);
  waitframe();
  self setgoalvolumeauto(var0);
}

function get_touching_goal_vol() {
  foreach(var1 in level.shaft_vols) {
    if(self istouching(var1)) {
      return var1;
    }
  }

  return undefined;
}

function get_touching_goal_vol_index() {
  var0 = undefined;

  foreach(var3, var2 in level.shaft_vols) {
    if(self istouching(var2)) {
      var0 = var3;
    }
  }

  if(!isDefined(var0)) {
    var4 = scripts\engine\utility::getclosest(self.origin, level.shaft_vols);

    foreach(var6 in level.shaft_vols) {
      if(isDefined(var6) && var6 == var4) {
        var0 = var3;
      }
    }
  }

  return var0;
}