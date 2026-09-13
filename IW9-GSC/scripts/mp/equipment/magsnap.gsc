/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\magsnap.gsc
***********************************************/

main() {
  level._id_364144DD3C6E6520 = spawnStruct();
  level._id_364144DD3C6E6520._id_54C031CB176FDD3A = getdvarfloat("dvar_CEC5A54A168C6679", 500);
  level._id_364144DD3C6E6520._id_B9864A2342FB7B95 = getdvarfloat("dvar_DCC2033108FB8778", 0.1);
  level._id_364144DD3C6E6520._id_45AF1840DD2CB15C = getdvarfloat("dvar_2432A1E2635B0DD7", 0.5);
  level._id_364144DD3C6E6520._id_D60608004C2E785B = getdvarfloat("dvar_4671F8F2C22D073B", 50);
  level._id_364144DD3C6E6520._id_A39CB4BE8C1E51B3 = getdvarfloat("dvar_85596D8A6911C513", 250);
  level._id_364144DD3C6E6520._id_A39CB4BE8C1E51B3 = getdvarfloat("dvar_85596D8A6911C513", 250);
  level._id_364144DD3C6E6520._id_3DCD416F662EB9C9 = getdvarfloat("dvar_9483ECCE1B94121A", 0.3);
  level._id_364144DD3C6E6520._id_7F7026FFA683F27E = getdvarfloat("dvar_BD655F0C0B07611B", 0.7);
  level._id_364144DD3C6E6520._id_893C4805C8D31E85 = getdvarfloat("dvar_9DF4AD38361C490C", 9000);
  level._id_364144DD3C6E6520._id_F610AE0BF25CBCA8 = getdvarfloat("dvar_626F8428CA347A04", 120);
  level._id_364144DD3C6E6520._id_13AEC9C9A6979E49 = getdvarfloat("dvar_F4441C74920ACDFC", 2.5);
  level._id_364144DD3C6E6520._id_3DB4975D301604DC = getdvarfloat("dvar_EF73F493DBB22DED", 1.5);
  level._id_364144DD3C6E6520._id_F0CDC3C578B25681 = getdvarint("dvar_EE1909CCEA23EB35", 8);
  level._id_364144DD3C6E6520._id_5CD43D05CD3BABAF = getdvarfloat("dvar_9C1A13161E672922", 500);
  level._id_364144DD3C6E6520._id_07B93BF8332743D8 = getdvarint("dvar_FF54A873EC2F46FC", 1);
  level._id_364144DD3C6E6520._id_EDDEB2347994E192 = getdvarint("dvar_6EC249B3086984B8", 1000);
  level._id_364144DD3C6E6520._id_12D04A2A12104C64 = getdvarfloat("dvar_B612AE2116E46DAA", 22);
  level._id_364144DD3C6E6520._id_FC05A282FE19896E = getdvarfloat("dvar_40AAED0ED0B9AA68", 70);
  level._id_364144DD3C6E6520._id_F36DAE686081EFFA = getdvarint("dvar_9D333E19DBBEAAAA", 1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("magsnap", "grenadeUsed", ::_id_93AE636ADDEF40FC);
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("eqp_magsnap");
  level._id_1FDD52A3D7E6715D = [];
}

_id_93AE636ADDEF40FC(grenade) {
  player = self;
  grenade endon("death");
  grenade endon("early_stuck");
  level._id_1FDD52A3D7E6715D[grenade getentitynumber()] = grenade;
  grenade setscriptablepartstate("anims", "throw", 0);
  grenade thread _id_16E46A07BA760694();
  grenade thread _id_97BAAC11A9A9DA0E();
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_B488DB65E5FEC906);

  if(istrue(level._id_364144DD3C6E6520._id_F36DAE686081EFFA))
    grenade thread scripts\mp\damage::monitordamage(19, "hitequip", ::_id_42FF6279E801E356, ::_id_0006926C08044819);

  wait(level._id_364144DD3C6E6520._id_B9864A2342FB7B95);
  grenade thread _id_77C1D8E179647B3A();
}

