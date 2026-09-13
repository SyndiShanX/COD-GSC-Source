/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6559b97af8aaf4bd.gsc
***********************************************/

_id_36AE2D2C117CDB23(_id_CC4F2E0388379546) {
  switch (_id_CC4F2E0388379546) {
    case "onUserInit":
      return::_id_3DBD361F74B442F9;
    case "onUserTerminate":
      return::_id_A157FBBC31D9EB1A;
    case "onEventReceived":
      return::_id_D9A30A0827FAB997;
    case "movingToDyingGuy":
      return::_id_13C5106712EE80F6;
    case "reviving":
      return::_id_82C92A2938EC01AF;
    case "dyingGuyBeingRevived":
      return::_id_7436E5B9117C6FAB;
    case "earlyRevivedSuccess":
      return::_id_23319222A7765CF2;
    case "set_bseq_phase":
      return _id_53651341190C5AAB::_id_606C28B248BADDFD;
  }
}

_id_3DBD361F74B442F9(_id_F8D4ED108521E632) {}

_id_A157FBBC31D9EB1A(_id_F8D4ED108521E632) {
  _id_8A46C62F0A756DD3 = "revival_helper_stim";

  if(self isscriptable() && self getscriptablehaspart(_id_8A46C62F0A756DD3))
    self setscriptablepartstate(_id_8A46C62F0A756DD3, "default");

  self unlink();
  self.pushable = 1;
  self.skipdyingbackcrawl = 0;

  if(!isalive(self))
    _func_AE368FAD1A1DC337(_id_F8D4ED108521E632, "death", 1);
  else {
    if(self._id_FE5EBEFA740C7106 == 0)
      _func_AE368FAD1A1DC337(_id_F8D4ED108521E632, "stealth_idle", 1);
    else if(self.asmname == self._id_A942DD31D55102C9)
      _func_AE368FAD1A1DC337(_id_F8D4ED108521E632, "death", 1);

    scripts\asm\asm::asm_fireephemeralevent("revival", "end");
    self clearbtgoal(3);
    self._id_026AA5CB1924A027 = 0;
    self._id_C3B6984B9532AF5B = 0;
  }

  self notify("end_revival");
}

_id_D9A30A0827FAB997(receiver, info, origin) {
  if(info == "focused_on" && !scripts\engine\utility::doinglongdeath()) {
    distsq = distancesquared(receiver.origin, origin);
    _id_63233BCA53EFDD98 = 200;

    if(distsq < _id_63233BCA53EFDD98 * _id_63233BCA53EFDD98 && !istrue(_func_060D6151AF81A343(self _meth_92435C7A6AE85C3C(), "death"))) {
      _func_AE368FAD1A1DC337(self _meth_92435C7A6AE85C3C(), "death", 1);
      return 1;
    }
  }

  return 0;
}

