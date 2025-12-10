/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_infil.gsc
*****************************************************/

section_

section_precache() {
  precacherumble("damage_light");
  precacherumble("light_2s");
  precacherumble("chopper_ride_rumble");
  precachestring(&"FLOOD_TANKS_FAIL");
  precachestring(&"FLOOD_FAIL_VEHICLE_CRUSH");
}

section_flag_inits() {
  common_scripts\utility::flag_init("infil_done");
  common_scripts\utility::flag_init("enemy_tank_killed");
  common_scripts\utility::flag_init("allies_run_for_garage");
  common_scripts\utility::flag_init("allies_in_position");
  common_scripts\utility::flag_init("allied_tank_killed");
}

infil_start() {
  maps\flood_util::player_move_to_checkpoint_start("streets_start");
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  maps\flood_util::spawn_allies();
  maps\_utility::vision_set_changes("flood_infil", 0);
  level.allies[0] maps\_utility::forceuseweapon("r5rgp", "primary");
  level.allies[1] maps\_utility::forceuseweapon("r5rgp+reflex_sp", "primary");
  level.allies[2] maps\_utility::forceuseweapon("r5rgp+acog_sp", "primary");
}

infil() {
  level.player disableweapons();
  level.player enableinvulnerability();
  maps\_utility::music_play("mus_flood_infil_ss");
  level.player setclienttriggeraudiozone("flood_infil", 0.1);
  common_scripts\utility::flag_wait("start_intro_sequence");
  thread maps\flood_audio::narration_flood_infil();
  thread maps\flood_audio::sfx_heli_infil();
  common_scripts\utility::flag_wait("intro_show_introtext");
  level.vtclassname = "script_vehicle_silenthawk_flood_player";
  maps\_vehicle::build_aianims(::setanims_flood_infil, vehicle_scripts\silenthawk::set_vehicle_anims);
  level.infil_global_offset = 0;
  level thread infil_flyin_player();
  level thread infil_flyin_allies();
  level thread setup_initial_ai();
  level thread setup_dead_destroyed_and_misc();
  level thread allies_first_advance();
  level maps\_utility::delaythread(level.infil_global_offset + 0.0, ::infil_sidestreet);
  level maps\_utility::delaythread(level.infil_global_offset + 0.0, ::rpg_guy_shoot_flyin_choopers);
  level maps\_utility::delaythread(level.infil_global_offset + 0.5, ::tank_battle);
  thread maps\flood_fx::fx_infil_heli_smoke();
  setsaveddvar("sm_sunSampleSizeNear", 0.6);
  level waittill("infil_done");
  level.player disableinvulnerability();
  maps\flood::streets();
}

health_debug() {
  for(;;) {
    iprintln(level.player.health);
    common_scripts\utility::waitframe();
    common_scripts\utility::waitframe();
  }
}

infil_flyin_player() {
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  var_0 = getent("player_heli_infil_clip", "targetname");
  var_0 hide();
  var_0 notsolid();
  level.player screenshakeonentity(0.5, 0.5, 0.5, 21, 0, 3, 0, 2.35, 0.75, 0.75);
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("infil_player_chopper_new");
  level.infil_heli_player = var_1;
  var_1 maps\_vehicle::godon();
  var_1 vehicle_turnengineoff();
  var_1 setmaxpitchroll(20, 10);
  var_1 vehicle_setspeedimmediate(50, 999);
  var_1 maps\_utility::delaythread(0.5, maps\_vehicle::vehicle_lights_off, "interior");
  level thread infil_vo(var_1);
  var_1 thread infil_silenthawk_landing_gear(7);
  level.allies[0].script_startingposition = 2;
  var_1 maps\_utility::guy_enter_vehicle(level.allies[0]);
  level.allies[1].script_startingposition = 3;
  var_1 maps\_utility::guy_enter_vehicle(level.allies[1]);
  level.allies[2].script_startingposition = 6;
  var_1 maps\_utility::guy_enter_vehicle(level.allies[2]);
  var_1.player_link_ent = common_scripts\utility::spawn_tag_origin();
  var_1.player_link_ent linkto(var_1, "tag_player", (20, 6, 0), (0, -66, 0));
  level.player playerlinktodelta(var_1.player_link_ent, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player common_scripts\utility::delaycall(0.15, ::playerlinktodelta, var_1.player_link_ent, "tag_player", 1, 25, 25, 20, 20, 1);
  var_1 thread infil_flyin_player_unload_gt();
  var_2 = common_scripts\utility::getstruct("player_chopper_lz", "targetname");
  var_2 waittill("trigger");
  thread maps\flood_audio::sfx_infil_heli_flyaway(var_1);
  wait 2.25;
  thread landing_vo();
  wait 0.5;
  level.player enableweapons();
  level notify("player_unloading");
  level.player maps\_utility::lerp_player_view_to_position_oldstyle((2380, -11463, -30), (0, 45, 0), 1);
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  setsaveddvar("hud_showStance", 1);
  level.player unlink();
  var_1.player_link_ent delete();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  var_0 show();
  var_0 solid();
  wait 0.35;
  common_scripts\utility::flag_set("infil_done");
  level thread maps\flood_util::flood_battlechatter_on(1);
  level.player.ignoreme = 1;
  wait 1.0;
  var_0 delete();
  wait 2.0;
  level.player.ignoreme = 0;
}

landing_vo() {
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_moveout");
  level maps\_utility::smart_radio_dialogue("flood_gp1_ondeck");
  level maps\_utility::smart_radio_dialogue("flood_hqr_helix47");
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_overlordpatchmeinto");
  level.player playSound("flood_hqr_roger");
}

player_ride_rumble() {
  level.player playrumblelooponentity("chopper_ride_rumble");
  level waittill("player_unloading");
  level.player stoprumble("chopper_ride_rumble");
  var_0 = level.infil_heli_player maps\flood_util::create_rumble_ent(700, undefined, 10);
  var_0 playrumblelooponentity("steady_rumble");
}

#using_animtree("generic_human");

setanims_flood_infil() {
  var_0 = vehicle_scripts\silenthawk::setanims();
  var_0[2].idle_alert = % flood_infil_ally1_loop;
  var_0[2].getout = % flood_infil_ally1_jumpout;
  var_0[3].idle_alert = % flood_infil_ally2_loop;
  var_0[3].getout = % flood_infil_ally2_jumpout;
  return var_0;
}

infil_silenthawk_landing_gear(var_0) {
  self notify("gear_up");
  wait(var_0);
  self notify("gear_down");
}

infil_vo(var_0) {
  var_0 maps\_utility::delaythread(0.0, maps\_anim::anim_single_solo, level.allies[0], "infil_vo", "tag_detach_right");
  level maps\_utility::smart_radio_dialogue("flood_hqr_bythetime");
  level maps\_utility::smart_radio_dialogue("flood_gp2_copythat");
  level maps\_utility::smart_radio_dialogue("flood_hlx_overlordbeadvisedhelix");
  var_0 notify("stop_infil_loop");
  level.allies[0] notify("stop_infil_loop");
  level maps\_utility::smart_radio_dialogue("flood_hqr_rogerthatfourseven");
}

infil_flyin_player_unload_gt() {
  var_0 = getnode("streets_leader_start_node", "targetname");
  var_1 = getnode("streets_ally_1_start_node", "targetname");
  var_2 = getnode("streets_ally_2_start_node", "targetname");
  level.allies[0] thread gt_get_to_cover_after_landing(self, var_0);
  level.allies[1] thread gt_get_to_cover_after_landing(self, var_1);
  level.allies[2] thread gt_get_to_cover_after_landing(self, var_2);
}

gt_get_to_cover_after_landing(var_0, var_1, var_2) {
  self setgoalnode(var_1);
  var_3 = self.goalradius;
  self.goalradius = 16;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();

  if(self.animname == "ally_0") {
    self.run_overrideanim = maps\_utility::getanim("price_exit_chopper_wave");
    thread revert_runoverrideanim();
  }

  var_0 waittill("unloaded");
  level thread maps\_utility::vision_set_changes("flood", 3);
  self unlink();
  self waittill("goal");
  self.goalradius = var_3;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
}

revert_runoverrideanim() {
  self endon("death");

  while(self getanimtime(maps\_utility::getanim("price_exit_chopper_wave")) < 0.5)
    common_scripts\utility::waitframe();

  while(self getanimtime(maps\_utility::getanim("price_exit_chopper_wave")) > 0.45)
    common_scripts\utility::waitframe();

  self.run_overrideanim = undefined;
  self.prevmovemode = "none";
  self notify("move_loop_restart");
}

infil_flyin_allies() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("infil_ally_chopper_new");
  level.infil_heli_ally = var_0;
  var_0 maps\_vehicle::godon();
  var_0 vehicle_turnengineoff();
  var_0 setmaxpitchroll(20, 60);
  var_0 vehicle_setspeedimmediate(60, 999);
  var_0 thread infil_silenthawk_landing_gear(7);
  var_1 = getnode("infil_redshirt_death", "targetname");
  var_2 = var_0 maps\_vehicle::vehicle_get_riders_by_group("passengers");
  var_0 waittill("unloaded");

  foreach(var_4 in var_2)
  var_4 thread chopper02_ally(var_1.origin);
}

