/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7e7fd8191bd7be26.gsc
***********************************************/

_id_21BD6A8C4766AD5A(guy, _id_43730F07D9C240E6, _id_9B57BD8D7F3D4E6A) {
  if(!isDefined(guy) || !isalive(guy)) {
    _id_6E3B3FA7A36B48EA("Armor plate guy passed in undefined or dead!?");
    return undefined;
  }

  id = undefined;

  if(istrue(_id_43730F07D9C240E6))
    id = guy _id_5B3B464CC2CB45F4();
  else {
    guy endon("death");
    guy _id_120270BD0A747A35::_id_8DAD0C97C82FB52F(guy);

    if(!isDefined(_id_9B57BD8D7F3D4E6A))
      _id_9B57BD8D7F3D4E6A = 5;

    guy thread _id_7640CB412C9E964C(self, _id_9B57BD8D7F3D4E6A);
    self waittill("guy_reached_cover");
    id = guy _id_5B3B464CC2CB45F4();
  }

  return id;
}

_id_63C85AB9240382F7(_id_CEB886EB060AED49, _id_EC2EBFC4CC6BFFC1) {
  if(!isDefined(_id_CEB886EB060AED49) || !isalive(_id_CEB886EB060AED49)) {
    _id_6E3B3FA7A36B48EA("Dying guy passed in undefined or dead!?");
    return undefined;
  }

  if(_id_CEB886EB060AED49 scripts\engine\utility::doinglongdeath())
    return _id_CEB886EB060AED49 _meth_92435C7A6AE85C3C();

  _id_F4CD424DD91129F3 = _id_CEB886EB060AED49._id_D5E499E7FE2C490B;
  _id_9C38EE3449EEE5E9 = 0;
  _id_1ABD967A9E476C70 = 0;

  if(isDefined(_id_EC2EBFC4CC6BFFC1)) {
    _id_B4312E532EAE7720 = _id_96E4999AC9CB2936();

    if(!isDefined(_id_B4312E532EAE7720)) {
      _id_6E3B3FA7A36B48EA("AI Code Bhvr bundle not found!");
      return undefined;
    }

    _id_A137E502148A0CBC = _id_B4312E532EAE7720._id_BEF2EF3042B5CF5E;
    _id_F8D4ED108521E632 = _func_72066AA981916ECC(_id_A137E502148A0CBC, _id_CEB886EB060AED49.origin, _id_CEB886EB060AED49.angles);

    if(isDefined(_id_F8D4ED108521E632)) {
      _id_C0456E000364A1D7(_id_CEB886EB060AED49);
      _id_CEB886EB060AED49._id_D5E499E7FE2C490B = 0;
      _id_CEB886EB060AED49 scripts\common\ai::_id_B9307A16E291255E(_id_9C38EE3449EEE5E9, _id_1ABD967A9E476C70);
      timeout = gettime() + 1000;

      while(istrue(_id_CEB886EB060AED49.longdeathstarting) && timeout > gettime())
        waitframe();

      _id_CEB886EB060AED49._id_D5E499E7FE2C490B = 1;
      _id_CEB886EB060AED49 _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632, "dying_guy");
      _id_EC2EBFC4CC6BFFC1 _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
      _id_CEB886EB060AED49 thread _id_4C0173CDE37DFA4A(_id_F4CD424DD91129F3);
      _id_CEB886EB060AED49 thread _id_51084CECD9163520(_id_F8D4ED108521E632);
    } else
      _id_6E3B3FA7A36B48EA("cannot spawn revival interaction");

    return _id_F8D4ED108521E632;
  } else {
    _id_CEB886EB060AED49._id_D5E499E7FE2C490B = 1;
    _id_CEB886EB060AED49 scripts\common\ai::_id_B9307A16E291255E(_id_9C38EE3449EEE5E9, _id_1ABD967A9E476C70);
    timeout = gettime() + 2000;

    while(!isDefined(_id_CEB886EB060AED49 _meth_92435C7A6AE85C3C()) && timeout > gettime())
      waitframe();

    _id_965955A16971E8BF = _id_CEB886EB060AED49 _meth_92435C7A6AE85C3C();

    if(isDefined(_id_965955A16971E8BF))
      _id_CEB886EB060AED49 thread _id_4C0173CDE37DFA4A(_id_F4CD424DD91129F3);
    else
      _id_CEB886EB060AED49._id_D5E499E7FE2C490B = _id_F4CD424DD91129F3;

    return _id_965955A16971E8BF;
  }
}

_id_5B3B464CC2CB45F4() {
  _id_B4312E532EAE7720 = _id_96E4999AC9CB2936();

  if(!isDefined(_id_B4312E532EAE7720)) {
    _id_6E3B3FA7A36B48EA("Undefined Bundle");
    return undefined;
  }

  _id_A137E502148A0CBC = _id_B4312E532EAE7720._id_640697C654911B1B;
  _id_F8D4ED108521E632 = _func_72066AA981916ECC(_id_A137E502148A0CBC, self.origin, self.angles);

  if(isDefined(_id_F8D4ED108521E632)) {
    self _meth_76B3CFB91EF40B3B(_id_F8D4ED108521E632);
    thread _id_D1957C81B78FCE90(_id_F8D4ED108521E632);
  } else
    _id_6E3B3FA7A36B48EA("cannot spawn armor plate interaction");

  return _id_F8D4ED108521E632;
}

_id_D1957C81B78FCE90(id) {
  self waittill("endusearmorplate");
  _func_2A627FA5FD1CE263(id);
}

_id_51084CECD9163520(id) {
  self waittill("end_revival");
  _func_2A627FA5FD1CE263(id);
}

_id_4C0173CDE37DFA4A(_id_F4CD424DD91129F3) {
  self waittill("cap_exit_completed");
  self._id_D5E499E7FE2C490B = _id_F4CD424DD91129F3;
}

_id_7640CB412C9E964C(_id_CE0950EBF476D6EF, timeout) {
  self endon("death");
  scripts\engine\utility::waittill_any_timeout_1(timeout, "goal");

  while(istrue(self.arriving))
    waitframe();

  _id_CE0950EBF476D6EF notify("guy_reached_cover");
}

_id_C0456E000364A1D7(guy) {
  if(!isDefined(guy._id_1544C20E168D97C0))
    guy._id_1544C20E168D97C0 = 5000;
}

_id_96E4999AC9CB2936() {
  return getscriptbundle("enum_0808DDC26C257759");
}

_id_6E3B3FA7A36B48EA(msg) {
  if(getDvar("dvar_CD2A202CCF770735"))
    return;
}