/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dmz_bosses_chopper.gsc
*******************************************************/

_id_C96F19C0BEBDC014() {
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896._id_B586C70B173DD02B = [];
  _id_AED74300DAF62896.name = "chopper";
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = ::_id_A98B4087642D8E07;
  _id_AED74300DAF62896.spawnfunc = ::_id_369A1DFB674D9262;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = ::_id_369A1DFB674D9262;
  _id_AED74300DAF62896._id_7232C52496C3A94A = ::_id_463307A73B2CD8DF;
  _id_2FDEB8023287BE67::_id_469ECEAE21900C7D(_id_AED74300DAF62896, "additive", 1);
  _id_2FDEB8023287BE67::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
}

_id_A98B4087642D8E07(_id_AED74300DAF62896) {
  level._id_CB36BEA0DB8A829F = getdvarint("dvar_41A5F023A6B9D7B6", 100);
  level._id_0D44040648E9624F = getdvarint("dvar_2E1A1EE4432BA896", 4000);
  level._id_426503BD899FE79D = getdvarint("dvar_F8CFA0A3E3979732", 6000);
  level._id_8B0166C08F79BA6F = getdvarint("dvar_0FB9F16D91BCC8A8", 420);
  level._id_AF333105A68EDCAF = getdvarint("dvar_D539A28855E76E9A", 0);
  level._id_72F4AE7B6CC41376 = getdvarint("dvar_4B206BD3A88E108B", 360);
  level._id_7317A07B6CEA3C64 = getdvarint("dvar_4AFD81D3A867F935", 440);
  level._id_6884E659BD874ED9 = getdvarint("dvar_29C7A74C7B9DD1B2", 3);
  level._id_920D2D352811F372 = getdvarint("dvar_4E73BB68DF397FBF", 6);
  level._id_EDA461803CDADC2C = getdvarint("dvar_995DD383D134E9ED", 10000);
  level._id_FDD8206D27C6E843 = getdvarint("dvar_7926DA00AFDCD474", 4500);
  level._id_147A8BCA293848EA = getdvarint("dvar_87A6941B45C05399", 4);
  level._id_C11E773465A38FB7 = getdvarint("dvar_B45A6072BEE6B2D4", 15);
  level._id_F787CF36B2E0E7F7 = getdvarint("dvar_369E173B0E8D08BA", 12);
  level._id_050B14458069E6DE = getdvarint("dvar_8B1842E92794C807", 7);
  level._id_26C9EB02A050F11A = getdvarint("dvar_CC7FEB01EAE01A3F", 1);
  level._id_103B912267715093 = getdvarint("dvar_45DA2E0688E80016", 5000);
  level._id_808F834A75546C5C = getdvarint("dvar_DD6E4061977972E5", 4);
  level._id_30C5E90E94B964FC = getdvarint("dvar_1DA644016C35BDAD", 0) == 1;
  level._id_E21F87900A38B4E0 = getdvarint("dvar_2B111045E5D27399", 155);
  level._id_E21F8A900A38BB79 = getdvarint("dvar_2B110D45E5D26D00", 75);
  level._id_E21F89900A38B946 = getdvarint("dvar_2B110E45E5D26F33", 10);
  level._id_59C6585D2F989571 = getdvarint("dvar_23583556FB69EC0E", 30) * 1000;
  level._id_BAFF2D8310C2551D = int(level._id_59C6585D2F989571 * 0.4);

  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702()) {
    level._id_80D62FADB785EC94 = ["saba_moderncity"];
    level._id_B4D5F28B79E4C447 = ["saba_moderncity", "saba_observatory"];
  } else if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414())
    level._id_80D62FADB785EC94 = ["sealion_castle", "sealion_coastalruins", "sealion_culdesac", "sealion_powerplant", "sealion_shipwreck", "sealion_watertreatment", "sealion_waterways"];
  else if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1()) {
    level._id_80D62FADB785EC94 = ["delta_castle", "delta_museum"];
    level._id_B4D5F28B79E4C447 = ["delta_castle", "delta_museum"];
  }

  level.averagealliesz = 0;
  level.killstreakweaponmap["chopper_gunner_proj_dmz"] = "chopper_gunner";
}

