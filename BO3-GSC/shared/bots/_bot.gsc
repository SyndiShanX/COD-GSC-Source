/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\bots\_bot.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\bots\bot_buttons;
#using scripts\shared\bots\bot_traversals;
#using scripts\shared\callbacks_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace bot;

function autoexec __init__sytem__() {
  system::register("bot", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  callback::on_player_killed(&on_player_killed);
  if(!isDefined(level.getbotsettings)) {
    level.getbotsettings = &get_bot_default_settings;
  }
  if(!isDefined(level.onbotremove)) {
    level.onbotremove = &bot_void;
  }
  if(!isDefined(level.onbotconnect)) {
    level.onbotconnect = &bot_void;
  }
  if(!isDefined(level.onbotspawned)) {
    level.onbotspawned = &bot_void;
  }
  if(!isDefined(level.onbotkilled)) {
    level.onbotkilled = &bot_void;
  }
  if(!isDefined(level.onbotdamage)) {
    level.onbotdamage = &bot_void;
  }
  if(!isDefined(level.botupdate)) {
    level.botupdate = &bot_update;
  }
  if(!isDefined(level.botprecombat)) {
    level.botprecombat = &bot_void;
  }
  if(!isDefined(level.botcombat)) {
    level.botcombat = &bot_combat::combat_think;
  }
  if(!isDefined(level.botpostcombat)) {
    level.botpostcombat = &bot_void;
  }
  if(!isDefined(level.botidle)) {
    level.botidle = &bot_void;
  }
  if(!isDefined(level.botthreatdead)) {
    level.botthreatdead = &bot_combat::clear_threat;
  }
  if(!isDefined(level.botthreatengage)) {
    level.botthreatengage = &bot_combat::engage_threat;
  }
  if(!isDefined(level.botupdatethreatgoal)) {
    level.botupdatethreatgoal = &bot_combat::update_threat_goal;
  }
  if(!isDefined(level.botthreatlost)) {
    level.botthreatlost = &bot_combat::clear_threat;
  }
  if(!isDefined(level.botgetthreats)) {
    level.botgetthreats = &bot_combat::get_bot_threats;
  }
  if(!isDefined(level.botignorethreat)) {
    level.botignorethreat = &bot_combat::ignore_non_sentient;
  }
  setDvar("bot_maxMantleHeight", 200);
  level thread bot_devgui_think();
}

function init() {
  init_bot_settings();
}

function is_bot_ranked_match() {
  return false;
}

function bot_void() {}

function bot_unhandled() {
  return false;
}

function add_bots(count, team) {
  for(i = 0; i < count; i++) {
    add_bot(team);
  }
}

function add_bot(team) {
  botent = addtestclient();
  if(!isDefined(botent)) {
    return undefined;
  }
  botent botsetrandomcharactercustomization();
  if(isDefined(level.disableclassselection) && level.disableclassselection) {
    botent.pers["class"] = level.defaultclass;
    botent.curclass = level.defaultclass;
  }
  if(level.teambased && team !== "autoassign") {
    botent.pers["team"] = team;
  }
  return botent;
}

function remove_bots(count, team) {
  players = getplayers();
  foreach(player in players) {
    if(!player istestclient()) {
      continue;
    }
    if(isDefined(team) && player.team != team) {
      continue;
    }
    remove_bot(player);
    if(isDefined(count)) {
      count--;
      if(count <= 0) {
        break;
      }
    }
  }
}

function remove_bot(bot) {
  if(!bot istestclient()) {
    return;
  }
  bot[[level.onbotremove]]();
  bot botdropclient();
}

function filter_bots(players) {
  bots = [];
  foreach(player in players) {
    if(player util::is_bot()) {
      bots[bots.size] = player;
    }
  }
  return bots;
}

function on_player_connect() {
  if(!self istestclient()) {
    return;
  }
  self endon("disconnect");
  self.bot = spawnStruct();
  self.bot.threat = spawnStruct();
  self.bot.damage = spawnStruct();
  self.pers["isBot"] = 1;
  if(level.teambased) {
    self notify("menuresponse", game["menu_team"], self.team);
    wait(0.5);
  }
  self notify("joined_team");
  callback::callback("hash_95a6c4c0");
  self thread[[level.onbotconnect]]();
}

function on_player_spawned() {
  if(!self util::is_bot()) {
    return;
  }
  self clear_stuck();
  self bot_combat::clear_threat();
  self.bot.prevweapon = undefined;
  self botlookforward();
  self thread[[level.onbotspawned]]();
  self thread bot_combat::wait_damage_loop();
  self thread wait_bot_path_failed_loop();
  self thread wait_bot_goal_reached_loop();
  self thread bot_think_loop();
}

function on_player_killed() {
  if(!self util::is_bot()) {
    return;
  }
  self thread[[level.onbotkilled]]();
  self botreleasemanualcontrol();
}

function bot_think_loop() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self bot_think();
    wait(level.botsettings.thinkinterval);
  }
}

