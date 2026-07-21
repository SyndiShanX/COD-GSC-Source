/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58270.gsc
***********************************************/

_id_12A27() {
  level._id_12A34 = [];
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"] = spawnStruct();
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].timeout = getdvarfloat("_encstr_84911853788589D31BE03A230BA15F8ACBD8199B8063FF2FD35D", 45.0);
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].maxhealth = 75;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].hitstokill = 3;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].speed = 140;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].accel = 20;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].halfsize = 27;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].spawndist = 30;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].streakname = "_encstr_970509C3CF3B425F68D9F7";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].vehicleinfo = "_encstr_A5E3101C7FA29F537BF328F9339169671AA2";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].modelbase = "_encstr_84BE15B80A090D494BAFCD63578353F7AD12A9F0429851";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].teamsplash = "_encstr_83810E8BBBF8B439FE075B2317A682EC";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].destroyedsplash = "_encstr_BEBD1B01361C10C02B5337590F939528A7884979D16A30031217655B23";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].initbunker = 0.5;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].sound_explode = "_encstr_A90A146AD31BC59B88A113CA88FD273FB061FCCF79E8";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].vodestroyed = "_encstr_83581AC48563C6EB8C27BDB959BE1385D8B5EA83D746596E479CDBF2";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].votimedout = "_encstr_A3201A6E497532692C0BD75D7AA602F34FEC036FF70B9BFD1DA783D3";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].scorepopup = "_encstr_AFD71334358BDC6B02137F09A15848C34561707345";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].playfxcallback = scripts\cp_mp\killstreaks\helper_drone::helperdronefx;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].primarymode = "_encstr_849007B069FD0B5FDC";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].primarymodestring = &"_encstr_8D7D1DC9B7DC042FC1EAD5CFB469EF4C7113B99146BABD4959C5DF401B2081";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].primarymodefunc = scripts\cp_mp\killstreaks\helper_drone::setreconmodesettings;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].premoddamagefunc = undefined;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].postmoddamagefunc = scripts\cp_mp\killstreaks\helper_drone::helperdrone_modifydamageresponse;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].deployweaponname = "_encstr_8BA3122BAB067B3D2805C4D93F637FB93D97B22B";
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"]._id_11B06 = 1;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"]._id_11B07 = 1;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"]._id_11B17 = 73984;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"]._id_11B18 = 73984;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].deathfunc = ::_id_12A22;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].leaderinteractionthink = 1;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].diewithowner = 1;
  level._id_12A34["_encstr_970509C3CF3B425F68D9F7"].stringcannotplace = &"_encstr_8FBF20B8242923C2B9856D71AFD9997BC3BCC161CD17F34D89A17F7BD30995DF1B14";
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_970509C3CF3B425F68D9F7", ::_id_13E2E, undefined, ::_id_13E11);
  initmines();
  var_0 = getarraykeys(level._id_12A34);

  foreach(var_2 in var_0) {
    var_3 = level._id_12A34[var_2].hitstokill;

    if(isDefined(var_3)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_2, var_3);
      scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E", var_3, var_2);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_970509C3CF3B425F68D9F7", ::_id_12A22);
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_924B0BBB80698FEF21B0E515D3"] = "_encstr_924B0BBB80698FEF21B0E515D3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B4412EBA1F34301E8058195252015FF889B7302"] = "_encstr_8B4412EBA1F34301E8058195252015FF889B7302";
  level._effect["_encstr_A5190E6BF26B4408B0D809B7A254F5CE"] = loadfx("_encstr_9A4A27360C32866CDFEAD13A8057A7374B63B8D5155853A5B570ABE16827D83B66DD2840A0404FFC5D");
}

initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_970509C3CF3B425F68D9F7", 1);
  var_0.frontextents = 15;
  var_0.backextents = 15;
  var_0.leftextents = 15;
  var_0.rightextents = 15;
  var_0.bottomextents = 3;
  var_0.distancetobottom = 3;
}

_id_13E2E(var_0) {
  var_1 = self;
  var_2 = var_1 _id_13E2F(var_0);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");
  }

  return var_2;
}

_id_13E11() {
  var_0 = self;
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_970509C3CF3B425F68D9F7", var_0);
  var_1._id_133CE = 1;
  var_2 = var_0 _id_13E2F(var_1);

  if(!var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");
  }

  return var_2;
}

