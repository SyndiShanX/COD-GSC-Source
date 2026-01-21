/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_rooftops.gsc
*****************************************************/

section_main() {
  setdvarifuninitialized("foo", 2.12);
}

section_precache() {
  precacherumble("steady_rumble");
  precacherumble("light_1s");
  precacherumble("heavy_2s");
  precacherumble("subtle_tank_rumble");
  precacheshellshock("flood_bridge_stumble");
  precachemodel("com_wallchunk_boardsmall03_dark");
  precachemodel("com_plasticcase_beige_big_iw6");
  precachemodel("com_plastic_crate_pallet");
  precachemodel("com_wallchunk_boardlarge01_dark");
  precachemodel("com_pallet_2");
  precachemodel("com_folding_chair");
  precachemodel("com_barrel_green");
  precachemodel("com_wallchunk_boardmedium01_dark");
  precachemodel("com_wallchunk_boardmedium02_dark");
  precachemodel("street_trashcan_open_iw6");
  precachemodel("com_wallchunk_boardsmall04_dark");
  precachemodel("com_trashbin01");
  precachemodel("ny_harbor_cargocontainer_destroyed02");
  precachemodel("vehicle_civilian_sedan_black_iw6");
  precachemodel("vehicle_civilian_sedan_white_iw6");
  precachemodel("moving_truck_iw6");
  precachemodel("flood_mack_truck_short");
  precachemodel("vehicle_uk_utility_truck_static");
  precachemodel("flood_debris_small_01");
  precachemodel("flood_debris_bridge_busted_wall");
  precachemodel("flood_traversal_01_wall");
  precachemodel("blackice_rope_ladder");
  precachemodel("ctl_emergency_flare_animated");
  level._effect["secondary_explosion"] = loadfx("fx/explosions/vehicle_explosion_medium");
  level._effect["glock_flash"] = loadfx("fx/muzzleflashes/ak47_flash_wv");
  level._effect["fx_flare_trail"] = loadfx("fx/misc/flare_trail");
}

section_flag_inits() {
  common_scripts\utility::flag_init("skybridge_initial_hit");
  common_scripts\utility::flag_init("debrisbridge_ready");
  common_scripts\utility::flag_init("debrisbridge_soft_ready");
  common_scripts\utility::flag_init("ally_using_water");
  common_scripts\utility::flag_init("debrisbridge_setup_done");
  common_scripts\utility::flag_init("rooftops_interior_encounter_start");
  common_scripts\utility::flag_init("rooftops_exterior_encounter_start");
  common_scripts\utility::flag_init("rooftops_water_encounter_start");
  common_scripts\utility::flag_init("rooftops_encounter_b_done");
  common_scripts\utility::flag_init("rooftops_heli_spawned");
  common_scripts\utility::flag_init("rooftops_kill_shot");
  common_scripts\utility::flag_init("rooftops_water_heli_approach");
  common_scripts\utility::flag_init("player_fire_initiated_combat");
  common_scripts\utility::flag_init("debrisbridge_LOS_blocked");
  common_scripts\utility::flag_init("rooftops_water_advancing");
  common_scripts\utility::flag_init("flood_rooftop_water_vs_flag");
  common_scripts\utility::flag_init("skybridge_vo_0");
  common_scripts\utility::flag_init("skybridge_vo_1");
  common_scripts\utility::flag_init("skybridge_vo_2");
  common_scripts\utility::flag_init("skybridge_vo_3");
  common_scripts\utility::flag_init("debrisbridge_vo_1");
  common_scripts\utility::flag_init("dont_interupt_vo");
  common_scripts\utility::flag_init("rooftops_vo_interrior_done");
  common_scripts\utility::flag_init("rooftops_vo_final_enemy");
  common_scripts\utility::flag_init("rooftops_vo_kick_wall");
  common_scripts\utility::flag_init("rooftops_vo_check_drop");
  common_scripts\utility::flag_init("player_drop_progress");
}

skybridge_start() {
  maps\flood_util::player_move_to_checkpoint_start("skybridge_start");
  maps\flood_util::spawn_allies();
  thread maps\flood_coverwater::register_coverwater_area("coverwater_stealth", "skybridge_done");
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
  level thread maps\flood_anim::skybridge_doorbreach_setup();
  level.player takeweapon("r5rgp");
  level.player takeweapon("p226");
  level.player giveweapon("flood_knife");
  level.player switchtoweapon("flood_knife");
}

skybridge() {
  level maps\flood_roof_stealth::reset_allies_to_defaults();
  maps\_utility::battlechatter_off("allies");
  maps\_utility::activate_trigger_with_targetname("skybridge_color_order_start");
  level.allies[1] maps\_utility::disable_ai_color();
  level.allies[2] maps\_utility::disable_ai_color();
  setdvar("ui_deadquote", "");
  level.allies[0] maps\_utility::set_force_color("r");
  level.allies[1] maps\_utility::forceuseweapon("fads+reflex_sp", "primary");
  level.allies[2] maps\_utility::forceuseweapon("fads+acog_sp", "primary");
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::set_team_bcvoice("axis", "shadowcompany");
  level.player thread remove_knife_on_drop();
  level thread skybridge_encounter();
  level thread skybridge_to_rooftops_transition();
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
  common_scripts\utility::exploder("rooftops_amb_fx");
  common_scripts\utility::exploder("skybridge_smoke_plume");
  level thread maps\flood_audio::skybridge_precursor_emitter();
  maps\_utility::wait_for_targetname_trigger("skybridge_encounter_0_trigger");
  level thread maps\_utility::autosave_by_name("skybridge_start");
  common_scripts\utility::flag_wait("skybridge_done");
}

remove_knife_on_drop() {
  self endon("death");
  var_0 = 1;

  while(var_0) {
    self waittill("weapon_change");
    var_1 = getweaponarray();

    foreach(var_3 in var_1) {
      if(var_3.classname == "weapon_flood_knife") {
        var_0 = 0;
        var_3 delete();
        break;
      }
    }
  }
}

skybridge_teleport_cheats() {
  wait 1.05;
  var_0 = getnode("skybridge_breach_node", "targetname");
  var_1 = distance(level.allies[0].origin, var_0.origin);

  if(256 < var_1) {
    var_2 = common_scripts\utility::getstruct("skybridge_breach_jumpto", "targetname");
    level.allies[0] forceteleport(var_2.origin, var_2.angles, 1024);
    var_3 = level.allies[0].moveplaybackrate;
    level.allies[0].moveplaybackrate = 1.2;
    wait 3.6;
    level.allies[0].moveplaybackrate = var_3;
  }
}

skybridge_ally_setup_breach() {
  wait 1.0;
  var_0 = getnode("skybridge_breach_node", "targetname");
  var_1 = 1;

  if(128 < distance(level.allies[0].origin, var_0.origin)) {
    if(256 < distance(level.allies[0].origin, var_0.origin)) {
      var_2 = common_scripts\utility::getstruct("skybridge_breach_jumpto", "targetname");
      var_1 = self.moveplaybackrate;
      self.moveplaybackrate = 1.15;
    } else
      var_2 = common_scripts\utility::getstruct("skybridge_ally_1", "targetname");

    self forceteleport(var_2.origin, var_2.angles, 1024);
  }

  wait 3.0;
  self.moveplaybackrate = var_1;
}

skybridge_encounter() {
  level.allies[0] thread skybridge_ally_vo();
  level.allies[0] thread skybridge_ally_logic();
  maps\_utility::wait_for_targetname_trigger("skybridge_encounter_0_trigger");
}

skybridge_debris_hit_large(var_0) {}

skybridge_debris_hit_med(var_0) {}

skybridge_debris_hit(var_0) {
  if(common_scripts\utility::flag("on_skybridge")) {
    stopallrumbles();

    if("large" == var_0) {
      level.player shellshock("flood_bridge_stumble", 0.6);
      level.player playrumbleonentity("heavy_2s");
      wait 0.75;
      level.player.on_bridge = 0;
    } else if("med" == var_0) {
      level.player playrumbleonentity("light_1s");
      wait 0.75;
      level.player.on_bridge = 0;
    }
  }
}

skybridge_rumble_logic() {
  self endon("death");
  level.player.on_bridge = 0;
  thread maps\_utility::player_speed_set(112, 0.05);

  while(!common_scripts\utility::flag("skybridge_safe_area")) {
    if(!self isonground() && level.player.on_bridge) {
      stopallrumbles();
      level.player notify("earthquake_end");
      level.player.on_bridge = 0;
    } else if(self isonground() && !level.player.on_bridge) {
      level.player playrumblelooponentity("subtle_tank_rumble");
      level.player thread maps\flood_util::earthquake_w_fade(0.21, 20);
      level.player.on_bridge = 1;
    }

    wait 0.05;
  }

  thread maps\_utility::player_speed_default(1.0);
  stopallrumbles();
  level.player thread maps\flood_util::earthquake_w_fade(0.21, 1.0, 0, 0.5);
}

skybridge_ally_logic() {}

skybridge_approach_fluff() {
  maps\_utility::trigger_wait_targetname("skybridge_approach_rumble");
  level.player playSound("scn_flood_mall_rumble_shake_int_lg");
  wait 1.893;
  level.player thread maps\flood_util::earthquake_w_fade(0.2, 0.95, 0.25, 0.6);
  level.player playrumbleonentity("light_1s");
}

rooftops_start() {
  maps\flood_util::player_move_to_checkpoint_start("rooftops_start");
  maps\flood_util::spawn_allies();
  level.allies[0] maps\_utility::clear_force_color();
  level.allies[1] maps\_utility::clear_force_color();
  level.allies[2] maps\_utility::clear_force_color();
  level.allies[0] maps\_utility::set_force_color("r");
  level thread skybridge_to_rooftops_transition();
  waittillframeend;
  maps\_utility::activate_trigger_with_targetname("rooftops_ally_logic_0_trigger");
  common_scripts\utility::flag_set("skybridge_heli_go");
  common_scripts\utility::flag_set("skybridge_safe_area");
  common_scripts\utility::flag_set("skybridge_ally_done");
  maps\_utility::activate_trigger_with_targetname("rooftops_color_order_start");
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
  level.player takeweapon("r5rgp");
  level.player takeweapon("p226");
  level.player giveweapon("pp19");
  level.player giveweapon("flood_knife");
  level.player switchtoweapon("pp19");
}

rooftops() {
  level thread maps\_utility::autosave_by_name("rooftops_a_start");
  level thread rooftops_encounter_a();
  level thread rooftops_to_rooftops_water_transition();
  common_scripts\utility::exploder("ending_smk_plume");
  common_scripts\utility::flag_wait("rooftops_done");
  level thread rooftops_cleanup_post_wallkick();
}

rooftops_encounter_a() {
  thread maps\flood_anim::rooftops_outro_scene_setup();
  thread rooftops_outro_setup_blocker();

  for(var_0 = 0; var_0 < 3; var_0++) {
    var_1 = getEntArray("rooftops_encounter_a_" + var_0 + "_spawner", "targetname");
    common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, maps\_utility::set_grenadeammo, 0);

    switch (var_0) {
      case 0:
        break;
      case 1:
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftop_enemy_exfil_logic);
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_enemy_aggresive_logic);
        maps\flood_anim::rooftops_enemy_exfil_spawn_actors(var_1);
        level thread maps\flood_anim::rooftops_enemy_exfil_setup_heli();
        rooftops_exterior_waittill_encounter_trigger();
        thread maps\flood_anim::rooftops_enemy_exfil_spawn();
        level.allies[0] thread rooftops_encounter_a_ally_reveal_logic();
        break;
      case 2:
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_encounter_a_enemy_logic);
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftop_enemy_exfil_logic);
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_enemy_combat_logic);
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_enemy_aggresive_logic);
        common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai);
        waittillframeend;

        if(common_scripts\utility::flag("rooftops_runner_escape")) {
          maps\_utility::activate_trigger_with_targetname("exfil_abort");
          common_scripts\utility::flag_set("rooftops_exterior_encounter_start");
        }

        break;
    }
  }

  common_scripts\utility::flag_wait_all("rooftops_encounter_a_death", "rooftop_runners_death");
  maps\flood_util::cleanup_triggers("rooftops_encounter_a");
  level thread rooftops_encounter_a_outro();
  common_scripts\utility::flag_wait("rooftops_vo_check_drop");
  maps\_utility::autosave_by_name("rooftops_a_done");
}

rooftops_encounters_logic() {
  level.player thread rooftops_encounters_player_logic();
  level.allies[0] thread rooftops_encounters_ally_logic();
  common_scripts\utility::flag_wait("rooftops_interior_encounter_start");
  thread maps\_utility::battlechatter_on("axis");
  common_scripts\utility::flag_wait("rooftops_exterior_encounter_start");
  thread maps\_utility::battlechatter_on("axis");
}