_id_369A1DFB674D9262(_id_A862EF8246B0E151) {
  if(getdvarint("dvar_E8345A47ED69D00A", 1) != 1) {
    return;
  }
  if(!scripts\engine\utility::_id_51D76700600CEBE3(level._id_CB36BEA0DB8A829F)) {
    return;
  }
  level thread _id_289402BE40270FB7(_id_A862EF8246B0E151);
}

_id_289402BE40270FB7(_id_A862EF8246B0E151) {
  instance = _id_2FDEB8023287BE67::_id_2E6E2B664DFE3186("chopper");
  instance.spawned = 0;
  instance._id_47BDE44B1ACEC603 = "chopper";

  if(isDefined(_id_A862EF8246B0E151) && isstruct(_id_A862EF8246B0E151)) {
    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
      instance._id_91403901A31FA2F8 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(_id_A862EF8246B0E151.origin, 1);
  } else {
    keys = getarraykeys(level._id_ACF99124377543BB);
    keys = scripts\engine\utility::array_randomize(keys);

    foreach(key in keys) {
      if(!isDefined(level._id_80D62FADB785EC94) || !isDefined(scripts\engine\utility::array_find(level._id_80D62FADB785EC94, key))) {
        instance._id_91403901A31FA2F8 = key;
        break;
      }
    }
  }

  if(!isDefined(instance._id_91403901A31FA2F8))
    instance._id_91403901A31FA2F8 = scripts\engine\utility::_id_F1164393DAC4665A(level._id_ACF99124377543BB);

  instance._id_FB1DEF007972B25A = level._id_ACF99124377543BB[instance._id_91403901A31FA2F8];
  instance scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Boss_Dmz", instance._id_FB1DEF007972B25A, 6000);
  scripts\mp\flags::gameflagwait("prematch_done");
  waittime = scripts\engine\utility::ter_op(level._id_AF333105A68EDCAF, randomintrange(level._id_72F4AE7B6CC41376, level._id_7317A07B6CEA3C64), level._id_8B0166C08F79BA6F);
  wait(waittime);
  instance _id_3EAD0708199BA214();
  instance notify("boss_spawned");
}

_id_C2A173266D940D79(chopper) {
  if(isalive(chopper) && isstring(chopper.currentstate)) {
    state = chopper.currentstate;

    if(state == "idle")
      state = "patrol";

    return state;
  }

  return "death";
}

_id_32DA9B74B9E6D888(chopper) {
  if(isDefined(chopper) && isDefined(chopper.currenttarget) && isarray(chopper._id_023CB38899CBA861) && isDefined(chopper._id_023CB38899CBA861[chopper.currenttarget]) && isPlayer(chopper._id_023CB38899CBA861[chopper.currenttarget].player))
    return chopper._id_023CB38899CBA861[chopper.currenttarget].player;

  return undefined;
}

_id_6C1462B3F7B01684(chopper) {
  targetplayer = _id_32DA9B74B9E6D888(chopper);

  if(isPlayer(targetplayer) && isstring(targetplayer.team))
    return targetplayer.team;

  return undefined;
}

