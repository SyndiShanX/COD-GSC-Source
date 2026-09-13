/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\crossbow.gsc
***********************************************/

initcrossbowusage(weapon) {
  if(!isDefined(level.crossbowbolts))
    level.crossbowbolts = [];

  if(!isDefined(self.crossbow)) {
    self.crossbow = spawnStruct();
    self.crossbow.boltnumber = 0;
    self.crossbow.boltsinflight = [];
  }

  self.crossbow.active = 1;
}

crossbowusageloop(weapon) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  ammotype = getcrossbowammotype(weapon);
  thread crossbowimpactwatcher(weapon, ammotype);
}

cleanupafterweaponswitch() {
  self waittill("end_launcher");
  _id_C0AB8A070E986732();
  wait 6;
  self notify("cleanupImpactWatcher");
}

crossbowimpactwatcher(_id_551411054E80B44B, ammotype) {
  self notify("cleanupImpactWatcher");
  self endon("disconnect");
  self endon("cleanupImpactWatcher");
  childthread cleanupafterweaponswitch();
  childthread watchforimpact(_id_551411054E80B44B, ammotype);
  childthread _id_5D09C8FAE400AFB2(_id_551411054E80B44B);
  childthread _id_F16D37D0028D5DE3(_id_551411054E80B44B, ammotype);
}

watchforimpact(_id_551411054E80B44B, ammotype) {
  _id_74231E1029EF65B5 = getcrossbowimpactfunc(ammotype);

  for(;;) {
    self waittill("bullet_first_impact", _id_9D7CA6252F103A3B, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, hitloc);

    if(_id_551411054E80B44B != weapon) {
      continue;
    }
    _id_E314A4412AFF5E4A = spawncrossbowbolt(_id_25DE37BAEC255643, _id_F07322C0D6CA069C, ammotype, weapon);
    handleimpact(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, _id_74231E1029EF65B5);
  }
}

_id_F16D37D0028D5DE3(_id_551411054E80B44B, ammotype) {
  _id_A0DFB992760D09E3 = _id_F7E93E7794BB696D(ammotype);

  for(;;) {
    self waittill("bullet_terminated", weapon, _id_F07322C0D6CA069C, _id_3ACCF23EBCB854D9);

    if(_id_551411054E80B44B != weapon) {
      continue;
    }
    _id_E314A4412AFF5E4A = spawncrossbowbolt(_id_3ACCF23EBCB854D9, _id_F07322C0D6CA069C, ammotype, weapon);
    _id_05C14133D6577BEF(_id_E314A4412AFF5E4A, _id_A0DFB992760D09E3);
  }
}

handleimpact(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, _id_74231E1029EF65B5) {
  if(shouldreflect(surfacetype, _id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, weapon))
    reflectbolt(_id_E314A4412AFF5E4A, _id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C, _id_25DE37BAEC255643);
  else if(shoulddeleteimmediately(_id_1D9FB21B4F3023F3)) {
    _id_E314A4412AFF5E4A delete();
    return;
  } else if(shouldlink(_id_1D9FB21B4F3023F3))
    _id_05478D81CF5EA8D4(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E);

  if(isDefined(_id_74231E1029EF65B5))
    [[_id_74231E1029EF65B5]](_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype);
}

_id_05C14133D6577BEF(_id_E314A4412AFF5E4A, _id_A0DFB992760D09E3) {
  if(isDefined(_id_A0DFB992760D09E3))
    [[_id_A0DFB992760D09E3]](_id_E314A4412AFF5E4A);
}

impactfunc_explo(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype) {
  _id_E314A4412AFF5E4A setscriptablepartstate("effects", "impact");

  if(isDefined(_id_1D9FB21B4F3023F3) && (isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)))
    fusetime = 1.1;
  else
    fusetime = 2;

  _id_E314A4412AFF5E4A.grenade = magicgrenademanual("semtex_bolt_mp", _id_E314A4412AFF5E4A.origin, (0, 0, 0), fusetime);
  _id_E314A4412AFF5E4A.grenade.angles = _id_E314A4412AFF5E4A.angles;
  _id_E314A4412AFF5E4A.grenade linkTo(_id_E314A4412AFF5E4A, "tag_origin");

  if(isDefined(_id_1D9FB21B4F3023F3) && isagent(_id_1D9FB21B4F3023F3) && !istrue(_id_1D9FB21B4F3023F3._id_274D3A7704E351EF))
    scripts\common\ai::_id_60DAA23100A2B874(_id_E314A4412AFF5E4A.grenade, _id_1D9FB21B4F3023F3);

  thread exploboltexplode(_id_E314A4412AFF5E4A, fusetime, _id_5E8EDE0EF6D7F3AB);
}

impactfunc_fire(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype) {
  thread _id_9BDA31FD01A8CB74(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc);
}

impactfunc_stun(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype) {
  if(!stunshoulddetonate(_id_1D9FB21B4F3023F3, surfacetype))
    thread _id_8FD268F7BE208047(_id_E314A4412AFF5E4A);
  else if(_id_9D1CDBD50D208B78(_id_E314A4412AFF5E4A))
    thread _id_397BF021CC9037F8(_id_E314A4412AFF5E4A);
  else
    thread _id_2A6AC0FC60AF6C16(_id_E314A4412AFF5E4A, _id_5E8EDE0EF6D7F3AB);
}

