/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_killcam.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\_tacticalinsertion;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_globallogic_spawn;
#using scripts\cp\gametypes\_spectating;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_tacticalinsertion;
#namespace killcam;

function autoexec __init__sytem__() {
  system::register("killcam", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
}

function init() {
  if(level.gametype === "coop") {
    level.killcam = getgametypesetting("allowKillcam");
    level.finalkillcam = getgametypesetting("allowFinalKillcam");
    level.var_3a9f9a38 = 0;
    init_final_killcam();
  }
}

function init_final_killcam() {
  level.finalkillcamsettings = [];
  init_final_killcam_team("none");
  foreach(team in level.teams) {
    init_final_killcam_team(team);
  }
  level.finalkillcam_winner = undefined;
}

function init_final_killcam_team(team) {
  level.finalkillcamsettings[team] = spawnStruct();
  clear_final_killcam_team(team);
}

function clear_final_killcam_team(team) {
  level.finalkillcamsettings[team].spectatorclient = undefined;
  level.finalkillcamsettings[team].weapon = undefined;
  level.finalkillcamsettings[team].deathtime = undefined;
  level.finalkillcamsettings[team].deathtimeoffset = undefined;
  level.finalkillcamsettings[team].offsettime = undefined;
  level.finalkillcamsettings[team].entityindex = undefined;
  level.finalkillcamsettings[team].targetentityindex = undefined;
  level.finalkillcamsettings[team].entitystarttime = undefined;
  level.finalkillcamsettings[team].perks = undefined;
  level.finalkillcamsettings[team].killstreaks = undefined;
  level.finalkillcamsettings[team].attacker = undefined;
}

function record_settings(spectatorclient, targetentityindex, weapon, deathtime, deathtimeoffset, offsettime, entityindex, entitystarttime, perks, killstreaks, attacker) {
  if(level.teambased && isDefined(attacker.team) && isDefined(level.teams[attacker.team])) {
    team = attacker.team;
    level.finalkillcamsettings[team].spectatorclient = spectatorclient;
    level.finalkillcamsettings[team].weapon = weapon;
    level.finalkillcamsettings[team].deathtime = deathtime;
    level.finalkillcamsettings[team].deathtimeoffset = deathtimeoffset;
    level.finalkillcamsettings[team].offsettime = offsettime;
    level.finalkillcamsettings[team].entityindex = entityindex;
    level.finalkillcamsettings[team].targetentityindex = targetentityindex;
    level.finalkillcamsettings[team].entitystarttime = entitystarttime;
    level.finalkillcamsettings[team].perks = perks;
    level.finalkillcamsettings[team].killstreaks = killstreaks;
    level.finalkillcamsettings[team].attacker = attacker;
  }
  level.finalkillcamsettings["none"].spectatorclient = spectatorclient;
  level.finalkillcamsettings["none"].weapon = weapon;
  level.finalkillcamsettings["none"].deathtime = deathtime;
  level.finalkillcamsettings["none"].deathtimeoffset = deathtimeoffset;
  level.finalkillcamsettings["none"].offsettime = offsettime;
  level.finalkillcamsettings["none"].entityindex = entityindex;
  level.finalkillcamsettings["none"].targetentityindex = targetentityindex;
  level.finalkillcamsettings["none"].entitystarttime = entitystarttime;
  level.finalkillcamsettings["none"].perks = perks;
  level.finalkillcamsettings["none"].killstreaks = killstreaks;
  level.finalkillcamsettings["none"].attacker = attacker;
}

function erase_final_killcam() {
  clear_final_killcam_team("none");
  foreach(team in level.teams) {
    clear_final_killcam_team(team);
  }
  level.finalkillcam_winner = undefined;
}

function final_killcam_waiter() {
  if(!isDefined(level.finalkillcam_winner)) {
    return false;
  }
  level waittill("final_killcam_done");
  return true;
}

function post_round_final_killcam() {
  if(isDefined(level.sidebet) && level.sidebet) {
    return;
  }
  level notify("play_final_killcam");
  globallogic::resetoutcomeforallplayers();
  final_killcam_waiter();
}

function do_final_killcam() {
  level waittill("play_final_killcam");
  level.infinalkillcam = 1;
  winner = "none";
  if(isDefined(level.finalkillcam_winner)) {
    winner = level.finalkillcam_winner;
  }
  if(!isDefined(level.finalkillcamsettings[winner].targetentityindex)) {
    level.infinalkillcam = 0;
    level notify("final_killcam_done");
    return;
  }
  if(isDefined(level.finalkillcamsettings[winner].attacker)) {
    challenges::getfinalkill(level.finalkillcamsettings[winner].attacker);
  }
  visionsetnaked(getdvarstring("mapname"), 0);
  players = level.players;
  for(index = 0; index < players.size; index++) {
    player = players[index];
    player closeingamemenu();
    player thread final_killcam(winner);
  }
  wait(0.1);
  while(are_any_players_watching()) {
    wait(0.05);
  }
  level notify("final_killcam_done");
  level.infinalkillcam = 0;
}

function startlastkillcam() {}

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

function killcam(attackernum, targetnum, killcamentity, killcamentityindex, killcamentitystarttime, weapon, deathtime, deathtimeoffset, offsettime, respawn, maxtime, perks, killstreaks, attacker, body) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  if(isDefined(body)) {
    codesetclientfield(body, "hide_body", 0);
  }
  if(killcamentityindex < 0 || killcamentityindex === targetnum) {
    self notify("end_killcam");
    return;
  }
  postdeathdelay = (gettime() - deathtime) / 1000;
  predelay = postdeathdelay + deathtimeoffset;
  camtime = calc_time(weapon, killcamentitystarttime, predelay, respawn, maxtime);
  postdelay = calc_post_delay();
  killcamlength = camtime + postdelay;
  if(isDefined(maxtime) && killcamlength > maxtime) {
    if(maxtime < 2) {
      return;
    }
    if((maxtime - camtime) >= 1) {
      postdelay = maxtime - camtime;
    } else {
      postdelay = 1;
      camtime = maxtime - 1;
    }
    killcamlength = camtime + postdelay;
  }
  killcamoffset = camtime + predelay;
  self notify("begin_killcam", gettime());
  killcamstarttime = gettime() - (killcamoffset * 1000);
  self.sessionstate = "spectator";
  self.spectatorclient = attackernum;
  self.killcamentity = -1;
  if(killcamentityindex >= 0) {
    self thread set_entity(killcamentityindex, (killcamentitystarttime - killcamstarttime) - 100);
  }
  self.killcamtargetentity = targetnum;
  self.archivetime = killcamoffset;
  self.killcamlength = killcamlength;
  self.psoffsettime = offsettime;
  self.var_7b6b6cbb = camtime;
  self.var_1c362abb = self.killcamlength - camtime;
  foreach(team in level.teams) {
    self allowspectateteam(team, 1);
  }
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
  self thread ended_killcam_cleanup();
  wait(0.05);
  if(self.archivetime <= predelay) {
    self.sessionstate = "spectator";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self notify("end_killcam");
    return;
  }
  self thread check_for_abrupt_end();
  self.killcam = 1;
  if(!self issplitscreen() && level.perksenabled == 1) {
    self add_timer(camtime);
    self hud::showperks();
  }
  self thread spawned_killcam_cleanup();
  self thread wait_team_change_end_killcam();
  self thread wait_killcam_time();
  self thread function_6cc9650b();
  self thread tacticalinsertion::cancel_button_think();
  self waittill("end_killcam");
  self.var_acfedf1c = undefined;
  self.var_ebd83169 = undefined;
  self end(0);
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
}

