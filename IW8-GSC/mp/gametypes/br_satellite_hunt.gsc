/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_satellite_hunt.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_84911D53788589CF98FF2A2C85C6AB8AB760FA9BE061BD37F3D50F50A5C83B", 0) == 0) {
    return;
  }
  level thread tracegroundheightexfil();
  level thread tomastrike_watchgameend();
  level tank_arrive_and_fire();
  scripts\engine\utility::add_fx("_encstr_B19D17DCC2E85963D8A5D1597D1B168D342BAFA55B1CB08D8E", "_encstr_A71834D80A702F58A7B828BEEA1E015B9B426098528DC1D88B0E4338C34F6BCB05FA10D8CA69274BAF234330A147138BAEE3A2B05278");
  level.setuptrain = getdvarint("_encstr_9B85176ED89CBE86589C0EFAC916462C4E95B42BBB8AB4DAAC", 90);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_81CC0586854EC1", scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  level.uavsettings["_encstr_81CC0586854EC1"] = spawnStruct();
  level.uavsettings["_encstr_81CC0586854EC1"].health = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].health;
  level.uavsettings["_encstr_81CC0586854EC1"].maxhealth = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].maxhealth;
  level.uavsettings["_encstr_81CC0586854EC1"].modelbase = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].modelbase;
  level.uavsettings["_encstr_81CC0586854EC1"].modelbasealt = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].modelbasealt;
  level.uavsettings["_encstr_81CC0586854EC1"].fxid_explode = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].playerzombielaststandrevive;
  level.uavsettings["_encstr_81CC0586854EC1"].fx_leave_tag = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fx_leave_tag;
  level.uavsettings["_encstr_81CC0586854EC1"].fxid_contrail = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fxid_contrail;
  level.uavsettings["_encstr_81CC0586854EC1"].fx_contrail_tag = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fx_contrail_tag;
  level.uavsettings["_encstr_81CC0586854EC1"].sound_explode = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].sound_explode;
  level.uavsettings["_encstr_81CC0586854EC1"].calloutdestroyed = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].calloutdestroyed;
  level.uavsettings["_encstr_81CC0586854EC1"].addfunc = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].addfunc;
  level.uavsettings["_encstr_81CC0586854EC1"].removefunc = level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].removefunc;
  level.uavsettings["_encstr_81CC0586854EC1"].streakname = "_encstr_81CC0586854EC1";
  level.uavsettings["_encstr_81CC0586854EC1"].teamsplash = "_encstr_88120A470839FC69711732AA";
  level.uavsettings["_encstr_81CC0586854EC1"].votimeout = "_encstr_BA2D0D1A0B9C83EB3A2DADB27BBA1D";
  level.uavsettings["_encstr_81CC0586854EC1"].timeout = level.setuptrain;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88570CF010DD1A4F086A07363072", ::setupweaponattachmentoverrides);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A52F0C5090A2BA24C361597223AB", ::setupx1timelimit);
  level.dialog_wait_ready_civ = 0;
  _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::stoppingpower_givehcrdata();
  level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DF8();
  level thread deletecircle();
}

tracegroundheightexfil() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA0D121B67DD3734B118102DA7B0A758086DD74F"] = "_encstr_BA0D121B67DD3734B118102DA7B0A758086DD74F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8CA20FE398D8408D1AE0483B3308586542"] = "_encstr_8CA20FE398D8408D1AE0483B3308586542";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4BA120D58E4387DCCC9B42B373263CBFA5D372B"] = "_encstr_B4BA120D58E4387DCCC9B42B373263CBFA5D372B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BA2D0D1A0B9C83EB3A2DADB27BBA1D"] = "_encstr_BA2D0D1A0B9C83EB3A2DADB27BBA1D";
}

setupweaponattachmentoverrides(var_0) {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_B4BA120D58E4387DCCC9B42B373263CBFA5D372B", var_0.team, 1);
}

setupx1timelimit(var_0) {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback(level.uavsettings["_encstr_81CC0586854EC1"].votimeout, var_0.team, 1);
}

deletecircle() {
  wait 5.0;
  scripts\mp\utility\sound::besttime("_encstr_B618173193AF59EC2BE63AFA3785472B36D8D2A359EBCDCC3C");
}

_id_12A17(var_0, var_1) {
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1);

  for(var_3 = []; isDefined(var_2["_encstr_850E077B0BF30318B9"]) && var_3.size < 25; var_2 = scripts\engine\trace::ray_trace(var_0, var_1, var_3))
    var_3[var_3.size] = var_2["_encstr_850E077B0BF30318B9"];

  return var_2;
}

