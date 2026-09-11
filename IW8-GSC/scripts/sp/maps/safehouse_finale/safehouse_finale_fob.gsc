/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\safehouse_finale\safehouse_finale_fob.gsc
*********************************************************************/

function init_fob() {
  fob_flags();
  fob_precache();
  fob_fx();
}

function fob_precache() {
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
  var0 = getEntArray("offhand_box", "targetname");
  scripts\engine\utility::array_thread(var0, &ammo_box_lids);
  var1 = getEntArray("destroyed_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var1, &hide);
  var2 = getEntArray("ending_scene_vindia", "targetname");
  scripts\engine\utility::array_call(var2, &hide);
  var3 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy");
  scripts\engine\utility::array_call(var3, &hide);
  var4 = getEntArray("fuel_truck_corpse", "targetname");
  scripts\engine\utility::array_call(var4, &hide);
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
  level.special_autosavecondition = &scripts\sp\maps\safehouse_finale\safehouse_finale::autosave_block_in_drone;
  var5 = getEnt("truck_smash_clip", "targetname");
  var5 connectpaths();
  var5 hide();
}

function init_hangar_vehicles() {
  wait 0.3;
  var0 = getscriptablearray("hangar_trucks", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("body", "no_process");
  }
}

function init_tarmac_fire_lights() {
  var0 = getEntArray("tarmac_fires", "targetname");

  foreach(var2 in var0) {
    var2.original_intensity = var2 getlightintensity();
    var2 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("tarmac_fire_lights");

  foreach(var2 in var0) {
    var2 setlightintensity(var2.original_intensity);
  }

  scripts\engine\utility::flag_waitopen("tarmac_fire_lights");

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function init_chu_fire_lights() {
  var0 = getEntArray("chu_fire", "targetname");

  foreach(var2 in var0) {
    var2.origin_intensity = var2 getlightintensity();
    var2 setlightintensity(0);
  }

  level waittill("chu_fire_start");

  foreach(var2 in var0) {
    var2 setlightintensity(var2.origin_intensity);
  }
}

function chu_bad_places() {
  level.chu_bad_places_ids = [];
  var0 = getEntArray("chu_bad_places", "targetname");

  foreach(var2 in var0) {
    level.chu_bad_places_ids[level.chu_bad_places_ids.size] = createnavbadplacebyent(var2, "axis");
  }

  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");

  foreach(var5 in level.chu_bad_places_ids) {
    destroynavobstacle(var5);
  }
}

function chu_bad_places_armory() {
  waitframe();
  var0 = getEntArray("chu_bad_places_armory", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var1 = createnavbadplacebyent(var3, "axis", "allies");
  }

  scripts\engine\utility::flag_wait("armory_01_secure");

  foreach(var6 in var1) {
    destroynavobstacle(var6);
  }
}

function fob_fx() {}

function fob_flags() {
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
  var0 = getEnt("charge_drop_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("player_dropped_in", var0, 1);
}

function fob_post_load_inits() {
  thread show_destroyed_choppers();
}

function show_destroyed_choppers() {
  scripts\engine\utility::flag_wait_any("fob_center_entrance", "container_door_breached", "chu_exit");
  var0 = getEntArray("destroyed_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var0, &show);
  var1 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy");
  scripts\engine\utility::array_call(var1, &show);
}

function bink_start() {
  level.bink_start = 1;
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_roofs", [level.player]);
}

function bink_main() {
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
  var0 = getEnt("binoculars", "targetname");
  level.player playerlinkTo(level.player.rig, "tag_origin", 1, 0, 0, 0, 0, 0);
  level.farah scripts\common\ai::gun_remove();
  level.player.rig hide();
  var1 = scripts\engine\utility::getStruct("intro_anim_struct", "targetname");
  var1 thread scripts\common\anim::anim_single([level.farah, level.player.rig], "bink_scene_roof");
  waitframe();
  var0.origin = level.farah gettagorigin("tag_accessory_left");
  var0.angles = level.farah gettagangles("tag_accessory_left");
  var0 linkTo(level.farah, "tag_accessory_left");
  thread bink_town_allies();
  thread hc_workers_scene();
  thread ally_town_movement_bink();
  thread bink_hc();
  thread bink_choppers();
  thread bink_technical();
  scripts\engine\utility::flag_set_delayed("beta_00", 0);
  level thread scripts\engine\sp\utility::dof_enable(2, 800, 400, undefined);
  wait 9;
  level thread scripts\engine\sp\utility::dof_enable(2, 130, 1, undefined);
  level waittill("forever");
}

function bink_town_allies() {
  scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies();
  wait 0.5;
  var0 = 400;
  var1 = getaiarray("allies", "axis");

  foreach(var3 in var1) {
    var3.ignoreall = 1;

    if(distance(var3.origin, (-32391, 30264, -717)) < var0) {
      var3 delete();
    }
  }

  var1 = getEntArray("defenders", "script_noteworthy");

  foreach(var3 in var1) {
    var3 delete();
  }

  var1 = getaiarray("allies", "axis");
  var3 = sortbydistance(var1, (-32667, 30155, -716))[0];
  var3 delete();
}

function bink_technical() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("bink_technical_01");
  var0.maxhealth = 34000;
  var1 = getvehiclenode("bink_technical_start_01", "targetname");
  var2 = getEntArray("truck_lights", "targetname");
  waitframe();
  var3 = 3;

  foreach(var5 in var2) {
    if(scripts\engine\utility::is_equal(var5.script_noteworthy, "left")) {
      var5.origin = var0 gettagorigin("tag_light_front_left");
      var5.origin += anglesToForward(var5.angles) * var3;
      var5.angles = var0 gettagangles("tag_light_front_left");
      var5 linkTo(var0);
    }

    if(scripts\engine\utility::is_equal(var5.script_noteworthy, "right")) {
      var5.origin = var0 gettagorigin("tag_light_front_right");
      var5.origin += anglesToForward(var5.angles) * var3;
      var5.angles = var0 gettagangles("tag_light_front_right");
      var5 linkTo(var0);
    }
  }

  wait 4;
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 vehicle_setspeedimmediate(10, 5);

  while(var0.veh_speed) {
    wait 0.1;
  }

  level notify("technical_stopped");
}

function bink_hc() {
  var0 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var1 = spawnStruct();
  var2 = getspawner("bink_actor_hc", "targetname");
  var1.angles = var2.angles;
  var1.origin = var2.origin + (0, 0, 5);
  var3 = scripts\engine\sp\utility::spawn_targetname("bink_actor_hc", 1);
  var3 scripts\common\ai::gun_remove();
  var3.animname = "rebel";
  var4 = [var3, var0];
  var1 thread scripts\common\anim::anim_single(var4, "intro_scene");
  waitframe();
  var0 setanimtime(var0 scripts\engine\utility::getanim("intro_scene"), 0.25);
  var3 setanimtime(var3 scripts\engine\utility::getanim("intro_scene"), 0.25);
}

function bink_choppers() {
  var0 = scripts\common\vehicle::spawn_vehicles_from_targetname("bink_choppers");
  scripts\engine\utility::array_thread(var0, &bink_chopper_behavior);
}

function bink_chopper_behavior() {
  var0 = spawnStruct();
  var1 = self.origin + anglesToForward(self.angles) * 7500;
  var1 += (0, 0, -900);
  self vehicle_teleport(var1, self.angles);
  var0 = self.origin + anglesToForward(self.angles) * 20000;
  self setvehgoalpos(var0, 1);
}

function safehouse_interior_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon(1);
  var0 = getEntArray("destroyed_tarmac_models", "script_noteworthy");
  scripts\engine\utility::array_call(var0, &hide);
}

function safehouse_interior_main() {
  thread bink_save_hack();
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 0.05);
  var0 = scripts\sp\hud_util::create_client_overlay("black", 1);
  thread cinematic_bars_intro();
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting::lt_interior_main_start();
  level.player allowsprint(0);
  thread scripts\sp\maps\safehouse_finale\safehouse_finale::level_droneambientspawnmanager();
  level.player modifybasefov(55, 0.1);
  var1 = getEnt("player_tablet", "targetname");
  var1.origin += (0, 13, 0);
  thread player_movespeed();
  thread objective_manager();
  thread trigger_manager();
  thread hell_cannon_intro_scene();
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  thread dialogue_safehouse_interior();
  var2.support_equipment = 0;
  var3.support_equipment = 0;
  scripts\engine\sp\utility::set_start_location("start_safehouse", [level.player, var2, var3]);
  thread scene_intro();
  level.hadir.name = "";
  wait 0.3;
  var0 fadeovertime(0.1);
  var0.alpha = 0;
  wait 1;
  thread transient_loading();
  wait 3;
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
  scripts\engine\sp\utility::trigger_wait_targetname("hadir_stairs_trigger");
  level.player allowsprint(1);
  thread notetrack_watcher();
  var4 = scripts\engine\utility::spawn_tag_origin(var1.origin, var1.angles);
  var4 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 5), &"SAFEHOUSE_FINALE_LOC/CONTROL_PAD", undefined, 700, 100, undefined, undefined, undefined, undefined, "duration_short");
  var4 waittill("trigger");
  var4 delete();
  var1 delete();
  level notify("player_has_tablet");
  var5 = getEnt("rc_door", "targetname");
  var5.clip = var5 scripts\engine\utility::get_target_ent();
  var5.clip linkTo(var5);
  var6 = scripts\engine\utility::getStruct("rc_door_struct", "targetname");
  var5.origin = var6.origin + (-1, 2, 0);
  var5.angles = var6.angles;
  scripts\engine\utility::flag_set("player_has_tablet");
  thread scripts\engine\sp\utility::autosave_by_name("drone_control");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level.player playSound("scn_safehouse_pickup_remote");
  scripts\engine\utility::flag_wait("tablet_vo");
  level.player notifyonplayercommand("first_droneControl", "+actionslot 1");
  scripts\engine\sp\utility::display_hint_forced("drone_control", undefined, undefined, level.player, "first_droneControl");
  wait_fly_drone(level.player);
  fake_drone_activation();
  var2 scripts\common\ai::stop_magic_bullet_shield();
  var3 scripts\common\ai::stop_magic_bullet_shield();
  var2 delete();
  var3 delete();
  var7 = getaiarray("allies");
  scripts\engine\utility::array_delete(var7);
}

function bink_save_hack() {
  wait 10;
  scripts\engine\sp\utility::autosave_now_silent();
}

function transient_loading() {
  scripts\engine\sp\utility::transient_load("safehouse_finale_town_tr");

  while(!istransientloaded("safehouse_finale_town_tr")) {
    waitframe();
  }

  scripts\engine\sp\utility::transient_load("safehouse_finale_fob_tr");
}

function wait_fly_drone() {
  level.player endon("first_droneControl");
  wait 10;
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [level.farah, "dx_vom_far_safehouse_interior_planestart_60"]);
}

function cinematic_bars_intro() {
  hidecinematicletterboxing(0, 0);
  wait 8;
  thread scripts\sp\introscreen::introscreen(1);
  getrandomnodedestination(2, 0);
}

function safehouse_interior_catchup() {
  thread objective_manager();
}

function player_movespeed() {
  thread scripts\sp\player::player_movement_state("creep");
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.7);
  level waittill("hadir_on_stairs");
  thread scripts\sp\player::player_movement_state("default");
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 6);
}

function notetrack_watcher() {
  level waittill("tablet_vo");
  scripts\engine\utility::flag_set("tablet_vo");
}

function scene_intro() {
  waitframe();
  level.player.behind_hadir = 0;
  level.hadir.second_idle = 1;
  level.hadir dontinterpolate();
  var0 = scripts\engine\sp\utility::spawn_targetname("safehouse_hc_guy", 1);
  var0.animname = "rebel";
  var0 scripts\common\ai::gun_remove();
  var0.allowdeath = 1;
  var1 = getspawner("safehouse_hc_guy", "targetname");
  var1.count = 1;
  var2 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var3 = getEnt("hc_door", "targetname");
  var3.animname = "hc_door";
  var3 scripts\engine\sp\utility::assign_animtree();
  var4 = [var2];
  var5 = [level.hadir, var0, var2, var3];
  var6 = scripts\engine\utility::getStruct("intro_anim_struct", "targetname");
  level.player clearclienttriggeraudiozone(0.8);
  thread player_behind_hadir_watcher();
  thread intro_scene_player(var6);
  thread safehouse_interior_mix();
  thread early_tank_guy(var6);
  thread safehouse_outside_runners();
  thread intro_scene_mayhem();
  var6 thread scripts\common\anim::anim_single(var5, "intro_scene");
  level.hadir waittillmatch("single anim", "end");
  level notify("hadir_on_stairs");
  thread rooftop_actors(var6);

  if(!scripts\engine\utility::flag("intro_player_behind_hadir")) {
    hadir_stair_idle_nag(var6);
    var6 notify("stop_loop");
    thread hadir_landing_clip();
    var6 notify("stop_loop");
    var6 thread scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_to_roof");
    level.hadir waittillmatch("single anim", "end");
  } else {
    thread hadir_landing_clip();
    var6 thread scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_to_roof");
    level.hadir waittillmatch("single anim", "end");
  }

  var6 thread scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_roof");
  thread intro_actors_to_idle(level.hadir);
  level.hadir.name = "Hadir";
  thread hadir_table_clip();
  var0 waittillmatch("single anim", "end");
  var0 delete();
  var2 delete();
}

function hadir_landing_clip() {
  var0 = getEnt("hadir_landing_clip", "targetname");
  var0 delete();
}

function hadir_table_clip() {
  level waittill("tablet_vo");
  var0 = getEnt("hadir_table_clip", "targetname");
  var0 delete();
}

function rooftop_actors(var0) {
  var1 = scripts\engine\sp\utility::spawn_anim_model("tablet_1");
  var2 = scripts\engine\sp\utility::spawn_anim_model("tablet_2");
  var3 = scripts\engine\sp\utility::spawn_anim_model("tablet_3");
  var4 = scripts\engine\sp\utility::spawn_anim_model("rc_plane");
  playFXOnTag(level._effect["vfx_safehouse_finale_drone_wingtip_red_lit"], var4, "tag_origin");
  var1.second_idle = 1;
  var2.second_idle = 1;
  level.farah.second_idle = 1;
  level.hadir.tablet = var1;
  level.safehouse_yasim = scripts\engine\sp\utility::spawn_targetname("safehouse_yasim", 1);
  level.safehouse_yasim.animname = "yasim";
  level.safehouse_yasim.name = "Lina";
  level.safehouse_yasim scripts\common\ai::gun_remove();
  var0 thread scripts\common\anim::anim_first_frame_solo(level.safehouse_yasim, "intro_scene_roof");
  level waittill("start_scene_b");
  var5 = [level.farah, level.safehouse_yasim, var1, var2, var3];
  var0 thread scripts\common\anim::anim_single_solo(var4, "intro_scene_roof");
  var0 thread scripts\common\anim::anim_single(var5, "intro_scene_roof");
  scripts\engine\utility::array_thread(var5, &intro_actors_to_idle, var0, var1);
  level.player waittill("first_droneControl");
  wait 2;
  var6 = [var1, var2, var3, var4];
  scripts\engine\utility::array_delete(var6);
}

#using_animtree("generic_human");

function intro_scene_mayhem() {
  thread scene_mayhem(level.hadir, %shf_010_infil_scenea_hadir_face, "intro_mayhem_hadir_face");
}

function safehouse_outside_runners() {
  wait 14;
  var0 = 0;

  while(var0 < 4) {
    var1 = spawn_check_func(undefined, "safehouse_outside_runners", 1);
    var0++;
    scripts\engine\utility::array_thread(var1, &safehouse_outside_runners_behavior);
    wait randomintrange(2, 3);
  }
}

function safehouse_outside_runners_behavior() {
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\utility::set_movement_speed(120);
  self waittill("goal");
  self delete();
}

function early_tank_guy(var0) {
  waitframe();
  var1 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var2 = scripts\engine\sp\utility::spawn_targetname("safehouse_hc_guy", 1);
  var2.animname = "rebel";
  var2 scripts\common\ai::gun_remove();
  var2.allowdeath = 1;
  var3 = spawnStruct();
  var3.origin = var0.origin + (10, 0, 0);
  var3.angles = var0.angles;
  var3 thread scripts\common\anim::anim_single_solo(var1, "intro_scene");
  var3 thread scripts\common\anim::anim_single_solo(var2, "intro_scene_02");
  waitframe();
  var1 setanimtime(var1 scripts\engine\utility::getanim("intro_scene"), 0.5);
  var2 setanimtime(var2 scripts\engine\utility::getanim("intro_scene_02"), 0.5);
  wait 8;
  var1 setanimrate(var1 scripts\engine\utility::getanim("intro_scene"), 2);
  var2 setanimrate(var2 scripts\engine\utility::getanim("intro_scene_02"), 2);
  var3.origin = var0.origin + (20, 0, 0);
  var3.origin = var0.origin;
  wait 4;
  var1 delete();
  var2 delete();
}

function intro_actors_to_idle(var0, var1) {
  self endon("death");
  self endon("entitydeleted");
  self waittillmatch("single anim", "end");
  var2 = undefined;

  if(self == level.hadir) {
    var2 = spawnStruct();
    var2.origin = var0.origin;
    var2.angles = var0.angles;
    level.hadir thread scripts\common\utility::lookatentity(level.player);
    scripts\engine\utility::flag_set("intro_dialogue_complete");
    hadir_tablet_idle_nag(var0, var2);
    var2 notify("stop_loop");
    var0 notify("stop_loop");
    var0 scripts\common\anim::anim_single([level.hadir, level.hadir.tablet], "intro_scene_roof_exit");
    self waittillmatch("single anim", "end");
    var0 thread scripts\common\anim::anim_loop([level.hadir, level.hadir.tablet], "intro_scene_roof_exit_idle", "stop_loop");
    return;
  }

  if(!scripts\engine\utility::is_equal(self, level.hadir.tablet) && self != level.hadir) {
    if(self == level.safehouse_yasim) {
      var0 thread scripts\common\anim::anim_loop_solo(self, "intro_scene_roof_idle", "yasim_stop");
    } else {
      var0 thread scripts\common\anim::anim_loop_solo(self, "intro_scene_roof_idle", "stop_loop");
    }
  }

  scripts\engine\utility::flag_wait("player_has_tablet");

  if(isDefined(level.hadir)) {
    level.hadir thread scripts\common\utility::lookatentity();
  }

  var0 notify("stop_loop");

  if(istrue(self.second_idle)) {
    var0 notify("stop_loop");
    var0 scripts\common\anim::anim_single_solo(self, "intro_scene_roof_exit");
    self waittillmatch("single anim", "end");
    var0 thread scripts\common\anim::anim_loop_solo(self, "intro_scene_roof_exit_idle", "stop_loop");
    return;
  }
}

function player_behind_hadir_watcher() {
  scripts\engine\sp\utility::trigger_wait_targetname("hadir_stairs_trigger");
  scripts\engine\utility::flag_set("intro_player_behind_hadir");
}

function safehouse_interior_mix() {
  level.player setsoundsubmix("iw8_safehouse_interior");
  scripts\engine\sp\utility::trigger_wait_targetname("hadir_stairs_trigger");
  level.player clearsoundsubmix("iw8_safehouse_interior", 8);
}

function hadir_stair_idle_nag(var0) {
  var0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_to_idle");
  level endon("intro_player_behind_hadir");

  for(;;) {
    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");
    wait 5;

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var0 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planeintro_20");
    var0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_nag1");
    var0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    wait 10;

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var0 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planeintro_30");
    var0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_nag2");
    var0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    wait 10;

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var0 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planeintro_40");
    var0 scripts\common\anim::anim_single_solo(level.hadir, "intro_scene_idle_nag2");

    if(scripts\engine\utility::flag("intro_player_behind_hadir")) {
      break;
    }

    var0 thread scripts\common\anim::anim_loop_solo(level.hadir, "intro_scene_idle", "stop_loop");
    wait 10;
    var0 notify("stop_loop");
  }
}

function hadir_tablet_idle_nag(var0, var1) {
  level endon("player_has_tablet");

  if(scripts\engine\utility::flag("player_has_tablet")) {
    return;
  }

  var2 = [level.hadir, level.hadir.tablet];

  for(;;) {
    var1 thread scripts\common\anim::anim_loop(var2, "intro_scene_roof_idle", "stop_loop");
    wait 5;
    var1 notify("stop_loop");

    if(scripts\engine\utility::flag("player_has_tablet")) {
      return;
    }

    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planestart_20");
    var1 scripts\common\anim::anim_single(var2, "intro_scene_roof_idle_nag1");
    var1 thread scripts\common\anim::anim_loop(var2, "intro_scene_roof_idle", "stop_loop");
    wait 10;
    var1 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planestart_30");
    var1 scripts\common\anim::anim_single(var2, "intro_scene_roof_idle_nag1");
    var1 thread scripts\common\anim::anim_loop(var2, "intro_scene_roof_idle", "stop_loop");
    wait 10;
    var1 notify("stop_loop");
    level.hadir thread scripts\engine\sp\utility::smart_dialogue("dx_vom_had_safehouse_interior_planestart_40");
    var1 scripts\common\anim::anim_single(var2, "intro_scene_roof_idle_nag1");
    var1 thread scripts\common\anim::anim_loop(var2, "intro_scene_roof_idle", "stop_loop");
    wait 10;
    var1 notify("stop_loop");
  }
}

function intro_scene_player(var0) {
  level.molotov = scripts\engine\sp\utility::spawn_anim_model("molotov");
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  var0 scripts\common\anim::anim_first_frame_solo(level.player.rig, "intro_scene");
  var1 = level.player.rig scripts\engine\utility::getanim("intro_scene");
  var2 = getstartorigin(var0.origin, var0.angles, var1);
  var3 = getstartangles(var0.origin, var0.angles, var1);
  level.player setOrigin(var2);
  level.player setplayerangles(var3);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::put_player_into_rig(level.player.rig, 0.05, 0, 0, 0, 0);
  var0 scripts\common\anim::anim_single([level.player.rig, level.molotov], "intro_scene");
  level notify("enable_guns_intro");
  level.player enableweapons();
  wait 0.5;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.molotov delete();
  level.player.rig delete();
}

function scene_intro_return() {
  waitframe();
  var0 = scripts\engine\utility::getStruct("intro_anim_struct", "targetname");
  var1 = [level.farah, level.hadir];
  level.farah.allowdeath = 1;
  level.hadir.allowdeath = 1;
  var0 thread scripts\common\anim::anim_single(var1, "intro_scene_roof_jump");
  waitframe();
  level.farah setanimtime(level.farah scripts\engine\utility::getanim("intro_scene_roof_jump"), 0.4);
  level.hadir setanimtime(level.hadir scripts\engine\utility::getanim("intro_scene_roof_jump"), 0.4);
  var0 notify("stop_loop");
}

function trigger_manager() {
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

function fake_drone_activation() {
  level.player.playeroriginalweapon = level.player.currentweapon;
  level.player giveweapon("ks_remote_device");
  level.player switchtoweapon("ks_remote_device");

  if(isDefined(level.player.currentweapon)) {
    if(isDefined(level.player.currentweapon.classname)) {
      if(level.player.currentweapon.classname == "mg") {
        wait 0.5;
        level.player playSound("scn_safehouse_use_remote");
      } else {
        level.player playSound("scn_safehouse_use_remote");
      }
    }
  }

  wait 1.2;
  var0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var0 fadeovertime(0.25);
  var0.alpha = 1;
  thread overlay_clear();
  wait 0.25;
}

function overlay_clear() {
  wait 1.5;
  self fadeovertime(0.25);
  self.alpha = 0;
  scripts\engine\utility::delaycall(1.5, &destroy);
}

function rooftops_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
  level.player.playeroriginalweapon = level.player.currentweapon;
  level.player giveweapon("ks_remote_device");
}

function rooftops_main() {
  var0 = getscriptablearray("tarmac_choppers", "targetname");

  foreach(var2 in var0) {
    var2 hide();
    var2.origin += (0, 0, -1000);
  }

  level.player setsoundsubmix("sp_npc_vehicles_down", 1, 1);
  setmusicstate("mx_safehouse_finale_attack");
  scripts\engine\utility::delaythread(1, &sfx_airbase_alarm);
  thread hide_tarmac_trucks();
  var4 = getEnt("roof_player_clip", "targetname");
  var4 delete();
  thread oil_fires_init();
  thread dialogue_rooftops();
  thread dialogue_pre_charge();
  thread scene_intro_return();
  var5 = scripts\sp\maps\safehouse_finale\safehouse_finale::board_getallydronestartnodes();

  foreach(var7 in var5) {
    var8 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::level_dronespawnVehicle(var7.origin, var7.angles);
    thread scripts\sp\maps\safehouse_finale\safehouse_finale::fly_allydronepathlogic(var8, var7, 0);
  }

  scripts\engine\utility::exploder("tarmac_exploder");
  var10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var10, &hide);
  thread explode_tarmac_scriptables();
  var11 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var12 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var13 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  level.player takeweapon("ks_remote_device");
  level.player switchtoweapon(level.player.playeroriginalweapon);
  var11 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var12 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var11.allowdeath = 1;
  var12.allowdeath = 1;
  var12 scripts\common\utility::demeanor_override("combat");
  var11 scripts\common\utility::demeanor_override("combat");

  if(istrue(level.fly_player_hit_helo)) {
    level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_fly_success_10");
  }

  thread scripts\sp\analytics::analytics_kleenex_update("Rooftops to Bunkers");
  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  var14 = scripts\sp\hud_util::create_client_overlay("black", 1, level.player);
  var15 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::ai_getaliveaiarray("axis");
  scripts\engine\utility::array_delete(var15);

  if(isDefined(level.enemy_vehicles)) {
    scripts\engine\utility::array_delete(level.enemy_vehicles);
  }

  scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies();
  thread town_technical_01();
  thread hc_workers_scene();
  thread ally_town_movement();
  var11 scripts\common\utility::demeanor_override("casual_gun");
  var16 = charge_setalliestoredshirts();
  level.allies = getaiarray("allies");
  scripts\engine\sp\utility::autosave_by_name("town");
  scripts\engine\sp\utility::set_start_location("start_roofs", [level.player, var11, var12]);
  level notify("rooftops_start");
  var14 fadeovertime(0.45);
  var14.alpha = 0;
  wait 0.3;
  scripts\engine\utility::exploder("tarmac_exploder_01");
  scripts\engine\sp\utility::trigger_wait_targetname("hc_meeting_trigger");
  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  scripts\engine\sp\utility::trigger_wait_targetname("charge_enter_trigger");
  scripts\engine\utility::flag_set("pep_talk_trigger");
  scripts\engine\sp\utility::autosave_by_name("pep_talk");
  scripts\engine\utility::stop_exploder("tarmac_exploder");
  scripts\engine\utility::stop_exploder("tarmac_exploder_01");
  var17 = getEnt("town_wall_trigger", "targetname");
}

function hide_tarmac_trucks() {
  wait 0.2;
  var0 = [];
  var1 = getscriptablearray();

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.model, "veh8_mil_lnd_tromeo_static_black_scr") || scripts\engine\utility::is_equal(var3.model, "veh8_mil_lnd_umike_pickup_static_scr") || scripts\engine\utility::is_equal(var3.model, "veh8_mil_air_lbravo_static_east_scr") || scripts\engine\utility::is_equal(var3.model, "veh8_mil_lnd_mkilo23_no_tail_static_scr")) {
      if(scripts\engine\utility::is_equal(var3.model, "veh8_mil_lnd_mkilo23_no_tail_static_scr") && var3.origin[0] < -42000) {
        continue;
      }

      var3.og_origin = var3.origin;
      var0 = var3;
      var3.origin += (0, 0, -3600);
    }
  }

  scripts\engine\utility::flag_wait("air_support_inbound");

  foreach(var3 in var0) {
    if(isDefined(var3)) {
      var3.origin = var3.og_origin;
    }
  }
}

function hide_tarmac_scriptables_until_apache() {
  wait 0.2;
  var0 = [];
  var1 = getscriptablearray("tarmac_hidden_scriptables", "targetname");

  foreach(var3 in var1) {
    var3.og_origin = var3.origin;
    var0 = var3;
    var3.origin += (0, 0, -3600);
  }

  scripts\engine\utility::flag_wait("air_support_inbound");

  foreach(var3 in var0) {
    if(isDefined(var3)) {
      var3.origin = var3.og_origin;
    }
  }

  var7 = getEntArray("tarmac_hidden_models", "targetname");
  scripts\engine\utility::array_delete(var7);
}

function rooftops_catchup() {
  if(istrue(level.bink_start)) {
    return;
  }

  thread oil_fires_init();
  thread hide_old_tarmac_scriptables();
  thread hide_tarmac_trucks();
  scripts\engine\utility::flag_set("wall_approach_vo_finished");
}

function hide_old_tarmac_scriptables() {
  wait 0.3;
  var0 = getscriptablearray("tarmac_choppers", "targetname");

  foreach(var2 in var0) {
    var2 hide();
    var2.origin += (0, 0, -1000);
  }
}

function hc_workers_scene() {
  level.hc_worker_01 = undefined;
  var0 = getEntArray("hc_badplace", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    var1 = createnavbadplacebyent(var3, "allies");
  }

  thread bad_place_remover(var1[1]);
  var5 = getspawnerarray("hc_Spawner");
  var6 = undefined;
  var7 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var8 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var8 hide();
  var9 = [];

  foreach(var11 in var5) {
    if(scripts\engine\utility::is_equal(var11.script_noteworthy, "firer")) {
      var12 = scripts\engine\sp\utility::bodyonlyspawn(var11);
      thread body_damage_watcher();
      var12.animname = var12.script_noteworthy;
      var12.allowdeath = 1;
      var9 = var12;
      var13 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
      continue;
    }

    if(scripts\engine\utility::is_equal(var11.script_noteworthy, "loader")) {
      var12 = scripts\engine\sp\utility::bodyonlyspawn(var11);
      thread body_damage_watcher();
      var6 = var12;
      level.hc_worker_01 = var6;
      var12.animname = var12.script_noteworthy;
      var12.allowdeath = 1;
      var9 = var12;
      var12 scripts\common\ai::gun_remove();
      continue;
    }

    var12 = var11 scripts\engine\sp\utility::spawn_ai(1);
  }

  var15 = scripts\engine\utility::getStruct("hc_scene_struct", "targetname");
  var15 thread scripts\common\anim::anim_loop(var9, "cannon_idle", "stop_loop");
  var15 thread scripts\common\anim::anim_first_frame_solo(var7, "cannon_load");
  wait 1;
  var15 notify("stop_loop");
  var15 thread scripts\common\anim::anim_single_solo(var7, "cannon_load");
  var15 thread scripts\common\anim::anim_single(var9, "cannon_load");
  var6 waittillmatch("single anim", "end");
  var15 thread scripts\common\anim::anim_loop(var9, "cannon_idle", "stop_loop");
  scripts\engine\utility::flag_wait("pep_talk_trigger");
  var8 show();
  var15 thread scripts\common\anim::anim_first_frame_solo(var8, "cannon_load");
  level waittill("hell_cannon_fire_move_tank");
  var7 delete();
  var15 notify("stop_loop");
  var15 thread scripts\common\anim::anim_single_solo(var8, "cannon_load");
  var15 thread scripts\common\anim::anim_single(var9, "cannon_load");
  waitframe();
  var16 = scripts\engine\utility::array_add(var9, var8);

  foreach(var3 in var16) {
    var3 setanimrate(var3 scripts\engine\utility::getanim("cannon_load"), 1.3);
  }

  level waittill("hell_cannon_fire_move_tank");
  var8 delete();
  var6 waittillmatch("single anim", "end");
  var15 thread scripts\common\anim::anim_loop(var9, "cannon_idle", "stop_loop");
  scripts\engine\utility::flag_wait("bunkers_charged");
  scripts\engine\utility::array_delete(var9);
}

function body_damage_watcher() {
  self endon("entitydeleted");
  self endon("death");
  thread friendly_fire_grenade_think();
  scripts\engine\utility::waittill_any("damage", "bullethit");
  scripts\sp\friendlyfire::missionfail();
  self startragdoll();
}

function friendly_fire_grenade_think() {
  self endon("entitydeleted");
  self endon("death");

  for(;;) {
    level.player waittill("grenade_fire", var0, var1);

    if(var1.basename == "molotov") {
      var0 waittill("missile_stuck", var2, var3, var4, var5, var6, var7);

      if(distance2dsquared(var6, self.origin) < squared(200)) {
        self notify("damage");
      }
    }

    waitframe();
  }
}

function bad_place_remover(var0) {
  level waittill("technical_stopped");
  destroynavobstacle(var0);
}

function hell_cannon_intro_scene() {
  var0 = scripts\engine\utility::getStruct("hc_scene_struct", "targetname");
  var1 = scripts\engine\sp\utility::array_spawn_targetname("hc_Spawner", 1);
  var2 = [];

  foreach(var4 in var1) {
    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "firer")) {
      var4.animname = var4.script_noteworthy;
      var2 = var4;
    }

    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "loader")) {
      var4.animname = var4.script_noteworthy;
      var2 = var4;
      var4 scripts\common\ai::gun_remove();
    }
  }

  var0 = scripts\engine\utility::getStruct("hc_scene_struct", "targetname");
  var0 thread scripts\common\anim::anim_loop(var2, "cannon_idle", "stop_loop");
  var6 = scripts\engine\sp\utility::spawn_anim_model("propane_tank");
  var0 thread scripts\common\anim::anim_first_frame_solo(var6, "cannon_load");
  level.player waittill("first_droneControl");
  scripts\engine\utility::array_delete(var1);
  var6 delete();
}

function ally_town_movement_bink() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  level.allies = getaiarray("allies");
  thread scripts\engine\utility::flag_set_delayed("alpha_00", 5);
  scripts\engine\utility::flag_set_delayed("delta_00", 2);
  scripts\engine\utility::flag_set_delayed("delta_01", 2);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  level.allies = getaiarray("allies");

  foreach(var3 in level.allies) {
    if(scripts\engine\utility::is_equal(var3.targetname, "technical_dudes_01")) {
      continue;
    }

    if(isalive(var3) && isDefined(var3)) {
      if(var3 == var0 || var3 == var1) {
        continue;
      }

      var3 scripts\engine\utility::set_movement_speed(200);
      var3 scripts\engine\sp\utility::set_goal_radius(800);
      wait 0.2;
    }
  }
}

