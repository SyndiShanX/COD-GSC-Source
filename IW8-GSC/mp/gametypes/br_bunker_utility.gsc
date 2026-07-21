/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_bunker_utility.gsc
***********************************************/

init() {
  teamrevivefiresalediscount();
  teamsplashbr();
  teamreviveperkdiscount();
  top_roof_enemy_watcher();
}

#using_animtree("_encstr_87610FB0CD966BC23A2B237DC19CBDE0DC");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

teamrevivefiresalediscount() {
  level.scr_animtree["_encstr_B6B20C25954580651B3949504263"] = #animtree;
  level.scr_anim["_encstr_B6B20C25954580651B3949504263"]["_encstr_8A900A9CA7C8F0994A2875C8"] = % _encstr_B10B1CCDAF27FBC5EB88370358A087C21BC8D4471689A20733691703F038;
  level.scr_animname["_encstr_B6B20C25954580651B3949504263"]["_encstr_8A900A9CA7C8F0994A2875C8"] = "_encstr_B10B1CCDAF27FBC5EB88370358A087C21BC8D4471689A20733691703F038";
  level.scr_anim["_encstr_B6B20C25954580651B3949504263"]["_encstr_82FD1152F8A0D3C958C95556FFC80B8B52F0DA"] = % _encstr_9B742387D1804B4DB0914E956BA0AFC26D15173F7DB5820FD8DEC51A41A0E79BC595AB93CB;
  level.scr_animname["_encstr_B6B20C25954580651B3949504263"]["_encstr_82FD1152F8A0D3C958C95556FFC80B8B52F0DA"] = "_encstr_9B742387D1804B4DB0914E956BA0AFC26D15173F7DB5820FD8DEC51A41A0E79BC595AB93CB";
}

teamsplashbr() {}

teamsassigned(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    if(var_5.script_noteworthy == "_encstr_877D10DB511F685D317120503271DE1442CB") {
      var_0.heli_anim = var_5;
      var_0.heli_anim setnonstick(1);
      continue;
    }

    if(var_5.script_noteworthy == "_encstr_994C0FEA2BE53B5F91A07F7A50995B8431") {
      var_0.heli_approach_instruct = var_5;
      var_0.heli_approach_instruct setnonstick(1);
    }
  }

  var_0.animname = "_encstr_B6B20C25954580651B3949504263";
  var_0 scripts\common\anim::setanimtree();

  if(!istrue(var_2))
    level thread teamspawnfunc(var_0, var_1);

  var_7 = anglesToForward(var_0.angles);
  var_8 = var_0.origin + (0, 0, -110) + var_7 * -128;
  var_9 = getEnt("_encstr_92FE106AF8010BC5E2D6FA976E239B4BEDDD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
  var_10.angles = var_0.angles;
  var_10 clonebrushmodeltoscriptmodel(var_9);
  var_0.battle_tracks_isbattletracksowner = var_10;
}

teamspawnfunc(var_0, var_1) {}

_id_12121(var_0, var_1, var_2, var_3) {}

