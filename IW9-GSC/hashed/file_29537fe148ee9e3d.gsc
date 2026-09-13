/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_29537fe148ee9e3d.gsc
***********************************************/

_id_36AE2D2C117CDB23(_id_CC4F2E0388379546) {
  switch (_id_CC4F2E0388379546) {
    case "onUserInit":
      return::_id_3DBD361F74B442F9;
    case "onUserTerminate":
      return::_id_A157FBBC31D9EB1A;
    case "setupMeetupPositions":
      return::_id_22AD2C8BCA9871A4;
    case "reachedPrimary":
      return::_id_1829959BC78F41A9;
    case "setWatchersToIdle":
      return::_id_273633DA55DF7339;
    case "callACeaseFire":
      return::_id_C441FA0827D790A3;
    case "setGoalPosLKP":
      return::_id_9AA657F85926DF09;
    case "reachedLKP":
      return::_id_9C6BADB8075C4880;
    case "setupPositionsNearLKP":
      return::_id_F7911B207B7EA23B;
    case "reachedLKPRandom":
      return::_id_F6F3CE8B49C1C3E7;
    case "waitForLKPAnimFinished":
      return::_id_1EB86A6134B967F9;
    case "reachedBTGoal":
      return::_id_59F0C716B5F99A1C;
    case "setstationary":
      return::_id_46A6CB991C2A5D49;
    case "set_bseq_phase":
      return _id_53651341190C5AAB::_id_606C28B248BADDFD;
    case "clearGoal":
      return::_id_8586052802BD2C79;
  }
}

_id_3DBD361F74B442F9(_id_F8D4ED108521E632) {
  if(!isDefined(level._id_80275CA89B572683))
    level._id_80275CA89B572683 = [];

  if(!isDefined(level._id_80275CA89B572683[_id_F8D4ED108521E632])) {
    level._id_80275CA89B572683[_id_F8D4ED108521E632] = spawnStruct();
    level._id_80275CA89B572683[_id_F8D4ED108521E632]._id_E6AAC1358274BC10 = 0;
    level._id_80275CA89B572683[_id_F8D4ED108521E632]._id_4E79A41164DE0C24 = [];
  }

  if(!isDefined(self._id_80275CA89B572683)) {
    self._id_80275CA89B572683 = spawnStruct();
    self._id_80275CA89B572683._id_35C7CD77665DD90A = 0;
  }

  self._id_34127A7FBDB497C5 = 1;
  self._id_ECB9F6A505B89AF6 = 1;
  self reacquireclear();
  self._id_80275CA89B572683.combatmode = self.combatmode;
  self.combatmode = "no_cover";
  self._id_80275CA89B572683.speed = self aigetdesiredspeed();
  self aisetdesiredspeed(120);
  self _meth_E64EA2B4E79C4B74(1);
  self setbtgoalRadius(1, 20);
  level._id_80275CA89B572683[_id_F8D4ED108521E632]._id_4E79A41164DE0C24[level._id_80275CA89B572683[_id_F8D4ED108521E632]._id_4E79A41164DE0C24.size] = self.origin;
  self._id_80275CA89B572683.allowedstances = [];
  self._id_80275CA89B572683._id_D65F2A1135F5C6C6 = 0;

  if(self _meth_E862ED56B787162B("stand")) {
    self._id_80275CA89B572683.allowedstances[self._id_80275CA89B572683._id_D65F2A1135F5C6C6] = "stand";
    self._id_80275CA89B572683._id_D65F2A1135F5C6C6 = self._id_80275CA89B572683._id_D65F2A1135F5C6C6 + 1;
  }

  if(self _meth_E862ED56B787162B("crouch")) {
    self._id_80275CA89B572683.allowedstances[self._id_80275CA89B572683._id_D65F2A1135F5C6C6] = "crouch";
    self._id_80275CA89B572683._id_D65F2A1135F5C6C6 = self._id_80275CA89B572683._id_D65F2A1135F5C6C6 + 1;
  }

  if(self _meth_E862ED56B787162B("prone")) {
    self._id_80275CA89B572683.allowedstances[self._id_80275CA89B572683._id_D65F2A1135F5C6C6] = "prone";
    self._id_80275CA89B572683._id_D65F2A1135F5C6C6 = self._id_80275CA89B572683._id_D65F2A1135F5C6C6 + 1;
  }

  self allowedstances("stand");
  self notify("startlkpbehavior");
}