function ally_town_movement() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  level.allies = getaiarray("allies");
  thread scripts\engine\utility::flag_set_delayed("alpha_00", 0.1);
  scripts\engine\utility::flag_set("delta_00");
  scripts\engine\utility::flag_set("delta_01");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  level.allies = getaiarray("allies");

  foreach(var3 in level.allies) {
    if(scripts\engine\utility::is_equal(var3.targetname, "technical_dudes_01")) {
      continue;
    }

    if(isalive(var3) && isDefined(var3)) {
      if(var3 == var0 || var3 == var1) {
        continue;
      }

      var3 scripts\engine\utility::set_movement_speed(160);
      wait 0.1;
    }
  }

  wait 1;
  var0 scripts\common\utility::demeanor_override("combat");
  var0 scripts\engine\sp\utility::set_force_color("p");
  var0 scripts\engine\utility::set_movement_speed(170);
  var1 scripts\engine\sp\utility::set_force_color("g");
  var1 scripts\engine\utility::set_movement_speed(170);
  scripts\engine\sp\utility::trigger_wait_targetname("hc_meeting_trigger");
  var0 scripts\engine\utility::set_movement_speed(160);
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

  foreach(var3 in level.allies) {
    if(isalive(var3) && isDefined(var3)) {
      var3 scripts\engine\utility::set_movement_speed(170);
      wait 0.2;
    }
  }
}

function scene_pep_talk(var0) {
  thread pep_talk_breakout();
  wait 0.5;
  level endon("early_charge");
  level.farah scripts\engine\sp\utility::clear_force_color();
  level.farah clearpath();
  level.peptalk_counter = 0;
  level.allies = getaiarray("allies");
  level.wall_actors = [level.armen];

  foreach(var2 in level.allies) {
    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "actors")) {
      level.wall_actors[level.wall_actors.size] = var2;
    }
  }

  foreach(var2 in level.wall_actors) {
    var2 clearpath();
    var2 scripts\engine\sp\utility::set_goal_radius(32);
    var2 scripts\engine\sp\utility::clear_force_color();
    var2.animname = "rebel_" + var5 + 1;
  }

  var6 = getnode("precharge_farah_path", "targetname");
  level.farah scripts\engine\sp\utility::set_goal_radius(32);
  level.farah setgoalpos(var6.origin);
  scripts\engine\utility::array_thread(level.wall_actors, &pep_talk_reach_and_idle);

  while(level.peptalk_counter < 4) {
    waitframe();
  }

  scripts\engine\utility::flag_wait("wall_approach_vo_finished");
  var7 = ["dx_vom_far_rooftop_moveup_r_30", "dx_vom_far_rooftop_moveup_r_40", "dx_vom_far_rooftop_moveup_r_50"];
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill_delayed(8, "pep_talk_trigger", var7);
  var8 = scripts\engine\utility::getStruct("pep_talk_struct", "targetname");
  level notify("pep_talk_start");
  var8 scripts\sp\anim::anim_reach_solo(level.farah, "peptalk_intro");
  scripts\engine\utility::flag_set("farah_pep_talking");
  var8 scripts\common\anim::anim_single_solo(level.farah, "peptalk_intro");
  scripts\engine\utility::flag_set("reached_pep_idle");
  var8 thread scripts\common\anim::anim_loop_solo(level.farah, "peptalk_idle", "stop_loop");
  level waittill("pep_talk_complete");
  var8 scripts\common\anim::anim_single_solo(level.farah, "peptalk_exit");
}

function pep_talk_breakout() {
  level endon("pep_talk_complete");
  scripts\engine\utility::flag_wait("early_charge");
  level.farah stopanimScripted();
  level.farah clearpath();
  level.farah setgoalpos(level.farah.origin);
}

function pep_talk_reach_and_idle() {
  var0 = scripts\engine\utility::getStruct("pep_talk_struct", "targetname");
  thread anim_reach_failsafe_go(15, var0, "peptalk_intro");
  thread ally_pep_talk_breakout();
  var0 scripts\sp\anim::anim_reach_solo(self, "peptalk_intro");

  if(scripts\engine\utility::flag("early_charge")) {
    return;
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, "peptalk_idle", "stop_loop");
  level endon("early_charge");
  level.peptalk_counter++;
  level waittill("pep_talk_start");
  var0 notify("stop_loop");
  waitframe();
  var0 scripts\common\anim::anim_single_solo(self, "peptalk_intro");
  var0 thread scripts\common\anim::anim_loop_solo(self, "peptalk_idle", "stop_loop");
  level scripts\engine\utility::waittill_any("pep_talk_complete", "early_charge");
  var0 notify("stop_loop");
  var0 scripts\common\anim::anim_single_solo(self, "peptalk_exit");
}

function anim_reach_failsafe_go(var0, var1, var2) {
  self endon("anim_reached");
  self endon("death");
  wait var0;
  var3 = scripts\engine\utility::getanim(var2);
  var4 = getstartorigin(var1.origin, var1.angles, var3);
  var5 = getstartangles(var1.angles, var1.angles, var3);
  self forceteleport(var4, var5);
}

function ally_pep_talk_breakout() {
  level endon("pep_talk_complete");
  scripts\engine\utility::flag_wait("early_charge");
  self stopanimScripted();
  self clearpath();
  self setgoalpos(self.origin);
}

function pre_charge_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("start_river", [level.player, var0, var1]);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies();
  scripts\engine\utility::array_thread(var3, &ally_start_at_end);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_wall_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("farah_river_mounds_color_trigger");
  var4 = charge_setalliestoredshirts();
  var5 = scripts\engine\sp\utility::array_spawn_targetname("technical_dudes_01");
  level notify("technical_stopped");
  level.allies = getaiarray("allies");
  scripts\engine\utility::array_thread(var5, &jump_technical_dudes);
  var0 scripts\engine\utility::set_movement_speed(150);
  var1 scripts\engine\sp\utility::clear_force_color();
  var1 scripts\engine\sp\utility::set_force_color("g");
  thread sfx_airbase_alarm();
  thread scene_pep_talk(1);
  thread dialogue_pre_charge();
  scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::activate_trigger_with_targetname, "charge_enter_trigger");
  scripts\engine\utility::flag_set("pep_talk_trigger");
}

function pre_charge_main() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  thread river_enter_watcher();
  thread player_early_shot_watcher();
  thread pre_charge_wall_guys();
  var2 = scripts\engine\sp\utility::array_spawn_targetname("pre_charge_enemySpawner", 1);

  for(var3 = 0; var3 < 2; var3++) {
    thread pre_charge_wall_anims(var2[var3]);
  }

  var4 = scripts\engine\sp\utility::spawn_targetname("tower_guy_charge");
  var4.dropweapon = 0;
  var4 allowedstances("stand");
  var2 = var4;
  scripts\engine\utility::array_thread(var2, &charge_enemy_behavior);
  level scripts\engine\utility::waittill_any("pep_talk_complete", "early_charge");
  level notify("farah_HC_command");
  wait 2;
  thread scripts\engine\utility::flag_set_delayed("bunker_busted", 2.5);
  thread hellcannon_first_strike(var4);
}

function pre_charge_wall_anims(var0) {
  level endon("early_charge");
  self endon("death");
  self.animname = "enemy_01";
  var1 = "lookaround_05";
  self.allowdeath = 1;

  if(var0 != 0) {
    var1 = "lookaround_04";
  }

  scripts\common\anim::anim_single_solo(self, var1);
  scripts\common\anim::anim_single_solo(self, var1);
}

function trailer_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("start_river", [level.player, var0, var1]);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies();
  scripts\engine\utility::array_thread(var3, &ally_start_at_end);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_wall_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("farah_river_mounds_color_trigger");
  var4 = charge_setalliestoredshirts();
  var5 = scripts\engine\sp\utility::array_spawn_targetname("technical_dudes_01");
  level notify("technical_stopped");
  level.allies = getaiarray("allies");
  scripts\engine\utility::array_thread(var5, &jump_technical_dudes);
  var0 scripts\engine\utility::set_movement_speed(150);
  var1 scripts\engine\sp\utility::clear_force_color();
  var1 scripts\engine\sp\utility::set_force_color("g");
  thread dialogue_pre_charge();
  scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::activate_trigger_with_targetname, "charge_enter_trigger");
  scripts\engine\utility::flag_set("pep_talk_trigger");
}

function jump_technical_dudes() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  self forceteleport(var0.origin, var0.angles);
  self setgoalpos(self.origin);
  self clearpath();
  scripts\engine\sp\utility::clear_force_color();
  scripts\engine\sp\utility::set_force_color("r");
}

function ally_start_at_end() {
  if(scripts\engine\utility::is_equal(self.script_noteworthy, "actors") || scripts\engine\utility::is_equal(self.script_noteworthy, "armen") || scripts\engine\utility::is_equal(self.script_noteworthy, "farah")) {
    var0 = (-32811, 30890, -711.149);
    self forceteleport(var0, (0, 180, 0));
    self setgoalpos(self.origin);
    return;
  }

  var1 = scripts\engine\utility::get_target_ent();
  var2 = var1 scripts\engine\sp\utility::get_last_ent_in_chain("pathnode");
  scripts\engine\sp\utility::teleport_ai(var2);
}

function hellcannon_first_strike(var0) {
  var1 = spawnStruct();
  var1.origin = (-35920, 32944, -552);
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::explosion_gethellcannonstructs();
  level notify("hell_cannon_fire_move_tank");
  scripts\sp\maps\safehouse_finale\safehouse_finale::level_hellcannonfire(var2[0], var1, 3.5);
  var3 = scripts\engine\utility::getStructArray("explosion_hellCannonTargetStruct", "targetname");
  playFX(scripts\engine\utility::getfx("vfx_safehouse_lingering_smoke"), var1.origin + (-100, 0, -50));
  scripts\engine\utility::exploder("explo_01");
  kill_perimeter_lights();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_showdamagedtargets();
  wait 0.2;
  earthquake(0.5, 1.35, var1.origin, 9999);
  scripts\engine\utility::flag_set("second_cannon");
  var4 = getaiarray("axis");

  if(isDefined(var0)) {
    var4 = scripts\engine\utility::array_remove(var4, var0);
  }

  scripts\engine\utility::array_delete(var4);
  thread cleanup_corpses();
}

function cleanup_corpses() {
  var0 = getcorpsearrayinradius((-35866, 32948, -488), 200);

  foreach(var2 in var0) {
    var2 delete();
  }
}

function charge_enemy_behavior() {
  level endon("farah_HC_command");
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\engine\utility::flag_wait("early_charge");
  self.ignoreme = 0;
  self.ignoreall = 0;
}

function player_early_shot_watcher() {
  level endon("reached_pep_idle");
  var0 = ["dx_vom_far_pre_charge_setup_200", "dx_vom_far_pre_charge_setup_220", "dx_vom_far_pre_charge_setup_210"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  level.player waittill("weapon_fired");
  var2 = getaiarray("axis");

  foreach(var4 in var2) {
    var4.ignoreall = 0;
  }

  level.farah stopsounds();
  waitframe();
  wait 1;
  level.farah scripts\engine\sp\utility::smart_dialogue(var1 scripts\engine\sp\utility::deck_draw_specific("dx_vom_far_pre_charge_setup_210"));
  scripts\engine\utility::flag_set("early_charge");
}

function get_to_charge() {
  var0 = scripts\engine\utility::getStruct("pep_talk_struct", "targetname");
  var0 scripts\sp\anim::anim_reach_solo(level.farah, "peptalk_exit");
  thread dialogue_pre_charge_fire_cannon();
  var0 thread scripts\common\anim::anim_single_solo(level.farah, "peptalk_exit");
}

function kill_perimeter_lights() {
  var0 = getscriptablearray("perimeter_lights", "targetname");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("onoff", "off");
  }
}

function pre_charge_wall_guys() {
  var0 = spawn_check_func(undefined, "pre_charge_wallSpawner", 2);
  wait 0.5;
  var0 = spawn_check_func(undefined, "pre_charge_wallSpawner", 1);
  var1 = 0;
  wait 3;
  var2 = scripts\engine\utility::getStruct("wall_general", "targetname");
  var2.origin += (40, 0, 5);
  var3 = spawn_check_func(undefined, "pre_charge_wallSpawner", 1)[0];
  var3.animname = "enemy_00";
  var3.general = 1;
  var3 clearpath();
  var3.target = undefined;
  var3.allowdeath = 1;
  var3 endon("death");
  var2 scripts\sp\anim::anim_reach_solo(var3, "directing_01");
  var2 scripts\common\anim::anim_single_solo(var3, "directing_01");
  var3 allowedstances("prone");
  wait 3;
  var3 delete();
}

function charge_start() {
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
  scripts\engine\utility::flag_set("bunker_busted");
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_showdamagedtargets();
  thread river_enter_watcher();
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  var1 scripts\engine\sp\utility::clear_force_color();
  var1 scripts\engine\sp\utility::set_force_color("g");
  scripts\engine\sp\utility::set_start_location("start_river", [level.player, var0, var1]);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies();
  scripts\engine\utility::array_thread(var3, &ally_start_at_end);
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_intro_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("town_wall_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("farah_river_mounds_color_trigger");
  var4 = charge_setalliestoredshirts();
  var5 = scripts\engine\sp\utility::array_spawn_targetname("technical_dudes_01");
  level notify("technical_stopped");
  level.allies = getaiarray("allies");
  scripts\engine\utility::array_thread(var5, &jump_technical_dudes);
  thread sfx_airbase_alarm();
  scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::activate_trigger_with_targetname, "charge_enter_trigger");
}

function charge_main() {
  thread dialogue_charge();
  thread bunkers_enter_watcher();
  var0 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var0, &delete);
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_setnotsolidtargets();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  scripts\engine\utility::flag_wait("bunker_busted");
  thread vo_walla_charge();
  thread run_dialogue();
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.9);
  level.player scripts\common\utility::allow_death(0);
  scripts\engine\utility::delaythread(0.1, &charge_redshirtssfxlogic);
  wait 1;
  var2 scripts\engine\sp\utility::clear_force_color();

  if(!scripts\engine\utility::flag("early_charge")) {
    scripts\engine\sp\utility::autosave_by_name("charge");
  }

  fob_post_load_inits();
  var3 = getaiarray("allies");
  var4 = getEntArray("hc_Spawner", "targetname");
  var3 = scripts\engine\utility::array_remove_array(var3, var4);
  level.player clearsoundsubmix("sp_npc_vehicles_down", 15);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::array_removedeaddyingorundefined(var3);
  var3 = sortbydistance(var3, level.player.origin);
  var5 = charge_getallypaths();
  var1 scripts\engine\utility::set_movement_speed(180);
  var6 = [var2];
  var7 = sortbydistance(var3, (-33524, 31042, -684))[0];

  foreach(var9 in var3) {
    var9 scripts\common\utility::demeanor_override("combat");

    if(istrue(level.trailer) && scripts\engine\utility::is_equal(var9.script_noteworthy, "charge_right")) {
      continue;
    }

    if(scripts\engine\utility::is_equal(var9.script_noteworthy, "gunners")) {
      var9 scripts\engine\sp\utility::set_force_color("y");
      var6 = var9;
      continue;
    }

    var10 = 0;

    if(var7 == var9) {
      var10 = 2;
    }

    var11 = sortbydistance(var5, var9.origin)[0];
    thread charge_allypathlogic(var9, var11, undefined, var10);
    var5 = scripts\engine\utility::array_remove(var5, var11);
    var9 scripts\engine\utility::set_movement_speed(220);
    thread charge_ally_variable_speed();
    thread ignore_until_fob();
  }

  wait 1;
  scripts\engine\sp\utility::activate_trigger_with_targetname("charge_cover_color_trigger");
  wait 2;
  scripts\engine\sp\utility::activate_trigger_with_targetname("bunkers_color_trigger");
  var13 = scripts\engine\sp\utility::array_spawn_targetname("charge_enemySpawner", 1);
  var13[0].baseaccuracy = 0.1;
  var13[0] scripts\engine\sp\utility::set_favoriteenemy(level.player);
  var14 = getaiarray("axis");

  foreach(var16 in var14) {
    var16.grenadeammo = 0;
    var16.ignoreall = 0;
    var16.ignoreme = 0;
  }

  wait 1;
  level.player scripts\engine\sp\utility::blend_movespeedscale(1, 2);
  wait 1;
  level notify("hell_cannon_fire");
  wait 0.35;
  var18 = spawnStruct();
  var18.origin = (-36120, 33599, -585);
  level notify("hell_cannon_fire_move_tank");
  var19 = scripts\sp\maps\safehouse_finale\safehouse_finale::explosion_gethellcannonstructs();
  scripts\sp\maps\safehouse_finale\safehouse_finale::level_hellcannonfire(var19[0], var18, 4);
  var20 = getEntArray("perimeter_tower_lights", "targetname");

  foreach(var22 in var20) {
    var22 setlightintensity(0);
  }

  level.player scripts\engine\utility::delaycall(0.2, &playrumbleonentity, "damage_heavy");
  screenshake(var18.origin, 20, 2, 4, 0.75, 0, 0.5, 1500, 5, 50, 50);
  var24 = getscriptablearray("guard_tower", "script_noteworthy");
  var24 = sortbydistance(var24, var18.origin);
  scripts\engine\utility::exploder("bunk_am");
  magicbullet("iw8_la_rpapa7_straight", var24[0].origin + (0, 0, 500), var24[0].origin, level.player);
  var25 = getaiarray("axis");

  foreach(var16 in var25) {
    var16 kill(var18.origin, level.player, level.player, "MOD_EXPLOSIVE");
  }

  var25 = getaiarray("allies");
  scripts\engine\utility::array_thread(var25, &hell_cannon_reactions, var18);
  var28 = spawn_check_func(32, "fob_front_guys");
  var25 = getaiarray("axis");

  foreach(var16 in var25) {
    var16 scripts\common\ai::magic_bullet_shield();
  }

  scripts\engine\utility::flag_wait("bunkers_charged");
  scripts\engine\sp\utility::autosave_by_name("bunkers_charged");
  scripts\engine\utility::flag_wait("player_exited_river");
  thread scripts\sp\maps\safehouse_finale\safehouse_finale::ammo_count();
  wait 3;

  foreach(var16 in var25) {
    var16 scripts\common\ai::stop_magic_bullet_shield();
  }

  level.player scripts\common\utility::allow_death(1);
  thread ally_equipment_watcher();
}

function run_dialogue() {
  wait 4.5;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_charge_go_30");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_charge_go_20");
  var0 = spawn("script_origin", (-35745, 32645, -465));
  var0 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_rcom_pre_charge_setup_50");
  var0 scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_rcom_pre_charge_setup_60");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_charge_go_40");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_charge_run_50");
  wait 2;
  var0 delete();
  var0 = spawn("script_origin", (-36506, 33360, -329));
  var0 scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_rcom_pre_charge_setup_70");
  var0 delete();
}

function bunkers_enter_watcher() {
  var0 = charge_getplayerexittrigger();
  var0 waittill("trigger");
  scripts\engine\utility::flag_set("player_exited_river");
}

function vo_walla_charge() {
  wait 0.8;
  var0 = spawn("script_origin", level.armen.origin);
  var0 linkTo(level.armen);
  var0 playSound("sh_walla_finale_charge", "sounddone");
  var0 waittill("sounddone");
  var0 delete();
}

function charge_catchup() {
  if(istrue(level.bink_start)) {
    return;
  }

  scripts\engine\utility::flag_set("fly_attack_done");
  thread ally_equipment_watcher();
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("bunker_busted");
  var0 = getEntArray("truck_lights", "targetname");

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function hell_cannon_reactions(var0) {
  scripts\engine\sp\utility::set_goal_radius(256);
  self endon("death");
  wait 0.2;

  if(distance2d(self.origin, var0.origin) < 1500) {
    wait randomfloatrange(0.05, 0.5);
    self endon("kill_pathing");
    self notify("stop_going_to_node");
    self clearpath();
    self setgoalpos(self.origin);
    self dodamage(1, var0.origin, undefined, undefined, "MOD_RIFLE_BULLET");
    scripts\engine\sp\utility::set_goal_radius(256);
    scripts\engine\sp\utility::clear_force_color();
    scripts\engine\sp\utility::set_force_color("r");
    self enableavoidance(1, 1);
    self.disablearrivals = 0;
    self.disableexits = 0;
    return;
  }
}

function charge_ally_variable_speed() {
  self endon("death");
  wait 2;

  for(;;) {
    var0 = level.player getEye();
    var1 = self getEye();
    var2 = sighttracepassed(var0, var1, 0, level.player, 1);
    var3 = 0.9948;

    if(var2) {
      break;
    }

    wait 1;
  }

  scripts\engine\utility::set_movement_speed(180);
}

function ally_equipment_watcher() {
  level.player endon("death");

  for(;;) {
    var0 = level.player getammocount(getcompleteweaponname("molotov"));

    if(var0 < 2) {
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
  var1 = [level.farah, level.hadir];

  foreach(var3 in var1) {
    if(var3.support_equipment < 1) {
      var1 = scripts\engine\utility::array_remove(var1, var3);
    }

    var3.support_equipment = 0;
    var3 notify("remove_other_ai_hint");
  }

  for(;;) {
    var0 = level.player getammocount(getcompleteweaponname("molotov"));

    if(var0 < 2) {
      break;
    }

    wait 0.5;
  }

  foreach(var3 in var1) {
    var3.support_equipment = 4;
  }

  level.player notify("ally_equipment_notify");
  level.player.ally_equipment_force_ping = 1;
}

function rpg_guy_logic() {
  wait 2;
  var0 = scripts\engine\sp\utility::spawn_targetname("charge_enemySpawner_rpg", 1);
  var0 endon("death");
  var0 scripts\engine\sp\utility::set_ignoresuppression(1);
  var0 scripts\engine\sp\utility::disable_bulletwhizbyreaction();
  var0 scripts\engine\sp\utility::set_goal_radius(32);
  var0.ignoreall = 1;
  var0.ignoreme = 1;
  var0.attackeraccuracy = 0;
  var0 allowedstances("stand");
  var0 scripts\anim\shared::forceuseweapon("iw8_la_rpapa7_straight", "primary");
  var1 = scripts\engine\utility::getStruct("charge_distance_struct", "targetname");
  var2 = scripts\engine\utility::spawn_tag_origin(var1.origin + (200, -200, -15), var1.angles);
  var0 waittill("goal");
  wait 3;
  var0.ignoreall = 0;

  for(;;) {
    var3 = getaiarray("allies");
    var3 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::array_removedeaddyingorundefined(var3);
    var3 = sortbydistance(var3, var1.origin);
    var0 setentitytarget(var2);
    wait 0.2;
  }
}

function river_enter_watcher() {
  var0 = ["dx_vom_far_pre_charge_setup_230", "dx_vom_far_pre_charge_setup_250", "dx_vom_far_pre_charge_setup_240"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  level.player.ignoreme = 1;
  scripts\engine\utility::flag_wait("player_dropped_in");
  level.player.ignoreme = 0;
  var2 = getEnt("charge_enter_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("charge_enter", var2, 1);

  if(scripts\engine\utility::flag("bunker_busted")) {
    return;
  }

  level.farah stopsounds();
  waitframe();

  while(!scripts\engine\utility::flag("bunker_busted")) {
    if(istrue(check_stay_in_river(var1))) {
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

  if(isalive(level.player)) {
    thread check_stay_in_river(level);
  }

  wait 1;
  scripts\engine\utility::flag_set("early_charge");
}

function check_stay_in_river(var0) {
  if(scripts\engine\utility::flag("charge_enter") || scripts\engine\utility::flag("reached_pep_idle")) {
    return false;
  }

  level endon("bunker_busted");
  level.farah scripts\engine\sp\utility::smart_dialogue(var0 scripts\engine\sp\utility::deck_draw());
  wait 1.2;
  level.farah scripts\engine\sp\utility::smart_dialogue(var0 scripts\engine\sp\utility::deck_draw());
  wait 0.8;
  var1 = (-35695, 33793, -258);
  magicbullet("iw8_lm_pkilo", var1, level.player.origin + (0, 0, 40));
  level.player waittill("damage");
  level.player kill();
  return true;
}

function ignore_until_fob() {
  if(self == level.hadir || self == level.farah) {
    self.ignoreme = 1;
  }

  self endon("death");
  self.attackeraccuracy = 1;
  var0 = charge_getplayerexittrigger();

  while(!self istouching(var0)) {
    waitframe();
  }

  self enableavoidance(0, 0);
  wait 0.1;

  while(self istouching(var0)) {
    waitframe();
  }

  if(self == level.hadir || self == level.farah) {
    self.ignoreme = 0;
  }

  self.attackeraccuracy = 0.2;
  self notify("charge_clear_paths");
  self notify("stop_going_to_node");
  scripts\engine\sp\utility::clear_force_color();
  scripts\engine\sp\utility::set_force_color("r");
  wait 2;
  self.ignoreall = 0;
  self enableavoidance(1, 1);
}

function charge_getplayerexittrigger() {
  return getEnt("charge_playerExitTrigger", "targetname");
}

function charge_allypathlogic(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    wait var3;
  }

  var0 endon("death");
  var0 scripts\engine\sp\utility::set_goalRadius(64);
  var0 scripts\engine\utility::set_cautious_navigation(0);
  var0.disablearrivals = 1;
  var0.disableexits = 1;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::ai_movealongpath(var0, var1);
  var0.disablearrivals = 0;
  var0.disableexits = 0;

  if(isDefined(var2)) {
    var0 scripts\engine\sp\utility::set_force_color("r");
    return;
  }
}

function charge_getallypaths() {
  return getnodearray("charge_allyPath", "targetname");
}

function container_getallypaths() {
  return getnodearray("gate_allyPath", "targetname");
}

function charge_setalliestoredshirts() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::getallies();

  foreach(var2 in var0) {
    var2.targetname = "charge_redShirt";
    var2 visiblesolid();
    var2.baseaccuracy = 0.1;
    var2.health = 40;
    var2.script_longdeath = 1;
  }

  return var0;
}

function charge_redshirtssfxlogic() {
  var0 = ["dx_vom_lf3_fob_center_helos_190", "dx_vom_had_containers_heliattack_140"];
  var1 = 3.2;
  var2 = 3.3;
  var3 = randomfloatrange(var1, var2);
  wait var3;
  var4 = 0.05;
  var5 = 0.15;
  var6 = charge_getredshirts();

  foreach(var8 in var6) {
    var9 = scripts\engine\utility::random(var0);
    var8 playSound(var9);
    var10 = randomfloatrange(var4, var5);
  }
}

function charge_getredshirts() {
  return getEntArray("charge_redShirt", "targetname");
}

function bunkers_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("bunkers_breached");
  scripts\engine\utility::flag_set("fob_truck_entrance");
  scripts\engine\utility::flag_set("fly_attack_done");
  scripts\engine\sp\utility::set_start_location("tent_city_start", [level.player]);
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_showdamagedtargets();
  thread sfx_airbase_alarm();
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(10);
  var4 = charge_setalliestoredshirts();
  var5 = bunker_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var4, [var0, var1, var2]);

  foreach(var7 in level.allies) {
    var8 = scripts\engine\utility::random(var5);
    var7 scripts\engine\sp\utility::teleport_ai(var8);
    var5 = scripts\engine\utility::array_remove(var5, var8);
  }

  var10 = spawn_check_func(32, "fob_front_guys");

  foreach(var12 in var10) {
    var12.grenadeammo = 0;
  }

  var14 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var14, &delete);
}

function bunkers_main() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  thread chu_bad_places();
  thread scripts\sp\analytics::analytics_kleenex_update("Bunkers to Containers");
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  thread ally_fob_movement();
  thread molotov_hint_flash();
  thread armory_01();
  scripts\engine\utility::flag_wait("bunkers_breached");
  level.player.ignoreme = 0;
  thread bunkers_kill_allies();
  thread dialogue_fob_bunkers();
  wait 1;
  var2 = spawn_check_func(32, "fob_front_guys_2");

  foreach(var4 in var2) {
    var4.grenadeammo = 0;
  }

  var6 = getaiarray("axis");
  thread enemies_cleared_move_forward(var6);
  scripts\engine\sp\utility::autosave_by_name("bunkers_breached");
  scripts\engine\utility::flag_wait("fob_center");
  scripts\engine\sp\utility::autosave_by_name("fob_center");
  var6 = scripts\engine\utility::array_removedead_or_dying(var6);
  var7 = getEnt("fob_center_pit_vol", "targetname");

  foreach(var4 in var6) {
    var4 setgoalvolumeauto(var7);
  }
}

function bunkers_kill_allies() {
  var0 = getEntArray("hc_Spawner", "targetname");
  thread scripts\engine\utility::array_delete(var0);
  var1 = getaiarray("allies");
  var2 = [level.farah, level.hadir, level.armen];
  var1 = scripts\engine\utility::array_remove_array(var1, var2);
  level endon("fob_center_entrance");
  level endon("bunkers_push");

  while(var1.size > 8) {
    var1 = scripts\engine\utility::array_removedead_or_dying(var1);
    var1 = sortbydistance(var1, level.player.origin);
    var3 = var1.size - 1;
    var4 = var1[var3];
    var5 = level.player getEye();
    var6 = var4 getEye();
    var7 = sighttracepassed(var5, var6, 0, level.player, 1);
    var8 = 0.707;

    if(!var7) {
      var4 kill();
    }

    wait 1;
  }
}

function armory_01() {
  thread chu_bad_places_armory();
  thread ally_armory_guards();
  thread armory_01_nag();
  thread dialogue_armory_01();
  thread battle_chatter_armory_01();
  scripts\engine\utility::flag_wait("fob_exit");
  level.enemy_armory_guards = scripts\engine\sp\utility::array_spawn_targetname("armory_guards");
  thread armory_guards_anims();
  level.armory_guards_ignored = 1;
  scripts\engine\utility::array_thread(level.enemy_armory_guards, &enemy_armory_guards_ignored);
  scripts\engine\sp\utility::trigger_wait_targetname("armory_01_trigger");
  scripts\engine\utility::flag_set("armory_01_trigger");
  thread tromeo_cleanup();
  var0 = spawnStruct();
  var0.origin = (-40170, 34500, -650);
  var0.angles = (0, 0, 0);
  level.gate_truck = scripts\engine\sp\utility::spawn_anim_model("gate_truck");
  var1 = getEnt("airport_gate", "targetname");
  var1.animname = "gate";
  var1 scripts\engine\sp\utility::assign_animtree();
  var0 thread scripts\common\anim::anim_first_frame_solo(level.gate_truck, "truck_enter");
  var0 thread scripts\common\anim::anim_first_frame_solo(var1, "truck_smash");
  thread anim_gate_truck_lights();
  var2 = getEnt("truck_smash_clip", "targetname");
  var2 show();
  var2 linkTo(level.gate_truck);
  var2 disconnectPaths();
  level.armory_guards_ignored = 0;

  while(level.enemy_armory_guards.size > 0) {
    level.enemy_armory_guards = scripts\engine\utility::array_removedead_or_dying(level.enemy_armory_guards);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("armory_01_secure");
}

function tromeo_cleanup() {
  var0 = scripts\engine\sp\utility::getvehiclearray();
  var1 = 700;
  var2 = (-40649, 34632, -636);

  foreach(var4 in var0) {
    if(scripts\engine\utility::is_equal(var4.model, "veh8_mil_lnd_tromeo_black") || scripts\engine\utility::is_equal(var4.model, "veh8_mil_lnd_tromeo_static_dst_black")) {
      if(var1 > distance(var2, var4.origin)) {
        var4 delete();
      }
    }
  }
}

function battle_chatter_armory_01() {
  level endon("armory_01_secure");
  scripts\engine\utility::flag_wait("fob_cleared");

  if(!scripts\engine\utility::flag("armory_01_secure")) {
    scripts\engine\sp\utility::battlechatter_off("allies");
    scripts\engine\utility::flag_wait("armory_01_secure");
    scripts\engine\sp\utility::battlechatter_on("allies");
    return;
  }
}

function ammo_box_lids() {
  if(!scripts\engine\utility::is_equal(self.script_noteworthy, "ammo")) {
    return;
  }

  var0 = scripts\engine\utility::get_linked_ent();
  self waittill("offhand_box_used");
  wait 0.2;
  var0.struct_01 = var0 scripts\engine\utility::get_target_ent();
  var0.struct_02 = var0.struct_01 scripts\engine\utility::get_target_ent();
  var0 moveTo(var0.struct_01.origin, 0.3);
  var0 rotateTo(var0.struct_01.angles, 0.3);
  wait 0.2;
  var0 moveTo(var0.struct_02.origin, 0.15);
  var0 rotateTo(var0.struct_02.angles, 0.15);
}

function anim_gate_truck_lights() {
  var0 = getEntArray("gate_truck_lights", "targetname");
  waitframe();
  var1 = 2;

  foreach(var3 in var0) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "left")) {
      var3.origin = self gettagorigin("tag_light_front_left");
      var3.origin += anglestoright(var3.angles) * var1;
      var3.angles = self gettagangles("tag_light_front_left");
      var3 linkTo(self, "tag_light_front_left");
    }

    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "right")) {
      var3.origin = self gettagorigin("tag_light_front_right");
      var3.origin += anglestoright(var3.angles) * var1;
      var3.angles = self gettagangles("tag_light_front_right");
      var3 linkTo(self, "tag_light_front_right");
    }
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_left_container"), self, "tag_light_front_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_right_container"), self, "tag_light_front_right");
  scripts\engine\utility::flag_wait("chu_entrance");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_left_container"), self, "tag_light_front_left");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_umike_right_container"), self, "tag_light_front_right");

  foreach(var3 in var0) {
    var3 setlightintensity(0);
  }
}

