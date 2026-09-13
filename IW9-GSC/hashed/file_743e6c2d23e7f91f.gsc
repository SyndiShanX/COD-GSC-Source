/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_743e6c2d23e7f91f.gsc
***********************************************/

_id_906E0BECC84C065B(pos, _id_E0C08758EB0006BE, vehicle, model, patrolradius, name) {
  spawndata = spawnStruct();
  spawndata.origin = pos;
  spawndata.angles = (0, 0, 0);
  spawndata.spawntype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.owner = undefined;
  spawndata.team = "team_hundred_ninety_five";
  spawndata.modelname = "veh9_mil_lnd_whotel_v2_composite_mp";
  spawndata.vehicletype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.targetname = "remote_tank";
  spawndata.cancapture = 0;
  spawndata.cancaptureimmediately = 0;
  spawndata.activateimmediately = 1;
  _id_F5E7C5E12051B3EB = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata);
  _id_2884ADC8D320F897 = _id_48814951E916AF89::_id_AF3034A7C69D7EDB(_id_371B4C2AB5861E62::_id_30A0D7CA3FAE40CC("merc"));
  _id_F5E7C5E12051B3EB.owner = _id_2884ADC8D320F897;
  _id_F5E7C5E12051B3EB scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", spawndata.team);
  _id_F5E7C5E12051B3EB.team = "team_hundred_ninety_five";
  _id_F5E7C5E12051B3EB.tanktype = "remote_tank";
  _id_F5E7C5E12051B3EB.maxhealth = 6000;
  _id_F5E7C5E12051B3EB.health = 6000;
  _id_F5E7C5E12051B3EB.currenthealth = 6000;
  _id_F5E7C5E12051B3EB.pathstruct = _id_E0C08758EB0006BE;
  _id_F5E7C5E12051B3EB._id_E0C08758EB0006BE = _id_E0C08758EB0006BE;
  _id_F5E7C5E12051B3EB.vehiclename = "pac_sentry";
  _id_F5E7C5E12051B3EB.spinuptime = 1;
  _id_F5E7C5E12051B3EB laseron();
  _id_F5E7C5E12051B3EB _meth_D2E41C7603BA7697("p2p");
  _id_F5E7C5E12051B3EB _meth_77320E794D35465A("p2p", "reverseGasNormal", 1.5);
  _id_F5E7C5E12051B3EB _meth_77320E794D35465A("p2p", "steeringMultiplier", 15);
  _id_F5E7C5E12051B3EB _meth_77320E794D35465A("p2p", "manualSpeed", 10);
  _id_F5E7C5E12051B3EB _meth_77320E794D35465A("p2p", "reverseForBehindGoal", 1);
  _id_F5E7C5E12051B3EB _meth_77320E794D35465A("p2p", "stuckTime", 4);
  _id_F5E7C5E12051B3EB _meth_77320E794D35465A("p2p", "goalThreshold", 10);
  _id_F5E7C5E12051B3EB scripts\cp_mp\emp_debuff::set_start_emp_callback(::_id_90FBF0CED62BC14A);
  _id_F5E7C5E12051B3EB scripts\cp_mp\emp_debuff::set_clear_emp_callback(::_id_E0C83A146741815F);
  _id_F5E7C5E12051B3EB._id_8FFA366EC68F0C8B = 10000;
  _id_F5E7C5E12051B3EB scripts\mp\killstreaks\remotetank::_id_89445073F3E86E5C(_id_F5E7C5E12051B3EB.vehiclename);
  _id_45C8EBE59275B96E(_id_F5E7C5E12051B3EB.vehiclename);
  playFXOnTag(scripts\engine\utility::getfx("vfx_dmz_Wheelson_flashlight"), _id_F5E7C5E12051B3EB, "tag_flash");
  _id_F5E7C5E12051B3EB.currentstate = "patrol";
  _id_F5E7C5E12051B3EB vehicleshowonminimap(0);
  _id_F5E7C5E12051B3EB.damagecallback = ::_id_96B758D589365EF6;
  _id_F5E7C5E12051B3EB thread _id_A51EAFFDB54130B2(_id_E0C08758EB0006BE);
  _id_F5E7C5E12051B3EB thread _id_042BC36AF24A342E();
  _id_F5E7C5E12051B3EB thread _id_93DCCF3096384DA0();
  _id_F5E7C5E12051B3EB.damagestate = 0;
  _id_F5E7C5E12051B3EB._id_1329597B4278AFE9 = [];
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(_id_F5E7C5E12051B3EB, _id_F5E7C5E12051B3EB.owner, _id_F5E7C5E12051B3EB.owner.team);
  return _id_F5E7C5E12051B3EB;
}

