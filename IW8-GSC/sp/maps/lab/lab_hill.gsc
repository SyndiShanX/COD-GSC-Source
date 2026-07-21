/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\lab\lab_hill.gsc
***********************************************/

hill_preload() {
  scripts\engine\sp\utility::add_hint_string("zoom_in", &"LAB/ZOOM_IN", ::player_zoomingsniper);
  scripts\engine\sp\utility::add_hint_string("zoom_out", &"LAB/ZOOM_OUT", ::player_zoomingsniper);
  precachestring(&"LAB/TANK_COVER_HINT");
  precachemodel("viewmodel_arms_alex_woodland");
  precachemodel("veh8_mil_air_mquebec9_small");
  precachemodel("veh8_mil_air_mindia8_turret");
  precachemodel("debris_concrete_rubble_floor_slab_chunk_small_01");
  precachemodel("debris_concrete_rubble_floor_slab_chunk_small_04");
  precachemodel("debris_concrete_rubble_floor_slab_chunk_small_07");
  precachemodel("foliage_tree_spruce_01_anim");
  precachemodel("foliage_tree_spruce_01_sml_anim");
  precachemodel("foliage_tree_spruce_02_anim");
  precachemodel("foliage_tree_spruce_03_anim");
  precachemodel("foliage_tree_spruce_03_sml_anim");
  precachemodel("veh8_mil_lnd_bromeo_animated_dst");
  scripts\engine\utility::flag_init("remove_corner_clip");
  scripts\engine\utility::flag_init("lab_door_opened");
  scripts\engine\utility::flag_init("hill_finished_trig");
  scripts\engine\utility::flag_init("start_green_beam_instruct");
  scripts\engine\utility::flag_init("stop_green_beam_instruct");
  scripts\engine\utility::flag_init("scripted_bridge_shot");
  scripts\engine\utility::flag_init("tank_1_last_stop");
  scripts\engine\utility::flag_init("go_left");
  scripts\engine\utility::flag_init("tank_death");
  scripts\engine\utility::flag_init("hill_charge_moving");
  scripts\engine\utility::flag_init("left_apc_close");
  scripts\engine\utility::flag_init("right_apc_close");
  scripts\engine\utility::flag_init("left_apc_dead");
  scripts\engine\utility::flag_init("right_apc_dead");
  scripts\engine\utility::flag_init("hilltop_heli_dead");
  scripts\engine\utility::flag_init("hillmid_helis_unloaded");
  scripts\engine\utility::flag_init("lb_targeting_player");
  scripts\engine\utility::flag_init("door_close_flag");
  scripts\engine\utility::flag_init("inside_close_door");
  scripts\engine\utility::flag_init("hilltop_heli_spawned");
  scripts\engine\utility::flag_init("hilltop_apc_close");
  scripts\engine\utility::flag_init("second_rpg_shot");
  scripts\engine\utility::flag_init("manual_shooting");
  scripts\engine\utility::flag_init("post_bridge_shooting");
  scripts\engine\utility::flag_init("bridge_move_up");
  scripts\engine\utility::flag_init("bridge_move_up_b");
  scripts\engine\utility::flag_init("tank_past_bridge");
  scripts\engine\utility::flag_init("bridge_tanks_stopped");
  scripts\engine\utility::flag_init("ridge_tanks_stopped");
  scripts\engine\utility::flag_init("drone_scene_done");
  scripts\engine\utility::flag_init("shoot_at_runners");
  scripts\engine\utility::flag_init("tank_proceed_6");
  scripts\engine\utility::flag_init("ridge_2_tanks_stopped");
  scripts\engine\utility::flag_init("tank_proceed_7");
  scripts\engine\utility::flag_init("bunker_fallback");
  scripts\engine\utility::flag_init("ridge_3_tanks_stopped");
  scripts\engine\utility::flag_init("hill_mid_tank_stopped");
  scripts\engine\utility::flag_init("tank_proceed_8");
  scripts\engine\utility::flag_init("midhill_guys");
  scripts\engine\utility::flag_init("hill_crash_site");
  scripts\engine\utility::flag_init("next_targets");
  scripts\engine\utility::flag_init("shoot_apc");
  scripts\engine\utility::flag_init("hill_top_fallback");
  scripts\engine\utility::flag_init("backup_guys");
  scripts\engine\utility::flag_init("heli_intro_movement");
  level.tankfovcos = cos(35);
  level.heroes = [];
}

hill_postload() {
  if(!scripts\sp\starts::is_after_start("hill_top")) {
    lab_drone_setup();
    remove_node_clip("tank_stops");
    var_0 = scripts\common\utility::getvehiclespawner("convoy_tank_2", "targetname");
    var_0 scripts\engine\sp\utility::add_spawn_function(::tank_logic);
    var_1 = scripts\common\utility::getvehiclespawnerarray();
    scripts\engine\utility::array_thread(var_1, scripts\engine\sp\utility::add_spawn_function, ::global_vehicle_spawn_func);
    thread init_scriptable_trucks("exploding_hill_trucks");
    scripts\engine\sp\utility::array_spawn_function_targetname("bunker_runners", scripts\sp\utility::context_melee_allow, 0);
    scripts\engine\sp\utility::array_spawn_function_noteworthy("main_hill_guys", scripts\sp\maps\lab\lab_util.gsc::ai_movement_control, level.player, 2000, 500);
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_1_guys", ::tower_ai_thread, "tower_death_1");
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_2_guys", ::tower_ai_thread, "tower_death_2");
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_3_guys", ::tower_ai_thread, "tower_death_3");
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_4_guys", ::tower_ai_thread, "tower_death_4");
    thread tower_spawner_killer("tower_1_guys", "tower_death_1");
    thread tower_spawner_killer("tower_3_guys", "tower_death_3");
    scripts\engine\sp\utility::add_global_spawn_function("axis", ::gun_on_death, 0);
    scripts\engine\sp\utility::add_global_spawn_function("allies", ::gun_on_death, 0, "allies");
    scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\sp\maps\lab\lab_util.gsc::axis_grenade_toggle, 0);
    thread init_towers();
    var_2 = getEntArray("magic_rpg_trig", "targetname");
    scripts\engine\utility::array_thread(var_2, ::magic_rpg_trig);
    thread init_trees();
  }

  var_3 = getEnt("heli_crash_01", "targetname");

  if(isDefined(var_3))
    var_3 hide();
}

tower_ai_thread(var_0) {
  self endon("death");

  if(!scripts\engine\utility::flag(var_0))
    scripts\engine\utility::flag_wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  self.goalradius = 2000;

  if(var_0 == "tower_death_1") {
    var_1 = getEnt("ridge_1_volume", "targetname");
    self setgoalvolumeauto(var_1);
  } else if(var_0 == "tower_death_4") {
    var_1 = getEnt("hill_top_volume", "targetname");
    self setgoalvolumeauto(var_1);
  } else {
    var_1 = getEnt("hill_mid_ai_volume", "targetname");
    self setgoalvolumeauto(var_1);
  }
}

tower_spawner_killer(var_0, var_1) {
  level endon("hill_finished_trig");
  scripts\engine\utility::flag_wait(var_1);
  var_2 = getEntArray(var_0, "script_noteworthy");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2)
    var_4 delete();
  }
}

gun_on_death(var_0, var_1) {
  if(scripts\engine\utility::is_equal(self.script_noteworthy, "rooftop_ai")) {
    self dontcastshadows();
    self dontcastdistantshadows();
  }

  if(scripts\engine\utility::is_equal(self.script_parameters, "no_weapon_drop") || scripts\engine\utility::is_equal(self.script_noteworthy, "rooftop_ai")) {
    self waittill("weapon_dropped", var_2);
    self endon("droppedItem");

    while(isDefined(var_2) && scripts\sp\maps\lab\lab_util.gsc::in_player_fov(level.cos15, var_2.origin))
      waitframe();

    if(isDefined(var_2))
      var_2 delete();
  }
}

tree_test() {
  var_0 = getscriptablearray("spruce_01", "script_noteworthy");
  var_1 = getscriptablearray("spruce_02", "script_noteworthy");
  var_2 = getscriptablearray("spruce_03", "script_noteworthy");
  var_3 = scripts\engine\utility::array_combine(var_0, var_1, var_2);
  wait 5;

  foreach(var_5 in var_3)
  var_5 setscriptablepartstate("base", "hide", 1);
}

lab_drone_setup() {
  var_0 = (7775.56, 4129.22, 4000);
  level.green_beam_weapon = "iw8_green_beam_bright";
  scripts\sp\equipment\green_beam::laser_init(var_0, 2, "start_green_beam_instruct", "stop_green_beam_instruct");
  level.helidronefx = "drone_explode_heli";
  level.drone.fx_explode = "drone_explode";
  level.green_beam_does_vo = 0;
}

tank_logic() {
  self endon("death");
  childthread player_behind_tank_think();
  scripts\engine\utility::delaythread(0.2, ::tank_stop_for_allies_think);
  wait 1;
  var_0 = self.mainturret;
  var_0.target_ent = scripts\engine\utility::spawn_script_origin();
  var_0.convergencetime = 0.75;
  var_0 setconvergencetime(0.05, "pitch");
  scripts\vehicle\bromeo::mainturret_idle();
  self.godmode = 1;
  self.repulsorent = scripts\engine\utility::spawn_tag_origin();
  self.repulsorent.origin = self.origin + anglesToForward(self.angles) * 80;
  self.repulsorent linkTo(self);
  thread scripts\engine\utility::delete_on_death(self.repulsorent);
  createnavrepulsor("friendlyAPC Axis" + self getentitynumber(), -1, self.repulsorent, 250, 1, "axis");
  playFXOnTag(level._effect["tank_tread"], self, "tag_wheel_extra_right_3");
  playFXOnTag(level._effect["tank_tread"], self, "tag_wheel_extra_left_3");
}

global_vehicle_spawn_func() {
  if(scripts\engine\utility::flag("hill_finished_trig")) {
    return;
  }
  if(scripts\common\vehicle::ishelicopter()) {
    if(isDefined(level.vo_callouts))
      level thread scripts\engine\utility::delaythread(randomfloatrange(5, 7), scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter, level.vo_callouts.heli scripts\engine\sp\utility::deck_draw());

    scripts\common\vehicle::vehicle_lights_off();
    thread heli_death_thread();

    if(isDefined(self.riders) && istrue(self.riders.size))
      thread heli_crash_on_pilot_death();
  } else {
    thread custom_vehicle_damage_function();
    thread vehicle_death_custom();
  }
}

custom_vehicle_damage_function() {
  self endon("death");

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1);

    if(var_0 < 350 || !isDefined(level.tank2)) {
      continue;
    }
    if(scripts\engine\utility::is_equal(level.tank2.mainturret, var_1) && var_0 > 380)
      scripts\sp\utility::do_damage(self.health + 10000, self.origin, var_1);
  }
}

init_trees() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0["spruce_01"] = "foliage_tree_spruce_01_anim";
  var_0["spruce_02"] = "foliage_tree_spruce_02_anim";
  var_0["spruce_03"] = "foliage_tree_spruce_03_anim";
  var_0["spruce_01_sml"] = "foliage_tree_spruce_01_sml_anim";
  var_0["spruce_03_sml"] = "foliage_tree_spruce_03_sml_anim";
  var_1 = getscriptablearray("spruce_tree", "targetname", self.origin, 2000);

  foreach(var_3 in var_1) {
    var_3 scripts\engine\sp\utility::assign_animtree(var_3.script_noteworthy);
    var_3.og_model = var_3.model;
    var_3.anim_model = var_0[var_3.script_noteworthy];
  }
}

helicopter_tree_watcher() {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(self)) {
    wait 0.1;
    var_0 = getscriptablearrayinradius("spruce_tree", "targetname", self.origin, 2000);

    if(!isDefined(var_0) || var_0.size < 1) {
      continue;
    }
    foreach(var_2 in var_0) {
      if(!istrue(var_2.tree_is_animating) && (!isendstr(var_2.model, "destr") || !scripts\engine\utility::is_equal(var_2 getscriptablepartstate("base", 1), "dead")))
        var_2 thread play_tree_animation(self);
    }
  }
}

play_tree_animation(var_0) {
  self.tree_is_animating = 1;
  play_tree_animation_internal(var_0);
  self notify("reset_watcher");
  self.tree_is_animating = 0;
}

#using_animtree("scriptables");

play_tree_animation_internal(var_0) {
  self endon("stop_tree_thread");
  childthread watch_for_tree_death();
  var_1 = undefined;

  if(self.model == self.og_model)
    self setModel(self.anim_model);

  while(isDefined(var_0) && tree_dist_check(var_0) < 1000) {
    if(isendstr(self.model, "destr") || scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "dead")) {
      break;
    }

    var_2 = pick_tree_anim(var_0);

    if(!isDefined(var_2) || !isDefined(var_2[0]) || !isDefined(var_2[1])) {
      break;
    }

    var_1 = var_2[0];
    var_3 = var_2[1];
    self setanimknoballrestart(var_1, %root, 0.5, 0, var_3);
    wait(getanimlength(var_1) / var_3);
  }

  if(!isDefined(var_1) || (isendstr(self.model, "destr") || scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "dead"))) {
    return;
  }
  self setanimknoballrestart(var_1, %root, 0.5, 0, 0.5);
  wait(getanimlength(var_1) / 0.5);

  if(!isendstr(self.model, "destr"))
    self setModel(self.og_model);
}

watch_for_tree_death() {
  self endon("reset_watcher");

  while(isDefined(self) && !scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "dead"))
    waitframe();

  if(!isendstr(self.model, "destr"))
    self setModel(self.og_model);

  self.tree_is_animating = 0;
  self notify("stop_tree_thread");
}

pick_tree_anim(var_0) {
  if(!isDefined(self) || scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "dead")) {
    return;
  }
  var_1 = tree_dist_check(var_0);
  var_2 = tree_dist_values(var_1);
  var_3 = "low";

  if(var_1 > 800)
    var_3 = "low";
  else if(var_1 > 500)
    var_3 = "mid";
  else if(var_1 > 300)
    var_3 = "hi";

  var_4 = level.scr_anim[self.script_noteworthy][var_3];
  return [var_4, var_2];
}

anim_rate_watcher(var_0, var_1) {
  self endon("reset_watcher");

  for(;;) {
    var_2 = tree_dist_check(var_0);
    var_3 = tree_dist_values(var_2);
    self setanimrate(var_1, var_3);
    wait 0.3;
  }
}

tree_dist_check(var_0) {
  var_1 = self gettagorigin("treea_tag_a_13", 1);

  if(!isDefined(var_1))
    var_1 = self.origin;

  var_2 = distance(var_0.origin, var_1);
  return var_2;
}

tree_dist_values(var_0) {
  if(var_0 > 800)
    return 1;
  else if(var_0 > 500)
    return 1.2;
  else
    return 1.4;
}

