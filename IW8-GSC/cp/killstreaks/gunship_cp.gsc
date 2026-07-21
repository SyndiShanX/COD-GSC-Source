/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\gunship_cp.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_BA150EC95C66282EE2FBA7E38B7BF5C0", ::gunship_findboxcenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_AD2610CABAF523255B9BB2E034139702403B", ::gunship_getbombingpoints);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_BD3E0B4CE4AF9C95E60E2CDD37", ::gunship_startbrrespawn);

  if(!scripts\cp\utility::tryingtoleave())
    scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222", ::gunship_assigntargetmarkers);
}

gunship_findboxcenter(var_0, var_1) {
  return scripts\cp\cp_globallogic::findboxcenter(var_0, var_1);
}

gunship_getbombingpoints(var_0, var_1, var_2) {
  var_3 = [];
  var_0 = var_0 - anglesToForward(self.angles) * 100;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_5 = randomint(var_2);
    var_6 = randomint(360);
    var_7 = var_0[0] + var_5 * cos(var_6);
    var_8 = var_0[1] + var_5 * sin(var_6);
    var_9 = var_0[2];
    var_10 = (var_7, var_8, var_9);
    var_11 = scripts\engine\trace::ray_trace(var_10 + (0, 0, 2000), var_10 - (0, 0, 10000), level.players);

    if(isDefined(var_11["_encstr_BD260953AA97E3F014279D"]))
      var_10 = var_11["_encstr_BD260953AA97E3F014279D"];

    var_3[var_3.size] = var_10;
  }

  return var_3;
}

gunship_startbrrespawn(var_0) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!istrue(var_0.fauxdead))
      var_0.shouldskiplaststand = 0;
  }
}

gunship_assigntargetmarkers(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08");
  var_5 = level.players;
  var_6 = [];

  if(isDefined(level.vo_paratroopers)) {
    foreach(var_8 in level.vo_paratroopers)
    var_6 = scripts\engine\utility::array_add(var_6, var_8);
  }

  var_3 = scripts\engine\utility::array_combine(var_6, var_4, var_5);

  foreach(var_11 in var_3) {
    if(level.teambased && var_11.team == self.team) {
      continue;
    }
    if(var_11 == self.owner) {
      continue;
    }
    if(var_11 scripts\cp\utility::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
      continue;
    }
    var_1[var_1.size] = var_11;
  }

  foreach(var_14 in var_5) {
    if(level.teambased && var_14.team != self.team) {
      continue;
    }
    var_2[var_2.size] = var_14;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_85041AA3432B9CDA0BB13BB437A57B73AC73CA6B5E91AC33C25D8DA3", self.owner, var_1, self.owner, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", self.owner, var_2, self.owner, 1, 1);
  level thread set_trap_flag(self.enemytargetmarkergroup, 0);
}

set_trap_flag(var_0, var_1) {
  level endon("_encstr_BD710C3A61F9C78170BD0C15B182");
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_0);

  for(;;) {
    level waittill("_encstr_A3DD1637382CEEDC56C8EBEC27DEAB83AFCD7B63C84B569C", var_2);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_2, var_0, var_1);
  }
}