_id_45C8EBE59275B96E(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 18;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 25;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 7;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 8;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "c4_mp";
  weaponhitsperattack = 5;
  _id_8B4500D6A881B7B2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "at_mine_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);

  weaponname = "thermite_mp";
  weaponhitsperattack = 1;
  _id_8B4500D6A881B7B2 = 50;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, _id_8B4500D6A881B7B2, streakname);
}

_id_45D2E44C40437351(startnode, _id_10592AC32D1E5A3D, _id_CFFDAA458D12AB7D) {
  pathstruct = spawnStruct();
  pathstruct.path = [startnode];
  pathstruct._id_7D8884F5400E2FCA = [];
  pathstruct.speed = 10;
  pathstruct.direction = 1;
  pathstruct.index = 0;
  _id_C80EAEAC6487D3B9 = startnode;

  while(isDefined(_id_C80EAEAC6487D3B9.target)) {
    _id_9A6BA9F5A0E705C7 = pathstruct.path.size - 1;
    pathstruct._id_7D8884F5400E2FCA[_id_9A6BA9F5A0E705C7] = [];
    _id_A942AE9112CD6BDE = scripts\engine\utility::getStructArray(_id_C80EAEAC6487D3B9.target, "targetname");

    foreach(node in _id_A942AE9112CD6BDE) {
      if(node.script_noteworthy == _id_10592AC32D1E5A3D) {
        _id_C80EAEAC6487D3B9 = node;
        pathstruct.path[pathstruct.path.size] = node;
        continue;
      }

      if(node.script_noteworthy == _id_CFFDAA458D12AB7D)
        pathstruct._id_7D8884F5400E2FCA[_id_9A6BA9F5A0E705C7][pathstruct._id_7D8884F5400E2FCA[_id_9A6BA9F5A0E705C7].size] = _id_49B628EC7B6247BD(node, _id_CFFDAA458D12AB7D);
    }
  }

  return pathstruct;
}

_id_49B628EC7B6247BD(startnode, _id_608B5DF3A17E09D3) {
  pathstruct = spawnStruct();
  pathstruct.path = [startnode];
  pathstruct.speed = 10;
  pathstruct.direction = 1;
  pathstruct.index = 0;

  for(_id_C80EAEAC6487D3B9 = startnode; isDefined(_id_C80EAEAC6487D3B9.target); pathstruct.path[pathstruct.path.size] = _id_C80EAEAC6487D3B9)
    _id_C80EAEAC6487D3B9 = scripts\engine\utility::getStructArray(_id_C80EAEAC6487D3B9.target, "targetname")[0];

  return pathstruct;
}

_id_A51EAFFDB54130B2(pathstruct) {
  if(isDefined(pathstruct.path) && pathstruct.path.size > 0) {
    self._id_13CCB567671DEB18 = undefined;
    thread _id_4BAC13D511590220::_id_C3889ABF5CD6ABBF(pathstruct, pathstruct.speed, undefined, "soldier");
  }
}

_id_B0BCD78019FA3F75() {
  if(isDefined(self._id_13CCB567671DEB18)) {
    _id_59F1425515D37E2A = _id_BB51D7FA820F19AE(0, self._id_46496C542D347BA8, self._id_13CCB567671DEB18);
    _id_4BAC13D511590220::_id_AA85EB39828A4D80(_id_59F1425515D37E2A, 10, 1, 1);
    self._id_F0F726ADAFB8C51A = undefined;
    self._id_13CCB567671DEB18 = undefined;
    self._id_46496C542D347BA8 = undefined;
  }

  thread _id_4BAC13D511590220::_id_C3889ABF5CD6ABBF(self._id_E0C08758EB0006BE, self._id_E0C08758EB0006BE.speed, undefined, "soldier");
}

