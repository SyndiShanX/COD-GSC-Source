/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_75377e59f5becac8.gsc
*************************************************/

#using script_142b065a6cb7bf82;
#using script_1a2a18b8a4837a05;
#using script_289ea7ea13a4a6cc;
#using script_4500eeb43be80324;
#using script_7933519955f32c4e;
#using script_7cfb984d8451dc2a;
#using script_930a1e7bd882c1d;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\class;
#using scripts\mp\deathicons;
#using scripts\mp\equipment\molotov;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\equipment\thermite;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_infils_ac130;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\br_vehicles;
#using scripts\mp\music_and_dialog;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace namespace_59982bac4da47c6f;

function main() {
  namespace_973962356ce55fee::init();

  if(namespace_973962356ce55fee::function_b4e9d46918f067bb()) {
    return;
  }

  assert(!isDefined(level.infilstruct));
  level.infilstruct = spawnStruct();
  level.infilstruct.players = [];

  if(getdvarint(@ "hash_2be93dd484220a45", 0) == 1) {
    register_state(0, "prematch", &state_prematch);
    register_state(1, "fadedown", &function_d2e5a4473e27019);
    register_state(2, "streaming", &function_6e7a11c7804fe019);
    register_state(3, "cinematic", &state_cinematic);
    register_state(4, "animatic", &function_c1e0d339c6959b81);
    register_state(5, "flyover", &state_flyover);
    register_state(6, "done", &state_done);
  } else {
    register_state(0, "prematch", &state_prematch);
    register_state(1, "fadedown", &function_d2e5a4473e27019);
    register_state(2, "streaming", &function_d23657823446b3a1);
    register_state(3, "cinematic", &state_cinematic);
    register_state(4, "animatic", &function_6cc48d378966bc2f);
    register_state(5, "flyover", &state_flyover);
    register_state(6, "done", &state_done);
  }

  function_fe85c23fc6fa8c2();
  function_c03893a40366ed07();
  level thread function_891dc8f3bb2a44aa();

  thread testdvarloop();
}

function function_891dc8f3bb2a44aa() {
  level endon("game_ended");
  level endon("kill_state_machine");
  level.infilcurrentstate = undefined;
  waitframe();
  startstate = 0;

  while(true) {
    if(!isDefined(level.infilcurrentstate)) {
      set_state(startstate);
    } else {
      set_state(level.infilcurrentstate + 1);
    }

    if(level.infilcurrentstate == 6) {
      break;
    }
  }
}

function private kill_state_machine() {
  level notify("kill_state_machine");
}

function register_state(statenum, statename, statefunc) {
  if(!isDefined(level.infilstates)) {
    level.infilstates = [];
  }

  assert(!isDefined(level.infilstates[statenum]));
  newstate = spawnStruct();
  newstate.name = statename;
  newstate.statefunc = statefunc;
  level.infilstates[statenum] = newstate;
}

function set_state(statenum) {
  level.infilcurrentstate = statenum;
  newstatedata = level.infilstates[level.infilcurrentstate];

  if(isDefined(level.infilstruct.statecallbacks[newstatedata.name])) {
    [[level.infilstruct.statecallbacks[newstatedata.name]]]();
  }

  if(isDefined(newstatedata.statefunc)) {
    [[newstatedata.statefunc]]();
  }
}

function state_prematch() {
  c130pathstruct = undefined;

  if(!istrue(level.br_infils_disabled) && !istrue(level.var_59ff09549058dda2)) {
    if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("createC130PathStruct")) {
      c130pathstruct = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("createC130PathStruct");
    } else {
      c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path(level.var_b88975a1f2a5e092, undefined);
    }
  }

  level.infilstruct.c130pathstruct = c130pathstruct;

  if(getdvarint(@ "hash_602981760e1c923d", 1)) {
    if(!istrue(level.skipprematch) && !istrue(level.prematchstarted)) {
      level waittill("start_prematch");
    }

    if(isDefined(level.infilstruct.var_eb0cd5e47dbbfd6a)) {
      [[level.infilstruct.var_eb0cd5e47dbbfd6a]]();
      function_6199c35f4cf4524c(&function_ab16b6a69b739179);
      thread function_6d2764481349d838();
    }
  }

  if(!istrue(level.prematchstarted)) {
    level waittill("prematch_started");
  }

  if(istrue(level.br_infils_disabled)) {
    level.infilstruct.players = scripts\mp\gametypes\br_utility::function_22a0e95dd4174c81();
    scripts\mp\flags::gameflagset("prematch_fade_done");
    waitframe();
    level.allowprematchdamage = 0;
    forcespawnplayers(level.infilstruct.players);
    function_ec7fe6e7834d5d70();

    if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
      level.disablespawning = 1;
      setdynamicdvar(hashcat(@ "scr_", getgametype(), "_numLives"), 1);
    }

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      player.plotarmor = undefined;

      if(istrue(level.var_3a92df26d817352d)) {
        player thread scripts\mp\gametypes\br::givestandardtableloadout(0, 1);
      }
    }

    scripts\mp\flags::gameflagset("br_ready_to_jump");
    kill_state_machine();
    return;
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("infilSequence")) {
    scripts\mp\gametypes\br_gametypes::runbrgametypefunc("infilSequence");
    scripts\mp\flags::gameflagset("br_ready_to_jump");
    kill_state_machine();
  }
}

function function_ab16b6a69b739179() {
  if(isDefined(level.infilstruct.var_5a3d20651fd80005)) {
    self[[level.infilstruct.var_5a3d20651fd80005]]();
  } else {
    self setallstreamloaddist(0);
  }

  self predictstreamposuntilcleared(level.infilstruct.var_6930961c8a8d33fc);
}

function function_6d2764481349d838() {
  while(true) {
    if(level.infilcurrentstate > 3) {
      break;
    }

    foreach(player in level.players) {
      if(isDefined(level.infilstruct.var_5a3d20651fd80005)) {
        player[[level.infilstruct.var_5a3d20651fd80005]]();
      } else {
        player setallstreamloaddist(0);
      }

      player predictstreamposuntilcleared(level.infilstruct.var_6930961c8a8d33fc);
    }

    wait 10;
  }
}

function function_d2e5a4473e27019() {
  if(isDefined(level.var_c5877dbe60fddbf6)) {
    foreach(codcaster in level.var_c5877dbe60fddbf6) {
      codcaster setclientomnvar("ui_br_infil_started", 1);
      codcaster setclientomnvar("ui_br_infiled", 0);
    }
  }

  assert(isDefined(level.infilstruct.c130pathstruct));
  scripts\mp\gametypes\br_c130::spawnc130(level.infilstruct.c130model, level.infilstruct.var_30e653e12f358438, level.infilstruct.var_c3a4f4442070a8b5, level.infilstruct.c130pathstruct, level.infilstruct.var_a6547e85663b3bc2, level.infilstruct.c130soundalias);
  assert(isDefined(level.br_ac130));
  level.infilstruct.c130 = level.br_ac130;
  level.infilstruct.players = scripts\mp\gametypes\br_utility::function_22a0e95dd4174c81();

  if(function_176ea5668fe41dad()) {
    level.infilstruct.players = array_remove(level.infilstruct.players, level.player);
  }

  function_8252134bb4aaa66b();

  if(level.var_7647df14c1f116f7 && isDefined(level.infilstruct.var_6f0c032ec6e5d14)) {
    [[level.infilstruct.var_6f0c032ec6e5d14]](level.infilstruct.c130.animstruct);
  }

  scripts\mp\deathicons::removealldeathicons();
  setomnvar("ui_hide_player_icons", 1);
  level.br_c130spawndone = 0;
  level.infiltransistioning = 1;
  level.infilcinematicactive = 1;
  level.allowprematchdamage = 0;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player function_38f6e236e493c28b();
    function_2de90f865b7ce99d(player);
  }

  function_6199c35f4cf4524c(&function_540bab0e9a607717);
  level.infilstruct.c130 thread gunship_updateplayercount();
  waitandpause(1);
  waitframe();
}

function private function_38f6e236e493c28b() {
  if(isDefined(level.infilstruct.var_5a3d20651fd80005)) {
    self[[level.infilstruct.var_5a3d20651fd80005]]();
  } else {
    self setallstreamloaddist(-1);
  }

  if(istrue(level.var_7647df14c1f116f7)) {
    self predictstreamposuntilcleared(level.infilstruct.var_3a6128a99dc22eb2);
  } else if(function_7812117b17c4d21e() == "hq_ac130_v2") {
    self predictstreamposuntilcleared(level.infilstruct.c130.animstruct.origin);
  } else {
    self predictstreamposuntilcleared(level.infilstruct.c130.origin);
  }

  function_179ad01817ae940b(level.infilstruct.c130);
  function_1b7e57bfe648f609();
  function_10f93bb3f3966751(1, "stateMachine");
  self setclientdvar(@ "hash_b21f1157c582ff15", 0);
}

