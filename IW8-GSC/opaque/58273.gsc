/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58273.gsc
***********************************************/

stopusingbomb() {
  level._effect["_encstr_84AA119F50535363CD9BEC67E8B97B0919A85B"] = loadfx("_encstr_935D2DB39987CB2DDDC1AFAD0ECBADD2B136B9A39C590BD65E3BCCC37DB08903EB1D9C166CACE4F5B99583B8CE99C3");
  level._effect["_encstr_97A3113636579BA39527EBB738D14BDA3D5691"] = loadfx("_encstr_A30832D35BA0705C90DFB0E1689EA2D23DA39F1D6B3569ACB81311F1FE27C0F0E39B9A20569B1AF77B1BA9CBEECB08A11646BA4A");
  level._effect["_encstr_ACF90D13B227D87BF09BA0389ECD90"] = loadfx("_encstr_9911363B66E1F2A5BBE0FAB5C1E56DA51BB19BD1E4ACC25BBCCE990FFAD8DB7347B0B4B9BE0BB189CC60AF26034DADB6F5D2ADE071CE331E");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B4EE153765A669F9F0211A639E6B0963FEEB9B8FB76FE7"] = "_encstr_B4EE153765A669F9F0211A639E6B0963FEEB9B8FB76FE7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A9EE1557B68B1629DCF7FDD9F7DD40A663E03C0997A5DA"] = "_encstr_A9EE1557B68B1629DCF7FDD9F7DD40A663E03C0997A5DA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6EE15F2E99ED7F6D073B2BC6FB0BC3F4620DA7AD6D6A2"] = "_encstr_B6EE15F2E99ED7F6D073B2BC6FB0BC3F4620DA7AD6D6A2";
  level.create_agent_definition = 0;
  level.create_ai_type_override = (0, 0, 0);
  level._id_13B46 = getdvarfloat("_encstr_B1062C4A267D69D4A838273F6026B5F2015092461D93031B96087B0B9098751BF7D71A7D7D354A6F5B18272FD853", 3000);
  level._id_13B47 = getdvarfloat("_encstr_AD482C371B39EB1D864ECAB0D1D75B96DCEBE48546D25DE6FADC3A4E2DDA2BCDF5854EEDAE7391F5C11B2CE52B93", 1500);
  level._id_13B45 = getdvarint("_encstr_850C21573F931818A85A61F9C3B7D8C30BABF7DFEFAA5879E8F78B362A64B8F3D21747", 10);
  level._id_13B48 = getdvarfloat("_encstr_825932CD1BC97DA31AC92BB0A3EB47434B1B5BE6B2E6CDEB270B8C5A5DB9D7B9D1C9965B2BB97DB04EDED5738CEBE0D80B97AC39", 400);
  level._id_13B43 = getdvarfloat("_encstr_8C3B217EAB032639CCFBC8E0B329C1B9935183E002E70B77F792A8093B3BA570D7FD0E", 0.15);
  level._id_13B44 = getdvarint("_encstr_83111C6EC693FA3A1A275616E8AF59F00736BD6ED2F6B97D46B05B0B9D2B", 10);
  var_0 = scripts\cp_mp\utility\game_utility::getmapname();

  switch (var_0) {
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
      _id_1322A();
      break;
    case "_encstr_B1D508B607F591B7CD33":
    case "_encstr_8CD508CA98A70FAFC01D":
      _id_1322B();
      break;
    default:
      _id_1322B();
      break;
  }
}

