/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\xmike109.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace xmike109;

function initusage(weapon) {
  if(!isDefined(level.xmike109projectiles)) {
    level.xmike109projectiles = [];
  }

  if(!isDefined(self.xmike109)) {
    self.xmike109 = spawnStruct();
  }

  self.xmike109.active = 1;
}

function usageloop(weapon) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  ammotype = getxmike109ammotype(weapon);

  if(ammotype == "mag_xmike109") {
    return;
  }

  impactfunc = getxmike109impactfunc(ammotype);
  thread impactwatcher(weapon, ammotype, impactfunc);
}

function cleanupafterweaponswitch() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupXMike109ImpactWatcher");
}

function impactwatcher(watcherweapon, ammotype, xmike109impactfunc) {
  self notify("cleanupXMike109ImpactWatcher");
  self endon("disconnect");
  self endon("cleanupXMike109ImpactWatcher");
  childthread cleanupafterweaponswitch();

  if(ammotype == "default") {
    return;
  }

  while(true) {
    self waittill("bullet_first_impact", var_9d7ca6252f103a3b, hitent, hitentpart, surfacenormal, surfacetype, weapon, bulletdir, impactpos, hitloc);

    if(watcherweapon != weapon) {
      continue;
    }

    handleimpact(hitent, hitentpart, hitloc, surfacenormal, surfacetype, weapon, bulletdir, impactpos, xmike109impactfunc, ammotype);
  }
}

function handleimpact(hitent, hitentpart, hitloc, surfacenormal, surfacetype, weapon, bulletdir, impactpos, xmike109impactfunc, ammotype) {
  reflected = shouldreflect(surfacetype, ammotype, hitent, hitentpart, surfacenormal, bulletdir);
  projectile = spawnprojectile(impactpos, bulletdir, ammotype, weapon, reflected, surfacenormal);

  if(shoulddeleteimmediately(hitent)) {
    projectile delete();
    return;
  } else if(shouldlink(hitent, reflected)) {
    linktoent(projectile, hitent, hitentpart);
  }

  if(isDefined(xmike109impactfunc)) {
    [[xmike109impactfunc]](projectile, hitent, hitentpart, hitloc, surfacetype, reflected);
  }
}

function impactfunc_explo(projectile, hitent, hitentpart, hitloc, surfacetype, reflected) {
  fusetime = 0.1;
  projectile.grenade = magicgrenademanual("semtex_xmike109_mp", projectile.origin, (0, 0, 0), fusetime);
  projectile.grenade.angles = projectile.angles;
  projectile.grenade linkTo(projectile, "tag_origin");
  thread projectileimpactexplode(projectile, fusetime, hitloc);
}

function impactfunc_fire(projectile, hitent, hitentpart, hitloc, surfacetype, reflected) {
  thread projectileimpactthermite(projectile, hitent, hitentpart, hitloc, reflected);
}

function impactfunc_null(projectile, hitent, hitentpart, hitloc, surfacetype, reflected) {}

function projectileimpactexplode(projectile, fusetime, hitloc) {
  self endon("disconnect");
  projectile endon("entitydeleted");
  projectile.grenade waittill_any_timeout_no_endon_death_1(fusetime, "explode");
  projectile setscriptablepartstate("effects", "explode");
  stuckweapon = makeweapon("semtex_xmike109_mp");
  splashweapon = makeweapon("semtex_xmike109_splash_mp");
  function_49967318fbd12317(stuckweapon, projectile.weapon);
  function_49967318fbd12317(splashweapon, projectile.weapon);
  glassradiusdamage(projectile.origin, 150, 50, 1);

  if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity)) {
    projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamage();
    projectile.stuckenemyentity dodamage(140, projectile.origin, self, self, "MOD_EXPLOSIVE", stuckweapon, hitloc);
    projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
  }

  radiusdamagestepped(projectile.origin, 9, 35, 15, 25, 60, 14, self, "MOD_EXPLOSIVE", splashweapon);
  wait 0.4;

  if(!projectile validateprojectileent()) {
    return;
  }

  projectile delete();
}

function projectileimpactthermite(projectile, hitent, hitentpart, hitloc, reflected) {
  if(istrue(projectile.isgrenade)) {
    projectile setscriptablepartstate("effects", "reflectThermite");
    waitforstuck(projectile);
  }

  projectile setscriptablepartstate("effects", "burn");
  thread thermitestuckto(projectile);
  thread thermiteradiusdamage(projectile);
  thread thermiteburnout(projectile);
}

