/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_overunder\mp_m_overunder.gsc
*****************************************************/

main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  _encstr_B67A3BDC6C27A5071DB9CB6B8397DAC20E6E5EAD38FA5BF5ED67564EAE378CAC9C795B38BE6BF5BD672BC957DC19ACE4F50E4EAC6CC21BA12BB876DC36::main();
  _encstr_AF033AC8DF2260A903E2A0993AEECB298827A2A07BF7383F9ACB8D1E53121111D23E58689B2F70596135E8A86B9A45DB268BC028F7396B195E5FF6A6::main();
  _encstr_AD0435E61B93A50E8EDCCBB6E0BCD6851CCDE56B077DD6EBBD6795E457DCC895C979DA38FAB67DDBD9564E57E6239527EB33E1B8D9DCB1::main();
  _encstr_BA1C3B835F058CD3711BFECAD05F2AA850430DF733DFF209F8E3727E7F6080ADB326D587F009410873B9122DA532B3C3F960439AA209F3C829E64FF3B8::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_A2BB1BB1DEB6382CDCDCD7ADB0077DAD38D7ADAFF6CE2B93BA9BC8CA39", "_encstr_A32E258FDFCDCA996863BF423ED0AF629F5B47B7D7E15240E1A8F2011059E70BFDD5C74B191DAB");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_8AB10B4909EADB6F7B507E783C", 0.01);
  setDvar("_encstr_82BC0B6CF3A5694AD1CB999527", 5000);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_8A65065739262C37";
  thread setupbobbingboat("_encstr_A9C30C13DE894C5AE6CE24BD581D");
  thread setup_vista_driving_boats();
  thread player_fired_gun_monitor();
  thread scripts\mp\destructible::rockable_cars_init();
}

player_fired_gun_monitor() {
  var_0 = getEnt("_encstr_9A7010E0B9A16FDF65EA270FA03D039A3A3B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (296, -124, 128));
  var_1.angles = (90, 0, 0);
  var_1 clonebrushmodeltoscriptmodel(var_0);
  var_2 = getEnt("_encstr_BE9508BA80D5CB6BE2E5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (316, 866, 51));
  var_3.angles = (0, 342, 0);
  var_3 clonebrushmodeltoscriptmodel(var_2, 1);
}

setupbobbingboat(var_0) {
  var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.startpos = var_1.origin;
  var_1.startang = var_1.angles;
  thread boatbob(var_1);
  thread boatwobble(var_1);
}

boatbob(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = randomfloatrange(4, 7);
    var_0.goalpos = var_0.startpos + (randomintrange(-2, 2), randomintrange(-2, 2), randomintrange(-3, 3));
    var_0 moveTo(var_0.goalpos, var_1, var_1 * 0.25, var_1 * 0.25);
    wait(var_1);
  }
}

boatwobble(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_1 = randomfloatrange(4, 6);
    var_0.goalang = var_0.startang + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
    var_0 rotateTo(var_0.goalang, var_1, var_1 * 0.25, var_1 * 0.25);
    wait(var_1);
  }
}

setup_vista_driving_boats() {
  wait 10.0;
  var_0 = getEntArray("_encstr_9A890B8A5828F0B720CF1A5B91", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 0.0125;
  var_2 = 0.0166667;
  var_3 = 0.0333333;
  wait 2.0;

  foreach(var_5 in var_0) {
    var_5.boatfx = scripts\engine\utility::spawn_tag_origin();
    var_5.boatfx.origin = var_5.origin;
    var_5.boatfx.angles = var_5.angles;
    var_5.boatfx.targetname = "_encstr_AFF3077A8D0AA3D6B9";
    var_5.boatfx show();
    var_5.boatfx linkTo(var_5);
    wait 0.1;

    if(isDefined(var_5.script_label)) {
      if(var_5.script_label == "_encstr_A518056F42E350") {
        thread vista_boat_drive(var_5, var_3);
        playFXOnTag(scripts\engine\utility::getfx("_encstr_8DEB1036E943614F41ABE0E0B36927F94F95"), var_5.boatfx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
        var_5 playLoopSound("_encstr_B63E14DD352BD709019368303F4B20F313D14C570C92");
      } else {
        thread vista_boat_drive(var_5, var_2);
        playFXOnTag(scripts\engine\utility::getfx("_encstr_B816125654EA81BB73B843DDE7508B9F13D314BF"), var_5.boatfx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      }

      continue;
    }

    thread vista_boat_drive(var_5, var_1);
    playFXOnTag(scripts\engine\utility::getfx("_encstr_854712D66D60717B181B9BE22067333940CB734D"), var_5.boatfx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_5 playLoopSound("_encstr_B8D113D19B791FE5ADBBB306F20F8F3BD90B3E3A8D");
  }
}

vista_boat_drive(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    var_3 = abs(distance(var_0.origin, var_2.origin) * var_1);
    var_0 moveTo(var_2.origin, var_3, 0, 0);
    var_0 rotateTo(var_2.angles, var_3, 0, 0);
    var_2 = scripts\engine\utility::getStruct(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    wait(var_3);
  }
}