vignette_old_choppers_for_test() {
  var_0 = common_scripts\utility::getstruct("vignette_infil_old", "script_noteworthy");
  var_1 = maps\_vignette_util::vignette_vehicle_spawn("infil_heli_player", "infil_heli_player");
  var_2 = maps\_vignette_util::vignette_vehicle_spawn("infil_heli_ally", "infil_heli_ally");
  var_3 = [];
  var_3["infil_heli_player"] = var_1;
  var_3["infil_heli_ally"] = var_2;
  var_0 thread maps\_anim::anim_single(var_3, "infil");
}

infil_flyin_old() {
  var_0 = maps\_vignette_util::vignette_vehicle_spawn("infil_heli_player", "infil_heli_player");
  level.infil_heli_player = var_0;
  level.infil_heli_player maps\_vehicle::godon();
  var_1 = maps\_vignette_util::vignette_vehicle_spawn("infil_heli_ally", "infil_heli_ally");
  level.infil_heli_ally = var_1;
  level.infil_heli_ally maps\_vehicle::godon();
  var_2 = maps\_vignette_util::vignette_actor_spawn("heli_01_copilot", "heli_01_copilot");
  var_3 = maps\_vignette_util::vignette_actor_spawn("heli_02_ally_01", "heli_02_ally_01");
  var_4 = maps\_vignette_util::vignette_actor_spawn("heli_02_ally_02", "heli_02_ally_02");
  var_5 = maps\_vignette_util::vignette_actor_spawn("heli_02_ally_03", "heli_02_ally_03");
  var_6 = maps\_vignette_util::vignette_actor_spawn("heli_02_ally_04", "heli_02_ally_04");
  var_0 vehicle_turnengineoff();
  var_1 vehicle_turnengineoff();
  thread maps\flood_audio::sfx_heli_infil();
  maps\_utility::delaythread(level.infil_global_offset + 9, maps\flood_fx::fx_heli_land);
  var_7 = common_scripts\utility::getstruct("vignette_infil_old", "script_noteworthy");
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  infil_vignette_remove_weapon(var_2);
  var_8 = [];
  var_8["infil_heli_player"] = var_0;
  var_8["infil_heli_ally"] = var_1;
  var_9 = maps\_utility::spawn_anim_model("player_rig");
  var_9 hide();
  var_9 linkto(var_0, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player playerlinktodelta(var_9, "tag_player", 1, 65, 65, 15, 15, 1);
  level.allies[0] linkto(var_0, "tag_player", (0, 0, 0), (0, 0, 0));
  level.allies[1] linkto(var_0, "tag_player", (40, 300, 0), (0, 0, 0));
  level.allies[2] linkto(var_0, "tag_player", (40, 200, 0), (0, 0, 0));
  var_10 = [];
  var_10["heli_01_copilot"] = var_2;
  var_11 = [];
  var_11["player_rig"] = var_9;
  var_11["ally_0"] = level.allies[0];
  var_12 = [];
  var_12["heli_02_ally_01"] = var_3;
  var_12["heli_02_ally_02"] = var_4;
  var_12["heli_02_ally_03"] = var_5;
  var_12["heli_02_ally_04"] = var_6;

  foreach(var_14 in var_10)
  var_14 linkto(var_0, "tag_player", (0, 0, 0), (0, 0, 0));

  foreach(var_14 in var_12)
  var_14 linkto(var_1, "tag_player", (0, 0, 0), (0, 0, 0));

  var_7 thread maps\_anim::anim_single(var_8, "infil");
  var_7 thread maps\_anim::anim_single(var_10, "infil");
  var_7 thread maps\_anim::anim_single(var_12, "infil");
  maps\_utility::delaythread(level.infil_global_offset + 0, ::helo_01_palyer_and_price, var_7, var_11, var_9);
  maps\_utility::delaythread(level.infil_global_offset + 13, ::helo_01_others);

  foreach(var_14 in var_12)
  var_14 maps\_utility::delaythread(level.infil_global_offset + 4.6, ::helo_02_dismount, var_7);

  wait(getanimlength(var_0 maps\_utility::getanim("infil")));
  var_0 maps\_vignette_util::vignette_vehicle_delete();
  var_1 maps\_vignette_util::vignette_vehicle_delete();
  var_2 maps\_vignette_util::vignette_actor_delete();
}

infil_vignette_remove_weapon(var_0) {
  if(isDefined(var_0.weapon))
    var_0 maps\_utility::gun_remove();
}

helo_01_palyer_and_price(var_0, var_1, var_2) {
  var_0 maps\_anim::anim_single(var_1, "infil");
  level.player unlink();
  var_2 delete();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  setsaveddvar("hud_showStance", 1);
  var_3 = getnode("streets_leader_start_node", "targetname");
  level.allies[0] unlink();
  level.allies[0] setgoalnode(var_3);
  level.allies[0].ignoresuppression = 1;
  level.allies[0].disablebulletwhizbyreaction = 1;
  common_scripts\utility::flag_set("infil_done");
}

helo_01_others() {
  var_0 = getnode("streets_ally_1_start_node", "targetname");
  var_1 = getnode("streets_ally_2_start_node", "targetname");
  level.allies[1] unlink();
  level.allies[1] setgoalnode(var_0);
  level.allies[1].ignoresuppression = 1;
  level.allies[1].disablebulletwhizbyreaction = 1;
  level.allies[2] unlink();
  level.allies[2] setgoalnode(var_1);
  level.allies[2].ignoresuppression = 1;
  level.allies[2].disablebulletwhizbyreaction = 1;
}

helo_02_dismount(var_0) {
  self unlink();
  var_0 maps\_anim::anim_single_solo(self, "infil_dismount");
  var_1 = getnode("infil_redshirt_death", "targetname");
  self.goalradius = 8;
  self setgoalnode(var_1);
  self waittill("goal");
  maps\_vignette_util::vignette_actor_delete();
}

chopper02_ally(var_0) {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 8;
  wait(randomfloatrange(0.5, 0.7));
  self setgoalpos(var_0);
  self waittill("goal");
  maps\_vignette_util::vignette_actor_delete();
}

unlink_ally_from_heli(var_0) {
  var_0 unlink();
}

swap_hi_res_dam(var_0) {
  var_1 = getent("flood_dam", "targetname");
  var_1 hide();
  wait(var_0);
  var_1 = getent("flood_dam", "targetname");
  var_1 show();
}

setup_dead_destroyed_and_misc() {
  level endon("player_on_ladder");
  var_0 = getEntArray("infil_start_destroyed", "targetname");

  foreach(var_2 in var_0) {
    var_3 = maps\_vehicle::vehicle_spawn(var_2);
    var_3 kill();
  }

  var_0 = getEntArray("infil_start_destroyed_lynx", "targetname");

  foreach(var_2 in var_0)
  var_2 kill();

  var_7 = maps\_vehicle::spawn_vehicle_from_targetname("tanks_burning_man7t");
  var_7 maps\_vehicle::godon();

  while(!isDefined(level.tank_ally_joel))
    common_scripts\utility::waitframe();

  var_8 = common_scripts\utility::getstruct("vignette_street_stop_sign_01", "script_noteworthy");
  var_8 thread crush_stop_sign_when_near_tank(165);
}

create_dead_guys() {
  var_0 = 10;
  var_1 = 8;
  var_2 = getent("dead_guy_ally", "targetname");
  var_3 = getnodearray("infil_dead_ally_node", "targetname");

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = var_3[randomint(var_3.size)];
    var_3 = common_scripts\utility::array_remove(var_3, var_5);
    var_2 maps\_utility::add_spawn_function(::dead_guy_spawn_func);
    var_6 = var_2 maps\_utility::spawn_ai();
    var_6 forceteleport(var_5.origin, (0, 0, randomfloat(300)));
    common_scripts\utility::waitframe();
  }
}

dead_guy_spawn_func(var_0) {
  self.allowdeath = 1;
  self.diequietly = 1;
  self kill();
}

setup_initial_ai() {
  var_0 = getEntArray("street_start_allies", "targetname");

  foreach(var_2 in var_0) {
    var_2 maps\_utility::add_spawn_function(::infil_redshirts_spawn_func);
    var_2 maps\_utility::delaythread(level.infil_global_offset + 0, maps\_utility::spawn_ai);
  }

  common_scripts\utility::flag_wait("flood_intro_tr_loaded");
  var_4 = maps\_utility::spawn_anim_model("lynx_smash");
  var_4.script_noteworthy = "tanks_cleanup";
  level.lynx_smash_array = [];
  level.lynx_smash_array["lynx_smash"] = var_4;
  var_5 = getent("lynx_smash_node", "targetname");
  var_5 thread maps\_anim::anim_first_frame(level.lynx_smash_array, "lynx_smash");
  var_6 = maps\_utility::spawn_anim_model("flood_tank_battle_barrier_01");
  var_6.script_noteworthy = "tanks_cleanup";
  var_7 = maps\_utility::spawn_anim_model("flood_tank_battle_barrier_02");
  var_7.script_noteworthy = "tanks_cleanup";
  var_8 = maps\_utility::spawn_anim_model("flood_tank_battle_window_frame");
  var_8.script_noteworthy = "tanks_cleanup";
  var_9 = maps\_utility::spawn_anim_model("flood_tank_battle_tankdebris");
  var_9.script_noteworthy = "tanks_cleanup";
  level.tank_window_array = [];
  level.tank_window_array["flood_tank_battle_barrier_01"] = var_6;
  level.tank_window_array["flood_tank_battle_barrier_02"] = var_7;
  level.tank_window_array["flood_tank_battle_window_frame"] = var_8;
  level.tank_window_array["flood_tank_battle_tankdebris"] = var_9;
  var_5 = getent("tank_window_node", "targetname");
  var_5 thread maps\_anim::anim_first_frame(level.tank_window_array, "tank_window");
}

