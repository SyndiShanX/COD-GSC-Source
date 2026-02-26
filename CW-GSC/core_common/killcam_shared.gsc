/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\killcam_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\visionset_mgr_shared;
#namespace killcam;

function private autoexec __init__system__() {
  system::register(#"killcam", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
}

function init() {
  level.killcammode = getgametypesetting(#"killcammode");
  level.finalkillcam = getgametypesetting(#"allowfinalkillcam");
  level.killcamtime = getgametypesetting(#"killcamtime");
  level.var_a95350da = getgametypesetting(#"hash_154db5a1b2e9d757");
  level.var_7abccc83 = !sessionmodeiswarzonegame();
  init_final_killcam();
}

function end_killcam() {
  self.spectatorclient = -1;
  self notify(#"end_killcam");
  self setmodellodbias(0);
}

function function_2f7579f(weaponnamehash) {
  if(!isDefined(level.var_ef3352fc)) {
    level.var_ef3352fc = [];
  }

  level.var_ef3352fc[weaponnamehash] = 1;
}

function get_killcam_entity_start_time(killcamentity) {
  killcamentitystarttime = 0;

  if(isDefined(killcamentity)) {
    if(isDefined(killcamentity.starttime)) {
      killcamentitystarttime = killcamentity.starttime;
    } else {
      killcamentitystarttime = killcamentity.birthtime;
    }

    if(!isDefined(killcamentitystarttime)) {
      killcamentitystarttime = 0;
    }
  }

  return killcamentitystarttime;
}

function store_killcam_entity_on_entity(killcam_entity) {
  assert(isDefined(killcam_entity));
  self.killcamentitystarttime = get_killcam_entity_start_time(killcam_entity);
  self.killcamentityindex = killcam_entity getentitynumber();
}

function init_final_killcam() {
  level.finalkillcamsettings = [];
  init_final_killcam_team(#"none");

  foreach(team, _ in level.teams) {
    init_final_killcam_team(team);
  }

  level.finalkillcam_winner = undefined;
  level.finalkillcam_winnerpicked = undefined;
}

function init_final_killcam_team(team) {
  level.finalkillcamsettings[team] = spawnStruct();
  clear_final_killcam_team(team);
}

function clear_final_killcam_team(team) {
  level.finalkillcamsettings[team].spectatorclient = undefined;
  level.finalkillcamsettings[team].weapon = undefined;
  level.finalkillcamsettings[team].meansofdeath = undefined;
  level.finalkillcamsettings[team].deathtime = undefined;
  level.finalkillcamsettings[team].deathtimeoffset = undefined;
  level.finalkillcamsettings[team].offsettime = undefined;
  level.finalkillcamsettings[team].killcam_entity_info = undefined;
  level.finalkillcamsettings[team].targetentityindex = undefined;
  level.finalkillcamsettings[team].perks = undefined;
  level.finalkillcamsettings[team].killstreaks = undefined;
  level.finalkillcamsettings[team].attacker = undefined;
}

function record_settings(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
  if(!isDefined(level.finalkillcamsettings)) {
    return;
  }

  if(isDefined(attacker.team) && isDefined(attacker) && isDefined(level.teams[attacker.team])) {
    team = attacker.team;
    level.finalkillcamsettings[team].spectatorclient = spectatorclient;
    level.finalkillcamsettings[team].weapon = weapon;
    level.finalkillcamsettings[team].meansofdeath = meansofdeath;
    level.finalkillcamsettings[team].deathtime = deathtime;
    level.finalkillcamsettings[team].deathtimeoffset = deathtimeoffset;
    level.finalkillcamsettings[team].offsettime = offsettime;
    level.finalkillcamsettings[team].killcam_entity_info = killcam_entity_info;
    level.finalkillcamsettings[team].targetentityindex = targetentityindex;
    level.finalkillcamsettings[team].perks = perks;
    level.finalkillcamsettings[team].killstreaks = killstreaks;
    level.finalkillcamsettings[team].attacker = attacker;
  }

  level.finalkillcamsettings[#"none"].spectatorclient = spectatorclient;
  level.finalkillcamsettings[#"none"].weapon = weapon;
  level.finalkillcamsettings[#"none"].meansofdeath = meansofdeath;
  level.finalkillcamsettings[#"none"].deathtime = deathtime;
  level.finalkillcamsettings[#"none"].deathtimeoffset = deathtimeoffset;
  level.finalkillcamsettings[#"none"].offsettime = offsettime;
  level.finalkillcamsettings[#"none"].killcam_entity_info = killcam_entity_info;
  level.finalkillcamsettings[#"none"].targetentityindex = targetentityindex;
  level.finalkillcamsettings[#"none"].perks = perks;
  level.finalkillcamsettings[#"none"].killstreaks = killstreaks;
  level.finalkillcamsettings[#"none"].attacker = attacker;
}

function function_eb3deeec(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
  player = self;

  if(spectatorclient == -1) {
    spectatorclient = player getentitynumber();
  }

  player.var_e59bd911 = {
    #spectatorclient: spectatorclient, #weapon: weapon, #meansofdeath: meansofdeath, #deathtime: deathtime, #deathtimeoffset: deathtimeoffset, #offsettime: offsettime, #killcam_entity_info: killcam_entity_info, #targetentityindex: targetentityindex, #perks: perks, #killstreaks: killstreaks, #attacker: attacker
  };
}

function has_deathcam() {
  return isDefined(self.var_e59bd911);
}

function start_deathcam() {
  if(!self has_deathcam()) {
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    return false;
  }

  if(is_true(self.var_e5681505)) {
    return false;
  }

  self thread deathcam(self);
  return true;
}

function deathcam(victim) {
  self endon(#"disconnect");
  self.var_e5681505 = 1;
  self clientfield::set_player_uimodel("hudItems.killcamActive", 1);
  s = victim.var_e59bd911;
  self killcam(s.spectatorclient, s.targetentityindex, s.killcam_entity_info, s.weapon, s.meansofdeath, s.deathtime, s.deathtimeoffset, s.offsettime, 0, undefined, s.perks, s.killstreaks, s.attacker, 0);
  var_9a73aefe = self.currentspectatingclient;
  self stopfollowing();

  if(var_9a73aefe >= 0) {
    var_e1f8d08d = getentbynum(var_9a73aefe);

    if(isDefined(var_e1f8d08d)) {
      self setcurrentspectatorclient(var_e1f8d08d);
    }
  }

  self.sessionstate = "dead";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self luinotifyevent(#"hash_5b2d65a026de792d", 0);
  self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
  self.var_e5681505 = undefined;

  if(is_true(self.var_686890d5)) {
    self thread[[level.spawnspectator]](self.origin + (0, 0, 60), self.angles);
  }

  waitframe(1);

  if(is_true(self.var_7350dfd7)) {
    self.var_7350dfd7 = undefined;
    timepassed = undefined;

    if(isDefined(self.respawntimerstarttime) && !isDefined(level.hostmigrationtimer)) {
      timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
    }

    self thread[[level.spawnclient]](timepassed);
  }
}

function erase_final_killcam() {
  clear_final_killcam_team(#"none");

  foreach(team, _ in level.teams) {
    clear_final_killcam_team(team);
  }

  level.finalkillcam_winner = undefined;
  level.finalkillcam_winnerpicked = undefined;
}

function final_killcam_waiter() {
  if(level.finalkillcam_winnerpicked === 1 && level.infinalkillcam === 1) {
    level waittill(#"final_killcam_done");
  }
}

function post_round_final_killcam() {
  if(!level.finalkillcam) {
    return;
  }

  level notify(#"play_final_killcam");
  final_killcam_waiter();
}

function function_a26057ee() {
  if(potm::function_ec01de3()) {
    println("<dev string:x38>");
    return;
  }

  post_round_final_killcam();
}

function function_de2b637d(winner) {
  if(!isDefined(winner)) {
    return # "none";
  }

  if(isentity(winner)) {
    return (isDefined(winner.team) ? winner.team : # "none");
  }

  return winner;
}

function do_final_killcam() {
  level waittill(#"play_final_killcam");
  setslowmotion(1, 1, 0);
  level.infinalkillcam = 1;
  winner = # "none";

  if(isDefined(level.finalkillcam_winner)) {
    winner = level.finalkillcam_winner;
  }

  winning_team = function_de2b637d(winner);

  if(!isDefined(level.finalkillcamsettings[winning_team].targetentityindex)) {
    level.infinalkillcam = 0;
    level notify(#"final_killcam_done");
    return;
  }

  attacker = level.finalkillcamsettings[winning_team].attacker;

  if(isDefined(attacker) && isDefined(attacker.archetype) && attacker.archetype == "mannequin") {
    level.infinalkillcam = 0;
    level notify(#"final_killcam_done");
    return;
  }

  if(isDefined(attacker)) {
    challenges::getfinalkill(attacker);
  }

  visionsetnaked("default", 0);
  players = level.players;

  for(index = 0; index < players.size; index++) {
    player = players[index];

    if(!player function_8b1a219a()) {
      player closeingamemenu();
    }

    player thread final_killcam(winner);
  }

  wait 0.1;

  while(are_any_players_watching()) {
    waitframe(1);
  }

  level notify(#"final_killcam_done");
  level.infinalkillcam = 0;
}

function are_any_players_watching() {
  players = level.players;

  for(index = 0; index < players.size; index++) {
    player = players[index];

    if(isDefined(player.killcam)) {
      return true;
    }
  }

  return false;
}

function watch_for_skip_killcam() {
  self endon(#"begin_killcam");
  self waittill(#"disconnect", #"spawned");
  waitframe(1);
  level.numplayerswaitingtoenterkillcam--;
}

function killcam(attackernum, targetnum, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, respawn, maxtime, perks, killstreaks, attacker, keep_deathcam) {
  self endon(#"disconnect", #"spawned", #"game_ended");

  if(meansofdeath < 0) {
    return;
  }

  self thread watch_for_skip_killcam();
  self callback::function_52ac9652(#"on_end_game", &on_end_game, undefined, 1);
  self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
  level.numplayerswaitingtoenterkillcam++;

  if(level.numplayerswaitingtoenterkillcam > 1) {
    println("<dev string:x81>");
    waitframe(level.numplayerswaitingtoenterkillcam - 1);
  }

  waitframe(1);
  level.numplayerswaitingtoenterkillcam--;

  if(!function_7f088568()) {
    println("<dev string:xbf>");

    while(!function_7f088568()) {
      waitframe(1);
    }
  }

  assert(level.numplayerswaitingtoenterkillcam > -1);
  postdeathdelay = float(gettime() - maxtime) / 1000;
  predelay = postdeathdelay + perks;
  killcamentitystarttime = get_killcam_entity_info_starttime(deathtimeoffset);
  camtime = calc_time(offsettime, killcamentitystarttime, predelay, attacker, deathtimeoffset.var_30f79181, respawn);
  postdelay = calc_post_delay();
  killcamlength = camtime + postdelay;

  if(isDefined(attacker) && killcamlength > attacker) {
    if(attacker < 2) {
      return;
    }

    if(attacker - camtime >= 1) {
      postdelay = attacker - camtime;
    } else {
      postdelay = 1;
      camtime = attacker - 1;
    }

    killcamlength = camtime + postdelay;
  }

  killcamoffset = camtime + predelay;
  self notify(#"begin_killcam", {
    #start_time: gettime()
  });

  if(isDefined(offsettime) && offsettime.name === # "straferun_rockets") {
    self setmodellodbias(8);
  }

  self util::clientnotify("sndDEDe");
  killcamstarttime = gettime() - int(killcamoffset * 1000);
  self.sessionstate = "spectator";
  self.spectatekillcam = 1;
  self.spectatorclient = meansofdeath;
  self.killcamentity = -1;
  self thread set_killcam_entities(deathtimeoffset, killcamstarttime);
  self.killcamtargetentity = deathtime;
  self.killcamweapon = offsettime;
  self.killcammod = respawn;
  self.archivetime = killcamoffset;
  self.killcamlength = killcamlength;
  self.psoffsettime = killstreaks;

  if(getdvarfloat(#"hash_475a5a67154785d", -1) >= 0) {
    self.killcamlength = max(0.5, min(self.killcamlength, getdvarfloat(#"hash_475a5a67154785d", -1)));
  }

  foreach(team, _ in level.teams) {
    self allowspectateteam(team, 1);
  }

  self allowspectateteam("freelook", 1);
  self allowspectateteam(#"none", 1);
  waitframe(1);

  if(self.archivetime <= predelay) {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self end_killcam();
    return;
  }

  self thread check_for_abrupt_end();
  self.killcam = 1;

  if(!self issplitscreen() && level.perksenabled == 1) {
    self hud::showperks();
  }

  self thread spawned_killcam_cleanup();
  self thread wait_skip_killcam_button();
  self thread function_fa405b23();
  self thread wait_team_change_end_killcam();
  self thread wait_killcam_time();

  if(isDefined(level.var_60ac2c9)) {
    self thread[[level.var_60ac2c9]]();
  }

  self waittill(#"end_killcam");
  self end(0);

  if(is_true(keep_deathcam)) {
    return;
  }

  self.sessionstate = "dead";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
}

function set_entity(killcamentityindex, delayms) {
  self endon(#"disconnect", #"end_killcam", #"spawned");

  if(delayms > 0) {
    wait float(delayms) / 1000;
  }

  self.killcamentity = killcamentityindex;
}

function set_killcam_entities(entity_info, killcamstarttime) {
  for(index = 0; index < entity_info.entity_indexes.size; index++) {
    delayms = entity_info.entity_spawntimes[index] - killcamstarttime - 100;
    thread set_entity(entity_info.entity_indexes[index], delayms);

    if(delayms <= 0) {
      return;
    }
  }
}

function wait_killcam_time() {
  self endon(#"disconnect", #"end_killcam", #"begin_killcam");
  wait self.killcamlength - 0.05;
  self end_killcam();
}

function wait_final_killcam_slowdown(deathtime, starttime) {
  self endon(#"disconnect", #"end_killcam");
  secondsuntildeath = float(deathtime - starttime) / 1000;
  deathtime = gettime() + int(secondsuntildeath * 1000);
  waitbeforedeath = 2;
  wait max(0, secondsuntildeath - waitbeforedeath);
  util::setclientsysstate("levelNotify", "sndFKsl");
  setslowmotion(1, 0.25, waitbeforedeath);
  wait waitbeforedeath + 0.5;
  setslowmotion(0.25, 1, 1);
  wait 0.5;
}

function function_875fc588() {
  if(!isDefined(self.killcamsskipped)) {
    self.killcamsskipped = 0;
  }

  self.killcamsskipped++;
  self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
  self end_killcam();
  self util::clientnotify("fkce");
}

function wait_skip_killcam_button() {
  self endon(#"disconnect", #"end_killcam");

  while(self useButtonPressed()) {
    waitframe(1);
  }

  while(!self useButtonPressed()) {
    waitframe(1);
  }

  if(!is_true(self.var_eca4c67f)) {
    function_875fc588();
  }
}

function function_fa405b23() {
  self endon(#"disconnect", #"end_killcam");

  while(self jumpbuttonPressed()) {
    waitframe(1);
  }

  while(!self jumpbuttonPressed()) {
    waitframe(1);
  }

  if(!is_true(self.var_eca4c67f)) {
    function_875fc588();
  }
}

function wait_team_change_end_killcam() {
  self endon(#"disconnect", #"end_killcam");
  self waittill(#"changed_class", #"joined_team");
  end(0);
  self end_killcam();
}

function wait_skip_killcam_safe_spawn_button() {
  self endon(#"disconnect", #"end_killcam");

  while(self fragButtonPressed()) {
    waitframe(1);
  }

  while(!self fragButtonPressed()) {
    waitframe(1);
  }

  self.wantsafespawn = 1;
  self end_killcam();
}

function end(final) {
  self.killcam = undefined;
  self callback::function_52ac9652(#"on_end_game", &on_end_game);
  self callback::function_52ac9652(#"on_end_game", &function_f5f2d8e6);
  self thread spectating::set_permissions();
}

function check_for_abrupt_end() {
  self endon(#"disconnect", #"end_killcam");

  while(true) {
    if(self.archivetime <= 0) {
      break;
    }

    waitframe(1);
  }

  self end_killcam();
}

function spawned_killcam_cleanup() {
  self endon(#"end_killcam", #"disconnect");
  self waittill(#"spawned");
  self end(0);
}

function spectator_killcam_cleanup(attacker) {
  self endon(#"end_killcam", #"disconnect");
  attacker endon(#"disconnect");
  waitresult = attacker waittill(#"begin_killcam");
  waittime = max(0, waitresult.start_time - self.deathtime - 50);
  wait waittime;
  self end(0);
}

function on_end_game() {
  if(level.var_7abccc83) {
    self notify(#"game_ended");
    self end(0);
    self[[level.spawnspectator]](0);
  }
}

function function_f5f2d8e6() {
  self notify(#"game_ended");
  self end(1);
}

function cancel_use_button() {
  return self useButtonPressed();
}

function cancel_safe_spawn_button() {
  return self fragButtonPressed();
}

function cancel_callback() {
  self.cancelkillcam = 1;
}

function cancel_safe_spawn_callback() {
  self.cancelkillcam = 1;
  self.wantsafespawn = 1;
}

function cancel_on_use() {
  self thread cancel_on_use_specific_button(&cancel_use_button, &cancel_callback);
}

function cancel_on_use_specific_button(pressingbuttonfunc, finishedfunc) {
  self endon(#"death_delay_finished", #"disconnect", #"game_ended");

  for(;;) {
    if(!self[[pressingbuttonfunc]]()) {
      waitframe(1);
      continue;
    }

    buttontime = 0;

    while(self[[pressingbuttonfunc]]()) {
      buttontime += 0.05;
      waitframe(1);
    }

    if(buttontime >= 0.5) {
      continue;
    }

    buttontime = 0;

    while(!self[[pressingbuttonfunc]]() && buttontime < 0.5) {
      buttontime += 0.05;
      waitframe(1);
    }

    if(buttontime >= 0.5) {
      continue;
    }

    self[[finishedfunc]]();
    return;
  }
}

function final_killcam_internal(winner) {
  winning_team = function_de2b637d(winner);
  killcamsettings = level.finalkillcamsettings[winning_team];
  postdeathdelay = float(gettime() - killcamsettings.deathtime) / 1000;
  predelay = postdeathdelay + killcamsettings.deathtimeoffset;
  killcamentitystarttime = get_killcam_entity_info_starttime(killcamsettings.killcam_entity_info);
  camtime = calc_time(killcamsettings.weapon, killcamentitystarttime, predelay, undefined, killcamsettings.killcam_entity_info.var_30f79181, killcamsettings.meansofdeath);
  postdelay = calc_post_delay();
  killcamoffset = camtime + predelay;
  killcamlength = camtime + postdelay - 0.05;
  killcamstarttime = gettime() - int(killcamoffset * 1000);
  self notify(#"begin_killcam", {
    #start_time: gettime()
  });
  util::setclientsysstate("levelNotify", "sndFKs");
  self.sessionstate = "spectator";
  self.spectatorclient = killcamsettings.spectatorclient;
  self.killcamentity = -1;
  self thread set_killcam_entities(killcamsettings.killcam_entity_info, killcamstarttime);
  self.killcamtargetentity = killcamsettings.targetentityindex;
  self.killcamweapon = killcamsettings.weapon;
  self.killcammod = killcamsettings.meansofdeath;
  self.archivetime = killcamoffset;
  self.killcamlength = killcamlength;
  self.psoffsettime = killcamsettings.offsettime;
  self allowspectateallteams(1);
  self allowspectateteam("freelook", 1);
  self allowspectateteam(#"none", 1);
  self callback::function_d8abfc3d(#"on_end_game", &function_f5f2d8e6);
  waitframe(1);

  if(self.archivetime <= predelay) {
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    self end_killcam();
    return;
  }

  self thread check_for_abrupt_end();
  self.killcam = 1;
  self thread wait_killcam_time();
  self thread wait_final_killcam_slowdown(level.finalkillcamsettings[winning_team].deathtime, killcamstarttime);
  self waittill(#"end_killcam");
}

function final_killcam(winner) {
  self endon(#"disconnect");
  level endon(#"game_ended");

  if(util::waslastround()) {
    setmatchflag("final_killcam", 1);
    setmatchflag("round_end_killcam", 0);
  } else {
    setmatchflag("final_killcam", 0);
    setmatchflag("round_end_killcam", 1);
  }

  if(getdvarint(#"scr_force_finalkillcam", 0) == 1) {
    setmatchflag("<dev string:xe7>", 1);
    setmatchflag("<dev string:xf8>", 0);
  }

  while(getdvarint(#"scr_endless_finalkillcam", 0) == 1) {
    final_killcam_internal(winner);
  }

  luinotifyevent(#"clear_transition");
  luinotifyevent(#"hash_6bb70498f448d405");
  final_killcam_internal(winner);
  util::setclientsysstate("levelNotify", "sndFKe");
  luinotifyevent(#"post_killcam_transition");
  self val::set(#"killcam", "freezecontrols", 1);
  self end(1);
  setmatchflag("final_killcam", 0);
  setmatchflag("round_end_killcam", 0);
  self spawn_end_of_final_killcam();
}

function spawn_end_of_final_killcam() {
  self visionset_mgr::player_shutdown();
}

function is_entity_weapon(weapon) {
  if(weapon.statname == # "planemortar") {
    return true;
  }

  return false;
}

function calc_time(weapon, entitystarttime, predelay, maxtime, var_30f79181, meansofdeath) {
  camtime = 0;

  if(getdvarstring(#"scr_killcam_time") == "") {
    if(meansofdeath == "MOD_EXECUTION") {
      camtime = getdvarfloat(#"hash_239216bd62cd21a6", level.killcamtime);
    } else if((is_entity_weapon(weapon) || var_30f79181 === 1) && entitystarttime > 0) {
      camtime = float(gettime() - entitystarttime) / 1000 - predelay - 0.1;
    } else if(weapon.isgrenadeweapon) {
      camtime = level.var_a95350da;
    } else {
      camtime = level.killcamtime;
    }
  } else {
    camtime = getdvarfloat(#"scr_killcam_time", 0);
  }

  if(isDefined(maxtime)) {
    if(camtime > maxtime) {
      camtime = maxtime;
    }

    if(camtime < 0.05) {
      camtime = 0.05;
    }
  }

  return camtime;
}

function calc_post_delay() {
  postdelay = 0;

  if(getdvarstring(#"scr_killcam_posttime") == "") {
    postdelay = 2;
  } else {
    postdelay = getdvarfloat(#"scr_killcam_posttime", 0);

    if(postdelay < 0.05) {
      postdelay = 0.05;
    }
  }

  return postdelay;
}

function get_closest_killcam_entity(attacker, killcamentities, depth = 0) {
  closestkillcament = undefined;
  closestkillcamentindex = undefined;
  closestkillcamentdist = undefined;
  origin = undefined;

  foreach(killcamentindex, killcament in killcamentities) {
    if(killcament == attacker) {
      continue;
    }

    origin = killcament.origin;

    if(isDefined(killcament.offsetpoint)) {
      origin += killcament.offsetpoint;
    }

    dist = distancesquared(self.origin, origin);

    if(!isDefined(closestkillcament) || dist < closestkillcamentdist) {
      closestkillcament = killcament;
      closestkillcamentdist = dist;
      closestkillcamentindex = killcamentindex;
    }
  }

  if(depth < 3 && isDefined(closestkillcament)) {
    if(!bullettracepassed(closestkillcament.origin, self.origin, 0, self)) {
      killcamentities[closestkillcamentindex] = undefined;
      betterkillcament = get_closest_killcam_entity(attacker, killcamentities, depth + 1);

      if(isDefined(betterkillcament)) {
        closestkillcament = betterkillcament;
      }
    }
  }

  return closestkillcament;
}

function get_killcam_entity(attacker, einflictor, weapon) {
  if(!isDefined(einflictor)) {
    return undefined;
  }

  if(isDefined(self.killcamkilledbyent)) {
    return self.killcamkilledbyent;
  }

  if(isDefined(level.var_93a0cd8f[weapon.name])) {
    var_3808f6bd = level[[level.var_93a0cd8f[weapon.name]]](attacker, einflictor);

    if(isDefined(var_3808f6bd)) {
      return var_3808f6bd;
    }
  }

  if(einflictor == attacker) {
    if(isai(einflictor)) {
      return einflictor;
    }

    if(isvehicle(einflictor) && isDefined(einflictor.killcament)) {
      return einflictor.killcament;
    }

    if(!isDefined(einflictor.ismagicbullet)) {
      return undefined;
    }

    if(isDefined(einflictor.ismagicbullet) && !einflictor.ismagicbullet) {
      return undefined;
    }
  } else if(isDefined(level.levelspecifickillcam)) {
    levelspecifickillcament = self[[level.levelspecifickillcam]]();

    if(isDefined(levelspecifickillcament)) {
      return levelspecifickillcament;
    }
  }

  if(weapon.name == # "hero_gravityspikes") {
    return undefined;
  }

  if(isDefined(attacker) && isPlayer(attacker) && attacker isremotecontrolling() && (einflictor.controlled === 1 || einflictor.occupied === 1)) {
    if(weapon.name == # "sentinel_turret" || weapon.name == # "amws_gun_turret_mp_player" || weapon.name == # "auto_gun_turret") {
      return undefined;
    }
  }

  if(weapon.name == # "dart") {
    return undefined;
  }

  if(isDefined(einflictor.killcament)) {
    if(einflictor.killcament == attacker || is_true(attacker.var_5c5fca5)) {
      return undefined;
    }

    return einflictor.killcament;
  } else if(isDefined(einflictor.killcamentities)) {
    return get_closest_killcam_entity(attacker, einflictor.killcamentities);
  }

  if(isDefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone") {
    return einflictor.killcament;
  }

  if(isai(attacker)) {
    return attacker;
  }

  if(isPlayer(attacker) && isvehicle(einflictor)) {
    if(attacker getvehicleoccupied() === einflictor) {
      if(!attacker isremotecontrolling() || is_true(attacker.var_5c5fca5)) {
        return undefined;
      }
    }
  }

  return einflictor;
}

function get_secondary_killcam_entity(entity, entity_info) {
  if(!isDefined(entity) || !isDefined(entity.killcamentityindex)) {
    return;
  }

  entity_info.entity_indexes[entity_info.entity_indexes.size] = entity.killcamentityindex;
  entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = entity.killcamentitystarttime;
}

function get_primary_killcam_entity(attacker, einflictor, weapon, entity_info) {
  killcamentity = self get_killcam_entity(attacker, einflictor, weapon);

  if(isDefined(level.var_ef3352fc) && isDefined(level.var_ef3352fc[weapon.name])) {
    if(isDefined(einflictor) && isDefined(einflictor.owner) && isDefined(einflictor.owner.killcament)) {
      killcamentity store_killcam_entity_on_entity(einflictor.owner.killcament);
    }
  }

  killcamentitystarttime = get_killcam_entity_start_time(killcamentity);
  killcamentityindex = -1;

  if(isDefined(killcamentity)) {
    killcamentityindex = killcamentity getentitynumber();
  } else {
    var_a5dd317c = self function_af5b3411();

    if(isDefined(var_a5dd317c)) {
      killcamentityindex = var_a5dd317c;
      killcamentitystarttime = self function_cefc1515() - 750;

      if(killcamentitystarttime < 0) {
        killcamentitystarttime = 0;
      }

      entity_info.var_30f79181 = 1;
    }
  }

  entity_info.entity_indexes[entity_info.entity_indexes.size] = killcamentityindex;
  entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = killcamentitystarttime;
  get_secondary_killcam_entity(killcamentity, entity_info);
}

function get_killcam_entity_info(attacker, einflictor, weapon) {
  entity_info = spawnStruct();
  entity_info.entity_indexes = [];
  entity_info.entity_spawntimes = [];
  get_primary_killcam_entity(attacker, einflictor, weapon, entity_info);
  return entity_info;
}

function get_killcam_entity_info_starttime(entity_info) {
  if(entity_info.entity_spawntimes.size == 0) {
    return 0;
  }

  return entity_info.entity_spawntimes[entity_info.entity_spawntimes.size - 1];
}

function function_4789a39a(weaponname, func) {
  level.var_93a0cd8f[weaponname] = func;
}