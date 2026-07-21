/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_c130airdrop.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A7AA0FC427BED813CC06A0A54E329CDE07", "_encstr_BA2017FE03BA1008A3F59BCB27D711B7B8D532C603503D638D", ::fntrapactivation);
  level.fob_bombs = [];
  level.focus_fire_attacker_timeout = [];
  level.fnhidefoundintel = getdvarint("_encstr_81BA23DE0BA386B52D8A7980020261FB7FA07ED661C389A917F240D0EB150D51D34AE345FD", 12000);
}

fnoffhandfire() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 1;
  level waittill("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");

  for(;;) {
    var_1 = getdvarint("_encstr_964E17B96C93AF32D6D3BE58A59C4693DE1CD71636A35A9DAC", 1);

    if(!var_1) {
      waitframe();
      continue;
    }

    var_2 = getdvarint("_encstr_A38420932672F935DAFBA7E38F130DD8377A9E28CED0417EF73671978F5BC728DE12", 3);
    var_3 = getdvarint("_encstr_8D031BDCD8C9FA915B3D7D58D22723E4DB077DD60BF0FAD89358E8ACB9", 12);
    var_4 = getdvarint("_encstr_962C239B364EBE46DAF4D7162D9C239CB7C17D37E085EEB9FA36B7BD36C8BDBBE6AFB6A5B9", 240);
    var_5 = getdvarint("_encstr_8C2C233718EEF8F468CA393BFB1B213BEFB18EA0D32913B0D880B8C0C83F97F3B3AF7AC3F0", 360);
    var_6 = randomintrange(var_4, var_5);

    if(istrue(level._id_14086) && istrue(var_0))
      scripts\mp\flags::gameflagwait("_encstr_B6CB14C26CE8B4D9C2472BF5C62CCDA1D72339DE1C37");
    else
      wait(var_6);

    if(isDefined(level.br_level))
      level.br_level.c130_speedoverride = 3044;

    var_7 = level.focus_fire_attacker_timeout.size;

    if(var_7 < var_3) {
      var_8 = getdvarint("_encstr_A13D1F9BC6E4AF91D6D3AF85A5C91927F683FAE6ABADBEB193588E56E6BEE0B2C9", 3);
      var_9 = var_3 - var_7;

      if(!istrue(var_0))
        var_2 = 1;

      var_10 = min(var_2, ceil(var_9 / var_8));
      var_11 = var_9;

      for(var_12 = 0; var_12 < var_10; var_12++) {
        var_13 = min(var_8, var_11);
        var_11 = var_11 - var_13;
        var_14 = fn_spec_op_post_customization(var_12);
        var_15 = distance(var_14.startpt, var_14.endpt);
        var_16 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
        var_17 = var_15 / var_16;
        var_18 = fntrapdeactivation(var_14, var_15, var_16, var_17);

        if(var_12 == 0)
          _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_13371("_encstr_9562189839EB6CC43306164B3932E4F6E0AFD2E6D8DBB55A3776");

        var_18 fob(var_13);

        if(istrue(level._id_14086))
          wait(randomintrange(4, 8));
      }

      if(istrue(var_0))
        var_0 = 0;
    }
  }
}

fn_spec_op_post_customization(var_0, var_1, var_2) {
  if(isDefined(level.br_level.br_mapcenter) && isDefined(level.br_level.br_mapsize))
    var_3 = fnanimatedprop_setanim(var_0, var_1, var_2);
  else
    var_3 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::spawnc130pathstruct(var_1);

  return var_3;
}

fnanimatedprop_setanim(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = level.br_level.br_mapcenter;

  if(isDefined(var_1))
    var_4 = var_1;

  var_5 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::respawns_on_failed_unload();
  var_6 = (0, randomfloat(360), 0);

  if(!isDefined(var_0) || var_0 == 0) {
    if(!istrue(var_2)) {
      var_7 = fngetplayerdrone();
      var_8 = fndropweapon(var_7);
      var_6 = vectortoangles(var_4 - var_8 * (1, 1, 0));
      level.fob_think = var_6;
    }

    var_4 = var_4 + (0, 0, scripts\cp_mp\parachute::release_player_on_damage());
  } else {
    if(isDefined(level.fob_think)) {
      var_6 = level.fob_think;
      var_9 = 1;

      if(var_0 == 2)
        var_9 = -1;

      var_10 = anglestoright(var_6) * (var_5 * var_9);
      var_11 = randomint(2);
      var_12 = randomfloat(360);
      var_6 = (0, var_12, 0);
      var_6 = scripts\engine\utility::ter_op(var_11, var_6, var_6 + (0, 180, 0));
    } else {
      var_12 = randomfloat(360);
      var_10 = anglesToForward((0, var_12, 0));
      var_10 = var_10 * (var_5 * randomfloatrange(-1, 1));
    }

    var_10 = var_10 + (0, 0, scripts\cp_mp\parachute::release_player_on_damage());
    var_4 = var_4 + var_10;
  }

  var_3 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::_id_1361A(var_4, var_6);
  return var_3;
}