function set_entity(killcamentityindex, delayms) {
  self endon("disconnect");
  self endon("end_killcam");
  self endon("spawned");
  if(delayms > 0) {
    wait(delayms / 1000);
  }
  self.killcamentity = killcamentityindex;
}

function wait_killcam_time() {
  self endon("disconnect");
  self endon("end_killcam");
  wait(self.killcamlength - 0.05);
  self notify("end_killcam");
}

function function_6cc9650b() {
  self endon("disconnect");
  self endon("end_killcam");
  wait(self.var_7b6b6cbb - 0.05);
  self notify("hash_4cb3b8de");
}

function wait_final_killcam_slowdown(deathtime, starttime) {
  self endon("disconnect");
  self endon("end_killcam");
  secondsuntildeath = (deathtime - starttime) / 1000;
  deathtime = gettime() + (secondsuntildeath * 1000);
  waitbeforedeath = 2;
  util::setclientsysstate("levelNotify", "fkcb");
  wait(max(0, secondsuntildeath - waitbeforedeath));
  setslowmotion(1, 0.25, waitbeforedeath);
  wait(waitbeforedeath + 0.5);
  setslowmotion(0.25, 1, 1);
  wait(0.5);
  util::setclientsysstate("levelNotify", "fkce");
}

function wait_skip_killcam_button() {
  self endon("disconnect");
  self endon("end_killcam");
  while(self usebuttonpressed()) {
    wait(0.05);
  }
  while(!self usebuttonpressed()) {
    wait(0.05);
  }
  self notify("end_killcam");
  self util::clientnotify("fkce");
}

