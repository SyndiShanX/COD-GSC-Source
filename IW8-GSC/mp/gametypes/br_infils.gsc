/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_infils.gsc
***********************************************/

main() {
  level.brlatespawnplayer = ::latespawnplayer;
  level.stop_wave = _id_1300F();
  setdvarifuninitialized("_encstr_8F4722127AD7208DD4D1D10176D0F788377AB23B82893F0650EB514B81613F4347126593", 1);
  setdvarifuninitialized("_encstr_878719487B89B3A8F31941D0F823B15B61627888F3D1DBE0E735D6", 1);
  setdvarifuninitialized("_encstr_960D1826A84EE0056BB8AB9712C515B64833DBA1100887C352F2", 0);
  level.infilselectionmethod = "_encstr_B40101";
  level.infilcanusemap = 0;

  if(istrue(getdvarint("_encstr_BE43173276A6875A8380D21908C1578F7B53B7A613680B24B1", 0))) {
    level.infilselectionmethod = getDvar("_encstr_A5F91C6E1B9CFA4CE4EBD2CDCC5A8DCD2B632BC6A3D2DE73DA59D143BD32", "_encstr_A3D70A2BF01B365D6EA5DB37");
    level.infilcanusemap = 1;
    level.get_bomb_interaction_ent_cut_hint = getdvarint("_encstr_8E8A13F7FF0EC152B8CEC64EC099972A6845170741", 1);
  }

  if(istrue(level.br_infils_disabled) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    level thread laser_vfx_think(undefined, 0);

  initspawnexclusionpois();
  initinfillocationselectionhandlers();
}

_id_1300F() {
  var_0 = 2;
  var_1 = getdvarint("_encstr_862211BFAF2DE170431EFA707310927503923B", var_0);

  if(var_1 == 1) {
    if(level.mapname != "_encstr_8CD508CA98A70FAFC01D" && level.mapname != "_encstr_A3F50BC8631F6D20CD64F7A155" && level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE" && !scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent())
      var_1 = 2;
  } else if(var_1 == 2) {
    if(level.mapname == "_encstr_8CD508CA98A70FAFC01D" || scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent())
      var_1 = 1;
    else if(level.mapname != "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319" && level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
      var_1 = 0;
  }

  return var_1;
}

remove_munition_on_use() {
  var_0 = undefined;
  var_1 = undefined;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
    var_0 = 0.0;
    var_1 = 0.0;
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    var_0 = 0.45;
    var_1 = 0.6;
  } else {
    var_0 = 3.45;
    var_1 = 0.6;
  }

  return [var_0, var_1];
}

setplayerprematchallows() {
  scripts\mp\utility\player::enableplayerforspawnlogic(0);
  self allowmelee(0);
  self disableoffhandweapons();
  level.freefallstartcb = ::freefallstartfunc;
}

freefallstartfunc() {
  self allowmelee(1);
  self enableoffhandweapons();
  thread scripts\cp_mp\parachute::_id_126CB();
}

stop_player_trigger_monitor() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(self.class == "_encstr_B40101") {
    self.class = "_encstr_A70708DF6DCAB0B8BF17";
    self.pers["_encstr_959506B911C79707"] = "_encstr_A70708DF6DCAB0B8BF17";
  }

  scripts\mp\playerlogic::spawnplayer(0);
  self.br_infilstarted = 1;
  self notify("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  self setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
}

_id_1435F(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 neurotoxin_damage_loop();
    var_5 setmlgdamagedone();

    if(!istrue(level.br_infils_disabled))
      var_5 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1254D();

    if(!isalive(var_5) && !istrue(var_5.waitingtospawnamortize)) {
      if(isDefined(var_1))
        var_5.forcespawnorigin = var_1;

      var_5 stop_player_trigger_monitor();
    } else {
      var_5.br_infilstarted = 1;

      if(isDefined(var_1))
        var_5 setOrigin(var_1);
    }

    if(!isDefined(var_5)) {
      continue;
    }
    if(isDefined(var_2))
      var_5 playerlinkTo(var_2);

    if(istrue(var_5.delay_enter_combat_after_investigating_grenade))
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(var_5, "_encstr_81E21C17A3287B6F58F91872C326377A380BAF867B6805737171E3DAEB06");

    var_5 notify("_encstr_BEBC0A21371738404846EFF1");
  }

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A3380CCF6327ABEBEC818BC88F5B")) {
    if(level.teambased) {
      foreach(var_8 in level.teamnamelist) {
        var_9 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemies_fallback_logic(var_8);

        for(var_10 = 0; var_10 < var_9.size; var_10++) {
          var_11 = var_9[var_10];
          var_12 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_8, var_11);
          var_13 = _id_1322C(var_12);

          if(isDefined(var_13)) {
            _id_12B12(var_13);
            var_13 thread _id_14494(var_8, var_11);
          }

          _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1401E(var_8, var_11);
        }
      }
    } else {
      var_3 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

      foreach(var_5 in var_3) {
        if(isDefined(var_5))
          _id_12B12(var_5);
      }
    }
  }

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    level.disablespawning = 1;
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D31199826EB896", 1);
  }

  level.snatchspawnalltoc130done = 1;
}

neurotoxin_damage_loop() {
  var_0 = self;
  var_0 skydive_setdeploymentstatus(0);
  var_0 skydive_setbasejumpingstatus(0);

  if(isDefined(var_0.play_disguise_vo))
    var_0.play_disguise_vo = 5;

  var_0 scripts\cp_mp\parachute::_id_121CA();
}

_id_12B12(var_0) {
  if(!istrue(var_0.vehicle_occupancy_monitorcontrols)) {
    var_0.vehicle_occupancy_monitorcontrols = 1;
    var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A97810F553CDD025BAAB13DF566F519130B1", 2);
    var_0 notifyonplayercommand("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_B44609DFE707CF394E1651");
    var_0 notifyonplayercommand("_encstr_920F0F26867FE2BA61D8779F70DB751AD1", "_encstr_977F0F954CE4B20BE8867D9B07935A37D1");
  }
}

_id_14494(var_0, var_1) {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0, var_1);
  var_3 = _id_1322C(var_2);

  if(isDefined(var_3)) {
    _id_12B12(var_3);
    var_3 thread _id_14494(var_0, var_1);
  }
}

performfailsafeinfil() {
  var_0 = (0, 0, 3000);

  if(isDefined(level.prematchspawnorigins) && level.prematchspawnorigins.size > 0) {
    var_1 = scripts\engine\utility::random(level.prematchspawnorigins);
    var_0 = var_1.origin;
  }

  var_2 = (0, randomintrange(0, 360), 0);
  self setOrigin(var_0, 1);
  self setplayerangles(var_2);
  wait 0.2;
  thread scripts\cp_mp\parachute::startfreefall(0, 1);
}

latespawnplayer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self;
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid();

  if(getDvar("_encstr_AFFC196283C8DEFD72962B06031821C8820B386029B9A1C6280FB8") != "_encstr_B40101" || var_1)
    _id_11FCC();
  else if(!isalive(var_0)) {
    if(!istrue(level.debugnextpropindex)) {
      var_2 = isbot(var_0) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound();

      while(!istrue(level.delay_music_reinforcements) && !var_2) {
        if(!var_2) {
          var_0 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in();
          var_0 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 4);
        }

        wait 0.3;
      }

      var_0 thread watch_for_usb_notetrack();
    } else {
      var_0.delay_explosion_fx = 0;
      var_0.br_infilstarted = 1;

      if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A3380CCF6327ABEBEC818BC88F5B")) {
        var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

        if(!isDefined(var_3) || var_3.size == 0)
          var_3 = [self];

        _id_1322C(var_3);
      }

      var_0 thread _id_11C49();
    }
  }

  var_0 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  var_0 setclientomnvar("_encstr_92A01B134971F2C02E93F0ABA180D35114D9F3AD17037FAA30BB87F79A", 0);
}

watch_for_usb_notetrack() {
  var_0 = self;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isalive(var_0)) {
    var_0.watch_for_usb_notetrack_switchoff = 1;
    var_0 scripts\mp\playerlogic::spawnplayer(0);
  }

  var_0 playerhide();
  var_0.watch_for_usb_notetrack_switchoff = undefined;
  var_0 freezecontrols(1);
  var_1 = 1;

  if(isDefined(var_0.team) && isDefined(var_0.squadindex)) {
    var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_1 = var_2.size == 1;
  }

  var_0.stop_counter_beep_sfx_on_bomb_vests = var_1;

  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath())
    var_0.infilanimindex = 1;

  if(!isDefined(var_0.infilanimindex) && level.teambased) {
    var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);
    var_3 = fivecontracts(var_2.size);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = 0;

      foreach(var_7 in var_2) {
        if(var_7 != var_0 && var_7 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath()) {
          continue;
        }
        if(isDefined(var_7.infilanimindex) && isDefined(var_3[var_4]) && var_7.infilanimindex == var_3[var_4]) {
          var_5 = 1;
          break;
        }
      }

      if(!var_5) {
        var_0.infilanimindex = var_3[var_4];
        break;
      }
    }
  }

  var_0 playerjoininfil();
  var_0 playerlinktopositionent(level.watch_for_total_counts_below_num);
  scripts\mp\utility\game::_id_131A3(var_0, 1);
  var_9 = remove_objective_on_flag(level.watch_for_total_counts_below_num);
  var_0 setOrigin(var_9.origin);
  var_0 playerplayinfilloopanim(level.watch_for_total_counts_below_num);
  waitframe();
  var_10 = 0;

  if(!var_10) {
    if(isDefined(var_0.team) && level.teambased) {
      var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

      foreach(var_12 in var_2) {
        var_0 showtoplayer(var_12);
        var_12 showtoplayer(var_0);
      }
    }
  }

  if(!isbot(var_0))
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::orbitcam(level.br_ac130);

  wait 0.5;
  var_0 freezecontrols(0);
  var_0 setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  var_0.br_infilstarted = 1;
}

fivecontracts(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0 - 1; var_2++)
    var_1[var_2] = var_2 + 2;

  return var_1;
}

_id_11C49() {
  var_0 = self;
  var_0.br_infilstarted = 1;
  var_0 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::addrespawntoken(1);
  var_0 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::playergulagautowin("_encstr_868F1948875373D3525C30CCAC2A4158A95F8008AB19A899FA7F36", undefined, undefined, 1);
  var_0 scripts\mp\playerlogic::addtoalivecount("_encstr_95790C33D33F63FAB95DE73A9773");
}

_id_11FCC() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = self;

  if(!isalive(var_0))
    var_0 scripts\mp\playerlogic::spawnplayer(0);

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A3380CCF6327ABEBEC818BC88F5B")) {
    if(level.teambased) {
      var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

      if(!isDefined(var_1) || var_1.size == 0)
        var_1 = [self];

      var_2 = _id_1322C(var_1);

      if(isDefined(var_2))
        _id_12B12(var_2);
      else {}
    } else {
      var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A97810F553CDD025BAAB13DF566F519130B1", 2);
      _id_12B12(var_0);
    }
  }

  var_0.br_infilstarted = 1;
}

takeloadoutatinfilend(var_0) {
  self takeweapon(self.weaponlist[0]);
  var_1 = getcompleteweaponname("_encstr_9AEF15139F81E2173160D3CA4E193FDA29079E61F9382C");
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    if(scripts\mp\utility\weapon::isgesture(var_4)) {
      continue;
    }
    if(isnullweapon(var_1, var_4)) {
      continue;
    }
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_4);
  }

  self.primaryweaponobj = undefined;
  self.primaryweapon = "_encstr_8BBA05185F8B99";
  self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"] = self.primaryweapon;
  self.secondaryweaponobj = undefined;
  self.secondaryweapon = "_encstr_8BBA05185F8B99";
  self.pers["_encstr_85891093AA774080F789052B879FB0971F72"] = self.secondaryweapon;

  if(!istrue(var_0)) {
    var_6 = getforcedloadoutweapon();
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_6, 1);
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_6);
    self setspawnweapon(var_6, 1);

    if(level.magcount == 0) {
      self setweaponammoclip(var_6, 0);
      self setweaponammostock(var_6, 0);
    } else {
      self setweaponammoclip(var_6, weaponclipsize(var_6));
      self setweaponammostock(var_6, weaponclipsize(var_6) * (level.magcount - 1));
    }

    self.secondaryweaponobj = var_6;
    self.secondaryweapon = createheadicon(self.secondaryweaponobj);
    self.pers["_encstr_85891093AA774080F789052B879FB0971F72"] = self.secondaryweapon;
  }
}

getforcedloadoutweapon() {
  return scripts\mp\class::buildweapon("_encstr_8BE20ED75722A6731BF84F3064CA126B", ["_encstr_AA1C072756CC63ACF0", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1, undefined, undefined, undefined, undefined, undefined, 0);
}

_id_1322C(var_0) {
  if(var_0.size == 0)
    return undefined;

  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath())
      return var_3;
  }

  foreach(var_3 in var_0) {
    if(level.onlinegame && var_3 isfireteamleader()) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1)) {
    var_7 = 0;
    var_8 = 0;

    foreach(var_3 in var_0) {
      var_10 = var_7 == isbot(var_3);

      if(var_10) {
        var_8++;
        var_11 = 1.0 / var_8;

        if(randomfloat(1.0) < var_11)
          var_1 = var_3;
      }
    }
  }

  if(!isDefined(var_1)) {
    foreach(var_3 in var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(!isDefined(var_1))
    return undefined;

  var_1 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1319D(1);

  foreach(var_3 in var_0) {
    if(var_3 != var_1)
      var_3 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1319D(0);

    var_16 = scripts\engine\utility::ter_op(var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath(), 2, 1);
    _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::setteammateomnvarsforplayer(var_3, var_0, var_16);
  }

  return var_1;
}

firespoutwatch(var_0, var_1) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    return firesaleforplayers(var_0, var_1);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    return fix_collision(var_0, var_1);
  else
    return buildac130infilanimstruct(var_0, var_1);
}