notcanon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!istrue(var_5)) {
    if(isDefined(var_0) && (isint(var_0) || isfloat(var_0)))
      wait(var_0);

    if(isDefined(var_1) && isstring(var_1))
      level waittill(var_1);
  }

  var_6 = randomint(360);
  var_7 = 15000;

  if(isDefined(var_3))
    var_7 = var_3;

  var_8 = cos(var_6) * var_7;
  var_9 = sin(var_6) * var_7;
  var_10 = 8000;

  if(isDefined(var_4))
    var_10 = var_4;

  var_11 = vectorNormalize((var_8, var_9, var_10));
  var_11 = var_11 * var_10;
  var_12 = "_encstr_8C1724D3C333875F90D8F531F198BA491F6733079569DA5DAA6BFA09ABC0F1B261878F7F3F8D";
  var_13 = level.gunship.origin;

  if(isDefined(var_2) && isvector(var_2)) {
    var_13 = var_2;
    level.gunship.origin = var_2;
  }

  var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_13);
  var_14 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_14.team = "_encstr_8E8405EA382B2A";
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_13);
  var_15 setModel(var_12);
  var_15 setCanDamage(1);
  var_15.currenthealth = 1000;
  var_15.maxhealth = var_15.currenthealth;
  var_15.health = 9999999;
  var_15.owner = var_14;
  var_15.timeout = 6669;
  var_15.currentdamagestate = 0;
  var_15.team = "_encstr_8E8405EA382B2A";
  var_15._id_11FB4 = 2;
  var_15.flaresreservecount = 2;
  var_15 scriptmoveroutline();
  var_15 scriptmoverthermal();
  var_16 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_16 = var_15[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]]("_encstr_A26F161C306860B15F6053C34D33BBA17A2DBA6048E1B3B7", var_15.team, 1, 1, 1);

  if(isDefined(var_16))
    objective_setshowoncompass(var_16, 1);

  var_15.minimapid = var_16;
  var_14 linkTo(level.gunship, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_15 linkTo(level.gunship, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_11, (0, var_6 + 90, -30));
  var_14.pers = [];
  var_15.streakinfo = var_14 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_86FD08B775CD07DC1338", var_14);
  var_15 thread notify_planter_on_damage();
  var_15 thread scripts\cp_mp\killstreaks\gunship::set_up_coop_push(undefined);

  if(level.script == "_encstr_86A90F8D07AF0B4EB6E67DC82B2C36AC39")
    var_15 thread notify_when_loadout_given(undefined, 1);
  else
    var_15 thread notify_when_loadout_given(undefined);

  var_15 thread scripts\cp_mp\killstreaks\gunship::gunship_linklightfxent();
  var_15 thread scripts\cp_mp\killstreaks\gunship::gunship_linkwingfxents();
  var_15 thread scripts\cp_mp\killstreaks\gunship::gunship_trackvelocity();
  var_15 thread scripts\cp\cp_flares::flares_monitor(var_15.flaresreservecount);
  var_15 thread notifyteamonvehicledeath();
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_15);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4"))
    var_15 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4")]](::nostand);

  var_15 playLoopSound("_encstr_9AD91096EE07AFD6B9F5166C896603AF3683");
}

_id_123E4() {
  var_0 = "_encstr_8BA0197BF070A7311F7BCDC55E19DB6D3978FF3F68CB16BB7103D2";
  var_1 = self;
  var_2 = var_1;
  var_3 = var_2 scripts\cp\vehicles\little_bird_mg_cp::fx_model(var_0);
  var_4 = var_2 scripts\cp\vehicles\little_bird_mg_cp::fx_obj(var_0);
  var_5 = soundexists(var_3);
  var_6 = soundexists(var_4);
  var_7 = scripts\cp\vehicles\little_bird_mg_cp::fx_thermal(var_5, var_3, var_6, var_4);
  var_8 = 1;

  if(istrue(var_8)) {
    var_9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](self.team, 1);

    foreach(var_11 in var_9) {
      if(var_2 == var_11) {
        if(var_5)
          var_2 playsoundtoplayer(var_3, var_11);

        continue;
      }

      if(var_6)
        var_2 playsoundtoplayer(var_4, var_11);
    }
  }
}

notify_when_loadout_given(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");

  if(istrue(var_1)) {
    for(;;) {
      level waittill("_encstr_8D8D174803C98FFDF972B780F3FF207BF2310FBDA1C3B4F0AF");

      if(istrue(level.computer_debugtestloop)) {
        continue;
      }
      break;
    }
  } else
    level waittill("_encstr_8D8D174803C98FFDF972B780F3FF207BF2310FBDA1C3B4F0AF");

  thread scripts\cp_mp\killstreaks\gunship::gunship_leave(var_0);
}

