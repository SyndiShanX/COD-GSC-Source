/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_train\mp_m_train.gsc
***********************************************/

main() {
  _encstr_A7343308584D77DBA4279D3DC10F071662D3CEE9C8F11DC1CB4A86175086D07F7118866B839EA76BA16B98E20E19A7191BB568DFB7::main();
  _encstr_BA4A32F34710DC4BB5FB6E72A3207796580FD765F9D1652F5D33823A0848674F400F1DE00FB821CB06491A5236B7FB43FA779B7B::main();
  _encstr_934A2DB936E44BE03AB9E55B8379D6588337E5DA0E7DDAAFE893C29673E55B0EF55BD78EC98596DCBECC3CB8D9CDC6::main();
  _encstr_880C333BB35631C950FFEF9DD84E55AE898282CF58FFA589530BC878480870D9B848D073128E30DA390C1C07634B6CC80732E84733::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_847217C6F6D6E0C2B9DCAFB50B1C7DB60EAFD6D7A393C2A5E6", "_encstr_A5F7216C7B191B2CE68ECA4EEBD8EDB5830B9BE6FADAC283BE5BC1FAB5AF1D4E16D2B9");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread _id_1327B();
  level._id_138B3 = 3000;
  thread _id_1323C();
  level.music_style = "_encstr_BAFB08CA7376C616B932";
}

monitor_dropped_phones() {
  for(;;) {
    level waittill("_encstr_91860E2BECB3A93ADEB9CA21C9EDD695");
    scripts\engine\utility::stop_exploder("_encstr_9AB10AFDAD5B4123CFFB9868");
    _id_13DC1();
  }
}

_id_13DC1() {
  thread molotov_register_trigger();
  wait 3;
  scripts\engine\utility::exploder("_encstr_9AB10AFDAD5B4123CFFB9868");
  wait 1;
  earthquake(0.75, 5, (8224, 2064, 0), 50000);

  foreach(var_1 in level.players) {
    thread _id_1329E(var_1);
    var_1 playlocalsound("_encstr_AF7A14586549DB22665D17CF2D506CB2D1E9E3E10E9F");
  }
}

molotov_register_trigger() {
  setmusicstate("_encstr_99FC146D9BA86F6B1EE3BFABB74DE29B786122F771B0");
  wait 1;
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (11723, 5944, 243));
  var_0 playSound("_encstr_B4FD1893A58FAA56C9817FC99B2064B25B676F036F20521928A9");
  wait 3;
  var_0 playSound("_encstr_A74A1464F5184CA3B0897AC1B3F5C347A0C7E4F97598");
  wait 8;
  var_0 playSound("_encstr_BDA914B5129A5B48DFEF5891B33DC189A3F1ABB5ED22");
  wait 2;
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-10356, 2146, 9476));
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-10563, -2114, 9476));
  waitframe();
  var_1 playsoundonmovingent("_encstr_A16416A9326670374F7A89F602CEE709BEA8295DC7CE985B");
  var_2 playsoundonmovingent("_encstr_A16416A9326670374F7A89F602CEE709BEA8295DC7CE985B");
  wait 4;
  var_1 moveTo((11001, 5520, 9476), 6);
  var_2 moveTo((8875, -2051, 9476), 6);
  wait 4;
  var_0 playSound("_encstr_8E5815E86B1683982705D5C00C170151F841E0F8F2EBD9");
  wait 12;
  var_1 delete();
  var_2 delete();
  var_0 delete();
}

_id_1329E(var_0) {
  var_0 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0.origin);
  wait 0.1;
  var_0 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0.origin);
  wait 0.2;
  var_0 playrumbleonpositionforclient("_encstr_A9D111B0278EA5D8D85939CBF5E4AED613D8B2", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_B6F00B9B1D8F830F9918182AAB", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_B6F00B9B1D8F830F9918182AAB", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_B6F00B9B1D8F830F9918182AAB", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_B6F00B9B1D8F830F9918182AAB", var_0.origin);
  wait 0.3;
  var_0 playrumbleonpositionforclient("_encstr_B6F00B9B1D8F830F9918182AAB", var_0.origin);
}

