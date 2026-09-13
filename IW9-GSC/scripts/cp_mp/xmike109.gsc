/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\xmike109.gsc
***********************************************/

initusage(weapon) {
  if(!isDefined(level.xmike109projectiles))
    level.xmike109projectiles = [];

  if(!isDefined(self.xmike109))
    self.xmike109 = spawnStruct();

  self.xmike109.active = 1;
}

usageloop(weapon) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  ammotype = getxmike109ammotype(weapon);

  if(ammotype == "mag_xmike109") {
    return;
  }
  _id_6F14BBB852DACAF9 = getxmike109impactfunc(ammotype);
  thread impactwatcher(weapon, ammotype, _id_6F14BBB852DACAF9);
}

cleanupafterweaponswitch() {
  self waittill("end_launcher");
  wait 6;
  self notify("cleanupXMike109ImpactWatcher");
}

impactwatcher(_id_551411054E80B44B, ammotype, _id_2C27F44E59E5E0EB) {
  self notify("cleanupXMike109ImpactWatcher");
  self endon("disconnect");
  self endon("cleanupXMike109ImpactWatcher");
  childthread cleanupafterweaponswitch();

  if(ammotype == "default") {
    return;
  }
  for(;;) {
    self waittill("bullet_first_impact", _id_9D7CA6252F103A3B, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, hitloc);

    if(_id_551411054E80B44B != weapon) {
      continue;
    }
    handleimpact(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, _id_2C27F44E59E5E0EB, ammotype);
  }
}

handleimpact(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, _id_2C27F44E59E5E0EB, ammotype) {
  _id_87442B30A6159847 = shouldreflect(surfacetype, ammotype, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C);
  projectile = spawnprojectile(_id_25DE37BAEC255643, _id_F07322C0D6CA069C, ammotype, weapon, _id_87442B30A6159847, _id_5E8EDE0EF6D7F3AB);

  if(shoulddeleteimmediately(_id_1D9FB21B4F3023F3)) {
    projectile delete();
    return;
  } else if(shouldlink(_id_1D9FB21B4F3023F3, _id_87442B30A6159847))
    linktoent(projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E);

  if(isDefined(_id_2C27F44E59E5E0EB))
    [[_id_2C27F44E59E5E0EB]](projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, surfacetype, _id_87442B30A6159847);
}

impactfunc_explo(projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, surfacetype, _id_87442B30A6159847) {
  fusetime = 0.1;
  projectile.grenade = magicgrenademanual("semtex_xmike109_mp", projectile.origin, (0, 0, 0), fusetime);
  projectile.grenade.angles = projectile.angles;
  projectile.grenade linkTo(projectile, "tag_origin");
  thread projectileimpactexplode(projectile, fusetime, hitloc);
}

impactfunc_fire(projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, surfacetype, _id_87442B30A6159847) {
  thread projectileimpactthermite(projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_87442B30A6159847);
}

impactfunc_null(projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, surfacetype, _id_87442B30A6159847) {}

projectileimpactexplode(projectile, fusetime, hitloc) {
  self endon("disconnect");
  projectile endon("entitydeleted");
  projectile.grenade scripts\engine\utility::waittill_any_timeout_no_endon_death_1(fusetime, "explode");
  projectile setscriptablepartstate("effects", "explode");
  _id_F6F7DA32D9DCDD7F = makeweapon("semtex_xmike109_mp");
  _id_FC2162402FEE9CEA = makeweapon("semtex_xmike109_splash_mp");
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_F6F7DA32D9DCDD7F, projectile.weapon);
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_FC2162402FEE9CEA, projectile.weapon);
  glassradiusdamage(projectile.origin, 150, 50, 1);

  if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity)) {
    projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamage();
    projectile.stuckenemyentity dodamage(140, projectile.origin, self, self, "MOD_EXPLOSIVE", _id_F6F7DA32D9DCDD7F, hitloc);
    projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
  }

  radiusdamagestepped(projectile.origin, 9, 35, 15, 25, 60, 14, self, "MOD_EXPLOSIVE", _id_FC2162402FEE9CEA);
  wait 0.4;

  if(!projectile validateprojectileent()) {
    return;
  }
  projectile delete();
}

