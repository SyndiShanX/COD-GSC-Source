/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_67015c88c47ec4f8.gsc
***********************************************/

_id_8BFEA85875208730() {
  thread _id_78E92E0D2C1AD4A0();
  thread _id_239121F5ED13AA9E();
  thread _id_B72324B3D1D917D9();
  thread _id_C7E19922AB223B93();
}

_id_3EFECEF2C469DFCA(_id_8A127DE2EC4F8B49) {
  thread _id_7C03AB87C5F9F420::_id_3EDE6B66136C0F93(_id_8A127DE2EC4F8B49);
}

_id_7407394BA40E686B() {
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("dmz_disguise_destroyed", [self]);
}

_id_78E92E0D2C1AD4A0() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("disconnect");
  self waittill("death");
  self notify("disguise_state_change", "death");
}

_id_239121F5ED13AA9E() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("death_or_disconnect");
  childthread _id_F5E4AA8637AFB835();
}

_id_3FB0CB7D9A396243() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_fired");

    if(_id_026B13DC209DEDBE()) {
      self notify("disguise_state_change", "combat");
      break;
    } else
      waitframe();
  }
}

_id_026B13DC209DEDBE() {
  _id_674DAAFFFC0AACF3 = _id_7C03AB87C5F9F420::_id_BC96CF8A43C99435();

  foreach(agent in _id_674DAAFFFC0AACF3) {
    if(agent cansee(self)) {
      agent setthreatsight(self, 1.0);
      agent _meth_68F50ADA6E19D8F4(self.origin, "med");

      if(istrue(agent.stealth_enabled))
        agent setstealthstate("combat");

      return 1;
    }
  }

  return 0;
}

_id_F5E4AA8637AFB835() {
  level endon("game_ended");
  self endon("disguise_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("grenade_thrown", grenade);
    _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(grenade.weapon_object);
    _id_0D68C5A87FF60523 = 1;

    if(_id_0EC0D05AC91AB5D4(_id_49E6EF3EDADD524E))
      _id_0D68C5A87FF60523 = 0;
    else
      _id_0D68C5A87FF60523 = _id_026B13DC209DEDBE();

    if(_id_0D68C5A87FF60523) {
      self notify("disguise_state_change", "combat");
      break;
    }

    waitframe();
  }
}

_id_FB972C00E1D438A4(_id_49E6EF3EDADD524E) {
  switch (_id_49E6EF3EDADD524E) {
    case "sound_veil":
    case "tac_ops_spawn_grenade":
    case "deployed_decoy":
    case "decoy_grenade":
    case "emp_grenade":
    case "concussion_grenade":
    case "shuriken":
    case "gas":
    case "at_mine":
    case "claymore":
    case "shock_stick":
    case "snapshot_grenade":
    case "smoke_grenade":
    case "throwstar":
    case "throwingknife":
    case "c4":
      return 1;
    default:
      return 0;
  }
}

_id_0EC0D05AC91AB5D4(_id_49E6EF3EDADD524E) {
  switch (_id_49E6EF3EDADD524E) {
    case "decon_station":
    case "reinforcement_flare":
    case "sonar_pulse":
    case "tac_camera":
    case "deployable_kiosk_marker_mp":
    case "advanced_supply_drop_marker":
    case "flare":
    case "tac_cover":
    case "leader_box":
    case "armor_box":
    case "ammo_box":
    case "offhand_spotter_scope":
    case "thermal_phone":
    case "geiger_counter":
    case "flare_dmz_pmc":
    case "trophy":
    case "iodine_pills":
    case "hb_sensor":
    case "blastshield_box":
    case "deploy_loadout_drop":
    case "deploy_weapondrop":
      return 1;
    default:
      return 0;
  }
}

