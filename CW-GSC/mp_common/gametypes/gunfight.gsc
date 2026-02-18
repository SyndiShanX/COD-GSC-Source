/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\gunfight.gsc
***********************************************/

#using script_1435f3c9fc699e04;
#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\abilities\ability_util;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\math_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\callbacks;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\perks;
#using scripts\mp_common\player\player_loadout;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace gunfight;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  setDvar(#"hash_6974ec4bbf3b9e97", int(20 * 1000));
  level.usingextratime = 0;
  level.extratime = getgametypesetting(#"extratime");
  level.var_4348a050 = 1;
  level.capturetime = getgametypesetting(#"capturetime");
  level.gunfightroundsperloadout = getgametypesetting(#"gunfightroundsperloadout");
  level.gunfightspyplane = getgametypesetting(#"gunfightspyplane");
  level.var_60507c71 = 1;
  level.takelivesondeath = 1;
  level.var_f5a73a96 = 1;
  level.var_e7b05b51 = 0;
  level.onstartgametype = &onstartgametype;
  level.givecustomloadout = &givecustomloadout;
  level.onendround = &onendround;
  level.ononeleftevent = &ononeleftevent;
  level.ondeadevent = &ondeadevent;
  level.ontimelimit = &ontimelimit;
  level.gettimelimit = &gettimelimit;
  level.var_a8b23f5a = 1;
  level.var_3a701785 = 1;
  level.var_a4947666 = &function_dd683ab8;
  level.var_6561b05c = &function_21471f74;
  level.var_70cd9e95 = 1;
  level.var_1cc83170 = 10;
  level.var_537d4629 = 5;
  level.var_807b9ff6 = -1;
  clientfield::register("world", "activeTrigger", 1, 1, "int");
  clientfield::register("scriptmover", "scriptid", 1, 1, "int");
  clientfield::register("allplayers", "gunfight_pregame_rob", 9000, 1, "int");
  callback::on_game_playing(&ongameplaying);
  callback::on_connect(&onconnect);
  callback::on_spawned(&onspawned);
  callback::function_c11071a8(&function_86513cd0);
  player::function_cf3aa03d(&onplayerkilled);
  callback::on_disconnect(&ondisconnect);
  spawning::addsupportedspawnpointtype("tdm");
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);

  if(!isDefined(game.var_96a8ff4a)) {
    bundle_index = isDefined(getgametypesetting(#"hash_3b05ecbff72f1065")) ? getgametypesetting(#"hash_3b05ecbff72f1065") : 0;
    var_92d79c8a = getscriptbundle("gunfightloadoutlist");
    bundle_name = isDefined(var_92d79c8a.var_d6f55369[bundle_index].loadout) ? var_92d79c8a.var_d6f55369[bundle_index].loadout : "mp_gunfight_loadout_default";
    var_cbf8cb48 = getscriptbundle(bundle_name);
    assert(isDefined(var_cbf8cb48));
    game.var_96a8ff4a = array::randomize(var_cbf8cb48.defaultloadouts);
    game.var_b6beb735 = 0;
  }
}

function onstartgametype() {
  level.graceperiod = 3;
  level.alwaysusestartspawns = 1;

  if(level.disablecustomcac !== 1) {
    setgametypesetting(#"disableclassselection", 0);
    level.disableclassselection = 0;
    setgametypesetting(#"perksenabled", 1);
    level.perksenabled = 1;
    level.givecustomloadout = undefined;
  }

  if(level.gunfightspyplane === 1) {
    foreach(team, _ in level.teams) {
      setteamspyplane(team, 1);
    }
  }

  if(!setupzones()) {
    return;
  }

  if(!util::isfirstround()) {
    music::setmusicstate("gunfight_roundstart");
  }

  function_8cac4c76();

  foreach(team, _ in level.teams) {
    level.var_a236b703[team] = 1;
    level.var_61952d8b[team] = 1;
  }

  luinotifyevent(#"round_start");

  self thread function_a481300e();

  if(level.tournamentmatch === 1) {
    function_d33c99f8();
  }
}

function private function_8cac4c76() {
  waitframe(1);
  clientfield::set_world_uimodel("hudItems.team1.noRespawnsLeft", 1);
  clientfield::set_world_uimodel("hudItems.team2.noRespawnsLeft", 1);
}

function private function_d33c99f8() {
  timeremaining = undefined;
  var_6b21cef = undefined;

  if(game.state == # "pregame") {
    if(isDefined(level.var_fd167bf6)) {
      timeremaining = float(max(0, level.var_fd167bf6 - gettime())) / 1000;
    } else {
      timeremaining = level.prematchperiod;
    }

    var_6b21cef = 2;
  } else if(game.state == # "playing") {
    timeremaining = float(max(0, globallogic_utils::gettimeremaining())) / 1000;
    var_6b21cef = level.var_31f5f23 === 1 ? 1 : 0;
  } else if(game.state == # "postgame") {
    timeremaining = 0;
    var_6b21cef = 3;
  }

  if(isDefined(timeremaining) && isDefined(var_6b21cef)) {
    currentround = (isDefined(game.roundsplayed) ? game.roundsplayed : 0) + 1;
    function_a4b196f3(int(timeremaining), currentround, var_6b21cef);
  }
}

function ongameplaying() {
  level.var_7928392e = 1;

  if(util::isfirstround()) {
    music::setmusicstate("gunfight_firstspawn");
  }

  foreach(zone in level.zones) {
    if(isDefined(zone.gameobject) && isDefined(zone.gameobject.objectiveid)) {
      zone.gameobject gameobjects::set_visible(#"group_none");
      zone.gameobject gameobjects::set_model_visibility(0, 1);
    }
  }

  foreach(player in getplayers()) {
    player clientfield::set("gunfight_pregame_rob", 0);
  }

  if(level.tournamentmatch === 1) {
    function_d33c99f8();
  }
}

function givecustomloadout() {
  setloadout(game.var_96a8ff4a[game.var_b6beb735]);
  self thread function_1f551f49();
}

function function_86513cd0() {
  if(level.disablecustomcac === 1) {
    foreach(player in level.players) {
      if(player.team == # "spectator") {
        player function_1f551f49();
      }
    }
  }
}

function private function_1f551f49() {
  self endon(#"disconnect");
  var_838bcdf8 = isDefined(game.var_96a8ff4a[game.var_b6beb735].primary) ? getitemindexfromref(game.var_96a8ff4a[game.var_b6beb735].primary) : -1;
  var_91a71f65 = isDefined(game.var_96a8ff4a[game.var_b6beb735].secondary) ? getitemindexfromref(game.var_96a8ff4a[game.var_b6beb735].secondary) : -1;
  var_26b5c8ef = isDefined(game.var_96a8ff4a[game.var_b6beb735].var_26b5c8ef) ? game.var_96a8ff4a[game.var_b6beb735].var_26b5c8ef : -1;
  var_4c0d0c4b = isDefined(game.var_96a8ff4a[game.var_b6beb735].var_4c0d0c4b) ? game.var_96a8ff4a[game.var_b6beb735].var_4c0d0c4b : -1;
  var_fe58c446 = isDefined(game.var_96a8ff4a[game.var_b6beb735].secondarygrenade) ? getitemindexfromref(game.var_96a8ff4a[game.var_b6beb735].secondarygrenade) : -1;
  var_312d49ec = isDefined(game.var_96a8ff4a[game.var_b6beb735].primarygrenade) ? getitemindexfromref(game.var_96a8ff4a[game.var_b6beb735].primarygrenade) : -1;

  while(util::isfirstround() && !level flag::get(#"hud_initialized") || isDefined(self) && self clientfield::get_player_uimodel("closeLoadingMovie") == 0) {
    wait 0.1;
  }

  if(isDefined(self)) {
    self luinotifyevent(#"hash_76e8cddd9789122c", 6, var_838bcdf8, var_26b5c8ef + 1, var_91a71f65, var_4c0d0c4b + 1, var_fe58c446, var_312d49ec);
  }
}

function onconnect() {
  if(util::isfirstround()) {
    if(game.state != # "playing") {
      music::setmusicstate("gunfight_preloop", self);
    }
  }

  self function_770b76d3();
}

function onspawned() {
  if(game.state == # "pregame") {
    self clientfield::set("gunfight_pregame_rob", 1);
    return;
  }

  self clientfield::set("gunfight_pregame_rob", 0);
}

function function_dd683ab8(outcome) {
  music::setmusicstate("matchend_win_02");
}

function function_21471f74() {
  music::setmusicstate("gunfight_roundend");
}

function setloadout(loadout) {
  self takeallweapons();
  self clearperks();
  self cleartalents();
  self function_44244433(loadout);
  self loadout::function_6573eeeb();
  self setperk(#"specialty_sprint");
  self setperk(#"specialty_slide");
  self setperk(#"specialty_sprintreload");
  self setperk(#"specialty_sprintheal");
}

function ondeadevent(team) {
  if(level.var_c7cce1ff === 1) {
    return;
  }

  losingteam = team;
  winningteam = losingteam == game.attackers ? game.defenders : game.attackers;
  thread function_3e53e79d(winningteam, losingteam);
  globallogic::function_a3e3bd39(winningteam, 6);
  level.var_c7cce1ff = 1;
}

function onendround(var_c1e98979) {
  globallogic_score::function_9779ac61();

  if(level.tournamentmatch === 1) {
    alliesscore = isDefined(game.stat[# "teamscores"][# "allies"]) ? game.stat[# "teamscores"][# "allies"] : 0;
    axisscore = isDefined(game.stat[# "teamscores"][# "axis"]) ? game.stat[# "teamscores"][# "axis"] : 0;
    function_b091e7c0(0, alliesscore);
    function_b091e7c0(1, axisscore);
    function_d33c99f8();
  }

  if(isDefined(level.gunfightroundsperloadout) && level.gunfightroundsperloadout !== 0 && (util::getroundsplayed() + 1) % level.gunfightroundsperloadout == 0) {
    game.var_b6beb735++;

    if(game.var_b6beb735 >= game.var_96a8ff4a.size) {
      game.var_b6beb735 = 0;
    }

    gametype::on_round_switch();
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isPlayer(deathanimduration) && deathanimduration.pers[# "team"] != self.pers[# "team"]) {
    deathanimduration.var_9b890e79 = (isDefined(deathanimduration.var_9b890e79) ? deathanimduration.var_9b890e79 : 0) + 1;
  }

  if(isDefined(self.team)) {
    level.var_12491923[self.team] = (isDefined(level.var_12491923[self.team]) ? level.var_12491923[self.team] : 0) + 1;
  }

  function_8f5272b2(self);
}

function ondisconnect() {
  if(game.state === # "playing" && isalive(self)) {
    function_8f5272b2(self);
  }
}

function private function_8f5272b2(player) {
  if(isDefined(player.team)) {
    globallogic_audio::play_2d_on_team(#"hash_7f0c9c0ec4410623", player.team);
    otherteam = util::getotherteam(player.team);

    if(isDefined(otherteam) && otherteam != player.team) {
      globallogic_audio::play_2d_on_team(#"hash_14b3ab2971ce1112", otherteam);
    }
  }
}

function ononeleftevent(team) {
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

    if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == team && isDefined(player.pers[# "class"])) {
      if(player.sessionstate == "playing" && !player.afk) {
        break;
      }
    }
  }

  if(i == players.size) {
    return;
  }

  player = players[i];
  player thread globallogic_audio::leader_dialog_on_player("roundEncourageLastPlayer", "roundEncourageLastPlayer");
}

function function_d98e2783(loadout, loadoutslot) {
  if(!isDefined(loadout)) {
    return;
  }

  if(loadoutslot === "primary") {
    loadoutweapon = loadout.primary;
    var_b805cfb3 = isDefined(loadout.var_26b5c8ef) ? loadout.var_26b5c8ef : 0;
    loadoutattachments = loadout.primaryattachments;
  } else if(loadoutslot === "secondary") {
    loadoutweapon = loadout.secondary;
    var_b805cfb3 = isDefined(loadout.var_4c0d0c4b) ? loadout.var_4c0d0c4b : 0;
    loadoutattachments = loadout.secondaryattachments;
  }

  if(isDefined(loadoutweapon)) {
    if(!isDefined(var_b805cfb3)) {
      var_b805cfb3 = 0;
    }

    if(isDefined(var_b805cfb3) && var_b805cfb3 > -1) {
      var_b805cfb3++;
      var_c4af33 = function_f62a996b(loadoutweapon, var_b805cfb3);
      weapon = var_c4af33.weapon;
      var_e91aba42 = var_c4af33.var_fd90b0bb;
    } else {
      weaponattachments = function_8fdeea14(loadoutattachments);

      if(array::contains(weaponattachments, #"dw")) {
        loadoutweapon += "_dw";
        arrayremovevalue(weaponattachments, #"dw");
      }

      weapon = getweapon(loadoutweapon, weaponattachments);
    }
  }

  weapon_struct = {};
  weapon_struct.weapon = weapon;
  weapon_struct.var_f879230e = var_e91aba42;
  return weapon_struct;
}

function function_770b76d3() {
  if(!isDefined(self)) {
    return;
  }

  var_f20ec141 = game.var_b6beb735;

  if(var_f20ec141 >= game.var_96a8ff4a.size) {
    var_f20ec141 = 0;
  }

  currentloadout = game.var_96a8ff4a[var_f20ec141];
  nextloadoutindex = var_f20ec141 + 1;

  if(nextloadoutindex >= game.var_96a8ff4a.size) {
    nextloadoutindex = 0;
  }

  nextloadout = game.var_96a8ff4a[nextloadoutindex];
  primaryweaponstruct = function_d98e2783(currentloadout, "primary");

  if(isDefined(primaryweaponstruct.weapon)) {
    self giveweapon(primaryweaponstruct.weapon, undefined, primaryweaponstruct.var_f879230e);
  }

  secondaryweaponstruct = function_d98e2783(currentloadout, "secondary");

  if(isDefined(secondaryweaponstruct.weapon)) {
    self giveweapon(secondaryweaponstruct.weapon, undefined, secondaryweaponstruct.var_f879230e);
  }

  var_9d60c468 = function_d98e2783(nextloadout, "primary");

  if(isDefined(var_9d60c468.weapon)) {
    self giveweapon(var_9d60c468.weapon, undefined, var_9d60c468.var_f879230e);
  }

  var_41083d50 = function_d98e2783(nextloadout, "secondary");

  if(isDefined(var_41083d50.weapon)) {
    self giveweapon(var_41083d50.weapon, undefined, var_41083d50.var_f879230e);
  }
}

function function_44244433(loadout) {
  self givetalents(loadout.talents, loadout.var_1c89585f, loadout.var_285151c1);
  primaryweaponstruct = function_d98e2783(loadout, "primary");
  primaryweapon = primaryweaponstruct.weapon;
  var_df9e1af5 = primaryweaponstruct.var_f879230e;

  if(isDefined(primaryweapon)) {
    self.lastnonkillstreakweapon = primaryweapon;
    self giveweapon(primaryweapon, undefined, var_df9e1af5);
    self givestartammo(primaryweapon);
    self switchtoweapon(primaryweapon, 1);
    self loadout::function_442539("primary", primaryweapon);
  } else {
    nullprimary = getweapon(#"bare_hands");
    self giveweapon(nullprimary);
    self setweaponammoclip(nullprimary, 0);
    self loadout::function_442539("primary", nullprimary);
  }

  secondaryweaponstruct = function_d98e2783(loadout, "secondary");
  secondaryweapon = secondaryweaponstruct.weapon;
  var_48d617f1 = secondaryweaponstruct.var_f879230e;

  if(isDefined(secondaryweapon)) {
    self giveweapon(secondaryweapon, undefined, var_48d617f1);
    self givestartammo(secondaryweapon);
    self loadout::function_442539("secondary", secondaryweapon);

    if(!isDefined(primaryweapon)) {
      self switchtoweapon(secondaryweapon, 1);
    }
  } else {
    nullsecondary = getweapon(#"bare_hands");
    self giveweapon(nullsecondary);
    self setweaponammoclip(nullsecondary, 0);
    self loadout::function_442539("secondary", nullsecondary);
  }

  firstround = util::isfirstround();
  primarygrenade = loadout.primarygrenade;

  if(isDefined(primarygrenade)) {
    var_8e797a67 = getweapon(primarygrenade);
    self giveweapon(var_8e797a67);
    var_4e6e2c39 = var_8e797a67.clipsize;

    if(loadout.var_1c89585f === 1) {
      var_4e6e2c39++;
    }

    self setweaponammoclip(var_8e797a67, var_4e6e2c39);
    self loadout::function_442539("primarygrenade", var_8e797a67);
    self ability_util::gadget_reset(var_8e797a67, 1, 1, firstround, 0);

    if(var_8e797a67.gadget_type == 0) {
      self giveweapon(level.var_34d27b26);
      self setweaponammoclip(level.var_34d27b26, 0);
    }
  } else {
    self giveweapon(level.var_34d27b26);
    self loadout::function_442539("primarygrenade", level.var_34d27b26);
  }

  secondarygrenade = loadout.secondarygrenade;

  if(isDefined(secondarygrenade)) {
    var_a66b455e = getweapon(secondarygrenade);
    self giveweapon(var_a66b455e);
    var_7173f066 = var_a66b455e.clipsize;

    if(loadout.var_285151c1 === 1) {
      var_7173f066++;
    }

    self setweaponammoclip(var_a66b455e, var_7173f066);
    self loadout::function_442539("secondarygrenade", var_a66b455e);

    if(var_a66b455e.gadget_type != 0) {
      if(var_a66b455e.gadget_type == 23) {
        self ability_util::gadget_power_full(var_a66b455e);
      } else {
        self ability_util::gadget_reset(var_a66b455e, 1, 1, firstround, 0);
      }
    }
  } else {
    self giveweapon(level.var_6388e216);
    self loadout::function_442539("secondarygrenade", level.var_6388e216);
  }

  specialgrenade = loadout.specialgrenade;

  if(isDefined(specialgrenade)) {
    var_8b0bfce9 = getweapon(specialgrenade);
    self giveweapon(var_8b0bfce9);
    self loadout::function_442539("specialgrenade", var_8b0bfce9);
    self ability_util::gadget_reset(var_8b0bfce9, 1, 1, firstround, 0);

    if(var_8b0bfce9.gadget_type == 0) {
      self giveweapon(level.var_43a51921);
      self setweaponammoclip(level.var_43a51921, 0);
    }
  } else {
    var_ad731691 = getweapon(#"null_offhand_secondary");
    self giveweapon(var_ad731691);
    self loadout::function_442539("specialgrenade", var_ad731691);
  }

  self val::set(#"hash_63c98741ae5048e3", "disable_weapon_pickup", 1);
}

function givetalents(talents, var_1c89585f, var_285151c1) {
  self cleartalents();
  self clearperks();

  if(!isDefined(talents)) {
    talents = [];
  }

  if(var_1c89585f === 1) {
    talents[talents.size] = {
      #talent: # "hash_7716cb3888f5dd8a"};
  }

  if(var_285151c1 === 1) {
    talents[talents.size] = {
      #talent: # "hash_2c3a32e6e2afd1f2"};
  }

  foreach(talent in talents) {
    if(isDefined(talent.talent) && talent.talent != # "weapon_null") {
      self addtalent(talent.talent + level.game_mode_suffix);
    }
  }

  perks = self getloadoutperks(0);

  foreach(perk in perks) {
    self setperk(perk);
  }

  self thread perks::monitorgpsjammer();
}

function function_8fdeea14(var_b3d10ae7) {
  var_9fb603ac = [];

  if(isDefined(var_b3d10ae7)) {
    foreach(element in var_b3d10ae7) {
      if(isDefined(element.attachment) && element.attachment != "weapon_null") {
        var_9fb603ac[var_9fb603ac.size] = element.attachment;
      }
    }
  }

  return var_9fb603ac;
}

function getzonearray() {
  zones = getEntArray("gunfight_zone_center", "targetname");

  if(!isDefined(zones)) {
    return undefined;
  }

  return zones;
}

function setupzones() {
  zones = getzonearray();

  if(zones.size == 0) {
    return false;
  }

  trigs = getEntArray("gunfight_zone_trigger", "targetname");
  assert(zones.size == trigs.size, "<dev string:x38>");

  for(i = 0; i < zones.size; i++) {
    errored = 0;
    zone = zones[i];
    zone.trig = undefined;

    for(j = 0; j < trigs.size; j++) {
      if(zone istouching(trigs[j])) {
        if(isDefined(zone.trig)) {
          globallogic_utils::add_map_error("Zone at " + zone.origin + " is touching more than one \"zonetrigger\" trigger");
          errored = 1;
          break;
        }

        zone.trig = trigs[j];
        zone.var_b76aa8 = j;
        zone.trig trigger::add_flags(16);
        break;
      }
    }

    if(!isDefined(zone.trig)) {
      if(!errored) {
        globallogic_utils::add_map_error("Zone at " + zone.origin + " is not inside any \"zonetrigger\" trigger");
        continue;
      }
    }

    assert(!errored);
    zone.trigorigin = zone.trig.origin;
    zone.objectiveanchor = spawn("script_model", zone.origin);
    visuals = [];
    visuals = getEntArray("gunfight_flag_neutral", "targetname");
    othervisuals = getEntArray(zone.target, "targetname");

    for(j = 0; j < othervisuals.size; j++) {
      visuals[visuals.size] = othervisuals[j];
      othervisuals[j] clientfield::set("scriptid", 1);
      othervisuals[j] notsolid();
    }

    zone.gameobject = gameobjects::create_use_object(#"neutral", zone.trig, visuals, (0, 0, 0), #"hash_56c11247a60bfd3c");
    zone.gameobject gameobjects::allow_use(#"group_none");
    zone.gameobject gameobjects::set_model_visibility(0, 1);
    function_18fbab10(zone.gameobject.objectiveid, #"hash_5ccb65c83273cdc9");

    if(util::isfirstround()) {
      zone.gameobject gameobjects::set_visible(#"group_all");
    } else {
      zone.gameobject gameobjects::set_visible(#"group_none");
    }

    zone.trig.useobj = zone.gameobject;
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
  }

  if(globallogic_utils::print_map_errors()) {
    return false;
  }

  level.zones = zones;
  return true;
}

function ontimelimit() {
  if(level.var_31f5f23 !== 1) {
    level.var_31f5f23 = 1;
    thread overtime();
    return;
  }

  function_c4915ac();
}

function overtime() {
  if(level.gunfightspyplane === 2) {
    foreach(team, _ in level.teams) {
      setteamspyplane(team, 1);
    }
  }

  level.var_1cc83170 = -1;
  level.var_537d4629 = level.extratime + 1;
  level.var_807b9ff6 = -1;
  zone = level.zones[0];

  if(zone.gameobject gameobjects::function_339d0e91() > 0) {
    pause_time();
  }

  setgameendtime(gettime() + int(level.extratime * 1000));
  thread globallogic::timelimitclock();
  level.usingextratime = 1;
  level thread globallogic::updategametypedvars();
  playsoundatposition(#"hash_6a5f99378f4a93c1", (0, 0, 0));
  music::setmusicstate("gunfight_time_extended");

  if(!isDefined(zone)) {
    function_c4915ac();
    return;
  }

  zone.gameobject gameobjects::allow_use(#"group_all");
  zone.gameobject gameobjects::set_use_time(level.capturetime);
  zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
  zone.gameobject gameobjects::set_visible(#"group_all");
  zone.gameobject gameobjects::set_model_visibility(1, 1);
  zone.gameobject gameobjects::must_maintain_claim(0);
  zone.gameobject gameobjects::can_contest_claim(1);
  zone.gameobject gameobjects::set_onbeginuse_event(&onbeginuse);
  zone.gameobject gameobjects::function_6362d6ea(&onuseupdate);
  zone.gameobject gameobjects::set_onuse_event(&onzonecapture);
  zone.gameobject gameobjects::set_onenduse_event(&onenduse);
  level clientfield::set("activeTrigger", 1);
  zone function_844322c9();
  globallogic_audio::leader_dialog("gnfOvertime", undefined, "gamemode_objective");
  luinotifyevent(#"hardpoint_unlocked");
  util::function_a3f7de13(29, #"none");

  if(level.tournamentmatch === 1) {
    function_d33c99f8();
  }
}

function function_844322c9() {
  setmatchflag("bomb_timer_a", 1);
  setbombtimer("A", gettime() + int(level.extratime * 1000));
}

function onuseupdate(team, progress, change) {
  var_2349519b = math::clamp(progress, 0, 1);
  objective_setprogress(self.objectiveid, var_2349519b);

  if(change > 0) {
    self gameobjects::set_flags(team == "allies" ? 1 : 2);
  }
}

function onzonecapture(sentient) {
  if(level.var_c7cce1ff === 1) {
    return;
  }

  self notify(#"zone_captured");

  foreach(player in getplayers()) {
    player playlocalsound(#"hash_6234f3332aa1bfe4");
  }

  if(isPlayer(sentient)) {
    team = sentient.team;
  } else if(isDefined(sentient.owner)) {
    team = sentient.owner.team;
  }

  if(isDefined(self.users[team]) && isDefined(self.users[team].touching.players)) {
    foreach(struct in self.users[team].touching.players) {
      var_41313ace = struct.player;
      scoreevents::processscoreevent(#"hash_18a50932842f1689", var_41313ace);
    }
  }

  endround(team, 12);
}

function onbeginuse(player) {
  pause_time();
}

function onenduse(team, sentient, success) {
  if(!isDefined(sentient)) {
    return;
  }

  player = sentient;

  if(!isPlayer(player)) {
    player = sentient.owner;
  }

  if(!success) {
    resume_time();
  }

  player notify(#"event_ended");
}

function function_c4915ac() {
  if(level.var_c7cce1ff === 1) {
    return;
  }

  var_3a22d07b = 0;
  var_f6718d9a = 0;

  foreach(player in getplayers(#"allies")) {
    var_3a22d07b += player.health;
  }

  foreach(player in getplayers(#"axis")) {
    var_f6718d9a += player.health;
  }

  if(var_3a22d07b > var_f6718d9a) {
    endround(#"allies", 1);
    return;
  }

  if(var_3a22d07b < var_f6718d9a) {
    endround(#"axis", 1);
    return;
  }

  if(level.var_3778003e === 1) {
    globallogic_score::giveteamscoreforobjective(#"allies", 1);
    globallogic_score::giveteamscoreforobjective(#"axis", 1);
    game.stat[# "roundswon"][# "allies"]++;
    game.stat[# "roundswon"][# "axis"]++;
  }

  thread globallogic::end_round(2);
}

function gettimelimit() {
  timelimit = getgametypesetting(#"timelimit") / 60;

  if(timelimit < level.timelimitmin) {
    timelimit = level.timelimitmin;
  } else if(timelimit > level.timelimitmax) {
    timelimit = level.timelimitmax;
  }

  if(level.usingextratime) {
    extratime = (level.extratime + float(function_60d95f53()) / 1000) / 60;
    return (timelimit + extratime);
  }

  return timelimit;
}

function endround(winning_team, var_c1e98979) {
  if(!isDefined(winning_team) || level.var_c7cce1ff === 1) {
    return;
  }

  round::set_winner(winning_team);
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  level clientfield::set("activeTrigger", 0);
  thread globallogic::function_a3e3bd39(winning_team, var_c1e98979);
  level.var_c7cce1ff = 1;
}

function pause_time() {
  if(!is_true(level.timerpaused)) {
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
  }
}

function resume_time() {
  if(is_true(level.timerpaused)) {
    globallogic_utils::resumetimer();
    level.timerpaused = 0;
  }
}

function private function_3e53e79d(team, deadteam) {
  if(!isDefined(team) || !isDefined(deadteam)) {
    return;
  }

  waittillframeend();
  var_fbd29ffa = isDefined(level.var_12491923[deadteam]) ? level.var_12491923[deadteam] : 0;

  if(var_fbd29ffa <= 1) {
    return;
  }

  timepassed = float(globallogic_utils::gettimepassed()) / 1000;

  if(timepassed < 15) {
    totalkills = 0;
    aliveplayers = function_a1ef346b(team);

    foreach(player in aliveplayers) {
      totalkills += isDefined(player.var_9b890e79) ? player.var_9b890e79 : 0;
    }

    if(totalkills >= var_fbd29ffa) {
      foreach(player in aliveplayers) {
        scoreevents::processscoreevent(#"hash_74e8afe823d11240", player);
      }
    }
  }

  foreach(player in getplayers(team)) {
    if(isDefined(player.var_9b890e79) && player.var_9b890e79 >= var_fbd29ffa) {
      scoreevents::processscoreevent(#"hash_3519e5bb7cacb1a7", player);
      player stats::function_cc215323(#"hash_75477f88c5551f60", 1);
    }
  }
}

function function_4d70ac20(loadout) {
  primary = self loadout::function_18a77b37("<dev string:x79>");
  secondary = self loadout::function_18a77b37("<dev string:x84>");

  if(primary.name != loadout.primary || secondary.name != loadout.secondary) {
    return 0;
  }

  if(!self hasperk(#"specialty_sprint") || !self hasperk(#"specialty_slide")) {
    return 0;
  }

  return 1;
}

function function_a481300e() {
  self endon(#"game_ended");
  dur = 0.5;

  while(true) {
    var_3a22d07b = 0;
    var_f6718d9a = 0;

    foreach(player in getplayers(#"allies")) {
      var_3a22d07b += player.health;
    }

    foreach(player in getplayers(#"axis")) {
      var_f6718d9a += player.health;
    }

    wait dur;
  }
}