buildac130infilanimstruct(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_0.animstruct = var_2;
    var_2.movingc130 = var_0;
  }

  var_2.staticc130 = getEnt("_encstr_A54E0C905A2303D079D8795BFEDF", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_2.staticc130))
    var_2.staticc130 show();
  else {
    var_2.staticc130 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", getdvarvector("_encstr_A9F4124CC9EB2DCD33D2D87D85CD2DDABEC1B7B9", (0, 0, 0)));
    var_2.staticc130 setModel("_encstr_8ADB28B3953407BEB6961BEBB02DC9BE0B360DB0E4364B95C4CC60BEB5C29DDA0BFA0BDCB4AD2C475923");
    var_2.staticc130.cleanme = 1;
  }

  var_2.cameraent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.staticc130.origin);
  var_2.cameraent setModel("_encstr_9ACD10771D6DE2CA90D8B71348088009F98D");

  if(isDefined(var_0)) {
    var_0 unmarkkeyframedmover(1);
    var_2.gas_trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.movingc130.origin);
    var_2.gas_trigger setModel("_encstr_9ACD10771D6DE2CA90D8B71348088009F98D");
    var_2.gas_trigger linkTo(var_2.movingc130, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
    var_2.gas_trigger unmarkkeyframedmover(1);
  }

  spawnplayerpositionparentent(var_2, var_2.staticc130);

  if(var_1 == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    var_2.playerslot1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.staticc130.origin);
    var_2.playerslot1 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2.playerslot2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.staticc130.origin);
    var_2.playerslot2 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2.playerslot3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.staticc130.origin);
    var_2.playerslot3 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2.playerslot4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.staticc130.origin);
    var_2.playerslot4 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2.playerslot1 linkTo(var_2.playerpositionents["_encstr_B2D7075B7166F7FDC8"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2.playerslot2 linkTo(var_2.playerpositionents["_encstr_B2D7075B7166F7FDC8"], "_encstr_9AAA09D4EB0727BD83F564", (0, 0, 0), (0, 0, 0));
    var_2.playerslot3 linkTo(var_2.playerpositionents["_encstr_B2D7075B7166F7FDC8"], "_encstr_8CAA09C39163028299D04A", (0, 0, 0), (0, 0, 0));
    var_2.playerslot4 linkTo(var_2.playerpositionents["_encstr_B2D7075B7166F7FDC8"], "_encstr_A9AA09E871D83818B3C7A9", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  } else {
    var_3 = ["_encstr_AFAA09344628DA52A72756", "_encstr_9AAA09D4EB0727BD83F564", "_encstr_8CAA09C39163028299D04A", "_encstr_A9AA09E871D83818B3C7A9"];

    foreach(var_5 in var_3)
    spawnplayerpositionent(var_2, var_5);

    var_2.infil_anim_type = "_encstr_8BB007E03658CBCAE4";
  }

  var_2.aidoorchief = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.staticc130.origin);
  var_2.aidoorchief setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");

  if(isDefined(var_0) && isDefined(var_2.movingc130.innards))
    var_2.movingc130.innards linkTo(var_2.movingc130, "_encstr_B40101", (0, 0, 0), (0, 0, 0));

  var_2.aidoorchief linkTo(var_2.playerpositionents["_encstr_B2D7075B7166F7FDC8"], "_encstr_BAAA0938A108E8C883F7FB", (0, 0, 0), (0, 0, 0));
  var_2.cameraent linkTo(var_2.staticc130, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
  var_2.helicountdownendcallback = spawnfx(level._effect["_encstr_924818FBA869411BC328E9165C48EB998750D243204F86739829"], var_2.staticc130.origin);
  return var_2;
}

firesaleforplayers(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_0.animstruct = var_2;
    var_2._id_11DBF = var_0;
  }

  var_3 = scripts\engine\utility::getStruct("_encstr_976C104BCD994B36AFC18D2C9BACAFB1A119", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2.origin = var_3.origin;
  var_2.angles = (0, 0, 0);

  if(isDefined(var_3.angles))
    var_2.angles = var_3.angles;

  var_2.chopper = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.chopper.angles = var_2.angles;
  var_2.chopper setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2.chopper.cleanme = 1;
  var_2.goalradiustarget = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.goalradiustarget setModel("_encstr_B25E2C0839EA1741EB09EB695F190827CBF8B659F0320A89EA03C4CD26C7F7EBC7F0085F0ADD3020CD43A3D892B9");
  var_2.goalradiustarget linkTo(var_2.chopper, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2.givestandardtableloadout = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.givestandardtableloadout setModel("_encstr_833C2F5B7FAB48F838420130F7D76BA0B88975FA60D9B9BF674D636863407FCDD74BF0EC6F4569CB01CA4A95407CBADFF5");
  var_2.givestandardtableloadout linkTo(var_2.chopper, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2.gas_trigger_think = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.gas_trigger_think setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_2.gas_trigger_think linkTo(var_2.chopper, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2.gas_tryplaycoughaudio = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.gas_tryplaycoughaudio setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_2.gas_tryplaycoughaudio linkTo(var_2.chopper, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));

  if(isDefined(var_0)) {
    var_0 unmarkkeyframedmover(1);
    var_2.gas_triggers_init = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_2.gas_triggers_init setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
    var_2.gas_triggers_init linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
    var_2.gas_triggers_init unmarkkeyframedmover(1);
    var_2.gas_vfx_and_triggers = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_2.gas_vfx_and_triggers setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
    var_2.gas_vfx_and_triggers linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
    var_2.gas_vfx_and_triggers unmarkkeyframedmover(1);
  }

  var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] linkTo(var_2.chopper, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] setModel("_encstr_9ACD10771D6DE2CA90D8B71348088009F98D");
  var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] linkTo(var_2.chopper, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));

  if(var_1 == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    var_2._id_1269E = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_2._id_1269E setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_1269E linkTo(var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2._id_1269F = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_2._id_1269F setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_1269F linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2._id_126A0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_2._id_126A0 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_126A0 linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_9AAA09D4EB0727BD83F564", (0, 0, 0), (0, 0, 0));
    var_2._id_126A1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_2._id_126A1 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_126A1 linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_8CAA09C39163028299D04A", (0, 0, 0), (0, 0, 0));
    var_2._id_126A2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_2._id_126A2 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_126A2 linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_A9AA09E871D83818B3C7A9", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  } else {
    var_2.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] gettagorigin("_encstr_AFAA09344628DA52A72756"));
    var_2.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"] linkTo(var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_A6380EC634D21B23EB9B17EA0B8CD762"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_AFAA09344628DA52A72756"));
    var_2.playerpositionents["_encstr_A6380EC634D21B23EB9B17EA0B8CD762"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_A6380EC634D21B23EB9B17EA0B8CD762"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_8A380E77B8D06C42B7B64A4397F9C97A"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_9AAA09D4EB0727BD83F564"));
    var_2.playerpositionents["_encstr_8A380E77B8D06C42B7B64A4397F9C97A"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_8A380E77B8D06C42B7B64A4397F9C97A"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_9AAA09D4EB0727BD83F564", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_84380E0ED898BC8A68277F676BAD61BB"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_8CAA09C39163028299D04A"));
    var_2.playerpositionents["_encstr_84380E0ED898BC8A68277F676BAD61BB"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_84380E0ED898BC8A68277F676BAD61BB"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_8CAA09C39163028299D04A", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_95380E21700B3C29EE07E758B6816973"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_A9AA09E871D83818B3C7A9"));
    var_2.playerpositionents["_encstr_95380E21700B3C29EE07E758B6816973"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_95380E21700B3C29EE07E758B6816973"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_A9AA09E871D83818B3C7A9", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "_encstr_8BB007E03658CBCAE4";
  }

  var_2.bot_gametype_attacker_defender_ai_director_update = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.bot_gametype_attacker_defender_ai_director_update setModel("_encstr_97F41D80E3AD61F17FAC73788D2B1ECB562B88106BC5CFC91FDC7570CB6F0B");
  var_2.bot_gametype_attacker_defender_ai_director_update linkTo(var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"], "_encstr_9AAA09D4EB0727BD83F564", (0, 0, 0), (0, 0, 0));
  var_2.bot_clear_hq_zone = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.bot_clear_hq_zone setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
  var_2.bot_clear_hq_zone linkTo(var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"], "_encstr_8CAA09C39163028299D04A", (0, 0, 0), (0, 0, 0));
  var_2.calloutmarkerpingvo_handleraddnewelement = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.calloutmarkerpingvo_handleraddnewelement setModel("_encstr_A5471187E0BE0F684829B70902773009B009FA");
  var_2.calloutmarkerpingvo_handleraddnewelement linkTo(var_2.chopper, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2.calloutmarkerpingvo_handleraddnewelement unmarkkeyframedmover(1);
  var_4 = 9;
  var_2.calloutmarkerpingvo_getmaxsoundaliaslength = [];

  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
    var_6 setModel("_encstr_973A22CE594307BED6961BFAB02D39EBDAA5CD46960B0EAF5A73CCA536EB998D96D9431D");
    var_6 linkTo(var_2.calloutmarkerpingvo_handleraddnewelement, "_encstr_824E080247038BE80737" + (var_5 + 2), (0, 0, 0), (0, 0, 0));
    var_6 unmarkkeyframedmover(1);
    var_6 playLoopSound("_encstr_BA0B1716C371E0D249AB0FCFBD64DA2CC9E90D5F59408F7A9F");
    var_2.calloutmarkerpingvo_getmaxsoundaliaslength[var_2.calloutmarkerpingvo_getmaxsoundaliaslength.size] = var_6;
  }

  return var_2;
}

fix_collision(var_0, var_1) {
  var_2 = spawnStruct();

  if(isDefined(var_0)) {
    var_0.animstruct = var_2;
    var_2._id_11DC3 = var_0;
  }

  var_2._id_13886 = getEnt("_encstr_AA6C10CB5BF10840AFA784DF1065C9FFC8D2", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_2._id_13886))
    var_2._id_13886 show();
  else {
    var_2._id_13886 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", getdvarvector("_encstr_A9F4124CC9EB2DCD33D2D87D85CD2DDABEC1B7B9", (0, 0, 0)));
    var_2._id_13886 setModel("_encstr_8ADB28B3953407BEB6961BEBB02DC9BE0B360DB0E4364B95C4CC60BEB5C29DDA0BFA0BDCB4AD2C475923");
  }

  var_2._id_13886.cleanme = 1;
  var_2.chopper_kill = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2.chopper_kill setModel("_encstr_AFD23826359090DF221B5B7F4280C05FCEC0A869C041A32EE1D5E8CCA87BBF13A8FD1F89779B5D28D1CE49F7DFFFA6A16EE2E959031344C6DBA3");
  var_2.chopper_kill linkTo(var_2._id_13886, "_encstr_96AF167C4F22E615B6891F1F33E0A63057849A2E0C612B07", (0, 0, 0), (0, 0, 0));
  var_2.chopper_kill_vehicle = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2.chopper_kill_vehicle setModel("_encstr_8C29393BF16B82B16BA314DF4BD802D70EA8422218A8BFB5E09302E17F28015738E1DAAA661B6BEBE18509F75F1996BFD6F831D308E42BA309C310");
  var_2.chopper_kill_vehicle linkTo(var_2._id_13886, "_encstr_853017F0D737A68D52E78E80BE0AD768A72390F01BDC7E6B6B", (0, 0, 0), (0, 0, 0));
  var_2.chopper_kill_person = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2.chopper_kill_person setModel("_encstr_B2F83A537B123FE760F3F499398363A00FE3FB68972102A0933D2AD9BA4B9E635E11404B09F8FD59303BAFDF43B70A099B7AF032FB6C884C717058DB");
  var_2.chopper_kill_person linkTo(var_2._id_13886, "_encstr_9699182007E796BD62B7DEF0CE5A875877D340C04BAC2E696A5B", (0, 0, 0), (0, 0, 0));
  var_2._id_12915 = [var_2.chopper_kill, var_2.chopper_kill_vehicle, var_2.chopper_kill_person];
  var_2._id_12D98 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2._id_12D98 setModel("_encstr_848228E3CD5107D720D82BDFA098B2393F52AC1DA097AA3EEB505B0FB893A782ED7C3495AF35026891F8");
  var_2._id_12D98 linkTo(var_2._id_13886, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2._id_13887 = getEnt("_encstr_912111C4E01E101187383A193A78A148CF6F0A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2._encstr_BD641493BB7FCDB8369B370BBC1DF09873C2CB58929B = getEnt("_encstr_A19316CB8D9963F46F59AB22C059AD17707834552620477A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2._encstr_A79B1466C3CA31F8B30798F003C73161C32F5EE39D13 = getEnt("_encstr_A72F16B9D1168EB436EBB95B5AB1DBEBCAE11D2B9C2D7B27", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2._encstr_91AA1726838A71B8F347D830C307118F032B90A11D622FC0CC = getEnt("_encstr_8EB61A4AAD5BDBC9C9517F178840B71135481303989BA10450A80B13", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2._encstr_A9831450E908135BC25EA42BC43AFBE7BA89A4B10CC1 = getEnt("_encstr_AB1017DC3AC2A3968DEBB96D2D63EDBE3A7B0E7DD8B4CED0D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2.gas_trigger_think = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2.gas_trigger_think setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_2.gas_trigger_think linkTo(var_2._id_13886, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2.gas_tryplaycoughaudio = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2.gas_tryplaycoughaudio setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_2.gas_tryplaycoughaudio linkTo(var_2._id_13886, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));

  if(isDefined(var_0)) {
    var_0 unmarkkeyframedmover(1);
    var_2.gas_triggers_init = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_2.gas_triggers_init setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
    var_2.gas_triggers_init linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
    var_2.gas_triggers_init unmarkkeyframedmover(1);
    var_2.gas_vfx_and_triggers = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_2.gas_vfx_and_triggers setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
    var_2.gas_vfx_and_triggers linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
    var_2.gas_vfx_and_triggers unmarkkeyframedmover(1);
  }

  var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] setModel("_encstr_95CD10EC56B9594E5A36AF0739DB38FA0F66");
  var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] linkTo(var_2._id_13886, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
  var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] setModel("_encstr_9ACD10771D6DE2CA90D8B71348088009F98D");
  var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] linkTo(var_2._id_13886, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));

  if(var_1 == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    var_2._id_1269E = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
    var_2._id_1269E setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_1269E linkTo(var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2._id_1269F = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
    var_2._id_1269F setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_1269F linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2._id_126A0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
    var_2._id_126A0 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_126A0 linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_9AAA09D4EB0727BD83F564", (0, 0, 0), (0, 0, 0));
    var_2._id_126A1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
    var_2._id_126A1 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_126A1 linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_8CAA09C39163028299D04A", (0, 0, 0), (0, 0, 0));
    var_2._id_126A2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2._id_13886.origin);
    var_2._id_126A2 setModel("_encstr_A2FF1A8A43D9436E80C9714FF3B875B7E8794381C9AED7E4A0256974");
    var_2._id_126A2 linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_A9AA09E871D83818B3C7A9", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";
  } else {
    var_2.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] gettagorigin("_encstr_AFAA09344628DA52A72756"));
    var_2.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"] linkTo(var_2.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_A6380EC634D21B23EB9B17EA0B8CD762"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_AFAA09344628DA52A72756"));
    var_2.playerpositionents["_encstr_A6380EC634D21B23EB9B17EA0B8CD762"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_A6380EC634D21B23EB9B17EA0B8CD762"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_AFAA09344628DA52A72756", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_8A380E77B8D06C42B7B64A4397F9C97A"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_9AAA09D4EB0727BD83F564"));
    var_2.playerpositionents["_encstr_8A380E77B8D06C42B7B64A4397F9C97A"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_8A380E77B8D06C42B7B64A4397F9C97A"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_9AAA09D4EB0727BD83F564", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_84380E0ED898BC8A68277F676BAD61BB"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_8CAA09C39163028299D04A"));
    var_2.playerpositionents["_encstr_84380E0ED898BC8A68277F676BAD61BB"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_84380E0ED898BC8A68277F676BAD61BB"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_8CAA09C39163028299D04A", (0, 0, 0), (0, 0, 0));
    var_2.playerpositionents["_encstr_95380E21700B3C29EE07E758B6816973"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] gettagorigin("_encstr_A9AA09E871D83818B3C7A9"));
    var_2.playerpositionents["_encstr_95380E21700B3C29EE07E758B6816973"] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
    var_2.playerpositionents["_encstr_95380E21700B3C29EE07E758B6816973"] linkTo(var_2.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"], "_encstr_A9AA09E871D83818B3C7A9", (0, 0, 0), (0, 0, 0));
    var_2.infil_anim_type = "_encstr_8BB007E03658CBCAE4";
  }

  if(isDefined(var_0) && isDefined(var_2._id_11DC3.innards))
    var_2._id_11DC3.innards linkTo(var_2._id_11DC3, "_encstr_B40101", (0, 0, 0), (0, 0, 0));

  return var_2;
}

handlefriendlyvisibility(var_0) {
  if(isDefined(var_0.calloutmarkerpingvo_getmaxsoundaliaslength)) {
    foreach(var_2 in var_0.calloutmarkerpingvo_getmaxsoundaliaslength)
    var_2 delete();
  }

  if(isDefined(var_0.calloutmarkerpingvo_handleraddnewelement))
    var_0.calloutmarkerpingvo_handleraddnewelement delete();

  if(isDefined(var_0.bot_clear_hq_zone))
    var_0.bot_clear_hq_zone delete();

  if(isDefined(var_0.bot_gametype_attacker_defender_ai_director_update))
    var_0.bot_gametype_attacker_defender_ai_director_update delete();

  if(isDefined(var_0.playerpositionents)) {
    foreach(var_5 in var_0.playerpositionents)
    var_5 delete();
  }

  if(isDefined(var_0._id_1269E))
    var_0._id_1269E delete();

  if(isDefined(var_0._id_1269F))
    var_0._id_1269F delete();

  if(isDefined(var_0._id_126A0))
    var_0._id_126A0 delete();

  if(isDefined(var_0._id_126A1))
    var_0._id_126A1 delete();

  if(isDefined(var_0._id_126A2))
    var_0._id_126A2 delete();

  if(isDefined(var_0.gas_trigger_think))
    var_0.gas_trigger_think delete();

  if(isDefined(var_0.gas_tryplaycoughaudio))
    var_0.gas_tryplaycoughaudio delete();

  if(isDefined(var_0.gas_triggers_init))
    var_0.gas_triggers_init delete();

  if(isDefined(var_0.gas_vfx_and_triggers))
    var_0.gas_vfx_and_triggers delete();

  if(isDefined(var_0.givestandardtableloadout))
    var_0.givestandardtableloadout delete();

  if(isDefined(var_0.goalradiustarget))
    var_0.goalradiustarget delete();

  if(isDefined(var_0.chopper) && istrue(var_0.chopper.cleanme))
    var_0.chopper delete();

  if(isDefined(var_0._id_11DBF) && istrue(var_0._id_11DBF.cleanme)) {
    if(isDefined(var_0._id_11DBF.innards) && istrue(var_0._id_11DBF.innards.cleanme))
      var_0._id_11DBF.innards delete();

    var_0._id_11DBF delete();
  }
}

handleimpact(var_0) {
  scripts\mp\utility\sound::_id_12C2A("_encstr_82510F061DBFE7E00CEF54A79B406BF8F8");

  if(isDefined(var_0.playerpositionents)) {
    foreach(var_2 in var_0.playerpositionents)
    var_2 delete();
  }

  if(isDefined(var_0._id_1269E))
    var_0._id_1269E delete();

  if(isDefined(var_0._id_1269F))
    var_0._id_1269F delete();

  if(isDefined(var_0._id_126A0))
    var_0._id_126A0 delete();

  if(isDefined(var_0._id_126A1))
    var_0._id_126A1 delete();

  if(isDefined(var_0._id_126A2))
    var_0._id_126A2 delete();

  if(isDefined(var_0.gas_trigger_think))
    var_0.gas_trigger_think delete();

  if(isDefined(var_0.gas_tryplaycoughaudio))
    var_0.gas_tryplaycoughaudio delete();

  if(isDefined(var_0.gas_triggers_init))
    var_0.gas_triggers_init delete();

  if(isDefined(var_0.gas_vfx_and_triggers))
    var_0.gas_vfx_and_triggers delete();

  if(isDefined(var_0._id_12D98))
    var_0._id_12D98 delete();

  foreach(var_5 in var_0._id_12915) {
    if(isDefined(var_5))
      var_5 delete();
  }

  if(isDefined(var_0._id_13886) && istrue(var_0._id_13886.cleanme))
    var_0._id_13886 delete();

  if(isDefined(var_0._id_13887))
    var_0._id_13887 delete();

  if(isDefined(var_0._encstr_BD641493BB7FCDB8369B370BBC1DF09873C2CB58929B))
    var_0._encstr_BD641493BB7FCDB8369B370BBC1DF09873C2CB58929B delete();

  if(isDefined(var_0._encstr_A79B1466C3CA31F8B30798F003C73161C32F5EE39D13))
    var_0._encstr_A79B1466C3CA31F8B30798F003C73161C32F5EE39D13 delete();

  if(isDefined(var_0._encstr_91AA1726838A71B8F347D830C307118F032B90A11D622FC0CC))
    var_0._encstr_91AA1726838A71B8F347D830C307118F032B90A11D622FC0CC delete();

  if(isDefined(var_0._encstr_A9831450E908135BC25EA42BC43AFBE7BA89A4B10CC1))
    var_0._encstr_A9831450E908135BC25EA42BC43AFBE7BA89A4B10CC1 delete();

  if(isDefined(var_0._id_11DC3) && istrue(var_0._id_11DC3.cleanme)) {
    if(isDefined(var_0._id_11DC3.innards) && istrue(var_0._id_11DC3.innards.cleanme))
      var_0._id_11DC3.innards delete();

    if(isDefined(var_0._id_11DC3.bunker_numberstation) && istrue(var_0._id_11DC3.bunker_numberstation.cleanme))
      var_0._id_11DC3.bunker_numberstation delete();

    if(isDefined(var_0._id_11DC3.door) && istrue(var_0._id_11DC3.door.cleanme))
      var_0._id_11DC3.door delete();

    var_0._id_11DC3 delete();
  }
}

handleheadshotkillrewardbullets(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    handlefriendlyvisibility(var_0);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    handleimpact(var_0);
  else
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::cleanac130struct(var_0);
}

laser_vfx_think(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = getEntArray("_encstr_BD700C7B20FBE38DA1811A1F9918", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(istrue(var_1)) {
    if(isDefined(var_0)) {
      var_3 = remove_munitions_in_radius(var_0);
      var_3 waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_961804BD954A");
    }
  }

  foreach(var_5 in var_2) {
    if(isDefined(var_5))
      var_5 delete();
  }
}

spawnplayerpositionparentent(var_0, var_1) {
  var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] setModel("_encstr_9ACD10771D6DE2CA90D8B71348088009F98D");
  var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] linkTo(var_1, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
}

spawnplayerpositionent(var_0, var_1) {
  var_0.playerpositionents[var_1] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] gettagorigin(var_1));
  var_0.playerpositionents[var_1] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_0.playerpositionents[var_1] linkTo(var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"], var_1, (0, 0, 0), (0, 0, 0));
}

