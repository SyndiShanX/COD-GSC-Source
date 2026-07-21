/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_challenges.gsc
***********************************************/

init() {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB") {
    return;
  }
  level._encstr_A3A71A984E7D1B340BB18D959B3B5656EC58B1BA2C3A7BE4CCEADCD8 = ::getallspawninstances;
  _id_12B14("_encstr_B1951998C97DD658CDD1CA9C5EF599A59DB234BD9BD1C9B036D1E6", ::player_equipment_init);
  _id_12B14("_encstr_82F920FAAE7E27D66F202A53A0DF4AF710185452C9C1631C0F90124BC8D182A78875", ::_id_127DB);
  _id_12B14("_encstr_828A1FB96AA7904F33DBDBFDC7D90F3839C5E33595C1C0722923D7FBBFD2DF30C3", ::_id_127DC);
  _id_12B14("_encstr_8E071D064A4790839A0B78C8F3B9BF03CBC59B0BB353599343F2E839EA8D69", ::force_dismount);
  _id_12B14("_encstr_A7311980D01767F9A33B0F22D37F2F54A5D37B764B3F1F81CC51C2", ::scavenger_vo_when_close);
  _id_12B14("_encstr_954C1C2639EB5B58DC3A59C9F27D93F6EAE68C695A1B1B8AC32BC6EAE895", ::_id_12DB8);
  _id_12B14("_encstr_BAB1164BFD11D5F1DBC5F7D860011B2E017B7D4897EF1BD5", ::_id_13D08);
}

_id_12B14(var_0, var_1) {
  if(!isDefined(level.debugprintteams))
    level.debugprintteams = [];

  level.debugprintteams[var_0] = var_1;
}

getallspawninstances(var_0, var_1) {
  if(!isDefined(level.debugprintteams)) {
    return;
  }
  if(istrue(level.getarenapickupattachmentoverrides)) {
    return;
  }
  var_2 = level.debugprintteams[var_0];

  if(isDefined(var_2))
    self thread[[var_2]](var_0, var_1);
}

cheesewedgeprompt(var_0) {
  if(getdvarint("_encstr_AF45177B265A575393694369A6F1BA83BDD75D81C95D9DA51F", 0))
    iprintlnbold("_encstr_A93C146A0B9BA3CAC95E80D086B0C61BB2E6EC2BD140" + var_0 + "_encstr_A72F0C108DF6AD38C6AC3A2B1984");

  scripts\cp\vehicles\vehicle_compass_cp::_id_12004(var_0);
}

