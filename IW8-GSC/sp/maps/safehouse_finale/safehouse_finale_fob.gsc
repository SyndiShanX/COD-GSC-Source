/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse_finale\safehouse_finale_fob.gsc
*************************************************************/

init_fob() {
  fob_flags();
  fob_precache();
  fob_fx();
}

fob_precache() {
  setdvarifuninitialized("scr_drn_useKillstreakMissile", 0);
  precachemodel("viewhands_base_fullbody_iw8");
  thread scripts\sp\player\offhand_box::offhand_box_setup();
  thread init_towers();
  thread init_ending_lights();
  thread init_tarmac_fire_lights();
  thread init_chu_fire_lights();
  thread init_chopper_lights();
  thread init_hangar_vehicles();
  thread hide_tarmac_scriptables_until_apache();
  var_0 = getEntArray("offhand_box", "targetname");
  scripts\engine\utility::array_thread(var_0, ::ammo_box_lids);
  var_1 = getEntArray("destroyed_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_1, ::hide);
  var_2 = getEntArray("ending_scene_vindia", "targetname");
  scripts\engine\utility::array_call(var_2, ::hide);
  var_3 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy");
  scripts\engine\utility::array_call(var_3, ::hide);
  var_4 = getEntArray("fuel_truck_corpse", "targetname");
  scripts\engine\utility::array_call(var_4, ::hide);
  level.choppers = [];
  level.tromeos = [];
  level.airport_gate_open = 1;
  level.squad_max_size = 4;
  level.squad_leader_group_size = 4;
  level.friendly_struct = spawnStruct();
  level.friendly_struct.animname = "SLF Rebel";
  level.friendly_struct.name = "SLF Rebel";
  level.apachee_pilot = spawnStruct();
  level.apachee_pilot.name = "Co-Pilot";
  level.tower_drone_target = 0;
  level.player_struct = spawnStruct();
  level.player_struct.animname = "Alex";
  level.player_struct.name = "Alex";
  level.current_visionset = "";
  level.special_autosavecondition = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::autosave_block_in_drone;
  var_5 = getEnt("truck_smash_clip", "targetname");
  var_5 connectpaths();
  var_5 hide();
}

init_hangar_vehicles() {
  wait 0.3;
  var_0 = getscriptablearray("hangar_trucks", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("body", "no_process");
}

init_tarmac_fire_lights() {
  var_0 = getEntArray("tarmac_fires", "targetname");

  foreach(var_2 in var_0) {
    var_2.original_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("tarmac_fire_lights");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.original_intensity);

  scripts\engine\utility::flag_waitopen("tarmac_fire_lights");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

init_chu_fire_lights() {
  var_0 = getEntArray("chu_fire", "targetname");

  foreach(var_2 in var_0) {
    var_2.origin_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  level waittill("chu_fire_start");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.origin_intensity);
}

chu_bad_places() {
  level.chu_bad_places_ids = [];
  var_0 = getEntArray("chu_bad_places", "targetname");

  foreach(var_2 in var_0)
  level.chu_bad_places_ids[level.chu_bad_places_ids.size] = createnavbadplacebyent(var_2, "axis");

  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");

  foreach(var_5 in level.chu_bad_places_ids)
  destroynavobstacle(var_5);
}

chu_bad_places_armory() {
  waitframe();
  var_0 = getEntArray("chu_bad_places_armory", "targetname");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = createnavbadplacebyent(var_3, "axis", "allies");

  scripts\engine\utility::flag_wait("armory_01_secure");

  foreach(var_6 in var_1)
  destroynavobstacle(var_6);
}

fob_fx() {}

fob_flags() {
  scripts\engine\utility::flag_init("drone_sprinted");
  scripts\engine\utility::flag_init("drone_detonated");
  scripts\engine\utility::flag_init("fob_center");
  scripts\engine\utility::flag_init("intro_dialogue_complete");
  scripts\engine\utility::flag_init("bunker_busted");
  scripts\engine\utility::flag_init("enter_bunkers");
  scripts\engine\utility::flag_init("ai_spawner_busy");
  scripts\engine\utility::flag_init("troop_rally");
  scripts\engine\utility::flag_init("hadir_at_goal");
  scripts\engine\utility::flag_init("mortar_team_killed");
  scripts\engine\utility::flag_init("bunkers_push");
  scripts\engine\utility::flag_init("boss_turret_disabled");
  scripts\engine\utility::flag_init("boss_turret_enabled");
  scripts\engine\utility::flag_init("drone_allowed");
  scripts\engine\utility::flag_init("chopper_wounded");
  scripts\engine\utility::flag_init("boss_rockets_disabled");
  scripts\engine\utility::flag_init("wall_approach_vo_finished");
  scripts\engine\utility::flag_init("farah_pep_talking");
  scripts\engine\utility::flag_init("boss_kill_prep");
  scripts\engine\utility::flag_init("armory_01_secure");
  scripts\engine\utility::flag_init("armory_02_secure");
  scripts\engine\utility::flag_init("cleared_armory_02");
  scripts\engine\utility::flag_init("entered_armory_02");
  scripts\engine\utility::flag_init("container_door_breached");
  scripts\engine\utility::flag_init("chu_chopper_first_attack_done");
  scripts\engine\utility::flag_init("hadir_approaching_chopper");
  scripts\engine\utility::flag_init("finished_bunker_vo");
  scripts\engine\utility::flag_init("finished_fob_center_vo");
  scripts\engine\utility::flag_init("one_fob_helo_left");
  scripts\engine\utility::flag_init("no_fob_helos_left");
  scripts\engine\utility::flag_init("boss_chopper_dead");
  scripts\engine\utility::flag_init("fob_cleared");
  scripts\engine\utility::flag_init("fob_spawns_complete");
  scripts\engine\utility::flag_init("hadir_prep_go");
  scripts\engine\utility::flag_init("air_support_inbound");
  scripts\engine\utility::flag_init("apache_here");
  scripts\engine\utility::flag_init("hadir_gate_smash");
  scripts\engine\utility::flag_init("hadir_gate_smash_stop");
  scripts\engine\utility::flag_init("hadir_ramming_dialogue_complete");
  scripts\engine\utility::flag_init("killstreak_complete");
  scripts\engine\utility::flag_init("prep_outside_1");
  scripts\engine\utility::flag_init("hadir_at_truck");
  scripts\engine\utility::flag_init("hadir_in_truck");
  scripts\engine\utility::flag_init("ally_armory_01_secure");
  scripts\engine\utility::flag_init("armory_dialogue_complete");
  scripts\engine\utility::flag_init("air_support_dialogue_complete");
  scripts\engine\utility::flag_init("tarmac_cleared");
  scripts\engine\utility::flag_init("intro_player_behind_hadir");
  scripts\engine\utility::flag_init("hadir_at_gate");
  scripts\engine\utility::flag_init("hangar_entrance");
  scripts\engine\utility::flag_init("player_has_tablet");
  scripts\engine\utility::flag_init("retreat");
  scripts\engine\utility::flag_init("airforce_vo_complete");
  scripts\engine\utility::flag_init("early_charge");
  scripts\engine\utility::flag_init("armory_02_exit");
  scripts\engine\utility::flag_init("pep_talk_trigger");
  scripts\engine\utility::flag_init("reached_pep_idle");
  scripts\engine\utility::flag_init("hadir_go_to_hatch");
  scripts\engine\utility::flag_init("player_in_armory_02");
  scripts\engine\utility::flag_init("farah_gate_lookat");
  scripts\engine\utility::flag_init("pallet_smash");
  scripts\engine\utility::flag_init("tarmac_fire_lights");
  scripts\engine\utility::flag_init("chu_fire_lights");
  scripts\engine\utility::flag_init("armory_01_trigger");
  scripts\engine\utility::flag_init("hatch_opened");
  scripts\engine\utility::flag_init("molotov_used");
  scripts\engine\utility::flag_init("tablet_vo");
  scripts\engine\utility::flag_init("power_kill");
  scripts\engine\utility::flag_init("kill_tower_snipers");
  scripts\engine\utility::flag_init("rpg_guys_go");
  scripts\engine\utility::flag_init("containers_vo_finished");
  scripts\engine\utility::flag_init("dont_drone_nag");
  scripts\engine\utility::flag_init("mission_failed");
  scripts\engine\utility::flag_init("disengage_apache");
  scripts\engine\utility::flag_init("door_gag_door_damaged");
  scripts\engine\utility::flag_init("start_fly_countdown");
  scripts\engine\utility::flag_init("ending_light_flicker_flag");
  scripts\engine\utility::flag_init("player_exited_river");
  scripts\engine\utility::flag_init("chopper_guns_pressed");
  scripts\engine\utility::flag_init("chopper_zoom_pressed");
  scripts\engine\utility::flag_init("chopper_rockets_pressed");
  scripts\engine\utility::flag_init("ks_trucks_stopped");
  scripts\engine\utility::flag_init("second_cannon");
  scripts\engine\utility::flag_init("ally_fob_movement_complete");
  scripts\engine\utility::flag_init("killing_player");
  var_0 = getEnt("charge_drop_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("player_dropped_in", var_0, 1);
}

fob_post_load_inits() {
  thread show_destroyed_choppers();
}

show_destroyed_choppers() {
  scripts\engine\utility::flag_wait_any("fob_center_entrance", "container_door_breached", "chu_exit");
  var_0 = getEntArray("destroyed_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_0, ::show);
  var_1 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy");
  scripts\engine\utility::array_call(var_1, ::show);
}

bink_start() {
  level.bink_start = 1;
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_roofs", [level.player]);
}

bink_main() {
  hidecinematicletterboxing(0.01, 0);
  level.player modifybasefov(42, 0.01);
  level.player setstance("stand");
  level.player hideviewmodel();
  level.player hidelegsandshadow();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player dontinterpolate();
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", (0, 0, 0), level.player.angles);
  var_0 = getEnt("binoculars", "targetname");
  level.player playerlinkTo(level.player.rig, "tag_origin", 1, 0, 0, 0, 0, 0);
  level.farah scripts\common\ai::gun_remove();
  level.player.rig hide();
  var_1 = scripts\engine\utility::getStruct("intro_anim_struct", "targetname");
  var_1 thread scripts\common\anim::anim_single([level.farah, level.player.rig], "bink_scene_roof");
  waitframe();
  var_0.origin = level.farah gettagorigin("tag_accessory_left");
  var_0.angles = level.farah gettagangles("tag_accessory_left");
  var_0 linkTo(level.farah, "tag_accessory_left");
  thread bink_town_allies();
  thread hc_workers_scene();
  thread ally_town_movement_bink();
  thread bink_hc();
  thread bink_choppers();
  thread bink_technical();
  scripts\engine\utility::flag_set_delayed("beta_00", 0);
  level thread scripts\engine\sp\utility::dof_enable(2.0, 800, 400, undefined);
  wait 9;
  level thread scripts\engine\sp\utility::dof_enable(2.0, 130, 1, undefined);
  level waittill("forever");
}

bink_town_allies() {
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies();
  wait 0.5;
  var_0 = 400;
  var_1 = getaiarray("allies", "axis");

  foreach(var_3 in var_1) {
    var_3.ignoreall = 1;

    if(distance(var_3.origin, (-32391, 30264, -717)) < var_0)
      var_3 delete();
  }

  var_1 = getEntArray("defenders", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 delete();

  var_1 = getaiarray("allies", "axis");
  var_3 = sortbydistance(var_1, (-32667, 30155, -716))[0];
  var_3 delete();
}

bink_technical() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("bink_technical_01");
  var_0.maxhealth = 34000;
  var_1 = getvehiclenode("bink_technical_start_01", "targetname");
  var_2 = getEntArray("truck_lights", "targetname");
  waitframe();
  var_3 = 3;

  foreach(var_5 in var_2) {
    if(scripts\engine\utility::is_equal(var_5.script_noteworthy, "left")) {
      var_5.origin = var_0 gettagorigin("tag_light_front_left");
      var_5.origin = var_5.origin + anglesToForward(var_5.angles) * var_3;
      var_5.angles = var_0 gettagangles("tag_light_front_left");
      var_5 linkTo(var_0);
    }

    if(scripts\engine\utility::is_equal(var_5.script_noteworthy, "right")) {
      var_5.origin = var_0 gettagorigin("tag_light_front_right");
      var_5.origin = var_5.origin + anglesToForward(var_5.angles) * var_3;
      var_5.angles = var_0 gettagangles("tag_light_front_right");
      var_5 linkTo(var_0);
    }
  }

  wait 4;
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 vehicle_setspeedimmediate(10, 5);

  while(var_0.veh_speed)
    wait 0.1;

  level notify("technical_stopped");
}

bink_hc() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var_1 = spawnStruct();
  var_2 = getspawner("bink_actor_hc", "targetname");
  var_1.angles = var_2.angles;
  var_1.origin = var_2.origin + (0, 0, 5);
  var_3 = scripts\engine\sp\utility::spawn_targetname("bink_actor_hc", 1);
  var_3 scripts\common\ai::gun_remove();
  var_3.animname = "rebel";
  var_4 = [var_3, var_0];
  var_1 thread scripts\common\anim::anim_single(var_4, "intro_scene");
  waitframe();
  var_0 setanimtime(var_0 scripts\engine\utility::getanim("intro_scene"), 0.25);
  var_3 setanimtime(var_3 scripts\engine\utility::getanim("intro_scene"), 0.25);
}

bink_choppers() {
  var_0 = scripts\common\vehicle::spawn_vehicles_from_targetname("bink_choppers");
  scripts\engine\utility::array_thread(var_0, ::bink_chopper_behavior);
}

bink_chopper_behavior() {
  var_0 = spawnStruct();
  var_1 = self.origin + anglesToForward(self.angles) * 7500;
  var_1 = var_1 + (0, 0, -900);
  self vehicle_teleport(var_1, self.angles);
  var_0 = self.origin + anglesToForward(self.angles) * 20000;
  self setvehgoalpos(var_0, 1);
}

safehouse_interior_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon(1);
  var_0 = getEntArray("destroyed_tarmac_models", "script_noteworthy");
  scripts\engine\utility::array_call(var_0, ::hide);
}

safehouse_interior_main() {
  level thread bink_save_hack();
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.05);
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 1);
  thread cinematic_bars_intro();
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting.gsc::lt_interior_main_start();
  level.player allowsprint(0);
  thread scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_droneambientspawnmanager();
  level.player modifybasefov(55, 0.1);
  var_1 = getEnt("player_tablet", "targetname");
  var_1.origin = var_1.origin + (0, 13, 0);
  thread player_movespeed();
  thread objective_manager();
  thread trigger_manager();
  thread hell_cannon_intro_scene();
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  thread dialogue_safehouse_interior();
  var_2.support_equipment = 0;
  var_3.support_equipment = 0;
  scripts\engine\sp\utility::set_start_location("start_safehouse", [level.player, var_2, var_3]);
  thread scene_intro();
  level.hadir.name = "";
  wait 0.3;
  var_0 fadeovertime(0.1);
  var_0.alpha = 0;
  wait 1;
  thread transient_loading();
  wait 3;
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  scripts\engine\sp\utility::trigger_wait_targetname("hadir_stairs_trigger");
  level.player allowsprint(1);
  thread notetrack_watcher();
  var_4 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_4 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 5), &"SAFEHOUSE_FINALE_LOC/CONTROL_PAD", undefined, 700, 100, undefined, undefined, undefined, undefined, "duration_short");
  var_4 waittill("trigger");
  var_4 delete();
  var_1 delete();
  level notify("player_has_tablet");
  var_5 = getEnt("rc_door", "targetname");
  var_5.clip = var_5 scripts\engine\utility::get_target_ent();
  var_5.clip linkTo(var_5);
  var_6 = scripts\engine\utility::getStruct("rc_door_struct", "targetname");
  var_5.origin = var_6.origin + (-1, 2, 0);
  var_5.angles = var_6.angles;
  scripts\engine\utility::flag_set("player_has_tablet");
  thread scripts\engine\sp\utility::autosave_by_name("drone_control");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player playSound("scn_safehouse_pickup_remote");
  scripts\engine\utility::flag_wait("tablet_vo");
  level.player notifyonplayercommand("first_droneControl", "+actionslot 1");
  scripts\engine\sp\utility::display_hint_forced("drone_control", undefined, undefined, level.player, "first_droneControl");
  level.player wait_fly_drone();
  fake_drone_activation();
  var_2 scripts\common\ai::stop_magic_bullet_shield();
  var_3 scripts\common\ai::stop_magic_bullet_shield();
  var_2 delete();
  var_3 delete();
  var_7 = getaiarray("allies");
  scripts\engine\utility::array_delete(var_7);
}

bink_save_hack() {
  wait 10;
  scripts\engine\sp\utility::autosave_now_silent();
}

transient_loading() {
  scripts\engine\sp\utility::transient_load("safehouse_finale_town_tr");

  while(!istransientloaded("safehouse_finale_town_tr"))
    waitframe();

  scripts\engine\sp\utility::transient_load("safehouse_finale_fob_tr");
}

wait_fly_drone() {
  level.player endon("first_droneControl");
  wait 10;
  var_0 = [];
  var_0[var_0.size] = [level.farah, "dx_vom_far_safehouse_interior_planestart_60"];
  var_0[var_0.size] = [level.hadir, "dx_vom_had_safehouse_interior_planestart_70"];
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill("first_droneControl", var_0, 6, 2);
}

cinematic_bars_intro() {
  hidecinematicletterboxing(0, 0);
  wait 8;
  thread scripts\sp\introscreen::introscreen(1);
  getrandomnodedestination(2, 0);
}

safehouse_interior_catchup() {
  thread objective_manager();
}

player_movespeed() {
  thread scripts\sp\player::player_movement_state("creep");
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.7);
  level waittill("hadir_on_stairs");
  thread scripts\sp\player::player_movement_state("default");
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 6);
}

notetrack_watcher() {
  level waittill("tablet_vo");
  scripts\engine\utility::flag_set("tablet_vo");
}

scene_intro() {
  waitframe();
  level.player.behind_hadir = 0;
  level.hadir.second_idle = 1;
  level.hadir dontinterpolate();
  var_0 = scripts\engine\sp\utility::spawn_targetname("safehouse_hc_guy", 1);
  var_0.animname = "rebel";
  var_0 scripts\common\ai::gun_remove();
  var_0.allowdeath = 1;
  var_1 = getspawner("safehouse_hc_guy", "targetname");
  var_1.count = 1;
  var_2 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var_3 = getEnt("hc_door", "targetname");
  var_3.animname = "hc_door";
  var_3 scripts\engine\sp\utility::assign_animtree();
  var_4 = [var_2];
  var_5 = [level.hadir, var_0, var_2, var_3];
  var_6 = scripts\engine\utility::getStruct("intro_anim_struct", "targetname");
  level.player clearclienttriggeraudiozone(0.8);
  thread player_behind_hadir_watcher();
  thread intro_scene_player(var_6);
  thread safehouse_interior_mix();
  thread early_tank_guy(var_6);
  thread safehouse_outside_runners();
  thread intro_scene_mayhem();
  var_6 thread scripts\common\anim::anim_single(var_5, "intro_scene");
  level.hadir waittillmatch("single anim", "end");
  level notify("hadir_on_stairs");
  thread rooftop_actors(var_6);

  if(!scripts\engine\utility::flag("intro_player_behind_hadir")) {
    hadir_stair_idle_nag(var_6);
    var_6 notify("stop_loop");
    thread hadir_landing_clip();
    var_6 notify("stop_loop");
    var_6 thread scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_to_roof");
    level.hadir waittillmatch("single anim", "end");
  } else {
    thread hadir_landing_clip();
    var_6 thread scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_to_roof");
    level.hadir waittillmatch("single anim", "end");
  }

  var_6 thread scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_roof");
  level.hadir thread intro_actors_to_idle(var_6);
  level.hadir.name = "Hadir";
  thread hadir_table_clip();
  var_0 waittillmatch("single anim", "end");
  var_0 delete();
  var_2 delete();
}

hadir_landing_clip() {
  var_0 = getEnt("hadir_landing_clip", "targetname");
  var_0 delete();
}

hadir_table_clip() {
  level waittill("tablet_vo");
  var_0 = getEnt("hadir_table_clip", "targetname");
  var_0 delete();
}

rooftop_actors(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_anim_model("tablet_1");
  var_2 = scripts\engine\sp\utility::spawn_anim_model("tablet_2");
  var_3 = scripts\engine\sp\utility::spawn_anim_model("tablet_3");
  var_4 = scripts\engine\sp\utility::spawn_anim_model("rc_plane");
  playFXOnTag(level._effect["vfx_safehouse_finale_drone_wingtip_red_lit"], var_4, "tag_origin");
  var_1.second_idle = 1;
  var_2.second_idle = 1;
  level.farah.second_idle = 1;
  level.hadir.tablet = var_1;
  level.safehouse_yasim = scripts\engine\sp\utility::spawn_targetname("safehouse_yasim", 1);
  level.safehouse_yasim.animname = "yasim";
  level.safehouse_yasim.name = "Lina";
  level.safehouse_yasim scripts\common\ai::gun_remove();
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.safehouse_yasim, "intro_scene_roof");
  level waittill("start_scene_b");
  var_5 = [level.farah, level.safehouse_yasim, var_1, var_2, var_3];
  var_0 thread scripts\common\anim::anim_single_solo(var_4, "intro_scene_roof");
  var_0 thread scripts\common\anim::anim_single(var_5, "intro_scene_roof");
  scripts\engine\utility::array_thread(var_5, ::intro_actors_to_idle, var_0, var_1);
  level.player waittill("first_droneControl");
  wait 2;
  var_6 = [var_1, var_2, var_3, var_4];
  scripts\engine\utility::array_delete(var_6);
}

#using_animtree("generic_human");

intro_scene_mayhem() {
  level.hadir thread scene_mayhem(%shf_010_infil_scenea_hadir_face, "intro_mayhem_hadir_face", "intro_mayhem_hadir_face_off");
}

safehouse_outside_runners() {
  wait 14;
  var_0 = 0;

  while(var_0 < 4) {
    var_1 = spawn_check_func(undefined, "safehouse_outside_runners", 1);
    var_0++;
    scripts\engine\utility::array_thread(var_1, ::safehouse_outside_runners_behavior);
    wait(randomintrange(2, 3));
  }
}

safehouse_outside_runners_behavior() {
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\utility::set_movement_speed(120);
  self waittill("goal");
  self delete();
}

early_tank_guy(var_0) {
  waitframe();
  var_1 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var_2 = scripts\engine\sp\utility::spawn_targetname("safehouse_hc_guy", 1);
  var_2.animname = "rebel";
  var_2 scripts\common\ai::gun_remove();
  var_2.allowdeath = 1;
  var_3 = spawnStruct();
  var_3.origin = var_0.origin + (10, 0, 0);
  var_3.angles = var_0.angles;
  var_3 thread scripts\common\anim::anim_single_solo(var_1, "intro_scene");
  var_3 thread scripts\common\anim::anim_single_solo(var_2, "intro_scene_02");
  waitframe();
  var_1 setanimtime(var_1 scripts\engine\utility::getanim("intro_scene"), 0.5);
  var_2 setanimtime(var_2 scripts\engine\utility::getanim("intro_scene_02"), 0.5);
  wait 8;
  var_1 setanimrate(var_1 scripts\engine\utility::getanim("intro_scene"), 2);
  var_2 setanimrate(var_2 scripts\engine\utility::getanim("intro_scene_02"), 2);
  var_3.origin = var_0.origin + (20, 0, 0);
  var_3.origin = var_0.origin;
  wait 4;
  var_1 delete();
  var_2 delete();
}

intro_actors_to_idle(var_0, var_1) {
  self endon("death");
  self endon("entitydeleted");
  self waittillmatch("single anim", "end");
  var_2 = undefined;

  if(self == level.hadir) {
    var_2 = spawnStruct();
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
    level.hadir thread scripts\common\utility::lookatentity(level.player);
    scripts\engine\utility::flag_set("intro_dialogue_complete");
    hadir_tablet_idle_nag(var_0, var_2);
    var_2 notify("stop_loop");
    var_0 notify("stop_loop");
    var_0 scripts\common\anim::anim_single([level.hadir, level.hadir.tablet], "intro_scene_roof_exit");
    self waittillmatch("single anim", "end");
    var_0 thread scripts\common\anim::anim_loop([level.hadir, level.hadir.tablet], "intro_scene_roof_exit_idle", "stop_loop");
    return;
  }

  if(!scripts\engine\utility::is_equal(self, level.hadir.tablet) && self != level.hadir) {
    if(self == level.safehouse_yasim)
      var_0 thread scripts\common\anim::anim_loop_solo(self, "intro_scene_roof_idle", "yasim_stop");
    else
      var_0 thread scripts\common\anim::anim_loop_solo(self, "intro_scene_roof_idle", "stop_loop");
  }

  scripts\engine\utility::flag_wait("player_has_tablet");

  if(isDefined(level.hadir))
    level.hadir thread scripts\common\utility::lookatentity();

  var_0 notify("stop_loop");

  if(istrue(self.second_idle)) {
    var_0 notify("stop_loop");
    var_0 scripts\common\anim::anim_single_solo(self, "intro_scene_roof_exit");
    self waittillmatch("single anim", "end");
    var_0 thread scripts\common\anim::anim_loop_solo(self, "intro_scene_roof_exit_idle", "stop_loop");
  }
}

player_behind_hadir_watcher() {
  scripts\engine\sp\utility::trigger_wait_targetname("hadir_stairs_trigger");
  scripts\engine\utility::flag_set("intro_player_behind_hadir");
}

safehouse_interior_mix() {
  level.player setsoundsubmix("iw8_safehouse_interior");
  scripts\engine\sp\utility::trigger_wait_targetname("hadir_stairs_trigger");
  level.player clearsoundsubmix("iw8_safehouse_interior", 8);
}

hadir_stair_idle_nag(var_0) {
  var_0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_to_idle");
  level endon("intro_player_behind_hadir");

  for(;;) {
    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var_0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");
    wait 5;

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var_0 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planeintro_20");
    var_0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_nag1");
    var_0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    wait 10;

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var_0 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planeintro_30");
    var_0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_nag2");
    var_0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    wait 10;

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var_0 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planeintro_40");
    var_0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_nag2");

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var_0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");
    wait 10;
    var_0 notify("stop_loop");
  }
}

hadir_tablet_idle_nag(var_0, var_1) {
  level endon("player_has_tablet");

  if(scripts\engine\utility::flag("player_has_tablet")) {
    return;
  }
  var_2 = [level.hadir, level.hadir.tablet];

  for(;;) {
    var_1 thread scripts\common\anim::anim_loop(var_2, "intro_scene_roof_idle", "stop_loop");
    wait 5;
    var_1 notify("stop_loop");

    if(scripts\engine\utility::flag("player_has_tablet")) {
      return;
    }
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planestart_20");
    var_1 scripts\common\anim::anim_single(var_2, "intro_scene_roof_idle_nag1");
    var_1 thread scripts\common\anim::anim_loop(var_2, "intro_scene_roof_idle", "stop_loop");
    wait 10;
    var_1 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planestart_30");
    var_1 scripts\common\anim::anim_single(var_2, "intro_scene_roof_idle_nag1");
    var_1 thread scripts\common\anim::anim_loop(var_2, "intro_scene_roof_idle", "stop_loop");
    wait 10;
    var_1 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planestart_40");
    var_1 scripts\common\anim::anim_single(var_2, "intro_scene_roof_idle_nag1");
    var_1 thread scripts\common\anim::anim_loop(var_2, "intro_scene_roof_idle", "stop_loop");
    wait 10;
    var_1 notify("stop_loop");
  }
}

intro_scene_player(var_0) {
  level.molotov = scripts\engine\sp\utility::spawn_anim_model("molotov");
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  var_0 scripts\common\anim::anim_first_frame_solo(level.player.rig, "intro_scene");
  var_1 = level.player.rig scripts\engine\utility::getanim("intro_scene");
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1);
  level.player setOrigin(var_2);
  level.player setplayerangles(var_3);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::put_player_into_rig(level.player.rig, 0.05, 0, 0, 0, 0);
  var_0 scripts\common\anim::anim_single([level.player.rig, level.molotov], "intro_scene");
  level notify("enable_guns_intro");
  level.player enableweapons();
  wait 0.5;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.molotov delete();
  level.player.rig delete();
}

scene_intro_return() {
  waitframe();
  var_0 = scripts\engine\utility::getStruct("intro_anim_struct", "targetname");
  var_1 = [level.farah, level.hadir];
  level.farah.allowdeath = 1;
  level.hadir.allowdeath = 1;
  var_0 thread scripts\common\anim::anim_single(var_1, "intro_scene_roof_jump");
  waitframe();
  level.farah setanimtime(level.farah scripts\engine\utility::getanim("intro_scene_roof_jump"), 0.4);
  level.hadir setanimtime(level.hadir scripts\engine\utility::getanim("intro_scene_roof_jump"), 0.4);
  var_0 notify("stop_loop");
}

trigger_manager() {
  scripts\engine\utility::trigger_off("hc_meeting_trigger", "targetname");
  scripts\engine\utility::trigger_off("leaving_staging_trigger", "targetname");
  scripts\engine\utility::trigger_off("town_wall_trigger", "targetname");
  scripts\engine\utility::trigger_off("charge_drop_trigger", "targetname");
  scripts\engine\utility::trigger_off("bunkers_charged", "targetname");
  scripts\engine\utility::trigger_off("charge_playerExitTrigger", "targetname");
  level notify("rooftops_start");
  scripts\engine\utility::trigger_on("hc_meeting_trigger", "targetname");
  scripts\engine\utility::trigger_on("leaving_staging_trigger", "targetname");
  scripts\engine\utility::trigger_on("town_wall_trigger", "targetname");
  scripts\engine\utility::trigger_on("charge_drop_trigger", "targetname");
  scripts\engine\utility::trigger_on("bunkers_charged", "targetname");
  scripts\engine\utility::trigger_on("charge_playerExitTrigger", "targetname");
}

fake_drone_activation() {
  level.player.playeroriginalweapon = level.player.currentweapon;
  level.player giveweapon("ks_remote_device");
  level.player switchtoweapon("ks_remote_device");

  if(isDefined(level.player.currentweapon)) {
    if(isDefined(level.player.currentweapon.classname)) {
      if(level.player.currentweapon.classname == "mg") {
        wait 0.5;
        level.player playSound("scn_safehouse_use_remote");
      } else
        level.player playSound("scn_safehouse_use_remote");
    }
  }

  wait 1.2;
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_0 fadeovertime(0.25);
  var_0.alpha = 1;
  var_0 thread overlay_clear();
  wait 0.25;
}

overlay_clear() {
  wait 1.5;
  self fadeovertime(0.25);
  self.alpha = 0;
  scripts\engine\utility::delaycall(1.5, ::destroy);
}

rooftops_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  level.player.playeroriginalweapon = level.player.currentweapon;
  level.player giveweapon("ks_remote_device");
}

rooftops_main() {
  var_0 = getscriptablearray("tarmac_choppers", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2.origin = var_2.origin + (0, 0, -1000);
  }

  level.player setsoundsubmix("sp_npc_vehicles_down", 1.0, 1.0);
  setmusicstate("mx_safehouse_finale_attack");
  scripts\engine\utility::delaythread(1, ::sfx_airbase_alarm);
  thread hide_tarmac_trucks();
  var_4 = getEnt("roof_player_clip", "targetname");
  var_4 delete();
  thread oil_fires_init();
  thread dialogue_rooftops();
  thread dialogue_pre_charge();
  thread scene_intro_return();
  var_5 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::board_getallydronestartnodes();

  foreach(var_7 in var_5) {
    var_8 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::level_dronespawnVehicle(var_7.origin, var_7.angles);
    thread scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::fly_allydronepathlogic(var_8, var_7, 0);
  }

  scripts\engine\utility::exploder("tarmac_exploder");
  var_10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_10, ::hide);
  thread explode_tarmac_scriptables();
  var_11 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_12 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_13 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  level.player takeweapon("ks_remote_device");
  level.player switchtoweapon(level.player.playeroriginalweapon);
  var_11 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_12 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_11.allowdeath = 1;
  var_12.allowdeath = 1;
  var_12 scripts\common\utility::demeanor_override("combat");
  var_11 scripts\common\utility::demeanor_override("combat");

  if(istrue(level.fly_player_hit_helo))
    level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_fly_success_10");

  thread scripts\sp\analytics::analytics_kleenex_update("Rooftops to Bunkers");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  var_14 = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  var_15 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::ai_getaliveaiarray("axis");
  scripts\engine\utility::array_delete(var_15);

  if(isDefined(level.enemy_vehicles))
    scripts\engine\utility::array_delete(level.enemy_vehicles);

  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies();
  thread town_technical_01();
  thread hc_workers_scene();
  thread ally_town_movement();
  var_11 scripts\common\utility::demeanor_override("casual_gun");
  var_16 = charge_setalliestoredshirts();
  level.allies = getaiarray("allies");
  scripts\engine\sp\utility::autosave_by_name("town");
  scripts\engine\sp\utility::set_start_location("start_roofs", [level.player, var_11, var_12]);
  level notify("rooftops_start");
  var_14 fadeovertime(0.45);
  var_14.alpha = 0;
  wait 0.3;
  scripts\engine\utility::exploder("tarmac_exploder_01");
  scripts\engine\sp\utility::trigger_wait_targetname("hc_meeting_trigger");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  scripts\engine\sp\utility::trigger_wait_targetname("charge_enter_trigger");
  scripts\engine\utility::flag_set("pep_talk_trigger");
  scripts\engine\sp\utility::autosave_by_name("pep_talk");
  scripts\engine\utility::stop_exploder("tarmac_exploder");
  scripts\engine\utility::stop_exploder("tarmac_exploder_01");
  var_17 = getEnt("town_wall_trigger", "targetname");
}

hide_tarmac_trucks() {
  wait 0.2;
  var_0 = [];
  var_1 = getscriptablearray();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.model, "veh8_mil_lnd_tromeo_static_black_scr") || scripts\engine\utility::is_equal(var_3.model, "veh8_mil_lnd_umike_pickup_static_scr") || scripts\engine\utility::is_equal(var_3.model, "veh8_mil_air_lbravo_static_east_scr") || scripts\engine\utility::is_equal(var_3.model, "veh8_mil_lnd_mkilo23_no_tail_static_scr")) {
      if(scripts\engine\utility::is_equal(var_3.model, "veh8_mil_lnd_mkilo23_no_tail_static_scr") && var_3.origin[0] < -42000) {
        continue;
      }
      var_3.og_origin = var_3.origin;
      var_0[var_0.size] = var_3;
      var_3.origin = var_3.origin + (0, 0, -3600);
    }
  }

  scripts\engine\utility::flag_wait("air_support_inbound");

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_3.origin = var_3.og_origin;
  }
}

hide_tarmac_scriptables_until_apache() {
  wait 0.2;
  var_0 = [];
  var_1 = getscriptablearray("tarmac_hidden_scriptables", "targetname");

  foreach(var_3 in var_1) {
    var_3.og_origin = var_3.origin;
    var_0[var_0.size] = var_3;
    var_3.origin = var_3.origin + (0, 0, -3600);
  }

  scripts\engine\utility::flag_wait("air_support_inbound");

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_3.origin = var_3.og_origin;
  }

  var_7 = getEntArray("tarmac_hidden_models", "targetname");
  scripts\engine\utility::array_delete(var_7);
}

rooftops_catchup() {
  if(istrue(level.bink_start)) {
    return;
  }
  thread oil_fires_init();
  thread hide_old_tarmac_scriptables();
  thread hide_tarmac_trucks();
  scripts\engine\utility::flag_set("wall_approach_vo_finished");
}

hide_old_tarmac_scriptables() {
  wait 0.3;
  var_0 = getscriptablearray("tarmac_choppers", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2.origin = var_2.origin + (0, 0, -1000);
  }
}

hc_workers_scene() {
  level.hc_worker_01 = undefined;
  var_0 = getEntArray("hc_badplace", "targetname");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = createnavbadplacebyent(var_3, "allies");

  thread bad_place_remover(var_1[1]);
  var_5 = getspawnerarray("hc_Spawner");
  var_6 = undefined;
  var_7 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var_8 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var_8 hide();
  var_9 = [];

  foreach(var_11 in var_5) {
    if(scripts\engine\utility::is_equal(var_11.script_noteworthy, "firer")) {
      var_12 = scripts\engine\sp\utility::bodyonlyspawn(var_11);
      var_12 thread body_damage_watcher();
      var_12.animname = var_12.script_noteworthy;
      var_12.allowdeath = 1;
      var_9[var_9.size] = var_12;
      var_13 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
      continue;
    }

    if(scripts\engine\utility::is_equal(var_11.script_noteworthy, "loader")) {
      var_12 = scripts\engine\sp\utility::bodyonlyspawn(var_11);
      var_12 thread body_damage_watcher();
      var_6 = var_12;
      level.hc_worker_01 = var_6;
      var_12.animname = var_12.script_noteworthy;
      var_12.allowdeath = 1;
      var_9[var_9.size] = var_12;
      var_12 scripts\common\ai::gun_remove();
      continue;
    }

    var_12 = var_11 scripts\engine\sp\utility::spawn_ai(1);
  }

  var_15 = scripts\engine\utility::getStruct("hc_scene_struct", "targetname");
  var_15 thread scripts\common\anim::anim_loop(var_9, "cannon_idle", "stop_loop");
  var_15 thread scripts\common\anim::anim_first_frame_solo(var_7, "cannon_load");
  wait 1;
  var_15 notify("stop_loop");
  var_15 thread scripts\common\anim::anim_single_solo(var_7, "cannon_load");
  var_15 thread scripts\common\anim::anim_single(var_9, "cannon_load");
  var_6 waittillmatch("single anim", "end");
  var_15 thread scripts\common\anim::anim_loop(var_9, "cannon_idle", "stop_loop");
  scripts\engine\utility::flag_wait("pep_talk_trigger");
  var_8 show();
  var_15 thread scripts\common\anim::anim_first_frame_solo(var_8, "cannon_load");
  level waittill("hell_cannon_fire_move_tank");
  var_7 delete();
  var_15 notify("stop_loop");
  var_15 thread scripts\common\anim::anim_single_solo(var_8, "cannon_load");
  var_15 thread scripts\common\anim::anim_single(var_9, "cannon_load");
  waitframe();
  var_16 = scripts\engine\utility::array_add(var_9, var_8);

  foreach(var_3 in var_16)
  var_3 setanimrate(var_3 scripts\engine\utility::getanim("cannon_load"), 1.3);

  level waittill("hell_cannon_fire_move_tank");
  var_8 delete();
  var_6 waittillmatch("single anim", "end");
  var_15 thread scripts\common\anim::anim_loop(var_9, "cannon_idle", "stop_loop");
  scripts\engine\utility::flag_wait("bunkers_charged");
  scripts\engine\utility::array_delete(var_9);
}