_id_13C5106712EE80F6(statename, params) {
  self endon("death");
  self endon("end_revival");
  _id_CEB886EB060AED49 = _id_FA0AAE45CE9C1727();

  if(!isDefined(_id_CEB886EB060AED49))
    _id_2D7FA1F11C70AD04();

  _id_CEB886EB060AED49 endon("death");
  _id_CEB886EB060AED49 endon("end_revival");
  _id_8EEFCDE993E5AE9D = 10;
  _id_C104EF9B1CAEF15D = _id_CEB886EB060AED49.origin;
  self setbtgoalpos(3, _id_C104EF9B1CAEF15D);
  self setbtgoalRadius(3, _id_8EEFCDE993E5AE9D);
  self waittill("path_set");
  self._id_026AA5CB1924A027 = 1;
  self._id_C3B6984B9532AF5B = 1;
  _id_6BC273BA321491F0 = 200;

  for(_id_5C7DC4E92DE4142E = self pathdisttogoal(); _id_5C7DC4E92DE4142E > _id_6BC273BA321491F0; _id_5C7DC4E92DE4142E = self pathdisttogoal()) {
    if(!isDefined(_id_CEB886EB060AED49))
      _id_2D7FA1F11C70AD04();

    _id_C104EF9B1CAEF15D = _id_CEB886EB060AED49.origin;
    self setbtgoalpos(3, _id_C104EF9B1CAEF15D);
    wait 0.2;
  }

  if(!isDefined(_id_CEB886EB060AED49))
    _id_2D7FA1F11C70AD04();

  _id_CEB886EB060AED49 animmode("angle deltas");
  _id_CEB886EB060AED49.skipdyingbackcrawl = 1;
  _id_CEB886EB060AED49 asmfireevent(_id_CEB886EB060AED49.asmname, "dying_back_crawl_done");
  _id_C104EF9B1CAEF15D = _id_CEB886EB060AED49.origin;
  _id_CEB886EB060AED49.pushable = 0;
  self.pushable = 0;
  _id_B3CD99F8E04AD13F = _id_9D6585CC199439CB(_id_CEB886EB060AED49);
  _id_975BE27F963E2F30 = "reviving_guy";
  _id_996949B7474560EB = _func_A0CCCF0B4C466B2C(self, _id_975BE27F963E2F30);
  _id_12D7533DD135629E = _id_996949B7474560EB.animation;
  _id_B70CF2E9EAA2927E = "reviving_intro";
  alias = archetypegetalias(_id_12D7533DD135629E, _id_B70CF2E9EAA2927E, _id_B3CD99F8E04AD13F, 0);
  animation = alias.anims;
  startorigin = getstartorigin(_id_CEB886EB060AED49.origin, _id_CEB886EB060AED49.angles, animation);
  startangles = getstartangles(_id_CEB886EB060AED49.origin, _id_CEB886EB060AED49.angles, animation);

  if(!ispointonnavmesh(startorigin, self)) {
    _id_9373E8DA64267C1F = _id_BE5400E991AE040A(_id_B3CD99F8E04AD13F);
    alias = archetypegetalias(_id_12D7533DD135629E, _id_B70CF2E9EAA2927E, _id_9373E8DA64267C1F, 0);
    animation = alias.anims;
    startorigin = getstartorigin(_id_CEB886EB060AED49.origin, _id_CEB886EB060AED49.angles, animation);
    startangles = getstartangles(_id_CEB886EB060AED49.origin, _id_CEB886EB060AED49.angles, animation);

    if(!ispointonnavmesh(startorigin, self)) {
      _id_CEB886EB060AED49._id_D5E499E7FE2C490B = 0;
      _func_AE368FAD1A1DC337(self _meth_92435C7A6AE85C3C(), "death", 1);
    }
  }

  self._id_14461074A827AAC9 = startorigin;
  self setbtgoalpos(3, self._id_14461074A827AAC9);
  self._id_6F56798704F22AD1 = startangles;
  self._id_0A41EDF45BB0FF97 = self._id_6F56798704F22AD1;
  self._id_C55C721292FDB08B = "crouch";
  _id_C70217358EDDBEB2 = 2;
  scripts\engine\utility::waittill_any_timeout_1(_id_C70217358EDDBEB2, "bt_goal");

  while(istrue(self.arriving))
    waitframe();

  if(!isDefined(_id_CEB886EB060AED49))
    _id_2D7FA1F11C70AD04();

  _id_A9EFDA5C39DAB5C0 = 32;

  if(distancesquared(self.origin, self._id_14461074A827AAC9) < _id_A9EFDA5C39DAB5C0 * _id_A9EFDA5C39DAB5C0) {
    _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_ai_revival", "caps/interactions/cap_ai_revival");
    self waittill("reviving_intro_starts");
  } else
    _func_AE368FAD1A1DC337(self _meth_92435C7A6AE85C3C(), "death", 1);

  self._id_026AA5CB1924A027 = 0;
  self clearbtgoal(3);
}

_id_82C92A2938EC01AF(statename, params) {
  self endon("death");
  self endon("end_revival");
  self endon("cap_exit_completed");
  childthread _id_971F2CE9CE3CF9E8();
  wait 0.3;
  _id_278C159E227FB4E3 = _id_FA0AAE45CE9C1727();
  self._id_026AA5CB1924A027 = 0;

  if(isDefined(_id_278C159E227FB4E3))
    self linktoblendtotag(_id_278C159E227FB4E3, "tag_sync");

  self waittill("cap_exit_completed");
}

