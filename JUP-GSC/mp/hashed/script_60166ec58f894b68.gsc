/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_60166ec58f894b68.gsc
*************************************************/

#using script_249b0a9054ceb230;
#using script_3e34d236a84cfd96;
#using script_7e41e37180e554f;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#namespace namespace_925730df71cc5248;

function init() {
  function_23300ca29b18a2e0();
  function_6d74697a89e64667();
}

function private function_23300ca29b18a2e0() {
  level.soak_test = spawnStruct();
  enable_test = getdvarint(@ "hash_1ffffebc79e93b7f", 0);

  if(istrue(enable_test)) {
    level callback::add("player_connect", &on_player_connect);
  }
}

function private on_player_connect(params) {
  level callback::remove("player_connect", &on_player_connect, 1);
  function_443f66340f31c7bf();
}

function private function_6d74697a89e64667() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_b23a59dfb4ca49a1("<dev string:x2d>", "<dev string:x40>", &function_4f96e3e391b21797);
  function_b23a59dfb4ca49a1("<dev string:x5e>", "<dev string:x70>", &function_4f96e3e391b21797);
  function_b23a59dfb4ca49a1("<dev string:x8f>", "<dev string:xbb>", &function_4f96e3e391b21797);
  function_b23a59dfb4ca49a1("<dev string:xea>", "<dev string:x115>", &function_4f96e3e391b21797);
  function_b23a59dfb4ca49a1("<dev string:x145>", "<dev string:x173>", &function_4f96e3e391b21797);
  function_b23a59dfb4ca49a1("<dev string:x19c>", "<dev string:x1c9>", &function_4f96e3e391b21797);
  function_b23a59dfb4ca49a1("<dev string:x1f3>", "<dev string:x219>", &function_4f96e3e391b21797);
  function_b23a59dfb4ca49a1("<dev string:x243>", "<dev string:x268>", &function_4f96e3e391b21797);
  function_fe953f000498048f();
}

function private function_4f96e3e391b21797(params) {
  switch (params[0]) {
    case #"hash_6caf06e2c9e6872e":
      function_443f66340f31c7bf();
      break;
    case #"hash_c1c88ef798270243":
      function_f6048c615df8478d();
      break;
    case #"hash_c264c6792dab4bb0":
      setDvar(@ "hash_bef29ea4a0f46e7", 1);
      thread function_90ef6e3b34b91a28();
      break;
    case #"hash_9b1fc617fa1ea3c9":
      setDvar(@ "hash_bef29ea4a0f46e7", 0);
      function_90ef6e3b34b91a28();
      break;
    case #"hash_26aaaa84b54da8b":
      setDvar(@ "hash_181ba380cbd7b4cf", 1);
      thread function_2088357a22c2dca4();
      break;
    case #"hash_bd6cf06749b490f8":
      setDvar(@ "hash_181ba380cbd7b4cf", 0);
      function_7bd4e7a55d00f89d();
      break;
    case #"hash_ae6608a71ecd1f46":
      setDvar(@ "hash_58fde8969e4bed86", 1);
      thread function_65f5363b869f516c();
      break;
    case #"hash_68b149a7de08536b":
      setDvar(@ "hash_58fde8969e4bed86", 0);
      function_6a48443164d8b285();
      break;
  }
}

function private function_443f66340f31c7bf() {
  function_f6048c615df8478d();
  level thread function_2088357a22c2dca4();
  level thread function_90ef6e3b34b91a28();
  level thread function_65f5363b869f516c();
}

function private function_f6048c615df8478d() {
  function_7bd4e7a55d00f89d();
  function_9a3fdb73804dcfa9();
  function_6a48443164d8b285();
  level notify("stop_ob_soaktest");
}

function private function_af072d6d989b7df4(player) {
  function_ad698ba26068ea05("Waiting for player control");
  takedamage = player.takedamage;

  while(istrue(player.scripted_mode)) {
    player.takedamage = 0;
    wait 1;
  }

  player.takedamage = takedamage;
  level flag_wait("ob_infil_completed");
  function_ad698ba26068ea05("Player has control");
}

