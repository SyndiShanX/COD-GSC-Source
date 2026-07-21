/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\toma_strike.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_88C5055208731B")]]();

  level.toma_strikes = [];
  init_toma_strike_vo();
}

init_toma_strike_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7FB131B36EACD8EAC4ED7371D9CA5B6B2F543D21D"] = "_encstr_A7FB131B36EACD8EAC4ED7371D9CA5B6B2F543D21D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8ADE148B689B2F21088D2FD8199BB0125507B38B9B13"] = "_encstr_8ADE148B689B2F21088D2FD8199BB0125507B38B9B13";
}

trytomastriketriggered(var_0) {
  var_1 = var_0.streakname;
  var_2 = getdvarint("_encstr_A1C4159E4BE3C6D9EDEA48B163438D582FF53095B91349", 3);
  return 1;
}

weapondetonatedtomastrike(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = getdvarint("_encstr_A1C4159E4BE3C6D9EDEA48B163438D582FF53095B91349", 3);
  var_2 thread tomastrike_attacktarget(var_3, undefined, var_1, var_0);
}

weapongiventomastrike(var_0) {
  if(isDefined(level.toma_strikes) && level.toma_strikes.size >= 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

    var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    return 0;
  }

  return 1;
}

weaponswitchendedtomastrike(var_0, var_1) {
  var_2 = getdvarint("_encstr_A1C4159E4BE3C6D9EDEA48B163438D582FF53095B91349", 3);

  if(scripts\cp_mp\utility\game_utility::_id_140A9())
    thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads(var_0);
}

weaponfiredtomastrike(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_13A81)) {
    var_3 = tomastrike_getownerlookat(self);

    if(!isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88A31A942F6BE4DA0996F50737672E37C17BFE24BC3FE91B680FA831");

      return "_encstr_AFAC097640D8DC32A87307";
    }
  }

  if(isDefined(level.gametype)) {
    if(level.gametype == "_encstr_B607038AAB" && isDefined(self.scrambledby)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8C371D6198B78575014891D1E0AD83FE736590E43ABEE3F36560D199D877C9");

      return "_encstr_AFAC097640D8DC32A87307";
    }
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_AD481BB44A2689D4454A8AA02DD4CB3482C99C3D45BE908AFA55A9A888");

    return "_encstr_AFAC097640D8DC32A87307";
  }

  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
    var_4 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1, var_4);
  return "_encstr_88E30897BDF1B71F7823";
}

tryusetomastrike() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A2E60C6BC099B7E1A0A93A398F48", self);
  return tryusetomastrikefromstruct(var_0);
}

tryusetomastrikefromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = getdvarint("_encstr_A1C4159E4BE3C6D9EDEA48B163438D582FF53095B91349", 3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

    if(var_2 == "_encstr_B607038AAB")
      var_1 = 5;
  }

  if(var_1 == 4) {
    var_3 = scripts\mp\killstreaks\throwback_marker::throwbackmarker_trythrowbackmarker(var_0, ::weapondetonatedtomastrike);

    if(!istrue(var_3))
      return 0;
  } else if(var_1 == 5 && isDefined(self.waitandunloadinfils)) {
    var_0._id_13A81 = self.waitandunloadinfils;
    self.waitandunloadinfils = undefined;
    var_4 = weaponfiredtomastrike(var_0, undefined, undefined);

    if(var_4 != "_encstr_88E30897BDF1B71F7823")
      return 0;
  } else {
    if(scripts\cp_mp\utility\game_utility::_id_140A9())
      var_5 = getcompleteweaponname("_encstr_95C419518C324FF2C9585B5320E52127B178B0D53020BBB1977817", ["_encstr_A1AA0D2E01D783B0AD9B42E7080B22"]);
    else
      var_5 = getcompleteweaponname("_encstr_A22812C4735AC7E2B64317C3CF560A3128DE7D0A");

    var_3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_5, "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", ::weapongiventomastrike, ::weaponswitchendedtomastrike, ::weaponfiredtomastrike);

    if(!istrue(var_3))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  if(tomastrike_isremotevehicletype(var_1)) {
    var_6 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]() || level.fauxvehiclecount + var_6 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]()) {
        self iprintlnbold(&"_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
        var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
        return 0;
      }
    }

    var_3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, ::weapongiventomastrike, ::weaponswitchendedtomastrike);

    if(!istrue(var_3))
      return 0;
  }

  var_7 = undefined;

  if(var_1 == 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B")]]();

    var_7 = createtomastrikedrone(self, var_0);

    if(!isDefined(var_7)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

      return 0;
    }
  } else if(var_1 == 1) {
    if(level.toma_cameras.size == 0) {
      var_8 = ["_encstr_956D13475F612E38D2FCC01969ABD869BA33CBA7EE", "_encstr_A66D13D2BA9187D32AF71068475309C35A625F7042", "_encstr_B66D136DE6EBE6D14E2DADB27D3685ADB29CB0D7CC", "_encstr_846D136DCDD7E6E84E5A6D56EB8D2CB6B2390BBED0"];

      foreach(var_10 in var_8) {
        var_11 = scripts\engine\utility::getStruct(var_10, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

        if(!isDefined(var_11)) {
          var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
          return;
        }

        var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_11.origin);
        var_12.angles = var_11.angles;
        var_12.targetname = var_11.targetname;
        var_12 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
        level.toma_cameras[level.toma_cameras.size] = var_12;
      }
    }
  } else if(var_1 == 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B")]]();

    var_7 = createtomastrikebomber(self, var_0);

    if(!isDefined(var_7)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

      return 0;
    }
  } else
    level.toma_strikes[level.toma_strikes.size] = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]]("_encstr_932811D34B6F1080FBD2B039F9CFCD7884BB0B", self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0.streakname, self.origin);

  if(var_1 != 4)
    thread starttomastrike(var_1, var_7, level.toma_cameras, var_0);

  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_8B330D3ADBD0F47B4B9536570725A8"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_8B330D3ADBD0F47B4B9536570725A8")]]();

  return 1;
}

_id_13BDA(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.pers = [];
  var_3.team = "_encstr_A7A408B9CA5D1D4E2C63";
  var_3.defaultoperatorteam = "_encstr_A7A408B9CA5D1D4E2C63";
  var_3.classname = "_encstr_BD4E0B7B104D6AD4DB384717A0";

  if(!isDefined(var_2))
    var_2 = var_3 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A2E60C6BC099B7E1A0A93A398F48", var_3);

  var_2.owner = var_3;
  var_2._id_13A81 = var_0;
  var_2._id_121AF = anglesToForward(var_1);
  var_2._id_133DC = 1;
  var_3 thread starttomastrike(5, undefined, undefined, var_2);
}