_id_3EAD0708199BA214() {
  _id_171F90B9C4C76D44 = self._id_91403901A31FA2F8;

  if(!isDefined(level._id_ACF99124377543BB) || !scripts\engine\utility::array_contains_key(level._id_ACF99124377543BB, _id_171F90B9C4C76D44)) {
    return;
  }
  self._id_FB1DEF007972B25A = self._id_FB1DEF007972B25A + (0, 0, level._id_103B912267715093);
  chopper = _id_978010E5FF5D52BC(self._id_FB1DEF007972B25A);
  chopper._id_0566868292EE2A1B = self;
  self.spawned = 1;
  self._id_E2958F412A7425C0 = chopper;
  self._id_E2958F412A7425C0._id_0109D6AFBC11C5F9 = getdvarint("dvar_ABC9AA0D61DCC958", 3);
  scripts\cp_mp\utility\game_utility::_id_AF5604CE591768E1();

  foreach(team in self._id_7D8AD21E5DFD7C94)
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);

  thread _id_67FE145BDE788912(self._id_FB1DEF007972B25A, _id_171F90B9C4C76D44);
  scripts\mp\weapons::_id_E00B77A9CB4D8322(chopper);
  _id_985AE874212B863E = [];
  _id_985AE874212B863E["idle"] = ["dmz_boss_chopper_escape", 0.0];
  _id_985AE874212B863E["combat"] = ["dmz_boss_chopper_combat", 1.5];
  _id_6B9A0DBBF039DECE = 1;
  thread _id_65F58F3C394DCF9A::_id_B5BE3A44077AEC21(self, _id_985AE874212B863E, level._id_BAFF2D8310C2551D, level._id_59C6585D2F989571, _id_6B9A0DBBF039DECE);
  return chopper;
}

_id_978010E5FF5D52BC(pos, _id_CB38D10F1E6836A1) {
  _id_44DD61E9BC4B4304 = getDvar("dvar_85E8885FCE5027E7", "veh9_mil_air_heli_hind_physics_dmz");
  _id_A5C6D4F05FA73949 = getDvar("dvar_FAD92B3F5A4631F2", "veh9_mil_air_heli_hind_dmz_weapons");
  chopper = _id_784AA75D4A32FA24::_id_4C4DF9AEB773709A(pos, _id_44DD61E9BC4B4304, _id_A5C6D4F05FA73949, level._id_0D44040648E9624F, "dmz_boss_chopper");
  chopper _meth_247AD6A91F6A4FFE(1);
  chopper._id_980D543A9814A36F = 20;
  chopper._id_D31810C7EB37ABFE = 500;
  chopper._id_CD2FA7E9B25262D0 = chopper._id_D31810C7EB37ABFE;
  chopper.currenthealth = level._id_426503BD899FE79D;
  chopper.health = level._id_426503BD899FE79D;
  chopper.maxhealth = level._id_426503BD899FE79D;
  chopper.lootfunc = ::_id_4AD380A5E1B9C51A;
  chopper._id_ECBC9CD30D3DB0BE = [];
  chopper.combatstate = 0;
  chopper.shouldshoot = 1;
  chopper._id_E0BF649E3B37455D = 0;
  chopper._id_C6C4017B9F56BFF4 = ::_id_C23BF5E680C0B0FC;
  chopper._id_F09811D8BB92DF96 = ::_id_80EB9BA6D517FEFE;
  chopper._id_59BCC0EE54CDB593 = ::_id_A5298692F21A8421;
  chopper.funcs["strafe"] = ::_id_0C1FEEB5592D1018;
  chopper._id_580BA3BE57AF233E = 0;
  chopper._id_902492553F7C3DAF = makeweapon("chopper_gunner_proj_dmz");
  chopper._id_47BDE44B1ACEC603 = "chopper";
  chopper setscriptablepartstate("blinking_lights", "on");
  chopper thread _id_7D5210C8E3520F4C();
  self.chopper = chopper;

  if(!istrue(_id_CB38D10F1E6836A1)) {
    _id_2FDEB8023287BE67::_id_8002B09B8348902C(pos, "ui_map_icon_boss_chopper");
    scripts\mp\objidpoolmanager::update_objective_onentity(self.objidnum, chopper);
  }

  scripts\mp\vehicles\damage::set_death_callback(self.chopper.vehiclename, ::_id_31529A6224103B1A);
  thread _id_37985716C0079C86();

  if(isDefined(level._id_D8D4808549090419))
    [[level._id_D8D4808549090419]](self);

  return chopper;
}

_id_37985716C0079C86() {
  self.chopper waittill("death");
  scripts\mp\gameobjects::releaseid();
  _id_2FDEB8023287BE67::_id_3E409004EDF37731("chopper");
}

_id_80EB9BA6D517FEFE(player) {
  if(isDefined(player) && isDefined(player.team) && scripts\cp_mp\utility\player_utility::isreallyalive(player) && isDefined(self._id_ECBC9CD30D3DB0BE[player.team]) && self._id_ECBC9CD30D3DB0BE[player.team] >= level._id_147A8BCA293848EA && !istrue(player.extracted))
    return 1;

  return 0;
}

