/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hostage.gsc
***********************************************/

function init_hostages(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("spawned_hostage_triggers")) {
    scripts\engine\utility::flag_init("spawned_hostage_triggers");
  }

  if(istrue(var_0)) {
    level.hostages_disablelookat = 1;
  }

  if(istrue(var_1)) {
    level.hostages_disablesounds = 1;
    return;
  }
}

function setup_hostage_anims(var_0, var_1) {
  set_building_hostage_id(var_0);
  var_2 = randomintrange(1, 5);
  var_3 = "hostage_idle_0" + var_2;
  var_4 = "hostage_release_0" + var_2;
  thread anim_hostage_idle(var_3, var_0);
  thread anim_hostage_wait_release(var_4);
}

function make_hostage_usable(var_0, var_1) {
  civ_init(self);
  self.onuse = &civ_hostage;
  self.trigger = spawn("script_model", self.origin + (-1, 0, 35));
  self.trigger linkTo(self, "j_wrist_le");
  self.trigger.group_name = var_0.group_name;
  self.trigger.hostage = self;
  self.trigger makeusable();
  self.trigger setuseprioritymax();
  self.trigger setCursorHint("HINT_BUTTON");
  self.trigger sethintdisplayrange(148);
  self.trigger sethintdisplayfov(90);
  self.trigger setuserange(72);
  self.trigger setusefov(45);
  self.trigger sethintonobstruction("show");
  self.trigger sethintrequiresholding(1);
  self.trigger setuseholdduration("duration_short");
  thread scripts\engine\utility::delete_on_death(self.trigger);
  thread ai_used_think();

  if(!isDefined(level.hostages_spawned_triggers)) {
    level.hostages_spawned_triggers = [];
  }

  level.hostages_spawned_triggers[level.hostages_spawned_triggers.size] = self.trigger;
  thread set_flag_spawned();
}

function set_flag_spawned() {
  wait 1;
  scripts\engine\utility::flag_set("spawned_hostage_triggers");
}

function despawn_hostage(var_0) {
  self notify("start_despawn");
  self endon("start_despawn");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 * var_0;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var_1)) {
      wait 2;
      continue;
    }

    break;
  }

  hostage_kill();
}

function hostage_kill() {
  if(isDefined(self.trigger)) {
    var_0 = scripts\engine\utility::array_find(level.hostages_spawned_triggers, self.trigger);
    level.hostages_spawned_triggers = scripts\engine\utility::array_remove_index(level.hostages_spawned_triggers, var_0);

    if(isent(self.trigger)) {
      self.trigger delete();
    }
  }

  self kill();
}

function allow_despawn_all_hostages() {
  foreach(var_1 in level.spawned_hostage_modules) {
    foreach(var_3 in var_1.ai_spawned) {
      if(isalive(var_3)) {
        thread despawn_hostage(var_3);
      }

      wait 0.05;
    }
  }
}

#using_animtree("");

function anim_init_hostage() {
  if(isDefined(level.scr_animtree["fulton_backpack"])) {
    return;
  }

  level.scr_animtree["fulton_backpack"] = #animtree;
  level.scr_anim["fulton_backpack"]["fulton"] = $cp_fulton_hostage_evac_device_wounded;
  level.scr_animname["fulton_backpack"]["fulton"] = "cp_fulton_hostage_evac_device_wounded";
  level.scr_animtree["fulton_ac130"] = #animtree;
  level.scr_anim["fulton_ac130"]["fulton"] = % cp_fulton_hostage_evac_plane_wounded;
  level.scr_animname["fulton_ac130"]["fulton"] = "cp_fulton_hostage_evac_plane_wounded";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["fulton"] = % cp_fulton_hostage_evac_player_wounded;
  level.scr_eventanim["player"]["fulton"] = "fulton";
  level.scr_animtree["fulton_hostage"] = #animtree;
  level.scr_anim["fulton_hostage"]["fulton"] = % cp_fulton_hostage_evac_civ_wounded;
  level.scr_animname["fulton_hostage"]["fulton"] = "cp_fulton_hostage_evac_civ_wounded";
}

