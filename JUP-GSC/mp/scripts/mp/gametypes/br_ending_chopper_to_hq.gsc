/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_ending_chopper_to_hq.gsc
***************************************************************/

#using script_62c595d55b88b26;
#using script_930a1e7bd882c1d;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\ui;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_ending;
#using scripts\mp\gametypes\br_ending_util;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;
#namespace br_ending_chopper_to_hq;

function chopperhqexfil_init() {
  setdevdvarifuninitialized(@ "hash_70809e88d9881104", 0);

  namespace_ab7fb53f62c7ae2e::function_dd857d7c2bd2f1bd();
  accolades_init();
  level.var_79c116f876dc27eb = &function_776f66e2e3d58aa7;
  level._effect["player_disconnect"] = loadfx("vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx");
  game["dialog"]["exfil_a_inbound_now"] = "xfil_grav_bsua";
  game["dialog"]["exfil_a_shadow1_inbound"] = "xfil_grav_bsub";
  game["dialog"]["exfil_a_extraction_inbound"] = "xfil_grav_bsuc";
}

function function_5bd3dfcb7c6dcce3(accolade, startfunc) {
  if(!isDefined(level.var_d8416adf5908f7b8)) {
    level.var_d8416adf5908f7b8 = [];
  }

  level.var_d8416adf5908f7b8[accolade] = startfunc;
}

function function_776f66e2e3d58aa7(winnerplayers, var_f7b694a4edf7dc9a) {
  thread function_9ade01856c32e00c(winnerplayers, var_f7b694a4edf7dc9a);
}

function private function_9ade01856c32e00c(winners, var_cbfc3ba10cefc8ce, movetime) {
  snd_transient_load("mp_gamemode_br_exfils_jup");
  clearmusicstate();
  wait 1;
  function_4e8ba327eb12540c(level.players, "mute_ambience_elements_emitters", 12);
}

