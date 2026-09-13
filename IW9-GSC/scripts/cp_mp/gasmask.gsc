/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\gasmask.gsc
***********************************************/

init(gasmaskhealth, gasmasktype) {
  _id_00E7CDF2F6D8FEB3 = 2;

  if(isDefined(gasmasktype)) {
    if(gasmasktype == "brloot_equip_gasmask_scuba") {
      _id_00E7CDF2F6D8FEB3 = 4;
      self._id_5239162658BE30D6 = 1;

      if(self _meth_6F55D55CCFF20D14())
        scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "updateScubaGasmask", self, 1);
    } else {
      if(istrue(self._id_5239162658BE30D6)) {
        self._id_5239162658BE30D6 = undefined;
        scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "updateScubaGasmask", self, 0);
      }

      if(gasmasktype == "brloot_equip_gasmask_durable")
        _id_00E7CDF2F6D8FEB3 = 3;
    }
  } else
    self._id_5239162658BE30D6 = undefined;

  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

  if(!isDefined(level.gasmask_resist)) {
    if(_id_E005D4B70D6F2611)
      level.gasmask_resist = getdvarfloat("dvar_3DDD1D0A30B7B07C", 0);
    else
      level.gasmask_resist = 0.2;
  }

  maxhealth = _id_894ADF8CE12D224D(gasmasktype);
  self.gasmaskhealth = maxhealth;
  self.gasmaskmaxhealth = maxhealth;
  self.gasmasktype = gasmasktype;

  if(istrue(self._id_5239162658BE30D6))
    thread scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("scubaGasMask", "monitorScubaGasMaskDamage");

  if(isDefined(gasmaskhealth))
    self.gasmaskhealth = gasmaskhealth;

  if(_id_E005D4B70D6F2611)
    level.gasmaskhealthperpip = self.gasmaskhealth / 6;

  level.gasmaskmaxhealth = maxhealth;
  self setclientomnvar("ui_head_equip_class", _id_00E7CDF2F6D8FEB3);
  self setclientomnvar("ui_gasmask_damage", self.gasmaskhealth / maxhealth);
}

_id_894ADF8CE12D224D(_id_1680A35FE50DC05E) {
  maxhealth = undefined;

  if(isDefined(_id_1680A35FE50DC05E)) {
    _id_0D7254484F0BD62F = level.br_pickups.counts[_id_1680A35FE50DC05E];

    if(isDefined(_id_0D7254484F0BD62F))
      maxhealth = _id_0D7254484F0BD62F;
    else {
      switch (_id_1680A35FE50DC05E) {
        case "brloot_equip_gasmask_durable":
          maxhealth = 216;
          break;
        default:
          break;
      }
    }
  }

  if(!isDefined(maxhealth)) {
    _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

    if(_id_E005D4B70D6F2611)
      maxhealth = getdvarint("dvar_ACAD4FF93022FF44", 108);
    else
      maxhealth = 180;
  }

  return maxhealth;
}

_id_D855F39E2B239317(_id_D5F96A53F7F4002E) {
  _id_1680A35FE50DC05E = undefined;

  switch (_id_D5F96A53F7F4002E) {
    case "gas_mask":
    case "gas_mask_mobile":
    case "brloot_equip_gasmask":
      _id_1680A35FE50DC05E = "brloot_equip_gasmask";
      break;
    case "brloot_equip_gasmask_durable":
      _id_1680A35FE50DC05E = "brloot_equip_gasmask_durable";
      break;
    default:
      break;
  }

  return _id_1680A35FE50DC05E;
}

