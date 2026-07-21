/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58306.gsc
***********************************************/

keypad_check_levelinput() {
  if(!isDefined(level._id_13D51))
    level._id_13D51 = [];

  level._id_13D51["_encstr_AFDD05A6AB763B"] = ::jugg_init;
}

jugg_init() {
  build_vehicle_drop_off_list();
  scripts\mp\mp_agent::init_agent("_encstr_B16824CBD3E6A3A018F1A199A729F8692B074B573F5AF5199C57E910CD192813325B5DE78F03");
  thread playing_stealth_alert_music();
  thread dialog_init();
  thread _id_12F06();
  thread ai_init();

  switch (level.trial["_encstr_836105A5EFB2E5"]) {
    case "_encstr_86D70CE85A1768FD42CB95B7CB2A":
      thread _id_128BA();
      break;
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
    default:
      thread _id_128BC();
      break;
  }
}

_id_128BC() {
  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");
  thread mine_light_vfx();
  level.player waittill("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  var_0 = gettime();
  _tablethide::_id_13D88();
  _tablethide::_id_13D89(0);
  thread playerzombiestreamwaittillcomplete();
  thread _id_129C3();
  level._id_13D6A = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level._id_13D25 = 1;
  level._id_1404A = "_encstr_8B01195940C3E0DBBE6A2AAFB0B8EADB59EE9B6B076ACF30876786";
  level._id_13D40 = 5;
  level._id_13D67 = 2;
  _id_14348(var_0 + 15000);
  level._id_13D25 = 0;
  level._id_13D40 = 6;
  level._id_13D67 = 3;
  _id_14348(var_0 + 30000);
  level._id_13D40 = 7;
  level._id_13D67 = 4;
  _id_14348(var_0 + 45000);
  thread _id_13BD0();
  level._id_1404A = "_encstr_8B6D1C10C0354F8B7FDAA0F9C1E2D31B884F38EBE7D9174B6BA088E9288F";
  _id_14348(var_0 + 60000);
  level._id_13D40 = 8;
  level._id_13D4D = 1;
  _id_14348(var_0 + 85000);
  var_1 = gettime();
  level._id_13D40 = 0;

  while(level._id_13D23.size) {
    if(gettime() > var_1 + 10000) {
      break;
    }

    waitframe();
  }

  _id_135FB();
  wait 10;
  var_2 = gettime();
  level._id_13D40 = 8;
  level._id_13D67 = 5;
  level._id_1404A = "_encstr_99591AE278050FE03913A0870978AC8739F68A6BA1EC0FDFF863BC85";
  _id_14348(var_2 + 15000);
  level notify("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level._id_13D67 = 6;
  level._id_13D4D = 2;
  _id_14348(var_2 + 15000 + 15000);
  level._id_13D25 = 1;
  level.chopper = spawn_chopper();
  level.chopper waittill("_encstr_AD75063D571AE108");
  _id_12F03(1000);
  level._id_13D40 = 10;
  level._id_13D67 = 8;
  level._id_13D25 = 0;
  wait 5;
  mp_boneyard_gw_patch();
  level._id_13D40 = 0;
}

_id_128BA() {
  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");
  thread mine_light_vfx();
  level.player waittill("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  var_0 = gettime();
  _tablethide::_id_13D88();
  _tablethide::_id_13D89(0);
  thread playerzombiestreamwaittillcomplete();
  thread _id_129C3();
  level._id_13D6A = 1;
  level.player.maxhealth = 10000;
  level.player.health = 10000;
  level.healthregendisabled = 1;
  level._id_1404A = "_encstr_8B01195940C3E0DBBE6A2AAFB0B8EADB59EE9B6B076ACF30876786";
  level._id_13D40 = 7;
  level._id_13D67 = 2;
  _id_14348(var_0 + 20000);
  level._id_13D40 = 8;
  level._id_13D67 = 3;
  _id_14348(var_0 + 35000);
  level._id_13D40 = 9;
  level._id_13D67 = 4;
  _id_14348(var_0 + 50000);
  thread _id_13BD0();
  level._id_1404A = "_encstr_8B6D1C10C0354F8B7FDAA0F9C1E2D31B884F38EBE7D9174B6BA088E9288F";
  _id_14348(var_0 + 65000);
  level._id_13D40 = 10;
  level._id_13D4D = 2;
  _id_14348(var_0 + 75000);
  var_1 = gettime();
  level._id_13D40 = 0;

  while(level.agentarray.size) {
    if(gettime() > var_1 + 10000) {
      break;
    }

    waitframe();
  }

  _id_135FB();
  wait 10;
  var_2 = gettime();
  level._id_13D40 = 10;
  level._id_13D67 = 5;
  level._id_1404A = "_encstr_99591AE278050FE03913A0870978AC8739F68A6BA1EC0FDFF863BC85";
  _id_14348(var_2 + 30000);
  level notify("_encstr_B61815BB43B41DCAFA07347B37C1867B39EAE6FA59CD91");
  level._id_13D67 = 6;
  level._id_13D4D = 3;
  _id_14348(var_2 + 30000 + 30000);
  level._id_13D40 = 0;
  level.chopper = spawn_chopper();
  level.chopper waittill("_encstr_AD75063D571AE108");
  _id_12F03(1000);
  level._id_13D40 = 10;
  level._id_13D67 = 8;
  wait 5;
  mp_boneyard_gw_patch();
  level._id_13D40 = 0;
}

_id_14348(var_0) {
  while(gettime() < var_0)
    waitframe();
}

playerzombiestreamwaittillcomplete() {
  level.player waittill("_encstr_AD75063D571AE108");
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B");
  var_0 = sortbydistance(var_0, level.player.origin);

  foreach(var_2 in level._id_13D23)
  var_2 setgoalpos(var_0[var_0.size - 1].origin);

  if(isDefined(level.chopper))
    level.chopper thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_leave();

  wait 3;
  score_calculate(1);
  _tablethide::trial_ui_waittill_retry();
  level.player setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1);
  level.player clearsoundsubmix("_encstr_9A0113E883515FA023F4269DC22FE907090A50504A", 2);
  scripts\mp\gamelogic::restart();
}

_id_129C3() {
  level._id_13D5D = 1;

  while(level._id_13D5D) {
    wait 1;
    triggeroneoffradarsweep(level.player);
  }
}

mine_light_vfx() {
  wait 1;
  level.cratedata.configs["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"].timeout = 99999;
  var_0 = getEnt("_encstr_A6D617A3395A858DFAA9AE3B9D5927E62CD53AFA6CE4161D59", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = magicgrenademanual("_encstr_A9AF1246CAC1367B2FAF0B969CC8C9DB07AFD683", var_0.origin, (0, 0, 0), 1);
  var_1.owner = level.player;
  var_2 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", level.player);
  var_2.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_2.streakname);
  var_2.mpstreaksysteminfo.attackerisinflictor = gettime();
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered(var_2);
  scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse(var_2);
  scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
  var_1 thread scripts\cp_mp\killstreaks\juggernaut::watchmarkeractivate(var_2);
  level.cratedata.configs["_encstr_8BFC0BC2CBD4F737E0A5E1FD79"].activatecallback = undefined;
}

_id_135FB() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_encstr_84A8206730D045F2DB80EB24F3B90A377BC02F6F30C8B7CBEBAEF91C68BD62C5CDC8");
  var_0 = [];
  var_0[0] = spawnStruct();
  var_0[0].angles = level.player.angles[1];
  var_0[0].location = level.player.origin;
  var_0[0].string = "_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773";
  var_1 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_8161113BE8A8948A78316B7F5F9722F718D3B2", level.player);
  var_1.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_1.streakname);
  var_1.mpstreaksysteminfo.attackerisinflictor = gettime();
  level.wpinprogress = 1;

  foreach(var_7, var_3 in var_0) {
    var_4 = var_3.location;
    var_5 = var_3.angles;
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145E6("_encstr_8D820B49520F0EC02DDE6367EC");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145E6("_encstr_81170C244F9CBDE72C01BB99A298");
    level.player thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145E6("_encstr_923011E397F3A22518DEF23AB1087CEAD53F1B");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
    var_6 = level.player scripts\cp_mp\killstreaks\white_phosphorus::wp_createplane(var_4, var_5, var_1);

    if(!isDefined(var_6))
      return 0;

    objective_delete(var_6.minimapid);
    var_6 thread scripts\cp_mp\killstreaks\white_phosphorus::_id_145EA();
    var_6 thread scripts\cp_mp\killstreaks\white_phosphorus::wp_deliverpayloads(var_1);

    if(var_0.size > 1 && var_7 < var_0.size - 1)
      wait(randomfloatrange(1, 3.0));
  }
}