function private function_ad698ba26068ea05(text) {
  if(getdvarint(@ "hash_fb7de827d1d52bd8", 0) == 0) {
    return;
  }

  println("<dev string:x293>" + gettime() + "<dev string:x2ae>" + text);
}

function private function_2088357a22c2dca4() {
  if(getdvarint(@ "hash_97f50d212cd862fd", 0) == 0) {
    return;
  }

  level notify("abort_bot_test");
  level endon("abort_bot_test");
  level endon("game_ended");
  function_ad698ba26068ea05("Iniitiating add_delete_test (ob_soak_test)");
  function_af072d6d989b7df4(level.players[0]);
  level.soak_test.test_bots = [];
  level.soak_test.var_d90a515a2b80169 = getdvarint(@ "hash_a962aa3ed8ea082c", 1);
  level.soak_test.var_37daf40716eddac3 = getdvarint(@ "hash_79b43bbd00d2a116", 14);
  level.soak_test.max_bots = getdvarint(@ "hash_97b11d093c59fce6", 2);
  level.soak_test.var_63c1c110c5bfce29 = level.var_dc9d9add8a02556a;
  level.var_dc9d9add8a02556a = 0;
  level.soak_test.var_a54d5e4b9ffc56a0 = level.var_b4d422cd8fbde1ad;
  level.var_b4d422cd8fbde1ad = 0;

  while(true) {
    if(level.soak_test.test_bots.size < level.soak_test.max_bots) {
      level.soak_test.var_d6610599aff7963e = level.players[0].origin;
      level thread scripts\mp\bots\bots::spawn_bots(1, level.players[0].team, &function_2b9cf2f2ee34bbc0, undefined, undefined, "recruit");
      level waittill("bot_spawned");
      continue;
    }

    wait 0.25;
  }
}

function private function_7bd4e7a55d00f89d() {
  function_ad698ba26068ea05("Terminating add_delete_test");

  if(isDefined(level.soak_test.var_63c1c110c5bfce29)) {
    level.var_dc9d9add8a02556a = level.soak_test.var_63c1c110c5bfce29;
  }

  if(isDefined(level.soak_test.var_a54d5e4b9ffc56a0)) {
    level.var_b4d422cd8fbde1ad = level.soak_test.var_a54d5e4b9ffc56a0;
  }

  level notify("kick_all_bots");
  level notify("abort_bot_test");
}

function private function_2b9cf2f2ee34bbc0() {
  thread function_8685e7bb9337b798("kick_all_bots", level.soak_test.var_d90a515a2b80169, level.soak_test.var_37daf40716eddac3);

  if(isDefined(level.soak_test.var_d6610599aff7963e)) {
    myorigin = level.soak_test.var_d6610599aff7963e + (randomintrange(-128, 128), randomintrange(-128, 128), 24);

    if(!self isspectatingplayer()) {
      self setOrigin(myorigin);
      self botclearscriptgoal();
    }
  }

  self botsetflag("disable_movement", 1);
  self botsetflag("disable_random_goal", 1);
  self botsetflag("dont_path_to_enemy", 1);
  self allowmovement(0);
  level.soak_test.test_bots[level.soak_test.test_bots.size] = self;
  function_ad698ba26068ea05("Bot Spawned, count = " + level.soak_test.test_bots.size);
  level notify("bot_spawned");
}

function private function_8685e7bb9337b798(note, min, max) {
  self endon("disconnect");
  timeout = randomfloatrange(min, max);
  level waittill_notify_or_timeout(note, timeout);
  level.soak_test.test_bots = array_remove(level.soak_test.test_bots, self);
  kick(self getentitynumber());
  function_ad698ba26068ea05("Bot kicked, count = " + level.soak_test.test_bots.size);
}