createtomastrikedrone(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_3 = (0, 0, 0);

  if(isDefined(var_2))
    var_3 = (0, 0, var_2.origin[2]);
  else
    var_3 = (0, 0, 600);

  var_3 = var_3 - (0, 0, 900);
  var_4 = spawnhelicopter(var_0, var_0.origin + (0, 0, 1000), var_0.angles, "_encstr_84311284A5632E211502D019AA6ADFC08F77817F", "_encstr_AD7B16E37758F298EAE791EFDFF25681E5CA0B195EBDF0E3");

  if(!isDefined(var_4)) {
    return;
  }
  var_4.speed = 100;
  var_4.accel = 50;
  var_4.health = 9999;
  var_4.maxhealth = 2000;
  var_4.lifetime = 10;
  var_4.team = var_0.team;
  var_4.owner = var_0;
  var_4.angles = var_0.angles;
  var_4.streakinfo = var_1;
  var_4.streakname = var_1.streakname;
  var_4.currentdamagestate = 0;
  var_4.scorepopup = "_encstr_A7531621F7C3108E4A270319A7A3589069C14BBBDA3130CD";
  var_4.vodestroyed = "_encstr_A7531621F7C3108E4A270319A7A3589069C14BBBDA3130CD";
  var_4.votimeout = "_encstr_96E8141D7CF2EBF06DC3F1A0479DC967FBA3962B542A";
  var_4.destroyedsplash = "_encstr_B1321EB2776AF94887402E235133FB6A20332B01F7D32F71569F778002743769";
  var_4.currentvisionset = "_encstr_B60A15ABAB38AB4AE13741AE77D9F75F8D4AC4EE815F1A";
  level.toma_strikes[level.toma_strikes.size] = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 1, 25);

  var_4 setmaxpitchroll(15, 15);
  var_4 vehicle_setspeed(var_4.speed, var_4.accel);
  var_4 sethoverparams(50, 5, 2.5);
  var_4 setturningability(1);
  var_4 setyawspeed(500, 100, 25, 0.5);
  var_4 setotherent(var_0);
  var_4 setentityowner(var_0);
  var_4 setCanDamage(1);
  var_4 setneargoalnotifydist(100);
  return var_4;
}

createtomastrikebomber(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_3 = (0, 0, 0);

  if(isDefined(var_2))
    var_3 = (0, 0, var_2.origin[2] + 8000);
  else
    var_3 = (0, 0, 5000);

  var_3 = var_3 - (0, 0, 900);
  var_4 = level.mapcenter - anglesToForward(var_0.angles) * 5000 + var_3;
  var_5 = level.mapcenter + anglesToForward(var_0.angles) * 20000 + var_3;
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  var_6 setModel("_encstr_95F719D9AC34C1D7D65A63AF2CB49CF52C8D3416396396594C990C");
  var_6.health = 9999;
  var_6.maxhealth = 2000;
  var_6.angles = var_0.angles;
  var_6.owner = var_0;
  var_6.team = var_0.team;
  var_6.streakinfo = var_1;
  var_6.streakname = var_1.streakname;
  var_6.pathstart = var_4;
  var_6.pathgoal = var_5;
  var_6.flaresreservecount = 1;
  var_6 setotherent(var_0);
  var_6 setentityowner(var_0);
  var_6 setCanDamage(1);
  var_6 scriptmoveroutline();
  var_6 scriptmoverthermal();
  var_6.camera = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.origin - (0, 0, 10));
  var_6.camera setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_6.camera.angles = vectortoangles(level.mapcenter - var_6.camera.origin);
  var_6.camera linkTo(var_6);
  var_6.cloudsfx = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.camera.origin - (0, 0, 10));
  var_6.cloudsfx setModel("_encstr_AF99129A0BC90C376DDA36B829F31892D0774D93");
  var_6.cloudsfx.angles = var_6.angles;
  var_6.cloudsfx linkTo(var_6.camera);
  level.toma_strikes[level.toma_strikes.size] = var_6;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 1, 25);

  return var_6;
}

starttomastrike(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(tomastrike_isremotevehicletype(var_0)) {
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_crouch(0);
    scripts\common\utility::allow_prone(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_killstreaks(0);
    self.restoreangles = self.angles;
    var_4 = 1;
    var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    var_5 setModel("_encstr_9A9A197F4791D38FB57F77DF53256A20B559D5F813FFE79BF188E7");
    var_5 setotherent(self);
    var_6 = [];

    foreach(var_8 in level.players) {
      if(level.teambased && var_8.team == self.team) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
        if(var_8[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
          continue;
      }

      var_6[var_6.size] = var_8;
    }

    var_10 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_85041AA3432B9CDA0BB13BB437A57B73AC73CA6B5E91AC33C25D8DA3", self, var_6, self, 0, 1, 1);
    var_11 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", self, self, self);

    if(var_0 == 0) {
      if(!isDefined(var_1)) {
        return;
      }
      self setplayerangles(var_1.angles);
      self cameralinkTo(var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      self remotecontrolvehicle(var_1);
      var_1 thread tomastrike_watchearlyexit();
      var_1 thread tomastrike_watchdamage();
      var_1 thread tomastrike_watchowner();
      var_1 thread tomastrike_watchdestroyed(var_5);
      thread tomastrike_watchlifetime(var_5, var_1);
      var_1.playersfx = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_1.origin);
      var_1.playersfx linkTo(var_1);
      var_1.playersfx playLoopSound("_encstr_91911D1BD14BFFDE0853FBC86349646FE168C3435B95BF9499BBFDCA7FB86A");
      self setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", (var_1.maxhealth - var_1.damagetaken) / var_1.maxhealth);
    } else if(var_0 == 1) {
      if(!isDefined(var_2) || var_2.size == 0) {
        return;
      }
      var_4 = 0;
      scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_A13E0BA3DEDAB04D4793B4AD95");
      thread tomastrike_watchcameraswitch(var_2, var_5);
      thread tomastrike_watchlifetime(var_5, var_1);
    } else if(var_0 == 2) {
      if(!isDefined(var_1)) {
        return;
      }
      self playerlinkweaponviewtodelta(var_1.camera, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 180, 180, 10, 90, 0);
      self playerlinkedsetviewznear(0);
      var_1 thread tomastrike_watchearlyexit();
      var_1 thread tomastrike_watchdamage();
      var_1 thread tomastrike_watchowner();
      var_1 thread tomastrike_watchdestroyed(var_5);
      var_1 thread tomastrike_watchleave(var_5);
      var_1 thread tomastrike_playearthquakeloop();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4"))
        var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4")]](::tomastrike_handlemissiledetection);

      if(isPlayer(var_1.owner))
        var_1.owner setclienttriggeraudiozone("_encstr_ACD20F4B118BEF03D380F9335815BC7761", 2);

      var_1.cloudsfx setscriptablepartstate("_encstr_9A5007A9E5275F8ACA", "_encstr_AB0703DBB9");
      var_1 moveTo(var_1.pathgoal, 70);
    }

    self.clusterammoleft = 3;
    self setclientomnvar("_encstr_96AF147D4BA16109B30B11257311A610939CEB2714A3", 1);
    self setclientomnvar("_encstr_ADD1191D20997748DBF32BA76BDFE2B4EFEB835DB0C838D5ADB9C3", self.clusterammoleft);
    self visionsetkillstreakforplayer("_encstr_81D2150E4E7B3AF6F5D17B5B0BAF6ED139A55B2BD75B83");
    thread tomastrike_movetargetguide(var_5, var_1);
    thread tomastrike_watchammousage(var_5, var_1, var_4);
    thread tomastrike_watchlasertarget(var_0, var_5, var_1, var_3);
    thread tomastrike_watchreturnplayer(var_3, var_0, var_10, var_11);
  } else {
    thread tomastrike_attacktarget(var_0, undefined, undefined, var_3);
    var_3 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
    thread _id_13BD9(var_3);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(20);
    self notify("_encstr_B67718E6348F33893F4B89E0C3124BC8279FFC6B9EA77BF96712");
    scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_3);
  }
}

tomastrike_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      var_2.flaresreservecount--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB"))
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB")]](undefined, var_3);

      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB"))
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB")]]();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A12D21C8A30471B1029AF6066E2BA37B7B5F7078DBD92B5318BD768647300D61D437D0")]](var_0);

      self missile_settargetEnt(var_6);
      self notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
      return;
    }

    waitframe();
  }
}

