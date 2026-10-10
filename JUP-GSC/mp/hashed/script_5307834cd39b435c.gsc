/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5307834cd39b435c.gsc
*************************************************/

#using script_1174abedbefe9ada;
#using script_15ca41a3fbb0e379;
#using script_2d9d24f7c63ac143;
#using script_3aacf02225ca0da5;
#using script_4a6760982b403bad;
#using script_5c65d346ac65390c;
#using script_6fc415ff6a905dc1;
#using script_b7a9ce0a2282b79;
#using scripts\common\ae_utility;
#using scripts\common\anim;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_spectate;
#using scripts\mp\gametypes\dead_drop;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\laststand;
#using scripts\mp\lightarmor;
#using scripts\mp\playerlogic;
#using scripts\mp\poi;
#using scripts\mp\rank;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace namespace_5287de5aa8b462db;

function function_36f1bd0f5d72054a() {
  if(getdvarint(@ "hash_25b11256c0da51a1", 1) == 0) {
    return;
  }

  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
  level._effect["vfx_smk_signal_gr"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal_gr");
  level._effect["vfx_smk_signal_dmz"] = loadfx("vfx/iw9/level/mp_dmz_hydro/vfx_smk_signal_dmz");
  level._effect["vfx_smk_signal_dmz_diss"] = loadfx("vfx/iw9/level/mp_dmz_hydro/vfx_smk_signal_dmz_diss");
  function_832f6c1a7bb8c4ff();
  level thread function_9792d0e6c82398bf();
  level.var_95de4b6bb41fbbfa = [];
  level.var_b8457c8044b2ee02 = getdvarint(@ "hash_bf86d2b0958e8803", 300);
  level.var_9405abd1db7cf2cf = getdvarint(@ "hash_9eb35fd11109d87d", 60);
  level.var_b91d57df9d8ec00e = getdvarint(@ "hash_28cc46b930476566", 10);
  level.var_745bebf82b7d49f8 = getdvarint(@ "hash_ed723ab06879fdb5", 60);
  level.var_df3a6e8886416b36 = int(getdvarint(@ "hash_918d5ea00183221c", 999) * 100);
  level.var_d962891163d17d4a = getdvarint(@ "scr_dmz_dmzsamepoiexfil", 0);
  level.var_c8ff03474c1de67f = getdvarint(@ "scr_dmz_dmznumofpoiawayexfil", 2);
  level.var_6b712f0345bf6f12 = getdvarint(@ "hash_8e317ce550e11531", 30);
  level.var_662586ede589f49c = getdvarint(@ "scr_dmz_exfilremoveonuse", 0);
  level.var_8f7d92f10fc80ce = getdvarint(@ "scr_dmz_exfilunlockonmissioncomplete", 0);
  level.var_9b6b8c7ecb7ac7c0 = getdvarint(@ "scr_dmz_exfilusesharedpool", 0);
  level.var_4644c9da9a611950 = getdvarint(@ "hash_4f0a08cc7285b3c7", 0);
  level.var_cdc76bc962358072 = getdvarint(@ "scr_dmz_exfilforceshared", 1);
  level.var_858dba9da8dc5419 = getdvarint(@ "scr_dmz_exfilinitialshared", 3);
  level.var_50477dc063210a56 = getdvarint(@ "hash_f96d14f35aba8181", 0) == 1;
  level.var_c69d2b1eeb329a5a = getdvarint(@ "hash_7aceaf0413d3f442", 1);
  level.var_f3a3f7cf0a42d67c = getdvarint(@ "hash_71de0410d6b8a154", 5000);
  level.var_68cdddbbe057395d = getdvarint(@ "hash_ba94141588893ff2", 1);
  level.var_9b3294726f6d3a6 = getdvarint(@ "hash_987da8ab1c15d96b", 1) == 1;
  level.var_dd83d323306dcba7 = getdvarint(@ "hash_761322608da01456", 0) == 1;
  level.var_540f24bb9acf4c02 = getdvarint(@ "hash_654fac10fc85947e", 2);
  level.var_1eff61a95657ca2 = getdvarint(@ "hash_4726749f66554ee", 1);
  level.var_628f636de1f2dda3 = getdvarint(@ "hash_9756404935ac6487", 2);
  level.var_a276cd366472b025 = getdvarint(@ "hash_4ac155bcb91cc93e", 5);
  level.var_bbf4a84349d0fdeb = getdvarint(@ "hash_6719472694f0112", 2000);
  level.var_cf4723bfb4cc7643 = getdvarint(@ "hash_b41c17e4ff85fb3c", 0);
  level.var_9fb5000ae38dcf7f = getdvarint(@ "hash_87418a428facd9bb", 1);
  level.var_c64beb7b042390c8 = getdvarint(@ "hash_8d43db8f06ffda3f", 1);
  level.var_679b51811bc32adc = getdvarint(@ "hash_f9f43c362802ca01", 5);
  level.var_e5261a9a2feaf655 = getdvarint(@ "hash_277d1a4cbe10e33c", 4);
  level.var_c7825757649c018e = getdvarint(@ "hash_1d32c1595de57577", 15);
  level.var_50ff14b675031d14 = getdvarint(@ "hash_a9ebe44e535cc367", 0);
  level.var_c42d6e4a40f70691 = getdvarint(@ "scr_dmz_exfil_req_missions", 0);

  if(level.var_c42d6e4a40f70691 || level.var_8f7d92f10fc80ce) {
    level.var_faa873310add1096 = &function_52781be0b4e8a959;
  }

  level.var_ff04728f8e36403f = getdvarint(@ "hash_2bf795e2bb163c72", 0);
  level.var_53bdd63ac87a9076 = getdvarint(@ "hash_62cc42aa2aca04c9", 1);
  level.var_4be8962610ee659b = getdvarfloat(@ "hash_82ca0dece965efba", 0);
  level.var_cd6e8342a9c09c26 = getdvarfloat(@ "hash_3bbb199dfb8a5bc7", 0.9);
  level.var_ba138ad5136d87d = getdvarint(@ "hash_5d13b090ca102618", 900) * 1000;
  level.var_6c41580562fd09e2 = gettime();
  level thread function_119b893a0ca18687();
  level thread function_1fac2465eb5dda23();

  level thread function_d92380bfc792a6a9();

  scripts\mp\team_assimilation::registerteamassimilatecallback(&function_a857c0cb4fcb1819);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_exfil_site", &function_c5f291acf1b44b69);
  namespace_e8fceb5cf6e8cdf8::function_7d47bded29ed7882(level.var_9405abd1db7cf2cf, level.var_bbf4a84349d0fdeb, level.var_745bebf82b7d49f8, level.var_a276cd366472b025, level.var_6fc3398b5a13400, getdvarint(@ "hash_a3c1d41c94507f92", 279), level.var_c7825757649c018e, level.var_df3a6e8886416b36);
  function_43516e81ba78395d();
}

function function_43516e81ba78395d() {
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("airspace_too_crowded", &function_40d3fb596096ac55);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("initial_splash", &function_595eede45a673b1f);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("setup_gas_masks", &function_aa3139c5fae701b8);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("player_exfil_timer", &playerexfiltimer);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("exfil_players", &exfilplayers);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("reset_exfil", &function_1dcda56efb76e334);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("remove_exfil", &function_673f07bb8a61bcf3);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("music_stop", &function_113d0e9d241c8568);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("music_reset", &function_704dc2a5075c58b9);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("music_start", &function_1ce7b362085d943e);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("music_exfil_end", &function_b1219a25435ab949);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("dialog_start_exfil", &function_133deebbe58fb347);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("dialog_handle_touchdown", &function_25e48c3d85f4a59c);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("dialog_final_warning", &function_ab7f97a0b46cbeaf);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("dialog_final_leaving", &function_a0d539b960b93bb);
  namespace_e8fceb5cf6e8cdf8::function_3c673414d075ebfc("dialog_shortcut", &function_e392fd7cad768e25);
}

function function_119b893a0ca18687() {
  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  foreach(team in level.teamnamelist) {
    level.teamdata[team]["exfils"] = [];
  }
}

function function_9792d0e6c82398bf() {
  wait 1;
  level.var_cc6f9cf228accb4 = [];

  foreach(entry in level.teamnamelist) {
    level.var_cc6f9cf228accb4[entry] = 0;
  }
}

function function_832f6c1a7bb8c4ff() {
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_waitfor_exfil", 1, "neutral", "MP_INGAME_ONLY/OBJ_EXFIL_NOTACTIVE_CAPS", "ui_map_icon_extraction", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("icon_waypoint_active_exfil", 1, "neutral", "MP_INGAME_ONLY/OBJ_Exfil_CAPS", "ui_map_icon_extraction", 0);
}

function function_a4181028915c44fa(node, droptoground) {
  var_3064fa24dbbd5bbf = spawnStruct();

  if(!isDefined(droptoground)) {
    droptoground = getdvarint(@ "hash_2f6aa396e5e4e4f1", 1) == 1;
  }

  if(isDefined(node.poi)) {
    var_3064fa24dbbd5bbf.poi = node.poi;
  } else {
    var_3064fa24dbbd5bbf.poi = scripts\mp\poi::function_6cc445c02b5effac(node.origin);
  }

  var_3064fa24dbbd5bbf.angles = node.angles;
  var_3064fa24dbbd5bbf.origin = ter_op(droptoground, scripts\mp\gametypes\br_public::droptogroundmultitrace(getclosestpointonnavmesh(node.origin)), node.origin);
  var_3064fa24dbbd5bbf.modelname = "dmz_exfil_site_xmodel";
  var_3064fa24dbbd5bbf.activatedteams = [];

  if(isDefined(node.target)) {
    helinode = getStruct(node.target, "targetname");

    if(isDefined(helinode)) {
      var_3064fa24dbbd5bbf.helitargetorigin = helinode.origin;
      var_3064fa24dbbd5bbf.helitargetangles = helinode.angles;
    }
  }

  if(isDefined(node.script_label)) {
    if(node.script_label == "land") {
      var_3064fa24dbbd5bbf.land = 1;
    }
  }

  return var_3064fa24dbbd5bbf;
}

function function_1fac2465eb5dda23() {
  if(getdvarint(@ "hash_61c64c6e38290aa1", 0) == 1) {
    return;
  }

  waitframe();
  level endon("game_ended");
  level.var_c26f0d22bc1fa7ef = [];
  level.var_b95a019fc748357a = [];
  level.var_ccbb0e8b2a740b8 = [];
  var_6b6476844b6ada68 = [];
  movetonavmesh = getdvarint(@ "hash_b4f00bd105203ec9", 1);
  var_5a3867693588454b = getdvarint(@ "hash_41d95a4caf9b2e7d", 0) == 1;
  var_fa41506cce024e8 = "dmz_squadExfilPoint";

  if(level.var_68cdddbbe057395d == 1) {
    var_fa41506cce024e8 = "dmz_communalExfilPoint" + level.var_53bdd63ac87a9076;
  }

  foreach(node in getStructArray(var_fa41506cce024e8, "script_noteworthy")) {
    if(var_5a3867693588454b && !isDefined(node.poi)) {
      continue;
    }

    if(isDefined(node.poi) && array_contains(level.var_ab20b3a256911579, node.poi)) {
      continue;
    }

    groundpos = getclosestpointonnavmesh(node.origin);

    if(isDefined(level.var_3796dc1d470dfab8)) {
      var_3064fa24dbbd5bbf = [[level.var_3796dc1d470dfab8]](node);
    } else {
      var_3064fa24dbbd5bbf = function_a4181028915c44fa(node);
    }

    var_6b6476844b6ada68[var_6b6476844b6ada68.size] = var_3064fa24dbbd5bbf;
  }

  foreach(node in getStructArray("dmz_communalExfilPointFinal", "script_noteworthy")) {
    if(var_5a3867693588454b && !isDefined(node.poi)) {
      continue;
    }

    if(isDefined(node.poi) && array_contains(level.var_ab20b3a256911579, node.poi)) {
      continue;
    }

    groundpos = getclosestpointonnavmesh(node.origin);
    var_3064fa24dbbd5bbf = function_a4181028915c44fa(node);
    level.var_b95a019fc748357a[level.var_b95a019fc748357a.size] = var_3064fa24dbbd5bbf;
  }

  assertex(var_6b6476844b6ada68.size > 0, "<dev string:x1c>" + var_fa41506cce024e8 + "<dev string:x4d>");
  function_442bb8e42c0d40b7(var_6b6476844b6ada68);

  if(level.var_9b6b8c7ecb7ac7c0 == 1) {
    function_1db005b6eb39a56d();
  }

  if(level.var_c69d2b1eeb329a5a == 1) {
    level thread function_b9730bfe1e8b9f81();
  }

  level thread function_9a7567a2d46b857a();
}

function private function_442bb8e42c0d40b7(var_3064fa24dbbd5bbf, var_d8aa357adf7cb05d) {
  var_f951f4bb16e92179 = 0;
  level.var_5fad09539823f92e = [];

  foreach(exfil in var_3064fa24dbbd5bbf) {
    var_f951f4bb16e92179++;
    exfil.var_302f61f95f10f7f3 = var_f951f4bb16e92179;
    level.var_c26f0d22bc1fa7ef[level.var_c26f0d22bc1fa7ef.size] = exfil;

    if(istrue(var_d8aa357adf7cb05d)) {
      function_bbe41f41d0f13612(exfil);
      exfil.ent setscriptablepartstate("dmz_exfil_icon", "communal_icon");
    }

    if(isDefined(exfil.poi)) {
      if(!isDefined(level.var_5fad09539823f92e[exfil.poi])) {
        level.var_5fad09539823f92e[exfil.poi] = [];
      }

      level.var_5fad09539823f92e[exfil.poi][level.var_5fad09539823f92e[exfil.poi].size] = exfil;
    }
  }
}

function private function_1db005b6eb39a56d() {
  assertex(isDefined(level.var_5fad09539823f92e), "<dev string:x58>");
  level.var_58f477e9e7e8f739 = [];

  if(getdvarint(@ "hash_a4617fb891ca21cb", 0) == 1) {
    foreach(exfil in level.var_c26f0d22bc1fa7ef) {
      level.var_58f477e9e7e8f739[level.var_58f477e9e7e8f739.size] = exfil;
    }

    return;
  }

  foreach(var_36847c9a092f0703 in level.var_5fad09539823f92e) {
    randomizedinfo = array_randomize(var_36847c9a092f0703);

    for(i = 0; i < level.var_540f24bb9acf4c02; i++) {
      level.var_58f477e9e7e8f739[level.var_58f477e9e7e8f739.size] = randomizedinfo[i];
    }
  }
}

function private function_2431347a478dc694(var_2b6deb0f4170e1a4) {
  level.var_f9e4efea742e3709 = [];
  var_f951f4bb16e92179 = 0;
  level.var_5fad09539823f92e = [];

  foreach(exfil in var_2b6deb0f4170e1a4) {
    var_f951f4bb16e92179++;
    exfil.var_302f61f95f10f7f3 = var_f951f4bb16e92179;
    exfil.teamtimers = [];
    exfil thread function_4bbc9b547eeb547f();
    level.var_c26f0d22bc1fa7ef[level.var_c26f0d22bc1fa7ef.size] = exfil;
    function_bbe41f41d0f13612(exfil);
    exfil.ent setscriptablepartstate("dmz_exfil_icon", "communal_icon");
  }
}

function private function_4bbc9b547eeb547f() {
  level endon("game_ended");

  while(true) {
    players = utility::playersincylinder(self.origin, 500);

    if(players.size > 0) {
      foreach(player in players) {
        if(!isDefined(self.teamtimers[player.team]) || self.teamtimers[player.team] == 0) {
          self.teamtimers[player.team] = 1;
          function_9251ff271b0450dd(player.team);
        }
      }
    }

    wait 1;
  }
}

function private function_9251ff271b0450dd(team) {
  exfiltimer = level.var_6b712f0345bf6f12;

  while(exfiltimer > 0) {
    players = utility::playersincylinder(self.origin, 500);

    foreach(player in players) {
      if(!isDefined(player.var_a09b2cb47a28054a) && player.team == team) {
        self.var_902a7ffcff8aa65[self.var_902a7ffcff8aa65.size] = player;
        player thread playerexfiltimer(self.origin, exfiltimer, 500);
      }
    }

    exfiltimer--;
    wait 1;
  }

  players = utility::playersincylinder(self.origin, 500);
  teammates = [];

  foreach(player in players) {
    if(player.team == team) {
      teammates[teammates.size] = player;
    }
  }

  exfilplayers(teammates);
  self.teamtimers[team] = 0;
}

function playerexfiltimer(heli, time, dist) {
  self notify("dmz_exfil_timer");
  self endon("disconnect");
  self endon("dmz_exfil_timer");
  timer = time;

  if(!isDefined(timer)) {
    return;
  }

  while(timer > 0) {
    if(timer < 11) {
      self setentitysoundcontext("lobby_fade", "on");
    }

    if(isDefined(dist) && (!isDefined(self) || distance(heli.pos, self.origin) > dist)) {
      break;
    }

    if(timer < 80) {
      self setclientomnvar("ui_match_start_countdown", timer);
    }

    timer--;
    wait 1;
  }

  namespace_e8fceb5cf6e8cdf8::function_423f49e2512a5f53();
  self setclientomnvar("ui_match_start_countdown", 0);
  self setentitysoundcontext("lobby_fade", "", 2);
}

function function_a9f268abd153b713() {
  self notify("dmz_exfil_timer");
  namespace_e8fceb5cf6e8cdf8::function_423f49e2512a5f53();
  self setclientomnvar("ui_match_start_countdown", 0);
}

function private function_b9730bfe1e8b9f81() {
  level waittill("dmz_radiation_started");

  if(!namespace_7789f919216d38a2::radiation_isinit()) {
    assertmsg("<dev string:x8c>");
    return;
  }

  wait 5;
  level thread function_48272de6dc9130f7();
}

function private function_48272de6dc9130f7() {
  assertex(isDefined(level.var_fe2e551da0962c3c), "<dev string:xd8>");

  while(true) {
    if(level.var_fe2e551da0962c3c.size > 0) {
      foreach(exfil in level.var_fe2e551da0962c3c) {
        if(namespace_7789f919216d38a2::radiation_isinradiation(exfil.origin)) {
          function_dda47641682585d9(exfil);
          level.var_fe2e551da0962c3c = array_remove(level.var_fe2e551da0962c3c, exfil);
        }
      }
    } else {
      level thread function_a3f113dc69814771();
      return;
    }

    wait 1;
  }
}

function private function_a3f113dc69814771() {
  if(!isDefined(level.var_c5074bf13ffb95ef)) {
    return;
  }

  radspeed = namespace_7789f919216d38a2::radiation_getspeed();
  var_c444e48ae40730ba = distance2d(level.var_aa174df565129c2b.origin, level.radiation.startorigin);
  var_1e6c96f9d4b225c4 = distance2d(level.var_c5074bf13ffb95ef.origin, level.radiation.startorigin);
  timer = (var_1e6c96f9d4b225c4 - var_c444e48ae40730ba) / radspeed;
  var_10817a88ad06996f = level.var_c5074bf13ffb95ef;
  function_bbe41f41d0f13612(var_10817a88ad06996f);

  if(isDefined(var_10817a88ad06996f.ent)) {
    var_10817a88ad06996f.ent setscriptablepartstate("dmz_exfil_site", "standby");
    var_10817a88ad06996f.ent setscriptablepartstate("dmz_exfil_icon", "final_exfil_icon");
  }

  thread function_9fdf14c5aac8ce53("dmz_exfil_pilot_called_final");
  timer -= level.var_a276cd366472b025 + 5;
  timer -= level.var_c7825757649c018e;

  if(level.players.size <= 0) {
    return;
  }

  thread function_5bc15f36914e63c7(var_10817a88ad06996f.ent, undefined, undefined, level.players[randomint(level.players.size)], timer, 0, 1);
}

function private function_dda47641682585d9(exfil) {
  if(!isDefined(exfil)) {
    return;
  }

  if(!isDefined(level.var_35a1cdd4a92304a5)) {
    level.var_35a1cdd4a92304a5 = [];
  }

  var_29f917ae2719196a = function_f2811d61401a5e40(exfil);

  if(istrue(exfil.globallyvisible) && level.var_f3a3f7cf0a42d67c > 0) {
    var_29f917ae2719196a = scripts\mp\utility\player::getplayersinradius(exfil.origin, level.var_f3a3f7cf0a42d67c);
  }

  scripts\cp_mp\overlord::playevent("radiation_delete_personal_exfils", array_remove_array(var_29f917ae2719196a, level.var_35a1cdd4a92304a5));
  level.var_35a1cdd4a92304a5 = array_combine_unique(level.var_35a1cdd4a92304a5, var_29f917ae2719196a);

  if(isDefined(exfil.ent)) {
    exfil.ent notify("disable");
    exfil.ent.disabled = 1;
    exfil.ent setscriptablepartstate("dmz_exfil_icon", "disabled_icon");
    exfil.ent setscriptablepartstate("dmz_exfil_smoke", "stop");
    exfil.ent setscriptablepartstate("dmz_exfil_site", "standby");
  }

  level.var_c26f0d22bc1fa7ef = array_remove(level.var_c26f0d22bc1fa7ef, exfil);

  if(isDefined(exfil.poi) && isDefined(level.var_5fad09539823f92e) && isDefined(level.var_5fad09539823f92e[exfil.poi])) {
    level.var_5fad09539823f92e[exfil.poi] = array_remove(level.var_5fad09539823f92e[exfil.poi], exfil);
  }

  if(isDefined(level.var_58f477e9e7e8f739)) {
    level.var_58f477e9e7e8f739 = array_remove(level.var_58f477e9e7e8f739, exfil);
  }
}

function private function_f2811d61401a5e40(exfil) {
  if(!isDefined(exfil)) {
    return [];
  }

  if(istrue(exfil.globallyvisible)) {
    return level.players;
  }

  visibleplayers = [];

  if(isDefined(exfil.activatedteams)) {
    foreach(team in exfil.activatedteams) {
      visibleplayers = array_combine(visibleplayers, getteamdata(team, "players"));
    }
  }

  return visibleplayers;
}

function private function_5086b40cfd533087() {
  radiationorigin = namespace_7789f919216d38a2::radiation_getorigin();

  if(!isDefined(radiationorigin)) {
    return;
  }

  nodes = getStructArray("dmz_communalExfilPoint" + level.var_53bdd63ac87a9076, "script_noteworthy");

  if(nodes.size > 0) {
    var_2c1975f487bbe252 = getdvarint(@ "hash_65d6b521ab74dc34", 1);
    var_5fc0bb331fcc1784 = getdvarint(@ "hash_df07ea3ec5250762", 4);
    var_87d5384a614ba40c = ter_op(var_2c1975f487bbe252 >= var_5fc0bb331fcc1784, var_2c1975f487bbe252, randomintrange(var_2c1975f487bbe252, var_5fc0bb331fcc1784));

    if(var_87d5384a614ba40c <= 0) {
      return;
    }

    var_5f48ee4ed384234c = [];

    if(getdvarint(@ "hash_2317bf1ebb6514f7", 0) == 1) {
      var_5f48ee4ed384234c[var_5f48ee4ed384234c.size] = sortbydistance(nodes, radiationorigin)[nodes.size - 1];
    } else {
      var_5f48ee4ed384234c[var_5f48ee4ed384234c.size] = random(array_slice(sortbydistance(nodes, radiationorigin), int(max(0, nodes.size - 2))));

      foreach(exclusiondistance in [45000, 25000, 10000, 3000]) {
        foreach(node in array_randomize(nodes)) {
          validnode = 1;

          foreach(var_8504857c0c6f38c3 in var_5f48ee4ed384234c) {
            if(distance(var_8504857c0c6f38c3.origin, node.origin) < exclusiondistance) {
              validnode = 0;
              break;
            }
          }

          if(validnode) {
            var_5f48ee4ed384234c[var_5f48ee4ed384234c.size] = node;

            if(var_5f48ee4ed384234c.size >= var_87d5384a614ba40c) {
              break;
            }
          }
        }

        if(var_5f48ee4ed384234c.size >= var_87d5384a614ba40c) {
          break;
        }
      }
    }

    var_1eb20c7e1f001a1e = [];
    var_6db47c254e98cc63 = getdvarint(@ "scr_dmz_exfils_useendareas", 1) == 1;

    foreach(node in var_5f48ee4ed384234c) {
      groundpos = scripts\mp\gametypes\br_public::droptogroundmultitrace(node.origin);
      var_3064fa24dbbd5bbf = spawnStruct();

      if(isDefined(node.poi)) {
        var_3064fa24dbbd5bbf.poi = node.poi;
      } else {
        var_3064fa24dbbd5bbf.poi = scripts\mp\poi::function_6cc445c02b5effac(node.origin);
      }

      var_3064fa24dbbd5bbf.angles = node.angles;
      var_3064fa24dbbd5bbf.origin = groundpos;
      var_3064fa24dbbd5bbf.activatedteams = [];
      var_3064fa24dbbd5bbf.modelname = ter_op(var_6db47c254e98cc63, "dmz_exfil_zone_xmodel", "dmz_exfil_site_xmodel");
      var_1eb20c7e1f001a1e[var_1eb20c7e1f001a1e.size] = var_3064fa24dbbd5bbf;
    }

    if(var_6db47c254e98cc63) {
      function_2431347a478dc694(var_1eb20c7e1f001a1e);
    } else {
      function_442bb8e42c0d40b7(var_1eb20c7e1f001a1e, 1);
    }

    level thread function_4868b0dabbb185f9(var_1eb20c7e1f001a1e);
  }
}

function function_4868b0dabbb185f9(var_1eb20c7e1f001a1e) {
  foreach(var_3064fa24dbbd5bbf in var_1eb20c7e1f001a1e) {
    level thread function_6613aeb065e36928(var_3064fa24dbbd5bbf);
  }
}

function function_6613aeb065e36928(loc) {
  if(!istrue(level.supportsai)) {
    return;
  }

  var_8e39da7681bbcc4b = getdvarint(@ "hash_f895a6b12aceb46", 12);

  if(var_8e39da7681bbcc4b <= 0) {
    return;
  }

  assert(scripts\mp\flags::gameflagexists("<dev string:x10c>") && scripts\mp\flags::gameflag("<dev string:x10c>"), "<dev string:x11d>");
  var_89593782b8b4434d = getdvarint(@ "hash_b7f14fbc972e9210", 6);
  var_6d3480de3b55c1aa = getdvarint(@ "hash_ec0ad58367541fe3", 6);
  var_51fb808f0ad7b056 = getdvarint(@ "hash_99e18e59aca26047", 6);
  var_eefd5067dc92a0e3 = getdvarint(@ "hash_cdde0b9f53cd9d6a", 6);

  if(isDefined(level.var_4b195d3dd0024b9c)) {
    team = level.var_4b195d3dd0024b9c;
  } else {
    team = "team_hundred_ninety_five";
  }

  reinforceorigin = loc;
  priority = "high";
  category = "reinforcements";
  subcategory = "exfil";
  poiname = scripts\mp\poi::function_6cc445c02b5effac(reinforceorigin);
  var_19b18e5335b6e88a = 256;
  var_2898710bec2562dc = 3500;
  summonradius = getdvarint(@ "hash_63d7f015b040d9c6", 5000);
  var_11b3529e57cfed0e = scripts\mp\ai_mp_controller::function_353fecd1549f5f42(reinforceorigin, summonradius, team, var_89593782b8b4434d, undefined, 1024, 1024, undefined);

  if(isarray(var_11b3529e57cfed0e)) {
    var_8e39da7681bbcc4b -= var_11b3529e57cfed0e.size;

    if(var_8e39da7681bbcc4b <= 0) {
      return;
    }

    foreach(agent in var_11b3529e57cfed0e) {
      vector = rotatevector((1, 0, 0), (0, randomint(360), 0));
      wanderorigin = vector * randomfloatrange(512, 1536) + reinforceorigin;
      wanderorigin = agent getclosestreachablepointonnavmesh(wanderorigin);
      scripts\mp\ai_behavior::function_e786aa52b93833eb(agent, wanderorigin, 256, 256);
    }
  }

  if(!function_33357506b39df2ef()) {
    return;
  }

  if(var_8e39da7681bbcc4b > 2) {
    var_b58631347b6ab04 = scripts\mp\ai_heli_reinforce::function_3779deb97b61a65(min(var_8e39da7681bbcc4b, var_51fb808f0ad7b056), reinforceorigin, priority, category, subcategory, undefined, team, 1, poiname);

    if(isarray(var_b58631347b6ab04)) {
      var_8e39da7681bbcc4b -= var_b58631347b6ab04.size - 2;

      if(var_8e39da7681bbcc4b <= 0) {
        return;
      }

      foreach(agent in var_b58631347b6ab04) {
        vector = rotatevector((1, 0, 0), (0, randomint(360), 0));
        wanderorigin = vector * randomfloatrange(512, 1536) + reinforceorigin;
        wanderorigin = agent getclosestreachablepointonnavmesh(wanderorigin);
        scripts\mp\ai_behavior::function_e786aa52b93833eb(agent, wanderorigin, 256, 256);
      }
    }
  }
}

function function_40be536148b7548e(agent) {
  agent endon("death");
  level endon("game_ended");

  while(true) {
    agent thread scripts\mp\utility\debug::drawsphere(agent.origin, 32, 1, (0, 1, 0));
    wait 1;
  }
}

function function_377d92658a1e91(var_3064fa24dbbd5bbf, model) {
  if(isDefined(var_3064fa24dbbd5bbf.ent)) {
    return;
  }

  if(!isDefined(model)) {
    model = var_3064fa24dbbd5bbf.modelname;
  }

  ent = spawn("script_model", var_3064fa24dbbd5bbf.origin);
  ent setModel(model);
  ent.angles = var_3064fa24dbbd5bbf.angles;
  ent.info = var_3064fa24dbbd5bbf;
  scripts\cp_mp\calloutmarkerping::function_6b9641d0060c3a2c(ent);
  ent setscriptablepartstate("dmz_exfil_smoke", "smoking", 0);
  ent setscriptablepartstate("dmz_exfil_site", "ready", 0);
  ent hide();
  var_3064fa24dbbd5bbf.ent = ent;
}

function function_bbe41f41d0f13612(var_3064fa24dbbd5bbf) {
  if(!isDefined(level.var_fe2e551da0962c3c)) {
    level.var_fe2e551da0962c3c = [];
  }

  if(!isDefined(var_3064fa24dbbd5bbf.ent)) {
    function_377d92658a1e91(var_3064fa24dbbd5bbf);
  }

  var_3064fa24dbbd5bbf.ent show();
  var_3064fa24dbbd5bbf.globallyvisible = 1;
  level.var_fe2e551da0962c3c[level.var_fe2e551da0962c3c.size] = var_3064fa24dbbd5bbf;
}

function function_97061811695243ea(var_3064fa24dbbd5bbf) {
  if(!isDefined(level.var_fe2e551da0962c3c)) {
    return;
  }

  if(!isDefined(var_3064fa24dbbd5bbf.ent)) {
    return;
  }

  var_3064fa24dbbd5bbf.ent hide();
  var_3064fa24dbbd5bbf.globallyvisible = 0;
  level.var_fe2e551da0962c3c = array_remove(level.var_fe2e551da0962c3c, var_3064fa24dbbd5bbf);
}

function function_b513aaf6e49f184a(var_3064fa24dbbd5bbf) {
  if(!isDefined(var_3064fa24dbbd5bbf.ent)) {
    function_377d92658a1e91(var_3064fa24dbbd5bbf);
  }

  foreach(team in var_3064fa24dbbd5bbf.activatedteams) {
    foreach(player in getteamdata(team, "players")) {
      var_3064fa24dbbd5bbf.ent showtoplayer(player);
    }
  }
}

function function_f4dc35c0f47a461c(var_3064fa24dbbd5bbf, team) {
  if(!isDefined(var_3064fa24dbbd5bbf.ent)) {
    function_377d92658a1e91(var_3064fa24dbbd5bbf);
  }

  foreach(player in getteamdata(team, "players")) {
    var_3064fa24dbbd5bbf.ent showtoplayer(player);
  }
}

function function_a857c0cb4fcb1819(player, oldteam, newteam) {
  var_87b0b8a08fb5e71a = level.teamdata[oldteam]["exfils"];
  var_f0e72070cf6e1eb1 = level.teamdata[newteam]["exfils"];

  foreach(exfil in var_87b0b8a08fb5e71a) {
    exfil.ent hidefromplayer(player);
  }

  foreach(exfil in var_f0e72070cf6e1eb1) {
    exfil.ent showtoplayer(player);
  }

  players = scripts\mp\utility\teams::getteamdata(newteam, "players");

  foreach(teammate in players) {
    if(istrue(teammate.var_5a4d470f2093fff1)) {
      player setclientomnvar("ui_owns_personal_exfil", 1);
      break;
    }
  }
}

function function_aee6fe083265e34c() {
  self endon("disable");
  numagents = getdvarint(@ "hash_1ce7b251c3164b2c", 6);

  if(numagents == 0) {
    return;
  }

  reinforcedist = getdvarint(@ "hash_3d1b037bbe89b3ac", 4000);
  reinforcedistsq = reinforcedist * reinforcedist;

  while(true) {
    foreach(team in self.info.activatedteams) {
      foreach(player in getteamdata(team, "players")) {
        if(distancesquared(self.origin, player.origin) < reinforcedistsq) {
          var_5aeb0c8e23ff1430 = scripts\mp\ai_mp_controller::function_77acc10c4823dd8a(numagents, self.origin, "medium", "reinforcements", "ExtractAmbush", undefined, undefined, 1, scripts\mp\poi::function_6cc445c02b5effac(player.origin));
          return;
        }
      }
    }

    wait 1;
  }
}

function exfilplayers(players, var_3064fa24dbbd5bbf) {
  if(!isDefined(var_3064fa24dbbd5bbf)) {
    var_3064fa24dbbd5bbf = namespace_e8fceb5cf6e8cdf8::function_730c660d9fc6808e(players, 0, 0, 0, 0);
  }

  namespace_a8b2b88699fc40fb::function_25a4b6a2083e2ab(players);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player.extracted = 1;
    function_17950170d1365ee0([player]);
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player thread function_ac298c756f30aea6(var_3064fa24dbbd5bbf);
  }
}

