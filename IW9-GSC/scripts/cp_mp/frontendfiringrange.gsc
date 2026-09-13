/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\frontendfiringrange.gsc
*************************************************/

_id_02BEF3A70387BED5() {
  if(getomnvar("ui_firing_range_has_started") == 1) {
    _func_75723F405BAB9463();
    currentweapon = self getcurrentweapon();

    if(isDefined(currentweapon) && isDefined(currentweapon._id_4C23F392C9061568))
      setomnvar("ui_firing_range_weapon_in_use_loot_index", currentweapon._id_4C23F392C9061568.lootid);
    else
      setomnvar("ui_firing_range_weapon_in_use_loot_index", -1);
  }
}

_id_55B15747CA46A0AC() {
  self.guid = 0;
  self.team = "allies";
  groundpos = scripts\common\utility::groundpos(level._id_AEB531C63A3266D6.basecam.origin);
  self spawn(groundpos, level._id_AEB531C63A3266D6.basecam.angles);
  waitframe();
  _id_FDE9D87638F0D841();
  self setclienttriggeraudiozone("frontend_firingrange", 0.25);
  setmusicstate("");

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  bodymodelname = self getcustomizationbody();
  headmodelname = self getcustomizationhead();
  _id_41BD2EEDA1C033D2 = self getcustomizationviewmodel();
  self setModel(bodymodelname);
  self setviewmodel(_id_41BD2EEDA1C033D2);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }

  self setclothtype("vestlight");
  self _meth_8ABE5A968CC3C220("millghtgr");
  level.playerviewowner._id_E7A9752E4F4C7D97 = undefined;
  level.playerviewowner _id_0CBB0697DE4C5728::_id_C72573FB42D0CDBC();
}

_id_0AD45F79E3A9B4D2(_id_FE2109095A023ED7) {
  if(_id_FE2109095A023ED7)
    _func_56F34B9A1463755C();

  self.sessionstate = "playing";
  self.statusicon = "";

  if(istrue(self._id_19300A2D63D79909)) {
    self._id_19300A2D63D79909 = 0;
    waitframe();
    _id_55B15747CA46A0AC();
  }
}

_id_FDE9D87638F0D841() {
  if(isDefined(self.primaryweaponobj))
    self takeweapon(self.primaryweaponobj);

  if(isDefined(self.secondaryweaponobj) && self.secondaryweaponobj.basename != "none")
    self takeweapon(self.secondaryweaponobj);

  self.primaryweaponobj = undefined;
  self.secondaryweaponobj = undefined;
  _id_13ECA9A3244E502F = self _meth_A91EAC707383A642();
  self.primaryweaponobj = _id_13ECA9A3244E502F._id_E69B3B114EC04BFA;
  self giveweapon(self.primaryweaponobj);
  self setweaponammoclip(self.primaryweaponobj, weaponclipsize(self.primaryweaponobj));
  self setweaponammostock(self.primaryweaponobj, weaponmaxammo(self.primaryweaponobj));
  self setactionslot(3, "altmode");
  self.secondaryweaponobj = _id_13ECA9A3244E502F._id_2ED868AC6AB2493A;
  self giveweapon(self.secondaryweaponobj);
  self setweaponammoclip(self.secondaryweaponobj, weaponclipsize(self.secondaryweaponobj));
  self setweaponammostock(self.secondaryweaponobj, weaponmaxammo(self.secondaryweaponobj));
  self switchtoweaponimmediate(self.primaryweaponobj);

  if(isDefined(self.primaryweaponobj) && isDefined(self.primaryweaponobj._id_4C23F392C9061568))
    setomnvar("ui_firing_range_weapon_in_use_loot_index", self.primaryweaponobj._id_4C23F392C9061568.lootid);
  else
    setomnvar("ui_firing_range_weapon_in_use_loot_index", -1);

  if(!isDefined(level.playerviewowner.operatorcustomization))
    level.playerviewowner.operatorcustomization = spawnStruct();

  level.playerviewowner.operatorcustomization.skinref = _id_13ECA9A3244E502F._id_962EF6817910EC78;
  _id_3291E2CBEC055766 = tablelookup("operatorskins.csv", 0, _id_13ECA9A3244E502F._id_962EF6817910EC78, 36);

  if(isDefined(_id_3291E2CBEC055766) && _id_3291E2CBEC055766 != "")
    level.playerviewowner _meth_ 602 B3DE054F2A81(_id_3291E2CBEC055766);

  thread _id_B74A4C79011E5ADF(self.primaryweaponobj);
}