projectileimpactthermite(projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_87442B30A6159847) {
  if(istrue(projectile.isgrenade)) {
    projectile setscriptablepartstate("effects", "reflectThermite");
    waitforstuck(projectile);
  }

  projectile setscriptablepartstate("effects", "burn");
  thread thermitestuckto(projectile);
  thread thermiteradiusdamage(projectile);
  thread thermiteburnout(projectile);
}

waitforstuck(projectile) {
  projectile endon("stuckWaitTimeout");
  projectile thread projectilewaittilstucktimeout();
  projectile waittill("missile_stuck", stuckto, _id_16A48D7056E5C472);

  if(isDefined(stuckto)) {
    linktoent(projectile, stuckto, _id_16A48D7056E5C472);
    projectile.bounceshot = 1;
  }
}

projectilewaittilstucktimeout() {
  wait 3;

  if(isDefined(self))
    self notify("stuckWaitTimeout");
}

thermitestuckto(projectile) {
  self endon("disconnect");
  projectile endon("entitydeleted");
  _id_F6F7DA32D9DCDD7F = makeweapon("thermite_xmike109_mp");
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_F6F7DA32D9DCDD7F, projectile.weapon);

  if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity)) {
    if(projectile.stuckenemyentity scripts\cp_mp\vehicles\vehicle::isvehicle() || isDefined(projectile.stuckenemyentity.classname) && projectile.stuckenemyentity.classname == "misc_turret")
      _id_F66B96D301B3D494 = 0.95;
    else
      _id_F66B96D301B3D494 = 0.25;

    if(istrue(projectile.bounceshot))
      projectile.stuckenemyentity dodamage(80, projectile.origin, self, projectile, "MOD_FIRE", _id_F6F7DA32D9DCDD7F);

    ticks = int(3.0 / _id_F66B96D301B3D494);

    while(isDefined(projectile) && isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity) && ticks >= 0) {
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamage();
      projectile.stuckenemyentity dodamage(3, projectile.origin, self, projectile, "MOD_FIRE", _id_F6F7DA32D9DCDD7F);
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::forcestuckdamageclear();
      ticks--;
      wait(_id_F66B96D301B3D494);
    }
  }
}

thermiteradiusdamage(projectile) {
  self endon("disconnect");
  projectile endon("entitydeleted");
  ticks = int(12.0);
  _id_FA52C6D10EF1F00F = makeweapon("thermite_xmike109_radius_mp");
  scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_FA52C6D10EF1F00F, projectile.weapon);
  projectile.thermiteradiusweaponref = _id_FA52C6D10EF1F00F.basename;

  while(ticks > 0) {
    if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity))
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier("thermite25mmStuck", 0, 0, ::thermite_damagemodifierignorefunc);

    projectile radiusdamage(projectile.origin, 50, 2, 2, self, "MOD_FIRE", _id_FA52C6D10EF1F00F);

    if(isDefined(projectile.stuckenemyentity) && isalive(projectile.stuckenemyentity))
      projectile.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier("thermite25mmStuck", 0);

    ticks--;
    wait 0.25;
  }
}

thermite_damagemodifierignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(!isDefined(inflictor))
    return 1;

  if(!isDefined(inflictor.thermiteradiusweaponref) || inflictor.thermiteradiusweaponref != "thermite_xmike109_radius_mp")
    return 1;

  if(!isDefined(inflictor.stuckenemyentity) || inflictor.stuckenemyentity != victim)
    return 1;

  return 0;
}

thermiteburnout(projectile) {
  projectile endon("entitydeleted");
  wait 3.0;

  if(!projectile validateprojectileent()) {
    return;
  }
  projectile setscriptablepartstate("effects", "burnout");
  projectile setscriptablepartstate("visibility", "hide");
  wait(randomfloatrange(0.3, 2.0));

  if(!projectile validateprojectileent()) {
    return;
  }
  wait(randomfloatrange(2, 3));
  projectile delete();
}