tank_arrive_and_fire() {
  var_0 = getDvar("_encstr_8B511E37C627F5E6B04756D8362D8E59BEAC3CB1B15DDC5ACE2BD7A5A3B2ADB9", "_encstr_92605C50635D97A08307E85416DBA94D8759B0E8BBB6DD79BF246CDDE007D101AF52A028739D7D93B347F84DFF67D8F9554B08485A66A74E7B717E47947B63B17D128099527FE56037960D28B18BAB73657AB0C80BD3013B3B9905B68783");
  var_1 = getDvar("_encstr_9A322A9BAA021FCB2FC40589A47753232152D038F21BBF405BFDAF73946FB88F574BF0283936C119E3E31576", "_encstr_83E509E542469D0ABC9B9B");
  var_2 = getDvar("_encstr_970428C7CF3EF173F07BB7FD5098BCEAAF6B730F9BE6DA4E08E6ACC369C0CF326EE7DB8701034219E84B", "_encstr_9B790AE3F98367C178CAEEF6");
  var_0 = strtok(var_0, "_encstr_964C0249");
  var_1 = strtok(var_1, "_encstr_964C0249");
  var_2 = strtok(var_2, "_encstr_964C0249");
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = spawnStruct();
    var_5.type = var_0[var_4];
    var_5.ml_p2_fail_start = int(var_1[var_4]);
    var_5.modeiskillstreakallowed = int(var_2[var_4]);
    var_5.ml_p3_to_safehouse_transition = 0;
    var_3[var_5.type] = var_5;
  }

  level._id_12EAA = var_3;
}

minigun_manager(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_4 = (0, 0, 500);
  var_5 = _id_12A17(var_1 + var_4, var_1 - var_4);
  var_6 = var_5["_encstr_BD260953AA97E3F014279D"] + (0, 0, 23);
  var_7 = var_2 + (0, -90, 110);
  lootstruct_offsets(var_0, var_3, var_6);
  var_8 = _id_135C6(var_0, var_6, var_7);
  var_8 radiusdamage(var_6, 500, 1000, 50);
  var_8 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_B6A908D84EB0E6435632");
  var_8 playSound("_encstr_A608124A23C0BF2ED83FFBF17159F40FFFF9D2B3");
  playFX(scripts\engine\utility::getfx("_encstr_B19D17DCC2E85963D8A5D1597D1B168D342BAFA55B1CB08D8E"), var_6, anglesToForward((0, var_2[1], 0)), (0, 0, 1));

  if(var_0 != "_encstr_8BBA05185F8B99")
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_BA0D121B67DD3734B118102DA7B0A758086DD74F", var_0, 1);

  _id_11A93(var_0, var_8);
  level thread _id_14482(var_8, ::_id_11FF4);

  if(isDefined(level.modeupdateloadoutclass))
    level.modeupdateloadoutclass = scripts\engine\utility::array_add(level.modeupdateloadoutclass, var_8);
}

lootstruct_offsets(var_0, var_1, var_2) {
  var_3 = var_1 - var_2;
  var_4 = anglestoup(vectortoangles(var_3));
  var_5 = vectortoangles(var_4);
  var_6 = _id_13553(var_1, var_5);
  var_6 endon("_encstr_AD75063D571AE108");
  var_6 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_811C08A1AEE9732B23C4");
  var_7 = distance(var_1, var_2);
  var_8 = var_7 / 3000;
  var_9 = var_8 * 0.75;
  var_6 moveTo(var_2, var_8, var_9, 0.05);
  var_6 playLoopSound("_encstr_81FA0E62E5F9DA8F35FE2B32A398F352");
  level thread _id_12EA5(var_6);
  level thread _id_12EA8(var_6);
  wait(var_8);
  var_6 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_878807108A42A309BB");
  _id_12EA9(var_2);
  var_6 stoploopsound();
  var_6 notify("_encstr_AC7B1DE8A31F63D753066DFD5DFAE3AB7D77C8887FAFB84979EAE5F1B6D233");
  var_6 notify("_encstr_876E1DBF8BAA67991B36FBD19DFCD09DE2BF3D2B5392A648258101CBC3CB90");
  var_6 delete();
}

_id_12EA9(var_0) {
  var_1 = scripts\engine\trace::sphere_trace_get_all_results(var_0, var_0, 60);

  foreach(var_3 in var_1) {
    var_4 = var_3["_encstr_850E077B0BF30318B9"];
    _id_13DFD(var_4, var_0);
  }
}

_id_12EA8(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_876E1DBF8BAA67991B36FBD19DFCD09DE2BF3D2B5392A648258101CBC3CB90");

  for(;;) {
    var_0 waittill("_encstr_8D7D06302FE5E159", var_1);
    _id_13DFD(var_1, var_0.origin);
  }
}

_id_13DFD(var_0, var_1) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  if(!var_0 scripts\common\vehicle::isvehicle() && !isDefined(var_0.classname)) {
    return;
  }
  if(var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
    var_0 dodamage(10 * var_0.health, var_1);
}