_id_042BC36AF24A342E() {
  self endon("death");
  thread _id_02325F7CC87D0684();

  for(;;) {
    while(istrue(self.emp))
      wait 0.2;

    _id_1E79B4675C5AA7F9 = undefined;
    _id_84D4866087B00608 = undefined;
    _id_7408ED52662703D3 = scripts\common\utility::playersinsphere(self.origin, 2048);

    foreach(target in _id_7408ED52662703D3) {
      if(!_id_79E58F587EFE9E1F(target)) {
        continue;
      }
      _id_7F96D62F3ABBF9B9 = target.origin - self.origin;
      _id_922C3BF422E322F5 = vectordot(anglesToForward(self gettagangles("tag_flash")), _id_7F96D62F3ABBF9B9);

      if(_id_922C3BF422E322F5 < 90) {
        continue;
      }
      distsq = distancesquared(target.origin, self.origin);

      if(!isDefined(_id_1E79B4675C5AA7F9) || distsq < _id_84D4866087B00608) {
        _id_1E79B4675C5AA7F9 = target;
        _id_84D4866087B00608 = distsq;
      }
    }

    if(isDefined(self._id_8E7D46146A9CF2EB))
      _id_1E79B4675C5AA7F9 = self._id_8E7D46146A9CF2EB;

    if(isDefined(_id_1E79B4675C5AA7F9)) {
      _id_0A3955F7116F3753();
      _id_F3C822808E8CC579(_id_1E79B4675C5AA7F9);
      thread _id_02325F7CC87D0684();
      self._id_8E7D46146A9CF2EB = undefined;
    }

    wait 0.1;
  }
}

_id_02325F7CC87D0684() {
  self endon("death");
  self endon("dmz_ai_vehicle_enterCombatState");
  self.currentstate = "patrol";
  _id_FBDAD214EE6C3307 = 0;
  direction = 1;

  for(;;) {
    if(istrue(self.emp)) {
      _id_0DB78384599E4B42 = anglesToForward(self gettagangles("tag_flash"));
      self setturrettargetvec(_id_0DB78384599E4B42 * 500 + (0, -800, 0));
    }

    while(istrue(self.emp))
      wait 0.2;

    _id_FBDAD214EE6C3307 = _id_FBDAD214EE6C3307 + 90 * direction;

    if(_id_FBDAD214EE6C3307 >= 360 || _id_FBDAD214EE6C3307 <= 0)
      direction = direction * -1;

    targetangles = (0, _id_FBDAD214EE6C3307, 0);
    _id_C0686995758526DE = anglesToForward(targetangles);
    start = self.origin + (0, 0, 16);
    end = start + 6000.0 * _id_C0686995758526DE;
    self setturrettargetvec(end);
    scripts\engine\utility::waittill_any_timeout_1(2.0, "turret_on_target");
  }
}

_id_0A3955F7116F3753() {
  self._id_3258BE7F1D1B7C7A = self.origin;
  self notify("newFollowPath");
  self notify("dmz_ai_vehicle_enterCombatState");
}