spawnprojectile(_id_25DE37BAEC255643, _id_F07322C0D6CA069C, ammotype, weapon, _id_87442B30A6159847, _id_5E8EDE0EF6D7F3AB) {
  if(_id_87442B30A6159847 && ammotype == "thermal") {
    vel = reflectprojectile(_id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, 1);
    org = _id_25DE37BAEC255643 + _id_5E8EDE0EF6D7F3AB * 10;
    projectile = magicgrenademanual("xmike109_grenade", org, vel, 10);
    projectile.isgrenade = 1;
    playFX(scripts\engine\utility::getfx("xmike109ThermiteBounce"), _id_25DE37BAEC255643, _id_5E8EDE0EF6D7F3AB);
  } else {
    projectile = spawn("script_model", _id_25DE37BAEC255643);
    projectile setModel("weapon_wm_sn_xmike109_projectile");
    projectile.origin = _id_25DE37BAEC255643;

    if(_id_87442B30A6159847) {
      vel = reflectprojectile(_id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, 0);
      projectile physicslaunchserver(_id_25DE37BAEC255643, vel);
    }
  }

  projectile.angles = vectortoangles(_id_F07322C0D6CA069C);
  projectile setdeleteable(ammotype);
  projectile.owner = self;
  projectile.ammotype = ammotype;
  projectile.weapon = weapon;
  projectile.isxmike109projectile = 1;
  projectile thread projectiledeletethread();
  manageworldspawnedprojectiles(projectile);
  return projectile;
}

setdeleteable(ammotype) {
  switch (ammotype) {
    case "thermal":
      thread setdeleteabletimer(3.5);
      self.deleteable = 0;
      break;
    case "explosive":
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
  manageworldspawnedprojectiles();
}

manageworldspawnedprojectiles(_id_A7B23DAE3BCFE5F8) {
  if(isDefined(_id_A7B23DAE3BCFE5F8))
    _id_5C397C9CF7A06802 = [_id_A7B23DAE3BCFE5F8];
  else
    _id_5C397C9CF7A06802 = [];

  foreach(_id_F5BA0D51B1831F07 in level.xmike109projectiles) {
    if(!isDefined(_id_F5BA0D51B1831F07)) {
      continue;
    }
    if(isDefined(_id_F5BA0D51B1831F07)) {
      if(_id_5C397C9CF7A06802.size >= 24 && _id_F5BA0D51B1831F07.deleteable) {
        _id_F5BA0D51B1831F07 delete();
        continue;
      }

      _id_5C397C9CF7A06802[_id_5C397C9CF7A06802.size] = _id_F5BA0D51B1831F07;
    }
  }

  level.xmike109projectiles = _id_5C397C9CF7A06802;
}

getxmike109ammotype(weapon) {
  _id_60424BD85D92D34E = "";

  foreach(attachment in weapon.attachments) {
    if(issubstr(attachment, "calcust")) {
      _id_60424BD85D92D34E = attachment;
      break;
    }
  }

  switch (_id_60424BD85D92D34E) {
    case "calcust2_xmike109":
      return "thermal";
    case "calcust1_xmike109":
      return "explosive";
    default:
      return "default";
  }
}

getxmike109impactfunc(ammotype) {
  switch (ammotype) {
    case "thermal":
      return::impactfunc_fire;
    case "explosive":
      return::impactfunc_explo;
    default:
      return::impactfunc_null;
  }
}

shouldreflect(surfacetype, ammotype, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C) {
  if(!isDefined(surfacetype))
    surfacetype = "";

  if(surfacetype == "riotshield")
    return 1;

  if(ammotype != "thermal")
    return 0;

  if(!isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_B3FCD958F4D7876E))
    return 1;

  if(issameteamplayer(_id_1D9FB21B4F3023F3) || issameteamagent(_id_1D9FB21B4F3023F3))
    return 1;

  if(isenemyteamplayer(_id_1D9FB21B4F3023F3) || isenemyteamagent(_id_1D9FB21B4F3023F3))
    return 0;

  if(isDefined(_id_1D9FB21B4F3023F3)) {
    if(_id_1D9FB21B4F3023F3 scripts\cp_mp\vehicles\vehicle::isvehicle())
      return 0;

    if(isDefined(_id_1D9FB21B4F3023F3.equipmentref) && _id_1D9FB21B4F3023F3.equipmentref == "equip_tac_cover")
      return 0;
  }

  switch (surfacetype) {
    case "glass_solid":
    case "glass_pane":
    case "riotshield":
      return 1;
    default:
      dot = abs(vectordot(_id_F07322C0D6CA069C, _id_5E8EDE0EF6D7F3AB));

      if(dot < 0.2) {
        return 1;
        return;
      }

      return 0;
      return;
  }
}