_id_1322B() {
  level.create_exfil_animstruct = [];
  level.create_exfil_animstruct[0] = spawnStruct();
  level.create_exfil_animstruct[0].locname = "_encstr_8BC6090EF0E08C337D68F3";
  level.create_exfil_animstruct[0].refname = "_encstr_AD7609B6149AE9EE747FE8";
  level.create_exfil_animstruct[0]._id_119A7 = (39696, -42616, -556);
  level.create_exfil_animstruct[0]._id_119A8 = 4000;
  level.create_exfil_animstruct[1] = spawnStruct();
  level.create_exfil_animstruct[1].locname = "_encstr_9B220624456A5747";
  level.create_exfil_animstruct[1].refname = "_encstr_B2EE0AF2285926E79E550903";
  level.create_exfil_animstruct[1]._id_119A7 = (51072, -39208, 1351);
  level.create_exfil_animstruct[1]._id_119A8 = 4000;
  level.create_exfil_animstruct[2] = spawnStruct();
  level.create_exfil_animstruct[2].locname = "_encstr_883E0979CAE2A1689B3161";
  level.create_exfil_animstruct[2].refname = "_encstr_B2780D2238237849794229F0900687";
  level.create_exfil_animstruct[2]._id_119A7 = (9072, -10984, -280);
  level.create_exfil_animstruct[2]._id_119A8 = 3000;
  level.create_exfil_animstruct[3] = spawnStruct();
  level.create_exfil_animstruct[3].locname = "_encstr_A77808B9284B9F27D3C1";
  level.create_exfil_animstruct[3].refname = "_encstr_88F40C37D10BC8D2D5B67D47581B";
  level.create_exfil_animstruct[3]._id_119A7 = (28720, 2272, -816);
  level.create_exfil_animstruct[3]._id_119A8 = 6000;
  level.create_exfil_animstruct[4] = spawnStruct();
  level.create_exfil_animstruct[4].locname = "_encstr_AFAF0B45B2046AE8C2E84BB773";
  level.create_exfil_animstruct[4].refname = "_encstr_A3B70EC31340ACC2F51B7F030F9D8AF3";
  level.create_exfil_animstruct[4]._id_119A7 = (15024, 18216, 152);
  level.create_exfil_animstruct[4]._id_119A8 = 2000;
  level.create_exfil_animstruct[5] = spawnStruct();
  level.create_exfil_animstruct[5].locname = "_encstr_BEB406F13B72BB3B";
  level.create_exfil_animstruct[5].refname = "_encstr_8AC20A4B7B582B16C1EB838F";
  level.create_exfil_animstruct[5]._id_119A7 = (-12792, 7912, -392);
  level.create_exfil_animstruct[5]._id_119A8 = 4000;
  level.create_exfil_animstruct[6] = spawnStruct();
  level.create_exfil_animstruct[6].locname = "_encstr_971804FD3712";
  level.create_exfil_animstruct[6].refname = "_encstr_81B40817BFCBE16C3138";
  level.create_exfil_animstruct[6]._id_119A7 = (-22080, 46160, -364);
  level.create_exfil_animstruct[6]._id_119A8 = 6000;
  level.create_exfil_animstruct[7] = spawnStruct();
  level.create_exfil_animstruct[7].locname = "_encstr_9A9B05DB63DD14";
  level.create_exfil_animstruct[7].refname = "_encstr_B4F209C485E6ADBE47851B";
  level.create_exfil_animstruct[7]._id_119A7 = (22688, -19272, 48);
  level.create_exfil_animstruct[7]._id_119A8 = 2000;
}

