/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_jugg_common.gsc
***********************************************/

init() {
  level.battle_tracks_stopbattletracksforplayer = ::_id_13140;
  level.battle_tracks_standingonvehicletimeout = ::battle_tracks_standingonvehicletimeout;
  level.headiconbox = ::minigun_wait_between_shot_rounds;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_BDE210BD9B1A93C28E955036E84B9DC2A395", ::_id_1200D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_B29F0BB0BA576E58532DEBDF55", ::_id_1200F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AD750E3E92F9DDAB6767D8785BB96329", "_encstr_85DA0F72482643D63053E4CD57185A6F63", ::_id_1200E);
  level thread _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::init();
  level.activejuggernauts = [];
  level.display_hint_for_player = [];
  thread toggleusbstickinhand();
}

toggleusbstickinhand() {
  waittillframeend;
  terminal_pusher_approaches_init();
  level._id_11F2C = 0;
}

_id_13140() {
  self._id_12173 = 100;
  self._id_12172 = 3.0;
  self._id_12176 = 1.0;
  self._id_12175 = 0.5;
  self._id_12174 = 5;
  self.infiniteammo = 0;
  self.maxhealth = getdvarint("_encstr_A5FE1383890B3EFA330FB30F7ADAE1DA4D4E73D3DA", 2000);
  self.startinghealth = getdvarint("_encstr_A5FE1383890B3EFA330FB30F7ADAE1DA4D4E73D3DA", 2000);
  self._id_14232 = int(self.maxhealth / self._id_11B7D);
  var_0 = getdvarint("_encstr_86DE1A37B1C9AFC44EFA4DEA3B3BEBEE2B0B38B7E6F507D236ADEA07", 0);
  self._id_140A7 = var_0;
  var_1 = getdvarint("_encstr_A9FF1307834221E61B398813C2373093DF14B79B2C", 1);

  if(var_1) {
    self.classstruct.loadoutprimary = "_encstr_8B161CE1674A5927235032DA1B88670AB01B67779FA01FEBD8A9DA4160DF";
    self._id_14092 = var_1;
  }

  self.allows["_encstr_AF4D07932B1BDE5846"] = undefined;
}

_id_11C95(var_0) {
  var_1 = getdvarfloat("_encstr_B82A1906669B07F9C2D7F0300FEF969D5381F487FAE1E781B97380", 7.0);
  var_2 = var_0 * var_1;
  return int(var_2);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1 scripts\mp\utility\killstreak::isjuggernaut() && getdvarint("_encstr_AF621E53095E17F4D8B7E7D775B07F2788265ABAD139F32CB1BF16CF7F88C54B", 1)) {
    var_10 = var_1.health;
    var_11 = int(var_1.maxhealth / 6);
    var_12 = var_10 + var_11;

    if(var_12 > var_1.maxhealth)
      var_12 = var_1.maxhealth;

    var_1.health = var_12;
    var_1 notify("_encstr_91D212A8FF87DA0F68274FB5BBE9AF3D25942788");
  }

  if(isDefined(self) && scripts\mp\utility\killstreak::isjuggernaut())
    self.stadium_puzzle = undefined;
}

battle_tracks_standingonvehicletimeout() {
  var_0 = self.juggcontext.juggconfig;
  var_1 = getdvarint("_encstr_A2E4151B41164FAEA8FF22259758B9C7BC39833269673B", 0);

  if(var_1) {
    thread _id_144EA(var_0);
    thread _id_144DE(var_0);
  }

  thread _id_11AB6(var_0);
}

