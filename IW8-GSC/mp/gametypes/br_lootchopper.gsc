/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_lootchopper.gsc
***********************************************/

init() {
  level.averagealliesz = 0;
  level._id_119E7 = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D480F89C9D7C6F6F6A3B1D0DB1C38AC39", "_encstr_AFFD17A58F20BBBFF4905B4247A041307248BB123C3DD38208", ::_id_11A11);
  level thread _id_12B27();
}

_id_12B27() {
  while(!isDefined(level.vehicle))
    waitframe();

  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_A7B30DE187CA05B92B54B8537A15E8", 1);
  var_0.canfly = 1;
}

_id_11A0D(var_0) {
  var_1 = _id_11A09(var_0);
  level._id_119E6 = [];
  level._id_119E6["_encstr_A19507C90D992379CB"] = [];
  level._id_119E6["_encstr_9395079F785FE3A922"] = [];
  level._id_119E6["_encstr_A39507FFC7615A0F7F"] = [];
  level._id_119E6["_encstr_83950769F310075F3D"] = [];

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1) {
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    if(var_0.isvalid) {
      foreach(var_10, var_8 in var_0._id_12952) {
        var_9 = distance2dsquared(var_3.origin, var_8);

        if(!isDefined(var_4) || var_9 < var_4) {
          var_4 = var_9;
          var_5 = var_8;
          var_6 = "_encstr_B4140618C3CE5176" + (var_10 + 1);
        }
      }
    } else {
      foreach(var_10, var_8 in level._id_12950) {
        var_9 = distance2dsquared(var_3.origin, var_8);

        if(!isDefined(var_4) || var_9 < var_4) {
          var_4 = var_9;
          var_5 = var_8;
          var_6 = "_encstr_B4140618C3CE5176" + (var_10 + 1);
        }
      }
    }

    var_3.origin = var_3.origin * (1, 1, 0);
    var_3.origin = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::resetcircuitbreakers(var_3.origin, (0, 0, 10000));
    level._id_119E6[var_6][level._id_119E6[var_6].size] = var_3;
  }
}

_id_11A09(var_0) {
  var_1 = [];

  foreach(var_3 in level.delete_script_object) {
    if(var_0.isvalid) {
      if(distance2dsquared(var_3.origin, var_0.center) > var_0.radius * var_0.radius)
        continue;
    }

    var_4 = spawnStruct();
    var_4.origin = var_3.origin;
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_11A0C(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.isvalid = isDefined(var_0) && isDefined(var_1);

  if(var_2.isvalid) {
    var_2.center = var_0;
    var_2.radius = var_1;
    var_3 = 45.0;
    var_4 = cos(var_3);
    var_5 = sin(var_3);
    var_2._id_12952[0] = var_0 + (-1.0 * var_4, var_5, 0) * var_1 * 0.5;
    var_2._id_12952[1] = var_0 + (var_4, var_5, 0) * var_1 * 0.5;
    var_2._id_12952[2] = var_0 + (var_4, -1.0 * var_5, 0) * var_1 * 0.5;
    var_2._id_12952[3] = var_0 + (-1.0 * var_4, -1.0 * var_5, 0) * var_1 * 0.5;
  }

  return var_2;
}

_id_11A0F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    return;
  }
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
    var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  }

  var_2 = _id_11A0C(var_0, var_1);
  _id_11A0D(var_2);
  level waittill("_encstr_A64211C4E4D70E4E2BB5B0D1C643549B325623");
  var_3 = getdvarint("_encstr_858116CD1B9CEB46B5E9EB36B17D5B581EAF588D8E96ECCA", 5);
  var_4 = getdvarint("_encstr_AF071A5BEE4AC10D92A3EF81EF99C1C8FE49C3B3969780A85A97AF89", 6000);
  var_5 = getdvarint("_encstr_979C1EE251A8677299DD5FABD7A8CB80E83B5D61C9E8EFAA659FF7AB476952C6", 360);
  var_6 = getdvarint("_encstr_A19C1E523E7561FC3070D703A02EA3DB2B4C9DC196E7BA0CF9F07F03294069A3", 480);

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    var_4 = 1000;

  for(;;) {
    var_7 = getdvarint("_encstr_8BBF129653FBDEF165E3B1306AB1B3115BF19C05", 0);

    if(!var_7) {
      waitframe();
      continue;
    }

    var_8 = randomintrange(var_5, var_6);

    if(istrue(level._id_14086))
      scripts\mp\flags::gameflagwait("_encstr_ACA314B97949B81C7ABB4D7716BB678B8FF1D18228CE");
    else
      wait(var_8);

    if(level._id_119E7.size < var_3) {
      var_9 = var_3 - level._id_119E7.size;

      for(var_10 = 0; var_10 < var_9; var_10++) {
        var_11 = var_10 + 1;

        if(var_11 > 4)
          var_11 = 1;

        var_12 = _id_11A07(level._id_119E6["_encstr_B4140618C3CE5176" + var_11], var_4);

        if(!isDefined(var_12))
          wait 1;

        if(var_10 == 0)
          _encstr_913B2988662341C84372B58BE2A089BB0F17B36823076860A92B6117F1D5CB9117C357A7302B206E4F43AE::_id_13371("_encstr_A2061886CAC7301F1D8BC89812F219A9DB7F9B0833DFD85B05C2");

        _id_11A18(var_12);

        if(istrue(level._id_14086))
          wait(randomintrange(1, 2));
      }

      if(istrue(level._id_14086)) {
        return;
      }
      continue;
    }

    while(level._id_119E7.size >= var_3)
      waitframe();
  }
}

