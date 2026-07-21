/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\adrenaline.gsc
***********************************************/

init() {}

_id_11D0F() {
  self._id_138AC = 1;
  wait 3;
  self._id_138AC = undefined;
}

useadrenaline() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9BD1119356ADB7D95682C8392B9B588D4B3759");
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  thread _id_11D0F();
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(getdvarint("_encstr_9BE9226B40BD81D7C17E25569FA8BF95CB09C0F13973853B98E4175F2C512BDF4DC00B1A", 1) == 1) {
    var_0 = scripts\mp\utility\game::unset_relic_grounded();

    if(var_0) {
      if(isDefined(self.are_players_nearby_turret) && isDefined(self.are_players_nearby_turret["_encstr_9A570C4FD8FF88ADE7B260684BA3"])) {
        var_1 = self.are_players_nearby_turret["_encstr_9A570C4FD8FF88ADE7B260684BA3"].mp_layover_patch - gettime();
        var_1 = var_1 / 1000;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_84BF17C8FB0901083795CE45786F73C96F127099525D47C313", "_encstr_8D8B0F48038BBF7D4A79F340F0FF067A33"))
          self.are_players_nearby_turret["_encstr_9A570C4FD8FF88ADE7B260684BA3"][[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_84BF17C8FB0901083795CE45786F73C96F127099525D47C313", "_encstr_8D8B0F48038BBF7D4A79F340F0FF067A33")]](var_1 + 3);

        return 1;
      } else
        thread _id_12170();
    }
  }

  adrenaline_missiononuse();
  self.adrenalinepoweractive = 1;
  self refreshsprinttime();
  childthread adrenaline_removeonplayernotifies();
  childthread adrenaline_removeondamage();
  childthread adrenaline_removeongameend();
  self setclientomnvar("_encstr_8868145074B9632D01CB1DC01112FBD05BEEA1192D75", 1);
  return 1;
}

removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("_encstr_9BD1119356ADB7D95682C8392B9B588D4B3759");
    self.adrenalinepoweractive = undefined;
  }
}

onequipmenttaken(var_0, var_1) {
  removeadrenaline();
}

onequipmentfired(var_0, var_1, var_2) {
  if(self isthrowingbackgrenade()) {
    self _meth_87A9();

    if(isDefined(var_2)) {
      var_3 = self getweaponammoclip(var_2);
      var_4 = int(max(var_3 - 1, 0));
      self setweaponammoclip(var_2, var_4);
    }
  }

  useadrenaline();
}

gethealthperframe() {
  return 8;
}

adrenaline_removeonplayernotifies() {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8FB50718DD41DB3FA9");
  thread removeadrenaline();
}

adrenaline_removeondamage() {
  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(level.deletescriptableinstanceaftertime_proc) && istrue(level.deleteallglass) && isPlayer(var_1) && var_1 != self && var_0 > level.deletescriptableinstanceaftertime_proc) {
      if(istrue(level.deleteable))
        self notify("_encstr_85211042E803A51BFF1DCFC5A007232CB55B");

      thread removeadrenaline();
      return;
    }

    if(level.gametype == "_encstr_B607038AAB" && (var_4 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3" || var_4 == "_encstr_BDB50C41D83F8F9F030B60E80F5B")) {
      continue;
    }
    thread removeadrenaline();
    return;
  }
}

adrenaline_removeongameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread removeadrenaline();
}

adrenaline_missiononuse() {
  if(self.health >= self.maxhealth) {
    self.usedadrenalineatfullhp = 1;
    thread adrenaline_missionondeaththink();
  }
}

adrenaline_missionondeaththink() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_97D31FEF71FAFDA616B0E868AB190D9C934F03B56D1CD89DB1535344B10B43933A");
  self endon("_encstr_97D31FEF71FAFDA616B0E868AB190D9C934F03B56D1CD89DB1535344B10B43933A");
  self waittill("_encstr_AD75063D571AE108");
  self.usedadrenalineatfullhp = undefined;
}

_id_12170() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self;
  var_0 binoculars_isads();
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", getdvarint("_encstr_92C622CD6C39FA85329395CDB0D8963756AFB79D2B93C89CB4CECABE8C5D2716E8D2DBB9", 3));

  if(isDefined(self.are_players_nearby_turret) && isDefined(self.are_players_nearby_turret["_encstr_9A570C4FD8FF88ADE7B260684BA3"])) {
    return;
  }
  var_0 binoculars_hidetargetmarker();
}

binoculars_isads() {
  self.movespeedscaler = level.deletesecretstashhud;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  binoculars_init();
}

binoculars_hidetargetmarker() {
  self notify("_encstr_933813DC8E7B837AECB22732275A9DAC28EA23B4B7");

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::removeperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::removeperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::removeperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
  self lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
  binoculars_hascoldblooded();
}

binoculars_init() {
  if(!isDefined(self._id_12147)) {
    self._id_12147 = self.operatorcustomization.suit;
    self.operatorcustomization.suit = "_encstr_8388125E35ED5A7E3978879318533DC289C02592";
    scripts\mp\utility\player::_setsuit("_encstr_8388125E35ED5A7E3978879318533DC289C02592");
  }
}

binoculars_hascoldblooded() {
  if(isDefined(self._id_12147)) {
    self.operatorcustomization.suit = self._id_12147;
    scripts\mp\utility\player::_setsuit(self._id_12147);
    self._id_12147 = undefined;
  }
}