function bot_think() {
  self botreleasebuttons();
  if(level.inprematchperiod || level.gameended || !isalive(self)) {
    return;
  }
  self check_stuck();
  self sprint_think();
  self update_swim();
  self thread[[level.botupdate]]();
  self thread[[level.botprecombat]]();
  self thread[[level.botcombat]]();
  self thread[[level.botpostcombat]]();
  if(!self bot_combat::has_threat() && !self botgoalset()) {
    self thread[[level.botidle]]();
  }
}

function bot_update() {}

function update_swim() {
  if(!self isplayerswimming()) {
    self.bot.resurfacetime = undefined;
    return;
  }
  if(self isplayerunderwater()) {
    if(!isDefined(self.bot.resurfacetime)) {
      self.bot.resurfacetime = gettime() + level.botsettings.swimtime;
    }
  } else {
    self.bot.resurfacetime = undefined;
  }
  if(self botundermanualcontrol()) {
    return;
  }
  goalposition = self botgetgoalposition();
  if(distance2dsquared(goalposition, self.origin) <= 16384 && getwaterheight(goalposition) > 0) {
    self press_swim_down();
    return;
  }
  if(isDefined(self.bot.resurfacetime) && self.bot.resurfacetime <= gettime()) {
    press_swim_up();
    return;
  }
  bottomtrace = groundtrace(self.origin, self.origin + (vectorscale((0, 0, -1), 1000)), 0, self, 1);
  swimheight = self.origin[2] - bottomtrace["position"][2];
  if(swimheight < 25) {
    self press_swim_up();
    vertdist = 25 - swimheight;
  } else if(swimheight > 45) {
    self press_swim_down();
    vertdist = swimheight - 45;
  }
  if(isDefined(vertdist)) {
    intervaldist = level.botsettings.swimverticalspeed * level.botsettings.thinkinterval;
    if(intervaldist > vertdist) {
      self wait_release_swim_buttons((level.botsettings.thinkinterval * vertdist) / intervaldist);
    }
  }
}

function wait_release_swim_buttons(waittime) {
  self endon("death");
  level endon("game_ended");
  wait(waittime);
  self release_swim_up();
  self release_swim_down();
}

