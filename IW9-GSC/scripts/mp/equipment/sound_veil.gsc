/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\sound_veil.gsc
***********************************************/

_id_735ED2B006DCE0EB() {}

_id_06D91F8514005D18(grenade) {
  grenade endon("death");
  self endon("disconnect");

  if(!isDefined(level._id_4405E76242D7CB8E))
    level._id_4405E76242D7CB8E = 0;

  grenade scripts\cp_mp\ent_manager::registerspawn(1, ::_id_558D562EB33EA61D);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto) && stuckto scripts\cp_mp\vehicles\vehicle::isvehicle())
    grenade._id_37A6165D55074798 = 1;

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      scripts\mp\supers::refundsuper();
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      grenade delete();
      return;
    }
  }

  grenade setscriptablepartstate("plant", "active", 0);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade setnonstick(1);
  grenade.issuper = 1;
  grenade.superid = level.superglobals.staticsuperdata["super_sound_veil"].id;
  grenade.usedcount = 0;
  grenade.deployingplayer = self;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, undefined, 1);
  grenade._id_89EE7EBA7B1862CF = [];
  trigger = spawn("trigger_rotatable_radius", grenade.origin, 0, 80, 300);
  trigger.angles = grenade.angles;
  grenade.trigger = trigger;
  trigger enablelinkTo();
  trigger linkTo(grenade);
  _id_307667D0142F2035 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");
  scripts\mp\weapons::onequipmentplanted(grenade, "sound_veil_mp", ::_id_558D562EB33EA61D);
  level thread scripts\mp\weapons::monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  maxhealth = scripts\engine\utility::ter_op(_id_307667D0142F2035, 150, 100);
  grenade thread scripts\mp\damage::monitordamage(maxhealth, "hitequip", ::_id_F313405D166290BE, ::_id_50B1D2352A6A686A, 0);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::_id_B434EA15774ED770);
  grenade _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_391EBDDE9E0EEC71);
  grenade _id_49197CD063A740EA(::_id_558D562EB33EA61D);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
  }

  grenade _id_74844A68121C9B36();
  scripts\cp_mp\challenges::_id_D997435895422ECC("super_sound_veil", 0);
}

_id_7A9D11F284EB6BC3(timeout) {
  self endon("destroyed");
  self notify("reset_timeout");
  self endon("reset_timeout");
  level endon("game_ended");
  result = scripts\engine\utility::waittill_any_timeout_1(timeout, "death");
  _id_558D562EB33EA61D();
}

_id_95A96C443AC9EA46(player) {
  self endon("death");
  self endon("destroyed");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = scripts\engine\utility::waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }
  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  _id_3A7F0173B03F5767 = -2000.0;
  _id_8B39E5984DA1FFAF = self.origin + (0.0, 0.0, _id_3A7F0173B03F5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, _id_FBCABD62B8F66EB8);
  groundentity = traceresults["entity"];

  if(isDefined(groundentity)) {
    if(scripts\cp_mp\utility\train_utility::is_train_ent(groundentity)) {
      self.origin = self.origin + (0, 0, 1.6);
      self linkTo(groundentity);
    }
  }
}

_id_50B1D2352A6A686A(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\damage::handlemeleedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);

  if(!isagent(attacker))
    scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, type);

  return _id_702BFC08FABD86CB;
}

_id_F313405D166290BE(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_FC93A01157648DCC");
  }

  _id_558D562EB33EA61D(data);
}

_id_558D562EB33EA61D(data) {
  if(!isDefined(self)) {
    return;
  }
  _id_FFE0D0BDD9BD7D44 = 0;

  if(isDefined(data) && isDefined(data.attacker)) {
    _id_FFE0D0BDD9BD7D44 = 1;
    _id_7C9D9F1CA399B82C(data.attacker);
  }

  if(isDefined(self.headiconid))
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);

  if(isDefined(self.navobstacle))
    destroynavobstacle(self.navobstacle);

  _id_77BBCE9593E3B2CC();
  thread _id_053B79C2279DC402(_id_FFE0D0BDD9BD7D44);
  self setscriptablepartstate("activate", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
  self notify("destroyed");
}

