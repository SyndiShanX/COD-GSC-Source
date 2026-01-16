/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_utility.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

triggerOff() {
  if(!isDefined(self.realOrigin)) {
    self.realOrigin = self.origin;
  }
  if(self.origin == self.realorigin) {
    self.origin += (0, 0, -10000);
  }
}
triggerOn() {
  if(isDefined(self.realOrigin)) {
    self.origin = self.realOrigin;
  }
}
error(msg) {
  println("^c*ERROR* ", msg);
  wait .05;
}
warning(msg) {
  println("^1WARNING: " + msg);
}
spawn_array_struct() {
  s = SpawnStruct();
  s.a = [];
  return s;
}
within_fov(start_origin, start_angles, end_origin, fov) {
  normal = VectorNormalize(end_origin - start_origin);
  forward = AnglesToForward(start_angles);
  dot = VectorDot(forward, normal);
  return dot >= fov;
}
append_array_struct(
  dst_s,
  src_s) {
  for (i = 0; i < src_s.a.size; i++) {
    dst_s.a[dst_s.a.size] = src_s.a[i];
  }
}
exploder(num) {
  [[level.exploderFunction]](num);
}
exploder_stop(num) {
  stop_exploder(num);
}
exploder_sound() {
  if(isDefined(self.script_delay)) {
    wait self.script_delay;
  }
  self playSound(level.scr_sound[self.script_sound]);
}
cannon_effect() {
  if(isDefined(self.v["repeat"])) {
    for (i = 0; i < self.v["repeat"]; i++) {
      playfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
      self exploder_delay();
    }
    return;
  }
  self exploder_delay();
  if(isDefined(self.looper)) {
    self.looper delete();
  }
  self.looper = spawnFx(getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
  triggerFx(self.looper);
  exploder_playSound();
}
exploder_delay() {
  if(!isDefined(self.v["delay"])) {
    self.v["delay"] = 0;
  }
  min_delay = self.v["delay"];
  max_delay = self.v["delay"] + 0.001;
  if(isDefined(self.v["delay_min"])) {
    min_delay = self.v["delay_min"];
  }
  if(isDefined(self.v["delay_max"])) {
    max_delay = self.v["delay_max"];
  }
  if(min_delay > 0) {
    wait(randomfloatrange(min_delay, max_delay));
  }
}
exploder_playSound() {
  if(!isDefined(self.v["soundalias"]) || self.v["soundalias"] == "nil") {
    return;
  }
  play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}
brush_delete() {
  num = self.v["exploder"];
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  } else {
    wait(.05);
  }
  if(!isDefined(self.model)) {
    return;
  }
  assert(isDefined(self.model));
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    self.model hide();
    self.model notsolid();
    wait(3);
    self.exploded = undefined;
    self.model show();
    self.model solid();
    return;
  }
  if(!isDefined(self.v["fxid"]) || self.v["fxid"] == "No FX") {
    self.v["exploder"] = undefined;
  }
  waittillframeend;
  self.model delete();
}
brush_show() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }
  assert(isDefined(self.model));
  self.model show();
  self.model solid();
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    wait(3);
    self.exploded = undefined;
    self.model hide();
    self.model notsolid();
  }
}
brush_throw() {
  if(isDefined(self.v["delay"])) {
    wait(self.v["delay"]);
  }
  ent = undefined;
  if(isDefined(self.v["target"])) {
    ent = getent(self.v["target"], "targetname");
  }
  if(!isDefined(ent)) {
    self.model delete();
    return;
  }
  self.model show();
  startorg = self.v["origin"];
  startang = self.v["angles"];
  org = ent.origin;
  temp_vec = (org - self.v["origin"]);
  x = temp_vec[0];
  y = temp_vec[1];
  z = temp_vec[2];
  self.model rotateVelocity((x, y, z), 12);
  self.model moveGravity((x, y, z), 12);
  if(level.createFX_enabled) {
    if(isDefined(self.exploded)) {
      return;
    }
    self.exploded = true;
    wait(3);
    self.exploded = undefined;
    self.v["origin"] = startorg;
    self.v["angles"] = startang;
    self.model hide();
    return;
  }
  self.v["exploder"] = undefined;
  wait(6);
  self.model delete();
}
getPlant() {
  start = self.origin + (0, 0, 10);
  range = 11;
  forward = anglesToForward(self.angles);
  forward = vector_scale(forward, range);
  traceorigins[0] = start + forward;
  traceorigins[1] = start;
  trace = bulletTrace(traceorigins[0], (traceorigins[0] + (0, 0, -18)), false, undefined);
  if(trace["fraction"] < 1) {
    temp = spawnstruct();
    temp.origin = trace["position"];
    temp.angles = orientToNormal(trace["normal"]);
    return temp;
  }
  trace = bulletTrace(traceorigins[1], (traceorigins[1] + (0, 0, -18)), false, undefined);
  if(trace["fraction"] < 1) {
    temp = spawnstruct();
    temp.origin = trace["position"];
    temp.angles = orientToNormal(trace["normal"]);
    return temp;
  }
  traceorigins[2] = start + (16, 16, 0);
  traceorigins[3] = start + (16, -16, 0);
  traceorigins[4] = start + (-16, -16, 0);
  traceorigins[5] = start + (-16, 16, 0);
  besttracefraction = undefined;
  besttraceposition = undefined;
  for (i = 0; i < traceorigins.size; i++) {
    trace = bulletTrace(traceorigins[i], (traceorigins[i] + (0, 0, -1000)), false, undefined);
    if(!isDefined(besttracefraction) || (trace["fraction"] < besttracefraction)) {
      besttracefraction = trace["fraction"];
      besttraceposition = trace["position"];
    }
  }
  if(besttracefraction == 1)
    besttraceposition = self.origin;
  temp = spawnstruct();
  temp.origin = besttraceposition;
  temp.angles = orientToNormal(trace["normal"]);
  return temp;
}
orientToNormal(normal) {
  hor_normal = (normal[0], normal[1], 0);
  hor_length = length(hor_normal);
  if(!hor_length)
    return (0, 0, 0);
  hor_dir = vectornormalize(hor_normal);
  neg_height = normal[2] * -1;
  tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
  plant_angle = vectortoangles(tangent);
  return plant_angle;
}
array_levelthread(ents, process,
  var, excluders) {
  exclude = [];
  for (i = 0; i < ents.size; i++)
    exclude[i] = false;
  if(isDefined(excluders)) {
    for (i = 0; i < ents.size; i++)
      for (p = 0; p < excluders.size; p++)
        if(ents[i] == excluders[p])
          exclude[i] = true;
  }
  for (i = 0; i < ents.size; i++) {
    if(!exclude[i]) {
      if(isDefined(var))
        level thread[[process]](ents[i],
          var);
      else
        level thread[[process]](ents[i]);
    }
  }
}
deletePlacedEntity(entity) {
  entities = getentarray(entity, "classname");
  for (i = 0; i < entities.size; i++) {
    entities[i] delete();
  }
}
playSoundOnPlayers(sound, team) {
  assert(isDefined(level.players));
  if(level.splitscreen) {
    if(isDefined(level.players[0]))
      level.players[0] playLocalSound(sound);
  } else {
    if(isDefined(team)) {
      for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if(isDefined(player.pers["team"]) && (player.pers["team"] == team))
          player playLocalSound(sound);
      }
    } else {
      for (i = 0; i < level.players.size; i++)
        level.players[i] playLocalSound(sound);
    }
  }
}
get_player_height() {
  return 70.0;
}
IsBulletImpactMOD(sMeansOfDeath) {
  return IsSubStr(sMeansOfDeath, "BULLET") || sMeansOfDeath == "MOD_HEAD_SHOT";
}
get_team_alive_players_s(teamName) {
  teamPlayers_s = spawn_array_struct();
  if(isDefined(teamName) &&
    isDefined(level.alivePlayers) &&
    isDefined(level.alivePlayers[teamName])) {
    for (i = 0; i < level.alivePlayers[teamName].size; i++) {
      teamPlayers_s.a[teamPlayers_s.a.size] = level.alivePlayers[teamName][i];
    }
  }
  return teamPlayers_s;
}
get_all_alive_players_s() {
  allPlayers_s = spawn_array_struct();
  if(isDefined(level.alivePlayers)) {
    keys = GetArrayKeys(level.alivePlayers);
    for (i = 0; i < keys.size; i++) {
      team = keys[i];
      for (j = 0; j < level.alivePlayers[team].size; j++) {
        allPlayers_s.a[allPlayers_s.a.size] = level.alivePlayers[team][j];
      }
    }
  }
  return allPlayers_s;
}
waitRespawnButton() {
  self endon("disconnect");
  self endon("end_respawn");
  while (self useButtonPressed() != true)
    wait .05;
}
setLowerMessage(text, time, combineMessageAndTimer) {
  if(!isDefined(self.lowerMessage))
    return;
  if(isDefined(self.lowerMessageOverride) && text != & "") {
    text = self.lowerMessageOverride;
    time = undefined;
  }
  self notify("lower_message_set");
  if(!isDefined(combineMessageAndTimer) || !combineMessageAndTimer)
    self.lowerMessage setText(text);
  else
    self.lowerMessage setText("");
  if(isDefined(time) && time > 0) {
    if(!isDefined(combineMessageAndTimer) || !combineMessageAndTimer)
      self.lowerTimer.label = & "";
    else
      self.lowerTimer.label = text;
    self.lowerTimer setTimer(time);
  } else {
    self.lowerTimer setText("");
    self.lowerTimer.label = & "";
  }
  if(self IsSplitscreen())
    self.lowerMessage.fontscale = 1.4;
  self.lowerMessage fadeOverTime(0.05);
  self.lowerMessage.alpha = 1;
  self.lowerTimer fadeOverTime(0.05);
  self.lowerTimer.alpha = 1;
}
clearLowerMessage(fadetime) {
  if(!isDefined(self.lowerMessage))
    return;
  self notify("lower_message_set");
  if(!isDefined(fadetime) || fadetime == 0) {
    setLowerMessage(&"");
  } else {
    self endon("disconnect");
    self endon("lower_message_set");
    self.lowerMessage fadeOverTime(fadetime);
    self.lowerMessage.alpha = 0;
    self.lowerTimer fadeOverTime(fadetime);
    self.lowerTimer.alpha = 0;
    wait fadetime;
    self setLowerMessage("");
  }
}
printOnTeam(text, team) {
  assert(isDefined(level.players));
  for (i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team))
      player iprintln(text);
  }
}
printBoldOnTeam(text, team) {
  assert(isDefined(level.players));
  for (i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team))
      player iprintlnbold(text);
  }
}
printBoldOnTeamArg(text, team, arg) {
  assert(isDefined(level.players));
  for (i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team))
      player iprintlnbold(text, arg);
  }
}
printOnTeamArg(text, team, arg) {}
printOnPlayers(text, team) {
  players = level.players;
  for (i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == team))
        players[i] iprintln(text);
    } else {
      players[i] iprintln(text);
    }
  }
}
printAndSoundOnEveryone(team, otherteam, printFriendly, printEnemy, soundFriendly, soundEnemy, printarg) {
  shouldDoSounds = isDefined(soundFriendly);
  shouldDoEnemySounds = false;
  if(isDefined(soundEnemy)) {
    assert(shouldDoSounds);
    shouldDoEnemySounds = true;
  }
  if(level.splitscreen || !shouldDoSounds) {
    for (i = 0; i < level.players.size; i++) {
      player = level.players[i];
      playerteam = player.pers["team"];
      if(isDefined(playerteam)) {
        if(playerteam == team && isDefined(printFriendly) && printFriendly != & "")
          player iprintln(printFriendly, printarg);
        else if(playerteam == otherteam && isDefined(printEnemy) && printEnemy != & "")
          player iprintln(printEnemy, printarg);
      }
    }
    if(shouldDoSounds) {
      assert(level.splitscreen);
      level.players[0] playLocalSound(soundFriendly);
    }
  } else {
    assert(shouldDoSounds);
    if(shouldDoEnemySounds) {
      for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printFriendly) && printFriendly != & "")
              player iprintln(printFriendly, printarg);
            player playLocalSound(soundFriendly);
          } else if(playerteam == otherteam) {
            if(isDefined(printEnemy) && printEnemy != & "")
              player iprintln(printEnemy, printarg);
            player playLocalSound(soundEnemy);
          }
        }
      }
    } else {
      for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        playerteam = player.pers["team"];
        if(isDefined(playerteam)) {
          if(playerteam == team) {
            if(isDefined(printFriendly) && printFriendly != & "")
              player iprintln(printFriendly, printarg);
            player playLocalSound(soundFriendly);
          } else if(playerteam == otherteam && isDefined(printEnemy) && printEnemy != & "") {
            player iprintln(printEnemy, printarg);
          }
        }
      }
    }
  }
}
_playLocalSound(soundAlias) {
  if(level.splitscreen && !self IsHost())
    return;
  self playLocalSound(soundAlias);
}
dvarIntValue(dVar, defVal, minVal, maxVal) {
  dVar = "scr_" + level.gameType + "_" + dVar;
  if(getDvar(dVar) == "") {
    setDvar(dVar, defVal);
    return defVal;
  }
  value = getDvarInt(dVar);
  if(value > maxVal)
    value = maxVal;
  else if(value < minVal)
    value = minVal;
  else
    return value;
  setDvar(dVar, value);
  return value;
}
dvarFloatValue(dVar, defVal, minVal, maxVal) {
  dVar = "scr_" + level.gameType + "_" + dVar;
  if(getDvar(dVar) == "") {
    setDvar(dVar, defVal);
    return defVal;
  }
  value = getDvarFloat(dVar);
  if(value > maxVal)
    value = maxVal;
  else if(value < minVal)
    value = minVal;
  else
    return value;
  setDvar(dVar, value);
  return value;
}
play_sound_on_tag(alias, tag) {
  if(isDefined(tag)) {
    org = spawn("script_origin", self getTagOrigin(tag));
    org linkto(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    org = spawn("script_origin", (0, 0, 0));
    org.origin = self.origin;
    org.angles = self.angles;
    org linkto(self);
  }
  org playsound(alias);
  wait(5.0);
  org delete();
}
createLoopEffect(fxid) {
  ent = maps\mp\_createfx::createEffect("loopfx", fxid);
  ent.v["delay"] = 0.5;
  return ent;
}
createOneshotEffect(fxid) {
  ent = maps\mp\_createfx::createEffect("oneshotfx", fxid);
  ent.v["delay"] = -15;
  return ent;
}
loop_fx_sound(alias, origin, ender, timeout) {
  org = spawn("script_origin", (0, 0, 0));
  if(isDefined(ender)) {
    thread loop_sound_delete(ender, org);
    self endon(ender);
  }
  org.origin = origin;
  org playloopsound(alias);
  if(!isDefined(timeout))
    return;
  wait(timeout);
}
exploder_damage() {
  if(isDefined(self.v["delay"]))
    delay = self.v["delay"];
  else
    delay = 0;
  if(isDefined(self.v["damage_radius"]))
    radius = self.v["damage_radius"];
  else
    radius = 128;
  damage = self.v["damage"];
  origin = self.v["origin"];
  wait(delay);
  radiusDamage(origin, radius, damage, damage);
}
exploder_before_load(num) {
  waittillframeend;
  waittillframeend;
  activate_exploder(num);
}
exploder_after_load(num) {
  activate_exploder(num);
}
activate_exploder(num) {
  num = int(num);
  for (i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!isDefined(ent))
      continue;
    if(ent.v["type"] != "exploder")
      continue;
    if(!isDefined(ent.v["exploder"]))
      continue;
    if(ent.v["exploder"] != num)
      continue;
    if(isDefined(ent.v["firefx"]))
      ent thread fire_effect();
    if(isDefined(ent.v["fxid"]) && ent.v["fxid"] != "No FX")
      ent thread cannon_effect();
    else
    if(isDefined(ent.v["soundalias"]))
      ent thread sound_effect();
    if(isDefined(ent.v["damage"]))
      ent thread exploder_damage();
    if(isDefined(ent.v["earthquake"])) {
      eq = ent.v["earthquake"];
      earthquake(level.earthquake[eq]["magnitude"],
        level.earthquake[eq]["duration"],
        ent.v["origin"],
        level.earthquake[eq]["radius"]);
    }
    if(ent.v["exploder_type"] == "exploder")
      ent thread brush_show();
    else
    if((ent.v["exploder_type"] == "exploderchunk") || (ent.v["exploder_type"] == "exploderchunk visible"))
      ent thread brush_throw();
    else
      ent thread brush_delete();
  }
}
stop_exploder(num) {
  num = int(num);
  for (i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!isDefined(ent))
      continue;
    if(ent.v["type"] != "exploder")
      continue;
    if(!isDefined(ent.v["exploder"]))
      continue;
    if(ent.v["exploder"] != num)
      continue;
    if(isDefined(ent.looper)) {
      ent.looper delete();
    }
  }
}
sound_effect() {
  self effect_soundalias();
}
effect_soundalias() {
  if(!isDefined(self.v["delay"]))
    self.v["delay"] = 0;
  origin = self.v["origin"];
  alias = self.v["soundalias"];
  wait(self.v["delay"]);
  play_sound_in_space(alias, origin);
}
play_sound_in_space(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));
  if(!isDefined(origin))
    origin = self.origin;
  org.origin = origin;
  if(isDefined(master) && master)
    org playsoundasmaster(alias);
  else
    org playsound(alias);
  wait(10.0);
  org delete();
}
loop_sound_in_space(alias, origin, ender) {
  org = spawn("script_origin", (0, 0, 1));
  if(!isDefined(origin)) {
    origin = self.origin;
  }
  org.origin = origin;
  org playLoopSound(alias);
  level waittill(ender);
  org stopLoopSound();
  wait 0.1;
  org delete();
}
fire_effect() {
  if(!isDefined(self.v["delay"]))
    self.v["delay"] = 0;
  delay = self.v["delay"];
  if((isDefined(self.v["delay_min"])) && (isDefined(self.v["delay_max"])))
    delay = self.v["delay_min"] + randomfloat(self.v["delay_max"] - self.v["delay_min"]);
  forward = self.v["forward"];
  up = self.v["up"];
  org = undefined;
  firefxSound = self.v["firefxsound"];
  origin = self.v["origin"];
  firefx = self.v["firefx"];
  ender = self.v["ender"];
  if(!isDefined(ender))
    ender = "createfx_effectStopper";
  timeout = self.v["firefxtimeout"];
  fireFxDelay = 0.5;
  if(isDefined(self.v["firefxdelay"]))
    fireFxDelay = self.v["firefxdelay"];
  wait(delay);
  if(isDefined(firefxSound))
    level thread loop_fx_sound(firefxSound, origin, ender, timeout);
  playfx(level._effect[firefx], self.v["origin"], forward, up);
}
loop_sound_delete(ender, ent) {
  ent endon("death");
  self waittill(ender);
  ent delete();
}
createExploder(fxid) {
  ent = maps\mp\_createfx::createEffect("exploder", fxid);
  ent.v["delay"] = 0;
  ent.v["exploder_type"] = "normal";
  return ent;
}
getOtherTeam(team) {
  if(team == "allies")
    return "axis";
  else if(team == "axis")
    return "allies";
  assertMsg("getOtherTeam: invalid team " + team);
}
wait_endon(waitTime, endOnString, endonString2, endonString3) {
  self endon(endOnString);
  if(isDefined(endonString2))
    self endon(endonString2);
  if(isDefined(endonString3))
    self endon(endonString3);
  wait(waitTime);
}
isMG(weapon) {
  return isSubStr(weapon, "_bipod_");
}
plot_points(plotpoints, r, g, b, timer) {
  lastpoint = plotpoints[0];
  if(!isDefined(r))
    r = 1;
  if(!isDefined(g))
    g = 1;
  if(!isDefined(b))
    b = 1;
  if(!isDefined(timer))
    timer = 0.05;
  for (i = 1; i < plotpoints.size; i++) {
    line(lastpoint, plotpoints[i], (r, g, b), 1, timer);
    lastpoint = plotpoints[i];
  }
}
registerClientSys(sSysName) {
  if(!isDefined(level._clientSys)) {
    level._clientSys = [];
  }
  if(level._clientSys.size >= 32) {
    error("Max num client systems exceeded.");
    return;
  }
  if(isDefined(level._clientSys[sSysName])) {
    error("Attempt to re-register client system : " + sSysName);
    return;
  } else {
    level._clientSys[sSysName] = spawnstruct();
    level._clientSys[sSysName].sysID = ClientSysRegister(sSysName);
  }
}
setClientSysState(sSysName, sSysState, player) {
  if(!isDefined(level._clientSys)) {
    error("setClientSysState called before registration of any systems.");
    return;
  }
  if(!isDefined(level._clientSys[sSysName])) {
    error("setClientSysState called on unregistered system " + sSysName);
    return;
  }
  if(isDefined(player)) {
    player ClientSysSetState(level._clientSys[sSysName].sysID, sSysState);
  } else {
    ClientSysSetState(level._clientSys[sSysName].sysID, sSysState);
    level._clientSys[sSysName].sysState = sSysState;
  }
}
getClientSysState(sSysName) {
  if(!isDefined(level._clientSys)) {
    error("Cannot getClientSysState before registering any client systems.");
    return "";
  }
  if(!isDefined(level._clientSys[sSysName])) {
    error("Client system " + sSysName + " cannot return state, as it is unregistered.");
    return "";
  }
  if(isDefined(level._clientSys[sSysName].sysState)) {
    return level._clientSys[sSysName].sysState;
  }
  return "";
}
clientNotify(event) {
  if(level.clientscripts) {
    if(IsPlayer(self)) {
      maps\mp\_utility::setClientSysState("levelNotify", event, self);
    } else {
      maps\mp\_utility::setClientSysState("levelNotify", event);
    }
  }
}
alphabet_compare(a, b) {
  list = [];
  val = 1;
  list["0"] = val;
  val++;
  list["1"] = val;
  val++;
  list["2"] = val;
  val++;
  list["3"] = val;
  val++;
  list["4"] = val;
  val++;
  list["5"] = val;
  val++;
  list["6"] = val;
  val++;
  list["7"] = val;
  val++;
  list["8"] = val;
  val++;
  list["9"] = val;
  val++;
  list["_"] = val;
  val++;
  list["a"] = val;
  val++;
  list["b"] = val;
  val++;
  list["c"] = val;
  val++;
  list["d"] = val;
  val++;
  list["e"] = val;
  val++;
  list["f"] = val;
  val++;
  list["g"] = val;
  val++;
  list["h"] = val;
  val++;
  list["i"] = val;
  val++;
  list["j"] = val;
  val++;
  list["k"] = val;
  val++;
  list["l"] = val;
  val++;
  list["m"] = val;
  val++;
  list["n"] = val;
  val++;
  list["o"] = val;
  val++;
  list["p"] = val;
  val++;
  list["q"] = val;
  val++;
  list["r"] = val;
  val++;
  list["s"] = val;
  val++;
  list["t"] = val;
  val++;
  list["u"] = val;
  val++;
  list["v"] = val;
  val++;
  list["w"] = val;
  val++;
  list["x"] = val;
  val++;
  list["y"] = val;
  val++;
  list["z"] = val;
  val++;
  a = tolower(a);
  b = tolower(b);
  val1 = 0;
  if(isDefined(list[a]))
    val1 = list[a];
  val2 = 0;
  if(isDefined(list[b]))
    val2 = list[b];
  if(val1 > val2)
    return "1st";
  if(val1 < val2)
    return "2nd";
  return "same";
}
is_later_in_alphabet(string1, string2) {
  count = string1.size;
  if(count >= string2.size)
    count = string2.size;
  for (i = 0; i < count; i++) {
    val = alphabet_compare(string1[i], string2[i]);
    if(val == "1st")
      return true;
    if(val == "2nd")
      return false;
  }
  return string1.size > string2.size;
}
alphabetize(array) {
  if(array.size <= 1)
    return array;
  count = 0;
  for (;;) {
    changed = false;
    for (i = 0; i < array.size - 1; i++) {
      if(is_later_in_alphabet(array[i], array[i + 1])) {
        val = array[i];
        array[i] = array[i + 1];
        array[i + 1] = val;
        changed = true;
        count++;
        if(count >= 9) {
          count = 0;
          wait(0.05);
        }
      }
    }
    if(!changed)
      return array;
  }
  return array;
}
get_players() {
  players = GetEntArray("player", "classname");
  return players;
}
getfx(fx) {
  assertEx(isDefined(level._effect[fx]), "Fx " + fx + " is not defined in level._effect.");
  return level._effect[fx];
}
struct_arraySpawn() {
  struct = SpawnStruct();
  struct.array = [];
  struct.lastindex = 0;
  return struct;
}
structarray_add(struct, object) {
  assert(!isDefined(object.struct_array_index));
  struct.array[struct.lastindex] = object;
  object.struct_array_index = struct.lastindex;
  struct.lastindex++;
}
structarray_remove(struct, object) {
  structarray_swaptolast(struct, object);
  struct.array[struct.lastindex - 1] = undefined;
  struct.lastindex--;
}
structarray_swaptolast(struct, object) {
  struct structarray_swap(struct.array[struct.lastindex - 1], object);
}
structarray_shuffle(struct, shuffle) {
  for (i = 0; i < shuffle; i++)
    struct structarray_swap(struct.array[i], struct.array[randomint(struct.lastindex)]);
}
structarray_swap(object1, object2) {
  index1 = object1.struct_array_index;
  index2 = object2.struct_array_index;
  self.array[index2] = object1;
  self.array[index1] = object2;
  self.array[index1].struct_array_index = index1;
  self.array[index2].struct_array_index = index2;
}
waittill_either(msg1, msg2) {
  self endon(msg1);
  self waittill(msg2);
}
getClosest(org, array, dist) {
  return compareSizes(org, array, dist, ::closerFunc);
}
getClosestFx(org, fxarray, dist) {
  return compareSizesFx(org, fxarray, dist, ::closerFunc);
}
getFarthest(org, array, dist) {
  return compareSizes(org, array, dist, ::fartherFunc);
}
compareSizesFx(org, array, dist, compareFunc) {
  if(!array.size)
    return undefined;
  if(isDefined(dist)) {
    distSqr = dist * dist;
    struct = undefined;
    keys = getArrayKeys(array);
    for (i = 0; i < keys.size; i++) {
      newdistSqr = DistanceSquared(array[keys[i]].v["origin"], org);
      if([
          [compareFunc]
        ](newdistSqr, distSqr))
        continue;
      distSqr = newdistSqr;
      struct = array[keys[i]];
    }
    return struct;
  }
  keys = getArrayKeys(array);
  struct = array[keys[0]];
  distSqr = DistanceSquared(struct.v["origin"], org);
  for (i = 1; i < keys.size; i++) {
    newdistSqr = DistanceSquared(array[keys[i]].v["origin"], org);
    if([
        [compareFunc]
      ](newdistSqr, distSqr))
      continue;
    distSqr = newdistSqr;
    struct = array[keys[i]];
  }
  return struct;
}
compareSizes(org, array, dist, compareFunc) {
  if(!array.size)
    return undefined;
  if(isDefined(dist)) {
    distSqr = dist * dist;
    ent = undefined;
    keys = GetArrayKeys(array);
    for (i = 0; i < keys.size; i++) {
      newdistSqr = DistanceSquared(array[keys[i]].origin, org);
      if([
          [compareFunc]
        ](newdistSqr, distSqr))
        continue;
      distSqr = newdistSqr;
      ent = array[keys[i]];
    }
    return ent;
  }
  keys = GetArrayKeys(array);
  ent = array[keys[0]];
  distSqr = DistanceSquared(ent.origin, org);
  for (i = 1; i < keys.size; i++) {
    newdistSqr = DistanceSquared(array[keys[i]].origin, org);
    if([
        [compareFunc]
      ](newdistSqr, distSqr))
      continue;
    distSqr = newdistSqr;
    ent = array[keys[i]];
  }
  return ent;
}
closerFunc(dist1, dist2) {
  return dist1 >= dist2;
}
fartherFunc(dist1, dist2) {
  return dist1 <= dist2;
}
get_array_of_closest(org, array, excluders, max, maxdist) {
  if(!isDefined(max))
    max = array.size;
  if(!isDefined(excluders))
    excluders = [];
  maxdists2rd = undefined;
  if(isDefined(maxdist))
    maxdists2rd = maxdist * maxdist;
  dist = [];
  index = [];
  for (i = 0; i < array.size; i++) {
    excluded = false;
    for (p = 0; p < excluders.size; p++) {
      if(array[i] != excluders[p])
        continue;
      excluded = true;
      break;
    }
    if(excluded)
      continue;
    length = distancesquared(org, array[i].origin);
    if(isDefined(maxdists2rd) && maxdists2rd < length)
      continue;
    dist[dist.size] = length;
    index[index.size] = i;
  }
  for (;;) {
    change = false;
    for (i = 0; i < dist.size - 1; i++) {
      if(dist[i] <= dist[i + 1])
        continue;
      change = true;
      temp = dist[i];
      dist[i] = dist[i + 1];
      dist[i + 1] = temp;
      temp = index[i];
      index[i] = index[i + 1];
      index[i + 1] = temp;
    }
    if(!change) {
      break;
    }
  }
  newArray = [];
  if(max > dist.size)
    max = dist.size;
  for (i = 0; i < max; i++)
    newArray[i] = array[index[i]];
  return newArray;
}
set_dvar_if_unset(
  dvar,
  value,
  force) {
  if(GetDvar(dvar) == "" || (isDefined(force) && force)) {
    SetDvar(dvar, value);
    return value;
  }
  return GetDvar(dvar);
}
set_dvar_float_if_unset(
  dvar,
  value,
  force) {
  if(GetDvar(dvar) == "" || (isDefined(force) && force)) {
    SetDvar(dvar, value);
  }
  return GetDvarFloat(dvar);
}
set_dvar_int_if_unset(
  dvar,
  value,
  force) {
  if(GetDvar(dvar) == "" || (isDefined(force) && force)) {
    SetDvar(dvar, value);
    return int(value);
  }
  return GetDvarInt(dvar);
}
drawcylinder(pos, rad, height, duration, stop_notify) {}
drawcylinder_think(pos, rad, height, seconds, stop_notify) {}
is_bot() {
  return (isDefined(self.pers["isBot"]) && self.pers["isBot"] != 0);
}
add_trigger_to_ent(ent) {
  if(!isDefined(ent._triggers)) {
    ent._triggers = [];
  }
  ent._triggers[self GetEntityNumber()] = 1;
}
remove_trigger_from_ent(ent) {
  if(!isDefined(ent))
    return;
  if(!isDefined(ent._triggers))
    return;
  if(!isDefined(ent._triggers[self GetEntityNumber()]))
    return;
  ent._triggers[self GetEntityNumber()] = 0;
}
ent_already_in_trigger(trig) {
  if(!isDefined(self._triggers))
    return false;
  if(!isDefined(self._triggers[trig GetEntityNumber()]))
    return false;
  if(!self._triggers[trig GetEntityNumber()])
    return false;
  return true;
}
trigger_thread_death_monitor(ent, ender) {
  ent waittill("death");
  self endon(ender);
  self remove_trigger_from_ent(ent);
}
trigger_thread(ent, on_enter_payload, on_exit_payload) {
  ent endon("entityshutdown");
  ent endon("death");
  if(ent ent_already_in_trigger(self))
    return;
  self add_trigger_to_ent(ent);
  ender = "end_trig_death_monitor" + self GetEntityNumber() + " " + ent GetEntityNumber();
  self thread trigger_thread_death_monitor(ent, ender);
  endon_condition = "leave_trigger_" + self GetEntityNumber();
  if(isDefined(on_enter_payload)) {
    self thread[[on_enter_payload]](ent, endon_condition);
  }
  while (isDefined(ent) && ent IsTouching(self)) {
    wait(0.01);
  }
  ent notify(endon_condition);
  if(isDefined(ent) && isDefined(on_exit_payload)) {
    self thread[[on_exit_payload]](ent);
  }
  if(isDefined(ent)) {
    self remove_trigger_from_ent(ent);
  }
  self notify(ender);
}
isOneRound() {
  if(level.roundLimit == 1)
    return true;
  return false;
}
isFirstRound() {
  if(level.roundLimit > 1 && game["roundsplayed"] == 0)
    return true;
  return false;
}
isLastRound() {
  if(level.roundLimit > 1 && game["roundsplayed"] >= (level.roundLimit - 1))
    return true;
  return false;
}
wasLastRound() {
  if(level.forcedEnd)
    return true;
  if(hitRoundLimit() || hitScoreLimit() || hitRoundWinLimit())
    return true;
  return false;
}
hitRoundLimit() {
  if(level.roundLimit <= 0)
    return false;
  return (getRoundsPlayed() >= level.roundLimit);
}
hitRoundWinLimit() {
  if(!isDefined(level.roundWinLimit) || level.roundWinLimit <= 0)
    return false;
  if(getRoundsWon("allies") >= level.roundWinLimit || getRoundsWon("axis") >= level.roundWinLimit) {
    return true;
  }
  if(getRoundsWon("allies") + game["roundswon"]["tie"] >= level.roundWinLimit ||
    getRoundsWon("axis") + game["roundswon"]["tie"] >= level.roundWinLimit) {
    if(getRoundsWon("allies") != getRoundsWon("axis")) {
      return true;
    }
  }
  return false;
}
hitScoreLimit() {
  if(isScoreRoundBased())
    return false;
  if(level.scoreLimit <= 0)
    return false;
  if(level.teamBased) {
    if(game["teamScores"]["allies"] >= level.scoreLimit || game["teamScores"]["axis"] >= level.scoreLimit)
      return true;
  } else {
    for (i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.score) && player.score >= level.scorelimit)
        return true;
    }
  }
  return false;
}
getRoundsWon(team) {
  return game["roundswon"][team];
}
getRoundsPlayed() {
  return game["roundsplayed"];
}
isScoreRoundBased() {
  return level.scoreRoundBased;
}
isRoundBased() {
  if(level.roundLimit != 1 && level.roundWinLimit != 1)
    return true;
  return false;
}
waitTillNotMoving() {
  if(self maps\mp\gametypes\_weaponobjects::isHacked()) {
    wait(0.05);
    return;
  }
  if(self.classname == "grenade") {
    self waittill("stationary");
  } else {
    prevorigin = self.origin;
    while (1) {
      wait .15;
      if(self.origin == prevorigin) {
        break;
      }
      prevorigin = self.origin;
    }
  }
}
mayApplyScreenEffect() {
  if(isDefined(self.viewlockedentity))
    return false;
  return true;
}
getDvarFloatDefault(dvarName, defaultValue) {
  returnVal = defaultValue;
  if(getDvar(dvarName) != "") {
    return getDvarFloat(dvarName);
  }
  return returnVal;
}
getDvarIntDefault(dvarName, defaultValue) {
  returnVal = defaultValue;
  if(getDvar(dvarName) != "") {
    return getDvarInt(dvarName);
  }
  return returnVal;
}
dropAllToGround(origin, radius, stickyObjectRadius) {
  PhysicsExplosionSphere(origin, radius, radius, 0);
  wait(0.05);
  maps\mp\gametypes\_weapons::dropWeaponsToGround(origin, radius);
  maps\mp\gametypes\_supplydrop::dropCratesToGround(origin, radius);
  level notify("drop_objects_to_ground", origin, stickyObjectRadius);
}
closestPointOnLine(point, lineStart, lineEnd) {
  lineMagSqrd = lengthsquared(lineEnd - lineStart);
  t = (((point[0] - lineStart[0]) * (lineEnd[0] - lineStart[0])) +
      ((point[1] - lineStart[1]) * (lineEnd[1] - lineStart[1])) +
      ((point[2] - lineStart[2]) * (lineEnd[2] - lineStart[2]))) /
    (lineMagSqrd);
  if(t < 0.0) {
    return lineStart;
  } else if(t > 1.0) {
    return lineEnd;
  }
  start_x = lineStart[0] + t * (lineEnd[0] - lineStart[0]);
  start_y = lineStart[1] + t * (lineEnd[1] - lineStart[1]);
  start_z = lineStart[2] + t * (lineEnd[2] - lineStart[2]);
  return (start_x, start_y, start_z);
}
isStrStart(string1, subStr) {
  return (getSubStr(string1, 0, subStr.size) == subStr);
}
spread_array_thread(entities, process, var1, var2, var3) {
  keys = getArrayKeys(entities);
  if(isDefined(var3)) {
    for (i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1, var2, var3);
      wait .1;
    }
    return;
  }
  if(isDefined(var2)) {
    for (i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1, var2);
      wait .1;
    }
    return;
  }
  if(isDefined(var1)) {
    for (i = 0; i < keys.size; i++) {
      entities[keys[i]] thread[[process]](var1);
      wait .1;
    }
    return;
  }
  for (i = 0; i < keys.size; i++) {
    entities[keys[i]] thread[[process]]();
    wait .1;
  }
}
freeze_player_controls(boolean) {
  AssertEx(isDefined(boolean), "'freeze_player_controls()' has not been passed an argument properly.");
  if(boolean && IsAlive(self)) {
    self FreezeControls(boolean);
  } else if(!boolean && IsAlive(self) && !level.gameEnded) {
    self FreezeControls(boolean);
  }
}
getHostPlayer() {
  players = get_players();
  for (index = 0; index < players.size; index++) {
    if(players[index] IsHost())
      return players[index];
  }
}
isPreGame() {
  return isDefined(level.pregame) && level.pregame;
}
isKillStreaksEnabled() {
  return isDefined(level.killstreaksenabled) && level.killstreaksenabled;
}
ishardPointsEnabled() {
  return isDefined(level.hardpointsenabled) && level.hardpointsenabled;
}
isRankEnabled() {
  return isDefined(level.rankEnabled) && level.rankEnabled;
}
playSmokeSound(position, duration, startSound, stopSound, loopSound) {
  smokeSound = spawn("script_origin", (0, 0, 1));
  smokeSound.origin = position;
  smokeSound playsound(startSound);
  smokeSound playLoopSound(loopSound);
  if(duration > 0.5)
    wait(duration - 0.5);
  thread playSoundinSpace(stopSound, position);
  smokeSound StopLoopSound(.5);
  wait(.5);
  smokeSound delete();
}
playSoundinSpace(alias, origin, master) {
  org = spawn("script_origin", (0, 0, 1));
  if(!isDefined(origin))
    origin = self.origin;
  org.origin = origin;
  if(isDefined(master) && master)
    org playsoundasmaster(alias);
  else
    org playsound(alias);
  wait(10.0);
  org delete();
}
get2DYaw(start, end) {
  yaw = 0;
  vector = (end[0] - start[0], end[1] - start[1], 0);
  return vecToAngles(vector);
}
vecToAngles(vector) {
  yaw = 0;
  vecX = vector[0];
  vecY = vector[1];
  if(vecX == 0 && vecY == 0)
    return 0;
  if(vecY < 0.001 && vecY > -0.001)
    vecY = 0.001;
  yaw = atan(vecX / vecY);
  if(vecY < 0)
    yaw += 180;
  return (90 - yaw);
}

