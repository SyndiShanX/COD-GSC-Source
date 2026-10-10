/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\utility\player_utility.gsc
*******************************************************/

#using script_cbb0697de4c5728;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace player_utility;

function getstancecenter() {
  if(self getstance() == "crouch") {
    center = self.origin + 0.5 * (0, 0, 48);
  } else if(self getstance() == "prone") {
    center = self.origin + 0.5 * (0, 0, 20);
  } else {
    center = self.origin + 0.5 * (0, 0, 64);
  }

  return center;
}

function getstancetop(stanceoverride) {
  curstance = self getstance();

  if(isDefined(stanceoverride)) {
    curstance = stanceoverride;
  }

  if(curstance == "crouch") {
    top = self.origin + (0, 0, 48);
  } else if(curstance == "prone") {
    top = self.origin + (0, 0, 20);
  } else {
    top = self.origin + (0, 0, 64);
  }

  return top;
}

function _isalive() {
  return isalive(self) && !isDefined(self.fauxdead) && !istrue(self.delayedspawnedplayernotify) && !istrue(self.liveragdoll);
}

function setusingremote(remotename) {
  if(issharedfuncdefined("player", "setUsingRemote")) {
    [[getsharedfunc("player", "setUsingRemote")]](remotename);
  }
}

function clearusingremote(var_2c111f02d48e2671) {
  if(issharedfuncdefined("player", "clearUsingRemote")) {
    [[getsharedfunc("player", "clearUsingRemote")]](var_2c111f02d48e2671);
  }
}

function function_1e4a0e61fdb00e32(player) {
  if(issharedfuncdefined("player", "isOOB")) {
    return [[getsharedfunc("player", "isOOB")]](player);
  }

  return isDefined(player.oob) && player.oob > 0;
}

function isenemy(other) {
  if(level.teambased) {
    if(isDefined(other.team) && isDefined(self.team)) {
      return (other.team != self.team);
    } else {
      assertmsg("<dev string:x1c>");
      return 1;
    }

    return;
  }

  if(isDefined(other.owner)) {
    return (other.owner != self);
  }

  return other != self;
}

function isinvehicle(includetransitions) {
  if(isDefined(self.vehicle) && isDefined(self.vehicle.vehiclename)) {
    return true;
  }

  if(istrue(includetransitions)) {
    if(isDefined(self.vehiclereserved) && isDefined(self.vehiclereserved.vehiclename)) {
      return true;
    }
  }

  return false;
}

function getvehicle(var_3fcd58f5bae3bd0) {
  if(isinvehicle()) {
    return self.vehicle;
  } else if(istrue(var_3fcd58f5bae3bd0)) {
    return self.externalvehicle;
  }

  return undefined;
}

function function_f8789f15330de751(player) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return false;
  }

  return istrue(player isinvehicle(1)) || isDefined(player getmovingplatformparent());
}

function getteamarray(team, var_dcc07fcc8a9beb59) {
  teamarray = [];

  if(!isDefined(var_dcc07fcc8a9beb59) || var_dcc07fcc8a9beb59) {
    foreach(player in level.characters) {
      if(isDefined(player.team) && player.team == team) {
        teamarray[teamarray.size] = player;
      }
    }
  } else {
    foreach(player in level.players) {
      if(isDefined(player.team) && player.team == team) {
        teamarray[teamarray.size] = player;
      }
    }
  }

  return teamarray;
}

function _freezecontrols(frozen, force, debug) {
  if(issharedfuncdefined("player", "freezeControls")) {
    return [[getsharedfunc("player", "freezeControls")]](frozen, force, debug);
  }
}

function function_8213d31f7a3c32e2() {
  if(issharedfuncdefined("player", "freezeControlsDebug")) {
    return [[getsharedfunc("player", "freezeControlsDebug")]]();
  }
}

function _freezelookcontrols(frozen, force) {
  if(issharedfuncdefined("player", "freezeLookControls")) {
    return [[getsharedfunc("player", "freezeLookControls")]](frozen, force);
  }
}

function function_82f44f5f304ba91a(enabled) {
  function_f2c3ee9fded6a3df(enabled);
  function_cb6c6cd4245c5551(enabled);
}

function function_f2c3ee9fded6a3df(enabled) {
  self allowmovement(!enabled);
  self allowprone(!enabled);
  self allowjump(!enabled);
  self allowmelee(!enabled);
}

function function_cb6c6cd4245c5551(enabled) {
  self freezecontrols(enabled);
  self freezelookcontrols(enabled);
}

function getplayersuperfaction(player) {
  playersuperfaction = 0;

  if(isDefined(player.operatorcustomization)) {
    playersuperfaction = player.operatorcustomization.superfaction;
  }

  return playersuperfaction;
}

