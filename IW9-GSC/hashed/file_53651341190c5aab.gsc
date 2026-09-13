/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_53651341190c5aab.gsc
***********************************************/

_id_72D72588305107B4(_id_F8D4ED108521E632) {
  self notify("interaction_started");
}

_id_8ADD99CB1B82B964(_id_F8D4ED108521E632) {
  self._id_7916F201EFB9963F = undefined;
  self._blackboard.idlenode = undefined;
  self._blackboard._id_C71A487341C700F3 = undefined;
}

_id_EFCEA5D26798E5B6(_id_CC4F2E0388379546) {
  switch (_id_CC4F2E0388379546) {
    case "start_cap":
      return::_id_29946584B628C719;
    case "set_bseq_phase":
      return::_id_606C28B248BADDFD;
    case "within_goal_dist":
      return::_id_A75E4EAF48401358;
    case "bseqUser_isBseqPhase":
      return::_id_75BDE4AB677D8C14;
    case "process_event":
      return::processevent;
    case "OnAddUser":
      return::_id_72D72588305107B4;
    case "OnDeleteUser":
      return::_id_8ADD99CB1B82B964;
    case "ShouldNotLoopEndlessly":
      return _id_4E1D4DD23699A8A4::_id_8439B78C94685919;
    case "UseCustomCurious":
      return::_id_5B942E48767AFEC7;
    case "IsInCombat":
      return::isincombat;
    case "ShouldReact":
      return::_id_BC0498B33398F0E9;
    case "InPlace":
      return::_id_327074D2913DE71D;
    case "UseCustomReact":
      return::_id_8F98221D71DAFE6E;
    case "CapToPatrolReact":
      return::_id_0D8786F820807C4F;
    case "IsFriendDown":
      return::_id_688018E12DB6E359;
  }
}

_id_606C28B248BADDFD(statename, params) {
  _id_72C614D54174DB7F = params[0];
  self._blackboard._id_7460B96395361857 = _id_72C614D54174DB7F;
}

_id_29946584B628C719(statename, params) {
  _id_996949B7474560EB = _func_A0CCCF0B4C466B2C(self, params[0]);
  _id_3E38EE41DC326FDC = _id_996949B7474560EB._id_3E38EE41DC326FDC;
  animset = _id_996949B7474560EB.animation;
  _id_BCF3C74B1D8B4883 = _id_996949B7474560EB._id_BCF3C74B1D8B4883;
  _id_842A67EE2435339D = _id_996949B7474560EB.initialstate;
  _id_127E00A9379F717C = _id_996949B7474560EB._id_BAD4F0BD11CBDCF9;
  interaction = spawnStruct();
  interaction.angles = self._blackboard._id_66C82B7660F29059;
  interaction.origin = self._blackboard._id_AD5EDA311C73F5D7;

  if(isDefined(self findoverridearchetype("default"))) {
    _id_051FB64C4BFCD847 = self findoverridearchetype("default") + "_cap_arrival";

    if(archetypehasstate(_id_3E38EE41DC326FDC, _id_051FB64C4BFCD847))
      _id_BCF3C74B1D8B4883 = _id_051FB64C4BFCD847;
  }

  if(isDefined(_id_842A67EE2435339D) && isDefined(_id_127E00A9379F717C)) {
    alias = archetypegetalias(animset, _id_842A67EE2435339D, _id_127E00A9379F717C, 0);
    animation = alias.anims;

    if(isarray(animation))
      animation = animation[0];

    originalangles = interaction.angles;
    originalorigin = interaction.origin;
    interaction.origin = getstartorigin(originalorigin, originalangles, animation);
    interaction.angles = getstartangles(originalorigin, originalangles, animation);
  }

  self._id_A70672E669CA7F00 = interaction.angles;
  self._id_718D80100704CC82 = getgroundposition(interaction.origin, 1);
  _id_010B6724C15A95E8::_id_E85F29F7EB1C5529(interaction, _id_3E38EE41DC326FDC, animset, _id_BCF3C74B1D8B4883);
}