tomastrike_watchearlyexit() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B")]]("_encstr_AD75063D571AE108");

  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  self notify("_encstr_AD75063D571AE108");
}

tomastrike_watchlifetime(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");
  var_2 = 1;

  if(isDefined(var_1)) {
    var_1 endon("_encstr_AD75063D571AE108");
    var_1 endon("_encstr_BA2D081B2B58B32D37EC");
    var_2 = 0;
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(10000));
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_96E8141D7CF2EBF06DC3F1A0479DC967FBA3962B542A");

  if(isDefined(var_1))
    var_1 notify("_encstr_AD75063D571AE108");

  self notify("_encstr_A221184B6F90EA11E3E580F71A3FA6CF33EB3AFE79CB19222573", var_2);

  if(isDefined(var_0))
    var_0 delete();

  self notify("_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");
}

tomastrike_watchdamage() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A2E60C6BC099B7E1A0A93A398F48", "_encstr_93790EDAEDCDA5D1F6E4110BDA0B3B56")]](self.maxhealth, "_encstr_A2FB098A2035874AB0F358", ::tomastrike_watchdeathdamage, ::tomastrike_modifydamage, 1);
}

tomastrike_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2"))
    var_6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2")]](var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4);

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    if(istrue(self.largeprojectiledamage)) {
      earthquake(0.25, 0.2, self.origin, 150);
      self.owner playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
    } else {
      earthquake(0.15, 0.15, self.origin, 150);
      self.owner playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
    }
  }

  self.currenthealth = self.maxhealth - (self.damagetaken + var_6);
  self.owner setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.currenthealth / self.maxhealth);
  return var_6;
}

tomastrike_watchdeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24")]](self.streakname, var_1, var_2, var_3, var_4, self.scorepopup, self.vodestroyed, self.destroyedsplash);

  self notify("_encstr_AD75063D571AE108");
}

tomastrike_watchdestroyed(var_0) {
  self endon("_encstr_8772059DDEDCAC");
  self waittill("_encstr_AD75063D571AE108");

  if(!isDefined(self)) {
    return;
  }
  self.owner notify("_encstr_82271065858A9BBE239BD0709F4DF6DBE2EF");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote())
    self.owner notify("_encstr_A221184B6F90EA11E3E580F71A3FA6CF33EB3AFE79CB19222573", 0);

  thread tomastrike_explode(self.owner, self.origin, "_encstr_95E70D8EDBDA85F5839CED35F5B683", var_0);
}

tomastrike_watchleave(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(35.0);
  self notify("_encstr_BA2D081B2B58B32D37EC");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote())
    self.owner notify("_encstr_A221184B6F90EA11E3E580F71A3FA6CF33EB3AFE79CB19222573", 0);

  if(isDefined(self.turret))
    self.turret delete();

  if(isDefined(self.camera))
    self.camera delete();

  if(isDefined(self.cloudsfx))
    self.cloudsfx delete();

  if(isDefined(var_0))
    var_0 delete();

  thread tomastrike_watchgoal(var_0);
}

tomastrike_watchgoal(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(self.origin != self.pathgoal)
    waitframe();

  level.toma_strikes = scripts\engine\utility::array_remove(level.toma_strikes, self);

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

  self delete();
}

tomastrike_playearthquakeloop() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self.owner earthquakeforplayer(0.07, 0.1, self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37"), 700);
    wait 0.1;
  }
}

tomastrike_watchowner() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner scripts\engine\utility::_id_143A6("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self notify("_encstr_AD75063D571AE108");
}