minigun_wait_between_shot_rounds() {
  var_0 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::minplunderextractions(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missiontime(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::mintokensdropondeath(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missedinfilplayerhandler(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missing_window_blockers(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::mix_loot_pickups(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missions_clearinappropriaterewards(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::missed_shots(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::mix(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::modifycrushdamage(var_0);
}

terminal_pusher_approaches_init() {
  if(!isDefined(level.calloutglobals.calloutzones) || level.calloutglobals.calloutzones.size == 0) {
    return;
  }
  level.vehicle_isneutraltoplayer = [];
  level.vehicle_occupancy_isenemytoplayer = [];

  foreach(var_3, var_1 in level.calloutglobals.calloutzones) {
    var_2 = spawnStruct();
    var_2.id = var_3;
    var_2.origin = var_1.origin;
    var_2.occupied = 0;
    level.vehicle_isneutraltoplayer[level.vehicle_isneutraltoplayer.size] = var_2;
  }
}

relic_punchbullets_track_previous_bullet_weapon(var_0) {
  var_1 = undefined;

  if(isDefined(level.vehicle_isneutraltoplayer) && level.vehicle_isneutraltoplayer.size > 0) {
    foreach(var_3 in level.vehicle_isneutraltoplayer) {
      if(!isDefined(level._id_12D05)) {
        if(!updatesmokinggunhud(var_3, var_0))
          continue;
      }

      if(istrue(var_3.occupied)) {
        continue;
      }
      if(update_objective_mlgicon_reset(var_3.origin)) {
        continue;
      }
      if(update_last_stand_id(var_3.origin)) {
        continue;
      }
      if(update_keypad_currentdisplay_models(var_3.origin)) {
        continue;
      }
      var_1 = var_3;
      var_3.occupied = 1;
      level.vehicle_occupancy_isenemytoplayer[level.vehicle_occupancy_isenemytoplayer.size] = var_3;
      break;
    }

    if(!isDefined(var_1))
      var_1 = init_season3_intel_challenges();
  } else {
    var_5 = undefined;
    var_1 = init_season3_intel_challenges(var_5);
  }

  return var_1;
}

updatesmokinggunhud(var_0, var_1) {
  if(level.br_circle_disabled || !isDefined(level.br_circle) || level.br_circle.circleindex < 0)
    return 1;

  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_4 = var_3 + var_1;
  var_5 = var_4 * var_4;

  if(distance2dsquared(var_0.origin, var_2) <= var_5)
    return 1;

  return 0;
}

update_last_stand_id(var_0) {
  var_1 = getdvarint("_encstr_95241B628733898263C1625F5C2F777F9C5E3FC1BB37358F797BFF63D0", 20000);
  var_2 = var_1 * var_1;

  foreach(var_4 in level.focus_fire_attacker_timeout) {
    if(distance2dsquared(var_0, var_4.origin) < var_2)
      return 1;
  }

  return 0;
}

update_keypad_currentdisplay_models(var_0) {
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_2 = int(var_1 - var_1 / 3);
  var_3 = var_2 * var_2;

  foreach(var_5 in level.activejuggernauts) {
    if(isDefined(var_5) && distance2dsquared(var_0, var_5.origin) < var_3)
      return 1;
  }

  return 0;
}

update_objective_mlgicon_reset(var_0) {
  var_1 = getdvarint("_encstr_885F18E6B139D7C4E4D735EACE9DBE1B5A4ED88D59AF372D4FCA", 5000);
  var_2 = 1000;
  var_3 = var_1 * 2 + var_2;
  var_4 = var_3 * var_3;

  foreach(var_6 in level.vehicle_occupancy_isenemytoplayer) {
    if(distance2dsquared(var_0, var_6.origin) < var_4)
      return 1;
  }

  return 0;
}

init_season3_intel_challenges(var_0) {
  var_1 = spawnStruct();

  if(isDefined(var_0)) {
    if(istrue(level._id_14089) && isscriptabledefined())
      var_0 = getclosestpointonnavmesh(var_0);

    var_1.origin = var_0;
  } else {
    var_2 = 10;

    while(!isDefined(var_1.origin)) {
      var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_modifyflagstieronrespawn();

      if(istrue(level._id_14089) && isscriptabledefined())
        var_3 = getclosestpointonnavmesh(var_3);

      if(isDefined(level.activejuggernauts) && level.activejuggernauts.size > 0) {
        if(!update_keypad_currentdisplay_models(var_3))
          var_1.origin = var_3;
      } else
        var_1.origin = var_3;

      var_2--;

      if(var_2 == 0 && !isDefined(var_1.origin))
        var_1.origin = var_3;

      waitframe();
    }
  }

  return var_1;
}

_id_1334B(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = getdvarint("_encstr_885F18E6B139D7C4E4D735EACE9DBE1B5A4ED88D59AF372D4FCA", 5000);
  var_3 = 50000;

  if(istrue(var_1)) {
    if(!istrue(level.br_circle_disabled))
      level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
  } else
    var_3 = 0;

  var_4 = [];

  for(var_5 = 0; var_5 < var_0; var_5++) {
    var_6 = relic_punchbullets_track_previous_bullet_weapon(var_3);
    var_6.clear_legacy_pickup_munitions = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin);
    var_6.clear_legacy_pickup_munitions setModel("_encstr_A2E6149A4380B76CA8893A3FB999B6B3371BF24189EE");
    var_6.clear_legacy_pickup_munitions setscriptablepartstate("_encstr_92C611A9AEB33B7D3293BD0EAFC456B036B737", "_encstr_AB0703DBB9", 0);
    var_6 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::init_tactical_boxes(11, 6, 2, var_6.origin);
    var_6 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1316F(var_2);
    var_6 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13369();
    var_4[var_4.size] = var_6;
  }

  return var_4;
}

_id_1383F(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::ter_op(istrue(level._id_1408B), "_encstr_92C217984E7D0759D7D4AEEC3BAC4EDC0BABD1FA371D2C938E", "_encstr_AFD51532BEA7C277821C7B25A248A9874080986BC3C8A4");
  _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_13371(var_2);

  foreach(var_5, var_4 in var_0) {
    level thread mlgiconfullflag(var_4, var_1);
    wait(randomfloatrange(5.0, 10.0));
  }
}

mlgiconfullflag(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = getdvarint("_encstr_885F18E6B139D7C4E4D735EACE9DBE1B5A4ED88D59AF372D4FCA", 5000);

  if(!isDefined(var_0.modify_blast_shield_damage))
    var_0.modify_blast_shield_damage = var_2;

  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_0.origin, var_0.modify_blast_shield_damage);
  var_4 = _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fn_spec_op_post_customization(undefined, var_3, 1);
  var_5 = distance(var_4.startpt, var_4.endpt);
  var_6 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
  var_7 = var_5 / var_6;
  var_8 = _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fntrapdeactivation(var_4, var_5, var_6, var_7);
  var_8.mode_can_play_ending = ::mode_can_play_ending;
  var_8._id_134E2 = var_1;
  var_8 _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fob(1, "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385", "_encstr_82F50B526FF73A07C3E52B6C68", var_0);
}

mode_can_play_ending(var_0, var_1, var_2, var_3) {
  var_4 = self.startpt;
  var_5 = self.centerpt;
  var_6 = self.speed;
  var_7 = distance2d(var_4, var_5) / var_6;
  var_8 = 0;
  var_9 = 0;

  for(level._id_11F2C = level._id_11F2C + var_0; var_8 < var_0; var_12._id_140A0 = relic_laststand_modifyplayerdamage()) {
    wait(var_7);
    var_10 = _encstr_81572892F3354F39D30B3DE0FBBF8459E8E7034A47B5F32D4646F7B6AA627BEFFB8B3958459825AF23D7::fnchildscorefunc(self.origin, 1);

    if(istrue(level._id_14089) && isscriptabledefined())
      var_10 = getclosestpointonnavmesh(var_10);

    var_11 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_10 + (0, 0, level.fnhidefoundintel - 100), var_10, self.angles, var_1, var_2, var_3._id_11EAB);
    var_8++;
    var_11.ml_p2_func = var_3;
    var_11._id_134E2 = self._id_134E2;
    level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var_11;
    var_12 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_11);
  }
}

_id_144EA(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0._id_12173;
  var_2 = var_0._id_12172;
  var_0.showtutsplash = 0;

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    var_0.showtutsplash++;
    var_0.waittorumbleonslam = gettime();

    if(var_0.showtutsplash >= var_1) {
      iprintlnbold("_encstr_A3C609A897FD2B7441F32C");
      scripts\common\utility::allow_fire(0);
      wait(var_2);
      iprintlnbold("_encstr_A669097198BDE9FD47D7A0");
      scripts\common\utility::allow_fire(1);
    }
  }
}

_id_144DE(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0._id_12176;
  var_2 = var_0._id_12175;
  var_3 = var_0._id_12174;

  for(;;) {
    if(var_0.showtutsplash > 0 && gettime() - var_0.waittorumbleonslam >= var_1 * 1000) {
      var_4 = var_0.showtutsplash - var_2;

      if(var_4 < 0)
        var_4 = 0;

      var_0.showtutsplash = int(var_4);
    }

    wait 0.05;
  }
}

_id_11AB6(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_88B00FB037873113F3557705AB596B58EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 5;

  for(;;) {
    var_2 = scripts\engine\utility::_id_143AD("_encstr_8738123F8928549AAEAF9BBF27D611BDB833F702", "_encstr_91D212A8FF87DA0F68274FB5BBE9AF3D25942788");
    var_3 = 1;

    if(var_2 == "_encstr_8738123F8928549AAEAF9BBF27D611BDB833F702") {
      var_3 = 0;
      self.stadium_puzzle = 1;
      wait(var_1);
    } else if(var_2 == "_encstr_91D212A8FF87DA0F68274FB5BBE9AF3D25942788") {
      var_4 = self.health / self.maxhealth;

      if(var_4 >= 0.75) {
        if(istrue(self.stadium_puzzle))
          self.stadium_puzzle = undefined;
      }
    }

    scripts\mp\healthoverlay::onexitdeathsdoor(var_3);
  }
}

droponplayerdeath(var_0) {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_97F512C8522453515F8CF66090D73889570A8878", var_0);
  level._id_11F2C--;
}

modeaddtoteamlives() {
  var_0 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  var_1 = scripts\engine\trace::ray_trace(self.origin + (0, 0, 40), self.origin - (0, 0, 10000), self, var_0);
  var_2 = self.origin;

  if(isDefined(var_1) && isDefined(var_1["_encstr_AA1C0886968EA32FE056"]) && var_1["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_2 = var_1["_encstr_BD260953AA97E3F014279D"];

  var_3 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(self.origin + (0, 0, 10), var_2, self.angles, "_encstr_A61A1913A6A320E023CF6BA0F08F0A196F3C05D4D70F2B1619B385", "_encstr_82F50B526FF73A07C3E52B6C68");

  if(isDefined(var_3)) {
    var_4 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_3);
    var_4._id_140A0 = relic_laststand_modifyplayerdamage();
  }
}

_id_1200D(var_0) {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AC5F143F5D5A2B1F4805FA06DB6001021DCBD37F0165", var_0);

  if(istrue(var_0)) {
    thread _id_14498();
    thread _id_14497();
  }

  var_1 = getdvarint("_encstr_ADAC2B8703C2A1669BB94B91C187AD381AA73D33AF6F593EB372C399E9DBD40879E5ADB959151170632A988142", 0) == 1;

  if(!var_1 && isDefined(self.ml_p2_func))
    infilvideopreload(self.ml_p2_func);
}

_id_14498() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = getdvarint("_encstr_ADD61BF3EF700F0625B1C09DCCF93776AA91E1133F722FB2D255B3DFCD", 300);
  wait(var_0);
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

_id_14497() {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(level.br_circle_disabled)) {
    return;
  }
  var_0 = getdvarint("_encstr_A1611FA723A2C106FBD968B3629750E87AB92173F74F88D627822DD9AA3373C0D7", 30);

  for(;;) {
    wait 0.05;

    if(!isDefined(level.br_circle) || level.br_circle.circleindex < 0) {
      continue;
    }
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

    if(distance2dsquared(var_1, self.origin) > var_2 * var_2) {
      break;
    }
  }

  wait(var_0);
  scripts\cp_mp\killstreaks\airdrop::destroycrate();
}

_id_1200F(var_0) {
  var_0.vehicle_handleflarefire = self._id_134E2;
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8CBF0F507D400B31BFDF58C86BD50F7FDA", var_0);
  _id_11ECB(var_0);
  infilvideoplay();
}

_id_11ECB(var_0) {
  var_1 = self.origin;
  var_2 = getdvarint("_encstr_885F18E6B139D7C4E4D735EACE9DBE1B5A4ED88D59AF372D4FCA", 5000);
  var_3 = scripts\common\utility::playersincylinder(var_1, var_2);

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && scripts\mp\utility\player::isreallyalive(var_5) && var_5 != var_0) {
      var_6 = "_encstr_86F61989C9F59AAB9D3BFA8DB01CE8AB2756FAE0DECD5AD14B3B2B";

      if(var_5.team != var_0.team)
        var_6 = "_encstr_8F0E1913E4D753AEB3767DD8851C1D5793CABEE6593B853A2DECCA";

      var_5 playlocalsound(var_6);
    }
  }
}

_id_1200E(var_0) {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A64913C0B57A98844A4FAD938B324D50FB8BEB5898", var_0);
  level._id_11F2C--;
  infilvideoplay();
}

infilvideoplay() {
  if(isDefined(self.ml_p2_func))
    infilvideopreload(self.ml_p2_func);

  if(isDefined(level.focus_fire_attacker_timeout))
    level.focus_fire_attacker_timeout = scripts\engine\utility::array_remove(level.focus_fire_attacker_timeout, self);
}

infilvideopreload(var_0) {
  var_0.occupied = 0;

  if(isDefined(var_0.mapcircle))
    var_0 _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::lastdirtyscore();

  if(isDefined(var_0.clear_legacy_pickup_munitions)) {
    var_0.clear_legacy_pickup_munitions setscriptablepartstate("_encstr_92C611A9AEB33B7D3293BD0EAFC456B036B737", "_encstr_BA19049F4B2D");
    var_0.clear_legacy_pickup_munitions delete();
  }
}

strafe_internal(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = "_encstr_8B1608EC43B8D647A113";

  if(!isDefined(level.display_hint_for_player[var_2]))
    level.display_hint_for_player[var_2] = [];

  level.display_hint_for_player[var_2][var_0] = var_1;
}

process_struct_path_tilts(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_1)) {
    if(isDefined(level.display_hint_for_player[var_1]))
      var_2 = level.display_hint_for_player[var_1][var_0];
  }

  if(!isDefined(var_2))
    var_2 = level.display_hint_for_player["_encstr_8B1608EC43B8D647A113"][var_0];

  return var_2;
}