_id_1322A() {
  level.create_exfil_animstruct = [];
  level.create_exfil_animstruct[0] = spawnStruct();
  level.create_exfil_animstruct[0].locname = "_encstr_A528131E48258E64A89E51D28AE551B8FB9D3BF5F8";
  level.create_exfil_animstruct[0].refname = "_encstr_AD7609B6149AE9EE747FE8";
  level.create_exfil_animstruct[0]._id_119A7 = (-3890, -6375, 100);
  level.create_exfil_animstruct[0]._id_119A8 = 1500;
  level.create_exfil_animstruct[1] = spawnStruct();
  level.create_exfil_animstruct[1].locname = "_encstr_ABF810E8D563B0CE01D4958D43C2E6D2C6CD";
  level.create_exfil_animstruct[1].refname = "_encstr_B2EE0AF2285926E79E550903";
  level.create_exfil_animstruct[1]._id_119A7 = (1800, -6400, 100);
  level.create_exfil_animstruct[1]._id_119A8 = 4000;
  level.create_exfil_animstruct[2] = spawnStruct();
  level.create_exfil_animstruct[2].locname = "_encstr_8619096ABDBAB93AC2DC26";
  level.create_exfil_animstruct[2].refname = "_encstr_B2780D2238237849794229F0900687";
  level.create_exfil_animstruct[2]._id_119A7 = (-8245, 17400, 1000);
  level.create_exfil_animstruct[2]._id_119A8 = 3000;
  level.create_exfil_animstruct[3] = spawnStruct();
  level.create_exfil_animstruct[3].locname = "_encstr_A61B0A41A38083694DF1172F";
  level.create_exfil_animstruct[3].refname = "_encstr_88F40C37D10BC8D2D5B67D47581B";
  level.create_exfil_animstruct[3]._id_119A7 = (-2300, 1640, 600);
  level.create_exfil_animstruct[3]._id_119A8 = 2000;
  level.create_exfil_animstruct[4] = spawnStruct();
  level.create_exfil_animstruct[4].locname = "_encstr_83CF0A13F6B7D10228A5C695";
  level.create_exfil_animstruct[4].refname = "_encstr_A3B70EC31340ACC2F51B7F030F9D8AF3";
  level.create_exfil_animstruct[4]._id_119A7 = (2400, 0, 100);
  level.create_exfil_animstruct[4]._id_119A8 = 5000;
  level.create_exfil_animstruct[5] = spawnStruct();
  level.create_exfil_animstruct[5].locname = "_encstr_AF190917FFA5FA6C18C08A";
  level.create_exfil_animstruct[5].refname = "_encstr_8AC20A4B7B582B16C1EB838F";
  level.create_exfil_animstruct[5]._id_119A7 = (-18200, 9800, 800);
  level.create_exfil_animstruct[5]._id_119A8 = 4000;
  level.create_exfil_animstruct[6] = spawnStruct();
  level.create_exfil_animstruct[6].locname = "_encstr_8F240E898057B9076CA1600FD0C76B1B";
  level.create_exfil_animstruct[6].refname = "_encstr_81B40817BFCBE16C3138";
  level.create_exfil_animstruct[6]._id_119A7 = (-9300, -11150, 100);
  level.create_exfil_animstruct[6]._id_119A8 = 6000;
  level.create_exfil_animstruct[7] = spawnStruct();
  level.create_exfil_animstruct[7].locname = "_encstr_9A9B05DB63DD14";
  level.create_exfil_animstruct[7].refname = "_encstr_B4F209C485E6ADBE47851B";
  level.create_exfil_animstruct[7]._id_119A7 = (-3900, -2000, 480);
  level.create_exfil_animstruct[7]._id_119A8 = 2000;
}

changing_loadout(var_0) {
  var_1 = 20;
  var_2 = getdvarfloat("_encstr_BAE519EE8E73EF0127F72838E344B8C31AF370FDE38B5B0B19E730", var_1);
  var_3 = 3000;
  var_4 = getdvarfloat("_encstr_AAA1179653FBDEFDE59258587B7FABD133EC088EA94BC0EBCA", var_3);
  var_5 = (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  var_6 = var_5;
  return level changetimertoovertimetimer(var_6, var_0, var_2, var_4);
}

changetimertoovertimetimer(var_0, var_1, var_2, var_3) {
  if(getdvarint("_encstr_8B6F1BA0462287BD4FDA301ACDF4DB13C8199E0AFBB8246F4BC0B8A950", 0))
    return 0;

  if(istrue(level.create_agent_definition))
    return 0;

  level thread clear_three_room_screens(var_0, var_1, var_2, var_3);
  return 1;
}

chase(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level.create_agent_definition)) {
    level notify("_encstr_AA800A4B13F09931C330E363");
    waitframe();
  }

  level.create_apc_vehicle_interaction = var_2;
  level thread clear_trap_console_activation(var_0, var_1);
}

