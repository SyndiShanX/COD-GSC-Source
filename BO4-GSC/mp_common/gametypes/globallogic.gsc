/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic.gsc
***********************************************/

#include scripts\abilities\ability_power;
#include scripts\core_common\array_shared;
#include scripts\core_common\bb_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\globallogic\globallogic_shared;
#include scripts\core_common\healthoverlay;
#include scripts\core_common\high_value_operative;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\infection;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\killcam_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\map;
#include scripts\core_common\match_record;
#include scripts\core_common\math_shared;
#include scripts\core_common\persistence_shared;
#include scripts\core_common\platoons;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\potm_shared;
#include scripts\core_common\rank_shared;
#include scripts\core_common\rat_shared;
#include scripts\core_common\simple_hostmigration;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\system_shared;
#include scripts\core_common\tweakables_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\killstreaks;
#include scripts\mp_common\arena;
#include scripts\mp_common\bots\mp_bot;
#include scripts\mp_common\challenges;
#include scripts\mp_common\draft;
#include scripts\mp_common\gameadvertisement;
#include scripts\mp_common\gamerep;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\clientids;
#include scripts\mp_common\gametypes\deathicons;
#include scripts\mp_common\gametypes\dev;
#include scripts\mp_common\gametypes\display_transition;
#include scripts\mp_common\gametypes\dogtags;
#include scripts\mp_common\gametypes\gametype;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_defaults;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\globallogic_ui;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\hostmigration;
#include scripts\mp_common\gametypes\hud_message;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\menus;
#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\gametypes\overtime;
#include scripts\mp_common\gametypes\radar_sweeps;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\gametypes\serversettings;
#include scripts\mp_common\gametypes\shellshock;
#include scripts\mp_common\player\player;
#include scripts\mp_common\player\player_loadout;
#include scripts\mp_common\player\player_monitor;
#include scripts\mp_common\player\player_record;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\rat;
#include scripts\mp_common\teams\platoons;
#include scripts\mp_common\teams\teams;
#include scripts\mp_common\userspawnselection;
#include scripts\mp_common\util;
#include scripts\weapons\mp\weapons;
#include scripts\weapons\weapon_utils;
#include scripts\weapons\weapons;

#namespace globallogic;