spawn_chopper() {
  while(level._id_13D24.size) {
    foreach(var_1 in level._id_13D24) {
      if(!var_1 agentcanseesentient(level.player))
        var_1 kill();
    }

    waitframe();
  }

  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_encstr_8FF81F0750B0E5527B204E841051BBAD9B193FD7902B576B89D8D43D8E07A37EA1");
  var_3 = level.player;
  var_4 = "_encstr_8E8405EA382B2A";

  if(level.player.team == "_encstr_8E8405EA382B2A")
    var_4 = "_encstr_9A8507BA4040188D08";

  var_5 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3", var_3);
  var_5.isdeploying = 0;
  var_5.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(var_5.streakname);
  var_5.mpstreaksysteminfo.attackerisinflictor = gettime();
  var_6 = (0, 0, 1750);
  var_7 = var_3.origin - anglesToForward(var_3.angles) * 15000 + var_6;
  var_8 = var_3.origin + anglesToForward(var_3.angles) * 2000 + var_6;
  var_9 = var_3.angles;
  var_10 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_11 = randomint(level.heli_structs_entrances.size);
    var_12 = level.heli_structs_entrances[var_11];
    var_10 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_12.script_linkto, level.heli_structs_goals);
    var_13 = var_12.origin * (1, 1, 0) + var_6;
    var_14 = var_10.origin * (1, 1, 0) + var_6;
    var_15 = vectorNormalize(var_14 - var_13);
    var_7 = var_14 - var_15 * 15000;
    var_8 = var_14;
    var_9 = vectortoangles(var_15);
  }

  var_16 = "_encstr_BE50133BC7C819C9ED087107F389E30EA7D1F9F0C8";

  if(var_4 == "_encstr_8E8405EA382B2A")
    var_16 = "_encstr_A3EC184E8538D2F9F368DAE10BD36A97D37FACD62F66EF3EB798";

  var_17 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_3, var_7, var_9, "_encstr_880B175437EAD70908E7D0C8D74AC6C7431ACF504A830F30F8", var_16);
  var_17.speed = 100;
  var_17.accel = 50;
  var_17.lifetime = 9999;
  var_17.team = var_4;
  var_17.owner = var_3;
  var_17.angles = var_9;
  var_17.streakinfo = var_5;
  var_17.streakname = var_5.streakname;
  var_17.flaresreservecount = 1;
  var_17.currentdamagestate = 0;
  var_17.pathstart = var_7;
  var_17.pathgoal = var_8;
  var_17.currentaction = "_encstr_96080730D8534E0A28";
  var_17.currenttarget = undefined;
  var_17.currentpatrolstruct = var_10;
  var_17.heightoffset = var_6;
  var_17.infil_complete = var_6[2] - 750;
  var_17.health = 1200;
  var_17.maxhealth = 1200;
  var_17 scripts\mp\sentientpoolmanager::registersentient("_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]](var_5.streakname, "_encstr_B6221A912898A54D273037B5B1CEA83FC8F24D826FB0B5F0C3D553B4", undefined, "_encstr_A58418E3DA959F3D4823BF2F0B1890B050A64F4B45071B8F3855", "_encstr_824522B6BF39A4808DF3A121853B39226D48E08566BFD860715721FB479BB568F317EAC3");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD"))
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD")]](var_5.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8"))
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8")]](var_5.streakname, ::goodwork);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF"))
    var_17[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF")]](var_5.streakname, scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);

  level.vehicles.damagecallbacks.deathcallbacks["_encstr_A1D710C6D0EDE00EB239EB37D5071CED27A3"] = ::givearmorvalue;
  var_17 setmaxpitchroll(15, 15);
  var_17 vehicle_setspeed(var_17.speed, var_17.accel);
  var_17 sethoverparams(50, 5, 2.5);
  var_17 setturningability(0.5);
  var_17 setyawspeed(100, 25, 25, 0.1);
  var_17 setCanDamage(1);
  var_17 setneargoalnotifydist(768);
  var_17 setscriptablepartstate("_encstr_8D98102E456FC82FB9BD7107F969183AB9FB", "_encstr_AB0703DBB9", 0);
  var_17 setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  var_18 = "_encstr_82BC202BBF802A40225FD9B7978A1EC92154B0E327FC12AD393313F5E3126581EFED";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_3))
    var_18 = "_encstr_83D225ECBD7BDA5FBD7A90011254FDCEB728F865153353C1699340903B6FB98657C5685569E7C3";

  var_17.frontturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_17 gettagorigin("_encstr_8E5611E85A97EFDB8F125EDD0CFF417D7D5260"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_17.frontturret.name = "_encstr_9BAF0D33C9DEE68EAF47BAC9C956A3";
  var_17.rearturret = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_17 gettagorigin("_encstr_8AA1104B5B2461E420CBE22FE3992A1A8FD5"), "_encstr_91BF1AB1D0DBC138569CAFCD5DE0E0DE4E3AEBD15D93E4B247BE6B0E");
  var_17.rearturret.name = "_encstr_B4F50CE49516C9BE47D593392BE8";
  var_19 = [var_17.frontturret, var_17.rearturret];

  foreach(var_21 in var_19) {
    var_21 setModel(var_18);
    var_21.owner = var_3;
    var_21.team = var_4;
    var_21.angles = var_17.angles;
    var_21.streakinfo = var_5;
    var_21.turreton = 1;
    var_21.attackingtarget = undefined;
    var_21 linkTo(var_17);
    var_21 setturretteam(var_4);
    var_21 setturretmodechangewait(0);
    var_21 setmode("_encstr_849007B268BD03DFD8");
    var_21 setdefaultdroppitch(45);
    var_21.groundtargetent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_17.origin);
    var_21.groundtargetent setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_21.groundtargetent dontinterpolate();
  }

  var_17.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_17 gettagorigin("_encstr_ACF80B99F702D840F25D235887"));
  var_17.killcament linkTo(var_17, "_encstr_ACF80B99F702D840F25D235887", (-600, 0, 1000), (0, 0, 0));
  var_17 setvehgoalpos(var_17.pathgoal, 1);
  var_17 playsoundonmovingent("_encstr_95DA1C68DA57103BE2DBC1E3FBC9FEF8107290C383EFC8EFEBCBC7F3C7E2");
  var_17.owner = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_17.owner.team = var_4;
  var_17.owner.name = "_encstr_927C11439BE2021308A8222A81B0577BC83B2B";
  var_17.owner.pers["_encstr_8AEF05472BC2D6"] = var_4;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_88031DD60D7078034D1D8F270BEFCBAF202B419D5858387B88D97F570B1CC2"] = undefined;
  level.sharedfuncs["_encstr_8A6705191B7B76"]["_encstr_9BBE1203BB08753F4D33D29AF83D4BAA88358594"] = ::mortar_init;
  var_17 thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_neargoalsettings();
  var_17 thread giverewards();
  var_17 vehicleshowonminimap(0);
  var_17.objid = var_17 scripts\mp\objidpoolmanager::createobjective("_encstr_A90B1D71DF60855F912DD2AAE8FF9BB16851FFD051E84A9746BB2B43B04E43", var_4, undefined, 1, 1);
  objective_setminimapiconsize(var_17.objid, "_encstr_9BD90B2D1BBDE6BEC60B4E76CA");
  level notify("_encstr_A33010C01B85818EEF194EC6FC5BB07FEFF3");
  return var_17;
}