_id_B086AD2CA32B8B08(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype) {
  thread _id_704DD2C09AD39716(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc);
}

_id_A73C5B03989D6EDA(_id_E314A4412AFF5E4A) {}

_id_1CC12BDC257818CC(_id_E314A4412AFF5E4A) {}

_id_3088A41A2AE98710(_id_E314A4412AFF5E4A) {}

exploboltexplode(_id_E314A4412AFF5E4A, fusetime, _id_5E8EDE0EF6D7F3AB) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  _id_E314A4412AFF5E4A.grenade scripts\engine\utility::waittill_any_timeout_no_endon_death_1(fusetime, "explode");
  _id_E314A4412AFF5E4A _id_ACD8433C3043C4F2(_id_5E8EDE0EF6D7F3AB);
  _id_E314A4412AFF5E4A setscriptablepartstate("effects", "explode");
  _id_F6F7DA32D9DCDD7F = makeweapon("semtex_bolt_mp");
  _id_FC2162402FEE9CEA = makeweapon("semtex_bolt_splash_mp");
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_F6F7DA32D9DCDD7F, _id_E314A4412AFF5E4A.weapon);
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_FC2162402FEE9CEA, _id_E314A4412AFF5E4A.weapon);

  if(isDefined(_id_E314A4412AFF5E4A.stuckenemyentity) && isalive(_id_E314A4412AFF5E4A.stuckenemyentity)) {
    _id_E314A4412AFF5E4A.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamage();
    _id_E314A4412AFF5E4A.stuckenemyentity dodamage(110, _id_E314A4412AFF5E4A.origin, self, undefined, "MOD_EXPLOSIVE", _id_F6F7DA32D9DCDD7F, "none");
    _id_E314A4412AFF5E4A.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
    _id_E314A4412AFF5E4A.stuckenemyentity thread _id_0A8A4CE8F3B02B96(self);
  }

  radiusdamage(_id_E314A4412AFF5E4A.origin, 160, 110, 35, self, "MOD_EXPLOSIVE", _id_FC2162402FEE9CEA);
  wait 0.4;

  if(!_id_E314A4412AFF5E4A validateboltent()) {
    return;
  }
  _id_E314A4412AFF5E4A delete();
}

_id_0A8A4CE8F3B02B96(inflictor) {
  self endon("disconnect");
  self notify("crossbow_semtex_blockDamage");
  self endon("crossbow_semtex_blockDamage");

  if(!isDefined(self._id_EA445BB2097EAA16))
    self._id_EA445BB2097EAA16 = [];

  self._id_EA445BB2097EAA16[self._id_EA445BB2097EAA16.size] = inflictor;
  waittillframeend;
  self._id_EA445BB2097EAA16 = undefined;
}

_id_9BDA31FD01A8CB74(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  wait 0.18;
  _id_E314A4412AFF5E4A setscriptablepartstate("effects", "impact");
  thread thermiteboltstuckto(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc);
  thread thermiteboltradiusdamage(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3);
  thread thermiteboltburnout(_id_E314A4412AFF5E4A);
}

thermiteboltstuckto(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  _id_F6F7DA32D9DCDD7F = makeweapon("thermite_bolt_mp");
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_F6F7DA32D9DCDD7F, _id_E314A4412AFF5E4A.weapon);

  if((isPlayer(_id_1D9FB21B4F3023F3) || isbot(_id_1D9FB21B4F3023F3)) && isDefined(hitloc) && hitloc == "shield") {
    hitloc = "torso_upper";
    _id_E314A4412AFF5E4A thread _id_28832848CD860D4E(_id_1D9FB21B4F3023F3);
  }

  if(isDefined(_id_E314A4412AFF5E4A.stuckenemyentity) && isalive(_id_E314A4412AFF5E4A.stuckenemyentity)) {
    if(isDefined(_id_1D9FB21B4F3023F3.vehiclename) || isDefined(_id_1D9FB21B4F3023F3.classname) && _id_1D9FB21B4F3023F3.classname == "misc_turret")
      _id_F66B96D301B3D494 = 1.0;
    else
      _id_F66B96D301B3D494 = 0.25;

    ticks = int(4.5 / _id_F66B96D301B3D494);

    while(isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_E314A4412AFF5E4A) && isalive(_id_1D9FB21B4F3023F3) && ticks > 0) {
      _id_1D9FB21B4F3023F3 scripts\cp_mp\utility\damage_utility::forcestuckdamage();
      _id_1D9FB21B4F3023F3 dodamage(5, _id_E314A4412AFF5E4A.origin, self, _id_E314A4412AFF5E4A, "MOD_FIRE", _id_F6F7DA32D9DCDD7F, hitloc);
      _id_1D9FB21B4F3023F3 scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
      ticks--;
      wait(_id_F66B96D301B3D494);
    }
  }
}

_id_28832848CD860D4E(_id_1D9FB21B4F3023F3) {
  _id_1D9FB21B4F3023F3 endon("disconnect");
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 waittill("death");

  if(!validateboltent()) {
    return;
  }
  boltunlink();
}