rooftops_encounters_player_logic() {
  common_scripts\utility::flag_wait("skybridge_safe_area");
  level.player allowprone(1);
  level thread rooftops_cleanup_post_skybridge();
  maps\_utility::set_player_attacker_accuracy(0);
  self.ignorerandombulletdamage = 1;
  thread rooftops_player_start_combat_attack("rooftops_interior_encounter_start");
  thread rooftops_interior_player_start_combat_trigger();
  common_scripts\utility::flag_wait("rooftops_interior_encounter_start");
  wait 2.5;
  maps\_gameskill::updatealldifficulty();
  self.ignorerandombulletdamage = 0;
  common_scripts\utility::flag_wait("rooftops_exterior_in_combat_space");
  maps\_utility::set_player_attacker_accuracy(0);
  self.ignorerandombulletdamage = 1;
  thread rooftops_player_start_combat_attack("rooftops_exterior_encounter_start");
  common_scripts\utility::flag_wait("rooftops_exterior_encounter_start");
  var_0 = getent("in_sight_of_enemy_exfil", "targetname");

  if(isDefined(var_0))
    var_0 waittill("trigger");

  thread maps\flood_util::notify_on_function_finish("can_be_hit", common_scripts\utility::waittill_notify_or_timeout, "weapon_fired", 2.5);

  if(isDefined(getent("exfil_abort", "targetname"))) {
    thread maps\flood_util::notify_on_function_finish("can_be_hit", maps\_utility::wait_for_targetname_trigger, "exfil_abort");
    self waittill("can_be_hit");
  }

  maps\_gameskill::updatealldifficulty();
  self.ignorerandombulletdamage = 0;
}

rooftops_player_start_combat_attack(var_0) {
  common_scripts\utility::flag_clear("player_fire_initiated_combat");
  common_scripts\utility::waittill_any("weapon_fired", "grenade_fire");
  common_scripts\utility::flag_set(var_0);
  common_scripts\utility::flag_set("player_fire_initiated_combat");
}

rooftops_interior_player_start_combat_trigger() {
  thread rooftops_interior_start_combat_solid_sight_line();
  thread rooftops_interior_start_combat_soft_sight_line();
}

rooftops_interior_start_combat_solid_sight_line() {
  maps\_utility::wait_for_targetname_trigger("in_sight_of_runners");
  common_scripts\utility::flag_set("rooftops_interior_encounter_start");
}

rooftops_interior_start_combat_soft_sight_line() {
  maps\_utility::wait_for_targetname_trigger("in_sight_of_runners_early");

  switch (maps\_utility::getdifficulty()) {
    case "fu":
      wait 1.5;
      break;
    case "hard":
      wait 3.0;
      break;
    default:
      wait 7.0;
  }

  common_scripts\utility::flag_set("rooftops_interior_encounter_start");
}

rooftops_encounters_ally_logic() {
  thread rooftops_encounter_a_ally_vo();
  common_scripts\utility::flag_wait("skybridge_ally_done");
  thread rooftops_ally_cqb_to_first_node();
  maps\_utility::disable_surprise();
  self.ignoreall = 1;
  self.ignoreme = 1;
  common_scripts\utility::flag_wait("rooftops_interior_encounter_start");
  self notify("spotted");
  self.ignoreme = 0;

  if(common_scripts\utility::flag("rooftops_vo_interrior_done"))
    maps\flood_util::waittill_danger();

  self.ignoreall = 0;
  thread rooftops_ally_advance_to_roof();
  maps\_utility::wait_for_targetname_trigger("rooftops_ally_logic_1_trigger");
  thread rooftops_encounter_a_ally_cleanup_logic();
  thread rooftops_encounter_a_ally_crouch_walk_to_cover();
  common_scripts\utility::flag_wait("rooftops_encounter_a_death");
  self allowedstances("stand", "crouch", "prone");
}

rooftops_encounter_a_ally_crouch_walk_to_cover() {
  var_0 = getent("in_sight_of_enemy_exfil", "targetname");

  if(isDefined(var_0)) {
    var_1 = self.goalradius;
    self.goalradius = 64;
    self allowedstances("crouch");
    self waittill("goal");
    self.goalradius = var_1;
    self allowedstances("stand", "crouch", "prone");
  }
}

rooftops_exterior_waittill_encounter_trigger() {
  var_0 = getent("rooftops_encounter_a_1_trigger", "targetname");

  while(!common_scripts\utility::flag("rooftops_runner_escape")) {
    if(!isDefined(var_0)) {
      break;
    }

    wait 0.05;
  }
}

rooftops_encounter_a_ally_cleanup_logic() {
  common_scripts\utility::flag_wait("rooftops_exterior_encounter_start");
  thread maps\flood_util::notify_on_enemy_count(1, undefined, "rooftops_kill_shot");
  common_scripts\utility::flag_wait("rooftops_kill_shot");
  common_scripts\utility::flag_set("rooftops_vo_final_enemy");
  maps\flood_util::cleanup_triggers("rooftops_encounter_a");
  maps\_utility::activate_trigger_with_targetname("rooftops_encounter_a_kill_shot");
  thread maps\_utility::battlechatter_off("allies");
  var_0 = self.suppressionwait;
  self.ignoresuppression = 1;
  self.suppressionwait = 0;
  common_scripts\utility::flag_wait("rooftops_encounter_a_death");
  self.suppressionwait = var_0;
  self.ignoresuppression = 0;
}

rooftops_ally_cqb_to_first_node() {
  maps\_utility::enable_cqbwalk();
  common_scripts\utility::flag_wait("rooftops_interior_encounter_start");
  maps\_utility::disable_cqbwalk();
}

rooftops_ally_advance_to_roof() {
  level thread maps\flood_util::notify_on_enemy_count_touching_volume("rooftop_runners_vol", 0, "enemies_escaped");
  level common_scripts\utility::waittill_any("enemies_escaped", "rooftop_runners_death");
  level notify("stop_checking_volume");
  var_0 = getent("rooftops_encounter_a_setup", "targetname");

  if(isDefined(var_0))
    var_0 maps\_utility::activate_trigger();

  var_1 = self.suppressionwait;
  maps\_utility::disable_cqbwalk();
  self.suppressionwait = 0;
  self.ignoresuppression = 1;
  self.disableplayeradsloscheck = 1;
  self.disablefriendlyfirereaction = 1;
  maps\_utility::wait_for_targetname_trigger("rooftops_ally_logic_1_trigger");
  self.suppressionwait = var_1;
  self.ignoresuppression = 0;
  self.disableplayeradsloscheck = 0;
  self.disablefriendlyfirereaction = undefined;
}

rooftops_encounter_a_ally_reveal_logic() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  maps\flood_util::waittill_danger_or_trigger("exfil_abort");
  self.ignoreall = 0;
  self.ignoreme = 0;
}

rooftops_encounter_a_enemy_logic() {
  self endon("death");
  self waittill("combat_ready");

  if(!common_scripts\utility::flag("rooftops_kill_shot")) {
    thread maps\flood_util::update_goal_vol_from_trigger("rooftops_encounter_a_intro_trigger", "rooftops_encounter_a_intro_vol");
    thread maps\flood_util::update_goal_vol_from_trigger("rooftops_encounter_a_flank_left_trigger", "rooftops_encounter_a_flank_left_vol");
    thread maps\flood_util::update_goal_vol_from_trigger("rooftops_encounter_a_flank_right_trigger", "rooftops_encounter_a_flank_right_vol");
  }
}

rooftop_enemy_runner_logic() {
  self endon("death");
  maps\_utility::disable_surprise();

  if("rooftop_runner_computer" == self.target) {
    self.animname = "generic";
    self.health = 1;
    self.allowdeath = 1;
    var_0 = common_scripts\utility::getstruct(self.target, "targetname");
    var_0 thread maps\_anim::anim_loop_solo(self, "hacking", "enemies_spotted");
  } else {
    var_1 = common_scripts\utility::getstruct(self.target, "targetname");
    self teleport(var_1.origin, var_1.angles);
    maps\_utility::set_fixednode_true();
    self.ignoreall = 1;
  }

  common_scripts\utility::flag_wait("rooftops_interior_encounter_start");
  self notify("enemy_near");
  self notify("combat_ready");
  var_2 = self.maxfaceenemydist;
  var_3 = self.goalradius;
  self.goalradius = 32;

  if("rooftop_runner_computer" == self.target) {
    if(common_scripts\utility::flag("player_fire_initiated_combat"))
      wait(randomfloat(0.5));
    else
      wait(1.0 + randomfloat(0.5));

    self notify("enemies_spotted");
    self stopanimscripted();
    self.fixednode = 1;
    self.maxfaceenemydist = 1024;
    self setgoalnode(getnode("runner_goal_0", "targetname"));
    wait 2.0;
    self.ignoreall = 1;
    wait 2.5;
    self.ignoreall = 0;
  } else {
    self notify("fire");

    if(!common_scripts\utility::flag("rooftops_vo_interrior_done"))
      wait 0.5;

    maps\_utility::set_fixednode_false();
    self.ignoreall = 0;
    thread rooftop_runner_force_gunfire();
    self setgoalnode(getnode("rooftop_runner_cover", "targetname"));
    self waittill("goal");
    wait 2.5;
    self setgoalnode(getnode("runner_goal_1", "targetname"));
  }

  self waittill("goal");
  self.fixednode = 0;
  self.maxfaceenemydist = var_2;
  self.goalradius = var_3;
  maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_a_intro_vol");
}

rooftop_runner_force_gunfire() {
  wait 0.5;
  self shoot(1.0, level.player.origin + (0, 0, 64));
  wait 0.2;
  self shoot(1.0, level.player.origin + (0, 0, 64));
  wait 0.2;
  self shoot(1.0, level.player.origin + (0, 0, 64));
}

rooftop_enemy_exfil_logic() {
  self endon("death");
  waittillframeend;

  if(isDefined(self.script_noteworthy)) {
    if("cover_flank" == self.script_noteworthy) {
      self.fixednode = 1;
      thread rooftops_player_spotted_vo("exfil_abort");
      level thread rooftops_enemy_alert_rest(self);
      var_0 = getnode("node_cover_flank_start", "targetname");
      var_0 thread maps\_anim::anim_loop_solo(self, "stand_idle", "enemy_spotted");
      self waittill("enemy");
      var_0 notify("enemy_spotted");
      self stopanimscripted();
      maps\_utility::handsignal("enemy");
      wait 3.0;
      self.fixednode = 0;
    } else if("ladder_holder" == self.script_noteworthy) {
      maps\_utility::disable_surprise();
      thread rooftops_encounter_a_enemy_logic();
      self waittill("fight");
      self.health = 120;
    } else if("cover_ledge" == self.script_noteworthy) {
      self.animname = "generic";
      var_0 = getnode("node_cover_ledge_start", "targetname");
      var_0 thread maps\_anim::anim_loop_solo(self, "stand_idle", "enemy_spotted");
      self waittill("fight");
      wait 0.3;
      var_0 notify("enemy_spotted");
      self stopanimscripted();
    } else {
      self.ignoreall = 1;
      maps\_patrol_anims_creepwalk::enable_creepwalk();
      thread maps\_patrol::patrol();
      self waittill("fight");
      self.ignoreall = 0;
      self waittill("enemy");
      self notify("stop_going_to_node");
    }

    var_0 = getnode("node_" + self.script_noteworthy, "targetname");
    var_1 = self.goalradius;
    self.goalradius = var_0.radius;
    self.fixednode = 1;
    self setgoalnode(var_0);
    self waittill("goal");
    self.goalradius = var_1;
    wait 2.0;
    self.fixednode = 0;
    self notify("combat_ready");
    maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_a_intro_vol");
  }
}

rooftops_enemy_alert_rest(var_0) {
  var_0 maps\flood_util::add_actor_danger_listeners();
  var_0 common_scripts\utility::waittill_any("enemy", "death", "ai_event");
  var_1 = maps\_utility::get_ai_group_ai("back_line");

  foreach(var_3 in var_1)
  var_3 notify("fight");

  common_scripts\utility::flag_set("rooftops_exterior_encounter_start");
  maps\_utility::activate_trigger_with_targetname("rooftops_encounter_a_vo_1");
}

rooftops_outro_setup_blocker() {
  var_0 = getent("brick_wall_blocker", "targetname");
  var_0 movez(-128, 0.05);
  maps\_utility::wait_for_targetname_trigger("rooftops_ally_exited");
  var_0 = getent("brick_wall_blocker", "targetname");
  var_0 notsolid();
}