tomastrike_watchcameraswitch(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");
  var_2 = var_0[0];
  self playerlinkweaponviewtodelta(var_2, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 45, 45, 20, 70, 0);
  self setplayerangles(var_2.angles);
  self.currentclustercamera = var_2;
  self notifyonplayercommand("_encstr_8CA913A7D0400442A9D05ED6216B8BD92EB0776BA0", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_8CA913A7D0400442A9D05ED6216B8BD92EB0776BA0", "_encstr_8D3E0AAA65CAD5995CBF10B8");
  self notifyonplayercommand("_encstr_929E141F57129348C8E7EBFAA0D88BD12F92E7AF3343", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  self notifyonplayercommand("_encstr_929E141F57129348C8E7EBFAA0D88BD12F92E7AF3343", "_encstr_8D4B0BACB5DB6756274BB3D01D");
  var_3 = 0;
  var_4 = var_0.size - 1;
  var_5 = var_3;

  for(;;) {
    var_6 = scripts\engine\utility::_id_143AD("_encstr_8CA913A7D0400442A9D05ED6216B8BD92EB0776BA0", "_encstr_929E141F57129348C8E7EBFAA0D88BD12F92E7AF3343");
    var_7 = var_0[var_5].origin;
    var_8 = self getplayerangles();

    if(!isDefined(var_6)) {
      continue;
    }
    switch (var_6) {
      case "_encstr_8CA913A7D0400442A9D05ED6216B8BD92EB0776BA0":
        var_5++;

        if(var_5 > var_4)
          var_5 = var_3;

        break;
      case "_encstr_929E141F57129348C8E7EBFAA0D88BD12F92E7AF3343":
        var_5--;

        if(var_5 < var_3)
          var_5 = var_4;

        break;
    }

    tomastrike_playercameratransition(var_7, var_8, var_0[var_5], var_1);
    waitframe();
  }
}

tomastrike_playercameratransition(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_4 setModel("_encstr_8E010B996FB7B6B3C1D1183343");
  var_4.owner = self;
  var_4.angles = var_1;
  self playerlinkweaponviewtodelta(var_4, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 0, 0, 0, 0, 0);
  self playerlinkedsetviewznear(0);
  self visionsetfadetoblackforplayer("_encstr_BA07031663", 0.25);
  self visionsetkillstreakforplayer("_encstr_B40101");
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.25);
  self setclientomnvar("_encstr_96AF147D4BA16109B30B11257311A610939CEB2714A3", 0);
  var_3 setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_BA19049F4B2D", 0);
  var_4 moveTo(var_2.origin, 0.25);
  var_4 rotateTo(var_2.angles, 0.25);
  var_4 waittill("_encstr_95640B9CB78E2CD1568CF673B2");
  scripts\mp\utility\player::restorebasevisionset(0.2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  self setclientomnvar("_encstr_96AF147D4BA16109B30B11257311A610939CEB2714A3", 1);
  self visionsetfadetoblackforplayer("_encstr_B40101", 0);
  self visionsetkillstreakforplayer("_encstr_81D2150E4E7B3AF6F5D17B5B0BAF6ED139A55B2BD75B83");
  scripts\mp\utility\player::restorebasevisionset(0);
  var_3 setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_A522069F9340A235", 0);
  self playerlinkweaponviewtodelta(var_2, "_encstr_8E010B996FB7B6B3C1D1183343", 1, 45, 45, 20, 70, 0);
  self.currentclustercamera = var_2;
  var_4 delete();
}

tomastrike_watchreturnplayer(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A221184B6F90EA11E3E580F71A3FA6CF33EB3AFE79CB19222573", var_4);
  tomastrike_returnplayer(var_0, var_1, var_4, var_2, var_3);
}

tomastrike_watchlasertarget(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");

  if(isDefined(var_2)) {
    var_2 endon("_encstr_AD75063D571AE108");
    var_2 endon("_encstr_BA2D081B2B58B32D37EC");
  }

  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notifyonplayercommand("_encstr_B2EC13C2105FE5EF9E550912E4E193E1CFB81ADB48", "_encstr_A9E60828803C73F11780");

  for(;;) {
    self waittill("_encstr_B2EC13C2105FE5EF9E550912E4E193E1CFB81ADB48");

    if(self.clusterammoleft == 0) {
      continue;
    }
    var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
    var_4 setModel("_encstr_9A9A197F4791D38FB57F77DF53256A20B559D5F813FFE79BF188E7");
    var_4 setotherent(self);
    var_4.owner = self;
    thread tomastrike_startlasertarget(var_0, var_2, var_1, var_4, var_3);

    if(var_0 == 2)
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  }
}

tomastrike_watchammousage(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");
  var_3 = 1;

  if(isDefined(var_1)) {
    var_1 endon("_encstr_AD75063D571AE108");
    var_1 endon("_encstr_BA2D081B2B58B32D37EC");
    var_3 = 0;
  }

  for(;;) {
    self waittill("_encstr_B1260A07D50F507F9BFBF8F8");
    self.clusterammoleft--;
    self setclientomnvar("_encstr_ADD1191D20997748DBF32BA76BDFE2B4EFEB835DB0C838D5ADB9C3", self.clusterammoleft);

    if(self.clusterammoleft == 0 && istrue(var_2)) {
      var_0 setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_BA19049F4B2D", 0);
      self setclientomnvar("_encstr_96AF147D4BA16109B30B11257311A610939CEB2714A3", 2);
      wait 5;
      var_0 setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_A522069F9340A235", 0);
      self.clusterammoleft = 3;
      self setclientomnvar("_encstr_96AF147D4BA16109B30B11257311A610939CEB2714A3", 1);
      self setclientomnvar("_encstr_ADD1191D20997748DBF32BA76BDFE2B4EFEB835DB0C838D5ADB9C3", self.clusterammoleft);
      continue;
    }

    self setclientomnvar("_encstr_ADD1191D20997748DBF32BA76BDFE2B4EFEB835DB0C838D5ADB9C3", self.clusterammoleft);

    if(self.clusterammoleft == 0) {
      self notify("_encstr_A221184B6F90EA11E3E580F71A3FA6CF33EB3AFE79CB19222573", var_3);

      if(isDefined(var_0))
        var_0 delete();

      self notify("_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");
      break;
    }
  }
}

tomastrike_movetargetguide(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");

  if(isDefined(var_1)) {
    var_1 endon("_encstr_AD75063D571AE108");
    var_1 endon("_encstr_BA2D081B2B58B32D37EC");
  }

  var_0 setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_A522069F9340A235", 0);

  for(;;) {
    var_2 = tomastrike_getownerlookat(self);
    var_0.origin = var_2;
    waitframe();
  }
}

tomastrike_getownerlookat(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8F3D0D4E3F80D93A908562A277D7A9"))
    return var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8F3D0D4E3F80D93A908562A277D7A9")]]();

  var_1 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07"];
  var_2 = physics_createcontents(var_1);
  var_3 = var_0 getvieworigin();
  var_4 = var_3 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_5 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_125F8();
  var_6 = scripts\engine\trace::ray_trace(var_3, var_4, var_5, var_2);
  var_7 = undefined;

  if(isDefined(var_6["_encstr_AA1C0886968EA32FE056"]) && var_6["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_7 = var_6["_encstr_BD260953AA97E3F014279D"];

  return var_7;
}

tomastrike_watchlaserrelease(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_8B0214794ED7F8E3BEFB6E96282B3BA75788B7A90F5A");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread tomastrike_watchdronedeath();
  var_1 waittill("_encstr_A66E1555FA92BDF1078340D0A755ABA72BA7D96D968B63");
  var_1 notify("_encstr_8DA2143227B77356BE47B0E49DCA3AEB6CC2CDD859C6");
  var_0 setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_BA19049F4B2D", 0);
}

tomastrike_watchdronedeath() {
  var_0 = self.owner;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_A66E1555FA92BDF1078340D0A755ABA72BA7D96D968B63");
  self waittill("_encstr_AD75063D571AE108");
  var_0 notify("_encstr_82271065858A9BBE239BD0709F4DF6DBE2EF");
  var_0 notify("_encstr_8DA2143227B77356BE47B0E49DCA3AEB6CC2CDD859C6");
}

tomastrike_startlasertarget(var_0, var_1, var_2, var_3, var_4) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3.origin = var_2.origin;
  var_3 setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_B8B00782A191CB07D9", 0);

  if(var_0 == 1)
    var_3 thread delayscriptablechangethread(7);
  else
    var_3 thread delayscriptablechangethread(3);

  self playlocalsound("_encstr_A26D199B2B6FA3B167C03FF7543B9BA17B0B6B77F8D9A8BE21BD41");
  self notify("_encstr_B1260A07D50F507F9BFBF8F8");

  if(isDefined(self))
    thread tomastrike_attacktarget(var_0, var_1, var_3, var_4);
}

tomastrike_attacktarget(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8B0214794ED7F8E3BEFB6E96282B3BA75788B7A90F5A");
  var_3.shots_fired++;
  var_4 = undefined;
  var_5 = undefined;

  if(var_0 == 0 || var_0 == 2) {
    var_4 = var_1.origin - (0, 0, 10) + anglesToForward(var_1.angles) * 20;
    var_5 = var_1.angles;
  } else if(var_0 == 1) {
    var_4 = self.currentclustercamera.origin - (0, 0, 3000);
    var_5 = anglestoright(self.currentclustercamera.angles);
  } else {
    var_4 = self.origin + (0, 0, 5000);

    if(!istrue(var_3.vehicle_process_node_when_at_goal))
      var_4 = var_4 - anglesToForward(self.angles) * 5000;

    var_5 = anglestoright(self.angles);
  }

  var_6 = undefined;

  if(isDefined(var_2)) {
    if(isvector(var_2))
      var_6 = var_2;
    else
      var_6 = var_2.origin;
  } else {
    if(var_0 == 5 && isDefined(var_3._id_13A81))
      var_6 = var_3._id_13A81;
    else
      var_6 = tomastrike_getownerlookat(self);

    if(!istrue(var_3._id_11EAE)) {
      var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
      var_2 setModel("_encstr_9A9A197F4791D38FB57F77DF53256A20B559D5F813FFE79BF188E7");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057"))
        var_2.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B6481343D019E0F217299F763213BEF3CF6B375057")]](99);

      var_7 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", 0);

      if(var_7)
        var_2.icon = "_encstr_A51A2007F2E04EA9BFC9238FA554B5D4AE2B30BD90ED096BA330EBEA24236663ABE5";
      else
        var_2.icon = "_encstr_8F911C5A1B7B37BEDDB0BC38EDA5B98EBED8C6ABCD1D2B27DCE893966DAC";

      if(isPlayer(self))
        var_2 setotherent(self);

      if(!istrue(var_3._id_133DC))
        var_2 toma_strike_setmarkerobjective(var_2.objidnum, var_2.icon, self, 50);

      var_2 thread toma_strike_handlemarkerscriptable();
    }
  }

  var_8 = 6;
  var_9 = 300;

  if(var_0 == 5) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B607038AAB", "_encstr_9179131B34C23663CAB9CE59516785365DB0A3DE39")) {
      var_10 = spawnStruct();
      var_10.streakinfo = var_3;
      var_10._id_13A8A = var_6;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B607038AAB", "_encstr_9179131B34C23663CAB9CE59516785365DB0A3DE39")]]("_encstr_828A1FB96AA7904F33DBDBFDC7D90F3839C5E33595C1C0722923D7FBBFD2DF30C3", var_10);
    }

    var_8 = 6;

    if(isDefined(var_3._id_11F47))
      var_8 = var_3._id_11F47;

    var_9 = 900;

    if(isDefined(var_3._id_129E3))
      var_9 = var_3._id_129E3;

    var_11 = var_9;

    if(isDefined(var_3._id_11ECE))
      var_11 = var_3._id_11ECE;

    if(!istrue(var_3._id_133C9) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A2401B452E92BFC11A5B20F0EF261A89DA56435D42FB2B68C2FF1070A7")]](var_6, var_11 + 300, var_3.streakname);
  }

  if(var_0 == 0 || var_0 == 2) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.3);
    var_4 = var_1.origin - (0, 0, 10) + anglesToForward(var_1.angles) * 20;
    var_12 = var_6;
    var_13 = spawnStruct();
    var_13.sourcepos = var_4;
    var_13.goalpos = var_12;
    var_13.initvelocity = var_13.goalpos - var_13.sourcepos;
    thread tomastrike_firestrike(var_13, var_3, var_1);
  } else if(var_0 == 1 || var_0 == 3 || var_0 == 4 || var_0 == 5) {
    var_14 = 2;

    if(isDefined(var_3._id_121AF))
      var_15 = var_3._id_121AF;
    else
      var_15 = anglesToForward(self getplayerangles());

    var_16 = anglesToForward(self.angles);
    var_17 = anglestoright(self.angles);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_14);

    for(var_19 = 0; var_19 < var_8; var_19++) {
      var_20 = undefined;

      if(istrue(var_3.vehicle_process_node_when_at_goal))
        var_20 = var_4;

      var_13 = findunobstructedfiringinfo(var_6, var_9, var_15, var_16, var_17, var_20);
      thread tomastrike_firestrike(var_13, var_3);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(randomfloatrange(1.35, 2.5));
    }

    level.toma_strikes = scripts\engine\utility::array_remove(level.toma_strikes, self);
  }
}

