/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_circle.gsc
***********************************************/

initcircle() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A78F076CA54E1B1B56"))
    level.br_circle_disabled = 1;
  else {
    if(!isDefined(level.br_level)) {
      return;
    }
    level.br_circle = spawnStruct();
    level.br_circle.mapbounds = level.br_level.br_mapbounds;

    if(getdvarint("_encstr_A9171BD71B537F02CD80EE647E979A0D9EB03743984987AAC3A1769FED", 0) > 0)
      level.br_circle.damagetick = [getdvarint("_encstr_A9171BD71B537F02CD80EE647E979A0D9EB03743984987AAC3A1769FED", 0)];
    else if(level.mapname == "_encstr_8B240B70C2BF685DFA3B1DF3C2" || level.mapname == "_encstr_A1BC0A5B07D7E09396DCF69B" || level.mapname == "_encstr_B2650A08775E4BF3A841CF2B")
      level.br_circle.damagetick = [9, 9, 9, 9, 9];
    else
      level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];

    _id_1312A();
    var_0 = getdvarvector("_encstr_8E141949237FCCB06D91315FBB9450061BCA66900BCF7EA0446C3B", (0, 0, 0));

    if(length(var_0) > 0)
      level.br_circle.br_finalcircleoverride = var_0;

    if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_96F01524FD4B55733DBAD0A152521F686743BD2844D71B"))
      level.br_circle.br_finalcircleoverride = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_96F01524FD4B55733DBAD0A152521F686743BD2844D71B");

    setomnvar("_encstr_A5E615ABE7B176D80F0D70A8341588B769637B017FBB46", level.br_level.br_circleminimapradii[0]);
    level.br_circle.circleindex = -1;
    allplayers_setphysicaldof();
    var_1 = level.br_level.br_circleradii.size;

    if(isDefined(var_1) && var_1 > 0) {
      teleport_entities_inside_subway_car(var_1);
      return;
    }

    teleport_entities_inside_subway_car(12);
  }
}

_id_1312A() {
  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start))
    level.debug_vault_assault_retrieve_saw_obj_start = [];

  if(getDvar("_encstr_ADD81DBF3BCAA97E83B151180BAF212029951117ACF3B8350F3B69A0436F66") != "_encstr_B40101") {
    var_0 = strtok(getDvar("_encstr_ADD81DBF3BCAA97E83B151180BAF212029951117ACF3B8350F3B69A0436F66"), "_encstr_964C0249");

    if(var_0.size % 4 != 0) {
      return;
    }
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = int(var_0[var_1]);
      var_3 = var_2 + "_encstr_B40101";

      if(var_3 != var_0[var_1]) {
        return;
      }
      var_0[var_1] = var_2;
    }

    for(var_1 = 0; var_1 < var_0.size; var_1 = var_1 + 4)
      level.debug_vault_assault_retrieve_saw_obj_start[level.debug_vault_assault_retrieve_saw_obj_start.size] = init_safehouse_gunshop((var_0[var_1], var_0[var_1 + 1], var_0[var_1 + 2]), var_0[var_1 + 3]);
  }
}

teleport_players_inside_subway_car(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.br_circle)) {
    return;
  }
  level.br_circle = spawnStruct();
  level.br_circle.mapbounds = level.br_level.br_mapbounds;
  level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];
  var_5 = level.br_level.br_circleclosetimes.size - 1;

  if(!isDefined(var_2) || var_2 < 0)
    var_2 = 0;
  else if(var_2 > var_5)
    var_2 = var_5;

  var_6 = level.br_level.br_circleclosetimes.size - var_2;
  var_7 = level.br_level.br_circleradii[0];

  if(!isDefined(var_3) || var_3 <= 0)
    var_3 = level.br_level.br_circleclosetimes[0];

  level.br_circle.circleindex = -1;
  level.br_level.ground_trigger_pipes_room = undefined;
  level.br_circle.damagetick = ignorefallback(level.br_circle.damagetick, var_2);
  level.br_level.br_circleclosetimes = ignorefallback(level.br_level.br_circleclosetimes, var_2);
  level.br_level.br_circledelaytimes = safehouse_vo_return_end(var_6, var_1);
  level.br_level.default_player_connect_black_screen = safehouse_vo_return_end(var_6, var_1);
  level.br_level.default_suicidebomber_combat = ignorefallback(level.br_level.default_suicidebomber_combat, var_2);
  level.br_level.br_circleminimapradii = ignorefallback(level.br_level.br_circleminimapradii, var_2);
  level.br_level.br_circleradii = ignorefallback(level.br_level.br_circleradii, var_2);
  level.br_level.br_circleradii[0] = var_7;
  level.br_level.br_circleclosetimes[0] = var_3;

  if(isDefined(var_4))
    level.br_level.br_circledelaytimes[1] = var_4;

  level.br_circle.br_finalcircleoverride = var_0;
  cacheentity();
  level thread allplayers_setphysicaldof();
  level.br_circle.br_finalcircleoverride = undefined;
  level notify("_encstr_8F8F12E70303AAD5CD813BC52A860CFD427A3BC3");

  if(isDefined(level.gulag_tutorial_vo)) {
    foreach(var_9 in level.gulag_tutorial_vo)
    var_9 delete();

    level.gulag_tutorial_vo = undefined;
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_13234();
  }

  thread _id_12E09(0);
}

ignorefallback(var_0, var_1) {
  if(var_1 == 0)
    return var_0;

  var_0 = scripts\engine\utility::array_slice(var_0, var_1, var_0.size);
  return var_0;
}

safehouse_vo_return_end(var_0, var_1) {
  var_2 = [];
  var_2[0] = var_1;

  for(var_3 = 1; var_3 < var_0; var_3++)
    var_2[var_2.size] = 0;

  return var_2;
}

getsafecircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
    return (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  else
    return (0, 0, 0);
}

getsafecircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
    return level.br_circle.safecircleent.origin[2];
  else
    return 0;
}

getdangercircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent))
    return (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  else
    return (0, 0, 0);
}

getdangercircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent))
    return level.br_circle.dangercircleent.origin[2];
  else
    return 0;
}

reset_timescalefactor() {
  var_0 = level.br_circle.circleindex + 2;

  if(var_0 < level.br_level.default_class_chosen.size)
    return level.br_level.default_class_chosen[var_0];
  else
    return undefined;
}

reset_totals_keep_type() {
  var_0 = level.br_circle.circleindex + 2;

  if(var_0 < level.br_level.br_circleradii.size)
    return level.br_level.br_circleradii[var_0];
  else
    return undefined;
}

get_best_goal_closest_to_any_player() {
  return isDefined(level.br_circle.safecircleent) && !istrue(level.br_circle.safecircleent.hidden);
}

get_bcrumbstruct_proximity() {
  return isDefined(level.br_circle.dangercircleent) && !istrue(level.br_circle.dangercircleent.hidden);
}

_id_12519() {
  if(istrue(self._id_14439))
    return 0;

  if(istrue(self.gulag)) {
    if(istrue(self.gulagarena) || istrue(self.jailed))
      return 0;
  }

  if(istrue(self.unset_relic_thirdperson))
    return 0;

  return get_bcrumbstruct_proximity();
}

cancircledamageplayer(var_0) {
  return isalive(var_0) && var_0 _id_12519() && !istrue(var_0.gulag) && !istrue(var_0.inrespawnc130) && !var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && !var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC();
}

_id_13E18() {
  var_0 = self;

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.vehicle_collision_getleveldata)) {
    return;
  }
  if(!isDefined(var_0.operatorcustomization)) {
    return;
  }
  if(var_0 scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }
  if(isDefined(var_0.did_ads_hint) && gettime() < var_0.did_ads_hint) {
    return;
  }
  var_0.did_ads_hint = gettime() + randomintrange(5000, 7000);

  if(!isai(var_0))
    var_0 playsoundtoplayer("_encstr_AC1F11299EBB31F7125F13233B09B66855F730", var_0, var_0);

  var_1 = "_encstr_95601258368D2D9537EBD60B36B2BE36DEBACE86";
  var_2 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::disableannouncer(var_0);
  var_3 = var_0.operatorcustomization.gender;

  if(var_2 == "_encstr_8E8405EA382B2A") {
    if(isDefined(var_3) && var_3 == "_encstr_B82907C2887BC62B39")
      var_1 = "_encstr_8A8212C848BAAF6F561DB0DB718B408E65EF17CB";
    else
      var_1 = "_encstr_B2A11071DBFFEEA9152999F36FFE60B59F72";
  } else if(isDefined(var_3) && var_3 == "_encstr_B82907C2887BC62B39")
    var_1 = "_encstr_92E414E9DDA4807DE3A72D2347EA31387FF6D0E38718";
  else
    var_1 = "_encstr_95601258368D2D9537EBD60B36B2BE36DEBACE86";

  var_4 = randomint(game["_encstr_B85109BAD04FB3DD30FB7D"][var_1].size);
  var_5 = game["_encstr_B85109BAD04FB3DD30FB7D"][var_1][var_4];
  var_0 playsoundonmovingent(var_5);
}

_id_131A0() {
  if(!isDefined(self._id_125E4))
    self._id_125E4 = gettime();
}

_id_12C79() {
  self._id_125E4 = undefined;
}

firstteam() {
  var_0 = [60.0, 90.0, 120.0];
  var_1 = [2.0, 3.0, 10.0];
  var_2 = spawnStruct();
  var_2.enabled = getdvarint("_encstr_B83122F8FB6379A3A926F1CA8AAED20F40AFDBB77BD23A871933D22BD927589021909FC8", 1);
  var_2._id_11F3F = getdvarint("_encstr_92BF2040EA425FEB5B914B4D7A6FF1EBEAB1F028A2DF7D4677ADD93D7FB7B89B15EB", 3);
  var_2._id_13B7B = [];
  var_2._id_11E09 = [];
  var_3 = 0.0;
  var_4 = 1.0;

  for(var_5 = 0; var_5 < var_2._id_11F3F; var_5++) {
    var_6 = undefined;
    var_7 = undefined;

    if(var_5 < var_0.size) {
      var_6 = var_0[var_5];
      var_7 = var_1[var_5];
      var_3 = var_6;
      var_4 = var_7;
    } else {
      var_3 = var_3 + 1.0;
      var_4 = var_4 + 1.0;
      var_6 = var_3;
      var_7 = var_4;
    }

    var_2._id_13B7B[var_5] = getdvarfloat("_encstr_83A020FFF716D958403148574B0197F26E776B0F4335533F209B051B0670D14ACDDF" + scripts\engine\utility::string(var_5 + 1), var_6);
    var_2._id_11E09[var_5] = getdvarfloat("_encstr_99AF2090E8DBE7D3307E339373DE277826712D01A9530E41075B20118F27A02293D1" + scripts\engine\utility::string(var_5 + 1), var_7);
  }

  return var_2;
}

relic_nuketimer(var_0, var_1) {
  if(!var_0.enabled)
    return var_1;

  if(!isDefined(self._id_125E4))
    return var_1;

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(isDefined(level.ffsm_onground_stateenter) && self.vehicle.vehiclename == "_encstr_83F40783ADF1D14AA3")
      return level.ffsm_onground_stateenter;

    if(isDefined(level.pickedupcoreminigun) && self.vehicle.vehiclename == "_encstr_BDC80A5437EAD749519A6068")
      return level.pickedupcoreminigun;
  }

  var_2 = (gettime() - self._id_125E4) * 0.001;

  for(var_3 = var_0._id_11F3F - 1; var_3 >= 0; var_3--) {
    var_4 = var_0._id_13B7B[var_3];

    if(var_2 >= var_4) {
      var_5 = var_0._id_11E09[var_3];
      return int(var_1 * var_5);
    }
  }

  return var_1;
}