function function_c0c06942d2085413(var_cbfc3ba10cefc8ce) {
  level.var_cc780086b56ca17 = self;
  sceneent = getEnt("infil_exfil_hq_origin", "targetname");

  if(!isDefined(sceneent)) {
    sceneent = spawnStruct();
    sceneent.origin = (0, 0, 0);
    sceneent.angles = (0, 0, 0);
  }

  winningteam = self.winners[0].team;
  var_8740420879100bee = spawnStruct();
  var_8740420879100bee.origin = self.origin;
  var_8740420879100bee.angles = self.angles;
  var_8740420879100bee scene::set_scriptbundle("jup_wz_exfil_a_scene");
  var_dda93b45a16fcdee = var_8740420879100bee scene::function_8a37fe423de2b9db();
  scene::add_scene_func(var_8740420879100bee, &function_78a0aed888196a36, var_dda93b45a16fcdee[0]);
  scene::add_scene_func(var_8740420879100bee, &function_488ede35fad91068, var_dda93b45a16fcdee[var_dda93b45a16fcdee.size - 1]);
  self.var_8740420879100bee = var_8740420879100bee;
  var_f4dbb9e4fefbf277 = isDefined(level.arrow) && istrue(level.arrow.defused);

  var_f4dbb9e4fefbf277 = var_f4dbb9e4fefbf277 || getdvarint(@ "hash_8e018b077a7ff49c", 0);

  var_3ac645baaf9e0cb = spawnStruct();
  var_3ac645baaf9e0cb.origin = sceneent.origin;
  var_3ac645baaf9e0cb.angles = sceneent.angles;

  if(!var_f4dbb9e4fefbf277 || !getdvarint(@ "hash_a7e71848f1ce587b", 1)) {
    var_3ac645baaf9e0cb scene::set_scriptbundle("jup_wz_exfil_b_scene");
    var_3ac645baaf9e0cb.randomizedshots = function_235edea6ee22bab3();
  } else {
    var_3ac645baaf9e0cb scene::set_scriptbundle("jup_wz_exfil_b_scene_cq");
    var_3ac645baaf9e0cb.randomizedshots = function_93b66df7957f429();
  }

  scene::add_scene_func(var_3ac645baaf9e0cb, &function_e4e5c7788f122acc, var_3ac645baaf9e0cb.randomizedshots[0]);
  scene::add_scene_func(var_3ac645baaf9e0cb, &function_a85a080d6669ac2f, var_3ac645baaf9e0cb.randomizedshots[var_3ac645baaf9e0cb.randomizedshots.size - 1]);
  self.var_3ac645baaf9e0cb = var_3ac645baaf9e0cb;
  var_299f8159a7635889 = spawnStruct();
  var_299f8159a7635889.origin = sceneent.origin;
  var_299f8159a7635889.angles = sceneent.angles;
  var_299f8159a7635889 scene::set_scriptbundle("jup_wz_aar_ar_scene");
  self.var_299f8159a7635889 = var_299f8159a7635889;

  if(!isDefined(var_cbfc3ba10cefc8ce)) {
    var_cbfc3ba10cefc8ce = (0, 0, 0);
  }

  setomnvarforallclients("ui_br_infil_exfil_player_focus", -1);

  if(!getdvarint(@ "hash_19a406e3c51ce52f")) {
    self.transientname = function_2023eb5589c72085();
    loadinfiltransient(self.transientname);
    level thread function_3681a4700f5bb7c1(2, 1.2, "exfil_fadeEnd");

    for(var_24b79087f3897e94 = 0; !var_24b79087f3897e94; var_24b79087f3897e94 = isinfiltransientloaded(self.transientname)) {
      waitframe();
    }
  }

  scripts\mp\gametypes\br_circle::hidedangercircle();
  self.winners = array_removeundefined(self.winners);

  if(var_f4dbb9e4fefbf277 && getdvarint(@ "hash_d869103c6c12e13a", 1)) {
    foreach(player in level.players) {
      if(player.team != winningteam) {
        player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
      }
    }
  }

  foreach(player in self.winners) {
    animname = "player" + player getentitynumber();
    player.animname = animname;
    player.brexfilanimname = animname;
  }

  if(getdvarint(@ "hash_70809e88d9881104", 0)) {
    self.winners = [];
  }

  if(self.winners.size == 0) {
    create_disconnectplayer(self);
  }

  self.var_8740420879100bee scene::function_2136d6e5467c6caf(max(1, level.var_285f57f09913c9e6));
  self.var_3ac645baaf9e0cb scene::function_2136d6e5467c6caf(max(1, level.var_285f57f09913c9e6));
  self.var_299f8159a7635889 scene::function_2136d6e5467c6caf(max(1, level.var_285f57f09913c9e6));
  var_7fa848e5b3bbc437 = getdvarint(@ "hash_cf55e0f95935f5af", 1);

  if(getdvarint(@ "hash_19a406e3c51ce52f") || getdvarint(@ "hash_2d200a3da7fb2518")) {
    var_7fa848e5b3bbc437 = 0;
  }

  var_807fea2fc7e90adc = undefined;
  var_d980f6395ec61106 = getDvar(@ "hash_ad33abd04b38d2fa", "");
  var_d980f5395ec60ed3 = getDvar(@ "hash_ad33aad04b38d0c7", "");
  var_d980f4395ec60ca0 = getDvar(@ "hash_ad33a9d04b38ce94", "");
  var_d980fb395ec61c05 = getDvar(@ "hash_ad33a8d04b38cc61", "");
  var_d980fa395ec619d2 = getDvar(@ "hash_ad33a7d04b38ca2e", "");
  var_d980f9395ec6179f = getDvar(@ "hash_ad33a6d04b38c7fb", "");

  if(var_d980f6395ec61106 != "" || var_d980f5395ec60ed3 != "" || var_d980f4395ec60ca0 != "" || var_d980fb395ec61c05 != "" || var_d980fa395ec619d2 != "" || var_d980f9395ec6179f != "") {
    var_807fea2fc7e90adc = [];
    var_807fea2fc7e90adc[0] = var_d980f6395ec61106;
    var_807fea2fc7e90adc[1] = var_d980f5395ec60ed3;
    var_807fea2fc7e90adc[2] = var_d980f4395ec60ca0;
    var_807fea2fc7e90adc[3] = var_d980fb395ec61c05;
    var_807fea2fc7e90adc[4] = var_d980fa395ec619d2;
    var_807fea2fc7e90adc[5] = var_d980f9395ec6179f;
  }

  namespace_ab7fb53f62c7ae2e::function_74497a0f417e329f(self.winners);
  scripts\mp\gametypes\br_ending::function_226b83f846d32ff2(self.winners);
  namespace_ab7fb53f62c7ae2e::function_5864d7eeac0e9ac(self.winners, var_7fa848e5b3bbc437, var_807fea2fc7e90adc);
}