_id_C23BF5E680C0B0FC(data) {
  scripts\cp_mp\killstreaks\chopper_support::_id_400022DABDB64055(data);

  if(isPlayer(data.attacker))
    _id_2FDEB8023287BE67::_id_9483543F1B1BFA73("chopper", undefined, data.attacker, undefined, 20000);

  switch (self.damagestate) {
    case 0:
      if(self.currenthealth < level._id_426503BD899FE79D * 0.65) {
        self.damagestate = 1;
        self setscriptablepartstate("body_damage_light", "on", 0);
      }

      break;
    case 1:
      if(self.currenthealth < level._id_426503BD899FE79D * 0.25) {
        self.damagestate = 2;
        self setscriptablepartstate("damage_left_wing", "on", 0);
        self setscriptablepartstate("body_damage_medium", "on", 0);
      }

      break;
    case 2:
      if(self.currenthealth < level._id_426503BD899FE79D * 0.05) {
        self.damagestate = 3;
        self setscriptablepartstate("damage_right_wing", "on", 0);
        self setscriptablepartstate("body_damage_heavy", "on", 0);
      }

      break;
    case 3:
    default:
      break;
  }

  if(!self.combatstate)
    _id_4B35485C0AF17453();

  if(isDefined(data.attacker) && isPlayer(data.attacker) && !istrue(level._id_F7CA3F03D0ED22A9)) {
    _id_2FDEB8023287BE67::_id_0AE49568842BCE7E(data.attacker, "chopper", 1);
    self._id_ECBC9CD30D3DB0BE[data.attacker.team] = level._id_147A8BCA293848EA;
  }

  return 1;
}

_id_31529A6224103B1A(data) {
  instance = self._id_0566868292EE2A1B;

  if(isDefined(instance)) {
    instance notify("boss_death");
    instance._id_6181D0250AFA3CEC = 1;
    instance._id_6181DE250AFA5BB6 = data.attacker;
  }

  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(data);
  thread _id_AA4375C53E07B7EC(data.attacker.team);
  thread _id_103478F5D3688256(self, data.attacker);
  self notify("death");
  return 1;
}

_id_AA4375C53E07B7EC(team) {
  chopper = self;

  if(!isstring(team)) {
    return;
  }
  while(isDefined(chopper))
    waitframe();

  _id_74B5B12BB6514385 = 5.0;
  _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_chopper_eliminated", team, _id_74B5B12BB6514385);
  _id_4B5A99C16ABFDFB1 = getdvarint("dvar_DFCAD66B7BA8DA13", 500);

  foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
    if(!isDefined(player._id_8C8050D7D861D06C))
      player._id_8C8050D7D861D06C = 0;

    player._id_8C8050D7D861D06C++;
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199", undefined, undefined, _id_4B5A99C16ABFDFB1, self, undefined, undefined, 1, undefined, 1);
  }
}

_id_7D5210C8E3520F4C() {
  self endon("death");
  level endon("game_ended");

  while(!self.combatstate) {
    players = scripts\common\utility::_id_2D7FD59D039FA69B(self.origin, level._id_FDD8206D27C6E843, 1);
    _id_694236C50BB536FE = [];

    foreach(player in players) {
      if(!isDefined(_id_694236C50BB536FE[player.team])) {
        _id_694236C50BB536FE[player.team] = 1;

        if(!isDefined(self._id_ECBC9CD30D3DB0BE[player.team]))
          self._id_ECBC9CD30D3DB0BE[player.team] = 0;

        self._id_ECBC9CD30D3DB0BE[player.team]++;

        if(self._id_ECBC9CD30D3DB0BE[player.team] >= level._id_147A8BCA293848EA)
          _id_4B35485C0AF17453();
      }
    }

    if(!istrue(level._id_30C5E90E94B964FC)) {
      self setscriptablepartstate("speaker", "idle", 0);
      wait 1;

      if(level.mapname == "mp_sealion")
        self setscriptablepartstate("speaker", "warning_sc", 0);
      else
        self setscriptablepartstate("speaker", "warning", 0);
    }

    wait(level._id_C11E773465A38FB7);
  }
}