circledamagetick() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_86FA1495B946D04BC91B63952258DA0B7656A2D2C6AD");

  while(level.br_circle.circleindex < 0)
    waitframe();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC"))
    level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");

  var_0 = getdvarfloat("_encstr_9BF4277FA8FBE79A2568168CE62F3265E660A393603104715F999F86C0FB2B17EBC06B577808478AB9", 2400.0);
  var_1 = getdvarfloat("_encstr_A5452682D0A281E890AECF3B0247D0D8974ABF21986761C0759B1B5093F7E92009FAC07B2C70D2B3", 1000.0);
  var_2 = firstteam();

  for(;;) {
    if(isDefined(level.br_circle.dangercircleent)) {
      var_3 = level.br_circle.circleindex;

      if(var_3 > level.br_circle.damagetick.size - 1)
        var_3 = level.br_circle.damagetick.size - 1;

      var_4 = level.br_circle.damagetick[var_3];

      if(isDefined(level.circledamagemultiplier))
        var_4 = var_4 * level.circledamagemultiplier;

      if(var_4 > 0) {
        var_5 = getdangercircleorigin();
        var_6 = getdangercircleradius();

        foreach(var_8 in level.players) {
          if(!isDefined(var_8) || !isDefined(var_8.origin)) {
            continue;
          }
          if(isDefined(var_8) && istrue(var_8.start_death_from_above_sequence)) {
            continue;
          }
          if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC") && istrue(var_8.plotarmor)) {
            var_8 _id_12C79();
            continue;
          }

          var_9 = 0;

          if(distance2dsquared(var_5, var_8.origin) > var_6 * var_6) {
            if(var_8 cancircledamageplayer(var_8)) {
              var_9 = 1;
              var_8 _id_131A0();
              var_10 = var_8 relic_nuketimer(var_2, var_4);

              if(scripts\cp_mp\gasmask::hasgasmask(var_8)) {
                if(_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ks_circlecount(var_8)) {
                  if(!istrue(var_8.gasmaskequipped)) {
                    var_8 _id_1384C(var_10);

                    if(!isalive(var_8))
                      continue;
                  }

                  var_8 scripts\cp_mp\gasmask::processdamage(var_10);
                } else {
                  if(!istrue(level._encstr_B18215C07F8B5833DB3CE56017B26101C4371878EB3C91) && !istrue(var_8.gasmaskequipped) && !istrue(var_8.gasmaskswapinprogress) && var_8 _meth_87EB()) {
                    var_8 _id_1384C(var_10);

                    if(!isalive(var_8))
                      continue;
                  }

                  if(isDefined(var_8.gasmaskhealth) && var_8.gasmaskhealth <= 0) {
                    var_8 playsoundtoplayer("_encstr_BED616F65A310F91CBCFC0A857FB6EBF4B06FE8AF91BD1BB", var_8);
                    var_8 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::handleweaponreloadammodrop();
                  } else {
                    var_8 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrepositoryref("_encstr_8AF50A134EEBC6A5396C362B");
                    var_8 scripts\cp_mp\gasmask::processdamage(var_10);
                  }
                }
              } else
                var_8 _id_1384C(var_10);
            } else
              var_8 _id_12C79();
          } else {
            var_8 _id_12C79();

            if(scripts\cp_mp\gasmask::hasgasmask(var_8)) {
              if(_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::ks_circlecount(var_8))
                continue;
              else if(isDefined(var_8.gasmaskhealth) && var_8.gasmaskhealth <= 0) {
                var_8 playsoundtoplayer("_encstr_BED616F65A310F91CBCFC0A857FB6EBF4B06FE8AF91BD1BB", var_8);
                var_8 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::handleweaponreloadammodrop();
              } else
                var_8 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::plunderrankupdate("_encstr_8AF50A134EEBC6A5396C362B");
            }
          }

          if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
            var_8 _id_13FE3(var_9);
        }

        var_12 = var_6 + var_0;
        var_13 = var_6 + var_1;
        _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dangercircletick(var_5, var_12);
        _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::dangercircletick(var_5, var_12);
        _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::dangercircletick(var_5, var_6, var_12);
        _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::dangercircletick(var_5, var_12);
        _encstr_A5E12A9EFE03F3136CDF72683BDF091B1AE79523922A8FB022E3E9F02BA54075E3810D2EAE927BC346DF80E8::dangercircletick(var_5, var_12);
        _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::dangercircletick(var_5, var_6);
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::dangercircletick(var_5, var_6);
        _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::dangercircletick(var_5, var_6);
        _encstr_B1402B7BCF9854D32D73D6FA3BA8D70E08BBF4E941981A66DE4BE903615D1785D80B8C7D8718231BFD28620B09::dangercircletick(var_5, var_6);
        _encstr_A3872A932672483F4BDF47FBEBC68C40353FFBAA8ACD2058C233AFF5978A46B8C2120683F52758AE5E7FEFF7::dangercircletick(var_5, var_6);
        scripts\mp\equipment\binoculars::isbossheli(var_5, var_6);
        _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_97D311FBD1FDFCADD2C9E888A7D50FD3890F07", var_5, var_12);
        _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_831717745038E7A5DB06D86BBF513DA4083EB260B9590BA173", var_5, var_6);
        _findgivearmoramountanddropleftovers::dangercircletick(var_5, var_12);

        if(getdvarint("_encstr_BABB17E68D9CFA4C27FA58B13AFADADEC82BEBACDC8DB0C1CA", 0))
          _encstr_81032C6ED8E4B41CA3CDCBAD0E979DB05B561D971C95375E98C9BE2C3647FA6BDEC8B2AF56E68D0B38955C76B9C6::dangercircletick(var_5, var_13, var_6);

        if(getdvarint("_encstr_97B8256FB8EBF79A638DE0117A0B229C5198D75720A00E1357236197DCCBFA4CBE781F63983B7D", 0) && isDefined(level.hudextractnum))
          [[level.hudextractnum]](var_5, var_6);

        if(getdvarint("_encstr_824E198E3F0B3F8006374DFFD068779EFD62DF7F29C8FAFFA47707", 0) && isDefined(level.onmatchplacement))
          [[level.onmatchplacement]](var_5, var_13, var_6);

        if(getdvarint("_encstr_ABAF14CD3693BE773D999118AF854B7D2B6759E6D16E", 0) && isDefined(level.next_drone_cd))
          [[level.next_drone_cd]](var_5, var_6);
      }
    }

    wait 1;
  }
}

_id_1384C(var_0) {
  var_1 = self;

  if(isDefined(level._id_11C95))
    var_0 = var_1[[level._id_11C95]](var_0);

  if(var_1 scripts\mp\utility\killstreak::isjuggernaut())
    var_0 = _encstr_AB9028F6A91A7BB7236095EDABB080C8900FED03A169B3BE2233379AFBD114EFC608405D7BE54D49236E::_id_11C95(var_0);

  var_1 dodamage(var_0, var_1.origin, var_1, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");

  if(var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
    var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(var_0);

  if(isalive(var_1))
    var_1 _id_13E18();
}

_id_13FE3(var_0) {
  if(!isDefined(self.unset_relic_shieldsonly)) {
    self.unset_relic_shieldsonly = var_0;
    self.waittill_see_infl_lbravo_long_enough = gettime();
  }

  if(self.unset_relic_shieldsonly != var_0) {
    self.unset_relic_shieldsonly = var_0;
    var_1 = gettime();

    if(var_0) {
      scripts\cp\vehicles\vehicle_compass_cp::_id_1383B("_encstr_A9B10D16D8A53B2BEBB473F5D9C2CD");
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::descendpos(self, var_1 - self.waittill_see_infl_lbravo_long_enough);
    } else {
      scripts\cp\vehicles\vehicle_compass_cp::_id_138D5("_encstr_A9B10D16D8A53B2BEBB473F5D9C2CD");
      _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::descendsolostarts(self, var_1 - self.waittill_see_infl_lbravo_long_enough);
    }

    self.waittill_see_infl_lbravo_long_enough = var_1;
  }
}

startuiclosetimer(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E07("_encstr_82C6125F793FABFC2954A67588C0350183F38FC3", var_0, var_1, var_2, var_3))) {
    return;
  }
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + int(var_0 * 1000));
  var_4 = _id_13322();

  if(var_1 == 0)
    var_1 = !scripts\mp\flags::gameflag("_encstr_B28811BA9B8952D39F1FE35F99DFCFC398101B");

  if(!var_1) {
    foreach(var_6 in level.players) {
      if(!isbot(var_6) && !var_6 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
        if(istrue(var_2)) {
          var_6 thread scripts\mp\hud_message::showsplash("_encstr_93A310AE7BC956BA10E3AB6FCF4BD38BB861");
          continue;
        }

        if(!var_4 || var_3 > 1)
          var_6 thread scripts\mp\hud_message::showsplash("_encstr_AF2D0E7B357F089DE7A6E767063EDB47");
      }
    }
  }

  if(istrue(var_2))
    setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 3);
  else
    setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 0);

  var_8 = [60, 30, 20, 10, 0];
  var_9 = var_8.size - 1;

  for(var_10 = 0; var_10 < var_8.size; var_10++) {
    if(var_0 > var_8[var_10]) {
      var_9 = var_10;
      break;
    }
  }

  if(var_0 < var_8[var_9]) {
    return;
  }
  wait(var_0 - var_8[var_9]);

  for(var_10 = var_9; var_10 < var_8.size - 1; var_10++) {
    if(var_10 == 2)
      thread scripts\mp\music_and_dialog::debugtype();

    if(var_10 == 3)
      setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 2);

    wait(var_8[var_10] - var_8[var_10 + 1]);
  }

  level notify("_encstr_9A5B122613D778EAB328E0F5608153BAB6EB3D4C");

  if(!var_1) {
    foreach(var_6 in level.players) {
      if(!isbot(var_6) && !var_6 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag() && (!var_4 || var_3 > 0)) {
        if(istrue(level.vehicle_collision_getleveldata))
          var_6 scripts\engine\utility::delaythread(2, scripts\mp\hud_message::showsplash, "_encstr_910A08358239287F9FCF");
        else
          var_6 thread scripts\mp\hud_message::showsplash("_encstr_87D8115A724129CFD61E4C43F9B298DD076A3B");

        var_6 playlocalsound("_encstr_9A5B122613D778EAB328E0F5608153BAB6EB3D4C");
      }
    }
  }

  setomnvar("_encstr_969213BAA57D13C9D76C5A9CB11B95BE6E1D16E8B2", 1);
}

all_players_are_in_trap_room_entrance() {
  setomnvar("_encstr_B2BF19AB3A7975FBC7A373F6BB534199D1238038634BD7F337C50D", 0);
}