_id_B72324B3D1D917D9() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("disguise_ended");

  for(;;) {
    self waittill("disguise_state_change", _id_B400931C07D29AD6);

    if(_id_1A0072FD9FEEF602(_id_B400931C07D29AD6)) {
      _id_8A127DE2EC4F8B49 = _id_B400931C07D29AD6 == "damaged";

      if(_id_B400931C07D29AD6 == "damaged" || _id_B400931C07D29AD6 == "combat")
        thread _id_0FCC882AC112294D();

      _id_3EFECEF2C469DFCA(_id_8A127DE2EC4F8B49);
      break;
    }
  }
}

_id_1A0072FD9FEEF602(_id_A18CCFA1C7D59163) {
  if(!isDefined(_id_A18CCFA1C7D59163))
    return 0;

  switch (_id_A18CCFA1C7D59163) {
    case "end_disguise":
    case "last_stand":
      return 1;
    default:
      return 0;
  }
}

_id_43207FFC5E843003() {
  if(!isDefined(self))
    return 0;

  if(isnullweapon(self.currentweapon) || !isDefined(self.currentweapon))
    return 0;

  if(scripts\mp\utility\player::isincombat())
    return 0;

  if(!scripts\mp\utility\player::isreallyalive(self))
    return 0;

  if(scripts\mp\utility\player::isinlaststand(self))
    return 0;
  else
    return _id_5A56D6ECB885EC19();
}

_id_25E7A6883C64324C() {
  if(isnullweapon(self.currentweapon) || !isDefined(self.currentweapon))
    return 0;

  return 1;
}

_id_15E7A42C79A6B4F6(damage, attacker) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("disguise_ended");
  thread _id_0FCC882AC112294D();
  _id_B47E8230E27E8A6A = _id_34E1DF38DEA3E196(damage);
  _id_8C0F3022529BE75E = _id_7C03AB87C5F9F420::_id_3275D6441A8E838A();
  _id_9511FFFEC55BA283 = _id_8C0F3022529BE75E.health;
  _id_EDF34A99C4635317 = _id_9511FFFEC55BA283 - damage;
  _id_EDF34A99C4635317 = int(clamp(_id_EDF34A99C4635317, 0, 108));
  _id_8C0F3022529BE75E.health = _id_EDF34A99C4635317;
  _id_2D9D24F7C63AC143::_id_E900E7E66383AD97(self, _id_8C0F3022529BE75E._id_EBBCB5A184F5C67B, _id_EDF34A99C4635317, 0);
  _id_BA24FD4FF7AC5DD7 = scripts\engine\utility::ter_op(_id_EDF34A99C4635317 == 0, "end_disguise", "damaged");
  self notify("disguise_state_change", _id_BA24FD4FF7AC5DD7);

  if(_id_BA24FD4FF7AC5DD7 == "end_disguise")
    scripts\engine\utility::delaythread(getdvarfloat("dvar_307D1884BCAEF28F", 0.45), ::_id_7407394BA40E686B);
}

_id_34E1DF38DEA3E196(damage) {
  return damage;
}

_id_0FCC882AC112294D(cooldowntime) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("killed_player");
  self notify("disguise_cooldown_start");
  self notify("disguise_cooldown_start");

  if(!isDefined(cooldowntime))
    cooldowntime = 5.0;

  self._id_EF8C89617046F3B7 = 1;
  counter = 0;

  while(counter < cooldowntime) {
    if(scripts\mp\utility\player::isincombat())
      counter = 0;
    else
      counter = counter + level.framedurationseconds;

    waitframe();
  }

  self._id_EF8C89617046F3B7 = undefined;
}

_id_5A56D6ECB885EC19() {
  if(!isDefined(self.lastdamagedtime))
    return 1;
  else {
    currenttime = gettime();
    _id_47AED03FF4CCD04E = (currenttime - self.lastdamagedtime) / 1000;

    if(_id_47AED03FF4CCD04E <= 5.0)
      return 0;

    return 1;
  }
}

_id_C7E19922AB223B93() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("disguise_ended");

  for(;;) {
    self waittill("execution_begin");
    _id_7C03AB87C5F9F420::_id_890834271F0A6FC5();
  }
}

_id_DF0FE5AC51164868(event) {}