/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_training_sim.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_achievements;
#using scripts\cp\_challenges;
#using scripts\cp\_decorations;
#using scripts\cp\_objectives;
#using scripts\cp\_safehouse;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\gametypes\_globallogic_player;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\music_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\table_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_quadtank;
#namespace namespace_c550ee23;

function autoexec __init__sytem__() {
  system::register("training_sim", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_connect( & on_player_connect);
  callback::on_spawned( & on_player_spawned);
  callback::on_ai_spawned( & on_ai_spawned);
  callback::on_ai_damage( & on_ai_damage);
  callback::on_ai_killed( & on_ai_killed);
  callback::on_ai_spawned( & ai_death_derez);
  clientfield::register("actor", "rez_in", 1, 1, "int");
  clientfield::register("actor", "rez_out", 1, 1, "int");
  clientfield::register("vehicle", "rez_in", 1, 1, "int");
  clientfield::register("vehicle", "rez_out", 1, 1, "int");
  clientfield::register("actor", "enable_ethereal_overlay", 1, 1, "int");
  clientfield::register("vehicle", "enable_ethereal_overlay", 1, 1, "int");
  clientfield::register("scriptmover", "enable_ethereal_overlay", 1, 1, "int");
  clientfield::register("toplayer", "postfx_build_world", 1, 1, "counter");
  clientfield::register("toplayer", "cleanup_sim", 1000, 1, "counter");
  function_76550e47();
  function_7f7e9ea5();
  level._effect["round_beacon_disabled"] = "ui/fx_ui_frontend_training_sim_icon_active";
  level._effect["round_beacon_enabled"] = "ui/fx_ui_frontend_training_sim_icon_idle";
  level._effect["round_beacon_moving"] = "ui/fx_ui_frontend_training_sim_icon_move";
  function_b9b9b898();
  function_b8d52e94();
}

function function_b8d52e94() {
  var_5ca6504d = [];
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-15393.6, -3229.79, 1130.5), (0, 0, 0));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-17421.5, -697.8, 1130.5), vectorscale((0, 1, 0), 45));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-18309.6, -3701.79, 1130.5), (0, 0, 0));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-15413.6, 7862.21, 1130.5), (0, 0, 0));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-17441.5, 10394.2, 1130.5), vectorscale((0, 1, 0), 45));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-18329.6, 7390.21, 1130.5), (0, 0, 0));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-28485.6, 7878.21, 1130.5), (0, 0, 0));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-30513.5, 10410.2, 1130.5), vectorscale((0, 1, 0), 45));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-31401.6, 7406.21, 1130.5), (0, 0, 0));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-28479.6, -3223.79, 1130.5), (0, 0, 0));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-30507.5, -691.848, 1130.5), vectorscale((0, 1, 0), 45));
  if(!isDefined(var_5ca6504d)) {
    var_5ca6504d = [];
  } else if(!isarray(var_5ca6504d)) {
    var_5ca6504d = array(var_5ca6504d);
  }
  var_5ca6504d[var_5ca6504d.size] = util::spawn_model("collision_clip_512x512x512", (-28481.6, -3221.79, 1130.5), (0, 0, 0));
  foreach(mdl in var_5ca6504d) {
    mdl disconnectpaths(2, 0);
    mdl hide();
    mdl notsolid();
  }
}

function on_player_connect() {
  self thread function_e22afa2c();
}

function on_player_spawned() {
  lui = self getluimenu("TrainingSim");
  if(isDefined(lui)) {
    self closeluimenu(lui);
  }
}

function function_b9b9b898() {
  if(!isDefined(level.var_6de9c3a5)) {
    level.var_6de9c3a5 = [];
    var_6de9c3a5 = struct::get_script_bundle_list("trainingsimrating", "rating_list");
    foreach(index, rating in var_6de9c3a5) {
      var_1a07fad9 = struct::get_script_bundle("trainingsimrating", rating);
      level.var_6de9c3a5[index] = spawnStruct();
      level.var_6de9c3a5[index].var_92142c80 = var_1a07fad9.var_92142c80;
      level.var_6de9c3a5[index].tokensawarded = var_1a07fad9.tokensawarded;
      level.var_6de9c3a5[index].var_9f813737 = var_1a07fad9.var_9f813737;
    }
  }
}

function function_a91b6cca() {
  if(!(isDefined(level.var_a91b6cca) && level.var_a91b6cca)) {
    level.var_a91b6cca = 1;
    foreach(beacon in struct::get_array("round_beacon", "script_noteworthy")) {
      e_trig = getent(beacon.targetname, "target");
      beacon.prompt = safehouse::init_interactive_prompt(e_trig, & "cp_safehouse_training_nextround", & "CP_SH_CAIRO_TRAINING_START_ROUND", & function_daea15a5, 0);
      beacon.prompt safehouse::function_e04cba0f();
      beacon.prompt.beacon = beacon;
    }
  }
}

function function_daea15a5(e_player) {
  self.beacon notify("trigger", e_player);
}

function function_cc13d7aa() {
  v_spawn_pos = self.s_beacon.origin + vectorscale((0, 0, 1), 50);
  self.var_77104b83 = util::spawn_model("p7_sim_training_icon", v_spawn_pos, self.s_beacon.angles);
  self.var_77104b83.var_792a209 = v_spawn_pos;
  self.var_77104b83.var_3c66c303 = 0;
  self.var_77104b83 thread function_89e36314();
}