function function_ac298c756f30aea6(var_3064fa24dbbd5bbf) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(self)) {
    if(getdvarint(@ "hash_83914b051f41c82d", 1) == 1 && !scripts\mp\gametypes\br_gametypes::isfeaturedisabled("teamSpectate")) {
      scripts\mp\gametypes\br_spectate::migratespectators(self, undefined, 0);
    }

    thread fadetoblack();

    if(istrue(level.var_95de4b6bb41fbbfa[self.team])) {
      self setclientomnvar("ui_dmz_extract_successful", 2);
    } else {
      fullyextracted = 1;

      foreach(player in getteamdata(self.team, "players")) {
        if(!istrue(player.extracted)) {
          fullyextracted = 0;
          break;
        }
      }

      if(fullyextracted) {
        level.var_95de4b6bb41fbbfa[self.team] = 1;
        self setclientomnvar("ui_dmz_extract_successful", 2);
      } else {
        self setclientomnvar("ui_dmz_extract_successful", 1);
      }
    }

    scripts\engine\utility::function_f3bb4f4911a1beb2("scorpion_event", "player_win");
    self.var_e7af56a2df18030d = 0;
    self.exfilpos = self.origin;
    self.spawnprotection = 1;
    scripts\mp\lightarmor::setlightarmorvalue(self, 1000, undefined, 0);
    val::group_register("exfil_success", ["usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch"]);
    val::group_set("exfil_success", 0);
    self allowmovement(0);
    self allowfire(0);
    self freezecontrols(1);
    self notify("successful_exfil");
    wait 0.25;

    if(getdvarint(@ "hash_a186ff3c324cdd8e", 1) == 1) {
      if(isDefined(level.var_11d0c321045f514f) && isDefined(level.var_11d0c321045f514f[self.team])) {
        self playerlinkTo(level.var_11d0c321045f514f[self.team]);
      } else {
        scripts\mp\gametypes\br_spectate::function_3c5421c26d253eb0(0);
        self playerlinkTo(level.var_11d0c321045f514f[self.team]);
      }
    }

    scripts\mp\gametypes\br_gametype_dmz::function_53109b63a7168074();
    function_46f56bf948599140(self);
    thread scripts\mp\hud_message::showsplash("callout_exfil_success");
  }

  if(isDefined(self)) {
    if(isDefined(self.exfilpos)) {
      self setOrigin(self.exfilpos);
    }

    function_a593971d75d82113();
    function_379bb555405c16bb("br_dmz_extract::onPlayerExfilSuccess()");
    self sethidenameplate(0);
    self disableoffhandprimaryweapons(0);
    self disableoffhandsecondaryweapons(0);
    self disableweapons(0);
    self disableweaponswitch(0);
    self setcamerathirdperson(1);
    self allowcrouch(0);
    self allowmelee(0);
    self allowjump(0);
    self allowprone(0);
    self.ignoreme = 1;
    self.plotarmor = 1;
    scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/EXTRACTED_SUCCESS");
    namespace_512200f0f9e6ebc9::function_5332e1c0f06b0245(var_3064fa24dbbd5bbf);

    if(!isDefined(self.var_e7faf08f327b0fb5)) {
      self.var_e7faf08f327b0fb5 = 0;
    }

    totalcashvalue = default_to(self.totalcashvalue, 0);
    self.var_e7faf08f327b0fb5 += scripts\mp\gametypes\dead_drop::function_160a29300ce1e14(totalcashvalue, self, getdvarfloat(@ "hash_ce8c20ac42e3c18a", 0.75));
    var_d6de66cfada71a27 = getdvarfloat(@ "hash_b733889f0b8c700", 1);
    var_689a927d39ba7262 = int(min(totalcashvalue / var_d6de66cfada71a27, getdvarint(@ "hash_890df0079e1885b8", 10000)));
    self.var_26d7a92a39b78748 = var_689a927d39ba7262;
    flatbonus = scripts\mp\rank::getscoreinfoxp(#"hash_a664e407eb3e39d4");

    if(scripts\mp\gametypes\dmz_dog_tag::hasdogtag(self)) {
      flatbonus += getdvarint(@ "hash_2b3cb1f1b979a35b", 500);
    }

    scripts\mp\utility\points::doscoreevent(#"hash_a664e407eb3e39d4", undefined, undefined, flatbonus + var_689a927d39ba7262, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    level thread handleplayerexfildone(self);
    wait 1;
    scripts\mp\gametypes\br_gametype_dmz::function_865b1a5a62c49d7();
  }
}

function function_df3bfe2c77975120() {
  flatbonus = scripts\mp\rank::getscoreinfoxp(#"hash_a664e407eb3e39d4");

  if(scripts\mp\gametypes\dmz_dog_tag::hasdogtag(self)) {
    flatbonus += getdvarint(@ "hash_2b3cb1f1b979a35b", 500);
  }

  scripts\mp\utility\points::doscoreevent(#"hash_a664e407eb3e39d4", undefined, undefined, flatbonus, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\mp\gametypes\br_gametype_dmz::function_865b1a5a62c49d7(1);
  namespace_a38a2e1fe7519183::savecash(self);
}

function function_46f56bf948599140(player) {
  current_team = "unset";

  if(isDefined(player.sessionteam)) {
    current_team = player.sessionteam;
  }

  if(isDefined(player.team)) {
    current_team = player.team;
  }

  lpconlevel = "0";

  if(isDefined(level.var_a7b62649c81b481a) && isDefined(level.var_a7b62649c81b481a.var_acc161de36707de2)) {
    lpconlevel = scripts\engine\utility::string(level.var_a7b62649c81b481a.var_acc161de36707de2);
  }

  var_e259eea64aef58d5 = player namespace_aead94004cf4c147::snapshotbackpack();
  var_7838b9df983ad1ea = [];
  var_ea9dd7d31f4b0630 = player namespace_512200f0f9e6ebc9::snapshotinventory();
  var_a1fc16d2ea055338 = [];
  stowedweapon = namespace_aead94004cf4c147::function_2985254128b1c262(player);

  if(!isDefined(stowedweapon)) {
    stowedweapon = "none";
  } else {
    stowedweapon = stowedweapon.basename;
  }

  foreach(item in var_e259eea64aef58d5) {
    if(!isDefined(item.lootid)) {
      var_7838b9df983ad1ea[var_7838b9df983ad1ea.size] = "null";
      continue;
    }

    itemref = scripts\engine\utility::string(item.lootid);
    var_7838b9df983ad1ea[var_7838b9df983ad1ea.size] = itemref;
  }

  foreach(item in var_ea9dd7d31f4b0630) {
    if(isDefined(item.lootid)) {
      itemref = item.lootid;
      var_a1fc16d2ea055338[var_a1fc16d2ea055338.size] = itemref;
    }
  }

  [streak, perks] = namespace_a38a2e1fe7519183::function_1558f8fb859c492a(player);

  if(!isDefined(streak)) {
    streak = 0;
  }

  data = spawnStruct();
  data.player = player;
  data.current_team = current_team;
  data.x = player.origin[0];
  data.y = player.origin[1];
  data.z = player.origin[2];
  data.xrot = player.angles[0];
  data.yrot = player.angles[1];
  data.zrot = player.angles[2];
  data.lpconlevel = lpconlevel;
  data.matchtimeelapsed = int(getsecondspassed());
  data.extractiontype = "0";
  data.cashtotal = player.plundercount;
  data.backpackitems = var_7838b9df983ad1ea;
  data.stowedweapon = stowedweapon;
  data.loadoutitems = var_a1fc16d2ea055338;
  data.mission1status = "none";
  data.mission2status = "none";
  data.mission3status = "none";
  data.newitemsunlocked = [];
  data.exfilstreak = streak;
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_dmz_on_exfil", data);
}

function handleplayerexfildone(player) {
  scripts\mp\gametypes\br::updateclientmatchdata(player);
  spectatetimer = 5;
  player.var_e7af56a2df18030d = 1;
  wait spectatetimer;

  if(isDefined(player)) {
    if(istrue(player.inlaststand)) {
      if(player scripts\mp\laststand::finishreviveplayer("self_revive_on_kill_success", player)) {
        player scripts\mp\laststand::onrevive(1);
      }
    }

    if(istrue(player.gasmaskequipped)) {
      player thread scripts\mp\gametypes\br_pickups::removegasmaskbr();
    }

    if(istrue(player.insertingarmorplate)) {
      player notify("try_armor_cancel", "game_end");
    }

    player scripts\common\damage_effects::onexitdeathsdoor(0);
    player.spawnprotection = 1;
    level.skipplaybodycountsound = 1;
    player scripts\mp\playerlogic::removefromalivecount(1, "dmzExfil");
    scripts\mp\utility\teams::validatealivecount("extract", player.team, player, "handlePlayerExfilDone");

    if(istrue(level.var_95de4b6bb41fbbfa[player.team])) {
      if(isDefined(self.exfilpos)) {
        spawnpoint = spawnStruct();
        spawnpoint.origin = player.exfilpos;
        spawnpoint.angles = player.angles;
        player scripts\mp\playerlogic::spawnintermission(spawnpoint, undefined, 0);
      } else {
        player scripts\mp\gametypes\br_spectate::spawnintermissionatplayer(player);
      }

      player.br_spectatorinitialized = 1;
      player notify("br_spectatorInitialized");
    } else {
      player thread scripts\mp\gametypes\br_spectate::spawnspectator();
      function_b892c6b4c68c344a([player], 1);
    }

    player setclientomnvar("ui_br_squad_eliminated_active", 1);
    player setclientomnvar("ui_round_end_title", game["round_end"]["victory"]);
    player setclientomnvar("ui_round_end_reason", game["end_reason"]["objective_completed"]);
    player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);
  }

  level thread scripts\mp\gametypes\br_gametype_dmz::function_da0fa1afaa8835cf();
}

function function_eff2a482b361a6ed(player, fadetoblack, fadetime) {
  player notify("start_fade_to_black");
  player endon("start_fade_to_black");
  player endon("disconnect");
  assertex(!isDefined(fadetime) || fadetime >= 0, "<dev string:x1a3>");
  var_400fc540bbc48aa9 = 0;

  if(istrue(fadetoblack)) {
    var_400fc540bbc48aa9 = 1;
  }

  if(!isDefined(fadetime) || fadetime == 0) {
    player setclientomnvar("ui_total_fade", var_400fc540bbc48aa9);
    return;
  }

  finalalpha = var_400fc540bbc48aa9;
  var_400fc540bbc48aa9 = 0;
  fadetimecounter = int(fadetime / level.framedurationseconds);
  fadechange = 1 / fadetimecounter;

  if(!istrue(fadetoblack)) {
    fadechange *= -1;
    var_400fc540bbc48aa9 = 1;
  }

  while(fadetimecounter > 0) {
    var_400fc540bbc48aa9 += fadechange;
    player setclientomnvar("ui_total_fade", var_400fc540bbc48aa9);
    fadetimecounter--;
    waitframe();
  }

  player setclientomnvar("ui_total_fade", finalalpha);
  player notify("finish_fade_to_black");
}

function fadetoblack() {
  level endon("game_ended");
  self endon("disconnect");
  level function_eff2a482b361a6ed(self, 1, 0.25);
  waittill_any_timeout_3(4, "force_spectate_done", "br_team_fully_eliminated", "br_spectatorInitialized");
  level function_eff2a482b361a6ed(self, 0, 1);
}

function function_aaef0bd11948a0c() {
  self waittill("force_spectate_done");

  if(self.hidehudenabled) {
    utility::hidehuddisable();
  }
}

function function_1dcda56efb76e334(team) {
  self endon("disable");
  wait level.var_b91d57df9d8ec00e;
  self setscriptablepartstate("dmz_exfil_smoke", "smoking", 1);
  self setscriptablepartstate("dmz_exfil_site", "ready", 1);

  if(isDefined(team)) {
    self.activatedteams[team] = team;
    function_ac66b79a73b21444(team, self.info);
  }
}

function function_8fc5aeab9cb08048(ent) {
  if(isDefined(ent)) {
    if(level.var_9b3294726f6d3a6 && (!level.var_dd83d323306dcba7 || !level.radiation.spreading)) {
      level thread function_6613aeb065e36928(ent.origin);
    }

    thread function_5bc15f36914e63c7(ent, undefined, undefined, self);
  }
}

function function_33357506b39df2ef() {
  if(level.var_ba138ad5136d87d > 0) {
    currentpercentage = clamp((gettime() - level.var_6c41580562fd09e2) / level.var_ba138ad5136d87d, 0, 1);
    dif = level.var_cd6e8342a9c09c26 - level.var_4be8962610ee659b;
    c = clamp(dif * currentpercentage + level.var_4be8962610ee659b, 0, 1);
    return percent_chance(c);
  } else if(level.var_ba138ad5136d87d == 0) {
    return percent_chance(level.var_cd6e8342a9c09c26);
  }

  return 1;
}

function function_7ff5e35e992df372() {
  if(!isDefined(level.var_6ad981ae12245cbe)) {
    level.var_6ad981ae12245cbe = [];
  }

  if(!isDefined(level.var_6ad981ae12245cbe[self.team])) {
    level.var_6ad981ae12245cbe[self.team] = 0;
  }

  if(level.var_6ad981ae12245cbe[self.team] >= getdvarint(@ "hash_bd34018fbf7c5375", 1)) {
    return false;
  }

  var_f5aa0aac262fbf0b = sortbydistance(level.var_883f54a2a56e126c, self.origin);

  foreach(exfil in var_f5aa0aac262fbf0b) {
    if(istrue(exfil.personal) || istrue(exfil.globallyvisible)) {
      continue;
    }

    exfil.personal = 1;
    level.var_6ad981ae12245cbe[self.team] += 1;
    function_f4dc35c0f47a461c(exfil, self.team);
    exfil.ent setscriptablepartstate("dmz_exfil_icon", "personal_icon");
    return true;
  }

  return false;
}

function function_9a7567a2d46b857a() {
  level endon("game_ended");

  while(!isDefined(level.var_c26f0d22bc1fa7ef)) {
    waitframe();
  }

  if(level.mapname == "mp_ai_firefight") {
    foreach(exfil in level.var_c26f0d22bc1fa7ef) {
      function_bbe41f41d0f13612(exfil);
    }

    return;
  }

  while(!isDefined(level.radiation)) {
    waitframe();
  }

  while(!isDefined(level.radiation.origin)) {
    waitframe();
  }

  while(!isDefined(level.var_1b7407dffe81e6e8) || !isDefined(level.var_1b7407dffe81e6e8.spawndatamap)) {
    waitframe();
  }

  movetonavmesh = getdvarint(@ "hash_b4f00bd105203ec9", 1);
  level.var_449a83b6455a0f37 = getStructArray("dmz_hostage_exfil", "script_noteworthy");

  foreach(exfil in level.var_449a83b6455a0f37) {
    exfil.origin = (0, 0, -10) + ter_op(movetonavmesh == 1, scripts\mp\gametypes\br_public::droptogroundmultitrace(getclosestpointonnavmesh(exfil.origin)), exfil.origin);
    exfil.modelname = "dmz_exfil_site_xmodel";

    if(isDefined(exfil.target)) {
      helinode = getStruct(exfil.target, "targetname");

      if(isDefined(helinode)) {
        exfil.helitargetorigin = helinode.origin;
        exfil.helitargetangles = helinode.angles;
      }
    }

    if(isDefined(exfil.script_label)) {
      if(exfil.script_label == "land") {
        exfil.land = 1;
      }
    }
  }

  if(istrue(level.var_50477dc063210a56)) {
    var_883f54a2a56e126c = [];

    foreach(exfil in level.var_c26f0d22bc1fa7ef) {
      var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
    }

    foreach(exfil in level.var_449a83b6455a0f37) {
      var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
    }

    foreach(exfil in level.var_b95a019fc748357a) {
      var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
    }

    foreach(exfil in var_883f54a2a56e126c) {
      function_bbe41f41d0f13612(exfil);
    }
  } else if(level.var_858dba9da8dc5419 != 0) {
    if(level.var_858dba9da8dc5419 < 0) {
      var_58e0d6d6e9b4c639 = abs(level.var_858dba9da8dc5419);

      foreach(var_36847c9a092f0703 in level.var_5fad09539823f92e) {
        exfils = array_randomize(var_36847c9a092f0703);

        for(i = 0; i < var_58e0d6d6e9b4c639; i++) {
          function_bbe41f41d0f13612(exfils[i]);
        }
      }
    } else {
      exfils = array_randomize(level.var_c26f0d22bc1fa7ef);

      if(exfils.size < level.var_858dba9da8dc5419) {
        level.var_858dba9da8dc5419 = exfils.size;
      }

      var_99a5914efbb9b30 = spawnStruct();
      var_99a5914efbb9b30.points = [];
      var_99a5914efbb9b30.var_f700d2836aab75a4 = [];
      var_99a5914efbb9b30.var_f700d2836aab75a4[0] = [];
      var_99a5914efbb9b30.var_f700d2836aab75a4[1] = [];
      var_99a5914efbb9b30.var_f700d2836aab75a4[2] = [];
      var_99a5914efbb9b30.var_f700d2836aab75a4[3] = [];
      var_99a5914efbb9b30.var_9f9244294d1d74e = [];
      var_99a5914efbb9b30.var_9f9244294d1d74e[0] = [];
      var_99a5914efbb9b30.var_9f9244294d1d74e[1] = [];
      var_99a5914efbb9b30.var_9f9244294d1d74e[2] = [];
      var_99a5914efbb9b30.var_9f9244294d1d74e[3] = [];
      var_99a5914efbb9b30.indexopen = [];
      var_883f54a2a56e126c = [];

      foreach(exfil in level.var_c26f0d22bc1fa7ef) {
        var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
      }

      movetonavmesh = getdvarint(@ "hash_b4f00bd105203ec9", 1);

      foreach(exfil in level.var_449a83b6455a0f37) {
        if(!istrue(exfil.chosen)) {
          exfil.origin = (0, 0, -10) + ter_op(movetonavmesh == 1, scripts\mp\gametypes\br_public::droptogroundmultitrace(getclosestpointonnavmesh(exfil.origin)), exfil.origin);
          exfil.modelname = "dmz_exfil_site_xmodel";
          var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
        }
      }

      level.var_883f54a2a56e126c = var_883f54a2a56e126c;
      var_f5aa0aac262fbf0b = sortbydistance(var_883f54a2a56e126c, level.radiation.origin);

      foreach(point in var_f5aa0aac262fbf0b) {
        relpos = point.origin - level.radiation.origin;
        point.relpos = relpos;
        index = ter_op(relpos[0] < 0, -1, 0) + ter_op(relpos[1] < 0, 3, 1);
        var_99a5914efbb9b30.var_f700d2836aab75a4[index][var_99a5914efbb9b30.var_f700d2836aab75a4[index].size] = point;
      }

      foreach(point in level.var_b95a019fc748357a) {
        relpos = point.origin;
        point.relpos = relpos;
        index = ter_op(relpos[0] < 0, -1, 0) + ter_op(relpos[1] < 0, 3, 1);
        var_99a5914efbb9b30.var_9f9244294d1d74e[index][var_99a5914efbb9b30.var_9f9244294d1d74e[index].size] = point;
      }

      radindex = ter_op(level.radiation.origin[0] * -1 < 0, -1, 0) + ter_op(level.radiation.origin[1] * -1 < 0, 3, 1);

      for(i = 0; i < 4; i++) {
        if(i != radindex) {
          var_99a5914efbb9b30.indexopen[var_99a5914efbb9b30.indexopen.size] = i;
        }
      }

      var_99a5914efbb9b30.indexopen = array_randomize(var_99a5914efbb9b30.indexopen);
      level.var_c5074bf13ffb95ef = var_99a5914efbb9b30.var_9f9244294d1d74e[radindex][randomint(var_99a5914efbb9b30.var_9f9244294d1d74e[radindex].size)];

      if(!isDefined(level.var_c5074bf13ffb95ef)) {
        var_a82a50c49958a9ef = sortbydistance(level.var_b95a019fc748357a, level.radiation.origin);
        level.var_c5074bf13ffb95ef = var_a82a50c49958a9ef[var_a82a50c49958a9ef.size - 1];
      }

      level.var_c919655bc36d8c87 = var_99a5914efbb9b30;
      var_8438f4a482da474a = undefined;
      var_1c2bd1d8ccea9d4b = 0;

      if(isDefined(level.var_a422458ec66a5dfb) && getdvarint(@ "hash_4d4f07cdde717aaf", 0)) {
        var_8438f4a482da474a = [[level.var_a422458ec66a5dfb]](var_f5aa0aac262fbf0b, level.var_b95a019fc748357a, level.var_c5074bf13ffb95ef, level.var_858dba9da8dc5419, level.radiation);

        if(isDefined(var_8438f4a482da474a) && var_8438f4a482da474a.size == level.var_858dba9da8dc5419) {
          var_8438f4a482da474a = array_reverse(var_8438f4a482da474a);
        }
      }

      if(!isDefined(var_8438f4a482da474a)) {
        targetdist = getdvarfloat(@ "hash_d92c4387f959542c", 0.65);
        maxrandom = getdvarint(@ "hash_f24f686449931240", 2);
        mindist = getdvarint(@ "hash_5d9984a8fa843de9", 20000);
        mindist *= mindist;
        midpoint = level.radiation.origin + (level.var_c5074bf13ffb95ef.origin - level.radiation.origin) * targetdist;
        closestpoints = sortbydistance(var_f5aa0aac262fbf0b, midpoint);
        var_8438f4a482da474a = [closestpoints[randomint(maxrandom)]];
        failed = 0;
        curindex = 0;

        for(i = 0; i < level.var_858dba9da8dc5419 - 1; i++) {
          index = i;
          attempts = 0;
          pointfound = 0;

          while(!pointfound && attempts < var_99a5914efbb9b30.indexopen.size) {
            while(index >= var_99a5914efbb9b30.indexopen.size) {
              index -= var_99a5914efbb9b30.indexopen.size;
            }

            foreach(point in var_99a5914efbb9b30.var_f700d2836aab75a4[var_99a5914efbb9b30.indexopen[index]]) {
              if(distance2dsquared(point.origin, level.radiation.origin) < mindist) {
                continue;
              }

              valid = 1;

              foreach(usedpoint in var_8438f4a482da474a) {
                if(distance2dsquared(point.origin, usedpoint.origin) < mindist) {
                  valid = 0;
                  break;
                }
              }

              if(!valid) {
                continue;
              }

              var_8438f4a482da474a[var_8438f4a482da474a.size] = point;
              pointfound = 1;
              break;
            }

            index += 1;
            attempts += 1;
          }

          if(!pointfound) {
            failed += 1;
          }
        }

        if(failed > 0) {
          assertmsg("<dev string:x1da>");

          for(i = 0; i < failed; i++) {
            var_8438f4a482da474a[var_8438f4a482da474a.size] = array_random(var_f5aa0aac262fbf0b);
          }
        }
      }

      foreach(e in var_8438f4a482da474a) {
        function_bbe41f41d0f13612(e);
      }

      assertex(var_8438f4a482da474a.size == level.var_858dba9da8dc5419, "<dev string:x214>");
      level.var_aa174df565129c2b = var_8438f4a482da474a[0];
    }

    timer = getdvarint(@ "scr_br_timelimit");
    waittime = int(max(timer - level.var_b8457c8044b2ee02, 0));

    if(waittime <= 0) {
      return;
    }

    wait waittime;
    level notify("start_dmz_extracts");
    return;
  }

  level.var_45b8ebf14dbc4e63 = [];

  foreach(player in level.players) {
    exfils = getteamdata(player.team, "exfils");

    if(isDefined(exfils) && exfils.size > 0) {
      continue;
    }

    if(level.var_c42d6e4a40f70691 == 0 && level.var_ff04728f8e36403f == 0) {
      function_1c2bd1696d29935b(player.team, "dmz_exfil_intro");
    }

    if(isDefined(player) && isDefined(level.var_c26f0d22bc1fa7ef) && isDefined(level.var_c26f0d22bc1fa7ef[0])) {
      exfil = level.var_c26f0d22bc1fa7ef[0];
      maxdist = 0;
      assertex(isDefined(level.teamdata[player.team]["<dev string:x251>"]), "<dev string:x25f>");

      if(isDefined(level.teamdata[player.team]["startPoint"])) {
        var_ac33fed0dd8063f8 = level.teamdata[player.team]["startPoint"].poi;
        targetpoi = undefined;
        var_e97fc2f67229c010 = ter_op(level.var_9b6b8c7ecb7ac7c0, level.var_58f477e9e7e8f739, level.var_c26f0d22bc1fa7ef);

        if(level.var_c8ff03474c1de67f >= level.poi.size) {
          level.var_c8ff03474c1de67f = level.poi.size - 1;
        }

        if(level.var_e5993849fc7d5987 == 0 && isDefined(var_ac33fed0dd8063f8) && isDefined(level.poi[var_ac33fed0dd8063f8]["otherPoiByDist"])) {
          targetpoi = level.poi[var_ac33fed0dd8063f8]["otherPoiByDist"][level.var_c8ff03474c1de67f];
        }

        for(i = 1; i < var_e97fc2f67229c010.size; i++) {
          if(level.var_d962891163d17d4a == 1) {
            if(isDefined(var_ac33fed0dd8063f8) && var_e97fc2f67229c010[i].poi != var_ac33fed0dd8063f8) {
              continue;
            }
          } else if(level.var_c8ff03474c1de67f != 0 && isDefined(targetpoi)) {
            if(var_e97fc2f67229c010[i].poi != targetpoi) {
              continue;
            }
          }

          dist = distance2dsquared(player.origin, var_e97fc2f67229c010[i].origin);

          if(dist > maxdist) {
            maxdist = dist;
            exfil = var_e97fc2f67229c010[i];
          }
        }
      }

      if(getdvarint(@ "hash_7f50c115586dc8ca", -1) != -1) {
        exfil = level.var_c26f0d22bc1fa7ef[getdvarint(@ "hash_7f50c115586dc8ca", 0)];
      }

      if(level.var_c42d6e4a40f70691 || level.var_ff04728f8e36403f != 0) {
        level.var_45b8ebf14dbc4e63[player.team] = exfil;
        continue;
      }

      if(level.var_cdc76bc962358072) {
        function_bbe41f41d0f13612(exfil);
        continue;
      }

      exfil.activatedteams[player.team] = player.team;
      function_ac66b79a73b21444(player.team, exfil);

      if(getdvarint(@ "hash_f0fc10ceb2d6142c", 0) == 0) {
        if(isDefined(exfil.activatedteams) && exfil.activatedteams.size > 0) {
          function_b513aaf6e49f184a(exfil);
          continue;
        }

        function_bbe41f41d0f13612(exfil);
      }
    }
  }

  timer = getdvarint(@ "scr_br_timelimit");
  waittime = int(max(timer - level.var_b8457c8044b2ee02, 0));

  if(waittime <= 0) {
    return;
  }

  wait waittime;
  level notify("start_dmz_extracts");
}

function private function_d92380bfc792a6a9() {
  wait 10;

  while(true) {
    if(getDvar(@ "hash_ec9d0bc135119057", "") != "") {
      val = getDvar(@ "hash_ec9d0bc135119057", "");
      setDvar(@ "hash_ec9d0bc135119057", "");

      if(isDefined(level.var_fe2e551da0962c3c)) {
        foreach(exfil in level.var_fe2e551da0962c3c) {
          function_97061811695243ea(exfil);
        }
      }

      vals = strtok(val, " ");
      movetonavmesh = getdvarint(@ "hash_b4f00bd105203ec9", 1);
      var_883f54a2a56e126c = [];

      if(array_contains(vals, "hostage") && isDefined(level.var_449a83b6455a0f37)) {
        foreach(exfil in level.var_449a83b6455a0f37) {
          exfil.origin = (0, 0, -10) + ter_op(movetonavmesh == 1, scripts\mp\gametypes\br_public::droptogroundmultitrace(getclosestpointonnavmesh(exfil.origin)), exfil.origin);
          exfil.modelname = "dmz_exfil_site_xmodel";
          var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
        }
      }

      if(array_contains(vals, "normal") && isDefined(level.var_c26f0d22bc1fa7ef)) {
        foreach(exfil in level.var_c26f0d22bc1fa7ef) {
          var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
        }
      }

      if(array_contains(vals, "final") && isDefined(level.var_b95a019fc748357a)) {
        foreach(exfil in level.var_b95a019fc748357a) {
          var_883f54a2a56e126c[var_883f54a2a56e126c.size] = exfil;
        }
      }

      foreach(exfil in var_883f54a2a56e126c) {
        function_bbe41f41d0f13612(exfil);
      }
    }

    if(getdvarint(@ "hash_a48fc6794f79a816", 0) == 1) {
      player = level.players[0];
      activitystruct = spawnStruct();
      activitystruct.poi = array_randomize(level.poi)[0];
      player.brmissionscompleted++;
      player setclientomnvar("ui_dmz_missions_completed", player.brmissionscompleted);
      function_52781be0b4e8a959(player.team, activitystruct);
      wait 4;
    }

    if(getdvarint(@ "hash_dfbc149f9d4e85bf", 0) == 1) {
      foreach(player in level.players) {
        player dodamage(999999, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }

      setDvar(@ "hash_dfbc149f9d4e85bf", 0);
    }

    wait 1;
  }
}

function function_52781be0b4e8a959(team, activity) {
  level.var_cc6f9cf228accb4[team]++;

  if(istrue(level.dmzradiationstart)) {
    return;
  }

  if(level.var_8f7d92f10fc80ce) {
    if(level.var_cc6f9cf228accb4[team] % level.var_8f7d92f10fc80ce != 0) {
      return;
    }

    if(level.var_9b6b8c7ecb7ac7c0) {
      var_204f99d788c2c529 = level.var_58f477e9e7e8f739[0];

      foreach(exfil in level.var_58f477e9e7e8f739) {
        if(!array_contains_key(exfil.activatedteams, team)) {
          if(exfil.activatedteams.size > level.var_628f636de1f2dda3) {
            var_204f99d788c2c529 = exfil;
            continue;
          }

          if(level.var_1eff61a95657ca2 && isDefined(level.teamdata[team]["startPoint"].poi) && exfil.poi == level.teamdata[team]["startPoint"].poi) {
            continue;
          }

          level thread function_f9ddc1898e570753(exfil, team);
          return;
        }
      }

      if(isDefined(var_204f99d788c2c529)) {
        level.var_628f636de1f2dda3 += 1;
        level thread function_f9ddc1898e570753(var_204f99d788c2c529, team);
      }

      return;
    } else {
      players = scripts\mp\utility\teams::getfriendlyplayers(team, 1);
      poi = ter_op(isDefined(activity.poi), activity.poi, scripts\mp\poi::function_6cc445c02b5effac(players[0].origin));
      exfil = function_ffef19d55026b498(team, activity.poi);

      if(isDefined(exfil)) {
        level thread function_f9ddc1898e570753(exfil, team);
        return;
      }
    }
  }

  if(level.var_cc6f9cf228accb4[team] != level.var_c42d6e4a40f70691) {
    return;
  }

  level thread function_ed7bc1aaeb97b0ef(team);
}

function function_f9ddc1898e570753(exfil, team) {
  wait 4;
  exfil.activatedteams[team] = team;
  function_ac66b79a73b21444(team, exfil);
  players = scripts\mp\utility\teams::getfriendlyplayers(team, 1);
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_exfil_ready", players, exfil.poi);

  if(getdvarint(@ "hash_f0fc10ceb2d6142c", 0) == 0) {
    if(isDefined(exfil.activatedteams) && exfil.activatedteams.size > 0) {
      function_b513aaf6e49f184a(exfil);
      return;
    }

    function_bbe41f41d0f13612(exfil);
  }
}

function function_ed7bc1aaeb97b0ef(team) {
  wait 4;
  exfil = level.var_45b8ebf14dbc4e63[team];
  exfil.activatedteams[team] = team;
  function_ac66b79a73b21444(team, exfil);
  players = scripts\mp\utility\teams::getfriendlyplayers(team, 1);
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_exfil_ready", players, exfil.poi);
  scripts\mp\utility\dialog::leaderdialog("dmz_contract_complete_2", team);

  if(getdvarint(@ "hash_f0fc10ceb2d6142c", 0) == 0) {
    if(isDefined(exfil.activatedteams) && exfil.activatedteams.size > 0) {
      function_b513aaf6e49f184a(exfil);
      return;
    }

    function_bbe41f41d0f13612(exfil);
  }
}

function function_ffef19d55026b498(team, poi) {
  newinfo = undefined;

  if(!isDefined(level.var_5fad09539823f92e[poi])) {
    return undefined;
  }

  foreach(exfil in level.var_5fad09539823f92e[poi]) {
    if(exfil.activatedteams.size == 0 || level.var_4644c9da9a611950) {
      newinfo = exfil;
    }

    if(array_contains_key(exfil.activatedteams, team)) {
      return undefined;
    }
  }

  return newinfo;
}

function function_40d3fb596096ac55(player) {
  player function_6c155294223488b5(undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
}

function function_595eede45a673b1f(players, poi, finalexfil) {
  if(istrue(finalexfil)) {
    scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_exfil_inbound_final", players, poi);
    return;
  }

  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("dmz_exfil_inbound", players, poi);
}

function function_779fdc701bfa688(players, finalexfil) {
  function_3a594b90827cde7e("dmz_exfil_start", players, finalexfil, "dmz_exfil_start_classic");

  foreach(player in players) {
    if(isPlayer(player)) {
      player.var_2441210fe6eea080 = 1;
    }
  }
}

function function_133deebbe58fb347(players, team, finalexfil, ent, waittimer) {
  if(!istrue(finalexfil)) {
    if(scripts\mp\gamelogic::gettimeremaining() / 1000 < 30 + level.var_9405abd1db7cf2cf || namespace_7789f919216d38a2::function_28f7a303238284ee()) {
      function_1c2bd1696d29935b(team, "dmz_exfil_pilot_called_gas");
    } else {
      function_1c2bd1696d29935b(team, "dmz_exfil_pilot_called_default");
    }
  }

  if(waittimer >= 45) {
    waittimer -= 30;
    wait waittimer;
    function_efd3004bcaa728f("dmz_exfil_pilot_called_30out", players);
    waittimer = 30;
  }

  if(waittimer >= 30) {
    waittimer -= 15;
    wait waittimer;
    function_efd3004bcaa728f("dmz_exfil_pilot_called_15out", players);
    waittimer = 15;
  }

  wait waittimer;

  if(!isDefined(ent) || istrue(ent.disabled)) {
    return;
  }

  function_efd3004bcaa728f("dmz_exfil_pilot_called_close", players);
}

function function_25e48c3d85f4a59c(players, heli) {
  if(isDefined(heli.gasmasks)) {
    function_efd3004bcaa728f("dmz_exfil_pilot_called_masks", players);
    return;
  }

  function_efd3004bcaa728f("dmz_exfil_pilot_called_touchdown", players);
}

function function_a0d539b960b93bb(players, finalexfil) {
  if(istrue(finalexfil)) {
    function_efd3004bcaa728f("dmz_exfil_pilot_called_final_leaving", players);
  }
}

function function_ab7f97a0b46cbeaf(players) {
  function_efd3004bcaa728f("dmz_exfil_pilot_called_final_warning", players);
}

function function_e392fd7cad768e25() {
  if(!isDefined(self)) {
    assertmsg("<dev string:x2b5>");
    return;
  }

  if(!isDefined(self.team)) {
    assertmsg("<dev string:x309>");
    return;
  }

  function_1c2bd1696d29935b(self.team, "dmz_exfil_pilot_called_shortcut");
}

function function_aa3139c5fae701b8(heli) {
  if(scripts\mp\gamelogic::gettimeremaining() / 1000 < 30 || namespace_7789f919216d38a2::function_28f7a303238284ee()) {
    var_bf80f581fdce86d2 = heli.angles + (0, -90, -18);
    var_840c2ee92c8f78fe = [(33, 40, -198), (-15, 40, -198), (-58, 40, -198), (-105, 40, -198)];

    foreach(offset in var_840c2ee92c8f78fe) {
      relativeoffset = rotatevector(offset, heli.angles);
      dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(heli.origin + relativeoffset, var_bf80f581fdce86d2);
      gasmask = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_equip_gasmask", dropinfo, 108);
      gasmask utility::function_6e506f39f121ea8a(heli, offset);
    }
  }
}

function function_113d0e9d241c8568(players, finalexfil) {}

function function_704dc2a5075c58b9(players) {
  foreach(player in players) {
    if(isPlayer(player) && !istrue(player.extracted)) {
      player.var_2441210fe6eea080 = undefined;
      player notify("end_heli_exit_listener");
      function_b892c6b4c68c344a([player], 2);
    }
  }
}

function function_1ce7b362085d943e(players, finalexfil) {
  function_3a594b90827cde7e("dmz_exfil_start", players, finalexfil, "dmz_exfil_start_classic");

  foreach(player in players) {
    thread function_2094ef55dee7b236(player);
  }
}

function function_b1219a25435ab949(players) {}

function function_17950170d1365ee0(players) {
  function_3a594b90827cde7e("dmz_exfil_end", players);
  function_2eda2621150bd589(players, 4);
}

function function_e7994a561be9b933(players) {
  function_3a594b90827cde7e("dmz_exfil_manual", players);
  function_2eda2621150bd589(players, 4);
}

function function_2094ef55dee7b236(player) {
  player notify("end_heli_exit_listener");
  player endon("end_heli_exit_listener");
  player waittill("exited_chopper");

  if(istrue(player.extracted)) {
    return;
  }

  function_b892c6b4c68c344a([player], 1);
  function_3a594b90827cde7e("dmz_exfil_abort", [player]);
}

function function_673f07bb8a61bcf3(ent, playersleft) {
  if(level.var_662586ede589f49c && playersleft) {
    ent.info.used = 1;
    ent delete();
    return;
  }
}

function function_5bc15f36914e63c7(ent, part, state, player, waittime, var_292d5d91fb6427ff, finalexfil) {
  namespace_e8fceb5cf6e8cdf8::function_d1478474b036b87f(ent, part, state, player, waittime, var_292d5d91fb6427ff, finalexfil);
}

function function_184ff6b45e3f1b70() {
  self endon("death_or_disconnect");
  scripts\mp\gametypes\br_public::playerplaygestureweaponanim("iw8_ges_plyr_plunder_smoke", 1.867);
}

function function_6c155294223488b5(weaponobject, localizedstring) {
  self iprintlnbold(localizedstring);
  self playlocalsound("br_pickup_deny");

  if(isDefined(weaponobject)) {
    ammo = self getweaponammoclip(weaponobject);
    self setweaponammoclip(weaponobject, ammo + 1);
  }
}

function callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner)) {
      attacker = attacker.owner;
    }
  }

  if(istrue(level.var_f7c6553e5222163f)) {
    return;
  }

  if((attacker == self || isDefined(attacker.pers) && attacker.pers["team"] == self.team && !level.friendlyfire && level.teambased) && attacker != self.owner) {
    return;
  }

  if(self.health <= 0) {
    return;
  }

  damage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::killstreakhit(attacker, objweapon, self, meansofdeath, damage);
  attacker updatedamagefeedback("");

  if(self.health - damage <= 900 && (!isDefined(self.smoking) || !self.smoking)) {
    self.smoking = 1;
  }

  self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname);
}