findunobstructedfiringinfo(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_5))
    var_7 = var_5;
  else
    var_7 = _id_13BD5(var_0, var_2, var_3, var_4);

  var_8 = vectorNormalize(var_0 - (var_7[0], var_7[1], 0));
  var_9 = _id_13BD6(var_0, var_1, var_8);
  var_10 = (0, 0, -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800));
  var_11 = (var_9.point - 0.5 * var_10 * squared(4) - var_7) / 4;
  var_13 = var_7 + var_11 * 3.925 + 0.5 * var_10 * squared(3.925);
  var_6.sourcepos = var_7;
  var_6.num_of_frame_frozen = var_9.num_of_frame_frozen;
  var_6.num_of_subway_cars = var_9.num_of_subway_cars;
  var_6.goalpos = var_9.point;
  var_6.preexplpos = var_13;
  var_6.initvelocity = var_11;
  return var_6;
}

delayscriptablechangethread(var_0) {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143B9(var_0, "_encstr_BD5D128FE0A838B98BE7C2BCDD9D71F733E02B5F");
  self setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_BA19049F4B2D", 0);
  self delete();
}

tomastrike_screeninterference(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_2)) {
    var_2 visionsetthermalforplayer(var_1);

    if(isDefined(var_0)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
      var_2 visionsetthermalforplayer(self.currentvisionset);
    }
  }
}

_id_13BD6(var_0, var_1, var_2) {
  var_3 = randomint(var_1);
  var_4 = randomint(360);
  var_5 = var_0[0] + var_3 * cos(var_4);
  var_6 = var_0[1] + var_3 * sin(var_4);
  var_7 = var_0[2];
  var_8 = (var_5, var_6, var_7);

  if(isDefined(var_2))
    var_8 = var_8 - var_2 * 100;

  var_9 = 10000;

  if(isDefined(level._id_13BD3))
    var_9 = level._id_13BD3;

  var_10 = spawnStruct();
  var_11 = scripts\engine\trace::create_default_contents(1);
  var_12 = scripts\engine\trace::ray_trace(var_8 + (0, 0, var_9), var_8 - (0, 0, var_9), undefined, var_11);

  if(isDefined(var_12["_encstr_850E077B0BF30318B9"])) {
    var_13 = var_12["_encstr_850E077B0BF30318B9"];
    var_10.num_of_frame_frozen = var_13;

    if(_id_13BD8(var_13) || _id_13BD7(var_13))
      var_10.num_of_subway_cars = "_encstr_A65507CC1B2F4BDC3B";
  }

  if(isDefined(var_12["_encstr_BD260953AA97E3F014279D"]))
    var_8 = var_12["_encstr_BD260953AA97E3F014279D"];

  var_10.point = var_8;
  return var_10;
}

_id_13BD8(var_0) {
  return var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && istrue(var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly());
}

_id_13BD7(var_0) {
  return isDefined(var_0.streakinfo) && isDefined(var_0.sentientpool) && var_0.sentientpool == "_encstr_81860F1741A58ADBBB43D3B36C79AF3083";
}

tomastrike_firestrike(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_2)) {
    self earthquakeforplayer(0.35, 1, var_2.origin, 1000);
    self playlocalsound("_encstr_8D231263B9A7DBC938F1454BA960CA1F5C50ABCA");
  }

  var_3 = isPlayer(self) || isagent(self);

  if(var_3) {
    var_4 = magicgrenademanual("_encstr_95E70D8EDBDA85F5839CED35F5B683", var_0.sourcepos, var_0.initvelocity, 5, self);
    var_4 setmissileminimapvisible(1);
    var_4 setentityowner(self);
    var_4 setotherent(self);
  } else {
    var_4 = magicgrenademanual("_encstr_95E70D8EDBDA85F5839CED35F5B683", var_0.sourcepos, var_0.initvelocity, 5);
    var_4 setmissileminimapvisible(1);
  }

  var_4 setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_930B07BB1B6B3854FF", 0);
  var_4 setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 0);

  if(isDefined(var_1._id_121A9))
    var_5 = var_1._id_121A9;
  else
    var_5 = "_encstr_8AED1AB69BBE47BD6BB0BEB98E9C4BD6B27DD64B6ECDD2632BEBAD07";

  var_4.explodeent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.origin);
  var_4.explodeent setModel(var_5);
  var_4.explodeent linkTo(var_4);
  var_4.explodeent dontinterpolate();

  if(var_3)
    var_4.explodeent setentityowner(self);

  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.sourcepos);
  var_6 linkTo(var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (10, 0, 10), (0, 0, 0));
  var_4.killcament = var_6;
  var_4.owner = self;
  var_4.streakinfo = var_1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_0.goalpos, 512, 300, self.team, 6, self, 1);

  var_4 thread _id_13BD4();
  var_4 thread toma_strike_watch_airexplosion(var_0.preexplpos, var_0.num_of_frame_frozen, var_0.num_of_subway_cars);
  var_4 thread toma_strike_watch_stuck(vectortoangles(var_0.initvelocity), gettime(), var_0.initvelocity);
}