clear_three_room_screens(var_0, var_1, var_2, var_3) {
  level.create_agent_definition = 1;

  if(!isDefined(level._id_12D05))
    _id_11ECA(var_0, var_3, var_1);

  var_4 = getdvarfloat("_encstr_B40523E6B139EB4CBDB598C24EC8B559B947EB8CCA36B0F2FA895699F64E95F537A3854E1D", 8);

  if(getdvarint("_encstr_AFD22023368AF72B0219630373E838B74038195743C0AC1FFDD008CFAE1ACB0525FF", 0))
    level thread _id_11AA8(var_0, var_2 + var_4, var_3);

  wait(var_4);
  level thread create_debug_model_for_spawnpoint(var_0, var_1, var_2, var_3);
}

create_debug_model_for_spawnpoint(var_0, var_1, var_2, var_3) {
  var_4 = gettime() + var_2 * 1000;
  var_5 = "_encstr_BD78059C33C543";

  if(isDefined(var_1))
    var_5 = var_1.team;

  level thread create_execution_devgui(var_0, var_4, var_3);

  while(gettime() < var_4) {
    var_6 = scripts\mp\utility\player::getplayersinradius(var_0, var_3);
    var_7 = [];
    var_8 = [];

    foreach(var_10 in var_6) {
      if(var_10.team == var_5) {
        continue;
      }
      if(var_10 updatemlgspectatorinfo() && (scripts\mp\utility\player::isreallyalive(var_10) && !scripts\mp\utility\player::unset_relic_trex(var_10))) {
        var_8[var_8.size] = var_10;
        continue;
      }

      var_7[var_7.size] = var_10;
    }

    if(var_8.size != 0) {
      foreach(var_10 in var_8) {
        level thread _id_13816(var_10.origin, var_1);
        wait 1;
      }

      continue;
    }

    if(var_7.size != 0) {
      foreach(var_10 in var_7) {
        level thread _id_13816(var_10.origin, var_1);
        wait 1;
      }

      continue;
    }

    var_16 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0, var_3, 0.2, 0.9, 1, 0);
    level thread _id_13816(var_16, var_1);
    wait 1.5;
  }

  level.create_agent_definition = 0;
}

create_execution_devgui(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;
  var_3[0] = scripts\engine\utility::getfx("_encstr_8EF3100682106612B5B58F5F28607CB76B38");
  var_3[1] = scripts\engine\utility::getfx("_encstr_97A3113636579BA39527EBB738D14BDA3D5691");
  var_3[2] = scripts\engine\utility::getfx("_encstr_97A3113636579BA39527EBB738D14BDA3D5691");
  var_3[3] = scripts\engine\utility::getfx("_encstr_97A3113636579BA39527EBB738D14BDA3D5691");
  var_3[4] = scripts\engine\utility::getfx("_encstr_ACF90D13B227D87BF09BA0389ECD90");
  var_5 = [];
  var_6 = getdvarfloat("_encstr_9B641A9B2F78396345B1537AFE2E976D50EF101F53E0BBC7FDC8CB53", 800);
  var_7 = [];
  var_8 = var_2 * 2 / var_6;
  var_9 = var_0 - (var_2, var_2, 0);

  for(var_10 = 0; var_10 < var_8; var_10++) {
    for(var_11 = 0; var_11 < var_8; var_11++) {
      var_12 = (var_9[0] + var_10 * var_6, var_9[1] + var_11 * var_6, var_0[2]);

      if(distance2dsquared(var_0, var_12) < var_2 * var_2)
        var_5[var_5.size] = scripts\engine\utility::drop_to_ground(var_12);
    }

    waitframe();
  }

  var_5 = scripts\engine\utility::array_randomize(var_5);
  var_13 = getdvarfloat("_encstr_A3A726DC6CC9FA322B89AE9DD713F6D6C458C932ADB273E8BECCF0D78359C9AFB49BD1959C3B0B36", 5);
  var_14 = getdvarfloat("_encstr_875C271B42BBC0483F02B39F17A64891931AB3610A5F80A3591E91F7598D586D0BC3A9E8B1F34BB0EF", 0.35);

  while(gettime() < var_1) {
    for(var_10 = 0; var_10 < var_13; var_10++) {
      playFX(var_3[var_4 % var_3.size], var_5[var_4 % var_5.size]);
      var_4++;
    }

    wait(var_14);
  }
}

