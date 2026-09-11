/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab_hill.gsc
***********************************************/

function hill_preload() {
  scripts\engine\sp\utility::add_hint_string("zoom_in", &"LAB/ZOOM_IN", &player_zoomingsniper);
  scripts\engine\sp\utility::add_hint_string("zoom_out", &"LAB/ZOOM_OUT", &player_zoomingsniper);
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

function hill_postload() {
  if(!scripts\sp\starts::is_after_start("hill_top")) {
    lab_drone_setup();
    remove_node_clip("tank_stops");
    var0 = scripts\common\utility::getvehiclespawner("convoy_tank_2", "targetname");
    var0 scripts\engine\sp\utility::add_spawn_function(&tank_logic);
    var1 = scripts\common\utility::getvehiclespawnerarray();
    scripts\engine\utility::array_thread(var1, &scripts\engine\sp\utility::add_spawn_function, &global_vehicle_spawn_func);
    thread init_scriptable_trucks("exploding_hill_trucks");
    scripts\engine\sp\utility::array_spawn_function_targetname("bunker_runners", &scripts\sp\utility::context_melee_allow, 0);
    scripts\engine\sp\utility::array_spawn_function_noteworthy("main_hill_guys", &scripts\sp\maps\lab\lab_util::ai_movement_control, level.player, 2000, 500);
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_1_guys", &tower_ai_thread, "tower_death_1");
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_2_guys", &tower_ai_thread, "tower_death_2");
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_3_guys", &tower_ai_thread, "tower_death_3");
    scripts\engine\sp\utility::array_spawn_function_noteworthy("tower_4_guys", &tower_ai_thread, "tower_death_4");
    thread tower_spawner_killer("tower_1_guys", "tower_death_1");
    thread tower_spawner_killer("tower_3_guys", "tower_death_3");
    scripts\engine\sp\utility::add_global_spawn_function("axis", &gun_on_death, 0);
    scripts\engine\sp\utility::add_global_spawn_function("allies", &gun_on_death, 0, "allies");
    scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\sp\maps\lab\lab_util::axis_grenade_toggle, 0);
    thread init_towers();
    var2 = getEntArray("magic_rpg_trig", "targetname");
    scripts\engine\utility::array_thread(var2, &magic_rpg_trig);
    thread init_trees();
  }

  var3 = getEnt("heli_crash_01", "targetname");

  if(isDefined(var3)) {
    var3 hide();
    return;
  }
}

function tower_ai_thread(var0) {
  self endon("death");

  if(!scripts\engine\utility::flag(var0)) {
    scripts\engine\utility::flag_wait(var0);
  }

  if(!isDefined(self)) {
    return;
  }

  self.goalradius = 2000;

  if(var0 == "tower_death_1") {
    var1 = getEnt("ridge_1_volume", "targetname");
    self setgoalvolumeauto(var1);
    return;
  }

  if(var1 == "tower_death_4") {
    var1 = getEnt("hill_top_volume", "targetname");
    self setgoalvolumeauto(var1);
    return;
  }

  var1 = getEnt("hill_mid_ai_volume", "targetname");
  self setgoalvolumeauto(var1);
}

function tower_spawner_killer(var0, var1) {
  level endon("hill_finished_trig");
  scripts\engine\utility::flag_wait(var1);
  var2 = getEntArray(var0, "script_noteworthy");

  if(isDefined(var2)) {
    foreach(var4 in var2) {
      var4 delete();
    }

    return;
  }
}

function gun_on_death(var0, var1) {
  if(scripts\engine\utility::is_equal(self.script_noteworthy, "rooftop_ai")) {
    self dontcastshadows();
    self dontcastdistantshadows();
  }

  if(scripts\engine\utility::is_equal(self.script_parameters, "no_weapon_drop") || scripts\engine\utility::is_equal(self.script_noteworthy, "rooftop_ai")) {
    self waittill("weapon_dropped", var2);
    self endon("droppedItem");

    while(isDefined(var2) && scripts\sp\maps\lab\lab_util::in_player_fov(level.cos15, var2.origin)) {
      waitframe();
    }

    if(isDefined(var2)) {
      var2 delete();
      return;
    }

    return;
  }
}

function tree_test() {
  var0 = getscriptablearray("spruce_01", "script_noteworthy");
  var1 = getscriptablearray("spruce_02", "script_noteworthy");
  var2 = getscriptablearray("spruce_03", "script_noteworthy");
  var3 = scripts\engine\utility::array_combine(var0, var1, var2);
  wait 5;

  foreach(var5 in var3) {
    var5 setscriptablepartstate("base", "hide", 1);
  }
}

function lab_drone_setup() {
  var0 = (7775.56, 4129.22, 4000);
  level.green_beam_weapon = "iw8_green_beam_bright";
  scripts\sp\equipment\green_beam::laser_init(var0, 2, "start_green_beam_instruct", "stop_green_beam_instruct");
  level.helidronefx = "drone_explode_heli";
  level.drone.fx_explode = "drone_explode";
  level.green_beam_does_vo = 0;
}

function tank_logic() {
  self endon("death");
  GscBinSkip4(0x35);
}

function global_vehicle_spawn_func() {
  if(scripts\engine\utility::flag("hill_finished_trig")) {
    return;
  }

  if(scripts\common\vehicle::ishelicopter()) {
    if(isDefined(level.vo_callouts)) {
      level thread scripts\engine\utility::delaythread(randomfloatrange(5, 7), &scripts\sp\maps\lab\lab_vo_util::say_as_chatter, level.vo_callouts.heli scripts\engine\sp\utility::deck_draw());
    }

    scripts\common\vehicle::vehicle_lights_off();
    thread heli_death_thread();

    if(isDefined(self.riders) && istrue(self.riders.size)) {
      thread heli_crash_on_pilot_death();
      return;
    }

    return;
  }

  thread custom_vehicle_damage_function();
  thread vehicle_death_custom();
}

function custom_vehicle_damage_function() {
  self endon("death");

  while(isDefined(self)) {
    self waittill("damage", var0, var1);

    if(var0 < 350 || !isDefined(level.tank2)) {
      continue;
    }

    if(scripts\engine\utility::is_equal(level.tank2.mainturret, var1) && var0 > 380) {
      scripts\sp\utility::do_damage(self.health + 10000, self.origin, var1);
    }
  }
}

function init_trees() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  GscBinSkip1(0x45, "spruce_01", "foliage_tree_spruce_01_anim");
}

function helicopter_tree_watcher() {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(self)) {
    wait 0.1;
    var0 = getscriptablearrayinradius("spruce_tree", "targetname", self.origin, 2000);

    if(!isDefined(var0) || var0.size < 1) {
      continue;
    }

    foreach(var2 in var0) {
      if(!istrue(var2.tree_is_animating) && (!isendstr(var2.model, "destr") || !scripts\engine\utility::is_equal(var2 getscriptablepartstate("base", 1), "dead"))) {
        thread play_tree_animation(var2);
      }
    }
  }
}

function play_tree_animation(var0) {
  self.tree_is_animating = 1;
  play_tree_animation_internal(var0);
  self notify("reset_watcher");
  self.tree_is_animating = 0;
}

function play_tree_animation_internal(var0) {
  self endon("stop_tree_thread");
  GscBinSkip4(0x35);
}

function watch_for_tree_death() {
  self endon("reset_watcher");

  while(isDefined(self) && !scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "dead")) {
    waitframe();
  }

  if(!isendstr(self.model, "destr")) {
    self setModel(self.og_model);
  }

  self.tree_is_animating = 0;
  self notify("stop_tree_thread");
}

function pick_tree_anim(var0) {
  if(!isDefined(self) || scripts\engine\utility::is_equal(self getscriptablepartstate("base", 1), "dead")) {
    return;
  }

  var1 = tree_dist_check(var0);
  var2 = tree_dist_values(var1);
  var3 = "low";

  if(var1 > 800) {
    var3 = "low";
  } else if(var1 > 500) {
    var3 = "mid";
  } else if(var1 > 300) {
    var3 = "hi";
  }

  var4 = level.scr_anim[self.script_noteworthy][var3];
  return [var4, var2];
}

function anim_rate_watcher(var0, var1) {
  self endon("reset_watcher");

  for(;;) {
    var2 = tree_dist_check(var0);
    var3 = tree_dist_values(var2);
    self setanimrate(var1, var3);
    wait 0.3;
  }
}

function tree_dist_check(var0) {
  var1 = self gettagorigin("treea_tag_a_13", 1);

  if(!isDefined(var1)) {
    var1 = self.origin;
  }

  var2 = distance(var0.origin, var1);
  return var2;
}

function tree_dist_values(var0) {
  if(var0 > 800) {
    return 1;
  }

  if(var0 > 500) {
    return 1.2;
  }

  return 1.4;
}

function init_scriptable_trucks(var0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var1 = getscriptablearray(var0, "script_noteworthy");

  foreach(var3 in var1) {
    var4 = getscriptablearrayinradius(undefined, undefined, var3.origin, 80);

    if(isDefined(var4)) {
      foreach(var6 in var4) {
        if(var6 != var3) {
          var3.child = var6;
        }
      }
    }

    thread truck_damage_custom();
  }
}

function init_scriptable_reds(var0) {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var1 = getscriptablearray(var0, "script_noteworthy");

  foreach(var3 in var1) {
    thread red_damage_custom();
  }
}

function truck_damage_custom() {
  var0 = self.origin;

  while(isDefined(self)) {
    self waittill("damage", var1, var2, var3, var3, var4, var3, var3, var3, var3, var3);

    if(isDefined(self.child)) {
      self.child kill();
    }

    if(var1 < 300) {
      continue;
    }

    waitframe();

    if(isDefined(level.tank2) && scripts\engine\utility::is_equal(level.tank2.mainturret, var2) && var1 > 380 || isDefined(var4) && isexplosivedamagemod(var4) && var1 >= 100) {
      if(isDefined(self.child)) {
        if(self.child getscriptableparthasstate("base", "death")) {
          self.child setscriptablepartstate("base", "death");
        }
      }

      thread smoke_thread(var0);

      if(distance2dsquared(var0, level.player.origin) > 40000) {
        radiusdamage(var0, 150, 400, 350, undefined, "MOD_GRENADE");
        return;
      }

      radiusdamage(var0, 150, 60, 100, undefined, "MOD_GRENADE");
      return;
    }
  }
}

function smoke_thread(var0) {
  if(scripts\engine\utility::is_equal(self.script_noteworthy, "exploding_hill_trucks")) {
    wait 15;

    switch (randomint(3)) {
      case 1:
        playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_md"), var0);
        break;
      default:
        playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_sml"), var0);
        break;
    }

    return;
  }
}

function red_damage_custom() {
  var0 = self.origin;
  self waittill("damage");

  for(;;) {
    var1 = self getscriptableparthasstate("base", "dead");

    if(var1) {
      break;
    }

    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  if(distance2dsquared(var0, level.player.origin) > 40000) {
    radiusdamage(var0, 150, 300, 250, undefined, "MOD_GRENADE");
    return;
  }
}

function init_towers() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("guard_tower", "script_noteworthy");
  var1 = getscriptablearray("ridge_tower", "script_noteworthy");
  var1[0].ridge_tower = 1;
  var2 = scripts\engine\utility::array_combine(var0, var1);

  foreach(var4 in var2) {
    var5 = var4 scripts\engine\sp\utility::get_linked_struct();
    var4.nodes = getnodearray(var5.target, "targetname");
    var6 = getEntArray(var5.target, "targetname");

    foreach(var8 in var6) {
      switch (var8.classname) {
        case "script_brushmodel":
          var4.brushmodel = var8;
          break;
        case "trigger_multiple":
          var4.trigger = var8;
          break;
        default:
          break;
      }
    }

    thread guard_tower_logic();
  }
}

function magic_rpg_trig() {
  self waittill("trigger");
  var0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var2 in var0) {
    var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
    var4 = magicbullet("iw8_la_rpapa7_straight_slow", var2.origin, var3.origin);
    var4 playLoopSound("move_rpapa7_proj_flame");
    wait randomfloatrange(0.5, 1);
  }

  self delete();
}

function dont_drop_weapons() {
  self.noloot = 1;
  self.dontdropweapon = 1;
}

function drone_start() {}

function drone_main() {
  thread scripts\sp\hud_util::fade_out(0);
  scripts\engine\utility::delaythread(6, &scripts\sp\hud_util::fade_in, 1.5);
  level.player lerpfovscalefactor(0, 0);
  level.player scripts\engine\utility::delaycall(20, &lerpfovscalefactor, 1, 3);
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.01);
  scripts\sp\maps\lab\lab_util::cine_letterboxing_up(0);
  thread monitor_weapon_fire();
  scripts\sp\maps\lab\lab_lighting::drone_hero_lighting_setup();
  thread scripts\sp\maps\lab\lab_util::hide_hill_weapons();
  scripts\sp\maps\lab\lab_util::spawn_alex();
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  thread friendlies_on_bridge_move();
  thread friendlies_follow_tanks();
  var0 = scripts\engine\utility::array_remove_array(level.heroes, [level.alex, level.price, level.kyle, level.farah]);

  foreach(var2 in var0) {
    thread run_n_gun();
  }

  spawn_tank2();
  var4 = scripts\engine\utility::getStruct("bridge_scene", "targetname");
  var4 thread scripts\common\anim::anim_first_frame_solo(level.tank2, "bridge_scene");
  var5 = [level.farah, level.price, level.kyle];
  scripts\engine\utility::array_thread(var5, &scripts\engine\utility::disable_pain);
  level.player scripts\engine\utility::delaycall(0.4, &playsound, "scn_lab_intro_start_lr");
  drone_intro_scene();
  scripts\engine\utility::flag_set("allow_green_beam");
  scripts\sp\maps\lab\lab_vo_util::init_callout_vo();
  level.drone_updater = 1;
}