enemy_tank_shoot_flyin_choopers() {
  self endon("death");
  self endon("end flyin script");
  self setmode("manual");

  while(!common_scripts\utility::flag("infil_done")) {
    self startfiring();
    self settargetentity(level.infil_heli_player, (0, 180, 80));
    wait 1;
    self setmode("manual");
    self stopfiring();
    self stopbarrelspin();
    wait(randomfloatrange(0.5, 1));
    self settargetentity(level.infil_heli_ally, (0, 0, -80));
    self startfiring();
    wait 1;
    self setmode("manual");
    self stopfiring();
    self stopbarrelspin();
    wait(randomfloatrange(0.5, 1));
  }

  self stopfiring();
  self stopbarrelspin();
  self cleartargetentity();
  self turretfiredisable();
}

allies_first_advance() {
  common_scripts\utility::flag_wait_all("enemy_tank_killed", "allies_first_advance");
  maps\_utility::activate_trigger("allies_first_advance", "targetname");
}

infil_sidestreet() {
  var_0 = common_scripts\utility::getstructarray("infil_sidestreet_bullet_array", "targetname");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("infil_heli_flyby01");
  var_1 thread create_passengers();
  var_1 vehicle_setspeedimmediate(60, 999);
  var_1 maps\_vehicle::godon();
  var_1 vehicle_turnengineoff();
  var_2 = common_scripts\utility::getstruct("infil_chopper_crash01", "targetname");
  var_1.perferred_crash_location = var_2;
  level maps\_utility::delaythread(3.2, ::kill_intro_chopper, var_1, var_1.riders);
  var_1 thread spawn_fx_at_hit_pos();
  magicbullet("rpg_straight", var_0[0].origin, (8877.4, -9400, 1890));
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("infil_heli_flyby02");
  var_1 vehicle_setspeedimmediate(60, 999);
  var_1 maps\_vehicle::godon();
  var_1 vehicle_turnengineoff();
  common_scripts\utility::noself_delaycall(1.5, ::magicbullet, "rpg_straight", var_0[1].origin, var_1.origin + (0, 0, 100));
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname("infil_heli_flyby03");
  var_1 vehicle_turnengineoff();
  var_1 maps\_utility::delaythread(3, maps\_vehicle::gopath);
  common_scripts\utility::noself_delaycall(5, ::magicbullet, "rpg_straight", var_0[0].origin, var_1.origin + (0, 0, 600));
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("infil_flyin_jet");

  foreach(var_5 in var_3)
  var_5 maps\_vehicle::godon();

  var_1 = maps\_utility::delaythread(12, maps\_vehicle::spawn_vehicles_from_targetname_and_drive, "tanks_landing_chopper_flyby");
}

spawn_fx_at_hit_pos() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  playFX(common_scripts\utility::getfx("vfx_nh90_impact_smoke"), var_3);
}

get_origin_for_rpg() {
  maps\flood_util::jkuprint(self.origin);
}

create_passengers() {
  var_0 = getent("infil_chooper_rider1", "targetname");
  var_1 = getent("infil_chooper_rider2", "targetname");
  var_2 = getent("infil_chooper_rider3", "targetname");
  var_3 = getent("infil_chooper_rider4", "targetname");
  var_4 = var_0 maps\_utility::spawn_ai();
  var_4.script_noteworthy = "tanks_cleanup";
  var_5 = common_scripts\utility::spawn_tag_origin();
  var_5.script_noteworthy = "tanks_cleanup";
  var_5.origin = self gettagorigin("tag_detach_left");
  var_5.angles = self gettagangles("tag_detach_left");
  var_5 linkto(self, "tag_detach_left");
  var_5 thread maps\_anim::anim_generic_loop(var_4, "heli_idle1");
  var_4 teleport(var_5.origin, var_5.angles);
  var_4 linkto(self);
  var_6 = var_1 maps\_utility::spawn_ai();
  var_6.script_noteworthy = "tanks_cleanup";
  var_7 = common_scripts\utility::spawn_tag_origin();
  var_7.script_noteworthy = "tanks_cleanup";
  var_7.origin = self gettagorigin("tag_detach_left");
  var_7.angles = self gettagangles("tag_detach_left");
  var_7 linkto(self);
  var_7 thread maps\_anim::anim_generic_loop(var_6, "heli_idle2");
  var_6 teleport(var_7.origin, var_7.angles);
  var_6 linkto(self);
  var_8 = var_2 maps\_utility::spawn_ai();
  var_8.script_noteworthy = "tanks_cleanup";
  var_9 = common_scripts\utility::spawn_tag_origin();
  var_9.script_noteworthy = "tanks_cleanup";
  var_9.origin = self gettagorigin("tag_detach_right");
  var_9.angles = self gettagangles("tag_detach_right");
  var_9 linkto(self);
  var_9 thread maps\_anim::anim_generic_loop(var_8, "heli_idle1");
  var_8 teleport(var_9.origin, var_9.angles);
  var_8 linkto(self);
  var_10 = var_3 maps\_utility::spawn_ai();
  var_10.script_noteworthy = "tanks_cleanup";
  var_11 = common_scripts\utility::spawn_tag_origin();
  var_11.script_noteworthy = "tanks_cleanup";
  var_11.origin = self gettagorigin("tag_detach_right");
  var_11.angles = self gettagangles("tag_detach_right");
  var_11 linkto(self);
  var_11 thread maps\_anim::anim_generic_loop(var_10, "heli_idle2");
  var_10 teleport(var_11.origin, var_11.angles);
  var_10 linkto(self);
  var_12 = [];
  var_12[var_12.size] = var_4;
  var_12[var_12.size] = var_6;
  var_12[var_12.size] = var_8;
  var_12[var_12.size] = var_10;
  self.infil_passengers = var_12;
}

kill_intro_chopper(var_0, var_1) {
  common_scripts\utility::noself_delaycall(0.25, ::playrumbleonposition, "grenade_rumble", level.player.origin + (0, 0, 200));
  var_0 kill();

  foreach(var_3 in var_0.infil_passengers) {
    var_3 unlink();
    var_3 stopanimscripted();
    var_3 kill();
    var_3 startragdollfromimpact("torso_upper", anglesToForward(var_3.angles) * 3000);
    wait(randomfloatrange(0.25, 0.85));
  }
}

tank_damage_player(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1))
    var_2 = spawn("trigger_radius", self.origin, 0, 90, 90);
  else
    var_2 = spawn("trigger_radius", self.origin + 130 * anglesToForward(self.angles), 0, 70, 70);

  var_2 enablelinkto();
  var_2 linkto(self);

  while(isDefined(var_2)) {
    var_2 waittill("trigger");

    if(level.player.health <= 34)
      var_3 = 999;
    else
      var_3 = level.player.health / level.player.damagemultiplier * 0.34;

    while(level.player istouching(var_2) && isalive(level.player)) {
      if(isDefined(var_0))
        level.player dodamage(var_0, level.player.origin);
      else
        level.player dodamage(var_3, level.player.origin);

      level.player playrumbleonentity("damage_light");
      wait 0.1;
    }

    if(!isalive(level.player)) {
      setdvar("ui_deadquote", &"FLOOD_FAIL_VEHICLE_CRUSH");
      self stopanimscripted();

      foreach(var_5 in level.lynx_smash_array)
      var_5 stopanimscripted();
    }
  }
}

#using_animtree("vehicles");