_id_13619(var_0, var_1) {
  if(!isDefined(level.br_pickups)) {
    return;
  }
  var_2 = relic_bullet_reward_hud_display(var_0, var_1);
  var_3 = scripts\engine\utility::getStructArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = getdvarint("_encstr_84241CE6D839D73193AF89AB73B5ACE4A1166CD0ACEBC42BD92BFA532DCD", 0);
  var_9 = getdvarint("_encstr_9B241C83D98EC7265077B2AD3DB0AFCBAE311ABAE1F043DFA07B97AD3BD0", 1);
  var_10 = getdvarint("_encstr_8DDE1D6E369CFA13C9AF26ABCDADCA4E86C28DA1CAAF240B375A8DF59A5A9B", 1);
  var_11 = getdvarint("_encstr_93DE1DE28EA5B12A03A9D3B71818E5AB1F176EDC6557D8714B70DF17E9B1C0", 2);

  foreach(var_13 in var_3) {
    if(var_13.script_noteworthy == "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D") {
      var_4[var_4.size] = var_13;
      continue;
    }

    if(var_13.script_noteworthy == "_encstr_B4D90E9636AFD277F08057BF3029380A") {
      var_5[var_5.size] = var_13;
      continue;
    }

    if(issubstr(var_13.script_noteworthy, "_encstr_AB010F83B559B88D6A73978F8BF05550E5")) {
      var_6[var_6.size] = var_13;
      continue;
    }

    var_7[var_7.size] = var_13;
  }

  var_15 = randomintrange(var_8, var_9);
  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_5 = scripts\engine\utility::array_randomize(var_5);

  for(var_16 = 0; var_16 < var_15; var_16++) {
    if(isDefined(var_4[var_16])) {
      var_17 = easepower(var_4[var_16].script_noteworthy, var_4[var_16].origin, var_4[var_16].angles);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_17);
    }
  }

  var_15 = randomintrange(var_10, var_11);

  for(var_16 = 0; var_16 < var_15; var_16++) {
    if(isDefined(var_5[var_16])) {
      var_17 = easepower(var_5[var_16].script_noteworthy, var_5[var_16].origin, var_5[var_16].angles);
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B3A(var_17);
    }
  }

  foreach(var_24, var_13 in var_6) {
    if(isDefined(var_13.script_noteworthy)) {
      var_19 = _id_13F0B(var_13.script_noteworthy);
      var_20 = remove_reduce_recoil(var_19);
      var_21 = var_13.origin;
      var_22 = var_13.angles;

      if(var_13.script_noteworthy == "_encstr_953411EADC5AC55D2B89ED7B3A923AB2ADBE62") {
        if(level.mapname == "_encstr_ACA10F6D0F871A2DAE5887E338C10A87F3") {
          switch (var_24) {
            case 0:
              continue;
            case 1:
              var_21 = (1969, 639, 68);
              var_22 = (0, 106.6, 75);
              break;
            case 2:
              var_21 = (1962, 665, 68);
              var_22 = (0, 106.6, 75);
              break;
          }
        } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
          switch (var_24) {
            case 0:
              continue;
            case 1:
              var_21 = (-3858, 62596, 573);
              var_22 = (0, 106.6, 75);
              break;
            case 2:
              var_21 = (-3850, 62571, 573);
              var_22 = (0, 106.6, 75);
              break;
          }
        }
      }

      var_23 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_21, var_22);
      var_17 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_19, var_23, var_20, 0);

      if(isDefined(var_17))
        var_17._id_13F0A = var_13.script_noteworthy;
    }
  }

  foreach(var_13 in var_7) {
    if(isDefined(var_13.script_noteworthy)) {
      var_26 = var_13.script_noteworthy;

      if(var_13.script_noteworthy == "_encstr_8ED50D3A1FE1C719538C383AFC67A3") {
        if(getdvarint("_encstr_97831AB96CE4AF13E4F5CD8316BB9B21D5B9DA594E534B73D2D1D5CD", 1) == 0) {
          continue;
        }
        var_26 = "_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656";
      } else if(var_13.script_noteworthy == "_encstr_95D514E4C54FF2D720D82307901BAE391FD3AE9DA6E3") {
        var_27 = randomintrange(1, 100);

        if(var_27 > getdvarint("_encstr_AF43227B265A575393694369A6F04A83EDF74A69EBD88FAD5A6743CFE7F2A390A5609AD1", 60))
          continue;
        else
          var_26 = safehouse_hotjoin_func();
      }

      var_20 = remove_reduce_recoil(var_26);
      var_23 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_13.origin, var_13.angles);
      var_17 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_26, var_23, var_20, 0);
    }
  }
}

