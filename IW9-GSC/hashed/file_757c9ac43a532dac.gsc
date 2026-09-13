/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_757c9ac43a532dac.gsc
***********************************************/

_id_19F98938B071A88F() {
  setDvar("dvar_ED6E4FFA933AF621", 1);
  level._id_5771FC79979CCC58 = ::_id_5771FC79979CCC58;
  level._id_8A3D726E5CF04CC0 = ::_id_8A3D726E5CF04CC0;
  level._id_2AD8917B23C8C1D2 = ::_id_2AD8917B23C8C1D2;
}

_id_5771FC79979CCC58(_id_A365E25AA9D7BCDA, _id_6DC0E605ECD21EEE, _id_07C3865DEE4ABED6, _id_FBD5FADA61AE8341) {
  player = self;
  success = undefined;

  if(_id_A365E25AA9D7BCDA.type == "killstreak") {
    if(!istrue(_id_6DC0E605ECD21EEE)) {
      if(player _id_098B53A7358927D9::_id_77986DB57958B676(_id_A365E25AA9D7BCDA.ref)) {
        player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(4);
        return 0;
      }
    }

    switch (_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0) {
      case "cp_cruisePredator":
      case "cruisePredator":
        success = player _id_644C18834356D9DC::_id_50BE8ABFE68DDBFC();

        if(!success)
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(7);

        break;
      case "cp_clusterSpike":
      case "cluster_spike":
        success = player _id_644C18834356D9DC::_id_50BE8ABFE68DDBFC();

        if(!success)
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(7);

        break;
    }
  } else if(_id_A365E25AA9D7BCDA.type == "fieldupgrade" || _id_A365E25AA9D7BCDA.type == "super") {
    if(player _id_098B53A7358927D9::_id_3F422A1C87BD2809()) {
      player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(6);
      return 0;
    }

    if(!istrue(_id_6DC0E605ECD21EEE)) {
      _id_75630A54FF140EC2 = player _id_098B53A7358927D9::_id_97FAC14206681B1F();

      if(isDefined(_id_75630A54FF140EC2) && _id_A365E25AA9D7BCDA.ref == _id_75630A54FF140EC2) {
        player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(5);
        return 0;
      }
    }

    switch (_id_A365E25AA9D7BCDA.ref) {
      case "ammo_box":
      case "super_ammo_drop":
        success = player _id_644C18834356D9DC::_id_50BE8ABFE68DDBFC();

        if(!success)
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(7);

        break;
    }
  } else if(_id_A365E25AA9D7BCDA.type == "perk") {
    if(player _id_098B53A7358927D9::_id_87072B42853A9C58(_id_A365E25AA9D7BCDA.ref)) {
      player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(5);
      return 0;
    }
  } else if(_id_A365E25AA9D7BCDA.type == "special") {
    switch (_id_A365E25AA9D7BCDA.ref) {
      case "armor_bundle":
      case "armor":
        success = player _id_DBF72A7C50F79F16(_id_A365E25AA9D7BCDA);

        if(!success)
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(2);

        break;
      case "ai_squad":
      case "aiSquad":
      case "cp_aiSquad":
        success = player _id_118948FBEAE841B3(_id_A365E25AA9D7BCDA);

        if(!success)
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(2);

        break;
      case "cp_sentry":
      case "risk_turret":
        success = player _id_644C18834356D9DC::_id_50BE8ABFE68DDBFC();

        if(!success)
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(7);

        break;
      case "self_revive_token":
        if(istrue(self.hasselfrevivetoken)) {
          success = 0;
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(10);
        }

        break;
      case "ammo_box":
      case "super_ammo_drop":
        success = player _id_644C18834356D9DC::_id_50BE8ABFE68DDBFC();

        if(!success)
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(7);

        break;
      case "timer_skip":
        success = player _id_CBA4B211895AA155(_id_A365E25AA9D7BCDA);
        break;
      case "armoredtruck":
        if(isDefined(level._id_473CDD03B063C62A) && level._id_473CDD03B063C62A._id_0C002553DC300019 == 3) {
          success = 0;
          player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(22);
        }

        break;
    }
  }

  if(isDefined(success)) {
    if(istrue(success))
      thread scripts\cp\cp_analytics::_id_54204F27964FDDCF(player, _id_A365E25AA9D7BCDA.ref, _id_FBD5FADA61AE8341);

    return success;
  }

  thread scripts\cp\cp_analytics::_id_54204F27964FDDCF(player, _id_A365E25AA9D7BCDA.ref, _id_FBD5FADA61AE8341);
  return 1;
}

