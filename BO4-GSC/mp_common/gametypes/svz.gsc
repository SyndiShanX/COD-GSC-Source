/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\svz.gsc
***********************************************/

#include scripts\abilities\ability_util;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\infection;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_role;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\killstreaks;
#include scripts\mp_common\bb;
#include scripts\mp_common\draft;
#include scripts\mp_common\gametypes\dogtags;
#include scripts\mp_common\gametypes\gametype;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\gametypes\spawning;
#include scripts\mp_common\laststand;
#include scripts\mp_common\player\player_loadout;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\util;

#namespace svz;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  infection::initialize();
  infection::function_153000d0(#"hash_70fe115fad3f4fa", #"hash_3ca96ae1bd7d344f");
  level.var_757f1b92 = getweapon("melee_bowie_bloody");
  level.var_4ae49bbd = getweapon("hatchet");
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundscorelimit(0, 10000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
  level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
  level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
  level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
  level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
  level.overrideteamscore = 1;
  level.takelivesondeath = 1;
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onroundswitch = &onroundswitch;
  level.onendround = &onendround;
  level.onendgame = &onendgame;
  level.ontimelimit = &ontimelimit;
  level.var_cdb8ae2c = &function_a8da260c;
  level.givecustomloadout = &givecustomloadout;
  level.var_30783ca9 = &function_507d58da;
  callback::on_connect(&onconnect);
  level.var_8a400007 = 5;
  player::function_cf3aa03d(&onplayerkilled);
  infection::function_db5ddd5f("specialty_sprint");
  infection::function_db5ddd5f("specialty_slide");
  infection::function_db5ddd5f("specialty_quieter");
  infection::function_db5ddd5f("specialty_loudenemies");
  infection::function_db5ddd5f("specialty_tracker");
  infection::function_db5ddd5f("specialty_fallheight");
  infection::function_db5ddd5f("specialty_fastladderclimb");
  infection::function_db5ddd5f("specialty_fastmantle");
  globallogic_spawn::addsupportedspawnpointtype("tdm");
  globallogic_audio::set_leader_gametype_dialog("startInfect", "hcStartInfect", "infectOrdersOfs", "infectOrdersDef", "bbStartInfect", "hcbbStartInfect");
  setdvar(#"g_allowlaststandforactiveclients", 1);
  setdvar(#"hash_7036719f41a78d54", 50);

  if(getdvarint(#"hash_5795d85dc4b1b0d9", 0)) {
    level.var_49a15413 = getdvarint(#"hash_5795d85dc4b1b0d9", 0);
    level.scoremodifiercallback = &function_f9df98d3;
  }
}

function_a8da260c() {
  foreach(team, _ in level.teams) {
    spawning::add_spawn_points(team, "mp_tdm_spawn");
    spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
    spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
  }

  spawning::updateallspawnpoints();
}

function_938b51ca() {
  util::wait_network_frame();
  clientfield::set_world_uimodel("hudItems.team" + level.teamindex[game.defenders] + ".noRespawnsLeft", 1);
}

onstartgametype() {
  level.var_51e72062 = 1;
  level thread function_938b51ca();
  level.var_a236b703[game.defenders] = 1;
  level.var_61952d8b[game.defenders] = 1;
  infection::function_a2d73bc3(game.attackers);
  level.displayroundendtext = 0;
  level thread onscoreclosemusic();

  if(!util::isoneround()) {
    level.displayroundendtext = 1;

    if(level.scoreroundwinbased) {
      globallogic_score::resetteamscores();
    }
  }

  if(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
    level.numlives = 1;
  }
}

function_fe170e7() {
  self endon(#"disconnect");

  while(level.inprematchperiod) {
    waitframe(1);
  }

  if(!isDefined(self)) {
    return;
  }

  if(!(isDefined(self.var_417bcbbd) && self.var_417bcbbd)) {
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }

    playFXOnTag("player/fx8_plyr_infect_change_flash_3p", self, "j_spine4");
    self playsoundontag(#"hash_757c35cbad846c27", "j_spine4");
    wait 0.5;

    if(!isDefined(self)) {
      return;
    }

    self.var_417bcbbd = 1;
  }

  function_d3beb9d3();
  self infection::give_body();
}

onspawnplayer(predictedspawn) {
  self.usingobj = undefined;

  if(level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
    level.usestartspawns = 0;
  }

  if(self.team == game.attackers) {
    self.var_ec2d285c = 0;

    if(!isDefined(self.pers[#"cachedrole"])) {
      self.pers[#"cachedrole"] = self player_role::get();
    }

    self thread function_fe170e7();
  } else if(isDefined(self.pers[#"cachedrole"])) {
    self player_role::set(self.pers[#"cachedrole"], 1);
    self.pers[#"cachedrole"] = undefined;
  }

  spawning::onspawnplayer(predictedspawn);
}

ontimelimit() {
  round::set_winner(game.defenders);
  thread globallogic::end_round(2);
}

onroundswitch() {
  gametype::on_round_switch();
}

onendround(var_c1e98979) {
  if(globallogic::function_8b4fc766(var_c1e98979)) {
    winning_team = round::get_winning_team();
    globallogic_score::giveteamscoreforobjective(winning_team, 1);
  }
}

onscoreclosemusic() {
  teamscores = [];

  while(!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.1;
    scorethresholdstart = abs(scorelimit - scorethreshold);
    scorelimitcheck = scorelimit - 10;
    topscore = 0;
    runnerupscore = 0;

    foreach(team, _ in level.teams) {
      score = [
        [level._getteamscore]
      ](team);

      if(score > topscore) {
        runnerupscore = topscore;
        topscore = score;
        continue;
      }

      if(score > runnerupscore) {
        runnerupscore = score;
      }
    }

    scoredif = topscore - runnerupscore;

    if(topscore >= scorelimit * 0.5) {
      level notify(#"sndmusichalfway");
      return;
    }

    wait 1;
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(smeansofdeath == "MOD_META") {
    return;
  }

  if(self.team == game.defenders) {
    self.iseliminated = 1;
    clientfield::set_player_uimodel("hudItems.playerLivesCount", 0);
  }

  if(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
    thread dogtags::checkallowspectating();
    should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();

    if(should_spawn_tags) {
      level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
    }
  }

  if(isplayer(attacker) == 0 || attacker.team == self.team) {
    return;
  }

  if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore) {
    attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
    self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
    }
  }
}

function_f9df98d3(type, value) {
  if(type === #"ekia") {
    return (value + level.var_49a15413);
  }

  return value;
}

givecustomloadout(takeallweapons, alreadyspawned) {
  if(self.team == game.attackers) {
    self function_bbde018c();
  } else if(self.team == game.defenders) {
    self function_845acdea();
  }

  return self.spawnweapon;
}

function_845acdea() {
  loadout::init_player(1);
  loadout::function_f436358b(self.curclass);
  level.givecustomloadout = undefined;
  loadout::give_loadout(self.team, self.curclass);
  level.givecustomloadout = &givecustomloadout;
}

function_d3beb9d3() {
  attackers = getplayers(game.attackers);

  if(attackers.size < 2) {
    return;
  }

  foreach(player in attackers) {
    if(!isalive(player)) {
      continue;
    }

    if(player.var_8a886ffc !== level.var_757f1b92) {
      if(isDefined(player.var_8a886ffc)) {
        player takeweapon(player.var_8a886ffc);
      }

      newweapon = level.var_757f1b92;
      player function_e6d991bc(newweapon);
    }
  }
}

function_e6d991bc(weapon) {
  self giveweapon(weapon);
  self givestartammo(weapon);
  self setblockweaponpickup(weapon, 1);
  self switchtoweapon(weapon);
  self.var_8a886ffc = weapon;
}

function_bbde018c() {
  loadout::init_player(1);

  if(loadout::function_87bcb1b()) {
    loadout::function_f436358b(self.curclass);
  }

  self infection::give_loadout();
  defaultweapon = level.var_757f1b92;
  self function_e6d991bc(defaultweapon);
  self setspawnweapon(defaultweapon);
  self.spawnweapon = defaultweapon;
  primaryoffhand = level.var_4ae49bbd;
  primaryoffhandcount = 1;
  self giveweapon(primaryoffhand);
  self setweaponammostock(primaryoffhand, primaryoffhandcount);
  self switchtooffhand(primaryoffhand);
  self.grenadetypeprimary = primaryoffhand;
  self.grenadetypeprimarycount = primaryoffhandcount;

  if(isDefined(level.specialistequipmentreadyonrespawn) && level.specialistequipmentreadyonrespawn) {
    self ability_util::gadget_power_full(primaryoffhand);
  }

  self giveweapon(level.weaponbasemelee);
  self.heroweapon = undefined;
}

function_507d58da() {
  n_random_int = randomintrange(1, 2);
  game.musicset = "_zm_0" + n_random_int;
}

function_8d346fd8(winningteam) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    if(!isDefined(players[i].pers[#"team"])) {
      continue;
    }

    if(level.hostforcedend && players[i] ishost()) {
      continue;
    }

    if(winningteam == "tie") {
      globallogic_score::updatetiestats(players[i]);
      continue;
    }

    if(players[i].pers[#"team"] == winningteam) {
      globallogic_score::updatewinstats(players[i]);
      continue;
    }

    if(level.rankedmatch && !level.leaguematch && players[i].pers[#"latejoin"] === 1) {
      globallogic_score::updatelosslatejoinstats(players[i]);
    }

    if(!level.disablestattracking) {
      players[i] stats::set_stat(#"playerstatslist", "cur_win_streak", #"statvalue", 0);
    }
  }
}

onendgame(var_c1e98979) {
  if(level.scoreroundwinbased) {
    globallogic_score::updateteamscorebyroundswon();
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
  } else {
    winner = globallogic::determineteamwinnerbyteamscore();
  }

  match::function_af2e264f(winner);
}

onconnect() {
  waitframe(1);

  if(level.ingraceperiod === 1 && level.draftstage != 3) {
    wait 1;
    draft::assign_remaining_players(self);
  }
}