remove_reduce_recoil(var_0) {
  if(isDefined(level.br_pickups.counts[var_0]))
    return level.br_pickups.counts[var_0];
  else if(isDefined(level.br_lootiteminfo[var_0]))
    return level.br_lootiteminfo[var_0].playerstartjailsetcontrols.clipsize;
  else if(isDefined(level.br_ammo_clipsize[var_0]))
    return level.br_ammo_clipsize[var_0];

  return 1;
}

_id_13F0B(var_0) {
  switch (var_0) {
    case "_encstr_B43411FBD87BFA7731B1FFE7455CBB078BB917":
    case "_encstr_953411EADC5AC55D2B89ED7B3A923AB2ADBE62":
    default:
  }
}

safehouse_hotjoin_func() {
  var_0 = 0;
  var_1 = 0;
  var_2 = scripts\mp\utility\game::round_vehicle_logic();

  if(level.gametype == "_encstr_B607038AAB" && (var_2 == "_encstr_B607038AAB" || var_2 == "_encstr_AFDD05A6AB763B" || var_2 == "_encstr_87A205AF50D049")) {
    var_0 = 2;
    var_1 = 2;
  }

  var_3 = getdvarint("_encstr_AD521D60D6C2CF1655E190EF58D33E10400C0A15F709488A0AA5A711033883", 0);
  var_4 = getdvarint("_encstr_927E23BB768BBF265D496A52E07916AFA0EA35328E108F6D27E041A983A3969739C1B1CBAD", 0);
  var_5 = getdvarint("_encstr_8E5924D07AD2EF19933F51D81753C5733D02E840D0ECCBD0BF2DF051FF2F493FA35B19C88A82", 0);
  var_6 = getdvarint("_encstr_8862207B50AD91CB73985C47A89B03A32DB882E3A971D6C309FD6767B78367EE7F20", 0);
  var_7 = getdvarint("_encstr_A7A420CDC69CD74C4EFAD87BDBA348AE73ADB2E41AA185B9C62B7DA6D2E6D21DAEE6", 0);
  var_8 = getdvarint("_encstr_8174214F98CBD7AA7538857D1851E0A510B06FC3012021B2AFCD413C7D2F8A5C7B28B3", 0);
  var_9 = getdvarint("_encstr_8B4E2537C627F5C439F5C6DEB78E485DDC6DB2390D1A589B6C2BD7059BB92CBA1B47224EB7CDCA", 0);
  var_10 = getdvarint("_encstr_AC2023AB1EBA31FEF3A739374FBB26B84EF491038E1888A09A576777AF038E381D8219792C", 0);
  var_11 = 1 + var_3 + var_4 + var_5 + var_6 + var_7 + var_8 + var_9 + var_10;
  var_12 = randomintrange(1, var_11);

  if(var_12 <= var_3)
    return "_encstr_8EED1705B2A5C0B76359C8B0523BC6D0FA3D8BEF774EA85F03";
  else if(var_12 <= var_3 + var_4)
    return "_encstr_BAFB18C493C6F6F6D1AF9B1C56C6A58563A5B98ED7C4F673D537";
  else if(var_12 <= var_3 + var_4 + var_5)
    return "_encstr_9B2D224A1EA89FC5F1E9FA62C821BE634110D1C4B451D38E8B0823AB6029B577F96E5768";
  else if(var_12 <= var_3 + var_4 + var_5 + var_6)
    return "_encstr_84E81D13DB7CE0D743294557BB4A312EDF2F9BE0FF1B38FF6A4BC657567253";
  else if(var_12 <= var_3 + var_4 + var_5 + var_6 + var_7)
    return "_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656";
  else if(var_12 <= var_3 + var_4 + var_5 + var_6 + var_7 + var_8)
    return "_encstr_B2051D88D229076718CF1BC8120B4B839315989A0FD017FFB4FB538847A34D";
  else if(var_12 <= var_3 + var_4 + var_5 + var_6 + var_7 + var_8 + var_9)
    return "_encstr_92D11FD25BF8E8083D47EF1FB0A09B2C4AFBF99F59314FEF419F5A5BEF72503771";
  else
    return "_encstr_85C61EB6FA3B604F8B69F8E072A52F5B2B954FBA7FBF68BDB642B049CBBFCB70";
}