rooftops_outro_remove_blocker(var_0) {
  var_1 = getent("brick_wall_blocker", "targetname");
  var_1 notsolid();
}

rooftops_encounter_a_outro() {
  level.allies[0] pushplayer(1);
  level.allies[0] maps\_utility::disable_ai_color();
  level.allies[0] maps\_utility::disable_turnanims();
  maps\flood_anim::rooftops_outro_scene_spawn();
  level.allies[0] pushplayer(0);

  if(common_scripts\utility::flag("vignette_rooftops_water_long_jump"))
    level thread maps\flood_anim::rooftops_water_long_jump_spawn();
  else {
    level.allies[0] maps\_utility::enable_ai_color();
    maps\_utility::activate_trigger_with_targetname("rooftops_encounter_a_done");
    level thread rooftops_long_jump();
  }
}

rooftops_long_jump() {
  common_scripts\utility::flag_wait("vignette_rooftops_water_long_jump");
  maps\flood_anim::rooftops_water_long_jump_spawn();
}

rooftop_water_start() {
  maps\flood_util::player_move_to_checkpoint_start("rooftop_water_start");
  maps\flood_util::spawn_allies();
  level.allies[0] maps\_utility::clear_force_color();
  level.allies[1] maps\_utility::clear_force_color();
  level.allies[2] maps\_utility::clear_force_color();
  level.allies[0] maps\_utility::set_force_color("r");
  thread rooftops_to_rooftops_water_transition();
  common_scripts\utility::flag_set("rooftops_player_dropped_down");
  maps\_utility::activate_trigger_with_targetname("rooftop_water_color_order_start");
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
}

script_turnoff_garagefacade() {
  level endon("debrisbridge_done");
  var_0 = getent("trigger_turnoff_garagefacade", "targetname");
  var_0 waittill("trigger");
  thread maps\flood_util::hide_models_by_targetname("garage_facade");
  thread script_turnon_garagefacade();
}

script_turnon_garagefacade() {
  level endon("debrisbridge_done");
  var_0 = getent("trigger_turnon_garagefacade", "targetname");
  var_0 waittill("trigger");
  thread maps\flood_util::show_models_by_targetname("garage_facade");
  thread script_turnoff_garagefacade();
}

rooftop_water() {
  thread maps\flood_coverwater::register_coverwater_area("coverwater_rooftop", "debrisbridge_done");
  level.cw_player_in_rising_water = 0;

  if(maps\_utility::getdifficulty() == "fu")
    level.cw_player_allowed_underwater_time = 10;
  else
    level.cw_player_allowed_underwater_time = 15;

  thread maps\flood_fx::fx_rooftop2_ambient();
  level thread maps\_utility::autosave_by_name_silent("rooftops_b_start");
  level thread script_turnoff_garagefacade();
  level thread rooftops_encounter_b();
  level thread track_underwater_melee_achievement();
  level thread rooftop_water_to_debrisbridge_transition();
  maps\_utility::stop_exploder("skybridge_smoke_plume");
  common_scripts\utility::flag_wait("rooftop_water_done");
}

track_underwater_melee_achievement() {
  level.player endon("death");
  level.underwater_melee_kill_achievement_count = 0;

  while(level.underwater_melee_kill_achievement_count < 5) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(!isDefined(var_2.is_tracking_underwater_melee_kill_achievement)) {
        var_2.is_tracking_underwater_melee_kill_achievement = 1;
        var_2 thread track_underwater_melee_achievement_ai();
      }
    }

    common_scripts\utility::waitframe();
  }

  level.player maps\_utility::player_giveachievement_wrapper("LEVEL_6A");
}

track_underwater_melee_achievement_ai() {
  self waittill("death", var_0);

  if(common_scripts\utility::flag("cw_player_underwater") && self.damagemod == "MOD_MELEE" && isDefined(var_0) && var_0 == level.player)
    level.underwater_melee_kill_achievement_count++;
}

rooftops_encounter_b() {
  level.allies[0] thread rooftops_encounter_b_ally_logic();
  level.player thread rooftops_water_player_logic();
  level thread rooftops_water_set_advancing_state();
  level thread rooftops_encounter_b_enemy_vo();
  level thread rooftops_encounter_b_enemy_movement_logic();
  level thread rooftops_encounter_b_force_clear();
  level thread rooftops_water_enemy_heli_logic();

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = getEntArray("rooftops_encounter_b_" + var_0 + "_spawner", "targetname");
    common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, maps\_utility::disable_long_death);
    common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, maps\_utility::set_grenadeammo, 0);
    common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_water_enemy_logic);

    switch (var_0) {
      case 0:
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_water_truck_actor_setup);
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_water_reveal_logic);
        maps\flood_anim::rooftops_water_intro_spawn_actors(var_1);
        thread maps\flood_anim::rooftops_water_intro();
        break;
      case 1:
        common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::rooftops_water_reveal_logic);
        common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai, 1);
        break;
      case 2:
        common_scripts\utility::flag_wait("rooftops_water_in_combat_space");
        level thread rooftops_cleanup_post_walkway();
        level notify("fight");
        level thread trigger_vo_in_combat("rooftops_encounter_b_vo_1", 10.0 + randomfloat(3.0));
        maps\flood_util::waittill_aigroup_count_or_timeout("rooftop_scene_actors", 1, 12.0);
        maps\flood_util::cleanup_triggers("rooftops_encounter_b_cleanup_push");

        if(!common_scripts\utility::flag("rooftops_water_advancing"))
          maps\_utility::activate_trigger_with_targetname("rooftops_water_push_0");

        common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai, 1);
        break;
      case 3:
        maps\flood_util::waittill_enemy_count_or_flag(3, "rooftops_water_enemy_retreat");
        var_2 = getent("debrisbridge_color_order_start", "targetname");

        if(!common_scripts\utility::flag("rooftop_water_done")) {
          if(isDefined(var_2))
            common_scripts\utility::array_thread(var_1, maps\_utility::spawn_ai, 1);

          thread maps\flood_util::notify_on_enemy_count(2, "final_push");
          self waittill("final_push");
          maps\flood_util::cleanup_triggers("rooftops_encounter_b");
        } else {
          foreach(var_4 in var_1)
          var_4 delete();
        }

        if(!common_scripts\utility::flag("rooftops_water_advancing"))
          maps\_utility::activate_trigger_with_targetname("rooftops_water_push_1");

        break;
    }
  }

  common_scripts\utility::flag_wait("rooftops_encounter_b_death");
  maps\flood_util::cleanup_triggers("rooftops_encounter_b_cleanup_push");
  maps\flood_util::cleanup_triggers("rooftops_encounter_b");
  common_scripts\utility::flag_set("rooftops_encounter_b_done");
  rooftops_encounter_b_outro();
  maps\_utility::autosave_by_name("rooftops_b_done");
}

rooftops_water_intro_flare_setup(var_0, var_1) {
  playFXOnTag(level._effect["fx_flare_trail"], var_0, "TAG_FIRE_FX");
  playFXOnTag(level._effect["fx_flare_trail"], var_1, "TAG_FIRE_FX");
  thread rooftops_water_intro_flare_actor_cleanup();
  common_scripts\utility::flag_wait("rooftops_water_flare_intro_done");
  var_0 stopanimscripted();
  var_1 stopanimscripted();
  var_2 = bulletTrace(var_0.origin, var_0.origin - (0, 0, 10000), 0);
  var_0 moveto(var_2["position"], 0.5);
  var_0 rotateto((0, randomint(360), randomint(360)), 0.5);
  var_2 = bulletTrace(var_1.origin, var_1.origin - (0, 0, 10000), 0);
  var_1 moveto(var_2["position"], 0.5);
  var_1 rotateto((0, randomint(360), randomint(360)), 0.5);
  wait 5.0;
  stopFXOnTag(level._effect["fx_flare_trail"], var_0, "TAG_FIRE_FX");
  stopFXOnTag(level._effect["fx_flare_trail"], var_1, "TAG_FIRE_FX");
}

rooftops_water_intro_flare_actor_cleanup() {
  self waittill("death");
  common_scripts\utility::flag_set("rooftops_water_flare_intro_done");
}

rooftops_water_truck_intro_weapon_cleanup() {
  self waittill("death");

  if(isDefined(self.glock))
    self.glock delete();
}

rooftops_water_truck_actor_setup() {
  thread maps\flood_util::add_actor_danger_listeners();
  self waittill("ai_event");
  common_scripts\utility::flag_set("rooftops_water_encounter_start");
}

rooftops_water_reveal_grab_gun(var_0) {
  var_0.glock.origin = var_0 gettagorigin("TAG_INHAND");
  var_0.glock.angles = var_0 gettagangles("TAG_INHAND");
  var_0.glock linkto(var_0, "TAG_INHAND");
}

rooftops_water_reveal_shoot(var_0) {
  if(isDefined(var_0.glock)) {
    var_1 = level.player getEye();
    var_2 = vectornormalize(var_1 - var_0.glock gettagorigin("TAG_FLASH"));
    var_3 = anglestoright(vectortoangles(var_2));
    var_4 = 1;

    if(randomint(2))
      var_4 = -1;

    playFXOnTag(level._effect["glock_flash"], var_0.glock, "TAG_FLASH");
    magicbullet("pp19", var_0.glock gettagorigin("TAG_FLASH"), var_1 + var_4 * var_3 * randomintrange(20, 32));
  }
}

rooftops_water_player_logic() {
  thread rooftops_water_player_ignoreme_logic();
  maps\_utility::set_player_attacker_accuracy(0);
  self.ignorerandombulletdamage = 1;
  common_scripts\utility::flag_wait("rooftops_water_in_combat_space");
  common_scripts\utility::flag_set("rooftops_water_encounter_start");
  maps\_utility::wait_for_notify_or_timeout("weapon_fired", 6.0);
  getent("rooftops_water_sight_blocker", "targetname") delete();
  maps\_gameskill::updatealldifficulty();
  self.ignorerandombulletdamage = 0;
}

rooftops_water_player_ignoreme_logic() {
  self.ignoreme = 1;
  common_scripts\utility::flag_wait("rooftops_water_in_combat_space");
  maps\_utility::wait_for_notify_or_timeout("weapon_fired", 4.0);
  wait(randomfloat(0.5));
  self.ignoreme = 0;
}

rooftops_water_enemy_logic() {
  self endon("death");
  maps\_utility::magic_bullet_shield();
  common_scripts\utility::flag_wait("rooftops_water_in_combat_space");
  self notify("stop_going_to_node");
  maps\_utility::stop_magic_bullet_shield();
}

rooftops_water_enemy_heli_logic() {
  var_0 = getent("rooftops_water_heli_0", "targetname");
  var_0 maps\_utility::add_spawn_function(::rooftops_water_heli_movement_logic);
  var_1 = maps\_vehicle::vehicle_spawn(var_0);
  var_1 thread maps\flood_audio::sfx_heli_rooftops_water_idle();
}

rooftops_water_heli_movement_logic() {
  self endon("death");
  level endon("rooftops_water_heli_exit");
  thread rooftops_water_heli_exit_logic();
  thread rooftops_water_heli_damage_logic();
  level.rooftops_water_heli = self;
  self notify("stop_friendlyfire_shield");
  self.health = self.script_startinghealth;

  if(isDefined(self.mgturret)) {
    foreach(var_1 in self.mgturret) {
      var_1 setaispread(3);
      var_1 setconvergencetime(2.5);
      var_1.accuracy = 0.85;
    }
  }
}

rooftops_water_heli_damage_logic() {
  self endon("death");

  for(;;) {
    self waittill("damage");

    if(self.health < 2500) {
      break;
    }
  }

  common_scripts\utility::flag_set("rooftops_water_heli_exit");
}

rooftops_water_heli_exit_logic() {
  self endon("death");
  common_scripts\utility::flag_wait("rooftops_water_encounter_start");
  thread maps\flood_audio::sfx_heli_rooftops_water();
  thread maps\_vehicle::gopath();
  common_scripts\utility::flag_wait_or_timeout("rooftops_water_heli_exit", 5.7);
  var_0 = common_scripts\utility::getstruct("south_exit", "targetname");
  self clearlookatent();
  self vehicle_helisetai(var_0.origin, 45, 10, 15, 0, (0, 0, 0), 0, 0.0, 0, 0, 0, 0, 0);
  self.attachedpath = var_0;
  thread maps\_vehicle::vehicle_paths(var_0);
}