relic_laststand_modifyplayerdamage() {
  return getdvarfloat("_encstr_BECA1B83368209C6DB7FDDFB875280203A0EEBD951ED300D213BD3C3A7", 5);
}

resetafkchecks(var_0) {
  if(istrue(var_0)) {
    var_1 = scripts\mp\utility\teams::resetchallengetimer();
    var_2 = getdvarint("_encstr_9B0D1FE6D8E47D98C9AFA6BA9D3BF53757ADD7E82B58ADB9EB1C59937D234EDEE0", 3);
    var_3 = 1;
    var_4 = max(floor(var_1 / var_2), var_3);
    var_5 = getdvarint("_encstr_93FB169BD8C9EB894ED735AEB3CEBECDAEB6F58C39ED07CD", 3);
    return min(var_5, var_4);
  } else
    return getdvarint("_encstr_93FB169BD8C9EB894ED735AEB3CEBECDAEB6F58C39ED07CD", 3);
}

remove_spawners_that_can_be_seen() {
  return getdvarfloat("_encstr_84E91A889F62E6CD2329C2553FAA6F0BCBD7C820E70FBEA71A4EC955", 1.0);
}

reservedplacement() {
  return getdvarfloat("_encstr_B8561A3E5EA33F310A0F38C8C737AEE3BA85BB4CB33A77DBC30F1070", 1.25);
}