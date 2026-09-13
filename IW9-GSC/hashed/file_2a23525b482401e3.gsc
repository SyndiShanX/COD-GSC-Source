/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2a23525b482401e3.gsc
***********************************************/

_id_36AE2D2C117CDB23(_id_CC4F2E0388379546) {
  switch (_id_CC4F2E0388379546) {
    case "StartPatrolCAP":
      return::_id_85DF049E80F30A6F;
    case "set_bseq_phase":
      return _id_53651341190C5AAB::_id_606C28B248BADDFD;
    case "OnUserInit":
      return::_id_3DBD361F74B442F9;
    case "OnUserTerminate":
      return::_id_A157FBBC31D9EB1A;
    case "OnEventProcessed":
      return::_id_B8A54EF5DC160380;
    case "FilterStartLoopState":
      return::_id_D77B520CEFCEFA50;
    case "FilterShouldReact":
      return::_id_9B4E4B04843C7E9F;
    case "CalcStartOrigin":
      return::_id_18ADD0932F52EE9E;
    case "InformReact":
      return::_id_435377C69EA3DA0B;
    case "FilterInCombat":
      return::_id_E28C16DF7B2F92E0;
    case "ShouldExitLoop":
      return::_id_E73BCB6E8160C464;
    case "CapToPatrolReact":
      return::_id_0D8786F820807C4F;
    case "FilterASMFinished":
      return::_id_9533A5B6F7CE9168;
    case "UseCustomReact":
      return::_id_8F98221D71DAFE6E;
    case "FilterShouldExitInteraction":
      return::_id_CDC4CF4BA475C8C8;
    case "ClearInteractionCap":
      return::_id_C8C992472A4C0276;
    case "ExitInteraction":
      return::_id_61CCC15CEF317B1F;
  }
}

_id_85DF049E80F30A6F(statename, params) {
  role = "guy";

  if(issubstr(self._id_AE3EA15396B65C1F, "guard"))
    role = "pistol";

  _id_996949B7474560EB = _func_A0CCCF0B4C466B2C(self, role);

  if(!isDefined(_id_996949B7474560EB)) {
    role = "guy";
    _id_996949B7474560EB = _func_A0CCCF0B4C466B2C(self, "guy");
  }

  _id_3E38EE41DC326FDC = _id_996949B7474560EB._id_3E38EE41DC326FDC;
  self._id_D773DD66BB9E0306 = _id_3E38EE41DC326FDC;
  animset = _id_996949B7474560EB.animation;
  return _id_53651341190C5AAB::_id_29946584B628C719(statename, [role]);
}

_id_18ADD0932F52EE9E(statename, role) {
  _id_996949B7474560EB = _func_A0CCCF0B4C466B2C(self, role);
  animset = _id_996949B7474560EB.animation;
  _id_BCF3C74B1D8B4883 = _id_996949B7474560EB._id_BCF3C74B1D8B4883;
  _id_842A67EE2435339D = _id_996949B7474560EB.initialstate;
  _id_127E00A9379F717C = _id_996949B7474560EB._id_BAD4F0BD11CBDCF9;
  id = self _meth_92435C7A6AE85C3C();
  origin = _func_BBFC94714C82788B(id);
  angles = _func_785F60047ABCFA05(id);

  if(isDefined(_id_842A67EE2435339D) && isDefined(_id_127E00A9379F717C)) {
    _id_2C8936D08F85C5C1 = archetypegetrandomalias(animset, _id_842A67EE2435339D, _id_127E00A9379F717C, 0);
    xanim = animsetgetanimfromindex(animset, _id_842A67EE2435339D, _id_2C8936D08F85C5C1);
    origin = getstartorigin(origin, angles, xanim);
  }

  return origin;
}

_id_3DBD361F74B442F9(_id_F8D4ED108521E632) {
  self._blackboard._id_7460B96395361857 = "enter";
  self._id_509C25E93045428D = 0;
}

_id_A157FBBC31D9EB1A(_id_F8D4ED108521E632) {
  self._id_D773DD66BB9E0306 = undefined;
  self._id_7916F201EFB9963F = undefined;
  self._blackboard._id_7460B96395361857 = undefined;
  _id_53651341190C5AAB::_id_8ADD99CB1B82B964(_id_F8D4ED108521E632);
  self notify("interaction_end");
}

_id_B8A54EF5DC160380(receiver, info, origin) {
  return 0;
}

