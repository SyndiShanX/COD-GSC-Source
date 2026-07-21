/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\uav.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_851904B59B34", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_851904B59B34", "_encstr_88C5055208731B")]]();

  var_0 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size) {
    var_1 = var_0[0].origin;
    var_2 = var_0[1].origin;
    var_3 = (0, 0, 0);
    var_3 = var_2 - var_1;
    var_3 = (var_3[0] / 2, var_3[1] / 2, var_3[2] / 2) + var_1;
    level.uavrotationorigin = var_3;
  } else
    level.uavrotationorigin = (0, 0, 0);

  level.uavrig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.uavrotationorigin);
  level.uavrig setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.uavrig.angles = (0, 115, 0);
  level.uavrig hide();
  level.uavrig.targetname = "_encstr_AB6814D5360B8D480727C8508B5123C9E15D40D58F02";
  level.uavrig thread rotateuavrig(70);
  level.uavrigslow = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.uavrotationorigin);
  level.uavrigslow setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.uavrigslow.angles = (0, 115, 0);
  level.uavrigslow hide();
  level.uavrigslow.targetname = "_encstr_AB6814D5360B8D480727C8508B5123C9E15D40D58F02";
  level.uavrigslow thread rotateuavrig(90);
  level.counteruavrig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.uavrotationorigin);
  level.counteruavrig setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.counteruavrig.angles = (0, 115, 0);
  level.counteruavrig hide();
  level.counteruavrig.targetname = "_encstr_8CBE1B563DB33D53BD1B60C863C2885779A2DE66143BC1FE6D57F09013";
  level.counteruavrig thread rotateuavrig(80);
  level.advanceduavrig = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", level.uavrotationorigin);
  level.advanceduavrig setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.advanceduavrig.angles = (0, 115, 0);
  level.advanceduavrig hide();
  level.advanceduavrig.targetname = "_encstr_AF1F1CA9F50B47257F98EAF3907D1ADF81F023231630CBEB5FA042DAA8B1";
  level.advanceduavrig thread rotateuavrig(200);
  level._id_13EDE = getuavstrengthmin();
  level._id_13ED9 = getuavstrengthmax();
  level._id_13EDA = getuavstrengthlevelshowenemydirectional();
  level._id_13EDC = getuavstrengthlevelneutral();
  level._id_13EDB = getuavstrengthlevelshowenemyfastsweep();

  if(!isDefined(level._id_13EDD) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8"))
    level._id_13EDD = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_965B13E617BA0BC850DC2AB285B554B9B0131B95C8")]]() && getdvarint("_encstr_B2D8177B77AD67EFA3DDDE475F73C83848E08848EF457ED060", 1);

  if(level.teambased && !istrue(level._id_13EDD)) {
    for(var_4 = 0; var_4 < level.teamnamelist.size; var_4++) {
      level.radarmode[level.teamnamelist[var_4]] = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
      level.activeuavs[level.teamnamelist[var_4]] = 0;
      level.activecounteruavs[level.teamnamelist[var_4]] = 0;
      level.activeadvanceduavs[level.teamnamelist[var_4]] = 0;
      level.uavmodels[level.teamnamelist[var_4]] = [];
    }
  } else {
    level.radarmode = [];
    level.activeuavs = [];
    level.activecounteruavs = [];
    level.activeadvanceduavs = [];
    level.uavmodels = [];
  }

  level.totalactiveuavs = 0;
  level.totalactivecounteruavs = 0;
  level.audio_heli_end_fade_out = 0;
  level thread onplayerconnect();
  level thread uavtracker();
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99BA0E2357C67F1FBF231B7537BF9321"] = "_encstr_99BA0E2357C67F1FBF231B7537BF9321";
}

onplayerconnect() {
  var_0 = getuavstrengthlevelneutral();
  var_1 = level.teambased && istrue(level._id_13EDD);

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_2);

    if(var_1) {
      var_2 thread _id_12090();
      continue;
    }

    level.activeuavs[var_2.guid] = 0;
    level.activeuavs[var_2.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"] = var_0;
    level.activecounteruavs[var_2.guid] = 0;
    level.radarmode[var_2.guid] = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
    var_2.radarstrength = var_0;
  }
}

_id_12090() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(!isDefined(self.squadindex))
    waitframe();

  var_0 = self.team + self.squadindex;

  if(!isDefined(level.radarmode[var_0]))
    level.radarmode[var_0] = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

  if(!isDefined(level.activeuavs[var_0]))
    level.activeuavs[var_0] = 0;

  if(!isDefined(level.activecounteruavs[var_0]))
    level.activecounteruavs[var_0] = 0;

  if(!isDefined(level.activeadvanceduavs[var_0]))
    level.activeadvanceduavs[var_0] = 0;

  if(!isDefined(level.uavmodels[var_0]))
    level.uavmodels[var_0] = [];
}

onplayerspawned() {
  level notify("_encstr_8B540B6DB903360BFAAAF85852");
}

rotateuavrig(var_0, var_1, var_2) {
  if(isDefined(var_2))
    self endon(var_2);

  if(!isDefined(var_0))
    var_0 = 60;

  if(!isDefined(var_1))
    var_1 = -360;

  for(;;) {
    self rotateYaw(var_1, var_0);
    wait(var_0);
  }
}

tryuseuav(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryuseuavfromstruct(var_1);
}

tryuseuavfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  if(istrue(level._encstr_88BE13E819E97B95C0A3F0B683509FA9778B8BFB9D)) {
    var_1 = "_encstr_BA0D2B25A348AB0AD719C10FB9B90FB9A1FD5983585A2A3D5D36A536BCEA8EF9B0C6ACF4EF89E22F470A2DC7AB";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_1);

    return 0;
  }

  var_2 = 0;

  if(level.teambased && isDefined(level.teamdata) && isDefined(level.teamdata[self.team]) && isDefined(level.teamdata[self.team]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"])) {
    var_3 = level.teamdata[self.team]["_encstr_85F0132F46DB4B5BF5C728F8B30472F7336F952FDA"].size;
    var_2 = var_3 > 0;
  }

  if(var_2) {
    var_1 = "_encstr_952F2FF94AA9DD1F0F6F31013765B5AF41A3487C5087CB8B572FE1B15B4CCE77995BCDED3AF97B0CFF3BC1511F8A052761";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_1);

    return 0;
  }

  if(!istrue(var_0._id_133CC)) {
    var_4 = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";

    if(scripts\cp_mp\utility\game_utility::_id_140A9())
      var_4 = "_encstr_92EA1A170F3174E0A3CB73ABB7A738BDFABFDD9BD799C910F766D88B";

    var_5 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname(var_4));

    if(!istrue(var_5))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  var_1 = useuav(var_0.streakname, var_0);
  return istrue(var_1);
}

useuav(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_0, self.origin);

  var_2 = self.pers["_encstr_8AEF05472BC2D6"];
  var_3 = self.squadindex;
  var_4 = level.uavsettings[var_0].timeout;
  var_5 = 0;

  if(level.gametype == "_encstr_B607038AAB")
    var_5 = 1;

  scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_AC4D2E4B5276C322171CAD65F6131AB79908A393C96836996B273311EC27336FA0E81F63C0637F13E7C9FC124EF3BA16", 1);
  scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_817C32139AEF96EBAE8C545F1631A3D13FE01A0A417B0DFFC3E736773C1813697F83326328E905737ED921534EE01FEDF760EB9F", 1);

  if(getdvarint("_encstr_B4CA0B19CBC12E11DB85F4AF7C", 1) >= 8)
    scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F("_encstr_887C32D19CBE8D43AF3B8DF62685D87D1B168D63AFA573AF57C2677D99DBE4AFBD1CCAE4C2E8F627D7D62DB99BB4EDCDD7B707CC", 1);

  level thread launchuav(self, var_0, var_1, var_5);

  switch (var_0) {
    case "_encstr_8C9D0C506F0B96A8F78B297BF313":
      self notify("_encstr_BA95115D37CA23EBB1ED5DE63A2B39AFEA0BD9");
      break;
    case "_encstr_81CC0586854EC1":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
      self.radarshowenemydirection = 1;

      if(level.teambased) {
        foreach(var_7 in level.players) {
          if(var_7.pers["_encstr_8AEF05472BC2D6"] == var_2) {
            if(istrue(level._id_13EDD) && var_7.squadindex != var_3) {
              continue;
            }
            var_7.radarshowenemydirection = 1;
          }
        }
      }

      self notify("_encstr_991115BA3795467D32A593958D8E2DBD9B85637DEA2CEC");
      break;
    default:
      self notify("_encstr_8F0A0960FB97193E0F81DC");
      break;
  }

  return 1;
}

_id_13320(var_0) {
  if(level.gametype != "_encstr_B607038AAB")
    return 0;

  if(var_0 != "_encstr_851904B59B34")
    return 0;

  var_1 = undefined;

  if(level.teambased) {
    var_1 = self.team;

    if(istrue(level._id_13EDD))
      var_1 = self.team + self.squadindex;
  } else
    var_1 = self.guid;

  var_2 = level.activeadvanceduavs[var_1] > 0;

  if(var_2)
    return 0;

  var_3 = level.activeuavs[var_1];
  var_4 = _getradarstrength(var_3 + 1, 0, 0);
  var_5 = getuavstrengthlevelshowenemydirectional();
  return var_4 >= var_5;
}