function setthermalvision(bool, fstop, focusdistance) {
  if(istrue(bool)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(fstop, focusdistance, 20, 20);
    self thermalvisionon();
    return;
  }

  self disablephysicaldepthoffieldscripting();
  self thermalvisionoff();
}

function watchthermalinputchange(inairvehicle) {
  self notify("watch_thermal_input_change");
  self endon("watch_thermal_input_change");
  self endon("disconnect");

  while(true) {
    var_ff8e235b01cd7409 = getthermalswitchplayercommand(inairvehicle);
    self notifyonplayercommand("switch_thermal_mode", var_ff8e235b01cd7409);
    returnednotif = waittill_any_return_no_endon_death_2("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", var_ff8e235b01cd7409);

    if(!isDefined(returnednotif) || returnednotif == "thermal_handling_ended") {
      break;
    }
  }
}

function stopwatchingthermalinputchange() {
  self notify("thermal_handling_ended");
}

function updateinputtypewatcher() {
  var_51ec07dc533464b5 = is_player_gamepad_enabled();

  if(!isDefined(self.gamepadwasenabled) || self.gamepadwasenabled != var_51ec07dc533464b5) {
    self notify("input_type_changed", var_51ec07dc533464b5);
    self.gamepadwasenabled = var_51ec07dc533464b5;
  }
}

function getthermalswitchplayercommand(inairvehicle) {
  if(is_player_gamepad_enabled()) {
    if(istrue(inairvehicle)) {
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
  assertex(isDefined(self.demeanorsafeenabled) && self.demeanorsafeenabled > 0, "<dev string:x5d>");
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

  if(!istrue(self.demeanorsprintdisable)) {
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

  if(istrue(self.demeanorsprintdisable)) {
    val::reset_all("forceDemeanor");
    self.demeanorsprintdisable = undefined;
  }
}

function cleardemeanorsafe() {
  self.demeanorsafeenabled = undefined;
  self.demeanorsprintdisable = undefined;
}

function playersareenemies(firstplayer, secondplayer, var_b2b9b3d299fbaeb1) {
  if(!isDefined(firstplayer) || !isDefined(secondplayer)) {
    return 0;
  }

  if(!isDefined(firstplayer.team) || !isDefined(secondplayer.team)) {
    return 0;
  }

  if(level.teambased) {
    sameteam = firstplayer.team == secondplayer.team;

    if(istrue(var_b2b9b3d299fbaeb1)) {
      var_a64bc29810299920 = 0;

      if(isDefined(firstplayer.var_b5091efefe8e436b) && isDefined(secondplayer.var_b5091efefe8e436b) && firstplayer.var_b5091efefe8e436b != "none") {
        var_a64bc29810299920 = firstplayer.var_b5091efefe8e436b == secondplayer.var_b5091efefe8e436b;
      }

      return (!sameteam && !var_a64bc29810299920);
    }

    return !sameteam;
  }

  return firstplayer != secondplayer;
}

function getteamindex(teamname) {
  return level.teamdata[teamname]["index"];
}

function playerbloodrestricted() {
  return utility::iswegameplatform();
}

function initdismembermentlist() {
  level.playerswithoutdismemberment = [];
}

function addtodismembermentlist() {
  assertex(isDefined(level.playerswithoutdismemberment), "<dev string:x9f>");

  if(!self isdismembermentenabledforplayer()) {
    level.playerswithoutdismemberment[self getxuid()] = self;
  }
}

function removefromdismembermentlist() {
  assertex(isDefined(level.playerswithoutdismemberment), "<dev string:xde>");
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
    function_a593971d75d82113();
  }

  self.playerhidden++;
}

function function_a593971d75d82113(var_1fffb4c6d7b458a3) {
  namespace_46e942396566f2da::function_112e56b7dbe18137();

  if(istrue(var_1fffb4c6d7b458a3)) {
    self playerhide(1);
    return;
  }

  self playerhide();
}

function function_379bb555405c16bb(reason) {
  if(getdvarint(@ "hash_b5fe5be1cf552f2e", 0) == 0) {
    return;
  }

  logprint("PlayerHide(): " + reason);
  println("<dev string:x122>" + reason);
}

function _playershowstack() {
  assertex(isDefined(self.playerhidden) && self.playerhidden > 0, "<dev string:x134>");

  if(self.playerhidden == 1) {
    function_6fb380927695ee76();
  }

  self.playerhidden--;

  if(self.playerhidden == 0) {
    self.playerhidden = undefined;
  }
}

function function_6fb380927695ee76(var_1fffb4c6d7b458a3) {
  if(istrue(var_1fffb4c6d7b458a3)) {
    self playershow(1);
  } else {
    self playershow();
  }

  namespace_46e942396566f2da::function_33637806fc5ac024();
}

function function_985b0973f29da4f8(reason) {
  if(getdvarint(@ "hash_11b8360f35c60d6f", 0) == 0) {
    return;
  }

  logprint("PlayerShow(): " + reason);
  println("<dev string:x165>" + reason);
}

function function_c28310e3b33872cb() {
  self.playerhidden = undefined;

  if(!isDefined(level.var_61a823f67a0cb19f)) {
    level.var_61a823f67a0cb19f = getdvarint(@ "hash_e6a081201f8d6465", 0);
  }

  if(level.var_61a823f67a0cb19f) {
    self playershow();
  }
}

function isreallyalive(player) {
  return isalive(player) && !isDefined(player.fauxdead) && !istrue(player.delayedspawnedplayernotify) && !istrue(player.liveragdoll);
}

function player_hasperk(perk) {
  if(issharedfuncdefined("perk", "hasPerk")) {
    return self[[getsharedfunc("perk", "hasPerk")]](perk);
  }

  return 0;
}

function isfemale() {
  return isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female";
}

function isswimmingunderwater() {
  return self isswimming() && self isswimunderwater();
}

function function_d474b372046544b0() {
  return self isswimming() && !self isswimunderwater();
}

function playplayerandnpcsounds(player, firstpersonsound, thirdpersonsound) {
  player playlocalsound(firstpersonsound);
  player playSound(thirdpersonsound, player);
}

function function_f7348e400b4a608d(player, motionasset, priority, forceon) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return;
  }

  if(!isDefined(player.var_82b2c97dad24de07)) {
    player.var_82b2c97dad24de07 = spawnStruct();
    player.var_82b2c97dad24de07.asset = motionasset;
    player.var_82b2c97dad24de07.priority = priority;
  } else if(istrue(forceon) || !isDefined(player.var_82b2c97dad24de07.priority) || player.var_82b2c97dad24de07.priority <= priority) {
    player.var_82b2c97dad24de07.asset = motionasset;
    player.var_82b2c97dad24de07.priority = priority;
  } else {
    return;
  }

  player setcinematicmotionoverride(motionasset);
}

