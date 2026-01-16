/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\bots\_bot_combat.gsc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\bot_buttons;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace bot_combat;

function combat_think() {
  if(self has_threat()) {
    if(self threat_is_alive()) {
      self update_threat();
    } else {
      self thread[[level.botthreatdead]]();
    }
  }
  if(!self has_threat() && !self get_new_threat()) {
    return;
  }
  if(self has_threat()) {
    if(!self threat_visible() || self.bot.threat.lastdistancesq > level.botsettings.threatradiusmaxsq) {
      self get_new_threat(level.botsettings.threatradiusmin);
    }
  }
  if(self threat_visible()) {
    self thread[[level.botupdatethreatgoal]]();
    self thread[[level.botthreatengage]]();
  } else {
    self thread[[level.botthreatlost]]();
  }
}

function is_alive(entity) {
  return isalive(entity);
}

function get_bot_threats(maxdistance = 0) {
  return self botgetthreats(maxdistance);
}

function get_ai_threats() {
  return getaiteamarray("axis");
}

function ignore_none(entity) {
  return false;
}

function ignore_non_sentient(entity) {
  return !issentient(entity);
}

function has_threat() {
  return isdefined(self.bot.threat.entity);
}

function threat_visible() {
  return self has_threat() && self.bot.threat.visible;
}

function threat_is_alive() {
  if(!self has_threat()) {
    return 0;
  }
  if(isdefined(level.botthreatisalive)) {
    return self[[level.botthreatisalive]](self.bot.threat.entity);
  }
  return isalive(self.bot.threat.entity);
}

function set_threat(entity) {
  self.bot.threat.entity = entity;
  self.bot.threat.aimoffset = self get_aim_offset(entity);
  self update_threat(1);
}

function clear_threat() {
  self.bot.threat.entity = undefined;
  self clear_threat_aim();
  self botlookforward();
}

function update_threat(newthreat) {
  if(isdefined(newthreat) && newthreat) {
    self.bot.threat.wasvisible = 0;
    self clear_threat_aim();
  } else {
    self.bot.threat.wasvisible = self.bot.threat.visible;
  }
  velocity = self.bot.threat.entity getvelocity();
  distancesq = distancesquared(self geteye(), self.bot.threat.entity.origin);
  predictiontime = (isdefined(level.botsettings.thinkinterval) ? level.botsettings.thinkinterval : 0.05);
  predictedposition = self.bot.threat.entity.origin + (velocity * predictiontime);
  aimpoint = predictedposition + self.bot.threat.aimoffset;
  dot = self bot::fwd_dot(aimpoint);
  fov = self botgetfov();
  if(isdefined(newthreat) && newthreat) {
    self.bot.threat.visible = 1;
  } else if(dot < fov || !self botsighttrace(self.bot.threat.entity)) {
    self.bot.threat.visible = 0;
    return;
  }
  self.bot.threat.visible = 1;
  self.bot.threat.lastvisibletime = gettime();
  self.bot.threat.lastdistancesq = distancesq;
  self.bot.threat.lastvelocity = velocity;
  self.bot.threat.lastposition = predictedposition;
  self.bot.threat.aimpoint = aimpoint;
  self.bot.threat.dot = dot;
  weapon = self getcurrentweapon();
  weaponrange = weapon_range(weapon);
  self.bot.threat.inrange = distancesq < (weaponrange * weaponrange);
  weaponrangeclose = weapon_range_close(weapon);
  self.bot.threat.incloserange = distancesq < (weaponrangeclose * weaponrangeclose);
}

function get_new_threat(maxdistance) {
  entity = self get_greatest_threat(maxdistance);
  if(isdefined(entity) && entity !== self.bot.threat.entity) {
    self set_threat(entity);
    return true;
  }
  return false;
}

function get_greatest_threat(maxdistance) {
  threats = self[[level.botgetthreats]](maxdistance);
  if(!isdefined(threats)) {
    return undefined;
  }
  foreach(entity in threats) {
    if(self[[level.botignorethreat]](entity)) {
      continue;
    }
    return entity;
  }
  return undefined;
}