_id_13553(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_2.angles = var_1;
  var_2 setModel("_encstr_B6D624D31A6F96732910CBD19D31239DABC80AB9A8E3CEBF2365B2D120DBE364C9F98293C059");
  return var_2;
}

_id_135C6(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3.angles = var_2;
  var_3 setModel("_encstr_8183273BF2876E8BC188537935A94BF533709241305BA6D79B8D5A6958737BFC61912A7B683111623B");
  var_3.id = "_encstr_BAE50DE60E739BA638C72068AF47B9";
  var_3.use_vehicle_turret = 1;
  var_3.team = var_0;

  if(var_0 != "_encstr_8BBA05185F8B99") {
    var_4 = scripts\mp\utility\teams::getfriendlyplayers(var_0);

    if(var_4.size > 0)
      var_3 setotherent(var_4[0]);
  }

  return var_3;
}

_id_12EA5(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AC7B1DE8A31F63D753066DFD5DFAE3AB7D77C8887FAFB84979EAE5F1B6D233");
  var_1 = -10000;

  for(;;) {
    var_2 = (var_0.origin[0], var_0.origin[1], var_1);
    var_3 = physicstrace(var_0.origin, var_2);
    playrumbleonposition("_encstr_979C1766739851F219E3EBFFAF3EAB9DF0589F61A8B8E10BEB", var_0.origin);
    playrumbleonposition("_encstr_979C1766739851F219E3EBFFAF3EAB9DF0589F61A8B8E10BEB", var_3);
    wait 0.7;
  }
}

_id_11A93(var_0, var_1) {
  var_1 makeusable();

  if(var_0 != "_encstr_8BBA05185F8B99") {
    foreach(var_3 in scripts\mp\utility\teams::getfriendlyplayers(var_0)) {
      var_1 setotherent(var_3);
      break;
    }

    var_1 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_930B07BB1B6B3854FF");
  } else
    var_1 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_A12410F0CAE3D3CB9F4FA5244DFB1297CD32");

  var_1 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_1 sethintonobstruction("_encstr_BD1805CB69C063");
  var_1 sethinttag("_encstr_BA300854E318F1FF9699");
  var_1 sethintdisplayrange(128);
  var_1 sethintdisplayfov(180);
  var_1 setuserange(128);
  var_1 setusefov(180);
  var_1 setusepriority(-1);
  var_1 setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  var_1 setHintString(&"_encstr_8E22284D288A54C413252A51FA12559351E5A9A0A82A263194452ABE0D0A1A90A2FAAA358AAF0929C9A8");
  var_1.userate = 1;
  var_1.usetime = 0;
}

_id_11A92(var_0) {
  var_0 notify("_encstr_86F019DCC247561BC65AE8CAEB6CC2C634ACAFEAE65DCD16133695");
  var_0 makeunusable();
  var_0 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_8882099673858D1D4B6756");
}

_id_14482(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_86F019DCC247561BC65AE8CAEB6CC2C634ACAFEAE65DCD16133695");

  for(;;) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_3 = _id_13E08(var_0, var_2);

    if(var_3) {
      if(isDefined(var_1))
        thread[[var_1]](var_0, var_2);
    }
  }
}

_id_13E08(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.inuse = 0;
  var_0.playerusing = undefined;
  var_0.curprogress = 0;
  var_2 = 0;

  while(isDefined(var_1) && var_1 useButtonPressed()) {
    if(var_0.usetime <= 0)
      return 1;

    var_0.curprogress = var_0.curprogress + level.framedurationseconds * var_0.userate;
    var_1 scripts\mp\gameobjects::updateuiprogress(var_0, 1);

    if(var_0.curprogress >= var_0.usetime) {
      var_2 = 1;
      break;
    }

    waitframe();
  }

  var_1 scripts\mp\gameobjects::updateuiprogress(var_0, 0);
  return var_2;
}

_id_11FF4(var_0, var_1) {
  var_2 = _id_135C7(var_0);
  _id_11A92(var_0);
  var_0 setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_ADB405071B8AE8");

  if(isDefined(var_1)) {
    var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_12005();
    var_3 = [];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_3[var_3.size] = "_encstr_B2C5059803B560" + var_4;
      var_3[var_3.size] = var_2[var_4].type;
    }

    var_3[var_3.size] = "_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1";
    var_3[var_3.size] = scripts\mp\matchdata::gettimefrommatchstart(gettime());
    var_3[var_3.size] = "_encstr_A33506D8AA82DF6A";
    var_3[var_3.size] = var_0.origin[0];
    var_3[var_3.size] = "_encstr_9335067B90C6FFD8";
    var_3[var_3.size] = var_0.origin[1];
    var_3[var_3.size] = "_encstr_9135061CED9BAF9E";
    var_3[var_3.size] = var_0.origin[2];
    var_1 dlog_recordplayerevent("_encstr_BDF3223AF0C81F51A07DFDCE414926037889D3127B1347922891F5F725F02EAF14E14B1B", var_3);
  }
}

