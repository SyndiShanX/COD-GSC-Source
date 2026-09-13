/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\cover.gsc
***********************************************/

getcoverstate() {
  return self._blackboard.coverstate;
}

shouldlookforinitialcover(taskid) {
  if(isDefined(self.fnshouldlookforcover))
    return self[[self.fnshouldlookforcover]](taskid);

  return anim.failure;
}

lookforinitialcover(taskid) {
  if(isDefined(self.fnlookforcover))
    return self[[self.fnlookforcover]](taskid);

  return anim.failure;
}

lookforbettercover_internal(_id_1FE63B952FE3EE08, _id_30B84A9CB603754F, _id_066FCA63B388F049) {
  if(self.arriving)
    return 0;

  if(!isDefined(_id_30B84A9CB603754F))
    _id_30B84A9CB603754F = 0;

  if(self.doingambush)
    node = self _meth_BF780A40BC8B05DE();
  else {
    if(!isDefined(_id_066FCA63B388F049) && _id_2B79931B08683E0A::usingmg())
      _id_066FCA63B388F049 = "cover_lmg";

    node = self findbestcovernode(_id_066FCA63B388F049, _id_30B84A9CB603754F);
  }

  if(isDefined(node)) {
    if(!isDefined(self.node) || node != self.node || isDefined(_id_1FE63B952FE3EE08) && node != _id_1FE63B952FE3EE08) {
      if(self _meth_30377946FC33F8A7(node)) {
        if(self.doingambush) {
          if(self _meth_9D627ED3C24F6B78(node))
            return 1;
          else {
            self clearpath();
            self.keepclaimednodeifvalid = 0;
            self.keepclaimednode = 0;
            return 0;
          }
        }

        return 1;
      }
    }
  }

  return 0;
}

update(_id_B8EBE3F71A08AB40) {
  covernode = self.covernode;
  return anim.success;
}

isdoingambush(_id_B8EBE3F71A08AB40) {
  return self.doingambush;
}

updatehide(_id_B8EBE3F71A08AB40) {
  self setcoverstate("hide", 1);
  return anim.success;
}

shouldreload(_id_B8EBE3F71A08AB40, params) {
  if(self.bulletsinclip > weaponclipsize(self.weapon) * params)
    return anim.failure;

  return anim.success;
}

initreload(_id_B8EBE3F71A08AB40) {
  thread _id_50EEB9595C6D6E1B::_id_C4E2E61A7CE330C0();
  inithidetimers();
}

inithidetimers() {
  _id_6B7BEE46F2C6DA28 = gettime();
  self._id_9831C13B5B34BDF9 = _id_6B7BEE46F2C6DA28;
  self _meth_6AF9B75F2C2A4C9C();
}

terminatehide(_id_B8EBE3F71A08AB40) {}

shouldchangestanceforfun(_id_B8EBE3F71A08AB40) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(isDefined(self.rambochance) && self.currentpose == "stand")
    return anim.failure;

  if(self.node.type != "Cover Right" && self.node.type != "Cover Left")
    return anim.failure;

  if(scripts\engine\utility::isnodecover3d(self.node))
    return anim.failure;

  if(self.currentpose == "stand" && !self.node doesnodeallowstance("crouch"))
    return anim.failure;

  if(self.currentpose == "crouch" && !self.node doesnodeallowstance("stand"))
    return anim.failure;

  if(!isDefined(self._id_058B37DAD6411F81))
    setcoverchangestanceforfuntime();

  if(gettime() < self._id_058B37DAD6411F81)
    return anim.failure;

  return anim.success;
}

setcoverchangestanceforfuntime() {
  self._id_058B37DAD6411F81 = gettime() + randomintrange(5000, 20000);
}

hasroomtofullexposecorner(node) {
  _id_16F58E6BCEBC24CA = 36;
  _id_76227CD0036993E3 = node.origin;

  if(scripts\engine\utility::isnodecoverright(node))
    _id_76227CD0036993E3 = _id_76227CD0036993E3 + anglestoright(node.angles) * _id_16F58E6BCEBC24CA;
  else
    _id_76227CD0036993E3 = _id_76227CD0036993E3 + anglestoleft(node.angles) * _id_16F58E6BCEBC24CA;

  if(!self _meth_B9F3609524DFB456(_id_76227CD0036993E3))
    return 0;

  if(!ispointonnavmesh(_id_76227CD0036993E3, self, 1))
    return 0;

  if(!scripts\engine\trace::capsule_trace_passed(node.origin, _id_76227CD0036993E3, 15, 36, (0, 0, 0), self, scripts\engine\trace::create_character_contents()))
    return 0;

  return 1;
}

updatealwayscoverexposed(taskid) {
  if(self.balwayscoverexposed) {
    if(self.health < self.maxhealth * 0.75)
      self.balwayscoverexposed = 0;
    else if(isDefined(self._blackboard.scriptableparts) && self._blackboard.scriptableparts.size >= 2)
      self.balwayscoverexposed = 0;
  }

  return anim.success;
}

updatecovercroucharrivaltype(taskid) {
  if(!isDefined(self.node) || self.node.type != "Cover Crouch") {
    self._blackboard.croucharrivaltype = undefined;
    self._blackboard.croucharrivalnode = undefined;
    return anim.success;
  }

  if(!isDefined(self._blackboard.croucharrivaltype) || self._blackboard.croucharrivalnode != self.node) {
    pathdisttogoal = self pathdisttogoal();

    if(pathdisttogoal > 0 && pathdisttogoal < 512) {
      _id_15604D8704252FC4 = getDvar("dvar_F72DDE9792B94CC9");

      if(isDefined(self.node.covercrouchtype)) {
        _id_15604D8704252FC4 = self.node.covercrouchtype;

        if(_id_15604D8704252FC4 != "Cover Right Crouch" && _id_15604D8704252FC4 != "Cover Left Crouch" && _id_15604D8704252FC4 != "Cover Crouch")
          _id_15604D8704252FC4 = undefined;
      } else if(_id_15604D8704252FC4 == "")
        _id_15604D8704252FC4 = undefined;

      self._blackboard.croucharrivalnode = self.node;
      self._blackboard.croucharrivaltype = _id_15604D8704252FC4;
    }
  }

  return anim.success;
}