body_damage_watcher() {
  self endon("entitydeleted");
  self endon("death");
  thread friendly_fire_grenade_think();
  scripts\engine\utility::waittill_any("damage", "bullethit");
  scripts\sp\friendlyfire::missionfail();
  self startragdoll();
}

friendly_fire_grenade_think() {
  self endon("entitydeleted");
  self endon("death");

  for(;;) {
    level.player waittill("grenade_fire", var_0, var_1);

    if(var_1.basename == "molotov") {
      var_0 waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6, var_7);

      if(distance2dsquared(var_6, self.origin) < squared(200))
        self notify("damage");
    }

    waitframe();
  }
}

bad_place_remover(var_0) {
  level waittill("technical_stopped");
  destroynavobstacle(var_0);
}

hell_cannon_intro_scene() {
  var_0 = scripts\engine\utility::getStruct("hc_scene_struct", "targetname");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("hc_Spawner", 1);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "firer")) {
      var_4.animname = var_4.script_noteworthy;
      var_2[var_2.size] = var_4;
    }

    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "loader")) {
      var_4.animname = var_4.script_noteworthy;
      var_2[var_2.size] = var_4;
      var_4 scripts\common\ai::gun_remove();
    }
  }

  var_0 = scripts\engine\utility::getStruct("hc_scene_struct", "targetname");
  var_0 thread scripts\common\anim::anim_loop(var_2, "cannon_idle", "stop_loop");
  var_6 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_6, "cannon_load");
  level.player waittill("first_droneControl");
  scripts\engine\utility::array_delete(var_1);
  var_6 delete();
}

ally_town_movement_bink() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  level.allies = getaiarray("allies");
  thread scripts\engine\utility::flag_set_delayed("alpha_00", 5);
  scripts\engine\utility::flag_set_delayed("delta_00", 2);
  scripts\engine\utility::flag_set_delayed("delta_01", 2);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  level.allies = getaiarray("allies");

  foreach(var_3 in level.allies) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "technical_dudes_01")) {
      continue;
    }
    if(isalive(var_3) && isDefined(var_3)) {
      if(var_3 == var_0 || var_3 == var_1) {
        continue;
      }
      var_3 scripts\engine\utility::set_movement_speed(200);
      var_3 scripts\engine\sp\utility::set_goal_radius(800);
      wait 0.2;
    }
  }
}

ally_town_movement() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  level.allies = getaiarray("allies");
  thread scripts\engine\utility::flag_set_delayed("alpha_00", 0.1);
  scripts\engine\utility::flag_set("delta_00");
  scripts\engine\utility::flag_set("delta_01");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  level.allies = getaiarray("allies");

  foreach(var_3 in level.allies) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "technical_dudes_01")) {
      continue;
    }
    if(isalive(var_3) && isDefined(var_3)) {
      if(var_3 == var_0 || var_3 == var_1) {
        continue;
      }
      var_3 scripts\engine\utility::set_movement_speed(160);
      wait 0.1;
    }
  }

  wait 1;
  var_0 scripts\common\utility::demeanor_override("combat");
  var_0 scripts\engine\sp\utility::set_force_color("p");
  var_0 scripts\engine\utility::set_movement_speed(170);
  var_1 scripts\engine\sp\utility::set_force_color("g");
  var_1 scripts\engine\utility::set_movement_speed(170);
  scripts\engine\sp\utility::trigger_wait_targetname("hc_meeting_trigger");
  var_0 scripts\engine\utility::set_movement_speed(160);
  scripts\engine\sp\utility::activate_trigger_with_targetname("farah_river_mounds_color_trigger");
  thread scene_pep_talk();
  thread scripts\engine\utility::flag_set_delayed("beta_00", 2);
  scripts\engine\utility::flag_set("alpha_01");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_wall_color_trigger");
  scripts\engine\sp\utility::trigger_wait_targetname("leaving_staging_trigger");
  scripts\engine\utility::flag_set_delayed("charlie_00", 1);
  scripts\engine\sp\utility::trigger_wait_targetname("town_wall_trigger");
  scripts\engine\utility::flag_set_delayed("charlie_01", 1);
  level.allies = getaiarray("allies");

  foreach(var_3 in level.allies) {
    if(isalive(var_3) && isDefined(var_3)) {
      var_3 scripts\engine\utility::set_movement_speed(170);
      wait 0.2;
    }
  }
}

scene_pep_talk(var_0) {
  thread pep_talk_breakout();
  wait 0.5;
  level endon("early_charge");
  level.farah scripts\engine\sp\utility::clear_force_color();
  level.farah clearpath();
  level.peptalk_counter = 0;
  level.allies = getaiarray("allies");
  level.wall_actors = [level.armen];

  foreach(var_2 in level.allies) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "actors"))
      level.wall_actors[level.wall_actors.size] = var_2;
  }

  foreach(var_5, var_2 in level.wall_actors) {
    var_2 clearpath();
    var_2 scripts\engine\sp\utility::set_goal_radius(32);
    var_2 scripts\engine\sp\utility::clear_force_color();
    var_2.animname = "rebel_" + (var_5 + 1);
  }

  var_6 = getnode("precharge_farah_path", "targetname");
  level.farah scripts\engine\sp\utility::set_goal_radius(32);
  level.farah setgoalpos(var_6.origin);
  scripts\engine\utility::array_thread(level.wall_actors, ::pep_talk_reach_and_idle);

  while(level.peptalk_counter < 4)
    waitframe();

  scripts\engine\utility::flag_wait("wall_approach_vo_finished");
  var_7 = ["dx_vom_far_rooftop_moveup_r_30", "dx_vom_far_rooftop_moveup_r_40", "dx_vom_far_rooftop_moveup_r_50"];
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill_delayed(8, "pep_talk_trigger", var_7);
  var_8 = scripts\engine\utility::getStruct("pep_talk_struct", "targetname");
  level notify("pep_talk_start");
  var_8 scripts\sp\anim::anim_reach_solo(level.farah, "peptalk_intro");
  scripts\engine\utility::flag_set("farah_pep_talking");
  var_8 scripts\common\anim::anim_single_solo(level.farah, "peptalk_intro");
  scripts\engine\utility::flag_set("reached_pep_idle");
  var_8 thread scripts\common\anim::anim_loop_solo(level.farah, "peptalk_idle", "stop_loop");
  level waittill("pep_talk_complete");
  var_8 scripts\common\anim::anim_single_solo(level.farah, "peptalk_exit");
}

pep_talk_breakout() {
  level endon("pep_talk_complete");
  scripts\engine\utility::flag_wait("early_charge");
  level.farah stopanimScripted();
  level.farah clearpath();
  level.farah setgoalpos(level.farah.origin);
}

pep_talk_reach_and_idle() {
  var_0 = scripts\engine\utility::getStruct("pep_talk_struct", "targetname");
  thread anim_reach_failsafe_go(15, var_0, "peptalk_intro");
  thread ally_pep_talk_breakout();
  var_0 scripts\sp\anim::anim_reach_solo(self, "peptalk_intro");

  if(scripts\engine\utility::flag("early_charge")) {
    return;
  }
  var_0 thread scripts\common\anim::anim_loop_solo(self, "peptalk_idle", "stop_loop");
  level endon("early_charge");
  level.peptalk_counter++;
  level waittill("pep_talk_start");
  var_0 notify("stop_loop");
  waitframe();
  var_0 scripts\common\anim::anim_single_solo(self, "peptalk_intro");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "peptalk_idle", "stop_loop");
  level scripts\engine\utility::waittill_any("pep_talk_complete", "early_charge");
  var_0 notify("stop_loop");
  var_0 scripts\common\anim::anim_single_solo(self, "peptalk_exit");
}

anim_reach_failsafe_go(var_0, var_1, var_2) {
  self endon("anim_reached");
  self endon("death");
  wait(var_0);
  var_3 = scripts\engine\utility::getanim(var_2);
  var_4 = getstartorigin(var_1.origin, var_1.angles, var_3);
  var_5 = getstartangles(var_1.angles, var_1.angles, var_3);
  self forceteleport(var_4, var_5);
}

ally_pep_talk_breakout() {
  level endon("pep_talk_complete");
  scripts\engine\utility::flag_wait("early_charge");
  self stopanimScripted();
  self clearpath();
  self setgoalpos(self.origin);
}

pre_charge_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("start_river", [level.player, var_0, var_1]);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies();
  scripts\engine\utility::array_thread(var_3, ::ally_start_at_end);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_wall_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("farah_river_mounds_color_trigger");
  var_4 = charge_setalliestoredshirts();
  var_5 = scripts\engine\sp\utility::array_spawn_targetname("technical_dudes_01");
  level notify("technical_stopped");
  level.allies = getaiarray("allies");
  scripts\engine\utility::array_thread(var_5, ::jump_technical_dudes);
  var_0 scripts\engine\utility::set_movement_speed(150);
  var_1 scripts\engine\sp\utility::clear_force_color();
  var_1 scripts\engine\sp\utility::set_force_color("g");
  thread sfx_airbase_alarm();
  thread scene_pep_talk(1);
  thread dialogue_pre_charge();
  scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::activate_trigger_with_targetname, "charge_enter_trigger");
  scripts\engine\utility::flag_set("pep_talk_trigger");
}

pre_charge_main() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  thread river_enter_watcher();
  thread player_early_shot_watcher();
  thread pre_charge_wall_guys();
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("pre_charge_enemySpawner", 1);

  for(var_3 = 0; var_3 < 2; var_3++)
    var_2[var_3] thread pre_charge_wall_anims(var_3);

  var_4 = scripts\engine\sp\utility::spawn_targetname("tower_guy_charge");
  var_4.dropweapon = 0;
  var_4 allowedstances("stand");
  var_2[var_2.size] = var_4;
  scripts\engine\utility::array_thread(var_2, ::charge_enemy_behavior);
  level scripts\engine\utility::waittill_any("pep_talk_complete", "early_charge");
  level notify("farah_HC_command");
  wait 2;
  thread scripts\engine\utility::flag_set_delayed("bunker_busted", 2.5);
  thread hellcannon_first_strike(var_4);
}

pre_charge_wall_anims(var_0) {
  level endon("early_charge");
  self endon("death");
  self.animname = "enemy_01";
  var_1 = "lookaround_05";
  self.allowdeath = 1;

  if(var_0 != 0)
    var_1 = "lookaround_04";

  scripts\common\anim::anim_single_solo(self, var_1);
  scripts\common\anim::anim_single_solo(self, var_1);
}

trailer_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("start_river", [level.player, var_0, var_1]);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies();
  scripts\engine\utility::array_thread(var_3, ::ally_start_at_end);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_wall_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("farah_river_mounds_color_trigger");
  var_4 = charge_setalliestoredshirts();
  var_5 = scripts\engine\sp\utility::array_spawn_targetname("technical_dudes_01");
  level notify("technical_stopped");
  level.allies = getaiarray("allies");
  scripts\engine\utility::array_thread(var_5, ::jump_technical_dudes);
  var_0 scripts\engine\utility::set_movement_speed(150);
  var_1 scripts\engine\sp\utility::clear_force_color();
  var_1 scripts\engine\sp\utility::set_force_color("g");
  thread dialogue_pre_charge();
  scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::activate_trigger_with_targetname, "charge_enter_trigger");
  scripts\engine\utility::flag_set("pep_talk_trigger");
}

jump_technical_dudes() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(self.origin);
  self clearpath();
  scripts\engine\sp\utility::clear_force_color();
  scripts\engine\sp\utility::set_force_color("r");
}

ally_start_at_end() {
  if(scripts\engine\utility::is_equal(self.script_noteworthy, "actors") || scripts\engine\utility::is_equal(self.script_noteworthy, "armen") || scripts\engine\utility::is_equal(self.script_noteworthy, "farah")) {
    var_0 = (-32811, 30890, -711.149);
    self forceteleport(var_0, (0, 180, 0));
    self setgoalpos(self.origin);
    return;
  }

  var_1 = scripts\engine\utility::get_target_ent();
  var_2 = var_1 scripts\engine\sp\utility::get_last_ent_in_chain("pathnode");
  scripts\engine\sp\utility::teleport_ai(var_2);
}

hellcannon_first_strike(var_0) {
  var_1 = spawnStruct();
  var_1.origin = (-35920, 32944, -552);
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::explosion_gethellcannonstructs();
  level notify("hell_cannon_fire_move_tank");
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_hellcannonfire(var_2[0], var_1, 3.5);
  var_3 = scripts\engine\utility::getStructArray("explosion_hellCannonTargetStruct", "targetname");
  playFX(scripts\engine\utility::getfx("vfx_safehouse_lingering_smoke"), var_1.origin + (-100, 0, -50));
  scripts\engine\utility::exploder("explo_01");
  kill_perimeter_lights();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_showdamagedtargets();
  wait 0.2;
  earthquake(0.5, 1.35, var_1.origin, 9999);
  scripts\engine\utility::flag_set("second_cannon");
  var_4 = getaiarray("axis");

  if(isDefined(var_0))
    var_4 = scripts\engine\utility::array_remove(var_4, var_0);

  scripts\engine\utility::array_delete(var_4);
  thread cleanup_corpses();
}

cleanup_corpses() {
  var_0 = getcorpsearrayinradius((-35866, 32948, -488), 200);

  foreach(var_2 in var_0)
  var_2 delete();
}

charge_enemy_behavior() {
  level endon("farah_HC_command");
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\engine\utility::flag_wait("early_charge");
  self.ignoreme = 0;
  self.ignoreall = 0;
}

player_early_shot_watcher() {
  level endon("reached_pep_idle");
  var_0 = ["dx_vom_far_pre_charge_setup_200", "dx_vom_far_pre_charge_setup_220", "dx_vom_far_pre_charge_setup_210"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  level.player waittill("weapon_fired");
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2)
  var_4.ignoreall = 0;

  level.farah stopsounds();
  waitframe();
  wait 1;
  level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw_specific("dx_vom_far_pre_charge_setup_210"));
  scripts\engine\utility::flag_set("early_charge");
}

get_to_charge() {
  var_0 = scripts\engine\utility::getStruct("pep_talk_struct", "targetname");
  var_0 scripts\sp\anim::anim_reach_solo(level.farah, "peptalk_exit");
  thread dialogue_pre_charge_fire_cannon();
  var_0 thread scripts\common\anim::anim_single_solo(level.farah, "peptalk_exit");
}

kill_perimeter_lights() {
  var_0 = getscriptablearray("perimeter_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("onoff", "off");

  return;
}

pre_charge_wall_guys() {
  var_0 = spawn_check_func(undefined, "pre_charge_wallSpawner", 2);
  wait 0.5;
  var_0 = spawn_check_func(undefined, "pre_charge_wallSpawner", 1);
  var_1 = 0;
  wait 3;
  var_2 = scripts\engine\utility::getStruct("wall_general", "targetname");
  var_2.origin = var_2.origin + (40, 0, 5);
  var_3 = spawn_check_func(undefined, "pre_charge_wallSpawner", 1)[0];
  var_3.animname = "enemy_00";
  var_3.general = 1;
  var_3 clearpath();
  var_3.target = undefined;
  var_3.allowdeath = 1;
  var_3 endon("death");
  var_2 scripts\sp\anim::anim_reach_solo(var_3, "directing_01");
  var_2 scripts\common\anim::anim_single_solo(var_3, "directing_01");
  var_3 allowedstances("prone");
  wait 3;
  var_3 delete();
}

charge_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  scripts\engine\utility::flag_set("bunker_busted");
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_showdamagedtargets();
  thread river_enter_watcher();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  var_1 scripts\engine\sp\utility::clear_force_color();
  var_1 scripts\engine\sp\utility::set_force_color("g");
  scripts\engine\sp\utility::set_start_location("start_river", [level.player, var_0, var_1]);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies();
  scripts\engine\utility::array_thread(var_3, ::ally_start_at_end);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_wall_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("farah_river_mounds_color_trigger");
  var_4 = charge_setalliestoredshirts();
  var_5 = scripts\engine\sp\utility::array_spawn_targetname("technical_dudes_01");
  level notify("technical_stopped");
  level.allies = getaiarray("allies");
  scripts\engine\utility::array_thread(var_5, ::jump_technical_dudes);
  thread sfx_airbase_alarm();
  scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::activate_trigger_with_targetname, "charge_enter_trigger");
}

charge_main() {
  thread dialogue_charge();
  thread bunkers_enter_watcher();
  var_0 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_0, ::delete);
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_setnotsolidtargets();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  scripts\engine\utility::flag_wait("bunker_busted");
  thread vo_walla_charge();
  thread run_dialogue();
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.9);
  level.player scripts\common\utility::allow_death(0);
  scripts\engine\utility::delaythread(0.1, ::charge_redshirtssfxlogic);
  wait 1;
  var_2 scripts\engine\sp\utility::clear_force_color();

  if(!scripts\engine\utility::flag("early_charge"))
    scripts\engine\sp\utility::autosave_by_name("charge");

  fob_post_load_inits();
  var_3 = getaiarray("allies");
  var_4 = getEntArray("hc_Spawner", "targetname");
  var_3 = scripts\engine\utility::array_remove_array(var_3, var_4);
  level.player clearsoundsubmix("sp_npc_vehicles_down", 15.0);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::array_removedeaddyingorundefined(var_3);
  var_3 = sortbydistance(var_3, level.player.origin);
  var_5 = charge_getallypaths();
  var_1 scripts\engine\utility::set_movement_speed(180);
  var_6 = [var_2];
  var_7 = sortbydistance(var_3, (-33524, 31042, -684))[0];

  foreach(var_9 in var_3) {
    var_9 scripts\common\utility::demeanor_override("combat");

    if(istrue(level.trailer) && scripts\engine\utility::is_equal(var_9.script_noteworthy, "charge_right")) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_9.script_noteworthy, "gunners")) {
      var_9 scripts\engine\sp\utility::set_force_color("y");
      var_6[var_6.size] = var_9;
      continue;
    }

    var_10 = 0;

    if(var_7 == var_9)
      var_10 = 2;

    var_11 = sortbydistance(var_5, var_9.origin)[0];
    thread charge_allypathlogic(var_9, var_11, undefined, var_10);
    var_5 = scripts\engine\utility::array_remove(var_5, var_11);
    var_9 scripts\engine\utility::set_movement_speed(220);
    var_9 thread charge_ally_variable_speed();
    var_9 thread ignore_until_fob();
  }

  wait 1;
  scripts\engine\sp\utility::activate_trigger_with_targetname("charge_cover_color_trigger");
  wait 2;
  scripts\engine\sp\utility::activate_trigger_with_targetname("bunkers_color_trigger");
  var_13 = scripts\engine\sp\utility::array_spawn_targetname("charge_enemySpawner", 1);
  var_13[0].baseaccuracy = 0.1;
  var_13[0] scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var_14 = getaiarray("axis");

  foreach(var_16 in var_14) {
    var_16.grenadeammo = 0;
    var_16.ignoreall = 0;
    var_16.ignoreme = 0;
  }

  wait 1;
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 2);
  wait 1;
  level notify("hell_cannon_fire");
  wait 0.35;
  var_18 = spawnStruct();
  var_18.origin = (-36120, 33599, -585);
  level notify("hell_cannon_fire_move_tank");
  var_19 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::explosion_gethellcannonstructs();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_hellcannonfire(var_19[0], var_18, 4);
  var_20 = getEntArray("perimeter_tower_lights", "targetname");

  foreach(var_22 in var_20)
  var_22 setlightintensity(0);

  level.player scripts\engine\utility::delaycall(0.2, ::playrumbleonentity, "damage_heavy");
  screenshake(var_18.origin, 20, 2, 4, 0.75, 0, 0.5, 1500, 5, 50, 50);
  var_24 = getscriptablearray("guard_tower", "script_noteworthy");
  var_24 = sortbydistance(var_24, var_18.origin);
  scripts\engine\utility::exploder("bunk_am");
  magicbullet("iw8_la_rpapa7_straight", var_24[0].origin + (0, 0, 500), var_24[0].origin, level.player);
  var_25 = getaiarray("axis");

  foreach(var_16 in var_25)
  var_16 kill(var_18.origin, level.player, level.player, "MOD_EXPLOSIVE");

  var_25 = getaiarray("allies");
  scripts\engine\utility::array_thread(var_25, ::hell_cannon_reactions, var_18);
  var_28 = spawn_check_func(32, "fob_front_guys");
  var_25 = getaiarray("axis");

  foreach(var_16 in var_25)
  var_16 scripts\common\ai::magic_bullet_shield();

  scripts\engine\utility::flag_wait("bunkers_charged");
  scripts\engine\sp\utility::autosave_by_name("bunkers_charged");
  scripts\engine\utility::flag_wait("player_exited_river");
  thread scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::ammo_count();
  wait 3;

  foreach(var_16 in var_25)
  var_16 scripts\common\ai::stop_magic_bullet_shield();

  level.player scripts\common\utility::allow_death(1);
  thread ally_equipment_watcher();
}

run_dialogue() {
  wait 4.5;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_charge_go_30");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_charge_go_20");
  var_0 = spawn("script_origin", (-35745, 32645, -465));
  var_0 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_rcom_pre_charge_setup_50");
  var_0 scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_rcom_pre_charge_setup_60");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_charge_go_40");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_charge_run_50");
  wait 2;
  var_0 delete();
  var_0 = spawn("script_origin", (-36506, 33360, -329));
  var_0 scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_rcom_pre_charge_setup_70");
  var_0 delete();
}

bunkers_enter_watcher() {
  var_0 = charge_getplayerexittrigger();
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("player_exited_river");
}

vo_walla_charge() {
  wait 0.8;
  var_0 = spawn("script_origin", level.armen.origin);
  var_0 linkTo(level.armen);
  var_0 playSound("sh_walla_finale_charge", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

charge_catchup() {
  if(istrue(level.bink_start)) {
    return;
  }
  scripts\engine\utility::flag_set("fly_attack_done");
  thread ally_equipment_watcher();
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("bunker_busted");
  var_0 = getEntArray("truck_lights", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

hell_cannon_reactions(var_0) {
  scripts\engine\sp\utility::set_goal_radius(256);
  self endon("death");
  wait 0.2;

  if(distance2d(self.origin, var_0.origin) < 1500) {
    wait(randomfloatrange(0.05, 0.5));
    self endon("kill_pathing");
    self notify("stop_going_to_node");
    self clearpath();
    self setgoalpos(self.origin);
    self dodamage(1, var_0.origin, undefined, undefined, "MOD_RIFLE_BULLET");
    scripts\engine\sp\utility::set_goal_radius(256);
    scripts\engine\sp\utility::clear_force_color();
    scripts\engine\sp\utility::set_force_color("r");
    self enableavoidance(1, 1);
    self.disablearrivals = 0;
    self.disableexits = 0;
  }
}

charge_ally_variable_speed() {
  self endon("death");
  wait 2;

  for(;;) {
    var_0 = level.player getEye();
    var_1 = self getEye();
    var_2 = sighttracepassed(var_0, var_1, 0, level.player, 1);
    var_3 = 0.9948;

    if(var_2) {
      break;
    }

    wait 1;
  }

  scripts\engine\utility::set_movement_speed(180);
}

ally_equipment_watcher() {
  level.player endon("death");

  for(;;) {
    var_0 = level.player getammocount(getcompleteweaponname("molotov"));

    if(var_0 < 2) {
      break;
    }

    wait 0.5;
  }

  level.farah.support_equipment = 4;
  level.hadir.support_equipment = 4;
  level.player notify("ally_equipment_notify");
  level.player.ally_equipment_force_ping = 1;
  level.player waittill("equipment_given");
  waitframe();
  var_1 = [level.farah, level.hadir];

  foreach(var_3 in var_1) {
    if(var_3.support_equipment < 1)
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);

    var_3.support_equipment = 0;
    var_3 notify("remove_other_ai_hint");
  }

  for(;;) {
    var_0 = level.player getammocount(getcompleteweaponname("molotov"));

    if(var_0 < 2) {
      break;
    }

    wait 0.5;
  }

  foreach(var_3 in var_1)
  var_3.support_equipment = 4;

  level.player notify("ally_equipment_notify");
  level.player.ally_equipment_force_ping = 1;
}

rpg_guy_logic() {
  wait 2;
  var_0 = scripts\engine\sp\utility::spawn_targetname("charge_enemySpawner_rpg", 1);
  var_0 endon("death");
  var_0 scripts\engine\sp\utility::set_ignoresuppression(1);
  var_0 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  var_0 scripts\engine\sp\utility::set_goal_radius(32);
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0.attackeraccuracy = 0;
  var_0 allowedstances("stand");
  var_0 scripts\anim\shared.gsc::forceuseweapon("iw8_la_rpapa7_straight", "primary");
  var_1 = scripts\engine\utility::getStruct("charge_distance_struct", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin + (200, -200, -15), var_1.angles);
  var_0 waittill("goal");
  wait 3;
  var_0.ignoreall = 0;

  for(;;) {
    var_3 = getaiarray("allies");
    var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::array_removedeaddyingorundefined(var_3);
    var_3 = sortbydistance(var_3, var_1.origin);
    var_0 setentitytarget(var_2);
    wait 0.2;
  }
}

river_enter_watcher() {
  var_0 = ["dx_vom_far_pre_charge_setup_230", "dx_vom_far_pre_charge_setup_250", "dx_vom_far_pre_charge_setup_240"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  level.player.ignoreme = 1;
  scripts\engine\utility::flag_wait("player_dropped_in");
  level.player.ignoreme = 0;
  var_2 = getEnt("charge_enter_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("charge_enter", var_2, 1);

  if(scripts\engine\utility::flag("bunker_busted")) {
    return;
  }
  level.farah stopsounds();
  waitframe();

  while(!scripts\engine\utility::flag("bunker_busted")) {
    if(istrue(check_stay_in_river(var_1))) {
      break;
    }

    level.player.ignoreme = 1;
    scripts\engine\utility::flag_wait("player_dropped_in");
    level.player.ignoreme = 0;

    if(scripts\engine\utility::flag("bunker_busted")) {
      return;
    }
    level.farah stopsounds();
    waitframe();
  }

  if(isalive(level.player))
    level thread check_stay_in_river(var_1);

  wait 1;
  scripts\engine\utility::flag_set("early_charge");
}

check_stay_in_river(var_0) {
  if(scripts\engine\utility::flag("charge_enter") || scripts\engine\utility::flag("reached_pep_idle"))
    return 0;

  level endon("bunker_busted");
  level.farah scripts\engine\sp\utility::smart_dialogue(var_0 scripts\engine\sp\utility::deck_draw());
  wait 1.2;
  level.farah scripts\engine\sp\utility::smart_dialogue(var_0 scripts\engine\sp\utility::deck_draw());
  wait 0.8;
  var_1 = (-35695, 33793, -258);
  magicbullet("iw8_lm_pkilo", var_1, level.player.origin + (0, 0, 40));
  level.player waittill("damage");
  level.player kill();
  return 1;
}

ignore_until_fob() {
  if(self == level.hadir || self == level.farah)
    self.ignoreme = 1;

  self endon("death");
  self.attackeraccuracy = 1;
  var_0 = charge_getplayerexittrigger();

  while(!self istouching(var_0))
    waitframe();

  self enableavoidance(0, 0);
  wait 0.1;

  while(self istouching(var_0))
    waitframe();

  if(self == level.hadir || self == level.farah)
    self.ignoreme = 0;

  self.attackeraccuracy = 0.2;
  self notify("charge_clear_paths");
  self notify("stop_going_to_node");
  scripts\engine\sp\utility::clear_force_color();
  scripts\engine\sp\utility::set_force_color("r");
  wait 2;
  self.ignoreall = 0;
  self enableavoidance(1, 1);
}

charge_getplayerexittrigger() {
  return getEnt("charge_playerExitTrigger", "targetname");
}

charge_allypathlogic(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    wait(var_3);

  var_0 endon("death");
  var_0 scripts\engine\sp\utility::set_goalRadius(64);
  var_0 scripts\engine\utility::set_cautious_navigation(0);
  var_0.disablearrivals = 1;
  var_0.disableexits = 1;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::ai_movealongpath(var_0, var_1);
  var_0.disablearrivals = 0;
  var_0.disableexits = 0;

  if(isDefined(var_2))
    var_0 scripts\engine\sp\utility::set_force_color("r");
}

charge_getallypaths() {
  return getnodearray("charge_allyPath", "targetname");
}

container_getallypaths() {
  return getnodearray("gate_allyPath", "targetname");
}

charge_setalliestoredshirts() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::getallies();

  foreach(var_2 in var_0) {
    var_2.targetname = "charge_redShirt";
    var_2 visiblesolid();
    var_2.baseaccuracy = 0.1;
    var_2.health = 40;
    var_2.script_longdeath = 1;
  }

  return var_0;
}

charge_redshirtssfxlogic() {
  var_0 = ["dx_vom_lf3_fob_center_helos_190", "dx_vom_had_containers_heliattack_140"];
  var_1 = 3.2;
  var_2 = 3.3;
  var_3 = randomfloatrange(var_1, var_2);
  wait(var_3);
  var_4 = 0.05;
  var_5 = 0.15;
  var_6 = charge_getredshirts();

  foreach(var_8 in var_6) {
    var_9 = scripts\engine\utility::random(var_0);
    var_8 playSound(var_9);
    var_10 = randomfloatrange(var_4, var_5);
  }
}

charge_getredshirts() {
  return getEntArray("charge_redShirt", "targetname");
}

bunkers_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("bunkers_breached");
  scripts\engine\utility::flag_set("fob_truck_entrance");
  scripts\engine\utility::flag_set("fly_attack_done");
  scripts\engine\sp\utility::set_start_location("tent_city_start", [level.player]);
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_showdamagedtargets();
  thread sfx_airbase_alarm();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(10);
  var_4 = charge_setalliestoredshirts();
  var_5 = bunker_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var_4, [var_0, var_1, var_2]);

  foreach(var_7 in level.allies) {
    var_8 = scripts\engine\utility::random(var_5);
    var_7 scripts\engine\sp\utility::teleport_ai(var_8);
    var_5 = scripts\engine\utility::array_remove(var_5, var_8);
  }

  var_10 = spawn_check_func(32, "fob_front_guys");

  foreach(var_12 in var_10)
  var_12.grenadeammo = 0;

  var_14 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_14, ::delete);
}

bunkers_main() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  thread chu_bad_places();
  thread scripts\sp\analytics::analytics_kleenex_update("Bunkers to Containers");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  thread ally_fob_movement();
  thread molotov_hint_flash();
  thread armory_01();
  scripts\engine\utility::flag_wait("bunkers_breached");
  level.player.ignoreme = 0;
  thread bunkers_kill_allies();
  thread dialogue_fob_bunkers();
  wait 1;
  var_2 = spawn_check_func(32, "fob_front_guys_2");

  foreach(var_4 in var_2)
  var_4.grenadeammo = 0;

  var_6 = getaiarray("axis");
  thread enemies_cleared_move_forward(var_6);
  scripts\engine\sp\utility::autosave_by_name("bunkers_breached");
  scripts\engine\utility::flag_wait("fob_center");
  scripts\engine\sp\utility::autosave_by_name("fob_center");
  var_6 = scripts\engine\utility::array_removedead_or_dying(var_6);
  var_7 = getEnt("fob_center_pit_vol", "targetname");

  foreach(var_4 in var_6)
  var_4 setgoalvolumeauto(var_7);
}

bunkers_kill_allies() {
  var_0 = getEntArray("hc_Spawner", "targetname");
  thread scripts\engine\utility::array_delete(var_0);
  var_1 = getaiarray("allies");
  var_2 = [level.farah, level.hadir, level.armen];
  var_1 = scripts\engine\utility::array_remove_array(var_1, var_2);
  level endon("fob_center_entrance");
  level endon("bunkers_push");

  while(var_1.size > 8) {
    var_1 = scripts\engine\utility::array_removedead_or_dying(var_1);
    var_1 = sortbydistance(var_1, level.player.origin);
    var_3 = var_1.size - 1;
    var_4 = var_1[var_3];
    var_5 = level.player getEye();
    var_6 = var_4 getEye();
    var_7 = sighttracepassed(var_5, var_6, 0, level.player, 1);
    var_8 = 0.707;

    if(!var_7)
      var_4 kill();

    wait 1;
  }
}

armory_01() {
  thread chu_bad_places_armory();
  thread ally_armory_guards();
  thread armory_01_nag();
  thread dialogue_armory_01();
  thread battle_chatter_armory_01();
  scripts\engine\utility::flag_wait("fob_exit");
  level.enemy_armory_guards = scripts\engine\sp\utility::array_spawn_targetname("armory_guards");
  thread armory_guards_anims();
  level.armory_guards_ignored = 1;
  scripts\engine\utility::array_thread(level.enemy_armory_guards, ::enemy_armory_guards_ignored);
  scripts\engine\sp\utility::trigger_wait_targetname("armory_01_trigger");
  scripts\engine\utility::flag_set("armory_01_trigger");
  thread tromeo_cleanup();
  var_0 = spawnStruct();
  var_0.origin = (-40170, 34500, -650);
  var_0.angles = (0, 0, 0);
  level.gate_truck = scripts\engine\sp\utility::spawn_anim_model("gate_truck");
  var_1 = getEnt("airport_gate", "targetname");
  var_1.animname = "gate";
  var_1 scripts\engine\sp\utility::assign_animtree();
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.gate_truck, "truck_enter");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, "truck_smash");
  level.gate_truck thread anim_gate_truck_lights();
  var_2 = getEnt("truck_smash_clip", "targetname");
  var_2 show();
  var_2 linkTo(level.gate_truck);
  var_2 disconnectPaths();
  level.armory_guards_ignored = 0;

  while(level.enemy_armory_guards.size > 0) {
    level.enemy_armory_guards = scripts\engine\utility::array_removedead_or_dying(level.enemy_armory_guards);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("armory_01_secure");
}

tromeo_cleanup() {
  var_0 = scripts\engine\sp\utility::getvehiclearray();
  var_1 = 700;
  var_2 = (-40649, 34632, -636);

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::is_equal(var_4.model, "veh8_mil_lnd_tromeo_black") || scripts\engine\utility::is_equal(var_4.model, "veh8_mil_lnd_tromeo_static_dst_black")) {
      if(var_1 > distance(var_2, var_4.origin))
        var_4 delete();
    }
  }
}

battle_chatter_armory_01() {
  level endon("armory_01_secure");
  scripts\engine\utility::flag_wait("fob_cleared");

  if(!scripts\engine\utility::flag("armory_01_secure")) {
    scripts\engine\sp\utility::battlechatter_off("allies");
    scripts\engine\utility::flag_wait("armory_01_secure");
    scripts\engine\sp\utility::battlechatter_on("allies");
  }
}

ammo_box_lids() {
  if(!scripts\engine\utility::is_equal(self.script_noteworthy, "ammo")) {
    return;
  }
  var_0 = scripts\engine\utility::get_linked_ent();
  self waittill("offhand_box_used");
  wait 0.2;
  var_0.struct_01 = var_0 scripts\engine\utility::get_target_ent();
  var_0.struct_02 = var_0.struct_01 scripts\engine\utility::get_target_ent();
  var_0 moveTo(var_0.struct_01.origin, 0.3);
  var_0 rotateTo(var_0.struct_01.angles, 0.3);
  wait 0.2;
  var_0 moveTo(var_0.struct_02.origin, 0.15);
  var_0 rotateTo(var_0.struct_02.angles, 0.15);
}

anim_gate_truck_lights() {
  var_0 = getEntArray("gate_truck_lights", "targetname");
  waitframe();
  var_1 = 2;

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "left")) {
      var_3.origin = self gettagorigin("tag_light_front_left");
      var_3.origin = var_3.origin + anglestoright(var_3.angles) * var_1;
      var_3.angles = self gettagangles("tag_light_front_left");
      var_3 linkTo(self, "tag_light_front_left");
    }

    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "right")) {
      var_3.origin = self gettagorigin("tag_light_front_right");
      var_3.origin = var_3.origin + anglestoright(var_3.angles) * var_1;
      var_3.angles = self gettagangles("tag_light_front_right");
      var_3 linkTo(self, "tag_light_front_right");
    }
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_left_container"), self, "tag_light_front_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_right_container"), self, "tag_light_front_right");
  scripts\engine\utility::flag_wait("chu_entrance");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_left_container"), self, "tag_light_front_left");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_right_container"), self, "tag_light_front_right");

  foreach(var_3 in var_0)
  var_3 setlightintensity(0);
}

armory_guards_anims() {
  var_0 = spawnStruct();
  var_0.origin = (-40269, 34936, -607);
  var_0.angles = (0, 90, 0);

  foreach(var_2 in level.enemy_armory_guards) {
    if(var_2 == level.enemy_armory_guards[0])
      var_2.animname = "enemy_01";
    else
      var_2.animname = "enemy_02";

    var_2.allowdeath = 1;
    var_2 endon("death");
  }

  scripts\engine\utility::array_thread(level.enemy_armory_guards, ::armory_guard_death_watcher);
  scripts\engine\utility::array_thread(level.enemy_armory_guards, ::armory_guard_breakout);
  var_0 thread scripts\common\anim::anim_single(level.enemy_armory_guards, "armory_surprise_toss");
  waitframe();

  foreach(var_2 in level.enemy_armory_guards) {
    var_2 setanimtime(var_2 scripts\engine\utility::getanim("armory_surprise_toss"), 0.27);
    var_2 setanimrate(var_2 scripts\engine\utility::getanim("armory_surprise_toss"), 0);
  }

  thread armory_01_anim_start();
  var_6 = (-40245, 34873, -574);

  while(!sighttracepassed(level.player getEye(), var_6, 0, level.player)) {
    if(level.player.cansee_armory) {
      break;
    }

    wait 0.1;
  }

  level notify("shut_down_armory_breakout");

  foreach(var_2 in level.enemy_armory_guards) {
    if(isDefined(var_2))
      var_2 setanimrate(var_2 scripts\engine\utility::getanim("armory_surprise_toss"), 1);
  }
}

armory_01_anim_start() {
  level.player.cansee_armory = 0;
  scripts\engine\sp\utility::trigger_wait_targetname("armory_01_trigger");
  level.player.cansee_armory = 1;
}

armory_guard_death_watcher() {
  level endon("shut_down_armory_breakout");

  while(isalive(self))
    waitframe();

  level notify("armory_breakout");
}

armory_guard_breakout() {
  self endon("death");
  level endon("shut_down_armory_breakout");
  level waittill("armory_breakout");
  self stopanimScripted();
  self setgoalpos(self.origin);
}