init_scriptable_trucks(var_0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_1 = getscriptablearray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    var_4 = getscriptablearrayinradius(undefined, undefined, var_3.origin, 80);

    if(isDefined(var_4)) {
      foreach(var_6 in var_4) {
        if(var_6 != var_3)
          var_3.child = var_6;
      }
    }

    var_3 thread truck_damage_custom();
  }
}

init_scriptable_reds(var_0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_1 = getscriptablearray(var_0, "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 thread red_damage_custom();
}

truck_damage_custom() {
  var_0 = self.origin;

  while(isDefined(self)) {
    self waittill("damage", var_1, var_2, var_3, var_3, var_4, var_3, var_3, var_3, var_3, var_3);

    if(isDefined(self.child))
      self.child kill();

    if(var_1 < 300) {
      continue;
    }
    waitframe();

    if(isDefined(level.tank2) && scripts\engine\utility::is_equal(level.tank2.mainturret, var_2) && var_1 > 380 || isDefined(var_4) && (isexplosivedamagemod(var_4) && var_1 >= 100)) {
      if(isDefined(self.child)) {
        if(self.child getscriptableparthasstate("base", "death"))
          self.child setscriptablepartstate("base", "death");
      }

      thread smoke_thread(var_0);

      if(distance2dsquared(var_0, level.player.origin) > 40000)
        radiusdamage(var_0, 150, 400, 350, undefined, "MOD_GRENADE");
      else
        radiusdamage(var_0, 150, 60, 100, undefined, "MOD_GRENADE");

      return;
    }
  }
}

smoke_thread(var_0) {
  if(scripts\engine\utility::is_equal(self.script_noteworthy, "exploding_hill_trucks")) {
    wait 15;

    switch (randomint(3)) {
      case 1:
        playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_md"), var_0);
        break;
      default:
        playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_sml"), var_0);
        break;
    }
  }
}

red_damage_custom() {
  var_0 = self.origin;
  self waittill("damage");

  for(;;) {
    var_1 = self getscriptableparthasstate("base", "dead");

    if(var_1) {
      break;
    }

    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }
  if(distance2dsquared(var_0, level.player.origin) > 40000)
    radiusdamage(var_0, 150, 300, 250, undefined, "MOD_GRENADE");
}

init_towers() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("guard_tower", "script_noteworthy");
  var_1 = getscriptablearray("ridge_tower", "script_noteworthy");
  var_1[0].ridge_tower = 1;
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4 scripts\engine\sp\utility::get_linked_struct();
    var_4.nodes = getnodearray(var_5.target, "targetname");
    var_6 = getEntArray(var_5.target, "targetname");

    foreach(var_8 in var_6) {
      switch (var_8.classname) {
        case "script_brushmodel":
          var_4.brushmodel = var_8;
          break;
        case "trigger_multiple":
          var_4.trigger = var_8;
          break;
        default:
          break;
      }
    }

    var_4 thread guard_tower_logic();
  }
}

magic_rpg_trig() {
  self waittill("trigger");
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
    var_4 = magicbullet("iw8_la_rpapa7_straight_slow", var_2.origin, var_3.origin);
    var_4 playLoopSound("move_rpapa7_proj_flame");
    wait(randomfloatrange(0.5, 1));
  }

  self delete();
}

dont_drop_weapons() {
  self.noloot = 1;
  self.dontdropweapon = 1;
}

drone_start() {}

drone_main() {
  thread scripts\sp\hud_util::fade_out(0);
  scripts\engine\utility::delaythread(6, scripts\sp\hud_util::fade_in, 1.5);
  level.player lerpfovscalefactor(0, 0);
  level.player scripts\engine\utility::delaycall(20, ::lerpfovscalefactor, 1, 3);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.01);
  scripts\sp\maps\lab\lab_util.gsc::cine_letterboxing_up(0);
  level.player thread monitor_weapon_fire();
  scripts\sp\maps\lab\lab_lighting.gsc::drone_hero_lighting_setup();
  thread scripts\sp\maps\lab\lab_util.gsc::hide_hill_weapons();
  scripts\sp\maps\lab\lab_util.gsc::spawn_alex();
  scripts\sp\maps\lab\lab_util.gsc::spawn_hill_friendlies();
  thread friendlies_on_bridge_move();
  thread friendlies_follow_tanks();
  var_0 = scripts\engine\utility::array_remove_array(level.heroes, [level.alex, level.price, level.kyle, level.farah]);

  foreach(var_2 in var_0)
  var_2 thread run_n_gun();

  spawn_tank2();
  var_4 = scripts\engine\utility::getStruct("bridge_scene", "targetname");
  var_4 thread scripts\common\anim::anim_first_frame_solo(level.tank2, "bridge_scene");
  var_5 = [level.farah, level.price, level.kyle];
  scripts\engine\utility::array_thread(var_5, scripts\engine\utility::disable_pain);
  level.player scripts\engine\utility::delaycall(0.4, ::playsound, "scn_lab_intro_start_lr");
  drone_intro_scene();
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\sp\maps\lab\lab_vo_util.gsc::init_callout_vo();
  level.drone_updater = 1;
}

drone_catchup() {
  if(!scripts\sp\starts::is_after_start("lab_entrance")) {
    scripts\engine\utility::flag_set("allow_green_beam");
    scripts\sp\maps\lab\lab_vo_util.gsc::init_callout_vo();
    level.drone_updater = 1;
  }

  level.onlydroneused = 0;
  scripts\sp\maps\lab\lab_util.gsc::trigger_nearest_friendly_respawn_trigger();
  scripts\engine\utility::flag_set("introscreen_start_wait");
}

monitor_weapon_fire() {
  level endon("hill_finished_trig");
  level endon("drone_achievement_failed");
  level.onlydroneused = 1;
  childthread monitor_grenade_fire();

  for(;;) {
    self waittill("weapon_fired", var_0, var_1, var_2);

    if(!isDefined(var_0))
      var_0 = self.currentweapon;

    var_3 = scripts\sp\equipment\green_beam::beam_weapon_check();

    if(!scripts\engine\utility::is_equal(var_0.basename, var_3)) {
      level.onlydroneused = 0;
      level notify("drone_achievement_failed");
      break;
    }
  }
}

monitor_grenade_fire() {
  self waittill("grenade_fire", var_0, var_1);
  level.onlydroneused = 0;
  level notify("drone_achievement_failed");
}

friendlies_on_bridge_move() {
  if(isDefined(level.alex))
    var_0 = [level.farah, level.price, level.kyle, level.alex];
  else
    var_0 = [level.farah, level.price, level.kyle];

  var_1 = scripts\engine\utility::array_remove_array(scripts\sp\maps\lab\lab_util.gsc::rebuild_heroes_array(), var_0);

  foreach(var_3 in var_1) {
    var_3.dontavoidplayer = 1;
    var_3.nododgemove = 1;
    var_3 visiblenotsolid();
    var_3 scripts\engine\utility::set_movement_speed(90);
  }

  scripts\sp\maps\lab\lab_util.gsc::move_lab_allies("bridge_heroes", var_1);
  scripts\engine\utility::flag_wait("drone_scene_done");
  var_1 = scripts\engine\utility::array_remove_array(scripts\sp\maps\lab\lab_util.gsc::rebuild_heroes_array(), var_0);

  foreach(var_3 in var_1) {
    var_3.dontavoidplayer = 0;
    var_3.nododgemove = 0;
    var_3 visiblesolid();
    var_3 scripts\common\utility::clear_movement_speed();
  }
}

run_n_gun() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  self enableavoidance(0, 0);
  scripts\engine\utility::flag_wait("run_n_gun");

  if(!isDefined(self)) {
    return;
  }
  self enableavoidance(1, 1);
}

vo_bridge() {
  level endon("post_bridge_shooting");
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_lass_bridge_moving_90");
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_bridge_moving_100");
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_lass_bridge_moving_110");
  wait 15;
  var_0 = ["dx_vom_pri_bridge_moving_140", "dx_vom_pri_bridge_moving_150", "dx_vom_pri_bridge_moving_160"];
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("post_bridge_shooting", var_0, 8);
}

drone_intro_scene() {
  visionsetnaked("lab_intro_drone", 0.1);

  if(isDefined(level.fade)) {
    level.fade fadeovertime(0.1);
    level.fade.alpha = 0;
  }

  var_0 = scripts\engine\utility::getStruct("bridge_scene", "targetname");
  var_1 = setup_bridge_missile();
  level.fakedrone = setup_bridge_drone(var_1);
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.fakedrone, "bridge_scene");
  level.baddies = spawn_bridge_badies("intro_enemies");
  var_0 thread scripts\common\anim::anim_first_frame(level.baddies, "bridge_scene");
  arm_player();
  var_0 scripts\sp\player_rig::link_player_to_rig("bridge_scene", undefined, 0, undefined, 1, 0, 0, 0, 0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.player_rig hide();
  level.player enableinvulnerability();
  level.player playerdisabletriggers();
  level.player cleardamageindicators();
  level.player freezecontrols(1);
  level.player hidelegsandshadow();
  level.player hideviewmodel();
  level.player modifybasefov(45, 0.05);
  level.player.movespeedscale = 0;
  level.player setmovespeedscale(0);
  wait 0.6;
  setomnvar("ui_is_bink_skipping_enabled", 0);
  thread drone_intro_cine_camera_settings(var_1);
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(level.heroes, scripts\engine\sp\utility::name_hide);
  level.tank2 setvehiclelookattext("", &"");
  var_0 thread missile_logic(var_1);
  var_2 = var_0 thread debris_logic();
  var_0 thread scripts\common\anim::anim_single(level.baddies, "bridge_scene");
  var_0 thread scripts\common\anim::anim_single_solo(level.tank2, "bridge_scene");
  var_3 = [level.alex, level.price, level.farah, level.kyle];
  var_0 scripts\common\anim::anim_single(var_3, "bridge_scene");
  level.alex scripts\sp\maps\lab\lab_util.gsc::disable_magic_bullet_delete();
  scripts\sp\maps\lab\lab_util.gsc::unlink_player_from_rig_lab();
  level.player disableinvulnerability();
  level.player freezecontrols(0);
  level.player showlegsandshadow();
  level.player playerenabletriggers();
  level.player scripts\common\utility::allow_cinematic_motion(1);
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  scripts\engine\sp\utility::autosave_by_name("drone_intro");
  level.heroes = scripts\sp\maps\lab\lab_util.gsc::rebuild_heroes_array();
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(level.heroes, scripts\engine\sp\utility::name_show);
  scripts\engine\utility::array_delete(var_2);
  level.tank2 setvehiclelookattext("Viper", &"");
  visionsetnaked("", 1.5);
  scripts\engine\utility::flag_set("introscreen_start_wait");
  setomnvar("ui_is_bink_skipping_enabled", 1);
}

drone_intro_cine_camera_settings(var_0) {
  var_0 thread scripts\engine\sp\utility::dof_enable_autofocus(12, 10, undefined, undefined);
  wait 8;
  level thread scripts\engine\sp\utility::dof_enable(2.4, 600);
  wait 4;
  level thread scripts\engine\sp\utility::dof_enable(2.4, 100, 1.5);
  wait 2;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 1, undefined, undefined, "tag_eye");
  wait 4;
  level.alex thread scripts\engine\sp\utility::dof_enable_autofocus(12, 1, undefined, undefined, "tag_eye");
  wait 5;
  level thread scripts\engine\sp\utility::dof_disable();
}

setup_bridge_missile() {
  var_0 = getEnt("bridge_missile", "targetname");
  var_0 scripts\engine\sp\utility::assign_animtree("missile");
  level.missle = var_0;
  return var_0;
}

setup_bridge_drone(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("veh8_mil_air_mquebec9_small");
  var_1 scripts\engine\sp\utility::assign_animtree("drone");
  return var_1;
}

spawn_bridge_badies(var_0) {
  var_1 = scripts\engine\sp\utility::array_spawn_targetname(var_0, 1, 1);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_4 setentitytarget(level.tank2);

    if(isDefined(var_4.animname)) {
      var_2[var_2.size] = var_4;
      var_4 thread bridge_guys_die();
    }
  }

  return var_2;
}

arm_player() {
  var_0[0] = scripts\sp\maps\lab\lab_util.gsc::make_bulletdrop_weapon();
  var_0[1] = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["ub_mike203_sp", "acog_west01_irons"]);
  var_1 = var_0[0];
  level.player giveweapon(var_0[0]);
  level.player giveweapon(var_0[1]);
  level.player setweaponammostock(var_0[0], 20);
  level.player givemaxammo(var_0[1]);
  level.player scripts\engine\sp\utility::give_offhand("flash");
  level.player givemaxammo("flash");
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player givemaxammo("frag");
  level.player switchtoweapon(var_1);
}

missile_logic(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel(var_0.model);
  var_1 hide();
  var_1 scripts\engine\sp\utility::assign_animtree("missile_light");
  var_1 thread scripts\sp\maps\lab\lab_lighting.gsc::drone_hero_lighting_on();
  var_2 = scripts\engine\utility::getStructArray("bridge_missles", "targetname");
  scripts\engine\utility::delaythread(24, ::bridge_crawlers);
  thread spawn_intro_trucks();
  level.tank2 scripts\engine\utility::delaythread(7.5, ::bridge_tank_shoots);
  thread scripts\common\anim::anim_single_solo(level.fakedrone, "bridge_scene");
  scripts\common\anim::anim_single([var_0, var_1, level.player_rig], "bridge_scene");
  scripts\engine\utility::delaythread(4, scripts\common\vehicle::spawn_vehicles_from_targetname_and_drive, "bridge_heli");
  level.fakedrone delete();
  var_3 = var_0.origin;
  level.player clearclienttriggeraudiozone(0.3);

  if(isDefined(var_3)) {
    level.player playSound("scn_lab_intro_explo_lr");
    level.player setclienttriggeraudiozone("lab_intro_post_explo", 1.0);
    level.player scripts\engine\utility::delaycall(1.0, ::clearclienttriggeraudiozone, 2.0);
    level.player viewkick(6, var_3, 0);
    earthquake(0.3, 1.5, level.player.origin, 400);
    playrumbleonposition("damage_heavy", level.player.origin);
    var_4 = getaiarrayinradius(var_0.origin, 1000, "axis");
    var_4 = scripts\engine\utility::array_remove_array(var_4, level.baddies);
    var_5 = scripts\engine\utility::get_array_of_closest(var_3, scripts\engine\sp\utility::getvehiclearray(), [level.tank2], undefined, 1200, 0);
    var_6 = scripts\engine\utility::array_combine(var_4, var_5);
    var_6 = scripts\engine\utility::array_removeundefined(var_6);

    foreach(var_8 in var_6)
    var_8 scripts\sp\utility::do_damage(var_8.health + 1, var_3, level.player, undefined, "MOD_EXPLOSIVE");

    foreach(var_11 in getscriptablearray("bridge_trees", "targetname"))
    var_11 setscriptablepartstate("base", "death");

    scripts\engine\utility::exploder("bridge_bomb");
  }

  level notify("delete_drone_light");
  visionsetnaked("lab_intro_sss", 3.55);
  var_0 delete();
  scripts\engine\utility::delaythread(12, scripts\engine\sp\utility::array_spawn_targetname, "bunker_runners", 1, 1);
  scripts\engine\utility::delaythread(10, ::scripted_bridge_shot);
  scripts\engine\utility::flag_set("bridge_move_up");
  scripts\engine\utility::flag_set_delayed("bridge_move_up_b", 6);
}