function drone_catchup() {
  if(!scripts\sp\starts::is_after_start("lab_entrance")) {
    scripts\engine\utility::flag_set("allow_green_beam");
    scripts\sp\maps\lab\lab_vo_util::init_callout_vo();
    level.drone_updater = 1;
  }

  level.onlydroneused = 0;
  scripts\sp\maps\lab\lab_util::trigger_nearest_friendly_respawn_trigger();
  scripts\engine\utility::flag_set("introscreen_start_wait");
}

function monitor_weapon_fire() {
  level endon("hill_finished_trig");
  level endon("drone_achievement_failed");
  level.onlydroneused = 1;
  GscBinSkip4(0x35);
}

function monitor_grenade_fire() {
  self waittill("grenade_fire", var0, var1);
  level.onlydroneused = 0;
  level notify("drone_achievement_failed");
}

function friendlies_on_bridge_move() {
  if(isDefined(level.alex)) {
    var0 = [level.farah, level.price, level.kyle, level.alex];
  } else {
    var0 = [level.farah, level.price, level.kyle];
  }

  var1 = scripts\engine\utility::array_remove_array(scripts\sp\maps\lab\lab_util::rebuild_heroes_array(), var0);

  foreach(var3 in var1) {
    var3.dontavoidplayer = 1;
    var3.nododgemove = 1;
    var3 visiblenotsolid();
    var3 scripts\engine\utility::set_movement_speed(90);
  }

  scripts\sp\maps\lab\lab_util::move_lab_allies("bridge_heroes", var1);
  scripts\engine\utility::flag_wait("drone_scene_done");
  var1 = scripts\engine\utility::array_remove_array(scripts\sp\maps\lab\lab_util::rebuild_heroes_array(), var0);

  foreach(var3 in var1) {
    var3.dontavoidplayer = 0;
    var3.nododgemove = 0;
    var3 visiblesolid();
    var3 scripts\common\utility::clear_movement_speed();
  }
}

function run_n_gun() {
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

function vo_bridge() {
  level endon("post_bridge_shooting");
  level scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_lass_bridge_moving_90");
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_bridge_moving_100");
  level scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_lass_bridge_moving_110");
  wait 15;
  var0 = ["dx_vom_pri_bridge_moving_140", "dx_vom_pri_bridge_moving_150", "dx_vom_pri_bridge_moving_160"];
  level.price scripts\sp\maps\lab\lab_vo_util::nagtill("post_bridge_shooting", var0, 8);
}

function drone_intro_scene() {
  visionsetnaked("lab_intro_drone", 0.1);

  if(isDefined(level.fade)) {
    level.fade fadeovertime(0.1);
    level.fade.alpha = 0;
  }

  var0 = scripts\engine\utility::getStruct("bridge_scene", "targetname");
  var1 = setup_bridge_missile();
  level.fakedrone = setup_bridge_drone(var1);
  var0 thread scripts\common\anim::anim_first_frame_solo(level.fakedrone, "bridge_scene");
  level.baddies = spawn_bridge_badies("intro_enemies");
  var0 thread scripts\common\anim::anim_first_frame(level.baddies, "bridge_scene");
  arm_player();
  var0 scripts\sp\player_rig::link_player_to_rig("bridge_scene", undefined, 0, undefined, 1, 0, 0, 0, 0);
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
  thread drone_intro_cine_camera_settings(var1);
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\engine\sp\utility::name_hide);
  level.tank2 setvehiclelookattext("", &"");
  thread missile_logic(var0);
  var2 = thread debris_logic();
  var0 thread scripts\common\anim::anim_single(level.baddies, "bridge_scene");
  var0 thread scripts\common\anim::anim_single_solo(level.tank2, "bridge_scene");
  var3 = [level.alex, level.price, level.farah, level.kyle];
  var0 scripts\common\anim::anim_single(var3, "bridge_scene");
  level.alex scripts\sp\maps\lab\lab_util::disable_magic_bullet_delete();
  scripts\sp\maps\lab\lab_util::unlink_player_from_rig_lab();
  level.player disableinvulnerability();
  level.player freezecontrols(0);
  level.player showlegsandshadow();
  level.player playerenabletriggers();
  level.player scripts\common\utility::allow_cinematic_motion(1);
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 1);
  scripts\engine\sp\utility::autosave_by_name("drone_intro");
  level.heroes = scripts\sp\maps\lab\lab_util::rebuild_heroes_array();
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\engine\sp\utility::name_show);
  scripts\engine\utility::array_delete(var2);
  level.tank2 setvehiclelookattext("Viper", &"");
  visionsetnaked("", 1.5);
  scripts\engine\utility::flag_set("introscreen_start_wait");
  setomnvar("ui_is_bink_skipping_enabled", 1);
}

function drone_intro_cine_camera_settings(var0) {
  var0 thread scripts\engine\sp\utility::dof_enable_autofocus(12, 10, undefined, undefined);
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

function setup_bridge_missile() {
  var0 = getEnt("bridge_missile", "targetname");
  var0 scripts\engine\sp\utility::assign_animtree("missile");
  level.missle = var0;
  return var0;
}

function setup_bridge_drone(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 setModel("veh8_mil_air_mquebec9_small");
  var1 scripts\engine\sp\utility::assign_animtree("drone");
  return var1;
}

function spawn_bridge_badies(var0) {
  var1 = scripts\engine\sp\utility::array_spawn_targetname(var0, 1, 1);
  var2 = [];

  foreach(var4 in var1) {
    var4 setentitytarget(level.tank2);

    if(isDefined(var4.animname)) {
      var2 = var4;
      thread bridge_guys_die();
    }
  }

  return var2;
}

function arm_player() {
  GscBinSkip1(0x45, 0, scripts\sp\maps\lab\lab_util::make_bulletdrop_weapon());
}

function missile_logic(var0) {
  var1 = spawn("script_model", var0.origin);
  var1.angles = var0.angles;
  var1 setModel(var0.model);
  var1 hide();
  var1 scripts\engine\sp\utility::assign_animtree("missile_light");
  var1 thread scripts\sp\maps\lab\lab_lighting::drone_hero_lighting_on();
  var2 = scripts\engine\utility::getStructArray("bridge_missles", "targetname");
  scripts\engine\utility::delaythread(24, &bridge_crawlers);
  thread spawn_intro_trucks();
  level.tank2 scripts\engine\utility::delaythread(7.5, &bridge_tank_shoots);
  thread scripts\common\anim::anim_single_solo(level.fakedrone, "bridge_scene");
  scripts\common\anim::anim_single([var0, var1, level.player_rig], "bridge_scene");
  scripts\engine\utility::delaythread(4, &scripts\common\vehicle::spawn_vehicles_from_targetname_and_drive, "bridge_heli");
  level.fakedrone delete();
  var3 = var0.origin;
  level.player clearclienttriggeraudiozone(0.3);

  if(isDefined(var3)) {
    level.player playSound("scn_lab_intro_explo_lr");
    level.player setclienttriggeraudiozone("lab_intro_post_explo", 1);
    level.player scripts\engine\utility::delaycall(1, &clearclienttriggeraudiozone, 2);
    level.player viewkick(6, var3, 0);
    earthquake(0.3, 1.5, level.player.origin, 400);
    playrumbleonposition("damage_heavy", level.player.origin);
    var4 = getaiarrayinradius(var0.origin, 1000, "axis");
    var4 = scripts\engine\utility::array_remove_array(var4, level.baddies);
    var5 = scripts\engine\utility::get_array_of_closest(var3, scripts\engine\sp\utility::getvehiclearray(), [level.tank2], undefined, 1200, 0);
    var6 = scripts\engine\utility::array_combine(var4, var5);
    var6 = scripts\engine\utility::array_removeundefined(var6);

    foreach(var8 in var6) {
      var8 scripts\sp\utility::do_damage(var8.health + 1, var3, level.player, undefined, "MOD_EXPLOSIVE");
    }

    foreach(var11 in getscriptablearray("bridge_trees", "targetname")) {
      var11 setscriptablepartstate("base", "death");
    }

    scripts\engine\utility::exploder("bridge_bomb");
  }

  level notify("delete_drone_light");
  visionsetnaked("lab_intro_sss", 3.55);
  var0 delete();
  scripts\engine\utility::delaythread(12, &scripts\engine\sp\utility::array_spawn_targetname, "bunker_runners", 1, 1);
  scripts\engine\utility::delaythread(10, &scripted_bridge_shot);
  scripts\engine\utility::flag_set("bridge_move_up");
  scripts\engine\utility::flag_set_delayed("bridge_move_up_b", 6);
}

function debris_logic() {
  var0 = make_debris("debris_01", "debris_concrete_rubble_floor_slab_chunk_small_01");
  thread scripts\common\anim::anim_single_solo(var0, "bridge_scene");
  var1 = make_debris("debris_02", "debris_concrete_rubble_floor_slab_chunk_small_04");
  thread scripts\common\anim::anim_single_solo(var1, "bridge_scene");
  var2 = make_debris("debris_03", "debris_concrete_rubble_floor_slab_chunk_small_07");
  thread scripts\common\anim::anim_single_solo(var2, "bridge_scene");
  return [var0, var1, var2];
}

function make_debris(var0, var1) {
  var2 = spawn("script_model", self.origin);
  var2 scripts\engine\sp\utility::assign_animtree(var0);
  var2 setModel(var1);
  return var2;
}

function bridge_crawlers() {
  level.crawlers = scripts\engine\sp\utility::array_spawn_targetname("intro_enemies_crawl", 1, 1);
  force_long_death_on_back_with_pistol_lab(level.crawlers[0], 3);
  force_long_death_on_back_with_pistol_lab(level.crawlers[1], 3);
  force_long_death_on_back_with_pistol_lab(level.crawlers[2], 1);
  force_long_death_on_back_with_pistol_lab(level.crawlers[3], 4);
  force_long_death_on_back_with_pistol_lab(level.crawlers[4], 1);
}

function force_long_death_on_back_with_pistol_lab(var0) {
  self.forcelongdeath = var0;
  self.longdeathnoncombat = 1;
  scripts\engine\sp\utility::set_attackeraccuracy(1);
  self asmsetstate(self.asmname, "choose_long_death");
}

function spawn_intro_trucks() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("intro_truck_1");
  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname("intro_truck_2");
  scripts\engine\utility::delaythread(1, &scripts\common\vehicle_paths::gopath, var0);
  scripts\engine\utility::delaythread(2, &scripts\common\vehicle_paths::gopath, var1);
}

function bridge_tank_shoots() {
  wait 0.5;
  self.mainturret notify("stop_burst_fire_unmanned");
  scripts\vehicle\bromeo::mainturret_idle();
  var0 = scripts\engine\utility::getStruct("bridge_tank_shoots", "targetname");
  self.mainturret.target_ent.origin = var0.origin;
  self.mainturret settargetentity(self.mainturret.target_ent, scripts\engine\utility::randomvector(20));
  var1 = gettime();

  while(gettime() < var1 + 4000) {
    tank_shot();
    wait 0.1 + randomfloat(0.6);
  }
}

function baddies_die() {
  self endon("death");

  if(isalive(self)) {
    scripts\engine\sp\utility::die();
    return;
  }
}

function bridge_guys_die() {
  scripts\common\ai::magic_bullet_shield();
  self.ragdoll_immediate = 1;
  self.allowdeath = 1;
  self waittillmatch("single anim", "end");
  scripts\common\ai::stop_magic_bullet_shield();
  self kill();
}

function bridge_start() {
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  spawn_tank2();
  scripts\engine\sp\utility::set_start_location("bridge_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  arm_player();
  friendlies_on_bridge_move();
  scripts\engine\utility::flag_set("bridge_move_up");
  scripts\engine\utility::flag_set("bridge_move_up_b");
  scripts\engine\utility::flag_set("drone_scene_done");

  foreach(var1 in getscriptablearray("bridge_trees", "targetname")) {
    var1 setscriptablepartstate("base", "death");
  }
}

function bridge_main() {
  scripts\sp\maps\lab\lab_util::rebuild_heroes_array();
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\utility::array_thread(level.heroes, &scripts\engine\sp\utility::set_ignoresuppression, 1);
  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], &scripts\engine\utility::disable_pain);
  var0 = [level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5];
  scripts\engine\utility::array_thread(var0, &scripts\engine\sp\utility::enable_dynamic_run_speed, level.tank2, 125, 190, 250);
  scripts\engine\utility::delaythread(0.1, &scripts\common\vehicle_paths::gopath, level.tank2);
  thread friendlies_end_of_bridge();
  thread vo_bridge();
  scripts\engine\utility::flag_wait("player_at_intro_checkpoint");
  thread scripts\engine\sp\utility::transient_unload("lab_drone_tr");
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::autosave_by_name, "post_bridge_clear");
  scripts\sp\maps\lab\lab_util::array_thread_safe(var0, &scripts\engine\sp\utility::disable_dynamic_run_speed);
  scripts\engine\utility::array_thread(level.heroes, &scripts\engine\sp\utility::set_ignoresuppression, 0);
  thread scripts\sp\analytics::analytics_kleenex_update("hill_intro_stopwatch");
}

