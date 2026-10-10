/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2c5456a9a7133a7c.gsc
*************************************************/

#using script_1031976741eb6674;
#using script_60add030ce1a42b6;
#using script_7295d46a1f0881ad;
#using script_f8531dcf975a7a7;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_build;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\spawner;
#namespace namespace_aa241837d428d6e2;

function function_26f826e859294500() {}

function cliff_start() {
  function_4c28f0141619d61a();
  set_start_location("s_start_cliff", [level.player]);
  set_start_location("s_start_cliff", level.tundra_allies);
  level thread function_4ef9521e4948b6a4();
  function_12af163adcd1c7e6("cliff_1_cover_farah", 1);
  level thread namespace_f247b8d258f67b0b::function_8900520dba6be4f2();
  level.player setmovespeedscale(1);
}

function cliff_main() {
  level notify("stop_tundra_pre_exfil_nags");
  level utility::flag_set("flag_lumbermill_obj_trigger_end");
  level thread namespace_191bb1c1589b3acb::function_e11990259b9f9756();
  level thread function_813afb59b6ad12fd();
  level thread function_d0bbf1af2ba163b0();
  level thread function_71928bf8f19a9c63();
  level thread function_f9114230bc1e8433();
  level thread function_b41383e8587fa198(1);
  level thread function_b5db5495178dc77a();
  level thread function_c570992541df7120();
  level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9(undefined, undefined, "flag_cliff_stop_nags", "cliff_player_progress", "trig_cliff");
  level utility::flag_set("flag_tundra_allies_in_stealth");
  array_thread(level.tundra_allies, &function_a683287706fba3b7);
  flag_wait("flag_end_cliff");
  level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3("flag_cliff_stop_nags");
}

function function_4ef9521e4948b6a4() {
  var_3e63548ba661f7d = getscriptablearray("scriptable_lumber_fence_back", "targetname");

  foreach(gate in var_3e63548ba661f7d) {
    gate delete();
  }
}

function function_a683287706fba3b7() {
  level.player endon("death");
  utility::ent_flag_init("flag_cliff_ally_follow_the_leader");
  thread function_678133c1d027d0ae();
  start_struct = namespace_8339f6377b6ba60e::function_bdc421f433af10c7("s_start_cliff");
  start_node = getnode(start_struct.target, "targetname");

  if(isDefined(start_node.script_flag_wait) && level utility::flag(start_node.script_flag_wait)) {
    next_node = getStruct(start_node.target, "targetname");

    if(isDefined(next_node)) {
      start_node = next_node;
    }
  }

  thread namespace_8339f6377b6ba60e::function_11fc094b83527d81(start_node);

  if(self.animname != "shepherd") {
    flag_wait("flag_cliff_helo_flyby_1");
  }

  thread cliff_ally_follow_the_leader();
  flag_wait("flag_cliff_snowdrift_on");
  wait randomfloatrange(0.5, 1.5);
  self notify("stop_follow_the_leader");
  utility::disable_dynamic_run_speed();
  self allowedstances("stand", "crouch", "prone");
  waitframe();

  switch (self.animname) {
    case #"hash_4ba1525745ce470f":
    case #"hash_df31f98a0b34e496":
      n_speed = 100;
      break;
    case #"hash_831c7a280af6bbca":
      n_speed = 60;
      break;
    case #"hash_fb36726c0708cd6d":
    default:
      n_speed = 80;
      break;
  }

  set_movement_speed(n_speed);
  msg = flag_wait_any_return("flag_cliff_snowdrift_off", "flag_cliff_allies_move_4");

  if(msg == "flag_cliff_snowdrift_off") {
    wait randomfloatrange(4, 6);
  } else {
    wait randomfloatrange(1, 3);
  }

  thread cliff_ally_follow_the_leader();
  level flag_wait("flag_end_cliff");
  self notify("stop_follow_the_leader");
  utility::disable_dynamic_run_speed();
  self allowedstances("stand", "crouch", "prone");
  utility::clear_movement_speed();
}

function function_678133c1d027d0ae() {
  level endon("flag_cliff_helo_flyby_1");
  self endon("death");
  utility::ent_flag_init("flag_cliff_ally_begin_cqb");
  utility::ent_flag_wait("flag_cliff_ally_begin_cqb");

  if(!utility::ent_flag("flag_cliff_ally_follow_the_leader")) {
    namespace_8339f6377b6ba60e::function_c9317b6d58796509(0, "cqb");
  }
}