_id_131AD(var_0) {
  if(scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8F94079C2BB3B2C21B" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_91070301C2" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_920A0862BD63CB5FC758")
    setomnvar("_encstr_9B391B25C4695DDBCF07C8E8FF04F131B1EA1DA79AB35F61D673C0D0BF", var_0);

  setomnvar("_encstr_86E11957B47D31E4EB1B2DE41B63AC60FA2B3732F556E6E896D1F2", var_0);
}

setstaticuicircles(var_0, var_1, var_2, var_3) {
  var_4 = ammo_buy_point_loop(var_0);
  setomnvar("_encstr_B2BF19AB3A7975FBC7A373F6BB534199D1238038634BD7F337C50D", gettime());
  setomnvar("_encstr_887817D5B4BE8993AF1B2D2736B1CAC0FA46AE93B0D14BB7E6", var_4);

  if(scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8F94079C2BB3B2C21B" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_91070301C2" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_920A0862BD63CB5FC758")
    setomnvar("_encstr_9B391B25C4695DDBCF07C8E8FF04F131B1EA1DA79AB35F61D673C0D0BF", var_1);

  setomnvar("_encstr_86E11957B47D31E4EB1B2DE41B63AC60FA2B3732F556E6E896D1F2", var_1);

  if(istrue(var_3))
    all_players_are_in_trap_room_entrance();

  var_4 = adjust_damage_based_on_weaponclass(var_0);
  setomnvar("_encstr_9AFA19B38A672680D96BD31D93FDF057BF832BB9A3A3F0E86C4DC3", gettime());
  setomnvar("_encstr_AF0A179B6C672806B1C783BDEFAAC50ACF8703F39694B8B0FA", var_4);
  setomnvar("_encstr_B8D31BC8F3F8E65B71B70F46A33930D95FEB130BC33B815D8A5B94C96B", var_2);
  setomnvar("_encstr_921519A5837678C308B3925B220C92ABFE7F309A012B2AE55AE37B", var_2);
  thread updatecirclehide(var_0, var_1, var_2);
}

setclosinguicircle(var_0, var_1, var_2, var_3) {
  var_4 = ammo_buy_point_loop(var_0);
  setomnvar("_encstr_B2BF19AB3A7975FBC7A373F6BB534199D1238038634BD7F337C50D", gettime());
  setomnvar("_encstr_887817D5B4BE8993AF1B2D2736B1CAC0FA46AE93B0D14BB7E6", var_4);

  if(scripts\mp\utility\game::round_vehicle_logic() != "_encstr_8F94079C2BB3B2C21B" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_91070301C2" && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_920A0862BD63CB5FC758")
    setomnvar("_encstr_9B391B25C4695DDBCF07C8E8FF04F131B1EA1DA79AB35F61D673C0D0BF", var_1);

  setomnvar("_encstr_86E11957B47D31E4EB1B2DE41B63AC60FA2B3732F556E6E896D1F2", var_1);

  if(istrue(var_3))
    all_players_are_in_trap_room_entrance();

  var_4 = adjust_damage_based_on_weaponclass(var_0);
  setomnvar("_encstr_9AFA19B38A672680D96BD31D93FDF057BF832BB9A3A3F0E86C4DC3", gettime());
  setomnvar("_encstr_AF0A179B6C672806B1C783BDEFAAC50ACF8703F39694B8B0FA", var_4);
  setomnvar("_encstr_B8D31BC8F3F8E65B71B70F46A33930D95FEB130BC33B815D8A5B94C96B", var_2);
  setomnvar("_encstr_921519A5837678C308B3925B220C92ABFE7F309A012B2AE55AE37B", var_1);
  thread updatecirclehide(var_0, var_1, var_2);
}

updatecirclehide(var_0, var_1, var_2) {
  level notify("_encstr_BD17167B60DF7963AFCE6108A0CEE82BFF4FED6D0BAAB548");
  level endon("_encstr_BD17167B60DF7963AFCE6108A0CEE82BFF4FED6D0BAAB548");

  for(;;) {
    level waittill("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
    var_3 = ammo_buy_point_loop(var_0);
    setomnvar("_encstr_887817D5B4BE8993AF1B2D2736B1CAC0FA46AE93B0D14BB7E6", var_3);
    var_3 = adjust_damage_based_on_weaponclass(var_0);
    setomnvar("_encstr_AF0A179B6C672806B1C783BDEFAAC50ACF8703F39694B8B0FA", var_3);
  }
}

adjust_damage_based_on_weaponclass(var_0) {
  if(get_bcrumbstruct_proximity())
    return int(var_0 * 1000);
  else
    return 0;
}

ammo_buy_point_loop(var_0) {
  if(get_best_goal_closest_to_any_player())
    return int(var_0 * 1000);
  else
    return 0;
}

islastcircle() {
  return level.br_circle.circleindex >= level.br_level.br_circleradii.size - 1 || !(level.br_level.br_circleradii[level.br_circle.circleindex + 1] > 0);
}

groupindex(var_0) {
  var_1 = level.br_level.br_circledelaytimes[var_0];
  var_2 = level.br_level.br_circleclosetimes[var_0];
  var_3 = var_1 + var_2;
  return var_3;
}

inithelirepository() {
  var_0 = level.br_circle.circleindex;
  var_1 = groupindex(var_0);
  var_2 = level.br_circle.starttime / 1000;
  var_3 = gettime() / 1000 - var_2;
  return var_1 - var_3;
}

_encstr_AD54171C038EE3AB0B220828A9A906C1D0B5874B02A76F35B1() {
  var_0 = level.br_circle.circleindex;

  if(!isDefined(var_0) || var_0 < 0)
    return 0;

  var_1 = inithelirepository();
  var_2 = level.br_level.br_circleclosetimes[var_0];
  return var_1 <= var_2;
}

helibankplunder(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::array_randomize(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(var_0.team, var_0.squadindex));
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6 != var_0) {
      var_4 = var_6;
      break;
    }
  }

  if(!isDefined(var_4))
    return undefined;

  if(!isDefined(var_1))
    var_1 = 0;

  var_8 = var_4.origin;
  var_9 = level.br_circle.circleindex;
  var_10 = level.br_circle.starttime / 1000;
  var_11 = var_1 + gettime() / 1000 + var_2;
  var_12 = max(var_11 - var_10 - level.br_level.br_circledelaytimes[var_9], 0);
  var_13 = int(min(var_9 + 1, level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective - 1));
  var_14 = level.br_level.br_circleclosetimes[var_9];
  var_15 = level.br_level.default_class_chosen[var_9];
  var_16 = level.br_level.br_circleradii[var_9];
  var_17 = level.br_level.default_class_chosen[var_13];
  var_18 = level.br_level.br_circleradii[var_13];
  var_19 = (var_17 - var_15) / var_14;
  var_20 = (var_18 - var_16) / var_14;
  var_21 = var_15 + var_19 * var_12;
  var_22 = var_16 + var_20 * var_12;
  var_23 = distance2d(var_8, var_21);

  if(var_23 == 0)
    return undefined;

  var_24 = getdvarfloat("_encstr_AC0719573F9318A8B21183790298F844EA67E1EB871BC088EFF6EA", 1000.0);
  var_25 = var_8 + (var_21 - var_8) * (var_24 / var_23);

  if(vandalize_minigun_speed(var_25, 0, var_1 + var_2))
    return var_25;

  var_26 = getdvarfloat("_encstr_B67C22DC6C277D269CAF9C2B9B38C2EECDEBC82DB9A3D7664E16368E2DB7CDEB58BB58BC", 0.5);
  var_24 = var_23 * var_26;
  var_25 = var_8 + (var_21 - var_8) * (var_24 / var_23);

  if(vandalize_minigun_speed(var_25, 0, var_1 + var_2))
    return var_25;

  var_27 = var_8 - var_21;
  var_25 = var_21 + var_22 / var_23 * var_27;

  if(vandalize_minigun_speed(var_25, 0, var_1 + var_2))
    return var_25;

  return undefined;
}

vandalize_minigun_speed(var_0, var_1, var_2) {
  if(!_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_0, 1))
    return 0;

  if(istrue(var_1) && allassassin_teamcompare(var_0))
    return 0;

  if(isDefined(var_2)) {
    var_3 = getmintimetillpointindangercircle(var_0);

    if(var_2 > var_3)
      return 0;
  }

  return 1;
}

_encstr_AD30271B63ED3759CDE8B98533561CB293B4DAACE82B271C7B5AE61D994EB7D6DC2EBAC219B685A3CA(var_0, var_1) {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var_2 = scripts\engine\utility::array_sort_with_func(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(self.team, self.squadindex), ::_encstr_996B17C78602D0D368C52D01112A515835AB20F3ADDFB5A850);

    foreach(var_4 in var_2) {
      if(var_4 != self) {
        if(var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() == 0) {
          var_5 = _encstr_B8511E09114DD3DE68CF6B45CF90E2CF64C973D2DB130F97403362589F10ED43(var_4.origin, var_0, var_1);

          if(isDefined(var_5))
            return var_5;
        }
      }
    }
  }

  return undefined;
}

_encstr_996B17C78602D0D368C52D01112A515835AB20F3ADDFB5A850(var_0, var_1) {
  return var_0.health >= var_1.health;
}

_encstr_BD592572209FE2AF5B155B4124A1C3AF0D901AEA08531AB3B0F35E6CCCAB77F549084272681BD3(var_0, var_1) {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    foreach(var_3 in level.br_pickups.crates) {
      if(!isDefined(var_3) || !isDefined(var_3.team) || var_3.team != self.team) {
        continue;
      }
      if(isDefined(var_3.playerscaptured) && isDefined(var_3.playerscaptured[self getentitynumber()])) {
        continue;
      }
      var_4 = _encstr_B8511E09114DD3DE68CF6B45CF90E2CF64C973D2DB130F97403362589F10ED43(var_3.origin, var_0, var_1);

      if(isDefined(var_4))
        return var_4;
    }
  }

  return undefined;
}

_encstr_B8511E09114DD3DE68CF6B45CF90E2CF64C973D2DB130F97403362589F10ED43(var_0, var_1, var_2) {
  var_3 = getsafecircleorigin();
  var_4 = float(getsafecircleradius());
  var_5 = getdangercircleorigin();
  var_6 = getdangercircleradius();
  var_7 = var_4 * var_4;

  if(var_7 > 0.0) {
    var_8 = distance2d(var_0, var_5);

    if(var_8 == 0)
      return var_0;

    var_6 = min(var_6, var_8);
    var_9 = 4;

    for(var_10 = var_9; var_10 >= 0; var_10--) {
      var_11 = var_6 * (var_10 / var_9);
      var_12 = (var_0 - var_5) * (var_11 / var_8) * var_1 + var_5;

      if(vandalize_minigun_speed(var_12, 0, var_2)) {
        if(getdvarint("_encstr_A16E1F53AE53678EF5F1D2EA304D871FCB07DFF62EB8E7529158E8E2685BFF4760", 1) == 1 && isscriptabledefined()) {
          var_12 = getclosestpointonnavmesh(var_12);

          if(vandalize_minigun_speed(var_12, 0, var_2) == 0)
            continue;
        }

        return var_12;
      }
    }
  }

  return undefined;
}

risk_flagspawnshiftingpercent(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_5 = istrue(var_5) && isscriptabledefined();
  var_8 = 8;
  var_9 = var_0;
  var_10 = 0;
  var_11 = 0;

  for(var_12 = 360; var_10 < var_8; var_10++) {
    var_13 = getrandompointincircle(var_0, var_1, var_2, var_3, 1, 0, var_11, var_12);

    if(vandalize_minigun_speed(var_13, var_6, var_7)) {
      var_9 = var_13;

      if(var_5) {
        var_13 = getclosestpointonnavmesh(var_9);

        if(vandalize_minigun_speed(var_13, var_6, var_7)) {
          var_9 = var_13;
          break;
        }
      } else
        break;
    }

    var_14 = level.br_level.default_class_chosen[0] - var_0;
    var_14 = (var_14[0], var_14[1], 0);
    var_15 = vectortoangles(var_14)[1];
    var_16 = (1.0 - var_10 / var_8) * 180;
    var_11 = var_15 - var_16;
    var_12 = var_15 + var_16;
  }

  return var_9;
}

