/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\crossbow.gsc
**************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\vehicle;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
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

  utility::registersharedfunc(#"crossbow", #"boltunlink", &boltunlink);
  self.crossbow.active = 1;
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
  function_3becd532a834f345();
  wait 6;
  self notify("cleanupImpactWatcher");
}

function crossbowimpactwatcher(watcherweapon, ammotype) {
  self notify("cleanupImpactWatcher");
  self endon("disconnect");
  self endon("cleanupImpactWatcher");
  childthread cleanupafterweaponswitch();
  childthread watchforimpact(watcherweapon, ammotype);
  childthread function_682bdd7e31c2ddd1(watcherweapon);
  childthread function_beeff12dd0a9589e(watcherweapon, ammotype);
}

function watchforimpact(watcherweapon, ammotype) {
  crossbowimpactfunc = getcrossbowimpactfunc(ammotype);

  while(true) {
    self waittill("bullet_first_impact", impacts);

    if(watcherweapon != impacts[0].weapon) {
      continue;
    }

    bolt = spawncrossbowbolt(impacts[0].hitpos, impacts[0].hitdir, ammotype, impacts[0].weapon);
    handleimpact(bolt, impacts[0].hitent, impacts[0].hitentpart, impacts[0].hitloc, impacts[0].surfacenormal, impacts[0].surfacetype, impacts[0].weapon, impacts[0].hitdir, impacts[0].hitpos, crossbowimpactfunc);
  }
}

function function_beeff12dd0a9589e(watcherweapon, ammotype) {
  var_1128637eb0714e2a = function_89994eb37340c2a6(ammotype);

  while(true) {
    self waittill("bullet_terminated", weapon, bulletdir, var_d6cddc63cc5fd962);

    if(watcherweapon != weapon) {
      continue;
    }

    bolt = spawncrossbowbolt(var_d6cddc63cc5fd962, bulletdir, ammotype, weapon);
    function_9d6d68a8ef5cf3be(bolt, var_1128637eb0714e2a);
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
    function_6db52ce8e25a40a5(bolt, hitent, hitentpart);
  }

  if(isDefined(crossbowimpactfunc)) {
    [[crossbowimpactfunc]](bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype);
  }
}