function init_bot_settings() {
  level.botsettings = [[level.getbotsettings]]();
  setDvar("bot_AllowMelee", (isDefined(level.botsettings.allowmelee) ? level.botsettings.allowmelee : 0));
  setDvar("bot_AllowGrenades", (isDefined(level.botsettings.allowgrenades) ? level.botsettings.allowgrenades : 0));
  setDvar("bot_AllowKillstreaks", (isDefined(level.botsettings.allowkillstreaks) ? level.botsettings.allowkillstreaks : 0));
  setDvar("bot_AllowHeroGadgets", (isDefined(level.botsettings.allowherogadgets) ? level.botsettings.allowherogadgets : 0));
  setDvar("bot_Fov", (isDefined(level.botsettings.fov) ? level.botsettings.fov : 0));
  setDvar("bot_FovAds", (isDefined(level.botsettings.fovads) ? level.botsettings.fovads : 0));
  setDvar("bot_PitchSensitivity", level.botsettings.pitchsensitivity);
  setDvar("bot_YawSensitivity", level.botsettings.yawsensitivity);
  setDvar("bot_PitchSpeed", (isDefined(level.botsettings.pitchspeed) ? level.botsettings.pitchspeed : 0));
  setDvar("bot_PitchSpeedAds", (isDefined(level.botsettings.pitchspeedads) ? level.botsettings.pitchspeedads : 0));
  setDvar("bot_YawSpeed", (isDefined(level.botsettings.yawspeed) ? level.botsettings.yawspeed : 0));
  setDvar("bot_YawSpeedAds", (isDefined(level.botsettings.yawspeedads) ? level.botsettings.yawspeedads : 0));
  setDvar("pitchAccelerationTime", (isDefined(level.botsettings.pitchaccelerationtime) ? level.botsettings.pitchaccelerationtime : 0));
  setDvar("yawAccelerationTime", (isDefined(level.botsettings.yawaccelerationtime) ? level.botsettings.yawaccelerationtime : 0));
  setDvar("pitchDecelerationThreshold", (isDefined(level.botsettings.pitchdecelerationthreshold) ? level.botsettings.pitchdecelerationthreshold : 0));
  setDvar("yawDecelerationThreshold", (isDefined(level.botsettings.yawdecelerationthreshold) ? level.botsettings.yawdecelerationthreshold : 0));
  meleerange = getdvarint("player_meleeRangeDefault") * (isDefined(level.botsettings.meleerangemultiplier) ? level.botsettings.meleerangemultiplier : 0);
  level.botsettings.meleerange = int(meleerange);
  level.botsettings.meleerangesq = meleerange * meleerange;
  level.botsettings.threatradiusminsq = level.botsettings.threatradiusmin * level.botsettings.threatradiusmin;
  level.botsettings.threatradiusmaxsq = level.botsettings.threatradiusmax * level.botsettings.threatradiusmax;
  lethaldistancemin = (isDefined(level.botsettings.lethaldistancemin) ? level.botsettings.lethaldistancemin : 0);
  level.botsettings.lethaldistanceminsq = lethaldistancemin * lethaldistancemin;
  lethaldistancemax = (isDefined(level.botsettings.lethaldistancemax) ? level.botsettings.lethaldistancemax : 1024);
  level.botsettings.lethaldistancemaxsq = lethaldistancemax * lethaldistancemax;
  tacticaldistancemin = (isDefined(level.botsettings.tacticaldistancemin) ? level.botsettings.tacticaldistancemin : 0);
  level.botsettings.tacticaldistanceminsq = tacticaldistancemin * tacticaldistancemin;
  tacticaldistancemax = (isDefined(level.botsettings.tacticaldistancemax) ? level.botsettings.tacticaldistancemax : 1024);
  level.botsettings.tacticaldistancemaxsq = tacticaldistancemax * tacticaldistancemax;
  level.botsettings.swimverticalspeed = getdvarfloat("player_swimVerticalSpeedMax");
  level.botsettings.swimtime = getdvarfloat("player_swimTime", 5) * 1000;
}

function get_bot_default_settings() {
  return struct::get_script_bundle("botsettings", "bot_default");
}

function sprint_to_goal() {
  self.bot.sprinttogoal = 1;
}

function end_sprint_to_goal() {
  self.bot.sprinttogoal = 0;
}

function sprint_think() {
  if(isDefined(self.bot.sprinttogoal) && self.bot.sprinttogoal) {
    if(self botgoalreached()) {
      self end_sprint_to_goal();
      return;
    }
    self press_sprint_button();
    return;
  }
}

function goal_in_trigger(trigger) {
  radius = self get_trigger_radius(trigger);
  return distancesquared(trigger.origin, self botgetgoalposition()) <= (radius * radius);
}

function point_in_goal(point) {
  deltasq = distance2dsquared(self botgetgoalposition(), point);
  goalradius = self botgetgoalradius();
  return deltasq <= (goalradius * goalradius);
}

