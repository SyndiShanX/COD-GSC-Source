/****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_supply_sweep.gsc
****************************************************************************/

main() {
  level thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  if(!getdvarint("dvar_722967118D0CE787", 0)) {
    return;
  }
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  level thread init();
}

init() {
  if(!getdvarint("redeploy_ascenders_enabled", 0))
    _id_610F57BDDD265BE2::_id_C592E91FC6604AD0();

  _id_963E59E07410B8ED();
}

_id_963E59E07410B8ED() {
  while(!isDefined(level.br_ac130))
    wait 0.05;

  wait 23;
  drone = spawn("script_model", anglesToForward((0, randomint(360), 0)) * 40000 + (0, 0, getdvarint("dvar_D09E4B72069E9128", 12500)));
  drone setModel("veh9_mil_air_drone_supply_sweep");
  drone.angles = (0, randomint(360), 0);
  drone.speed = 0;
  drone.health = getdvarint("dvar_03B68B33598132A0", 270);
  drone setCanDamage(1);
  drone forcenetfieldhighlod(1);
  scripts\mp\weapons::_id_E00B77A9CB4D8322(drone);
  drone thread _id_037A5377D8DE43DF();
  drone thread _id_F9E2637633ED4523();
}

_id_037A5377D8DE43DF() {
  level endon("game_ended");
  self endon("entitydeleted");
  _id_39AB2635FA36C1E7 = getdvarint("dvar_D09E4B72069E9128", 12500);
  _id_5452B78B5A67F7E0 = spawnStruct();
  _id_58DF80BC53F9BC28 = randomint(360);

  while(self.health > 0) {
    if(level.br_circle.circleindex == level._id_FC4BB27A820F54DD._id_73610DF6CB8260E6) {
      _id_2B4D24A5508865BC();
      return;
    }

    for(;;) {
      _id_49B41B574BD7B2BF = (_id_2695A20D4011076D::getsafecircleorigin()[0], _id_2695A20D4011076D::getsafecircleorigin()[1], _id_39AB2635FA36C1E7);
      _id_58DF80BC53F9BC28 = _id_58DF80BC53F9BC28 + randomintrange(90, 270);

      if(_id_58DF80BC53F9BC28 > 360)
        _id_58DF80BC53F9BC28 = _id_58DF80BC53F9BC28 - 360;

      _id_5452B78B5A67F7E0.origin = _id_49B41B574BD7B2BF + anglesToForward((0, _id_58DF80BC53F9BC28, 0)) * randomintrange(2500, 7500);
      _id_5452B78B5A67F7E0.angles = vectortoangles(_id_5452B78B5A67F7E0.origin - self.origin);
      _id_5452B78B5A67F7E0.angles = (0, _id_5452B78B5A67F7E0.angles[1], 0);

      if(distance2dsquared(_id_5452B78B5A67F7E0.origin, self.origin) > squared(2500)) {
        break;
      }

      waitframe();
    }

    self._id_3B4FEE20D214BD9B = undefined;
    self._id_F44262DAAB1A384A = undefined;
    self.speed = 0;
    thread _id_610F57BDDD265BE2::_id_6D9358D777958A1B(_id_5452B78B5A67F7E0);
    thread _id_610F57BDDD265BE2::_id_53A07930F4FC0E08(_id_5452B78B5A67F7E0);
    thread _id_610F57BDDD265BE2::_id_0314CDFB5C5633B1();
    self waittill("redeploy_drone_arrive");

    while(!isDefined(self._id_3B4FEE20D214BD9B) || !isDefined(self._id_F44262DAAB1A384A))
      wait 1;
  }
}

_id_2B4D24A5508865BC() {
  _id_10B874AA4BB07A07 = spawnStruct();
  _id_9602B340166DCDD7 = _id_2695A20D4011076D::getsafecircleorigin();
  _id_10B874AA4BB07A07.origin = self.origin + vectorNormalize(self.origin - (_id_9602B340166DCDD7[0], _id_9602B340166DCDD7[1], self.origin[2])) * 20000;
  _id_10B874AA4BB07A07.angles = vectortoangles(self.origin - (_id_9602B340166DCDD7[0], _id_9602B340166DCDD7[1], self.origin[2]));
  self._id_3B4FEE20D214BD9B = undefined;
  self._id_F44262DAAB1A384A = undefined;
  thread _id_610F57BDDD265BE2::_id_6D9358D777958A1B(_id_10B874AA4BB07A07);
  thread _id_610F57BDDD265BE2::_id_53A07930F4FC0E08(_id_10B874AA4BB07A07);

  while(!isDefined(self._id_3B4FEE20D214BD9B) || !isDefined(self._id_F44262DAAB1A384A)) {
    if(self.health <= 0) {
      return;
    }
    wait 0.05;
  }

  self notify("relocation_complete");
  self delete();
}