remove_veh_spawners_from_passive_wave_spawning(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    return remove_usability_crutch_on_death(var_0);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    return removeaccesscard(var_0);
  else
    return remove_tank_class(var_0);
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

remove_usability_crutch_on_death(var_0) {
  var_1 = self getplayerangles(1);
  var_2 = anglesToForward(var_1);
  var_3 = anglesToForward(var_0._id_11DBF.angles);
  var_4 = anglestoright(var_0._id_11DBF.angles);
  var_5 = vectordot(var_2, var_3);
  var_6 = vectordot(var_2, var_4);
  var_7 = cos(45.0);

  if(var_5 < -1.0 * var_7)
    return ["_encstr_9BEB21B3AD17F9653FBB1310613B02CB6CE64A19B4CDA083F787B1504865F0C0EA732F", %_encstr_9BEB21B3AD17F9653FBB1310613B02CB6CE64A19B4CDA083F787B1504865F0C0EA732F, "_encstr_B2551DDD9ED75ACD99B48DAF5B5AE6462D160ED7D45DDA0EC0C47D1CB1C089"];

  if(var_6 > var_7)
    return ["_encstr_8E4B2624DADF88753722D8391A8C3D615F690B88529FF09151EA98B8E362C73BB34197AFE932FEE1", %_encstr_8E4B2624DADF88753722D8391A8C3D615F690B88529FF09151EA98B8E362C73BB34197AFE932FEE1, "_encstr_8205220F32C9B3C321822958B024084971F30A87A50B35934ADFF9D0C432A979076FD9A9"];
  else if(var_6 < -1.0 * var_7)
    return ["_encstr_9A4B263702D69FADFD60E2E978DB6563C867F0E7923B3772E7787AF278051D6B82F7606F93EBB73A", %_encstr_9A4B263702D69FADFD60E2E978DB6563C867F0E7923B3772E7787AF278051D6B82F7606F93EBB73A, "_encstr_9B05221F72D1D16DE6A8301FFB6173B26C5F684E726BCFA8124F70080253AB61F7679F02"];
  else if(var_6 > 0.0)
    return ["_encstr_A7CD2713F26F42B611A85B8F90287E5AFB87488152935AD05EF07743906327637107B209675147378D", %_encstr_A7CD2713F26F42B611A85B8F90287E5AFB87488152935AD05EF07743906327637107B209675147378D, "_encstr_86ED237F55300AF6A0A09DA9D8200E12F3FBCA67DD4D32A03A83596AD0C219F977A172EFA9"];
  else
    return ["_encstr_9ACD2773920F22D671887BAFB0C89EBADBA728E172B3BAF07E9057637043474391E792694771271723", %_encstr_9ACD2773920F22D671887BAFB0C89EBADBA728E172B3BAF07E9057637043474391E792694771271723, "_encstr_BDED23D332AF8276D1689B4F50683E1ABBC7884192531A90F3825FFB306BB951A3C3F2C906"];
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

remove_tank_class(var_0) {
  var_1 = self getplayerangles(1);
  var_2 = anglesToForward(var_1);
  var_3 = anglesToForward(var_0.movingc130.angles);
  var_4 = anglestoright(var_0.movingc130.angles);
  var_5 = vectordot(var_2, var_3);
  var_6 = vectordot(var_2, var_4);
  var_7 = cos(45.0);

  if(var_5 < -1.0 * var_7)
    return ["_encstr_A1CB23E2B1A867E2179787A3DDB33AAFE8B98A7AA369EA3BE1A1578F33E8C3DAF06350620B", %_encstr_A1CB23E2B1A867E2179787A3DDB33AAFE8B98A7AA369EA3BE1A1578F33E8C3DAF06350620B, "_encstr_8D9E18CD19277DB5E0AF96DC992D637D0BC6986660BED4BA5B1C"];

  if(var_6 > var_7)
    return ["_encstr_AAC928DC4639BED683D75A7399A5C6BE58B14CCCC0F5A957B5E0EBCE56370EE4ED1C0F4C607D9303AF63", %_encstr_AAC928DC4639BED683D75A7399A5C6BE58B14CCCC0F5A957B5E0EBCE56370EE4ED1C0F4C607D9303AF63, "_encstr_AFAC1D722138F772A72737334DC3AA3F58297AEA13F99A8B7151E76609E0F2"];
  else if(var_6 < -1.0 * var_7)
    return ["_encstr_A3C9286BD1661F3DE8CF11EE45D885D707A9C7D7F3A8B37328B92FEF6BC8CA3BB823CB7F8BAF36FAE1A5", %_encstr_A3C9286BD1661F3DE8CF11EE45D885D707A9C7D7F3A8B37328B92FEF6BC8CA3BB823CB7F8BAF36FAE1A5, "_encstr_8EAC1DDF5CAAC999EBD130D86AA7C11186B3A3D7905928DDE73BCE2AF7A786"];
  else if(var_6 > 0.0)
    return ["_encstr_BD59297360A5E98F3B80414E2420B3212BC0DF8F2A271CA7F07F6F7F4D280B324FF0D327924F824A83F054", %_encstr_BD59297360A5E98F3B80414E2420B3212BC0DF8F2A271CA7F07F6F7F4D280B324FF0D327924F824A83F054, "_encstr_914E1EA314E36815B83F5AC3500734590BF8AFC6ABD0A0CD0743E9E7799B9828"];
  else
    return ["_encstr_BA5929B9919CEB6B0ED7A5E666B4D8EBC28DC49981BE535DB583AF7695B90E93DE07C3C481D7137060AF27", %_encstr_BA5929B9919CEB6B0ED7A5E666B4D8EBC28DC49981BE535DB583AF7695B90E93DE07C3C481D7137060AF27, "_encstr_A94E1EB9C839D75B0EFA2D9BCC9663D7C26CC4990CBEA957AD0EEB4CC103EB93"];
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

removeaccesscard(var_0) {
  var_1 = self getplayerangles(1);
  var_2 = anglesToForward(var_1);
  var_3 = anglesToForward(var_0._id_11DC3.angles);
  var_4 = anglestoright(var_0._id_11DC3.angles);
  var_5 = vectordot(var_2, var_3);
  var_6 = vectordot(var_2, var_4);
  var_7 = cos(45.0);

  if(var_5 < -1.0 * var_7)
    return ["_encstr_B6A31FBBF4F55ADC99D2D8D7B9DA4B8DF6AF53AE6B38AFEC2B37E0C9B71C1E1306", %_encstr_B6A31FBBF4F55ADC99D2D8D7B9DA4B8DF6AF53AE6B38AFEC2B37E0C9B71C1E1306, "_encstr_93121B7B33EF3BF81FE9A1CF1B84187187D950A32A2BCF4A79E8590961"];

  if(var_6 > var_7)
    return ["_encstr_9B7F24BBF4EB96DC332DD8EBCD6D4B36BD7DA6AEB51CEBECCAB983E4B783871318BEC918FAB1", %_encstr_9B7F24BBF4EB96DC332DD8EBCD6D4B36BD7DA6AEB51CEBECCAB983E4B783871318BEC918FAB1, "_encstr_B24F2078C59163452D410AE7174CE92BADA7822BC8C042829158613F4781BAFF3103"];
  else if(var_6 < -1.0 * var_7)
    return ["_encstr_977F24BB4FBEB473CC96B1FA375B5A36BD7D9A5DAD1CFA3BCA9BC14E7B07F02603D79C0CF59C", %_encstr_977F24BB4FBEB473CC96B1FA375B5A36BD7D9A5DAD1CFA3BCA9BC14E7B07F02603D79C0CF59C, "_encstr_914F20E30A5773D5AEE70A07F80F316A171902DFAD47EBEFCF4370F76B76ABA3B772"];
  else if(var_6 > 0.0)
    return ["_encstr_9BB125BBE9BE96CD3396367DCDB64BB1DBEBA6AB6B83FACE597383277B0E3C6203FA4C07067D1B", %_encstr_9BB125BBE9BE96CD3396367DCDB64BB1DBEBA6AB6B83FACE597383277B0E3C6203FA4C07067D1B, "_encstr_97DB218362DFF206A138CBFF10F8C96A67684CBB41E91F01AED8C34A2A56E977718055"];
  else
    return ["_encstr_B2B1250C7249C4F6741401076A0FC470B8FF828BFFC7C84029C54053A070B0175269AEAB73B153", %_encstr_B2B1250C7249C4F6741401076A0FC470B8FF828BFFC7C84029C54053A070B0175269AEAB73B153, "_encstr_8EDB219713CF6FAD5DBC50411F5A9B81A8013B805D889A73FF307D2F4F6942F1AA58EB"];
}

_id_1274B(var_0) {
  var_1 = "_encstr_B40101";

  if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath())
    var_1 = "_encstr_BA3D1B7236E6AF9DCDB03219783B93473908F4EDC7E9C7A29740AB3248";
  else
    var_1 = "_encstr_9712184C39FA5AB9992D1BF5CDB8AE858CDA2C1D59BE53D56B0E";

  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1276A(var_1, var_0.team, var_0);
}

watchinfiljumpanim(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(level.infiljumpentsspawned))
    level.infiljumpentsspawned = 0;

  self.shouldhumanspawntags = 0;
  self waittill("_encstr_8F7D08C66A0125438523");
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);
  var_2 = [];

  if(self.jumptype == "_encstr_8D7A07F007F10143A3") {
    foreach(var_4 in var_1) {
      if(isDefined(var_4.infilanimindex))
        var_2[var_2.size] = var_4;
    }
  } else if(self.jumptype == "_encstr_B61805B97B36DB" || self.jumptype == "_encstr_8A720C58B3AB7729A26778B853CB")
    var_2 = [self];

  var_6 = var_2.size > 0;

  if(var_6) {
    var_7 = getdvarint("_encstr_878719487B89B3A8F31941D0F823B15B61627888F3D1DBE0E735D6", 1) != 0;

    if(level.infiljumpentsspawned >= 100)
      var_7 = 0;

    var_8 = undefined;

    if(var_7) {
      var_8 = 0;
      [var_10, var_11, var_12] = remove_veh_spawners_from_passive_wave_spawning(var_0);
      var_13 = remove_objective_on_flag(var_0);
      var_14["_encstr_B2D7075B7166F7FDC8"] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_13.origin);
      level.infiljumpentsspawned++;
      var_14["_encstr_B2D7075B7166F7FDC8"] setModel("_encstr_A5471187E0BE0F684829B70902773009B009FA");
      var_14["_encstr_B2D7075B7166F7FDC8"] linkTo(var_13, "_encstr_8F1E092CC9F71178C01941", (0, 0, 0), (0, 0, 0));

      foreach(var_4 in var_2) {
        if(!isDefined(var_4.infilanimindex))
          var_4.infilanimindex = 1;

        var_16 = "_encstr_824E080247038BE80737" + (var_4.infilanimindex + 2);
        var_14[var_16] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_14["_encstr_B2D7075B7166F7FDC8"] gettagorigin(var_16));
        level.infiljumpentsspawned++;
        var_14[var_16] setModel("_encstr_8E010B996FB7B6B3C1D1183343");
        var_14[var_16] linkTo(var_14["_encstr_B2D7075B7166F7FDC8"], var_16, (0, 0, 0), (0, 0, 0));
        var_4 playerlinkTo(var_14[var_16], "_encstr_8E010B996FB7B6B3C1D1183343");
        var_4 playershow(1);
        var_4 playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", var_12);
        var_4.infilanimindex = undefined;
        var_4 playlocalsound("_encstr_83761ADC1BE4FAC4E4BED2CDCC4B36D74DD5B5C1AF371DB4E6CEACE4");
        level thread _id_1274B(var_4);
      }

      var_14["_encstr_B2D7075B7166F7FDC8"] scriptmodelplayanim(var_10, "_encstr_8F0E0583E4DB83");
      var_18 = getanimlength(var_11);
      var_19 = 1.0;
      var_18 = max(var_18, var_19 + 0.1);
      wait(var_18 - var_19);

      foreach(var_4 in var_2)
      var_4 cameradefault();

      wait(var_19);

      foreach(var_23 in var_14) {
        var_23 delete();
        level.infiljumpentsspawned--;
      }
    } else {
      var_8 = 1;
      waittillframeend;
    }

    foreach(var_4 in var_2) {
      var_4.infilanimindex = undefined;
      var_4 stopanimscriptsceneevent();
      var_4 notify("_encstr_831910EB8313CF31B9121BFFC3FECDF5800D");
      var_4 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1254E();
    }

    if(var_8) {
      waitframe();
      var_13 = remove_objective_on_flag(var_0);

      if(isDefined(var_13)) {
        if(isDefined(var_13.playeroffsets) && isDefined(var_13.currentplayeroffset)) {
          foreach(var_4 in var_2) {
            var_28 = var_13.playeroffsets[var_13.currentplayeroffset];
            var_4 setOrigin(var_13.origin + var_28, 1, 1);
            var_13.currentplayeroffset++;

            if(var_13.currentplayeroffset == var_13.playeroffsets.size)
              var_13.currentplayeroffset = 0;

            var_4 playershow(1);
            level thread _id_1274B(var_4);
          }
        }
      }
    }
  }
}

playinfilplayeranims(var_0, var_1) {
  var_2 = _id_1256D(var_0);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 thread[[level.parachutetakeweaponscb]]();
    var_5 _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1254D();
    scripts\mp\utility\game::_id_131A3(var_5, 1);
    var_5.plotarmor = 1;
    var_5 unlink();
    var_5 playerlinktopositionent(var_0);
    var_6 = var_5 _id_1256E(var_0);
    var_5 playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", var_6);
  }

  wait(var_2);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 thread playerplayinfilloopanim(var_0);
  }
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_1256D(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    return getanimlength(%_encstr_A9731D2723397BA0BE846806AD697825B2B731EFAF82B1E0EFDA50D9504DD0);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    return getanimlength(%_encstr_827E1CE3AB77B37067912957930C80890F51FBA892FF7910F1633105F8E2);
  else
    return getanimlength(%_encstr_B642219FE5A2E9307F2743C5336F65E04BF6777B5A118D5351EB2B373B6DB713C8404A);
}

_id_1256E(var_0) {
  var_1 = "_encstr_B40101";
  var_2 = self hasfemalecustomizationmodel();

  if(var_2)
    var_1 = "_encstr_9243059F464770";

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return "_encstr_A9731D2723397BA0BE846806AD697825B2B731EFAF82B1E0EFDA50D9504DD0" + var_1;
    else
      return "_encstr_A5191E7F63F849BAAEC109182554B5C468299297906F0B09B469ABBAA61B2133" + self.infilanimindex + var_1;
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return "_encstr_827E1CE3AB77B37067912957930C80890F51FBA892FF7910F1633105F8E2" + var_1;
    else
      return "_encstr_A76C1ABB9EF5B4373396637D37B6A5B1F67DCD17EA16C8D7E6912718" + self.infilanimindex + var_1;
  } else
    return "_encstr_A3E6204B706839310BC6F0A0F69B589E2769F703DA89BB12FCDB60B72A91364F1F23" + self.infilanimindex;
}

_id_1256F(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return "_encstr_97631B0F8D81243BB4A05269081B03DF9823C85FC958ED8BF07B4AA79B";
    else
      return "_encstr_B8111AE393C1B8209F417CAF6737B683CF0F8B4F63970AAFDF686428" + self.infilanimindex;
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return "_encstr_AC7420CB9BCF2810262DD3D62E4C11C017B1D38F837133216F2702D7B9DF6907F0B3";
    else
      return "_encstr_A76C1ABB9EF5B4373396637D37B6A5B1F67DCD17EA16C8D7E6912718" + self.infilanimindex + "_encstr_A3850616E56F783F";
  } else
    return "_encstr_88051CD2819857D2C74757532D630A9FB8C9DA4A73993CCA90F1872311B7" + self.infilanimindex;
}

_id_12571(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return var_0.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"];
    else
      return var_0.playerpositionents["_encstr_B1AB0D3F28CB429B71983F43903969" + self.infilanimindex];
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return var_0.playerpositionents["_encstr_8CF90B70EA34A9F907F330B9F7"];
    else
      return var_0.playerpositionents["_encstr_B1AB0D3F28CB429B71983F43903969" + self.infilanimindex];
  } else
    return var_0.playerpositionents["_encstr_824E080247038BE80737" + self.infilanimindex];
}

_id_12572(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return "_encstr_AFAA09344628DA52A72756";
    else
      return "_encstr_824E080247038BE80737" + self.infilanimindex;
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    if(self.stop_counter_beep_sfx_on_bomb_vests)
      return "_encstr_AFAA09344628DA52A72756";
    else
      return "_encstr_824E080247038BE80737" + self.infilanimindex;
  } else
    return "_encstr_824E080247038BE80737" + self.infilanimindex;
}

playerlinktopositionent(var_0) {
  if(isai(self) && !istrue(self.hasspawned)) {
    return;
  }
  if(!isDefined(self.infilanimindex))
    self.infilanimindex = 1;

  var_1 = _id_12571(var_0);
  self playerlinkTo(var_1, "_encstr_8E010B996FB7B6B3C1D1183343");
}

playerplayinfilloopanim(var_0) {
  if(!isDefined(self.infilanimindex))
    self.infilanimindex = 1;

  if(!isDefined(self.stop_counter_beep_sfx_on_bomb_vests)) {
    var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);
    self.stop_counter_beep_sfx_on_bomb_vests = var_1.size == 1;
  }

  var_2 = _id_1256F(var_0);
  self playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", var_2);
  thread watchinfiljumpanim(var_0);
}

_id_12AB5(var_0) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_0.staticc130 waittillmatch("_encstr_824E060F2147FBB8", "_encstr_A3CF06A740732502");
  var_1 = getentitylessscriptablearrayinradius("_encstr_B6F91532D06DC42B7EBEE4E9406DC7CD87C1EA8A3029FB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1)
  var_3 setscriptablepartstate("_encstr_B46F14A00834A163AF3ADCB86B3A60488FD92B10357B", "_encstr_B135094273DAF12B2F9808", 1);
}

serverroomrewardlocs(var_0) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_0.staticc130 waittillmatch("_encstr_824E060F2147FBB8", "_encstr_BE8808E77D883E2DDB48");
  var_1 = getentitylessscriptablearrayinradius("_encstr_B6F91532D06DC42B7EBEE4E9406DC7CD87C1EA8A3029FB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1)
  var_3 setscriptablepartstate("_encstr_B46F14A00834A163AF3ADCB86B3A60488FD92B10357B", "_encstr_93F10B7121D740B981FAC86B73", 1);
}

_id_133B1(var_0) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_1 = getentitylessscriptablearrayinradius("_encstr_95A21207D069C16A0F04229F7D05119CD030BBFB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = getentitylessscriptablearrayinradius("_encstr_A92217C83BE650A181B75EED0FAAFFB84187485897ABCB6FDB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_3 = getentitylessscriptablearrayinradius("_encstr_B4491031856804D3C823223A6EB93F7FF029", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_4 = getentitylessscriptablearrayinradius("_encstr_8F221531C6F57208D8DB5D798FAC10684378C8C3391FBB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_6 in var_1)
  var_6 setscriptablepartstate("_encstr_B82125D85A761AD1BE31D84B9B5BD27376EB4BB9CC4B63BEBB9EF5B4B91BC2CD19BED939AC59CD", "_encstr_88FB0FB54BD7A00BEE6F8CAAF0489F68E1", 1);

  foreach(var_6 in var_2)
  var_6 setscriptablepartstate("_encstr_99322A81FF2A6BC037F6F8501DFBD090C2BF033D6B9221D137C886A842D4D8D84A57878D1FFAF8096B228803", "_encstr_88FB0FB54BD7A00BEE6F8CAAF0489F68E1", 1);

  foreach(var_6 in var_3)
  var_6 setscriptablepartstate("_encstr_861B2363A5B3A13ABEC48DD237D64BB93BF5B473CC5A36BEEEA7D7D2E6362C9B23EBC92B46", "_encstr_B135094273DAF12B2F9808", 1);

  foreach(var_6 in var_4)
  var_6 setscriptablepartstate("_encstr_99E22810D717608191C661FBDD8AE3E87F77B09843A1381FFBE8F0F3F2D23B10A4DF1048D37F93394293", "_encstr_B135094273DAF12B2F9808", 1);

  wait 4.6;

  foreach(var_6 in var_1)
  var_6 setscriptablepartstate("_encstr_B82125D85A761AD1BE31D84B9B5BD27376EB4BB9CC4B63BEBB9EF5B4B91BC2CD19BED939AC59CD", "_encstr_93F10B7121D740B981FAC86B73", 1);

  foreach(var_6 in var_2)
  var_6 setscriptablepartstate("_encstr_99322A81FF2A6BC037F6F8501DFBD090C2BF033D6B9221D137C886A842D4D8D84A57878D1FFAF8096B228803", "_encstr_93F10B7121D740B981FAC86B73", 1);

  foreach(var_6 in var_3)
  var_6 setscriptablepartstate("_encstr_861B2363A5B3A13ABEC48DD237D64BB93BF5B473CC5A36BEEEA7D7D2E6362C9B23EBC92B46", "_encstr_93F10B7121D740B981FAC86B73", 1);

  foreach(var_6 in var_4)
  var_6 setscriptablepartstate("_encstr_99E22810D717608191C661FBDD8AE3E87F77B09843A1381FFBE8F0F3F2D23B10A4DF1048D37F93394293", "_encstr_93F10B7121D740B981FAC86B73", 1);
}

_id_11FAC(var_0) {
  var_1 = getentitylessscriptablearrayinradius("_encstr_B6F91532D06DC42B7EBEE4E9406DC7CD87C1EA8A3029FB", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_3 in var_1)
  var_3 setscriptablepartstate("_encstr_B46F14A00834A163AF3ADCB86B3A60488FD92B10357B", "_encstr_88FB0FB54BD7A00BEE6F8CAAF0489F68E1", 1);
}

_id_126F4(var_0, var_1) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_0.staticc130 scripts\engine\utility::waittill_match_or_timeout("_encstr_824E060F2147FBB8", "_encstr_A98609B8C39F15416FB7E6", 30.0);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || isbot(var_4)) {
      continue;
    }
    var_4 scripts\mp\utility\player::_id_1328C("_encstr_9A1804890618", 1);
  }

  var_0.aidoorchief scripts\mp\utility\player::_id_1328C("_encstr_9A1804890618");
}

headoffset(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4.manualoverridewindmaterial = undefined;
  }

  var_0.aidoorchief scripts\mp\utility\player::_id_1328C("_encstr_934C0218");
}

_id_126F5(var_0, var_1) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || isbot(var_4)) {
      continue;
    }
    var_4 scripts\mp\utility\player::_id_1328C("_encstr_840703171A", 1);
  }
}

headshot_distance(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4.manualoverridewindmaterial = undefined;
  }
}

_id_126F6(var_0, var_1) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("_encstr_8B92075E3753DAE2B9", "_encstr_A98609B8C39F15416FB7E6", 30.0);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || isbot(var_4)) {
      continue;
    }
    var_4 scripts\mp\utility\player::_id_1328C("_encstr_840703171A", 1);
  }
}

healdamage(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4.manualoverridewindmaterial = undefined;
  }
}

healthpack_health(var_0) {
  _id_14361(7.7);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 clearsoundsubmix("_encstr_870F12B507D73139AF96E6992D8DEB85C6629906", 30.0);
  }
}

healthpool(var_0) {
  _id_14361(0.65);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 clearsoundsubmix("_encstr_83DB1103A801C0F6B75270793A133880E519BB", 3.0);
  }
}

health_remaining_max(var_0) {
  _id_14361(0.5);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 clearsoundsubmix("_encstr_ABDD315A110DD791E88F0702B178A627388972023E551BD608D924375B306A775EE61B7A233B73CBD0E97D2F5BB0F767F7D882", 1.0);
  }
}

_id_131BF(var_0) {
  _id_14361(2.0);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_3 clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
    var_3 setsoundsubmix("_encstr_ABDD315A110DD791E88F0702B178A627388972023E551BD608D924375B306A775EE61B7A233B73CBD0E97D2F5BB0F767F7D882", 2.0);
  }
}

_id_12C3E(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3 getlinkedchildren();

    if(isDefined(var_4) && var_4.size) {
      var_5 = var_4.size;

      if(var_5 > 0) {
        var_6 = "_encstr_990D0FA4E69996B110416385E5AC4E800A" + var_3.name + "_encstr_ABDA09AE3984E75B081170" + var_5 + "_encstr_BD9C1096F74A038572D56019F7B818C89266";

        foreach(var_8 in var_4) {
          if(isDefined(var_8.equipmentref)) {
            var_6 = var_6 + ("_encstr_B86F07FB4173601FCA" + var_8.equipmentref + "_encstr_964C0249");
            continue;
          }

          if(isDefined(var_8.weapon_name)) {
            var_6 = var_6 + ("_encstr_880108D3A10B78F2C88D" + var_8.weapon_name + "_encstr_964C0249");
            continue;
          }

          if(isDefined(var_8.model)) {
            var_6 = var_6 + ("_encstr_B433077AD061FF13DA" + var_8.model + "_encstr_964C0249");
            continue;
          }

          var_6 = var_6 + "_encstr_A707036734";
        }

        scripts\mp\utility\script::laststand_dogtags(var_6);
      }
    }
  }
}