_id_11AA8(var_0, var_1, var_2) {
  var_3 = _id_11A9B(var_0, var_2);
  wait(var_1);
  var_3 delete();
}

_id_11ECA(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag() || !var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(var_2) && var_5.team == var_2.team) {
      var_3[var_3.size] = var_5;
      button(var_5, var_2);
      continue;
    }

    if(length2dsquared(var_5.origin - var_0) < var_1 * var_1) {
      button_sequence(var_5);
      var_3[var_3.size] = var_5;
      continue;
    }

    if(istrue(level.delete_airlock_ents))
      buttonmashcount(var_5);
  }

  var_7 = ["_encstr_B4EE153765A669F9F0211A639E6B0963FEEB9B8FB76FE7", "_encstr_A9EE1557B68B1629DCF7FDD9F7DD40A663E03C0997A5DA", "_encstr_B6EE15F2E99ED7F6D073B2BC6FB0BC3F4620DA7AD6D6A2"];
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog(var_7[randomintrange(0, 3)], 1, var_3);
}

button(var_0, var_1) {
  var_0 scripts\mp\hud_message::showsplash("_encstr_A1721D325BB8D34790E35154FF588DD75E51ABDAAD0D6BFB01C94935856894", undefined, var_1);
}

button_sequence(var_0) {
  var_0 scripts\mp\hud_message::showsplash("_encstr_A5181F2BE3F8520ABECD1381A996F5CD0929C0AC606568AB8FD8684A2533A0F2AF");
}

buttonmashcount(var_0) {
  var_0 scripts\mp\hud_message::showsplash("_encstr_A1F02398937D279567AC5836AF897BD631169C46DA59B9D1BE6316BADCD8A1F5AC37CA6B5E");
}

updatemlgspectatorinfo() {
  var_0 = self;
  var_1 = var_0.origin;
  var_2 = var_1 + (0, 0, 3000);

  if(var_2[2] <= var_1[2])
    return 0;

  var_3 = scripts\engine\trace::_bullet_trace_passed(var_1, var_2, 0, var_0);
  return var_3;
}

_id_11A9B(var_0, var_1) {
  var_2 = getmaxobjectivecount(var_0[0], var_0[1], var_1);
  var_2 setmapcirclecolorindex(12);
  var_2 setmapcircleiconindex(3);
  var_2 setmapcirclestyleindex(1);
  return var_2;
}

_id_13816(var_0, var_1) {
  if(!isDefined(level._id_13922))
    level._id_13922 = 0;

  level._id_13922++;

  if(!isDefined(var_1) || !isPlayer(var_1))
    _id_12E22(var_0, undefined);
  else if(level._id_13922 % 3 == 0)
    _id_12E22(var_0, var_1);
  else {
    if(level._id_13922 % 3 == 1) {
      _id_12E25(var_0, var_1);
      return;
    }

    _id_12E24(var_0, var_1);
  }
}