_id_F9E2637633ED4523() {
  level endon("game_ended");
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(isPlayer(eattacker))
      eattacker _id_5762AC2F22202BA2::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");
    else if(isDefined(eattacker.owner) && isPlayer(eattacker.owner))
      eattacker.owner _id_5762AC2F22202BA2::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");

    if(isDefined(eattacker.model) && eattacker.model == "veh8_mil_air_lbravo_mp_flyable" || eattacker.model == "veh8_mil_air_lbravo_mp_flyable_mg")
      level thread _id_610F57BDDD265BE2::_id_CF65FBC1C077FADB(eattacker, self.origin);

    if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE")
      idamage = int(idamage * level._id_FC4BB27A820F54DD._id_4B2CDACF483DCCC4);

    if(isDefined(modelname) && modelname == "ks_airstrike_target_br_ch3")
      idamage = level._id_FC4BB27A820F54DD._id_71BA1DDBE86CAB15;

    self.health = self.health - idamage;

    if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "toma_proj_mp")
      self.health = 0;

    if(self.health <= 0) {
      _id_4A0AFEE07E97BF31(eattacker);
      return;
    }
  }
}

_id_4A0AFEE07E97BF31(eattacker) {
  eattacker scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8F3A6840E401F2E3");
  self setscriptablepartstate("redeploy_drone_relocation_smoke_vfx", "enabled");
  self physics_registerforcollisioncallback();
  thread _id_610F57BDDD265BE2::_id_026AACBD66AB5C92();
  self waittill("collision");
  _id_610F57BDDD265BE2::_id_6D23AA882F67A716();
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin + (0, 0, 10), self.angles, self, level.br_pickups._id_AD49A38DD7C4C10F, level.br_pickups._id_3B53BC0EEE6AE84E);
  item = undefined;

  if(randomint(100) < 5)
    item = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_auav", _id_CB4FAD49263E20C4, undefined, 1, undefined, 0);
  else {
    switch (level.br_circle.circleindex) {
      case 0:
        item = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_supply_sweep", _id_CB4FAD49263E20C4, undefined, 1, undefined, 0);
        break;
      case 1:
        item = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_scramblerdrone", _id_CB4FAD49263E20C4, undefined, 1, undefined, 0);
        break;
      default:
        item = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_uav", _id_CB4FAD49263E20C4, undefined, 1, undefined, 0);
    }
  }

  item thread _id_F6825931489DC8A9(eattacker, "ui_icon_minimap_reward");
  item thread _id_9FE88329EEA942F5();
  level thread _id_5AD7013749E24080(self.origin + (0, 0, 10));
  level thread _id_3CFCB01C0C46B6C1(eattacker, self.origin + (0, 0, 10));
  level thread _id_F3D493E76BC49486();
  scripts\mp\weapons::_id_1A33BD42949CCBDA(self);
  self delete();
}

_id_5AD7013749E24080(_id_254F9C6C23AD6894) {
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_2CEDCC356F1B9FC8::droptogroundmultitrace(_id_254F9C6C23AD6894 + anglesToForward((0, randomint(360), 0)) * 10, 0, -500), (0, randomint(360), 0));

  if(scripts\engine\utility::cointoss())
    _id_7E52B56769FA7774::spawnpickup("brloot_super_emppulse", _id_CB4FAD49263E20C4);
  else
    _id_7E52B56769FA7774::spawnpickup("brloot_super_tacticalcamera", _id_CB4FAD49263E20C4);

  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_2CEDCC356F1B9FC8::droptogroundmultitrace(_id_254F9C6C23AD6894 + anglesToForward((0, randomint(360), 0)) * 20, 0, -500), (0, randomint(360), 0));
  _id_AC0E594AC96AA3A8 = randomint(100);

  if(_id_AC0E594AC96AA3A8 < 33)
    _id_7E52B56769FA7774::spawnpickup("brloot_offhand_decoy", _id_CB4FAD49263E20C4);
  else if(_id_AC0E594AC96AA3A8 < 66)
    _id_7E52B56769FA7774::spawnpickup("brloot_offhand_shockstick", _id_CB4FAD49263E20C4);
  else
    _id_7E52B56769FA7774::spawnpickup("brloot_offhand_snapshot", _id_CB4FAD49263E20C4);
}