notify_planter_on_damage(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 8192);
  self setCanDamage(1);

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(level.teambased) && isPlayer(var_2) && var_2.team == self.team) {
      continue;
    }
    if(var_5 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_5 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_5 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5") {
      continue;
    }
    if(isPlayer(var_2)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_A2FB098A2035874AB0F358");
    }

    thread _id_12DF8(7);
    self.wasdamaged = 1;
    var_11 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2"))
      var_11 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2")]](var_2, var_10, var_5, var_1, self.maxhealth, 4, 5, 6);

    self.damagetaken = self.damagetaken + var_11;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(self.currenthealth <= 500 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
    } else if(self.currenthealth <= 250 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_BA19049F4B2D");
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
    } else if(self.currenthealth <= 0 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_BA19049F4B2D");
      self setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_BA19049F4B2D");
      thread scripts\cp_mp\killstreaks\gunship::gunship_startengineblowoutfx();
    }

    if(self.damagetaken >= self.maxhealth) {
      var_12 = self.streakinfo.streakname;
      var_13 = undefined;
      var_14 = "_encstr_ACB80B32E13893EAC81A9F1209" + var_12;
      var_15 = undefined;
      var_16 = "_encstr_A76B138D2C1B36EDEA477D19959B1D4E7B97B223F5" + var_12;
      var_17 = 1;

      if(isPlayer(var_2)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
          thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_16, var_2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24"))
        var_18 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24")]](var_12, var_2, var_10, var_13, var_1, var_14, var_15, var_16, var_17);

      self.owner delete();
      level.little_bird_mg_mp_init = 1;
      thread scripts\cp\cp_relics::_id_137A2(1);
      thread scripts\cp_mp\killstreaks\gunship::gunship_crash(8, var_0);
    }
  }
}

_id_12DF8(var_0) {
  self notify("_encstr_A2F1168DBF8AC0E80D628BC3CFD33003326B5F29BF629320");
  self endon("_encstr_A2F1168DBF8AC0E80D628BC3CFD33003326B5F29BF629320");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self._id_139B7 = 1;
  childthread removesuppressioneffectsaftertimeout(var_0);
}

removesuppressioneffectsaftertimeout(var_0) {
  self notify("_encstr_8634251318EBF5F389B66D603FB3673A3F804A4AB145EFF7210D5349DC5B2F0229289272780BA3");
  self endon("_encstr_8634251318EBF5F389B66D603FB3673A3F804A4AB145EFF7210D5349DC5B2F0229289272780BA3");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  self._id_139B7 = undefined;
}

nostand(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_8B670FAEBFBD03705FE9ADCEC95BBE3BA6")]](var_2);

      var_2 scripts\cp_mp\killstreaks\gunship::gunship_playflaresfx(var_3);

      if(isDefined(var_2.owner) && isPlayer(var_2.owner))
        var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_BD270FB10BE3EE101438FFF55C7E88BDCF", 1);

      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB"))
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB")]]();

      self missile_settargetEnt(var_6);
      self notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      return;
    } else if(var_5 < 300 && var_2.flaresreservecount <= 0) {
      var_2 thread scripts\cp_mp\killstreaks\gunship::gunship_playfakebodyexplosion();
      var_7 = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner) && isPlayer(self.owner))
        var_2 dodamage(var_7, self.owner.origin, self.owner, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self.weapon_name);
      else
        var_2 dodamage(var_7, var_2.origin, undefined, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self.weapon_name);

      self delete();
    }

    waitframe();
  }
}

gunship_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_ABE8153B38058B547B038EEDCCAF1B3AA993BFC5ED6682");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

gunship_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