_id_77C1D8E179647B3A() {
  self endon("death");
  self endon("early_stuck");

  for(;;) {
    _id_8D4A699ABE2400B0 = _id_006A3D59E885F8DE();

    if(isDefined(_id_8D4A699ABE2400B0)) {
      self._id_8D4A699ABE2400B0 = _id_8D4A699ABE2400B0;
      thread _id_CB826296092AF87F();
      return;
    }

    waitframe();
  }
}

_id_CB826296092AF87F() {
  self endon("death");
  self endon("early_stuck");
  self notify("seek_started");
  self missilehidetrail();
  self setscriptablepartstate("fly", "inactive", 0);
  self setscriptablepartstate("seek", "active", 0);
  self setscriptablepartstate("anims", "in", 0);
  _id_6150B9D03028F80C = scripts\engine\utility::_id_06C71C72547BB931(self.origin);
  _id_05EF919FC92B9E48 = level._id_364144DD3C6E6520._id_893C4805C8D31E85;

  if(!istrue(_id_6150B9D03028F80C)) {
    self.angles = self.angles - (90, 0, 0);
    self._id_25DB4001E607EEC1 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
    self linkTo(self._id_25DB4001E607EEC1);
    _id_CFDA048A67136B8D = self.origin + (0, 0, level._id_364144DD3C6E6520._id_D60608004C2E785B);
    endpos = physicstrace(self.origin, _id_CFDA048A67136B8D);

    if(endpos != _id_CFDA048A67136B8D) {
      _id_59CC4BBDB45C73D6 = distance(self.origin, endpos);
      _id_C9D21868A74D14D5 = _id_59CC4BBDB45C73D6 / level._id_364144DD3C6E6520._id_D60608004C2E785B;
      _id_8A1C31DC5147CD9C = _id_C9D21868A74D14D5 * level._id_364144DD3C6E6520._id_45AF1840DD2CB15C;
      self._id_25DB4001E607EEC1 moveTo(endpos, _id_8A1C31DC5147CD9C, level._id_364144DD3C6E6520._id_3DCD416F662EB9C9 * _id_8A1C31DC5147CD9C, level._id_364144DD3C6E6520._id_7F7026FFA683F27E * _id_8A1C31DC5147CD9C);
    } else
      self._id_25DB4001E607EEC1 moveTo(_id_CFDA048A67136B8D, level._id_364144DD3C6E6520._id_45AF1840DD2CB15C, level._id_364144DD3C6E6520._id_3DCD416F662EB9C9 * level._id_364144DD3C6E6520._id_45AF1840DD2CB15C, level._id_364144DD3C6E6520._id_7F7026FFA683F27E * level._id_364144DD3C6E6520._id_45AF1840DD2CB15C);

    wait(level._id_364144DD3C6E6520._id_45AF1840DD2CB15C);
    self unlink();
    self._id_25DB4001E607EEC1 delete();
    waitframe();
  } else {
    _id_05EF919FC92B9E48 = level._id_364144DD3C6E6520._id_F610AE0BF25CBCA8;
    wait(level._id_364144DD3C6E6520._id_45AF1840DD2CB15C);
  }

  if(!isDefined(self._id_8D4A699ABE2400B0) || !isalive(self._id_8D4A699ABE2400B0)) {
    return;
  }
  _id_4DD85878437BFB1A = _id_5CB667460C4A842C(self._id_8D4A699ABE2400B0);
  targetorigin = scripts\engine\utility::ter_op(isDefined(_id_4DD85878437BFB1A), _id_4DD85878437BFB1A, self._id_8D4A699ABE2400B0.origin);
  _id_C8ABD320C8CE5955(targetorigin, _id_05EF919FC92B9E48);
}