_id_F3C822808E8CC579(target) {
  self endon("death");
  self endon("enter_patrol");
  self endon("target_lost");
  self._id_C6DFDD9743149226 = target;
  childthread _id_66EF3BD97CE18687();
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];

  for(;;) {
    _id_5768D16C6697B59E = undefined;

    if(istrue(target.hasriotshieldequipped))
      _id_5768D16C6697B59E = target;

    if(!_id_79E58F587EFE9E1F(target) || istrue(target.hasriotshieldequipped) || isDefined(self._id_8E7D46146A9CF2EB) && self._id_8E7D46146A9CF2EB != target) {
      if(isDefined(self._id_8E7D46146A9CF2EB) && self._id_8E7D46146A9CF2EB != target)
        target = self._id_8E7D46146A9CF2EB;
      else {
        _id_7408ED52662703D3 = scripts\common\utility::playersinsphere(self.origin, 2048);
        _id_7408ED52662703D3 = sortbydistance(_id_7408ED52662703D3, self.origin);

        foreach(_id_331304DB73694587 in _id_7408ED52662703D3) {
          if(!_id_79E58F587EFE9E1F(_id_331304DB73694587)) {
            continue;
          }
          if(istrue(_id_331304DB73694587.hasriotshieldequipped) && !isDefined(_id_5768D16C6697B59E)) {
            _id_5768D16C6697B59E = _id_331304DB73694587;
            continue;
          }

          target = _id_331304DB73694587;
          break;
        }
      }

      if(!_id_79E58F587EFE9E1F(target) && isDefined(_id_5768D16C6697B59E))
        target = _id_5768D16C6697B59E;
    }

    self.currentstate = "attack";
    _id_1457A29DDB8B55DC(target, _id_A84CFD847DC1F677);
    _id_55F73871378D7CEA();
    wait 0.2;
  }
}

_id_6A5482361557E17B(_id_A84CFD847DC1F677) {
  self endon("death");
  spinuptime = self.spinuptime;
  thread scripts\cp_mp\killstreaks\sentry_gun::sentry_targetlocksound();
  self _meth_EE85446AFC7CB0A8(1);
  self._id_4863A1B39F3E20F5 = 1;

  while(spinuptime > 0) {
    spinuptime = spinuptime - 0.05;
    wait 0.05;
  }
}

_id_55F73871378D7CEA() {
  if(istrue(self._id_4863A1B39F3E20F5)) {
    spinuptime = self.spinuptime;
    self _meth_EE85446AFC7CB0A8(0);
    self._id_4863A1B39F3E20F5 = undefined;

    while(spinuptime > 0) {
      spinuptime = spinuptime - 0.05;
      wait 0.05;
    }
  }
}

_id_66EF3BD97CE18687() {
  _id_BCF69F5A7053FAB1 = 0;
  maxfails = 4;

  if(isDefined(self._id_D04BB72230A5A308))
    maxfails = self._id_D04BB72230A5A308;

  for(;;) {
    if(!isDefined(self._id_C6DFDD9743149226)) {
      self notify("target_lost");
      return;
    }

    if(_id_79E58F587EFE9E1F(self._id_C6DFDD9743149226)) {
      _id_BCF69F5A7053FAB1 = 0;
      wait 0.5;
      continue;
    }

    if(_id_A1618F0C0BC81103(self._id_C6DFDD9743149226)) {
      _id_BCF69F5A7053FAB1 = 0;
      waitframe();
      continue;
    }

    _id_BCF69F5A7053FAB1 = _id_BCF69F5A7053FAB1 + 1;

    if(_id_BCF69F5A7053FAB1 > maxfails) {
      thread _id_B0BCD78019FA3F75();
      self notify("target_lost");
    }

    wait 1;
  }
}

_id_79E58F587EFE9E1F(target) {
  if(!isDefined(target))
    return 0;

  if(isPlayer(target)) {
    if(isDefined(self._id_1329597B4278AFE9) && scripts\engine\utility::array_contains(self._id_1329597B4278AFE9, target.team))
      return 0;

    if(!target scripts\cp_mp\utility\player_utility::_isalive() || target.sessionstate != "playing")
      return 0;

    if(scripts\mp\utility\player::isinlaststand(target))
      return 0;

    if(istrue(target.notarget))
      return 0;

    if(target == self.owner)
      return 0;

    return self vehicle_canturrettargetpoint(target gettagorigin("j_mainroot"), 1, self);
  }
}