function scripted_bridge_shot() {
  var0 = scripts\engine\utility::getStruct("scripted_bridge_shot", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("fake_rebel_1", 1);
  var2 = scripts\engine\sp\utility::spawn_targetname("fake_rebel_2", 1);
  bridge_guy_setup(var1);
  bridge_guy_setup(var2);
  scripts\engine\utility::flag_wait("scripted_bridge_shot");
  shoot_bridge_guy(var1, var0, 0.5);
  shoot_bridge_guy(var2, var0, 1.2);
}

function bridge_guy_setup() {
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  self enableavoidance(0, 1);
}

function shoot_bridge_guy(var0, var1) {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  while(isDefined(self) && !scripts\engine\utility::within_fov(var0.origin, var0.angles, self getEye(), level.cos30)) {
    waitframe();
  }

  wait var1;

  if(isDefined(self)) {
    magicbullet("iw8_sn_alpha50", var0.origin, self getEye());
    return;
  }
}

function bridge_catchup() {
  var0 = getEntArray("bridge_triggers", "targetname");
  thread scripts\engine\utility::array_delete(var0);

  if(!scripts\sp\starts::is_after_start("lab_entrance")) {
    scripts\engine\utility::flag_set("player_at_intro_checkpoint");
    scripts\engine\utility::flag_set("post_bridge_shooting");
    return;
  }
}

function friendlies_end_of_bridge() {
  scripts\engine\utility::flag_wait("bridge_tanks_stopped");
  thread tutorial_flood_init();
  var0 = [level.price, level.farah, level.kyle];

  if(!scripts\engine\utility::flag("tank_proceed_1")) {
    scripts\sp\maps\lab\lab_util::array_thread_safe(var0, &stop_following_ent);
    scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_intro_checkpoint");
  }

  var0 = scripts\engine\utility::array_remove_array(level.heroes, var0);
  scripts\sp\maps\lab\lab_util::array_thread_safe(var0, &scripts\engine\sp\utility::enable_ai_color);
}

function tunnel_start() {
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  spawn_tank2("tank_2_tunnel_node");
  scripts\engine\sp\utility::set_start_location("uphill_intro_tunnel_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  scripts\engine\sp\utility::array_spawn_targetname("post_bridge_gate_trucks", 1, 1);

  if(!scripts\engine\utility::flag("tank_proceed_1")) {
    scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_intro_checkpoint");
  }

  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], &scripts\engine\utility::disable_pain);
}

function tunnel_main() {
  scripts\engine\utility::array_thread(level.heroes, &run_n_gun);
  thread remove_road_corner_ai_clip_watcher();
  thread fence_ai_clear();
  thread vo_drone_tutorial();
  thread start_the_drone_hint();
  ridge_tree_init();
  thread sfx_bottom_hill_trucks();
  scripts\engine\utility::flag_wait("tank_proceed_1");
  var0 = thread scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("checkpoint_reinforcements_high_heli");
  scripts\engine\sp\utility::autosave_by_name("drone_tutorial_clear");
  var1 = getnodearray("stop_1_nodes", "targetname");
  scripts\engine\utility::array_call(var1, &disconnectnode);
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\engine\sp\utility::set_ignoresuppression, 1);
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\sp\maps\lab\lab_util::toggle_ignore_all);
  scripts\engine\sp\utility::array_spawn_targetname("checkpoint_reinforcements_high_tower", 1, 1);
  thread friendlies_follow_tanks();
  scripts\engine\utility::delaythread(2.5, &scripts\engine\sp\utility::activate_trigger_with_noteworthy, "push_tutorial_section");
  var2 = scripts\engine\utility::array_remove_array(level.heroes, [level.price, level.farah, level.kyle]);
  scripts\sp\maps\lab\lab_util::array_thread_safe(var2, &scripts\engine\utility::set_movement_speed, 130);
  scripts\sp\maps\lab\lab_util::array_thread_safe(var2, &reset_speed_at_node);
  scripts\engine\utility::flag_wait("ridge_tanks_stopped");
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\sp\maps\lab\lab_util::toggle_ignore_all);

  if(!scripts\engine\utility::flag("tank_proceed_5")) {
    scripts\sp\maps\lab\lab_util::array_thread_safe([level.price, level.farah, level.kyle], &stop_following_ent);
  }

  scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_ridge_checkpoint");
  scripts\sp\maps\lab\lab_util::array_thread_safe(level.heroes, &scripts\engine\sp\utility::set_ignoresuppression, 0);
  thread checkpoint_ai_check("checkpoint_b_high_guys", 6, "tank_proceed_5", undefined, "player_past_stop_1");
  scripts\engine\utility::flag_wait("tank_proceed_5");
  var1 = getnodearray("stop_2_nodes", "targetname");
  scripts\engine\utility::array_call(var1, &disconnectnode);

  if(!scripts\engine\utility::flag("tank_proceed_5_rush")) {
    thread scripts\engine\sp\utility::array_spawn_targetname("hill_bottom_tree_enemies", 1, 1);
  }

  thread enemy_sight_increased();
  scripts\engine\sp\utility::autosave_by_name("ridge_1_clear");
  thread friendlies_follow_tanks();
  scripts\engine\utility::delaythread(3, &scripts\engine\sp\utility::activate_trigger_with_noteworthy, "squad_to_stop_3");
}

function sfx_bottom_hill_trucks() {
  thread scripts\engine\utility::play_sound_in_space("scn_lab_hill_bottom_truck_driveins", (10402, 5853, -1186));
}

function tutorial_flood_init() {
  wait 2;

  if(scripts\engine\utility::flag("stop_tut_floods")) {
    return;
  }

  var0 = getspawnerarray("tutorial_flood");

  foreach(var2 in var0) {
    thread tut_flood();
  }

  scripts\engine\utility::flag_wait("stop_tut_floods");

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      if(isDefined(var2.guy)) {
        var2.guy delete();
      }

      var2 delete();
    }
  }
}

function tut_flood() {
  self endon("death");
  level endon("stop_tut_floods");
  self.count += 1;
  var0 = scripts\engine\sp\utility::spawn_ai();

  while(isDefined(self) && !scripts\engine\utility::flag("stop_tut_floods")) {
    if(isDefined(var0)) {
      self.count += 1;
      self.guy = var0;
      var0 endon("entitydeleted");
      var0 waittill("death");
      wait 1;

      while(scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, self.origin, [level.player])) {
        wait 0.15;
      }

      var0 = self stalingradspawn();
      continue;
    }

    wait 1;
  }
}

function tunnel_catchup() {
  if(!scripts\sp\starts::is_after_start("lab_entrance")) {
    thread scripts\sp\maps\lab\lab_vo_util::init_drone_vo();
  }

  scripts\engine\utility::flag_set("tank_proceed_1");
  scripts\engine\utility::flag_set("tank_proceed_5");
  scripts\engine\utility::flag_set("player_past_stop_1");
}

function start_the_drone_hint() {
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_drone_tutorial_intro_60");
  scripts\engine\utility::flag_set("start_green_beam_instruct");

  if(!isDefined(level.last_beam_time)) {
    level scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_uavoperator_drone_tutorial_laseconf_ready_20", 0, 2);
  }

  thread scripts\sp\maps\lab\lab_vo_util::init_drone_vo();
}

function ridge_tree_init() {
  var0 = getscriptablearrayinradius("spruce_tree", "targetname", (10045.7, 3912.01, -729.359), 400);

  foreach(var2 in var0) {
    thread ridge_tree_logic();
  }
}

function ridge_tree_logic() {
  level endon("tank_proceed_5");

  for(;;) {
    self waittill("damage", var0, var1, var2, var2, var3, var2, var2, var2, var2, var2);

    if(var0 < 49) {
      continue;
    }

    if(isDefined(level.tank2) && scripts\engine\utility::is_equal(level.tank2.mainturret, var1) && var0 >= 380 || isDefined(var3) && isexplosivedamagemod(var3) && var0 >= 50) {
      self setscriptablepartstate("base", "death");
    }
  }
}

function remove_node_clip(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var3 connectpaths();
  }
}

function fence_ai_clear() {
  scripts\engine\sp\utility::waittill_ai_group_dead("fence_enemies");
  scripts\engine\utility::flag_set("tank_proceed_1");
}

function vo_drone_tutorial() {
  level scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_drone_tutorial_intro_10");
  scripts\engine\utility::flag_wait("tank_proceed_1");
  wait 2;
  level scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_drone_tutorial_intro_20");
}

function reset_speed_at_node() {
  self endon("death");
  wait 3;
  self waittill("goal");
  scripts\common\utility::clear_movement_speed();
}

function spawn_tank2(var0) {
  var1 = 0;
  var2 = scripts\common\utility::getvehiclespawner("convoy_tank_2", "targetname");

  if(isDefined(var0)) {
    var2.target = var0;
    var1 = 1;
  }

  var3 = getEntArray("tank2_follow_spots", "targetname");

  foreach(var6, var5 in var3) {
    var5.tovehiclevector = var5.origin - var2.origin;
    var5.tovehiclelocaloffset = rotatevectorinverted(var5.tovehiclevector, var2.angles);
  }

  var7 = getEntArray("tank_poi", "script_noteworthy");

  foreach(var6, var5 in var7) {
    var5.tovehiclevector = var5.origin - var2.origin;
    var5.tovehiclelocaloffset = rotatevectorinverted(var5.tovehiclevector, var2.angles);
  }

  level.tank2 = scripts\common\vehicle::spawn_vehicle_from_targetname("convoy_tank_2");
  level.tank2 scripts\engine\utility::ent_flag_init("ready_to_turn_left");
  level.tank2 scripts\engine\utility::ent_flag_init("end_of_the_line");
  level.tank2 scripts\engine\utility::ent_flag_init("reset_shooting");
  waitframe();

  foreach(var6, var5 in var3) {
    var10 = rotatevector(var5.tovehiclelocaloffset, level.tank2.angles);
    var5.origin = level.tank2.origin + var10;
    var5 linkTo(level.tank2);
  }

  level.tank2.follow_ents = var3;

  foreach(var5 in var7) {
    var10 = rotatevector(var5.tovehiclelocaloffset, level.tank2.angles);
    var5.origin = level.tank2.origin + var10;
    var5 linkTo(level.tank2);

    if(isDefined(var5.script_linkname)) {
      switch (var5.script_linkname) {
        case "farah":
          level.tank2.farah_poi = var5;
          break;
        case "kyle":
          level.tank2.kyle_poi = var5;
          break;
        default:
          level.tank2.price_poi = var5;
          break;
      }
    }
  }

  level.vehicle.templates.deathmodel["veh8_mil_lnd_bromeo"] = "veh8_mil_lnd_bromeo_animated_dst";

  if(var1) {
    scripts\engine\utility::delaythread(0.1, &scripts\common\vehicle_paths::gopath, level.tank2);
  }

  level.tank2 setvehiclelookattext("Viper", &"");
  GscBinSkip4(0x6e, level.tank2);
}

function player_behind_tank_think() {
  player_behind_tank_think_internal();
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
}

function player_behind_tank_think_internal() {
  var0 = 1;

  while(isDefined(self)) {
    var1 = scripts\engine\math::is_point_in_front(level.player.origin);

    if(var1 && !var0) {
      level.player scripts\sp\utility::set_player_attacker_accuracy(1);
    } else if(!var1 && var0) {
      level.player scripts\sp\utility::set_player_attacker_accuracy(0.3);
    }

    var0 = var1;
    waitframe();
  }
}

function friendly_tank_force_target(var0, var1) {
  scripts\vehicle\bromeo::mainturret_idle();
  self.mainturret settargetentity(var0, (0, 0, 30));

  while(isalive(var0) && !is_aimed_at_target(var0)) {
    wait 0.1;
  }

  if(!isalive(var0)) {
    return;
  }

  var2 = -15;
  var3 = 15;
  var4 = randomintrange(4, 6);

  for(var5 = 0; var5 < var4; var5++) {
    if(!isalive(var0)) {
      break;
    }

    if(istrue(var1) && var5 > 2 && isalive(var0)) {
      var0 kill();
    }

    self.mainturret settargetentity(var0, (0, 0, 30) + scripts\engine\utility::randomvectorrange(var2, var3));
    tank_shot();
    wait 0.4 + randomfloat(0.15);
  }

  scripts\vehicle\bromeo::mainturret_attack();
}

function friendly_nav_repulsor(var0, var1) {
  var2 = scripts\engine\utility::ter_op(isDefined(var1), var1, 180);

  if(var0) {
    createnavrepulsor("tank " + self getentitynumber(), -1, self, var2, 1);
    return;
  }

  if(!var0) {
    destroynavrepulsor("tank " + self getentitynumber());
    return;
  }
}

function tank_interact() {
  for(;;) {
    self waittillmatch("noteworthy", "interact");
    scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 64), &"LAB/CURSOR_MOVEUP", undefined, 1024, 1000, 1);
    scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "trigger");
    level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, self.currentnode.script_flag_wait);
    scripts\engine\sp\utility::do_wait_any();
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    scripts\engine\utility::flag_set(self.currentnode.script_flag_wait);
  }
}

function tank_engine_sfx() {
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

    while(self vehicle_getspeed() < 1) {
      wait 0.2;
    }

    self playSound("veh_bradley_engine_start");

    if(isDefined(self.idle_sfx)) {
      self.idle_sfx scripts\engine\sp\utility::sound_fade_and_delete(1, 1);
    }

    wait 1.5;
    self playLoopSound("veh_bradley_engine_lp");

    while(self vehicle_getspeed() > 1) {
      wait 0.2;
    }
  }
}

function player_fullads() {
  return level.player playerads() == 1;
}