launchuav(var_0, var_1, var_2, var_3) {
  var_4 = var_0.team;
  var_5 = var_0.squadindex;
  var_6 = getuavrig(var_1);

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    if(level.gametype == "_encstr_B81904B04E6B") {
      if(isDefined(level.hqmidpoint))
        var_6.origin = level.hqmidpoint;
    } else
      var_6.origin = var_0.origin;
  }

  var_7 = undefined;

  if(istrue(var_3)) {
    var_7 = spawnStruct();
    var_7.damagetaken = 0;
  } else
    var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6 gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37") + (0, 0, 5000));

  var_8 = level.uavsettings[var_1].modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0) && isDefined(level.uavsettings[var_1].modelbasealt))
    var_8 = level.uavsettings[var_1].modelbasealt;

  var_9 = level.uavsettings[var_1].timeout;
  var_11 = level.uavsettings[var_1].maxhealth;
  var_12 = level.uavsettings[var_1].teamsplash;
  var_13 = var_2.streakname;

  if(var_0 _id_13320(var_1))
    var_13 = "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950";

  var_14 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](var_0, var_13);
    var_14 = 2.0;
  }

  if(level.gametype == "_encstr_B607038AAB")
    var_0 _id_13ED5(var_4, 15000, var_13);

  if(var_1 == "_encstr_81CC0586854EC1") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88570CF010DD1A4F086A07363072"))
      var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88570CF010DD1A4F086A07363072")]](var_0);
  }

  var_0 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_13, 1, var_14);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_12, var_0);

  if(isent(var_7))
    var_7 setModel(var_8);

  var_7.team = var_4;
  var_7.owner = var_0;
  var_7.timetoadd = 0;
  var_7.uavtype = var_1;
  var_7.health = level.uavsettings[var_1].health;
  var_7.maxhealth = var_11;
  var_7.streakinfo = var_2;
  var_7 thread monitorowner();
  var_7 thread restorestrengthafterhostmigration();
  var_7 thread watchgameend();

  if(isent(var_7)) {
    var_7 setotherent(var_0);
    var_7 scriptmoveroutline();
    var_7 scriptmoverthermal();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
      var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0);

    var_7 thread damagetracker();
    var_7 thread handleincomingstinger();
    var_7 thread perkengineer_manageminimap();
    var_7 thread trackvelocity();
    var_7 setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_AB0703DBB9", 0);
    var_15 = randomintrange(6000, 6500);

    if(var_7.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || var_7.uavtype == "_encstr_81CC0586854EC1")
      var_15 = randomintrange(30000, 31000);

    if(isDefined(level.spawnpoints))
      var_16 = level.spawnpoints;
    else
      var_16 = level.startspawnpoints;

    if(!isDefined(var_16)) {
      var_17 = spawnStruct();
      var_17.origin = (var_0.origin[0], var_0.origin[1], 6969);
      var_16 = [var_17];
    }

    var_18 = var_16[0];

    foreach(var_17 in var_16) {
      if(var_17.origin[2] < var_18.origin[2])
        var_18 = var_17;
    }

    var_21 = var_18.origin[2];
    var_22 = var_6.origin[2];

    if(var_21 < 0) {
      var_22 = var_22 + var_21 * -1;
      var_21 = 0;
    }

    var_23 = randomint(360);
    var_24 = randomint(1000);

    if(var_7.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || var_7.uavtype == "_encstr_81CC0586854EC1")
      var_24 = randomintrange(20000, 22000);

    var_25 = var_24 + 4000;
    var_26 = cos(var_23) * var_25;
    var_27 = sin(var_23) * var_25;
    var_28 = vectorNormalize((var_26, var_27, var_15));
    var_28 = var_28 * var_15;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
      var_29 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

      if(var_29 == "_encstr_B607038AAB") {
        var_30 = (0, 0, 3000);
        var_28 = var_28 + var_30;
      }
    }

    var_7 linkTo(var_6, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_28, (0, var_23 - 90, 0));
    var_7 thread updateuavmodelvisibility();
  }

  var_7[[level.uavsettings[var_1].addfunc]]();

  if(var_1 == "_encstr_851904B59B34" || var_1 == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || var_7.uavtype == "_encstr_81CC0586854EC1") {
    var_7 revealminimapforteam(1);
    var_7 thread applymapenableonspawn();
  }

  if(isDefined(level.activeuavs[var_4]) && level.activeuavs[var_4] > 0) {
    if(isent(var_7)) {
      foreach(var_32 in level.uavmodels[var_4]) {
        if(var_32 == var_7) {
          continue;
        }
        if(isDefined(var_32.timetoadd))
          var_32.timetoadd = var_32.timetoadd + 5;
      }
    } else
      var_7.timetoadd = 5 * (level.activeuavs[var_4] - 1);
  }

  var_7 thread handlewiretap();
  level notify("_encstr_8B540B6DB903360BFAAAF85852");
  var_7 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("_encstr_AD75063D571AE108", var_9);

  if(isDefined(var_7) && var_7.damagetaken < var_7.maxhealth) {
    if(isent(var_7)) {
      var_7 unlink();
      var_7.lb_dmg_factor_fuselage = var_7.origin + anglesToForward(var_7.angles) * 50000;
      var_7 moveTo(var_7.lb_dmg_factor_fuselage, 50);

      if(isDefined(level.uavsettings[var_1].fxid_leave) && isDefined(level.uavsettings[var_1].fx_leave_tag))
        playFXOnTag(level.uavsettings[var_1].fxid_leave, var_7, level.uavsettings[var_1].fx_leave_tag);
    }

    if(isDefined(var_0) && !istrue(level.gameended))
      var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(level.uavsettings[var_7.uavtype].votimeout, 1);

    var_7 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("_encstr_AD75063D571AE108", 3);

    if(isDefined(var_7) && var_7.damagetaken < var_7.maxhealth) {
      var_7 notify("_encstr_BA2D081B2B58B32D37EC");
      var_7.isleaving = 1;

      if(var_1 == "_encstr_81CC0586854EC1") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A52F0C5090A2BA24C361597223AB"))
          var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A52F0C5090A2BA24C361597223AB")]](var_0);
      }

      if(isent(var_7))
        var_7 moveTo(var_7.lb_dmg_factor_fuselage, 15);

      var_7 scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("_encstr_AD75063D571AE108", 4 + var_7.timetoadd);

      if(isDefined(var_7) && var_7.damagetaken < var_7.maxhealth)
        var_7.leftplayspace = 1;
    }
  }

  if(isDefined(var_7)) {
    var_7.owner notify("_encstr_B1C80D55912B1E35A4E240889A7FF9");

    if(var_1 == "_encstr_851904B59B34" || var_1 == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || var_1 == "_encstr_81CC0586854EC1")
      var_7 revealminimapforteam(level.minimaponbydefault);

    var_7[[level.uavsettings[var_1].removefunc]]();

    if(isDefined(level.killstreakfinishusefunc))
      level thread[[level.killstreakfinishusefunc]](var_2);

    if(isDefined(var_7.enemyobjid)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_867712AA1378832BD004D25AA9BECB7C808B1924")]](var_7.enemyobjid);

      var_7 notify("_encstr_81A01443291B468D7232BDCDBD909E531D12C3980C95");
    }

    var_7.streakinfo.onspray = !istrue(var_7.leftplayspace);

    if(!istrue(self._id_12AA4))
      var_7.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(var_7.streakinfo);

    if(isent(var_7))
      var_7 delete();
    else
      var_7 notify("_encstr_AD75063D571AE108");
  }

  if(var_1 == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950") {
    if(isDefined(var_0))
      var_0.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(var_35 in level.players) {
        if(isDefined(var_35) && var_35.pers["_encstr_8AEF05472BC2D6"] == var_4) {
          if(istrue(level._id_13EDD) && var_35.squadindex != var_5) {
            continue;
          }
          var_35.radarshowenemydirection = 0;
        }
      }
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_841B100E39B49BA3A3B0B5B2A01B47D2DBDC")]]("_encstr_8887145B961BD86E8EC9AC16B601ACDC8C5923109604" + var_1, var_0);

  level notify("_encstr_8B540B6DB903360BFAAAF85852");
}