_id_1825B45C23285050() {
  self notify("updateWeaponSwitch");
  self endon("updateWeaponSwitch");
  _id_87BFB3E5EF139E4D = undefined;

  for(;;) {
    self waittill("weapon_change");
    level._id_37A55ECAF979D920 = 0;
    level._id_91D278FB245D797B = 0;
    level._id_FEBC1F5F6FC40F70 = 0;
    level._id_EDCA0E3497F3463F = 0;
    setomnvar("ui_firing_range_accuracy", 0.0);
    setomnvar("ui_firing_range_target_kill_count", 0);
    weapon = self getcurrentweapon();
    _id_AB501F397D3CD312 = getweaponrootname(weapon.basename);

    switch (_id_AB501F397D3CD312) {
      case "iw9_dm_crossbow":
        thread scripts\cp_mp\crossbow::initcrossbowusage();
        thread scripts\cp_mp\crossbow::crossbowusageloop(weapon);
        break;
    }

    if(isDefined(weapon) && isDefined(weapon._id_4C23F392C9061568))
      setomnvar("ui_firing_range_weapon_in_use_loot_index", weapon._id_4C23F392C9061568.lootid);
    else
      setomnvar("ui_firing_range_weapon_in_use_loot_index", -1);

    _id_0CBB0697DE4C5728::_id_B939BC4F3A6D4FDC(weapon);
    _id_0B770C0D79C3B668(weapon, _id_87BFB3E5EF139E4D);
    _id_87BFB3E5EF139E4D = weapon;
  }
}

_id_0B770C0D79C3B668(_id_4DA99B8AAFF6E52A, prevweaponobj) {
  weaponattachmentperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj);
}

weaponattachmentperkupdate(_id_4DA99B8AAFF6E52A, prevweaponobj) {
  _id_503110DC18B08AB9 = undefined;
  _id_88C1658D6B22A174 = undefined;

  if(!isundefinedweapon(prevweaponobj)) {
    _id_88C1658D6B22A174 = getweaponattachments(prevweaponobj);

    if(isDefined(_id_88C1658D6B22A174) && _id_88C1658D6B22A174.size > 0) {
      foreach(_id_4B974A0C3AE8192B in _id_88C1658D6B22A174) {
        perks = _id_DE5D0DB99CD9BFD7(prevweaponobj, _id_4B974A0C3AE8192B);

        if(!isDefined(perks)) {
          continue;
        }
        foreach(perk in perks)
        _id_02EE11F200BF73E2(perk);
      }
    }
  }

  if(!isundefinedweapon(_id_4DA99B8AAFF6E52A)) {
    _id_503110DC18B08AB9 = getweaponattachments(_id_4DA99B8AAFF6E52A);

    if(isDefined(_id_503110DC18B08AB9) && _id_503110DC18B08AB9.size > 0) {
      foreach(_id_8EC829625D9FFE8C in _id_503110DC18B08AB9) {
        perks = _id_DE5D0DB99CD9BFD7(_id_4DA99B8AAFF6E52A, _id_8EC829625D9FFE8C);

        if(!isDefined(perks)) {
          continue;
        }
        foreach(perk in perks)
        _id_1EE3FBFCCEAA746B(perk);
      }
    }
  }
}

_id_DE5D0DB99CD9BFD7(weaponobj, _id_659F734FC2A248FF) {
  _id_23CC62CF981071E5 = _func_4F344EC5B7C45A3F(weaponobj, _id_659F734FC2A248FF);

  if(isDefined(_id_23CC62CF981071E5)) {
    _id_AAF9287B9184CA14 = [];

    foreach(perk in _id_23CC62CF981071E5) {
      _id_D9D32F098F69C77F = _id_3350B04CB0437D15(perk);

      if(isDefined(_id_D9D32F098F69C77F))
        _id_AAF9287B9184CA14[_id_AAF9287B9184CA14.size] = _id_D9D32F098F69C77F;
    }

    return _id_AAF9287B9184CA14;
  }

  return undefined;
}

_id_3350B04CB0437D15(perk) {
  switch (perk) {
    case "specialty_magwell":
      return "specialty_fastreload";
  }

  return undefined;
}

_id_1EE3FBFCCEAA746B(perk) {
  self setperk(perk, 1);
}

_id_02EE11F200BF73E2(perk) {
  self unsetperk(perk, 1);
}

_id_0A0C6C9F9A16B236() {
  _id_FDE9D87638F0D841();
  _id_0AD45F79E3A9B4D2(1);
}

loadout_giveperk(perkname) {
  if(!isDefined(self.loadoutperks))
    self.loadoutperks = [];

  self setperk(perkname, 1);
  self.loadoutperks[self.loadoutperks.size] = perkname;
}

_id_CB993EBADDA105C7() {
  setomnvar("ui_firing_range_has_started", 1);
  _func_DAA1538470157756();

  foreach(trig in level.lanetriggers)
  trig._id_27654D98D67BCCC8 = 0;

  if(_id_914509F96205B92D()) {
    level._id_81756A36088F74A4 = gettime();
    level._id_EE0F9B1B1E7E1DCE = 0;
    level._id_9F4CEDE9E6B31BF0 = 0;
    level._id_CE3C34EAC4202086 = 0;
    level._id_50F8B730D8C5EAE4 = 0;
  }

  level thread _id_F00185B72CDB3B04();
  level._id_37A55ECAF979D920 = 0;
  level._id_91D278FB245D797B = 0;
  level._id_FEBC1F5F6FC40F70 = 0;
  level._id_EDCA0E3497F3463F = 0;
  setomnvar("ui_firing_range_accuracy", 0.0);
  setomnvar("ui_firing_range_target_kill_count", 0);

  if(_id_42C8B6FF9ADFABFA()) {
    setDvar("dvar_04033DA1E021E6D5", 0);
    level._id_DD19F80DE7B179BE = gettime();
    level._id_B8494E78AB9BC23E = 0;
    level._id_6BA74CCD0535DFAB = 0;
    level._id_E89E680520310188 = 0.0;
    level._id_A9A55BEB5763B7D5 = 0;
  }

  self setsuit("iw9_defaultsuit_mp");
  self.sessionstate = "playing";
  self.statusicon = "";
  waitframe();
  self._id_19300A2D63D79909 = 0;
  _id_55B15747CA46A0AC();
  loadout_giveperk("specialty_pistoldraw");
  thread infiniteammo();
  thread _id_1825B45C23285050();
  thread _id_BD002AAB782C389E();
}