function player_zoomingsniper() {
  return level.player meleeButtonPressed() && player_fullads() && level.player scripts\sp\maps\lab\lab_util::using_bulletdrop_weapon();
}

function hill_bottom_start() {
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("hill_bottom_start_struct", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  spawn_tank2("hill_bottom_start_2");
  thread enemy_sight_increased();
  thread scripts\engine\sp\utility::array_spawn_targetname("hill_bottom_tree_enemies", 1, 1);
  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], &scripts\engine\utility::disable_pain);
}

function hill_bottom_main() {
  scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\lab\lab_util::allies_molotov_toggle, 1);
  var0 = [level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5];
  scripts\sp\maps\lab\lab_util::array_thread_safe(var0, &scripts\sp\maps\lab\lab_util::allies_molotov_toggle, 1);
  thread scripts\sp\maps\lab\lab_util::wind_setdirection("south", (-30, -80, 0), 4000);
  thread vo_hill_charge();
  scripts\sp\player_death::set_custom_death_quote(70);
  thread vo_hill_bottom();
  thread friendlies_follow_tanks();
  scripts\engine\utility::flag_wait("ridge_2_tanks_stopped");
  thread checkpoint_ai_check("tree_ledge_truckers", 6, "tank_proceed_6", "woods_fallback", "player_past_stop_2");
  scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_stop_4");
  scripts\engine\utility::array_thread([level.price, level.kyle, level.farah], &stop_following_ent);
  scripts\engine\utility::flag_wait("tank_proceed_6");
  var1 = getnodearray("stop_3_nodes", "targetname");
  scripts\engine\utility::array_call(var1, &disconnectnode);
  scripts\engine\utility::delaythread(8, &scripts\engine\sp\utility::activate_trigger_with_noteworthy, "squad_to_stop_5");
  var2 = scripts\common\vehicle::spawn_vehicle_from_targetname("hill_bottom_heli");
  thread scripts\common\vehicle_paths::gopath(var2);
  scripts\engine\sp\utility::autosave_by_name("tank_3_stop");
  thread friendlies_follow_tanks();
  scripts\engine\utility::flag_wait("ridge_3_tanks_stopped");
  scripts\engine\utility::array_thread([level.price, level.kyle, level.farah], &stop_following_ent);
  thread checkpoint_ai_check("hill_cliff_car_guys", 3, "tank_proceed_7", "bunker_fallback", "player_past_stop_3");
  scripts\engine\utility::flag_wait("tank_proceed_7");
  var1 = getnodearray("stop_4_nodes", "targetname");
  scripts\engine\utility::array_call(var1, &disconnectnode);
  scripts\engine\sp\utility::autosave_by_name("tank_4_stop");
  thread friendlies_follow_tanks();
  scripts\engine\utility::flag_wait_any("midhill_guys", "woods_fallback");
  scripts\engine\utility::delaythread(10, &scripts\engine\sp\utility::array_spawn_targetname, "hill_charge_rpg", 1, 1);
  scripts\engine\sp\utility::array_spawn_targetname("midhill_guys_lot_1", 0, 1);
  thread tank_rpg_death();
  scripts\engine\utility::flag_wait("hill_mid_tank_stopped");
  var3 = 0;
  scripts\sp\maps\lab\lab_util::array_thread_safe([level.price, level.kyle, level.farah], &scripts\engine\sp\utility::enable_ai_color);

  if(!scripts\engine\utility::flag("player_past_stop_4")) {
    scripts\engine\utility::array_thread([level.price, level.kyle, level.farah], &stop_following_ent);
    scripts\engine\sp\utility::activate_trigger_with_noteworthy("squad_to_stop_6");
    var3 = 1;
  }

  scripts\engine\utility::flag_wait_all("go_left", "player_past_stop_4");

  if(!istrue(var3)) {
    scripts\sp\maps\lab\lab_util::array_thread_safe([level.price, level.kyle, level.farah], &stop_following_ent);
  }

  scripts\engine\sp\utility::activate_trigger_with_noteworthy("tank_death_color");
  scripts\engine\utility::flag_set("tank_proceed_8");
  var1 = getnodearray("stop_5_nodes", "targetname");
  scripts\engine\utility::array_call(var1, &disconnectnode);
  scripts\engine\utility::array_thread([level.price, level.farah, level.kyle], &scripts\engine\utility::enable_pain);
}

function hill_bottom_catchup() {
  scripts\engine\utility::flag_set("hill_charge_started");
  scripts\engine\utility::flag_set("go_left");
  scripts\engine\utility::flag_set("tank_1_last_stop");
  thread remove_road_corner_ai_clip();

  if(!scripts\sp\starts::is_after_start("hill_top")) {
    scripts\engine\sp\utility::add_global_spawn_function("allies", &scripts\sp\maps\lab\lab_util::allies_molotov_toggle, 1);
    return;
  }
}

function checkpoint_ai_check(var0, var1, var2, var3, var4) {
  level endon(var2);
  wait 1;
  var5 = gettime() + 40000;

  while(scripts\engine\sp\utility::get_ai_group_death_count(var0) < var1 && gettime() < var5) {
    wait 0.5;
  }

  if(isDefined(var4)) {
    scripts\engine\utility::flag_wait(var4);
  }

  if(isDefined(var3)) {
    scripts\engine\utility::flag_set(var3);
  }

  wait 5;
  scripts\engine\utility::flag_set(var2);
}

function heli_crash_swap() {
  level endon("hill_finished_trig");
  var0 = getEntArray("crash_script_models", "targetname");
  var1 = getEnt("heli_clip", "targetname");
  var2 = getEnt("burnt_terrain_patch", "targetname");
  var3 = getEnt("pristine_terrain_patch", "targetname");
  var2 connectpaths();
  var4 = scripts\engine\utility::array_combine(var0, [var1], [var2]);
  scripts\engine\utility::flag_wait("hill_crash_site");
  var3 hide();
  var3 notsolid();
  var1 solid();
  var2 solid();

  foreach(var6 in var4) {
    var6 show();
  }
}

function vo_hill_charge() {
  wait 1;
  var0 = 0;

  if(isDefined(level._ai_group["checkpoint_b_high_guys"]) && isDefined(level._ai_group["checkpoint_b_high_guys"].ai)) {
    foreach(var2 in level._ai_group["checkpoint_b_high_guys"].ai) {
      if(isalive(var2)) {
        var0 = 1;
      }
    }
  }

  if(var0) {
    level.price thread scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_pipes_outdoor_callout_machineguns_70");
  } else {
    level.price thread scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_drone_tutorial_transition_10");
  }

  tank_moveup_nag("tank_proceed_6");
  wait 1.5;
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_bottom_charge_10");
  level.farah scripts\engine\utility::waittill_notify_or_timeout("weapon_fired", 5);
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_bottom_charge_20");
  var4 = sortbydistance(getaiarray("allies"), level.player.origin);
  var5 = scripts\engine\sp\utility::create_deck(["dx_vom_fsa1_hill_bottom_charge_30", "dx_vom_fsa2_hill_bottom_charge_40", "dx_vom_fsa3_hill_bottom_charge_50"]);

  foreach(var7 in var4) {
    if(var7 == level.price || var7 == level.farah || var7 == level.kyle) {
      continue;
    }

    var7 thread scripts\sp\maps\lab\lab_vo_util::say(var5 scripts\engine\sp\utility::deck_draw());
    wait randomfloatrange(0.05, 0.15);
  }

  scripts\engine\utility::flag_wait("tank_proceed_7");
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_bottom_charge_14");
  wait 1;
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_bottom_charge_13");
  wait 8;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_bottom_charge_21");
  wait 1;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_bottom_charge_22");
  scripts\engine\utility::flag_wait("tank_proceed_8");
  wait 8;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_bottom_charge_23");
  wait 1;
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_bottom_charge_24");
  wait 8;
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_bottom_charge_11");
  wait 1;
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_bottom_charge_12");
}

function high_tower_guys_cleanup() {
  var0 = getEntArray("tut_tower_volumes", "script_noteworthy");
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3 scripts\engine\sp\utility::get_ai_touching_volume();

    if(var4.size) {
      var1 = scripts\engine\utility::array_combine(var4, var1);
    }
  }

  if(var1.size) {
    thread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var1, 600);
    return;
  }
}

function remove_road_corner_ai_clip_watcher() {
  scripts\engine\utility::flag_wait("remove_corner_clip");
  remove_road_corner_ai_clip();
}

function remove_road_corner_ai_clip() {
  var0 = getEntArray("corner_ai_clip", "targetname");

  if(!isDefined(var0) || !isarray(var0)) {
    return;
  }

  foreach(var2 in var0) {
    var2 connectpaths();
    var2 delete();
  }
}

function vo_hill_bottom() {
  scripts\engine\utility::flag_wait("go_left");
  wait 4;
  level.kyle scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_kyle_hill_bottom_callout_rpg_100", 1, 1);
}

function turret_operator() {
  self endon("death");
  thread scripts\common\ai::magic_bullet_shield();
  self.damage_functions[self.damage_functions.size] = &turret_owner_damage_func;
  var0 = undefined;

  while(!isDefined(var0)) {
    var0 = self getturret();
    waitframe();
  }

  self notify("stop_using_built_in_burst_fire");
  var0 setturretteam("axis");
  var0 setrightarc(180);
  var0 setleftarc(180);
  var0 setbottomarc(180);
  var0 settoparc(180);
  var0 setconvergencetime(0.05, "yaw");
  var0 setconvergencetime(0.05, "pitch");
  var0.accuracy = 0.9;
  var0.maxrange = 50000;
  var0.aispread = 0;
  var0 setmode("manual_ai");
  var0.health = 99999;
  GscBinSkip4(0x6e, var0, self);
}

function turret_logic(var0) {
  level endon("tank_death");
  wait 6;

  for(;;) {
    var1 = undefined;
    var2 = 0;

    if(isDefined(level.corner_redshirts)) {
      foreach(var4 in level.corner_redshirts) {
        if(isalive(var4)) {
          var2 = 1;
          var4.health = 10;
          var1 = var4;
        }
      }
    } else if(randomint(100) < 60) {
      var1 = level.player;
    } else {
      foreach(var4 in level.heroes) {
        if(!isDefined(var4.magic_bullet_shield)) {
          var1 = var4;
          break;
        }
      }
    }

    if(!isalive(var1)) {
      waitframe();
      continue;
    }

    self settargetentity(var1);
    var8 = randomintrange(30, 50);
    var9 = var1.health;

    for(var10 = 0; var10 < var8; var10++) {
      if(!isalive(var1)) {
        break;
      }

      self settargetentity(var1);

      if(var2) {
        var11 = 1;
        var12 = 2;
      } else if(isPlayer(var1) && shouldshootplayer()) {
        var11 = 16;
        var12 = 18;
      } else {
        var11 = 18;
        var12 = 23;
      }

      magicbullet("iw8_lm_pkilo", self gettagorigin("tag_flash"), var1 getEye() + scripts\engine\utility::randomvectorrange(var11, var12));
      wait 0.05 + randomfloat(0.15);
    }

    wait 2 + randomfloat(1);
  }
}

function turret_owner_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1) && var1 == level.player) {
    scripts\sp\maps\lab\lab_util::stop_magic_bullet_safe();
    return;
  }
}