_id_3C2BC94B2ABF6FAD(asmname, statename, params) {
  _id_2C8936D08F85C5C1 = scripts\asm\asm::asm_getanim(asmname, statename);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_2C8936D08F85C5C1);

  if(isDefined(params) && params == "loop") {
    self._id_509C25E93045428D = self._id_509C25E93045428D + getanimlength(xanim);
    _id_4E1D4DD23699A8A4::_id_C6F62DE5C6E04207(asmname, statename, params);
  } else
    _id_4E1D4DD23699A8A4::_id_FB8AFEABD23A5EF5(asmname, statename, params, _id_2C8936D08F85C5C1);
}

_id_9B4E4B04843C7E9F(params) {
  return self _meth_A4A9E73B2D25FF8B();
}

_id_0D8786F820807C4F(statename, params) {
  _id_9B1941CB7354665E = "custom_patrol_lookaround_passthrough";

  if(!isDefined(params[0])) {
    _id_9B1941CB7354665E = "stl_react_passthrough";

    if(!isDefined(self._id_FD01AD49B4E38AE8)) {
      if(isDefined(self._id_DE7AB32958C52392))
        self._id_FD01AD49B4E38AE8 = self._id_DE7AB32958C52392;
      else
        self._id_FD01AD49B4E38AE8 = "med";
    }
  }

  if(self asmhasstate(self.asmname, _id_9B1941CB7354665E))
    self asmsetstate(self.asmname, _id_9B1941CB7354665E);
}

_id_435377C69EA3DA0B(statename, params) {
  self asmfireevent(self.asmname, "interaction_react");
}

_id_E28C16DF7B2F92E0(statename, params) {
  return self.bisincombat;
}

_id_A8367856A2C4316F() {
  if(!isDefined(self._blackboard.idlenode))
    return self._id_509C25E93045428D * 1000 + gettime();

  _id_E354D4BC1D4F4D4E = 0;

  if(isDefined(self._blackboard.idlenode.script_delay_min) && isDefined(self._blackboard.idlenode.script_delay_max))
    _id_E354D4BC1D4F4D4E = randomfloatrange(self._blackboard.idlenode.script_delay_min, self._blackboard.idlenode.script_delay_max);
  else if(isDefined(self._blackboard.idlenode.script_delay))
    _id_E354D4BC1D4F4D4E = self._blackboard.idlenode.script_delay;

  time = (self._id_509C25E93045428D + _id_E354D4BC1D4F4D4E) * 1000 + gettime();
  return time;
}

_id_E73BCB6E8160C464(asmname, statename, params) {
  if(isDefined(self._blackboard.idlenode) && isDefined(self._blackboard.idlenode._id_803F2BF203326F29))
    return 0;

  if(!isDefined(self._id_7916F201EFB9963F) || self._id_7916F201EFB9963F <= 0)
    self._id_7916F201EFB9963F = _id_A8367856A2C4316F();

  if(isDefined(self._id_7916F201EFB9963F)) {
    remainingtime = self._id_7916F201EFB9963F - gettime();
    return remainingtime <= 0;
  } else
    return 1;
}

_id_D77B520CEFCEFA50(statename, params) {
  return isDefined(self._blackboard._id_7460B96395361857) && self._blackboard._id_7460B96395361857 == "looping";
}

_id_9533A5B6F7CE9168(statename, params) {
  if(!isDefined(self.asmname))
    return 1;

  if(!isDefined(self._id_D773DD66BB9E0306))
    return 1;

  if(!isDefined(self._blackboard._id_7460B96395361857))
    return 1;

  return self.asmname != self._id_D773DD66BB9E0306;
}

_id_8F98221D71DAFE6E(param) {
  statename = "react";
  alias = scripts\asm\soldier\patrol::_id_A23A26ADCF97FDD0();
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(self._id_AE3EA15396B65C1F, statename, alias, 0);

  if(isDefined(_id_0EABF81B5BE8DDB5))
    return 1;

  return 0;
}

_id_CDC4CF4BA475C8C8(statename, params) {
  if(isDefined(self.stealth) && self._id_FE5EBEFA740C7106 != 0)
    return 1;

  return 0;
}

_id_C8C992472A4C0276(statename, params) {
  _id_010B6724C15A95E8::_id_B6AF4ADE50626E90();
}

_id_61CCC15CEF317B1F(statename, params) {
  self endon("interaction_end");
  self endon("death");
  self._blackboard._id_7460B96395361857 = "end";

  if(isDefined(self._id_D773DD66BB9E0306))
    self waittill("cap_exit_completed");
}