_id_4B35485C0AF17453() {
  self.combatstate = 1;
  thread _id_E20F2BA1DCB6F312();
}

_id_E20F2BA1DCB6F312() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(!istrue(level._id_30C5E90E94B964FC)) {
      self setscriptablepartstate("speaker", "idle", 0);
      wait 1;

      if(level.mapname == "mp_sealion")
        self setscriptablepartstate("speaker", "attack_sc", 0);
      else
        self setscriptablepartstate("speaker", "attacking", 0);
    }

    wait(level._id_C11E773465A38FB7);
  }
}

_id_67FE145BDE788912(_id_EB4D81FD840007E2, _id_171F90B9C4C76D44) {
  if(level._id_EDA461803CDADC2C < 0) {
    return;
  }
  if(level._id_EDA461803CDADC2C > 0) {
    playerlist = [];

    foreach(player in level.players) {
      if(distance2dsquared(player.origin, _id_EB4D81FD840007E2) < level._id_EDA461803CDADC2C)
        playerlist[playerlist.size] = player;
    }
  } else
    playerlist = level.players;

  teamlist = [];

  foreach(player in playerlist) {
    if(!isarray(teamlist[player.team]))
      teamlist[player.team] = [];

    teamlist[player.team] = scripts\engine\utility::array_add(teamlist[player.team], player);
  }

  _id_5619598E6A21F53C = [];

  foreach(team, players in teamlist) {
    if(players.size == 1) {
      _id_5619598E6A21F53C[_id_5619598E6A21F53C.size] = players[0];
      continue;
    }

    if(players.size > 1) {
      closestplayer = undefined;

      foreach(player in players) {
        if(!isDefined(closestplayer)) {
          closestplayer = player;
          continue;
        }

        if(isDefined(closestplayer) && isDefined(player)) {
          _id_762F99B56D7DFC4C = distance2dsquared(closestplayer.origin, _id_EB4D81FD840007E2);
          _id_6008EA8BACB77120 = distance2dsquared(player.origin, _id_EB4D81FD840007E2);

          if(_id_6008EA8BACB77120 < _id_762F99B56D7DFC4C)
            closestplayer = player;
        }
      }

      if(isDefined(closestplayer))
        _id_5619598E6A21F53C[_id_5619598E6A21F53C.size] = closestplayer;
    }
  }

  foreach(_id_4C9C6A9AA1F72DF4 in _id_5619598E6A21F53C)
  _id_463307A73B2CD8DF(_id_4C9C6A9AA1F72DF4, 0, 1);
}

_id_4AD380A5E1B9C51A() {
  crate = _id_046CF752D93DC17B::_id_52F17E5FBEC318A6(self.origin, level._id_EF63E063E320ACFC["dmz_boss_drop"], self.origin);

  if(isDefined(crate)) {
    crate unlink();
    crate physicslaunchserver((0, 0, 0), (0, 0, 0));
    _id_212A44A5393C3B34 = crate physics_getbodyid(0);
    physics_setbodycenterofmassnormal(_id_212A44A5393C3B34, (0, 0, -0.75));
    crate.physicsactivated = 1;
    crate.usetime = 10;
    crate setscriptablepartstate("dmz_supply_drop", "usable");
    crate._id_5CC8AC2ED7A3D9FA = ::_id_0E018DDEC11A442B;
  }
}

_id_0E018DDEC11A442B(instance, player) {
  if(!isDefined(instance.contents)) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_konni_safehouse_intel");
    instance _id_552B8E4EA5FF7DF1::_id_D683A60016231237(lootid, 1);
  }
}