relic_bullet_reward_hud_display(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2)) {
    if(var_2.size == 1)
      return var_2[0];
    else {
      var_3 = undefined;
      var_4 = undefined;

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        var_6 = distance2dsquared(var_0, var_2[var_5].origin);

        if(!isDefined(var_4) || var_6 < var_4) {
          var_4 = var_6;
          var_3 = var_2[var_5];
        }
      }

      return var_3;
    }
  }

  return undefined;
}

binoculars_endadslogic(var_0) {
  if(tv_station_marker_player_connect_monitor(var_0.angles[1], 106, 1)) {
    var_1 = anglesToForward(var_0.angles);
    return [var_0.origin + var_1 * 30, (var_0.angles[0], 106, 90)];
  } else if(tv_station_marker_player_connect_monitor(var_0.angles[1], 90, 1)) {
    var_1 = anglesToForward(var_0.angles);
    return [var_0.origin - var_1 * 10, var_0.angles];
  } else if(tv_station_marker_player_connect_monitor(var_0.angles[1], 70, 1))
    return [var_0.origin, (var_0.angles[0], var_0.angles[1], 0)];

  return [var_0.origin, var_0.angles];
}

tv_station_marker_player_connect_monitor(var_0, var_1, var_2) {
  return abs(var_0 - var_1) <= var_2;
}

loadout_given() {
  little_bird_mg_playercontrolmg((-17923, -42192, -252));
  little_bird_mg_playercontrolmg((-15045, 45467, -186));
  little_bird_mg_playercontrolmg((1992, 38955, 1378));
  little_bird_mg_playercontrolmg((49764, 34322, 206));
  little_bird_mg_playercontrolmg((52510, -32696, -119));
  little_bird_mg_playercontrolmg((47158, -10562, 131));
  little_bird_mg_playercontrolmg((-39282, -2005, -78));
  little_bird_mg_playercontrolmg((41919, -41349, -580));
  little_bird_mg_playercontrolmg((-38426, -19360, 403));
  little_bird_mg_playercontrolmg((21085, 16700, 246));
  little_bird_mg_playercontrolmg((17893, -34039, -561));
}

little_bird_mg_onenterheavydamagestate() {
  little_bird_mg_playercontrolmg((-4337, 62466, 580));
}

little_bird_mg_playercontrolmg(var_0, var_1) {
  var_2 = 2000;

  if(!isDefined(var_1))
    var_1 = var_2;

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::little_bird_mg_playercontrolmg(var_0, var_1, 100);
}

teamreviveperkdiscount() {
  level.flaglockedtimer = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_8D3F130E63DAEF99425730109F631627B288FF07BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_3 = easepower("_encstr_AD4B1FD60B380D5AE68EBEB5955E1C16C8EBC4D5E6D659E4FA5A378EAC9C4BBD27", var_2.origin);
    var_3.chopper_glow_sticks = 1;

    if(isDefined(var_2.script_noteworthy)) {
      var_3.flagpickupchecks = int(var_2.script_noteworthy);
      level.flaglockedtimer[var_3.flagpickupchecks] = var_3;
    }
  }
}

vehicleparent(var_0, var_1, var_2, var_3, var_4) {
  level thread allies_spawn_function(var_0, var_1, var_2, var_3, var_4);
}

allies_spawn_function(var_0, var_1, var_2, var_3, var_4) {
  var_0 setscriptablepartstate(var_1, "_encstr_BA19049F4B2D");

  if(isDefined(var_0.ks_killleaders))
    level thread vehicleaniminit(var_0, var_1);

  var_3 vehiclelinkTo(var_0);

  if(isDefined(var_3))
    var_3 _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12685(0);

  wait 1;

  if(!isDefined(var_0.ks_killleaders) && !(istrue(var_0.opened) && istrue(var_0.little_bird_mg_initoccupancy)))
    var_0 setscriptablepartstate(var_1, "_encstr_AB0703DBB9");
}

