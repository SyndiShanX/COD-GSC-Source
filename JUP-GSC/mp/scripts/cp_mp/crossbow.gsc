/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\crossbow.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace crossbow;

function initcrossbowusage(weapon) {
  if(!isDefined(level.crossbowbolts)) {
    level.crossbowbolts = [];
  }

  if(!isDefined(self.crossbow)) {
    self.crossbow = spawnStruct();
    self.crossbow.boltnumber = 0;
    self.crossbow.boltsinflight = [];
  }

  self.crossbow.active = 1;

  if(!isDefined(weapon::function_23defc57f8da7fbc("thermite_bolt_mp"))) {
    weapon::function_eac07882d12979d8("iw9_dm_crossbow", "thermite_bolt_mp");
    weapon::function_eac07882d12979d8("iw9_dm_crossbow", "thermite_bolt_radius_mp");
    weapon::function_eac07882d12979d8("iw9_dm_crossbow", "semtex_bolt_mp");
    weapon::function_eac07882d12979d8("iw9_dm_crossbow", "semtex_bolt_splash_mp");
    weapon::function_eac07882d12979d8("iw9_dm_crossbow", "molotov_bolt_mp");
  }
}

function crossbowusageloop(weapon) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  ammotype = getcrossbowammotype(weapon);
  thread crossbowimpactwatcher(weapon, ammotype);
}

function cleanupafterweaponswitch() {
  self waittill("end_launcher");
  function_c0ab8a070e986732();
  wait 6;
  self notify("cleanupImpactWatcher");
}

function crossbowimpactwatcher(watcherweapon, ammotype) {
  self notify("cleanupImpactWatcher");
  self endon("disconnect");
  self endon("cleanupImpactWatcher");
  childthread cleanupafterweaponswitch();
  childthread watchforimpact(watcherweapon, ammotype);
  childthread function_5d09c8fae400afb2(watcherweapon);
  childthread function_f16d37d0028d5de3(watcherweapon, ammotype);
}

function watchforimpact(watcherweapon, ammotype) {
  crossbowimpactfunc = getcrossbowimpactfunc(ammotype);

  while(true) {
    self waittill("bullet_first_impact", var_9d7ca6252f103a3b, hitent, hitentpart, surfacenormal, surfacetype, weapon, bulletdir, impactpos, hitloc);

    if(watcherweapon != weapon) {
      continue;
    }

    bolt = spawncrossbowbolt(impactpos, bulletdir, ammotype, weapon);
    handleimpact(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype, weapon, bulletdir, impactpos, crossbowimpactfunc);
  }
}

function function_f16d37d0028d5de3(watcherweapon, ammotype) {
  var_a0dfb992760d09e3 = function_f7e93e7794bb696d(ammotype);

  while(true) {
    self waittill("bullet_terminated", weapon, bulletdir, var_3accf23ebcb854d9);

    if(watcherweapon != weapon) {
      continue;
    }

    bolt = spawncrossbowbolt(var_3accf23ebcb854d9, bulletdir, ammotype, weapon);
    function_5c14133d6577bef(bolt, var_a0dfb992760d09e3);
  }
}

function handleimpact(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype, weapon, bulletdir, impactpos, crossbowimpactfunc) {
  if(shouldreflect(surfacetype, bolt, hitent, hitentpart, weapon)) {
    reflectbolt(bolt, surfacenormal, bulletdir, impactpos);
  } else if(shoulddeleteimmediately(hitent, weapon)) {
    bolt delete();
    return;
  } else if(shoulddrop(hitent, hitloc)) {
    dropbolt(bolt);
  } else if(shouldlink(hitent)) {
    function_5478d81cf5ea8d4(bolt, hitent, hitentpart);
  }

  if(isDefined(crossbowimpactfunc)) {
    [[crossbowimpactfunc]](bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype);
  }
}

function function_5c14133d6577bef(bolt, var_a0dfb992760d09e3) {
  if(isDefined(var_a0dfb992760d09e3)) {
    [[var_a0dfb992760d09e3]](bolt);
  }
}

function impactfunc_explo(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  bolt setscriptablepartstate("effects", "impact");

  if(isDefined(hitent) && (isPlayer(hitent) || isagent(hitent))) {
    fusetime = 1.1;
  } else {
    fusetime = 2;
  }

  bolt.grenade = magicgrenademanual("semtex_bolt_mp", bolt.origin, (0, 0, 0), fusetime);
  bolt.grenade.angles = bolt.angles;
  bolt.grenade linkTo(bolt, "tag_origin");

  if(isDefined(hitent) && isagent(hitent) && !istrue(hitent.var_274d3a7704e351ef)) {
    function_60daa23100a2b874(bolt.grenade, hitent);
  }

  thread exploboltexplode(bolt, fusetime, surfacenormal);
}

