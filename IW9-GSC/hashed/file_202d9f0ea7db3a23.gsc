/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_202d9f0ea7db3a23.gsc
***********************************************/

initcrossbowusage(weapon) {}

crossbowusageloop(weapon) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("end_launcher");
  ammotype = getcrossbowammotype(weapon);
  _id_74231E1029EF65B5 = getcrossbowimpactfunc(ammotype);
  thread crossbowimpactwatcher(weapon, ammotype, _id_74231E1029EF65B5);
}

cleanupafterweaponswitch() {
  self waittill("end_launcher");
  wait 6;
  self notify("endImpactWatcher");
}

crossbowimpactwatcher(_id_551411054E80B44B, ammotype, _id_74231E1029EF65B5) {
  self notify("endImpactWatcher");
  self endon("disconnect");
  self endon("endImpactWatcher");
  childthread cleanupafterweaponswitch();

  for(;;) {
    self waittill("bullet_first_impact", _id_9D7CA6252F103A3B, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, hitloc);

    if(_id_551411054E80B44B != weapon) {
      continue;
    }
    _id_E314A4412AFF5E4A = spawncrossbowbolt(_id_25DE37BAEC255643, _id_F07322C0D6CA069C, ammotype, weapon);
    handleimpact(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, _id_25DE37BAEC255643, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, _id_74231E1029EF65B5);
  }
}

handleimpact(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, _id_5E8EDE0EF6D7F3AB, surfacetype, weapon, _id_F07322C0D6CA069C, _id_25DE37BAEC255643, _id_74231E1029EF65B5) {
  if(shouldreflect(surfacetype, _id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E))
    reflectbolt(_id_E314A4412AFF5E4A, _id_5E8EDE0EF6D7F3AB, _id_F07322C0D6CA069C, _id_25DE37BAEC255643);
  else if(shoulddeleteimmediately(_id_1D9FB21B4F3023F3)) {
    _id_E314A4412AFF5E4A _id_71A47EC0BC86A9A1(1);
    return;
  } else if(shouldlink(_id_1D9FB21B4F3023F3))
    linktoent(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E);

  if(isDefined(_id_74231E1029EF65B5))
    self[[_id_74231E1029EF65B5]](_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, surfacetype);
}

_id_8C51CD45D4F7245D(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E, hitloc, surfacetype) {
  camera = _id_34E2C429F1463C06::_id_EC71C6A3676C9EE6(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, hitloc);

  if(isDefined(camera)) {
    _id_E314A4412AFF5E4A thread boltdeleteonnote(camera, "death");
    _id_E314A4412AFF5E4A thread boltdeleteonnote(camera, "explode");
  }
}

_id_79A632D01CF0C669() {
  return "iw9_dm_recondartcrossbow_mp";
}

spawncrossbowbolt(_id_25DE37BAEC255643, _id_F07322C0D6CA069C, ammotype, weapon) {
  model = getboltmodel(ammotype);
  _id_E314A4412AFF5E4A = spawn("script_model", _id_25DE37BAEC255643);
  _id_E314A4412AFF5E4A setModel(model);
  _id_E314A4412AFF5E4A.angles = vectortoangles(_id_F07322C0D6CA069C);
  _id_E314A4412AFF5E4A setdeleteable();
  _id_E314A4412AFF5E4A.owner = self;
  _id_E314A4412AFF5E4A.ammotype = ammotype;
  _id_E314A4412AFF5E4A.weapon = weapon;
  _id_E314A4412AFF5E4A.iscrossbowbolt = 1;
  _id_E314A4412AFF5E4A thread _id_EDF6A939D6F2D3AF();
  return _id_E314A4412AFF5E4A;
}

setdeleteable() {
  self.deleteable = 0;
}

getcrossbowammotype(weapon) {
  return "bolt_recon";
}

getcrossbowimpactfunc(ammotype) {
  return::_id_8C51CD45D4F7245D;
}

getboltmodel(ammotype) {
  return "weapon_wm_sn_crossbow_bolt_static";
}

validateboltent() {
  if(isDefined(self) && istrue(self.iscrossbowbolt))
    return 1;
  else {}
}