_id_11B1D(var_0) {
  if(!isDefined(level.teamdata[var_0])) {
    return;
  }
  foreach(var_2 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  _id_13D07(var_2);

  if(getdvarint("_encstr_A70E1B3AD7DBB696BB8F3168DA1AA12D68973D03592FB320F38311837A", 0)) {
    _id_13F74(var_0);
    _id_11E54(var_0);
  }
}

_id_13F74(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0;
  var_2 = 0;
  var_3 = max(1, level.maxteamsize);

  foreach(var_5 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    var_1 = var_1 + var_5.deaths;

    if(isDefined(var_5._id_11BE1))
      var_1 = var_1 + var_5._id_11BE1;

    if(scripts\mp\utility\player::isreallyalive(var_5))
      var_2++;
  }

  if(var_1 == 0) {
    foreach(var_5 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
    var_5 cheesewedgeprompt("_encstr_8E6417731067B1EFC793EF8B330F23BDA1E78DE6A4389521BD");
  }
}

_id_11E53() {
  if(!isDefined(self) || !isDefined(self.team)) {
    return;
  }
  var_0 = self.deaths;
  var_1 = self.team;

  foreach(var_3 in level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"]) {
    if(scripts\mp\utility\player::isreallyalive(var_3)) {
      if(!isDefined(var_3._id_11BE1))
        var_3._id_11BE1 = 0;

      var_3._id_11BE1 = var_3._id_11BE1 + var_0;
      break;
    }
  }
}

_id_11E54(var_0) {
  var_1 = 7;

  if(!isDefined(var_0)) {
    return;
  }
  if(_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::usingtacmap()) {
    return;
  }
  var_2 = 0;

  foreach(var_4 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    var_2 = var_2 + var_4.deaths;

    if(isDefined(var_4._id_11BE1))
      var_2 = var_2 + var_4._id_11BE1;
  }

  if(var_2 >= var_1) {
    foreach(var_4 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
    var_4 cheesewedgeprompt("_encstr_A6A91786D341EFDF23639A23EBC7E5389B7BD27FF1734381E2");
  }
}

player_equipment_init(var_0, var_1) {
  if(!isDefined(self.team)) {
    return;
  }
  if(_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(self.egress_landlord_vo) < 5) {
    return;
  }
  var_2 = isDefined(level.gulag) && !istrue(level.gulag.shutdown);

  foreach(var_4 in level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"]) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      return;
    }
    if(var_2 && var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal())
      return;
  }

  cheesewedgeprompt(var_0);
}

_id_127DB(var_0, var_1) {
  var_2 = var_1._id_123A1;
  var_3 = var_1._id_13A8A;

  if(!isDefined(var_2) || !isDefined(var_2.brbonusxpallowed) || !isDefined(var_2.streakinfo) || !isDefined(var_3)) {
    return;
  }
  var_4 = var_2.streakinfo;

  if(distancesquared(self.origin, var_3) > squared(432)) {
    return;
  }
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_B6292107DB5A9B4790C658CD5BFAB096E4E6D19C2DB62BAFDAA5B1D83A935836ADAC4E");
  self endon("_encstr_B6292107DB5A9B4790C658CD5BFAB096E4E6D19C2DB62BAFDAA5B1D83A935836ADAC4E");
  scripts\engine\utility::_id_143B9(10.0, "_encstr_8E4614852DE4DC3A4E96AD56F5335ADC4BDCD0598CF5" + var_2.brbonusxpallowed);

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  if(var_4.kills >= 3)
    cheesewedgeprompt("_encstr_87F72098E4AFADC29BD12B39CB7D83F696E6478436B0375B4DD1E4B258DA964B63C6");
}

_id_127DC(var_0, var_1) {
  var_2 = var_1.streakinfo;
  var_3 = var_1._id_13A8A;

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  if(distancesquared(self.origin, var_3) > squared(432)) {
    return;
  }
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_84822062C85362FCC5F01F1BF05EB43A0357EC5EACFFC93B4818237B50F19BA2FB76");
  self endon("_encstr_84822062C85362FCC5F01F1BF05EB43A0357EC5EACFFC93B4818237B50F19BA2FB76");
  scripts\engine\utility::_id_143BA(20, "_encstr_B67718E6348F33893F4B89E0C3124BC8279FFC6B9EA77BF96712");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  if(var_2.kills >= 3)
    cheesewedgeprompt("_encstr_87F72098E4AFADC29BD12B39CB7D83F696E6478436B0375B4DD1E4B258DA964B63C6");

  return;
}

force_dismount(var_0, var_1) {
  var_2 = var_1.meansofdeath;
  var_3 = var_1.inflictor;

  if(!isDefined(var_2) || var_2 != "_encstr_B45C0E2DFF41B17F437FB870E733FBFF") {
    return;
  }
  if(!vandalize_attack_nodes(var_3)) {
    return;
  }
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_9AB2187DB85BE1398FE84259A2E4DB79935599F50CA3EC4BB502");
  self endon("_encstr_9AB2187DB85BE1398FE84259A2E4DB79935599F50CA3EC4BB502");

  if(!isDefined(self._id_12A83))
    self._id_12A83 = 0;

  self._id_12A83++;
  wait 4.0;

  if(isDefined(self._id_12A83) && self._id_12A83 >= 3) {
    cheesewedgeprompt(var_0);
    var_4 = force_call_lz(var_3);
    var_5 = isDefined(var_4) && isDefined(var_4.team) && isDefined(self.team) && var_4.team == self.team;

    if(var_5)
      var_4 cheesewedgeprompt(var_0);
  }

  self._id_12A83 = undefined;
}

vandalize_attack_nodes(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_0.vehiclename) && !var_0 scripts\common\vehicle_code::vehicle_is_stopped()) {
    var_1 = var_0 getlinkedchildren();

    foreach(var_3 in var_1) {
      if(isDefined(var_3.weapon_name) && var_3.weapon_name == "_encstr_9AAE0876FCB7603101DB")
        return 1;
    }
  } else if(isDefined(var_0.weapon_name) && var_0.weapon_name == "_encstr_9AAE0876FCB7603101DB") {
    var_5 = var_0 getlinkedparent();

    if(isDefined(var_5) && isDefined(var_5.vehiclename) && !var_5 scripts\common\vehicle_code::vehicle_is_stopped())
      return 1;
  }

  return 0;
}