givearmorvalue(var_0) {
  objective_delete(self.objid);
  self.killedbyweapon = var_0.objweapon;
  self.streakinfo = undefined;
  self notify("_encstr_AD75063D571AE108");
}

giverewards() {
  self endon("_encstr_860808CB78E2984063BA");
  self waittill("_encstr_AD75063D571AE108");
  wait 3;

  if(isDefined(self)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_crash(100);
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_explode();
  }
}

goodwork(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  self.currenthealth = self.health - var_4;

  if(self.currenthealth <= 1500 && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
  } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
  } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
  }

  return 1;
}

_id_13BD0() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_encstr_818E1BAF95CD95D62FD7477BB616BE6EE8392DDA2B7D4BDC31F6BAB991");
  level endon("_encstr_BE250FC643F0F7CF8511833A186F3BAF20");
  level.player endon("_encstr_AD75063D571AE108");
  level endon("_encstr_A33010C01B85818EEF194EC6FC5BB07FEFF3");
  var_0 = level.player scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A2E60C6BC099B7E1A0A93A398F48", level.player);

  for(;;) {
    var_1 = anglesToForward(level.player getplayerangles());
    var_2 = anglesToForward(level.player.angles);
    var_3 = anglestoright(level.player.angles);
    var_4 = level.player scripts\cp_mp\killstreaks\toma_strike::findunobstructedfiringinfo(level.player.origin, 500, var_1, var_2, var_3);
    level.player tomastrike_firestrike(var_4, var_0);
    wait(randomfloatrange(3, 6));
  }
}