_id_A52F1E6528800C39() {
  self._id_19300A2D63D79909 = 1;

  if(isDefined(self.primaryweaponobj)) {
    if(self hasweapon(self.primaryweaponobj)) {
      self takeweapon(self.primaryweaponobj);
      self clearclienttriggeraudiozone(2);
    }
  }

  if(isDefined(self.secondaryweaponobj)) {
    if(self hasweapon(self.secondaryweaponobj))
      self takeweapon(self.secondaryweaponobj);
  }

  self suicide();
  waitframe();
  self allowspectateteam("none", 1);
  self.sessionstate = "spectator";
  thread scripts\cp_mp\frontendutils::frontend_camera_watcher(scripts\cp_mp\frontendutils::camera_section_change);
}

_id_42C8B6FF9ADFABFA() {
  return getdvarint("dvar_E46B4B4F19BE660B", 0) == 1 && getdvarint("dvar_C006752EC3578568", -1) > -1;
}

_id_847107A04C7FC7FB() {
  _id_40F233F0D24307D6 = ["bundle_id", getdvarint("dvar_C006752EC3578568"), "nb_bullet_fired", level._id_B8494E78AB9BC23E, "nb_inspection", getdvarint("dvar_04033DA1E021E6D5"), "nb_target_killed", level._id_A9A55BEB5763B7D5, "accuracy", level._id_E89E680520310188, "time_spent_in_firing_range", gettime() - level._id_DD19F80DE7B179BE];
  dlog_recordevent("dlog_event_try_a_gun_stats", _id_40F233F0D24307D6);
}

_id_914509F96205B92D() {
  return getdvarint("dvar_3E7F94C85DB5827A", 1) == 1;
}

_id_A3931D4B9B90F0E1() {
  if(!_id_914509F96205B92D()) {
    return;
  }
  _id_7E45A75E369B0163 = ["time_spent_in_firing_range", gettime() - level._id_81756A36088F74A4, "last_primary_weapon", self.primaryweaponobj.basename, "last_primary_type", "todo", "last_seconday_weapon", self.secondaryweaponobj.basename, "last_secondary_type", "todo", "last_bullets_fired", level._id_37A55ECAF979D920 + level._id_FEBC1F5F6FC40F70, "last_targets_killed", getomnvar("ui_firing_range_target_kill_count"), "last_accuracy", getomnvar("ui_firing_range_accuracy"), "num_plates_zero", level._id_EE0F9B1B1E7E1DCE, "num_plates_one", level._id_9F4CEDE9E6B31BF0, "num_plates_two", level._id_CE3C34EAC4202086, "num_plates_three", level._id_50F8B730D8C5EAE4];
  dlog_recordevent("dlog_event_firing_range_stats", _id_7E45A75E369B0163);
}

_id_3EC902BEADBE5E8D() {
  if(!_id_914509F96205B92D()) {
    return;
  }
  switch (level._id_37E9D3ECAFDB61DC) {
    case 0:
      level._id_EE0F9B1B1E7E1DCE++;
      break;
    case 1:
      level._id_9F4CEDE9E6B31BF0++;
      break;
    case 2:
      level._id_CE3C34EAC4202086++;
      break;
    case 3:
      level._id_50F8B730D8C5EAE4++;
      break;
  }
}

_id_6DDBFA779DCE4B5D() {
  _id_A3931D4B9B90F0E1();
  _id_A52F1E6528800C39();
  self setspectatedefaults(level.camera_loadout_showcase_overview.basecam.origin, level.camera_loadout_showcase_overview.basecam.angles);
  setomnvar("ui_firing_range_has_started", 0);
  setomnvar("ui_firing_range_lane", -1);
  _func_4738968C0CD77B51();

  if(_id_42C8B6FF9ADFABFA()) {
    _id_847107A04C7FC7FB();
    setDvar("dvar_C006752EC3578568", -1);
  }

  level._id_37A55ECAF979D920 = 0;
  level._id_91D278FB245D797B = 0;
  level._id_FEBC1F5F6FC40F70 = 0;
  level._id_EDCA0E3497F3463F = 0;
  setomnvar("ui_firing_range_accuracy", 0.0);
  setomnvar("ui_firing_range_target_kill_count", 0);
  level notify("exit_firing_range");

  foreach(target in level._id_E0FD2FCCBEADEF41)
  target thread _id_0242BC1E2941732E();
}

_id_31C28009668DE7EC() {
  if(getomnvar("ui_firing_range_has_started") == 1) {
    _func_75723F405BAB9463();
    _id_6DDBFA779DCE4B5D();
  }
}