getrandompointincircle(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_1 <= 0.0)
    return var_0;

  var_8 = 0.0;

  if(isDefined(var_2))
    var_8 = var_2;

  var_9 = 1.0;

  if(isDefined(var_3))
    var_9 = var_3;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 1;

  if(!isDefined(var_6))
    var_6 = 0;

  if(!isDefined(var_7))
    var_7 = 360;

  var_10 = squared(var_1 * var_8);
  var_11 = squared(var_1 * var_9);
  var_12 = undefined;

  if(var_10 == var_11)
    var_12 = sqrt(var_10);
  else
    var_12 = sqrt(randomfloatrange(var_10, var_11));

  var_13 = var_6 + randomfloat(var_7 - var_6);
  var_14 = (var_12 * cos(var_13), var_12 * sin(var_13), 0);
  var_15 = var_0 + var_14;

  if(var_4) {
    var_16 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::semtex_used();
    var_17 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
    var_15 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage((var_0[0], var_0[1], 0) + var_14, var_16);
  }

  if(var_5 && isscriptabledefined())
    var_15 = getclosestpointonnavmesh(var_15);

  return var_15;
}

getrandompointincurrentcircle(var_0, var_1) {
  var_2 = getdangercircleorigin();
  var_3 = level.br_level.br_circleradii[level.br_circle.circleindex + 1];
  return getrandompointincircle(var_2, var_3, var_0, var_1);
}

riskspawn_flagspawnbytier(var_0, var_1) {
  var_2 = getsafecircleorigin();
  var_3 = getsafecircleradius();
  return getrandompointincircle(var_2, var_3, var_0, var_1);
}

risk_modifyflagstieronrespawn(var_0, var_1) {
  var_2 = getsafecircleorigin();
  var_3 = getsafecircleradius();
  return risk_flagspawnshiftingpercent(var_2, var_3, var_0, var_1);
}

ispointincurrentsafecircle(var_0) {
  if(!isDefined(level.br_circle.dangercircleent))
    return 0;

  var_1 = (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  var_2 = float(level.br_level.br_circleradii[level.br_circle.circleindex + 1]);
  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2)
    return 1;

  return 0;
}

updateprestreamrespawn(var_0) {
  if(!isDefined(level.br_circle.dangercircleent))
    return 0;

  var_1 = getdangercircleorigin();
  var_2 = float(getdangercircleradius());
  var_3 = distance2dsquared(var_1, var_0);
  var_4 = var_2 * var_2;
  return var_3 < var_4;
}

updatescavengerhud(var_0) {
  var_1 = reset_timescalefactor();
  var_2 = float(reset_totals_keep_type());

  if(!isDefined(var_1) || !isDefined(var_2))
    return 0;

  var_3 = distance2dsquared(var_0, var_1);

  if(var_3 < var_2 * var_2)
    return 1;

  return 0;
}

isblocked() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self show();

    foreach(var_1 in level.players) {
      if(!var_1 _id_12519())
        self hidefromplayer(var_1);
    }

    level waittill("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
  }
}

allassassin_teamcompare(var_0) {
  if(getdvarint("_encstr_8826199BE3ADF1A6131E7E7B59F7A39A685FA3341297FB674027F2", 0) == 1)
    return 0;

  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start) || level.debug_vault_assault_retrieve_saw_obj_start.size == 0)
    return 0;

  foreach(var_2 in level.debug_vault_assault_retrieve_saw_obj_start) {
    var_3 = distance2dsquared(var_0, var_2.origin);

    if(var_3 < var_2._id_129E5)
      return 1;
  }

  return 0;
}

allplayers_setphysicaldof(var_0, var_1) {
  level.br_level.default_class_chosen = [];
  var_2 = (level.br_circle.mapbounds[0] + level.br_circle.mapbounds[1]) * 0.5;

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_81EC15B516C11A959B1D9527645ACDC28D68D2E48D36B2"))
    var_2 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_81EC15B516C11A959B1D9527645ACDC28D68D2E48D36B2");

  level.br_level.default_class_chosen[0] = (var_2[0], var_2[1], 0.0);
  var_3 = var_2[0];
  var_4 = var_2[1];

  if(istrue(level.br_level._id_13884)) {
    level.br_level.default_class_chosen[0] = scripts\engine\utility::drop_to_ground((var_3, var_4, 4000));
    level.br_level.default_class_chosen[1] = level.br_level.default_class_chosen[0];
    return;
  }

  var_5 = getdvarfloat("_encstr_AAE3242B9E3AB17E7327A7BBBB4AB1B8FF3790830284F92FEAC79FBB3FF28878A7CA59796DFD", 0.0);
  var_6 = var_5 * level.br_level.br_circleradii[1];
  var_7 = [];
  var_7[0] = level.br_circle.mapbounds[0][0] - var_6;
  var_7[1] = level.br_circle.mapbounds[0][1] - var_6;
  var_7[2] = level.br_circle.mapbounds[1][0] + var_6;
  var_7[3] = level.br_circle.mapbounds[1][1] + var_6;
  var_8 = min(var_7[0], var_7[2]);
  var_9 = max(var_7[0], var_7[2]);
  var_10 = min(var_7[1], var_7[3]);
  var_11 = max(var_7[1], var_7[3]);
  var_12 = relic_amped_play_beep();

  if(isDefined(level.br_circle.br_finalcircleoverride)) {
    var_13 = level.br_circle.br_finalcircleoverride[0];
    var_14 = level.br_circle.br_finalcircleoverride[1];
    var_15 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds((var_13, var_14, 0), 1);
    var_16 = allassassin_teamcompare((var_13, var_14, 0));
    var_17 = var_15 && istrue(level.vehicle_collision_getleveldata);
    var_18 = var_15 && !var_16;

    if(var_17 || var_18) {
      var_3 = var_13;
      var_4 = var_14;
    }
  } else if(isDefined(var_12)) {
    var_3 = var_12[0];
    var_4 = var_12[1];
  } else {
    var_19 = 8;
    var_20 = 0;

    for(var_21 = 0; var_20 < var_19; var_20++) {
      var_13 = randomfloatrange(var_8, var_9);
      var_14 = randomfloatrange(var_10, var_11);
      var_22 = (var_13, var_14, 0);

      if(vandalize_minigun_speed(var_22, 1)) {
        var_3 = var_13;
        var_4 = var_14;
        var_21 = 1;
        break;
      }

      var_8 = var_8 * 0.9;
      var_9 = var_9 * 0.9;
      var_10 = var_10 * 0.9;
      var_11 = var_11 * 0.9;
    }

    if(!var_21)
      scripts\mp\utility\script::laststand_dogtags("_encstr_846B3B42ED69D35E5167F6DB4AD8AB6F52C8BD3569736023CB66DBC7D5E6916B3F13C829823AE19CBDEFB86A69FDBBBF58A885623BE88BF2ACF27F2837" + level.mapname + "_encstr_8B1916FA4AC135329BE57D73C35DFAB82BC842BF627038C9");
  }

  var_23 = level.br_level.br_circleradii.size - 1 - level.br_level.delay_start_escort_protect_hvi_objective;
  level.br_level.default_class_chosen[var_23] = scripts\engine\utility::drop_to_ground((var_3, var_4, 4000));

  if(istrue(var_1)) {
    return;
  }
  var_24 = getdvarfloat("_encstr_8B5C18DCD839FA4CE4FAC6A59CC68DAC7DDAB03CD7CD3856B223", 200);
  var_25 = getdvarint("_encstr_B1022512A15897E286073F0F45264AE589094D1E98A04F2A5721C72F5B566254301602A231503C", 0);
  var_26 = getdvarint("_encstr_BDF61F5B966B5F86FDE93A926837FD4F2606DEC1B796BB8DFF58029B1913F75F78", 0);

  if(!var_26 && _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_9A1214D8A52736D8ACA9370BE02ADB720B3BD456DC86"))
    var_26 = 1;

  for(var_27 = var_23 - 1; var_27 >= 0; var_27--) {
    var_28 = level.br_level.default_class_chosen[var_27 + 1];
    var_29 = level.br_level.br_circleradii[var_27];
    var_30 = 0.0;
    var_31 = 1.0 - level.br_level.br_circleradii[var_27 + 1] / var_29;
    var_32 = var_30 + randomfloat(var_31 - var_30);
    var_33 = level.br_level.br_circleclosetimes[var_27];
    var_34 = level.br_level.br_circleradii[var_27 + 1];
    var_35 = var_29 - var_34;
    var_36 = var_35 / var_33;
    var_37 = max(0, var_24 - var_36);
    var_38 = var_37 * var_33;
    var_39 = var_38 / var_29;
    var_40 = var_32 > var_39;

    if(var_40 && !istrue(var_0)) {
      var_41 = var_36 + var_32 * var_29 / var_33;
      getentitylessscriptablearray("_encstr_B89123918DDBCED756EC563747F5C427BE6CD29C1B1B95AFCDE0CA5691FADD58E4CDD29BCE", ["_encstr_AF1C0DE3F9AF8B7D80E6DAE259C084", var_24, "_encstr_B88D0D19E2BBDE083F3FBFB12D6710", var_41, "_encstr_B29412FA98D31F7A0210EF30EFAB6A9715BB98B7", float(var_33), "_encstr_B2B01606102046F4F599862D2A3DC73060FF9A8EDB4BDDE0", float(var_29), "_encstr_9387138D2DC91BC6B27DCDACE11DEB4E8523A5D59B", float(var_34)]);
    }

    if(var_27) {
      if(var_25 && var_40)
        var_32 = var_30 + randomfloat(var_39 - var_30);

      level.br_level.default_class_chosen[var_27] = risk_flagspawnshiftingpercent(var_28, var_29, var_32, var_32, 1, var_26, 1);
      continue;
    }
  }

  for(var_27 = var_23 + 1; var_27 < var_23 + 1 + level.br_level.delay_start_escort_protect_hvi_objective; var_27++) {
    var_42 = level.br_level.br_circleradii[var_27 - 1];
    var_43 = level.br_level.default_class_chosen[var_27 - 1];
    var_44 = level.br_level.br_circleradii[var_27];
    var_45 = var_42 + var_44 + level.br_level.delay_start_player_weapon_fired_monitor;
    var_46 = var_42 + var_44 + level.br_level.delay_start_player_grenade_fire_monitor;
    level.br_level.default_class_chosen[var_27] = risk_flagspawnshiftingpercent(var_43, var_46, var_45 / var_46, 1.0, 1, var_26, 1);
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8F94079C2BB3B2C21B") {
    level.br_level.default_class_chosen[0] = (0, 0, 0);
    level.br_level.default_class_chosen[1] = (0, 10000, 0);
    level.br_level.default_class_chosen[2] = (-20830, 46010, -582);
  }

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AD5B19389C2BD0C28D1B6A58CC59D05A93D81BACD0599B1D2BC9DC");
  level notify("_encstr_855514074BB1B2DF6058F2BED078170A9DFDC3971566");
}

relic_amped_play_beep() {
  var_0 = (0, 0, 0);
  var_1 = [];
  var_2 = 1;
  var_3 = 0.0;

  for(;;) {
    var_4 = getdvarvector("_encstr_BD98179B6C9CBE269CEBB15AC9B163CAAF957391AF0EDBCDFA" + var_2, var_0);

    if(var_4 == var_0) {
      break;
    }

    var_5 = spawnStruct();
    var_5.pos = var_4;
    var_5.radius = getdvarfloat("_encstr_BED51E7E1EE37FF1CACFB0E853F308B39907780DF91BD79BBF03B8B8271D238F" + var_2, 0.0);
    var_6 = getdvarfloat("_encstr_990A1EB85FAAC97E2DF871B04D50B5A7B191C26FF7503013FFC47AA91F1C2C2E" + var_2, 1.0);

    if(var_6 > 0.0) {
      var_3 = var_3 + var_6;
      var_5.weight = var_3;
      var_1[var_1.size] = var_5;
    }

    var_2++;
  }

  if(!var_1.size)
    return undefined;

  var_7 = undefined;
  var_8 = getdvarint("_encstr_BEE722FF287B671AA5E8960C66AFB2E566B0132B31D39F33A71C9DC2C65B59A12820B7A3", 0);

  if(var_8) {
    var_8 = var_8 - 1;

    if(var_8 < var_1.size)
      var_7 = var_1[var_8];
  } else {
    var_9 = randomfloatrange(0.0, var_3);

    for(var_10 = 0; var_10 < var_1.size; var_10++) {
      if(var_9 < var_1[var_10].weight) {
        var_7 = var_1[var_10];
        break;
      }
    }
  }

  if(!isDefined(var_7))
    return undefined;

  if(var_7.radius > 0)
    return risk_flagspawnshiftingpercent(var_7.pos, var_7.radius, 0.0, 1.0, 1, 1, 1);
  else
    return var_7.pos;
}

_id_12E09(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AC63109843D7295D3A2C58D48963A11142F3");
  level.br_circle.safecircleent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (level.br_level.default_class_chosen[1][0], level.br_level.default_class_chosen[1][1], level.br_level.br_circleradii[1]));
  level.br_circle.safecircleent.hidden = 0;
  level.br_circle.safecircleui = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.br_circle.safecircleent.origin);
  level.br_circle.safecircleui.hidden = 0;
  level.br_circle.dangercircleent = spawnbrcircle(level.br_level.default_class_chosen[0][0], level.br_level.default_class_chosen[0][1], level.br_level.br_circleradii[0]);
  level.br_circle.dangercircleent.hidden = 0;
  level.br_circle.dangercircleent thread isblocked();
  level.br_circle.dangercircleui = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.br_circle.dangercircleent.origin);
  level.br_circle.dangercircleui.hidden = 0;
  _id_131AD(level.br_circle.safecircleent);
  spawn_carriable_at_struct();

  if(istrue(var_0) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee_params("_encstr_913C1133FB03C75D8B11220B40EBDAD3D9DEAC"))
    level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");

  if(istrue(level.usegulag))
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_13249();

  _id_13348();
  level.br_circle thread circledamagetick();
  level thread _id_138D7();

  if(isDefined(level.br_level.br_circledelaytimes)) {
    for(var_1 = 0; var_1 < level.br_level.br_circledelaytimes.size; var_1++)
      circletimer(var_1);
  }

  _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::little_bird_mg_initomnvars();
  _encstr_A5E12A9EFE03F3136CDF72683BDF091B1AE79523922A8FB022E3E9F02BA54075E3810D2EAE927BC346DF80E8::little_bird_mg_initspawning();
}