function function_540bab0e9a607717() {
  self endon("disconnect");
  function_38f6e236e493c28b();
  waitandpause(1);
  waitframe();
}

function private function_179ad01817ae940b(c130) {
  self.c130 = c130;

  if(!scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    utility::hidehudenable();
  }

  scripts\mp\class::blockclasschange();

  if(self isnoclip()) {
    self noclip();
  }

  if(self isufo()) {
    self ufo();
  }
}

function private gunship_updateplayercount() {
  level endon("game_ended");
  self notify("ac130_player_count");
  self endon("ac130_player_count");
  level.infilstruct.playersinc130 = 0;

  while(true) {
    setomnvar("ui_br_players_left_in_plane", level.infilstruct.playersinc130);

    if(!isDefined(self)) {
      break;
    }

    wait 0.5;
  }
}

function function_d23657823446b3a1() {
  scripts\mp\gametypes\br_vehicles::emptyallvehicles();
  setomnvar("ui_in_infil", 1);
  scripts\mp\flags::gameflagset("prematch_fade_done");

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player setclientomnvar("ui_options_menu", 0);
  }

  forcespawnplayers(level.infilstruct.players, level.infilstruct.c130.origin, level.infilstruct.c130);
  level.snatchspawnalltoc130done = 1;
  function_ec7fe6e7834d5d70();

  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    level.disablespawning = 1;
    setdynamicdvar(hashcat(@ "scr_", getgametype(), "_numLives"), 1);
  }

  function_6199c35f4cf4524c(&function_f6248665c763b00f);
  waitandpause(getdvarfloat(@ "hash_669c21dc4d23066d", 3));

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!istrue(level.infilstruct.var_2a959f4ba13b75da)) {
      player clearpredictedstreampos();
    }

    player endprematchskydiving();
    player.br_isininfil = 1;

    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
      player setclientomnvar("ui_options_menu", -1);
    }
  }

  function_583f118c4064ca21(level.infilstruct.players);
  function_6199c35f4cf4524c(&function_c3d1219a613ebcdf);
}

function function_6e7a11c7804fe019() {
  function_d23657823446b3a1();
  waittime = getdvarfloat(@ "hash_ff017df91bbce1b3", 10);
  lobbysize = function_425d34ddd114f3de();

  lobbysize = getdvarint(@ "hash_a1a244c93c599fe8", lobbysize);

  while(level.players.size < lobbysize) {
    waittime -= level.framedurationseconds;

    if(waittime < 0) {
      break;
    }

    waitframe();
  }

  if(getdvarint(@ "hash_9be38b3a8782259c", 0) == 1) {
    return;
  }

  wait getdvarfloat(@ "hash_fbe5ab97a6675878", 10);
  function_d5131497d473cb79("");

  foreach(player in level.players) {
    player setsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2);
  }

  setomnvar("ui_in_infil", 3);
  wait getdvarfloat(@ "hash_a707d8e7bcd8e3a7", 118);

  foreach(player in level.players) {
    player clearsoundsubmix("fade_to_black_all_except_music_scripted5_and_amb", 2);
  }
}

function function_f6248665c763b00f() {
  self endon("disconnect");
  forcespawnplayers([self], level.infilstruct.c130.origin, level.infilstruct.c130);
  function_d392b52249d2a8fe();
}

function function_c3d1219a613ebcdf() {
  self endon("disconnect");
  self clearpredictedstreampos();
  endprematchskydiving();
  self.br_isininfil = 1;
  function_423115ed15f21e05(self.team);
}

function private forcespawnplayer() {
  self endon("disconnect");

  if(self.class == "") {
    self.class = "custom1";
    self.pers["class"] = "custom1";
  }

  scripts\mp\playerlogic::spawnplayer(0);
  self.br_infilstarted = 1;
  self notify("brWaitAndSpawnClientComplete");
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

function private forcespawnplayers(players, spawnorigin, var_f60347f29feec261) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!isDefined(player.team) || player.team == "spectator" || player.team == "codcaster") {
      assertmsg("<dev string:x1c>");
      continue;
    }

    prevpos = player.origin;
    player endprematchskydiving();
    player clearladderstate();

    if(isalive(player)) {
      player stopliveragdoll();
    }

    if(!istrue(level.br_infils_disabled)) {
      player scripts\mp\gametypes\br::playerexecutionsdisable();
      player scripts\common\values::set("br_infil", "offhand_throwback", 0);
    }

    player.var_e3bb1b362fbe3cc5 = undefined;

    if(!isalive(player)) {
      if(istrue(player.waitingtospawnamortize)) {
        player waittill_either("spawned_player", "disconnect");

        if(isDefined(player) && isDefined(spawnorigin)) {
          player setOrigin(spawnorigin);
        }
      } else {
        if(isDefined(spawnorigin)) {
          player.forcespawnorigin = spawnorigin;
        }

        player forcespawnplayer();
      }
    } else if(isDefined(spawnorigin)) {
      player setOrigin(spawnorigin);
    }

    if(!isDefined(player)) {
      continue;
    }

    player thread function_e139474e71a93fb0();
    player.br_infilstarted = 1;
    player thread[[level.parachutetakeweaponscb]]();
    player.plotarmor = 1;

    if(isDefined(var_f60347f29feec261)) {
      player playerlinkTo(var_f60347f29feec261);
      player.c130 = var_f60347f29feec261;

      if(function_60597da56f99d304(player)) {
        player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
        player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_infils_common::forceSpawnPlayers()");
      }
    }

    if(istrue(player.br_iseliminated)) {
      scripts\mp\gametypes\br_utility::unmarkplayeraseliminated(player, "forceSpawnPlayers");
    }

    if(isDefined(spawnorigin)) {
      scripts\mp\gametypes\br_gametypes::function_d72afaccedfc946e("onPlayerTeleport", player, prevpos, spawnorigin, "c130");
    }

    player notify("beginC130");
  }
}

function private function_e139474e71a93fb0() {
  self endon("disconnect");
  player = self;
  waittillframeend();
  var_dc6bf94dbaaa7056 = getmatchrulesdata("commonOption", "infilArmor");
  infilreserveplates = getmatchrulesdata("commonOption", "infilReservePlates");
  player scripts\cp_mp\armor::givestartingarmor(var_dc6bf94dbaaa7056, undefined, infilreserveplates);
}

function private function_ec7fe6e7834d5d70() {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("squadLeader")) {
    return;
  }

  if(level.teambased) {
    foreach(team in level.teamnamelist) {
      teamplayers = getteamdata(team, "players");
      brsquadleader = setupbrsquadleader(teamplayers);

      if(isDefined(brsquadleader)) {
        registerbrsquadleaderjumpcommands(brsquadleader);
        brsquadleader thread watchbrsquadleaderdisconnect(team);
      }

      scripts\mp\gametypes\br::updatesquadleaderpassstateforteam(team);
    }

    return;
  }

  foreach(player in level.infilstruct.players) {
    if(isDefined(player)) {
      registerbrsquadleaderjumpcommands(player);
    }
  }
}

function private function_d392b52249d2a8fe() {
  if(scripts\mp\gametypes\br_gametypes::isfeaturedisabled("squadLeader")) {
    return;
  }

  if(level.teambased) {
    teamplayers = getteamdata(self.team, "players");
    brsquadleader = setupbrsquadleader(teamplayers);

    if(isDefined(brsquadleader)) {
      registerbrsquadleaderjumpcommands(brsquadleader);
      brsquadleader thread watchbrsquadleaderdisconnect(self.team);
    }

    scripts\mp\gametypes\br::updatesquadleaderpassstateforteam(self.team);
    return;
  }

  registerbrsquadleaderjumpcommands(self);
}

function state_cinematic() {
  playvideo();
  function_749c46213cdb834();

  if(isDefined(level.infilstruct.binkname)) {
    function_7f3ad8fe6df1b8fe(0.3, level.infilstruct.players, "stateMachine");
  }
}

function function_9215bf6c0287802c() {
  self endon("disconnect");
  function_12ccccd25dafe834();
}