function path_to_trigger(trigger, radius) {
  if(trigger.classname == "trigger_use" || trigger.classname == "trigger_use_touch") {
    if(!isDefined(radius)) {
      radius = get_trigger_radius(trigger);
    }
    randomangle = (0, randomint(360), 0);
    randomvec = anglesToForward(randomangle);
    point = trigger.origin + (randomvec * radius);
    self botsetgoal(point);
  }
  if(!isDefined(radius)) {
    radius = 0;
  }
  self botsetgoal(trigger.origin, int(radius));
}

function path_to_point_in_trigger(trigger) {
  mins = trigger getmins();
  maxs = trigger getmaxs();
  radius = min(maxs[0], maxs[1]);
  height = maxs[2] - mins[2];
  minorigin = trigger.origin + (0, 0, mins[2]);
  queryheight = height / 4;
  queryorigin = minorigin + (0, 0, queryheight);
  if(getdvarint("", 0)) {
    draws = 10;
    circle(queryorigin, radius, (0, 1, 0), 0, 1, 20 * draws);
    circle(queryorigin + (0, 0, queryheight), radius, (0, 1, 0), 0, 1, 20 * draws);
    circle(queryorigin - (0, 0, queryheight), radius, (0, 1, 0), 0, 1, 20 * draws);
  }
  queryresult = positionquery_source_navigation(queryorigin, 0, radius, queryheight, 17, self);
  best_point = undefined;
  foreach(point in queryresult.data) {
    point.score = randomfloatrange(0, 100);
    if(!isDefined(best_point) || point.score > best_point.score) {
      best_point = point;
    }
  }
  if(isDefined(best_point)) {
    self botsetgoal(best_point.origin, 24);
    return;
  }
  self path_to_trigger(trigger, radius);
}

function get_trigger_radius(trigger) {
  maxs = trigger getmaxs();
  if(trigger.classname == "trigger_radius") {
    return maxs[0];
  }
  return min(maxs[0], maxs[1]);
}

function get_trigger_height(trigger) {
  maxs = trigger getmaxs();
  if(trigger.classname == "trigger_radius") {
    return maxs[2];
  }
  return maxs[2] * 2;
}

function check_stuck() {
  if(!getdvarint("")) {
    return;
  }
  if(self botundermanualcontrol() || self botgoalreached() || self util::isstunned() || self ismeleeing() || self meleeButtonPressed() || (self bot_combat::has_threat() && self.bot.threat.lastdistancesq < 16384)) {
    return;
  }
  velocity = self getvelocity();
  if(velocity[0] == 0 && velocity[1] == 0 && (velocity[2] == 0 || self isplayerswimming())) {
    if(!isDefined(self.bot.stuckcycles)) {
      self.bot.stuckcycles = 0;
    }
    self.bot.stuckcycles++;
    if(self.bot.stuckcycles >= 3) {
      if(getdvarint("", 0)) {
        sphere(self.origin, 16, (1, 0, 0), 0.25, 0, 16, 1200);
        iprintln((("" + self.name) + "") + self.origin);
      }
      self thread stuck_resolution();
    }
  } else {
    self.bot.stuckcycles = 0;
  }
  if(!self bot_combat::threat_visible()) {
    self check_stuck_position();
  }
}

function check_stuck_position() {
  if(gettime() < self.bot.checkpositiontime) {
    return;
  }
  self.bot.checkpositiontime = gettime() + 500;
  self.bot.positionhistory[self.bot.positionhistoryindex] = self.origin;
  self.bot.positionhistoryindex = (self.bot.positionhistoryindex + 1) % 5;
  if(self.bot.positionhistory.size < 5) {
    return;
  }
  maxdistsq = undefined;
  for(i = 0; i < self.bot.positionhistory.size; i++) {
    if(getdvarint("", 0)) {
      line(self.bot.positionhistory[i], self.bot.positionhistory[i] + vectorscale((0, 0, 1), 72), (0, 1, 0), 1, 0, 10);
    }
    for(j = i + 1; j < self.bot.positionhistory.size; j++) {
      distsq = distancesquared(self.bot.positionhistory[i], self.bot.positionhistory[j]);
      if(distsq > 16384) {
        return;
      }
    }
  }
  if(getdvarint("", 0)) {
    sphere(self.origin, 128, (1, 0, 0), 0.25, 0, 16, 1200);
    iprintln((("" + self.name) + "") + self.origin);
  }
  self thread stuck_resolution();
}