tomastrike_firestrike(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = magicgrenademanual("_encstr_95E70D8EDBDA85F5839CED35F5B683", var_0.sourcepos, var_0.initvelocity, 5);
  var_3 = var_2 scripts\mp\objidpoolmanager::createobjective("_encstr_A18A1BD2367B9BD7B52DB92DB60B38AFD8E4AED2DCACDA4B373796632B", "_encstr_8E8405EA382B2A", undefined, 1, 1);
  var_2 setentityowner(self);
  var_2 setotherent(self);
  var_2.owner = self;
  var_2 setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_930B07BB1B6B3854FF", 0);
  var_2 setscriptablepartstate("_encstr_8AA6067362614831", "_encstr_930B07BB1B6B3854FF", 0);
  var_2.explodeent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_2.explodeent setModel("_encstr_8AED1AB69BBE47BD6BB0BEB98E9C4BD6B27DD64B6ECDD2632BEBAD07");
  var_2.explodeent linkTo(var_2);
  var_2.explodeent dontinterpolate();
  var_2.explodeent setentityowner(self);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.sourcepos);
  var_4 linkTo(var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (10, 0, 10), (0, 0, 0));
  var_2.killcament = var_4;
  var_2.streakinfo = var_1;
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_airexplosion(var_0.preexplpos);
  var_2 thread scripts\cp_mp\killstreaks\toma_strike::toma_strike_watch_stuck(vectortoangles(var_0.initvelocity), gettime(), var_0.initvelocity);
  var_2 waittill("_encstr_AD75063D571AE108");
  objective_delete(var_3);
}