_id_A157FBBC31D9EB1A(_id_F8D4ED108521E632) {
  self clearbtgoal(1);
  self aiclearscriptdesiredspeed();
  self.combatmode = self._id_80275CA89B572683.combatmode;
  _func_AE368FAD1A1DC337(_id_F8D4ED108521E632, "lkpanimtype", "none");
  self stoplookat();
  self._id_ECB9F6A505B89AF6 = 0;
  self._id_34127A7FBDB497C5 = 0;

  if(self._id_80275CA89B572683._id_D65F2A1135F5C6C6 == 3)
    self allowedstances(self._id_80275CA89B572683.allowedstances[0], self._id_80275CA89B572683.allowedstances[1], self._id_80275CA89B572683.allowedstances[2]);
  else if(self._id_80275CA89B572683._id_D65F2A1135F5C6C6 == 2)
    self allowedstances(self._id_80275CA89B572683.allowedstances[0], self._id_80275CA89B572683.allowedstances[1]);
  else if(self._id_80275CA89B572683._id_D65F2A1135F5C6C6 == 1)
    self allowedstances(self._id_80275CA89B572683.allowedstances[0]);

  if(!isalive(self))
    _func_AE368FAD1A1DC337(_id_F8D4ED108521E632, "death", 1);

  self._id_80275CA89B572683 = undefined;
  _id_9B83AFFDD5ED7AE0 = _id_CBE869548EA6BAAC("primary_investigator", _id_F8D4ED108521E632);

  if(!isDefined(_id_9B83AFFDD5ED7AE0) || _id_9B83AFFDD5ED7AE0 == self)
    level._id_80275CA89B572683[_id_F8D4ED108521E632] = undefined;

  self notify("endlkpbehavior");
}

_id_22AD2C8BCA9871A4(statename, params) {
  _id_9B83AFFDD5ED7AE0 = _id_CBE869548EA6BAAC("primary_investigator");
  _id_9B83AFFDD5ED7AE0 endon("death");
  _id_9B83AFFDD5ED7AE0 endon("endlkpbehavior");
  id = self _meth_92435C7A6AE85C3C();
  _id_70637B1FCCA27427 = _id_CBD389222BCE05AE("backup_investigator");
  _id_412AB049E38BF9FA = _id_9B83AFFDD5ED7AE0.origin;
  return _id_A6F064ACC25E8DB8(_id_412AB049E38BF9FA);
}

_id_1829959BC78F41A9(statename, params) {
  _id_9B83AFFDD5ED7AE0 = _id_CBE869548EA6BAAC("primary_investigator");
  _id_9B83AFFDD5ED7AE0 endon("death");
  _id_9B83AFFDD5ED7AE0 endon("endlkpbehavior");
  id = self _meth_92435C7A6AE85C3C();
  _id_70637B1FCCA27427 = _id_CBD389222BCE05AE("backup_investigator");
  level._id_80275CA89B572683[id]._id_E6AAC1358274BC10++;

  if(level._id_80275CA89B572683[id]._id_E6AAC1358274BC10 >= _id_70637B1FCCA27427.size) {
    _func_AE368FAD1A1DC337(id, "move_complete_initial", 1);
    level._id_80275CA89B572683[id]._id_E6AAC1358274BC10 = 0;
  }
}

_id_273633DA55DF7339(statename, params) {
  _id_9B83AFFDD5ED7AE0 = _id_CBE869548EA6BAAC("primary_investigator");
  _id_9B83AFFDD5ED7AE0 endon("death");
  _id_9B83AFFDD5ED7AE0 endon("endlkpbehavior");
  id = self _meth_92435C7A6AE85C3C();
  self _meth_E64EA2B4E79C4B74(1);
  lastknownposition = _func_060D6151AF81A343(id, "last_known_position");
  self setlookat(lastknownposition + (0, 0, 63));
  _func_AE368FAD1A1DC337(id, "lkpanimtype", "idle");
}

_id_C441FA0827D790A3(statename, params) {
  self endon("endlkpbehavior");
  self endon("death");
  wait 0.2;
  id = self _meth_92435C7A6AE85C3C();
  _id_7A7EAB776DAF7A0A = _func_060D6151AF81A343(id, "num_members");

  if(isDefined(level._id_80275CA89B572683) && isDefined(level._id_80275CA89B572683[id]) && isDefined(level._id_80275CA89B572683[id]._id_4E79A41164DE0C24)) {
    level._id_80275CA89B572683[id]._id_4E79A41164DE0C24[level._id_80275CA89B572683[id]._id_4E79A41164DE0C24.size] = self.origin;
    lastknownposition = _func_060D6151AF81A343(id, "last_known_position");
    level._id_80275CA89B572683[id]._id_4E79A41164DE0C24[level._id_80275CA89B572683[id]._id_4E79A41164DE0C24.size] = lastknownposition;
    _id_181B810D3DE25443 = _id_CBD389222BCE05AE("backup_investigator");
    _id_E598E495307893B6 = _id_CBD389222BCE05AE("RestOfThem");
    _func_AE368FAD1A1DC337(id, "num_backup_members", _id_181B810D3DE25443.size);
    _id_7A7EAB776DAF7A0A = _id_181B810D3DE25443.size + _id_E598E495307893B6.size;
    _func_AE368FAD1A1DC337(id, "num_members", _id_7A7EAB776DAF7A0A);

    if(_id_7A7EAB776DAF7A0A > 1) {
      _func_AE368FAD1A1DC337(id, "lkpanimtype", "cease_fire");
      self._id_63D7585BEE031305 = 1;
      _func_216C67AB6749137A(self, self.enemy, "last_known_position", "cease_fire", 0);
    }
  }
}