monitorowner() {
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143A5("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_81170C244F9CBDE72C01BB99A298");

  if(isent(self)) {
    self hide();
    var_0 = anglestoright(self.angles) * 200;
    playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_0);
    playsoundatpos(self.origin, level.uavsettings[self.uavtype].sound_explode);
    self.damagetaken = self.maxhealth;
  }

  self notify("_encstr_AD75063D571AE108");
}

restorestrengthafterhostmigration() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_85A51314B8F75347B068B7FB30CB39AAB5D8DF0D95");

    if(level.teambased) {
      foreach(var_1 in level.teamnamelist) {
        if(istrue(level._id_13EDD)) {
          foreach(var_6, var_3 in level.squaddata[var_1]) {
            var_4 = var_1 + var_6;
            var_5 = aigroundturret_cancel(var_4);
            ammobox_showattachmentflyout(var_1, var_6, var_5);
          }

          continue;
        }

        var_5 = aigroundturret_mountcompleted(var_1);
        _setteamradarstrength(var_1, var_5);
      }
    }
  }
}

updateuavmodelvisibility() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level scripts\engine\utility::waittill_either("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_8B540B6DB903360BFAAAF85852");
    self hide();

    foreach(var_1 in level.players) {
      if(level.teambased) {
        if(var_1.team != self.team)
          self showtoplayer(var_1);

        continue;
      }

      if(isDefined(self.owner) && var_1 == self.owner) {
        continue;
      }
      self showtoplayer(var_1);
    }
  }
}

damagetracker() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setCanDamage(1);
  self.damagetaken = 0;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A30108473FBA97C8D662", "_encstr_A1400A6BC2E0AB951683B7B9"))
      var_9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A30108473FBA97C8D662", "_encstr_A1400A6BC2E0AB951683B7B9")]](var_9, var_13);

    if(!isPlayer(var_1)) {
      if(!isDefined(self))
        return;
    } else {
      if((self.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || self.uavtype == "_encstr_81CC0586854EC1") && (var_4 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_4 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_4 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")) {
        continue;
      }
      if(isDefined(var_8) && var_8 &level.idflags_penetration)
        self.wasdamagedfrombulletpenetration = 1;

      if(isDefined(var_8) && var_8 &level.idflags_ricochet)
        self.wasdamagedfrombulletricochet = 1;

      self.wasdamaged = 1;
      var_14 = var_0;

      if(isPlayer(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
          var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_A2FB098A2035874AB0F358");

        if(var_4 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_4 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215") {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
            if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_872D180B63F7EE100E3CA1B36776B0A1B7DBE3F09A7316D8E50F"))
              var_14 = var_14 + var_0 * level.armorpiercingmod;
          }
        }
      }

      var_15 = 1;
      var_16 = 1;
      var_17 = 1;
      var_18 = 0;
      var_19 = 3;

      if(self.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || self.uavtype == "_encstr_81CC0586854EC1") {
        var_15 = 5;
        var_16 = 6;
        var_17 = 7;
        var_18 = 0;
        var_19 = 0;
      }

      if(isDefined(var_9)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2"))
          var_14 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2")]](var_1, var_9, var_4, var_14, self.maxhealth, var_15, var_16, var_17, var_18, var_19);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071")]](var_1, var_9, self, var_4, var_14);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_A2CC1636B7B3051D1D1636DA2B27D25AC636E6A39C95C2DA"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_A2CC1636B7B3051D1D1636DA2B27D25AC636E6A39C95C2DA")]](self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, createheadicon(var_9));
      }

      self.damagetaken = self.damagetaken + var_14;

      if(self.damagetaken >= self.maxhealth) {
        if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
          var_20 = level.uavsettings[self.uavtype].calloutdestroyed;
          var_21 = "_encstr_ACB80B32E13893EAC81A9F1209" + self.uavtype;

          if(self.uavtype == "_encstr_851904B59B34") {
            var_21 = undefined;
            self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_99BA0E2357C67F1FBF231B7537BF9321", 1);
          }

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24"))
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24")]](self.uavtype, var_1, var_9, var_4, var_0, "_encstr_ACB80B32E13893EAC81A9F1209" + self.uavtype, var_21, var_20);

          if(isDefined(self.uavremotemarkedby) && self.uavremotemarkedby != var_1) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_851904B59B34", "_encstr_924B1EBBB0434D43212DC12EC06B939587181323A133075719ADC903EE10EF1B"))
              self.uavremotemarkedby thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_851904B59B34", "_encstr_924B1EBBB0434D43212DC12EC06B939587181323A133075719ADC903EE10EF1B")]]();
          }
        }

        self hide();
        var_22 = anglestoright(self.angles) * 200;
        playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_22);
        playsoundatpos(self.origin, level.uavsettings[self.uavtype].sound_explode);
        self notify("_encstr_AD75063D571AE108");
        return;
      }
    }
  }
}