mp_boneyard_gw_patch() {
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_encstr_9B77144FFB187A45E8F68D5368D0AF72E00D077F45B5");
  var_0 = 6;
  var_1 = 10;
  var_2 = level.nuke_expl_struct.origin;
  var_3 = vectorNormalize((var_2[0], var_2[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
  var_4 = var_2 + var_3 * 15000;
  var_4 = var_4 + (0, 0, 30000) + var_3 * 5000;
  var_5 = spawnStruct();
  var_5.streakname = "_encstr_A1B90BB32380C2D0A1587087E7";
  var_5.nukegoalpoint = var_2;
  level.nuke_clockobject = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_4 + (0, 0, 100));
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_startprelaunchalarm(var_0);
  wait(var_0);
  playsoundatpos(var_4, "_encstr_85D415A14327A0B86B433B67E12BFF6BAE045765E5D60B");
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_launchmissile(undefined, undefined, var_4, var_2, var_1);
  wait(var_1);
  _id_12F04();
  level thread _calloutmarkerping_handleluinotify_acknowledged::setnuketimescalefactor();
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_explosion(undefined, var_5);
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_earthquake(undefined, var_5);
  visionsetnaked("_encstr_AC711298BB343B1E676CB03E7993C6F55D42F830", 0.05);
  setDvar("_encstr_87642439EBD60BE8B2934B85B190B1DEDBB6212A356C39A5E0D19AB06E47AC4E51372CC4D8AC", 0);
  wait 0.5;
  level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_fadeflashvision(1, 2);
  wait 4.5;
  _calloutmarkerping_handleluinotify_acknowledged::_id_11EF4();
  level.movetonewprop = level.player.health;
  level.player kill();
  level thread _calloutmarkerping_handleluinotify_acknowledged::_id_11EF1(2);

  foreach(var_7 in level._id_13D23)
  var_7 dodamage(99999, var_2);

  level notify("_encstr_BDD90B3ACBBFEA87EC98F94B6C");
}

mortar_init(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22, var_23, var_24, var_25) {}

ai_init() {
  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");
  level._id_13D23 = [];
  level._id_13D24 = [];
  level._id_13D66 = [];
  level._id_13D40 = 0;
  level._id_13D67 = 1;
  level._id_1404A = "_encstr_8B01195940C3E0DBBE6A2AAFB0B8EADB59EE9B6B076ACF30876786";

  for(;;) {
    while(level._id_13D40 <= level.agentarray.size - scripts\mp\mp_agent::getfreeagentcount())
      waitframe();

    if(istrue(level._id_13D4D)) {
      _id_13544();
      level._id_13D4D--;
    } else
      _id_134EF();

    waitframe();
  }
}

_id_134EF() {
  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  if(!isDefined(level.agent_funcs["_encstr_880B07DFB62BB72B3F" + level._id_1404A])) {
    level.agent_funcs["_encstr_880B07DFB62BB72B3F" + level._id_1404A] = [];
    level.agent_funcs["_encstr_880B07DFB62BB72B3F" + level._id_1404A]["_encstr_8C841417DFC0FF7B93D802B938E5F9B339B1998F6549"] = ::_id_13D28;
    level.agent_funcs["_encstr_880B07DFB62BB72B3F" + level._id_1404A]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::_id_13D29;
  }

  var_0 = scripts\mp\mp_agent::spawnnewagentaitype(level._id_1404A, play_player_falling_anims(), (0, 0, 0));
  var_0.a.disablelongdeath = 1;
  var_0 enabletraversals(0);
  var_0.goalradius = 750;
  level._id_13D23 = scripts\engine\utility::array_add(level._id_13D23, var_0);
  var_0 thread bot_abort_tactical_goal_for_revive();
  var_0 thread bot_cache_entrances_to_other_zones();
  var_0 setgoalentity(level.player);
  var_0 agentsetfavoriteenemy(level.player);
}

_id_13544() {
  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  if(!isDefined(level.agent_funcs["_encstr_86B920E91EBCB0F6214F3D23476BA87850F9B3030411E0380A17173F9F0308500D8B"])) {
    level.agent_funcs["_encstr_86B920E91EBCB0F6214F3D23476BA87850F9B3030411E0380A17173F9F0308500D8B"] = [];
    level.agent_funcs["_encstr_86B920E91EBCB0F6214F3D23476BA87850F9B3030411E0380A17173F9F0308500D8B"]["_encstr_8C841417DFC0FF7B93D802B938E5F9B339B1998F6549"] = ::_id_13D28;
    level.agent_funcs["_encstr_86B920E91EBCB0F6214F3D23476BA87850F9B3030411E0380A17173F9F0308500D8B"]["_encstr_8D0F13CAB7E1501459D3B241E79837FFE1317BBFF8"] = ::_id_13D29;
  }

  var_0 = scripts\mp\mp_agent::spawnnewagentaitype("_encstr_95701A5B2BC22150FFFDA35EA3BA986F2A87DDF3B74AFDF016D60B33", play_player_falling_anims(), (0, 0, 0));
  var_0.a.disablelongdeath = 1;
  var_0 enabletraversals(0);
  level._id_13D23 = scripts\engine\utility::array_add(level._id_13D23, var_0);
  level._id_13D24 = scripts\engine\utility::array_add(level._id_13D24, var_0);
  var_0 setgoalentity(level.player);
  var_0 agentsetfavoriteenemy(level.player);
  var_0.favoriteenemy = level.player;
}

play_player_falling_anims() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_8A550CA8037FCD9021830923AF55");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BA891631A8D8EDA759B36AC36B3A1F3E62C34FBB35138B50");
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_858C12AF1A37B997E9607371037AA963717F2D9B");
  var_3 = scripts\engine\utility::array_combine(var_0, var_1, var_2);
  var_4 = sortbydistance(var_3, level.player.origin);
  var_5 = var_4[0];
  var_6 = [];

  foreach(var_8 in var_4) {
    var_9 = getaiarrayinradius(var_8.origin, 256);

    if(var_9.size) {
      continue;
    }
    var_10 = spawnsighttrace(var_8, var_8.origin + (0, 0, 56), level.player.origin + (0, 0, 56));

    if(!var_10)
      var_6[var_6.size] = var_8;
  }

  var_12 = int(clamp(var_6.size, 0, 4));
  var_13 = randomintrange(0, var_12);

  if(istrue(level._id_13D25))
    var_13 = var_6.size - 1 - var_13;

  var_5 = var_6[var_13];
  return var_5.origin;
}

bot_abort_tactical_goal_for_revive() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");
    bot_abort_emp_pickup();
  }
}