rooftops_water_enter_combat_space() {
  var_0 = getent("rooftops_water_jumpdown_splash_ally", "targetname");
  var_0 thread rooftops_water_enter_combat_space_play_effects();
  var_0 = getent("rooftops_water_jumpdown_splash", "targetname");
  var_0 thread rooftops_water_enter_combat_space_play_effects();
}

rooftops_water_enter_combat_space_play_effects() {
  self waittill("trigger", var_0);
  var_1 = undefined;

  if(var_0 == level.player) {
    var_0 playrumbleonentity("heavy_2s");
    var_2 = anglesToForward(level.player getplayerangles());
    var_1 = var_0.origin + (0, 0, 24) + var_2 * 28;
    var_0 playSound("scn_flood_intowater_splash_plr_ss");
  } else {
    var_1 = var_0.origin + (0, 0, 16);
    var_0 playSound("scn_flood_intowater_splash_ss");
  }
}

rooftops_encounter_b_ally_logic() {
  thread rooftops_encounter_b_ally_vo();
  maps\_utility::wait_for_targetname_trigger("rooftop_water_color_order_start");
  thread rooftops_water_ally_presence();
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread rooftops_encounter_b_ally_use_water_correctly();
  maps\_utility::disable_surprise();
  common_scripts\utility::flag_wait("rooftops_water_encounter_start");
  var_0 = getent("in_sight_of_rooftop_scene", "targetname");

  if(isDefined(var_0))
    var_0 maps\_utility::activate_trigger();

  self.ignoreall = 0;
  self.ignoreme = 0;
  thread maps\flood_util::notify_on_enemy_count(1, "go_for_the_kill");
  self waittill("go_for_the_kill");
  maps\flood_util::cleanup_triggers("rooftops_encounter_b");
  var_0 = getent("rooftops_encounter_b_kill_shot", "targetname");

  if(isDefined(var_0))
    var_0 maps\_utility::activate_trigger();
}

rooftops_water_set_advancing_state() {
  var_0 = getent("push_to_next_encounter", "script_noteworthy");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("rooftops_water_advancing");
}

rooftops_water_ally_presence() {
  self endon("ai_event");
  maps\_utility::wait_for_targetname_trigger("in_sight_of_rooftop_scene_ally");
  wait 20.0;
  common_scripts\utility::flag_set("rooftops_water_encounter_start");
  self notify("ai_event");
}

rooftops_encounter_b_enemy_movement_logic() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  maps\_utility::wait_for_targetname_trigger("in_sight_of_rooftop_scene");

  while(!common_scripts\utility::flag("rooftops_encounter_b_death")) {
    if(common_scripts\utility::flag("rooftops_encounter_b_player_turtling") && !common_scripts\utility::flag("cw_player_underwater")) {
      if(!var_0) {
        thread rooftops_encounter_b_handle_turtling();
        var_0 = 1;
      }
    } else {
      var_0 = 0;

      if(common_scripts\utility::flag("rooftops_encounter_b_player_defensive") && !common_scripts\utility::flag("cw_player_underwater")) {
        if(!var_1) {
          thread rooftops_encounter_b_handle_defensive();
          var_1 = 1;
        }
      } else {
        var_1 = 0;

        if(common_scripts\utility::flag("rooftops_encounter_b_player_aggresive") && !common_scripts\utility::flag("cw_player_underwater")) {
          var_3 = maps\_utility::get_ai_group_sentient_count("rooftop_scene_actors");
          var_4 = maps\_utility::get_ai_group_sentient_count("rooftops_encounter_b_main");
          var_5 = maps\_utility::get_ai_group_sentient_count("rooftops_encounter_b_backup");
          var_6 = common_scripts\utility::array_combine(maps\_utility::get_ai_group_ai("rooftop_scene_actors"), maps\_utility::get_ai_group_ai("rooftops_encounter_b_main"));
          var_7 = common_scripts\utility::array_combine(var_6, maps\_utility::get_ai_group_ai("rooftops_encounter_b_backup"));
          maps\flood_util::reassign_goal_volume(var_7, "rooftops_encounter_b_ledge_vol");
          wait 5.0;
        }
      }
    }

    wait 1.0;
  }
}

rooftops_encounter_b_handle_turtling() {
  self notify("handle_turtling");
  self endon("handle_turtling");
  thread maps\flood_util::notify_on_flag_open("rooftops_encounter_b_player_turtling", "handle_turtling");
  wait 10.0;

  while(!common_scripts\utility::flag("rooftops_encounter_b_death")) {
    var_0 = maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_flush_vol");

    if(2 > var_0.size) {
      var_1 = 2 - var_0.size;
      var_0 = maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_catwalk_vol");

      if(var_1 > var_0.size) {
        var_0 = common_scripts\utility::array_combine(var_0, maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_ledge_vol"));

        if(var_1 > var_0.size) {
          var_0 = common_scripts\utility::array_combine(var_0, maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_water_vol"));
          var_0 = common_scripts\utility::get_array_of_farthest(level.player.origin, var_0);
        } else
          var_0 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0);
      } else
        var_0 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0);

      var_2 = [];

      foreach(var_4 in var_0) {
        var_2 = common_scripts\utility::array_add(var_2, var_4);

        if(var_1 <= var_2.size) {
          break;
        }
      }

      if(0 < var_2.size) {
        maps\flood_util::reassign_goal_volume(var_2, "rooftops_encounter_b_flush_vol");
        common_scripts\utility::array_thread(var_2, ::rooftops_encounter_b_waittill_flankers_dead, "rooftop_water_flanker_dead");
        common_scripts\utility::array_thread(var_2, maps\_utility::set_grenadeammo, 1);
        maps\_utility::activate_trigger_with_targetname("rooftops_encounter_b_vo_flank");

        for(var_6 = 0; var_6 < var_2.size; var_6++)
          level waittill("rooftop_water_flanker_dead");
      }
    }

    wait 0.05;
  }
}

rooftops_encounter_b_waittill_flankers_dead(var_0) {
  self waittill("death");
  level notify(var_0);
}

rooftops_encounter_b_handle_defensive() {
  self notify("handle_defensive");
  self endon("handle_defensive");
  thread maps\flood_util::notify_on_flag_open("rooftops_encounter_b_player_defensive", "handle_defensive");

  while(!common_scripts\utility::flag("rooftops_encounter_b_death")) {
    var_0 = maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_water_vol");

    if(4 > var_0.size) {
      var_1 = 2 - var_0.size;
      var_0 = maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_ledge_vol");

      if(var_1 > var_0.size) {
        var_0 = common_scripts\utility::array_combine(var_0, maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_catwalk_vol"));

        if(var_1 > var_0.size) {
          var_0 = common_scripts\utility::array_combine(var_0, maps\flood_util::get_enemies_touching_volume("rooftops_encounter_b_flush_vol"));
          var_0 = common_scripts\utility::get_array_of_farthest(level.player.origin, var_0);
        } else
          var_0 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0);
      } else
        var_0 = common_scripts\utility::get_array_of_closest(level.player.origin, var_0);

      var_2 = [];

      foreach(var_4 in var_0) {
        var_2 = common_scripts\utility::array_add(var_2, var_4);

        if(var_1 <= var_2.size) {
          break;
        }
      }

      if(0 < var_2.size)
        maps\flood_util::reassign_goal_volume(var_2, "rooftops_encounter_b_water_vol");
    }

    wait 5.0;
  }
}

rooftops_water_reveal_logic() {
  self endon("death");
  waittillframeend;
  var_0 = common_scripts\utility::getstruct(self.target, "targetname");
  var_1 = getnode(self.target, "targetname");

  if(isDefined(var_0)) {
    maps\_utility::disable_surprise();
    self waittill("fight");
  } else if(isDefined(var_1)) {
    self.patrol_walk_anim = "active_patrolwalk_gundown";
    thread maps\_patrol::patrol();
    self waittill("enemy");
    self notify("stop_going_to_node");
    level notify("fight");
  }

  switch (self.target) {
    case "gunners_patrol_node":
      maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_b_gunner_vol");
      break;
    case "catwalk_patrol_node":
      maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_b_catwalk_vol");
      break;
    case "ledge_patrol_node":
      maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_b_ledge_vol");
      break;
    case "flare_reveal":
      self.ragdoll_immediate = 0;
      maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_b_catwalk_vol");
      break;
    case "truck_reveal_a":
      var_2 = self.goalradius;
      self.goalradius = 32;
      self setgoalnode(getnode("car_cover", "targetname"));
      self waittill("goal");
      self.goalradius = var_2;
      maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_b_water_vol");
      break;
    case "rando":
      var_2 = self.goalradius;
      self.goalradius = 32;
      self setgoalnode(getnode("water_front", "targetname"));
      self waittill("goal");
      self.goalradius = var_2;
      maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_b_water_vol");
    default:
      maps\flood_util::reassign_goal_volume(self, "rooftops_encounter_b_ledge_vol");
  }
}

rooftops_encounter_b_ally_use_water_correctly() {
  var_0 = common_scripts\utility::array_combine(getEntArray("rooftops_encounter_b", "targetname"), getEntArray("rooftops_encounter_b_cleanup_push", "targetname"));
  var_0 = common_scripts\utility::array_add(var_0, getent("in_sight_of_rooftop_scene", "targetname"));
  common_scripts\utility::array_thread(var_0, ::ally_crouch_walk_to_goal, self);
}

rooftops_encounter_b_force_clear() {
  maps\_utility::wait_for_targetname_trigger("clear_rooftops_encounter_b");

  for(var_0 = 0; var_0 < 3; var_0++) {
    var_1 = getEntArray("rooftops_encounter_b_" + var_0 + "_spawner", "targetname");

    foreach(var_3 in var_1)
    var_3 delete();
  }

  common_scripts\utility::flag_set("rooftops_water_heli_exit");
  var_5 = maps\_utility::get_ai_group_ai("rooftop_scene_actors");

  foreach(var_7 in var_5)
  var_7 kill();

  var_5 = maps\_utility::get_ai_group_ai("rooftops_encounter_b_main");

  foreach(var_7 in var_5)
  var_7 kill();

  var_5 = maps\_utility::get_ai_group_ai("rooftops_encounter_b_backup");

  foreach(var_7 in var_5)
  var_7 kill();

  var_5 = maps\_utility::get_ai_group_ai("turret_gunners");

  foreach(var_7 in var_5)
  var_7 kill();

  common_scripts\utility::flag_set("rooftops_encounter_b_death");
}

rooftops_encounter_b_outro() {
  level.allies[0] allowedstances("stand", "crouch", "prone");
  var_0 = getent("rooftops_encounter_b_vo_2", "targetname");
  var_0 maps\_utility::activate_trigger();
  var_0 common_scripts\utility::delaycall(0.1, ::delete);
  var_1 = getent("rooftops_encounter_b_done", "targetname");

  if(isDefined(var_1))
    var_1 maps\_utility::activate_trigger();
}

rooftops_water_splash() {
  var_0 = getent("coverwater_rooftop_trigger", "targetname");

  while(!level.player istouching(var_0))
    common_scripts\utility::waitframe();

  playFXOnTag(common_scripts\utility::getfx("waterline_under"), level.cw_player_view_fx_source, "tag_origin");
  thread maps\flood_coverwater::create_player_going_underwater_effects();
  wait 0.25;

  if(level.player getstance() != "crouch") {
    playFXOnTag(common_scripts\utility::getfx("waterline_above"), level.cw_player_view_fx_source, "tag_origin");
    wait 0.5;
    thread maps\flood_coverwater::create_player_surfacing_effects();
  }
}

debrisbridge_start() {
  maps\flood_util::player_move_to_checkpoint_start("debrisbridge_start");
  maps\flood_util::spawn_allies();
  level.allies[0] maps\_utility::set_force_color("r");
  level.allies[1] maps\_utility::set_force_color("p");
  level.allies[2] maps\_utility::set_force_color("b");
  level thread rooftop_water_to_debrisbridge_transition();
  common_scripts\utility::flag_set("rooftops_encounter_b_death");
  common_scripts\utility::flag_set("rooftop_water_done");
  maps\_utility::activate_trigger_with_targetname("debrisbridge_color_order_start");
  thread maps\flood_swept::swept_water_toggle("swim", "hide");
  thread maps\flood_swept::swept_water_toggle("debri_bridge", "show");
  level thread maps\flood_util::flood_battlechatter_on();
}

