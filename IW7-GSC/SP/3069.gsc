/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3069.gsc
**************************************/

_id_488D() {
  self.meleerangesq = 9216;
  self.meleechargedist = 1000;
  self.meleechargedistvsplayer = 1000;
  self._id_B627 = 36;
  self.meleeactorboundsradius = 32;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = ::_id_9DA2;
}

_id_9DA0(var_0) {
  if(isDefined(self.dontmelee))
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  if(isDefined(self.enemy.dontmelee))
    return 0;

  if(isDefined(self._stealth) && !scripts\aitypes\melee::canmeleeduringstealth())
    return 0;

  if(isDefined(var_0) && var_0)
    return 1;

  if(scripts\aitypes\melee::_id_9DD1())
    return 0;

  return 1;
}

_id_9D9F(var_0) {
  if(!scripts\asm\asm_bb::bb_iscrawlmelee())
    return anim.failure;

  return anim.success;
}

_id_487C(var_0) {
  if(randomint(100) < 25)
    _id_0BFE::_id_E1B1(randomintrange(3000, 8000));
  else
    _id_0BFE::_id_E1B2(randomintrange(3000, 8000));

  thread _id_0BFE::_id_5671();
  _id_488D();
  return anim.success;
}

_id_487B() {
  _id_0BFE::_id_41DA();
  _id_0BFE::_id_41DB();
  _id_0BFE::_id_F6C7();
}

_id_FFDD(var_0) {
  if(!_id_9DA0(0)) {
    _id_487B();
    return anim.failure;
  }

  if(![[self.fnismeleevalid]](self.enemy, 0)) {
    _id_487B();
    return anim.failure;
  }

  return anim.success;
}

_id_4881(var_0) {
  self.bt.instancedata[var_0] = spawnStruct();
  self.bt.instancedata[var_0]._id_3E30 = gettime() + 100;
  self.bt.instancedata[var_0].timeout = gettime() + 4000;
  self.bt.instancedata[var_0]._id_6572 = self.enemy.origin;
  self.melee._id_2AC7 = 1;
  self.melee._id_2AC6 = 1;
  self._id_B651 = 1;

  if(scripts\asm\asm_bb::bb_isselfdestruct() && isDefined(self.bt._id_F1F7)) {
    self.bt._id_F1F7 stoploopsound();
    self.bt._id_F1F7 playLoopSound("c6_mvmt_crawl_loop_vocal");
  } else
    self playLoopSound("c6_mvmt_crawl_loop_vocal");
}

_id_487A(var_0) {
  self.melee._id_29B4 = 1;
  return anim.success;
}

_id_488C(var_0) {
  if(_id_0A0B::_id_2EE1()) {
    if(!isDefined(self.bt._id_487E)) {
      self.bt._id_487E = 1;
      self.btgoalradius = 16;
      self _meth_8481(self.origin);
      thread _id_0BFE::_id_F1F8();
    }

    return anim.running;
  }

  return anim.success;
}

_id_9DA2(var_0, var_1) {
  if(scripts\aitypes\melee::ismeleevalid_common(var_0, var_1) == 0)
    return 0;

  if(var_1) {
    if(scripts\anim\utility_common::isusingsidearm())
      return 0;
  }

  if(isDefined(self.grenade) && self.frontshieldanglecos == 1)
    return 0;

  if(isDefined(var_0._id_5951) || isDefined(var_0.ignoreme) && var_0.ignoreme)
    return 0;

  if(!isai(var_0) && !isPlayer(var_0))
    return 0;

  if(isDefined(self._id_B5DD) && isDefined(var_0._id_B5DD))
    return 0;

  if(isDefined(self._id_B5DD) && isDefined(var_0._id_B14F) || isDefined(var_0._id_B5DD) && isDefined(self._id_B14F))
    return 0;

  if(isai(var_0)) {
    if(var_0 _meth_81A6())
      return 0;

    if(var_0 scripts\sp\utility::_id_58DA() || var_0.delayeddeath)
      return 0;

    if(self.stairsstate != "none" || var_0.stairsstate != "none")
      return 0;

    if(var_0.unittype != "soldier" && var_0.unittype != "c6" && var_0.unittype != "c6i")
      return 0;
  }

  if(isPlayer(var_0))
    var_2 = var_0 getstance();
  else
    var_2 = var_0.a.pose;

  if(var_2 != "stand" && var_2 != "crouch")
    return 0;

  if(isDefined(self._id_B14F) && isDefined(var_0._id_B14F))
    return 0;

  if(isDefined(var_0.grenade))
    return 0;

  return 1;
}