function function_6cc48d378966bc2f() {
  function_1696e6e3ac4a370a();

  if(!isDefined(level.infilstruct.binkname)) {
    function_7f3ad8fe6df1b8fe(1, level.infilstruct.players, "stateMachine");
  }

  if(level.var_7647df14c1f116f7) {
    function_6199c35f4cf4524c(&function_1ef9f2a9d0d8f157);
  } else {
    function_6199c35f4cf4524c(&function_32583056e04e8645);
  }

  function_8d001511b174ef1e();
}

function function_c1e0d339c6959b81() {
  function_1696e6e3ac4a370a();
  function_7f3ad8fe6df1b8fe(1, level.infilstruct.players, "stateMachine");
  function_6199c35f4cf4524c(&function_6ee3f813b3c2d7af);
  level.infilstruct.c130.animstruct scripts\mp\gametypes\br_infils_ac130::teleporttomovingplane();
  level.br_ac130 setscriptablepartstate("running_lights", "on");
  level.br_ac130 notify("start_moving");
}

function function_6ee3f813b3c2d7af() {
  function_1162dbfdb942d179(1, "stateMachine");
}

function function_1ef9f2a9d0d8f157() {
  self endon("disconnect");
  self notify("beginC130");

  if(level.infilcurrentstate == 4) {
    level.infilstruct.c130 waittill("start_moving");
  }

  function_1162dbfdb942d179(1, "stateMachine");
  _freezelookcontrols(0);
  function_423115ed15f21e05(self.team);
}

function function_32583056e04e8645() {
  self endon("disconnect");
  self notify("beginC130");
  function_1162dbfdb942d179(1, "stateMachine");
  function_6d8ac534ad288aa5(self);
  _freezelookcontrols(1);
  activepack = undefined;

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.animstruct)) {
    activepack = level.infilstruct.animstruct.activepack;
  }

  if(isDefined(activepack.playerfunc)) {
    level.infilstruct.animstruct[[activepack.playerfunc]](self, activepack.var_5ab13b55d7ceff80);
  }

  if(activepack.islooping) {
    _freezelookcontrols(0);
    activepack function_8839d2f2f530a0b9(self);
    wait 1;
    self cameraunlink();
    self stopxcam();
    thread scripts\mp\gametypes\br_c130::orbitcam(level.infilstruct.c130);
    function_423115ed15f21e05(self.team);
    return;
  }

  self cameraunlink();
  self stopxcam();
  activepack function_bda88f27a0337eaa(self);
  activepack function_8839d2f2f530a0b9(self);

  if(function_60597da56f99d304(self)) {
    scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
    scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_infils_common::state_animatic_playerLateJoin()");
  }
}

function state_flyover() {
  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player function_25a0c882b7e8bb02();

    if(player isplayerheadless()) {
      registerheadlessinfil(player);
    }
  }

  if(isDefined(level.var_c5877dbe60fddbf6)) {
    foreach(codcaster in level.var_c5877dbe60fddbf6) {
      codcaster setclientomnvar("ui_br_infiled", 1);
    }
  }

  level.br_ac130 scripts\mp\gametypes\br_gametypes::runbrgametypefunc("addToC130Infil");
  function_6199c35f4cf4524c(&function_d2540ea30a17f53a);
  setomnvar("ui_in_infil", -1);
  level.infiltransistioning = undefined;
  level.infilcinematicactive = 0;
  scripts\mp\flags::gameflagset("infil_animatic_complete");
  level thread function_c22e838caf108bb0();

  if(isDefined(level.headlessinfilplayers)) {
    level thread function_12d78457edd58de();
  }

  function_9f3146807ea18258();
  level waittill("br_c130_left_bounds");
}

function private function_25a0c882b7e8bb02() {
  self setallstreamloaddist(0);
  scripts\mp\gametypes\br_public::playerclearstreamhintorigin();

  if(!istrue(level.infilstruct.var_eb0e85a583f21b9d)) {
    self setclientdvar(@ "cg_fov", 65);
    self setclientdvar(@ "hash_86bf34d5f48fa435", 65);

    if(!istrue(level.infilstruct.var_12c912ee9672fa1)) {
      self setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
    }

    self disablephysicaldepthoffieldscripting();
    setdof_default();
  }

  self.instantclassswapallowed = 1;
  scripts\mp\class::unblockclasschange();

  if(get_int_or_0(self.hidehudenabled) > 0) {
    utility::hidehuddisable();
  }

  self visionsetfadetoblackforplayer("", 1);
  self notify("joining_Infil");
  self.br_infilstarted = 1;

  if(!istrue(level.c130inbounds)) {
    self setclientomnvar("ui_hide_minimap", 1);
  }

  self.health = self.maxhealth;
  self cameraunlink();
  self stopxcam();
  scripts\mp\gametypes\br_c130::spawnplayertoc130();
  playersetupcontrolsforinfil();
  scripts\mp\gametypes\br_public::updatebrscoreboardstat("isInInfilPlane", 1);
  level.infilstruct.playersinc130++;
  scripts\mp\gametypes\br_public::function_64fa4c213439177f();
  thread playercleanupinfilondisconnect();
}

function private function_c22e838caf108bb0() {
  scripts\mp\gametypes\br_public::brleaderdialog("match_start", 0, level.infilstruct.players, undefined, undefined, undefined, level.brgametype.dialogprefix);
  level thread scripts\mp\gametypes\br_c130::waittoplayinfildialog();

  if(istrue(level.brgametype.var_98ade9e8627af484) && isDefined(game["dialog"]["offense_obj"])) {
    soundname = scripts\mp\gametypes\br_public::function_93550b34f0a49dd9("match_start", level.infilstruct.players[0], level.brgametype.dialogprefix);

    if(isDefined(soundname)) {
      soundlength = lookupsoundlength(soundname, 1) / 1000;
      wait soundlength + 1;
    }

    scripts\mp\gametypes\br_public::brleaderdialog("offense_obj", 0, level.infilstruct.players, undefined, undefined, undefined, level.brgametype.dialogprefix);
  }
}

function function_d2540ea30a17f53a() {
  self endon("disconnect");
  function_25a0c882b7e8bb02();
  thread watchinfiljumpanim();
  scripts\mp\gametypes\br_public::brleaderdialog("match_start", 0, [self], undefined, undefined, undefined, level.brgametype.dialogprefix);
  _freezelookcontrols(0);
  self cameraunlink();
  self stopxcam();
  thread scripts\mp\gametypes\br_c130::orbitcam(level.infilstruct.c130);
  function_423115ed15f21e05(self.team);
}

function state_done() {
  function_bee6776dbf711484();
}

function private registerheadlessinfil(player) {
  if(!isDefined(level.headlessinfilplayers)) {
    level.headlessinfilplayers = [];
  }

  level.headlessinfilplayers[level.headlessinfilplayers.size] = player;
}

function private function_12d78457edd58de() {
  level endon("game_ended");
  dist = distance(level.br_ac130.pathstruct.startpt, level.br_ac130.pathstruct.endpt);
  time = dist / scripts\mp\gametypes\br_c130::getc130speed() / level.headlessinfilplayers.size;

  for(i = 0; i < level.headlessinfilplayers.size; i++) {
    wait time;
    level.headlessinfilplayers[i] notify("halo_jump_c130");
  }

  level.headlessinfilplayers = undefined;
}

function private playersetupcontrolsforinfil(soloonly) {
  if(!isDefined(soloonly)) {
    soloonly = 0;
  }

  self setclientomnvar("ui_br_infil_started", 1);
  self setclientomnvar("ui_br_infiled", 0);

  if(!soloonly) {
    self notifyonplayercommand("halo_jump_c130", "+gostand");

    if(!isbot(self)) {
      self notifyonplayercommand("halo_jump_parachute_c130", "+open_parachute");
    }
  } else {
    self notifyonplayercommand("halo_jump_solo_c130", "+gostand");

    if(!isbot(self)) {
      self notifyonplayercommand("halo_jump_parachute_solo_c130", "+open_parachute");
    }
  }

  self notifyonplayercommand("br_pass_squad_leader", "+usereload");
  self notifyonplayercommand("br_pass_squad_leader", "+activate");
}

function private playercleanupinfilondisconnect() {
  level endon("game_ended");
  self endon("death");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("disconnect");

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0) {
    level.infilstruct.playersinc130--;
  }
}

function private function_9f3146807ea18258() {
  level.infiljumpentsspawned = 0;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player thread watchinfiljumpanim();
  }
}

function playjumpsoundtosquad() {
  aliasname = "evt_br_infil_squadmate_jump";

  if(scripts\mp\gametypes\br_public::isplayerbrsquadleader()) {
    aliasname = "evt_br_infil_squad_leader_jump";
  }

  self playsoundtoteam(aliasname, self.team, self);
}