function function_813afb59b6ad12fd() {
  flag_wait_any("flag_cliff_helo_flyby_1", "flag_cliff_allies_move_3");
  flag_set("flag_cliff_helo_flyby_1");
  var_8f74ad64995286a4 = vehicle::spawn_vehicle_from_targetname_and_drive("veh_enemy_heli_cliff_1");
  vehicle_build::build_treadfx(var_8f74ad64995286a4.classname_mp, "default", "vfx/jup/level/sp_tundra/vfx_tun_env_helo_wash_snow_1.vfx", 1);
  var_8f74ad64995286a4 thread namespace_8339f6377b6ba60e::function_9871d73aaf67c8f4();
  flag_wait("flag_cliff_helo_flyby_2");
  var_8f74b06499528d3d = vehicle::spawn_vehicle_from_targetname_and_drive("veh_enemy_heli_cliff_2");
  vehicle_build::build_treadfx(var_8f74b06499528d3d.classname_mp, "default", "vfx/jup/level/sp_tundra/vfx_tun_env_helo_wash_snow_1.vfx", 1);
  var_8f74b06499528d3d thread namespace_8339f6377b6ba60e::function_9871d73aaf67c8f4();
}

function function_d0bbf1af2ba163b0() {
  var_7c760871476912f0 = getStructArray("s_cliff_frag_pickup", "targetname");
  var_4c23139ab28e649a = [];

  foreach(struct in var_7c760871476912f0) {
    frag_pickup = struct function_527133d02bd11634();
    var_4c23139ab28e649a = array_add(var_4c23139ab28e649a, frag_pickup);
  }
}

function function_b41383e8587fa198(var_5a6aa17b697081b4) {
  if(istrue(var_5a6aa17b697081b4)) {
    level utility::flag_wait("flag_cliff_allies_move_4");
  }

  array_spawn_function_targetname("ai_cliff_corpse", &function_a05bb3a974bf2561);
  var_45f554f827a2e713 = array_spawn_targetname("ai_cliff_corpse", 1);
}

function function_71928bf8f19a9c63() {
  level.player endon("death");
  flag_wait("flag_cliff_helo_flyby_1");
  level.player thread utility::blend_movespeedscale(0.85, 1);
  flag_wait("flag_cliff_snowdrift_start");
  var_a69f0cad17062b6b = getStruct("cliff_snowdrift_structs", "targetname");
  var_7b557f184ad06d46 = spawn_tag_origin(var_a69f0cad17062b6b.origin + (0, 0, 20), var_a69f0cad17062b6b.angles);
  exploder("vfx_cliff_weather_wind_burst");
  level thread namespace_f74ba02cf5fc717a::function_4e97b1a797add6f0();
  wait 3;
  visionsetnaked("sp_jup_tundra_shipyard_whiteout", 3);
  wait 1;
  var_3fc9573f89ae1058 = playFXOnTag(getfx("vfx_snowdrift"), var_7b557f184ad06d46, "tag_origin");
  flag_set("flag_cliff_snowdrift_on");
  level thread function_d56a13347ecadd55();
  level thread function_348704bb23158ea5("strong");
  visionsetnaked("sp_jup_tundra_shipyard_whiteout", 2.5);
  n_duration = randomfloatrange(8, 12);
  wait n_duration;
  stopFXOnTag(getfx("vfx_snowdrift"), var_7b557f184ad06d46, "tag_origin");
  level thread function_348704bb23158ea5("weak");
  flag_set("flag_cliff_snowdrift_off");
  visionsetnaked("", 4);
  var_7b557f184ad06d46 delete();
}

function function_d56a13347ecadd55() {
  level.player endon("death");
  screen_origin = spawn_tag_origin(level.player getEye(), level.player.angles);
  screen_origin.origin = level.player getEye();
  screen_origin linkTo(level.player);
  screen_fx = playFXOnTag(getfx("vfx_snowdrift_screen"), screen_origin, "tag_origin");
  level.player thread utility::blend_movespeedscale(0.6, 0.5);
  level.player allowsprint(0);
  level.player thread utility::player_gesture_force("ges_frag_block");
  wait 0.5;
  screenshake(level.player.origin, 4, 2, 8, 4, 0.5, 1.5, 0, 0.2, 0.05, 0.1);
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.2, 1.5, level.player.origin, 200);
  wait 3;
  level.player allowsprint(1);
  level.player thread utility::blend_movespeedscale(0.9, 2);
  wait 1;
  stopFXOnTag(getfx("vfx_snowdrift_screen"), screen_origin, "tag_origin");
  wait 3;
  screen_origin delete();
  flag_wait("flag_end_cliff");
  level.player thread utility::blend_movespeedscale_default(1);
}

function function_45ec82c0014d1b4c() {
  flag_set("flag_cliff_allies_move_1");
  flag_set("flag_cliff_allies_move_2");
  flag_set("flag_cliff_allies_move_3");
  flag_set("flag_cliff_allies_move_4");
  flag_set("flag_cliff_allies_move_5");
  flag_set("flag_cliff_allies_move_6");
}