_id_135C7(var_0) {
  var_1 = random_loot_override(var_0);

  if(!isDefined(var_1) || var_1.size <= 0)
    return [];

  var_2 = spawnStruct();
  var_3 = anglesToForward((0, var_0.angles[1] - -90, 0));
  var_2.origin = var_0.origin + var_3 * 45;
  var_2.angles = (0, var_0.angles[1], 0);
  var_2.itemsdropped = 0;
  var_4 = var_2 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_1, 1, undefined);
  _id_13C36(var_4);
  return var_4;
}

random_loot_override(var_0) {
  var_1 = verifybunkercode("_encstr_BE6D106EB0A3CAC66396E8CAFA360BD80DB2", 0);

  if(!isDefined(var_1))
    var_1 = [];

  var_2 = gettruegroundposition();

  if(isDefined(var_2))
    var_1[var_1.size] = var_2;

  return var_1;
}

gettruegroundposition() {
  var_0 = 0;

  foreach(var_2 in level._id_12EAA) {
    if(var_2.ml_p3_to_safehouse_transition >= var_2.modeiskillstreakallowed) {
      continue;
    }
    var_0 = var_0 + var_2.ml_p2_fail_start;
  }

  if(var_0 <= 0)
    return undefined;

  var_4 = randomint(var_0);
  var_5 = 0;

  foreach(var_2 in level._id_12EAA) {
    if(var_2.ml_p3_to_safehouse_transition >= var_2.modeiskillstreakallowed) {
      continue;
    }
    var_5 = var_5 + var_2.ml_p2_fail_start;

    if(var_4 < var_5)
      return var_2.type;
  }

  return undefined;
}

_id_13C36(var_0) {
  foreach(var_2 in var_0) {
    var_3 = level._id_12EAA[var_2.type];

    if(!isDefined(var_3)) {
      continue;
    }
    var_3.ml_p3_to_safehouse_transition++;
  }
}

tomastrike_watchgameend() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.player_get_carepackage_precision_airstrike = [];
  level.player_gassed_effects = [];
  level._id_13641 = [];
  level.modeupdateloadoutclass = [];

  switch (level.mapname) {
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      level thread tire_repair_start_air_stop_sfx();
      break;
    case "_encstr_8CD508CA98A70FAFC01D":
      level thread tire_repair_start_exit_foley_sfx();
      break;
  }

  level thread topteamsever();
  level thread timevotrigger();
  level thread _id_14015();
}

battle_tracks_playbattletrackswhenstandingonvehicle(var_0, var_1, var_2) {
  if(!isDefined(level.player_get_carepackage_precision_airstrike[var_0]))
    level.player_get_carepackage_precision_airstrike[var_0] = [];

  var_3 = level.player_get_carepackage_precision_airstrike[var_0].size;

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_4 = spawnStruct();
  var_4.origin = var_1;
  var_4.angles = var_2;
  level.player_get_carepackage_precision_airstrike[var_0][var_3] = var_4;
}

battle_tracks_playbattletrackstoplayer(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.crashorigin = var_1;
  var_3.spawnorigin = var_0;
  var_3.infectsetradaronnumsurvivors = var_2;
  level.player_gassed_effects[level.player_gassed_effects.size] = var_3;
}