force_call_lz(var_0) {
  if(isDefined(var_0) && isDefined(var_0.weapon_name) && var_0.weapon_name == "_encstr_9AAE0876FCB7603101DB") {
    var_1 = var_0 getlinkedparent();

    if(isDefined(var_1))
      return var_1.owner;
  }

  return undefined;
}

_id_12DB8(var_0, var_1) {
  var_2 = var_1.player;

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(var_2.modifiers["_encstr_B1100A561EACC6AB3AB47BCD"]) && var_2.modifiers["_encstr_B1100A561EACC6AB3AB47BCD"] == 1)
    var_2 cheesewedgeprompt("_encstr_954C1C2639EB5B58DC3A59C9F27D93F6EAE68C695A1B1B8AC32BC6EAE895");
}

scavenger_vo_when_close(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(self)) {
    return;
  }
  var_2 = var_1.onplayerkillednew;
  var_3 = var_1._id_11A6C;

  if(istrue(var_2)) {
    if(istrue(self.should_run_sp_stealth) && self._id_12A84 != 0) {
      return;
    }
    self.should_run_sp_stealth = 1;
  }

  if(!istrue(self.should_run_sp_stealth)) {
    return;
  }
  self notify("_encstr_ACC50E4178BF2B436D238F57A7EC500B");
  self endon("_encstr_ACC50E4178BF2B436D238F57A7EC500B");

  if(!isDefined(self._id_12A84))
    self._id_12A84 = 0;

  if(istrue(var_3))
    self._id_12A84++;

  wait 4.0;

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_12A84) && self._id_12A84 >= 3)
    cheesewedgeprompt(var_0);

  self._id_12A84 = undefined;
  self.should_run_sp_stealth = undefined;
}

_id_13D08(var_0, var_1) {
  var_2 = -1;

  if(getdvarint("_encstr_A70E1B3AD7DBB696BB8F3168DA1AA12D68973D03592FB320F38311837A", 0) == 0) {
    return;
  }
  var_3 = var_1.inflictor;

  if(!isDefined(var_3)) {
    return;
  }
  if(!isPlayer(var_3)) {
    if(isDefined(var_3.owner) && isPlayer(var_3.owner))
      var_3 = var_3.owner;
    else
      return;
  }

  var_4 = var_1.victim;

  if(!isDefined(var_4) || !isPlayer(var_4)) {
    return;
  }
  var_5 = 0;
  var_6 = var_3 _encstr_B2372553095ECF72D09FAFE571E27F3709619B7BF3BDEFFD588527F36BA0C547ADBB6396790E57::removematchingents_bymodel(var_3);

  if(var_6 != var_2)
    var_5 = var_5 | 1 << var_6;

  var_6 = var_4 _encstr_B2372553095ECF72D09FAFE571E27F3709619B7BF3BDEFFD588527F36BA0C547ADBB6396790E57::removematchingents_bymodel(var_4);

  if(var_6 != var_2)
    var_5 = var_5 | 1 << var_6;

  if(var_5 == 0) {
    return;
  }
  foreach(var_8 in level.teamdata[var_3.team]["_encstr_9775086022BE1B413B8B"]) {
    if(!isDefined(var_8._id_14727))
      var_8._id_14727 = 0;

    var_8._id_14727 = var_8._id_14727 | var_5;
  }
}

_id_13D07(var_0) {
  var_1 = 12;

  if(!isDefined(var_0._id_14727) || var_0._id_14727 == 0) {
    return;
  }
  var_2 = 0;

  for(var_3 = 0; var_3 < level.calloutglobals._id_11E29.size; var_3++) {
    var_4 = var_0._id_14727 & 1 << var_3;

    if(var_4)
      var_2++;
  }

  if(var_2 >= var_1)
    var_0 cheesewedgeprompt("_encstr_BAB1164BFD11D5F1DBC5F7D860011B2E017B7D4897EF1BD5");

  return;
}