enemy_armory_guards_ignored() {
  self endon("death");
  self.ignoreme = 1;

  while(level.armory_guards_ignored)
    waitframe();

  self.ignoreme = 0;
}

ally_armory_guards() {
  scripts\engine\utility::flag_wait("armory_01_secure");

  if(scripts\engine\utility::flag("fob_cleared")) {
    var_0 = scripts\engine\sp\utility::array_spawn_targetname("armory_01_ally_spawner", 1);
    var_1 = getnodearray("armory_01_nodes", "targetname");
    var_1 = sortbydistance(var_1, var_0[0].origin);

    foreach(var_4, var_3 in var_0)
    var_3 setgoalnode(var_1[var_4]);
  }
}

ally_armory_02_guards() {
  scripts\engine\utility::flag_wait("armory_02_secure");
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("armory_02_ally_spawner", 1);
  var_1 = getnodearray("armory_02_nodes", "targetname");
  var_1 = sortbydistance(var_1, var_0[0].origin);

  foreach(var_4, var_3 in var_0)
  var_3 setgoalnode(var_1[var_4]);
}

armory_02() {
  thread armory_02_door();
  thread hangar_hatch();
  level.enemy_armory_guards = scripts\engine\sp\utility::array_spawn_targetname("armory_02_guards", 1);
  scripts\engine\utility::array_thread(level.enemy_armory_guards, scripts\engine\sp\utility::set_battlechatter, 0);
  level.armory_guards_ignored = 1;

  foreach(var_1 in level.enemy_armory_guards)
  var_1 scripts\engine\sp\utility::disable_surprise();

  scripts\engine\utility::array_thread(level.enemy_armory_guards, ::enemy_armory_guards_ignored);
  scripts\engine\utility::flag_wait("hatch_opened");
  level.enemy_armory_guards = scripts\engine\utility::array_removedead_or_dying(level.enemy_armory_guards);

  foreach(var_1 in level.enemy_armory_guards)
  var_1 getenemyinfo(level.player);

  scripts\engine\sp\utility::trigger_wait_targetname("armory_02_trigger");
  level.hadir.support_equipment = level.hadir.support_equipment_og;
  scripts\engine\utility::exploder("hangar_enemy_smoke");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::remove_corpses_away_from_player_pos(1200);
  level.armory_guards_ignored = 0;

  while(level.enemy_armory_guards.size > 0) {
    level.enemy_armory_guards = scripts\engine\utility::array_removedead_or_dying(level.enemy_armory_guards);
    waitframe();
  }

  scripts\engine\utility::flag_set("armory_02_secure");
}

armory_02_guards_vo() {
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_for_break_in_chatter(1);
  level.enemy_armory_guards[0] scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_ru4_armory_02_ruconvo1_10");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_for_break_in_chatter(2);
  level.enemy_armory_guards[0] scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_ru4_armory_02_ruconvo1_30");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_for_break_in_chatter(5);
  level.enemy_armory_guards[1] scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_ru3_armory_02_ruconvo1_40");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_for_break_in_chatter(5);
  level.enemy_armory_guards[0] scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_ru4_armory_02_ruconvo1_50");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_for_break_in_chatter(1);
  level.enemy_armory_guards[1] scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_ru3_armory_02_ruconvo1_60");
}

armory_02_door() {
  var_0 = getEntArray("armory_02_door", "targetname");
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "interactive_door"))
      var_1 = var_3;
  }

  var_1 waittill("trigger");
  scripts\engine\utility::flag_set("hadir_go_to_hatch");
}

hangar_hatch() {
  scripts\engine\utility::flag_wait("hadir_go_to_hatch");
  var_0 = spawnStruct();
  var_0.origin = (-42507.5, 28453.1, -678.982);
  var_0.angles = (0, -20, 0);
  var_1 = getEnt("hangar_hatch", "targetname");
  var_1.clip = var_1 scripts\engine\utility::get_target_ent();
  var_1.clip linkTo(var_1);
  var_1.animname = "hatch";
  var_1 scripts\engine\sp\utility::assign_animtree();
  var_2 = spawnStruct();
  var_2.origin = (-42647, 28362, -539);
  var_2.angles = (0, 70, 0);
  var_2 thread scripts\common\anim::anim_first_frame_solo(var_1, "armory_hatch");
  var_0 buddy_boost();
  thread player_in_armory_watcher();
  thread player_fell_watcher();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  scripts\engine\sp\utility::autosave_by_name("armory_02_door");
  var_2 scripts\sp\anim::anim_reach_solo(level.hadir, "armory_enter");
  var_2 scripts\common\anim::anim_single_solo(level.hadir, "armory_enter");
  var_3 = getEnt("hatch_flag_trigger", "targetname");
  var_2 notify("stop_loop");
  thread scripts\engine\utility::flag_set_delayed("hatch_opened", 0.5);
  var_2 thread scripts\common\anim::anim_single_solo(var_1, "armory_hatch");
  var_2 scripts\common\anim::anim_single_solo(level.hadir, "armory_hatch");
  var_2 thread scripts\common\anim::anim_loop_solo(level.hadir, "armory_hatch_idle", "stop_loop");
  var_0 thread hadir_pick_up_loop(var_2);

  while(!scripts\engine\utility::flag("player_in_armory_02") && istrue(level.player_on_armory)) {
    scripts\engine\utility::waittill_any_timeout(5, "player_fell");

    if(scripts\engine\utility::flag("player_in_armory_02") || !istrue(level.player_on_armory)) {
      break;
    }

    var_2 notify("stop_loop");
    var_2 scripts\common\anim::anim_single_solo(level.hadir, "armory_hatch_nag");
    var_2 thread scripts\common\anim::anim_loop_solo(level.hadir, "armory_hatch_idle", "stop_loop");
    scripts\engine\utility::waittill_any_timeout(5, "player_fell");

    if(scripts\engine\utility::flag("player_in_armory_02") || !istrue(level.player_on_armory)) {
      break;
    }
  }

  var_2 notify("stop_loop");
}

hadir_pick_up_loop(var_0) {
  var_1 = self;
  thread reboost_nav_obstacle();
  var_2 = spawnStruct();
  var_2.origin = (-42693, 28343, -480);
  var_2.angles = (21, 345, 0);

  while(!scripts\engine\utility::flag("player_in_armory_02")) {
    if(!istrue(level.player_on_armory)) {
      var_0 notify("stop_loop");
      level.hadir stopanimScripted();
      var_1 buddy_boost_restart();
      var_0 scripts\sp\anim::anim_reach_solo(level.hadir, "armory_hatch_idle");
      var_0 thread scripts\common\anim::anim_loop_solo(level.hadir, "armory_hatch_idle", "stop_loop");
      level.hadir notify("back_at_hatch");
    }

    waitframe();
  }

  var_0 notify("stop_loop");
}

player_fell_watcher() {
  level.hadir waittillmatch("single anim", "end");

  for(level.player_on_armory = 1; !scripts\engine\utility::flag("player_in_armory_02"); level.player_on_armory = 1) {
    if(level.hadir.origin[2] > level.player.origin[2] + 100) {
      level.player_on_armory = 0;
      level notify("player_fell");
    }

    waitframe();
  }
}

buddy_boost() {
  var_0 = getEnt("no_stick_clip", "targetname");
  var_0 setnonstick(1);
  var_0 setCanDamage(1);
  level.hadir.support_equipment_og = level.hadir.support_equipment;
  level.hadir.support_equipment = 0;
  level.hadir notify("remove_equipment");
  level.hadir.name = "";
  var_1 = self;
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  level.player.rig hide();
  var_1 scripts\common\anim::anim_single_solo(level.hadir, "buddy_boost_enter");
  var_1 thread scripts\common\anim::anim_loop_solo(level.hadir, "buddy_boost_enter_idle");
  var_1 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "buddy_boost");
  thread hadir_boost_nag(var_1);
  level.hadir thread scripts\common\utility::lookatentity(level.player);
  level.hadir scripts\sp\player\cursor_hint::create_cursor_hint("tag_accessory_left", (0, 0, 0), &"SAFEHOUSE_FINALE_LOC/BOOST", undefined, 700, 100, undefined, undefined, undefined, undefined, "duration_short");
  level.hadir waittill("trigger");
  level.hadir thread scripts\common\utility::lookatentity();
  level.player_rig = level.player.rig;
  visionsetnaked("safehouse_finale_hangar_lift", 0);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::put_player_into_rig(level.player.rig, 0.75, 0, 0, 0, 0);
  var_1 thread scripts\common\anim::anim_single([level.hadir, level.player.rig], "buddy_boost");
  var_1 notify("stop_loop");
  level.player.rig waittillmatch("single anim", "end");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.jumpspot = level.player.origin;
  visionsetnaked("", 0);
  var_1 thread scripts\common\anim::anim_loop_solo(level.hadir, "buddy_boost_restart_idle", "stop_loop");
  thread jump_interact();
  jump_watcher(level.jumpspot);
  visionsetnaked("safehouse_finale_hangar_lift", 0);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::put_player_into_rig(level.player.rig, 0.0, 0, 0, 0, 0);
  var_1 thread scripts\sp\player_rig::anim_lerp_from_player_pos("buddy_boost_restart", 0.5, 0.5);
  var_1 notify("stop_loop");
  level.player notify("jumped_up");
  var_1 scripts\common\anim::anim_single([level.hadir], "buddy_boost_restart");
  level.player allowjump(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
  visionsetnaked("", 0);
}

jump_watcher(var_0) {
  level endon("boost_jumped");

  for(;;) {
    var_1 = distance(level.player.origin, var_0);

    if(var_1 < 50)
      level.player allowjump(0);
    else
      level.player allowjump(1);

    if(var_1 < 50 && level.player jumpbuttonPressed()) {
      break;
    }

    waitframe();
  }

  level notify("boost_jumped");
}

jump_interact() {
  level endon("boost_jumped");
  wait 2.5;
  var_0 = scripts\engine\utility::spawn_tag_origin(level.hadir gettagorigin("j_head"), (0, 0, 0));
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, -30), &"SAFEHOUSE_FINALE_LOC/BOOST_JUMP", undefined, 600, 125, undefined, undefined, undefined, undefined, "duration_short");
  var_0 thread jump_interact_remove();
  var_0 waittill("trigger");
  level notify("boost_jumped");
  var_0 delete();
}

reboost_nav_obstacle() {
  var_0 = getEnt("armory_roof_obstacle", "targetname");
  var_1 = createnavobstaclebyent(var_0, "allies");
}

jump_interact_remove() {
  self endon("trigger");
  level scripts\engine\utility::waittill_any("boost_jumped", "player_in_armory_02");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

hadir_boost_nag(var_0) {}

buddy_boost_restart() {
  self notify("stop_loop");
  scripts\sp\anim::anim_reach_solo(level.hadir, "buddy_boost_restart_enter");
  scripts\common\anim::anim_single_solo(level.hadir, "buddy_boost_restart_enter");
  thread scripts\common\anim::anim_loop_solo(level.hadir, "buddy_boost_restart_idle", "stop_loop");
  scripts\common\anim::anim_first_frame_solo(level.player.rig, "buddy_boost_restart");
  thread jump_interact();
  jump_watcher(level.jumpspot);
  self notify("stop_loop");
  level.player allowjump(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::put_player_into_rig(level.player.rig, 1, 0, 0, 0, 0);
  scripts\common\anim::anim_single([level.hadir, level.player.rig], "buddy_boost_restart");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::pull_player_out_of_rig_hide_rig(level.player.rig);
}

player_in_armory_watcher() {
  scripts\engine\sp\utility::trigger_wait_targetname("armory_02_trigger");
  scripts\engine\utility::exploder("hangar_enemy_smoke");
  scripts\engine\utility::flag_set("player_in_armory_02");
}

molotov_hint_flash() {
  scripts\engine\utility::flag_wait_or_timeout("fob_truck_entrance", 10);

  if(level.player getammocount("molotov") > 0)
    scripts\engine\sp\utility::display_hint_forced("molotov_hint", 10);
}

gunner_bravo_spawn() {
  wait 2;
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("fob_chopper_04");
  var_0 thread scripts\engine\sp\utility::battlechatter_addvehicle("helicopter");
  wait 0.1;
  level notify("chopper_spawned");
  var_0 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::track_fob_helo_spawn();
}

transport_bravo_spawn() {
  for(;;) {
    var_0 = getaiarray("axis", "allies");

    if(var_0.size < 27 && !scripts\engine\utility::flag("ai_spawner_busy")) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("ai_spawner_busy");
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("fob_chopper_transport");
  var_1 thread scripts\engine\sp\utility::battlechatter_addvehicle("helicopter");
  wait 0.1;
  scripts\engine\utility::flag_clear("ai_spawner_busy");
  level notify("chopper_spawned");
  var_1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::track_fob_helo_spawn();
}

bunker_getallycovernodes() {
  return getnodearray("bunker_allyNode", "targetname");
}

precharge_getallycovernodes() {
  return getnodearray("preCharge_allyNode", "script_noteworthy");
}

town_getallycovernodes() {
  return getnodearray("town_allyNode", "targetname");
}

fobcenter_getallycovernodes() {
  return getnodearray("fobCenter_allyNode", "targetname");
}

fobchu_getallycovernodes() {
  return getnodearray("fobCHU_allyNode", "targetname");
}

airportcombat_getallycovernodes() {
  return getnodearray("airportCombat_allyNode", "targetname");
}

trenchrun_getallycovernodes() {
  return getnodearray("trenchRun_allyNode", "targetname");
}

towerstairs_getallycovernodes() {
  return getnodearray("towerStairs_allyNode", "targetname");
}

redshirt_refill() {
  level endon("hangar_interior");
  var_0 = getspawner("allySpawner_bunkers", "targetname");
  var_1 = 8;

  for(;;) {
    if(scripts\engine\utility::flag("fob_player_in_center"))
      var_0 = getspawner("allySpawner_center", "targetname");

    if(scripts\engine\utility::flag("fob_exit"))
      var_0 = getspawner("allySpawner_exit", "targetname");

    if(scripts\engine\utility::flag("chu_strafe_run")) {
      var_0 = getspawner("allySpawner_Containers", "targetname");
      var_1 = 7;
    }

    var_2 = var_0.origin;
    var_3 = getaiarray("allies");

    if(var_3.size < var_1) {
      var_4 = getaiarray("axis", "allies");

      if(var_4.size > 30 || scripts\engine\utility::flag("ai_spawner_busy")) {
        wait 0.1;
        continue;
      }

      scripts\engine\utility::flag_set("ai_spawner_busy");
      var_0 = scripts\engine\utility::random(["allySpawner_dmr", "allySpawner_sh", "allySpawner_ar", "allySpawner_smg"]);
      var_0 = getspawner(var_0, "targetname");
      var_5 = var_0 scripts\engine\sp\utility::spawn_ai(1);

      if(var_5.classname == "actor_ally_reb_desert_dmr")
        var_5.disablesniperbehaviors = 1;

      var_5.health = 40;
      var_5.baseaccuracy = 0.1;
      var_5 scripts\engine\sp\utility::set_force_color("r");
      var_5 scripts\engine\utility::set_movement_speed(220);
      var_5 forceteleport(var_2);
      level.allies = scripts\engine\utility::array_add(level.allies, var_5);
      scripts\engine\utility::flag_clear("ai_spawner_busy");

      if(scripts\engine\utility::flag("fob_exit") && !scripts\engine\utility::flag("chu_strafe_run_go")) {
        var_5 scripts\engine\sp\utility::clear_force_color();
        var_5 scripts\engine\sp\utility::set_force_color("r");
      }

      if(scripts\engine\utility::flag("tarmac_enter")) {
        var_5 scripts\engine\sp\utility::clear_force_color();
        var_5 scripts\engine\sp\utility::set_force_color("p");
      } else {
        var_5 scripts\engine\sp\utility::clear_force_color();
        var_5.fixednode = 0;
        var_5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
      }

      var_0.count++;
    }

    wait 4;
  }
}

ally_fob_movement(var_0) {
  scripts\engine\utility::flag_wait("bunkers_breached");
  scripts\engine\sp\utility::activate_trigger_with_targetname("bunkers_color_trigger");
  level.allies = getaiarray("allies");
  level.ally_volume = fob_getallyentrancevolume();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_3 = getEnt("armen", "script_noteworthy");

  foreach(var_5 in level.allies) {
    if(isalive(var_5) && isDefined(var_5)) {
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 scripts\engine\sp\utility::set_force_color("r");
    }

    if(var_5 == var_1) {
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 scripts\engine\sp\utility::set_force_color("o");
      continue;
    }

    if(var_5 == var_3) {
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 scripts\engine\sp\utility::set_force_color("c");
      continue;
    }
  }

  scripts\engine\utility::flag_wait_any("fob_center", "bunkers_push");
  var_7 = fob_left_flank_init();
  var_8 = scripts\engine\utility::getStruct("armen_front_goal_spots", "targetname");

  foreach(var_5 in var_7) {
    if(isalive(var_5) && isDefined(var_5)) {
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 setgoalpos(var_8.origin);
      var_5 scripts\engine\sp\utility::set_goal_radius(400);
      var_5.fixednode = 0;
    }
  }

  if(!scripts\engine\utility::flag("fob_rear"))
    wait 3;

  scripts\engine\sp\utility::activate_trigger_with_targetname("fob_center_color_trigger");
  var_1 thread farah_door_kill();
  scripts\engine\utility::flag_wait("fob_center_entrance");
  level.ally_volume = getEnt("fob_ally_center_vol", "targetname");
  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("fob_ally_rear_vol", "targetname");

  foreach(var_5 in level.allies) {
    if(isDefined(var_5.left_flank)) {
      continue;
    }
    if(isalive(var_5) && isDefined(var_5)) {
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 setgoalpos(var_5.origin);
      var_5 scripts\engine\sp\utility::set_goal_radius(1000);
      var_5.fixednode = 0;
      var_5 setgoalentity(level.player);
      var_5.ignoresuppression = 0;
    }

    if(var_5 == level.farah || var_5 == level.hadir) {
      var_5 clearpath();
      var_5 setgoalpos((-38160, 34650, -648));
      var_5 scripts\engine\sp\utility::set_goal_radius(500);
    }
  }

  scripts\engine\utility::flag_wait("fob_rear");
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("fob_ally_exit_vol", "targetname");

  foreach(var_5 in level.allies) {
    if(isalive(var_5) && isDefined(var_5)) {
      var_5 setgoalpos(var_5.origin);
      var_5.fixednode = 0;
      var_5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
    }

    if(var_5 == level.farah || var_5 == level.hadir) {
      var_5 clearpath();
      var_5 setgoalpos((-38592, 34664, -684));
      var_5 scripts\engine\sp\utility::set_goal_radius(400);
    }
  }

  scripts\engine\utility::flag_wait("fob_exit_guards");
  level.allies = getaiarray("allies");
  goal_ent_player(1000, level.allies);
  scripts\engine\utility::flag_set("ally_fob_movement_complete");
  scripts\engine\utility::flag_wait("fob_spawns_complete");
  scripts\engine\utility::flag_wait("fob_cleared");
}

farah_door_kill() {
  level endon("fob_player_in_center_swarm");
  level endon("fob_exit");

  if(scripts\sp\starts::is_after_start("fob_center")) {
    return;
  }
  var_0 = getEnt("chu_bad_places_door", "targetname");
  var_0 = createnavbadplacebyent(var_0, "allies", "axis");
  var_1 = scripts\engine\utility::getStruct("farah_door_struct", "targetname");
  var_1.enemy_target = undefined;
  var_1.target_ent = undefined;
  var_2 = var_1 scripts\engine\utility::get_target_array();

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "door")) {
      var_1.target_ent = var_4;
      var_1.target_ent = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles);
    }

    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "guy"))
      var_1.enemy_target = var_4;
  }

  scripts\engine\utility::flag_wait("fob_player_in_center");
  scripts\engine\sp\utility::set_goal_radius(34);
  self.fixednode = 0;
  scripts\engine\utility::set_movement_speed(250);
  scripts\engine\sp\utility::set_goal_pos(var_1.origin);
  self.ignoresuppression = 1;
  var_6 = scripts\engine\sp\utility::spawn_targetname("farah_door_spawners");
  var_6.health = var_6.health + 50;
  var_6 scripts\engine\sp\utility::set_goal_radius(34);
  var_6 scripts\engine\sp\utility::set_goal_pos(var_1.enemy_target.origin);
  self setentitytarget(var_1.target_ent, 1);
  self waittill("goal");

  if(isDefined(var_6))
    var_6 scripts\engine\utility::waittill_any_timeout(5, "death");

  if(!isDefined(var_6))
    wait 1;

  destroynavobstacle(var_0);
  scripts\engine\sp\utility::set_goal_radius(800);
  self clearentitytarget();
  self waittill("goal");
  scripts\engine\utility::set_movement_speed(180);
  self.ignoresuppression = 0;
}

ally_movement_containers(var_0) {
  scripts\engine\utility::flag_wait("fob_cleared");
  level endon("chu_exit");
  level.ally_volume = getEnt("fob_ally_exit_vol", "targetname");
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_3 = getEnt("armen", "script_noteworthy");
  scripts\engine\sp\utility::activate_trigger_with_targetname("armory_01_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_pre_truck_color");

  if(!scripts\engine\utility::flag("armory_01_secure")) {
    level.allies = getaiarray("allies");

    foreach(var_5 in level.allies) {
      if(scripts\engine\utility::is_equal(var_5.targetname, "armory_02_guards")) {
        continue;
      }
      var_5.fixednode = 1;

      if(isalive(var_5) && isDefined(var_5)) {
        var_5 scripts\engine\utility::set_movement_speed(220);

        if(var_5 == var_3 || var_5 == var_2) {
          var_5 scripts\engine\sp\utility::clear_force_color();
          var_5 scripts\engine\sp\utility::set_force_color("c");
          continue;
        }

        if(var_5 == var_1) {
          var_5 scripts\engine\sp\utility::clear_force_color();
          var_5 scripts\engine\sp\utility::set_force_color("p");
          continue;
        }

        var_5 scripts\engine\sp\utility::clear_force_color();
        var_5 scripts\engine\sp\utility::set_force_color("r");
        var_5.fixednode = 1;
      }
    }
  }

  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_pre_truck_color");
  level.allies = getaiarray("allies");

  foreach(var_5 in level.allies) {
    if(scripts\engine\utility::is_equal(var_5.targetname, "armory_02_guards")) {
      continue;
    }
    var_5.fixednode = 1;

    if(isalive(var_5) && isDefined(var_5)) {
      var_5 scripts\engine\utility::set_movement_speed(180);

      if(var_5 == var_1) {
        var_5.fixednode = 1;
        var_5 scripts\engine\sp\utility::clear_force_color();
        var_5 scripts\engine\sp\utility::set_force_color("p");
        var_5 setgoalpos(var_5.origin);
        var_5 thread scene_gate_farah();
        continue;
      }

      if(var_5 == var_2) {
        var_5 scripts\engine\sp\utility::clear_force_color();
        var_5 scripts\engine\sp\utility::set_force_color("g");
        var_5 thread hadir_truck_entrance(var_0);
        continue;
      }

      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 scripts\engine\sp\utility::set_force_color("r");
      var_5.fixednode = 1;
    }
  }

  scripts\engine\utility::flag_wait("farah_gate_lookat");
  wait 4;
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_truck_color");
  var_9 = scripts\engine\utility::getStruct("farah_gate_anim", "targetname");
  level.container_nodes = getnodearray("fobCHU_allyNode", "targetname");

  foreach(var_11 in level.container_nodes) {
    if(!scripts\engine\utility::is_equal(var_11.type, "Exposed"))
      level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, var_11);
  }

  level.container_nodes = sortbydistance(level.container_nodes, (-40802, 34662, -620));
  level.allies = getaiarray("allies");
  level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, level.container_nodes[level.container_nodes.size - 1]);
  level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, level.container_nodes[level.container_nodes.size - 1]);
  level.allies = getaiarray("allies");
  level.allies = sortbydistance(level.allies, (-40802, 34662, -620));

  foreach(var_5 in level.allies) {
    if(scripts\engine\utility::is_equal(var_5.targetname, "armory_02_guards")) {
      continue;
    }
    if(isalive(var_5) && isDefined(var_5)) {
      if(var_5 == var_2) {
        continue;
      }
      var_14 = sortbydistance(level.container_nodes, var_5.origin)[0];
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 setgoalpos(var_5.origin);
      var_5 setgoalnode(var_14);
      level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, var_14);
    }
  }

  level.container_nodes = undefined;
  scripts\engine\utility::flag_wait("container_door_breached");
  wait 3.0;
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_farah_hadir_00");
  level.ally_volume = getEnt("chu_main_vol", "targetname");
  var_1 setgoalpos(var_1.origin);
  var_1 scripts\engine\sp\utility::clear_force_color();
  var_1 scripts\engine\sp\utility::set_force_color("b");
  var_2 scripts\engine\sp\utility::clear_force_color();
  var_2 scripts\engine\sp\utility::set_force_color("b");
  level.allies = getaiarray("allies");
  var_16 = container_getallypaths();

  foreach(var_18 in level.allies) {
    if(scripts\engine\utility::is_equal(var_18.targetname, "armory_01_ally_spawner")) {
      continue;
    }
    if(var_18 == var_2 || var_18 == var_1) {
      continue;
    }
    wait 0.1;
    var_18 scripts\common\utility::demeanor_override("combat");
    var_18.old_color = var_18.script_forcecolor;
    var_18 scripts\engine\sp\utility::clear_force_color();
    var_18 thread fire_death();
    var_19 = sortbydistance(var_16, var_18.origin)[0];
    thread charge_allypathlogic(var_18, var_19, 1);
    var_16 = scripts\engine\utility::array_remove(var_16, var_19);
    var_18 scripts\engine\utility::set_movement_speed(250);
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_chopper_color_trigger");
  level.allies = getaiarray("allies");

  foreach(var_18 in level.allies) {
    var_18 scripts\engine\utility::set_movement_speed(250);
    var_18.ignoreme = 1;
  }

  scripts\engine\utility::flag_wait("chu_strafe_run_go");
  wait 5;
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("chu_main_vol", "targetname");

  foreach(var_5 in level.allies) {
    var_5 notify("stop_going_to_node");

    if(isalive(var_5) && isDefined(var_5)) {
      var_5.ignoreme = 0;

      if(var_5 == var_1 || var_5 == var_2) {
        continue;
      }
      var_5 scripts\engine\utility::set_movement_speed(200);
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5 scripts\engine\sp\utility::set_goal_radius(250);
      var_5.fixednode = 0;
      var_5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
    }
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_farah_hadir_01");
  scripts\engine\utility::flag_wait("chu_rear");
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("chu_rear_vol", "targetname");

  foreach(var_5 in level.allies) {
    if(isalive(var_5) && isDefined(var_5)) {
      var_5 setgoalpos(var_5.origin);
      var_5 scripts\engine\sp\utility::set_goal_radius(500);
      var_5 scripts\engine\sp\utility::clear_force_color();
      var_5.forcelongdeath = 1;
      var_5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
      var_5.fixednode = 0;
    }
  }
}

fire_death() {
  scripts\common\ai::magic_bullet_shield();

  if(self.model == "fsa_rebel_female_a" || self.model == "fsa_rebel_female_b" || self.model == "fsa_rebel_female_c") {
    return;
  }
  scripts\engine\utility::flag_wait_any("chu_strafe_run_go", "player_in_drone");
  level waittill("chu_fire_start");
  scripts\common\ai::stop_magic_bullet_shield();
  var_0 = scripts\engine\utility::getStruct("fuel_trailer", "targetname");
  var_1 = 400;

  if(var_1 < distance(self.origin, var_0.origin)) {
    return;
  }
  self._blackboard.isburning = 1;
  self.burningtodeath = 1;
  self.burningdirection = "left";
  self dodamage(10, self.origin, undefined, level.player, "MOD_FIRE", "molotov");
  thread molotov_burn_sfx();
  level thread remove_blackboard_isburning(self);
}

molotov_burn_sfx(var_0) {
  if(isDefined(var_0))
    var_1 = 1;
  else
    var_1 = 0.5;

  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfxenabled = 1;
    wait(var_1);
    wait 0.15;

    if(isDefined(self.burnsfx)) {
      self.burnsfx delete();
      self.burnsfxenabled = 0;
    }
  }
}

remove_blackboard_isburning(var_0) {
  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_0._blackboard.isburning = undefined;
}

scene_gate_farah() {
  var_0 = spawnStruct();
  var_0.origin = (-40865, 34544, -642);
  var_0.angles = (0, -90, 0);
  var_1 = getEnt("armory_01_trigger", "targetname");

  while(level.player istouching(var_1))
    waitframe();

  scripts\engine\utility::set_movement_speed(160);
  scripts\engine\utility::flag_wait("farah_gate_lookat");
  scripts\engine\sp\utility::clear_force_color();
  waitframe();
  var_0 scripts\sp\anim::anim_reach_solo(self, "gate_pull");
  var_0 thread scripts\common\anim::anim_single_solo(self, "gate_pull");
  level notify("farah_gate_pull");
  wait 5;
  level notify("farah_gate_anim");
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::set_movement_speed(200);
}

fob_left_flank_init() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_2 = getaiarray("allies");
  var_2 = scripts\engine\utility::array_remove(var_2, var_0);
  var_2 = scripts\engine\utility::array_remove(var_2, var_1);
  var_2 = scripts\engine\utility::array_remove(var_2, level.armen);
  var_2 = sortbydistance(var_2, level.armen.origin);
  var_2 = [level.armen, var_2[0], var_2[1]];

  foreach(var_4 in var_2)
  var_4.left_flank = 1;

  return var_2;
}

hadir_truck_entrance(var_0) {
  if(isDefined(var_0))
    waitframe();

  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\utility::set_movement_speed(220);
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\sp\utility::clear_force_color();
  var_1 = scripts\engine\utility::getStruct("hadir_truck_enter_struct", "targetname");
  thread scripts\sp\spawner::go_to_node(var_1);
  self waittill("goal");
  scripts\engine\utility::flag_set("hadir_at_truck");
}

scene_truck_gate() {
  var_0 = spawnStruct();
  var_0.origin = (-40170, 34500, -650);
  var_0.angles = (0, 0, 0);
  var_1 = getEnt("airport_gate", "targetname");
  var_1.clip = getEnt("airport_gate_clip", "targetname");
  var_1.struct = var_1 scripts\engine\utility::get_target_ent();
  var_1.clip linkTo(var_1);
  var_1.animname = "gate";
  var_2 = getEntArray("airport_gate_barbs", "targetname");

  foreach(var_4 in var_2)
  var_4 unlink();

  var_1 scripts\engine\sp\utility::assign_animtree();
  var_6 = scripts\engine\sp\utility::spawn_anim_model("bent_gate", (0, 0, 0), (0, 0, 0));
  var_7 = getspawnerarray("fob_guys_rear")[0];
  var_7.count = 1;
  var_7 = scripts\engine\sp\utility::bodyonlyspawn(var_7);
  var_7.animname = "body";
  var_8 = [level.hadir, level.gate_truck, var_7];
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, "truck_smash");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_6, "truck_smash");
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.gate_truck, "truck_enter");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_7, "truck_enter");
  var_1.clip unlink();
  level.hadir scripts\engine\utility::set_cautious_navigation(0);
  waitframe();
  scripts\engine\utility::flag_wait("farah_gate_lookat");
  wait 2;
  var_0 scripts\sp\anim::anim_reach_solo(level.hadir, "truck_enter");
  var_0 scripts\common\anim::anim_single(var_8, "truck_enter");
  scripts\engine\utility::flag_set("hadir_in_truck");
  var_9 = getEnt("truck_smash_clip", "targetname");
  var_9 connectpaths();
  var_10 = getEnt("truck_smash_trigger", "targetname");
  var_10 enablelinkTo();
  var_10 linkTo(var_9);
  level.hadir.support_equipment_og = level.hadir.support_equipment;
  level.hadir.support_equipment = 0;
  level.gate_truck thread scripts\common\anim::anim_loop_solo(level.hadir, "truck_enter_idle", "stop_loop", "TAG_DRIVER");
  scripts\engine\utility::flag_wait("hadir_ramming_dialogue_complete");
  level.gate_truck thread scripts\engine\sp\utility::play_sound_on_entity("scn_safehouse_gate_smash_engine_01");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_taillight_umike_left_container"), level.gate_truck, "tag_light_back_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_taillight_umike_right_container"), level.gate_truck, "tag_light_back_right");
  wait 2;
  var_10 thread truck_smash_watcher();
  level.hadir linkTo(level.gate_truck, "TAG_DRIVER");
  var_8 = [var_1, level.gate_truck, var_6, var_1];
  var_0 thread scripts\common\anim::anim_single(var_8, "truck_smash");
  level waittill("gate_down");
  var_1.clip linkTo(var_6);

  foreach(var_4 in var_2)
  var_4 linkTo(var_6);

  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_gate_smash_impact", var_1.origin);
  level.gate_truck thread scripts\engine\sp\utility::play_sound_on_entity("scn_safehouse_gate_smash_engine_02");
  var_6 thread scripts\engine\sp\utility::play_sound_on_entity("scn_safehouse_gate_smash_push");
  var_1.clip connectpaths();
  level.gate_truck waittillmatch("single anim", "end");
  var_9 disconnectPaths();
  level.gate_truck notify("stop_loop");
  level.gate_truck thread scripts\common\anim::anim_single_solo(level.gate_truck, "truck_exit");
  level.gate_truck scripts\common\anim::anim_single_solo(level.hadir, "truck_exit", "TAG_DRIVER");
  level.hadir.support_equipment = level.hadir.support_equipment_og;
  level.hadir unlink();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  var_1.clip delete();
  var_1 delete();
}

truck_smash_watcher() {
  wait 1;
  level.gate_truck endon("stop_loop");

  while(!level.player istouching(self))
    waitframe();

  level.player kill();
}

fob_getallyentrancevolume() {
  return getEnt("fob_ally_entrance_vol", "targetname");
}

enemy_fob_movement() {
  level.enemy_goal_volume = undefined;
}

enemies_cleared_move_forward(var_0) {
  level endon("fob_center");

  while(var_0.size > 2) {
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
    wait 0.1;
  }

  scripts\engine\utility::flag_set_delayed("bunkers_push", 2);
}

fob_enemies_rear() {
  var_0 = getaiarray("axis", "allies");
  var_1 = 25 - var_0.size;
  var_2 = getspawnerarray("fob_guys_rear");
  var_3 = getEnt("fob_rear_vol", "targetname");

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_0 = getaiarray("axis", "allies");
    var_1 = 22 - var_0.size;

    if(var_1 <= 0) {
      return;
    }
    var_5 = var_2[0] scripts\engine\sp\utility::spawn_ai(1);
    var_2[0].count = 1;
    waitframe();
  }
}

fob_center_start() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  thread explode_tarmac_scriptables();
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::rocket_showdamagedtargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  scripts\engine\utility::flag_set("fly_attack_done");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("bunkers_breached");
  scripts\engine\sp\utility::set_start_location("fob_center_start", [level.player]);
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(7);
  var_4 = charge_setalliestoredshirts();
  var_5 = bunker_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var_4, [var_0, var_1, var_2]);

  foreach(var_7 in level.allies) {
    var_8 = scripts\engine\utility::random(var_5);
    var_7 scripts\engine\sp\utility::teleport_ai(var_8);
    var_5 = scripts\engine\utility::array_remove(var_5, var_8);
  }

  thread armory_01();
  thread ally_fob_movement();
  thread chu_bad_places();
  var_10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_10, ::delete);
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("finished_bunker_vo");
}

fob_center_main() {
  thread rooftop_director_03();
  thread hide_armory_guns();
  thread door_gag_door_watcher();
  var_0 = getEntArray("door_gag_trigger", "targetname");
  scripts\engine\utility::array_thread(var_0, ::door_gags);
  scripts\engine\utility::flag_wait_any("fob_center", "bunkers_push");
  var_1 = spawn_check_func(31, "fob_guys_center_containers", 3);
  goal_ent_position(600, var_1, "mid_goal_spots");
  thread directing_02(var_1);
  var_2 = spawn_check_func(32, "fob_guys_center_pit", 2);
  waitframe();
  var_1 = spawn_check_func(31, "fob_guys_center_containers", 3);
  goal_ent_player(1200, var_2);
  level thread scripts\engine\sp\utility::notify_delay("sfx_airbase_siren_stop", 15);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_4 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  thread redshirt_refill();
  thread fob_spawn_manager();
  thread dialogue_fob_center();
  thread favela_door_guy();
  scripts\engine\utility::flag_wait("finished_fob_center_vo");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::player_startallowdrones();
  scripts\engine\utility::flag_wait("fob_player_in_center");
  thread fob_center_autosave(getEnt("fob_autosave_left", "targetname"));
  thread fob_center_autosave(getEnt("fob_autosave_right", "targetname"));
  var_5 = scripts\engine\utility::getStruct("charge_distance_struct", "targetname");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::remove_corpses_away_from_player_pos(800);
  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");
  thread enemy_info();
  scripts\engine\sp\utility::autosave_by_name("fob_center_entrance");
  scripts\engine\utility::flag_wait("fob_rear");
  thread ally_drone_attack(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::remove_corpses_away_from_player_pos(1200);
  thread enemy_info();
  scripts\engine\sp\utility::autosave_by_name("fob_rear");
  scripts\engine\utility::flag_wait("fob_exit");
  thread enemy_info();
  thread kill_fob_ladders();
  scripts\engine\sp\utility::autosave_by_name("fob_exit");
  scripts\engine\utility::flag_wait("fob_cleared");
  level notify("drone_allowed");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::player_pauseallowdrones();
}

vo_fob_center_snipers() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_far_tarmac_snipers_10";
  var_0[var_0.size] = "dx_vom_far_tarmac_snipers_20";
  var_0[var_0.size] = "dx_vom_far_tarmac_snipers_30";
  var_1 = [];
  var_1[var_1.size] = "dx_vom_had_tarmac_snipers_10";
  var_1[var_1.size] = "dx_vom_had_tarmac_snipers_20";
  var_1[var_1.size] = "dx_vom_had_tarmac_snipers_30";
  var_2 = [scripts\engine\sp\utility::create_deck(var_0), scripts\engine\sp\utility::create_deck(var_1)];
  var_3 = [level.farah, level.hadir];
  var_4 = 0;

  for(;;) {
    level.player waittill("bulletwhizby", var_5, var_6);
    var_7 = getEntArray("tower_spawner", "script_noteworthy");

    if(var_7.size == 0 || !scripts\engine\utility::array_contains(var_7, var_5)) {
      continue;
    }
    var_3[var_4] scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_2[var_4] scripts\engine\sp\utility::deck_draw(), 0, 2);
    var_4 = !var_4;
    wait 6;
  }
}