function waitforstuck(projectile) {
  projectile endon("stuckWaitTimeout");
  projectile thread projectilewaittilstucktimeout();
  projectile waittill("missile_stuck", stuckto, stuckpart);

  if(isDefined(stuckto)) {
    linktoent(projectile, stuckto, stuckpart);
    projectile.bounceshot = 1;
  }
}

function projectilewaittilstucktimeout() {
  wait 3;

  if(isDefined(self)) {
    self notify("stuckWaitTimeout");
  }
}

function thermitestuckto(projectile) {
  self endon("disconnect");
  projectile endon("entitydeleted");
  stuckweapon = makeweapon("thermite_xmike109_mp");
  function_49967318fbd12317(stuckweapon, projectile.weapon);

  if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity)) {
    if(projectile.stuckenemyentity scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(projectile.stuckenemyentity.classname) && projectile.stuckenemyentity.classname == "misc_turret") {
      damage_interval = 0.95;
    } else {
      damage_interval = 0.25;
    }

    if(istrue(projectile.bounceshot)) {
      projectile.stuckenemyentity dodamage(80, projectile.origin, self, projectile, "MOD_FIRE", stuckweapon);
    }

    ticks = int(3 / damage_interval);

    while(isDefined(projectile) && isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity) && ticks >= 0) {
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamage();
      projectile.stuckenemyentity dodamage(3, projectile.origin, self, projectile, "MOD_FIRE", stuckweapon);
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
      ticks--;
      wait damage_interval;
    }
  }
}

function thermiteradiusdamage(projectile) {
  self endon("disconnect");
  projectile endon("entitydeleted");
  ticks = int(12);
  radiusweapon = makeweapon("thermite_xmike109_radius_mp");
  function_49967318fbd12317(radiusweapon, projectile.weapon);
  projectile.thermiteradiusweaponref = radiusweapon.basename;

  while(ticks > 0) {
    if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity)) {
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermite25mmStuck", 0, 0, &thermite_damagemodifierignorefunc);
    }

    projectile radiusdamage(projectile.origin, 50, 2, 2, self, "MOD_FIRE", radiusweapon);

    if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity)) {
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermite25mmStuck", 0);
    }

    ticks--;
    wait 0.25;
  }
}

function thermite_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!isDefined(inflictor)) {
    return true;
  }

  if(!isDefined(inflictor.thermiteradiusweaponref) || inflictor.thermiteradiusweaponref != "thermite_xmike109_radius_mp") {
    return true;
  }

  if(!isDefined(inflictor.stuckenemyentity) || inflictor.stuckenemyentity != victim) {
    return true;
  }

  return false;
}

function thermiteburnout(projectile) {
  projectile endon("entitydeleted");
  wait 3;

  if(!projectile validateprojectileent()) {
    return;
  }

  projectile setscriptablepartstate("effects", "burnout");
  projectile setscriptablepartstate("visibility", "hide");
  wait randomfloatrange(0.3, 2);

  if(!projectile validateprojectileent()) {
    return;
  }

  wait randomfloatrange(2, 3);
  projectile delete();
}

function spawnprojectile(impactpos, bulletdir, ammotype, weapon, reflected, surfacenormal) {
  if(reflected && ammotype == "thermal") {
    vel = reflectprojectile(surfacenormal, bulletdir, impactpos, 1);
    org = impactpos + surfacenormal * 10;
    projectile = magicgrenademanual("xmike109_grenade", org, vel, 10);
    projectile.isgrenade = 1;
    playFX(getfx("xmike109ThermiteBounce"), impactpos, surfacenormal);
  } else {
    projectile = spawn("script_model", impactpos);
    projectile setModel("weapon_wm_sn_xmike109_projectile");
    projectile.origin = impactpos;

    if(reflected) {
      vel = reflectprojectile(surfacenormal, bulletdir, impactpos, 0);
      projectile physicslaunchserver(impactpos, vel);
    }
  }

  projectile.angles = vectortoangles(bulletdir);
  projectile setdeleteable(ammotype);
  projectile.owner = self;
  projectile.ammotype = ammotype;
  projectile.weapon = weapon;
  projectile.isxmike109projectile = 1;
  projectile thread projectiledeletethread();
  manageworldspawnedprojectiles(projectile);
  return projectile;
}