_id_8A3D726E5CF04CC0(_id_A365E25AA9D7BCDA, _id_7DDDAC09987D559E, _id_452130D9D126E506, _id_DB943473454F6EA6) {
  player = self;
  _id_15B89FF206500554 = player.br_kiosk;
  level._id_F091400016C92E56 = 1;
  _id_59CDCDF44A2FA379 = 1;
  _id_B517DF938986556F = 1;
  _id_A51E1E429C38EE87 = undefined;

  if(_id_A365E25AA9D7BCDA.type == "killstreak") {
    switch (_id_A365E25AA9D7BCDA._id_2CE272546E3AE7F0) {
      case "precisionAirstrike":
      case "cp_precisionAirstrike":
        _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_munition_precision_airstrike", player);
        _id_A51E1E429C38EE87 = 1;
        break;
      case "autoDrone":
      case "cp_autoDrone":
        _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_killstreak_auto_drone", player);
        _id_A51E1E429C38EE87 = 1;
        break;
      case "cp_clusterSpike":
      case "clusterSpike":
        _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_munition_cluster_spike", player);
        _id_A51E1E429C38EE87 = 1;
        break;
      case "cp_cruisePredator":
      case "cruisePredator":
        _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_munition_cruise_missile", player);
        _id_A51E1E429C38EE87 = 1;
        break;
      case "juggStreak":
      case "cp_juggStreak":
        _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_munition_juggernaut", player);
        level notify("defender_kiosk_juggernaut_purchased", player);
        _id_A51E1E429C38EE87 = 1;
        break;
    }
  } else {
    switch (_id_A365E25AA9D7BCDA.ref) {
      case "ai_squad":
      case "cp_ai_squad":
        player _id_A9D99FE0169FDB0A();
        break;
      case "cp_armor":
      case "armor":
        _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, "brloot_armor_plate", 1, undefined, 1, _id_452130D9D126E506);

        if(!_id_59CDCDF44A2FA379) {
          _id_CB4FAD49263E20C4 = _id_098B53A7358927D9::_id_BB87CFAE1E28E70B(0, _id_15B89FF206500554.origin, _id_15B89FF206500554.angles, player);
          pickupent = _id_098B53A7358927D9::_id_09D6D4C76ABC82CF("brloot_armor_plate", _id_CB4FAD49263E20C4, 1, 1, undefined, 0);
          _id_59CDCDF44A2FA379 = 1;
        }

        break;
      case "armor_bundle":
      case "cp_armor_bundle":
        _id_2B83F7CF5DD2CF23 = player _id_3FD3C5A2E270592E::_findgivearmoramountanddropleftovers(1);

        if(_id_2B83F7CF5DD2CF23 <= 0)
          _id_59CDCDF44A2FA379 = 1;
        else
          _id_59CDCDF44A2FA379 = _id_098B53A7358927D9::_id_E2DB59D7677BFCEB(player, "brloot_armor_plate", 1, _id_2B83F7CF5DD2CF23, 1, _id_452130D9D126E506);

        break;
      case "cp_sentry":
      case "risk_turret":
        _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_munition_sentry", player);
        _id_A51E1E429C38EE87 = 1;
        break;
      case "self_revive_token":
      case "cp_self_revive_token":
        player thread _id_66122A002AFF5D57::addselfrevivetoken();
        break;
      case "cp_super_ammo_drop":
      case "ammo_box":
      case "super_ammo_drop":
        _id_59CDCDF44A2FA379 = scripts\cp\loot_system::give_munition("brloot_munition_munitions_crate", player);
        _id_A51E1E429C38EE87 = 1;
        break;
      case "timer_skip":
      case "cp_timer_skip":
        break;
      case "armoredtruck":
        _id_3A06EC88CB67667B();

        if(level._id_473CDD03B063C62A._id_0C002553DC300019 == 3) {
          _id_59CDCDF44A2FA379 = 0;
          break;
        }

        _id_7B147BFA44B8941D = thread _id_498D00EFDF8E6AF3();
        break;
    }
  }

  if(_id_59CDCDF44A2FA379) {
    _id_FBD5FADA61AE8341 = _id_3FD3C5A2E270592E::_getactualcost(player, _id_A365E25AA9D7BCDA);
    itemname = _id_68ED62C896913C57(_id_A365E25AA9D7BCDA.ref);
    scripts\cp\challenges_cp::_id_D8B00758A4ECBDA7(itemname);
    scripts\cp\challenges_cp::_id_CE271D4118A0475D(_id_FBD5FADA61AE8341);
    player _id_3FD3C5A2E270592E::_makekioskpurchase(_id_A365E25AA9D7BCDA);

    if(_id_B517DF938986556F)
      player thread _id_098B53A7358927D9::_id_234F5394668ED388("br_item_purchased");

    if(istrue(_id_A51E1E429C38EE87))
      player thread _id_27CED223B0B31D99();

    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("defender_vo", "item_purchased", itemname);
    scripts\cp_mp\challenges::onkioskpurchaseitem("special", _id_A365E25AA9D7BCDA.ref, undefined, 1, _id_A365E25AA9D7BCDA.cost);
    _id_098B53A7358927D9::_id_98BD9179435D1557(self, _id_A365E25AA9D7BCDA.cost, "special", _id_A365E25AA9D7BCDA.ref);
  }
}