thermiteboltradiusdamage(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  ticks = int(18.0);
  _id_FA52C6D10EF1F00F = makeweapon("thermite_bolt_radius_mp");
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_FA52C6D10EF1F00F, _id_E314A4412AFF5E4A.weapon);
  _id_E314A4412AFF5E4A.thermiteradiusweaponref = _id_FA52C6D10EF1F00F.basename;

  if(!isDefined(_id_E314A4412AFF5E4A.stuckenemyentity))
    _id_E314A4412AFF5E4A.badplace = _id_49206079981E8DD9(_id_E314A4412AFF5E4A.origin);

  while(ticks > 0) {
    if(isDefined(_id_E314A4412AFF5E4A.stuckenemyentity) && isalive(_id_E314A4412AFF5E4A.stuckenemyentity))
      _id_E314A4412AFF5E4A.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermiteBoltStuck", 0, 0, ::thermite_damagemodifierignorefunc);

    _id_E314A4412AFF5E4A radiusdamage(_id_E314A4412AFF5E4A.origin, 50, 5, 3, self, "MOD_FIRE", _id_FA52C6D10EF1F00F);

    if(isDefined(_id_E314A4412AFF5E4A.stuckenemyentity) && isalive(_id_E314A4412AFF5E4A.stuckenemyentity))
      _id_E314A4412AFF5E4A.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermiteBoltStuck", 0);

    ticks--;
    wait 0.25;
  }
}

_id_49206079981E8DD9(_id_96586EEC2364C35B) {
  badplace = createnavbadplacebybounds(_id_96586EEC2364C35B, (50, 50, 50), (0, 0, 0));
  return badplace;
}

thermite_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!isDefined(inflictor))
    return 1;

  if(!isDefined(inflictor.thermiteradiusweaponref) || inflictor.thermiteradiusweaponref != "thermite_bolt_radius_mp")
    return 1;

  if(!isDefined(inflictor.stuckenemyentity) || inflictor.stuckenemyentity != victim)
    return 1;

  return 0;
}

thermiteboltburnout(_id_E314A4412AFF5E4A) {
  _id_E314A4412AFF5E4A endon("entitydeleted");
  wait 4.5;

  if(!_id_E314A4412AFF5E4A validateboltent()) {
    return;
  }
  _id_E314A4412AFF5E4A setscriptablepartstate("effects", "burnEnd");
  wait(randomfloatrange(0.3, 2.0));

  if(isDefined(_id_E314A4412AFF5E4A.badplace))
    destroynavobstacle(_id_E314A4412AFF5E4A.badplace);

  _id_E314A4412AFF5E4A boltunlink();
  _id_E314A4412AFF5E4A setModel("weapon_wm_sn_crossbow_bolt_fire_static_dst");
}

_id_2A6AC0FC60AF6C16(_id_E314A4412AFF5E4A, _id_5E8EDE0EF6D7F3AB) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  wait 0.16;
  _id_E314A4412AFF5E4A _id_ACD8433C3043C4F2(_id_5E8EDE0EF6D7F3AB);
  _id_E314A4412AFF5E4A setscriptablepartstate("impact", "active");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "gas_createTrigger"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "gas_createTrigger")]](_id_E314A4412AFF5E4A.origin, self, self.team, 5, 0.45);

  thread stunboltdelete(_id_E314A4412AFF5E4A);
}

_id_8FD268F7BE208047(_id_E314A4412AFF5E4A) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  wait 0.1;
  _id_E314A4412AFF5E4A setscriptablepartstate("impact", "dud");
}

_id_397BF021CC9037F8(_id_E314A4412AFF5E4A) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  wait 0.1;
  _id_E314A4412AFF5E4A setscriptablepartstate("impact", "dudUnderwater");
}

stunboltdelete(_id_E314A4412AFF5E4A) {
  _id_E314A4412AFF5E4A endon("entitydeleted");
  wait 0.5;

  if(!_id_E314A4412AFF5E4A validateboltent()) {
    return;
  }
  _id_E314A4412AFF5E4A delete();
}

_id_704DD2C09AD39716(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc) {
  self endon("disconnect");
  _id_E314A4412AFF5E4A endon("entitydeleted");
  _id_6951CF1F43BC8EBE = self getgunangles();
  _id_8011CFFB839E8243 = gettime();
  _id_7331D469160F6A41 = anglesToForward(_id_6951CF1F43BC8EBE) * 940 + anglestoup(_id_6951CF1F43BC8EBE) * 120;
  _id_42F65B4B53C1F5D4 = (gettime() - _id_8011CFFB839E8243) / 1000;
  _id_CEAB23E7A7E95404 = _id_7331D469160F6A41 + (0, 0, -800 * _id_42F65B4B53C1F5D4);

  if(isDefined(_id_1D9FB21B4F3023F3) && (isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)))
    thread _id_8ADD0B9E806FA2FB(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404);
  else
    thread _id_A61B7128BCEA5142(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404);
}

