/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\chopper_support_cp.gsc
*************************************************/

init_chopper_support() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16", ::chopper_support_set_vehicle_hit_damage_data);
}

chopper_support_set_vehicle_hit_damage_data(var_0, var_1) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var_0, var_1);
}

chopper_support_create_enemy_chopper(var_0) {
  var_1 = spawnStruct();
  var_1.streakname = "_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3";
  var_1.owner = var_0;
  var_2 = var_0 spawnenemychopper(var_0, var_1);

  if(!isDefined(var_2)) {
    iprintln("_encstr_86C05C0F56018911AB1E1DBCB13FDFF81D893DE8575E8B3BD97863994867B9EBAABA2AC2355168A3B9C40262AD3E44EFE93E51B3F2B39AE0291F87B37746BB4FC93D8383711B9A0B1239BD11B7DD3540D3818A3CB83F28356694086A9DBE");
    return 0;
  }

  var_2 thread startenemychopper(var_0, var_1);
}

spawnenemychopper(var_0, var_1) {
  var_2 = (0, 0, 1750);
  var_4 = var_0.origin - anglesToForward(var_0.angles) * 15000 + var_2;
  var_5 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_2;
  var_6 = var_0.angles;
  var_7 = getdvarint("_encstr_82BC1D8B3E9A115E7247E1E9873B88A835525380E2E459815A7B33F98F92ED", 45);
  var_9 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_10 = randomint(level.heli_structs_entrances.size);
    var_11 = level.heli_structs_entrances[var_10];
    var_9 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_11.script_linkto, level.heli_structs_goals);
    var_12 = var_11.origin * (1, 1, 0) + var_2;
    var_13 = var_9.origin * (1, 1, 0) + var_2;
    var_14 = vectorNormalize(var_13 - var_12);
    var_4 = var_13 - var_14 * 15000;
    var_5 = var_13;
    var_6 = vectortoangles(var_14);
  } else
    iprintlnbold("_encstr_B660336BB38B6B8938C7C6EAA9EA2B43704BA2A13440FB98865AB84B2B3FABFE9848F11075A1C68A70CF60339EAB78A1794E3D50CE");

  var_21 = "_encstr_A3EC184E8538D2F9F368DAE10BD36A97D37FACD62F66EF3EB798";
  var_22 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_4, var_6, "_encstr_880B175437EAD70908E7D0C8D74AC6C7431ACF504A830F30F8", var_21);

  if(!isDefined(var_22)) {
    iprintln("_encstr_973F4C28A6EC57ED71F20810799112FB8534DEA0CD945F65930AC058B9099A671F2038AA75DDB33FCF79FEE1B125046B77DF8D50102B5A7A9130732AB98547578AC640879F6BB742C922EE263271");
    return undefined;
  }

  var_22.speed = 100;
  var_22.accel = 50;
  var_22.lifetime = var_7;
  var_22.team = "_encstr_8E8405EA382B2A";
  var_22.owner = var_0;
  var_22.angles = var_6;
  var_22.streakinfo = var_1;
  var_22.streakname = var_1.streakname;
  var_22.flaresreservecount = 1;
  var_22.currentdamagestate = 0;
  var_22.pathstart = var_4;
  var_22.pathgoal = var_5;
  var_22.currentaction = "_encstr_96080730D8534E0A28";
  var_22.currenttarget = undefined;
  var_22.currentpatrolstruct = var_9;
  var_22.heightoffset = var_2;
  var_22.health = 2000;
  var_22.maxhealth = 2000;
  var_22 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]](var_1.streakname, "_encstr_B6221A912898A54D273037B5B1CEA83FC8F24D826FB0B5F0C3D553B4", undefined, "_encstr_A58418E3DA959F3D4823BF2F0B1890B050A64F4B45071B8F3855", "_encstr_824522B6BF39A4808DF3A121853B39226D48E08566BFD860715721FB479BB568F317EAC3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD")]](var_1.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8")]](var_1.streakname, scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF")]](var_1.streakname, scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);

  level.choppersupports[level.choppersupports.size] = var_22;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_1.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_0, 0, 1, 100);

  var_22 setmaxpitchroll(15, 15);
  var_22 vehicle_setspeed(var_22.speed, var_22.accel);
  var_22 sethoverparams(50, 5, 2.5);
  var_22 setturningability(0.5);
  var_22 setyawspeed(100, 25, 25, 0.1);
  var_22 setCanDamage(1);
  var_22 setneargoalnotifydist(768);
  var_22 setscriptablepartstate("_encstr_8D98102E456FC82FB9BD7107F969183AB9FB", "_encstr_AB0703DBB9", 0);
  var_22 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_23 = "_encstr_83D225ECBD7BDA5FBD7A90011254FDCEB728F865153353C1699340903B6FB98657C5685569E7C3";
  var_22.frontturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_22 gettagorigin("_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_22.frontturret setModel(var_23);
  var_22.frontturret.owner = var_0;
  var_22.frontturret.team = "_encstr_8E8405EA382B2A";
  var_22.frontturret.angles = var_22.angles;
  var_22.frontturret.streakinfo = var_1;
  var_22.frontturret.turreton = 1;
  var_22.frontturret.name = "_encstr_9BAF0D33C9DEE68EAF47BAC9C956A3";
  var_22.frontturret.attackingtarget = undefined;
  var_22.frontturret linkTo(var_22);
  var_22.frontturret setturretteam("_encstr_8E8405EA382B2A");
  var_22.frontturret setturretmodechangewait(0);
  var_22.frontturret setmode("_encstr_849007B268BD03DFD8");
  var_22.frontturret setdefaultdroppitch(45);
  var_22.frontturret.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_22.frontturret.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_22.frontturret.groundtargetent dontinterpolate();
  var_22.rearturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_22 gettagorigin("_encstr_8AA1104B5B2461E420CBE22FE3992A1A8FD5"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_22.rearturret setModel(var_23);
  var_22.rearturret.owner = var_0;
  var_22.rearturret.team = "_encstr_8E8405EA382B2A";
  var_22.rearturret.angles = var_22.angles;
  var_22.rearturret.streakinfo = var_1;
  var_22.rearturret.turreton = 1;
  var_22.rearturret.name = "_encstr_B4F50CE49516C9BE47D593392BE8";
  var_22.rearturret.attackingtarget = undefined;
  var_22.rearturret linkTo(var_22);
  var_22.rearturret setturretteam("_encstr_8E8405EA382B2A");
  var_22.rearturret setturretmodechangewait(0);
  var_22.rearturret setmode("_encstr_849007B268BD03DFD8");
  var_22.rearturret setdefaultdroppitch(45);
  var_22.rearturret.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_22.rearturret.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_22.rearturret.groundtargetent dontinterpolate();
  var_22.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_22 gettagorigin("_encstr_ACF80B99F702D840F25D235887"));
  var_22.killcament linkTo(var_22, "_encstr_ACF80B99F702D840F25D235887", (-600, 0, 1000), (0, 0, 0));
  var_22.frontturret.killcament = var_22.killcament;
  var_22.rearturret.killcament = var_22.killcament;
  level notify("_encstr_AA67171FA023D3325D0D1E15EE297A96E9E9AF93385B182A75", var_22);
  return var_22;
}