function private function_90ef6e3b34b91a28() {
  level notify("warp_shoot_test_singleton");
  level endon("warp_shoot_test_singleton");
  level endon("game_ended");

  if(getdvarint(@ "hash_bef29ea4a0f46e7", 0) == 0) {
    return;
  }

  function_af072d6d989b7df4(level.players[0]);
  function_ad698ba26068ea05("Iniitiating warp_shoot_test (ob_soak_test)");

  while(true) {
    foreach(player in level.players) {
      if(isalive(player) && !player ent_flag("player_soak_active")) {
        player thread function_21c7f1a87f076126();
      }
    }

    wait 10;
  }
}

function private function_21c7f1a87f076126() {
  self notify("player_soak_loop_singleton");
  self endon("player_soak_loop_singleton");
  level endon("warp_shoot_test_singleton");
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  player = self;
  player ent_flag_set("player_soak_active");
  setDvar(@ "player_sustainammo", 1);
  all_ai = getaiarray();
  ai_sorted = get_array_of_closest(player.origin, all_ai);

  foreach(ai in ai_sorted) {
    if(isDefined(ai) && isalive(ai)) {
      warp_origin = ai.origin + (30, 30, 10);
      new_origin = getclosestpointonnavmesh(warp_origin);
      player setOrigin(new_origin);
      function_ad698ba26068ea05("Warping player (" + player.name + ") to location " + new_origin);
      wait 2;

      for(i = 0; i < 10; i++) {
        player startforcedfire();
        wait 2;
        player stopforcedfire();
        wait 2;
        current_angles = player getplayerangles();
        player setplayerangles(current_angles + (0, 85, 0));
        wait 1;
        angles = player getplayerangles();
      }

      break;
    }
  }

  player ent_flag_clear("player_soak_active");
}

function private function_9a3fdb73804dcfa9() {
  function_ad698ba26068ea05("Terminating warp_shoot_test");
  level notify("warp_shoot_test_singleton");
}

function private function_65f5363b869f516c() {
  if(getdvarint(@ "hash_58fde8969e4bed86", 0) == 0) {
    return;
  }

  level notify("abort_activity_sweep");
  level endon("abort_activity_sweep");
  level endon("game_ended");
  function_ad698ba26068ea05("Iniitiating activity_sweep_test (ob_soak_test)");
  callback::add("player_damaged", &on_player_damaged);
  callback::add("player_laststand", &on_player_laststand);
  function_af072d6d989b7df4(level.players[0]);
  var_a165f6980e3e577 = namespace_af57321bdeb06a78::function_6a64df48ad4ce4f9();

  while(true) {
    foreach(player in level.players) {
      if(isbot(player)) {
        kick(player getentitynumber());
      }
    }

    if(namespace_af57321bdeb06a78::function_fd8734d232315c9d() == 0) {
      function_ad698ba26068ea05("Aborting activity_sweep_test (ob_soak_test), activity manager not enabled");
      function_6a48443164d8b285();
      return;
    }

    foreach(supportedclass in var_a165f6980e3e577) {
      var_b6d95c655b8e4a0f = namespace_af57321bdeb06a78::function_4a4911b696acc29c(supportedclass);

      if(isDefined(var_b6d95c655b8e4a0f)) {
        activityinstance = namespace_af57321bdeb06a78::function_fa5136406f67c5a5(var_b6d95c655b8e4a0f);

        if(isDefined(activityinstance)) {
          _activity_run(activityinstance, var_b6d95c655b8e4a0f);
        }
      }

      wait 1;
    }
  }
}

function private function_6a48443164d8b285() {
  callback::remove("player_damaged", &on_player_damaged);
  callback::remove("player_laststand", &on_player_laststand);
  level notify("abort_activity_sweep");
}

function private function_2637add8f1942080(activityinstance) {
  switch (activityinstance.type) {
    case #"hash_8868223da7b17525":
      return 30;
    case #"hash_17b1c4f2de901a59":
    case #"hash_5639f68d1b348213":
    case #"hash_b034a4d29df58c9a":
    case #"hash_bcceffcc02978e65":
      return 60;
  }

  return getdvarint(@ "hash_a5704d522027396c", 30);
}