function function_78a0aed888196a36() {
  function_fd28a78c72cc942b();
}

function private function_fd28a78c72cc942b() {
  sceneroot = self;
  harnesses = function_26beb46813cf3ccb(sceneroot);

  foreach(harness in harnesses) {
    harness hide();
  }

  ropes = function_c3ceff8ef7715628(sceneroot);

  foreach(rope in ropes) {
    rope hide();
  }

  for(playeridx = 0; playeridx < max(1, level.var_285f57f09913c9e6); playeridx++) {
    if(isDefined(harnesses[playeridx])) {
      harnesses[playeridx] show();
    }

    if(isDefined(ropes[playeridx])) {
      ropes[playeridx] show();
    }
  }
}

function private function_26beb46813cf3ccb(sceneroot) {
  harnesses = [];

  for(i = 1; i <= 6; i++) {
    var_76c1f43057b9102c = "Harness 0" + i;
    harnesses[harnesses.size] = sceneroot scene::get_entity(var_76c1f43057b9102c);
  }

  return harnesses;
}

function private function_c3ceff8ef7715628(sceneroot) {
  ropes = [];

  for(i = 1; i <= 6; i++) {
    ropename = "Rope 0" + i;
    ropes[ropes.size] = sceneroot scene::get_entity(ropename);
  }

  return ropes;
}

function private function_235edea6ee22bab3() {
  shotslist = ["shot_010", "shot_020", "shot_030", "shot_040", "shot_050"];
  var_9e9d94263cf344d3 = [" A", " B", " C"];
  introvariation = var_9e9d94263cf344d3[randomint(3)];
  outrovariation = var_9e9d94263cf344d3[randomint(3)];

  shotorder = getDvar(@ "hash_198a3621e730d4b5", "<dev string:x1c>");

  if(shotorder != "<dev string:x1c>") {
    introvariation = "<dev string:x20>" + shotorder[0];
    outrovariation = "<dev string:x20>" + shotorder[1];
  }

  shotslist[0] += introvariation;
  shotslist[1] += introvariation;
  shotslist[2] += introvariation;
  shotslist[3] += outrovariation;
  shotslist[4] += outrovariation;
  return shotslist;
}

function private function_93b66df7957f429(var_acd6e67641545f5a) {
  shotslist = ["shot_010", "shot_020", "shot_030", "shot_040", "shot_050"];
  var_9e9d94263cf344d3 = [" C", " D"];
  variation = var_9e9d94263cf344d3[randomint(2)];

  shot = getDvar(@ "hash_6e6b30dcd38ed28f", "<dev string:x1c>");

  if(shot != "<dev string:x1c>") {
    variation = "<dev string:x20>" + shot;
  }

  shotslist[0] += variation;
  shotslist[1] += variation;
  shotslist[2] += variation;
  shotslist[3] += variation;
  shotslist[4] += variation;
  return shotslist;
}

function function_488ede35fad91068() {
  var_3ac645baaf9e0cb = level.var_cc780086b56ca17.var_3ac645baaf9e0cb;
  var_3ac645baaf9e0cb scene::pre_stream(level.var_cc780086b56ca17.winners);
  var_b8829b834109780b = 0;
  fade_in_time = 0;
  fade_out_time = 0.25;
  shots = scene::function_8a37fe423de2b9db();
  shotlength = scene::function_d9be975d8d1c9db3(shots[shots.size - 1]);
  waittime = max(0, shotlength - var_b8829b834109780b);
  wait waittime;
  function_c300d34e34164b6d(fade_in_time, 3.33, fade_out_time);
}

function function_a85a080d6669ac2f() {
  fade_in_time = 0.15;
  fade_out_time = 0.25;
  shots = scene::function_8a37fe423de2b9db();
  shotlength = scene::function_d9be975d8d1c9db3(shots[shots.size - 1]);
  waittime = max(0, shotlength - fade_in_time - 0.6375);
  wait waittime;
  function_c300d34e34164b6d(fade_in_time, 0.85, fade_out_time);
}

function function_e4e5c7788f122acc() {
  sceneentities = scene::get_entities();

  foreach(entity in sceneentities) {
    if(isDefined(entity)) {
      entity forcenetfieldhighlod(1);
    }
  }
}