_id_3CFCB01C0C46B6C1(player, _id_254F9C6C23AD6894) {
  _id_239793E9AA66493E = getdvarint("dvar_078AFB5674FADD4E", 3);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_239793E9AA66493E; _id_AC0E594AC96AA3A8++) {
    _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_2CEDCC356F1B9FC8::droptogroundmultitrace(_id_254F9C6C23AD6894 + anglesToForward((0, randomint(360), 0)) * (_id_AC0E594AC96AA3A8 + 1) * 30, 0, -500), (0, randomint(360), 0));

    if(scripts\engine\utility::cointoss()) {
      _id_7E52B56769FA7774::spawnpickup("brloot_armor_plate", _id_CB4FAD49263E20C4);
      continue;
    }

    _id_92D8A509637FB29B = undefined;

    if(isDefined(player) && isPlayer(player)) {
      weapon = player getcurrentprimaryweapon();

      if(issubstr(weapon.basename, "_ar"))
        _id_92D8A509637FB29B = "brloot_ammo_762";
      else if(issubstr(weapon.basename, "_pi") || issubstr(weapon.basename, "_sm"))
        _id_92D8A509637FB29B = "brloot_ammo_919";
      else if(issubstr(weapon.basename, "_sh"))
        _id_92D8A509637FB29B = "brloot_ammo_12g";
      else if(issubstr(weapon.basename, "_sn") || issubstr(weapon.basename, "_dm"))
        _id_92D8A509637FB29B = "brloot_ammo_50cal";
      else {
        _id_2C878E7206CB78EA = ["brloot_ammo_762", "brloot_ammo_919", "brloot_ammo_12g", "brloot_ammo_50cal"];
        _id_92D8A509637FB29B = _id_2C878E7206CB78EA[randomint(_id_2C878E7206CB78EA.size)];
      }
    }

    _id_7E52B56769FA7774::spawnpickup(_id_92D8A509637FB29B, _id_CB4FAD49263E20C4);
  }
}

_id_F6825931489DC8A9(eattacker, _id_5C85522AD96B3A04) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(getdvarint("dvar_43CDBBA4C39BA0CF", 0))
    objective_state(objid, "current");
  else
    objective_state(objid, "active");

  objective_position(objid, self.origin);
  objective_sethideelevation(objid, 1);
  objective_setplayintro(objid, 0);
  objective_setdescription(objid, &"MP_BR_INGAME/REWARD_ICON_NAME_SUPPLY_SWEEP");

  if(getdvarint("dvar_485F48117DD17E41", 0))
    objective_setshowdistance(objid, 1);
  else
    objective_setshowdistance(objid, 0);

  if(getdvarint("dvar_780F489553661EC6", 0))
    objective_setshowoncompass(objid, 1);
  else
    objective_setshowoncompass(objid, 0);

  _func_865F9C5D005F9A08(objid, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(objid, _id_5C85522AD96B3A04);
  scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 5);
  objective_removeallfrommask(objid);

  foreach(player in scripts\mp\utility\teams::getteamdata(eattacker.team, "players"))
  objective_addclienttomask(objid, player);

  objective_showtoplayersinmask(objid);
  level thread _id_0C4648FA62189EBA(self, objid);
}

_id_0C4648FA62189EBA(scriptable, objid) {
  while(isDefined(scriptable))
    waitframe();

  objective_hidefromplayersinmask(objid);
  scripts\mp\objidpoolmanager::returnobjectiveid(objid);
}

_id_9FE88329EEA942F5() {
  level endon("game_ended");
  _id_AE2730E7EECF1623 = getdvarint("dvar_88A67073D3A4010C", 300);

  while(isDefined(self)) {
    _id_6F21E5ABF098A6D1 = scripts\mp\utility\player::getplayersinradius(self.origin, 300);

    if(_id_6F21E5ABF098A6D1.size) {
      _id_6F21E5ABF098A6D1[0] scripts\mp\utility\points::_id_0366980B6A8796AE("stat_3344B8F2F73B922A");
      break;
    }

    waitframe();
  }
}

_id_F3D493E76BC49486() {
  level endon("game_ended");
  wait(getdvarint("dvar_764F944633363973", 55));

  if(level.br_circle.circleindex < level._id_FC4BB27A820F54DD._id_73610DF6CB8260E6) {
    drone = spawn("script_model", anglesToForward((0, randomint(360), 0)) * 40000 + (0, 0, getdvarint("dvar_D09E4B72069E9128", 12500)));
    drone setModel("veh9_mil_air_drone_supply_sweep");
    drone.angles = (0, randomint(360), 0);
    drone.speed = 0;
    drone.health = getdvarint("dvar_03B68B33598132A0", 270);
    drone setCanDamage(1);
    drone forcenetfieldhighlod(1);
    scripts\mp\weapons::_id_E00B77A9CB4D8322(drone);
    drone thread _id_037A5377D8DE43DF();
    drone thread _id_F9E2637633ED4523();
  }
}