fob_center_autosave(var_0) {
  level endon("fob_cleared");
  var_0 waittill("trigger");
  scripts\engine\sp\utility::autosave_now();
}

hide_armory_guns() {
  wait 0.1;
  var_0 = getEntArray("fob_weapons_01", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
  scripts\engine\utility::flag_wait("fob_exit_guards");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 show();
  }
}

door_gag_door_watcher() {
  wait 0.5;
  level endon("door_gag_go");
  var_0 = undefined;
  var_1 = getscriptablearray();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "shooting_door_door"))
      var_0 = var_3;
  }

  if(isDefined(var_0)) {
    var_0 waittill("damage");
    scripts\engine\utility::flag_set("door_gag_door_damaged");
  }
}

rooftop_director_03() {
  waitframe();
  var_0 = scripts\engine\utility::getStruct("general_03_struct", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("general_guy_right", 1);

  if(!isDefined(var_1)) {
    return;
  }
  var_1 endon("death");
  var_1 thread damage_breakout_of_anim();
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.allowdeath = 1;
  var_1.animname = "enemy_01";
  var_0 scripts\sp\anim::anim_reach_solo(var_1, "directing_01");
  var_0 scripts\common\anim::anim_single_solo(var_1, "directing_01");
  var_1 notify("anim_done");
}

damage_breakout_of_anim() {
  self endon("death");
  scripts\engine\utility::waittill_any("damage", "anim_done");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self stopanimScripted();
  self setgoalpos(self.origin);
  self.goalheight = 72;
  scripts\engine\sp\utility::set_goal_radius(200);
}

directing_02(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];
  waitframe();
  var_1 endon("death");
  var_4 = scripts\engine\utility::getStruct("directing_02", "targetname");
  var_1.animname = "enemy_02";
  var_1.allowdeath = 1;
  var_1.ignoreme = 1;
  var_2.ignoreme = 1;
  var_3.ignoreme = 1;
  var_4 thread scripts\common\anim::anim_first_frame_solo(var_1, "directing_02");
  waitframe();
  var_5 = [var_2, var_3];

  foreach(var_7 in var_5) {
    var_7 forceteleport(var_1.origin, var_1.angles);
    var_7 setgoalpos(var_7.origin);
    var_7 scripts\engine\sp\utility::set_goal_radius(20);
  }

  scripts\engine\utility::flag_wait("fob_center_entrance");
  var_4 thread scripts\common\anim::anim_single_solo(var_1, "directing_02");
  var_1 thread ai_after_animation();
  wait 0.25;

  foreach(var_11, var_7 in var_5) {
    if(isalive(var_7)) {
      var_10 = -200;

      if(var_11 == 1)
        var_10 = -300;

      var_7 setgoalpos(var_7.origin + (-50, var_10, 50));
      var_7 scripts\engine\sp\utility::set_goal_radius(64);
      var_7.ignoreme = 0;
      var_7 scripts\engine\sp\utility::set_ignoresuppression(1);
      var_7 getenemyinfo(level.farah);
    }
  }

  wait 4;
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  goal_ent_player(1000, var_0);
}

ai_after_animation() {
  self waittillmatch("single anim", "end");

  if(isalive(self)) {
    self setgoalpos(self.origin + (0, 0, 0));
    scripts\engine\sp\utility::set_goal_radius(10);
    self.ignoreme = 0;
  }
}

directing_01(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[1];
  waitframe();
  var_3 = scripts\engine\utility::getStruct("directing_01", "targetname");
  var_1.animname = "enemy_01";
  var_1.allowdeath = 1;
  var_1.ignoreme = 1;
  var_2.ignoreme = 1;
  var_3 thread scripts\common\anim::anim_first_frame_solo(var_1, "directing_01");
  waitframe();
  var_2 forceteleport(var_1.origin, var_1.angles);
  var_2 setgoalpos(var_2.origin);
  var_2 scripts\engine\sp\utility::set_goal_radius(20);
  scripts\engine\utility::flag_wait("fob_center_entrance");
  var_3 thread scripts\common\anim::anim_single_solo(var_1, "directing_01");
  var_1 thread ai_after_animation();
  wait 2;

  if(isalive(var_2)) {
    var_2 setgoalpos((-42252, 33044, -608));
    var_2 scripts\engine\sp\utility::set_goal_radius(64);
    var_2.ignoreme = 0;
    var_2 scripts\engine\sp\utility::set_ignoresuppression(1);
    var_2 getenemyinfo(level.player);
  }

  wait 4;
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  goal_ent_player(1000, var_0);
}

favela_door_guy() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("favela_door", "targetname")[0];
  var_0.script_destructible = 1;
  var_0.clip = var_0 scripts\engine\utility::get_linked_ent();
  var_0.clip linkTo(var_0);
  level.favela_door = var_0;
  var_0.animname = "door_scriptable";
  var_0 scripts\engine\sp\utility::assign_animtree();
  scripts\engine\utility::flag_wait("fob_rear");
  var_1 = scripts\engine\sp\utility::spawn_targetname("favela_door_guy", 1);
  var_1.animname = "generic";
  var_1.forceragdollimmediate = 1;
  var_1.allowdeath = 1;
  favela_door_open_loop(var_0, var_1);
  var_0 notify("stop_loop");
  var_0 stopanimScripted();
  var_0 setflaggedanim("single anim", var_0 scripts\engine\utility::getanim("faveladoor_fastopen"), 1);
  var_0.clip connectpaths();

  if(isDefined(var_1)) {
    var_1 stopanimScripted();
    var_1 setgoalpos(var_1.origin);
    var_1 scripts\engine\sp\utility::set_goal_radius(10);
  }

  wait 4;

  if(isDefined(var_1)) {
    var_1 setgoalentity(level.player);
    var_1 scripts\engine\sp\utility::set_goal_radius(800);
  }
}

favela_door_open_loop(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("breakout");
  var_2 = var_0 scripts\engine\utility::getanim("faveladoor_fire1");
  var_3 = getanimlength(var_2);
  var_1 thread favela_door_guy_anims(var_0, var_3);
  var_0 setflaggedanim("single anim", var_2, 1);
  wait(var_3);

  if(scripts\engine\utility::flag("favella_end_flag")) {
    return;
  }
  if(scripts\engine\utility::flag("favella_end_flag"))
    return;
}

favela_door_guy_anims(var_0, var_1) {
  self endon("death");
  var_0 scripts\common\anim::anim_single_solo(self, "faveladoor_fire1");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "faveladoor_idle", "stop_loop");
  wait 1;
  var_0 notify("stop_loop");
  waitframe();
}

door_gags() {
  level endon("fob_rear_trucks");
  var_0 = scripts\engine\utility::get_target_array();
  self.position_struct = undefined;
  self.spawner = getspawner(self.target, "targetname");
  self.door_ent = undefined;

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "door")) {
      self.door_ent = var_2;
      self.door_ent = scripts\engine\utility::spawn_tag_origin(var_2.origin + (0, 0, 10), var_2.angles);
    }

    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "position"))
      self.position_struct = var_2;
  }

  self waittill("trigger");

  if(scripts\engine\utility::flag("door_gag_door_damaged")) {
    return;
  }
  level notify("door_gag_go");
  var_4 = self.spawner scripts\engine\sp\utility::spawn_ai(1);
  var_4.targetname = "door_gag_guy";
  var_4 endon("death");
  var_4 scripts\engine\sp\utility::set_goal_radius(32);
  var_4 scripts\engine\sp\utility::set_goal_pos(var_4.origin);
  var_4 setentitytarget(self.door_ent, 1);
  thread door_ent_movement(var_4);
  wait 3;
  var_4 clearentitytarget();
  var_4 getenemyinfo(level.player);
  var_4 setgoalentity(level.player);
  var_4 scripts\engine\sp\utility::set_goal_radius(100);
}

door_ent_movement(var_0) {
  var_1 = 3;
  var_0 endon("death");
  self.door_ent.origin = self.door_ent.origin + (0, 0, -20);
  self.door_ent moveTo(self.origin + (5, 5, 20), var_1);
  thread door_gag_magic_bullet(var_0);
  wait(var_1);
  self notify("magic_done");
}

door_gag_magic_bullet(var_0) {
  self endon("magic_done");
  var_0 endon("death");
  var_0 endon("damage");

  for(;;) {
    var_1 = var_0 gettagorigin("tag_flash");
    magicbullet("iw8_lm_pkilo", var_1, self.door_ent.origin);
    wait 0.1;
  }
}

enemy_info() {
  var_0 = getaiarray("allies");
  var_1 = getaiarray("axis");
  scripts\engine\utility::array_thread(var_0, ::get_enemy_info_all, "axis");
  scripts\engine\utility::array_thread(var_0, ::get_enemy_info_all, "allies");
}

get_enemy_info_all(var_0) {
  self endon("death");
  var_1 = getaiarray(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      self getenemyinfo(var_3);
  }
}

kill_fob_ladders() {
  var_0 = getEntArray("ladder_nav_kill", "targetname");

  foreach(var_2 in var_0)
  createnavbadplacebyent(var_2, "allies", "axis");
}

init_chopper_lights() {
  var_0 = getEnt("cockpit_light_01", "targetname");
  var_0 setlightintensity(0);
  var_0 = getEnt("cockpit_light_02", "targetname");
  var_0 setlightintensity(0);
  var_0 = getEnt("cockpit_light_03", "targetname");
  var_0 setlightintensity(0);
}

init_ending_lights() {
  var_0 = getEntArray("ending_character_lights", "targetname");

  foreach(var_2 in var_0) {
    var_2.origin_intensity = var_2 getlightintensity();
    var_2 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("killstreak_complete");
  scripts\engine\utility::exploder("end_scene_fx");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2.origin_intensity);
}

init_towers() {
  while(!scripts\engine\utility::flag_exist("scriptables_ready"))
    waitframe();

  scripts\engine\utility::flag_wait("scriptables_ready");
  var_0 = getscriptablearray("guard_tower", "script_noteworthy");
  var_1 = (-43000.5, 29836, -340);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1, (0, 0, 0));
  level.tarmac_tower = sortbydistance(var_0, var_2.origin)[0];

  foreach(var_4 in var_0) {
    var_5 = var_4 scripts\engine\sp\utility::get_linked_struct();
    var_4.nodes = getnodearray(var_5.target, "targetname");
    var_4.glass = getglassarray(var_5.target);
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

guard_tower_logic() {
  var_0 = scripts\engine\sp\utility::get_spawner_array("tower_spawner", "script_noteworthy");
  var_0 = sortbydistance(var_0, self.origin);
  var_0[0].count = 1;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_5) && (isexplosivedamagemod(var_5) && var_1 > 100)) {
      var_11 = 0;

      if(isDefined(var_4) && var_4[2] - self.origin[2] < 215)
        var_11 = 1;

      if(var_11)
        var_12 = "collapsed";
      else
        var_12 = "exploded";

      var_0[0].count = 0;
      self.brushmodel delete();

      foreach(var_14 in self.glass)
      destroyglass(var_14);

      self setscriptablepartstate("base", var_12, 1);
      thread scripts\engine\utility::play_sound_in_space("scn_safehouse_hellcannon_impact_debris", self.origin);
      level notify("tower_collapse");

      if(self == level.tarmac_tower)
        level.tarmac_tower.collapsed = 1;

      foreach(var_17 in getaiarray()) {
        if(var_17 istouching(self.trigger)) {
          if(isDefined(var_17.magic_bullet_shield)) {
            continue;
          }
          var_17.ragdoll_immediate = 1;
          var_17 dodamage(500, var_17.origin, undefined, undefined, "MOD_CRUSH");
        }
      }

      self.trigger delete();

      foreach(var_20 in self.nodes) {
        var_20 disconnectnode();
        destroynavlink(var_20);
      }

      return;
    }
  }
}

fob_spawn_manager() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  thread tromeo_entrance_01();
  transport_bravo_spawn();
  gunner_bravo_spawn();
  thread close_airport_gate();
  thread fob_umike_03();
  thread tromeo_entrance_03();
  tower_spawner_logic("tower_guy_fob_02", 3);
  level thread vo_fob_center_snipers();
  scripts\engine\utility::flag_wait("fob_center_entrance");
  level scripts\engine\utility::waittill_any_timeout(15, "fob_player_in_center", "player_in_drone");
  waitframe();
  var_2 = spawn_check_func(31, "fob_guys_center_tower");
  thread rooftop_directoring(var_2);
  scripts\engine\utility::flag_wait("fob_player_in_center");
  waitframe();
  var_3 = spawn_check_func(31, "fob_guys_center_containers", 5);
  goal_ent_position(600, var_3, "mid_goal_spots");
  wait 1;
  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");
  var_4 = [level.farah, level.hadir];

  foreach(var_6 in var_4)
  var_6 setthreatbiasgroup("shielded");

  var_8 = [];
  var_8[var_8.size] = tower_spawner_logic("tower_guy_fob");
  waitframe();
  var_8[var_8.size] = tower_spawner_logic("tower_guy_fob");

  foreach(var_6 in var_8)
  var_6 setthreatbiasgroup("snipers");

  thread scripts\engine\sp\utility::ignoreeachother("shielded", "snipers");
  var_11 = spawn_check_func(31, "fob_guys_center_containers", 4);
  goal_ent_position(600, var_11, "rear_goal_spots");
  scripts\engine\utility::flag_wait("fob_rear");
  thread tromeo_entrance_02();
  scripts\engine\utility::flag_waitopen("ai_spawner_busy");
  var_12 = spawn_check_func(31, "fob_guys_rear", 5);

  if(isDefined(var_12)) {
    foreach(var_6 in var_12) {
      if(isDefined(var_6)) {
        var_6 setgoalpos(var_6.origin);
        var_6 scripts\engine\sp\utility::set_goal_radius(900);
        var_6 setgoalentity(level.player);
      }
    }
  }

  scripts\engine\utility::flag_wait("fob_rear_trucks");
  goal_ent_player(1000);
  var_15 = getaiarray("axis");
  var_16 = [];

  foreach(var_6 in var_15) {
    if(scripts\engine\utility::is_equal(var_6.targetname, "tromeo_guys_03"))
      var_16[var_16.size] = var_6;
  }

  goal_ent_player(1000, var_16);
  var_19 = [];
  var_19 = spawn_check_func(31, "fob_guys_exit");

  if(isDefined(var_19) && isDefined(var_19[0]) && var_19.size > 0) {
    foreach(var_6 in var_19) {
      var_6 scripts\engine\sp\utility::set_goal_radius(1100);
      var_6 setgoalpos((-40644, 33949, -636));
    }
  }

  scripts\engine\utility::flag_wait("fob_exit_guards");
  var_22 = spawn_check_func(31, "umike_03_guys_behind");
  var_19 = spawn_check_func(31, "fob_guys_exit_guards");
  scripts\engine\utility::flag_set("fob_spawns_complete");
  goal_ent_player(1000);
  thread door_bust_scene();
  wait 1;
  var_23 = getaiarray("axis");

  if(isalive(level.door_bust_guy))
    var_23 = scripts\engine\utility::array_remove(var_23, level.door_bust_guy);

  while(var_23.size > 4) {
    var_23 = scripts\engine\utility::array_removedead_or_dying(var_23);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("fob_exit");
  waitframe();
  var_23 = getaiarray("axis");

  if(isalive(level.door_bust_guy))
    var_23 = scripts\engine\utility::array_remove(var_23, level.door_bust_guy);

  var_23 = scripts\engine\utility::array_remove_array(var_23, level.enemy_armory_guards);

  foreach(var_6 in var_23) {
    var_6 cleargoalvolume();
    var_6.ignoresuppression = 1;
    var_6.ignoreme = 0;
    var_6.attackeraccuracy = 1;
    var_6 setgoalpos(var_6.origin);
    var_6 scripts\engine\sp\utility::set_goal_radius(800);
    var_6 setgoalentity(level.player);
    var_6.goalheight = 72;
  }

  scripts\engine\utility::flag_set("kill_tower_snipers");
  var_23 = getaiarray("axis");

  if(isalive(level.door_bust_guy))
    var_23 = scripts\engine\utility::array_remove(var_23, level.door_bust_guy);

  var_23 = scripts\engine\utility::array_remove_array(var_23, level.enemy_armory_guards);

  while(var_23.size > 0) {
    var_23 = scripts\engine\utility::array_removedead_or_dying(var_23);
    wait 0.1;
  }

  if(isalive(level.door_bust_guy)) {
    if(scripts\engine\utility::flag("door_bust_go") || scripts\engine\utility::flag("door_bust_behind")) {
      while(isalive(level.door_bust_guy))
        waitframe();
    } else {
      level notify("clear_door_bust");
      level.door_bust_guy scripts\common\ai::stop_magic_bullet_shield();
      level.door_bust_guy delete();
    }
  }

  scripts\engine\utility::flag_set("fob_cleared");
}

tower_guy_cleanup() {}

rooftop_directoring(var_0) {
  if(var_0.size < 1) {
    return;
  }
  var_1 = 0.85;
  var_2 = scripts\engine\utility::getStruct("general_01_struct", "targetname");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  var_3 = sortbydistance(var_0, var_2.origin)[0];

  if(!isDefined(var_3)) {
    return;
  }
  var_3 endon("death");
  var_3 endon("break_out");
  wait 0.1;

  if(!isalive(var_3)) {
    return;
  }
  var_3.target = undefined;
  var_3 clearpath();
  var_3.allowdeath = 1;
  var_3.animname = "enemy_03";
  var_2 scripts\sp\anim::anim_reach_solo(var_3, "directing_03");
  var_3 setgoalpos(var_3.origin);
  var_3 scripts\engine\sp\utility::set_goal_radius(2);

  for(;;) {
    if(1200 > distance(level.player.origin, var_3.origin)) {
      break;
    }

    if(level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, var_1)) {
      break;
    }

    waitframe();
  }

  var_3 thread directing_breakout();
  var_2 scripts\common\anim::anim_single_solo(var_3, "directing_03");
  var_3 notify("breakout");
}

directing_breakout() {
  self endon("death");
  scripts\engine\utility::waittill_any("damage", "breakout");
  self notify("breakout");

  if(!scripts\engine\utility::flag("fob_spawns_complete"))
    return;
}

tower_spawner_logic(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  var_2 = getspawner(var_0, "targetname");

  if(var_2.count == 0) {
    return;
  }
  var_3 = scripts\engine\sp\utility::spawn_targetname(var_0);
  var_3.forceragdollimmediate = 1;
  var_3 allowedstances("stand");
  var_3 scripts\engine\sp\utility::set_goal_radius(64);
  var_3 thread ally_drone_attack();
  var_2 = getspawner(var_0, "targetname");
  var_2.count = 1;
  return var_3;
}

ally_drone_attack(var_0) {
  self endon("death");
  level endon("fob_cleared");
  var_1 = "fob_allyDroneStartNode_t1";

  if(scripts\engine\utility::is_equal(self.targetname, "tower_guy_fob_02"))
    var_1 = "fob_allyDroneStartNode_t2";

  if(level.tower_drone_target) {
    return;
  }
  var_2 = level.player getEye();
  var_3 = 0.9998;

  if(isDefined(var_0))
    var_1 = "fob_allyDroneStartNode_t3";

  while(!scripts\engine\utility::flag("kill_tower_snipers")) {
    if(isDefined(var_0)) {
      break;
    }

    var_4 = distance(level.player.origin, self.origin);

    if(var_4 < 1000) {
      if(level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_3)) {
        break;
      }
    }

    waitframe();
  }

  if(level.tower_drone_target) {
    return;
  }
  if(scripts\engine\utility::is_equal(self.targetname, "tower_guy_fob_02")) {
    var_1 = "fob_allyDroneStartNode_t2";
    wait 1;
  }

  var_5 = getvehiclenode(var_1, "targetname");
  var_6 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::level_dronespawnVehicle(var_5.origin, var_5.angles);
  var_6.maxhealth = 30000;
  thread scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::fly_allydronepathlogic(var_6, var_5);
}

player_weapon_class() {
  var_0 = weaponclass(level.player getcurrentweapon());

  if(var_0 == "rifle" || var_0 == "smg" || var_0 == "mg" || var_0 == "spread")
    return 0;
  else
    return 1;
}

spawn_printer() {
  for(;;) {
    if(scripts\engine\utility::flag("ai_spawner_busy"))
      waitframe();
  }
}

goal_ent_player(var_0, var_1) {
  var_2 = getaiarray("axis");

  if(isDefined(var_1))
    var_2 = var_1;

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4.targetname, "fob_guys_center_tower") || scripts\engine\utility::is_equal(var_4.targetname, "fob_guys_exit") || scripts\engine\utility::is_equal(var_4.targetname, "fob_guys_exit_guards") || scripts\engine\utility::is_equal(var_4.targetname, "armory_guards") || scripts\engine\utility::is_equal(var_4.targetname, "door_bust_guy") || scripts\engine\utility::is_equal(var_4.script_noteworthy, "tower_spawner")) {
      continue;
    }
    if(isDefined(var_4)) {
      var_4 setgoalpos(var_4.origin);
      var_4 scripts\engine\sp\utility::set_goal_radius(var_0);
      var_4 setgoalentity(level.player);
    }
  }
}

goal_ent_position(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStructArray(var_2, "targetname");
  var_4 = sortbydistance(var_4, level.player.origin);
  var_5 = getaiarray("axis");

  if(!isDefined(var_1)) {
    return;
  }
  if(isstring(var_1))
    var_5 = var_1;

  foreach(var_7 in var_5) {
    if(isDefined(var_3))
      wait(var_3);

    if(scripts\engine\utility::is_equal(var_7.targetname, "fob_guys_center_tower") || scripts\engine\utility::is_equal(var_7.targetname, "fob_guys_exit") || scripts\engine\utility::is_equal(var_7.targetname, "fob_guys_exit_guards") || scripts\engine\utility::is_equal(var_7.targetname, "armory_guards") || scripts\engine\utility::is_equal(var_7.script_noteworthy, "tower_spawner")) {
      continue;
    }
    if(isDefined(var_7)) {
      var_7 setgoalpos(var_4[0].origin + (0, 0, 0));
      var_7 scripts\engine\sp\utility::set_goal_radius(var_0);
    }
  }
}

armory_01_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  thread explode_tarmac_scriptables();
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\utility::flag_set("fly_attack_done");
  scripts\engine\utility::flag_set("bunkers_breached");
  scripts\engine\utility::flag_set("fob_exit_guards");
  scripts\engine\utility::flag_set("fob_cleared");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("fob_spawns_complete");
  scripts\engine\utility::flag_set("fob_player_in_center_swarm");
  scripts\engine\utility::flag_set("fob_cleared");
  scripts\engine\utility::flag_set("one_fob_helo_left");
  scripts\engine\utility::flag_set("no_fob_helos_left");
  scripts\engine\utility::flag_set("ally_fob_movement_complete");
  scripts\engine\sp\utility::set_start_location("fobCHU_start", [level.player]);
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(4);
  var_4 = charge_setalliestoredshirts();
  var_5 = fobchu_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var_4, [var_0, var_1, var_2]);

  foreach(var_7 in level.allies) {
    var_8 = scripts\engine\utility::random(var_5);
    var_7 scripts\engine\sp\utility::teleport_ai(var_8);
    var_5 = scripts\engine\utility::array_remove(var_5, var_8);
  }

  thread redshirt_refill();
  thread close_airport_gate(1);
  var_10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_10, ::delete);
  thread fob_umike_03(1);
  thread armory_01();
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::player_startallowdrones();
}

armory_01_main() {
  thread ally_movement_containers();
  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\sp\utility::autosave_now();
  scripts\engine\utility::flag_wait("armory_dialogue_complete");
  scripts\engine\utility::flag_wait("ally_fob_movement_complete");
}

armory_01_catchup() {
  scripts\engine\utility::flag_set("armory_01_trigger");
  scripts\engine\utility::flag_set("armory_01_secure");
  scripts\engine\utility::flag_set("fob_cleared");
}

containers_gate_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  thread explode_tarmac_scriptables();
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\utility::flag_set("ally_fob_movement_complete");
  scripts\engine\utility::flag_set("bunkers_breached");
  scripts\engine\utility::flag_set("fob_exit_guards");
  scripts\engine\utility::flag_set("fob_cleared");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("fob_spawns_complete");
  scripts\engine\utility::flag_set("fob_player_in_center_swarm");
  scripts\engine\utility::flag_set("armory_dialogue_complete");
  scripts\engine\utility::flag_set("armory_01_secure");
  scripts\engine\utility::flag_set("ally_armory_01_secure");
  scripts\engine\utility::flag_set("one_fob_helo_left");
  scripts\engine\utility::flag_set("no_fob_helos_left");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("fobCHU_start", [level.player, var_0, var_1]);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(5);
  var_4 = charge_setalliestoredshirts();
  var_5 = fobchu_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var_4, [var_2]);

  foreach(var_7 in level.allies) {
    var_8 = scripts\engine\utility::random(var_5);
    var_7 scripts\engine\sp\utility::teleport_ai(var_8);
    var_5 = scripts\engine\utility::array_remove(var_5, var_8);
  }

  thread redshirt_refill();
  thread close_airport_gate(1);
  var_10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_10, ::delete);
  level.gate_truck = scripts\engine\sp\utility::spawn_anim_model("gate_truck");
  level.containers_start = 1;
  thread ally_movement_containers();
}

containers_gate_main() {
  scripts\engine\utility::flag_wait("fob_exit");
  thread dialogue_containers_gate();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  scripts\engine\utility::flag_wait("hadir_at_truck");
  thread magic_clip_fix();
}

magic_clip_fix() {
  var_0 = getEnt("rc_door", "targetname");
  var_0.clip = var_0 scripts\engine\utility::get_target_ent();
  var_0.clip unlink();
  var_0.clip.origin = (-41310, 33727, -471);
  var_0.clip.angles = (0, 0, 0);
}

containers_truck_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  thread explode_tarmac_scriptables();
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  scripts\engine\utility::flag_set("fob_exit_guards");
  scripts\engine\utility::flag_set("fob_cleared");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("fob_spawns_complete");
  scripts\engine\utility::flag_set("fob_player_in_center_swarm");
  scripts\engine\utility::flag_set("armory_dialogue_complete");
  scripts\engine\utility::flag_set("armory_01_secure");
  scripts\engine\utility::flag_set("ally_armory_01_secure");
  scripts\engine\utility::flag_set("hadir_ramming_dialogue_complete");
  scripts\engine\utility::flag_set("hadir_at_gate");
  scripts\engine\utility::flag_set("hadir_at_goal");
  scripts\engine\utility::flag_set("one_fob_helo_left");
  scripts\engine\utility::flag_set("no_fob_helos_left");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("fobCHU_start", [level.player, var_0]);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(5);
  var_4 = charge_setalliestoredshirts();
  var_5 = fobchu_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var_4, [var_2]);

  foreach(var_7 in level.allies) {
    var_8 = scripts\engine\utility::random(var_5);
    var_7 scripts\engine\sp\utility::teleport_ai(var_8);
    var_5 = scripts\engine\utility::array_remove(var_5, var_8);
  }

  thread ally_movement_containers(1);
  thread redshirt_refill();
  thread close_airport_gate(1);
  level.gate_truck = scripts\engine\sp\utility::spawn_anim_model("gate_truck");
  var_10 = scripts\engine\utility::getStruct("hadir_truck_enter_struct", "targetname");
  var_1 forceteleport(var_10.origin, var_10.angles);
  var_11 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_11, ::delete);
}

containers_truck_main() {
  thread scene_truck_gate();
  scripts\engine\utility::flag_wait("hadir_ramming_dialogue_complete");
  thread dialogue_containers_gate_smash();
  scripts\engine\utility::flag_wait("hadir_in_truck");
  level.armen scripts\common\ai::stop_magic_bullet_shield();
  level.armen.health = 20;
  thread player_clear_of_truck_watcher();
  level waittill("gate_down");
  scripts\engine\utility::exploder("truck_hit");
  thread vo_walla_truck_gate_charge();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::ai_getaliveaiarray("axis");
  scripts\engine\sp\utility::array_kill(var_0);
  scripts\engine\utility::flag_set("container_door_breached");
  wait 1;
  scripts\common\vehicle::spawn_vehicle_from_targetname("chu_chopper");
  scripts\engine\utility::flag_wait("strafe_setup");

  if(isDefined(level.chu_chopper))
    level.chu_chopper scalevolume(0.0, 0.0);

  level.drone_start_position = spawnStruct();
  level.drone_start_position.origin = (-40153, 35374, -124);
  level.drone_start_position.angles = (5, 230, 0);
  thread scripts\sp\analytics::analytics_kleenex_update("Bunkers to Containers");
  scripts\engine\utility::flag_wait("chu_strafe_run_go");
  thread fob_enemies_chu();
  scripts\engine\sp\utility::autosave_by_name("chu_strafe_run");

  if(isDefined(level.chu_chopper))
    level.chu_chopper scalevolume(1.0, 2.0);

  scripts\engine\utility::flag_wait("chu_entrance");
  level.drone_start_position = spawnStruct();
  level.drone_start_position.origin = (-41431, 35377, 38);
  level.drone_start_position.angles = (5, 259, 0);
  scripts\engine\sp\utility::autosave_by_name("chu_entrance");
  scripts\engine\utility::flag_wait("chu_rear");
  scripts\engine\sp\utility::autosave_by_name("chu_rear");
  var_1 = spawn_check_func(32, "fob_guys_chu_rear");
  thread chu_guys_alive_check();
  scripts\engine\utility::flag_wait("chu_exit");
  scripts\engine\sp\utility::autosave_by_name("chu_exit");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::remove_corpses_away_from_player_pos(1200);
}

containers_truck_catchup() {
  scripts\engine\utility::flag_set("hadir_ramming_dialogue_complete");
  scripts\engine\utility::flag_set("farah_gate_lookat");
  scripts\engine\utility::flag_set("container_door_breached");
}

door_bust_scene() {
  level endon("clear_door_bust");
  var_0 = scripts\engine\sp\utility::spawn_targetname("door_bust_guy", 1);
  var_0 endon("death");
  level.door_bust_guy = var_0;
  var_0.animname = "enemy_01";
  var_0 scripts\engine\sp\utility::set_deathanim("door_bust_death");
  var_0.allowdeath = 1;
  var_1 = scripts\engine\utility::getStruct("door_bust_struct", "targetname");
  var_1 scripts\sp\anim::anim_reach_solo(var_0, "door_bust");
  var_0 thread scripts\common\ai::magic_bullet_shield();
  var_0 setgoalpos(var_0.origin);
  var_0 scripts\engine\sp\utility::set_goal_radius(10);
  var_0.ignoreall = 1;
  var_2 = getscriptablearray("door_bust_door", "targetname")[0];
  var_2.script_destructible = 1;
  var_2.animname = "door_scriptable";
  var_2 scripts\engine\sp\utility::assign_animtree();
  var_2.clip = var_2 scripts\engine\utility::get_linked_ent();
  var_2.clip linkTo(var_2);
  var_0 endon("entitydeleted");
  scripts\engine\utility::flag_wait_any("door_bust_go", "door_bust_behind");
  var_1 scripts\sp\anim::anim_reach_solo(var_0, "door_bust");
  var_0 thread scripts\common\ai::stop_magic_bullet_shield();
  var_0.ignoreall = 0;
  var_0 scripts\engine\sp\utility::set_goal_radius(256);
  var_1 thread scripts\common\anim::anim_single_solo(var_0, "door_bust");
  var_2 setflaggedanim("single anim", var_2 scripts\engine\utility::getanim("door_bust"), 1);
  var_2.clip connectpaths();
  wait 1;

  if(scripts\engine\utility::flag("door_bust_behind")) {
    var_3 = scripts\engine\sp\utility::spawn_targetname("door_bust_ally", 1);
    var_3 scripts\engine\sp\utility::set_force_color("r");
    var_3.health = 1;
    return;
  }

  wait 1;
  var_0 stopanimScripted();
}

vo_walla_truck_gate_charge() {
  wait 1.5;
  var_0 = spawn("script_origin", level.armen.origin);
  var_0 linkTo(level.armen);
  var_0 playSound("sh_walla_finale_ram_gate_charge", "sounddone");
  var_0 waittill("sounddone");
  var_0 delete();
}

nav_bad_place_truck_path() {
  var_0 = getEnt("gate_truck_reverse_trigger", "targetname");
  var_1 = createnavbadplacebyent(var_0, "allies");
  scripts\engine\utility::flag_wait("container_door_breached");
  destroynavobstacle(var_1);
}

player_clear_of_truck_watcher() {
  scripts\engine\utility::flag_wait("hadir_in_truck");
  var_0 = getEnt("gate_truck_reverse_trigger", "targetname");
  var_1 = getEnt("armory_01_trigger", "targetname");
  var_2 = 0;

  while(level.player istouching(var_0) || level.player istouching(var_1)) {
    if(!var_2)
      var_2 = 1;

    waitframe();
  }

  wait 2;
  scripts\engine\utility::flag_set("hadir_gate_smash");
  scripts\engine\utility::flag_set("hadir_gate_smash_stop");
}

player_clear_truck_nag(var_0) {
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  level endon("hadir_gate_smash");

  for(;;) {
    wait 5;

    if(level.player istouching(var_0))
      var_1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dialogue("Alex, I'm going to hit the gate with the truck.");

    wait 8;
  }
}

player_clear_armory_nag(var_0) {
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  level endon("hadir_gate_smash");

  for(;;) {
    if(level.player istouching(var_0))
      var_1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dialogue("Get what you need and get back out here, Alex.");

    wait 15;

    if(level.player istouching(var_0))
      var_1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dialogue("Alex, I'm going to hit the gate with the truck.");

    wait 10;
  }
}

chu_guys_alive_check() {
  while(!scripts\engine\utility::flag("chu_exit")) {
    var_0 = getaiarray("axis");

    if(var_0.size < 2)
      scripts\engine\utility::flag_set("chu_exit");

    waitframe();
  }
}

close_airport_gate(var_0) {
  thread airport_gate_trigger(var_0);

  if(!isDefined(var_0)) {
    while(!scripts\engine\utility::flag("fob_exit") && level.airport_gate_open)
      waitframe();
  }

  var_1 = 2;

  if(isDefined(var_0))
    var_1 = 0.1;

  var_2 = getEnt("airport_gate", "targetname");
  var_2.clip = getEnt("airport_gate_clip", "targetname");
  var_2.struct = var_2 scripts\engine\utility::get_target_ent();
  var_2.clip linkTo(var_2);
  var_3 = getEntArray("airport_gate_barbs", "targetname");

  foreach(var_5 in var_3) {
    var_5.origin = (var_2.origin[0], var_5.origin[1], var_5.origin[2]);
    var_5 linkTo(var_2);
  }

  level notify("airport_gate_closed");
  var_2 moveTo(var_2.struct.origin, var_1);
  wait(var_1 + 0.1);
  var_2.clip disconnectPaths();
}

airport_gate_trigger(var_0) {
  if(isDefined(var_0)) {
    return;
  }
  level endon("chu_entrance");

  while(!isDefined(level.fob_umike_03))
    waitframe();

  level.fob_umike_03 endon("entitydeleted");
  var_1 = getEnt("gate_truck_trigger", "targetname");

  while(!level.fob_umike_03 istouching(var_1))
    waitframe();

  level.airport_gate_open = 0;
}

chu_explosion() {
  var_0 = scripts\engine\utility::getStruct("fuel_trailer", "targetname");
  var_1 = scripts\engine\utility::getStruct("fuel_tank_struct", "targetname");
  wait 1.5;
  scripts\engine\utility::flag_set("chu_fire_lights");
  scripts\engine\utility::exploder("explo_02");
  thread explosion_and_fire_sounds();
  level notify("chu_fire_start");
  radiusdamage(var_0.origin, 200, 500, 100);
  createnavbadplacebybounds(var_0.origin, (150, 150, 50), var_0.angles, "allies");
}

explosion_and_fire_sounds() {
  thread scripts\engine\utility::play_sound_in_space("weap_hellfire_impact", (-41495, 33496, -560));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_large_metal_lp_02", (-41442, 33589, -569));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_metal_car_lp_01", (-41297, 33886, -605));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_small_lp_04", (-41355, 33755, -605));
}

fob_enemies_chu() {
  var_0 = spawn_check_func(32, "fob_guys_chu_strafe");

  foreach(var_2 in var_0) {
    var_2.baseaccuracy = 0.1;
    var_2.ignoreme = 1;
  }

  scripts\engine\utility::flag_wait("chu_entrance");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  foreach(var_2 in var_0) {
    var_2.baseaccuracy = 0.2;
    var_2.ignoreme = 0;
  }

  var_6 = getEnt("fob_chu_vol", "targetname");
  var_7 = spawn_check_func(32, "fob_guys_chu");

  foreach(var_2 in var_7) {
    var_2 getenemyinfo(level.farah);
    var_2.grenadeammo = 0;
  }

  var_7 = scripts\engine\utility::array_combine(var_7, var_0);
  thread chu_right_side();
  thread chu_molotov_death();
  scripts\engine\utility::flag_wait("chu_rear");
  var_10 = getEnt("chu_rear_nav_obstacle", "targetname");
  var_10 = createnavbadplacebyent(var_10, "axis");
  waitframe();
  var_7 = scripts\engine\utility::array_removedead_or_dying(var_7);
  goal_ent_position(800, var_7, "chu_rear_goal");
  scripts\engine\utility::flag_wait("chu_exit");
  waitframe();
  var_7 = scripts\engine\utility::array_removedead_or_dying(var_7);

  foreach(var_2 in var_7) {
    var_2 setgoalpos(var_2.origin);
    var_2 scripts\engine\sp\utility::set_goal_radius(500);
    var_2 scripts\engine\utility::set_movement_speed(150);
    var_2 setgoalentity(level.player);
  }
}

chu_right_side() {
  level endon("chu_rear");
  level.fob_guys_chu_right = [];
  scripts\engine\utility::flag_wait("chu_right_side");
  level.fob_guys_chu_right = spawn_check_func(32, "fob_guys_chu_right", 3);
  directing_01(level.fob_guys_chu_right);
  level.fob_guys_chu_right = scripts\engine\utility::array_removedead_or_dying(level.fob_guys_chu_right);

  foreach(var_1 in level.fob_guys_chu_right) {
    var_1 scripts\engine\sp\utility::set_goal_radius(600);
    var_1 getenemyinfo(level.player);
    var_1 setgoalentity(level.player);
  }
}