_id_5C56BA321FD2AEC8() {
  _id_497AE74EAA2F9C07 = undefined;

  if(isDefined(level.stealth) && isDefined(level.stealth.combat_volumes) && isDefined(self.stealth) && isDefined(level.stealth.combat_volumes[self.script_stealthgroup]))
    _id_497AE74EAA2F9C07 = level.stealth.combat_volumes[self.script_stealthgroup];
  else
    _id_497AE74EAA2F9C07 = self getgoalvolume();

  return _id_497AE74EAA2F9C07;
}

_id_9AA657F85926DF09(statename, params) {
  id = self _meth_92435C7A6AE85C3C();
  lastknownposition = _func_060D6151AF81A343(id, "last_known_position");
  _id_E8D51BF2E0FD9BF4 = undefined;
  _id_6DF5CD3FFE06E6CE = 64;
  self setlookat(lastknownposition + (0, 0, 63));
  _func_AE368FAD1A1DC337(id, "lkpanimtype", "none");
  _id_497AE74EAA2F9C07 = _id_5C56BA321FD2AEC8();

  if(isDefined(_id_497AE74EAA2F9C07)) {
    _id_E8D51BF2E0FD9BF4 = findclosestlospointwithinvolume(_id_497AE74EAA2F9C07, lastknownposition + (0, 0, 63), lastknownposition, level._id_80275CA89B572683[id]._id_4E79A41164DE0C24, 0);

    if(!isDefined(_id_E8D51BF2E0FD9BF4))
      _id_E8D51BF2E0FD9BF4 = findclosestnonlospointwithinvolume(_id_497AE74EAA2F9C07, lastknownposition + (0, 0, 63), lastknownposition, level._id_80275CA89B572683[id]._id_4E79A41164DE0C24, _id_6DF5CD3FFE06E6CE);
  }

  if(!isDefined(_id_E8D51BF2E0FD9BF4))
    _id_E8D51BF2E0FD9BF4 = lastknownposition;

  goalpos = self getclosestreachablepointonnavmesh(_id_E8D51BF2E0FD9BF4);
  level._id_80275CA89B572683[id]._id_4E79A41164DE0C24[level._id_80275CA89B572683[id]._id_4E79A41164DE0C24.size] = goalpos;

  if(getdvarint("ai_debuglkpsquad") != 0) {}

  return goalpos;
}

_id_9C6BADB8075C4880(statename, params) {
  id = self _meth_92435C7A6AE85C3C();
  _func_AE368FAD1A1DC337(id, "lkpanimtype", "lost_target");
  self._id_63D7585BEE031305 = 1;
  _func_216C67AB6749137A(self, self.enemy, "last_known_position", "lost_target");
}

_id_F7911B207B7EA23B(statename, params) {
  _id_9B83AFFDD5ED7AE0 = _id_CBE869548EA6BAAC("primary_investigator");
  _id_9B83AFFDD5ED7AE0 endon("death");
  _id_9B83AFFDD5ED7AE0 endon("endlkpbehavior");
  id = self _meth_92435C7A6AE85C3C();
  lastknownposition = _func_060D6151AF81A343(id, "last_known_position");
  self setlookat(lastknownposition + (0, 0, 63));
  return _id_A6F064ACC25E8DB8(lastknownposition);
}

_id_F6F3CE8B49C1C3E7(statename, params) {
  _id_9B83AFFDD5ED7AE0 = _id_CBE869548EA6BAAC("primary_investigator");
  _id_9B83AFFDD5ED7AE0 endon("death");
  _id_9B83AFFDD5ED7AE0 endon("endlkpbehavior");
  id = self _meth_92435C7A6AE85C3C();
  level._id_80275CA89B572683[id]._id_E6AAC1358274BC10++;
  _id_70637B1FCCA27427 = _id_CBD389222BCE05AE("backup_investigator");

  if(level._id_80275CA89B572683[id]._id_E6AAC1358274BC10 >= _id_70637B1FCCA27427.size) {
    _func_AE368FAD1A1DC337(id, "move_complete_lkp", 1);
    level._id_80275CA89B572683[id]._id_E6AAC1358274BC10 = 0;
  }
}