_id_A1618F0C0BC81103(target) {
  _id_A0EEC69077D8135E = undefined;
  _id_C80EAEAC6487D3B9 = self._id_E0C08758EB0006BE.path[self._id_E0C08758EB0006BE.index];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
    _id_973024EE97DE3062 = self._id_E0C08758EB0006BE.index + _id_AC0E594AC96AA3A8;
    _id_973024EE97DE3062 = scripts\engine\utility::ter_op(_id_973024EE97DE3062 >= self._id_E0C08758EB0006BE.path.size, _id_973024EE97DE3062 - self._id_E0C08758EB0006BE.path.size, _id_973024EE97DE3062);

    if(_id_3E8010501DE305FA(self._id_E0C08758EB0006BE.path[_id_973024EE97DE3062], target)) {
      _id_A0EEC69077D8135E = _id_B4908DC2CBEC66A6(_id_973024EE97DE3062, 1);
      self._id_F0F726ADAFB8C51A = undefined;
      self._id_13CCB567671DEB18 = undefined;
      self._id_46496C542D347BA8 = undefined;
      self._id_E0C08758EB0006BE.index = _id_973024EE97DE3062;
      _id_4BAC13D511590220::_id_AA85EB39828A4D80(_id_A0EEC69077D8135E.path, _id_A0EEC69077D8135E.speed, 1, 1);
      return 1;
    }

    if(isDefined(self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[_id_973024EE97DE3062]) && self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[_id_973024EE97DE3062].size > 0) {
      foreach(parentindex, _id_D9B3E4B68CC48819 in self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[_id_973024EE97DE3062]) {
        foreach(index, node in _id_D9B3E4B68CC48819.path) {
          if(_id_3E8010501DE305FA(node, target)) {
            if(_id_AC0E594AC96AA3A8 != 0) {
              _id_A0EEC69077D8135E = _id_B4908DC2CBEC66A6(_id_973024EE97DE3062, 1, index, parentindex);
              self._id_F0F726ADAFB8C51A = index;
              self._id_13CCB567671DEB18 = parentindex;
              self._id_46496C542D347BA8 = _id_973024EE97DE3062;
              self._id_E0C08758EB0006BE.index = _id_973024EE97DE3062;
              _id_4BAC13D511590220::_id_AA85EB39828A4D80(_id_A0EEC69077D8135E.path, _id_A0EEC69077D8135E.speed, 1, 1);
            } else {
              _id_59F1425515D37E2A = _id_BB51D7FA820F19AE(index, _id_973024EE97DE3062, parentindex);
              self._id_F0F726ADAFB8C51A = index;
              self._id_13CCB567671DEB18 = parentindex;
              self._id_46496C542D347BA8 = _id_973024EE97DE3062;
              self._id_E0C08758EB0006BE.index = _id_973024EE97DE3062;
              _id_4BAC13D511590220::_id_AA85EB39828A4D80(_id_59F1425515D37E2A, 10, 1, 1);
            }

            return 1;
          }
        }
      }
    }

    if(_id_AC0E594AC96AA3A8 == 0) {
      continue;
    }
    _id_710537D2607C471F = self._id_E0C08758EB0006BE.index - _id_AC0E594AC96AA3A8;
    _id_710537D2607C471F = scripts\engine\utility::ter_op(_id_710537D2607C471F < 0, _id_710537D2607C471F + self._id_E0C08758EB0006BE.path.size, _id_710537D2607C471F);

    if(_id_3E8010501DE305FA(self._id_E0C08758EB0006BE.path[_id_710537D2607C471F], target)) {
      _id_A0EEC69077D8135E = _id_B4908DC2CBEC66A6(_id_710537D2607C471F, 0);
      self._id_F0F726ADAFB8C51A = undefined;
      self._id_13CCB567671DEB18 = undefined;
      self._id_46496C542D347BA8 = undefined;
      self._id_E0C08758EB0006BE.index = _id_710537D2607C471F;
      _id_4BAC13D511590220::_id_AA85EB39828A4D80(_id_A0EEC69077D8135E.path, _id_A0EEC69077D8135E.speed, 1, 1);
      return 1;
    }

    if(isDefined(self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[_id_710537D2607C471F]) && self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[_id_710537D2607C471F].size > 0) {
      foreach(parentindex, _id_D9B3E4B68CC48819 in self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[_id_710537D2607C471F]) {
        foreach(index, node in _id_D9B3E4B68CC48819.path) {
          if(_id_3E8010501DE305FA(node, target)) {
            _id_A0EEC69077D8135E = _id_B4908DC2CBEC66A6(_id_710537D2607C471F, 1, index, parentindex);
            self._id_F0F726ADAFB8C51A = index;
            self._id_13CCB567671DEB18 = parentindex;
            self._id_46496C542D347BA8 = _id_710537D2607C471F;
            self._id_E0C08758EB0006BE.index = _id_710537D2607C471F;
            _id_4BAC13D511590220::_id_AA85EB39828A4D80(_id_A0EEC69077D8135E.path, _id_A0EEC69077D8135E.speed, 1, 1);
            return 1;
          }
        }
      }
    }
  }

  return 0;
}