function private function_9786d4a97caa645f(radius) {
  if(!isDefined(radius)) {
    radius = 512;
  }

  level endon("<dev string:x2b4>");
  level endon("<dev string:x2cc>");
  self endon("<dev string:x2da>");
  self notify("<dev string:x2e8>");
  self endon("<dev string:x2e8>");

  while(true) {
    nearby_ai = getaiarrayinradius(self.origin, radius);

    foreach(ai in nearby_ai) {
      ai kill(ai.origin);
    }

    wait 0.5;
  }
}

function private _activity_run(activityinstance, var_b6d95c655b8e4a0f) {
  level endon("abort_activity_sweep");
  function_ad698ba26068ea05("Found Activity (" + var_b6d95c655b8e4a0f.class + ") with name of: " + var_b6d95c655b8e4a0f.name);
  new_origin = getclosestpointonnavmesh(var_b6d95c655b8e4a0f.origins[randomint(var_b6d95c655b8e4a0f.origins.size)]);
  level.players[0] utility::player_prestream_camera(new_origin, 5, level.players[0].angles[1]);

  foreach(player in level.players) {
    player setOrigin(new_origin + (randomintrange(-60, 60), randomintrange(-60, 60), 10));
    function_ad698ba26068ea05("Warping player (" + player.name + ") to location " + new_origin);
  }

  level thread function_865f136049fdf0d1(var_b6d95c655b8e4a0f, activityinstance);
  activitytimeout = function_2637add8f1942080(var_b6d95c655b8e4a0f);
  function_ad698ba26068ea05("Activity (" + var_b6d95c655b8e4a0f.class + ") with name of (" + var_b6d95c655b8e4a0f.name + ") will be active for the next " + activitytimeout + " seconds.");
  waittill_notify_or_timeout("test_activity_completed", activitytimeout);
  function_ad698ba26068ea05("Ending Activity (" + var_b6d95c655b8e4a0f.class + ") with name of: " + var_b6d95c655b8e4a0f.name);
  namespace_98c7625238714297::function_26a02c0ecf9a374([activityinstance]);
  level notify("ob_test_activity_ended");
}

function private function_865f136049fdf0d1(var_b6d95c655b8e4a0f, activityinstance) {
  level notify("_activity_run_type");
  level endon("_activity_run_type");
  level endon("ob_test_activity_ended");
  level endon("abort_activity_sweep");
  waitframe();
  function_ad698ba26068ea05("Starting Activity (" + var_b6d95c655b8e4a0f.class + ") variant tag:" + activityinstance.varianttag);

  switch (var_b6d95c655b8e4a0f.type) {
    case #"hash_17b1c4f2de901a59":
      level thread function_bcf6d6ab3719478e(activityinstance, var_b6d95c655b8e4a0f);
      break;
    case #"hash_bcceffcc02978e65":
      level thread function_8bf670784bc9f103(activityinstance, var_b6d95c655b8e4a0f);
      break;
    case #"hash_5639f68d1b348213":
    case #"hash_b034a4d29df58c9a":
      level thread function_ebd46f9e0f9a9bc(activityinstance, var_b6d95c655b8e4a0f);
      break;
    case #"hash_8868223da7b17525":
      level thread function_21393886aa794bf3(activityinstance, var_b6d95c655b8e4a0f);
      break;
    case #"hash_18347fa7b15eb832":
    case #"hash_2839d15859ec95fb":
    case #"hash_2ccdb15df9009096":
    case #"hash_2f4998a4a5760392":
    case #"hash_40d422a1ae5ecf0f":
    case #"hash_427820bb3395e2bf":
    case #"hash_5191681fd986c4eb":
    case #"hash_5253ef0f4683b778":
    case #"hash_5aec85630f3886be":
    case #"hash_6cf9b195bc4324c6":
    case #"hash_76bc11857d0dbf4c":
    case #"hash_80393f08d5a43d76":
    case #"hash_84c8d0e39c86ae55":
    case #"hash_87fc920520ec2075":
    case #"hash_93ac930eae20dc0":
    case #"hash_8a15cfdbf463e060":
    case #"hash_a9427160c391d79d":
    case #"hash_113756c907deb5be":
    case #"hash_bc2e36acd99d4454":
    case #"hash_15c4973fd9fe46c4":
    case #"hash_bfe91a2e65bea028":
    case #"hash_c66a776a8125106c":
    case #"hash_cf18a80d017267ca":
    case #"hash_cf6a24d2fd4c1930":
    case #"hash_df1adaaaad94657b":
    case #"hash_f0f77ef6300b1970":
    case #"hash_f3614d8cc5575a83":
    case #"hash_f4c3ae9ba5e649bb":
    default:
      foreach(player in level.players) {
        player thread function_9786d4a97caa645f();
      }

      break;
  }
}