chu_molotov_death() {
  level endon("chu_exit");
  scripts\engine\utility::flag_wait("chu_right_side");
  scripts\engine\sp\utility::trigger_wait_targetname("molotov_guy_trig");
  var_0 = spawn_check_func(32, "chu_molotov_death");
  var_0[0].baseaccuracy = 0;
  var_0[0] endon("death");
  var_0[0] getenemyinfo(level.player);
  var_1 = scripts\engine\utility::getStruct("molotov_guy_struct", "targetname");
  var_2 = getnode("molotov_node", "targetname");
  var_3 = level.farah magicgrenade(var_1.origin, var_2.origin);

  if(isDefined(var_3))
    var_3 endon("entitydeleted");

  scripts\sp\equipment\molotov::molotovfiremain(var_3);
}

tarmac_start() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  scripts\engine\utility::flag_set("fly_attack_done");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("bunkers_breached");
  scripts\engine\utility::flag_set("chu_strafe_run");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("tarmac_enter");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("chu_rear");
  scripts\engine\utility::flag_set("chu_exit");
  scripts\engine\utility::flag_set("boss_turret_disabled");
  scripts\engine\utility::flag_set("chu_chopper_first_attack_done");
  scripts\engine\utility::flag_set("container_door_breached");
  scripts\engine\utility::flag_set("chu_chopper_first_attack_done");
  scripts\engine\utility::flag_set("fob_spawns_complete");
  scripts\engine\utility::flag_set("armory_01_secure");
  scripts\engine\utility::flag_set("boss_chopper_dead");
  scripts\engine\utility::flag_set("containers_vo_finished");
  scripts\engine\sp\utility::set_start_location("trenchRun_start", [level.player]);
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(5);
  var_3 = charge_setalliestoredshirts();
  var_4 = trenchrun_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var_3, [var_0, var_1]);

  foreach(var_6 in level.allies) {
    var_7 = scripts\engine\utility::random(var_4);
    var_6 scripts\engine\sp\utility::teleport_ai(var_7);
    var_4 = scripts\engine\utility::array_remove(var_4, var_7);
  }

  thread chu_right_side();
  thread redshirt_refill();
  thread explode_tarmac_scriptables();
  scripts\engine\utility::flag_set("tarmac_enter");
  var_9 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_9, ::delete);
  var_10 = scripts\sp\utility::make_weapon("iw8_la_mike32_incendiary", ["lnchrscope_mike32"]);
  level.player scripts\sp\utility::give_weapon(var_10);
}

tarmac_main() {
  scripts\engine\utility::flag_wait("chu_exit");
  thread dialogue_tarmac();
  thread hangar_drag_scene();
  thread explode_tarmac_scriptables_by_trigger();
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  level.ally_volume = getEnt("tarmac_volume", "targetname");

  if(!istrue(level.tarmac_tower.collapsed))
    level.tarmac_tower_guy = tower_spawner_logic("tower_guy_tarmac");

  var_2 = spawn_check_func(32, "tarmac_guys_front", 2);
  var_3 = spawn_check_func(32, "tarmac_guys", 10);
  var_4 = spawn_check_func(32, "tarmac_guys_rear_guard");

  foreach(var_6 in var_3) {
    var_6.ignoreall = 1;
    var_6.baseaccuracy = 0.1;
  }

  if(scripts\engine\utility::flag("boss_chopper_dead")) {
    level.drone_start_position = spawnStruct();
    level.drone_start_position.origin = (-41830, 33562, -217);
    level.drone_start_position.angles = (5, -90, 0);

    if(scripts\engine\utility::flag("player_in_drone"))
      scripts\engine\utility::flag_waitopen("player_in_drone");

    scripts\engine\sp\utility::autosave_by_name("chu_exit");
  }

  scripts\engine\utility::flag_wait("tarmac_enter");
  level.allies = getaiarray("allies");

  foreach(var_6 in level.allies) {
    var_6 setgoalpos(var_6.origin);
    var_6 scripts\engine\sp\utility::set_goal_radius(1200);
    var_6 scripts\engine\sp\utility::clear_force_color();
    var_6 scripts\engine\sp\utility::set_force_color("p");
  }

  thread tarmace_player_allies();
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_00");
  thread ally_rpg_guy();
  var_10 = getaiarray("axis");

  foreach(var_6 in var_10) {
    var_6.ignoreall = 0;
    var_6.baseaccuracy = 0.2;
  }

  var_3 = scripts\engine\utility::array_removedead_or_dying(var_3);
  goal_ent_position(2000, var_3, "tarmac_goal_rear");
  thread tarmac_push_player(var_3);
  scripts\engine\utility::flag_wait("tarmac_front");
  scripts\engine\sp\utility::autosave_by_name("tarmac_front");
  var_13 = scripts\engine\sp\utility::array_spawn_targetname("hangar_snipers", 1);

  if(var_13.size > 0)
    var_13[0] scripts\engine\sp\utility::set_favoriteenemy(level.player);

  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_01");
  thread tarmace_player_allies();
  scripts\engine\utility::flag_wait("tarmac_mid");
  thread fob_scriptables_cleanup();
  scripts\engine\sp\utility::autosave_by_name("tarmac_mid");
  thread tarmace_player_allies();
  var_14 = spawn_check_func(32, "tarmac_guys_rear", 5);
  goal_ent_player(600, var_14);
  scripts\engine\utility::flag_wait("tarmac_rear");
  thread tarmace_player_allies();
  var_15 = spawn_check_func(32, "tarmac_guys_hangar_entrance");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_02");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_03");
  var_10 = getaiarray("axis");
  var_10 = scripts\engine\utility::array_removedead_or_dying(var_10);
  level.ally_volume = getEnt("tarmac_rear_volume", "targetname");

  foreach(var_6 in var_10) {
    var_6 setgoalpos(var_6.origin);
    var_6 setgoalvolumeauto(level.ally_volume);
  }

  thread hangar_allies_move_up();
  scripts\engine\utility::flag_wait("hangar_entrance");

  if(isDefined(level.tarmac_tower_guy))
    level.tarmac_tower_guy kill();

  var_10 = getaiarray("axis");
  var_10 = scripts\engine\utility::array_removedead_or_dying(var_10);

  foreach(var_6 in var_10) {
    if(scripts\engine\utility::is_equal(var_6.targetname, "tower_guy_tarmac")) {
      continue;
    }
    var_6 setgoalpos(var_6.origin);
    var_6 scripts\engine\sp\utility::set_goal_radius(500);
    var_6 scripts\engine\utility::set_movement_speed(150);
    var_6 setgoalentity(level.player);
  }

  var_20 = getEnt("hangar_volume", "targetname");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_04");
  scripts\engine\sp\utility::autosave_by_name("tarmac_color_04");
  level.fob_enemies = getaiarray("axis");

  foreach(var_6 in level.fob_enemies) {
    if(scripts\engine\utility::is_equal(var_6.targetname, "tower_guy_tarmac")) {
      continue;
    }
    var_6 cleargoalvolume();
    var_6.ignoresuppression = 1;
    var_6.ignoreme = 0;
    var_6 setgoalpos(var_6.origin);
    var_6 scripts\engine\sp\utility::set_goal_radius(500);
    var_6 setgoalentity(level.player);
  }

  while(level.fob_enemies.size > 0 && !scripts\engine\utility::flag("hangar_interior")) {
    level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
    wait 0.1;

    if(level.fob_enemies.size == 0)
      scripts\engine\utility::flag_set("hangar_interior");
  }

  scripts\engine\utility::flag_set("tarmac_cleared");
}

fob_scriptables_cleanup() {
  var_0 = [];
  var_1 = getscriptablearray();

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.model, "door_wooden_hollow_rl_01_destr")) {
      var_0[var_0.size] = var_3;
      var_3 thread scripts\sp\door::remove_open_prompts();
      var_3.origin = var_3.origin + (0, 0, -4000);
      var_3 hide();
    }
  }
}

ally_rpg_guy() {
  var_0 = (-43000.5, 29836, -340);
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  scripts\engine\utility::flag_wait("tarmac_mid");

  if(istrue(level.tarmac_tower.collapsed)) {
    return;
  }
  var_2 = getEntArray("tower_guy_tarmac", "targetname")[0];
  var_3 = scripts\engine\sp\utility::spawn_targetname("ally_rpg_guy", 1);
  var_4 = var_3 scripts\engine\utility::get_target_ent();
  var_3 scripts\engine\sp\utility::set_goal_radius(32);
  var_3 endon("death");
  var_3 scripts\engine\sp\utility::set_ignoresuppression(1);
  var_3 allowedstances("stand");
  var_3 clearpath();
  var_3 setgoalpos(var_4.origin);
  var_3 waittill("goal");
  var_3.ignoreme = 1;
  var_3 scripts\common\ai::magic_bullet_shield();
  var_3 setentitytarget(var_1);
  var_5 = missile_createattractorent(var_1, 2000, 3000);
  level scripts\engine\utility::waittill_any("tower_collapse", "tarmac_rear");
  missile_deleteattractor(var_5);
  var_3 scripts\common\ai::stop_magic_bullet_shield();
  var_3.ignoreall = 1;
  wait 4;
  var_3 clearentitytarget();
  var_6 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var_3 scripts\anim\shared.gsc::forceuseweapon(var_6, "primary");
  wait 1;
  var_3.ignoreall = 0;
}

hangar_drag_scene() {
  var_0 = scripts\engine\utility::getStruct("drag_struct", "targetname");
  var_0.origin = var_0.origin + (0, 0, -4);
  var_1 = scripts\engine\sp\utility::spawn_targetname("hangar_drag_guy_01", 1);
  var_1 scripts\common\ai::magic_bullet_shield();
  var_1.animname = "enemy_01";
  var_1.forceragdollimmediate = 1;
  var_0 scripts\common\anim::anim_first_frame_solo(var_1, "drag_scene_drag");
  scripts\engine\utility::flag_wait("tarmac_rear");
  var_2 = scripts\engine\sp\utility::spawn_targetname("hangar_drag_guy_02", 1);
  var_2.animname = "enemy_02";
  var_2.forceragdollimmediate = 1;
  var_2.allowdeath = 1;
  var_1.allowdeath = 1;
  var_1.ignoreme = 1;
  var_2.ignoreall = 1;
  var_2.ignoreme = 1;
  var_2 scripts\common\ai::magic_bullet_shield();
  var_1.health = 100;
  var_1 thread budy_death_watcher(var_2);
  var_2 thread budy_death_watcher(var_1);
  var_0 scripts\sp\anim::anim_reach_solo(var_2, "drag_scene_drag");
  var_1 scripts\common\ai::stop_magic_bullet_shield();
  var_2 scripts\common\ai::stop_magic_bullet_shield();
  var_0 thread scripts\common\anim::anim_single_solo(var_2, "drag_scene_drag");
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "drag_scene_drag");
  var_1 thread drug_guy_kill();
  var_1 endon("death");
  var_2 endon("death");
  var_2.ignoreall = 0;
}

drug_guy_kill() {
  self endon("death");
  self waittillmatch("single anim", "end");
  level notify("stop_buddy_watching");
  waitframe();
  self kill();
}

budy_death_watcher(var_0) {
  level endon("stop_buddy_watching");
  self endon("death");
  var_0 waittill("death");

  if(self.targetname == "hangar_drag_guy_02") {
    self allowedstances("crouch");
    scripts\engine\sp\utility::set_goal_radius(20);
    self stopanimScripted();
    self.ignoreme = 0;
    self setgoalpos(self.origin);
    return;
  }

  self kill();
}

tarmac_catchup() {
  var_0 = getEnt("chu_chopper_clip", "targetname");
  var_0 delete();
  scripts\engine\utility::flag_set("tarmac_mid");
  scripts\engine\utility::flag_set("boss_chopper_dead");
}

tarmace_player_allies() {
  var_0 = getaiarray("allies");
  var_0 = scripts\engine\utility::array_remove(var_0, level.farah);
  var_0 = scripts\engine\utility::array_remove(var_0, level.hadir);
  var_0 = sortbydistance(var_0, level.player.origin);

  if(isDefined(var_0[0])) {
    var_1 = var_0[0];
    var_1.fixednode = 0;
    var_1 scripts\engine\sp\utility::clear_force_color();
    var_1 scripts\engine\sp\utility::set_goal_radius(700);
    var_1 setgoalentity(level.player);
  }

  if(isDefined(var_0[1])) {
    var_1 = var_0[1];
    var_1 scripts\engine\sp\utility::clear_force_color();
    var_1.fixednode = 0;
    var_1 scripts\engine\sp\utility::set_goal_radius(700);
    var_1 setgoalentity(level.player);
  }
}

hangar_allies_move_up() {
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::enemy_alive_counter_gate(0);
  scripts\engine\utility::flag_set("hangar_entrance");
}

armory_02_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("chu_strafe_run");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("tarmac_enter");
  scripts\engine\utility::flag_set("tarmac_mid");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("chu_rear");
  scripts\engine\utility::flag_set("chu_exit");
  scripts\engine\utility::flag_set("boss_turret_disabled");
  scripts\engine\utility::flag_set("chu_chopper_first_attack_done");
  scripts\engine\utility::flag_set("container_door_breached");
  scripts\engine\utility::flag_set("chu_chopper_first_attack_done");
  scripts\engine\utility::flag_set("fob_spawns_complete");
  scripts\engine\utility::flag_set("tarmac_enter");
  scripts\engine\utility::flag_clear("drone_allowed");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_armory_02", [level.player, var_0, var_1]);
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(5);
  var_3 = charge_setalliestoredshirts();
  var_4 = towerstairs_getallycovernodes();
  var_5 = var_3;

  foreach(var_7 in level.allies) {
    var_8 = scripts\engine\utility::random(var_4);
    var_7 scripts\engine\sp\utility::teleport_ai(var_8);
    var_4 = scripts\engine\utility::array_remove(var_4, var_8);
  }

  level.allies = getaiarray("allies");

  foreach(var_11 in level.allies) {
    var_11 setgoalpos(var_11.origin);
    var_11 scripts\engine\sp\utility::clear_force_color();
    var_11 scripts\engine\sp\utility::set_force_color("p");
  }

  thread redshirt_refill();
  thread explode_tarmac_scriptables();
  var_13 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_13, ::delete);
}

armory_02_main() {
  level.player setsoundsubmix("sp_npc_steps_down", 1.0, 1.0);
  scripts\engine\sp\utility::autosave_by_name("armory_02");
  scripts\engine\sp\utility::activate_trigger_with_targetname("hangar_defend_start_color");
  scripts\engine\utility::trigger_off("hangar_defend_flag_trig", "targetname");
  thread dialogue_armory_02();
  thread dialogue_armory_boost();
  thread armory_02();
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_06");
  var_0 = [level.farah, level.hadir];

  foreach(var_2 in var_0) {
    var_2 setgoalpos(var_2.origin);
    var_2 scripts\engine\sp\utility::clear_force_color();
    var_2 scripts\engine\sp\utility::set_force_color("b");
  }

  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    if(var_2 == level.farah || var_2 == level.hadir) {
      continue;
    }
    var_2 setgoalpos(var_2.origin);
    var_2 scripts\engine\sp\utility::clear_force_color();
    var_2 scripts\engine\sp\utility::set_force_color("r");
  }

  scripts\engine\sp\utility::trigger_wait_targetname("armory_02_trigger");
  scripts\engine\utility::flag_set("entered_armory_02");
  scripts\engine\utility::exploder("hangar_enemy_smoke");
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir setgoalentity(level.farah);
  level.hadir scripts\engine\sp\utility::set_goal_radius(200);
  scripts\engine\utility::flag_wait("armory_02_secure");
  scripts\engine\utility::trigger_on("hangar_defend_flag_trig", "targetname");
  scripts\engine\sp\utility::autosave_by_name("armory_02_secure");
}

explode_tarmac_scriptables() {
  wait 0.1;
  var_0 = getscriptablearray("tarmac_scriptables", "targetname");

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.model, "veh8_mil_lnd_tromeo_black")) {
      if(var_2 getscriptableparthasstate("base", "dead"))
        var_2 setscriptablepartstate("base", "dead", 1, 1);

      if(var_2 getscriptableparthasstate("body", "dead"))
        var_2 setscriptablepartstate("body", "dead", 1, 1);

      continue;
    }

    if(var_2 getscriptableparthasstate("base", "dead"))
      var_2 setscriptablepartstate("base", "dead", 1, 1);

    if(var_2 getscriptableparthasstate("body", "dead"))
      var_2 setscriptablepartstate("body", "dead", 1, 1);

    var_2.origin = var_2.origin + (0, 0, -2000);
  }

  var_4 = getEntArray("fuel_truck_corpse", "targetname");
  scripts\engine\utility::array_call(var_4, ::show);
}

explode_tarmac_scriptables_by_trigger() {
  wait 0.1;
  var_0 = getscriptablearray("tarmac_truck_r2", "targetname");
  scripts\engine\utility::flag_wait("tarmac_front");
  wait 2;

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("body", "dead", 1);

  var_0 = getscriptablearray("tarmac_truck_l1", "targetname");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("body", "onfire", 1);

  var_0 = getscriptablearray("tarmac_truck_l1", "targetname");
  scripts\engine\utility::flag_wait("tarmac_mid");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("body", "dead", 1);

  var_0 = getscriptablearray("tarmac_truck_r1", "targetname");
  scripts\engine\utility::flag_wait("tarmac_mid");
  wait 4;

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("body", "dead", 1);
}

tarmac_push_player(var_0) {
  while(var_0.size) {
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
    var_0 = sortbydistance(var_0, level.player.origin);

    if(isDefined(var_0[0])) {
      var_0[0] scripts\engine\sp\utility::set_goal_radius(600);
      var_0[0] scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var_0[0] scripts\engine\utility::set_movement_speed(150);
      var_0[0] setgoalentity(level.player);
      var_0[0] waittill("death");
    }

    waitframe();
  }
}

hangar_defend_start() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("chu_strafe_run");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("tarmac_enter");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("chu_rear");
  scripts\engine\utility::flag_set("chu_exit");
  scripts\engine\utility::flag_set("tarmac_mid");
  scripts\engine\utility::flag_set("boss_turret_disabled");
  scripts\engine\utility::flag_set("chu_chopper_first_attack_done");
  scripts\engine\utility::flag_set("container_door_breached");
  scripts\engine\utility::flag_set("chu_chopper_first_attack_done");
  scripts\engine\utility::flag_set("fob_spawns_complete");
  scripts\engine\utility::flag_set("tarmac_enter");
  scripts\engine\utility::flag_clear("drone_allowed");
  scripts\engine\utility::flag_set("hangar_defend_start");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_killstreak_ending", [level.player, var_0, var_1]);
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(1);
  var_3 = charge_setalliestoredshirts();
  var_4 = towerstairs_getallycovernodes();

  foreach(var_6 in level.allies) {
    var_7 = scripts\engine\utility::random(var_4);
    var_6 scripts\engine\sp\utility::teleport_ai(var_7);
    var_4 = scripts\engine\utility::array_remove(var_4, var_7);
  }

  var_9 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_9, ::delete);
  scripts\engine\sp\utility::activate_trigger_with_targetname("hangar_defend_start_color");
}

hangar_defend_main() {
  thread tarmac_badplace();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  level.vtclassname = "script_vehicle_iw8_truck_umike_covered";
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/lab/vfx_temp_lrg_veh_death.vfx", "tag_origin", "rocket_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_tank_death_exp.vfx", "tag_origin");
  level.vtclassname = "script_vehicle_iw8_vindia_a1";
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/bromeo/vfx_tank_death_exp_plume.vfx", "tag_origin", "rocket_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_tank_death_exp.vfx", "tag_origin");
  scripts\engine\utility::flag_wait("hangar_defend_start");

  if(!scripts\engine\utility::flag("hangar_defend_start"))
    level scripts\engine\utility::flag_set("power_kill");

  if(scripts\engine\utility::flag("hangar_defend_start"))
    thread scripts\engine\utility::flag_set_delayed("power_kill", 5);

  level.hadir.name = "Hadir";
  visionsetnaked("safehouse_finale_tarmac_end", 0.05);
  thread pallet_smash();
  level.player scripts\sp\utility::set_player_attacker_accuracy(0.15);
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("hangar_defend_infantry", 1);

  foreach(var_2 in var_0) {
    var_2.grenadeammo = 0;
    var_2 setgoalpos(var_2.origin);
    var_2 scripts\common\ai::magic_bullet_shield();
  }

  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var_2) || scripts\engine\utility::is_equal(level.hadir, var_2)) {
      continue;
    }
    var_2 scripts\common\ai::magic_bullet_shield();
  }

  var_6 = getEnt("hangar_defend_badplace", "targetname");
  createnavbadplacebyent(var_6, "axis");
  level.ks_vehicles = [];
  scripts\engine\utility::flag_wait("hangar_defend_start");
  thread dialogue_hangar_defend();
  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var_2) || scripts\engine\utility::is_equal(level.hadir, var_2)) {
      continue;
    }
    var_2 scripts\common\ai::stop_magic_bullet_shield();
  }

  foreach(var_2 in var_0)
  var_2 scripts\common\ai::stop_magic_bullet_shield();

  goal_ent_player(2000, var_0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  var_11 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_12 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    var_2 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(var_11, var_2) || scripts\engine\utility::is_equal(var_12, var_2)) {
      var_2 scripts\engine\sp\utility::set_force_color("b");
      var_2.grenadeammo = 0;
      continue;
    }

    var_2 thread exterior_allies_run_inside();
    var_2.attackeraccuracy = 1;
    var_2.health = 20;
  }

  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    if(scripts\engine\utility::is_equal(var_11, var_2) || scripts\engine\utility::is_equal(var_12, var_2))
      var_2.grenadeammo = 200;
  }

  scripts\engine\utility::trigger_off("oil_fire_dmg_trigger", "targetname");
  scripts\engine\utility::flag_wait("power_kill");
  thread audio_shf_kill_hangar_lights();
  thread player_leaves_volume_watcher();
  thread dialogue_killstreak_waiting();
  thread tarmac_umike_08();
  thread tarmac_umike_09();
  wait 1;
  goal_ent_player(1500);
  var_17 = getaiarray("axis");

  foreach(var_2 in var_17)
  var_2.grenadeammo = 0;

  thread tarmac_vindia_02(9);
  thread defend_autosaves();
  var_12 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_20 = getEnt("oil_fire_dmg_trigger", "targetname");
  var_20 delete();
  scripts\engine\utility::flag_wait("air_support_dialogue_complete");
  level.incomingapache = scripts\common\vehicle::spawn_vehicle_from_targetname("apache");
  level.player notifyonplayercommand("air_support_requested", "+actionslot 1");
  scripts\engine\sp\utility::display_hint_forced("air_support");
  level.player waittill("air_support_requested");
  level.player.fake_weapon = level.player getcurrentweapon();
  scripts\engine\utility::flag_set("air_support_inbound");
}

audio_shf_kill_hangar_lights() {
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-42595, 29256, -331));
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-41992, 29023, -331));
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-42207, 28321, -331));
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-42824, 28526, -331));
}

tarmac_badplace() {
  var_0 = getEnt("tarmac_badplace", "targetname");
  var_1 = createnavbadplacebyent(var_0, "axis");
  level waittill("remove_tarmac_bp");
  destroynavobstacle(var_1);
}

player_leaves_volume_watcher() {
  var_0 = getEnt("hangar_volume", "targetname");
  level.player.inside_volume = 1;

  while(!scripts\engine\utility::flag("air_support_inbound")) {
    if(!level.player istouching(var_0)) {
      if(level.player.inside_volume)
        thread leave_hangar_vo();

      level.player.inside_volume = 0;

      if(scripts\engine\utility::flag("air_support_dialogue_complete")) {
        scripts\engine\utility::flag_set("killing_player");
        var_1 = level.player.origin + (0, 0, 80);
        magicbullet("iw8_lm_pkilo", var_1, level.player.origin + (0, 0, 20));
        level.player waittill("damage");
        level.player kill();
      }
    }

    waitframe();
  }

  level.player.inside_volume = 1;
}

leave_hangar_vo() {
  var_0 = ["dx_vom_far_pre_charge_setup_230", "dx_vom_far_pre_charge_setup_250", "dx_vom_far_pre_charge_setup_240"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw());
  wait 5.2;
  level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw());
}

hangar_defend_vfx_main() {
  scripts\engine\utility::flag_set("hangar_defend_start");
  thread scripts\engine\utility::flag_set_delayed("tarmac_fire_lights", 1.5);
  level notify("power_kill");
  visionsetnaked("safehouse_finale_tarmac_end", 0.05);
  thread pallet_smash();
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("hangar_defend_infantry", 1);

  foreach(var_2 in var_0) {
    var_2.grenadeammo = 0;
    var_2 setgoalpos(var_2.origin);
    var_2 scripts\common\ai::magic_bullet_shield();
  }

  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var_2) || scripts\engine\utility::is_equal(level.hadir, var_2)) {
      continue;
    }
    var_2 scripts\common\ai::magic_bullet_shield();
  }

  var_6 = getEnt("hangar_defend_badplace", "targetname");
  createnavbadplacebyent(var_6, "axis");
  level.ks_vehicles = [];
  scripts\engine\utility::flag_wait("hangar_defend_start");
  thread dialogue_hangar_defend();
  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var_2) || scripts\engine\utility::is_equal(level.hadir, var_2)) {
      continue;
    }
    var_2 scripts\common\ai::stop_magic_bullet_shield();
  }

  foreach(var_2 in var_0)
  var_2 scripts\common\ai::stop_magic_bullet_shield();

  goal_ent_player(2000, var_0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  var_11 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_12 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    var_2 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(var_11, var_2) || scripts\engine\utility::is_equal(var_12, var_2)) {
      var_2 scripts\engine\sp\utility::set_force_color("b");
      var_2.grenadeammo = 0;
      continue;
    }

    var_2 thread exterior_allies_run_inside();
    var_2.attackeraccuracy = 1;
    var_2.health = 20;
  }

  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    if(scripts\engine\utility::is_equal(var_11, var_2) || scripts\engine\utility::is_equal(var_12, var_2))
      var_2.grenadeammo = 200;
  }

  scripts\engine\utility::trigger_off("oil_fire_dmg_trigger", "targetname");
  scripts\engine\utility::flag_wait("hangar_defend_start");
  thread dialogue_killstreak_waiting();
  thread tarmac_umike_08();
  wait 2;
  thread tarmac_umike_09();
  wait 1;
  goal_ent_player(1500);
  thread tarmac_vindia_02(1, 1);
  level waittill("forever");
}

pallet_smash() {
  var_0 = getEnt("pallet_smash_trigger", "targetname");
  var_1 = getEnt("pallet_badplace", "targetname");
  createnavbadplacebyent(var_1, "axis");

  while(!isDefined(level.tarmac_vindia_02))
    waitframe();

  while(!level.tarmac_vindia_02 istouching(var_0))
    waitframe();

  scripts\engine\utility::trigger_off("pallet_fire_trig", "targetname");
  thread pallet_scriptables();
  scripts\engine\utility::flag_set("pallet_smash");
  thread pallet_lights();
  var_2 = scripts\engine\utility::spawn_tag_origin((-41852.4, 29958.4, -645.557), (0.10223, 185.996, 359.008));
  playFXOnTag(scripts\engine\utility::getfx("vfx_safehouse_finale_apc_collision"), var_2, "tag_origin");
  wait 0.5;
  var_3 = scripts\engine\utility::spawn_tag_origin((-41844.9, 29862.9, -650.004), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_safehouse_finale_apc_collision"), var_2, "tag_origin");
  wait 0.5;
  scripts\engine\utility::exploder("hanger_lights");
  scripts\engine\utility::exploder("pallet_plume_02");
  playFXOnTag(scripts\engine\utility::getfx("vfx_safehouse_finale_vindia_fire"), level.tarmac_vindia_02, "drivers_hatch_jnt");
  var_4 = getEntArray("pallet_pristine", "targetname");
  scripts\engine\utility::flag_wait("air_support_inbound");
  var_2 delete();
  var_3 delete();
}

pallet_lights() {
  var_0 = getEntArray("tarmac_fires", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_equal(var_3.script_noteworthy, "pallet"))
      var_1[var_1.size] = var_3;
  }

  scripts\engine\utility::array_thread(var_1, ::pallet_light_lerps);
}

pallet_light_lerps() {
  var_0 = self getlightintensity();
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting.gsc::lerp_value_charge_explosion(var_0, var_0 * 0.15, 0.5);
  wait 4;
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting.gsc::lerp_value_charge_explosion(var_0 * 0.15, var_0, 3);
}

pallet_scriptables() {
  var_0 = getscriptablearray("pallet_pristine", "targetname");

  foreach(var_2 in var_0) {
    if(var_2 getscriptableparthasstate("base", "dead"))
      var_2 setscriptablepartstate("base", "dead", 1, 1);

    if(var_2 getscriptableparthasstate("base", "exploded"))
      var_2 setscriptablepartstate("base", "exploded", 1, 1);

    scripts\engine\utility::flag_wait("apache_here");

    if(var_2 getscriptableparthasstate("base", "fragmented"))
      var_2 setscriptablepartstate("base", "fragmented", 1, 1);
  }
}

defend_autosaves() {
  var_0 = getEnt("hangar_volume", "targetname");

  if(level.player istouching(var_0) && !scripts\engine\utility::flag("killing_player"))
    scripts\engine\sp\utility::autosave_by_name("hangar_defend_auto_1");

  wait 12;

  if(level.player istouching(var_0) && !scripts\engine\utility::flag("killing_player"))
    scripts\engine\sp\utility::autosave_by_name("hangar_defend_auto_2");
}

exterior_allies_run_inside() {
  self endon("death");
  self.ignoreall = 1;
  scripts\engine\utility::set_movement_speed(220);
  scripts\engine\sp\utility::set_force_color("p");
  self.disableplayeradsloscheck = 1;
  self waittill("goal");
  self.ignoreall = 0;
  wait 10;
  self.disableplayeradsloscheck = 0;
}

lerp_value(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = 0.05;
  var_5 = int(var_2 / var_4);

  if(var_5 > 0) {
    for(var_6 = var_3 / var_5; var_5; var_5--) {
      var_0 = var_0 + var_6;
      wait(var_4);
    }
  }
}

killstreak_chopper_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  level.player notifyonplayercommand("drone_control_attempt", "+actionslot 1");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("chu_strafe_run");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("chu_exit");
  scripts\engine\utility::flag_set("air_support_inbound");
  scripts\engine\utility::flag_set("pallet_smash");
  scripts\engine\utility::flag_set("armory_02_secure");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  scripts\engine\sp\utility::set_start_location("start_killstreak_ending", [level.player, var_0]);
  level.allies = getaiarray("allies");

  foreach(var_2 in level.allies) {
    var_2 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(level.farah, var_2)) {
      var_2 scripts\engine\sp\utility::set_force_color("b");
      continue;
    }

    var_2 scripts\engine\sp\utility::set_force_color("p");
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  thread tarmac_umike_08();
  thread tarmac_umike_09();
  level.ks_vehicles = [];
  thread tarmac_vindia_02(undefined, 1);
  var_4 = getEnt("oil_fire_dmg_trigger", "targetname");
  var_4 delete();
  var_5 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_5, ::delete);
  level.incomingapache = scripts\common\vehicle::spawn_vehicle_from_targetname("apache");
  level.player.fake_weapon = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_getprimaryweaponobject();
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  level.vtclassname = "script_vehicle_iw8_truck_umike_covered";
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/lab/vfx_temp_lrg_veh_death.vfx", "tag_origin", "rocket_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_tank_death_exp.vfx", "tag_origin");
  level.vtclassname = "script_vehicle_iw8_vindia_a1";
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/bromeo/vfx_tank_death_exp_plume.vfx", "tag_origin", "rocket_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_tank_death_exp.vfx", "tag_origin");
  thread explode_tarmac_scriptables();
}

killstreak_chopper_main() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_0 = [];
  var_1 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.model, "veh8_mil_air_mindia8_static_dst_tail"))
      var_0[var_0.size] = var_3;
  }

  scripts\engine\utility::array_call(var_0, ::hide);
  scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\sp\utility::battlechatter_off("axis");
  level.allies = getaiarray("allies");

  foreach(var_6 in level.allies) {
    var_6.grenadeammo = 0;
    var_6 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(level.farah, var_6) || scripts\engine\utility::is_equal(level.hadir, var_6)) {
      var_6.support_equipment = 0;
      var_6 notify("remove_equipment");
      var_6 scripts\engine\sp\utility::set_force_color("b");
      continue;
    }

    var_6 delete();
  }

  var_8 = getspawnerarray("hangar_dummy_ai");

  foreach(var_10 in var_8) {
    var_11 = spawnStruct();
    var_11.origin = var_10.origin;
    var_11.angles = var_10.angles;
    var_10 = scripts\engine\sp\utility::bodyonlyspawn(var_10);
    var_10.animname = var_10.script_animname;
    var_11 thread scripts\common\anim::anim_loop_solo(var_10, "hangar_idles");
  }

  var_13 = getcorpsearray();
  scripts\engine\utility::array_delete(var_13);
  level.fob_enemies = getaiarray("axis");

  foreach(var_6 in level.fob_enemies)
  var_6.grenadeammo = 0;

  var_16 = getaiarray("allies");

  foreach(var_6 in var_16)
  var_6.name = "";

  scripts\engine\utility::delaythread(2, ::tarmac_umike_01);
  scripts\engine\utility::delaythread(2, ::tarmac_umike_01b);
  scripts\engine\utility::delaythread(2.1, ::tarmac_umike_02);
  thread tarmac_umike_03();
  thread tarmac_vindia_03();
  thread dialogue_killstreak_chopper();
  var_19 = spawnStruct();
  var_19.origin = level.player.origin;
  var_19.angles = level.player.angles;
  level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.player playSound("scn_apache_transition_intro");
  level.player hidelegsandshadow();
  level.player.ignoreme = 1;
  level.blackoverlay fadeovertime(0.25);
  level.blackoverlay.alpha = 1;
  level.player.og_ks_spot = level.player.origin;
  wait 0.5;
  level.player setOrigin((-41768, 28835, -622));
  visionsetnaked("safehouse_finale", 0.05);
  level.player dontinterpolate();
  level.player setOrigin(level.incomingapache.origin);
  level.player setplayerangles(level.incomingapache.angles);
  level.player playerlinktodelta(level.incomingapache, "tag_origin", 0, 0, 0, 0, 0);
  level.incomingapache thread scripts\common\vehicle::vehicle_lights_on("interior");
  level.incomingapache thread scripts\vehicle\apache::pilot_apache(level.player, scripts\engine\utility::getStruct("inc_apache_start", "targetname"), scripts\engine\utility::getStruct("inc_apache_final", "targetname"), 1);
  level.player playSound("scn_apache_transition_lr");
  level.incomingapache makeentitysentient("allies", 0);
  thread apache_death_watcher();
  wait 1;
  level.player dontinterpolate();
  level.player setOrigin(level.incomingapache.origin);
  level.player setplayerangles(level.incomingapache.angles);
  level.player playerlinktoabsolute(level.incomingapache, "tag_origin");
  scripts\engine\sp\utility::set_start_location("fob_center_start", [level.player]);
  level.player lerpfovscalefactor(0, 0);
  level.blackoverlay fadeovertime(1);
  level.blackoverlay.alpha = 0;
  level waittill("apache_transition");
  setsaveddvar("LMRRNRMLS", 1);
  thread scriptable_cleanup();
  scripts\sp\utility::delete_live_grenades();
  level.incomingapache.ignoreme = 1;
  var_20 = getaiarray("axis");
  var_20 = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var_6 in var_20) {
    var_6.grenadeammo = 0;
    var_6.skipdeathanim = 1;
  }

  wait 1;
  thread chopper_rockets_watcher();
  thread chopper_ads_watcher();
  thread chopper_guns_watcher();
  var_23 = scripts\engine\sp\utility::getvehiclearray();
  scripts\engine\utility::array_thread(var_23, ::vehicle_jolt_watcher);
  thread trucks_stopped_watcher();
  thread apache_start_moving_nags();
  scripts\engine\sp\utility::display_hint("apache_fly");
  scripts\engine\utility::flag_set("apache_here");
  var_20 = getaiarray("axis");
  var_20 = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var_6 in var_20)
  var_6.grenadeammo = 0;

  var_26 = gettime() + 10000;

  while(gettime() <= var_26 && !level.player scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::stick_forward())
    waitframe();

  wait 3;
  thread apache_hints();
  thread killstreak_rpg_guys();
  thread killstreak_backup_enemies();
  thread ai_cleanup_watcher();

  while(level.ks_vehicles.size > 0) {
    scripts\engine\utility::waittill_any_ents_array(level.ks_vehicles, "death");

    foreach(var_3 in level.ks_vehicles) {
      if(!isalive(var_3))
        level.ks_vehicles = scripts\engine\utility::array_remove(level.ks_vehicles, var_3);
    }
  }

  level notify("tanks_dead");
  scripts\engine\sp\utility::autosave_by_name("tanks_dead");
  scripts\engine\utility::flag_set("rpg_guys_go");
  scripts\engine\utility::flag_wait("ks_trucks_stopped");
  wait 7;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::enemy_alive_counter_gate(20);
  level notify("kill_respawners");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::enemy_alive_counter_gate(16);
  scripts\engine\utility::flag_set("retreat");
  thread killstreak_retreat();
  wait 8;
  level.fob_enemies = getaiarray("axis");
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
  level.player notifyonplayercommand("disengage_apache", "+actionslot 1");
  thread disengage_watcher();

  while(!scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::hide_apache_retreat_hint() && level.fob_enemies.size > 0) {
    level.fob_enemies = getaiarray("axis");
    level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
    waitframe();
  }

  level notify("apache_safe");

  if(level.fob_enemies.size == 0)
    wait 3;

  level.incomingapache scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_clear_10");
  scripts\engine\utility::flag_set("killstreak_complete");
  setsaveddvar("LMRRNRMLS", 0);
  wait 0.2;

  foreach(var_30 in level.ks_vehicles) {
    if(isDefined(var_30))
      var_30 kill();
  }

  level.player enableinvulnerability();
  level.player unlink();
  var_32 = scripts\engine\utility::spawn_tag_origin(level.player.og_ks_spot, level.player.angles);
  level.player dontinterpolate();
  level.player setOrigin(var_32.origin);
  level.player playerlinktoabsolute(var_32, "tag_origin");
  thread ending_scene_ent_cleanup(2);
  level.incomingapache scripts\vehicle\apache::leave_apache_no_player(level.player);
  scripts\engine\utility::array_delete(var_8);
  var_33 = getaiarray("axis");
  scripts\engine\utility::array_delete(var_33);

  if(scripts\engine\utility::flag("mission_failed"))
    level waittill("forever");
}

