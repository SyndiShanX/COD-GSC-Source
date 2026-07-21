/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\pvpve\pvpve.gsc
***********************************************/

init_pvpve() {
  level.dogtag_revive = 1;
  setup_play_test_name_to_team_id_mapping();
}

getassignedspawnpointbasedonteam(var_0) {
  var_1 = get_spawn_point_targetname(var_0);
  var_2 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2[var_0.slot_number];
  return var_3;
}

get_spawn_point_targetname(var_0) {
  switch (var_0.team_number) {
    case 0:
      return "_encstr_8FD40D6A58DBAEC0665BD54160A611";
    case 1:
      return "_encstr_A1D40DE0EC0EECACAF3AAC16B5F590";
    case 2:
      return "_encstr_93D40DC07DFB0339F9B8A1419D3E5E";
    case 3:
      return "_encstr_ABD40DA07C3036BB8E29077E858FA5";
    default:
  }
}

initialize_player_team_slot_assignment() {
  level.team_id_slot_index_list = [];
  level.team_id_num_slot_filled = [];

  for(var_0 = 0; var_0 < 4; var_0++)
    level.team_id_slot_index_list[level.team_id_slot_index_list.size] = make_randomized_slot_index_list();

  for(var_1 = 0; var_1 < 4; var_1++)
    level.team_id_num_slot_filled[var_1] = 0;
}

get_available_slot_index_for_team_id(var_0) {}

make_randomized_slot_index_list() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0[var_0.size] = var_1;

  for(var_2 = 0; var_2 < 5; var_2++)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  return var_0;
}

pvpve_enabled() {
  return getdvarint("_encstr_8C480D8A106F6BFDC04F8876E9A047", 0) != 0;
}

setup_play_test_name_to_team_id_mapping() {
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"] = [];
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8183089830E36FFFC686")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8D9E1025D5F52985DAB237BE0D0D2BB9FA64")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AAF30C4F019749C3EF3FF841588B")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_93840E25EA358263AF29AE8DA5598E26")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8AEF0C94BA9A05D8FAA5D236ED4C")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B2C30C998F9DC7A531ED031AFF8F")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A9410D4ABA6A826C7D12BD1D563613")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AF3508F904C5EB2B1F12")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A93508137F560FF50172")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8C3508A4EA86148DF599")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AD650DE914E0019FFF514E01BB9BFA")] = 2;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8BC10C29CF0972B2C0DD4A02600F")] = 2;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_84BB0F91A98D412397B3C34F7AA330E37A")] = 2;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8E8B0D1F97913106D16FC54DA178C9")] = 2;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AF560D9357AD79EC8F188BB1C20327")] = 3;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B4C40CFCA1E7E77A11907B51C9D2")] = 3;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B13508106C9881632F42")] = 3;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_9B1F0F235478CF13BE035F9A619A6F3CB2")] = 3;
}