function private function_dd86c05daa1432c3() {
  self endon("disconnect");
  wait 5;
  self setclientdvar(@ "hash_b21f1157c582ff15", 1);
}

function private watchinfiljumpanim() {
  self endon("death_or_disconnect");
  self.hasspawnweapons = 0;
  self waittill("br_jump");

  if(isDefined(level.infilstruct.jumpfunc)) {
    self thread[[level.infilstruct.jumpfunc]]();
  }

  var_a2117ea816a8b7f1 = getdvarint(@ "hash_8be4acc5eebb19ca", 1) != 0;

  if(level.infiljumpentsspawned >= 100) {
    var_a2117ea816a8b7f1 = 0;
  }

  shouldteleport = undefined;

  if(var_a2117ea816a8b7f1) {
    shouldteleport = 0;
    assert(isDefined(level.infilstruct.var_ae9e4023110acc6e));
    [var_8dec95713ec1f7ba, var_4d261ef98868b4e6, var_66809387054fc02a, playerlinktag] = [[level.infilstruct.var_ae9e4023110acc6e]]();
    parentent = level.infilstruct.c130;

    if(isDefined(level.infilstruct.animstruct) && istrue(level.infilstruct.animstruct.var_c978f36e30808108)) {
      parentent = level.infilstruct.animstruct.c130;
    }

    var_9b145eb55513dbb5["parent"] = spawn("script_model", parentent.origin);
    level.infiljumpentsspawned++;
    var_9b145eb55513dbb5["parent"] setModel("generic_prop_x10");
    var_9b145eb55513dbb5["parent"] forcenetfieldhighlod(1);
    var_9b145eb55513dbb5["parent"] linkTo(parentent, "tag_body", (0, 0, 0), (0, 0, 0));
    var_9b145eb55513dbb5[playerlinktag] = spawn("script_model", var_9b145eb55513dbb5["parent"] gettagorigin(playerlinktag));
    level.infiljumpentsspawned++;
    var_9b145eb55513dbb5[playerlinktag] setModel("tag_player");
    var_9b145eb55513dbb5[playerlinktag] forcenetfieldhighlod(1);
    var_9b145eb55513dbb5[playerlinktag] linkTo(var_9b145eb55513dbb5["parent"], playerlinktag, (0, 0, 0), (0, 0, 0));
    self playerlinkTo(var_9b145eb55513dbb5[playerlinktag], "tag_player");
    scripts\cp_mp\utility\player_utility::function_6fb380927695ee76(1);
    self playanimscriptsceneevent("scripted_scene", var_66809387054fc02a);
    self.infilanimindex = undefined;
    self.var_db122a8941dfee14 = undefined;
    self playlocalsound("evt_br_infil_jump_stinger");
    playjumpsoundtosquad();
    var_9b145eb55513dbb5["parent"] scriptmodelplayanim(var_8dec95713ec1f7ba, "prop");
    var_7a79e5c326955318 = getanimlength(var_4d261ef98868b4e6);
    var_886f7978500acb10 = 1;
    var_7a79e5c326955318 = max(var_7a79e5c326955318, var_886f7978500acb10 + 0.1);
    wait var_7a79e5c326955318 - var_886f7978500acb10;
    self cameradefault();

    if(isDefined(level.infilstruct.var_dc0bc83a31193177)) {
      self thread[[level.infilstruct.var_dc0bc83a31193177]]();
    }

    thread function_dd86c05daa1432c3();
    wait var_886f7978500acb10;

    foreach(ent in var_9b145eb55513dbb5) {
      ent delete();
      level.infiljumpentsspawned--;
    }
  } else {
    shouldteleport = 1;
    waittillframeend();
    thread function_dd86c05daa1432c3();
  }

  self.infilanimindex = undefined;
  self.var_db122a8941dfee14 = undefined;
  self.infilactive = undefined;
  self stopanimscriptsceneevent();
  self notify("infil_jump_done");
  scripts\mp\gametypes\br::playerexecutionsenable();
  scripts\common\values::reset_all("br_infil");

  if(shouldteleport) {
    waitframe();

    if(isDefined(level.infilstruct.c130)) {
      if(isDefined(level.infilstruct.c130.playeroffsets) && isDefined(level.infilstruct.c130.currentplayeroffset)) {
        offset = level.infilstruct.c130.playeroffsets[level.infilstruct.c130.currentplayeroffset];
        self setOrigin(level.infilstruct.c130.origin + offset, 1, 1);
        level.infilstruct.c130.currentplayeroffset++;

        if(level.infilstruct.c130.currentplayeroffset == level.infilstruct.c130.playeroffsets.size) {
          level.infilstruct.c130.currentplayeroffset = 0;
        }

        scripts\cp_mp\utility\player_utility::function_6fb380927695ee76(1);
        playjumpsoundtosquad();

        if(isDefined(level.infilstruct.var_dc0bc83a31193177)) {
          self thread[[level.infilstruct.var_dc0bc83a31193177]]();
        }
      }
    }
  }

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("onInfilJumpDone")) {
    thread scripts\mp\gametypes\br_gametypes::runbrgametypefunc("onInfilJumpDone", self);
  }
}

function private function_b599ea9ce3625a9d(players) {
  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    linkedchildren = player getlinkedchildren();

    if(isDefined(linkedchildren) && linkedchildren.size) {
      numchildren = linkedchildren.size;

      if(numchildren > 0) {
        message = "Infil Player (" + player.name + ") with (" + numchildren + ") linked ents: ";

        foreach(childent in linkedchildren) {
          var_8ee353d273e5b1d4 = childent function_67ea74bab288a2b5();

          if(isDefined(var_8ee353d273e5b1d4) && var_8ee353d273e5b1d4.size > 0) {
            message += "stack:" + var_8ee353d273e5b1d4 + ",";
          }

          if(isDefined(childent.equipmentref)) {
            message += "equip:" + childent.equipmentref + ",";
            continue;
          }

          if(isDefined(childent.weapon_name)) {
            message += "weapon:" + childent.weapon_name + ",";
            continue;
          }

          if(isDefined(childent.model)) {
            message += "model:" + childent.model + ",";
            continue;
          }

          message += "?,";
        }

        scripts\mp\utility\script::demoforcesre(message);
      }
    }
  }
}

function private function_1696e6e3ac4a370a() {
  if(isDefined(level.var_9d615a366ec2fb6f)) {
    level.var_9d615a366ec2fb6f = undefined;
  }

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player notify("beginC130");
    player scripts\mp\gametypes\br_utility::function_fd357ca89e5e29d9();
    linkedchildren = player getlinkedchildren();

    foreach(childent in linkedchildren) {
      if(isDefined(childent.equipmentref) && childent.equipmentref == "equip_molotov") {
        player scripts\mp\equipment\molotov::molotov_clear_burning(1);
        childent delete();
        continue;
      }

      if(isDefined(childent.equipmentref) && childent.equipmentref == "equip_thermite") {
        childent thread scripts\mp\equipment\thermite::thermite_destroy(1);
        continue;
      }

      if(isDefined(childent.equipmentref) && childent.equipmentref == "equip_shockstick") {
        childent thread scripts\mp\equipment\shock_stick::function_c44b639f5005afa(1);
      }
    }
  }

  if(isDefined(level.throwingknives)) {
    foreach(throwingknife in level.throwingknives) {
      if(isDefined(throwingknife)) {
        throwingknife thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_deletepickup();
      }
    }
  }

  function_b599ea9ce3625a9d(level.infilstruct.players);
}

function private function_1b7e57bfe648f609() {
  videoname = level.infilstruct.binkname;

  if(!isDefined(videoname)) {
    return;
  }

  self preloadcinematicforplayer(videoname);
}

function private playvideo() {
  videoname = level.infilstruct.binkname;

  if(!isDefined(videoname)) {
    return;
  }

  thread scripts\mp\music_and_dialog::stopsuspensemusic();

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player playcinematicforplayer(videoname);
    player setclientomnvar("ui_br_bink_overlay_state", 3);
  }
}

function private function_12ccccd25dafe834() {
  videoname = level.infilstruct.binkname;

  if(!isDefined(videoname)) {
    return;
  }

  self setplayermusicstate("");
  self playcinematicforplayer(videoname);
  self setclientomnvar("ui_br_bink_overlay_state", 3);
}

function infilvideocompletecallback(channel, val) {
  if(istrue(self.var_20a6defc94783931)) {
    return;
  }

  if(channel == "bink_complete") {
    level notify("play_video_complete");
    self setclientomnvar("ui_br_bink_overlay_state", 0);
    self stopcinematicforplayer();
    self.var_20a6defc94783931 = 1;
  }
}