function function_7524f2eb69c7509d() {
  fade_in_time = 0.15;
  fade_out_time = 0.15;
  shots = scene::function_8a37fe423de2b9db();
  shotlength = scene::function_d9be975d8d1c9db3(shots[shots.size - 1]);
  waittime = max(0, shotlength - 0.3);
  wait waittime;
  function_c300d34e34164b6d(fade_in_time, 0.3, fade_out_time);
}

function function_fec0e84f57eef429() {
  fade_in_time = 0.15;
  fade_out_time = 0.75;
  shots = scene::function_8a37fe423de2b9db();
  shotlength = scene::function_d9be975d8d1c9db3(shots[shots.size - 1]);
  waittime = max(0, shotlength - 0.3);
  wait waittime;
  function_c300d34e34164b6d(fade_in_time, 0.3, fade_out_time);
}

function function_5396a4248f68364() {
  if(istrue(self.istemp)) {
    function_1e13be59a6d24c33();
    return;
  }

  function_1e13be59a6d24c33();
  function_91277d2b844973c8();
  function_3ff1da3583824ebe();
  function_8a4241a18c791441();

  foreach(player in level.players) {
    player clearpredictedstreampos();
  }
}

function private function_1e13be59a6d24c33() {
  function_4e8ba327eb12540c(level.players, "jup_br_exfil_a_igc", 0.75);
  self.var_8740420879100bee scene::pre_stream(self.winners);
  wait 0.75;
  level notify("exfil_fadeEnd");

  if(istrue(self.istemp)) {
    thread function_327d687c7f00c05d();
  }

  setomnvarforallclients("ui_br_infil_exfil_player_focus", -2);

  foreach(player in level.players) {
    player function_451319f93d30ebe5(%"hash_6672d428dc04ad44");
  }

  level thread function_2551574cc8e210ee(self.winners);
  level thread function_b4a1bd54c864d01e();
  self.var_8740420879100bee scene::play(self.winners);

  if(istrue(self.istemp)) {
    self notify("<dev string:x25>");

    foreach(player in level.players) {
      player clearpredictedstreampos();
    }
  }

}

function private function_91277d2b844973c8() {
  namespace_81156089ff1fe819::function_42f1462f1d4193af("exfil_light");

  foreach(player in level.players) {
    player function_451319f93d30ebe5(%"hash_34c59bed7392d266");
  }

  visionset = "mp_jup_bigmap_wz2_exfil";
  _visionsetnaked(visionset, 0);
  level thread function_72abe688101ab2a7();

  if(isDefined(self.var_3ac645baaf9e0cb.randomizedshots)) {
    self.var_3ac645baaf9e0cb scene::play(self.winners, self.var_3ac645baaf9e0cb.randomizedshots);
    return;
  }

  self.var_3ac645baaf9e0cb scene::play(self.winners);
}

function private function_3ff1da3583824ebe() {
  namespace_81156089ff1fe819::function_42f1462f1d4193af("accolade_light");
  var_be03fff7402b13b3 = undefined;
  var_d66b567786c9b10e = 0;
  var_2a10ef4f01bb1116 = [];

  foreach(var_16a81c74ce61860e in level.var_6b11625abe5346b0) {
    if(isDefined(var_16a81c74ce61860e.player)) {
      var_2a10ef4f01bb1116[var_2a10ef4f01bb1116.size] = var_16a81c74ce61860e;
    }
  }

  level.var_6b11625abe5346b0 = var_2a10ef4f01bb1116;

  foreach(var_16a81c74ce61860e in level.var_6b11625abe5346b0) {
    var_b37316fae4667b00 = var_16a81c74ce61860e.ref;
    player = var_16a81c74ce61860e.player;

    if(isDefined(var_be03fff7402b13b3) && var_be03fff7402b13b3 == var_b37316fae4667b00) {
      self.var_3ac645baaf9e0cb scene::cleanup();
    }

    var_1384d9221443f717 = level.var_bcf7be5c24905ab9[var_b37316fae4667b00];
    assertex(isDefined(var_1384d9221443f717), "<dev string:x3d>" + var_b37316fae4667b00 + "<dev string:x4e>");
    self.var_3ac645baaf9e0cb scene::set_scriptbundle(var_1384d9221443f717.scenename);

    if(var_d66b567786c9b10e == level.var_6b11625abe5346b0.size - 1) {
      shotnames = self.var_3ac645baaf9e0cb scene::function_8a37fe423de2b9db();
      scene::add_scene_func(self.var_3ac645baaf9e0cb, &function_e4e5c7788f122acc, shotnames[0]);
      scene::add_scene_func(self.var_3ac645baaf9e0cb, &function_fec0e84f57eef429, shotnames[shotnames.size - 1]);
      function_e395443832372863(self.var_3ac645baaf9e0cb);
    } else {
      shotnames = self.var_3ac645baaf9e0cb scene::function_8a37fe423de2b9db();
      scene::add_scene_func(self.var_3ac645baaf9e0cb, &function_e4e5c7788f122acc, shotnames[0]);
      scene::add_scene_func(self.var_3ac645baaf9e0cb, &function_7524f2eb69c7509d, shotnames[shotnames.size - 1]);
    }

    if(isDefined(level.var_d8416adf5908f7b8[var_16a81c74ce61860e.ref])) {
      level thread[[level.var_d8416adf5908f7b8[var_16a81c74ce61860e.ref]]](var_16a81c74ce61860e);
    }

    function_7e7e37848a8230ba(self.winners, player);
    self.var_3ac645baaf9e0cb scene::play([player]);
    var_d66b567786c9b10e++;
    var_be03fff7402b13b3 = var_b37316fae4667b00;
  }
}

