/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\player_utility.gsc
****************************************************/

#using script_cbb0697de4c5728;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace player_utility;

function isenemy(other) {
  if(level.teambased) {
    if(isDefined(other.team) && isDefined(self.team)) {
      return (other.team != self.team);
    } else {
      assertmsg("<dev string:x24>");
      return 1;
    }

    return;
  }

  if(isDefined(other.owner)) {
    return (other.owner != self);
  }

  return other != self;
}

function getvehicle(var_193f2bb22e471663) {
  if(vehicle::is_in_vehicle()) {
    return self.vehicle;
  } else if(var_193f2bb22e471663) {
    return self.externalvehicle;
  }

  return undefined;
}

function function_c0192d3e90f65e0e(player) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return false;
  }

  return player vehicle::is_in_vehicle(1) || isDefined(player getmovingplatformparent());
}

function getteamarray(team, includeagents) {
  teamarray = [];

  if(!isDefined(includeagents) || includeagents) {
    foreach(player in level.characters) {
      if(player.team === team) {
        teamarray[teamarray.size] = player;
      }
    }
  } else {
    foreach(player in level.players) {
      if(player.team === team) {
        teamarray[teamarray.size] = player;
      }
    }
  }

  return teamarray;
}

function _freezecontrols(frozen, force, debug) {
  var_32dbca3143d9c4a5 = level.sharedfuncs[#"player"][#"freezecontrols"];

  if(isDefined(var_32dbca3143d9c4a5)) {
    self[[var_32dbca3143d9c4a5]](frozen, force, debug);
  }
}

function function_b8d64912ebafb09() {
  var_32dbca3143d9c4a5 = level.sharedfuncs[#"player"][#"freezeControlsDebug"];

  if(isDefined(var_32dbca3143d9c4a5)) {
    self[[var_32dbca3143d9c4a5]]();
  }
}

function _freezelookcontrols(frozen, force) {
  var_32dbca3143d9c4a5 = level.sharedfuncs[#"player"][#"freezelookcontrols"];

  if(isDefined(var_32dbca3143d9c4a5)) {
    self[[var_32dbca3143d9c4a5]](frozen, force);
  }
}

function getplayersuperfaction(player) {
  playersuperfaction = 0;

  if(isDefined(player.operatorcustomization)) {
    playersuperfaction = player.operatorcustomization.superfaction;
  }

  return playersuperfaction;
}

function setthermalvision(bool, fstop, focusdistance) {
  if(bool) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(fstop, focusdistance, 20, 20);
    self thermalvisionon();
    return;
  }

  self disablephysicaldepthoffieldscripting();
  self thermalvisionoff();
}

function watchthermalinputchange(inairvehicle, var_41b147ca23b7366e) {
  self notify("watch_thermal_input_change");
  self endon("watch_thermal_input_change");
  self endon("disconnect");

  while(true) {
    var_57d1116398f2b84e = var_41b147ca23b7366e ?? getthermalswitchplayercommand(inairvehicle);
    self notifyonplayercommand("switch_thermal_mode", var_57d1116398f2b84e);
    returnednotif = utility::waittill_any_return_no_endon_death("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", var_57d1116398f2b84e);

    if(!isDefined(returnednotif) || returnednotif == "thermal_handling_ended") {
      break;
    }
  }
}

function stopwatchingthermalinputchange() {
  self notify("thermal_handling_ended");
}

function getthermalswitchplayercommand(inairvehicle) {
  if(utility::is_player_gamepad_enabled()) {
    if(inairvehicle) {
      return "+stance";
    }

    return "+gostand";
  }

  return "nightvision";
}

function enabledemeanorsafe() {
  if(!isDefined(self.demeanorsafeenabled)) {
    self.demeanorsafeenabled = 0;
  }

  self.demeanorsafeenabled++;

  if(self.demeanorsafeenabled == 1) {
    forcedemeanorsafe(1);
  }
}

function disabledemeanorsafe() {
  assert(self.demeanorsafeenabled > 0, "<dev string:x65>");
  self.demeanorsafeenabled--;

  if(self.demeanorsafeenabled == 0) {
    self.demeanorsafeenabled = undefined;
    forcedemeanorsafe(0);
  }
}

function forcedemeanorsafe(bool) {
  if(bool && self getdemeanorviewmodel() != "safe") {
    thread forcedemeanorsafeinteral(bool);
    return;
  }

  if(!bool && self getdemeanorviewmodel() == "safe") {
    thread forcedemeanorsafeinteral(bool);
  }
}

function forcedemeanorsafeinteral(bool) {
  self endon("death_or_disconnect");
  self notify("forceDemeanorSafeInteral");
  self endon("forceDemeanorSafeInteral");
  wassprinting = self issprinting();

  if(!self.demeanorsprintdisable) {
    val::set("forceDemeanor", "sprint", 0);
    self.demeanorsprintdisable = 1;
  }

  if(wassprinting) {
    wait 0.5;
  }

  if(bool) {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
  } else {
    self setdemeanorviewmodel("normal");
  }

  wait 0.5;

  if(self.demeanorsprintdisable) {
    val::reset_all("forceDemeanor");
    self.demeanorsprintdisable = undefined;
  }
}

function cleardemeanorsafe() {
  self.demeanorsafeenabled = undefined;
  self.demeanorsprintdisable = undefined;
}

function playersareenemies(firstplayer, secondplayer) {
  return level.teambased ? isDefined(firstplayer.team) && isDefined(secondplayer.team) && firstplayer.team != secondplayer.team : firstplayer != secondplayer;
}

function function_2b55094fe59356fe(firstplayer, secondplayer) {
  if(!(isDefined(firstplayer.team) && isDefined(secondplayer.team))) {
    return 0;
  }

  if(level.teambased) {
    sameteam = firstplayer.team == secondplayer.team;
    var_9e55c69066c49c17 = isDefined(firstplayer.var_52a4aad8e6eafc68) && isDefined(secondplayer.var_52a4aad8e6eafc68) && firstplayer.var_52a4aad8e6eafc68 != "none" && firstplayer.var_52a4aad8e6eafc68 == secondplayer.var_52a4aad8e6eafc68;
    return (!sameteam && !var_9e55c69066c49c17);
  }

  return firstplayer != secondplayer;
}

function function_51a0c300008ab56b(firstplayer, secondplayer) {
  return isfriendly(firstplayer.team, secondplayer);
}

function getteamindex(teamname) {
  return level.teamdata[teamname]["index"];
}

function playerbloodrestricted() {
  return level.var_ce11fa8b9f14341d ?? utility::iswegameplatform();
}

function initdismembermentlist() {
  level.playerswithoutdismemberment = [];
}

function addtodismembermentlist() {
  assert(isDefined(level.playerswithoutdismemberment), "<dev string:xa7>");

  if(!self isdismembermentenabledforplayer()) {
    level.playerswithoutdismemberment[self getxuid()] = self;
  }
}

function removefromdismembermentlist() {
  assert(isDefined(level.playerswithoutdismemberment), "<dev string:xe6>");
  level.playerswithoutdismemberment[self getxuid()] = undefined;
}

function getdismembermentlist() {
  return level.playerswithoutdismemberment;
}

function _playerhidestack() {
  if(!isDefined(self.playerhidden)) {
    self.playerhidden = 0;
  }

  if(self.playerhidden == 0) {
    function_dbe5a52a6654a982();
  }

  self.playerhidden++;
}

function function_dbe5a52a6654a982(var_eb28bb08a5c7d49c) {
  mtx_weapon::function_61f9d1047d33e77e();

  if(var_eb28bb08a5c7d49c) {
    self playerhide(1);
    return;
  }

  self playerhide();
}

function function_9d378d725bb4831e(reason) {
  if(getdvarint(@ "hash_b5fe5be1cf552f2e", 0) == 0) {
    return;
  }

  logprint("PlayerHide(): " + reason);
  println("<dev string:x12a>" + reason);
}

function _playershowstack() {
  assert(self.playerhidden > 0, "<dev string:x13c>");

  if(self.playerhidden == 1) {
    function_b54a1e23734ef07();
  }

  self.playerhidden--;

  if(self.playerhidden == 0) {
    self.playerhidden = undefined;
  }
}

function function_b54a1e23734ef07(var_eb28bb08a5c7d49c) {
  if(var_eb28bb08a5c7d49c) {
    self playershow(1);
  } else {
    self playershow();
  }

  mtx_weapon::function_6e83b6d312e47cb3();
}

function function_4688d689820ff1ed(reason) {
  if(getdvarint(@ "hash_11b8360f35c60d6f", 0) == 0) {
    return;
  }

  logprint("PlayerShow(): " + reason);
  println("<dev string:x16d>" + reason);
}

function function_278a198455b7bee6() {
  self.playerhidden = undefined;
  self playershow();
}

function function_bd8d26e4f03d2ca(var_f1d441fe1b436aa0 = 0) {
  activeanims = self getactiveanimations();

  foreach(activeanim in activeanims) {
    self setanimtime(utility::getanim(activeanim["name"]), 0.999, undefined, var_f1d441fe1b436aa0);
  }
}

function isswimmingunderwater() {
  return self isswimming() && self isswimunderwater();
}

function function_2e61ffcf29281b15() {
  return self isswimming() && !self isswimunderwater();
}

function function_2a104cfb275afa1b(player, firstpersonsound, thirdpersonsound, var_d7cadebdd3516a03) {
  player playlocalsound(firstpersonsound);

  if(var_d7cadebdd3516a03) {
    player playsoundatviewheight(thirdpersonsound);
    return;
  }

  player playSound(thirdpersonsound, player);
}

function function_99d180c3f0ca93b8(player, motionasset, priority, forceon) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return;
  }

  if(!isDefined(player.var_eed72558c5c10954)) {
    player.var_eed72558c5c10954 = spawnStruct();
    player.var_eed72558c5c10954.asset = motionasset;
    player.var_eed72558c5c10954.priority = priority;
  } else if(forceon || !isDefined(player.var_eed72558c5c10954.priority) || player.var_eed72558c5c10954.priority <= priority) {
    player.var_eed72558c5c10954.asset = motionasset;
    player.var_eed72558c5c10954.priority = priority;
  } else {
    return;
  }

  player setcinematicmotionoverride(motionasset);
}