reflectprojectile(_id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, isgrenade) {
  if(isgrenade) {
    _id_88545910D2FBD70A = 1500;
    _id_88774D10D322045E = 500;
    _id_88774310D321EE60 = 150;
  } else {
    _id_88545910D2FBD70A = 500;
    _id_88774D10D322045E = 500;
    _id_88774310D321EE60 = 500;
  }

  _id_06A3A1033FFC2699 = scripts\engine\math::vector_reflect(_id_F07322C0D6CA069C, _id_5E8EDE0EF6D7F3AB);
  _id_06A3A1033FFC2699 = vectorlerp(_id_06A3A1033FFC2699, _id_5E8EDE0EF6D7F3AB, 0.2);
  dot = abs(vectordot(_id_F07322C0D6CA069C, _id_5E8EDE0EF6D7F3AB));

  if(dot < 0.2) {
    dot = scripts\engine\math::normalize_value(0, 0.2, dot);
    _id_91F849DFA0F2014C = scripts\engine\math::factor_value(_id_88545910D2FBD70A, _id_88774D10D322045E, dot);
  } else {
    dot = scripts\engine\math::normalize_value(0.2, 1, dot);
    _id_91F849DFA0F2014C = scripts\engine\math::factor_value(_id_88774D10D322045E, _id_88774310D321EE60, dot);
  }

  _id_06A3A1033FFC2699 = _id_06A3A1033FFC2699 * _id_91F849DFA0F2014C;
  return _id_06A3A1033FFC2699;
}

shoulddeleteimmediately(_id_1D9FB21B4F3023F3) {
  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  if(isagent(_id_1D9FB21B4F3023F3) && _id_1D9FB21B4F3023F3 is_suicidebomber() && !isalive(_id_1D9FB21B4F3023F3) && !isDefined(_id_1D9FB21B4F3023F3 getcorpseentity()))
    return 1;

  return 0;
}

shouldlink(_id_1D9FB21B4F3023F3, _id_87442B30A6159847) {
  if(_id_87442B30A6159847 || !isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  return 1;
}

is_suicidebomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

linktoent(projectile, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E) {
  if((isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)) && !isalive(_id_1D9FB21B4F3023F3)) {
    corpse = _id_1D9FB21B4F3023F3 getcorpseentity();

    if(isDefined(corpse))
      _id_1D9FB21B4F3023F3 = corpse;
  }

  if(isPlayer(_id_1D9FB21B4F3023F3))
    projectile hidefromplayer(_id_1D9FB21B4F3023F3);

  if(isDefined(_id_B3FCD958F4D7876E))
    projectile linkTo(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E);
  else
    projectile linkTo(_id_1D9FB21B4F3023F3);

  if(cansticktoent(_id_1D9FB21B4F3023F3)) {
    projectile.stuckenemyentity = _id_1D9FB21B4F3023F3;
    projectile thread removestuckenemyondeathordisconnect(_id_1D9FB21B4F3023F3);
  }

  if(!istrue(projectile.isgrenade))
    projectile notsolid();

  projectile thread projectileunlinkonnote(_id_1D9FB21B4F3023F3);
  projectile thread projectiledeleteonnote(_id_1D9FB21B4F3023F3, "vehicle_deleted");
  projectile thread projectiledeleteonnote(_id_1D9FB21B4F3023F3, "detonated");
  projectile thread projectiledeleteonnote(_id_1D9FB21B4F3023F3, "beginC130");
}

validateprojectileent() {
  if(isDefined(self) && istrue(self.isxmike109projectile))
    return 1;
  else {}
}

