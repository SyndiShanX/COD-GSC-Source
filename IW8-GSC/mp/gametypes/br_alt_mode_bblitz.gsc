/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_bblitz.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_888E17E6D8E47D13937D85C63A7DDADB91B27D3113B1D2A34F", 0)) {
    return;
  }
  level.clear_cypher_icon = 0;
  level.clear_and_give_killstreak_loadout_assault = getdvarint("_encstr_A35B1C8F8706C95AA0C67E059BF16D02D513B7336DA1120488AEF7CDD180", 3);
  level thread impactfunc_null();
}

impactfunc_null() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = getarraykeys(level.teamdata);

  foreach(var_2 in var_0)
  level.teamdata[var_2]["_encstr_A2440E3189B14B3AA786EDBA371DCAE4"] = 0;

  if(!getdvarint("_encstr_A699261B42BBC078FA3F9B893CE958908B5A16A1FA7B03A310278799450BD8681F426E09C2B74E80", 1)) {
    return;
  }
  for(;;) {
    wait 1;
    var_4 = (0, 0, 0);

    if(isDefined(level.br_circle)) {
      var_5 = level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective - 1;
      var_4 = level.br_level.default_class_chosen[var_5];
    }

    if(!_encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::outofboundstriggersplanetrace(var_4)) {
      break;
    }
  }

  clear_cypher_icon();
}

clear_cypher_icon() {
  if(level.clear_cypher_icon) {
    return;
  }
  level.clear_cypher_icon = 1;

  foreach(var_2, var_1 in level.teamdata)
  clear_bomb_vest_controller_holder(var_2, -1);

  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_8FFA13F3E896E2A2513B8B9E08573ABD5BC04FDF60");
}

clear_all_remaining(var_0) {
  if(!getdvarint("_encstr_888E17E6D8E47D13937D85C63A7DDADB91B27D3113B1D2A34F", 0))
    return 0;

  if(level.clear_cypher_icon)
    return 0;

  var_1 = var_0.team;

  if(!isDefined(var_1))
    return 0;

  var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_A2440E3189B14B3AA786EDBA371DCAE4") + 1;
  clear_bomb_vest_controller_holder(var_1, var_2);

  if(var_2 == level.clear_and_give_killstreak_loadout_assault) {
    clear_bomb_vest_controller_holder(var_1, 0);

    if(getdvarint("_encstr_8C402398329AB741DB47AF114447E88F473A8198BAB5135B035FA69826AF9041EE93B868D2", 1) && !_encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::outofboundstriggersplanetrace(var_0.origin)) {
      thread clear_and_give_killstreak_loadout_demo(var_0);
      return var_2;
    }

    var_3 = spawnStruct();
    var_3.ml_p3_to_safehouse_transition = 0;
    var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_3, var_0.origin, (0, 0, 0), undefined, 0, 0, 35);
    var_5 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup("_encstr_845B1F61B25C48807B3F8D898F3257E8E10D2B19D8AC784F22FBFFB1F7AA91E894", var_4, 0, 1);
  }

  return var_2;
}

clear_bomb_vest_controller_holder(var_0, var_1) {
  scripts\mp\utility\teams::setteamdata(var_0, "_encstr_A2440E3189B14B3AA786EDBA371DCAE4", var_1);

  foreach(var_3 in scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B"))
  var_3 setclientomnvar("_encstr_B1D80DDFDBA8227201B976FDF070B2", var_1);
}

clear_and_give_killstreak_loadout_support() {
  return getdvarfloat("_encstr_8CAD2BA770232F529DD0DE95AD1F7AD749F89F7B1098417BA5C8A2CF1F2DD268F69893FF28118CF1CF772FC7F5", 0.0);
}

clear_and_give_killstreak_loadout_recon() {
  return getdvarfloat("_encstr_8BEE2723AA300EDA184F2E71210740EF08F19788461871B3F85933798ADD72F3AFE0BBAD69A1DAEDB5", 120.0);
}

clear_and_give_killstreak_loadout_demo(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_3 in var_1)
  var_3 scripts\mp\utility\lower_message::_id_1316E("_encstr_A77C1BAA1837DE4F13C7031BEB98CF23E358F2F1803FD33FEB3C1D14FE", undefined, 5);

  var_5 = "_encstr_B2CB2AF0B38D9C905AD31FD5634FB9A5F1B28D7BE44D0AB8EF58B7C54B9961C6AEB91DB150DD0FAFE856BAAB";
  var_6 = [];
  var_6[var_6.size] = registerscriptedspawnpoints("_encstr_AC20072B9FA9487832", 3, 4, var_5);
  var_6[var_6.size] = "_encstr_91591A4CE463DE7BA3AF9B57C12BE4AFB6AB734B3A4BB7379B31DB3C";
  var_6[var_6.size] = "_encstr_92F81B10027A5DFF8D48031265389DF07DF0C208EB9CEF816399B72926";
  var_7 = spawnStruct();
  var_7.origin = var_0.origin;
  var_7.angles = var_0.angles;
  var_7.itemsdropped = 0;
  var_7 _encstr_AD8826DA61D6104B139FC638B11E4FFBD81533CB10979E651EB5412A3F700DC1FF6FB0580802461F::_id_11A42(var_6, 0);
}