_id_1EB86A6134B967F9(statename, params) {
  self endon("endlkpbehavior");
  self endon("death");
  scripts\engine\utility::waittill_any_timeout_1(5, "exposed_lkp");
  id = self _meth_92435C7A6AE85C3C();
  _id_D5CC8B378F09BD04 = _func_060D6151AF81A343(id, "lkpanimtype");
  timeout = 10;

  if(_id_D5CC8B378F09BD04 == "idle" || _id_D5CC8B378F09BD04 == "none")
    timeout = 2;

  scripts\engine\utility::waittill_any_timeout_1(timeout, "exposed_lkp_finished");
}

_id_46A6CB991C2A5D49(statename, params) {
  self _meth_E64EA2B4E79C4B74(1);
  self setbtgoalRadius(1, params[0]);
}

_id_59F0C716B5F99A1C(statename) {
  goalradius = 16;
  _id_5C7DC4E92DE4142E = self pathdisttogoal();

  if(_id_5C7DC4E92DE4142E <= goalradius)
    return 1;

  return 0;
}

_id_8586052802BD2C79(statename) {
  self clearbtgoal(1);
}

_id_CBE869548EA6BAAC(tag, _id_F8D4ED108521E632) {
  self endon("death");
  self endon("endlkpbehavior");
  _id_7E18A8A72A7ADD37 = _id_CBD389222BCE05AE(tag, _id_F8D4ED108521E632);
  return _id_7E18A8A72A7ADD37[0];
}

_id_CBD389222BCE05AE(tag, _id_F8D4ED108521E632) {
  self endon("death");
  self endon("endlkpbehavior");

  if(!isDefined(_id_F8D4ED108521E632))
    _id_F8D4ED108521E632 = self _meth_92435C7A6AE85C3C();

  _id_7E18A8A72A7ADD37 = _func_FCE201C1F66B31B6(_id_F8D4ED108521E632, tag);
  return _id_7E18A8A72A7ADD37;
}

_id_A6F064ACC25E8DB8(_id_79029E89A95370D9) {
  self endon("death");
  self endon("endlkpbehavior");
  id = self _meth_92435C7A6AE85C3C();
  _id_6DF5CD3FFE06E6CE = 100;
  _id_497AE74EAA2F9C07 = _id_5C56BA321FD2AEC8();

  if(isDefined(_id_497AE74EAA2F9C07)) {
    _id_E8D51BF2E0FD9BF4 = findclosestlospointwithinvolume(_id_497AE74EAA2F9C07, _id_79029E89A95370D9 + (0, 0, 63), _id_79029E89A95370D9, level._id_80275CA89B572683[id]._id_4E79A41164DE0C24, _id_6DF5CD3FFE06E6CE);

    if(!isDefined(_id_E8D51BF2E0FD9BF4))
      _id_E8D51BF2E0FD9BF4 = findclosestnonlospointwithinvolume(_id_497AE74EAA2F9C07, _id_79029E89A95370D9 + (0, 0, 63), _id_79029E89A95370D9, level._id_80275CA89B572683[id]._id_4E79A41164DE0C24, _id_6DF5CD3FFE06E6CE);
  } else {
    _id_2E61D47FCB18D101 = 1000;
    _id_E8D51BF2E0FD9BF4 = findclosestlospointwithinradius(self.origin, _id_2E61D47FCB18D101, _id_79029E89A95370D9 + (0, 0, 63), _id_79029E89A95370D9, level._id_80275CA89B572683[id]._id_4E79A41164DE0C24, _id_6DF5CD3FFE06E6CE);
  }

  if(!isDefined(_id_E8D51BF2E0FD9BF4)) {
    _id_850A0F04F8EDABA5 = self.origin;
    _id_9CF4AC09E4991562 = randomintrange(100, 150);
    _id_E8D51BF2E0FD9BF4 = _id_79029E89A95370D9 - _id_9CF4AC09E4991562 * vectorNormalize(_id_79029E89A95370D9 - _id_850A0F04F8EDABA5);
  }

  goalpos = self getclosestreachablepointonnavmesh(_id_E8D51BF2E0FD9BF4);
  level._id_80275CA89B572683[id]._id_4E79A41164DE0C24[level._id_80275CA89B572683[id]._id_4E79A41164DE0C24.size] = goalpos;

  if(getdvarint("ai_debuglkpsquad") != 0) {}

  return goalpos;
}