_id_138D7() {
  level notify("_encstr_BD8C1502E53FE3ABC06077B3207B616BB7F70D3FD555DA");
  level endon("_encstr_BD8C1502E53FE3ABC06077B3207B616BB7F70D3FD555DA");
  level scripts\engine\utility::waittill_any_two("_encstr_9B1D0BC7932875276230426AA1", "_encstr_AC63109843D7295D3A2C58D48963A11142F3");

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", 0);
}

relic_amped_reset_deathshield_on_revived(var_0) {
  if(!isDefined(level.br_circle))
    return -1;

  var_1 = -1;

  for(var_2 = 0; var_2 < level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective; var_2++) {
    var_3 = level.br_level.default_class_chosen[var_2];
    var_4 = level.br_level.br_circleradii[var_2];
    var_5 = distance2d(var_0, var_3);

    if(var_5 >= var_4) {
      break;
    }

    var_1 = var_2;
  }

  return var_1;
}

getmintimetillpointindangercircle(var_0) {
  if(istrue(level.br_circle_disabled))
    return 99999;

  if(!isDefined(level.br_circle))
    return -1;

  if(istrue(level.br_level._id_13884))
    return -1;

  var_1 = 0.0;

  if(level.br_circle.circleindex >= 0) {
    var_2 = level.br_circle.circleindex;
    var_3 = level.br_circle.starttime;
    var_4 = level.br_circle.dangercircleent.origin[2];
    var_5 = level.br_circle.dangercircleent.origin;

    if(var_2 >= level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective)
      var_2 = level.br_level.default_class_chosen.size - 1;
  } else {
    var_2 = 0;
    var_3 = gettime();
    var_4 = level.br_level.br_circleradii[0];
    var_5 = level.br_level.default_class_chosen[0];
  }

  var_6 = relic_amped_reset_deathshield_on_revived(var_0);

  if(var_6 < 0)
    return var_1;
  else if(var_6 < var_2)
    return var_1;
  else if(var_6 == var_2) {
    if(distance2d(var_5, var_0) > var_4)
      return var_1;
  }

  for(var_7 = var_2 + 1; var_7 < var_6; var_7++) {
    var_1 = var_1 + level.br_level.br_circleclosetimes[var_7];
    var_1 = var_1 + level.br_level.br_circledelaytimes[var_7];
  }

  var_8 = level.br_level.br_circledelaytimes[var_2];
  var_9 = level.br_level.br_circleclosetimes[var_2];
  var_10 = (gettime() - var_3) / 1000;

  if(var_6 > var_2) {
    var_11 = var_8 + var_9;
    var_1 = var_1 + (var_11 - var_10);
    var_1 = var_1 + level.br_level.br_circledelaytimes[var_6];
    var_12 = level.br_level.br_circleclosetimes[var_6];
    var_13 = level.br_level.default_class_chosen[var_6];
    var_14 = level.br_level.default_class_chosen[var_6 + 1];
    var_15 = level.br_level.br_circleradii[var_6];
    var_16 = level.br_level.br_circleradii[var_6 + 1];
  } else {
    if(var_10 < var_8) {
      var_1 = var_1 + (var_8 - var_10);
      var_12 = var_9;
    } else
      var_12 = var_9 - (var_10 - var_8);

    var_13 = var_5;
    var_14 = level.br_level.default_class_chosen[var_2 + 1];
    var_15 = var_4;
    var_16 = level.br_level.br_circleradii[var_2 + 1];
  }

  var_15 = float(var_15);
  var_16 = float(var_16);

  if(var_12 == 0)
    return var_1;

  var_17 = var_0[0];
  var_18 = var_17 * var_17;
  var_19 = var_13[0];
  var_20 = var_19 * var_19;
  var_21 = (var_14[0] - var_13[0]) / var_12;
  var_22 = var_21 * var_21;
  var_23 = var_0[1];
  var_24 = var_23 * var_23;
  var_25 = var_13[1];
  var_26 = var_25 * var_25;
  var_27 = (var_14[1] - var_13[1]) / var_12;
  var_28 = var_27 * var_27;
  var_29 = var_15;
  var_30 = var_29 * var_29;
  var_31 = (var_16 - var_15) / var_12;
  var_32 = var_31 * var_31;
  var_33 = sqrt(pow(2 * var_17 * var_21 - 2 * var_19 * var_21 + 2 * var_23 * var_27 - 2 * var_25 * var_27 + 2 * var_29 * var_31, 2) - 4 * (-1 * var_22 - var_28 + var_32) * (-1 * var_18 + 2 * var_17 * var_19 - var_20 - var_24 + 2 * var_23 * var_25 - var_26 + var_30));
  var_34 = -2 * var_17 * var_21 + 2 * var_19 * var_21 - 2 * var_23 * var_27 + 2 * var_25 * var_27 - 2 * var_29 * var_31;
  var_35 = 2 * (-1 * var_22 - var_28 + var_32);

  if(var_35 == 0.0)
    return var_1;

  var_36 = (-1 * var_33 + var_34) / var_35;
  var_37 = (var_33 + var_34) / var_35;

  if(var_36 < 0)
    var_38 = var_37;
  else if(var_37 < 0)
    var_38 = var_36;
  else
    var_38 = min(var_36, var_37);

  var_1 = var_1 + var_38;
  return var_1;
}

spawn_carriable_at_struct() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleui)) {
    return;
  }
  level.br_circle.dangercircleui.hidden++;
  level.br_circle.dangercircleent.hidden++;
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