debris_logic() {
  var_0 = make_debris("debris_01", "debris_concrete_rubble_floor_slab_chunk_small_01");
  thread scripts\common\anim::anim_single_solo(var_0, "bridge_scene");
  var_1 = make_debris("debris_02", "debris_concrete_rubble_floor_slab_chunk_small_04");
  thread scripts\common\anim::anim_single_solo(var_1, "bridge_scene");
  var_2 = make_debris("debris_03", "debris_concrete_rubble_floor_slab_chunk_small_07");
  thread scripts\common\anim::anim_single_solo(var_2, "bridge_scene");
  return [var_0, var_1, var_2];
}

make_debris(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2 scripts\engine\sp\utility::assign_animtree(var_0);
  var_2 setModel(var_1);
  return var_2;
}

bridge_crawlers() {
  level.crawlers = scripts\engine\sp\utility::array_spawn_targetname("intro_enemies_crawl", 1, 1);
  level.crawlers[0] force_long_death_on_back_with_pistol_lab(3);
  level.crawlers[1] force_long_death_on_back_with_pistol_lab(3);
  level.crawlers[2] force_long_death_on_back_with_pistol_lab(1);
  level.crawlers[3] force_long_death_on_back_with_pistol_lab(4);
  level.crawlers[4] force_long_death_on_back_with_pistol_lab(1);
}

force_long_death_on_back_with_pistol_lab(var_0) {
  self.forcelongdeath = var_0;
  self.longdeathnoncombat = 1;
  scripts\engine\sp\utility::set_attackeraccuracy(1);
  self asmsetstate(self.asmname, "choose_long_death");
}

spawn_intro_trucks() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("intro_truck_1");
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("intro_truck_2");
  scripts\engine\utility::delaythread(1, scripts\common\vehicle_paths::gopath, var_0);
  scripts\engine\utility::delaythread(2, scripts\common\vehicle_paths::gopath, var_1);
}

bridge_tank_shoots() {
  wait 0.5;
  self.mainturret notify("stop_burst_fire_unmanned");
  scripts\vehicle\bromeo::mainturret_idle();
  var_0 = scripts\engine\utility::getStruct("bridge_tank_shoots", "targetname");
  self.mainturret.target_ent.origin = var_0.origin;
  self.mainturret settargetentity(self.mainturret.target_ent, scripts\engine\utility::randomvector(20));
  var_1 = gettime();

  while(gettime() < var_1 + 4000) {
    tank_shot();
    wait(0.1 + randomfloat(0.6));
  }
}

baddies_die() {
  self endon("death");

  if(isalive(self))
    scripts\engine\sp\utility::die();
}

bridge_guys_die() {
  scripts\common\ai::magic_bullet_shield();
  self.ragdoll_immediate = 1;
  self.allowdeath = 1;
  self waittillmatch("single anim", "end");
  scripts\common\ai::stop_magic_bullet_shield();
  self kill();
}

bridge_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_hill_friendlies();
  spawn_tank2();
  scripts\engine\sp\utility::set_start_location("bridge_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  arm_player();
  friendlies_on_bridge_move();
  scripts\engine\utility::flag_set("bridge_move_up");
  scripts\engine\utility::flag_set("bridge_move_up_b");
  scripts\engine\utility::flag_set("drone_scene_done");

  foreach(var_1 in getscriptablearray("bridge_trees", "targetname"))
  var_1 setscriptablepartstate("base", "death");
}

bridge_main() {
  scripts\sp\maps\lab\lab_util.gsc::rebuild_heroes_array();
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\utility::array_thread(level.heroes, scripts\engine\sp\utility::set_ignoresuppression, 1);
  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], scripts\engine\utility::disable_pain);
  var_0 = [level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5];
  scripts\engine\utility::array_thread(var_0, scripts\engine\sp\utility::enable_dynamic_run_speed, level.tank2, 125, 190, 250);
  scripts\engine\utility::delaythread(0.1, scripts\common\vehicle_paths::gopath, level.tank2);
  thread friendlies_end_of_bridge();
  thread vo_bridge();
  scripts\engine\utility::flag_wait("player_at_intro_checkpoint");
  thread scripts\engine\sp\utility::transient_unload("lab_drone_tr");
  scripts\engine\utility::delaythread(3, scripts\engine\sp\utility::autosave_by_name, "post_bridge_clear");
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_0, scripts\engine\sp\utility::disable_dynamic_run_speed);
  scripts\engine\utility::array_thread(level.heroes, scripts\engine\sp\utility::set_ignoresuppression, 0);
  thread scripts\sp\analytics::analytics_kleenex_update("hill_intro_stopwatch");
}

scripted_bridge_shot() {
  var_0 = scripts\engine\utility::getStruct("scripted_bridge_shot", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("fake_rebel_1", 1);
  var_2 = scripts\engine\sp\utility::spawn_targetname("fake_rebel_2", 1);
  var_1 bridge_guy_setup();
  var_2 bridge_guy_setup();
  scripts\engine\utility::flag_wait("scripted_bridge_shot");
  var_1 shoot_bridge_guy(var_0, 0.5);
  var_2 shoot_bridge_guy(var_0, 1.2);
}

bridge_guy_setup() {
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  self enableavoidance(0, 1);
}

shoot_bridge_guy(var_0, var_1) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  while(isDefined(self) && !scripts\engine\utility::within_fov(var_0.origin, var_0.angles, self getEye(), level.cos30))
    waitframe();

  wait(var_1);

  if(isDefined(self))
    magicbullet("iw8_sn_alpha50", var_0.origin, self getEye());
}

bridge_catchup() {
  var_0 = getEntArray("bridge_triggers", "targetname");
  thread scripts\engine\utility::array_delete(var_0);

  if(!scripts\sp\starts::is_after_start("lab_entrance")) {
    scripts\engine\utility::flag_set("player_at_intro_checkpoint");
    scripts\engine\utility::flag_set("post_bridge_shooting");
  }
}

friendlies_end_of_bridge() {
  scripts\engine\utility::flag_wait("bridge_tanks_stopped");
  thread tutorial_flood_init();
  var_0 = [level.price, level.farah, level.kyle];

  if(!scripts\engine\utility::flag("tank_proceed_1")) {
    scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_0, ::stop_following_ent);
    scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_intro_checkpoint");
  }

  var_0 = scripts\engine\utility::array_remove_array(level.heroes, var_0);
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_0, scripts\engine\sp\utility::enable_ai_color);
}

tunnel_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_hill_friendlies();
  spawn_tank2("tank_2_tunnel_node");
  scripts\engine\sp\utility::set_start_location("uphill_intro_tunnel_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  scripts\engine\sp\utility::array_spawn_targetname("post_bridge_gate_trucks", 1, 1);

  if(!scripts\engine\utility::flag("tank_proceed_1"))
    scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_intro_checkpoint");

  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], scripts\engine\utility::disable_pain);
}

tunnel_main() {
  scripts\engine\utility::array_thread(level.heroes, ::run_n_gun);
  thread remove_road_corner_ai_clip_watcher();
  thread fence_ai_clear();
  thread vo_drone_tutorial();
  thread start_the_drone_hint();
  ridge_tree_init();
  thread sfx_bottom_hill_trucks();
  scripts\engine\utility::flag_wait("tank_proceed_1");
  var_0 = thread scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("checkpoint_reinforcements_high_heli");
  scripts\engine\sp\utility::autosave_by_name("drone_tutorial_clear");
  var_1 = getnodearray("stop_1_nodes", "targetname");
  scripts\engine\utility::array_call(var_1, ::disconnectnode);
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(level.heroes, scripts\engine\sp\utility::set_ignoresuppression, 1);
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(level.heroes, scripts\sp\maps\lab\lab_util.gsc::toggle_ignore_all);
  scripts\engine\sp\utility::array_spawn_targetname("checkpoint_reinforcements_high_tower", 1, 1);
  thread friendlies_follow_tanks();
  scripts\engine\utility::delaythread(2.5, scripts\engine\sp\utility::activate_trigger_with_noteworthy, "push_tutorial_section");
  var_2 = scripts\engine\utility::array_remove_array(level.heroes, [level.price, level.farah, level.kyle]);
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_2, scripts\engine\utility::set_movement_speed, 130);
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_2, ::reset_speed_at_node);
  scripts\engine\utility::flag_wait("ridge_tanks_stopped");
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(level.heroes, scripts\sp\maps\lab\lab_util.gsc::toggle_ignore_all);

  if(!scripts\engine\utility::flag("tank_proceed_5"))
    scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.price, level.farah, level.kyle], ::stop_following_ent);

  scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_ridge_checkpoint");
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(level.heroes, scripts\engine\sp\utility::set_ignoresuppression, 0);
  thread checkpoint_ai_check("checkpoint_b_high_guys", 6, "tank_proceed_5", undefined, "player_past_stop_1");
  scripts\engine\utility::flag_wait("tank_proceed_5");
  var_1 = getnodearray("stop_2_nodes", "targetname");
  scripts\engine\utility::array_call(var_1, ::disconnectnode);

  if(!scripts\engine\utility::flag("tank_proceed_5_rush"))
    thread scripts\engine\sp\utility::array_spawn_targetname("hill_bottom_tree_enemies", 1, 1);

  thread enemy_sight_increased();
  scripts\engine\sp\utility::autosave_by_name("ridge_1_clear");
  thread friendlies_follow_tanks();
  scripts\engine\utility::delaythread(3, scripts\engine\sp\utility::activate_trigger_with_noteworthy, "squad_to_stop_3");
}

sfx_bottom_hill_trucks() {
  thread scripts\engine\utility::play_sound_in_space("scn_lab_hill_bottom_truck_driveins", (10402, 5853, -1186));
}

tutorial_flood_init() {
  wait 2;

  if(scripts\engine\utility::flag("stop_tut_floods")) {
    return;
  }
  var_0 = getspawnerarray("tutorial_flood");

  foreach(var_2 in var_0)
  var_2 thread tut_flood();

  scripts\engine\utility::flag_wait("stop_tut_floods");

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      if(isDefined(var_2.guy))
        var_2.guy delete();

      var_2 delete();
    }
  }
}

tut_flood() {
  self endon("death");
  level endon("stop_tut_floods");
  self.count = self.count + 1;
  var_0 = scripts\engine\sp\utility::spawn_ai();

  while(isDefined(self) && !scripts\engine\utility::flag("stop_tut_floods")) {
    if(isDefined(var_0)) {
      self.count = self.count + 1;
      self.guy = var_0;
      var_0 endon("entitydeleted");
      var_0 waittill("death");
      wait 1;

      while(scripts\sp\maps\lab\lab_util.gsc::in_player_fov(level.cos30, self.origin, [level.player]))
        wait 0.15;

      var_0 = self stalingradspawn();
      continue;
    }

    wait 1;
  }
}

tunnel_catchup() {
  if(!scripts\sp\starts::is_after_start("lab_entrance"))
    thread scripts\sp\maps\lab\lab_vo_util.gsc::init_drone_vo();

  scripts\engine\utility::flag_set("tank_proceed_1");
  scripts\engine\utility::flag_set("tank_proceed_5");
  scripts\engine\utility::flag_set("player_past_stop_1");
}

start_the_drone_hint() {
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_drone_tutorial_intro_60");
  scripts\engine\utility::flag_set("start_green_beam_instruct");

  if(!isDefined(level.last_beam_time))
    level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_uavoperator_drone_tutorial_laseconf_ready_20", 0, 2);

  thread scripts\sp\maps\lab\lab_vo_util.gsc::init_drone_vo();
}

ridge_tree_init() {
  var_0 = getscriptablearrayinradius("spruce_tree", "targetname", (10045.7, 3912.01, -729.359), 400);

  foreach(var_2 in var_0)
  var_2 thread ridge_tree_logic();
}

ridge_tree_logic() {
  level endon("tank_proceed_5");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_2, var_3, var_2, var_2, var_2, var_2, var_2);

    if(var_0 < 49) {
      continue;
    }
    if(isDefined(level.tank2) && scripts\engine\utility::is_equal(level.tank2.mainturret, var_1) && var_0 >= 380 || isDefined(var_3) && (isexplosivedamagemod(var_3) && var_0 >= 50))
      self setscriptablepartstate("base", "death");
  }
}

remove_node_clip(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1)
  var_3 connectpaths();
}

fence_ai_clear() {
  scripts\engine\sp\utility::waittill_ai_group_dead("fence_enemies");
  scripts\engine\utility::flag_set("tank_proceed_1");
}

vo_drone_tutorial() {
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_drone_tutorial_intro_10");
  scripts\engine\utility::flag_wait("tank_proceed_1");
  wait 2;
  level scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_drone_tutorial_intro_20");
}

reset_speed_at_node() {
  self endon("death");
  wait 3;
  self waittill("goal");
  scripts\common\utility::clear_movement_speed();
}

spawn_tank2(var_0) {
  var_1 = 0;
  var_2 = scripts\common\utility::getvehiclespawner("convoy_tank_2", "targetname");

  if(isDefined(var_0)) {
    var_2.target = var_0;
    var_1 = 1;
  }

  var_3 = getEntArray("tank2_follow_spots", "targetname");

  foreach(var_6, var_5 in var_3) {
    var_5.tovehiclevector = var_5.origin - var_2.origin;
    var_5.tovehiclelocaloffset = rotatevectorinverted(var_5.tovehiclevector, var_2.angles);
  }

  var_7 = getEntArray("tank_poi", "script_noteworthy");

  foreach(var_6, var_5 in var_7) {
    var_5.tovehiclevector = var_5.origin - var_2.origin;
    var_5.tovehiclelocaloffset = rotatevectorinverted(var_5.tovehiclevector, var_2.angles);
  }

  level.tank2 = scripts\common\vehicle::spawn_vehicle_from_targetname("convoy_tank_2");
  level.tank2 scripts\engine\utility::ent_flag_init("ready_to_turn_left");
  level.tank2 scripts\engine\utility::ent_flag_init("end_of_the_line");
  level.tank2 scripts\engine\utility::ent_flag_init("reset_shooting");
  waitframe();

  foreach(var_6, var_5 in var_3) {
    var_10 = rotatevector(var_5.tovehiclelocaloffset, level.tank2.angles);
    var_5.origin = level.tank2.origin + var_10;
    var_5 linkTo(level.tank2);
  }

  level.tank2.follow_ents = var_3;

  foreach(var_6, var_5 in var_7) {
    var_10 = rotatevector(var_5.tovehiclelocaloffset, level.tank2.angles);
    var_5.origin = level.tank2.origin + var_10;
    var_5 linkTo(level.tank2);

    if(isDefined(var_5.script_linkname)) {
      switch (var_5.script_linkname) {
        case "farah":
          level.tank2.farah_poi = var_5;
          break;
        case "kyle":
          level.tank2.kyle_poi = var_5;
          break;
        default:
          level.tank2.price_poi = var_5;
          break;
      }
    }
  }

  level.vehicle.templates.deathmodel["veh8_mil_lnd_bromeo"] = "veh8_mil_lnd_bromeo_animated_dst";

  if(var_1)
    scripts\engine\utility::delaythread(0.1, scripts\common\vehicle_paths::gopath, level.tank2);

  level.tank2 setvehiclelookattext("Viper", &"");
  level.tank2 childthread tank_shooting_logic();

  if(!scripts\engine\sp\utility::is_default_start())
    level.tank2 thread tank_engine_sfx();

  level.tank2 scripts\engine\sp\utility::assign_animtree("tank_2");
}