processdamage(damage) {
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();
  _id_C8898166AD0DCCC9 = self.gasmaskhealth / self.gasmaskmaxhealth;
  self.gasmaskhealth = self.gasmaskhealth - damage;
  self.gasmaskhealth = max(0, self.gasmaskhealth);

  if(_id_E005D4B70D6F2611)
    _id_B8B6FA3D6F2F0B8C = (self.gasmaskhealth + 1) / self.gasmaskmaxhealth;
  else
    _id_B8B6FA3D6F2F0B8C = self.gasmaskhealth / self.gasmaskmaxhealth;

  _id_B8B6FA3D6F2F0B8C = clamp(_id_B8B6FA3D6F2F0B8C, 0.0, 1.0);
  self setclientomnvar("ui_gasmask_damage", _id_B8B6FA3D6F2F0B8C);

  if(self.gasmaskhealth <= 0) {
    if(_id_E005D4B70D6F2611 && scripts\cp_mp\utility\script_utility::issharedfuncdefined("gasmask", "breakGasMaskBR"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("gasmask", "breakGasMaskBR")]]();
    else
      breakgasmask();
  } else if(_id_E005D4B70D6F2611) {
    _id_D89463B5F4F6BE0C = floor(_id_C8898166AD0DCCC9 * 6 + 0.5);
    _id_14642D90CC419FF7 = floor(_id_B8B6FA3D6F2F0B8C * 6 + 0.5);

    if(_id_D89463B5F4F6BE0C > _id_14642D90CC419FF7)
      self playsoundtoplayer("br_gas_mask_crack_plr", self);
  }

  if(!isDefined(self.gasdamagebuffer))
    self.gasdamagebuffer = 0;

  self.gasdamagebuffer = self.gasdamagebuffer + damage * level.gasmask_resist;
  _id_DEAA0150BED01750 = floor(self.gasdamagebuffer);

  if(_id_DEAA0150BED01750 >= 1) {
    self dodamage(_id_DEAA0150BED01750, self.origin, self, undefined, "MOD_TRIGGER_HURT");
    self.gasdamagebuffer = self.gasdamagebuffer - _id_DEAA0150BED01750;
  }
}

didgasmaskpipschange(_id_6DA37E0E07826838, _id_EDF34A99C4635317) {
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]();

  if(!_id_E005D4B70D6F2611)
    return 0;

  if(!isDefined(self.gasmaskmaxhealth))
    self.gasmaskmaxhealth = getdvarint("dvar_ACAD4FF93022FF44", 108);

  _id_0BB4C61422137BF8 = _id_6DA37E0E07826838 / self.gasmaskmaxhealth;
  _id_6A0FB9554998A6CF = _id_EDF34A99C4635317 / self.gasmaskmaxhealth;
  _id_D89463B5F4F6BE0C = floor(_id_0BB4C61422137BF8 * 6 + 0.5);
  _id_14642D90CC419FF7 = floor(_id_6A0FB9554998A6CF * 6 + 0.5);
  return _id_D89463B5F4F6BE0C != _id_14642D90CC419FF7;
}

equipgasmask() {
  self endon("death_or_disconnect");
  self playsoundtoplayer("br_gas_mask_on_plr", self);
  _id_13516EF685B23D13 = makeweapon("none");
  _id_04A8F5643E919524 = self getcurrentweapon();

  if(!issameweapon(_id_04A8F5643E919524, _id_13516EF685B23D13)) {
    if(scripts\common\utility::iscp())
      self forceplaygestureviewmodel("ges_magma_gas_mask_on");
    else
      self forceplaygestureviewmodel("ges_visor_down");
  }

  self.gasmaskswapinprogress = 1;
  wait 0.338;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 1;
  scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
  self attach("hat_gasmask");
  createoverlay();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("gasmask_female");
  else
    self _meth_555E2D32E2756625("gasmask_male");
}