function function_c14762bb6e0b4edb(player) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return;
  }

  player clearcinematicmotionoverride();

  if(isDefined(player.var_eed72558c5c10954)) {
    player.var_eed72558c5c10954.asset = undefined;
    player.var_eed72558c5c10954.priority = undefined;
  }
}

function printspawnmessage(message) {
  if(getdvarint(@ "hash_da3b86849f785e06", 0) == 1) {
    println("<dev string:x17f>" + gettime() + "<dev string:x185>" + self.name + "<dev string:x18b>" + message);
    println("<dev string:x191>" + self.sessionstate);
    println("<dev string:x1a4>" + self.origin);

    if(isDefined(self.forcedspawncameraref)) {
      println("<dev string:x1b8>" + self.forcedspawncameraref);
    }

    if(isDefined(self.spawncameraent)) {
      println("<dev string:x1d8>" + self.spawncameraent.origin);
      println("<dev string:x1f9>" + self.spawncameraent.angles);
    }
  }

}

function function_f1bdd64504937120() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");

  if(level.killcam) {
    while(!isDefined(self.var_193ef53f6ce54cf2)) {
      waitframe();
    }

    if(level.killcam && self.killcam) {
      utility::waittill_any("killcam_ended", "killcam_canceled", "abort_killcam");
    }
  }
}