function stuck_resolution() {
  self endon("death");
  level endon("game_ended");
  self clear_stuck();
  self bottakemanualcontrol();
  escapeangle = (self getangles()[1] + 180) + (randomintrange(-60, 60));
  escapedir = anglesToForward((0, escapeangle, 0));
  self botsetmoveangle(escapedir);
  self botsetmovemagnitude(1);
  wait(1.5);
  self botreleasemanualcontrol();
}

function clear_stuck() {
  self.bot.stuckcycles = 0;
  self.bot.positionhistory = [];
  self.bot.positionhistoryindex = 0;
  self.bot.checkpositiontime = 0;
}

function camp() {
  self botsetgoal(self.origin);
  self press_crouch_button();
}

function wait_bot_path_failed_loop() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self waittill("bot_path_failed", reason);
    if(getdvarint("", 0)) {
      goalposition = self botgetgoalposition();
      box(self.origin, vectorscale((-1, -1, 0), 15), (15, 15, 72), 0, (0, 1, 0), 0.25, 0, 1200);
      box(goalposition, vectorscale((-1, -1, 0), 15), (15, 15, 72), 0, (1, 0, 0), 0.25, 0, 1200);
      line(self.origin, goalposition, (1, 1, 1), 1, 0, 1200);
      iprintln((((("" + self.name) + "") + self.origin) + "") + goalposition);
    }
    self thread stuck_resolution();
  }
}

function wait_bot_goal_reached_loop() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    self waittill("bot_goal_reached", reason);
    self clear_stuck();
  }
}

function stow_gun_gadget() {
  currentweapon = self getcurrentweapon();
  if(self getweaponammoclip(currentweapon) || !currentweapon.isheroweapon) {
    return;
  }
  if(isDefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
    self switchtoweapon(self.lastdroppableweapon);
  }
}

function get_ready_gadget() {
  weapons = self getweaponslist();
  foreach(weapon in weapons) {
    slot = self gadgetgetslot(weapon);
    if(slot < 0 || !self gadgetisready(slot) || self gadgetisactive(slot)) {
      continue;
    }
    return weapon;
  }
  return level.weaponnone;
}

function get_ready_gun_gadget() {
  weapons = self getweaponslist();
  foreach(weapon in weapons) {
    if(!is_gun_gadget(weapon)) {
      continue;
    }
    slot = self gadgetgetslot(weapon);
    if(slot < 0 || !self gadgetisready(slot) || self gadgetisactive(slot)) {
      continue;
    }
    return weapon;
  }
  return level.weaponnone;
}

function is_gun_gadget(weapon) {
  if(!isDefined(weapon) || weapon == level.weaponnone || !weapon.isheroweapon) {
    return 0;
  }
  return weapon.isbulletweapon || weapon.isprojectileweapon || weapon.islauncher || weapon.isgasweapon;
}

function activate_hero_gadget(weapon) {
  if(!isDefined(weapon) || weapon == level.weaponnone || !weapon.isgadget) {
    return;
  }
  if(is_gun_gadget(weapon)) {
    self switchtoweapon(weapon);
  } else {
    if(weapon.isheroweapon) {
      self tap_offhand_special_button();
    } else {
      self botpressbuttonforgadget(weapon);
    }
  }
}

function coop_pre_combat() {
  self bot_combat::bot_pre_combat();
  if(self bot_combat::has_threat()) {
    return;
  }
  if(self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self ismeleeing() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
    return;
  }
  if(self bot_combat::switch_weapon()) {
    return;
  }
  if(self bot_combat::reload_weapon()) {
    return;
  }
}

