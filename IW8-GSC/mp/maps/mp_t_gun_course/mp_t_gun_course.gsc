/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_t_gun_course\mp_t_gun_course.gsc
*******************************************************/

main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  level._id_13D50 = 1;
  level.music_style = "_encstr_AD130C5BD24623B1B2D7AC169B47";
  var_0 = getentarrayinradius("_encstr_811F0DF09B396191B1E3859F3AEACD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF", (-610.39, 705.465, 45.9237), 1)[0];
  var_0.origin = var_0.origin + (0, 0, 1);
  var_1 = getdvarint("_encstr_BA040B31A8A2942D2793962A8A", 0);

  if(var_1 == 104) {
    level.set_spotlight_target_loc = 0;
    var_2 = "_encstr_B42E085325A82CB3F221";
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-700, 400, 24), (0, 50, 0));
  } else {
    level.set_spotlight_target_loc = 1;
    var_2 = "_encstr_8D5B09262CD8B5EEB02719";
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_87CE0FB5C1BEA3272D2C1BAF9BE016EE37", (-709, 472, 24), (0, 150, 0));
  }

  var_4 = getEntArray();

  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_wtf) && var_6.script_wtf == var_2)
      var_6 delete();
  }

  scripts\mp\spawnlogic::bdiedonce([var_3]);
  _encstr_93FB3D9BD8C92DC18EDC97AD385EDA2C0EB9F2AD38EB477D765737AFC6DB5DC9B9CA5E5B0EF58EEBB3579B7DD8BDAE4EE62BD7E027B21BC23686CAB83BDCD8::main();
  _encstr_87CD3CCD8DE44B078E6ECBB6835ED6C238B9F26B0EBED1EBCE57B9FA1BDEAB39CD595EB356E6795B0E7D8EAFD957B9EB36EDAEC937ACD7169C1DB8766EB1::main();
  _encstr_B6C33792FEB5C228D3F8D6C7F860FD8A490E0D8DDF474B7FD9E0DB078840BDC3E7ADF505471F83B7E198E3FFB038750BBF35617F2B150AC389::main();
  _encstr_853E3DB201F8016365BFEEFFA1A0FA41906B3DBDDB39C469349BE33FEFB8A3AA2031B50533E18C211C63DB47D750EBE2F899D1CD8848284B637DF78A3706B2::main();
  scripts\mp\load::main();
  level.ttlos_suppressasserts = 1;
  level.trial_infinite_reserve_ammo = 1;
  scripts\mp\compass::setupminimap("_encstr_827F1C61FABF3F08228B4F3381CA310973511B6E02B778C1FE7F1305BBF7");
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread _id_12C55();
  thread door_surprise_breach();
  thread progression_gates();
  thread target_random_models();
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-20, 1648, 68));
  var_8.angles = (0, 180, 0);
  var_8 setModel("_encstr_BA242A89BA5AC6C85A37D9F5DD2C638DAF4C937BDAB273FAD8DE9CCD5993FAA1700F43E0F5184CFA47B03723");
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1352, 1780.5, 160));
  var_9.angles = (0, 270, 0);
  var_9 setModel("_encstr_8AF11F1B2DCDC895394C367B36ADEBBB0B1B63F51DF6381C9539FA81197D1346E0");
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-256, 536, 244));
  var_10.angles = (0, 270, 0);
  var_10 setModel("_encstr_88BC19F0993B7194C02340B9A11007BF6F3A0D5F9ADBF5E7D84A76");
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-998.672, 1585, 25.4966));
  var_11.angles = (0, 184.399, -180);
  var_11 setModel("_encstr_A7033112FF7DE38F527B0960188FCA0E5B13179ACA85BE850DB51FC142A92F6E07983011B7E390A768A660B8AE19414FE2F9F3");
  var_12 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-1128, 672, 120));
  var_12.angles = (360, 345, -90);
  var_12 setModel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");

  if(!level.set_spotlight_target_loc) {
    var_13 = getEnt("_encstr_961804BD954A", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
    var_13.origin = var_13.origin + (0, 48, 0);
    var_14 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (-499.179, 667.972, -15.5977));
    var_14.angles = (0, 303.999, -90.0001);
    var_14 setModel("_encstr_883C10B8FA66B3E983614E4310B63BF98827");
  }
}

