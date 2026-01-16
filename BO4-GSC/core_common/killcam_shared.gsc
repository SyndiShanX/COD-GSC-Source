/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\killcam_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\weapons\tacticalinsertion;

#namespace killcam;

autoexec __init__system__() {
  system::register(#"killcam", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
}

init() {
  level.killcam = getgametypesetting(#"allowkillcam");
  level.finalkillcam = getgametypesetting(#"allowfinalkillcam");
  level.killcamtime = getgametypesetting(#"killcamtime");
  level.var_a95350da = getgametypesetting(#"hash_154db5a1b2e9d757");
  level.var_7abccc83 = !sessionmodeiswarzonegame();
  init_final_killcam();
}

end_killcam() {
  self.spectatorclient = -1;
  self notify(#"end_killcam");
  self setmodellodbias(0);
}

function_2f7579f(weaponnamehash) {
  if(!isDefined(level.var_ef3352fc)) {
    level.var_ef3352fc = [];
  }

  level.var_ef3352fc[weaponnamehash] = 1;
}

get_killcam_entity_start_time(killcamentity) {
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

store_killcam_entity_on_entity(killcam_entity) {
  assert(isDefined(killcam_entity));
  self.killcamentitystarttime = get_killcam_entity_start_time(killcam_entity);
  self.killcamentityindex = killcam_entity getentitynumber();
}

init_final_killcam() {
  level.finalkillcamsettings = [];
  init_final_killcam_team(#"none");

  foreach(team, _ in level.teams) {
    init_final_killcam_team(team);
  }

  level.finalkillcam_winner = undefined;
  level.finalkillcam_winnerpicked = undefined;
}

init_final_killcam_team(team) {
  level.finalkillcamsettings[team] = spawnStruct();
  clear_final_killcam_team(team);
}

clear_final_killcam_team(team) {
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

record_settings(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
  if(isDefined(attacker) && isDefined(attacker.team) && isDefined(level.teams[attacker.team])) {
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

function_eb3deeec(spectatorclient, targetentityindex, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, perks, killstreaks, attacker) {
  player = self;

  if(spectatorclient == -1) {
    spectatorclient = player getentitynumber();
  }

  player.var_e59bd911 = {
    #spectatorclient: spectatorclient, 
    #weapon: weapon, 
    #meansofdeath: meansofdeath, 
    #deathtime: deathtime, 
    #deathtimeoffset: deathtimeoffset, 
    #offsettime: offsettime, 
    #killcam_entity_info: killcam_entity_info, 
    #targetentityindex: targetentityindex, 
    #perks: perks, 
    #killstreaks: killstreaks, 
    #attacker: attacker
  };
}

has_deathcam() {
  return isDefined(self.var_e59bd911);
}

start_deathcam() {
  if(!self has_deathcam()) {
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    return false;
  }

  if(isDefined(self.var_e5681505) && self.var_e5681505) {
    return false;
  }

  self thread deathcam(self);
  return true;
}

deathcam(victim) {
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
}

erase_final_killcam() {
  clear_final_killcam_team(#"none");

  foreach(team, _ in level.teams) {
    clear_final_killcam_team(team);
  }

  level.finalkillcam_winner = undefined;
  level.finalkillcam_winnerpicked = undefined;
}

final_killcam_waiter() {
  if(level.finalkillcam_winnerpicked === 1) {
    level waittill(#"final_killcam_done");
  }
}

post_round_final_killcam() {
  if(!level.finalkillcam) {
    return;
  }

  level notify(#"play_final_killcam");
  final_killcam_waiter();
}

function_a26057ee() {
  if(potm::function_ec01de3()) {
    println("<dev string:x38>");
    return;
  }

  post_round_final_killcam();
}

function_de2b637d(winner) {
  if(!isDefined(winner)) {
    return #"none";
  }

  if(isentity(winner)) {
    return (isDefined(winner.team) ? winner.team : #"none");
  }

  return winner;
}

do_final_killcam() {
  level waittill(#"play_final_killcam");
  setslowmotion(1, 1, 0);
  level.infinalkillcam = 1;
  winner = #"none";

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

    if(!function_8b1a219a()) {
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

are_any_players_watching() {
  players = level.players;

  for(index = 0; index < players.size; index++) {
    player = players[index];

    if(isDefined(player.killcam)) {
      return true;
    }
  }

  return false;
}

watch_for_skip_killcam() {
  self endon(#"begin_killcam");
  self waittill(#"disconnect", #"spawned");
  waitframe(1);
  level.numplayerswaitingtoenterkillcam--;
}

killcam(attackernum, targetnum, killcam_entity_info, weapon, meansofdeath, deathtime, deathtimeoffset, offsettime, respawn, maxtime, perks, killstreaks, attacker, keep_deathcam) {
  self endon(#"disconnect", #"spawned", #"game_ended");

  if(attackernum < 0) {
    return;
  }

  self thread watch_for_skip_killcam();
  self callback::function_52ac9652(#"on_end_game", &on_end_game, undefined, 1);
  self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
  level.numplayerswaitingtoenterkillcam++;

  if(level.numplayerswaitingtoenterkillcam > 1) {
    println("<dev string:x80>");
    waitframe(level.numplayerswaitingtoenterkillcam - 1);
  }

  waitframe(1);
  level.numplayerswaitingtoenterkillcam--;

  if(!function_7f088568()) {
    println("<dev string:xbd>");

    while(!function_7f088568()) {
      waitframe(1);
    }
  }

  assert(level.numplayerswaitingtoenterkillcam > -1);
  postdeathdelay = float(gettime() - deathtime) / 1000;
  predelay = postdeathdelay + deathtimeoffset;
  killcamentitystarttime = get_killcam_entity_info_starttime(killcam_entity_info);
  camtime = calc_time(weapon, killcamentitystarttime, predelay, maxtime);
  postdelay = calc_post_delay();
  killcamlength = camtime + postdelay;

  if(isDefined(maxtime) && killcamlength > maxtime) {
    if(maxtime < 2) {
      return;
    }

    if(maxtime - camtime >= 1) {
      postdelay = maxtime - camtime;
    } else {
      postdelay = 1;
      camtime = maxtime - 1;
    }

    killcamlength = camtime + postdelay;
  }

  killcamoffset = camtime + predelay;
  self notify(#"begin_killcam", {
    #start_time: gettime()
  });

  if(isDefined(weapon) && weapon.name === #"straferun_rockets") {
    self setmodellodbias(8);
  }

  self util::clientnotify("sndDEDe");
  killcamstarttime = gettime() - int(killcamoffset * 1000);
  self.sessionstate = "spectator";
  self.spectatekillcam = 1;
  self.spectatorclient = attackernum;
  self.killcamentity = -1;
  self thread set_killcam_entities(killcam_entity_info, killcamstarttime);
  self.killcamtargetentity = targetnum;
  self.killcamweapon = weapon;
  self.killcammod = meansofdeath;
  self.archivetime = killcamoffset;
  self.killcamlength = killcamlength;
  self.psoffsettime = offsettime;

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
  self thread tacticalinsertion::cancel_button_think();
  self waittill(#"end_killcam");
  self end(0);

  if(isDefined(keep_deathcam) && keep_deathcam) {
    return;
  }

  self.sessionstate = "dead";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
}

set_entity(killcamentityindex, delayms) {
  self endon(#"disconnect", #"end_killcam", #"spawned");

  if(delayms > 0) {
    wait float(delayms) / 1000;
  }

  self.killcamentity = killcamentityindex;
}

set_killcam_entities(entity_info, killcamstarttime) {
  for(index = 0; index < entity_info.entity_indexes.size; index++) {
    delayms = entity_info.entity_spawntimes[index] - killcamstarttime - 100;
    thread set_entity(entity_info.entity_indexes[index], delayms);

    if(delayms <= 0) {
      return;
    }
  }
}

wait_killcam_time() {
  self endon(#"disconnect", #"end_killcam", #"begin_killcam");
  wait self.killcamlength - 0.05;
  self end_killcam();
}

wait_final_killcam_slowdown(deathtime, starttime) {
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

function_875fc588() {
  if(!isDefined(self.killcamsskipped)) {
    self.killcamsskipped = 0;
  }

  self.killcamsskipped++;
  self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
  self end_killcam();
  self util::clientnotify("fkce");
}

wait_skip_killcam_button() {
  self endon(#"disconnect", #"end_killcam");

  while(self usebuttonpressed()) {
    waitframe(1);
  }

  while(!self usebuttonpressed()) {
    waitframe(1);
  }

  if(!(isDefined(self.var_eca4c67f) && self.var_eca4c67f)) {
    function_875fc588();
  }
}

function_fa405b23() {
  self endon(#"disconnect", #"end_killcam");

  while(self jumpbuttonpressed()) {
    waitframe(1);
  }

  while(!self jumpbuttonpressed()) {
    waitframe(1);
  }

  if(!(isDefined(self.var_eca4c67f) && self.var_eca4c67f)) {
    function_875fc588();
  }
}

wait_team_change_end_killcam() {
  self endon(#"disconnect", #"end_killcam");
  self waittill(#"changed_class", #"joined_team");
  end(0);
  self end_killcam();
}

wait_skip_killcam_safe_spawn_button() {
  self endon(#"disconnect", #"end_killcam");

  while(self fragbuttonpressed()) {
    waitframe(1);
  }

  while(!self fragbuttonpressed()) {
    waitframe(1);
  }

  self.wantsafespawn = 1;
  self end_killcam();
}

end(final) {
  self.killcam = undefined;
  self callback::function_52ac9652(#"on_end_game", &on_end_game);
  self callback::function_52ac9652(#"on_end_game", &function_f5f2d8e6);
  self thread spectating::set_permissions();
}

check_for_abrupt_end() {
  self endon(#"disconnect", #"end_killcam");

  while(true) {
    if(self.archivetime <= 0) {
      break;
    }

    waitframe(1);
  }

  self end_killcam();
}

spawned_killcam_cleanup() {
  self endon(#"end_killcam", #"disconnect");
  self waittill(#"spawned");
  self end(0);
}

spectator_killcam_cleanup(attacker) {
  self endon(#"end_killcam", #"disconnect");
  attacker endon(#"disconnect");
  waitresult = attacker waittill(#"begin_killcam");
  waittime = max(0, waitresult.start_time - self.deathtime - 50);
  wait waittime;
  self end(0);
}

on_end_game() {
  if(level.var_7abccc83) {
    self notify(#"game_ended");
    self end(0);
    self[[level.spawnspectator]](0);
  }
}

function_f5f2d8e6() {
  self notify(#"game_ended");
  self end(1);
}

cancel_use_button() {
  return self usebuttonpressed();
}

cancel_safe_spawn_button() {
  return self fragbuttonpressed();
}

cancel_callback() {
  self.cancelkillcam = 1;
}

cancel_safe_spawn_callback() {
  self.cancelkillcam = 1;
  self.wantsafespawn = 1;
}

cancel_on_use() {
  self thread cancel_on_use_specific_button(&cancel_use_button, &cancel_callback);
}

cancel_on_use_specific_button(pressingbuttonfunc, finishedfunc) {
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

final_killcam_internal(winner) {
  winning_team = function_de2b637d(winner);
  killcamsettings = level.finalkillcamsettings[winning_team];
  postdeathdelay = float(gettime() - killcamsettings.deathtime) / 1000;
  predelay = postdeathdelay + killcamsettings.deathtimeoffset;
  killcamentitystarttime = get_killcam_entity_info_starttime(killcamsettings.killcam_entity_info);
  camtime = calc_time(killcamsettings.weapon, killcamentitystarttime, predelay, undefined);
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

final_killcam(winner) {
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
    setmatchflag("<dev string:xe4>", 1);
    setmatchflag("<dev string:xf4>", 0);
  }

  while(getdvarint(#"scr_endless_finalkillcam", 0) == 1) {
    final_killcam_internal(winner);
  }

  final_killcam_internal(winner);
  util::setclientsysstate("levelNotify", "sndFKe");
  luinotifyevent(#"post_killcam_transition");
  self val::set(#"killcam", "freezecontrols", 1);
  self end(1);
  setmatchflag("final_killcam", 0);
  setmatchflag("round_end_killcam", 0);
  self spawn_end_of_final_killcam();
}

spawn_end_of_final_killcam() {
  self visionset_mgr::player_shutdown();
}

is_entity_weapon(weapon) {
  if(weapon.statname == #"planemortar") {
    return true;
  }

  return false;
}

calc_time(weapon, entitystarttime, predelay, maxtime) {
  camtime = 0;

  if(getdvarstring(#"scr_killcam_time") == "") {
    if(is_entity_weapon(weapon)) {
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

calc_post_delay() {
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

get_closest_killcam_entity(attacker, killcamentities, depth = 0) {
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

get_killcam_entity(attacker, einflictor, weapon) {
  if(!isDefined(einflictor)) {
    return undefined;
  }

  if(isDefined(self.killcamkilledbyent)) {
    return self.killcamkilledbyent;
  }

  if(einflictor == attacker) {
    if(isai(einflictor)) {
      return einflictor;
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

  if(weapon.name == #"hero_gravityspikes") {
    return undefined;
  }

  if(isDefined(attacker) && isplayer(attacker) && attacker isremotecontrolling() && (einflictor.controlled === 1 || einflictor.occupied === 1)) {
    if(weapon.name == #"sentinel_turret" || weapon.name == #"amws_gun_turret_mp_player" || weapon.name == #"auto_gun_turret") {
      return undefined;
    }
  }

  if(weapon.name == #"dart") {
    return undefined;
  }

  if(isDefined(einflictor.killcament)) {
    if(einflictor.killcament == attacker) {
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

  if(isplayer(attacker)) {
    if(attacker function_a867284b()) {
      return undefined;
    }

    if(isvehicle(einflictor) && attacker.viewlockedentity === einflictor) {
      if(attacker.vehicleposition >= 1 && attacker.vehicleposition <= 4) {
        return undefined;
      }
    }
  }

  return einflictor;
}

get_secondary_killcam_entity(entity, entity_info) {
  if(!isDefined(entity) || !isDefined(entity.killcamentityindex)) {
    return;
  }

  entity_info.entity_indexes[entity_info.entity_indexes.size] = entity.killcamentityindex;
  entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = entity.killcamentitystarttime;
}

get_primary_killcam_entity(attacker, einflictor, weapon, entity_info) {
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
  }

  entity_info.entity_indexes[entity_info.entity_indexes.size] = killcamentityindex;
  entity_info.entity_spawntimes[entity_info.entity_spawntimes.size] = killcamentitystarttime;
  get_secondary_killcam_entity(killcamentity, entity_info);
}

get_killcam_entity_info(attacker, einflictor, weapon) {
  entity_info = spawnStruct();
  entity_info.entity_indexes = [];
  entity_info.entity_spawntimes = [];
  get_primary_killcam_entity(attacker, einflictor, weapon, entity_info);
  return entity_info;
}

get_killcam_entity_info_starttime(entity_info) {
  if(entity_info.entity_spawntimes.size == 0) {
    return 0;
  }

  return entity_info.entity_spawntimes[entity_info.entity_spawntimes.size - 1];
}