_id_11A07(var_0, var_1) {
  var_2 = undefined;

  if(var_0.size > 0) {
    var_3 = [];

    foreach(var_5 in var_0) {
      if(istrue(var_5.goalstruct)) {
        continue;
      }
      if(_id_11A0E(var_5, var_1)) {
        continue;
      }
      var_5.goalstruct = 1;
      var_3[var_3.size] = var_5;
    }

    if(var_3.size > 0)
      var_2 = var_3[randomint(var_3.size)];
  }

  return var_2;
}

_id_11A0E(var_0, var_1) {
  var_2 = 0;
  var_3 = level._id_119E6;
  var_4 = var_1 * var_1;

  foreach(var_6 in var_3) {
    foreach(var_8 in var_6) {
      if(istrue(var_8.goalstruct)) {
        if(distance2dsquared(var_0.origin, var_8.origin) < var_4) {
          var_2 = 1;
          break;
        }
      }
    }

    if(istrue(var_2)) {
      break;
    }
  }

  return var_2;
}

_id_11A0A(var_0) {
  var_1 = undefined;
  var_2 = 0;

  foreach(var_5, var_4 in level._id_119E6) {
    if(var_2 == var_0) {
      var_1 = var_4;
      break;
    }

    var_2++;
  }

  return var_1;
}