door_surprise_breach() {
  var_0 = getEnt("_encstr_B16705D9AFE22E", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_1 = getEnt("_encstr_877807BA5717B8C8FD", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");
  var_2 = getEnt("_encstr_82780732EDF6E4F5E4", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  for(;;) {
    level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");

    while(!var_0.activated)
      waitframe();

    playsoundatpos(var_1.origin + (0, 0, 42), "_encstr_8CC823BBA60DBB4340FF77AFAB17900D0734384FAFD1B3202CDE1BC35D0FF0D77972AE03E0");
    playsoundatpos(var_2.origin + (0, 0, 42), "_encstr_8CC823BBA60DBB4340FF77AFAB17900D0734384FAFD1B3202CDE1BC35D0FF0D77972AE03E0");
    var_1 rotateYaw(-135, 0.3, 0, 0.1);
    var_2 rotateYaw(135, 0.3, 0, 0.1);
    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
    var_1 rotateYaw(135, 1);
    var_2 rotateYaw(-135, 1);
  }
}

progression_gates() {
  var_0 = getEnt("_encstr_8D6E0CF8CCAFD60BC19A3D8B77C5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt("_encstr_A9D916DA3DCB2B64FE28B79328911762BF5965D4266332B6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = getEnt("_encstr_B1011E1243C0BA8310752713672579E308E84D1C5B687F1A480F7B3755DBB25F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getEnt("_encstr_8CF60A408A77CFB9EFEE363D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = getEnt("_encstr_BA3C14753881779FCB88C2BA191F15733813EBE1C0A8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_5 = getEnt("_encstr_97DE104C0BD8D6A39C2CC6B6BE6695B9B195", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_6 = getEnt("_encstr_8395217ADB1BC4F31E01028AAE7CCFFD684BCFC36FA0CD4F4638DAA2B6C6237550236C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 linkTo(var_0);

  if(level.set_spotlight_target_loc) {
    var_7 = (0, 90, 0);
    var_8 = (0, 0, 0);
    var_9 = (0, 290, 0);
    var_10 = (0, 0, 0);
    var_11 = (0, 4, 0);
    var_12 = (0, 270, 0);
    var_13 = (-1030, 484, 82);
  } else {
    var_7 = (0, 290, 0);
    var_8 = (0, 0, 0);
    var_9 = (0, 90, 0);
    var_10 = (0, 0, 0);
    var_11 = (0, 0, 0);
    var_12 = (0, 90, 0);
    var_13 = (-448, 530, 82);
  }

  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");

  while(level.player getvelocity() == 0)
    waitframe();

  for(;;) {
    var_0 rotateTo(var_7, 2);
    scripts\engine\utility::play_sound_in_space("_encstr_BE081EE3C6D31264E68883C3D1B92FBABDC8AE9C277B5ABCC888BF57D8D017E3", var_13);
    wait 1.5;
    var_1 notsolid();
    level waittill("_encstr_85EC0F1BA7D0E24F3566A3DB89966B9FF0");
    var_1 solid();
    var_2 notsolid();
    var_6 notsolid();
    var_4 notsolid();
    var_0 rotateTo(var_8, 2);
    var_3 rotateTo(var_9, 3);
    var_5 rotateTo(var_11, 1);
    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
    var_2 solid();
    var_6 solid();
    var_5 rotateTo(var_12, 3);
    _tablethide::trial_ui_waittill_retry();
  }
}

_id_12C55() {
  for(;;) {
    level waittill("_encstr_B8D80D131723B292AB2759B2975BA0");
    var_0 = getentitylessscriptablearrayinradius("_encstr_A34C32F3AA53231093E945A115B1C0FE8BA22B9B127BE9E061C457AF2AE968307B9BC3034BEF976009D55B81210D110953913323", "_encstr_AC110A7F14873B5B3D073009");

    foreach(var_2 in var_0)
    var_2 vehicle_getinputvalue();
  }
}

target_random_models() {
  while(!isDefined(level.targets_thinking) || istrue(level.targets_thinking))
    waitframe();

  var_0 = ["_encstr_8AE12A8D20CF571B40BB044815B77693D367B705D8C298087226A84C2BDFB290D1A3C5C19F3865A56A0EF12F", "_encstr_85E12A56B2EBAD4B1B5AD1C2C95EF59B86BDBD1D4B37CEFA4E589BD9ACEBE0C60BD1CAF5B2E695B52FD76023", "_encstr_ADE12A7982AF7980DDA95173DAC0693EDB9AB0C3AA93A4F972B91D67F5A1D809A743492EF23BED5048AFA9C7", "_encstr_B4E12AAC2BBE6B9636D2A3589CBC7D9B1ADEBD1DA5B9CEFA3958DCB32BBE071B2C1DB2F5CA73AC6BCBF50C0D", "_encstr_B6E12AA19520E09BD9C7345FCDB10EA809AAE7248073AC76C6AF58DF7B49C7D5C163F99060866D2D79F712FE", "_encstr_A6E12A5659BEB6A5C6B44785E4F2EBCD1ADBBDD196DCD9BEC985B93BB2EB1CB1583A59FAB2DCCAAD2FEB1863"];
  var_1 = ["_encstr_959F2DE7BBC0BA0163704B160BF06F1323D7473B0BF0C2FF1859C59F81E9881A0F49171F87AB9BB1D0A03EA5FE6AF1", "_encstr_A29F2D562BF55B5AC6963A169C5E7D9BA1B77B1D4B73ECF5E458373BB2FA1C8D2C8EACEB6C5A6796C65A16B9FA8191", "_encstr_B19F2D59CABE5B4BD8A5D158C9CBF5CD347BB7D15A9BB37D4E58E6D92BF51CD8B0E8AC7D365A9D4BD8B42CB9AF6033"];
  var_2 = ["_encstr_87CE289595BE6B968D2D1DB093F2F5E634B7F6A32DDC9DEBE416B93B2BBE8336851DCAAF2657631BACD1", "_encstr_A3AC2B0D9DC192EBF2DBE3B00383998F509F0F63BA25BF2E3D8705C16767131307A838BE12C36DCB5213B90B87", "_encstr_ACAC2BE36F312769F83B70C3F2712F4FEAF85863FA48B0D7EA4F4678AA50B189D22BA50721BB39CC3F9308290A", "_encstr_91AC2B2DC76943B8FC2F2070BB11B6B7C2ED902D5C122F26CA27F848CF1F2BD1FAD31D20F61BF188856B69EA8E"];
  var_3 = scripts\engine\utility::array_randomize(level.enemy_targets);
  var_4 = scripts\engine\utility::array_randomize(level.civilian_targets);

  foreach(var_6 in var_3) {
    var_6.bullet_decal = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6.plate.origin);
    var_6.bullet_decal.angles = var_6.plate.angles;
    var_6.bullet_decal linkTo(var_6.plate);

    if(isDefined(var_6.script_parameters))
      var_6.plate setModel(var_6.script_parameters);
  }

  foreach(var_6 in var_3) {
    var_9 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(var_3, var_6));
    var_10 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9));
    var_11 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9), var_10));
    var_12 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_2, var_9.bullet_decal.model), var_10.bullet_decal.model), var_11.bullet_decal.model);

    if(!isDefined(var_6.script_parameters)) {
      var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_0, var_9.plate.model), var_10.plate.model), var_11.plate.model);
      var_6.plate setModel(scripts\engine\utility::random(var_13));
    }

    var_6.bullet_decal setModel(scripts\engine\utility::random(var_12));
  }

  foreach(var_16 in var_4) {
    var_9 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(var_4, var_16));
    var_10 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_4, var_16), var_9));

    if(isDefined(var_16.script_parameters)) {
      var_16.plate setModel(var_16.script_parameters);
      continue;
    }

    var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_1, var_9.plate.model), var_10.plate.model);
    var_16.plate setModel(scripts\engine\utility::random(var_13));
  }
}