tire_repair_start_exit_foley_sfx() {
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A60108C05863AB184BF8", (-23095, 15097, -6));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A60108C05863AB184BF8", (-14014, 20695, -390));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A60108C05863AB184BF8", (-8879, 17588, -262));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_883009BD28232B4B688B98", (24481, -17510, -150));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_883009BD28232B4B688B98", (28377, -15532, -180));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_883009BD28232B4B688B98", (30944, -9443, -366));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_B4840D0763993ADCA8D3C816A9E015", (3026, 51369, 1094));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_B4840D0763993ADCA8D3C816A9E015", (2222, 46081, 1466));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_B4840D0763993ADCA8D3C816A9E015", (7569, 47423, 1079));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A19407CB0D1807F441", (-31645, 45925, 3131));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A19407CB0D1807F441", (-18635, 62607, 1968));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A19407CB0D1807F441", (-22281, 53130, 2690));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_AC0309234BF48BE08190F9", (33699, 38645, 770));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_AC0309234BF48BE08190F9", (37949, 42069, 2059));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_AC0309234BF48BE08190F9", (28480, 38949, 765));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_91B606B0E49C0B5E", (23659, 24841, 1358));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_91B606B0E49C0B5E", (29272, 18345, 1210));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A77808BB284B9F27D3C1", (24237, 5066, -557));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A77808BB284B9F27D3C1", (36604, 6026, -462));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A77808BB284B9F27D3C1", (28682, 212, -526));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_B19B09E057A26011D22585", (51891, -17870, -332));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_B19B09E057A26011D22585", (46236, -13936, -17));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_B19B09E057A26011D22585", (43967, -4737, 337));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A6690DF03B72BB3BE3E136B5F76B82", (-14036, 9027, 226));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A6690DF03B72BB3BE3E136B5F76B82", (-14812, 4964, -342));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A6690DF03B72BB3BE3E136B5F76B82", (-7048, 7646, -269));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A12309057F2275CBB14A51", (-25772, -9352, 9));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A12309057F2275CBB14A51", (-28848, -18447, -176));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_AFD40D24BE99C11BC3956F29C2B020", (-15159, -14136, 258));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_AFD40D24BE99C11BC3956F29C2B020", (-8952, -15887, -310));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_810D059BE07D8B", (38675, -27620, -512));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_810D059BE07D8B", (33792, -24817, -508));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_8E4107C6EA5B135939", (50312, 2539, 78));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_8E4107C6EA5B135939", (53346, 5901, 88));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A9E20F22E87985579BB6E7EDC5A0E74F83", (-4195, -29916, 334));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A9E20F22E87985579BB6E7EDC5A0E74F83", (-6128, -21873, -226));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_A6690DF03B72BB3BE3E136B5F76B82", (-28088, 9552, -262));
  battle_tracks_playbattletrackstoplayer((-42206, 30546, 15594), (-21206, 55546, 3258), (0, 63, 0));
  battle_tracks_playbattletrackstoplayer((-7587, 73408, 15594), (-28587, 48408, 2621), (0, 231, 0));
  battle_tracks_playbattletrackstoplayer((5434, 42408, 15594), (-15434, 62784, 1890), (0, 133, 0));
  battle_tracks_playbattletrackstoplayer((1358, 45734, 15594), (-19642, 20734, -390), (0, 238, 0));
  battle_tracks_playbattletrackstoplayer((-38950, -9330, 15594), (-17950, 15670, -267), (0, 57, 0));
  battle_tracks_playbattletrackstoplayer((15000, 40711, 15594), (-6147, 20711, -298), (0, 218, 0));
  battle_tracks_playbattletrackstoplayer((21050, 72623, 15594), (50, 47623, 1786), (0, 240, 0));
  battle_tracks_playbattletrackstoplayer((27637, 73473, 15594), (6637, 48473, 1082), (0, 226, 0));
  battle_tracks_playbattletrackstoplayer((25637, 73557, 15594), (3434, 53557, 1082), (0, 234, 0));
  battle_tracks_playbattletrackstoplayer((-1855, -41818, 15594), (22914, -16594, -158), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((48000, 15912, 15594), (26741, -5912, -398), (0, 233, 0));
  battle_tracks_playbattletrackstoplayer((-3944, -4366, 15594), (27516, -14650, -206), (0, 337, 0));
  battle_tracks_playbattletrackstoplayer((55974, 63705, 15594), (34974, 38705, 767), (0, 227, 0));
  battle_tracks_playbattletrackstoplayer((16974, 21705, 15594), (36216, 41247, 1382), (0, 55, 0));
  battle_tracks_playbattletrackstoplayer((9008, 10518, 15594), (30008, 35518, 639), (0, 54, 0));
  battle_tracks_playbattletrackstoplayer((710, -3670, 15594), (21710, 22670, 1658), (0, 45, 0));
  battle_tracks_playbattletrackstoplayer((51763, 46740, 15594), (30763, 21740, 728), (0, 230, 0));
  battle_tracks_playbattletrackstoplayer((39099, 28563, 15594), (28099, 3563, -520), (0, 246, 0));
  battle_tracks_playbattletrackstoplayer((10099, -14500, 15594), (33112, 6457, -539), (0, 42, 0));
  battle_tracks_playbattletrackstoplayer((13642, -25493, 15594), (34642, -493, -672), (0, 60, 0));
  battle_tracks_playbattletrackstoplayer((73223, 10097, 15594), (52223, -15097, -336), (0, 229, 0));
  battle_tracks_playbattletrackstoplayer((63223, 8097, 15594), (44410, -13675, -49), (0, 228, 0));
  battle_tracks_playbattletrackstoplayer((64356, 13848, 15594), (43356, -12848, -51), (0, 241, 0));
  battle_tracks_playbattletrackstoplayer((-28813, -21412, 15594), (-7813, 3588, -296), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((10603, 36659, 15594), (-11603, 11659, -249), (0, 230, 0));
  battle_tracks_playbattletrackstoplayer((4603, 26659, 15594), (-17047, 8088, -263), (0, 219, 0));
  battle_tracks_playbattletrackstoplayer((-49541, -35754, 15594), (-28541, -10754, -70), (0, 48, 0));
  battle_tracks_playbattletrackstoplayer((-2089, 12133, 15594), (-23089, -12867, -135), (0, 220, 0));
  battle_tracks_playbattletrackstoplayer((-34198, -43327, 15594), (-13198, -18327, -310), (0, 54, 0));
  battle_tracks_playbattletrackstoplayer((-26949, -33422, 15594), (-5949, -8422, -359), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((9586, -52505, 15594), (30586, -27505, -508), (0, 44, 0));
  battle_tracks_playbattletrackstoplayer((-15193, -45559, 15594), (36193, -20559, -508), (0, 25, 0));
  battle_tracks_playbattletrackstoplayer((30115, -26887, 15594), (51115, -1887, 156), (0, 50, 0));
  battle_tracks_playbattletrackstoplayer((69480, 32243, 15594), (48480, 7243, 35), (0, 237, 0));
  battle_tracks_playbattletrackstoplayer((-26000, -47000, 15594), (-6755, -29018, 90), (0, 49, 0));
  battle_tracks_playbattletrackstoplayer((-32000, 0, 15594), (-11306, -20228, -304), (0, 314, 0));
  battle_tracks_playbattletrackstoplayer((-43000, -12000, 15594), (-23028, 8447, -260), (0, 47, 0));
  battle_tracks_playbattletrackstoplayer((25000, -15642, 15594), (45195, 4358, -42), (0, 38, 0));
  battle_tracks_playbattletrackstoplayer((22000, -25000, 15594), (42167, -6352, 279), (0, 20, 0));
  battle_tracks_playbattletrackstoplayer((-47000, -39000, 15594), (-27520, -19542, -200), (0, 50, 0));
}

tire_repair_start_air_stop_sfx() {
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_82EF0594EDAE31", (5100, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_82EF0594EDAE31", (5300, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_82EF0594EDAE31", (5500, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_82EF0594EDAE31", (5700, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackswhenstandingonvehicle("_encstr_82EF0594EDAE31", (5900, -583, 58), (0, randomintrange(0, 360), 0));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5100, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5300, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5500, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5700, -450, 58));
  battle_tracks_playbattletrackstoplayer((-10000, -376, 8178), (5900, -450, 58));
}

topteamsever() {
  var_0 = getdvarint("_encstr_91CF1CB346F5F97B783D15906973CB5FB130E025977752256B39189F2EE5", 1);

  if(var_0 <= 0) {
    return;
  }
  if(!isDefined(level.player_get_carepackage_precision_airstrike)) {
    return;
  }
  var_1 = getdvarint("_encstr_AFA91F72C138F7932F71073B59C32B05A9C86CBD78F9842AFD732BFF9DF8D27D60", 15);

  if(var_1 <= 0) {
    return;
  }
  var_2 = getarraykeys(level.player_get_carepackage_precision_airstrike);
  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_4 < var_1 && var_5 < var_2.size; var_5++) {
    var_6 = var_2[var_5 % var_2.size];
    var_7 = int(min(level.player_get_carepackage_precision_airstrike[var_6].size, var_0));

    if(var_7 <= 0) {
      continue;
    }
    var_8 = randomintrange(0, var_7 + 1);
    var_9 = int(min(var_1 - var_4, var_8));
    var_3[var_6] = var_9;
    var_4 = var_4 + var_9;
  }

  for(var_5 = 0; var_4 < var_1 && var_5 < var_2.size; var_5++) {
    var_6 = var_2[var_5 % var_2.size];

    if(var_3[var_6] < level.player_get_carepackage_precision_airstrike[var_6].size) {
      var_9 = int(min(var_1 - var_4, level.player_get_carepackage_precision_airstrike[var_6].size - var_3[var_6]));
      var_3[var_6] = var_3[var_6] + var_9;
      var_4 = var_4 + var_9;
    }
  }

  foreach(var_14, var_11 in var_3) {
    var_12 = level.player_get_carepackage_precision_airstrike[var_14];

    if(!isarray(var_12)) {
      continue;
    }
    var_13 = scripts\engine\utility::array_randomize(var_12);

    for(var_5 = 0; var_5 < var_13.size && var_5 < var_0; var_5++)
      _id_13696(var_13[var_5].origin, var_13[var_5].angles, 1);
  }
}

timevotrigger() {
  var_0 = getdvarint("_encstr_91CF1CB346F5F97B783D15906973CB5FB130E025977752256B39189F2EE5", 1);

  if(var_0 <= 0) {
    return;
  }
  var_1 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_9A6E17E33F031F9D5930333A998114FB58886B7C476B776575"];

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1) {
    var_4 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_3.target];

    if(!isarray(var_4)) {
      continue;
    }
    var_4 = scripts\engine\utility::array_randomize(var_4);

    for(var_5 = 0; var_5 < var_4.size && var_5 < var_0; var_5++) {
      var_6 = var_4[var_5];

      if(!isDefined(var_6)) {
        continue;
      }
      _id_13696(var_6.origin, var_6.angles);
    }
  }
}

