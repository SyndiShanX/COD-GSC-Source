/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\vehicle_drop.gsc
***********************************************/

_id_172A790B85BBC40B() {
  thread _id_369CD45B595B9C13();
  return 1;
}

_id_369CD45B595B9C13() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waitframe();
  _id_19163E14365D9264 = scripts\mp\supers::getcurrentsuper();

  if(isDefined(level._id_27F78817B59DFE32))
    _id_19163E14365D9264._id_FB58A31C756DB4CC = level._id_27F78817B59DFE32;

  _id_3B64EB40368C1450::set("giveDropWeapon", "killstreaks", 0);
  _id_9B1DEB5E9D32BBE3 = _id_02AABAC61F2AE422::_id_F3A5A94B1D50ED38(_id_19163E14365D9264, makeweapon("deploy_vehicle_drop_mp"), "grenade_fire");
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("giveDropWeapon");

  if(istrue(_id_9B1DEB5E9D32BBE3)) {
    self notify("super_finished_with_deploy_weapon");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();
      scripts\cp_mp\challenges::_id_D997435895422ECC("super_vehicle_drop", 0);
    }
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage") && !scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/CANNOT_USE_GENERIC");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
  }
}

_id_E203A65ECB5C85C4(grenade) {
  player = self;
  player endon("disconnect");
  player endon("vehicle_drop_grenade_explode");
  grenade waittill("death");
  waitframe();

  if(isDefined(player.super))
    player scripts\mp\supers::superusefinished(1);
}

_id_604ED6F2F8323EA6(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  grenade endon("explode_end");

  if(!isDefined(self)) {
    return;
  }
  if(_id_799D521F485A1701::_id_81C029669130C0D4()) {}

  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread _id_E203A65ECB5C85C4(grenade);

  if(isDefined(level._id_E3CCF0898A949BEC))
    level thread scripts\mp\equipment\advanced_supply_drop::_id_22740C19D22B8B6E(self, grenade);

  grenade waittill("explode", position);
  self notify("vehicle_drop_grenade_explode");

  if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
    if(isDefined(grenade))
      grenade delete();

    if(isDefined(self.super))
      scripts\mp\supers::superusefinished(1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/VEHICLE_DROP_CANNOT_USE_OOB");
  } else {
    _id_0FB932F46EF5EC56 = scripts\mp\utility\game::getsubgametype() == "truckwar";
    spawndata = spawnStruct();
    spawndata.origin = position;
    spawndata.angles = self.angles;

    if(isDefined(level._id_DB7E814F7458CDBB))
      spawndata.origin = scripts\engine\utility::drop_to_ground(spawndata.origin, level._id_DB7E814F7458CDBB, -12000);

    spawndata._id_427538F5A2AD4F8B = 1;
    spawndata._id_EC76FFDBE2F37C5B = 1;
    spawndata._id_065DA0A245B653CC = 1;
    spawndata._id_D04816FE2F5BCEE6 = 1;
    _id_A365E25AA9D7BCDA = spawnStruct();
    _id_A365E25AA9D7BCDA.ref = "veh9_mil_lnd_mrap";

    if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(spawndata.origin, _id_A365E25AA9D7BCDA.ref)) {
      if(isDefined(grenade))
        grenade delete();

      if(isDefined(self.super))
        scripts\mp\supers::superusefinished(1);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/VEHICLE_DROP_CANNOT_USE_OOB");
    }

    self notify("vehicle_drop_success");
    thread _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4("truckwar_vehicle_deploying", level.teamdata[self.team]["players"]);
    thread _id_4384ABBF498DF6A7::_id_3F45B3C575EC001B(_id_A365E25AA9D7BCDA, spawndata, _id_0FB932F46EF5EC56);
  }
}

_id_852EA8E204596ED0(equipmentref) {
  return isDefined(equipmentref) && equipmentref == "equip_advanced_vehicle_drop";
}