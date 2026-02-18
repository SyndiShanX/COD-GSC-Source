/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dem.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_7a8059ca02b7b09e;
#using scripts\core_common\battlechatter;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\dogtags;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\gametype;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\overtime;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace dem;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registerscorelimit(0, 500);
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.playerspawnedcb = &function_fcf8c3f3;
  player::function_cf3aa03d(&onplayerkilled);
  level.ondeadevent = &ondeadevent;
  level.ononeleftevent = &ononeleftevent;
  level.ontimelimit = &ontimelimit;
  level.onroundswitch = &onroundswitch;
  level.gettimelimit = &gettimelimit;
  level.shouldplayovertimeround = &shouldplayovertimeround;
  level.var_17ae20ae = &function_17ae20ae;
  level.var_6c4ec3fc = &function_8af3b312;
  level.var_21479330 = undefined;
  level.var_3b2307bb = undefined;
  level.ddbombmodel = [];
  level.endgameonscorelimit = 0;
  level.var_cbdf9ba4 = "bombzone_dem";
  level.var_ce802423 = 1;
  globallogic_defaults::function_daa7e9d5();
  spawning::addsupportedspawnpointtype("dem");
  clientfield::register_clientuimodel("Demolition.isCarryingBomb", 1, 1, "int", 0);
}