_id_13E2F(var_0) {
  var_1 = self;

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  if(!self isonground() && !self isonladder() || _calloutmarkerping_handleluinotify_enemyrepinged::updateleaders())
    return 0;

  if(isDefined(level.getflagradarowner)) {
    if(![[level.getflagradarowner]](var_1))
      return 0;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle(1))
    return 0;

  var_2 = var_0.streakname;
  var_3 = level._id_12A34[var_2].deployweaponname;
  var_4 = var_1 scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, ::_id_14588, undefined, undefined, ::deployweapontaken, var_3, 0, ::_id_14405);
  var_1 scripts\common\utility::allow_usability(0);
  var_1 thread scripts\cp_mp\utility\killstreak_utility::tabletdofset(0, 1, 1);

  if(!istrue(var_4)) {
    var_1 _id_12A2A(var_0);
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_1 _id_12A2A(var_0);
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }
  }

  var_1 scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  var_5 = 0.4;
  var_6 = var_1 scripts\engine\utility::_id_143BA(var_5, "_encstr_AD75063D571AE108", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");

  if(!isDefined(var_6) || var_6 != "_encstr_995408F398012F656821") {
    var_1 _id_12A20(var_0);
    var_1 scripts\cp_mp\utility\player_utility::_freezecontrols(0);
    return 0;
  }

  var_1 scripts\cp_mp\utility\player_utility::_freezecontrols(0);
  var_7 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](var_1, var_0.streakname);
    var_7 = 2.0;
  }

  var_1 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1, var_7);
  var_8 = level._id_12A34[var_2].teamsplash;
  var_6 = _id_13870(var_0);

  if(!istrue(var_6)) {
    var_1 _id_12A20(var_0);
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_8, var_1);

  return 1;
}

_id_14405(var_0) {
  scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon(var_0);
  waitframe();
}

_id_14588(var_0) {
  return 1;
}

deployweapontaken(var_0) {
  self notify("_encstr_A5B117CF7820397B738BAB4FE1AD136480C2091311A0E87258");
}

_id_12E28() {
  var_0 = self;
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  var_1 = getcompleteweaponname("_encstr_8BA3122BAB067B3D2805C4D93F637FB93D97B22B");

  if(var_0 hasweapon(var_1))
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
}

_id_13870(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = spawnStruct();
  var_2.origin = var_1.origin + (100, 0, 0);
  var_2.angles = var_1.angles;
  var_2.modelname = "_encstr_84BE15B80A090D494BAFCD63578353F7AD12A9F0429851";
  var_2.vehicletype = "_encstr_BE3E0CDD5534D11EAF9B99E6D23B";
  var_2.targetname = "_encstr_AB13093BAC86D7C9B1F0C8";
  var_2.cannotbesuspended = 1;
  var_3 = spawnStruct();
  var_4 = var_1 _id_12A25(100);

  if(!isDefined(var_4)) {
    var_1 _id_12A20(var_0);
    return 0;
  }

  var_2.origin = var_4;
  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_2, var_3);

  if(!isDefined(var_5)) {
    var_1 _id_12A20(var_0);
    return 0;
  }

  var_1.restoreangles = var_1 getplayerangles();
  var_5 setotherent(var_1);
  var_5 setentityowner(var_1);
  var_1 controlslinkTo(var_5);
  var_1 setclientomnvar("_encstr_ABD71088F34932B7E97F1FFD45236308F180", 9);
  var_5 scripts\cp_mp\utility\killstreak_utility::_id_11DC0(var_1);
  var_5.owner = var_1;
  var_5.team = var_1.team;
  var_5.vehiclename = var_0.streakname;
  var_6 = level._id_12A34[var_0.streakname];
  var_5.streakinfo = var_0;
  var_5.owner.streakinfo = var_0;
  var_5.maxhealth = var_6.maxhealth;
  var_5.health = var_6.maxhealth;

  if(isDefined(var_6.damagemonitorfunc))
    var_5 thread[[var_6.damagemonitorfunc]]();

  var_5 thread _id_12A33();
  var_5 thread _id_12A30();
  var_5 thread _id_12A2F();
  var_5 thread _id_12A32();
  var_5 thread _id_12A23();
  var_5 thread _id_12A2C(var_6);
  var_5 thread _id_12A2E();
  var_5 thread _id_12A2B();
  var_5 thread _id_12A28(var_6);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
    thread _id_12E28();

  var_5 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  scripts\mp\outofbounds::registerentforoob(var_5, "_encstr_85CE0B9770B02C73A1760F06D2");
  var_5 _id_12A29("_encstr_924B0BBB80698FEF21B0E515D3", 0, 1);
  var_5 _id_12A29("_encstr_8B4412EBA1F34301E8058195252015FF889B7302", 1, 0);
  var_5 setscriptablepartstate("_encstr_A1C00C1444AF43E1E1FA0870D243", "_encstr_A18008BD35E222F01BD0", 0);
  return 1;
}