vehiclelinkTo(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A78C1F6D952F835846D76D968DB605B12C5E959C8C9CF6AD5A56E50E2C8CD49A74");
  thread vehicle_watchmarkedtankdeath(var_0);
  thread vehiclegod(var_0);
  thread vehicleindangertracking(var_0);
  _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12685(1);
  var_1 = 8;

  if(isDefined(var_0.helihint_activate_vo))
    var_1 = var_0.helihint_activate_vo;

  _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12683(var_1);
  _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12684([0]);

  if(istrue(var_0.helihint_wait) && var_0.helihint_activate_vo <= 5)
    _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12684(var_0.helidrivablemission["_encstr_91B606B0E49C0B5E"]);

  while(isDefined(self) && _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::removedeathicon() != 0) {
    self waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_2, var_3);

    if(isDefined(var_2)) {
      if(var_2 == "_encstr_9AEB110B93682527BD66B2BB4E1A2F98502394") {
        if(getdvarint("_encstr_82032F1F11A0DFF3A3E12E4DD0A48D6547E77FA1914A3C2F43F530C0CD28F0790245EABB2FAB09C0D54B405ABA6E2B7398", 0))
          thread vehicleindangertracking(var_0);

        if(isDefined(var_0.helidrivablemission) && tv_station_reinforcement_spawn_logic(var_0, var_3)) {
          _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12685(2);
          var_0.helileave = 2;

          if(isDefined(var_0._id_1395D))
            [[var_0._id_1395D]](var_0);

          break;
        } else {
          if(soundexists("_encstr_B63B0FC493FADACABC381619BE19ACB9F2"))
            playsoundatpos(self.origin, "_encstr_B63B0FC493FADACABC381619BE19ACB9F2");

          var_0.helileave = 3;
          _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12685(3);
          waitframe();

          if(isDefined(self))
            _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12685(1);
        }

        continue;
      }

      if(var_2 == "_encstr_81110FCA584B8BEFC1BEDF13DD4A9B1689") {
        var_0.helileave = 3;

        if(isDefined(var_0.ks_killleaders))
          level notify(var_0.ks_killleaders);

        break;
      }
    }
  }

  _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12684([0]);
  self notify("_encstr_A6B20F85E0CB073C20A9F0B83DAB900761");
}

vehicle_watchmarkedtankdeath(var_0) {
  self endon("_encstr_A78C1F6D952F835846D76D968DB605B12C5E959C8C9CF6AD5A56E50E2C8CD49A74");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0.ks_killleaders))
    level notify(var_0.ks_killleaders);

  _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12684([0]);
  self notify("_encstr_A78C1F6D952F835846D76D968DB605B12C5E959C8C9CF6AD5A56E50E2C8CD49A74");
}

vehiclegod(var_0) {
  self endon("_encstr_A78C1F6D952F835846D76D968DB605B12C5E959C8C9CF6AD5A56E50E2C8CD49A74");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(isDefined(var_0.ks_killleaders))
    level notify(var_0.ks_killleaders);

  _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12684([0]);
  self notify("_encstr_A78C1F6D952F835846D76D968DB605B12C5E959C8C9CF6AD5A56E50E2C8CD49A74");
}

vehicleindangertracking(var_0) {
  self endon("_encstr_A78C1F6D952F835846D76D968DB605B12C5E959C8C9CF6AD5A56E50E2C8CD49A74");
  self notify("_encstr_B8491707631BA3C1B87E929D51B80D7BEB8983B7BF4FABBB80");
  self endon("_encstr_B8491707631BA3C1B87E929D51B80D7BEB8983B7BF4FABBB80");
  wait(getdvarint("_encstr_8D9520B9364E7D984ED726EADC5B95C9FAB659971C16237D4BC83656AF475AB6AC39", 60));

  if(isDefined(var_0.ks_killleaders))
    level notify(var_0.ks_killleaders);

  _encstr_82372827A322F08F639B40309336CC783D3DA1CB584F987853E346F82A877F2017AF3B59F9753A94CFEA::_id_12684([0]);
  self notify("_encstr_A78C1F6D952F835846D76D968DB605B12C5E959C8C9CF6AD5A56E50E2C8CD49A74");
}