tank_battle() {
  maps\_utility::delaythread(level.infil_global_offset + 5.5, ::tank_wall_stuff);
  level.tank_ally_joel = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("infil_tank_ally_joel");
  level.tank_ally_joel maps\_vehicle::godon();
  level.tank_ally_joel maps\_utility::delaythread(0.25, maps\_vehicle::mgoff);
  level.tank_ally_joel vehicle_setspeed(12, 6);
  var_0 = getent("infil_tank_ally_pease", "targetname");
  var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
  var_1 vehicle_setspeed(12, 12);
  var_1 maps\_vehicle::godon();
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname("enemy_tank_infil_destroyed");
  var_2 maps\_vehicle::godon();
  var_2 maps\_vehicle::mgoff();
  var_2.mgturret[1] thread enemy_tank_shoot_flyin_choopers();
  wait 0.5;
  var_2 thread fire_cannon_at_target(var_1, 1, (0, 220, -12));
  wait 1.5;
  var_1 thread fire_cannon_at_target(var_2, 1, (0, -200, 10));
  maps\_utility::delaythread(0.75, common_scripts\utility::exploder, "tank_debri_hit_02");
  wait 1.25;
  var_2 thread fire_cannon_at_target(var_1, 1, (0, 0, 45));
  wait 0.85;
  var_1 kill();
  level.tank_ally_joel vehicle_setspeed(5);
  maps\_utility::delaythread(2, maps\_utility::activate_trigger_with_targetname, "redshirts_first_advance");
  wait 1.5;
  level.tank_ally_joel vehicle_setspeed(10.5, 6);
  wait 1;
  level.tank_ally_joel maps\_vehicle::mgon();
  level.tank_ally_joel.mgturret[0] settargetentity(var_2, (0, 0, 45));
  level.tank_ally_joel thread fire_cannon_at_target(var_2, 1, (0, 120, 20));
  wait 2;
  level.tank_ally_joel.mgturret[0] common_scripts\utility::delaycall(1.25, ::cleartargetentity);
  level.tank_ally_joel.mgturret[0] common_scripts\utility::delaycall(1.25, ::stopfiring);
  level.tank_ally_joel fire_cannon_at_target(var_2, 1, (0, 0, 45));
  wait 0.85;
  common_scripts\utility::exploder("tank_explosion_01");
  var_2 kill();
  wait 3.5;
  level.enemy_tank_wall thread fire_cannon_at_target(level.tank_ally_joel, 2, (0, 0, 45));
  wait 2;
  level.tank_ally_joel.mgturret[0] common_scripts\utility::delaycall(1, ::settargetentity, level.enemy_tank_wall, (0, 0, 45));
  wait 2.5;
  level.tank_ally_joel vehicle_setspeed(0, 6);
  level.tank_ally_joel fire_cannon_at_target(level.enemy_tank_wall, 1, (0, 0, 45));
  playFXOnTag(common_scripts\utility::getfx("tank_fire_ground_dust"), level.tank_ally_joel, "tag_origin");
  wait 0.5;
  level.enemy_tank_wall kill();
  common_scripts\utility::flag_set("enemy_tank_killed");
  level.tank_ally_joel vehicle_setspeed(10.5, 6);
  level.tank_ally_joel.mgturret[0] cleartargetentity();
  level.tank_ally_joel.mgturret[0] stopfiring();
  level.tank_ally_joel.mgturret[0] setconvergenceheightpercent(0.25);
  level.tank_ally_joel.mgturret[0] common_scripts\utility::delaycall(2, ::setmode, "auto_nonai");
  level.tank_ally_joel.mgturret[0] common_scripts\utility::delaycall(6, ::setconvergenceheightpercent, 1);
  level.tank_ally_joel.mgturret[0] maps\_utility::delaythread(6, ::mg_turret_do_something_while_waiting_for_player);
  var_3 = [];
  var_3[0] = "flood_pri_keepupwithteam";
  level.allies[0] maps\_utility::delaythread(15, maps\flood_util::play_nag, var_3, "player_at_corner", 25, 50, 1, 2);
  level.tank_ally_joel common_scripts\utility::delaycall(2, ::setturrettargetvec, anglesToForward(level.tank_ally_joel.angles));
  var_4 = getEntArray("streets_enemy_tank_soldiers_2", "targetname");

  foreach(var_6 in var_4) {
    var_6 maps\_utility::add_spawn_function(::enemy_tank_soldiers_2_init);
    var_6 maps\_utility::spawn_ai();
  }

  level thread maps\_utility::activate_trigger_with_targetname("corner_start");
  wait 1;
  level thread maps\_utility::autosave_by_name("infil_landing");
  var_8 = getnodearray("path_to_garage_node", "targetname");

  foreach(var_10 in var_8)
  var_10 disconnectnode();

  var_12 = getvehiclenode("allied_tank_corner_start", "targetname");
  var_12 waittill("trigger");
  level thread maps\_utility::smart_radio_dialogue("flood_tnk_ineedvisualon");
  level thread maps\_utility::smart_radio_dialogue("flood_tnk_onethreeengageleftgunner");
  var_13 = % flood_tank_battle_lynx_smash_tank;
  var_14 = getent("lynx_smash_node", "targetname");
  var_15 = spawnStruct();
  var_15.origin = getstartorigin(var_14.origin, var_14.angles, var_13);
  var_15.angles = getstartangles(var_14.origin, var_14.angles, var_13);
  level.tank_ally_joel vehicle_orientto(var_15.origin, var_15.angles, 0, 0.0);
  level.tank_ally_joel waittill("orientto_complete");
  level.tank_ally_joel vehicle_setspeedimmediate(0);
  common_scripts\utility::flag_wait("player_at_corner");
  level.tank_ally_joel.mgturret[0] setmode("manual");
  level.tank_ally_joel.mgturret[0] stopbarrelspin();
  var_0 = getent("enemy_tank_2", "targetname");
  level.enemy_tank_2 = var_0 maps\_utility::spawn_vehicle();
  level.enemy_tank_2 thread tank_invulnerable_warning();
  level.enemy_tank_2 maps\_vehicle::godon();
  level.enemy_tank_2 maps\_utility::delaythread(0.25, maps\_vehicle::mgoff);
  level.enemy_tank_2 maps\_vehicle::gopath();
  level.enemy_tank_2 vehicle_setspeedimmediate(6, 5);
  var_0 = getent("enemy_tank_3", "targetname");
  level.enemy_tank_3 = var_0 maps\_utility::spawn_vehicle();
  level.enemy_tank_3 thread tank_invulnerable_warning();
  level.enemy_tank_3 maps\_vehicle::godon();
  level.enemy_tank_3 maps\_utility::delaythread(0.25, maps\_vehicle::mgoff);
  level.enemy_tank_3 maps\_vehicle::gopath();
  level.enemy_tank_3 vehicle_setspeedimmediate(7, 5);
  level maps\_utility::delaythread(9, maps\_vehicle::spawn_vehicles_from_targetname_and_drive, "tanks_mainstreet_driveby");
  level maps\_utility::delaythread(14, ::kill_player_with_tanks, "tanks_patio_loitering");
  wait 2;
  var_16 = getent("tank_target_balcony", "targetname");
  level.tank_ally_joel thread maps\_utility::smart_radio_dialogue_overlap("flood_us12_on");
  level.tank_ally_joel fire_cannon_at_target(var_16, 1, undefined, undefined, "flood_us7_away");
  level thread maps\_utility::kill_deathflag("streets_wave_2a");
  wait 1.75;
  var_16 = getent("tank_target_planters", "targetname");
  level.tank_ally_joel thread maps\_utility::smart_radio_dialogue_overlap("flood_us11_on");
  level.tank_ally_joel fire_cannon_at_target(var_16, 1, undefined, undefined, "flood_us7_away");
  level thread maps\flood_streets::destroy_planter("planter_06");
  level thread maps\flood_streets::destroy_planter("planter_08");
  level thread maps\_utility::kill_deathflag("streets_wave_2b");
  level.tank_ally_joel.mgturret[0] common_scripts\utility::delaycall(5.5, ::settargetentity, level.enemy_tank_2, (0, 0, 45));
  var_17 = getent("enemy_tank_2_garage_target", "targetname");
  level.tank_ally_joel common_scripts\utility::delaycall(3, ::setturrettargetvec, var_17.origin + (400, 0, 300));
  level.tank_ally_joel common_scripts\utility::delaycall(10, ::setturrettargetent, level.enemy_tank_2);
  level thread enemy_mg_pin_down_player(level.enemy_tank_2.mgturret[1], level.enemy_tank_3.mgturret[1]);
  wait 1;
  level maps\_utility::delaythread(4, maps\_utility::smart_radio_dialogue, "flood_gs5_twotargetsat10");
  level thread maps\_utility::activate_trigger_with_targetname("second_street_advance");
  level thread animated_script_model(level.tank_ally_joel, var_14, #animtree, var_13);
  var_18 = getent("lynx_smash_col_tank_back", "targetname");
  var_18 moveto(var_18.origin + (0, -224, 96), 0.05);
  var_18 common_scripts\utility::delaycall(0.1, ::linkto, level.tank_ally_joel);
  level.tank_ally_joel notify("suspend_drive_anims");
  level.tank_ally_joel animscripted("tank_animation", var_14.origin, var_14.angles, var_13);
  level.tank_ally_joel maps\_utility::delaythread(3, ::tank_damage_player);
  level.tank_ally_joel common_scripts\utility::delaycall(3.25, ::playrumblelooponentity, "tank_rumble");
  var_14 thread maps\_anim::anim_single(level.lynx_smash_array, "lynx_smash");
  thread maps\flood_audio::sfx_lynx_smash();
  wait 6;
  level.enemy_tank_2 fire_cannon_at_target(level.tank_ally_joel, 1, 200 * anglesToForward(level.tank_ally_joel.angles) + (0, 0, 32));
  level thread middle_tank_vo();
  wait 1.5;
  level.enemy_tank_3 fire_cannon_at_target(level.tank_ally_joel, 1, (0, 0, 60));

  foreach(var_20 in level.tank_ally_joel.riders) {
    if(isDefined(var_20.magic_bullet_shield))
      var_20 maps\_utility::stop_magic_bullet_shield();
  }

  level thread maps\flood_util::hide_models_by_targetname("lynx_smash_col_before");
  level.tank_ally_joel kill();
  level.tank_ally_joel playrumbleonentity("heavy_1s");

  foreach(var_23 in level.allies)
  var_23.forcesuppression = 1;

  common_scripts\utility::flag_set("allied_tank_killed");
  level thread set_flag_when_allies_in_position();
  level thread set_flag_after_timer("allies_in_position", 5);
  common_scripts\utility::flag_wait("allies_in_position");
  wait 3;
  var_25 = getent("enemy_tank_2_window_target", "targetname");
  level.player.og_health = level.player.health;
  level.player.demigod = 1;
  level.enemy_tank_3 fire_cannon_at_target(var_25, 1);
  var_25 playrumbleonentity("heavy_1s");
  level.player maps\_utility::delaythread(0.2, ::disable_demigod);
  level thread maps\_utility::kill_deathflag("infil_ally_redshirt");
  thread maps\flood_audio::sfx_tank_bust_wall();
  wait 4;
  wait 1;
  var_13 = % flood_tank_battle_window_tank;
  var_14 = getent("tank_window_node", "targetname");
  var_15 = spawnStruct();
  var_15.origin = getstartorigin(var_14.origin, var_14.angles, var_13);
  var_15.angles = getstartangles(var_14.origin, var_14.angles, var_13);
  var_26 = getent("allied_tank_2", "targetname");
  var_26 = var_26 maps\_utility::spawn_vehicle();
  var_26 maps\_vehicle::godon();
  level.tank_wall_sfx linkto(var_26, "tag_origin", (120, 0, 100), (0, 0, 0));
  level thread animated_script_model(var_26, var_14, #animtree, var_13);
  var_26 notify("suspend_drive_anims");
  var_26 animscripted("tank_animation", var_14.origin, var_14.angles, var_13);
  var_26 playrumblelooponentity("tank_rumble");
  var_26 common_scripts\utility::delaycall(3, ::playrumbleonentity, "heavy_1s");
  var_26 common_scripts\utility::delaycall(4.75, ::stoprumble, "tank_rumble");
  var_26 thread tank_damage_player(999);
  var_26 thread tank_damage_player(999, 1);
  var_14 thread maps\_anim::anim_single(level.tank_window_array, "tank_window");
  thread maps\flood_fx::fx_tank_window_break();
  var_26 common_scripts\utility::delaycall(1.5, ::playrumbleonentity, "heavy_2s");
  var_25 = getent("tank_wallsmash_debris_col", "targetname");
  var_25 common_scripts\utility::delaycall(4, ::movez, 24, 0.1);
  wait 2.63;
  var_25 = getent("flag_remove_after_window_tank", "targetname");
  var_25 common_scripts\utility::trigger_off();
  var_25 = getent("streets_run_for_it", "targetname");
  var_25 common_scripts\utility::trigger_off();
  var_27 = getent("allied_tank_2_blocker", "targetname");
  var_27 notsolid();
  level.enemy_tank_2.veh_pathdir = "reverse";
  level.enemy_tank_2.veh_transmission = "reverse";
  level.enemy_tank_2 startpath();
  level.enemy_tank_2 vehicle_setspeed(5);
  level.enemy_tank_2 maps\_vehicle::vehicle_wheels_backward();
  wait 0.5;
  var_26 thread maps\_utility::smart_radio_dialogue_overlap("flood_gs5_on");
  var_26 fire_cannon_at_target(level.enemy_tank_2, 1, (0, 0, 60), undefined, "flood_us8_away");
  wait 0.5;
  level.enemy_tank_3.veh_pathdir = "reverse";
  level.enemy_tank_3.veh_transmission = "reverse";
  level.enemy_tank_3 startpath();
  level.enemy_tank_3 vehicle_setspeed(5);
  level.enemy_tank_3 maps\_vehicle::vehicle_wheels_backward();
  level.enemy_tank_2 kill();
  level thread set_flag_when_allies_in_garage();
  var_27 connectpaths();

  foreach(var_10 in var_8)
  var_10 connectnode();

  var_30 = garage_wave_get_furthest();
  level thread maps\_utility::activate_trigger_with_targetname("move_to_garage");
  var_30 thread garage_wave();
  common_scripts\utility::flag_set("allies_run_for_garage");
  level.allies[0] thread maps\_utility::smart_dialogue("flood_pri_headtotheparking");
  level.allies[0] thread allies_run_for_garage();
  level.allies[1] thread allies_run_for_garage();
  level.allies[2] thread allies_run_for_garage();
  wait 1;
  var_26 setturrettargetent(level.enemy_tank_3);
  wait 0.5;
  level.enemy_tank_3 fire_cannon_at_target(var_26, 1, (0, 0, 60));
  level.enemy_tank_3 vehicle_setspeed(0);
  wait 0.5;
  var_31 = [];
  var_31[var_31.size] = "run_stumble";
  var_31[var_31.size] = "run_flinch";
  var_31[var_31.size] = "run_duck";

  for(var_32 = 0; var_32 < 3; var_32++) {
    if(distance2d(level.allies[var_32].origin, var_26.origin) < 450 && level.allies[var_32].a.movement == "run")
      level.allies[var_32] thread stumble_anim(var_31[var_32]);
  }

  var_26 kill();
  var_26 playrumbleonentity("heavy_1s");
  maps\_utility::battlechatter_on("allies");
}

tank_invulnerable_warning() {
  var_0 = [];
  var_1 = 0;

  while(isalive(self)) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isplayer(var_3)) {
      var_0[var_0.size] = gettime();

      for(var_9 = 0; var_9 < var_0.size; var_9++) {
        if(gettime() - var_0[var_9] > 1000)
          var_0 = maps\_utility::array_remove_index(var_0, var_9);
      }

      maps\flood_util::jkuprint(var_0.size + " type: " + var_6);

      if(var_6 == "MOD_IMPACT" || var_6 == "MOD_GRENADE" || var_6 == "MOD_GRENADE_SPLASH") {
        var_1 = var_1 + 1;

        if(var_1 > 1)
          maps\_utility::display_hint("invulerable_frags");
      } else if(var_0.size > 5) {
        var_0 = [];
        maps\_utility::display_hint("invulerable_bullets");
      }
    }
  }
}