bot_abort_emp_pickup() {
  self notify("_encstr_8C7B141A356FDAE47E9B0317C833ADF35FD5A455ADD5");
  self endon("_encstr_8C7B141A356FDAE47E9B0317C833ADF35FD5A455ADD5");
  level._id_13D66[self.entity_number] = self;
  var_0 = gettime() + 750;

  while(var_0 > gettime() && self.health > 0)
    waitframe();

  level._id_13D66 = scripts\engine\utility::array_remove_key(level._id_13D66, self.entity_number);
}

bot_cache_entrances_to_other_zones() {
  self endon("_encstr_AD75063D571AE108");
  self.dontevershoot = 0;

  for(;;) {
    var_0 = level._id_13D66.size >= level._id_13D67;
    var_1 = !isDefined(level._id_13D66[self.entity_number]);

    if(var_0 && var_1)
      self.dontevershoot = 1;
    else
      self.dontevershoot = 0;

    waitframe();
  }
}

_id_13D28(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_5.basename == level.player.primaryweaponobj.basename)
    var_1 thread scripts\mp\damagefeedback::updatedamagefeedback("_encstr_A5AE098ADB583E0AF7A5AB", var_2 >= self.health);
}

_id_13D29(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level._id_13D23 = scripts\engine\utility::array_remove(level._id_13D23, self);
  level._id_13D24 = scripts\engine\utility::array_remove(level._id_13D24, self);

  if(var_4.basename == level.player.primaryweaponobj.basename) {
    if(self.agent_type == "_encstr_86B920E91EBCB0F6214F3D23476BA87850F9B3030411E0380A17173F9F0308500D8B")
      thread _id_12F03(500);
    else
      thread _id_12F03(100);
  }
}

_id_12F06() {
  _tablethide::_id_13D8C(4000);
  level.score = [];

  if(game["_encstr_8CA606F38878410D"]["_encstr_9B230BB64D9BDD493B975FDB03"] == -1)
    level.score["_encstr_AF9B051E1D0B0C"] = 0;
  else
    level.score["_encstr_AF9B051E1D0B0C"] = game["_encstr_8CA606F38878410D"]["_encstr_9B230BB64D9BDD493B975FDB03"];

  _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
  level.score["_encstr_BE7D0633C08849E2"] = 0;
  level.score["_encstr_AAAC09701B829B88093F5B"] = 0;
  level.score["_encstr_8E8D0697EB01F243"] = 0;
  level.score["_encstr_8E08158556AF90931F7BA95BF275A12903FF1E08A55B7B"] = 0;
  level.score["_encstr_976C0E432D9D43B2B9D1EB6CDBAD31B7"] = 0;
  level.score["_encstr_999A060533C0FDD2"] = 0;
  score_calculate();
}

score_calculate(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  level.score["_encstr_AAAC09701B829B88093F5B"] = level.score["_encstr_8E8D0697EB01F243"];
  level.score["_encstr_BE7D0633C08849E2"] = level.score["_encstr_AAAC09701B829B88093F5B"] + level.score["_encstr_999A060533C0FDD2"];
  _tablethide::trial_ui_set_stat_and_bonus_score(1, "_encstr_93371859CD2B6B4BCAB9F5B5961B1BAC8CBE73B7AF4E0B4796BD", level.score["_encstr_8E08158556AF90931F7BA95BF275A12903FF1E08A55B7B"], 0);
  _tablethide::trial_ui_set_stat_and_bonus_score(2, "_encstr_976C0E432D9D43B2B9D1EB6CDBAD31B7", level.score["_encstr_976C0E432D9D43B2B9D1EB6CDBAD31B7"], 0);
  _tablethide::trial_ui_set_subscore(level.score["_encstr_AAAC09701B829B88093F5B"]);
  hud_set_reward_tier();

  if(var_0) {
    _tablethide::trial_ui_set_main_score(level.score["_encstr_BE7D0633C08849E2"]);

    if(level.score["_encstr_AF9B051E1D0B0C"] < level.score["_encstr_BE7D0633C08849E2"]) {
      level.score["_encstr_AF9B051E1D0B0C"] = level.score["_encstr_BE7D0633C08849E2"];
      _tablethide::trial_ui_set_best_score(level.score["_encstr_AF9B051E1D0B0C"]);
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_83BB0B2AF52B93E9EF78EAE280"] = level.score["_encstr_8E08158556AF90931F7BA95BF275A12903FF1E08A55B7B"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B1B10B75D57208082F6A38C172"] = level.score["_encstr_976C0E432D9D43B2B9D1EB6CDBAD31B7"];
      game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_8E6E0A761F73A9D656E77008"] = level.score["_encstr_999A060533C0FDD2"] > 0;
    }

    hud_set_reward_tier(1);
    level notify("_encstr_B8D80D131723B292AB2759B2975BA0");
    thread _tablethide::trial_ui_open_results_screen();
  }
}