_id_12E22(var_0, var_1) {
  var_2 = 16;
  var_3 = [(0.33, 0.33, 0), (0.33, 0.66, 0), (0.66, 0.33, 0), (0.66, 0.66, 0), (-0.33, 0.33, 0), (-0.33, 0.66, 0), (-0.66, 0.33, 0), (-0.66, 0.66, 0), (0.33, -0.33, 0), (0.33, -0.66, 0), (0.66, -0.33, 0), (0.66, -0.66, 0), (-0.33, -0.33, 0), (-0.33, -0.66, 0), (-0.66, -0.33, 0), (-0.66, -0.66, 0)];
  var_4 = getdvarfloat("_encstr_8A3D1E076FC348F89FADB129927C489DDA9BE78FABAB2BE8AD09BB213F29F0CE", 514);
  var_5 = scripts\engine\utility::randomvectorrange(var_4 * -0.25, var_4 * 0.25);

  for(var_6 = 0; var_6 < var_2; var_6++)
    var_3[var_6] = var_0 + var_5 + (var_3[var_6][0] * var_4, var_3[var_6][1] * var_4, 5000);

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_7 setModel("_encstr_819117D0629FC873EB1F31054F424DF16C7E7BA90F1C8139A3");

  if(isDefined(var_1))
    var_7 setentityowner(var_1);

  var_7.weapon_name = "_encstr_A2950D16C9E8D2361B59932FF55BC1";
  var_7.angles = (0, 0, 0);
  var_7 dontinterpolate();

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_8 = var_3[var_6];
    var_9 = var_3[var_6] - (randomfloatrange(-10, 10), randomfloatrange(-10, 10), 30000);
    var_10 = scripts\engine\trace::ray_trace(var_8, var_9, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_11 = var_10["_encstr_BD260953AA97E3F014279D"];
    var_12 = var_10["_encstr_820E07FAE8780B3A4C"];
    var_13 = var_11 + var_12 * 10;
    var_14 = vectorNormalize(var_11 - var_8);

    if(var_14 == (0, 0, 1))
      var_15 = (0, 1, 0);
    else
      var_15 = vectorcross(var_14, (0, 0, 1));

    var_16 = vectorcross(var_15, var_14);
    thread callstrike_playmultitracerfx(scripts\engine\utility::getfx("_encstr_84AA119F50535363CD9BEC67E8B97B0919A85B"), var_13, var_14, var_16);
    var_7 thread moveanddamagepoint(var_6 + 1, var_13);
    wait 0.05;
  }

  wait 2;
  var_7 delete();
}

_id_12E25(var_0, var_1) {
  var_2 = var_0 + scripts\engine\utility::randomvectorrange(-1000, 1000) + (0, 0, 3000);
  var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA"), var_2, var_0, var_1);
  wait 4;

  if(isDefined(var_3))
    var_3 delete();
}

_id_12E24(var_0, var_1) {
  var_2 = var_0 + scripts\engine\utility::randomvectorrange(-1000, 1000) + (0, 0, 5000);
  var_3 = [(300, 300, 0), (-300, 300, 0), (-300, -300, 0), (300, -300, 0)];
  var_4 = getcompleteweaponname("_encstr_88710EC26CC49918FA1A815BB5AFADC1");

  foreach(var_6 in var_3) {
    var_1 thread set_up_chopper_boss(var_4, var_2, var_0 + var_6);
    wait 0.1;
  }

  wait 0.1;
  var_1 thread set_up_chopper_boss(getcompleteweaponname("_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9"), var_2, var_0);
}

set_up_chopper_boss(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = scripts\cp_mp\utility\weapon_utility::_magicbullet(var_0, var_1, var_2, self);
  var_3 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_4, var_5, var_6, var_7, var_8, var_9);
  var_10 = 0.5;
  var_11 = 100;

  switch (var_0.basename) {
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      var_10 = 1.5;
      var_11 = 500;
      break;
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
      var_10 = 1;
      var_11 = 300;
      break;
  }

  var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3.origin);
  var_12 setModel("_encstr_A5A9131AC3AF376E32A7F88F31E87267B59BD1E24B");
  var_12.angles = vectortoangles(var_9);
  var_12 linkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  var_13 = "_encstr_AB0703DBB9";
  var_12 setscriptablepartstate(var_0.basename, var_13, 0);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E8A06F7D987435E", "_encstr_9B311317F53C07EF029FC815910E3CB1BD79C8C00B")]](var_3.origin, var_11, var_11, self.team, var_10, self, 1);

    var_12 setotherent(self);
    var_3 detonate();
  } else
    var_3 delete();

  var_14 = var_12.origin;
  var_15 = 0.75;

  if(var_0.basename == "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9") {
    var_16 = 0.75;
    var_17 = 2000;
  } else {
    var_16 = 0.5;
    var_17 = 1300;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8CF40B9B3BFD1849BB9CC8C6B4", "_encstr_AB4D1537203BD17A197552887023E27283586FEF403015")]](var_14, var_16, var_15, var_17);

  wait 5;
  var_12 delete();
}