function function_b4530b39() {
  level endon(#"game_ended");

  while(game.state != # "playing") {
    waitframe(1);
  }

  globallogic_audio::leader_dialog("roundOvertime");

  foreach(player in level.players) {
    team = player.pers[# "team"];

    if(team === # "spectator") {
      continue;
    }

    player luinotifyevent(#"hash_6b67aa04e378d681", 1, 21);
  }
}

function function_17ae20ae(einflictor, attacker, smeansofdeath, weapon) {
  if(isDefined(self.isdefusing) && self.isdefusing || isDefined(self.isplanting) && self.isplanting) {
    return true;
  }

  return false;
}

function onroundswitch() {
  if(game.stat[# "teamscores"][# "allies"] == level.scorelimit - 1 && game.stat[# "teamscores"][# "axis"] == level.scorelimit - 1) {
    aheadteam = getbetterteam();

    if(aheadteam != game.defenders) {
      game.switchedsides = !game.switchedsides;
    }

    level.halftimetype = 4;

    if(isDefined(level.bombzones[1])) {
      level.bombzones[1] gameobjects::disable_object();
    }

    return;
  }

  gametype::on_round_switch();
}

function getbetterteam() {
  kills[# "allies"] = 0;
  kills[# "axis"] = 0;
  deaths[# "allies"] = 0;
  deaths[# "axis"] = 0;

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    team = player.pers[# "team"];

    if(isDefined(team) && (team == # "allies" || team == # "axis")) {
      kills[team] += player.kills;
      deaths[team] += player.deaths;
    }
  }

  if(kills[# "allies"] > kills[# "axis"]) {
    return # "allies";
  } else if(kills[# "axis"] > kills[# "allies"]) {
    return # "axis";
  }

  if(deaths[# "allies"] < deaths[# "axis"]) {
    return # "allies";
  } else if(deaths[# "axis"] < deaths[# "allies"]) {
    return # "axis";
  }

  if(randomint(2) == 0) {
    return # "allies";
  }

  return # "axis";
}

function onstartgametype() {
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  setbombtimer("B", 0);
  setmatchflag("bomb_timer_b", 0);
  level.usingextratime = 0;
  hud_message::function_36419c2(1, game.strings[# "target_destroyed"], game.strings[# "target_destroyed"]);
  setclientnamemode("manual_change");
  game.strings[# "target_destroyed"] = # "mp/target_destroyed";
  game.strings[# "bomb_defused"] = # "mp/bomb_defused";
  level._effect[# "bombexplosion"] = # "hash_1811460fd925f1f8";
  level._effect[# "hash_568509fa2561a75d"] = # "hash_4d29da75039cfce";
  bombzones = getEntArray(level.var_cbdf9ba4, "targetname");

  if(bombzones.size == 0) {
    level.var_cbdf9ba4 = "bombzone";
  }

  thread updategametypedvars();
  thread bombs();
  level thread function_39dabed5();

  if(is_true(level.droppedtagrespawn)) {
    level.numlives = 1;
  }

  if(overtime::is_overtime_round()) {
    thread function_b4530b39();
  }
}

function onspawnplayer(predictedspawn) {
  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = !isdefending(self);
  self thread function_1e8f61d1();
  spawning::onspawnplayer(predictedspawn);
}

function function_1e8f61d1() {
  self endon(#"death", #"disconnect");
  waitframe(1);
  self clientfield::set_player_uimodel("Demolition.isCarryingBomb", self.isbombcarrier);
}

function isdefending(player) {
  if(game.overtime_round) {
    return false;
  }

  return game.defenders == player.team;
}

function function_fcf8c3f3() {
  level notify(#"spawned_player");
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  thread checkallowspectating();

  if(is_true(level.droppedtagrespawn)) {
    should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();

    if(should_spawn_tags) {
      level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
    }
  }

  bombzone = undefined;

  for(index = 0; index < level.bombzones.size; index++) {
    if(!isDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
      dist = distance2dsquared(self.origin, level.bombzones[index].curorigin);

      if(dist < level.defaultoffenseradiussq) {
        bombzone = level.bombzones[index];
        break;
      }

      dist = distance2dsquared(attacker.origin, level.bombzones[index].curorigin);

      if(dist < level.defaultoffenseradiussq) {
        inbombzone = 1;
        break;
      }
    }
  }

  if(isDefined(bombzone) && isPlayer(attacker) && attacker.pers[# "team"] != self.pers[# "team"]) {
    if(bombzone gameobjects::get_owner_team() != attacker.team) {
      if(!isDefined(attacker.var_28c6734a)) {
        attacker.var_28c6734a = 0;
      }

      attacker.var_28c6734a++;

      if(level.playeroffensivemax >= attacker.var_28c6734a) {
        attacker medals::offenseglobalcount();
        attacker thread challenges::killedbasedefender(bombzone.trigger);
        scoreevents::processscoreevent("killed_defender", attacker, self, weapon);
        level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
          #player: self, #var_bdc4bbd2: # "defending"});
        attacker challenges::function_2f462ffd(self, weapon, einflictor, bombzone.trigger);
        attacker.pers[# "objectiveekia"]++;
        attacker.objectiveekia = attacker.pers[# "objectiveekia"];
        attacker.pers[# "objectives"]++;
        attacker.objectives = attacker.pers[# "objectives"];
      } else {
        attacker iprintlnbold("<dev string:x38>");
      }
    } else {
      if(!isDefined(attacker.var_b9f51a5d)) {
        attacker.var_b9f51a5d = 0;
      }

      attacker.var_b9f51a5d++;

      if(level.playerdefensivemax >= attacker.var_b9f51a5d) {
        if(isDefined(attacker.pers[# "defends"])) {
          attacker.pers[# "defends"]++;
          attacker.defends = attacker.pers[# "defends"];
        }

        attacker medals::defenseglobalcount();
        attacker thread challenges::killedbaseoffender(bombzone.trigger, weapon, einflictor);
        scoreevents::processscoreevent("killed_attacker", attacker, self, weapon);
        level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
          #player: self, #var_bdc4bbd2: # "assaulting"});
        attacker challenges::function_2f462ffd(self, weapon, einflictor, bombzone.trigger);
        attacker.pers[# "objectiveekia"]++;
        attacker.objectiveekia = attacker.pers[# "objectiveekia"];
        attacker.pers[# "objectives"]++;
        attacker.objectives = attacker.pers[# "objectives"];
      } else {
        attacker iprintlnbold("<dev string:x82>");
      }
    }
  }

  if(self.isplanting == 1) {
    level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
      #player: self, #var_bdc4bbd2: # "planting"});
  }

  if(self.isdefusing == 1) {
    level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
      #player: self, #var_bdc4bbd2: # "defusing"});
  }
}

function checkallowspectating() {
  self endon(#"disconnect");
  waitframe(1);
  update = 0;
  livesleft = !(level.numlives && !self.pers[# "lives"]);

  if(!function_a1ef346b(game.attackers).size && !livesleft) {
    level.spectateoverride[game.attackers].allowenemyspectate = # "all";
    update = 1;
  }

  if(!function_a1ef346b(game.defenders).size && !livesleft) {
    level.spectateoverride[game.defenders].allowenemyspectate = # "all";
    update = 1;
  }

  if(update) {
    spectating::update_settings();
  }
}

function function_92164b1c(winningteam, var_c1e98979) {
  foreach(bombzone in level.bombzones) {
    bombzone gameobjects::set_visible(#"group_none");
  }

  thread globallogic::function_a3e3bd39(winningteam, var_c1e98979);
}

function function_6e7465ab(var_c1e98979) {
  foreach(bombzone in level.bombzones) {
    bombzone gameobjects::set_visible(#"group_none");
  }

  round::set_flag("tie");
  thread globallogic::end_round(var_c1e98979);
}

function ondeadevent(team) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }

  if(team == "all") {
    if(level.bombplanted) {
      function_92164b1c(game.attackers, 6);
    } else {
      function_92164b1c(game.defenders, 6);
    }

    return;
  }

  if(team == game.attackers) {
    if(level.bombplanted) {
      return;
    }

    function_92164b1c(game.defenders, 6);
    return;
  }

  if(team == game.defenders) {
    function_92164b1c(game.attackers, 6);
  }
}

function ononeleftevent(team) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }

  warnlastplayer(team);
}

function ontimelimit() {
  if(overtime::is_overtime_round()) {
    function_6e7465ab(2);
    return;
  }

  if(level.teambased) {
    var_3c6bbe27 = 0;

    for(index = 0; index < level.bombzones.size; index++) {
      if(!isDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
        var_3c6bbe27++;
      }
    }

    if(var_3c6bbe27 == 0 || level.var_e8b70364 === 1) {
      function_92164b1c(game.attackers, 1);
    } else {
      function_92164b1c(game.defenders, 2);
    }

    return;
  }

  function_6e7465ab(2);
}

function warnlastplayer(team) {
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

  players[i] thread givelastattackerwarning();
}

function givelastattackerwarning() {
  self endon(#"death", #"disconnect");
  fullhealthtime = 0;
  interval = 0.05;

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

  self globallogic_audio::leader_dialog_on_player("roundSuddenDeath");
}

function updategametypedvars() {
  level.planttime = getgametypesetting(#"planttime");
  level.defusetime = getgametypesetting(#"defusetime");
  level.bombtimer = getgametypesetting(#"bombtimer");
  level.extratime = getgametypesetting(#"extratime");
  level.overtimetimelimit = getgametypesetting(#"overtimetimelimit");
  level.teamkillpenaltymultiplier = getgametypesetting(#"teamkillpenalty");
  level.teamkillscoremultiplier = getgametypesetting(#"teamkillscore");
  level.var_3db672a4 = getgametypesetting(#"maxplayereventsperminute");
  level.var_f5ae264 = getgametypesetting(#"maxobjectiveeventsperminute");
  level.playeroffensivemax = getgametypesetting(#"maxplayeroffensive");
  level.playerdefensivemax = getgametypesetting(#"maxplayerdefensive");
}

function resetbombzone() {
  if(overtime::is_overtime_round()) {
    self gameobjects::set_owner_team(#"neutral");
    self gameobjects::allow_use(#"group_all");
  } else {
    self gameobjects::allow_use(#"group_enemy");
  }

  self gameobjects::set_use_time(level.planttime);
  self gameobjects::set_visible(#"group_all");
  self.useweapon = getweapon(#"briefcase_bomb");
}

function setupfordefusing() {
  self gameobjects::allow_use(#"group_friendly");
  self gameobjects::set_use_time(level.defusetime);
  self gameobjects::set_visible(#"group_all");
}

function bombs() {
  level.var_ea8469b5 = 0;
  level.var_119e12f4 = 0;
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  sdbomb = getent("sd_bomb", "targetname");

  if(isDefined(sdbomb)) {
    sdbomb delete();
  }

  level.bombzones = [];
  bombzones = getEntArray(level.var_cbdf9ba4, "targetname");

  for(index = 0; index < bombzones.size; index++) {
    trigger = bombzones[index];
    scriptlabel = trigger.script_label;
    visuals = getEntArray(bombzones[index].target, "targetname");
    clipbrushes = getEntArray("bombzone_clip" + scriptlabel, "targetname");
    defusetrig = getent(visuals[0].target, "targetname");
    var_b3c46dd0 = game.defenders;
    var_2b4ef22b = # "group_enemy";

    if(overtime::is_overtime_round()) {
      if(scriptlabel != "_overtime") {
        trigger delete();
        defusetrig delete();
        visuals[0] delete();

        foreach(clip in clipbrushes) {
          clip delete();
        }

        continue;
      }

      var_b3c46dd0 = # "neutral";
      var_2b4ef22b = # "group_all";
      scriptlabel = "_a";
    } else if(scriptlabel == "_overtime") {
      trigger delete();
      defusetrig delete();
      visuals[0] delete();

      foreach(clip in clipbrushes) {
        clip delete();
      }

      continue;
    }

    name = # "dem" + scriptlabel;
    trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
    trigger usetriggerignoreuseholdtime();
    trigger function_268e4500();
    trigger function_682f34cf(-800);
    bombzone = gameobjects::create_use_object(var_b3c46dd0, trigger, visuals, (0, 0, 0), name, 1, 1);
    bombzone gameobjects::allow_use(var_2b4ef22b);
    bombzone gameobjects::set_use_time(level.planttime);
    bombzone.label = scriptlabel;
    bombzone.index = index;
    bombzone gameobjects::set_visible(#"group_all");
    bombzone.onbeginuse = &onbeginuse;
    bombzone.onenduse = &onenduse;
    bombzone.onuse = &onuseobject;
    bombzone.oncantuse = &oncantuse;
    bombzone.useweapon = getweapon(#"briefcase_bomb");
    bombzone.visuals[0].killcament = spawn("script_model", bombzone.visuals[0].origin + (0, 0, 128));

    if(isDefined(level.bomb_zone_fixup)) {
      [[level.bomb_zone_fixup]](bombzone);
    }

    for(i = 0; i < visuals.size; i++) {
      if(isDefined(visuals[i].script_exploder)) {
        bombzone.exploderindex = visuals[i].script_exploder;
        break;
      }
    }

    foreach(visual in bombzone.visuals) {
      visual.team = # "none";
    }

    level.bombzones[level.bombzones.size] = bombzone;
    bombzone.bombdefusetrig = defusetrig;
    assert(isDefined(bombzone.bombdefusetrig));
    bombzone.bombdefusetrig.origin += (0, 0, -10000);
    bombzone.bombdefusetrig.label = scriptlabel;
    team_mask = util::getteammask(game.attackers);
    bombzone.spawninfluencer = bombzone influencers::create_influencer("dem_enemy_base", trigger.origin, team_mask);
  }

  for(index = 0; index < level.bombzones.size; index++) {
    array = [];

    for(otherindex = 0; otherindex < level.bombzones.size; otherindex++) {
      if(otherindex != index) {
        array[array.size] = level.bombzones[otherindex];
      }
    }

    level.bombzones[index].otherbombzones = array;
  }
}

function setbomboverheatingafterweaponchange(useobject, overheated, heat) {
  self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
  waitresult = self waittill(#"weapon_change");

  if(waitresult.weapon == useobject.useweapon) {
    self setweaponoverheating(overheated, heat, waitresult.weapon);
  }
}

function function_208ed5d5(team) {
  team = util::get_team_mapping(team);

  if(!level.teambased) {
    return true;
  }

  owner_team = self gameobjects::get_owner_team();

  if(owner_team == # "any") {
    return true;
  }

  if(owner_team == team) {
    return true;
  }

  return false;
}

function onbeginuse(player) {
  timeremaining = globallogic_utils::gettimeremaining();

  if(timeremaining <= int(level.planttime * 1000)) {
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
  }

  if(self function_208ed5d5(player.pers[# "team"])) {
    player playSound(#"mpl_sd_bomb_defuse");
    player.isdefusing = 1;
    player thread setbomboverheatingafterweaponchange(self, 0, 0);
    bestdistance = 9000000;
    var_fa43ed99 = undefined;

    if(isDefined(level.ddbombmodel)) {
      keys = getarraykeys(level.ddbombmodel);

      for(bomblabel = 0; bomblabel < keys.size; bomblabel++) {
        bomb = level.ddbombmodel[keys[bomblabel]];

        if(!isDefined(bomb)) {
          continue;
        }

        dist = distancesquared(player.origin, bomb.origin);

        if(dist < bestdistance) {
          bestdistance = dist;
          var_fa43ed99 = bomb;
        }
      }

      assert(isDefined(var_fa43ed99));
      player.defusing = var_fa43ed99;
      var_fa43ed99 hide();
    }

    return;
  }

  player.isplanting = 1;
  player thread setbomboverheatingafterweaponchange(self, 0, 0);
}

function onenduse(team, player, result) {
  if(!isDefined(player)) {
    if(!result) {
      self gameobjects::clear_progress();
      self.trigger releaseclaimedtrigger();
    }

    return;
  }

  if(!level.var_ea8469b5 && !level.var_119e12f4) {
    globallogic_utils::resumetimer();
    level.timerpaused = 0;
  }

  player.isdefusing = 0;
  player.isplanting = 0;
  player notify(#"event_ended");

  if(self function_208ed5d5(player.pers[# "team"])) {
    if(isDefined(player.defusing) && !result) {
      player.defusing show();
    }
  }
}

function oncantuse(player) {
  player iprintlnbold(#"mp/cant_plant_without_bomb");
}

function onuseobject(player) {
  team = player.team;
  enemyteam = util::getotherteam(team);
  self function_1e4847e();
  player function_1e4847e();

  if(!self function_208ed5d5(team)) {
    self gameobjects::set_flags(1);
    level thread bombplanted(self, player);

    print("<dev string:xcc>" + self.label);

    bb::function_95a5b5c2("dem_bombplant", self.label, team, player.origin);
    player notify(#"bomb_planted");

    if(isDefined(player.pers[# "plants"])) {
      player.pers[# "plants"]++;
      player.plants = player.pers[# "plants"];
    }

    player.pers[# "objectives"]++;
    player.objectives = player.pers[# "objectives"];

    if(!isscoreboosting(player, self)) {
      demo::bookmark(#"event", gettime(), player);
      potm::bookmark(#"event", gettime(), player);
      player stats::function_bb7eedf0(#"plants", 1);
      player stats::function_dad108fa(#"plants_defuses", 1);
      scoreevents::processscoreevent("planted_bomb", player, undefined, undefined);
      player recordgameevent("plant");
      level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
        #player: player, #eventtype: # "plant"});
    } else {
      player iprintlnbold("<dev string:xde>");
    }

    level thread popups::displayteammessagetoall(#"hash_12473d7e6ed6e752", player);
    globallogic_audio::leader_dialog("bombPlanted");
    return;
  }

  self gameobjects::set_flags(0);
  player notify(#"bomb_defused");

  print("<dev string:x124>" + self.label);

  self thread bombdefused(player);
  self resetbombzone();
  bb::function_95a5b5c2("dem_bombdefused", self.label, team, player.origin);

  if(isDefined(player.pers[# "defuses"])) {
    player.pers[# "defuses"]++;
    player.defuses = player.pers[# "defuses"];
  }

  player.pers[# "objectives"]++;
  player.objectives = player.pers[# "objectives"];

  if(!isscoreboosting(player, self)) {
    demo::bookmark(#"event", gettime(), player);
    player stats::function_bb7eedf0(#"defuses", 1);
    player stats::function_dad108fa(#"plants_defuses", 1);
    scoreevents::processscoreevent("defused_bomb", player, undefined, undefined);
    player recordgameevent("defuse");
    level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
      #player: player, #eventtype: # "defuse"});
  } else {
    player iprintlnbold("<dev string:x136>");
  }

  level thread popups::displayteammessagetoall(#"mp/explosives_defused_by", player);
  globallogic_audio::leader_dialog("bombDefused");
}

function ondrop(player) {
  if(!level.bombplanted) {
    globallogic_audio::leader_dialog("bombFriendlyDropped", player.pers[# "team"]);

    if(isDefined(player)) {
      print("<dev string:x17d>");
    } else {
      print("<dev string:x17d>");
    }
  }

  player notify(#"event_ended");
  sound::play_on_players(game.bomb_dropped_sound, game.attackers);
}

function onpickup(player) {
  player.isbombcarrier = 1;
  player thread function_1e8f61d1();

  if(!level.bombdefused) {
    thread sound::play_on_players("mus_sd_pickup" + "_" + level.teampostfix[player.pers[# "team"]], player.pers[# "team"]);
    globallogic_audio::leader_dialog("bombFriendlyTaken", player.pers[# "team"]);

    print("<dev string:x18d>");
  }

  sound::play_on_players(game.bomb_recovered_sound, game.attackers);
}

function onreset() {}

function function_c15fc31f(label, reason) {
  if(label == "_a") {
    level.var_ea8469b5 = 0;
    setbombtimer("A", 0);
  } else {
    level.var_119e12f4 = 0;
    setbombtimer("B", 0);
  }

  setmatchflag("bomb_timer" + label, 0);

  if(!level.var_ea8469b5 && !level.var_119e12f4) {
    level.timerpaused = 0;
    globallogic_utils::resumetimer();
  }

  self.visuals[0] globallogic_utils::stoptickingsound();

  if(reason == "bomb_exploded") {
    self gameobjects::allow_use(#"group_none");
    self gameobjects::set_flags(2);
    self gameobjects::disable_object(0, 0);
  }
}

function dropbombmodel(player, site) {
  trace = bulletTrace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000), 0, player);
  tempangle = randomfloat(360);
  forward = (cos(tempangle), sin(tempangle), 0);
  forward = vectornormalize(forward - vectorscale(trace[# "normal"], vectordot(forward, trace[# "normal"])));
  dropangles = vectortoangles(forward);
  offset = (0, 0, 3);

  if(isDefined(trace[# "surfacetype"]) && trace[# "surfacetype"] == "water") {
    phystrace = playerphysicstrace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000));

    if(isDefined(phystrace)) {
      trace[# "position"] = phystrace;
    }
  }

  level.ddbombmodel[site] = spawn("script_model", trace[# "position"] + offset);
  level.ddbombmodel[site].angles = dropangles;
  level.ddbombmodel[site] setModel(#"wpn_t9_eqp_c4_bomb_world");
}

function private function_ddc47ed1(label) {
  spawning::function_c40af6fa();
  spawning::addsupportedspawnpointtype("dem");

  if(label == "_a") {
    spawning::addsupportedspawnpointtype("dem_remove_b");
    spawning::addsupportedspawnpointtype("dem_attacker_a");
    spawning::addsupportedspawnpointtype("dem_defender_b");
    return;
  }

  spawning::addsupportedspawnpointtype("dem_remove_a");
  spawning::addsupportedspawnpointtype("dem_attacker_b");
  spawning::addsupportedspawnpointtype("dem_defender_a");
}

function function_8af3b312() {
  spawning::addsupportedspawnpointtype("dem");

  if(!overtime::is_overtime_round()) {
    spawning::addsupportedspawnpointtype("dem_remove_a");
    spawning::addsupportedspawnpointtype("dem_remove_b");
    spawning::addsupportedspawnpointtype("dem_defender_a");
    spawning::addsupportedspawnpointtype("dem_defender_b");
  }

  spawnpoint = spawning::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);

  if(overtime::is_overtime_round()) {
    spawning::addsupportedspawnpointtype("dem_overtime");
  } else {
    spawning::addsupportedspawnpointtype("dem_start_spawn");
  }

  globallogic::function_8af3b312();
}

function bombplanted(destroyedobj, player) {
  level endon(#"game_ended");
  destroyedobj endon(#"bomb_defused");
  team = player.team;
  game.challenge[team][# "plantedbomb"] = 1;
  globallogic_utils::pausetimer();
  level.timerpaused = 1;
  destroyedobj.bombplanted = 1;
  player setweaponoverheating(1, 100, destroyedobj.useweapon);
  player playbombplant();
  destroyedobj.visuals[0] thread globallogic_utils::playtickingsound("mpl_sab_ui_suitcasebomb_timer");
  destroyedobj.tickingobject = destroyedobj.visuals[0];
  level thread function_ee6e5993();
  label = destroyedobj.label;
  detonatetime = gettime() + int(level.bombtimer * 1000);
  function_789dbdd3(label, detonatetime);
  destroyedobj.detonatetime = detonatetime;
  trace = bulletTrace(player.origin + (0, 0, 20), player.origin - (0, 0, 2000), 0, player);
  self dropbombmodel(player, destroyedobj.label);
  destroyedobj gameobjects::allow_use(#"group_none");
  destroyedobj gameobjects::set_visible(#"group_none");

  if(overtime::is_overtime_round()) {
    destroyedobj gameobjects::set_owner_team(util::getotherteam(player.team));
  }

  destroyedobj setupfordefusing();
  game.challenge[team][# "plantedbomb"] = 1;
  destroyedobj function_473a1738(label, level.bombtimer);
  destroyedobj function_c15fc31f(label, "bomb_exploded");

  if(level.gameended) {
    return;
  }

  origin = (0, 0, 0);

  if(isDefined(player)) {
    origin = player.origin;
  }

  bb::function_95a5b5c2("dem_bombexplode", label, team, origin);
  destroyedobj.bombexploded = 1;
  game.challenge[team][# "destroyedbombsite"] = 1;
  explosionorigin = destroyedobj.curorigin;
  level.ddbombmodel[destroyedobj.label] delete();

  if(isDefined(player)) {
    destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, 200, 20, player, "MOD_EXPLOSIVE", getweapon(#"briefcase_bomb"));

    if(player.team == team) {
      player stats::function_bb7eedf0(#"destructions", 1);
      scoreevents::processscoreevent("bomb_detonated", player, undefined, undefined);
    }

    player recordgameevent("destroy");
    level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
      #player: player, #eventtype: # "destroy"});
  } else {
    destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, 200, 20, undefined, "MOD_EXPLOSIVE", getweapon(#"briefcase_bomb"));
  }

  currenttime = gettime();

  if(isDefined(level.var_21479330) && level.var_3b2307bb == team) {
    if(level.var_21479330 + 10000 > currenttime) {
      for(i = 0; i < level.players.size; i++) {
        if(level.players[i].team == team) {
          level.players[i] challenges::bothbombsdetonatewithintime();
        }
      }
    }
  }

  level.var_21479330 = currenttime;
  level.var_3b2307bb = team;
  rot = randomfloat(360);
  explosioneffect = spawnfx(level._effect[# "bombexplosion"], explosionorigin + (0, 0, 50), (0, 0, 1), (cos(rot), sin(rot), 0));
  triggerfx(explosioneffect);
  destroyedobj thread function_98274264();
  thread sound::play_in_space("mpl_sd_exp_suitcase_bomb_main", explosionorigin);

  if(isDefined(destroyedobj.exploderindex)) {
    exploder::exploder(destroyedobj.exploderindex);
  }

  var_3c6bbe27 = 0;

  for(index = 0; index < level.bombzones.size; index++) {
    if(!isDefined(level.bombzones[index].bombexploded) || !level.bombzones[index].bombexploded) {
      var_3c6bbe27++;
    }
  }

  if(var_3c6bbe27 == 0) {
    level.var_e8b70364 = 1;
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
    setgameendtime(0);
    wait 3;
    function_92164b1c(team, 1);
    return;
  }

  enemyteam = util::getotherteam(team);
  level thread function_b98a264e(1);

  if([[level.gettimelimit]]() > 0) {
    level.usingextratime = 1;
  }

  foreach(player in level.players) {
    team = player.pers[# "team"];

    if(team === # "spectator") {
      continue;
    }

    player luinotifyevent(#"hash_6b67aa04e378d681", 1, 20);
  }

  destroyedobj influencers::remove_influencer(destroyedobj.spawninfluencer);
  destroyedobj.spawninfluencer = undefined;
  function_ddc47ed1(label);
}

function function_98274264() {
  if(!isDefined(self.visuals[0])) {
    return;
  }

  var_d46e7070 = self.visuals[0].origin;
  var_e6397375 = anglesToForward(self.visuals[0].angles);
  var_213527e2 = anglestoup(self.visuals[0].angles);
  wait 0.1;
  var_238e7468 = spawnfx(level._effect[# "hash_568509fa2561a75d"], var_d46e7070, var_e6397375, var_213527e2);
  triggerfx(var_238e7468);
}

function gettimelimit() {
  timelimit = globallogic_defaults::default_gettimelimit();

  if(overtime::is_overtime_round()) {
    timelimit = level.overtimetimelimit;
  }

  if(level.usingextratime) {
    return (timelimit + level.extratime);
  }

  return timelimit;
}

function shouldplayovertimeround() {
  if(overtime::is_overtime_round()) {
    return false;
  }

  if(game.stat[# "teamscores"][# "allies"] == level.roundwinlimit - 1 && game.stat[# "teamscores"][# "axis"] == level.roundwinlimit - 1) {
    return true;
  }

  return false;
}

function function_473a1738(var_d40f7c9f, duration) {
  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + int(duration * 1000);

  while(gettime() < endtime) {
    hostmigration::waittillhostmigrationstarts(float(endtime - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      endtime += 250;
      function_789dbdd3(var_d40f7c9f, endtime);
      wait 0.25;
    }
  }

  if(gettime() != endtime) {
    println("<dev string:x19b>" + gettime() + "<dev string:x1bb>" + endtime);
  }

  while(isDefined(level.hostmigrationtimer)) {
    endtime += 250;
    function_789dbdd3(var_d40f7c9f, endtime);
    wait 0.25;
  }

  return gettime() - starttime;
}

function function_789dbdd3(var_d40f7c9f, detonatetime) {
  if(var_d40f7c9f == "_a") {
    level.var_ea8469b5 = 1;
    setbombtimer("A", int(detonatetime));
  } else {
    level.var_119e12f4 = 1;
    setbombtimer("B", int(detonatetime));
  }

  setmatchflag("bomb_timer" + var_d40f7c9f, int(detonatetime));
}

function bombdefused(player) {
  self.tickingobject globallogic_utils::stoptickingsound();
  self gameobjects::allow_use(#"group_none");
  self gameobjects::set_visible(#"group_none");
  self.bombdefused = 1;
  self notify(#"bomb_defused");
  self.bombplanted = 0;
  self function_c15fc31f(self.label, "bomb_defused");
  player setweaponoverheating(1, 100, self.useweapon);
  player playbombdefuse();
  level thread function_b98a264e();
}

function function_ae26fe4(team, enemyteam) {
  wait 3;

  if(!isDefined(team) || !isDefined(enemyteam)) {
    return;
  }
}

function function_1e4847e() {
  if(!isDefined(self.var_a6766873)) {
    self.var_57260b12 = 0;
    self.var_a6766873 = 0;
  }

  self.var_57260b12++;
  minutespassed = float(globallogic_utils::gettimepassed()) / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed[# "total"])) {
    minutespassed = self.timeplayed[# "total"] / 60;
  }

  self.var_a6766873 = self.var_57260b12 / minutespassed;

  if(self.var_a6766873 > self.var_57260b12) {
    self.var_a6766873 = self.var_57260b12;
  }
}

function isscoreboosting(player, flag) {
  if(!level.rankedmatch) {
    return false;
  }

  if(player.var_a6766873 > level.var_3db672a4) {
    return true;
  }

  if(flag.var_a6766873 > level.var_f5ae264) {
    return true;
  }

  return false;
}

function function_ee6e5993() {
  level notify(#"hash_15b8b6edc4ed3032", {
    #var_7090bf53: 1
  });
}

function function_b98a264e(var_96a07b96 = 0) {
  timeleft = float(globallogic_utils::gettimeremaining()) / 1000;
  timeleftint = int(timeleft + 0.5);

  if(is_true(var_96a07b96)) {
    level.var_a8b23f5a = 0;
  }

  if(timeleftint <= 31 && !var_96a07b96) {
    return;
  }

  if(level.var_ea8469b5 || level.var_119e12f4) {
    return;
  }

  level notify(#"hash_28434e94a8844dc5");
  level thread globallogic_audio::function_13bcae23();
  level thread globallogic_audio::function_913f483f();
}

function function_39dabed5() {
  level endon(#"game_ended");

  while(true) {
    level waittill(#"match_ending_pretty_soon");
    level.var_a8b23f5a = 1;
    level notify(#"hash_d50c83061fcd561");
    level thread globallogic_audio::function_913f483f();
  }
}