startenemychopper(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self setvehgoalpos(self.pathgoal, 1);
  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_1.streakname, 1);
  thread choppersupport_neargoalsettings_enemy();
  self playsoundonmovingent("_encstr_95DA1C68DA57103BE2DBC1E3FBC9FEF8107290C383EFC8EFEBCBC7F3C7E2");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_A6DE168658DC32B156A4E68DDEDA2DB9D9D4D1A5E6CE59E4")]](scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);
}

choppersupport_neargoalsettings_enemy() {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_watchdestoyed();
  thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_watchgameendleave();
  thread choppersupport_leaveoncommand_enemy();
  thread choppersupport_patrolfield_enemy(1);
  thread choppersupport_engageturrettarget_enemy(self.frontturret);
  thread choppersupport_engageturrettarget_enemy(self.rearturret);
}

choppersupport_leaveoncommand_enemy() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  level waittill("_encstr_870119E9027310902DD57353C713A843CF6AC0911B6731D886BE7B");
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_cleanup();
}

choppersupport_patrolfield_enemy(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_86BD0980BBC647A80FDE04");
  self endon("_encstr_B6911073D66FB81C0F42717ECB074E500724");

  if(self.currentaction != "_encstr_96080730D8534E0A28")
    self.currentaction = "_encstr_96080730D8534E0A28";
  else if(self.currentaction == "_encstr_96080730D8534E0A28" && !istrue(var_0)) {
    return;
  }
  self setneargoalnotifydist(100);
  var_1 = 0;

  for(;;) {
    if(self.currentaction == "_encstr_AD1C0A291B7C0BBEA2BFFDE7") {
      if(!istrue(var_1))
        var_1 = 1;

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_1)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_B40117C634B70E0E95C9D7E6AEE0C1DBC947EB0EC23A39DE63");
      var_1 = 0;
    }

    var_2 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findclosestpatrolstruct();

    if(isDefined(var_2))
      scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(var_2, 1);
    else {
      var_4 = [];
      var_5 = (0, 0, 0);
      var_6 = self.pathgoal;

      foreach(var_8 in level.players) {
        if(!var_8 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        var_5 = var_5 + var_8.origin;
        var_4[var_4.size] = var_8;
      }

      if(isDefined(var_5) && var_4.size > 0) {
        var_10 = var_5 / var_4.size;
        scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(var_10);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

choppersupport_engageturrettarget_enemy(var_0) {
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!istrue(var_0.turreton)) {
      waitframe();
      continue;
    }

    var_1 = choppersupport_gettargets_enemy();

    if(isDefined(var_1) && var_1.size > 0) {
      var_2 = choppersupport_acquireturrettarget_enemy(var_0, var_1);

      if(isDefined(var_2) && var_2 == "_encstr_85680FEB7807CA1361F59FDE1BEB3F154F")
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);

      if(!scripts\cp_mp\killstreaks\chopper_support::choppersupport_checkifactivetargets())
        thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_patrolfield();
    }

    wait 0.05;
  }
}

choppersupport_gettargets_enemy() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 = [];
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(choppersupport_istarget_enemy(var_3)) {
      if(isDefined(var_1[var_2]))
        var_0[var_0.size] = var_1[var_2];
    } else
      continue;

    wait 0.05;
  }

  return var_0;
}