function engage_threat() {
  if(!self.bot.threat.wasvisible && self.bot.threat.visible && !self isthrowinggrenade() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self isswitchingweapons()) {
    visibleroll = randomint(100);
    rollweight = (isdefined(level.botsettings.lethalweight) ? level.botsettings.lethalweight : 0);
    if(visibleroll < rollweight && self.bot.threat.lastdistancesq >= level.botsettings.lethaldistanceminsq && self.bot.threat.lastdistancesq <= level.botsettings.lethaldistancemaxsq && self getweaponammostock(self.grenadetypeprimary)) {
      self clear_threat_aim();
      self throw_grenade(self.grenadetypeprimary, self.bot.threat.lastposition);
      return;
    }
    visibleroll = visibleroll - rollweight;
    rollweight = (isdefined(level.botsettings.tacticalweight) ? level.botsettings.tacticalweight : 0);
    if(visibleroll >= 0 && visibleroll < rollweight && self.bot.threat.lastdistancesq >= level.botsettings.tacticaldistanceminsq && self.bot.threat.lastdistancesq <= level.botsettings.tacticaldistancemaxsq && self getweaponammostock(self.grenadetypesecondary)) {
      self clear_threat_aim();
      self throw_grenade(self.grenadetypesecondary, self.bot.threat.lastposition);
      return;
    }
    self.bot.threat.aimoffset = self get_aim_offset(self.bot.threat.entity);
  }
  if(self fragbuttonpressed()) {
    self throw_grenade(self.grenadetypeprimary, self.bot.threat.lastposition);
    return;
  }
  if(self secondaryoffhandbuttonpressed()) {
    self throw_grenade(self.grenadetypesecondary, self.bot.threat.lastposition);
    return;
  }
  self update_weapon_aim();
  if(self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self ismeleeing()) {
    return;
  }
  if(melee_attack()) {
    return;
  }
  self update_weapon_ads();
  self fire_weapon();
}

function update_threat_goal() {
  if(self botundermanualcontrol()) {
    return;
  }
  if(self botgoalset() && (self.bot.threat.wasvisible || !self.bot.threat.visible)) {
    return;
  }
  radius = get_threat_goal_radius();
  radiussq = radius * radius;
  threatdistsq = distance2dsquared(self.origin, self.bot.threat.lastposition);
  if(threatdistsq < radiussq || !self botsetgoal(self.bot.threat.lastposition, radius)) {
    self combat_strafe();
  }
}

function get_threat_goal_radius() {
  weapon = self getcurrentweapon();
  if(randomint(100) < 10 || weapon.weapclass == "melee" || (!self getweaponammoclip(weapon) && !self getweaponammostock(weapon))) {
    return level.botsettings.meleerange;
  }
  return randomintrange(level.botsettings.threatradiusmin, level.botsettings.threatradiusmax);
}

function fire_weapon() {
  if(!self.bot.threat.inrange) {
    return;
  }
  weapon = self getcurrentweapon();
  if(weapon == level.weaponnone || !self getweaponammoclip(weapon) || self.bot.threat.dot < weapon_fire_dot(weapon)) {
    return;
  }
  if(weapon.firetype == "Single Shot" || weapon.firetype == "Burst" || weapon.firetype == "Charge Shot") {
    if(self attackbuttonpressed()) {
      return;
    }
  }
  self bot::press_attack_button();
  if(weapon.isdualwield) {
    self bot::press_throw_button();
  }
}

function melee_attack() {
  if(self.bot.threat.dot < level.botsettings.meleedot) {
    return false;
  }
  if(distancesquared(self.origin, self.bot.threat.lastposition) > level.botsettings.meleerangesq) {
    return false;
  }
  self bot::tap_melee_button();
  return true;
}

function chase_threat() {
  if(self botundermanualcontrol()) {
    return;
  }
  if(self.bot.threat.wasvisible && !self.bot.threat.visible) {
    self clear_threat_aim();
    self botsetgoal(self.bot.threat.lastposition);
    self bot::sprint_to_goal();
    return;
  }
  if((self.bot.threat.lastvisibletime + (isdefined(level.botsettings.chasethreattime) ? level.botsettings.chasethreattime : 0)) < gettime()) {
    self clear_threat();
    return;
  }
  if(!self botgoalset()) {
    self bot::navmesh_wander(self.bot.threat.lastvelocity, self.botsettings.chasewandermin, self.botsettings.chasewandermax, self.botsettings.chasewanderspacing, self.botsettings.chasewanderfwddot);
    self clear_threat();
  }
}

function get_aim_offset(entity) {
  if(issentient(entity) && randomint(100) < (isdefined(level.botsettings.headshotweight) ? level.botsettings.headshotweight : 0)) {
    return entity geteye() - entity.origin;
  }
  return entity getcentroid() - entity.origin;
}