spawn_dummy_crate() {
  level.br_circle.safecircleui.hidden++;
  level.br_circle.safecircleent.hidden++;
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

_id_13348() {
  var_0 = level.br_circle.dangercircleent.hidden || level.br_circle.dangercircleent.hidden;
  level.br_circle.dangercircleui.hidden--;
  level.br_circle.dangercircleent.hidden--;
  var_1 = level.br_circle.dangercircleui.hidden || level.br_circle.dangercircleent.hidden;

  if(var_0 && !var_1)
    level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

_id_1336F() {
  var_0 = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;
  level.br_circle.safecircleui.hidden--;
  level.br_circle.safecircleent.hidden--;
  var_1 = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;

  if(var_0 && !var_1)
    level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

_id_13322() {
  return scripts\mp\utility\game::round_vehicle_logic() == "_encstr_87A205AF50D049" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_A919041BADA2" || getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0) || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8F94079C2BB3B2C21B" || isDefined(level.disable_heli_lights) && level.disable_heli_lights._id_14291 == 3 || getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) != 0;
}

circletimer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AC63109843D7295D3A2C58D48963A11142F3");

  if(istrue(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_85DC0CB2A8BE0795B831C9C57B28", var_0))) {
    return;
  }
  level.br_circle.starttime = gettime();
  level.br_circle.circleindex = var_0;
  var_1 = var_0 == 0;
  var_2 = var_0 == level.br_level.br_circleclosetimes.size - 1;
  var_3 = level.br_level.br_circledelaytimes[var_0];
  var_4 = level.br_level.br_circleclosetimes[var_0];
  var_5 = level.br_level.br_circleradii[var_0 + 1];

  if(_id_13322())
    setomnvar("_encstr_9561115DB4EB4CC9F56C9693B136CAF5DCBADA", var_0);
  else
    setomnvar("_encstr_9561115DB4EB4CC9F56C9693B136CAF5DCBADA", var_0 + 1);

  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::circletimer(var_0);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_9B1010C65AE48D1B952A96B69593E4B2878E", var_0);
  level thread delay_play_depart_vo(var_0);
  var_6 = level.br_level.default_class_chosen[var_0 + 1];
  level.br_circle.centertarget = var_6;
  level.br_circle.safecircleent.origin = (level.br_circle.centertarget[0], level.br_circle.centertarget[1], var_5);
  level.respawnclosets = gathervalidspawnclosets(var_6, var_5);
  cleanupoutercrates();
  gatheroutercrates(var_6, var_5);
  var_7 = level.br_level.default_player_connect_black_screen[var_0];

  if(var_7 > 0) {
    spawn_carriable_at_struct();
    scripts\engine\utility::delaythread(var_7, ::_id_13348);
  }

  var_8 = level.br_level.default_suicidebomber_combat[var_0];

  if(var_8 > 0) {
    spawn_dummy_crate();
    scripts\engine\utility::delaythread(var_8, ::_id_1336F);
  }

  level thread startuiclosetimer(var_3, var_1, var_2, var_0);
  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = getdangercircleorigin() + (0, 0, getdangercircleradius());
  setstaticuicircles(var_3, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_2);

  if(get_allykilled_alias(var_0)) {
    if(var_1)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_99CB0DCCB44EB93AEB6C96C9B11B2B", 1);
    else
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_92990BE6B2BBAF6CA527D81B56", 1);
  }

  if(istrue(level.usegulag))
    level thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::transitioncircle(var_5, var_3);

  level notify("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_0 + 1);
  wait(var_3);
  level notify("_encstr_95F112120D99C0D46893093D7142F3E9E21BCFCD", var_0 + 1);
  level.group_unset_jugg_standstill = 1;
  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", gettime() + int(var_4 * 1000));

  if(get_allowed_vehicle_types_from_wave(var_0)) {
    if(var_2)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8E180DB67BCD4FDD7FA0228BB841D7", 1);
    else
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A6820FFF97DB9AAD5F1F66D06F42334847", 1);

    thread dialoguelines(var_0);
  }

  level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
  level.br_circle.dangercircleui.origin = getdangercircleorigin() + (0, 0, getdangercircleradius());
  setclosinguicircle(int(var_4), level.br_circle.safecircleent, level.br_circle.dangercircleui, var_2);
  level.br_circle.dangercircleent brcirclemoveTo(level.br_circle.centertarget[0], level.br_circle.centertarget[1], var_5, var_4);
  thread scripts\mp\music_and_dialog::defcon_alarms_stop();
  wait(var_4);

  if(_id_12C72(var_0)) {
    if(getdvarint("_encstr_8C4A1FEBB1E69F7E784F9B6FED8047A70DAE62F219B10F794007837C9F508DAB3D", 1))
      level.br_circle.dangercircleent.origin = (level.br_circle.centertarget[0], level.br_circle.centertarget[1], var_5);
  }

  var_9 = 5;

  if(var_9 > 0 && var_0 < var_9) {
    scripts\mp\rank::addglobalrankxpmultiplier(1.2, "_encstr_BDCC0CB1A5E4D86C59D4AB361DFA" + scripts\engine\utility::string(var_0));
    scripts\mp\weaponrank::addweaponrankxpmultiplier(1.2, "_encstr_BDCC0CB1A5E4D86C59D4AB361DFA" + scripts\engine\utility::string(var_0));
  }

  level.group_unset_jugg_standstill = 0;
  cleanupouterspawnclosets(var_6, var_5);
}

delay_play_depart_vo(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(var_0 > 0) {
    var_1 = var_0 - 1;
    var_2 = level.br_level.br_circleminimapradii[var_0];
    var_3 = level.br_level.br_circleminimapradii[var_1];

    if(var_2 == var_3) {
      return;
    }
    var_4 = 0.05;
    var_5 = 2;
    var_6 = var_5 / var_4;
    var_7 = int((var_3 - var_2) / var_6);
    var_8 = level.br_level.br_circleminimapradii[var_1];

    for(var_9 = 0; var_9 < var_6; var_9++) {
      var_8 = var_8 - var_7;
      setomnvar("_encstr_A5E615ABE7B176D80F0D70A8341588B769637B017FBB46", var_8);
      wait(var_4);
    }

    setomnvar("_encstr_A5E615ABE7B176D80F0D70A8341588B769637B017FBB46", level.br_level.br_circleminimapradii[var_0]);
  } else
    setomnvar("_encstr_A5E615ABE7B176D80F0D70A8341588B769637B017FBB46", level.br_level.br_circleminimapradii[var_0]);
}

cleanupouterspawnclosets(var_0, var_1) {
  var_2 = var_1 * var_1;

  if(isDefined(level.revivetriggers)) {
    foreach(var_6, var_4 in level.revivetriggers) {
      if(isDefined(var_4) && distance2dsquared(var_0, var_4.trigger.origin) > var_2) {
        var_5 = gathervalidspawnclosets(var_4.trigger.origin, var_1);

        if(isDefined(var_5) && var_5.size > 0)
          var_4.victim scripts\mp\teamrevive::relocatetrigger(var_5[0].origin);
        else
          var_4.victim scripts\mp\teamrevive::removetrigger(var_6);
      }
    }
  }
}

gathervalidspawnclosets(var_0, var_1) {
  if(isDefined(level.respawnclosets)) {
    var_2 = scripts\engine\utility::get_array_of_closest(var_0, level.respawnclosets, undefined, undefined, var_1);
    return var_2;
  }

  return undefined;
}

gatheroutercrates(var_0, var_1) {
  var_2 = var_1 * var_1;

  foreach(var_4 in level.br_pickups.crates) {
    if(isDefined(var_4) && distance2dsquared(var_0, var_4.origin) > var_2)
      level.br_pickups.outercrates[level.br_pickups.outercrates.size] = var_4;
  }
}

cleanupoutercrates() {
  foreach(var_1 in level.br_pickups.outercrates) {
    if(isDefined(var_1) && var_1.curprogress == 0)
      var_1 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
  }

  level.br_pickups.outercrates = [];
}

can_man_turret(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++)
    var_2[var_2.size] = var_0;

  return var_2;
}

can_killstreak_be_detected(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  if(!isDefined(var_3))
    var_3 = 0.0;

  if(!isDefined(var_4))
    var_4 = 0.5;

  if(!isDefined(var_5))
    var_5 = 0.1;

  if(!isDefined(var_2))
    var_2 = 0;

  var_7 = var_3 / 3 + var_4 / 2 + var_5;

  for(var_8 = 0; var_8 < var_1; var_8++) {
    if(var_2)
      var_9 = var_1 - var_8 - 1;
    else
      var_9 = var_8;

    var_10 = (var_3 * (6 * var_8 * var_8 + 6 * var_8 + 2) + 3 * var_1 * (2 * var_4 * var_8 + var_4 + 2 * var_5 * var_1)) / (6 * var_1 * var_1 * var_1);
    var_11 = var_10 / var_7;
    var_6[var_9] = var_11 * var_0;
  }

  return var_6;
}

open_teleport_room_door(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isarray(var_0))
    var_0 = [var_0];

  if(!isarray(var_1))
    var_1 = can_man_turret(var_1, var_0.size);

  if(!isarray(var_2))
    var_2 = can_man_turret(var_2, var_0.size);

  if(!isarray(var_3))
    var_3 = can_man_turret(var_3, var_0.size);

  if(!isarray(var_4))
    var_4 = can_man_turret(var_4, var_0.size);

  if(!isarray(var_5))
    var_5 = can_man_turret(var_5, var_0.size);

  var_6 = level.br_level.br_circleradii[level.br_level.br_circleradii.size - 1];
  level.br_level.br_circleradii[level.br_level.br_circleradii.size - 1] = undefined;

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_8 = level.br_level.br_circleradii.size;
    level.br_level.br_circleradii[var_8] = var_0[var_7];
    var_8 = level.br_level.br_circleclosetimes.size;
    level.br_level.br_circleclosetimes[var_8] = var_1[var_7];
    var_8 = level.br_level.br_circledelaytimes.size;
    level.br_level.br_circledelaytimes[var_8] = var_2[var_7];
    var_8 = level.br_level.br_circleminimapradii.size;
    level.br_level.br_circleminimapradii[var_8] = var_3[var_7];
    var_8 = level.br_level.default_player_connect_black_screen.size;
    level.br_level.default_player_connect_black_screen[var_8] = var_4[var_7];
    var_8 = level.br_level.default_suicidebomber_combat.size;
    level.br_level.default_suicidebomber_combat[var_8] = var_5[var_7];
  }

  level.br_level.br_circleradii[level.br_level.br_circleradii.size] = var_6;
}

last_vo_time(var_0) {
  level.br_level.br_circleradii = scripts\engine\utility::array_remove_index(level.br_level.br_circleradii, var_0);
  level.br_level.br_circleclosetimes = scripts\engine\utility::array_remove_index(level.br_level.br_circleclosetimes, var_0);
  level.br_level.br_circledelaytimes = scripts\engine\utility::array_remove_index(level.br_level.br_circledelaytimes, var_0);
  level.br_level.br_circleminimapradii = scripts\engine\utility::array_remove_index(level.br_level.br_circleminimapradii, var_0);
  level.br_level.default_player_connect_black_screen = scripts\engine\utility::array_remove_index(level.br_level.default_player_connect_black_screen, var_0);
  level.br_level.default_suicidebomber_combat = scripts\engine\utility::array_remove_index(level.br_level.default_suicidebomber_combat, var_0);
}