_id_1273C(var_0, var_1) {
  _id_12C3E(var_1);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    _id_1245A(var_0, var_1);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    _id_12765(var_0, var_1);
  else
    playac130infilanim(var_0, var_1);
}

_id_1245A(var_0, var_1) {
  thread _id_131BF(var_1);
  _id_12459(var_0, var_1);
  _id_13CE9(var_0, var_1);
  mp_m_trench_patch_giveplayer_c4(var_0, var_1);
}

playac130infilanim(var_0, var_1) {
  thread _id_131BF(var_1);
  _id_12442(var_0, var_1);
  _id_13CE8(var_0, var_1);
  mp_m_speed_patch(var_0, var_1);
}

_id_12765(var_0, var_1) {
  thread _id_131BF(var_1);
  _id_12764(var_0, var_1);
  _id_13CF1(var_0, var_1);
  neverspectate(var_0, var_1);
}

helicopter_death_lockon_clear(var_0) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_0.staticc130 waittillmatch("_encstr_824E060F2147FBB8", "_encstr_B26910A36EF1FD1B1734F3BF954303D703E0");
  triggerfx(var_0.helicountdownendcallback);
}

_id_1324F(var_0) {
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.sort = -1;
  var_0.color = (0.21, 0.21, 0.17);
  var_0.alpha = 0;
  var_0 sendcollectedclientanticheatdata(1);
}

_id_13250(var_0) {
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.sort = -1;
  var_0.color = (0.93, 0.95, 0.94);
  var_0.alpha = 0;
  var_0 sendcollectedclientanticheatdata(1);
}

remove_munitions_globally() {
  var_0 = undefined;
  var_1 = undefined;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
    var_0 = 0.15;
    var_1 = 0.2;
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    var_0 = 0.16;
    var_1 = 0.5;
  } else {
    var_0 = 0.16;
    var_1 = 0.5;
  }

  return [var_0, var_1];
}

patch_ent_fixes(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = remove_munitions_in_radius(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);
  var_4 = level.players.size == var_3.size;

  if(var_4) {
    level.stop_passedby_once = newhudelem();
    _id_1324F(level.stop_passedby_once);
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_passedby_once = newclienthudelem(var_6);
      _id_1324F(var_6.stop_passedby_once);
    }
  }

  [var_9, var_10] = remove_munitions_globally();
  var_2 waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_8BB40CF84FAC69135A6A951702D3");

  if(var_4) {
    level.stop_passedby_once fadeovertime(var_9);
    level.stop_passedby_once.alpha = 1;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_passedby_once fadeovertime(var_9);
      var_6.stop_passedby_once.alpha = 1;
    }
  }

  var_2 waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_97A50D66B0462B7BD5476E3AB0C9A3");

  if(var_4) {
    level.stop_passedby_once fadeovertime(var_10);
    level.stop_passedby_once.alpha = 0;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_passedby_once fadeovertime(var_10);
      var_6.stop_passedby_once.alpha = 0;
    }
  }

  _id_14361(var_10 + 0.1);

  if(var_4) {
    level.stop_passedby_once destroy();
    level.stop_passedby_once = undefined;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_passedby_once destroy();
    }
  }
}

helicopter_firendly_dmg_text_display(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  var_2 = remove_munitions_in_radius(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);
  var_4 = level.players.size == var_3.size;

  if(var_4) {
    level.stop_turbulence_just_before_the_end = newhudelem();
    _id_13250(level.stop_turbulence_just_before_the_end);
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_turbulence_just_before_the_end = newclienthudelem(var_6);
      _id_13250(var_6.stop_turbulence_just_before_the_end);
    }
  }

  var_8 = 0.2;
  var_9 = 0.6;
  var_2 waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_877C0BCA570E2B5E3A7327B8B3");
  wait 0.12;

  if(var_4) {
    level.stop_turbulence_just_before_the_end fadeovertime(var_8);
    level.stop_turbulence_just_before_the_end.alpha = 1;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_turbulence_just_before_the_end fadeovertime(var_8);
      var_6.stop_turbulence_just_before_the_end.alpha = 1;
    }
  }

  var_2 waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_961804BD954A");
  wait 0.3;

  if(var_4) {
    level.stop_turbulence_just_before_the_end fadeovertime(var_9);
    level.stop_turbulence_just_before_the_end.alpha = 0;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_turbulence_just_before_the_end fadeovertime(var_9);
      var_6.stop_turbulence_just_before_the_end.alpha = 0;
    }
  }

  _id_14361(var_9 + 0.1);

  if(var_4) {
    level.stop_turbulence_just_before_the_end destroy();
    level.stop_turbulence_just_before_the_end = undefined;
  } else {
    foreach(var_6 in var_3) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6.stop_turbulence_just_before_the_end destroy();
    }
  }
}

stimmodelattached(var_0) {
  var_1 = getdvarfloat("_encstr_88060B49BC98F12F2F63C13907");
  var_2 = getdvarint("_encstr_BE360B89A215A69A0AD229B47A");
  var_3 = getdvarint("_encstr_91070B6BA23D9140AB28DFA4C4");
  var_4 = getdvarfloat("_encstr_84D20BC8A9B7B51394314358D9");
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1000.0);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 6);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.25);
  var_0 scripts\engine\utility::waittill_either("_encstr_85D218A1D2C2BBA83F5A3B4BC111A70B680F73E5875504F7829B", "_encstr_B81A0AB98E7B074D3659B9AC");
  setDvar("_encstr_88060B49BC98F12F2F63C13907", var_1);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", var_2);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", var_3);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", var_4);
}

stompeenemyprogressupdate(var_0) {
  var_1 = getdvarfloat("_encstr_88060B49BC98F12F2F63C13907");
  var_2 = getdvarint("_encstr_BE360B89A215A69A0AD229B47A");
  var_3 = getdvarint("_encstr_91070B6BA23D9140AB28DFA4C4");
  var_4 = getdvarfloat("_encstr_84D20BC8A9B7B51394314358D9");
  setDvar("_encstr_88060B49BC98F12F2F63C13907", 1000.0);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", 8);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", 8);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", 0.25);
  var_0 scripts\engine\utility::waittill_either("_encstr_85D218A1D2C2BBA83F5A3B4BC111A70B680F73E5875504F7829B", "_encstr_B81A0AB98E7B074D3659B9AC");
  setDvar("_encstr_88060B49BC98F12F2F63C13907", var_1);
  setDvar("_encstr_BE360B89A215A69A0AD229B47A", var_2);
  setDvar("_encstr_91070B6BA23D9140AB28DFA4C4", var_3);
  setDvar("_encstr_84D20BC8A9B7B51394314358D9", var_4);
}

givecustomloadout(var_0) {
  if(isDefined(var_0.givestandardtableloadout))
    var_0.givestandardtableloadout hide();

  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("_encstr_8B92075E3753DAE2B9", "_encstr_8E5E09B9D0EDBB917B7B93", 30.0);

  if(isDefined(var_0.givestandardtableloadout))
    var_0.givestandardtableloadout show();
}

cargo_truck_mg_initinteract(var_0, var_1) {
  var_2 = undefined;

  if(var_0.infil_anim_type == "_encstr_8BB007E03658CBCAE4") {
    if(!isDefined(var_1)) {
      foreach(var_4 in level.teamnamelist) {
        var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemies_fallback_logic(var_4);

        for(var_6 = 0; var_6 < var_5.size; var_6++) {
          var_7 = var_5[var_6];
          var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_4, var_7);
          var_9 = var_8.size == 1;
          var_10 = fivecontracts(var_8.size);

          foreach(var_14, var_12 in var_8) {
            if(var_12 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath())
              var_12.infilanimindex = 1;
            else {
              var_13 = scripts\engine\utility::random(var_10);
              var_12.infilanimindex = var_13;
              var_10 = scripts\engine\utility::array_remove(var_10, var_13);
            }

            var_12.stop_counter_beep_sfx_on_bomb_vests = var_9;
          }
        }
      }

      _id_12ACC();

      foreach(var_12 in level.players) {
        if(isDefined(var_12) && !isDefined(var_12.stop_counter_beep_sfx_on_bomb_vests)) {
          var_12.infilanimindex = 1;
          var_12.stop_counter_beep_sfx_on_bomb_vests = 1;
        }
      }

      return;
    }

    foreach(var_12 in var_1) {
      if(!isDefined(var_12)) {
        continue;
      }
      var_12 playerhide();
      var_12 showtoplayer(var_12);
      var_12.infilanimindex = 1;
      var_12.stop_counter_beep_sfx_on_bomb_vests = 1;
    }

    return;
  } else {}
}

_id_12442(var_0, var_1) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  cargo_truck_mg_initinteract(var_0, var_1);
  var_2 = 34;
  var_3 = 5.6;
  var_4 = 50.7;
  var_5 = 2.0;
  var_6 = 4;
  var_0.cameraent scriptmodelplayanim("_encstr_BE01251241589712870717136D234ADF78091A8A33D962AAD53B5BDF6959424130B30269F17035", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0.gas_trigger))
    var_0.gas_trigger scriptmodelplayanim("_encstr_BE01251241589712870717136D234ADF78091A8A33D962AAD53B5BDF6959424130B30269F17035", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0.movingc130))
    var_0.movingc130 stoploopsound();

  var_7 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection();
  var_0.aidoorchief hide();
  var_8 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }
    if(!var_7) {
      var_10 setsoundsubmix("_encstr_83DB1103A801C0F6B75270793A133880E519BB", 0.0);
      var_10 setsoundsubmix("_encstr_911712B50EEB26E47DA5B9995A8DEBD6BADC9636", 0.0);

      if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level._id_12D05))
        var_10 setsoundsubmix("_encstr_870F12B507D73139AF96E6992D8DEB85C6629906", 0.0);

      var_10 setclienttriggeraudiozone("_encstr_9950154513E17CE238C3D33727484ABEF098BD41A87314", 1.0);
    }

    var_0.gas_trap_weapon = "_encstr_824E080247038BE80737" + var_10.infilanimindex;
    var_10 cameraunlink();
    var_10 cameralinkTo(var_0.cameraent, var_0.gas_trap_weapon, 1, 1);
    var_10 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_2);
    var_10 enablephysicaldepthoffieldscripting();
    var_10 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    var_10 scripts\mp\utility\player::_freezelookcontrols(1);
    var_0.aidoorchief showtoplayer(var_10);
  }

  thread healthpool(var_1);
  thread getlightingvalues();
  playFXOnTag(level._effect["_encstr_926614331B0B190172FE6656EF7FF96F2189CAF5FC1B"], var_0.staticc130, "_encstr_8F1E092CC9F71178C01941");
  var_0.staticc130 scriptmodelplayanim("_encstr_ABFC270A59408F1AFF7F1F0B652B52D7700112823BD16A52DD3323D771414A39084B3A118998510F0F", "_encstr_824E060F2147FBB8");

  if(isDefined(var_0.movingc130)) {
    var_0.movingc130 scriptmodelplayanim("_encstr_ABFC270A59408F1AFF7F1F0B652B52D7700112823BD16A52DD3323D771414A39084B3A118998510F0F", "_encstr_824E060F2147FBB8");
    var_0.movingc130.innards scriptmodelplayanim("_encstr_ABFC270A59408F1AFF7F1F0B652B52D7700112823BD16A52DD3323D771414A39084B3A118998510F0F", "_encstr_95980DE01B16DC59A4CDE62CE491CD");
  }

  var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] scriptmodelplayanim("_encstr_8DB528E359EEA78560579996CD400D5F9F515F6F6BD05BFF983B905FDF7016A337C983B24B88FB34E06F", "_encstr_8F0E0583E4DB83");

  if(var_0.infil_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    var_0.playerslot1 scriptmodelplayanim("_encstr_B642219FE5A2E9307F2743C5336F65E04BF6777B5A118D5351EB2B373B6DB713C8404A", "_encstr_840703931E");
    var_0.playerslot2 scriptmodelplayanim("_encstr_844221E79323A86060C130E8B75120E04AE71BEF5A5986F88CA31AC65A0C702BE21B95", "_encstr_B20703F066");
    var_0.playerslot3 scriptmodelplayanim("_encstr_B24221A319AEE7C52017D9D60D80CD9F5F911F2F2B909B3F587BD09F399056CFF52BB7", "_encstr_A607036B0B");
    var_0.playerslot4 scriptmodelplayanim("_encstr_854221D36930711F975E2A2201635339F0CF291B59B1C2E7B5333339EBC99F687895A4", "_encstr_B60703ABCF");
  } else if(var_0.infil_anim_type == "_encstr_8BB007E03658CBCAE4")
    thread playinfilplayeranims(var_0, var_1);

  var_0.aidoorchief scriptmodelplayanim("_encstr_AF1223B862BA9780F3678B7036FFE8CF26BA1232BF1905599B550BE00C3F705D0E72581832", "_encstr_848F0A0CB710F2FF4350D2EA");
  level thread _id_11FAC(var_0);
  level thread _id_12AB5(var_0);
  level thread serverroomrewardlocs(var_0);
  level thread _id_126F4(var_0, var_1);
  level thread helicopter_death_lockon_clear(var_0);
  level thread patch_ent_fixes(var_0, var_1);
  level thread stimmodelattached(var_0);
  level thread ks_circleminimapradius(var_0, var_1);
  var_0.cameraent scripts\engine\utility::waittill_match_or_timeout("_encstr_8B92075E3753DAE2B9", "_encstr_8F5B0B6405C72BFB53CB58E790", 30.0);
  var_0 notify("_encstr_85D218A1D2C2BBA83F5A3B4BC111A70B680F73E5875504F7829B");
  level headoffset(var_0, var_1);
}

#using_animtree("_encstr_B40101");

_id_12459(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  cargo_truck_mg_initinteract(var_0, var_1);
  var_4 = 48;
  var_5 = 5.6;
  var_6 = 50.7;
  var_7 = 2.0;
  var_8 = 4;
  var_0.gas_trigger_think scriptmodelplayanim("_encstr_81B21A8B807F74F52E48D82F48574801DB69815F9260791F670E5F28", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0.gas_triggers_init))
    var_0.gas_triggers_init scriptmodelplayanim("_encstr_81B21A8B807F74F52E48D82F48574801DB69815F9260791F670E5F28", "_encstr_8B92075E3753DAE2B9");

  var_0.gas_tryplaycoughaudio scriptmodelplayanim("_encstr_91BC1BBBF4D7A537665A367D5BD2DCC82DB0077DDC8BEAB046BE1B2CB6", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0.gas_vfx_and_triggers))
    var_0.gas_vfx_and_triggers scriptmodelplayanim("_encstr_91BC1BBBF4D7A537665A367D5BD2DCC82DB0077DDC8BEAB046BE1B2CB6", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0._id_11DBF))
    var_0._id_11DBF stoploopsound();

  var_0.bot_gametype_attacker_defender_ai_director_update hide();
  var_0.bot_clear_hq_zone hide();
  var_9 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_11 in var_9) {
    if(!isDefined(var_11)) {
      continue;
    }
    var_11 playlocalsound("_encstr_BE8417E23A49332DC9A8461F800EE3F877E8F93B4BA7FFFCEB");
    var_11 setsoundsubmix("_encstr_83DB1103A801C0F6B75270793A133880E519BB", 0.0);
    var_11 setsoundsubmix("_encstr_911712B50EEB26E47DA5B9995A8DEBD6BADC9636", 0.0);

    if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level._id_12D05))
      var_11 setsoundsubmix("_encstr_870F12B507D73139AF96E6992D8DEB85C6629906", 0.0);

    var_11 setclienttriggeraudiozone("_encstr_9950154513E17CE238C3D33727484ABEF098BD41A87314", 1.0);
    var_12 = scripts\engine\utility::ter_op(var_11.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_trigger_think, var_0.gas_tryplaycoughaudio);
    var_13 = "_encstr_AFAA09344628DA52A72756";
    var_11 cameraunlink();
    var_11 cameralinkTo(var_12, var_13, 1, 1);
    var_11 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_4);
    var_11 setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 1);
    var_11 enablephysicaldepthoffieldscripting();
    var_11 setphysicaldepthoffield(var_5, var_6, var_7, var_8);
    var_11 scripts\mp\utility\player::_freezelookcontrols(1);
    var_0.bot_gametype_attacker_defender_ai_director_update showtoplayer(var_11);
    var_0.bot_clear_hq_zone showtoplayer(var_11);
  }

  thread healthpool(var_1);

  if(isDefined(var_0._id_11DBF))
    var_0._id_11DBF setscriptablepartstate("_encstr_AAC50E3B73D94C6BD7C9D341F8FFAAE5", "_encstr_AB0703DBB9");

  var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] scriptmodelplayanim("_encstr_9A7E253B652F90F8EE8B89D10D10C8633F86A2F17B9FD898E8B62BF62AEA2F83FDE380D2733857", "_encstr_8F0E0583E4DB83");
  var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] scriptmodelplayanim("_encstr_87B3260813616B705BA1F9788D4F38C9540AEAC17B029BA90BEF76EB99DB018F7BD23039225CF520", "_encstr_8F0E0583E4DB83");

  if(var_0.infil_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    if(istrue(var_2)) {
      var_0._id_1269E show();
      var_0._id_1269F hide();
      var_0._id_126A0 hide();
      var_0._id_126A1 hide();
      var_0._id_126A2 hide();
    } else {
      var_0._id_1269E hide();
      var_0._id_1269F show();
      var_0._id_126A0 show();
      var_0._id_126A1 show();
      var_0._id_126A2 show();
    }

    var_15 = "_encstr_B40101";

    if(istrue(var_3))
      var_15 = "_encstr_9243059F464770";

    var_0._id_1269E scriptmodelplayanim("_encstr_A9731D2723397BA0BE846806AD697825B2B731EFAF82B1E0EFDA50D9504DD0" + var_15, "_encstr_840703931E");
    var_0._id_1269F scriptmodelplayanim("_encstr_AC7B1FC89B2F40B5020461E01DAAEDA9718F3A1117B91B63CAA1677176833393F1" + var_15, "_encstr_840703931E");
    var_0._id_126A0 scriptmodelplayanim("_encstr_B87B1F778B9FD33AEA2B64C7B8E38A09F76F68F983E75F719A4F2B9461130530CB" + var_15, "_encstr_B20703F066");
    var_0._id_126A1 scriptmodelplayanim("_encstr_8E7B1FEE9ED7D2DC33A5367DAD4BCD8C4B1607AF9B2EAE5823F538630BBC564E33" + var_15, "_encstr_A607036B0B");
    var_0._id_126A2 scriptmodelplayanim("_encstr_BE7B1FF362D141C22CCBA377DB430A8498E9B871FB08054A758FDBB32B73E2EADA" + var_15, "_encstr_B60703ABCF");
  } else if(var_0.infil_anim_type == "_encstr_8BB007E03658CBCAE4")
    thread playinfilplayeranims(var_0, var_1);

  var_0.bot_gametype_attacker_defender_ai_director_update scriptmodelplayanim("_encstr_961C1CB490F9DBC8665F901157B1CD0922FE8B28AA9289D077D3B08077C4", "_encstr_B2A708E1CB77DF6DAFC8");
  var_0.bot_clear_hq_zone scriptmodelplayanim("_encstr_B1871E474876C942651BAD6971033A8CD808F25FA8A8349A3F2675DA6B21E244", "_encstr_9AF20A0BB4D0B7C14B63DB47");
  var_0.calloutmarkerpingvo_handleraddnewelement scriptmodelplayanim("_encstr_B80518FB1A97BA5EF970F33738700632533F90790F3532998128", "_encstr_8BCD0AF0DBA5C3898F42A3AC");

  foreach(var_17 in var_0.calloutmarkerpingvo_getmaxsoundaliaslength) {
    var_18 = getanimlength(%_encstr_A3111A28E5B10C688959D571DB40A582B08F8FF96517D78140901BA2);
    var_19 = randomfloatrange(0.5, var_18 - 0.5);
    var_17 scriptmodelplayanim("_encstr_A3111A28E5B10C688959D571DB40A582B08F8FF96517D78140901BA2", "_encstr_97E70E4F5860B1921B7EFC35CFE15A6A", var_19);
    var_17 setscriptablepartstate("_encstr_ACB510E28090D4F449F9D8A1EABB1D59DCEF", "_encstr_AB0703DBB9");

    if(isDefined(var_17.innards))
      var_17.innards scriptmodelplayanim("_encstr_A3111A28E5B10C688959D571DB40A582B08F8FF96517D78140901BA2", "_encstr_BDAE1516E4D60B2385D00D7BE00EAC2792E6738527C86E", var_19);
  }

  level thread _id_126F5(var_0, var_1);
  level thread givecustomloadout(var_0);
  level thread patch_ent_fixes(var_0, var_1);
  level thread stompeenemyprogressupdate(var_0);
  level thread ks_circleminimapradius(var_0, var_1);
  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("_encstr_8B92075E3753DAE2B9", "_encstr_8F5B0B6405C72BFB53CB58E790", 30.0);
  var_0 notify("_encstr_85D218A1D2C2BBA83F5A3B4BC111A70B680F73E5875504F7829B");
  level headshot_distance(var_0, var_1);
}

