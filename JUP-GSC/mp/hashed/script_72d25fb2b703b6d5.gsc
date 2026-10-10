/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_72d25fb2b703b6d5.gsc
*************************************************/

#using script_728ffcee8cbf30ee;
#using script_930a1e7bd882c1d;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\ui;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_ending_util;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#namespace namespace_cdf78256fb747c6e;

function function_ffa68c72485da6cc(var_cbfc3ba10cefc8ce) {
  level.var_cc780086b56ca17 = self;
  level.var_7a1d91242348fb45 = getdvarint(@ "hash_d21fb4c6ab6e94f1", 1);
  sceneent = getEnt("infil_exfil_hq_origin", "targetname");

  if(!isDefined(sceneent)) {
    sceneent = spawnStruct();
    sceneent.origin = (0, 0, 0);
    sceneent.angles = (0, 0, 0);
  }

  if(level.var_7a1d91242348fb45) {
    preloadcinematicforall("jup_wz_cq_detonation_bink", 1);
  }

  var_8740420879100bee = spawnStruct();
  var_8740420879100bee.origin = self.origin;
  var_8740420879100bee.angles = self.angles;
  var_8740420879100bee scene::set_scriptbundle("jup_wz_exfil_cq_detonation_scene");
  var_dda93b45a16fcdee = var_8740420879100bee scene::function_8a37fe423de2b9db();
  self.var_8740420879100bee = var_8740420879100bee;
  var_3ac645baaf9e0cb = spawnStruct();
  var_3ac645baaf9e0cb.origin = sceneent.origin;
  var_3ac645baaf9e0cb.angles = sceneent.angles;
  var_3ac645baaf9e0cb scene::set_scriptbundle("jup_wz_exfil_b_scene_cq");
  var_7c624482f39768b5 = var_3ac645baaf9e0cb scene::function_8a37fe423de2b9db();
  var_3ac645baaf9e0cb.randomizedshots = function_93b66df7957f429();
  self.var_3ac645baaf9e0cb = var_3ac645baaf9e0cb;
  var_4467afaef897ef04 = spawnStruct();
  var_4467afaef897ef04.origin = sceneent.origin;
  var_4467afaef897ef04.angles = sceneent.angles;
  var_4467afaef897ef04 scene::set_scriptbundle("jup_wz_acc_cq_detonation_scene");
  var_9f8024010501e954 = var_4467afaef897ef04 scene::function_8a37fe423de2b9db();
  scene::add_scene_func(var_4467afaef897ef04, &function_a94e7648851e0e34, var_9f8024010501e954[0]);
  scene::add_scene_func(var_4467afaef897ef04, &function_9f179f05e30bbdca, var_9f8024010501e954[var_9f8024010501e954.size - 1]);
  self.var_4467afaef897ef04 = var_4467afaef897ef04;
  var_299f8159a7635889 = spawnStruct();
  var_299f8159a7635889.origin = sceneent.origin;
  var_299f8159a7635889.angles = sceneent.angles;
  var_299f8159a7635889 scene::set_scriptbundle("jup_wz_aar_ar_scene");
  self.var_299f8159a7635889 = var_299f8159a7635889;
  self.winner = self.winners[0].team;

  if(!isDefined(var_cbfc3ba10cefc8ce)) {
    var_cbfc3ba10cefc8ce = (0, 0, 0);
  }

  level.var_fa77ea41af520470 = "";
  setomnvarforallclients("ui_br_infil_exfil_player_focus", -1);

  if(!getdvarint(@ "hash_19a406e3c51ce52f")) {
    self.transientname = function_aafaf24d80927b02();
    assert(!istrue(level.arrow.dvars.var_c86c4de4e54401e1) || istrue(level.arrow.transientloaded));

    if(istrue(level.arrow.dvars.var_c86c4de4e54401e1) && !istrue(level.arrow.transientloaded)) {
      scripts\mp\utility\script::demoforcesre("Transients not loaded early.") namespace_6c622b52017c6808::function_ba362ff77cb55d00();
    }

    while(!istrue(level.arrow.transientloaded)) {
      waitframe();
    }
  }

  scripts\mp\gametypes\br_circle::hidedangercircle();
  self.winners = array_removeundefined(self.winners);

  if(getdvarint(@ "hash_31c2a7e681ae24ed", 1)) {
    foreach(player in level.players) {
      player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
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

  numplayers = self.winners.size;

  numplayers = getdvarint(@ "hash_6c00832d85ed5093", numplayers);

  self.var_4467afaef897ef04.numinscene = numplayers;
  self.var_8740420879100bee scene::function_2136d6e5467c6caf(numplayers);
  self.var_3ac645baaf9e0cb scene::function_2136d6e5467c6caf(numplayers);
  self.var_4467afaef897ef04 scene::function_2136d6e5467c6caf(numplayers);
  self.var_299f8159a7635889 scene::function_2136d6e5467c6caf(numplayers);
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
}

function function_bb2daf72d16fc6a7() {
  setDvar(@ "cg_drawcrosshair", 0);

  if(istrue(self.istemp)) {
    function_982f2d6d032119f6();
    return;
  }

  function_982f2d6d032119f6();
  function_7df370db6f5c2769();
  function_3ff1da3583824ebe();
  function_8a4241a18c791441();

  foreach(player in level.players) {
    player clearpredictedstreampos();
  }
}

function private function_982f2d6d032119f6() {
  self.var_8740420879100bee scene::pre_stream(self.winners);

  foreach(player in level.players) {
    player function_451319f93d30ebe5(%"hash_34c59bed7392d266");
  }

  if(isDefined(level.arrow.props) && isDefined(level.arrow.props.bombsite)) {
    level.arrow.props.bombsite freescriptable();
  }

  wait 0.75;
  level notify("nuke_fadeEnd");

  if(istrue(self.istemp)) {
    thread function_327d687c7f00c05d();
  }

  var_7c624482f39768b5 = self.var_8740420879100bee scene::function_8a37fe423de2b9db();
  duration = self.var_8740420879100bee scene::function_d9be975d8d1c9db3(var_7c624482f39768b5[0]);
  thread function_a6c14e404b6d27();
  var_c01f079eb027d3bc = 2;
  wait duration - var_c01f079eb027d3bc;
}

function private function_a6c14e404b6d27() {
  br_cq_ending_flyby = function_17ee301cf0b5ba85("br_cq_ending_flyby");
  var_cc9bd4af3a489f3c = function_17ee301cf0b5ba85("br_cq_ending_flyby");
  function_fe75a89529dd0fd0(level.players, br_cq_ending_flyby, undefined, undefined, var_cc9bd4af3a489f3c);
  delaythread(0, &function_7acde5feb50c98f2, level.players, "evt_br_cq_detonation_flyby");
  delaythread(3.5, &function_7acde5feb50c98f2, level.players, "evt_br_cq_detonation_flyby_slam_zoom");
  delaythread(3.8, &function_7acde5feb50c98f2, level.players, "evt_br_cq_detonation_flyby_nuke_beep");
  self.var_8740420879100bee scene::play(self.winners);

  if(istrue(self.istemp)) {
    self notify("<dev string:x1c>");

    foreach(player in level.players) {
      player clearpredictedstreampos();
    }
  }

}

function private function_92cf6571a49606b9() {
  level thread scripts\mp\gametypes\br::handleendgamesplash(self.winner, 1, self.winners);
  level thread scripts\mp\gametypes\br::handleendgamespectatingsplash(self.winner, 1);

  if(istrue(level.shownonspectatingwinnersplash)) {
    level thread scripts\mp\gametypes\br::handleendgamenonwinnersplash(self.winner, 1);
  }
}

function private function_93b66df7957f429() {
  shotslist = ["shot_010", "shot_020", "shot_030", "shot_040", "shot_050"];
  var_9e9d94263cf344d3 = [" A", " B"];
  variation = var_9e9d94263cf344d3[randomint(2)];

  shot = getDvar(@ "hash_6e6b30dcd38ed28f", "<dev string:x34>");

  if(shot != "<dev string:x34>") {
    variation = "<dev string:x38>" + shot;
  }

  shotslist[0] += variation;
  shotslist[1] += variation;
  shotslist[2] += variation;
  shotslist[3] += variation;
  shotslist[4] += variation;
  return shotslist;
}

function private function_7df370db6f5c2769() {
  function_65753b3e1905c075(self.winners);
  function_7acde5feb50c98f2(level.players, "evt_br_cq_nuke_explo");
  namespace_6c622b52017c6808::function_fd06a1bbf48d3fca();
  wait 1;
  _visionsetnaked("mp_jup_bigmap_wz2_cq_exfil", 0);
  setomnvarforallclients("post_game_state", 13);
  setomnvarforallclients("ui_br_bink_overlay_state", 13);

  if(level.var_7a1d91242348fb45) {
    function_1804d4c2e4ef3af5(0, 1);
  } else {
    playcinematicforall("jup_wz_cq_detonation_bink", 1);
  }

  var_2e17aeee87c04fae = 4;
  var_1af552d7a8743a80 = 9.5;
  var_507f54f784d0918 = var_2e17aeee87c04fae + var_1af552d7a8743a80;
  function_f1aed36ab4598ea("mp_gamemode_br_exfils_jup");
  self.var_3ac645baaf9e0cb thread scene::pre_stream(self.winners, undefined, var_507f54f784d0918);
  wait var_2e17aeee87c04fae;
  function_92cf6571a49606b9();
  wait var_1af552d7a8743a80;
  stopcinematicforall(1, 1);
  setomnvarforallclients("ui_br_bink_overlay_state", 0);
  setomnvarforallclients("post_game_state", 0);
  level thread function_c300d34e34164b6d(0, 3.33, 1);
  level thread function_a9283bb8f2690ea8();
  function_c79f9300ee85f805(level.players, "mp_killstreak_nuke", 3);
  function_c79f9300ee85f805(level.players, "br_elite_contract_ending", 3);
  br_cq_exfil = function_17ee301cf0b5ba85("br_cq_exfil");
  var_f2184c8d4415453a = function_17ee301cf0b5ba85("br_cq_exfil");
  function_fe75a89529dd0fd0(level.players, br_cq_exfil, undefined, undefined, var_f2184c8d4415453a);
  function_7acde5feb50c98f2(level.players, "uin_jup_cq_victory_exfil_chyrons");
  namespace_81156089ff1fe819::function_42f1462f1d4193af("cq_exfil_light");
  thread function_d496ea2ee81d60fc();

  if(isDefined(self.var_3ac645baaf9e0cb.randomizedshots)) {
    self.var_3ac645baaf9e0cb scene::play(self.winners, self.var_3ac645baaf9e0cb.randomizedshots);
    return;
  }

  self.var_3ac645baaf9e0cb scene::play(self.winners);
}

function function_a94e7648851e0e34() {
  function_fd28a78c72cc942b();
}

function private function_fd28a78c72cc942b() {
  sceneroot = self;
  var_30b554732c7dbecf = sceneroot scene::get_entity("Medals Singles");
  medalsduos = sceneroot scene::get_entity("Medals Duos");
  medalstrios = sceneroot scene::get_entity("Medals Trios");
  medalsquads = sceneroot scene::get_entity("Medals Quads");

  if(sceneroot.numinscene != 4) {
    medalsquads hide();
  }

  if(sceneroot.numinscene != 3) {
    medalstrios hide();
  }

  if(sceneroot.numinscene != 2) {
    medalsduos hide();
  }

  if(sceneroot.numinscene != 1 && sceneroot.numinscene != 0) {
    var_30b554732c7dbecf hide();
  }
}

function function_9f179f05e30bbdca() {
  fade_in_time = 0.15;
  fade_out_time = 0.25;
  fade_time = 0.5;
  shots = scene::function_8a37fe423de2b9db();
  shotlength = scene::function_d9be975d8d1c9db3(shots[shots.size - 1]);
  waittime = max(0, shotlength - fade_in_time - fade_time * 3 / 4);
  wait waittime;
  function_c300d34e34164b6d(fade_in_time, fade_time, fade_out_time);
}

function private function_d496ea2ee81d60fc() {
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 1);
  wait 22;
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 2);
  wait 5;
  setomnvarforallclients("ui_br_elite_arrow_aar_state", 3);
}