uavtracker() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_8B540B6DB903360BFAAAF85852");

    if(level.teambased) {
      foreach(var_1 in level.teamnamelist) {
        if(istrue(level._id_13EDD)) {
          if(isDefined(level.squaddata)) {
            foreach(var_4, var_3 in level.squaddata[var_1])
            _id_14020(var_1, var_4);
          }

          continue;
        }

        updateteamuavstatus(var_1);
      }

      continue;
    }

    updateplayersuavstatus();
  }
}

handlewiretap() {
  foreach(var_1 in level.players) {
    if(isDefined(self.streakname) && (self.streakname == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || self.streakname == "_encstr_8C9D0C506F0B96A8F78B297BF313" || self.uavtype == "_encstr_81CC0586854EC1")) {
      return;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_82E61BB90795365A85C68EE5FA2B3C07C2CD23958CD7B54BCD2DB58507"))
        continue;
    }

    if(var_1.team == self.team) {
      continue;
    }
    thread executewiretapsweeps(var_1);
  }
}

executewiretapsweeps(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  triggeroneoffradarsweep(var_0);
  self waittill("_encstr_AD75063D571AE108");
  triggeroneoffradarsweep(var_0);
}

aigroundturret_cancel(var_0) {
  var_1 = scripts\engine\utility::ter_op(isDefined(level.activeuavs[var_0]), level.activeuavs[var_0], 0);
  var_2 = scripts\engine\utility::ter_op(isDefined(level.activeadvanceduavs[var_0]), level.activeadvanceduavs[var_0], 0);
  var_3 = scripts\engine\utility::ter_op(isDefined(level.activecounteruavs[var_0]), level.activecounteruavs[var_0], 0);
  var_3 = level.totalactivecounteruavs - var_3;
  return _getradarstrength(var_1, var_2, var_3);
}

aigroundturret_mountcompleted(var_0) {
  var_1 = level.activeuavs[var_0];
  var_2 = level.activeadvanceduavs[var_0];
  var_3 = level.totalactivecounteruavs - level.activecounteruavs[var_0];
  return _getradarstrength(var_1, var_2, var_3);
}

_getradarstrength(var_0, var_1, var_2) {
  var_3 = getuavstrengthmin();
  var_4 = getuavstrengthmax();

  if(var_1)
    var_0 = var_4 - getuavstrengthlevelneutral();

  if(level.gametype == "_encstr_B607038AAB")
    var_5 = int(clamp(var_0 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemydirectional()));
  else if(var_2 > 0)
    var_5 = var_3;
  else if(var_1 > 0)
    var_5 = var_4;
  else
    var_5 = int(clamp(var_0 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep()));

  var_5 = int(clamp(var_5, var_3, var_4));
  return var_5;
}

_setteamradarstrength(var_0, var_1) {
  updateteamuavstatus(var_0, var_1);
}

ammobox_showattachmentflyout(var_0, var_1, var_2) {
  _id_14020(var_0, var_1, var_2);
}

updateteamuavstatus(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = var_1;
  else
    var_2 = aigroundturret_mountcompleted(var_0);

  _id_13FDF(var_2, var_0);
}

_id_14020(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = var_2;
  else {
    var_4 = var_0 + var_1;
    var_3 = aigroundturret_cancel(var_4);
  }

  _id_13FDF(var_3, var_0, var_1);
}

_id_13FDF(var_0, var_1, var_2) {
  var_0 = int(max(min(var_0, level._id_13ED9), level._id_13EDE));
  var_3 = var_0 == level._id_13EDE;
  var_4 = !var_3;
  var_5 = var_0 >= level._id_13EDA;
  var_6 = !var_3;

  if(var_0 == level._id_13EDC) {
    var_7 = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
    var_4 = 0;
  } else if(var_0 == level._id_13ED9 || var_5)
    var_7 = "_encstr_A93F0F1B7B739BE8859BD1D727B0465839";
  else if(var_0 == level._id_13EDB)
    var_7 = "_encstr_A7490B76D3880B6726096A2273";
  else
    var_7 = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

  var_8 = level.players;

  if(isDefined(var_2))
    var_8 = level.squaddata[var_1][var_2].players;
  else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_8FE20C82D819FB7FC9699CB1FD91"))
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8FE20C82D819FB7FC9699CB1FD91")]](var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }
    if(istrue(var_10.tracking_obit)) {
      continue;
    }
    if(istrue(var_10._id_133E9)) {
      continue;
    }
    var_10.radarstrength = var_0;
    var_10.isradarblocked = var_3;
    var_10.hasradar = var_4;
    var_10.radarshowenemydirection = var_5;

    if(var_10.radarshowenemydirection) {
      var_10.radarmode = "_encstr_A93F0F1B7B739BE8859BD1D727B0465839";
      continue;
    }

    var_10.radarmode = var_7;
  }
}

