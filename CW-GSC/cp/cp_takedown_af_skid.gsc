/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_takedown_af_skid.gsc
***********************************************/

#using script_31e9b35aaacbbd93;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_61cfc2ab8e60625;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp\cp_takedown_af_chase;
#using scripts\cp\cp_takedown_af_hill;
#using scripts\cp\cp_takedown_fx;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace tkdn_af_skid;

function starting(var_d3440450) {
  namespace_b100dd86::function_5aabc3fb();
  level.af_plane = namespace_b100dd86::function_5431431d();
  namespace_b100dd86::function_c8381339(level.af_plane, 1);
  thread namespace_b100dd86::function_1c77193b(level.af_plane);
  level.chase_truck = getvehiclearray("af_chase_veh", "targetname")[0];
  level.chase_truck vehicle::lights_on();
  level.chase_truck vehicle::toggle_force_driver_taillights(1);
  level.chase_truck cp_takedown_fx::function_4c265dee();
  tkdn_af_hill::function_a2015343();
  a_ar = getweapon(#"ar_accurate_t9");
  level.adler setweapon(a_ar);
  level flag::set("af_start_enemy_crash_vehs");
  setDvar(#"hash_76c0d7e6385ee6de", 0.05);
  thread namespace_a052577e::function_3dbad6f5();
}

function main(var_d3440450, var_50cc0d4f) {
  player = getplayers()[0];
  setDvar(#"hash_3d9a09e7ecea2271", 0);
  level clientfield::set("crash_models", 1);
  vehs = getvehiclearray();
  function_def1eb14(["smash_veh", "crash_veh_l", "crash_veh_r"]);
  wait 0.1;
  level flag::set("af_doing_crash");
  thread function_243c9d46(player);
  level notify(#"hash_2000b4f0550d06a6");
  level flag::wait_till("af_skid_complete");

  if(isDefined(level.adler)) {
    level.adler util::stop_magic_bullet_shield();
    level.adler delete();
  }

  setDvar(#"hash_3d9a09e7ecea2271", 1);

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function cleanup(name, starting, direct, player) {
  level clientfield::set("crash_models", 0);
}

function init_flags() {
  level flag::init("af_skid_complete");
  level flag::init("af_doing_crash");
}

function init_clientfields() {}

function function_22b7fffd() {}

function function_def1eb14(name_array) {
  level.var_515a88e0 = [];

  foreach(name in name_array) {
    veh = vehicle::simple_spawn_single(name);
    level.var_515a88e0[level.var_515a88e0.size] = veh;
    veh thread function_c5eaa394();
  }
}

function function_c5eaa394() {
  wait 0.1;

  if(self.targetname == "smash_veh") {
    self waittill(#"turn_on_lights");
  }

  self vehicle::lights_on();
  self vehicle::toggle_force_driver_taillights(1);
  self thread tkdn_af_chase::function_6b9d341b();
}

function function_243c9d46(player) {
  player_veh = getvehiclearray("af_chase_veh", "targetname")[0];
  level.chase_truck = player_veh;
  level.player = getplayers()[0];
  thread function_c0f9442c();
  thread function_e99dbb58(player);
  player_veh vehicle::get_off_path();
  woods = getactorarray("af_woods", "targetname");

  if(woods.size > 0) {
    woods[0] unlink();
  }

  plane = getent("cargo_plane", "targetname");
  plane unlink();
  level.adler unlink();
  util::nvidiaansel_scriptdisable(1);
  actors = level.var_515a88e0;
  level.fake_player = util::spawn_player_clone(level.player);
  level.fake_player.targetname = "FakePlayer";
  actors[#"fakeplayer"] = level.fake_player;
  level.fake_player hide();
  level thread scene::play_from_time("scene_tkd_hit3_planecrash_intro", "crash_fakeplayer", actors, 0.8, 0, 1);
  waitframe(1);
  level.fake_player hide();
  level.fake_player setinvisibletoall();
  player playerlinktodelta(level.fake_player, "tag_player", 1, 180, 180, 180, 180, 1, 0, 1);
  level waittill(#"hash_2d945658a781d296");
  namespace_82bfe441::fade(1, "FadeImmediate");
  player playerlinktoblend(level.fake_player, "tag_player", 0.2, 0, 0, 0.2, 0, 0, 1);
  wait 0.2;
  level.fake_player show();
  level.fake_player setvisibletoall();
  player val::set("crash", "disable_weapons", 2);
  player playerlinktodelta(level.fake_player, "tag_player", 1, 0, 0, 0, 0, 1, 0, 1);
  level waittill(#"hash_360943c8eac07426");
  waitframe(1);
  level.chase_truck vehicle::lights_off();
  level.chase_truck vehicle::toggle_force_driver_taillights(0);
  level.chase_truck cp_takedown_fx::function_2c185955();
  level waittill(#"hash_557087a4ef59ae6c");
  wait 3;
  level flag::set("af_skid_complete");
  snd::client_msg("af_skid_complete");
  player unlink();
  level.fake_player delete();
  player val::reset("crash", "disable_weapons");
  player val::reset("crash", "allow_crouch");
  player val::reset("crash", "allow_prone");
  player val::reset(#"chase", "allowdeath");
  util::nvidiaansel_scriptdisable(0);
}

function function_c0f9442c() {
  level waittill(#"hash_164bf872d25545af");
  level notify(#"hash_6f65948492627624");
  snd::client_msg(#"hash_164bf872d25545af");
}

function function_71a64494(player, guy) {
  guy waittill(#"weapon_fired");
  level.player playhitmarker(undefined, 5, undefined, 1);
  wait 0.01;
  level notify(#"hash_79d44a2e92237673");
}

function function_c2f81a50(notification) {
  level endon(notification);
  self waittill(#"damage");
  level.player playhitmarker(undefined, 5, undefined, 1);
  level notify(notification);
}

function function_e99dbb58(player) {
  player unlink();
  player playersetgroundreferenceent(undefined);
  level.chase_truck setmovingplatformenabled(1, 0);
  player setstance("stand");
  waitframe(1);
  player val::set("crash", "allow_crouch", 0);
  player val::set("crash", "allow_prone", 0);
  wait 2;

  if(isDefined(level.rc_car)) {
    level.rc_car delete();
  }

  level waittill(#"hash_61855c3885c438e6");
  player shellshock(#"frag_grenade_mp", 4);
  level lui::screen_fade_out(0.2);
  player playrumbleonentity("damage_heavy");
  level notify(#"hash_351eb749d2c8fa9c");
  flag::clear("af_wing_smash");
}

function function_c9f7e2d2() {
  vehs = vehicle::simple_spawn_and_drive("af_enemy_crash_veh");
}