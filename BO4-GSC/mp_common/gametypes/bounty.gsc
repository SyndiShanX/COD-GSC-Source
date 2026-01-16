/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\bounty.gsc
***********************************************/

#include script_52d2de9b438adc78;
#include script_702b73ee97d18efe;
#include scripts\core_common\ai_shared;
#include scripts\core_common\animation_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\popups_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\rank_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\killstreaks\airsupport;
#include scripts\killstreaks\helicopter_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\killstreaks_util;
#include scripts\mp_common\bb;
#include scripts\mp_common\contracts;
#include scripts\mp_common\draft;
#include scripts\mp_common\dynamic_loadout;
#include scripts\mp_common\gametypes\gametype;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_defaults;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\globallogic_ui;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\radar_sweeps;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\laststand;
#include scripts\mp_common\pickup_ammo;
#include scripts\mp_common\pickup_health;
#include scripts\mp_common\player\player_callbacks;
#include scripts\mp_common\player\player_killed;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\util;

#namespace bounty;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 500);
  util::registerroundlimit(0, 12);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.overrideteamscore = 1;
  level.var_f5a73a96 = 1;
  level.var_60507c71 = 1;
  level.takelivesondeath = 1;
  level.var_4348a050 = (isDefined(getgametypesetting(#"playernumlives")) ? getgametypesetting(#"playernumlives") : 0) + (isDefined(getgametypesetting(#"teamnumlives")) ? getgametypesetting(#"teamnumlives") : 0) > 0;
  level.endgameonscorelimit = 0;
  level.scoreroundwinbased = 1;
  level.var_5ee570bd = 1;
  level.var_7d1eeba9 = 1;
  level.var_81ca6158 = 1;
  level.var_30408f96 = 1;
  level.var_f46d16f0 = 1;
  level.b_allow_vehicle_proximity_pickup = 1;
  level.var_f16f6c66 = 1;

  if(!isDefined(game.var_b40d8319)) {
    game.var_b40d8319 = getgametypesetting(#"hash_2847dbf50c74391f");
  }

  level.var_b9aad767 = getgametypesetting(#"bountypurchasephaseduration");
  level.var_860cdbdb = getgametypesetting(#"hash_63f088c667689f40");
  level.var_8e8e80c6 = getgametypesetting(#"hash_32995dae734b94b6");
  level.var_374a483e = getgametypesetting(#"hash_561be47168b4e674");
  level.var_a2b93ad3 = getgametypesetting(#"hash_2270a3136e7cd914");
  level.var_854eeded = getgametypesetting(#"hash_48a1a06a8787b8d5");
  level.var_6fb8c585 = getgametypesetting(#"bountystartmoney");
  level.var_59e1bdd9 = getgametypesetting(#"hash_57fb5c079ad2fb7a");
  level.var_aad1f6f2 = getgametypesetting(#"hash_b5542a4bc9afce9");
  level.var_8ce231e3 = getgametypesetting(#"hash_b3a34a4bc841d67");

  if(level.var_aad1f6f2 > level.var_8ce231e3) {
    var_6b6c4ce = level.var_8ce231e3;
    level.var_8ce231e3 = level.var_aad1f6f2;
    level.var_aad1f6f2 = var_6b6c4ce;
  }

  if(level.var_aad1f6f2 == level.var_8ce231e3) {
    level.var_8ce231e3 += 0.001;
  }

  assert(level.var_aad1f6f2 <= level.var_8ce231e3);
  level.var_73a7a457 = max(getgametypesetting(#"hash_381587a813feab3e"), 1);
  level.bountydepositsitecapturetime = max(getgametypesetting(#"bountydepositsitecapturetime"), 1);
  level.var_ad9d03e7 = getgametypesetting(#"hash_3ffec9399ef7052f");
  level.var_d4fe7ba9 = getgametypesetting(#"hash_1e3a29a0321c9293");
  level.var_8cfdca96 = getgametypesetting(#"hash_78e49b8491ad6446");
  level.var_16fd9420 = getgametypesetting(#"hash_63f8d60d122e755b");
  level.var_651c849 = getgametypesetting(#"hash_45ff0effd8383bae");
  level.var_714ddf4a = getgametypesetting(#"hash_ef8682282bd2e10");
  level.var_e025e79e = getgametypesetting(#"bountybagomoneymovescale");
  level.var_18823aed = getgametypesetting(#"bountydepositextratime");
  level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
  level.var_3e14d8dd = getgametypesetting(#"bountybagomoneymoney");
  level.var_b2a8558a = level.var_3e14d8dd;
  level.laststandhealth = getgametypesetting(#"laststandhealth");
  level.laststandtimer = getgametypesetting(#"laststandtimer");
  level.var_aad2ad58 = getgametypesetting(#"hash_4462b9c231538fc9");

  if(level.var_aad2ad58) {
    level.var_2f990fc4 = getgametypesetting(#"hash_74efbd1bd1ee6413");
  }

  level.decayprogress = isDefined(getgametypesetting(#"decayprogress")) ? getgametypesetting(#"decayprogress") : 0;
  level.autodecaytime = isDefined(getgametypesetting(#"autodecaytime")) ? getgametypesetting(#"autodecaytime") : undefined;
  globallogic_spawn::addsupportedspawnpointtype("bounty");
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.ondeadevent = &ondeadevent;
  level.ontimelimit = &ontimelimit;
  level.ononeleftevent = &ononeleftevent;
  level.onroundswitch = &onroundswitch;
  level.onscoreevent = &onscoreevent;
  level.var_f7b64ada = &function_f7b64ada;
  level.var_1a0c2b72 = &function_1a0c2b72;
  player::function_cf3aa03d(&onplayerkilled);
  callback::on_connect(&onconnect);
  callback::on_spawned(&onspawned);
  callback::on_player_damage(&onplayerdamage);
  globallogic_defaults::function_daa7e9d5();
  laststand_mp::function_367cfa1b(&function_95002a59);
  laststand_mp::function_eb8c0e47(&onplayerrevived);
  setdvar(#"hash_7036719f41a78d54", getgametypesetting(#"laststandrevivehealth"));
  clientfield::register("allplayers", "bountymoneytrail", 1, 1, "int");
  clientfield::register("toplayer", "realtime_multiplay", 1, 1, "int");
  level.var_1aef539f = &function_a800815;
}

function_f2d6cd4a(gestureindex, animlength) {
  if(isDefined(level.purchasephase) && level.purchasephase) {
    self setlowready(0);
  }
}

function_41c54fc4() {
  if(isDefined(level.purchasephase) && level.purchasephase) {
    self setlowready(1);
  }
}

private onconnect() {
  waitframe(1);

  if(!isDefined(self.pers[#"money"])) {
    self.pers[#"money"] = level.var_6fb8c585;
    self.pers[#"money_earned"] = 0;

    if(game.roundsplayed > 0) {
      numteammates = 0;
      var_69c2bc0d = 0;

      foreach(player in level.players) {
        if(player == self) {
          continue;
        }

        if(!isDefined(player.pers[#"money_earned"])) {
          continue;
        }

        if(player.team == self.team) {
          numteammates++;
          var_69c2bc0d += player.pers[#"money_earned"];
        }
      }

      if(numteammates) {
        self function_3a77006e(int(var_69c2bc0d / numteammates), "moneychange_initialallocation");
      }
    }
  }

  if(level.var_aad2ad58 && !isDefined(self.pers[#"dynamic_loadout"].weapons[1])) {
    self.pers[#"dynamic_loadout"].weapons[1] = spawnStruct();
    self.pers[#"dynamic_loadout"].weapons[1].name = #"pistol_standard_t8";
    self.pers[#"dynamic_loadout"].weapons[1].attachments = [];
    self.pers[#"dynamic_loadout"].weapons[1].ammo = -1;
    self.pers[#"dynamic_loadout"].weapons[1].startammo = level.var_2f990fc4;
    dynamic_loadout::function_ff8ef46b(1, "luielement.BountyHunterLoadout.secondary", 7);
  }

  self clientfield::set_to_player("bountyMoney", self.pers[#"money"]);

  if(level.ingraceperiod === 1 && level.draftstage != 3) {
    wait 1;
    draft::assign_remaining_players(self);
  }
}

function_e1919661() {
  self.gameobject_link = util::spawn_model("tag_origin", self.origin, self.angles);
  self playerlinkto(self.gameobject_link, "tag_origin", 0, 30, 30, 30, 30);
}

function_feeebad() {
  if(isDefined(self)) {
    self unlink();

    if(isDefined(self.gameobject_link)) {
      self.gameobject_link delete();
    }
  }
}

private onspawned() {
  self clientfield::set_to_player("bountyMoney", self.pers[#"money"]);

  if(isDefined(level.purchasephase) && level.purchasephase) {
    self freezecontrols(1);
    self thread function_9b85340e();
    self setlowready(1);
    return;
  }

  if(game.state == "playing") {
    self clientfield::set_to_player("realtime_multiplay", 1);
  }
}

private function_9b85340e() {
  self endon(#"death", #"disconnect");
  waitframe(1);
  self buy_menu_open();
}

private onstartgametype() {
  level.graceperiod = isDefined(level.var_b9aad767) ? level.var_b9aad767 : level.graceperiod;
  level.alwaysusestartspawns = 1;

  foreach(team, _ in level.teams) {
    level.var_a236b703[team] = 1;
    level.var_61952d8b[team] = 1;
  }

  thread function_17debb33();
  level thread function_8cac4c76();
  var_b1f5f155 = game.roundsplayed + 1;

  if(var_b1f5f155 == game.var_b40d8319) {
    game.var_b40d8319 += getgametypesetting(#"hash_7e30d3849ca91b60");
    thread function_bdba96e1();
  }

  level.var_7e7897b8 = function_b3faa437();
  thread function_c04cc87c();

  if(level.scoreroundwinbased) {
    [[level._setteamscore]](#"allies", game.stat[#"roundswon"][#"allies"]);
    [[level._setteamscore]](#"axis", game.stat[#"roundswon"][#"axis"]);
  }

  laststand_mp::function_414115a0(level.laststandtimer, level.laststandhealth);
  level.var_4cfc17cc = struct::get_script_bundle("killstreak", #"killstreak_bounty_deposit_site_heli");
  function_fb6f71d5();
  function_9f5ae64d();
  level thread function_7cb5420e(level.var_b9aad767);

  level thread function_b968a61c();

}

private onspawnplayer(predictedspawn) {
  spawning::onspawnplayer(predictedspawn);
}

function_5439aa67() {
  self endon(#"death", #"revived");

  while(isDefined(self)) {
    if(self function_cf8de58d()) {
      self dodamage(10000, self.origin, undefined, undefined, undefined, "MOD_UNKNOWN", 0, level.shockrifleweapon);
      return;
    }

    waitframe(1);
  }
}

private function_95002a59(attacker, victim, inflictor, weapon, meansofdeath) {
  if(attacker == self) {
    return;
  }

  var_e9d49a33 = 0;
  self notify(#"minigame_laststand");

  if(isDefined(weapon) && killstreaks::is_killstreak_weapon(weapon)) {
    var_e9d49a33 = 1;
  }

  if(!var_e9d49a33) {
    overrideentitycamera = player::function_c0f28ff9(attacker, weapon);
    var_50d1e41a = potm::function_775b9ad1(weapon, meansofdeath);
    potm::function_66d09fea(#"hash_11588f7b0737f095", attacker, self, inflictor, var_50d1e41a, overrideentitycamera);
  }

  if(isDefined(attacker)) {
    [[level.var_37d62931]](attacker, 1);
    attacker.pers[#"downs"] = (isDefined(attacker.pers[#"downs"]) ? attacker.pers[#"downs"] : 0) + 1;
    attacker.downs = attacker.pers[#"downs"];
  }

  self thread function_5439aa67();
}

private onplayerrevived(revivee, reviver) {
  [[level.var_37d62931]](reviver, 1);
  reviver.pers[#"revives"] = (isDefined(reviver.pers[#"revives"]) ? reviver.pers[#"revives"] : 0) + 1;
  reviver.revives = reviver.pers[#"revives"];
  revivee notify(#"revived");
}

buy_menu_open() {
  assert(isDefined(level.var_968635ea));

  if(!level.var_968635ea bountyhunterbuy::is_open(self)) {
    level.var_968635ea bountyhunterbuy::open(self);
  }
}

buy_menu_close() {
  assert(isDefined(level.var_968635ea));

  if(level.var_968635ea bountyhunterbuy::is_open(self)) {
    level.var_968635ea bountyhunterbuy::close(self);
  }

  level.var_7e7897b8 gameobjects::set_visible_team(#"any");
}

private function_c04cc87c() {
  level.var_324e2795 = 1;
  level.var_7aa0d894 = 1;
  objective_setinvisibletoall(level.var_7e7897b8.objectiveid);

  while(game.state != "playing") {
    waitframe(1);
  }

  globallogic_utils::pausetimer();
  level.purchasephase = 1;

  foreach(player in level.players) {
    player thread globallogic_audio::set_music_on_player("spawnPreLoop");
    player[[level.givecustomloadout]]();
  }

  if(function_8b1a219a()) {
    foreach(player in level.players) {
      player freezecontrols(1);
      player globallogic_ui::closemenus();
    }

    wait 1;
  } else {
    foreach(player in level.players) {
      player globallogic_ui::closemenus();
    }

    waitframe(1);
  }

  foreach(player in level.players) {
    if(!function_8b1a219a()) {
      player freezecontrols(1);
    }

    player buy_menu_open();
    player setlowready(1);
  }

  thread globallogic_audio::leader_dialog("bountyBuyStart");
  clockobject = spawn("script_origin", (0, 0, 0));
  timeremaining = level.var_b9aad767;

  while(timeremaining > 0) {
    level clientfield::set_world_uimodel("BountyHunterLoadout.timeRemaining", timeremaining);

    if(timeremaining == 5) {
      foreach(player in level.players) {
        player globallogic_audio::set_music_on_player("spawnPreRise");
      }
    }

    if(timeremaining <= 5) {
      clockobject playSound(#"mpl_ui_timer_countdown");
    }

    if(timeremaining <= 1) {
      foreach(player in level.players) {
        player setlowready(0);
        player buy_menu_close();
        player globallogic_ui::closemenus();
      }
    }

    timeremaining--;
    wait 1;
  }

  level.var_324e2795 = 0;
  level.purchasephase = 0;

  foreach(player in level.players) {
    player stopallboasts(1);
    player[[level.givecustomloadout]]();
    player freezecontrols(0);
    player globallogic_audio::set_music_on_player("spawnShort");
    player clientfield::set_to_player("realtime_multiplay", 1);
  }

  if(game.roundsplayed == 0) {
    if(level.hardcoremode) {
      thread globallogic_audio::leader_dialog("hcStartBounty");
    } else {
      thread globallogic_audio::leader_dialog("startBounty");
    }

    thread globallogic_audio::leader_dialog("bountyModeOrder");
  } else {
    thread globallogic_audio::leader_dialog("startRoundBounty");
  }

  level.var_7aa0d894 = undefined;
  level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", 1);
  globallogic_utils::resumetimer();
  objective_setvisibletoall(level.var_7e7897b8.objectiveid);
  thread radar_sweeps::radarsweeps();
}

private ondeadevent(team) {
  if(team == "all") {
    if(isDefined(level.var_a379a090)) {
      function_36f8016e(level.var_a379a090, 6);
      return;
    }

    function_b8793906(6);
    return;
  }

  if(isDefined(level.var_a379a090)) {
    return;
  }

  level.var_a379a090 = util::get_enemy_team(team);

  if(isDefined(level.numlives) ? level.numlives : 0) {
    challenges::last_man_defeat_3_enemies(level.var_a379a090);
  }

  if(game.stat[#"roundswon"][level.var_a379a090] >= level.roundwinlimit - 1) {
    function_36f8016e(level.var_a379a090, 6);
    return;
  }

  level thread function_a981417();
  level thread function_30b3b16e(level.var_a379a090);
}

private function_a981417() {
  level endon(#"game_ended");
  level.var_6938f270 = 1;

  while(game.state == "playing") {
    if(isDefined(level.var_ad7774db)) {
      if(isDefined(level.var_ad7774db.keyobject[0].carrier) && level.var_ad7774db.keyobject[0].carrier istouching(level.var_ad7774db.trigger)) {
        level.var_ad7774db.userate *= level.var_6938f270;
        level.var_ad7774db.autodecaytime /= level.var_6938f270;

        if(level.var_ad7774db.autodecaytime < 0.001) {
          level.var_ad7774db.autodecaytime = 0.001;
        }

        level.var_6938f270 += 0.1 * float(level.var_9fee970c) / 1000;
      }
    }

    waitframe(1);
  }
}

private function_acf3ff19() {
  level endon(#"game_ended");
  level.timerpaused = 0;

  while(game.state == "playing") {
    if(isDefined(level.var_ad7774db)) {
      if(isDefined(level.var_ad7774db.keyobject[0].carrier) && level.var_ad7774db.keyobject[0].carrier istouching(level.var_ad7774db.trigger)) {
        if(!level.timerpaused) {
          pause_time();
          level.timerpaused = 1;
        }
      } else if(level.timerpaused) {
        resume_time();
        level.timerpaused = 0;
      }
    }

    waitframe(1);
  }
}

private function_30b3b16e(winner) {
  if(isDefined(level.var_18823aed) && level.var_18823aed > 0) {
    thread globallogic_audio::leader_dialog("bountyCashTimerStart", winner);
    level.timelimitoverride = 1;
    setgameendtime(gettime() + int(level.var_18823aed * 1000));
    hostmigration::waitlongdurationwithgameendtimeupdate(level.var_18823aed);

    if(game.state != "playing") {
      return;
    }

    thread globallogic_audio::leader_dialog("bountyCashTimerFail", winner);
  }

  function_36f8016e(winner, 6);
}

private ontimelimit() {
  function_b8793906(2);
}

function_b8793906(var_c1e98979) {
  round::set_flag("tie");
  function_9698aa74(#"none");
  thread globallogic::end_round(var_c1e98979);
}

function_36f8016e(winning_team, var_c1e98979) {
  round::set_winner(winning_team);
  function_9698aa74(winning_team);
  thread globallogic::function_a3e3bd39(winning_team, var_c1e98979);
}

private ononeleftevent(team) {
  if(!isDefined(level.warnedlastplayer)) {
    level.warnedlastplayer = [];
  }

  if(isDefined(level.warnedlastplayer[team])) {
    return;
  }

  level.warnedlastplayer[team] = 1;
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == team && isDefined(player.pers[#"class"])) {
      if(player.sessionstate == "playing" && !player.afk) {
        break;
      }
    }
  }

  if(i == players.size) {
    return;
  }

  players[i] thread givelastattackerwarning(team);
  util::function_5a68c330(17, player.team, player getentitynumber());
}

private onroundswitch() {
  gametype::on_round_switch();
}

private onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(level.numlives) ? level.numlives : 0) {
    clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a);
    enemy_team = util::getotherteam(self.team);

    if(!isDefined(level.var_1df52fe0)) {
      level.var_1df52fe0 = [];
    }

    var_ff9338bb = level.playercount[self.team] * level.numlives - level.deaths[self.team];

    if(var_ff9338bb == 1) {
      level.var_1df52fe0[self.team] = 1;
    } else if(var_ff9338bb <= 3 && var_ff9338bb > 1 && !(isDefined(level.var_1df52fe0[self.team]) && level.var_1df52fe0[self.team])) {
      thread globallogic_audio::leader_dialog("bountyLowLives", self.team);
      thread globallogic_audio::leader_dialog("bountyLowLivesEnemy", enemy_team);
      level.var_1df52fe0[self.team] = 1;
    }
  }

  if(isDefined(self) && isDefined(attacker) && isplayer(attacker) && attacker != self && attacker.team != self.team && !self laststand_mp::is_cheating()) {
    scoreevents::processscoreevent(#"eliminated_enemy", attacker, self, weapon);
    attacker contracts::function_fd9fb79b(#"contract_mp_eliminations");

    if(var_ff9338bb === 0) {
      attacker stats::function_dad108fa(#"eliminated_final_enemy", 1);
    }
  }

  self function_4f2c425d();
}

private onscoreevent(params) {
  if(self laststand_mp::is_cheating()) {
    return;
  }

  event = params.event;

  if(!isDefined(level.scoreinfo[event])) {
    return;
  }

  money = self rank::function_bcb5e246(event);

  if(isDefined(money) && money > 0 && !(params.victim === self)) {
    self function_3a77006e(money, "moneychange_scoreevent");
    self playsoundtoplayer(#"hash_767e2476f594e0f3", self);
  }
}

private onplayerdamage(params) {
  if(isDefined(params) && isDefined(params.eattacker) && isplayer(params.eattacker) && isDefined(params.idamage)) {
    if(params.eattacker.team == self.team) {
      return;
    }

    player = params.eattacker;

    if(player laststand_mp::is_cheating()) {
      return;
    }

    var_80ed4b57 = params.idamage;

    if(laststand::player_is_in_laststand() && isDefined(self.var_969fabf4) && var_80ed4b57 > self.var_969fabf4) {
      var_80ed4b57 = self.var_969fabf4;
    } else if(var_80ed4b57 < 0) {
      var_80ed4b57 = 0;
    } else if(var_80ed4b57 > self.health) {
      var_80ed4b57 = self.health;
    }

    player function_3a77006e(var_80ed4b57, "moneychange_playerdamage");
    player playsoundtoplayer(#"hash_767e2476f594e0f3", player);
  }
}

private function_f7b64ada() {
  if(game.state == "playing") {
    foreach(weapondata in self.pers[#"dynamic_loadout"].weapons) {
      weapondata.ammo = -1;
    }
  }

  self thread function_f7ef4642();
}

private function_f7ef4642() {
  waitframe(1);

  if(isDefined(self) && isalive(self)) {
    level thread popups::displayteammessagetoteam(#"hash_4fe1c041d2f3e71", self, self.team, undefined, undefined);
  }
}

private function_1a0c2b72(revivedplayer) {
  if(isDefined(self) && isalive(self) && isDefined(revivedplayer)) {
    level thread popups::displayteammessagetoteam(#"hash_17c6b0524e578976", self, self.team, revivedplayer.entnum, undefined);
  }
}

private function_8cac4c76() {
  waitframe(1);
  clientfield::set_world_uimodel("hudItems.team1.noRespawnsLeft", 1);
  clientfield::set_world_uimodel("hudItems.team2.noRespawnsLeft", 1);
}

private function_4f2c425d() {
  if(!isDefined(level.var_7e7897b8)) {
    return;
  }

  if(!isDefined(level.var_7e7897b8.carrier)) {
    return;
  }

  if(!isDefined(self.team)) {
    return;
  }

  var_fe63ca41 = getteamplayersalive(self.team);

  if(var_fe63ca41 <= 0) {
    self.var_6bd898f7 = level.var_7e7897b8.carrier getentitynumber();
    return;
  }

  teammates = getplayers(self.team);

  foreach(teammate in teammates) {
    if(teammate == level.var_7e7897b8.carrier) {
      self.var_6bd898f7 = teammate getentitynumber();
      return;
    }
  }
}

private givelastattackerwarning(team) {
  self endon(#"death", #"disconnect");
  fullhealthtime = 0;
  interval = 0.05;
  self.lastmansd = 1;
  enemyteam = util::get_enemy_team(team);

  if(level.alivecount[enemyteam] > 2) {
    self.var_66cfa07f = 1;
  }

  while(true) {
    if(self.health != self.maxhealth) {
      fullhealthtime = 0;
    } else {
      fullhealthtime += interval;
    }

    wait interval;

    if(self.health == self.maxhealth && fullhealthtime >= 3) {
      break;
    }
  }

  self thread globallogic_audio::leader_dialog_on_player("roundEncourageLastPlayer");
  thread globallogic_audio::leader_dialog_for_other_teams("roundEncourageLastPlayerEnemy", self.team, undefined, undefined);
  self playlocalsound(#"mus_last_stand");
}

function_c04436fc() {
  foreach(player in level.players) {
    if(isDefined(level.var_a5221eec) && level.var_a5221eec == player.team) {
      player function_3a77006e(level.var_3e14d8dd, "moneychange_bagomoney");
    }
  }
}

private function_9698aa74(winner) {
  foreach(player in level.players) {
    if(isalive(player)) {
      foreach(weapondata in player.pers[#"dynamic_loadout"].weapons) {
        weapondata.ammo = -1;
      }
    }

    player dynamic_loadout::function_cea5cbc5();
    player dynamic_loadout::removearmor();

    if(!level.var_59e1bdd9) {
      player.pers[#"pickup_health"] = 0;
    }

    if(!player laststand_mp::is_cheating()) {
      if(player.team == winner) {
        player scoreevents::processscoreevent(#"round_won", player);
        continue;
      }

      player scoreevents::processscoreevent(#"round_lost", player);
    }
  }
}

private function_b3faa437() {
  var_fa06e6b7 = struct::get_array("bounty_bag_o_money", "variantname");
  var_85b31568 = var_fa06e6b7[randomint(var_fa06e6b7.size)].origin;
  usetrigger = spawn("trigger_radius_use", var_85b31568 + (0, 0, 15), 0, 80, 60);
  usetrigger triggerignoreteam();
  usetrigger setvisibletoall();
  usetrigger setteamfortrigger(#"none");
  usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
  usetrigger function_682f34cf(-800);
  var_8b6f8e45 = [];
  var_8b6f8e45[0] = spawn("script_model", var_85b31568);
  var_8b6f8e45[0] setModel("p8_heist_duffel_bag_set_open");
  var_7e7897b8 = gameobjects::create_carry_object(#"neutral", usetrigger, var_8b6f8e45, (0, 0, 0), #"bag_o_money");
  var_7e7897b8 gameobjects::set_use_hint_text(#"hash_ee4d709a0f80280");
  var_7e7897b8 gameobjects::allow_carry(#"any");
  var_7e7897b8 gameobjects::set_visible_team(#"any");
  var_7e7897b8 gameobjects::set_use_time(level.var_8cfdca96);
  var_7e7897b8 gameobjects::set_objective_entity(var_7e7897b8);
  var_7e7897b8 gameobjects::function_63f73e1d(#"hash_510667a4ac8024c3");
  var_7e7897b8.objectiveonself = 1;
  var_7e7897b8.allowweapons = 1;
  var_7e7897b8.onpickup = &function_cd23eebc;
  var_7e7897b8.ondrop = &function_62d627a0;
  var_7e7897b8.var_22389d70 = 0;
  var_7e7897b8.var_78149e41 = gameobjects::get_next_obj_id();
  objective_add(var_7e7897b8.var_78149e41, "invisible", var_7e7897b8, #"hash_34a0ac740c9d0bc2");
  objective_onentity(var_7e7897b8.var_78149e41, var_7e7897b8);
  var_7e7897b8 gameobjects::set_visible_team(#"none");
  level.var_7e7897b8 = var_7e7897b8;
  return var_7e7897b8;
}

private function_cd23eebc(player) {
  level.var_a5221eec = player.team;
  enemy_team = gameobjects::get_enemy_team(player.team);
  self gameobjects::set_visible_team(#"none");
  self.visuals[0] notsolid();
  player setmovespeedscale(level.var_e025e79e);
  player clientfield::set_player_uimodel("hudItems.BountyCarryingBag", 1);
  player clientfield::set("bountymoneytrail", 1);
  objective_setstate(self.var_78149e41, "active");
  objective_onentity(self.var_78149e41, player);
  objective_setteam(self.var_78149e41, player.team);
  function_3ae6fa3(self.var_78149e41, player.team, 1);
  objective_setinvisibletoplayer(self.var_78149e41, player);

  if(!isDefined(self.var_b8ced2f9) && !self laststand_mp::is_cheating()) {
    scoreevents::processscoreevent(#"hash_2626334909405935", player, undefined, undefined);
    self.var_b8ced2f9 = 1;
  }

  level thread function_2ad9733b();
  level thread popups::displayteammessagetoall(#"hash_5f69531a71a74e3d", player);
  thread globallogic_audio::leader_dialog("bountyCashAcquiredFriendly", player.team);
  thread globallogic_audio::leader_dialog("bountyCashAcquiredEnemy", util::getotherteam(player.team));

  if(level.var_16fd9420) {
    self thread function_319af5a2(player);
    return;
  }

  player clientfield::set_to_player("bountyBagMoney", 1);
}

private function_319af5a2(player) {
  self endon(#"hash_1af469c6cd76e56b");
  objective_setprogress(self.var_78149e41, float(level.var_3e14d8dd) / level.var_b2a8558a);
  player clientfield::set_to_player("bountyBagMoney", int(float(level.var_3e14d8dd) / level.var_16fd9420));

  while(level.var_3e14d8dd > level.var_714ddf4a) {
    if(isDefined(level.var_ad7774db)) {
      if(player istouching(level.var_ad7774db.trigger)) {
        waitframe(1);
        continue;
      }
    }

    wait level.var_651c849;
    level.var_3e14d8dd -= level.var_16fd9420;

    if(level.var_3e14d8dd < level.var_714ddf4a) {
      level.var_3e14d8dd = level.var_714ddf4a;
    } else if(level.var_3e14d8dd > level.var_3e14d8dd) {
      level.var_3e14d8dd = level.var_3e14d8dd;
    }

    objective_setprogress(self.var_78149e41, float(level.var_3e14d8dd) / level.var_b2a8558a);
    player clientfield::set_to_player("bountyBagMoney", int(float(level.var_3e14d8dd) / level.var_16fd9420));
  }

  player clientfield::set_to_player("bountyBagMoney", int(float(level.var_3e14d8dd) / level.var_16fd9420));
}

private function_62d627a0(player) {
  self notify(#"hash_1af469c6cd76e56b");
  self.visuals[0] solid();

  if(isDefined(self.var_78149e41)) {
    objective_setstate(self.var_78149e41, "invisible");
    objective_onentity(self.var_78149e41, self);
    objective_setteam(self.var_78149e41, #"none");
    objective_setvisibletoplayer(self.var_78149e41, player);
    function_3ae6fa3(self.var_78149e41, player.team, 0);
  }

  player setmovespeedscale(1);
  level.var_a5221eec = undefined;
  level.var_3e14d8dd -= level.var_d4fe7ba9;
  self gameobjects::set_visible_team(#"any");
  level thread popups::displayteammessagetoall(#"hash_5e8cd98e9533c77d", player);
  player clientfield::set_player_uimodel("hudItems.BountyCarryingBag", 0);
  player clientfield::set("bountymoneytrail", 0);
  self playSound(#"hash_6f33c21d562757a1");
}

private function_7f8c4043() {
  if(isDefined(level.var_a740d54d)) {
    return level.var_a740d54d;
  }

  var_1c8f5a97 = struct::get_array("bounty_deposit_location", "variantname");

  if(var_1c8f5a97.size == 0) {
    var_1c8f5a97[0] = {};
    mapcenter = airsupport::getmapcenter();
    var_1c8f5a97[0].origin = getclosestpointonnavmesh(mapcenter, 256, 32);
  } else if(var_1c8f5a97.size > 1) {
    if(isDefined(game.var_46ffd493)) {
      closestdist = 2147483647;
      closestindex = -1;

      for(i = 0; i < var_1c8f5a97.size; i++) {
        dist = distancesquared(game.var_46ffd493, var_1c8f5a97[i].origin);

        if(dist < closestdist) {
          closestdist = dist;
          closestindex = i;
        }
      }

      if(closestindex >= 0) {
        arrayremoveindex(var_1c8f5a97, closestindex);
      }
    }

    closestdist = 2147483647;
    closestindex = -1;

    for(i = 0; i < var_1c8f5a97.size; i++) {
      dist = distancesquared(level.var_7e7897b8.origin, var_1c8f5a97[i].origin);

      if(dist < closestdist) {
        closestdist = dist;
        closestindex = i;
      }
    }

    if(closestindex >= 0) {
      arrayremoveindex(var_1c8f5a97, closestindex);
    }
  }

  var_fa5724d5 = var_1c8f5a97[randomint(var_1c8f5a97.size)].origin;
  level.var_a740d54d = var_fa5724d5;
  game.var_46ffd493 = var_fa5724d5;
  return level.var_a740d54d;
}

private function_fb6f71d5() {
  level.var_a740d54d = undefined;
}

private function_9f5ae64d() {
  if(isDefined(level.var_8fcae189)) {
    level.var_8fcae189 notify(#"strobe_stop");
    level.var_8fcae189 = undefined;
  }
}

private function_7cb5420e(delay) {
  while(game.state != "playing") {
    waitframe(1);
  }

  if(isDefined(level.var_8fcae189)) {
    return;
  }

  if(isDefined(delay)) {
    wait delay;
  }

  var_fa5724d5 = function_7f8c4043();
  level.var_8fcae189 = ir_strobe::function_284b1d4c(var_fa5724d5, #"wpn_t8_eqp_grenade_smoke_world");
  level.var_b167ae9a = gameobjects::get_next_obj_id();
  objective_add(level.var_b167ae9a, "active", level.var_8fcae189, #"hash_7e7657e9c8f441eb");
  function_da7940a3(level.var_b167ae9a, 1);
}

private function_2ad9733b() {
  if(isDefined(level.var_1f3975e4)) {
    return;
  }

  level.var_1f3975e4 = 1;
  function_7cb5420e();
  tempcontext = {};
  function_f878f4bf(function_7f8c4043(), tempcontext);
}

private function_f878f4bf(var_fa5724d5, context) {
  assert(isDefined(var_fa5724d5));
  level.var_8fcae189 = ir_strobe::function_284b1d4c(var_fa5724d5, #"wpn_t8_eqp_grenade_smoke_world");
  var_8ff770b8 = randomfloatrange(level.var_aad1f6f2, level.var_8ce231e3);
  wait var_8ff770b8;
  destination = getstartorigin(var_fa5724d5, (0, 0, 0), #"ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2");
  var_6aa266d6 = helicopter::getvalidrandomstartnode(destination).origin;
  helicopter = function_d23cf101(var_6aa266d6, vectortoangles(destination - var_6aa266d6), context);
  helicopter endon(#"death", #"hash_69d2c68fdf86b6d7");
  helicopter.hardpointtype = undefined;
  waitframe(1);
  function_554b5692(helicopter);
  helicopter thread function_1aca4a4e(helicopter, destination);
  helicopter waittill(#"reached_destination");
  helicopter thread function_4af1c786(helicopter, var_fa5724d5);
  wait_start = gettime();

  while(helicopter.origin[2] - var_fa5724d5[2] > 620 && gettime() - wait_start < 1000) {
    wait 0.1;
  }

  level thread function_f9a7a3d8(helicopter);

  if(!isDefined(level.var_ad7774db)) {
    level.var_ad7774db = function_8debcb6(var_fa5724d5);
  } else {
    level.var_ad7774db function_99e2da8b(var_fa5724d5);
  }

  level.var_ad7774db thread function_acf3ff19();
  waitresult = level.var_ad7774db waittill(#"hash_5677d0c5246418e5");

  for(prevprogress = 0; waitresult._notify == "timeout" && level.var_ad7774db.curprogress > prevprogress; prevprogress = level.var_ad7774db.curprogress) {
    waitresult = level.var_ad7774db waittilltimeout(0.25, #"hash_5677d0c5246418e5");
  }

  if(!isDefined(level.var_ad7774db)) {
    return;
  }

  if(waitresult._notify == "timeout") {
    level.var_ad7774db function_572ce431();
  }

  level.var_8fcae189 notify(#"strobe_stop");
  helicopter thread function_b48e2739(helicopter);
  context.deployed = 1;
  helicopter thread function_36f403(helicopter);
}

private function_4af1c786(helicopter, var_5ad5316d) {
  helicopter endon(#"death", #"hash_589604da14bd8976");
  var_45d0806d = var_5ad5316d;
  lerp_duration = max((helicopter.origin[2] - var_5ad5316d[2] - 600) / 625, 0.8);
  helicopter animation::play(#"ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", var_45d0806d, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, lerp_duration);

  while(true) {
    helicopter animation::play(#"ai_swat_rifle_ent_litlbird_rappel_stn_vehicle2", var_45d0806d, (0, helicopter.angles[1], 0), 1, 0.1, 0.2, 0.8);
  }
}

private function_554b5692(helicopter) {
  assert(!isDefined(helicopter.rope));
  helicopter.rope = spawn("script_model", helicopter.origin);
  assert(isDefined(helicopter.rope));
  helicopter.rope useanimtree("generic");
  helicopter.rope setModel(#"hash_142fee14ea7bdb9b");
  helicopter.rope linkto(helicopter, "tag_origin_animate");
  helicopter.rope hide();
}

private function_f9a7a3d8(helicopter) {
  assert(isDefined(helicopter.rope));
  helicopter endon(#"death", #"hash_69d2c68fdf86b6d7", #"hash_3478587618f28c8");
  helicopter.rope endon(#"death");
  helicopter.rope show();
  helicopter.rope animation::play(#"hash_751de00c6e9e0862", helicopter, "tag_origin_animate", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
  childthread function_5db7fc11(helicopter);
}

private function_5db7fc11(helicopter) {
  assert(isDefined(helicopter.rope));

  while(true) {
    helicopter.rope animation::play(#"hash_217d8ba9d8489561", helicopter, "tag_origin_animate", 1, 0.1, 0.1, undefined, undefined, undefined, 0);
  }
}

private function_b48e2739(helicopter) {
  if(!isDefined(helicopter.rope)) {
    return;
  }

  helicopter endon(#"hash_69d2c68fdf86b6d7", #"death");
  helicopter.rope endon(#"death");
  helicopter notify(#"hash_3478587618f28c8");
  helicopter.rope thread animation::play(#"hash_3d52f6faf02fd23", helicopter, "tag_origin_animate", 1, 0.2, 0.1, undefined, undefined, undefined, 0);
  playFXOnTag(#"hash_24fa7e1844b116bb", helicopter.rope, "duffel_attach_jnt");
  var_314ff04b = getanimlength(#"hash_3d52f6faf02fd23") + 15;
  wait var_314ff04b;
  function_b09faaf8(helicopter);
}

private function_b09faaf8(helicopter) {
  helicopter endon(#"death");

  if(isDefined(helicopter.rope)) {
    helicopter.rope delete();
  }
}

heli_reset() {
  self cleartargetyaw();
  self cleargoalyaw();
  self setyawspeed(75, 45, 45);
  self setmaxpitchroll(30, 30);
}

function_36f403(helicopter) {
  helicopter notify(#"leaving");
  helicopter notify(#"hash_589604da14bd8976");
  helicopter.leaving = 1;
  leavenode = helicopter::getvalidrandomleavenode(helicopter.origin);
  var_b4c35bb7 = leavenode.origin;
  heli_reset();
  helicopter vehclearlookat();
  exitangles = vectortoangles(var_b4c35bb7 - helicopter.origin);
  helicopter setgoalyaw(exitangles[1]);

  if(isDefined(level.var_e071ed64) && level.var_e071ed64) {
    if(!ispointinnavvolume(helicopter.origin, "navvolume_big")) {
      if(issentient(helicopter)) {
        helicopter function_60d50ea4();
      }

      radius = distance(self.origin, leavenode.origin);
      var_a9a839e2 = getclosestpointonnavvolume(helicopter.origin, "navvolume_big", radius);

      if(isDefined(var_a9a839e2)) {
        helicopter function_9ffc1856(var_a9a839e2, 0);

        while(true) {

          recordsphere(var_a9a839e2, 8, (0, 0, 1), "<dev string:x38>");

            var_baa92af9 = ispointinnavvolume(helicopter.origin, "navvolume_big");

          if(var_baa92af9 && !issentient(helicopter)) {
            helicopter makesentient();
            break;
          }

          waitframe(1);
        }
      }
    }

    if(!ispointinnavvolume(leavenode.origin, "navvolume_big")) {
      helicopter thread function_8de67419(leavenode);
      helicopter waittill(#"hash_2bf34763927dd61b");
    }
  }

  helicopter function_9ffc1856(var_b4c35bb7, 1);
  helicopter waittilltimeout(20, #"near_goal", #"death");

  if(isDefined(helicopter)) {
    helicopter stoploopsound(1);
    helicopter util::death_notify_wrapper();

    if(isDefined(helicopter.alarm_snd_ent)) {
      helicopter.alarm_snd_ent stoploopsound();
      helicopter.alarm_snd_ent delete();
      helicopter.alarm_snd_ent = undefined;
    }

    helicopter delete();
  }
}

private function_d23cf101(origin, angles, context) {
  helicopter = spawnvehicle(#"vehicle_t8_mil_helicopter_swat_transport", origin, angles, "bounty_deposit_site_helicopter");
  helicopter.spawntime = gettime();
  helicopter.attackers = [];
  helicopter.attackerdata = [];
  helicopter.attackerdamage = [];
  helicopter.flareattackerdamage = [];
  helicopter.killstreak_id = context.killstreak_id;
  helicopter setdrawinfrared(1);
  helicopter.allowcontinuedlockonafterinvis = 1;
  helicopter.soundmod = "heli";
  helicopter.takedamage = 0;
  notifydist = 128;
  helicopter setneargoalnotifydist(notifydist);
  bundle = level.var_4cfc17cc;
  helicopter.maxhealth = bundle.kshealth;
  helicopter.health = bundle.kshealth;
  helicopter.overridevehicledamage = &function_b9192530;
  context.helicopter = helicopter;
  var_99c4651a = 0;

  if(var_99c4651a) {
    helicopter.target_offset = (0, 0, -25);
    target_set(helicopter, (0, 0, -25));
  }

  helicopter setrotorspeed(1);
  aitype = "spawner_mp_swat_buddy_team1_male";
  pilot = spawnactor(aitype, helicopter.origin, (0, 0, 0));
  pilot.var_e09b732c = 1;
  pilot.ai.swat_gunner = 1;
  pilot linkto(helicopter, "tag_driver", (0, 0, 0), (0, 0, 0));
  pilot.ignoreall = 1;
  pilot.ignoreme = 1;
  pilot ai::gun_remove();
  pilot.takedamage = 0;
  pilot setteam(#"free");
  return helicopter;
}

private function_1aca4a4e(helicopter, destination) {
  helicopter endon(#"death");
  var_7f4a508d = destination;

  if(isDefined(level.var_e071ed64) && level.var_e071ed64) {
    helicopter thread function_656691ab();

    if(!ispointinnavvolume(var_7f4a508d, "navvolume_big")) {
      var_a9a839e2 = getclosestpointonnavvolume(destination, "navvolume_big", 10000);
      var_7f4a508d = (var_a9a839e2[0], var_a9a839e2[1], destination[2]);

      if(isDefined(var_7f4a508d)) {
        helicopter function_9ffc1856(var_7f4a508d, 1);
        helicopter.var_7f4a508d = var_7f4a508d;

        if(!ispointinnavvolume(var_7f4a508d, "navvolume_big")) {
          self waittilltimeout(10, #"hash_340ab3c2b94ff86a");
        }
      }
    }

    self function_9ffc1856(var_7f4a508d, 1);
    self waittill(#"near_goal");
  } else {
    helicopter thread airsupport::setgoalposition(destination, "bounty_deposit_site_heli_reached", 1);
    helicopter waittill(#"bounty_deposit_site_heli_reached");
  }

  last_distance_from_goal_squared = 1e+07 * 1e+07;
  continue_waiting = 1;

  for(remaining_tries = 30; continue_waiting && remaining_tries > 0; remaining_tries--) {
    current_distance_from_goal_squared = distance2dsquared(helicopter.origin, destination);
    continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > 4 * 4;
    last_distance_from_goal_squared = current_distance_from_goal_squared;

    if(continue_waiting) {
      waitframe(1);
    }
  }

  helicopter notify(#"reached_destination");
}

function_b9192530(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  bundle = level.var_4cfc17cc;
  chargelevel = 0;
  weapon_damage = killstreak_bundles::function_dd7587e4(bundle, self.maxhealth, eattacker, weapon, smeansofdeath, idamage, idflags, chargelevel);

  if(!isDefined(weapon_damage)) {
    weapon_damage = killstreaks::get_old_damage(eattacker, weapon, smeansofdeath, idamage, 1);
  }

  weapon_damage = int(weapon_damage);

  if(weapon_damage >= self.health) {
    thread destroy_heli(self);
  }

  return weapon_damage;
}

private destroy_heli(helicopter) {
  if(isDefined(level.var_ad7774db)) {
    level.var_ad7774db function_572ce431();
    level.var_8fcae189 notify(#"strobe_stop");

    if(isDefined(helicopter.rope)) {
      helicopter.rope delete();
    }
  }

  helicopter helicopter::function_e1058a3e();
  wait 0.1;

  if(isDefined(helicopter)) {
    helicopter delete();
  }
}

private function_656691ab() {
  self endon(#"death");

  while(true) {
    var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");

    if(var_baa92af9) {
      heli_reset();
      self makepathfinder();
      self makesentient();
      self.ignoreme = 1;

      if(isDefined(self.heligoalpos)) {
        self function_9ffc1856(self.heligoalpos, 1);
      }

      self notify(#"hash_340ab3c2b94ff86a");
      break;
    }

    waitframe(1);
  }
}

function_9ffc1856(goalpos, stop) {
  self.heligoalpos = goalpos;

  if(isDefined(level.var_e071ed64) && level.var_e071ed64) {
    if(issentient(self) && ispathfinder(self) && ispointinnavvolume(self.origin, "navvolume_big")) {
      self setgoal(goalpos, stop);
      self function_a57c34b7(goalpos, stop, 1);
    } else {
      self function_a57c34b7(goalpos, stop, 0);
    }

    return;
  }

  self setgoal(goalpos, stop);
}

private function_8de67419(leavenode) {
  self endon(#"death");
  radius = distance(self.origin, leavenode.origin);
  var_a9a839e2 = getclosestpointonnavvolume(leavenode.origin, "navvolume_big", radius);

  if(isDefined(var_a9a839e2)) {
    self function_9ffc1856(var_a9a839e2, 0);

    while(true) {

      recordsphere(var_a9a839e2, 8, (0, 0, 1), "<dev string:x38>");

        var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");

      if(!var_baa92af9) {
        self function_60d50ea4();
        self notify(#"hash_2bf34763927dd61b");
        break;
      }

      waitframe(1);
    }

    return;
  }

  self function_60d50ea4();
  self notify(#"hash_2bf34763927dd61b");
}

function_8debcb6(origin) {
  objective_delete(level.var_b167ae9a);
  trigger = spawn("trigger_radius_new", origin, 0, 90, 100);
  trigger triggerignoreteam();
  useobj = gameobjects::create_use_object(#"none", trigger, [], (0, 0, 0), #"hash_7e7657e9c8f441eb");
  useobj gameobjects::set_visible_team(#"any");
  useobj gameobjects::allow_use(#"any");
  useobj gameobjects::set_owner_team(#"neutral");
  useobj gameobjects::set_use_time(level.bountydepositsitecapturetime);
  useobj gameobjects::set_key_object(level.var_7e7897b8);
  useobj gameobjects::set_onbeginuse_event(&function_9ef02b1b);
  useobj gameobjects::set_onuse_event(&function_37e1bbbf);
  useobj gameobjects::function_3510971a(1);
  useobj gameobjects::function_1b4d64d8(1);
  useobj function_d8151863(origin);
  useobj.onuseupdate = &onuseupdate;
  useobj.decayprogress = level.decayprogress;
  useobj.autodecaytime = level.autodecaytime;
  useobj.cancontestclaim = 0;
  return useobj;
}

function_a800815(victim, attacker) {
  if(isDefined(level.var_7e7897b8) && (isDefined(level.var_7e7897b8.carrier) && level.var_7e7897b8.carrier == victim || isDefined(victim.var_ea1458aa) && isDefined(victim.var_ea1458aa.var_cba684c2) && victim.var_ea1458aa.var_cba684c2[level.var_7e7897b8 getentitynumber()] === 1)) {
    if(isDefined(level.var_ad7774db) && isDefined(level.var_ad7774db.trigger) && victim istouching(level.var_ad7774db.trigger)) {
      return true;
    }
  }

  return false;
}

onuseupdate(team, progress, change) {
  if(change > 0) {
    self gameobjects::set_flags(team == "allies" ? 1 : 2);
  }
}

function_d8151863(origin) {
  useobj = self;
  useobj function_ee4574b1();
  fwd = (0, 0, 1);
  right = (0, -1, 0);
  useobj.fx = spawnfx(#"ui/fx_dom_marker_team_r90", origin, fwd, right);
  useobj.fx.team = #"none";
  triggerfx(useobj.fx, 0.001);
}

function_ee4574b1() {
  useobj = self;

  if(isDefined(useobj.fx)) {
    useobj.fx delete();
  }
}

function_99e2da8b(origin) {
  useobj = self;
  useobj.origin = origin;
  useobj gameobjects::clear_progress();
  useobj gameobjects::set_visible_team(#"any");
  useobj gameobjects::allow_use(#"any");
  useobj gameobjects::set_owner_team(#"neutral");
  useobj gameobjects::set_model_visibility(1);
  useobj function_d8151863(origin);
}

function_572ce431() {
  useobj = self;
  useobj gameobjects::set_visible_team(#"none");
  useobj gameobjects::allow_use(#"none");
  useobj gameobjects::set_model_visibility(0);
  useobj function_ee4574b1();
}

function_37e1bbbf(player) {
  if(!isDefined(player)) {
    return;
  }

  if(game.state != "playing") {
    return;
  }

  useobj = self;
  useobj notify(#"hash_5677d0c5246418e5");
  useobj function_572ce431();
  player playsoundtoplayer(#"hash_19f756f885db9bb8", player);
  [[level.var_37d62931]](player, 1);
  player.pers[#"objscore"]++;
  player.objscore = player.pers[#"objscore"];
  level thread popups::displayteammessagetoall(#"hash_6bea5c334a4ab164", player);
  level function_c04436fc();
  team = player getteam();

  if(isDefined(team) && level.alivecount[team] === 1) {
    otherteam = util::getotherteam(team);
    var_b3db754a = isDefined(level.alivecount[otherteam]) ? level.alivecount[otherteam] : 0;

    if(var_b3db754a > 0) {
      player stats::function_dad108fa(#"hash_55f8a59c6d7132a8", 1);
    }
  }

  function_36f8016e(team, 1);
}

private function_9ef02b1b(sentient) {
  useobj = self;
  player = sentient;

  if(!isplayer(player)) {
    player = sentient.owner;
  }

  var_6f002c17 = player getteam();

  if(!isDefined(level.var_d7076fb6) || gettime() > level.var_d7076fb6) {
    level.var_d7076fb6 = gettime() + 1000;
    thread globallogic_audio::leader_dialog("bountyCashDepositingFriendly", var_6f002c17);
    thread globallogic_audio::leader_dialog("bountyCashDepositingEnemy", util::getotherteam(var_6f002c17));
  }

  function_bd4536a2(level.var_5ae8f1c7, var_6f002c17);
}

private function_bd4536a2(var_e70389e, var_d89c1031) {
  if(!isDefined(var_e70389e)) {
    return;
  }

  if(var_d89c1031 != var_e70389e gameobjects::get_owner_team()) {
    var_e70389e gameobjects::set_owner_team(var_d89c1031);
  }
}

private function_17debb33() {
  waitframe(1);
  pickup_health::function_e963e37d();
  pickup_ammo::function_cff1656d();
}

private function_bdba96e1() {
  waitframe(1);
  droplocations = struct::get_array("bounty_drop", "variantname");
  droppoint = droplocations[randomint(droplocations.size)].origin;
  droppoint += (0, 0, 2000);
  startpoint = helicopter::getvalidrandomstartnode(droppoint).origin;
  startpoint = (startpoint[0], startpoint[1], droppoint[2]);
  timer = randomintrange(level.var_8e8e80c6, level.var_374a483e);
  wait timer;
  supplydropveh = spawnvehicle(#"vehicle_t8_mil_helicopter_transport_mp", startpoint, vectortoangles(vectornormalize(droppoint - startpoint)));
  supplydropveh.goalradius = 128;
  supplydropveh.goalheight = 128;

  if(!isDefined(supplydropveh)) {
    return;
  }

  supplydropveh setspeed(100);
  supplydropveh setrotorspeed(1);
  supplydropveh setCanDamage(0);
  supplydropveh vehicle::toggle_tread_fx(1);
  supplydropveh vehicle::toggle_exhaust_fx(1);
  supplydropveh vehicle::toggle_sounds(1);
  supplydrop = spawn("script_model", (0, 0, 0));
  supplydrop setModel("wpn_t7_drop_box_wz");
  supplydrop linkto(supplydropveh, "tag_cargo_attach", (0, 0, -30));
  supplydropveh.supplydrop = supplydrop;
  supplydropveh function_a57c34b7(droppoint, 1, 0);
  supplydropveh thread function_6d1352cb(droppoint);
}

private function_6d1352cb(droppoint) {
  self endon(#"death");
  exitpoint = droppoint + droppoint - self.origin;

  while(true) {
    waitframe(1);
    currdist = distancesquared(self.origin, droppoint);

    if(currdist < 225 * 225) {
      self setspeed(0);
      self.supplydrop unlink();
      self.supplydrop moveto(droppoint - (0, 0, 1990), 2);
      self.supplydrop playSound("evt_supply_drop");
      self.supplydrop thread function_9ec1d15();
      self.supplydrop = undefined;
      self setspeed(100);
      break;
    }
  }

  self function_a57c34b7(exitpoint);
  timeout = distance(self.origin, exitpoint) / 1000;
  wait timeout;
  self delete();
}

private function_9ec1d15() {
  wait 2.01;
  self physicslaunch();
  self waittill(#"stationary");
  self.trigger = spawn("trigger_radius_use", self.origin, 0, 100, 60);
  self.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
  self.trigger triggerignoreteam();
  self.gameobject = gameobjects::create_use_object(#"neutral", self.trigger, [], (0, 0, 60), "bounty_drop", 1);
  self.gameobject gameobjects::set_objective_entity(self.gameobject);
  self.gameobject gameobjects::set_visible_team(#"any");
  self.gameobject gameobjects::allow_use(#"any");
  self.gameobject gameobjects::set_use_time(1.5);
  self.gameobject.onenduse = &function_d4a84cde;
  self.gameobject.usecount = 0;
  self.gameobject.parentobj = self;
  thread globallogic_audio::leader_dialog("bountyAirdropDetected");
}

private function_d4a84cde(team, player, result) {
  self.isdisabled = 0;

  if(isDefined(result) && result && isDefined(player) && isplayer(player)) {
    self.usecount++;
    player function_3a77006e(level.var_860cdbdb, "moneychange_bountydrop");
    player pickup_health::function_dd4bf8ac(level.var_a2b93ad3);
    weapons = player getweaponslist();

    foreach(weapon in weapons) {
      player givestartammo(weapon);
    }

    player playsoundtoplayer(#"hash_19f756f885db9bb8", player);
    self gameobjects::hide_waypoint(player);
    self.trigger setinvisibletoplayer(player);

    if(self.usecount >= level.var_854eeded) {
      self gameobjects::disable_object(1);
      return;
    }
  }
}

function_3a77006e(amount, reason) {
  if(!isDefined(self.pers[#"money"]) || self laststand_mp::is_cheating()) {
    return;
  }

  self.pers[#"money"] += amount;
  self.pers[#"money_earned"] += amount;
  [[level._setplayerscore]](self, self.pers[#"money_earned"]);
  self clientfield::set_to_player("bountyMoney", self.pers[#"money"]);
  bb::function_95a5b5c2(reason, "", self.team, self.origin, self);
}

pause_time() {
  if(level.timepauseswheninzone && !(isDefined(level.timerpaused) && level.timerpaused)) {
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
  }
}

resume_time() {
  if(level.timepauseswheninzone && isDefined(level.timerpaused) && level.timerpaused) {
    globallogic_utils::resumetimer();
    level.timerpaused = 0;
  }
}

function_b1dcb019() {
  path = "<dev string:x41>";
  cmd = "<dev string:x56>";
  util::add_devgui(path + "<dev string:x6e>", cmd + "<dev string:x7b>");
  util::add_devgui(path + "<dev string:x80>", cmd + "<dev string:x8e>");
  util::add_devgui(path + "<dev string:x94>", cmd + "<dev string:xa2>");
  util::add_devgui(path + "<dev string:xa8>", cmd + "<dev string:xb6>");
  util::add_devgui(path + "<dev string:xbc>", cmd + "<dev string:xcb>");
}

function_b968a61c() {
  level notify(#"hash_7069fa0a73642e1f");
  level endon(#"hash_7069fa0a73642e1f");
  wait 1;
  function_b1dcb019();
  wait 1;

  while(true) {
    wait 0.25;
    var_9b37b387 = getdvarint(#"hash_312d65fd43c7008c", 0);

    if(var_9b37b387 <= 0) {
      continue;
    }

    player = level.players[0];

    if(isplayer(player)) {
      player.pers[#"money"] += var_9b37b387;
      player clientfield::set_to_player("<dev string:xd2>", player.pers[#"money"]);
    }

    setdvar(#"hash_312d65fd43c7008c", 0);
  }
}