_id_12764(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_B81A0AB98E7B074D3659B9AC");
  cargo_truck_mg_initinteract(var_0, var_1);
  var_4 = 42;
  var_5 = 5.6;
  var_6 = 50.7;
  var_7 = 2.0;
  var_8 = 4;
  var_0.gas_trigger_think scriptmodelplayanim("_encstr_A2171A83BA585F6530DB7C47C7706CF3F8B65BEA402C039F2137694D", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0.gas_triggers_init))
    var_0.gas_triggers_init scriptmodelplayanim("_encstr_A2171A83BA585F6530DB7C47C7706CF3F8B65BEA402C039F2137694D", "_encstr_8B92075E3753DAE2B9");

  var_0.gas_tryplaycoughaudio scriptmodelplayanim("_encstr_82D419BB9EF5A59BCCB463F56EB5D263BDF537C55716197DB116B6", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0.gas_vfx_and_triggers))
    var_0.gas_vfx_and_triggers scriptmodelplayanim("_encstr_82D419BB9EF5A59BCCB463F56EB5D263BDF537C55716197DB116B6", "_encstr_8B92075E3753DAE2B9");

  if(isDefined(var_0._id_11DC3))
    var_0._id_11DC3 stoploopsound();

  var_0._id_13886 setscriptablepartstate("_encstr_85CE0F9F48F12982F77C4889DEA7EAE478", "_encstr_AC6D0770ABB619D877");
  var_9 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection();
  var_10 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12)) {
      continue;
    }
    if(!var_9) {
      if(var_12.stop_counter_beep_sfx_on_bomb_vests) {
        thread stop_strafe_minigun_manager("_encstr_92D51D5DEA41083A2F42909E5BDF6130E959FDDD69F521FF37BB0B4BA18B26", 0.8, var_12);
        thread stop_strafe_minigun_manager("_encstr_AFCB1D4A23C0BFAC3059E7CF7FD8B50768F8029228215722588DF4AA0FA87A", 6.4, var_12);
      } else {
        thread stop_strafe_minigun_manager("_encstr_B45D1D028599BAC7DBF88A71A32D27B7411BB68E2B68C9F3F713339F4E8913", 0.8, var_12);
        thread stop_strafe_minigun_manager("_encstr_B1571D8D83B9F608314588862AF580A551171D1D4732A89851DAD33359C450", 6.4, var_12);
      }

      var_12 setsoundsubmix("_encstr_83DB1103A801C0F6B75270793A133880E519BB", 0.0);
      var_12 setsoundsubmix("_encstr_911712B50EEB26E47DA5B9995A8DEBD6BADC9636", 0.0);

      if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level._id_12D05))
        var_12 setsoundsubmix("_encstr_870F12B507D73139AF96E6992D8DEB85C6629906", 0.0);

      var_12 setclienttriggeraudiozone("_encstr_9A40140F591822C3C889058F66C8160AEB893F97FD35", 1.0);
    }

    var_13 = scripts\engine\utility::ter_op(var_12.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_trigger_think, var_0.gas_tryplaycoughaudio);
    var_14 = "_encstr_AFAA09344628DA52A72756";
    var_12 cameraunlink();
    var_12 cameralinkTo(var_13, var_14, 1, 1);
    var_12 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_4);
    var_12 setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 1);
    var_12 enablephysicaldepthoffieldscripting();
    var_12 setphysicaldepthoffield(var_5, var_6, var_7, var_8);
    var_12 scripts\mp\utility\player::_freezelookcontrols(1);
    var_12 calloutmarkerping_getinventoryslot(5000.0);
    var_12 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_0._id_13886.origin);
  }

  thread healthpool(var_1);

  if(isDefined(var_0._id_11DC3.bunker_numberstation)) {
    var_0._id_11DC3.bunker_numberstation setscriptablepartstate("_encstr_91C110B8126F2B707F6E33B8439BD8AB576B", "_encstr_AB0703DBB9");
    var_0._id_11DC3.bunker_numberstation setscriptablepartstate("_encstr_85CE0F9F48F12982F77C4889DEA7EAE478", "_encstr_ACC107AD988D31CD07");
  }

  thread getlightingvalues();
  var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] scriptmodelplayanim("_encstr_960E1FACE84EE0056BB8AB9703C49BD060B9E7930838B9D2F1B211B80999F0882C", "_encstr_8F0E0583E4DB83");
  var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] scriptmodelplayanim("_encstr_A1D51EEEF4EBD2CD33B48DF5CDB65A8DF6FA37B85D2C237DB92327EBD8B4DCB6", "_encstr_8F0E0583E4DB83");

  if(var_0.infil_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    if(istrue(var_2)) {
      var_0._id_1269E show();
      var_0._id_1269F hide();
      var_0._id_126A0 hide();
      var_0._id_126A1 hide();
      var_0._id_126A2 hide();
    } else {
      var_0._id_1269E hide();
      var_0._id_1269F show();
      var_0._id_126A0 show();
      var_0._id_126A1 show();
      var_0._id_126A2 show();
    }

    var_16 = "_encstr_B40101";

    if(istrue(var_3))
      var_16 = "_encstr_9243059F464770";

    var_0._id_1269E scriptmodelplayanim("_encstr_827E1CE3AB77B37067912957930C80890F51FBA892FF7910F1633105F8E2" + var_16, "_encstr_840703931E");
    var_0._id_1269F scriptmodelplayanim("_encstr_81641B3BAA19893AE4037BBF5F1A32F4F096B202E3304CE146211B7AC3" + var_16, "_encstr_840703931E");
    var_0._id_126A0 scriptmodelplayanim("_encstr_87641BBB4FF54BDC334B637DCDDAA5D8DBAFCD2E572C327DE691E41846" + var_16, "_encstr_B20703F066");
    var_0._id_126A1 scriptmodelplayanim("_encstr_96641BDF9A4E070555D84A71E0A73CEBA0904351B5D17B012788B37FFA" + var_16, "_encstr_A607036B0B");
    var_0._id_126A2 scriptmodelplayanim("_encstr_AD641BD782C1921AC6504C778F8FEC0DF729DA9A5B9828C038D1BBF2DD" + var_16, "_encstr_B60703ABCF");
  } else if(var_0.infil_anim_type == "_encstr_8BB007E03658CBCAE4")
    thread playinfilplayeranims(var_0, var_1);

  if(isDefined(var_0._id_13886))
    var_0._id_13886 scriptmodelplayanim("_encstr_97171AEE3DFA5AB9992D1BF5CDB52DB1EDBE6E5A9BCE6395FACEACD0", "_encstr_824E060F2147FBB8", 0, 1);

  if(isDefined(var_0._id_12D98))
    var_0._id_12D98 scriptmodelplayanim("_encstr_A65A200BA8C72CCBA1D30C07F6289F35FFE93362901FA53F7E440D389853BFFA0330", "_encstr_824E060F2147FBB8", 0, 1);

  foreach(var_18 in var_0._id_12915) {
    if(isDefined(var_18))
      var_18 scriptmodelplayanim("_encstr_97171AEE3DFA5AB9992D1BF5CDB52DB1EDBE6E5A9BCE6395FACEACD0", "_encstr_824E060F2147FBB8", 0, 1);
  }

  if(isDefined(var_0._id_13887))
    var_0._id_13887 scriptmodelplayanim("_encstr_97851B430BD713D007F14937F3AC2069EFB15B08F29FD9F011D4475F1A", "_encstr_824E060F2147FBB8", 0, 1);

  level thread _id_126F6(var_0, var_1);
  level thread _id_133B1(var_0);
  level thread patch_ent_fixes(var_0, var_1);
  level thread helicopter_firendly_dmg_text_display(var_0, var_1);
  level thread spawn_apache_chopper(var_0, var_1);
  level thread laser_vfx_think(var_0, 1);
  level thread stimmodelattached(var_0);
  level thread ks_circleminimapradius(var_0, var_1);
  level thread _id_12E63(var_0, var_1);
  var_0.gas_trigger_think scripts\engine\utility::waittill_match_or_timeout("_encstr_8B92075E3753DAE2B9", "_encstr_8F5B0B6405C72BFB53CB58E790", 30.0);
  var_0 notify("_encstr_85D218A1D2C2BBA83F5A3B4BC111A70B680F73E5875504F7829B");
  level thread healdamage(var_0, var_1);
}

_id_12E63(var_0, var_1) {
  if(getdvarint("_encstr_AB412CF347105103B67E0A4261037319403F9164C7D1E2D754D1618B6969478B18EF12FC73C82C670E88ABF2713E", 1) == 0) {
    return;
  }
  var_2 = remove_munitions_in_radius(var_0);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);
  var_2 scripts\engine\utility::waittill_match_or_timeout("_encstr_8B92075E3753DAE2B9", "_encstr_961804BD954A", 30.0);
  wait 0.25;

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
    var_5 skydive_cutparachuteoff();
  }
}

spawn_apache_chopper(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) == 0 || !isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.br_infils_disabled)) {
    return;
  }
  var_2 = remove_munitions_in_radius(var_0);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    level.br_circle.dangercircleent hidefromplayer(var_5);
  }

  var_2 scripts\engine\utility::waittill_match_or_timeout("_encstr_8B92075E3753DAE2B9", "_encstr_961804BD954A", 30.0);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    level.br_circle.dangercircleent showtoplayer(var_5);
  }
}

stop_strafe_minigun_manager(var_0, var_1, var_2) {
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait(var_1);
  var_2 playlocalsound(var_0);
}

ks_circleminimapradius(var_0, var_1) {
  var_2 = remove_objective_on_flag(var_0);

  if(isDefined(var_2) && getdvarint("_encstr_B43C1BC27188473236B7CF2B1555CABD6158F54D4B380E3A1FF98F4B13", 1) == 1) {
    var_3 = getdvarint("_encstr_8CFD20C377206133862EFB93935577A5A9C76557A510F51FBF20D23A592DBF5D6873", 8);
    wait(var_3);
    var_4 = var_2.origin;
    var_5 = getdvarint("_encstr_B15B22D367307123965E8B83836567B559D75547D54BC5EFAF10A22A49DCA7AAE8B3E2D4", 0);

    if(var_5 > 0) {
      var_6 = anglesToForward(var_2.angles);
      var_4 = var_2.origin + var_6 * var_5;
    }

    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9 calloutmarkerping_getinventoryslot(0.0);
      var_9 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_4);
    }
  }
}

_id_138F3(var_0, var_1) {
  var_2 = remove_objective_on_flag(var_0);

  if(isDefined(var_2) && getdvarint("_encstr_B43C1BC27188473236B7CF2B1555CABD6158F54D4B380E3A1FF98F4B13", 1) == 1) {
    var_3 = getdvarint("_encstr_99012373C652D9160B4FDFA98302EF6B2C5D3C482BA1A85C01ABF395F728A09094B7800110", 5);
    wait(var_3);
    var_4 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_6 in var_4) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_6 thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
    }
  }
}

_id_13F06(var_0, var_1) {
  wait(var_0);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 scripts\mp\utility\player::_freezelookcontrols(0);
  }
}

_id_13CE8(var_0, var_1) {
  var_2 = 65;
  var_3 = 14;
  var_4 = 35;
  var_5 = 2.0;
  var_6 = 4;

  if(isDefined(var_0.gas_trigger)) {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9 calloutmarkerping_getcreatedtime(0.0);

      if(!isDefined(var_9.infilanimindex))
        var_9.infilanimindex = 1;

      var_0.gas_trap_weapon = "_encstr_824E080247038BE80737" + var_9.infilanimindex;
      var_9 cameraunlink();
      var_9 cameralinkTo(var_0.gas_trigger, var_0.gas_trap_weapon, 1, 1);
      var_9 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_2);
      var_9 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    }

    thread health_remaining_max(var_1);
  } else {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9 calloutmarkerping_getcreatedtime(0.0);
    }
  }

  if(isDefined(var_0.helicountdownendcallback)) {
    if(isDefined(var_0.movingc130))
      var_0.helicountdownendcallback.origin = var_0.movingc130.origin;
  }

  var_0.staticc130 hide();
  var_0.cameraent unlink();
  var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] unlink();

  if(isDefined(var_0.movingc130)) {
    var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] linkTo(var_0.movingc130, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    var_0.cameraent linkTo(var_0.movingc130, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    var_0.movingc130 notify("_encstr_A2810D5F30B9EADB1F11752B0B15A2");
  }

  setomnvar("_encstr_A3891553A45F40B34A87A7C19B2283602AB158E94DC620", 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }
    var_9 setclienttriggeraudiozone("_encstr_B150155F0948A28FA879D31AD049C17ABC53C31F9B036B", 2.0);
  }

  thread healthpack_health(var_1);

  if(var_0.infil_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    var_0.playerslot1 scriptmodelplayanim("_encstr_8EC11D5F59B679E583962CF5A9103CB187EFDEC6994812AFD09BA97AC0B229", "_encstr_840703931E");
    var_0.playerslot2 scriptmodelplayanim("_encstr_82C11D331A93F838521793E5567C78A087C2C3B3C7CFA9F0AD10F7D174F272", "_encstr_B20703F066");
    var_0.playerslot3 scriptmodelplayanim("_encstr_92C11DDC8CC9F55B1CBE2DCD332D8DBE0B1BC49903D78D7BED83EB1C8D18CC", "_encstr_A607036B0B");
    var_0.playerslot4 scriptmodelplayanim("_encstr_87C11DE646C9FADA83D7A573CCB4B17D5836269960D78DDEDE837D1C1B60D0", "_encstr_B60703ABCF");
  }

  var_0.aidoorchief scriptmodelplayanim("_encstr_B85322CB71C67F5D88AF714EE5782537E70967B793080B1598194F4C9F20EA1F9BE0BA6A", "_encstr_848F0A0CB710F2FF4350D2EA");
  level thread playac130infilloopanims(var_0);

  if(isDefined(var_0.gas_trigger))
    var_0.gas_trigger waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_961804BD954A");

  thread _id_13F06(1.2, var_1);
}

_id_13CE9(var_0, var_1) {
  var_2 = 65;
  var_3 = 14;
  var_4 = 35;
  var_5 = 2.0;
  var_6 = 4;

  if(isDefined(var_0.gas_triggers_init) && isDefined(var_0.gas_vfx_and_triggers)) {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9 calloutmarkerping_getcreatedtime(0.0);

      if(!isDefined(var_9.infilanimindex))
        var_9.infilanimindex = 1;

      if(!isDefined(var_9.stop_counter_beep_sfx_on_bomb_vests))
        var_9.stop_counter_beep_sfx_on_bomb_vests = 1;

      var_10 = scripts\engine\utility::ter_op(var_9.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_triggers_init, var_0.gas_vfx_and_triggers);
      var_11 = "_encstr_AFAA09344628DA52A72756";
      var_9 cameraunlink();
      var_9 cameralinkTo(var_10, var_11, 1, 1);
      var_9 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_2);
      var_9 setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 0);
      var_9 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    }

    thread health_remaining_max(var_1);
  } else {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9 calloutmarkerping_getcreatedtime(0.0);
    }
  }

  var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] unlink();
  var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] unlink();

  if(isDefined(var_0._id_11DBF)) {
    var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] linkTo(var_0._id_11DBF, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] linkTo(var_0._id_11DBF, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    var_0._id_11DBF notify("_encstr_A2810D5F30B9EADB1F11752B0B15A2");
  }

  var_0.calloutmarkerpingvo_handleraddnewelement unlink();

  if(isDefined(var_0._id_11DBF))
    var_0.calloutmarkerpingvo_handleraddnewelement linkTo(var_0._id_11DBF, "_encstr_B40101", (0, 0, 0), (0, 0, 0));

  setomnvar("_encstr_A3891553A45F40B34A87A7C19B2283602AB158E94DC620", 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }
    var_9 setclienttriggeraudiozone("_encstr_B150155F0948A28FA879D31AD049C17ABC53C31F9B036B", 2.0);
  }

  thread healthpack_health(var_1);

  if(var_0.infil_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    var_0._id_1269E scriptmodelplayanim("_encstr_97631B0F8D81243BB4A05269081B03DF9823C85FC958ED8BF07B4AA79B", "_encstr_840703931E");
    var_0._id_1269F scriptmodelplayanim("_encstr_97631B0F8D81243BB4A05269081B03DF9823C85FC958ED8BF07B4AA79B", "_encstr_840703931E");
    var_0._id_126A0 scriptmodelplayanim("_encstr_AA631BEEA77D4B73995AD87D5B5ADC234B2CC1AF63DEBD38AF1CD80C46", "_encstr_B20703F066");
    var_0._id_126A1 scriptmodelplayanim("_encstr_81631B3BAA19893AE4037BBF631B42FCC0516089C04047135009637AC7", "_encstr_A607036B0B");
    var_0._id_126A2 scriptmodelplayanim("_encstr_B2631BD8725E5F90C9208D9FC7BA1DA4F3299BE03870E083598398B295", "_encstr_B60703ABCF");
  }

  var_0.bot_gametype_attacker_defender_ai_director_update hide();
  var_0.bot_clear_hq_zone hide();
  level thread _id_12520(var_0);

  if(isDefined(var_0.gas_triggers_init))
    var_0.gas_triggers_init waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_961804BD954A");

  thread _id_13F06(1.2, var_1);
}

_id_13CF1(var_0, var_1) {
  var_2 = 65;
  var_3 = 14;
  var_4 = 35;
  var_5 = 2.0;
  var_6 = 4;

  if(isDefined(var_0.gas_triggers_init) && isDefined(var_0.gas_vfx_and_triggers)) {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9 calloutmarkerping_getcreatedtime(0.0);

      if(!isDefined(var_9.infilanimindex))
        var_9.infilanimindex = 1;

      if(!isDefined(var_9.stop_counter_beep_sfx_on_bomb_vests))
        var_9.stop_counter_beep_sfx_on_bomb_vests = 1;

      var_10 = scripts\engine\utility::ter_op(var_9.stop_counter_beep_sfx_on_bomb_vests, var_0.gas_triggers_init, var_0.gas_vfx_and_triggers);
      var_11 = "_encstr_AFAA09344628DA52A72756";
      var_9 cameraunlink();
      var_9 cameralinkTo(var_10, var_11, 1, 1);
      var_9 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", var_2);
      var_9 setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 0);
      var_9 setphysicaldepthoffield(var_3, var_4, var_5, var_6);
    }

    thread health_remaining_max(var_1);
  } else {
    var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

    foreach(var_9 in var_7) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9 calloutmarkerping_getcreatedtime(0.0);
    }
  }

  var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] unlink();
  var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] unlink();

  if(isDefined(var_0._id_11DC3)) {
    var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] linkTo(var_0._id_11DC3, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] linkTo(var_0._id_11DC3, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    var_0._id_11DC3 notify("_encstr_A2810D5F30B9EADB1F11752B0B15A2");
  }

  setomnvar("_encstr_A3891553A45F40B34A87A7C19B2283602AB158E94DC620", 0);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_9 in var_7) {
    if(!isDefined(var_9)) {
      continue;
    }
    var_9 setclienttriggeraudiozone("_encstr_AD4014B61CFA4BE68DC2E646AFA537992D36BE950F8E", 2.0);
  }

  thread healthpack_health(var_1);

  if(var_0.infil_anim_type == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    var_0.playerslot1 scriptmodelplayanim("_encstr_AC7420CB9BCF2810262DD3D62E4C11C017B1D38F837133216F2702D7B9DF6907F0B3", "_encstr_840703931E");
    var_0.playerslot2 scriptmodelplayanim("_encstr_8A3420FC3237608DCFCA639143A45B181FEF0677957789A7F202C8F2AF7119304768", "_encstr_B20703F066");
    var_0.playerslot3 scriptmodelplayanim("_encstr_96D420F390486FCDC401914977A4D0EB9FDFD84FF74931B8A6F110CF0EAF700F48D8", "_encstr_A607036B0B");
    var_0.playerslot4 scriptmodelplayanim("_encstr_9295202B2AB073F0A0498D578822A858903F320BEB90516F6093CE3A947F88E8BABA", "_encstr_B60703ABCF");
  }

  level thread _id_12766(var_0);

  if(isDefined(var_0._id_11DC3.door))
    var_0._id_11DC3.door scriptmodelplayanim("_encstr_AC5A205F75D0EA1640407D893B1029F290A7C75F356402D56109B58D73D9641A7851", "_encstr_824E060F2147FBB8", 0, 1);

  if(isDefined(var_0.gas_triggers_init))
    var_0.gas_triggers_init waittillmatch("_encstr_8B92075E3753DAE2B9", "_encstr_961804BD954A");

  thread _id_13F06(1.2, var_1);
}