trucks_stopped_watcher() {
  var_0 = scripts\engine\sp\utility::getvehiclearray();

  foreach(var_2 in var_0) {
    if(var_2.model != "veh8_mil_lnd_umike")
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  while(var_0.size > 0) {
    var_0 = scripts\engine\utility::array_removedead(var_0);

    foreach(var_2 in var_0) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(!isalive(var_2))
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);

      if(isDefined(var_2.veh_speed) && var_2.veh_speed < 1)
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("ks_trucks_stopped");
}

apache_start_moving_nags() {
  var_0 = ["dx_vom_apap_killstreak_chopper_intro_90", "dx_vom_apap_killstreak_chopper_intro_100", "dx_vom_apap_killstreak_chopper_intro_110"];
  level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill_delayed(15, "apache_start_moving_nags", var_0, 12, 1.2);

  while(!level.player scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::stick_forward())
    waitframe();

  level notify("apache_start_moving_nags");
}

apache_fire_vo() {
  var_0 = ["dx_vom_apap_killstreak_chopper_combat_30", "dx_vom_apap_killstreak_chopper_combat_40", "dx_vom_apap_killstreak_chopper_combat_140"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);

  if(!level.player attackButtonPressed())
    level.player waittill("attack_pressed");
  else
    var_1 scripts\engine\sp\utility::deck_draw();

  while(level.player attackButtonPressed() && !var_1 scripts\engine\sp\utility::deck_is_empty()) {
    level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 0.5);
    wait 0.1;
  }
}

apache_missile_fire_vo() {
  level.player waittill("frag_pressed");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_combat_10", 0, 0.5);
}

apache_killconfirm_vo() {
  var_0 = [];
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_100";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_combat_90";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_combat_80";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_combat_70";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_combat_20";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_combat_130";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_combat_150";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_10";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_20";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_30";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_40";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_50";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_60";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_70";
  var_0[var_0.size] = "dx_vom_apap_killstreak_chopper_reactions_90";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("apache_kill", var_3, var_4);
    wait 1;

    if(isDefined(var_4) && var_4 == "apache_proj_sp" && !var_1 scripts\engine\sp\utility::deck_is_empty()) {
      level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 0, 0.5);
      continue;
    }

    level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_2 scripts\engine\sp\utility::deck_draw(), 0, 0.5);
  }
}

apache_reloading_vo() {
  var_0 = ["dx_vom_apap_killstreak_chopper_reloading_10", "dx_vom_apap_killstreak_chopper_reloading_20"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_apap_killstreak_chopper_combat_200", "dx_vom_apap_killstreak_chopper_combat_210", "dx_vom_apap_killstreak_chopper_combat_220", "dx_vom_apap_killstreak_chopper_combat_230"];
  var_2 = scripts\engine\sp\utility::create_deck(var_0);

  for(;;) {
    level waittill("apache_reloading");
    var_3 = var_1 scripts\engine\sp\utility::deck_draw();
    level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_3, 0, 3);
    wait 4.5;
    var_3 = var_2 scripts\engine\sp\utility::deck_draw();
    level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_3, 0);
  }
}

notify_on_killed_by_apache() {
  self waittill("death", var_0, var_1, var_2);
  var_3 = undefined;

  if(isDefined(var_2))
    var_3 = createheadicon(var_2);

  if(!scripts\engine\utility::is_equal(var_0, level.incomingapache.mainturret) && !scripts\engine\utility::is_equal(var_0, level.player)) {
    return;
  }
  level notify("apache_kill", "vehicle", var_3);
}

notify_apache_ai_kill() {
  for(;;) {
    level waittill("ai_killed", var_0, var_1, var_2, var_3);

    if(!scripts\engine\utility::is_equal(var_1, level.incomingapache.mainturret) && !scripts\engine\utility::is_equal(var_1, level.player)) {
      continue;
    }
    level notify("apache_kill", "ai", var_3);
  }
}

apache_hints() {
  scripts\engine\sp\utility::display_hint("apache_rockets");
  scripts\engine\utility::flag_wait("chopper_rockets_pressed");
  wait 2;

  if(level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledGamepad") || !level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard"))
    scripts\engine\sp\utility::display_hint("apache_zoom");
  else
    scripts\engine\sp\utility::display_hint("apache_zoom_hold");

  scripts\engine\utility::flag_wait("chopper_zoom_pressed");
  wait 2;
  scripts\engine\sp\utility::display_hint("apache_guns");
}

chopper_rockets_watcher() {
  level endon("killstreak_complete");

  while(!level.player fragButtonPressed())
    waitframe();

  scripts\engine\utility::flag_set("chopper_rockets_pressed");
}

chopper_ads_watcher() {
  level endon("killstreak_complete");

  while(!level.player adsButtonPressed())
    waitframe();

  scripts\engine\utility::flag_set("chopper_zoom_pressed");
}

chopper_guns_watcher() {
  level endon("killstreak_complete");

  while(!level.player attackButtonPressed())
    waitframe();

  scripts\engine\utility::flag_set("chopper_guns_pressed");
}

scriptable_cleanup() {
  var_0 = getscriptablearray("apache_scr", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(self.model) && self.model != "veh8_civ_lnd_hindia_black")
      var_2 hide();
  }
}

ai_cleanup_watcher() {
  level waittill("kill_all_ai");
  var_0 = getaiarray("axis");
  scripts\engine\utility::array_delete(var_0);
}

disengage_watcher() {
  level.player waittill("disengage_apache");
  scripts\engine\utility::flag_set("disengage_apache");
}

apache_death_watcher() {
  level endon("apache_safe");
  level waittill("apache_dead");
  scripts\sp\utility::missionfailedwrapper();
  scripts\engine\utility::flag_set("mission_failed");
}

killstreak_rpg_guys() {
  thread killstreak_rpg_guys_timeout();
  level.incomingapache.threat_tag = scripts\engine\utility::spawn_tag_origin(level.incomingapache gettagorigin("tag_turret") + (0, 0, -50), level.incomingapache.angles);
  level.incomingapache.threat_tag linkTo(level.incomingapache);
  var_0 = missile_createattractorent(level.incomingapache, 1000, 7000);
  var_1 = scripts\sp\utility::make_weapon("iw8_la_rpapa7_straight_slower");
  scripts\engine\utility::flag_wait_or_timeout("rpg_guys_go", 120);
  scripts\engine\utility::flag_set("rpg_guys_go");
  wait 3;
  level.fob_enemies = getaiarray("axis");
  var_2 = [];
  level.fob_enemies = sortbydistance(level.fob_enemies, (-43015.7, 31540.7, 200));

  for(var_3 = 0; var_3 < level.fob_enemies.size - 1; var_3 = var_3 + 4) {
    if(isDefined(level.fob_enemies[var_3])) {
      level.fob_enemies[var_3] scripts\engine\sp\utility::set_maxsightdistsquared(225000000);
      level.fob_enemies[var_3] thread scripts\anim\shared.gsc::forceuseweapon(var_1, "primary");
      level.fob_enemies[var_3] setentitytarget(level.incomingapache.threat_tag, 1);
      level.fob_enemies[var_3].baseaccuracy = 1;
      var_2[var_2.size] = level.fob_enemies[var_3];
      level.fob_enemies[var_3].rpg_guy = 1;
    }
  }

  if(scripts\engine\utility::flag("killstreak_complete")) {
    return;
  }
  level endon("killstreak_complete");

  if(var_2.size > 0)
    scripts\engine\utility::array_thread(var_2, ::rpg_guys_fire);
}

rpg_guys_fire() {
  self endon("death");
  level endon("rpg_fired");
  self waittill("weapon_fired");
  level notify("rpg_fired");
}

killstreak_rpg_guys_timeout() {}

killstreak_backup_enemies() {
  level endon("kill_respawners");
  var_0 = getEnt("tarmac_ks_guys_vol_01", "targetname");
  var_1 = getspawnerarray("killstreak_backup_guys");
  var_2 = 0;

  while(var_2 < 17) {
    level.fob_enemies = getaiarray("axis");

    if(level.fob_enemies.size < 20) {
      var_3 = var_1[randomintrange(0, 3)];
      var_4 = var_3 scripts\engine\sp\utility::spawn_ai();
      var_3.count = 1;

      if(isDefined(var_4)) {
        var_2++;
        var_4.grenadeammo = 0;
        var_4 setgoalvolumeauto(var_0);
        waitframe();
      }
    }

    wait 0.2;
  }
}

ai_counter() {
  level.fob_enemies = getaiarray("axis");

  while(level.fob_enemies.size > 0) {
    level.fob_enemies = getaiarray("axis");
    level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
    wait 1;
  }
}

killstreak_retreat() {
  level endon("killstreak_complete");
  level.farah.ignoreme = 1;
  level.allies = getaiarray("allies");
  level.fob_enemies = getaiarray("axis");
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var_1 in level.fob_enemies) {
    var_1.ignoresuppression = 1;
    var_1.forcelongdeath = 1;
    var_1 scripts\engine\utility::set_movement_speed(230);
  }

  scripts\engine\utility::array_thread(level.fob_enemies, ::run_to_position, 1200, "molotov_guy_struct");
  wait 10;
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var_1 in level.fob_enemies) {
    var_1.forcelongdeath = 1;
    var_1 scripts\engine\utility::set_movement_speed(230);
  }

  scripts\engine\utility::array_thread(level.fob_enemies, ::run_to_position, 1500, "molotov_guy_struct");
  wait 15;
  level notify("second_retreat");
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var_1 in level.fob_enemies)
  var_1 scripts\engine\utility::set_movement_speed(160);

  scripts\engine\utility::array_thread(level.fob_enemies, ::run_to_position, 1200, "mid_goal_spots");
}

run_to_position(var_0, var_1, var_2) {
  self endon("death");
  wait(randomfloatrange(1, 4));
  self.ignoreall = 1;
  var_3 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_3 = sortbydistance(var_3, level.player.origin);
  self setentitytarget(level.incomingapache.threat_tag, 1);
  self setgoalpos(var_3[0].origin);
  scripts\engine\sp\utility::set_goal_radius(var_0);
  self waittill("goal");
  wait 3;
  self.ignoreall = 0;
}

ending_scene_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_givemolotovweapon();
  level.player notifyonplayercommand("drone_control_attempt", "+actionslot 1");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("chu_strafe_run");
  scripts\engine\utility::flag_set("fob_player_in_center");
  scripts\engine\utility::flag_set("fob_rear");
  scripts\engine\utility::flag_set("fob_exit");
  scripts\engine\utility::flag_set("chu_exit");
  scripts\engine\utility::flag_set("killstreak_complete");
  scripts\engine\utility::flag_set("hangar_defend_start");
  scripts\engine\utility::flag_set("tarmac_fire_lights");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_killstreak_ending", [level.player]);
  scripts\engine\sp\utility::set_start_location("start_killstreak_igc", [var_0, var_1]);
  var_2 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::spawnallies(2);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::trench_spawnallies();
  var_4 = charge_setalliestoredshirts();
  var_5 = towerstairs_getallycovernodes();
  var_6 = var_4;
  level.allies = scripts\engine\sp\utility::array_merge(var_4, [var_0, var_1]);

  foreach(var_8 in level.allies) {
    var_9 = scripts\engine\utility::random(var_5);
    var_8 scripts\engine\sp\utility::teleport_ai(var_9);
    var_5 = scripts\engine\utility::array_remove(var_5, var_9);
  }

  level.allies = getaiarray("allies");

  foreach(var_12 in level.allies) {
    var_12 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(var_0, var_12) || scripts\engine\utility::is_equal(var_1, var_12)) {
      var_12 scripts\engine\sp\utility::set_force_color("o");
      continue;
    }

    var_12 scripts\engine\sp\utility::set_force_color("p");
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_07");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  var_14 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var_14, ::delete);
  level.ending_scene = 1;
  level.incomingapache = scripts\common\vehicle::spawn_vehicle_from_targetname("apache");
  level.incomingapache thread scripts\common\vehicle::vehicle_lights_on("interior");
  level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.player.fake_weapon = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::player_getprimaryweaponobject();
  hidecinematicletterboxing(2, 0);
}

ending_scene_main() {
  level.player clearsoundsubmix("sp_npc_steps_down", 1.0);
  scripts\engine\utility::exploder("end_scene_fx");
  setsaveddvar("MNSOQLKMT", "2 0.0006 1 1");
  thread ending_scene_bodies();
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting.gsc::ending_scene_lights();
  thread ending_scene_lights_off();
  level.player allowcrouch(0);
  level.player scripts\common\utility::allow_cinematic_motion(0);
  level.player setstance("stand");
  level.player modifybasefov(42, 0.5);
  thread ending_scene_celebration();
  level.incomingapache delete();
  waitframe();
  level.incomingapache = scripts\common\vehicle::spawn_vehicle_from_targetname("apache");
  level.incomingapache.animname = "ks_apache_vehicle_camera";
  level.incomingapache thread scripts\common\vehicle::vehicle_lights_on("interior");
  setomnvar("ui_hide_hud", 1);
  level.player hideviewmodel();
  level.player hidelegsandshadow();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player remotecontrolvehicleoff();
  level.player remotecontrolturretoff(level.incomingapache.mainturret);
  level.player disableweapons();
  level.player dontinterpolate();
  level.incomingapache vehicle_cleardrivingstate();
  level.incomingapache vehicle_setspeedimmediate(30, 50, 25);
  var_0 = scripts\engine\utility::getStruct("ks_ending_struct", "targetname");
  var_1 = scripts\engine\utility::getStruct("boss_chopper_tower_entrance_struct", "targetname");
  var_2 = var_0 scripts\engine\utility::get_target_ent();
  var_2.origin = var_2.origin + anglesToForward(var_2.angles) * 10000;
  level.incomingapache vehicle_teleport(var_1.origin + (1000, 1000, 0), var_0.angles);
  level.incomingapache setvehgoalpos(var_2.origin, 1);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_4 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_spawnhadir();
  var_5 = scripts\engine\sp\utility::spawn_targetname("alex", 1);
  var_5.animname = "alex";
  var_5.name = "";
  var_4.name = "";
  var_3.name = "";
  level.hadir.support_equipment = 0;
  level.farah.support_equipment = 0;
  level.hadir notify("remove_equipment");
  var_6 = weaponclass(level.player.fake_weapon);

  if(var_6 != "rifle")
    level.player.fake_weapon = scripts\sp\utility::make_weapon("iw8_ar_akilo47");

  var_5 scripts\anim\shared.gsc::forceuseweapon(level.player.fake_weapon, "primary");
  var_7 = scripts\engine\utility::getStruct("outro_scene_struct", "targetname");
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", (0, 0, 0), level.player.angles);
  level.player.rig hide();
  var_8 = [var_5, var_3];
  scripts\engine\sp\utility::set_start_location("start_killstreak_igc", [var_3, var_4, var_5]);
  level.player unlink();
  level.player dontinterpolate();
  level.player playerlinkTo(level.player.rig, "tag_origin", 1, 0, 0, 0, 0, 0);
  level.player setclienttriggeraudiozone("safef_final_scene", 3.0);
  level.player playSound("shf_end_walla_celebrate");
  var_9 = getanimlength(var_5 scripts\engine\utility::getanim("outro_scene"));
  var_10 = getEntArray("ending_scene_vindia", "targetname");
  scripts\engine\utility::array_call(var_10, ::show);
  ending_scene_ent_cleanup();
  thread skippable_ending();
  thread dialogue_ending_scene();
  var_4 thread ending_scene_dof();
  visionsetnaked("safehouse_finale_ending", 0.05);
  var_7 thread ending_camera_animation();
  wait 0.5;
  level.blackoverlay fadeovertime(0.05);
  level.blackoverlay.alpha = 0;
  var_7 thread ending_scene_anims(var_3, var_5, var_4);
  level.player scripts\engine\utility::delaythread(var_9 - 6, ::audio_fade_out_ending_mix);
  wait(var_9 - 2);
  level notify("level_ended");
  scripts\engine\sp\utility::nextmission();
  level waittill("forever");
}

audio_fade_out_ending_mix() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 5.0);
}

skippable_ending() {
  level endon("level_ended");
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  scripts\sp\hud_util::fade_out(0);
  scripts\engine\sp\utility::nextmission();
}

ending_scene_bodies() {
  var_0 = scripts\engine\utility::getStructArray("tarmac_end_dead_struct", "targetname");
  var_1 = getspawnerarray("tarmac_guys")[0];
  var_0[1].origin = (-41766, 29430, -675.963);
  var_0[1].angles = (0, 22.8998, 0);

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\sp\utility::bodyonlyspawn(var_1);
    var_1.count = 1;
    var_4.animname = "soldier_01";
    var_4 thread scripts\common\ai::gun_remove();
    waitframe();
    var_3 thread scripts\common\anim::anim_single_solo(var_4, var_3.animation);
    waitframe();
  }
}

ending_scene_lights_off() {
  scripts\engine\sp\utility::flag_clear_delayed("tarmac_fire_lights", 0.1);
  var_0 = getEntArray("tarmac_fires", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

ending_scene_dof() {
  level scripts\engine\sp\utility::dof_enable(2.8, 2000, 10.0, 10.0, undefined, undefined);
  wait 3.5;
  level scripts\engine\sp\utility::dof_enable(2.8, 130, 1.0, 1.0, undefined, undefined);
  wait 3.75;
  thread scripts\engine\sp\utility::dof_enable_autofocus(3.5, 8, undefined, undefined, "tag_eye", undefined, 1);
}

ending_scene_celebration() {
  var_0 = scripts\engine\utility::getStruct("outro_scene_struct", "targetname");
  var_1 = getspawnerarray("celebration_spawners")[0];
  var_2 = [];

  for(var_3 = 1; var_3 < 11; var_3++) {
    var_4 = var_1 scripts\engine\sp\utility::spawn_ai(1);
    var_4.animname = "rebel_" + var_3;
    var_1.count++;
    var_2[var_2.size] = var_4;
    var_4.name = "";
    var_4 scripts\common\ai::magic_bullet_shield();
    waitframe();
  }

  var_0 scripts\common\anim::anim_single(var_2, "outro_scene");
}

ending_scene_anims(var_0, var_1, var_2) {
  var_3 = [var_0, var_1, var_2];
  thread scripts\common\anim::anim_single(var_3, "outro_scene");
  var_1 thread scene_mayhem(%shf_050_3p_outro_alex_face, "ending_mayhem_alex_face");
  var_0 thread scene_mayhem(%shf_050_3p_outro_farah_face, "ending_mayhem_farah_face");
  var_2 thread scene_mayhem(%shf_050_3p_outro_hadir_face, "ending_mayhem_hadir_face");
}

scene_mayhem(var_0, var_1, var_2) {
  level waittill(var_1);

  if(!isDefined(var_2))
    var_2 = undefined;

  thread play_mayhem_animation(var_0, var_2);
}

ending_camera_animation() {
  level.player setplayerangles((0, 0, 0));
  thread scripts\common\anim::anim_single_solo(level.player.rig, "outro_scene");
}

play_mayhem_animation(var_0, var_1) {
  if(isDefined(self.headmodel)) {
    if(isDefined(self.hatmodel))
      self detach(self.hatmodel);

    self detach(self.headmodel);
    self setanim(var_0, 1.0, 0.0, 1.0);
  }

  if(isDefined(var_1)) {
    level waittill(var_1);
    self setanim(var_0, 0.0, 0.0, 0.0);
    self attach(self.headmodel);
  }
}

ending_scene_ent_cleanup(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  var_1 = getcorpsearray();
  scripts\engine\utility::array_delete(var_1);
  var_2 = getweaponarray();
  scripts\engine\utility::array_delete(var_2);
  var_3 = scripts\engine\sp\utility::getvehiclearray();
  var_3 = scripts\engine\utility::array_remove(var_3, level.incomingapache);
  scripts\engine\utility::array_delete(var_3);
  var_4 = getEntArray("destroyed_tarmac_models", "script_noteworthy");
  var_5 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_6 = getentarrayinradius(undefined, undefined, var_5.origin, 3000);
  scripts\engine\utility::array_thread(var_6, ::ending_scene_ent_cleanup_loop);
}

ending_scene_ent_cleanup_loop() {
  if(scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_vindia_a1_dst") || scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_vindia_a1") || scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_umike_pickup_static_dst") || scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_umike_pickup") || isDefined(self.death_fx)) {
    self notify("fire_extinguish");
    self notify("stop_all_death_fx");
    waitframe();

    if(isDefined(self))
      self hide();
  }
}

tromeo_entrance_00() {
  for(;;) {
    var_0 = getaiarray("axis", "allies");
    var_1 = 31 - var_0.size;

    if(var_1 > 4 && !scripts\engine\utility::flag("ai_spawner_busy")) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("ai_spawner_busy");
  level.tromeo_00 = scripts\common\vehicle::spawn_vehicle_from_targetname("tromeo_vehicle_00");
  level.tromeo_00 scripts\common\vehicle::vehicle_lights_on();
  level.tromeo_00.maxhealth = 24000;
  level.tromeo_00.vehicle_skipdeathanimation = 1;
  level.tromeo_00.team = "axis";
  level.tromeo_00 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  level.tromeos[level.tromeos.size] = level.tromeo_00;
  var_2 = getvehiclenode("tromeo_00_start", "targetname");
  level.tromeo_00 scripts\common\vehicle::attach_vehicle_and_gopath(var_2);
  wait 0.5;
  scripts\engine\utility::flag_clear("ai_spawner_busy");
  level notify("tromeo_spawn_succeeded");
  level.tromeo_00 endon("death");

  while(level.tromeo_00.veh_speed > 5)
    wait 0.1;

  level.tromeo_00.maxhealth = 10000;
  level.tromeo_00 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_00 playSound("scn_safehouse_fin_truck_skid");
  wait 2;
  var_3 = getaiarray("axis");
  var_4 = [];

  foreach(var_6 in var_3) {
    if(scripts\engine\utility::is_equal(var_6.targetname, "tromeo_guys_00"))
      var_4[var_4.size] = var_6;
  }

  if(scripts\engine\utility::flag("fob_player_in_center_swarm"))
    goal_ent_position(800, "all", "rear_goal_spots");
  else
    goal_ent_player(1200, var_4);
}

tromeo_entrance_01() {
  scripts\engine\utility::flag_wait("fob_center_action");
  scripts\engine\utility::flag_wait_any_timeout(20, "player_in_drone", "fob_player_in_center_swarm");
  wait 1;
  level.tromeo_01 = scripts\common\vehicle::spawn_vehicle_from_targetname("tromeo_vehicle");
  level.tromeo_01 scripts\common\vehicle::vehicle_lights_on();
  level.tromeo_01.maxhealth = 24000;
  level.tromeo_01.team = "axis";
  level.tromeo_01 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  level.tromeos[level.tromeos.size] = level.tromeo_01;
  var_0 = getvehiclenode("tromeo_01_start", "targetname");
  level.tromeo_01 scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
  wait 0.5;
  level notify("tromeo_spawn_succeeded");
  level.tromeo_01 endon("death");
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "tromeo_guys"))
      self.vehiclerunexit = 1;
  }

  while(level.tromeo_01.veh_speed > 5)
    wait 0.1;

  level.tromeo_01.regenerate = 0;
  level.tromeo_01.maxhealth = 7000;
  level.tromeo_01 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_01 playSound("scn_safehouse_fin_truck_skid");
  wait 2;
  var_1 = getaiarray("axis");
  var_5 = [];

  foreach(var_3 in var_1) {
    if(scripts\engine\utility::is_equal(var_3.targetname, "tromeo_guys"))
      var_5[var_5.size] = var_3;
  }

  var_5 = scripts\engine\utility::array_removedead_or_dying(var_5);

  if(scripts\engine\utility::flag("fob_player_in_center_swarm"))
    goal_ent_position(800, var_5, "mid_goal_spots");
  else
    goal_ent_player(1200, var_5);
}

tromeo_entrance_02() {
  for(;;) {
    var_0 = getaiarray("axis", "allies");
    var_1 = 31 - var_0.size;

    if(var_1 > 4 && !scripts\engine\utility::flag("ai_spawner_busy")) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("ai_spawner_busy");
  level.tromeo_02 = scripts\common\vehicle::spawn_vehicle_from_targetname("tromeo_vehicle_02");
  level.tromeo_02 scripts\common\vehicle::vehicle_lights_on();
  level.tromeo_02.maxhealth = 1000;
  level.tromeo_02 endon("death");
  level.tromeo_02.team = "axis";
  level.tromeo_02 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_2 = getvehiclenode("tromeo_02_start", "targetname");
  level.tromeos[level.tromeos.size] = level.tromeo_02;
  level.tromeo_02 scripts\common\vehicle::attach_vehicle_and_gopath(var_2);
  wait 0.5;
  scripts\engine\utility::flag_clear("ai_spawner_busy");
  level notify("tromeo_spawn_succeeded");
  level.tromeo_02 endon("death");

  while(level.tromeo_02.veh_speed > 5)
    wait 0.1;

  level.tromeo_02.maxhealth = 1000;
  level.tromeo_02 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_02 playSound("scn_safehouse_fin_truck_skid");
}

tromeo_entrance_03() {
  level endon("airport_gate_closed");
  scripts\engine\utility::flag_wait("fob_rear_trucks");
  var_0 = getEnt("fob_center_containers_vol", "targetname");

  for(;;) {
    var_1 = getaiarray("axis", "allies");
    var_2 = 31 - var_1.size;

    if(var_2 > 4 && !scripts\engine\utility::flag("ai_spawner_busy")) {
      break;
    }

    waitframe();
  }

  if(scripts\engine\utility::flag("fob_exit")) {
    return;
  }
  level.tromeo_03 = scripts\common\vehicle::spawn_vehicle_from_targetname("tromeo_vehicle_03");
  level.tromeo_03 scripts\common\vehicle::vehicle_lights_on();
  level.tromeo_03.maxhealth = 21000;
  level.tromeo_03 endon("death");
  level.tromeo_03.team = "axis";
  level.tromeo_03 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_3 = getvehiclenode("tromeo_03_start", "targetname");
  level.tromeos[level.tromeos.size] = level.tromeo_03;
  level.tromeo_03 scripts\common\vehicle::attach_vehicle_and_gopath(var_3);
  wait 0.5;
  level notify("tromeo_spawn_succeeded");
  level.tromeo_03 endon("death");

  while(level.tromeo_03.veh_speed > 5)
    wait 0.1;

  level.tromeo_03 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_03 playSound("scn_safehouse_fin_truck_skid");
}

fob_umike_03(var_0) {
  scripts\engine\utility::flag_wait_any("fob_rear_trucks", "fob_exit");
  level.fob_umike_03 = scripts\common\vehicle::spawn_vehicle_from_targetname("fob_umike_03");
  level.fob_umike_03.animname = "gate_truck";
  var_1 = getEntArray("gate_truck_lights", "targetname");
  level.fob_umike_03.clip = getEnt("fob_umike_03_clip", "targetname");
  level.fob_umike_03.clip linkTo(level.fob_umike_03);
  var_2 = 2;
  level.fob_umike_03 scripts\common\vehicle::godon();
  level.fob_umike_03.regenerate = 1;
  level.fob_umike_03.maxhealth = 80300;
  level.fob_umike_03.team = "axis";
  var_3 = getvehiclenode("fob_umike_03_start", "targetname");
  var_4 = level.fob_umike_03 scripts\common\vehicle::vehicle_get_path_array();
  var_5 = var_4.size - 1;
  level.fob_umike_03 scripts\common\vehicle::attach_vehicle_and_gopath(var_3);

  if(isDefined(var_0)) {
    var_6 = getEntArray("umike_03_guys", "targetname");
    scripts\engine\utility::array_delete(var_6);
    var_4 = level.fob_umike_03 scripts\common\vehicle::vehicle_get_path_array();
    var_5 = var_4.size - 2;
    level.fob_umike_03 vehicle_teleport(var_4[var_5].origin, var_4[var_5].angles);
  }

  while(level.fob_umike_03.veh_speed > 1)
    wait 0.1;

  level.fob_umike_03 vehicle_turnengineoff();
  scripts\engine\utility::flag_wait("armory_01_trigger");

  foreach(var_8 in var_1)
  var_8 unlink();

  level.fob_umike_03.clip delete();
  level.fob_umike_03 delete();
}

tromeo_vehicle_tarmac_00() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tromeo_vehicle_tarmac_00");
  var_0 scripts\common\vehicle::vehicle_lights_on();
  var_0.maxhealth = 20200;
  var_0 setnormalhealth(1);
  var_0 endon("death");
  var_0.team = "axis";
  var_0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_1 = getvehiclenode("tromeo_vehicle_tarmac_00_start", "targetname");
  level.tromeos[level.tromeos.size] = var_0;
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  wait 0.5;
  var_0 endon("death");
  scripts\engine\utility::flag_wait("fly_attack_done");
  var_0 delete();
}

tarmac_umike_01(var_0) {
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_2 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_01");
  var_2 scripts\common\vehicle::vehicle_lights_on();
  var_2.regenerate = 0;
  var_2.maxhealth = 21000;
  var_2 thread umike_damage_watcher();
  var_2 setnormalhealth(1);
  var_2 endon("death");
  var_2.team = "axis";
  var_2 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_2 scripts\common\vehicle::godoff();
  var_3 = getvehiclenode("tarmac_umike_01_start", "targetname");
  wait 2;
  var_2 scripts\common\vehicle::attach_vehicle_and_gopath(var_3);

  if(isDefined(var_0)) {
    var_4 = var_2 scripts\common\vehicle::vehicle_get_path_array();
    var_5 = var_4.size - 1;
    var_2 vehicle_teleport(var_4[var_5].origin, var_4[var_5].angles);
    scripts\engine\utility::flag_wait("apache_here");
    var_2 scripts\common\vehicle::vehicle_unload();
    return;
  }

  wait 0.5;
  var_2 endon("death");
  scripts\engine\utility::flag_wait("apache_here");

  while(var_2.veh_speed > 0)
    wait 0.1;
}

tarmac_umike_01b() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_01b");
  var_1 scripts\common\vehicle::vehicle_lights_on();
  var_1.maxhealth = 21000;
  var_1.regenerate = 0;
  var_1 setnormalhealth(1);
  var_1 thread umike_damage_watcher();
  var_1 endon("death");
  var_1.team = "axis";
  var_1 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_2 = getvehiclenode("tarmac_umike_01b_start", "targetname");
  var_1 scripts\common\vehicle::attach_vehicle_and_gopath(var_2);
  var_3 = var_1 scripts\common\vehicle::vehicle_get_path_array();
  var_4 = var_3.size - 8;
  var_1 vehicle_teleport(var_3[var_4].origin, var_3[var_4].angles);
  var_1 endon("death");
  scripts\engine\utility::flag_wait("apache_here");

  while(var_1.veh_speed > 0)
    wait 0.1;

  var_1 scripts\common\vehicle::vehicle_unload();
}

tarmac_umike_02() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_02");
  var_0 scripts\common\vehicle::vehicle_lights_on("headlights");
  var_0.maxhealth = 21000;
  var_0.regenerate = 0;
  var_0 setnormalhealth(1);
  var_0 thread umike_damage_watcher();
  var_0 endon("death");
  var_0.team = "axis";
  var_0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_1 = getvehiclenode("tarmac_umike_02_start", "targetname");
  var_0 scripts\common\vehicle::godoff();
  wait 2;
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  wait 0.5;
  var_0 endon("death");

  while(var_0.veh_speed > 5)
    wait 0.1;
}

tarmac_umike_03() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_03");
  var_0 scripts\common\vehicle::vehicle_lights_on("headlights");
  var_0 thread umike_damage_watcher();
  var_0.maxhealth = 21000;
  var_0 setnormalhealth(1);
  var_0.regenerate = 0;
  var_0 endon("death");
  var_0.team = "axis";
  var_0 scripts\common\vehicle::godoff();
  var_0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_1 = getvehiclenode("tarmac_umike_03_start", "targetname");
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  wait 0.5;
  var_0 endon("death");

  while(var_0.veh_speed > 5)
    wait 0.1;
}

tarmac_umike_08() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_08");
  var_0 scripts\common\vehicle::vehicle_lights_on("headlights");
  var_0.maxhealth = 21000;
  var_0 endon("death");
  var_0.team = "axis";
  var_0 thread umike_damage_watcher();
  var_0 scripts\common\vehicle::godoff();
  var_0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_1 = getvehiclenode("tarmac_umike_08_start", "targetname");
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  wait 0.5;
  var_2 = var_0 scripts\common\vehicle::vehicle_get_path_array();
  var_3 = var_2.size - 3;
  var_0 scripts\common\vehicle::godon();
  var_0 vehicle_teleport(var_2[var_3].origin, var_2[var_3].angles);
  var_0 endon("death");

  while(var_0.veh_speed > 1)
    wait 0.1;

  level notify("remove_tarmac_bp");
  var_0 scripts\common\vehicle::godoff();
  var_0 scripts\common\vehicle::vehicle_lights_off("headlights");
  scripts\engine\utility::flag_wait("apache_here");
  var_0.regenerate = 0;
}

tarmac_umike_09() {
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_09");
  var_0 scripts\common\vehicle::vehicle_lights_on("headlights");
  var_0.maxhealth = 21000;
  var_0 endon("death");
  var_0.team = "axis";
  var_0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_1 = getvehiclenode("tarmac_umike_09_start", "targetname");
  var_0 scripts\common\vehicle::godon();
  var_0 scripts\common\vehicle::attach_vehicle_and_gopath(var_1);
  wait 0.5;
  var_0 endon("death");

  while(var_0.veh_speed > 1)
    wait 0.1;

  var_0 scripts\common\vehicle::vehicle_lights_off("headlights");
  scripts\engine\utility::flag_wait("apache_here");
  var_0.regenerate = 0;
}

umike_damage_watcher() {
  self endon("death");

  for(;;)
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
}

tarmac_vindia_02(var_0, var_1) {
  if(isDefined(var_0))
    var_2 = var_0;
  else
    var_2 = 0;

  wait(var_2);
  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_4 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_vindia_02");
  level.tarmac_vindia_02 = var_4;
  var_4 thread vindia_spotlight();
  var_4 scripts\common\vehicle::godon();
  var_4.regenerate = 1;
  var_4.maxhealth = 35000;
  var_4.mgturret[0] makeunusable();
  var_4 endon("death");
  var_4.team = "axis";
  var_4 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_4 playSound("scn_shf_vindia_drivein");
  var_5 = getvehiclenode("tarmac_vindia_02_start", "targetname");
  level.ks_vehicles[level.ks_vehicles.size] = var_4;
  var_4 scripts\common\vehicle::attach_vehicle_and_gopath(var_5);
  var_6 = var_4 scripts\common\vehicle::vehicle_get_path_array();
  var_7 = var_6.size - 7;
  var_4 vehicle_teleport(var_6[var_7].origin, var_6[var_7].angles);

  if(isDefined(var_1)) {
    var_7 = var_6.size - 5;
    var_4 vehicle_teleport(var_6[var_7].origin, var_6[var_7].angles);
  }

  var_8 = scripts\engine\utility::getStruct("turret_path", "targetname");
  var_9 = scripts\engine\utility::spawn_tag_origin(var_8.origin + (0, 0, 0), level.player.angles);
  var_4 tank_aim_at(var_9);
  var_4 endon("death");
  scripts\engine\utility::flag_wait("pallet_smash");
  thread scripts\engine\utility::play_sound_in_space("scn_shf_palette_smash", var_4.origin);
  thread enable_hangar_vehicles();
  wait 2;
  var_4 tank_fire_enable();
  var_9 thread vindia_target_mover();
  scripts\engine\utility::flag_wait("apache_here");
  var_4.regenerate = 0;
  var_4 thread scripts\common\vehicle_code::vehicle_disable_navobstacles();
  var_4 scripts\common\vehicle::godoff();
  var_4.maxhealth = 35000;
  var_4 setnormalhealth(1);
  var_10 = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles + (0, 90, 0));
  var_4.angles = var_10.angles;
  var_4 linkTo(var_10);
  waitframe();
  var_4 thread scripts\common\vehicle_code::vehicle_enable_navobstacles();
  var_4 thread scripts\common\vehicle_code::vehicle_enable_navrepulsors();
  var_4 thread vehicle_jolt_watcher();

  for(;;) {
    var_10 moveTo(var_10.origin + anglesToForward(var_10.angles) * 100, 3);
    wait 5;
    var_10 moveTo(var_10.origin + anglesToForward(var_10.angles) * -100, 3);
    wait 5;
    var_10 moveTo(var_10.origin + anglesToForward(var_10.angles) * 100, 4);
    wait 6;
    var_10 moveTo(var_10.origin + anglesToForward(var_10.angles) * -100, 4);
    wait 5;
  }
}

vehicle_jolt_watcher() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_9) && scripts\engine\utility::is_equal(var_1, level.player)) {
      if(scripts\engine\utility::is_equal(var_9.basename, "apache_proj_sp"))
        self joltbody(var_2, 10);
    }
  }
}