_id_11A18(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = getdvarint("_encstr_8FAF199BC6E4EBC85B9EBED8B1AF38583A27BDD8F5272C234BABB9", 4000);

  if(isDefined(var_0))
    var_5 = var_0.origin;
  else {
    var_7 = [];

    foreach(var_9 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_9))
        var_7[var_7.size] = var_9;
    }

    if(var_7.size > 0) {
      var_11 = randomint(var_7.size);
      var_5 = var_7[var_11].origin;
    }
  }

  if(!isDefined(var_5)) {
    return;
  }
  var_5 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::resetcircuitbreakers(var_5, (0, 0, 10000));
  var_12 = undefined;

  if(isDefined(var_4))
    var_12 = var_4;
  else
    var_12 = scripts\cp_mp\killstreaks\chopper_support::getpathstart(var_5);

  var_13 = vectortoangles(var_5 - var_12);
  var_14 = -1200;

  if(isDefined(level.br_level) && isDefined(level.br_level._id_11A5B))
    var_14 = level.br_level._id_11A5B;

  var_15 = var_14 + 10000;

  if(var_12[2] < var_15)
    var_12 = (var_12[0], var_12[1], var_15);

  var_16 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_AC2F1B3BCAA1AFB1D0F6C138ACC9AFB9EA1C1CED4EA3BE19B6D3BE5BE0");
  var_17 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var_12, var_13, var_16, "_encstr_A3EC184E8538D2F9F368DAE10BD36A97D37FACD62F66EF3EB798");

  if(!isDefined(var_17)) {
    return;
  }
  if(isDefined(var_2) && isDefined(var_3)) {
    var_17.chopper_boss_explosion = var_2;
    var_17._id_1220E = var_3;
  } else
    var_17.chopper_boss_explosion = 0;

  var_17.speed = 100;
  var_17.accel = 50;
  var_17.lifetime = getdvarint("_encstr_A5B914FBDEDD08C9C262691936C70840DA626423B71F", 9999);
  var_17.team = "_encstr_A7A408B9CA5D1D4E2C63";
  var_17.angles = var_13;
  var_17.flaresreservecount = getdvarint("_encstr_AB1B129B2F78396341B2F1CA79B0B32D48B50503", 0);
  var_17.currentdamagestate = 0;
  var_17.pathstart = var_12;
  var_17.pathgoal = var_5;
  var_17.currentaction = "_encstr_96080730D8534E0A28";
  var_17.currenttarget = undefined;
  var_17.heightoffset = (0, 0, getdvarint("_encstr_A56512E68D93D7C8D6A7F5C68DBE43ACA5EC43A3", 1500));
  var_17._id_12210 = var_0;
  var_17._id_1220D = var_5;
  var_17._id_1220F = var_6;
  var_17._id_13768 = 35;
  var_17.infil_complete = var_17.heightoffset[2] - 250;

  if(var_17.chopper_boss_explosion) {
    var_17._id_12200 = 0;
    var_17.updateteamscoreplacements = 1;
  }

  var_17 setmaxpitchroll(15, 15);
  var_17 vehicle_setspeed(var_17.speed, var_17.accel);
  var_17 sethoverparams(50, 5, 2.5);
  var_17 setturningability(0.5);
  var_17 setyawspeed(100, 25, 25, 0.1);
  var_17 setCanDamage(1);
  var_17 setneargoalnotifydist(768);
  var_17 setvehicleteam(var_17.team);
  var_17.health = getdvarint("_encstr_97A71237B127FA23B5A7EB36B17D43CAB0C6D11A", 5000);
  var_17.maxhealth = getdvarint("_encstr_97A71237B127FA23B5A7EB36B17D43CAB0C6D11A", 5000);
  var_17 scripts\mp\sentientpoolmanager::registersentient("_encstr_BE230E64859CE87B09557DB81153BB97", var_17.team);
  var_17 _id_11A15();
  var_17 setscriptablepartstate("_encstr_8D98102E456FC82FB9BD7107F969183AB9FB", "_encstr_AB0703DBB9", 0);
  var_17 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_17.frontturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_17 gettagorigin("_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_17.frontturret setModel("_encstr_83D225ECBD7BDA5FBD7A90011254FDCEB728F865153353C1699340903B6FB98657C5685569E7C3");
  var_17.frontturret.team = var_17.team;
  var_17.frontturret.angles = var_17.angles;
  var_17.frontturret.turreton = 1;
  var_17.frontturret.name = "_encstr_9BAF0D33C9DEE68EAF47BAC9C956A3";
  var_17.frontturret.attackingtarget = undefined;
  var_17.frontturret._id_14258 = "_encstr_A7B30DE187CA05B92B54B8537A15E8";
  var_17.frontturret linkTo(var_17);
  var_17.frontturret setturretteam(var_17.team);
  var_17.frontturret setturretmodechangewait(0);
  var_17.frontturret setmode("_encstr_849007B268BD03DFD8");
  var_17.frontturret setdefaultdroppitch(45);
  var_17.frontturret.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_17.origin);
  var_17.frontturret.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_17.frontturret.groundtargetent dontinterpolate();
  var_17.rearturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_17 gettagorigin("_encstr_8AA1104B5B2461E420CBE22FE3992A1A8FD5"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_17.rearturret setModel("_encstr_83D225ECBD7BDA5FBD7A90011254FDCEB728F865153353C1699340903B6FB98657C5685569E7C3");
  var_17.rearturret.team = var_17.team;
  var_17.rearturret.angles = var_17.angles;
  var_17.rearturret.turreton = 1;
  var_17.rearturret.name = "_encstr_B4F50CE49516C9BE47D593392BE8";
  var_17.rearturret.attackingtarget = undefined;
  var_17.rearturret._id_14258 = "_encstr_A7B30DE187CA05B92B54B8537A15E8";
  var_17.rearturret linkTo(var_17);
  var_17.rearturret setturretteam(var_17.team);
  var_17.rearturret setturretmodechangewait(0);
  var_17.rearturret setmode("_encstr_849007B268BD03DFD8");
  var_17.rearturret setdefaultdroppitch(45);
  var_17.rearturret.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_17.origin);
  var_17.rearturret.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_17.rearturret.groundtargetent dontinterpolate();
  level._id_119E7[level._id_119E7.size] = var_17;

  if(var_17.chopper_boss_explosion && isDefined(var_17.intro_enemy_respawner))
    var_17._id_1220C = var_17.intro_enemy_respawner;
  else
    var_17._id_1220C = ::_id_11A12;

  var_17.lootfunc = ::_id_11A05;
  var_17.has_ammo_drain_passive = ::_id_11A03;
  var_17 _id_11A04();
  var_17 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4"))
    var_17 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4")]](scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);

  if(!istrue(var_17.chopper_boss_explosion))
    var_17 thread scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var_17.pathgoal, 1);

  return var_17;
}