player_behind_tank_think() {
  player_behind_tank_think_internal();
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
}

player_behind_tank_think_internal() {
  var_0 = 1;

  while(isDefined(self)) {
    var_1 = scripts\engine\math::is_point_in_front(level.player.origin);

    if(var_1 && !var_0)
      level.player scripts\sp\utility::set_player_attacker_accuracy(1);
    else if(!var_1 && var_0)
      level.player scripts\sp\utility::set_player_attacker_accuracy(0.3);

    var_0 = var_1;
    waitframe();
  }
}

friendly_tank_force_target(var_0, var_1) {
  scripts\vehicle\bromeo::mainturret_idle();
  self.mainturret settargetentity(var_0, (0, 0, 30));

  while(isalive(var_0) && !is_aimed_at_target(var_0))
    wait 0.1;

  if(!isalive(var_0)) {
    return;
  }
  var_2 = -15;
  var_3 = 15;
  var_4 = randomintrange(4, 6);

  for(var_5 = 0; var_5 < var_4; var_5++) {
    if(!isalive(var_0)) {
      break;
    }

    if(istrue(var_1) && var_5 > 2 && isalive(var_0))
      var_0 kill();

    self.mainturret settargetentity(var_0, (0, 0, 30) + scripts\engine\utility::randomvectorrange(var_2, var_3));
    tank_shot();
    wait(0.4 + randomfloat(0.15));
  }

  scripts\vehicle\bromeo::mainturret_attack();
}

friendly_nav_repulsor(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 180);

  if(var_0)
    createnavrepulsor("tank " + self getentitynumber(), -1, self, var_2, 1);
  else if(!var_0)
    destroynavrepulsor("tank " + self getentitynumber());
}

tank_interact() {
  for(;;) {
    self waittillmatch("noteworthy", "interact");
    scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 64), &"LAB/CURSOR_MOVEUP", undefined, 1024, 1000, 1);
    scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "trigger");
    level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, self.currentnode.script_flag_wait);
    scripts\engine\sp\utility::do_wait_any();
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    scripts\engine\utility::flag_set(self.currentnode.script_flag_wait);
  }
}

tank_engine_sfx() {
  self endon("death");
  self vehicle_turnengineon();

  for(;;) {
    self playSound("veh_bradley_engine_stop");
    wait 0.5;
    self stoploopsound("veh_bradley_engine_lp");

    if(!isDefined(self.idle_sfx)) {
      self.idle_sfx = spawn("script_origin", self.origin);
      self.idle_sfx linkTo(self);
    }

    self.idle_sfx scripts\engine\sp\utility::sound_fade_in("veh_bradley_idle_lp", 1, 1, 1);

    while(self vehicle_getspeed() < 1)
      wait 0.2;

    self playSound("veh_bradley_engine_start");

    if(isDefined(self.idle_sfx))
      self.idle_sfx scripts\engine\sp\utility::sound_fade_and_delete(1, 1);

    wait 1.5;
    self playLoopSound("veh_bradley_engine_lp");

    while(self vehicle_getspeed() > 1)
      wait 0.2;
  }
}

player_fullads() {
  return level.player playerads() == 1;
}

player_zoomingsniper() {
  return level.player meleeButtonPressed() && player_fullads() && level.player scripts\sp\maps\lab\lab_util.gsc::using_bulletdrop_weapon();
}

hill_bottom_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("hill_bottom_start_struct", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  spawn_tank2("hill_bottom_start_2");
  thread enemy_sight_increased();
  thread scripts\engine\sp\utility::array_spawn_targetname("hill_bottom_tree_enemies", 1, 1);
  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], scripts\engine\utility::disable_pain);
}

hill_bottom_main() {
  scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\maps\lab\lab_util.gsc::allies_molotov_toggle, 1);
  var_0 = [level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5];
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_0, scripts\sp\maps\lab\lab_util.gsc::allies_molotov_toggle, 1);
  thread scripts\sp\maps\lab\lab_util.gsc::wind_setdirection("south", (-30, -80, 0), 4000);
  thread vo_hill_charge();
  scripts\sp\player_death::set_custom_death_quote(70);
  thread vo_hill_bottom();
  thread friendlies_follow_tanks();
  scripts\engine\utility::flag_wait("ridge_2_tanks_stopped");
  thread checkpoint_ai_check("tree_ledge_truckers", 6, "tank_proceed_6", "woods_fallback", "player_past_stop_2");
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_stop_4");
  scripts\engine\utility::array_thread([level.price, level.kyle, level.farah], ::stop_following_ent);
  scripts\engine\utility::flag_wait("tank_proceed_6");
  var_1 = getnodearray("stop_3_nodes", "targetname");
  scripts\engine\utility::array_call(var_1, ::disconnectnode);
  scripts\engine\utility::delaythread(8, scripts\engine\sp\utility::activate_trigger_with_noteworthy, "squad_to_stop_5");
  var_2 = scripts\common\vehicle::spawn_vehicle_from_targetname("hill_bottom_heli");
  thread scripts\common\vehicle_paths::gopath(var_2);
  scripts\engine\sp\utility::autosave_by_name("tank_3_stop");
  thread friendlies_follow_tanks();
  scripts\engine\utility::flag_wait("ridge_3_tanks_stopped");
  scripts\engine\utility::array_thread([level.price, level.kyle, level.farah], ::stop_following_ent);
  thread checkpoint_ai_check("hill_cliff_car_guys", 3, "tank_proceed_7", "bunker_fallback", "player_past_stop_3");
  scripts\engine\utility::flag_wait("tank_proceed_7");
  var_1 = getnodearray("stop_4_nodes", "targetname");
  scripts\engine\utility::array_call(var_1, ::disconnectnode);
  scripts\engine\sp\utility::autosave_by_name("tank_4_stop");
  thread friendlies_follow_tanks();
  scripts\engine\utility::flag_wait_any("midhill_guys", "woods_fallback");
  scripts\engine\utility::delaythread(10, scripts\engine\sp\utility::array_spawn_targetname, "hill_charge_rpg", 1, 1);
  scripts\engine\sp\utility::array_spawn_targetname("midhill_guys_lot_1", 0, 1);
  thread tank_rpg_death();
  scripts\engine\utility::flag_wait("hill_mid_tank_stopped");
  var_3 = 0;
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.price, level.kyle, level.farah], scripts\engine\sp\utility::enable_ai_color);

  if(!scripts\engine\utility::flag("player_past_stop_4")) {
    scripts\engine\utility::array_thread([level.price, level.kyle, level.farah], ::stop_following_ent);
    scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_stop_6");
    var_3 = 1;
  }

  scripts\engine\utility::flag_wait_all("go_left", "player_past_stop_4");

  if(!istrue(var_3))
    scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.price, level.kyle, level.farah], ::stop_following_ent);

  scripts\engine\sp\utility::activate_trigger_with_noteworthy("tank_death_color");
  scripts\engine\utility::flag_set("tank_proceed_8");
  var_1 = getnodearray("stop_5_nodes", "targetname");
  scripts\engine\utility::array_call(var_1, ::disconnectnode);
  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], scripts\engine\utility::enable_pain);
}

hill_bottom_catchup() {
  scripts\engine\utility::flag_set("hill_charge_started");
  scripts\engine\utility::flag_set("go_left");
  scripts\engine\utility::flag_set("tank_1_last_stop");
  thread remove_road_corner_ai_clip();

  if(!scripts\sp\starts::is_after_start("hill_top"))
    scripts\engine\sp\utility::add_global_spawn_function("allies", scripts\sp\maps\lab\lab_util.gsc::allies_molotov_toggle, 1);
}

checkpoint_ai_check(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_2);
  wait 1;
  var_5 = gettime() + 40000;

  while(scripts\engine\sp\utility::get_ai_group_death_count(var_0) < var_1 && gettime() < var_5)
    wait 0.5;

  if(isDefined(var_4))
    scripts\engine\utility::flag_wait(var_4);

  if(isDefined(var_3))
    scripts\engine\utility::flag_set(var_3);

  wait 5;
  scripts\engine\utility::flag_set(var_2);
}

heli_crash_swap() {
  level endon("hill_finished_trig");
  var_0 = getEntArray("crash_script_models", "targetname");
  var_1 = getEnt("heli_clip", "targetname");
  var_2 = getEnt("burnt_terrain_patch", "targetname");
  var_3 = getEnt("pristine_terrain_patch", "targetname");
  var_2 connectpaths();
  var_4 = scripts\engine\utility::array_combine(var_0, [var_1], [var_2]);
  scripts\engine\utility::flag_wait("hill_crash_site");
  var_3 hide();
  var_3 notsolid();
  var_1 solid();
  var_2 solid();

  foreach(var_6 in var_4)
  var_6 show();
}

vo_hill_charge() {
  wait 1;
  var_0 = 0;

  if(isDefined(level._ai_group["checkpoint_b_high_guys"]) && isDefined(level._ai_group["checkpoint_b_high_guys"].ai)) {
    foreach(var_2 in level._ai_group["checkpoint_b_high_guys"].ai) {
      if(isalive(var_2))
        var_0 = 1;
    }
  }

  if(var_0)
    level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_pipes_outdoor_callout_machineguns_70");
  else
    level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_drone_tutorial_transition_10");

  tank_moveup_nag("tank_proceed_6");
  wait 1.5;
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_bottom_charge_10");
  level.farah scripts\engine\utility::waittill_notify_or_timeout("weapon_fired", 5);
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_hill_bottom_charge_20");
  var_4 = sortbydistance(getaiarray("allies"), level.player.origin);
  var_5 = scripts\engine\sp\utility::create_deck(["dx_vom_fsa1_hill_bottom_charge_30", "dx_vom_fsa2_hill_bottom_charge_40", "dx_vom_fsa3_hill_bottom_charge_50"]);

  foreach(var_7 in var_4) {
    if(var_7 == level.price || var_7 == level.farah || var_7 == level.kyle) {
      continue;
    }
    var_7 thread scripts\sp\maps\lab\lab_vo_util.gsc::say(var_5 scripts\engine\sp\utility::deck_draw());
    wait(randomfloatrange(0.05, 0.15));
  }

  scripts\engine\utility::flag_wait("tank_proceed_7");
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_bottom_charge_14");
  wait 1;
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_bottom_charge_13");
  wait 8;
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_hill_bottom_charge_21");
  wait 1;
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_hill_bottom_charge_22");
  scripts\engine\utility::flag_wait("tank_proceed_8");
  wait 8;
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_hill_bottom_charge_23");
  wait 1;
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_hill_bottom_charge_24");
  wait 8;
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_bottom_charge_11");
  wait 1;
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_bottom_charge_12");
}

high_tower_guys_cleanup() {
  var_0 = getEntArray("tut_tower_volumes", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\sp\utility::get_ai_touching_volume();

    if(var_4.size)
      var_1 = scripts\engine\utility::array_combine(var_4, var_1);
  }

  if(var_1.size)
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_1, 600);
}

remove_road_corner_ai_clip_watcher() {
  scripts\engine\utility::flag_wait("remove_corner_clip");
  remove_road_corner_ai_clip();
}

remove_road_corner_ai_clip() {
  var_0 = getEntArray("corner_ai_clip", "targetname");

  if(!isDefined(var_0) || !isarray(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_2 delete();
  }
}

vo_hill_bottom() {
  scripts\engine\utility::flag_wait("go_left");
  wait 4;
  level.kyle scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_kyle_hill_bottom_callout_rpg_100", 1, 1);
}

turret_operator() {
  self endon("death");
  thread scripts\common\ai::magic_bullet_shield();
  self.damage_functions[self.damage_functions.size] = ::turret_owner_damage_func;
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_0 = self getturret();
    waitframe();
  }

  self notify("stop_using_built_in_burst_fire");
  var_0 setturretteam("axis");
  var_0 setrightarc(180);
  var_0 setleftarc(180);
  var_0 setbottomarc(180);
  var_0 settoparc(180);
  var_0 setconvergencetime(0.05, "yaw");
  var_0 setconvergencetime(0.05, "pitch");
  var_0.accuracy = 0.9;
  var_0.maxrange = 50000;
  var_0.aispread = 0;
  var_0 setmode("manual_ai");
  var_0.health = 99999;
  var_0 childthread turret_logic(self);
  scripts\engine\utility::flag_wait("tank_1_last_stop");
  scripts\sp\spawner::stop_using_turret();
  self.goalradius = 250;
}

turret_logic(var_0) {
  level endon("tank_death");
  wait 6;

  for(;;) {
    var_1 = undefined;
    var_2 = 0;

    if(isDefined(level.corner_redshirts)) {
      foreach(var_4 in level.corner_redshirts) {
        if(isalive(var_4)) {
          var_2 = 1;
          var_4.health = 10;
          var_1 = var_4;
        }
      }
    } else if(randomint(100) < 60)
      var_1 = level.player;
    else {
      foreach(var_4 in level.heroes) {
        if(!isDefined(var_4.magic_bullet_shield)) {
          var_1 = var_4;
          break;
        }
      }
    }

    if(!isalive(var_1)) {
      waitframe();
      continue;
    }

    self settargetentity(var_1);
    var_8 = randomintrange(30, 50);
    var_9 = var_1.health;

    for(var_10 = 0; var_10 < var_8; var_10++) {
      if(!isalive(var_1)) {
        break;
      }

      self settargetentity(var_1);

      if(var_2) {
        var_11 = 1;
        var_12 = 2;
      } else if(isPlayer(var_1) && shouldshootplayer()) {
        var_11 = 16;
        var_12 = 18;
      } else {
        var_11 = 18;
        var_12 = 23;
      }

      magicbullet("iw8_lm_pkilo", self gettagorigin("tag_flash"), var_1 getEye() + scripts\engine\utility::randomvectorrange(var_11, var_12));
      wait(0.05 + randomfloat(0.15));
    }

    wait(2 + randomfloat(1));
  }
}