function hill_mid_start() {
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("hill_mid_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  spawn_tank2("hill_mid_start_node");
  thread enemy_sight_increased();
  scripts\engine\utility::flag_set("tank_death");
  wait 1;
  thread kill_the_tank();
  wait 0.1;
  level.follow_ent = level.player;
  scripts\sp\maps\lab\lab_util::array_thread_safe([level.price, level.farah, level.kyle, level.rebel_1], &scripts\sp\maps\lab\lab_util::ai_movement_control, level.follow_ent, 800, 500);
  scripts\sp\maps\lab\lab_util::array_thread_safe([level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5], &scripts\sp\maps\lab\lab_util::ai_movement_control, level.follow_ent, 600, 500);
}

function hill_mid_main() {
  thread vo_hill_mid();
  thread hill_mid_spawning();
  scripts\engine\sp\utility::autosave_by_name("hill_mid");
  scripts\engine\utility::flag_wait_any("tank_death", "spawn_hilltop_heli");
  scripts\sp\player_death::clear_custom_death_quote();
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("hill_mid_heli");
  thread scripts\common\vehicle_paths::gopath(var0);
  thread heli_done_unloading();
}

function hill_mid_spawning() {
  level endon("hill_fallback_2");
  level endon("hilltop_heli_spawned");
  scripts\engine\utility::flag_wait("tank_death");

  if(level.player.origin[0] < 5600) {
    var0 = "midhill_right";
  } else {
    var0 = "midhill_left";
  }

  if(var0 == "midhill_right") {
    var1 = ["midhill_guys_right", "midhill_guys_leftback", "midhill_guys_back_right"];
  } else {
    var1 = ["midhill_guys_left", "midhill_guys_back_right", "midhill_guys_leftback"];
  }

  foreach(var3 in var1) {
    while(getaiarray("axis").size >= 10) {
      waitframe();
    }

    var4 = scripts\engine\sp\utility::array_spawn_targetname(var3, 0, 1);
    var5 = gettime() + 40000;

    while(getaiarray("axis").size > 10 && gettime() < var5) {
      waitframe();
    }

    if(var6 >= 1 && gettime() < var5) {
      if(level.gameskill < 3) {
        scripts\engine\sp\utility::autosave_by_name("wave_killed");
      }
    }
  }
}

function hill_mid_move_up_nag() {
  if(scripts\engine\utility::flag("midhill_left") || scripts\engine\utility::flag("midhill_right")) {
    return;
  }

  level endon("midhill_left");
  level endon("midhill_right");
  wait 10;
  var0 = ["dx_vom_pri_hill_mid_halfway_20", "dx_vom_pri_hill_mid_halfway_30", "dx_vom_pri_hill_mid_halfway_40"];
  level.price scripts\sp\maps\lab\lab_vo_util::nagtill(undefined, var0, 8);
}

function vo_hill_mid() {
  scripts\engine\utility::flag_wait_any("midhill_left", "midhill_right");
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_mid_halfway_10");
  scripts\engine\utility::flag_wait("tank_proceed_10");
  scripts\sp\maps\lab\lab_vo_util::hill_pa_chatter_say("dx_vom_bkv_hill_top_arrival_20");
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_top_arrival_30", 1);
  scripts\sp\maps\lab\lab_vo_util::hill_pa_chatter_say("dx_vom_bkv_hill_top_arrival_40", 1);
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_top_arrival_50", 1);
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_top_arrival_60", 1);
  scripts\sp\maps\lab\lab_vo_util::hill_pa_chatter_say("dx_vom_bkv_hill_top_arrival_70", 1);
  thread hill_mid_move_up_nag();
}

function heli_done_unloading() {
  scripts\engine\utility::waittill_any("unloaded", "death");
  scripts\engine\utility::flag_set("hillmid_helis_unloaded");
}

function friendlies_follow_tanks() {
  while(!isDefined(level.tank2) || !isDefined(level.tank2.follow_ents)) {
    waitframe();
  }

  var0 = [level.farah, level.kyle, level.price];
  var1 = level.tank2.follow_ents;

  foreach(var3 in var0) {
    if(!isDefined(var3)) {
      continue;
    }

    if(!isDefined(var3.my_tank_node)) {
      var3.my_tank_node = var3 scripts\sp\maps\lab\lab_util::get_my_node(var1);
    }

    thread follow_ent(var3);
    var1 = scripts\engine\utility::array_remove(var1, var3.my_tank_node);
  }
}

function follow_ent(var0) {
  self endon("stop_following_ent");
  self endon("death");

  if(!isDefined(self)) {
    return;
  }

  while(distance2dsquared(self.origin, var0.origin) < 6400) {
    waitframe();
  }

  self allowedstances("stand");
  self.og_goalradius = self.goalradius;
  scripts\engine\sp\utility::disable_ai_color();
  self.goalradius = 10;
  self.follow_ent = var0;
  self cleargoalvolume();
  self setgoalpos(var0.origin);
  self setgoalentity(var0, 1000);
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_ignoresuppression(1);
  self.og_attackeraccuracy = self.attackeraccuracy;
  self.attackeraccuracy = 0.05;
  base_tank_ai_speed(var0);
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

function base_tank_ai_speed(var0) {
  var1 = 300;
  var2 = 200;
  var3 = -100;
  var4 = 20;
  var5 = 150;
  var6 = 250;
  thread scripts\engine\sp\utility::enable_dynamic_run_speed(var0, var4, var5, var6, var1, var2, var3);
}

function stop_following_ent() {
  self notify("stop_following_ent");
  self allowedstances("stand", "crouch", "prone");

  if(isDefined(self.my_tank_node)) {
    self setgoalpos(self.my_tank_node.origin);
  } else {
    self setgoalpos(self.origin);
  }

  if(isDefined(self.og_goalradius)) {
    self.goalradius = self.og_goalradius;
  }

  self.follow_ent = undefined;
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\sp\utility::set_ignoresuppression(0);

  if(isDefined(self.og_attackeraccuracy)) {
    self.attackeraccuracy = self.og_attackeraccuracy;
  } else {
    self.attackeraccuracy = 1;
  }

  scripts\engine\sp\utility::disable_dynamic_run_speed();
  scripts\common\utility::clear_movement_speed();
  scripts\common\ai::enable_arrivals();

  if(isDefined(level.poi_activeai)) {
    scripts\common\ai::poi_enable(0);
  }

  self enableavoidance(1, 1);
}

function tank_rpg_death() {
  scripts\engine\utility::flag_wait("tank_1_last_stop");
  thread kill_tower_ladders();
  scripts\engine\utility::flag_wait("hill_weapons_lower");
  level.tank2 scripts\engine\utility::ent_flag_wait_or_timeout("end_of_the_line", 3);
  var0 = gettime() + 10000;
  var1 = [level.price, level.kyle, level.farah, level.tank2, level.player];

  while(!scripts\engine\utility::flag("tank_death_timeout") && !scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, level.tank2.origin + anglesToForward(level.tank2.angles) * -50, var1) && gettime() < var0) {
    waitframe();
  }

  var2 = scripts\engine\utility::getStruct("rpg_impact", "targetname");
  var3 = scripts\engine\utility::getStruct("tank_rpg_impact_start", "targetname");
  var4 = scripts\engine\utility::getStruct(var3.target, "targetname");
  level.tank1_rpg_guys = scripts\engine\sp\utility::array_spawn_targetname("tank1_rpg_guys", 1, 1);
  var5 = magicbullet("iw8_la_rpapa7_straight_ai", var3.origin, var4.origin);
  level.tank2 vehicle_cleardrivingstate();
  scripts\engine\utility::flag_set("tank_death");
  scripts\engine\sp\utility::remove_global_spawn_function("axis", &scripts\sp\maps\lab\lab_util::axis_grenade_toggle);
  scripts\engine\utility::array_thread(getaiarray("axis"), &scripts\sp\maps\lab\lab_util::axis_grenade_toggle, 1);

  while(isDefined(var5) && distance2d(var5.origin, level.tank2.origin) > 100) {
    waitframe();
  }

  thread kill_the_tank();
  wait 0.8;
  level.player scripts\sp\utility::set_player_attacker_accuracy(1);
  scripts\engine\sp\utility::autosave_by_name("tank_death");
  level.follow_ent = level.player;
  thread monitor_ai_movement_vol();
  wait 0.2;
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_bottom_callout_apcdestroyed_ally1_30", 1, 1);
}

function kill_the_tank() {
  level.tank2.godmode = 0;
  level.tank2 scripts\sp\utility::do_damage(level.tank2.health + 10000, level.tank2.origin, undefined, undefined, "MOD_EXPLOSIVE");
  waitframe();
  level.tank2 scripts\common\anim::anim_single_solo(level.tank2, "tank_death");
}

function monitor_ai_movement_vol() {
  var0 = getEnt("hero_follow_volume", "targetname");
  var1 = getEnt("hill_tower_vol", "targetname");
  var2 = 0;
  scripts\engine\utility::flag_wait("tank_1_last_stop");

  while(!scripts\engine\utility::flag("hill_finished_trig")) {
    var3 = ai_should_follow_check(var0, var1);

    if(!var2 && var3) {
      level.follow_ent = level.player;
      scripts\sp\maps\lab\lab_util::array_thread_safe([level.price, level.farah, level.kyle, level.rebel_1], &scripts\sp\maps\lab\lab_util::ai_movement_control, level.follow_ent, 800, 500);
      scripts\sp\maps\lab\lab_util::array_thread_safe([level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5], &scripts\sp\maps\lab\lab_util::ai_movement_control, level.follow_ent, 400, 500);
    } else if(var2 && !var3) {
      level.follow_ent = undefined;
      scripts\engine\utility::array_thread(level.heroes, &scripts\sp\maps\lab\lab_util::stop_ai_movement_control);
    }

    var2 = var3;
    wait 1;
  }
}

function ai_should_follow_check(var0, var1) {
  if(level.player istouching(var0) && !level.player istouching(var1)) {
    return 1;
  }

  return 0;
}

function hill_lot_enemies_seek() {
  while(scripts\engine\sp\utility::get_ai_group_count("hill_lot_guys") >= 2) {
    wait 0.1;
  }

  var0 = scripts\engine\sp\utility::get_ai_group_ai("hill_lot_guys");

  foreach(var2 in var0) {
    var2 setgoalentity(level.player);
  }
}

function hill_mid_catchup() {
  scripts\engine\utility::flag_set("tank_proceed_10");
  scripts\engine\utility::flag_set("hill_fallback_1");
}

function hill_top_start() {
  scripts\sp\maps\lab\lab_util::spawn_hill_friendlies();
  scripts\engine\sp\utility::set_start_location("hilltop_start", [level.player, level.kyle, level.price, level.farah, level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5]);
  thread enemy_sight_increased();
  scripts\engine\utility::flag_set("tank_death_timeout");
  level.follow_ent = level.player;
  thread monitor_ai_movement_vol();
}

function hill_top_main() {
  thread vo_hill_top();
  scripts\engine\sp\utility::autosave_by_name("hill_top");
  thread hill_lot_enemies_seek();
  thread last_hill_enemies_dead();
  thread track_player_rpg();
  scripts\engine\sp\utility::flagwaitthread("spawn_hilltop_heli", &spawn_hilltop_heli);
  var0 = getEnt("gl_intro_door", "script_noteworthy");
  var0 thread scripts\sp\maps\lab\lab_turbines::lab_door_prompt();
  var1 = scripts\engine\sp\utility::array_spawn_targetname("hilltop_tower_guys", 1, 1);
  scripts\engine\utility::flag_wait("hill_finished_trig");
  scripts\sp\maps\lab\lab_util::array_thread_safe([level.rebel_1, level.rebel_2, level.rebel_3], &scripts\common\ai::magic_bullet_shield);
  var2 = getEntArray("hilltop_placed_rpg", "targetname");
  scripts\engine\utility::array_thread(var2, &rpg_respawning);
}

function nag_kill_hiltop_heli() {
  if(scripts\engine\utility::flag("hilltop_heli_dead")) {
    return;
  }

  level endon("hilltop_heli_dead");
  wait 30;
  var0 = ["dx_vom_pri_hill_top_helicopter_10", "dx_vom_pri_hill_top_helicopter_20", "dx_vom_pri_hill_top_helicopter_30", "dx_vom_pri_hill_top_helicopter_40"];
  level.price scripts\sp\maps\lab\lab_vo_util::nagtill("hilltop_heli_dead", var0, 15, 3, 1.5, 1.1, 35, 5);
}

function vo_clear_carpark() {
  if(scripts\engine\utility::flag("hill_finished_trig")) {
    return;
  }

  level endon("hill_finished_trig");
  wait 2;
  scripts\sp\maps\lab\lab_vo_util::hill_pa_chatter_say("dx_vom_bkv_hill_top_helicopter_60");
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_hill_top_helicopter_70");
  level.farah scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_far_hill_top_helicopter_80");
  level.price scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_top_carpark_10");
  scripts\engine\utility::flag_wait("hill_finished_trig");
}

function vo_hill_top() {
  scripts\engine\utility::flag_wait("hilltop_heli_spawned");
  nag_kill_hiltop_heli();
  vo_clear_carpark();
  scripts\sp\maps\lab\lab_vo_util::wait_combat_cooldown(0.8, 4);
  level.player scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_alx_hill_top_carpark_30");
  scripts\engine\utility::delaythread(0.5, &scripts\sp\equipment\green_beam::take_green_beam, 1);
  level.vo_callouts = undefined;
}

function rpg_respawning() {
  if(scripts\engine\utility::flag("hilltop_heli_dead")) {
    return;
  } else {
    level endon("hilltop_heli_dead");
  }

  var0 = cos(65);
  var1 = self;
  var2 = self.classname;
  var3 = self.spawnflags;

  for(;;) {
    var4 = var1.origin;
    var5 = var1.angles;
    var1 waittill("trigger");
    wait 1;

    while(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var4, var0)) {
      wait 1;
    }

    var1 = spawn(var2, var4, 0);
    var1 itemweaponsetammo(weaponclipsize(var1), weaponmaxammo(var1));
  }
}

function spawn_hilltop_heli() {
  level.hilltop_heli = scripts\common\vehicle::spawn_vehicle_from_targetname("hilltop_littlebird");
  thread little_bird_spawnfunc();
  thread scripts\engine\sp\utility::array_spawn_targetname("hilltop_final_wave", 1, 1);
}

function hill_top_catchup() {
  scripts\engine\utility::flag_set("hill_finished_trig");
}