function function_d03d00c6() {
  if(sessionmodeissystemlink()) {
    return;
  }
  precacheleaderboards("LB_CP_TRAINING_SIM");
}

function function_89e36314() {
  self endon("death");
  while(true) {
    if(self.var_3c66c303 != 2) {
      var_53a79e45 = (self.var_3c66c303 == 0 ? 5 : 45);
      var_ad74c1fa = (self.var_3c66c303 == 0 ? 2.2 : 2.5);
      n_accel = (self.var_3c66c303 == 0 ? 0.5 : 0.7);
      while(self.var_3c66c303 != 2) {
        self moveto(self.var_792a209 + (0, 0, var_53a79e45), var_ad74c1fa, n_accel, n_accel);
        self waittill("movedone");
        wait(0.15);
        var_53a79e45 = var_53a79e45 * -1;
        self playLoopSound("veh_mapper_drone_main");
      }
    }
    wait(0.2);
  }
}

function function_cf1101c0() {
  self.var_77104b83.e_fx = self.var_77104b83 fx::play("round_beacon_moving", self.var_77104b83.origin, self.var_77104b83.angles, "movedone", 1);
  self.var_77104b83.var_3c66c303 = 2;
  self.var_77104b83.var_792a209 = self.s_beacon.origin + vectorscale((0, 0, 1), 180);
  self.var_77104b83 moveto(self.var_77104b83.var_792a209, 2, 1.25, 0.25);
  self.var_77104b83 playSound("veh_mapper_drone_ping");
  self.var_77104b83 playSound("veh_beacon_ball_move_start");
  self.var_77104b83 playLoopSound("veh_mapper_drone_move");
  self.var_77104b83 waittill("movedone");
  self.var_77104b83.e_fx = self.var_77104b83 fx::play("round_beacon_disabled", self.var_77104b83.origin, self.var_77104b83.angles, "round_beacon_moving", 1);
  self.var_77104b83.var_3c66c303 = 1;
}

function function_fcd1719a() {
  self.var_77104b83.e_fx = self.var_77104b83 fx::play("round_beacon_moving", self.var_77104b83.origin, self.var_77104b83.angles, "movedone", 1);
  self.var_77104b83.var_3c66c303 = 2;
  self.var_77104b83.var_792a209 = self.s_beacon.origin + vectorscale((0, 0, 1), 50);
  self.var_77104b83 moveto(self.var_77104b83.var_792a209, 1.5, 0.3, 1.1);
  self.var_77104b83 waittill("movedone");
  self.var_77104b83.var_3c66c303 = 0;
  self.var_77104b83.e_fx = self.var_77104b83 fx::play("round_beacon_enabled", self.var_77104b83.origin, self.var_77104b83.angles, "round_beacon_moving", 1);
  self.var_77104b83 playSound("veh_mapper_drone_ping");
  self.var_77104b83 playSound("veh_beacon_ball_move_start");
}

function teleport_player(var_cc1de81f) {
  self function_9ab09984();
  self.var_bd5ad7fc = var_cc1de81f;
  self unlink();
  a_spawn_points = get_struct_array("training_sim_spawn_point", "script_noteworthy");
  s_spawn_point = array::random(a_spawn_points);
  self setorigin(s_spawn_point.origin);
  util::wait_network_frame();
  self setplayerangles(s_spawn_point.angles);
}

function function_17f2cd2f() {
  if(self.var_d6d35c88 == level.var_6de9c3a5.size) {
    return;
  }
  if(level.var_6de9c3a5[self.var_d6d35c88].var_92142c80 <= self.var_d1b47d51) {
    if(!(isDefined(self getdstat("trainingSimStats", "ranksAchieved", self.var_d6d35c88)) && self getdstat("trainingSimStats", "ranksAchieved", self.var_d6d35c88))) {
      self setdstat("trainingSimStats", "ranksAchieved", self.var_d6d35c88, 1);
      self setdstat("PlayerStatsByMap", "cp_sh_cairo", "completedDifficulties", self.var_d6d35c88, 1);
      self giveunlocktoken(level.var_6de9c3a5[self.var_d6d35c88].tokensawarded);
      self addplayerstat("career_tokens", level.var_6de9c3a5[self.var_d6d35c88].tokensawarded);
      self addrankxpvalue("completed_training_sim_rating", level.var_6de9c3a5[self.var_d6d35c88].var_9f813737);
      self addplayerstat("CAREER_TRAINING_SIM", 1);
    }
    self.var_d6d35c88++;
    self setluimenudata(self.var_43693cde, "currentRating", self.var_d6d35c88);
  }
}

function function_635d5e9d() {
  for(i = 0; i < 4; i++) {
    if(!(isDefined(self getdstat("trainingSimStats", "ranksAchieved", i)) && self getdstat("trainingSimStats", "ranksAchieved", i))) {
      return i;
    }
  }
  return 4;
}

function run(var_cc1de81f) {
  self.var_8201758a = 1;
  self thread _run(var_cc1de81f);
  self util::waittill_either("training_finished", "death");
  self thread function_a1fa0b8e();
  music::setmusicstate("underscore", self);
}

function function_a1fa0b8e() {
  self endon("death");
  self endon("disconnect");
  self endon("hash_3a6467f0");
  wait(5);
  music::setmusicstate("underscore", self);
}