function private function_8a4241a18c791441() {
  foreach(player in self.winners) {
    if(!isDefined(player) || isbot(player)) {
      continue;
    }

    player scripts\mp\gametypes\br_ending::player_equipment_use_stop();
    player thread scripts\mp\gametypes\br_ending::player_set_weapon();
  }

  outrofunc();
  function_65753b3e1905c075(self.winners);
  thread function_878fde0a59a3cb9d();
  delaythread(1, &function_7acde5feb50c98f2, level.players, "uin_jup_br_aar_placement_badge_slam");
  self.var_299f8159a7635889 scene::play(self.winners);
  function_2d3425695113e32b();
}

function private function_327d687c7f00c05d() {
  self waittill("<dev string:x25>");

  if(self.var_8740420879100bee scene::get_state() == "<dev string:x65>") {
    self.var_8740420879100bee scene::stop();
  }
}

function private function_878fde0a59a3cb9d() {
  level waittill("br_ending_skip_scene");

  if(self.var_299f8159a7635889 scene::get_state() == "Playing") {
    self.var_299f8159a7635889 scene::stop();
  }
}

function private function_7e7e37848a8230ba(winners, var_9ba8618891167a35) {
  foreach(player in winners) {
    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(var_9ba8618891167a35) && player == var_9ba8618891167a35) {
      continue;
    }

    player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
    player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_ending_chopper_to_hq::refreshPlayersVisibility()");
  }

  if(isDefined(var_9ba8618891167a35)) {
    var_9ba8618891167a35 scripts\cp_mp\utility\player_utility::function_6fb380927695ee76(1);
  }
}

function private function_65753b3e1905c075(winners) {
  foreach(player in winners) {
    if(!isDefined(player)) {
      continue;
    }

    player playershow();
  }
}

function private function_795c64584625d13b() {
  randomoptions = ["exfil_a_inbound_now", "exfil_a_shadow1_inbound", "exfil_a_extraction_inbound"];
  waittimes = [1.4, 1.033, 1.433];
  choice = randomint(randomoptions.size);
  scripts\mp\gametypes\br_public::brleaderdialog(randomoptions[choice], 0, level.players, 1, waittimes[choice], undefined, "dx_br_jpbm_");
}

function function_2551574cc8e210ee(winners) {
  var_d39eb0d89e4b241f = 7;
  winners = default_to(winners, []);
  var_c5d4ae74fe20f862 = min(winners.size, var_d39eb0d89e4b241f);
  assertex(winners.size >= 0 && winners.size <= 7, "<dev string:x70>");
  musicstate = function_17ee301cf0b5ba85("br_exfil_intro1");
  musicstate_classic = function_17ee301cf0b5ba85("br_exfil_intro1_classic");

  if(var_c5d4ae74fe20f862 > 0) {
    musicset = "br_exfil_intro" + var_c5d4ae74fe20f862;
    musicstate = function_17ee301cf0b5ba85(musicset);
    musicstate_classic = function_17ee301cf0b5ba85(musicset + "_classic");
  }

  function_fe75a89529dd0fd0(level.players, musicstate, undefined, undefined, musicstate_classic);
  wait 3;
  function_4e8ba327eb12540c(level.players, "mute_music", 2, 0.369043);
  wait 10;
  function_c79f9300ee85f805(level.players, "mute_music", 7);
}