function function_56d83cde22535f96(player) {
  if(!isDefined(player) || isbot(player) || isagent(player)) {
    return;
  }

  player clearcinematicmotionoverride();

  if(isDefined(player.var_82b2c97dad24de07)) {
    player.var_82b2c97dad24de07.asset = undefined;
    player.var_82b2c97dad24de07.priority = undefined;
  }
}

function printspawnmessage(message) {
  if(getdvarint(@ "hash_da3b86849f785e06", 0) == 1) {
    println("<dev string:x177>" + gettime() + "<dev string:x17d>" + self.name + "<dev string:x183>" + message);
    println("<dev string:x189>" + self.sessionstate);
    println("<dev string:x19c>" + self.origin);

    if(isDefined(self.forcedspawncameraref)) {
      println("<dev string:x1b0>" + self.forcedspawncameraref);
    }

    if(isDefined(self.spawncameraent)) {
      println("<dev string:x1d0>" + self.spawncameraent.origin);
      println("<dev string:x1f1>" + self.spawncameraent.angles);
    }
  }

}

function function_7a8a04d15ad052d5() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");

  if(level.killcam) {
    while(!isDefined(self.var_7c813e50ff75be27)) {
      waitframe();
    }

    if(level.killcam && istrue(self.killcam)) {
      waittill_any_3("killcam_ended", "killcam_canceled", "abort_killcam");
    }
  }
}

function function_fdff38028c016239() {
  self endon("disconnect");
  assert(istrue(self.liveragdoll));
  cameraentity = function_6d606d81ea9ab50b(0, 0);
  self.var_7c813e50ff75be27 = undefined;
  wait getdvarfloat(@ "hash_ac849f1ec300d19c", 1.75);
  function_7a8a04d15ad052d5();
  self allowspectateteam(self.team, 1);
  self cameraunlink();
  cameraentity delete();
}

function function_6d606d81ea9ab50b(var_81aa39b3e585cd66, var_d198b30dc157c5cd) {
  if(!isDefined(var_81aa39b3e585cd66)) {
    var_81aa39b3e585cd66 = 0;
  }

  cameradata = function_d93211a15c000cd(self, self.attacker, var_d198b30dc157c5cd);

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
  self cameralinkTo(cameraentity, "tag_origin", 1, var_81aa39b3e585cd66);
  return cameraentity;
}