hud_set_reward_tier(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    var_1 = level.score["_encstr_AF9B051E1D0B0C"];
  else
    var_1 = level.score["_encstr_AAAC09701B829B88093F5B"];

  if(var_1 >= level.trial["_encstr_966C066BF011B2F7"])
    var_2 = 3;
  else if(var_1 >= level.trial["_encstr_876C06B1FF0A66F2"]) {
    var_3 = level.trial["_encstr_966C066BF011B2F7"] - level.trial["_encstr_876C06B1FF0A66F2"];
    var_4 = var_1 - level.trial["_encstr_876C06B1FF0A66F2"];
    var_2 = 2 + var_4 / var_3;
  } else if(var_1 >= level.trial["_encstr_816C069599555DA7"]) {
    var_3 = level.trial["_encstr_876C06B1FF0A66F2"] - level.trial["_encstr_816C069599555DA7"];
    var_4 = var_1 - level.trial["_encstr_816C069599555DA7"];
    var_2 = 1 + var_4 / var_3;
  } else
    var_2 = var_1 / level.trial["_encstr_816C069599555DA7"];

  if(var_0)
    _tablethide::trial_ui_set_reward_tier(var_2);
  else
    _tablethide::trial_ui_set_reward_tier_preview(var_2);
}

_id_12F03(var_0) {
  if(!isDefined(level.vehicle_damage_setperkmoddamage))
    level.vehicle_damage_setperkmoddamage = 1;

  var_1 = min(100000, var_0 * level.vehicle_damage_setperkmoddamage);
  _tablethide::_id_13D8B(level.vehicle_damage_setperkmoddamage);
  level.vehicle_damage_setperkmoddamage++;

  if(level.score["_encstr_976C0E432D9D43B2B9D1EB6CDBAD31B7"] < level.vehicle_damage_setperkmoddamage)
    level.score["_encstr_976C0E432D9D43B2B9D1EB6CDBAD31B7"] = level.vehicle_damage_setperkmoddamage;

  thread hidedangercircle();
  level.player thread scripts\mp\rank::scorepointspopup(int(min(99999, var_1)));
  level.score["_encstr_8E08158556AF90931F7BA95BF275A12903FF1E08A55B7B"]++;
  level.score["_encstr_8E8D0697EB01F243"] = level.score["_encstr_8E8D0697EB01F243"] + var_1;
  score_calculate();
}

_id_12F04() {
  level.score["_encstr_999A060533C0FDD2"] = 50000;
  _tablethide::trial_ui_set_stat_and_bonus_score(3, "_encstr_A5740B638BE343D805D34BB379", 0, level.score["_encstr_999A060533C0FDD2"]);
  score_calculate();
}

hidedangercircle() {
  level notify("_encstr_858F0C97DDFFB59FE968D16387DB");
  level endon("_encstr_858F0C97DDFFB59FE968D16387DB");
  var_0 = gettime();

  while(gettime() < var_0 + 4000)
    waitframe();

  wait 0.25;
  level.vehicle_damage_setperkmoddamage = 1;
  _tablethide::_id_13D8B(0);
}

dialog_init() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B82511E33073C62B7E3DE6E4D8E3C70FADC12F"] = "_encstr_AFE5166B07F5C856C223D37BB9B2BE959B32F50C37470BE4";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_962A15A3272DC2C6BECA9B46EB1D4B59397DC0F5C2B1E8"] = "_encstr_B41214F89341513127CC92B7AE5F3E3F765AF138BA67";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8E25111D9CD20BD8AF56E6237DD1B4599CEBC4"] = "_encstr_8ABF160A0BDF49C5C81868AFC61A11D786BBE7F27B2BF713";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2511DC4DE0F6031811228A3EE54FAF90AF12"] = "_encstr_9B311611FF07696502D34A70700520B18588CEEE27E3E71D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922511F9A67C510C376F0BCD5F148740A29783"] = "_encstr_AF4C166B83D7C85916914F7BB9B2D72BB9C8F566DCA3859C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D6D1230CDAC5CC14C1A2CFB47D8075F46CD0610"] = "_encstr_AC8A12DBE35F7DEAFA100268428717B828A433A7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9130189AAE3BB3D7969BE8E4BDBE9B0DDB938E7DB52CE6D5B063"] = "_encstr_93B9186B73418590A1DF8238458D094BEACBCDE7376B5BF8EAB3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB6B0B5A331AA78E138B58D893"] = "_encstr_83901675F9E107B797A193CA88FD27BD6055CFD359C84A3B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_922C0E0DAD0FE8606B93F3FB3BDF2D08"] = "_encstr_AFB21AD683EB8CCAC2C8D3B773957DDE31A6EB9BB0D9AFA1EAC927BC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3DD10A6BAECCEBE47C24EEC56E8237BBBB9"] = "_encstr_9312153893EFBDA0DEE48DAF0607A9F0B38AF6606A5BE1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8B1C0DE3E0A137A191EF3D36C44BCA"] = "_encstr_AA1214AD077D322B0B19D3DB3756FADB89D47D32B5B3";
  _tablethide::waittill_player_isDefined();
  thread levelobjectives();
  thread light_tank_getmissileplayercommand();
}

levelobjectives() {
  var_0 = "_encstr_9130189AAE3BB3D7969BE8E4BDBE9B0DDB938E7DB52CE6D5B063";

  if(game["_encstr_8CA606F38878410D"]["_encstr_96E9101DBAB2EB7347DB20687F99280B2A67"] == 3)
    var_0 = "_encstr_8D6D1230CDAC5CC14C1A2CFB47D8075F46CD0610";

  wait 10;
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(var_0);
}

light_tank_getmissileplayercommand() {
  level.player waittill("_encstr_A702111AF557B7BF23BAEA6828779B1C4B023C");
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_AB6B0B5A331AA78E138B58D893");
}