turret_owner_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && var_1 == level.player)
    scripts\sp\maps\lab\lab_util.gsc::stop_magic_bullet_safe();
}

hill_mid_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("hill_mid_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  spawn_tank2("hill_mid_start_node");
  thread enemy_sight_increased();
  scripts\engine\utility::flag_set("tank_death");
  wait 1;
  thread kill_the_tank();
  wait 0.1;
  level.follow_ent = level.player;
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.price, level.farah, level.kyle, level.rebel_1], scripts\sp\maps\lab\lab_util.gsc::ai_movement_control, level.follow_ent, 800, 500);
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5], scripts\sp\maps\lab\lab_util.gsc::ai_movement_control, level.follow_ent, 600, 500);
}

hill_mid_main() {
  thread vo_hill_mid();
  thread hill_mid_spawning();
  scripts\engine\sp\utility::autosave_by_name("hill_mid");
  scripts\engine\utility::flag_wait_any("tank_death", "spawn_hilltop_heli");
  scripts\sp\player_death::clear_custom_death_quote();
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("hill_mid_heli");
  thread scripts\common\vehicle_paths::gopath(var_0);
  var_0 thread heli_done_unloading();
}

hill_mid_spawning() {
  level endon("hill_fallback_2");
  level endon("hilltop_heli_spawned");
  scripts\engine\utility::flag_wait("tank_death");

  if(level.player.origin[0] < 5600)
    var_0 = "midhill_right";
  else
    var_0 = "midhill_left";

  if(var_0 == "midhill_right")
    var_1 = ["midhill_guys_right", "midhill_guys_leftback", "midhill_guys_back_right"];
  else
    var_1 = ["midhill_guys_left", "midhill_guys_back_right", "midhill_guys_leftback"];

  foreach(var_6, var_3 in var_1) {
    while(getaiarray("axis").size >= 10)
      waitframe();

    var_4 = scripts\engine\sp\utility::array_spawn_targetname(var_3, 0, 1);
    var_5 = gettime() + 40000;

    while(getaiarray("axis").size > 10 && gettime() < var_5)
      waitframe();

    if(var_6 >= 1 && gettime() < var_5) {
      if(level.gameskill < 3)
        scripts\engine\sp\utility::autosave_by_name("wave_killed");
    }
  }
}

hill_mid_move_up_nag() {
  if(scripts\engine\utility::flag("midhill_left") || scripts\engine\utility::flag("midhill_right")) {
    return;
  }
  level endon("midhill_left");
  level endon("midhill_right");
  wait 10;
  var_0 = ["dx_vom_pri_hill_mid_halfway_20", "dx_vom_pri_hill_mid_halfway_30", "dx_vom_pri_hill_mid_halfway_40"];
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::nagtill(undefined, var_0, 8);
}

vo_hill_mid() {
  scripts\engine\utility::flag_wait_any("midhill_left", "midhill_right");
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_mid_halfway_10");
  scripts\engine\utility::flag_wait("tank_proceed_10");
  scripts\sp\maps\lab\lab_vo_util.gsc::hill_pa_chatter_say("dx_vom_bkv_hill_top_arrival_20");
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_top_arrival_30", 1);
  scripts\sp\maps\lab\lab_vo_util.gsc::hill_pa_chatter_say("dx_vom_bkv_hill_top_arrival_40", 1);
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_hill_top_arrival_50", 1);
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_top_arrival_60", 1);
  scripts\sp\maps\lab\lab_vo_util.gsc::hill_pa_chatter_say("dx_vom_bkv_hill_top_arrival_70", 1);
  thread hill_mid_move_up_nag();
}

heli_done_unloading() {
  scripts\engine\utility::waittill_any("unloaded", "death");
  scripts\engine\utility::flag_set("hillmid_helis_unloaded");
}

friendlies_follow_tanks() {
  while(!isDefined(level.tank2) || !isDefined(level.tank2.follow_ents))
    waitframe();

  var_0 = [level.farah, level.kyle, level.price];
  var_1 = level.tank2.follow_ents;

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!isDefined(var_3.my_tank_node))
      var_3.my_tank_node = var_3 scripts\sp\maps\lab\lab_util.gsc::get_my_node(var_1);

    var_3 thread follow_ent(var_3.my_tank_node);
    var_1 = scripts\engine\utility::array_remove(var_1, var_3.my_tank_node);
  }
}

follow_ent(var_0) {
  self endon("stop_following_ent");
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  while(distance2dsquared(self.origin, var_0.origin) < 6400)
    waitframe();

  self allowedstances("stand");
  self.og_goalradius = self.goalradius;
  scripts\engine\sp\utility::disable_ai_color();
  self.goalradius = 10;
  self.follow_ent = var_0;
  self cleargoalvolume();
  self setgoalpos(var_0.origin);
  self setgoalentity(var_0, 1000);
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  self.og_attackeraccuracy = self.attackeraccuracy;
  self.attackeraccuracy = 0.05;
  base_tank_ai_speed(var_0);
  scripts\common\ai::disable_arrivals();
  self enableavoidance(0, 1);

  switch (self.script_noteworthy) {
    case "farah":
      thread scripts\common\ai::poi_enable(1);
      break;
    case "kyle":
      thread scripts\common\ai::poi_enable(1);
      break;
    default:
      thread scripts\common\ai::poi_enable(1);
      break;
  }
}

base_tank_ai_speed(var_0) {
  var_1 = 300;
  var_2 = 200;
  var_3 = -100;
  var_4 = 20;
  var_5 = 150;
  var_6 = 250;
  thread scripts\engine\sp\utility::enable_dynamic_run_speed(var_0, var_4, var_5, var_6, var_1, var_2, var_3);
}

stop_following_ent() {
  self notify("stop_following_ent");
  self allowedstances("stand", "crouch", "prone");

  if(isDefined(self.my_tank_node))
    self setgoalpos(self.my_tank_node.origin);
  else
    self setgoalpos(self.origin);

  if(isDefined(self.og_goalradius))
    self.goalradius = self.og_goalradius;

  self.follow_ent = undefined;
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\sp\utility::set_ignoresuppression(0);

  if(isDefined(self.og_attackeraccuracy))
    self.attackeraccuracy = self.og_attackeraccuracy;
  else
    self.attackeraccuracy = 1;

  scripts\engine\sp\utility::disable_dynamic_run_speed();
  scripts\common\utility::clear_movement_speed();
  scripts\common\ai::enable_arrivals();

  if(isDefined(level.poi_activeai))
    scripts\common\ai::poi_enable(0);

  self enableavoidance(1, 1);
}

tank_rpg_death() {
  scripts\engine\utility::flag_wait("tank_1_last_stop");
  thread kill_tower_ladders();
  scripts\engine\utility::flag_wait("hill_weapons_lower");
  level.tank2 scripts\engine\utility::ent_flag_wait_or_timeout("end_of_the_line", 3);
  var_0 = gettime() + 10000;
  var_1 = [level.price, level.kyle, level.farah, level.tank2, level.player];

  while(!scripts\engine\utility::flag("tank_death_timeout") && !scripts\sp\maps\lab\lab_util.gsc::in_player_fov(level.cos30, level.tank2.origin + anglesToForward(level.tank2.angles) * -50, var_1) && gettime() < var_0)
    waitframe();

  var_2 = scripts\engine\utility::getStruct("rpg_impact", "targetname");
  var_3 = scripts\engine\utility::getStruct("tank_rpg_impact_start", "targetname");
  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  level.tank1_rpg_guys = scripts\engine\sp\utility::array_spawn_targetname("tank1_rpg_guys", 1, 1);
  var_5 = magicbullet("iw8_la_rpapa7_straight_ai", var_3.origin, var_4.origin);
  level.tank2 vehicle_cleardrivingstate();
  scripts\engine\utility::flag_set("tank_death");
  scripts\engine\sp\utility::remove_global_spawn_function("axis", scripts\sp\maps\lab\lab_util.gsc::axis_grenade_toggle);
  scripts\engine\utility::array_thread(getaiarray("axis"), scripts\sp\maps\lab\lab_util.gsc::axis_grenade_toggle, 1);

  while(isDefined(var_5) && distance2d(var_5.origin, level.tank2.origin) > 100)
    waitframe();

  thread kill_the_tank();
  wait 0.8;
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
  scripts\engine\sp\utility::autosave_by_name("tank_death");
  level.follow_ent = level.player;
  thread monitor_ai_movement_vol();
  wait 0.2;
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_bottom_callout_apcdestroyed_ally1_30", 1, 1);
}

kill_the_tank() {
  level.tank2.godmode = 0;
  level.tank2 scripts\sp\utility::do_damage(level.tank2.health + 10000, level.tank2.origin, undefined, undefined, "MOD_EXPLOSIVE");
  waitframe();
  level.tank2 scripts\common\anim::anim_single_solo(level.tank2, "tank_death");
}

monitor_ai_movement_vol() {
  var_0 = getEnt("hero_follow_volume", "targetname");
  var_1 = getEnt("hill_tower_vol", "targetname");
  var_2 = 0;
  scripts\engine\utility::flag_wait("tank_1_last_stop");

  while(!scripts\engine\utility::flag("hill_finished_trig")) {
    var_3 = ai_should_follow_check(var_0, var_1);

    if(!var_2 && var_3) {
      level.follow_ent = level.player;
      scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.price, level.farah, level.kyle, level.rebel_1], scripts\sp\maps\lab\lab_util.gsc::ai_movement_control, level.follow_ent, 800, 500);
      scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5], scripts\sp\maps\lab\lab_util.gsc::ai_movement_control, level.follow_ent, 400, 500);
    } else if(var_2 && !var_3) {
      level.follow_ent = undefined;
      scripts\engine\utility::array_thread(level.heroes, scripts\sp\maps\lab\lab_util.gsc::stop_ai_movement_control);
    }

    var_2 = var_3;
    wait 1;
  }
}

ai_should_follow_check(var_0, var_1) {
  if(level.player istouching(var_0) && !level.player istouching(var_1))
    return 1;
  else
    return 0;
}

hill_lot_enemies_seek() {
  while(scripts\engine\sp\utility::get_ai_group_count("hill_lot_guys") >= 2)
    wait 0.1;

  var_0 = scripts\engine\sp\utility::get_ai_group_ai("hill_lot_guys");

  foreach(var_2 in var_0)
  var_2 setgoalentity(level.player);
}

hill_mid_catchup() {
  scripts\engine\utility::flag_set("tank_proceed_10");
  scripts\engine\utility::flag_set("hill_fallback_1");
}

hill_top_start() {
  scripts\sp\maps\lab\lab_util.gsc::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("hilltop_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  thread enemy_sight_increased();
  scripts\engine\utility::flag_set("tank_death_timeout");
  level.follow_ent = level.player;
  thread monitor_ai_movement_vol();
}

hill_top_main() {
  thread vo_hill_top();
  scripts\engine\sp\utility::autosave_by_name("hill_top");
  thread hill_lot_enemies_seek();
  thread last_hill_enemies_dead();
  thread track_player_rpg();
  scripts\engine\sp\utility::flagwaitthread("spawn_hilltop_heli", ::spawn_hilltop_heli);
  var_0 = getEnt("gl_intro_door", "script_noteworthy");
  var_0 thread scripts\sp\maps\lab\lab_turbines.gsc::lab_door_prompt();
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("hilltop_tower_guys", 1, 1);
  scripts\engine\utility::flag_wait("hill_finished_trig");
  scripts\sp\maps\lab\lab_util.gsc::array_thread_safe([level.rebel_1, level.rebel_2, level.rebel_3], scripts\common\ai::magic_bullet_shield);
  var_2 = getEntArray("hilltop_placed_rpg", "targetname");
  scripts\engine\utility::array_thread(var_2, ::rpg_respawning);
}

nag_kill_hiltop_heli() {
  if(scripts\engine\utility::flag("hilltop_heli_dead")) {
    return;
  }
  level endon("hilltop_heli_dead");
  wait 30;
  var_0 = ["dx_vom_pri_hill_top_helicopter_10", "dx_vom_pri_hill_top_helicopter_20", "dx_vom_pri_hill_top_helicopter_30", "dx_vom_pri_hill_top_helicopter_40"];
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::nagtill("hilltop_heli_dead", var_0, 15, 3, 1.5, 1.1, 35, 5);
}

vo_clear_carpark() {
  if(scripts\engine\utility::flag("hill_finished_trig")) {
    return;
  }
  level endon("hill_finished_trig");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util.gsc::hill_pa_chatter_say("dx_vom_bkv_hill_top_helicopter_60");
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_hill_top_helicopter_70");
  level.farah scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_far_hill_top_helicopter_80");
  level.price scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_top_carpark_10");
  scripts\engine\utility::flag_wait("hill_finished_trig");
}

vo_hill_top() {
  scripts\engine\utility::flag_wait("hilltop_heli_spawned");
  nag_kill_hiltop_heli();
  vo_clear_carpark();
  scripts\sp\maps\lab\lab_vo_util.gsc::wait_combat_cooldown(0.8, 4);
  level.player scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_alx_hill_top_carpark_30");
  scripts\engine\utility::delaythread(0.5, scripts\sp\equipment\green_beam::take_green_beam, 1);
  level.vo_callouts = undefined;
}

rpg_respawning() {
  if(scripts\engine\utility::flag("hilltop_heli_dead"))
    return;
  else
    level endon("hilltop_heli_dead");

  var_0 = cos(65);
  var_1 = self;
  var_2 = self.classname;
  var_3 = self.spawnflags;

  for(;;) {
    var_4 = var_1.origin;
    var_5 = var_1.angles;
    var_1 waittill("trigger");
    wait 1;

    while(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_4, var_0))
      wait 1;

    var_1 = spawn(var_2, var_4, 0);
    var_1 itemweaponsetammo(weaponclipsize(var_1), weaponmaxammo(var_1));
  }
}

spawn_hilltop_heli() {
  level.hilltop_heli = scripts\common\vehicle::spawn_vehicle_from_targetname("hilltop_littlebird");
  level.hilltop_heli thread little_bird_spawnfunc();
  thread scripts\engine\sp\utility::array_spawn_targetname("hilltop_final_wave", 1, 1);
}

hill_top_catchup() {
  scripts\engine\utility::flag_set("hill_finished_trig");
}