function update_weapon_aim() {
  if(!isdefined(self.bot.threat.aimstarttime)) {
    self start_threat_aim();
  }
  aimtime = gettime() - self.bot.threat.aimstarttime;
  if(aimtime < 0) {
    return;
  }
  if(aimtime >= self.bot.threat.aimtime || !isdefined(self.bot.threat.aimerror)) {
    self botlookatpoint(self.bot.threat.aimpoint);
    return;
  }
  eyepoint = self geteye();
  threatangles = vectortoangles(self.bot.threat.aimpoint - eyepoint);
  initialangles = threatangles + self.bot.threat.aimerror;
  currangles = vectorlerp(initialangles, threatangles, aimtime / self.bot.threat.aimtime);
  playerangles = self getplayerangles();
  self botsetlookangles(anglestoforward(currangles));
}

function start_threat_aim() {
  self.bot.threat.aimstarttime = gettime() + ((isdefined(level.botsettings.aimdelay) ? level.botsettings.aimdelay : 0) * 1000);
  self.bot.threat.aimtime = (isdefined(level.botsettings.aimtime) ? level.botsettings.aimtime : 0) * 1000;
  loc_00001942:
    pitcherror = angleerror((isdefined(level.botsettings.aimerrorminpitch) ? level.botsettings.aimerrorminpitch : 0), (isdefined(level.botsettings.aimerrormaxpitch) ? level.botsettings.aimerrormaxpitch : 0));
  loc_000019AA:
    yawerror = angleerror((isdefined(level.botsettings.aimerrorminyaw) ? level.botsettings.aimerrorminyaw : 0), (isdefined(level.botsettings.aimerrormaxyaw) ? level.botsettings.aimerrormaxyaw : 0));
  self.bot.threat.aimerror = (pitcherror, yawerror, 0);
}

function angleerror(anglemin, anglemax) {
  angle = anglemax - anglemin;
  angle = angle * (randomfloatrange(-1, 1));
  if(angle < 0) {
    angle = angle - anglemin;
  } else {
    angle = angle + anglemin;
  }
  return angle;
}

function clear_threat_aim() {
  if(!isdefined(self.bot.threat.aimstarttime)) {
    return;
  }
  self.bot.threat.aimstarttime = undefined;
  self.bot.threat.aimtime = undefined;
  self.bot.threat.aimerror = undefined;
}

function bot_pre_combat() {
  if(self has_threat()) {
    return;
  }
  if(isdefined(self.bot.damage.time) && (self.bot.damage.time + 1500) > gettime()) {
    if(self has_threat() && self.bot.damage.time > self.bot.threat.lastvisibletime) {
      self clear_threat();
    }
    self bot::navmesh_wander(self.bot.damage.attackdir, level.botsettings.damagewandermin, level.botsettings.damagewandermax, level.botsettings.damagewanderspacing, level.botsettings.damagewanderfwddot);
    self bot::end_sprint_to_goal();
    self clear_damage();
  }
}

function bot_post_combat() {}

function update_weapon_ads() {
  if(!self.bot.threat.inrange || self.bot.threat.incloserange) {
    return;
  }
  weapon = self getcurrentweapon();
  if(weapon == level.weaponnone || weapon.isdualwield || weapon.weapclass == "melee" || self getweaponammoclip(weapon) <= 0) {
    return;
  }
  if(self.bot.threat.dot < weapon_ads_dot(weapon)) {
    return;
  }
  self bot::press_ads_button();
}

function weapon_ads_dot(weapon) {
  if(weapon.issniperweapon) {
    return level.botsettings.sniperads;
  }
  if(weapon.isrocketlauncher) {
    return level.botsettings.rocketlauncherads;
  }
  switch (weapon.weapclass) {
    case "mg": {
      return level.botsettings.mgads;
    }
    case "smg": {
      return level.botsettings.smgads;
    }
    case "spread": {
      return level.botsettings.spreadads;
    }
    case "pistol": {
      return level.botsettings.pistolads;
    }
    case "rifle": {
      return level.botsettings.rifleads;
    }
  }
  return level.botsettings.defaultads;
}

function weapon_fire_dot(weapon) {
  if(weapon.issniperweapon) {
    return level.botsettings.sniperfire;
  }
  if(weapon.isrocketlauncher) {
    return level.botsettings.rocketlauncherfire;
  }
  switch (weapon.weapclass) {
    case "mg": {
      return level.botsettings.mgfire;
    }
    case "smg": {
      return level.botsettings.smgfire;
    }
    case "spread": {
      return level.botsettings.spreadfire;
    }
    case "pistol": {
      return level.botsettings.pistolfire;
    }
    case "rifle": {
      return level.botsettings.riflefire;
    }
  }
  return level.botsettings.defaultfire;
}