function impactfunc_fire(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  thread function_9bda31fd01a8cb74(bolt, hitent, hitentpart, hitloc);
}

function impactfunc_stun(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  if(!stunshoulddetonate(hitent, surfacetype)) {
    thread function_8fd268f7be208047(bolt);
    return;
  }

  if(stununderwater(bolt)) {
    thread function_397bf021cc9037f8(bolt);
    return;
  }

  thread function_2a6ac0fc60af6c16(bolt, surfacenormal);
}

function function_b086ad2ca32b8b08(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  thread function_704dd2c09ad39716(bolt, hitent, hitentpart, hitloc);
}

function function_4001c2c1b47fb0be(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  bundle = level.equipment.table["equip_snapshot_grenade"].bundle;
  bolt.owner = self;
  var_3f8bb05fa2e29061 = getdvarint(@ "hash_279801714fd4c0c9", 1500);
  var_5cd43d05cd3babaf = getdvarint(@ "hash_c9b936fe0714b566", 256);

  if(issharedfuncdefined("weapons", "snapshot_bolt_detect")) {
    bolt thread[[getsharedfunc("weapons", "snapshot_bolt_detect")]](var_5cd43d05cd3babaf, var_3f8bb05fa2e29061, bundle);
  }

  playFX(utility::getfx("vfx_snap_gren_pulse"), bolt.origin);
  playsoundatpos(bolt.origin, "iw9_snapshot_expl");
}

function function_a73c5b03989d6eda(bolt) {}

function function_1cc12bdc257818cc(bolt) {}

function function_3088a41a2ae98710(bolt) {}

function exploboltexplode(bolt, fusetime, surfacenormal) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  bolt.grenade waittill_any_timeout_no_endon_death_1(fusetime, "explode");
  bolt function_acd8433c3043c4f2(surfacenormal);
  bolt setscriptablepartstate("effects", "explode");
  stuckweapon = makeweapon("semtex_bolt_mp");
  splashweapon = makeweapon("semtex_bolt_splash_mp");
  function_49967318fbd12317(stuckweapon, bolt.weapon);
  function_49967318fbd12317(splashweapon, bolt.weapon);
  stuckdamage = 110;
  outerdamage = 35;
  innerdamage = 110;
  idamageradius = 160;

  if(isDefined(bolt.weapon) && bolt.weapon.basename == "jup_jp31_dm_compound_mp") {
    stuckdamage = 200;
    outerdamage = 50;
    innerdamage = 150;
    idamageradius = 160;
  }

  if(isDefined(bolt.stuckenemyentity) && isalive(bolt.stuckenemyentity)) {
    bolt.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamage();

    if(isDefined(bolt.grenade)) {
      bolt.stuckenemyentity dodamage(stuckdamage, bolt.origin, self, bolt.grenade, "MOD_EXPLOSIVE", stuckweapon, "none");
    } else {
      bolt.stuckenemyentity dodamage(stuckdamage, bolt.origin, self, undefined, "MOD_EXPLOSIVE", stuckweapon, "none");
    }

    bolt.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
    bolt.stuckenemyentity thread function_a8a4ce8f3b02b96(self);
  }

  radiusdamage(bolt.origin, idamageradius, innerdamage, outerdamage, self, "MOD_EXPLOSIVE", splashweapon);
  wait 0.4;

  if(!bolt validateboltent()) {
    return;
  }

  bolt delete();
}

function function_a8a4ce8f3b02b96(inflictor) {
  self endon("disconnect");
  self notify("crossbow_semtex_blockDamage");
  self endon("crossbow_semtex_blockDamage");

  if(!isDefined(self.var_ea445bb2097eaa16)) {
    self.var_ea445bb2097eaa16 = [];
  }

  self.var_ea445bb2097eaa16[self.var_ea445bb2097eaa16.size] = inflictor;
  waittillframeend();
  self.var_ea445bb2097eaa16 = undefined;
}

function function_9bda31fd01a8cb74(bolt, hitent, hitentpart, hitloc) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  wait 0.18;
  bolt setscriptablepartstate("effects", "impact");
  thread thermiteboltstuckto(bolt, hitent, hitentpart, hitloc);
  thread thermiteboltradiusdamage(bolt, hitent);
  thread thermiteboltburnout(bolt);
}