function create_vip_fulton_trigger(var_0, var_1) {
  var_2 = var_0.angles;

  if(isDefined(var_1)) {
    var_2 += var_1;
  }

  var_0.trigger = spawn("script_model", var_0.origin);
  var_3 = rotatevector((0, 0, 15.5), var_0.angles);
  var_0.trigger linkTo(var_0, "tag_origin", var_3, (0, 0, 0));
  var_0.trigger makeusable();
  var_0.trigger setHintString(&"CP_QUARRY2_OBJECTIVES/ATTACH_FULTON_WORLD");
  var_0.trigger setCursorHint("HINT_BUTTON");
  var_0.trigger sethintdisplayrange(256);
  var_0.trigger sethintdisplayfov(360);
  var_0.trigger setuserange(72);
  var_0.trigger setusefov(80);
  var_0.trigger sethintonobstruction("show");
  var_0.trigger sethintrequiresholding(1);
  var_0.trigger setuseholdduration("duration_medium");
  var_0 thread scripts\engine\utility::delete_on_death(var_0.trigger);
  thread vip_use_fulton_think(var_0);
}

function ref_142BB(var_0) {
  var_0.linktoent = spawn("script_model", var_0.origin);
  var_0.linktoent.angles = var_0.angles;
  var_0 linkTo(var_0.linktoent);
}

function vip_use_fulton_think(var_0, var_1) {
  var_0 endon("death");
  var_0.trigger endon("death");
  thread vip_use_fulton_start();

  for(;;) {
    var_0.trigger waittill("trigger", var_2);
    var_0 notify("fulton_hostage", var_2);
    level notify("fulton_hostage", var_2, var_0, var_0.openaltbunker);

    if(isDefined(var_0.linktoent)) {
      var_0 unlink();
      var_0.linktoent delete();
    }

    var_0.trigger makeunusable();
    LOC_00000085:
  }
}

function vip_use_fulton_start() {
  self endon("death");
  self waittill("trigger_progress", var_0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_device_setting", undefined, 0.6);
}

function anim_fulton_hostage_player_scene(var_0, var_1, var_2) {
  var_3 = undefined;
  self waittill("fulton_hostage", var_3);

  if(isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_3.ability_invulnerable = 1;
  }

  if(isagent(var_0)) {
    return;
  }

  var_4 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_5 = spawn("script_model", var_4.origin);
  var_5.angles = var_4.angles;
  var_5 setModel("smuggler_informant_fullbody");
  var_5.animname = "fulton_hostage";
  var_5 useanimtree(level.scr_animtree["fulton_hostage"]);
  var_5 dontinterpolate();
  var_5 hide();

  if(isDefined(var_1)) {
    var_1.origin = var_5 gettagorigin("j_neck");
    var_1 linkTo(var_5, "j_neck");
  }

  var_6 = spawn("script_model", var_4.origin);
  var_6 setModel("military_skyhook_backpack");
  var_6.angles = var_4.angles;
  var_6.animname = "fulton_backpack";
  var_6 useanimtree(level.scr_animtree["fulton_backpack"]);
  var_6 dontinterpolate();
  var_6 hide();
  thread chopper_can_see(level);
  waitframe();
  var_7 = spawn("script_model", var_4.origin);
  var_7 setModel("military_skyhook_hatch");
  var_7.angles = var_4.angles;
  var_7.animname = "fulton_backpack";
  var_7 useanimtree(level.scr_animtree["fulton_backpack"]);
  var_7 linkTo(var_6, "j_main_cable_base", (0, 2, -10), (0, 20, 90));
  var_7 dontinterpolate();
  var_7 hide();
  waitframe();
  var_8 = spawn("script_model", var_4.origin);
  var_8 setModel("military_skyhook_parachute");
  var_8.angles = var_4.angles;
  var_8.animname = "fulton_backpack";
  var_8 useanimtree(level.scr_animtree["fulton_backpack"]);
  var_8 hide();
  waitframe();
  var_9 = spawn("script_model", var_4.origin - (0, 0, 10000));
  var_9 setModel("veh8_mil_air_acharlie130_small");
  var_9.angles = var_4.angles;
  var_9.animname = "fulton_ac130";
  var_9 useanimtree(level.scr_animtree["fulton_ac130"]);
  var_10 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_3, "player", 1, 0, 1);
  var_11 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_6, "fulton_backpack");
  var_11 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_12 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_8, "fulton_backpack");
  var_12 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_13 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_9, "fulton_ac130");
  var_13 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var_14 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_5, "fulton_hostage");
  var_14 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread killentireenemyteam(var_8, var_2);
  thread killedenemy(var_6, var_7, var_3);
  var_3 cameraset("camera_custom_orbit_0");
  thread delay_player_say_attached(var_3);
  thread delay_player_say_in_air(var_3);
  var_15 = [var_10, var_13, var_11, var_12, var_14];

  foreach(var_17 in var_15) {
    if(!isDefined(var_17)) {
      var_15 = scripts\engine\utility::array_remove(var_15, var_17);
    }
  }

  var_0 stopuseanimtree();
  var_0 scriptmodelclearanim();
  level notify("hvt_stop_idle");
  var_0 hide();
  var_5 show();
  var_5 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  thread cleanupents(var_6, var_7, var_8, var_9, var_5);
  thread keypadkeys(var_3);
  var_4 thread scripts\cp_mp\anim_scene::anim_scene(var_15, "fulton", 1, 1, "tag_origin");
}