_id_8ADD0B9E806FA2FB(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("molotov", "molotov_burn_for_time"))
    _id_1D9FB21B4F3023F3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("molotov", "molotov_burn_for_time")]](6, self, _id_E314A4412AFF5E4A, _id_E314A4412AFF5E4A);

  _id_CEAB23E7A7E95404 = _id_CEAB23E7A7E95404 * (0, 0, 1);
  caststart = _id_E314A4412AFF5E4A.origin;
  castdir = (0, 0, -1);
  castend = caststart + castdir * 128;
  contents = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("molotov", "molotov_get_cast_contents");
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, _id_E314A4412AFF5E4A, 0, "physicsquery_closest", 1);

  if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
    castend = _id_E021C2744CC7ED68[0]["position"];
    _id_A95D04F8F906E839 = _id_E021C2744CC7ED68[0]["normal"];
    _id_8D3DD4E0CA9BB1C0 = _id_E021C2744CC7ED68[0]["entity"];
    castend = castend - _id_A95D04F8F906E839 * 1;
    _id_AC0E564AC96A9D0F = vectordot(castend - caststart, castdir);
    t = sqrt(2 * _id_AC0E564AC96A9D0F / 800);
    up = _id_A95D04F8F906E839;
    right = anglestoright(_id_6951CF1F43BC8EBE);
    _id_4B65413211AF7033 = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("molotov", "molotov_rebuild_angles_up_right", up, right);
    _id_8B65648A30994E16(_id_E314A4412AFF5E4A, castend, _id_4B65413211AF7033, _id_8D3DD4E0CA9BB1C0, _id_CEAB23E7A7E95404, gettime() + t * 1000);
    return;
  }

  _id_E314A4412AFF5E4A notify("death");
  level thread _id_8D43B846FF1837F1(_id_E314A4412AFF5E4A);
}

_id_A61B7128BCEA5142(_id_E314A4412AFF5E4A, stuckto, _id_6951CF1F43BC8EBE, _id_CEAB23E7A7E95404) {
  angles = undefined;
  forward = vectorNormalize(_id_CEAB23E7A7E95404);
  up = anglestoup(_id_E314A4412AFF5E4A.angles);
  right = anglestoright(_id_6951CF1F43BC8EBE);

  if(abs(vectordot(forward, up)) >= 0.9848)
    angles = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("molotov", "molotov_rebuild_angles_up_right", up, right);
  else
    angles = scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("molotov", "molotov_rebuild_angles_up_forward", up, forward);

  _id_8B65648A30994E16(_id_E314A4412AFF5E4A, _id_E314A4412AFF5E4A.origin, angles, stuckto, _id_CEAB23E7A7E95404, gettime());
}

_id_8B65648A30994E16(_id_E314A4412AFF5E4A, castend, _id_4B65413211AF7033, _id_8D3DD4E0CA9BB1C0, _id_CEAB23E7A7E95404, impacttime) {
  _id_E314A4412AFF5E4A setscriptablepartstate("effects", "explode", 0);
  scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("molotov", "molotov_simulate_impact", _id_E314A4412AFF5E4A, castend, _id_4B65413211AF7033, _id_8D3DD4E0CA9BB1C0, _id_CEAB23E7A7E95404, impacttime);
}

_id_8D43B846FF1837F1(_id_E314A4412AFF5E4A) {
  _id_E314A4412AFF5E4A endon("entitydeleted");
  wait 0.5;

  if(!_id_E314A4412AFF5E4A validateboltent()) {
    return;
  }
  _id_E314A4412AFF5E4A delete();
}

stunshoulddetonate(_id_1D9FB21B4F3023F3, surfacetype) {
  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  if(isDefined(_id_1D9FB21B4F3023F3.targetname) && _id_1D9FB21B4F3023F3.targetname == "enemyTarget")
    return 1;

  if(!isPlayer(_id_1D9FB21B4F3023F3) && !isagent(_id_1D9FB21B4F3023F3))
    return 0;

  if(issameteamplayer(_id_1D9FB21B4F3023F3))
    return 0;

  if(issameteamagent(_id_1D9FB21B4F3023F3))
    return 0;

  if(isDefined(surfacetype) && surfacetype == "riotshield")
    return 0;

  return 1;
}

_id_9D1CDBD50D208B78(_id_E314A4412AFF5E4A) {
  if(scripts\engine\utility::_id_06C71C72547BB931(_id_E314A4412AFF5E4A.origin + (0, 0, 10)))
    return 1;

  return 0;
}

spawncrossbowbolt(_id_25DE37BAEC255643, _id_F07322C0D6CA069C, ammotype, weapon) {
  model = getboltmodel(ammotype);

  if(!isDefined(level.mapname))
    level.mapname = getDvar("g_mapname");

  if(issubstr(level.mapname, "frontend"))
    model = model + "_fe";

  _id_E314A4412AFF5E4A = spawn("script_model", _id_25DE37BAEC255643);
  _id_E314A4412AFF5E4A setModel(model);
  _id_E314A4412AFF5E4A notsolid();
  _id_E314A4412AFF5E4A.angles = vectortoangles(_id_F07322C0D6CA069C);
  _id_E314A4412AFF5E4A setdeleteable(ammotype);
  _id_E314A4412AFF5E4A.owner = self;
  _id_E314A4412AFF5E4A.ammotype = ammotype;
  _id_E314A4412AFF5E4A.weapon = weapon;
  _id_E314A4412AFF5E4A.iscrossbowbolt = 1;

  if(shouldpickup(ammotype))
    _id_E314A4412AFF5E4A = makepickup(_id_E314A4412AFF5E4A);

  _id_E314A4412AFF5E4A thread boltdeletethread();
  manageworldspawnedbolts(_id_E314A4412AFF5E4A);
  return _id_E314A4412AFF5E4A;
}