_id_B76D8B8AD8E2C823(statename, params) {
  _id_996949B7474560EB = _func_A0CCCF0B4C466B2C(self, params[0]);
  _id_3E38EE41DC326FDC = _id_996949B7474560EB._id_3E38EE41DC326FDC;
  animset = _id_996949B7474560EB.animation;
  _id_BCF3C74B1D8B4883 = _id_996949B7474560EB._id_BCF3C74B1D8B4883;
  _id_842A67EE2435339D = _id_996949B7474560EB.initialstate;
  _id_127E00A9379F717C = _id_996949B7474560EB._id_BAD4F0BD11CBDCF9;
  interaction = spawnStruct();
  interaction.angles = self._blackboard._id_66C82B7660F29059;
  interaction.origin = self._blackboard._id_AD5EDA311C73F5D7;

  if(isDefined(self findoverridearchetype("default"))) {
    _id_051FB64C4BFCD847 = self findoverridearchetype("default") + "_cap_arrival";

    if(archetypehasstate(_id_3E38EE41DC326FDC, _id_051FB64C4BFCD847))
      _id_BCF3C74B1D8B4883 = _id_051FB64C4BFCD847;
  }

  if(isDefined(_id_842A67EE2435339D) && isDefined(_id_127E00A9379F717C)) {
    alias = archetypegetalias(animset, _id_842A67EE2435339D, _id_127E00A9379F717C, 0);
    animation = alias.anims;

    if(isarray(animation))
      animation = animation[0];

    originalangles = interaction.angles;
    originalorigin = interaction.origin;
    interaction.origin = getstartorigin(originalorigin, originalangles, animation);
    interaction.angles = getstartangles(originalorigin, originalangles, animation);
  }

  self._id_A70672E669CA7F00 = interaction.angles;
  self._id_718D80100704CC82 = interaction.origin;
  _id_010B6724C15A95E8::_id_C434AF0895CC147C(_id_3E38EE41DC326FDC, animset, 0);
  scripts\asm\asm::asm_fireephemeralevent("move", "end");
  self forceteleport(self._id_718D80100704CC82, self._id_A70672E669CA7F00, 2048);
}

_id_A75E4EAF48401358(statename, params) {
  _id_636C8575D7A7768B = params[0];

  if(self.pathpending)
    return 0;

  return self pathdisttogoal() <= _id_636C8575D7A7768B;
}

processevent(receiver, info, origin) {
  if(info == "relaxed")
    return 1;
  else if(info == "panicked" || info == "cower" || info == "scared" || info == "flee") {
    _id_4E1D4DD23699A8A4::_id_BF3D5AE7E2EEDA40();
    self._blackboard._id_7460B96395361857 = "exit";
  } else if(info == "curious") {
    self._blackboard._id_C71A487341C700F3 = self._blackboard._id_7460B96395361857;
    _id_2AA3F9382269A724 = self _meth_C0DE39048EEDDE94();

    if(_id_4E1D4DD23699A8A4::_id_F179EDE0989E6734("curious", "curious_anim")) {
      self._blackboard._id_7460B96395361857 = "curious";
      return 1;
    } else if(!_id_2AA3F9382269A724)
      return 1;
    else {
      _id_4E1D4DD23699A8A4::_id_BF3D5AE7E2EEDA40();
      self._blackboard._id_7460B96395361857 = "exit";
      return 0;
    }
  } else if(!isDefined(self._blackboard._id_7460B96395361857) || isDefined(self._blackboard._id_7460B96395361857) && self._blackboard._id_7460B96395361857 != "end") {
    self._blackboard._id_7460B96395361857 = "react";
    return 1;
  }

  return 0;
}

_id_75BDE4AB677D8C14(params) {
  if(isDefined(self._blackboard._id_7460B96395361857)) {
    if(self._blackboard._id_7460B96395361857 == params[0])
      return 1;
  }

  return 0;
}

empty(params) {}

_id_5B942E48767AFEC7(param) {
  statename = "curious";
  alias = "curious_anim";
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(self._id_AE3EA15396B65C1F, statename, alias, 0);

  if(isDefined(_id_0EABF81B5BE8DDB5))
    return 1;

  return 0;
}

isincombat(statename, params) {
  return self.bisincombat;
}

_id_BC0498B33398F0E9(params) {
  return self _meth_A4A9E73B2D25FF8B();
}

_id_327074D2913DE71D(statename, params) {
  self._blackboard._id_F725B0BB1F8D27EE = 1;
  _id_F8D4ED108521E632 = self _meth_92435C7A6AE85C3C();
  _id_C2A860252B030C52(_id_F8D4ED108521E632);
}

_id_25C933655D73066A(_id_F8D4ED108521E632) {
  repulsorname = _id_D980C506B2F1A19B(_id_F8D4ED108521E632);
  destroynavrepulsor(repulsorname);
}

_id_D980C506B2F1A19B(_id_F8D4ED108521E632) {
  return "civilian_interaction_" + _id_F8D4ED108521E632;
}