_id_13696(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  var_3 = (0, 0, 500);
  var_4 = scripts\engine\trace::ray_trace(var_0 + var_3, var_0 - var_3);
  var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_4["_encstr_BD260953AA97E3F014279D"], 0, int(128), int(72));
  var_6 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_5);
  var_6 scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
  var_6 scripts\mp\gameobjects::cancontestclaim(1);
  var_6 scripts\mp\gameobjects::setusetime(10);
  var_6.usecondition = ::mark_loot;
  var_6.onbeginuse = ::mark_danger_timeout;
  var_6.onenduse = ::domflag_onenduse;
  var_6.onuse = ::domflag_onuse;
  var_6.onuseupdate = ::domflag_onuseupdate;
  var_6.lockupdatingicons = 1;
  var_6.getrandompointincirclewithindistance = 1;
  var_6._id_12F83 = var_2;
  getbnetigrbattlepassxpmultiplier(var_6.objidnum, 450, 500);
  objective_setshowoncompass(var_6.objidnum, 0);
  objective_state(var_6.objidnum, "_encstr_A2BE0AB4DC3BB46E5A981BAC");
  objective_icon(var_6.objidnum, "_encstr_ADA127404FB74801294EF668E5A24930F53BD899F723C0C5F1B3EF89FC6AA7BE5793A8F037EC58BD7A");
  var_6.flagmodel setModel("_encstr_8889268393D7EE4FEBCD2C47F5632DDC6DD77B3135AC363A2D6795D7DC858E59B136B4A3B2FA604C");
  var_6.flagmodel.angles = (var_4["_encstr_820E07FAE8780B3A4C"][0], var_1[1], var_4["_encstr_820E07FAE8780B3A4C"][2]);
  var_6.flagmodel playLoopSound("_encstr_B6091C8AABB96AAAB8284BEA4BDBDB8FFF1A05678E3B5C6BC5F7DB30883F");
  level._id_13641[level._id_13641.size] = var_6;
}