function thermiteboltstuckto(bolt, hitent, hitentpart, hitloc) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  stuckweapon = makeweapon("thermite_bolt_mp");
  function_49967318fbd12317(stuckweapon, bolt.weapon);

  if((isPlayer(hitent) || isbot(hitent)) && isDefined(hitloc) && hitloc == "shield") {
    hitloc = "torso_upper";
    bolt thread function_28832848cd860d4e(hitent);
  }

  if(isDefined(bolt.stuckenemyentity) && isalive(bolt.stuckenemyentity)) {
    if(isDefined(hitent.vehiclename) || isDefined(hitent.classname) && hitent.classname == "misc_turret") {
      damage_interval = 1;
    } else {
      damage_interval = 0.25;
    }

    ticks = int(4.5 / damage_interval);

    while(isDefined(hitent) && isDefined(bolt) && isalive(hitent) && ticks > 0) {
      hitent scripts\cp_mp\utility\damage_utility::forcestuckdamage();
      hitent dodamage(5, bolt.origin, self, bolt, "MOD_FIRE", stuckweapon, hitloc);
      hitent scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
      ticks--;
      wait damage_interval;
    }
  }
}

function function_28832848cd860d4e(hitent) {
  hitent endon("disconnect");
  self endon("entitydeleted");
  hitent waittill("death");

  if(!validateboltent()) {
    return;
  }

  boltunlink();
}

function thermiteboltradiusdamage(bolt, hitent) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  ticks = int(18);
  radiusweapon = makeweapon("thermite_bolt_radius_mp");
  function_49967318fbd12317(radiusweapon, bolt.weapon);
  bolt.thermiteradiusweaponref = radiusweapon.basename;

  if(!isDefined(bolt.stuckenemyentity)) {
    bolt.badplace = thermitebadplace(bolt.origin);
  }

  while(ticks > 0) {
    if(isDefined(bolt.stuckenemyentity) && isalive(bolt.stuckenemyentity)) {
      bolt.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteBoltStuck", 0, 0, &thermite_damagemodifierignorefunc);
    }

    bolt radiusdamage(bolt.origin, 50, 5, 3, self, "MOD_FIRE", radiusweapon);

    if(isDefined(bolt.stuckenemyentity) && isalive(bolt.stuckenemyentity)) {
      bolt.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteBoltStuck", 0);
    }

    ticks--;
    wait 0.25;
  }
}

function thermitebadplace(impactpoint) {
  badplace = createnavbadplacebybounds(impactpoint, (50, 50, 50), (0, 0, 0));
  return badplace;
}

function thermite_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!isDefined(inflictor)) {
    return true;
  }

  if(!isDefined(inflictor.thermiteradiusweaponref) || inflictor.thermiteradiusweaponref != "thermite_bolt_radius_mp") {
    return true;
  }

  if(!isDefined(inflictor.stuckenemyentity) || inflictor.stuckenemyentity != victim) {
    return true;
  }

  return false;
}

function thermiteboltburnout(bolt) {
  bolt endon("entitydeleted");
  wait 4.5;

  if(!bolt validateboltent()) {
    return;
  }

  bolt setscriptablepartstate("effects", "burnEnd");
  wait randomfloatrange(0.3, 2);

  if(isDefined(bolt.badplace)) {
    destroynavobstacle(bolt.badplace);
  }

  bolt boltunlink();
  bolt setModel("weapon_wm_sn_crossbow_bolt_fire_static_dst");
}

function function_2a6ac0fc60af6c16(bolt, surfacenormal) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  wait 0.16;
  bolt function_acd8433c3043c4f2(surfacenormal);
  bolt setscriptablepartstate("impact", "active");

  if(issharedfuncdefined("weapons", "gas_createTrigger")) {
    paplevel = 0;

    if(isDefined(bolt.weapon) && issharedfuncdefined("zombie", "get_pap_level")) {
      paplevel = function_af5127390d3221e9(bolt.weapon);
    }

    thread[[getsharedfunc("weapons", "gas_createTrigger")]](bolt.origin, self, self.team, 5, 0.45, 1, paplevel);
  }

  thread stunboltdelete(bolt);
}

function function_8fd268f7be208047(bolt) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  wait 0.1;
  bolt setscriptablepartstate("impact", "dud");
}

function function_397bf021cc9037f8(bolt) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  wait 0.1;
  bolt setscriptablepartstate("impact", "dudUnderwater");
}

function stunboltdelete(bolt) {
  bolt endon("entitydeleted");
  wait 0.5;

  if(!bolt validateboltent()) {
    return;
  }

  bolt delete();
}

function function_704dd2c09ad39716(bolt, hitent, hitentpart, hitloc) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  launchangles = self getgunangles();
  launchtimems = gettime();
  launchvelocity = anglesToForward(launchangles) * 940 + anglestoup(launchangles) * 120;
  traveltime = (gettime() - launchtimems) / 1000;
  impactvelocity = launchvelocity + (0, 0, -800 * traveltime);

  if(isDefined(hitent) && (isPlayer(hitent) || isagent(hitent))) {
    thread function_8add0b9e806fa2fb(bolt, hitent, launchangles, impactvelocity);
    return;
  }

  thread function_a61b7128bcea5142(bolt, hitent, launchangles, impactvelocity);
}