function last_hill_enemies_dead() {
  scripts\engine\utility::flag_wait("hilltop_heli_dead");
  wait 5;
  var0 = 0;

  for(;;) {
    var1 = getaiarray("axis");

    if(!var1.size) {
      break;
    }

    if(var1.size < 6 && var0 == 0) {
      scripts\engine\utility::flag_set("hill_top_fallback");
      childthread scripts\engine\sp\utility::ai_delete_when_out_of_sight(var1, 1000);
      var0++;
    }

    if(var1.size < 3 && var0 == 1) {
      if(var1.size == 2) {
        level.price thread scripts\sp\maps\lab\lab_vo_util::say_as_chatter("dx_vom_pri_hill_top_carpark_20");
      }

      scripts\sp\maps\lab\lab_util::array_thread_safe(var1, &scripts\sp\utility::player_seek_enable);
      var0++;
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

function tank_stop_for_allies_think() {
  self endon("death");
  var0 = 300;
  var1 = 170;
  var2 = 230;
  var3 = 130;
  var4 = 50;
  var5 = 30;

  for(var6 = 0;; var6 = 0) {
    waitframe();
    var7 = scripts\engine\sp\utility::worldtolocalcoords(level.player.origin);
    var8 = abs(var7[1]) / var0 / 2;
    var8 = max(scripts\engine\math::remap(var8, var1 / var0, 1, 0, 1), 0);
    var9 = (var7[0] - var5) / var2;

    if(var8 < 1 && var9 < 1 && var9 > 0) {
      if(var7[0] > var5 + var4) {
        var9 = max(scripts\engine\math::remap(var9, var3 / var2, 1, 0, 1), 0);
      } else {
        var9 = max(scripts\engine\math::remap(1 - var9, (var2 - var4) / var2, 1, 0, 1), 0);
      }

      var10 = max(var8, var9);

      if(!isDefined(self.vehicle_stop_named) || !self.vehicle_stop_named.size) {
        var11 = 100 * (1 - var10);
        self vehicle_setspeed(level.tank2.currentnode.speed * 0.1 * var10, var11, var11);
        var6 = 1;
      }

      continue;
    }

    if(var6) {
      if(!isDefined(self.vehicle_stop_named) || !self.vehicle_stop_named.size) {
        self resumespeed(10);
      }
    }
  }
}

function tank_stop_for_allies_think_debug(var0, var1, var2, var3, var4, var5) {
  var6 = (var4, var0 / 2 * -1, 30);
  var7 = (var4, var0 / 2, 30);
  var8 = (var4 + var2, var0 / 2 * -1, 30);
  var9 = (var4 + var2, var0 / 2, 30);
  var10 = (var4, var1 / 2 * -1, 30);
  var11 = (var4, var1 / 2, 30);
  var12 = (var4 + var2, var1 / 2 * -1, 30);
  var13 = (var4 + var2, var1 / 2, 30);
  var14 = (var4 + var3, var0 / 2 * -1, 30);
  var15 = (var4 + var3, var0 / 2, 30);
  var16 = (var4 + var5, var0 / 2 * -1, 30);
  var17 = (var4 + var5, var0 / 2, 30);
  var18 = self localtoworldcoords(var6);
  var19 = self localtoworldcoords(var7);
  var20 = self localtoworldcoords(var8);
  var21 = self localtoworldcoords(var9);
}

function friendly_tank_stop_internal() {
  for(;;) {
    while(!self.allies_in_danger.size) {
      waitframe();
    }

    self.stopped_for_allies = 1;
    var0 = self.origin + anglesToForward(self.angles) * 260;
    self.badplace_id = createnavobstaclebybounds(var0, (127, 70, 64), vectortoangles(self.path_vector));
    stop_tank("allies", 15, 15);

    while(self.allies_in_danger.size) {
      waitframe();
    }

    if(isDefined(self.badplace_id)) {
      destroynavobstacle(self.badplace_id);
    }

    resume_tank("allies");
    self.stopped_for_allies = 0;
    self notify("resume_stop_for_allies");
    self.badplace_id = undefined;
  }
}

function get_off_tank_path(var0, var1, var2) {
  var0 endon("death");
  var0 notify("move_for_tank");
  self.allies_in_danger[self.allies_in_danger.size] = var0;

  while(var0 isinbadplace()) {
    waitframe();
  }

  var0 notify("off_tank_path");
  self.allies_in_danger = scripts\engine\utility::array_remove(self.allies_in_danger, var0);
}

function stop_tank(var0, var1, var2) {
  if(isDefined(self.stops) && isDefined(self.stops[var0])) {
    return;
  }

  self.stops[var0] = 1;
  scripts\common\vehicle::vehicle_stop_named(var0, var1, var2);
}

function resume_tank(var0) {
  self.stops[var0] = undefined;
  scripts\common\vehicle::vehicle_resume_named(var0);
}

function tank_waittill_stopped() {
  while(self vehicle_getspeed() > 0) {
    waitframe();
  }

  wait 1;
}

function waittill_nonai_isnt_blocking_tank(var0) {
  var0 endon("death");
  self.allies_in_danger[self.allies_in_danger.size] = var0;

  for(;;) {
    if(is_blocking_tank(var0, self)) {} else {
      break;
    }

    waitframe();
  }

  var0 notify("off_tank_path");
  self.allies_in_danger = scripts\engine\utility::array_remove(self.allies_in_danger, var0);
}

function is_blocking_tank(var0) {
  return distancesquared(var0.origin, self.origin) < squared(500) && scripts\engine\utility::within_fov(var0.origin, var0.angles, self.origin, level.tankfovcos);
}

function vehicle_death_custom() {
  self waittill("death");
  var0 = self.origin;

  if(scripts\engine\utility::is_equal(self, level.tank2)) {
    radiusdamage(var0, 200, 80, 30, level.player, "MOD_EXPLOSIVE");

    if(distance2dsquared(var0, level.player.origin) < 22500) {
      level.player shellshock("explosion", 3);
    }

    scripts\engine\utility::exploder("bromeo_death_1");
    return;
  }

  radiusdamage(var0, 300, 250, 200, level.player, "MOD_EXPLOSIVE");

  if(isDefined(self.script_noteworthy)) {
    switch (self.script_noteworthy) {
      case "smoke_lrg":
        wait 15;
        playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_lrg"), var0);
        break;
      default:
        wait 15;
        playFX(scripts\engine\utility::getfx("vfx_lab_hill_smoke_sml"), var0);
        break;
    }

    return;
  }
}

function heli_death_thread() {
  self waittill("death", var0);
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
        if(self.origin[0] > 3241) {
          scripts\engine\utility::exploder("heli_crash_1");
          var1 = getEnt("heli_crash_01", "targetname");
          var1 show();
        } else {
          playFX(scripts\engine\utility::getfx("vfx_lab_helo_explode_dist_ch"), self.origin);
        }

        break;
      case "helicopter_4":
        scripts\engine\utility::exploder("heli_crash_3");
        break;
      case "helicopter_5":
        var2 = scripts\engine\utility::getStruct("left_crash_site", "targetname");

        if(distance2dsquared(self.origin, var2.origin) < 250000) {
          playFX(scripts\engine\utility::getfx("vfx_lab_helo_explode_dist_ch"), self.origin);
        } else {
          scripts\engine\utility::exploder("heli_crash_2");
        }

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
    return;
  }
}

function heli_replenish_health_after_death() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var0)) {
      self.health += var0;
    }
  }
}

function heli_damage_death() {
  scripts\engine\sp\utility::assign_animtree("hind");

  for(;;) {
    self waittill("damage", var0, var1, var2, var2, var2, var2, var2, var3, var2, var4);

    if(scripts\engine\utility::is_equal(var1, level.player)) {
      if(isDefined(var4) && (scripts\engine\utility::is_equal(var4.classname, "grenade") || scripts\engine\utility::is_equal(var4.classname, "rocketlauncher"))) {
        thread kill_heli(var1, var4);
        return;
      }
    }
  }
}

function kill_heli(var0, var1) {
  self.custom_death_script = &helicopter_lerp_crash_anim;
  self notify("death", var0, undefined, var1);
  self vehicle_turnengineoff();
}

function helicopter_lerp_crash_anim() {
  thread scripts\engine\sp\utility::notify_delay("in_air_explosion", 0.1);
  var0 = scripts\engine\utility::getStruct("heli_crash_node", "targetname");
  self.animtag = scripts\engine\utility::spawn_tag_origin();
  self linkTo(self.animtag);
  var1 = 5;
  self.animtag moveTo(var0.origin, var1);
  self.animtag rotateTo(var0.angles, var1);
  thread helicopter_crash_beats();
  self.animtag scripts\common\anim::anim_single_solo(self, "death_crash");
}

function helicopter_crash_beats() {
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

function heli_crash_on_pilot_death() {
  self endon("death");
  var0 = undefined;

  foreach(var2 in self.riders) {
    if(scripts\engine\utility::is_equal(var2.vehicle_position, 0)) {
      var0 = var2;
      break;
    }
  }

  if(!isDefined(var0)) {
    return;
  }

  var4 = pilot_damage_thread(var0);
  level.player notify("new_hint");
  wait 0.1;

  if(isDefined(self.godmode)) {
    return;
  }

  if(scripts\common\vehicle::vehicle_is_crashing()) {
    return;
  }

  level thread scripts\sp\utility::giveachievement_wrapper("pilotkill");

  if(isDefined(var4)) {
    scripts\sp\utility::do_damage(self.health - self.healthbuffer + 1, var4[0], var4[1], undefined, var4[2], var4[3]);
    return;
  }

  scripts\sp\utility::do_damage(self.health - self.healthbuffer + 1, self.origin);
}

function pilot_damage_thread() {
  self endon("death");
  self.stored_damage = 0;
  self.health = 2000;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var2, var2, var2, var6);

    if(scripts\engine\utility::is_equal(var1, level.player) && level.player scripts\sp\maps\lab\lab_util::using_bulletdrop_weapon()) {
      self.health += var0;
      continue;
    }

    self.stored_damage += var0;

    if(self.stored_damage >= 200) {
      scripts\sp\utility::do_damage(self.health + self.stored_damage, var3, var1, undefined, var4, var6);
      return [var3, var1, var4, var6];
    }
  }
}

function little_bird_dmg_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1) && isPlayer(var1)) {
    if(isDefined(var4)) {
      if(var4 == "MOD_GRENADE") {
        self.grenadehits++;
      }
    }
  }

  if(self.grenadehits >= 2 || self.projectilehits > 0) {
    scripts\sp\utility::do_damage(self.health + 10000, self.origin, var1, var1, "MOD_PROJECTILE");
    return;
  }
}

function drone_attack_checks() {
  level endon("lab_door_opened");

  for(;;) {
    level waittill("hellfire_impact", var0, var1);
    var2 = scripts\engine\utility::get_array_of_closest(var0, getaiarray("axis"), undefined, undefined, 500, 0);
    var3 = scripts\engine\utility::get_array_of_closest(var0, scripts\engine\sp\utility::getvehiclearray(), undefined, undefined, 500, 0);
    var4 = scripts\engine\utility::array_combine(var2, var3);
    var5 = 0;

    foreach(var7 in var4) {
      if(isai(var7) && isalive(var7) && var7.team == "allies") {
        var5 = 1;
        continue;
      }

      if(var7 scripts\common\vehicle::isvehicle() && var7.script_team == "allies" && !var7 scripts\common\vehicle_code::_is_godmode()) {
        var5 = 1;
      }
    }

    if(getdvarint("scr_debug_greenbeam")) {
      thread scripts\engine\utility::draw_circle(var0, 500, (1, 0, 0), 1, 0, 100);
    }

    if(var5) {
      wait 0.7;
      scripts\sp\friendlyfire::missionfail(0);
      return;
    }

    foreach(var10 in var4) {
      if(var10 scripts\common\vehicle::isvehicle()) {
        if(var10 scripts\common\vehicle_code::_is_godmode()) {
          continue;
        } else if(istrue(var10.attachedguys.size)) {
          level.drone.killcount += var10.attachedguys.size;
        }
      }

      var10 scripts\sp\utility::do_damage(var10.health + 10000, var10.origin, level.player, undefined, "MOD_EXPLOSIVE", getcompleteweaponname("iw8_projectile_hfoxtrot"));
      level.drone.killcount++;
    }
  }
}