function armory_guards_anims() {
  var0 = spawnStruct();
  var0.origin = (-40269, 34936, -607);
  var0.angles = (0, 90, 0);

  foreach(var2 in level.enemy_armory_guards) {
    if(var2 == level.enemy_armory_guards[0]) {
      var2.animname = "enemy_01";
    } else {
      var2.animname = "enemy_02";
    }

    var2.allowdeath = 1;
    var2 endon("death");
  }

  scripts\engine\utility::array_thread(level.enemy_armory_guards, &armory_guard_death_watcher);
  scripts\engine\utility::array_thread(level.enemy_armory_guards, &armory_guard_breakout);
  var0 thread scripts\common\anim::anim_single(level.enemy_armory_guards, "armory_surprise_toss");
  waitframe();

  foreach(var2 in level.enemy_armory_guards) {
    var2 setanimtime(var2 scripts\engine\utility::getanim("armory_surprise_toss"), 0.27);
    var2 setanimrate(var2 scripts\engine\utility::getanim("armory_surprise_toss"), 0);
  }

  thread armory_01_anim_start();
  var6 = (-40245, 34873, -574);

  while(!sighttracepassed(level.player getEye(), var6, 0, level.player)) {
    if(level.player.cansee_armory) {
      break;
    }

    wait 0.1;
  }

  level notify("shut_down_armory_breakout");

  foreach(var2 in level.enemy_armory_guards) {
    if(isDefined(var2)) {
      var2 setanimrate(var2 scripts\engine\utility::getanim("armory_surprise_toss"), 1);
    }
  }
}

function armory_01_anim_start() {
  level.player.cansee_armory = 0;
  scripts\engine\sp\utility::trigger_wait_targetname("armory_01_trigger");
  level.player.cansee_armory = 1;
}

function armory_guard_death_watcher() {
  level endon("shut_down_armory_breakout");

  while(isalive(self)) {
    waitframe();
  }

  level notify("armory_breakout");
}

function armory_guard_breakout() {
  self endon("death");
  level endon("shut_down_armory_breakout");
  level waittill("armory_breakout");
  self stopanimScripted();
  self setgoalpos(self.origin);
}

function enemy_armory_guards_ignored() {
  self endon("death");
  self.ignoreme = 1;

  while(level.armory_guards_ignored) {
    waitframe();
  }

  self.ignoreme = 0;
}

function ally_armory_guards() {
  scripts\engine\utility::flag_wait("armory_01_secure");

  if(scripts\engine\utility::flag("fob_cleared")) {
    var0 = scripts\engine\sp\utility::array_spawn_targetname("armory_01_ally_spawner", 1);
    var1 = getnodearray("armory_01_nodes", "targetname");
    var1 = sortbydistance(var1, var0[0].origin);

    foreach(var3 in var0) {
      var3 setgoalnode(var1[var4]);
    }

    return;
  }
}

function ally_armory_02_guards() {
  scripts\engine\utility::flag_wait("armory_02_secure");
  var0 = scripts\engine\sp\utility::array_spawn_targetname("armory_02_ally_spawner", 1);
  var1 = getnodearray("armory_02_nodes", "targetname");
  var1 = sortbydistance(var1, var0[0].origin);

  foreach(var3 in var0) {
    var3 setgoalnode(var1[var4]);
  }
}

function armory_02() {
  thread armory_02_door();
  thread hangar_hatch();
  level.enemy_armory_guards = scripts\engine\sp\utility::array_spawn_targetname("armory_02_guards", 1);
  scripts\engine\utility::array_thread(level.enemy_armory_guards, &scripts\engine\sp\utility::set_battlechatter, 0);
  level.armory_guards_ignored = 1;

  foreach(var1 in level.enemy_armory_guards) {
    var1 scripts\engine\sp\utility::disable_surprise();
  }

  scripts\engine\utility::array_thread(level.enemy_armory_guards, &enemy_armory_guards_ignored);
  scripts\engine\utility::flag_wait("hatch_opened");
  level.enemy_armory_guards = scripts\engine\utility::array_removedead_or_dying(level.enemy_armory_guards);

  foreach(var1 in level.enemy_armory_guards) {
    var1 getenemyinfo(level.player);
  }

  scripts\engine\sp\utility::trigger_wait_targetname("armory_02_trigger");
  level.hadir.support_equipment = level.hadir.support_equipment_og;
  scripts\engine\utility::exploder("hangar_enemy_smoke");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::remove_corpses_away_from_player_pos(1200);
  level.armory_guards_ignored = 0;

  while(level.enemy_armory_guards.size > 0) {
    level.enemy_armory_guards = scripts\engine\utility::array_removedead_or_dying(level.enemy_armory_guards);
    waitframe();
  }

  scripts\engine\utility::flag_set("armory_02_secure");
}

function armory_02_guards_vo() {
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::wait_for_break_in_chatter(1);
  level.enemy_armory_guards[0] scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_ru4_armory_02_ruconvo1_10");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::wait_for_break_in_chatter(2);
  level.enemy_armory_guards[0] scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_ru4_armory_02_ruconvo1_30");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::wait_for_break_in_chatter(5);
  level.enemy_armory_guards[1] scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_ru3_armory_02_ruconvo1_40");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::wait_for_break_in_chatter(5);
  level.enemy_armory_guards[0] scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_ru4_armory_02_ruconvo1_50");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::wait_for_break_in_chatter(1);
  level.enemy_armory_guards[1] scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_ru3_armory_02_ruconvo1_60");
}

function armory_02_door() {
  var0 = getEntArray("armory_02_door", "targetname");
  var1 = undefined;

  foreach(var3 in var0) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "interactive_door")) {
      var1 = var3;
    }
  }

  var1 waittill("trigger");
  scripts\engine\utility::flag_set("hadir_go_to_hatch");
}

function hangar_hatch() {
  scripts\engine\utility::flag_wait("hadir_go_to_hatch");
  var0 = spawnStruct();
  var0.origin = (-42507.5, 28453.1, -678.982);
  var0.angles = (0, -20, 0);
  var1 = getEnt("hangar_hatch", "targetname");
  var1.clip = var1 scripts\engine\utility::get_target_ent();
  var1.clip linkTo(var1);
  var1.animname = "hatch";
  var1 scripts\engine\sp\utility::assign_animtree();
  var2 = spawnStruct();
  var2.origin = (-42647, 28362, -539);
  var2.angles = (0, 70, 0);
  var2 thread scripts\common\anim::anim_first_frame_solo(var1, "armory_hatch");
  buddy_boost(var0);
  thread player_in_armory_watcher();
  thread player_fell_watcher();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  scripts\engine\sp\utility::autosave_by_name("armory_02_door");
  var2 scripts\sp\anim::anim_reach_solo(level.hadir, "armory_enter");
  var2 scripts\common\anim::anim_single_solo(level.hadir, "armory_enter");
  var3 = getEnt("hatch_flag_trigger", "targetname");
  var2 notify("stop_loop");
  thread scripts\engine\utility::flag_set_delayed("hatch_opened", 0.5);
  var2 thread scripts\common\anim::anim_single_solo(var1, "armory_hatch");
  var2 scripts\common\anim::anim_single_solo(level.hadir, "armory_hatch");
  var2 thread scripts\common\anim::anim_loop_solo(level.hadir, "armory_hatch_idle", "stop_loop");
  thread hadir_pick_up_loop(var0);

  while(!scripts\engine\utility::flag("player_in_armory_02") && istrue(level.player_on_armory)) {
    scripts\engine\utility::waittill_any_timeout(5, "player_fell");
    var2 notify("stop_loop");
    var2 scripts\common\anim::anim_single_solo(level.hadir, "armory_hatch_nag");
    var2 thread scripts\common\anim::anim_loop_solo(level.hadir, "armory_hatch_idle", "stop_loop");
    scripts\engine\utility::waittill_any_timeout(5, "player_fell");

    if(scripts\engine\utility::flag("player_in_armory_02") || !istrue(level.player_on_armory)) {
      break;
    }
  }

  LOC_000001fe:
    var2 notify("stop_loop");
}

function hadir_pick_up_loop(var0) {
  var1 = self;
  thread reboost_nav_obstacle();
  var2 = spawnStruct();
  var2.origin = (-42693, 28343, -480);
  var2.angles = (21, 345, 0);

  while(!scripts\engine\utility::flag("player_in_armory_02")) {
    if(!istrue(level.player_on_armory)) {
      var0 notify("stop_loop");
      level.hadir stopanimScripted();
      buddy_boost_restart(var1);
      var0 scripts\sp\anim::anim_reach_solo(level.hadir, "armory_hatch_idle");
      var0 thread scripts\common\anim::anim_loop_solo(level.hadir, "armory_hatch_idle", "stop_loop");
      level.hadir notify("back_at_hatch");
    }

    waitframe();
  }

  var0 notify("stop_loop");
}

function player_fell_watcher() {
  level.hadir waittillmatch("single anim", "end");
  level.player_on_armory = 1;

  while(!scripts\engine\utility::flag("player_in_armory_02")) {
    if(level.hadir.origin[2] > level.player.origin[2] + 100) {
      level.player_on_armory = 0;
      level notify("player_fell");
    }

    waitframe();
    level.player_on_armory = 1;
  }
}

function buddy_boost() {
  var0 = getEnt("no_stick_clip", "targetname");
  var0 setnonstick(1);
  var0 setCanDamage(1);
  level.hadir.support_equipment_og = level.hadir.support_equipment;
  level.hadir.support_equipment = 0;
  level.hadir notify("remove_equipment");
  level.hadir.name = "";
  var1 = self;
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  level.player.rig hide();
  var1 scripts\common\anim::anim_single_solo(level.hadir, "buddy_boost_enter");
  var1 thread scripts\common\anim::anim_loop_solo(level.hadir, "buddy_boost_enter_idle");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, "buddy_boost");
  thread hadir_boost_nag(var1);
  level.hadir thread scripts\common\utility::lookatentity(level.player);
  level.hadir scripts\sp\player\cursor_hint::create_cursor_hint("tag_accessory_left", (0, 0, 0), &"SAFEHOUSE_FINALE_LOC/BOOST", undefined, 700, 100, undefined, undefined, undefined, undefined, "duration_short");
  level.hadir waittill("trigger");
  level.hadir thread scripts\common\utility::lookatentity();
  level.player_rig = level.player.rig;
  visionsetnaked("safehouse_finale_hangar_lift", 0);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::put_player_into_rig(level.player.rig, 0.75, 0, 0, 0, 0);
  var1 thread scripts\common\anim::anim_single([level.hadir, level.player.rig], "buddy_boost");
  var1 notify("stop_loop");
  level.player.rig waittillmatch("single anim", "end");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::pull_player_out_of_rig_hide_rig(level.player.rig);
  level.jumpspot = level.player.origin;
  visionsetnaked("", 0);
  var1 thread scripts\common\anim::anim_loop_solo(level.hadir, "buddy_boost_restart_idle", "stop_loop");
  thread jump_interact();
  jump_watcher(level.jumpspot);
  visionsetnaked("safehouse_finale_hangar_lift", 0);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::put_player_into_rig(level.player.rig, 0, 0, 0, 0, 0);
  var1 thread scripts\sp\player_rig::anim_lerp_from_player_pos("buddy_boost_restart", 0.5, 0.5);
  var1 notify("stop_loop");
  level.player notify("jumped_up");
  var1 scripts\common\anim::anim_single([level.hadir], "buddy_boost_restart");
  level.player allowjump(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::pull_player_out_of_rig_hide_rig(level.player.rig);
  visionsetnaked("", 0);
}

function jump_watcher(var0) {
  level endon("boost_jumped");

  for(;;) {
    var1 = distance(level.player.origin, var0);

    if(var1 < 50) {
      level.player allowjump(0);
    } else {
      level.player allowjump(1);
    }

    if(var1 < 50 && level.player jumpbuttonPressed()) {
      break;
    }

    waitframe();
  }

  level notify("boost_jumped");
}

function jump_interact() {
  level endon("boost_jumped");
  wait 2.5;
  var0 = scripts\engine\utility::spawn_tag_origin(level.hadir gettagorigin("j_head"), (0, 0, 0));
  var0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, -30), &"SAFEHOUSE_FINALE_LOC/BOOST_JUMP", undefined, 600, 125, undefined, undefined, undefined, undefined, "duration_short");
  thread jump_interact_remove();
  var0 waittill("trigger");
  level notify("boost_jumped");
  var0 delete();
}

function reboost_nav_obstacle() {
  var0 = getEnt("armory_roof_obstacle", "targetname");
  var1 = createnavobstaclebyent(var0, "allies");
}

function jump_interact_remove() {
  self endon("trigger");
  level scripts\engine\utility::waittill_any("boost_jumped", "player_in_armory_02");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function hadir_boost_nag(var0) {}

function buddy_boost_restart() {
  self notify("stop_loop");
  scripts\sp\anim::anim_reach_solo(level.hadir, "buddy_boost_restart_enter");
  scripts\common\anim::anim_single_solo(level.hadir, "buddy_boost_restart_enter");
  thread scripts\common\anim::anim_loop_solo(level.hadir, "buddy_boost_restart_idle", "stop_loop");
  scripts\common\anim::anim_first_frame_solo(level.player.rig, "buddy_boost_restart");
  thread jump_interact();
  jump_watcher(level.jumpspot);
  self notify("stop_loop");
  level.player allowjump(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::put_player_into_rig(level.player.rig, 1, 0, 0, 0, 0);
  scripts\common\anim::anim_single([level.hadir, level.player.rig], "buddy_boost_restart");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::pull_player_out_of_rig_hide_rig(level.player.rig);
}

function player_in_armory_watcher() {
  scripts\engine\sp\utility::trigger_wait_targetname("armory_02_trigger");
  scripts\engine\utility::exploder("hangar_enemy_smoke");
  scripts\engine\utility::flag_set("player_in_armory_02");
}

function molotov_hint_flash() {
  scripts\engine\utility::flag_wait_or_timeout("fob_truck_entrance", 10);

  if(level.player getammocount("molotov") > 0) {
    scripts\engine\sp\utility::display_hint_forced("molotov_hint", 10);
    return;
  }
}

function gunner_bravo_spawn() {
  wait 2;
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("fob_chopper_04");
  var0 thread scripts\engine\sp\utility::battlechatter_addvehicle("helicopter");
  wait 0.1;
  level notify("chopper_spawned");
  var0 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::track_fob_helo_spawn();
}

function transport_bravo_spawn() {
  for(;;) {
    var0 = getaiarray("axis", "allies");

    if(var0.size < 27 && !scripts\engine\utility::flag("ai_spawner_busy")) {
      break;
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("ai_spawner_busy");
  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname("fob_chopper_transport");
  var1 thread scripts\engine\sp\utility::battlechatter_addvehicle("helicopter");
  wait 0.1;
  scripts\engine\utility::flag_clear("ai_spawner_busy");
  level notify("chopper_spawned");
  var1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::track_fob_helo_spawn();
}

function bunker_getallycovernodes() {
  return getnodearray("bunker_allyNode", "targetname");
}

function precharge_getallycovernodes() {
  return getnodearray("preCharge_allyNode", "script_noteworthy");
}

function town_getallycovernodes() {
  return getnodearray("town_allyNode", "targetname");
}

function fobcenter_getallycovernodes() {
  return getnodearray("fobCenter_allyNode", "targetname");
}

function fobchu_getallycovernodes() {
  return getnodearray("fobCHU_allyNode", "targetname");
}

function airportcombat_getallycovernodes() {
  return getnodearray("airportCombat_allyNode", "targetname");
}

function trenchrun_getallycovernodes() {
  return getnodearray("trenchRun_allyNode", "targetname");
}

function towerstairs_getallycovernodes() {
  return getnodearray("towerStairs_allyNode", "targetname");
}

function redshirt_refill() {
  level endon("hangar_interior");
  var0 = getspawner("allySpawner_bunkers", "targetname");
  var1 = 8;

  for(;;) {
    if(scripts\engine\utility::flag("fob_player_in_center")) {
      var0 = getspawner("allySpawner_center", "targetname");
    }

    if(scripts\engine\utility::flag("fob_exit")) {
      var0 = getspawner("allySpawner_exit", "targetname");
    }

    if(scripts\engine\utility::flag("chu_strafe_run")) {
      var0 = getspawner("allySpawner_Containers", "targetname");
      var1 = 7;
    }

    var2 = var0.origin;
    var3 = getaiarray("allies");

    if(var3.size < var1) {
      var4 = getaiarray("axis", "allies");

      if(var4.size > 30 || scripts\engine\utility::flag("ai_spawner_busy")) {
        wait 0.1;
        continue;
      }

      scripts\engine\utility::flag_set("ai_spawner_busy");
      var0 = scripts\engine\utility::random(["allySpawner_dmr", "allySpawner_sh", "allySpawner_ar", "allySpawner_smg"]);
      var0 = getspawner(var0, "targetname");
      var5 = var0 scripts\engine\sp\utility::spawn_ai(1);

      if(var5.classname == "actor_ally_reb_desert_dmr") {
        var5.disablesniperbehaviors = 1;
      }

      var5.health = 40;
      var5.baseaccuracy = 0.1;
      var5 scripts\engine\sp\utility::set_force_color("r");
      var5 scripts\engine\utility::set_movement_speed(220);
      var5 forceteleport(var2);
      level.allies = scripts\engine\utility::array_add(level.allies, var5);
      scripts\engine\utility::flag_clear("ai_spawner_busy");

      if(scripts\engine\utility::flag("fob_exit") && !scripts\engine\utility::flag("chu_strafe_run_go")) {
        var5 scripts\engine\sp\utility::clear_force_color();
        var5 scripts\engine\sp\utility::set_force_color("r");
      }

      if(scripts\engine\utility::flag("tarmac_enter")) {
        var5 scripts\engine\sp\utility::clear_force_color();
        var5 scripts\engine\sp\utility::set_force_color("p");
      } else {
        var5 scripts\engine\sp\utility::clear_force_color();
        var5.fixednode = 0;
        var5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
      }

      var0.count++;
    }

    wait 4;
  }
}

function ally_fob_movement(var0) {
  scripts\engine\utility::flag_wait("bunkers_breached");
  scripts\engine\sp\utility::activate_trigger_with_targetname("bunkers_color_trigger");
  level.allies = getaiarray("allies");
  level.ally_volume = fob_getallyentrancevolume();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var3 = getEnt("armen", "script_noteworthy");

  foreach(var5 in level.allies) {
    if(isalive(var5) && isDefined(var5)) {
      var5 scripts\engine\sp\utility::clear_force_color();
      var5 scripts\engine\sp\utility::set_force_color("r");
    }

    if(var5 == var1) {
      var5 scripts\engine\sp\utility::clear_force_color();
      var5 scripts\engine\sp\utility::set_force_color("o");
      continue;
    }

    if(var5 == var3) {
      var5 scripts\engine\sp\utility::clear_force_color();
      var5 scripts\engine\sp\utility::set_force_color("c");
    }
  }

  scripts\engine\utility::flag_wait_any("fob_center", "bunkers_push");
  var7 = fob_left_flank_init();
  var8 = scripts\engine\utility::getStruct("armen_front_goal_spots", "targetname");

  foreach(var5 in var7) {
    if(isalive(var5) && isDefined(var5)) {
      var5 scripts\engine\sp\utility::clear_force_color();
      var5 setgoalpos(var8.origin);
      var5 scripts\engine\sp\utility::set_goal_radius(400);
      var5.fixednode = 0;
    }
  }

  if(!scripts\engine\utility::flag("fob_rear")) {
    wait 3;
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("fob_center_color_trigger");
  thread farah_door_kill();
  scripts\engine\utility::flag_wait("fob_center_entrance");
  level.ally_volume = getEnt("fob_ally_center_vol", "targetname");
  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("fob_ally_rear_vol", "targetname");

  foreach(var5 in level.allies) {
    if(isalive(var5) && isDefined(var5)) {
      var5 scripts\engine\sp\utility::clear_force_color();
      var5 setgoalpos(var5.origin);
      var5 scripts\engine\sp\utility::set_goal_radius(1000);
      var5.fixednode = 0;
      var5 setgoalentity(level.player);
      var5.ignoresuppression = 0;
    }

    if(var5 == level.farah || var5 == level.hadir) {
      var5 clearpath();
      var5 setgoalpos((-38160, 34650, -648));
      var5 scripts\engine\sp\utility::set_goal_radius(500);
      LOC_0000025b:
    }
    LOC_0000025b:
  }

  scripts\engine\utility::flag_wait("fob_rear");
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("fob_ally_exit_vol", "targetname");

  foreach(var5 in level.allies) {
    if(isalive(var5) && isDefined(var5)) {
      var5 setgoalpos(var5.origin);
      var5.fixednode = 0;
      var5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
    }

    if(var5 == level.farah || var5 == level.hadir) {
      var5 clearpath();
      var5 setgoalpos((-38592, 34664, -684));
      var5 scripts\engine\sp\utility::set_goal_radius(400);
    }
  }

  scripts\engine\utility::flag_wait("fob_exit_guards");
  level.allies = getaiarray("allies");
  goal_ent_player(1000, level.allies);
  scripts\engine\utility::flag_set("ally_fob_movement_complete");
  scripts\engine\utility::flag_wait("fob_spawns_complete");
  scripts\engine\utility::flag_wait("fob_cleared");
}

function farah_door_kill() {
  level endon("fob_player_in_center_swarm");
  level endon("fob_exit");

  if(scripts\sp\starts::is_after_start("fob_center")) {
    return;
  }

  var0 = getEnt("chu_bad_places_door", "targetname");
  var0 = createnavbadplacebyent(var0, "allies", "axis");
  var1 = scripts\engine\utility::getStruct("farah_door_struct", "targetname");
  var1.enemy_target = undefined;
  var1.target_ent = undefined;
  var2 = var1 scripts\engine\utility::get_target_array();

  foreach(var4 in var2) {
    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "door")) {
      var1.target_ent = var4;
      var1.target_ent = scripts\engine\utility::spawn_tag_origin(var4.origin, var4.angles);
    }

    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "guy")) {
      var1.enemy_target = var4;
    }
  }

  scripts\engine\utility::flag_wait("fob_player_in_center");
  scripts\engine\sp\utility::set_goal_radius(34);
  self.fixednode = 0;
  scripts\engine\utility::set_movement_speed(250);
  scripts\engine\sp\utility::set_goal_pos(var1.origin);
  self.ignoresuppression = 1;
  var6 = scripts\engine\sp\utility::spawn_targetname("farah_door_spawners");
  var6.health += 50;
  var6 scripts\engine\sp\utility::set_goal_radius(34);
  var6 scripts\engine\sp\utility::set_goal_pos(var1.enemy_target.origin);
  self setentitytarget(var1.target_ent, 1);
  self waittill("goal");

  if(isDefined(var6)) {
    var6 scripts\engine\utility::waittill_any_timeout(5, "death");
  }

  if(!isDefined(var6)) {
    wait 1;
  }

  destroynavobstacle(var0);
  scripts\engine\sp\utility::set_goal_radius(800);
  self clearentitytarget();
  self waittill("goal");
  scripts\engine\utility::set_movement_speed(180);
  self.ignoresuppression = 0;
}

function ally_movement_containers(var0) {
  scripts\engine\utility::flag_wait("fob_cleared");
  level endon("chu_exit");
  level.ally_volume = getEnt("fob_ally_exit_vol", "targetname");
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var3 = getEnt("armen", "script_noteworthy");
  scripts\engine\sp\utility::activate_trigger_with_targetname("armory_01_color_trigger");
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_pre_truck_color");

  if(!scripts\engine\utility::flag("armory_01_secure")) {
    level.allies = getaiarray("allies");

    foreach(var5 in level.allies) {
      if(scripts\engine\utility::is_equal(var5.targetname, "armory_02_guards")) {
        continue;
      }

      var5.fixednode = 1;

      if(isalive(var5) && isDefined(var5)) {
        var5 scripts\engine\utility::set_movement_speed(220);

        if(var5 == var3 || var5 == var2) {
          var5 scripts\engine\sp\utility::clear_force_color();
          var5 scripts\engine\sp\utility::set_force_color("c");
          continue;
        }

        if(var5 == var1) {
          var5 scripts\engine\sp\utility::clear_force_color();
          var5 scripts\engine\sp\utility::set_force_color("p");
          continue;
        }

        var5 scripts\engine\sp\utility::clear_force_color();
        var5 scripts\engine\sp\utility::set_force_color("r");
        var5.fixednode = 1;
      }
    }
  }

  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_pre_truck_color");
  level.allies = getaiarray("allies");

  foreach(var5 in level.allies) {
    if(scripts\engine\utility::is_equal(var5.targetname, "armory_02_guards")) {
      continue;
    }

    var5.fixednode = 1;

    if(isalive(var5) && isDefined(var5)) {
      var5 scripts\engine\utility::set_movement_speed(180);

      if(var5 == var1) {
        var5.fixednode = 1;
        var5 scripts\engine\sp\utility::clear_force_color();
        var5 scripts\engine\sp\utility::set_force_color("p");
        var5 setgoalpos(var5.origin);
        thread scene_gate_farah();
        continue;
      }

      if(var5 == var2) {
        var5 scripts\engine\sp\utility::clear_force_color();
        var5 scripts\engine\sp\utility::set_force_color("g");
        thread hadir_truck_entrance(var5);
        continue;
      }

      var5 scripts\engine\sp\utility::clear_force_color();
      var5 scripts\engine\sp\utility::set_force_color("r");
      var5.fixednode = 1;
    }
  }

  scripts\engine\utility::flag_wait("farah_gate_lookat");
  wait 4;
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_truck_color");
  var9 = scripts\engine\utility::getStruct("farah_gate_anim", "targetname");
  level.container_nodes = getnodearray("fobCHU_allyNode", "targetname");

  foreach(var11 in level.container_nodes) {
    if(!scripts\engine\utility::is_equal(var11.type, "Exposed")) {
      level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, var11);
    }
  }

  level.container_nodes = sortbydistance(level.container_nodes, (-40802, 34662, -620));
  level.allies = getaiarray("allies");
  level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, level.container_nodes[level.container_nodes.size - 1]);
  level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, level.container_nodes[level.container_nodes.size - 1]);
  level.allies = getaiarray("allies");
  level.allies = sortbydistance(level.allies, (-40802, 34662, -620));

  foreach(var5 in level.allies) {
    if(isalive(var5) && isDefined(var5)) {
      var14 = sortbydistance(level.container_nodes, var5.origin)[0];
      var5 scripts\engine\sp\utility::clear_force_color();
      var5 setgoalpos(var5.origin);
      var5 setgoalnode(var14);
      level.container_nodes = scripts\engine\utility::array_remove(level.container_nodes, var14);
      LOC_000003d2:
    }
    LOC_000003d2:
  }

  level.container_nodes = undefined;
  scripts\engine\utility::flag_wait("container_door_breached");
  wait 3;
  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_farah_hadir_00");
  level.ally_volume = getEnt("chu_main_vol", "targetname");
  var1 setgoalpos(var1.origin);
  var1 scripts\engine\sp\utility::clear_force_color();
  var1 scripts\engine\sp\utility::set_force_color("b");
  var2 scripts\engine\sp\utility::clear_force_color();
  var2 scripts\engine\sp\utility::set_force_color("b");
  level.allies = getaiarray("allies");
  var16 = container_getallypaths();

  foreach(var18 in level.allies) {
    if(var18 == var2 || var18 == var1) {
      continue;
    }

    wait 0.1;
    var18 scripts\common\utility::demeanor_override("combat");
    var18.old_color = var18.script_forcecolor;
    var18 scripts\engine\sp\utility::clear_force_color();
    thread fire_death();
    var19 = sortbydistance(var16, var18.origin)[0];
    thread charge_allypathlogic(var18, var19, 1);
    var16 = scripts\engine\utility::array_remove(var16, var19);
    var18 scripts\engine\utility::set_movement_speed(250);
    LOC_000004fd:
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_chopper_color_trigger");
  level.allies = getaiarray("allies");

  foreach(var18 in level.allies) {
    var18 scripts\engine\utility::set_movement_speed(250);
    var18.ignoreme = 1;
  }

  scripts\engine\utility::flag_wait("chu_strafe_run_go");
  wait 5;
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("chu_main_vol", "targetname");

  foreach(var5 in level.allies) {
    var5 notify("stop_going_to_node");

    if(isalive(var5) && isDefined(var5)) {
      var5.ignoreme = 0;
      var5 scripts\engine\utility::set_movement_speed(200);
      var5 scripts\engine\sp\utility::clear_force_color();
      var5 scripts\engine\sp\utility::set_goal_radius(250);
      var5.fixednode = 0;
      var5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
      LOC_00000611:
    }
    LOC_00000611:
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("containers_farah_hadir_01");
  scripts\engine\utility::flag_wait("chu_rear");
  level.allies = getaiarray("allies");
  level.ally_volume = getEnt("chu_rear_vol", "targetname");

  foreach(var5 in level.allies) {
    if(isalive(var5) && isDefined(var5)) {
      var5 setgoalpos(var5.origin);
      var5 scripts\engine\sp\utility::set_goal_radius(500);
      var5 scripts\engine\sp\utility::clear_force_color();
      var5.forcelongdeath = 1;
      var5 setgoalvolumeauto(level.ally_volume, anglesToForward((0, 180, 0)));
      var5.fixednode = 0;
    }
  }
}

function fire_death() {
  scripts\common\ai::magic_bullet_shield();

  if(self.model == "fsa_rebel_female_a" || self.model == "fsa_rebel_female_b" || self.model == "fsa_rebel_female_c") {
    return;
  }

  scripts\engine\utility::flag_wait_any("chu_strafe_run_go", "player_in_drone");
  level waittill("chu_fire_start");
  scripts\common\ai::stop_magic_bullet_shield();
  var0 = scripts\engine\utility::getStruct("fuel_trailer", "targetname");
  var1 = 400;

  if(var1 < distance(self.origin, var0.origin)) {
    return;
  }

  self._blackboard.isburning = 1;
  self.burningtodeath = 1;
  self.burningdirection = "left";
  self dodamage(10, self.origin, undefined, level.player, "MOD_FIRE", "molotov");
  thread molotov_burn_sfx();
  thread remove_blackboard_isburning(level);
}

function molotov_burn_sfx(var0) {
  if(isDefined(var0)) {
    var1 = 1;
  } else {
    var1 = 0.5;
  }

  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfxenabled = 1;
    wait var1;
    wait 0.15;

    if(isDefined(self.burnsfx)) {
      self.burnsfx delete();
      self.burnsfxenabled = 0;
      return;
    }

    return;
  }
}

function remove_blackboard_isburning(var0) {
  waitframe();

  if(!isDefined(var0)) {
    return;
  }

  var0._blackboard.isburning = undefined;
}

function scene_gate_farah() {
  var0 = spawnStruct();
  var0.origin = (-40865, 34544, -642);
  var0.angles = (0, -90, 0);
  var1 = getEnt("armory_01_trigger", "targetname");

  while(level.player istouching(var1)) {
    waitframe();
  }

  scripts\engine\utility::set_movement_speed(160);
  scripts\engine\utility::flag_wait("farah_gate_lookat");
  scripts\engine\sp\utility::clear_force_color();
  waitframe();
  var0 scripts\sp\anim::anim_reach_solo(self, "gate_pull");
  var0 thread scripts\common\anim::anim_single_solo(self, "gate_pull");
  level notify("farah_gate_pull");
  wait 5;
  level notify("farah_gate_anim");
  scripts\common\utility::demeanor_override("combat");
  scripts\engine\utility::set_movement_speed(200);
}

function fob_left_flank_init() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var2 = getaiarray("allies");
  var2 = scripts\engine\utility::array_remove(var2, var0);
  var2 = scripts\engine\utility::array_remove(var2, var1);
  var2 = scripts\engine\utility::array_remove(var2, level.armen);
  var2 = sortbydistance(var2, level.armen.origin);
  var2 = [level.armen, var2[0], var2[1]];

  foreach(var4 in var2) {
    var4.left_flank = 1;
  }

  return var2;
}

function hadir_truck_entrance(var0) {
  if(isDefined(var0)) {
    waitframe();
  }

  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\utility::set_movement_speed(220);
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\sp\utility::clear_force_color();
  var1 = scripts\engine\utility::getStruct("hadir_truck_enter_struct", "targetname");
  thread scripts\sp\spawner::go_to_node(var1);
  self waittill("goal");
  scripts\engine\utility::flag_set("hadir_at_truck");
}