disable_demigod() {
  self.demigod = 0;
  self enableinvulnerability();
  common_scripts\utility::delaycall(2, ::disableinvulnerability);
}

stumble_anim(var_0) {
  var_0 = maps\_utility::getgenericanim(var_0);
  self.run_overrideanim = var_0;
  self setflaggedanimknob("stumble_run", var_0, 1, 0.2, 1, 1);
  wait 1.5;

  while(self getanimtime(var_0) > 0.45)
    common_scripts\utility::waitframe();

  self.run_overrideanim = undefined;
  self notify("movemode");
}

garage_wave_get_furthest() {
  var_0 = getnode("tanks_garage_wave", "targetname");
  var_1 = distance2d(level.allies[1].origin, var_0.origin);
  var_2 = distance2d(level.allies[2].origin, var_0.origin);

  if(var_1 > var_2) {
    level.allies[1] maps\_utility::clear_force_color();
    return level.allies[1];
  } else {
    level.allies[2] maps\_utility::clear_force_color();
    return level.allies[2];
  }
}

#using_animtree("generic_human");

garage_wave() {
  level endon("waver_stop");
  var_0 = getnode("tanks_garage_wave", "targetname");
  var_1 = [];
  var_1[var_1.size] = % flood_garage_waving_ally_01;
  maps\_utility::set_force_color("o");
  maps\_utility::disable_sprint();
  self.og_goalradius = self.goalradius;
  self.goalradius = 0;
  thread release_waver();

  if(self.animname == "ally_1") {
    while(distance2d(self.origin, level.allies[0].origin) < 300 || distance2d(self.origin, level.allies[2].origin) < 300)
      common_scripts\utility::waitframe();
  } else {
    while(distance2d(self.origin, level.allies[0].origin) < 300 || distance2d(self.origin, level.allies[1].origin) < 300)
      common_scripts\utility::waitframe();
  }

  self setgoalnode(var_0);
  self waittill("goal");
  wait 1;
  thread maps\_anim::anim_generic_loop(self, "garage_waving", "stop_loop");
}

release_waver() {
  level.player endon("death");
  var_0 = getent("tanks_release_waver", "targetname");
  var_0 waittill("trigger");
  level notify("waver_stop");
  self notify("stop_loop");
  self stopanimscripted();
  level thread maps\_utility::activate_trigger_with_targetname("release_waver");
  self.goalradius = self.og_goalradius;
}

middle_tank_vo() {
  level.player endon("death");
  wait 0.5;
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_enemyarmorgetto");
  wait 1;
  level maps\_utility::smart_radio_dialogue("flood_gs6_thompsonisdown");
  level thread maps\_utility::battlechatter_off("allies");
  level.allies[0] maps\_utility::smart_dialogue("flood_pri_werepinneddownby");
  level maps\_utility::smart_radio_dialogue("flood_us9_werealmostthere");
}