_id_D0CD695CD85915AD(_id_A0EEC69077D8135E) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A0EEC69077D8135E.size - 1; _id_AC0E594AC96AA3A8++)
    scripts\engine\utility::draw_arrow_time(_id_A0EEC69077D8135E[_id_AC0E594AC96AA3A8], _id_A0EEC69077D8135E[_id_AC0E594AC96AA3A8 + 1], (255, 0, 0), 10);
}

_id_B4908DC2CBEC66A6(index, forward, _id_4A72697044D23367, _id_AD1E1E856375B447) {
  pathstruct = spawnStruct();
  pathstruct.path = _id_BB51D7FA820F19AE(0, self._id_46496C542D347BA8, self._id_13CCB567671DEB18);
  pathstruct.speed = 10;
  pathstruct.index = 0;
  _id_9A6BA9F5A0E705C7 = self._id_E0C08758EB0006BE.index;

  if(istrue(forward)) {
    while(index >= _id_9A6BA9F5A0E705C7) {
      pathstruct.path[pathstruct.path.size] = self._id_E0C08758EB0006BE.path[_id_9A6BA9F5A0E705C7].origin;
      _id_9A6BA9F5A0E705C7 = _id_9A6BA9F5A0E705C7 + 1;
    }
  } else {
    for(_id_9A6BA9F5A0E705C7 = _id_9A6BA9F5A0E705C7 - 1; _id_9A6BA9F5A0E705C7 >= index; _id_9A6BA9F5A0E705C7 = _id_9A6BA9F5A0E705C7 - 1)
      pathstruct.path[pathstruct.path.size] = self._id_E0C08758EB0006BE.path[_id_9A6BA9F5A0E705C7].origin;
  }

  if(isDefined(_id_AD1E1E856375B447)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4A72697044D23367; _id_AC0E594AC96AA3A8++)
      pathstruct.path[pathstruct.path.size] = self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[index][_id_AD1E1E856375B447].path[_id_AC0E594AC96AA3A8].origin;
  }

  return pathstruct;
}

_id_BB51D7FA820F19AE(index, parentindex, _id_AD1E1E856375B447) {
  _id_A0EEC69077D8135E = [];

  if(isDefined(self._id_13CCB567671DEB18)) {
    if(_id_AD1E1E856375B447 == self._id_13CCB567671DEB18) {
      direction = scripts\engine\utility::ter_op(self._id_F0F726ADAFB8C51A > index, -1, 1);

      for(_id_AC0E594AC96AA3A8 = self._id_F0F726ADAFB8C51A; _id_AC0E594AC96AA3A8 != index + direction; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + direction)
        _id_A0EEC69077D8135E[_id_A0EEC69077D8135E.size] = self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[parentindex][_id_AD1E1E856375B447].path[_id_AC0E594AC96AA3A8].origin;
    } else {
      for(_id_AC0E594AC96AA3A8 = self._id_F0F726ADAFB8C51A; _id_AC0E594AC96AA3A8 >= 0; _id_AC0E594AC96AA3A8--)
        _id_A0EEC69077D8135E[_id_A0EEC69077D8135E.size] = self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[parentindex][self._id_13CCB567671DEB18].path[_id_AC0E594AC96AA3A8].origin;

      _id_A0EEC69077D8135E[_id_A0EEC69077D8135E.size] = self._id_E0C08758EB0006BE.path[self._id_E0C08758EB0006BE.index].origin;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < index; _id_AC0E594AC96AA3A8++)
        _id_A0EEC69077D8135E[_id_A0EEC69077D8135E.size] = self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[parentindex][_id_AD1E1E856375B447].path[_id_AC0E594AC96AA3A8].origin;
    }
  } else if(isDefined(parentindex) && isDefined(_id_AD1E1E856375B447))
    _id_A0EEC69077D8135E[_id_A0EEC69077D8135E.size] = self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA[parentindex][_id_AD1E1E856375B447].path[0].origin;

  return _id_A0EEC69077D8135E;
}