function scene_truck_gate() {
  var0 = spawnStruct();
  var0.origin = (-40170, 34500, -650);
  var0.angles = (0, 0, 0);
  var1 = getEnt("airport_gate", "targetname");
  var1.clip = getEnt("airport_gate_clip", "targetname");
  var1.struct = var1 scripts\engine\utility::get_target_ent();
  var1.clip linkTo(var1);
  var1.animname = "gate";
  var2 = getEntArray("airport_gate_barbs", "targetname");

  foreach(var4 in var2) {
    var4 unlink();
  }

  var1 scripts\engine\sp\utility::assign_animtree();
  var6 = scripts\engine\sp\utility::spawn_anim_model("bent_gate", (0, 0, 0), (0, 0, 0));
  var7 = getspawnerarray("fob_guys_rear")[0];
  var7.count = 1;
  var7 = scripts\engine\sp\utility::bodyonlyspawn(var7);
  var7.animname = "body";
  var8 = [level.hadir, level.gate_truck, var7];
  var0 thread scripts\common\anim::anim_first_frame_solo(var1, "truck_smash");
  var0 thread scripts\common\anim::anim_first_frame_solo(var6, "truck_smash");
  var0 thread scripts\common\anim::anim_first_frame_solo(level.gate_truck, "truck_enter");
  var0 thread scripts\common\anim::anim_first_frame_solo(var7, "truck_enter");
  var1.clip unlink();
  level.hadir scripts\engine\utility::set_cautious_navigation(0);
  waitframe();
  scripts\engine\utility::flag_wait("farah_gate_lookat");
  wait 2;
  var0 scripts\sp\anim::anim_reach_solo(level.hadir, "truck_enter");
  var0 scripts\common\anim::anim_single(var8, "truck_enter");
  scripts\engine\utility::flag_set("hadir_in_truck");
  var9 = getEnt("truck_smash_clip", "targetname");
  var9 connectpaths();
  var10 = getEnt("truck_smash_trigger", "targetname");
  var10 enablelinkTo();
  var10 linkTo(var9);
  level.hadir.support_equipment_og = level.hadir.support_equipment;
  level.hadir.support_equipment = 0;
  level.gate_truck thread scripts\common\anim::anim_loop_solo(level.hadir, "truck_enter_idle", "stop_loop", "TAG_DRIVER");
  scripts\engine\utility::flag_wait("hadir_ramming_dialogue_complete");
  level.gate_truck thread scripts\engine\sp\utility::play_sound_on_entity("scn_safehouse_gate_smash_engine_01");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_taillight_umike_left_container"), level.gate_truck, "tag_light_back_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_taillight_umike_right_container"), level.gate_truck, "tag_light_back_right");
  wait 2;
  thread truck_smash_watcher();
  level.hadir linkTo(level.gate_truck, "TAG_DRIVER");
  var8 = [var1, level.gate_truck, var6, var1];
  var0 thread scripts\common\anim::anim_single(var8, "truck_smash");
  level waittill("gate_down");
  var1.clip linkTo(var6);

  foreach(var4 in var2) {
    var4 linkTo(var6);
  }

  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_gate_smash_impact", var1.origin);
  level.gate_truck thread scripts\engine\sp\utility::play_sound_on_entity("scn_safehouse_gate_smash_engine_02");
  var6 thread scripts\engine\sp\utility::play_sound_on_entity("scn_safehouse_gate_smash_push");
  var1.clip connectpaths();
  level.gate_truck waittillmatch("single anim", "end");
  var9 disconnectPaths();
  level.gate_truck notify("stop_loop");
  level.gate_truck thread scripts\common\anim::anim_single_solo(level.gate_truck, "truck_exit");
  level.gate_truck scripts\common\anim::anim_single_solo(level.hadir, "truck_exit", "TAG_DRIVER");
  level.hadir.support_equipment = level.hadir.support_equipment_og;
  level.hadir unlink();
  level.hadir scripts\engine\sp\utility::clear_force_color();
  level.hadir scripts\engine\sp\utility::set_force_color("b");
  var1.clip delete();
  var1 delete();
}

function truck_smash_watcher() {
  wait 1;
  level.gate_truck endon("stop_loop");

  while(!level.player istouching(self)) {
    waitframe();
  }

  level.player kill();
}

function fob_getallyentrancevolume() {
  return getEnt("fob_ally_entrance_vol", "targetname");
}

function enemy_fob_movement() {
  level.enemy_goal_volume = undefined;
}

function enemies_cleared_move_forward(var0) {
  level endon("fob_center");

  while(var0.size > 2) {
    var0 = scripts\engine\utility::array_removedead_or_dying(var0);
    wait 0.1;
  }

  scripts\engine\utility::flag_set_delayed("bunkers_push", 2);
}

function fob_enemies_rear() {
  var0 = getaiarray("axis", "allies");
  var1 = 25 - var0.size;
  var2 = getspawnerarray("fob_guys_rear");
  var3 = getEnt("fob_rear_vol", "targetname");

  for(var4 = 0; var4 < var1; var4++) {
    var0 = getaiarray("axis", "allies");
    var1 = 22 - var0.size;

    if(var1 <= 0) {
      return;
    }

    var5 = var2[0] scripts\engine\sp\utility::spawn_ai(1);
    var2[0].count = 1;
    waitframe();
  }
}

function fob_center_start() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  thread explode_tarmac_scriptables();
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_deletepristinetargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale::rocket_showdamagedtargets();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
  scripts\engine\utility::flag_set("fly_attack_done");
  scripts\engine\utility::flag_set("fob_center");
  scripts\engine\utility::flag_set("enter_bunkers");
  scripts\engine\utility::flag_set("bunkers_breached");
  scripts\engine\sp\utility::set_start_location("fob_center_start", [level.player]);
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(7);
  var4 = charge_setalliestoredshirts();
  var5 = bunker_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var4, [var0, var1, var2]);

  foreach(var7 in level.allies) {
    var8 = scripts\engine\utility::random(var5);
    var7 scripts\engine\sp\utility::teleport_ai(var8);
    var5 = scripts\engine\utility::array_remove(var5, var8);
  }

  thread armory_01();
  thread ally_fob_movement();
  thread chu_bad_places();
  var10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var10, &delete);
  scripts\engine\utility::flag_set("fob_center_entrance");
  scripts\engine\utility::flag_set("finished_bunker_vo");
}

function fob_center_main() {
  thread rooftop_director_03();
  thread hide_armory_guns();
  thread door_gag_door_watcher();
  var0 = getEntArray("door_gag_trigger", "targetname");
  scripts\engine\utility::array_thread(var0, &door_gags);
  scripts\engine\utility::flag_wait_any("fob_center", "bunkers_push");
  var1 = spawn_check_func(31, "fob_guys_center_containers", 3);
  goal_ent_position(600, var1, "mid_goal_spots");
  thread directing_02(var1);
  var2 = spawn_check_func(32, "fob_guys_center_pit", 2);
  waitframe();
  var1 = spawn_check_func(31, "fob_guys_center_containers", 3);
  goal_ent_player(1200, var2);
  level thread scripts\engine\sp\utility::notify_delay("sfx_airbase_siren_stop", 15);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var4 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  thread redshirt_refill();
  thread fob_spawn_manager();
  thread dialogue_fob_center();
  thread favela_door_guy();
  scripts\engine\utility::flag_wait("finished_fob_center_vo");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::player_startallowdrones();
  scripts\engine\utility::flag_wait("fob_player_in_center");
  thread fob_center_autosave(getEnt("fob_autosave_left", "targetname"));
  thread fob_center_autosave(getEnt("fob_autosave_right", "targetname"));
  var5 = scripts\engine\utility::getStruct("charge_distance_struct", "targetname");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::remove_corpses_away_from_player_pos(800);
  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");
  thread enemy_info();
  scripts\engine\sp\utility::autosave_by_name("fob_center_entrance");
  scripts\engine\utility::flag_wait("fob_rear");
  thread ally_drone_attack(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::remove_corpses_away_from_player_pos(1200);
  thread enemy_info();
  scripts\engine\sp\utility::autosave_by_name("fob_rear");
  scripts\engine\utility::flag_wait("fob_exit");
  thread enemy_info();
  thread kill_fob_ladders();
  scripts\engine\sp\utility::autosave_by_name("fob_exit");
  scripts\engine\utility::flag_wait("fob_cleared");
  level notify("drone_allowed");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::player_pauseallowdrones();
}

function vo_fob_center_snipers() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_far_tarmac_snipers_10");
}

function fob_center_autosave(var0) {
  level endon("fob_cleared");
  var0 waittill("trigger");
  scripts\engine\sp\utility::autosave_now();
}

function hide_armory_guns() {
  wait 0.1;
  var0 = getEntArray("fob_weapons_01", "targetname");
  scripts\engine\utility::array_call(var0, &hide);
  scripts\engine\utility::flag_wait("fob_exit_guards");

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      var2 show();
    }
  }
}

function door_gag_door_watcher() {
  wait 0.5;
  level endon("door_gag_go");
  var0 = undefined;
  var1 = getscriptablearray();

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.targetname, "shooting_door_door")) {
      var0 = var3;
    }
  }

  if(isDefined(var0)) {
    var0 waittill("damage");
    scripts\engine\utility::flag_set("door_gag_door_damaged");
    return;
  }
}

function rooftop_director_03() {
  waitframe();
  var0 = scripts\engine\utility::getStruct("general_03_struct", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("general_guy_right", 1);

  if(!isDefined(var1)) {
    return;
  }

  var1 endon("death");
  thread damage_breakout_of_anim();
  var1.ignoreall = 1;
  var1.ignoreme = 1;
  var1.allowdeath = 1;
  var1.animname = "enemy_01";
  var0 scripts\sp\anim::anim_reach_solo(var1, "directing_01");
  var0 scripts\common\anim::anim_single_solo(var1, "directing_01");
  var1 notify("anim_done");
}

function damage_breakout_of_anim() {
  self endon("death");
  scripts\engine\utility::waittill_any("damage", "anim_done");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self stopanimScripted();
  self setgoalpos(self.origin);
  self.goalheight = 72;
  scripts\engine\sp\utility::set_goal_radius(200);
}

function directing_02(var0) {
  var1 = var0[0];
  var2 = var0[1];
  var3 = var0[2];
  waitframe();
  var1 endon("death");
  var4 = scripts\engine\utility::getStruct("directing_02", "targetname");
  var1.animname = "enemy_02";
  var1.allowdeath = 1;
  var1.ignoreme = 1;
  var2.ignoreme = 1;
  var3.ignoreme = 1;
  var4 thread scripts\common\anim::anim_first_frame_solo(var1, "directing_02");
  waitframe();
  var5 = [var2, var3];

  foreach(var7 in var5) {
    var7 forceteleport(var1.origin, var1.angles);
    var7 setgoalpos(var7.origin);
    var7 scripts\engine\sp\utility::set_goal_radius(20);
  }

  scripts\engine\utility::flag_wait("fob_center_entrance");
  var4 thread scripts\common\anim::anim_single_solo(var1, "directing_02");
  thread ai_after_animation();
  wait 0.25;

  foreach(var7 in var5) {
    if(isalive(var7)) {
      var10 = -200;

      if(var11 == 1) {
        var10 = -300;
      }

      var7 setgoalpos(var7.origin + (-50, var10, 50));
      var7 scripts\engine\sp\utility::set_goal_radius(64);
      var7.ignoreme = 0;
      var7 scripts\engine\sp\utility::set_ignoresuppression(1);
      var7 getenemyinfo(level.farah);
    }
  }

  wait 4;
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  goal_ent_player(1000, var0);
}

function ai_after_animation() {
  self waittillmatch("single anim", "end");

  if(isalive(self)) {
    self setgoalpos(self.origin + (0, 0, 0));
    scripts\engine\sp\utility::set_goal_radius(10);
    self.ignoreme = 0;
    return;
  }
}

function directing_01(var0) {
  var1 = var0[0];
  var2 = var0[1];
  waitframe();
  var3 = scripts\engine\utility::getStruct("directing_01", "targetname");
  var1.animname = "enemy_01";
  var1.allowdeath = 1;
  var1.ignoreme = 1;
  var2.ignoreme = 1;
  var3 thread scripts\common\anim::anim_first_frame_solo(var1, "directing_01");
  waitframe();
  var2 forceteleport(var1.origin, var1.angles);
  var2 setgoalpos(var2.origin);
  var2 scripts\engine\sp\utility::set_goal_radius(20);
  scripts\engine\utility::flag_wait("fob_center_entrance");
  var3 thread scripts\common\anim::anim_single_solo(var1, "directing_01");
  thread ai_after_animation();
  wait 2;

  if(isalive(var2)) {
    var2 setgoalpos((-42252, 33044, -608));
    var2 scripts\engine\sp\utility::set_goal_radius(64);
    var2.ignoreme = 0;
    var2 scripts\engine\sp\utility::set_ignoresuppression(1);
    var2 getenemyinfo(level.player);
  }

  wait 4;
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  goal_ent_player(1000, var0);
}

function favela_door_guy() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("favela_door", "targetname")[0];
  var0.script_destructible = 1;
  var0.clip = var0 scripts\engine\utility::get_linked_ent();
  var0.clip linkTo(var0);
  level.favela_door = var0;
  var0.animname = "door_scriptable";
  var0 scripts\engine\sp\utility::assign_animtree();
  scripts\engine\utility::flag_wait("fob_rear");
  var1 = scripts\engine\sp\utility::spawn_targetname("favela_door_guy", 1);
  var1.animname = "generic";
  var1.forceragdollimmediate = 1;
  var1.allowdeath = 1;
  favela_door_open_loop(var0, var1);
  var0 notify("stop_loop");
  var0 stopanimScripted();
  var0 setflaggedanim("single anim", var0 scripts\engine\utility::getanim("faveladoor_fastopen"), 1);
  var0.clip connectpaths();

  if(isDefined(var1)) {
    var1 stopanimScripted();
    var1 setgoalpos(var1.origin);
    var1 scripts\engine\sp\utility::set_goal_radius(10);
  }

  wait 4;

  if(isDefined(var1)) {
    var1 setgoalentity(level.player);
    var1 scripts\engine\sp\utility::set_goal_radius(800);
    return;
  }
}

function favela_door_open_loop(var0, var1) {
  var1 endon("death");
  var1 endon("breakout");
  var2 = var0 scripts\engine\utility::getanim("faveladoor_fire1");
  var3 = getanimlength(var2);
  thread favela_door_guy_anims(var1, var0);
  var0 setflaggedanim("single anim", var2, 1);
  wait var3;

  if(scripts\engine\utility::flag("favella_end_flag")) {
    return;
  }

  if(scripts\engine\utility::flag("favella_end_flag")) {
    return;
  }
}

function favela_door_guy_anims(var0, var1) {
  self endon("death");
  var0 scripts\common\anim::anim_single_solo(self, "faveladoor_fire1");
  var0 thread scripts\common\anim::anim_loop_solo(self, "faveladoor_idle", "stop_loop");
  wait 1;
  var0 notify("stop_loop");
  waitframe();
}

function door_gags() {
  level endon("fob_rear_trucks");
  var0 = scripts\engine\utility::get_target_array();
  self.position_struct = undefined;
  self.spawner = getspawner(self.target, "targetname");
  self.door_ent = undefined;

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "door")) {
      self.door_ent = var2;
      self.door_ent = scripts\engine\utility::spawn_tag_origin(var2.origin + (0, 0, 10), var2.angles);
    }

    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "position")) {
      self.position_struct = var2;
    }
  }

  self waittill("trigger");

  if(scripts\engine\utility::flag("door_gag_door_damaged")) {
    return;
  }

  level notify("door_gag_go");
  var4 = self.spawner scripts\engine\sp\utility::spawn_ai(1);
  var4.targetname = "door_gag_guy";
  var4 endon("death");
  var4 scripts\engine\sp\utility::set_goal_radius(32);
  var4 scripts\engine\sp\utility::set_goal_pos(var4.origin);
  var4 setentitytarget(self.door_ent, 1);
  thread door_ent_movement(var4);
  wait 3;
  var4 clearentitytarget();
  var4 getenemyinfo(level.player);
  var4 setgoalentity(level.player);
  var4 scripts\engine\sp\utility::set_goal_radius(100);
}

function door_ent_movement(var0) {
  var1 = 3;
  var0 endon("death");
  self.door_ent.origin += (0, 0, -20);
  self.door_ent moveTo(self.origin + (5, 5, 20), var1);
  thread door_gag_magic_bullet(var0);
  wait var1;
  self notify("magic_done");
}

function door_gag_magic_bullet(var0) {
  self endon("magic_done");
  var0 endon("death");
  var0 endon("damage");

  for(;;) {
    var1 = var0 gettagorigin("tag_flash");
    magicbullet("iw8_lm_pkilo", var1, self.door_ent.origin);
    wait 0.1;
  }
}

function enemy_info() {
  var0 = getaiarray("allies");
  var1 = getaiarray("axis");
  scripts\engine\utility::array_thread(var0, &get_enemy_info_all, "axis");
  scripts\engine\utility::array_thread(var0, &get_enemy_info_all, "allies");
}

function get_enemy_info_all(var0) {
  self endon("death");
  var1 = getaiarray(var0);

  foreach(var3 in var1) {
    if(isDefined(var3)) {
      self getenemyinfo(var3);
    }
  }
}

function kill_fob_ladders() {
  var0 = getEntArray("ladder_nav_kill", "targetname");

  foreach(var2 in var0) {
    createnavbadplacebyent(var2, "allies", "axis");
  }
}

function init_chopper_lights() {
  var0 = getEnt("cockpit_light_01", "targetname");
  var0 setlightintensity(0);
  var0 = getEnt("cockpit_light_02", "targetname");
  var0 setlightintensity(0);
  var0 = getEnt("cockpit_light_03", "targetname");
  var0 setlightintensity(0);
}

function init_ending_lights() {
  var0 = getEntArray("ending_character_lights", "targetname");

  foreach(var2 in var0) {
    var2.origin_intensity = var2 getlightintensity();
    var2 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("killstreak_complete");
  scripts\engine\utility::exploder("end_scene_fx");

  foreach(var2 in var0) {
    var2 setlightintensity(var2.origin_intensity);
  }
}

function init_towers() {
  while(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    waitframe();
  }

  scripts\engine\utility::flag_wait("scriptables_ready");
  var0 = getscriptablearray("guard_tower", "script_noteworthy");
  var1 = (-43000.5, 29836, -340);
  var2 = scripts\engine\utility::spawn_tag_origin(var1, (0, 0, 0));
  level.tarmac_tower = sortbydistance(var0, var2.origin)[0];

  foreach(var4 in var0) {
    var5 = var4 scripts\engine\sp\utility::get_linked_struct();
    var4.nodes = getnodearray(var5.target, "targetname");
    var4.glass = getglassarray(var5.target);
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

function guard_tower_logic() {
  var0 = scripts\engine\sp\utility::get_spawner_array("tower_spawner", "script_noteworthy");
  var0 = sortbydistance(var0, self.origin);
  var0[0].count = 1;

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(isDefined(var5) && isexplosivedamagemod(var5) && var1 > 100) {
      var11 = 0;

      if(isDefined(var4) && var4[2] - self.origin[2] < 215) {
        var11 = 1;
      }

      if(var11) {
        var12 = "collapsed";
      } else {
        var12 = "exploded";
      }

      var1[0].count = 0;
      self.brushmodel delete();

      foreach(var14 in self.glass) {
        destroyglass(var14);
      }

      self setscriptablepartstate("base", var12, 1);
      thread scripts\engine\utility::play_sound_in_space("scn_safehouse_hellcannon_impact_debris", self.origin);
      level notify("tower_collapse");

      if(self == level.tarmac_tower) {
        level.tarmac_tower.collapsed = 1;
      }

      foreach(var17 in getaiarray()) {
        if(var17 istouching(self.trigger)) {
          if(isDefined(var17.magic_bullet_shield)) {
            continue;
          }

          var17.ragdoll_immediate = 1;
          var17 dodamage(500, var17.origin, undefined, undefined, "MOD_CRUSH");
        }
      }

      self.trigger delete();

      foreach(var20 in self.nodes) {
        var20 disconnectnode();
        destroynavlink(var20);
      }

      return;
    }
  }
}

function fob_spawn_manager() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  thread tromeo_entrance_01();
  transport_bravo_spawn();
  gunner_bravo_spawn();
  thread close_airport_gate();
  thread fob_umike_03();
  thread tromeo_entrance_03();
  tower_spawner_logic("tower_guy_fob_02", 3);
  thread vo_fob_center_snipers();
  scripts\engine\utility::flag_wait("fob_center_entrance");
  level scripts\engine\utility::waittill_any_timeout(15, "fob_player_in_center", "player_in_drone");
  waitframe();
  var2 = spawn_check_func(31, "fob_guys_center_tower");
  thread rooftop_directoring(var2);
  scripts\engine\utility::flag_wait("fob_player_in_center");
  waitframe();
  var3 = spawn_check_func(31, "fob_guys_center_containers", 5);
  goal_ent_position(600, var3, "mid_goal_spots");
  wait 1;
  scripts\engine\utility::flag_wait("fob_player_in_center_swarm");
  var4 = [level.farah, level.hadir];

  foreach(var6 in var4) {
    var6 setthreatbiasgroup("shielded");
  }

  var8 = [];
  GscBinSkip0(0x2e, var8.size, tower_spawner_logic("tower_guy_fob"), level);
}

function tower_guy_cleanup() {}

function rooftop_directoring(var0) {
  if(var0.size < 1) {
    return;
  }

  var1 = 0.85;
  var2 = scripts\engine\utility::getStruct("general_01_struct", "targetname");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);
  var3 = sortbydistance(var0, var2.origin)[0];

  if(!isDefined(var3)) {
    return;
  }

  var3 endon("death");
  var3 endon("break_out");
  wait 0.1;

  if(!isalive(var3)) {
    return;
  }

  var3.target = undefined;
  var3 clearpath();
  var3.allowdeath = 1;
  var3.animname = "enemy_03";
  var2 scripts\sp\anim::anim_reach_solo(var3, "directing_03");
  var3 setgoalpos(var3.origin);
  var3 scripts\engine\sp\utility::set_goal_radius(2);

  for(;;) {
    if(1200 > distance(level.player.origin, var3.origin)) {
      break;
    }

    if(level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var3.origin, var1)) {
      break;
    }

    waitframe();
  }

  thread directing_breakout();
  var2 scripts\common\anim::anim_single_solo(var3, "directing_03");
  var3 notify("breakout");
}

function directing_breakout() {
  self endon("death");
  scripts\engine\utility::waittill_any("damage", "breakout");
  self notify("breakout");

  if(!scripts\engine\utility::flag("fob_spawns_complete")) {
    return;
  }
}

function tower_spawner_logic(var0, var1) {
  if(isDefined(var1)) {
    wait var1;
  }

  var2 = getspawner(var0, "targetname");

  if(var2.count == 0) {
    return;
  }

  var3 = scripts\engine\sp\utility::spawn_targetname(var0);
  var3.forceragdollimmediate = 1;
  var3 allowedstances("stand");
  var3 scripts\engine\sp\utility::set_goal_radius(64);
  thread ally_drone_attack();
  var2 = getspawner(var0, "targetname");
  var2.count = 1;
  return var3;
}

function ally_drone_attack(var0) {
  self endon("death");
  level endon("fob_cleared");
  var1 = "fob_allyDroneStartNode_t1";

  if(scripts\engine\utility::is_equal(self.targetname, "tower_guy_fob_02")) {
    var1 = "fob_allyDroneStartNode_t2";
  }

  if(level.tower_drone_target) {
    return;
  }

  var2 = level.player getEye();
  var3 = 0.9998;
  jumpiffalse(isDefined(var0)) LOC_00000056;
  var1 = "fob_allyDroneStartNode_t3";

  while(!scripts\engine\utility::flag("kill_tower_snipers")) {
    if(isDefined(var0)) {
      break;
    }

    var4 = distance(level.player.origin, self.origin);

    if(var4 < 1000) {
      if(level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var3)) {
        break;
      }
    }

    waitframe();
  }

  if(level.tower_drone_target) {
    return;
  }

  if(scripts\engine\utility::is_equal(self.targetname, "tower_guy_fob_02")) {
    var1 = "fob_allyDroneStartNode_t2";
    wait 1;
  }

  var5 = getvehiclenode(var1, "targetname");
  var6 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::level_dronespawnVehicle(var5.origin, var5.angles);
  var6.maxhealth = 30000;
  thread scripts\sp\maps\safehouse_finale\safehouse_finale::fly_allydronepathlogic(var6, var5);
}

function player_weapon_class() {
  var0 = weaponclass(level.player getcurrentweapon());

  if(var0 == "rifle" || var0 == "smg" || var0 == "mg" || var0 == "spread") {
    return 0;
  }

  return 1;
}

function spawn_printer() {
  for(;;) {
    if(scripts\engine\utility::flag("ai_spawner_busy")) {
      waitframe();
    }
  }
}

function goal_ent_player(var0, var1) {
  var2 = getaiarray("axis");

  if(isDefined(var1)) {
    var2 = var1;
  }

  foreach(var4 in var2) {
    if(scripts\engine\utility::is_equal(var4.targetname, "fob_guys_center_tower") || scripts\engine\utility::is_equal(var4.targetname, "fob_guys_exit") || scripts\engine\utility::is_equal(var4.targetname, "fob_guys_exit_guards") || scripts\engine\utility::is_equal(var4.targetname, "armory_guards") || scripts\engine\utility::is_equal(var4.targetname, "door_bust_guy") || scripts\engine\utility::is_equal(var4.script_noteworthy, "tower_spawner")) {
      continue;
    }

    if(isDefined(var4)) {
      var4 setgoalpos(var4.origin);
      var4 scripts\engine\sp\utility::set_goal_radius(var0);
      var4 setgoalentity(level.player);
    }
  }
}

function goal_ent_position(var0, var1, var2, var3) {
  var4 = scripts\engine\utility::getStructArray(var2, "targetname");
  var4 = sortbydistance(var4, level.player.origin);
  var5 = getaiarray("axis");

  if(!isDefined(var1)) {
    return;
  }

  if(isstring(var1)) {
    var5 = var1;
  }

  foreach(var7 in var5) {
    if(isDefined(var3)) {
      wait var3;
    }

    if(scripts\engine\utility::is_equal(var7.targetname, "fob_guys_center_tower") || scripts\engine\utility::is_equal(var7.targetname, "fob_guys_exit") || scripts\engine\utility::is_equal(var7.targetname, "fob_guys_exit_guards") || scripts\engine\utility::is_equal(var7.targetname, "armory_guards") || scripts\engine\utility::is_equal(var7.script_noteworthy, "tower_spawner")) {
      continue;
    }

    if(isDefined(var7)) {
      var7 setgoalpos(var4[0].origin + (0, 0, 0));
      var7 scripts\engine\sp\utility::set_goal_radius(var0);
    }
  }
}

function armory_01_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(4);
  var4 = charge_setalliestoredshirts();
  var5 = fobchu_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var4, [var0, var1, var2]);

  foreach(var7 in level.allies) {
    var8 = scripts\engine\utility::random(var5);
    var7 scripts\engine\sp\utility::teleport_ai(var8);
    var5 = scripts\engine\utility::array_remove(var5, var8);
  }

  thread redshirt_refill();
  thread close_airport_gate(1);
  var10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var10, &delete);
  thread fob_umike_03(1);
  thread armory_01();
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::player_startallowdrones();
}

function armory_01_main() {
  thread ally_movement_containers();
  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\sp\utility::autosave_now();
  scripts\engine\utility::flag_wait("armory_dialogue_complete");
  scripts\engine\utility::flag_wait("ally_fob_movement_complete");
}

function armory_01_catchup() {
  scripts\engine\utility::flag_set("armory_01_trigger");
  scripts\engine\utility::flag_set("armory_01_secure");
  scripts\engine\utility::flag_set("fob_cleared");
}

function containers_gate_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("fobCHU_start", [level.player, var0, var1]);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(5);
  var4 = charge_setalliestoredshirts();
  var5 = fobchu_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var4, [var2]);

  foreach(var7 in level.allies) {
    var8 = scripts\engine\utility::random(var5);
    var7 scripts\engine\sp\utility::teleport_ai(var8);
    var5 = scripts\engine\utility::array_remove(var5, var8);
  }

  thread redshirt_refill();
  thread close_airport_gate(1);
  var10 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var10, &delete);
  level.gate_truck = scripts\engine\sp\utility::spawn_anim_model("gate_truck");
  level.containers_start = 1;
  thread ally_movement_containers();
}

function containers_gate_main() {
  scripts\engine\utility::flag_wait("fob_exit");
  thread dialogue_containers_gate();
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  scripts\engine\utility::flag_wait("hadir_at_truck");
  thread magic_clip_fix();
}

function magic_clip_fix() {
  var0 = getEnt("rc_door", "targetname");
  var0.clip = var0 scripts\engine\utility::get_target_ent();
  var0.clip unlink();
  var0.clip.origin = (-41310, 33727, -471);
  var0.clip.angles = (0, 0, 0);
}

function containers_truck_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnarmen();
  scripts\engine\sp\utility::set_start_location("fobCHU_start", [level.player, var0]);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(5);
  var4 = charge_setalliestoredshirts();
  var5 = fobchu_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var4, [var2]);

  foreach(var7 in level.allies) {
    var8 = scripts\engine\utility::random(var5);
    var7 scripts\engine\sp\utility::teleport_ai(var8);
    var5 = scripts\engine\utility::array_remove(var5, var8);
  }

  thread ally_movement_containers(1);
  thread redshirt_refill();
  thread close_airport_gate(1);
  level.gate_truck = scripts\engine\sp\utility::spawn_anim_model("gate_truck");
  var10 = scripts\engine\utility::getStruct("hadir_truck_enter_struct", "targetname");
  var1 forceteleport(var10.origin, var10.angles);
  var11 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var11, &delete);
}

function containers_truck_main() {
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::ai_getaliveaiarray("axis");
  scripts\engine\sp\utility::array_kill(var0);
  scripts\engine\utility::flag_set("container_door_breached");
  wait 1;
  scripts\common\vehicle::spawn_vehicle_from_targetname("chu_chopper");
  scripts\engine\utility::flag_wait("strafe_setup");

  if(isDefined(level.chu_chopper)) {
    level.chu_chopper scalevolume(0, 0);
  }

  level.drone_start_position = spawnStruct();
  level.drone_start_position.origin = (-40153, 35374, -124);
  level.drone_start_position.angles = (5, 230, 0);
  thread scripts\sp\analytics::analytics_kleenex_update("Bunkers to Containers");
  scripts\engine\utility::flag_wait("chu_strafe_run_go");
  thread fob_enemies_chu();
  scripts\engine\sp\utility::autosave_by_name("chu_strafe_run");

  if(isDefined(level.chu_chopper)) {
    level.chu_chopper scalevolume(1, 2);
  }

  scripts\engine\utility::flag_wait("chu_entrance");
  level.drone_start_position = spawnStruct();
  level.drone_start_position.origin = (-41431, 35377, 38);
  level.drone_start_position.angles = (5, 259, 0);
  scripts\engine\sp\utility::autosave_by_name("chu_entrance");
  scripts\engine\utility::flag_wait("chu_rear");
  scripts\engine\sp\utility::autosave_by_name("chu_rear");
  var1 = spawn_check_func(32, "fob_guys_chu_rear");
  thread chu_guys_alive_check();
  scripts\engine\utility::flag_wait("chu_exit");
  scripts\engine\sp\utility::autosave_by_name("chu_exit");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::remove_corpses_away_from_player_pos(1200);
}

function containers_truck_catchup() {
  scripts\engine\utility::flag_set("hadir_ramming_dialogue_complete");
  scripts\engine\utility::flag_set("farah_gate_lookat");
  scripts\engine\utility::flag_set("container_door_breached");
}

function door_bust_scene() {
  level endon("clear_door_bust");
  var0 = scripts\engine\sp\utility::spawn_targetname("door_bust_guy", 1);
  var0 endon("death");
  level.door_bust_guy = var0;
  var0.animname = "enemy_01";
  var0 scripts\engine\sp\utility::set_deathanim("door_bust_death");
  var0.allowdeath = 1;
  var1 = scripts\engine\utility::getStruct("door_bust_struct", "targetname");
  var1 scripts\sp\anim::anim_reach_solo(var0, "door_bust");
  var0 thread scripts\common\ai::magic_bullet_shield();
  var0 setgoalpos(var0.origin);
  var0 scripts\engine\sp\utility::set_goal_radius(10);
  var0.ignoreall = 1;
  var2 = getscriptablearray("door_bust_door", "targetname")[0];
  var2.script_destructible = 1;
  var2.animname = "door_scriptable";
  var2 scripts\engine\sp\utility::assign_animtree();
  var2.clip = var2 scripts\engine\utility::get_linked_ent();
  var2.clip linkTo(var2);
  var0 endon("entitydeleted");
  scripts\engine\utility::flag_wait_any("door_bust_go", "door_bust_behind");
  var1 scripts\sp\anim::anim_reach_solo(var0, "door_bust");
  var0 thread scripts\common\ai::stop_magic_bullet_shield();
  var0.ignoreall = 0;
  var0 scripts\engine\sp\utility::set_goal_radius(256);
  var1 thread scripts\common\anim::anim_single_solo(var0, "door_bust");
  var2 setflaggedanim("single anim", var2 scripts\engine\utility::getanim("door_bust"), 1);
  var2.clip connectpaths();
  wait 1;

  if(scripts\engine\utility::flag("door_bust_behind")) {
    var3 = scripts\engine\sp\utility::spawn_targetname("door_bust_ally", 1);
    var3 scripts\engine\sp\utility::set_force_color("r");
    var3.health = 1;
    return;
  }

  wait 1;
  var1 stopanimScripted();
}

function vo_walla_truck_gate_charge() {
  wait 1.5;
  var0 = spawn("script_origin", level.armen.origin);
  var0 linkTo(level.armen);
  var0 playSound("sh_walla_finale_ram_gate_charge", "sounddone");
  var0 waittill("sounddone");
  var0 delete();
}

function nav_bad_place_truck_path() {
  var0 = getEnt("gate_truck_reverse_trigger", "targetname");
  var1 = createnavbadplacebyent(var0, "allies");
  scripts\engine\utility::flag_wait("container_door_breached");
  destroynavobstacle(var1);
}

function player_clear_of_truck_watcher() {
  scripts\engine\utility::flag_wait("hadir_in_truck");
  var0 = getEnt("gate_truck_reverse_trigger", "targetname");
  var1 = getEnt("armory_01_trigger", "targetname");
  var2 = 0;

  while(level.player istouching(var0) || level.player istouching(var1)) {
    if(!var2) {
      var2 = 1;
    }

    waitframe();
  }

  wait 2;
  scripts\engine\utility::flag_set("hadir_gate_smash");
  scripts\engine\utility::flag_set("hadir_gate_smash_stop");
}

function player_clear_truck_nag(var0) {
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  level endon("hadir_gate_smash");

  for(;;) {
    wait 5;

    if(level.player istouching(var0)) {
      var1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::dialogue("Alex, I'm going to hit the gate with the truck.");
    }

    wait 8;
  }
}

function player_clear_armory_nag(var0) {
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  level endon("hadir_gate_smash");

  for(;;) {
    if(level.player istouching(var0)) {
      var1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::dialogue("Get what you need and get back out here, Alex.");
    }

    wait 15;

    if(level.player istouching(var0)) {
      var1 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::dialogue("Alex, I'm going to hit the gate with the truck.");
    }

    wait 10;
  }
}

function chu_guys_alive_check() {
  while(!scripts\engine\utility::flag("chu_exit")) {
    var0 = getaiarray("axis");

    if(var0.size < 2) {
      scripts\engine\utility::flag_set("chu_exit");
    }

    waitframe();
  }
}