infiniteammo() {
  level endon("exit_firing_range");
  self notify("infiniteAmmo");
  self endon("infiniteAmmo");

  for(;;) {
    weapons = self getweaponslistprimaries();

    foreach(weapon in weapons) {
      self givemaxammo(weapon);
      self setweaponammostock(weapon, weaponmaxammo(weapon));
    }

    waitframe();
  }
}

_id_7086103BDF1F2C05(_id_10FD8ED3FED0E0AE) {
  _id_9A4A482CAC1B5C20 = level._id_37E9D3ECAFDB61DC;
  level._id_37E9D3ECAFDB61DC = int(max(0, _id_10FD8ED3FED0E0AE));
  setomnvar("ui_firing_range_num_dummy_plates", level._id_37E9D3ECAFDB61DC);

  foreach(ent in level._id_E0FD2FCCBEADEF41)
  ent._id_C284C09EF7780E64.health = _id_314B6888C85326DB();

  if(_id_9A4A482CAC1B5C20 != level._id_37E9D3ECAFDB61DC)
    _id_3EC902BEADBE5E8D();
}

_id_BD002AAB782C389E() {
  self endon("disconnect");
  level endon("game_ended");
  level endon("exit_firing_range");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, val);

    if(_id_7148C1A6F25491F8 == "ui_set_dummy_num_plates")
      _id_7086103BDF1F2C05(val);
  }
}

_id_314B6888C85326DB() {
  return _id_C0EBB986EF34456D() + level._id_37E9D3ECAFDB61DC * 50;
}

_id_C0EBB986EF34456D() {
  _id_2E16E7BE9D5A2E92 = getdvarint("scr_player_maxhealth", 100);

  if(getdvarint("ui_is_magma_gamemode", 0) == 1)
    _id_2E16E7BE9D5A2E92 = getdvarint("dvar_CB5458A36C2B39D9", 150);

  return _id_2E16E7BE9D5A2E92;
}

_id_F00185B72CDB3B04() {
  if(!isDefined(level._id_E0FD2FCCBEADEF41)) {
    if(!isDefined(level._id_37E9D3ECAFDB61DC))
      level._id_37E9D3ECAFDB61DC = 0;

    setupdamageflags();
    level._id_E0FD2FCCBEADEF41 = getEntArray("enemyTarget", "targetname");

    foreach(ent in level._id_E0FD2FCCBEADEF41) {
      ent._id_C284C09EF7780E64 = spawn("script_origin", ent.origin);
      ent._id_C284C09EF7780E64.owner = ent;
      ent._id_C284C09EF7780E64.health = _id_314B6888C85326DB();
      ent._id_3B77CA060F09B517 = getEntArray(ent.target, "targetname");

      foreach(brush in ent._id_3B77CA060F09B517) {
        brush.owner = ent;
        brush thread _id_66CDAC98AC1A8A6A();
      }

      ent._id_C284C09EF7780E64 thread _id_487345CE6A43A653();
      ent thread _id_66CDAC98AC1A8A6A(1);
      ent _id_0CBB0697DE4C5728::_id_C72573FB42D0CDBC();

      if(getdvarint("dvar_19CB7A793CE35F97", 0) == 0)
        ent thread _id_26F9A6AB8C0254BA();
    }
  } else {
    foreach(ent in level._id_E0FD2FCCBEADEF41)
    ent._id_C284C09EF7780E64.health = _id_314B6888C85326DB();
  }

  _id_3EC902BEADBE5E8D();
}

_id_26F9A6AB8C0254BA() {
  _id_833736327534C698 = self.origin + (0, 0, 40);
  self._id_4940CA5C0CD5A797 = _id_833736327534C698;
  _id_D8813B31F9508FE9 = (0, 0, 1);
  self._id_F83A9D5C8D6B9A96 = _id_D8813B31F9508FE9;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, _id_13EA67FC910045AD);
    _id_833736327534C698 = self.origin + (0, 0, 40);

    if(distance(point, _id_833736327534C698) < 48) {
      self._id_4940CA5C0CD5A797 = point;
      self._id_F83A9D5C8D6B9A96 = direction_vec;
      continue;
    }

    self._id_4940CA5C0CD5A797 = _id_833736327534C698;
    self._id_F83A9D5C8D6B9A96 = _id_D8813B31F9508FE9;
  }
}

_id_66CDAC98AC1A8A6A(_id_D4E9008CF35BE9D6) {
  self setCanDamage(1);
  data = spawnStruct();
  data.damage = 0;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, _id_13EA67FC910045AD);
    attacker = level.playerviewowner;
    victim = self.owner;

    if(istrue(_id_D4E9008CF35BE9D6)) {
      victim = self;

      if(scripts\engine\utility::isbulletdamage(meansofdeath) || meansofdeath == "MOD_EXPLOSIVE_BULLET")
        continue;
    }

    hitloc = "torso_upper";

    if(isDefined(self.script_noteworthy)) {
      switch (self.script_noteworthy) {
        case "chest":
          hitloc = "torso_upper";
          break;
        case "head":
          hitloc = "head";
          break;
        case "legs":
          hitloc = "left_leg_upper";
          break;
        case "conflict":
        case "arm":
          hitloc = "left_arm_upper";
          break;
      }
    }

    currenttime = gettime();
    data.origin = self.origin;
    data.attacker = attacker;
    data.meansofdeath = meansofdeath;
    data.weapon = attacker getcurrentweapon();
    data.hitloc = hitloc;
    data.idflags = idflags;
    _id_24DF708F286B0562 = int(floor(damage * _func_77011F86063F18B4(attacker getcurrentweapon(), hitloc)));
    data.damage = _id_24DF708F286B0562;

    if(isspreadweapon(data.weapon))
      data.damage = spreadshotdamagemod(victim, data.attacker, data.weapon, data.damage, data.idflags);

    if(data.damage > 0)
      victim thread _id_FAD21382D44834E8(data);
  }
}