_id_3E8010501DE305FA(node, target) {
  _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1);
  canseetarget = scripts\engine\trace::ray_trace_passed(target.origin, node.origin + (0, 0, 50), [self], _id_C3FBB6661B91750F);
  return canseetarget;
}

_id_1457A29DDB8B55DC(target, _id_A5218803B3C3BE55) {
  self endon("death");
  self endon("enter_patrol");
  self endon("target_lost");
  firetime = weaponfiretime(_id_A5218803B3C3BE55.weaponinfo);
  _id_3746EC1BEFD86AE8 = 50;
  _id_3E92CD336A99CE02 = 65;
  _id_5F622C39D6661B23 = _id_A5218803B3C3BE55.pausemin;
  _id_42AE243CD994C3BD = _id_A5218803B3C3BE55.pausemax;
  _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);

  if(!_id_79E58F587EFE9E1F(target)) {
    return;
  }
  self setturrettargetEnt(target, target gettagorigin("j_mainroot") - target.origin);
  _id_A84CFD847DC1F677 = level.tanksettings[self.tanktype];

  if(!istrue(self._id_4863A1B39F3E20F5))
    _id_6A5482361557E17B();

  while(_id_79E58F587EFE9E1F(target) && !_id_05323B44EE395058::_id_BB61346FDA4278E5(self, target, "j_mainroot", 5))
    waitframe();

  _id_0BB0ADDA1F09BC49 = 0;

  while(_id_89F949A75D92E1A4 > 0) {
    if(!isDefined(target) || !isDefined(target.origin)) {
      return;
    }
    if(isDefined(self._id_C02EEA4B304A5921) && _id_79E58F587EFE9E1F(target)) {
      _id_0BB0ADDA1F09BC49 = 0;
      self._id_C02EEA4B304A5921 = undefined;
      self setturrettargetEnt(target, target gettagorigin("j_mainroot") - target.origin);
    } else if(!isDefined(self._id_C02EEA4B304A5921) && !_id_79E58F587EFE9E1F(target)) {
      _id_0BB0ADDA1F09BC49 = _id_0BB0ADDA1F09BC49 + 1;
      self._id_C02EEA4B304A5921 = target gettagorigin("j_mainroot");
      self setturrettargetvec(self._id_C02EEA4B304A5921);

      if(isDefined(self._id_7CFE1B189BCF3CAD) && _id_0BB0ADDA1F09BC49 > self._id_7CFE1B189BCF3CAD)
        return;
    }

    self fireweapon();
    _id_89F949A75D92E1A4--;
    wait(firetime);
  }
}

_id_90FBF0CED62BC14A(data) {
  scripts\mp\killstreaks\remotetank::_id_DB443C859C55E450(1);
  _id_55F73871378D7CEA();
  self.emp = 1;
  self notify("target_lost");

  if(isDefined(self._id_F973D23CB4CFC1A7))
    self[[self._id_F973D23CB4CFC1A7]]();
}

_id_E0C83A146741815F(_id_B3990D56E2779F79) {
  scripts\mp\killstreaks\remotetank::_id_DB443C859C55E450(0);
  self.emp = 0;
  _id_B0BCD78019FA3F75();

  if(isDefined(self._id_5B07EF3C411C7013))
    self[[self._id_5B07EF3C411C7013]]();
}