_id_7436E5B9117C6FAB(statename, params) {
  self endon("death");
  self endon("end_revival");
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("cap_ai_revival", "caps/interactions/cap_ai_revival");

  while(!scripts\asm\asm::asm_ephemeraleventfired("being_revived", "end")) {
    _id_D51349C1F64450E3 = level.frameduration;
    self.desiredtimeofdeath = self.desiredtimeofdeath + _id_D51349C1F64450E3;
    waitframe();
  }

  self.doinglongdeath = 0;
  self.health = 150;
  self waittill("cap_exit_completed");
  _id_DB717D5877CAF11D();
}

_id_23319222A7765CF2(statename, params) {
  self endon("death");
  self endon("end_revival");
  scripts\asm\asm::asm_fireevent(self.asmname, "early_revived_success");

  if(istrue(self.doinglongdeath)) {
    self.doinglongdeath = 0;
    self.health = 150;
  }

  self waittill("cap_exit_completed");
  _id_DB717D5877CAF11D();
}

_id_DB717D5877CAF11D() {
  _id_EC2EBFC4CC6BFFC1 = _id_5669CB34CD563512();

  if(isDefined(_id_EC2EBFC4CC6BFFC1))
    _id_EC2EBFC4CC6BFFC1 unlink();
}

_id_971F2CE9CE3CF9E8() {
  startpos = self.origin;
  startangles = self.angles;
  _id_41845CE3E73BB4F2 = distancesquared(startpos, self._id_14461074A827AAC9) > 100;
  _id_8DF2B0C826A4A7B2 = absangleclamp180(startangles[1] - self._id_6F56798704F22AD1[1]) > 7;

  if(_id_41845CE3E73BB4F2 || _id_8DF2B0C826A4A7B2) {
    interval = 300;
    endtime = gettime() + interval;

    while(endtime > gettime()) {
      fraction = 1.0 - (endtime - gettime()) / interval;
      _id_6C53D859D582A421 = vectorlerp(startpos, self._id_14461074A827AAC9, fraction);
      _id_B98CF035C97EDEE9 = anglelerpquatfrac(startangles, self._id_6F56798704F22AD1, fraction);
      self forceteleport(_id_6C53D859D582A421, _id_B98CF035C97EDEE9);
      waitframe();
    }
  }
}

_id_9D6585CC199439CB(_id_CEB886EB060AED49) {
  _id_3B3C2E088B48D1E2 = 6;
  _id_44FBE4141B0CB046 = "_back";

  if(isDefined(_id_CEB886EB060AED49)) {
    _id_3B3C2E088B48D1E2 = _id_5262C59C62FA4892::_id_A1E95F167C3C1107(_id_CEB886EB060AED49, self);
    _id_44FBE4141B0CB046 = _id_CEB886EB060AED49 _id_5262C59C62FA4892::getdamagedirectionsuffix();
  }

  return _id_3B3C2E088B48D1E2 + _id_44FBE4141B0CB046;
}

_id_BE5400E991AE040A(alias) {
  if(alias[0] == "4")
    return "6" + getsubstr(alias, 1);
  else
    return "4" + getsubstr(alias, 1);
}

_id_2D7FA1F11C70AD04() {
  _func_AE368FAD1A1DC337(self _meth_92435C7A6AE85C3C(), "death", 1);
  self _meth_EA63241A4D3092C4();
}

_id_FA0AAE45CE9C1727() {
  id = self _meth_92435C7A6AE85C3C();
  _id_7E18A8A72A7ADD37 = _func_FCE201C1F66B31B6(id, "dying_guy");
  return _id_7E18A8A72A7ADD37[0];
}

_id_5669CB34CD563512() {
  id = self _meth_92435C7A6AE85C3C();
  _id_7E18A8A72A7ADD37 = _func_FCE201C1F66B31B6(id, "reviving_guy");
  return _id_7E18A8A72A7ADD37[0];
}