function function_8add0b9e806fa2fb(bolt, hitent, launchangles, impactvelocity) {
  if(issharedfuncdefined("molotov", "molotov_burn_for_time")) {
    hitent thread[[getsharedfunc("molotov", "molotov_burn_for_time")]](6, self, bolt, bolt);
  }

  impactvelocity *= (0, 0, 1);
  caststart = bolt.origin;
  castdir = (0, 0, -1);
  castend = caststart + castdir * 128;
  contents = callsharedfunc("molotov", "molotov_get_cast_contents");
  castresults = physics_raycast(caststart, castend, contents, bolt, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["position"];
    casthitnorm = castresults[0]["normal"];
    casthitent = castresults[0]["entity"];
    castend -= casthitnorm * 1;
    d = vectordot(castend - caststart, castdir);
    t = sqrt(2 * d / -1 * -800);
    up = casthitnorm;
    right = anglestoright(launchangles);
    impactangles = callsharedfunc("molotov", "molotov_rebuild_angles_up_right", up, right);
    function_8b65648a30994e16(bolt, castend, impactangles, casthitent, impactvelocity, gettime() + t * 1000);
    return;
  }

  bolt notify("death");
  level thread function_8d43b846ff1837f1(bolt);
}

function function_a61b7128bcea5142(bolt, stuckto, launchangles, impactvelocity) {
  angles = undefined;
  forward = vectorNormalize(impactvelocity);
  up = anglestoup(bolt.angles);
  right = anglestoright(launchangles);

  if(abs(vectordot(forward, up)) >= 0.9848) {
    angles = callsharedfunc("molotov", "molotov_rebuild_angles_up_right", up, right);
  } else {
    angles = callsharedfunc("molotov", "molotov_rebuild_angles_up_forward", up, forward);
  }

  function_8b65648a30994e16(bolt, bolt.origin, angles, stuckto, impactvelocity, gettime());
}

function function_8b65648a30994e16(bolt, castend, impactangles, casthitent, impactvelocity, impacttime) {
  bolt setscriptablepartstate("effects", "explode", 0);
  callsharedfunc("molotov", "molotov_simulate_impact", bolt, castend, impactangles, casthitent, impactvelocity, impacttime);
}

function function_8d43b846ff1837f1(bolt) {
  bolt endon("entitydeleted");
  wait 0.5;

  if(!bolt validateboltent()) {
    return;
  }

  bolt delete();
}

function stunshoulddetonate(hitent, surfacetype) {
  if(!isDefined(hitent)) {
    return false;
  }

  if(isDefined(hitent.targetname) && hitent.targetname == "enemyTarget") {
    return true;
  }

  if(!isPlayer(hitent) && !isagent(hitent)) {
    return false;
  }

  if(issameteamplayer(hitent)) {
    return false;
  }

  if(issameteamagent(hitent)) {
    return false;
  }

  if(isDefined(surfacetype) && surfacetype == "riotshield") {
    return false;
  }

  return true;
}

function stununderwater(bolt) {
  if(ispointinwater(bolt.origin + (0, 0, 10))) {
    return true;
  }

  return false;
}

function spawncrossbowbolt(impactpos, bulletdir, ammotype, weapon) {
  model = getboltmodel(ammotype);

  if(!isDefined(level.mapname)) {
    level.mapname = getDvar(@ "g_mapname");
  }

  if(issubstr(level.mapname, "frontend")) {
    model += "_fe";
  }

  bolt = spawn("script_model", impactpos);
  bolt setModel(model);
  bolt notsolid();
  bolt.angles = vectortoangles(bulletdir);
  bolt setdeleteable(ammotype);
  bolt.owner = self;
  bolt.ammotype = ammotype;
  bolt.weapon = weapon;
  bolt.iscrossbowbolt = 1;

  if(shouldpickup(ammotype)) {
    bolt = makepickup(bolt);
  }

  bolt thread boltdeletethread();
  manageworldspawnedbolts(bolt);
  return bolt;
}

function shouldpickup(ammotype) {
  if(ammotype == "bolt_default" || ammotype == "bolt_stun" || ammotype == "bolt_stun_vday" || ammotype == "bolt_snapshot" || ammotype == "bolt_ripper" || ammotype == "jup_ammo_arrow_std") {
    return true;
  }

  return false;
}

function makepickup(bolt) {
  triggerorg = bolt.origin + anglesToForward(bolt.angles) * 15;
  triggerang = axistoangles(anglestoup(bolt.angles), anglestoright(bolt.angles), anglesToForward(bolt.angles));
  trigger = spawn("trigger_rotatable_radius", triggerorg, 0, 64, 79);
  trigger.angles = triggerang;
  trigger.targetname = "bolt_pickup";
  trigger enablelinkTo();
  trigger linkTo(bolt);
  bolt.pickuptrigger = trigger;
  bolt thread bolt_watchpickup();
  return bolt;
}

