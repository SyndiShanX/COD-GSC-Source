/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hostage.gsc
***********************************************/

function init_hostages(var0, var1) {
  if(!scripts\engine\utility::flag_exist("spawned_hostage_triggers")) {
    scripts\engine\utility::flag_init("spawned_hostage_triggers");
  }

  if(istrue(var0)) {
    level.hostages_disablelookat = 1;
  }

  if(istrue(var1)) {
    level.hostages_disablesounds = 1;
    return;
  }
}

function setup_hostage_anims(var0, var1) {
  set_building_hostage_id(var0);
  var2 = randomintrange(1, 5);
  var3 = "hostage_idle_0" + var2;
  var4 = "hostage_release_0" + var2;
  thread anim_hostage_idle(var3, var0);
  thread anim_hostage_wait_release(var4);
}

function make_hostage_usable(var0, var1) {
  civ_init(self);
  self.onuse = &civ_hostage;
  self.trigger = spawn("script_model", self.origin + (-1, 0, 35));
  self.trigger linkTo(self, "j_wrist_le");
  self.trigger.group_name = var0.group_name;
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

function despawn_hostage(var0) {
  self notify("start_despawn");
  self endon("start_despawn");
  self endon("death");
  level endon("game_ended");
  var1 = var0 * var0;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, var1)) {
      wait 2;
      continue;
    }

    break;
  }

  hostage_kill();
}

function hostage_kill() {
  if(isDefined(self.trigger)) {
    var0 = scripts\engine\utility::array_find(level.hostages_spawned_triggers, self.trigger);
    level.hostages_spawned_triggers = scripts\engine\utility::array_remove_index(level.hostages_spawned_triggers, var0);

    if(isent(self.trigger)) {
      self.trigger delete();
    }
  }

  self kill();
}