notifyteamonvehicledeath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(level.teambased && var_3.team == self.team) {
        continue;
      }
      if(istrue(var_3.respawn_in_progress)) {
        continue;
      }
      if(istrue(var_3.inlaststand)) {
        continue;
      }
      if(var_3 isskydiving()) {
        continue;
      }
      if(isDefined(var_3.vehicle) && isent(var_3.vehicle)) {} else if(var_3 scripts\cp\utility::is_indoors(var_3))
        continue;
      else if(!sighttracepassed(self.origin, var_3.origin, 0, undefined, 1)) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
        if(var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7") || var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_990810B8796F28FB0B6193B21770B42573B3")) {
          if(var_3._id_1389A <= 3.0) {
            var_3._id_1389A = var_3._id_1389A + 0.05;
            continue;
          } else
            var_3._id_1389A = 0.0;
        }
      }

      var_1 = nospectatablepropswatch(var_3);
      break;
      wait 0.05;
    }

    if(var_1.size > 0 && var_1.size < 2) {
      foreach(var_6 in var_1) {
        if(isPlayer(var_6)) {
          var_6 thread _id_123E4();
          thread nopropsspectate(var_6);
          var_6 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AF6F17FC3DAA975488A1010BA0B58CB181C016A932A39B2DC9");
          self notify("_encstr_99FD1DEF9B4043AA93C167DFD948029C2141E73633B027A2F8FFA7DB23605A");
        }
      }
    } else if(var_1.size >= 2) {
      foreach(var_6 in var_1) {
        if(isPlayer(var_6)) {
          thread nopropsspectate(var_6);
          var_6 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_AF13161873BDCF20974890F125EBEBA3A9BB18D0FBD32B79");
          self notify("_encstr_99FD1DEF9B4043AA93C167DFD948029C2141E73633B027A2F8FFA7DB23605A");
        }
      }
    }

    wait(randomintrange(3, 15));
  }
}

nospectatablepropswatch(var_0) {
  var_1 = scripts\common\utility::playersinsphere(var_0.origin, 666);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(level.teambased && var_4.team != var_0.team) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

notifycapturetoplayers() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_B6551C58B70E3389C252E886EBBAC9796087C8F043CD492F0B3FFF0FC5E2");
  self.owner endon("_encstr_99FD1DEF9B4043AA93C167DFD948029C2141E73633B027A2F8FFA7DB23605A");

  for(;;) {
    var_0 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 40000), self);
    waitframe();
  }
}

notify_planter_on_whizby(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_2 = self.origin;

    if(isDefined(var_0))
      var_2 = self gettagorigin(var_0);

    if(istrue(var_1)) {
      var_3 = anglesToForward(self.angles);
      var_4 = anglestoright(self.angles);
      var_5 = anglestoup(self.angles);
    }

    wait 0.05;
  }
}

nopropsspectate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self notify(var_0.name + "_encstr_81411893360F38F35713F05BAA872FF16799051B927530B0E36B");
  self endon(var_0.name + "_encstr_81411893360F38F35713F05BAA872FF16799051B927530B0E36B");

  if(!isDefined(self.initthermometerwatch)) {
    self._id_1459F = ["_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9", "_encstr_88710EC26CC49918FA1A815BB5AFADC1", "_encstr_88F90EF65F8E7A1AEED5251AE97F9788"];
    self.initspawnsoverridefunc = 0;
    self.initsolospawnstruct = self._id_1459F[0];
    self.initthermometerwatch = self.initsolospawnstruct;
  }

  for(;;) {
    var_1 = scripts\engine\utility::_id_143AD("_encstr_B6551C58B70E3389C252E886EBBAC9796087C8F043CD492F0B3FFF0FC5E2", "_encstr_99FD1DEF9B4043AA93C167DFD948029C2141E73633B027A2F8FFA7DB23605A");

    if(!isDefined(var_1)) {
      waitframe();
      continue;
    }

    if(var_1 == "_encstr_B6551C58B70E3389C252E886EBBAC9796087C8F043CD492F0B3FFF0FC5E2") {
      self.initspawnsoverridefunc++;

      if(self.initspawnsoverridefunc > 2)
        self.initspawnsoverridefunc = 0;

      self.initsolospawnstruct = self._id_1459F[self.initspawnsoverridefunc];
      self.initthermometerwatch = self.initsolospawnstruct;
      continue;
    }

    if(istrue(self._id_139B7)) {
      waitframe();
      continue;
    }

    var_2 = nosplash(var_0);
    thread noprone(var_2, self.initsolospawnstruct);
  }
}