_id_14015() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(getdvarint("_encstr_A14A21334A8BE5305521A9F36F3D5038AF01089962272E282C16838F686248F00F6A81", 0) == 0) {
    return;
  }
  var_0 = 1;
  var_1 = 1;
  var_2 = 25;
  var_3 = 5000;
  var_4 = var_3 * var_3;

  for(;;) {
    if(isDefined(level.players) && level.players.size > 0 && isDefined(level._id_13641) && level._id_13641.size > 0) {
      for(var_5 = 0; var_5 < level._id_13641.size; var_5++) {
        var_6 = level._id_13641[var_5];

        if(istrue(var_6.trigger.trigger_off)) {
          continue;
        }
        objective_removeallfrommask(var_6.objidnum);
        var_7 = level.players;

        for(var_8 = 0; var_8 < var_7.size; var_8++) {
          var_9 = var_7[var_8];

          if(isDefined(var_9)) {
            var_10 = distance2dsquared(var_9.origin, var_6.flagmodel.origin);

            if(var_10 <= var_4)
              objective_addclienttomask(var_6.objidnum, var_9);
          }

          if(var_8 % var_2 == 0)
            waitframe();
        }

        if(istrue(var_6.trigger.trigger_off)) {
          continue;
        }
        objective_showtoplayersinmask(var_6.objidnum);

        if(var_5 % var_1 == 0)
          waitframe();
      }
    }

    wait(var_0);
  }
}

mark_loot(var_0) {
  return 1;
}

mark_danger_timeout(var_0) {
  self.flagmodel playLoopSound("_encstr_933913984EFA9B0BE8AF5738C65A9B6DEBD87BB738");
}

domflag_onuseupdate(var_0, var_1, var_2, var_3) {
  if(var_1 > 0.05 && var_2 && !istrue(self.didstatusnotify))
    self.didstatusnotify = 1;
}

domflag_onuse(var_0) {
  self.flagmodel endon("_encstr_AD75063D571AE108");
  thread mark_phone_guy_once_all_spawned();
  var_1 = "_encstr_8BBA05185F8B99";

  if(isDefined(var_0.team))
    var_1 = var_0.team;

  var_2 = ["_encstr_A996165D01DFC1CF2D4BB01862C5739913B3EB5674976BD1", scripts\mp\matchdata::gettimefrommatchstart(gettime()), "_encstr_A33506D8AA82DF6A", self.flagmodel.origin[0], "_encstr_9335067B90C6FFD8", self.flagmodel.origin[1], "_encstr_9135061CED9BAF9E", self.flagmodel.origin[2]];
  var_0 dlog_recordplayerevent("_encstr_9BC51EECB1681FA9B3C03A82F8EFDEF3C6A6717440506F2D7771430A58C39267", var_2);
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_8CA20FE398D8408D1AE0483B3308586542", var_1, 1);
  self.flagmodel playSound("_encstr_BD3716586B99B7798B3FDD571427404F7182B8A002AFCF93");
  self.flagmodel setscriptablepartstate("_encstr_A59306224004FA23", "_encstr_ADB405071B8AE8");
  scripts\mp\gameobjects::disableobject();

  foreach(var_4 in scripts\mp\utility\teams::getfriendlyplayers(var_1)) {
    if(!var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag() && var_4 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(25);
      var_4 thread scripts\mp\hud_message::showsplash("_encstr_B4721E45F2A9E0C7A3AA4890E23786383B7DD12181CBE8AF3F6201B8EA8730D0");
    }
  }

  while(self.flagmodel getscriptablepartstate("_encstr_A59306224004FA23") != "_encstr_B1CF098D5838A3D5C95623")
    waitframe();

  wait(randomfloatrange(1, 2));

  if(!self._id_12F83)
    level thread modifyakimboburstrenettidamagehack(var_1, self.curorigin);
  else
    level thread mlp2_front_truck(var_1, self.curorigin);
}