removestuckenemyondeathordisconnect(_id_1D9FB21B4F3023F3) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 scripts\engine\utility::waittill_any_3("entitydeleted", "death", "disconnect");

  if(!validateprojectileent()) {
    return;
  }
  self.stuckenemyentity = undefined;

  if(isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_1D9FB21B4F3023F3.nocorpse))
    self delete();
}

projectileunlinkonnote(_id_1D9FB21B4F3023F3) {
  self endon("entitydeleted");

  if(isagent(_id_1D9FB21B4F3023F3))
    _id_1D9FB21B4F3023F3 waittill("entitydeleted");
  else
    _id_1D9FB21B4F3023F3 scripts\engine\utility::waittill_any_2("entitydeleted", "disconnect");

  if(!validateprojectileent()) {
    return;
  }
  projectileunlink();
}

projectileunlink(_id_5BE247F60B965650) {
  if(!isDefined(_id_5BE247F60B965650))
    _id_5BE247F60B965650 = (0, 0, 100);

  if(self islinked())
    self unlink();

  if(!istrue(self.isgrenade))
    self solid();

  self physicslaunchserver(self.origin, _id_5BE247F60B965650);
}

projectiledeleteonnote(_id_1D9FB21B4F3023F3, _id_A234A65C378F3289) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 waittill(_id_A234A65C378F3289);

  if(!validateprojectileent()) {
    return;
  }
  self delete();
}

projectiledeletethread() {
  self waittill("entitydeleted");

  if(isDefined(self.grenade))
    self.grenade delete();
}

issameteamplayer(_id_1D9FB21B4F3023F3) {
  if(!isPlayer(_id_1D9FB21B4F3023F3))
    return 0;

  if(scripts\cp_mp\utility\player_utility::isenemy(_id_1D9FB21B4F3023F3))
    return 0;
  else
    return 1;
}

isenemyteamplayer(_id_1D9FB21B4F3023F3) {
  if(!isPlayer(_id_1D9FB21B4F3023F3))
    return 0;

  if(scripts\cp_mp\utility\player_utility::isenemy(_id_1D9FB21B4F3023F3))
    return 1;
  else
    return 0;
}

issameteamagent(_id_1D9FB21B4F3023F3) {
  if(!isagent(_id_1D9FB21B4F3023F3))
    return 0;

  if(isDefined(_id_1D9FB21B4F3023F3.agentteam) && self.team == _id_1D9FB21B4F3023F3.agentteam)
    return 1;

  return 0;
}

isenemyteamagent(_id_1D9FB21B4F3023F3) {
  if(!isagent(_id_1D9FB21B4F3023F3))
    return 0;

  if(isDefined(_id_1D9FB21B4F3023F3.agentteam) && self.team == _id_1D9FB21B4F3023F3.agentteam)
    return 0;

  return 1;
}

cansticktoent(_id_1D9FB21B4F3023F3) {
  _id_EB5A204E520CC8A3 = 0;

  if(isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3))
    _id_EB5A204E520CC8A3 = 1;

  if(_id_1D9FB21B4F3023F3 scripts\cp_mp\vehicles\vehicle::isvehicle())
    _id_EB5A204E520CC8A3 = 1;

  if(isDefined(_id_1D9FB21B4F3023F3.classname)) {
    if(_id_1D9FB21B4F3023F3.classname == "misc_turret")
      _id_EB5A204E520CC8A3 = 1;

    if(_id_1D9FB21B4F3023F3.classname == "script_model") {
      if(isDefined(_id_1D9FB21B4F3023F3.streakinfo) && (_id_1D9FB21B4F3023F3.streakinfo.streakname == "uav" || _id_1D9FB21B4F3023F3.streakinfo.streakname == "gunship"))
        _id_EB5A204E520CC8A3 = 1;
    }
  }

  if(isDefined(_id_1D9FB21B4F3023F3.equipmentref)) {
    if(_id_1D9FB21B4F3023F3.equipmentref == "equip_tac_cover")
      _id_EB5A204E520CC8A3 = 1;
  }

  return _id_EB5A204E520CC8A3;
}