function private function_749c46213cdb834() {
  videoname = level.infilstruct.binkname;

  if(!isDefined(videoname)) {
    return;
  }

  assert(isDefined(level.infilstruct.binktime));
  wait level.infilstruct.binktime;

  foreach(player in level.infilstruct.players) {
    player setclientomnvar("ui_br_bink_overlay_state", 0);
    player stopcinematicforplayer();
  }
}

function private function_7f133e4caeb239a6() {
  if(getdvarint(@ "hash_f0bf803446eb9e90", 0)) {
    level.infilstruct.var_ee3961854e32111a = "jup_wz_infil_transmission";
    level.infilstruct.var_eb28885bca8b37ad = getdvarfloat(@ "hash_c24c7f8c3ae02360", 20);
    level.infilstruct.var_66d291c4463106bd = getdvarfloat(@ "hash_b6857320540de260", 0);
    level.infilstruct.var_8e9941b094b11142 = getdvarfloat(@ "hash_3437352036590b99", 1);
  }
}

function private function_2de90f865b7ce99d(player) {
  if(!isDefined(level.infilstruct.var_ee3961854e32111a) || isDefined(level.infilstruct.binkname)) {
    return;
  }

  if(randomfloatrange(0, 1) > level.infilstruct.var_8e9941b094b11142) {
    level.infilstruct.var_ee3961854e32111a = undefined;
    return;
  }

  if(isbot(player)) {
    return;
  }

  player preloadcinematicforplayer(level.infilstruct.var_ee3961854e32111a, 1, 1);
}

function private function_f977de121342eeac(player) {
  if(!isDefined(level.infilstruct.var_ee3961854e32111a)) {
    return;
  }

  if(isDefined(level.infilstruct.binkname) && randomfloatrange(0, 1) > level.infilstruct.var_8e9941b094b11142) {
    level.infilstruct.var_ee3961854e32111a = undefined;
    return;
  }

  if(isbot(player)) {
    return;
  }

  if(level.infilstruct.var_66d291c4463106bd > 0) {
    wait level.infilstruct.var_66d291c4463106bd;
  }

  player.var_20a6defc94783931 = undefined;
  player thread function_f305b9064916953d();
  player function_786fee88b4749dff(0, 1);
  player setclientomnvar("ui_br_bink_overlay_state", 14);
  wait level.infilstruct.var_eb28885bca8b37ad;

  if(!istrue(player.var_20a6defc94783931)) {
    player setclientomnvar("ui_br_bink_overlay_state", 0);
    player stopcinematicforplayer();
    player.var_20a6defc94783931 = 1;
  }
}

function private function_f305b9064916953d() {
  self endon("disconnect");
  self setsoundsubmix("jup_br_infil_bink", 5);
  wait level.infilstruct.var_eb28885bca8b37ad - 3;
  self clearsoundsubmix("jup_br_infil_bink", 0.3);
}

function private function_19ea8f6d547dc8bc(player) {
  assert(isDefined(self.camerainfo));
  cameraent = self.camerainfo.ent;
  cameratag = undefined;

  if(isfunction(self.camerainfo.var_e6783d526b4a7212)) {
    cameratag = self[[self.camerainfo.var_e6783d526b4a7212]](player);
  } else if(isarray(self.camerainfo.var_e6783d526b4a7212)) {
    assert(isDefined(player.infilanimindex) && player.infilanimindex <= self.camerainfo.var_e6783d526b4a7212.size);
    cameratag = self.camerainfo.var_e6783d526b4a7212[player.infilanimindex - 1];
  } else {
    cameratag = self.camerainfo.var_e6783d526b4a7212;
  }

  return [cameraent, cameratag];
}

function private uses_xcam() {
  assert(isDefined(self.camerainfo));
  return isDefined(self.camerainfo.xcamasset);
}

function private function_bda88f27a0337eaa(player, var_e45f1cd8436c9aa9) {
  [cameraent, cameratag] = function_19ea8f6d547dc8bc(player);

  if(uses_xcam()) {
    if(!istrue(var_e45f1cd8436c9aa9)) {
      xcamasset = self.camerainfo.xcamasset;

      if(isDefined(self.camerainfo.xcamfunction)) {
        xcamasset = self[[self.camerainfo.xcamfunction]](player);
      }

      player cameraunlink();
      animstarttime = ter_op(istrue(level.var_8cf2b3f6bd2bf0e6), getframeduration() * 0.001, undefined);

      if(level.infilstruct.var_3772737101aa4af) {
        player playxcamontag(xcamasset, 0, cameraent, cameratag, animstarttime, 1, 1, 1);
      } else {
        player playxcamontag(xcamasset, 0, cameraent, cameratag, animstarttime, 1);
      }
    }

    return;
  }

  player stopxcam();
  player cameralinkTo(cameraent, cameratag, 1, 1);
}

function private function_78dfe475a5d4f843(player) {
  [cameraent, cameratag] = function_19ea8f6d547dc8bc(player);
  cameraorigin = cameraent gettagorigin(cameratag);
  cameraangles = cameraent gettagangles(cameratag);
  return [cameraorigin, cameraangles];
}

function private function_347d56feb29d7f74() {
  assert(isDefined(self.camerainfo));

  if(uses_xcam()) {
    return self.camerainfo.xcamlength;
  }

  return self.camerainfo.animlength;
}

function private function_8839d2f2f530a0b9(player) {
  assert(isDefined(player.infilanimindex) && player.infilanimindex <= self.playerpositions.size);
  linkent = self.playerpositions[player.infilanimindex - 1].ent;
  animname = self.playerpositions[player.infilanimindex - 1].animname;

  if(istrue(level.var_5338013d30a283c8)) {
    if(isDefined(self.playerpositions[player.infilanimindex - 1].animnamefem)) {
      if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female") {
        animname = self.playerpositions[player.infilanimindex - 1].animnamefem;
      }
    }
  }

  var_5934ae37f5ed079c = 0;
  var_569b6c130acd3daa = player.var_4b72faf29b9b511a;

  if(!isDefined(var_569b6c130acd3daa) || var_569b6c130acd3daa != linkent) {
    var_5934ae37f5ed079c = 1;
  }

  if(var_5934ae37f5ed079c) {
    player playerlinkTo(linkent, "tag_player");
    player.var_4b72faf29b9b511a = linkent;
  }

  player playanimscriptsceneevent("scripted_scene", animname);
}

function private unfreezeplayercontrols(delaytime) {
  wait delaytime;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    player _freezelookcontrols(0);
  }
}