enable_hangar_vehicles() {
  var_0 = getscriptablearray("hangar_trucks", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("body", "healthy");
}

vindia_spotlight() {
  var_0 = getEntArray("vindia_spotlight", "targetname");
  var_1 = 3;

  foreach(var_3 in var_0) {
    var_3.origin = self.mainturret gettagorigin("tag_front_turret_light");
    var_3.origin = var_3.origin + anglesToForward(var_3.angles) * var_1;
    var_3.angles = self.mainturret gettagangles("tag_front_turret_light");
    var_3.angles = var_3.angles + (10, 0, 0);
    var_3 linkTo(self.mainturret, "tag_front_turret_light");
    var_3.og_intensity = var_3 getlightintensity();
    var_3 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("pallet_smash");
  wait 1;

  foreach(var_3 in var_0)
  var_3 setlightintensity(var_3.og_intensity);

  scripts\engine\utility::flag_wait("air_support_inbound");
  wait 1;

  foreach(var_3 in var_0)
  var_3 setlightintensity(0);
}

vindia_target_mover() {
  wait 2;
  var_0 = scripts\engine\utility::getStruct("turret_path", "targetname");
  self.origin = var_0.origin;
  wait 1;
  var_0 = var_0 scripts\engine\utility::get_target_ent();
  var_0 = var_0 scripts\engine\utility::get_target_ent();
  var_0 = var_0 scripts\engine\utility::get_target_ent();
  var_0 = var_0 scripts\engine\utility::get_target_ent();
  self moveTo(var_0.origin, 2);
  wait 5;

  for(;;) {
    var_0 = var_0 scripts\engine\utility::get_target_ent();

    if(!isDefined(var_0.target))
      var_0 = scripts\engine\utility::getStruct("turret_path", "targetname");

    self moveTo(var_0.origin, 2);
    wait 3.5;
  }
}

tarmac_vindia_03() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_vindia_03");
  var_1 scripts\common\vehicle::vehicle_lights_on();
  level.tarmac_vindia_03 = var_1;
  var_1.regenerate = 0;
  var_1.maxhealth = 35000;
  var_1 setnormalhealth(1);
  var_1 endon("death");
  var_1.team = "axis";
  var_1 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var_2 = getvehiclenode("tarmac_vindia_03_start", "targetname");
  level.ks_vehicles[level.ks_vehicles.size] = var_1;
  var_1 scripts\common\vehicle::attach_vehicle_and_gopath(var_2);
  wait 9;
  var_3 = scripts\engine\utility::spawn_tag_origin((-42379, 28449, -544), (0, 0, 0));
  var_1 tank_aim_at(var_3);

  while(var_1.veh_speed > 0)
    wait 0.1;

  var_1 tank_fire_enable();
  var_4 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_1 linkTo(var_4);

  for(;;) {
    var_4 moveTo(var_4.origin + anglesToForward(var_4.angles) * 70, 3);
    wait 5;
    var_4 moveTo(var_4.origin + anglesToForward(var_4.angles) * -70, 3);
    wait 5;
    var_4 moveTo(var_4.origin + anglesToForward(var_4.angles) * 70, 3);
    wait 4;
    var_4 moveTo(var_4.origin + anglesToForward(var_4.angles) * -70, 3);
    wait 4;
  }
}

tank_fire_enable() {
  self.mainturret.script_delay_min = 1.5;
  self.mainturret.script_delay_max = 2.0;
  self.mainturret turretfireenable();
  self.mainturret startfiring();
  self.mainturret thread scripts\sp\mgturret::burst_fire_unmanned();
}

tank_fire_disable() {
  self.mainturret stopfiring();
  self.mainturret notify("stop_burst_fire_unmanned");
  self.mgturret[0] stopfiring();
  self.mgturret[0] notify("stop_burst_fire_unmanned");
}

tank_aim_at(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  self.mainturret settargetentity(var_0, var_1);
  self.mgturret[0] settargetentity(var_0, var_1);
}

damage_watcher() {
  self endon("death");

  while(isDefined(self))
    self waittill("damage", var_0);
}

fob_spawn_funcs() {
  var_0 = getspawnerarray("technical_dudes_01");
  scripts\engine\sp\utility::array_spawn_function(var_0, ::technical_dudes_01_spawn_func);
  var_1 = getspawnerarray("pre_charge_wallSpawner");
  scripts\engine\sp\utility::array_spawn_function(var_1, ::pre_charge_wallspawner_spawn_func);
  var_2 = scripts\engine\utility::array_combine(getspawnerarray("fob_front_guys"), getspawnerarray("fob_front_guys_2"));
  var_2 scripts\engine\sp\utility::array_spawn_function(var_2, ::fob_front_guys_spawn_func);
  var_3 = scripts\engine\utility::array_combine(getspawnerarray("fob_guys_center_containers"), getspawnerarray("fob_guys_rear"));
  scripts\engine\sp\utility::array_spawn_function(var_3, ::fob_center_guys_spawn_func);
  var_4 = scripts\engine\utility::array_combine(getspawnerarray("fob_guys_chu"), getspawnerarray("fob_guys_chu_rear"));
  scripts\engine\sp\utility::array_spawn_function(var_4, ::fob_container_guys_spawn_func);
  var_5 = scripts\common\utility::getvehiclespawner("chu_chopper", "targetname");
  var_5 scripts\engine\sp\utility::add_spawn_function(::chu_chopper_spawn_func);
  var_6 = scripts\common\utility::getvehiclespawner("fob_chopper_04", "targetname");
  var_6 scripts\engine\sp\utility::add_spawn_function(::fob_center_chopper_spawn_func);
  var_7 = scripts\common\utility::getvehiclespawner("fob_chopper_transport", "targetname");
  var_7 scripts\engine\sp\utility::add_spawn_function(::fob_chopper_transport_spawn_func);
  var_8 = getspawnerarray("lb_04_guys");
  scripts\engine\sp\utility::array_spawn_function(var_8, ::fob_center_chopper_guys_spawn_func);
  var_9 = getspawnerarray("fob_chopper_transport_guys");
  scripts\engine\sp\utility::array_spawn_function(var_9, ::fob_chopper_transport_guys_spawn_func);
  var_10 = getspawnerarray("tower_guy_tarmac");
  scripts\engine\sp\utility::array_spawn_function(var_10, ::tower_guy_tarmac_spawn_func);
  var_11 = scripts\engine\utility::array_combine(getspawnerarray("tromeo_guys_02"), getspawnerarray("tromeo_guys_03"));
  scripts\engine\sp\utility::array_spawn_function(var_11, ::tromeo_guys_03_spawn_func);
}

fob_front_guys_spawn_func() {
  self.grenadeammo = 0;
}

fob_center_guys_spawn_func() {}

fob_container_guys_spawn_func() {
  scripts\engine\sp\utility::set_grenadeweapon("flash");
}

tower_guy_tarmac_spawn_func() {
  self endon("death");
  scripts\engine\sp\utility::trigger_wait_targetname("armory_02_trigger");
  scripts\engine\utility::exploder("hangar_enemy_smoke");
  self delete();
}

turret_guy_spawn_func() {
  self.baseaccuracy = 0.1;
  self.health = 1000;
}

fob_allies_spawn_setup() {
  level.allies[level.allies.size] = self;

  if(self.classname == "actor_ally_reb_desert_dmr")
    self.disablesniperbehaviors = 1;
}

gunner_death_watcher(var_0) {
  self endon("death");
  var_0 waittill("death");
  self kill();
}

chu_chopper_spawn_func() {
  level.chu_chopper = self;
  level.choppers[level.choppers.size] = self;
  self.clip = getEnt("chu_chopper_clip", "targetname");
  self.clip linkTo(self);
  self.maxhealth = 20200;
  self setnormalhealth(1);
  scripts\common\vehicle::godon();
  self.team = "axis";
  self.targetname = "chu_chopper";
  thread radiant_cockpit_light("cockpit_light_03");
  var_0 = scripts\engine\utility::getStruct("boss_chopper_chu_01", "targetname");
  self hideallparts();

  foreach(var_2 in self.mgturret)
  var_2 hideallparts();

  thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::track_fob_helo_spawn();
  thread boss_heli_weapons_create();
  waitframe();
  thread chopper_crew_behavior();
  self vehicle_teleport(var_0.origin - (0, 0, 200), var_0.angles);
  self vehicle_setspeed(90, 10, 10);
  thread chopper_damage_watcher();
  thread lb_attack_runs();
  self waittill("death", var_4);
  scripts\engine\utility::flag_set("dont_drone_nag");
  scripts\engine\utility::flag_set("boss_chopper_dead");

  if(scripts\engine\utility::flag("player_in_drone"))
    scripts\engine\utility::flag_waitopen("player_in_drone");

  scripts\engine\sp\utility::autosave_by_name("chu_chopper_dead");
  wait 0.6;

  if(var_4.classname == "player")
    level.player thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_containers_chopperdown_50", 1, 3);
}

fob_center_chopper_spawn_func() {
  self endon("pilot_killed");
  level.choppers[level.choppers.size] = self;
  self.og_position = self.origin;
  self.clip = getEnt("fob_chopper_04_clip", "targetname");
  self.clip linkTo(self);
  thread scripts\engine\utility::delete_on_death(self.clip);
  self.maxhealth = 20200;
  self setnormalhealth(1);
  thread radiant_cockpit_light("cockpit_light_02");
  scripts\common\vehicle::vehicle_lights_on("interior");
  self.team = "axis";
  self vehicle_setspeed(45, 20, 10);
  thread chopper_damage_watcher();
  thread chopper_crew_behavior();
  thread center_chopper_save_watcher();
  fob_center_chopper_behavior();
  self vehicle_setspeed(45, 20, 10);
  self setvehgoalpos(self.og_position, 1);
  self setneargoalnotifydist(100);
  self endon("death");
  self waittill("near_goal");

  if(isDefined(self.pilot))
    self.pilot delete();

  self delete();
}

fob_chopper_transport_spawn_func() {
  self endon("pilot_killed");
  level.choppers[level.choppers.size] = self;
  self.og_position = self.origin;
  self.clip = getEnt("fob_chopper_transport_clip", "targetname");
  self.clip linkTo(self);
  thread radiant_cockpit_light("cockpit_light_01");
  thread scripts\engine\utility::delete_on_death(self.clip);
  self.maxhealth = 24000;
  self setnormalhealth(1);
  self.team = "axis";
  self vehicle_setspeed(65, 30, 20);
  thread chopper_damage_watcher();
  thread chopper_transport_crew_behavior();
  fob_center_transport_behavior();
  self endon("death");
  self waittill("goal");

  if(scripts\engine\utility::flag("player_in_drone"))
    scripts\engine\utility::flag_waitopen("player_in_drone");

  if(isDefined(self.pilot))
    self.pilot delete();

  self delete();
}

radiant_cockpit_light(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 setlightintensity(0.015);
  var_1 setlightradius(100);
  var_2 = self gettagorigin("tag_pilot1") + (22, -10, 32);
  var_1.angles = self gettagangles("tag_pilot1") + (145, 0, 0);
  var_1.origin = var_2;
  var_1 linkTo(self);
  scripts\engine\utility::waittill_any("entitydeleted", "death");
  var_1 delete();
}

center_chopper_save_watcher() {
  self waittill("death");

  if(scripts\engine\utility::flag("player_in_drone")) {
    scripts\engine\utility::flag_waitopen("player_in_drone");
    scripts\engine\sp\utility::autosave_by_name("center_chopper_dead");
  }
}

chopper_crew_behavior() {
  var_0 = scripts\engine\utility::get_target_array();
  self.gunners = [];

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "gunner")) {
      self.gunners[self.gunners.size] = var_2;
      var_2 thread crew_chopper_death_watcher_behavior(self);
      var_2 thread crew_ignore_manager();
    }

    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "pilot")) {
      var_2.ignoreme = 1;
      self.pilot = var_2;
      var_2._blackboard.isburning = 0;

      if(scripts\engine\utility::is_equal(self.targetname, "chu_chopper"))
        var_2 hide();

      if(scripts\engine\utility::flag("air_support_inbound"))
        var_2.health = 100;

      thread pilot_death_watcher(var_2);
      thread chu_chopper_pilot_protector();
      thread wildfire_watcher();
    }
  }

  if(self.gunners.size > 0)
    thread chopper_gunners_killed_watcher();
}

chu_chopper_pilot_protector() {
  self.pilot endon("death");

  if(scripts\engine\utility::is_equal(self.targetname, "chu_chopper")) {
    self.pilot scripts\common\ai::magic_bullet_shield();
    scripts\engine\utility::flag_wait("chu_fire_lights");
    wait 2;
    self.pilot scripts\common\ai::stop_magic_bullet_shield();
  }
}

crew_ignore_manager() {
  self endon("death");
  self.ignoreme = 1;
  scripts\engine\utility::flag_wait("fob_exit_guards");
  wait 1;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::enemy_alive_counter_gate(2);
  self.ignoreme = 0;
}

chopper_transport_crew_behavior() {
  var_0 = scripts\engine\utility::get_target_array();
  self.gunners = [];

  foreach(var_2 in var_0) {
    var_2.ignoreme = 1;

    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "gunner")) {
      self.gunners[self.gunners.size] = var_2;
      var_2 thread crew_chopper_death_watcher_behavior(self);
    }

    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, "pilot")) {
      self.pilot = var_2;
      self.pilot.ignoreme = 1;

      if(scripts\engine\utility::flag("air_support_inbound"))
        var_2.health = 100;

      thread pilot_death_watcher(var_2);
      thread wildfire_watcher();
    }
  }

  if(self.gunners.size > 0)
    thread chopper_gunners_killed_watcher();

  self waittill("unloaded");
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  if(scripts\engine\utility::flag("fob_player_in_center_swarm"))
    goal_ent_position(800, var_0, "rear_goal_spots");
  else
    goal_ent_player(1200, var_0);

  wait 2;
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);

  foreach(var_2 in var_0)
  var_2.ignoreme = 0;
}

fob_chopper_transport_guys_spawn_func() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  wait 13;
  self.ignoreme = 0;
  self.ignoreall = 0;
}

tromeo_guys_03_spawn_func() {
  self.vehiclerunexit = 1;
}

fob_center_chopper_guys_spawn_func() {
  self endon("death");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "gunner")) {
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    self.baseaccuracy = 0.1;
    self.ignoreall = 1;
    self.ignoreme = 1;
    wait 6;
    self.ignoreall = 0;
    self.ignoreme = 0;

    if(scripts\engine\utility::flag("air_support_inbound"))
      scripts\engine\sp\utility::set_favoriteenemy(level.incomingapache);
  }
}

pilot_death_watcher(var_0) {
  self endon("death");
  var_0 thread pilotkill_watcher();

  while(isalive(var_0))
    waitframe();

  self notify("pilot_killed");
  self.pilot_killed = 1;
  wait 1;
  self kill();
}

pilotkill_watcher() {
  self waittill("death", var_0, var_1, var_2, var_3);

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(isDefined(var_1) && (var_1 == "MOD_PISTOL_BULLET" || var_1 == "MOD_RIFLE_BULLET" || var_1 == "MOD_EXPLOSIVE_BULLET"))
      level thread scripts\sp\utility::giveachievement_wrapper("pilotkill");
  }
}

wildfire_watcher() {
  self endon("vehicle_crashDone");
  self endon("in_air_explosion");

  for(;;) {
    self.pilot waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(isDefined(var_9) && scripts\engine\utility::is_equal(var_1, level.player)) {
      if(scripts\engine\utility::is_equal(var_9.basename, "molotov")) {
        break;
      }
    }
  }

  level thread scripts\sp\utility::giveachievement_wrapper("wildfire");

  if(isDefined(self))
    self kill();
}

boss_pilot_death_watcher() {
  self endon("death");
  var_0 = scripts\engine\utility::get_target_ent();
  var_0 scripts\common\ai::magic_bullet_shield();
  var_0.ignoreme = 1;
  scripts\engine\utility::flag_wait("chopper_wounded");
  wait 1;
  var_0 scripts\common\ai::stop_magic_bullet_shield();
}

boss_chopper_chu_behavior() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();
  self endon("death");
  var_2 = scripts\engine\utility::getStruct("boss_chopper_chu_01", "targetname");
  self setvehgoalpos(var_2.origin + (0, 0, -500), 1);
  self vehicle_setspeed(55, 20, 10);
  self setneargoalnotifydist(1000);
  self settargetyaw(var_2.angles[1]);
  scripts\engine\utility::flag_set("boss_rockets_disabled");
  thread boss_heli_weapons_create();
  self sethoverparams(50, 20, 5);
  scripts\engine\utility::flag_wait("strafe_setup");
  var_2 = scripts\engine\utility::getStruct("boss_chopper_chu_01", "targetname");
  self setvehgoalpos(var_2.origin + (0, 0, 0), 1);
  wait 2.0;
  childthread boss_mg_50cal(1);
  var_3 = 0;
  self vehicle_setspeed(45, 20, 10);
  var_4 = var_2 scripts\engine\utility::get_target_ent();
  self setvehgoalpos(var_4.origin + (0, var_3, 0), 0);
  self clearlookatent();
  self settargetyaw(var_4.angles[1]);
  self waittill("goal");
  thread chopper_nags();
  var_5 = var_4 scripts\engine\utility::get_target_ent();
  self setvehgoalpos(var_5.origin + (0, var_3, 0), 0);
  self settargetyaw(var_5.angles[1]);
  self vehicle_setspeed(65, 20, 20);
  self waittill("goal");
  var_6 = var_5 scripts\engine\utility::get_target_ent();
  self setvehgoalpos(var_6.origin + (0, 0, 0), 1);
  self settargetyaw(var_6.angles[1]);
  self waittill("goal");
  var_7 = var_6 scripts\engine\utility::get_target_ent();
  self setvehgoalpos(var_7.origin + (0, 0, 0), 1);
  self settargetyaw(var_7.angles[1]);
  self waittill("near_goal");
  var_8 = var_7 scripts\engine\utility::get_target_ent();
  self setvehgoalpos(var_8.origin + (30, 0, 200), 1);
  self settargetyaw(var_2.angles[1]);
  self notify("end_of_chu");
  self waittill("goal");
  wait 2;
  self vehicle_setspeed(45, 20, 10);
  var_9 = (var_8.origin[0], var_4.origin[1], var_4.origin[2]);
  self setvehgoalpos(var_9, 0);
  self clearlookatent();
  self settargetyaw(var_4.angles[1]);
  childthread boss_mg_50cal(0);
  self waittill("goal");
  self setvehgoalpos(var_5.origin + (0, 0, 0), 0);
  self settargetyaw(var_5.angles[1]);
  self vehicle_setspeed(65, 20, 20);
  self waittill("goal");
  self setvehgoalpos(var_6.origin + (0, 0, 0), 1);
  self settargetyaw(var_6.angles[1]);
  self waittill("goal");
  self setvehgoalpos(var_7.origin + (0, 0, 0), 1);
  self settargetyaw(var_7.angles[1]);
  self waittill("near_goal");
  self setvehgoalpos(var_8.origin + (50, -400, 250), 1);
  self settargetyaw(var_2.angles[1]);
  self sethoverparams(200, 20, 5);
  self notify("end_of_chu");
  scripts\engine\utility::flag_set("boss_turret_enabled");
  scripts\engine\utility::flag_wait("chu_exit");
  scripts\engine\utility::flag_clear("boss_rockets_disabled");
}

chopper_nags() {
  self endon("death");
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_gethadir();

  for(;;) {
    var_0 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::dialogue("Hit that chopper with an RC plane!");
    wait 18;
  }
}

boss_chopper_rockets() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale.gsc::level_getfarah();
  var_1 = spawnStruct();
  var_2 = 1;
  self endon("death");
  var_3 = 0;
  scripts\engine\utility::flag_waitopen("boss_rockets_disabled");

  while(!scripts\engine\utility::flag("boss_chopper_dead")) {
    if(scripts\engine\utility::flag("player_in_drone"))
      scripts\engine\utility::flag_waitopen("player_in_drone");

    if(scripts\engine\utility::flag("boss_rockets_disabled"))
      scripts\engine\utility::flag_waitopen("boss_rockets_disabled");

    var_4 = level.player.origin;
    var_5 = vectortoangles(var_4 - self.origin);
    var_6 = var_5[1];
    wait(randomfloatrange(1.9, 2.2));
    var_7 = var_4 + anglestoright(self.angles) * -20 + (0, 0, 25);
    var_8 = var_4 + anglestoright(self.angles) * 20 + (0, 0, 25);

    if(!scripts\engine\utility::flag("chopper_wounded")) {
      var_7 = var_7 + anglesToForward(level.player.angles) * var_3;
      var_8 = var_8 + anglesToForward(level.player.angles) * var_3;
    }

    var_9 = self gettagorigin("tag_missile_l_4");
    var_10 = self gettagorigin("tag_missile_r_4");
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_r_4");
    thread scripts\engine\utility::playsoundontag("weap_lalpha_fire_npc", "tag_missile_r_4");
    magicbullet("iw8_la_rpapa7_straight_weak", var_10, var_4);
    wait 0.5;

    if(scripts\engine\utility::flag("player_in_drone")) {
      continue;
    }
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_l_4");
    thread scripts\engine\utility::playsoundontag("weap_lalpha_fire_npc", "tag_missile_l_4");
    magicbullet("iw8_la_rpapa7_straight_weak", var_9, var_4);
    level notify("boss_rockets_fired");
    wait 1.5;
  }
}

chopper_rocket_behavior() {
  self endon("death");
  wait 4;

  for(;;) {
    var_0 = distance(level.incomingapache.origin, self.origin);

    if(var_0 < 500) {
      wait 1;
      continue;
    }

    wait(randomfloatrange(1.9, 2.2));
    var_1 = self.pods[0].origin;
    var_2 = self.pods[0].origin;
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_1, var_3);
    wait 1;
    var_1 = self.pods[0].origin;
    var_2 = self.pods[0].origin;
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_2, var_3);
    wait 1;
    var_1 = self.pods[0].origin;
    var_2 = self.pods[0].origin;
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_1, var_3);
    wait 1;
    var_1 = self.pods[0].origin;
    var_2 = self.pods[0].origin;
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_2, var_3);
    level notify("boss_rockets_fired");
    wait 3;
  }
}

chopper_final_rocket_behavior() {
  self endon("death");
  wait 4;

  for(;;) {
    var_0 = distance(level.incomingapache.origin, self.origin);

    if(var_0 < 500) {
      wait 1;
      continue;
    }

    wait(randomfloatrange(1.9, 2.2));
    var_1 = self gettagorigin("tag_missile_l_1");
    var_2 = self gettagorigin("tag_missile_r_1");
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_l_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_1, var_3);
    wait 1;
    var_1 = self gettagorigin("tag_missile_l_1");
    var_2 = self gettagorigin("tag_missile_r_1");
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_r_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_2, var_3);
    wait 1;
    var_1 = self gettagorigin("tag_missile_l_1");
    var_2 = self gettagorigin("tag_missile_r_1");
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_l_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_1, var_3);
    wait 1;
    var_1 = self gettagorigin("tag_missile_l_1");
    var_2 = self gettagorigin("tag_missile_r_1");
    var_3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_r_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var_2, var_3);
    level notify("boss_rockets_fired");
    wait 3;
  }
}

boss_heli_weapons_create() {
  var_0 = "tag_light_2";
  var_1 = (0, 0, 0);
  var_2 = self gettagorigin(var_0);
  self endon("death");
  self.target_ent = scripts\engine\utility::spawn_tag_origin();
  thread boss_chopper_mg_attack();
  scripts\engine\utility::flag_wait("boss_turret_enabled");
  self.mgturret[0] setmode("auto_nonai");
  self.mgturret[1] setmode("auto_nonai");
  self.mgturret[0] setdefaultdroppitch(0);
  self.mgturret[0] setleftarc(180);
  self.mgturret[0] setrightarc(180);
  self.mgturret[0] settoparc(180);
  self.mgturret[0] setbottomarc(180);
  self.mgturret[0] setconvergencetime(0.05, "yaw");
  self.mgturret[0] setconvergencetime(0.05, "pitch");
  scripts\engine\utility::flag_wait("chopper_wounded");
  self.minigun delete();
}

boss_chopper_mg_attack() {
  self endon("death");
  level endon("boss_turret_disabled");
  self.can_see_drone = 0;
  self.can_see_player = 0;
  self.accuracy = 0;
  self.mgturret[0] settargetentity(level.player);
  self.mgturret[1] settargetentity(level.player);
  var_0 = 0;
  scripts\engine\utility::flag_wait("boss_turret_enabled");

  while(!scripts\engine\utility::flag("boss_turret_disabled")) {
    if(!scripts\engine\utility::flag("player_in_drone")) {
      if(sighttracepassed(self.origin + (0, 0, -100), level.player.origin + (0, 0, 70), 0, undefined, 0) && !scripts\engine\utility::flag("boss_turret_disabled")) {
        if(self.can_see_player == 0) {
          wait 1;
          self.can_see_player = 1;
        }

        if(!scripts\engine\utility::flag("player_in_drone")) {
          self.accuracy = 1;
          self.mgturret[0] turretfireenable();
          self.mgturret[1] turretfireenable();

          while(sighttracepassed(self.origin + (0, 0, -100), level.player.origin + (0, 0, 70), 0, undefined, 0)) {
            for(var_1 = 0; var_1 < 4; var_1++) {
              var_2 = self.mgturret[0] gettagorigin("tag_flash");
              var_3 = self.mgturret[1] gettagorigin("tag_flash");
              magicbullet("iw8_mg_lbravo", var_2, level.player.origin + (0, 0, var_1));
              playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[0], "tag_flash");
              wait 0.2;
              magicbullet("iw8_mg_lbravo", var_3, level.player.origin + (0, 0, var_1));
              playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[1], "tag_flash");
            }

            wait 4;
          }
        }
      } else {
        self.can_see_player = 0;
        self.mgturret[0] turretfiredisable();
        self.mgturret[1] turretfiredisable();
        self.mgturret[0] cleartargetentity(level.player);
        self.mgturret[1] cleartargetentity(level.player);
      }
    }

    if(scripts\engine\utility::flag("player_in_drone")) {
      if(!scripts\engine\utility::flag("boss_turret_disabled") && isDefined(level.chopper_turret_target) && sighttracepassed(self.origin + (0, 0, -100), level.chopper_turret_target.origin + (0, 0, 20), 0, undefined, 0)) {
        while(isDefined(level.chopper_turret_target) && sighttracepassed(self.origin + (0, 0, -100), level.chopper_turret_target.origin + (0, 0, 20), 0, undefined, 0)) {
          for(var_1 = 0; var_1 < 5; var_1++) {
            if(!isDefined(level.chopper_turret_target)) {
              return;
            }
            var_2 = self.mgturret[0] gettagorigin("tag_flash");
            var_3 = self.mgturret[0] gettagorigin("tag_flash");
            magicbullet("iw8_mg_lbravo", var_2, level.chopper_turret_target.origin + (0, 0, var_1));
            playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[0], "tag_flash");
            wait 0.15;

            if(!isDefined(level.chopper_turret_target)) {
              return;
            }
            magicbullet("iw8_mg_lbravo", var_3, level.chopper_turret_target.origin + (0, 0, var_1));
            playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[1], "tag_flash");
          }

          wait 2;
        }
      } else
        self.can_see_drone = 0;

      self.mgturret[0] turretfiredisable();
      self.mgturret[1] turretfiredisable();
      self.mgturret[0] cleartargetentity(level.player);
      self.mgturret[1] cleartargetentity(level.player);
    }

    waitframe();
  }
}

turret_fire_enable() {
  self.mgturret[0].script_delay_min = 0.1;
  self.mgturret[0].script_delay_max = 0.2;
  self.mgturret[1].script_delay_min = 0.1;
  self.mgturret[1].script_delay_max = 0.2;
  self.mgturret[0] turretfireenable();
  self.mgturret[0] startfiring();
  self.mgturret[0] thread scripts\sp\mgturret::burst_fire_unmanned();
  wait 0.1;
  self.mgturret[1] turretfireenable();
  self.mgturret[1] startfiring();
  self.mgturret[1] thread scripts\sp\mgturret::burst_fire_unmanned();
}

fob_center_chopper_behavior() {
  self endon("death");
  self endon("kill_chopper_logic");
  self endon("chopper_gunners_dead");
  self.ignoreme = 1;
  var_0 = 250;
  var_1 = scripts\engine\utility::getStruct("fob_hover_bravo_struct_01", "targetname");
  self.hover_origin = var_1.origin;
  self setvehgoalpos(self.hover_origin + (0, 0, 200), 1);
  self setneargoalnotifydist(1000);
  self waittill("near_goal");
  self clearlookatent();
  self setlookatent(level.player);
  self waittill("goal");
  self vehicle_setspeed(45, 20, 10);
  self clearlookatent();
  var_2 = var_1;
  var_3 = 1000;
  var_4 = -100;
  var_5 = 20;
  self settargetyaw(var_5);
  self vehicle_setspeed(30, 10, 5);

  for(;;) {
    if(scripts\engine\utility::flag("fob_player_in_center_swarm"))
      var_3 = 1000;

    if(scripts\engine\utility::flag("fob_rear")) {
      var_3 = 1000;
      var_4 = 0;
    }

    var_2 = var_2 scripts\engine\utility::get_target_ent();
    self setvehgoalpos(var_2.origin + (var_3, var_4, 100), 1);
    self waittill("goal");
    wait(randomfloatrange(0.5, 2));
    var_5 = var_5 * -1;
    self settargetyaw(var_5);
  }
}

fob_center_transport_behavior() {
  scripts\engine\utility::flag_wait("fob_center");
  self endon("death");
  self endon("kill_chopper_logic");
  self endon("chopper_gunners_dead");
  self endon("pilot_killed");
  self.ignoreme = 1;
  var_0 = 250;
  var_1 = scripts\engine\utility::getStruct("fob_hover_bravo_struct_01", "targetname");
  self.hover_origin = var_1.origin;

  if(level.player.origin[1] > 33864.0) {
    self vehicle_teleport((-40444, 36636, -596), var_1.angles);
    self.rightside = 1;
    self.hover_origin = self.hover_origin + (500, 500, 500);
  }

  self setvehgoalpos(self.hover_origin, 1);
  self setneargoalnotifydist(1000);
  self waittill("near_goal");
  self clearlookatent();
  self setlookatent(level.player);
  self waittill("goal");
  self vehicle_setspeed(75, 40, 20);
  var_2 = var_1;
  var_3 = 1000;
  var_4 = -1000;

  if(scripts\engine\utility::flag("fob_player_in_center_swarm"))
    var_3 = 1000;

  if(scripts\engine\utility::flag("fob_rear")) {
    var_3 = 1000;
    var_4 = 0;
  }

  var_5 = scripts\engine\utility::getStruct("fob_chopper_unload", "targetname");
  self setneargoalnotifydist(600);
  self setvehgoalpos(var_5.origin + (0, 0, 120), 1);
  self waittill("near_goal");
  self sethoverparams(0, 0, 0);
  self waittill("goal");
  scripts\common\vehicle::vehicle_unload("both");
  self waittill("unloaded");
  self vehicle_setspeed(4, 15, 10);
  self setvehgoalpos(var_5.origin + (-550, 0, 400), 0);
  wait 3;
  self clearlookatent(level.player);
  self settargetyaw(270);
  self vehicle_setspeed(15, 15, 10);
  self waittill("goal");
  self vehicle_setspeed(20, 15, 10);
  wait 1;
  self setvehgoalpos(var_5.origin + (-1400, -1000, 800), 1);
  self waittill("goal");
  var_6 = scripts\engine\utility::getStruct("transport_chopper_end", "targetname");
  self.hover_origin = var_6.origin + (0, -2000, 20);
  self setvehgoalpos(self.hover_origin, 1);
}

fob_ks_chopper_behavior(var_0) {
  self endon("death");
  self endon("kill_chopper_logic");
  self endon("chopper_gunners_dead");
  var_1 = 0;
  var_2 = 0;
  var_3 = randomintrange(300, 350);
  self vehicle_setspeed(45, 20, 10);
  self setvehgoalpos(var_0.origin, 1);
  self waittill("goal");

  for(;;) {
    self vehicle_setspeed(25, 15, 10);
    var_0 = var_0 scripts\engine\utility::get_target_ent();
    self setvehgoalpos(var_0.origin + (var_1, var_2, var_3), 1);
    self waittill("goal");
    wait 1;
  }
}

chopper_damage_watcher() {
  self endon("death");
  self.bullet_health = 200;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_0 > 300 && var_1 == level.player || self.bullet_health < 1) {
      break;
    }
  }

  scripts\engine\utility::flag_set("chopper_wounded");
  self kill();
}

boss_chopper_damage_watcher() {
  while(!scripts\engine\utility::flag("chopper_wounded")) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(var_0 > 400 && scripts\engine\utility::is_equal(var_1, level.player) || scripts\engine\utility::is_equal(var_9, scripts\sp\utility::make_weapon("iw8_la_rpapa7_straight_slow"))) {
      break;
    }
  }

  scripts\engine\utility::flag_set("chopper_wounded");
  scripts\engine\utility::flag_set("boss_rockets_disabled");
  scripts\engine\utility::flag_set("boss_turret_disabled");
  self notify("chopper_wounded");
  scripts\common\vehicle::godoff();
  self kill();
}

lb_attack_runs() {
  self endon("death");
  var_0 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  var_1 = 1;
  thread show_chopper();
  var_2 = scripts\engine\utility::getStruct("bravo_strafe_01", "targetname");
  var_2.origin = var_2.origin + (0, -500, 0);
  var_3 = scripts\engine\utility::getStruct("boss_chopper_chu_06", "targetname");
  var_3.origin = var_3.origin + (0, -20, 0);
  var_4 = -150;
  var_5 = 0;
  level.allies = scripts\engine\utility::array_removedead_or_dying(level.allies);
  var_6 = scripts\engine\utility::array_add(level.allies, level.player);
  var_6 = scripts\engine\utility::array_randomize(var_6);
  var_0.origin = scripts\engine\utility::random(var_6).origin;
  self settargetyaw(65);
  self vehicle_settopspeedrotational(10);

  if(!var_1) {
    var_2 = var_3;
    var_4 = 0;
    level notify("attack_run_starting");
  } else
    var_5 = 3;

  wait(var_5);
  var_7 = (var_2.origin[0], var_2.origin[1], var_2.origin[2] + var_4);
  self setvehgoalpos(var_7, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  scripts\engine\utility::flag_wait_any("chu_strafe_run_go", "player_in_drone");
  self settargetyaw(90);
  wait 2;
  thread chu_explosion();
  self setmaxpitchroll(40, 40);
  var_8 = (var_2.origin[0], var_2.origin[1] + 3000, -150);
  var_9 = var_8 + anglesToForward((0, 90, 0)) * 500 + (0, 200, 0);
  var_10 = var_9 + (-1000, -4000, 0);

  if(!var_1)
    var_10 = var_9 + (-200, -4000, 0);

  self vehicle_setspeed(35, 30, 5);
  self setvehgoalpos(var_8, 0);
  self setneargoalnotifydist(600);
  level notify("chu_attack_start");
  childthread lb_mg_50cal(var_0, var_1);
  self waittill("near_goal");
  scripts\common\vehicle::godoff();
  scripts\engine\utility::flag_set("chu_chopper_first_attack_done");
  self clearlookatent();
  self setvehgoalpos(var_9, 0);
  self settargetyaw(160);
  self vehicle_setspeed(75, 35, 10);
  self waittill("near_goal");
  var_1 = 0;
  self cleartargetyaw();
  self settargetyaw(270);
  self setneargoalnotifydist(200);
  self setvehgoalpos(var_10, 0);
  self vehicle_setspeed(55, 35, 10);
  self waittill("goal");
  self cleartargetyaw();
  self settargetyaw(0);
  wait 2;
  var_2 = scripts\engine\utility::getStruct("boss_chopper_chu_06", "targetname");
  self setneargoalnotifydist(20);
  self setvehgoalpos(var_2.origin + (0, 0, 200), 0);
  self vehicle_setspeed(10, 10, 10);
  self sethoverparams(50, 20, 5);
  self settargetyaw(var_2.angles[1]);
  self waittill("goal");
  var_11 = scripts\engine\utility::getStruct("bravo_strafe_01", "targetname");
  self.current_struct_angles = var_11.angles;
  thread chu_chopper_yaw_updater();
  scripts\engine\utility::flag_set("boss_turret_enabled");
  self setlookatent(level.player);
  var_12 = scripts\engine\utility::getStruct("chu_chopper_patrol_01", "targetname");
  var_13 = scripts\engine\utility::getStruct("chu_chopper_patrol_02", "targetname");
  var_12.origin = var_12.origin + (0, 0, 200);
  var_13.origin = var_13.origin + (0, 0, 200);

  while(!scripts\engine\utility::flag("chu_exit")) {
    self.current_struct_angles = var_12.angles;
    self setvehgoalpos(var_12.origin, 0);
    self waittill("goal");
    wait 6;
    self.current_struct_angles = var_13.angles;
    self setvehgoalpos(var_2.origin + (0, 0, 200), 0);
    self waittill("goal");
    wait 3;
  }

  self setvehgoalpos((-40351.1, 30529.1, -197), 1);
  scripts\engine\utility::flag_wait("hangar_interior");
  self setvehgoalpos((-40351.1, 30529.1, 0), 1);
  self waittill("goal");
  self setvehgoalpos((-55003.1, 23393.1, 400), 1);
  self waittill("goal");
  self delete();
  scripts\engine\utility::flag_set("boss_chopper_dead");
}

show_chopper() {
  scripts\engine\utility::flag_wait_any("chu_strafe_run_go", "player_in_drone");
  self showallparts();

  foreach(var_1 in self.mgturret)
  var_1 showallparts();

  self.pilot show();
}

chu_chopper_yaw_updater() {
  self endon("death");

  for(;;) {
    if(scripts\engine\utility::flag("player_in_drone")) {
      wait 2;

      if(scripts\engine\utility::flag("player_in_drone")) {
        self clearlookatent();

        if(isDefined(level.player_dronemodel)) {
          self setlookatent(level.player_dronemodel);
          scripts\engine\utility::flag_waitopen("player_in_drone");
          self clearlookatent();
          self cleartargetyaw();
        }
      }
    }

    self setlookatent(level.player);
    waitframe();
  }
}

lb_mg_50cal(var_0, var_1) {
  var_2 = 1.1;

  if(var_1)
    var_2 = 0;

  wait(var_2);
  var_3 = 30;
  var_4 = -40;
  var_5 = spawnStruct();
  var_5.origin = (-41481, 34229, -726);

  if(!var_1)
    var_5.origin = (-41891, 34029, -726);

  var_6 = var_5.origin;
  thread lb_mg_50cal_sound();
  var_7 = self.mgturret[0] gettagorigin("tag_flash");
  var_8 = self.mgturret[1] gettagorigin("tag_flash");
  self endon("death");

  for(var_9 = var_3; var_9 > var_4; var_9 = var_9 - 2) {
    var_10 = var_9 * -30;
    var_7 = self.mgturret[0] gettagorigin("tag_flash");
    var_8 = self.mgturret[1] gettagorigin("tag_flash");
    magicbullet("iw8_mg_lbravo", var_7, var_6 + (0, var_10, 0));
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[0], "tag_flash");
    wait 0.1;
    magicbullet("iw8_mg_lbravo", var_8, var_6 + (130, var_10, 0));
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[1], "tag_flash");
    wait 0.05;
  }

  self notify("attack_done");
}

boss_mg_50cal(var_0) {
  var_1 = 0.2;

  if(!var_0)
    var_1 = 0;

  wait(var_1);
  var_2 = 36;
  var_3 = -46;
  var_4 = 110;
  var_5 = spawnStruct();
  var_5.origin = (-41491, 34029, -726);

  if(!var_0) {
    var_5.origin = (-41830, 33710, -726);
    var_4 = 50;
  }

  var_6 = var_5.origin;
  thread lb_mg_50cal_sound();
  self endon("death");

  for(var_7 = var_2; var_7 > var_3; var_7 = var_7 - 2) {
    var_8 = self gettagorigin("tag_missile_l_4");
    var_9 = self gettagorigin("tag_missile_r_4");
    var_10 = var_7 * -30;
    magicbullet("iw8_lm_pkilo", var_8, var_6 + (0, var_10, 0));
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var_8);
    magicbullet("iw8_lm_pkilo", var_9, var_6 + (var_4, var_10, 0));
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var_9);
    wait 0.1;
  }

  self notify("attack_done");
}