_id_11A15() {
  self.vehiclename = "_encstr_A7B30DE187CA05B92B54B8537A15E8";
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(self.vehiclename, 20);
  _id_11A10("_encstr_9B69114A571F8EBD17484FBA87220987C71A97", 4.0, 20);
  _id_11A10("_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA", 4.0, 20);
  _id_11A10("_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59", 4.0, 20);
  _id_11A10("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", 4.0, 20);
  _id_11A10("_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0", 4.0, 20);
  _id_11A10("_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920", 5.0, 20);
  _id_11A10("_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B", 4.0, 20);
  _id_11A10("_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0", 2.85714, 20);
  _id_11A10("_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB", 2.85714, 20);
  _id_11A10("_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1", 2.85714, 20);
  _id_11A10("_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588", 2.85714, 20);
  _id_11A10("_encstr_9AAE0876FCB7603101DB", 4.0, 20);
  _id_11A10("_encstr_92A70ABB8267F5E0D89F6351", 2.85714, 20);
  _id_11A10("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", 2.85714, 20);
  _id_11A10("_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0", 2.85714, 20);
  _id_11A10("_encstr_BA730BF8AFF178988293F158B9", 1.81818, 20);
  _id_11A10("_encstr_91730EE7A8D8C8B0A5FD1FF790E72860", 1.81818, 20);
  _id_11A10("_encstr_81430B218B3F7018458997D78A", 2.85714, 20);
  _id_11A10("_encstr_99410C4B48C39AB7D0CD95B769DB", 1, 36);
  _id_11A10("_encstr_B29B0FE0E32573E3A23395B04E6BBF5898", 1, 36);
  _id_11A10("_encstr_8E3B11F9785798B1A7BB5906C267F96061C579", 1, 30);
  _id_11A10("_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002", 1, 52);
  _id_11A10("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E", 2.85714, 20);
  _id_11A10("_encstr_ACC40CC1F8A321601715CFBFE0EA", 2.85714, 20);
  _id_11A10("_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1", 2.0, 20);
  _id_11A10("_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0", 1.42857, 20);
  _id_11A10("_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B", 1.0, 20);
  _id_11A10("_encstr_AC740FAA3BF169D025C6A373200C27E06B", 5.0, 20);
  _id_11A10("_encstr_95E70D8EDBDA85F5839CED35F5B683", 2.85714, 20);
  _id_11A10("_encstr_8DCB0F47F22330CEE7996B13A2E390583A", 6.66667, 20);
  _id_11A10("_encstr_A2950D16C9E8D2361B59932FF55BC1", 6.66667, 20);
  _id_11A10("_encstr_A29408E6D5D6CAAF5B1C", 10.0, 20);
  _id_11A10("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9", 10.0, 20);
  _id_11A10("_encstr_88710EC26CC49918FA1A815BB5AFADC1", 5.0, 20);
  _id_11A10("_encstr_88F90EF65F8E7A1AEED5251AE97F9788", 2.85714, 20);
  _id_11A10("_encstr_87DF1286F6D9959CBE9AAC1DBEC1E47B35F56B07", 5.0, 20);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage(self);
  scripts\mp\vehicles\damage::get_vehicle_mod_damage_data(self.vehiclename, 1);
  scripts\mp\vehicles\damage::set_pre_mod_damage_callback(self.vehiclename, ::_id_11A14);
  scripts\mp\vehicles\damage::set_post_mod_damage_callback(self.vehiclename, ::_id_11A13);
  scripts\mp\vehicles\damage::set_death_callback(self.vehiclename, ::_id_11A0B);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self);
}