function private function_1c3d2f575360d8fa(var_df94e780c2b3c994) {
  self endon("stopScene");
  level.infilstruct.animstruct = self;
  level.infilstruct.var_df94e780c2b3c994 = var_df94e780c2b3c994;
  self.activepack = undefined;
  level.infilstruct.var_3772737101aa4af = default_to(self.var_3772737101aa4af, 0);
  var_e49a1c04ac964563 = 0;

  var_e49a1c04ac964563 = function_c43d732289ecf3e8();

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    function_6d8ac534ad288aa5(player);
    player _freezelookcontrols(1);
    player.infilactive = 1;
    thread function_f977de121342eeac(player);
  }

  if(level.infilstruct.var_3772737101aa4af) {
    self.camerarunner val::set("br_infil", "cinematics_participant", 1);
  }

  foreach(pack in self.packs) {
    self.activepack = pack;

    if(istrue(var_df94e780c2b3c994)) {
      iprintlnbold("<dev string:x6d>" + pack.anime);
    }

    if(pack.islooping) {
      function_583f118c4064ca21(level.infilstruct.players);
    }

    if(isDefined(pack.fov)) {
      allplayers_setfov(pack.fov);
    } else {
      function_cf47ab3f9defe35b();
    }

    if(isDefined(pack.fstop) && isDefined(pack.focusdist)) {
      allplayers_setphysicaldof(pack.fstop, pack.focusdist, pack.focusspeed, pack.aperturespeed, pack.focalpoint);
    }

    if(isDefined(pack.startfunc)) {
      [[pack.startfunc]](pack.var_c65bb75cce61100f);
    }

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(isDefined(pack.playerfunc)) {
        [[pack.playerfunc]](player, pack.var_5ab13b55d7ceff80);
      }

      if(!scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() || !pack.islooping) {
        player cameraunlink();
        player stopxcam();
        pack function_bda88f27a0337eaa(player);
      }
    }

    if(isDefined(pack.fx)) {
      playFX(getfx(pack.fx), pack.fxorigin, anglesToForward(pack.fxangles), anglestoup(pack.fxangles));
    }

    pack.ents = array_removeundefined(pack.ents);

    foreach(ent in pack.ents) {
      animstarttime = ter_op(istrue(level.var_8cf2b3f6bd2bf0e6), getframeduration() * 0.001, undefined);

      if(level.infilstruct.var_3772737101aa4af) {
        ent val::set("br_infil", "cinematics_participant", 1);
        ent scriptmodelplayanim(level.scr_anim[ent.animname][pack.anime], ent.animname, animstarttime, 1, "none");
      } else {
        if(!istrue(ent.dontteleport)) {
          ent dontinterpolate();
        }

        ent scriptmodelplayanim(level.scr_anim[ent.animname][pack.anime], ent.animname, animstarttime);
      }

      ent thread scripts\common\notetrack::start_notetrack_wait(ent, ent.animname, pack.anime, ent.animname, level.scr_anim[ent.animname][pack.anime]);
    }

    foreach(rig in pack.lightingrigs) {
      foreach(probe in rig.probes) {
        origin_offset = probe.origin_offset;
        angles_offset = probe.angles_offset;

        if(!isDefined(angles_offset)) {
          angles_offset = (0, 0, 0);
        }

        probe show();
        probe linkTo(rig.linkent, "tag_origin", origin_offset, angles_offset);
      }

      foreach(light in rig.lights) {
        if(isDefined(light.original_intensity)) {
          light setlightintensity(light.original_intensity);
        }

        origin_offset = light.origin_offset;
        angles_offset = light.angles_offset;

        if(!isDefined(angles_offset)) {
          angles_offset = (0, 0, 0);
        }

        light linkTo(rig.linkent, "tag_origin", origin_offset, angles_offset);
      }
    }

    var_2246d8f267e2c3de = 0;
    var_2119f74ea52e3c92 = 4;

    var_2119f74ea52e3c92 = function_d8220f4960da76cd();

    pack.var_3bd5282b118d27f8 = array_removeundefined(pack.var_3bd5282b118d27f8);

    foreach(proxy in pack.var_3bd5282b118d27f8) {
      animstarttime = ter_op(istrue(level.var_8cf2b3f6bd2bf0e6), getframeduration() * 0.001, undefined);

      if(level.infilstruct.var_3772737101aa4af) {
        proxy val::set("br_infil", "cinematics_participant", 1);
        proxy scriptmodelplayanim(level.scr_anim[proxy.animname][pack.anime], proxy.animname, animstarttime, 1, "none");
      } else {
        proxy dontinterpolate();
        proxy scriptmodelplayanim(level.scr_anim[proxy.animname][pack.anime], proxy.animname, animstarttime);
      }

      if(var_e49a1c04ac964563) {
        if(!isDefined(pack.var_a39842bcdfc531c2)) {
          if(var_2246d8f267e2c3de < var_2119f74ea52e3c92) {
            proxy show();
          } else {
            proxy hide();
          }
        }
      } else {
        proxy hide();
      }

      var_2246d8f267e2c3de++;
    }

    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(level.infilstruct.var_3772737101aa4af) {
        player val::set("br_infil", "cinematics_participant", 1);
      }

      pack function_8839d2f2f530a0b9(player);

      if(var_e49a1c04ac964563) {
        if(function_60597da56f99d304(player)) {
          player scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
          player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("br_infils_common::playInfilSequence()");
        }
      }
    }

    if(pack.islooping) {
      break;
    }

    animlength = pack function_347d56feb29d7f74();
    waitandpause(animlength);
  }

  wait 1;

  if(!istrue(level.infilstruct.var_eb0e85a583f21b9d)) {
    allplayers_clearphysicaldof();
    function_cf47ab3f9defe35b();
  }

  if(level.infilstruct.var_3772737101aa4af) {
    foreach(player in level.infilstruct.players) {
      player val::reset("br_infil", "cinematics_participant");

      if(isDefined(player.var_4b72faf29b9b511a)) {
        player.var_4b72faf29b9b511a = undefined;
      }
    }
  }

  if(getdvarint(@ "hash_187e8c5233803ac8", 0)) {
    thread function_b0f7742c6d38dbd1();
  } else if(istrue(var_df94e780c2b3c994)) {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      player cameraunlink();
      player stopxcam();
      player scripts\mp\gametypes\br_c130::orbitcam(level.br_ac130);
    }
  }

  level thread unfreezeplayercontrols(1.2);
}

function private function_8b74f71235297593(var_df94e780c2b3c994) {
  level.infilstruct.animstruct = self;
  level.infilstruct.var_df94e780c2b3c994 = var_df94e780c2b3c994;

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    function_6d8ac534ad288aa5(player);
    player _freezelookcontrols(1);
  }

  if(isDefined(level.infilstruct.var_c7e1f8034a6cca31)) {
    [[level.infilstruct.var_c7e1f8034a6cca31]](self);
  }

  if(!istrue(level.infilstruct.var_eb0e85a583f21b9d)) {
    allplayers_clearphysicaldof();
    function_cf47ab3f9defe35b();
  }

  if(getdvarint(@ "hash_187e8c5233803ac8", 0)) {
    thread function_b0f7742c6d38dbd1();
  } else if(istrue(var_df94e780c2b3c994)) {
    foreach(player in level.infilstruct.players) {
      if(!isDefined(player)) {
        continue;
      }

      player cameraunlink();
      player stopxcam();
      player scripts\mp\gametypes\br_c130::orbitcam(level.br_ac130);
    }
  }

  level thread unfreezeplayercontrols(1.2);
}

function function_b0f7742c6d38dbd1() {
  transitiontime = 1;
  wait transitiontime;
  c130 = self.movingc130;

  if(!isDefined(c130)) {
    c130 = self.c130;
  }

  entaxis = anglestoaxis(c130.angles);
  entright = -1 * entaxis["<dev string:x7e>"];
  entup = entaxis["<dev string:x87>"];

  foreach(player in level.infilstruct.players) {
    if(!isDefined(player)) {
      continue;
    }

    slotnumber = player.infilanimindex - 1;
    assert(isDefined(self.activepack));
    [cameraorigin, cameraangles] = self.activepack function_78dfe475a5d4f843(player);
    baseorigin = player getvieworigin();
    playerangles = player getplayerangles();
    playeraxis = anglestoaxis(playerangles);
    rayorigin = cameraorigin;
    raydir = anglesToForward(cameraangles);
    planenormal = (raydir[0] * -1, raydir[1] * -1, 0);
    planenormal = vectorNormalize(planenormal);
    denominator = vectordot(planenormal, raydir);
    difference = baseorigin - rayorigin;
    t = vectordot(difference, planenormal) / denominator;
    result = rayorigin + t * raydir;
    offset = result - baseorigin;
    println("<dev string:x8d>" + slotnumber + "<dev string:xaa>" + offset[0] + "<dev string:xb0>" + offset[1] + "<dev string:xb0>" + offset[2] + "<dev string:xb5>");
    entorigin = baseorigin + entright * offset[0] + entup * offset[2];
    cameradistance = distance(cameraorigin, entorigin);
    var_cf201622a9fd5646 = entorigin - cameraorigin;
    var_cf201622a9fd5646 = vectorNormalize(var_cf201622a9fd5646);
    var_abdc396b57c7f955 = vectordot(raydir, var_cf201622a9fd5646);
    println("<dev string:xba>" + slotnumber + "<dev string:xd6>" + cameradistance + "<dev string:xe6>" + var_abdc396b57c7f955 + "<dev string:xb5>");
    var_4200398f14c8db5 = cameraorigin - entorigin;
    var_629f52c3d96c0cb9 = length(var_4200398f14c8db5);
    var_867d9818ce7f2161 = acos(var_4200398f14c8db5[2] / var_629f52c3d96c0cb9);
    println("<dev string:xf1>" + slotnumber + "<dev string:x110>" + var_629f52c3d96c0cb9 + "<dev string:x11d>" + var_867d9818ce7f2161 + "<dev string:xb5>");
  }
}

function safe_delete() {
  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.dontdelete)) {
    return;
  }

  if(isDefined(self.innards)) {
    self.innards delete();
  }

  self delete();
}

