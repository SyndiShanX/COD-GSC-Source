/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_oilrig\mp_oilrig.gsc
***********************************************/

main() {
  _start_spawn_modules::keypad_check_levelinput();
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  _encstr_99FD31EA59A0592B1DC7A6A7E968228958A375F5937117F279DD8797AF61BBFFF8485DBA28D89F9B4E9BA7871F9BD276109316::main();
  _encstr_951F30D613BB589963B3F2F89B6D6B910BAB70417867C0934D4BC8A0461723C89E2D67D0CF6768ED742281A8EBEB7DA1B7CB::main();
  _encstr_A60F2B831F25E36370E32EC52BF89321704B0257E88F2810981373D7E6F7D2592F93381A5F7FBE1EF9ED0F1B4F::main();
  _encstr_8D1B316E8DC95A383ACD5E6BE0CBADB0836E976BC1FABDA58D27A5D997DA0EEBED5AB19396B3EB8D4BCEA11D96E69D179D6E1B::main();
  scripts\mp\load::main();
  setDvar("_encstr_A7341BF848750358B597CF3FC543279965B24AEF507891A0884BC32748", 1);
  level.music_style = "_encstr_BAFB08CA7376C616B932";
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_978A161A50F33AA773AE4F654FFB978531394232F06534C7", "_encstr_9A442038D23FEF01FF4C8D7E0FD788AB629A9B30499523FB774D0FE00727105D8C82");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  setDvar("_encstr_B8BC0A9479731E693A7ABB81", 2);
  setDvar("_encstr_82BC0B6CF3A5694AD1CB999527", 5000);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread _id_139C6();
  thread _id_139C5("_encstr_B40F0F58CA35EA9C252A1938D562B9FA39");
  thread _id_139C5("_encstr_B60F0F580E3660EB82F7CFBF3FABA52282");
  thread total_puddle_count("_encstr_952C07E644CAB95361");
  thread carriable_respawn();
  level thread _id_121F5();
  level thread onplayerconnect();
  thread scripts\mp\animation_suite::animationsuite();
  level._id_12C49 = 1;
  level.requiredplayercount["_encstr_9A8507BA4040188D08"] = 4;
  level.requiredplayercount["_encstr_8E8405EA382B2A"] = 4;
  thread check_trigger_spawnflags();
}

_id_121F5() {
  if(!isDefined(level.outofboundstriggers))
    level.outofboundstriggers = [];

  var_0 = [(-2126, -1616, 983), (-2175, -1400, 980), (-1500, -2600, 850)];

  foreach(var_2 in var_0) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, 400, 128);
    level.outofboundstriggers[level.outofboundstriggers.size] = var_3;
  }
}

carriable_respawn() {
  var_0 = getEnt("_encstr_B81B13324E4BC6B1149BA5AD583AB2910A96D9DEE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_965C0BC827B463D8145A3BB7D1", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = getEnt("_encstr_B601188D222A6138F113E8F017FCD1B9610C7C803B21D301B013", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_0)) {
    var_0 linkTo(var_1);
    var_2 linkTo(var_1);
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread _id_13892();
    var_0 thread _id_13893();
  }
}

_id_13892() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.update_tracks_operational_status = 1;
  var_0 = "_encstr_A130085D3FD8D8A80F60";

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_isalive() && self.update_tracks_operational_status)
      playFXOnTag(level._effect["_encstr_A525103948240FE9900A42924BEBBEEBE7DD"], self, var_0);

    wait(2.5 + randomfloat(3));
  }
}

_id_13893() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getEnt("_encstr_BE380E2D7337B423AC1539963B76AC4E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(;;) {
    if(var_0 istouching(self))
      self.update_tracks_operational_status = 0;
    else
      self.update_tracks_operational_status = 1;

    wait 1;
  }
}

_id_139C6() {
  var_0 = getEnt("_encstr_B6E30A63873F40CFD6E7344F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3.modelscale = 0.5;
    var_3 linkTo(var_0);
  }

  thread _id_139C8(var_0, 4);
}

_id_139C5(var_0) {
  var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_139C8(var_1, 1.25);
}

_id_139C8(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_1;

  for(;;) {
    var_3 = 7;
    var_2 = var_2 * -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_2);
    var_0 rotateTo(var_0.goalang, var_3, var_3 * 0.45, var_3 * 0.45);
    wait(var_3);
    scripts\engine\utility::exploder("_encstr_A5AD056A019C63");
    var_2 = var_2 * -1;
    var_0.goalang = (randomfloatrange(-1.5, 1.5), randomfloatrange(-15, 15), var_2);
    var_0 rotateTo(var_0.goalang, var_3, var_3 * 0.45, var_3 * 0.45);
    wait(var_3);
    scripts\engine\utility::exploder("_encstr_8253060E2B5FE330");
  }
}

total_puddle_count(var_0) {
  level waittill("_encstr_93DB1596E666B436BE6E59D1EAE0AF8DF6AD836359A32B");
  var_1 = getEnt("_encstr_82710C9BD3C823D2BB290A52C867", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEntArray("_encstr_86760CAB0990C222FE06326AC8BA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_96340A92D11372F1E0FD8AC5", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  if(isDefined(var_1))
    var_1 linkTo(var_3);

  if(isDefined(var_2) && isDefined(var_3)) {
    foreach(var_5 in var_2)
    var_5 linkTo(var_3);
  }

  wait 6.0;
  var_1._id_132A9 = scripts\engine\utility::spawn_tag_origin();
  var_1._id_132A9.origin = var_1.origin;
  var_1._id_132A9.angles = var_1.angles;
  var_1._id_132A9.targetname = "_encstr_A62C078A638B5B266E";
  var_1._id_132A9 show();
  var_1._id_132A9 linkTo(var_1);
  wait 0.1;
  playFXOnTag(scripts\engine\utility::getfx("_encstr_8D4913D9991EF5F69663AFC6589CB3EDAF6EA15A0E"), var_1._id_132A9, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 playLoopSound("_encstr_B63E14DD352BD709019368303F4B20F313D14C570C92");
}

check_trigger_spawnflags() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
  var_1 = 35;
  var_2 = 35.0;
  var_3 = 50.0;
  var_4 = [];

  for(var_5 = 1; var_5 < var_1 + 1; var_5++) {
    var_6 = "_encstr_9760271C898125433166B3CBAB1FC7DDA80B9473F1086EE7ED3B79B270E04F53588F0DE563B8F3DF98" + var_5 + "_encstr_934C0218";

    if(soundexists(var_6))
      var_4[var_4.size] = var_6;
  }

  var_7 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  level thread check_if_frozen();
  var_8 = [];
  var_8[var_8.size] = -1;
  var_8[var_8.size] = -1;
  var_8[var_8.size] = -1;

  for(;;) {
    for(var_9 = randomintrange(0, var_4.size); var_9 == var_8[0] || var_9 == var_8[1] || var_9 == var_8[2]; var_9 = randomintrange(0, var_4.size)) {}

    var_8[0] = var_8[1];
    var_8[1] = var_8[2];
    var_8[2] = var_9;
    var_7 playSound(var_4[var_9]);
    wait 5.0;
    wait(randomfloatrange(var_2, var_3));
  }
}

check_if_frozen() {
  wait 10;
  enablepaspeaker("_encstr_A2400AC02CB295400F1FD858");
}