autoexec __init__system__() {
  system::register(#"globallogic", &__init__, undefined, #"visionset_mgr");
}

__init__() {
  if(!isDefined(level.vsmgr_prio_visionset_mpintro)) {
    level.vsmgr_prio_visionset_mpintro = 5;
  }

  visionset_mgr::register_info("visionset", "mpintro", 1, level.vsmgr_prio_visionset_mpintro, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
  level.host_migration_activate_visionset_func = &mpintro_visionset_activate_func;
  level.host_migration_deactivate_visionset_func = &mpintro_visionset_deactivate_func;
  visionset_mgr::register_info("visionset", "crithealth", 1, 4, 25, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
  clientfield::register("clientuimodel", "huditems.killedByEntNum", 1, 4, "int");
  clientfield::register("clientuimodel", "huditems.killedByAttachmentCount", 1, 4, "int");
  clientfield::register("clientuimodel", "huditems.killedByItemIndex", 1, 10, "int");
  clientfield::register("clientuimodel", "huditems.killedByMOD", 1, 8, "int");

  for(index = 0; index < 5; index++) {
    clientfield::register("clientuimodel", "huditems.killedByAttachment" + index, 1, 6, "int");
  }

  clientfield::register("toplayer", "thermal_sight", 1, 1, "int");
  clientfield::register("toplayer", "strobe_light", 1, 1, "int");
  clientfield::register("allplayers", "cold_blooded", 1, 1, "int");
  level.weaponpineapplegun = getweapon(#"hero_pineapplegun");
  level.weaponpineapplegungrenade = getweapon(#"hero_pineapple_grenade");
  ability_power::function_9d78823f(level.weaponpineapplegun, level.weaponpineapplegungrenade);
  callback::on_spawned(&on_player_spawned);
  callback::on_game_playing(&on_game_playing);
}

private on_player_spawned() {
  self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
  self.strobed = 0;
}

init() {
  level.splitscreen = issplitscreen();
  level.xenon = getdvarstring(#"xenongame") == "true";
  level.ps3 = getdvarstring(#"ps3game") == "true";
  level.wiiu = getdvarstring(#"wiiugame") == "true";
  level.orbis = getdvarstring(#"orbisgame") == "true";
  level.durango = getdvarstring(#"durangogame") == "true";
  level.onlinegame = sessionmodeisonlinegame();
  level.systemlink = sessionmodeissystemlink();
  level.console = level.xenon || level.ps3 || level.wiiu || level.orbis || level.durango;
  level.rankedmatch = gamemodeisusingxp();
  level.leaguematch = 0;
  level.custommatch = gamemodeismode(1) || gamemodeismode(7);
  level.arenamatch = gamemodeisarena();
  level.mpcustommatch = level.custommatch;
  level.contractsenabled = !getgametypesetting(#"disablecontracts");
  level.contractsenabled = 0;
  level.disablevehicleburndamage = 1;
  level.var_49d9aa70 = 1;

  if(getdvarint(#"scr_forcerankedmatch", 0) == 1) {
    level.rankedmatch = 1;
  }

    level.script = util::get_map_name();
  level.gametype = util::get_game_type();
  level.var_837aa533 = hash(level.gametype);

  if(isDefined(level.gametype)) {
    level.var_12323003 = function_16495154(level.gametype);
  }

  level.teambased = 0;
  level.teamcount = getgametypesetting(#"teamcount");

  level.teamcount = math::clamp(level.teamcount, 1, getdvarint(#"com_maxclients", level.teamcount));

    level.multiteam = level.teamcount > 2;
  level.maxteamplayers = getgametypesetting(#"maxteamplayers");
  level.competitivesettingsenabled = getgametypesetting(#"competitivesettings") === 1;
  level.competitiveteamlives = getgametypesetting(#"competitiveteamlives") === 1;
  gametype::init();
  init_teams();
  level.var_724cf71 = 1;

  thread function_340107d4();

    level.overrideteamscore = 0;
  level.overrideplayerscore = 0;
  level.displayhalftimetext = 0;
  level.displayroundendtext = 1;
  level.clampscorelimit = 1;
  level.endgameonscorelimit = 1;
  level.endgameontimelimit = 1;
  level.scoreroundwinbased = 0;
  level.resetplayerscoreeveryround = 0;
  level.doendgamescoreboard = 1;
  level.gameforfeited = 0;
  level.forceautoassign = 0;
  level.halftimetype = 2;
  level.laststatustime = 0;
  level.waswinning = [];
  level.lastslowprocessframe = 0;
  level.placement = [];

  foreach(team, _ in level.teams) {
    level.placement[team] = [];
  }

  level.placement[#"all"] = [];
  level.defaultoffenseradius = 560;
  level.defaultoffenseradiussq = level.defaultoffenseradius * level.defaultoffenseradius;
  level.dropteam = getdvarint(#"sv_maxclients", 0);
  level.infinalkillcam = 0;
  level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
  setdvar(#"bg_boastenabled", getgametypesetting(#"boastenabled"));
  setdvar(#"hash_e099986c072eb0f", getgametypesetting(#"hash_104f124f56f0f20a"));
  setdvar(#"hash_553ad8f9db24bf22", int(1000 * getgametypesetting(#"hash_1614b9cbe0df6f75")));
  function_9afe34e3();
  gameobjects::register_allowed_gameobject(level.gametype);

  if(isDefined(level.var_d1455682)) {
    gameobjectname = level.var_d1455682.gameobjectname;

    if(isDefined(gameobjectname)) {
      gameobjects::register_allowed_gameobject(gameobjectname);
    }
  }

  map::init();
  globallogic_ui::init();
  registerdvars();
  loadout::init_dvars();
  level.oldschool = getgametypesetting(#"oldschoolmode");
  display_transition::init_shared();
  precache_mp_leaderboards();

  if(!isDefined(game.tiebreaker)) {
    game.tiebreaker = 0;
  }

  if(!isDefined(game.stat)) {
    game.stat = [];
  }

  thread gameadvertisement::init();
  thread gamerep::init();
  level.disablechallenges = 0;

  if(level.leaguematch || getdvarint(#"scr_disablechallenges", 0) > 0) {
    level.disablechallenges = 1;
  }

  level.disablestattracking = getdvarint(#"scr_disablestattracking", 0) > 0;
  setup_callbacks();
  clientfield::register("playercorpse", "firefly_effect", 1, 2, "int");
  clientfield::register("playercorpse", "annihilate_effect", 1, 1, "int");
  clientfield::register("playercorpse", "pineapplegun_effect", 1, 1, "int");
  clientfield::register("actor", "annihilate_effect", 1, 1, "int");
  clientfield::register("actor", "pineapplegun_effect", 1, 1, "int");
  clientfield::register("world", "game_ended", 1, 1, "int");
  clientfield::register("world", "post_game", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.hideOutcomeUI", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.captureCrateState", 1, 2, "int");
  clientfield::register("clientuimodel", "hudItems.captureCrateTotalTime", 1, 13, "int");
  clientfield::register("worlduimodel", "hudItems.team1.roundsWon", 1, 4, "int");
  clientfield::register("worlduimodel", "hudItems.team1.livesCount", 1, 8, "int");
  clientfield::register("worlduimodel", "hudItems.team1.noRespawnsLeft", 1, 1, "int");
  clientfield::register("worlduimodel", "hudItems.team2.roundsWon", 1, 4, "int");
  clientfield::register("worlduimodel", "hudItems.team2.livesCount", 1, 8, "int");
  clientfield::register("worlduimodel", "hudItems.team2.noRespawnsLeft", 1, 1, "int");
  clientfield::register("worlduimodel", "hudItems.specialistSwitchIsLethal", 1, 1, "int");
  clientfield::register_clientuimodel("hudItems.playerLivesCount", 1, 8, "int", 0);
  clientfield::register("clientuimodel", "hudItems.armorIsOnCooldown", 1, 1, "int");
  level thread setroundswonuimodels();
  level.figure_out_attacker = &player::figure_out_attacker;
  level.figure_out_friendly_fire = &player::figure_out_friendly_fire;
  thread hud_message::init();
}

function_340107d4() {
  while(true) {
    wait 2;
    level.var_724cf71 = getdvarint(#"scr_ekia", level.var_724cf71);
  }
}

  function private init_teams() {
    level.teams = [];
    level.teamindex = [];
    teamcount = level.teamcount;

    if(level.teamcount == 1) {
      teamcount = getdvarint(#"com_maxclients", 17) + 1;
      level.teams[#"free"] = "free";
    }

    level.teams[#"allies"] = "allies";
    level.teams[#"axis"] = "axis";
    level.teamindex[#"world"] = "world";
    level.teamindex[#"neutral"] = 0;
    level.teamindex[#"allies"] = 1;
    level.teamindex[#"axis"] = 2;

    for(teamindex = 3; teamindex < teamcount + 1; teamindex++) {
      level.teams[hash("team" + teamindex)] = "team" + teamindex;
      level.teamindex[hash("team" + teamindex)] = teamindex;
    }

    level.var_75dffa9f = [];
    callback::callback(#"init_teams");
  }

function_9afe34e3() {
  level.var_336c35f1 = [];
  globallogic_utils::function_4aa8d809(0, "dnf");
  globallogic_utils::function_4aa8d809(1, "completed");
  globallogic_utils::function_4aa8d809(2, "time limit");
  globallogic_utils::function_4aa8d809(3, "scorelimit");
  globallogic_utils::function_4aa8d809(4, "roundscorelimit");
  globallogic_utils::function_4aa8d809(5, "roundlimit");
  globallogic_utils::function_4aa8d809(6, "team eliminated");
  globallogic_utils::function_4aa8d809(7, "forfeit");
  globallogic_utils::function_4aa8d809(8, "ended game");
  globallogic_utils::function_4aa8d809(9, "host ended game");
  globallogic_utils::function_4aa8d809(10, "host ended sucks");

  for(i = 0; i < 5; i++) {
    globallogic_utils::function_4aa8d809(11 + i, "gamemode-specific");
  }
}

registerdvars() {
  setmatchflag("bomb_timer", 0);
  level.vehicledamagescalar = getdvarfloat(#"scr_vehicle_damage_scalar", 1);
  level.fire_audio_repeat_duration = getdvarint(#"fire_audio_repeat_duration", 0);
  level.fire_audio_random_max_duration = getdvarint(#"fire_audio_random_max_duration", 0);
  setdvar(#"g_customteamname_allies", "");
  setdvar(#"g_customteamname_axis", "");
  setdvar(#"hash_8351525729015ab", 1);
}

setroundswonuimodels() {
  waitframe(1);
  alliesroundswon = 0;
  axisroundswon = 0;

  if(isDefined(game.stat[#"roundswon"])) {
    alliesroundswon = game.stat[#"roundswon"][#"allies"];
    axisroundswon = game.stat[#"roundswon"][#"axis"];
  }

  clientfield::set_world_uimodel("hudItems.team1.roundsWon", alliesroundswon);
  clientfield::set_world_uimodel("hudItems.team2.roundsWon", axisroundswon);
}

blank(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10) {}

setup_callbacks() {
  level.spawnplayer = &globallogic_spawn::spawnplayer;
  level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
  level.spawnclient = &globallogic_spawn::spawnclient;
  level.spawnspectator = &globallogic_spawn::spawnspectator;
  level.spawnintermission = &globallogic_spawn::spawnintermission;
  level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
  level.onplayerscore = &globallogic_score::default_onplayerscore;
  level.onteamscore = &globallogic_score::default_onteamscore;
  level.gamehistoryplayerkicked = &gamehistoryplayerkicked;
  level.wavespawntimer = &wavespawntimer;
  level.spawnmessage = &globallogic_spawn::default_spawnmessage;
  level.onspawnplayer = &blank;
  level.onspawnplayer = &spawning::onspawnplayer;
  level.onspawnspectator = &globallogic_defaults::default_onspawnspectator;
  level.onspawnintermission = &globallogic_defaults::default_onspawnintermission;
  level.onrespawndelay = &blank;
  level.onforfeit = &globallogic_defaults::default_onforfeit;
  level.ontimelimit = &globallogic_defaults::default_ontimelimit;
  level.onscorelimit = &globallogic_defaults::default_onscorelimit;
  level.onroundscorelimit = &globallogic_defaults::default_onroundscorelimit;
  level.onalivecountchange = &globallogic_defaults::default_onalivecountchange;
  level.ondeadevent = undefined;
  level.ononeleftevent = &globallogic_defaults::default_ononeleftevent;
  level.giveteamscore = &globallogic_score::giveteamscore;
  level.gettimepassed = &globallogic_utils::gettimepassed;
  level.gettimelimit = &globallogic_defaults::default_gettimelimit;
  level.getteamkillpenalty = &globallogic_defaults::default_getteamkillpenalty;
  level.getteamkillscore = &globallogic_defaults::default_getteamkillscore;
  level.iskillboosting = &globallogic_score::default_iskillboosting;
  level.var_37d62931 = &globallogic_score::function_37d62931;
  level._setteamscore = &globallogic_score::_setteamscore;
  level._setplayerscore = &globallogic_score::_setplayerscore;
  level._getteamscore = &globallogic_score::_getteamscore;
  level._getplayerscore = &globallogic_score::_getplayerscore;
  level.resetplayerscorestreaks = &globallogic_score::resetplayerscorechainandmomentum;
  level.onprecachegametype = &blank;
  level.onstartgametype = &blank;
  level.onplayerconnect = &blank;
  level.onplayerdisconnect = &blank;
  level.onplayerdamage = &blank;
  level.var_da2045d0 = [];
  level.var_fa66fada = [];
  level.var_6c4ec3fc = &function_8af3b312;
  level.onteamoutcomenotify = &hud_message::teamoutcomenotify;
  level.onoutcomenotify = &hud_message::outcomenotify;
  level.onendround = &blank;
  level.onendgame = &globallogic_defaults::onendgame;
  level.onmedalawarded = &blank;
  level.var_df67ea13 = &globallogic_defaults::function_108c4b65;
  level.var_36a111f3 = &function_10dc43bc;

  if(sessionmodeiswarzonegame()) {
    level.var_b10e134d = &player_monitor::function_d35f877a;
  }

  level callback::add_callback(#"on_last_alive", &globallogic_defaults::function_dcf41142);
  level callback::add_callback(#"hash_6b7d26d34885b425", &function_b29d2423);
  globallogic_ui::setupcallbacks();
}

precache_mp_friend_leaderboards() {
  hardcoremode = getgametypesetting(#"hardcoremode");

  if(!isDefined(hardcoremode)) {
    hardcoremode = 0;
  }

  arenamode = isarenamode();
  postfix = "";

  if(hardcoremode) {
    postfix = "_HC";
  } else if(arenamode) {
    postfix = "_ARENA";
  }

  friendleaderboarda = "LB_MP_FRIEND_A" + postfix;
  friendleaderboardb = " LB_MP_FRIEND_B" + postfix;
  precacheleaderboards(friendleaderboarda + friendleaderboardb);
}

precache_mp_anticheat_leaderboards() {
  hardcoremode = getgametypesetting(#"hardcoremode");

  if(!isDefined(hardcoremode)) {
    hardcoremode = 0;
  }

  arenamode = isarenamode();
  postfix = "";

  if(hardcoremode) {
    postfix = "_HC";
  } else if(arenamode) {
    postfix = "_ARENA";
  }

  anticheatleaderboard = "LB_MP_ANTICHEAT_" + level.gametype + postfix;

  if(level.gametype != "fr") {
    anticheatleaderboard += " LB_MP_ANTICHEAT_GLOBAL";
  }

  precacheleaderboards(anticheatleaderboard);
}

precache_mp_public_leaderboards() {
  mapname = util::get_map_name();
  hardcoremode = getgametypesetting(#"hardcoremode");

  if(!isDefined(hardcoremode)) {
    hardcoremode = 0;
  }

  arenamode = isarenamode();
  freerunmode = level.gametype == "fr";
  postfix = "";

  if(freerunmode) {
    frleaderboard = " LB_MP_GM_FR_" + getsubstr(mapname, 3, mapname.size);
    precacheleaderboards(frleaderboard);
    return;
  } else if(hardcoremode) {
    postfix = "_HC";
  } else if(arenamode) {
    postfix = "_ARENA";
  }

  careerleaderboard = " LB_MP_GB_SCORE" + postfix;
  prestigelb = " LB_MP_GB_XPPRESTIGE";
  gamemodeleaderboard = "LB_MP_GM_" + level.gametype + postfix;
  arenaleaderboard = "";

  if(gamemodeismode(6)) {
    arenaslot = arenagetslot();
    arenaleaderboard = " LB_MP_ARENA_MASTERS_0" + arenaslot;
  }

  precacheleaderboards(gamemodeleaderboard + careerleaderboard + prestigelb + arenaleaderboard);
}

precache_mp_custom_leaderboards() {
  customleaderboards = "LB_MP_CG_" + level.gametype;
  precacheleaderboards("LB_MP_CG_GENERAL " + customleaderboards);
}

precache_mp_leaderboards() {
  if(bot::is_bot_ranked_match()) {
    return;
  }

  if(level.rankedmatch || level.gametype == "fr") {
    precache_mp_public_leaderboards();
    precache_mp_friend_leaderboards();
    precache_mp_anticheat_leaderboards();
    return;
  }

  precache_mp_custom_leaderboards();
}

compareteambygamestat(gamestat, teama, teamb, previous_winner_score) {
  winner = undefined;
  assert(teama !== "<dev string:x38>");

  if(previous_winner_score == game.stat[gamestat][teamb]) {
    winner = undefined;
  } else if(game.stat[gamestat][teamb] > previous_winner_score) {
    winner = teamb;
  } else {
    winner = teama;
  }

  return winner;
}

determineteamwinnerbygamestat(gamestat) {
  teamkeys = getarraykeys(level.teams);
  winner = teamkeys[0];
  previous_winner_score = game.stat[gamestat][winner];

  for(teamindex = 1; teamindex < teamkeys.size; teamindex++) {
    winner = compareteambygamestat(gamestat, winner, teamkeys[teamindex], previous_winner_score);

    if(isDefined(winner)) {
      previous_winner_score = game.stat[gamestat][winner];
    }
  }

  return winner;
}

compareteambyteamscore(currentwinner, teamb, var_2a5c5ccb) {
  assert(currentwinner !== "<dev string:x38>");
  teambscore = [[level._getteamscore]](teamb);

  if(teambscore == var_2a5c5ccb) {
    return undefined;
  } else if(teambscore > var_2a5c5ccb) {
    return teamb;
  }

  return currentwinner;
}

determineteamwinnerbyteamscore() {
  teamkeys = getarraykeys(level.teams);
  winner = teamkeys[0];
  var_2a5c5ccb = [[level._getteamscore]](winner);

  for(teamindex = 1; teamindex < teamkeys.size; teamindex++) {
    winner = compareteambyteamscore(winner, teamkeys[teamindex], var_2a5c5ccb);

    if(isDefined(winner)) {
      var_2a5c5ccb = [
        [level._getteamscore]
      ](winner);
    }
  }

  return winner;
}

forceend(hostsucks = 0) {
  if(level.hostforcedend || level.forcedend) {
    return;
  }

  level.forcedend = 1;
  level.hostforcedend = 1;

  if(hostsucks) {
    var_c1e98979 = 10;
  } else {
    var_c1e98979 = 9;
  }

  setmatchflag("disableIngameMenu", 1);
  round::function_870759fb();
  round::set_flag("force_end_host");
  thread end_round(var_c1e98979);
}

killserverpc() {
  if(level.hostforcedend || level.forcedend) {
    return;
  }

  level.forcedend = 1;
  level.hostforcedend = 1;
  level.killserver = 1;
  round::set_flag("force_end_host");
  round::function_870759fb();
  thread end_round(9);
}

atleasttwoteams() {
  valid_count = 0;

  foreach(team, _ in level.teams) {
    if(level.playercount[team] != 0) {
      valid_count++;
    }
  }

  if(valid_count < 2) {
    return false;
  }

  return true;
}

function_f25690c1(team) {
  if(!game.everexisted[team]) {
    return false;
  }

  if(level.playercount[team] < 1) {
    return true;
  }

  return false;
}

function_4b670b29() {
  if(game.state != "playing") {
    return false;
  }

  if(util::totalplayercount() == 0) {
    return false;
  }

  params = {
    #teams_forfeited: [], 
    #var_6eb69269: []
  };

  foreach(team, _ in level.teams) {
    if(function_f25690c1(team)) {
      if(!isDefined(params.teams_forfeited)) {
        params.teams_forfeited = [];
      } else if(!isarray(params.teams_forfeited)) {
        params.teams_forfeited = array(params.teams_forfeited);
      }

      params.teams_forfeited[params.teams_forfeited.size] = team;
      continue;
    }

    if(!isDefined(params.var_6eb69269)) {
      params.var_6eb69269 = [];
    } else if(!isarray(params.var_6eb69269)) {
      params.var_6eb69269 = array(params.var_6eb69269);
    }

    params.var_6eb69269[params.var_6eb69269.size] = team;
  }

  if(platoons::function_382a49e0() && !infection::function_74650d7()) {
    params.var_f300b200 = [];

    foreach(team in params.teams_forfeited) {
      platoon = getteamplatoon(team);

      if(platoon != #"none" && platoon != #"invalid") {
        if(!isDefined(params.var_f300b200)) {
          params.var_f300b200 = [];
        } else if(!isarray(params.var_f300b200)) {
          params.var_f300b200 = array(params.var_f300b200);
        }

        if(!isinarray(params.var_f300b200, platoon)) {
          params.var_f300b200[params.var_f300b200.size] = platoon;
        }
      }
    }

    params.var_b2ee6c67 = [];

    foreach(team in params.var_6eb69269) {
      platoon = getteamplatoon(team);

      if(!isDefined(params.var_b2ee6c67)) {
        params.var_b2ee6c67 = [];
      } else if(!isarray(params.var_b2ee6c67)) {
        params.var_b2ee6c67 = array(params.var_b2ee6c67);
      }

      if(!isinarray(params.var_b2ee6c67, platoon)) {
        params.var_b2ee6c67[params.var_b2ee6c67.size] = platoon;
      }
    }

    if(params.var_b2ee6c67.size == 1 && params.var_f300b200.size > 0) {
      thread[[level.onforfeit]](params);
      return true;
    }
  } else if(params.var_6eb69269.size == 1 && params.teams_forfeited.size > 0) {
    thread[[level.onforfeit]](params);
    return true;
  }

  return false;
}

dospawnqueueupdates() {
  foreach(team, _ in level.teams) {
    if(level.spawnqueuemodified[team]) {
      [
        [level.onalivecountchange]
      ](team);
    }
  }
}

function_7b75ee16(team) {
  if(level.playerlives[team]) {
    return true;
  }

  if(level.alivecount[team] - level.laststandcount[team] > 0) {
    return true;
  }

  return false;
}

function_9c839e9() {
  params = {
    #var_8245068d: 0, 
    #var_46a749a8: [], 
    #teams_alive: []
  };
  aliveteam = undefined;

  foreach(team, _ in level.teams) {
    if(teams::function_9dd75dad(team)) {
      params.var_8245068d++;

      if(!teams::is_all_dead(team)) {
        if(!isDefined(params.teams_alive)) {
          params.teams_alive = [];
        } else if(!isarray(params.teams_alive)) {
          params.teams_alive = array(params.teams_alive);
        }

        params.teams_alive[params.teams_alive.size] = team;
        continue;
      }

      if(!isDefined(params.var_46a749a8)) {
        params.var_46a749a8 = [];
      } else if(!isarray(params.var_46a749a8)) {
        params.var_46a749a8 = array(params.var_46a749a8);
      }

      params.var_46a749a8[params.var_46a749a8.size] = team;
    }
  }

  if(platoons::function_382a49e0()) {
    params.platoons_alive = [];

    foreach(team in params.teams_alive) {
      platoon = getteamplatoon(team);

      if(platoon != #"invalid") {
        if(!isDefined(params.platoons_alive)) {
          params.platoons_alive = [];
        } else if(!isarray(params.platoons_alive)) {
          params.platoons_alive = array(params.platoons_alive);
        }

        if(!isinarray(params.platoons_alive, platoon)) {
          params.platoons_alive[params.platoons_alive.size] = platoon;
        }
      }
    }

    params.var_eb1984d4 = [];

    foreach(team in params.var_46a749a8) {
      platoon = getteamplatoon(team);

      if(platoon != #"invalid" && !isDefined(params.platoons_alive[platoon])) {
        if(!isDefined(params.var_eb1984d4)) {
          params.var_eb1984d4 = [];
        } else if(!isarray(params.var_eb1984d4)) {
          params.var_eb1984d4 = array(params.var_eb1984d4);
        }

        if(!isinarray(params.var_eb1984d4, platoon)) {
          params.var_eb1984d4[params.var_eb1984d4.size] = platoon;
        }
      }
    }
  }

  if(infection::function_74650d7()) {
    params.var_dfa2cc2c = [];
    var_6c4bfa17 = infection::function_76601b7d();

    foreach(team in params.teams_alive) {
      if(getteamplatoon(team) != var_6c4bfa17) {
        params.var_dfa2cc2c[params.var_dfa2cc2c.size] = team;
      }
    }
  }

  return params;
}

function_10dc43bc(params) {
  if(params.var_8245068d == 0) {
    return false;
  }

  if(platoons::function_382a49e0()) {
    if(params.platoons_alive.size == 1 && params.var_eb1984d4.size > 0) {
      return true;
    }
  } else if(params.teams_alive.size == 1 && params.var_46a749a8.size > 0) {
    return true;
  }

  return false;
}

private function_eb1c0d37() {
  if(level.var_f97a6ba3 && !level.var_4ad4bec3) {
    return false;
  }

  foreach(team, _ in level.teams) {
    if(!level.var_f97a6ba3 && !level.everexisted[team]) {
      return false;
    }

    if(!teams::is_all_dead(team)) {
      return false;
    }
  }

  return true;
}

dodeadeventupdates() {
  if(level.teambased) {
    if(function_eb1c0d37()) {
      level callback::callback(#"hash_8a248204daef7ec");

      if(isDefined(level.ondeadevent)) {
        [
          [level.ondeadevent]
        ]("all");
      }

      return true;
    }

    foreach(team, _ in level.teams) {
      if(teams::function_9dd75dad(team) && !level.teameliminated[team]) {
        if(!function_7b75ee16(team)) {
          level.teameliminated[team] = gettime();
          level callback::callback(#"on_team_eliminated", team);

          if(isDefined(level.ondeadevent)) {
            [
              [level.ondeadevent]
            ](team);
          }
        }
      }
    }

    platoons::update_status();
    params = function_9c839e9();

    if([
        [level.var_36a111f3]
      ](params)) {
      level callback::callback(#"on_last_alive", params);
      return true;
    }
  } else if(totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1) {
    level callback::callback(#"hash_8a248204daef7ec");

    if(isDefined(level.ondeadevent)) {
      [
        [level.ondeadevent]
      ]("all");
    }

    return true;
  }

  return false;
}

private isonlyoneleftaliveonteam(team) {
  if(level.lastalivecount[team] <= 1) {
    return false;
  }

  if(level.alivecount[team] != 1) {
    return false;
  }

  if(level.playerlives[team] != 1) {
    return false;
  }

  if(isDefined(level.aliveplayers[team]) && level.aliveplayers[team].size && level.aliveplayers[team][0] laststand::player_is_in_laststand()) {
    return false;
  }

  return true;
}

doonelefteventupdates() {
  if(level.teambased) {
    foreach(team, _ in level.teams) {
      if(isonlyoneleftaliveonteam(team)) {
        [
          [level.ononeleftevent]
        ](team);
        return true;
      }
    }
  } else if(totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1) {
    [[level.ononeleftevent]]("all");
    return true;
  }

  return false;
}

function_b29d2423(params) {

  if(getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return;
  }

    if(isDefined(level.takelivesondeath) && level.takelivesondeath) {
      foreach(team, _ in level.teams) {
        player::function_c49fc862(team);
      }
    }

  if((level.rankedmatch || level.leaguematch) && !level.ingraceperiod) {
    if(level.teambased) {
      if(!level.gameforfeited) {
        if(function_4b670b29()) {
          return;
        }
      } else if(atleasttwoteams()) {
        level.gameforfeited = 0;
        level notify(#"abort forfeit");
      }
    } else if(!level.gameforfeited) {
      if(util::totalplayercount() == 1 && level.maxplayercount > 1) {
        thread[[level.onforfeit]]();
        return;
      }
    } else if(util::totalplayercount() > 1) {
      level.gameforfeited = 0;
      level notify(#"abort forfeit");
    }
  }

  if(level.ingraceperiod) {
    return;
  }

  if(level.playerqueuedrespawn) {
    dospawnqueueupdates();
  }

  if(!level.numlives && !level.numteamlives && !level.var_c2cc011f && !infection::function_74650d7()) {
    return;
  }

  if(dodeadeventupdates()) {
    return;
  }

  if(doonelefteventupdates()) {
    return;
  }
}

mpintro_visionset_ramp_hold_func() {
  level endon(#"mpintro_ramp_out_notify");

  while(true) {
    for(player_index = 0; player_index < level.players.size; player_index++) {
      self visionset_mgr::set_state_active(level.players[player_index], 1);
    }

    waitframe(1);
  }
}

mpintro_visionset_activate_func() {
  visionset_mgr::activate("visionset", "mpintro", undefined, 0, &mpintro_visionset_ramp_hold_func, 2);
}

mpintro_visionset_deactivate_func() {
  level notify(#"mpintro_ramp_out_notify");
}

showobjectivenotificationuiforallplayers(missiontype, delay) {
  level endon(#"game_ended");

  if(!isDefined(delay) || delay < 2) {
    delay = 2;
  }

  if(sessionmodeismultiplayergame()) {
    menudelay = getgametypesetting(#"bountypurchasephaseduration");

    if(isDefined(menudelay)) {
      delay += menudelay;
    }
  }

  wait delay;

  foreach(player in level.players) {
    team = player.pers[#"team"];

    if(team === #"spectator") {
      continue;
    }

    hintmessage = util::function_4a118b30(team);

    if(isDefined(hintmessage)) {
      player luinotifyevent(#"show_gametype_objective_hint", 1, hintmessage);
    }
  }
}

matchstarttimer() {
  mpintro_visionset_activate_func();
  waitforplayers();
  counttime = int(level.prematchperiod);
  var_5654073f = counttime >= 2;
  level.var_5654073f = var_5654073f;
  level.var_fd167bf6 = gettime() + int(counttime * 1000);
  luinotifyevent(#"create_prematch_timer", 2, level.var_fd167bf6, var_5654073f);

  if(var_5654073f) {
    while(counttime > 0 && !level.gameended) {
      if(counttime == 2) {
        mpintro_visionset_deactivate_func();
      }

      if(counttime == 3) {
        level thread sndsetmatchsnapshot(0);

        foreach(player in level.players) {
          if(player.hasspawned || player.pers[#"team"] == #"spectator") {
            player globallogic_audio::set_music_on_player("spawnPreRise");
          }
        }
      }

      counttime--;
      var_b9ef7eae = [];

      foreach(player in level.players) {
        shouldplaysound = 1;

        for(playeridx = 0; playeridx < var_b9ef7eae.size; playeridx++) {
          if(player isplayeronsamemachine(var_b9ef7eae[playeridx])) {
            shouldplaysound = 0;
          }
        }

        if(shouldplaysound) {
          if(sessionmodeiswarzonegame()) {
            player playlocalsound(#"hash_6a97a2aee9eb2f4");
          } else {
            player playlocalsound(#"uin_start_count_down");
          }

          var_b9ef7eae[var_b9ef7eae.size] = player;
        }
      }

      wait 1;
    }
  } else {
    mpintro_visionset_deactivate_func();
  }

  luinotifyevent(#"prematch_timer_ended", 1, var_5654073f);
}

matchstarttimerskip() {
  visionsetnaked("default", 0);
}

sndsetmatchsnapshot(num) {
  waitframe(1);
  level clientfield::set("sndMatchSnapshot", num);
}

notifyteamwavespawn(team, time) {
  if(time - level.lastwave[team] > int(level.wavedelay[team] * 1000)) {
    level notify("wave_respawn_" + team);
    level.lastwave[team] = time;
    level.waveplayerspawnindex[team] = 0;
    return true;
  }

  return false;
}

wavespawntimer() {
  self notify("1a95a923bdb84bdb");
  self endon("1a95a923bdb84bdb");
  level endon(#"game_ended");
  level callback::callback(#"hash_3be1213f454fa90e");

  if(isDefined(level.var_75db41a7) && gettime() >= level.var_75db41a7) {
    level callback::callback(#"hash_7fc21de2eaebdb3b");
    return;
  }

  while(game.state == "playing") {
    time = gettime();
    notified = 0;

    foreach(team, _ in level.teams) {
      notified |= notifyteamwavespawn(team, time);
    }

    if(notified) {
      level callback::callback(#"hash_3be1213f454fa90e");

      if(isDefined(level.var_75db41a7) && time >= level.var_75db41a7) {
        level callback::callback(#"hash_7fc21de2eaebdb3b");
        return;
      }
    }

    waitframe(1);
  }
}

hostidledout() {
  hostplayer = util::gethostplayer();

  if(getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return false;
  }

    if(isDefined(hostplayer) && !(isDefined(hostplayer.hasspawned) && hostplayer.hasspawned) && !isDefined(hostplayer.selectedclass)) {
      return true;
    }

  return false;
}

incrementmatchcompletionstat(gamemode, playedorhosted, stat) {
  if(sessionmodeiswarzonegame()) {
    return;
  }

  self stats::inc_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

setmatchcompletionstat(gamemode, playedorhosted, stat) {
  if(sessionmodeiswarzonegame()) {
    return;
  }

  self stats::set_stat(#"gamehistory", gamemode, #"modehistory", playedorhosted, stat, 1);
}

getteamscoreratio() {
  playerteam = self.pers[#"team"];
  score = getteamscore(playerteam);
  otherteamscore = 0;

  foreach(team, _ in level.teams) {
    if(team == playerteam) {
      continue;
    }

    otherteamscore += getteamscore(team);
  }

  if(level.teams.size > 1) {
    otherteamscore /= level.teams.size - 1;
  }

  if(otherteamscore != 0) {
    return (float(score) / float(otherteamscore));
  }

  return score;
}

gethighestscore() {
  highestscore = -999999999;

  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];

    if(player.score > highestscore) {
      highestscore = player.score;
    }
  }

  return highestscore;
}

getnexthighestscore(score) {
  highestscore = -999999999;

  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];

    if(player.score >= score) {
      continue;
    }

    if(player.score > highestscore) {
      highestscore = player.score;
    }
  }

  return highestscore;
}

recordplaystyleinformation() {
  if(!sessionmodeismultiplayergame()) {
    return;
  }

  avgkilldistance = 0;
  percenttimemoving = 0;
  avgspeedofplayerwhenmoving = 0;
  totalkilldistances = float(self.pers[#"kill_distances"]);
  numkilldistanceentries = float(self.pers[#"num_kill_distance_entries"]);
  timeplayedmoving = float(self.pers[#"time_played_moving"]);
  timeplayedalive = float(self.pers[#"time_played_alive"]);
  totalspeedswhenmoving = float(self.pers[#"total_speeds_when_moving"]);
  numspeedswhenmovingentries = float(self.pers[#"num_speeds_when_moving_entries"]);
  totaldistancetravelled = float(self.pers[#"total_distance_travelled"]);
  movementupdatecount = float(self.pers[#"movement_update_count"]);

  if(numkilldistanceentries > 0) {
    avgkilldistance = totalkilldistances / numkilldistanceentries;
  }

  movementupdatedenom = int(movementupdatecount / 5);

  if(movementupdatedenom > 0) {
    percenttimemoving = numspeedswhenmovingentries / movementupdatedenom * 100;
  }

  if(numspeedswhenmovingentries > 0) {
    avgspeedofplayerwhenmoving = totalspeedswhenmoving / numspeedswhenmovingentries;
  }

  recordplayerstats(self, "totalKillDistances", totalkilldistances);
  recordplayerstats(self, "numKillDistanceEntries", numkilldistanceentries);
  recordplayerstats(self, "timePlayedMoving", timeplayedmoving);
  recordplayerstats(self, "timePlayedAlive", timeplayedalive);
  recordplayerstats(self, "totalSpeedsWhenMoving", totalspeedswhenmoving);
  recordplayerstats(self, "numSpeedsWhenMovingEntries", numspeedswhenmovingentries);
  recordplayerstats(self, "averageKillDistance", avgkilldistance);
  recordplayerstats(self, "percentageOfTimeMoving", percenttimemoving);
  recordplayerstats(self, "averageSpeedDuringMatch", avgspeedofplayerwhenmoving);
  recordplayerstats(self, "totalDistanceTravelled", totaldistancetravelled);
  mpplaystyles = {
    #averagekilldistance: avgkilldistance, 
    #percentageoftimemoving: percenttimemoving, 
    #averagespeedduringmatch: avgspeedofplayerwhenmoving
  };
  function_92d1707f(#"hash_5cee5eb6de3811d0", mpplaystyles);
}

updateandfinalizematchrecord() {

  if(getdvarint(#"scr_writeconfigstrings", 0) == 1) {
    return;
  }

    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];
      player player_record::record_special_move_data_for_life(undefined);

      if(isbot(player)) {
        continue;
      }

      player player_record::record_global_mp_stats_for_player_at_match_end();
      nemesis = player.pers[#"nemesis_name"];

      if(!isDefined(player.pers[#"killed_players"][nemesis])) {
        player.pers[#"killed_players"][nemesis] = 0;
      }

      if(!isDefined(player.pers[#"killed_by"][nemesis])) {
        player.pers[#"killed_by"][nemesis] = 0;
      }

      spread = player.kills - player.deaths;

      if(player.pers[#"cur_kill_streak"] > player.pers[#"best_kill_streak"]) {
        player.pers[#"best_kill_streak"] = player.pers[#"cur_kill_streak"];
      }

      if(level.onlinegame) {
        teamscoreratio = player getteamscoreratio();
        scoreboardposition = getplacementforplayer(player);

        if(scoreboardposition < 0) {
          scoreboardposition = level.players.size;
        }

        player gamehistoryfinishmatch(4, player.kills, player.deaths, player.score, scoreboardposition, teamscoreratio);
        placement = level.placement[#"all"];

        for(otherplayerindex = 0; otherplayerindex < placement.size; otherplayerindex++) {
          if(level.placement[#"all"][otherplayerindex] == player) {
            recordplayerstats(player, "position", otherplayerindex);
          }
        }

        if(isDefined(player.pers[#"matchesplayedstatstracked"])) {
          gamemode = util::getcurrentgamemode();
          player incrementmatchcompletionstat(gamemode, "played", "completed");

          if(isDefined(player.pers[#"matcheshostedstatstracked"])) {
            player incrementmatchcompletionstat(gamemode, "hosted", "completed");
            player.pers[#"matcheshostedstatstracked"] = undefined;
          }

          player.pers[#"matchesplayedstatstracked"] = undefined;
        }

        recordplayerstats(player, "highestKillStreak", player.pers[#"best_kill_streak"]);
        recordplayerstats(player, "numUavCalled", player killstreaks::get_killstreak_usage("uav_used"));
        recordplayerstats(player, "numDogsCalleD", player killstreaks::get_killstreak_usage("dogs_used"));
        recordplayerstats(player, "numDogsKills", player.pers[#"dog_kills"]);
        recordplayerstats(player, "participation", player.pers[#"participation"]);
        recordplayerstats(player, "controllerParticipation", player.pers[#"controllerparticipation"]);
        recordplayerstats(player, "controllerParticipationChecks", player.pers[#"controllerparticipationchecks"]);
        recordplayerstats(player, "controllerParticipationChecksSkipped", player.pers[#"controllerparticipationchecksskipped"]);
        recordplayerstats(player, "controllerParticipationConsecutiveSuccessMax", player.pers[#"controllerparticipationconsecutivesuccessmax"]);
        recordplayerstats(player, "controllerParticipationConsecutiveFailureMax", player.pers[#"controllerparticipationconsecutivefailuremax"]);
        recordplayerstats(player, "controllerParticipationEndGameResult", player.pers[#"controllerparticipationendgameresult"]);
        recordplayerstats(player, "controllerParticipationInactivityWarnings", player.pers[#"controllerparticipationinactivitywarnings"]);
        recordplayerstats(player, "controllerParticipationSuccessAfterInactivityWarning", player.pers[#"controllerparticipationsuccessafterinactivitywarning"]);
        player recordplaystyleinformation();
        recordplayermatchend(player);
        function_c5906527(player);
        recordplayerstats(player, "present_at_end", 1);

        if(isDefined(player.pers) && isDefined(player.pers[#"totalmatchbonus"])) {
          recordplayerstats(player, "match_xp", player.pers[#"totalmatchbonus"]);
        } else if(isDefined(player.matchbonus)) {
          recordplayerstats(player, "match_xp", player.matchbonus);
        }
      }

      recordplayerstats(player, "damage_dealt", player.pers[#"damagedone"]);
    }

  finalizematchrecord();
}

function_c5906527(player) {
  if(isDefined(player.pers[#"scoreeventcache"])) {
    foreach(event, count in player.pers[#"scoreeventcache"]) {
      function_2c666d56(player, event, count);
    }
  }
}

gamehistoryplayerkicked() {
  teamscoreratio = self getteamscoreratio();
  scoreboardposition = getplacementforplayer(self);

  if(scoreboardposition < 0) {
    scoreboardposition = level.players.size;
  }

  assert(isDefined(self.kills));
  assert(isDefined(self.deaths));
  assert(isDefined(self.score));
  assert(isDefined(scoreboardposition));
  assert(isDefined(teamscoreratio));

    self gamehistoryfinishmatch(2, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);

  if(isDefined(self.pers[#"matchesplayedstatstracked"])) {
    gamemode = util::getcurrentgamemode();
    self incrementmatchcompletionstat(gamemode, "played", "kicked");
    self.pers[#"matchesplayedstatstracked"] = undefined;
  }

  uploadstats(self);
  wait 1;
}

gamehistoryplayerquit() {
  teamscoreratio = self getteamscoreratio();
  scoreboardposition = getplacementforplayer(self);

  if(scoreboardposition < 0) {
    scoreboardposition = level.players.size;
  }

  self gamehistoryfinishmatch(3, self.kills, self.deaths, self.score, scoreboardposition, teamscoreratio);

  if(isDefined(self.pers[#"matchesplayedstatstracked"])) {
    gamemode = util::getcurrentgamemode();
    self incrementmatchcompletionstat(gamemode, "played", "quit");

    if(isDefined(self.pers[#"matcheshostedstatstracked"])) {
      self incrementmatchcompletionstat(gamemode, "hosted", "quit");
      self.pers[#"matcheshostedstatstracked"] = undefined;
    }

    self.pers[#"matchesplayedstatstracked"] = undefined;
  }

  uploadstats(self);

  if(!self ishost()) {
    wait 1;
  }
}

function_a50a4f61(outcome) {
  if(level.teambased) {
    if(outcome::get_flag(outcome, "tie") || !isDefined(outcome::get_winning_team(outcome))) {
      demo::function_c6ae5fd6(#"game_result", level.teamindex[#"neutral"], level.teamindex[#"neutral"]);
      return;
    }

    demo::function_c6ae5fd6(#"game_result", level.teamindex[outcome::get_winning_team(outcome)], level.teamindex[#"neutral"]);
  }
}

function_9022da4e() {
  bb::function_a7ba460f(match::function_3624d032());

  if(sessionmodeismultiplayergame()) {
    mpmatchfacts = {
      #gametime: function_f8d53445(), 
      #winner: match::get_winner(), 
      #killstreakcount: level.globalkillstreakscalled
    };
    function_92d1707f(#"hash_7784f98b4b9750ec", mpmatchfacts);
  }
}

function_b0a2785c() {
  if(util::hitroundlimit() || util::hitroundwinlimit()) {
    return 5;
  } else if(util::hitscorelimit()) {
    return 3;
  } else if(util::hitroundscorelimit()) {
    return 4;
  }

  if(level.forcedend) {
    if(level.hostforcedend) {
      return 9;
    } else {
      return 8;
    }
  }

  return "time limit";
}

function_8111babb() {
  setmatchtalkflag("DeadChatWithDead", level.voip.deadchatwithdead);
  setmatchtalkflag("DeadChatWithTeam", level.voip.deadchatwithteam);
  setmatchtalkflag("DeadHearTeamLiving", level.voip.deadhearteamliving);
  setmatchtalkflag("DeadHearAllLiving", level.voip.deadhearallliving);
  setmatchtalkflag("EveryoneHearsEveryone", level.voip.everyonehearseveryone);
  setmatchtalkflag("DeadHearKiller", level.voip.deadhearkiller);
  setmatchtalkflag("KillersHearVictim", level.voip.killershearvictim);
  setmatchtalkflag("PartyChat", level.voip.partychat);
}

function_d89bf8aa() {
  if(!is_game_over()) {
    if(isDefined(level.nextroundisovertime) && level.nextroundisovertime) {
      game.overtime_round++;
    }

    player::function_2f80d95b(&val::reset, "freeze_player_for_round_end", "freezecontrols");
    player::function_2f80d95b(&val::reset, "freeze_player_for_round_end", "disablegadgets");
    player::function_2f80d95b(&clientfield::set_player_uimodel, "hudItems.hideOutcomeUI", 1);
    function_8111babb();
    function_452e18ad();
    game.state = "pregame";
    map_restart(1);
    return true;
  }

  return false;
}

function_de2b637d(winner) {
  if(!isDefined(winner)) {
    return "tie";
  }

  if(isentity(winner)) {
    return (isDefined(winner.team) ? winner.team : #"none");
  }

  return winner;
}

getroundlength() {
  if(!level.timelimit || level.forcedend) {
    gamelength = float(globallogic_utils::gettimepassed()) / 1000;
    gamelength = min(gamelength, 1200);
  } else {
    gamelength = level.timelimit * 60;
  }

  return gamelength;
}

waitanduploadstats(player, waittime) {
  wait waittime;

  if(isplayer(player)) {
    uploadstats(player);
  }
}

registerotherlootxpawards(func) {
  if(!isDefined(level.awardotherlootxpfunctions)) {
    level.awardotherlootxpfunctions = [];
  }

  if(!isDefined(level.awardotherlootxpfunctions)) {
    level.awardotherlootxpfunctions = [];
  } else if(!isarray(level.awardotherlootxpfunctions)) {
    level.awardotherlootxpfunctions = array(level.awardotherlootxpfunctions);
  }

  level.awardotherlootxpfunctions[level.awardotherlootxpfunctions.size] = func;
}

awardotherlootxp() {
  player = self;

  if(!isDefined(level.awardotherlootxpfunctions)) {
    return 0;
  }

  if(!isplayer(player)) {
    return 0;
  }

  lootxp = 0;

  foreach(func in level.awardotherlootxpfunctions) {
    if(!isDefined(func)) {
      continue;
    }

    lootxp += player[[func]]();
  }

  return lootxp;
}

private function_6c9e78d5(var_c1e98979) {
  updateplacement();
  function_68bfd6d7();
  roundlength = getroundlength();
  survey_id = function_70171add();
  current_time = gettime();
  game_over = is_game_over();
  players = level.players;

  foreach(player in players) {

    player globallogic_ui::freegameplayhudelems();

      player.pers[#"lastroundscore"] = player.pointstowin;
    player weapons::update_timings(current_time);
    player bbplayermatchend(roundlength, var_c1e98979, game_over);
    player.pers[#"totaltimeplayed"] += player.timeplayed[#"total"];

    if(sessionmodeisonlinegame()) {
      player stats::function_7a850245(#"demofileid", getdemofileid());
      player stats::function_7a850245(#"matchid", getmatchid());

      if(level.rankedmatch) {
        player stats::function_7a850245("surveyId", survey_id);
      }
    }

    player stats::function_7a850245("hardcore", level.hardcoremode);
  }

  userspawnselection::closespawnselectionmenuforallplayers();
  player::function_2f80d95b(&function_5ae24200);

  if(!util::waslastround()) {
    player::function_38de2d5a("round_ended");
  }
}

private is_game_over() {
  if(util::isoneround() || util::waslastround()) {
    return true;
  }

  return false;
}

private function_70171add() {
  if(randomfloat(1) <= getdvarfloat(#"survey_chance", 0)) {
    return randomintrange(1, getdvarint(#"survey_count", 0) + 1);
  }

  return 0;
}

private function_176452e3() {
  winning_team = round::get_winning_team();
  winner = round::get_winner();

  if(isDefined(winner) && isDefined(level.teams[winning_team])) {
    level.finalkillcam_winner = winner;
  } else {
    level.finalkillcam_winner = "none";
  }

  level.finalkillcam_winnerpicked = 1;
}

private function_9113e843() {
  winning_team = round::get_winning_team();
  overtime_round = round::get_flag("overtime");

  if(overtime_round) {
    if(isDefined(game.stat[#"overtimeroundswon"][winning_team])) {
      game.stat[#"overtimeroundswon"][winning_team]++;
    }
  }

  if(!overtime_round || util::waslastround()) {
    game.roundsplayed++;
    game.roundwinner[game.roundsplayed] = round::get_winner();

    if(isDefined(game.stat[#"roundswon"][winning_team])) {
      game.stat[#"roundswon"][winning_team]++;
    }
  }
}

private function_e8cd6051() {
  result = #"draw";

  if(!match::get_flag("tie") && match::function_c10174e7()) {
    result = match::get_winning_team();
  }

  if(result == "tie" || result == "free") {
    result = #"draw";
  }

  return result;
}

private function_d8d30361(var_c1e98979) {
  setmatchflag("game_ended", 1);
  gamestate::set_state("postgame");
  level.gameendtime = gettime();
  level.gameended = 1;
  level.var_8a3a9ca4.roundend = gettime();
  setdvar(#"g_gameended", 1);
  round::function_897438f4(var_c1e98979);

  rat::function_65e13d0f();

}

private function_68bfd6d7() {
  if(!is_game_over()) {
    game_winner = round::get_winner();
    return;
  }

  game_winner = match::function_6d0354e3();
  var_8dbf2a6d = globallogic_score::function_15683f39();

  if(isDefined(var_8dbf2a6d) && isDefined(var_8dbf2a6d.var_9cd2c51d)) {
    var_8dbf2a6d stats::function_dad108fa(#"top_scorer", 1);
    var_8dbf2a6d contracts::increment_contract(#"hash_117aee9968655de3");
  }
}

function_dd9663e5() {
  callback::function_daed27e8(#"on_end_game");
  callback::function_bea20a96(#"on_end_game");
  level notify(#"game_ended");
  level clientfield::set("gameplay_started", 0);
  level clientfield::set("game_ended", 1);
}

private function_4720c07f(outcome) {
  level.ingraceperiod = 0;
  function_dd9663e5();

  if(!isDefined(level.disableoutrovisionset) || level.disableoutrovisionset == 0) {
    visionsetnaked("mpOutro", 2);
  }

  setmatchflag("cg_drawSpectatorMessages", 0);
  globallogic_audio::flush_dialog();

  foreach(team, _ in level.teams) {
    game.lastroundscore[team] = getteamscore(team);
  }

  if(util::isroundbased()) {
    matchrecordroundend();
  }

  function_9113e843();
  function_176452e3();
  thread setroundswonuimodels();
  setgameendtime(0);
  updaterankedmatch(outcome);
  setmatchtalkflag("EveryoneHearsEveryone", 1);
  gamerep::gamerepupdateinformationforround();
  thread challenges::roundend(round::get_winner());
  function_6c9e78d5(outcome.var_c1e98979);
  gameobjects::function_407c83be();
  globallogic_utils::function_8d61a6c2(outcome.var_c1e98979);
  function_a50a4f61(outcome);
}

function_566a70ad(var_c139bfe2) {
  level.var_49d9aa70 = 0.25;
  level.var_db945f12 = level.roundenddelay[var_c139bfe2] / 4;
  setslowmotion(1, level.var_49d9aa70, level.var_db945f12);
}

function_2556afb5(scale_start, scale_end, transition_time) {
  level.var_49d9aa70 = scale_end;
  setslowmotion(scale_start, scale_end, transition_time);
}

function_452e18ad() {
  level.var_49d9aa70 = 1;
  setslowmotion(1, 1, 0);
}

function_8b4fc766(var_c1e98979) {
  switch (var_c1e98979) {
    case 0:
    case 9:
    case 10:
      return false;
    default:
      return true;
  }
}

function_a3e3bd39(winning_team, var_c1e98979) {
  if(level.var_23b92e65 === 1) {
    return;
  }

  level.var_23b92e65 = 1;
  assert(isDefined(winning_team));

  if(function_8b4fc766(var_c1e98979)) {
    globallogic_score::giveteamscoreforobjective_delaypostprocessing(winning_team, 1);
  }

  round::set_winner(winning_team);
  thread end_round(var_c1e98979);
}

function_61e80d63() {
  if(level.teambased) {
    function_a3e3bd39(game.defenders, 2);
    return;
  }

  end_round(2);
}

function_543ac649() {
  if(level.teambased) {
    round::set_winner(game.defenders);
  }

  end_round(2);
}

function_692f2157() {
  if(isalive(self)) {
    self.deathtime = 0;
    self.pers[#"deathtime"] = 0;
  }
}

end_round(var_c1e98979) {
  if(sessionmodeismultiplayergame() && var_c1e98979 === 6) {
    if(isDefined(level.roundending) && level.roundending) {
      return;
    }

    level.roundending = 1;

    if(!isDefined(level.var_a5c930dd)) {
      level.var_a5c930dd = 0;
    }

    if(!isDefined(level.var_697b1d55)) {
      level.var_697b1d55 = 0;
    }

    do {
      waitframe(1);
      endtime = gettime() - 2 * float(function_60d95f53()) / 1000;
    }
    while(level.lastslowprocessframe > endtime || level.var_a5c930dd > endtime || level.var_697b1d55 > endtime);
  }

  if(gamestate::is_game_over() || level.gameended) {
    return;
  }

  player::function_2f80d95b(&function_692f2157);
  function_d8d30361(var_c1e98979);
  level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", 0);

  if(isDefined(level.onendround)) {
    [[level.onendround]](var_c1e98979);
  }

  outcome = hud_message::function_a2f30ab4(1, var_c1e98979, 0, round::function_f37f02fc());
  function_4720c07f(outcome);
  overtime::function_f435f4dd();
  display_transition::display_round_end(outcome);

  if(!function_d89bf8aa()) {
    beacon_cp_biodomes_server_room_top_floor_door_rumble();
  }
}

private function_f30cfedb() {
  if(util::isoneround()) {
    var_c1e98979 = round::function_3624d032();
  } else {
    var_c1e98979 = function_b0a2785c();
  }

  match::function_897438f4(var_c1e98979);
}

private function_3526a519() {
  var_e61d6eb0 = [];

  foreach(vehicle in level.var_8819644a) {
    if(!isDefined(vehicle)) {
      continue;
    }

    data = {
      #pos_x: vehicle.origin[0], 
      #pos_y: vehicle.origin[1], 
      #pos_z: vehicle.origin[2], 
      #type: vehicle.vehicletype, 
      #used: isDefined(vehicle.used) && vehicle.used
    };

    if(!isDefined(var_e61d6eb0)) {
      var_e61d6eb0 = [];
    } else if(!isarray(var_e61d6eb0)) {
      var_e61d6eb0 = array(var_e61d6eb0);
    }

    var_e61d6eb0[var_e61d6eb0.size] = data;

    if(var_e61d6eb0.size >= 100) {
      function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
      var_e61d6eb0 = [];
      wait 0.1;
    }
  }

  if(var_e61d6eb0.size > 0) {
    function_92d1707f(#"hash_55f923de6ff3632b", #"entries", var_e61d6eb0);
  }
}

private function_e4335431() {
  var_726f6c6 = [];

  foreach(stash in level.item_spawn_stashes) {
    state = function_ffdbe8c2(stash);
    data = {
      #pos_x: stash.origin[0], 
      #pos_y: stash.origin[1], 
      #pos_z: stash.origin[2], 
      #type: stash.var_15d44120, 
      #used: state != 0, 
      #state: state, 
      #var_a7feba9c: isDefined(stash.var_80b1d504) ? stash.var_80b1d504 : 0, 
      #var_fa0ba6bc: isDefined(stash.lootlocker) && stash.lootlocker
    };

    if(!isDefined(var_726f6c6)) {
      var_726f6c6 = [];
    } else if(!isarray(var_726f6c6)) {
      var_726f6c6 = array(var_726f6c6);
    }

    var_726f6c6[var_726f6c6.size] = data;

    if(var_726f6c6.size >= 100) {
      function_92d1707f(#"hash_7cd6488eb92cb736", #"entries", var_726f6c6);
      var_726f6c6 = [];
      wait 0.1;
    }
  }

  if(var_726f6c6.size > 0) {
    function_92d1707f(#"hash_7cd6488eb92cb736", #"entries", var_726f6c6);
  }
}

private function_159d7b6f() {
  itemcount = function_8322cf16();
  summary = [];
  var_69cbb8c = [];

  for(i = 0; i < itemcount; i++) {
    if(i % 100 == 0) {
      wait 0.1;
    }

    item = function_b1702735(i);

    if(!isDefined(summary[item.targetname])) {
      summary[item.targetname] = {};
    }

    if(isDefined(item.itementry)) {
      if(!isDefined(summary[item.targetname].itemtypes)) {
        summary[item.targetname].itemtypes = [];
      }

      if(!isDefined(summary[item.targetname].itemtypes[item.itementry.itemtype])) {
        summary[item.targetname].itemtypes[item.itementry.itemtype] = {};
      }

      if(!isDefined(summary[item.targetname].itemtypes[item.itementry.itemtype].items)) {
        summary[item.targetname].itemtypes[item.itementry.itemtype].items = [];
      }

      if(!isDefined(summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name])) {
        summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name] = {};
      }

      if(!isDefined(summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].count)) {
        summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].count = 0;
      }

      summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].count += 1;
      summary[item.targetname].itemtypes[item.itementry.itemtype].items[item.itementry.name].rarity = hash(item.itementry.rarity);
    } else {
      if(!isDefined(var_69cbb8c[item.targetname])) {
        var_69cbb8c[item.targetname] = {};
      }

      if(!isDefined(var_69cbb8c[item.targetname].count)) {
        var_69cbb8c[item.targetname].count = 0;
      }

      var_69cbb8c[item.targetname].count += 1;
    }
  }

  wait 0.1;
  item_data = [];

  foreach(location_name, location in summary) {
    if(isDefined(location.itemtypes)) {
      foreach(category_name, category in location.itemtypes) {
        if(isDefined(category.items)) {
          foreach(item_name, item in category.items) {
            data = {
              #location: location_name, 
              #category: category_name, 
              #item: item_name, 
              #rarity: item.rarity, 
              #count: item.count
            };

            if(!isDefined(item_data)) {
              item_data = [];
            } else if(!isarray(item_data)) {
              item_data = array(item_data);
            }

            item_data[item_data.size] = data;

            if(item_data.size >= 100) {
              var_cae7fe15 = {
                #seed: level.item_spawn_seed, 
                #event_count: item_data.size
              };
              function_92d1707f(#"hash_67dcbe8b30edd15a", #"summary", var_cae7fe15, #"entries", item_data);
              item_data = [];
              wait 0.1;
            }
          }
        }
      }
    }
  }

  if(item_data.size > 0) {
    var_cae7fe15 = {
      #seed: level.item_spawn_seed, 
      #event_count: item_data.size
    };
    function_92d1707f(#"hash_67dcbe8b30edd15a", #"summary", var_cae7fe15, #"entries", item_data);
  }
}

private function_2506a4ec() {
  function_3526a519();
  wait 0.1;
  function_e4335431();
  wait 0.1;
  function_159d7b6f();
  wait 0.1;
}

private function_6a4a86() {
  result = function_e8cd6051();
  recordgameresult(result);
  player::function_2f80d95b(&player_record::function_96d38b95, result);
  player::function_2f80d95b(&player_record::record_misc_player_stats);
  skillupdate();

  if(sessionmodeiswarzonegame()) {
    thread function_2506a4ec();
  }

  winner = match::get_winner();
  thread challenges::gameend(winner);
  function_9022da4e();
}

private function_5ae24200() {
  self setclientuivisibilityflag("hud_visible", 0);
  self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

private function_a18a9342() {
  setmatchtalkflag("EveryoneHearsEveryone", 1);
  setmatchflag("cg_drawSpectatorMessages", 0);
  util::setclientsysstate("levelNotify", "streamFKsl");
  player::function_2f80d95b(&function_5ae24200);
}

private function_ac30613c() {
  return hud_message::function_a2f30ab4(1, match::function_3624d032(), 1, match::function_f37f02fc());
}

private function_bd1e54e7(outcome) {
  stopdemorecording();
  function_a50a4f61(outcome);
}

private player_end_game() {
  self thread[[level.spawnintermission]](0, level.usexcamsforendgame);
  self setclientuivisibilityflag("hud_visible", 1);
}

private function_f6928798() {
  level.intermission = 1;
  level notify(#"endgame_intermission");
  player::function_2f80d95b(&player_end_game);
  level clientfield::set("post_game", 1);
}

getplayerbyname(name) {
  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];

    if(isbot(player)) {
      continue;
    }

    if(player.name == name) {
      return player;
    }
  }
}

function_4e7d44bd() {
  foreach(team, _ in level.teams) {
    if(level.everexisted[team]) {
      teamranking = isDefined(level.var_eed7c027[team]) ? level.var_eed7c027[team] : 1;
      players = getplayers(team);

      foreach(player in players) {
        player luinotifyevent(#"team_eliminated", 1, teamranking);
      }
    }
  }
}

function_9c14ee08() {
  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];

    if(isbot(player)) {
      continue;
    }

    playerclientnum = player getentitynumber();
    enemyindex = 0;

    for(j = 0; j < level.players.size; j++) {
      if(index == j) {
        continue;
      }

      notplayer = level.players[j];

      if(util::function_fbce7263(player.team, notplayer.team)) {
        var_13947986 = notplayer getentitynumber();
        killed = notplayer.pers[#"killed_by"][player.name];
        killedby = notplayer.pers[#"killed_players"][player.name];

        if(!isDefined(killed)) {
          killed = 0;
        }

        if(!isDefined(killedby)) {
          killedby = 0;
        }

        player luinotifyevent(#"hash_9ab42b593c66ed", 5, playerclientnum, enemyindex, var_13947986, killed, killedby);
        enemyindex++;
      }
    }
  }
}

function_4636deca(player) {
  if(isbot(player)) {
    return;
  }

  player player_record::function_7569c0fb();
  nemesis = player.pers[#"nemesis_name"];
  assert(isDefined(nemesis), "<dev string:x3e>" + player.name);
  assert(isstring(nemesis), "<dev string:x61>" + nemesis + "<dev string:x6c>" + player.name);

  if(!isDefined(player.pers[#"killed_players"][nemesis])) {
    player.pers[#"killed_players"][nemesis] = 0;
  }

  if(!isDefined(player.pers[#"killed_by"][nemesis])) {
    player.pers[#"killed_by"][nemesis] = 0;
  }

  spread = player.kills - player.deaths;

  if(player.pers[#"cur_kill_streak"] > player.pers[#"best_kill_streak"]) {
    player.pers[#"best_kill_streak"] = player.pers[#"cur_kill_streak"];
  }

  if(level.rankedmatch || level.leaguematch) {
    player stats::function_7a850245(#"privatematch", 0);
  } else {
    player stats::function_7a850245(#"privatematch", 1);
  }

  player setnemesisxuid(player.pers[#"nemesis_xuid"]);
  player stats::function_7a850245(#"valid", 1);
  player stats::function_7a850245(#"nemesisname", nemesis);
  player stats::function_7a850245(#"nemesisrank", player.pers[#"nemesis_rank"]);
  player stats::function_7a850245(#"nemesisrankicon", player.pers[#"nemesis_rankicon"]);
  player stats::function_7a850245(#"nemesiskills", player.pers[#"killed_players"][nemesis]);
  player stats::function_7a850245(#"nemesiskilledby", player.pers[#"killed_by"][nemesis]);
  nemesisplayerent = getplayerbyname(nemesis);

  if(isDefined(nemesisplayerent)) {
    player stats::function_7a850245(#"nemesisheroindex", nemesisplayerent getcharacterbodytype());
  }

  clientnum = player getentitynumber();
  player stats::function_7a850245(#"clientnum", clientnum);
  characterindex = player getcharacterbodytype();
  player stats::function_7a850245(#"characterindex", characterindex);
  player stats::function_7a850245(#"gametype", level.var_12323003);
}

sendafteractionreport() {

  if(getdvarint(#"scr_writeconfigstrings", 0) == 1) {
    return;
  }

    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];
      function_4636deca(player);
    }
}

private function_5c159ad3() {
  util::preload_frontend();
  gamerep::gamerepanalyzeandreport();
  thread function_4e7d44bd();
  wait 1;

  if(!sessionmodeiswarzonegame()) {
    thread sendafteractionreport();
  }

  thread function_9c14ee08();
}

function_9a022fbc(str_state) {
  players = getplayers();
  var_7e05b6e9 = [];

  foreach(player in players) {
    if(isbot(player) || player issplitscreen()) {
      array::add(var_7e05b6e9, player);
    }
  }

  foreach(bot in var_7e05b6e9) {
    arrayremovevalue(players, bot);
  }

  foreach(player in players) {
    lui_menu = lui::get_luimenu("FullScreenBlack");

    if(str_state == "open") {
      if(isDefined(lui_menu)) {
        [
          [lui_menu]
        ] - > open(player);
        [
          [lui_menu]
        ] - > set_startalpha(player, 1);
        [
          [lui_menu]
        ] - > set_endalpha(player, 1);
        [
          [lui_menu]
        ] - > set_fadeovertime(player, int(2000));
      }

      continue;
    }

    if(isDefined(lui_menu)) {
      [
        [lui_menu]
      ] - > close(player);
    }
  }
}

private beacon_cp_biodomes_server_room_top_floor_door_rumble() {
  function_f30cfedb();
  hvo::function_323c6715();
  [[level.onendgame]](match::function_3624d032());
  globallogic_score::updatewinlossstats();

  if(level.arenamatch) {
    arena::match_end();
  }

  function_6a4a86();
  function_a18a9342();
  outcome = function_ac30613c();

  if(util::function_8570168d()) {
    level notify(#"result", {
      #outcome: outcome
    });
  }

  level notify(#"give_match_bonus");
  thread function_5c159ad3();

  if(!isDefined(level.skipgameend) || !level.skipgameend) {
    display_transition::function_19adc0b7(outcome);
  }

  if(util::function_8570168d()) {
    level notify(#"hash_5562cfc90ce9dfe2");
  }

  function_bd1e54e7(outcome);

  if(util::isoneround() && !display_transition::function_81d670f5()) {
    globallogic_utils::executepostroundevents();
  }

  function_f6928798();
  level notify(#"sfade");
  updateandfinalizematchrecord();

  if(util::function_8570168d() && isDefined(level.b_movie) && level.b_movie) {
    level waittill(#"movie_done");
  }

  if(isDefined(level.end_game_video)) {
    function_9a022fbc("open");
    level thread lui::play_movie(level.end_game_video, "fullscreen", 1, 0, 0, #"", level.var_48ea0e8c);
    level waittill(#"movie_done");
  }

  level callback::callback(#"on_game_shutdown");
  exit_level();
}

exit_level() {
  if(level.exitlevel) {
    return;
  }

  level.exitlevel = 1;
  exitlevel(0);
}

gettotaltimeplayed(maxlength) {
  totaltimeplayed = 0;

  if(isDefined(self.pers[#"totaltimeplayed"])) {
    totaltimeplayed = self.pers[#"totaltimeplayed"];

    if(totaltimeplayed > maxlength) {
      totaltimeplayed = maxlength;
    }
  }

  return totaltimeplayed;
}

getroundtimeplayed(roundlength) {
  totaltimeplayed = 0;

  if(isDefined(self.timeplayed) && isDefined(self.timeplayed[#"total"])) {
    totaltimeplayed = self.timeplayed[#"total"];

    if(totaltimeplayed > roundlength) {
      totaltimeplayed = roundlength;
    }
  }

  return totaltimeplayed;
}

bbplayermatchend(gamelength, var_c1e98979, gameover) {
  if(!sessionmodeismultiplayergame() || !isDefined(self.pers)) {
    return;
  }

  playerrank = getplacementforplayer(self);
  totaltimeplayed = self getroundtimeplayed(gamelength);
  xuid = int(self getxuid(1));
  mpplayermatchfacts = {
    #score: self.pers[#"score"], 
    #momentum: self.pers[#"momentum"], 
    #endreason: var_c1e98979, 
    #sessionrank: playerrank, 
    #playtime: int(totaltimeplayed), 
    #xuid: xuid, 
    #gameover: gameover, 
    #team: self.team, 
    #specialist: self getspecialistindex()
  };
  function_92d1707f(#"hash_7c173cd9201d5271", mpplayermatchfacts);
}

roundenddof() {
  self clientfield::set_to_player("player_dof_settings", 2);
}

checktimelimit() {
  if(isDefined(level.timelimitoverride) && level.timelimitoverride) {
    return;
  }

  if(gamestate::is_game_over()) {
    setgameendtime(0);
    return;
  }

  if(level.timelimit <= 0) {
    setgameendtime(0);
    return;
  }

  if(isDefined(level.timerpaused) && level.timerpaused) {
    timeremaining = globallogic_utils::gettimeremaining();
    setgameendtime(int(timeremaining) * -1);
    return;
  }

  if(isDefined(level.timerstopped) && level.timerstopped) {
    setgameendtime(0);
    return;
  }

  if(!isDefined(level.starttime)) {
    return;
  }

  timeleft = globallogic_utils::gettimeremaining();
  setgameendtime(gettime() + int(timeleft));

  if(timeleft > 0) {
    return;
  }

  [[level.ontimelimit]]();
}

checkscorelimit() {
  if(game.state != "playing") {
    return 0;
  }

  if(level.scorelimit <= 0) {
    return 0;
  }

  if(level.teambased) {
    if(!util::any_team_hit_score_limit()) {
      return 0;
    }
  } else {
    if(!isplayer(self)) {
      return 0;
    }

    if(self.pointstowin < level.scorelimit) {
      return 0;
    }
  }

  [[level.onscorelimit]]();
}

checksuddendeathscorelimit(team) {
  if(game.state != "playing") {
    return 0;
  }

  if(level.roundscorelimit <= 0) {
    return 0;
  }

  if(level.teambased) {
    if(!game.teamsuddendeath[team]) {
      return 0;
    }
  } else {
    return 0;
  }

  [[level.onscorelimit]]();
}

checkroundscorelimit() {
  if(game.state != "playing") {
    return 0;
  }

  if(level.roundscorelimit <= 0) {
    return 0;
  }

  if(level.teambased) {
    if(!util::any_team_hit_round_score_limit()) {
      return 0;
    }
  } else {
    if(!isplayer(self)) {
      return 0;
    }

    roundscorelimit = util::get_current_round_score_limit();

    if(self.pointstowin < roundscorelimit) {
      return 0;
    }
  }

  [[level.onroundscorelimit]]();
}

updategametypedvars() {
  level endon(#"game_ended");

  while(!gamestate::is_game_over()) {
    roundlimit = math::clamp(getgametypesetting(#"roundlimit"), level.roundlimitmin, level.roundlimitmax);

    if(roundlimit != level.roundlimit) {
      level.roundlimit = roundlimit;
    }

    timelimit = [[level.gettimelimit]]();

    if(timelimit != level.timelimit) {
      level.timelimit = timelimit;
    }

    thread checktimelimit();
    scorelimit = math::clamp(getgametypesetting(#"scorelimit"), level.scorelimitmin, level.scorelimitmax);

    if(scorelimit != level.scorelimit) {
      level.scorelimit = scorelimit;
    }

    thread checkscorelimit();
    roundscorelimit = math::clamp(getgametypesetting(#"roundscorelimit"), level.roundscorelimitmin, level.roundscorelimitmax);

    if(roundscorelimit != level.roundscorelimit) {
      level.roundscorelimit = roundscorelimit;
    }

    thread checkroundscorelimit();

    if(isDefined(level.starttime)) {
      if(globallogic_utils::gettimeremaining() < 30000) {
        wait 0.1;
        continue;
      }
    }

    wait 0.25;
  }
}

removedisconnectedplayerfromplacement() {
  if(gamestate::is_shutting_down()) {
    return;
  }

  offset = 0;
  numplayers = level.placement[#"all"].size;
  found = 0;

  for(i = 0; i < numplayers; i++) {
    if(level.placement[#"all"][i] == self) {
      found = 1;
    }

    if(found) {
      level.placement[#"all"][i] = level.placement[#"all"][i + 1];
    }
  }

  if(!found) {
    return;
  }

  level.placement[#"all"][numplayers - 1] = undefined;
  assert(level.placement[#"all"].size == numplayers - 1);

  globallogic_utils::assertproperplacement();

    updateteamplacement();

  if(level.teambased) {
    return;
  }

  numplayers = level.placement[#"all"].size;

  for(i = 0; i < numplayers; i++) {
    player = level.placement[#"all"][i];
    player notify(#"update_outcome");
  }
}

updateplacement() {
  if(!level.players.size) {
    return;
  }

  level.placement[#"all"] = [];

  foreach(player in level.players) {
    if(!level.teambased || isDefined(level.teams[player.team])) {
      level.placement[#"all"][level.placement[#"all"].size] = player;
    }
  }

  placementall = level.placement[#"all"];

  if(level.teambased) {
    for(i = 1; i < placementall.size; i++) {
      player = placementall[i];
      playerscore = player.score;

      for(j = i - 1; j >= 0 && (playerscore > placementall[j].score || playerscore == placementall[j].score && player.deaths < placementall[j].deaths); j--) {
        placementall[j + 1] = placementall[j];
      }

      placementall[j + 1] = player;
    }
  } else {
    for(i = 1; i < placementall.size; i++) {
      player = placementall[i];
      playerscore = player.pointstowin;

      for(j = i - 1; j >= 0 && (playerscore > placementall[j].pointstowin || playerscore == placementall[j].pointstowin && player.deaths < placementall[j].deaths || playerscore == placementall[j].pointstowin && player.deaths == placementall[j].deaths && player.lastkilltime > placementall[j].lastkilltime); j--) {
        placementall[j + 1] = placementall[j];
      }

      placementall[j + 1] = player;
    }
  }

  level.placement[#"all"] = placementall;

  globallogic_utils::assertproperplacement();

    updateteamplacement();
}

updateteamplacement() {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(level.placement[#"all"])) {
    return;
  }

  foreach(team, _ in level.teams) {
    placement[team] = [];
  }

  placement[#"spectator"] = [];
  placementall = level.placement[#"all"];
  placementallsize = placementall.size;

  for(i = 0; i < placementallsize; i++) {
    player = placementall[i];

    if(!isDefined(player)) {
      continue;
    }

    team = player.pers[#"team"];
    placement[team][placement[team].size] = player;
  }

  foreach(team, _ in level.teams) {
    level.placement[team] = placement[team];
  }
}

getplacementforplayer(player) {
  updateplacement();
  playerrank = -1;
  placement = level.placement[#"all"];

  for(placementindex = 0; placementindex < placement.size; placementindex++) {
    if(level.placement[#"all"][placementindex] == player) {
      playerrank = placementindex + 1;
      break;
    }
  }

  return playerrank;
}

istopscoringplayer(player) {
  topscoringplayer = 0;
  updateplacement();
  assert(level.placement[#"all"].size > 0);

  if(level.placement[#"all"].size == 0) {
    return 0;
  }

  if(level.teambased) {
    topscore = level.placement[#"all"][0].score;

    foreach(place in level.placement[#"all"]) {
      if(place.score == 0) {
        break;
      }

      if(topscore > place.score) {
        break;
      }

      if(player == place) {
        topscoringplayer = 1;
        break;
      }
    }
  } else {
    topscore = level.placement[#"all"][0].pointstowin;

    foreach(place in level.placement[#"all"]) {
      if(place.pointstowin == 0) {
        break;
      }

      if(topscore > place.pointstowin) {
        break;
      }

      if(player == place) {
        topscoringplayer = 1;
        break;
      }
    }
  }

  return topscoringplayer;
}

sortdeadplayers(team) {
  if(!level.playerqueuedrespawn) {
    return;
  }

  for(i = 1; i < level.deadplayers[team].size; i++) {
    player = level.deadplayers[team][i];

    for(j = i - 1; j >= 0 && player.deathtime < level.deadplayers[team][j].deathtime; j--) {
      level.deadplayers[team][j + 1] = level.deadplayers[team][j];
    }

    level.deadplayers[team][j + 1] = player;
  }

  for(i = 0; i < level.deadplayers[team].size; i++) {
    if(level.deadplayers[team][i].spawnqueueindex != i) {
      level.spawnqueuemodified[team] = 1;
    }

    level.deadplayers[team][i].spawnqueueindex = i;
  }
}

totalalivecount() {
  count = 0;

  foreach(team, _ in level.teams) {
    count += level.alivecount[team];
  }

  return count;
}

totalplayerlives() {
  count = 0;

  foreach(team, _ in level.teams) {
    count += level.playerlives[team];
  }

  return count;
}

function_e9e52d05() {
  count = 0;

  foreach(team, _ in level.teams) {
    if(level.alivecount[team]) {
      count++;
    }
  }

  return count;
}

initteamvariables(team) {
  if(!isDefined(level.alivecount)) {
    level.alivecount = [];
  }

  if(!isDefined(level.laststandcount)) {
    level.laststandcount = [];
  }

  level.alivecount[team] = 0;
  level.lastalivecount[team] = 0;

  if(!isDefined(level.var_f97a6ba3)) {
    level.var_f97a6ba3 = 0;
  }

  if(!isDefined(level.var_4ad4bec3)) {
    level.var_4ad4bec3 = 0;
  }

  if(!isDefined(game.everexisted)) {
    game.everexisted = [];
  }

  if(!isDefined(game.everexisted[team])) {
    game.everexisted[team] = 0;
  }

  if(!isDefined(level.var_eed7c027)) {
    level.var_eed7c027 = [];
  }

  level.teameliminated[team] = 0;
  level.everexisted[team] = 0;
  level.wavedelay[team] = 0;
  level.lastwave[team] = 0;
  level.waveplayerspawnindex[team] = 0;
  level.var_4ad4bec3 = 0;
  resetteamvariables(team);
}

resetteamvariables(team) {
  level.playercount[team] = 0;
  level.botscount[team] = 0;
  level.lastalivecount[team] = level.alivecount[team];
  level.alivecount[team] = 0;
  level.playerlives[team] = 0;
  level.laststandcount[team] = 0;
  level.aliveplayers[team] = [];
  level.spawningplayers[team] = [];
  level.deadplayers[team] = [];
  level.spawnqueuemodified[team] = 0;
}

updateteamstatus() {
  level notify(#"updating_team_status");
  level endon(#"updating_team_status", #"game_ended");
  waittillframeend();
  wait 0;

  if(gamestate::is_game_over()) {
    return;
  }

  resettimeout();

  foreach(team, _ in level.teams) {
    resetteamvariables(team);
  }

  if(!level.teambased) {
    resetteamvariables("free");
  }

  level.activeplayers = [];
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player) && level.splitscreen) {
      continue;
    }

    if(level.teambased || player.team == #"spectator") {
      team = player.team;
    } else {
      team = "free";
    }

    playerclass = player.curclass;

    if(team != #"spectator" && (isDefined(playerclass) && playerclass != "" || !loadout::function_87bcb1b())) {
      level.playercount[team]++;

      if(isbot(player)) {
        level.botscount[team]++;
      }

      not_quite_dead = 0;

      if(isDefined(player.overrideplayerdeadstatus)) {
        not_quite_dead = player[[player.overrideplayerdeadstatus]]();
      }

      if(player.sessionstate == "playing") {
        level.alivecount[team]++;
        level.playerlives[team]++;
        player.spawnqueueindex = -1;

        if(isalive(player)) {
          level.aliveplayers[team][level.aliveplayers[team].size] = player;
          level.activeplayers[level.activeplayers.size] = player;

          if(isDefined(player.laststand) && player.laststand) {
            level.laststandcount[team]++;
          }
        } else {
          level.deadplayers[team][level.deadplayers[team].size] = player;
        }

        continue;
      }

      if(not_quite_dead) {
        level.alivecount[team]++;
        level.playerlives[team]++;
        level.aliveplayers[team][level.aliveplayers[team].size] = player;
        continue;
      }

      level.deadplayers[team][level.deadplayers[team].size] = player;
    }
  }

  foreach(team, _ in level.deadplayers) {
    foreach(player in level.deadplayers[team]) {
      if(player globallogic_spawn::mayspawn()) {
        level.playerlives[team]++;
      }
    }

    sortdeadplayers(team);
  }

  totalalive = totalalivecount();

  if(totalalive > level.maxplayercount) {
    level.maxplayercount = totalalive;
  }

  teams::function_596bfb16();
  platoons::function_596bfb16();
  callback::callback(#"hash_6b7d26d34885b425", {});
}

updatealivetimes(team) {
  level.alivetimesaverage[team] = 0;

  if(gamestate::is_game_over()) {
    return;
  }

  total_player_count = 0;
  average_player_spawn_time = 0;
  total_value_count = 0;

  foreach(player in level.aliveplayers[team]) {
    average_time = 0;
    count = 0;

    if(!isDefined(player)) {
      continue;
    }

    if(isDefined(player.alivetimes)) {
      foreach(time in player.alivetimes) {
        if(!isDefined(time)) {
          continue;
        }

        if(time != 0) {
          average_time += time;
          count++;
        }
      }
    }

    if(count) {
      total_value_count += count;
      average_player_spawn_time += average_time / count;
      total_player_count++;
    }
  }

  foreach(player in level.deadplayers[team]) {
    if(!isDefined(player)) {
      continue;
    }

    average_time = 0;
    count = 0;

    if(isDefined(player.alivetimes)) {
      foreach(time in player.alivetimes) {
        if(!isDefined(time)) {
          continue;
        }

        if(time != 0) {
          average_time += time;
          count++;
        }
      }
    }

    if(count) {
      total_value_count += count;
      average_player_spawn_time += average_time / count;
      total_player_count++;
    }
  }

  if(total_player_count == 0 || total_value_count < 3) {
    level.alivetimesaverage[team] = 0;
    return;
  }

  level.alivetimesaverage[team] = average_player_spawn_time / total_player_count;

  if(getdvarint(#"hash_7d48f244ba0d0b2d", 0)) {
    iprintln("<dev string:x8b>" + level.alivetimesaverage[#"allies"] + "<dev string:xa3>" + level.alivetimesaverage[#"axis"]);
  }

}

updateallalivetimes() {
  foreach(team, _ in level.teams) {
    updatealivetimes(team);
  }
}

checkteamscorelimitsoon(team) {
  assert(isDefined(team));

  if(level.scorelimit <= 0) {
    return;
  }

  if(!level.teambased) {
    return;
  }

  if(globallogic_utils::gettimepassed() < int(60 * 1000)) {
    return;
  }

  timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(team);

  if(timeleft < 1) {
    level notify(#"match_ending_soon", {
      #event: "score"
    });
  }
}

checkplayerscorelimitsoon() {
  assert(isplayer(self));

  if(level.scorelimit <= 0) {
    return;
  }

  if(level.teambased) {
    return;
  }

  if(globallogic_utils::gettimepassed() < int(60 * 1000)) {
    return;
  }

  timeleft = globallogic_utils::getestimatedtimeuntilscorelimit(undefined);

  if(timeleft < 1) {
    level notify(#"match_ending_soon", {
      #event: "score"
    });
  }
}

timelimitclock() {
  level endon(#"game_ended");
  waitframe(1);
  clockobject = spawn("script_origin", (0, 0, 0));

  while(!gamestate::is_game_over()) {
    using_tickets_as_time = level.timelimit == 0 && isDefined(level.low_tickets_enabled) && isDefined(level.get_tickets_as_time);

    if(!level.timerstopped && (level.timelimit || level.low_ticket_count === 1)) {
      if(using_tickets_as_time) {
        timeleftint = [
          [level.get_tickets_as_time]
        ]();
      } else {
        timeleft = float(globallogic_utils::gettimeremaining()) / 1000;
        timeleftint = int(timeleft + 0.5);
      }

      if(timeleftint == 601) {
        util::clientnotify("notify_10");
      }

      if(timeleftint == 301) {
        util::clientnotify("notify_5");
      }

      if(timeleftint == 60) {
        util::clientnotify("notify_1");
      }

      if(timeleftint == 12) {
        util::clientnotify("notify_count");
      }

      if(timeleftint >= 40 && timeleftint <= 60) {
        level notify(#"match_ending_soon", "time");
      }

      if(timeleftint >= 30 && timeleftint <= 40) {
        level notify(#"match_ending_pretty_soon", "time");
      }

      if(timeleftint <= 32) {
        level notify(#"match_ending_vox");
      }

      if(timeleftint <= 10 || timeleftint <= 30 && timeleftint % 2 == 0 || level.low_ticket_count === 1 && timeleftint % 2 == 0 || level.very_low_ticket_count === 1) {
        level notify(#"match_ending_very_soon", "time");

        if(timeleftint == 0) {
          break;
        }

        clockobject playSound(#"mpl_ui_timer_countdown");
      }

      if(!using_tickets_as_time) {
        if(timeleftint <= 5) {
          wait 0.5;
          continue;
        } else if(timeleft - floor(timeleft) >= 0.05) {
          wait timeleft - floor(timeleft);
        }
      }
    }

    if(using_tickets_as_time && !level.timerstopped) {
      timeleftint = [
        [level.get_tickets_as_time]
      ]();

      if(timeleftint <= 0) {
        wait 1;
      } else {
        oldtimeleftint = timeleftint;

        while(!level.timerstopped && oldtimeleftint == timeleftint && timeleftint > 0) {
          waitframe(1);
          timeleftint = [
            [level.get_tickets_as_time]
          ]();
        }
      }

      continue;
    }

    wait 1;
  }
}

timelimitclock_intermission(waittime) {
  setgameendtime(gettime() + int(waittime * 1000));
  clockobject = spawn("script_origin", (0, 0, 0));

  if(waittime >= 10) {
    wait waittime - 10;
  }

  for(;;) {
    clockobject playSound(#"mpl_ui_timer_countdown");
    wait 1;
  }
}

private set_game_playing() {
  level notify(#"game_playing");
  gamestate::set_state("playing");
  level callback::callback(#"on_game_playing");

  if(level.var_6aec2d48 > 0) {
    thread function_b4262bec();
  }

  level clientfield::set("gameplay_started", 1);
  players = getplayers();
  totalplayers = 0;

  foreach(player in players) {
    if(isalive(player)) {
      totalplayers++;
    }
  }

  function_5fad41b5();

  if(isDefined(level.var_7dc1df3a) && isDefined(level.var_7dc1df3a.duration)) {
    var_bc9cd862 = level.var_7dc1df3a.duration;
    var_2c5afb5e = isDefined(level.var_7dc1df3a.var_e2382b29) ? level.var_7dc1df3a.var_e2382b29 : 0;
    var_b3418d40 = isDefined(level.var_7dc1df3a.var_7be962bb) ? level.var_7dc1df3a.var_7be962bb : 0;
    var_84dc46fb = isDefined(level.var_7dc1df3a.var_7d960258) ? level.var_7dc1df3a.var_7d960258 : 0;
    var_47f5b811 = isDefined(level.var_7dc1df3a.var_a104a7da) ? level.var_7dc1df3a.var_a104a7da : 0;
  } else {
    var_bc9cd862 = 0;
    var_2c5afb5e = 0;
    var_b3418d40 = 0;
    var_84dc46fb = 0;
    var_47f5b811 = 0;
  }

  data = {
    #var_ea8aaaef: var_bc9cd862, 
    #var_962b073b: var_2c5afb5e, 
    #var_be2fca42: var_b3418d40, 
    #var_f0956407: var_84dc46fb, 
    #var_cac41566: var_47f5b811, 
    #var_31942899: gettime(), 
    #player_count: totalplayers
  };
  function_92d1707f(#"hash_24f510499c464072", data);
  match_record::set_stat(#"hash_5288d149bac65a79", gettime());
}

private function_b4262bec() {
  level endon(#"game_ended");
  level.friendlyfire = level.var_78d89cdd;
  level.var_40eaa459 = 1;
  wait level.var_6aec2d48;
  level.friendlyfire = level.var_a65e8e93;
  level.var_40eaa459 = 0;
}

function_edb0e0f0() {
  if(util::isroundbased()) {
    if(util::getroundsplayed() == 0) {
      recordmatchbegin();
    }

    matchrecordroundstart();

    if(overtime::is_overtime_round()) {
      matchrecordovertimeround();
    }

    return;
  }

  recordmatchbegin();
}

startgame() {
  callback::on_game_playing(&globallogic_utils::gametimer);
  level.timerstopped = 0;
  level.playabletimerstopped = 0;
  gamestate::set_state("pregame");
  function_8111babb();

  if(isDefined(level.custom_prematch_period)) {
    [[level.custom_prematch_period]]();
  } else {
    prematchperiod();
  }

  if(!gamestate::is_state("pregame")) {
    return;
  }

  set_game_playing();

  rat::function_7d22c1c9();

    thread showobjectivenotificationuiforallplayers(undefined, 0);
  thread timelimitclock();
  thread graceperiod();
  thread watchmatchendingsoon();
  thread globallogic_audio::announcercontroller();
  thread globallogic_audio::sndmusicfunctions();
  function_edb0e0f0();
}

isprematchrequirementconditionmet(activeteamcount) {
  if(level.prematchrequirement == 0) {
    return true;
  }

  if(level.teambased) {
    if(activeteamcount.size <= 1) {
      return false;
    }

    foreach(teamcount in activeteamcount) {
      if(teamcount != level.prematchrequirement) {
        return false;
      }
    }
  } else if(activeteamcount[#"free"] != level.prematchrequirement) {
    return false;
  }

  return true;
}

waitforplayers() {
  level endon(#"game_ended");
  starttime = gettime();
  playerready = 0;
  activeplayercount = 0;
  accepttestclient = 0;
  activeteamcount = [];
  player_ready = [];

  while(!playerready || activeplayercount == 0 || !isprematchrequirementconditionmet(activeteamcount)) {
    activeplayercount = 0;

    if(level.teambased) {
      foreach(team, _ in level.teams) {
        activeteamcount[team] = 0;
      }
    } else {
      activeteamcount[#"free"] = 0;
    }

    temp_player_ready = [];

    foreach(player in level.players) {
      if(player istestclient() && accepttestclient == 0) {
        continue;
      }

      if(player.team != #"spectator") {
        activeplayercount++;
        player_num = player getentitynumber();

        if(isDefined(player_ready[player_num])) {
          temp_player_ready[player_num] = player_ready[player_num];
        } else {
          temp_player_ready[player_num] = gettime();
        }

        if(temp_player_ready[player_num] + 5000 < gettime() || player isstreamerready(-1, 1)) {
          if(level.teambased) {
            activeteamcount[player.team]++;
          } else {
            activeteamcount[#"free"]++;
          }
        }
      }

      if(player isstreamerready(-1, 1)) {
        if(playerready == 0) {
          level notify(#"first_player_ready", {
            #player: player
          });
        }

        playerready = 1;
      }
    }

    player_read = temp_player_ready;
    waitframe(1);

    if(gettime() - starttime > int(20 * 1000)) {
      if(level.rankedmatch == 0 && level.arenamatch == 0) {
        accepttestclient = 1;
      }
    }

    if(level.rankedmatch && gettime() - starttime > int(120 * 1000)) {
      exit_level();

      while(true) {
        wait 10;
      }
    }
  }
}

prematchwaitingforplayers() {
  if(level.prematchrequirement != 0) {
    level waittill(#"first_player_ready");
    luinotifyevent(#"prematch_waiting_for_players");
  }
}

prematchperiod() {
  setmatchflag("hud_hardcore", level.hardcoremode);
  level endon(#"game_ended");
  globallogic_audio::sndmusicsetrandomizer();

  if(draft::is_draft_this_round()) {
    level thread draft::start();
    level waittill(#"draft_complete");

    if(isDefined(level.var_f3e25805)) {
      level thread[[level.var_f3e25805]]();
    }

    function_654d64ea();
    return;
  }

  if(isDefined(level.var_f3e25805)) {
    level thread[[level.var_f3e25805]]();
  }

  if(isDefined(level.var_86513cd0)) {
    [[level.var_86513cd0]]();
  }

  thread matchstarttimer();

  if(level.prematchperiod > 0) {
    thread prematchwaitingforplayers();
    waitforplayers();
    wait level.prematchperiod;
  } else {
    matchstarttimerskip();
    waitframe(1);
  }

  level.inprematchperiod = 0;
  level thread sndsetmatchsnapshot(0);

  foreach(player in level.players) {
    player val::reset(#"spawn_player", "freezecontrols");
    player val::reset(#"spawn_player", "disablegadgets");
    player enableweapons();
    player callback::callback(#"prematch_end");
  }

  level callback::callback(#"prematch_end");
}

graceperiod() {
  level endon(#"game_ended");

  if(isDefined(level.graceperiodfunc)) {
    [[level.graceperiodfunc]]();
  } else {
    wait level.graceperiod;
  }

  level notify(#"grace_period_ending");
  waitframe(1);
  level.ingraceperiod = 0;

  if(gamestate::is_game_over()) {
    return;
  }

  if(level.numlives) {
    players = level.players;

    for(i = 0; i < players.size; i++) {
      player = players[i];

      if(!player.hasspawned && player.sessionteam != #"spectator" && !isalive(player)) {
        player.statusicon = "hud_status_dead";
      }
    }
  }

  level thread updateteamstatus();
  level thread updateallalivetimes();
}

watchmatchendingsoon() {
  setdvar(#"xblive_matchendingsoon", 0);
  level waittill(#"match_ending_soon");
  setdvar(#"xblive_matchendingsoon", 1);
}

anyteamhaswavedelay() {
  foreach(team, _ in level.teams) {
    if(level.wavedelay[team]) {
      return true;
    }
  }

  return false;
}

setteamlivesuimodels() {
  waitframe(1);

  if(level.numteamlives > 0) {
    allieslivescount = 0;
    axislivescount = 0;

    if(isDefined(game.lives)) {
      allieslivescount = level.numteamlives;
      axislivescount = level.numteamlives;
    }

    clientfield::set_world_uimodel("hudItems.team1.livesCount", allieslivescount);
    clientfield::set_world_uimodel("hudItems.team2.livesCount", axislivescount);
  }
}

function_8af3b312() {
  if(isDefined(level.var_cdb8ae2c)) {
    [[level.var_cdb8ae2c]]();
  }

  influencers::create_map_placed_influencers();
  globallogic_spawn::addspawns();
}

on_game_playing() {
  wavedelay = level.waverespawndelay;

  if(wavedelay) {
    level thread[[level.wavespawntimer]]();
  }
}

function_b9b7618() {
  level.prematchrequirement = 0;
  level.prematchperiod = 0;
  level.intermission = 0;
  setmatchflag("cg_drawSpectatorMessages", 1);
  setmatchflag("game_ended", 0);

  if(!isDefined(game.gamestarted)) {
    assert(isDefined(game.attackers) && isDefined(game.defenders));
    assert(game.attackers != game.defenders);

    if(!isDefined(game.state)) {
      game.state = "pregame";
    }

    gamestate::set_state(game.state);
    game.strings[#"press_to_spawn"] = #"hash_203ff65a4ee460e6";

    if(level.teambased) {
      game.strings[#"waiting_for_teams"] = #"mp/waiting_for_teams";
      game.strings[#"opponent_forfeiting_in"] = #"mp/opponent_forfeiting_in";
    } else {
      game.strings[#"waiting_for_teams"] = #"mp/waiting_for_players";
      game.strings[#"opponent_forfeiting_in"] = #"mp/opponent_forfeiting_in";
    }

    game.strings[#"match_starting_in"] = #"hash_18e58cc95db34427";
    game.strings[#"spawn_next_round"] = #"mp/spawn_next_round";
    game.strings[#"waiting_to_spawn"] = #"mp/waiting_to_spawn";
    game.strings[#"waiting_to_spawn_ss"] = #"hash_78bf3a61cf52e257";
    game.strings[#"you_will_spawn"] = #"hash_53c0ba6abce1c0ea";
    game.strings[#"match_starting"] = #"mp/match_starting";
    game.strings[#"change_class"] = #"mp/change_class_next_spawn";
    game.strings[#"item_on_respawn"] = #"hash_220160808c99fe71";
    game.strings[#"hash_b71875e85956ea"] = #"hash_61f8bf2959b7bd5a";
    game.strings[#"last_stand"] = #"hash_5732d212e4511a00";
    game.strings[#"cowards_way"] = #"hash_268e464278a2f8ff";
    [[level.onprecachegametype]]();
    game.gamestarted = 1;
    game.totalkills = 0;

    foreach(team, _ in level.teams) {
      if(!isDefined(game.migratedhost)) {
        game.stat[#"teamscores"][team] = 0;
      }

      game.teamsuddendeath[team] = 0;
      game.totalkillsteam[team] = 0;
    }

    level.prematchrequirement = getgametypesetting(#"prematchrequirement");
    level.prematchperiod = getgametypesetting(#"prematchperiod");

    prematchperiodoverride = getdvarint(#"prematchperiodoverride", -1);

    if(prematchperiodoverride >= 0) {
      level.prematchperiod = prematchperiodoverride;
    }

  } else {
    if(!level.splitscreen) {
      level.prematchperiod = getgametypesetting(#"preroundperiod");
    }

    preroundperiodoverride = getdvarint(#"preroundperiodoverride", -1);

    if(preroundperiodoverride >= 0) {
      level.prematchperiod = preroundperiodoverride;
    }

  }

  if(!isDefined(game.timepassed)) {
    game.timepassed = 0;
  }

  if(!isDefined(game.playabletimepassed)) {
    game.playabletimepassed = 0;
  }

  round::round_stats_init();
  level.skipvote = 0;
  level.gameended = 0;
  level.exitlevel = 0;
  setdvar(#"g_gameended", 0);
  level.objidstart = 0;
  level.forcedend = 0;
  level.hostforcedend = 0;
  level.hardcoremode = getgametypesetting(#"hardcoremode");

  if(level.hardcoremode) {

    print("<dev string:xad>");

      if(!isDefined(level.friendlyfiredelaytime)) {
        level.friendlyfiredelaytime = 0;
      }
  }

  level.rankcap = getdvarint(#"scr_max_rank", 0);
  level.minprestige = getdvarint(#"scr_min_prestige", 0);
  level.usestartspawns = 1;
  level.alwaysusestartspawns = 0;
  level.usexcamsforendgame = 0;
  level.cumulativeroundscores = getgametypesetting(#"cumulativeroundscores");
  level.playerqueuedrespawn = getgametypesetting(#"playerqueuedrespawn");
  level.playerforcerespawn = getgametypesetting(#"playerforcerespawn");
  level.roundstartexplosivedelay = getgametypesetting(#"roundstartexplosivedelay");
  level.roundstartkillstreakdelay = getgametypesetting(#"roundstartkillstreakdelay");
  level.perksenabled = getgametypesetting(#"perksenabled");
  level.disableattachments = getgametypesetting(#"disableattachments");
  level.disabletacinsert = getgametypesetting(#"disabletacinsert");
  level.disablecac = getgametypesetting(#"disablecac");
  level.disableclassselection = getgametypesetting(#"disableclassselection");

  if(!isDefined(level.disableweapondrop)) {
    level.disableweapondrop = getgametypesetting(#"disableweapondrop");
  }

  level.teamkillreducedpenalty = getgametypesetting(#"teamkillreducedpenalty");
  level.teamkillpointloss = getgametypesetting(#"teamkillpointloss");
  level.teamkillspawndelay = getgametypesetting(#"teamkillspawndelay");
  level.deathpointloss = getgametypesetting(#"deathpointloss");
  level.leaderbonus = getgametypesetting(#"leaderbonus");
  level.forceradar = getgametypesetting(#"forceradar");
  level.playersprinttime = getgametypesetting(#"playersprinttime");
  level.bulletdamagescalar = getgametypesetting(#"bulletdamagescalar");
  level.playermaxhealth = getgametypesetting(#"playermaxhealth");
  level.playerhealthregentime = getgametypesetting(#"playerhealthregentime");

  if(sessionmodeismultiplayergame()) {
    level.var_90bb9821 = getgametypesetting(#"specialistmaxhealth_allies_1") - 150;
    level.minimumallowedteamkills = getgametypesetting(#"specialistteamkillsallowed_allies_1") - 1;
    level.onlyheadshots = getgametypesetting(#"specialistonlyheadshots_allies_1");
    level.allowhitmarkers = getgametypesetting(#"hash_7477eea36687a960");
  } else {
    level.var_90bb9821 = getgametypesetting(#"playermaxhealth") - 150;
    level.minimumallowedteamkills = getgametypesetting(#"teamkillpunishcount") - 1;
    level.onlyheadshots = getgametypesetting(#"onlyheadshots");
    level.allowhitmarkers = getgametypesetting(#"allowhitmarkers");
  }

  level.scoreresetondeath = getgametypesetting(#"scoreresetondeath");
  level.ekiaresetondeath = getgametypesetting(#"ekiaresetondeath");
  level.var_c77de7d6 = getgametypesetting(#"hash_32da91b78e54e7b5");
  level.playerrespawndelay = getgametypesetting(#"playerrespawndelay");
  level.playerincrementalrespawndelay = getgametypesetting(#"incrementalspawndelay");
  level.playerobjectiveheldrespawndelay = getgametypesetting(#"playerobjectiveheldrespawndelay");
  level.waverespawndelay = getgametypesetting(#"waverespawndelay");
  level.suicidespawndelay = getgametypesetting(#"spawnsuicidepenalty");
  level.teamkilledspawndelay = getgametypesetting(#"spawnteamkilledpenalty");
  level.maxsuicidesbeforekick = getgametypesetting(#"maxsuicidesbeforekick");
  level.spectatetype = getgametypesetting(#"spectatetype");
  level.voip = spawnStruct();
  level.voip.deadchatwithdead = getgametypesetting(#"voipdeadchatwithdead");
  level.voip.deadchatwithteam = getgametypesetting(#"voipdeadchatwithteam");
  level.voip.deadhearallliving = getgametypesetting(#"voipdeadhearallliving");
  level.voip.deadhearteamliving = getgametypesetting(#"voipdeadhearteamliving");
  level.voip.everyonehearseveryone = getgametypesetting(#"voipeveryonehearseveryone");
  level.voip.deadhearkiller = getgametypesetting(#"voipdeadhearkiller");
  level.voip.killershearvictim = getgametypesetting(#"voipkillershearvictim");
  level.voip.partychat = getgametypesetting(#"hash_33bc6781006ae83d");
  level.droppedtagrespawn = getgametypesetting(#"droppedtagrespawn");
  setdvar(#"g_allowlaststandforactiveclients", getgametypesetting(#"allowlaststandforactiveclients"));

  if(isDefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
    dogtags::init();
  }

  gameobjects::main();

  foreach(team, _ in level.teams) {
    initteamvariables(team);
  }

  if(!level.teambased) {
    initteamvariables("free");
  }

  level.maxplayercount = 0;
  level.activeplayers = [];
  level.alivetimemaxcount = 3;
  level.alivetimesaverage = [];
  level.var_a236b703 = [];
  level.var_61952d8b = [];
  level.deaths = [];

  foreach(team, _ in level.teams) {
    level.alivetimesaverage[team] = 0;
    level.var_a236b703[team] = 0;
    level.var_61952d8b[team] = 0;
    level.deaths[team] = 0;
  }

  if(!isDefined(level.livesdonotreset) || !level.livesdonotreset) {
    if(level.teambased) {
      foreach(team, _ in level.teams) {
        game.lives[team] = level.numteamlives;
      }

      level thread setteamlivesuimodels();
    } else {
      foreach(team, _ in level.teams) {
        game.lives[team] = 0;
      }
    }
  }

  level.allowannouncer = getgametypesetting(#"allowannouncer");

  if(!isDefined(level.timelimit)) {
    util::registertimelimit(1, 1440);
  }

  if(!isDefined(level.scorelimit)) {
    util::registerscorelimit(1, 500);
  }

  if(!isDefined(level.roundscorelimit)) {
    util::registerroundscorelimit(0, 500);
  }

  if(!isDefined(level.roundlimit)) {
    util::registerroundlimit(0, 10);
  }

  if(!isDefined(level.roundwinlimit)) {
    util::registerroundwinlimit(0, 10);
  }

  if(!display_transition::function_81d670f5()) {
    globallogic_utils::registerpostroundevent(&killcam::function_a26057ee);
    globallogic_utils::registerpostroundevent(&potm::post_round_potm);
  }

  wavedelay = level.waverespawndelay;

  if(wavedelay) {
    foreach(team, _ in level.teams) {
      level.wavedelay[team] = wavedelay;
      level.lastwave[team] = 0;
    }
  }

  level.inprematchperiod = 1;

  if(level.prematchperiod > 2 && level.rankedmatch) {
    level.prematchperiod += randomfloat(4) - 2;
  }

  if(level.numlives || anyteamhaswavedelay() || level.playerqueuedrespawn) {
    level.graceperiod = 15;
  } else {
    level.graceperiod = 5;
  }

  level.ingraceperiod = 1;
  level.roundenddelay[0] = 3.5;
  level.roundenddelay[1] = 1.5;
  level.roundenddelay[2] = 1.5;
  level.roundenddelay[3] = 7;
  level.roundenddelay[4] = 2;
  globallogic_score::updateallteamscores();
  level.killstreaksenabled = 1;
  level.missilelockplayspacecheckenabled = 1;
  level.missilelockplayspacecheckextraradius = 18000;

  if(getdvarstring(#"scr_game_rankenabled") == "") {
    setdvar(#"scr_game_rankenabled", 1);
  }

  level.rankenabled = getdvarint(#"scr_game_rankenabled", 0);

  if(getdvarstring(#"scr_game_medalsenabled") == "") {
    setdvar(#"scr_game_medalsenabled", 1);
  }

  level.medalsenabled = getdvarint(#"scr_game_medalsenabled", 0);

  if(level.hardcoremode && level.rankedmatch && getdvarstring(#"scr_game_friendlyfiredelay") == "") {
    setdvar(#"scr_game_friendlyfiredelay", 1);
  }

  level.friendlyfiredelay = getdvarint(#"scr_game_friendlyfiredelay", 0);
  setclientnamemode("auto_change");

  if(getdvarint(#"custom_killstreak_mode", 0) == 1) {
    level.killstreaksenabled = 0;
  }

  level.var_aa5e6547 = strendswith(isDefined(level.gametype) ? level.gametype : "", "_cwl");

  if(level.var_aa5e6547) {
    var_1141ae61 = getdvarfloat(#"hash_5349c39a9c2a9357", 1e-06);

    if(var_1141ae61 > 0) {
      var_480ff6af = var_1141ae61 <= 1e-06 ? 0 : var_1141ae61;
      setgametypesetting("scoreHeroPowerTimeFactor", var_480ff6af);
    }
  }

  setdebugsideswitch(game.switchedsides);

}

callback_startgametype() {
  function_b9b7618();
  [[level.var_6c4ec3fc]]();
  gametype::on_start_game_type();
  callback::callback(#"on_start_gametype");
  [[level.onstartgametype]]();
  level thread function_54b079aa();
  level thread killcam::do_final_killcam();
  level thread updategametypedvars();
  thread startgame();
  level thread simple_hostmigration::updatehostmigrationdata();

  if(!(isDefined(level.var_f16f6c66) && level.var_f16f6c66)) {
    level thread radar_sweeps::radarsweeps();
  }

  if(getdvarint(#"scr_writeconfigstrings", 0) == 1) {
    level.skipgameend = 1;
    level.roundlimit = 1;
    wait 1;
    thread forceend(0);
  }

  if(getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    thread forcedebughostmigration();
  }

}

function_54b079aa() {
  waittillframeend();

  while(game.state != "playing") {
    waitframe(1);
  }

  specialistswitchislethal = 1;

  if(isDefined(level.var_324e2795) && level.var_324e2795) {
    specialistswitchislethal = 0;
  }

  level clientfield::set_world_uimodel("hudItems.specialistSwitchIsLethal", specialistswitchislethal);
}

forcedebughostmigration() {
  while(true) {
    hostmigration::waittillhostmigrationdone();
    wait 60;
    starthostmigration();
    hostmigration::waittillhostmigrationdone();
  }
}

  function registerfriendlyfiredelay(dvarstring, defaultvalue, minvalue, maxvalue) {
    dvarstring = "scr_" + dvarstring + "_friendlyFireDelayTime";

    if(getdvarstring(dvarstring) == "") {
      setdvar(dvarstring, defaultvalue);
    }

    if(getdvarint(dvarstring, 0) > maxvalue) {
      setdvar(dvarstring, maxvalue);
    } else if(getdvarint(dvarstring, 0) < minvalue) {
      setdvar(dvarstring, minvalue);
    }

    level.friendlyfiredelaytime = getdvarint(dvarstring, 0);
  }

listenforgameend() {
  self endon(#"disconnect");
  self waittill(#"host_sucks_end_game");
  level.skipvote = 1;

  if(!level.gameended) {
    level thread forceend(1);
  }
}

getkillstreaks(player) {
  for(killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
    killstreak[killstreaknum] = "killstreak_null";
  }

  if(isplayer(player) && level.disableclassselection != 1 && !isbot(player) && isDefined(player.killstreak)) {
    currentkillstreak = 0;

    for(killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
      if(isDefined(player.killstreak[killstreaknum])) {
        killstreak[currentkillstreak] = player.killstreak[killstreaknum];
        currentkillstreak++;
      }
    }
  }

  return killstreak;
}

updaterankedmatch(outcome) {
  if(level.rankedmatch) {
    if(hostidledout()) {
      level.hostforcedend = 1;

      print("<dev string:xc3>");

    }
  }

  globallogic_score::updatematchbonusscores(outcome);
}

annihilatorgunplayerkilleffect(attacker, weapon, smeansofdeath) {
  if(smeansofdeath == "MOD_IMPACT") {
    wait weapon.fusetime / 1000;
  } else if(weapon.fusetime != 0) {
    wait 0.1;
  } else {
    wait 0.45;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(attacker)) {
    self playsoundtoplayer(#"evt_annihilation_plr", attacker);
    self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
  }

  codesetclientfield(self, "annihilate_effect", 1);
  earthquake(0.3, 0.75, self.origin, 500);
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }

  self notsolid();
  self ghost();
}

annihilatorgunactorkilleffect(attacker, weapon) {
  waitresult = self waittill(#"actor_corpse");
  body = waitresult.corpse;

  if(weapon.fusetime != 0) {
    wait weapon.fusetime * 0.001;
  } else {
    wait 0.45;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(attacker)) {
    self playsoundtoplayer(#"evt_annihilation_plr", attacker);
    self playsoundtoallbutplayer(#"evt_annihilation_npc", attacker);
  }

  if(!isDefined(body)) {
    return;
  }

  codesetclientfield(body, "annihilate_effect", 1);
  body shake_and_rumble(0, 0.6, 0.2, 1);
  body notsolid();
  body ghost();
}

pineapplegunplayerkilleffect(attacker) {
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }

  playsoundatposition(#"evt_annihilation_npc", self.origin);
  codesetclientfield(self, "pineapplegun_effect", 1);
  self shake_and_rumble(0, 0.3, 0.35, 1);
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }

  self notsolid();
  self ghost();
}

bowplayerkilleffect() {
  waitframe(1);

  if(!isDefined(self)) {
    return;
  }

  playsoundatposition(#"evt_annihilation_npc", self.origin);
  codesetclientfield(self, "annihilate_effect", 1);
  self shake_and_rumble(0, 0.3, 0.35, 1);

  if(!isDefined(self)) {
    return;
  }

  self notsolid();
  self ghost();
}

pineapplegunactorkilleffect() {
  waitresult = self waittill(#"actor_corpse");
  body = waitresult.corpse;
  wait 0.75;

  if(!isDefined(self)) {
    return;
  }

  playsoundatposition(#"evt_annihilation_npc", self.origin);

  if(!isDefined(body)) {
    return;
  }

  codesetclientfield(body, "pineapplegun_effect", 1);
  body shake_and_rumble(0, 0.3, 0.75, 1);
  body notsolid();
  body ghost();
}

shake_and_rumble(n_delay, shake_size, shake_time, rumble_num) {
  if(isDefined(n_delay) && n_delay > 0) {
    wait n_delay;
  }

  nmagnitude = shake_size;
  nduration = shake_time;
  nradius = 500;
  v_pos = self.origin;
  earthquake(nmagnitude, nduration, v_pos, nradius);

  for(i = 0; i < rumble_num; i++) {
    self playrumbleonentity("damage_heavy");
    wait 0.1;
  }
}

doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(weapon.name == "hero_pineapplegun" && isplayer(attacker) && smeansofdeath == "MOD_GRENADE") {
    attacker playlocalsound(#"wpn_pineapple_grenade_explode_flesh_2d");
  }
}

function_e050e788(weapon, attacker, einflictor, smeansofdeath) {
  if(!weapon.doannihilate) {
    return false;
  }

  if(randomfloat(1) > weapon.var_36c76157) {
    return false;
  }

  if(!isplayer(attacker)) {
    return false;
  }

  if(smeansofdeath != "MOD_IMPACT" && smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_PROJECTILE" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_MELEE") {
    return false;
  }

  if(smeansofdeath == "MOD_IMPACT" && weapon.var_6262fd11) {
    return false;
  }

  if((smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH") && !(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self)) {
    return false;
  }

  return true;
}

doweaponspecificcorpseeffects(body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  if(!isDefined(weapon)) {
    return;
  }

  if(function_e050e788(weapon, attacker, einflictor, smeansofdeath)) {
    if(isactor(body)) {
      body thread annihilatorgunactorkilleffect(attacker, weapon);
    } else {
      body thread annihilatorgunplayerkilleffect(attacker, weapon, smeansofdeath);
    }

    return;
  }

  if(smeansofdeath == "MOD_BURNED" || smeansofdeath == "MOD_DOT" && weapon.doesfiredamage) {
    if(!isactor(body)) {
      body thread burncorpse();
    }

    return;
  }

  if(weapon.isheavyweapon && isplayer(attacker)) {
    if(weapon.name == #"hero_firefly_swarm") {
      value = randomint(2) + 1;

      if(!isactor(body)) {
        codesetclientfield(body, "firefly_effect", value);
      }
    }
  }
}

burncorpse() {
  self endon(#"death");
  codesetclientfield(self, "burned_effect", 1);
  wait 6;
  codesetclientfield(self, "burned_effect", 0);
}

function_991daa12(weapon) {
  if(weaponhasattachment(weapon, "ir")) {
    self clientfield::set_to_player("thermal_sight", 1);
  }

  if(weaponhasattachment(weapon, "uber") && weapon.rootweapon == getweapon(#"shotgun_semiauto_t8")) {
    self thread function_a4156fb2();
  }
}

function_ec7cf015(weapon) {
  if(weaponhasattachment(weapon, "ir")) {
    self clientfield::set_to_player("thermal_sight", 0);
  }

  if(weaponhasattachment(weapon, "uber") && weapon.rootweapon == getweapon(#"shotgun_semiauto_t8")) {
    function_b761e219();
  }
}

function_fdb8b430(player) {
  if(!isalive(player) || player.sessionstate != "playing") {
    return false;
  }

  if(!player util::isenemyteam(self.team)) {
    return false;
  }

  distsq = distancesquared(self.origin, player.origin);

  if(distsq > level.stroberange * level.stroberange) {
    return false;
  }

  if(!util::within_fov(self.origin, self.angles, player.origin, level.strobefov)) {
    return false;
  }

  if(!util::within_fov(player.origin, player getplayerangles(), self.origin, level.strobefov)) {
    return false;
  }

  return true;
}

function_a4156fb2() {
  self notify("52ea5c232e4bcf");
  self endon("52ea5c232e4bcf");
  self endon(#"strobe_off", #"death");
  level.stroberange = getdvarint(#"strobe_range", 500);
  level.strobefov = cos(getdvarint(#"strobe_fov", 45));

  while(true) {
    enemyplayers = getplayers("all", self.origin, level.stroberange * 2);

    foreach(player in enemyplayers) {
      if(self function_fdb8b430(player)) {
        if(!(isDefined(player.strobed) && player.strobed)) {
          player clientfield::set_to_player("strobe_light", 1);
          player.strobed = 1;
        }

        continue;
      }

      if(isDefined(player.strobed) && player.strobed) {
        player clientfield::set_to_player("strobe_light", 0);
        player.strobed = 0;
      }
    }

    waitframe(1);
  }
}

function_b761e219() {
  self notify(#"strobe_off");
  enemyplayers = getplayers();

  foreach(player in enemyplayers) {
    if(!player util::isenemyteam(self.team)) {
      continue;
    }

    if(isDefined(player.strobed) && player.strobed) {
      player clientfield::set_to_player("strobe_light", 0);
      player.strobed = 0;
    }
  }
}