function private function_3ff1da3583824ebe() {
  function_7acde5feb50c98f2(level.players, "scn_jup_br_cq_exfil_nuke_dist_blast");
  function_e395443832372863(self.var_4467afaef897ef04);
  self.var_4467afaef897ef04 scene::play(self.winners);
}

function private function_8a4241a18c791441() {
  outrofunc();
  function_65753b3e1905c075(self.winners);
  thread function_878fde0a59a3cb9d();
  delaythread(1, &function_7acde5feb50c98f2, level.players, "uin_jup_br_aar_placement_badge_slam");
  self.var_299f8159a7635889 scene::play(self.winners);
  function_2d3425695113e32b();
}

function private function_327d687c7f00c05d() {
  self waittill("<dev string:x1c>");

  if(self.var_8740420879100bee scene::get_state() == "<dev string:x3d>") {
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

function function_a9283bb8f2690ea8() {
  function_4e8ba327eb12540c(level.players, "jup_br_exfil_b_igc", 3);
  function_a408e30ca85e03a9(level.players, "mp_jup_br_exfil_cq", 1);
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
  function_4e8ba327eb12540c(level.players, "mute_ambience_elements_emitters", 1, 0.683772);
  function_4e8ba327eb12540c(level.players, "mute_ambience", 1, 1);
  delaythread(5, &function_326e5ed05234a4f0, level.players, 15);
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

  if(!istrue(level.var_9b73afbde2775159)) {
    level thread function_c300d34e34164b6d(undefined, 2, 1);
  }

  level.var_9b73afbde2775159 = undefined;
  level thread function_c4ebe940e6d84d42();
}

function function_c4ebe940e6d84d42() {
  wait 60;
  soundbank = "mp_gamemode_br_exfils";

  if(scripts\engine\utility::issharedfuncdefined("br_ending_chopper_to_hq", "getExfilSoundbank")) {
    soundbank = [[scripts\engine\utility::getsharedfunc("br_ending_chopper_to_hq", "getExfilSoundbank")]]();
  }

  function_f4e0ff5cb899686d(soundbank);
}

function function_aafaf24d80927b02() {
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