_id_12A25(var_0) {
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = [var_2 + var_0 * var_4, var_2 - var_0 * var_4, var_2 + var_0 * var_5, var_2 - var_0 * var_5, var_2 + 0.707 * var_0 * (var_4 + var_5), var_2 + 0.707 * var_0 * (var_4 - var_5), var_2 + 0.707 * var_0 * (var_5 - var_4), var_2 + 0.707 * var_0 * (-1 * var_4 - var_5)];

  foreach(var_8 in var_6) {
    var_1 = _id_12A1D(var_2, var_8);

    if(isDefined(var_1)) {
      break;
    }
  }

  return var_1;
}

_id_12A1D(var_0, var_1) {
  var_2 = undefined;
  var_3 = (0, 0, 45);
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  var_5 = var_0 + var_3;
  var_6 = var_1 + var_3;
  var_7 = 40;
  var_8 = scripts\engine\trace::ray_trace_passed(var_5, var_6, self, var_4);

  if(!istrue(var_8))
    return var_2;

  var_9 = scripts\engine\trace::ray_trace(var_6, var_6 - (0, 0, 500), self, var_4);

  if(isDefined(var_9["_encstr_BD260953AA97E3F014279D"]) && var_9["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
    var_10 = var_9["_encstr_BD260953AA97E3F014279D"] + var_3;
    var_11 = scripts\engine\trace::sphere_trace_passed(var_10, var_10, var_7, self, var_4);
    var_12 = undefined;

    if(level.teambased)
      var_12 = self.team;

    if(istrue(var_11) && !scripts\mp\outofbounds::ispointinoutofbounds(var_9["_encstr_BD260953AA97E3F014279D"], var_12))
      var_2 = var_9["_encstr_BD260953AA97E3F014279D"];
  }

  var_13 = var_2;
  var_14 = 14.75;

  if(isDefined(var_2)) {
    var_15 = 1;
    var_16 = [(var_14, var_14, 0), (-1 * var_14, var_14, 0), (var_14, -1 * var_14, 0), (-1 * var_14, -1 * var_14, 0)];

    foreach(var_18 in var_16) {
      var_19 = var_13 + var_18;
      var_9 = scripts\engine\trace::ray_trace(var_13, var_19, self, var_4);

      if(isDefined(var_9["_encstr_BD260953AA97E3F014279D"]) && var_9["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_20 = scripts\mp\outofbounds::ispointinoutofbounds(var_9["_encstr_BD260953AA97E3F014279D"], self.team);

        if(!istrue(var_20))
          return undefined;

        break;
      }
    }
  }

  return var_13;
}

_id_12A20(var_0) {
  var_1 = self;
  var_1 _id_12A2A(var_0);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

  if(!var_1 scripts\common\utility::is_usability_allowed())
    var_1 scripts\common\utility::allow_usability(1);
}

_id_12A28(var_0) {
  var_1 = self;
  var_1.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_BA2D081B2B58B32D37EC");
  var_1 endon("_encstr_860808CB78E2984063BA");
  var_1 endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_1 vehphys_enablecollisioncallback(1);
  var_2 = var_1.streakinfo;

  for(;;) {
    var_1 waittill("_encstr_93510A16C71B20636A2AB8B8", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(!isDefined(var_10)) {
      continue;
    }
    var_12 = undefined;

    if(var_10 scripts\cp_mp\vehicles\vehicle::isvehicle())
      var_12 = var_10;
    else if(var_10 scripts\cp_mp\utility\player_utility::isinvehicle())
      var_12 = var_10.vehicle;
    else if(istrue(var_10.velstartid))
      var_12 = var_10;

    if(!isDefined(var_12)) {
      continue;
    }
    var_13 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_1.owner, var_12.owner));

    if(istrue(var_0.leaderplunderstring)) {
      if(var_13 || !isDefined(var_12.owner))
        var_1 thread _id_12A24(var_2);
      else
        var_1 dodamage(var_1.maxhealth, var_12.origin, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");

      continue;
    }

    var_14 = undefined;
    var_15 = undefined;

    if(var_13) {
      var_16 = var_12.owner scripts\cp_mp\utility\player_utility::getvehicle();

      if(isDefined(var_16) && var_16 == var_12) {
        var_14 = var_12.owner;
        var_15 = var_12;
      }
    }

    var_17 = var_1.maxhealth * var_0.initbunker;
    var_1 dodamage(var_17, var_12.origin, var_14, var_15, "_encstr_8D4E0A501FCB898912CB3FA3");
  }
}

_id_12A33() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8B460B3A23F8474A212F879E33");
  var_1 = level._id_12A34[var_0.vehiclename];
  var_0.timeout = var_1.timeout;

  if(!isDefined(var_0.timeout)) {
    return;
  }
  var_3 = var_0.streakinfo;

  if(var_0.timeout > 0) {
    var_0.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(var_0.timeout * 1000));
    wait(var_0.timeout);
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_1.votimedout, 1);
  var_0 thread _id_12A21(var_3);
}