mp_m_speed_patch(var_0, var_1) {
  thread wires_on_bombs();
  stopFXOnTag(level._effect["_encstr_926614331B0B190172FE6656EF7FF96F2189CAF5FC1B"], var_0.staticc130, "_encstr_8F1E092CC9F71178C01941");
  var_0.staticc130 stoploopsound();

  if(isDefined(var_0.movingc130))
    var_0.movingc130 playLoopSound("_encstr_97E10C4C93D7C21B4C6660F5D807");

  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 calloutmarkerping_getcreatedtime(0.0);
    var_4 cameraunlink();
    var_4 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", 65);
    var_4 disablephysicaldepthoffieldscripting();
    var_4 scripts\mp\utility\player::setdof_default();
  }

  level thread _id_138F3(var_0, var_1);
}

mp_m_trench_patch_giveplayer_c4(var_0, var_1) {
  var_0.chopper stoploopsound();

  if(isDefined(var_0._id_11DBF))
    var_0._id_11DBF playLoopSound("_encstr_916816C439F51A59362DBE5AE6335A8DD786ACE4F6FA1BC1");

  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 calloutmarkerping_getcreatedtime(0.0);
    var_4 cameraunlink();
    var_4 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", 65);
    var_4 setclientdvar("_encstr_AC670A0959D4F762BF3DDA79", 0);
    var_4 disablephysicaldepthoffieldscripting();
    var_4 scripts\mp\utility\player::setdof_default();
  }

  level thread _id_138F3(var_0, var_1);
}

neverspectate(var_0, var_1) {
  thread wires_on_bombs();
  var_0._id_13886 stoploopsound();

  if(isDefined(var_0._id_11DC3))
    var_0._id_11DC3 playLoopSound("_encstr_99EE1802DBB14360B1CBA1C1A027E0B0E0D77983A6600FD7B9D9");

  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 calloutmarkerping_getcreatedtime(0.0);
    var_4 cameraunlink();
    var_4 setclientdvar("_encstr_B14A0A4545A9412AC9133D26", 65);
    var_4 disablephysicaldepthoffieldscripting();
    var_4 scripts\mp\utility\player::setdof_default();
  }

  level thread _id_138F3(var_0, var_1);
}

stop_hotjoining(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    stop_firing_minigun(var_0);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    stop_module_on_delay(var_0);
  else
    stop_eye_barkov(var_0);
}

stop_eye_barkov(var_0) {
  var_1 = level._effect["_encstr_926614331B0B190172FE6656EF7FF96F2189CAF5FC1B"];
  var_2 = level._effect["_encstr_A20115D00278D721BB27CF36A156A30F652AF0707AD5C9"];

  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    var_1 = level._effect["_encstr_A14018B3CCF0AFCDE60B3A8DA17D5836139981F51B8DDEBA23DC"];

  if(isDefined(var_1))
    stopFXOnTag(var_1, var_0, "_encstr_8F1E092CC9F71178C01941");

  if(isDefined(var_2))
    stopFXOnTag(var_2, var_0, "_encstr_8F1E092CC9F71178C01941");
}

stop_firing_minigun(var_0) {}

stop_module_on_delay(var_0) {}

playac130infilloopanims(var_0) {
  if(isDefined(var_0.movingc130)) {
    var_0.movingc130 scriptmodelplayanim("_encstr_8E6E1FFE5F63FF90484F605083798847FA065726A26951980F8BA2E1C384E16DC2", "_encstr_824E060F2147FBB8");
    var_0.movingc130.innards scriptmodelplayanim("_encstr_8E6E1FFE5F63FF90484F605083798847FA065726A26951980F8BA2E1C384E16DC2", "_encstr_95980DE01B16DC59A4CDE62CE491CD");
  }

  var_0.playerpositionents["_encstr_B2D7075B7166F7FDC8"] scriptmodelplayanim("_encstr_84F32353F87BC0FA13B9AB880173D811F7175F63A2995582F70BF0C46FE0D37535EF7B6B97", "_encstr_8F0E0583E4DB83");
}

_id_12766(var_0) {
  if(isDefined(var_0._id_11DC3)) {
    var_0._id_11DC3 scriptmodelplayanim("_encstr_B42318474876C942651BAD697E074A8418F9A39F484B070B4BA3", "_encstr_824E060F2147FBB8");
    var_0._id_11DC3.bunker_numberstation scriptmodelplayanim("_encstr_B42318474876C942651BAD697E074A8418F9A39F484B070B4BA3", "_encstr_824E060F2147FBB8");
    var_0._id_11DC3.innards scriptmodelplayanim("_encstr_B42318474876C942651BAD697E074A8418F9A39F484B070B4BA3", "_encstr_95980DE01B16DC59A4CDE62CE491CD");
  }

  var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] scriptmodelplayanim("_encstr_AC4B1F474876C942651BAD697E074A8418F9A39F484B071A4BA0B25A681993014B", "_encstr_8F0E0583E4DB83");
  var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] scriptmodelplayanim("_encstr_AC4B1F474876C942651BAD697E074A8418F9A39F484B071A4BA0B25A681993014B", "_encstr_8F0E0583E4DB83");
}

_id_12520(var_0) {
  if(isDefined(var_0._id_11DBF)) {
    var_0._id_11DBF scriptmodelplayanim("_encstr_A3111A28E5B10C688959D571DB40A582B08F8FF96517D78140901BA2", "_encstr_824E060F2147FBB8");
    var_0._id_11DBF.innards scriptmodelplayanim("_encstr_A3111A28E5B10C688959D571DB40A582B08F8FF96517D78140901BA2", "_encstr_95980DE01B16DC59A4CDE62CE491CD");
  }

  var_0.playerpositionents["_encstr_99130C5F0B1BC52E91806AB8189F"] scriptmodelplayanim("_encstr_AAD321EEF4D72D37335AD8D75BD29B91B4581CF5B1BDBDE0D7D9ACE6C127DB381E8918", "_encstr_8F0E0583E4DB83");
  var_0.playerpositionents["_encstr_B8540DBFDEA34BB00C0FF0E88F31C9"] scriptmodelplayanim("_encstr_AAD321EEF4D72D37335AD8D75BD29B91B4581CF5B1BDBDE0D7D9ACE6C127DB381E8918", "_encstr_8F0E0583E4DB83");
}

_encstr_8EDC17EF52BD6FA94F7B71281B7A1D93608C5F605F7897DBD4(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2.operatorcustomization.operatorref == "_encstr_8E5E0AB968EB8385636B2BE4" || var_2.operatorcustomization.operatorref == "_encstr_81DC0BCD86AF46BD7676CA8EE8")
      var_2 visionsetnakedforplayer("_encstr_9BF60CBBD3D71DD533A1D4AF8E56");
  }
}

_encstr_99881CA59B66A5630D58B9C81B95A3AC9C6B96E65D9BB7ABA3C6A573B29B(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2.operatorcustomization.operatorref == "_encstr_8E5E0AB968EB8385636B2BE4" || var_2.operatorcustomization.operatorref == "_encstr_81DC0BCD86AF46BD7676CA8EE8")
      var_2 thread _encstr_95371860408C3939893FF3D872A0D838130BF58553FA821509AF();
  }
}

_encstr_95371860408C3939893FF3D872A0D838130BF58553FA821509AF() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = scripts\mp\utility\player::getteamarray(self.team, 1);
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.infilanimindex) && var_3.infilanimindex == 1) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1))
    var_1 hudoutlineenableforclient(self, "_encstr_84B011DBBA47D896B9B27D3A95275B9637AEE6");

  wait 0.75;

  if(isDefined(var_1))
    var_1 hudoutlinedisableforclient(self);

  wait 8.25;
  var_5 = scripts\engine\utility::random(var_0);

  if(isDefined(var_5))
    var_5 hudoutlineenableforclient(self, "_encstr_84B011DBBA47D896B9B27D3A95275B9637AEE6");

  wait 0.75;

  if(isDefined(var_5))
    var_5 hudoutlinedisableforclient(self);
}

_encstr_BDB31796DC664B63CD598EABE08EAC27DA9673D537C42DDCDA(var_0, var_1) {
  wait(var_1);
  _encstr_91D219B093C73AC3187B4DB50AFBD931251E256820EB1206B36558(var_0);
  _encstr_916D16E155B8D423AF10B23B3B0D038DA82D7563E578DDF7(var_0);
  wait 1.0;
  _encstr_99881CA59B66A5630D58B9C81B95A3AC9C6B96E65D9BB7ABA3C6A573B29B(var_0);
}

_encstr_91D219B093C73AC3187B4DB50AFBD931251E256820EB1206B36558(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2.operatorcustomization.operatorref == "_encstr_8E5E0AB968EB8385636B2BE4" || var_2.operatorcustomization.operatorref == "_encstr_81DC0BCD86AF46BD7676CA8EE8")
      var_2 skydive_cutparachuteon("_encstr_84CF1370C2BF4055CB472BDDDF23B098519A7888ED");
  }
}

_encstr_916D16E155B8D423AF10B23B3B0D038DA82D7563E578DDF7(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2.operatorcustomization.operatorref == "_encstr_8E5E0AB968EB8385636B2BE4" || var_2.operatorcustomization.operatorref == "_encstr_81DC0BCD86AF46BD7676CA8EE8")
      var_2 preloadcinematicforplayer("_encstr_84CF1370C2BF4055CB472BDDDF23B098519A7888ED");
  }
}

stoparmorinsert(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_0))
    preloadcinematicforall(var_1, 0, var_2);
  else {
    foreach(var_4 in var_0) {
      if(isDefined(var_4))
        var_4 skydive_cutparachuteon(var_1, 0, var_2);
    }
  }
}

stop_with_front_truck(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);
  var_6 = level.players.size == var_5.size;

  if(var_6)
    setglobalsoundcontext("_encstr_93FD0BEA50EDBEC7F624716C4D", "_encstr_B40101", 2);

  foreach(var_8 in var_5) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(!var_6)
      var_8 setentitysoundcontext("_encstr_93FD0BEA50EDBEC7F624716C4D", "_encstr_B40101", 2);

    if(!isDefined(var_4))
      var_4 = "_encstr_B40101";

    switch (var_4) {
      case "_encstr_9707036E19":
        var_8 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
        var_8 clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
        break;
      case "_encstr_932910EB56AF78195762F0DBF9C34778C3E1":
        var_8 playlocalsound("_encstr_853412409B0F6095226401803A0AF58BC997B858");
        var_8 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
        var_8 clearsoundsubmix("_encstr_95C51F5E87B9A7F9C158E93268C32E47367FACDC30219BBE9BB863F998336207E9", 0.5);
        var_8 setsoundsubmix("_encstr_857D18D7E08E0A4BCFC5E3DFB87151D450781B2E01204E529B69", 0.5);
        break;
      case "_encstr_96BA0EA9427F8738EFC21773F617C841":
        var_8 playlocalsound("_encstr_8B6E1728CE0F5BB34C9AD99AF5F6D301EE11599BC1131751EB");
        var_8 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
        var_8 clearsoundsubmix("_encstr_95C51F5E87B9A7F9C158E93268C32E47367FACDC30219BBE9BB863F998336207E9", 0.5);
        var_8 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
        break;
      case "_encstr_83120C635BBBCBA07E8C382AAB51":
        var_8 playlocalsound("_encstr_8D9D1C899CF5A5B9CCB4C6BE8D0D997D83D8B0CDCABED2371D9CDEF5D893");
        var_8 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
        var_8 clearsoundsubmix("_encstr_95C51F5E87B9A7F9C158E93268C32E47367FACDC30219BBE9BB863F998336207E9", 0.5);
        var_8 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
        break;
      case "_encstr_A32E10CFD74B3A9709C07D47F8A89F629B79":
        var_8 playlocalsound("_encstr_B6F2208A9A57B7CD50309929C9602BF9A7BBE0A787125F454A37512073DBB048D87A");
        var_8 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
        var_8 clearsoundsubmix("_encstr_95C51F5E87B9A7F9C158E93268C32E47367FACDC30219BBE9BB863F998336207E9", 0.5);
        var_8 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
        break;
      case "_encstr_A9B50F3A9527B5969BEACDFAD2CDCCB4C6":
        var_8 playlocalsound("_encstr_8E2C1F2A98B75CBB31439CB76ED806695932618310A3D5AFCEBB9694FE40EF6DBD");
        var_8 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
        var_8 clearsoundsubmix("_encstr_95C51F5E87B9A7F9C158E93268C32E47367FACDC30219BBE9BB863F998336207E9", 0.5);
        var_8 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
        break;
      default:
        var_8 playlocalsound("_encstr_853412409B0F6095226401803A0AF58BC997B858");
        var_8 clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
        var_8 clearsoundsubmix("_encstr_95C51F5E87B9A7F9C158E93268C32E47367FACDC30219BBE9BB863F998336207E9", 0.5);
        var_8 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
        break;
    }
  }

  var_2 = var_2 || istrue(level.vehicle_collision_getleveldata);

  if(var_6) {
    if(istrue(level.vehicle_collision_getleveldata) || var_2)
      playcinematicforall(var_1, 1, 1);
    else
      playcinematicforall(var_1);
  } else {
    foreach(var_8 in var_5) {
      if(!isDefined(var_8)) {
        continue;
      }
      if(istrue(level.vehicle_collision_getleveldata) || var_2) {
        var_8 preloadcinematicforplayer(var_1, 1, 1);
        continue;
      }

      var_8 preloadcinematicforplayer(var_1);
    }
  }

  var_12 = 3;

  if(getdvarint("_encstr_8538150F67CB40E08A29692BDA10D183A28385AFFFA3BE", 0) == 1)
    var_12 = 9;
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    var_12 = 11;
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    if(getdvarint("_encstr_8E522BB30EF3C72E5551327AA05B650F0BE2215490FED73213399B2230B99D5720D8B6D9B986F7BBCB48729AA8", 1) == 0)
      var_12 = 11;
    else
      var_12 = 13;
  } else if(istrue(var_3))
    var_12 = 10;

  foreach(var_8 in var_5) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(!istrue(var_8.watch_for_usb_notetrack_switchoff))
      var_8 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", var_12);
  }
}

getboltmodel(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", var_1);
  }
}

stop_spawn_modules(var_0, var_1) {
  if(var_0 == "_encstr_84300E8EA97BA8771622B0602AAFE9A1") {
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 5);
    self skydive_cutparachuteoff();
  }
}

stop_vehicle_on_pilot_death(var_0, var_1) {
  if(var_0 == "_encstr_84300E8EA97BA8771622B0602AAFE9A1") {
    wait 0.6;
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
    self skydive_cutparachuteoff();
  }
}

stop_wave_section(var_0, var_1) {
  if(var_0 == "_encstr_84300E8EA97BA8771622B0602AAFE9A1") {
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
    self skydive_cutparachuteoff();
  }
}

stopchallengetimer(var_0) {
  if(getdvarint("_encstr_8538150F67CB40E08A29692BDA10D183A28385AFFFA3BE", 0) == 1)
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::stop_spawn_modules);
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::stop_vehicle_on_pilot_death);
  else
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::stop_wave_section);

  var_1 = undefined;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    var_1 = 4.95;
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    var_1 = 7.23;
  else
    var_1 = 3.2;

  if(istrue(level.vehicle_collision_getleveldata))
    var_1 = 4.6;
  else if(getdvarint("_encstr_8538150F67CB40E08A29692BDA10D183A28385AFFFA3BE", 0) == 1)
    var_1 = 36.0;

  wait(var_1);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, level.players);

  if(isDefined(level._id_133B4))
    level._id_133B4 = undefined;

  foreach(var_4 in var_2) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 notify("_encstr_BEBC0A21371738404846EFF1");
  }

  if(isDefined(level.throwingknives)) {
    foreach(var_7 in level.throwingknives) {
      if(isDefined(var_7))
        var_7 thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_deletepickup();
    }
  }
}

setup_jugg_maze_kill_trigger() {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
    self setModel("_encstr_BD0525AE65D8321913887A41A0730AF7D0DB0E348B01FAD12F58924A69BD06CF48A881A694A8D3");
    self notsolid();
    self.innards setModel("_encstr_8394276ED358105F912DF2C969FB93B11853FEC463C8D8974BD86B1213C32F32310565779B181717E1");
    self.innards notsolid();
    self.playeroffsets = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    self setModel("_encstr_B254209D591A0EEBB5B48DAF585A27F56EB65A1BDED7D2CD99A5B1D799B14BEC0D3A");
    self notsolid();
    self.innards setModel("_encstr_8D1D25CE95A10EAFB6A5D8FAC25A4EAF9B6DB463BDFAA5B98E56C95AB7E4EBCEADD7A57366B48D");
    self.innards notsolid();
    self.playeroffsets = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
    self.bunker_numberstation = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    self.bunker_numberstation setModel("_encstr_B1E52C9DB2A11CF5AD2D1BBE0B96E4D7B95B5A1BEDEB4BE6CC5AC6F566B1A5D90D3AEB58E41D5AD8AB3616A3B219");
    self.bunker_numberstation linkTo(self, "_encstr_B40101", (0, 0, 0), (0, 0, 0));
    self.bunker_numberstation.cleanme = 1;
    self.door = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    self.door setModel("_encstr_A7F32D3B6D4021A7358723D1C62F034FD0F8E491900F6A6054659293A0607F40604199F58F33E29E2055F999DDEA73");
    self.door linkTo(self.bunker_numberstation, "_encstr_83E8092987F028A9DF45D7", (0, 0, 0), (0, 0, 0));
    self.door.cleanme = 1;
  } else {
    self notsolid();

    if(isDefined(self.innards))
      self.innards notsolid();
  }
}

setup_last_enemies_standing(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self hide();

  if(isDefined(self.innards))
    self.innards hide();

  self waittill("_encstr_A2810D5F30B9EADB1F11752B0B15A2");
  self show();

  if(isDefined(self.innards))
    self.innards show();

  self moveTo(var_0, var_1);
  thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::killaftertime(var_1, "_encstr_969105B1C4CC81");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    self playLoopSound("_encstr_916816C439F51A59362DBE5AE6335A8DD786ACE4F6FA1BC1");
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    self playLoopSound("_encstr_97E10C4C93D7C21B4C6660F5D807");
  else {
    thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::gunship_spawnvfx();
    self playLoopSound("_encstr_97E10C4C93D7C21B4C6660F5D807");
  }
}

remove_outline(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    return var_0.chopper;
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    return var_0._id_13886;
  else
    return var_0.staticc130;
}

remove_objective_on_flag(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    return var_0._id_11DBF;
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    return var_0._id_11DC3;
  else
    return var_0.movingc130;
}

remove_munitions_in_radius(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played())
    return var_0.gas_triggers_init;
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
    return var_0.gas_triggers_init;
  else
    return var_0.gas_trigger;
}