function _run(var_cc1de81f) {
  self endon("disconnect");
  self thread teleport_player(var_cc1de81f);
  wait(0.05);
  self util::freeze_player_controls(1);
  self.var_24c69c09 = 1;
  self.var_d1b47d51 = 0;
  self.var_80e5e834 = 0;
  self.var_bcf55acc = [];
  self.var_d46900f9 = 0;
  self.var_2ded5a80 = 0;
  self.var_a46c7f73 = 0;
  self cybercom_gadget::function_edff667f();
  self sortheldweapons();
  if(self hascybercomrig("cybercom_emergencyreserve") > 0) {
    self.lives = 1;
  }
  self util::streamer_wait(undefined, 0, 9);
  wait(1.2);
  self clientfield::increment_to_player("postfx_build_world", 1);
  self thread lui::screen_fade_in(1.5, "white");
  codesetuimodelclientfield(self, "safehouse.inTrainingSim", 1);
  self thread function_86a2dc30();
  function_cce02c2e();
  cleanup();
  if(isDefined(self.var_43693cde)) {
    self closeluimenu(self.var_43693cde);
    self.var_43693cde = undefined;
  }
  if(isalive(self)) {
    self notify("hash_1c919c84");
  }
  self.var_24c69c09 = undefined;
}

function cleanup() {
  codesetuimodelclientfield(self, "safehouse.inTrainingSim", 0);
  if(isDefined(self.s_beacon.prompt)) {
    self.s_beacon.prompt safehouse::function_e04cba0f(self);
  }
  objectives::hide("cp_safehouse_training_nextround", self);
  objectives::hide("cp_safehouse_training_start", self);
  if(isDefined(self.s_beacon.e_fx)) {
    self.s_beacon.e_fx delete();
  }
  if(isDefined(self.var_77104b83)) {
    self.var_77104b83 delete();
  }
  a_enemies = getaiarray(self.var_bd5ad7fc, "prefabname");
  foreach(e_enemy in a_enemies) {
    e_enemy delete();
  }
  delete_corpses();
  function_8c8a1672();
  function_65b24866();
}

function function_76550e47() {
  level.var_a6bed3c2 = [];
  var_d10f0e22 = table::load("gamedata/tables/cp/cp_training_sim.csv", "round", 1);
  var_f8cc3a0e = getarraykeys(var_d10f0e22);
  foreach(n_round in var_f8cc3a0e) {
    a_types = getarraykeys(var_d10f0e22[n_round]);
    foreach(str_type in a_types) {
      n_count = var_d10f0e22[n_round][str_type];
      if(n_count > 0) {
        level.var_a6bed3c2[n_round][str_type] = n_count;
      }
    }
  }
}

function function_7f7e9ea5() {
  level.var_4b30274 = table::load("gamedata/tables/cp/cp_training_sim.csv", "score", 1);
}

function function_86a2dc30() {
  self endon("death");
  self endon("hash_1c919c84");
  self waittill("menuresponse", menu, response);
  while(response != "EndTrainingSim") {
    self waittill("menuresponse", menu, response);
  }
  self lui::screen_fade_out(1.5, "black");
  self notify("hash_1c919c84");
}

function function_b5b532e8() {
  var_762314d8 = function_d2614e32();
  e_trig = getent(var_762314d8.targetname, "target");
  var_762314d8.prompt = safehouse::init_interactive_prompt(e_trig, & "cp_safehouse_training_start", & "CP_SH_CAIRO_TRAINING_START_ROUND", & function_daea15a5, 0);
  var_762314d8.prompt safehouse::function_e04cba0f();
  var_762314d8.prompt.beacon = var_762314d8;
  objectives::show("cp_safehouse_training_start", self);
  self.var_77104b83.e_fx = self.var_77104b83 fx::play("round_beacon_enabled", self.var_77104b83.origin, self.var_77104b83.angles, "round_beacon_moving", 1);
  var_762314d8.prompt safehouse::function_a8271940(self);
  var_762314d8 waittill("trigger");
  var_762314d8.prompt safehouse::function_e04cba0f(self);
  objectives::hide("cp_safehouse_training_start", self);
}