choppersupport_istarget_enemy(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");

  if(!isalive(var_0) || var_0.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    return 0;

  if(!isDefined(var_0.pers["_encstr_8AEF05472BC2D6"]))
    return 0;

  if(var_0.pers["_encstr_8AEF05472BC2D6"] == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7"))
      return 0;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(scripts\cp_mp\killstreaks\chopper_support::choppersupport_isactivetarget(var_0))
    return 0;

  if(distance2dsquared(self.origin, var_0.origin) > 16000000)
    return 0;

  if(var_0 sightconetrace(self.origin, self) < 1)
    return 0;

  return 1;
}

choppersupport_acquireturrettarget_enemy(var_0, var_1) {
  self notify("_encstr_B6911073D66FB81C0F42717ECB074E500724");
  var_2 = undefined;
  var_3 = choppersupport_getbesttarget_enemy(var_0, var_1);

  if(isDefined(var_3)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_setcurrenttarget(var_0, var_3);
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_fireonturrettarget(var_0, var_3, 1);
    var_2 = "_encstr_85680FEB7807CA1361F59FDE1BEB3F154F";
  } else
    var_2 = "_encstr_A1DF1327FD1ECBBF1A7093698811E6F2867441B330";

  return var_2;
}

choppersupport_getbesttarget_enemy(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!choppersupport_istarget_enemy(var_5)) {
      continue;
    }
    var_6 = abs(vectortoangles(var_5.origin - self.origin)[1]);
    var_7 = abs(self gettagangles("_encstr_A14F0AE336178944BA076F41")[1]);
    var_6 = abs(var_6 - var_7);
    var_8 = var_5 getweaponslistitems();

    foreach(var_10 in var_8) {
      var_11 = weaponclass(var_10);

      if(var_11 == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0")
        var_6 = var_6 - 40;
    }

    if(distancesquared(self.origin, var_5.origin) > 16000000)
      var_6 = var_6 + 40;

    if(!isDefined(var_2) || var_2 > var_6) {
      var_2 = var_6;
      var_3 = var_5;
    }
  }

  return var_3;
}