_id_FAD21382D44834E8(instance) {
  _id_C284C09EF7780E64 = self._id_C284C09EF7780E64;

  if(_id_C284C09EF7780E64.health <= 0) {
    return;
  }
  if(!isDefined(level._id_DAF783F0070ECCB5) || level._id_DAF783F0070ECCB5.damage < instance.damage)
    level._id_DAF783F0070ECCB5 = instance;

  level notify("processDamageThisFrame");
  level endon("processDamageThisFrame");
  waittillframeend;
  instance = level._id_DAF783F0070ECCB5;
  level._id_DAF783F0070ECCB5 = undefined;
  _id_3B42C59F79C3F077 = _id_C0EBB986EF34456D();
  hasarmor = _id_C284C09EF7780E64.health > _id_3B42C59F79C3F077;
  _id_ECA68F675AA4ABE5 = _id_C0EBB986EF34456D() + 150;
  _id_AE0F808555C671F9 = 0;
  armorbroke = 0;

  if(hasarmor) {
    _id_815F2CEE6F7F75CD = _id_C284C09EF7780E64.health - _id_3B42C59F79C3F077;
    _id_AE0F808555C671F9 = int(clamp(instance.damage, 0, _id_815F2CEE6F7F75CD));
    armorbroke = _id_815F2CEE6F7F75CD - _id_AE0F808555C671F9 == 0;
  }

  _id_4A101E7F1377C05D = _id_43702519A3DC0854(instance.meansofdeath) && _id_AE0F808555C671F9 >= 150;
  _id_520F3F243189CA25 = _id_AE24F0C0C8C6DE2A(instance.weapon);
  _id_84B2B2A1586DE527 = _id_C284C09EF7780E64.health >= _id_ECA68F675AA4ABE5;

  if(_id_4A101E7F1377C05D && _id_84B2B2A1586DE527) {
    if(instance.damage >= _id_C284C09EF7780E64.health && !istrue(_id_520F3F243189CA25))
      instance.damage = int(clamp(instance.damage, 0, _id_C284C09EF7780E64.health - 1));
  }

  _id_C284C09EF7780E64 dodamage(instance.damage, instance.origin, instance.attacker, instance.attacker, instance.meansofdeath, instance.weapon, instance.hitloc);
  level notify("damage_done");
  isheadshot = instance.hitloc == "head";
  _id_796F911F3D497AD6 = isDefined(instance.meansofdeath) && instance.meansofdeath == "MOD_FIRE" || instance.meansofdeath == "MOD_EXPLOSIVE";

  if(!_id_796F911F3D497AD6) {
    _id_A1566100E7DF492E = 1;
    _id_7D955100FAEA2A9B = 1;

    if(instance.attacker getcurrentweapon() == instance.attacker.primaryweaponobj) {
      level._id_91D278FB245D797B = min(level._id_91D278FB245D797B + 1, level._id_37A55ECAF979D920);
      _id_7D955100FAEA2A9B = level._id_91D278FB245D797B;
      _id_A1566100E7DF492E = level._id_37A55ECAF979D920;

      if(_id_42C8B6FF9ADFABFA()) {
        level._id_6BA74CCD0535DFAB++;
        _id_B8494E78AB9BC23E = max(1.0, level._id_B8494E78AB9BC23E);
        level._id_E89E680520310188 = clamp(level._id_6BA74CCD0535DFAB / _id_B8494E78AB9BC23E, 0.0, 1.0);
      }
    } else {
      level._id_EDCA0E3497F3463F = min(level._id_EDCA0E3497F3463F + 1, level._id_FEBC1F5F6FC40F70);
      _id_7D955100FAEA2A9B = level._id_EDCA0E3497F3463F;
      _id_A1566100E7DF492E = level._id_FEBC1F5F6FC40F70;
    }

    _id_A1566100E7DF492E = max(1.0, _id_A1566100E7DF492E);
    accuracy = clamp(_id_7D955100FAEA2A9B / _id_A1566100E7DF492E, 0.0, 1.0);
    setomnvar("ui_firing_range_accuracy", accuracy);
  }

  _id_A9ACAC74F8733EF9 = getdvarint("dvar_C0BF29E81B3A5EEC", 1);
  _id_E97D8200C5B56592 = getdvarint("dvar_D1EEDA3BC1BFB41B", 1);
  _id_DC382B1157307F94 = undefined;
  _id_F3D8C14A53E479F5 = getDvar("snd_hitmarker_alias");

  if(_id_A9ACAC74F8733EF9 || _id_E97D8200C5B56592) {
    if(armorbroke) {
      if(_id_A9ACAC74F8733EF9) {
        if(_id_C284C09EF7780E64.health + instance.damage >= _id_ECA68F675AA4ABE5)
          _id_DC382B1157307F94 = "hitarmormaxplatebreak";
        else
          _id_DC382B1157307F94 = "hitarmorlightbreak";
      }

      if(_id_E97D8200C5B56592)
        _id_F3D8C14A53E479F5 = "hit_marker_3d_armor_break";
    } else if(hasarmor) {
      if(_id_A9ACAC74F8733EF9) {
        if(_id_C284C09EF7780E64.health + instance.damage >= _id_ECA68F675AA4ABE5)
          _id_DC382B1157307F94 = "hitarmorlightmaxlevel";
        else
          _id_DC382B1157307F94 = "hitarmorlight";
      }
    }
  }

  if(_id_C284C09EF7780E64.health <= 0) {
    if(getdvarint("dvar_19CB7A793CE35F97", 0) == 0)
      _id_C284C09EF7780E64.owner _meth_934DD81D5E332BE8(_id_C284C09EF7780E64.owner._id_4940CA5C0CD5A797, _id_C284C09EF7780E64.owner._id_F83A9D5C8D6B9A96, instance.attacker, instance.weapon, 1);

    _id_EE27F3F198276535 = getomnvar("ui_firing_range_target_kill_count");

    if(_id_EE27F3F198276535 <= 500)
      setomnvar("ui_firing_range_target_kill_count", _id_EE27F3F198276535 + 1);

    if(_id_42C8B6FF9ADFABFA())
      level._id_A9A55BEB5763B7D5++;

    if(isheadshot)
      self playsoundtoplayer("mp_headshot_alert", instance.attacker);
    else
      self playsoundtoplayer("mp_kill_alert", instance.attacker);

    instance.attacker _id_5E9E768A83DA2AD4::_id_02A968DDF3C277CE("standard", 1, isheadshot, 0, _id_DC382B1157307F94);
    thread _id_76EC949F11311DA1(_id_C284C09EF7780E64);
    _id_642470E1ABC1BBF9 = spawnStruct();
    _id_642470E1ABC1BBF9.attacker = instance.attacker;
    _id_642470E1ABC1BBF9.objweapon = instance.weapon;
    _id_642470E1ABC1BBF9.meansofdeath = instance.meansofdeath;
    _id_642470E1ABC1BBF9.hitloc = instance.hitloc;
    self.body = self;
    _id_0CBB0697DE4C5728::_id_D7C5900C7D5BB0DB(_id_642470E1ABC1BBF9);
  } else {
    playsoundatpos(instance.origin, _id_F3D8C14A53E479F5);
    instance.attacker _id_5E9E768A83DA2AD4::_id_02A968DDF3C277CE("standard", 0, isheadshot, 0, _id_DC382B1157307F94);
  }
}