function function_cce02c2e() {
  self endon("death");
  self endon("hash_1c919c84");
  self thread function_453e055b();
  self.var_38da1d8e = 0;
  self.var_69051fdd = get_ent("sim_goal_volume", "targetname", 1);
  self.var_2328b30c = function_4041981f();
  self.s_beacon = function_d2614e32();
  music::setmusicstate("ts_underscore", self);
  self notify("enable_cybercom");
  wait(2.5);
  lui::screen_fade_out(0.1, "white");
  function_cc13d7aa();
  wait(0.3);
  lui::screen_fade_in(1.5, "white");
  function_a91b6cca();
  self notify("hash_ce89933d");
  self util::freeze_player_controls(0);
  wait(0.25);
  self util::set_low_ready(0);
  self notify("hash_2aca24c6");
  function_b5b532e8();
  self.var_43693cde = self openluimenu("TrainingSim");
  self setdstat("trainingSimStats", "ranksAchieved", 0, 1);
  self.var_d6d35c88 = self function_635d5e9d();
  self.var_38da1d8e++;
  self setluimenudata(self.var_43693cde, "training_sim_time_bonus", "");
  self setluimenudata(self.var_43693cde, "round_num", "1");
  self setluimenudata(self.var_43693cde, "score", "0");
  self setluimenudata(self.var_43693cde, "roundStartTime", gettime());
  self setluimenudata(self.var_43693cde, "currentRating", self.var_d6d35c88);
  var_38184ced = 2;
  while(isDefined(level.var_a6bed3c2[self.var_38da1d8e])) {
    self.var_1e13e77e = self.s_beacon;
    self.s_beacon = function_c9db2b14(self.var_1e13e77e);
    self thread function_7407182f(self.s_beacon.origin);
    thread function_cf1101c0();
    self setluimenudata(self.var_43693cde, "round_num", "" + self.var_38da1d8e);
    wait(var_38184ced);
    delete_corpses();
    function_8c8a1672();
    function_30df2b91();
    function_49796025();
    a_types = level.var_a6bed3c2[self.var_38da1d8e];
    self.var_4c79ddb8 = [];
    foreach(str_type, n_count in a_types) {
      if(str_type == "goaltime") {
        continue;
      }
      var_8e7d3ece = undefined;
      a_spawners = function_d05904dc(str_type);
      a_spawners = array::randomize(a_spawners);
      a_spawners = array::merge_sort(a_spawners, & function_44933f23);
      var_b3d71f31 = 0;
      assert(a_spawners.size, ("" + str_type) + "");
      for(i = 0; i < n_count; i++) {
        var_a59295c6 = undefined;
        sp = a_spawners[var_b3d71f31];
        var_b3d71f31++;
        var_b3d71f31 = (var_b3d71f31 >= a_spawners.size ? 0 : var_b3d71f31);
        while(true) {
          e_spawned = sp spawner::spawn(1);
          if(isDefined(e_spawned)) {
            e_spawned.var_a5c5977d = sp.origin[2];
            e_spawned thread function_6dbfd048(self);
            e_spawned hide();
            e_spawned notsolid();
            e_spawned.takedamage = 0;
            e_spawned ai::set_ignoreall(1);
            if(sp.script_string === "spawn_at_spawner") {
              v_origin = e_spawned.origin;
            } else {
              v_origin = function_27b9fdd3(e_spawned, self.s_beacon.origin, var_8e7d3ece);
            }
            v_angles = vectortoangles(self.origin - v_origin);
            e_spawned spawner::teleport_spawned(v_origin, v_angles);
            var_5e280b91 = randomfloatrange(0.25, 0.45);
            wait(var_5e280b91);
            e_spawned show();
            e_spawned.takedamage = 1;
            e_spawned ai::set_ignoreall(0);
            e_spawned getperfectinfo(self, 1);
            e_spawned util::delay(1, "death", & solid);
            if(isactor(e_spawned)) {
              e_spawned thread function_9b1ae7e9(self);
            } else if(isvehicle(e_spawned)) {
              e_spawned thread function_826a69d8(self);
            }
            if(!isDefined(var_8e7d3ece)) {
              var_8e7d3ece = e_spawned.origin;
            }
            if(!isDefined(self.var_4c79ddb8)) {
              self.var_4c79ddb8 = [];
            } else if(!isarray(self.var_4c79ddb8)) {
              self.var_4c79ddb8 = array(self.var_4c79ddb8);
            }
            self.var_4c79ddb8[self.var_4c79ddb8.size] = e_spawned;
            break;
          }
          wait(0.05);
        }
      }
    }
    self notify("hash_a120a3f4");
    music::setmusicstate("ts_combat", self);
    while(true) {
      var_bd6b575 = [];
      foreach(e_spawned in self.var_4c79ddb8) {
        if(isDefined(e_spawned) && isalive(e_spawned) && e_spawned.team != self.team) {
          var_bd6b575[var_bd6b575.size] = e_spawned;
        }
      }
      if(var_bd6b575.size <= 0) {
        break;
      }
      self.var_4c79ddb8 = var_bd6b575;
      wait(0.25);
    }
    self.var_4c79ddb8 = [];
    if(!isDefined(level.var_a6bed3c2[self.var_38da1d8e + 1])) {
      break;
    }
    music::setmusicstate("ts_underscore", self);
    objectives::show("cp_safehouse_training_nextround", self);
    function_fcd1719a();
    var_38184ced = 3.5;
    self.s_beacon.prompt safehouse::function_a8271940(self);
    self.s_beacon waittill("trigger");
    self thread function_4837ece8(self.s_beacon);
    function_e8f80ed0();
    function_31f3ed94(self);
    self.s_beacon.prompt safehouse::function_e04cba0f(self);
    objectives::hide("cp_safehouse_training_nextround", self);
    self.var_38da1d8e++;
  }
  wait(2);
  self util::freeze_player_controls(1);
  music::setmusicstate("ts_victory", self);
  self luinotifyevent(&"training_sim_complete", 0);
  wait(3);
  self lui::screen_fade_out(2, "black");
  self util::freeze_player_controls(0);
  if(level.gameskilllowest == 4) {
    self addplayerstat("career_training_sim_real", 1);
  }
}

function function_7407182f(var_19f0c7ba) {
  var_878a2866 = var_19f0c7ba - self.origin;
  self util::freeze_player_controls(1);
  self startcameratween(0.3);
  self setplayerangles((17, vectortoangles(var_878a2866)[1], 0));
  wait(0.4);
  self util::freeze_player_controls(0);
}

function function_a92a30c4(var_6ec35b3f, var_fcbbec04) {
  var_59fb42bf = acos(vectordot(var_6ec35b3f, var_fcbbec04) / (length(var_6ec35b3f) * length(var_fcbbec04)));
  return var_59fb42bf;
}