_id_C8ABD320C8CE5955(targetorigin, _id_F8048727716242B0) {
  self setscriptablepartstate("anims", "dive", 0);
  self setscriptablepartstate("dive", "active", 0);
  scripts\mp\utility\weapon::_launchgrenade("magsnap_mp", self.origin, (0, 0, 0), undefined, 1, self);
  waitframe();
  direction = vectorNormalize(targetorigin - self.origin);
  scripts\mp\utility\weapon::_launchgrenade("magsnap_mp", self.origin, direction * _id_F8048727716242B0, 100, 1, self);
  wait(level._id_364144DD3C6E6520._id_13AEC9C9A6979E49);
  thread _id_413C88CEDC60B27C(self);
}

_id_413C88CEDC60B27C(grenade) {
  grenade endon("death");

  if(!isDefined(grenade) || istrue(grenade._id_3DEC45413E499E18))
    return;
  else
    grenade._id_3DEC45413E499E18 = 1;

  owner = grenade.owner;

  if(grenade getscriptablepartstate("fly") == "active")
    grenade setscriptablepartstate("fly", "inactive", 0);

  grenade setscriptablepartstate("anims", "out", 0);
  grenade setscriptablepartstate("seek", "inactive", 0);
  grenade setscriptablepartstate("stuck", "active", 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_364144DD3C6E6520._id_F0CDC3C578B25681; _id_AC0E594AC96AA3A8++) {
    thread _id_FABD0E133860C3E1(grenade);
    _id_DABD31905C8EF6B1(grenade);

    if(_id_AC0E594AC96AA3A8 == level._id_364144DD3C6E6520._id_F0CDC3C578B25681 - 1) {
      grenade _id_5E76EAE43A3BE711(scripts\engine\utility::ter_op(scripts\engine\utility::_id_06C71C72547BB931(grenade.origin), "timeout_underwater", "timeout"));
      continue;
    }

    wait(level._id_364144DD3C6E6520._id_3DB4975D301604DC);
  }
}

_id_DABD31905C8EF6B1(grenade) {
  if(!isDefined(grenade._id_D9C65D67EEC5EA00))
    grenade._id_D9C65D67EEC5EA00 = [];

  _id_3E3FF1AA3362BAC2 = grenade._id_D9C65D67EEC5EA00;

  foreach(_id_82DC593EF677C4F0 in grenade._id_08323BC4CDCCDA6D)
  _id_3E3FF1AA3362BAC2 = scripts\engine\utility::_id_6D6AF8144A5131F1(_id_3E3FF1AA3362BAC2, _id_82DC593EF677C4F0);

  _id_4AB11C52D7908E01 = _id_3E3FF1AA3362BAC2.size - grenade._id_D9C65D67EEC5EA00.size;

  if(_id_4AB11C52D7908E01 > 0 && isDefined(grenade.owner))
    scripts\cp_mp\challenges::_id_8359CADD253F9604(grenade.owner, "magsnap_tag", _id_4AB11C52D7908E01);

  grenade._id_D9C65D67EEC5EA00 = _id_3E3FF1AA3362BAC2;
}

_id_FABD0E133860C3E1(grenade) {
  grenade endon("death");
  _id_7AA1FF687CFC30D1 = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_createoutlinedata(grenade.owner, self.origin);
  position = self.origin;
  _id_F835339FB0E0E6E2 = scripts\common\utility::_id_2D7FD59D039FA69B(position, level._id_364144DD3C6E6520._id_5CD43D05CD3BABAF);
  grenade._id_08323BC4CDCCDA6D = [];

  foreach(player in _id_F835339FB0E0E6E2) {
    if(!scripts\mp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(grenade.owner, player, 1))) {
      continue;
    }
    if(!level._id_364144DD3C6E6520._id_07B93BF8332743D8) {
      target = _id_5CB667460C4A842C(player);

      if(!isDefined(target))
        continue;
    }

    _id_9283BB519D50DCF5 = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_applysnapshot(player, grenade.owner, _id_7AA1FF687CFC30D1, undefined, undefined, 1);

    if(_id_9283BB519D50DCF5 && isPlayer(player))
      grenade._id_08323BC4CDCCDA6D = scripts\engine\utility::array_add(grenade._id_08323BC4CDCCDA6D, player);
  }

  grenade setscriptablepartstate("snapshot", "active", 0);
  grenade playsoundonmovingent("equip_magsnap_pulse");
  wait(level._id_364144DD3C6E6520._id_EDDEB2347994E192);
  grenade setscriptablepartstate("snapshot", "inactive", 0);
}

