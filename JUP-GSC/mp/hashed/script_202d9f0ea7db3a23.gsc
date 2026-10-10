/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_202d9f0ea7db3a23.gsc
*************************************************/

#using script_34e2c429f1463c06;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_4d6911a5d970ff49;

function initcrossbowusage(weapon) {}

function crossbowusageloop(weapon) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  ammotype = getcrossbowammotype(weapon);
  crossbowimpactfunc = getcrossbowimpactfunc(ammotype);
  thread crossbowimpactwatcher(weapon, ammotype, crossbowimpactfunc);
}

function cleanupafterweaponswitch() {
  self waittill("end_launcher");
  wait 6;
  self notify("endImpactWatcher");
}

function crossbowimpactwatcher(watcherweapon, ammotype, crossbowimpactfunc) {
  self notify("endImpactWatcher");
  self endon("disconnect");
  self endon("endImpactWatcher");
  childthread cleanupafterweaponswitch();

  while(true) {
    self waittill("bullet_first_impact", var_9d7ca6252f103a3b, hitent, hitentpart, surfacenormal, surfacetype, weapon, bulletdir, impactpos, hitloc);

    if(watcherweapon != weapon) {
      continue;
    }

    bolt = spawncrossbowbolt(impactpos, bulletdir, ammotype, weapon);
    handleimpact(bolt, hitent, hitentpart, impactpos, surfacenormal, surfacetype, weapon, bulletdir, impactpos, crossbowimpactfunc);
  }
}

function handleimpact(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype, weapon, bulletdir, impactpos, crossbowimpactfunc) {
  if(shouldreflect(surfacetype, bolt, hitent, hitentpart)) {
    reflectbolt(bolt, surfacenormal, bulletdir, impactpos);
  } else if(shoulddeleteimmediately(hitent)) {
    bolt deletebolt(1);
    return;
  } else if(shouldlink(hitent)) {
    linktoent(bolt, hitent, hitentpart);
  }

  if(isDefined(crossbowimpactfunc)) {
    self[[crossbowimpactfunc]](bolt, hitent, hitentpart, hitloc, surfacetype);
  }
}

function function_8c51cd45d4f7245d(bolt, hitent, hitentpart, hitloc, surfacetype) {
  camera = function_ec71c6a3676c9ee6(bolt, hitent, hitloc);

  if(isDefined(camera)) {
    bolt thread boltdeleteonnote(camera, "death");
    bolt thread boltdeleteonnote(camera, "explode");
  }
}

function function_79a632d01cf0c669() {
  return "iw9_dm_recondartcrossbow_mp";
}

function spawncrossbowbolt(impactpos, bulletdir, ammotype, weapon) {
  model = getboltmodel(ammotype);
  bolt = spawn("script_model", impactpos);
  bolt setModel(model);
  bolt.angles = vectortoangles(bulletdir);
  bolt setdeleteable();
  bolt.owner = self;
  bolt.ammotype = ammotype;
  bolt.weapon = weapon;
  bolt.iscrossbowbolt = 1;
  bolt thread function_edf6a939d6f2d3af();
  return bolt;
}

function setdeleteable() {
  self.deleteable = 0;
}

function getcrossbowammotype(weapon) {
  return "bolt_recon";
}

function getcrossbowimpactfunc(ammotype) {
  return &function_8c51cd45d4f7245d;
}

function getboltmodel(ammotype) {
  return "weapon_wm_sn_crossbow_bolt_static";
}

function validateboltent() {
  if(isDefined(self) && istrue(self.iscrossbowbolt)) {
    return 1;
  }

  assertmsg("<dev string:x1c>");
}