function keypadkeys(var_0) {
  var_0 endon("death_or_disconnect");
  wait 9;
  var_0 cameradefault();
}

function killedenemy(var_0, var_1, var_2) {
  wait 6.1;
  var_0 dontinterpolate();
  var_0 show();
  var_1 dontinterpolate();
  var_1 show();

  if(isDefined(var_2) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_2.ability_invulnerable = undefined;
  }

  wait 5.1;
  var_1 hide();
}

function delay_player_say_hellyeah(var_0, var_1) {
  level endon("game_ended");
  var_2 = 64000000;
  var_3 = cos(130);
  wait var_0;

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(distance2dsquared(level.players[var_4].origin, var_1.origin) < var_2) {
      if(scripts\engine\utility::within_fov(level.players[var_4].origin, level.players[var_4] getplayerangles(), var_1.origin, var_3)) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[var_4], "flavor_positive", undefined, randomfloat(2));
      }
    }
  }
}

function delay_player_say_in_air(var_0) {
  self endon("death_or_disconnect");
  wait var_0;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "obj_fulton_hvi");
}

function delay_player_say_attached(var_0) {
  self endon("death_or_disconnect");
  wait var_0;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "obj_device_set");
}

function killentireenemyteam(var_0, var_1) {
  if(!isDefined(var_1)) {
    wait 11.38;
  } else {
    wait var_1;
  }

  var_0 show();
}

function anim_hostage_notetrack_handler(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("animscripted", var_2);

    if(!isDefined(var_2)) {
      var_2 = ["undefined"];
    }

    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    var_3 = undefined;

    foreach(var_5 in var_2) {
      switch (var_5) {
        case "attach_backpack":
          thread backpack_delayshow();
          thread chopper_boss_target_tag();
          break;
      }
    }
  }
}

function backpack_delayshow() {
  self show();
}

function chopper_boss_target_tag() {
  self show();
  wait 5.7;
  self hide();
}

function chopper_can_see(var_0) {
  var_0.modifyvehicletoplayerdamage = spawn("script_model", var_0.origin - (0, 0, 192));
  var_0.modifyvehicletoplayerdamage setModel("military_skyhook_backpack");
  var_0.modifyvehicletoplayerdamage notsolid();
}

function anim_hostage_fulton_start(var_0) {
  self endon("death");
  self.ignoreall = 1;
  self.scripted_mode = 1;
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
}

function civ_hostage(var_0, var_1) {
  if(istrue(self.was_used)) {
    return;
  }

  self notify("released");
  level notify("hostage_released");
  self.trigger makeunusable();
  self.was_used = 1;
  self.scripted_mode = 0;
  self.ignoreall = 0;
  self.dontkilloff = 0;
  self.health = 10;
  self.maxhealth = 10;
  self.ignoreme = 0;
  var_2 = randomintrange(140, 190);
  scripts\engine\utility::set_movement_speed(var_2);
  self allowedstances("stand");
  var_3 = scripts\engine\utility::getStructArray("hostage_extract_locations", "targetname");
  var_4 = scripts\engine\utility::getclosest(self.origin, var_3);
  var_5 = getclosestpointonnavmesh(var_4.origin);
  self setgoalpos(var_5);
  thread hostage_keep_goal(var_5);
  thread despawn_hostage(4000);
}

function hostage_keep_goal(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self setgoalpos(var_0);
    wait 4;
  }
}

function civ_init(var_0) {
  var_0 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
  var_0 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
  var_0.scripted_mode = 1;
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0.dontkilloff = 1;
  var_0.health = 100000;
  var_0.maxhealth = 100000;
  var_0.suppressionthreshold = 0;
}