function function_b4a1bd54c864d01e() {
  thread function_795c64584625d13b();
  function_c79f9300ee85f805(level.players, "mute_ambience_elements_emitters", 2.4);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfil_a_skyhook_plane_approach_lr");
  wait 6.5;
  function_4e8ba327eb12540c(level.players, "mute_ambience_elements_emitters", 0.1);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfil_a_skyhook_plane_flyby_lr");
  wait 2.6;
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfil_a_skyhook_rope_snag");
  wait 0.9;
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfil_a_skyhook_plane_jetwash_lr");
  wait 1;
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfil_a_transition_stinger_lr");
}

function function_72abe688101ab2a7() {
  function_c79f9300ee85f805(level.players, "jup_br_exfil_a_igc", 3);
  function_4e8ba327eb12540c(level.players, "jup_br_exfil_b_igc", 3);
  function_a408e30ca85e03a9(level.players, "mp_jup_br_exfil_b", 1);
  wait 3;
  function_c79f9300ee85f805(level.players, "mute_ambience_elements_emitters", 3);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfil_b_sh010_walla");
}

function function_e395443832372863(var_782d6f9d9f6342d) {
  var_94251af069be7d8 = 0;

  if(isDefined(var_782d6f9d9f6342d)) {
    shots = var_782d6f9d9f6342d scene::function_8a37fe423de2b9db();

    foreach(shotname in shots) {
      var_94251af069be7d8 += var_782d6f9d9f6342d scene::function_d9be975d8d1c9db3(shotname);
    }
  }

  var_94251af069be7d8 -= mod(var_94251af069be7d8, 0.05);
  level thread function_42f6e3ede94bfa29(var_94251af069be7d8);
}

function function_42f6e3ede94bfa29(var_86ef029e00d906fe) {
  var_86ef029e00d906fe = default_to(var_86ef029e00d906fe, 0);

  if(var_86ef029e00d906fe > 1.5) {
    waittime = var_86ef029e00d906fe - 1.5;
    wait waittime;
  }

  function_7acde5feb50c98f2(level.players, "uin_jup_br_aar_transition_slam_lr");
  function_4e8ba327eb12540c(level.players, "mute_ambience_elements_emitters", 4, 0.683772);
  delaythread(4, &function_4e8ba327eb12540c, level.players, "mute_ambience", 6, 1);
  delaythread(12.05, &function_326e5ed05234a4f0, level.players, 3);
  wait 0.05;
  clearmusicstate();
}

function function_4d471b771b1ff7e8() {
  level waittill("br_credits_complete");
  delaytime = getdvarfloat(@ "hash_c88b807ea15b731f", 0);
  fadedowntime = getdvarfloat(@ "hash_a1ceffe4417264d1", 1);
  var_95a318d022e623a7 = getdvarfloat(@ "hash_c9f5c9db0c714fae", 2.5);
  var_1bb7594c18d17443 = getdvarfloat(@ "hash_4633bce56a15979a", 1);

  if(delaytime > 0) {
    wait delaytime;
  }

  level.var_9b73afbde2775159 = 1;
  level thread function_c300d34e34164b6d(fadedowntime, var_95a318d022e623a7, var_1bb7594c18d17443);

  if(fadedowntime > 0) {
    wait fadedowntime;
  }

  level notify("br_ending_skip_scene");
}

function function_c63452ae16fa9df1(val) {
  level notify("br_credits_complete");
}

function outrofunc() {
  if(!scripts\mp\gametypes\br_public::isanytutorialorbotpracticematch()) {
    setomnvarforallclients("post_game_state", 14);
    setomnvarforallclients("ui_br_end_game_splash_type", 17);
  }

  level scripts\common\ui::lui_registercallback("br_credits_complete", &function_c63452ae16fa9df1);
  level thread function_4d471b771b1ff7e8();
}