shouldpickup(ammotype) {
  if(ammotype == "bolt_default" || ammotype == "bolt_stun" || ammotype == "bolt_stun_vday")
    return 1;

  return 0;
}

makepickup(_id_E314A4412AFF5E4A) {
  _id_C0EE4D060004600B = _id_E314A4412AFF5E4A.origin + anglesToForward(_id_E314A4412AFF5E4A.angles) * 15;
  _id_A712EB05EE38EAB9 = axistoangles(anglestoup(_id_E314A4412AFF5E4A.angles), anglestoright(_id_E314A4412AFF5E4A.angles), anglesToForward(_id_E314A4412AFF5E4A.angles));
  trigger = spawn("trigger_rotatable_radius", _id_C0EE4D060004600B, 0, 64, 79);
  trigger.angles = _id_A712EB05EE38EAB9;
  trigger.targetname = "bolt_pickup";
  trigger enablelinkTo();
  trigger linkTo(_id_E314A4412AFF5E4A);
  _id_E314A4412AFF5E4A.pickuptrigger = trigger;
  _id_E314A4412AFF5E4A thread bolt_watchpickup();
  return _id_E314A4412AFF5E4A;
}

removepickup(_id_E314A4412AFF5E4A) {
  _id_E314A4412AFF5E4A notify("removePickup");

  if(isDefined(_id_E314A4412AFF5E4A.pickuptrigger))
    _id_E314A4412AFF5E4A.pickuptrigger delete();
}

bolt_watchpickup() {
  self endon("entitydeleted");
  self endon("removePickup");
  wait 2;

  for(;;) {
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
    _id_6FBA2B63D1FB95E1 = get_weapon_ammo_matched(player getweaponslistprimaries());

    if(!isDefined(_id_6FBA2B63D1FB95E1)) {
      continue;
    }
    if(player bolt_trytopickup(_id_6FBA2B63D1FB95E1))
      self delete();
  }
}

get_weapon_ammo_matched(weapons) {
  foreach(weapon in weapons) {
    if(isDefined(weapon.basename) && weapon.basename == "iw9_dm_crossbow_mp") {
      if(isDefined(weapon.modifier) && weapon.modifier == "ammo_bolt_std" && self.ammotype == "bolt_default")
        return weapon;

      if(isDefined(weapon.modifier) && weapon.modifier == "ammo_bolt_gas" && (self.ammotype == "bolt_stun" || self.ammotype == "bolt_stun_vday"))
        return weapon;
    }
  }

  return undefined;
}

bolt_trytopickup(weapon) {
  maxammo = weaponmaxammo(weapon);
  _id_EA34E536B58878DD = self getweaponammostock(weapon);

  if(_id_EA34E536B58878DD >= maxammo)
    return 0;

  _id_402CBD10005539A1 = int(min(maxammo, _id_EA34E536B58878DD + 1));
  self setweaponammostock(weapon, _id_402CBD10005539A1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "hudIconType"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "hudIconType")]]("crossbowbolt");

  return 1;
}

setdeleteable(ammotype) {
  switch (ammotype) {
    case "bolt_fire":
      thread setdeleteabletimer(5);
      self.deleteable = 0;
      break;
    case "bolt_explo":
      self.deleteable = 0;
      break;
    case "bolt_stun":
    case "bolt_stun_vday":
      thread setdeleteabletimer(0.5);
      self.deleteable = 0;
      break;
    default:
      self.deleteable = 1;
  }
}

setdeleteabletimer(time) {
  self endon("entitydeleted");
  wait(time);
  self.deleteable = 1;
  manageworldspawnedbolts();
}

manageworldspawnedbolts(_id_44C316327321C5FE) {
  if(isDefined(_id_44C316327321C5FE))
    _id_5C397C9CF7A06802 = [_id_44C316327321C5FE];
  else
    _id_5C397C9CF7A06802 = [];

  foreach(_id_E314A4412AFF5E4A in level.crossbowbolts) {
    if(!isDefined(_id_E314A4412AFF5E4A)) {
      continue;
    }
    if(isDefined(_id_E314A4412AFF5E4A)) {
      if(_id_5C397C9CF7A06802.size >= 24 && _id_E314A4412AFF5E4A.deleteable) {
        _id_E314A4412AFF5E4A delete();
        continue;
      }

      _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_E314A4412AFF5E4A;
    }
  }

  level.crossbowbolts = _id_5C397C9CF7A06802;
}

getcrossbowammotype(weapon) {
  switch (weapon.modifier) {
    case "ammo_bolt_he":
      return "bolt_explo";
    case "ammo_bolt_db":
      return "bolt_fire";
    case "ammo_bolt_gas":
      if(weapon.modifiervarindex == 1)
        return "bolt_stun_vday";
      else
        return "bolt_stun";
    case "ammo_bolt_mol":
      return "bolt_molotov";
    default:
      return "bolt_default";
  }
}

getcrossbowimpactfunc(ammotype) {
  switch (ammotype) {
    case "bolt_explo":
      return::impactfunc_explo;
    case "bolt_fire":
      return::impactfunc_fire;
    case "bolt_stun":
    case "bolt_stun_vday":
      return::impactfunc_stun;
    case "bolt_molotov":
      return::_id_B086AD2CA32B8B08;
    default:
      return;
  }
}

