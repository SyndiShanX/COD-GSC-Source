/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_promenade_gw\mp_promenade_gw.gsc
*******************************************************/

main() {
  _encstr_A3A33DDC6CC94B38A3CDE5B51C79D616E0DCBCB60EAF83E4DEDACA9B0B1995AFB3DDBCB51CAF8339BDD656CDC2C895FA9DDDD71C2795D82C8D1ACAC5769BD8::main();
  _encstr_ADEE3C1F236A8340B188BFD25A5E585112BAF020178F73A245931B72C235377FBF2C7682BD4E5EE2CB4F3B23926F21405F10FD41BFAC27E2B5F395E29BE7::main();
  _encstr_A97C37C7320A1818EBABA6DD579763911073D8DDDB3860BBC7011AF07109E5D1EC6F58828106D8169AF5CF8633DF083F54CF0924F8E5EA4E3E::main();
  _encstr_9BC13DFB36CB276291E89EB2D80F1DBF23A63F6DD7360B2A7FE022BA48E1578F390CB7156FDED37217C82AB220C98FD791F47F9C0B61FB3B23C8F2AE283F46::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registerlargemap();

  if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B" || scripts\mp\utility\game::unset_relic_landlocked()) {
    if(!isDefined(level.localeid))
      setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 18);

    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    level.kill_border_triggers = getEntArray("_encstr_BEB1142FC808E479552002BF1D5D31A493A067973063", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  }

  getscriptablelootspawnedcountbyname(400, 1200);
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_843E1C471771C3A120DB79FDB110D7AA57DF938BEFA95A96E841EF4969D0");
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  level.music_style = "_encstr_824D0F570306FBDD206071C73B18EF73D5";
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread _id_12F8E();
}

_id_12F8E() {
  var_0 = [];

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_A54F06D32A2F0498":
      if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) || game["_encstr_8DC30DAA0285FD69FAE113371B1934"] == 0) {
        break;
      } else {
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-10592, -19208, -360), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-10648, -19344, -360), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-10784, -19344, -360), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-10736, -19224, -360), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-9832, -19736, -280), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-9888, -19872, -280), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-10024, -19872, -280), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-9976, -19752, -280), (0, 216, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-9282.86, -21761.1, -280), (0, 180, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-9186.86, -21665.1, -280), (0, 180, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-9178.86, -21881.1, -280), (0, 180, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_91AE1DBDEB1987AB78370B47579851F9E8F0340723C15B534F0D03C77B302A", (-9058.86, -21761.1, -280), (0, 180, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22304, -27056, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22424, -27032, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22320, -27176, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22448, -27144, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-21800, -27744, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-21784, -27624, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-21904, -27600, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-21928, -27712, -139.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22576, -26592, -131.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22592, -26712, -131.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22696, -26568, -131.501), (0, 30, 0));
        var_0[var_0.size] = scripts\mp\spawnlogic::init_trap_room_doors("_encstr_85541B3F6928F2F7811B723EB320172A13F3DF7F17E5DACAA3662D85C9", (-22720, -26680, -131.501), (0, 30, 0));
        break;
      }
  }

  if(var_0.size > 0)
    scripts\mp\spawnlogic::bdiedonce(var_0);
}