debrisbridge() {
  level thread maps\_utility::autosave_by_name_silent("debrisbridge_start");
  level thread debrisbridge_encounter();
  level thread player_debrisbridge_death_fx();
  level thread debrisbridge_water_rumble();
  thread maps\flood_garage::float_cars();
  level.allies[1] thread maps\flood_fx::debris_bridge_ally_waterfx("debrisbridge_ally_2_ready");
  level.allies[2] thread maps\flood_fx::debris_bridge_ally_waterfx("debrisbridge_ally_1_ready");
  level thread debrisbridge_water_enter_combat_space();
  common_scripts\utility::flag_wait("debrisbridge_done");
  level thread rooftops_cleanup_post_debrisbridge();
}

player_debrisbridge_death_fx() {
  level endon("debrisbridge_done");
  level.player waittill("death");

  if(common_scripts\utility::flag("player_in_debris_water")) {
    setsaveddvar("r_znear", 0.7);
    maps\flood_fx::water_death_fx();
  }
}

debrisbridge_water_enter_combat_space() {
  var_0 = getent("debrisbridge_water_jumpdown_splash", "targetname");
  var_0 thread debrisbridge_water_enter_combat_space_play_effects();
  var_0 thread debrisbridge_water_enter_combat_space_play_effects_ally();
}

debrisbridge_water_enter_combat_space_play_effects() {
  level.player endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level.player) {
      var_0 playrumbleonentity("heavy_2s");
      var_1 = anglesToForward(level.player getplayerangles());
      var_2 = var_0.origin + var_1 * 45;
      var_0 playSound("scn_flood_intowater_splash_plr_ss");
      playFX(level._effect["vfx_splash_medium_02"], var_2);
      break;
    }

    common_scripts\utility::waitframe();
  }
}

debrisbridge_water_enter_combat_space_play_effects_ally() {
  level.allies[0] endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level.allies[0]) {
      var_1 = var_0.origin;
      var_0 playSound("scn_flood_intowater_splash_ss");
      playFX(level._effect["vfx_splash_medium_02"], var_1);
      break;
    }

    common_scripts\utility::waitframe();
  }

  level.allies[0] thread maps\flood_fx::debris_bridge_ally_waterfx("debrisbridge_ally_0_ready");
}

debrisbridge_encounter() {
  level.player thread debrisbridge_no_prone();
  thread debrisbridge_ally_vo();
  thread debrisbridge_path_logic();
  thread debrisbridge_clear_enemies_bottom();
  thread debrisbridge_clear_enemies_top();
  thread debrisbridge_cleanup();
  maps\_utility::wait_for_targetname_trigger("debrisbridge_encounter_1_trigger");
  level thread rooftops_cleanup_post_debrisbridge_dropdown();
  level.allies[1] maps\_utility::set_force_color("y");
  level.allies[2] maps\_utility::set_force_color("b");
  level.allies[0] maps\_utility::set_grenadeammo(0);
  level.allies[1] maps\_utility::set_grenadeammo(0);
  level.allies[2] maps\_utility::set_grenadeammo(0);
  thread debrisbridge_enemy_spawn_logic();
  maps\flood_util::cleanup_triggers("rooftops_encounter_b_cleanup_late");
  common_scripts\utility::flag_wait("debrisbridge_encounter_death");
  maps\flood_util::cleanup_triggers("debrisbridge_encounter");
  common_scripts\utility::flag_wait("debrisbridge_soft_ready");
  maps\_utility::autosave_by_name("debrisbridge_done");
}

debrisbridge_ally_vo() {
  maps\flood_util::jkuprint("in cqb");
  level.allies[0] maps\_utility::enable_cqbwalk();
  level.allies[1] maps\_utility::enable_cqbwalk();
  level.allies[2] maps\_utility::enable_cqbwalk();
  maps\_utility::wait_for_targetname_trigger("debrisbridge_encounter_vo_0");
  maps\_utility::battlechatter_off("allies");
  level.allies[1] maps\_utility::smart_dialogue("flood_vrg_gladtoseeyou");
  wait 0.75;
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_vargasstartlayingdown");
  level.allies[1] maps\_utility::smart_dialogue("flood_pri_garciawasspottedheading");
  maps\_utility::battlechatter_on("allies");
  wait 2;
  level notify("get_killed");
  common_scripts\utility::waitframe();
  level notify("kill_shot");

  for(var_0 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_bottom"); var_0.size > 4; var_0 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_bottom"))
    common_scripts\utility::waitframe();

  common_scripts\utility::flag_wait("debrisbridge_soft_ready");
  maps\_utility::battlechatter_off("allies");
  level.allies[0] maps\_utility::smart_dialogue("flood_vrg_sowhatthehell");
  level.allies[1] maps\_utility::smart_dialogue("flood_pri_weneedtofind");
  debris_bridge_allies_loop();
  common_scripts\utility::flag_wait("debrisbridge_vo_1");
  wait 15.0;
  var_1 = maps\_utility::make_array("flood_diz_getacrossnow", "flood_vrg_eliascmongetover", "flood_pri_wedontknowhow");
  level.allies[2] thread maps\flood_util::play_nag(var_1, "debrisbridge_done", 15, 30, 1, 2, "flag_set");
  common_scripts\utility::flag_wait("debrisbridge_done");
  level.allies[2] notify("flag_set");
}

debris_bridge_allies_loop() {
  var_0 = common_scripts\utility::getstruct("vignette_debris_bridge_node", "script_noteworthy");
  var_1 = [];
  var_1[var_1.size] = getnode("debrisbridge_kill_shot_0", "targetname");
  var_1[var_1.size] = getnode("debrisbridge_kill_shot_1", "targetname");
  var_1[var_1.size] = getnode("debrisbridge_kill_shot_2b", "targetname");
  level.allies[0] thread debris_bridge_reach_and_loop(var_0, 0);
  level.allies[0].debrisbridge_loc = 0;
  level.allies[1] thread debris_bridge_reach_and_loop(var_0, 2);
  level.allies[1].debrisbridge_loc = 2;
  level.allies[2] thread debris_bridge_reach_and_loop(var_0, 1);
  level.allies[2].debrisbridge_loc = 1;
}

debris_bridge_reach_and_loop(var_0, var_1) {
  maps\_vignette_util::vignette_actor_ignore_everything();
  level.db_faux_enemy = getent("debrisbridge_faux_enemy", "targetname");

  if(var_1 == 0) {
    level.allies[0] thread maps\_utility::smart_dialogue("flood_vrg_merrickeliasfollowmy");
    level maps\_utility::delaythread(3, maps\_utility::battlechatter_on, "allies");
  }

  self pushplayer(1);
  self.og_facedist = self.maxfaceenemydist;
  self.maxfaceenemydist = 2048;
  self.ignoreall = 0;

  if(!isDefined(self.enemy)) {
    maps\flood_util::jkuprint(self.animname + " no enemy!!!");
    level.db_faux_enemy makeentitysentient("axis");
    self.favoriteenemy = level.db_faux_enemy;
  }

  var_0 maps\_anim::anim_reach_solo(self, "debrisbridge_loop" + var_1);
  self.fixednode = 1;
  self setgoalpos(self.origin);
  self pushplayer(0);
  self.favoriteenemy = undefined;
  maps\flood_util::jkuprint(self.animname + " anim reach finished " + gettime());

  for(var_2 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_bottom"); var_2.size > 0; var_2 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_bottom"))
    common_scripts\utility::waitframe();

  common_scripts\utility::flag_set("debrisbridge_ally_" + var_1 + "_ready");
}

debrisbridge_enemy_spawn_logic() {
  thread debrisbridge_enemy_spawn_group_logic("debrisbridge_enemies_top", 3, 13.0, "top");
  thread debrisbridge_enemy_spawn_group_logic("debrisbridge_enemies_bottom", 2, 9, "bottom");
}

debrisbridge_enemy_spawn_group_logic(var_0, var_1, var_2, var_3) {
  maps\flood_util::waittill_aigroup_count_or_timeout(var_0, var_1, var_2);
  var_4 = getEntArray("debrisbridge_encounter_1_" + var_3 + "_spawner", "targetname");
  common_scripts\utility::array_thread(var_4, maps\_utility::add_spawn_function, maps\_utility::disable_long_death);
  common_scripts\utility::array_thread(var_4, maps\_utility::add_spawn_function, maps\_utility::set_grenadeammo, 0);
  common_scripts\utility::array_thread(var_4, maps\_utility::add_spawn_function, ::debrisbridge_enemy_aggrisive_logic);
  common_scripts\utility::array_thread(var_4, maps\_utility::spawn_ai, 1);

  if("bottom" == var_3) {
    var_5 = getent("debrisbridge_special", "targetname");
    var_5 maps\_utility::add_spawn_function(maps\_utility::disable_long_death);
    var_5 maps\_utility::add_spawn_function(maps\_utility::set_grenadeammo, 0);
    var_5 maps\_utility::add_spawn_function(::debrisbridge_enemy_aggrisive_logic);
    var_6 = var_5 maps\_utility::spawn_ai(1);
    var_6 common_scripts\utility::delaycall(9.0, ::kill);
  }
}

debrisbridge_enemy_aggrisive_logic() {
  self endon("death");
  common_scripts\utility::flag_wait("debrisbridge_LOS_blocked");
  self.aggressivemode = 1;
  self.health = 1;
  self.ignoresuppression = 1;
  self.suppressionwait = 0;
  var_0 = getent("debrisbridge_aggresive_vol", "targetname");
  var_1 = getent("debrisbridge_enemy_aggresive", "targetname");

  if(self istouching(var_1))
    self setgoalvolumeauto(var_0);
}

debrisbridge_enemy_logic() {
  maps\_utility::magic_bullet_shield();

  if("debrisbridge_enemies_top" == self.script_aigroup)
    maps\_utility::wait_for_targetname_trigger("debrisbridge_encounter_1_trigger");
  else if("debrisbridge_enemies_bottom" == self.script_aigroup)
    maps\_utility::wait_for_targetname_trigger("debrisbridge_allow_defensive_advantage");

  maps\_utility::stop_magic_bullet_shield();
}

debrisbridge_path_logic() {
  common_scripts\utility::flag_wait("debrisbridge_ready");
  var_0 = getent("debrisbridge_stop_blocking", "targetname");

  if(isDefined(var_0)) {
    var_0 maps\_utility::activate_trigger();
    var_0 delete();
  }
}

debrisbridge_prevent_frogger(var_0) {
  level endon("debrisbridge_ready");
  thread debrisbridge_move_trigger(var_0);

  while(!common_scripts\utility::flag("debrisbridge_ready")) {
    self waittill("trigger", var_1);

    if(var_1 == level.player)
      var_1 thread debrisbridge_slide_player(self);
  }
}

debrisbridge_move_trigger(var_0) {
  level endon("debrisbridge_ready");

  for(;;) {
    self.origin = var_0.origin;
    self.angles = var_0.angles;
    wait 0.05;
  }
}

debrisbridge_slide_player(var_0) {
  if(maps\_utility::issliding() || isDefined(self.player_view)) {
    return;
  }
  self endon("death");
  var_1 = undefined;

  if(isDefined(var_0.script_accel))
    var_1 = var_0.script_accel;

  maps\_utility::beginsliding(undefined, var_1);

  while(self istouching(var_0))
    wait 0.05;

  if(isDefined(level.end_slide_delay))
    wait(level.end_slide_delay);

  maps\_utility::endsliding();
}

debrisbridge_no_prone() {
  self endon("death");
  maps\_utility::wait_for_targetname_trigger("debrisbridge_encounter_1_trigger");

  if(self getstance() == "prone")
    self setstance("crouch");

  self allowprone(0);
  common_scripts\utility::flag_wait("debrisbridge_done");
  self allowprone(1);
}

debrisbridge_clear_enemies_bottom() {
  level waittill("get_killed");
  var_0 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_bottom");

  foreach(var_2 in var_0)
  var_2 thread debrisbridge_setup_enemies_for_clearance();

  level waittill("kill_shot");
  level.allies[2] thread debrisbridge_setup_ally_for_kill_shot(2);
}

debrisbridge_setup_enemies_for_clearance() {
  self endon("death");
  self.ignoresuppression = 1;
  wait 2.0;
  self.suppressionwait = 0;
  self.attackeraccuracy = 10000;
}

debrisbridge_setup_ally_for_kill_shot(var_0) {
  self setgoalnode(getnode("debrisbridge_kill_shot_" + var_0, "targetname"));

  if(!common_scripts\utility::flag("debrisbridge_encounter_death")) {
    maps\flood_util::jkuprint(self.animname + " kill mode on " + gettime());
    var_1 = self.suppressionwait;
    self.ignoreme = 1;
    self.suppressionwait = 0;
    self.ignoresuppression = 1;
    self.disableplayeradsloscheck = 1;
    self.disablefriendlyfirereaction = 1;
    maps\_utility::disable_ai_color();
    common_scripts\utility::flag_wait("debrisbridge_encounter_death");
    maps\flood_util::jkuprint(self.animname + " kill mode off " + gettime());
    self.ignoreme = 0;
    self.suppressionwait = var_1;
    self.ignoresuppression = 0;
    self.disableplayeradsloscheck = 0;
    self.disablefriendlyfirereaction = undefined;
  }
}