last_hill_enemies_dead() {
  scripts\engine\utility::flag_wait("hilltop_heli_dead");
  wait 5;
  var_0 = 0;

  for(;;) {
    var_1 = getaiarray("axis");

    if(!var_1.size) {
      break;
    }

    if(var_1.size < 6 && var_0 == 0) {
      scripts\engine\utility::flag_set("hill_top_fallback");
      childthread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var_1, 1000);
      var_0++;
    }

    if(var_1.size < 3 && var_0 == 1) {
      if(var_1.size == 2)
        level.price thread scripts\sp\maps\lab\lab_vo_util.gsc::say_as_chatter("dx_vom_pri_hill_top_carpark_20");

      scripts\sp\maps\lab\lab_util.gsc::array_thread_safe(var_1, scripts\sp\utility::player_seek_enable);
      var_0++;
    }

    wait 1;
  }

  thread scripts\engine\sp\utility::autosave_by_name("hill_clear");
  childthread scripts\engine\sp\utility::ai_delete_when_out_of_sight(getaiarray("axis"), 1000);
  level notify("clear_flood_wait");
  level notify("hilltop_heli_dead");
  scripts\engine\utility::flag_set("hill_finished_trig");
  wait 3;
}

tank_stop_for_allies_think() {
  self endon("death");
  var_0 = 300;
  var_1 = 170;
  var_2 = 230;
  var_3 = 130;
  var_4 = 50;
  var_5 = 30;
  var_6 = 0;

  for(;;) {
    waitframe();
    var_7 = scripts\engine\sp\utility::worldtolocalcoords(level.player.origin);
    var_8 = abs(var_7[1]) / (var_0 / 2);
    var_8 = max(scripts\engine\math::remap(var_8, var_1 / var_0, 1, 0, 1), 0);
    var_9 = (var_7[0] - var_5) / var_2;

    if(var_8 < 1 && var_9 < 1 && var_9 > 0) {
      if(var_7[0] > var_5 + var_4)
        var_9 = max(scripts\engine\math::remap(var_9, var_3 / var_2, 1, 0, 1), 0);
      else
        var_9 = max(scripts\engine\math::remap(1 - var_9, (var_2 - var_4) / var_2, 1, 0, 1), 0);

      var_10 = max(var_8, var_9);

      if(!isDefined(self.vehicle_stop_named) || !self.vehicle_stop_named.size) {
        var_11 = 100 * (1 - var_10);
        self vehicle_setspeed(level.tank2.currentnode.speed * 0.1 * var_10, var_11, var_11);
        var_6 = 1;
      }

      continue;
    }

    if(var_6) {
      if(!isDefined(self.vehicle_stop_named) || !self.vehicle_stop_named.size)
        self resumespeed(10);

      var_6 = 0;
    }
  }
}

tank_stop_for_allies_think_debug(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = (var_4, var_0 / 2 * -1, 30);
  var_7 = (var_4, var_0 / 2, 30);
  var_8 = (var_4 + var_2, var_0 / 2 * -1, 30);
  var_9 = (var_4 + var_2, var_0 / 2, 30);
  var_10 = (var_4, var_1 / 2 * -1, 30);
  var_11 = (var_4, var_1 / 2, 30);
  var_12 = (var_4 + var_2, var_1 / 2 * -1, 30);
  var_13 = (var_4 + var_2, var_1 / 2, 30);
  var_14 = (var_4 + var_3, var_0 / 2 * -1, 30);
  var_15 = (var_4 + var_3, var_0 / 2, 30);
  var_16 = (var_4 + var_5, var_0 / 2 * -1, 30);
  var_17 = (var_4 + var_5, var_0 / 2, 30);
  var_18 = self localtoworldcoords(var_6);
  var_19 = self localtoworldcoords(var_7);
  var_20 = self localtoworldcoords(var_8);
  var_21 = self localtoworldcoords(var_9);
}

friendly_tank_stop_internal() {
  for(;;) {
    while(!self.allies_in_danger.size)
      waitframe();

    self.stopped_for_allies = 1;
    var_0 = self.origin + anglesToForward(self.angles) * 260;
    self.badplace_id = createnavobstaclebybounds(var_0, (127, 70, 64), vectortoangles(self.path_vector));
    stop_tank("allies", 15, 15);

    while(self.allies_in_danger.size)
      waitframe();

    if(isDefined(self.badplace_id))
      destroynavobstacle(self.badplace_id);

    resume_tank("allies");
    self.stopped_for_allies = 0;
    self notify("resume_stop_for_allies");
    self.badplace_id = undefined;
  }
}

get_off_tank_path(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 notify("move_for_tank");
  self.allies_in_danger[self.allies_in_danger.size] = var_0;

  while(var_0 isinbadplace())
    waitframe();

  var_0 notify("off_tank_path");
  self.allies_in_danger = scripts\engine\utility::array_remove(self.allies_in_danger, var_0);
}

stop_tank(var_0, var_1, var_2) {
  if(isDefined(self.stops) && isDefined(self.stops[var_0])) {
    return;
  }
  self.stops[var_0] = 1;
  scripts\common\vehicle::vehicle_stop_named(var_0, var_1, var_2);
}

resume_tank(var_0) {
  self.stops[var_0] = undefined;
  scripts\common\vehicle::vehicle_resume_named(var_0);
}

tank_waittill_stopped() {
  while(self vehicle_getspeed() > 0)
    waitframe();

  wait 1;
}

waittill_nonai_isnt_blocking_tank(var_0) {
  var_0 endon("death");
  self.allies_in_danger[self.allies_in_danger.size] = var_0;

  for(;;) {
    if(var_0 is_blocking_tank(self)) {} else
      break;

    waitframe();
  }

  var_0 notify("off_tank_path");
  self.allies_in_danger = scripts\engine\utility::array_remove(self.allies_in_danger, var_0);
}

is_blocking_tank(var_0) {
  return distancesquared(var_0.origin, self.origin) < squared(500) && scripts\engine\utility::within_fov(var_0.origin, var_0.angles, self.origin, level.tankfovcos);
}

vehicle_death_custom() {
  self waittill("death");
  var_0 = self.origin;

  if(scripts\engine\utility::is_equal(self, level.tank2)) {
    radiusdamage(var_0, 200, 80, 30, level.player, "MOD_EXPLOSIVE");

    if(distance2dsquared(var_0, level.player.origin) < 22500)
      level.player shellshock("explosion", 3);

    scripts\engine\utility::exploder("bromeo_death_1");
  } else {
    radiusdamage(var_0, 300, 250, 200, level.player, "MOD_EXPLOSIVE");

    if(isDefined(self.script_noteworthy)) {
      switch (self.script_noteworthy) {
        case "smoke_lrg":
          wait 15;
          playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_lrg"), var_0);
          break;
        default:
          wait 15;
          playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_sml"), var_0);
          break;
      }
    }
  }
}

heli_death_thread() {
  self waittill("death", var_0);
  thread heli_replenish_health_after_death();
  waitframe();

  if(!istrue(self.vehiclecrashing) || istrue(self.vehicle_skipdeathmodel) || scripts\engine\utility::is_equal(self.preferred_crash_style, 3)) {
    return;
  }
  self vehicle_turnengineoff();
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }
  self waittill("vehicle_crashDone");
  level.player playSound("exp_helicopter_lab");

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "helicopter_3":
        if(self.origin[0] > 3241.0) {
          scripts\engine\utility::exploder("heli_crash_1");
          var_1 = getEnt("heli_crash_01", "targetname");
          var_1 show();
        } else
          playFX(scripts\engine\utility::getfx("vfx_lab_helo_explode_dist_ch"), self.origin);

        break;
      case "helicopter_4":
        scripts\engine\utility::exploder("heli_crash_3");
        break;
      case "helicopter_5":
        var_2 = scripts\engine\utility::getStruct("left_crash_site", "targetname");

        if(distance2dsquared(self.origin, var_2.origin) < 250000)
          playFX(scripts\engine\utility::getfx("vfx_lab_helo_explode_dist_ch"), self.origin);
        else
          scripts\engine\utility::exploder("heli_crash_2");

        break;
      default:
        playFX(scripts\engine\utility::getfx("vfx_lab_helo_explode_dist_ch"), self.origin);
        break;
    }
  }

  if(isDefined(self.origin)) {
    thread scripts\engine\utility::play_sound_in_space("hind_helicopter_crash", self.origin);

    if(distance2dsquared(self.origin, level.player.origin) < 9000000) {
      earthquake(0.3, 1.5, level.player.origin, 400);
      playrumbleonposition("damage_heavy", level.player.origin);
    }

    self delete();
  }
}

heli_replenish_health_after_death() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_0))
      self.health = self.health + var_0;
  }
}

heli_damage_death() {
  scripts\engine\sp\utility::assign_animtree("hind");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_2, var_2, var_2, var_2, var_3, var_2, var_4);

    if(scripts\engine\utility::is_equal(var_1, level.player)) {
      if(isDefined(var_4) && (scripts\engine\utility::is_equal(var_4.classname, "grenade") || scripts\engine\utility::is_equal(var_4.classname, "rocketlauncher"))) {
        thread kill_heli(var_1, var_4);
        return;
      }
    }
  }
}

kill_heli(var_0, var_1) {
  self.custom_death_script = ::helicopter_lerp_crash_anim;
  self notify("death", var_0, undefined, var_1);
  self vehicle_turnengineoff();
}

helicopter_lerp_crash_anim() {
  thread scripts\engine\sp\utility::notify_delay("in_air_explosion", 0.1);
  var_0 = scripts\engine\utility::getStruct("heli_crash_node", "targetname");
  self.animtag = scripts\engine\utility::spawn_tag_origin();
  self linkTo(self.animtag);
  var_1 = 5;
  self.animtag moveTo(var_0.origin, var_1);
  self.animtag rotateTo(var_0.angles, var_1);
  thread helicopter_crash_beats();
  self.animtag scripts\common\anim::anim_single_solo(self, "death_crash");
}

helicopter_crash_beats() {
  self waittillmatch("single anim", "midair_explosion");
  self notify("stop_crash_loop_sound");
  playworldsound("hind_helicopter_hit", self.origin);
  earthquake(0.7, 0.8, level.player.origin, 500);
  self waittillmatch("single anim", "silo_impact");
  playmayhem("mayhem_silo");
  playworldsound("hind_helicopter_hit", self.origin);
  earthquake(0.7, 0.8, level.player.origin, 500);
  showmayhem("mayhem_silo");
  getEnt("static_silo", "targetname") hide();
  self waittillmatch("single anim", "ground_impact");
  playworldsound("hind_helicopter_hit", self.origin);
  earthquake(0.7, 0.8, level.player.origin, 500);
  self stoploopsound("hind_helicopter_dying_loop");
  self vehicle_turnengineoff();
  self stopsounds();
}

heli_crash_on_pilot_death() {
  self endon("death");
  var_0 = undefined;

  foreach(var_2 in self.riders) {
    if(scripts\engine\utility::is_equal(var_2.vehicle_position, 0)) {
      var_0 = var_2;
      break;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_4 = var_0 pilot_damage_thread();
  level.player notify("new_hint");
  wait 0.1;

  if(isDefined(self.godmode)) {
    return;
  }
  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }
  level thread scripts\sp\utility::giveachievement_wrapper("pilotkill");

  if(isDefined(var_4))
    scripts\sp\utility::do_damage(self.health - self.healthbuffer + 1, var_4[0], var_4[1], undefined, var_4[2], var_4[3]);
  else
    scripts\sp\utility::do_damage(self.health - self.healthbuffer + 1, self.origin);
}

pilot_damage_thread() {
  self endon("death");
  self.stored_damage = 0;
  self.health = 2000;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_2, var_2, var_2, var_6);

    if(scripts\engine\utility::is_equal(var_1, level.player) && level.player scripts\sp\maps\lab\lab_util.gsc::using_bulletdrop_weapon()) {
      self.health = self.health + var_0;
      continue;
    }

    self.stored_damage = self.stored_damage + var_0;

    if(self.stored_damage >= 200) {
      scripts\sp\utility::do_damage(self.health + self.stored_damage, var_3, var_1, undefined, var_4, var_6);
      return [var_3, var_1, var_4, var_6];
    }
  }
}

little_bird_dmg_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    if(isDefined(var_4)) {
      if(var_4 == "MOD_GRENADE")
        self.grenadehits++;
    }
  }

  if(self.grenadehits >= 2 || self.projectilehits > 0)
    scripts\sp\utility::do_damage(self.health + 10000, self.origin, var_1, var_1, "MOD_PROJECTILE");
}

drone_attack_checks() {
  level endon("lab_door_opened");

  for(;;) {
    level waittill("hellfire_impact", var_0, var_1);
    var_2 = scripts\engine\utility::get_array_of_closest(var_0, getaiarray("axis"), undefined, undefined, 500, 0);
    var_3 = scripts\engine\utility::get_array_of_closest(var_0, scripts\engine\sp\utility::getvehiclearray(), undefined, undefined, 500, 0);
    var_4 = scripts\engine\utility::array_combine(var_2, var_3);
    var_5 = 0;

    foreach(var_7 in var_4) {
      if(isai(var_7) && isalive(var_7) && var_7.team == "allies") {
        var_5 = 1;
        continue;
      }

      if(var_7 scripts\common\vehicle::isvehicle() && var_7.script_team == "allies" && !var_7 scripts\common\vehicle_code::_is_godmode())
        var_5 = 1;
    }

    if(getdvarint("scr_debug_greenbeam"))
      thread scripts\engine\utility::draw_circle(var_0, 500, (1, 0, 0), 1, 0, 100);

    if(var_5) {
      wait 0.7;
      scripts\sp\friendlyfire::missionfail(0);
      return;
    }

    foreach(var_10 in var_4) {
      if(var_10 scripts\common\vehicle::isvehicle()) {
        if(var_10 scripts\common\vehicle_code::_is_godmode())
          continue;
        else if(istrue(var_10.attachedguys.size))
          level.drone.killcount = level.drone.killcount + var_10.attachedguys.size;
      }

      var_10 scripts\sp\utility::do_damage(var_10.health + 10000, var_10.origin, level.player, undefined, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));
      level.drone.killcount++;
    }
  }
}

guard_tower_logic() {
  self.stored_damage = 0;
  level endon("ambush1_start");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_3, var_3, var_3, var_3, var_5, var_6, var_3, var_3, var_7);

    if(isDefined(level.hilltop_heli) && scripts\engine\utility::is_equal(level.hilltop_heli.minigun, var_1))
      self.stored_damage = self.stored_damage + var_0;

    if(var_0 < 170) {
      continue;
    }
    if(tower_damage_check(var_1, var_4, var_0)) {
      if(isDefined(var_5)) {
        var_8 = createheadicon(var_5);
        level notify("guard_tower_destroyed", self, var_1, var_7, var_4, var_8);
      }

      foreach(var_10 in getaiarray("axis")) {
        if(var_10 istouching(self.trigger)) {
          if(isDefined(var_5)) {
            var_10 childthread scripts\sp\utility::do_damage(var_10.health + 1, var_6, var_1, var_7, var_4, var_5);
            continue;
          }

          var_10 childthread scripts\sp\utility::do_damage(var_10.health + 1, var_6, var_1, var_7, var_4);
        }
      }

      if(isDefined(var_2) && var_2[2] - self.origin[2] < 215)
        var_12 = "collapsed";
      else
        var_12 = "exploded";

      self setscriptablepartstate("base", var_12, 1);
      childthread scripts\engine\utility::play_sound_in_space("lab_hill_guard_tower_" + var_12, self.origin);

      foreach(var_14 in self.nodes) {
        if(scripts\engine\utility::is_equal(var_14.type, "Begin")) {
          destroynavlink(var_14);
          continue;
        }

        var_14 disconnectnode();
      }

      self.brushmodel delete();
      self.trigger delete();

      if(isDefined(self.ridge_tower)) {
        wait 2;
        self hide();
      }

      return;
    }
  }
}