function ai_used_think(var_0) {
  self endon("death");
  self endon("downed");
  self endon("exfil");
  self.trigger endon("death");
  self endon("stop_interact");

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!istrue(self.interact_disabled)) {
      self[[self.onuse]](var_1, var_0);
      self notify("following_player", var_1);
    }
  }
}

function self_onuse(var_0, var_1) {
  scripts\engine\utility::disable_pain();
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setgoalentity(var_0, 100);
  scripts\cp\cp_modular_spawning::set_goal_radius(256);
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("stealth");
}

function anim_hostage_idle(var_0, var_1) {
  self endon("death");
  self endon("released");
  self endon("following_player");

  if(!isDefined(level.spawned_hostage_modules)) {
    level.spawned_hostage_modules = [];
  }

  if(!scripts\engine\utility::array_contains(level.spawned_hostage_modules, var_1)) {
    level.spawned_hostage_modules[var_1.group_name] = var_1;
  }

  if(!istrue(level.hostages_disablelookat)) {
    thread lookat_nearby_players();
  }

  if(!istrue(level.hostages_disablesounds)) {
    thread hostage_cry_idle();
    thread hostage_cry_release();
    thread hostage_seeplayer_frantic();
  }

  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var_0);
}

function anim_hostage_wait_release(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::ref_143AD("released", "following_player");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self, var_1);
}

function reset_guy(var_0, var_1) {
  var_0 allowedstances("prone", "stand", "crouch");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 asmsetstate(var_0.asmname, "panic_idle_stand");
  var_0 setlookatentity();
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
}

function set_building_hostage_id(var_0) {
  var_1 = "";

  switch (var_0.group_name) {
    case "spawned_hostages_a":
    case "spawned_hostage_a":
      var_1 = "a";
      break;
    case "spawned_hostages_b":
    case "spawned_hostage_b":
      var_1 = "b";
      break;
    case "spawned_hostages_c":
    case "spawned_hostage_c":
      var_1 = "c";
      break;
    case "spawned_hostage_d":
    case "spawned_hostages_d":
      var_1 = "d";
      break;
    case "spawned_hostage_e":
    case "spawned_hostages_e":
      var_1 = "e";
      break;
    case "spawned_hostage_f":
    case "spawned_hostages_f":
      var_1 = "f";
      break;
  }

  self.hostage_building_id = var_1;
  self notify("building_id_set");
}

function lookat_nearby_players() {
  self endon("death");
  self endon("released");
  self endon("following_player");
  var_0 = 1500;
  var_1 = var_0 * var_0;

  for(;;) {
    var_2 = scripts\cp\utility::give_closest_player_nearby(self.origin, var_1);

    if(isDefined(var_2)) {
      self.nearbyplayer = var_2;
      self setlookatentity(var_2);
    }

    wait 1;
  }
}

function request_hostage_id(var_0) {
  if(!isDefined(level.obj_building_hostages_1)) {
    level.obj_building_hostages_1 = ["1", "2", "3", "4", "5"];
  }

  if(!isDefined(level.obj_building_hostages_2)) {
    level.obj_building_hostages_2 = ["1", "2", "3", "4", "5"];
  }

  if(!isDefined(level.obj_building_hostages_3)) {
    level.obj_building_hostages_3 = ["1", "2", "3", "4", "5"];
  }

  if(!isDefined(level.obj_building_hostages_4)) {
    level.obj_building_hostages_4 = ["1", "2", "3", "4", "5"];
  }

  if(!isDefined(level.obj_building_hostages_5)) {
    level.obj_building_hostages_5 = ["1", "2", "3", "4", "5"];
  }

  if(!isDefined(level.obj_building_hostages_6)) {
    level.obj_building_hostages_6 = ["1", "2", "3", "4", "5"];
  }

  var_1 = "";

  switch (var_0) {
    case "a":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_1);
      break;
    case "b":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_2);
      break;
    case "c":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_3);
      break;
    case "d":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_4);
      break;
    case "e":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_5);
      break;
    case "f":
      var_1 = create_myid_from_levelarray(level.obj_building_hostages_6);
      break;
  }

  return var_1;
}