debrisbridge_clear_enemies_top() {
  maps\_utility::wait_for_targetname_trigger("debrisbridge_encounter_vo_0");
  var_0 = [26.0, 26.6, 13.0, 17.6, 36.0];

  for(var_1 = 0; var_1 < 5; var_1++) {
    var_2 = getent("debris_bridge_car_" + var_1, "targetname");
    level maps\_utility::delaythread(var_0[var_1], ::debrisbridge_kill_enemies_top, var_1, var_2);
  }
}

#using_animtree("destructibles");

debrisbridge_kill_enemies_top(var_0, var_1) {
  var_2 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_top");

  if(0 < var_2.size) {
    if(issubstr(var_1.model, "destroy")) {
      playFXOnTag(level._effect["secondary_explosion"], var_1, "tag_death_fx");
      var_1 playSound("car_explode");

      if(isDefined(var_1.animsapplied)) {
        foreach(var_4 in var_1.animsapplied)
        var_1 clearanim(var_4, 0);
      }

      var_1 useanimtree(#animtree);
      var_1 setanimknobrestart(%vehicle_80s_sedan1_destroy, 1.0, 0.1, 1);
    } else
      var_1 setscriptablepartstate(0, 5, 0);
  }

  if(1 == var_0) {
    wait 0.2;

    foreach(var_7 in var_2)
    var_7 kill(var_1.origin, level.player);
  }
}

debrisbridge_cleanup() {
  common_scripts\utility::flag_wait("debrisbridge_done");

  foreach(var_1 in level.allies)
  var_1 maps\_utility::set_grenadeammo(3);

  var_3 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_bottom");

  foreach(var_5 in var_3)
  var_5 kill();

  var_3 = maps\_utility::get_ai_group_ai("debrisbridge_enemies_top");

  foreach(var_5 in var_3)
  var_5 kill();
}

debrisbridge_hide_glass_parts(var_0) {
  foreach(var_2 in var_0) {
    switch (var_2.model) {
      case "vehicle_civilian_sedan_white_iw6":
      case "vehicle_civilian_sedan_black_iw6":
      case "vehicle_civilian_sedan_blue_iw6":
      case "vehicle_civilian_sedan_bronze_iw6":
        var_2 hidepart("TAG_LIGHT_RIGHT_FRONT_D", var_2.model);
        var_2 hidepart("TAG_LIGHT_LEFT_FRONT_D", var_2.model);
        var_2 hidepart("TAG_GLASS_FRONT_D", var_2.model);
        var_2 hidepart("TAG_GLASS_BACK_D", var_2.model);
        var_2 hidepart("TAG_GLASS_RIGHT_FRONT_D", var_2.model);
        var_2 hidepart("TAG_GLASS_RIGHT_BACK_D", var_2.model);
        var_2 hidepart("TAG_GLASS_LEFT_FRONT_D", var_2.model);
        var_2 hidepart("TAG_GLASS_LEFT_BACK_D", var_2.model);
        break;
      case "vehicle_civilian_van_red_iw6":
      case "vehicle_civilian_van_white_iw6":
      case "vehicle_civilian_van_blue_iw6":
        var_2 hidepart("TAG_GLASS_BACK_D", var_2.model);
        var_2 hidepart("TAG_GLASS_FRONT_D", var_2.model);
        var_2 hidepart("TAG_GLASS_LEFT_BACK_02_D", var_2.model);
        var_2 hidepart("TAG_GLASS_LEFT_FRONT_D", var_2.model);
        var_2 hidepart("TAG_GLASS_LEFT_MID_D", var_2.model);
        var_2 hidepart("TAG_GLASS_RIGHT_FRONT_D", var_2.model);
        var_2 hidepart("TAG_GLASS_RIGHT_MID_D", var_2.model);
        var_2 hidepart("tag_glass_right_back_02_D", var_2.model);
        break;
    }
  }
}

debrisbridge_wall_break_logic() {
  wait 24.0;
  var_0 = getnode("debrisbridge_wall_node_0", "targetname");

  foreach(var_2 in level.allies) {
    if(32 > distance(var_0.origin, var_2.origin)) {
      var_2 maps\_utility::disable_ai_color();
      var_2 setgoalnode(getnode("debrisbridge_wall_node_1", "targetname"));
      break;
    }
  }

  level.allies[1] thread debrisbridge_setup_ally_for_kill_shot(1);
  wait 2.0;
  common_scripts\utility::flag_set("debrisbridge_LOS_blocked");
}

debrisbridge_crossing() {
  var_0 = maps\_utility::getdifficulty();

  if(!common_scripts\utility::flag("debrisbridge_done")) {
    if("fu" == var_0)
      maps\_utility::set_player_attacker_accuracy(0.5);

    if("hard" == var_0)
      maps\_utility::set_player_attacker_accuracy(0.25);
  }

  wait 1.15;
  var_1 = getent("debrisbridge_fodder_0", "targetname");

  if(isDefined(var_1)) {
    var_1 maps\_utility::add_spawn_function(maps\_utility::disable_long_death);
    var_1 maps\_utility::add_spawn_function(maps\_utility::set_grenadeammo, 0);
    level.debrisbridge_fodder = var_1 maps\_utility::spawn_ai(1);
  }

  if("fu" == var_0 || "hard" == var_0) {
    wait 1.6;
    var_1 = getent("debrisbridge_fodder_1", "targetname");

    if(isDefined(var_1)) {
      var_1 maps\_utility::add_spawn_function(maps\_utility::disable_long_death);
      var_1 maps\_utility::add_spawn_function(maps\_utility::set_grenadeammo, 0);
      level.debrisbridge_fodder_extra = var_1 maps\_utility::spawn_ai(1);
    }
  }

  common_scripts\utility::flag_wait("debrisbridge_done");
  maps\_gameskill::updatealldifficulty();
}

debrisbridge_combat_crossing(var_0) {
  if(!isDefined(level.debrisbridge_fodder)) {
    return;
  }
  if(!isDefined(level.debrisbridge_shot_count))
    level.debrisbridge_shot_count = 0;
  else
    level.debrisbridge_shot_count++;

  if(isalive(level.debrisbridge_fodder)) {
    var_1 = undefined;

    if(2 > level.debrisbridge_shot_count) {
      var_2 = maps\_utility::make_array("TAG_WEAPON_RIGHT", "TAG_WEAPON_LEFT", "TAG_REFLECTOR_ARM_RI", "TAG_REFLECTOR_ARM_LE", "TAG_WEAPON_CHEST");
      var_1 = level.debrisbridge_fodder gettagorigin(var_2[randomint(var_2.size)]);
    } else
      var_1 = level.debrisbridge_fodder getEye();

    switch (maps\_utility::getdifficulty()) {
      case "hard":
      case "medium":
      case "easy":
        magicbullet("r5rgp", var_0 gettagorigin("tag_flash"), var_1);
        break;
      case "fu":
        if(1 > level.debrisbridge_shot_count)
          magicbullet("r5rgp", var_0 gettagorigin("tag_flash"), var_1);
        else
          magicbullet("r5rgp", var_0 gettagorigin("tag_flash"), var_1 + (0, 0, 32));

        break;
    }

    var_0 shoot(0.0, var_1);
  }
}

debrisbridge_water_rumble() {
  var_0 = getEntArray("debrisbridge_water_ent", "targetname");

  foreach(var_2 in var_0)
  var_2 playrumblelooponentity("steady_rumble");
}

skybridge_to_rooftops_transition() {
  level thread rooftops_encounters_logic();
  thread rooftops_heli_logic();
  maps\_utility::wait_for_targetname_trigger("rooftops_color_order_start");
  var_0 = getEntArray("rooftops_encounter_a_0_spawner", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::rooftops_encounter_a_enemy_logic);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::rooftop_enemy_runner_logic);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\_utility::disable_long_death);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\_utility::set_grenadeammo, 0);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    level.rooftops_runner[var_1] = var_0[var_1] maps\_utility::spawn_ai();

  thread maps\_utility::battlechatter_off("axis");
  thread rooftops_encounter_a_runners_vo();
  var_2 = level.player getweaponslist("primary");

  if(1 != var_2.size || "flood_knife" != var_2[0]) {
    var_2 = getEntArray("derp_award", "targetname");

    foreach(var_4 in var_2)
    var_4 delete();
  }
}

suspend_actor_turnanims() {
  self endon("death");
  maps\_utility::trigger_wait_targetname("rooftops_water_turn_hack_start");
  self.noturnanims = 1;
  maps\_utility::trigger_wait_targetname("rooftops_water_turn_hack_stop");
  self.noturnanims = undefined;
}

rooftops_heli_logic() {
  var_0 = getent("rooftops_encounter_heli", "targetname");
  common_scripts\utility::flag_wait("skybridge_heli_go");
  level.rooftop_heli = maps\_vehicle::vehicle_spawn(var_0);
  level.rooftop_heli maps\_vehicle::godon();
  level.rooftop_heli thread maps\_vehicle::gopath();
  level.rooftop_heli thread maps\flood_audio::sfx_stealth_heli_flyby();
  level.rooftop_heli hidepart("door_L", level.rooftop_heli.model);
  level.rooftop_heli hidepart("door_L_handle", level.rooftop_heli.model);
  level.rooftop_heli hidepart("door_L_lock", level.rooftop_heli.model);
  common_scripts\utility::flag_set("rooftops_heli_spawned");
  thread maps\flood_audio::rooftops_mix_heli_down();
}

ally_crouch_walk_to_goal(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger");
    var_0 thread actor_use_water_when_moving();

    while(self istouching(level.player))
      wait 0.1;
  }
}

actor_use_water_when_moving() {
  self notify("using_water");
  self endon("using_water");
  level.rooftop_ally_temp = self.goalradius;
  self.goalradius = 32;
  self allowedstances("crouch");
  self.ignoresuppression = 1;
  self waittill("goal");
  self.goalradius = level.rooftop_ally_temp;
  self allowedstances("stand", "crouch", "prone");
  self.ignoresuppression = 0;
}

rooftops_enemy_combat_logic() {
  self endon("death");
  maps\_utility::magic_bullet_shield();
  common_scripts\utility::flag_wait("rooftops_exterior_in_combat_space");
  maps\_utility::stop_magic_bullet_shield();
}

rooftops_enemy_aggresive_logic() {
  self endon("death");
  thread maps\flood_util::notify_on_enemy_count(1, "last_man_standing");
  self waittill("last_man_standing");
  self notify("stop_goal_volume_updates");
  self.aggressivemode = 1;
  self.health = 1;
  self cleargoalvolume();

  if(common_scripts\utility::flag("rooftop_water_done")) {
    self.goalradius = 16;
    var_0 = undefined;

    if(0 < maps\_utility::get_ai_group_count("debrisbridge_enemies_top"))
      var_0 = getnode("debrisbridge_get_killed_node", "targetname");
    else if(0 < maps\_utility::get_ai_group_count("debrisbridge_enemies_bottom"))
      var_0 = getnode("debrisbridge_get_killed_node_bottom", "targetname");

    var_0.radius = 32;
    self setgoalnode(var_0);
  } else {
    self.goalradius = 16;
    var_0 = getnode("rooftops_encounter_a_final_stand", "targetname");
    var_0.radius = 32;
    self setgoalnode(var_0);
    self.ignoresuppression = 1;
    self.suppressionwait = 0;
  }
}

rooftop_water_to_debrisbridge_transition() {
  common_scripts\utility::flag_wait_any("rooftops_encounter_b_death", "rooftop_water_done");
  maps\_utility::battlechatter_on("axis");
  maps\_utility::battlechatter_on("allies");
  var_0 = getEntArray("debrisbridge_encounter_0_top_spawner", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("debrisbridge_encounter_0_bottom_spawner", "targetname"));
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\_utility::disable_long_death);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::debrisbridge_enemy_aggrisive_logic);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\_utility::set_grenadeammo, 0);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::debrisbridge_enemy_logic);
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai, 1);
  var_1 = common_scripts\utility::getstruct("debrisbridge_ally_1", "targetname");
  level.allies[1] teleport(var_1.origin, var_1.angles);
  level.allies[1] maps\_utility::enable_ai_color();
  level.allies[1] maps\_utility::set_force_color("p");
  level.allies[1].goalradius = 96;
  level.allies[1] maps\_utility::gun_recall();
  var_1 = common_scripts\utility::getstruct("debrisbridge_ally_2", "targetname");
  level.allies[2] teleport(var_1.origin, var_1.angles);
  level.allies[2] maps\_utility::enable_ai_color();
  level.allies[2] maps\_utility::set_force_color("b");
  level.allies[2].goalradius = 96;
  level.allies[2] maps\_utility::gun_recall();
  maps\_utility::activate_trigger_with_targetname("debrisbridge_new_allies");
  level.allies[0] thread ally_rooftop_water_to_debrisbridge();
}