kill_tower_ladders() {
  var_0 = getscriptablearray("guard_tower", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.nodes) || !var_2 is_tower_touching_trigger()) {
      continue;
    }
    foreach(var_4 in var_2.nodes) {
      if(var_4.type == "Begin") {
        destroynavlink(var_4);
        continue;
      }

      var_4 disconnectnode();
    }
  }
}

is_tower_touching_trigger() {
  var_0 = getEnt("tower_death_2", "script_noteworthy");
  var_1 = getEnt("tower_death_3", "script_noteworthy");

  if(isDefined(var_0) && self istouching(var_0))
    return 1;
  else if(isDefined(var_1) && self istouching(var_1))
    return 1;
  else
    return 0;
}

tower_damage_check(var_0, var_1, var_2) {
  if(scripts\engine\utility::is_equal(var_0, level.player) && level.player scripts\sp\maps\lab\lab_util.gsc::using_bulletdrop_weapon())
    return 0;
  else if(isDefined(var_1) && (isexplosivedamagemod(var_1) && var_2 >= 180))
    return 1;
  else if(isDefined(level.tank2) && scripts\engine\utility::is_equal(level.tank2.mainturret, var_0) && var_2 > 380)
    return 1;
  else if(isDefined(self.stored_damage) && self.stored_damage > 8000)
    return 1;
  else
    return 0;
}

enemy_sight_increased() {
  level.player notify("stealth_disabled");
  var_0 = 5500;
  var_1 = var_0 * var_0;
  level.player scripts\engine\sp\utility::set_maxvisibledist(var_0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\engine\sp\utility::set_maxsightdistsquared, var_1);

  foreach(var_3 in getaiarray("axis"))
  var_3 scripts\engine\sp\utility::set_maxsightdistsquared(var_1);
}

hill_dmg_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(scripts\engine\utility::is_equal(var_1.classname, "script_vehicle_bromeo"))
    thread player_temp_invul(var_0);
}

player_temp_invul(var_0) {
  self endon("death");

  if(isDefined(self.temp_invul)) {
    return;
  }
  self.temp_invul = 1;
  self enableinvulnerability();
  scripts\sp\player::set_normalhealth(self.health + var_0 / self.maxhealth);
  wait 3;
  self disableinvulnerability();
  self.temp_invul = undefined;
}

apc_shoot_logic() {
  self endon("death");
  childthread apc_target_updater();

  if(!scripts\engine\utility::flag("go_left")) {
    childthread hill_bottom_apc_attack();
    return;
  }

  var_0 = self.mainturret;
  wait 0.25;

  for(;;) {
    if(apc_should_attack_player())
      apc_hurttarget(level.player);
    else
      apc_attack_target_until_closer_threat();

    wait(randomfloatrange(2, 3));
  }
}

hill_bottom_apc_attack() {
  wait 4;

  for(;;) {
    var_0 = undefined;

    if(isDefined(level.corner_redshirts)) {
      foreach(var_2 in level.corner_redshirts) {
        if(isalive(var_2)) {
          var_2.health = 10;
          apc_hurttarget(var_2, 1);
        }
      }
    }

    if(!scripts\engine\utility::flag("green_beam_safe_zone"))
      apc_hurttarget(level.player, 1);
    else
      apc_attack_target_until_closer_threat();

    waitframe();
  }
}

apc_should_attack_player() {
  if(!scripts\engine\utility::flag("go_left"))
    return !scripts\engine\utility::flag("green_beam_safe_zone");

  if(!isDefined(self.script_noteworthy))
    return 0;

  return scripts\engine\utility::flag(self.script_noteworthy + "_close");
}

apc_attack_target_until_closer_threat() {
  var_0 = self.currtarget;
  self endon("new_threat");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("death");
  self.mainturret settargetentity(var_0, (0, 0, 30));

  while(isDefined(var_0) && !is_aimed_at_target(var_0))
    wait 0.05;

  if(!isalive(var_0))
    return 1;

  apc_hurttarget(var_0);
  return 1;
}

apc_target_updater() {
  var_0 = level.player;
  self.currtarget = var_0;
  var_1 = [];

  for(;;) {
    var_2 = getaiarray("allies");
    var_2 = scripts\engine\utility::array_combine(var_2, [level.player, level.tank2]);
    var_2 = sortbydistance(var_2, self.origin);

    foreach(var_5, var_4 in var_2) {
      if(isDefined(var_4.ridingvehicle)) {
        continue;
      }
      if(var_5 == 0)
        var_1[var_1.size] = var_4;
      else if(distancesquared(var_4.origin, var_1[0].origin) < 202500)
        var_1[var_1.size] = var_4;

      var_0 = var_4;
      break;
    }

    if(var_1.size > 1)
      var_0 = scripts\engine\utility::random(var_1);
    else
      var_0 = var_1[0];

    self notify("new_threat", var_0);
    self.currtarget = var_0;
    var_0 scripts\engine\utility::waittill_notify_or_timeout("death", 5);
  }
}

apc_hurttarget(var_0, var_1) {
  var_2 = isPlayer(var_0);

  if(var_2 && !isDefined(var_1)) {
    var_3 = 100;
    self.mainturret.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_3;
    waitframe();
    self.mainturret settargetentity(self.mainturret.target_ent, (0, 0, 0));

    for(;;) {
      var_3 = var_3 - 10;
      self.mainturret.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_3;
      tank_shot();
      wait(0.15 + randomfloat(0.15));

      if(distance(var_0.origin, self.mainturret.target_ent.origin) < 50) {
        break;
      }
    }
  }

  var_4 = randomintrange(4, 6);

  if(istrue(var_0.magic_bullet_shield))
    var_4 = 3;

  var_5 = 0;
  var_6 = 3;
  var_7 = var_0.health;
  var_8 = 0;

  for(var_9 = 0; var_9 < var_4; var_9++) {
    var_10 = -15;
    var_11 = 15;

    if(var_2 && var_0 issprinting() && !isDefined(var_1)) {
      var_10 = -30;
      var_11 = 30;
    }

    self.mainturret settargetentity(var_0, (0, 0, 30) + scripts\engine\utility::randomvectorrange(var_10, var_11));
    tank_shot();
    wait(0.2 + randomfloat(0.15));

    if(!canshoottarget(var_0)) {
      var_5++;

      if(var_5 == var_6)
        return;
    }
  }
}

canshoottarget(var_0) {
  var_1 = undefined;

  if(isPlayer(var_0) || isai(var_0))
    var_1 = var_0 getEye();
  else if(var_0 scripts\common\vehicle::isvehicle())
    var_1 = var_0.origin + (0, 0, 60);
  else
    var_1 = var_0.origin;

  var_2 = sighttracepassed(self.mainturret gettagorigin("tag_flash"), var_1, 0, [self, var_0]);
  return var_2;
}

get_ally_target() {
  var_0 = getaiarray("allies");

  if(isalive(level.tank2))
    var_0 = scripts\engine\utility::array_add(var_0, level.tank2);

  foreach(var_2 in var_0) {
    if(canshoottarget(var_2))
      return var_2;
  }

  return undefined;
}

is_aimed_at_target(var_0) {
  return scripts\engine\utility::within_fov(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var_0.origin, level.cos10);
}

tank_moveup_nag(var_0) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  wait 18;
  var_1 = ["dx_vom_pri_drone_tutorial_transition_30", "dx_vom_pri_drone_tutorial_transition_20", "dx_vom_pri_drone_tutorial_transition_40"];
  var_2 = scripts\engine\sp\utility::create_deck(var_1, 0);
  level scripts\sp\maps\lab\lab_vo_util.gsc::nagtill(undefined, var_2, 16, 2, 1.2, 1.2, 45, 5);
}

tanks_moveup_hill_shooting_logic() {
  self endon("death");
  scripts\vehicle\bromeo::mainturret_idle();
  var_0 = getspawnerarray("turret_guys");
  scripts\engine\utility::flag_wait("hill_charge_started");
  scripts\engine\utility::ent_flag_set("reset_shooting");
  self notify("reset_shooting");
  self.mainturret.target_ent unlink();

  while(!scripts\engine\utility::flag("go_left") && !scripts\engine\utility::flag("manual_shooting")) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      self.mainturret.target_ent.origin = var_2.origin + (0, 0, 130);
      self.mainturret settargetentity(self.mainturret.target_ent, scripts\engine\utility::randomvector(20));

      while(!is_aimed_at_target(self.mainturret.target_ent))
        wait 0.25;

      var_3 = randomintrange(4, 7);

      for(var_4 = 0; var_4 < var_3; var_4++) {
        tank_shot();
        wait(0.25 + randomfloat(0.15));
      }

      wait(2 + randomfloat(2));
    }
  }

  scripts\engine\utility::ent_flag_clear("reset_shooting");
  scripts\engine\utility::flag_set("manual_shooting");
}

tank_shooting_logic() {
  self endon("death");

  while(!isDefined(self.mainturret.target_ent))
    wait 1;

  scripts\vehicle\bromeo::mainturret_idle();

  for(;;) {
    wait 0.5;
    self.mainturret.target_ent unlink();
    self.mainturret cleartargetentity();
    self.mainturret.convergencetime = 0.75;
    self.mainturret.target_ent.origin = self.origin + anglesToForward(self.angles) * 50;

    if(scripts\engine\utility::flag("manual_shooting"))
      manual_shooting_logic();
    else if(scripts\engine\utility::flag("post_bridge_shooting"))
      tank_struct_shoots();
    else
      tank_idle_aiming();

    wait 0.5;
  }
}

manual_shooting_logic() {
  level endon("post_bridge_shooting");
  self endon("reset_shooting");
  var_0 = scripts\engine\sp\utility::getvehiclearray_in_radius(self.origin, 3000, "axis");
  self.mainturret settargetentity(self.mainturret.target_ent);

  if(var_0.size > 0)
    tank_pick_vehicle_target(var_0);
  else
    tank_pick_ai_target();
}

tank_struct_shoots() {
  level endon("manual_shooting");
  level endon("next_targets");
  self endon("reset_shooting");
  var_0 = get_closest_tank_targets();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_1 = sortbydistance(var_1, self.origin);

  foreach(var_3 in var_1) {
    self.mainturret.target_ent unlink();
    self.mainturret.target_ent.origin = var_3.origin;
    self.mainturret settargetentity(self.mainturret.target_ent);
    var_4 = getaiarrayinradius(var_3.origin, 700, "axis");

    if(var_4.size < 1) {
      continue;
    }
    if(!isDefined(var_3.radius))
      var_5 = 200;
    else
      var_5 = var_3.radius;

    var_6 = gettime() + 3000;

    while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var_6)
      wait 0.5;

    if(!isDefined(var_3.script_noteworthy)) {
      var_7 = randomintrange(3, 5);

      for(var_8 = 0; var_8 < var_7; var_8++) {
        tank_shot();
        wait(0.3 + randomfloat(0.3));
      }
    } else if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "ai_target"))
      tank_pick_ai_target(var_3.origin, var_5);
    else if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "vehicle_target")) {
      var_9 = scripts\engine\sp\utility::getvehiclearray_in_radius(var_3.origin, var_5, "axis");
      tank_pick_vehicle_target(var_9);
    }

    wait 1;
  }

  for(;;) {
    tank_pick_ai_target(self.mainturret.target_ent.origin, 2000);
    wait 2;
  }
}

tank_shot() {
  earthquake(0.1, 0.5, self.origin, 400);
  playrumbleonposition("damage_light", self.origin);
  self.mainturret shootturret("tag_flash");
}

get_closest_tank_targets() {
  var_0 = scripts\engine\utility::getStructArray("tank_target_zones", "targetname");
  var_1 = scripts\engine\utility::getclosest(self.mainturret gettagorigin("tag_flash"), var_0);
  return var_1;
}

tank_idle_aiming() {
  self endon("reset_shooting");
  level endon("manual_shooting");
  level endon("post_bridge_shooting");

  while(!isDefined(self.mainturret.target_ent))
    wait 1;

  wait(randomintrange(1, 3));
  var_0 = self.origin + (0, 0, 100) + anglesToForward(self.angles) * 200;
  var_1 = spawn("script_origin", var_0);
  var_1.angles = self.angles;
  var_1 linkTo(self);
  var_2 = gettime() + 3000;
  self.mainturret settargetentity(self.mainturret.target_ent);
  self.mainturret.convergencetime = 0.05;

  for(;;) {
    var_3 = var_1.origin;
    var_4 = anglestoleft(var_1.angles) * randomintrange(-300, 300);
    self.mainturret.target_ent.origin = var_3 + var_4;
    self.mainturret.target_ent linkTo(self);

    while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var_2)
      wait 1;

    wait(randomintrange(2, 3));
    var_3 = var_1.origin;
    var_5 = anglestoup(var_1.angles) * randomintrange(-30, 50);
    self.mainturret.target_ent unlink();
    self.mainturret.target_ent.origin = var_3 + var_5;
    self.mainturret.target_ent linkTo(self);

    while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var_2)
      wait 1;

    wait(randomintrange(1, 2));
    wait 2;
    self.mainturret.target_ent unlink();
  }

  self.mainturret.target_ent unlink();
}

tank_pick_vehicle_target(var_0) {
  self endon("reset_shooting");
  var_0 = scripts\engine\utility::array_removeundefined(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      tank_shoot_target(var_2, [1, 2], scripts\engine\utility::randomvector(80));
      self.mainturret.target_ent unlink();
      break;
    }
  }
}

tank_pick_ai_target(var_0, var_1) {
  self endon("reset_shooting");

  if(!isDefined(var_0))
    var_0 = self.mainturret.target_ent.origin;

  if(!isDefined(var_1))
    var_1 = 2000;

  var_2 = getaiarrayinradius(var_0, var_1, "axis");

  if(isDefined(var_2) && var_2.size > 0) {
    var_3 = scripts\engine\utility::getclosest(self.mainturret.target_ent.origin, var_2);
    tank_shoot_target(var_3, [3, 5], scripts\engine\utility::randomvector(30));
    self.mainturret.target_ent unlink();
  }
}

tank_shoot_target(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    self.mainturret.target_ent.origin = var_0.origin + (0, 0, 30);

    if(isent(var_0))
      self.mainturret.target_ent linkTo(var_0);
  }

  self.mainturret settargetentity(self.mainturret.target_ent, var_2);

  if(isarray(var_1))
    var_1 = randomintrange(var_1[0], var_1[1]);

  var_3 = gettime() + 2000;

  while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var_3)
    wait 0.5;

  for(var_4 = 1; var_4 < var_1; var_4++) {
    tank_shot();
    wait(0.3 + randomfloat(0.3));
  }
}

