/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_68cdf0ca5df5e.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_36fc02e86719d0f5;
#using script_3bbf85ab4cb9f3c2;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_413ab8fe25a61c50;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5133d88c555e460;
#using script_5549681e1669c11a;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_634ae70c663d1cc9;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using script_f38dc50f0e82277;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_8c04284b;
class class_f4bf8a8 {
  var angles;
  var m_center;
  var m_name;
  var m_namehash;
  var maxs;
  var origin;
  var script_int;
  var script_noteworthy;
  var script_parameters;
  var tweakcam;
  var var_24df6bfb;
  var var_2e06f9d4;
  var var_35760f46;
  var var_36f9408;
  var var_486c1553;
  var var_5479b5f3;
  var var_5d3a1;
  var var_5e72455f;
  var var_60821378;
  var var_622da539;
  var var_63f7cb8f;
  var var_694b395b;
  var var_73ab8b47;
  var var_73c16a24;
  var var_74297693;
  var var_79baa471;
  var var_7c7691d6;
  var var_80292cd;
  var var_81e9b5ca;
  var var_961441d1;
  var var_9cd25248;
  var var_a1fa7529;
  var var_b198ac5a;
  var var_b60ab5fd;
  var var_be31d6d6;
  var var_bedb7d90;
  var var_c0023851;
  var var_cb3e8eba;
  var var_d7b6f39c;
  var var_e2a6dd61;

  constructor() {
    var_81e9b5ca = [];
    var_c0023851 = undefined;
    var_73ab8b47 = [];
    var_486c1553 = undefined;
    var_622da539 = undefined;
    var_9cd25248 = undefined;
    var_2e06f9d4 = 1;
    var_961441d1 = 1;
    var_24df6bfb = 28;
    var_e2a6dd61 = [];
    var_5d3a1 = [];
    var_bedb7d90 = 5;
    var_5e72455f = 10;
    var_35760f46 = 0;
    var_60821378 = 3;
    var_d7b6f39c = [];
  }

  function destructor() {
    foreach(exit in var_b198ac5a) {
      if(isDefined(exit.fakemodel)) {
        exit.fakemodel delete();
      }
    }
  }

  function function_806bba() {
    return var_961441d1;
  }

  function function_1f47a68(val) {
    var_961441d1 = val;
  }

  function function_ffcf1d1() {
    return m_center.origin;
  }

  function function_14b480d1() {
    return var_622da539;
  }

  function function_19a90502(val) {
    var_60821378 = val;
  }

  function ispaused() {
    return var_7c7691d6;
  }

  function function_1e4d7a0c(var_4983b208) {
    function_e87bab7b(var_4983b208);

    foreach(spot in var_74297693) {
      if(isDefined(spot.mdl)) {
        continue;
      }

      if((spot.var_4983b208 &var_4983b208) == 0) {
        continue;
      }

      if(isDefined(spot.maxround) && level.doa.roundnumber > spot.maxround) {
        continue;
      }

      spot.mdl = namespace_ec06fe4a::spawnmodel(spot.origin, spot.modelname, spot.angles, m_name + "_decor_item");

      if(isDefined(spot.mdl)) {
        spot.mdl setscale(spot.scale);

        if(is_true(spot.var_bfbc537c)) {
          spot.mdl disconnectpaths();
          spot.mdl solid();
          continue;
        }

        spot.mdl notsolid();
      }
    }
  }

