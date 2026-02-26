/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_34c07e36b76bab45.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using script_4b6505921addc7bc;
#using script_758226507b1afa11;
#using script_86ebb5dd573a003;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\teleport_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_sp;
#using scripts\cp_common\util;
#namespace namespace_4dd4b998;

function init_flags() {
  level flag::init("start_train_lighting");
  level flag::init("start_train");
  level flag::init("flag_train_fadein_start");
  level flag::init("train_civs_spawned");
  level flag::init("guy09_seated");
  level flag::init("train_done");
  level flag::init("train_player_rise");
  level flag::init("flag_player_train_intro_done");
  level flag::init("flag_prep_teleport_train_player");
  level flag::init("teleport_train_player");
  level flag::init("train_adler_ready");
  level flag::init("flag_post_train_weapons");
}

function start(str_objective) {
  level.var_c0c469ea = 1.75;
  player = getplayers()[0];
  player clientfield::set_to_player("force_stream_train", 1);
  level thread scene::init_streamer(#"cin_stakeout_train_intro", getplayers());
  level thread namespace_5ceacc03::function_d7739931();
  util::function_268bdf4f("adler", &namespace_11998b8f::function_2f0f0a84);
  util::function_268bdf4f("lazar");
  util::function_268bdf4f("park");
  level thread function_805f1669();
  level scene::init("cin_stakeout_train_intro");
}

function function_7633f53d() {
  level.adler endon(#"death");
  level.adler waittill(#"hash_224ded9a34613b7b");
  level flag::set("train_adler_ready");
}

function function_7514adbc() {
  level thread function_7633f53d();
  level flag::wait_till("train_adler_ready");
  var_38d138fb = [];
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_02030_adlr_bellletsgo_a2";
  var_38d138fb[var_38d138fb.size] = "vox_cp_stkt_02030_adlr_timetogobell_81";
  level.adler thread namespace_11998b8f::function_ec76072d(10, var_38d138fb, 10, "train_door_used");
  var_4cbc3fe8 = struct::get("train_door_interact");
  var_4cbc3fe8 util::create_cursor_hint(undefined, undefined, #"hash_24b92cc9c8f3144e");
  var_4cbc3fe8 waittill(#"trigger");
  var_4cbc3fe8 util::remove_cursor_hint();
  level flag::set("train_door_used");
}

function main(str_objective, var_50cc0d4f) {
  level flag::set("start_train_lighting");
  scene::function_d0d7d9f7("cin_stakeout_train_intro", &function_e9812a44);
  scene::add_scene_func("cin_stakeout_train_cam_shake", &function_6c744934, "play");
  scene::add_scene_func("cin_stakeout_train_block", &function_63886603, "lazar_close_behind", "lazar_close_behind");
  scene::add_scene_func("cin_stakeout_train_block", &function_63886603, "lazar_exit", "lazar_exit");
  scene::function_d0d7d9f7("cin_stakeout_train_cross", &function_63886603);
  scene::function_d0d7d9f7("cin_stakeout_train_jumpout", &cin_stakeout_train_jumpout);
  level.adler.var_5b22d53 = 0;
  level.park.var_5b22d53 = 0;
  level.lazar.var_5b22d53 = 0;
  level scene::init("cin_stakeout_train_intro");
  player = getplayers()[0];
  player clientfield::set_to_player("force_stream_train", 0);
  player val::set("stakeout_intro", "disable_oob", 1);
  level thread function_c18c1869();
  player thread namespace_c80e7f5f::function_e526c584();
  level thread namespace_5ceacc03::function_e40ab25f();
  namespace_5ceacc03::music("1.0_train");
  wait 4;
  level globallogic_ui::function_7bc0e4b9();
  wait 2;
  dialogue::radio("vox_cp_stkt_02001_park_wejustpassedund_65");
  wait 1;
  level flag::set("flag_train_fadein_start");

  if(isDefined(level.var_d7d201ba)) {
    level.player flag::set(level.var_d7d201ba);
  }

  level thread namespace_5ceacc03::train_fade_up_from_black();
  train_car_01_player_clip = getent("train_car_01_player_clip", "targetname");

  if(isDefined(train_car_01_player_clip)) {
    train_car_01_player_clip notsolid();
  }

  train_car_02_player_clip = getent("train_car_02_player_clip", "targetname");

  if(isDefined(train_car_02_player_clip)) {
    train_car_02_player_clip notsolid();
  }

  getplayers()[0] thread function_6d1d0dc8();
  getplayers()[0] districts::function_a7d79fcb("tunnels");
  wait 6;
  level flag::set("start_train");
  level thread flag::delay_set(16.2, "flag_player_train_intro_done");
  level thread scene::play("cin_stakeout_train_cam_shake");
  level scene::play("cin_stakeout_train_intro");

  if(level flag::get("train_player_following")) {
    level scene::init("cin_stakeout_train_block");

    if(level flag::get("in_between_trains")) {
      level thread function_c4ede77b();
    } else {
      level util::delay("in_between_trains", undefined, &function_c4ede77b);
    }

    level scene::play("cin_stakeout_train_cross", "train_cross");
  } else {
    level scene::init("cin_stakeout_train_cross");
    level scene::init("cin_stakeout_train_block");
    level flag::wait_till("train_adler_continue");
    level util::delay("in_between_trains", undefined, &function_c4ede77b);
    level scene::play("cin_stakeout_train_cross", "train_wait_loop_end");
  }

  level thread scene::play("cin_stakeout_train_car_2");
  level flag::wait_till("inside_train_car_02");
  level thread scene::play("cin_stakeout_train_block", "lazar_exit");

  if(isDefined(train_car_02_player_clip)) {
    train_car_02_player_clip solid();
  }

  function_7514adbc();
  namespace_5ceacc03::music("deactivate_1.0_train");
  level scene::play("cin_stakeout_train_jumpout", "jump_out_pre_teleport");
  level flag::set("flag_prep_teleport_train_player");
  getplayers()[0] playersetgroundreferenceent(undefined);
  level.var_77e3cd5f delete();
  level scene::stop("cin_stakeout_train_cam_shake", 1);
  level scene::stop("cin_stakeout_train_car_2");
  level thread scene::play("cin_stakeout_train_jumpout", "jump_out_post_teleport");
  level waittill(#"hash_19e230299ea7fcb3");
  level.adler.var_5b22d53 = undefined;
  level.park.var_5b22d53 = undefined;
  level.lazar.var_5b22d53 = undefined;
  level flag::set("player_jumped_off_train");
  level flag::set("train_done");
  level flag::delay_set(4, "flag_post_train_weapons");
  skipto::function_4e3ab877("train");
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  if(player) {
    train_tunnel_01 = function_dd407ea1(getEntArray("train_tunnel_01", "targetname"));
    train_tunnel_02 = function_dd407ea1(getEntArray("train_tunnel_02", "targetname"));
    train_tunnel_03 = function_dd407ea1(getEntArray("train_tunnel_03", "targetname"));
    train_tunnel_04 = function_dd407ea1(getEntArray("train_tunnel_04", "targetname"));
    train_tunnel_01 thread function_b63268b6();
    train_tunnel_02 thread function_b63268b6();
    train_tunnel_03 thread function_b63268b6();
    train_tunnel_04 thread function_b63268b6();
    level flag::set("train_adler_ready");
    level flag::set("player_jumped_off_train");
    level flag::set("train_done");
  }

  e_vol = getent("vol_sims_look", "targetname");

  if(isDefined(e_vol)) {
    e_vol delete();
  }

  var_5278dbd0 = getent("train_tunnel_moving_model_01", "targetname");

  if(isDefined(var_5278dbd0)) {
    var_5278dbd0 delete();
  }

  var_3ebbb456 = getent("train_tunnel_moving_model_02", "targetname");

  if(isDefined(var_3ebbb456)) {
    var_3ebbb456 delete();
  }
}

function function_c4ede77b() {
  train_car_01_player_clip = getent("train_car_01_player_clip", "targetname");

  if(isDefined(train_car_01_player_clip)) {
    train_car_01_player_clip solid();
  }

  level scene::stop("cin_stakeout_train_block");
  level scene::play("cin_stakeout_train_block", "lazar_close_behind");
}

function function_e9812a44(a_ents, str_shot) {
  if(str_shot == "init") {
    var_3064b024 = a_ents[#"hash_475ee55621b83ca0"];
    cig = util::spawn_model(#"ndy_cigarette_01", var_3064b024.origin);
    cig linkto(var_3064b024, "j_prop_1", (0, 0, 0), (0, 0, 0));
    return;
  }

  level flag::wait_till("guy09_seated");
  level.var_4c282d2a = function_e1e726bd(a_ents[#"hash_3714d2a27221e1d8"], "train_car_01_door_02_r", "train_car_01_door_02_l");
}

function function_6c744934(a_ents) {
  level.var_77e3cd5f = util::spawn_model("tag_origin");
  player = getplayers()[0];
  level.var_77e3cd5f linkto(a_ents[#"hash_475ee55621b83ca0"], "j_prop_1", (0, 0, 0), (0, 0, 0));
  player playersetgroundreferenceent(level.var_77e3cd5f);
}

function function_63886603(a_ents, str_shot) {
  waitframe(1);

  if(isDefined(a_ents[#"hash_3714d2a27221e1d8"])) {
    level.var_4c282d2a = function_e1e726bd(a_ents[#"hash_3714d2a27221e1d8"], "train_car_01_door_02_r", "train_car_01_door_02_l");
  }

  if(isDefined(a_ents[#"hash_3714d5a27221e6f1"]) && str_shot !== "lazar_close_behind") {
    level.var_e0b9564e = function_e1e726bd(a_ents[#"hash_3714d5a27221e6f1"], "train_car_02_door_01_l", "train_car_02_door_01_r");
  }
}

function cin_stakeout_train_jumpout(a_ents, str_shot) {
  if(str_shot == "jump_out_post_teleport") {
    level.var_eefbf2d3 = function_e1e726bd(a_ents[#"hash_3714d4a27221e53e"], "train_car_02_door_02_r", "train_car_02_door_02_l");
    level.var_71550d76 = function_4c1ae753(a_ents[#"train"]);
    level flag::set("teleport_train_player");
    util::delay(12, undefined, &function_48b8f4be);
    level notify(#"player_train_teleport");
    level thread function_e884d0eb(a_ents[#"train"]);

    if(isDefined(a_ents[#"player"])) {
      a_ents[#"player"] waittill(#"hash_6b07997287bc1c83");
    }

    level scene::init("p9_fxanim_cp_stakeout_subway_train_passing_01_bundle");
    level scene::init("p9_fxanim_cp_stakeout_subway_train_passing_02_bundle");
  }
}

function function_48b8f4be() {
  if(isDefined(level.var_71550d76) && isDefined(level.var_71550d76.a_e_lights) && isarray(level.var_71550d76.a_e_lights)) {
    array::delete_all(level.var_71550d76.a_e_lights);
  }

  if(isDefined(level.var_71550d76) && isDefined(level.var_71550d76.var_49b85ad8) && isarray(level.var_71550d76.var_49b85ad8)) {
    array::delete_all(level.var_71550d76.var_49b85ad8);
  }

  if(isDefined(level.var_71550d76.var_62b1eb0a)) {
    level.var_71550d76.var_62b1eb0a delete();
  }

  if(isDefined(level.var_71550d76.var_fba19ceb)) {
    level.var_71550d76.var_fba19ceb delete();
  }

  if(isDefined(level.var_71550d76.var_55fb067)) {
    level.var_71550d76.var_55fb067 delete();
  }

  if(isDefined(level.var_71550d76)) {
    level.var_71550d76 delete();
  }

  if(isDefined(level.var_4c282d2a)) {
    level.var_4c282d2a delete();
  }

  if(isDefined(level.var_e0b9564e)) {
    level.var_e0b9564e delete();
  }

  if(isDefined(level.var_eefbf2d3)) {
    level.var_eefbf2d3 delete();
  }

  var_25d4d93 = getEntArray("all_train_doors", "script_noteworthy");
  array::delete_all(var_25d4d93);
}

function function_e884d0eb(var_71550d76) {}

function function_4c1ae753(var_71550d76) {
  var_71550d76.var_62b1eb0a = getent("post_teleport_train_a", "targetname");
  var_71550d76.var_fba19ceb = getent("post_teleport_train_b", "targetname");
  var_71550d76.var_55fb067 = getent("post_teleport_train_c", "targetname");
  var_71550d76.a_e_lights = getEntArray("light_train_jump_off", "targetname");
  array::run_all(var_71550d76.a_e_lights, &linkto, var_71550d76.var_62b1eb0a);
  var_71550d76.var_fba19ceb linkto(var_71550d76.var_62b1eb0a);
  var_71550d76.var_55fb067 linkto(var_71550d76.var_62b1eb0a);
  var_71550d76.var_49b85ad8 = getEntArray(var_71550d76.var_55fb067.script_linkto, "script_linkname");

  foreach(prop in var_71550d76.var_49b85ad8) {
    prop linkto(var_71550d76.var_55fb067);
  }

  var_71550d76.var_62b1eb0a linkto(var_71550d76, "j_prop_1", (0, 0, 0), (0, 0, 0));
  return var_71550d76;
}

function function_e1e726bd(rig, var_81b1bc71, var_391b674) {
  door_01 = getent(var_81b1bc71, "targetname");
  var_ff2ba721 = door_01 getlinkedent();

  if(var_ff2ba721 !== rig) {
    door_01 unlink();
  }

  door_01 linkto(rig, "j_prop_1", (0, 0, 0), (0, 0, 0));
  var_e970e951 = undefined;

  if(isDefined(door_01.target)) {
    var_e970e951 = getent(door_01.target, "targetname");
  }

  if(isDefined(var_e970e951)) {
    var_e970e951 linkto(door_01);
  }

  door_02 = getent(var_391b674, "targetname");
  var_ff2ba721 = door_02 getlinkedent();

  if(var_ff2ba721 !== rig) {
    door_02 unlink();
  }

  door_02 linkto(rig, "j_prop_2", (0, 0, 0), (0, 0, 0));
  var_d21634ee = undefined;

  if(isDefined(door_02.target)) {
    var_d21634ee = getent(door_02.target, "targetname");
  }

  if(isDefined(var_d21634ee)) {
    var_d21634ee linkto(door_02);
  }

  return rig;
}

function private function_6d1d0dc8() {
  self endon(#"death");
  self util::function_749362d7(1);
  self val::set("train", "allow_crouch", 0);
  self val::set("train", "allow_prone", 0);
  self setmovespeedscale(0.4);
  self clientfield::set_to_player("lerp_fov", 1);
  level waittill(#"hash_415b311f108f4f7c");
  self clientfield::set_to_player("lerp_fov", 2);
  level flag::wait_till("flag_post_train_weapons");
  self util::function_749362d7(0);
  self val::reset("train", "allow_crouch");
  self val::reset("train", "allow_prone");
  self util::blend_movespeedscale(0.72, 0.5);
}

function function_bf15220b() {
  while(!level flag::get("teleport_train_player")) {
    self movex(1536, 3 * 2 - 0.25, 0, 0);
    wait 3 * 2 - 0.25;
    self movex(1536 * -1, 0.05, 0, 0);
    wait 0.25;
  }

  waitframe(1);
  self delete();
}

function function_c18c1869() {
  train_tunnel_01 = function_dd407ea1(getEntArray("train_tunnel_01", "targetname"));
  train_tunnel_02 = function_dd407ea1(getEntArray("train_tunnel_02", "targetname"));
  train_tunnel_03 = function_dd407ea1(getEntArray("train_tunnel_03", "targetname"));
  train_tunnel_04 = function_dd407ea1(getEntArray("train_tunnel_04", "targetname"));
  waitframe(1);
  var_1a34ae13 = struct::get("train_tunnel_spot_1", "targetname");
  var_7ea097e = struct::get("train_tunnel_spot_2", "targetname");
  var_7e1af5de = struct::get("train_tunnel_spot_3", "targetname");
  var_6b455033 = struct::get("train_tunnel_spot_4", "targetname");
  train_tunnel_01.org moveto(var_1a34ae13.origin, 0.05, 0, 0);
  train_tunnel_02.org moveto(var_7ea097e.origin, 0.05, 0, 0);
  train_tunnel_03.org moveto(var_7e1af5de.origin, 0.05, 0, 0);
  train_tunnel_04.org moveto(var_6b455033.origin, 0.05, 0, 0);
  waitframe(1);
  wait 1;
  level thread namespace_5ceacc03::function_9c504c29();
  waitframe(1);
  train_tunnel_01 thread function_913571bd(1, train_tunnel_02);
  train_tunnel_02 thread function_913571bd(2, train_tunnel_03);
  train_tunnel_03 thread function_913571bd(3, train_tunnel_04);
  train_tunnel_04 thread function_913571bd(4, train_tunnel_01);
  level thread function_6935ca68();
  level flag::wait_till("teleport_train_player");
  train_tunnel_01 thread function_b63268b6();
  train_tunnel_02 thread function_b63268b6();
  train_tunnel_03 thread function_b63268b6();
  train_tunnel_04 thread function_b63268b6();
  wait 6;
  player = getplayers()[0];
  player endon(#"death");
  screenshake(player.origin, 0.2, 0, 0, 2, 0, 1);
  player playrumbleonentity(#"hash_400ddb5ce7b2ea08");
  wait 1;
  player stoprumble(#"hash_400ddb5ce7b2ea08");
  wait 5;
}

function function_6935ca68() {
  level endon(#"flag_prep_teleport_train_player");
  player = getplayers()[0];
  player endon(#"death");

  while(!level flag::get("teleport_train_player")) {
    random_time = randomfloatrange(2, 4.5);
    player stoprumble(#"hash_400ddb5ce7b2ea08");
    player playrumbleonentity(#"hash_4028f15ce7c9d722");
    wait randomfloatrange(1, 5);
    random_time = randomfloatrange(0.25, 1);
    player stoprumble(#"hash_4028f15ce7c9d722");
    player playrumbleonentity(#"hash_400ddb5ce7b2ea08");

    if(level flag::get("flag_player_train_intro_done")) {
      screenshake(player.origin, 0.2, 0, 0, random_time, 0, random_time * 0.5, 0, 15);
    }

    playerforward = anglesToForward(player getplayerangles());
    snd::play("emt_train_rumble_screenshake", playerforward * 24);
    snd::play("emt_train_rumble_screenshake", playerforward * -24);
    wait randomfloatrange(1, 2);
  }

  wait 5.5;
  player stoprumble(#"hash_4028f15ce7c9d722");
  player stoprumble(#"hash_400ddb5ce7b2ea08");
}

function function_913571bd(var_7906643a, var_90d9967c) {
  start_index = 1;
  end_index = 5;

  if(!isDefined(level.var_52cc4fe1)) {
    level.var_52cc4fe1 = [];

    for(i = start_index; i <= end_index; i++) {
      level.var_52cc4fe1[i] = struct::get("train_tunnel_spot_" + i, "targetname");
    }
  }

  end_origin = level.var_52cc4fe1[end_index].origin;
  start_origin = level.var_52cc4fe1[start_index].origin;
  self.org dontinterpolate();
  self.org.origin = level.var_52cc4fe1[var_90d9967c].origin;
  speed = 1536 / 3;
  waitframe(1);

  while(isDefined(level.var_52cc4fe1)) {
    delta = end_origin - self.org.origin;
    travel_time = delta[0] / speed;
    self.org moveto(end_origin, travel_time, 0, 0);
    wait travel_time;

    if(level flag::get("teleport_train_player")) {
      break;
    }

    self.org dontinterpolate();
    self.org.origin = start_origin;
  }

  level.var_52cc4fe1 = undefined;
}

function function_dd407ea1(ents) {
  train_tunnel = spawnStruct();
  train_tunnel.link = [];
  lights = [];

  foreach(ent in ents) {
    ent.var_cb62211a = train_tunnel;

    if(!isDefined(ent.script_noteworthy)) {
      continue;
    }

    if(ent.script_noteworthy == "link") {
      if(!isDefined(train_tunnel.link)) {
        train_tunnel.link = [];
      } else if(!isarray(train_tunnel.link)) {
        train_tunnel.link = array(train_tunnel.link);
      }

      train_tunnel.link[train_tunnel.link.size] = ent;
    } else if(ent.script_noteworthy == "train_tunnel") {
      train_tunnel.train_tunnel = ent;
    }

    if(ent.model == "uk_storage_wall_light_01_on" || ent.classname === "light") {
      if(!isDefined(lights)) {
        lights = [];
      } else if(!isarray(lights)) {
        lights = array(lights);
      }

      lights[lights.size] = ent;
    }
  }

  foreach(link in train_tunnel.link) {
    link linkto(train_tunnel.train_tunnel);
  }

  var_f9cb1189 = struct::get(train_tunnel.train_tunnel.target);
  train_tunnel.org = util::spawn_model("tag_origin", var_f9cb1189.origin, var_f9cb1189.angles);
  train_tunnel.train_tunnel linkto(train_tunnel.org);
  return train_tunnel;
}

function function_b63268b6() {
  foreach(ent in self.link) {
    if(isDefined(ent)) {
      ent delete();
    }
  }

  if(isDefined(self.train_tunnel)) {
    self.train_tunnel delete();
  }

  if(isDefined(self.org)) {
    self.org delete();
  }
}

function function_adb5d442(a_ents) {
  if(isDefined(a_ents[#"cigarette"])) {
    level.var_efd78e86 = util::spawn_model("ndy_cigarette_01");
    level.var_efd78e86 linkto(a_ents[#"cigarette"], "j_prop_1", (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(a_ents[#"hash_7cae62e63be0e49a"])) {
    level.var_82bdfa96 = util::spawn_model("par_umbrella_closed_01_85");
    level.var_82bdfa96 linkto(a_ents[#"hash_7cae62e63be0e49a"], "j_prop_1", (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(a_ents[#"briefcase"])) {
    level.var_a07e24ea = util::spawn_model("briefcase_prop");
    level.var_a07e24ea linkto(a_ents[#"briefcase"], "j_prop_1", (0, 0, 0), (0, 0, 0));
  }

  if(isDefined(a_ents[#"newspaper"])) {
    level.var_efec11c3 = a_ents[#"newspaper"];
  }
}

function function_49848b62(a_ents) {
  if(isDefined(a_ents[#"hash_4829d5e6aa02c3ca"])) {
    a_ents[#"hash_4829d5e6aa02c3ca"] setModel(#"hash_2d23880c67fba2af");
    a_ents[#"hash_4829d5e6aa02c3ca"].script_objective = "train";
  }

  if(isDefined(a_ents[#"hash_4829d4e6aa02c217"])) {
    a_ents[#"hash_4829d4e6aa02c217"] setModel(#"hash_2d23890c67fba462");
    a_ents[#"hash_4829d4e6aa02c217"].script_objective = "train";
  }

  if(isDefined(a_ents[#"hash_4829d3e6aa02c064"])) {
    a_ents[#"hash_4829d3e6aa02c064"] setModel(#"hash_2d238a0c67fba615");
    a_ents[#"hash_4829d3e6aa02c064"].script_objective = "train";
  }

  if(isDefined(a_ents[#"guy01"])) {
    a_ents[#"guy01"] setModel(#"hash_d8bd2d6d2845868");
    level.var_af402d52 = a_ents[#"guy01"];
    a_ents[#"guy01"].script_objective = "train";
  }

  if(isDefined(a_ents[#"guy02"])) {
    a_ents[#"guy02"] setModel(#"hash_d8bd5d6d2845d81");
    a_ents[#"guy02"].script_objective = "train";
  }

  if(isDefined(a_ents[#"guy03"])) {
    a_ents[#"guy03"] setModel(#"hash_d8bd4d6d2845bce");
    a_ents[#"guy03"].script_objective = "train";
  }

  if(isDefined(a_ents[#"guy04"])) {
    level.var_2f39ad47 = a_ents[#"guy04"];
    a_ents[#"guy04"] setModel(#"hash_d8bd7d6d28460e7");
    a_ents[#"guy04"].script_objective = "train";
  }

  if(isDefined(a_ents[#"hash_70031b227822b2af"])) {
    a_ents[#"hash_70031b227822b2af"] setModel(#"hash_d8bd6d6d2845f34");
    a_ents[#"hash_70031b227822b2af"].script_objective = "train";
  }

  if(isDefined(a_ents[#"hash_70031c227822b462"])) {
    a_ents[#"hash_70031c227822b462"] setModel(#"hash_d8bd9d6d284644d");
    a_ents[#"hash_70031c227822b462"].script_objective = "train";
  }

  if(isDefined(a_ents[#"guy07"])) {
    level.var_53f3f6c7 = a_ents[#"guy07"];
    a_ents[#"guy07"] setModel(#"hash_d8bd8d6d284629a");
    a_ents[#"guy07"].script_objective = "train";
  }

  if(isDefined(a_ents[#"hash_70031e227822b7c8"])) {
    level.var_662b1b35 = a_ents[#"hash_70031e227822b7c8"];
    a_ents[#"hash_70031e227822b7c8"] setModel(#"hash_d8bcbd6d2844c83");
    a_ents[#"hash_70031e227822b7c8"].script_objective = "train";
  }

  if(isDefined(a_ents[#"guy09"])) {
    level.var_1d8f09fe = a_ents[#"guy09"];
    a_ents[#"guy09"].script_objective = "train";
  }

  if(isDefined(a_ents[#"hash_70069c227825c3b9"])) {
    a_ents[#"hash_70069c227825c3b9"] setModel(#"hash_d884dd6d2814092");
    a_ents[#"hash_70069c227825c3b9"].script_objective = "train";
  }
}

function function_d7dc07ee() {
  self setteam(#"allies");
  self val::set("train", "ignoreall", 1);
  self val::set("train", "ignoreme", 1);
  self thread function_2c1ab89d();
}

function function_2c1ab89d() {
  level endon(#"hash_68487efcb1c63f9", #"train_done");
  e_vol = getent("vol_sims_look", "targetname");
  player = getplayers()[0];

  while(true) {
    while(!player istouching(e_vol)) {
      waitframe(1);
    }

    waitframe(1);

    while(player istouching(e_vol)) {
      if(player islookingat(self)) {
        self ai::look_at(player, 0, undefined, 2);
        self thread dialogue::queue("vox_cp_stkt_02025_sims_mmmhmm_b7_1");
        wait 2;
        level notify(#"hash_68487efcb1c63f9");
      }

      waitframe(1);
    }
  }
}

function function_805f1669() {
  scene::add_scene_func("scene_z_stk_train_intro_riders_loop", &function_adb5d442, "play");
  scene::add_scene_func("scene_z_stk_train_intro_guy09_loop", &function_63886603, "play");
  scene::add_scene_func("scene_z_stk_train_intro_riders_loop", &function_49848b62, "init");
  scene::add_scene_func("scene_z_stk_train_intro_convo", &function_49848b62, "init");
  scene::add_scene_func("scene_z_stk_train_intro_standing_riders_loop", &function_49848b62, "init");
  scene::add_scene_func("scene_z_stk_train_intro_guy09_loop", &function_49848b62, "init");
  level scene::init("scene_z_stk_train_intro_convo");
  level scene::init("scene_z_stk_train_intro_riders_loop");
  level scene::init("scene_z_stk_train_intro_standing_riders_loop");
  level flag::wait_till("flag_train_fadein_start");
  level thread scene::play("scene_z_stk_train_intro_convo");
  level thread scene::play("scene_z_stk_train_intro_riders_loop");
  sims = spawner::simple_spawn_single("sims", &function_d7dc07ee);
  level scene::init("scene_z_stk_train_intro_guy09_loop", sims);
  level flag::wait_till("start_train");
  level thread scene::play("scene_z_stk_train_intro_standing_riders_loop");
  level thread scene::play("scene_z_stk_train_intro_guy09_loop", sims);
  level waittill(#"guy09_seated");
  level flag::set("guy09_seated");
  level thread function_5ecc0c9d();
  level flag::wait_till("train_done");
  level scene::stop("scene_z_stk_train_intro_convo");
  level scene::stop("scene_z_stk_train_intro_riders_loop");
  level scene::stop("scene_z_stk_train_intro_standing_riders_loop");
  level scene::stop("scene_z_stk_train_intro_guy09_loop");

  if(isDefined(level.var_efd78e86)) {
    level.var_efd78e86 delete();
  }

  if(isDefined(level.var_82bdfa96)) {
    level.var_82bdfa96 delete();
  }

  if(isDefined(level.var_a07e24ea)) {
    level.var_a07e24ea delete();
  }

  if(isDefined(level.var_efec11c3)) {
    level.var_efec11c3 delete();
  }

  if(isDefined(level.var_53f3f6c7)) {
    level.var_53f3f6c7 delete();
  }

  if(isDefined(level.var_662b1b35)) {
    level.var_662b1b35 delete();
  }

  if(isDefined(level.var_1d8f09fe)) {
    level.var_1d8f09fe delete();
  }
}

function function_5ecc0c9d() {
  level endon(#"player_train_teleport");
  wait 3;
  party = [];
  party[party.size] = ["gmc1", level.var_2f39ad47];
  party[party.size] = ["gmc2", level.var_53f3f6c7];
  convo = [];
  convo[convo.size] = "vox_cp_stkt_02020_gmc1_heinrichyourelo_c3";
  convo[convo.size] = "vox_cp_stkt_02020_gmc2_yeahwewereuplat_58";
  convo[convo.size] = "vox_cp_stkt_02020_gmc1_thatsincredible_1f";
  convo[convo.size] = "vox_cp_stkt_02020_gmc2_wepaidoffborder_d6";
  convo[convo.size] = "vox_cp_stkt_02020_gmc1_anuncleofminetr_ef";
  convo[convo.size] = 0.6;
  convo[convo.size] = "vox_cp_stkt_02020_gmc2_sorrytohearthat_15";
  convo[convo.size] = 0.4;
  convo[convo.size] = "vox_cp_stkt_02020_gmc1_noideahaventhea_8b";
  convo[convo.size] = 12;
  level thread namespace_c80e7f5f::function_f29bdbdf(party, convo, 1, "player_train_teleport");
}

function function_4cb25b61(str_objective) {
  util::function_268bdf4f("adler", &namespace_11998b8f::function_2f0f0a84);
  util::function_268bdf4f("lazar");
  util::function_268bdf4f("park");
  level thread namespace_5ceacc03::function_d7739931();
  level thread function_805f1669();
}

function function_1eb97f49(str_objective, var_50cc0d4f) {
  level flag::set("start_train_lighting");
  scene::function_d0d7d9f7("cin_stakeout_train_intro", &function_e9812a44);
  scene::add_scene_func("cin_stakeout_train_cam_shake", &function_6c744934, "play");
  scene::add_scene_func("cin_stakeout_train_block", &function_63886603, "lazar_close_behind", "lazar_close_behind");
  scene::add_scene_func("cin_stakeout_train_block", &function_63886603, "lazar_exit", "lazar_exit");
  scene::function_d0d7d9f7("cin_stakeout_train_cross", &function_63886603);
  scene::function_d0d7d9f7("cin_stakeout_train_jumpout", &cin_stakeout_train_jumpout);
  level thread function_c18c1869();
  level thread namespace_5ceacc03::function_e40ab25f();
  level flag::set("inside_train_car_02");
  level thread scene::play_from_time("cin_stakeout_train_car_2", undefined, undefined, 0.4);
  level thread scene::play("cin_stakeout_train_block", "lazar_exit");
  function_7514adbc();
  level scene::play("cin_stakeout_train_jumpout", "jump_out_pre_teleport");
  level scene::stop("cin_stakeout_train_car_2");
  level thread scene::play("cin_stakeout_train_jumpout", "jump_out_post_teleport");
}