function function_d93211a15c000cd(victim, attacker, var_d198b30dc157c5cd) {
  assert(isDefined(victim) && isent(victim));
  assert(isDefined(attacker) && isent(attacker));
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

  if(victim == attacker) {
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
    trace = scripts\engine\trace::sphere_trace(startposition, endposition, 2, [victim, attacker]);

    if(isDefined(trace) && trace["fraction"] > 0.99) {
      validpositions[validpositions.size] = trace["position"];

      if(!istrue(var_d198b30dc157c5cd)) {
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
  assert(sessionstate == "<dev string:x212>" || sessionstate == "<dev string:x21d>" || sessionstate == "<dev string:x225>" || sessionstate == "<dev string:x232>" || sessionstate == "<dev string:x242>");
  ui_session_state = sessionstate;

  if(istrue(self.liveragdoll)) {
    if(self.sessionstate == "playing_but_spectating" && (sessionstate == "dead" || sessionstate == "spectator")) {
      printspawnmessage("player::updateSessionState() didn't not update because we are in liveRagdoll");
      return;
    }

    if(sessionstate == "playing_but_spectating") {
      ui_session_state = "spectator";

      if(getdvarint(@ "hash_f47d7bfe207dc431", 1) == 0) {
        thread function_fdff38028c016239();
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
      if(istrue(level.var_286c2c7b34d03b04)) {
        statusicon = "";
      } else if(istrue(level.numlifelimited)) {
        if(istrue(self.tagavailable)) {
          statusicon = "hud_status_dogtag";
        } else if(istrue(self.revivetriggeravailable)) {
          if(isDefined(self.statusicon) && self.statusicon == "hud_status_revive_or") {
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

function clearkillcamstate() {
  self.forcespectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.archiveusepotg = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  thread function_c5a5b36868d0a68e();
}

function private function_c5a5b36868d0a68e() {
  self endon("disconnect");
  self notify("reset_killcam_player");
  self endon("reset_killcam_player");
  wait 0.05;
  restorepitch = 0;
  restoreroll = 0;
  var_7500ec3e41c123ab = self getplayerangles();
  restoreyaw = var_7500ec3e41c123ab[1];
  self setplayerangles((restorepitch, restoreyaw, restoreroll));
}

function getplayersinradius(origin, radius, desiredteam, excludeent) {
  if(radius <= 0) {
    return [];
  }

  excludearray = undefined;

  if(isDefined(excludeent)) {
    if(isarray(excludeent)) {
      excludearray = excludeent;
    } else {
      excludearray = [excludeent];
    }
  }

  results = physics_querypoint(origin, radius, physics_createcontents(["physicscontents_characterproxy"]), excludearray, "physicsquery_all");
  filteredresults = [];

  if(!isDefined(desiredteam)) {
    foreach(result in results) {
      e = result["entity"];

      if(isPlayer(e)) {
        filteredresults[filteredresults.size] = e;
      }
    }
  } else {
    foreach(result in results) {
      e = result["entity"];

      if(isPlayer(e) && isDefined(e.team) && e.team == desiredteam) {
        filteredresults[filteredresults.size] = e;
      }
    }
  }

  if(getdvarint(@ "hash_500c5c1476d28421", 0) > 0) {
    debugduration = 60;
    sphere(origin, radius, (1, 1, 1), 0, debugduration);

    foreach(player in filteredresults) {
      sphere(player.origin, 10, (1, 0, 0), 1, debugduration);
    }
  }

  return filteredresults;
}

function getplayerlookatpos(player, ignoreents, contentoverride) {
  contents = scripts\engine\trace::create_default_contents();

  if(isDefined(contentoverride)) {
    if(isarray(contentoverride)) {
      contentoverride = physics_createcontents(contentoverride);
    }

    contents = contentoverride;
  }

  starttrace = player getvieworigin();

  if(player getcamerathirdperson()) {
    starttrace = player getcamerathirdpersonorigin();
  }

  endtrace = starttrace + anglesToForward(player getplayerangles()) * 20000;
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignoreents, contentoverride);
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
  assert(isDefined(self.hidehudenabled) && self.hidehudenabled > 0, "<dev string:x25c>");

  if(self.hidehudenabled == 1) {
    self setclientomnvar("ui_hide_hud", 0);
  }

  self.hidehudenabled--;
}

function hidehudclear() {
  self.hidehudenabled = undefined;
  self setclientomnvar("ui_hide_hud", 0);
}

function function_b7869f6d9d4242e3(reviver) {
  return istrue(reviver.revivingteammate) && !istrue(reviver.var_383e041e3e341315);
}

function isfriendly(var_da8cec9bce12f9cb, var_c4b81997f0120a97) {
  assertex(isDefined(var_c4b81997f0120a97), "<dev string:x28d>");

  if(!level.teambased) {
    return false;
  }

  if(!isPlayer(var_c4b81997f0120a97) && !isDefined(var_c4b81997f0120a97.team)) {
    return false;
  }

  if(var_da8cec9bce12f9cb != var_c4b81997f0120a97.team) {
    return false;
  }

  return true;
}

function _jumpbuttonPressed() {
  return self jumpbuttonPressed();
}

function function_1551f039785a297d() {
  return self superbuttonPressed();
}