_id_12E21(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = randomfloat(360);
  var_4 = vectortoangles((cos(var_3), sin(var_3), 0));
  var_0 = scripts\engine\utility::drop_to_ground(var_0);

  if(isDefined(level._id_13B41))
    var_5 = level._id_13B41;
  else
    var_5 = "_encstr_917015FE4548591BAE76238F5E8E778DF03B724FEBF05A";

  if(istrue(level.create_apc_vehicle_interaction)) {
    var_6 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
    var_6 setModel(var_5);
    var_6.angles = var_4;
    waitframe();
  } else
    var_6 = easepower(var_5, var_0, var_4);

  if(!isDefined(var_6)) {
    return;
  }
  var_6 setscriptablepartstate("_encstr_A29B05E9400E5D", "_encstr_930B07BB1B6B3854FF", 0);

  if(isDefined(var_2))
    radiusdamage(var_0, 300, var_1, var_1, var_2, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A2950D16C9E8D2361B59932FF55BC1");

  thread calculatehelitimetoflysec(var_0);

  if(istrue(level.create_apc_vehicle_interaction))
    thread playerpositivereinforcement(var_6, 1);
  else
    thread playerpowerscleanup(var_6, 1);
}

calculatehelitimetoflysec(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(level.delete_starting_boxes)) {
    var_1 = scripts\mp\utility\player::getplayersinradius(var_0, level.delete_track);

    foreach(var_3 in var_1) {
      if(!istrue(var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())) {
        var_3 scripts\mp\weapons::setplayerstunned();
        var_3 thread scripts\mp\weapons::cleanupconcussionstun(level.delete_trapfunc);
        var_3 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
        var_3 scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B", "_encstr_A146078E65FB5158DD", level.delete_trapfunc, 1);
      }
    }
  }
}

playerpowerscleanup(var_0, var_1) {
  level.create_disconnectplayer++;
  wait(var_1);
  var_0 freescriptable();
  level.create_disconnectplayer--;
}

playerpositivereinforcement(var_0, var_1) {
  wait(var_1);
  var_0 delete();
}

moveanddamagepoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = var_1;
  self setscriptablepartstate("_encstr_860808CB78E2984063BA" + var_0, "_encstr_930B07BB1B6B3854FF", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA" + var_0, "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

callstrike_playmultitracerfx(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 3;

  while(var_4 < var_5) {
    var_6 = randomintrange(25, 50);
    var_7 = randomintrange(25, 50);
    playFX(var_0, var_1 + (var_6, var_7, 0), var_2, var_3);
    var_4++;
    wait 0.05;
  }
}

clear_trap_console_activation(var_0, var_1) {
  level endon("_encstr_AA43153AF0A9AB7EB8F9552595F089F3C3480293B8754B");
  level.create_agent_definition = 1;
  level thread _id_11AB2();
  thread _id_11AB1();
  thread _id_13B40(var_0, var_1);
}

_id_11AB1() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AA43153AF0A9AB7EB8F9552595F089F3C3480293B8754B");
  level waittill("_encstr_AA800A4B13F09931C330E363");
  level.create_agent_definition = 0;
  level notify("_encstr_AA43153AF0A9AB7EB8F9552595F089F3C3480293B8754B");
}

_id_11AB2() {
  self endon("_encstr_AA43153AF0A9AB7EB8F9552595F089F3C3480293B8754B");

  while(level.create_agent_definition) {
    level.create_ambient_vehicle = undefined;

    foreach(var_1 in level.players) {
      if(isDefined(var_1) && scripts\mp\utility\player::isreallyalive(var_1))
        level.create_ambient_vehicle = var_1;
    }

    if(isDefined(level.create_ambient_vehicle)) {
      level.create_ambient_vehicle waittill("_encstr_8D820B49520F0EC02DDE6367EC");
      continue;
    }

    return;
  }
}