_id_C2A860252B030C52(_id_F8D4ED108521E632) {
  _id_36B6C21725713470 = _func_ADF0D34FF483C35A(_id_F8D4ED108521E632);

  if(_id_36B6C21725713470.size == 0) {
    return;
  }
  _id_97E5D2C62501499E = [];

  foreach(_id_6BEFFE9C75D5E9A3 in _id_36B6C21725713470) {
    if(_id_6BEFFE9C75D5E9A3._blackboard._id_F725B0BB1F8D27EE)
      _id_97E5D2C62501499E[_id_97E5D2C62501499E.size] = _id_6BEFFE9C75D5E9A3;
  }

  if(_id_97E5D2C62501499E.size == 0) {
    return;
  }
  circleorigin = (0, 0, 0);
  circleradius = 0;

  if(_id_97E5D2C62501499E.size == 1) {
    circleorigin = _id_97E5D2C62501499E[0].origin;
    circleradius = 15;
  } else if(_id_97E5D2C62501499E.size >= 2) {
    _id_3C590D0EE220B409 = _id_97E5D2C62501499E[0].origin[0];
    _id_C978C90E8E5AB1F7 = _id_97E5D2C62501499E[0].origin[0];
    _id_3C590C0EE220B1D6 = _id_97E5D2C62501499E[0].origin[1];
    _id_C978C80E8E5AAFC4 = _id_97E5D2C62501499E[0].origin[1];

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_97E5D2C62501499E.size; _id_AC0E594AC96AA3A8++) {
      _id_5D8D3F6A643B89ED = _id_97E5D2C62501499E[_id_AC0E594AC96AA3A8].origin;

      if(_id_5D8D3F6A643B89ED[0] < _id_3C590D0EE220B409)
        _id_3C590D0EE220B409 = _id_5D8D3F6A643B89ED[0];
      else if(_id_5D8D3F6A643B89ED[0] > _id_C978C90E8E5AB1F7)
        _id_C978C90E8E5AB1F7 = _id_5D8D3F6A643B89ED[0];

      if(_id_5D8D3F6A643B89ED[1] < _id_3C590C0EE220B1D6) {
        _id_3C590C0EE220B1D6 = _id_5D8D3F6A643B89ED[1];
        continue;
      }

      if(_id_5D8D3F6A643B89ED[1] > _id_C978C80E8E5AAFC4)
        _id_C978C80E8E5AAFC4 = _id_5D8D3F6A643B89ED[1];
    }

    circleorigin = ((_id_C978C90E8E5AB1F7 + _id_3C590D0EE220B409) / 2, (_id_C978C80E8E5AAFC4 + _id_3C590C0EE220B1D6) / 2, 0);
    _id_1E5E9F053774BCB3 = 0;
    _id_A1F8512FCBA75B7F = 0;

    foreach(_id_EEE718E33217DC9E in _id_97E5D2C62501499E) {
      _id_A1F8512FCBA75B7F = _id_A1F8512FCBA75B7F + _id_EEE718E33217DC9E.origin[2];
      _id_289872F1C7A48D0F = distance2dsquared(circleorigin, _id_EEE718E33217DC9E.origin);

      if(_id_289872F1C7A48D0F > _id_1E5E9F053774BCB3)
        _id_1E5E9F053774BCB3 = _id_289872F1C7A48D0F;
    }

    _id_A1F8512FCBA75B7F = _id_A1F8512FCBA75B7F / _id_97E5D2C62501499E.size;
    circleorigin = circleorigin + (0, 0, _id_A1F8512FCBA75B7F);
    circleradius = sqrt(_id_1E5E9F053774BCB3) + 24;
  }

  repulsorname = _id_D980C506B2F1A19B(_id_F8D4ED108521E632);
  destroynavrepulsor(repulsorname);
  createnavrepulsor(repulsorname, -1, circleorigin, circleradius, 0, "all");
}

_id_8F98221D71DAFE6E(param) {
  statename = "react";
  alias = "8";
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(self._id_AE3EA15396B65C1F, statename, alias, 0);

  if(isDefined(_id_0EABF81B5BE8DDB5))
    return 1;

  return 0;
}

_id_0D8786F820807C4F(statename, params) {
  _id_9B1941CB7354665E = "custom_patrol_lookaround_passthrough";

  if(!isDefined(params[0])) {
    _id_9B1941CB7354665E = "stl_react_passthrough";

    if(!isDefined(self._id_FD01AD49B4E38AE8))
      self._id_FD01AD49B4E38AE8 = "med";
  }

  if(self asmhasstate(self.asmname, _id_9B1941CB7354665E))
    self asmsetstate(self.asmname, _id_9B1941CB7354665E);
}

_id_688018E12DB6E359(param) {
  statename = "friend_down";
  alias = "friend_down_anim";
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(self._id_AE3EA15396B65C1F, statename, alias, 0);

  if(!isDefined(_id_0EABF81B5BE8DDB5))
    return 0;

  if(!isDefined(self._blackboard._id_7460B96395361857))
    return 0;

  return self._blackboard._id_7460B96395361857 == "friend_down";
}