_id_A5298692F21A8421(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(target)) {
    return;
  }
  _id_40130BD790669C04 = target.origin;
  _id_DE6CB1958BE41B40 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(target.origin);
  _id_CB9AC661C1F66862 = 1;

  if(isDefined(level._id_B4D5F28B79E4C447) && isDefined(_id_DE6CB1958BE41B40))
    _id_CB9AC661C1F66862 = !scripts\engine\utility::array_contains(level._id_B4D5F28B79E4C447, _id_DE6CB1958BE41B40);

  self.shouldshoot = 1;
  self._id_E0BF649E3B37455D = 0;
  thread _id_D105B5766895909D(target);

  if(isPlayer(target))
    _id_2FDEB8023287BE67::_id_9483543F1B1BFA73("chopper", undefined, target, undefined, 20000);

  for(;;) {
    if(isDefined(target)) {
      self setturrettargetvec(target.origin);

      if(_id_DD5CA63B6CA176B8(target)) {
        if(self._id_580BA3BE57AF233E > level._id_6884E659BD874ED9) {
          if(level._id_920D2D352811F372 > 0 && self.damagestate < 3 && _id_CB9AC661C1F66862)
            _id_784AA75D4A32FA24::_id_9F656E924A854C1B(target, 4000, 8, randomint(360), 1000);
          else
            _id_E278235100ED92F4(target);
        } else {
          _id_E278235100ED92F4(target);

          if(level._id_920D2D352811F372 > 0 && self.damagestate < 3 && _id_CB9AC661C1F66862)
            _id_784AA75D4A32FA24::_id_9F656E924A854C1B(target, 4000, 8, randomint(360), 1000);
          else
            self._id_580BA3BE57AF233E = 0;
        }
      }
    }

    if(!isDefined(target) || !scripts\cp_mp\utility\player_utility::isreallyalive(target)) {
      _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
      return;
    }

    if(distance2dsquared(_id_40130BD790669C04, target.origin) > 100000000) {
      _id_784AA75D4A32FA24::_id_03BE784D69CC30A0(target, -800);
      _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
      return;
    }

    wait 3;
  }
}

_id_0C1FEEB5592D1018(target) {
  self._id_580BA3BE57AF233E = 0;
  _id_46DA84E8CED274E2 = ["tag_gun_right1", "tag_gun_left1", "tag_gun_right2", "tag_gun_left2"];
  wait 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_920D2D352811F372; _id_AC0E594AC96AA3A8++) {
    if(self.damagestate > 1 && (_id_AC0E594AC96AA3A8 % 4 == 1 || _id_AC0E594AC96AA3A8 % 4 == 3)) {
      wait 0.3;
      continue;
    } else if(self.damagestate > 2) {
      wait 0.3;
      continue;
    }

    _id_0429AAE2E6E20F85 = self gettagorigin(_id_46DA84E8CED274E2[_id_AC0E594AC96AA3A8 % 4]) + anglesToForward(self.angles + (6, 0, 0)) * 200;
    _id_85FA3CDCB19D2A9C = self gettagorigin(_id_46DA84E8CED274E2[_id_AC0E594AC96AA3A8 % 4]) + anglesToForward(self.angles + (6, 0, 0)) * 1000;
    missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(self._id_902492553F7C3DAF, _id_0429AAE2E6E20F85, _id_85FA3CDCB19D2A9C, self.owner);
    wait 0.3;
  }
}

_id_D105B5766895909D(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");
  self notify("moving_to_engage");
  self endon("moving_to_engage");
  target endon("death_or_disconnect");
  self setlookatent(target);
  _id_29AE2ED56E057510 = 0;
  timer = 0;

  for(;;) {
    if(!istrue(self._id_652BF3292E2A7755)) {
      if(!isDefined(target) || !isDefined(target.origin))
        _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");

      _id_C3FBB6661B91750F = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0);
      canseetarget = scripts\engine\trace::ray_trace_passed(target.origin, self.origin, self.ignorelist, _id_C3FBB6661B91750F) && !target.notarget;

      if(timer > level._id_808F834A75546C5C || !canseetarget || distance2dsquared(target.origin, self.origin) > 20250000 || distance2dsquared(target.origin, self.origin) < 2250000) {
        timer = 0;

        if(!_id_784AA75D4A32FA24::_id_E9CB677B6BA63162(target, 3000, 8, randomint(360))) {
          _id_29AE2ED56E057510++;

          if(_id_29AE2ED56E057510 > level._id_26C9EB02A050F11A)
            self._id_E0BF649E3B37455D = 1;

          if(_id_29AE2ED56E057510 > level._id_050B14458069E6DE)
            self.shouldshoot = 0;

          if(_id_29AE2ED56E057510 > level._id_F787CF36B2E0E7F7) {
            _id_784AA75D4A32FA24::_id_03BE784D69CC30A0(target, -500);
            _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
          }
        } else {
          self._id_E0BF649E3B37455D = 0;
          self.shouldshoot = 1;
        }
      } else {
        self._id_E0BF649E3B37455D = 0;
        self.shouldshoot = 1;
      }
    }

    timer = timer + 0.5;
    wait 0.5;
  }
}