function close_airport_gate(var0) {
  thread airport_gate_trigger(var0);

  if(!isDefined(var0)) {
    while(!scripts\engine\utility::flag("fob_exit") && level.airport_gate_open) {
      waitframe();
    }
  }

  var1 = 2;

  if(isDefined(var0)) {
    var1 = 0.1;
  }

  var2 = getEnt("airport_gate", "targetname");
  var2.clip = getEnt("airport_gate_clip", "targetname");
  var2.struct = var2 scripts\engine\utility::get_target_ent();
  var2.clip linkTo(var2);
  var3 = getEntArray("airport_gate_barbs", "targetname");

  foreach(var5 in var3) {
    var5.origin = (var2.origin[0], var5.origin[1], var5.origin[2]);
    var5 linkTo(var2);
  }

  level notify("airport_gate_closed");
  var2 moveTo(var2.struct.origin, var1);
  wait var1 + 0.1;
  var2.clip disconnectPaths();
}

function airport_gate_trigger(var0) {
  if(isDefined(var0)) {
    return;
  }

  level endon("chu_entrance");

  while(!isDefined(level.fob_umike_03)) {
    waitframe();
  }

  level.fob_umike_03 endon("entitydeleted");
  var1 = getEnt("gate_truck_trigger", "targetname");

  while(!level.fob_umike_03 istouching(var1)) {
    waitframe();
  }

  level.airport_gate_open = 0;
}

function chu_explosion() {
  var0 = scripts\engine\utility::getStruct("fuel_trailer", "targetname");
  var1 = scripts\engine\utility::getStruct("fuel_tank_struct", "targetname");
  wait 1.5;
  scripts\engine\utility::flag_set("chu_fire_lights");
  scripts\engine\utility::exploder("explo_02");
  thread explosion_and_fire_sounds();
  level notify("chu_fire_start");
  radiusdamage(var0.origin, 200, 500, 100);
  createnavbadplacebybounds(var0.origin, (150, 150, 50), var0.angles, "allies");
}

function explosion_and_fire_sounds() {
  thread scripts\engine\utility::play_sound_in_space("weap_hellfire_impact", (-41495, 33496, -560));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_large_metal_lp_02", (-41442, 33589, -569));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_metal_car_lp_01", (-41297, 33886, -605));
  thread scripts\engine\utility::play_loopsound_in_space("emt_fire_small_lp_04", (-41355, 33755, -605));
}

function fob_enemies_chu() {
  var0 = spawn_check_func(32, "fob_guys_chu_strafe");

  foreach(var2 in var0) {
    var2.baseaccuracy = 0.1;
    var2.ignoreme = 1;
  }

  scripts\engine\utility::flag_wait("chu_entrance");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);

  foreach(var2 in var0) {
    var2.baseaccuracy = 0.2;
    var2.ignoreme = 0;
  }

  var6 = getEnt("fob_chu_vol", "targetname");
  var7 = spawn_check_func(32, "fob_guys_chu");

  foreach(var2 in var7) {
    var2 getenemyinfo(level.farah);
    var2.grenadeammo = 0;
  }

  var7 = scripts\engine\utility::array_combine(var7, var0);
  thread chu_right_side();
  thread chu_molotov_death();
  scripts\engine\utility::flag_wait("chu_rear");
  var10 = getEnt("chu_rear_nav_obstacle", "targetname");
  var10 = createnavbadplacebyent(var10, "axis");
  waitframe();
  var7 = scripts\engine\utility::array_removedead_or_dying(var7);
  goal_ent_position(800, var7, "chu_rear_goal");
  scripts\engine\utility::flag_wait("chu_exit");
  waitframe();
  var7 = scripts\engine\utility::array_removedead_or_dying(var7);

  foreach(var2 in var7) {
    var2 setgoalpos(var2.origin);
    var2 scripts\engine\sp\utility::set_goal_radius(500);
    var2 scripts\engine\utility::set_movement_speed(150);
    var2 setgoalentity(level.player);
  }
}

function chu_right_side() {
  level endon("chu_rear");
  level.fob_guys_chu_right = [];
  scripts\engine\utility::flag_wait("chu_right_side");
  level.fob_guys_chu_right = spawn_check_func(32, "fob_guys_chu_right", 3);
  directing_01(level.fob_guys_chu_right);
  level.fob_guys_chu_right = scripts\engine\utility::array_removedead_or_dying(level.fob_guys_chu_right);

  foreach(var1 in level.fob_guys_chu_right) {
    var1 scripts\engine\sp\utility::set_goal_radius(600);
    var1 getenemyinfo(level.player);
    var1 setgoalentity(level.player);
  }
}

function chu_molotov_death() {
  level endon("chu_exit");
  scripts\engine\utility::flag_wait("chu_right_side");
  scripts\engine\sp\utility::trigger_wait_targetname("molotov_guy_trig");
  var0 = spawn_check_func(32, "chu_molotov_death");
  var0[0].baseaccuracy = 0;
  var0[0] endon("death");
  var0[0] getenemyinfo(level.player);
  var1 = scripts\engine\utility::getStruct("molotov_guy_struct", "targetname");
  var2 = getnode("molotov_node", "targetname");
  var3 = level.farah magicgrenade(var1.origin, var2.origin);

  if(isDefined(var3)) {
    var3 endon("entitydeleted");
  }

  scripts\sp\equipment\molotov::molotovfiremain(var3);
}

function tarmac_start() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(5);
  var3 = charge_setalliestoredshirts();
  var4 = trenchrun_getallycovernodes();
  level.allies = scripts\engine\sp\utility::array_merge(var3, [var0, var1]);

  foreach(var6 in level.allies) {
    var7 = scripts\engine\utility::random(var4);
    var6 scripts\engine\sp\utility::teleport_ai(var7);
    var4 = scripts\engine\utility::array_remove(var4, var7);
  }

  thread chu_right_side();
  thread redshirt_refill();
  thread explode_tarmac_scriptables();
  scripts\engine\utility::flag_set("tarmac_enter");
  var9 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var9, &delete);
  var10 = scripts\sp\utility::make_weapon("iw8_la_mike32_incendiary", ["lnchrscope_mike32"]);
  level.player scripts\sp\utility::give_weapon(var10);
}

function tarmac_main() {
  scripts\engine\utility::flag_wait("chu_exit");
  thread dialogue_tarmac();
  thread hangar_drag_scene();
  thread explode_tarmac_scriptables_by_trigger();
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  level.ally_volume = getEnt("tarmac_volume", "targetname");

  if(!istrue(level.tarmac_tower.collapsed)) {
    level.tarmac_tower_guy = tower_spawner_logic("tower_guy_tarmac");
  }

  var2 = spawn_check_func(32, "tarmac_guys_front", 2);
  var3 = spawn_check_func(32, "tarmac_guys", 10);
  var4 = spawn_check_func(32, "tarmac_guys_rear_guard");

  foreach(var6 in var3) {
    var6.ignoreall = 1;
    var6.baseaccuracy = 0.1;
  }

  if(scripts\engine\utility::flag("boss_chopper_dead")) {
    level.drone_start_position = spawnStruct();
    level.drone_start_position.origin = (-41830, 33562, -217);
    level.drone_start_position.angles = (5, -90, 0);

    if(scripts\engine\utility::flag("player_in_drone")) {
      scripts\engine\utility::flag_waitopen("player_in_drone");
    }

    scripts\engine\sp\utility::autosave_by_name("chu_exit");
  }

  scripts\engine\utility::flag_wait("tarmac_enter");
  level.allies = getaiarray("allies");

  foreach(var6 in level.allies) {
    var6 setgoalpos(var6.origin);
    var6 scripts\engine\sp\utility::set_goal_radius(1200);
    var6 scripts\engine\sp\utility::clear_force_color();
    var6 scripts\engine\sp\utility::set_force_color("p");
  }

  thread tarmace_player_allies();
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_00");
  thread ally_rpg_guy();
  var10 = getaiarray("axis");

  foreach(var6 in var10) {
    var6.ignoreall = 0;
    var6.baseaccuracy = 0.2;
  }

  var3 = scripts\engine\utility::array_removedead_or_dying(var3);
  goal_ent_position(2000, var3, "tarmac_goal_rear");
  thread tarmac_push_player(var3);
  scripts\engine\utility::flag_wait("tarmac_front");
  scripts\engine\sp\utility::autosave_by_name("tarmac_front");
  var13 = scripts\engine\sp\utility::array_spawn_targetname("hangar_snipers", 1);

  if(var13.size > 0) {
    var13[0] scripts\engine\sp\utility::set_favoriteenemy(level.player);
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_01");
  thread tarmace_player_allies();
  scripts\engine\utility::flag_wait("tarmac_mid");
  thread fob_scriptables_cleanup();
  scripts\engine\sp\utility::autosave_by_name("tarmac_mid");
  thread tarmace_player_allies();
  var14 = spawn_check_func(32, "tarmac_guys_rear", 5);
  goal_ent_player(600, var14);
  scripts\engine\utility::flag_wait("tarmac_rear");
  thread tarmace_player_allies();
  var15 = spawn_check_func(32, "tarmac_guys_hangar_entrance");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_02");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_03");
  var10 = getaiarray("axis");
  var10 = scripts\engine\utility::array_removedead_or_dying(var10);
  level.ally_volume = getEnt("tarmac_rear_volume", "targetname");

  foreach(var6 in var10) {
    var6 setgoalpos(var6.origin);
    var6 setgoalvolumeauto(level.ally_volume);
  }

  thread hangar_allies_move_up();
  scripts\engine\utility::flag_wait("hangar_entrance");

  if(isDefined(level.tarmac_tower_guy)) {
    level.tarmac_tower_guy kill();
  }

  var10 = getaiarray("axis");
  var10 = scripts\engine\utility::array_removedead_or_dying(var10);

  foreach(var6 in var10) {
    if(scripts\engine\utility::is_equal(var6.targetname, "tower_guy_tarmac")) {
      continue;
    }

    var6 setgoalpos(var6.origin);
    var6 scripts\engine\sp\utility::set_goal_radius(500);
    var6 scripts\engine\utility::set_movement_speed(150);
    var6 setgoalentity(level.player);
  }

  var20 = getEnt("hangar_volume", "targetname");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_04");
  scripts\engine\sp\utility::autosave_by_name("tarmac_color_04");
  level.fob_enemies = getaiarray("axis");

  foreach(var6 in level.fob_enemies) {
    if(scripts\engine\utility::is_equal(var6.targetname, "tower_guy_tarmac")) {
      continue;
    }

    var6 cleargoalvolume();
    var6.ignoresuppression = 1;
    var6.ignoreme = 0;
    var6 setgoalpos(var6.origin);
    var6 scripts\engine\sp\utility::set_goal_radius(500);
    var6 setgoalentity(level.player);
  }

  while(level.fob_enemies.size > 0 && !scripts\engine\utility::flag("hangar_interior")) {
    level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
    wait 0.1;

    if(level.fob_enemies.size == 0) {
      scripts\engine\utility::flag_set("hangar_interior");
    }
  }

  scripts\engine\utility::flag_set("tarmac_cleared");
}

function fob_scriptables_cleanup() {
  var0 = [];
  var1 = getscriptablearray();

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.model, "door_wooden_hollow_rl_01_destr")) {
      var0 = var3;
      var3 thread scripts\sp\door::remove_open_prompts();
      var3.origin += (0, 0, -4000);
      var3 hide();
    }
  }
}

function ally_rpg_guy() {
  var0 = (-43000.5, 29836, -340);
  var1 = scripts\engine\utility::spawn_tag_origin(var0, (0, 0, 0));
  scripts\engine\utility::flag_wait("tarmac_mid");

  if(istrue(level.tarmac_tower.collapsed)) {
    return;
  }

  var2 = getEntArray("tower_guy_tarmac", "targetname")[0];
  var3 = scripts\engine\sp\utility::spawn_targetname("ally_rpg_guy", 1);
  var4 = var3 scripts\engine\utility::get_target_ent();
  var3 scripts\engine\sp\utility::set_goal_radius(32);
  var3 endon("death");
  var3 scripts\engine\sp\utility::set_ignoresuppression(1);
  var3 allowedstances("stand");
  var3 clearpath();
  var3 setgoalpos(var4.origin);
  var3 waittill("goal");
  var3.ignoreme = 1;
  var3 scripts\common\ai::magic_bullet_shield();
  var3 setentitytarget(var1);
  var5 = missile_createattractorent(var1, 2000, 3000);
  level scripts\engine\utility::waittill_any("tower_collapse", "tarmac_rear");
  missile_deleteattractor(var5);
  var3 scripts\common\ai::stop_magic_bullet_shield();
  var3.ignoreall = 1;
  wait 4;
  var3 clearentitytarget();
  var6 = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  var3 scripts\anim\shared::forceuseweapon(var6, "primary");
  wait 1;
  var3.ignoreall = 0;
}

function hangar_drag_scene() {
  var0 = scripts\engine\utility::getStruct("drag_struct", "targetname");
  var0.origin += (0, 0, -4);
  var1 = scripts\engine\sp\utility::spawn_targetname("hangar_drag_guy_01", 1);
  var1 scripts\common\ai::magic_bullet_shield();
  var1.animname = "enemy_01";
  var1.forceragdollimmediate = 1;
  var0 scripts\common\anim::anim_first_frame_solo(var1, "drag_scene_drag");
  scripts\engine\utility::flag_wait("tarmac_rear");
  var2 = scripts\engine\sp\utility::spawn_targetname("hangar_drag_guy_02", 1);
  var2.animname = "enemy_02";
  var2.forceragdollimmediate = 1;
  var2.allowdeath = 1;
  var1.allowdeath = 1;
  var1.ignoreme = 1;
  var2.ignoreall = 1;
  var2.ignoreme = 1;
  var2 scripts\common\ai::magic_bullet_shield();
  var1.health = 100;
  thread budy_death_watcher(var1);
  thread budy_death_watcher(var2);
  var0 scripts\sp\anim::anim_reach_solo(var2, "drag_scene_drag");
  var1 scripts\common\ai::stop_magic_bullet_shield();
  var2 scripts\common\ai::stop_magic_bullet_shield();
  var0 thread scripts\common\anim::anim_single_solo(var2, "drag_scene_drag");
  var0 thread scripts\common\anim::anim_single_solo(var1, "drag_scene_drag");
  thread drug_guy_kill();
  var1 endon("death");
  var2 endon("death");
  var2.ignoreall = 0;
}

function drug_guy_kill() {
  self endon("death");
  self waittillmatch("single anim", "end");
  level notify("stop_buddy_watching");
  waitframe();
  self kill();
}

function budy_death_watcher(var0) {
  level endon("stop_buddy_watching");
  self endon("death");
  var0 waittill("death");

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

function tarmac_catchup() {
  var0 = getEnt("chu_chopper_clip", "targetname");
  var0 delete();
  scripts\engine\utility::flag_set("tarmac_mid");
  scripts\engine\utility::flag_set("boss_chopper_dead");
}

function tarmace_player_allies() {
  var0 = getaiarray("allies");
  var0 = scripts\engine\utility::array_remove(var0, level.farah);
  var0 = scripts\engine\utility::array_remove(var0, level.hadir);
  var0 = sortbydistance(var0, level.player.origin);

  if(isDefined(var0[0])) {
    var1 = var0[0];
    var1.fixednode = 0;
    var1 scripts\engine\sp\utility::clear_force_color();
    var1 scripts\engine\sp\utility::set_goal_radius(700);
    var1 setgoalentity(level.player);
  }

  if(isDefined(var0[1])) {
    var1 = var0[1];
    var1 scripts\engine\sp\utility::clear_force_color();
    var1.fixednode = 0;
    var1 scripts\engine\sp\utility::set_goal_radius(700);
    var1 setgoalentity(level.player);
    return;
  }
}

function hangar_allies_move_up() {
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::enemy_alive_counter_gate(0);
  scripts\engine\utility::flag_set("hangar_entrance");
}

function armory_02_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_armory_02", [level.player, var0, var1]);
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(5);
  var3 = charge_setalliestoredshirts();
  var4 = towerstairs_getallycovernodes();
  var5 = var3;

  foreach(var7 in level.allies) {
    var8 = scripts\engine\utility::random(var4);
    var7 scripts\engine\sp\utility::teleport_ai(var8);
    var4 = scripts\engine\utility::array_remove(var4, var8);
  }

  level.allies = getaiarray("allies");

  foreach(var11 in level.allies) {
    var11 setgoalpos(var11.origin);
    var11 scripts\engine\sp\utility::clear_force_color();
    var11 scripts\engine\sp\utility::set_force_color("p");
  }

  thread redshirt_refill();
  thread explode_tarmac_scriptables();
  var13 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var13, &delete);
}

function armory_02_main() {
  level.player setsoundsubmix("sp_npc_steps_down", 1, 1);
  scripts\engine\sp\utility::autosave_by_name("armory_02");
  scripts\engine\sp\utility::activate_trigger_with_targetname("hangar_defend_start_color");
  scripts\engine\utility::trigger_off("hangar_defend_flag_trig", "targetname");
  thread dialogue_armory_02();
  thread dialogue_armory_boost();
  thread armory_02();
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_06");
  var0 = [level.farah, level.hadir];

  foreach(var2 in var0) {
    var2 setgoalpos(var2.origin);
    var2 scripts\engine\sp\utility::clear_force_color();
    var2 scripts\engine\sp\utility::set_force_color("b");
  }

  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    if(var2 == level.farah || var2 == level.hadir) {
      continue;
    }

    var2 setgoalpos(var2.origin);
    var2 scripts\engine\sp\utility::clear_force_color();
    var2 scripts\engine\sp\utility::set_force_color("r");
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

function explode_tarmac_scriptables() {
  wait 0.1;
  var0 = getscriptablearray("tarmac_scriptables", "targetname");

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.model, "veh8_mil_lnd_tromeo_black")) {
      if(var2 getscriptableparthasstate("base", "dead")) {
        var2 setscriptablepartstate("base", "dead", 1, 1);
      }

      if(var2 getscriptableparthasstate("body", "dead")) {
        var2 setscriptablepartstate("body", "dead", 1, 1);
      }

      continue;
    }

    if(var2 getscriptableparthasstate("base", "dead")) {
      var2 setscriptablepartstate("base", "dead", 1, 1);
    }

    if(var2 getscriptableparthasstate("body", "dead")) {
      var2 setscriptablepartstate("body", "dead", 1, 1);
    }

    var2.origin += (0, 0, -2000);
  }

  var4 = getEntArray("fuel_truck_corpse", "targetname");
  scripts\engine\utility::array_call(var4, &show);
}

function explode_tarmac_scriptables_by_trigger() {
  wait 0.1;
  var0 = getscriptablearray("tarmac_truck_r2", "targetname");
  scripts\engine\utility::flag_wait("tarmac_front");
  wait 2;

  foreach(var2 in var0) {
    var2 setscriptablepartstate("body", "dead", 1);
  }

  var0 = getscriptablearray("tarmac_truck_l1", "targetname");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("body", "onfire", 1);
  }

  var0 = getscriptablearray("tarmac_truck_l1", "targetname");
  scripts\engine\utility::flag_wait("tarmac_mid");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("body", "dead", 1);
  }

  var0 = getscriptablearray("tarmac_truck_r1", "targetname");
  scripts\engine\utility::flag_wait("tarmac_mid");
  wait 4;

  foreach(var2 in var0) {
    var2 setscriptablepartstate("body", "dead", 1);
  }
}

function tarmac_push_player(var0) {
  while(var0.size) {
    var0 = scripts\engine\utility::array_removedead_or_dying(var0);
    var0 = sortbydistance(var0, level.player.origin);

    if(isDefined(var0[0])) {
      var0[0] scripts\engine\sp\utility::set_goal_radius(600);
      var0[0] scripts\engine\sp\utility::set_favoriteenemy(level.player);
      var0[0] scripts\engine\utility::set_movement_speed(150);
      var0[0] setgoalentity(level.player);
      var0[0] waittill("death");
    }

    waitframe();
  }
}

function hangar_defend_start() {
  scripts\engine\sp\utility::battlechatter_on("allies");
  scripts\engine\sp\utility::battlechatter_on("axis");
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon(1);
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_killstreak_ending", [level.player, var0, var1]);
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(1);
  var3 = charge_setalliestoredshirts();
  var4 = towerstairs_getallycovernodes();

  foreach(var6 in level.allies) {
    var7 = scripts\engine\utility::random(var4);
    var6 scripts\engine\sp\utility::teleport_ai(var7);
    var4 = scripts\engine\utility::array_remove(var4, var7);
  }

  var9 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var9, &delete);
  scripts\engine\sp\utility::activate_trigger_with_targetname("hangar_defend_start_color");
}

function hangar_defend_main() {
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

  if(!scripts\engine\utility::flag("hangar_defend_start")) {
    level scripts\engine\utility::flag_set("power_kill");
  }

  if(scripts\engine\utility::flag("hangar_defend_start")) {
    thread scripts\engine\utility::flag_set_delayed("power_kill", 5);
  }

  level.hadir.name = "Hadir";
  visionsetnaked("safehouse_finale_tarmac_end", 0.05);
  thread pallet_smash();
  level.player scripts\sp\utility::set_player_attacker_accuracy(0.15);
  var0 = scripts\engine\sp\utility::array_spawn_targetname("hangar_defend_infantry", 1);

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
    var2 setgoalpos(var2.origin);
    var2 scripts\common\ai::magic_bullet_shield();
  }

  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var2) || scripts\engine\utility::is_equal(level.hadir, var2)) {
      continue;
    }

    var2 scripts\common\ai::magic_bullet_shield();
  }

  var6 = getEnt("hangar_defend_badplace", "targetname");
  createnavbadplacebyent(var6, "axis");
  level.ks_vehicles = [];
  scripts\engine\utility::flag_wait("hangar_defend_start");
  thread dialogue_hangar_defend();
  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var2) || scripts\engine\utility::is_equal(level.hadir, var2)) {
      continue;
    }

    var2 scripts\common\ai::stop_magic_bullet_shield();
  }

  foreach(var2 in var0) {
    var2 scripts\common\ai::stop_magic_bullet_shield();
  }

  goal_ent_player(2000, var0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  var11 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var12 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    var2 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(var11, var2) || scripts\engine\utility::is_equal(var12, var2)) {
      var2 scripts\engine\sp\utility::set_force_color("b");
      var2.grenadeammo = 0;
      continue;
    }

    thread exterior_allies_run_inside();
    var2.attackeraccuracy = 1;
    var2.health = 20;
  }

  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    if(scripts\engine\utility::is_equal(var11, var2) || scripts\engine\utility::is_equal(var12, var2)) {
      var2.grenadeammo = 200;
    }
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
  var17 = getaiarray("axis");

  foreach(var2 in var17) {
    var2.grenadeammo = 0;
  }

  thread tarmac_vindia_02(9);
  thread defend_autosaves();
  var12 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var20 = getEnt("oil_fire_dmg_trigger", "targetname");
  var20 delete();
  scripts\engine\utility::flag_wait("air_support_dialogue_complete");
  level.incomingapache = scripts\common\vehicle::spawn_vehicle_from_targetname("apache");
  level.player notifyonplayercommand("air_support_requested", "+actionslot 1");
  scripts\engine\sp\utility::display_hint_forced("air_support");
  level.player waittill("air_support_requested");
  level.player.fake_weapon = level.player getcurrentweapon();
  scripts\engine\utility::flag_set("air_support_inbound");
}

function audio_shf_kill_hangar_lights() {
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-42595, 29256, -331));
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-41992, 29023, -331));
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-42207, 28321, -331));
  thread scripts\engine\utility::play_sound_in_space("shf_light_turn_off", (-42824, 28526, -331));
}

function tarmac_badplace() {
  var0 = getEnt("tarmac_badplace", "targetname");
  var1 = createnavbadplacebyent(var0, "axis");
  level waittill("remove_tarmac_bp");
  destroynavobstacle(var1);
}

function player_leaves_volume_watcher() {
  var0 = getEnt("hangar_volume", "targetname");
  level.player.inside_volume = 1;

  while(!scripts\engine\utility::flag("air_support_inbound")) {
    if(!level.player istouching(var0)) {
      if(level.player.inside_volume) {
        thread leave_hangar_vo();
      }

      level.player.inside_volume = 0;

      if(scripts\engine\utility::flag("air_support_dialogue_complete")) {
        scripts\engine\utility::flag_set("killing_player");
        var1 = level.player.origin + (0, 0, 80);
        magicbullet("iw8_lm_pkilo", var1, level.player.origin + (0, 0, 20));
        level.player waittill("damage");
        level.player kill();
      }
    }

    waitframe();
  }

  level.player.inside_volume = 1;
}

function leave_hangar_vo() {
  var0 = ["dx_vom_far_pre_charge_setup_230", "dx_vom_far_pre_charge_setup_250", "dx_vom_far_pre_charge_setup_240"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  level.farah scripts\engine\sp\utility::smart_dialogue(var1 scripts\engine\sp\utility::deck_draw());
  wait 5.2;
  level.farah scripts\engine\sp\utility::smart_dialogue(var1 scripts\engine\sp\utility::deck_draw());
}

function hangar_defend_vfx_main() {
  scripts\engine\utility::flag_set("hangar_defend_start");
  thread scripts\engine\utility::flag_set_delayed("tarmac_fire_lights", 1.5);
  level notify("power_kill");
  visionsetnaked("safehouse_finale_tarmac_end", 0.05);
  thread pallet_smash();
  var0 = scripts\engine\sp\utility::array_spawn_targetname("hangar_defend_infantry", 1);

  foreach(var2 in var0) {
    var2.grenadeammo = 0;
    var2 setgoalpos(var2.origin);
    var2 scripts\common\ai::magic_bullet_shield();
  }

  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var2) || scripts\engine\utility::is_equal(level.hadir, var2)) {
      continue;
    }

    var2 scripts\common\ai::magic_bullet_shield();
  }

  var6 = getEnt("hangar_defend_badplace", "targetname");
  createnavbadplacebyent(var6, "axis");
  level.ks_vehicles = [];
  scripts\engine\utility::flag_wait("hangar_defend_start");
  thread dialogue_hangar_defend();
  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    if(scripts\engine\utility::is_equal(level.farah, var2) || scripts\engine\utility::is_equal(level.hadir, var2)) {
      continue;
    }

    var2 scripts\common\ai::stop_magic_bullet_shield();
  }

  foreach(var2 in var0) {
    var2 scripts\common\ai::stop_magic_bullet_shield();
  }

  goal_ent_player(2000, var0);
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  var11 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var12 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    var2 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(var11, var2) || scripts\engine\utility::is_equal(var12, var2)) {
      var2 scripts\engine\sp\utility::set_force_color("b");
      var2.grenadeammo = 0;
      continue;
    }

    thread exterior_allies_run_inside();
    var2.attackeraccuracy = 1;
    var2.health = 20;
  }

  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    if(scripts\engine\utility::is_equal(var11, var2) || scripts\engine\utility::is_equal(var12, var2)) {
      var2.grenadeammo = 200;
    }
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

function pallet_smash() {
  var0 = getEnt("pallet_smash_trigger", "targetname");
  var1 = getEnt("pallet_badplace", "targetname");
  createnavbadplacebyent(var1, "axis");

  while(!isDefined(level.tarmac_vindia_02)) {
    waitframe();
  }

  while(!level.tarmac_vindia_02 istouching(var0)) {
    waitframe();
  }

  scripts\engine\utility::trigger_off("pallet_fire_trig", "targetname");
  thread pallet_scriptables();
  scripts\engine\utility::flag_set("pallet_smash");
  thread pallet_lights();
  var2 = scripts\engine\utility::spawn_tag_origin((-41852.4, 29958.4, -645.557), (0.10223, 185.996, 359.008));
  playFXOnTag(scripts\engine\utility::getfx("vfx_safehouse_finale_apc_collision"), var2, "tag_origin");
  wait 0.5;
  var3 = scripts\engine\utility::spawn_tag_origin((-41844.9, 29862.9, -650.004), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_safehouse_finale_apc_collision"), var2, "tag_origin");
  wait 0.5;
  scripts\engine\utility::exploder("hanger_lights");
  scripts\engine\utility::exploder("pallet_plume_02");
  playFXOnTag(scripts\engine\utility::getfx("vfx_safehouse_finale_vindia_fire"), level.tarmac_vindia_02, "drivers_hatch_jnt");
  var4 = getEntArray("pallet_pristine", "targetname");
  scripts\engine\utility::flag_wait("air_support_inbound");
  var2 delete();
  var3 delete();
}

function pallet_lights() {
  var0 = getEntArray("tarmac_fires", "targetname");
  var1 = [];

  foreach(var3 in var0) {
    if(scripts\engine\utility::is_equal(var3.script_noteworthy, "pallet")) {
      var1 = var3;
    }
  }

  scripts\engine\utility::array_thread(var1, &pallet_light_lerps);
}

function pallet_light_lerps() {
  var0 = self getlightintensity();
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting::lerp_value_charge_explosion(var0, var0 * 0.15, 0.5);
  wait 4;
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting::lerp_value_charge_explosion(var0 * 0.15, var0, 3);
}

function pallet_scriptables() {
  var0 = getscriptablearray("pallet_pristine", "targetname");

  foreach(var2 in var0) {
    if(var2 getscriptableparthasstate("base", "dead")) {
      var2 setscriptablepartstate("base", "dead", 1, 1);
    }

    if(var2 getscriptableparthasstate("base", "exploded")) {
      var2 setscriptablepartstate("base", "exploded", 1, 1);
    }

    scripts\engine\utility::flag_wait("apache_here");

    if(var2 getscriptableparthasstate("base", "fragmented")) {
      var2 setscriptablepartstate("base", "fragmented", 1, 1);
    }
  }
}

function defend_autosaves() {
  var0 = getEnt("hangar_volume", "targetname");

  if(level.player istouching(var0) && !scripts\engine\utility::flag("killing_player")) {
    scripts\engine\sp\utility::autosave_by_name("hangar_defend_auto_1");
  }

  wait 12;

  if(level.player istouching(var0) && !scripts\engine\utility::flag("killing_player")) {
    scripts\engine\sp\utility::autosave_by_name("hangar_defend_auto_2");
    return;
  }
}

function exterior_allies_run_inside() {
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

function lerp_value(var0, var1, var2) {
  var3 = var1 - var0;
  var4 = 0.05;
  var5 = int(var2 / var4);

  if(var5 > 0) {
    var6 = var3 / var5;

    while(var5) {
      var0 += var6;
      wait var4;
      var5--;
    }

    return;
  }
}

function killstreak_chopper_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  scripts\engine\sp\utility::set_start_location("start_killstreak_ending", [level.player, var0]);
  level.allies = getaiarray("allies");

  foreach(var2 in level.allies) {
    var2 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(level.farah, var2)) {
      var2 scripts\engine\sp\utility::set_force_color("b");
      continue;
    }

    var2 scripts\engine\sp\utility::set_force_color("p");
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  thread tarmac_umike_08();
  thread tarmac_umike_09();
  level.ks_vehicles = [];
  thread tarmac_vindia_02(undefined, 1);
  var4 = getEnt("oil_fire_dmg_trigger", "targetname");
  var4 delete();
  var5 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var5, &delete);
  level.incomingapache = scripts\common\vehicle::spawn_vehicle_from_targetname("apache");
  level.player.fake_weapon = scripts\sp\maps\safehouse_finale\safehouse_finale::player_getprimaryweaponobject();
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  level.vtclassname = "script_vehicle_iw8_truck_umike_covered";
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/lab/vfx_temp_lrg_veh_death.vfx", "tag_origin", "rocket_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_tank_death_exp.vfx", "tag_origin");
  level.vtclassname = "script_vehicle_iw8_vindia_a1";
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/veh/bromeo/vfx_tank_death_exp_plume.vfx", "tag_origin", "rocket_explode");
  scripts\common\vehicle_build::build_deathfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_tank_death_exp.vfx", "tag_origin");
  thread explode_tarmac_scriptables();
}