_id_27CED223B0B31D99() {
  self endon("death_or_disconnect");
  self endon("last_stand_start");
  wait 3;
  scripts\cp\utility::hint_prompt("tutorial_munitions", 1, 8, 1);
}

_id_68ED62C896913C57(ref) {
  switch (ref) {
    case "ai_squad":
    case "cp_aiSquad":
      return "delta_soldiers";
  }

  return ref;
}

_id_2AD8917B23C8C1D2(cost, _id_A365E25AA9D7BCDA) {
  _id_98EA5AFB293A76A2 = _id_66122A002AFF5D57::_id_6C95BEB0447FF560();
  _id_150663DEF4F4145A = int(cost * _id_98EA5AFB293A76A2);
  return _id_150663DEF4F4145A;
}

_id_498D00EFDF8E6AF3() {
  _id_FE4B92977CE13AF0 = getdvarint("dvar_B0FF99704A332F6F") > 0;
  _id_346F237F388C0946 = _id_9D9AC764C359A4A4();
  level._id_473CDD03B063C62A._id_64A7D687BFE1B47D++;

  if(level._id_473CDD03B063C62A._id_64A7D687BFE1B47D == 3)
    level._id_473CDD03B063C62A._id_64A7D687BFE1B47D = 0;

  level._id_473CDD03B063C62A._id_0C002553DC300019++;

  if(_id_FE4B92977CE13AF0)
    thread scripts\cp\utility::drawsphere(_id_346F237F388C0946.origin, 20, 10, (1, 0, 0));

  spawndata = spawnStruct();
  spawndata.origin = _id_346F237F388C0946.origin;
  spawndata.angles = _id_346F237F388C0946.angles;
  _id_17160569DAB45FD6 = _id_721EE99D7A8F9168::_id_66C684FEA143FBFD("veh9_jltv_mg", spawndata);
  _id_17160569DAB45FD6 thread _id_74AC9140DDCCE4DD();
  _id_17160569DAB45FD6 thread _id_1B38E55682DFCB61(_id_346F237F388C0946);

  if(_id_FE4B92977CE13AF0)
    _id_17160569DAB45FD6 thread _id_38830A31E89C2E73(_id_346F237F388C0946);

  if(!isDefined(_id_17160569DAB45FD6)) {
    level._id_473CDD03B063C62A._id_0C002553DC300019--;
    return undefined;
  }

  level._id_473CDD03B063C62A._id_104C9F34A293C2FF = scripts\engine\utility::array_add(level._id_473CDD03B063C62A._id_104C9F34A293C2FF, _id_17160569DAB45FD6);
  return _id_17160569DAB45FD6;
}

_id_1B38E55682DFCB61(_id_346F237F388C0946) {
  kill_trigger = getEnt(_id_346F237F388C0946.target, "targetname");
  _id_E1284CA18BEB2EC4 = squared(20);

  for(;;) {
    _id_D148813AD40029C9 = lengthsquared(_id_346F237F388C0946.origin - self.origin);

    if(_id_D148813AD40029C9 < _id_E1284CA18BEB2EC4) {
      _id_ECA74EAB8BD38D74 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
      _id_96CD52C92501B815 = scripts\cp\cp_agent_utils::getaliveagentsofteam("allies");
      _id_DA44429A60525CE8 = scripts\engine\utility::array_combine(level.players, _id_96CD52C92501B815, _id_ECA74EAB8BD38D74);
      _id_5BCEAE19DEC279BF = kill_trigger getistouchingentities(_id_DA44429A60525CE8);

      foreach(ent in _id_5BCEAE19DEC279BF) {
        if(isPlayer(ent))
          ent thread _id_BA7469B0E511AF83();
        else
          ent kill(_id_346F237F388C0946.origin, self, self, "MOD_PROJECTILE");

        ent playSound("prty_elevator_shaft_player_crush");
      }

      break;
    }

    if(_id_D148813AD40029C9 < squared(12)) {
      break;
    }

    waitframe();
  }
}

_id_BA7469B0E511AF83() {
  self.shouldskipdeathsshield = 1;
  self.shouldskiplaststand = 1;
  self dodamage(self.maxhealth + 100000, self.origin, self, undefined, "MOD_TRIGGER_HURT");
  self dodamage(self.maxhealth + 100000, self.origin, self, undefined, "MOD_TRIGGER_HURT");
  wait 5;
  self.shouldskipdeathsshield = 0;
  self.shouldskiplaststand = 0;
}