ally_rooftop_water_to_debrisbridge() {
  var_0 = getent("debrisbridge_ally_logic_0_trigger", "targetname");
  var_1 = self.suppressionwait;
  self.ignoreall = 1;
  self.ignoresuppression = 1;
  self.suppressionwait = 0;
  self.disableplayeradsloscheck = 1;
  self.disablefriendlyfirereaction = 1;

  while(!self istouching(var_0))
    wait 1.0;

  self.ignoreall = 0;
  self.ignoresuppression = 0;
  self.suppressionwait = var_1;
  self.disableplayeradsloscheck = 0;
  self.disablefriendlyfirereaction = undefined;
}

temp_debrisbridge_remove_base_clip() {}

rooftops_to_rooftops_water_transition() {
  common_scripts\utility::flag_wait("rooftops_player_dropped_down");
  level thread rooftops_water_enter_combat_space();
}

rooftops_shoot_around_actor(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 0.1;

  if(!isDefined(var_2))
    var_2 = 0;

  for(var_3 = 0.1; 0.0 < var_1; var_1 = var_1 - var_3) {
    if(!isalive(var_0)) {
      break;
    }

    if(0 >= var_1 - var_3 && var_2) {
      magicbullet("pp19", self gettagorigin("TAG_FLASH"), var_0 getEye());
      self shoot();

      if(isalive(var_0))
        var_0 kill();
    } else {
      var_4 = var_0 getEye();
      var_5 = vectornormalize(var_4 - self gettagorigin("TAG_FLASH"));
      var_6 = anglestoright(vectortoangles(var_5));
      var_7 = 1;

      if(randomint(2))
        var_7 = -1;

      var_8 = var_7 * var_6 * randomintrange(20, 32);
      var_9 = (0, 0, randomint(14));
      magicbullet("pp19", self gettagorigin("TAG_FLASH"), var_4 + var_8 + var_9);
      self shoot();
    }

    wait 0.1;
  }
}

rooftops_cleanup_jumpto() {
  waittillframeend;
  var_0 = getent("skybridge_start", "targetname");
  var_0 delete();
  var_0 = getent("rooftops_start", "targetname");
  var_0 delete();
  var_0 = getent("rooftop_water_start", "targetname");
  var_0 delete();
  var_0 = getent("debrisbridge_start", "targetname");
  var_0 delete();
  var_0 = getent("ending_start", "targetname");
  var_0 delete();
}

rooftops_cleanup_post_skybridge() {
  waittillframeend;
  var_0 = getent("rooftops_encounter_heli", "targetname");
  var_0 delete();
  var_1 = getent("ally_in_front_vol", "targetname");
  var_1 delete();
  var_2 = getEntArray("skybridge_noprone", "targetname");

  foreach(var_4 in var_2)
  var_4 delete();
}

rooftops_cleanup_post_wallkick() {
  var_0 = getEntArray("derp_award", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  for(var_4 = 0; var_4 < 2; var_4++) {
    var_0 = getEntArray("rooftops_weapon_upgrade_" + var_4, "targetname");

    foreach(var_2 in var_0)
    var_2 delete();
  }

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_7 = getEntArray("rooftops_encounter_a_" + var_4 + "_spawner", "targetname");

    foreach(var_9 in var_7)
    var_9 delete();
  }

  var_11 = getent("rooftop_runners_vol", "targetname");
  var_11 delete();
  var_11 = getent("rooftops_encounter_a_intro_vol", "targetname");
  var_11 delete();
  var_11 = getent("rooftops_encounter_a_flank_left_vol", "targetname");
  var_11 delete();
  var_11 = getent("rooftops_encounter_a_flank_right_vol", "targetname");
  var_11 delete();
  var_12 = getEntArray("rooftops_misc_triggers", "script_noteworthy");

  foreach(var_14 in var_12)
  var_14 delete();

  var_16 = getEntArray("rooftops_misc_flags", "targetname");

  foreach(var_18 in var_16)
  var_18 delete();

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_20 = getent("skybridge_clip_" + var_4, "targetname");
    var_20 delete();

    if(isDefined(level.skybridge_sections) && isDefined(level.skybridge_sections[var_4])) {
      level.skybridge_sections[var_4] delete();
      level.skybridge_origins[var_4] delete();
    }
  }

  var_20 = getent("skybridge_doorbreach_clip", "targetname");
  var_20 delete();

  if(isDefined(level.skybridge_door))
    level.skybridge_door delete();
}

rooftops_cleanup_post_walkway() {
  if(isDefined(level.rooftop_outro_props)) {
    foreach(var_1 in level.rooftop_outro_props)
    var_1 delete();
  }
}

rooftops_cleanup_post_debrisbridge_dropdown() {
  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = getEntArray("rooftops_encounter_b_" + var_0 + "_spawner", "targetname");

    foreach(var_3 in var_1) {
      if(isDefined(var_3))
        var_3 delete();
    }
  }

  var_5 = getent("rooftops_encounter_b_water_vol", "targetname");
  var_5 delete();
  var_5 = getent("rooftops_encounter_b_flush_vol", "targetname");
  var_5 delete();
  var_5 = getent("rooftops_encounter_b_catwalk_vol", "targetname");
  var_5 delete();
  var_5 = getent("rooftops_encounter_b_ledge_vol", "targetname");
  var_5 delete();
  var_5 = getent("rooftops_encounter_b_gunner_vol", "targetname");
  var_5 delete();
  var_5 = getent("rooftops_encounter_b_safe_vol", "targetname");
  var_5 delete();
  var_6 = getEntArray("rooftops_water_misc_triggers", "script_noteworthy");

  foreach(var_8 in var_6)
  var_8 delete();

  var_10 = getEntArray("rooftops_water_heli_zone_flags", "targetname");

  foreach(var_12 in var_10)
  var_12 delete();

  var_10 = getEntArray("rooftops_water_player_zone_flags", "targetname");

  foreach(var_12 in var_10)
  var_12 delete();
}

rooftops_cleanup_post_debrisbridge() {
  if(isDefined(level.debrisbridge_fodder))
    level.debrisbridge_fodder delete();

  if(isDefined(level.debrisbridge_fodder_extra))
    level.debrisbridge_fodder_extra delete();

  var_0 = getEntArray("debrisbridge_weapons", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  for(var_4 = 0; var_4 < 2; var_4++) {
    var_5 = getEntArray("debrisbridge_encounter_" + var_4 + "_bottom_spawner", "targetname");

    foreach(var_7 in var_5)
    var_7 delete();

    var_5 = getEntArray("debrisbridge_encounter_" + var_4 + "_top_spawner", "targetname");

    foreach(var_7 in var_5)
    var_7 delete();
  }

  var_7 = getent("debrisbridge_fodder_0", "targetname");
  var_7 delete();
  var_7 = getent("debrisbridge_fodder_1", "targetname");
  var_7 delete();
  var_11 = getent("debrisbridge_encounter_vol", "targetname");
  var_11 delete();
  var_11 = getent("debrisbridge_encounter_bottom_vol", "targetname");
  var_11 delete();
  var_11 = getent("debrisbridge_crossing_vol", "targetname");
  var_11 delete();
  var_11 = getent("debrisbridge_aggresive_vol", "targetname");
  var_11 delete();
  var_12 = getent("debrisbridge_enemy_aggresive", "targetname");
  var_12 delete();
  var_12 = getent("debrisbridge_noprone", "targetname");
  var_12 delete();
  var_13 = getEntArray("debrisbridge_misc_triggers", "script_noteworthy");

  foreach(var_12 in var_13)
  var_12 delete();

  var_16 = getent("debrisbridge_prop_14", "targetname");
  var_16 delete();
  var_16 = getent("debrisbridge_prop_15", "targetname");
  var_16 delete();
  var_16 = getent("debrisbridge_clip_all", "targetname");
  var_16 delete();

  if(isDefined(level.debrisbridge_origins)) {
    foreach(var_18 in level.debrisbridge_origins)
    var_18 delete();
  }
}

flag_wait_any_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("flag_wait_any_or_timeout");
  level thread maps\_utility::notify_delay("flag_wait_any_or_timeout", var_0);
  common_scripts\utility::flag_wait_any(var_1, var_2, var_3, var_4, var_5);
}

rooftops_player_spotted_vo(var_0) {
  self endon("death");
  self.animname = "generic";
  maps\flood_util::waittill_danger_or_trigger(var_0);
  var_1 = maps\_utility::make_array("flood_vz12_getguns", "flood_vz2_americans", "flood_vz11_enemies");
  maps\_utility::smart_dialogue(var_1[randomint(var_1.size)]);
}

trigger_vo_in_combat(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  maps\_utility::activate_trigger_with_targetname(var_0);
}

skybridge_ally_vo() {
  common_scripts\utility::flag_wait("skybridge_heli_go");
  wait 0.8;
  maps\_utility::smart_dialogue("flood_vrg_justlikeoldtimes");
  common_scripts\utility::flag_wait("skybridge_vo_0");
  maps\_utility::smart_dialogue("flood_vrg_thecitysfallinapart");
  common_scripts\utility::flag_wait("skybridge_vo_1");

  if(!common_scripts\utility::flag("on_skybridge"))
    maps\_utility::smart_dialogue("flood_diz_onlywaytogo");

  if(!common_scripts\utility::flag("on_skybridge"))
    thread maps\_utility::smart_dialogue("flood_vrg_wegottagetacross");

  common_scripts\utility::flag_wait_any("skybridge_vo_2", "skybridge_vo_3");

  if(!common_scripts\utility::flag("skybridge_vo_3")) {
    thread maps\_utility::smart_dialogue("flood_diz_rightforus");
    common_scripts\utility::flag_wait_or_timeout("skybridge_vo_3", 8.0);
    var_0 = maps\_utility::make_array("flood_diz_keepmoving2", "flood_diz_rightforus", "flood_diz_hurry");
    thread maps\flood_util::play_nag(var_0, "on_skybridge", 8, 30, 1, 1.5, "on_skybridge");
    common_scripts\utility::flag_wait("on_skybridge");
    self notify("on_skybridge");
  }

  common_scripts\utility::flag_wait("skybridge_vo_3");
  thread maps\_utility::smart_dialogue("flood_diz_barelyholding");
}