calculatebrbonusxp() {
  if(!getdvarint("_encstr_84A31DE356E269A6BBDF736F6352F8E0B72E285BFE5460F02233637D63BA35", 1) || _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_97CE0D72D84DC423792EE1F2C6E0F7")) {
    level.br_level.delay_start_escort_protect_hvi_objective = 0;
    return;
  }

  level.br_level.delay_start_escort_protect_hvi_objective = getdvarint("_encstr_81041B6ED8E4AF98937D5BEDCEB4B9B3D7365A27D8B156BED8BDEACD3A", 0);
  level.br_level.delay_start_player_weapon_fired_monitor = getdvarfloat("_encstr_8891233736E4FA98C97DB5B79D2D73CEFAB1D293C6D82BEB5BBDB3B2AF8C2DDCA3BED62DCD", 100);
  level.br_level.delay_start_player_grenade_fire_monitor = getdvarfloat("_encstr_8C91232646BB27D9E2F7E87BAB01909FB1EE932EDE322B26D51F3858272408EFAB19193F70", 300);
  var_0 = getdvarint("_encstr_8E4E1CB30EF3C72E5551726A205BE5EF8EE6214A969897393950FAA35089", 0);
  var_1 = level.br_level.br_circleradii.size - 1;

  switch (var_0) {
    case 1:
      if(!level.br_level.delay_start_escort_protect_hvi_objective)
        level.br_level.delay_start_escort_protect_hvi_objective = 4;

      var_2 = level.br_level.br_circleradii[var_1];
      var_3 = level.br_level.br_circleradii[var_1 - 1];
      var_4 = level.br_level.br_circleclosetimes[var_1 - 1];
      var_5 = level.br_level.br_circledelaytimes[var_1 - 1];
      var_6 = level.br_level.br_circleminimapradii[var_1 - 1];
      last_vo_time(var_1 - 1);
      var_7 = level.br_level.delay_start_escort_protect_hvi_objective;
      var_8 = getdvarvector("_encstr_91A63537B35231F60B491840C33FB8B8A10B8BAD5B3D38502BF311CBDAA3F83043743F7FD2267883C7DB2E11E28725609CFA83D1610DD0", (0, 1, 0));
      var_9 = [];
      var_10 = can_killstreak_be_detected(var_3 - var_2, var_7 + 1, 1, var_8[0], var_8[1], var_8[2]);
      var_11 = 0;

      for(var_12 = 0; var_12 < var_7; var_12++) {
        var_11 = var_11 + var_10[var_12];
        var_9[var_12] = var_3 - var_11;
      }

      var_8 = getdvarvector("_encstr_8FD533AAF0FB87F8C3F7DD80B8603E744F62F8A2B6494DF9894A7ADBFA90FE5FC79B58A82BD1D7783FC323029BA38260AB58088048", (0, 1, 0.125));
      var_13 = getdvarfloat("_encstr_878F2C272FDE1182483E951D73F8C6EA2047D7AB97097A4780A38F6209282F428DF147A75123A235D16B06EE8D48", 1.0);
      var_14 = getdvarfloat("_encstr_8FE92CB3E9BEF7169327CDC75DF05D4F70816A2B7119D781E865FDC30340299F8DDB82613B634F47B98DF1CC3370", 0.5);
      var_15 = (var_4 + var_4) * var_13;
      var_16 = can_killstreak_be_detected(var_15 * var_14, var_7, 1, var_8[0], var_8[1], var_8[2]);
      var_17 = can_killstreak_be_detected(var_15 * (1.0 - var_14), var_7, 1, var_8[0], var_8[1], var_8[2]);
      open_teleport_room_door(var_9, var_16, var_17, var_6);
      break;
    case 2:
      last_vo_time(var_1 - 1);
      level.br_level.delay_start_escort_protect_hvi_objective = 4;
      var_9 = [1200, 900, 600, 300];
      var_16 = [30, 30, 30, 30];
      var_18 = [30, 20, 10, 0];
      var_19 = [5500, 5000, 4500, 4000];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 3:
      level.br_level.delay_start_escort_protect_hvi_objective = 5;
      var_9 = [1200, 900, 600, 300];
      var_16 = [30, 30, 30, 30];
      var_18 = [30, 20, 10, 0];
      var_19 = [5500, 5000, 4500, 4000];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 4:
      last_vo_time(var_1 - 1);
      level.br_level.delay_start_escort_protect_hvi_objective = 4;
      var_20 = 1500;
      var_21 = 750 + randomint(301);
      var_22 = 1000 + randomint(301);
      var_9 = [var_20, var_20, var_21, var_22];
      var_16 = [30, 30, 30, 45];
      var_18 = [10, 5, 5, 0];
      var_19 = [5500, 5500, 5500, 5500];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 5:
      var_2 = level.br_level.br_circleradii[var_1];
      var_3 = level.br_level.br_circleradii[var_1 - 1];
      var_4 = level.br_level.br_circleclosetimes[var_1 - 1];
      var_5 = level.br_level.br_circledelaytimes[var_1 - 1];
      var_6 = level.br_level.br_circleminimapradii[var_1 - 1];
      last_vo_time(var_1 - 1);

      if(!level.br_level.delay_start_escort_protect_hvi_objective)
        level.br_level.delay_start_escort_protect_hvi_objective = 4;

      var_7 = level.br_level.delay_start_escort_protect_hvi_objective;
      var_8 = getdvarvector("_encstr_91A63537B35231F60B491840C33FB8B8A10B8BAD5B3D38502BF311CBDAA3F83043743F7FD2267883C7DB2E11E28725609CFA83D1610DD0", (0, 1, 0));
      var_9 = [];
      var_10 = can_killstreak_be_detected(var_3 - var_2, var_7 + 1, 1, var_8[0], var_8[1], var_8[2]);
      var_11 = 0;

      for(var_12 = 0; var_12 < var_7; var_12++) {
        var_11 = var_11 + var_10[var_12];
        var_9[var_12] = var_3 - var_11;
      }

      var_23 = [3000, 2000, 1000, 500];

      for(var_12 = 0; var_12 < var_7; var_12++)
        var_9[var_12] = var_9[var_12] + var_23[var_12];

      var_8 = getdvarvector("_encstr_8FD533AAF0FB87F8C3F7DD80B8603E744F62F8A2B6494DF9894A7ADBFA90FE5FC79B58A82BD1D7783FC323029BA38260AB58088048", (0, 1, 0.125));
      var_13 = getdvarfloat("_encstr_878F2C272FDE1182483E951D73F8C6EA2047D7AB97097A4780A38F6209282F428DF147A75123A235D16B06EE8D48", 1.0);
      var_14 = getdvarfloat("_encstr_8FE92CB3E9BEF7169327CDC75DF05D4F70816A2B7119D781E865FDC30340299F8DDB82613B634F47B98DF1CC3370", 0.5);
      var_15 = (var_4 + var_4) * var_13;
      var_16 = can_killstreak_be_detected(var_15 * var_14, var_7, 1, var_8[0], var_8[1], var_8[2]);
      var_17 = can_killstreak_be_detected(var_15 * (1.0 - var_14), var_7, 1, var_8[0], var_8[1], var_8[2]);
      open_teleport_room_door(var_9, var_16, var_17, var_6);
      break;
    case 6:
      level.br_level.delay_start_escort_protect_hvi_objective = 4;
      var_9 = [4200, 2200, 1300, 600];
      var_16 = [30, 30, 30, 30];
      var_18 = [30, 20, 10, 0];
      var_19 = [5500, 5000, 4500, 4000];
      open_teleport_room_door(var_9, var_16, var_18, var_19);
      break;
    case 0:
    default:
      break;
  }

  if(var_0) {
    var_24 = level.br_level.br_circleradii.size - 1;
    level.br_level.delay_start_infiltrate_objective = var_24 - var_1;
  }
}

cachedomnars() {
  var_0 = level.br_level;
  var_1 = var_0.br_circleclosetimes.size;
  var_2 = var_0.br_circleradii[var_1];

  for(var_3 = 0; var_3 < var_1 + 1; var_3++) {
    var_4 = "_encstr_B204139BC315C76A28CF13C8F337BAA1411EB86B0F" + var_3;
    var_5 = getDvar(var_4, "_encstr_B40101");

    if(var_5 == "_encstr_B40101") {
      continue;
    }
    if(var_5 == "_encstr_A25F0710622DF3B3D7") {
      for(var_6 = var_3; var_6 < var_1; var_6++) {
        var_0.br_circleradii[var_6] = undefined;
        var_0.br_circleclosetimes[var_6] = undefined;
        var_0.br_circledelaytimes[var_6] = undefined;
        var_0.br_circleminimapradii[var_6] = undefined;
        var_0.default_player_connect_black_screen[var_6] = undefined;
        var_0.default_suicidebomber_combat[var_6] = undefined;
      }

      var_0.br_circleradii[var_3] = var_2;
      var_0.br_circleradii[var_6] = undefined;
      break;
    }

    var_7 = "_encstr_9B4C023E";
    var_8 = strtok(var_5, "_encstr_964C0249");

    if(var_3 >= var_1) {
      var_9 = 6;
      gulagindex(var_8.size == var_9, "_encstr_931F073D830AFD5230" + var_4 + "_encstr_8F2806A283161F48" + var_8.size + "_encstr_B2BD13AACBF6691B2FB3D1DFBD03E333DE53081046" + var_9);

      if(var_8.size != var_9) {
        break;
      }

      var_10 = 1;

      for(var_6 = 0; var_6 < var_9; var_6++) {
        if(var_8[var_6] == var_7) {
          var_10 = 0;
          break;
        }
      }

      gulagindex(var_10, "_encstr_931F073D830AFD5230" + var_4 + "_encstr_95871399B08E48DF0392931B3A6B25107611B98960" + var_9 + "_encstr_A2440C10D98563BA56E604B9B21D");

      if(!var_10) {
        break;
      }
    }

    for(var_6 = 0; var_6 < var_8.size; var_6++) {
      var_11 = var_8[var_6];

      if(var_11 == var_7) {
        continue;
      }
      switch (var_6) {
        case 0:
          var_0.br_circleradii[var_3] = int(var_11);
          break;
        case 1:
          var_0.br_circleclosetimes[var_3] = int(var_11);
          break;
        case 2:
          var_0.br_circledelaytimes[var_3] = int(var_11);
          break;
        case 3:
          var_0.br_circleminimapradii[var_3] = int(var_11);
          break;
        case 4:
          var_0.default_player_connect_black_screen[var_3] = int(var_11);
          break;
        case 5:
          var_0.default_suicidebomber_combat[var_3] = int(var_11);
          break;
        default:
          break;
      }
    }

    if(var_3 >= var_1) {
      var_0.br_circleradii[var_3 + 1] = var_2;
      var_1++;
    }
  }
}

cacheentity() {
  calculatebrbonusxp();
  cachedomnars();
  var_0 = getdvarfloat("_encstr_84A219E356E269A6BBDF6F6373F2F9F0B7EB28B87F67D0EE623B6B", 1.0);
  var_1 = level.br_level;
  var_1.br_circleclosetimes = add_client_back_to_mask_after_delay(var_1.br_circleclosetimes, "_encstr_9B550BC636B73759D7D1A5B5CA", var_0, 0);
  var_1.br_circledelaytimes = add_client_back_to_mask_after_delay(var_1.br_circledelaytimes, "_encstr_991A0BBC6558579077602A6280", var_0, 0);
  var_1.default_player_connect_black_screen = add_client_back_to_mask_after_delay(var_1.default_player_connect_black_screen, "_encstr_9B5912E634B777D71995B185F2AF462C9B3BB24E", var_0, 1);
  var_1.default_suicidebomber_combat = add_client_back_to_mask_after_delay(var_1.default_suicidebomber_combat, "_encstr_B230108321882B87CDA9CA023288FF667893", var_0, 1);

  if(!isDefined(var_1.default_compare))
    var_1.default_compare = level.br_level.br_circleradii[0];

  cargo_truck_mg_cp_initlate();
}

add_client_back_to_mask_after_delay(var_0, var_1, var_2, var_3) {
  var_4 = getdvarfloat("_encstr_82AD0F8231C8077276F7CF9FD596DA75F9" + var_1 + "_encstr_910407D9F70A339CFF", 1.0);

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = getdvarfloat("_encstr_A90E18E66C39AF9827AF8D4BC98DD8567DEDB3CA4E39B41956D7" + var_1 + "_encstr_BA4C02DF" + var_5, -1.0);

    if(var_6 > 0 || var_6 == 0 && var_3)
      var_0[var_5] = var_6;

    var_0[var_5] = var_0[var_5] * var_2;
    var_0[var_5] = var_0[var_5] * var_4;
  }

  return var_0;
}