function cleanupents() {
  foreach(pack in self.packs) {
    pack.var_3bd5282b118d27f8 = array_removeundefined(pack.var_3bd5282b118d27f8);

    foreach(proxy in pack.var_3bd5282b118d27f8) {
      proxy safe_delete();
    }

    pack.playerpositions = array_removeundefined(pack.playerpositions);

    foreach(posstruct in pack.playerpositions) {
      if(isDefined(posstruct.ent)) {
        posstruct.ent safe_delete();
      }
    }

    pack.playerpositions = [];
    pack.ents = array_removeundefined(pack.ents);

    foreach(ent in pack.ents) {
      if(isDefined(ent.linkedents)) {
        array_delete(ent.linkedents);
      }

      ent safe_delete();
    }

    pack.staticents = array_removeundefined(pack.staticents);

    foreach(ent in pack.staticents) {
      if(isDefined(ent.linkedents)) {
        array_delete(ent.linkedents);
      }

      ent safe_delete();
    }
  }
}

function private function_7812117b17c4d21e() {
  defaultscenetype = "ac130";
  scenetype = function_56d92ab945808b50(defaultscenetype);
  return scenetype;
}

function private function_56d92ab945808b50(defaultstring) {
  scenetype = getDvar(@ "hash_2f5821f46995d1e2");

  if(scenetype != "") {
    return scenetype;
  }

  return defaultstring;
}

function private function_fe85c23fc6fa8c2() {
  level.infilstruct.statecallbacks = [];
  level.infilstruct.binkname = undefined;
  scenetype = function_7812117b17c4d21e();

  switch (scenetype) {
    case #"hash_1136bc3322c0a548":
      level.var_7647df14c1f116f7 = 0;
      namespace_5c75c180befb8e98::init();
      break;
    case #"hash_5428ebdaaca96e36":
      level.var_7647df14c1f116f7 = 0;
      namespace_6b61356959df5986::init();
      break;
    case #"hash_ee578a15ca8b126d":
      level.var_7647df14c1f116f7 = 1;
      namespace_3c940a00e48e77dd::init();
      break;
    case #"hash_a9257f2a837c6176":
      level.var_7647df14c1f116f7 = 0;
      namespace_8229c5f55435b3e6::init();
      break;
    case #"hash_b730c3301d705212":
      level.var_7647df14c1f116f7 = 0;
      namespace_d8d4c267054a30a2::init();
      break;
    case #"hash_a9f638b560f8481f":
    default:
      level.var_7647df14c1f116f7 = 0;
      scripts\mp\gametypes\br_infils_ac130::init();
      break;
  }

  function_7f133e4caeb239a6();
}

function function_8252134bb4aaa66b() {
  assert(isDefined(level.infilstruct.c130));
  animstruct = function_55f2480b4b819aea(level.infilstruct.c130);
  level.infilstruct.c130.animstruct = animstruct;
}

function function_8d001511b174ef1e() {
  level.infilstruct.var_1cf4fe3c9d7da8a2 = 1;
  assert(isDefined(level.infilstruct.c130.animstruct));

  if(istrue(level.var_7647df14c1f116f7)) {
    level.infilstruct.c130.animstruct function_8b74f71235297593();
    return;
  }

  level.infilstruct.c130.animstruct function_1c3d2f575360d8fa();
}

function function_55f2480b4b819aea(movingc130) {
  assert(isDefined(level.infilstruct.var_b381e33e977da440));
  return [[level.infilstruct.var_b381e33e977da440]](movingc130);
}

function private function_c03893a40366ed07() {
  level.var_16da1e546dc92a4c = [];
  level.brlatespawnplayer = &latespawnplayer;
}

function private function_bee6776dbf711484() {
  level.var_16da1e546dc92a4c = undefined;
}

function private function_c69c9cf4ab75a1ef() {
  return isDefined(level.var_16da1e546dc92a4c) && level.var_16da1e546dc92a4c.size > 0;
}

function private missedinfilplayerhandler() {
  if(self.class == "") {
    self.class = "custom1";
    self.pers["class"] = "custom1";
  }

  self.br_infilstarted = 1;
  scripts\mp\gametypes\br_pickups::addrespawntoken(1);

  if(getdvarint(@ "hash_9846cbf5e5814e63", 0) == 1) {
    self.var_a8a69818c7e933a9 = 1;
  }

  scripts\mp\gametypes\br_gulag::playergulagautowin("missedInfil", undefined, undefined, 1);
}

function private function_7e1bbc382ad810f9() {
  self endon("disconnect");
  self.br_isininfil = 0;
  self.br_infilstarted = 1;
  isuibot = scripts\mp\gametypes\br::function_7dbb8165d792b06c();

  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("squadLeader")) {
    teamplayers = getteamdata(self.team, "players");

    if(!isDefined(teamplayers) || teamplayers.size == 0) {
      teamplayers = [self];
    }

    setupbrsquadleader(teamplayers);
  }

  self setallstreamloaddist(0);
  self clearpredictedstreampos();

  if(isDefined(self.var_cd09849e16631c71)) {
    foreach(overlay in self.var_cd09849e16631c71) {
      if(isDefined(overlay)) {
        overlay destroy();
      }
    }

    self.var_cd09849e16631c71 = undefined;
  }

  self setclientdvar(@ "hash_b21f1157c582ff15", 1);
  scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
  scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("br_infils_common::lateSpawnPlayerAfterInfil()");
  self.plotarmor = 0;
  _freezelookcontrols(0, 1);
  self cameraunlink();
  self stopxcam();
  self setclientdvar(@ "cg_fov", 65);
  self setclientdvar(@ "hash_86bf34d5f48fa435", 65);
  self setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
  self disablephysicaldepthoffieldscripting();
  setdof_default();

  if(isDefined(self.hidehudenabled) && self.hidehudenabled > 0) {
    utility::hidehuddisable();
  }

  self visionsetfadetoblackforplayer("", 1);
  self visionsetnakedforplayer("", 1);
  scripts\mp\gametypes\br_public::function_64fa4c213439177f();

  if(!isalive(self)) {
    if(getdvarint(@ "hash_25ad2925d6075c8f", 0) == 2 && isbot(self) && !isuibot) {
      self.jumped = 1;
      scripts\mp\playerlogic::addtoalivecount("lateSpawn");
    }

    if(isuibot) {
      thread scripts\mp\playerlogic::spawnplayer(undefined, 0);
    } else {
      thread missedinfilplayerhandler();
    }
  } else {
    assertmsg("<dev string:x130>");
  }

  if(!isbot(self)) {
    setwind("1");
  }

  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_br_extended_load_screen", 0);
}

function latespawnplayer() {
  if(!function_c69c9cf4ab75a1ef()) {
    function_7e1bbc382ad810f9();
    return;
  }

  assert(isDefined(level.infilstruct.players));

  if(array_contains(level.infilstruct.players, self)) {
    return;
  }

  callbackindex = 0;

  while(callbackindex < level.var_16da1e546dc92a4c.size) {
    func = level.var_16da1e546dc92a4c[callbackindex];
    self[[func]]();
    callbackindex++;

    if(!function_c69c9cf4ab75a1ef()) {
      function_7e1bbc382ad810f9();
      return;
    }
  }

  level.infilstruct.players[level.infilstruct.players.size] = self;
}

function function_60597da56f99d304(player) {
  if(!isDefined(player)) {
    return 0;
  }

  if(getdvarint(@ "hash_ad78f0f19c8707ab", 1) == 1) {
    return isDefined(player.c130);
  }

  return 1;
}

function private function_3e9deb911031fc08() {
  level.var_ca629cf434263639 = 0;
  thread function_710d2b779609907d();
  thread function_b51365f787d44355();
}

function private function_c5c00974981e6e90() {
  level.var_ca629cf434263639 = undefined;
  self notify("<dev string:x187>");

  foreach(player in level.players) {
    player _freezelookcontrols(0);
    player cameradefault();
    player cameraunlink();
    player stopxcam();
    player lerpfov(65, 0.5);

    if(istrue(player.var_1f0a019572c9f8e2)) {
      player disablephysicaldepthoffieldscripting();
      player setdof_default();
      player.var_1f0a019572c9f8e2 = undefined;
    }
  }

  wait 1;

  foreach(player in level.players) {
    player setclientdvar(@ "cg_fov", 65);
    player setclientdvar(@ "hash_86bf34d5f48fa435", 65);
    player setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
  }

  cleanupents();
}