rooftops_encounter_a_ally_vo() {
  waittillframeend;
  thread rooftops_encounter_a_ally_vo_holdup();
  maps\_utility::battlechatter_off("allies");
  maps\_utility::wait_for_targetname_trigger("rooftops_encounter_a_setup");
  thread rooftops_encounter_a_ally_vo_runners();
  maps\_utility::wait_for_targetname_trigger("rooftops_encounter_a_vo_1");
  wait 0.5;
  common_scripts\utility::flag_wait("rooftops_exterior_ally_in_combat_space");
  maps\_utility::smart_dialogue("flood_diz_itshostile");
  maps\_utility::battlechatter_on("allies");
  common_scripts\utility::flag_wait_all("rooftops_encounter_a_death", "rooftop_runners_death");
  maps\_utility::battlechatter_off("axis");
  wait 1.4;
  maps\_utility::smart_dialogue("flood_diz_getsomebearings");
  maps\_utility::wait_for_targetname_trigger("rooftops_exterior_ally_vo_0");
  level thread maps\_utility::radio_dialogue_queue("flood_pri_thisghostzerooneif");
  wait 3.9;
  thread maps\_utility::smart_dialogue("flood_vrg_thisisghostzerotwo");
  wait 1.6;
  level thread maps\_utility::radio_dialogue_queue("flood_pri_vargaswereunderheavy");
  wait 2.7;
  common_scripts\utility::flag_set("rooftops_vo_kick_wall");
  wait 2.0;
  thread maps\_utility::smart_dialogue("flood_vrg_ineedtoknow");
  wait 3.0;
  common_scripts\utility::flag_set("rooftops_vo_check_drop");
  wait 0.5;
  maps\_utility::smart_dialogue("flood_diz_gethimselfkilled");
  flag_wait_any_or_timeout(10.0, "player_in_sight_of_ally", "rooftops_player_dropped_down", "rooftops_player_pushing");

  if(!common_scripts\utility::flag("player_in_sight_of_ally") && !common_scripts\utility::flag("rooftops_player_dropped_down") && !common_scripts\utility::flag("rooftops_player_pushing")) {
    var_0 = maps\_utility::make_array("flood_diz_keepmoving3", "flood_diz_gethimselfkilled");
    level.allies[0] thread maps\flood_util::play_nag(var_0, "player_drop_progress", 8, 30, 1, 1.5, "flag_set");
    common_scripts\utility::flag_wait_any("player_in_sight_of_ally", "rooftops_player_dropped_down", "rooftops_player_pushing");
    common_scripts\utility::flag_set("player_drop_progress");
    self notify("flag_set");
  }

  common_scripts\utility::flag_clear("player_drop_progress");
  common_scripts\utility::flag_wait_or_timeout("rooftops_vo_push_forward_hassle", 8.0);

  if(!common_scripts\utility::flag("rooftops_vo_push_forward_hassle")) {
    var_0 = maps\_utility::make_array("flood_diz_dropdown", "flood_vrg_wecantstopnow", "flood_vrg_eliaspickupthe");
    level.allies[0] thread maps\flood_util::play_nag(var_0, "rooftops_vo_push_forward_hassle", 15, 30, 1, 2, "flag_set");
    common_scripts\utility::flag_wait("rooftops_vo_push_forward_hassle");
    self notify("flag_set");
  }

  common_scripts\utility::flag_clear("rooftops_vo_push_forward_hassle");
  common_scripts\utility::flag_wait("rooftops_player_dropped_down");
  maps\_utility::smart_dialogue("flood_vrg_welliguesswere");
  common_scripts\utility::flag_wait("rooftops_vo_landing");
  wait 0.5;
  maps\_utility::smart_dialogue("flood_vrg_onceweregroupwith");
  common_scripts\utility::flag_wait_or_timeout("rooftops_vo_push_forward_nag1", 5.0);

  if(!common_scripts\utility::flag("rooftops_vo_push_forward_nag1")) {
    var_0 = maps\_utility::make_array("flood_diz_jumpthegap", "flood_vrg_cmonkeepup", "flood_vrg_cmonjump");
    level.allies[0] thread maps\flood_util::play_nag(var_0, "rooftops_vo_push_forward_nag1", 15, 30, 1, 2, "flag_set");
    common_scripts\utility::flag_wait("rooftops_vo_push_forward_nag1");
    self notify("flag_set");
  }

  common_scripts\utility::flag_clear("rooftops_vo_push_forward_nag1");
}

rooftops_encounter_a_ally_vo_holdup() {
  self endon("spotted");
  var_0 = getent("ally_handsignal", "targetname");
  var_0 waittill("trigger", var_1);

  if(var_1 == self)
    thread maps\flood_anim::rooftops_ally_holdup();

  common_scripts\utility::flag_wait("skybridge_done");
  var_2 = level.player getweaponslist("primary");

  if(1 >= var_2.size && "flood_knife" == var_2[0])
    maps\_utility::smart_dialogue("flood_diz_hostileahead");
  else {
    wait 0.8;
    maps\_utility::smart_dialogue("flood_diz_holdup");
  }

  maps\_utility::smart_dialogue("flood_diz_gohotmark");
}

rooftops_encounter_a_ally_vo_runners() {
  wait 0.75;

  if(0 < maps\_utility::get_ai_group_count("rooftop_runners")) {
    if(0 >= maps\flood_util::get_enemies_touching_volume("rooftop_runners_vol").size) {
      maps\_utility::smart_dialogue("flood_diz_onesgettin");
      maps\_utility::smart_dialogue("flood_diz_upthestairs2");
    }
  } else {
    common_scripts\utility::flag_wait("rooftops_vo_up_stairs");
    maps\_utility::smart_dialogue("flood_diz_haveabird");
    maps\_utility::smart_dialogue("flood_diz_moveslowly");
  }
}

rooftops_encounter_a_runners_vo() {
  getent("skybridge_finished_blocker", "targetname") waittill("trigger");
  var_0 = maps\_utility::get_ai_group_ai("rooftop_runners");

  if(var_0[0].target == "rooftop_runner_computer") {
    var_1 = var_0[0];
    var_2 = var_0[1];
  } else {
    var_1 = var_0[1];
    var_2 = var_0[0];
  }

  var_1 thread maps\flood_util::stop_enemy_dialogue();
  var_2 thread maps\flood_util::stop_enemy_dialogue();
  var_2 endon("enemy_near");
  var_1.animname = "generic";
  var_2.animname = "generic";
  var_1 thread rooftops_encounter_a_runners_escape_vo();
  var_2 maps\_utility::smart_dialogue("flood_vs10_hearme");
  var_2 thread rooftops_encounter_a_runners_escape_vo();
  var_1 maps\_utility::smart_dialogue("flood_vz11_downloaddata");
  var_1 thread rooftops_encounter_a_runners_escape_vo();
  var_2 maps\_utility::smart_dialogue("flood_vs10_priorityalert");
  var_2 thread rooftops_encounter_a_runners_escape_vo();
  var_1 maps\_utility::smart_dialogue("flood_vs11_rewire");
  var_1 thread rooftops_encounter_a_runners_escape_vo();
  var_2 maps\_utility::smart_dialogue("flood_vs10_setupfine");
  var_2 thread rooftops_encounter_a_runners_escape_vo();
  var_1 maps\_utility::smart_dialogue("flood_vz11_goargue");
  common_scripts\utility::flag_set("rooftops_vo_interrior_done");
  common_scripts\utility::flag_set("rooftops_interior_encounter_start");
  var_2 notify("enemy_near");
}

rooftops_encounter_a_runners_escape_vo() {
  level notify("runners_escape");
  level endon("runners_escape");
  self endon("death");
  self waittill("enemy_near", var_0);
  maps\_utility::anim_stopanimscripted();

  if(isalive(self)) {
    var_1 = maps\_utility::make_array("flood_vz11_enemies", "flood_vz2_americans");
    maps\_utility::smart_dialogue(var_1[randomint(var_1.size)]);
  }
}

rooftops_encounter_b_ally_vo() {
  thread maps\flood_util::notify_on_flag_set("rooftops_encounter_b_death", "early_out");
  self endon("early_out");
  maps\_utility::battlechatter_off("allies");
  thread rooftops_encounter_b_ally_end_vo();
  maps\_utility::wait_for_targetname_trigger("in_sight_of_rooftop_scene_ally");
  wait 2.0;

  if(!common_scripts\utility::flag("rooftops_vo_push_forward_hassle")) {
    var_0 = maps\_utility::make_array("flood_vrg_downhereelias");
    level.allies[0] thread maps\flood_util::play_nag(var_0, "player_drop_progress", 15, 30, 1, 2, "flag_set");
  }

  common_scripts\utility::flag_wait_any("rooftops_vo_push_forward_hassle", "rooftops_water_encounter_start");
  common_scripts\utility::flag_set("player_drop_progress");
  self notify("flag_set");
  wait 2.0;
  var_0 = maps\_utility::make_array("flood_diz_getdownhereneedsupport", "flood_vrg_wereunderfireget", "flood_vrg_cmonandgetin");
  level.allies[0] thread maps\flood_util::play_nag(var_0, "rooftops_vo_push_forward_hassle", 15, 30, 1, 2, "flag_set");
  common_scripts\utility::flag_wait("rooftops_vo_push_forward_hassle");
  self notify("flag_set");
  maps\_utility::battlechatter_on("allies");
  thread rooftops_encounter_b_water_vo();
  thread rooftops_encounter_b_flank_vo();
  wait 1.0;
  common_scripts\utility::flag_clear("rooftops_vo_push_forward_hassle");
}

rooftops_encounter_b_ally_end_vo() {
  var_0 = getent("clear_rooftops_encounter_b", "targetname");
  var_0 endon("trigger");
  maps\_utility::wait_for_targetname_trigger("rooftops_encounter_b_vo_2");
  maps\_utility::battlechatter_off("allies");
  var_1 = getent("rooftops_encounter_b_vo_3", "targetname");

  if(isDefined(var_1)) {
    wait 0.75;
    var_2 = maps\_utility::make_array("flood_diz_gethimselfkilled");
    level.allies[0] thread maps\flood_util::play_nag(var_2, "rooftops_vo_push_forward_hassle", 15, 30, 1, 2, "flag_set");
  }

  common_scripts\utility::flag_wait("rooftops_vo_push_forward_hassle");
  self notify("flag_set");
  var_1 = getent("rooftops_encounter_b_vo_3", "targetname");

  if(isDefined(var_1))
    maps\_utility::smart_dialogue("flood_diz_cominginfromabove");

  var_1 = getent("rooftops_encounter_b_vo_3", "targetname");

  if(isDefined(var_1))
    var_1 waittill("trigger");

  var_1 = getent("clear_rooftops_encounter_b", "targetname");

  if(isDefined(var_1)) {
    common_scripts\utility::flag_wait("rooftops_water_vo_fromabove");
    maps\_utility::smart_dialogue("flood_diz_infromabove");
  }

  maps\_utility::battlechatter_on("allies");
  common_scripts\utility::flag_clear("rooftops_vo_push_forward_hassle");
  wait 3.0;
  var_2 = maps\_utility::make_array("flood_bkr_dropdownhere");
  level.allies[0] thread maps\flood_util::play_nag(var_2, "rooftops_vo_push_forward_nag1", 30, 30, 1, 1, "flag_set");
  wait 10.0;
  var_2 = maps\_utility::make_array("flood_diz_getdownhere");
  level.allies[1] thread maps\flood_util::play_nag(var_2, "rooftops_vo_push_forward_nag1", 30, 30, 1, 1, "flag_set");
  wait 10.0;
  var_2 = maps\_utility::make_array("flood_kgn_needsupport");
  level.allies[2] thread maps\flood_util::play_nag(var_2, "rooftops_vo_push_forward_nag1", 30, 30, 1, 1, "flag_set");
  common_scripts\utility::flag_wait("rooftops_vo_push_forward_nag1");
  level.allies[0] notify("flag_set");
  level.allies[1] notify("flag_set");
  level.allies[2] notify("flag_set");
  wait 1.0;
  common_scripts\utility::flag_clear("rooftops_vo_push_forward_nag1");
}

rooftops_encounter_b_water_vo() {
  self endon("death");
  level endon("cw_player_underwater");
  var_0 = maps\_utility::make_array("flood_diz_usethewater");
  var_1 = 0;
  var_2 = 0;

  while(!common_scripts\utility::flag("rooftops_encounter_b_done") && 3 > var_2) {
    if(!var_1 && 0.5 > level.player.health / level.player.maxhealth) {
      if(common_scripts\utility::flag("cw_player_in_water")) {
        common_scripts\utility::flag_waitopen("dont_interupt_vo");
        maps\_utility::dialogue_queue(var_0[randomint(var_0.size)]);
        var_1 = 1;
        var_2++;
      }

      wait 10.0;
    }

    if(var_1 && level.player.health == level.player.maxhealth)
      var_1 = 0;

    wait 0.5;
  }
}

rooftops_encounter_b_flank_vo() {
  level endon("rooftops_encounter_b_done");

  for(;;) {
    maps\_utility::wait_for_targetname_trigger("rooftops_encounter_b_vo_flank");
    common_scripts\utility::flag_waitopen("dont_interupt_vo");
    maps\_utility::smart_dialogue("flood_diz_flankingus");
  }
}

rooftops_encounter_b_enemy_vo() {
  common_scripts\utility::flag_wait("rooftops_water_encounter_start");
  maps\_utility::battlechatter_on("axis");
  wait 0.75;
  var_0 = maps\_utility::get_ai_group_ai("rooftop_scene_actors");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2.animname = "generic";
      var_2 maps\_utility::smart_dialogue("flood_vz12_getguns");
      break;
    }
  }
}

foo() {
  for(;;)
    wait 0.05;
}

debug_kill_enemies_in_order(var_0) {
  self notifyonplayercommand("debug_kill", "+usereload");
  self waittill("debug_kill");

  for(var_1 = 0; var_1 < 2; var_1++) {
    var_2 = getEntArray("debug_kill_group_" + var_1, "script_noteworthy");

    foreach(var_4 in var_2)
    var_4 kill();

    wait(var_0);
  }
}

wtf_is_it(var_0) {
  for(;;) {
    var_1 = level.player getEye();
    wait 0.1;
  }
}

debug_countdown_timer(var_0, var_1) {
  level endon("stop_timer");

  while(0 < var_0) {
    var_0 = var_0 - 0.05;
    wait 0.05;
  }

  if(isDefined(var_1))
    return;
}