_id_1323C() {
  level.molotov_watch_cleanup_pool_internal = 1;
  waitframe();
  level.monitor_dropmenu = getEnt("_encstr_81430C254F4F81F005E8E34FCF8A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_13275(level.monitor_dropmenu);
  level.monitor_balloon_marker_throw = getEnt("_encstr_A7630A5976CEA6477B732B13", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_13275(level.monitor_balloon_marker_throw);
  level.monitor_balloons = getEnt("_encstr_A1630A8B27E7A10D8FCA895B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_13275(level.monitor_balloons);
  level.monitor_bush_trig = getEnt("_encstr_93630AD9BF8F315CC0ED95D3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_13275(level.monitor_bush_trig);
  level.monitor_death_thread = getEnt("_encstr_8B630A9576B39AE8DE9B951A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_13275(level.monitor_death_thread);
  level.monitor_dropkit_marker_throw = getEnt("_encstr_83630A9BCF22FEF80FFDC1D3", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_13275(level.monitor_dropkit_marker_throw);
  level.helihint_gotopad[0] = randomintrange(1, 10);
  _id_1313F(level.monitor_balloon_marker_throw, level.helihint_gotopad[0]);

  for(level.helihint_gotopad[1] = level.helihint_gotopad[0]; level.helihint_gotopad[1] == level.helihint_gotopad[0]; level.helihint_gotopad[1] = randomintrange(1, 10)) {}

  _id_1313F(level.monitor_balloons, level.helihint_gotopad[1]);

  for(level.helihint_gotopad[2] = level.helihint_gotopad[0]; level.helihint_gotopad[2] == level.helihint_gotopad[0] || level.helihint_gotopad[2] == level.helihint_gotopad[1]; level.helihint_gotopad[2] = randomintrange(1, 10)) {}

  _id_1313F(level.monitor_bush_trig, level.helihint_gotopad[2]);

  for(level.helihint_gotopad[3] = level.helihint_gotopad[0]; level.helihint_gotopad[3] == level.helihint_gotopad[0] || level.helihint_gotopad[3] == level.helihint_gotopad[1] || level.helihint_gotopad[3] == level.helihint_gotopad[2]; level.helihint_gotopad[3] = randomintrange(1, 10)) {}

  _id_1313F(level.monitor_death_thread, level.helihint_gotopad[3]);

  for(level.helihint_gotopad[4] = level.helihint_gotopad[0]; level.helihint_gotopad[4] == level.helihint_gotopad[0] || level.helihint_gotopad[4] == level.helihint_gotopad[1] || level.helihint_gotopad[4] == level.helihint_gotopad[2] || level.helihint_gotopad[4] == level.helihint_gotopad[3]; level.helihint_gotopad[4] = randomintrange(1, 10)) {}

  _id_1313F(level.monitor_dropkit_marker_throw, level.helihint_gotopad[4]);
  level.insertingarmorplate = 0;
}

_id_13275(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 setCanDamage(1);
  var_0.health = level._id_138B3;
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 show();
  var_1.fxname = "_encstr_B6A02076CDC0D1DB36398AC2C686FFD5408D1DFC5351651BD0D1537AAE6DEF4A1035";

  while(var_0.health > 0)
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

  playFXOnTag(scripts\engine\utility::getfx("_encstr_B6A02076CDC0D1DB36398AC2C686FFD5408D1DFC5351651BD0D1537AAE6DEF4A1035"), var_1, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  playsoundatpos(var_1.origin, "_encstr_879714B1B73BD0F8FA15B913FFEFA070326F15CBC372");
  level notify("_encstr_91860E2BECB3A93ADEB9CA21C9EDD695");
  var_0 hide();

  if(isDefined(var_0.heligotoplunderrepository))
    var_0.heligotoplunderrepository show();

  if(var_0.targetname == "_encstr_81430C254F4F81F005E8E34FCF8A")
    thread vehicles_spawned();
}

molotov_watch_cleanup_pool() {
  level._id_138B3 = 1;
}

vehicles_spawned() {
  level.vehicleoccupants = getEntArray("_encstr_96A80A56B3B312D53A47BD73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.vehicleoccupants)
  thread vehiclespawn_armoredtruck(var_1);

  wait 1;

  while(level.molotov_watch_cleanup_pool_internal) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("_encstr_9BB30F1ABDC85669B29728C995379B9519");
      continue;
    }

    level.molotov_watch_cleanup_pool_internal = 0;
    thread _id_13DC1();
  }
}

vehiclespawn_armoredtruck(var_0) {
  var_0 setCanDamage(1);

  while(level.molotov_watch_cleanup_pool_internal) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(level.audio_player_delete_mud_loop == int(var_0.script_label)) {
      level.insertingarmorplate++;
      level notify("_encstr_9BB30F1ABDC85669B29728C995379B9519");
      continue;
    }

    if(level.helihint_gotopad[0] == int(var_0.script_label)) {
      level.insertingarmorplate = 1;
      level notify("_encstr_9BB30F1ABDC85669B29728C995379B9519");
      continue;
    }

    level.insertingarmorplate = 0;
    level notify("_encstr_9BB30F1ABDC85669B29728C995379B9519");
  }
}

_id_1313F(var_0, var_1) {
  switch (var_1) {
    case 1:
      var_0.heligotoplunderrepository = getEnt("_encstr_A2BA0527EAB698", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 2:
      var_0.heligotoplunderrepository = getEnt("_encstr_B1BA059DF7EA9F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 3:
      var_0.heligotoplunderrepository = getEnt("_encstr_BABA059CD55B99", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 4:
      var_0.heligotoplunderrepository = getEnt("_encstr_B2BA05D9FBF5D9", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 5:
      var_0.heligotoplunderrepository = getEnt("_encstr_A6BA05D0BBF1D2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 6:
      var_0.heligotoplunderrepository = getEnt("_encstr_B6BA0584133DE2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 7:
      var_0.heligotoplunderrepository = getEnt("_encstr_B4BA05C95DDA9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 8:
      var_0.heligotoplunderrepository = getEnt("_encstr_ADBA05C9DDF818", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    case 9:
      var_0.heligotoplunderrepository = getEnt("_encstr_85BA0588C0B328", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_0.heligotoplunderrepository.origin = var_0.origin;
      var_0.heligotoplunderrepository.angles = var_0.angles;
      var_0.heligotoplunderrepository hide();
      break;
    default:
      break;
  }
}

_id_1327B() {
  wait(randomint(20));
  var_0 = getEntArray("_encstr_ADA606A2E4B04BE6", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  level._id_13CD2 = 1;
  wait(level._id_13CD2);
  level._id_12A13 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (656, 968, 180));
  level._id_12A14 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (572, 332, 80));
  level._id_12A15 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (656, -436, 180));
  level._id_12A16 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (216, -196, 80));

  foreach(var_2 in var_0) {
    if(isDefined(var_2.targetname)) {
      var_3 = getEntArray(var_2.targetname, "_encstr_A16007A921A23B85E3");

      foreach(var_5 in var_3)
      var_5 linkTo(var_2);
    }

    if(isDefined(var_2.script_label)) {
      switch (var_2.script_label) {
        case "_encstr_817F076A48F76C8B81":
          if(isDefined(var_2.targetname) && var_2.targetname == "_encstr_AB720BA7D52B1A4D4673A8906C") {
            playFXOnTag(level._effect["_encstr_832F1E3B9B73192B326AEB15A030889D54CA4461DB331FD2CA2EEA39C153137E"], var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
            thread _id_13C97(var_2);
          }

          break;
        case "_encstr_836908836871798689F5":
          break;
        case "_encstr_AB2207CB9F030A59A0":
          break;
        default:
          break;
      }
    }

    thread _id_13CC9(var_2);
    thread _id_13CCC(var_2);
    level._id_13CD2 = randomint(30);
    var_2 thread _id_13C96();
  }
}

_id_13CCC(var_0) {
  wait(randomfloat(1.0));

  for(;;) {
    playrumbleonposition("_encstr_A2EE0C1037DEC01783C321BE9D2A", var_0.origin + (150, 0, 0));
    wait 0.3;
  }
}

_id_13CC9(var_0) {
  var_1 = 0.0025;
  var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_3 = abs(distance(var_0.origin, var_2.origin) * var_1);
    var_0 moveTo(var_2.origin, var_3, 0, 0);
    var_0 rotateTo(var_2.angles, var_3, 0, 0);
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    wait(var_3);

    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "_encstr_A26A09A3F2BD63A30FCA85") {
      var_0.origin = var_2.origin;
      var_0.angles = var_2.angles;
      wait(level._id_13CD2);
      var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    }
  }
}

_id_13C96() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0 endon("_encstr_AD75063D571AE108");
  thread scripts\engine\utility::delete_on_death(var_0);
  var_1 = "_encstr_B40101";

  switch (self.script_label) {
    case "_encstr_817F076A48F76C8B81":
      var_1 = "_encstr_92971967B234AF6C8527D9DB47C9165AB9AF95E676D2B995EB8D83";
      break;
    case "_encstr_836908836871798689F5":
      var_1 = "_encstr_811F17E0C738A68F52A284983B3BD328969778C003C37E596B";
      break;
    case "_encstr_AB2207CB9F030A59A0":
      var_1 = "_encstr_A3E0172DA5A44106378B4970D343CF38FD078FFB5A0BF9D91B";
      break;
    default:
      break;
  }

  var_0 linkTo(self);
  wait 0.05;
  var_0 playLoopSound(var_1);
  var_0 waittill("_encstr_9B8F0BAE0BE2F1097BBF50807B" + var_1);
  var_0 stoploopsound(var_1);
  var_0 delete();
}

_id_13C97(var_0) {
  waitframe();

  for(;;) {
    if(isDefined(var_0) && isDefined(level._id_12A13)) {
      if(distance2dsquared(var_0.origin, level._id_12A13.origin) < 7000000) {
        level._id_12A13 playSound("_encstr_8B261771859419DDCB772BDD7733AF884C5DF98EEFEDE81E92");
        wait 1.5;
        level._id_12A14 playSound("_encstr_91A2191BBDD331FD0BAA986051533F206B0493F75E3D18C5638231");
        wait 1.5;
        level._id_12A15 playSound("_encstr_8B261771859419DDCB772BDD7733AF884C5DF98EEFEDE81E92");
        level._id_12A16 playSound("_encstr_91A2191BBDD331FD0BAA986051533F206B0493F75E3D18C5638231");
        wait 30;
      } else
        wait 1;
    }

    waitframe();
  }
}