_id_74AC9140DDCCE4DD() {
  self waittill("death");
  level._id_473CDD03B063C62A._id_104C9F34A293C2FF = scripts\engine\utility::array_remove(level._id_473CDD03B063C62A._id_104C9F34A293C2FF, self);
  level._id_473CDD03B063C62A._id_0C002553DC300019--;
}

_id_38830A31E89C2E73(_id_346F237F388C0946) {
  self endon("death");
  kill_trigger = getEnt(_id_346F237F388C0946.target, "targetname");

  for(;;) {
    _id_D148813AD40029C9 = length(_id_346F237F388C0946.origin - self.origin);

    if(_id_D148813AD40029C9 < 11) {
      break;
    }

    thread scripts\engine\utility::draw_line_for_time(self.origin, _id_346F237F388C0946.origin, 0, 0, 1, 0.05);
    waitframe();
  }
}

_id_3A06EC88CB67667B() {
  if(isDefined(level._id_473CDD03B063C62A)) {
    return;
  }
  setdvarifuninitialized("dvar_B0FF99704A332F6F", 0);
  level._id_473CDD03B063C62A = spawnStruct();
  level._id_473CDD03B063C62A._id_0C002553DC300019 = 0;
  level._id_473CDD03B063C62A._id_64A7D687BFE1B47D = 0;
  level._id_473CDD03B063C62A._id_104C9F34A293C2FF = [];
}

_id_9D9AC764C359A4A4() {
  _id_30272807396105F4 = scripts\engine\utility::getStructArray("vehicle_airdrop_location", "script_noteworthy");
  return _id_30272807396105F4[level._id_473CDD03B063C62A._id_64A7D687BFE1B47D];
}

_id_DBF72A7C50F79F16(_id_A365E25AA9D7BCDA) {
  player = self;
  _id_6A8B46E184E181CC = spawnStruct();
  _id_6A8B46E184E181CC.scriptablename = "brloot_armor_plate";

  if(_id_A365E25AA9D7BCDA.ref == "armor_bundle")
    _id_6A8B46E184E181CC.count = 5;
  else
    _id_6A8B46E184E181CC.count = 1;

  _id_DC297349765E2088 = _id_098B53A7358927D9::_id_76AE39F27ED53321(_id_6A8B46E184E181CC);

  if(_id_DC297349765E2088 != 1 && _id_DC297349765E2088 != 20) {
    if(_id_DC297349765E2088 == 4)
      return 1;
    else {
      player _id_3FD3C5A2E270592E::_closepurchasemenuwithresponse(7);
      return 0;
    }
  }

  return 1;
}

_id_118948FBEAE841B3(_id_A365E25AA9D7BCDA) {
  _id_30C5DCD8B800B7C5 = _id_5CB623572B271C34::_id_110F112431C654DC();

  if(isDefined(level._id_0410DCB9CDA2B067) && level._id_0410DCB9CDA2B067.size >= 3) {
    thread scripts\cp\cp_hud_message::tutorialprint(level._id_9C3AA643B7642FB1);
    return 0;
  } else if(_id_30C5DCD8B800B7C5 >= _id_5CB623572B271C34::_id_87AC668A043AF5DD()) {
    thread scripts\cp\cp_hud_message::tutorialprint(level._id_9C3AA643B7642FB1);
    return 0;
  } else if(!isDefined(level._id_F78FB7634E3797C4)) {
    thread scripts\cp\cp_hud_message::tutorialprint(level._id_9C3AA643B7642FB1, 2);
    return 0;
  } else if(istrue(level._id_F42ACFB1D6B18FD7)) {
    thread scripts\cp\cp_hud_message::tutorialprint(level._id_9C3AA643B7642FB1);
    return 0;
  } else
    return 1;
}

_id_CBA4B211895AA155(_id_A365E25AA9D7BCDA) {
  if(isDefined(level._id_E9922F45DB5AE222))
    return 1;
  else
    return 0;
}

_id_18E5B806C7693D20() {
  if(isDefined(level._id_9C3AA643B7642FB1)) {
    return;
  }
  if(isDefined(level._id_54F48A7236A6DD69)) {
    [[level._id_54F48A7236A6DD69]]();
    return;
  }

  level._id_9C3AA643B7642FB1 = &"CP_WEAPON_BUY/DELTA_SQUAD_ALIVE";
  level._id_87DBB8D8D744C95F = &"CP_WEAPON_BUY/DELTA_SQUAD_SPAWN";
  level._id_988BC8650B85A175 = &"CP_WEAPON_BUY/DELTA_SQUAD_PAUSED";
}

_id_A9D99FE0169FDB0A() {
  scripts\cp\utility::playsoundtoplayer_safe("buystation_deltasquad_buy", self);
  level notify("deploy_delta_squad", self);
  return 1;
}