function function_44933f23(sp1, sp2) {
  if(sp1.script_string === "spawn_at_spawner") {
    return true;
  }
  return false;
}

function function_49796025() {
  self.var_bcf55acc[self.var_38da1d8e] = spawnStruct();
  self.var_bcf55acc[self.var_38da1d8e].var_dbc3b44a = gettime();
  self.var_bcf55acc[self.var_38da1d8e].headshots = 0;
  self.var_bcf55acc[self.var_38da1d8e].var_5004e3e9 = 0;
  self.var_bcf55acc[self.var_38da1d8e].var_827fa2cc = 0;
}

function function_e8f80ed0() {
  var_bc6c413b = self.var_bcf55acc[self.var_38da1d8e];
  if(isDefined(var_bc6c413b)) {
    var_3313da6b = level.var_a6bed3c2[self.var_38da1d8e]["goaltime"];
    var_4cd10db3 = gettime() - var_bc6c413b.var_dbc3b44a;
    n_round_time = var_4cd10db3 / 1000;
    var_8f752567 = n_round_time - var_3313da6b;
    var_35989c93 = 0;
    if(var_8f752567 < 0) {
      var_35989c93 = floor(abs(var_8f752567 * 10));
    }
    var_bc6c413b.var_a3d7c1d0 = self.var_80e5e834;
    var_bc6c413b.n_time_ms = var_4cd10db3;
    var_bc6c413b.var_35989c93 = var_35989c93;
    self.var_80e5e834 = 0;
    if(var_35989c93 > 0) {
      self.var_d1b47d51 = self.var_d1b47d51 + var_35989c93;
      self function_a5ac6877();
      self function_17f2cd2f();
      self setluimenudata(self.var_43693cde, "training_sim_time_bonus", "" + var_35989c93);
      self setluimenudata(self.var_43693cde, "score", "" + self.var_d1b47d51);
    }
  }
}

function delete_corpses() {
  a_corpses = getcorpsearray();
  foreach(e_corpse in a_corpses) {
    e_corpse delete();
  }
  a_corpses = getEntArray("script_vehicle_corpse", "classname");
  foreach(e_corpse in a_corpses) {
    e_corpse delete();
  }
}

function function_8c8a1672() {
  self clientfield::increment_to_player("cleanup_sim", 1);
}

function function_65b24866() {
  a_dropped_weapons = getdroppedweapons();
  foreach(e_weapon in a_dropped_weapons) {
    if(isDefined(e_weapon) && distance2dsquared(self.origin, e_weapon.origin) <= (5000 * 5000)) {
      e_weapon delete();
    }
  }
}

function function_30df2b91() {
  var_fed635a = getweapon("riotshield");
  if(!isDefined(var_fed635a)) {
    return;
  }
  a_dropped_weapons = getdroppedweapons();
  foreach(e_weapon in a_dropped_weapons) {
    if(isDefined(e_weapon) && isDefined(e_weapon.item) && e_weapon.item == var_fed635a && distance2dsquared(self.origin, e_weapon.origin) <= (5000 * 5000)) {
      e_weapon delete();
    }
  }
}

function function_4837ece8(s_beacon) {
  self luinotifyevent(&"training_sim_round_complete", 0);
}

function function_c9db2b14(var_d8d3a227) {
  a_beacons = get_struct_array("round_beacon", "script_noteworthy");
  if(isDefined(var_d8d3a227)) {
    arrayremovevalue(a_beacons, var_d8d3a227);
  } else {
    var_178d40cf = arraygetclosest(self.origin, a_beacons);
    arrayremovevalue(a_beacons, var_178d40cf);
  }
  s_beacon = array::random(a_beacons);
  function_d4242515(s_beacon);
  return s_beacon;
}

function function_d2614e32() {
  a_beacons = get_struct_array("round_beacon", "script_noteworthy");
  var_178d40cf = arraygetclosest(self.origin, a_beacons);
  return var_178d40cf;
}

function function_4041981f() {
  a_beacons = get_struct_array("round_beacon", "script_noteworthy");
  foreach(s_beacon in a_beacons) {
    if(s_beacon.groupname === "tower1") {
      return s_beacon;
    }
  }
}

function function_6dbfd048(e_player) {
  self endon("death");
  e_player waittill("death");
  objectives::hide("cp_safehouse_training_nextround", e_player);
  objectives::hide("cp_safehouse_training_start", e_player);
  self delete();
}