domflag_onenduse(var_0, var_1, var_2) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
  self.flagmodel stoploopsound();

  if(!var_2)
    self.flagmodel playLoopSound("_encstr_B6091C8AABB96AAAB8284BEA4BDBDB8FFF1A05678E3B5C6BC5F7DB30883F");
  else if(isDefined(var_1))
    var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_12083();
}

mark_phone_guy_once_all_spawned() {
  self endon("_encstr_A2BD0839CAB6B7CE5919");
  waittillframeend;
  domflagupdateicons();
}

domflagupdateicons() {
  objective_showtoplayersinmask(self.objidnum);
  objective_removeallfrommask(self.objidnum);
}

mlp2_front_truck(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 7500;

  var_3 = level.player_gassed_effects;
  var_4 = [];
  var_5 = var_2 * var_2;

  foreach(var_7 in var_3) {
    if(isDefined(var_7.used)) {
      continue;
    }
    if(distance2dsquared(var_1, var_7.crashorigin) > var_5) {
      continue;
    }
    var_4[var_4.size] = var_7;
  }

  if(var_4.size <= 0) {
    return;
  }
  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_9 = [];

  foreach(var_11 in var_4) {
    if(!isDefined(level.br_circle.dangercircleent) || _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::ispointincurrentsafecircle(var_11.crashorigin))
      var_9[var_9.size] = var_11;
  }

  if(var_9.size > 0)
    var_4 = var_9;

  var_7 = var_4[0];
  var_7.used = 1;
  level minigun_manager(var_0, var_7.crashorigin, var_7.infectsetradaronnumsurvivors, var_7.spawnorigin);
}

modifyakimboburstrenettidamagehack(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 7500;

  var_3 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"]["_encstr_8BFA18EB0908D790F4801B3D61F4207938D8B1A8D77A03BB15CD"];

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = [];
  var_5 = var_2 * var_2;

  foreach(var_7 in var_3) {
    if(isDefined(var_7.used)) {
      continue;
    }
    if(distance2dsquared(var_1, var_7.origin) > var_5) {
      continue;
    }
    var_4[var_4.size] = var_7;
  }

  if(var_4.size <= 0) {
    return;
  }
  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_7 = var_4[0];
  var_7.used = 1;
  var_9 = level.struct_class_names["_encstr_B2CE0BA1D0FB19FDC54613D9BF"][var_7.target];

  if(!isDefined(var_9) || !isDefined(var_9[0])) {
    return;
  }
  level minigun_manager(var_0, var_7.origin, var_7.angles, var_9[0].origin);
}

dangercircletick(var_0, var_1) {
  if(getdvarint("_encstr_84911D53788589CF98FF2A2C85C6AB8AB760FA9BE061BD37F3D50F50A5C83B", 0) == 0 && !istrue(level.delete_corpses)) {
    return;
  }
  var_2 = var_1 + 3000;
  var_3 = var_2 * var_2;

  if(isDefined(level._id_13641)) {
    foreach(var_5 in level._id_13641) {
      if(distance2dsquared(var_5.curorigin, var_0) > var_3)
        loadoutdefaultcost(var_5);
    }
  }

  var_7 = var_1 + 3000;
  var_8 = var_7 * var_7;

  if(isDefined(level.modeupdateloadoutclass)) {
    for(var_9 = level.modeupdateloadoutclass.size - 1; var_9 >= 0; var_9--) {
      var_10 = level.modeupdateloadoutclass[var_9];

      if(distance2dsquared(var_10.origin, var_0) > var_8) {
        var_10 delete();
        level.modeupdateloadoutclass = scripts\engine\utility::array_remove_index(level.modeupdateloadoutclass, var_9, 0);
      }
    }
  }
}

loadoutdefaultcost(var_0) {
  if(!isDefined(var_0) || istrue(var_0.disabled)) {
    return;
  }
  var_0.trigger triggerdisable();
  var_0.disabled = 1;
  var_0.flagmodel stoploopsound();
  var_0 scripts\mp\gameobjects::disableobject();
}