_id_13B40(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_85C20D19A2E77EB19A34FBD55C4730");
  level endon("_encstr_AA800A4B13F09931C330E363");
  var_2 = gettime() + var_0 * 1000;
  var_3 = "_encstr_BD78059C33C543";

  if(!isDefined(level.create_disconnectplayer))
    level.create_disconnectplayer = 0;

  var_4 = [];

  if(isDefined(var_1))
    var_4[0] = var_1;
  else
    var_4 = level.players;

  var_6 = level._id_13B46;
  var_7 = level._id_13B45;
  var_8 = 0;

  if(isDefined(level._id_13B49))
    var_8 = level._id_13B49;

  var_9 = level._id_13B43 + randomfloat(var_8);
  var_10 = level._id_13B44;
  var_11 = 0;

  while(gettime() < var_2) {
    foreach(var_1 in var_4) {
      var_13 = undefined;

      if(isPlayer(var_1)) {
        if(!scripts\mp\utility\player::isreallyalive(var_1))
          continue;
        else
          var_13 = var_1.origin;
      } else if(isvector(var_1))
        var_13 = var_1;

      if(!isDefined(var_13)) {
        continue;
      }
      var_14 = _id_13B3C(var_0, var_2);
      var_15 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_13, var_6, var_14._id_11C42, var_14._id_11B70, 1, 0);
      _id_12E21(var_15, var_10, level.create_ambient_vehicle);
      var_11++;
      var_11 = var_11 % var_7;

      if(var_11 == 0)
        wait(var_9);
    }

    wait 0.1;
  }

  level.create_agent_definition = 0;
  level notify("_encstr_AA43153AF0A9AB7EB8F9552595F089F3C3480293B8754B");
}

_id_13B3D(var_0, var_1, var_2, var_3) {
  var_4 = getmaxobjectivecount(var_0[0], var_0[1], var_2);
  var_4 setmapcirclecolorindex(var_3);
  var_4 setmapcircleiconindex(1);
  var_4 setmapcirclestyleindex(1);
  wait(var_1);
  var_4 delete();
}

_id_13B3E(var_0, var_1, var_2) {
  level endon("_encstr_AA43153AF0A9AB7EB8F9552595F089F3C3480293B8754B");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = 0.1;
  var_4 = getdvarfloat("_encstr_B1062C4A267D69D4A838273F6026B5F2015092461D93031B96087B0B9098751BF7D71A7D7D354A6F5B18272FD853", 3000);

  while(gettime() < var_2) {
    if(!isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      break;
    }

    var_5 = _id_13B3C(var_1, var_2);
    level thread _id_13B3D(var_0.origin, var_3, var_4 * var_5._id_11C42, 4);
    level thread _id_13B3D(var_0.origin, var_3, var_4 * var_5._id_11B70, 4);
    wait(var_3);
  }

  var_0.issnipersemi = 0;
}

_id_13B3C(var_0, var_1) {
  var_2 = level._id_13B46;
  var_3 = level._id_13B47;
  var_4 = level._id_13B48;
  var_5 = var_3 / var_2;
  var_6 = var_4 / var_2;
  var_7 = var_1 - gettime();
  var_8 = var_7 / (var_0 * 1000);
  var_9 = clamp(var_8 + 0.2, 0, 1);

  if(var_9 - var_5 < var_6)
    var_9 = var_5 + var_6;

  var_10 = spawnStruct();
  var_10._id_11C42 = clamp(var_6, 0, 1);
  var_10._id_11B70 = clamp(var_9, 0, 1);
  return var_10;
}

_id_13B3F(var_0) {
  setDvar("_encstr_AD482C371B39EB1D864ECAB0D1D75B96DCEBE48546D25DE6FADC3A4E2DDA2BCDF5854EEDAE7391F5C11B2CE52B93", var_0);
}