_id_16E46A07BA760694() {
  _id_A681B7890CD017C7 = spawnStruct();
  childthread scripts\mp\equipment::_id_BDDE0931ACCF955B(_id_A681B7890CD017C7);
  self waittill("missile_impact");

  if(isDefined(_id_A681B7890CD017C7) && isDefined(_id_A681B7890CD017C7.stuckto)) {
    if(isPlayer(_id_A681B7890CD017C7.stuckto) || isagent(_id_A681B7890CD017C7.stuckto)) {
      self notify("early_stuck");
      scripts\mp\damage::monitordamageend();
      self.owner _id_74B851B7AA1EF32D::_id_693D12AA2C1C02C5(0, "magsnapHit");
      _id_A681B7890CD017C7.stuckto thread _id_413C88CEDC60B27C(self);
      return;
    } else if(_id_A681B7890CD017C7.stuckto scripts\cp_mp\vehicles\vehicle::isvehicle())
      _id_A681B7890CD017C7.stuckto dodamage(1, self.origin, self.owner, self);
  }

  if(!istrue(self._id_3DEC45413E499E18))
    _id_5E76EAE43A3BE711("impact");
}

_id_B488DB65E5FEC906(_id_E527F023260C562C) {
  _id_E527F023260C562C.victim _id_5CD13F03F0108C3C(_id_E527F023260C562C.attacker);
  _id_E527F023260C562C.victim thread _id_5E76EAE43A3BE711("impact");
}

_id_97BAAC11A9A9DA0E() {
  self endon("death");
  self endon("seek_started");
  self endon("early_stuck");

  for(;;) {
    if(scripts\engine\utility::_id_06C71C72547BB931(self.origin)) {
      if(self getscriptablepartstate("fly") != "underwater")
        self setscriptablepartstate("fly", "underwater", 0);
    } else if(self getscriptablepartstate("fly") != "active")
      self setscriptablepartstate("fly", "active", 0);

    wait 0.5;
  }
}

_id_0006926C08044819(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  damage = data.damage;

  if(scripts\engine\utility::isbulletdamage(meansofdeath)) {
    if(isDefined(objweapon)) {
      hits = 1;

      if(damage >= scripts\mp\weapons::minegettwohitthreshold())
        hits = hits + 1;

      if(scripts\mp\utility\damage::isfmjdamage(objweapon, meansofdeath))
        hits = hits * 2;

      damage = hits * 19;
    }
  }

  scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, meansofdeath);
  return damage;
}

_id_42FF6279E801E356(data) {
  _id_5E76EAE43A3BE711("impact");
  _id_5CD13F03F0108C3C(data.attacker, data.objweapon);
}

_id_5E76EAE43A3BE711(state) {
  if(!isDefined(self)) {
    return;
  }
  level._id_1FDD52A3D7E6715D[self getentitynumber()] = undefined;
  self setscriptablepartstate("destroy", state, 0);
  self setscriptablepartstate("stuck", "inactive", 0);
  self notify("death");
  scripts\cp_mp\ent_manager::deregisterspawn();
  self.exploding = 1;
  wait 2;

  if(isDefined(self._id_25DB4001E607EEC1))
    self._id_25DB4001E607EEC1 delete();

  self delete();
}