vehicleaniminit(var_0, var_1) {
  if(isDefined(var_0.ks_killleaders))
    level waittill(var_0.ks_killleaders);

  var_0 setscriptablepartstate(var_1, "_encstr_AB0703DBB9");
}

tv_station_reinforcement_spawn_logic(var_0, var_1) {
  if(!isDefined(var_0.helidrivablemission["_encstr_A1D80717112333A5D4"]))
    return 0;

  if(var_1 == -1)
    return 0;

  var_2 = int(var_0.helidrivablemission["_encstr_A1D80717112333A5D4"]);

  if(var_1 == var_2)
    return 1;

  return 0;
}

pre_laserpanel_weapon(var_0, var_1) {
  var_2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_2 = scripts\engine\utility::array_randomize(var_2);
    var_1.helidrivablemission[var_3] = var_2[0];
    var_2 = scripts\engine\utility::array_remove(var_2, var_2[0]);
  }
}

pre_get_in_anim_wait(var_0, var_1, var_2, var_3) {
  var_4 = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var_1.helidrivablemission = [];

  if(!isDefined(var_2))
    var_2 = 0;
  else
    var_1.helidrivablemission["_encstr_B49208B1CAEF0650775B"] = [];

  if(!isDefined(var_3))
    var_3 = 0;
  else
    var_1.helidrivablemission["_encstr_850108A3934B1CD82BCD"] = [];

  var_5 = var_0 - var_2 - var_3 * 2;
  var_6 = scripts\engine\utility::array_randomize(var_4);
  var_4 = [];
  var_7 = randomintrange(1, 9);

  foreach(var_10, var_9 in var_6) {
    if(var_10 == var_7) {
      var_4[var_4.size] = 0;
      continue;
    }

    var_4[var_4.size] = var_9;
  }

  for(var_11 = 0; var_11 < var_5; var_11++)
    var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"][var_11] = var_4[var_11];

  var_12 = var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"];

  for(var_11 = 0; var_11 < var_2; var_11++) {
    var_13 = var_12[var_11];
    var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"][var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"].size] = var_13;
    var_1.helidrivablemission["_encstr_B49208B1CAEF0650775B"][var_1.helidrivablemission["_encstr_B49208B1CAEF0650775B"].size] = var_13;
    var_12 = scripts\engine\utility::array_remove(var_12, var_12[var_11]);
  }

  for(var_11 = 0; var_11 < var_3; var_11++) {
    var_14 = var_12[var_11];

    for(var_15 = 0; var_15 < 2; var_15++)
      var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"][var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"].size] = var_14;

    var_1.helidrivablemission["_encstr_850108A3934B1CD82BCD"][var_1.helidrivablemission["_encstr_850108A3934B1CD82BCD"].size] = var_14;
    var_12 = scripts\engine\utility::array_remove(var_12, var_12[var_11]);
  }

  var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"] = scripts\engine\utility::array_randomize(var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"]);
  var_1.helidrivablemission["_encstr_A1D80717112333A5D4"] = "_encstr_B40101";

  foreach(var_9 in var_1.helidrivablemission["_encstr_91B606B0E49C0B5E"]) {
    var_17 = "_encstr_B40101" + var_9;
    var_1.helidrivablemission["_encstr_A1D80717112333A5D4"] = var_1.helidrivablemission["_encstr_A1D80717112333A5D4"] + var_17;
  }
}