_id_11A10(var_0, var_1, var_2) {
  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle(var_0, var_1, self.vehiclename);
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data_for_weapon(self.vehiclename, var_2, var_0);
}

_id_11A14(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.attacker;
  return 1;
}

_id_11A13(var_0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage(var_0);

  if(!isDefined(self.attackers))
    self.attackers = [];

  var_1 = _id_11A08(var_0.attacker);

  if(!isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.player = var_0.attacker;
    var_2.objweapon = var_0.objweapon;
    var_2._id_13BEE = var_0.damage;
    self.attackers[self.attackers.size] = var_2;
  } else {
    var_1._id_13BEE = var_1._id_13BEE + var_0.damage;
    var_1.objweapon = var_0.objweapon;
  }

  return 1;
}

_id_11A0B(var_0) {
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage(var_0);

  if(istrue(level.tryupdategenericprogress)) {
    self notify("_encstr_AD75063D571AE108");
    return 1;
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = var_0.attacker;
  self.viphud_hidefromplayer = var_3;

  if(isDefined(self.attackers)) {
    foreach(var_5 in self.attackers) {
      if(isDefined(var_5.player)) {
        if(isDefined(var_3) && var_3 == var_5.player)
          var_1 = "_encstr_AC4A1A130876CC5277956166F30FDB9859906FB3182B2C4B5F2BF7DF";
        else
          var_1 = "_encstr_AB8B21620BE8FB9528B13F0BA17B9A532DE3498A7156D38A50B33D1437A86217437B73";

        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);
        var_5.player thread scripts\mp\rank::giverankxp(var_1, var_2, var_5.objweapon);
        var_5.player thread scripts\mp\events::killeventtextpopup(var_1, 0);
        thread scripts\cp\vehicles\vehicle_compass_cp::vehiclekilled(self, var_0.inflictor, var_5.player, 0, var_5.objweapon);
      }
    }
  }

  self notify("_encstr_AD75063D571AE108");
  return 1;
}