_id_053B79C2279DC402(_id_4FAC8B8CE36E09F1) {
  self endon("death");

  if(!isDefined(self)) {}

  self.exploding = 1;

  if(isDefined(self.trigger))
    self.trigger delete();

  if(isDefined(self.owner) && !isagent(self.owner)) {
    self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_sound_veil", 3, self.usedcount);
    scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(_id_4FAC8B8CE36E09F1));
    self.owner scripts\mp\weapons::removeequip(self);
  }

  wait 2;
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self))
    self delete();
}

_id_7C9D9F1CA399B82C(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }
}

_id_B434EA15774ED770(data) {
  if(!isDefined(data) || !isDefined(data.victim)) {
    return;
  }
  data.victim endon("death");
  data.victim endon("destroyed");
  data.victim setscriptablepartstate("empd", "active", 0);
  data.victim _id_3E3BA6DFDEA9465B();
  wait 6.0;
  data.victim setscriptablepartstate("empd", "neutral", 0);
  data.victim _id_74844A68121C9B36();
}

_id_391EBDDE9E0EEC71(data) {
  _id_558D562EB33EA61D(data);
}

_id_74844A68121C9B36() {
  self notify("enable_super_sound_veil");
  self setscriptablepartstate("arm", "active", 0);

  if(!istrue(self._id_EEC43B28DF0BC8D6)) {
    _id_20F555E2261730D5 = 60;

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      _id_20F555E2261730D5 = 480;

    _id_38A6B48A5F70C0B8 = getdvarint("dvar_AA851E1CD1444734", 0);

    if(_id_38A6B48A5F70C0B8 > 0)
      _id_20F555E2261730D5 = _id_38A6B48A5F70C0B8;

    thread _id_7A9D11F284EB6BC3(_id_20F555E2261730D5);
  }

  if(istrue(self.triggered))
    self setscriptablepartstate("activate", "active", 0);

  thread _id_CAAB3D73A9D2B003();
  self._id_EEC43B28DF0BC8D6 = 1;
}

_id_CAAB3D73A9D2B003() {
  self endon("death");
  self endon("destroyed");
  self endon("disable_super_sound_veil");
  level endon("game_ended");
  self._id_B8117F3DCA9B4070 = [];

  for(;;) {
    self.trigger waittill("trigger", _id_CA79210CD76FADA3);

    if(isagent(_id_CA79210CD76FADA3) && !scripts\engine\utility::array_contains(self._id_B8117F3DCA9B4070, _id_CA79210CD76FADA3)) {
      self._id_B8117F3DCA9B4070[self._id_B8117F3DCA9B4070.size] = _id_CA79210CD76FADA3;
      _id_CA79210CD76FADA3 _id_13D1C402F1421C35::flashbangstart(3);
    }

    if(!istrue(self.triggered)) {
      if(!_id_2567C5FFAE3AA0CC(_id_CA79210CD76FADA3)) {
        continue;
      }
      self.triggered = 1;
      thread _id_7A9D11F284EB6BC3(20);
      self setscriptablepartstate("trigger", "active", 0);
      wait 0.35;
      self setscriptablepartstate("activate", "active", 0);
      scripts\mp\shellshock::grenade_earthquakeatposition(self.origin, 0.25);

      if(!isDefined(self._id_37A6165D55074798) && !isDefined(self.navobstacle)) {
        _id_E86FD4EA1AC5C77A = 150.0;
        _id_11234F42CB6A6DD2 = 20.0;
        _id_195A2ED93E9EAEF9 = anglestoup(self.angles);
        _id_D5DD171F21B7DACA = self.origin + _id_195A2ED93E9EAEF9 * _id_E86FD4EA1AC5C77A - _id_195A2ED93E9EAEF9 * _id_11234F42CB6A6DD2;
        self.navobstacle = createnavbadplacebyshape(_id_D5DD171F21B7DACA, self.angles, 8, 90, _id_E86FD4EA1AC5C77A + 40);
      }

      continue;
    }

    _id_FFB333A3A7D50710(_id_CA79210CD76FADA3);
  }
}

_id_2567C5FFAE3AA0CC(_id_BD73C7ACC56CD20C) {
  if(_id_BD73C7ACC56CD20C scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(!isDefined(_id_BD73C7ACC56CD20C.streakinfo)) {
      vehicle = _id_BD73C7ACC56CD20C;
      vehicleoccupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);
      _id_7F22902F9E860F6A = 0;

      if(isDefined(vehicleoccupants) && vehicleoccupants.size > 0) {
        foreach(_id_F85572CD5F6117C6 in vehicleoccupants) {
          if(!_id_BD10B05C42BB5432(_id_F85572CD5F6117C6, 1)) {
            continue;
          }
          _id_7F22902F9E860F6A = 1;
          break;
        }
      }

      if(!istrue(_id_7F22902F9E860F6A))
        return 0;
    } else
      return 0;
  } else if(!_id_BD10B05C42BB5432(_id_BD73C7ACC56CD20C))
    return 0;

  return 1;
}