function coop_post_combat() {
  if(self revive_players()) {
    if(self bot_combat::has_threat()) {
      self bot_combat::clear_threat();
      self botsetgoal(self.origin);
    }
    return;
  }
  self bot_combat::bot_post_combat();
}

function follow_coop_players() {
  host = get_host_player();
  if(!isalive(host)) {
    players = arraysort(level.players, self.origin);
    foreach(player in players) {
      if(!player util::is_bot() && player.team == self.team && isalive(player)) {
        break;
      }
    }
  } else {
    player = host;
  }
  if(isDefined(player)) {
    fwd = anglesToForward(player.angles);
    botdir = self.origin - player.origin;
    if(vectordot(botdir, fwd) < 0) {
      self thread lead_player(player, 150);
    }
  }
}

function lead_player(player, followmin) {
  radiusmin = followmin - 32;
  radiusmax = followmin;
  dotmin = 0.85;
  dotmax = 0.92;
  queryresult = positionquery_source_navigation(player.origin, radiusmin, radiusmax, 150, 32, self);
  fwd = anglesToForward(player.angles);
  point = player.origin + (fwd * 72);
  self botsetgoal(point, 42);
  self sprint_to_goal();
}

function follow_entity(entity, radiusmin = 24, radiusmax = radiusmin + 1) {
  if(!point_in_goal(entity.origin)) {
    radius = randomintrange(radiusmin, radiusmax);
    self botsetgoal(entity.origin, radius);
    self sprint_to_goal();
  }
}

function navmesh_wander(fwd, radiusmin = (isDefined(level.botsettings.wandermin) ? level.botsettings.wandermin : 0), radiusmax, spacing, fwddot) {
  if(!isDefined(radiusmax)) {
    radiusmax = (isDefined(level.botsettings.wandermax) ? level.botsettings.wandermax : 0);
  }
  if(!isDefined(spacing)) {
    spacing = (isDefined(level.botsettings.wanderspacing) ? level.botsettings.wanderspacing : 0);
  }
  if(!isDefined(fwddot)) {
    fwddot = (isDefined(level.botsettings.wanderfwddot) ? level.botsettings.wanderfwddot : 0);
  }
  if(!isDefined(fwd)) {
    fwd = anglesToForward(self.angles);
  }
  fwd = vectornormalize((fwd[0], fwd[1], 0));
  queryresult = positionquery_source_navigation(self.origin, radiusmin, radiusmax, 150, spacing, self);
  best_point = undefined;
  origin = (self.origin[0], self.origin[1], 0);
  foreach(point in queryresult.data) {
    movepoint = (point.origin[0], point.origin[1], 0);
    movedir = vectornormalize(movepoint - origin);
    dot = vectordot(movedir, fwd);
    point.score = mapfloat(radiusmin, radiusmax, 0, 50, point.disttoorigin2d);
    if(dot > fwddot) {
      point.score = point.score + randomfloatrange(30, 50);
    } else {
      if(dot > 0) {
        point.score = point.score + randomfloatrange(10, 35);
      } else {
        point.score = point.score + randomfloatrange(0, 15);
      }
    }
    if(!isDefined(best_point) || point.score > best_point.score) {
      best_point = point;
    }
  }
  if(isDefined(best_point)) {
    self botsetgoal(best_point.origin, radiusmin);
  } else {
    circle(self.origin, radiusmin, (1, 0, 0), 0, 1, 1200);
    circle(self.origin, radiusmax, (1, 0, 0), 0, 1, 1200);
    sphere(self.origin, 16, (0, 1, 0), 0.25, 0, 16, 1200);
    iprintln((("" + self.name) + "") + self.origin);
    if(getdvarint("", 0)) {}
    self thread stuck_resolution();
  }
}