function wait_team_change_end_killcam() {
  self endon("disconnect");
  self endon("end_killcam");
  self waittill("changed_class");
  end(0);
}

function wait_skip_killcam_safe_spawn_button() {
  self endon("disconnect");
  self endon("end_killcam");
  while(self fragbuttonpressed()) {
    wait(0.05);
  }
  while(!self fragbuttonpressed()) {
    wait(0.05);
  }
  self.wantsafespawn = 1;
  self notify("end_killcam");
}

function end(final) {
  if(isDefined(self.kc_skiptext)) {
    self.kc_skiptext.alpha = 0;
  }
  if(isDefined(self.kc_timer)) {
    self.kc_timer.alpha = 0;
  }
  self.killcam = undefined;
  self thread spectating::set_permissions();
}

function check_for_abrupt_end() {
  self endon("disconnect");
  self endon("end_killcam");
  while(true) {
    if(self.archivetime <= 0) {
      break;
    }
    wait(0.05);
  }
  self notify("end_killcam");
}

function spawned_killcam_cleanup() {
  self endon("end_killcam");
  self endon("disconnect");
  self waittill("spawned");
  self end(0);
}

function spectator_killcam_cleanup(attacker) {
  self endon("end_killcam");
  self endon("disconnect");
  attacker endon("disconnect");
  attacker waittill("begin_killcam", attackerkcstarttime);
  waittime = max(0, (attackerkcstarttime - self.deathtime) - 50);
  wait(waittime);
  self end(0);
}

function ended_killcam_cleanup() {
  self endon("end_killcam");
  self endon("disconnect");
  level waittill("game_ended");
  self end(0);
}

function ended_final_killcam_cleanup() {
  self endon("end_killcam");
  self endon("disconnect");
  level waittill("game_ended");
  self end(1);
}

function cancel_use_button() {
  return self usebuttonpressed();
}

function cancel_safe_spawn_button() {
  return self fragbuttonpressed();
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
  self endon("death_delay_finished");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    if(!self[[pressingbuttonfunc]]()) {
      wait(0.05);
      continue;
    }
    buttontime = 0;
    while(self[[pressingbuttonfunc]]()) {
      buttontime = buttontime + 0.05;
      wait(0.05);
    }
    if(buttontime >= 0.5) {
      continue;
    }
    buttontime = 0;
    while(!self[[pressingbuttonfunc]]() && buttontime < 0.5) {
      buttontime = buttontime + 0.05;
      wait(0.05);
    }
    if(buttontime >= 0.5) {
      continue;
    }
    self[[finishedfunc]]();
    return;
  }
}