function function_348704bb23158ea5(intensity) {
  switch (intensity) {
    case #"hash_5750d6ce52be2eda":
      lerp_saveddvar(@ "hash_402173c7dbee15d9", 15, 2);
      str_intensity = "30";
      break;
    case #"hash_c71b112fe04823d6":
      lerp_saveddvar(@ "hash_402173c7dbee15d9", 3, 3);
      str_intensity = "15";
      break;
    case #"hash_a1b0ba7432c84029":
    default:
      lerp_saveddvar(@ "hash_402173c7dbee15d9", 1, 5);
      str_intensity = "5";
      break;
  }

  foreach(ally in level.tundra_allies) {
    ally thread namespace_8339f6377b6ba60e::function_590b3a1b2bdf1c57(1, str_intensity);
  }

  wires = getEntArray("jup_shipyard_wires", "targetname");

  foreach(wire in wires) {
    wire setscriptablepartstate("main", intensity);
  }
}

function cliff_ally_follow_the_leader() {
  level.player endon("death");
  self endon("death");
  self endon("stop_follow_the_leader");
  utility::ent_flag_set("flag_cliff_ally_follow_the_leader");

  if(self.animname != "shepherd") {
    childthread namespace_ed524932b773201d::function_e3b8e5fb74bf3a6();
  }

  minspeed = 0;
  midspeed = 65;
  maxspeed = 160;
  frontdist = -100;
  middist = -200;
  backdist = -300;

  switch (self.animname) {
    case #"hash_4ba1525745ce470f":
      followent = level.player;
      minspeed = 0;
      midspeed = 150;
      maxspeed = 220;
      frontdist = -200;
      middist = -500;
      backdist = -800;
      break;
    case #"hash_df31f98a0b34e496":
      followent = level.player;
      minspeed = 0;
      midspeed = 150;
      maxspeed = 220;
      frontdist = 200;
      middist = -100;
      backdist = -300;
      break;
    case #"hash_831c7a280af6bbca":
      followent = level.gaz;
      minspeed = 0;
      midspeed = 80;
      maxspeed = 180;
      frontdist = 200;
      middist = 100;
      backdist = -100;
      break;
    case #"hash_fb36726c0708cd6d":
    default:
      followent = level.player;
      minspeed = 0;
      midspeed = 150;
      maxspeed = 220;
      frontdist = -100;
      middist = -250;
      backdist = -400;
      break;
  }

  thread utility::enable_dynamic_run_speed(followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist);
}

function function_f9114230bc1e8433() {
  level.player endon("death");
  flag_wait("flag_cliff_allies_move_5");
  heli = function_90fda098ff7adca6("veh_enemy_heli_shipyard_start", "flag_shipyard_idle_heli_start_path");
  heli endon("death");
  level utility::flag_wait("flag_shipyard_idle_heli_start_path");
  wait 6;
  heli scalevolume(0, 7);
}

function function_b5db5495178dc77a() {
  level endon("flag_end_cliff");
  e_cliff_backtrack_blocker = getEnt("e_cliff_backtrack_blocker", "targetname");

  if(isDefined(e_cliff_backtrack_blocker)) {
    e_cliff_backtrack_blocker hide();
    e_cliff_backtrack_blocker notsolid();
    e_cliff_backtrack_blocker connectpaths();
  } else {
    iprintln("<dev string:x1c>");
  }

  flag_wait("flag_cliff_allies_move_4");

  if(isDefined(e_cliff_backtrack_blocker)) {
    e_cliff_backtrack_blocker show();
    e_cliff_backtrack_blocker solid();
    return;
  }

  iprintln("<dev string:x1c>");
}

function function_c570992541df7120() {
  level endon("flag_end_cliff");
  e_lumbermill_cliff_backtrack_blocker = getEnt("e_lumbermill_cliff_backtrack_blocker", "targetname");

  if(isDefined(e_lumbermill_cliff_backtrack_blocker)) {
    e_lumbermill_cliff_backtrack_blocker hide();
    e_lumbermill_cliff_backtrack_blocker notsolid();
    e_lumbermill_cliff_backtrack_blocker connectpaths();
  } else {
    iprintln("<dev string:x4e>");
  }

  flag_wait("flag_cliff_helo_flyby_1");

  if(isDefined(e_lumbermill_cliff_backtrack_blocker)) {
    e_lumbermill_cliff_backtrack_blocker show();
    e_lumbermill_cliff_backtrack_blocker solid();
    return;
  }

  iprintln("<dev string:x1c>");
}