tomastrike_getmissileendpos(var_0) {
  var_1 = var_0;

  foreach(var_3 in level.players) {
    if(level.teambased && var_3.team == self.team)
      continue;
    else if(!level.teambased && var_3 == self) {
      continue;
    }
    if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(istrue(var_3.markedfortoma)) {
      continue;
    }
    if(distancesquared(var_0, var_3.origin) > 250000) {
      continue;
    }
    var_3.markedfortoma = 1;
    var_1 = var_3.origin;
    var_3 thread clearmarkonrespawn();
    break;
  }

  return var_1;
}

clearmarkonrespawn() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143B9(10, "_encstr_AD75063D571AE108");
  self.markedfortoma = undefined;
}

tomastrike_returnplayer(var_0, var_1, var_2, var_3, var_4) {
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_crouch(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_usability(1);
  scripts\common\utility::allow_killstreaks(1);
  self clearclienttriggeraudiozone(1);

  if(var_1 == 1)
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_A13E0BA3DEDAB04D4793B4AD95");

  if(!istrue(var_2)) {
    if(var_1 == 0) {
      self remotecontrolvehicleoff();
      self cameraunlink();
      self setplayerangles(self.restoreangles);
      self.restoreangles = undefined;
    } else if(var_1 == 2)
      self unlink();
  } else {
    self unlink();
    self setplayerangles(self.restoreangles);
    self.restoreangles = undefined;
  }

  self setclientomnvar("_encstr_96AF147D4BA16109B30B11257311A610939CEB2714A3", 0);
  self setclientomnvar("_encstr_ADD1191D20997748DBF32BA76BDFE2B4EFEB835DB0C838D5ADB9C3", 0);
  self visionsetkillstreakforplayer("_encstr_B40101", 0);
  self visionsetfadetoblackforplayer("_encstr_B40101", 0);
  scripts\mp\utility\player::restorebasevisionset(0);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_3);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_4);
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
}

tomastrike_explode(var_0, var_1, var_2, var_3) {
  self playSound("_encstr_864A1567EDDE83D0DB22E0E83AF77E10F949CBE1910668");

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_92761D6280DB958F894DA795579303DC1BAB8A3A50EB4B03C0AE699C7B5823"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_92761D6280DB958F894DA795579303DC1BAB8A3A50EB4B03C0AE699C7B5823")]](var_1, 1.2);

  level.toma_strikes = scripts\engine\utility::array_remove(level.toma_strikes, self);

  if(isDefined(self.turret))
    self.turret delete();

  if(isDefined(self.camera))
    self.camera delete();

  if(isDefined(self.cloudsfx))
    self.cloudsfx delete();

  if(isDefined(var_3))
    var_3 delete();

  self delete();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();
}

toma_strike_missile_explode(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.exploding = 1;
  self.explodeent unlink();
  self.explodeent.origin = var_0;
  self.explodeent setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_930B07BB1B6B3854FF", 0);
  thread toma_strike_delay_hide();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(self.explodeent))
    self.explodeent delete();

  self delete();
}

toma_strike_delay_hide() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.05;
  self setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self hide();
}

_id_13BD4() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = self.owner;
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self.killcament))
    self.killcament delete();

  self setmissileminimapvisible(0);
  thread toma_strike_missile_explode(self.origin);
  self notify("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
}

toma_strike_watch_airexplosion(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
  self.killcament thread toma_strike_move_killcam(3.675, var_0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.925);
  self setmissileminimapvisible(0);
  thread toma_strike_missile_explode(var_0);

  if(isDefined(var_1) && isDefined(var_2) && var_2 == "_encstr_A65507CC1B2F4BDC3B") {
    var_3 = self.owner;

    if(!isPlayer(var_3))
      var_3 = self;

    var_1 dodamage(500, var_0, var_3, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_95E70D8EDBDA85F5839CED35F5B683"));
  }
}

toma_strike_move_killcam(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self unlink();
  self moveTo(var_1, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

toma_strike_watch_stuck(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_3);
  self setmissileminimapvisible(0);

  if(gettime() - var_1 < 3925.0) {
    thread toma_strike_missile_explode(self.origin);
    self notify("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
  } else {
    wait 0.05;
    var_4 = -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800);
    var_5 = (gettime() - var_1) / 1000;
    var_6 = var_2 + (0, 0, var_4 * var_5);

    if(isDefined(var_3) && isPlayer(var_3)) {
      toma_strike_stuck_player(self, var_3, var_0, var_6);
      return;
    }

    toma_strike_stuck(var_3, var_0, var_6);
  }
}

toma_strike_stuck(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = vectorNormalize(var_2);
  var_5 = anglestoup(self.angles);
  var_6 = anglestoright(var_1);

  if(abs(vectordot(var_4, var_5)) >= 0.9848)
    var_3 = toma_strike_rebuild_angles_up_right(var_5, var_6);
  else
    var_3 = toma_strike_rebuild_angles_up_forward(var_5, var_4);

  self.angles = var_3;
  thread toma_strike_launch_cluster(self, self.origin, var_3, var_0, gettime());
}

toma_strike_stuck_player(var_0, var_1, var_2, var_3) {
  var_3 = var_3 * (0, 0, 1);
  var_4 = var_0.origin;
  var_5 = (0, 0, -1);
  var_6 = var_4 + var_5 * 128;
  var_7 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_8 = physics_raycast(var_4, var_6, var_7, var_0, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_8) && var_8.size > 0) {
    var_6 = var_8[0]["_encstr_BD260953AA97E3F014279D"];
    var_9 = var_8[0]["_encstr_820E07FAE8780B3A4C"];
    var_10 = var_8[0]["_encstr_850E077B0BF30318B9"];
    var_6 = var_6 - var_9 * 1;
    var_11 = -1 * getdvarint("_encstr_979A08F619C1EA8361C7", 800);
    var_12 = vectordot(var_6 - var_4, var_5);
    var_13 = sqrt(2 * var_12 / (-1 * var_11));
    var_14 = var_9;
    var_15 = anglestoright(var_2);
    var_16 = toma_strike_rebuild_angles_up_right(var_14, var_15);
    thread toma_strike_launch_cluster(var_0, var_6, var_16, var_10, gettime() + var_13 * 1000);
  }
}

toma_strike_launch_cluster(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.owner;
  var_6 = var_0.killcament;
  var_7 = anglestoup(var_2);
  var_8 = var_1 + var_7 * 1;
  var_9 = var_8 + var_7 * 25;
  var_10 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  var_11 = physics_raycast(var_8, var_9, var_10, var_0, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_11) && var_11.size > 0)
    var_9 = var_11[0]["_encstr_BD260953AA97E3F014279D"] - var_7 * 1;

  var_12 = var_9;
  var_13 = toma_strike_get_shared_data(var_5, var_0.streakinfo, var_4, var_6);
  var_14 = toma_strike_get_cast_data();
  var_15 = toma_strike_create_branch(var_13, var_14, undefined, var_12, var_2, var_3, 0, undefined, undefined);
  var_13.branches[var_13.branches.size] = var_15;
  var_15.killcament = var_6;
  var_16 = anglesToForward(var_2);
  var_17 = anglestoright(var_2);
  var_18 = anglestoup(var_2);
  var_19 = rotatepointaroundvector(var_18, var_16, 30);
  var_20 = vectorNormalize(vectorcross(var_19, var_18));
  var_21 = vectorcross(var_20, var_16);
  var_22 = axistoangles(var_19, var_20, var_21);
  var_14 = toma_strike_get_cast_data();
  var_15 = toma_strike_create_branch(var_13, var_14, undefined, var_12, var_22, var_3, 0, undefined, undefined);
  var_15.killcament = var_6;
  var_13.branches[var_13.branches.size] = var_15;
  var_19 = rotatepointaroundvector(var_18, var_16, -30);
  var_20 = vectorNormalize(vectorcross(var_19, var_18));
  var_21 = vectorcross(var_20, var_16);
  var_22 = axistoangles(var_19, var_20, var_21);
  var_14 = toma_strike_get_cast_data();
  var_15 = toma_strike_create_branch(var_13, var_14, undefined, var_12, var_22, var_3, 0, undefined, undefined);
  var_15.killcament = var_6;
  var_13.branches[var_13.branches.size] = var_15;
  var_13 toma_strike_shared_data_register_cast();

  foreach(var_15 in var_13.branches)
  var_15 thread toma_strike_start_branch();
}