_id_12A21(var_0) {
  var_1 = 1;
  var_2 = self;

  if(!isDefined(var_0))
    var_0 = var_2.streakinfo;

  if(!istrue(var_2.lbravo_spawner_safehouse1)) {
    var_2 thread _id_12A1E();
    var_2.lbravo_spawner_safehouse1 = 1;
  }

  var_2 vehphys_enablecollisioncallback(0);

  if(!isDefined(var_0))
    var_0 = var_2.streakinfo;

  if(isDefined(var_2.owner)) {
    if(!isDefined(var_0))
      var_0 = var_2.owner.streakinfo;

    var_2.owner.streakinfo = undefined;
  }

  if(!isDefined(var_2) || istrue(var_2.isdestroyed)) {
    if(isDefined(var_0))
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

    return;
  }

  var_2.isdestroyed = 1;
  var_2.health = 0;
  var_2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var_2 playSound("_encstr_BDA11887DF79028B02DCD893ABE0B00820224FFB209A10D80E4B");

  if(level.gametype != "_encstr_B607038AAB" && isDefined(var_2.owner) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B607038AAB", "_encstr_AB0F11DCBAE02B274D8DB78E6863ACC237AA0E"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B607038AAB", "_encstr_AB0F11DCBAE02B274D8DB78E6863ACC237AA0E")]](var_2.owner);

  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  var_2.owner setclientomnvar("_encstr_ABD71088F34932B7E97F1FFD45236308F180", 0);
  var_2.owner cameraunlink(var_2);
  var_2 unlink();
  var_2.owner controlsunlink();
  scripts\cp_mp\utility\killstreak_utility::_id_11DC1(var_2.owner);
  var_2 setscriptablepartstate("_encstr_A1C00C1444AF43E1E1FA0870D243", "_encstr_8B1608EC43B8D647A113", 0);
  var_2.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
  var_2.owner unlink();
  var_2.owner setplayerangles((var_2.owner.restoreangles[0], var_2.owner.restoreangles[1], 0));
  var_2.owner.restoreangles = undefined;
  var_2.owner scripts\common\utility::allow_usability(1);
  var_2 notify("_encstr_860808CB78E2984063BA");
  scripts\mp\outofbounds::clearoob(self, 1);
  var_2 setscriptablepartstate("_encstr_A1C00C1444AF43E1E1FA0870D243", "_encstr_8B1608EC43B8D647A113", 0);
  var_3 = level._id_12A34[var_0.streakname].deployweaponname;
  var_4 = getcompleteweaponname(var_3);

  if(var_2.owner hasweapon(var_4))
    var_2.owner scripts\cp_mp\utility\inventory_utility::getridofweapon(var_4);

  var_2 thread _id_12A1F();
  var_2.owner setclientomnvar("_encstr_86601BAE2D7D9C95AD7B8E59D76CBDCD8E93BDD8EBCD59B8AE95CD1BB2", -1);
}