clear_tier_lights(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, level.players);

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_5 calloutmarkerping_getcreatedtime(-1.0);
    }
  }

  level.infilstruct = spawnStruct();
  level.infilstruct.playersinc130 = 0;

  if(!isDefined(var_0))
    var_0 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path();

  level.infilstruct.c130pathstruct = var_0;
  level.infilstruct.transporttime = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::spawnc130(level.infilstruct.c130pathstruct, ::setup_last_enemies_standing, ::setup_jugg_maze_kill_trigger);
  level.infilstruct.firstc130endtime = level.infilstruct.transporttime + gettime();
  var_7 = firespoutwatch(level.br_ac130, var_1);
  level.watch_for_total_counts_below_num = var_7;

  if(isDefined(level._id_12852))
    [[level._id_12852]](var_7);

  level.stop_end_breach_fx = 1;
  level.allowprematchdamage = 0;
  level.br_ac130 thread gunship_updateplayercount();
  var_8 = remove_outline(var_7);
  var_9 = 0;
  var_10 = 0;

  if(getdvarint("_encstr_8538150F67CB40E08A29692BDA10D183A28385AFFFA3BE", 0) == 1) {
    var_10 = 1;
    _id_13CF0(var_3, "_encstr_8BB007E03658CBCAE4", var_8, 1);
    stoparmorinsert(var_3, "_encstr_9B4619073AC15CA72D420DB3F88F38994BEA47E190F855AF874617");
    stop_with_front_truck(var_3, "_encstr_9B4619073AC15CA72D420DB3F88F38994BEA47E190F855AF874617", var_9, 0, "_encstr_9707036E19");
    stopchallengetimer(var_3);
    var_11 = game["_encstr_813F06832D8A18FE"]["_encstr_82A30F380BF9E3F8A32971E031DBE39D5D"].size;
    var_12 = randomint(var_11);
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, level.players);

    foreach(var_5 in var_3) {
      var_5 setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);
      var_5 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_82A30F380BF9E3F8A32971E031DBE39D5D"][var_12]);
    }
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8F94079C2BB3B2C21B") {
    _id_13CF0(var_3, var_1, var_8, 0);
    var_15 = undefined;
    var_16 = 0;

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
      var_15 = "_encstr_8274194F781664F2D5BD0BC2928FEA219840D707524ED12A09CED5";
      var_16 = 1;
    } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
      var_15 = "_encstr_AB5019AD1CFADDD3BED237C658B919BE0ED885B92BBE2DE63A27BD";
    else
      var_15 = "_encstr_AD7716B912F9C1E86E6F50704F87A1A387AA3833ED23B5D0";

    stoparmorinsert(var_3, var_15);
    stop_with_front_truck(var_3, var_15, var_9, var_16, "_encstr_932910EB56AF78195762F0DBF9C34778C3E1");
    stopchallengetimer(var_3);
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9286085A21B8034D3863") {
    _id_13CF0(var_3, var_1, var_8, 0);
    var_15 = "_encstr_B4E914F07265CC8D3BD96F2BC5F8ABF5117FB8CB90DF";
    var_16 = 0;
    var_17 = "_encstr_A32E10CFD74B3A9709C07D47F8A89F629B79";
    var_9 = 1;
    stoparmorinsert(var_3, var_15);
    stop_with_front_truck(var_3, var_15, var_9, var_16, var_17);
    stopchallengetimer(var_3);
  } else if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_AAEF05B85A86E9") {
    _id_13CF0(var_3, var_1, var_8, 0);
    var_15 = "_encstr_AC8F17DBE35FF41B19901C13E2093890AFBE6FC71A488D9538";
    var_16 = 0;
    var_17 = "_encstr_83120C635BBBCBA07E8C382AAB51";
    var_9 = 0;

    if(getdvarint("_encstr_BE951C5B01560F6B5065E5F9450872C77318826288B897A3788DF2F179E0", 0) == 1)
      _encstr_8EDC17EF52BD6FA94F7B71281B7A1D93608C5F605F7897DBD4(var_3);

    stoparmorinsert(var_3, var_15);
    stop_with_front_truck(var_3, var_15, var_9, var_16, "_encstr_A9B50F3A9527B5969BEACDFAD2CDCCB4C6");
    stopchallengetimer(var_3);
  } else {
    _id_13CF0(var_3, var_1, var_8, 0);
    var_15 = undefined;
    var_16 = 0;
    var_17 = undefined;

    if(getdvarint("_encstr_BE951C5B01560F6B5065E5F9450872C77318826288B897A3788DF2F179E0", 0) == 1)
      _encstr_8EDC17EF52BD6FA94F7B71281B7A1D93608C5F605F7897DBD4(var_3);

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tv_station_intro_already_played()) {
      if(scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent())
        var_15 = "_encstr_972B18B607AF959BC6C283B2D7AD4BCD91B48507D74B9B47E4B7";
      else
        var_15 = "_encstr_8274194F781664F2D5BD0BC2928FEA219840D707524ED12A09CED5";

      var_16 = 1;
      var_17 = "_encstr_96BA0EA9427F8738EFC21773F617C841";
    } else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg()) {
      var_15 = "_encstr_AB5019AD1CFADDD3BED237C658B919BE0ED885B92BBE2DE63A27BD";
      var_17 = "_encstr_83120C635BBBCBA07E8C382AAB51";
    } else
      var_15 = "_encstr_AD7716B912F9C1E86E6F50704F87A1A387AA3833ED23B5D0";

    var_15 = _encstr_81F112FF632BEE0F18971DD1C5457275AEB24050(var_15);
    stoparmorinsert(var_3, var_15);
    stop_with_front_truck(var_3, var_15, var_9, var_16, var_17);
    stopchallengetimer(var_3);
  }

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound() || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootcallbacks()) {
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, level.players);

    foreach(var_5 in var_3) {
      if(isDefined(var_5) && isPlayer(var_5))
        var_5 notify("_encstr_B1270B8FD43F927F9C2A704812");
    }
  }

  if(var_10)
    getboltmodel(var_3, 0);

  [var_21, var_22] = remove_munition_on_use();
  level thread infilallfadetoblack(0.0, var_21, var_22, undefined, var_2);

  if(getdvarint("_encstr_BE951C5B01560F6B5065E5F9450872C77318826288B897A3788DF2F179E0", 0) == 1)
    level thread _encstr_BDB31796DC664B63CD598EABE08EAC27DA9673D537C42DDCDA(var_3, var_22);

  _id_1273C(var_7, var_2);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, level.players);
  _id_13CEE(var_3, var_1);
  level.stop_end_breach_fx = 0;
  level.infilstruct.infil_anim_type = var_1;

  if(isDefined(level.obit_activation))
    level thread _encstr_81032C6ED8E4B41CA3CDCBAD0E979DB05B561D971C95375E98C9BE2C3647FA6BDEC8B2AF56E68D0B38955C76B9C6::obj_fob2(var_2);
  else {
    thread _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8F3D13CD2304CAAA680143B51793A9A5EFED1F937D", var_2);

    if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A1B50F226F23E2F0A1FB78932245C75325"))
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_827F0CA01ADBB640298B192B92CB", 0, var_2);
  }

  var_23 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::validtousesticker() || _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid();

  if(!var_23) {
    var_24 = getDvar("_encstr_AFFC196283C8DEFD72962B06031821C8820B386029B9A1C6280FB8") == "_encstr_B40101";
    var_3 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, level.players);

    foreach(var_5 in var_3) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(!istrue(var_5.delay_explosion_fx) && var_24) {
        continue;
      }
      var_5 thread playerjoininfil();

      if(var_5 calloutmarkerping_getEnt())
        _id_12B22(var_5);
    }

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_B1130F58C89145BD6813990CA473335A36"))
      level.br_ac130 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_B1130F58C89145BD6813990CA473335A36");
  }

  if(isDefined(level.showexfilstartsplash))
    level thread showextractionobjectivetoteam();
}

_encstr_81F112FF632BEE0F18971DD1C5457275AEB24050(var_0) {
  if(istrue(level.vehicle_collision_getleveldata))
    var_0 = "_encstr_B446195322C7E10F8D1D71538719E69AD30A800302F3E6475F6B69";
  else if(scripts\cp_mp\utility\game_utility::turretlightsonstate())
    var_0 = "_encstr_BA580B3A85D7EC7BCED7A5E666";
  else if(level.mapname == "_encstr_AFFF0BE590A158DFF3D1238507" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A519044B436F")
    var_0 = "_encstr_8CD41ACA98A70FAFC0B5748B5A0E5782A7325102F099C2F7DE227080";
  else if(level.mapname == "_encstr_A3F50BC8631F6D20CD64F7A155")
    var_0 = "_encstr_BA580B3A85D7EC7BCED7A5E666";

  return var_0;
}

_id_1324E(var_0) {
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("_encstr_83AB065EE1391A7B", 640, 480);
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.sort = -1;
  var_0 sendcollectedclientanticheatdata(1);
}

infilallfadetoblack(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);
  var_7 = level.players.size == var_6.size;

  if(var_7 && !isDefined(level.infilblackoverlay)) {
    level.infilblackoverlay = newhudelem();
    _id_1324E(level.infilblackoverlay);
  } else if(!var_7) {
    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9.infilblackoverlay = newclienthudelem(var_9);
      _id_1324E(var_9.infilblackoverlay);
    }
  }

  if(isDefined(var_0) && var_0 > 0) {
    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }
      if(!var_5) {
        var_9 setsoundsubmix("_encstr_A2AB152D771CBE4C9CEB5AB9332D36AF6685C82BF6EA1D", 0.0);

        if(!istrue(level.vehicle_collision_getleveldata) && !isDefined(level._id_12D05))
          var_9 setsoundsubmix("_encstr_911712B50EEB26E47DA5B9995A8DEBD6BADC9636", 0.0);
      }

      if(!var_7) {
        var_9.infilblackoverlay.alpha = 0;
        var_9.infilblackoverlay fadeovertime(var_0);
        var_9.infilblackoverlay.alpha = 1;
      }
    }

    if(var_7) {
      level.infilblackoverlay.alpha = 0;
      level.infilblackoverlay fadeovertime(var_2);
      level.infilblackoverlay.alpha = 1;
    }

    wait(var_0);
  }

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection()) {
    if(var_7)
      level.infilblackoverlay.alpha = 1;

    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }
      if(!var_5) {
        var_9 setsoundsubmix("_encstr_83DB1103A801C0F6B75270793A133880E519BB", 0.0);
        var_9 setsoundsubmix("_encstr_870F12B507D73139AF96E6992D8DEB85C6629906", 0.0);
      }

      if(!var_7)
        var_9.infilblackoverlay.alpha = 1;
    }
  }

  if(isDefined(var_3))
    level waittill(var_3);

  if(isDefined(var_1) && var_1 > 0)
    wait(var_1);

  if(isDefined(var_2) && var_2 > 0) {
    if(var_7) {
      level.infilblackoverlay.alpha = 1;
      level.infilblackoverlay fadeovertime(var_2);
      level.infilblackoverlay.alpha = 0;
    }

    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }
      if(!var_5) {
        if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection()) {
          if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::usefailcapacitymsg())
            var_9 setclienttriggeraudiozone("_encstr_9A40140F591822C3C889058F66C8160AEB893F97FD35", var_2);
          else
            var_9 setclienttriggeraudiozone("_encstr_9950154513E17CE238C3D33727484ABEF098BD41A87314", var_2);
        }

        var_9 clearsoundsubmix("_encstr_A2AB152D771CBE4C9CEB5AB9332D36AF6685C82BF6EA1D", 2);
        var_9 clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
      }

      if(!var_7) {
        var_9.infilblackoverlay.alpha = 1;
        var_9.infilblackoverlay fadeovertime(var_2);
        var_9.infilblackoverlay.alpha = 0;
      }
    }

    wait(var_2);
  } else if(!var_5) {
    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }
      if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isusinginfilselection())
        var_9 setclienttriggeraudiozone("_encstr_9950154513E17CE238C3D33727484ABEF098BD41A87314");

      var_9 clearsoundsubmix("_encstr_A2AB152D771CBE4C9CEB5AB9332D36AF6685C82BF6EA1D", 2);
      var_9 clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
    }
  }

  if(var_7)
    level.infilblackoverlay.alpha = 0;
  else {
    var_6 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, level.players);

    foreach(var_9 in var_6) {
      if(!isDefined(var_9)) {
        continue;
      }
      if(isDefined(var_9.infilblackoverlay))
        var_9.infilblackoverlay destroy();

      var_9.infilblackoverlay = undefined;
    }
  }
}

_id_12ACC(var_0) {
  var_1 = 0;
  var_2 = isDefined(var_0) && var_0.size != level.players.size;

  foreach(var_4 in level.teamnamelist) {
    var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemies_fallback_logic(var_4);

    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      var_7 = var_5[var_6];
      var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_4, var_7);

      foreach(var_14, var_10 in var_8) {
        if(var_2 && !scripts\engine\utility::array_contains(var_0, var_10)) {
          continue;
        }
        var_10 playerhide();

        if(!var_1) {
          foreach(var_12 in var_8)
          var_10 showtoplayer(var_12);
        }
      }
    }
  }
}

_id_13CF0(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    scripts\mp\utility\game::_id_131A3(var_5, 1);
    var_5 scripts\mp\utility\player::hidehudenable();
    var_5 scripts\mp\class::computerrebootsequence_init();
  }

  scripts\mp\deathicons::_id_12BFD();
  setomnvar("_encstr_A3891553A45F40B34A87A7C19B2283602AB158E94DC620", 1);
  thread infilallfadetoblack(1, 3.5, 1, "_encstr_A7C81A7B7A6B714F911B59BECE9F521357780D197349154327DB40A9", var_0, var_3);

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 predictstreampos(var_2.origin, 1);
  }

  level.stop_visited_once = 1;
  _id_14361(1);
  waitframe();
  _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::emptyallvehicles();
  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", 1);
  scripts\mp\flags::gameflagset("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 playerhide();
  }

  _id_1435F(var_0, var_2.origin, var_2);
  level notify("_encstr_A7C81A7B7A6B714F911B59BECE9F521357780D197349154327DB40A9");
  _id_14361(3.5);

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }
    var_5 clearpredictedstreampos();
    var_5 neurotoxin_damage_loop();
    var_5.delay_explosion_fx = 1;
  }

  if(var_1 == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0") {
    foreach(var_5 in var_0) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_5 playerhide();
    }
  } else
    _id_12ACC(var_0);
}

_id_13CEE(var_0, var_1) {
  var_2 = var_1 == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0";

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 scripts\mp\class::_id_13F02();
    var_4.instantclassswapallowed = 1;

    if(_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_4.hidehudenabled) > 0)
      var_4 scripts\mp\utility\player::hidehuddisable();

    var_4 visionsetfadetoblackforplayer("_encstr_B40101", 1.0);

    if(var_2)
      var_4 playershow();
  }

  setomnvar("_encstr_91D80CAEA5FAA537D72DCD334B8D", -1);
  level.stop_visited_once = undefined;
}

gunship_updateplayercount() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_854613C1672A6A6AAFBB7AD2E2652B39E0D76D46D1");
  self endon("_encstr_854613C1672A6A6AAFBB7AD2E2652B39E0D76D46D1");

  for(;;) {
    setomnvar("_encstr_A6D91C4B30B0ABBAD1D15421BB78C2A7D808C2C23B687F75F9F95C29BD50", level.infilstruct.playersinc130);

    if(!isDefined(self)) {
      break;
    }

    wait 0.5;
  }
}

playerjoininfil() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8F9C0E528823754F286C8799F07117BD");
  var_0 = self;
  var_0.br_infilstarted = 1;
  var_0.health = var_0.maxhealth;
  var_0 _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::spawnplayertoc130();
  var_0 playersetupcontrolsforinfil();
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_AB2A0F28DA4178ABF283F3F173FAF72005", 1);
  level.infilstruct.playersinc130++;
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1264D();
  var_0 thread _id_12525();
}

_id_12525() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8F860C1B58DCB1B28DEB6C4C6603");
  self endon("_encstr_8F7D08C66A0125438523");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.infilstruct) && isDefined(level.infilstruct.playersinc130) && level.infilstruct.playersinc130 > 0)
    level.infilstruct.playersinc130--;
}

playersetupcontrolsforinfil(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  self setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
  self setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 0);

  if(!var_0)
    self notifyonplayercommand("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_B44609DFE707CF394E1651");
  else
    self notifyonplayercommand("_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C", "_encstr_B44609DFE707CF394E1651");

  self notifyonplayercommand("_encstr_9976159972471B737FD2196F7F10F9F020724249856DA2", "_encstr_97410B23BD6B976233901AF2F8");
  self notifyonplayercommand("_encstr_9976159972471B737FD2196F7F10F9F020724249856DA2", "_encstr_B4C60AD707B2BDC0E6CE1309");
}

getlightingvalues() {}

within_points() {}

wires_on_bombs() {}

initinfillocationselectionhandlers() {
  registerinfillocationselectionhandler("_encstr_A3D70A2BF01B365D6EA5DB37", ::handleexclusionils, ::spawnselectionbegin, ::spawnselectionend);
}

handleinfillocationselection(var_0) {
  var_1 = self;
  var_2 = level.infilselectionmethod;
  var_3 = getinfillocationselectionfunc(var_2);

  if(!isDefined(var_3)) {
    return;
  }
  return var_1[[var_3]](var_0.location, var_0.angles);
}

registerinfillocationselectionhandler(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.br_infillocationselectionhandlers))
    level.br_infillocationselectionhandlers = [];

  var_4 = spawnStruct();
  var_4.locationselectionfunc = var_1;
  var_4.spawnselectstartfunc = var_2;
  var_4.spawnselectendfunc = var_3;
  level.br_infillocationselectionhandlers[var_0] = var_4;
}

getinfillocationselectionfunc(var_0) {
  if(!isDefined(level.br_infillocationselectionhandlers))
    return undefined;

  var_1 = level.br_infillocationselectionhandlers[var_0];

  if(!isDefined(var_1))
    return undefined;

  return var_1.locationselectionfunc;
}

handleexclusionils(var_0, var_1) {
  var_2 = self;

  if(!istrue(level.get_bomb_interaction_ent_cut_hint) && !istrue(var_2.issquadleader))
    return 0;

  [var_4, var_5] = getspawnselectionpoi(var_0);
  var_6 = getspawnselectionexclusionsize(var_0, var_4, var_5);

  if(isDefined(var_2.team)) {
    var_7 = scripts\mp\utility\player::getteamarray(var_2.team);
    var_6 = var_6 * var_7.size;
  }

  if(istrue(level.get_bomb_interaction_ent_cut_hint) && !istrue(var_2.issquadleader))
    return var_2 setuplocalelocation(var_0, var_1, var_6);

  foreach(var_9 in level.br_spawns) {
    var_10 = var_2 round_logic();

    if(isDefined(var_10) && var_9 == var_10) {
      if(level.get_bomb_interaction_ent_cut_hint) {
        if(var_2 getquickdropplundercount(var_9, var_6, var_0, 1))
          return 1;
      }

      continue;
    } else if(level.get_bomb_interaction_ent_cut_hint) {
      if(!var_2 getquickdropplundercount(var_9, var_6, var_0, 0))
        return 0;
    }

    if(pow(var_6 + var_9.spawnexclusion2ddist, 2) > distance2dsquared(var_9.locationorigin, var_0)) {
      var_2 thread sendplayerstatusmessage(50, 2.0);
      var_2 playlocalsound("_encstr_B67417662A27F0A37A99E85042D75F2B17AFF87095CB5BF7A2");
      return 0;
    }
  }

  return var_2 registerspawnlocation(var_0, var_1, var_6);
}

setuplocalelocation(var_0, var_1, var_2) {
  var_3 = self;

  foreach(var_5 in level.br_spawns) {
    var_6 = round_logic();
    var_7 = 0;

    if(isDefined(var_6) && var_5 == var_6)
      var_7 = 1;

    if(pow(var_2 + var_5.spawnexclusion2ddist, 2) > distance2dsquared(var_5.locationorigin, var_0)) {
      if(var_7) {
        var_8 = var_3 roof_spawners();
        lastlocationcallouttime(var_8);
        var_3 thread sendplayerstatusmessage(56, 2.0);
        var_3 playlocalsound("_encstr_ACE6185EF3160A988FC1D0D904CF12E1C9DFB3F741FDB0419A61");
        return 1;
      }

      var_3 thread sendplayerstatusmessage(50, 2.0);
      var_3 playlocalsound("_encstr_B67417662A27F0A37A99E85042D75F2B17AFF87095CB5BF7A2");
      return 0;
    }

    if(var_7 && var_3 getquickdropplundercount(var_5, var_2, var_0, var_7))
      return 1;
  }

  return var_3 registerspawnlocation(var_0, var_1, var_2);
}

getquickdropplundercount(var_0, var_1, var_2, var_3) {
  var_4 = self;

  foreach(var_6 in var_0._id_134CC) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_7 = var_4 roof_spawners();

    if(isDefined(var_7) && var_6 == var_7) {
      continue;
    }
    if(pow(var_1 + var_6.spawnexclusion2ddist, 2) > distance2dsquared(var_6.locationorigin, var_2)) {
      if(!var_3) {
        var_4 thread sendplayerstatusmessage(50, 2.0);
        var_4 playlocalsound("_encstr_B67417662A27F0A37A99E85042D75F2B17AFF87095CB5BF7A2");
        return 0;
      }

      var_2 = var_6.locationorigin;
      var_8 = var_6.locationangles;
      var_1 = var_6.spawnexclusion2ddist;

      if(isDefined(var_7) && isDefined(var_7.circleent))
        var_7.circleent delete();

      var_9 = var_4 registerspawnlocation(var_2, var_8, var_1);

      if(!var_9)
        return var_9;

      if(!istrue(var_4.issquadleader))
        var_4 thread sendplayerstatusmessage(55, 2.0);
      else
        var_4 thread sendplayerstatusmessage(54, 2.0);

      return var_9;
    }
  }

  if(!var_3)
    return 1;

  return 0;
}

sendplayerstatusmessage(var_0, var_1) {
  var_2 = self;
  var_2 notify("_encstr_8FA2185727528539AC9EE27942BB504F4BCFCFA3DF6BD688FFF7");
  var_2 endon("_encstr_8FA2185727528539AC9EE27942BB504F4BCFCFA3DF6BD688FFF7");
  var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(var_0);

  if(isDefined(var_1)) {
    wait(var_1);
    var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  }
}