function function_9d6d68a8ef5cf3be(bolt, var_1128637eb0714e2a) {
  if(isDefined(var_1128637eb0714e2a)) {
    [[var_1128637eb0714e2a]](bolt);
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

  if(isagent(hitent) && !hitent.var_2f7b28254901f8d6) {
    ai::function_9b5d55d642edff87(bolt.grenade, hitent);
  }

  thread exploboltexplode(bolt, fusetime, surfacenormal);
}

function impactfunc_fire(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  thread function_12a7131021c4ede7(bolt, hitent, hitentpart, hitloc);
}

function impactfunc_stun(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  if(!stunshoulddetonate(hitent, surfacetype)) {
    thread stunboltdud(bolt);
    return;
  }

  if(stununderwater(bolt)) {
    thread function_4744c665476cbe51(bolt);
    return;
  }

  thread stunboltdetonate(bolt, surfacenormal);
}

function impactfunc_molotov(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  thread function_5f45be40107548bf(bolt, hitent, hitentpart, hitloc);
}

function impactfunc_snapshot(bolt, hitent, hitentpart, hitloc, surfacenormal, surfacetype) {
  bundle = level.equipment.table["equip_snapshot_grenade"].bundle;
  bolt.owner = self;

  if(utility::issharedfuncdefined(#"weapons", #"snapshot_bolt_detect")) {
    bolt thread[[utility::getsharedfunc(#"weapons", #"snapshot_bolt_detect")]](256, 750, bundle);
  }

  playFX(utility::getfx("vfx_snap_gren_pulse"), bolt.origin);
  playsoundatpos(bolt.origin, "iw9_snapshot_expl");
}

function function_888faec9ceb06667(bolt) {}

function function_b92518105b8919af(bolt) {}

function function_4e99db0c39be700f(bolt) {}

function exploboltexplode(bolt, fusetime, surfacenormal) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  bolt.grenade utility::waittill_any_timeout_no_endon_death(fusetime, "explode");
  bolt function_5799063fd00c05b5(surfacenormal);
  bolt setscriptablepartstate("effects", "explode");
  stuckweapon = makeweapon("semtex_bolt_mp");
  splashweapon = makeweapon("semtex_bolt_splash_mp");
  weapon_utility::function_502496613f00eb2a(stuckweapon, bolt.weapon);
  weapon_utility::function_502496613f00eb2a(splashweapon, bolt.weapon);
  stuckdamage = 200;
  outerdamage = 50;
  innerdamage = 150;
  idamageradius = 160;

  if(isDefined(bolt.weapon) && bolt.weapon.basename == "jup_jp31_dm_compound_mp") {
    stuckdamage = 200;
    outerdamage = 50;
    innerdamage = 150;
    idamageradius = 160;
  }

  if(isalive(bolt.stuckenemyentity)) {
    bolt.stuckenemyentity damage_utility::forcestuckdamage();
    bolt.stuckenemyentity dodamage(stuckdamage, bolt.origin, self, undefined, "MOD_EXPLOSIVE", stuckweapon, "none");
    bolt.stuckenemyentity damage_utility::forcestuckdamageclear();
    bolt.stuckenemyentity thread function_7a34faea2f3c515f(self);
  }

  radiusdamage(bolt.origin, idamageradius, innerdamage, outerdamage, self, "MOD_EXPLOSIVE", splashweapon);
  wait 0.4;

  if(!bolt validateboltent()) {
    return;
  }

  bolt delete();
}

function function_7a34faea2f3c515f(inflictor) {
  self endon("disconnect");
  self notify("crossbow_semtex_blockDamage");
  self endon("crossbow_semtex_blockDamage");

  if(!isDefined(self.var_672320809c1c1c21)) {
    self.var_672320809c1c1c21 = [];
  }

  self.var_672320809c1c1c21[self.var_672320809c1c1c21.size] = inflictor;
  waittillframeend();
  self.var_672320809c1c1c21 = undefined;
}

function function_12a7131021c4ede7(bolt, hitent, hitentpart, hitloc) {
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
  weapon_utility::function_502496613f00eb2a(stuckweapon, bolt.weapon);

  if((isPlayer(hitent) || isbot(hitent)) && isDefined(hitloc) && hitloc == "shield") {
    hitloc = "torso_upper";
    bolt thread function_43dd396be454b029(hitent);
  }

  if(isalive(bolt.stuckenemyentity)) {
    if(isDefined(hitent vehicle::get_ref()) || hitent.classname == "misc_turret") {
      damage_interval = 1;
    } else {
      damage_interval = 0.25;
    }

    ticks = int(4.5 / damage_interval);

    while(isDefined(hitent) && isDefined(bolt) && isalive(hitent) && ticks > 0) {
      hitent damage_utility::forcestuckdamage();
      hitent dodamage(5, bolt.origin, self, bolt, "MOD_FIRE", stuckweapon, hitloc);
      hitent damage_utility::forcestuckdamageclear();
      ticks--;
      wait damage_interval;
    }
  }
}

function function_43dd396be454b029(hitent) {
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
  weapon_utility::function_502496613f00eb2a(radiusweapon, bolt.weapon);
  bolt.thermiteradiusweaponref = radiusweapon.basename;

  if(!isDefined(bolt.stuckenemyentity)) {
    bolt.badplace = thermitebadplace(bolt.origin);
  }

  while(ticks > 0) {
    if(isalive(bolt.stuckenemyentity)) {
      bolt.stuckenemyentity damage_utility::adddamagemodifier("thermiteBoltStuck", 0, 0, &thermite_damagemodifierignorefunc);
    }

    bolt radiusdamage(bolt.origin, 50, 5, 3, self, "MOD_FIRE", radiusweapon);

    if(isalive(bolt.stuckenemyentity)) {
      bolt.stuckenemyentity damage_utility::removedamagemodifier("thermiteBoltStuck", 0);
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

  if(inflictor.thermiteradiusweaponref != "thermite_bolt_radius_mp") {
    return true;
  }

  if(inflictor.stuckenemyentity != victim) {
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

function stunboltdetonate(bolt, surfacenormal) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  wait 0.16;
  bolt function_5799063fd00c05b5(surfacenormal);
  bolt setscriptablepartstate("impact", "active");

  if(utility::issharedfuncdefined(#"weapons", #"gas_createtrigger")) {
    paplevel = 0;

    if(isDefined(bolt.weapon) && utility::issharedfuncdefined(#"zombie", #"get_pap_level")) {
      paplevel = namespace_9d8e359c3b1041e5::function_1d4087075103b248(bolt.weapon);
    }

    thread[[utility::getsharedfunc(#"weapons", #"gas_createtrigger")]](bolt.origin, self, self.team, 5, 0.45, 1, paplevel);
  }

  thread stunboltdelete(bolt);
}

function stunboltdud(bolt) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  wait 0.1;
  bolt setscriptablepartstate("impact", "dud");
}

function function_4744c665476cbe51(bolt) {
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

function function_5f45be40107548bf(bolt, hitent, hitentpart, hitloc) {
  self endon("disconnect");
  bolt endon("entitydeleted");
  launchangles = self getgunangles();
  launchtimems = gettime();
  launchvelocity = anglesToForward(launchangles) * 940 + anglestoup(launchangles) * 120;
  traveltime = (gettime() - launchtimems) / 1000;
  impactvelocity = launchvelocity + (0, 0, -800 * traveltime);

  if(isDefined(hitent) && (isPlayer(hitent) || isagent(hitent))) {
    thread function_55aab84a1cfcf1ac(bolt, hitent, launchangles, impactvelocity);
    return;
  }

  thread function_c92d596d8d38d761(bolt, hitent, launchangles, impactvelocity);
}

function function_55aab84a1cfcf1ac(bolt, hitent, launchangles, impactvelocity) {
  if(utility::issharedfuncdefined(#"molotov", #"molotov_burn_for_time")) {
    hitent thread[[utility::getsharedfunc(#"molotov", #"molotov_burn_for_time")]](6, self, bolt, bolt);
  }

  impactvelocity *= (0, 0, 1);
  caststart = bolt.origin;
  castdir = (0, 0, -1);
  castend = caststart + castdir * 128;
  contents = utility::callsharedfunc(#"molotov", #"molotov_get_cast_contents");
  castresults = physics_raycast(caststart, castend, contents, bolt, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["position"];
    casthitnorm = castresults[0]["normal"];
    casthitent = castresults[0]["entity"];
    castend -= casthitnorm * 1;
    d = vectordot(castend - caststart, castdir);
    t = sqrt(2 * d / 800);
    up = casthitnorm;
    right = anglestoright(launchangles);
    impactangles = utility::callsharedfunc(#"molotov", #"molotov_rebuild_angles_up_right", up, right);
    function_bb38e98b6937d00b(bolt, castend, impactangles, casthitent, impactvelocity, gettime() + t * 1000);
    return;
  }

  bolt notify("death");
  level thread function_4992085a27550df8(bolt);
}

function function_c92d596d8d38d761(bolt, stuckto, launchangles, impactvelocity) {
  angles = undefined;
  forward = vectorNormalize(impactvelocity);
  up = anglestoup(bolt.angles);
  right = anglestoright(launchangles);

  if(abs(vectordot(forward, up)) >= 0.9848) {
    angles = utility::callsharedfunc(#"molotov", #"molotov_rebuild_angles_up_right", up, right);
  } else {
    angles = utility::callsharedfunc(#"molotov", #"molotov_rebuild_angles_up_forward", up, forward);
  }

  function_bb38e98b6937d00b(bolt, bolt.origin, angles, stuckto, impactvelocity, gettime());
}

function function_bb38e98b6937d00b(bolt, castend, impactangles, casthitent, impactvelocity, impacttime) {
  bolt setscriptablepartstate("effects", "explode", 0);
  utility::callsharedfunc(#"molotov", #"molotov_simulate_impact", bolt, castend, impactangles, casthitent, impactvelocity, impacttime);
}

function function_4992085a27550df8(bolt) {
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

  if(hitent.targetname == "enemyTarget") {
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

  if(surfacetype == "riotshield") {
    return false;
  }

  return true;
}

function stununderwater(bolt) {
  if(utility::ispointinwater(bolt.origin + (0, 0, 10))) {
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

    if(isalive(self.stuckenemyentity) && !isDefined(self.stuckenemyentity vehicle::get_ref())) {
      continue;
    }

    var_74c0eea1de4191a0 = get_weapon_ammo_matched(player getweaponslistprimaries());

    if(!isDefined(var_74c0eea1de4191a0)) {
      continue;
    }

    if(player bolt_trytopickup(var_74c0eea1de4191a0)) {
      self delete();
    }
  }
}

function get_weapon_ammo_matched(weapons) {
  foreach(weapon in weapons) {
    if(weapon.basename == "iw9_dm_crossbow_mp" || weapon.basename == "jup_jp31_dm_compound_mp") {
      if(weapon.modifier == "ammo_bolt_std" && self.ammotype == "bolt_default") {
        return weapon;
      }

      if(weapon.modifier == "ammo_bolt_gas" && (self.ammotype == "bolt_stun" || self.ammotype == "bolt_stun_vday") || weapon.modifier == "jup_ammo_arrow_snapshot" || weapon.modifier == "jup_ammo_arrow_rip" || weapon.modifier == "jup_ammo_arrow_std") {
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

  if(utility::issharedfuncdefined(#"damage", #"hudicontype")) {
    self[[utility::getsharedfunc(#"damage", #"hudicontype")]]("crossbowbolt");
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
      return &impactfunc_molotov;
    case #"hash_841d3280c0d224ab":
      return &impactfunc_snapshot;
    default:
      return;
  }
}

function function_89994eb37340c2a6(ammotype) {
  switch (ammotype) {
    case #"hash_546f43dd604e633f":
      return &impactfunc_explo;
    case #"hash_5565a4776393e4b7":
      return &impactfunc_fire;
    case #"hash_f2adc5f71cba34f7":
      return &impactfunc_stun;
    case #"hash_ae030c32020d2f3b":
      return &impactfunc_molotov;
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
  if(!isDefined(hitent) && hitentpart == getxhash("tag_origin")) {
    return 1;
  }

  if(isDefined(hitent) && hitent.var_fb9c152a3bef72e1) {
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
    case #"hash_d1caa6f32509652e":
      return 1;
  }

  if(function_368d97d5df26034c(hitent, hitentpart)) {
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

  if(isDefined(hitent) && hitent.var_a8a5be77d852fc77) {
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

  if(isDefined(hitent) && hitent.var_ba274cd730dfbf99) {
    return true;
  }

  if((isPlayer(hitent) || isagent(hitent)) && !isalive(hitent) && !isDefined(hitent getcorpseentity())) {
    return true;
  }

  if(isagent(hitent) && utility::issharedfuncdefined(#"ai", #"isLimbDismembered")) {
    if(hitent[[utility::getsharedfunc(#"ai", #"isLimbDismembered")]](hitloc)) {
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
  return istrue(self.unittype == "suicidebomber");
}

function function_6db52ce8e25a40a5(bolt, hitent, hitentpart) {
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
      hitent thread doCrossbowHitPlayerThermiteSounds();
    }
  }

  if(isDefined(hitentpart) && hitent tagexists(hitentpart)) {
    bolt linkTo(hitent, hitentpart);
    bolt function_db6fe503e774d9fb(hitent, hitentpart);
  } else {
    bolt linkTo(hitent);
  }

  bolt.linked = 1;

  if(cansticktoent(hitent)) {
    bolt.stuckenemyentity = hitent;
    bolt thread removestuckenemyondeathordisconnect(hitent);
  } else if(isenemycorpse(hitent)) {
    bolt thread function_7fe4adcb73afa36d();
  }

  bolt function_b398682b38f521f5(1);
  bolt thread boltunlinkonnote(hitent);
  bolt thread boltdeleteonnote(hitent, "vehicle_deleted");
  bolt thread boltdeleteonnote(hitent, "detonated");
  bolt thread boltdeleteonnote(hitent, "beginC130");
}

function validateboltent() {
  if(isDefined(self) && self.iscrossbowbolt) {
    return 1;
  }

  assertmsg("<dev string:x24>");
}

function removestuckenemyondeathordisconnect(hitent) {
  self endon("entitydeleted");
  hitent utility::waittill_any("entitydeleted", "death", "disconnect");

  if(!validateboltent()) {
    return;
  }

  self.stuckenemyentity = undefined;

  if(isDefined(hitent) && isDefined(hitent.nocorpse)) {
    self delete();
  }

  function_7fe4adcb73afa36d();
}

function isenemycorpse(hitent) {
  if(hitent.targetname == "player_corpse") {
    return 1;
  }

  return 0;
}

function function_7fe4adcb73afa36d() {
  self endon("entitydeleted");
  wait 45;

  if(!validateboltent()) {
    return;
  }

  self delete();
}

function boltunlinkonnote(hitent) {
  self endon("entitydeleted");
  hitent utility::waittill_any("entitydeleted", "disconnect");
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

  if(self.classname != "script_model") {
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

function function_5799063fd00c05b5(surfacenormal) {
  if(isDefined(surfacenormal)) {
    self dontinterpolate();
    self.angles = vectortoangles(surfacenormal * -1);
  }
}

function issameteamplayer(hitent) {
  if(!isPlayer(hitent)) {
    return 0;
  }

  if(player_utility::isenemy(hitent)) {
    return 0;
  }

  return 1;
}

function issameteamagent(hitent) {
  if(!isagent(hitent)) {
    return false;
  }

  if(self.team == hitent.agentteam) {
    return true;
  }

  return false;
}

function iscrossbowweapon(objweapon) {
  return isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw9_dm_crossbow_mp";
}

function cansticktoent(hitent) {
  if(isai(hitent)) {
    return true;
  }

  if(isPlayer(hitent) || isagent(hitent)) {
    return true;
  }

  if(isDefined(hitent vehicle::get_ref())) {
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

      if(hitent.targetname == "enemyTarget") {
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

function function_aa9fd31c54910c8() {
  return 4.5;
}

function function_682bdd7e31c2ddd1(watcherweapon) {
  if(!function_e91ae2ccca2d456(watcherweapon)) {
    return;
  }

  function_3becd532a834f345();

  while(true) {
    self waittill("weapon_fired");
    function_30c5047d8c1ee4ce();
    childthread function_ad6efda3fc22e6f6();
    childthread function_a265bd8528bd5787();
    self waittill("reload_ammo_added");
    function_c39894740165284f();
  }
}

function function_e91ae2ccca2d456(objweapon) {
  if(objweapon.scope == "fourx04" && objweapon.scopevarindex == 4) {
    return 1;
  }

  return 0;
}

function function_ad6efda3fc22e6f6() {
  self endon("bullet_terminated");
  self endon("reload");
  self waittill("bullet_first_impact", impacts);

  if(stunshoulddetonate(impacts[0].hitent, impacts[0].surfacetype)) {
    function_f1f9d2266ab06cb();
    return;
  }

  function_74eac2c923061355();
}

function function_a265bd8528bd5787() {
  self endon("bullet_first_impact");
  self endon("reload");
  self waittill("bullet_terminated");
  function_74eac2c923061355();
}

function function_3becd532a834f345() {
  self setclientomnvar("ui_reticle_mtx_action", 0);
}

function function_30c5047d8c1ee4ce() {
  self setclientomnvar("ui_reticle_mtx_action", 1);
}

function function_f1f9d2266ab06cb() {
  self setclientomnvar("ui_reticle_mtx_action", 2);
}

function function_74eac2c923061355() {
  self setclientomnvar("ui_reticle_mtx_action", 3);
}

function function_c39894740165284f() {
  self setclientomnvar("ui_reticle_mtx_action", 4);
}

function doCrossbowHitPlayerThermiteSounds() {
  thermite_bolt_sfx = spawn("script_origin", self.origin);
  thermite_bolt_sfx.targetname = "doCrossbowHitPlayerThermiteSounds";
  thermite_bolt_sfx linkTo(self);
  thermite_bolt_sfx playSound("thermite_bomb_crossbow_impact");
  thermite_bolt_sfx playLoopSound("thermite_bomb_crossbow_fire_lp");
  utility::waittill_any_timeout(4.5, "entitydeleted", "death", "disconnect");
  thermite_bolt_sfx playSound("thermite_bomb_crossbow_fire_end");
  thermite_bolt_sfx stoploopsound("thermite_bomb_crossbow_fire_lp");
  wait 5;
  thermite_bolt_sfx delete();
}

function function_368d97d5df26034c(hitent, hitentpart) {
  if(!isDefined(hitent)) {
    return false;
  }

  if(!isDefined(hitentpart)) {
    return false;
  }

  var_a3dce8b16e28153e = function_d88b357b027cbaed(hitentpart);

  if(!function_7f710e67938d4db4(var_a3dce8b16e28153e)) {
    return false;
  }

  if(isDefined(hitent.damageableparts[var_a3dce8b16e28153e]) && isDefined(hitent.damageableparts) && var_a3dce8b16e28153e != "" && isDefined(hitent.damageableparts[var_a3dce8b16e28153e].healthvalue)) {
    part = hitent.damageableparts[var_a3dce8b16e28153e];

    if(part.healthvalue == 0) {
      return true;
    }
  }

  return false;
}

function function_db6fe503e774d9fb(hitent, hitentpart) {
  var_a3dce8b16e28153e = function_d88b357b027cbaed(hitentpart);

  if(!function_7f710e67938d4db4(var_a3dce8b16e28153e)) {
    return;
  }

  if(isDefined(hitent.damageableparts) && var_a3dce8b16e28153e != "" && isDefined(hitent.damageableparts[var_a3dce8b16e28153e])) {
    if(!isDefined(hitent.damageableparts[var_a3dce8b16e28153e].linkedbolts)) {
      hitent.damageableparts[var_a3dce8b16e28153e].linkedbolts = [];
    }

    hitent.damageableparts[var_a3dce8b16e28153e].linkedbolts[hitent.damageableparts[var_a3dce8b16e28153e].linkedbolts.size] = self;
  }
}

function function_d88b357b027cbaed(xhash) {
  if(!isDefined(level.var_a3dce8b16e28153e)) {
    return "";
  }

  return level.var_a3dce8b16e28153e[xhash] ?? "";
}

function function_7f710e67938d4db4(partstring) {
  if(issubstr(partstring, "tag_wheel") || issubstr(partstring, "tag_door")) {
    return 1;
  }

  return 0;
}