#using_animtree("script_model");

_id_76EC949F11311DA1(_id_C284C09EF7780E64) {
  level endon("exit_firing_range");

  if(istrue(self._id_9A74C6FBE0CF64EB)) {
    return;
  }
  self._id_9A74C6FBE0CF64EB = 1;
  _id_C284C09EF7780E64 setCanDamage(0);
  self _meth_ F807A01ED0CF8EB();
  self notsolid();
  self notify("entitydeleted");
  self scriptmodelplayanimdeltamotion("iw9_mp_firingrange_dummy_death");
  self playSound("uin_firingrange_target_fall");
  wait(getanimlength(%iw9_mp_firingrange_dummy_death));
  self scriptmodelplayanimdeltamotion("iw9_mp_firingrange_dummy_deathidle");
  wait 3.0;
  playsoundatpos(self.origin, "uin_firingrange_target_rise");
  self setscriptablepartstate("mtxDeath", "off", 0);
  thread _id_0242BC1E2941732E();
}

_id_0242BC1E2941732E() {
  if(!istrue(self._id_9A74C6FBE0CF64EB)) {
    return;
  }
  self scriptmodelplayanimdeltamotion("iw9_mp_firingrange_dummy_respawn");
  self._id_9A74C6FBE0CF64EB = 1;
  wait(getanimlength(%iw9_mp_firingrange_dummy_respawn));
  self scriptmodelclearanim();
  self._id_9A74C6FBE0CF64EB = 0;
  self solid();
  self enableaimassist();
  self._id_C284C09EF7780E64.health = _id_314B6888C85326DB();
  self._id_C284C09EF7780E64 setCanDamage(1);
  _id_0CBB0697DE4C5728::_id_C72573FB42D0CDBC();
}

_id_487345CE6A43A653() {
  self setCanDamage(1);
  self.owner enableaimassist();
  thread _id_64289D610B532582();

  for(;;)
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon);
}

_id_64289D610B532582() {
  for(;;) {
    color = scripts\engine\utility::ter_op(self.health > 0, (0, 1, 0), (1, 0, 0));
    waitframe();
  }
}

