/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_blueprint_extract_spawn.gsc
*******************************************************/

init() {
  level.control_room_button = undefined;
  level.contract_death_cash_flag = undefined;
  level.contributingplayers = undefined;

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52") {
    level.control_room_button = getdvarfloat("_encstr_9A6F1EE33EC3F71E59D0226BF08BD593DE157572584857A009B85BB040D9CE5B", 4);
    level.contract_death_cash_flag = getdvarfloat("_encstr_822E1DB673DBFEDD05732BB01B1C8DD3171C31AAF737C0236D3A082942B243", 0.02);
    level.contributingplayers = getdvarfloat("_encstr_BDBE243736C9F5C4C6D5AC1C4E2D37A3FA8CB5E9D71BD00BDC6CB20A564ED0F69BE89CC236A3", 0.0);
  } else {
    level.control_room_button = getdvarfloat("_encstr_A6061D5B01560FEE186BEDE07DE8356B6899C301A8A7CB2A788DCDF959D0FC", 4);
    level.contract_death_cash_flag = getdvarfloat("_encstr_92331C878F7EB122589B773A535866BB40251BBF77AB9A1678E1A6466BC0", 0.02);
    level.contributingplayers = getdvarfloat("_encstr_AF1F23BB768BBF266118FAA308431DAB866E221F9E108F6D27E0B1CA10EF958B9BCEB9DBAD", 0.0);
  }

  level.convoy4_module_snipers = 0;
  level.convoy4_failed_extract = level.contract_death_cash_flag;
  level.control_station = undefined;
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B33("_encstr_845B1F61B25C48807B3F8D898F3257E8E10D2B19D8AC784F22FBFFB1F7AA91E894", ::controls_unlink_safe);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12B33("_encstr_BDAA2BBE124A5768F4076008B73D43A5A2BD2DB5E8A33591CB4381C0CF5298339B692DCF827BD3BBB573A828E3", ::controls_linkto_safe);
}

convoy4_actively_hacking(var_0, var_1) {
  if(!convert_remaining_to_ai(var_0, var_1))
    return undefined;

  if(level.convoy4_module_snipers >= level.control_room_button)
    return undefined;

  var_2 = randomfloat(1);

  if(var_2 <= level.convoy4_failed_extract) {
    level.convoy4_module_snipers = level.convoy4_module_snipers + 1;
    return "_encstr_845B1F61B25C48807B3F8D898F3257E8E10D2B19D8AC784F22FBFFB1F7AA91E894";
  } else {
    level.convoy4_failed_extract = level.convoy4_failed_extract + level.contributingplayers;
    return undefined;
  }
}

convert_remaining_to_ai(var_0, var_1) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::turret_headicon())
    return 0;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled())
    return 0;

  if(istrue(level.convoy_handle_stuck_compromise))
    return 0;

  if(isDefined(var_1) && var_1 == "_encstr_969713904BDFF0B373B9DFE50F7BA9DE4B9F10B87F")
    return 0;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.circleindex) && isDefined(level.br_level) && isDefined(level.br_level.br_circleclosetimes)) {
    var_2 = level.br_circle.circleindex;
    var_3 = level.br_level.br_circleclosetimes.size - 1;

    if(var_3 - var_2 < 4)
      return 0;
  }

  if(!_encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::outofboundstriggersplanetrace(var_0))
    return 0;

  return 1;
}

control_station_interact(var_0, var_1) {
  level.control_station = var_0;
  level.control_room_button_green = var_1;
}

add_neurotoxin_damage_area(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::risk_flagspawndebugobjicons(var_0);
  controlslinked(var_1);
  thread controlledcallbacksqueue();
  thread controlledcallbacks();
}

controls_unlink_safe() {
  var_0 = scripts\engine\utility::ter_op(getdvarint("_encstr_888E17E6D8E47D13937D85C63A7DDADB91B27D3113B1D2A34F", 0), 2, 0);
  add_neurotoxin_damage_area(var_0);
}

controls_linkto_safe() {
  add_neurotoxin_damage_area(1);
}

controlslinked(var_0) {
  var_1 = _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::riotshield_init_cp(var_0);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_119F5(self, var_1);
  self.overwatch_soldiers_05_bombers = var_0;
}

controlledcallbacksqueue() {
  var_0 = level.control_station;
  level.control_station = undefined;
  var_1 = level.control_room_button_green;
  level.control_room_button_green = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1) && istrue(var_1._id_11FF8)) {
    return;
  }
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_2 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0), "_encstr_85952BDB33375AE07E886BD7D891B8022BD8A3D9ABF7B23686A87B6358C9635BEBE0ED41B71D5A4529C83763C8");
    scripts\mp\objidpoolmanager::objective_set_play_intro(var_2, 1);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);

    foreach(var_4 in scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B")) {
      if(!var_4 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag())
        objective_addclienttomask(var_2, var_4);
    }
  }

  var_6 = gettime();

  while(isDefined(self) && gettime() - var_6 < 15000) {
    var_7 = self.origin + (0, 0, 10);
    scripts\mp\objidpoolmanager::update_objective_position(var_2, var_7);
    waitframe();
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);
  scripts\mp\objidpoolmanager::returnobjectiveid(var_2);
}

controlledcallbacks() {
  while(isDefined(self)) {
    if(!_encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::outofboundstriggersplanetrace(self.origin)) {
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::lastgoodjobplayer();
      return;
    }

    waitframe();
  }
}