function setdeleteable(ammotype) {
  switch (ammotype) {
    case #"hash_fd8321f2ca4fc7a0":
      thread setdeleteabletimer(3.5);
      self.deleteable = 0;
      break;
    case #"hash_1cb749d9b456c694":
      self.deleteable = 0;
      break;
    default:
      self.deleteable = 1;
      break;
  }
}

function setdeleteabletimer(time) {
  self endon("entitydeleted");
  wait time;
  self.deleteable = 1;
  manageworldspawnedprojectiles();
}

function manageworldspawnedprojectiles(newstruct) {
  if(isDefined(newstruct)) {
    temparr = [newstruct];
  } else {
    temparr = [];
  }

  foreach(projectiles in level.xmike109projectiles) {
    if(!isDefined(projectiles)) {
      continue;
    }

    if(isDefined(projectiles)) {
      if(temparr.size >= 4 && projectiles.deleteable) {
        projectiles delete();
        continue;
      }

      temparr[temparr.size] = projectiles;
    }
  }

  level.xmike109projectiles = temparr;
}

function getxmike109ammotype(weapon) {
  var_60424bd85d92d34e = "";

  foreach(attachment in weapon.attachments) {
    if(issubstr(attachment, "calcust")) {
      var_60424bd85d92d34e = attachment;
      break;
    }
  }

  switch (var_60424bd85d92d34e) {
    case #"hash_3de5ca2916f09a8d":
      return "thermal";
    case #"hash_aac8d0e29b407c16":
      return "explosive";
    default:
      return "default";
  }
}

function getxmike109impactfunc(ammotype) {
  switch (ammotype) {
    case #"hash_fd8321f2ca4fc7a0":
      return &impactfunc_fire;
    case #"hash_1cb749d9b456c694":
      return &impactfunc_explo;
    default:
      return &impactfunc_null;
  }
}

function shouldreflect(surfacetype, ammotype, hitent, hitentpart, surfacenormal, bulletdir) {
  if(!isDefined(surfacetype)) {
    surfacetype = "";
  }

  if(surfacetype == "riotshield") {
    return 1;
  }

  if(ammotype != "thermal") {
    return 0;
  }

  if(!isDefined(hitent) && isDefined(hitentpart)) {
    return 1;
  }

  if(issameteamplayer(hitent) || issameteamagent(hitent)) {
    return 1;
  }

  if(isenemyteamplayer(hitent) || isenemyteamagent(hitent)) {
    return 0;
  }

  if(isDefined(hitent)) {
    if(hitent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      return 0;
    }

    if(isDefined(hitent.equipmentref) && hitent.equipmentref == "equip_tac_cover") {
      return 0;
    }
  }

  switch (surfacetype) {
    case #"hash_321a9678047d0a4e":
    case #"hash_886109ae17c9aa73":
    case #"hash_8c9d4c67dcde81f2":
      return 1;
    default:
      dot = abs(vectordot(bulletdir, surfacenormal));

      if(dot < 0.2) {
        return 1;
      } else {
        return 0;
      }

      break;
  }
}

function reflectprojectile(surfacenormal, bulletdir, impactpos, isgrenade) {
  if(isgrenade) {
    speedmax = 1500;
    speedmid = 500;
    speedmin = 150;
  } else {
    speedmax = 500;
    speedmid = 500;
    speedmin = 500;
  }

  vec = math::vector_reflect(bulletdir, surfacenormal);
  vec = vectorlerp(vec, surfacenormal, 0.2);
  dot = abs(vectordot(bulletdir, surfacenormal));

  if(dot < 0.2) {
    dot = math::normalize_value(0, 0.2, dot);
    reflect_velocity = math::factor_value(speedmax, speedmid, dot);
  } else {
    dot = math::normalize_value(0.2, 1, dot);
    reflect_velocity = math::factor_value(speedmid, speedmin, dot);
  }

  vec *= reflect_velocity;
  return vec;
}

function shoulddeleteimmediately(hitent) {
  if(!isDefined(hitent)) {
    return false;
  }

  if(isagent(hitent) && hitent is_suicidebomber() && !isalive(hitent) && !isDefined(hitent getcorpseentity())) {
    return true;
  }

  return false;
}