function shouldreflect(surfacetype, bolt, hitent, hitentpart) {
  if(!isDefined(hitent) && isDefined(hitentpart)) {
    return 1;
  }

  if(!isDefined(surfacetype)) {
    return 0;
  }

  switch (surfacetype) {
    case #"hash_886109ae17c9aa73":
    case #"hash_8c9d4c67dcde81f2":
      return 1;
  }

  if(bolt.ammotype == "bolt_explo") {
    return 0;
  }

  if(issameteamplayer(hitent)) {
    return 1;
  }

  if(issameteamagent(hitent)) {
    return 1;
  }

  switch (surfacetype) {
    case #"hash_321a9678047d0a4e":
    case #"hash_67e845c97d1f9eda":
    case #"hash_f9100fc94321f813":
      return 1;
    case #"hash_fb5a4fd62140d3d":
    case #"hash_519950fd846289c6":
    case #"hash_7fe735e403d9fe08":
    case #"hash_b72d9dbb666bc59c":
    case #"hash_d70d4c17673f4162":
    case #"hash_f4d3c7f04f8ef31d":
      if(bolt.ammotype == "bolt_fire") {
        return 0;
      } else {
        return 1;
      }
    default:
      return 0;
  }
}

function reflectbolt(bolt, surfacenormal, bulletdir, impactpos) {
  vec = math::vector_reflect(bulletdir, surfacenormal);
  dot = abs(vectordot(bulletdir, surfacenormal));
  reflect_velocity = math::factor_value(2300, 1000, dot);
  vec *= reflect_velocity;
  bolt physicslaunchserver(impactpos, vec);
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

function issameteamagent(hitent) {
  if(!isagent(hitent)) {
    return false;
  }

  if(isDefined(hitent.agentteam) && self.team == hitent.agentteam) {
    return true;
  }

  return false;
}

function deletebolt(var_c4a5a9d9ae155452) {
  if(!validateboltent()) {
    assertmsg("<dev string:x54>");
  }

  if(var_c4a5a9d9ae155452) {
    iprintlnbold("<dev string:x8a>");
  }

  self delete();
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

function is_suicidebomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function removestuckenemyondeathordisconnect(hitent) {
  self endon("entitydeleted");
  hitent waittill_any_3("entitydeleted", "death", "disconnect");

  if(!validateboltent()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(hitent) && isDefined(hitent.nocorpse)) {
    deletebolt(0);
  }
}

function boltdeleteonnote(hitent, note) {
  self endon("entitydeleted");
  hitent waittill(note);

  if(!validateboltent()) {
    return;
  }

  deletebolt(0);
}

function function_edf6a939d6f2d3af() {
  self waittill("entitydeleted");
}

function linktoent(bolt, hitent, hitentpart) {
  if((isPlayer(hitent) || isagent(hitent)) && !isalive(hitent)) {
    corpse = hitent getcorpseentity();

    if(isDefined(corpse)) {
      hitent = corpse;
    }
  }

  if(isPlayer(hitent)) {
    bolt hidefromplayer(hitent);
  }

  if(isDefined(hitentpart)) {
    bolt linkTo(hitent, hitentpart);
  } else {
    bolt linkTo(hitent);
  }

  if(cansticktoent(hitent)) {
    bolt.stuckenemyentity = hitent;
    bolt thread removestuckenemyondeathordisconnect(hitent);
  }

  bolt notsolid();
  bolt thread boltunlinkonnote(hitent);
  bolt thread boltdeleteonnote(hitent, "vehicle_deleted");
  bolt thread boltdeleteonnote(hitent, "detonated");
  bolt thread boltdeleteonnote(hitent, "beginC130");
}

function shouldlink(hitent) {
  if(!isDefined(hitent)) {
    return false;
  }

  return true;
}

function boltunlinkonnote(hitent) {
  self endon("entitydeleted");
  hitent waittill_any_2("entitydeleted", "disconnect");

  if(!validateboltent()) {
    return;
  }

  boltunlink();
}

function boltunlink(launchvec) {
  if(!isDefined(launchvec)) {
    launchvec = (0, 0, 100);
  }

  if(self islinked()) {
    self unlink();
  }

  if(!isDefined(self.model) || self.model == "tag_origin") {
    return;
  }

  self solid();
  self physicslaunchserver(self.origin, launchvec);
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