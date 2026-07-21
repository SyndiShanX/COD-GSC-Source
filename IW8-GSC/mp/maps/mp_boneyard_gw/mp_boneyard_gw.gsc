/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_boneyard_gw\mp_boneyard_gw.gsc
*****************************************************/

main() {
  _start_spawn_modules::keypad_check_levelinput();
  _encstr_BE5E3B6E3352F4235BFF56D3415A79B2D0C7588068796298D06A9A116BB388583FB631EFB93515F52978A7BE7966E1FCAF7B76D167997B303036B7FB8E::main();
  _encstr_A24D3A8F9E966F431997F038F35A259FEA330E507019562588DDBA9F2AEF395F8FAEC42968C7AF591F8BF083F3DF80E35BE12947C1EECA1B86A183DB::main();
  _encstr_92FB3598139BDCE08D5EF602E73219D079E60668E851D2C0A09583D82B2B502FD397DD1A3939EDCD6703C2A3197E8F3CAF4FE8927FD6C7::main();
  _encstr_852B3BFB43FB614B2480E0B75A6E0D99239E3AB1511F8228785A68F0B8B911CF9FBE79D8192DD8B6824B1BF3FF3611DF673A5C043BE5D05B8C05471A07::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 4);

    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  scripts\mp\compass::setupminimap("_encstr_923D1BB71F35E8D7AF6BBEE052FB80480A573D37B69F782F4332B6A95B");
  level thread scripts\engine\scriptable_door::system_init();
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  level.g = getEntArray("_encstr_83CD0DD81636B1F6BAD1F5859CAC2C", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  thread _id_145F0();
  thread _id_12F8E();
}

_id_145F0() {
  var_0 = getdvarint("_encstr_B4640BD8718FB217D4B25B4756", 0);
  wait 3;

  switch (var_0) {
    case 0:
      break;
    case 1:
      playFX(scripts\engine\utility::getfx("_encstr_BD930C07A3F8B1A3DD59BAE2A1AE"), (-27045, -11205, 89));
      break;
    case 2:
      playFX(scripts\engine\utility::getfx("_encstr_BA67084238D7F9B30926"), (-27045, -11205, 89));
      break;
    case 3:
      playFX(scripts\engine\utility::getfx("_encstr_85380B276FDB40989DE728A34D"), (-27045, -11205, 89));
      break;
    case 4:
      playFX(scripts\engine\utility::getfx("_encstr_AAB30A817AA7C8784537B783"), (-27045, -11205, 89));
      break;
  }
}

_id_12F8E() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_A54F06D32A2F0498":
      if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        break;
      } else {
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-29384, -17824, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-29320, -17920, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-29456, -17920, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-29384, -18008, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28760, -17792, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28832, -17888, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28696, -17888, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28760, -17976, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28456, -17272, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28528, -17184, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28456, -17088, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-28392, -17184, -232), (0, 90, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28680, -2848, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28592, -2768, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28760, -2776, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28680, -2680, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28304, -2776, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28224, -2848, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28224, -2680, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-28136, -2768, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-27768, -2680, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-27680, -2768, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-27768, -2680, -311.31), (0, 270, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-27848, -2776, -311.31), (0, 270, 0));
        break;
      }
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}