_id_AA6F0C2C4F3559C0(_id_2F58E7950B321302) {
  self endon("death");
  self notify("dmz_ai_vehicle_check_stuck");
  self endon("dmz_ai_vehicle_check_stuck");
  _id_547FE4C1DD5E2C2A = self.origin;
  _id_3F46A394E6CF82DE = 0;

  for(;;) {
    wait 1;

    if(istrue(self._id_DF9D4533B4C32B50) || istrue(self._id_12BFB031C0A0EFD8)) {
      wait 0.25;
      continue;
    }

    _id_6E3257DCBA2C4998 = self.origin;

    if(distancesquared(_id_6E3257DCBA2C4998, _id_547FE4C1DD5E2C2A) < 100) {
      _id_3F46A394E6CF82DE = _id_3F46A394E6CF82DE + 1;

      if(_id_3F46A394E6CF82DE > 3) {
        _id_3F46A394E6CF82DE = 0;
        _id_602B08F8DDAB1906();
      }
    }

    _id_547FE4C1DD5E2C2A = _id_6E3257DCBA2C4998;
  }
}

_id_602B08F8DDAB1906() {
  self notify("target_lost");
  _id_4BAC13D511590220::_id_AA85EB39828A4D80([self._id_2F63CC785DACC8A3], 10, 1, 1);
  _id_636C8575D7A7768B = 100000000;
  _id_306CB412722A32D9 = undefined;
  _id_8F51101F14C01979 = undefined;
  _id_D6A24DD68967019E = undefined;

  foreach(index, node in self._id_E0C08758EB0006BE.path) {
    dist = distancesquared(node.origin, self.origin);

    if(dist < _id_636C8575D7A7768B) {
      _id_636C8575D7A7768B = dist;
      _id_D6A24DD68967019E = index;
    }
  }

  foreach(index, _id_C2FBB71A3A796005 in self._id_E0C08758EB0006BE._id_7D8884F5400E2FCA) {
    foreach(_id_4A72697044D23367, _id_BE64712B6ECE7AA5 in _id_C2FBB71A3A796005) {
      foreach(_id_908F3939D47BD887, node in _id_BE64712B6ECE7AA5.path) {
        dist = distancesquared(node.origin, self.origin);

        if(dist < _id_636C8575D7A7768B) {
          _id_636C8575D7A7768B = dist;
          _id_306CB412722A32D9 = _id_4A72697044D23367;
          _id_8F51101F14C01979 = _id_908F3939D47BD887;
          _id_D6A24DD68967019E = index;
        }
      }
    }
  }

  self._id_F0F726ADAFB8C51A = _id_8F51101F14C01979;
  self._id_13CCB567671DEB18 = _id_306CB412722A32D9;
  self._id_46496C542D347BA8 = _id_D6A24DD68967019E;
  self._id_E0C08758EB0006BE.index = _id_D6A24DD68967019E;
}

_id_93DCCF3096384DA0() {
  self endon("death");

  for(;;) {
    self waittill("near_goal");
    self._id_2F63CC785DACC8A3 = self.origin;
    wait 0.1;
    thread _id_AA6F0C2C4F3559C0(self._id_76A498119F4D69BC);
  }
}

_id_96B758D589365EF6(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid) {
  if(isagent(attacker)) {
    return;
  }
  if(isPlayer(attacker))
    self._id_8E7D46146A9CF2EB = attacker;

  if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback))
    self[[level.vehicles.damagecallback]](inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname, eventid);
  else
    self vehicle_finishdamage(inflictor, attacker, damage, _id_44E290FB31B85206, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, _id_799F234362ADB813, partname);

  if(self.damagestate == 0 && self.health / self.maxhealth < 0.6) {
    self setscriptablepartstate("body_damage_light", "on", 0);

    if(isDefined(self.interact))
      self.interact setscriptablepartstate("body_damage_light", "on", 0);

    self.damagestate = 1;
  } else if(self.damagestate == 1 && self.health / self.maxhealth < 0.3) {
    self setscriptablepartstate("body_damage_medium", "on", 0);

    if(isDefined(self.interact)) {
      self.interact setscriptablepartstate("body_damage_light", "off", 0);
      self.interact setscriptablepartstate("body_damage_medium", "on", 0);
    }

    self.damagestate = 2;
  }
}