function function_2d3425695113e32b() {
  if(getdvarint(@ "hash_b44ba42bba42b79e", 1)) {
    foreach(player in level.players) {
      player clearpredictedstreampos();
    }
  }

  _visionsetnaked("", 0);

  foreach(player in level.players) {
    player function_df8fad503896462(%"hash_34c59bed7392d266");
    player function_df8fad503896462(%"hash_6672d428dc04ad44");
  }

  if(!istrue(level.var_9b73afbde2775159)) {
    level thread function_c300d34e34164b6d(undefined, 2, 1);
  }

  level.var_9b73afbde2775159 = undefined;
  level thread function_c4ebe940e6d84d42();
}

function function_c4ebe940e6d84d42() {
  wait 60;
  soundbank = "mp_gamemode_br_exfils_jup";

  if(scripts\engine\utility::issharedfuncdefined("br_ending_chopper_to_hq", "getExfilSoundbank")) {
    soundbank = [[scripts\engine\utility::getsharedfunc("br_ending_chopper_to_hq", "getExfilSoundbank")]]();
  }

  snd_transient_unload(soundbank);
}

function accolades_init() {
  function_5bd3dfcb7c6dcce3("assassin", &function_dfdae612c1b74e7d);
  function_5bd3dfcb7c6dcce3("assists", &function_5e896530bebc3e6e);
  function_5bd3dfcb7c6dcce3("bigguns", &function_a10a208251957df);
  function_5bd3dfcb7c6dcce3("breacher", &function_36faf3d5c9fbebe6);
  function_5bd3dfcb7c6dcce3("commando", &function_899d5e24a4b9301e);
  function_5bd3dfcb7c6dcce3("deadweight", &function_ece133611317bd82);
  function_5bd3dfcb7c6dcce3("ghost", &function_8ccb94b37d6fe8c1);
  function_5bd3dfcb7c6dcce3("highachiever_cool", &function_3e55bcf9ca7328a3);
  function_5bd3dfcb7c6dcce3("highachiever_cooler", &function_b0eda2cf30fc9f14);
  function_5bd3dfcb7c6dcce3("highachiever_coolest", &function_724c8ab1fac0e71b);
  function_5bd3dfcb7c6dcce3("immortal", &function_a557921894e6c5dd);
  function_5bd3dfcb7c6dcce3("interrogator", &function_67017685dd320c5e);
  function_5bd3dfcb7c6dcce3("killer", &function_94299e7e4ca6d8d3);
  function_5bd3dfcb7c6dcce3("machinist", &function_4bd40ca7e3ca4514);
  function_5bd3dfcb7c6dcce3("marksman", &function_c8bcfd7749815dda);
  function_5bd3dfcb7c6dcce3("medalist_cool", &function_86f5a2ce998d8295);
  function_5bd3dfcb7c6dcce3("medalist_cooler", &function_f73a279a135b21e2);
  function_5bd3dfcb7c6dcce3("medalist_coolest", &function_48333192d309fec5);
  function_5bd3dfcb7c6dcce3("medic", &function_5cf4647b98e8f7b8);
  function_5bd3dfcb7c6dcce3("moneybags", &function_3db025ace93c7d35);
  function_5bd3dfcb7c6dcce3("pacifist", &function_bfeb55dd644c2525);
  function_5bd3dfcb7c6dcce3("pyro", &function_fcda569d8f93b5f4);
  function_5bd3dfcb7c6dcce3("scavenger", &function_8e9cf76d9c196732);
  function_5bd3dfcb7c6dcce3("scout", &function_ef2a4a9117f93ef4);
  function_5bd3dfcb7c6dcce3("sniper", &function_fc64dfcb9fc83a3f);
  function_5bd3dfcb7c6dcce3("supplier", &function_847f2cd68ddcb2f0);
  function_5bd3dfcb7c6dcce3("survivor", &function_39d31dc79c2c3236);
  function_5bd3dfcb7c6dcce3("teamobjectives", &function_41b707de8e8441b5);
  function_5bd3dfcb7c6dcce3("trapper", &function_ee2ea98cac37a0b8);
  function_5bd3dfcb7c6dcce3("tryhard_cool", &function_904baa6156cb1880);
  function_5bd3dfcb7c6dcce3("tryhard_cooler", &function_511de7706207469b);
  function_5bd3dfcb7c6dcce3("tryhard_coolest", &function_92a6c88a671ffa1a);
  function_5bd3dfcb7c6dcce3("weakestlink", &function_299389de1323fa26);
}