updateplayersuavstatus() {
  foreach(var_1 in level.players) {
    if(istrue(var_1.tracking_obit)) {
      continue;
    }
    var_2 = level.activeuavs[var_1.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"];
    var_3 = level.totalactivecounteruavs - level.activecounteruavs[var_1.guid];

    if(var_3 > 0)
      var_2 = level._id_13EDE;

    var_2 = int(max(min(var_2, level._id_13ED9), level._id_13EDE));
    var_1.radarstrength = var_2;
    var_4 = var_1.team == "_encstr_AF8C0A1B6A1D6045925B4F7D" || var_1.team == "_encstr_933E090A10B17DDFB3E522" || var_1.team == "_encstr_BD78059C33C543";

    if(var_2 <= level._id_13EDC || var_4) {
      var_1.hasradar = 0;
      var_1.radarshowenemydirection = 0;

      if(isDefined(var_1.radarmode) && var_1.radarmode == "_encstr_A93F0F1B7B739BE8859BD1D727B0465839")
        var_1.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

      continue;
    }

    if(var_2 >= level._id_13EDB)
      var_1.radarmode = "_encstr_A7490B76D3880B6726096A2273";
    else
      var_1.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

    var_1.radarshowenemydirection = var_2 >= level._id_13EDA;

    if(istrue(var_1.radarshowenemydirection))
      var_1.radarmode = "_encstr_A93F0F1B7B739BE8859BD1D727B0465839";

    var_1.hasradar = 1;
  }
}

handleincomingstinger() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_A1B90EC33B80328870DB219DE446B39B", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    var_1 thread stingerproximitydetonate(var_2, var_0);
  }
}

trackvelocity() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.velocity = (0, 0, 0);

  for(;;) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

watchgameend() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_B1C80D55912B1E35A4E240889A7FF9");
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  self._id_12AA4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
}

stingerproximitydetonate(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = distance(self.origin, var_0 getpointinbounds(0, 0, 0));
  var_3 = var_0 getpointinbounds(0, 0, 0);

  for(;;) {
    if(!isDefined(var_0))
      var_4 = var_3;
    else
      var_4 = var_0 getpointinbounds(0, 0, 0);

    var_3 = var_4;
    var_5 = distance(self.origin, var_4);

    if(var_5 < var_2)
      var_2 = var_5;

    if(var_5 > var_2) {
      if(var_5 > 1536) {
        return;
      }
      radiusdamage(self.origin, 1536, 600, 600, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9B69114A571F8EBD17484FBA87220987C71A97");
      self hide();
      self notify("_encstr_8BE208E31FA8E1631D65");
      waitframe();
      self delete();
      var_1 notify("_encstr_BA7F15E8D0B3C5BF5072F187A7E1A0ABC7C4DA7F43355F");
    }

    waitframe();
  }
}

adduavmodel() {
  if(level.teambased) {
    if(istrue(level._id_13EDD)) {
      self.squadindex = self.owner.squadindex;
      self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973 = self.team + self.owner.squadindex;
      level.uavmodels[self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973][level.uavmodels[self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973].size] = self;
    } else
      level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
  } else
    level.uavmodels[self.owner.guid + "_encstr_BA4C02DF" + gettime()] = self;
}

removeuavmodel() {
  var_0 = [];

  if(level.teambased) {
    var_1 = self.team;
    var_2 = self.owner.squadindex;

    if(istrue(level._id_13EDD)) {
      foreach(var_4 in level.uavmodels[self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973]) {
        if(!isDefined(var_4)) {
          continue;
        }
        var_0[var_0.size] = var_4;
      }

      level.uavmodels[self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973] = var_0;
      return;
    }

    foreach(var_4 in level.uavmodels[var_1]) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_0[var_0.size] = var_4;
    }

    level.uavmodels[var_1] = var_0;
    return;
  } else {
    foreach(var_4 in level.uavmodels) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_0[var_0.size] = var_4;
    }

    level.uavmodels = var_0;
  }
}

addactiveuav() {
  level.totalactiveuavs++;

  if(level.teambased) {
    var_0 = self.team;

    if(istrue(level._id_13EDD)) {
      self.squadindex = self.owner.squadindex;
      self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973 = self.team + self.owner.squadindex;
      var_0 = self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973;
    }

    level.activeuavs[var_0]++;

    if(self.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || self.uavtype == "_encstr_81CC0586854EC1") {
      level.activeadvanceduavs[var_0]++;
      level.audio_heli_end_fade_out++;
      return;
    }
  } else {
    level.activeuavs[self.owner.guid]++;
    level.activeuavs[self.owner.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"]++;

    if(self.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || self.uavtype == "_encstr_81CC0586854EC1") {
      level.activeuavs[self.owner.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"] = level.activeuavs[self.owner.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"] + 2;

      if(!isDefined(level.activeadvanceduavs[self.owner.guid]))
        level.activeadvanceduavs[self.owner.guid] = 0;

      level.activeadvanceduavs[self.owner.guid]++;
      level.audio_heli_end_fade_out++;
    }
  }
}

addactivecounteruav() {
  if(level.teambased) {
    if(istrue(level._id_13EDD)) {
      self.squadindex = self.owner.squadindex;
      self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973 = self.team + self.owner.squadindex;
      level.activecounteruavs[self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973]++;
    } else
      level.activecounteruavs[self.team]++;
  } else
    level.activecounteruavs[self.owner.guid]++;

  level.totalactivecounteruavs++;
}

removeactiveuav() {
  if(level.teambased) {
    var_0 = self.team;

    if(istrue(level._id_13EDD))
      var_0 = self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973;

    level.activeuavs[var_0]--;
    level.totalactiveuavs--;

    if(self.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || self.uavtype == "_encstr_81CC0586854EC1") {
      level.activeadvanceduavs[var_0]--;
      level.audio_heli_end_fade_out--;
      return;
    }
  } else if(isDefined(self.owner)) {
    level.activeuavs[self.owner.guid]--;
    level.totalactiveuavs--;
    level.activeuavs[self.owner.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"]--;

    if(self.uavtype == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950" || self.uavtype == "_encstr_81CC0586854EC1") {
      level.activeuavs[self.owner.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"] = level.activeuavs[self.owner.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"] - 2;
      level.activeadvanceduavs[self.owner.guid]--;
      level.audio_heli_end_fade_out--;
    }
  }
}

removeactivecounteruav() {
  if(level.teambased) {
    if(istrue(level._id_13EDD))
      level.activecounteruavs[self._encstr_8E0B0F0D5DBF90A71A1B5878F2F5B12973]--;
    else
      level.activecounteruavs[self.team]--;
  } else if(isDefined(self.owner))
    level.activecounteruavs[self.owner.guid]--;

  level.totalactivecounteruavs--;
}

watchhighlightfadetime(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    var_3 endon("_encstr_AD75063D571AE108");

  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143BF(var_2, "_encstr_B10A068D255BFBC5");

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_0, var_1);
  }
}