function function_27b9fdd3(e_spawned, v_pos, var_8e7d3ece) {
  var_88ea9601 = e_spawned getabsmaxs();
  var_eea2d76b = e_spawned getabsmins();
  n_size = max(var_88ea9601[0] - var_eea2d76b[0], var_88ea9601[1] - var_eea2d76b[1]);
  n_height = var_88ea9601[2] - var_eea2d76b[2];
  var_567a389e = undefined;
  if(isDefined(var_8e7d3ece)) {
    v_pos = var_8e7d3ece;
    var_ac2f333b = n_size;
    var_819d27f5 = var_ac2f333b + (n_size * 5);
    if(getdvarint("", 0)) {
      sphere(v_pos, 20, e_spawned.script_color, 1, 0, 10, 600);
    }
  } else {
    if(e_spawned.script_string === "spawn_between_towers") {
      var_bbcaca07 = distance2d(e_spawned.spawner.origin, self.var_2328b30c.origin);
      var_ac2f333b = 0;
      var_819d27f5 = e_spawned.spawner.radius;
      var_226a15c3 = (self.s_beacon.origin[0], self.s_beacon.origin[1], e_spawned.spawner.origin[2]);
      var_c4a9fefc = (self.var_1e13e77e.origin[0], self.var_1e13e77e.origin[1], var_226a15c3[2]);
      v_pos = var_226a15c3 + ((vectornormalize(var_c4a9fefc - var_226a15c3)) * var_bbcaca07);
    } else {
      if(isDefined(v_pos)) {
        var_ac2f333b = 0;
        var_819d27f5 = (var_ac2f333b + 1000) + (n_size * 3);
        v_pos = (v_pos[0], v_pos[1], e_spawned.var_a5c5977d);
      } else {
        v_pos = self.origin;
        var_ac2f333b = max(500, n_size);
        var_819d27f5 = var_ac2f333b + (n_size * 3);
        var_567a389e = anglesToForward(self.angles) * -10;
      }
    }
  }
  n_half_height = n_height / 2;
  var_b61860b6 = n_size / 2;
  var_2f3e48f3 = n_size / 2;
  var_fdf395af = [];
  v_pos = (v_pos[0], v_pos[1], e_spawned.var_a5c5977d);
  if(isDefined(var_567a389e)) {
    queryresult = positionquery_source_navigation(v_pos, var_ac2f333b, var_819d27f5, n_half_height, var_b61860b6, e_spawned, var_2f3e48f3, var_567a389e);
  } else {
    queryresult = positionquery_source_navigation(v_pos, var_ac2f333b, var_819d27f5, n_half_height, var_b61860b6, e_spawned, var_2f3e48f3);
  }
  if(queryresult.data.size) {
    return queryresult.data[randomint(queryresult.data.size)].origin;
  }
  if(getdvarint("", 0)) {
    foreach(point in var_fdf395af) {
      debugstar(point.origin, 600, e_spawned.script_color);
    }
  }
  queryresult = positionquery_source_navigation(self.s_beacon.origin, var_ac2f333b, var_819d27f5, n_half_height, var_b61860b6, e_spawned, var_2f3e48f3);
  if(queryresult.data.size) {
    return queryresult.data[randomint(queryresult.data.size)].origin;
  }
  return e_spawned.origin;
}

function function_d05904dc(str_type) {
  a_spawners = util::query_ents(associativearray("classname", str_type, "vehicletype", str_type), 0, [], 0, 1);
  a_spawners = getentarrayfromarray(a_spawners, self.var_bd5ad7fc, "prefabname");
  a_spawners = array::filter(a_spawners, 0, & is_spawner);
  return a_spawners;
}

function is_spawner(ent) {
  return isspawner(ent);
}

function get_ent_array(str_value, str_key, b_ignore_spawners = 0) {
  a_ents = getEntArray(self.var_bd5ad7fc, "prefabname", b_ignore_spawners);
  a_ents = getentarrayfromarray(a_ents, str_value, str_key);
  return a_ents;
}

function get_ent(str_value, str_key, b_ignore_spawners) {
  a_ents = get_ent_array(str_value, str_key, b_ignore_spawners);
  if(a_ents.size) {
    return a_ents[0];
  }
  return undefined;
}

function function_aeb2edb(str_value, str_key) {
  a_ents = getactorarray(self.var_bd5ad7fc, "prefabname");
  if(isDefined(str_value)) {
    a_ents = getentarrayfromarray(a_ents, str_value, str_key);
  }
  return a_ents;
}

function get_struct_array(str_value, str_key) {
  var_5ea0ba06 = struct::get_array(self.var_bd5ad7fc, "prefabname");
  var_389e3f9d = struct::get_array(str_value, str_key);
  return arrayintersect(var_5ea0ba06, var_389e3f9d);
}

function on_ai_spawned() {
  self endon("death");
  if(self.script_noteworthy === "training_spawners") {
    self.var_72f54197 = function_c1a5b344();
    self.var_b0ac175a = 0;
    util::wait_network_frame();
    self clientfield::set("rez_in", 1);
    if(self function_29281420()) {
      self clientfield::set("enable_ethereal_overlay", 1);
    }
  } else if(isDefined(self.remote_owner)) {
    self.prefabname = self.remote_owner.var_bd5ad7fc;
  }
}

function on_ai_damage(s_params) {
  if(isplayer(s_params.eattacker) && (isDefined(s_params.eattacker.var_24c69c09) && s_params.eattacker.var_24c69c09)) {
    var_bc6c413b = s_params.eattacker.var_bcf55acc[s_params.eattacker.var_38da1d8e];
    if(isDefined(var_bc6c413b) && isDefined(self.var_72f54197)) {
      n_multiplier = 1;
      if(isinarray(array("helmet", "head", "neck"), s_params.shitloc)) {
        if(isDefined(self.var_72f54197["headshot_multiplier"])) {
          n_multiplier = self.var_72f54197["headshot_multiplier"];
          var_bc6c413b.headshots++;
          s_params.eattacker.var_d46900f9++;
        }
      } else {
        if(isinarray(array("torso_upper", "torso_mid"), s_params.shitloc)) {
          if(isDefined(self.var_72f54197["torso_multiplier"])) {
            n_multiplier = self.var_72f54197["torso_multiplier"];
            var_bc6c413b.var_5004e3e9++;
            s_params.eattacker.var_2ded5a80++;
          }
        } else if(isDefined(self.var_72f54197["legs_multiplier"])) {
          n_multiplier = self.var_72f54197["legs_multiplier"];
          var_bc6c413b.var_827fa2cc++;
          s_params.eattacker.var_a46c7f73++;
        }
      }
      if(n_multiplier > self.var_b0ac175a) {
        self.var_b0ac175a = n_multiplier;
      }
    }
  }
}