level_weapon_spawn() {
  level.player endon("_encstr_AD75063D571AE108");

  for(;;) {
    level waittill("_encstr_858F0C97DDFFB59FE968D16387DB");
    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_922C0E0DAD0FE8606B93F3FB3BDF2D08");
    wait 8;
  }
}

lgbudgetingprobesize() {
  level.player endon("_encstr_AD75063D571AE108");

  for(;;) {
    while(level.player.health > level.player.maxhealth / 4)
      wait 0.5;

    level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8B1C0DE3E0A137A191EF3D36C44BCA");
    wait 8;
  }
}

light_tank_initcollision() {
  level.player endon("_encstr_AD75063D571AE108");

  while(!isDefined(level.chopper))
    wait 0.5;

  level.chopper waittill("_encstr_AD75063D571AE108");
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A3DD10A6BAECCEBE47C24EEC56E8237BBBB9");
}

playing_stealth_alert_music() {
  level.gameskill = 1;
  level.difficultytype[1] = "_encstr_8CA606F38878410D";
  anim.run_accuracy = 0.05;
  anim.walk_accuracy = 0.08;
  level.difficultysettings["_encstr_BE1116D98B2A83683A9F1BF1FD115835B027570B83724120"]["_encstr_8CA606F38878410D"] = 35000;
  level.difficultysettings["_encstr_937917E08D2CE595278E9C2BDC0B2356492C739D2B51D2D6B2"]["_encstr_8CA606F38878410D"] = 15000;
  level.difficultysettings["_encstr_9B0918C163855E2B3988DBD5C4B1CA749359B98532CA155AADCA"]["_encstr_8CA606F38878410D"] = 150000;
  level.difficultysettings["_encstr_8EA718295277AEF8CFCF47651DF56865DF0BC631CA4B5068E7CC"]["_encstr_8CA606F38878410D"] = 1;
  level.difficultysettings["_encstr_AF011C38F73EA6AFA2640F9DBAE9D5AB8A2778312BCD1843FB81059355A2"]["_encstr_8CA606F38878410D"] = 2.0;
  level.difficultysettings["_encstr_96AB1CD6B03CFACD3796C12BC9EB31EA93378E7D3295D8852FF547B46B59"]["_encstr_8CA606F38878410D"] = 3.0;
  level.difficultysettings["_encstr_A2A216EE36FF53ABFA99687B621353EB2FA56066938798E3"]["_encstr_8CA606F38878410D"] = 1.1;
  level.difficultysettings["_encstr_8394146BC55002B71E05020AEB6DFFFF4027F3C169E8"]["_encstr_8CA606F38878410D"] = 1.6;
  level.difficultysettings["_encstr_879611A3DF4BC621E1D539F57DDE20FDC25B19"]["_encstr_8CA606F38878410D"] = 0.05;
  level.difficultysettings["_encstr_9B9517AD2D379BA2A5D6CA11A5CDA32CCDB1ACC80B368EDB27"]["_encstr_8CA606F38878410D"] = 0.0001;
  _tablethide::waittill_player_isDefined();
  level.player playingcoughdamagesound(level.gameskill);
}

playingcoughdamagesound(var_0) {
  self.gameskill = level.gameskill;
  self.gs = spawnStruct();
  self.gs.min_sniper_burst_delay_time = 2;
  self.gs.max_sniper_burst_delay_time = 3;
  anim.min_sniper_burst_delay_time = self.gs.min_sniper_burst_delay_time;
  anim.max_sniper_burst_delay_time = self.gs.max_sniper_burst_delay_time;
  self.gs.misstimeconstant = 0.05;
  self.gs.misstimedistancefactor = 0.0001;
  self.gs.double_grenades_allowed = 1;
}

build_vehicle_drop_off_list() {
  level._id_13D32 = ::_id_13D35;

  if(!isDefined(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"])) {
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"] = [];
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_83BB0B2AF52B93E9EF78EAE280"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B1B10B75D57208082F6A38C172"] = 0;
    game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_8E6E0A761F73A9D656E77008"] = 0;
  }
}

_id_13D35() {
  var_0 = level.trial["_encstr_88120A27D8FBEB0A7F90FCA7"];
  var_1 = getomnvar("_encstr_A58F154B42BFF49BE0B72CCFABFBC7C7C8C5A74B84681A");
  var_2 = getomnvar("_encstr_965E14EA96AFA3E45A5836AF899537D1AF9BD8BDE42B");
  var_3 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_83BB0B2AF52B93E9EF78EAE280"]);
  var_4 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_B1B10B75D57208082F6A38C172"]);
  var_5 = int(game["_encstr_8CA606F38878410D"]["_encstr_8C9C0A406B2394C0B33AC877"]["_encstr_8E6E0A761F73A9D656E77008"]);
  level.player dlog_recordplayerevent("_encstr_AC691F48DA22A7E1EB4D978AC59FB3425BCE1077615083A7A9DA9958BFE5FB6FA9", ["_encstr_840703024B", var_0, "_encstr_A9EF051333FAB3", var_1, "_encstr_82FB06EB26785BD7", var_2, "_encstr_8E8D0697EB01F243", var_3, "_encstr_918E068DDBDA31B7", var_4, "_encstr_B8BA05F06B9785", var_5]);
}