_id_BD10B05C42BB5432(_id_BD73C7ACC56CD20C, _id_C21CBB75E13200D4, _id_E6C0B49674829EF4) {
  if(!_id_FB91AC0D17CE422E(_id_BD73C7ACC56CD20C, _id_E6C0B49674829EF4))
    return 0;

  if(_id_8BE3970B7E22CB24(_id_BD73C7ACC56CD20C))
    return 0;

  if(!_id_669BD251F952DB32(_id_BD73C7ACC56CD20C) && !istrue(_id_C21CBB75E13200D4))
    return 0;

  if(!_id_47BBA92311467CA4(_id_BD73C7ACC56CD20C))
    return 0;

  return 1;
}

_id_8BE3970B7E22CB24(_id_BD73C7ACC56CD20C) {
  return istrue(_id_BD73C7ACC56CD20C._id_BAF99FF6E658C413);
}

_id_669BD251F952DB32(_id_BD73C7ACC56CD20C) {
  return _id_BD73C7ACC56CD20C sightconetrace(self.origin, self) > 0;
}

_id_47BBA92311467CA4(_id_BD73C7ACC56CD20C) {
  if((isPlayer(_id_BD73C7ACC56CD20C) || isagent(_id_BD73C7ACC56CD20C)) && _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::isinvehicle())
    _id_BD73C7ACC56CD20C = _id_BD73C7ACC56CD20C scripts\cp_mp\utility\player_utility::getvehicle();

  if(!_id_BD73C7ACC56CD20C istouching(self.trigger))
    return 0;

  return 1;
}

_id_B6727D48164BA951(_id_BD73C7ACC56CD20C, _id_E6C0B49674829EF4, _id_4A6A11A4F1E2C293) {
  if(!scripts\mp\utility\player::isreallyalive(_id_BD73C7ACC56CD20C))
    return 0;

  if(istrue(level.teambased)) {
    if(_id_BD73C7ACC56CD20C.team == self.owner.team) {
      if(_id_BD73C7ACC56CD20C == self.owner) {
        if(istrue(_id_E6C0B49674829EF4) || istrue(_id_4A6A11A4F1E2C293))
          return 1;
      }
    } else
      return 1;
  } else if(_id_BD73C7ACC56CD20C == self.owner) {
    if(istrue(_id_E6C0B49674829EF4) || istrue(_id_4A6A11A4F1E2C293))
      return 1;
  } else
    return 1;

  return 0;
}

_id_A5A768EC20759F3D(_id_BD73C7ACC56CD20C) {
  if(isDefined(_id_BD73C7ACC56CD20C.agent_type) && issubstr(_id_BD73C7ACC56CD20C.agent_type, "civilian"))
    return 0;

  if(isDefined(_id_BD73C7ACC56CD20C.team) && _id_BD73C7ACC56CD20C.team == self.owner.team)
    return 0;

  return 1;
}

_id_FB91AC0D17CE422E(_id_BD73C7ACC56CD20C, _id_E6C0B49674829EF4) {
  _id_4A6A11A4F1E2C293 = 0;

  if(!isDefined(_id_BD73C7ACC56CD20C))
    return 0;

  if(isPlayer(_id_BD73C7ACC56CD20C) && !_id_B6727D48164BA951(_id_BD73C7ACC56CD20C, _id_E6C0B49674829EF4, _id_4A6A11A4F1E2C293))
    return 0;

  if(isagent(_id_BD73C7ACC56CD20C) && !_id_A5A768EC20759F3D(_id_BD73C7ACC56CD20C))
    return 0;

  return 1;
}