function killstreak_chopper_main() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var0 = [];
  var1 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy");

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.model, "veh8_mil_air_mindia8_static_dst_tail")) {
      var0 = var3;
    }
  }

  scripts\engine\utility::array_call(var0, &hide);
  scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\sp\utility::battlechatter_off("axis");
  level.allies = getaiarray("allies");

  foreach(var6 in level.allies) {
    var6.grenadeammo = 0;
    var6 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(level.farah, var6) || scripts\engine\utility::is_equal(level.hadir, var6)) {
      var6.support_equipment = 0;
      var6 notify("remove_equipment");
      var6 scripts\engine\sp\utility::set_force_color("b");
      continue;
    }

    var6 delete();
  }

  var8 = getspawnerarray("hangar_dummy_ai");

  foreach(var10 in var8) {
    var11 = spawnStruct();
    var11.origin = var10.origin;
    var11.angles = var10.angles;
    var10 = scripts\engine\sp\utility::bodyonlyspawn(var10);
    var10.animname = var10.script_animname;
    var11 thread scripts\common\anim::anim_loop_solo(var10, "hangar_idles");
  }

  var13 = getcorpsearray();
  scripts\engine\utility::array_delete(var13);
  level.fob_enemies = getaiarray("axis");

  foreach(var6 in level.fob_enemies) {
    var6.grenadeammo = 0;
  }

  var16 = getaiarray("allies");

  foreach(var6 in var16) {
    var6.name = "";
  }

  scripts\engine\utility::delaythread(2, &tarmac_umike_01);
  scripts\engine\utility::delaythread(2, &tarmac_umike_01b);
  scripts\engine\utility::delaythread(2.1, &tarmac_umike_02);
  thread tarmac_umike_03();
  thread tarmac_vindia_03();
  thread dialogue_killstreak_chopper();
  var19 = spawnStruct();
  var19.origin = level.player.origin;
  var19.angles = level.player.angles;
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
  var20 = getaiarray("axis");
  var20 = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var6 in var20) {
    var6.grenadeammo = 0;
    var6.skipdeathanim = 1;
  }

  wait 1;
  thread chopper_rockets_watcher();
  thread chopper_ads_watcher();
  thread chopper_guns_watcher();
  var23 = scripts\engine\sp\utility::getvehiclearray();
  scripts\engine\utility::array_thread(var23, &vehicle_jolt_watcher);
  thread trucks_stopped_watcher();
  thread apache_start_moving_nags();
  scripts\engine\sp\utility::display_hint("apache_fly");
  scripts\engine\utility::flag_set("apache_here");
  var20 = getaiarray("axis");
  var20 = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var6 in var20) {
    var6.grenadeammo = 0;
  }

  var26 = gettime() + 10000;

  while(gettime() <= var26 && !level.player scripts\sp\maps\safehouse_finale\safehouse_finale::stick_forward()) {
    waitframe();
  }

  wait 3;
  thread apache_hints();
  thread killstreak_rpg_guys();
  thread killstreak_backup_enemies();
  thread ai_cleanup_watcher();

  while(level.ks_vehicles.size > 0) {
    scripts\engine\utility::waittill_any_ents_array(level.ks_vehicles, "death");

    foreach(var3 in level.ks_vehicles) {
      if(!isalive(var3)) {
        level.ks_vehicles = scripts\engine\utility::array_remove(level.ks_vehicles, var3);
      }
    }
  }

  level notify("tanks_dead");
  scripts\engine\sp\utility::autosave_by_name("tanks_dead");
  scripts\engine\utility::flag_set("rpg_guys_go");
  scripts\engine\utility::flag_wait("ks_trucks_stopped");
  wait 7;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::enemy_alive_counter_gate(20);
  level notify("kill_respawners");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::enemy_alive_counter_gate(16);
  scripts\engine\utility::flag_set("retreat");
  thread killstreak_retreat();
  wait 8;
  level.fob_enemies = getaiarray("axis");
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
  level.player notifyonplayercommand("disengage_apache", "+actionslot 1");
  thread disengage_watcher();

  while(!scripts\sp\maps\safehouse_finale\safehouse_finale::hide_apache_retreat_hint() && level.fob_enemies.size > 0) {
    level.fob_enemies = getaiarray("axis");
    level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
    waitframe();
  }

  level notify("apache_safe");

  if(level.fob_enemies.size == 0) {
    wait 3;
  }

  level.incomingapache scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_apap_killstreak_chopper_clear_10");
  scripts\engine\utility::flag_set("killstreak_complete");
  setsaveddvar("LMRRNRMLS", 0);
  wait 0.2;

  foreach(var30 in level.ks_vehicles) {
    if(isDefined(var30)) {
      var30 kill();
    }
  }

  level.player enableinvulnerability();
  level.player unlink();
  var32 = scripts\engine\utility::spawn_tag_origin(level.player.og_ks_spot, level.player.angles);
  level.player dontinterpolate();
  level.player setOrigin(var32.origin);
  level.player playerlinktoabsolute(var32, "tag_origin");
  thread ending_scene_ent_cleanup(2);
  level.incomingapache scripts\vehicle\apache::leave_apache_no_player(level.player);
  scripts\engine\utility::array_delete(var8);
  var33 = getaiarray("axis");
  scripts\engine\utility::array_delete(var33);

  if(scripts\engine\utility::flag("mission_failed")) {
    level waittill("forever");
    return;
  }
}

function trucks_stopped_watcher() {
  var0 = scripts\engine\sp\utility::getvehiclearray();

  foreach(var2 in var0) {
    if(var2.model != "veh8_mil_lnd_umike") {
      var0 = scripts\engine\utility::array_remove(var0, var2);
    }
  }

  while(var0.size > 0) {
    var0 = scripts\engine\utility::array_removedead(var0);

    foreach(var2 in var0) {
      if(!isDefined(var2)) {
        continue;
      }

      if(!isalive(var2)) {
        var0 = scripts\engine\utility::array_remove(var0, var2);
      }

      if(isDefined(var2.veh_speed) && var2.veh_speed < 1) {
        var0 = scripts\engine\utility::array_remove(var0, var2);
      }
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("ks_trucks_stopped");
}

function apache_start_moving_nags() {
  var0 = ["dx_vom_apap_killstreak_chopper_intro_90", "dx_vom_apap_killstreak_chopper_intro_100", "dx_vom_apap_killstreak_chopper_intro_110"];
  level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill_delayed(15, "apache_start_moving_nags", var0, 12, 1.2);

  while(!level.player scripts\sp\maps\safehouse_finale\safehouse_finale::stick_forward()) {
    waitframe();
  }

  level notify("apache_start_moving_nags");
}

function apache_fire_vo() {
  var0 = ["dx_vom_apap_killstreak_chopper_combat_30", "dx_vom_apap_killstreak_chopper_combat_40", "dx_vom_apap_killstreak_chopper_combat_140"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);

  if(!level.player attackButtonPressed()) {
    level.player waittill("attack_pressed");
  } else {
    var1 scripts\engine\sp\utility::deck_draw();
  }

  while(level.player attackButtonPressed() && !var1 scripts\engine\sp\utility::deck_is_empty()) {
    level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter(var1 scripts\engine\sp\utility::deck_draw(), 0, 0.5);
    wait 0.1;
  }
}

function apache_missile_fire_vo() {
  level.player waittill("frag_pressed");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_apap_killstreak_chopper_combat_10", 0, 0.5);
}

function apache_killconfirm_vo() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_apap_killstreak_chopper_reactions_100");
}

function apache_reloading_vo() {
  var0 = ["dx_vom_apap_killstreak_chopper_reloading_10", "dx_vom_apap_killstreak_chopper_reloading_20"];
  var1 = scripts\engine\sp\utility::create_deck(var0);
  var0 = ["dx_vom_apap_killstreak_chopper_combat_200", "dx_vom_apap_killstreak_chopper_combat_210", "dx_vom_apap_killstreak_chopper_combat_220", "dx_vom_apap_killstreak_chopper_combat_230"];
  var2 = scripts\engine\sp\utility::create_deck(var0);

  for(;;) {
    level waittill("apache_reloading");
    var3 = var1 scripts\engine\sp\utility::deck_draw();
    level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter(var3, 0, 3);
    wait 4.5;
    var3 = var2 scripts\engine\sp\utility::deck_draw();
    level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter(var3, 0);
  }
}

function notify_on_killed_by_apache() {
  self waittill("death", var0, var1, var2);
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = createheadicon(var2);
  }

  if(!scripts\engine\utility::is_equal(var0, level.incomingapache.mainturret) && !scripts\engine\utility::is_equal(var0, level.player)) {
    return;
  }

  level notify("apache_kill", "vehicle", var3);
}

function notify_apache_ai_kill() {
  for(;;) {
    level waittill("ai_killed", var0, var1, var2, var3);

    if(!scripts\engine\utility::is_equal(var1, level.incomingapache.mainturret) && !scripts\engine\utility::is_equal(var1, level.player)) {
      continue;
    }

    level notify("apache_kill", "ai", var3);
  }
}

function apache_hints() {
  scripts\engine\sp\utility::display_hint("apache_rockets");
  scripts\engine\utility::flag_wait("chopper_rockets_pressed");
  wait 2;

  if(level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledGamepad") || !level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard")) {
    scripts\engine\sp\utility::display_hint("apache_zoom");
  } else {
    scripts\engine\sp\utility::display_hint("apache_zoom_hold");
  }

  scripts\engine\utility::flag_wait("chopper_zoom_pressed");
  wait 2;
  scripts\engine\sp\utility::display_hint("apache_guns");
}

function chopper_rockets_watcher() {
  level endon("killstreak_complete");

  while(!level.player fragButtonPressed()) {
    waitframe();
  }

  scripts\engine\utility::flag_set("chopper_rockets_pressed");
}

function chopper_ads_watcher() {
  level endon("killstreak_complete");

  while(!level.player adsButtonPressed()) {
    waitframe();
  }

  scripts\engine\utility::flag_set("chopper_zoom_pressed");
}

function chopper_guns_watcher() {
  level endon("killstreak_complete");

  while(!level.player attackButtonPressed()) {
    waitframe();
  }

  scripts\engine\utility::flag_set("chopper_guns_pressed");
}

function scriptable_cleanup() {
  var0 = getscriptablearray("apache_scr", "targetname");

  foreach(var2 in var0) {
    if(isDefined(self.model) && self.model != "veh8_civ_lnd_hindia_black") {
      var2 hide();
    }
  }
}

function ai_cleanup_watcher() {
  level waittill("kill_all_ai");
  var0 = getaiarray("axis");
  scripts\engine\utility::array_delete(var0);
}

function disengage_watcher() {
  level.player waittill("disengage_apache");
  scripts\engine\utility::flag_set("disengage_apache");
}

function apache_death_watcher() {
  level endon("apache_safe");
  level waittill("apache_dead");
  scripts\sp\utility::missionfailedwrapper();
  scripts\engine\utility::flag_set("mission_failed");
}

function killstreak_rpg_guys() {
  thread killstreak_rpg_guys_timeout();
  level.incomingapache.threat_tag = scripts\engine\utility::spawn_tag_origin(level.incomingapache gettagorigin("tag_turret") + (0, 0, -50), level.incomingapache.angles);
  level.incomingapache.threat_tag linkTo(level.incomingapache);
  var0 = missile_createattractorent(level.incomingapache, 1000, 7000);
  var1 = scripts\sp\utility::make_weapon("iw8_la_rpapa7_straight_slower");
  scripts\engine\utility::flag_wait_or_timeout("rpg_guys_go", 120);
  scripts\engine\utility::flag_set("rpg_guys_go");
  wait 3;
  level.fob_enemies = getaiarray("axis");
  var2 = [];
  level.fob_enemies = sortbydistance(level.fob_enemies, (-43015.7, 31540.7, 200));
  var3 = 0;

  while(var3 < level.fob_enemies.size - 1) {
    if(isDefined(level.fob_enemies[var3])) {
      level.fob_enemies[var3] scripts\engine\sp\utility::set_maxsightdistsquared(225000000);
      level.fob_enemies[var3] thread scripts\anim\shared::forceuseweapon(var1, "primary");
      level.fob_enemies[var3] setentitytarget(level.incomingapache.threat_tag, 1);
      level.fob_enemies[var3].baseaccuracy = 1;
      var2 = level.fob_enemies[var3];
      level.fob_enemies[var3].rpg_guy = 1;
    }

    var3 += 4;
  }

  if(scripts\engine\utility::flag("killstreak_complete")) {
    return;
  }

  level endon("killstreak_complete");

  if(var2.size > 0) {
    scripts\engine\utility::array_thread(var2, &rpg_guys_fire);
    return;
  }
}

function rpg_guys_fire() {
  self endon("death");
  level endon("rpg_fired");
  self waittill("weapon_fired");
  level notify("rpg_fired");
}

function killstreak_rpg_guys_timeout() {}

function killstreak_backup_enemies() {
  level endon("kill_respawners");
  var0 = getEnt("tarmac_ks_guys_vol_01", "targetname");
  var1 = getspawnerarray("killstreak_backup_guys");
  var2 = 0;

  while(var2 < 17) {
    level.fob_enemies = getaiarray("axis");

    if(level.fob_enemies.size < 20) {
      var3 = var1[randomintrange(0, 3)];
      var4 = var3 scripts\engine\sp\utility::spawn_ai();
      var3.count = 1;

      if(isDefined(var4)) {
        var2++;
        var4.grenadeammo = 0;
        var4 setgoalvolumeauto(var0);
        waitframe();
      }
    }

    wait 0.2;
  }
}

function ai_counter() {
  level.fob_enemies = getaiarray("axis");

  while(level.fob_enemies.size > 0) {
    level.fob_enemies = getaiarray("axis");
    level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);
    wait 1;
  }
}

function killstreak_retreat() {
  level endon("killstreak_complete");
  level.farah.ignoreme = 1;
  level.allies = getaiarray("allies");
  level.fob_enemies = getaiarray("axis");
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var1 in level.fob_enemies) {
    var1.ignoresuppression = 1;
    var1.forcelongdeath = 1;
    var1 scripts\engine\utility::set_movement_speed(230);
  }

  scripts\engine\utility::array_thread(level.fob_enemies, &run_to_position, 1200, "molotov_guy_struct");
  wait 10;
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var1 in level.fob_enemies) {
    var1.forcelongdeath = 1;
    var1 scripts\engine\utility::set_movement_speed(230);
  }

  scripts\engine\utility::array_thread(level.fob_enemies, &run_to_position, 1500, "molotov_guy_struct");
  wait 15;
  level notify("second_retreat");
  level.fob_enemies = scripts\engine\utility::array_removedead_or_dying(level.fob_enemies);

  foreach(var1 in level.fob_enemies) {
    var1 scripts\engine\utility::set_movement_speed(160);
  }

  scripts\engine\utility::array_thread(level.fob_enemies, &run_to_position, 1200, "mid_goal_spots");
}

function run_to_position(var0, var1, var2) {
  self endon("death");
  wait randomfloatrange(1, 4);
  self.ignoreall = 1;
  var3 = scripts\engine\utility::getStructArray(var1, "targetname");
  var3 = sortbydistance(var3, level.player.origin);
  self setentitytarget(level.incomingapache.threat_tag, 1);
  self setgoalpos(var3[0].origin);
  scripts\engine\sp\utility::set_goal_radius(var0);
  self waittill("goal");
  wait 3;
  self.ignoreall = 0;
}

function ending_scene_start() {
  fob_post_load_inits();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_giveprimaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givesecondaryweapon();
  scripts\sp\maps\safehouse_finale\safehouse_finale::player_givemolotovweapon();
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
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  scripts\engine\sp\utility::set_start_location("start_killstreak_ending", [level.player]);
  scripts\engine\sp\utility::set_start_location("start_killstreak_igc", [var0, var1]);
  var2 = scripts\sp\maps\safehouse_finale\safehouse_finale::spawnallies(2);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::trench_spawnallies();
  var4 = charge_setalliestoredshirts();
  var5 = towerstairs_getallycovernodes();
  var6 = var4;
  level.allies = scripts\engine\sp\utility::array_merge(var4, [var0, var1]);

  foreach(var8 in level.allies) {
    var9 = scripts\engine\utility::random(var5);
    var8 scripts\engine\sp\utility::teleport_ai(var9);
    var5 = scripts\engine\utility::array_remove(var5, var9);
  }

  level.allies = getaiarray("allies");

  foreach(var12 in level.allies) {
    var12 scripts\engine\sp\utility::clear_force_color();

    if(scripts\engine\utility::is_equal(var0, var12) || scripts\engine\utility::is_equal(var1, var12)) {
      var12 scripts\engine\sp\utility::set_force_color("o");
      continue;
    }

    var12 scripts\engine\sp\utility::set_force_color("p");
  }

  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_07");
  scripts\engine\sp\utility::activate_trigger_with_targetname("tarmac_color_08");
  var14 = getEntArray("pristine_tarmac_models", "targetname");
  scripts\engine\utility::array_call(var14, &delete);
  level.ending_scene = 1;
  level.incomingapache = scripts\common\vehicle::spawn_vehicle_from_targetname("apache");
  level.incomingapache thread scripts\common\vehicle::vehicle_lights_on("interior");
  level.blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.player.fake_weapon = scripts\sp\maps\safehouse_finale\safehouse_finale::player_getprimaryweaponobject();
  hidecinematicletterboxing(2, 0);
}

function ending_scene_main() {
  level.player clearsoundsubmix("sp_npc_steps_down", 1);
  scripts\engine\utility::exploder("end_scene_fx");
  setsaveddvar("MNSOQLKMT", "2 0.0006 1 1");
  thread ending_scene_bodies();
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_lighting::ending_scene_lights();
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
  var0 = scripts\engine\utility::getStruct("ks_ending_struct", "targetname");
  var1 = scripts\engine\utility::getStruct("boss_chopper_tower_entrance_struct", "targetname");
  var2 = var0 scripts\engine\utility::get_target_ent();
  var2.origin += anglesToForward(var2.angles) * 10000;
  level.incomingapache vehicle_teleport(var1.origin + (1000, 1000, 0), var0.angles);
  level.incomingapache setvehgoalpos(var2.origin, 1);
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var4 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_spawnhadir();
  var5 = scripts\engine\sp\utility::spawn_targetname("alex", 1);
  var5.animname = "alex";
  var5.name = "";
  var4.name = "";
  var3.name = "";
  level.hadir.support_equipment = 0;
  level.farah.support_equipment = 0;
  level.hadir notify("remove_equipment");
  var6 = weaponclass(level.player.fake_weapon);

  if(var6 != "rifle") {
    level.player.fake_weapon = scripts\sp\utility::make_weapon("iw8_ar_akilo47");
  }

  var5 scripts\anim\shared::forceuseweapon(level.player.fake_weapon, "primary");
  var7 = scripts\engine\utility::getStruct("outro_scene_struct", "targetname");
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", (0, 0, 0), level.player.angles);
  level.player.rig hide();
  var8 = [var5, var3];
  scripts\engine\sp\utility::set_start_location("start_killstreak_igc", [var3, var4, var5]);
  level.player unlink();
  level.player dontinterpolate();
  level.player playerlinkTo(level.player.rig, "tag_origin", 1, 0, 0, 0, 0, 0);
  level.player setclienttriggeraudiozone("safef_final_scene", 3);
  level.player playSound("shf_end_walla_celebrate");
  var9 = getanimlength(var5 scripts\engine\utility::getanim("outro_scene"));
  var10 = getEntArray("ending_scene_vindia", "targetname");
  scripts\engine\utility::array_call(var10, &show);
  ending_scene_ent_cleanup();
  thread skippable_ending();
  thread dialogue_ending_scene();
  thread ending_scene_dof();
  visionsetnaked("safehouse_finale_ending", 0.05);
  thread ending_camera_animation();
  wait 0.5;
  level.blackoverlay fadeovertime(0.05);
  level.blackoverlay.alpha = 0;
  thread ending_scene_anims(var7, var3, var5);
  level.player scripts\engine\utility::delaythread(var9 - 6, &audio_fade_out_ending_mix);
  wait var9 - 2;
  level notify("level_ended");
  scripts\engine\sp\utility::nextmission();
  level waittill("forever");
}

function audio_fade_out_ending_mix() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 5);
}

function skippable_ending() {
  level endon("level_ended");
  var0 = scripts\sp\utility::userskip_wait();

  if(!var0) {
    return;
  }

  scripts\sp\hud_util::fade_out(0);
  scripts\engine\sp\utility::nextmission();
}

function ending_scene_bodies() {
  var0 = scripts\engine\utility::getStructArray("tarmac_end_dead_struct", "targetname");
  var1 = getspawnerarray("tarmac_guys")[0];
  var0[1].origin = (-41766, 29430, -675.963);
  var0[1].angles = (0, 22.8998, 0);

  foreach(var3 in var0) {
    var4 = scripts\engine\sp\utility::bodyonlyspawn(var1);
    var1.count = 1;
    var4.animname = "soldier_01";
    var4 thread scripts\common\ai::gun_remove();
    waitframe();
    var3 thread scripts\common\anim::anim_single_solo(var4, var3.animation);
    waitframe();
  }
}

function ending_scene_lights_off() {
  scripts\engine\sp\utility::flag_clear_delayed("tarmac_fire_lights", 0.1);
  var0 = getEntArray("tarmac_fires", "targetname");

  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function ending_scene_dof() {
  level scripts\engine\sp\utility::dof_enable(2.8, 2000, 10, 10, undefined, undefined);
  wait 3.5;
  level scripts\engine\sp\utility::dof_enable(2.8, 130, 1, 1, undefined, undefined);
  wait 3.75;
  thread scripts\engine\sp\utility::dof_enable_autofocus(3.5, 8, undefined, undefined, "tag_eye", undefined, 1);
}

function ending_scene_celebration() {
  var0 = scripts\engine\utility::getStruct("outro_scene_struct", "targetname");
  var1 = getspawnerarray("celebration_spawners")[0];
  var2 = [];

  for(var3 = 1; var3 < 11; var3++) {
    var4 = var1 scripts\engine\sp\utility::spawn_ai(1);
    var4.animname = "rebel_" + var3;
    var1.count++;
    var2 = var4;
    var4.name = "";
    var4 scripts\common\ai::magic_bullet_shield();
    waitframe();
  }

  var0 scripts\common\anim::anim_single(var2, "outro_scene");
}

#using_animtree("");

function ending_scene_anims(var0, var1, var2) {
  var3 = [var0, var1, var2];
  thread scripts\common\anim::anim_single(var3, "outro_scene");
  thread scene_mayhem(var1, %shf_050_3p_outro_alex_face);
  thread scene_mayhem(var0, %shf_050_3p_outro_farah_face);
  thread scene_mayhem(var2, %shf_050_3p_outro_hadir_face);
}

function scene_mayhem(var0, var1, var2) {
  level waittill(var1);

  if(!isDefined(var2)) {
    var2 = undefined;
  }

  thread play_mayhem_animation(var0, var2);
}

function ending_camera_animation() {
  level.player setplayerangles((0, 0, 0));
  thread scripts\common\anim::anim_single_solo(level.player.rig, "outro_scene");
}

function play_mayhem_animation(var0, var1) {
  if(isDefined(self.headmodel)) {
    if(isDefined(self.hatmodel)) {
      self detach(self.hatmodel);
    }

    self detach(self.headmodel);
    self setanim(var0, 1, 0, 1);
  }

  if(isDefined(var1)) {
    level waittill(var1);
    self setanim(var0, 0, 0, 0);
    self attach(self.headmodel);
    return;
  }
}

function ending_scene_ent_cleanup(var0) {
  if(isDefined(var0)) {
    wait var0;
  }

  var1 = getcorpsearray();
  scripts\engine\utility::array_delete(var1);
  var2 = getweaponarray();
  scripts\engine\utility::array_delete(var2);
  var3 = scripts\engine\sp\utility::getvehiclearray();
  var3 = scripts\engine\utility::array_remove(var3, level.incomingapache);
  scripts\engine\utility::array_delete(var3);
  var4 = getEntArray("destroyed_tarmac_models", "script_noteworthy");
  var5 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var6 = getentarrayinradius(undefined, undefined, var5.origin, 3000);
  scripts\engine\utility::array_thread(var6, &ending_scene_ent_cleanup_loop);
}

function ending_scene_ent_cleanup_loop() {
  if(scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_vindia_a1_dst") || scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_vindia_a1") || scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_umike_pickup_static_dst") || scripts\engine\utility::is_equal(self.model, "veh8_mil_lnd_umike_pickup") || isDefined(self.death_fx)) {
    self notify("fire_extinguish");
    self notify("stop_all_death_fx");
    waitframe();

    if(isDefined(self)) {
      self hide();
      return;
    }

    return;
  }
}

function tromeo_entrance_00() {
  for(;;) {
    var0 = getaiarray("axis", "allies");
    var1 = 31 - var0.size;

    if(var1 > 4 && !scripts\engine\utility::flag("ai_spawner_busy")) {
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
  var2 = getvehiclenode("tromeo_00_start", "targetname");
  level.tromeo_00 scripts\common\vehicle::attach_vehicle_and_gopath(var2);
  wait 0.5;
  scripts\engine\utility::flag_clear("ai_spawner_busy");
  level notify("tromeo_spawn_succeeded");
  level.tromeo_00 endon("death");

  while(level.tromeo_00.veh_speed > 5) {
    wait 0.1;
  }

  level.tromeo_00.maxhealth = 10000;
  level.tromeo_00 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_00 playSound("scn_safehouse_fin_truck_skid");
  wait 2;
  var3 = getaiarray("axis");
  var4 = [];

  foreach(var6 in var3) {
    if(scripts\engine\utility::is_equal(var6.targetname, "tromeo_guys_00")) {
      var4 = var6;
    }
  }

  if(scripts\engine\utility::flag("fob_player_in_center_swarm")) {
    goal_ent_position(800, "all", "rear_goal_spots");
    return;
  }

  goal_ent_player(1200, var4);
}

function tromeo_entrance_01() {
  scripts\engine\utility::flag_wait("fob_center_action");
  scripts\engine\utility::flag_wait_any_timeout(20, "player_in_drone", "fob_player_in_center_swarm");
  wait 1;
  level.tromeo_01 = scripts\common\vehicle::spawn_vehicle_from_targetname("tromeo_vehicle");
  level.tromeo_01 scripts\common\vehicle::vehicle_lights_on();
  level.tromeo_01.maxhealth = 24000;
  level.tromeo_01.team = "axis";
  level.tromeo_01 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  level.tromeos[level.tromeos.size] = level.tromeo_01;
  var0 = getvehiclenode("tromeo_01_start", "targetname");
  level.tromeo_01 scripts\common\vehicle::attach_vehicle_and_gopath(var0);
  wait 0.5;
  level notify("tromeo_spawn_succeeded");
  level.tromeo_01 endon("death");
  var1 = getaiarray("axis");

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.targetname, "tromeo_guys")) {
      self.vehiclerunexit = 1;
    }
  }

  while(level.tromeo_01.veh_speed > 5) {
    wait 0.1;
  }

  level.tromeo_01.regenerate = 0;
  level.tromeo_01.maxhealth = 7000;
  level.tromeo_01 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_01 playSound("scn_safehouse_fin_truck_skid");
  wait 2;
  var1 = getaiarray("axis");
  var5 = [];

  foreach(var3 in var1) {
    if(scripts\engine\utility::is_equal(var3.targetname, "tromeo_guys")) {
      var5 = var3;
    }
  }

  var5 = scripts\engine\utility::array_removedead_or_dying(var5);

  if(scripts\engine\utility::flag("fob_player_in_center_swarm")) {
    goal_ent_position(800, var5, "mid_goal_spots");
    return;
  }

  goal_ent_player(1200, var5);
}

function tromeo_entrance_02() {
  for(;;) {
    var0 = getaiarray("axis", "allies");
    var1 = 31 - var0.size;

    if(var1 > 4 && !scripts\engine\utility::flag("ai_spawner_busy")) {
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
  var2 = getvehiclenode("tromeo_02_start", "targetname");
  level.tromeos[level.tromeos.size] = level.tromeo_02;
  level.tromeo_02 scripts\common\vehicle::attach_vehicle_and_gopath(var2);
  wait 0.5;
  scripts\engine\utility::flag_clear("ai_spawner_busy");
  level notify("tromeo_spawn_succeeded");
  level.tromeo_02 endon("death");

  while(level.tromeo_02.veh_speed > 5) {
    wait 0.1;
  }

  level.tromeo_02.maxhealth = 1000;
  level.tromeo_02 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_02 playSound("scn_safehouse_fin_truck_skid");
}

function tromeo_entrance_03() {
  level endon("airport_gate_closed");
  scripts\engine\utility::flag_wait("fob_rear_trucks");
  var0 = getEnt("fob_center_containers_vol", "targetname");

  for(;;) {
    var1 = getaiarray("axis", "allies");
    var2 = 31 - var1.size;

    if(var2 > 4 && !scripts\engine\utility::flag("ai_spawner_busy")) {
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
  var3 = getvehiclenode("tromeo_03_start", "targetname");
  level.tromeos[level.tromeos.size] = level.tromeo_03;
  level.tromeo_03 scripts\common\vehicle::attach_vehicle_and_gopath(var3);
  wait 0.5;
  level notify("tromeo_spawn_succeeded");
  level.tromeo_03 endon("death");

  while(level.tromeo_03.veh_speed > 5) {
    wait 0.1;
  }

  level.tromeo_03 scripts\common\vehicle::vehicle_lights_off();
  level.tromeo_03 playSound("scn_safehouse_fin_truck_skid");
}

function fob_umike_03(var0) {
  scripts\engine\utility::flag_wait_any("fob_rear_trucks", "fob_exit");
  level.fob_umike_03 = scripts\common\vehicle::spawn_vehicle_from_targetname("fob_umike_03");
  level.fob_umike_03.animname = "gate_truck";
  var1 = getEntArray("gate_truck_lights", "targetname");
  level.fob_umike_03.clip = getEnt("fob_umike_03_clip", "targetname");
  level.fob_umike_03.clip linkTo(level.fob_umike_03);
  var2 = 2;
  level.fob_umike_03 scripts\common\vehicle::godon();
  level.fob_umike_03.regenerate = 1;
  level.fob_umike_03.maxhealth = 80300;
  level.fob_umike_03.team = "axis";
  var3 = getvehiclenode("fob_umike_03_start", "targetname");
  var4 = level.fob_umike_03 scripts\common\vehicle::vehicle_get_path_array();
  var5 = var4.size - 1;
  level.fob_umike_03 scripts\common\vehicle::attach_vehicle_and_gopath(var3);

  if(isDefined(var0)) {
    var6 = getEntArray("umike_03_guys", "targetname");
    scripts\engine\utility::array_delete(var6);
    var4 = level.fob_umike_03 scripts\common\vehicle::vehicle_get_path_array();
    var5 = var4.size - 2;
    level.fob_umike_03 vehicle_teleport(var4[var5].origin, var4[var5].angles);
  }

  while(level.fob_umike_03.veh_speed > 1) {
    wait 0.1;
  }

  level.fob_umike_03 vehicle_turnengineoff();
  scripts\engine\utility::flag_wait("armory_01_trigger");

  foreach(var8 in var1) {
    var8 unlink();
  }

  level.fob_umike_03.clip delete();
  level.fob_umike_03 delete();
}

function tromeo_vehicle_tarmac_00() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tromeo_vehicle_tarmac_00");
  var0 scripts\common\vehicle::vehicle_lights_on();
  var0.maxhealth = 20200;
  var0 setnormalhealth(1);
  var0 endon("death");
  var0.team = "axis";
  var0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var1 = getvehiclenode("tromeo_vehicle_tarmac_00_start", "targetname");
  level.tromeos[level.tromeos.size] = var0;
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  wait 0.5;
  var0 endon("death");
  scripts\engine\utility::flag_wait("fly_attack_done");
  var0 delete();
}

function tarmac_umike_01(var0) {
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var2 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_01");
  var2 scripts\common\vehicle::vehicle_lights_on();
  var2.regenerate = 0;
  var2.maxhealth = 21000;
  thread umike_damage_watcher();
  var2 setnormalhealth(1);
  var2 endon("death");
  var2.team = "axis";
  var2 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var2 scripts\common\vehicle::godoff();
  var3 = getvehiclenode("tarmac_umike_01_start", "targetname");
  wait 2;
  var2 scripts\common\vehicle::attach_vehicle_and_gopath(var3);

  if(isDefined(var0)) {
    var4 = var2 scripts\common\vehicle::vehicle_get_path_array();
    var5 = var4.size - 1;
    var2 vehicle_teleport(var4[var5].origin, var4[var5].angles);
    scripts\engine\utility::flag_wait("apache_here");
    var2 scripts\common\vehicle::vehicle_unload();
    return;
  }

  wait 0.5;
  var4 endon("death");
  scripts\engine\utility::flag_wait("apache_here");

  while(var4.veh_speed > 0) {
    wait 0.1;
  }
}

function tarmac_umike_01b() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_01b");
  var1 scripts\common\vehicle::vehicle_lights_on();
  var1.maxhealth = 21000;
  var1.regenerate = 0;
  var1 setnormalhealth(1);
  thread umike_damage_watcher();
  var1 endon("death");
  var1.team = "axis";
  var1 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var2 = getvehiclenode("tarmac_umike_01b_start", "targetname");
  var1 scripts\common\vehicle::attach_vehicle_and_gopath(var2);
  var3 = var1 scripts\common\vehicle::vehicle_get_path_array();
  var4 = var3.size - 8;
  var1 vehicle_teleport(var3[var4].origin, var3[var4].angles);
  var1 endon("death");
  scripts\engine\utility::flag_wait("apache_here");

  while(var1.veh_speed > 0) {
    wait 0.1;
  }

  var1 scripts\common\vehicle::vehicle_unload();
}

function tarmac_umike_02() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_02");
  var0 scripts\common\vehicle::vehicle_lights_on("headlights");
  var0.maxhealth = 21000;
  var0.regenerate = 0;
  var0 setnormalhealth(1);
  thread umike_damage_watcher();
  var0 endon("death");
  var0.team = "axis";
  var0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var1 = getvehiclenode("tarmac_umike_02_start", "targetname");
  var0 scripts\common\vehicle::godoff();
  wait 2;
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  wait 0.5;
  var0 endon("death");

  while(var0.veh_speed > 5) {
    wait 0.1;
  }
}

function tarmac_umike_03() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_03");
  var0 scripts\common\vehicle::vehicle_lights_on("headlights");
  thread umike_damage_watcher();
  var0.maxhealth = 21000;
  var0 setnormalhealth(1);
  var0.regenerate = 0;
  var0 endon("death");
  var0.team = "axis";
  var0 scripts\common\vehicle::godoff();
  var0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var1 = getvehiclenode("tarmac_umike_03_start", "targetname");
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  wait 0.5;
  var0 endon("death");

  while(var0.veh_speed > 5) {
    wait 0.1;
  }
}

function tarmac_umike_08() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_08");
  var0 scripts\common\vehicle::vehicle_lights_on("headlights");
  var0.maxhealth = 21000;
  var0 endon("death");
  var0.team = "axis";
  thread umike_damage_watcher();
  var0 scripts\common\vehicle::godoff();
  var0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var1 = getvehiclenode("tarmac_umike_08_start", "targetname");
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  wait 0.5;
  var2 = var0 scripts\common\vehicle::vehicle_get_path_array();
  var3 = var2.size - 3;
  var0 scripts\common\vehicle::godon();
  var0 vehicle_teleport(var2[var3].origin, var2[var3].angles);
  var0 endon("death");

  while(var0.veh_speed > 1) {
    wait 0.1;
  }

  level notify("remove_tarmac_bp");
  var0 scripts\common\vehicle::godoff();
  var0 scripts\common\vehicle::vehicle_lights_off("headlights");
  scripts\engine\utility::flag_wait("apache_here");
  var0.regenerate = 0;
}