function function_230204b1e2875ed0() {
  self endon("disconnect");
  assert(self.liveragdoll);
  cameraentity = function_232d44374eb29c6a(0, 0);
  self.var_193ef53f6ce54cf2 = undefined;
  wait getdvarfloat(@ "scr_death_scene_time", 1.75);
  function_f1bdd64504937120();
  self allowspectateteam(self.team, 1);
  self cameraunlink();
  cameraentity delete();
}

function function_232d44374eb29c6a(var_a9427f67bd9fcf83, var_53b8cce0afd54244) {
  if(!isDefined(var_a9427f67bd9fcf83)) {
    var_a9427f67bd9fcf83 = 0;
  }

  cameradata = function_cdda5b59decded4e(self, self.attacker, var_53b8cce0afd54244);

  if(!isDefined(cameradata)) {
    return undefined;
  }

  cameraentity = spawn("script_model", cameradata.origin);
  cameraentity setModel("tag_origin");
  cameraentity.angles = cameradata.angles;
  cameraentity.data = cameradata;
  playermover = self getmovingplatformparent();

  if(isDefined(playermover)) {
    cameraentity linkTo(playermover);
  }

  self allowspectateallteams(0);
  self cameralinkTo(cameraentity, "tag_origin", 1, var_a9427f67bd9fcf83);
  return cameraentity;
}