function allow_despawn_all_hostages() {
  foreach(var1 in level.spawned_hostage_modules) {
    foreach(var3 in var1.ai_spawned) {
      if(isalive(var3)) {
        thread despawn_hostage(var3);
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

function create_vip_fulton_trigger(var0, var1) {
  var2 = var0.angles;

  if(isDefined(var1)) {
    var2 += var1;
  }

  var0.trigger = spawn("script_model", var0.origin);
  var3 = rotatevector((0, 0, 15.5), var0.angles);
  var0.trigger linkTo(var0, "tag_origin", var3, (0, 0, 0));
  var0.trigger makeusable();
  var0.trigger setHintString(&"CP_QUARRY2_OBJECTIVES/ATTACH_FULTON_WORLD");
  var0.trigger setCursorHint("HINT_BUTTON");
  var0.trigger sethintdisplayrange(256);
  var0.trigger sethintdisplayfov(360);
  var0.trigger setuserange(72);
  var0.trigger setusefov(80);
  var0.trigger sethintonobstruction("show");
  var0.trigger sethintrequiresholding(1);
  var0.trigger setuseholdduration("duration_medium");
  var0 thread scripts\engine\utility::delete_on_death(var0.trigger);
  thread vip_use_fulton_think(var0);
}

function ref_142bb(var0) {
  var0.linktoent = spawn("script_model", var0.origin);
  var0.linktoent.angles = var0.angles;
  var0 linkTo(var0.linktoent);
}

function vip_use_fulton_think(var0, var1) {
  var0 endon("death");
  var0.trigger endon("death");
  thread vip_use_fulton_start();

  for(;;) {
    var0.trigger waittill("trigger", var2);
    var0 notify("fulton_hostage", var2);
    level notify("fulton_hostage", var2, var0, var0.openaltbunker);

    if(isDefined(var0.linktoent)) {
      var0 unlink();
      var0.linktoent delete();
    }

    var0.trigger makeunusable();
    LOC_00000085:
  }
}

function vip_use_fulton_start() {
  self endon("death");
  self waittill("trigger_progress", var0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_device_setting", undefined, 0.6);
}

function anim_fulton_hostage_player_scene(var0, var1, var2) {
  var3 = undefined;
  self waittill("fulton_hostage", var3);

  if(isDefined(var3) && var3 scripts\cp_mp\utility\player_utility::_isalive()) {
    var3.ability_invulnerable = 1;
  }

  if(isagent(var0)) {
    return;
  }

  var4 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var5 = spawn("script_model", var4.origin);
  var5.angles = var4.angles;
  var5 setModel("smuggler_informant_fullbody");
  var5.animname = "fulton_hostage";
  var5 useanimtree(level.scr_animtree["fulton_hostage"]);
  var5 dontinterpolate();
  var5 hide();

  if(isDefined(var1)) {
    var1.origin = var5 gettagorigin("j_neck");
    var1 linkTo(var5, "j_neck");
  }

  var6 = spawn("script_model", var4.origin);
  var6 setModel("military_skyhook_backpack");
  var6.angles = var4.angles;
  var6.animname = "fulton_backpack";
  var6 useanimtree(level.scr_animtree["fulton_backpack"]);
  var6 dontinterpolate();
  var6 hide();
  thread chopper_can_see(level);
  waitframe();
  var7 = spawn("script_model", var4.origin);
  var7 setModel("military_skyhook_hatch");
  var7.angles = var4.angles;
  var7.animname = "fulton_backpack";
  var7 useanimtree(level.scr_animtree["fulton_backpack"]);
  var7 linkTo(var6, "j_main_cable_base", (0, 2, -10), (0, 20, 90));
  var7 dontinterpolate();
  var7 hide();
  waitframe();
  var8 = spawn("script_model", var4.origin);
  var8 setModel("military_skyhook_parachute");
  var8.angles = var4.angles;
  var8.animname = "fulton_backpack";
  var8 useanimtree(level.scr_animtree["fulton_backpack"]);
  var8 hide();
  waitframe();
  var9 = spawn("script_model", var4.origin - (0, 0, 10000));
  var9 setModel("veh8_mil_air_acharlie130_small");
  var9.angles = var4.angles;
  var9.animname = "fulton_ac130";
  var9 useanimtree(level.scr_animtree["fulton_ac130"]);
  var10 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var3, "player", 1, 0, 1);
  var11 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var6, "fulton_backpack");
  var11 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var12 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var8, "fulton_backpack");
  var12 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var13 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var9, "fulton_ac130");
  var13 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  var14 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var5, "fulton_hostage");
  var14 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(0);
  thread killentireenemyteam(var8, var2);
  thread killedenemy(var6, var7, var3);
  var3 cameraset("camera_custom_orbit_0");
  thread delay_player_say_attached(var3);
  thread delay_player_say_in_air(var3);
  var15 = [var10, var13, var11, var12, var14];

  foreach(var17 in var15) {
    if(!isDefined(var17)) {
      var15 = scripts\engine\utility::array_remove(var15, var17);
    }
  }

  var0 stopuseanimtree();
  var0 scriptmodelclearanim();
  level notify("hvt_stop_idle");
  var0 hide();
  var5 show();
  var5 scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  thread cleanupents(var6, var7, var8, var9, var5);
  thread keypadkeys(var3);
  var4 thread scripts\cp_mp\anim_scene::anim_scene(var15, "fulton", 1, 1, "tag_origin");
}

function keypadkeys(var0) {
  var0 endon("death_or_disconnect");
  wait 9;
  var0 cameradefault();
}

function killedenemy(var0, var1, var2) {
  wait 6.1;
  var0 dontinterpolate();
  var0 show();
  var1 dontinterpolate();
  var1 show();

  if(isDefined(var2) && var2 scripts\cp_mp\utility\player_utility::_isalive()) {
    var2.ability_invulnerable = undefined;
  }

  wait 5.1;
  var1 hide();
}