_id_F7E93E7794BB696D(ammotype) {
  switch (ammotype) {
    case "bolt_explo":
      return::impactfunc_explo;
    case "bolt_fire":
      return::impactfunc_fire;
    case "bolt_stun":
      return::impactfunc_stun;
    case "bolt_molotov":
      return::_id_B086AD2CA32B8B08;
    default:
      return;
  }
}

getboltmodel(ammotype) {
  switch (ammotype) {
    case "bolt_explo":
      return "weapon_wm_sn_crossbow_bolt_explosive_static";
    case "bolt_fire":
      return "weapon_wm_sn_crossbow_bolt_fire_static";
    case "bolt_stun":
      return "weapon_wm_sn_crossbow_bolt_stun_static";
    case "bolt_stun_vday":
      return "weapon_wm_sn_crossbow_bolt_stun_vday_static";
    case "bolt_molotov":
      return "weapon_wm_sn_crossbow_bolt_molotov_static";
    default:
      return "weapon_wm_sn_crossbow_bolt_static";
  }
}

shouldreflect(surfacetype, _id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, weapon) {
  if(!isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_B3FCD958F4D7876E) && _id_B3FCD958F4D7876E == _func_3DB00F01CDBA4538("tag_origin"))
    return 1;

  if(isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_1D9FB21B4F3023F3.code_classname) && _id_1D9FB21B4F3023F3.code_classname == "scriptable")
    return 1;

  if(issameteamplayer(_id_1D9FB21B4F3023F3))
    return 1;

  if(issameteamagent(_id_1D9FB21B4F3023F3))
    return 1;

  if(!isDefined(surfacetype))
    return 0;

  switch (surfacetype) {
    case "user_terrain_7":
    case "glass_solid":
    case "glass_pane":
      return 1;
  }

  if(_id_1CEF76B86C23032B(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E))
    return 1;

  if(_id_E314A4412AFF5E4A.ammotype == "bolt_explo")
    return 0;

  if(issameteamplayer(_id_1D9FB21B4F3023F3))
    return 1;

  if(issameteamagent(_id_1D9FB21B4F3023F3))
    return 1;

  if(getcrossbowammotype(weapon) == "bolt_stun_vday" && (isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)) && !isalive(_id_1D9FB21B4F3023F3))
    return 1;

  switch (surfacetype) {
    case "glass_vehicle":
    case "asphalt_wet":
    case "asphalt_dry":
      return 1;
    case "plastic":
    case "metal_car":
    case "metal_tank":
    case "metal_helicopter":
    case "metal_thin":
    case "metal_thick":
    case "metal_grate":
    case "riotshield":
      if(_id_E314A4412AFF5E4A.ammotype == "bolt_fire")
        return 0;
      else
        return 1;
    default:
      return 0;
  }
}

reflectbolt(_id_E314A4412AFF5E4A, _id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C, _id_25DE37BAEC255643) {
  _id_06A3A1033FFC2699 = scripts\engine\math::vector_reflect(_id_F07322C0D6CA069C, _id_5E8EDE0EF6D7F3AB);
  dot = abs(vectordot(_id_F07322C0D6CA069C, _id_5E8EDE0EF6D7F3AB));
  _id_91F849DFA0F2014C = scripts\engine\math::factor_value(2300, 1000, dot);
  _id_06A3A1033FFC2699 = _id_06A3A1033FFC2699 * _id_91F849DFA0F2014C;
  _id_E314A4412AFF5E4A solid();
  _id_E314A4412AFF5E4A physicslaunchserver(_id_25DE37BAEC255643, _id_06A3A1033FFC2699);
}

shoulddeleteimmediately(_id_1D9FB21B4F3023F3) {
  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  if(isagent(_id_1D9FB21B4F3023F3) && _id_1D9FB21B4F3023F3 is_suicidebomber() && !isalive(_id_1D9FB21B4F3023F3) && !isDefined(_id_1D9FB21B4F3023F3 getcorpseentity()))
    return 1;

  return 0;
}

shouldlink(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, weapon) {
  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  return 1;
}

is_suicidebomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

_id_05478D81CF5EA8D4(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E) {
  if((isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)) && !isalive(_id_1D9FB21B4F3023F3)) {
    corpse = _id_1D9FB21B4F3023F3 getcorpseentity();

    if(isDefined(corpse))
      _id_1D9FB21B4F3023F3 = corpse;
  }

  if(isPlayer(_id_1D9FB21B4F3023F3) && _id_E314A4412AFF5E4A.ammotype != "bolt_stun") {
    _id_E314A4412AFF5E4A hidefromplayer(_id_1D9FB21B4F3023F3);

    if(isDefined(_id_E314A4412AFF5E4A.pickuptrigger))
      _id_E314A4412AFF5E4A.pickuptrigger hidefromplayer(_id_1D9FB21B4F3023F3);

    if(_id_E314A4412AFF5E4A.ammotype == "bolt_fire")
      _id_1D9FB21B4F3023F3 thread _id_163DED397285C41E();
  }

  if(isDefined(_id_B3FCD958F4D7876E) && _id_1D9FB21B4F3023F3 tagexists(_id_B3FCD958F4D7876E)) {
    _id_E314A4412AFF5E4A linkTo(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E);
    _id_E314A4412AFF5E4A _id_4510118C9D9EE7B2(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E);
  } else
    _id_E314A4412AFF5E4A linkTo(_id_1D9FB21B4F3023F3);

  _id_E314A4412AFF5E4A.linked = 1;

  if(cansticktoent(_id_1D9FB21B4F3023F3)) {
    _id_E314A4412AFF5E4A.stuckenemyentity = _id_1D9FB21B4F3023F3;
    _id_E314A4412AFF5E4A thread removestuckenemyondeathordisconnect(_id_1D9FB21B4F3023F3);
  } else if(_id_54546DC01019F527(_id_1D9FB21B4F3023F3))
    _id_E314A4412AFF5E4A thread _id_A4930163E0971504();

  _id_E314A4412AFF5E4A _meth_1268AC885ADC88A2(1);
  _id_E314A4412AFF5E4A thread boltunlinkonnote(_id_1D9FB21B4F3023F3);
  _id_E314A4412AFF5E4A thread boltdeleteonnote(_id_1D9FB21B4F3023F3, "vehicle_deleted");
  _id_E314A4412AFF5E4A thread boltdeleteonnote(_id_1D9FB21B4F3023F3, "detonated");
  _id_E314A4412AFF5E4A thread boltdeleteonnote(_id_1D9FB21B4F3023F3, "beginC130");
}