ppkteamwithflag(var_0, var_1, var_2, var_3) {
  if(var_2 > var_0["_encstr_B49208B1CAEF0650775B"].size)
    var_2 = 0;

  if(var_3 > var_0["_encstr_850108A3934B1CD82BCD"].size)
    var_3 = 0;

  var_4 = 0;
  var_5 = 0;
  var_6 = scripts\engine\utility::array_randomize(scripts\engine\utility::array_remove_duplicates(var_0["_encstr_91B606B0E49C0B5E"]));
  var_7 = [];

  for(var_8 = 0; var_8 < var_1; var_8++) {
    if(var_4 < var_2) {
      var_9 = var_0["_encstr_B49208B1CAEF0650775B"][var_4];
      var_4++;
    } else if(var_5 < var_3) {
      var_9 = var_0["_encstr_850108A3934B1CD82BCD"][var_5];
      var_5++;
    } else
      var_9 = var_6[0];

    var_7[var_9] = var_8 + 1;
    var_6 = scripts\engine\utility::array_remove(var_6, var_9);
  }

  var_10 = [];
  var_11 = getarraykeys(var_7);

  foreach(var_19, var_13 in var_11) {
    var_10[var_19] = var_0["_encstr_91B606B0E49C0B5E"];
    var_14 = 0;

    foreach(var_18, var_16 in var_10[var_19]) {
      if(var_16 == var_13 && var_14) {
        var_10[var_19][var_18] = "_encstr_BA96070FF3B82290F4" + var_7[var_13];
        var_17 = 1;
        continue;
      }

      if(var_16 == var_13 && !var_14) {
        var_14 = 1;
        continue;
      }

      if(scripts\engine\utility::array_contains(var_11, var_16))
        var_10[var_19][var_18] = "_encstr_BA96070FF3B82290F4" + var_7[var_16];
    }
  }

  return var_10;
}

cargo_truck_mg_getspawnstructscallback(var_0, var_1) {
  var_0 = scripts\engine\utility::array_randomize(var_0);

  foreach(var_4, var_3 in var_0) {
    if(var_4 > var_1.size)
      var_4 = 0;

    var_3.scriptable.logplayermatchend = var_4;
  }
}

relic_dogtags(var_0, var_1) {
  return var_0.logplayermatchstart[var_1];
}

_id_119A3(var_0) {
  if(isDefined(var_0.doors)) {
    foreach(var_2 in var_0.doors)
    var_2 scriptabledoorfreeze(1);
  }
}

_id_13F1E(var_0) {
  if(isDefined(var_0.doors)) {
    foreach(var_2 in var_0.doors)
    var_2 scriptabledoorfreeze(0);
  }
}

_id_1212E(var_0, var_1) {
  foreach(var_3 in var_0.doors)
  var_3 constraintoscriptgoalRadius("_encstr_A2840585EE16CB", var_0.origin);

  if(istrue(var_1)) {
    wait 1;
    _id_119A3(var_0);
  }
}

heli_screenshake(var_0, var_1) {
  foreach(var_3 in var_0.doors)
  var_3 vehicle_getinputvalue(1);

  if(istrue(var_1)) {
    var_5 = 0;

    while(!var_5) {
      var_6 = 0;

      foreach(var_3 in var_0.doors) {
        if(!var_3 scriptabledoorisclosed())
          var_6 = 1;
      }

      if(!var_6)
        var_5 = 1;

      waitframe();
    }

    _id_119A3(var_0);
  }
}