function on_ai_killed(s_params) {
  if(isplayer(s_params.eattacker) && (isDefined(s_params.eattacker.var_24c69c09) && s_params.eattacker.var_24c69c09)) {
    player = s_params.eattacker;
    var_a3d7c1d0 = self.var_72f54197["basescore"];
    n_score = floor(var_a3d7c1d0 * self.var_b0ac175a);
    player.var_80e5e834 = player.var_80e5e834 + n_score;
    player.var_d1b47d51 = player.var_d1b47d51 + n_score;
    player thread function_a5ac6877();
    player setluimenudata(player.var_43693cde, "score", "" + player.var_d1b47d51);
    player function_17f2cd2f();
  }
}

function function_a5ac6877() {
  self endon("death");
  self endon("hash_1c919c84");
  wait(0.05);
  self.score = int(self.var_d1b47d51);
  self.pers["score"] = self.score;
}

function function_c1a5b344() {
  foreach(str_type in getarraykeys(level.var_4b30274)) {
    if(issubstr(self.classname, str_type) || (isDefined(self.vehicletype) && issubstr(self.vehicletype, str_type))) {
      return level.var_4b30274[str_type];
    }
  }
}

function function_d4242515(s_beacon) {
  a_volumes = getEntArray("info_volume", "classname");
  a_volumes = getentarrayfromarray(a_volumes, s_beacon.prefabname, "prefabname");
  a_volumes = getentarrayfromarray(a_volumes, s_beacon.groupname, "groupname");
  s_beacon.var_f66aa772 = function_5ecb6fa8(s_beacon, "inner_volume");
  s_beacon.var_20087b79 = function_5ecb6fa8(s_beacon, "middle_volume");
  s_beacon.var_2f9a05d7 = function_5ecb6fa8(s_beacon, "outer_volume");
  s_beacon.var_69051fdd = self.var_69051fdd;
}

function function_5ecb6fa8(s_beacon, str_volume) {
  a_volumes = getEntArray("info_volume", "classname");
  a_volumes = getentarrayfromarray(a_volumes, s_beacon.prefabname, "prefabname");
  a_volumes = getentarrayfromarray(a_volumes, s_beacon.groupname, "groupname");
  a_volumes = getentarrayfromarray(a_volumes, str_volume, "targetname");
  assert(a_volumes.size == 1, "" + str_volume);
  return a_volumes[0];
}

function function_9b1ae7e9(player) {
  self endon("death");
  if(isDefined(self.script_goalvolume)) {
    self setgoal(function_5ecb6fa8(player.s_beacon, self.script_goalvolume), 1);
  } else {
    self setgoal(player.s_beacon.var_69051fdd, 1);
  }
  player waittill("hash_a120a3f4");
  while(player function_aeb2edb().size > 2) {
    wait(randomfloatrange(0.6666666, 1.333333));
  }
  if(!issubstr(self.classname, "warlord")) {
    self.var_c9a40973 = gettime() + 2500;
    while(true) {
      var_f2053c49 = distance2dsquared(self.origin, player.s_beacon.origin);
      var_fba032a4 = distance2dsquared(self.origin, player.origin);
      var_77f64226 = distance2dsquared(player.origin, player.s_beacon.origin);
      if(var_fba032a4 > (450 * 450) || var_77f64226 < (450 * 450)) {
        self setgoal(player.s_beacon.var_f66aa772, 1);
      }
      if(!getdvarint("tu1_trainingSimDisableTeleport", 1)) {
        if(var_f2053c49 >= (450 * 450) && var_77f64226 >= (450 * 450) && var_fba032a4 >= (300 * 300)) {
          if(function_93405f3(self, player)) {
            self.var_c9a40973 = gettime() + 2500;
          } else if(gettime() > self.var_c9a40973) {
            self clientfield::set("rez_out", 1);
            self ai::set_ignoreall(1);
            self hide();
            v_origin = player.s_beacon.origin;
            v_origin = v_origin + (anglesToForward(player.s_beacon.angles) * (randomfloatrange(-150, -20)));
            v_origin = v_origin + (anglestoright(player.s_beacon.angles) * (randomfloatrange(-150, 150)));
            v_angles = vectortoangles(player.origin - v_origin);
            self spawner::teleport_spawned(v_origin, v_angles);
            util::wait_network_frame();
            self clientfield::set("rez_in", 1);
            self ai::set_ignoreall(0);
            self show();
            break;
          }
        } else {
          self.var_c9a40973 = gettime() + 2500;
        }
      }
      wait(0.25);
    }
  }
}

function function_93405f3(e_enemy, player) {
  n_player_fov = getdvarfloat("cg_fov");
  n_dot_check = cos(n_player_fov);
  v_pos = e_enemy.origin;
  v_eye = player getEye();
  v_facing = anglesToForward(player getplayerangles());
  v_to_ent = vectornormalize(v_pos - v_eye);
  n_dot = vectordot(v_facing, v_to_ent);
  if(n_dot > n_dot_check) {
    if(e_enemy sightconetrace(v_eye, player) != 0) {
      return true;
    }
  }
  return false;
}