function tarmac_umike_09() {
  var0 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_umike_09");
  var0 scripts\common\vehicle::vehicle_lights_on("headlights");
  var0.maxhealth = 21000;
  var0 endon("death");
  var0.team = "axis";
  var0 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var1 = getvehiclenode("tarmac_umike_09_start", "targetname");
  var0 scripts\common\vehicle::godon();
  var0 scripts\common\vehicle::attach_vehicle_and_gopath(var1);
  wait 0.5;
  var0 endon("death");

  while(var0.veh_speed > 1) {
    wait 0.1;
  }

  var0 scripts\common\vehicle::vehicle_lights_off("headlights");
  scripts\engine\utility::flag_wait("apache_here");
  var0.regenerate = 0;
}

function umike_damage_watcher() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  }
}

function tarmac_vindia_02(var0, var1) {
  if(isDefined(var0)) {
    var2 = var0;
  } else {
    var2 = 0;
  }

  wait var2;
  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var4 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_vindia_02");
  level.tarmac_vindia_02 = var4;
  thread vindia_spotlight();
  var4 scripts\common\vehicle::godon();
  var4.regenerate = 1;
  var4.maxhealth = 35000;
  var4.mgturret[0] makeunusable();
  var4 endon("death");
  var4.team = "axis";
  var4 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var4 playSound("scn_shf_vindia_drivein");
  var5 = getvehiclenode("tarmac_vindia_02_start", "targetname");
  level.ks_vehicles[level.ks_vehicles.size] = var4;
  var4 scripts\common\vehicle::attach_vehicle_and_gopath(var5);
  var6 = var4 scripts\common\vehicle::vehicle_get_path_array();
  var7 = var6.size - 7;
  var4 vehicle_teleport(var6[var7].origin, var6[var7].angles);

  if(isDefined(var2)) {
    var7 = var6.size - 5;
    var4 vehicle_teleport(var6[var7].origin, var6[var7].angles);
  }

  var8 = scripts\engine\utility::getStruct("turret_path", "targetname");
  var9 = scripts\engine\utility::spawn_tag_origin(var8.origin + (0, 0, 0), level.player.angles);
  tank_aim_at(var4, var9);
  var4 endon("death");
  scripts\engine\utility::flag_wait("pallet_smash");
  thread scripts\engine\utility::play_sound_in_space("scn_shf_palette_smash", var4.origin);
  thread enable_hangar_vehicles();
  wait 2;
  tank_fire_enable(var4);
  thread vindia_target_mover();
  scripts\engine\utility::flag_wait("apache_here");
  var4.regenerate = 0;
  var4 thread scripts\common\vehicle_code::vehicle_disable_navobstacles();
  var4 scripts\common\vehicle::godoff();
  var4.maxhealth = 35000;
  var4 setnormalhealth(1);
  var10 = scripts\engine\utility::spawn_tag_origin(var4.origin, var4.angles + (0, 90, 0));
  var4.angles = var10.angles;
  var4 linkTo(var10);
  waitframe();
  var4 thread scripts\common\vehicle_code::vehicle_enable_navobstacles();
  var4 thread scripts\common\vehicle_code::vehicle_enable_navrepulsors();
  thread vehicle_jolt_watcher();

  for(;;) {
    var10 moveTo(var10.origin + anglesToForward(var10.angles) * 100, 3);
    wait 5;
    var10 moveTo(var10.origin + anglesToForward(var10.angles) * -100, 3);
    wait 5;
    var10 moveTo(var10.origin + anglesToForward(var10.angles) * 100, 4);
    wait 6;
    var10 moveTo(var10.origin + anglesToForward(var10.angles) * -100, 4);
    wait 5;
  }
}

function vehicle_jolt_watcher() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(isDefined(var9) && scripts\engine\utility::is_equal(var1, level.player)) {
      if(scripts\engine\utility::is_equal(var9.basename, "apache_proj_sp")) {
        self joltbody(var2, 10);
      }
    }
  }
}

function enable_hangar_vehicles() {
  var0 = getscriptablearray("hangar_trucks", "script_noteworthy");

  foreach(var2 in var0) {
    var2 setscriptablepartstate("body", "healthy");
  }
}

function vindia_spotlight() {
  var0 = getEntArray("vindia_spotlight", "targetname");
  var1 = 3;

  foreach(var3 in var0) {
    var3.origin = self.mainturret gettagorigin("tag_front_turret_light");
    var3.origin += anglesToForward(var3.angles) * var1;
    var3.angles = self.mainturret gettagangles("tag_front_turret_light");
    var3.angles += (10, 0, 0);
    var3 linkTo(self.mainturret, "tag_front_turret_light");
    var3.og_intensity = var3 getlightintensity();
    var3 setlightintensity(0);
  }

  scripts\engine\utility::flag_wait("pallet_smash");
  wait 1;

  foreach(var3 in var0) {
    var3 setlightintensity(var3.og_intensity);
  }

  scripts\engine\utility::flag_wait("air_support_inbound");
  wait 1;

  foreach(var3 in var0) {
    var3 setlightintensity(0);
  }
}

function vindia_target_mover() {
  wait 2;
  var0 = scripts\engine\utility::getStruct("turret_path", "targetname");
  self.origin = var0.origin;
  wait 1;
  var0 = var0 scripts\engine\utility::get_target_ent();
  var0 = var0 scripts\engine\utility::get_target_ent();
  var0 = var0 scripts\engine\utility::get_target_ent();
  var0 = var0 scripts\engine\utility::get_target_ent();
  self moveTo(var0.origin, 2);
  wait 5;

  for(;;) {
    var0 = var0 scripts\engine\utility::get_target_ent();

    if(!isDefined(var0.target)) {
      var0 = scripts\engine\utility::getStruct("turret_path", "targetname");
    }

    self moveTo(var0.origin, 2);
    wait 3.5;
  }
}

function tarmac_vindia_03() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname("tarmac_vindia_03");
  var1 scripts\common\vehicle::vehicle_lights_on();
  level.tarmac_vindia_03 = var1;
  var1.regenerate = 0;
  var1.maxhealth = 35000;
  var1 setnormalhealth(1);
  var1 endon("death");
  var1.team = "axis";
  var1 thread scripts\engine\sp\utility::battlechatter_addvehicle("technical");
  var2 = getvehiclenode("tarmac_vindia_03_start", "targetname");
  level.ks_vehicles[level.ks_vehicles.size] = var1;
  var1 scripts\common\vehicle::attach_vehicle_and_gopath(var2);
  wait 9;
  var3 = scripts\engine\utility::spawn_tag_origin((-42379, 28449, -544), (0, 0, 0));
  tank_aim_at(var1, var3);

  while(var1.veh_speed > 0) {
    wait 0.1;
  }

  tank_fire_enable(var1);
  var4 = scripts\engine\utility::spawn_tag_origin(var1.origin, var1.angles);
  var1 linkTo(var4);

  for(;;) {
    var4 moveTo(var4.origin + anglesToForward(var4.angles) * 70, 3);
    wait 5;
    var4 moveTo(var4.origin + anglesToForward(var4.angles) * -70, 3);
    wait 5;
    var4 moveTo(var4.origin + anglesToForward(var4.angles) * 70, 3);
    wait 4;
    var4 moveTo(var4.origin + anglesToForward(var4.angles) * -70, 3);
    wait 4;
  }
}

function tank_fire_enable() {
  self.mainturret.script_delay_min = 1.5;
  self.mainturret.script_delay_max = 2;
  self.mainturret turretfireenable();
  self.mainturret startfiring();
  self.mainturret thread scripts\sp\mgturret::burst_fire_unmanned();
}

function tank_fire_disable() {
  self.mainturret stopfiring();
  self.mainturret notify("stop_burst_fire_unmanned");
  self.mgturret[0] stopfiring();
  self.mgturret[0] notify("stop_burst_fire_unmanned");
}

function tank_aim_at(var0, var1) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  self.mainturret settargetentity(var0, var1);
  self.mgturret[0] settargetentity(var0, var1);
}

function damage_watcher() {
  self endon("death");

  while(isDefined(self)) {
    self waittill("damage", var0);
  }
}

function fob_spawn_funcs() {
  var0 = getspawnerarray("technical_dudes_01");
  scripts\engine\sp\utility::array_spawn_function(var0, &technical_dudes_01_spawn_func);
  var1 = getspawnerarray("pre_charge_wallSpawner");
  scripts\engine\sp\utility::array_spawn_function(var1, &pre_charge_wallspawner_spawn_func);
  var2 = scripts\engine\utility::array_combine(getspawnerarray("fob_front_guys"), getspawnerarray("fob_front_guys_2"));
  var2 scripts\engine\sp\utility::array_spawn_function(var2, &fob_front_guys_spawn_func);
  var3 = scripts\engine\utility::array_combine(getspawnerarray("fob_guys_center_containers"), getspawnerarray("fob_guys_rear"));
  scripts\engine\sp\utility::array_spawn_function(var3, &fob_center_guys_spawn_func);
  var4 = scripts\engine\utility::array_combine(getspawnerarray("fob_guys_chu"), getspawnerarray("fob_guys_chu_rear"));
  scripts\engine\sp\utility::array_spawn_function(var4, &fob_container_guys_spawn_func);
  var5 = scripts\common\utility::getvehiclespawner("chu_chopper", "targetname");
  var5 scripts\engine\sp\utility::add_spawn_function(&chu_chopper_spawn_func);
  var6 = scripts\common\utility::getvehiclespawner("fob_chopper_04", "targetname");
  var6 scripts\engine\sp\utility::add_spawn_function(&fob_center_chopper_spawn_func);
  var7 = scripts\common\utility::getvehiclespawner("fob_chopper_transport", "targetname");
  var7 scripts\engine\sp\utility::add_spawn_function(&fob_chopper_transport_spawn_func);
  var8 = getspawnerarray("lb_04_guys");
  scripts\engine\sp\utility::array_spawn_function(var8, &fob_center_chopper_guys_spawn_func);
  var9 = getspawnerarray("fob_chopper_transport_guys");
  scripts\engine\sp\utility::array_spawn_function(var9, &fob_chopper_transport_guys_spawn_func);
  var10 = getspawnerarray("tower_guy_tarmac");
  scripts\engine\sp\utility::array_spawn_function(var10, &tower_guy_tarmac_spawn_func);
  var11 = scripts\engine\utility::array_combine(getspawnerarray("tromeo_guys_02"), getspawnerarray("tromeo_guys_03"));
  scripts\engine\sp\utility::array_spawn_function(var11, &tromeo_guys_03_spawn_func);
}

function fob_front_guys_spawn_func() {
  self.grenadeammo = 0;
}

function fob_center_guys_spawn_func() {}

function fob_container_guys_spawn_func() {
  scripts\engine\sp\utility::set_grenadeweapon("flash");
}

function tower_guy_tarmac_spawn_func() {
  self endon("death");
  scripts\engine\sp\utility::trigger_wait_targetname("armory_02_trigger");
  scripts\engine\utility::exploder("hangar_enemy_smoke");
  self delete();
}

function turret_guy_spawn_func() {
  self.baseaccuracy = 0.1;
  self.health = 1000;
}

function fob_allies_spawn_setup() {
  level.allies[level.allies.size] = self;

  if(self.classname == "actor_ally_reb_desert_dmr") {
    self.disablesniperbehaviors = 1;
    return;
  }
}

function gunner_death_watcher(var0) {
  self endon("death");
  var0 waittill("death");
  self kill();
}

function chu_chopper_spawn_func() {
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
  var0 = scripts\engine\utility::getStruct("boss_chopper_chu_01", "targetname");
  self hideallparts();

  foreach(var2 in self.mgturret) {
    var2 hideallparts();
  }

  thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::track_fob_helo_spawn();
  thread boss_heli_weapons_create();
  waitframe();
  thread chopper_crew_behavior();
  self vehicle_teleport(var0.origin - (0, 0, 200), var0.angles);
  self vehicle_setspeed(90, 10, 10);
  thread chopper_damage_watcher();
  thread lb_attack_runs();
  self waittill("death", var4);
  scripts\engine\utility::flag_set("dont_drone_nag");
  scripts\engine\utility::flag_set("boss_chopper_dead");

  if(scripts\engine\utility::flag("player_in_drone")) {
    scripts\engine\utility::flag_waitopen("player_in_drone");
  }

  scripts\engine\sp\utility::autosave_by_name("chu_chopper_dead");
  wait 0.6;

  if(var4.classname == "player") {
    level.player thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_containers_chopperdown_50", 1, 3);
    return;
  }
}

function fob_center_chopper_spawn_func() {
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

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  self delete();
}

function fob_chopper_transport_spawn_func() {
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

  if(scripts\engine\utility::flag("player_in_drone")) {
    scripts\engine\utility::flag_waitopen("player_in_drone");
  }

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  self delete();
}

function radiant_cockpit_light(var0) {
  var1 = getEnt(var0, "targetname");
  var1 setlightintensity(0.015);
  var1 setlightradius(100);
  var2 = self gettagorigin("tag_pilot1") + (22, -10, 32);
  var1.angles = self gettagangles("tag_pilot1") + (145, 0, 0);
  var1.origin = var2;
  var1 linkTo(self);
  scripts\engine\utility::waittill_any("entitydeleted", "death");
  var1 delete();
}

function center_chopper_save_watcher() {
  self waittill("death");

  if(scripts\engine\utility::flag("player_in_drone")) {
    scripts\engine\utility::flag_waitopen("player_in_drone");
    scripts\engine\sp\utility::autosave_by_name("center_chopper_dead");
    return;
  }
}

function chopper_crew_behavior() {
  var0 = scripts\engine\utility::get_target_array();
  self.gunners = [];

  foreach(var2 in var0) {
    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "gunner")) {
      self.gunners[self.gunners.size] = var2;
      thread crew_chopper_death_watcher_behavior(var2);
      thread crew_ignore_manager();
    }

    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "pilot")) {
      var2.ignoreme = 1;
      self.pilot = var2;
      var2._blackboard.isburning = 0;

      if(scripts\engine\utility::is_equal(self.targetname, "chu_chopper")) {
        var2 hide();
      }

      if(scripts\engine\utility::flag("air_support_inbound")) {
        var2.health = 100;
      }

      thread pilot_death_watcher(var2);
      thread chu_chopper_pilot_protector();
      thread wildfire_watcher();
    }
  }

  if(self.gunners.size > 0) {
    thread chopper_gunners_killed_watcher();
    return;
  }
}

function chu_chopper_pilot_protector() {
  self.pilot endon("death");

  if(scripts\engine\utility::is_equal(self.targetname, "chu_chopper")) {
    self.pilot scripts\common\ai::magic_bullet_shield();
    scripts\engine\utility::flag_wait("chu_fire_lights");
    wait 2;
    self.pilot scripts\common\ai::stop_magic_bullet_shield();
    return;
  }
}

function crew_ignore_manager() {
  self endon("death");
  self.ignoreme = 1;
  scripts\engine\utility::flag_wait("fob_exit_guards");
  wait 1;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::enemy_alive_counter_gate(2);
  self.ignoreme = 0;
}

function chopper_transport_crew_behavior() {
  var0 = scripts\engine\utility::get_target_array();
  self.gunners = [];

  foreach(var2 in var0) {
    var2.ignoreme = 1;

    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "gunner")) {
      self.gunners[self.gunners.size] = var2;
      thread crew_chopper_death_watcher_behavior(var2);
    }

    if(scripts\engine\utility::is_equal(var2.script_noteworthy, "pilot")) {
      self.pilot = var2;
      self.pilot.ignoreme = 1;

      if(scripts\engine\utility::flag("air_support_inbound")) {
        var2.health = 100;
      }

      thread pilot_death_watcher(var2);
      thread wildfire_watcher();
    }
  }

  if(self.gunners.size > 0) {
    thread chopper_gunners_killed_watcher();
  }

  self waittill("unloaded");
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);

  if(scripts\engine\utility::flag("fob_player_in_center_swarm")) {
    goal_ent_position(800, var0, "rear_goal_spots");
  } else {
    goal_ent_player(1200, var0);
  }

  wait 2;
  var0 = scripts\engine\utility::array_removedead_or_dying(var0);

  foreach(var2 in var0) {
    var2.ignoreme = 0;
  }
}

function fob_chopper_transport_guys_spawn_func() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  wait 13;
  self.ignoreme = 0;
  self.ignoreall = 0;
}

function tromeo_guys_03_spawn_func() {
  self.vehiclerunexit = 1;
}

function fob_center_chopper_guys_spawn_func() {
  self endon("death");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "gunner")) {
    scripts\engine\sp\utility::set_favoriteenemy(level.player);
    self.baseaccuracy = 0.1;
    self.ignoreall = 1;
    self.ignoreme = 1;
    wait 6;
    self.ignoreall = 0;
    self.ignoreme = 0;

    if(scripts\engine\utility::flag("air_support_inbound")) {
      scripts\engine\sp\utility::set_favoriteenemy(level.incomingapache);
      return;
    }

    return;
  }
}

function pilot_death_watcher(var0) {
  self endon("death");
  thread pilotkill_watcher();

  while(isalive(var0)) {
    waitframe();
  }

  self notify("pilot_killed");
  self.pilot_killed = 1;
  wait 1;
  self kill();
}

function pilotkill_watcher() {
  self waittill("death", var0, var1, var2, var3);

  if(isDefined(var0) && isPlayer(var0)) {
    if(isDefined(var1) && (var1 == "MOD_PISTOL_BULLET" || var1 == "MOD_RIFLE_BULLET" || var1 == "MOD_EXPLOSIVE_BULLET")) {
      level thread scripts\sp\utility::giveachievement_wrapper("pilotkill");
      return;
    }

    return;
  }
}

function wildfire_watcher() {
  self endon("vehicle_crashDone");
  self endon("in_air_explosion");

  for(;;) {
    self.pilot waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(isDefined(var9) && scripts\engine\utility::is_equal(var1, level.player)) {
      if(scripts\engine\utility::is_equal(var9.basename, "molotov")) {
        break;
      }
    }
  }

  level thread scripts\sp\utility::giveachievement_wrapper("wildfire");

  if(isDefined(self)) {
    self kill();
    return;
  }
}

function boss_pilot_death_watcher() {
  self endon("death");
  var0 = scripts\engine\utility::get_target_ent();
  var0 scripts\common\ai::magic_bullet_shield();
  var0.ignoreme = 1;
  scripts\engine\utility::flag_wait("chopper_wounded");
  wait 1;
  var0 scripts\common\ai::stop_magic_bullet_shield();
}

function boss_chopper_chu_behavior() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();
  self endon("death");
  var2 = scripts\engine\utility::getStruct("boss_chopper_chu_01", "targetname");
  self setvehgoalpos(var2.origin + (0, 0, -500), 1);
  self vehicle_setspeed(55, 20, 10);
  self setneargoalnotifydist(1000);
  self settargetyaw(var2.angles[1]);
  scripts\engine\utility::flag_set("boss_rockets_disabled");
  thread boss_heli_weapons_create();
  self sethoverparams(50, 20, 5);
  scripts\engine\utility::flag_wait("strafe_setup");
  var2 = scripts\engine\utility::getStruct("boss_chopper_chu_01", "targetname");
  self setvehgoalpos(var2.origin + (0, 0, 0), 1);
  wait 2;
  GscBinSkip4(0x35, 1);
}

function chopper_nags() {
  self endon("death");
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_gethadir();

  for(;;) {
    var0 thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::dialogue("Hit that chopper with an RC plane!");
    wait 18;
  }
}

function boss_chopper_rockets() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale::level_getfarah();
  var1 = spawnStruct();
  var2 = 1;
  self endon("death");
  var3 = 0;
  scripts\engine\utility::flag_waitopen("boss_rockets_disabled");

  while(!scripts\engine\utility::flag("boss_chopper_dead")) {
    if(scripts\engine\utility::flag("player_in_drone")) {
      scripts\engine\utility::flag_waitopen("player_in_drone");
    }

    if(scripts\engine\utility::flag("boss_rockets_disabled")) {
      scripts\engine\utility::flag_waitopen("boss_rockets_disabled");
    }

    var4 = level.player.origin;
    var5 = vectortoangles(var4 - self.origin);
    var6 = var5[1];
    wait randomfloatrange(1.9, 2.2);
    var7 = var4 + anglestoright(self.angles) * -20 + (0, 0, 25);
    var8 = var4 + anglestoright(self.angles) * 20 + (0, 0, 25);

    if(!scripts\engine\utility::flag("chopper_wounded")) {
      var7 += anglesToForward(level.player.angles) * var3;
      var8 += anglesToForward(level.player.angles) * var3;
    }

    var9 = self gettagorigin("tag_missile_l_4");
    var10 = self gettagorigin("tag_missile_r_4");
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_r_4");
    thread scripts\engine\utility::playsoundontag("weap_lalpha_fire_npc", "tag_missile_r_4");
    magicbullet("iw8_la_rpapa7_straight_weak", var10, var4);
    wait 0.5;

    if(scripts\engine\utility::flag("player_in_drone")) {
      continue;
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_l_4");
    thread scripts\engine\utility::playsoundontag("weap_lalpha_fire_npc", "tag_missile_l_4");
    magicbullet("iw8_la_rpapa7_straight_weak", var9, var4);
    level notify("boss_rockets_fired");
    wait 1.5;
  }
}

function chopper_rocket_behavior() {
  self endon("death");
  wait 4;

  for(;;) {
    var0 = distance(level.incomingapache.origin, self.origin);

    if(var0 < 500) {
      wait 1;
      continue;
    }

    wait randomfloatrange(1.9, 2.2);
    var1 = self.pods[0].origin;
    var2 = self.pods[0].origin;
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var1, var3);
    wait 1;
    var1 = self.pods[0].origin;
    var2 = self.pods[0].origin;
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var2, var3);
    wait 1;
    var1 = self.pods[0].origin;
    var2 = self.pods[0].origin;
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var1, var3);
    wait 1;
    var1 = self.pods[0].origin;
    var2 = self.pods[0].origin;
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFX(scripts\engine\utility::getfx("vfx_flash_mortar"), self.pods[0].origin, (1, 1, 1), (1, 1, 1));
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var2, var3);
    level notify("boss_rockets_fired");
    wait 3;
  }
}

function chopper_final_rocket_behavior() {
  self endon("death");
  wait 4;

  for(;;) {
    var0 = distance(level.incomingapache.origin, self.origin);

    if(var0 < 500) {
      wait 1;
      continue;
    }

    wait randomfloatrange(1.9, 2.2);
    var1 = self gettagorigin("tag_missile_l_1");
    var2 = self gettagorigin("tag_missile_r_1");
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_l_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var1, var3);
    wait 1;
    var1 = self gettagorigin("tag_missile_l_1");
    var2 = self gettagorigin("tag_missile_r_1");
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_r_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var2, var3);
    wait 1;
    var1 = self gettagorigin("tag_missile_l_1");
    var2 = self gettagorigin("tag_missile_r_1");
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_l_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var1, var3);
    wait 1;
    var1 = self gettagorigin("tag_missile_l_1");
    var2 = self gettagorigin("tag_missile_r_1");
    var3 = level.incomingapache.mainturret.origin + (0, 0, 20);
    playFXOnTag(scripts\engine\utility::getfx("vfx_flash_mortar"), self, "tag_missile_r_1");
    self playSound("weap_lalpha_fire_npc");
    magicbullet("apache_proj_sp", var2, var3);
    level notify("boss_rockets_fired");
    wait 3;
  }
}

function boss_heli_weapons_create() {
  var0 = "tag_light_2";
  var1 = (0, 0, 0);
  var2 = self gettagorigin(var0);
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

function boss_chopper_mg_attack() {
  self endon("death");
  level endon("boss_turret_disabled");
  self.can_see_drone = 0;
  self.can_see_player = 0;
  self.accuracy = 0;
  self.mgturret[0] settargetentity(level.player);
  self.mgturret[1] settargetentity(level.player);
  var0 = 0;
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
            for(var1 = 0; var1 < 4; var1++) {
              var2 = self.mgturret[0] gettagorigin("tag_flash");
              var3 = self.mgturret[1] gettagorigin("tag_flash");
              magicbullet("iw8_mg_lbravo", var2, level.player.origin + (0, 0, var1));
              playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[0], "tag_flash");
              wait 0.2;
              magicbullet("iw8_mg_lbravo", var3, level.player.origin + (0, 0, var1));
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
          for(var1 = 0; var1 < 5; var1++) {
            if(!isDefined(level.chopper_turret_target)) {
              return;
            }

            var2 = self.mgturret[0] gettagorigin("tag_flash");
            var3 = self.mgturret[0] gettagorigin("tag_flash");
            magicbullet("iw8_mg_lbravo", var2, level.chopper_turret_target.origin + (0, 0, var1));
            playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[0], "tag_flash");
            wait 0.15;

            if(!isDefined(level.chopper_turret_target)) {
              return;
            }

            magicbullet("iw8_mg_lbravo", var3, level.chopper_turret_target.origin + (0, 0, var1));
            playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[1], "tag_flash");
          }

          wait 2;
        }
      } else {
        self.can_see_drone = 0;
      }

      self.mgturret[0] turretfiredisable();
      self.mgturret[1] turretfiredisable();
      self.mgturret[0] cleartargetentity(level.player);
      self.mgturret[1] cleartargetentity(level.player);
    }

    waitframe();
  }
}

function turret_fire_enable() {
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

function fob_center_chopper_behavior() {
  self endon("death");
  self endon("kill_chopper_logic");
  self endon("chopper_gunners_dead");
  self.ignoreme = 1;
  var0 = 250;
  var1 = scripts\engine\utility::getStruct("fob_hover_bravo_struct_01", "targetname");
  self.hover_origin = var1.origin;
  self setvehgoalpos(self.hover_origin + (0, 0, 200), 1);
  self setneargoalnotifydist(1000);
  self waittill("near_goal");
  self clearlookatent();
  self setlookatent(level.player);
  self waittill("goal");
  self vehicle_setspeed(45, 20, 10);
  self clearlookatent();
  var2 = var1;
  var3 = 1000;
  var4 = -100;
  var5 = 20;
  self settargetyaw(var5);
  self vehicle_setspeed(30, 10, 5);

  for(;;) {
    if(scripts\engine\utility::flag("fob_player_in_center_swarm")) {
      var3 = 1000;
    }

    if(scripts\engine\utility::flag("fob_rear")) {
      var3 = 1000;
      var4 = 0;
    }

    var2 = var2 scripts\engine\utility::get_target_ent();
    self setvehgoalpos(var2.origin + (var3, var4, 100), 1);
    self waittill("goal");
    wait randomfloatrange(0.5, 2);
    var5 *= -1;
    self settargetyaw(var5);
  }
}

function fob_center_transport_behavior() {
  scripts\engine\utility::flag_wait("fob_center");
  self endon("death");
  self endon("kill_chopper_logic");
  self endon("chopper_gunners_dead");
  self endon("pilot_killed");
  self.ignoreme = 1;
  var0 = 250;
  var1 = scripts\engine\utility::getStruct("fob_hover_bravo_struct_01", "targetname");
  self.hover_origin = var1.origin;

  if(level.player.origin[1] > 33864) {
    self vehicle_teleport((-40444, 36636, -596), var1.angles);
    self.rightside = 1;
    self.hover_origin += (500, 500, 500);
  }

  self setvehgoalpos(self.hover_origin, 1);
  self setneargoalnotifydist(1000);
  self waittill("near_goal");
  self clearlookatent();
  self setlookatent(level.player);
  self waittill("goal");
  self vehicle_setspeed(75, 40, 20);
  var2 = var1;
  var3 = 1000;
  var4 = -1000;

  if(scripts\engine\utility::flag("fob_player_in_center_swarm")) {
    var3 = 1000;
  }

  if(scripts\engine\utility::flag("fob_rear")) {
    var3 = 1000;
    var4 = 0;
  }

  var5 = scripts\engine\utility::getStruct("fob_chopper_unload", "targetname");
  self setneargoalnotifydist(600);
  self setvehgoalpos(var5.origin + (0, 0, 120), 1);
  self waittill("near_goal");
  self sethoverparams(0, 0, 0);
  self waittill("goal");
  scripts\common\vehicle::vehicle_unload("both");
  self waittill("unloaded");
  self vehicle_setspeed(4, 15, 10);
  self setvehgoalpos(var5.origin + (-550, 0, 400), 0);
  wait 3;
  self clearlookatent(level.player);
  self settargetyaw(270);
  self vehicle_setspeed(15, 15, 10);
  self waittill("goal");
  self vehicle_setspeed(20, 15, 10);
  wait 1;
  self setvehgoalpos(var5.origin + (-1400, -1000, 800), 1);
  self waittill("goal");
  var6 = scripts\engine\utility::getStruct("transport_chopper_end", "targetname");
  self.hover_origin = var6.origin + (0, -2000, 20);
  self setvehgoalpos(self.hover_origin, 1);
}

function fob_ks_chopper_behavior(var0) {
  self endon("death");
  self endon("kill_chopper_logic");
  self endon("chopper_gunners_dead");
  var1 = 0;
  var2 = 0;
  var3 = randomintrange(300, 350);
  self vehicle_setspeed(45, 20, 10);
  self setvehgoalpos(var0.origin, 1);
  self waittill("goal");

  for(;;) {
    self vehicle_setspeed(25, 15, 10);
    var0 = var0 scripts\engine\utility::get_target_ent();
    self setvehgoalpos(var0.origin + (var1, var2, var3), 1);
    self waittill("goal");
    wait 1;
  }
}

function chopper_damage_watcher() {
  self endon("death");
  self.bullet_health = 200;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(var0 > 300 && var1 == level.player || self.bullet_health < 1) {
      break;
    }
  }

  scripts\engine\utility::flag_set("chopper_wounded");
  self kill();
}

function boss_chopper_damage_watcher() {
  while(!scripts\engine\utility::flag("chopper_wounded")) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(var0 > 400 && scripts\engine\utility::is_equal(var1, level.player) || scripts\engine\utility::is_equal(var9, scripts\sp\utility::make_weapon("iw8_la_rpapa7_straight_slow"))) {
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

function lb_attack_runs() {
  self endon("death");
  var0 = scripts\engine\utility::spawn_script_origin(level.player.origin, level.player.angles);
  var1 = 1;
  thread show_chopper();
  var2 = scripts\engine\utility::getStruct("bravo_strafe_01", "targetname");
  var2.origin += (0, -500, 0);
  var3 = scripts\engine\utility::getStruct("boss_chopper_chu_06", "targetname");
  var3.origin += (0, -20, 0);
  var4 = -150;
  var5 = 0;
  level.allies = scripts\engine\utility::array_removedead_or_dying(level.allies);
  var6 = scripts\engine\utility::array_add(level.allies, level.player);
  var6 = scripts\engine\utility::array_randomize(var6);
  var0.origin = scripts\engine\utility::random(var6).origin;
  self settargetyaw(65);
  self vehicle_settopspeedrotational(10);

  if(!var1) {
    var2 = var3;
    var4 = 0;
    level notify("attack_run_starting");
  } else {
    var5 = 3;
  }

  wait var5;
  var7 = (var2.origin[0], var2.origin[1], var2.origin[2] + var4);
  self setvehgoalpos(var7, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  scripts\engine\utility::flag_wait_any("chu_strafe_run_go", "player_in_drone");
  self settargetyaw(90);
  wait 2;
  thread chu_explosion();
  self setmaxpitchroll(40, 40);
  var8 = (var2.origin[0], var2.origin[1] + 3000, -150);
  var9 = var8 + anglesToForward((0, 90, 0)) * 500 + (0, 200, 0);
  var10 = var9 + (-1000, -4000, 0);

  if(!var1) {
    var10 = var9 + (-200, -4000, 0);
  }

  self vehicle_setspeed(35, 30, 5);
  self setvehgoalpos(var8, 0);
  self setneargoalnotifydist(600);
  level notify("chu_attack_start");
  GscBinSkip4(0x35, var0, var1);
}

function show_chopper() {
  scripts\engine\utility::flag_wait_any("chu_strafe_run_go", "player_in_drone");
  self showallparts();

  foreach(var1 in self.mgturret) {
    var1 showallparts();
  }

  self.pilot show();
}

function chu_chopper_yaw_updater() {
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

function lb_mg_50cal(var0, var1) {
  var2 = 1.1;

  if(var1) {
    var2 = 0;
  }

  wait var2;
  var3 = 30;
  var4 = -40;
  var5 = spawnStruct();
  var5.origin = (-41481, 34229, -726);

  if(!var1) {
    var5.origin = (-41891, 34029, -726);
  }

  var6 = var5.origin;
  thread lb_mg_50cal_sound();
  var7 = self.mgturret[0] gettagorigin("tag_flash");
  var8 = self.mgturret[1] gettagorigin("tag_flash");
  self endon("death");
  var9 = var3;

  while(var9 > var4) {
    var10 = var9 * -30;
    var7 = self.mgturret[0] gettagorigin("tag_flash");
    var8 = self.mgturret[1] gettagorigin("tag_flash");
    magicbullet("iw8_mg_lbravo", var7, var6 + (0, var10, 0));
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[0], "tag_flash");
    wait 0.1;
    magicbullet("iw8_mg_lbravo", var8, var6 + (130, var10, 0));
    playFXOnTag(scripts\engine\utility::getfx("vfx_muz_minigun_chopper_w"), self.mgturret[1], "tag_flash");
    wait 0.05;
    var9 -= 2;
  }

  self notify("attack_done");
}

function boss_mg_50cal(var0) {
  var1 = 0.2;

  if(!var0) {
    var1 = 0;
  }

  wait var1;
  var2 = 36;
  var3 = -46;
  var4 = 110;
  var5 = spawnStruct();
  var5.origin = (-41491, 34029, -726);

  if(!var0) {
    var5.origin = (-41830, 33710, -726);
    var4 = 50;
  }

  var6 = var5.origin;
  thread lb_mg_50cal_sound();
  self endon("death");
  var7 = var2;

  while(var7 > var3) {
    var8 = self gettagorigin("tag_missile_l_4");
    var9 = self gettagorigin("tag_missile_r_4");
    var10 = var7 * -30;
    magicbullet("iw8_lm_pkilo", var8, var6 + (0, var10, 0));
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var8);
    magicbullet("iw8_lm_pkilo", var9, var6 + (var4, var10, 0));
    playFX(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), var9);
    wait 0.1;
    var7 -= 2;
  }

  self notify("attack_done");
}

function lb_mg_50cal_sound() {
  self playLoopSound("scn_safehouse_minigun_heli_gatling_fire");
  scripts\engine\utility::waittill_any("attack_done", "death");
  self stoploopsound("scn_safehouse_minigun_heli_gatling_fire");
}

function lb_gunner() {
  var0 = getEnt("lb_door_gunner_og", "targetname");
  var1 = scripts\engine\utility::spawn_tag_origin(var0.origin, var0.angles);
  var1 linkTo(self);
  var2 = scripts\engine\sp\utility::spawn_targetname("lb_door_gunner");
  var2 linkTo(var1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var2 allowedstances("crouch");
  var2 endon("death");
  self waittill("death");
  var2 kill();
}

function crew_chopper_death_watcher_behavior(var0) {
  var0 endon("unloaded");
  self endon("death");
  var0 waittill("death");
  wait 2;
  self kill();
}

function crew_chopper_transport_behavior(var0) {
  self endon("death");
  var0 waittill("goal");

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "gunner")) {
    self.ignoreme = 1;
    var0 waittill("unloaded");
    self.ignoreme = 0;
    self.ignoreall = 0;
    return;
  }
}