function shouldlink(hitent, reflected) {
  if(reflected || !isDefined(hitent)) {
    return false;
  }

  return true;
}

function is_suicidebomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function linktoent(projectile, hitent, hitentpart) {
  if((isPlayer(hitent) || isagent(hitent)) && !isalive(hitent)) {
    corpse = hitent getcorpseentity();

    if(isDefined(corpse)) {
      hitent = corpse;
    }
  }

  if(isPlayer(hitent)) {
    projectile hidefromplayer(hitent);
  }

  if(isDefined(hitentpart)) {
    projectile linkTo(hitent, hitentpart);
  } else {
    projectile linkTo(hitent);
  }

  if(cansticktoent(hitent)) {
    projectile.stuckenemyentity = hitent;
    projectile thread removestuckenemyondeathordisconnect(hitent);
  }

  if(!istrue(projectile.isgrenade)) {
    projectile notsolid();
  }

  projectile thread projectileunlinkonnote(hitent);
  projectile thread projectiledeleteonnote(hitent, "vehicle_deleted");
  projectile thread projectiledeleteonnote(hitent, "detonated");
  projectile thread projectiledeleteonnote(hitent, "beginC130");
}

function validateprojectileent() {
  if(isDefined(self) && istrue(self.isxmike109projectile)) {
    return 1;
  }

  assertmsg("<dev string:x1c>");
}

function removestuckenemyondeathordisconnect(hitent) {
  self endon("entitydeleted");
  hitent waittill_any_3("entitydeleted", "death", "disconnect");

  if(!validateprojectileent()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(hitent) && isDefined(hitent.nocorpse)) {
    self delete();
  }
}

function projectileunlinkonnote(hitent) {
  self endon("entitydeleted");

  if(isagent(hitent)) {
    hitent waittill("entitydeleted");
  } else {
    hitent waittill_any_2("entitydeleted", "disconnect");
  }

  if(!validateprojectileent()) {
    return;
  }

  projectileunlink();
}

function projectileunlink(launchvec) {
  if(!isDefined(launchvec)) {
    launchvec = (0, 0, 100);
  }

  if(self islinked()) {
    self unlink();
  }

  if(!istrue(self.isgrenade)) {
    self solid();
  }

  self physicslaunchserver(self.origin, launchvec);
}

function projectiledeleteonnote(hitent, note) {
  self endon("entitydeleted");
  hitent waittill(note);

  if(!validateprojectileent()) {
    return;
  }

  self delete();
}

function projectiledeletethread() {
  self waittill("entitydeleted");

  if(isDefined(self.grenade)) {
    self.grenade delete();
  }
}

function issameteamplayer(hitent) {
  if(!isPlayer(hitent)) {
    return 0;
  }

  if(scripts\cp_mp\utility\player_utility::isenemy(hitent)) {
    return 0;
  }

  return 1;
}

function isenemyteamplayer(hitent) {
  if(!isPlayer(hitent)) {
    return 0;
  }

  if(scripts\cp_mp\utility\player_utility::isenemy(hitent)) {
    return 1;
  }

  return 0;
}

function issameteamagent(hitent) {
  if(!isagent(hitent)) {
    return false;
  }

  if(isDefined(hitent.agentteam) && self.team == hitent.agentteam) {
    return true;
  }

  return false;
}

function isenemyteamagent(hitent) {
  if(!isagent(hitent)) {
    return false;
  }

  if(isDefined(hitent.agentteam) && self.team == hitent.agentteam) {
    return false;
  }

  return true;
}

function cansticktoent(hitent) {
  canstick = 0;

  if(isPlayer(hitent) || isagent(hitent)) {
    canstick = 1;
  }

  if(hitent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    canstick = 1;
  }

  if(isDefined(hitent.classname)) {
    if(hitent.classname == "misc_turret") {
      canstick = 1;
    }

    if(hitent.classname == "script_model") {
      if(isDefined(hitent.streakinfo) && (hitent.streakinfo.streakname == "uav" || hitent.streakinfo.streakname == "gunship")) {
        canstick = 1;
      }
    }
  }

  if(isDefined(hitent.equipmentref)) {
    if(hitent.equipmentref == "equip_tac_cover") {
      canstick = 1;
    }
  }

  return canstick;
}