function function_efd3004bcaa728f(dialog, players) {
  soundname = game["dialog"][dialog];

  foreach(player in players) {
    if(isDefined(player) && isreallyalive(player)) {
      player queuedialogforplayer(soundname, dialog, 2);
    }
  }
}

function function_9fdf14c5aac8ce53(dialog) {
  soundname = game["dialog"][dialog];

  foreach(player in level.players) {
    if(!isbot(player) && isDefined(player) && isreallyalive(player)) {
      player queuedialogforplayer(soundname, dialog, 2);
    }
  }
}

function function_1c2bd1696d29935b(teamname, dialog) {
  soundname = game["dialog"][dialog];

  foreach(teammember in getteamdata(teamname, "players")) {
    if(isDefined(teammember) && isreallyalive(teammember)) {
      teammember queuedialogforplayer(soundname, dialog, 2);
    }
  }
}

function function_c5f291acf1b44b69(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(!isDefined(instance) || !isDefined(player)) {
    return;
  }

  player thread function_8fc5aeab9cb08048(instance.entity);
  instance setscriptablepartstate("dmz_exfil_site", "standby");
}

function function_3a594b90827cde7e(music, var_3a3d1b991ac7ba41, var_7e6513b2ae0d5c1d, var_6b9a0dbbf039dece) {
  musicstate = function_17ee301cf0b5ba85(music);
  var_cbfb00f6fdb0afba = function_17ee301cf0b5ba85(var_6b9a0dbbf039dece);

  if(isarray(var_3a3d1b991ac7ba41)) {
    players = var_3a3d1b991ac7ba41;
    function_fe75a89529dd0fd0(players, musicstate, undefined, undefined, var_cbfb00f6fdb0afba);
    return;
  }

  if(isstring(var_3a3d1b991ac7ba41)) {
    team = var_3a3d1b991ac7ba41;
    function_46979d2fd81a6d4b(team, musicstate, undefined, var_cbfb00f6fdb0afba);
  }
}

function function_2eda2621150bd589(players, fadetime) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player setsoundsubmix("iw9_mp_dmz_exfil_fadeout", fadetime);
    player.var_30dc7dfd9be2a276 = 1;
  }

  scripts\cp_mp\overlord::function_2c722a2ef9574e87(players, "exfil_fadeout", 120);
}

function function_b892c6b4c68c344a(players, fadetime) {
  foreach(player in players) {
    player clearsoundsubmix("iw9_mp_dmz_exfil_fadeout", fadetime);
    player.var_30dc7dfd9be2a276 = undefined;
  }

  scripts\cp_mp\overlord::function_70979c1eabf04180(players, "exfil_fadeout");
}

function function_ac66b79a73b21444(team, var_3064fa24dbbd5bbf) {
  var_3fe83c7fbe0f3dfc = array_add(getteamdata(team, "exfils"), var_3064fa24dbbd5bbf);
  scripts\mp\utility\teams::setteamdata(team, "exfils", var_3fe83c7fbe0f3dfc);

  namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x361>", team, undefined, undefined, undefined, undefined, var_3064fa24dbbd5bbf.poi, var_3064fa24dbbd5bbf.origin);
}