function approach_goal_trigger(trigger, radiusmax = 1500, spacing = 128) {
  distsq = distancesquared(self.origin, trigger.origin);
  if(distsq < (radiusmax * radiusmax)) {
    self path_to_point_in_trigger(trigger);
    return;
  }
  radiusmin = self get_trigger_radius(trigger);
  self approach_point(trigger.origin, radiusmin, radiusmax, spacing);
}

function approach_point(point, radiusmin = 0, radiusmax = 1500, spacing = 128) {
  distsq = distancesquared(self.origin, point);
  if(distsq < (radiusmax * radiusmax)) {
    self botsetgoal(point, 24);
    return;
  }
  queryresult = positionquery_source_navigation(point, radiusmin, radiusmax, 150, spacing, self);
  fwd = anglesToForward(self.angles);
  fwd = (fwd[0], fwd[1], 0);
  origin = (self.origin[0], self.origin[1], 0);
  best_point = undefined;
  foreach(point in queryresult.data) {
    movepoint = (point.origin[0], point.origin[1], 0);
    movedir = vectornormalize(movepoint - origin);
    dot = vectordot(movedir, fwd);
    point.score = randomfloatrange(0, 50);
    if(dot < 0.5) {
      point.score = point.score + randomfloatrange(30, 50);
    } else {
      point.score = point.score + randomfloatrange(0, 15);
    }
    if(!isDefined(best_point) || point.score > best_point.score) {
      best_point = point;
    }
  }
  if(isDefined(best_point)) {
    self botsetgoal(best_point.origin, 24);
  }
}

function revive_players() {
  players = self get_team_players_in_laststand();
  if(players.size > 0) {
    revive_player(players[0]);
    return true;
  }
  return false;
}

function get_team_players_in_laststand() {
  players = [];
  foreach(player in level.players) {
    if(player != self && player laststand::player_is_in_laststand() && player.team == self.team) {
      players[players.size] = player;
    }
  }
  players = arraysort(players, self.origin);
  return players;
}

function revive_player(player) {
  if(!point_in_goal(player.origin)) {
    self botsetgoal(player.origin, 64);
    self sprint_to_goal();
    return;
  }
  if(self botgoalreached()) {
    self botsetlookanglesfrompoint(player getcentroid());
    self tap_use_button();
  }
}

function watch_bot_corner(startcornerdist, cornerdist) {
  self endon("death");
  self endon("bot_combat_target");
  level endon("game_ended");
  if(!isDefined(startcornerdist)) {
    startcornerdist = 64;
  }
  if(!isDefined(cornerdist)) {
    cornerdist = 128;
  }
  startcornerdistsq = cornerdist * cornerdist;
  cornerdistsq = cornerdist * cornerdist;
  while(true) {
    self waittill("bot_corner", centerpoint, enterpoint, leavepoint, angle, nextenterpoint);
    if(self bot_combat::has_threat()) {
      continue;
    }
    if(distance2dsquared(self.origin, enterpoint) < startcornerdistsq || distance2dsquared(leavepoint, nextenterpoint) < cornerdistsq) {
      continue;
    }
    self thread wait_corner_radius(startcornerdistsq, centerpoint, enterpoint, leavepoint, angle, nextenterpoint);
  }
}

function wait_corner_radius(startcornerdistsq, centerpoint, enterpoint, leavepoint, angle, nextenterpoint) {
  self endon("death");
  self endon("bot_corner");
  self endon("bot_goal_reached");
  self endon("bot_combat_target");
  level endon("game_ended");
  while(distance2dsquared(self.origin, enterpoint) > startcornerdistsq) {
    if(self bot_combat::has_threat()) {
      return;
    }
    wait(0.05);
  }
  self botlookatpoint((nextenterpoint[0], nextenterpoint[1], nextenterpoint[1] + 60));
  self thread finish_corner();
}

function finish_corner() {
  self endon("death");
  self endon("combat_target");
  level endon("game_ended");
  self util::waittill_any("bot_corner", "bot_goal_reached");
  self botlookforward();
}

function get_host_player() {
  players = getplayers();
  foreach(player in players) {
    if(player ishost()) {
      return player;
    }
  }
  return undefined;
}