toma_strike_start_branch() {
  var_0 = self.killcament;

  if(!isDefined(self.preventstarttime))
    self.preventstarttime = gettime();

  if(!isDefined(self.startingcasttype)) {
    if(!self.shareddata toma_strike_shared_data_is_complete()) {
      var_1 = toma_strike_branch_create_explosion(self.startingorigin, self.startingangles, self.startingstuckto, self.shareddata.streakinfo);
      var_1.killcament = var_0;
      var_1 thread toma_strike_start_explosion();
      self.iscomplete = 1;
      self.shareddata toma_strike_shared_data_is_complete(1);
    }
  } else {
    self.caststart = self.startingorigin;
    self.castend = undefined;
    self.castangles = self.startingangles;
    self.castdir = undefined;
    self.casttype = self.startingcasttype;
    self.startingorigin = undefined;
    self.startingangles = undefined;
    self.startingcasttype = undefined;

    for(;;) {
      if(self.shareddata toma_strike_shared_data_is_complete()) {
        break;
      }

      if(toma_strike_branch_is_complete()) {
        break;
      }

      if(!self.shareddata toma_strike_shared_data_can_cast_this_frame()) {
        waitframe();
        continue;
      }

      if(self.casttype == 0) {
        var_2 = self.castdata.firstforwardmodanglesfunc;

        if(isDefined(var_2)) {
          self.castangles = [[var_2]](self.castangles);
          self.castdata.firstforwardmodanglesfunc = undefined;
        }
      }

      self.castdir = toma_strike_get_cast_dir(self.castangles, self.casttype);
      self.castend = self.caststart + self.castdir * toma_strike_get_cast_dist(self.casttype, self.castdata);
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;
      var_8 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

      if(isDefined(var_8) && var_8.size > 0) {
        var_3 = 1;
        var_4 = var_8[0]["_encstr_BD260953AA97E3F014279D"];
        var_5 = var_8[0]["_encstr_820E07FAE8780B3A4C"];
        var_6 = var_8[0]["_encstr_850E077B0BF30318B9"];
      }

      switch (self.casttype) {
        case 0:
          if(istrue(var_3)) {
            toma_strike_branch_register_cast(self.casttype, 0, var_4);
            var_9 = 1;

            if(isDefined(self.castdata.firstforwarddist)) {
              var_10 = var_4 - self.caststart;
              var_11 = vectordot(var_10, self.castdir);
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - var_11;

              if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist)
                var_9 = 0;
              else
                self.castdata.firstforwarddist = undefined;
            }

            var_7 = toma_strike_rebuild_angles_up_right(var_5, anglestoright(self.castangles));

            if(var_9) {
              var_1 = toma_strike_branch_create_explosion(var_4, var_7, var_6, self.shareddata.streakinfo);
              var_1.killcament = var_0;
              var_1 thread toma_strike_start_explosion();
            }

            self.casttype = 2;
            self.caststart = var_4 + var_5 * 1;
            self.castangles = var_7;
          } else {
            toma_strike_branch_register_cast(self.casttype, undefined, undefined);

            if(isDefined(self.castdata.firstforwarddist)) {
              var_10 = self.castend - self.caststart;
              var_11 = vectordot(var_10, self.castdir);
              self.castdata.firstforwarddist = self.castdata.firstforwarddist - var_11;

              if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist)
                self.castdata.firstforwarddist = undefined;
            }

            self.casttype = 1;
            self.caststart = self.castend;
          }

          break;
        case 1:
          if(istrue(var_3)) {
            var_7 = toma_strike_rebuild_angles_up_right(var_5, anglestoright(self.castangles));
            var_1 = toma_strike_branch_create_explosion(var_4, var_7, var_6, self.shareddata.streakinfo);
            var_1.killcament = var_0;
            var_1 thread toma_strike_start_explosion();
            var_12 = vectordot(anglestoup(self.castangles), var_5);

            if(var_12 < 0.9848) {
              toma_strike_branch_register_cast(self.casttype, 2, var_4);
              self.casttype = 2;
              self.caststart = var_4 + var_5 * 1;
              self.castangles = var_7;
            } else {
              toma_strike_branch_register_cast(self.casttype, 1, var_4);
              self.casttype = 0;
            }
          } else {
            toma_strike_branch_register_cast(self.casttype, undefined, undefined);
            self.caststart = self.castend;
          }

          break;
        case 2:
          if(istrue(var_3)) {
            toma_strike_branch_register_cast(self.casttype, 3, var_4);
            self.casttype = 0;
            self.caststart = var_4 + var_5 * 1;
          } else {
            toma_strike_branch_register_cast(self.casttype, undefined, undefined);
            self.casttype = 0;
          }

          break;
      }

      waittillframeend;
    }

    self.iscomplete = 1;
    self.shareddata toma_strike_shared_data_is_complete(1);
    self.shareddata.branches = [];
  }
}

toma_strike_branch_create_explosion(var_0, var_1, var_2, var_3) {
  var_4 = 50;

  if(1)
    var_4 = randomintrange(50, 350);

  var_5 = self.preventstarttime + var_4;
  var_6 = toma_strike_create_explosion(var_0 + anglestoup(var_1), var_1, var_2, self.shareddata.owner, var_5, var_3);
  self.preventstarttime = var_5;
  self.ents[self.ents.size] = var_6;
  self.shareddata toma_strike_shared_data_register_ent();
  return var_6;
}

toma_strike_create_explosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_6.angles = var_1;
  var_6.stuckto = var_2;
  var_6.owner = var_3;
  var_6.starttime = var_4;
  var_6.streakinfo = var_5;

  if(isDefined(var_5._id_121A8))
    var_7 = var_5._id_121A8;
  else
    var_7 = "_encstr_9B591AD6B9AF47DB5B857DCDE839966D59FAB18D5DE6A395E47D6BC1";

  var_6 setModel(var_7);

  if(isPlayer(var_3)) {
    var_6 setotherent(var_3);
    var_6 setentityowner(var_3);
  }

  if(isDefined(var_2))
    var_6 linkTo(var_2);

  return var_6;
}

toma_strike_start_explosion() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.owner endon("_encstr_81170C244F9CBDE72C01BB99A298");

  if(isDefined(self.stuckto))
    self.stuckto endon("_encstr_AD75063D571AE108");

  while(gettime() < self.starttime)
    waitframe();

  thread toma_strike_explosion_end();
}

toma_strike_explosion_end() {
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_930B07BB1B6B3854FF", 0);
  wait 1;
  self delete();
}