validateboltent() {
  if(isDefined(self) && istrue(self.iscrossbowbolt))
    return 1;
  else {}
}

removestuckenemyondeathordisconnect(_id_1D9FB21B4F3023F3) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 scripts\engine\utility::waittill_any_3("entitydeleted", "death", "disconnect");

  if(!validateboltent()) {
    return;
  }
  self.stuckenemyentity = undefined;

  if(isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_1D9FB21B4F3023F3.nocorpse))
    self delete();

  _id_A4930163E0971504();
}

_id_54546DC01019F527(_id_1D9FB21B4F3023F3) {
  if(isDefined(_id_1D9FB21B4F3023F3.targetname) && _id_1D9FB21B4F3023F3.targetname == "player_corpse")
    return 1;
  else
    return 0;
}

_id_A4930163E0971504() {
  self endon("entitydeleted");
  wait 45;

  if(!validateboltent()) {
    return;
  }
  self delete();
}

boltunlinkonnote(_id_1D9FB21B4F3023F3) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 scripts\engine\utility::waittill_any_3("entitydeleted", "disconnect");
  boltunlink();
}

boltunlink(_id_5BE247F60B965650) {
  if(!validateboltent()) {
    return;
  }
  if(!isDefined(self.linked)) {
    return;
  }
  if(self islinked())
    self unlink();

  self.linked = undefined;

  if(!isDefined(_id_5BE247F60B965650))
    _id_5BE247F60B965650 = (0, 0, 100);

  if(!isDefined(self.model) || self.model == "tag_origin") {
    return;
  }
  if(!isDefined(self.classname) || self.classname != "script_model") {
    return;
  }
  self solid();
  self physicslaunchserver(self.origin, _id_5BE247F60B965650);
}

boltdeleteonnote(_id_1D9FB21B4F3023F3, _id_A234A65C378F3289) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 waittill(_id_A234A65C378F3289);

  if(!validateboltent()) {
    return;
  }
  self delete();
}

boltdeletethread() {
  self waittill("entitydeleted");

  if(isDefined(self.pickuptrigger))
    self.pickuptrigger delete();

  if(isDefined(self.grenade))
    self.grenade delete();
}

_id_ACD8433C3043C4F2(_id_5E8EDE0EF6D7F3AB) {
  if(isDefined(_id_5E8EDE0EF6D7F3AB)) {
    self dontinterpolate();
    self.angles = vectortoangles(_id_5E8EDE0EF6D7F3AB * -1);
  }
}

issameteamplayer(_id_1D9FB21B4F3023F3) {
  if(!isPlayer(_id_1D9FB21B4F3023F3))
    return 0;

  if(scripts\cp_mp\utility\player_utility::isenemy(_id_1D9FB21B4F3023F3))
    return 0;
  else
    return 1;
}

issameteamagent(_id_1D9FB21B4F3023F3) {
  if(!isagent(_id_1D9FB21B4F3023F3))
    return 0;

  if(isDefined(_id_1D9FB21B4F3023F3.agentteam) && self.team == _id_1D9FB21B4F3023F3.agentteam)
    return 1;

  return 0;
}

_id_B7F3D4ED89F15341(objweapon) {
  return isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw9_dm_crossbow_mp";
}

cansticktoent(_id_1D9FB21B4F3023F3) {
  if(isai(_id_1D9FB21B4F3023F3))
    return 1;

  if(isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3))
    return 1;

  if(isDefined(_id_1D9FB21B4F3023F3.vehiclename))
    return 1;

  if(isDefined(_id_1D9FB21B4F3023F3.classname)) {
    if(_id_1D9FB21B4F3023F3.classname == "misc_turret")
      return 1;

    if(_id_1D9FB21B4F3023F3.classname == "script_model") {
      if(isDefined(_id_1D9FB21B4F3023F3.streakinfo) && isDefined(_id_1D9FB21B4F3023F3.streakinfo.streakname) && (_id_1D9FB21B4F3023F3.streakinfo.streakname == "uav" || _id_1D9FB21B4F3023F3.streakinfo.streakname == "gunship"))
        return 1;

      if(isDefined(_id_1D9FB21B4F3023F3.targetname) && _id_1D9FB21B4F3023F3.targetname == "enemyTarget")
        return 1;
    }
  }

  if(isDefined(_id_1D9FB21B4F3023F3.equipmentref)) {
    if(_id_1D9FB21B4F3023F3.equipmentref == "equip_tac_cover")
      return 1;
  }

  return 0;
}