function weapon_range(weapon) {
  if(weapon.issniperweapon) {
    return level.botsettings.sniperrange;
  }
  if(weapon.isrocketlauncher) {
    return level.botsettings.rocketlauncherrange;
  }
  switch (weapon.weapclass) {
    case "mg": {
      return level.botsettings.mgrange;
    }
    case "smg": {
      return level.botsettings.smgrange;
    }
    case "spread": {
      return level.botsettings.spreadrange;
    }
    case "pistol": {
      return level.botsettings.pistolrange;
    }
    case "rifle": {
      return level.botsettings.riflerange;
    }
  }
  return level.botsettings.defaultrange;
}

function weapon_range_close(weapon) {
  if(weapon.issniperweapon) {
    return level.botsettings.sniperrangeclose;
  }
  if(weapon.isrocketlauncher) {
    return level.botsettings.rocketlauncherrangeclose;
  }
  switch (weapon.weapclass) {
    case "mg": {
      return level.botsettings.mgrangeclose;
    }
    case "smg": {
      return level.botsettings.smgrangeclose;
    }
    case "spread": {
      return level.botsettings.spreadrangeclose;
    }
    case "pistol": {
      return level.botsettings.pistolrangeclose;
    }
    case "rifle": {
      return level.botsettings.riflerangeclose;
    }
  }
  return level.botsettings.defaultrangeclose;
}

function switch_weapon() {
  currentweapon = self getcurrentweapon();
  if(self isswitchingweapons() || currentweapon.isheroweapon || currentweapon.isitem) {
    return false;
  }
  weapon = bot::get_ready_gadget();
  if(weapon != level.weaponnone) {
    if(!isdefined(level.enemyempactive) || !self[[level.enemyempactive]]()) {
      self bot::activate_hero_gadget(weapon);
      return true;
    }
  }
  weapons = self getweaponslistprimaries();
  if(currentweapon == level.weaponnone || currentweapon.weapclass == "melee" || currentweapon.weapclass == "rocketLauncher" || currentweapon.weapclass == "pistol") {
    foreach(weapon in weapons) {
      if(weapon == currentweapon) {
        continue;
      }
      if(self getweaponammoclip(weapon) || self getweaponammostock(weapon)) {
        self botswitchtoweapon(weapon);
        return true;
      }
    }
    return false;
  }
  currentammostock = self getweaponammostock(currentweapon);
  if(currentammostock) {
    return false;
  }
  switchfrac = 0.3;
  currentclipfrac = self weapon_clip_frac(currentweapon);
  if(currentclipfrac > switchfrac) {
    return false;
  }
  foreach(weapon in weapons) {
    if(self getweaponammostock(weapon) || self weapon_clip_frac(weapon) > switchfrac) {
      self botswitchtoweapon(weapon);
      return true;
    }
  }
  return false;
}

function threat_switch_weapon() {
  currentweapon = self getcurrentweapon();
  if(self isswitchingweapons() || self getweaponammoclip(currentweapon) || currentweapon.isitem) {
    return;
  }
  currentammostock = self getweaponammostock(currentweapon);
  weapons = self getweaponslistprimaries();
  foreach(weapon in weapons) {
    if(weapon == currentweapon || weapon.requirelockontofire) {
      continue;
    }
    if(weapon.weapclass == "melee") {
      if(currentammostock && randomintrange(0, 100) < 75) {
        continue;
      }
    } else {
      if(!self getweaponammoclip(weapon) && currentammostock) {
        continue;
      }
      weaponammostock = self getweaponammostock(weapon);
      if(!currentammostock && !weaponammostock) {
        continue;
      }
      if(weapon.weapclass != "pistol" && randomintrange(0, 100) < 75) {
        continue;
      }
    }
    self botswitchtoweapon(weapon);
  }
}

function reload_weapon() {
  weapon = self getcurrentweapon();
  if(!self getweaponammostock(weapon)) {
    return false;
  }
  reloadfrac = 0.5;
  if(weapon.weapclass == "mg") {
    reloadfrac = 0.25;
  }
  if(self weapon_clip_frac(weapon) < reloadfrac) {
    self bot::tap_reload_button();
    return true;
  }
  return false;
}