function function_826a69d8(player) {
  self setgoal(player);
}

function function_5c685ad1() {
  self waittill("death");
  if(isDefined(self) && !self function_9d7569cc()) {
    self clientfield::set("enable_ethereal_overlay", 0);
  }
}

function ai_death_derez() {
  if(self function_9d7569cc()) {
    self thread derez_when_actor_becomes_corpse();
    self thread derez_on_ragdoll_start();
  } else {
    self thread function_5c685ad1();
  }
}

function function_9d7569cc() {
  return !isvehicle(self) && isactor(self);
}

function function_29281420() {
  return self.team == "axis";
}

function derez_when_actor_becomes_corpse() {
  self endon("ai_derez_death");
  self waittill("actor_corpse", e_corpse);
  if(isDefined(e_corpse)) {
    e_corpse clientfield::set("rez_out", 1);
  }
  util::wait_network_frame();
  if(isDefined(self)) {
    self playSound("evt_ai_derez");
  }
  wait(0.2);
  if(isDefined(e_corpse)) {
    e_corpse delete();
  }
  if(isDefined(self)) {
    self notify("ai_derez_death");
  }
}

function derez_on_ragdoll_start() {
  self endon("ai_derez_death");
  self waittill("start_ragdoll");
  if(self.b_balcony_death === 1) {
    wait(4);
  }
  if(isDefined(self)) {
    self clientfield::set("rez_out", 1);
  }
  util::wait_network_frame();
  if(isDefined(self)) {
    self playSound("evt_ai_derez");
  }
  wait(0.2);
  if(isDefined(self)) {
    self delete();
    self notify("ai_derez_death");
  }
}

function function_31f3ed94(e_player) {
  a_weapons = e_player getweaponslist();
  foreach(weapon in a_weapons) {
    e_player givemaxammo(weapon);
    e_player setweaponammoclip(weapon, weapon.clipsize);
  }
}

function function_6d04e0c2() {
  highestscore = self getdstat("trainingSimStats", "highestScore");
  if(self.var_d1b47d51 > highestscore) {
    self setdstat("trainingSimStats", "highestScore", int(self.var_d1b47d51));
    self setdstat("trainingSimStats", "highestRound", int(self.var_38da1d8e));
    self setdstat("trainingSimStats", "oneHitKills", self.var_d46900f9);
    self setdstat("trainingSimStats", "torsoHits", self.var_2ded5a80);
    self setdstat("trainingSimStats", "limbHits", self.var_a46c7f73);
  }
}

function upload_leaderboards() {
  self uploadleaderboards();
}

function function_3206b93a() {
  if(self decorations::function_59727018()) {
    self givedecoration("cp_medal_training_sim");
  }
  if(isDefined(self.var_d6d35c88)) {
    if(self.var_d6d35c88 == level.var_6de9c3a5.size) {
      self achievements::give_achievement("CP_TRAINING_GOLD");
    }
  }
  if(decorations::function_bea4ff57()) {
    self givedecoration("cp_medal_all_weapon_unlocks");
  }
  self.var_cae9ddc4 = self openluimenu("TrainingSimAAR");
  self setluimenudata(self.var_cae9ddc4, "training_sim_aar_score", "" + self.var_d1b47d51);
  self setluimenudata(self.var_cae9ddc4, "training_sim_aar_round", "" + self.var_38da1d8e);
  self setluimenudata(self.var_cae9ddc4, "training_sim_aar_lethals", "" + self.var_d46900f9);
  self setluimenudata(self.var_cae9ddc4, "training_sim_aar_torsohits", "" + self.var_2ded5a80);
  self setluimenudata(self.var_cae9ddc4, "training_sim_aar_limbhits", "" + self.var_a46c7f73);
  self function_6d04e0c2();
  uploadstats(self);
  self function_9ab09984();
  self waittill("menuresponse", menu, response);
  while(response != "closed") {
    self waittill("menuresponse", menu, response);
  }
  self closeluimenu(self.var_cae9ddc4);
}

function function_9ab09984() {
  self globallogic_player::function_7bdf5497();
  self.pers["score"] = 0;
  self.pers["kills"] = 0;
  self.pers["incaps"] = 0;
  self.pers["assists"] = 0;
  self.pers["revives"] = 0;
}

function function_e22afa2c() {
  self endon("disconnect");
  while(true) {
    var_dd6f0201 = getdvarint("");
    var_e2c1fe1f = getdvarint("");
    if(var_dd6f0201) {
      function_11a03fdc(getdvarint(""));
      end_round();
      setdvar("", 0);
    } else if(var_e2c1fe1f) {
      end_round();
      setdvar("", 0);
    }
    wait(0.3);
  }
}

function function_453e055b() {
  while(true) {
    while(!getdvarint("", 0)) {
      wait(1);
    }
    end_round();
    self waittill("hash_a120a3f4");
  }
}

function end_round() {
  if(!isDefined(self.var_4c79ddb8)) {
    self waittill("hash_a120a3f4");
  }
  if(self.var_4c79ddb8.size) {
    wait(5);
    level array::run_all(array::remove_dead(self.var_4c79ddb8), & kill);
  }
  wait(5);
  self.s_beacon.prompt function_daea15a5(self);
}

function function_11a03fdc(n_round) {
  self.var_38da1d8e = n_round - 1;
}