lb_mg_50cal_sound() {
  self playLoopSound("scn_safehouse_minigun_heli_gatling_fire");
  scripts\engine\utility::waittill_any("attack_done", "death");
  self stoploopsound("scn_safehouse_minigun_heli_gatling_fire");
}

lb_gunner() {
  var_0 = getEnt("lb_door_gunner_og", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1 linkTo(self);
  var_2 = scripts\engine\sp\utility::spawn_targetname("lb_door_gunner");
  var_2 linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2 allowedstances("crouch");
  var_2 endon("death");
  self waittill("death");
  var_2 kill();
}

crew_chopper_death_watcher_behavior(var_0) {
  var_0 endon("unloaded");
  self endon("death");
  var_0 waittill("death");
  wait 2;
  self kill();
}

crew_chopper_transport_behavior(var_0) {
  self endon("death");
  var_0 waittill("goal");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "gunner")) {
    self.ignoreme = 1;
    var_0 waittill("unloaded");
    self.ignoreme = 0;
    self.ignoreall = 0;
  }
}

chopper_gunners_killed_watcher() {
  self endon("death");

  while(self.gunners.size > 0) {
    self.gunners = scripts\engine\utility::array_removedead_or_dying(self.gunners);
    wait 0.1;
  }

  self notify("chopper_gunners_dead");

  if(scripts\engine\utility::flag("air_support_inbound"))
    self kill();
}

chopper_pilot_death_watcher() {
  self endon("death");
  self.pilot waittill("death");
  self kill();
}

heli_mg(var_0) {
  var_1 = self.mg.origin + anglesToForward(self.angles) * -500;

  for(var_2 = 0; var_2 < 30; var_2++) {
    magicbullet("iw8_lm_kilo121", self.mg.origin, var_0);
    magicbullet("iw8_lm_kilo121", self.mg.origin, var_0 + (randomintrange(-20, 20), 10, randomintrange(-20, 20)));
    wait 0.075;
  }

  wait 1;

  if(isDefined(self.first_struct)) {
    for(var_2 = 0; var_2 < 20; var_2++) {
      magicbullet("iw8_lm_kilo121", self.mg.origin, var_0);
      magicbullet("iw8_lm_kilo121", self.mg.origin, var_0 + (randomintrange(-20, 20), 10, randomintrange(-20, 20)));
      wait 0.075;
    }
  }
}

spawn_check_func(var_0, var_1, var_2) {
  if(scripts\engine\utility::flag("ai_spawner_busy"))
    scripts\engine\utility::flag_waitopen("ai_spawner_busy");

  scripts\engine\utility::flag_set("ai_spawner_busy");

  if(!isDefined(var_0))
    var_0 = 32;

  var_3 = getaiarray("axis", "allies");
  var_4 = var_0 - var_3.size;
  var_5 = getspawnerarray(var_1);
  var_6 = [];

  if(var_4 == 0) {
    scripts\engine\utility::flag_clear("ai_spawner_busy");
    return undefined;
  }

  if(var_5.size - var_4 < 0)
    var_4 = var_5.size;

  if(isDefined(var_2) && var_2 < var_4)
    var_4 = var_2;

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_8 = var_0 - var_3.size;

    if(var_8 <= 0) {
      break;
    }

    var_6[var_6.size] = var_5[var_7] scripts\engine\sp\utility::spawn_ai(1);
    var_5[var_7].count = 1;
  }

  scripts\engine\utility::flag_clear("ai_spawner_busy");
  return var_6;
}

oil_fires_init() {
  wait 1;
  var_0 = getEntArray("oil_fire_ogs", "targetname");

  foreach(var_2 in var_0) {}

  thread tarmac_gameplay_fires();
}

tarmac_gameplay_fires() {
  if(istrue(level.bink_start)) {
    return;
  }
  scripts\engine\utility::exploder("tarmac_smk");
  scripts\engine\utility::exploder("pallet_plume");
  scripts\engine\utility::exploder("sky_smoke");

  if(scripts\sp\starts::is_after_start("killstreak_chopper")) {
    return;
  }
  scripts\engine\utility::flag_wait("enter_bunkers");
  scripts\engine\utility::exploder("tarmac_plumes");
  scripts\engine\utility::flag_wait("fob_exit");
  scripts\engine\utility::exploder("aftermath");
  scripts\engine\utility::flag_set("tarmac_fire_lights");
  scripts\engine\utility::flag_wait("apache_here");
  scripts\engine\utility::stop_exploder("pallet_plume");
  waitframe();
  scripts\engine\utility::stop_exploder("tarmac_plumes");
  scripts\engine\utility::stop_exploder("sky_smoke");
  scripts\engine\utility::flag_wait("killstreak_complete");
  scripts\engine\utility::stop_exploder("aftermath");
}

cull_redshirts_for_startpoint(var_0, var_1) {
  var_2 = [];

  while(var_0.size > var_1) {
    var_2[var_2.size] = scripts\engine\utility::array_remove(var_0, var_0[var_0.size - 1]);
    waitframe();
  }

  var_2 = scripts\engine\utility::array_remove_array(var_0, var_2);
  scripts\engine\utility::array_delete(var_0);
  return var_2;
}

town_technical_01() {
  level.technical_01 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_01");
  level.technical_01.maxhealth = 50000;
  level.technical_01.regenerate = 1;
  var_0 = getvehiclenode("technical_start_01", "targetname");
  level.technical_01 scripts\common\vehicle::godon();
  var_1 = getEntArray("truck_lights", "targetname");
  waitframe();
  var_2 = 2.5;

  foreach(var_4 in var_1) {
    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "left")) {
      var_4.origin = level.technical_01 gettagorigin("tag_light_front_left");
      var_4.origin = var_4.origin + anglesToForward(var_4.angles) * var_2;
      var_4.angles = level.technical_01 gettagangles("tag_light_front_left");
      var_4 linkTo(level.technical_01);
      playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_left_nolight"), level.technical_01, "tag_light_front_left");
    }

    if(scripts\engine\utility::is_equal(var_4.script_noteworthy, "right")) {
      var_4.origin = level.technical_01 gettagorigin("tag_light_front_right");
      var_4.origin = var_4.origin + anglesToForward(var_4.angles) * var_2;
      var_4.angles = level.technical_01 gettagangles("tag_light_front_right");
      var_4 linkTo(level.technical_01);
      playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_right_nolight"), level.technical_01, "tag_light_front_right");
    }
  }

  level.technical_01 scripts\common\vehicle::attach_vehicle_and_gopath(var_0);
  level.technical_01 endon("death");
  level.technical_01 endon("entitydeleted");
  level.technical_01 vehicle_setspeedimmediate(18, 5);
  wait 6;
  level.technical_01 vehicle_setspeedimmediate(5, 5);

  while(level.technical_01.veh_speed)
    wait 0.1;

  level notify("technical_stopped");
  wait 4;
  level.technical_01 scripts\common\vehicle::godoff();
  level.technical_01 endon("death");
  scripts\engine\utility::flag_wait("bunker_busted");

  foreach(var_4 in var_1)
  var_4 setlightintensity(0);

  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_right_nolight"), level.technical_01, "tag_light_front_right");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_left_nolight"), level.technical_01, "tag_light_front_left");
}

technical_dudes_01_spawn_func() {
  self endon("death");
  self.vehiclerunexit = 1;
  thread scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  level waittill("technical_stopped");
  self.ignoreall = 1;
  thread scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  scripts\engine\sp\utility::set_force_color("r");
  wait 5;
  self.ignoreall = 0;
  thread scripts\engine\sp\utility::enable_bulletwhizbyreaction();
}

pre_charge_wallspawner_spawn_func() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\engine\utility::set_movement_speed(180);
  self waittill("goal");

  if(!istrue(self.general))
    self delete();
}

fob_guys_center_start_spawn_func() {
  scripts\engine\sp\utility::set_goal_pos((-36846.9, 33612.3, -644));
  self.shouldjoinsquad = 1;
}

fob_guys_center_spawn_func() {}

tromeo_guys_spawn_func() {}

objective_manager() {
  waitframe();
  var_0 = getnode("hadir_rooftop_node", "targetname");
  scripts\engine\sp\objectives::objective_add("reach_roof", "current", var_0.origin + (0, 0, 100), &"SAFEHOUSE_FINALE_LOC/OBJ_UPSTAIRS");
  scripts\engine\utility::flag_wait("intro_player_behind_hadir");
  scripts\engine\sp\objectives::objective_remove("reach_roof");
  var_1 = getEnt("player_tablet", "targetname");
  scripts\engine\sp\objectives::objective_add("get_controls", "current", var_1.origin + (0, 0, 20), &"SAFEHOUSE_FINALE_LOC/GET_CONTROLS");
  scripts\engine\utility::flag_wait("player_has_tablet");
  scripts\engine\sp\objectives::objective_remove("get_controls");
  var_2 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy")[0];
  var_3 = spawnStruct();
  var_3.origin = var_2.origin;

  if(!scripts\engine\utility::flag("fly_attack_done")) {
    while(!isDefined(level.choppers[0]))
      waitframe();

    scripts\engine\sp\objectives::objective_add("crash", "current", var_3.origin + (0, 0, 20), &"SAFEHOUSE_FINALE_LOC/CRASH_RC");
    scripts\engine\sp\objectives::objective_set_on_entity("crash", undefined, level.choppers[0]);
    scripts\engine\utility::flag_wait("fly_attack_done");
    scripts\engine\sp\objectives::objective_remove("crash");
  }

  var_4 = spawnStruct();
  var_4.origin = (-33439, 31016, -622.09);
  scripts\engine\sp\objectives::objective_add("hold_at_wall", "current", var_4.origin, &"SAFEHOUSE_FINALE_LOC/REGROUP");
  scripts\engine\utility::flag_wait("bunker_busted");
  scripts\engine\sp\objectives::objective_remove("hold_at_wall");
  var_5 = spawnStruct();
  var_5.origin = (-36412, 33448, -604);
  scripts\engine\sp\objectives::objective_add("clear_bunkers", "current", var_5.origin, &"SAFEHOUSE_FINALE_LOC/BUNKERS");
  scripts\engine\utility::flag_wait("fob_center");
  scripts\engine\sp\objectives::objective_remove("clear_bunkers");
  var_6 = scripts\engine\utility::getStruct("armory_struct_01", "targetname");
  scripts\engine\sp\objectives::objective_add("secure_armory_01", "current", var_6.origin, &"SAFEHOUSE_FINALE_LOC/ARMORY_01");
  scripts\engine\utility::flag_wait("armory_01_secure");
  scripts\engine\sp\objectives::objective_remove("secure_armory_01");
  scripts\engine\sp\objectives::objective_add("clear_fob", "current", undefined, &"SAFEHOUSE_FINALE_LOC/SECURE_AREA");
  scripts\engine\utility::flag_wait("fob_cleared");
  scripts\engine\sp\objectives::objective_remove("clear_fob");
  var_7 = spawnStruct();
  var_7.origin = (-40551, 34709, -700);
  scripts\engine\sp\objectives::objective_add("lookat_hadir", "current", var_7.origin + (0, 0, 100), &"SAFEHOUSE_FINALE_LOC/REGROUP_GATE");
  scripts\engine\utility::flag_wait("container_door_breached");
  scripts\engine\sp\objectives::objective_remove("lookat_hadir");

  if(!scripts\engine\utility::flag("boss_chopper_dead")) {
    scripts\engine\utility::flag_wait("chu_strafe_run_go");

    while(!isDefined(level.chu_chopper))
      waitframe();

    scripts\engine\sp\objectives::objective_add("boss_chopper", "current", undefined, &"SAFEHOUSE_FINALE_LOC/DESTROY_CHOPPER");
    scripts\engine\sp\objectives::objective_set_on_entity("boss_chopper", undefined, level.chu_chopper);
    scripts\engine\utility::flag_wait("boss_chopper_dead");
    scripts\engine\sp\objectives::objective_remove("boss_chopper");
  }

  var_8 = spawnStruct();
  var_8.origin = (-43901, 35648, -405);
  scripts\engine\sp\objectives::objective_add("clear_containers", "current", undefined, &"SAFEHOUSE_FINALE_LOC/CLEAR_CONTAINERS");
  scripts\engine\utility::flag_wait("chu_exit");
  scripts\engine\sp\objectives::objective_remove("clear_containers");
  var_9 = scripts\engine\utility::getStruct("armory_struct_02", "targetname");
  scripts\engine\sp\objectives::objective_add("secure_armory_02", "current", var_9.origin, &"SAFEHOUSE_FINALE_LOC/ARMORY_01");
  scripts\engine\utility::flag_wait("armory_02_secure");
  scripts\engine\sp\objectives::objective_remove("secure_armory_02");
  scripts\engine\sp\objectives::objective_add("survive", "current", undefined, &"SAFEHOUSE_FINALE_LOC/DEFEND_HANGAR");
  scripts\engine\utility::flag_wait("apache_here");
  scripts\engine\sp\objectives::objective_remove("survive");
  scripts\engine\sp\objectives::objective_add("apache", "current", undefined, &"SAFEHOUSE_FINALE_LOC/APACHE_THREATS");
  var_10 = scripts\engine\sp\objectives::_objective_getindexforname("apache");
  level.tarmac_vindia_02.objindex = 0;
  level.tarmac_vindia_03.objindex = 1;
  objective_setlocation(var_10, level.tarmac_vindia_02.objindex, level.tarmac_vindia_02);
  objective_setlocation(var_10, level.tarmac_vindia_03.objindex, level.tarmac_vindia_03);
  scripts\engine\utility::array_thread([level.tarmac_vindia_02, level.tarmac_vindia_03], ::location_objective_remover, var_10);
  scripts\engine\utility::flag_wait("retreat");
  var_11 = scripts\engine\utility::getStruct("molotov_guy_struct", "targetname");
  var_12 = scripts\engine\utility::getStruct("mid_goal_spots", "targetname");
  level scripts\engine\utility::waittill_any_timeout(20, "killstreak_complete");
  scripts\engine\sp\objectives::objective_update("apache", "current", var_11.origin, &"SAFEHOUSE_FINALE_LOC/APACHE_THREATS");

  if(!scripts\engine\utility::flag("killstreak_complete")) {
    level scripts\engine\utility::waittill_any("killstreak_complete", "second_retreat");

    if(!scripts\engine\utility::flag("killstreak_complete")) {
      scripts\engine\utility::flag_wait_or_timeout("killstreak_complete", 30);
      scripts\engine\sp\objectives::objective_update("apache", "current", var_12.origin, &"SAFEHOUSE_FINALE_LOC/APACHE_THREATS");
    }
  }

  scripts\engine\utility::flag_wait("killstreak_complete");
  scripts\engine\sp\objectives::objective_remove("apache");
}

location_objective_remover(var_0) {
  level endon("killstreak_complete");
  var_1 = self.objindex;
  self waittill("death");
  objective_unsetlocation(var_0, var_1);
}

dialogue_safehouse_interior() {
  level.player endon("death");
  level.player waittill("first_droneControl");
  wait 3;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_safehouse_interior_planestart_80", 0, 1);
}

dialogue_fly() {
  level.player_dronemodel endon("death");
  level endon("fly_crash_missed");
  childthread dialoge_fly_off_course();

  while(dist_to_chopper_pos() > 25000)
    waitframe();

  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_fly_approach_10");

  while(dist_to_chopper_pos() > 10000)
    waitframe();

  scripts\engine\utility::flag_set("start_fly_countdown");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_fly_approach_30");
  level notify("kill_off_course");

  while(dist_to_chopper_pos() > 4500)
    waitframe();

  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_fly_approach_20");
}

dist_to_chopper_pos() {
  var_0 = scripts\engine\utility::getclosest(level.player_dronemodel.origin, level.choppers);
  return length2d(var_0.origin - level.player_dronemodel.origin);
}

dialoge_fly_off_course() {
  level endon("kill_off_course");
  var_0 = ["dx_vom_had_fly_offcourse_10", "dx_vom_had_fly_offcourse_20", "dx_vom_had_fly_offcourse_30"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_2 = 0.5;

  for(;;) {
    for(;;) {
      var_3 = [];

      foreach(var_5 in getEntArray("level_droneVehicle", "targetname"))
      var_3[var_3.size] = var_5.origin;

      if(var_3.size == 0) {} else {
        var_7 = averagepoint(var_3);
        var_8 = anglesToForward(level.player_dronemodel.angles);
        var_9 = var_7 - level.player_dronemodel.origin;
        var_8 = (var_8[0], var_8[1], 0);
        var_9 = (var_9[0], var_9[1], 0);
        var_10 = length(var_9);
        var_8 = var_8 / length(var_8);
        var_9 = var_9 / var_10;
        var_10 = clamp(var_10, 0, 2500);
        var_11 = scripts\engine\math::remap(var_10, 0, 2500, 90, 40);
        var_12 = vectordot(var_8, var_9);
        var_12 = clamp(var_12, 0, 1);
        var_13 = acos(var_12);

        if(isDefined(var_13) && var_13 > var_11) {
          break;
        }
      }

      waitframe();
    }

    level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw());
    var_2 = min(var_2 * 1.5, 6);
    wait(var_2);
  }
}

dialogue_rooftops() {
  var_0 = getEnt("hc_meeting_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("reached_hc_meeting", var_0, 0);
  wait 6;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_pre_charge_setup_00");
  wait 0.5;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_pre_charge_setup_30");
  var_1 = ["dx_vom_far_rooftop_moveup_r_30", "dx_vom_far_rooftop_moveup_r_40", "dx_vom_far_rooftop_moveup_r_50"];
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill_delayed(8, "reached_hc_meeting", var_1, 10);
  thread vo_armen_bg_convo();
  thread vo_farah_hold_here();
  wait 0.5;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter_with_gesture("iw8_vm_ges_radio_shoulder_sp", "dx_vom_alx_rooftop_street_140", 0.5, 0.1);
  level scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_lass_rooftop_street_150");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter_with_gesture("iw8_vm_ges_radio_shoulder_sp", "dx_vom_alx_rooftop_street_160", 0.5, 0.1);
  scripts\engine\utility::flag_set("wall_approach_vo_finished");
}

vo_farah_hold_here() {
  level endon("wall_approach_vo_finished");
  scripts\engine\utility::flag_wait("pep_talk_trigger");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_far_pre_charge_setup_80", 1);
}

vo_armen_bg_convo() {
  wait 2;
  level.armen scripts\engine\sp\utility::smart_dialogue("dx_vom_lf3_rooftop_street_40");
  level.armen scripts\engine\sp\utility::smart_dialogue("dx_vom_lf3_rooftop_street_50");
}

dialogue_pre_charge() {
  level.player endon("death");
  thread dialogue_pre_charge_branch();
  dialogue_pre_charge_pep();
  scripts\engine\utility::flag_wait_any("reached_pep_idle", "early_charge");

  if(!scripts\engine\utility::flag("early_charge"))
    level notify("pep_talk_complete");

  dialogue_pre_charge_fire_cannon();
}

dialogue_pre_charge_pep() {
  level endon("early_charge");
  level waittill("pep_talk_start");
  level endon("player_dropped_in");
  level.player endon("weapon_fired");
  wait 0.8;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_far_pre_charge_setup_120");
  wait 0.2;
  level.armen scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_lf3_rooftop_street_130");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_far_pre_charge_setup_140");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_pre_charge_setup_190");
  level.armen thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_lf3_pre_charge_setup_170");
  var_0 = [];

  foreach(var_2 in level.allies) {
    if(var_2 == level.farah || var_2 == level.hadir || var_2 == level.armen) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  var_0 = sortbydistance(var_0, level.player.origin);
  var_0[1] thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say("dx_vom_lf4_pre_charge_setup_180");
  wait 0.6;
}

dialogue_pre_charge_fire_cannon() {
  wait 0.35;

  if(scripts\engine\utility::flag("early_charge"))
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_pre_charge_setup_260", 1);
  else
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_pre_charge_prep_30", 1);

  scripts\engine\utility::flag_wait("bunker_busted");
  setmusicstate("");
  level.farah waittill("weapon_fired");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_tarmac_intro_40");
}

dialogue_pre_charge_branch() {}

dialogue_charge() {
  level.player endon("death");
}

dialogue_fob_bunkers() {
  level.player endon("death");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_bunkers_molotovuse_10");
  wait 3;
  level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_bunkers_assault_20");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_yas_bunkers_assault_30");
  wait 1;
  scripts\engine\utility::flag_wait_any("fob_center", "bunkers_push");
  level.farah thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_bunkers_assault_130");
  level.armen scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_lf3_bunkers_assault_140");
  wait 1;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_bunkers_assault_150");
  scripts\engine\utility::flag_set("finished_bunker_vo");
}

dialogue_fob_center() {
  level.player endon("death");
  level endon("armory_01_secure");
  wait 3;
  scripts\engine\utility::flag_wait("finished_bunker_vo");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_fob_center_helos_10");
  level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_fob_center_intro_20");
  level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_yas_fob_center_helos_30");
  scripts\engine\utility::flag_set("finished_fob_center_vo");
  scripts\engine\utility::flag_wait_or_timeout("no_fob_helos_left", 10);
  thread enemy_radio_vo();
  wait 1;
  thread vo_armory_01_approach();
  scripts\engine\utility::flag_waitopen("player_in_drone");
  wait 3;

  while(scripts\engine\utility::flag("player_in_drone")) {
    scripts\engine\utility::flag_waitopen("player_in_drone");
    scripts\engine\utility::flag_wait_or_timeout("fob_player_in_center_swarm", 5);
  }

  if(!scripts\engine\utility::flag("fob_player_in_center_swarm"))
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_01_locate_20");

  scripts\engine\utility::flag_wait("fob_rear_trucks");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_armory_01_locate_90");
  var_0 = (-40128, 34639, -600);
  var_1 = (-40128, 34885, -600);
  var_2 = (-40128, 35132, -600);
  thread wait_lookat_armory(var_0);
  thread wait_lookat_armory(var_1);
  thread wait_lookat_armory(var_2);
  thread wait_hadir_sees_armory(var_0);
  var_3 = level scripts\engine\utility::waittill_any_return("looked_at_armory", "hadir_sees_armory") == "hadir_sees_armory";

  if(var_3) {
    level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_armory_01_locate_140");
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_01_locate_150");
  } else {
    level.player thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_armory_01_locate_120");
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_01_locate_130");
  }
}

vo_armory_01_approach() {
  wait 2;
  say_on_closest_enemy("dx_vom_rcom_armory_01_interior_30");
  wait 1;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_01_locate_10");
  wait 2;
  say_on_closest_enemy("dx_vom_rcom_armory_01_interior_10");
  wait 4;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_armory_01_locate_11");
  wait 3;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_armory_01_locate_12");
  wait 3;
  say_on_closest_enemy("dx_vom_rcom_armory_01_interior_20");
  wait 8;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_armory_01_locate_13");
}

say_on_closest_enemy(var_0, var_1, var_2) {
  var_3 = getaiarray("axis");
  var_3 = scripts\engine\utility::array_removedead_or_dying(var_3);

  if(var_3.size == 0) {
    return;
  }
  var_4 = scripts\engine\utility::getclosest(level.player.origin, var_3);
  var_4 scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_0, var_1, var_2);
}

wait_lookat_armory(var_0) {
  level endon("hadir_sees_armory");
  level endon("looked_at_armory");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_lookat(var_0, 100);

  if(isDefined(level.saw_armory)) {
    level.saw_armory = undefined;
    level notify("looked_at_armory");
  } else
    level.saw_armory = 1;
}

wait_hadir_sees_armory(var_0) {
  level endon("hadir_sees_armory");
  level endon("looked_at_armory");

  while(!scripts\engine\trace::ray_trace_passed(level.hadir getEye(), var_0, [level.hadir], scripts\engine\trace::create_ainosight_contents()))
    waitframe();

  level notify("hadir_sees_armory");
}

enemy_radio_vo() {
  scripts\engine\utility::flag_wait_or_timeout("player_in_drone", 8);
  level waittill("ai_killed");
  wait 2;
  level.playing_radio_dialogue = 1;
  var_0 = [];
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_10");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_20");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_30");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_40");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_50");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_60");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_70");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_80");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_90");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_100");
}

dialogue_armory_01() {
  level.player endon("death");
  childthread dialgue_armory_01_enemies();
  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  wait 0.6;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_combat_cooldown(0.6, 3);
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_armory_01_interior_60");

  if(getaiarray("axis").size == 0)
    level.farah thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_01_interior_70");

  scripts\engine\utility::flag_set("armory_dialogue_complete");
}

dialgue_armory_01_enemies() {
  scripts\engine\utility::flag_wait("fob_exit");
  level.enemy_armory_guards[0] endon("death");
  level.enemy_armory_guards[1] endon("death");
  level.enemy_armory_guards[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_ru2_armory_01_interior_40");
  scripts\engine\utility::flag_wait("armory_01_trigger");
  level.enemy_armory_guards[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_ru1_armory_01_interior_50");
}

dialogue_armory_02() {
  level.player endon("death");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_tarmac_assault_210");
  scripts\engine\utility::flag_wait("armory_02_secure");
  wait 0.6;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::wait_combat_cooldown(0.4, 2);
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_armory_02_breach_170");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_02_breach_180");
  wait 25;
  var_0 = ["dx_vom_far_armory_02_breach_190", "dx_vom_far_armory_02_breach_200", "dx_vom_far_armory_02_breach_210"];
  level.farah thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill("hangar_defend_start", var_0, 12);
}

wait_guys_all_reach_node(var_0, var_1) {
  var_1 = squared(var_1);

  foreach(var_3 in [level.farah, level.hadir]) {
    while(distance2dsquared(var_3.origin, var_3.goalnode.origin) > var_1)
      waitframe();
  }
}

wait_guys_any_reach_node(var_0, var_1) {
  var_1 = squared(var_1);

  for(;;) {
    foreach(var_3 in [level.farah, level.hadir]) {
      if(distance2dsquared(var_3.origin, var_3.goalnode.origin) < var_1)
        return;
    }

    waitframe();
  }
}

dialogue_armory_boost() {
  dialogue_check_lock_and_nag_boost();
  level endon("player_in_armory_02");
  var_0 = ["dx_vom_had_armory_02_breach_111", "dx_vom_had_armory_02_breach_112", "dx_vom_had_armory_02_breach_113"];
  level.hadir_boost_nags = scripts\engine\sp\utility::create_deck(var_0);
  level waittill("boost_jump_nag");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say(level.hadir_boost_nags scripts\engine\sp\utility::deck_draw());

  for(;;) {
    level waittill("boost_jump_nag");
    level waittill("boost_jump_nag");
    level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say(level.hadir_boost_nags scripts\engine\sp\utility::deck_draw());
  }
}

dialogue_check_lock_and_nag_boost() {
  level.player endon("death");
  dialogue_nag_open_armory_02();
  level.hadir endon("trigger");
  thread dialogue_armory_hatch();
  wait 0.4;
  level.player thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_armory_02_breach_70", 1, 1);
  level.hadir waittill("goal");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_armory_02_breach_80");
  wait 8;
  var_0 = ["dx_vom_had_armory_02_breach_90", "dx_vom_had_armory_02_breach_100", "dx_vom_had_armory_02_breach_110"];
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill(undefined, var_0, 8);
}

dialogue_nag_open_armory_02() {
  scripts\engine\sp\utility::battlechatter_off();

  if(scripts\engine\utility::flag("hadir_go_to_hatch")) {
    return;
  }
  level endon("hadir_go_to_hatch");
  wait 3;
  wait_guys_all_reach_node([level.farah, level.hadir], 350);
  thread armory_02_guards_vo();
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_armory_02_breach_10");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_02_breach_20");
  wait 0.2;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_02_breach_30");
  wait 4;
  var_0 = [];
  var_0[var_0.size] = [level.farah, "dx_vom_far_armory_02_breach_40"];
  var_0[var_0.size] = [level.hadir, "dx_vom_had_armory_02_breach_62"];
  var_0[var_0.size] = [level.hadir, "dx_vom_had_armory_02_breach_61"];
  var_0[var_0.size] = [level.farah, "dx_vom_far_armory_02_breach_50"];
  var_0[var_0.size] = [level.hadir, "dx_vom_had_armory_02_breach_63"];
  var_0[var_0.size] = [level.farah, "dx_vom_far_armory_02_breach_60"];
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill(undefined, var_0, 6);
}

dialogue_armory_hatch() {
  level.player waittill("jumped_up");
  wait 5;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_armory_02_breach_120");

  if(scripts\engine\utility::flag("entered_armory_02")) {
    return;
  }
  level endon("entered_armory_02");

  for(;;) {
    nag_enter_armory();
    level.hadir_boost_nags scripts\engine\sp\utility::deck_shuffle();
    level.hadir_boost_nags scripts\engine\sp\utility::deck_draw_specific("dx_vom_had_armory_02_breach_111");
    level.hadir waittill("back_at_hatch");
  }
}

nag_enter_armory() {
  level endon("player_fell");
  var_0 = ["dx_vom_had_armory_02_breach_161", "dx_vom_had_armory_02_breach_162", "dx_vom_had_armory_02_breach_163"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  childthread watch_armory_clear();

  while(!scripts\engine\utility::flag("cleared_armory_02")) {
    var_2 = level scripts\engine\utility::waittill_any_in_array_or_timeout(["ai_killed", "cleared_armory_02"], 8);

    if(var_2 != "timeout") {
      continue;
    }
    level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill(["ai_killed", "cleared_armory_02"], var_1, 8);
  }

  wait 2;
  var_0 = ["dx_vom_had_armory_02_breach_150", "dx_vom_had_armory_02_breach_160", "dx_vom_had_armory_02_breach_140"];
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill("entered_armory_02", var_0, 8);
}

watch_armory_clear() {
  level.enemy_armory_guards = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::array_removedeaddyingorundefined(level.enemy_armory_guards);
  scripts\engine\sp\utility::waittill_dead(level.enemy_armory_guards);
  scripts\engine\utility::flag_set("cleared_armory_02");
}

dialogue_hangar_defend() {
  level.player endon("death");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_hangar_defend_10");
  scripts\engine\utility::flag_wait("power_kill");
  wait 0.85;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_tarmac_assault_220");
  wait 0.4;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_hangar_defend_81");
  scripts\engine\sp\utility::battlechatter_on();
  wait 10;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_hangar_defend_90");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_hangar_defend_100");
}

armory_01_nag() {
  level.player endon("death");
  level endon("armory_01_trigger");
  level endon("armory_01_secure");
  level endon("ally_armory_01_secure");
  scripts\engine\utility::flag_wait("fob_cleared");
  wait 8;
  var_0 = ["dx_vom_far_armory_01_locate_160", "dx_vom_far_armory_01_locate_170", "dx_vom_far_armory_01_locate_180"];
  level.farah childthread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill("armory_01_trigger", var_0, 10, 2, 35);

  for(;;) {
    level waittill("started_nag", var_1, var_2);
    var_3 = lookupsoundlength(var_2) / 1000;
    childthread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::focus_reminder("armory_01_trigger", var_3 + 20);
    wait(var_3 + 20);
  }
}

dialogue_containers_gate() {
  level.player endon("death");
  var_0 = getEnt("gate_truck_reverse_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("player_in_truck_path", var_0, 1);
  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\utility::flag_wait_all("fob_exit", "fob_cleared", "hadir_at_truck");
  scripts\engine\utility::flag_wait("armory_dialogue_complete");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_armory_01_interior_80");
  var_1 = ["dx_vom_far_fob_center_gotogate_10", "dx_vom_far_fob_center_gotogate_20", "dx_vom_far_fob_center_gotogate_30"];
  level.farah thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill_delayed(1, "farah_gate_lookat", var_1, 10);
  player_in_area_check(level.farah, 0.75);
  scripts\engine\utility::flag_set("farah_gate_lookat");
  level waittill("farah_gate_pull");
  wait 2;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_containers_trucksmash_40");
  wait 4;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_containers_trucksmash_50");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_containers_trucksmash_60");
  scripts\engine\sp\utility::autosave_by_name("at_gate");
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_containers_trucksmash_70");
  scripts\engine\utility::flag_wait("hadir_in_truck");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_containers_trucksmash_120");

  if(scripts\engine\utility::flag("player_in_truck_path"))
    wait 1;

  var_1 = ["dx_vom_had_containers_gate_90", "dx_vom_had_containers_gate_100", "dx_vom_had_containers_gate_110"];
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill_open("player_in_truck_path", var_1, 6);
  scripts\engine\utility::flag_set("hadir_ramming_dialogue_complete");
}

dialogue_containers_gate_smash() {
  thread gatesmash_laswell_convo();
  scripts\engine\utility::flag_wait("container_door_breached");
  scripts\engine\utility::flag_wait("chu_strafe_run_go");
  level.armen scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_lf3_containers_heliattack_10", 1);
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_containers_heliattack_20", 1);
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_containers_heliattack_30", 1);
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_containers_heliattack_60", 1);
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_containers_heliattack_50");
  wait 0.1;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::player_resumeallowdrones();
  wait 8;

  if(!scripts\engine\utility::flag("boss_chopper_dead"))
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_containers_heliattack_70");

  scripts\engine\utility::flag_wait("chu_rear");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_containers_combat_10");
  wait 2;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_containers_combat_40");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_containers_combat_50");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_containers_combat_60");
  scripts\engine\utility::flag_set("containers_vo_finished");
}

gatesmash_laswell_convo() {
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter_with_gesture("iw8_vm_ges_radio_shoulder_sp", "dx_vom_alx_containers_trucksmash_140", 0.5, 0.1);
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_lass_containers_trucksmash_150");
}

player_in_area_check(var_0, var_1, var_2, var_3) {
  var_4 = gettime();

  if(isDefined(var_2))
    var_2 = var_2 * 1000;

  var_3 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::default_if_undefined(var_3, 1200);
  var_1 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::default_if_undefined(var_1, 0.9848);
  var_5 = 600;

  for(;;) {
    if(isDefined(var_2) && gettime() > var_4 + var_2) {
      break;
    }

    var_6 = distance(level.player.origin, var_0.origin);
    var_7 = distance(level.player.origin, var_0.origin);
    var_8 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin + (0, 0, 50), var_1);

    if(var_0 != level.gate_truck) {
      var_9 = var_0 gettagorigin("tag_eye");

      if(sighttracepassed(level.player getEye(), var_9, 0, level.player) && var_8 && var_6 <= var_3) {
        break;
      }
    }

    if(var_7 < var_5) {
      break;
    } else if(var_8 && var_6 <= var_3) {
      break;
    }

    waitframe();
  }

  level notify("player_looking");
}

dialogue_tarmac() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("containers_vo_finished");
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::player_stopallowdrones();
  level.player notifyonplayercommandremove("player_droneControl", "+actionslot 1");
  scripts\engine\sp\utility::battlechatter_off("allies");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_containers_combat_70");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_yas_hangar_defend_30");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_hangar_defend_70");
  wait 1;
  level.player notifyonplayercommand("player_droneControl", "+actionslot 1");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_hangar_defend_71");
  scripts\engine\sp\utility::battlechatter_on("allies");
  wait 6;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_tarmac_assault_10");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_tarmac_assault_20");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_tarmac_assault_30");

  if(scripts\engine\utility::flag("hangar_entrance")) {
    return;
  }
  level endon("hangar_entrance");
  wait 3;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_tarmac_assault_40");
  wait 6;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_tarmac_assault_150");
  wait 1;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_tarmac_assault_151");
  wait 2;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_tarmac_assault_152");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_tarmac_assault_153");
}

dialogue_killstreak_waiting() {
  level.player endon("death");
  level endon("air_support_inbound");
  wait 22;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_radar_planes_50");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_killstreak_2ndwave_10");
  wait 0.5;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_far_killstreak_2ndwave_20");
  wait 3;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_had_hangar_defend_120");
  scripts\engine\utility::delaythread(3, scripts\engine\utility::flag_set, "air_support_dialogue_complete");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_intro_10");
  wait 6;
  var_0 = ["dx_vom_apap_killstreak_chopper_intro_60", "dx_vom_apap_killstreak_chopper_intro_70", "dx_vom_apap_killstreak_chopper_intro_80"];
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::nagtill("air_support_inbound", var_0, 12, 1.2);
}

dialogue_killstreak_chopper() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("air_support_inbound");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_killstreak_chopper_intro_20");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_killstreak_chopper_intro_30");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_intro_40");
  thread chopper_chatter();
  scripts\engine\utility::flag_wait("killstreak_complete");
  thread mus_chopper_done();
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_killstreak_chopper_clear_20");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_clear_30");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_alx_killstreak_chopper_clear_40");
}

mus_chopper_done() {
  wait 5.0;
  setmusicstate("mx_safehouse_finale_end");
}

chopper_chatter() {
  level endon("killstreak_complete");
  childthread init_apache_chatter();
  wait 10;
  thread take_out_armor_nags();
  scripts\engine\utility::flag_wait("rpg_guys_go");
  childthread rpg_chatter();
  wait 1;

  while(level.ks_vehicles.size > 0)
    waitframe();

  level.incomingapache scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_armor_10");
  scripts\engine\utility::flag_wait("retreat");
  wait 7;
  level.incomingapache thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_end_30");
  wait 1;
  scripts\engine\sp\utility::display_hint_forced("apache_leave");
  wait 7;
  level waittill("second_retreat");
}

init_apache_chatter() {
  childthread apache_fire_vo();
  childthread apache_missile_fire_vo();
  childthread apache_killconfirm_vo();
  childthread apache_reloading_vo();
  childthread notify_apache_ai_kill();

  foreach(var_1 in scripts\engine\sp\utility::getvehiclearray())
  var_1 childthread notify_on_killed_by_apache();
}

take_out_armor_nags() {
  var_0 = ["dx_vom_apap_killstreak_chopper_combat_280", "dx_vom_apap_killstreak_chopper_combat_290", "dx_vom_apap_killstreak_chopper_combat_300"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);

  while(level.ks_vehicles.size > 0) {
    level.incomingapache scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw());
    wait(randomfloatrange(8, 12));
  }
}

rpg_chatter() {
  wait 2;
  level.incomingapache thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_combat_170", 1, 1);
  level waittill("rpg_fired");
  wait 0.5;
  level.incomingapache thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc::say_as_chatter("dx_vom_apap_killstreak_chopper_combat_160", 1, 0.25);
}

dialogue_ending_scene() {
  level.player endon("death");
}

sfx_airbase_alarm() {
  var_0 = spawn("script_origin", (-40363, 32693, -285));
  var_0 playLoopSound("scn_safehouse_fin_airbase_siren");
  level waittill("sfx_airbase_siren_stop");
  var_0 scripts\engine\sp\utility::sound_fade_and_delete(6, 1);
}