function create_myid_from_levelarray(var_0) {
  var_1 = ["1", "2", "3", "4", "5"];

  if(isDefined(var_0)) {
    var_2 = scripts\engine\utility::random(var_0);

    if(!isDefined(var_2)) {
      var_2 = scripts\engine\utility::random(var_1);
    } else {
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    }
  } else {
    var_2 = scripts\engine\utility::random(var_2);
  }

  return var_2;
}

function set_hostage_aliases(var_0) {
  var_1 = undefined;
  var_2 = self.voice;

  if(var_2 == "fsafemale") {
    var_1 = "f";
  } else {
    var_1 = "m";
  }

  self.hostage_aliases_idles = [];
  self.hostage_aliases_release = [];
  self.hostage_aliases_exiting = [];
  self.hostage_last_played = "";
  var_3 = var_0 + "_" + var_1;

  switch (var_3) {
    case "1_m":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm1_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm1_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm1_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm1_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm1_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm1_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm1_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm1_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm1_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm1_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm1_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm1_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm1_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm1_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm1_hostage_exit_50";
      break;
    case "1_f":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf1_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf1_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf1_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf1_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf1_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf1_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf1_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf1_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf1_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf1_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf1_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf1_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf1_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf1_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf1_hostage_exit_50";
      break;
    case "2_m":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm2_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm2_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm2_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm2_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm2_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm2_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm2_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm2_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm2_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm2_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm2_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm2_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm2_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm2_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm2_hostage_exit_50";
      break;
    case "2_f":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf1_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf2_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf2_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf2_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf2_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf2_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf2_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf2_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf2_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf2_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf2_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf2_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf2_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf2_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf2_hostage_exit_50";
      break;
    case "3_m":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm3_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm3_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm3_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm3_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm3_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm3_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm3_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm3_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm3_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm3_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm3_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm3_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm3_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm3_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm3_hostage_exit_50";
      break;
    case "3_f":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf3_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf3_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf3_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf3_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf3_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf3_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf3_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf3_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf3_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf3_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf3_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf3_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf3_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf3_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf3_hostage_exit_50";
      break;
    case "4_m":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm4_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm4_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm4_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm4_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm4_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm4_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm4_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm4_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm4_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm4_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm4_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm4_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm4_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm4_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm4_hostage_exit_50";
      break;
    case "4_f":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf4_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf4_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf4_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf4_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf4_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf4_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf4_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf4_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf4_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf4_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf4_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf4_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf4_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf4_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf4_hostage_exit_50";
      break;
    case "5_m":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm5_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm5_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm5_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm5_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hm5_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm5_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm5_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm5_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm5_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hm5_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm5_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm5_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm5_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm5_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hm5_hostage_exit_50";
      break;
    case "5_f":
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf5_hostage_callout_10";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf5_hostage_callout_20";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf5_hostage_callout_30";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf5_hostage_callout_40";
      self.hostage_aliases_idles[self.hostage_aliases_idles.size] = "dx_cps_hf5_hostage_callout_50";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf5_hostage_release_10";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf5_hostage_release_20";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf5_hostage_release_30";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf5_hostage_release_40";
      self.hostage_aliases_release[self.hostage_aliases_release.size] = "dx_cps_hf5_hostage_release_50";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf5_hostage_exit_10";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf5_hostage_exit_20";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf5_hostage_exit_30";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf5_hostage_exit_40";
      self.hostage_aliases_exiting[self.hostage_aliases_exiting.size] = "dx_cps_hf5_hostage_exit_50";
      break;
  }
}

function hostage_seeplayer_frantic() {
  self endon("death");
  self endon("released");
  self endon("following_player");
  var_0 = 0;
  var_1 = 8000;
  var_2 = 300;
  var_3 = var_2 * var_2;
  var_4 = 1500;
  var_5 = var_4 * var_4;

  for(;;) {
    wait 0.2;

    if(!isDefined(self.nearbyplayer)) {
      continue;
    }

    for(var_6 = 0; var_6 < level.players.size; var_6++) {
      if(distance2dsquared(self.origin, level.players[var_6].origin) > var_5) {
        continue;
      }

      if(distance2dsquared(self.origin, level.players[var_6].origin) < var_3) {
        var_0 = gettime();
        break;
      }

      var_7 = sighttracepassed(level.players[var_6] getEye(), self getEye(), 0, level.players[var_6]);

      if(var_7) {
        var_0 = gettime();
        break;
      }
    }

    wait randomfloatrange(0.1, 0.5);

    if(gettime() < var_0 + var_1) {
      self.hostage_saw_player_recently = 1;
      thread hostage_seeplayer_frantic_share();
      continue;
    }

    self.hostage_saw_player_recently = 0;
  }
}