_id_11A12(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_B6911073D66FB81C0F42717ECB074E500724");

  if(self.currentaction != "_encstr_96080730D8534E0A28")
    self.currentaction = "_encstr_96080730D8534E0A28";
  else if(self.currentaction == "_encstr_96080730D8534E0A28" && !istrue(var_0)) {
    return;
  }
  self clearlookatent();
  self setneargoalnotifydist(300);
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    if(self.currentaction == "_encstr_AD1C0A291B7C0BBEA2BFFDE7") {
      if(!istrue(var_1))
        var_1 = 1;

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_1))
      var_1 = 0;

    var_3 = self._id_1220D + anglesToForward((0, var_2, 0)) * int(self._id_1220F / 1.2);
    var_2 = var_2 + 90;
    scripts\cp_mp\killstreaks\chopper_support::debugtimedelta(var_3, 1);

    if(var_2 >= 360)
      var_2 = 0;

    wait 0.5;
  }
}

_id_11A05() {
  var_0 = _id_11A06(self.origin + (0, 0, 500));

  if(isDefined(var_0) && istrue(level._id_14088) && isscriptabledefined())
    var_0 = getclosestpointonnavmesh(var_0);

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::missionbonustimer(self.origin, var_0);
    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2._id_140A0 = 10;
  }
}

_id_11A06(var_0) {
  var_1 = undefined;
  var_2 = var_0 - (0, 0, 20000);
  var_3 = [self, self.frontturret, self.rearturret];
  var_4 = scripts\engine\trace::ray_trace(var_0, var_2, var_3);

  if(isDefined(var_4) && var_4["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
    var_1 = var_4["_encstr_BD260953AA97E3F014279D"];

  return var_1;
}

_id_11A11(var_0) {
  var_1 = getdvarint("_encstr_87FE1A38923A172107C210F1B3A7EB29A3EA382B1B9985D957C18EFD", 100000);

  if(istrue(level.convoy_handle_stuck_compromise)) {
    var_2 = getdvarint("_encstr_8B3F205FEF4E8FC972EA17CB92792892C518AC62FA11EDC21B75303953C5EBF14BEA", 50000);
    var_1 = var_1 + var_2;
  }

  if(isDefined(level.delayed_explosion_things))
    var_1 = level.delayed_explosion_things;

  var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
  self.itemsdropped = 0;
  var_4 = _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::dropplunderbyrarity(var_1 / 100, var_3);

  foreach(var_6 in var_4)
  var_6._id_11A40 = "_encstr_A7B30DE187CA05B92B54B8537A15E8";

  if(!isDefined(var_0._id_11A01))
    var_0._id_11A01 = 1;
  else
    var_0._id_11A01++;

  var_0 scripts\mp\utility\stats::setextrascore1(var_0._id_11A01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_92611950639191A0EF2CF0D618C78B71C78B41D82AF0BFF8EB2560");
}

_id_11A03() {
  if(isDefined(self.modifyvehicledamage))
    self.modifyvehicledamage delete();

  if(isDefined(self._id_12210))
    self._id_12210.goalstruct = undefined;

  if(isDefined(self.objectiveiconid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  level._id_119E7 = scripts\engine\utility::array_remove(level._id_119E7, self);
}

_id_11A04() {
  var_0 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_0 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_0, "_encstr_930B07BB1B6B3854FF", self.origin, "_encstr_858B23CF5C37ABE3E9E8334F858A5B8253F823FE2C2320FBA9A6407A4601E748B50398699B", "_encstr_ABD30C68F6C82ECFC80B037C8347");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_0, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_0);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_0, self);
    playencryptedcinematicforall(var_0, 1);
  }

  self.objectiveiconid = var_0;
}

_id_11A08(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0))
    return var_1;

  foreach(var_3 in self.attackers) {
    if(isDefined(var_3.player) && var_0 == var_3.player) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}