_id_12A1F() {
  waitframe();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

_id_12A2A(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 notify("_encstr_992310E4D8E119D559850EBDDC51B0D695DC");
  var_1 endon("_encstr_992310E4D8E119D559850EBDDC51B0D695DC");
  wait 1.5;
  var_2 = level._id_12A34[var_0.streakname].deployweaponname;
  var_3 = getcompleteweaponname(var_2);
  var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
  var_4 = var_1 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();
  var_5 = var_1 scripts\mp\utility\inventory::getlastweapon();

  if(!var_1 hasweapon(var_5))
    var_5 = var_1 scripts\mp\utility\inventory::getfirstprimaryweapon();

  var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_5);
  var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);

  if(var_1 hasweapon(var_3))
    var_1 scripts\cp_mp\utility\inventory_utility::getridofweapon(var_3);

  if(!var_1 scripts\common\utility::is_usability_allowed())
    var_1 scripts\common\utility::allow_usability(1);
}

_id_12A22(var_0) {
  var_1 = self;
  var_1 thread _id_12A21();
  return 0;
}

_id_12A30() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 childthread _id_12A31("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 childthread _id_12A31("_encstr_81170C244F9CBDE72C01BB99A298");
  var_0 childthread _id_12A31("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  var_0 childthread _id_12A31("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
}

_id_12A31(var_0) {
  var_1 = self;
  var_2 = var_1.streakinfo;
  var_1.owner waittill(var_0);
  var_1 notify("_encstr_8B460B3A23F8474A212F879E33");
  var_1 thread _id_12A21(var_2);
}

_id_12A2F() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_1 = var_0.streakinfo;

  for(;;) {
    var_0.owner waittill("_encstr_AD75063D571AE108");
    var_2 = level._id_12A34[var_0.vehiclename];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_BA7714A8BBFD7D30A2DFA8F8B94296071895313315B7")) {
      if(istrue(var_2.diewithowner) || [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_BA7714A8BBFD7D30A2DFA8F8B94296071895313315B7")]]() && var_0.owner.pers["_encstr_8E0607055DBFB3919A"] == [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_BA7714A8BBFD7D30A2DFA8F8B94296071895313315B7")]]())
        var_0 thread _id_12A21(var_1);
    }
  }
}

_id_12A32() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8B460B3A23F8474A212F879E33");
  var_1 = var_0.streakinfo;
  level scripts\engine\utility::_id_143A7("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739", "_encstr_9B1D0BC7932875276230426AA1", "_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0", "_encstr_B48B10CF58B0F96A343FB7E78BE502262081");
  var_0 thread _id_12A21(var_1);
}

_id_12A23() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_1 = var_0.streakinfo;
  level scripts\engine\utility::_id_143A5("_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1", "_encstr_9B1D0BC7932875276230426AA1");
  var_0 thread _id_12A21(var_1);
}

_id_12A2C(var_0) {
  var_1 = self;

  if(!istrue(var_0.leaderinteractionthink)) {
    return;
  }
  var_1.owner notifyonplayercommand("_encstr_BE160E232B8EDE370B47CAD7C9C61E8C", "_encstr_97410B23BD6B976233901AF2F8");
  var_1.owner notifyonplayercommand("_encstr_BE160E232B8EDE370B47CAD7C9C61E8C", "_encstr_B4C60AD707B2BDC0E6CE1309");
  var_1 _id_12A2D();

  if(isDefined(var_1.owner)) {
    var_1.owner notifyonplayercommandremove("_encstr_BE160E232B8EDE370B47CAD7C9C61E8C", "_encstr_97410B23BD6B976233901AF2F8");
    var_1.owner notifyonplayercommandremove("_encstr_BE160E232B8EDE370B47CAD7C9C61E8C", "_encstr_B4C60AD707B2BDC0E6CE1309");
  }
}

_id_12A2D() {
  var_0 = self;
  var_0.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_1 = var_0.streakinfo;
  var_0.owner waittill("_encstr_BE160E232B8EDE370B47CAD7C9C61E8C");
  var_0 thread _id_12A24(var_1);
}

_id_12A2E() {
  var_0 = self;
  var_0.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_0.owner notifyonplayercommand("_encstr_93140AD8C327B7711AE389B9", "_encstr_B44609DFE707CF394E1651");

  for(;;) {
    if(!var_0 _meth_87B5()) {
      var_0.owner waittill("_encstr_93140AD8C327B7711AE389B9");
      waitframe();

      if(var_0 _meth_87B5()) {
        var_0 setscriptablepartstate("_encstr_84DD05D205AA0B", "_encstr_A18008BD35E222F01BD0", 0);
        waitframe();
        var_0 setscriptablepartstate("_encstr_84DD05D205AA0B", "_encstr_8B1608EC43B8D647A113", 0);
      }
    }

    waitframe();
  }
}