removegasmask() {
  self endon("death_or_disconnect");

  if(!istrue(self.gasmaskequipped)) {
    return;
  }
  self playsoundtoplayer("br_gas_mask_off_plr", self);
  _id_13516EF685B23D13 = makeweapon("none");
  _id_04A8F5643E919524 = self getcurrentweapon();

  if(!issameweapon(_id_04A8F5643E919524, _id_13516EF685B23D13)) {
    if(scripts\common\utility::iscp())
      self forceplaygestureviewmodel("ges_magma_gas_mask_off");
    else
      self forceplaygestureviewmodel("ges_visor_up");
  }

  self.gasmaskswapinprogress = 1;
  wait 0.521;
  self.gasmaskswapinprogress = 0;
  self.gasmaskequipped = 0;
  scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();
  self detach("hat_gasmask");
  destroyoverlay();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355")
    self _meth_555E2D32E2756625("gasmask_female");
  else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319")
    self setentitysoundcontext("gender", "bongmask_male");
  else
    self _meth_555E2D32E2756625("");
}

breakgasmask() {
  if(!istrue(self.gasmaskequipped)) {
    return;
  }
  self.gasmaskequipped = 0;
  self playsoundtoplayer("br_gas_mask_break_plr", self);
  self detach("hat_gasmask");
  destroyoverlay();

  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355")
    self _meth_555E2D32E2756625("gasmask_female");
  else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("female");
  else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319")
    self setentitysoundcontext("gender", "bongmask_male");
  else
    self _meth_555E2D32E2756625("");

  self playsoundtoplayer("br_gas_mask_depleted_plr", self);
  self setclientomnvar("ui_head_equip_class", 0);
  self setclientomnvar("ui_gasmask_damage", 0);
}

createoverlay(_id_EE006CF398BCD8FD, _id_74B5B12BB6514385) {
  self.gasmaskoverlay = newclienthudelem(self);
  self.gasmaskoverlay.x = 0;
  self.gasmaskoverlay.y = 0;
  self.gasmaskoverlay.alignx = "left";
  self.gasmaskoverlay.aligny = "top";
  self.gasmaskoverlay.horzalign = "fullscreen";
  self.gasmaskoverlay.vertalign = "fullscreen";
  self.gasmaskoverlay setshader("gasmask_overlay_delta2", 640, 480);
  self.gasmaskoverlay.sort = -10;
  self.gasmaskoverlay.archived = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
      self.gasmaskoverlay.alpha = 0.0;

      if(isDefined(_id_EE006CF398BCD8FD)) {
        if(isDefined(_id_74B5B12BB6514385))
          wait(_id_74B5B12BB6514385);

        if(isDefined(self.gasmaskoverlay))
          self.gasmaskoverlay fadeovertime(_id_EE006CF398BCD8FD);
      }
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay.alpha = 1.0;
    self.gasmaskoverlay.lowresbackground = 1;
  }
}

setbrokenoverlaymaterial() {
  if(isDefined(self.gasmaskoverlay))
    self.gasmaskoverlay setshader("gasmask_overlay_delta2_broken", 640, 480);
}

fadeoutoverlay(_id_C8FE6E3CA9715960) {
  self.gasmaskoverlay.alpha = 1.0;
  self.gasmaskoverlay fadeovertime(_id_C8FE6E3CA9715960);
  self.gasmaskoverlay.alpha = 0.0;
}

destroyoverlay(_id_C8FE6E3CA9715960, _id_74B5B12BB6514385) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isDefined(self.gasmaskoverlay)) {
    return;
  }
  if(isDefined(_id_C8FE6E3CA9715960)) {
    if(isDefined(_id_74B5B12BB6514385))
      wait(_id_74B5B12BB6514385);

    if(isDefined(self.gasmaskoverlay)) {
      fadeoutoverlay(_id_C8FE6E3CA9715960);
      wait(_id_C8FE6E3CA9715960);
    }
  }

  if(isDefined(self.gasmaskoverlay)) {
    self.gasmaskoverlay destroy();
    self.gasmaskoverlay = undefined;
  }
}

hasgasmask(player) {
  return isDefined(player.gasmaskhealth);
}

_id_260708C89A11F0C3(player) {
  return istrue(player.gasmaskequipped);
}