function final_killcam(winner) {
  self endon("disconnect");
  level endon("game_ended");
  if(util::waslastround()) {
    setmatchflag("final_killcam", 1);
    setmatchflag("round_end_killcam", 0);
  } else {
    setmatchflag("final_killcam", 0);
    setmatchflag("round_end_killcam", 1);
  }
  if(getdvarint("") == 1) {
    setmatchflag("", 1);
    setmatchflag("", 0);
  }
  if(level.console) {
    self globallogic_spawn::setthirdperson(0);
  }
  killcamsettings = level.finalkillcamsettings[winner];
  postdeathdelay = (gettime() - killcamsettings.deathtime) / 1000;
  predelay = postdeathdelay + killcamsettings.deathtimeoffset;
  camtime = calc_time(killcamsettings.weapon, killcamsettings.entitystarttime, predelay, 0, undefined);
  postdelay = calc_post_delay();
  killcamoffset = camtime + predelay;
  killcamlength = (camtime + postdelay) - 0.05;
  killcamstarttime = gettime() - (killcamoffset * 1000);
  self notify("begin_killcam", gettime());
  self.sessionstate = "spectator";
  self.spectatorclient = killcamsettings.spectatorclient;
  self.killcamentity = -1;
  if(killcamsettings.entityindex >= 0) {
    self thread set_entity(killcamsettings.entityindex, (killcamsettings.entitystarttime - killcamstarttime) - 100);
  }
  self.killcamtargetentity = killcamsettings.targetentityindex;
  self.archivetime = killcamoffset;
  self.killcamlength = killcamlength;
  self.psoffsettime = killcamsettings.offsettime;
  foreach(team in level.teams) {
    self allowspectateteam(team, 1);
  }
  self allowspectateteam("freelook", 1);
  self allowspectateteam("none", 1);
  self thread ended_final_killcam_cleanup();
  wait(0.05);
  if(self.archivetime <= predelay) {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self notify("end_killcam");
    return;
  }
  self thread check_for_abrupt_end();
  self.killcam = 1;
  if(!self issplitscreen()) {
    self add_timer(camtime);
  }
  self thread wait_killcam_time();
  self thread wait_final_killcam_slowdown(level.finalkillcamsettings[winner].deathtime, killcamstarttime);
  self waittill("end_killcam");
  self end(1);
  setmatchflag("final_killcam", 0);
  setmatchflag("round_end_killcam", 0);
  self spawn_end_of_final_killcam();
}

function spawn_end_of_final_killcam() {
  [[level.spawnspectator]]();
  self freezecontrols(1);
}

function is_entity_weapon(weapon) {
  if(weapon.name == "planemortar") {
    return true;
  }
  return false;
}