_id_E278235100ED92F4(target) {
  self endon("death");
  self endon("crashing");
  self endon("state_change");

  if(!isDefined(target)) {
    return;
  }
  _id_B0B68854AE03B4D7 = level._id_E21F87900A38B4E0;
  _id_795D7F662BA7E1A1 = 0;
  self._id_D706B7E51984C2EC = undefined;
  self._id_580BA3BE57AF233E++;
  guid = target.guid;
  dir = anglesToForward(target.angles);
  _id_6EF6398383AE0CF6 = vectorNormalize((dir[0], dir[1], 0));

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 100; _id_AC0E594AC96AA3A8++) {
    if(self.health <= 0) {
      return;
    }
    if(!isDefined(target)) {
      if(isDefined(guid))
        _id_784AA75D4A32FA24::_id_83388ED388DDBDDC(guid);

      _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
      return;
    }

    if(scripts\cp_mp\utility\player_utility::isreallyalive(target) && istrue(target.inlaststand)) {
      _id_784AA75D4A32FA24::_id_03BE784D69CC30A0(target, -2000);
      _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
      return;
    }

    if(_id_AC0E594AC96AA3A8 == 35)
      _id_B0B68854AE03B4D7 = level._id_E21F8A900A38BB79;
    else if(_id_AC0E594AC96AA3A8 == 65)
      _id_B0B68854AE03B4D7 = level._id_E21F89900A38B946;

    if(self._id_E0BF649E3B37455D && !isDefined(self._id_D706B7E51984C2EC)) {
      self._id_D706B7E51984C2EC = _id_B0B68854AE03B4D7;
      _id_795D7F662BA7E1A1 = 50;
      _id_B0B68854AE03B4D7 = int(level._id_E21F87900A38B4E0);
    } else if(!self._id_E0BF649E3B37455D && isDefined(self._id_D706B7E51984C2EC)) {
      _id_B0B68854AE03B4D7 = self._id_D706B7E51984C2EC;
      _id_795D7F662BA7E1A1 = 0;
      self._id_D706B7E51984C2EC = undefined;
    }

    if(!self.shouldshoot) {
      wait 0.1;
      continue;
    }

    _id_91BE2B7482F940BA = undefined;

    if(isDefined(target))
      _id_91BE2B7482F940BA = target.origin;

    if(isPlayer(target))
      _id_91BE2B7482F940BA = target gettagorigin("j_spineupper");

    if(!isDefined(_id_91BE2B7482F940BA)) {
      if(isDefined(guid))
        _id_784AA75D4A32FA24::_id_83388ED388DDBDDC(guid);

      _id_784AA75D4A32FA24::_id_7743AEFF79A08975("idle");
      return;
    }

    _id_A0A41BA05E16FFE6 = randomint(_id_B0B68854AE03B4D7) + _id_795D7F662BA7E1A1;
    _id_9E5D403038E4C071 = randomint(360);
    x = _id_91BE2B7482F940BA[0] + _id_A0A41BA05E16FFE6 * cos(_id_9E5D403038E4C071);
    y = _id_91BE2B7482F940BA[1] + _id_A0A41BA05E16FFE6 * sin(_id_9E5D403038E4C071);
    z = _id_91BE2B7482F940BA[2];
    point = (x, y, z);

    if(self._id_CD2FA7E9B25262D0 > 0) {
      point = point + _id_6EF6398383AE0CF6 * self._id_CD2FA7E9B25262D0;
      self._id_CD2FA7E9B25262D0 = self._id_CD2FA7E9B25262D0 - self._id_980D543A9814A36F;
    }

    self setturrettargetvec(point);
    wait 0.1;
    self fireweapon();
  }

  self._id_CD2FA7E9B25262D0 = self._id_D31810C7EB37ABFE;
}