function function_cdda5b59decded4e(victim, attacker, var_53b8cce0afd54244) {
  assert(isent(victim));
  assert(isent(attacker));
  deathpos = undefined;

  if(isDefined(victim.origin)) {
    deathpos = victim.origin;
  } else if(isDefined(victim.lastdeathpos)) {
    deathpos = victim.lastdeathpos;
  }

  if(!isDefined(deathpos)) {
    logstring("Undefined deathPos for death ragdoll 3rd person camera.");
    return undefined;
  }

  if(victim == attacker || !isDefined(attacker.origin)) {
    forwardvector = anglesToForward(victim.angles);
    forwardvector = vectornormalize2(forwardvector);
  } else {
    forwardvector = vectorNormalize(deathpos - attacker.origin);
  }

  baseangles = generateaxisanglesfromforwardvector(forwardvector, (0, 0, 1));
  cameraposition = deathpos + (0, 0, 12);
  cameradistance = 200;
  stepangle = 30;
  maxsteps = 360 / stepangle;
  validpositions = [];

  for(i = 0; i < maxsteps; i++) {
    stepvector = anglesToForward(baseangles + (0, stepangle * i, 0));
    startposition = deathpos + (0, 0, 12);
    endposition = deathpos + stepvector * cameradistance + (0, 0, 150);
    trace = trace::sphere_trace(startposition, endposition, 2, [victim, attacker]);

    if(isDefined(trace) && trace["fraction"] > 0.99) {
      validpositions[validpositions.size] = trace["position"];

      if(!var_53b8cce0afd54244) {
        break;
      }
    }
  }

  if(validpositions.size > 0) {
    cameraposition = validpositions[0];
  }

  victimdirection = vectorNormalize(deathpos - cameraposition);
  cameradata = spawnStruct();
  cameradata.origin = cameraposition;
  cameradata.angles = vectortoangles(victimdirection);
  cameradata.distance = cameradistance;
  cameradata.validpositions = validpositions;
  return cameradata;
}

function updatesessionstate(sessionstate, statusicon) {
  assert(sessionstate == "<dev string:x21a>" || sessionstate == "<dev string:x225>" || sessionstate == "<dev string:x22d>" || sessionstate == "<dev string:x23a>" || sessionstate == "<dev string:x24a>");
  ui_session_state = sessionstate;

  if(self.liveragdoll) {
    if(self.sessionstate == "playing_but_spectating" && (sessionstate == "dead" || sessionstate == "spectator")) {
      printspawnmessage("player::updateSessionState() didn't not update because we are in liveRagdoll");
      return;
    }

    if(sessionstate == "playing_but_spectating") {
      ui_session_state = "spectator";

      if(getdvarint(@ "killswitch_cyberrevivedeathcamenabled", 1) == 0) {
        thread function_230204b1e2875ed0();
      }
    }
  }

  switch (sessionstate) {
    case #"hash_6e223a17d0eb5015":
    case #"hash_7135993aa112803d":
      statusicon = "";
      break;
    case #"hash_9430ae82e6671e2a":
    case #"hash_cf14c509efeb3c87":
      if(level.doing_winners_circle) {
        statusicon = "";
      } else if(level.numlifelimited) {
        if(self.tagavailable) {
          statusicon = "hud_status_dogtag";
        } else if(self.revivetriggeravailable) {
          if(self.statusicon == "hud_status_revive_or") {
            statusicon = "hud_status_revive_or";
          } else {
            statusicon = "hud_status_revive_wh";
          }
        } else {
          statusicon = "hud_status_dead";
        }
      } else {
        statusicon = "hud_status_dead";
      }

      break;
  }

  if(!isDefined(statusicon)) {
    statusicon = "";
  }

  self.sessionstate = sessionstate;
  self.statusicon = statusicon;
  self setclientomnvar("ui_session_state", ui_session_state);
  printspawnmessage("player::updateSessionState() " + sessionstate);
}