function calc_time(weapon, entitystarttime, predelay, respawn, maxtime) {
  camtime = 0;
  if(getdvarstring("scr_killcam_time") == "") {
    if(is_entity_weapon(weapon)) {
      camtime = (((gettime() - entitystarttime) / 1000) - predelay) - 0.1;
    } else {
      if(!respawn) {
        camtime = 5;
      } else {
        if(weapon.isgrenadeweapon) {
          camtime = 4.25;
        } else {
          camtime = 2.5;
        }
      }
    }
  } else {
    camtime = getdvarfloat("scr_killcam_time");
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
  if(getdvarstring("scr_killcam_posttime") == "") {
    postdelay = 2;
  } else {
    postdelay = getdvarfloat("scr_killcam_posttime");
    if(postdelay < 0.05) {
      postdelay = 0.05;
    }
  }
  return postdelay;
}

function add_skip_text(respawn) {
  if(!isDefined(self.kc_skiptext)) {
    self.kc_skiptext = newclienthudelem(self);
    self.kc_skiptext.archived = 0;
    self.kc_skiptext.x = 0;
    self.kc_skiptext.alignx = "center";
    self.kc_skiptext.aligny = "middle";
    self.kc_skiptext.horzalign = "center";
    self.kc_skiptext.vertalign = "bottom";
    self.kc_skiptext.sort = 1;
    self.kc_skiptext.font = "objective";
  }
  if(self issplitscreen()) {
    self.kc_skiptext.y = -100;
    self.kc_skiptext.fontscale = 1.4;
  } else {
    self.kc_skiptext.y = -120;
    self.kc_skiptext.fontscale = 2;
  }
  if(respawn) {
    self.kc_skiptext settext(&"PLATFORM_PRESS_TO_RESPAWN");
  } else {
    self.kc_skiptext settext(&"PLATFORM_PRESS_TO_SKIP");
  }
  self.kc_skiptext.alpha = 1;
}

function add_timer(camtime) {}

function init_kc_elements() {
  if(!isDefined(self.kc_skiptext)) {
    self.kc_skiptext = newclienthudelem(self);
    self.kc_skiptext.archived = 0;
    self.kc_skiptext.x = 0;
    self.kc_skiptext.alignx = "center";
    self.kc_skiptext.aligny = "top";
    self.kc_skiptext.horzalign = "center_adjustable";
    self.kc_skiptext.vertalign = "top_adjustable";
    self.kc_skiptext.sort = 1;
    self.kc_skiptext.font = "default";
    self.kc_skiptext.foreground = 1;
    self.kc_skiptext.hidewheninmenu = 1;
    if(self issplitscreen()) {
      self.kc_skiptext.y = 20;
      self.kc_skiptext.fontscale = 1.2;
    } else {
      self.kc_skiptext.y = 32;
      self.kc_skiptext.fontscale = 1.8;
    }
  }
  if(!isDefined(self.kc_othertext)) {
    self.kc_othertext = newclienthudelem(self);
    self.kc_othertext.archived = 0;
    self.kc_othertext.y = 48;
    self.kc_othertext.alignx = "left";
    self.kc_othertext.aligny = "top";
    self.kc_othertext.horzalign = "center";
    self.kc_othertext.vertalign = "middle";
    self.kc_othertext.sort = 10;
    self.kc_othertext.font = "small";
    self.kc_othertext.foreground = 1;
    self.kc_othertext.hidewheninmenu = 1;
    if(self issplitscreen()) {
      self.kc_othertext.x = 16;
      self.kc_othertext.fontscale = 1.2;
    } else {
      self.kc_othertext.x = 32;
      self.kc_othertext.fontscale = 1.6;
    }
  }
  if(!isDefined(self.kc_icon)) {
    self.kc_icon = newclienthudelem(self);
    self.kc_icon.archived = 0;
    self.kc_icon.x = 16;
    self.kc_icon.y = 16;
    self.kc_icon.alignx = "left";
    self.kc_icon.aligny = "top";
    self.kc_icon.horzalign = "center";
    self.kc_icon.vertalign = "middle";
    self.kc_icon.sort = 1;
    self.kc_icon.foreground = 1;
    self.kc_icon.hidewheninmenu = 1;
  }
  if(!self issplitscreen()) {
    if(!isDefined(self.kc_timer)) {
      self.kc_timer = hud::createfontstring("hudbig", 1);
      self.kc_timer.archived = 0;
      self.kc_timer.x = 0;
      self.kc_timer.alignx = "center";
      self.kc_timer.aligny = "middle";
      self.kc_timer.horzalign = "center_safearea";
      self.kc_timer.vertalign = "top_adjustable";
      self.kc_timer.y = 42;
      self.kc_timer.sort = 1;
      self.kc_timer.font = "hudbig";
      self.kc_timer.foreground = 1;
      self.kc_timer.color = vectorscale((1, 1, 1), 0.85);
      self.kc_timer.hidewheninmenu = 1;
    }
  }
}