function delay_player_say_hellyeah(var0, var1) {
  level endon("game_ended");
  var2 = 64000000;
  var3 = cos(130);
  wait var0;

  for(var4 = 0; var4 < level.players.size; var4++) {
    if(distance2dsquared(level.players[var4].origin, var1.origin) < var2) {
      if(scripts\engine\utility::within_fov(level.players[var4].origin, level.players[var4] getplayerangles(), var1.origin, var3)) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(level.players[var4], "flavor_positive", undefined, randomfloat(2));
      }
    }
  }
}

function delay_player_say_in_air(var0) {
  self endon("death_or_disconnect");
  wait var0;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "obj_fulton_hvi");
}

function delay_player_say_attached(var0) {
  self endon("death_or_disconnect");
  wait var0;
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "obj_device_set");
}

function killentireenemyteam(var0, var1) {
  if(!isDefined(var1)) {
    wait 11.38;
  } else {
    wait var1;
  }

  var0 show();
}

function anim_hostage_notetrack_handler(var0, var1) {
  self endon("death");

  for(;;) {
    self waittill("animscripted", var2);

    if(!isDefined(var2)) {
      var2 = ["undefined"];
    }

    if(!isarray(var2)) {
      var2 = [var2];
    }

    var3 = undefined;

    foreach(var5 in var2) {
      switch (var5) {
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

function chopper_can_see(var0) {
  var0.modifyvehicletoplayerdamage = spawn("script_model", var0.origin - (0, 0, 192));
  var0.modifyvehicletoplayerdamage setModel("military_skyhook_backpack");
  var0.modifyvehicletoplayerdamage notsolid();
}

function anim_hostage_fulton_start(var0) {
  self endon("death");
  self.ignoreall = 1;
  self.scripted_mode = 1;
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
}

function civ_hostage(var0, var1) {
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
  var2 = randomintrange(140, 190);
  scripts\engine\utility::set_movement_speed(var2);
  self allowedstances("stand");
  var3 = scripts\engine\utility::getStructArray("hostage_extract_locations", "targetname");
  var4 = scripts\engine\utility::getclosest(self.origin, var3);
  var5 = getclosestpointonnavmesh(var4.origin);
  self setgoalpos(var5);
  thread hostage_keep_goal(var5);
  thread despawn_hostage(4000);
}

function hostage_keep_goal(var0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self setgoalpos(var0);
    wait 4;
  }
}

function civ_init(var0) {
  var0 scripts\cp\cp_modular_spawning::update_spawn_data_on_spawn();
  var0 thread scripts\cp\cp_modular_spawning::_update_spawn_data_on_death();
  var0.scripted_mode = 1;
  var0.ignoreall = 1;
  var0.ignoreme = 1;
  var0.dontkilloff = 1;
  var0.health = 100000;
  var0.maxhealth = 100000;
  var0.suppressionthreshold = 0;
}

function ai_used_think(var0) {
  self endon("death");
  self endon("downed");
  self endon("exfil");
  self.trigger endon("death");
  self endon("stop_interact");

  for(;;) {
    self.trigger waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!istrue(self.interact_disabled)) {
      self[[self.onuse]](var1, var0);
      self notify("following_player", var1);
    }
  }
}

function self_onuse(var0, var1) {
  scripts\engine\utility::disable_pain();
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setgoalentity(var0, 100);
  scripts\cp\cp_modular_spawning::set_goal_radius(256);
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("stealth");
}

function anim_hostage_idle(var0, var1) {
  self endon("death");
  self endon("released");
  self endon("following_player");

  if(!isDefined(level.spawned_hostage_modules)) {
    level.spawned_hostage_modules = [];
  }

  if(!scripts\engine\utility::array_contains(level.spawned_hostage_modules, var1)) {
    level.spawned_hostage_modules[var1.group_name] = var1;
  }

  if(!istrue(level.hostages_disablelookat)) {
    thread lookat_nearby_players();
  }

  if(!istrue(level.hostages_disablesounds)) {
    thread hostage_cry_idle();
    thread hostage_cry_release();
    thread hostage_seeplayer_frantic();
  }

  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var0);
}

function anim_hostage_wait_release(var0) {
  self endon("death");
  var1 = scripts\engine\utility::ref_143ad("released", "following_player");
  scripts\asm\shared\mp\utility::burndowntime(var0);
  reset_guy(self, var1);
}

function reset_guy(var0, var1) {
  var0 allowedstances("prone", "stand", "crouch");
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var0 asmsetstate(var0.asmname, "panic_idle_stand");
  var0 setlookatentity();
  var0.headlook_enabled = 1;
  var0.disableautolookat = 0;
  var0.deathstate = undefined;
  var0.deathalias = undefined;
  var0.ignoreall = 0;
}

function set_building_hostage_id(var0) {
  var1 = "";

  switch (var0.group_name) {
    case "spawned_hostages_a":
    case "spawned_hostage_a":
      var1 = "a";
      break;
    case "spawned_hostages_b":
    case "spawned_hostage_b":
      var1 = "b";
      break;
    case "spawned_hostages_c":
    case "spawned_hostage_c":
      var1 = "c";
      break;
    case "spawned_hostage_d":
    case "spawned_hostages_d":
      var1 = "d";
      break;
    case "spawned_hostage_e":
    case "spawned_hostages_e":
      var1 = "e";
      break;
    case "spawned_hostage_f":
    case "spawned_hostages_f":
      var1 = "f";
      break;
  }

  self.hostage_building_id = var1;
  self notify("building_id_set");
}

function lookat_nearby_players() {
  self endon("death");
  self endon("released");
  self endon("following_player");
  var0 = 1500;
  var1 = var0 * var0;

  for(;;) {
    var2 = scripts\cp\utility::give_closest_player_nearby(self.origin, var1);

    if(isDefined(var2)) {
      self.nearbyplayer = var2;
      self setlookatentity(var2);
    }

    wait 1;
  }
}

function request_hostage_id(var0) {
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

  var1 = "";

  switch (var0) {
    case "a":
      var1 = create_myid_from_levelarray(level.obj_building_hostages_1);
      break;
    case "b":
      var1 = create_myid_from_levelarray(level.obj_building_hostages_2);
      break;
    case "c":
      var1 = create_myid_from_levelarray(level.obj_building_hostages_3);
      break;
    case "d":
      var1 = create_myid_from_levelarray(level.obj_building_hostages_4);
      break;
    case "e":
      var1 = create_myid_from_levelarray(level.obj_building_hostages_5);
      break;
    case "f":
      var1 = create_myid_from_levelarray(level.obj_building_hostages_6);
      break;
  }

  return var1;
}

function create_myid_from_levelarray(var0) {
  var1 = ["1", "2", "3", "4", "5"];

  if(isDefined(var0)) {
    var2 = scripts\engine\utility::random(var0);

    if(!isDefined(var2)) {
      var2 = scripts\engine\utility::random(var1);
    } else {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  } else {
    var2 = scripts\engine\utility::random(var2);
  }

  return var2;
}

function set_hostage_aliases(var0) {
  var1 = undefined;
  var2 = self.voice;

  if(var2 == "fsafemale") {
    var1 = "f";
  } else {
    var1 = "m";
  }

  self.hostage_aliases_idles = [];
  self.hostage_aliases_release = [];
  self.hostage_aliases_exiting = [];
  self.hostage_last_played = "";
  var3 = var0 + "_" + var1;

  switch (var3) {
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
  var0 = 0;
  var1 = 8000;
  var2 = 300;
  var3 = var2 * var2;
  var4 = 1500;
  var5 = var4 * var4;

  for(;;) {
    wait 0.2;

    if(!isDefined(self.nearbyplayer)) {
      continue;
    }

    for(var6 = 0; var6 < level.players.size; var6++) {
      if(distance2dsquared(self.origin, level.players[var6].origin) > var5) {
        continue;
      }

      if(distance2dsquared(self.origin, level.players[var6].origin) < var3) {
        var0 = gettime();
        break;
      }

      var7 = sighttracepassed(level.players[var6] getEye(), self getEye(), 0, level.players[var6]);

      if(var7) {
        var0 = gettime();
        break;
      }
    }

    wait randomfloatrange(0.1, 0.5);

    if(gettime() < var0 + var1) {
      self.hostage_saw_player_recently = 1;
      thread hostage_seeplayer_frantic_share();
      continue;
    }

    self.hostage_saw_player_recently = 0;
  }
}

function hostage_seeplayer_frantic_share() {
  var0 = 1100;
  var1 = var0 * var0;
  wait randomfloatrange(2, 4.5);

  foreach(var3 in level.spawned_hostage_modules) {
    for(var4 = 0; var4 < var3.ai_spawned.size; var4++) {
      if(distance2dsquared(self.origin, var3.ai_spawned[var4].origin) < var1) {
        var3.ai_spawned[var4].hostage_saw_player_recently = 1;
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

  var0 = 0;
  var1 = 4000;

  for(;;) {
    wait 0.05;

    if(!isDefined(self.nearbyplayer)) {
      continue;
    }

    if(istrue(self.hostage_saw_player_recently)) {
      if(gettime() > var0 + var1) {
        var0 = gettime();
        var2 = scripts\engine\utility::random(self.hostage_aliases_idles);

        if(!isDefined(var2)) {
          return;
        }

        while(var2 == self.hostage_last_played) {
          var2 = scripts\engine\utility::random(self.hostage_aliases_idles);
        }

        var1 += randomintrange(0, 1200);
        var3 = self gettagorigin("tag_eye");
        thread hostage_play_sound_idle(var3, var2);
        self.hostage_last_played = var2;
        level.obj_last_hostage_vo = var2;
      }
    }
  }
}

function hostage_play_sound_idle(var0, var1) {
  self.soundent = scripts\engine\utility::spawn_tag_origin(var0);
  self.soundent playSound(var1);
  var2 = lookupsoundlength(var1);
  var2 /= 1000;
  wait var2;

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
  scripts\engine\utility::ref_143a5("released", "following_player");

  if(!isDefined(self.hostage_id)) {
    self.hostage_id = request_hostage_id(self.hostage_building_id);
    set_hostage_aliases(self.hostage_id);
  }

  if(isDefined(self.soundent)) {
    self.soundent stopsounds();
    self.soundent.delaykill = 1;
  }

  wait 0.1;
  var0 = scripts\engine\utility::random(self.hostage_aliases_release);
  self playsoundonmovingent(var0);
  self.hostage_last_played = var0;

  if(istrue(self.disable_exit_sounds)) {
    return;
  }

  var1 = lookupsoundlength(var0);
  var1 /= 1000;
  wait var1 + 1.15;

  for(var2 = 0; var2 < 8; var2++) {
    var0 = scripts\engine\utility::random(self.hostage_aliases_exiting);
    self playsoundonmovingent(var0);
    self.hostage_last_played = var0;
    var3 = randomfloatrange(5.5, 12);
    wait var3;
  }
}

function cleanupents(var0, var1, var2, var3, var4, var5) {
  wait 40;

  if(isDefined(var0) && isent(var0)) {
    var0 delete();
  }

  if(isDefined(var1) && isent(var1)) {
    var1 delete();
  }

  if(isDefined(var2) && isent(var2)) {
    var2 delete();
  }

  if(isDefined(var3) && isent(var3)) {
    var3 delete();
  }

  if(isDefined(var4) && isDefined(var4.modifyvehicletoplayerdamage) && isent(var4.modifyvehicletoplayerdamage)) {
    var4.modifyvehicletoplayerdamage delete();
  }

  if(isDefined(var5) && isent(var5)) {
    if(var5 islinked()) {
      var5 unlink();
    }

    var5.origin -= (0, 0, 15000);
    var5 dodamage(500, var5.origin, var5);
  }

  if(isDefined(var4) && isent(var4)) {
    var4 delete();
    return;
  }
}