enemy_mg_pin_down_player(var_0, var_1) {
  level.player endon("death");
  var_0 setmode("manual");
  var_1 setmode("manual");

  for(;;) {
    if((common_scripts\utility::flag("infil_player_in_open") || common_scripts\utility::flag("infil_player_in_open_behind_tank")) && !common_scripts\utility::flag("allies_run_for_garage")) {
      if(isalive(var_0)) {
        var_0 settargetentity(level.player);
        var_0 startfiring();
        var_0 setconvergencetime(0);
      }

      var_1 settargetentity(level.player);
      var_1 startfiring();
      var_1 setconvergencetime(0);
      wait_player_not_in_open_or_needs_garage();
    } else if(!common_scripts\utility::flag("allies_run_for_garage")) {
      if(isalive(var_0)) {
        var_0 stopfiring();
        var_0 stopbarrelspin();
      }

      var_1 stopfiring();
      var_1 stopbarrelspin();

      if(isalive(var_0)) {
        var_0.mg_target = var_0 enemy_mg_get_untargeted_random_target();
        var_0 thread enemy_mg_adjust_if_target_dies(var_0.mg_target);
        var_0 thread enemy_mg_burst_fire();
      }

      var_1.mg_target = var_1 enemy_mg_get_untargeted_random_target();
      var_1 thread enemy_mg_adjust_if_target_dies(var_1.mg_target);
      var_1 thread enemy_mg_burst_fire();
      common_scripts\utility::flag_wait_any("infil_player_in_open", "infil_player_in_open_behind_tank", "allies_run_for_garage");

      if(isalive(var_0))
        var_0.mg_target.is_currently_mg_target = undefined;

      var_1.mg_target.is_currently_mg_target = undefined;
    } else {
      var_2 = [];
      var_2[0] = "flood_vrg_cmoneliaskeepup";
      var_2[1] = "flood_mrk_makearunfor";
      var_2[2] = "flood_pri_cmoneliasgetto";
      level.allies[1] maps\_utility::delaythread(15, maps\flood_util::play_nag, var_2, "firing_garage_shot", 10, 30, 1, 2);

      while(!common_scripts\utility::flag("firing_garage_shot")) {
        var_1 enemy_mg_shoot_randomly_at_player_until_he_runs_for_it();
        maps\flood_util::jkuprint("player running for it");
        var_3 = maps\_utility::get_ai_group_ai("streets_enemy_tank_soldiers");

        foreach(var_5 in var_3)
        var_5.baseaccuracy = 0;

        if(isalive(level.infil_rpg_guy))
          level.infil_rpg_guy.baseaccuracy = 0;

        level.enemy_tank_3 setturrettargetent(level.player);
        var_1 setconvergencetime(0);
        var_1 settargetentity(getent("tank_window_node", "targetname"));
        var_1 startfiring();
        var_1 common_scripts\utility::delaycall(1, ::setconvergencetime, 2);
        var_1 common_scripts\utility::delaycall(1, ::settargetentity, level.player);
        maps\_utility::delaythread(1, maps\flood_util::jkuprint, "player is turret target");
        common_scripts\utility::flag_waitopen("infil_player_in_open");
        common_scripts\utility::flag_waitopen("infil_player_in_open_behind_tank");
      }

      var_1 stopfiring();
      var_1 stopbarrelspin();
      level.enemy_tank_3 fireweapon();
      break;
    }

    common_scripts\utility::waitframe();
  }
}

enemy_mg_shoot_randomly_at_player_until_he_runs_for_it() {
  self endon("death");
  level.player endon("death");
  level endon("infil_player_in_open");
  level endon("infil_player_in_open_behind_tank");
  level endon("firing_garage_shot");

  for(;;) {
    self settargetentity(level.player, (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-100, 100)));
    self startfiring();
    wait(randomfloatrange(4, 5.5));
    self stopfiring();
    self stopbarrelspin();
    wait(randomfloatrange(1.5, 2));
  }
}

wait_player_not_in_open_or_needs_garage() {
  level.player endon("death");
  level endon("firing_garage_shot");

  for(;;) {
    if(!common_scripts\utility::flag("infil_player_in_open") && !common_scripts\utility::flag("infil_player_in_open_behind_tank") || common_scripts\utility::flag("allies_run_for_garage")) {
      break;
    } else
      common_scripts\utility::waitframe();
  }
}

enemy_mg_adjust_if_target_dies(var_0) {
  self endon("death");
  level endon("infil_player_in_open");
  level endon("infil_player_in_open_behind_tank");
  level endon("allies_run_for_garage");
  level endon("firing_garage_shot");

  while(isalive(var_0))
    common_scripts\utility::waitframe();

  self.mg_target = enemy_mg_get_untargeted_random_target();
}

enemy_mg_burst_fire() {
  self endon("death");
  level endon("infil_player_in_open");
  level endon("infil_player_in_open_behind_tank");
  level endon("allies_run_for_garage");
  level endon("firing_garage_shot");

  for(;;) {
    wait(randomfloatrange(3, 4));
    self stopfiring();
    self stopbarrelspin();
    wait(randomfloatrange(1, 2.5));
    self.mg_target = enemy_mg_get_untargeted_random_target();
  }
}

enemy_mg_get_untargeted_random_target() {
  self endon("death");
  var_0 = getaiarray("allies");
  var_0 = common_scripts\utility::add_to_array(var_0, level.player);
  var_1 = var_0[randomint(var_0.size)];
  var_2 = 0;

  while(!var_2) {
    if(!isDefined(var_1.is_currently_mg_target)) {
      var_1.is_currently_mg_target = 1;
      self setconvergencetime(2);
      var_2 = 1;
    } else
      var_1 = var_0[randomint(var_0.size)];

    common_scripts\utility::waitframe();
  }

  if(isplayer(var_1))
    self settargetentity(var_1);
  else if(isDefined(var_1.sprint) && var_1.sprint)
    self settargetentity(var_1);
  else
    self settargetentity(var_1, (0, 0, randomintrange(16, 60)));

  self startfiring();

  if(isDefined(self.mg_target))
    self.mg_target.is_currently_mg_target = undefined;

  return var_1;
}

animated_script_model(var_0, var_1, var_2, var_3) {
  if(getdvarint("show_script_model") == 0) {
    return;
  }
  var_4 = (0, -3000, 0);
  var_5 = spawn("script_model", var_1.origin);
  var_5 setModel(var_0.model);
  var_5 useanimtree(var_2);
  var_5 animscripted("blah", var_1.origin + var_4, var_1.angles, var_3);
  var_0 waittill("death");
  wait 1;
  var_5 delete();
}

allies_run_for_garage() {
  maps\_utility::enable_sprint();
  self waittill("in_garage");
  wait 2.0;
  maps\_utility::disable_sprint();
  self.forcesuppression = undefined;
}

tank_wall_stuff() {
  var_0 = getent("enemy_tank", "targetname");
  var_1 = var_0 maps\_vehicle::spawn_vehicle_and_gopath();
  level.enemy_tank_wall = var_1;
  var_1 maps\_vehicle::godon();
  var_1 maps\_vehicle::mgoff();
  var_1.mgturret[1] thread enemy_tank_shoot_flyin_choopers();
  var_2 = getEntArray("streets_enemy_tank_soldiers", "targetname");

  foreach(var_4 in var_2) {
    var_4 maps\_utility::add_spawn_function(::follow_tank_enemies_spawn_func);
    var_4 maps\_utility::spawn_ai();
  }

  var_6 = getvehiclenode("enemy_tank_wall_end", "targetname");
  var_6 waittill("trigger");
  var_1.mgturret[1] notify("end flyin script");
  var_1.mgturret[1] stopfiring();
  var_1.mgturret[1] stopbarrelspin();
  var_1.mgturret[1] cleartargetentity();
  var_1.mgturret[1] setmode("manual");
  var_1.mgturret[1] settargetentity(level.tank_ally_joel, (0, 0, 45));
}

infil_redshirts_spawn_func() {
  if(!isDefined(level.street_start_allies))
    level.street_start_allies = [];

  level.street_start_allies[level.street_start_allies.size] = self;
  maps\_utility::magic_bullet_shield(1);
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.dontavoidplayer = 1;
  common_scripts\utility::flag_wait("allied_tank_killed");
  maps\_utility::stop_magic_bullet_shield();
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  self.dontavoidplayer = 0;
}