function function_2023eb5589c72085() {
  switch (level.script) {
    case #"hash_3ebe34631513de1d":
      return "mp_infil_br_jup_mech_ending_tr";
    case #"hash_aeddd44c5b27b2d":
    case #"hash_bce1a7274538a78":
    case #"hash_73e90c896fdaebc3":
      return "mp_infil_br_jup_wz2_ending_tr";
    case #"hash_da8f14763f037922":
      return "mp_infil_br_jup_sm_island_2_wz2_ending_tr";
  }

  return "";
}

function function_dfdae612c1b74e7d(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_assassin");
}

function function_5e896530bebc3e6e(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_assists");
}

function function_a10a208251957df(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_bigguns");
}

function function_36faf3d5c9fbebe6(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_breacher");
}

function function_899d5e24a4b9301e(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_commando");
}

function function_ece133611317bd82(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_deadweight");
}

function function_8ccb94b37d6fe8c1(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_ghost");
}

function function_3e55bcf9ca7328a3(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_highachiever_cool");
}

function function_b0eda2cf30fc9f14(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_highachiever_cooler");
}

function function_724c8ab1fac0e71b(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_highachiever_coolest");
}

function function_a557921894e6c5dd(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_immortal");
}

function function_67017685dd320c5e(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_interrogator");
}

function function_94299e7e4ca6d8d3(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_killer");
}

function function_4bd40ca7e3ca4514(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_machinist");
}

function function_c8bcfd7749815dda(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_marksman");
}

function function_86f5a2ce998d8295(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_medalist_cool");
}

function function_f73a279a135b21e2(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_medalist_cooler");
}

function function_48333192d309fec5(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_medalist_coolest");
}

function function_5cf4647b98e8f7b8(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_medic");
}

function function_3db025ace93c7d35(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_moneybags");
}

function function_bfeb55dd644c2525(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_pacifist");
}

function function_fcda569d8f93b5f4(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_pyro");
}

function function_8e9cf76d9c196732(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_scavenger");
}

function function_ef2a4a9117f93ef4(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_scout");
}

function function_fc64dfcb9fc83a3f(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_sniper");
}

function function_847f2cd68ddcb2f0(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_supplier");
}

function function_39d31dc79c2c3236(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_survivor");
}

function function_41b707de8e8441b5(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_team_objectives");
}

function function_ee2ea98cac37a0b8(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_trapper");
}

function function_904baa6156cb1880(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_tryhard_cool");
}

function function_511de7706207469b(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_tryhard_cooler");
}

function function_92a6c88a671ffa1a(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_tryhard_coolest");
}

function function_299389de1323fa26(var_16a81c74ce61860e) {
  function_734a8512ebf4e928(var_16a81c74ce61860e.ref, var_16a81c74ce61860e.player);
  function_7acde5feb50c98f2(level.players, "scn_jup_br_exfl_accolade_weakestlink");
}

function private function_734a8512ebf4e928(var_b37316fae4667b00, var_5a4f63372f6a484d) {
  var_caa2afb2cdcb7815 = level.var_e3fca817c22e740d[var_b37316fae4667b00];
  var_56c090a52d545d89 = 0;

  if(isDefined(var_5a4f63372f6a484d) && isDefined(var_5a4f63372f6a484d.var_f090ccb984435bbc)) {
    var_caa2afb2cdcb7815 = level.var_e3fca817c22e740d[var_5a4f63372f6a484d.var_f090ccb984435bbc];
    var_56c090a52d545d89 = int(var_5a4f63372f6a484d.var_5e71ee49d0cc6534);
  }

  assert(isDefined(var_caa2afb2cdcb7815));
  assert(var_caa2afb2cdcb7815 >= 0 && var_caa2afb2cdcb7815 < 256);
  var_c7df9d76114d30f4 = 0;

  if(isDefined(var_5a4f63372f6a484d)) {
    var_c7df9d76114d30f4 = var_5a4f63372f6a484d getentitynumber();
  }

  assert(var_c7df9d76114d30f4 >= 0 && var_c7df9d76114d30f4 < 256);
  omnvarvalue = var_c7df9d76114d30f4;
  omnvarvalue |= var_caa2afb2cdcb7815 << 8;

  if(var_56c090a52d545d89 != 0) {
    omnvarvalue |= var_56c090a52d545d89 << 16;
  }

  setomnvarforallclients("ui_br_infil_exfil_player_focus", omnvarvalue);
}