function chopper_gunners_killed_watcher() {
  self endon("death");

  while(self.gunners.size > 0) {
    self.gunners = scripts\engine\utility::array_removedead_or_dying(self.gunners);
    wait 0.1;
  }

  self notify("chopper_gunners_dead");

  if(scripts\engine\utility::flag("air_support_inbound")) {
    self kill();
    return;
  }
}

function chopper_pilot_death_watcher() {
  self endon("death");
  self.pilot waittill("death");
  self kill();
}

function heli_mg(var0) {
  var1 = self.mg.origin + anglesToForward(self.angles) * -500;

  for(var2 = 0; var2 < 30; var2++) {
    magicbullet("iw8_lm_kilo121", self.mg.origin, var0);
    magicbullet("iw8_lm_kilo121", self.mg.origin, var0 + (randomintrange(-20, 20), 10, randomintrange(-20, 20)));
    wait 0.075;
  }

  wait 1;

  if(isDefined(self.first_struct)) {
    for(var2 = 0; var2 < 20; var2++) {
      magicbullet("iw8_lm_kilo121", self.mg.origin, var0);
      magicbullet("iw8_lm_kilo121", self.mg.origin, var0 + (randomintrange(-20, 20), 10, randomintrange(-20, 20)));
      wait 0.075;
    }

    return;
  }
}

function spawn_check_func(var0, var1, var2) {
  if(scripts\engine\utility::flag("ai_spawner_busy")) {
    scripts\engine\utility::flag_waitopen("ai_spawner_busy");
  }

  scripts\engine\utility::flag_set("ai_spawner_busy");

  if(!isDefined(var0)) {
    var0 = 32;
  }

  var3 = getaiarray("axis", "allies");
  var4 = var0 - var3.size;
  var5 = getspawnerarray(var1);
  var6 = [];

  if(var4 == 0) {
    scripts\engine\utility::flag_clear("ai_spawner_busy");
    return undefined;
  }

  if(var5.size - var4 < 0) {
    var4 = var5.size;
  }

  if(isDefined(var2) && var2 < var4) {
    var4 = var2;
  }

  for(var7 = 0; var7 < var4; var7++) {
    var8 = var0 - var3.size;

    if(var8 <= 0) {
      break;
    }

    var6 = var5[var7] scripts\engine\sp\utility::spawn_ai(1);
    var5[var7].count = 1;
  }

  scripts\engine\utility::flag_clear("ai_spawner_busy");
  return var6;
}

function oil_fires_init() {
  wait 1;
  var0 = getEntArray("oil_fire_ogs", "targetname");

  foreach(var2 in var0) {}

  thread tarmac_gameplay_fires();
}

function tarmac_gameplay_fires() {
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

function cull_redshirts_for_startpoint(var0, var1) {
  var2 = [];

  if(var0.size > var1) {
    GscBinSkip0(0x2e, var2.size, scripts\engine\utility::array_remove(var0, var0[var0.size - 1]));
  }

  var2 = scripts\engine\utility::array_remove_array(var0, var2);
  scripts\engine\utility::array_delete(var0);
  return var2;
}

function town_technical_01() {
  level.technical_01 = scripts\common\vehicle::spawn_vehicle_from_targetname("technical_01");
  level.technical_01.maxhealth = 50000;
  level.technical_01.regenerate = 1;
  var0 = getvehiclenode("technical_start_01", "targetname");
  level.technical_01 scripts\common\vehicle::godon();
  var1 = getEntArray("truck_lights", "targetname");
  waitframe();
  var2 = 2.5;

  foreach(var4 in var1) {
    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "left")) {
      var4.origin = level.technical_01 gettagorigin("tag_light_front_left");
      var4.origin += anglesToForward(var4.angles) * var2;
      var4.angles = level.technical_01 gettagangles("tag_light_front_left");
      var4 linkTo(level.technical_01);
      playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_left_nolight"), level.technical_01, "tag_light_front_left");
    }

    if(scripts\engine\utility::is_equal(var4.script_noteworthy, "right")) {
      var4.origin = level.technical_01 gettagorigin("tag_light_front_right");
      var4.origin += anglesToForward(var4.angles) * var2;
      var4.angles = level.technical_01 gettagangles("tag_light_front_right");
      var4 linkTo(level.technical_01);
      playFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_right_nolight"), level.technical_01, "tag_light_front_right");
    }
  }

  level.technical_01 scripts\common\vehicle::attach_vehicle_and_gopath(var0);
  level.technical_01 endon("death");
  level.technical_01 endon("entitydeleted");
  level.technical_01 vehicle_setspeedimmediate(18, 5);
  wait 6;
  level.technical_01 vehicle_setspeedimmediate(5, 5);

  while(level.technical_01.veh_speed) {
    wait 0.1;
  }

  level notify("technical_stopped");
  wait 4;
  level.technical_01 scripts\common\vehicle::godoff();
  level.technical_01 endon("death");
  scripts\engine\utility::flag_wait("bunker_busted");

  foreach(var4 in var1) {
    var4 setlightintensity(0);
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_right_nolight"), level.technical_01, "tag_light_front_right");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_veh_headlight_pindia_left_nolight"), level.technical_01, "tag_light_front_left");
}

function technical_dudes_01_spawn_func() {
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

function pre_charge_wallspawner_spawn_func() {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\engine\utility::set_movement_speed(180);
  self waittill("goal");

  if(!istrue(self.general)) {
    self delete();
    return;
  }
}

function fob_guys_center_start_spawn_func() {
  scripts\engine\sp\utility::set_goal_pos((-36846.9, 33612.3, -644));
  self.shouldjoinsquad = 1;
}

function fob_guys_center_spawn_func() {}

function tromeo_guys_spawn_func() {}

function objective_manager() {
  waitframe();
  var0 = getnode("hadir_rooftop_node", "targetname");
  scripts\engine\sp\objectives::objective_add("reach_roof", "current", var0.origin + (0, 0, 100), &"SAFEHOUSE_FINALE_LOC/OBJ_UPSTAIRS");
  scripts\engine\utility::flag_wait("intro_player_behind_hadir");
  scripts\engine\sp\objectives::objective_remove("reach_roof");
  var1 = getEnt("player_tablet", "targetname");
  scripts\engine\sp\objectives::objective_add("get_controls", "current", var1.origin + (0, 0, 20), &"SAFEHOUSE_FINALE_LOC/GET_CONTROLS");
  scripts\engine\utility::flag_wait("player_has_tablet");
  scripts\engine\sp\objectives::objective_remove("get_controls");
  var2 = getEntArray("destroyed_tarmac_choppers", "script_noteworthy")[0];
  var3 = spawnStruct();
  var3.origin = var2.origin;

  if(!scripts\engine\utility::flag("fly_attack_done")) {
    while(!isDefined(level.choppers[0])) {
      waitframe();
    }

    scripts\engine\sp\objectives::objective_add("crash", "current", var3.origin + (0, 0, 20), &"SAFEHOUSE_FINALE_LOC/CRASH_RC");
    scripts\engine\sp\objectives::objective_set_on_entity("crash", undefined, level.choppers[0]);
    scripts\engine\utility::flag_wait("fly_attack_done");
    scripts\engine\sp\objectives::objective_remove("crash");
  }

  var4 = spawnStruct();
  var4.origin = (-33439, 31016, -622.09);
  scripts\engine\sp\objectives::objective_add("hold_at_wall", "current", var4.origin, &"SAFEHOUSE_FINALE_LOC/REGROUP");
  scripts\engine\utility::flag_wait("bunker_busted");
  scripts\engine\sp\objectives::objective_remove("hold_at_wall");
  var5 = spawnStruct();
  var5.origin = (-36412, 33448, -604);
  scripts\engine\sp\objectives::objective_add("clear_bunkers", "current", var5.origin, &"SAFEHOUSE_FINALE_LOC/BUNKERS");
  scripts\engine\utility::flag_wait("fob_center");
  scripts\engine\sp\objectives::objective_remove("clear_bunkers");
  var6 = scripts\engine\utility::getStruct("armory_struct_01", "targetname");
  scripts\engine\sp\objectives::objective_add("secure_armory_01", "current", var6.origin, &"SAFEHOUSE_FINALE_LOC/ARMORY_01");
  scripts\engine\utility::flag_wait("armory_01_secure");
  scripts\engine\sp\objectives::objective_remove("secure_armory_01");
  scripts\engine\sp\objectives::objective_add("clear_fob", "current", undefined, &"SAFEHOUSE_FINALE_LOC/SECURE_AREA");
  scripts\engine\utility::flag_wait("fob_cleared");
  scripts\engine\sp\objectives::objective_remove("clear_fob");
  var7 = spawnStruct();
  var7.origin = (-40551, 34709, -700);
  scripts\engine\sp\objectives::objective_add("lookat_hadir", "current", var7.origin + (0, 0, 100), &"SAFEHOUSE_FINALE_LOC/REGROUP_GATE");
  scripts\engine\utility::flag_wait("container_door_breached");
  scripts\engine\sp\objectives::objective_remove("lookat_hadir");

  if(!scripts\engine\utility::flag("boss_chopper_dead")) {
    scripts\engine\utility::flag_wait("chu_strafe_run_go");

    while(!isDefined(level.chu_chopper)) {
      waitframe();
    }

    scripts\engine\sp\objectives::objective_add("boss_chopper", "current", undefined, &"SAFEHOUSE_FINALE_LOC/DESTROY_CHOPPER");
    scripts\engine\sp\objectives::objective_set_on_entity("boss_chopper", undefined, level.chu_chopper);
    scripts\engine\utility::flag_wait("boss_chopper_dead");
    scripts\engine\sp\objectives::objective_remove("boss_chopper");
  }

  var8 = spawnStruct();
  var8.origin = (-43901, 35648, -405);
  scripts\engine\sp\objectives::objective_add("clear_containers", "current", undefined, &"SAFEHOUSE_FINALE_LOC/CLEAR_CONTAINERS");
  scripts\engine\utility::flag_wait("chu_exit");
  scripts\engine\sp\objectives::objective_remove("clear_containers");
  var9 = scripts\engine\utility::getStruct("armory_struct_02", "targetname");
  scripts\engine\sp\objectives::objective_add("secure_armory_02", "current", var9.origin, &"SAFEHOUSE_FINALE_LOC/ARMORY_01");
  scripts\engine\utility::flag_wait("armory_02_secure");
  scripts\engine\sp\objectives::objective_remove("secure_armory_02");
  scripts\engine\sp\objectives::objective_add("survive", "current", undefined, &"SAFEHOUSE_FINALE_LOC/DEFEND_HANGAR");
  scripts\engine\utility::flag_wait("apache_here");
  scripts\engine\sp\objectives::objective_remove("survive");
  scripts\engine\sp\objectives::objective_add("apache", "current", undefined, &"SAFEHOUSE_FINALE_LOC/APACHE_THREATS");
  var10 = scripts\engine\sp\objectives::_objective_getindexforname("apache");
  level.tarmac_vindia_02.objindex = 0;
  level.tarmac_vindia_03.objindex = 1;
  objective_setlocation(var10, level.tarmac_vindia_02.objindex, level.tarmac_vindia_02);
  objective_setlocation(var10, level.tarmac_vindia_03.objindex, level.tarmac_vindia_03);
  scripts\engine\utility::array_thread([level.tarmac_vindia_02, level.tarmac_vindia_03], &location_objective_remover, var10);
  scripts\engine\utility::flag_wait("retreat");
  var11 = scripts\engine\utility::getStruct("molotov_guy_struct", "targetname");
  var12 = scripts\engine\utility::getStruct("mid_goal_spots", "targetname");
  level scripts\engine\utility::waittill_any_timeout(20, "killstreak_complete");
  scripts\engine\sp\objectives::objective_update("apache", "current", var11.origin, &"SAFEHOUSE_FINALE_LOC/APACHE_THREATS");

  if(!scripts\engine\utility::flag("killstreak_complete")) {
    level scripts\engine\utility::waittill_any("killstreak_complete", "second_retreat");

    if(!scripts\engine\utility::flag("killstreak_complete")) {
      scripts\engine\utility::flag_wait_or_timeout("killstreak_complete", 30);
      scripts\engine\sp\objectives::objective_update("apache", "current", var12.origin, &"SAFEHOUSE_FINALE_LOC/APACHE_THREATS");
    }
  }

  scripts\engine\utility::flag_wait("killstreak_complete");
  scripts\engine\sp\objectives::objective_remove("apache");
}

function location_objective_remover(var0) {
  level endon("killstreak_complete");
  var1 = self.objindex;
  self waittill("death");
  objective_unsetlocation(var0, var1);
}

function dialogue_safehouse_interior() {
  level.player endon("death");
  level.player waittill("first_droneControl");
  wait 3;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_safehouse_interior_planestart_80", 0, 1);
}

function dialogue_fly() {
  level.player_dronemodel endon("death");
  level endon("fly_crash_missed");
  GscBinSkip4(0x35);
}

function dist_to_chopper_pos() {
  var0 = scripts\engine\utility::getclosest(level.player_dronemodel.origin, level.choppers);
  return length2d(var0.origin - level.player_dronemodel.origin);
}

function dialoge_fly_off_course() {
  level endon("kill_off_course");
  var0 = ["dx_vom_had_fly_offcourse_10", "dx_vom_had_fly_offcourse_20", "dx_vom_had_fly_offcourse_30"];
  var1 = scripts\engine\sp\utility::create_deck(var0);
  var2 = 0.5;

  for(;;) {
    for(;;) {
      var3 = [];

      foreach(var5 in getEntArray("level_droneVehicle", "targetname")) {
        var3 = var5.origin;
      }

      if(var3.size == 0) {} else {
        var7 = averagepoint(var3);
        var8 = anglesToForward(level.player_dronemodel.angles);
        var9 = var7 - level.player_dronemodel.origin;
        var8 = (var8[0], var8[1], 0);
        var9 = (var9[0], var9[1], 0);
        var10 = length(var9);
        var8 /= length(var8);
        var9 /= var10;
        var10 = clamp(var10, 0, 2500);
        var11 = scripts\engine\math::remap(var10, 0, 2500, 90, 40);
        var12 = vectordot(var8, var9);
        var12 = clamp(var12, 0, 1);
        var13 = acos(var12);

        if(isDefined(var13) && var13 > var11) {
          break;
        }
      }

      waitframe();
    }

    level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter(var1 scripts\engine\sp\utility::deck_draw());
    var2 = min(var2 * 1.5, 6);
    wait var2;
  }
}

function dialogue_rooftops() {
  var0 = getEnt("hc_meeting_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("reached_hc_meeting", var0, 0);
  wait 6;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_pre_charge_setup_00");
  wait 0.5;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_pre_charge_setup_30");
  var1 = ["dx_vom_far_rooftop_moveup_r_30", "dx_vom_far_rooftop_moveup_r_40", "dx_vom_far_rooftop_moveup_r_50"];
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill_delayed(8, "reached_hc_meeting", var1, 10);
  thread vo_armen_bg_convo();
  thread vo_farah_hold_here();
  wait 0.5;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter_with_gesture("iw8_vm_ges_radio_shoulder_sp", "dx_vom_alx_rooftop_street_140", 0.5, 0.1);
  level scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_lass_rooftop_street_150");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter_with_gesture("iw8_vm_ges_radio_shoulder_sp", "dx_vom_alx_rooftop_street_160", 0.5, 0.1);
  scripts\engine\utility::flag_set("wall_approach_vo_finished");
}

function vo_farah_hold_here() {
  level endon("wall_approach_vo_finished");
  scripts\engine\utility::flag_wait("pep_talk_trigger");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_far_pre_charge_setup_80", 1);
}

function vo_armen_bg_convo() {
  wait 2;
  level.armen scripts\engine\sp\utility::smart_dialogue("dx_vom_lf3_rooftop_street_40");
  level.armen scripts\engine\sp\utility::smart_dialogue("dx_vom_lf3_rooftop_street_50");
}

function dialogue_pre_charge() {
  level.player endon("death");
  thread dialogue_pre_charge_branch();
  dialogue_pre_charge_pep();
  scripts\engine\utility::flag_wait_any("reached_pep_idle", "early_charge");

  if(!scripts\engine\utility::flag("early_charge")) {
    level notify("pep_talk_complete");
  }

  dialogue_pre_charge_fire_cannon();
}

function dialogue_pre_charge_pep() {
  level endon("early_charge");
  level waittill("pep_talk_start");
  level endon("player_dropped_in");
  level.player endon("weapon_fired");
  wait 0.8;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_far_pre_charge_setup_120");
  wait 0.2;
  level.armen scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_lf3_rooftop_street_130");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_far_pre_charge_setup_140");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_pre_charge_setup_190");
  level.armen thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_lf3_pre_charge_setup_170");
  var0 = [];

  foreach(var2 in level.allies) {
    if(var2 == level.farah || var2 == level.hadir || var2 == level.armen) {
      continue;
    }

    var0 = var2;
  }

  var0 = sortbydistance(var0, level.player.origin);
  var0[1] thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say("dx_vom_lf4_pre_charge_setup_180");
  wait 0.6;
}

function dialogue_pre_charge_fire_cannon() {
  wait 0.35;

  if(scripts\engine\utility::flag("early_charge")) {
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_pre_charge_setup_260", 1);
  } else {
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_pre_charge_prep_30", 1);
  }

  scripts\engine\utility::flag_wait("bunker_busted");
  setmusicstate("");
  level.farah waittill("weapon_fired");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_tarmac_intro_40");
}

function dialogue_pre_charge_branch() {}

function dialogue_charge() {
  level.player endon("death");
}

function dialogue_fob_bunkers() {
  level.player endon("death");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_bunkers_molotovuse_10");
  wait 3;
  level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_bunkers_assault_20");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_yas_bunkers_assault_30");
  wait 1;
  scripts\engine\utility::flag_wait_any("fob_center", "bunkers_push");
  level.farah thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_bunkers_assault_130");
  level.armen scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_lf3_bunkers_assault_140");
  wait 1;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_bunkers_assault_150");
  scripts\engine\utility::flag_set("finished_bunker_vo");
}

function dialogue_fob_center() {
  level.player endon("death");
  level endon("armory_01_secure");
  wait 3;
  scripts\engine\utility::flag_wait("finished_bunker_vo");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_fob_center_helos_10");
  level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_fob_center_intro_20");
  level thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_yas_fob_center_helos_30");
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

  if(!scripts\engine\utility::flag("fob_player_in_center_swarm")) {
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_01_locate_20");
  }

  scripts\engine\utility::flag_wait("fob_rear_trucks");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_armory_01_locate_90");
  var0 = (-40128, 34639, -600);
  var1 = (-40128, 34885, -600);
  var2 = (-40128, 35132, -600);
  thread wait_lookat_armory(var0);
  thread wait_lookat_armory(var1);
  thread wait_lookat_armory(var2);
  thread wait_hadir_sees_armory(var0);
  var3 = level scripts\engine\utility::waittill_any_return("looked_at_armory", "hadir_sees_armory") == "hadir_sees_armory";

  if(var3) {
    level.hadir thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_armory_01_locate_140");
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_01_locate_150");
    return;
  }

  level.player thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_armory_01_locate_120");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_01_locate_130");
}

function vo_armory_01_approach() {
  wait 2;
  say_on_closest_enemy("dx_vom_rcom_armory_01_interior_30");
  wait 1;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_01_locate_10");
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

function say_on_closest_enemy(var0, var1, var2) {
  var3 = getaiarray("axis");
  var3 = scripts\engine\utility::array_removedead_or_dying(var3);

  if(var3.size == 0) {
    return;
  }

  var4 = scripts\engine\utility::getclosest(level.player.origin, var3);
  var4 scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter(var0, var1, var2);
}

function wait_lookat_armory(var0) {
  level endon("hadir_sees_armory");
  level endon("looked_at_armory");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::wait_lookat(var0, 100);

  if(isDefined(level.saw_armory)) {
    level.saw_armory = undefined;
    level notify("looked_at_armory");
    return;
  }

  level.saw_armory = 1;
}

function wait_hadir_sees_armory(var0) {
  level endon("hadir_sees_armory");
  level endon("looked_at_armory");

  while(!scripts\engine\trace::ray_trace_passed(level.hadir getEye(), var0, [level.hadir], scripts\engine\trace::create_ainosight_contents())) {
    waitframe();
  }

  level notify("hadir_sees_armory");
}

function enemy_radio_vo() {
  scripts\engine\utility::flag_wait_or_timeout("player_in_drone", 8);
  level waittill("ai_killed");
  wait 2;
  level.playing_radio_dialogue = 1;
  var0 = [];
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_10");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_20");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_30");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_40");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_50");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_60");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_70");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_80");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_ru1_bunkers_ruradio_90");
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_line_on_enemy_radio("dx_vom_rcom_bunkers_ruradio_100");
}

function dialogue_armory_01() {
  level.player endon("death");
  GscBinSkip4(0x35);
}

function dialgue_armory_01_enemies() {
  scripts\engine\utility::flag_wait("fob_exit");
  level.enemy_armory_guards[0] endon("death");
  level.enemy_armory_guards[1] endon("death");
  level.enemy_armory_guards[1] scripts\engine\sp\utility::smart_dialogue("dx_vom_ru2_armory_01_interior_40");
  scripts\engine\utility::flag_wait("armory_01_trigger");
  level.enemy_armory_guards[0] scripts\engine\sp\utility::smart_dialogue("dx_vom_ru1_armory_01_interior_50");
}

function dialogue_armory_02() {
  level.player endon("death");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_tarmac_assault_210");
  scripts\engine\utility::flag_wait("armory_02_secure");
  wait 0.6;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::wait_combat_cooldown(0.4, 2);
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_armory_02_breach_170");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_02_breach_180");
  wait 25;
  var0 = ["dx_vom_far_armory_02_breach_190", "dx_vom_far_armory_02_breach_200", "dx_vom_far_armory_02_breach_210"];
  level.farah thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill("hangar_defend_start", var0, 12);
}

function wait_guys_all_reach_node(var0, var1) {
  var1 = squared(var1);

  foreach(var3 in [level.farah, level.hadir]) {
    while(distance2dsquared(var3.origin, var3.goalnode.origin) > var1) {
      waitframe();
    }
  }
}

function wait_guys_any_reach_node(var0, var1) {
  var1 = squared(var1);

  for(;;) {
    foreach(var3 in [level.farah, level.hadir]) {
      if(distance2dsquared(var3.origin, var3.goalnode.origin) < var1) {
        return;
      }
    }

    waitframe();
  }
}

function dialogue_armory_boost() {
  dialogue_check_lock_and_nag_boost();
  level endon("player_in_armory_02");
  var0 = ["dx_vom_had_armory_02_breach_111", "dx_vom_had_armory_02_breach_112", "dx_vom_had_armory_02_breach_113"];
  level.hadir_boost_nags = scripts\engine\sp\utility::create_deck(var0);
  level waittill("boost_jump_nag");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say(level.hadir_boost_nags scripts\engine\sp\utility::deck_draw());

  for(;;) {
    level waittill("boost_jump_nag");
    level waittill("boost_jump_nag");
    level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say(level.hadir_boost_nags scripts\engine\sp\utility::deck_draw());
  }
}

function dialogue_check_lock_and_nag_boost() {
  level.player endon("death");
  dialogue_nag_open_armory_02();
  level.hadir endon("trigger");
  thread dialogue_armory_hatch();
  wait 0.4;
  level.player thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_armory_02_breach_70", 1, 1);
  level.hadir waittill("goal");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_armory_02_breach_80");
  wait 8;
  var0 = ["dx_vom_had_armory_02_breach_90", "dx_vom_had_armory_02_breach_100", "dx_vom_had_armory_02_breach_110"];
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill(undefined, var0, 8);
}

function dialogue_nag_open_armory_02() {
  scripts\engine\sp\utility::battlechatter_off();

  if(scripts\engine\utility::flag("hadir_go_to_hatch")) {
    return;
  }

  level endon("hadir_go_to_hatch");
  wait 3;
  wait_guys_all_reach_node([level.farah, level.hadir], 350);
  thread armory_02_guards_vo();
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_armory_02_breach_10");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_02_breach_20");
  wait 0.2;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_02_breach_30");
  wait 4;
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [level.farah, "dx_vom_far_armory_02_breach_40"]);
}

function dialogue_armory_hatch() {
  level.player waittill("jumped_up");
  wait 5;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_armory_02_breach_120");

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

function nag_enter_armory() {
  level endon("player_fell");
  var0 = ["dx_vom_had_armory_02_breach_161", "dx_vom_had_armory_02_breach_162", "dx_vom_had_armory_02_breach_163"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  GscBinSkip4(0x35);
}

function watch_armory_clear() {
  level.enemy_armory_guards = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::array_removedeaddyingorundefined(level.enemy_armory_guards);
  scripts\engine\sp\utility::waittill_dead(level.enemy_armory_guards);
  scripts\engine\utility::flag_set("cleared_armory_02");
}

function dialogue_hangar_defend() {
  level.player endon("death");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_hangar_defend_10");
  scripts\engine\utility::flag_wait("power_kill");
  wait 0.85;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_tarmac_assault_220");
  wait 0.4;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_hangar_defend_81");
  scripts\engine\sp\utility::battlechatter_on();
  wait 10;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_hangar_defend_90");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_hangar_defend_100");
}

function armory_01_nag() {
  level.player endon("death");
  level endon("armory_01_trigger");
  level endon("armory_01_secure");
  level endon("ally_armory_01_secure");
  scripts\engine\utility::flag_wait("fob_cleared");
  wait 8;
  var0 = ["dx_vom_far_armory_01_locate_160", "dx_vom_far_armory_01_locate_170", "dx_vom_far_armory_01_locate_180"];
  level.farah childthread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill("armory_01_trigger", var0, 10, 2, 35);

  for(;;) {
    level waittill("started_nag", var1, var2);
    var3 = lookupsoundlength(var2) / 1000;
    childthread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::focus_reminder("armory_01_trigger", var3 + 20);
    wait var3 + 20;
  }
}

function dialogue_containers_gate() {
  level.player endon("death");
  var0 = getEnt("gate_truck_reverse_trigger", "targetname");
  scripts\engine\sp\utility::flag_trigger_init("player_in_truck_path", var0, 1);
  scripts\engine\utility::flag_wait_any("armory_01_secure", "ally_armory_01_secure");
  scripts\engine\utility::flag_wait_all("fob_exit", "fob_cleared", "hadir_at_truck");
  scripts\engine\utility::flag_wait("armory_dialogue_complete");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_armory_01_interior_80");
  var1 = ["dx_vom_far_fob_center_gotogate_10", "dx_vom_far_fob_center_gotogate_20", "dx_vom_far_fob_center_gotogate_30"];
  level.farah thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill_delayed(1, "farah_gate_lookat", var1, 10);
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
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_containers_trucksmash_120");

  if(scripts\engine\utility::flag("player_in_truck_path")) {
    wait 1;
  }

  var1 = ["dx_vom_had_containers_gate_90", "dx_vom_had_containers_gate_100", "dx_vom_had_containers_gate_110"];
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill_open("player_in_truck_path", var1, 6);
  scripts\engine\utility::flag_set("hadir_ramming_dialogue_complete");
}

function dialogue_containers_gate_smash() {
  thread gatesmash_laswell_convo();
  scripts\engine\utility::flag_wait("container_door_breached");
  scripts\engine\utility::flag_wait("chu_strafe_run_go");
  level.armen scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_lf3_containers_heliattack_10", 1);
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_containers_heliattack_20", 1);
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_containers_heliattack_30", 1);
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_containers_heliattack_60", 1);
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_containers_heliattack_50");
  wait 0.1;
  scripts\sp\maps\safehouse_finale\safehouse_finale_utility::player_resumeallowdrones();
  wait 8;

  if(!scripts\engine\utility::flag("boss_chopper_dead")) {
    level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_containers_heliattack_70");
  }

  scripts\engine\utility::flag_wait("chu_rear");
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_containers_combat_10");
  wait 2;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_containers_combat_40");
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_containers_combat_50");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_containers_combat_60");
  scripts\engine\utility::flag_set("containers_vo_finished");
}

function gatesmash_laswell_convo() {
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter_with_gesture("iw8_vm_ges_radio_shoulder_sp", "dx_vom_alx_containers_trucksmash_140", 0.5, 0.1);
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_lass_containers_trucksmash_150");
}

function player_in_area_check(var0, var1, var2, var3) {
  var4 = gettime();

  if(isDefined(var2)) {
    var2 *= 1000;
  }

  var3 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::default_if_undefined(var3, 1200);
  var1 = scripts\sp\maps\safehouse_finale\safehouse_finale_utility::default_if_undefined(var1, 0.9848);
  var5 = 600;

  for(;;) {
    if(isDefined(var2) && gettime() > var4 + var2) {
      break;
    }

    var6 = distance(level.player.origin, var0.origin);
    var7 = distance(level.player.origin, var0.origin);
    var8 = scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin + (0, 0, 50), var1);

    if(var0 != level.gate_truck) {
      var9 = var0 gettagorigin("tag_eye");

      if(sighttracepassed(level.player getEye(), var9, 0, level.player) && var8 && var6 <= var3) {
        break;
      }
    }

    if(var6 < var4) {
      break;
    } else if(var7 && var5 <= var2) {
      break;
    }

    waitframe();
  }

  level notify("player_looking");
}

function dialogue_tarmac() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("containers_vo_finished");
  thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::player_stopallowdrones();
  level.player notifyonplayercommandremove("player_droneControl", "+actionslot 1");
  scripts\engine\sp\utility::battlechatter_off("allies");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_containers_combat_70");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_yas_hangar_defend_30");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_hangar_defend_70");
  wait 1;
  level.player notifyonplayercommand("player_droneControl", "+actionslot 1");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_hangar_defend_71");
  scripts\engine\sp\utility::battlechatter_on("allies");
  wait 6;
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_tarmac_assault_10");
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_tarmac_assault_20");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_tarmac_assault_30");

  if(scripts\engine\utility::flag("hangar_entrance")) {
    return;
  }

  level endon("hangar_entrance");
  wait 3;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_tarmac_assault_40");
  wait 6;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_tarmac_assault_150");
  wait 1;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_tarmac_assault_151");
  wait 2;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_tarmac_assault_152");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_tarmac_assault_153");
}

function dialogue_killstreak_waiting() {
  level.player endon("death");
  level endon("air_support_inbound");
  wait 22;
  level.hadir scripts\engine\sp\utility::smart_dialogue("dx_vom_had_radar_planes_50");
  wait 1;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_killstreak_2ndwave_10");
  wait 0.5;
  level.farah scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_far_killstreak_2ndwave_20");
  wait 3;
  level.hadir scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_had_hangar_defend_120");
  scripts\engine\utility::delaythread(3, &scripts\engine\utility::flag_set, "air_support_dialogue_complete");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_apap_killstreak_chopper_intro_10");
  wait 6;
  var0 = ["dx_vom_apap_killstreak_chopper_intro_60", "dx_vom_apap_killstreak_chopper_intro_70", "dx_vom_apap_killstreak_chopper_intro_80"];
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::nagtill("air_support_inbound", var0, 12, 1.2);
}

function dialogue_killstreak_chopper() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("air_support_inbound");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_killstreak_chopper_intro_20");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_killstreak_chopper_intro_30");
  level scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_apap_killstreak_chopper_intro_40");
  thread chopper_chatter();
  scripts\engine\utility::flag_wait("killstreak_complete");
  thread mus_chopper_done();
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_killstreak_chopper_clear_20");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_apap_killstreak_chopper_clear_30");
  level.player scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_alx_killstreak_chopper_clear_40");
}

function mus_chopper_done() {
  wait 5;
  setmusicstate("mx_safehouse_finale_end");
}

function chopper_chatter() {
  level endon("killstreak_complete");
  GscBinSkip4(0x35);
}

function init_apache_chatter() {
  GscBinSkip4(0x35);
}

function take_out_armor_nags() {
  var0 = ["dx_vom_apap_killstreak_chopper_combat_280", "dx_vom_apap_killstreak_chopper_combat_290", "dx_vom_apap_killstreak_chopper_combat_300"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);

  while(level.ks_vehicles.size > 0) {
    level.incomingapache scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter(var1 scripts\engine\sp\utility::deck_draw());
    wait randomfloatrange(8, 12);
  }
}

function rpg_chatter() {
  wait 2;
  level.incomingapache thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_apap_killstreak_chopper_combat_170", 1, 1);
  level waittill("rpg_fired");
  wait 0.5;
  level.incomingapache thread scripts\sp\maps\safehouse_finale\safehouse_finale_utility::say_as_chatter("dx_vom_apap_killstreak_chopper_combat_160", 1, 0.25);
}

function dialogue_ending_scene() {
  level.player endon("death");
}

function sfx_airbase_alarm() {
  var0 = spawn("script_origin", (-40363, 32693, -285));
  var0 playLoopSound("scn_safehouse_fin_airbase_siren");
  level waittill("sfx_airbase_siren_stop");
  var0 scripts\engine\sp\utility::sound_fade_and_delete(6, 1);
}