function fwd_dot(point) {
  angles = self getplayerangles();
  fwd = anglesToForward(angles);
  delta = point - self getEye();
  delta = vectornormalize(delta);
  dot = vectordot(fwd, delta);
  return dot;
}

function has_launcher() {
  weapons = self getweaponslist();
  foreach(weapon in weapons) {
    if(weapon.isrocketlauncher) {
      return true;
    }
  }
  return false;
}

function kill_bot() {
  self dodamage(self.health, self.origin);
}

function kill_bots() {
  foreach(player in level.players) {
    if(player util::is_bot()) {
      player kill_bot();
    }
  }
}

function add_bot_at_eye_trace(team) {
  host = util::gethostplayer();
  trace = host eye_trace();
  direction_vec = host.origin - trace[""];
  direction = vectortoangles(direction_vec);
  yaw = direction[1];
  bot = add_bot(team);
  if(isDefined(bot)) {
    bot waittill("spawned_player");
    bot setorigin(trace[""]);
    bot setplayerangles((bot.angles[0], yaw, bot.angles[2]));
  }
  return bot;
}

function eye_trace() {
  direction = self getplayerangles();
  direction_vec = anglesToForward(direction);
  eye = self getEye();
  scale = 8000;
  direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
  return bulletTrace(eye, eye + direction_vec, 0, undefined);
}

function devgui_debug_route() {
  iprintln("");
  points = self get_nav_points();
  if(!isDefined(points) || points.size == 0) {
    iprintln("");
    return;
  }
  iprintln("");
  players = getplayers();
  foreach(player in players) {
    if(!player util::is_bot()) {
      continue;
    }
    player thread debug_patrol(points);
  }
}

function get_nav_points() {
  iprintln("");
  iprintln("");
  iprintln("");
  points = [];
  while(true) {
    wait(0.05);
    point = self eye_trace()[""];
    if(isDefined(point)) {
      point = getclosestpointonnavmesh(point, 128);
      if(isDefined(point)) {
        sphere(point, 16, (0, 0, 1), 0.25, 0, 16, 1);
      }
    }
    if(self buttonPressed("")) {
      if(isDefined(point) && (points.size == 0 || (distance2d(point, points[points.size - 1])) > 16)) {
        points[points.size] = point;
      }
    } else {
      if(self buttonPressed("")) {
        return points;
      }
      if(self buttonPressed("")) {
        return undefined;
      }
    }
    for(i = 0; i < points.size; i++) {
      sphere(points[i], 16, (0, 1, 0), 0.25, 0, 16, 1);
    }
  }
}

function debug_patrol(points) {
  self notify("debug_patrol");
  self endon("death");
  self endon("debug_patrol");
  i = 0;
  while(true) {
    self botsetgoal(points[i], 24);
    self sprint_to_goal();
    self waittill("bot_goal_reached");
    i = (i + 1) % points.size;
  }
}

function bot_devgui_think() {
  while(true) {
    wait(0.25);
    cmd = getdvarstring("", "");
    if(!isDefined(level.botdevguicmd) || ![[level.botdevguicmd]](cmd)) {
      host = util::gethostplayer();
      switch (cmd) {
        case "": {
          remove_bots();
          break;
        }
        case "": {
          kill_bots();
          break;
        }
        case "": {
          host devgui_debug_route();
          break;
        }
        default: {
          break;
        }
      }
    }
    setDvar("", "");
  }
}

function coop_bot_devgui_cmd(cmd) {
  host = get_host_player();
  switch (cmd) {
    case "": {
      add_bot(host.team);
      return true;
    }
    case "": {
      add_bots(3, host.team);
      return true;
    }
    case "": {
      add_bot_at_eye_trace();
      return true;
    }
    case "": {
      remove_bots(1);
      return true;
      break;
    }
  }
  return false;
}

function debug_star(origin, seconds, color) {
  if(!isDefined(seconds)) {
    seconds = 1;
  }
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }
  frames = int(20 * seconds);
  debugstar(origin, frames, color);
}