normalspeed(var_0) {
  return weaponfiretime(var_0);
}

nosplash(var_0) {
  var_1 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"];
  var_2 = physics_createcontents(var_1);
  var_3 = self.origin;
  var_4 = vectorNormalize(var_0.origin - self.origin);
  var_5 = var_3 + var_4 * 50000;
  var_6 = scripts\engine\trace::ray_trace(var_3, var_5, self, var_2);
  var_7 = var_6["_encstr_BD260953AA97E3F014279D"];
  return var_7;
}

noprone(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_99FD1DEF9B4043AA93C167DFD948029C2141E73633B027A2F8FFA7DB23605A");
  self endon("_encstr_B6551C58B70E3389C252E886EBBAC9796087C8F043CD492F0B3FFF0FC5E2");

  for(;;) {
    var_2 = weaponmaxammo(var_1);

    while(var_2 > 0) {
      if(istrue(self._id_139B7)) {
        waitframe();
        continue;
      }

      var_3 = undefined;
      var_4 = scripts\cp_mp\killstreaks\toma_strike::_id_13BD6(var_0, 333);
      var_3 = var_4.point;
      var_5 = undefined;
      var_6 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname(var_1), self.origin, var_3, var_5);
      var_6.weapon_name = var_1;
      var_6.team = self.team;
      thread notstand(var_6);
      var_2--;

      if(var_2 == 0) {
        wait 1;
        self notify("_encstr_B6551C58B70E3389C252E886EBBAC9796087C8F043CD492F0B3FFF0FC5E2");
        var_7 = level.weaponreloadtime[var_1] + getdvarint("_encstr_ACBE17F3CE33076FBD60917B7891E5B7A93D6195559BC7B751", 0);

        while(var_7 > 0) {
          var_7--;
          wait 1;
        }
      }

      wait(normalspeed(var_1));
    }
  }
}

notstand(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_2 = getcompleteweaponname(self.initthermometerwatch);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 = 0.5;
  var_10 = 100;

  if(isDefined(var_2) && isDefined(var_2.basename)) {
    switch (var_2.basename) {
      case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
        var_9 = 1.5;
        var_10 = 500;
        break;
      case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
        var_9 = 1;
        var_10 = 300;
        break;
    }
  }

  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_11 setModel("_encstr_A5A9131AC3AF376E32A7F88F31E87267B59BD1E24B");
  var_11.angles = vectortoangles(var_8);
  var_11 linkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_11 setotherent(self);
  var_11 thread scripts\cp_mp\killstreaks\gunship::deleteaftertime(5);
  var_12 = "_encstr_AB0703DBB9";

  if(istrue(var_1))
    var_12 = "_encstr_96221067CD45D3EF66A8531FAB78A43915DB";

  var_11 setscriptablepartstate(var_0.weapon_name, var_12, 0);

  if(isDefined(self))
    var_0 detonate();
  else
    var_0 delete();

  var_13 = var_11.origin;
  var_14 = scripts\cp_mp\killstreaks\gunship::getmissileexplscale(var_0.weapon_name);
  var_15 = 0.75;
  var_16 = scripts\cp_mp\killstreaks\gunship::getmissileexplradius(var_0.weapon_name);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015")]](var_13, var_14, var_15, var_16);
}

notetrack_listener_cattleprod_shock_player_at_gate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self.owner endon("_encstr_B6551C58B70E3389C252E886EBBAC9796087C8F043CD492F0B3FFF0FC5E2");
  self.owner endon("_encstr_99FD1DEF9B4043AA93C167DFD948029C2141E73633B027A2F8FFA7DB23605A");

  for(;;) {
    self.flashlight.angles = vectortoangles(var_0 - self.origin);
    waitframe();
  }
}