_id_FFB333A3A7D50710(_id_8483C4E961406C32) {
  _id_0C8D9F540BEE26B9 = [];

  if(_id_8483C4E961406C32 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    if(!isDefined(_id_8483C4E961406C32.streakinfo)) {
      vehicleoccupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(_id_8483C4E961406C32);

      if(isDefined(vehicleoccupants) && vehicleoccupants.size > 0) {
        foreach(_id_F85572CD5F6117C6 in vehicleoccupants) {
          if(_id_BD10B05C42BB5432(_id_F85572CD5F6117C6, 1, 1))
            _id_0C8D9F540BEE26B9[_id_0C8D9F540BEE26B9.size] = _id_F85572CD5F6117C6;
        }
      }
    } else
      return;
  } else if(_id_BD10B05C42BB5432(_id_8483C4E961406C32, undefined, 1))
    _id_0C8D9F540BEE26B9[_id_0C8D9F540BEE26B9.size] = _id_8483C4E961406C32;

  foreach(target in _id_0C8D9F540BEE26B9) {
    if(!isDefined(target)) {
      continue;
    }
    _id_58224AD5DB7BA3EF(target);
    _id_CFF38BAE1F51BBBF = _id_55F4107C03475907(target);
    _id_DBA08B318EB4224D(target, _id_CFF38BAE1F51BBBF);
    thread _id_20E0E81CCC2160E7(target, _id_CFF38BAE1F51BBBF);

    if(isPlayer(target) && !isbot(target))
      _id_99F74E04A216A21C(target, _id_CFF38BAE1F51BBBF);
  }
}

_id_55F4107C03475907(target) {
  level._id_4405E76242D7CB8E++;
  _id_CFF38BAE1F51BBBF = 0;

  if(isPlayer(target) && !isbot(target))
    _id_CFF38BAE1F51BBBF = target getxuid();
  else
    _id_CFF38BAE1F51BBBF = target getentitynumber();

  return _id_CFF38BAE1F51BBBF + "_" + level._id_4405E76242D7CB8E;
}

_id_20E0E81CCC2160E7(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + _id_CFF38BAE1F51BBBF);
  self endon("disable_super_sound_veil");
  level endon("game_ended");
  _id_4A6A11A4F1E2C293 = 0;

  if(isDefined(_id_8483C4E961406C32) && isPlayer(_id_8483C4E961406C32) && _id_8483C4E961406C32 != self.owner)
    self.owner thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_62166C6D2FCB36C3");

  while(isDefined(_id_8483C4E961406C32)) {
    _id_22F87C8BF7C4616B = "sound_veil_mp";

    if(isPlayer(_id_8483C4E961406C32)) {
      if(_id_8483C4E961406C32 scripts\mp\utility\perk::_hasperk("specialty_tac_resist"))
        _id_22F87C8BF7C4616B = "sound_veil_reduced_mp";
    }

    _id_8483C4E961406C32 scripts\cp_mp\utility\shellshock_utility::_shellshock(_id_22F87C8BF7C4616B, "stun", 0.5, 0);

    if(isDefined(self.owner))
      _id_8483C4E961406C32 dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_object, "torso_upper");

    wait 0.5;
  }
}

_id_99F74E04A216A21C(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  if(_id_8483C4E961406C32 scripts\cp_mp\utility\player_utility::isusingremote()) {
    thread _id_A996433357117A3F(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF);
    return;
  }

  thread _id_A8B8C5877FC13197(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF);
}

_id_A996433357117A3F(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + _id_CFF38BAE1F51BBBF);
  self endon("disable_super_sound_veil");
  level endon("game_ended");

  while(isDefined(_id_8483C4E961406C32) && _id_8483C4E961406C32 scripts\cp_mp\utility\player_utility::isusingremote())
    waitframe();

  thread _id_A8B8C5877FC13197(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF);
}

_id_A8B8C5877FC13197(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  level endon("game_ended");
  _id_4A6A11A4F1E2C293 = 0;
  _id_B249C1FFAEBDBC61 = "player_soundveil_shake_mp";
  _id_5C46A6026A0B4D43 = 5;

  if(_id_8483C4E961406C32 scripts\mp\utility\perk::_hasperk("specialty_tac_resist")) {
    _id_B249C1FFAEBDBC61 = "player_soundveil_shake_reduced_mp";
    _id_5C46A6026A0B4D43 = 3;
  }

  scripts\cp_mp\utility\player_utility::_id_F7348E400B4A608D(_id_8483C4E961406C32, _id_B249C1FFAEBDBC61, 1);
  _id_8483C4E961406C32 setclientomnvar("ui_hud_shake", 1);
  _id_8483C4E961406C32 scripts\cp_mp\emp_debuff::play_emp_scramble(_id_5C46A6026A0B4D43);
  level scripts\engine\utility::waittill_any_ents(self, "death", self, "destroyed", self, "lost_target_" + _id_CFF38BAE1F51BBBF, self, "disable_super_sound_veil");

  if(isDefined(_id_8483C4E961406C32)) {
    scripts\cp_mp\utility\player_utility::_id_56D83CDE22535F96(_id_8483C4E961406C32);
    _id_8483C4E961406C32 setclientomnvar("ui_hud_shake", 0);
    _id_8483C4E961406C32 scripts\cp_mp\emp_debuff::stop_emp_scramble(_id_5C46A6026A0B4D43);
  }
}

