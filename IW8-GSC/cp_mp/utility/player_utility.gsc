/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\player_utility.gsc
***********************************************/

_isalive() {
  return isalive(self) && !isDefined(self.fauxdead) && !istrue(self.delayedspawnedplayernotify);
}

setusingremote(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_979D0FE291986D039BF5BF53DBB10A84C8"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_979D0FE291986D039BF5BF53DBB10A84C8")]](var_0);
}

clearusingremote(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B864110E58F8B1EB6D271F0B67B6C2E57BE307"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B864110E58F8B1EB6D271F0B67B6C2E57BE307")]](var_0);
}

isusingremote() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_A1750E827BBDD74450E7625D9B304BF7"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A1750E827BBDD74450E7625D9B304BF7")]]();

  return 0;
}

isinvehicle(var_0) {
  if(isDefined(self.vehicle) && isDefined(self.vehicle.vehiclename))
    return 1;

  if(istrue(var_0)) {
    if(isDefined(self._id_1425D) && isDefined(self._id_1425D.vehiclename))
      return 1;
  }

  return 0;
}

getvehicle() {
  if(!isinvehicle())
    return undefined;

  return self.vehicle;
}

_freezecontrols(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B2680F276E71EB3A2703FFBBA1636F5123"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B2680F276E71EB3A2703FFBBA1636F5123")]](var_0, var_1, var_2);
}

ai_offhandfiremanager() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_A37014CC4ECACA3DB268B7374793B7C6372259135DD9"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_A37014CC4ECACA3DB268B7374793B7C6372259135DD9")]]();
}

_freezelookcontrols(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AC5D131B65CD2A0258E4BD8538512FD21DFDB74B0F"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AC5D131B65CD2A0258E4BD8538512FD21DFDB74B0F")]](var_0, var_1);
}

getplayersuperfaction(var_0) {
  var_1 = 0;

  if(isDefined(var_0.operatorcustomization))
    var_1 = var_0.operatorcustomization.superfaction;

  return var_1;
}

setthermalvision(var_0, var_1, var_2) {
  if(istrue(var_0)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(var_1, var_2, 20, 20);
    self thermalvisionon();
  } else {
    self disablephysicaldepthoffieldscripting();
    self thermalvisionoff();
  }
}

watchthermalinputchange() {
  self notify("_encstr_AC7E1B40EAE3C708776423AD5A87119181F27383C3BB07A14399389425");
  self endon("_encstr_AC7E1B40EAE3C708776423AD5A87119181F27383C3BB07A14399389425");

  for(;;) {
    var_0 = getthermalswitchplayercommand();
    self notifyonplayercommand("_encstr_83DC143FAF8C707E6B3133B8FA6B2180652FBB8F2477", var_0);
    var_1 = scripts\engine\utility::_id_143B4("_encstr_AA63132DE6C1ABA37D1DF2C159D7C6430BCD3BB223", "_encstr_85211783800B220F9999F7C82740136DBB283AC92BC51F6751");
    self notifyonplayercommandremove("_encstr_83DC143FAF8C707E6B3133B8FA6B2180652FBB8F2477", var_0);

    if(!isDefined(var_1) || var_1 == "_encstr_85211783800B220F9999F7C82740136DBB283AC92BC51F6751") {
      break;
    }
  }
}

stopwatchingthermalinputchange() {
  self notify("_encstr_85211783800B220F9999F7C82740136DBB283AC92BC51F6751");
}

getthermalswitchplayercommand() {
  if(scripts\engine\utility::is_player_gamepad_enabled())
    return "_encstr_A6E308B2DCE8B0B936B2";

  return "_encstr_ABC00CDC969D431D9DD2B9B4EDDC";
}

enabledemeanorsafe() {
  if(!isDefined(self.demeanorsafeenabled))
    self.demeanorsafeenabled = 0;

  self.demeanorsafeenabled++;

  if(self.demeanorsafeenabled == 1)
    forcedemeanorsafe(1);
}

disabledemeanorsafe() {
  self.demeanorsafeenabled--;

  if(self.demeanorsafeenabled == 0) {
    self.demeanorsafeenabled = undefined;
    forcedemeanorsafe(0);
  }
}

forcedemeanorsafe(var_0) {
  if(var_0 && self getdemeanorviewmodel() != "_encstr_B418059B8533CA")
    thread forcedemeanorsafeinteral(var_0);
  else if(!var_0 && self getdemeanorviewmodel() == "_encstr_B418059B8533CA")
    thread forcedemeanorsafeinteral(var_0);
}

forcedemeanorsafeinteral(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_8EF119849F886BF22535BD5FE07E7FAAB718DBCF2382EB81637E21");
  self endon("_encstr_8EF119849F886BF22535BD5FE07E7FAAB718DBCF2382EB81637E21");
  var_1 = self issprinting();

  if(!istrue(self.demeanorsprintdisable)) {
    scripts\common\utility::allow_sprint(0);
    self.demeanorsprintdisable = 1;
  }

  if(var_1)
    wait 0.5;

  if(var_0)
    self setdemeanorviewmodel("_encstr_B418059B8533CA", "_encstr_A975161B174F60E8BD020E61AF6D20A7C28FA5EFAF62B4B0");
  else
    self setdemeanorviewmodel("_encstr_820E07FAE8780B3A4C");

  wait 0.5;

  if(istrue(self.demeanorsprintdisable)) {
    scripts\common\utility::allow_sprint(1);
    self.demeanorsprintdisable = undefined;
  }
}

cleardemeanorsafe() {
  self.demeanorsafeenabled = undefined;
  self.demeanorsprintdisable = undefined;
}

playersareenemies(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1))
    return undefined;

  if(!isDefined(var_0.team) || !isDefined(var_1.team))
    return undefined;

  if(level.teambased)
    return var_0.team != var_1.team;
  else
    return var_0 != var_1;
}

_id_12510() {
  return self setclientkillstreakindexes() || scripts\common\utility::iswegameplatform();
}

temp_debug_wait_and_stop_music_loop() {
  level._id_126C0 = [];
}

being_kicked_from_inactivity() {
  if(!self clearvehicleturretsticker())
    level._id_126C0[self getxuid()] = self;
}

_id_12C03() {
  level._id_126C0[self getxuid()] = undefined;
}

relic_nuketimer_timer() {
  return level._id_126C0;
}

allowunresolvedcollision() {
  if(!isDefined(self._id_125CD))
    self._id_125CD = 0;

  if(self._id_125CD == 0)
    self playerhide();

  self._id_125CD++;
}

allplayers_clearphysicaldof() {
  if(isDefined(self._id_125CD)) {
    if(self._id_125CD == 1)
      self playershow();

    self._id_125CD--;

    if(self._id_125CD <= 0)
      self._id_125CD = undefined;
  } else
    self playershow();
}

_id_125D0() {
  self._id_125CD = undefined;

  if(!isDefined(level._id_12693))
    level._id_12693 = getdvarint("_encstr_95DC166BDE7AF137D29FD3E3FB09732817BDB0C7C7C3E8ED", 0);

  if(level._id_12693)
    self playershow();
}