function removepickup(bolt) {
  bolt notify("removePickup");

  if(isDefined(bolt.pickuptrigger)) {
    bolt.pickuptrigger delete();
  }
}

function bolt_watchpickup() {
  self endon("entitydeleted");
  self endon("removePickup");
  wait 2;

  while(true) {
    self.pickuptrigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(isDefined(self.stuckenemyentity) && isalive(self.stuckenemyentity) && !isDefined(self.stuckenemyentity.vehiclename)) {
      continue;
    }

    var_6fba2b63d1fb95e1 = get_weapon_ammo_matched(player getweaponslistprimaries());

    if(!isDefined(var_6fba2b63d1fb95e1)) {
      continue;
    }

    if(player bolt_trytopickup(var_6fba2b63d1fb95e1)) {
      self delete();
    }
  }
}

function get_weapon_ammo_matched(weapons) {
  foreach(weapon in weapons) {
    if(isDefined(weapon.basename) && (weapon.basename == "iw9_dm_crossbow_mp" || weapon.basename == "jup_jp31_dm_compound_mp")) {
      if(isDefined(weapon.modifier) && weapon.modifier == "ammo_bolt_std" && self.ammotype == "bolt_default") {
        return weapon;
      }

      if(isDefined(weapon.modifier) && weapon.modifier == "ammo_bolt_gas" && (self.ammotype == "bolt_stun" || self.ammotype == "bolt_stun_vday") || weapon.modifier == "jup_ammo_arrow_snapshot" || weapon.modifier == "jup_ammo_arrow_rip" || weapon.modifier == "jup_ammo_arrow_std") {
        return weapon;
      }
    }
  }

  return undefined;
}

function bolt_trytopickup(weapon) {
  maxammo = weaponmaxammo(weapon);
  ogammo = self getweaponammostock(weapon);

  if(ogammo >= maxammo) {
    return false;
  }

  finalammo = int(min(maxammo, ogammo + 1));
  self setweaponammostock(weapon, finalammo);

  if(issharedfuncdefined("damage", "hudIconType")) {
    self[[getsharedfunc("damage", "hudIconType")]]("crossbowbolt");
  }

  return true;
}