_id_DBA08B318EB4224D(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  thread _id_DE45ED589C44B1B6(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF);
  thread _id_F6FF6461277E08E7(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF);
  thread _id_5FDECE59C0FFC021(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF);
  thread _id_9AD53F155F459571(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF);
}

_id_F6FF6461277E08E7(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + _id_CFF38BAE1F51BBBF);
  self endon("disable_super_sound_veil");
  level endon("game_ended");

  if(isPlayer(_id_8483C4E961406C32))
    _id_8483C4E961406C32 scripts\engine\utility::waittill_any_2("death_or_disconnect", "killed_player");
  else
    _id_8483C4E961406C32 waittill("death");

  self notify("lost_target_" + _id_CFF38BAE1F51BBBF);
}

_id_5FDECE59C0FFC021(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + _id_CFF38BAE1F51BBBF);
  self endon("disable_super_sound_veil");
  level endon("game_ended");

  while(isDefined(_id_8483C4E961406C32)) {
    if(!isDefined(_id_8483C4E961406C32.vehicle)) {
      if(!_id_669BD251F952DB32(_id_8483C4E961406C32)) {
        break;
      }
    }

    if(!_id_47BBA92311467CA4(_id_8483C4E961406C32)) {
      break;
    }

    waitframe();
  }

  self notify("lost_target_" + _id_CFF38BAE1F51BBBF);
}

_id_9AD53F155F459571(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  self endon("death");
  self endon("destroyed");
  self endon("lost_target_" + _id_CFF38BAE1F51BBBF);
  self endon("disable_super_sound_veil");
  level endon("game_ended");
  _id_8483C4E961406C32 waittill("using_remote");
  self notify("lost_target_" + _id_CFF38BAE1F51BBBF);
}

_id_DE45ED589C44B1B6(_id_8483C4E961406C32, _id_CFF38BAE1F51BBBF) {
  self endon("death");
  self endon("destroyed");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("lost_target_" + _id_CFF38BAE1F51BBBF, "disable_super_sound_veil");
  _id_61D589D2064B53F2(_id_8483C4E961406C32);
}

_id_3E3BA6DFDEA9465B() {
  self notify("disable_super_sound_veil");
  self setscriptablepartstate("activate", "neutral", 0);
  self setscriptablepartstate("arm", "neutral", 0);
}

_id_58224AD5DB7BA3EF(_id_8483C4E961406C32) {
  _id_8483C4E961406C32._id_BAF99FF6E658C413 = 1;
  self.usedcount++;
  self._id_89EE7EBA7B1862CF[self._id_89EE7EBA7B1862CF.size] = _id_8483C4E961406C32;
}

_id_3C43DCC55621952A(_id_8483C4E961406C32) {
  if(isDefined(self) && self._id_89EE7EBA7B1862CF.size > 0) {
    foreach(target in self._id_89EE7EBA7B1862CF) {
      if(isDefined(target) && isDefined(_id_8483C4E961406C32) && target == _id_8483C4E961406C32)
        return 1;
    }
  }

  return 0;
}

_id_61D589D2064B53F2(_id_8483C4E961406C32) {
  if(isDefined(_id_8483C4E961406C32)) {
    _id_8483C4E961406C32._id_BAF99FF6E658C413 = undefined;
    self._id_89EE7EBA7B1862CF = scripts\engine\utility::array_remove(self._id_89EE7EBA7B1862CF, _id_8483C4E961406C32);
  }
}

_id_77BBCE9593E3B2CC() {
  if(isDefined(self._id_89EE7EBA7B1862CF)) {
    foreach(target in self._id_89EE7EBA7B1862CF)
    _id_61D589D2064B53F2(target);
  }
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}