toma_strike_shared_data_register_cast() {
  self.caststotal++;
  self.caststhisframe++;
  self.frametimestamp = gettime();
}

toma_strike_shared_data_register_ent() {
  self.entstotal++;
}

toma_strike_shared_data_can_cast_this_frame() {
  if(self.frametimestamp < gettime()) {
    self.frametimestamp = gettime();
    self.caststhisframe = 0;
  }

  return self.caststhisframe < 3;
}

toma_strike_shared_data_is_complete(var_0) {
  var_1 = 0;

  if(self.caststotal >= 60)
    var_1 = 1;
  else if(self.entstotal >= 20)
    var_1 = 1;
  else if(istrue(var_0)) {
    var_2 = 1;

    foreach(var_4 in self.branches) {
      if(!var_4 toma_strike_branch_is_complete()) {
        var_2 = 0;
        break;
      }
    }

    if(var_2)
      var_1 = 1;
  }

  if(var_1)
    self.iscomplete = 1;

  return var_1;
}

toma_strike_branch_register_cast(var_0, var_1, var_2) {
  self.shareddata toma_strike_shared_data_register_cast();
  self.casts++;

  if(isDefined(var_1)) {
    if(var_1 == 0 || var_1 == 1 || var_1 == 2)
      self.castfails = 0;
  } else if(var_0 == 1)
    self.castfails++;
}

toma_strike_branch_is_complete(var_0) {
  var_1 = 0;
  var_2 = undefined;

  if(self.shareddata toma_strike_shared_data_is_complete())
    var_1 = 1;
  else if(isDefined(self.castdata) && self.castfails >= self.castdata.maxfails)
    var_1 = 1;
  else if(isDefined(self.castdata) && self.casts >= self.castdata.maxcasts)
    var_1 = 1;
  else if(isDefined(self.castdata) && self.ents.size >= self.castdata.maxents)
    var_1 = 1;
  else if(istrue(var_0)) {
    var_2 = 1;

    foreach(var_4 in self.branches) {
      if(!var_4 toma_strike_branch_is_complete()) {
        var_2 = 0;
        break;
      }
    }

    if(var_2)
      var_1 = 1;
  }

  if(var_1 && !istrue(self.iscomplete)) {
    var_6 = self.oncompletedfunc;

    if(isDefined(var_6))
      self[[var_6]]();

    if(istrue(var_2)) {
      var_1 = 0;

      foreach(var_4 in self.branches) {
        if(!var_4 toma_strike_branch_is_complete()) {
          var_2 = 0;
          break;
        }
      }

      if(var_2)
        var_1 = 1;
    }
  }

  if(var_1)
    self.iscomplete = 1;

  return var_1;
}

toma_strike_create_branch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.shareddata = var_0;
  var_9.castdata = var_1;
  var_9.startingorigin = var_3;
  var_9.startingangles = var_4;
  var_9.startingstuckto = var_5;
  var_9.startingcasttype = var_6;
  var_9.oncompletedfunc = var_8;
  var_9.ents = [];
  var_9.branches = [];
  var_9.hitpositions = [];
  var_9.hittypes = [];
  var_9.casts = 0;
  var_9.castfails = 0;
  var_9.preventstarttime = var_7;
  return var_9;
}

toma_strike_get_shared_data(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.owner = var_0;
  var_4.team = var_0.team;
  var_4.streakinfo = var_1;
  var_4.impacttime = var_2;
  var_4.branches = [];
  var_4.entstotal = 0;
  var_4.caststotal = 0;
  var_4.caststhisframe = 0;
  var_4.frametimestamp = gettime();
  var_4.castcontents = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA"]);
  return var_4;
}

toma_strike_get_cast_data() {
  var_0 = spawnStruct();
  var_0.distforward = 125;
  var_0.distdown = 50;
  var_0.distup = 25;
  var_0.maxcasts = 12;
  var_0.maxfails = 3;
  var_0.maxents = 4;
  return var_0;
}

toma_strike_get_cast_dir(var_0, var_1) {
  switch (var_1) {
    case 0:
      return anglesToForward(var_0);
    case 1:
      return -1 * anglestoup(var_0);
    case 2:
      return anglestoup(var_0);
  }

  return undefined;
}

toma_strike_get_cast_dist(var_0, var_1) {
  switch (var_0) {
    case 0:
      if(isDefined(var_1.firstforwarddist))
        return var_1.firstforwarddist;
      else
        return var_1.distforward;
    case 1:
      return var_1.distdown;
    case 2:
      return var_1.distup;
  }

  return undefined;
}

toma_strike_rebuild_angles_up_right(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_0, var_1));
  var_1 = vectorcross(var_2, var_0);
  return axistoangles(var_2, var_1, var_0);
}

toma_strike_rebuild_angles_up_forward(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_1, var_0));
  var_1 = vectorcross(var_0, var_2);
  return axistoangles(var_1, var_2, var_0);
}

tomastrike_isremotevehicletype(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      var_1 = 1;
      break;
  }

  return var_1;
}

tomastrike_ismarkertype(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 4:
    case 3:
      var_1 = 1;
      break;
  }

  return var_1;
}

toma_strike_setmarkerobjective(var_0, var_1, var_2, var_3) {
  objective_icon(var_0, var_1);
  objective_showtoplayersinmask(var_0);

  if(isPlayer(var_2))
    objective_addclienttomask(var_0, var_2);

  objective_onentity(var_0, self);
  objective_setzoffset(var_0, var_3);
  objective_setplayintro(var_0, 0);
  objective_setplayoutro(var_0, 0);
  objective_setbackground(var_0, 1);

  if(level.teambased || !isPlayer(var_2))
    objective_setownerteam(var_0, var_2.team);
  else
    objective_setownerclient(var_0, var_2);

  objective_state(var_0, "_encstr_AF5A081BBAC993AC73A3");
}

toma_strike_handlemarkerscriptable() {
  self endon("_encstr_AD75063D571AE108");
  self setscriptablepartstate("_encstr_A16007A921A23B85E3", "_encstr_AB0703DBB9", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](self.objidnum);

    self delete();
  }
}

_id_13BD5(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::create_default_contents(1);
  var_5 = scripts\engine\trace::ray_trace(var_0 - var_1 * 30, var_0 + var_1 * 1000, undefined, var_4);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"] + var_5["_encstr_820E07FAE8780B3A4C"] * 20;
  var_7 = var_6;
  var_8 = 5000;
  var_9 = 5000;
  var_10 = [var_7 + var_2 * 100, var_7 - var_2 * 100, var_7 + var_3 * 100, var_7 - var_3 * 100, var_7 + (var_2 + var_3) * 100, var_7 + (var_2 - var_3) * 100, var_7 + (var_3 - var_2) * 100, var_7 + (-1 * var_2 - var_3) * 100];
  var_11 = var_7 + (0, 0, var_8 * 1.5);

  foreach(var_13 in var_10) {
    var_14 = vectorNormalize(var_13 - var_7);
    var_15 = var_7 + (0, 0, var_8) - var_14 * var_9;
    var_16 = var_7;
    var_17 = scripts\engine\trace::ray_trace_passed(var_15, var_16, undefined, var_4);

    if(!istrue(var_17)) {
      wait 0.05;
      continue;
    }

    var_11 = var_15;
    break;
  }

  return var_11;
}

_id_13BD9(var_0) {
  self endon("_encstr_B67718E6348F33893F4B89E0C3124BC8279FFC6B9EA77BF96712");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_0);
}