_id_B74A4C79011E5ADF(primary) {
  level notify("frontend_watch_bullets");
  level endon("exit_firing_range");
  level endon("frontend_watch_bullets");

  for(;;) {
    self waittill("weapon_fired", objweapon);
    _id_A1566100E7DF492E = 0;
    _id_66049A1B8433BBEE = 0;

    if(objweapon == primary) {
      level._id_37A55ECAF979D920++;
      _id_A1566100E7DF492E = level._id_37A55ECAF979D920;
      _id_66049A1B8433BBEE = level._id_91D278FB245D797B;

      if(_id_42C8B6FF9ADFABFA())
        level._id_B8494E78AB9BC23E++;
    } else {
      level._id_FEBC1F5F6FC40F70++;
      _id_A1566100E7DF492E = level._id_FEBC1F5F6FC40F70;
      _id_66049A1B8433BBEE = level._id_EDCA0E3497F3463F;
    }

    thread _id_AF1E66CD09D0FA6F(_id_66049A1B8433BBEE, _id_A1566100E7DF492E, objweapon == primary);
  }
}

_id_AF1E66CD09D0FA6F(_id_66049A1B8433BBEE, _id_A1566100E7DF492E, _id_918D83438649E9A5) {
  level notify("wait_for_bullet_result");
  level endon("exit_firing_range");
  level endon("wait_for_bullet_result");
  thread _id_A9FE4D5F2A3EFC22();
  level scripts\engine\utility::waittill_any_2("timeout_damage", "damage_done");

  if(_id_918D83438649E9A5 && _id_66049A1B8433BBEE == level._id_91D278FB245D797B || !_id_918D83438649E9A5 && _id_66049A1B8433BBEE == level._id_EDCA0E3497F3463F) {
    _id_A1566100E7DF492E = max(1.0, _id_A1566100E7DF492E);
    accuracy = clamp(_id_66049A1B8433BBEE / _id_A1566100E7DF492E, 0.0, 1.0);
    setomnvar("ui_firing_range_accuracy", accuracy);

    if(_id_918D83438649E9A5 && _id_42C8B6FF9ADFABFA()) {
      _id_B8494E78AB9BC23E = max(1.0, level._id_B8494E78AB9BC23E);
      level._id_E89E680520310188 = clamp(level._id_6BA74CCD0535DFAB / _id_B8494E78AB9BC23E, 0.0, 1.0);
    }
  }
}

_id_A9FE4D5F2A3EFC22() {
  level endon("damage_done");
  level endon("exit_firing_range");
  level endon("wait_for_bullet_result");
  wait 0.1;
  level notify("timeout_damage");
}

isspreadweapon(objweapon) {
  return isDefined(objweapon) && isDefined(weaponclass(objweapon)) && weaponclass(objweapon) == "spread";
}

setupdamageflags() {
  level.idflags_radius = 1;
  level.idflags_no_armor = 2;
  level.idflags_no_knockback = 4;
  level.idflags_penetration = 8;
  level.idflags_stun = 16;
  level.idflags_shield_explosive_impact = 32;
  level.idflags_shield_explosive_impact_huge = 64;
  level.idflags_shield_explosive_splash = 128;
  level.idflags_ricochet = 256;
  level.idflags_br_armor_hit = 512;
  level.idflags_br_armor_break = 1024;
  level.idflags_source_left_hand = 2048;
  level.idflags_no_dismemberment = 4096;
  level.idflags_hyper_burst_round = 8192;
  level.idflags_penetration_player_only = 16384;
  level._id_81A140202A2F4D30 = 32768;
  level.idflags_no_team_protection = 65536;
  level.idflags_no_protection = 131072;
  level.idflags_passthru = 262144;
}

spreadshotdamagemod(victim, eattacker, objweapon, idamage, idflags) {
  if(isDefined(eattacker) && isDefined(victim)) {
    _id_A9F996CAF54DD68C = _id_88E9E2299BD29FD1(idflags);
    _id_BDA9C6703DCFCC16 = _id_D77E6B2580F74622(victim);
    time = gettime();

    if(!isDefined(eattacker.pelletweaponvictimids))
      eattacker.pelletweaponvictimids = [];

    foreach(_id_AD11AA18430D8799, _id_25762EF6BB7CED23 in eattacker.pelletweaponvictimids) {
      foreach(_id_48B7B944A7A02B2C, _id_3A99D1CAFE4A4BAC in _id_25762EF6BB7CED23) {
        if((time - _id_3A99D1CAFE4A4BAC.time) / 1000 > 0.1) {
          eattacker.pelletweaponvictimids[_id_AD11AA18430D8799] = scripts\engine\utility::array_remove_key(eattacker.pelletweaponvictimids[_id_AD11AA18430D8799], _id_48B7B944A7A02B2C);

          if(eattacker.pelletweaponvictimids[_id_AD11AA18430D8799].size == 0)
            eattacker.pelletweaponvictimids = scripts\engine\utility::array_remove_key(eattacker.pelletweaponvictimids, _id_AD11AA18430D8799);
        }
      }
    }

    if(!isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C]))
      eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C] = [];

    if(!isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]))
      eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16] = _id_C415D83582AAD1E4(eattacker, objweapon, time);

    eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_7981F7D372990A2B = 0;
    eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed = scripts\engine\utility::array_sort_with_func(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed, ::is_lower);

    if(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed.size >= eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_33AC4C9665BE6910) {
      if(idamage > eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed[0]) {
        _id_85D9D85F3AD5012A = idamage - eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed[0];
        eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed[0] = idamage;
        eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_7981F7D372990A2B = 1;
        idamage = _id_85D9D85F3AD5012A;
      } else
        return 0;
    } else
      eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed = scripts\engine\utility::array_insert(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed, idamage, 0);

    idamage = _id_1113FC99A0327D7D(eattacker, victim, idflags, idamage);
  }

  return idamage;
}