getuavrig(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_851904B59B34":
      var_1 = level.uavrig;
      break;
    case "_encstr_8C9D0C506F0B96A8F78B297BF313":
      var_1 = level.counteruavrig;
      break;
    case "_encstr_81CC0586854EC1":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
      var_1 = level.advanceduavrig;
      break;
    case "_encstr_8B1608EC43B8D647A113":
      break;
  }

  return var_1;
}

perkengineer_manageminimap() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_81A01443291B468D7232BDCDBD909E531D12C3980C95");

  switch (self.uavtype) {
    case "_encstr_851904B59B34":
      var_0 = "_encstr_B65C114BC6B737AFADD29B2D5B580EFAEA85CE";
      break;
    case "_encstr_8C9D0C506F0B96A8F78B297BF313":
      var_0 = "_encstr_96B21F614EA2C06FB54825290FE06291A7879B260CC2EA9043B7E357B8C0D2D5FB";
      break;
    case "_encstr_81CC0586854EC1":
    case "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950":
      var_0 = "_encstr_A24612B48DBD73AFD6D2CDB4B658E0BE58EAB0B3";
      break;
    default:
      var_0 = "_encstr_B65C114BC6B737AFADD29B2D5B580EFAEA85CE";
  }

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841"))
    var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8171181E82557B0575B7C210B55711AA646DBD6DA409557F7DF3");

  if(isDefined(var_1))
    self.enemyobjid = self[[var_1]](var_0, 1, 1);

  var_2 = 0;

  for(;;) {
    var_3 = level.players.size;

    for(var_4 = 0; var_4 < 10; var_4++) {
      if(var_2 >= level.players.size)
        var_2 = 0;

      var_5 = level.players[var_2];
      var_2++;

      if(!isDefined(var_5)) {
        continue;
      }
      if(self.enemyobjid != -1) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
          if(var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9B63139B09C036574770439BFEAD93EF088D051565") && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_5, self.owner))) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, var_5);
            continue;
          }

          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.enemyobjid, var_5);
        }
      }
    }

    waitframe();
  }
}

startsystemshutdown() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(level.teambased && var_1.team == self.owner.team) {
      continue;
    }
    if(!level.teambased && var_1 == self.owner) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_B66B146E0E95B12D16C6A3977DCA6B83965BDA57E6CA"))
        var_1 thread shutdownenemysystem(self);
    }
  }

  thread applyshutdownonspawn();
}

givefriendlyperks(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5")]]("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5")]]("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");

  var_0 waittill("_encstr_AD75063D571AE108");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD")]]("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD")]]("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
}

shutdownenemysystem(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setuavjammed(1);
  var_0 waittill("_encstr_AD75063D571AE108");
  self setuavjammed(0);
}

applyshutdownonspawn() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.owner;
  var_1 = var_0.team;

  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_2);

    if(var_2 == var_0) {
      continue;
    }
    if(level.teambased) {
      if(istrue(level._id_13EDD)) {
        if(var_2.team == var_1 && var_2.squadindex == var_0.squadindex)
          continue;
      } else if(var_2.team == var_1)
        continue;
    }

    var_2 thread shutdownenemysystem(self);
  }
}

startemppulse() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 2;
  self playSound("_encstr_A58114ECC7A3AAE5CB710353D860DD3117EBB662BCEB");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_A58114ECC7A3AAE5CB710353D860DD3117EBB662BCEB"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 1.5;
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_A58114ECC7A3AAE5CB710353D860DD3117EBB662BCEB"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_84EC17B239A1AF47B097544A9F380F1FD6707AAAC004577BD0"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playSound("_encstr_84EC17B239A1AF47B097544A9F380F1FD6707AAAC004577BD0");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_1 thread applyuavshellshock();
  }

  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC"))
    var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B4050ECEB23AA8CD95B55EA8ACC2B5DC")]](self.team);

  foreach(var_5 in var_3)
  destroyactiveobjects(var_5, self.owner);
}

applyuavshellshock() {
  self playLoopSound("_encstr_9ADE0CBBD9D117889A2569A9E160");
  thread applyuavshellshockvisionset();
  wait 0.5;
  self playSound("_encstr_86C110ADDDF829373F5A4BBEC117EFCDF810");
  self stoploopsound("_encstr_9ADE0CBBD9D117889A2569A9E160");
}