rpg_guy_shoot_flyin_choopers() {
  var_0 = getent("infil_rpg_guy_start", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai();
  level.infil_rpg_guy = var_1;
  var_1 endon("death");
  var_1 thread maps\flood_streets::remove_rpgs_on_death();
  var_1 maps\_utility::magic_bullet_shield(1);
  var_1.grenadeawareness = 0;
  var_1.ignoreexplosionevents = 1;
  var_1.ignorerandombulletdamage = 1;
  var_1.ignoresuppression = 1;
  var_1.disablebulletwhizbyreaction = 1;
  var_1 maps\_utility::disable_pain();
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  common_scripts\utility::waitframe();
  var_2 = var_1 gettagorigin("tag_flash") + (0, 0, 50);
  var_3 = common_scripts\utility::getstruct("rpg_guy_target1", "targetname");
  common_scripts\utility::noself_delaycall(1, ::magicbullet, "rpg_straight", var_2 + (0, 0, 50), var_3.origin);
  var_1 maps\_anim::anim_generic(var_1, "rpg_reload");
  magicbullet("rpg_straight", var_2, level.player.origin + (0, 100, 100));
  var_1 maps\_anim::anim_generic(var_1, "rpg_reload");
  magicbullet("rpg_straight", var_2, level.player.origin + (0, 100, 100));
  var_1.grenadeammo = 0;
  var_1 maps\_utility::stop_magic_bullet_shield();
  var_1.grenadeawareness = 1;
  var_1.ignoreexplosionevents = 0;
  var_1.ignorerandombulletdamage = 0;
  var_1.ignoresuppression = 0;
  var_1.disablebulletwhizbyreaction = 0;
  var_1 maps\_utility::enable_pain();
  var_1.ignoreall = 0;
  var_1.ignoreme = 0;
  common_scripts\utility::flag_wait("enemy_tank_killed");
  var_4 = getent("streets_enemy_tank_soldiers_goal_volume_2", "targetname");
  var_1 setgoalvolumeauto(var_4);
}

follow_tank_enemies_spawn_func() {
  self endon("death");
  thread enemies_attack_player_when_in_open();
  var_0 = getent("streets_enemy_tank_soldiers_goal_volume", "targetname");
  self setgoalvolumeauto(var_0);
  maps\_utility::magic_bullet_shield();
  self.ignoreall = 1;
  self.attackeraccuracy = 0;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  var_1 = getvehiclenode("wall_tank_past_wall", "targetname");
  var_1 waittill("trigger");
  maps\_utility::stop_magic_bullet_shield();
  common_scripts\utility::flag_wait("enemy_tank_killed");
  self.ignoreall = 0;
  var_0 = getent("streets_enemy_tank_soldiers_goal_volume_2", "targetname");
  self setgoalvolumeauto(var_0);
  wait 1;
  self.attackeraccuracy = 1;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
}

enemy_tank_soldiers_2_init() {
  self endon("death");
  thread enemies_attack_player_when_in_open();
  thread enemies_magic_bullet_until_player_at_corner();
  self.health = 300;
  maps\_utility::magic_bullet_shield();
  self.attackeraccuracy = 0;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.fixednode = 1;
  common_scripts\utility::flag_wait("player_at_corner");
  maps\_utility::stop_magic_bullet_shield();
  self.attackeraccuracy = 1;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  wait 2.5;
  self.fixednode = 0;
}

enemies_magic_bullet_until_player_at_corner() {
  self endon("death");
  level endon("player_at_corner");

  for(;;) {
    if(!common_scripts\utility::flag("player_at_corner")) {
      self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

      if(var_1 == level.player)
        common_scripts\utility::flag_set("player_at_corner");
    }

    common_scripts\utility::waitframe();
  }
}

enemies_attack_player_when_in_open() {
  self endon("death");

  for(;;) {
    common_scripts\utility::flag_wait_any("infil_player_in_open", "infil_player_in_open_behind_tank");
    self.favoriteenemy = level.player;
    self.baseaccuracy = 50;
    common_scripts\utility::flag_waitopen("infil_player_in_open");
    common_scripts\utility::flag_waitopen("infil_player_in_open_behind_tank");
    self.favoriteenemy = undefined;
    self.baseaccuracy = 1;
  }
}

infil_heli_outside_city() {
  var_0 = [];
  var_1 = getEntArray("infil_blackhawk_outside_city", "targetname");

  foreach(var_3 in var_1)
  var_0[var_0.size] = var_3 thread maps\_utility::spawn_vehicle();

  wait 3;

  foreach(var_3 in var_0)
  var_3 thread maps\_vehicle::gopath();
}

infil_convoy_outside_city() {}

crush_stop_sign_when_near_tank(var_0) {
  while(distance2d(level.tank_ally_joel.origin, self.origin) > var_0)
    wait 0.1;

  common_scripts\utility::flag_set("vignette_streets_stop_sign_01");
}

rotate_barrier_when_near_tank(var_0) {
  var_1 = self.angles;
  var_2 = (0, 90, 0);
  self.angles = var_2;

  while(distance2d(level.tank_ally_joel.origin, self.origin) > var_0)
    common_scripts\utility::waitframe();

  self rotateto(var_2 + (0, 0, -10), 0.2);
  wait 0.2;
  self rotateto(var_1, 0.6);
  wait 0.6;
  self rotateto(var_1 + (0, 0, 5), 0.15);
  wait 0.15;
  self rotateto(var_1, 0.15);
  wait 0.1;
  self rotateto(var_1 + (0, 0, -5), 0.1);
  wait 0.1;
  self rotateto(var_1, 0.1);
}

fire_cannon_at_target(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("stop_firing");

  if(!isDefined(var_1))
    var_1 = 10000;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = randomfloatrange(1.5, 2);

  while(isDefined(var_0) && var_1 > 0) {
    if(isDefined(self)) {
      self setturrettargetvec(var_0.origin + var_2);
      self waittill("turret_on_target");

      if(isDefined(var_4))
        thread maps\_utility::smart_radio_dialogue_overlap(var_4);

      self fireweapon();
    }

    var_1--;

    if(var_1 > 0)
      wait(var_3);
  }
}

set_flag_when_allies_in_garage() {
  var_0 = 1;
  var_1 = 1;
  var_2 = 1;
  var_3 = 1;

  while(var_0 || var_1 || var_2 || var_3) {
    var_4 = getent("parking_garage_doorway", "targetname");
    var_4 waittill("trigger", var_5);

    if(level.player istouching(var_4))
      var_0 = 0;

    if(level.allies[0] istouching(var_4)) {
      var_1 = 0;
      var_5 notify("in_garage");
    }

    if(level.allies[1] istouching(var_4)) {
      var_2 = 0;
      var_5 notify("in_garage");
    }

    if(level.allies[2] istouching(var_4)) {
      var_3 = 0;
      var_5 notify("in_garage");
    }
  }

  common_scripts\utility::flag_set("everyone_in_garage");
}

mg_turret_do_something_while_waiting_for_player() {
  level endon("player_at_corner");
  level.tank_ally_joel.mgturret[0] setmode("auto_nonai");

  while(!common_scripts\utility::flag("player_at_corner")) {
    level.tank_ally_joel.mgturret[0] turretfiredisable();
    level.tank_ally_joel.mgturret[0] stopbarrelspin();
    wait(randomfloatrange(3, 4.5));
    level.tank_ally_joel.mgturret[0] turretfireenable();
    wait(randomfloatrange(4.5, 7.5));
  }

  level.tank_ally_joel.mgturret[0] setmode("manual");
}

react_correctly_to_tank_fire() {
  self.ignoresuppression = 0;
  self.ignorerandombulletdamage = 1;
  self.disablebulletwhizbyreaction = 1;
  self.script_dontpeek = 1;
  maps\_utility::disable_pain();
}

set_flag_when_allies_in_position() {
  foreach(var_1 in level.street_start_allies) {
    if(isDefined(var_1))
      var_1 pushplayer(1);
  }

  var_3 = 1;

  while(var_3 && !common_scripts\utility::flag("allies_in_position")) {
    var_4 = 0;
    var_5 = 0;
    var_6 = getent("ally_behind_planter", "targetname");

    foreach(var_1 in level.street_start_allies) {
      if(isDefined(var_1)) {
        if(var_1 istouching(var_6))
          var_4++;

        var_5++;
      }
    }

    if(var_4 >= var_5 - 1)
      var_3 = 0;

    wait 0.1;
  }

  common_scripts\utility::flag_set("allies_in_position");

  foreach(var_1 in level.street_start_allies) {
    if(isDefined(var_1))
      var_1 pushplayer(0);
  }
}

set_flag_after_timer(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_set(var_0);
}

kill_barriers_when_close(var_0, var_1) {
  var_0 endon("death");

  while(distance2d(var_0.origin, self.origin) > var_1) {
    wait 0.1;

    if(!isDefined(var_0)) {
      break;
    }
  }

  if(isDefined(var_0))
    self delete();
}

infil_flyin_battle_init() {
  maps\_utility::delaythread(28, ::infil_flyin_battle);
  level thread maps\_utility::notify_delay("kill enemy tank", 37);
  level thread maps\_utility::notify_delay("start tanks", 31);
}

infil_flyin_battle() {
  maps\flood_util::jkuprint("start the battle");
  var_0 = getEntArray("infil_flyin_battle_tank_destroyed", "targetname");
  var_1 = getEntArray("infil_flyin_battle_tank_ally_hummer", "targetname");
  var_2 = getEntArray("infil_flyin_battle_tank_ally", "targetname");
  var_3 = getEntArray("infil_flyin_battle_static", "targetname");
  var_4 = getent("infil_flyin_battle_tank_enemy", "targetname");
  var_5 = common_scripts\utility::getstruct("infil_flyin_battle_tank_enemy_target", "targetname");
  var_6 = common_scripts\utility::getstructarray("infil_flyin_battle_tank_enemy_barrier_target", "targetname");
  var_7 = getent("infil_flyin_battle_tank_ally_aim", "targetname");
  var_8 = getent("infil_flyin_battle_tank_ally_bridge_l", "targetname");
  var_9 = getent("infil_flyin_battle_tank_ally_bridge_r", "targetname");

  foreach(var_11 in var_0)
  var_11 kill();

  var_4 thread enemy_tank_spawn_func(var_6);
  var_7 common_scripts\utility::delaycall(6, ::setturrettargetvec, var_4.origin);
  var_8 maps\_utility::add_spawn_function(::tank_spawn_func, var_5);
  var_8 = var_8 maps\_vehicle::spawn_vehicle_and_gopath();
  var_9 maps\_utility::add_spawn_function(::tank_spawn_func, var_5);
  var_9 = var_9 maps\_vehicle::spawn_vehicle_and_gopath();

  foreach(var_14 in var_1) {
    var_14 maps\_utility::add_spawn_function(::hummer_spawn_func);
    var_14 maps\_vehicle::spawn_vehicle_and_gopath();
  }

  foreach(var_11 in var_2) {
    var_11 maps\_utility::add_spawn_function(::tank_moving_spawn_func);
    var_11 maps\_vehicle::spawn_vehicle_and_gopath();
  }

  level waittill("kill enemy tank");
  maps\flood_util::jkuprint("kill enemy tank");
  var_4 kill();
}

enemy_tank_spawn_func(var_0) {
  self endon("death");

  for(;;) {
    var_1 = var_0[randomintrange(0, var_0.size)];
    fire_cannon_at_target(var_1, 1);
    wait(randomfloatrange(1.5, 3.0));
  }
}

tank_spawn_func(var_0) {
  self endon("death");
  self vehicle_setspeed(14, 14, 7);
  wait 1;

  for(;;) {
    if(self vehicle_getspeed() < 1) {
      thread fire_cannon_at_target(var_0);
      break;
    }

    common_scripts\utility::waitframe();
  }

  level waittill("kill enemy tank");
  self notify("stop_firing");
  level waittill("infil kill everything");
  self delete();
}

tank_moving_spawn_func() {
  self endon("death");
  self vehicle_setspeed(0, 1, 1);
  level waittill("start tanks");
  self vehicle_setspeed(14, 14, 7);
  level waittill("infil kill everything");
  self delete();
}

hummer_spawn_func() {
  self endon("death");
  wait 1;

  for(;;) {
    if(self vehicle_getspeed() < 0.2) {
      self joltbody(self.origin + (0, 0, 64), 100);
      break;
    }

    common_scripts\utility::waitframe();
  }

  maps\_vehicle::vehicle_unload("all");
  level waittill("infil kill everything");
  self delete();
}

infil_cleanup() {
  level notify("infil kill everything");
  var_0 = getEntArray("infil_cleanup", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

tanks_cleanup_early() {
  var_0 = getEntArray("tanks_cleanup_early", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

tanks_cleanup() {
  var_0 = getEntArray("tanks_cleanup", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

streets_start() {
  level.street_start_allies = [];
  maps\flood_util::player_move_to_checkpoint_start("streets_start");
  maps\flood_util::spawn_allies();
}

streets() {
  level thread maps\_utility::autosave_by_name_silent("streets_old");
  level thread streets_battle_blackhawk();
  level thread blackhawk_countermeasure();
  level thread kill_player_with_tanks("streets_beyond_enemy_tank_2");
  level thread kill_player_with_tanks("streets_run_for_it");
  level thread maps\flood_streets::aim_missiles_2();
  level thread maps\flood_streets::hide_missile_launcher_collision();
  level thread maps\flood_streets::hide_spire();
  level thread maps\flood_streets::hide_garage_debris();
  level thread maps\flood_streets::garage_opening_collapse();
  var_0 = getent("into_parking_garage", "targetname");
  var_0 waittill("trigger");
  level notify("end_streets");
}

kill_player_with_tanks(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");

  if(isalive(level.enemy_tank_2)) {
    level.enemy_tank_2 setturrettargetent(level.player);
    wait 0.5;
    level.enemy_tank_2 fireweapon();
  }

  if(isalive(level.enemy_tank_3)) {
    level.enemy_tank_3 setturrettargetent(level.player);
    wait 0.5;
    level.enemy_tank_3 fireweapon();
  }

  if(isalive(level.enemy_tank_3))
    level.player kill(level.enemy_tank_3.origin, level.enemy_tank_3, level.enemy_tank_3);
  else {
    wait 0.5;
    level.player kill();
  }

  wait 0.1;
  setdvar("ui_deadquote", &"FLOOD_TANKS_FAIL");
  level thread maps\_utility::missionfailedwrapper();
}

streets_battle_blackhawk() {
  var_0 = getent("trig_battle_blackhawk_fight", "targetname");
  var_0 waittill("trigger");
  thread streets_battle_fire_rocket("streets_battle_blackhawk_rocket_1", "streets_battle_blackhawk_missile_impact_1");
  wait 0.9;
  thread streets_battle_fire_rocket("streets_battle_blackhawk_rocket_2", "streets_battle_blackhawk_missile_impact_2");
  wait 0.9;
  thread streets_battle_fire_rocket("streets_battle_blackhawk_rocket_3", "streets_battle_blackhawk_missile_impact_3");
  wait 1.4;
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_battle_blackhawk");
  var_1.path_gobbler = 1;
  var_1.script_vehicle_selfremove = 1;
  var_1 vehicle_setspeed(60);
}

streets_battle_fire_rocket(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 thread maps\_utility::add_spawn_function(::postspawn_crash_blackhawk_rocket);
  var_3 = var_2 maps\_vehicle::spawn_vehicle_and_gopath();
  var_3 waittill("reached_end_node");
  var_4 = getent(var_1, "targetname");
  playFX(level._effect["temp_missile_impact"], var_4.origin);
}

streets_crash_blackhawk() {}

postspawn_crash_blackhawk_rocket() {
  self setModel("projectile_rpg7");
  var_0 = common_scripts\utility::getfx("rpg_trail");
  playFXOnTag(var_0, self, "tag_origin");

  if(isDefined(self.script_sound)) {
    if(isDefined(self.script_wait))
      common_scripts\utility::delaycall(self.script_wait, ::playsound, self.script_sound);
    else
      self playSound(self.script_sound);
  } else
    self playLoopSound("weap_rpg_loop");

  self waittill("reached_end_node");

  if(isDefined(self.script_exploder))
    common_scripts\utility::exploder(self.script_exploder);
  else if(isDefined(self.script_fxid))
    playFX(common_scripts\utility::getfx(self.script_fxid), self.origin, anglesToForward(self.angles));

  self delete();
}

crash_blackhawk_missile_impacts() {
  var_0 = getEntArray("crash_blackhawk_missile_impact", "targetname");

  for(;;) {
    if(common_scripts\utility::flag("trig_crash_blackhawk_crash")) {
      break;
    }

    var_1 = randomintrange(0, var_0.size - 1);

    if(isDefined(var_0[var_1]))
      playFX(level._effect["temp_missile_impact"], var_0[var_1].origin);

    var_2 = randomfloatrange(2.25, 3.0);
    wait(var_2);
  }
}

blackhawk_countermeasure() {
  var_0 = getent("trig_countermeasure_blackhawk", "targetname");
  var_0 waittill("trigger");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_countermeasure_blackhawk");
  var_1.script_vehicle_selfremove = 1;
  var_1 vehicle_setspeedimmediate(60);
  var_2 = common_scripts\utility::getfx("chopper_countermeasure");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_1 gettagorigin("tag_light_l_wing");
  var_3.angles = var_1 gettagangles("tag_light_l_wing");
  var_3 linkto(var_1);
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_1 gettagorigin("tag_light_r_wing");
  var_4.angles = var_1 gettagangles("tag_light_r_wing");
  var_4 linkto(var_1);
  wait 2.75;

  for(var_5 = 0; var_5 < 5; var_5++)
    wait 0.3;

  var_3 delete();
  var_4 delete();
}

nh90_convoy_choppers() {
  var_0 = getent("convoy_helicopter_crash_location", "targetname");
  var_1 = getent("trig_enemy_convoy_choppers", "targetname");
  var_1 waittill("trigger");

  if(!common_scripts\utility::flag("m880_has_spawned")) {
    var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_enemy_convoy_chopper1");
    var_2 vehicle_turnengineoff();
    var_2 thread maps\flood_audio::flood_convoy_chopper1_sfx();
    var_2.script_vehicle_selfremove = 1;
    var_2 vehicle_setspeedimmediate(60);
    var_2.perferred_crash_location = var_0;
    wait 2.5;
    var_3 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_enemy_convoy_chopper2");
    var_3 vehicle_turnengineoff();
    var_3 thread maps\flood_audio::flood_convoy_chopper2_sfx();
    var_3.script_vehicle_selfremove = 1;
    var_3.perferred_crash_location = var_0;
    wait 1;
    wait 2;
    var_4 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("streets_enemy_convoy_chopper4");
    var_4 vehicle_turnengineoff();
    var_4 thread maps\flood_audio::flood_convoy_chopper4_sfx();
    var_4.script_vehicle_selfremove = 1;
    var_4 hidepart("door_R", var_4.model);
    var_4 hidepart("door_R_handle", var_4.model);
    var_4 hidepart("door_R_lock", var_4.model);
    var_4.perferred_crash_location = var_0;
  }
}

flag_waitopen_any(var_0, var_1) {
  while(common_scripts\utility::flag(var_0))
    level waittill(var_0);
}

aent_flag_waitopen_either(var_0, var_1) {
  while(isDefined(self)) {
    if(!maps\_utility::ent_flag(var_0)) {
      return;
    }
    if(!maps\_utility::ent_flag(var_1)) {
      return;
    }
    common_scripts\utility::waittill_either(var_0, var_1);
  }
}

awaittill_either(var_0, var_1) {
  self endon(var_0);
  self waittill(var_1);
}

kill_infil_enemies() {
  var_0 = maps\_utility::get_ai_group_ai("streets_enemy_tank_soldiers");

  foreach(var_2 in var_0)
  var_2 kill();

  if(isalive(level.infil_rpg_guy))
    level.infil_rpg_guy kill();
}