top_roof_enemy_watcher() {
  level.max_pt = getdvarint("_encstr_962E0B7225E9A6C4969A53152A", 0) > 0;
  scripts\mp\gamelogic::_id_12C4C(9);
  level.max_extra_enemies = getEnt("_encstr_81A80E6B3128C3B29D326BF74AA1D85A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}

_id_12F70(var_0) {
  foreach(var_2 in var_0)
  var_2 thread _id_12F6F();

  var_4 = 0;

  for(;;) {
    var_4 = 1;

    foreach(var_2 in var_0) {
      if(var_2 _id_12F75()) {
        var_4 = 0;
        break;
      }
    }

    if(var_4) {
      break;
    }

    waitframe();
  }

  return 1;
}

_id_12F71(var_0) {
  foreach(var_2 in var_0)
  var_2 _id_12F72();
}

_id_12F6F() {
  self endon("_encstr_A95F0C19B7ED4EBE3663D759E691");

  if(istrue(self.max_dist_sq_from_node)) {
    return;
  }
  self.max_dist_sq_from_node = 1;
  var_0 = combineangles(self.angles, (0, -1 * self scriptabledoorangle(), 0));
  var_1 = self.origin;
  var_2 = anglesToForward(var_0);
  var_3 = anglestoup(self.angles);
  var_4 = 28.0;
  var_5 = 48.0;
  var_1 = var_1 + var_2 * var_4;
  var_1 = var_1 + var_3 * var_5;
  var_6 = sqrt(pow(28.0, 2) + pow(48.0, 2)) + 20;
  var_7 = var_1 + var_3 * 128 * -0.5;
  var_8 = combineangles(var_0, (0, -90, 0));

  if(1 && isDefined(level.max_extra_enemies)) {
    var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
    var_9 clonebrushmodeltoscriptmodel(level.max_extra_enemies);
    var_9.origin = var_7;
    var_9.angles = var_8;
    self.max_groups_per_player = var_9;
  }

  self.max_projectile_check = [];

  while(!self scriptabledoorisclosed()) {
    self vehicle_getinputvalue();

    if(1) {
      var_10 = scripts\mp\utility\player::getplayersinradius(var_1, var_6);

      foreach(var_12 in var_10) {
        var_13 = var_12 getentitynumber();

        if(!var_12 scripts\cp_mp\utility\player_utility::_isalive()) {
          self.max_projectile_check[var_13] = undefined;
          continue;
        }

        if(!isDefined(self.max_projectile_check[var_13])) {
          var_12 _id_12F73(1);
          self.max_projectile_check[var_13] = var_12;
        }
      }

      foreach(var_13, var_12 in self.max_projectile_check) {
        if(!isDefined(var_12) || !var_12 scripts\cp_mp\utility\player_utility::_isalive()) {
          self.max_projectile_check[var_13] = undefined;
          continue;
        }

        var_16 = 1;

        foreach(var_18 in var_10) {
          if(var_18 == var_12) {
            var_16 = 0;
            break;
          }
        }

        if(var_16) {
          var_12 _id_12F73(0);
          self.max_projectile_check[var_13] = undefined;
        }
      }
    }

    waitframe();
  }

  self scriptabledoorfreeze();
  thread _id_12F72();
}

_id_12F72() {
  self notify("_encstr_A95F0C19B7ED4EBE3663D759E691");
  self.max_dist_sq_from_node = undefined;

  if(isDefined(self.max_groups_per_player)) {
    self.max_groups_per_player delete();
    self.max_groups_per_player = undefined;
  }

  if(isDefined(self.max_projectile_check)) {
    foreach(var_1 in self.max_projectile_check) {
      if(!isDefined(var_1) || !var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      var_1 _id_12F73(0);
    }
  }

  self.max_projectile_check = undefined;
}

_id_12F73(var_0) {
  scripts\common\utility::allow_melee(!var_0, "_encstr_84B408C87BDEE4AF8D1B");
  scripts\common\utility::allow_usability(!var_0, "_encstr_84B408C87BDEE4AF8D1B");
}

_id_12F75() {
  return istrue(self.max_dist_sq_from_node);
}

_id_12F74() {
  return istrue(level.max_pt);
}

hitsperattackforvehicle(var_0) {
  playsoundatpos(var_0.origin, "_encstr_8F2511B08E993F07E9AB580B88CD17CA728529");
  var_0 setscriptablepartstate(var_0.type, "_encstr_BA19049F4B2D");
  wait 3;
  var_0 setscriptablepartstate(var_0.type, "_encstr_AB0703DBB9");
}