function hostage_seeplayer_frantic_share() {
  var_0 = 1100;
  var_1 = var_0 * var_0;
  wait randomfloatrange(2, 4.5);

  foreach(var_3 in level.spawned_hostage_modules) {
    for(var_4 = 0; var_4 < var_3.ai_spawned.size; var_4++) {
      if(distance2dsquared(self.origin, var_3.ai_spawned[var_4].origin) < var_1) {
        var_3.ai_spawned[var_4].hostage_saw_player_recently = 1;
      }
    }

    waitframe();
  }
}

function hostage_cry_idle() {
  self endon("death");
  self endon("released");
  self endon("following_player");

  if(!isDefined(level.obj_last_hostage_vo)) {
    level.obj_last_hostage_vo = "";
  }

  if(!isDefined(self.hostage_id)) {
    if(!isDefined(self.hostage_building_id)) {
      self waittill("building_id_set");
    }

    self.hostage_id = request_hostage_id(self.hostage_building_id);
    set_hostage_aliases(self.hostage_id);
  }

  var_0 = 0;
  var_1 = 4000;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.nearbyplayer)) {
      continue;
    }

    if(istrue(self.hostage_saw_player_recently)) {
      if(gettime() > var_0 + var_1) {
        var_0 = gettime();
        var_2 = scripts\engine\utility::random(self.hostage_aliases_idles);

        if(!isDefined(var_2)) {
          return;
        }

        while(var_2 == self.hostage_last_played) {
          var_2 = scripts\engine\utility::random(self.hostage_aliases_idles);
        }

        var_1 += randomintrange(0, 1200);
        var_3 = self gettagorigin("tag_eye");
        thread hostage_play_sound_idle(var_3, var_2);
        self.hostage_last_played = var_2;
        level.obj_last_hostage_vo = var_2;
      }
    }
  }
}

function hostage_play_sound_idle(var_0, var_1) {
  self.soundent = scripts\engine\utility::spawn_tag_origin(var_0);
  self.soundent playSound(var_1);
  var_2 = lookupsoundlength(var_1);
  var_2 /= 1000;
  wait var_2;

  if(isDefined(self.soundent) && isent(self.soundent) && istrue(self.soundent.delaykill)) {
    waitframe();
  }

  if(isent(self.soundent)) {
    self.soundent delete();
    return;
  }
}

function hostage_cry_release() {
  self endon("death");
  scripts\engine\utility::ref_143A5("released", "following_player");

  if(!isDefined(self.hostage_id)) {
    self.hostage_id = request_hostage_id(self.hostage_building_id);
    set_hostage_aliases(self.hostage_id);
  }

  if(isDefined(self.soundent)) {
    self.soundent stopsounds();
    self.soundent.delaykill = 1;
  }

  wait 0.1;
  var_0 = scripts\engine\utility::random(self.hostage_aliases_release);
  self playsoundonmovingent(var_0);
  self.hostage_last_played = var_0;

  if(istrue(self.disable_exit_sounds)) {
    return;
  }

  var_1 = lookupsoundlength(var_0);
  var_1 /= 1000;
  wait var_1 + 1.15;

  for(var_2 = 0; var_2 < 8; var_2++) {
    var_0 = scripts\engine\utility::random(self.hostage_aliases_exiting);
    self playsoundonmovingent(var_0);
    self.hostage_last_played = var_0;
    var_3 = randomfloatrange(5.5, 12);
    wait var_3;
  }
}

function cleanupents(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait 40;

  if(isDefined(var_0) && isent(var_0)) {
    var_0 delete();
  }

  if(isDefined(var_1) && isent(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_2) && isent(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_3) && isent(var_3)) {
    var_3 delete();
  }

  if(isDefined(var_4) && isDefined(var_4.modifyvehicletoplayerdamage) && isent(var_4.modifyvehicletoplayerdamage)) {
    var_4.modifyvehicletoplayerdamage delete();
  }

  if(isDefined(var_5) && isent(var_5)) {
    if(var_5 islinked()) {
      var_5 unlink();
    }

    var_5.origin -= (0, 0, 15000);
    var_5 dodamage(500, var_5.origin, var_5);
  }

  if(isDefined(var_4) && isent(var_4)) {
    var_4 delete();
    return;
  }
}