function guard_tower_logic() {
  self.stored_damage = 0;
  level endon("ambush1_start");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var3, var3, var3, var3, var5, var6, var3, var3, var7);

    if(isDefined(level.hilltop_heli) && scripts\engine\utility::is_equal(level.hilltop_heli.minigun, var1)) {
      self.stored_damage += var0;
    }

    if(var0 < 170) {
      continue;
    }

    if(tower_damage_check(var1, var4, var0)) {
      if(isDefined(var5)) {
        var8 = createheadicon(var5);
        level notify("guard_tower_destroyed", self, var1, var7, var4, var8);
      }

      foreach(var10 in getaiarray("axis")) {
        if(var10 istouching(self.trigger)) {
          if(isDefined(var5)) {
            var10 childthread scripts\sp\utility::do_damage(var10.health + 1, var6, var1, var7, var4, var5);
            continue;
          }

          var10 childthread scripts\sp\utility::do_damage(var10.health + 1, var6, var1, var7, var4);
        }
      }

      if(isDefined(var2) && var2[2] - self.origin[2] < 215) {
        var12 = "collapsed";
      } else {
        var12 = "exploded";
      }

      self setscriptablepartstate("base", var12, 1);
      childthread scripts\engine\utility::play_sound_in_space("lab_hill_guard_tower_" + var12, self.origin);

      foreach(var14 in self.nodes) {
        if(scripts\engine\utility::is_equal(var14.type, "Begin")) {
          destroynavlink(var14);
          continue;
        }

        var14 disconnectnode();
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

function kill_tower_ladders() {
  var0 = getscriptablearray("guard_tower", "script_noteworthy");

  foreach(var2 in var0) {
    if(!isDefined(var2.nodes) || !is_tower_touching_trigger(var2)) {
      continue;
    }

    foreach(var4 in var2.nodes) {
      if(var4.type == "Begin") {
        destroynavlink(var4);
        continue;
      }

      var4 disconnectnode();
    }
  }
}

function is_tower_touching_trigger() {
  var0 = getEnt("tower_death_2", "script_noteworthy");
  var1 = getEnt("tower_death_3", "script_noteworthy");

  if(isDefined(var0) && self istouching(var0)) {
    return 1;
  }

  if(isDefined(var1) && self istouching(var1)) {
    return 1;
  }

  return 0;
}

function tower_damage_check(var0, var1, var2) {
  if(scripts\engine\utility::is_equal(var0, level.player) && level.player scripts\sp\maps\lab\lab_util::using_bulletdrop_weapon()) {
    return 0;
  }

  if(isDefined(var1) && isexplosivedamagemod(var1) && var2 >= 180) {
    return 1;
  }

  if(isDefined(level.tank2) && scripts\engine\utility::is_equal(level.tank2.mainturret, var0) && var2 > 380) {
    return 1;
  }

  if(isDefined(self.stored_damage) && self.stored_damage > 8000) {
    return 1;
  }

  return 0;
}

function enemy_sight_increased() {
  level.player notify("stealth_disabled");
  var0 = 5500;
  var1 = var0 * var0;
  level.player scripts\engine\sp\utility::set_maxvisibledist(var0);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &scripts\engine\sp\utility::set_maxsightdistsquared, var1);

  foreach(var3 in getaiarray("axis")) {
    var3 scripts\engine\sp\utility::set_maxsightdistsquared(var1);
  }
}

function hill_dmg_func(var0, var1, var2, var3, var4, var5, var6) {
  if(scripts\engine\utility::is_equal(var1.classname, "script_vehicle_bromeo")) {
    thread player_temp_invul(var0);
    return;
  }
}

function player_temp_invul(var0) {
  self endon("death");

  if(isDefined(self.temp_invul)) {
    return;
  }

  self.temp_invul = 1;
  self enableinvulnerability();
  scripts\sp\player::set_normalhealth(self.health + var0 / self.maxhealth);
  wait 3;
  self disableinvulnerability();
  self.temp_invul = undefined;
}

function apc_shoot_logic() {
  self endon("death");
  GscBinSkip4(0x35);
}

function hill_bottom_apc_attack() {
  wait 4;

  for(;;) {
    var0 = undefined;

    if(isDefined(level.corner_redshirts)) {
      foreach(var2 in level.corner_redshirts) {
        if(isalive(var2)) {
          var2.health = 10;
          apc_hurttarget(var2, 1);
        }
      }
    }

    if(!scripts\engine\utility::flag("green_beam_safe_zone")) {
      apc_hurttarget(level.player, 1);
    } else {
      apc_attack_target_until_closer_threat();
    }

    waitframe();
  }
}

function apc_should_attack_player() {
  if(!scripts\engine\utility::flag("go_left")) {
    return !scripts\engine\utility::flag("green_beam_safe_zone");
  }

  if(!isDefined(self.script_noteworthy)) {
    return 0;
  }

  return scripts\engine\utility::flag(self.script_noteworthy + "_close");
}

function apc_attack_target_until_closer_threat() {
  var0 = self.currtarget;
  self endon("new_threat");

  if(!isDefined(var0)) {
    return;
  }

  var0 endon("death");
  self.mainturret settargetentity(var0, (0, 0, 30));

  while(isDefined(var0) && !is_aimed_at_target(var0)) {
    wait 0.05;
  }

  if(!isalive(var0)) {
    return 1;
  }

  apc_hurttarget(var0);
  return 1;
}

function apc_target_updater() {
  var0 = level.player;
  self.currtarget = var0;
  var1 = [];

  for(;;) {
    var2 = getaiarray("allies");
    var2 = scripts\engine\utility::array_combine(var2, [level.player, level.tank2]);
    var2 = sortbydistance(var2, self.origin);

    foreach(var4 in var2) {
      if(isDefined(var4.ridingvehicle)) {
        continue;
      }

      if(var5 == 0) {
        var1 = var4;
      } else if(distancesquared(var4.origin, var1[0].origin) < 202500) {
        var1 = var4;
      }

      var0 = var4;
      break;
    }

    if(var1.size > 1) {
      var0 = scripts\engine\utility::random(var1);
    } else {
      var0 = var1[0];
    }

    self notify("new_threat", var0);
    self.currtarget = var0;
    var0 scripts\engine\utility::waittill_notify_or_timeout("death", 5);
  }
}

function apc_hurttarget(var0, var1) {
  var2 = isPlayer(var0);

  if(var2 && !isDefined(var1)) {
    var3 = 100;
    self.mainturret.target_ent.origin = var0.origin + anglesToForward(var0.angles) * var3;
    waitframe();
    self.mainturret settargetentity(self.mainturret.target_ent, (0, 0, 0));

    for(;;) {
      var3 -= 10;
      self.mainturret.target_ent.origin = var0.origin + anglesToForward(var0.angles) * var3;
      tank_shot();
      wait 0.15 + randomfloat(0.15);

      if(distance(var0.origin, self.mainturret.target_ent.origin) < 50) {
        break;
      }
    }
  }

  var4 = randomintrange(4, 6);

  if(istrue(var0.magic_bullet_shield)) {
    var4 = 3;
  }

  var5 = 0;
  var6 = 3;
  var7 = var0.health;
  var8 = 0;

  for(var9 = 0; var9 < var4; var9++) {
    var10 = -15;
    var11 = 15;

    if(var2 && var0 issprinting() && !isDefined(var1)) {
      var10 = -30;
      var11 = 30;
    }

    self.mainturret settargetentity(var0, (0, 0, 30) + scripts\engine\utility::randomvectorrange(var10, var11));
    tank_shot();
    wait 0.2 + randomfloat(0.15);

    if(!canshoottarget(var0)) {
      var5++;

      if(var5 == var6) {
        return;
      }
    }
  }
}

function canshoottarget(var0) {
  var1 = undefined;

  if(isPlayer(var0) || isai(var0)) {
    var1 = var0 getEye();
  } else if(var0 scripts\common\vehicle::isvehicle()) {
    var1 = var0.origin + (0, 0, 60);
  } else {
    var1 = var0.origin;
  }

  var2 = sighttracepassed(self.mainturret gettagorigin("tag_flash"), var1, 0, [self, var0]);
  return var2;
}

function get_ally_target() {
  var0 = getaiarray("allies");

  if(isalive(level.tank2)) {
    var0 = scripts\engine\utility::array_add(var0, level.tank2);
  }

  foreach(var2 in var0) {
    if(canshoottarget(var2)) {
      return var2;
    }
  }

  return undefined;
}

function is_aimed_at_target(var0) {
  return scripts\engine\utility::within_fov(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var0.origin, level.cos10);
}

function tank_moveup_nag(var0) {
  if(scripts\engine\utility::flag(var0)) {
    return;
  }

  level endon(var0);
  wait 18;
  var1 = ["dx_vom_pri_drone_tutorial_transition_30", "dx_vom_pri_drone_tutorial_transition_20", "dx_vom_pri_drone_tutorial_transition_40"];
  var2 = scripts\engine\sp\utility::create_deck(var1, 0);
  level scripts\sp\maps\lab\lab_vo_util::nagtill(undefined, var2, 16, 2, 1.2, 1.2, 45, 5);
}

function tanks_moveup_hill_shooting_logic() {
  self endon("death");
  scripts\vehicle\bromeo::mainturret_idle();
  var0 = getspawnerarray("turret_guys");
  scripts\engine\utility::flag_wait("hill_charge_started");
  scripts\engine\utility::ent_flag_set("reset_shooting");
  self notify("reset_shooting");
  self.mainturret.target_ent unlink();

  while(!scripts\engine\utility::flag("go_left") && !scripts\engine\utility::flag("manual_shooting")) {
    var0 = scripts\engine\utility::array_randomize(var0);

    foreach(var2 in var0) {
      self.mainturret.target_ent.origin = var2.origin + (0, 0, 130);
      self.mainturret settargetentity(self.mainturret.target_ent, scripts\engine\utility::randomvector(20));

      while(!is_aimed_at_target(self.mainturret.target_ent)) {
        wait 0.25;
      }

      var3 = randomintrange(4, 7);

      for(var4 = 0; var4 < var3; var4++) {
        tank_shot();
        wait 0.25 + randomfloat(0.15);
      }

      wait 2 + randomfloat(2);
    }
  }

  scripts\engine\utility::ent_flag_clear("reset_shooting");
  scripts\engine\utility::flag_set("manual_shooting");
}

function tank_shooting_logic() {
  self endon("death");

  while(!isDefined(self.mainturret.target_ent)) {
    wait 1;
  }

  scripts\vehicle\bromeo::mainturret_idle();

  for(;;) {
    wait 0.5;
    self.mainturret.target_ent unlink();
    self.mainturret cleartargetentity();
    self.mainturret.convergencetime = 0.75;
    self.mainturret.target_ent.origin = self.origin + anglesToForward(self.angles) * 50;

    if(scripts\engine\utility::flag("manual_shooting")) {
      manual_shooting_logic();
    } else if(scripts\engine\utility::flag("post_bridge_shooting")) {
      tank_struct_shoots();
    } else {
      tank_idle_aiming();
    }

    wait 0.5;
  }
}

function manual_shooting_logic() {
  level endon("post_bridge_shooting");
  self endon("reset_shooting");
  var0 = scripts\engine\sp\utility::getvehiclearray_in_radius(self.origin, 3000, "axis");
  self.mainturret settargetentity(self.mainturret.target_ent);

  if(var0.size > 0) {
    tank_pick_vehicle_target(var0);
    return;
  }

  tank_pick_ai_target();
}

function tank_struct_shoots() {
  level endon("manual_shooting");
  level endon("next_targets");
  self endon("reset_shooting");
  var0 = get_closest_tank_targets();

  if(!isDefined(var0)) {
    return;
  }

  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var1 = sortbydistance(var1, self.origin);

  foreach(var3 in var1) {
    self.mainturret.target_ent unlink();
    self.mainturret.target_ent.origin = var3.origin;
    self.mainturret settargetentity(self.mainturret.target_ent);
    var4 = getaiarrayinradius(var3.origin, 700, "axis");

    if(var4.size < 1) {
      continue;
    }

    if(!isDefined(var3.radius)) {
      var5 = 200;
    } else {
      var5 = var3.radius;
    }

    var6 = gettime() + 3000;

    while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var6) {
      wait 0.5;
    }

    if(!isDefined(var3.script_noteworthy)) {
      var7 = randomintrange(3, 5);

      for(var8 = 0; var8 < var7; var8++) {
        tank_shot();
        wait 0.3 + randomfloat(0.3);
      }
    } else if(scripts\engine\utility::is_equal(var3.script_noteworthy, "ai_target")) {
      tank_pick_ai_target(var3.origin, var5);
    } else if(scripts\engine\utility::is_equal(var3.script_noteworthy, "vehicle_target")) {
      var9 = scripts\engine\sp\utility::getvehiclearray_in_radius(var3.origin, var5, "axis");
      tank_pick_vehicle_target(var9);
    }

    wait 1;
  }

  for(;;) {
    tank_pick_ai_target(self.mainturret.target_ent.origin, 2000);
    wait 2;
  }
}

function tank_shot() {
  earthquake(0.1, 0.5, self.origin, 400);
  playrumbleonposition("damage_light", self.origin);
  self.mainturret shootturret("tag_flash");
}

function get_closest_tank_targets() {
  var0 = scripts\engine\utility::getStructArray("tank_target_zones", "targetname");
  var1 = scripts\engine\utility::getclosest(self.mainturret gettagorigin("tag_flash"), var0);
  return var1;
}

function tank_idle_aiming() {
  self endon("reset_shooting");
  level endon("manual_shooting");
  level endon("post_bridge_shooting");

  while(!isDefined(self.mainturret.target_ent)) {
    wait 1;
  }

  wait randomintrange(1, 3);
  var0 = self.origin + (0, 0, 100) + anglesToForward(self.angles) * 200;
  var1 = spawn("script_origin", var0);
  var1.angles = self.angles;
  var1 linkTo(self);
  var2 = gettime() + 3000;
  self.mainturret settargetentity(self.mainturret.target_ent);
  self.mainturret.convergencetime = 0.05;

  for(;;) {
    var3 = var1.origin;
    var4 = anglestoleft(var1.angles) * randomintrange(-300, 300);
    self.mainturret.target_ent.origin = var3 + var4;
    self.mainturret.target_ent linkTo(self);

    while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var2) {
      wait 1;
    }

    wait randomintrange(2, 3);
    var3 = var1.origin;
    var5 = anglestoup(var1.angles) * randomintrange(-30, 50);
    self.mainturret.target_ent unlink();
    self.mainturret.target_ent.origin = var3 + var5;
    self.mainturret.target_ent linkTo(self);

    while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var2) {
      wait 1;
    }

    wait randomintrange(1, 2);
    wait 2;
    self.mainturret.target_ent unlink();
  }

  self.mainturret.target_ent unlink();
}

function tank_pick_vehicle_target(var0) {
  self endon("reset_shooting");
  var0 = scripts\engine\utility::array_removeundefined(var0);

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      tank_shoot_target(var2, [1, 2], scripts\engine\utility::randomvector(80));
      self.mainturret.target_ent unlink();
      break;
    }
  }
}

function tank_pick_ai_target(var0, var1) {
  self endon("reset_shooting");

  if(!isDefined(var0)) {
    var0 = self.mainturret.target_ent.origin;
  }

  if(!isDefined(var1)) {
    var1 = 2000;
  }

  var2 = getaiarrayinradius(var0, var1, "axis");

  if(isDefined(var2) && var2.size > 0) {
    var3 = scripts\engine\utility::getclosest(self.mainturret.target_ent.origin, var2);
    tank_shoot_target(var3, [3, 5], scripts\engine\utility::randomvector(30));
    self.mainturret.target_ent unlink();
    return;
  }
}

function tank_shoot_target(var0, var1, var2) {
  if(isDefined(var0)) {
    self.mainturret.target_ent.origin = var0.origin + (0, 0, 30);

    if(isent(var0)) {
      self.mainturret.target_ent linkTo(var0);
    }
  }

  self.mainturret settargetentity(self.mainturret.target_ent, var2);

  if(isarray(var1)) {
    var1 = randomintrange(var1[0], var1[1]);
  }

  var3 = gettime() + 2000;

  while(!is_aimed_at_target(self.mainturret.target_ent) && gettime() < var3) {
    wait 0.5;
  }

  for(var4 = 1; var4 < var1; var4++) {
    tank_shot();
    wait 0.3 + randomfloat(0.3);
  }
}