function weapon_clip_frac(weapon) {
  if(weapon.clipsize <= 0) {
    return 1;
  }
  clipammo = self getweaponammoclip(weapon);
  return clipammo / weapon.clipsize;
}

function throw_grenade(weapon, target) {
  if(!isdefined(self.bot.threat.aimstarttime)) {
    self aim_grenade(weapon, target);
    self press_grenade_button(weapon);
    return;
  }
  if((self.bot.threat.aimstarttime + self.bot.threat.aimtime) > gettime()) {
    return;
  }
  if(self will_hit_target(weapon, target)) {
    return;
  }
  self press_grenade_button(weapon);
}

function press_grenade_button(weapon) {
  if(weapon == self.grenadetypeprimary) {
    self bot::press_frag_button();
  } else if(weapon == self.grenadetypesecondary) {
    self bot::press_offhand_button();
  }
}

function aim_grenade(weapon, target) {
  aimpeak = target + vectorscale((0, 0, 1), 100);
  self.bot.threat.aimstarttime = gettime();
  self.bot.threat.aimtime = 1500;
  self botsetlookanglesfrompoint(aimpeak);
}

function will_hit_target(weapon, target) {
  velocity = get_throw_velocity(weapon);
  throworigin = self geteye();
  xydist = distance2d(throworigin, target);
  xyspeed = distance2d(velocity, (0, 0, 0));
  t = xydist / xyspeed;
  gravity = getdvarfloat("bg_gravity") * -1;
  theight = (throworigin[2] + (velocity[2] * t)) + (((gravity * t) * t) * 0.5);
  return (abs(theight - target[2])) < 20;
}

function get_throw_velocity(weapon) {
  angles = self getplayerangles();
  forward = anglestoforward(angles);
  return forward * 928;
}

function get_lethal_grenade() {
  weaponslist = self getweaponslist();
  foreach(weapon in weaponslist) {
    if(weapon.type == "grenade" && self getweaponammostock(weapon)) {
      return weapon;
    }
  }
  return level.weaponnone;
}

function wait_damage_loop() {
  self endon("death");
  level endon("game_ended");
  while (true) {
    self waittill("damage", damage, attacker, direction, point, mod, unused1, unused2, unused3, weapon, flags, inflictor);
    self.bot.damage.entity = attacker;
    self.bot.damage.amount = damage;
    self.bot.damage.attackdir = vectornormalize(attacker.origin - self.origin);
    self.bot.damage.weapon = weapon;
    self.bot.damage.mod = mod;
    self.bot.damage.time = gettime();
    self thread[[level.onbotdamage]]();
  }
}

function clear_damage() {
  self.bot.damage.entity = undefined;
  self.bot.damage.amount = undefined;
  self.bot.damage.direction = undefined;
  self.bot.damage.weapon = undefined;
  self.bot.damage.mod = undefined;
  self.bot.damage.time = undefined;
}

function combat_strafe(radiusmin = (isdefined(level.botsettings.strafemin) ? level.botsettings.strafemin : 0), radiusmax, spacing, sidedotmin, sidedotmax) {
  if(!isdefined(radiusmax)) {
    radiusmax = (isdefined(level.botsettings.strafemax) ? level.botsettings.strafemax : 0);
  }
  if(!isdefined(spacing)) {
    spacing = (isdefined(level.botsettings.strafespacing) ? level.botsettings.strafespacing : 0);
  }
  if(!isdefined(sidedotmin)) {
    sidedotmin = (isdefined(level.botsettings.strafesidedotmin) ? level.botsettings.strafesidedotmin : 0);
  }
  if(!isdefined(sidedotmax)) {
    sidedotmax = (isdefined(level.botsettings.strafesidedotmax) ? level.botsettings.strafesidedotmax : 0);
  }
  fwd = anglestoforward(self.angles);
  queryresult = positionquery_source_navigation(self.origin, radiusmin, radiusmax, 64, spacing, self);
  best_point = undefined;
  foreach(point in queryresult.data) {
    movedir = vectornormalize(point.origin - self.origin);
    dot = vectordot(movedir, fwd);
    if(dot >= sidedotmin && dot <= sidedotmax) {
      point.score = mapfloat(radiusmin, radiusmax, 0, 50, point.disttoorigin2d);
      point.score = point.score + randomfloatrange(0, 50);
    }
    if(!isdefined(best_point) || point.score > best_point.score) {
      best_point = point;
    }
  }
  if(isdefined(best_point)) {
    self botsetgoal(best_point.origin);
    self bot::end_sprint_to_goal();
  }
}