fngetplayerdrone() {
  var_0 = undefined;
  var_1 = scripts\mp\gamescore::run_common_functions_stealth();
  var_2 = [];

  foreach(var_4 in level.teamnamelist) {
    var_5 = scripts\mp\utility\teams::getteamdata(var_4, "_encstr_9775086022BE1B413B8B");

    if(var_5.size > 0) {
      var_6 = 0;

      foreach(var_8 in var_5) {
        if(!isDefined(var_8)) {
          continue;
        }
        if(scripts\mp\utility\player::isreallyalive(var_8)) {
          var_6 = 1;
          break;
        }
      }

      if(!istrue(var_6)) {
        continue;
      }
      var_10 = var_1[var_4];

      if(!isDefined(var_0) || var_10 >= var_0) {
        var_0 = var_10;
        var_11 = var_2.size;
        var_2[var_11] = spawnStruct();
        var_2[var_11].team = var_4;
        var_2[var_11].players = var_5;
      }
    }
  }

  if(var_2.size > 0) {
    var_11 = 0;

    if(var_2.size > 1)
      var_11 = randomint(var_2.size);

    return var_2[var_11];
  }

  return;
}

fndropweapon(var_0) {
  if(!isDefined(var_0.players))
    return (randomfloatrange(-1000, 1000), 0, 0);

  var_1 = (0, 0, 0);
  var_2 = 3000;
  var_3 = 1;

  foreach(var_5 in var_0.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_5)) {
      continue;
    }
    var_1 = var_5.origin;

    foreach(var_7 in var_0.players) {
      if(var_7 == var_5) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_7)) {
        continue;
      }
      if(distance2dsquared(var_5.origin, var_7.origin) <= var_2 * var_2) {
        var_3++;
        var_1 = var_1 + var_7.origin;
        break;
      }
    }

    if(var_3 >= 2) {
      break;
    }
  }

  var_10 = var_1 / var_3;
  return var_10;
}

fntrapdeactivation(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.startpt);
  var_4 setModel("_encstr_8ADB28B3953407BEB6961BEBB02DC9BE0B360DB0E4364B95C4CC60BEB5C29DDA0BFA0BDCB4AD2C475923");
  var_4 setCanDamage(0);
  var_4.maxhealth = 100000;
  var_4.health = var_4.maxhealth;
  var_4.startpt = var_0.startpt;
  var_4.endpt = var_0.endpt;
  var_4.centerpt = var_0.centerpt;
  var_4.dir = vectorNormalize(var_4.endpt - var_4.startpt);
  var_4.angles = vectortoangles(var_4.dir);
  var_4._id_121FE = var_1;
  var_4.speed = var_2;
  var_4.lifetime = var_3;
  var_4.getcircleclosetime = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4.startpt);
  var_4.getcircleclosetime setModel("_encstr_A3D525B3CA431CD7ADA51BAF85A593AF2C1B342C9CD84B2B4C99187DB558B3D6B0F5E4D23B4B46");
  var_4.getcircleclosetime linkTo(var_4, "_encstr_B40101", (0, 0, 0), (0, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")) {
    var_5 = var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A5B0108E1B78310BF5DFB39BE3AE53614841")]]("_encstr_A26F161C306860B15F6053C34D33BBA17A2DBA6048E1B3B7", undefined, undefined, 1, 1);
    var_4.minimapid = var_5;
  }

  level.fob_bombs[level.fob_bombs.size] = var_4;
  return var_4;
}

fob(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("_encstr_8AD10DE70B1283A017F3B8C9BB4D5A", "_encstr_AB0703DBB9", 0);
  self moveTo(self.endpt, self.lifetime);
  thread fnanimatedprop_setup();
  thread fnanimatedprop_startanim(var_0, var_1, var_2, var_3);
}

fnanimatedprop_setup() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(max(self.lifetime - 1, 1));
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 setModel("_encstr_BD392AF81A5421BEEF0951C01927C327FE8280D8C3EDDBB1F67B47D8FD2F293BA6E9A0405BC4216B8F5261CD");
  var_0 setscriptablepartstate("_encstr_B6490F72500C4B52A70B43F33D677F9783", "_encstr_AB0703DBB9", 0);
  var_0 thread scripts\mp\utility\script::delayentdelete(10);
  wait 1;
  level.fob_bombs = scripts\engine\utility::array_remove(level.fob_bombs, self);
  self setscriptablepartstate("_encstr_8AD10DE70B1283A017F3B8C9BB4D5A", "_encstr_BA19049F4B2D", 0);

  if(isDefined(self.minimapid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);

  if(isDefined(self.getcircleclosetime))
    self.getcircleclosetime delete();

  if(isDefined(self))
    self delete();
}