function tanksshouldmove(var0) {
  var1 = [level.tank, level.tank2];

  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = var3 scripts\engine\math::is_point_in_front(level.player.origin);

    if(var4) {
      return true;
    }

    if(distancesquared(var3.origin, level.player.origin) < var0 * var0) {
      if(!var4) {
        return true;
      }
    }
  }

  return false;
}

function shouldshootplayer() {
  if(level.player.health <= 10) {
    return false;
  }

  if(scripts\engine\utility::flag("laser_marker_on")) {
    return false;
  }

  if(level.player scripts\sp\maps\lab\lab_util::using_bulletdrop_weapon() && level.player adsButtonPressed(1)) {
    return false;
  }

  return true;
}

function loop_path(var0) {
  self endon("death");

  for(;;) {
    self waittill("reached_end_node");
    wait 3;
    self.hasstarted = undefined;
    self attachpath(var0);
    thread scripts\common\vehicle::vehicle_paths(var0);
    scripts\common\vehicle_paths::gopath(self);
  }
}

function little_bird_spawnfunc() {
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
  GscBinSkip4(0x35);
}

function disable_hilltop_roof_traversal() {
  var0 = getnodesinradius((3425.16, 1056.94, 32), 100, 0);

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.type, "Begin")) {
      destroynavlink(var2);
    }
  }
}

function lb_pilot_init() {
  level endon("hilltop_heli_dead");

  while(!isDefined(self.riders[0])) {
    waitframe();
  }

  self.riders[0].ignoreme = 1;
  self.riders[0] scripts\engine\sp\utility::set_attackeraccuracy(0.3);
  thread lb_pilot_death();
  scripts\engine\utility::flag_wait("heli_intro_movement");
  self.riders[0].ignoreme = 0;
}

function lb_pilot_death() {
  self waittill("death", var0, var0, var1);

  if(isDefined(var1) && (scripts\engine\utility::is_equal(var1.basename, "iw8_sn_hdromeo_ballistics") || scripts\engine\utility::is_equal(var1.basename, "none"))) {
    self delete();
    return;
  }
}

function heli_mg_create() {
  var0 = "tag_light_2";
  var1 = (30, -11.511, 4);
  var2 = self gettagorigin(var0);
  self.minigun = spawnturret("misc_turret", var2, "iw8_vehicle_mg_50cal_heli_lab");
  self.minigun.angles = self gettagangles(var0);
  self.minigun setModel("veh8_mil_air_mindia8_turret");
  self.minigun linkTo(self, var0, var1, (6, 0, 0));
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

function heli_movement() {
  self endon("death");
  var0 = scripts\engine\utility::getStructArray("left_heli_lane", "targetname");
  var1 = scripts\engine\utility::getStructArray("right_heli_lane", "targetname");
  var2 = scripts\engine\utility::getStructArray("left_heli_lane_back", "targetname");
  var3 = scripts\engine\utility::getStructArray("right_heli_lane_back", "targetname");
  var4 = 1;
  var5 = getEnt("gl_intro_door", "script_noteworthy").origin;
  nav_gotopos(self.origin + (0, 0, 500));

  for(;;) {
    self notify("new_goal");

    if(var4) {
      if(scripts\engine\utility::flag("lb_switch_paths")) {
        var6 = var2;
      } else {
        var6 = var0;
      }

      var4 = 0;
    } else {
      if(scripts\engine\utility::flag("lb_switch_paths")) {
        var6 = var3;
      } else {
        var6 = var1;
      }

      var4 = 1;
    }

    var7 = scripts\engine\utility::random(var6);
    var8 = scripts\engine\utility::getStruct(var7.target, "targetname");
    var9 = distance(level.player.origin, var5);
    var10 = var9 * 0.5;
    var11 = level.player.origin + anglesToForward(level.player.angles) * var10;
    var12 = pointonsegmentnearesttopoint(var7.origin, var8.origin, var11);
    var13 = getgroundposition(var12, 60)[2] + 350 + randomint(200);
    var14 = (var12[0], var12[1], var13);
    heli_movetopos_and_idle(var14);
    player_fired_recently_delay();
    wait 0.05;
  }
}

function heli_movetopos_and_idle(var0) {
  nav_gotopos(var0);
  var1 = 6 + randomint(2);
  var2 = gettime();

  while(gettime() < var2 + var1 * 1000) {
    if(scripts\engine\utility::flag("lb_targeting_player")) {
      if(player_is_trying_to_shoot_me() || scripts\engine\utility::flag("laser_marker_on")) {
        return;
      }
    }

    waitframe();
  }
}

function nav_gotopos(var0, var1) {
  self notify("nav_new_path");
  self endon("nav_new_path");
  var2 = findpath3d(self.origin, var0);

  if(!isDefined(var2)) {
    return;
  }

  var3 = 0;
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 37);
  self vehicle_setspeed(var1, var1 * 0.5, var1 * 0.5);

  foreach(var5 in var2) {
    if(var6 == var2.size - 1) {
      var3 = 1;
    }

    self setvehgoalpos(var5, var3);
    scripts\engine\utility::waittill_any("near_goal", "goal");
  }

  self notify("nav_goal");
}

function draw_3d_path(var0) {
  var1 = self.origin;

  foreach(var3 in var0) {
    var1 = var3;
    wait 0.05;
  }
}

function has_ceiling() {
  var0 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 0, 1, 0);
  return !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 1000), self, var0);
}

function track_player_rpg() {
  level.player endon("death");
  level endon("hilltop_heli_dead");
  level.player.last_misile_fire_time = gettime();

  for(;;) {
    level.player waittill("missile_fire", var0);
    var1 = level.player getcurrentprimaryweapon();

    if(var1.classname == "grenade" || var1.classname == "rocketlauncher") {
      level.player.last_misile_fire_time = gettime();
    }
  }
}

function player_fired_recently_delay() {
  if(level.gameskill > 1) {
    return;
  }

  if(scripts\engine\utility::flag("lb_targeting_player")) {
    return;
  }

  if(isDefined(level.player.last_misile_fire_time) && gettime() - level.player.last_misile_fire_time < 2500) {
    wait 2;
    return;
  }
}

function player_using_sniper_rifle() {
  var0 = level.player getcurrentweapon();

  if(isstring(var0)) {
    var1 = weaponclass(var0);
  } else {
    var1 = var1.classname;
  }

  return var1 == "sniper";
}

function player_is_trying_to_snipe_me() {
  if(!level.player adsButtonPressed(1)) {
    return false;
  }

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin - (0, 0, 80), level.cos60)) {
    return false;
  }

  return player_using_sniper_rifle();
}

function player_is_trying_to_shoot_me() {
  var0 = level.player getcurrentweapon();

  switch (var0.classname) {
    case "sniper":
    case "rocketlauncher":
      if(level.player adsButtonPressed(1) && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin - (0, 0, 80), cos(30))) {
        return 1;
      }

      if(gettime() - level.player.last_misile_fire_time <= 1000) {
        return 1;
      }
    default:
      return 0;
  }
}

function heli_attack_logic() {
  self endon("death");
  var0 = cos(50);
  var1 = scripts\engine\trace::create_contents(0, 0, 0, 1, 0, 0, 1, 1);
  var2 = gettime() + 10000;
  self.ignoreme = 0;
  scripts\engine\utility::flag_set("heli_intro_movement");
  childthread scripts\engine\sp\utility::flag_clear_delayed("heli_intro_movement", 10);

  for(;;) {
    jumpiffalse(gettime() < var2 && !scripts\sp\maps\lab\lab_util::in_player_fov(level.cos30, self.origin, [self, level.player])) LOC_00000075;
    wait 0.5;
  }

  for(;;) {
    var3 = get_heli_target(var1);

    if(!isDefined(var3)) {
      wait 0.5;
      continue;
    }

    if(isPlayer(var3)) {
      if(!scripts\engine\utility::flag("lb_targeting_player")) {
        scripts\engine\utility::flag_set("lb_targeting_player");
        self.no_gb_lockon = 1;
      }
    } else if(scripts\engine\utility::flag("lb_targeting_player")) {
      self.no_gb_lockon = undefined;
      scripts\engine\utility::flag_clear("lb_targeting_player");
    }

    self setlookatent(var3);

    while(isalive(var3) && !scripts\engine\utility::within_fov(self.origin, self.angles, var3.origin, var0)) {
      wait 0.1;
    }

    if(!isalive(var3)) {
      waitframe();
      continue;
    }

    if(isai(var3)) {
      shoottokill(var3, var1);
      level.player scripts\engine\sp\utility::set_attackeraccuracy(1);
    } else {
      level.player scripts\engine\sp\utility::set_attackeraccuracy(0.5);

      if(should_kill_player()) {
        shoottokill(var3, var1);
      } else {
        hurttarget(var3);
      }
    }

    wait 2;
  }
}

function get_heli_target(var0) {
  var1 = gettime() - self.lastattackplayertime;

  if(var1 >= 8000) {
    if(!scripts\engine\utility::flag("heli_intro_movement")) {
      self.lastattackplayertime = gettime();
    }

    return level.player;
  }

  var2 = [];

  foreach(var4 in getaiarray("allies")) {
    if(!isDefined(var4.magic_bullet_shield)) {
      var2 = var4;
    }
  }

  var6 = sortbydistance(var2, level.player.origin)[var2.size - 1];
  return var6;
}

function heli_fov_check(var0) {
  var1 = level.player getEye() + (0, 0, 10);
  var2 = self.minigun gettagorigin("tag_flash");
  var3 = scripts\engine\utility::array_removeundefined(level.heroes);
  var4 = scripts\engine\utility::array_add(var3, self);

  if(scripts\engine\trace::ray_trace_passed(var2, var1, var4, var0)) {
    return 1;
  }

  return 0;
}

function should_kill_player() {
  var0 = 10;
  var1 = 15;
  var0 *= 1000;

  if(!isDefined(self.last_kill_attempt_time) && gettime() - self.heli_fight_start >= var1) {
    return true;
  }

  if(isDefined(self.last_kill_attempt_time) && gettime() - self.last_kill_attempt_time >= var0) {
    return true;
  }

  return false;
}

function shoottokill(var0, var1) {
  if(istrue(self.noshooting) || istrue(var0.magic_bullet_shield)) {
    return;
  }

  self endon("death");
  var0 endon("death");
  self endon("stop_shooting");
  self.last_kill_attempt_time = gettime();
  self.is_shooting = 1;
  var2 = 60;

  if(isPlayer(var0)) {
    var3 = 375;
    self.minigun.target_ent.origin = var0.origin + anglesToForward(var0.angles) * var3;

    for(;;) {
      var3 -= 10;
      self.minigun.target_ent.origin = var0.origin + anglesToForward(var0.angles) * var3;
      self.minigun shootturret("tag_flash");
      wait 0.05;

      if(distance(var0.origin, self.minigun.target_ent.origin) < 50) {
        break;
      }
    }
  }

  for(var4 = 0; var4 < var2; var4++) {
    if(isPlayer(var0) && var0 issprinting()) {
      self.minigun settargetentity(var0, scripts\engine\utility::randomvector(50));
    } else {
      self.minigun settargetentity(var0, (15, 15, 20));
    }

    self.minigun shootturret();

    if(var0.health <= 1) {
      if(isPlayer(var0) && !scripts\engine\trace::ray_trace_detail_passed(self.minigun.origin, var0 getEye(), [self.minigun, level.player, self])) {
        return;
      }

      var0 kill();
      return;
    }

    if(var4 == var2 * 0.5) {
      wait 0.3;
      continue;
    }

    wait 0.05;
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

function hurttarget(var0) {
  if(istrue(self.noshooting) || istrue(var0.magic_bullet_shield)) {
    return;
  }

  self endon("death");
  self endon("stop_shooting");
  var0 endon("death");
  self.is_shooting = 1;

  if(level.gameskill < 2) {
    var1 = 30;
    var2 = 60;
  } else {
    var1 = 1;
    var2 = 30;
  }

  var3 = 450;
  self.minigun.target_ent.origin = var2.origin + anglesToForward(var2.angles) * var3;

  for(;;) {
    var3 -= 10;
    self.minigun.target_ent.origin = var2.origin + anglesToForward(var2.angles) * var3;
    self.minigun shootturret();
    wait 0.05;

    if(distance(var2.origin, self.minigun.target_ent.origin) < 50) {
      break;
    }
  }

  var4 = 60;
  var5 = var2.health;
  var6 = 0;

  for(var7 = 0; var7 < var4; var7++) {
    if(var2.health <= var1) {
      break;
    }

    if(isPlayer(var2)) {
      self.minigun settargetentity(var2, scripts\engine\utility::randomvector(var2));
    } else {
      self.minigun settargetentity(var2, (24, -24, 40));
    }

    self.minigun shootturret();
    wait 0.05;

    if(var2.health != var5) {
      var5 = var2.health;
    }
  }

  self.minigun stopbarrelspin();
  self.is_shooting = 0;
}

function canshoottargetfrompos(var0, var1) {
  if(istrue(self.noshooting)) {
    return 0;
  }

  if(isPlayer(var1) || isai(var1)) {
    var2 = var1 getEye();
  } else {
    var2 = var2.origin;
  }

  var3 = sighttracepassed(var1 - (0, 0, self.mg_z_offset), var2, 0, self);
  return var3;
}