cargo_truck_mg_cp_initlate() {
  gulagindex(isDefined(level.br_level.br_circleclosetimes), "_encstr_88FD2F04736E8A9055B80DFF09214B2A42C59B5081A372BD3B997F66D1077F51DF1AA50B2330A8482BE1C21DD5A3A66761");
  gulagindex(isDefined(level.br_level.br_circledelaytimes), "_encstr_827D2F36AC67CAC65C26C9AF1B956795C6B83193BED89627B1D8CA22CA1B585E51B4B5B29B019B7B8E408C5699B49BB219");
  gulagindex(isDefined(level.br_level.default_player_connect_black_screen), "_encstr_8386341DB5E55A7CD008EB5750913E02B978E612307752AA81608F7F0888F7D873E1AE48159B9AC769789283180398A2DB0C34057DC9");
  gulagindex(isDefined(level.br_level.default_suicidebomber_combat), "_encstr_A188326AAAA8692A9E72CD0759C0D080302D4AA3B990D89A12680B2180EFE3E00F8D108057DF52354E20A029E02031A0780B57E4");
  gulagindex(isDefined(level.br_level.br_circleminimapradii), "_encstr_932F31E87D7335C06E9555714460BBBF6CFEC86AEF0BE0620E79D8EB6A98BC811990E56BE2DBA4A9E3C8D8060FC0CD404DF94C");
  gulagindex(isDefined(level.br_level.br_circleradii), "_encstr_827D2F36AC67CAC65C26C9AF1B956795C6B83193BED89627B1D8CA22CA1B585E51B4B5B29B019B7B8E408C5699B49BB219");
  var_0 = level.br_level.br_circleclosetimes.size;
  gulagindex(var_0 == level.br_level.br_circledelaytimes.size, "_encstr_92E02C957AE3694CF822EB271C5FEB8778026B8257F0A1DE7902B5A10DECDECBF1C7B52B4020F78370052E96C707" + var_0);
  gulagindex(var_0 == level.br_level.default_player_connect_black_screen.size, "_encstr_B87B31417AB6D51A6EAE7AC798E50B0BE352FE2B06EE2F62EA7C7AAB40720C81219946738046139995935A5788AA304AB79D72" + var_0);
  gulagindex(var_0 == level.br_level.default_suicidebomber_combat.size, "_encstr_ADAF2FC4F8639081CE41D84622A716CD288252F84749EC0327642031104FCF98F8C0E6FA0F8EAECAC1438C325B7E06AD40" + var_0);
  gulagindex(var_0 == level.br_level.br_circleminimapradii.size, "_encstr_93DC2EC65667B2365C4C9C7DD8CA3B95C6C51393D71B4B4E6CB1956A96CD96AD85C1A4B023B42D40DCA5A7CA0490F410" + var_0);
  gulagindex(var_0 == level.br_level.br_circleradii.size - 1, "_encstr_8FD82930E063EF6422B6E0410A1553A579E5C67A406F9F5A9BC029957E230BE3C2C0A032F9F6C111263D1A" + var_0);

  for(var_1 = 0; var_1 < level.br_level.default_player_connect_black_screen.size; var_1++) {
    var_2 = level.br_level.br_circledelaytimes[var_1];
    gulagindex(isDefined(var_2), "_encstr_877E2DA5CF5253A2DC271058EA1598816AB7AB38A7AA9909DF5382789B6771D3C31E91357712F9D1A1E3C008AF63E1" + var_1);
    var_3 = level.br_level.default_player_connect_black_screen[var_1];
    gulagindex(isDefined(var_3), "_encstr_8783322E8C627F05ED3370B8EA1598816AB7AB38A7AA9909DF5382789B6771D3C31E9135B2C2FF139C27E868DF54C965FA0716EF" + var_1);
    gulagindex(var_3 <= var_2, "_encstr_99C429E54DED5264C813D35F4899361A8170EE1A386F2AA28998876743B00FD07BF9B6500D9392FF117067" + var_1 + "_encstr_AF07039E3E" + var_2 + "_encstr_A21704F632E7" + var_3);
  }

  for(var_1 = 0; var_1 < level.br_level.br_circledelaytimes.size; var_1++) {
    var_2 = level.br_level.br_circledelaytimes[var_1];
    gulagindex(isDefined(var_2), "_encstr_877E2DA5CF5253A2DC271058EA1598816AB7AB38A7AA9909DF5382789B6771D3C31E91357712F9D1A1E3C008AF63E1" + var_1);
    var_3 = level.br_level.default_suicidebomber_combat[var_1];
    gulagindex(isDefined(var_3), "_encstr_B2CE30AF982A1BDC4D4413D3AA78B62FFF6C0CB8F9E4E15117CB818D8ABFDE2B334213EFEFF0CF8F78EFDC7083D99FA33D3A" + var_1);
    gulagindex(var_3 <= var_2, "_encstr_840524C62BB356D85C31E47DC6ACEC2B1B5C4C39BED8D293361B5922B21B58BCA2D2DA59CD6B" + var_1 + "_encstr_AF07039E3E" + var_2 + "_encstr_A21704F632E7" + var_3);
  }

  if(getdvarint("_encstr_84A31DE356E269A6BBDF736F6352F8E0B72E285BFE5460F02233637D63BA35", 1) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_97CE0D72D84DC423792EE1F2C6E0F7"))
    gulagindex(level.br_level.br_circleradii[0] == level.br_level.default_compare, "_encstr_B8C32A58FB875BC9E8635476EA2ADA3F184D1EE30A608F1BA73677E988A7D2FB9201487BFBBBB065939B0134");
}

gulagindex(var_0, var_1) {
  if(!var_0)
    return;
}

relic_amped_pick_random_valid_player(var_0) {
  if(!isDefined(level.br_level))
    return 0;

  if(!isDefined(level.br_level.br_circledelaytimes) || !level.br_level.br_circledelaytimes.size)
    return 0;

  var_1 = level.br_level.br_circledelaytimes.size;

  if(var_0 >= var_1)
    var_0 = var_1 - 1;

  var_2 = 0;

  for(var_3 = 0; var_3 <= var_0; var_3++) {
    var_4 = level.br_level.br_circledelaytimes[var_3];
    var_5 = level.br_level.br_circleclosetimes[var_3];
    var_2 = var_2 + var_4 + var_5;
  }

  return var_2;
}

dialoguelines(var_0) {
  var_1 = level.br_level.br_circledelaytimes[var_0] / 5;
  wait(var_1);

  foreach(var_3 in level.teamnamelist) {
    var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemies_fallback_logic(var_3);

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_6 = var_4[var_5];
      level thread maxtokensdropondeath(var_3, var_6);
    }
  }
}

maxtokensdropondeath(var_0, var_1) {
  var_2 = getsafecircleorigin();
  var_3 = getsafecircleradius();
  var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(var_0, var_1);

  if(var_4.size <= 1) {
    return;
  }
  var_5 = sortbydistance(var_4, var_2);
  var_6 = distance2dsquared(var_2, var_5[0].origin);

  if(var_6 > var_3 * var_3) {
    if(var_6 > var_3 * var_3 * 4)
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "_encstr_ADB019C7C06441BF8983D801E34F03C1EBB7B24047C8EB63336998");
    else
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "_encstr_9AA216F6899AEB372DD193950EF5C65AC936D895BEB7AB47");
  } else {
    var_7 = distance2dsquared(var_2, var_5[var_5.size - 1].origin);

    if(var_7 > var_3 * var_3)
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "_encstr_8D5F18F64C9AAF6EB4479C2B38EB6CD29C8D63ACFAD64BC35646");
    else
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_5[0], "_encstr_A9BF15F2493277D258F1524DD1C19EF76601BADA761B7B");
  }
}

init_safehouse_gunshop(var_0, var_1) {
  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start))
    level.debug_vault_assault_retrieve_saw_obj_start = [];

  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.radius = var_1;
  var_2._id_129E5 = var_1 * var_1;
  return var_2;
}

get_allykilled_alias(var_0) {
  var_1 = 1;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "_encstr_87A205AF50D049" || var_2 == "_encstr_816E079685517D0975" || var_2 == "_encstr_B18D0B5281530117EDEAC82033" || var_2 == "_encstr_A519044B436F" || getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0) || var_2 == "_encstr_8F94079C2BB3B2C21B" || isDefined(level.disable_heli_lights) && level.disable_heli_lights._id_14291 == 3 || var_2 == "_encstr_91070301C2" || getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) || _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_95F80E992D399B1D345A93B18DB295F6")) {
    if(var_0 <= 1)
      var_1 = 0;
  }

  return var_1;
}

get_allowed_vehicle_types_from_wave(var_0) {
  var_1 = 1;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(var_2 == "_encstr_8F94079C2BB3B2C21B" || var_2 == "_encstr_91070301C2" || var_2 == "_encstr_816E078685517D0975") {
    var_1 = 0;
    return var_1;
  }

  if(var_2 == "_encstr_87A205AF50D049" || var_2 == "_encstr_A519044B436F" || getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0) || isDefined(level.disable_heli_lights) && level.disable_heli_lights._id_14291 == 3 || getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) || _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_95F80E992D399B1D345A93B18DB295F6")) {
    if(var_0 == 0)
      var_1 = 0;
  }

  return var_1;
}

_id_12C72(var_0) {
  var_1 = 0;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  switch (var_2) {
    case "_encstr_A519044B436F":
    case "_encstr_A919041BADA2":
    case "_encstr_87A205AF50D049":
      if(var_0 == 0)
        var_1 = 1;

      break;
    case "_encstr_BD1D06DA5D98651B":
      if(level.disable_heli_lights._id_14291 == 3) {
        if(var_0 == 0)
          var_1 = 1;
      }

      break;
    case "_encstr_8F94079C2BB3B2C21B":
      var_1 = 1;
      break;
  }

  if(isDefined(level.obit_activation) && getdvarint("_encstr_8DE12B6E369CFA13C9AF16638E7DDAEDC8CA7D95E6B1168356D7CDB6D21CD7B473A51D96B063F5D85A4E8D8D2B", 0))
    var_1 = 1;

  if(getdvarint("_encstr_92DC2C9B20BBF092FDF8F71911D71DEFC1D088FD0F6ABBC35DF1B76F7FF9F3F8F130B29CA85750B9AE9B3B5E082F", 0) != 0 && var_0 == 0)
    var_1 = 1;

  return var_1;
}

teleport_entities_inside_subway_car(var_0) {
  setdvarifuninitialized("_encstr_97A119E251A867121697BB97AFB66A82F8589F6129D8F37A6699BF", 3);
  setdvarifuninitialized("_encstr_A70A1FFF7B8AE93EC3F191D8CB6FE1E069D3794FF337A17D97CAA906E3372FE03F", 1);
  setdvarifuninitialized("_encstr_AB661FD6B64BD7291227484B8B5BA0EBE11F45D18E530F13E1C770B9E773D901EA", 1);
  setdvarifuninitialized("_encstr_B8F526C862CAE711AB37DEC3F207186B798B88A09B29D9898B31DBD0FC37CD275F03B9F8B2FE1141", 1);
  setdvarifuninitialized("_encstr_960424DCD839EB2639F56C5A936C8DB2F5B91AB7EE7D91958D58E5F59BB06695D7B9C616D859", 1);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    setdvarifuninitialized("_encstr_818E23B98D4E7D264ED7364B3936D8ACBEB7CE5993C94BC8B2F5B1B1BD9BB27D474BDAB2BE" + var_1, -1);
    setdvarifuninitialized("_encstr_A2E3237B3835F1130AF90E6A326BD9BF294F46185AF85A3D20EF4AA1B312B71793E1DB6BDE" + var_1, -1);
    setdvarifuninitialized("_encstr_AD6A2ADC3639FAC493F51B2D9C36D8567DEDD9AC4E9CD21959F5DC86BDBBBE46B2B10B97D71985379D2B9CFA" + var_1, -1);
  }
}

init_relic_explodedmg(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 5;

  if(var_1 > var_0.size)
    var_1 = var_0.size;

  foreach(var_5, var_4 in var_0)
  var_0[var_5] = (var_4[0], var_4[1], 0.0);

  var_6 = scripts\engine\utility::array_randomize(getarraykeys(var_0));
  var_7 = [];

  for(var_8 = 0; var_8 < var_1; var_8++) {
    var_9 = spawnStruct();
    var_9.origin = var_0[var_6[var_8]];
    var_9.heli_watch_for_fly_away = [];
    var_9.radius = 0.0;
    var_7[var_7.size] = var_9;
  }

  for(var_10 = 0; var_10 < var_2; var_10++) {
    for(var_8 = 0; var_8 < var_1; var_8++)
      var_7[var_8].heli_watch_for_fly_away = [];

    foreach(var_16, var_12 in var_0) {
      var_13 = 0;
      var_14 = distance2dsquared(var_12, var_7[0].origin);

      for(var_8 = 1; var_8 < var_7.size; var_8++) {
        var_15 = distance2dsquared(var_12, var_7[var_8].origin);

        if(var_15 < var_14) {
          var_13 = var_8;
          var_14 = var_15;
        }
      }

      var_7[var_13].heli_watch_for_fly_away[var_16] = var_0[var_16];
    }

    var_17 = 0;

    foreach(var_9 in var_7) {
      if(var_9.heli_watch_for_fly_away.size == 0) {
        continue;
      }
      var_19 = (0, 0, 0);

      foreach(var_4 in var_9.heli_watch_for_fly_away)
      var_19 = var_19 + var_4;

      var_19 = var_19 / var_9.heli_watch_for_fly_away.size;

      if(var_19 != var_9.origin) {
        var_9.origin = var_19;
        var_17 = 1;
      }
    }

    if(!var_17) {
      break;
    }
  }

  return var_7;
}

relic_focusfire_modifyplayerdamage(var_0) {
  var_1 = [];

  foreach(var_3 in level.players)
  var_1[var_1.size] = var_3.origin;

  var_5 = init_relic_explodedmg(var_1, var_0);
  var_6 = var_5[0];

  foreach(var_8 in var_5) {
    if(var_8.heli_watch_for_fly_away.size > var_6.heli_watch_for_fly_away.size)
      var_6 = var_8;
  }

  return var_6.origin;
}