function private function_710d2b779609907d() {
  self endon("<dev string:x187>");
  hostplayer = scripts\mp\gamelogic::gethostplayer();

  if(!isDefined(hostplayer)) {
    return;
  }

  while(true) {
    level.var_ca629cf434263639 = 0;

    while(hostplayer buttonPressed("<dev string:x194>")) {
      waitframe();
    }

    while(!hostplayer buttonPressed("<dev string:x194>")) {
      waitframe();
    }

    if(isDefined(self.activepack)) {
      self.activepack.ents = array_removeundefined(self.activepack.ents);

      foreach(ent in self.activepack.ents) {
        ent scriptmodelpauseanim(1);
      }

      self.activepack.var_3bd5282b118d27f8 = array_removeundefined(self.activepack.var_3bd5282b118d27f8);

      foreach(proxy in self.activepack.var_3bd5282b118d27f8) {
        proxy scriptmodelpauseanim(1);
      }

      if(self.activepack uses_xcam()) {
        hostplayer pausexcam(1);
      }
    }

    level.var_ca629cf434263639 = 1;

    while(hostplayer buttonPressed("<dev string:x194>")) {
      waitframe();
    }

    while(!hostplayer buttonPressed("<dev string:x194>")) {
      waitframe();
    }

    if(isDefined(self.activepack)) {
      self.activepack.ents = array_removeundefined(self.activepack.ents);

      foreach(ent in self.activepack.ents) {
        ent scriptmodelpauseanim(0);
      }

      self.activepack.var_3bd5282b118d27f8 = array_removeundefined(self.activepack.var_3bd5282b118d27f8);

      foreach(proxy in self.activepack.var_3bd5282b118d27f8) {
        proxy scriptmodelpauseanim(0);
      }

      if(self.activepack uses_xcam()) {
        hostplayer pausexcam(0);
      }
    }
  }
}

function function_b51365f787d44355() {
  self endon("<dev string:x187>");
  hostplayer = scripts\mp\gamelogic::gethostplayer();

  if(!isDefined(hostplayer)) {
    return;
  }

  while(true) {
    while(!hostplayer buttonPressed("<dev string:x1a2>")) {
      waitframe();
    }

    hostplayer scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
    hostplayer scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8("<dev string:x1ad>");
    hostplayer cameraunlink();
    hostplayer disablephysicaldepthoffieldscripting();
    hostplayer cameradefault();
    hostplayer _freezelookcontrols(0);

    if(isDefined(self.activepack)) {
      [cameraorigin, cameraangles] = self.activepack function_78dfe475a5d4f843(hostplayer);
      newplayerorg = cameraorigin + (0, 0, -60);
      var_a6fd7eae18e63f8 = cameraangles;
      hostplayer setOrigin(newplayerorg);
      hostplayer setplayerangles(var_a6fd7eae18e63f8);
    }

    if(!hostplayer isufo()) {
      hostplayer ufo();
    }

    setDvar(@ "hash_f94addedc8e87b69", 2);

    while(hostplayer buttonPressed("<dev string:x1a2>")) {
      waitframe();
    }

    while(!hostplayer buttonPressed("<dev string:x1a2>")) {
      waitframe();
    }

    if(hostplayer isufo()) {
      hostplayer ufo();
    }

    setDvar(@ "hash_f94addedc8e87b69", 0);

    if(isDefined(self.activepack)) {
      self.activepack function_bda88f27a0337eaa(hostplayer, 1);
    }

    hostplayer scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
    hostplayer scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("<dev string:x1ad>");
    hostplayer enablephysicaldepthoffieldscripting();

    while(hostplayer buttonPressed("<dev string:x1a2>")) {
      waitframe();
    }
  }
}

function private function_9384c9ed097bf7b9(player, buttonstring) {
  while(player buttonPressed(buttonstring) && function_136f4218b1d719b9()) {
    waitframe();
  }

  while(!player buttonPressed(buttonstring) && function_136f4218b1d719b9()) {
    waitframe();
  }
}

function private function_a93a090c732f587b() {
  c130pathstruct = undefined;

  if(scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined("<dev string:x1d2>")) {
    c130pathstruct = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("<dev string:x1d2>");
  } else {
    c130pathstruct = scripts\mp\gametypes\br_c130::createtestc130path(undefined, undefined);
  }

  level.infilstruct.c130pathstruct = c130pathstruct;
  scripts\mp\gametypes\br_c130::spawnc130(level.infilstruct.c130model, level.infilstruct.var_30e653e12f358438, level.infilstruct.var_c3a4f4442070a8b5, level.infilstruct.c130pathstruct, level.infilstruct.var_a6547e85663b3bc2);
  level.infilstruct.c130 = level.br_ac130;
}

function private function_f50b1941591d7479() {
  if(isDefined(level.infilstruct.c130)) {
    if(isDefined(level.infilstruct.c130.innards)) {
      level.infilstruct.c130.innards delete();
    }

    level.infilstruct.c130 delete();
  }
}

function function_faabc6943f92e6ac() {
  hostplayer = scripts\mp\gamelogic::gethostplayer();

  if(!isDefined(hostplayer)) {
    return;
  }

  while(function_136f4218b1d719b9()) {
    function_9384c9ed097bf7b9(hostplayer, "<dev string:x194>");

    if(!function_136f4218b1d719b9()) {
      break;
    }

    if(!isDefined(level.infilstruct)) {
      level.infilstruct = spawnStruct();
    }

    level.infilstruct.players = [hostplayer];
    startorigin = hostplayer.origin;
    startangles = hostplayer getplayerangles();
    scripts\mp\outofbounds::enableoobimmunity(hostplayer);
    hostplayer thread[[level.parachutetakeweaponscb]]();
    function_fe85c23fc6fa8c2();
    function_a93a090c732f587b();
    animstruct = function_55f2480b4b819aea(level.infilstruct.c130);

    if(istrue(level.var_7647df14c1f116f7)) {
      hostplayer predictstreamposuntilcleared(level.infilstruct.var_3a6128a99dc22eb2);

      if(level.var_7647df14c1f116f7 && isDefined(level.infilstruct.var_6f0c032ec6e5d14)) {
        [[level.infilstruct.var_6f0c032ec6e5d14]](animstruct);
      }

      wait 1;
      animstruct thread function_8b74f71235297593(1);
      function_9384c9ed097bf7b9(hostplayer, "<dev string:x1ea>");
      hostplayer clearpredictedstreampos();

      foreach(player in level.players) {
        player _freezelookcontrols(0);
        player cameradefault();
        player cameraunlink();
        player stopxcam();
        player lerpfov(65, 0.5);

        if(istrue(player.var_1f0a019572c9f8e2)) {
          player disablephysicaldepthoffieldscripting();
          player setdof_default();
          player.var_1f0a019572c9f8e2 = undefined;
        }
      }

      wait 1;

      foreach(player in level.players) {
        player setclientdvar(@ "cg_fov", 65);
        player setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
      }
    } else {
      animstruct thread function_1c3d2f575360d8fa(1);
      animstruct function_3e9deb911031fc08();
      function_9384c9ed097bf7b9(hostplayer, "<dev string:x1ea>");
      animstruct function_c5c00974981e6e90();
    }

    if(isDefined(animstruct.cleanupfunc)) {
      animstruct[[animstruct.cleanupfunc]]();
    }

    function_f50b1941591d7479();
    hostplayer setOrigin(startorigin);
    hostplayer setplayerangles(startangles);
    scripts\mp\outofbounds::disableoobimmunity(hostplayer);
    wait 0.5;
  }
}

function function_c43d732289ecf3e8() {
  return getdvarint(@ "hash_35a8afc828c370cb", 0);
}

function function_d8220f4960da76cd() {
  return getdvarint(@ "hash_623aaa3d216921a", 4);
}

function testdvarloop() {
  setdevdvarifuninitialized(@ "br_infil_anim_pos", (5500, 0, 2000));
  setdevdvarifuninitialized(@ "hash_8545857262882e35", 0);
  setdevdvarifuninitialized(@ "hash_2f5821f46995d1e2", "<dev string:x1f7>");
  setdevdvarifuninitialized(@ "hash_441165c7b355dd1b", -1);
  setdevdvarifuninitialized(@ "hash_35a8afc828c370cb", 0);
  setdevdvarifuninitialized(@ "hash_623aaa3d216921a", 4);
  setdevdvarifuninitialized(@ "hash_f6b3b7c2e066bf97", 0);
  setdevdvarifuninitialized(@ "hash_5dd356944d2c0dc5", 0);
  setdevdvarifuninitialized(@ "hash_783c8ff29b519ca5", 0);
  wait 1;

  while(true) {
    if(function_136f4218b1d719b9()) {
      function_faabc6943f92e6ac();
    } else if(getdvarint(@ "hash_783c8ff29b519ca5", 0)) {
      setDvar(@ "hash_783c8ff29b519ca5", 0);
      level.player thread[[level.brlatespawnplayer]]();
    }

    wait 0.25;
  }
}

function function_176ea5668fe41dad() {
  return getdvarint(@ "hash_5dd356944d2c0dc5", 0);
}

# /