_id_5CD13F03F0108C3C(attacker, objweapon) {
  if(isDefined(attacker) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, objweapon);
  }
}

_id_006A3D59E885F8DE() {
  targets = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, level._id_364144DD3C6E6520._id_5CD43D05CD3BABAF);
  _id_8D4A699ABE2400B0 = undefined;
  _id_4DD85878437BFB1A = undefined;
  _id_C1DA30005A22582B = undefined;

  foreach(target in targets) {
    if(target.team == self.team) {
      continue;
    }
    _id_501C0103B7BC4ABE = _id_5CB667460C4A842C(target);

    if(!isDefined(_id_501C0103B7BC4ABE)) {
      continue;
    }
    _id_C2F3143F8701C43B = distancesquared(self.origin, _id_501C0103B7BC4ABE);

    if(!isDefined(_id_C1DA30005A22582B) || _id_C2F3143F8701C43B < _id_C1DA30005A22582B) {
      _id_8D4A699ABE2400B0 = target;
      _id_C1DA30005A22582B = _id_C2F3143F8701C43B;
    }
  }

  return _id_8D4A699ABE2400B0;
}

_id_5CB667460C4A842C(player) {
  _id_073ED222306C8D11 = [];
  _id_073ED222306C8D11[_id_073ED222306C8D11.size] = player gettagorigin("j_spine4");
  _id_073ED222306C8D11[_id_073ED222306C8D11.size] = player gettagorigin("j_shoulder_le");
  _id_073ED222306C8D11[_id_073ED222306C8D11.size] = player gettagorigin("j_shoulder_ri");
  _id_073ED222306C8D11[_id_073ED222306C8D11.size] = player gettagorigin("j_knee_le");
  _id_073ED222306C8D11[_id_073ED222306C8D11.size] = player gettagorigin("j_knee_ri");
  _id_073ED222306C8D11[_id_073ED222306C8D11.size] = player gettagorigin("j_head");
  _id_A15A7F703200FCC3 = undefined;

  if(player _meth_793F941D7DFF15ED()) {
    _id_A15A7F703200FCC3 = player.vehicle;

    if(player _meth_A7DE57196F4B5D16()) {
      seat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(_id_A15A7F703200FCC3, player);
      _id_E2718B7F1C9EAD28 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_linktooriginandangles(_id_A15A7F703200FCC3, seat);
      _id_482D742BED8EEBCC = strtok(seat, "_");

      if(scripts\engine\utility::array_contains(_id_482D742BED8EEBCC, "right"))
        targetorigin = _id_E2718B7F1C9EAD28.origin + anglestoright(_id_E2718B7F1C9EAD28.angles) * level._id_364144DD3C6E6520._id_12D04A2A12104C64 + anglestoup(_id_E2718B7F1C9EAD28.angles) * level._id_364144DD3C6E6520._id_FC05A282FE19896E;
      else if(scripts\engine\utility::array_contains(_id_482D742BED8EEBCC, "driver") || scripts\engine\utility::array_contains(_id_482D742BED8EEBCC, "left"))
        targetorigin = _id_E2718B7F1C9EAD28.origin + anglestoleft(_id_E2718B7F1C9EAD28.angles) * level._id_364144DD3C6E6520._id_12D04A2A12104C64 + anglestoup(_id_E2718B7F1C9EAD28.angles) * level._id_364144DD3C6E6520._id_FC05A282FE19896E;
      else
        targetorigin = _id_E2718B7F1C9EAD28.origin + anglestoup(_id_E2718B7F1C9EAD28.angles) * level._id_364144DD3C6E6520._id_FC05A282FE19896E;

      return targetorigin;
    }
  }

  foreach(_id_4DD85878437BFB1A in _id_073ED222306C8D11) {
    if(sighttracepassed(self.origin, _id_4DD85878437BFB1A, 0, _id_A15A7F703200FCC3))
      return _id_4DD85878437BFB1A;
  }

  return undefined;
}