  function function_20b2a1e4(mask) {
    self endon(#"deactivate");

    while(true) {
      if(level.doa.var_ecff3871) {
        self triggerenable((mask & 2) != 0);
      } else {
        self triggerenable((mask & 1) != 0);
      }

      level waittill(#"hash_180d4d3b6b7ea3f3");
    }
  }

  function function_20b4ef55(side) {
    return var_5d3a1[side].size;
  }

  function function_21d1be3d(side) {
    assert(isDefined(var_63f7cb8f[side]), "<dev string:x7c>" + side + "<dev string:x98>" + m_name);
    return var_63f7cb8f[side][randomint(var_63f7cb8f[side].size)];
  }

  function function_23476287(idx, side) {
    assert(isDefined(var_73c16a24[side]), "<dev string:x7c>" + side + "<dev string:x98>" + m_name);
    assert(idx < var_73c16a24.size, "<dev string:xae>" + side + "<dev string:xd9>" + m_name);
    return var_73c16a24[side][idx];
  }

  function function_242886d5(type) {
    if(!isDefined(type)) {
      return var_a1fa7529;
    }

    var_f9c9c0 = [];

    foreach(hazard in var_a1fa7529) {
      if(hazard.script_noteworthy === type) {
        var_f9c9c0[var_f9c9c0.size] = hazard;
      }
    }

    return var_f9c9c0;
  }

  function function_25962665(wave) {
    if(!isDefined(var_5d3a1[wave.spawn_side])) {
      var_5d3a1[wave.spawn_side] = [];
    } else if(!isarray(var_5d3a1[wave.spawn_side])) {
      var_5d3a1[wave.spawn_side] = array(var_5d3a1[wave.spawn_side]);
    }

    var_5d3a1[wave.spawn_side][var_5d3a1[wave.spawn_side].size] = wave;
  }

  function getname() {
    return m_name;
  }

  function getcenter() {
    return m_center;
  }

  function function_3476ff6d() {
    return var_79baa471;
  }

  function function_3bf5b85d() {
    return var_486c1553;
  }

  function function_3e91f789(val) {
    var_9cd25248 = val;
  }

  function initialize(arena_struct, index) {
    m_center = arena_struct;
    m_name = arena_struct.script_noteworthy;
    m_namehash = hash(m_name);
    var_be31d6d6 = index;
    var_b60ab5fd = struct::get_array(m_name + "_safe_spot", "targetname");
    var_74297693 = struct::get_array(m_name + "_decor", "targetname");
    var_79baa471 = struct::get_array(m_name + "_rise_spot", "targetname");
    var_5479b5f3 = struct::get_array(m_name + "_pickup", "targetname");
    var_a1fa7529 = struct::get_array(m_name + "_hazard", "targetname");
    var_80292cd = struct::get_array(m_name + "_player_spawnpoint", "targetname");
    var_73ab8b47 = struct::get_array(m_name + "_silverback_spawn", "targetname");
    var_b198ac5a = [];
    exits = getEntArray(m_name + "_doa_exit", "targetname");
    var_c0023851 = struct::get(m_name + "_wild_spot", "targetname");
    var_e2a6dd61 = getEntArray(m_name + "_camera_tweak", "targetname");

    foreach(exit in exits) {
      var_b198ac5a[exit.script_noteworthy] = exit;
    }

    assert(var_b198ac5a.size == 4, "<dev string:x38>");
    var_63f7cb8f = [];
    var_63f7cb8f[# "bottom"] = struct::get_array(m_name + "_enemy_spawn_bottom", "targetname");
    var_63f7cb8f[# "left"] = struct::get_array(m_name + "_enemy_spawn_left", "targetname");
    var_63f7cb8f[# "top"] = struct::get_array(m_name + "_enemy_spawn_top", "targetname");
    var_63f7cb8f[# "right"] = struct::get_array(m_name + "_enemy_spawn_right", "targetname");

    foreach(spot in var_63f7cb8f[# "bottom"]) {
      spot.origin = namespace_ec06fe4a::function_65ee50ba(spot.origin);
    }

    foreach(spot in var_63f7cb8f[# "left"]) {
      spot.origin = namespace_ec06fe4a::function_65ee50ba(spot.origin);
    }

    foreach(spot in var_63f7cb8f[# "top"]) {
      spot.origin = namespace_ec06fe4a::function_65ee50ba(spot.origin);
    }

    foreach(spot in var_63f7cb8f[# "right"]) {
      spot.origin = namespace_ec06fe4a::function_65ee50ba(spot.origin);
    }

    foreach(spot in var_74297693) {
      spot.var_4983b208 = 15;

      if(isDefined(spot.script_int)) {
        spot.var_4983b208 = int(spot.script_int);
      }

      assert(spot.var_4983b208 >= 1 && spot.var_4983b208 <= 15);
      toks = strtok(spot.script_string, ";");
      assert(toks.size >= 3);
      spot.modelname = toks[0];
      spot.scale = float(toks[1]);
      spot.var_bfbc537c = int(toks[2]);

      if(toks.size >= 4) {
        spot.maxround = int(toks[3]);
      }
    }

    var_73c16a24 = [];
    var_73c16a24[# "bottom"] = struct::get_array(m_name + "_exit_start_bottom", "targetname");
    var_73c16a24[# "left"] = struct::get_array(m_name + "_exit_start_left", "targetname");
    var_73c16a24[# "top"] = struct::get_array(m_name + "_exit_start_top", "targetname");
    var_73c16a24[# "right"] = struct::get_array(m_name + "_exit_start_right", "targetname");
    var_36f9408 = [];
    var_36f9408[# "bottom"] = getent(m_name + "_blocker_bottom", "targetname");
    var_36f9408[# "left"] = getent(m_name + "_blocker_left", "targetname");
    var_36f9408[# "top"] = getent(m_name + "_blocker_top", "targetname");
    var_36f9408[# "right"] = getent(m_name + "_blocker_right", "targetname");
    var_36f9408[# "bottom"].var_e603ff2c = var_36f9408[# "bottom"].origin;
    var_36f9408[# "left"].var_e603ff2c = var_36f9408[# "left"].origin;
    var_36f9408[# "top"].var_e603ff2c = var_36f9408[# "top"].origin;
    var_36f9408[# "right"].var_e603ff2c = var_36f9408[# "right"].origin;
    var_36f9408[# "bottom"].side = "bottom";
    var_36f9408[# "left"].side = "left";
    var_36f9408[# "top"].side = "top";
    var_36f9408[# "right"].side = "right";
    var_5d3a1[# "top"] = [];
    var_5d3a1[# "bottom"] = [];
    var_5d3a1[# "left"] = [];
    var_5d3a1[# "right"] = [];
    var_694b395b = getent(m_name + "_safezone", "targetname");
    var_d7b6f39c = getEntArray(m_name + "_unsafezone", "targetname");
    var_cb3e8eba = getEntArray(m_name + "_doa_exit", "targetname");
    var_7c7691d6 = 0;
    deactivate();
  }

  function function_464d882c() {
    foreach(hazard in var_a1fa7529) {
      hazard notify(#"destroy_hazard");
    }
  }

  function function_4774f263(type, trigger, var_6a1dbbf3 = 0, var_fe263624 = 0) {
    self notify("4a076f664a823540");
    self endon("4a076f664a823540");
    self endon(#"disconnect");
    var_6a1dbbf3 = int(var_6a1dbbf3);
    var_425999f6 = int(var_fe263624);
    maxamount = 32 - 1;
    var_753de10b = trigger.maxs[var_6a1dbbf3];
    var_974c88c7 = maxs[var_fe263624];

    while(isDefined(trigger) && self istouching(trigger) && trigger istriggerenabled()) {
      localpoint = origin - trigger.origin;
      var_9fa53333 = rotatepoint(localpoint, trigger.angles * -1);
      var_605440f7 = var_9fa53333 + trigger.origin;
      dist2 = abs(trigger.origin[var_fe263624] - var_605440f7[var_fe263624]) - var_974c88c7;
      var_85322688 = 1 - dist2 / var_753de10b;
      var_7ead8893 = int(mapfloat(0, 1, 0, maxamount, var_85322688));
      self clientfield::set_to_player(type, var_7ead8893);
      util::wait_network_frame();
    }

    self clientfield::set_to_player(type, 0);
    tweakcam = undefined;
  }

  function setpaused(val) {
    var_7c7691d6 = val;
  }

  function function_51dd0a59() {
    if(!isDefined(var_c0023851)) {
      return;
    }

    return var_c0023851;
  }

  function function_55916d40() {
    return var_35760f46;
  }

  function function_59fc184c() {
    return var_79baa471[randomint(var_79baa471.size)];
  }

  function function_62d5e1be() {
    return var_60821378;
  }

  function function_635991ca() {
    if(var_73ab8b47.size) {
      return var_73ab8b47[randomint(var_73ab8b47.size)];
    }

    sides = array("top", "bottom", "left", "right");
    return function_21d1be3d(sides[randomint(sides.size)]);
  }

  function getid() {
    return var_be31d6d6;
  }

  function function_68400720(val) {
    var_2e06f9d4 = val;
  }

  function function_6d5262dc(val) {
    if(val > 40) {
      val = 40;
    }

    var_24df6bfb = val;
  }

  function function_70fb5745(nearby, min = 256, max = 512, getclosest = 0) {
    if(!isDefined(nearby)) {
      return var_b60ab5fd[randomint(var_b60ab5fd.size)];
    }

    spots = arraysortclosest(var_b60ab5fd, nearby, undefined, min, max);

    if(getclosest) {
      return spots[0];
    }

    if(spots.size > 0) {
      return spots[randomint(spots.size)];
    }

    return m_center;
  }

  function function_73ec120c(side) {
    var_36f9408[side].origin = var_36f9408[side].var_e603ff2c + (0, 0, -50000);
    namespace_1e25ad94::debugmsg("Moving blocker: " + side + " to origin " + var_36f9408[side].origin);
  }

  function function_774497ee(var_49983302) {
    var_622da539 = var_49983302;
  }

  function function_7856fdb6() {
    return m_namehash;
  }

  function function_786b9d39() {
    return var_5e72455f;
  }

  function function_7ce9bb97(deactivate) {
    objective_setstate(10, "invisible");

    foreach(exit in var_b198ac5a) {
      exit triggerenable(0);
      exit.enabled = 0;
      namespace_1e25ad94::debugmsg("Disabling trigger: " + exit.script_noteworthy);

      if(isDefined(exit.fakemodel)) {
        exit.fakemodel namespace_83eb6304::turnofffx("exit_fog_marker");
      }
    }

    level notify(#"hash_69b4bed202ddfa69");
    var_81e9b5ca = [];
  }

  function function_8054e011() {
    return var_b60ab5fd;
  }

  function function_82fd5391() {
    self waittill(#"deactivate");
    self triggerenable(0);
  }

  function function_8a7cec70() {
    return var_9cd25248;
  }

  function function_8bca81f0() {
    self notify("3a1d3e220bd0ab10");
    self endon("3a1d3e220bd0ab10");
    level endon(#"hash_69b4bed202ddfa69");
    wait 1;

    while(true) {
      result = self waittilltimeout(10, #"trigger");

      if(result._notify == # "timeout") {
        continue;
      }

      if(isbot(result.activator) || is_true(result.activator.var_c497caa3)) {
        continue;
      }

      break;
    }

    namespace_1e25ad94::debugmsg("Exit Taken Trigger: " + script_noteworthy);

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      player notify(#"hash_279998c5df86c04d");
      player thread namespace_7f5aeb59::turnplayershieldon();
    }

    result.activator notify(#"doa_exit_taken");
    level notify(#"doa_exit_taken", {
      #activator: result.activator, #direction: script_noteworthy
    });
  }

  function function_90de0b96() {
    level thread namespace_268747c0::function_3874b272("explo_barrel");
    level thread namespace_268747c0::function_3874b272("killbox");
    level thread namespace_268747c0::function_3874b272("killzone");
    level thread namespace_268747c0::function_3874b272("pungi");
    level thread namespace_268747c0::function_3874b272("flogger");
    level thread namespace_268747c0::function_3874b272("logdrop");
    level thread namespace_268747c0::function_3874b272("physicsbox");
    level thread namespace_268747c0::function_3874b272("fireball");
    level thread namespace_268747c0::function_3874b272("dragonhead");
    level thread namespace_268747c0::function_3874b272("platform");
  }

  function function_9485c2a9() {
    return var_2e06f9d4;
  }

  function function_94e37da2(player) {
    foreach(zone in var_d7b6f39c) {
      if(player istouching(zone)) {
        return 0;
      }
    }

    return player istouching(var_694b395b);
  }

  function function_9f494a87() {
    foreach(blocker in var_36f9408) {
      blocker.origin = blocker.var_e603ff2c;
      namespace_1e25ad94::debugmsg("Moving blocker: " + blocker.side + " to origin " + blocker.origin);
    }
  }

  function function_a95693e1() {
    level thread namespace_268747c0::function_3874b272("elec_pole", function_8a7cec70());
  }

  function function_aad69885(side) {
    return var_b198ac5a[side];
  }

  function deactivate() {
    level notify(#"arena_deactivated");
    function_464d882c();
    function_7ce9bb97(1);
    function_9f494a87();
    function_e87bab7b();
    objective_setstate(10, "invisible");

    foreach(exit in var_b198ac5a) {
      if(isDefined(exit.fakemodel)) {
        exit.fakemodel delete();
      }
    }

    foreach(var_f0ce243e in var_e2a6dd61) {
      if(isDefined(var_f0ce243e)) {
        var_f0ce243e notify(#"deactivate");
      }
    }

    var_5d3a1[# "top"] = [];
    var_5d3a1[# "bottom"] = [];
    var_5d3a1[# "left"] = [];
    var_5d3a1[# "right"] = [];
    var_ac834eea = function_14b480d1();

    if(isDefined(var_ac834eea)) {
      level thread[[var_ac834eea]]();
    }
  }

  function function_b2f9e813() {
    var_35760f46 = gettime();
  }

  function function_b6954aba(var_e74c8f7) {
    var_486c1553 = var_e74c8f7;
  }

  function function_c0402c8a() {
    return var_5479b5f3;
  }

  function activate() {
    level clientfield::set_world_uimodel("DOA_GLOBALUIMODEL_ARENANUMBER", getid());
    objective_setstate(10, "invisible");

    foreach(exit in var_b198ac5a) {
      origin = exit namespace_ec06fe4a::function_65ee50ba(exit.origin, 12);

      if(!isDefined(exit.fakemodel)) {
        exit.fakemodel = namespace_ec06fe4a::spawnmodel(origin + (0, 0, 16), "tag_origin");
        exit.fakemodel.targetname = m_name + "_exit_" + exit.script_noteworthy;
      }
    }

    foreach(var_f0ce243e in var_e2a6dd61) {
      var_f0ce243e thread function_e7bbc8d1();
    }

    function_90de0b96();
    function_7ce9bb97();
    function_9f494a87();

    while(!loadnavvolume(m_name)) {
      waitframe(1);
    }

    var_5d3a1[# "top"] = [];
    var_5d3a1[# "bottom"] = [];
    var_5d3a1[# "left"] = [];
    var_5d3a1[# "right"] = [];
    var_2f0b512f = [[level.doa.var_39e3fa99]] - > function_3bf5b85d();

    if(isDefined(var_2f0b512f)) {
      level thread[[var_2f0b512f]]();
    }
  }

  function function_c8300b0e(side) {
    exit = function_aad69885(side);
    function_73ec120c(exit.script_noteworthy);
    exit triggerenable(1);
    exit.enabled = 1;
    namespace_1e25ad94::debugmsg("Enabling trigger: " + exit.script_noteworthy);
    exit thread function_8bca81f0();
    exit.fakemodel namespace_83eb6304::function_3ecfde67("exit_fog_marker");
    exit.fakemodel namespace_83eb6304::turnofffx("arena_barrier");
    objective_setstate(10, "active");
    objective_onentity(10, exit.fakemodel);
    objective_setprogress(10, 1);
    var_81e9b5ca[var_81e9b5ca.size] = exit;
  }

  function function_c892290a() {
    return is_true(level.doa.hardcoremode) ? 40 : var_24df6bfb;
  }

  function function_c9f6682b() {
    if(namespace_ec06fe4a::function_a8975c67()) {
      playsoundatposition(#"hash_2021d3391e72675c", (0, 0, 0));
    }

    profilestart();
    var_81e9b5ca = [];
    num = 1;
    var_41629194 = [];

    while(num) {
      side = namespace_8c04284b::function_7802d126();

      if(!isinarray(var_41629194, side)) {
        var_41629194[var_41629194.size] = side;
        num--;
      }
    }

    foreach(side in var_41629194) {
      function_c8300b0e(side);
    }

    profilestop();
  }

  function setwild(set) {
    var_c0023851 = set;
  }

  function function_cc773c53() {
    return var_bedb7d90;
  }

  function function_dfb49846() {
    return var_81e9b5ca;
  }

  function function_e0de916a(var_cc6976cf, var_fd3fce8b) {
    var_bedb7d90 = var_cc6976cf;
    var_5e72455f = var_fd3fce8b;
  }

  function function_e7bbc8d1() {
    self endon(#"deactivate");
    self triggerenable(1);
    self thread function_82fd5391();
    type = isDefined(script_noteworthy) ? script_noteworthy : "setCameraDown";

    if(isDefined(script_int)) {
      self thread function_20b2a1e4(int(script_int));
    }

    var_6a1dbbf3 = 0;
    var_fe263624 = 0;

    if(isDefined(script_parameters)) {
      toks = strtok(script_parameters, ";");
      assert(toks.size >= 2);
      var_6a1dbbf3 = int(toks[0]);
      var_fe263624 = int(toks[1]);
    }

    angles = angleclamp180(angles);

    while(true) {
      result = self waittill(#"trigger");

      if(isPlayer(result.activator) && !isDefined(result.activator.tweakcam)) {
        result.activator.tweakcam = self;
        result.activator thread function_4774f263(type, self, var_6a1dbbf3, var_fe263624);
      }
    }
  }

  function function_e87bab7b(var_4983b208 = 0) {
    foreach(spot in var_74297693) {
      if(!isDefined(spot.mdl)) {
        continue;
      }

      if(spot.var_4983b208 &var_4983b208) {
        continue;
      }

      if(is_true(spot.var_bfbc537c)) {
        spot.mdl connectpaths();
      }

      spot.mdl delete();
      spot.mdl = undefined;
    }
  }

  function function_eca91fd8(origin) {
    return arraysort(var_b60ab5fd, origin)[var_b60ab5fd.size - 1];
  }

  function function_ee30f092(side) {
    if(function_20b4ef55(side) > 0) {
      wave = var_5d3a1[side][0];
      arrayremoveindex(var_5d3a1[side], 0);
      return wave;
    }

    return undefined;
  }

  function function_f231126a() {
    return function_20b4ef55("top") + function_20b4ef55("bottom") + function_20b4ef55("left") + function_20b4ef55("right");
  }

  function function_fc81ec00(idx) {
    assert(idx < var_80292cd.size, "<dev string:x56>" + m_name);
    return var_80292cd[idx];
  }

  function function_fdea25f1() {
    return var_5479b5f3[randomint(var_5479b5f3.size)];
  }
}

function function_b97739d8(idx = 0) {
  assert(idx >= 0 && idx < 4);

  if(idx < 0 || idx > 3) {
    return;
  }

  if(isDefined(level.doa.var_39e3fa99)) {
    return [[level.doa.var_39e3fa99]] - > function_fc81ec00(idx);
  }

  return level.doa.var_9c14d513[idx];
}

function init() {
  clientfield::register("world", "setArena", 1, 5, "int");
  clientfield::register("world", "setTOD", 1, 3, "int");
  level flag::init("arena_zero_rounds", 0);
  level flag::init("arena_hold_presentation", 0);
  level flag::init("arena_hold_banner_presentation", 0);
  level flag::init("arena_pauseAdvancement", 0);
  level.doa.arenas = [];
  level.doa.var_7f0b4a69 = 0;
  level.doa.var_8f91d36b = 0;
  level.doa.var_654a3ea9 = 0;
  level.doa.var_23ce73 = 0;
  level.doa.var_39459d49 = 0;
  level.doa.var_4e554b79 = &function_b97739d8;
  level.doa.var_9c14d513 = struct::get_array("island_player_spawnpoint", "targetname");
  arenas = struct::get_array("arena_center", "targetname");
  var_7f6c6c04 = [];

  foreach(arena in arenas) {
    assert(isDefined(arena.script_parameters), "<dev string:xe7>");
    args = strtok(arena.script_parameters, ";");
    order = int(args[0]);
    assert(!isDefined(var_7f6c6c04[order]), "<dev string:x147>" + arena.script_noteworthy);
    var_7f6c6c04[order] = arena;
  }

  id = 0;

  for(index = 0; index < 100; index++) {
    if(isDefined(var_7f6c6c04[index])) {
      function_afa7d50a(var_7f6c6c04[index], id);
      id++;
    }
  }

  objective_add(10, "invisible", (0, 0, 0), #"exit_objective");
  level clientfield::set("setArena", 32 - 1);
}

function main() {
  level.doa.var_e5ef2ab4 = 0;
  level.doa.var_8f91d36b = 0;
  level.doa.var_654a3ea9 = 0;
  level.doa.var_23ce73 = 0;
  level.doa.var_a598a835 = undefined;
  level.doa.var_a77e4601 = [];
  level.doa.var_39459d49 = 0;
  level.doa.var_11623c49 = randomintrange(200, 600);
  level flag::clear("arena_zero_rounds");
  level flag::clear("arena_hold_presentation");
  level flag::clear("arena_hold_banner_presentation");
  function_a70ff03e(0, 1);

  if(level.doa.arenas.size == 0) {
    return;
  }

  foreach(arena in level.doa.arenas) {
    [[arena]] - > deactivate();
  }

  level.doa.var_39e3fa99 = undefined;
  level endon(#"game_over");
  level waittill(#"hash_671684f03a58b3a3");
  level doa_banner::function_7a0e5387();
  waitframe(1);

  if(is_true(level.var_65efe052)) {
    util::wait_network_frame();
    level doa_banner::function_7a0e5387(51);
  }

  level.doa.var_23fd3659 = 0;
  level clientfield::set("setArena", level.doa.var_23fd3659);

  while(true) {
    level thread function_6d6bfe1f(level.doa.var_23fd3659);
    result = level waittill(#"waiting_on_player_exit_teleporteronly", #"waiting_on_player_exit_decidechoice");

    if(result._notify == "waiting_on_player_exit_teleporterOnly") {
      nextarena = level.doa.var_23fd3659 + 1;

      if(nextarena >= level.doa.arenas.size) {
        nextarena = 0;
      }

      arena = level.doa.arenas[nextarena];
      level thread namespace_ec06fe4a::function_87612422([[arena]] - > function_ffcf1d1(), undefined, 0.5, 999999);
    }

    result = level waittill(#"teleporter_taken", #"enter_the_wild");

    if(result._notify == # "enter_the_wild") {
      level thread doa_wild::function_7c5bc025(result.param, result.data);
      level waittill(#"hash_325440d5433be263");
      namespace_d2efac9a::function_47498d07(0, 0, 1);
    }

    level doa_banner::function_7a0e5387();

    while(flag::get("arena_pauseAdvancement")) {
      waitframe(1);
    }

    level.doa.var_23fd3659++;

    if(getdvarint(#"hash_d874e4e73e9f18") == 4) {
      level.doa.var_23fd3659--;
    }

    if(level.doa.var_23fd3659 >= level.doa.arenas.size) {
      level.doa.var_23fd3659 = 0;
      level.doa.var_6c58d51++;
      level.doa.var_e5ef2ab4 = 0;
      level.doa.var_3e7292fc = math::clamp(100 - level.doa.var_6c58d51 * 25, 20, 100);

      foreach(var_94f3b914 in level.doa.var_329c97a3) {
        chance = [[var_94f3b914]] - > function_17454656();
        chance = math::clamp(chance + level.doa.var_6c58d51 * 2, 6, 100);
        [[var_94f3b914]] - > function_7edd7727(chance);
      }
    }

    level clientfield::set_world_uimodel("DOA_GLOBALUIMODEL_ARENANUMBER", level.doa.var_23fd3659);
    level.doa.var_a3e53b88 = 1;
    wait 5;

    if(level.doa.var_a5ade8f8 === 0 && level.doa.var_6c58d51 > 0) {
      level.doa.var_a5ade8f8 = math::clamp(level.doa.var_6c58d51 * 8, 0, 40);
    }

    players = getplayers();

    foreach(player in players) {
      player clientfield::increment_to_player("resetCamera");
    }
  }
}

function function_afa7d50a(arena_struct, index) {
  arena = new class_f4bf8a8();
  [[arena]] - > initialize(arena_struct, index);
  level.doa.arenas[[[arena]] - > getid()] = arena;
  var_663588d = "Zombietron/Arenas/";
  cmdline = "scr_arena_activate " + [[arena]] - > getname() + "; zombie_devgui arena";
  util::add_devgui(var_663588d + [[arena]] - > getname() + ":" + [[arena]] - > getid(), cmdline);
}

function function_a7c5291d(name) {
  foreach(arena in level.doa.arenas) {
    if([[arena]] - > getname() == name) {
      return [[arena]] - > getid();
    }
  }

  return -1;
}

function function_85c7d70e(name) {
  foreach(arena in level.doa.arenas) {
    if([[arena]] - > getname() == name) {
      return arena;
    }
  }
}

function function_1ced05a1(id) {
  foreach(arena in level.doa.arenas) {
    if([[arena]] - > getid() == id) {
      return [[arena]] - > getname();
    }
  }
}

function function_27960a04(arenaid) {
  assert(isDefined(level.doa.arenas[arenaid]), "<dev string:x190>" + arenaid);
  level notify(#"arena_switching");
  level clientfield::set("setArena", arenaid);
  level clientfield::set("setTOD", 0);
  level util::set_lighting_state(0, 0);
  level.doa.var_a598a835 = undefined;
  util::wait_network_frame();
  level.doa.var_39e3fa99 = level.doa.arenas[arenaid];
  [[level.doa.var_39e3fa99]] - > activate();
  [[level.doa.var_39e3fa99]] - > setpaused(1);
  [[level.doa.var_39e3fa99]] - > function_68400720(1);
  level thread namespace_ec06fe4a::function_87612422([[level.doa.var_39e3fa99]] - > function_ffcf1d1());
  function_8405d534();
  function_a70ff03e(0, 1);
  level util::streamer_wait(undefined, 0, 2);
  namespace_9fc66ac::function_5beeba99();
  namespace_1e25ad94::debugmsg("Arena " + arenaid + " activated (" + [[level.doa.var_39e3fa99]] - > getname() + ")");
  level notify(#"arena_initialized");
}

function function_a70ff03e(flip = 0, reset = 0) {
  players = getplayers();

  if(reset) {
    level.doa.var_ecff3871 = 0;

    foreach(player in players) {
      if(isDefined(player)) {
        player doa_player::function_a48eea2b(level.doa.var_ecff3871, 1);
      }
    }
  } else {
    level.doa.var_ecff3871 = flip;

    foreach(player in players) {
      if(isDefined(player)) {
        player doa_player::function_a48eea2b(level.doa.var_ecff3871);
      }
    }
  }

  level notify(#"hash_180d4d3b6b7ea3f3", {
    #var_5078f168: level.doa.var_ecff3871
  });
}

function function_8405d534(side) {
  players = namespace_7f5aeb59::function_23e1f90f();
  idx = 0;

  foreach(player in players) {
    player.doa.var_3cf36932 = 1;

    if(isDefined(side)) {
      spot = [[level.doa.var_39e3fa99]] - > function_23476287(idx, side);
      assert(isDefined(spot), "<dev string:x1b1>");
    } else {
      spot = [[level.doa.var_39e3fa99]] - > function_fc81ec00(idx);
      assert(isDefined(spot), "<dev string:x1da>");
    }

    player notify(#"hash_279998c5df86c04d");
    player setorigin(spot.origin);
    player setplayerangles(spot.angles);

    if(is_true(level.doa.var_67d8328d) && isDefined(player.doa.var_46b45756)) {
      level thread[[player.doa.var_46b45756]](spot.origin + (0, 0, 100), player);
    }

    player.doa.var_46b45756 = undefined;
    player notify(#"hash_7893364bd228d63e", {
      #var_cff8d1e: 1
    });
    player namespace_83eb6304::turnofffx("firstPersonMarker");
    player clientfield::increment_to_player("controlBinding");
    player clientfield::increment_to_player("setCompassVis");
    player namespace_7f5aeb59::function_61d74d57();
    player.doa.var_9f897c4d = gettime();
    idx++;
  }

  level.doa.var_67d8328d = undefined;
  level.doa.var_dcbded2 = [];
  level namespace_7f5aeb59::function_d0251f76();
  level thread function_37dc18ca();
}

function function_37dc18ca() {
  self notify("5037d1e6b45447b3");
  self endon("5037d1e6b45447b3");
  level endon(#"game_over");
  util::wait_network_frame();

  while(true) {
    if(isDefined(level.doa.var_39e3fa99)) {
      players = namespace_7f5aeb59::function_23e1f90f();

      foreach(player in players) {
        if(player isinmovemode("ufo", "noclip")) {
          continue;
        }

        if(isDefined(level.doa.var_6f3d327)) {
          continue;
        }

        if(!is_true(player.doa.var_3cf36932)) {
          continue;
        }

        if(isDefined(level.doa.var_a77e6349)) {
          continue;
        }

        if(![[level.doa.var_39e3fa99]] - > function_94e37da2(player)) {
          player notify(#"hash_279998c5df86c04d");
          spot = [[level.doa.var_39e3fa99]] - > function_70fb5745(player.origin, 0, 1024, 1);

          if(!isDefined(spot)) {
            spot = [[level.doa.var_39e3fa99]] - > function_70fb5745();
          }

          if(isDefined(spot)) {
            namespace_1e25ad94::debugmsg("Safe Zone Monitor teleporting player (" + player.doa.color + ") at: " + player.origin + " to a safe spot in (" + [[level.doa.var_39e3fa99]] - > getname() + ") at :" + spot.origin, 1);
            player setorigin(spot.origin);
          }
        }
      }
    }

    wait 0.5;
  }
}

function function_9f0eb43e() {
  if(is_true(level.doa.var_8f710e5d) || level.doa.roundnumber > 4 && randomint(100) < 15 || level.doa.roundnumber - level.doa.var_7f0b4a69 > 7) {
    level thread namespace_58e19d6::function_571bb3ac();
    level.doa.var_7f0b4a69 = level.doa.roundnumber;
    level thread namespace_9fc66ac::announce(70);
  }
}

function function_aad0c9db() {
  level thread function_e1916608();
  level thread function_16902251();
  level thread function_17e79564();
  level thread function_1b42a0bb();
  level thread doa_enemy::function_7495bd30();
}

function function_962e9d92(roundnumber) {
  if(roundnumber >= 30 && level.doa.var_6c58d51 == 0) {
    return int(1000 + 29 * 100 + (roundnumber - 29) * 50 + level.doa.var_997a0313 * (250 + getplayers().size * 250));
  }

  return 1000 + (roundnumber - 1) * 100 + level.doa.var_997a0313 * (250 + getplayers().size * 250);
}

function function_f15b9f04(roundnumber) {
  return 24 + (roundnumber - 1) * 2;
}

function function_6d6bfe1f(arenaid, rounds = 4) {
  self notify("39087439f10bf314");
  self endon("39087439f10bf314");
  level endon(#"game_over", #"arena_completed");
  level flag::clear("arena_zero_rounds");
  namespace_4dae815d::function_e22d3978(level.doa.roundnumber + 1);
  assert(arenaid != -1, "<dev string:x1ff>");
  namespace_4dae815d::function_21cd3890(0);
  function_a70ff03e(0, 1);
  currentlightstate = 0;
  namespace_ec06fe4a::function_de70888a();
  level.doa.var_a3e53b88 = undefined;
  function_27960a04(arenaid);

  if(is_true(level.var_65efe052)) {
    wait 5;
  }

  level doa_banner::function_7a0e5387();
  level.var_65efe052 = undefined;
  level function_aad0c9db();
  var_d0cb8cd4 = gettime();
  var_4a140058 = function_1ced05a1(arenaid);
  level.doa.var_4cfbc260 = rounds;
  var_406866b1 = 0;
  [[level.doa.var_39e3fa99]] - > function_1e4d7a0c(1);

  while(level.doa.var_4cfbc260 > 0) {
    level.doa.var_39459d49 += getplayers().size;

    if(getdvarint(#"hash_23f1ebb21fe023b", 3) != 3) {
      level.doa.var_6a0340ad = getdvarint(#"hash_23f1ebb21fe023b", 3);
    } else {
      level.doa.var_6a0340ad = [[level.doa.var_39e3fa99]] - > function_62d5e1be();
    }

    level.doa.roundstarttime = gettime();
    level.doa.var_9fcf26ea = 0;
    level.doa.var_de939ab7 = 0;
    level.doa.var_cde5274e = 0;
    level.doa.var_2b4e2465 = 0;
    level.doa.var_5de71250 = 0;
    level.doa.var_f66b524a = 0;
    level.doa.var_aa7fba18 = 0;
    level.doa.challengeactive = 0;
    level.doa.var_465867b = 0;
    namespace_1e25ad94::debugmsg("Arena (" + var_4a140058 + ") round starting at: " + level.doa.roundstarttime + " RoundNumber: " + level.doa.roundnumber + " Rounds Left on this Arena: " + level.doa.var_4cfbc260);
    [[level.doa.var_39e3fa99]] - > function_9f494a87();
    [[level.doa.var_39e3fa99]] - > function_7ce9bb97();
    [[level.doa.var_39e3fa99]] - > function_a95693e1();
    wait 1.5;
    util::function_21678f2c(getplayers(), 10000);
    level notify(#"round_about_to_start");
    level namespace_7f5aeb59::function_836aeb74();
    function_1eaaceab(level.doa.var_5598fe58);
    assert(level.doa.var_5598fe58.size == 0, "<dev string:x221>");

    foreach(player in getplayers()) {
      if(isDefined(player.doa)) {
        player.doa.var_c739e4eb = 0;
      }
    }

    if(namespace_77eccc4f::function_379191c(var_4a140058)) {
      result = level waittill(#"challenge_ready");
      level.doa.challengeactive = 1;
    }

    switch (level.doa.var_6a0340ad) {
      case 1:
        level function_3d25cb06();
        level thread function_81282ad3();
        break;
      case 2:
        level function_3d25cb06();
        level thread function_9e0d71e5();
        break;
      case 3:
        level thread function_7655afe();
        break;
      default:
        assert(0, "<dev string:x24d>");
        break;
    }

    [[level.doa.var_39e3fa99]] - > setpaused(0);
    level notify(#"round_begin");
    level namespace_7f5aeb59::function_ec758d18();
    level flag::wait_till_clear("doa_round_spawning");
    [[level.doa.var_39e3fa99]] - > setpaused(1);
    namespace_ec06fe4a::function_b6b79fd1(-1);

    while(level flag::get("doa_round_paused") || is_true(level.hostmigrationtimer)) {
      waitframe(1);
    }

    level flag::set("doa_round_over");
    level.doa.var_c59f32d7 = gettime();
    level.doa.var_f66b524a = level.doa.var_c59f32d7 - level.doa.roundstarttime;

    if(is_true(level.doa.challengeactive)) {
      namespace_7f5aeb59::function_f8645db3(getdvarint(#"hash_7256472be03ba328", 1000));
    }

    if(!is_true(level.doa.var_3ec3c9aa)) {
      eventparams = {
        #roundnumber: level.doa.roundnumber, #roundduration: int(float(level.doa.var_f66b524a) / 1000)
      };
      function_92d1707f(#"hash_70c149ea78c8a7ac", eventparams);
    } else {
      namespace_1e25ad94::debugmsg("Arena (" + var_4a140058 + ") round [" + level.doa.roundnumber + "] skipping DLOG event due to interference");
    }

    level.doa.var_3ec3c9aa = undefined;
    namespace_1e25ad94::debugmsg("Arena (" + var_4a140058 + ") round [" + level.doa.roundnumber + "] finished at: " + gettime() + " Total Time:" + float(level.doa.var_f66b524a) / 1000 + " seconds");

    if(is_true(level.doa.var_7ada373e)) {
      namespace_1e25ad94::function_4e3cfad("\tArena (" + var_4a140058 + ") round [" + level.doa.roundnumber + "] finished at: " + gettime() + " Total Time:" + float(level.doa.var_f66b524a) / 1000 + " seconds" + " AI Spawned:" + level.doa.var_9fcf26ea, undefined, undefined, undefined, 10);
    }

    level notify(#"round_over");
    waitframe(1);

    if(level flag::get("arena_zero_rounds")) {
      level.doa.var_4cfbc260 = 0;
    }

    if(level.doa.var_4cfbc260 > 1) {
      spot = [[level.doa.var_39e3fa99]] - > function_fdea25f1();
      roll = randomint(100);
      radius = spot.radius;

      if(!isDefined(radius)) {
        radius = 32;
      }

      if(roll == 0) {
        namespace_dfc652ee::function_68442ee7(spot.origin, 1, radius, 1);
      }

      namespace_dfc652ee::function_68442ee7(spot.origin, randomintrange(4, 10), radius, 0);

      if(namespace_ec06fe4a::function_a8975c67()) {
        playsoundatposition(#"hash_2021d3391e72675c", (0, 0, 0));
      }

      if([[level.doa.var_39e3fa99]] - > function_806bba()) {
        [[level.doa.var_39e3fa99]] - > function_c9f6682b();
        function_9f0eb43e();
      }

      level thread function_6932cdb4();
      namespace_1e25ad94::debugmsg("Arena (" + var_4a140058 + ") waiting for doa_exit_taken");
      level doa_banner::function_7a0e5387(10);
      result = level waittill(#"doa_exit_taken");

      if(namespace_ec06fe4a::function_a8975c67()) {
        playsoundatposition(#"evt_doa_travel_doors_chosen", (0, 0, 0));
      }

      namespace_1e25ad94::debugmsg("Arena (" + var_4a140058 + ") waiting for doa_exit_taken recieved");
      [[level.doa.var_39e3fa99]] - > function_7ce9bb97();
      var_1075516b = result.direction;
      namespace_ec06fe4a::function_de70888a();
      level thread namespace_7f5aeb59::function_67f054d7();
      level waittill(#"hash_1b322de3d2e3e781");
      level doa_banner::function_7a0e5387();
      level notify(#"hash_2282d796a1f7533a");
      namespace_ec06fe4a::function_de70888a();
      waitframe(1);

      if(namespace_5a917022::function_7230f033()) {
        level waittill(#"hash_7dd47c99b7707b1c");
      }

      function_a70ff03e(!level.doa.var_ecff3871);
      currentlightstate++;

      if(currentlightstate > 3) {
        currentlightstate = 0;
      }

      level util::set_lighting_state(currentlightstate, 0);
      level clientfield::set("setTOD", currentlightstate);
      namespace_dfc652ee::function_19fa261e();
      namespace_ec06fe4a::clearallcorpses();

      if(isDefined(var_1075516b)) {
        var_406866b1++;
        [[level.doa.var_39e3fa99]] - > function_1e4d7a0c(1 << var_406866b1);
        function_8405d534(var_1075516b);
      }
    }

    level.doa.var_4cfbc260--;
    level.doa.var_9a86a331 = [];
    level.doa.var_f4cf4e3 += 2;
    level.doa.zombie_health += 100;

    if(level.doa.var_4cfbc260 > 0) {
      namespace_4dae815d::function_e22d3978(level.doa.roundnumber + 1);
    }

    namespace_250e9486::function_d1bc3f11(level.doa.roundnumber);
  }

  clusters = 2;

  while(clusters > 0) {
    clusters--;
    spot = [[level.doa.var_39e3fa99]] - > function_fdea25f1();
    radius = spot.radius;

    if(!isDefined(radius)) {
      radius = 32;
    }

    roll = randomint(100);

    if(roll == 0) {
      namespace_dfc652ee::function_68442ee7(spot.origin, 1, radius, 1);
    }

    namespace_dfc652ee::function_68442ee7(spot.origin, randomintrange(4, 10), radius, 0);
  }

  level thread function_3f18205d();
  level thread function_6932cdb4();
  timesec = float(gettime() - var_d0cb8cd4) / 1000;
  level.doa.var_b456a02b += timesec;
  namespace_1e25ad94::debugmsg("Arena (" + var_4a140058 + ") time spent: " + timesec + " seconds.");
  namespace_ec06fe4a::function_de70888a();
  level notify(#"arena_completed");
}

function private function_6932cdb4() {
  wait 1;
  var_370ac26d = getdvarint(#"hash_b6131d2b653429b", 425) + level.doa.roundnumber * getdvarint(#"hash_58e9d99a358668d8", 75);
  maxxp = getdvarint(#"hash_2f1edc610eb9f340", 3500) + level.doa.var_6c58d51 * getdvarint(#"hash_7240e9b38c2b7e29", 2500);

  if(var_370ac26d > maxxp) {
    var_370ac26d = maxxp;
  }

  namespace_7f5aeb59::function_f8645db3(var_370ac26d);
  namespace_d2efac9a::function_47498d07(undefined, 1);
}

function function_3f18205d() {
  self notify("3435e896293dcba3");
  self endon("3435e896293dcba3");
  level endon(#"game_over", #"hash_4a13bd350867b4ae");
  level notify(#"hash_de33bd076cde122");

  foreach(player in getplayers()) {
    player notify(#"hash_279998c5df86c04d");
  }

  waitframe(1);

  while(level flag::get("arena_hold_presentation")) {
    waitframe(1);
  }

  assert(isDefined(level.doa.var_39e3fa99), "<dev string:x27d>");
  var_dd3eca11 = [[level.doa.var_39e3fa99]] - > function_9485c2a9();
  var_c6906ae1 = undefined;

  if(level.doa.var_6c58d51 == 0) {
    var_c6906ae1 = [[level.doa.var_39e3fa99]] - > function_51dd0a59();

    if(is_true(level.doa.hardcoremode) && isDefined(var_c6906ae1)) {
      if(var_c6906ae1.targetname !== # "hash_10d262cdf5d256d8") {
        var_c6906ae1 = undefined;
      }
    }
  }

  if(isDefined(var_c6906ae1)) {
    var_9f6855ea = isDefined(level.doa.var_e15152e6) ? level.doa.var_e15152e6 : var_c6906ae1.script_noteworthy;
    var_c4f905c2 = isDefined(var_c6906ae1.script_int) ? int(var_c6906ae1.script_int) : isDefined(level.doa.var_baeb966b) ? level.doa.var_baeb966b : 0;
    wild = doa_wild::function_e5e987ae(var_9f6855ea);
    var_82dd2bd0 = isDefined(var_c6906ae1) ? var_c6906ae1.origin : [[level.doa.var_39e3fa99]] - > function_70fb5745([[level.doa.var_39e3fa99]] - > function_ffcf1d1()).origin;

    if(isDefined(wild)) {
      hintpos = [[wild]] - > function_70111aa4(var_c4f905c2);
      level thread namespace_ec06fe4a::function_87612422(hintpos.origin, hintpos.angles, 0.1, 999999, [[wild]] - > function_c8fbcc3f(var_c4f905c2));
    }
  } else {
    var_dd3eca11 = 1;
  }

  if(is_true(level.var_e5d89122) || is_true(level.doa.var_1f2c7d5f)) {
    var_dd3eca11 = 1;
    wild = undefined;
  }

  id = [[level.doa.var_39e3fa99]] - > getid();

  if(var_dd3eca11) {
    namespace_1e25ad94::debugmsg("Arena " + id + " spawning teleporter");
    origin = [[level.doa.var_39e3fa99]] - > function_ffcf1d1();
    var_45041f7 = namespace_ec06fe4a::spawnmodel(origin + (0, 0, -115), "zombietron_teleporter");

    if(isDefined(var_45041f7)) {
      var_45041f7 thread namespace_ec06fe4a::function_d55f042c(level, "game_over");
      var_45041f7 setModel("zombietron_teleporter");
      var_45041f7 solid();
      var_45041f7 setmovingplatformenabled(1);
      var_45041f7 namespace_83eb6304::function_3ecfde67("teleporter_dungeon_light");
      var_45041f7 namespace_e32bb68::function_3a59ec34("evt_doa_teleporter_spawn");
      var_45041f7 thread namespace_ec06fe4a::function_f506b4c7();
      var_45041f7 moveto(origin + (0, 0, 12), 1.5);
      level notify(#"teleporter_spawned", {
        #teleporter: var_45041f7
      });
      var_45041f7 waittill(#"movedone");
      var_45041f7 namespace_e32bb68::function_3a59ec34("evt_doa_teleporter_lp");
      level.doa.teleporter = var_45041f7;
      var_45041f7.trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", var_45041f7.origin + (0, 0, -100), 0, 20, 200);

      if(isDefined(var_45041f7.trigger)) {
        var_45041f7.trigger thread namespace_ec06fe4a::function_d55f042c(var_45041f7, "death");
      } else {
        assert(0, "<dev string:x2e0>");
      }

      while(level flag::get("arena_hold_banner_presentation")) {
        waitframe(1);
      }

      var_c2366736 = isDefined(wild) ? 12 : 11;
      level doa_banner::function_7a0e5387(var_c2366736);
    } else {
      assert(0, "<dev string:x2e0>");
    }
  } else {
    assert(isDefined(wild));

    while(level flag::get("arena_hold_banner_presentation")) {
      waitframe(1);
    }

    level doa_banner::function_7a0e5387(13);
  }

  note = "teleporter_taken";
  param = undefined;
  data = undefined;

  if(isDefined(wild)) {
    var_6c225512 = namespace_ec06fe4a::spawnmodel(var_82dd2bd0, "tag_origin");

    if(isDefined(var_6c225512)) {
      var_6c225512 namespace_83eb6304::function_3ecfde67("wild_portal");
      var_6c225512 namespace_83eb6304::function_3ecfde67("wild_portal_elec_burst");
      var_6c225512 namespace_e32bb68::function_3a59ec34("evt_doa_teleporter_wilds_spawn");
      var_6c225512 namespace_e32bb68::function_3a59ec34("evt_doa_teleporter_wilds_lp");
      var_6c225512 thread namespace_ec06fe4a::function_d55f042c(level, "game_over");
    } else {
      assert(0, "<dev string:x2e0>");
    }

    var_6c225512.trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", var_6c225512.origin + (0, 0, -30), 0, 40, 100);
    level.doa.var_6c225512 = var_6c225512;

    if(isDefined(var_6c225512.trigger)) {
      var_6c225512.trigger thread namespace_ec06fe4a::function_d55f042c(var_6c225512, "death");
    } else {
      assert(0, "<dev string:x2e0>");
    }

    wait 1;
    var_6c225512 namespace_83eb6304::function_3ecfde67("wild_portal_radial_burst");
    var_6c225512 namespace_e32bb68::function_3a59ec34("evt_doa_teleporter_wilds_burst");
    var_6c225512.trigger thread function_ba702ab7("enter_the_wild");

    if(isDefined(var_45041f7) && !is_true(var_45041f7.malfunction)) {
      var_45041f7.trigger thread function_ba702ab7("teleporter_taken");
    }

    level.doa.var_9ae7e5e6 = var_6c225512;
    level notify(#"waiting_on_player_exit_decidechoice");
    result = function_df020ff4();
    note = result.note;
    level.doa.var_9ae7e5e6 = undefined;

    if(note == "enter_the_wild") {
      param = var_9f6855ea;
      data = var_c4f905c2;
    }
  } else {
    assert(isDefined(var_45041f7));
    level notify(#"waiting_on_player_exit_teleporteronly");
    result = var_45041f7.trigger waittill(#"trigger");
    var_45041f7.trigger delete();
  }

  if(note === "teleporter_taken") {
    if(namespace_ec06fe4a::function_a8975c67()) {
      playsoundatposition(#"hash_44baccb35f91eeb6", (0, 0, 0));
    }

    foreach(player in getplayers()) {
      player namespace_d2efac9a::function_9a8fff78();
    }
  }

  level thread namespace_7f5aeb59::function_67f054d7();
  level waittill(#"hash_1b322de3d2e3e781");
  [[level.doa.var_39e3fa99]] - > deactivate();

  if(isDefined(var_45041f7)) {
    var_45041f7 namespace_83eb6304::turnofffx("teleporter_dungeon_light");
    var_45041f7 namespace_83eb6304::turnofffx("glow_red");
    var_45041f7 namespace_83eb6304::turnofffx("glow_green");
    var_45041f7 namespace_83eb6304::turnofffx("glow_blue");
    util::wait_network_frame();
    var_45041f7 delete();
  }

  if(isDefined(var_6c225512)) {
    var_6c225512.trigger delete();
    var_6c225512 delete();
    level.doa.var_6c225512 = undefined;
  }

  if(note === # "enter_the_wild") {
    level.doa.zombie_health += 250 + getplayers().size * 250;
  }

  level.doa.teleporter = undefined;
  level.doa.var_a5e5c622 = level.doa.var_39e3fa99;
  level.doa.var_39e3fa99 = undefined;
  level clientfield::set("setArena", 32 - 1);
  namespace_dfc652ee::function_19fa261e();
  namespace_ec06fe4a::clearallcorpses();
  level notify(note, {
    #param: param, #data: data
  });
}

function function_ba702ab7(note) {
  self endon(#"death");
  level endon(#"hash_45f77908e3043522");
  result = self waittill(#"trigger");
  level notify(#"hash_45f77908e3043522", {
    #note: note, #activator: result.activator
  });
}

function function_df020ff4() {
  result = level waittill(#"hash_45f77908e3043522");
  return result;
}

function function_e1916608() {
  self notify("6ffb2dd99af75b0c");
  self endon("6ffb2dd99af75b0c");
  level endon(#"game_over");
  level endon(#"hash_1cf1c429bb1c9a07");
  wait randomint(3) + 1;
  minitems = 4;
  maxitems = 10;
  minwait = 10;
  maxwait = 20;
  var_627acedf = undefined;

  while(true) {
    wait randomfloatrange(minwait, maxwait);

    if(flag::get("doa_round_over") || !isDefined(level.doa.var_39e3fa99)) {
      continue;
    }

    if(isDefined(var_627acedf)) {
      if(gettime() > var_627acedf) {
        while(isDefined(level.doa.var_39e3fa99) && [[level.doa.var_39e3fa99]] - > ispaused()) {
          wait 1;
        }
      }
    } else if([[level.doa.var_39e3fa99]] - > ispaused()) {
      var_627acedf = gettime() + 30000;
    }

    if(doa_enemy::function_e7e91016()) {
      namespace_1e25ad94::function_4e3cfad("<dev string:x2fa>", (1, 0, 0), undefined, 1.5);
      namespace_1e25ad94::debugmsg("<dev string:x321>");

      continue;
    }

    if(!isDefined(level.doa.var_39e3fa99)) {
      continue;
    }

    spot = [[level.doa.var_39e3fa99]] - > function_fdea25f1();
    radius = spot.radius;

    if(!isDefined(radius)) {
      radius = 72;
    }

    namespace_dfc652ee::function_68442ee7(spot.origin, randomintrange(minitems, maxitems), radius, randomint(100) > 98);
  }
}

function function_16902251() {
  self notify("5798315263234892");
  self endon("5798315263234892");
  level endon(#"arena_completed");
  level endon(#"game_over");
  level endon(#"arena_deactivated");
  level endon(#"hash_1cf1c429bb1c9a07");
  minwait = 12;
  maxwait = 24;
  wait randomint(8);
  var_46b5961c = 0;
  var_4b444556 = [[level.doa.var_39e3fa99]] - > getcenter();
  var_9bb0a315 = arraycombine([[level.doa.var_39e3fa99]] - > function_8054e011(), [[level.doa.var_39e3fa99]] - > function_c0402c8a());

  while(true) {
    wait 0.25;

    while([[level.doa.var_39e3fa99]] - > ispaused()) {
      wait 1;
    }

    if(doa_enemy::function_e7e91016()) {
      namespace_1e25ad94::function_4e3cfad("<dev string:x354>", (1, 0, 0), undefined, 1.5);
      namespace_1e25ad94::debugmsg("<dev string:x37a>");

      continue;
    }

    pickupdef = namespace_dfc652ee::function_57160cba();
    type = [[pickupdef]] - > gettype();
    spot = var_9bb0a315[randomint(var_9bb0a315.size)];

    if(!namespace_dfc652ee::function_ae609287(pickupdef, spot.origin)) {
      continue;
    }

    if(type == var_46b5961c) {
      var_46b5961c = 0;
      continue;
    }

    var_46b5961c = type;
    var_9e20508c = 1;

    if(type == 3) {
      var_9e20508c = getplayers().size;
      [[pickupdef]] - > function_772950ea(1);
    }

    for(var_9994cd6e = 8; var_9e20508c; var_9994cd6e = 8) {
      if(var_9994cd6e > 0 && distancesquared(var_4b444556.origin, spot.origin) < sqr(300)) {
        spot = var_9bb0a315[randomint(var_9bb0a315.size)];
        waitframe(1);
        var_9994cd6e--;
        continue;
      }

      var_4b444556 = spot;
      radius = 48;
      namespace_dfc652ee::function_83aea294(spot.origin, 1, radius, pickupdef);
      var_9e20508c--;
      spot = var_9bb0a315[randomint(var_9bb0a315.size)];
    }

    if([[pickupdef]] - > function_772950ea(0)) {
      [[pickupdef]] - > function_755a46e6();
    }

    wait randomfloatrange(minwait, maxwait);
  }
}

function function_17e79564() {
  self notify("3520af402d8485a4");
  self endon("3520af402d8485a4");
  level endon(#"arena_completed");
  level endon(#"game_over");
  level endon(#"hash_1cf1c429bb1c9a07");
  wait 5;
  minwait = 30;
  maxwait = 40;
  nextweapon = 0;
  var_e36d70e2 = undefined;
  var_d7f489eb = array::randomize(arraycombine([[level.doa.var_39e3fa99]] - > function_8054e011(), [[level.doa.var_39e3fa99]] - > function_c0402c8a()));
  var_9a572c4e = 0;

  while(true) {
    if(isDefined(var_e36d70e2)) {
      if(gettime() > var_e36d70e2) {
        while([[level.doa.var_39e3fa99]] - > ispaused()) {
          wait 1;
        }
      }
    } else if([[level.doa.var_39e3fa99]] - > ispaused()) {
      var_e36d70e2 = gettime() + 30000;
    }

    if(gettime() > nextweapon) {
      if(isDefined(level.doa.var_cfa10fcf)) {
        var_9e20508c = level.doa.var_cfa10fcf;
        level.doa.var_cfa10fcf = undefined;
      } else {
        var_9e20508c = 1;

        if(randomint(100) > 98) {
          var_9e20508c += randomint(3);
        }
      }

      def = namespace_dfc652ee::function_57160cba(6);
      spot = var_d7f489eb[var_9a572c4e];
      var_9a572c4e++;

      if(var_9a572c4e >= var_d7f489eb.size) {
        var_9a572c4e = 0;
      }

      radius = spot.radius;

      if(!isDefined(radius)) {
        radius = 36;
      }

      namespace_dfc652ee::function_83aea294(spot.origin, var_9e20508c, radius, def);
      nextweapon = gettime() + randomintrange(minwait, maxwait) * 1000;
    }

    waitframe(1);
  }
}

function function_80bb0f94(name) {
  return true;
}

function function_1b42a0bb() {
  self notify("7e0335e89fa03145");
  self endon("7e0335e89fa03145");
  level endon(#"arena_completed");
  level endon(#"game_over");

  if(function_80bb0f94([[level.doa.var_39e3fa99]] - > getname()) == 0) {
    return;
  }

  while(true) {
    while(!is_true(level.doa.var_a6cd0cb7) && isDefined(level.doa.var_39e3fa99) && [[level.doa.var_39e3fa99]] - > ispaused() || isDefined(level.doa.var_6f3d327)) {
      wait 1;
    }

    level.doa.var_11623c49--;

    if(level.doa.var_11623c49 <= 0) {
      level.doa.var_a6cd0cb7 = undefined;
      level function_8f63849();

      while(isDefined(level.doa.weaponcharger)) {
        wait 1;
      }

      level.doa.var_11623c49 = randomintrange(200, 600);
    }

    wait 1;
  }
}

function function_8f63849() {
  self notify("6368f448f211935e");
  self endon("6368f448f211935e");
  level endon(#"arena_completed");
  level endon(#"game_over");

  if(isDefined(level.doa.weaponcharger)) {
    level.doa.weaponcharger delete();
  }

  spot = [[level.doa.var_39e3fa99]] - > function_70fb5745();
  var_d6e32de9 = [[level.doa.var_39e3fa99]] - > function_70fb5745(spot.origin, 24, 256);

  if(isDefined(var_d6e32de9)) {
    def = namespace_dfc652ee::function_57160cba(6);
    namespace_dfc652ee::function_83aea294(var_d6e32de9.origin, 1, 8, def);
  }

  origin = namespace_ec06fe4a::function_65ee50ba(spot.origin) + (0, 0, 6);
  var_70527f67 = namespace_ec06fe4a::spawnmodel(origin + (0, 0, -115), "zombietron_weapon_charging_pad");

  if(isDefined(var_70527f67)) {
    var_70527f67.targetname = "weaponCharger";
    var_70527f67 solid();
    var_70527f67 namespace_83eb6304::function_3ecfde67("glow_yellow");
    var_70527f67.var_81b02b86 = 120;
    var_70527f67 moveto(origin, 1.5);
    var_70527f67 waittill(#"movedone");
    var_70527f67 connectpaths();
    var_70527f67.trigger = namespace_ec06fe4a::spawntrigger("trigger_radius", origin + (0, 0, -20), 0, 20, 72);
    var_70527f67 namespace_83eb6304::function_3ecfde67("weaponChargerActive");
    var_70527f67 namespace_e32bb68::function_3a59ec34("evt_doa_weapon_charge_start");
    var_70527f67 namespace_e32bb68::function_3a59ec34("evt_doa_weapon_charge_lp");
    level.doa.weaponcharger = var_70527f67;
    level.doa.weaponcharger thread function_6aa1d6a();
    level.doa.weaponcharger thread function_b0a158d7();
    level.doa.weaponcharger thread function_f39d5561();
  }
}

function function_b0a158d7() {
  self endon(#"death");

  if(!isDefined(self.trigger)) {
    level notify(#"hash_bc1b9c6675b1faa");
    return;
  }

  var_666e15ce = 150;
  def = namespace_dfc652ee::function_2c9923d7(36);
  var_7cc1c2b2 = array(def, def, def, def);

  while(self.var_81b02b86 > 0 && isDefined(self.trigger)) {
    players = namespace_7f5aeb59::function_23e1f90f();

    foreach(player in players) {
      entnum = player.doa.entnum;
      player.doa.var_57eaec6e = 0;

      if(player istouching(self.trigger)) {
        if(is_true(player.laststand)) {
          continue;
        }

        if(player.doa.weaponlevel == 2 && player.doa.var_d8955419 == 1024) {
          continue;
        }

        player.doa.var_57eaec6e = 1;

        if(player.doa.weaponlevel == 0) {
          player.doa.var_d8955419 = 1024;
        }

        switch (player.doa.weaponlevel) {
          case 0:
            type = 36;
            glow = "glow_white";
            break;
          case 1:
            type = 37;
            glow = "glow_red";
            break;
          case 2:
            type = 38;
            glow = "glow_blue";
            break;
        }

        if(type === [[var_7cc1c2b2[entnum]]] - > gettype()) {
          def = var_7cc1c2b2[entnum];
        } else {
          def = namespace_dfc652ee::function_2c9923d7(type);
          var_7cc1c2b2[entnum] = def;
        }

        namespace_dfc652ee::itemspawn(def, player.origin, player.angles, undefined, 1, glow, undefined, undefined, player, 0);
        player.doa.var_6b4163f1 = 0;
        self.var_81b02b86 -= 5;
      }
    }

    wait 1;
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  level notify(#"hash_bc1b9c6675b1faa");
}

function function_f39d5561() {
  self endon(#"death");
  wait 30;
  level notify(#"hash_bc1b9c6675b1faa");
}

function function_6aa1d6a() {
  self endon(#"death");
  level waittill(#"arena_completed", #"game_over", #"exit_taken", #"hash_bc1b9c6675b1faa", #"round_over", #"hash_7ebdbe412d2fed17");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  wait 1;
  self namespace_83eb6304::turnofffx("weaponChargerActive");
  self namespace_e32bb68::function_ae271c0b("evt_doa_weapon_charge_lp");
  self namespace_83eb6304::function_3ecfde67("weaponChargerDone");
  self namespace_e32bb68::function_3a59ec34("evt_doa_weapon_charge_end");
  self moveto(self.origin + (0, 0, -115), 1.5);
  self waittill(#"movedone");
  self connectpaths();
  self namespace_83eb6304::turnofffx("weaponChargerActive");
  level.doa.weaponcharger = undefined;
  players = namespace_7f5aeb59::function_23e1f90f();

  foreach(player in players) {
    player.doa.var_57eaec6e = 0;
  }

  self delete();
}

function function_81282ad3(delay = 0, infinite = 0) {
  self notify("20e62f006de791f4");
  self endon("20e62f006de791f4");
  level endon(#"game_over");
  level endon(#"round_over");
  level flag::set("doa_round_spawning");
  level flag::clear("doa_round_over");

  if(delay > 0) {
    wait delay;
  }

  starttime = gettime();

  if(level flag::get("challenge_round_spawnOverride")) {
    level flag::wait_till_clear("challenge_round_spawnOverride");
  } else {
    namespace_1e25ad94::debugmsg("Round " + level.doa.roundnumber + " starting at: " + starttime + " Waves expected: " + level.doa.var_9a86a331.size);
    level.doa.var_aa7fba18 = level.doa.var_9a86a331.size;

    do {
      for(wave = 0; wave < level.doa.var_9a86a331.size; wave++) {
        while(level flag::get("doa_round_paused") || is_true(level.hostmigrationtimer)) {
          waitframe(1);
        }

        if(level flag::get("doa_game_is_over")) {
          break;
        }

        level thread function_a87190c4(level.doa.var_9a86a331[wave]);
        wait level.doa.var_9a86a331[wave].var_bd90dbbc;
      }
    }
    while(infinite);
  }

  while(level.doa.var_aa7fba18 > 0 || level.doa.var_dcbded2.size) {
    wait 1;
  }

  endtime = gettime();
  namespace_1e25ad94::debugmsg("Round " + level.doa.roundnumber + " took (" + (endtime - starttime) / 1000 + ") seconds to complete.");
  level flag::clear("doa_round_spawning");
  level.doa.var_9a86a331 = [];
}

function function_24058346(spot) {
  if(level.doa.var_a77e4601.size) {
    var_7a8f2a62 = level.doa.var_a77e4601[randomint(level.doa.var_a77e4601.size)];
  } else {
    var_7a8f2a62 = level.doa.var_329c97a3[randomint(level.doa.var_329c97a3.size)];
  }

  if(var_7a8f2a62 != level.doa.var_65a70dc) {
    if([[var_7a8f2a62]] - > function_baae6c9d([[level.doa.var_39e3fa99]] - > getname())) {
      var_7a8f2a62 = level.doa.var_65a70dc;
    }

    var_9d97ad8e = [[var_7a8f2a62]] - > function_7f3e577e(level.doa.var_3e7292fc) || gettime() - [[level.doa.var_39e3fa99]] - > function_55916d40() > 15000;

    if(!isinarray(level.doa.var_a77e4601, var_7a8f2a62) && var_9d97ad8e == 0) {
      var_7a8f2a62 = level.doa.var_65a70dc;
    }

    if([[var_7a8f2a62]] - > canspawn() == 0) {
      var_7a8f2a62 = level.doa.var_65a70dc;
    }

    if(var_7a8f2a62 != level.doa.var_65a70dc) {
      [[level.doa.var_39e3fa99]] - > function_b2f9e813();
    }
  }

  return doa_enemy::function_4e8ae191(var_7a8f2a62, 1, spot.origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99);
}

function function_a87190c4(wave) {
  level endon(#"round_over");
  level endon(#"game_over");
  endtime = gettime() + wave.var_d89d85d0 * 1000;

  while(gettime() < endtime || wave.var_3ed31a82 > 0) {
    while(level flag::get("doa_round_paused") || is_true(level.hostmigrationtimer)) {
      waitframe(1);
    }

    if(level flag::get("doa_game_is_over")) {
      break;
    }

    if(is_true(level.hostmigrationtimer)) {
      waitframe(1);
      continue;
    }

    wait 0.35;
    spot = [[level.doa.var_39e3fa99]] - > function_21d1be3d(wave.spawn_side);
    ai = function_24058346(spot);

    if(isDefined(ai)) {
      wave.var_3ed31a82--;
    }
  }

  level.doa.var_aa7fba18--;
  wave notify(#"done_spawning");
}

function function_3d25cb06(roundnumber = level.doa.roundnumber) {
  level.doa.var_9a86a331 = [];
  max = 30 + level.doa.var_6c58d51 * 30;
  waves = 6 + int(roundnumber * 1.2);

  if(waves > max) {
    waves = max;
  }

  for(i = 0; i < waves; i++) {
    level.doa.var_9a86a331[i] = function_2419e70a(i, roundnumber);
  }
}

function function_7802d126() {
  switch (randomint(4)) {
    case 0:
      return "bottom";
    case 1:
      return "top";
    case 2:
      return "right";
    case 3:
      return "left";
  }
}

function function_d60e0e9a(side) {
  switch (side) {
    case # "top":
      return "bottom";
    case # "bottom":
      return "top";
    case # "left":
      return "right";
    case # "right":
      return "left";
  }
}

function private function_2419e70a(wave_number, round_number) {
  wave = spawnStruct();
  wave.var_d89d85d0 = 1 + randomfloatrange(0, 1 + wave_number * 0.3) + randomfloatrange(0, 1 + round_number * 0.2);
  wave.spawn_side = function_7802d126();
  wave.var_bd90dbbc = 1 + randomfloatrange(wave.var_d89d85d0 * 0.3, wave.var_d89d85d0 * 0.9);
  wave.var_3ed31a82 = int(wave.var_d89d85d0 / 0.35 * 0.35);
  wave.wavenumber = wave_number;
  return wave;
}

function function_3af22009() {
  if(!isDefined(self.endtime)) {
    return false;
  }

  return gettime() > self.endtime || self.var_3ed31a82 <= 0;
}

function function_67a3bb43() {
  level endon(#"round_over");
  level endon(#"game_over");
  self notify("2f006c2033275640");
  self endon("2f006c2033275640");
  result = self waittill(#"hash_b1f03f83d7dde45");

  if(!isDefined(self.starttime)) {
    self.starttime = gettime();
    self.endtime = self.starttime + self.var_d89d85d0 * 1000;
  }

  while(!self function_3af22009()) {
    self.var_1834860 = result.var_1834860;
    self.wanted = result.wanted;

    while(self.wanted > 0) {
      spot = [[level.doa.var_39e3fa99]] - > function_21d1be3d(self.spawn_side);

      if(level.doa.var_a77e4601.size) {
        var_7a8f2a62 = level.doa.var_a77e4601[randomint(level.doa.var_a77e4601.size)];
        var_7d992156 = 1;
      } else {
        var_7a8f2a62 = level.doa.var_329c97a3[randomint(level.doa.var_329c97a3.size)];
        var_7d992156 = undefined;
      }

      var_9e20508c = self.wanted;

      if(var_7a8f2a62 != level.doa.var_65a70dc) {
        if([[var_7a8f2a62]] - > function_baae6c9d([[level.doa.var_39e3fa99]] - > getname())) {
          var_7a8f2a62 = level.doa.var_65a70dc;
        }

        var_9d97ad8e = [[var_7a8f2a62]] - > function_7f3e577e(level.doa.var_3e7292fc) || gettime() - [[level.doa.var_39e3fa99]] - > function_55916d40() > 15000;

        if(!isinarray(level.doa.var_a77e4601, var_7a8f2a62) && var_9d97ad8e == 0) {
          var_7a8f2a62 = level.doa.var_65a70dc;
        }

        if([[var_7a8f2a62]] - > canspawn() == 0) {
          var_7a8f2a62 = level.doa.var_65a70dc;
        }

        if(var_7a8f2a62 != level.doa.var_65a70dc) {
          [[level.doa.var_39e3fa99]] - > function_b2f9e813();

          if(!is_true(var_7d992156)) {
            var_9e20508c = 1;
          }
        }
      }

      self.var_3ed31a82 -= var_9e20508c;
      self.wanted -= var_9e20508c;
      doa_enemy::function_a6b807ea(var_7a8f2a62, var_9e20508c, spot.origin, 0, undefined, undefined, undefined, level.doa.var_39e3fa99, self.var_1834860, 0, self.endtime);
      wait randomfloatrange(0.5, 2);
    }

    if(is_true(level.doa.var_2409dcb5)) {
      level thread namespace_1e25ad94::debugline(spot.origin, [[level.doa.var_39e3fa99]] - > function_ffcf1d1(), self.var_7f9fdec7, (1, 0, 0));
    }
  }

  self.alldone = 1;
}

function function_9e0d71e5() {
  self notify("41f1f5a885cedbd");
  self endon("41f1f5a885cedbd");
  level endon(#"game_over");
  level endon(#"round_over");
  level flag::set("doa_round_spawning");
  level flag::clear("doa_round_over");
  starttime = gettime();
  var_d517bf3a = 1;

  if(level flag::get("challenge_round_spawnOverride")) {
    level flag::wait_till_clear("challenge_round_spawnOverride");
    var_d517bf3a = level.doa.var_6c58d51 > 0;
  }

  if(var_d517bf3a) {
    namespace_1e25ad94::debugmsg("Round " + level.doa.roundnumber + " starting at: " + starttime + " Waves expected: " + level.doa.var_9a86a331.size);
    level.doa.var_aa7fba18 = level.doa.var_9a86a331.size;

    for(wave = 0; wave < level.doa.var_9a86a331.size; wave++) {
      [[level.doa.var_39e3fa99]] - > function_25962665(level.doa.var_9a86a331[wave]);
    }

    level.doa.var_9a86a331 = [];
    var_68280a24 = [[level.doa.var_39e3fa99]] - > function_cc773c53();
    var_fe3c2d16 = [[level.doa.var_39e3fa99]] - > function_786b9d39();
    waves = [];
    waves[# "top"] = [[level.doa.var_39e3fa99]] - > function_ee30f092("top");

    if(isDefined(waves[# "top"])) {
      waves[# "top"] thread function_67a3bb43();
    }

    waves[# "bottom"] = [[level.doa.var_39e3fa99]] - > function_ee30f092("bottom");

    if(isDefined(waves[# "bottom"])) {
      waves[# "bottom"] thread function_67a3bb43();
    }

    waves[# "left"] = [[level.doa.var_39e3fa99]] - > function_ee30f092("left");

    if(isDefined(waves[# "left"])) {
      waves[# "left"] thread function_67a3bb43();
    }

    waves[# "right"] = [[level.doa.var_39e3fa99]] - > function_ee30f092("right");

    if(isDefined(waves[# "right"])) {
      waves[# "right"] thread function_67a3bb43();
    }

    done = 0;
    var_1834860 = 100;

    while(!done) {
      waves = array::randomize(waves);

      foreach(wave in waves) {
        wave notify(#"hash_b1f03f83d7dde45", {
          #var_1834860: var_1834860, #wanted: randomintrange(var_68280a24, var_fe3c2d16)
        });
        level.doa.var_aa7fba18 = math::clamp(level.doa.var_aa7fba18 - 1, 0, level.doa.var_aa7fba18);
        var_1834860++;

        while(wave.var_bd90dbbc > 0) {
          wait 0.2;
          wave.var_bd90dbbc -= 0.2;
        }
      }

      waitframe(1);
      done = 1;
      var_77fcdba0 = [];

      foreach(wave in waves) {
        nextside = undefined;

        if(is_true(wave.alldone)) {
          nextside = [[level.doa.var_39e3fa99]] - > function_ee30f092(wave.spawn_side);

          if(isDefined(nextside)) {
            nextside thread function_67a3bb43();

            if(!isDefined(var_77fcdba0)) {
              var_77fcdba0 = [];
            } else if(!isarray(var_77fcdba0)) {
              var_77fcdba0 = array(var_77fcdba0);
            }

            var_77fcdba0[var_77fcdba0.size] = nextside;
          }

          continue;
        }

        if(!isDefined(var_77fcdba0)) {
          var_77fcdba0 = [];
        } else if(!isarray(var_77fcdba0)) {
          var_77fcdba0 = array(var_77fcdba0);
        }

        var_77fcdba0[var_77fcdba0.size] = wave;
      }

      waves = var_77fcdba0;

      if(waves.size) {
        done = 0;
      }
    }
  }

  level flag::clear("doa_round_spawning");
  level notify(#"hash_7ebdbe412d2fed17");
  wait 1;

  while(level.doa.var_dcbded2.size) {
    waitframe(1);
  }

  endtime = gettime();
  namespace_1e25ad94::debugmsg("Round " + level.doa.roundnumber + " took (" + (endtime - starttime) / 1000 + ") seconds to complete.");
}

function function_53678480() {
  avail = [];

  if(level.doa.var_23ce73 & 1) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = "top";
  }

  if(level.doa.var_23ce73 & 2) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = "left";
  }

  if(level.doa.var_23ce73 & 4) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = "right";
  }

  if(level.doa.var_23ce73 & 8) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = "bottom";
  }

  return avail;
}

function function_32d53491() {
  avail = [];

  if((level.doa.var_23ce73 & 1) == 0) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = 1;
  }

  if((level.doa.var_23ce73 & 2) == 0) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = 2;
  }

  if((level.doa.var_23ce73 & 4) == 0) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = 4;
  }

  if((level.doa.var_23ce73 & 8) == 0) {
    if(!isDefined(avail)) {
      avail = [];
    } else if(!isarray(avail)) {
      avail = array(avail);
    }

    avail[avail.size] = 8;
  }

  return avail;
}

function function_a30ab289(side) {
  switch (side) {
    case # "top":
      return 1;
    case # "left":
      return 2;
    case # "right":
      return 4;
    case # "bottom":
      return 8;
  }

  return 0;
}

function function_dc848b36(side) {
  level endon(#"game_over", #"round_over");
  var_612922db = function_a30ab289(side);

  while(level flag::get("doa_round_spawning")) {
    while(level flag::get("doa_round_paused") || is_true(level.hostmigrationtimer)) {
      waitframe(1);
    }

    if(level.doa.var_23ce73 &var_612922db) {
      spot = [[level.doa.var_39e3fa99]] - > function_21d1be3d(side);
      ai = function_24058346(spot);

      if(isDefined(ai)) {
        level.doa.var_3ed31a82 = math::clamp(level.doa.var_3ed31a82 - 1, 0, level.doa.var_3ed31a82);
        wait 0.35;
      } else {
        wait randomfloatrange(0.15, 0.35);
      }

      continue;
    }

    wait randomfloatrange(0.15, 0.5);
  }
}

function function_870f7b82(probability) {
  level endon(#"game_over", #"round_over");
  probability = math::clamp(probability, 0, 100);

  if(probability == 0) {
    return;
  }

  var_912bdf32 = getdvarint(#"hash_3679fe3f1521db3d", 5);
  var_c7befab = getdvarint(#"hash_2b73855c34966f6b", 12);
  minwaittime = getdvarint(#"hash_2209051f3a7463fc", 1);
  maxwaittime = getdvarint(#"hash_7150d4531dfb10c6", 5);
  var_5689c058 = undefined;

  while(level flag::get("doa_round_spawning")) {
    if(randomint(100) < probability) {
      var_49261ce3 = function_32d53491();

      if(var_49261ce3.size) {
        if(isDefined(var_5689c058) && var_49261ce3.size > 1 && isinarray(var_49261ce3, var_5689c058)) {
          arrayremovevalue(var_49261ce3, var_5689c058);
        }

        var_5689c058 = var_49261ce3[randomint(var_49261ce3.size)];
        level.doa.var_23ce73 |= var_5689c058;
        var_936be0c2 = randomfloatrange(var_912bdf32, var_c7befab);
        wait var_936be0c2;
        level.doa.var_23ce73 &= ~var_5689c058;
      }
    }

    wait randomfloatrange(minwaittime, maxwaittime);
  }
}

function function_cc48fee6() {
  var_30d7b69b = {};
  var_30d7b69b.var_dcf9fac7 = getdvarint(#"hash_4c0888d26878c503", 3);
  var_30d7b69b.var_39a29169 = getdvarint(#"hash_6bb8a71eee3d3d15", 47);
  var_30d7b69b.var_5bb9bdea = 0;
  probability = 100;

  for(var_dcf9fac7 = var_30d7b69b.var_dcf9fac7; var_dcf9fac7; var_dcf9fac7--) {
    var_30d7b69b.var_5bb9bdea += int(level.doa.var_8bf23c51 * probability / 100);
    probability = math::clamp(probability - var_30d7b69b.var_39a29169, 5, 100);
  }

  return var_30d7b69b;
}

function function_70a9cb95(var_30d7b69b) {
  level.doa.var_23ce73 = 0;
  var_dcf9fac7 = var_30d7b69b.var_dcf9fac7;
  var_39a29169 = var_30d7b69b.var_39a29169;
  probability = 100;

  while(var_dcf9fac7) {
    level thread function_870f7b82(probability);
    probability -= var_39a29169;
    var_dcf9fac7--;
  }

  level thread function_dc848b36("top");
  level thread function_dc848b36("left");
  level thread function_dc848b36("bottom");
  level thread function_dc848b36("right");
}

function function_c8462f96() {
  level.doa.var_8f91d36b = 0;
  level.doa.var_3ed31a82 = 0;
}

function function_7655afe() {
  self notify("214f45353a3979d");
  self endon("214f45353a3979d");
  level endon(#"game_over", #"round_over");
  level flag::set("doa_round_spawning");
  level flag::clear("doa_round_over");
  starttime = gettime();
  var_d517bf3a = 1;

  if(level flag::get("challenge_round_spawnOverride")) {
    level.doa.var_3ed31a82 = 0;
    level flag::wait_till_clear("challenge_round_spawnOverride");
    var_d517bf3a = level.doa.var_6c58d51 > 0;
  }

  if(var_d517bf3a) {
    level.doa.var_8bf23c51 = 20 + level.doa.roundnumber * 2.5 + 180 * level.doa.var_6c58d51;

    if(getdvarint(#"hash_5c718b756a54aaba", 0)) {
      level.doa.var_8bf23c51 = 999999;
      [[level.doa.var_39e3fa99]] - > function_6d5262dc(40);
    }

    if(getdvarint(#"hash_5d9faab41425ec06", 0)) {
      level.doa.var_8bf23c51 = getdvarint(#"hash_5d9faab41425ec06", 0);
      level thread namespace_ec06fe4a::function_e10101e(getdvarint(#"hash_5d9faab41425ec06", 0) + 1);
    }

    var_319ab9be = function_cc48fee6();
    level function_70a9cb95(var_319ab9be);
    level.doa.var_3ed31a82 = int(var_319ab9be.var_5bb9bdea / 0.35 * 0.35);
    level.doa.var_8f91d36b = starttime + level.doa.var_8bf23c51 * 1000;
    level.doa.var_a8834e17 = level.doa.var_8f91d36b - gettime();
    quarter = level.doa.var_8bf23c51 / 4 * 1000;
    var_1ba263be = starttime + quarter;
    var_6889287c = var_1ba263be + quarter;
    var_dc22600b = var_6889287c + quarter;
    level.doa.var_654a3ea9 = 0;
    last = starttime;

    do {
      wait 1;
      time = gettime();

      if(time > level.doa.var_8f91d36b && level.doa.var_3ed31a82 > 0) {
        level.doa.var_654a3ea9++;
      }

      if(last < var_1ba263be && time >= var_1ba263be) {
        level notify(#"hash_5b8b8bf728571b12");
      }

      if(last < var_6889287c && time >= var_6889287c) {
        level notify(#"hash_73d11f98f78c29be");
      }

      if(last < var_dc22600b && time >= var_dc22600b) {
        level notify(#"hash_c57f3f18a005e45");
      }

      last = time;
    }
    while(time < level.doa.var_8f91d36b || level.doa.var_3ed31a82 > 0);
  }

  level.doa.var_23ce73 = 0;
  level flag::clear("doa_round_spawning");
  level notify(#"hash_7ebdbe412d2fed17");
  wait 1;

  while(level.doa.var_dcbded2.size) {
    waitframe(1);
  }

  endtime = gettime();
  namespace_1e25ad94::debugmsg("Round " + level.doa.roundnumber + " took (" + (endtime - starttime) / 1000 + ") seconds to complete.");
}

function function_41e097fc(arenaid) {
  level notify(#"round_over");
  level notify(#"arena_completed");
  level.doa.var_3ec3c9aa = 1;
  namespace_ec06fe4a::function_de70888a();
  level namespace_ec06fe4a::function_b6b79fd1(3);
  namespace_ec06fe4a::clearallcorpses();
  level thread namespace_7f5aeb59::function_67f054d7();
  level waittill(#"hash_1b322de3d2e3e781");
  namespace_ec06fe4a::function_42304070();

  if(isDefined(level.doa.var_39e3fa99)) {
    [[level.doa.var_39e3fa99]] - > function_9f494a87();
    [[level.doa.var_39e3fa99]] - > function_7ce9bb97();
    [[level.doa.var_39e3fa99]] - > deactivate();
  }

  level notify(#"arena_completed");
  level.doa.var_23fd3659 = arenaid;
  level.doa.var_f4cf4e3 = function_f15b9f04(level.doa.var_23fd3659 * 4);
  level.doa.zombie_health = function_962e9d92(level.doa.var_23fd3659 * 4);
  namespace_4dae815d::function_e22d3978(level.doa.var_23fd3659 * 4);

  foreach(player in getplayers()) {
    if(isDefined(player) && isDefined(player.doa)) {
      player.doa.var_87c1cd32 = level.doa.roundnumber;
      player.doa.var_b8232cd0 = level.doa.roundnumber;
    }
  }

  namespace_250e9486::function_d1bc3f11(level.doa.roundnumber, 1);
  level thread function_6d6bfe1f(level.doa.var_23fd3659);
}