_id_88E9E2299BD29FD1(idflags) {
  if(idflags &level.idflags_source_left_hand)
    return "lHandWeap";
  else
    return "rHandWeap";
}

_id_D77E6B2580F74622(victim) {
  return "" + victim getentitynumber();
}

_id_C415D83582AAD1E4(eattacker, objweapon, time) {
  struct = spawnStruct();
  struct.time = time;
  struct.pelletdmgpassed = [];
  struct._id_9BB59738D095536E = 0;
  struct._id_33AC4C9665BE6910 = getspreadpelletspershot(eattacker, objweapon);

  if(_id_A062727999A72D2F(objweapon.basename))
    struct._id_52F16F4C9CDBF165 = 120;
  else
    struct._id_52F16F4C9CDBF165 = 200;

  return struct;
}

_id_A062727999A72D2F(weaponname) {
  _id_F8C0529126C5FB04 = ["iw9_sh_mike1014_mp", "iw9_sh_vecho_mp", "iw9_pi_swhiskey_mp"];

  foreach(_id_AC0E594AC96AA3A8 in _id_F8C0529126C5FB04) {
    if(_id_AC0E594AC96AA3A8 == weaponname)
      return 1;
  }

  return 0;
}

_id_1113FC99A0327D7D(eattacker, victim, idflags, idamage) {
  _id_A9F996CAF54DD68C = _id_88E9E2299BD29FD1(idflags);
  _id_BDA9C6703DCFCC16 = _id_D77E6B2580F74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C]) || !isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]))
    return idamage;

  _id_52F16F4C9CDBF165 = eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_52F16F4C9CDBF165;
  _id_9BB59738D095536E = eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E;

  if(_id_9BB59738D095536E < _id_52F16F4C9CDBF165) {
    idamage = clamp(idamage, 0, _id_52F16F4C9CDBF165 - eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E);
    eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E = eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E + idamage;
    return idamage;
  } else
    return 0;
}

is_lower(a, b) {
  return a < b;
}

getspreadpelletspershot(eattacker, objweapon) {
  _id_AB501F397D3CD312 = getweaponrootname(objweapon.basename);

  if(_id_AB501F397D3CD312 == "iw9_sh_charlie725" || _id_AB501F397D3CD312 == "iw9_pi_swhiskey") {
    if(eattacker isdualwielding())
      return 2;

    if(objweapon hasattachment("bar_sh_short_p14"))
      return 3;

    _id_8B953A03A24F231D = eattacker playerads() > 0.5;

    if(_id_8B953A03A24F231D) {
      return 4;
      return;
    }

    return 3;
    return;
  } else
    return 4;
}

getweaponrootname(weapon) {
  if(!isDefined(level.weaponrootcache))
    level.weaponrootcache = [];

  weaponname = undefined;

  if(isweapon(weapon))
    weaponname = weapon.basename;
  else
    weaponname = weapon;

  _id_93AB397A467E3DD4 = level.weaponrootcache[weaponname];

  if(isDefined(_id_93AB397A467E3DD4))
    return _id_93AB397A467E3DD4;

  _id_7E8CE070B59848FD = weaponname;
  _id_67F14F8315CB0F2F = strtok(weaponname, "_");
  index = 0;

  if(_id_67F14F8315CB0F2F[0] == "alt")
    index++;

  if(_id_67F14F8315CB0F2F[index] == "iw8" || _id_67F14F8315CB0F2F[index] == "iw9" || _id_67F14F8315CB0F2F[index] == "t10" || _id_67F14F8315CB0F2F[index] == "jup") {
    _id_C0BB28E7846054F1 = ["ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "br"];

    if(isDefined(_id_67F14F8315CB0F2F[index + 1]) && scripts\engine\utility::array_contains(_id_C0BB28E7846054F1, _id_67F14F8315CB0F2F[index + 1])) {
      if(_id_67F14F8315CB0F2F.size >= index + 4 && _id_67F14F8315CB0F2F[index] == "t10" || _id_67F14F8315CB0F2F[index] == "jup")
        weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1] + "_" + _id_67F14F8315CB0F2F[index + 2] + "_" + _id_67F14F8315CB0F2F[index + 3];
      else
        weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1] + "_" + _id_67F14F8315CB0F2F[index + 2];
    } else
      weaponname = _id_67F14F8315CB0F2F[index] + "_" + _id_67F14F8315CB0F2F[index + 1];
  }

  if(level.weaponrootcache.size < 100)
    level.weaponrootcache[_id_7E8CE070B59848FD] = weaponname;

  return weaponname;
}

_id_43702519A3DC0854(smeansofdeath) {
  if(!isDefined(smeansofdeath))
    return 0;

  if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET")
    return 1;

  return 0;
}

_id_AE24F0C0C8C6DE2A(objweapon) {
  weapontype = weaponclass(objweapon);

  if(weapontype == "sniper" && objweapon.basename != "iw9_sn_limax_mp" && _func_F30A6D3194F97C09(objweapon, "specialty_explosivebullet"))
    return 1;

  if(objweapon.basename == "iw9_dm_crossbow_mp")
    return 1;

  return 0;
}