tanksshouldmove(var_0) {
  var_1 = [level.tank, level.tank2];

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3 scripts\engine\math::is_point_in_front(level.player.origin);

    if(var_4)
      return 1;
    else if(distancesquared(var_3.origin, level.player.origin) < var_0 * var_0) {
      if(!var_4)
        return 1;
    }
  }

  return 0;
}

shouldshootplayer() {
  if(level.player.health <= 10)
    return 0;

  if(scripts\engine\utility::flag("laser_marker_on"))
    return 0;

  if(level.player scripts\sp\maps\lab\lab_util.gsc::using_bulletdrop_weapon() && level.player adsButtonPressed(1))
    return 0;

  return 1;
}

loop_path(var_0) {
  self endon("death");

  for(;;) {
    self waittill("reached_end_node");
    wait 3;
    self.hasstarted = undefined;
    self attachpath(var_0);
    thread scripts\common\vehicle::vehicle_paths(var_0);
    scripts\common\vehicle_paths::gopath(self);
  }
}

little_bird_spawnfunc() {
  self setvehicleteam("axis");
  self.script_team = "axis";
  self.isheli = 1;
  self.heli_fight_start = gettime();
  self.projectilehits = 0;
  self.grenadehits = 0;
  self setneargoalnotifydist(300);
  self.lastattackplayertime = 0;
  heli_mg_create();
  thread heli_movement();
  thread heli_attack_logic();
  scripts\engine\utility::flag_set("hilltop_heli_spawned");
  scripts\engine\sp\utility::autosave_by_name("lb_spawn");
  childthread lb_pilot_init();
  self.ignoreme = 1;
  self waittill("death");
  disable_hilltop_roof_traversal();
  level.player scripts\engine\sp\utility::set_attackeraccuracy(1);
  scripts\engine\sp\utility::autosave_by_name("lb_dead");
  thread scripts\engine\sp\utility::transient_load_array(["lab_turbine1_tr", "lab_turbine2_tr", "lab_van_tr"]);
  thread scripts\engine\utility::flag_set_delayed("hilltop_heli_dead", 2);
}

disable_hilltop_roof_traversal() {
  var_0 = getnodesinradius((3425.16, 1056.94, 32), 100, 0);

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.type, "Begin"))
      destroynavlink(var_2);
  }
}

lb_pilot_init() {
  level endon("hilltop_heli_dead");

  while(!isDefined(self.riders[0]))
    waitframe();

  self.riders[0].ignoreme = 1;
  self.riders[0] scripts\engine\sp\utility::set_attackeraccuracy(0.3);
  self.riders[0] thread lb_pilot_death();
  scripts\engine\utility::flag_wait("heli_intro_movement");
  self.riders[0].ignoreme = 0;
}

lb_pilot_death() {
  self waittill("death", var_0, var_1);

  if(isDefined(var_1) && (scripts\engine\utility::is_equal(var_1.basename, "iw8_sn_hdromeo_ballistics") || scripts\engine\utility::is_equal(var_1.basename, "none")))
    self delete();
}

heli_mg_create() {
  var_0 = "tag_light_2";
  var_1 = (30, -11.511, 4);
  var_2 = self gettagorigin(var_0);
  self.minigun = spawnturret("misc_turret", var_2, "iw8_vehicle_mg_50cal_heli_lab");
  self.minigun.angles = self gettagangles(var_0);
  self.minigun setModel("veh8_mil_air_mindia8_turret");
  self.minigun linkTo(self, var_0, var_1, (6, 0, 0));
  self.minigun makeunusable();
  self.minigun setmode("manual");
  self.minigun setdefaultdroppitch(0);
  self.minigun setleftarc(180);
  self.minigun setrightarc(180);
  self.minigun settoparc(180);
  self.minigun setbottomarc(180);
  self.minigun.target_ent = scripts\engine\utility::spawn_tag_origin();
  self.minigun.chopper = self;
  self.mg_z_offset = self.origin[2] - self.minigun gettagorigin("tag_flash")[2];
  thread scripts\engine\utility::delete_on_death(self.minigun.target_ent);
  thread scripts\engine\utility::delete_on_death(self.minigun);
}

heli_movement() {
  self endon("death");
  var_0 = scripts\engine\utility::getStructArray("left_heli_lane", "targetname");
  var_1 = scripts\engine\utility::getStructArray("right_heli_lane", "targetname");
  var_2 = scripts\engine\utility::getStructArray("left_heli_lane_back", "targetname");
  var_3 = scripts\engine\utility::getStructArray("right_heli_lane_back", "targetname");
  var_4 = 1;
  var_5 = getEnt("gl_intro_door", "script_noteworthy").origin;
  nav_gotopos(self.origin + (0, 0, 500));

  for(;;) {
    self notify("new_goal");

    if(var_4) {
      if(scripts\engine\utility::flag("lb_switch_paths"))
        var_6 = var_2;
      else
        var_6 = var_0;

      var_4 = 0;
    } else {
      if(scripts\engine\utility::flag("lb_switch_paths"))
        var_6 = var_3;
      else
        var_6 = var_1;

      var_4 = 1;
    }

    var_7 = scripts\engine\utility::random(var_6);
    var_8 = scripts\engine\utility::getStruct(var_7.target, "targetname");
    var_9 = distance(level.player.origin, var_5);
    var_10 = var_9 * 0.5;
    var_11 = level.player.origin + anglesToForward(level.player.angles) * var_10;
    var_12 = pointonsegmentnearesttopoint(var_7.origin, var_8.origin, var_11);
    var_13 = getgroundposition(var_12, 60)[2] + 350 + randomint(200);
    var_14 = (var_12[0], var_12[1], var_13);
    heli_movetopos_and_idle(var_14);
    player_fired_recently_delay();
    wait 0.05;
  }
}

heli_movetopos_and_idle(var_0) {
  nav_gotopos(var_0);
  var_1 = 6 + randomint(2);
  var_2 = gettime();

  while(gettime() < var_2 + var_1 * 1000) {
    if(scripts\engine\utility::flag("lb_targeting_player")) {
      if(player_is_trying_to_shoot_me() || scripts\engine\utility::flag("laser_marker_on"))
        return;
    }

    waitframe();
  }
}

nav_gotopos(var_0, var_1) {
  self notify("nav_new_path");
  self endon("nav_new_path");
  var_2 = findpath3d(self.origin, var_0);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = 0;
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 37);
  self vehicle_setspeed(var_1, var_1 * 0.5, var_1 * 0.5);

  foreach(var_6, var_5 in var_2) {
    if(var_6 == var_2.size - 1)
      var_3 = 1;

    self setvehgoalpos(var_5, var_3);
    scripts\engine\utility::waittill_any("near_goal", "goal");
  }

  self notify("nav_goal");
}

draw_3d_path(var_0) {
  var_1 = self.origin;

  foreach(var_4, var_3 in var_0) {
    var_1 = var_3;
    wait 0.05;
  }
}

has_ceiling() {
  var_0 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 0, 1, 0);
  return !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 1000), self, var_0);
}

track_player_rpg() {
  level.player endon("death");
  level endon("hilltop_heli_dead");
  level.player.last_misile_fire_time = gettime();

  for(;;) {
    level.player waittill("missile_fire", var_0);
    var_1 = level.player getcurrentprimaryweapon();

    if(var_1.classname == "grenade" || var_1.classname == "rocketlauncher")
      level.player.last_misile_fire_time = gettime();
  }
}

player_fired_recently_delay() {
  if(level.gameskill > 1) {
    return;
  }
  if(scripts\engine\utility::flag("lb_targeting_player")) {
    return;
  }
  if(isDefined(level.player.last_misile_fire_time) && gettime() - level.player.last_misile_fire_time < 2500)
    wait 2;
}

player_using_sniper_rifle() {
  var_0 = level.player getcurrentweapon();

  if(isstring(var_0))
    var_1 = weaponclass(var_0);
  else
    var_1 = var_0.classname;

  return var_1 == "sniper";
}

player_is_trying_to_snipe_me() {
  if(!level.player adsButtonPressed(1))
    return 0;

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin - (0, 0, 80), level.cos60))
    return 0;

  return player_using_sniper_rifle();
}

player_is_trying_to_shoot_me() {
  var_0 = level.player getcurrentweapon();

  switch (var_0.classname) {
    case "sniper":
    case "rocketlauncher":
      if(level.player adsButtonPressed(1) && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin - (0, 0, 80), cos(30)))
        return 1;

      if(gettime() - level.player.last_misile_fire_time <= 1000)
        return 1;
    default:
      return 0;
  }
}

heli_attack_logic() {
  self endon("death");
  var_0 = cos(50);
  var_1 = scripts\engine\trace::create_contents(0, 0, 0, 1, 0, 0, 1, 1);
  var_2 = gettime() + 10000;
  self.ignoreme = 0;
  scripts\engine\utility::flag_set("heli_intro_movement");
  childthread scripts\engine\sp\utility::flag_clear_delayed("heli_intro_movement", 10);

  while(gettime() < var_2 && !scripts\sp\maps\lab\lab_util.gsc::in_player_fov(level.cos30, self.origin, [self, level.player]))
    wait 0.5;

  for(;;) {
    var_3 = get_heli_target(var_1);

    if(!isDefined(var_3)) {
      wait 0.5;
      continue;
    }

    if(isPlayer(var_3)) {
      if(!scripts\engine\utility::flag("lb_targeting_player")) {
        scripts\engine\utility::flag_set("lb_targeting_player");
        self.no_gb_lockon = 1;
      }
    } else if(scripts\engine\utility::flag("lb_targeting_player")) {
      self.no_gb_lockon = undefined;
      scripts\engine\utility::flag_clear("lb_targeting_player");
    }

    self setlookatent(var_3);

    while(isalive(var_3) && !scripts\engine\utility::within_fov(self.origin, self.angles, var_3.origin, var_0))
      wait 0.1;

    if(!isalive(var_3)) {
      waitframe();
      continue;
    }

    if(isai(var_3)) {
      shoottokill(var_3, var_1);
      level.player scripts\engine\sp\utility::set_attackeraccuracy(1);
    } else {
      level.player scripts\engine\sp\utility::set_attackeraccuracy(0.5);

      if(should_kill_player())
        shoottokill(var_3, var_1);
      else
        hurttarget(var_3);
    }

    wait 2;
  }
}

get_heli_target(var_0) {
  var_1 = gettime() - self.lastattackplayertime;

  if(var_1 >= 8000) {
    if(!scripts\engine\utility::flag("heli_intro_movement"))
      self.lastattackplayertime = gettime();

    return level.player;
  }

  var_2 = [];

  foreach(var_4 in getaiarray("allies")) {
    if(!isDefined(var_4.magic_bullet_shield))
      var_2[var_2.size] = var_4;
  }

  var_6 = sortbydistance(var_2, level.player.origin)[var_2.size - 1];
  return var_6;
}

heli_fov_check(var_0) {
  var_1 = level.player getEye() + (0, 0, 10);
  var_2 = self.minigun gettagorigin("tag_flash");
  var_3 = scripts\engine\utility::array_removeundefined(level.heroes);
  var_4 = scripts\engine\utility::array_add(var_3, self);

  if(scripts\engine\trace::ray_trace_passed(var_2, var_1, var_4, var_0))
    return 1;
  else
    return 0;
}

should_kill_player() {
  var_0 = 10;
  var_1 = 15;
  var_0 = var_0 * 1000;

  if(!isDefined(self.last_kill_attempt_time) && gettime() - self.heli_fight_start >= var_1)
    return 1;

  if(isDefined(self.last_kill_attempt_time) && gettime() - self.last_kill_attempt_time >= var_0)
    return 1;

  return 0;
}

shoottokill(var_0, var_1) {
  if(istrue(self.noshooting) || istrue(var_0.magic_bullet_shield)) {
    return;
  }
  self endon("death");
  var_0 endon("death");
  self endon("stop_shooting");
  self.last_kill_attempt_time = gettime();
  self.is_shooting = 1;
  var_2 = 60;

  if(isPlayer(var_0)) {
    var_3 = 375;
    self.minigun.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_3;

    for(;;) {
      var_3 = var_3 - 10;
      self.minigun.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_3;
      self.minigun shootturret("tag_flash");
      wait 0.05;

      if(distance(var_0.origin, self.minigun.target_ent.origin) < 50) {
        break;
      }
    }
  }

  for(var_4 = 0; var_4 < var_2; var_4++) {
    if(isPlayer(var_0) && var_0 issprinting())
      self.minigun settargetentity(var_0, scripts\engine\utility::randomvector(50));
    else
      self.minigun settargetentity(var_0, (15, 15, 20));

    self.minigun shootturret();

    if(var_0.health <= 1) {
      if(isPlayer(var_0) && !scripts\engine\trace::ray_trace_detail_passed(self.minigun.origin, var_0 getEye(), [self.minigun, level.player, self])) {
        return;
      }
      var_0 kill();
      return;
    }

    if(var_4 == var_2 * 0.5) {
      wait 0.3;
      continue;
    }

    wait 0.05;
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

hurttarget(var_0) {
  if(istrue(self.noshooting) || istrue(var_0.magic_bullet_shield)) {
    return;
  }
  self endon("death");
  self endon("stop_shooting");
  var_0 endon("death");
  self.is_shooting = 1;

  if(level.gameskill < 2) {
    var_1 = 30;
    var_2 = 60;
  } else {
    var_1 = 1;
    var_2 = 30;
  }

  var_3 = 450;
  self.minigun.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_3;

  for(;;) {
    var_3 = var_3 - 10;
    self.minigun.target_ent.origin = var_0.origin + anglesToForward(var_0.angles) * var_3;
    self.minigun shootturret();
    wait 0.05;

    if(distance(var_0.origin, self.minigun.target_ent.origin) < 50) {
      break;
    }
  }

  var_4 = 60;
  var_5 = var_0.health;
  var_6 = 0;

  for(var_7 = 0; var_7 < var_4; var_7++) {
    if(var_0.health <= var_1) {
      break;
    }

    if(isPlayer(var_0))
      self.minigun settargetentity(var_0, scripts\engine\utility::randomvector(var_2));
    else
      self.minigun settargetentity(var_0, (24, -24, 40));

    self.minigun shootturret();
    wait 0.05;

    if(var_0.health != var_5)
      var_5 = var_0.health;
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

canshoottargetfrompos(var_0, var_1) {
  if(istrue(self.noshooting))
    return 0;

  if(isPlayer(var_1) || isai(var_1))
    var_2 = var_1 getEye();
  else
    var_2 = var_1.origin;

  var_3 = sighttracepassed(var_0 - (0, 0, self.mg_z_offset), var_2, 0, self);
  return var_3;
}