applyuavshellshockvisionset() {
  visionsetnaked("_encstr_B26E0E5E6828F089CE9BD3EB81FBA25C", 0.05);
  waitframe();
  visionsetnaked("_encstr_B26E0E5E6828F089CE9BD3EB81FBA25C", 0);
  visionsetnaked("_encstr_B40101", 0.5);
}

destroyactiveobjects(var_0, var_1) {
  var_2 = "_encstr_A29408E6D5D6CAAF5B1C";
  var_3 = level.activekillstreaks;
  var_4 = [[level.getactiveequipmentarray]]();
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(var_4))
    var_5 = scripts\engine\utility::array_combine_unique(var_3, var_4);
  else if(isDefined(var_3))
    var_5 = var_3;
  else if(isDefined(var_4))
    var_5 = var_4;

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9F8150DE578FB9851B708B9AF43D029220AFD8EFF8257"))
          var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A9F8150DE578FB9851B708B9AF43D029220AFD8EFF8257")]](10000, var_1, var_1, var_0, var_7.origin, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_2);
      }
    }
  }
}

revealminimapforteam(var_0) {
  foreach(var_2 in level.players) {
    if(isai(var_2)) {
      continue;
    }
    if(level.teambased) {
      if(istrue(level._id_13EDD)) {
        if(self.squadindex != var_2.squadindex || self.team != var_2.team)
          continue;
      } else if(self.team != var_2.team)
        continue;
    }

    if(!level.teambased && self.owner != var_2) {
      continue;
    }
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(istrue(var_0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43")]]();

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60"))
      var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60")]]();
  }
}

applymapenableonspawn() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.owner.guid;

  if(level.teambased) {
    if(istrue(level._id_13EDD))
      var_0 = self.team + self.owner.squadindex;
    else
      var_0 = self.team;
  }

  level notify("_encstr_8FF712AF70B3DFB359384B4911635AA178E8337F" + var_0);
  level endon("_encstr_8FF712AF70B3DFB359384B4911635AA178E8337F" + var_0);

  if(istrue(level.istacops)) {
    return;
  }
  for(;;) {
    level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23", var_1);

    if(isai(var_1)) {
      continue;
    }
    if(level.teambased) {
      if(istrue(level._id_13EDD)) {
        if(self.team != var_1.team || self.squadindex != var_1.squadindex)
          continue;
      } else if(self.team != var_1.team)
        continue;
    }

    if(!level.teambased && self.owner != var_1) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43"))
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43")]]();

    var_1.showuavminimaponspawn = 1;
  }
}

setforceradars(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  var_2 = getdvarint("_encstr_9A2112B98D39F53B2CB695EB667B938DCABA859D");
  var_3 = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
  var_4 = 1;
  var_5 = 0;

  switch (var_2) {
    case 3:
      var_3 = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
      break;
    case 5:
      var_3 = "_encstr_A7490B76D3880B6726096A2273";
      var_4 = 2;
      break;
    case 6:
      var_3 = "_encstr_A93F0F1B7B739BE8859BD1D727B0465839";
      var_5 = 1;
      break;
    default:
      break;
  }

  if(level.teambased) {
    if(istrue(level._id_13EDD)) {
      var_6 = 0;

      foreach(var_8 in level.teamnamelist) {
        foreach(var_12, var_10 in level.squaddata[var_8]) {
          var_11 = var_8 + var_12;
          level.radarmode[var_11] = var_3;
          level.activeuavs[var_11] = var_4;
          level.activeadvanceduavs[var_11] = var_5;
          var_6++;
          ammobox_showattachmentflyout(var_8, var_12, var_2);
        }
      }

      level.audio_heli_end_fade_out = var_6;
    } else {
      foreach(var_15 in level.teamnamelist) {
        level.radarmode[var_15] = var_3;
        level.activeuavs[var_15] = var_4;
        level.activeadvanceduavs[var_15] = var_5;
        level.audio_heli_end_fade_out = level.teamnamelist.size;
        _setteamradarstrength(var_15, var_2);
      }
    }
  } else {
    var_4 = scripts\engine\utility::ter_op(var_5 > 0, level._id_13ED9, level._id_13EDC + var_4);
    level.radarmode[var_0.guid] = var_3;
    var_0.radarstrength = var_4;
    level.activeuavs[var_0.guid + "_encstr_97380FEB9C0B8CC227351D93B2CDB38ED0"] = var_4;
    level.activeadvanceduavs[var_0.guid] = var_5;
    level.audio_heli_end_fade_out = level.teamnamelist.size;
    updateplayersuavstatus();
  }
}

_id_13ED5(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return;
  }
  var_3 = _id_13ED6(var_0, var_1);

  foreach(var_5 in var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8E65136B88A3B4EDC330C74B3236E3C191E981E522"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8E65136B88A3B4EDC330C74B3236E3C191E981E522")]](var_5, var_2, 1);
  }
}

_id_13ED6(var_0, var_1) {
  var_2 = [];
  var_3 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];

  foreach(var_5 in var_3) {
    if(!isDefined(var_5) || !var_5 scripts\cp_mp\utility\player_utility::_isalive() || var_5 scripts\cp_mp\utility\player_utility::_isalive() && istrue(var_5.gulag)) {
      continue;
    }
    var_6 = scripts\common\utility::playersincylinder(var_5.origin, var_1, var_3);

    foreach(var_8 in var_6) {
      if(var_2.size > 0) {
        var_9 = _id_13ED7(var_8, var_2);

        if(istrue(var_9))
          continue;
      }

      var_2[var_2.size] = var_8;
    }
  }

  return var_2;
}

_id_13ED7(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && var_0 == var_4) {
      var_2 = 1;
      break;
    }
  }

  return var_2;
}