function setdeleteable(ammotype) {
  switch (ammotype) {
    case #"hash_5565a4776393e4b7":
      thread setdeleteabletimer(5);
      self.deleteable = 0;
      break;
    case #"hash_546f43dd604e633f":
      self.deleteable = 0;
      break;
    case #"hash_3f2013439426f0b8":
    case #"hash_f2adc5f71cba34f7":
      thread setdeleteabletimer(0.5);
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
  manageworldspawnedbolts();
}

function manageworldspawnedbolts(newbolt) {
  if(isDefined(newbolt)) {
    temparr = [newbolt];
  } else {
    temparr = [];
  }

  foreach(bolt in level.crossbowbolts) {
    if(!isDefined(bolt)) {
      continue;
    }

    if(isDefined(bolt)) {
      if(temparr.size >= 24 && bolt.deleteable) {
        bolt delete();
        continue;
      }

      temparr[temparr.size] = bolt;
    }
  }

  level.crossbowbolts = temparr;
}

function getcrossbowammotype(weapon) {
  switch (weapon.modifier) {
    case #"hash_1384dc17fea40a53":
    case #"hash_54394a972b4ae6e1":
      return "bolt_explo";
    case #"hash_135ed917fe85f086":
    case #"hash_542d33972b41c850":
      return "bolt_fire";
    case #"hash_19baf8c5b7e79ee1":
    case #"hash_bb2800f912ce65eb":
      if(weapon.modifiervarindex == 1) {
        return "bolt_stun_vday";
      } else {
        return "bolt_stun";
      }
    case #"hash_464357c5cf40c360":
      return "bolt_molotov";
    case #"hash_fc78a991420fd12e":
      return "bolt_snapshot";
    case #"hash_dd886f93e6f7e11":
      return "bolt_ripper";
    default:
      return "bolt_default";
  }
}

function getcrossbowimpactfunc(ammotype) {
  switch (ammotype) {
    case #"hash_546f43dd604e633f":
      return &impactfunc_explo;
    case #"hash_5565a4776393e4b7":
      return &impactfunc_fire;
    case #"hash_3f2013439426f0b8":
    case #"hash_f2adc5f71cba34f7":
      return &impactfunc_stun;
    case #"hash_ae030c32020d2f3b":
      return &function_b086ad2ca32b8b08;
    case #"hash_841d3280c0d224ab":
      return &function_4001c2c1b47fb0be;
    default:
      return;
  }
}

function function_f7e93e7794bb696d(ammotype) {
  switch (ammotype) {
    case #"hash_546f43dd604e633f":
      return &impactfunc_explo;
    case #"hash_5565a4776393e4b7":
      return &impactfunc_fire;
    case #"hash_f2adc5f71cba34f7":
      return &impactfunc_stun;
    case #"hash_ae030c32020d2f3b":
      return &function_b086ad2ca32b8b08;
    default:
      return;
  }
}

function getboltmodel(ammotype) {
  switch (ammotype) {
    case #"hash_546f43dd604e633f":
      return "weapon_wm_sn_crossbow_bolt_explosive_static";
    case #"hash_5565a4776393e4b7":
      return "weapon_wm_sn_crossbow_bolt_fire_static";
    case #"hash_f2adc5f71cba34f7":
      return "weapon_wm_sn_crossbow_bolt_stun_static";
    case #"hash_3f2013439426f0b8":
      return "weapon_wm_sn_crossbow_bolt_stun_vday_static";
    case #"hash_ae030c32020d2f3b":
      return "weapon_wm_sn_crossbow_bolt_molotov_static";
    default:
      return "weapon_wm_sn_crossbow_bolt_static";
  }
}

function shouldreflect(surfacetype, bolt, hitent, hitentpart, weapon) {
  if(!isDefined(hitent) && isDefined(hitentpart) && hitentpart == function_3db00f01cdba4538("tag_origin")) {
    return 1;
  }

  if(isDefined(hitent) && istrue(hitent.var_9d4f1024957fde36)) {
    return 1;
  }

  if(isDefined(hitent) && isDefined(hitent.code_classname) && hitent.code_classname == "scriptable") {
    return 1;
  }

  if(issameteamplayer(hitent) || issameteamagent(hitent)) {
    if(weapon.basename == "iw9_dm_crossbow_mp") {
      return 1;
    } else {
      return 0;
    }
  }

  if(!isDefined(surfacetype)) {
    return 0;
  }

  switch (surfacetype) {
    case #"hash_886109ae17c9aa73":
    case #"hash_8c9d4c67dcde81f2":
      return 1;
  }

  if(function_1cef76b86c23032b(hitent, hitentpart)) {
    return 1;
  }

  if(bolt.ammotype == "bolt_explo") {
    return 0;
  }

  if(getcrossbowammotype(weapon) == "bolt_stun_vday" && (isPlayer(hitent) || isagent(hitent)) && !isalive(hitent)) {
    return 1;
  }

  switch (surfacetype) {
    case #"hash_dacf073cf66fde4":
    case #"hash_67e845c97d1f9eda":
    case #"hash_f9100fc94321f813":
      return 1;
    case #"hash_fb5a4fd62140d3d":
    case #"hash_321a9678047d0a4e":
    case #"hash_519950fd846289c6":
    case #"hash_7fe735e403d9fe08":
    case #"hash_91afe7576024a903":
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
  bolt solid();
  bolt physicslaunchserver(impactpos, vec);
}

function shoulddeleteimmediately(hitent, weapon) {
  if(!isDefined(hitent)) {
    return false;
  }

  if(isDefined(hitent) && istrue(hitent.var_c122daa06de1cc56)) {
    return true;
  }

  if(isagent(hitent) && hitent is_suicidebomber() && !isalive(hitent) && !isDefined(hitent getcorpseentity())) {
    return true;
  }

  if((issameteamplayer(hitent) || issameteamagent(hitent)) && weapon.basename != "iw9_dm_crossbow_mp") {
    return true;
  }

  return false;
}

function shoulddrop(hitent, hitloc) {
  if(!isDefined(hitent)) {
    return false;
  }

  if(isDefined(hitent) && istrue(hitent.var_48b4b50848b36508)) {
    return true;
  }

  if((isPlayer(hitent) || isagent(hitent)) && !isalive(hitent) && !isDefined(hitent getcorpseentity())) {
    return true;
  }

  if(isagent(hitent) && utility::issharedfuncdefined("ai", "isLimbDismembered")) {
    if(hitent[[utility::getsharedfunc("ai", "isLimbDismembered")]](hitloc)) {
      return true;
    }
  }

  return false;
}

function dropbolt(bolt) {
  bolt solid();
  bolt physicslaunchserver();
}

function shouldlink(hitent, hitentpart, weapon) {
  if(!isDefined(hitent)) {
    return false;
  }

  return true;
}

function is_suicidebomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function function_5478d81cf5ea8d4(bolt, hitent, hitentpart) {
  if((isPlayer(hitent) || isagent(hitent)) && !isalive(hitent)) {
    corpse = hitent getcorpseentity();

    if(isDefined(corpse)) {
      hitent = corpse;
    }
  }

  if(isPlayer(hitent) && bolt.ammotype != "bolt_stun") {
    bolt hidefromplayer(hitent);

    if(isDefined(bolt.pickuptrigger)) {
      bolt.pickuptrigger hidefromplayer(hitent);
    }

    if(bolt.ammotype == "bolt_fire") {
      hitent thread docrossbowhitplayerthermitesounds();
    }
  }

  if(isDefined(hitentpart) && hitent tagexists(hitentpart)) {
    bolt linkTo(hitent, hitentpart);
    bolt function_4510118c9d9ee7b2(hitent, hitentpart);
  } else {
    bolt linkTo(hitent);
  }

  bolt.linked = 1;

  if(cansticktoent(hitent)) {
    bolt.stuckenemyentity = hitent;
    bolt thread removestuckenemyondeathordisconnect(hitent);
  } else if(isenemycorpse(hitent)) {
    bolt thread function_a4930163e0971504();
  }

  bolt function_1268ac885adc88a2(1);
  bolt thread boltunlinkonnote(hitent);
  bolt thread boltdeleteonnote(hitent, "vehicle_deleted");
  bolt thread boltdeleteonnote(hitent, "detonated");
  bolt thread boltdeleteonnote(hitent, "beginC130");
}

function validateboltent() {
  if(isDefined(self) && istrue(self.iscrossbowbolt)) {
    return 1;
  }

  assertmsg("<dev string:x1c>");
}

function removestuckenemyondeathordisconnect(hitent) {
  self endon("entitydeleted");
  hitent waittill_any_3("entitydeleted", "death", "disconnect");

  if(!validateboltent()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(hitent) && isDefined(hitent.nocorpse)) {
    self delete();
  }

  function_a4930163e0971504();
}

function isenemycorpse(hitent) {
  if(isDefined(hitent.targetname) && hitent.targetname == "player_corpse") {
    return 1;
  }

  return 0;
}

function function_a4930163e0971504() {
  self endon("entitydeleted");
  wait 45;

  if(!validateboltent()) {
    return;
  }

  self delete();
}

function boltunlinkonnote(hitent) {
  self endon("entitydeleted");
  hitent waittill_any_3("entitydeleted", "disconnect");
  boltunlink();
}

function boltunlink(launchvec) {
  if(!validateboltent()) {
    return;
  }

  if(!isDefined(self.linked)) {
    return;
  }

  if(self islinked()) {
    self unlink();
  }

  self.linked = undefined;

  if(!isDefined(launchvec)) {
    launchvec = (0, 0, 100);
  }

  if(!isDefined(self.model) || self.model == "tag_origin") {
    return;
  }

  if(!isDefined(self.classname) || self.classname != "script_model") {
    return;
  }

  self solid();
  self physicslaunchserver(self.origin, launchvec);
}

function boltdeleteonnote(hitent, note) {
  self endon("entitydeleted");
  hitent waittill(note);

  if(!validateboltent()) {
    return;
  }

  self delete();
}

function boltdeletethread() {
  self waittill("entitydeleted");

  if(isDefined(self.pickuptrigger)) {
    self.pickuptrigger delete();
  }

  if(isDefined(self.grenade)) {
    self.grenade delete();
  }
}

function function_acd8433c3043c4f2(surfacenormal) {
  if(isDefined(surfacenormal)) {
    self dontinterpolate();
    self.angles = vectortoangles(surfacenormal * -1);
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

function issameteamagent(hitent) {
  if(!isagent(hitent)) {
    return false;
  }

  if(isDefined(hitent.agentteam) && self.team == hitent.agentteam) {
    return true;
  }

  return false;
}

function cansticktoent(hitent) {
  if(isai(hitent)) {
    return true;
  }

  if(isPlayer(hitent) || isagent(hitent)) {
    return true;
  }

  if(isDefined(hitent.vehiclename)) {
    return true;
  }

  if(isDefined(hitent.classname)) {
    if(hitent.classname == "misc_turret") {
      return true;
    }

    if(hitent.classname == "script_model") {
      if(isDefined(hitent.streakinfo) && isDefined(hitent.streakinfo.streakname) && (hitent.streakinfo.streakname == "uav" || hitent.streakinfo.streakname == "gunship")) {
        return true;
      }

      if(isDefined(hitent.targetname) && hitent.targetname == "enemyTarget") {
        return true;
      }
    }
  }

  if(isDefined(hitent.equipmentref)) {
    if(hitent.equipmentref == "equip_tac_cover") {
      return true;
    }
  }

  return false;
}

function isthermitecrossbow(objweapon) {
  if(isDefined(objweapon.modifier)) {
    return (objweapon.modifier == "ammo_bolt_db");
  }

  return false;
}

function function_42b0dfeb350f6ea5() {
  return 4.5;
}

function function_5d09c8fae400afb2(watcherweapon) {
  if(!function_f023a978eea742d3(watcherweapon)) {
    return;
  }

  function_c0ab8a070e986732();

  while(true) {
    self waittill("weapon_fired");
    function_a2e0841b4f6a8c5f();
    childthread function_e27041f5372c53f1();
    childthread function_e26f4be6d803c186();
    self waittill("reload");
    function_182a5b792f5c615a();
  }
}

function function_f023a978eea742d3(objweapon) {
  if(isDefined(objweapon.scope) && objweapon.scope == "fourx04" && objweapon.scopevarindex == 4) {
    return 1;
  }

  return 0;
}

function function_e27041f5372c53f1() {
  self endon("bullet_terminated");
  self endon("reload");
  self waittill("bullet_first_impact", var_9d7ca6252f103a3b, hitent, hitentpart, surfacenormal, surfacetype, weapon, bulletdir, impactpos, hitloc);

  if(stunshoulddetonate(hitent, surfacetype)) {
    function_32dd4ab63407230e();
    return;
  }

  function_4d540620ce852f82();
}

function function_e26f4be6d803c186() {
  self endon("bullet_first_impact");
  self endon("reload");
  self waittill("bullet_terminated");
  function_4d540620ce852f82();
}

function function_c0ab8a070e986732() {
  self setclientomnvar("ui_reticle_mtx_action", 0);
}

function function_a2e0841b4f6a8c5f() {
  self setclientomnvar("ui_reticle_mtx_action", 1);
}

function function_32dd4ab63407230e() {
  self setclientomnvar("ui_reticle_mtx_action", 2);
}

function function_4d540620ce852f82() {
  self setclientomnvar("ui_reticle_mtx_action", 3);
}

function function_182a5b792f5c615a() {
  self setclientomnvar("ui_reticle_mtx_action", 4);
}

function docrossbowhitplayerthermitesounds() {
  var_63c7f7bafd29c6cf = spawn("script_origin", self.origin);
  var_63c7f7bafd29c6cf linkTo(self);
  var_63c7f7bafd29c6cf playSound("thermite_bomb_crossbow_impact");
  var_63c7f7bafd29c6cf playLoopSound("thermite_bomb_crossbow_fire_lp");
  waittill_any_timeout_3(4.5, "entitydeleted", "death", "disconnect");
  var_63c7f7bafd29c6cf playSound("thermite_bomb_crossbow_fire_end");
  var_63c7f7bafd29c6cf stoploopsound("thermite_bomb_crossbow_fire_lp");
  wait 5;
  var_63c7f7bafd29c6cf delete();
}

function function_1cef76b86c23032b(hitent, hitentpart) {
  if(!isDefined(hitent)) {
    return false;
  }

  if(!isDefined(hitentpart)) {
    return false;
  }

  var_cc077650ade11117 = function_8ed0ffa3f8be7c75(hitentpart);

  if(!function_6efe6c06514615(var_cc077650ade11117)) {
    return false;
  }

  if(isDefined(hitent.damageableparts) && var_cc077650ade11117 != "" && isDefined(hitent.damageableparts[var_cc077650ade11117]) && isDefined(hitent.damageableparts[var_cc077650ade11117].healthvalue)) {
    part = hitent.damageableparts[var_cc077650ade11117];

    if(part.healthvalue == 0) {
      return true;
    }
  }

  return false;
}

function function_4510118c9d9ee7b2(hitent, hitentpart) {
  var_cc077650ade11117 = function_8ed0ffa3f8be7c75(hitentpart);

  if(!function_6efe6c06514615(var_cc077650ade11117)) {
    return;
  }

  if(isDefined(hitent.damageableparts) && var_cc077650ade11117 != "" && isDefined(hitent.damageableparts[var_cc077650ade11117])) {
    if(!isDefined(hitent.damageableparts[var_cc077650ade11117].var_673c6895d1418e1c)) {
      hitent.damageableparts[var_cc077650ade11117].var_673c6895d1418e1c = [];
    }

    hitent.damageableparts[var_cc077650ade11117].var_673c6895d1418e1c = array_add(hitent.damageableparts[var_cc077650ade11117].var_673c6895d1418e1c, self);
  }
}

function function_8ed0ffa3f8be7c75(xhash) {
  if(!isDefined(level.var_d43e78e513933216)) {
    return "";
  }

  return default_to(level.var_d43e78e513933216[xhash], "");
}

function function_6efe6c06514615(partstring) {
  if(issubstr(partstring, "tag_wheel") || issubstr(partstring, "tag_door")) {
    return 1;
  }

  return 0;
}