_id_DD5CA63B6CA176B8(target) {
  _id_97F0985016AA48CB = 0.8;
  _id_929AD65D451FFC68 = anglesToForward(self gettagangles("tag_flash"));
  _id_EFA57ADC48838F9B = vectorNormalize(target.origin - self gettagorigin("tag_flash"));
  _id_FF53E400DD536B82 = vectordot(_id_929AD65D451FFC68, _id_EFA57ADC48838F9B);
  return _id_FF53E400DD536B82 >= _id_97F0985016AA48CB;
}

_id_6326EFAEA227C12A(turret) {
  if(isDefined(self.currenttarget) && self.currenttarget == turret.attackingtarget) {
    self.currenttarget._id_5B7ED65D780010D7 = gettime();
    self.currenttarget = undefined;
  }

  if(istrue(turret.targetbrokelos))
    turret.targetbrokelos = undefined;

  turret.attackingtarget = undefined;
  turret cleartargetentity();
  turret.groundtargetent unlink();
  turret notify("lost_target");
}

_id_463307A73B2CD8DF(player, showicon, _id_91E5939BCABA8460) {
  team = player.team;

  if(scripts\engine\utility::array_contains(self._id_7D8AD21E5DFD7C94, team))
    return 0;

  if(istrue(self.spawned) && !isDefined(self.chopper))
    return 0;

  self._id_7D8AD21E5DFD7C94 = scripts\engine\utility::array_add(self._id_7D8AD21E5DFD7C94, team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");
  _id_AC4C51BF033F6323 = players;

  if(!istrue(self.spawned)) {
    foreach(player in players)
    scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(player);
  } else {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, team);
    _id_6B9A0DBBF039DECE = 1;

    if(istrue(_id_91E5939BCABA8460))
      _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, self._id_FB1DEF007972B25A, level._id_EDA461803CDADC2C, "dmz_boss_chopper_approach", 1.5, _id_6B9A0DBBF039DECE);
    else
      _id_65F58F3C394DCF9A::_id_5C07A5046A6DC0F4(team, player, level._id_B1149892B2595056, "dmz_boss_chopper_approach", 1.5, _id_6B9A0DBBF039DECE);
  }

  _id_171F90B9C4C76D44 = undefined;

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913())
    _id_171F90B9C4C76D44 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(self._id_FB1DEF007972B25A, 1, 0);

  _id_1B4ADA49A21B51CA = scripts\engine\utility::ter_op(istrue(self.spawned), "dmz_chopper_revealed", "dmz_chopper_revealed_circle");
  _id_4480C6CE37B2BDF3::_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, _id_AC4C51BF033F6323, _id_171F90B9C4C76D44);
  thread _id_1F97A44D1761C919::_id_9793A81BC3BC19E9("boss_chopper_near", team, 2.0);
  return 1;
}

_id_103478F5D3688256(chopper, _id_6181DE250AFA5BB6) {
  _id_0566868292EE2A1B = chopper._id_0566868292EE2A1B;
  _id_0566868292EE2A1B notify("stop_boss_ai_music_thread");
  _id_65F58F3C394DCF9A::_id_CAEAF68AB0E87565(_id_0566868292EE2A1B._id_085E53E70C7110DA, "");

  while(isDefined(chopper))
    waitframe();

  _id_65F58F3C394DCF9A::_id_73F954808739F7BC(_id_0566868292EE2A1B, _id_6181DE250AFA5BB6, "dmz_boss_chopper_win", 2.5, "dmz_boss_chopper_escape", 0.0);
}