_id_12A2B() {
  var_0 = self;
  var_0.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  for(;;) {
    if(var_0 _meth_87B4()) {
      var_0 setscriptablepartstate("_encstr_88060E5EB59A8FEB0593A9D0935963C9", "_encstr_A18008BD35E222F01BD0", 0);
      var_0 setscriptablepartstate("_encstr_826C088A50082FC31340", "_encstr_A18008BD35E222F01BD0", 0);
      wait 0.2;
      var_0 setscriptablepartstate("_encstr_88060E5EB59A8FEB0593A9D0935963C9", "_encstr_8B1608EC43B8D647A113", 0);

      while(var_0 _meth_87B4())
        waitframe();

      var_0 setscriptablepartstate("_encstr_826C088A50082FC31340", "_encstr_8B1608EC43B8D647A113", 0);
    }

    waitframe();
  }
}

_id_12A24(var_0) {
  var_1 = self;
  var_1 thread _id_12A1E();
  var_1.lbravo_spawner_safehouse1 = 1;
  var_1 thread _id_12A21(var_0);
}

_id_12A1E() {
  var_0 = self;
  var_1 = var_0.origin;
  var_2 = var_0.owner;
  var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1, 0, 256, 512);
  var_0 radiusdamage(var_0.origin, 300, 60, 25, var_2, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  var_3 endon("_encstr_AD75063D571AE108");
  var_3.owner = var_2;
  var_3.team = var_2.team;
  var_3.playersintrigger = [];
  var_3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerenter();
  var_3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerexit();
  var_3 thread watchgastrigger(var_0.owner, "_encstr_8AC70B0ABFB867FF318361BAEB");
  var_4 = var_0.origin + (0, 0, -10);
  var_5 = physicstrace(var_0.origin, var_4);
  var_6 = var_5 == var_4;
  var_7 = "_encstr_A6030FE8D9A3D79807F8D72FB3EAEBE809";

  if(var_6)
    var_7 = "_encstr_8D7E0C49921308C8EEC46323F112";

  physicsexplosionsphere(var_0.origin, 200, 100, 3);
  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var_0.origin);
  playFX(scripts\engine\utility::getfx("_encstr_A5190E6BF26B4408B0D809B7A254F5CE"), var_0.origin);
  var_2 playsoundtoplayer("_encstr_82021C1B11F0A90763022EC1B163906177D73B87BBDB282F477D08F0C1A8", var_2);
  wait 20.0;
  var_3 thread scripts\mp\equipment\gas_grenade::gas_destroytrigger();
}

watchgastrigger(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(level.teambased && var_2.team == var_0.team && var_2 != var_0) {
      continue;
    }
    if(istrue(var_2.gettinggassed)) {
      continue;
    }
    thread applygasdamageovertime(var_0, var_2);
  }
}

applygasdamageovertime(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1.gettinggassed = 1;

  while(var_1 istouching(self)) {
    var_1 dodamage(9, self.origin, var_0, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
    var_2 = scripts\engine\utility::_id_143B9(1, "_encstr_AD75063D571AE108");

    if(var_2 == "_encstr_AD75063D571AE108") {
      break;
    }
  }

  if(istrue(var_1.gettinggassed))
    var_1.gettinggassed = undefined;
}

_id_12A29(var_0, var_1, var_2) {
  var_3 = self;

  if(!isDefined(var_0)) {
    return;
  }
  var_4 = var_3 _id_12A26(var_1, var_2, 7500);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog(var_0, 1, var_4);
}

_id_12A26(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = [];
  var_5 = var_3.owner.team;
  var_6 = level.teamdata[var_5]["_encstr_9775086022BE1B413B8B"];
  var_4 = scripts\common\utility::playersnear(var_3.owner.origin, var_2);

  if(istrue(var_0))
    var_4 = scripts\engine\utility::array_intersection(var_6, var_4);

  if(istrue(var_1))
    var_4 = scripts\engine\utility::array_difference(var_4, var_6);

  return var_4;
}