registerspawnlocation(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = scripts\engine\trace::create_default_contents(1);

  if(istrue(var_3.issquadleader)) {
    var_5 = var_3 round_logic();

    if(!isDefined(var_5))
      var_5 = var_3 totalhealth();
  } else if(istrue(level.get_bomb_interaction_ent_cut_hint)) {
    var_5 = var_3 roof_spawners();

    if(!isDefined(var_5))
      var_5 = var_3 total_spawns();
  } else
    return 0;

  var_6 = getdvarfloat("_encstr_8B961CDC369CD75A9BCC968DFA0EC6BAB9D7CDC10B77737D34595AEC1A8E", 5500.0);
  var_7 = (0, 0, var_6);
  var_8 = (0, 0, 10000);
  var_9 = var_0 + var_8;
  var_10 = var_0 - var_8;
  var_11 = scripts\engine\trace::ray_trace(var_9, var_10, undefined, var_4);
  var_12 = var_0;

  if(var_11["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_12 = var_11["_encstr_BD260953AA97E3F014279D"];

  var_5.locationorigin = var_12 + var_7;

  if(istrue(var_3.issquadleader))
    var_5.groundorigin = var_12;

  var_5.locationangles = var_1;
  var_5.spawnexclusion2ddist = var_2;
  [var_14, var_15, var_16] = var_5.locationorigin;

  if(isDefined(var_5.circleent))
    var_5.circleent.origin = (var_14, var_15, var_2);
  else {
    var_5.circleent = getmaxobjectivecount(var_14, var_15, var_2, var_3);

    if(istrue(var_3.issquadleader))
      var_5.circleent setmapcircleiconindex(1);
  }

  var_17 = scripts\mp\utility\teams::getfriendlyplayers(var_3.team, 0);

  foreach(var_19 in var_17) {
    if(!istrue(var_3.issquadleader)) {
      var_19 thread sendplayerstatusmessage(64, 2.0);
      var_19 playlocalsound("_encstr_ACE6185EF3160A988FC1D0D904CF12E1C9DFB3F741FDB0419A61");
      continue;
    }

    var_19 thread sendplayerstatusmessage(57, 2.0);
    var_19 playlocalsound("_encstr_ACE6185EF3160A988FC1D0D904CF12E1C9DFB3F741FDB0419A61");
  }

  return 1;
}

assignrandomspawnselection() {
  var_0 = self;

  if(!isDefined(var_0.issquadleader)) {
    var_0.issquadleader = 1;
    var_1 = scripts\mp\utility\teams::getfriendlyplayers(var_0.team, 0);

    foreach(var_3 in var_1) {
      if(var_3 != var_0)
        var_3.issquadleader = 0;
    }
  }

  var_5 = (0, 0, 0);

  for(var_6 = 0; var_6 < 3; var_6++) {
    var_7 = randomfloatrange(level.mapsafecorners[1][0], level.mapsafecorners[0][0]);
    var_8 = randomfloatrange(level.mapsafecorners[1][1], level.mapsafecorners[0][1]);
    var_5 = (var_7, var_8, 0);
    var_9 = var_0 handleexclusionils(var_5);

    if(var_9)
      return 1;
  }

  var_0 registerspawnlocation(var_5, undefined, getdvarint("_encstr_A3FB1C9F3BE2AF38D9CA181B277B4AF1A3C17B1B6F704FE0E658AF37D380", 2000));
  return 0;
}

notifyafkofselection(var_0) {
  var_1 = self;
  var_2 = scripts\mp\utility\teams::getfriendlyplayers(var_1.team, 0);
  var_3 = "_encstr_B40101";

  if(var_0)
    var_3 = "_encstr_A2071E1ED923118112CBD86002E65FA9A3459E0539DFB8C9CE8350A88A8DFBC1";
  else
    var_3 = "_encstr_AD062009D8AB70EE7F99C173B9FBF88839DD1C855F239CC82D31D53328D37422C574";

  foreach(var_5 in var_2)
  var_5 iprintlnbold(var_3);
}

_id_13AEC() {
  var_0 = self;
  var_0 playershow(1);
  var_0 unlink(1);
  var_1 = var_0 round_logic();

  if(isDefined(var_1.locationorigin)) {
    var_2 = var_1.locationorigin;
    var_3 = var_0 roof_spawners();

    if(isDefined(var_3))
      var_2 = var_3.locationorigin;

    var_4 = 512;
    var_5 = (0, 60 * var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"] % 360, 0);
    var_6 = anglesToForward(var_5) * var_4;
    var_2 = var_2 + var_6 + (0, 0, randomfloatrange(0, 512));

    if(getdvarint("_encstr_92651AD872DAF7019B076CD71CCBC953461AF0B8BAB4D97BEB21EC58", 0)) {
      var_0.forcespawnorigin = var_2;
      var_0.forcespawnangles = undefined;
      var_0.alreadyaddedtoalivecount = 1;
      var_0 scripts\mp\playerlogic::spawnplayer(0, 0);
    } else {
      var_0 setOrigin(var_2, 1);
      var_0 setplayerangles(var_5);
    }
  }

  var_0 stopanimscriptsceneevent();
  var_0 clearpredictedstreampos();
  var_0 playershow(1);
  var_0.br_infilstarted = 1;
  var_0 setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
  var_0 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
  var_0 scripts\cp_mp\parachute::startfreefall(0, 0);
  var_0 _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(var_0);
}

postspawnselectionstream() {
  var_0 = self;
  var_1 = var_0 roof_spawners();
  var_2 = var_0 round_logic();

  if(isDefined(var_1))
    var_0 predictstreampos(var_1.locationorigin, 1);
  else if(isDefined(var_2))
    var_0 predictstreampos(var_2.locationorigin, 1);
}

spawnselectionbegin() {
  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_8CE412C1C9CA0E589356AF33B793F52D9B992D63");
  scripts\mp\gamelogic::matchstarttimerperplayer_internal(10);
  scripts\mp\flags::gameflaginit("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082", 0);
  level notify("_encstr_B8BF1A716AA78340F941FDD5791D015967D32EDBF223CD704B29F7CD");

  if(!isDefined(level.br_spawns))
    level.br_spawns = [];

  foreach(var_1 in level.players) {
    var_1 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::playerselectspawnsequence();
    var_1.isselectingspawn = 1;
  }

  wait 2.0;
}

spawnselectionend() {
  scripts\mp\flags::gameflagset("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082");
  var_0 = getdvarint("_encstr_A51D136FF26E7F6BADC61917E7D43BCFAD3D30A930", 0);

  foreach(var_2 in level.players) {
    var_2 notify("_encstr_91A21017B155D07573493840921FB5C8AD06");
    var_2 thread sendplayerstatusmessage(51, 2.0);
    var_3 = var_2 round_logic();

    if(!isDefined(var_3)) {
      if(var_0) {
        var_2.brmapselectionafk = 1;
        continue;
      } else {
        var_4 = var_2 assignrandomspawnselection();
        var_2 notifyafkofselection(var_4);
      }
    }

    var_2.brmapselectionafk = 0;
    var_2.isselectingspawn = 0;
    var_2 postspawnselectionstream();
  }

  thread _id_12C24();
  wait 4;

  foreach(var_2 in level.players) {
    var_2 thread sendplayerstatusmessage(0);
    var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A97810F553CDD025BAAB13DF566F519130B1", 0);
  }

  thread _id_14392();
}

_id_14392() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");
}

roof_spawners() {
  var_0 = self;

  if(!istrue(level.get_bomb_interaction_ent_cut_hint) || istrue(var_0.issquadleader))
    return undefined;

  var_1 = var_0 round_logic();

  if(isDefined(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]) && isDefined(var_1)) {
    if(isDefined(var_1._id_134CC[var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]]) && isDefined(var_1._id_134CC[var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]].locationorigin))
      return var_1._id_134CC[var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]];
  }

  return undefined;
}

round_logic() {
  var_0 = self;

  if(isDefined(level.br_spawns) && isDefined(var_0.team) && isDefined(level.br_spawns[var_0.team]) && isDefined(level.br_spawns[var_0.team].locationorigin))
    return level.br_spawns[var_0.team];

  return undefined;
}

total_spawns() {
  var_0 = self;

  if(!istrue(level.get_bomb_interaction_ent_cut_hint) || istrue(var_0.issquadleader))
    return undefined;

  var_1 = var_0 round_logic();

  if(isDefined(var_1) && isDefined(var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"])) {
    var_1._id_134CC[var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]] = spawnStruct();
    var_1._id_134CC[var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]].circleent = undefined;
    return var_1._id_134CC[var_0.pers["_encstr_A73E115F73359AECE9D12DF6C9C819A205E3FB"]];
  }

  return undefined;
}

totalhealth() {
  var_0 = self;

  if(!istrue(var_0.issquadleader))
    return undefined;

  if(isDefined(level.br_spawns) && isDefined(var_0.team)) {
    level.br_spawns[var_0.team] = spawnStruct();
    level.br_spawns[var_0.team].circleent = undefined;
    level.br_spawns[var_0.team]._id_134CC = [];
    return level.br_spawns[var_0.team];
  }

  return undefined;
}

lastlocationcallouttime(var_0) {
  if(isDefined(var_0.circleent))
    var_0.circleent delete();

  var_1 = undefined;
}

lastmovingplatform(var_0) {
  if(isDefined(var_0.circleent))
    var_0.circleent delete();

  var_0 = undefined;
}

classselectionbeginnonexclusion() {
  scripts\mp\flags::gameflaginit("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082", 0);

  foreach(var_1 in level.players)
  var_1 thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::playerstartselectspawnclassnonexclusion();
}

classselectionendnonexclusion() {
  scripts\mp\flags::gameflagset("_encstr_8EF114059E3857933F37A79D116375B46F0893CC3082");
}

_id_12C24() {
  wait 25;

  if(isDefined(level.br_spawns)) {
    foreach(var_1 in level.br_spawns) {
      if(isDefined(var_1._id_134CC)) {
        foreach(var_3 in var_1._id_134CC)
        lastlocationcallouttime(var_3);
      }

      lastmovingplatform(var_1);
    }
  }
}

getspawnselectionlockedtimer() {
  return 5;
}

spawnselectioninfil(var_0) {
  foreach(var_2 in level.players) {
    var_2.br_infilstarted = 1;
    var_2 setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
    var_2 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
  }

  var_4 = buildac130infilanimstruct(undefined, var_0);
  playac130infilanim(var_4);
}

initspawnexclusionpois() {
  setdvarifuninitialized("_encstr_B4B61DA00AA2FFE8CF20F8E60DC3D14F8B32C8B0213A1921EB4BFDC8ED3F78", 813);
  setdvarifuninitialized("_encstr_A2B61D6E6C937D5B16837D9BB2D82BB1D15A7BDCAF37E05893DC59FAB50B1E", 1000);
  setdvarifuninitialized("_encstr_95542036F35B7E43C6A35128EADD1BB13B91B02077F7E1BB2CCA88C8E3B7B788E70E", 625);
  setdvarifuninitialized("_encstr_AA5420D75E18D909E7AB1190BA01CA5EB9B317D8CF136015434845FD183A3120C39B", 813);
  setdvarifuninitialized("_encstr_A3FB1C9F3BE2AF38D9CA181B277B4AF1A3C17B1B6F704FE0E658AF37D380", 500);
  setdvarifuninitialized("_encstr_A9FB1C86E61B879851EBD98087645137A38C708071D24BA02BD7D1787F98", 625);
  setdvarifuninitialized("_encstr_BD57277358A5E98F19177753A580972E01903A5A5155DEC3D0F0567E50484FB02F50C203B033552729", 25000);
  setdvarifuninitialized("_encstr_8EF71E63396E270568892F0B4BE8CF2F95903A3A06CC973D588F0EE62780D053", "_encstr_95BD0B36ED73E896CDD5F6AE6E");
  level.br_spawnsparsepois = ["_encstr_A12309057F2275CBB14A51", "_encstr_837905862370BD", "_encstr_8E4107C6EA5B135939", "_encstr_971804ED3712", "_encstr_86430DCDB558D863A04B3983B7391D", "_encstr_B49507136BBF0EA070"];
  level.br_spawnsemidensepois = ["_encstr_8B410851CDC7EDE732ED", "_encstr_883E0978CAE2A1689B3161", "_encstr_810D059BE07D8B", "_encstr_A77808BB284B9F27D3C1", "_encstr_834E0AFD03697C39A427F282", "_encstr_85540C476130A3E140D973BDB320", "_encstr_9A810C7B7B7011F6E59BB57005B3"];
  level.br_spawndensepois = ["_encstr_9B220634456A5747", "_encstr_A1280E880A62E9081B7FAC285C8FD395", "_encstr_ACAA0ECF47604368FD3768DD73670775", "_encstr_BEC70C41B68350576ACBE9CFD363", "_encstr_8CFA0CD03AB2995DDFF2BF38EA73"];
  var_0 = getdvarint("_encstr_B4B61DA00AA2FFE8CF20F8E60DC3D14F8B32C8B0213A1921EB4BFDC8ED3F78");
  var_1 = getdvarint("_encstr_A2B61D6E6C937D5B16837D9BB2D82BB1D15A7BDCAF37E05893DC59FAB50B1E");

  foreach(var_3 in level.br_spawnsparsepois) {
    level.br_spawnpois[var_3] = spawnStruct();
    level.br_spawnpois[var_3].exclusionmin = var_0;
    level.br_spawnpois[var_3].exclusionmax = var_1;
  }

  var_5 = getdvarint("_encstr_95542036F35B7E43C6A35128EADD1BB13B91B02077F7E1BB2CCA88C8E3B7B788E70E");
  var_6 = getdvarint("_encstr_AA5420D75E18D909E7AB1190BA01CA5EB9B317D8CF136015434845FD183A3120C39B");

  foreach(var_3 in level.br_spawnsemidensepois) {
    level.br_spawnpois[var_3] = spawnStruct();
    level.br_spawnpois[var_3].exclusionmin = var_5;
    level.br_spawnpois[var_3].exclusionmax = var_6;
  }

  var_9 = getdvarint("_encstr_A3FB1C9F3BE2AF38D9CA181B277B4AF1A3C17B1B6F704FE0E658AF37D380");
  var_10 = getdvarint("_encstr_A9FB1C86E61B879851EBD98087645137A38C708071D24BA02BD7D1787F98");

  foreach(var_3 in level.br_spawndensepois) {
    level.br_spawnpois[var_3] = spawnStruct();
    level.br_spawnpois[var_3].exclusionmin = var_9;
    level.br_spawnpois[var_3].exclusionmax = var_10;
  }

  level.br_spawnpois["_encstr_8B410851CDC7EDE732ED"].pos = (-12420, -26792, 0);
  level.br_spawnpois["_encstr_A12309057F2275CBB14A51"].pos = (-26542, -21776, 0);
  level.br_spawnpois["_encstr_883E0978CAE2A1689B3161"].pos = (7827, -22240, 0);
  level.br_spawnpois["_encstr_810D059BE07D8B"].pos = (35008, -37117, 0);
  level.br_spawnpois["_encstr_837905862370BD"].pos = (48757, -25620, 0);
  level.br_spawnpois["_encstr_9B220634456A5747"].pos = (51019, -52257, 0);
  level.br_spawnpois["_encstr_8E4107C6EA5B135939"].pos = (51048, -8557, 0);
  level.br_spawnpois["_encstr_A77808BB284B9F27D3C1"].pos = (28873, -9839, 0);
  level.br_spawnpois["_encstr_834E0AFD03697C39A427F282"].pos = (14423, 4999, 0);
  level.br_spawnpois["_encstr_A1280E880A62E9081B7FAC285C8FD395"].pos = (20311, -18724, 0);
  level.br_spawnpois["_encstr_ACAA0ECF47604368FD3768DD73670775"].pos = (22076, -29372, 0);
  level.br_spawnpois["_encstr_85540C476130A3E140D973BDB320"].pos = (-24594, -3984, 0);
  level.br_spawnpois["_encstr_9A810C7B7B7011F6E59BB57005B3"].pos = (-12782, -3634, 0);
  level.br_spawnpois["_encstr_BEC70C41B68350576ACBE9CFD363"].pos = (-8280, 5837, 0);
  level.br_spawnpois["_encstr_8CFA0CD03AB2995DDFF2BF38EA73"].pos = (-21055, 7124, 0);
  level.br_spawnpois["_encstr_971804ED3712"].pos = (-26873, 32208, 0);
  level.br_spawnpois["_encstr_86430DCDB558D863A04B3983B7391D"].pos = (5823, 38518, 0);
  level.br_spawnpois["_encstr_B49507136BBF0EA070"].pos = (32653, 26929, 0);
}

getspawnselectioncontexclusiongrowth(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("_encstr_BD57277358A5E98F19177753A580972E01903A5A5155DEC3D0F0567E50484FB02F50C203B033552729");
  var_5 = distance2d(var_0, var_1);

  if(var_5 > var_4)
    return getdvarint("_encstr_929C1C1F43A32138E9B9D7DBA190D7910454FFEDEF0758AE48A702C78ADE", 2800);

  var_6 = log(var_3) / (log(var_2) * var_4);
  var_7 = var_2 * exp(var_6 * var_5);
  return var_7;
}

getspawnselectionconstexclusiongrowth(var_0, var_1, var_2, var_3) {
  var_4 = var_2 / var_3;
  var_5 = getdvarint("_encstr_BD57277358A5E98F19177753A580972E01903A5A5155DEC3D0F0567E50484FB02F50C203B033552729");
  var_6 = distance2d(var_0, var_1);

  if(var_6 > var_5)
    return getdvarint("_encstr_929C1C1F43A32138E9B9D7DBA190D7910454FFEDEF0758AE48A702C78ADE", 2800);

  var_7 = var_6 / var_5;
  var_8 = var_2 * pow(1 + var_4, var_7);
  return var_8;
}

getspawnselectionlerpexclusiongrowth(var_0, var_1, var_2, var_3) {
  var_4 = getdvarint("_encstr_BD57277358A5E98F19177753A580972E01903A5A5155DEC3D0F0567E50484FB02F50C203B033552729");
  var_5 = distance2d(var_0, var_1);

  if(var_5 > var_4)
    return getdvarint("_encstr_929C1C1F43A32138E9B9D7DBA190D7910454FFEDEF0758AE48A702C78ADE", 2800);

  var_6 = var_5 / var_4;
  var_7 = scripts\engine\math::lerp(var_2, var_3, var_6);
  return var_7;
}

getspawnselectionpoi(var_0) {
  var_1 = 2147483647;
  var_2 = undefined;

  foreach(var_6, var_4 in level.br_spawnpois) {
    var_5 = distance2d(var_0, var_4.pos);

    if(var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_6;
    }
  }

  return [var_1, var_2];
}

getspawnselectionexclusionsize(var_0, var_1, var_2) {
  var_3 = getDvar("_encstr_8EF71E63396E270568892F0B4BE8CF2F95903A3A06CC973D588F0EE62780D053", "_encstr_95BD0B36ED73E896CDD5F6AE6E");
  var_4 = level.br_spawnpois[var_2];

  switch (var_3) {
    case "_encstr_95BD0B36ED73E896CDD5F6AE6E":
      var_4.spawnexclusion2ddist = getspawnselectioncontexclusiongrowth(var_4.pos, var_0, var_4.exclusionmin, var_4.exclusionmax);
      break;
    case "_encstr_8FB70913D8A0A77BA32813":
      var_4.spawnexclusion2ddist = getspawnselectionconstexclusiongrowth(var_4.pos, var_0, var_4.exclusionmin, var_4.exclusionmax);
      break;
    case "_encstr_86AD05B1563983":
      var_4.spawnexclusion2ddist = getspawnselectionlerpexclusiongrowth(var_4.pos, var_0, var_4.exclusionmin, var_4.exclusionmax);
      break;
    default:
      var_4.spawnexclusion2ddist = getdvarint("_encstr_929C1C1F43A32138E9B9D7DBA190D7910454FFEDEF0758AE48A702C78ADE", 2800);
  }

  return var_4.spawnexclusion2ddist;
}

_id_14361(var_0) {
  wait(var_0);
}

_id_11DBB(var_0, var_1, var_2, var_3) {
  self moveTo(var_0, var_1, var_2, var_3);
}

_id_12D9F(var_0, var_1, var_2, var_3) {
  self rotateTo(var_0, var_1, var_2, var_3);
}

showextractionobjectivetoteam() {
  var_0 = distance(level.br_ac130._id_12205.startpt, level.br_ac130._id_12205.endpt);
  var_1 = var_0 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed() / level.showexfilstartsplash.size;

  for(var_2 = 0; var_2 < level.showexfilstartsplash.size; var_2++) {
    wait(var_1);
    level.showexfilstartsplash[var_2] notify("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82");
  }

  level.showexfilstartsplash = undefined;
}

_id_12B22(var_0) {
  if(!isDefined(level.showexfilstartsplash))
    level.showexfilstartsplash = [];

  level.showexfilstartsplash[level.showexfilstartsplash.size] = var_0;
}