function clearkillcamstate(var_824c9d962d9cde74) {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.archiveusepotg = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;

  if(!var_824c9d962d9cde74) {
    thread function_d14fd7480f28bba9();
  }
}

function private function_d14fd7480f28bba9() {
  self endon("disconnect");
  self notify("reset_killcam_player");
  self endon("reset_killcam_player");
  wait 0.05;
  restorepitch = 0;
  restoreroll = 0;
  var_2f9e1349ec2a4b90 = self getplayerangles();
  restoreyaw = var_2f9e1349ec2a4b90[1];
  self setplayerangles((restorepitch, restoreyaw, restoreroll));
}

function script_getplayersinradius(origin, radius, desiredteam, excludeent) {
  return getplayersinradius(origin, radius, undefined, undefined, excludeent, desiredteam);
}

function getplayerlookatpos(player, ignoreents, contentoverride) {
  starttrace = player getcamerathirdperson() ? player getcamerathirdpersonorigin() : player getvieworigin();
  endtrace = starttrace + anglesToForward(player getplayerangles()) * 20000;
  trace = trace::ray_trace(starttrace, endtrace, ignoreents, contentoverride);
  endpos = undefined;

  if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
    endpos = trace["position"];
  }

  return endpos;
}

function _visionsetnaked(visionset, time) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(isai(player)) {
      continue;
    }

    player visionsetnakedforplayer(visionset, time);
  }
}

function waittillrecoveredhealth(time, interval) {
  self endon("death_or_disconnect");
  fullhealthtime = 0;

  if(!isDefined(interval)) {
    interval = 0.05;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  while(true) {
    if(self.health != self.maxhealth) {
      fullhealthtime = 0;
    } else {
      fullhealthtime += interval;
    }

    wait interval;

    if(self.health == self.maxhealth && fullhealthtime >= time) {
      break;
    }
  }
}

function hidehudenable() {
  if(!isDefined(self.ui_hudhidden)) {
    self.hidehudenabled = 0;
  }

  if(self.hidehudenabled == 0) {
    self setclientomnvar("ui_hide_hud", 1);
  }

  self.hidehudenabled++;
}

function hidehuddisable() {
  assert(self.hidehudenabled > 0, "<dev string:x264>");

  if(self.hidehudenabled == 1) {
    self setclientomnvar("ui_hide_hud", 0);
  }

  self.hidehudenabled--;
}

function hidehudclear() {
  self.hidehudenabled = undefined;
  self setclientomnvar("ui_hide_hud", 0);
}

function function_cdedd9a19069ca4c(reviver) {
  return reviver.revivingteammate && !reviver.var_e0a3e97f1aea8404;
}

function isfriendly(teamtocheck, var_5b415c263e1d902) {
  assert(isDefined(var_5b415c263e1d902), "<dev string:x295>");

  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(var_5b415c263e1d902) && !isDefined(var_5b415c263e1d902.team)) {
    return false;
  }

  if(teamtocheck != var_5b415c263e1d902.team) {
    return false;
  }

  return true;
}

function _jumpbuttonPressed() {
  return self jumpbuttonPressed();
}

function function_a1e9194b63d531a4() {
  return self superbuttonPressed();
}

function getPlayerGuid(player) {
  if(isPlayer(player) && isDefined(player.guid)) {
    return player.guid;
  }

  assertmsg("<dev string:x2c1>");
  return 0;
}