fnanimatedprop_startanim(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.mode_can_play_ending))
    self[[self.mode_can_play_ending]](var_0, var_1, var_2, var_3);
  else {
    var_4 = self.lifetime;
    var_5 = var_4 * 0.4;
    var_6 = var_4 - var_5;
    var_7 = var_5 / 2;
    var_8 = var_6 / max(1, var_0 - 1);
    var_9 = 1;
    var_10 = 0;
    var_11 = var_7;
    var_12 = 0;

    while(var_12 < var_0) {
      if(!istrue(var_9))
        var_11 = var_8;

      if(istrue(var_10)) {
        var_11 = var_8 / 3;
        var_10 = 0;
      }

      wait(var_11);

      if(istrue(var_9))
        var_9 = 0;

      var_13 = fnchildscorefunc(self.origin + anglesToForward(self.angles) * 500);

      if(!isDefined(var_13)) {
        var_10 = 1;
        continue;
      }

      var_14 = scripts\cp_mp\killstreaks\airdrop::minshotstostage3acc(var_13 + (0, 0, level.fnhidefoundintel - 100), var_13, self.angles, var_1, var_2);

      if(!isDefined(var_14)) {
        var_10 = 1;
        continue;
      }

      var_12++;
      var_15 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_14);
      var_15._id_140A0 = 5;
      level.focus_fire_attacker_timeout[level.focus_fire_attacker_timeout.size] = var_14;
    }
  }
}

fnchildscorefunc(var_0, var_1) {
  var_2 = undefined;
  var_3 = var_0 - (0, 0, 20000);
  var_4 = [self, self.getcircleclosetime];
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1, 1, 1);
  var_6 = scripts\engine\trace::ray_trace(var_0, var_3, var_4, var_5);

  if(isDefined(var_6) && var_6["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_2 = var_6["_encstr_BD260953AA97E3F014279D"];

  if(isDefined(var_2) && !istrue(var_1)) {
    if(istrue(level._id_14089) && isscriptabledefined())
      var_2 = getclosestpointonnavmesh(var_2);

    var_7 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_2, 1, 0) && !fnlookforvehicles(var_2);

    if(!istrue(var_7))
      var_2 = undefined;
  }

  return var_2;
}

fnlookforvehicles(var_0) {
  var_1 = 0;
  var_2 = level.focus_fire_attacker_timeout;
  var_3 = getdvarint("_encstr_B8A8194F278BAF90D5202EE18C92C8CEF2D39FEBE7B2C858F97A33", 10000);
  var_4 = var_3 * var_3;

  foreach(var_6 in var_2) {
    if(distance2dsquared(var_0, var_6.origin) < var_4) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

fntrapactivation(var_0) {
  var_1 = "_encstr_ACD825D6C1BC8DF67BA3D7375647F50B969C8C93DB0E7DC6B7CDD195CDD19B7DC86B9E8B6C9BCE";
  self.itemsdropped = 0;
  var_2 = [];

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") != "_encstr_8AE1099A0B999F2D28AF15") {
    var_3 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 1, "_encstr_85CE0B9770B02C73A1760F06D2", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_3 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(4, 1, "_encstr_AC20072B9FA9487832", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_3 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 2, "_encstr_91B50734CA58631D1A", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  var_3 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 2, "_encstr_B483058670B0B7", var_1);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && getdvarint("_encstr_91561C6EC693BE236B3DFA16A593C839B783FA23397B38AFA3B09836B23A", 0) == 1) {
    var_3 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 1, "_encstr_86DB073A2CC4C62B47", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_4 = randomint(3);

  if(var_4 == 2) {
    var_3 = _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::chooseandspawnitems(0, 1, "_encstr_9695073995D94BD959", var_1);
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);
  }

  var_5 = 750;

  if(isDefined(level.br_checkforlaststandwipe))
    var_5 = level.br_checkforlaststandwipe;

  if(istrue(level.convoy_handle_stuck_compromise))
    var_5 = int(var_5 * level._id_12192);

  var_6 = undefined;

  if(isDefined(level.br_circle_init_func))
    var_6 = level.br_circle_init_func;

  var_7 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  var_7.ml_p3_to_safehouse_transition = self.itemsdropped;
  var_3 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplunderbyrarity(var_5, var_7, var_6);
  var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  foreach(var_9 in var_2)
  var_9._id_11A40 = "_encstr_8771099F9E6F47990AB57A";

  if(!isDefined(var_0._id_11A01))
    var_0._id_11A01 = 1;
  else
    var_0._id_11A01++;

  var_0 scripts\mp\utility\stats::setextrascore1(var_0._id_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_AFA51129F3EFD14A0A6239BBDDF03738838BBB");
}