/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_wallco2\mp_m_wallco2.gsc
*************************************************/

main() {
  _encstr_BDC3376EB19CD207A33797AD8379AD851CE6E5AD837D6BBEDDC2D8B1C6F6C8BCADE0FA6BEBEE2C1B1B1BBD91FAC193596C851B4359E29D37B1::main();
  _encstr_871D369B1BC996388E9BE55B0779B6C21CE6795B07FAB6D7EE58D8D8C6F6647976AC37F2D6077D5BF5DD2C361BD8B746F5B09C1D8B9DB96C::main();
  _encstr_93B531573F930338B41A2878C2C7984F0BD777E38BA9D979EFF648502E7FBAD0B2431F1B9F7397281C4E50A3D95EA098CA27DF::main();
  _encstr_96B1377B4E732031F30BA72D7B922560EB9B3E2508612D9063B7A03188E0A745F16F571D67EC030C6998E70ADF289A5F736B23052A5267535F::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_AA3319FF471D69C8783B17D531085E88AB5FE92167F8F282FEB7EA", "_encstr_AA82235B7F91BFBE87E8F323387E82D3FF0836FE769F3102CE6A0B21755143EF84B1FB7082");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread monitor();
}

monitor() {
  level._id_13DEE = getEnt("_encstr_91B810A2CED9A29C5D1BB619BA8D8D34EDD8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13DEF = getEnt("_encstr_85D90CD069349B55E87DECCD7D18", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13DF0 = getEnt("_encstr_849E14D920AF7BCA879EA8A9607BEBD8F959B828CA3A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13DF0 linkTo(level._id_13DEF);
  level._id_13DF1 = getEnt("_encstr_8FD10D15B3EC44B7BDC949B4D934E8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13DF2 = getEnt("_encstr_963715A5CA04732EAB09AFE8DF1F73262A9733289D3DE8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level._id_13DF2 linkTo(level._id_13DF1);
  level.molotov_trigger_timeout = getEnt("_encstr_820E0748ECD055DA58", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.molotovrecentlyused = getEntArray("_encstr_BE5B097537173AD25DC193", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.molotovrecentlyused)
  var_1 hide();

  level.clear_padding_disables = getEntArray("_encstr_91C80851ECB3482B2CE4", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_4 in level.clear_padding_disables)
  var_4 hide();

  thread molotov_store_branch_ents("_encstr_ACFC092840B7E6E7415E51");
}

molotov_store_branch_ents(var_0) {
  var_1 = getEnt(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 show();
  var_1 setCanDamage(1);
  var_1 waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
  var_1 hide();

  if(isDefined(var_1.target))
    molotov_store_branch_ents(var_1.target);
  else
    monitor_enemy_death();
}

monitor_enemy_death() {
  scripts\engine\utility::exploder("_encstr_A37E0AD82C6EA3D79CB71B8D");
  thread _id_13295();

  foreach(var_1 in level.molotovrecentlyused)
  var_1 show();

  level.molotov_trigger_timeout hide();
  level._id_13DEE hide();
  level._id_13DEE connectpaths();
  level._id_13DEF rotateby((0, -230, 0), 0.5, 0, 0);
  wait 0.05;
  level._id_13DF1 rotateby((0, 270, 0), 0.45, 0, 0);
  wait 0.45;
  level._id_13DEF rotateby((0, 30, 0), 1.5, 0, 0.5);
  level._id_13DF1 rotateby((0, -20, 0), 1, 0, 0.25);
}

_id_13295() {
  thread scripts\engine\utility::play_sound_in_space("_encstr_998319D32E50E74B53E8424A08D707C7AE0D5A6DB6989F1559886A", (-301, -42, 186));
  thread scripts\engine\utility::play_sound_in_space("_encstr_8BA3112DCB83CF2F48C5DC19FFD7639BB6EF92", (-124, 2, 222));
  wait 1;
  thread scripts\engine\utility::play_loopsound_in_space("_encstr_869013658D936F41A10FA0C8D7CCB847FA73F05772", (-101, 9, 234));
  thread scripts\engine\utility::play_loopsound_in_space("_encstr_A59013A2AD145903305312105FB95729EADBCEFF03", (-165, -6, 223));
  thread scripts\engine\utility::play_loopsound_in_space("_encstr_95CA136FB9E017F8A71FD260797F0A469AF8F19846", (-273, -66, 176));
  thread scripts\engine\utility::play_loopsound_in_space("_encstr_B4CA134B37C32810E0CED3C8B5DD50601A2B4769D2", (-287, -3, 176));
}