shouldreflect(surfacetype, _id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E) {
  if(!isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_B3FCD958F4D7876E))
    return 1;

  if(!isDefined(surfacetype))
    return 0;

  switch (surfacetype) {
    case "glass_solid":
    case "glass_pane":
      return 1;
  }

  if(_id_E314A4412AFF5E4A.ammotype == "bolt_explo")
    return 0;

  if(issameteamplayer(_id_1D9FB21B4F3023F3))
    return 1;

  if(issameteamagent(_id_1D9FB21B4F3023F3))
    return 1;

  switch (surfacetype) {
    case "riotshield":
    case "asphalt_dry":
    case "asphalt_wet":
      return 1;
    case "metal_tank":
    case "metal_helicopter":
    case "metal_thin":
    case "metal_thick":
    case "metal_grate":
    case "metal_car":
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
  _id_E314A4412AFF5E4A physicslaunchserver(_id_25DE37BAEC255643, _id_06A3A1033FFC2699);
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

_id_71A47EC0BC86A9A1(_id_C4A5A9D9AE155452) {
  if(!validateboltent()) {}

  if(_id_C4A5A9D9AE155452) {}

  self delete();
}

shoulddeleteimmediately(_id_1D9FB21B4F3023F3) {
  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  if(isagent(_id_1D9FB21B4F3023F3) && _id_1D9FB21B4F3023F3 is_suicidebomber() && !isalive(_id_1D9FB21B4F3023F3) && !isDefined(_id_1D9FB21B4F3023F3 getcorpseentity()))
    return 1;

  return 0;
}

is_suicidebomber() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

removestuckenemyondeathordisconnect(_id_1D9FB21B4F3023F3) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 scripts\engine\utility::waittill_any_3("entitydeleted", "death", "disconnect");

  if(!validateboltent()) {
    return;
  }
  self.stuckenemyentity = undefined;

  if(isDefined(_id_1D9FB21B4F3023F3) && isDefined(_id_1D9FB21B4F3023F3.nocorpse))
    _id_71A47EC0BC86A9A1(0);
}

boltdeleteonnote(_id_1D9FB21B4F3023F3, _id_A234A65C378F3289) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 waittill(_id_A234A65C378F3289);

  if(!validateboltent()) {
    return;
  }
  _id_71A47EC0BC86A9A1(0);
}

_id_EDF6A939D6F2D3AF() {
  self waittill("entitydeleted");
}

linktoent(_id_E314A4412AFF5E4A, _id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E) {
  if((isPlayer(_id_1D9FB21B4F3023F3) || isagent(_id_1D9FB21B4F3023F3)) && !isalive(_id_1D9FB21B4F3023F3)) {
    corpse = _id_1D9FB21B4F3023F3 getcorpseentity();

    if(isDefined(corpse))
      _id_1D9FB21B4F3023F3 = corpse;
  }

  if(isPlayer(_id_1D9FB21B4F3023F3))
    _id_E314A4412AFF5E4A hidefromplayer(_id_1D9FB21B4F3023F3);

  if(isDefined(_id_B3FCD958F4D7876E))
    _id_E314A4412AFF5E4A linkTo(_id_1D9FB21B4F3023F3, _id_B3FCD958F4D7876E);
  else
    _id_E314A4412AFF5E4A linkTo(_id_1D9FB21B4F3023F3);

  if(cansticktoent(_id_1D9FB21B4F3023F3)) {
    _id_E314A4412AFF5E4A.stuckenemyentity = _id_1D9FB21B4F3023F3;
    _id_E314A4412AFF5E4A thread removestuckenemyondeathordisconnect(_id_1D9FB21B4F3023F3);
  }

  _id_E314A4412AFF5E4A notsolid();
  _id_E314A4412AFF5E4A thread boltunlinkonnote(_id_1D9FB21B4F3023F3);
  _id_E314A4412AFF5E4A thread boltdeleteonnote(_id_1D9FB21B4F3023F3, "vehicle_deleted");
  _id_E314A4412AFF5E4A thread boltdeleteonnote(_id_1D9FB21B4F3023F3, "detonated");
  _id_E314A4412AFF5E4A thread boltdeleteonnote(_id_1D9FB21B4F3023F3, "beginC130");
}

shouldlink(_id_1D9FB21B4F3023F3) {
  if(!isDefined(_id_1D9FB21B4F3023F3))
    return 0;

  return 1;
}

boltunlinkonnote(_id_1D9FB21B4F3023F3) {
  self endon("entitydeleted");
  _id_1D9FB21B4F3023F3 scripts\engine\utility::waittill_any_2("entitydeleted", "disconnect");

  if(!validateboltent()) {
    return;
  }
  boltunlink();
}

boltunlink(_id_5BE247F60B965650) {
  if(!isDefined(_id_5BE247F60B965650))
    _id_5BE247F60B965650 = (0, 0, 100);

  if(self islinked())
    self unlink();

  if(!isDefined(self.model) || self.model == "tag_origin") {
    return;
  }
  self solid();
  self physicslaunchserver(self.origin, _id_5BE247F60B965650);
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