function private function_8bf670784bc9f103(activityinstance, var_b6d95c655b8e4a0f) {
  level endon("game_ended");
  level endon("ob_test_activity_ended");
  level endon("abort_activity_sweep");
  player = level.players[0];

  if(!isDefined(player)) {
    level notify("test_activity_completed");
    return;
  }

  while(!isDefined(activityinstance.safe)) {
    wait 1;
  }

  new_origin = getclosestpointonnavmesh(activityinstance.safe.origin + (randomintrange(-60, 60), randomintrange(-60, 60), 10));
  player setOrigin(new_origin);
  function_ad698ba26068ea05("Warping player (" + player.name + ") to weapon st stash at location " + new_origin);
  wait 3;
  activityinstance.safe notify("safe_unlocked");
  wait 3;
  level notify("test_activity_completed");
}

function private function_ebd46f9e0f9a9bc(activityinstance, var_b6d95c655b8e4a0f) {
  level endon("game_ended");
  level endon("ob_test_activity_ended");
  level endon("abort_activity_sweep");
  player = level.players[0];

  if(!isDefined(player)) {
    return;
  }

  player endon("disconnect");
  defend_objective = activityinstance.var_209424e196b67f71;
  anchor = getclosestpointonnavmesh(defend_objective.origin);
  player setOrigin(anchor + (randomintrange(-60, 60), randomintrange(-60, 60), 10));
  player thread function_9786d4a97caa645f(1024);
  function_ad698ba26068ea05("Setting position of player (" + player.name + ") to defend location " + anchor + " for object: " + defend_objective.targetname);

  while(isDefined(player)) {
    wait 1;
  }

  level notify("test_activity_completed");
}

function private function_bcf6d6ab3719478e(activityinstance, var_b6d95c655b8e4a0f) {
  level endon("game_ended");
  level endon("ob_test_activity_ended");
  level endon("abort_activity_sweep");
  wait 1;
  level notify("test_activity_completed");
}

function private function_21393886aa794bf3(activityinstance, var_b6d95c655b8e4a0f) {
  level endon("game_ended");
  level endon("ob_test_activity_ended");
  level endon("abort_activity_sweep");
  player = level.players[0];

  if(!isDefined(player)) {
    return;
  }

  keynames = ["<dev string:x304>", "<dev string:x30d>", "<dev string:x34a>", "<dev string:x387>", "<dev string:x3c6>", "<dev string:x406>"];
  wait 1;
  activityinstance thread namespace_47d96238dd467828::function_1459744b58026a21(keynames[randomint(keynames.size)], player);
}

function private on_player_laststand(params) {
  if(isPlayer(self)) {}
}

function private on_player_damaged(params) {
  newhealth = self.health - params.damage;
  healthfloor = int(self.maxhealth * 0.75);

  if(newhealth <= healthfloor) {
    params.damage = 0;
    self.health = self.maxhealth;
  }
}