_id_FC87AFF67FB01E6F(objweapon) {
  if(isDefined(objweapon.modifier))
    return objweapon.modifier == "ammo_bolt_db";

  return 0;
}

_id_42B0DFEB350F6EA5() {
  return 4.5;
}

_id_5D09C8FAE400AFB2(_id_551411054E80B44B) {
  if(!_id_F023A978EEA742D3(_id_551411054E80B44B)) {
    return;
  }
  _id_C0AB8A070E986732();

  for(;;) {
    self waittill("weapon_fired");
    _id_A2E0841B4F6A8C5F();
    childthread _id_E27041F5372C53F1();
    childthread _id_E26F4BE6D803C186();
    self waittill("reload");
    _id_182A5B792F5C615A();
  }
}

_id_F023A978EEA742D3(objweapon) {
  if(isDefined(objweapon.scope) && objweapon.scope == "fourx04" && objweapon.scopevarindex == 4)
    return 1;
  else
    return 0;
}

_id_E27041F5372C53F1() {
  self endon("bullet_terminated");
  self endon("reload");
  self waittill("bullet_first_impact", _id_9D7CA6252F103A3B, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, hitloc);

  if(stunshoulddetonate(_id_1D9FB21B4F3023F3, surfacetype))
    _id_32DD4AB63407230E();
  else
    _id_4D540620CE852F82();
}

_id_E26F4BE6D803C186() {
  self endon("bullet_first_impact");
  self endon("reload");
  self waittill("bullet_terminated");
  _id_4D540620CE852F82();
}

_id_C0AB8A070E986732() {
  self setclientomnvar("ui_reticle_mtx_action", 0);
}

_id_A2E0841B4F6A8C5F() {
  self setclientomnvar("ui_reticle_mtx_action", 1);
}

_id_32DD4AB63407230E() {
  self setclientomnvar("ui_reticle_mtx_action", 2);
}

_id_4D540620CE852F82() {
  self setclientomnvar("ui_reticle_mtx_action", 3);
}

_id_182A5B792F5C615A() {
  self setclientomnvar("ui_reticle_mtx_action", 4);
}

_id_163DED397285C41E() {
  _id_63C7F7BAFD29C6CF = spawn("script_origin", self.origin);
  _id_63C7F7BAFD29C6CF linkTo(self);
  _id_63C7F7BAFD29C6CF playSound("thermite_bomb_crossbow_impact");
  _id_63C7F7BAFD29C6CF playLoopSound("thermite_bomb_crossbow_fire_lp");
  scripts\engine\utility::waittill_any_timeout_3(4.5, "entitydeleted", "death", "disconnect");
  _id_63C7F7BAFD29C6CF playSound("thermite_bomb_crossbow_fire_end");
  _id_63C7F7BAFD29C6CF stoploopsound("thermite_bomb_crossbow_fire_lp");
  wait 5;
  _id_63C7F7BAFD29C6CF delete();
}

_id_1CEF76B86C23032B(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E) {
  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  if(!isDefined(_id_B3FCD958F4D7876E))
    return 0;

  _id_CC077650ADE11117 = _id_8ED0FFA3F8BE7C75(_id_B3FCD958F4D7876E);

  if(!_id_006EFE6C06514615(_id_CC077650ADE11117))
    return 0;

  if(isDefined(_id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96) && _id_CC077650ADE11117 != "" && isDefined(_id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117]) && isDefined(_id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117]._id_A776F097EB36E500)) {
    part = _id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117];

    if(part._id_A776F097EB36E500 == 0)
      return 1;
  }

  return 0;
}

_id_4510118C9D9EE7B2(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E) {
  _id_CC077650ADE11117 = _id_8ED0FFA3F8BE7C75(_id_B3FCD958F4D7876E);

  if(!_id_006EFE6C06514615(_id_CC077650ADE11117)) {
    return;
  }
  if(isDefined(_id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96) && _id_CC077650ADE11117 != "" && isDefined(_id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117])) {
    if(!isDefined(_id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117]._id_673C6895D1418E1C))
      _id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117]._id_673C6895D1418E1C = [];

    _id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117]._id_673C6895D1418E1C = scripts\engine\utility::array_add(_id_1D9FB21B4F3023F3._id_AAB9695C92B0ED96[_id_CC077650ADE11117]._id_673C6895D1418E1C, self);
  }
}

_id_8ED0FFA3F8BE7C75(_id_9427D76BD72BC70B) {
  if(!isDefined(level._id_D43E78E513933216))
    return "";

  return scripts\engine\utility::_id_53C4C53197386572(level._id_D43E78E513933216[_id_9427D76BD72BC70B], "");
}

_id_006EFE6C06514615(_id_A82468A449D0F391) {
  if(issubstr(_id_A82468A449D0F391, "tag_wheel") || issubstr(_id_A82468A449D0F391, "tag_door"))
    return 1;
  else
    return 0;
}