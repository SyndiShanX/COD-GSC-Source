/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gametype_truckwar.gsc
*************************************************/

init() {
  level thread enemy_claymore_watchfortrigger();
  level thread enemy_clear_scrambler();
  level thread enemy_aggro_at_closest_player();
  level thread enemy_ai_enter_alert_due_to_grenade_explode();
  level.checkpoint_objective_id = getdvarint("_encstr_91C21C68C26A4771B772A0A755FBD8E5176BE870FB051FE97F842DAB55C7", 20);
  level._id_12CB4 = getdvarint("_encstr_83AB1DD6662AD974289387420AC080CF3B250F8158526D5961F8CF0273E017", 0);
  level.dialog_wait_ready_civ = 0;
  level._id_13ECD = getdvarint("_encstr_82C11A336A93F8F0D23D87EF477E88A08F62ABB9022739F0EB0995FF", 1) == 1;
  level._id_13ED1 = getdvarint("_encstr_A66323833760212BC6AB3AA2F397FBE9E0BF0D3C43A8F617E163308A7BFEDBDF39139A65C7", 1) == 1;
  level._id_13EC3 = 15;
  var_0 = getDvar("_encstr_936D20E68D39F53AE457D86DEE58C9BEB14B27D88D954D4BF459F4672B27C9B42359", "_encstr_8BBC2CB730F6F3593246EAC20F6A117946A8BEAFF85AAB61DA2FC25A6783C9C3222087275042A389A317BAE28EBA");

  if(var_0 != "_encstr_B40101") {
    level._id_13ECF = [];
    var_1 = strtok(var_0, "_encstr_974C0246");

    foreach(var_3 in var_1)
    level._id_13ECF[level._id_13ECF.size] = float(var_3);
  }

  var_5 = getDvar("_encstr_8A6725DCD893F547E4BAD8B6EEB0E47D8D5A4E8DB1AC1A36DBDC5645A5B656A79DB293E44B91B2", "_encstr_95721CD3E7529F1A0AB039135F5252DFFE2F19EBFF6A4D42A6ADE129653A");

  if(var_5 != "_encstr_B40101") {
    level._id_13EC2 = [];
    var_6 = strtok(var_5, "_encstr_974C0246");

    foreach(var_3 in var_6)
    level._id_13EC2[level._id_13EC2.size] = float(var_3);
  }

  var_9 = getDvar("_encstr_92C925CD6C39FAD139AB8D6DBBC227AF36B439D8632B8859362CF2A82D5B56F4ECCA9CC9D223AC", "_encstr_99C719641906109C060473D4108D81808D60400D6A106660804618");

  if(var_9 != "_encstr_B40101") {
    level._id_13EC7 = [];
    var_10 = strtok(var_9, "_encstr_974C0246");

    foreach(var_3 in var_10)
    level._id_13EC7[level._id_13EC7.size] = float(var_3);
  }

  level._id_13ED0 = getdvarfloat("_encstr_A9DB1FDAB6EDF9645BB0AF8788113AA1A7DBE256A97BF1ACC190CB7B40E9E9CB5F", 50000);
  level._id_13ECA = getdvarfloat("_encstr_85031D9B1B93D7E893D5B1B5778593FA6C4BE41B1B952973DC594E9AD2D359", 40000);
  level._id_13ECB = getdvarfloat("_encstr_953A1B2328860F094B0BAFA83321931ED148B293506AC01B68EFD30D68", 10000);
  level._id_13EBF = getdvarfloat("_encstr_935F209BD827D78E9CABB16DEE58C9BE8DB4391B1B591AD8DEB9CA6AA537A296AD59", 30);
  level._id_13EC0 = getdvarfloat("_encstr_88B31D786F923631F393760A6BBA457EEBDFF840FB5D4DC90A3A7D9DC452A3", 220);
  level._id_13EC1 = getdvarfloat("_encstr_868123B3E9BEF7939373C3C35FB05AAF6EC0DB3A909D4F4D1067FDE41B88A717037992E219", 40);
  level._id_13EC5 = getdvarfloat("_encstr_BE641D679FD65883A81B5EF76B181A8780600A6EDC57F96DB3BA68A3C8DADD", 60);
  level._id_13EC6 = getdvarfloat("_encstr_B2E1239B3693BE8E4EEA8DD6DDB039F51B96C98D8D9511AC8D58E58AB4D6560DA1B073B3AC", 10);
  level._id_13EC4 = getdvarfloat("_encstr_AADB20BF323BE99452B361F82378021689ABF6F0584D2D233A11D333F305EB6FA5E5", 10);
  level._id_13ECE = getdvarint("_encstr_ACE7261AE2B329308E9050181FDF03B7C3D9C30779BFC1838B04EF6D4DC3689113CFCFD02DE0221C", 1);
  level._id_13EC9 = getdvarfloat("_encstr_AADC24BF323BE99452B361F82378021689ABF6F0584D8C356AB3DB6BF98F2F7BA9EB5F7B6022", 60);
  level._id_13EC8 = getdvarfloat("_encstr_A56424E68D93D7E8275736B6DDC293EB8D2D931B8D954ADCD2E8B40B360D63B7B956A24B6B59", 330);
  level._id_13ECC = getdvarfloat("_encstr_A9981CDE0BA38699EA2B98D0E3C64D5E4FB9E65E6C878CE7D33259D89BDB", 1);

  if(level._id_13ECD) {
    setDvar("_encstr_84A31DE356E269A6BBDF736F6352F8E0B72E285BFE5460F02233637D63BA35", 1);
    level.decoyassists = ::brmini_initdialog;
  }

  level stoppingpower_givehcrdata();
}

enemy_claymore_watchfortrigger() {
  if(getdvarint("_encstr_8DBF12E66C27BE4C27A339ABD8B67D3256985DCE", 0) == 1) {
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_A78F076CA54E1B1B56");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_BDC6085DF29A892901C7");
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_B603110FA57A675BFC2FA3B0BBE750AD32CAFE");
  }

  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B220634456A5747");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_ADF20D88BB7DC8C9AA6A4653C3822F");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_9B0C0EEC59D0A5D8B1B2353885BBE6B9");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::load_sequence_3_vfx("_encstr_86980E2ED36AC0E9D1236347510B52CD");
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::move_molotov_mortar("_encstr_8CE50ED185C48D59A325B238360B36AC");
}

enemy_clear_scrambler() {
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8A38163B98D17952EDA44F0596EFEA2D3FE0C30708A8DDFB", ::enemy_goto_struct_on_spawn);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_841310FF4D098B1FA62BD8A2107583806833", ::onstartgametype);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8106123B24BF78D3DBDC083511D5719BA1AE6345", ::_id_125F7);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_8F351F39D6AB5F8FECFFB840AB1923CBF27CA1B36DF23911CCAF0839EF5C98339A", ::_id_11B16);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_BADF16AD165ED0F6B99B96C895E40A3616CBB2E488AC5846", ::_id_11B80);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_A613112B8BE3D85F5FB050F81A6780A083F549", ::validate_and_activate_stations);
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12B11("_encstr_97670EEB0EFB48B1BA22F028DA0D6701", ::manage_fakebody_hides);
  waittillframeend;
  scripts\mp\flags::gameflaginit("_encstr_95891233AB8F29F50393D1D8596B251062118F8D", 0);
  level.ontimelimit = ::enemy_fallback_logic;
  level._id_11C7A = ::_id_125F7;
  enemies_validate_life();
  level._id_140D9 = [];
  level._id_140D9[0] = "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0";
  level._id_140D9[1] = "_encstr_A1580B19DE5B5A9B0BA35AEDCD";
  level._id_140D9[2] = "_encstr_AF460A7B2649F34FE367455D";
  level._id_1385F = 0;

  if(level._id_13ECD)
    level thread enemy_damage_monitoring();

  thread _id_13DF8();
}

enemy_aggro_at_closest_player() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_970E16454B71B5C0F18D704979D1B07B9B4F3BD1BF8B8D70");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BAB3151BD3A8D4F3384D79E0D8D85F2E3F99F588AFEE27"] = "_encstr_8896278E27BAD85BEE16939BF50BE4D6B727B223AFEC2B349636D859F5BACD322B39AF858E1DB0D8AD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A62A17CBE589CA03E8400FB783A1EF420F8D94025FC5D24DB1"] = "_encstr_B4F029E8C9578DD6778593B9FAC2935BDE93568CEBB3CA0DB4D8B1CAEB378316BBB9D7C82DB9C24C1BAC8C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD17167DC8DC78A6ED89E64BB04E303DFF452D735B7A9BF0"] = "_encstr_A5D4288EE4EAC6AD771627E67D16275B7B935991BED9CAD0B41BD856F537C1C2DD73D72BDC5826C65932";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A97712255F4A7BC8B4870E61AF73A82ED2D78B99"] = "_encstr_99BC2221DEC58FDCF702DB7757DFBD33BFFB3836B2425872E93021E1EAA0FBD23FF883A3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE6B131C3D989830516526C8B890CFD5618FAE997A"] = "_encstr_84E722B0DB6561DF73A6CE56319A03ABD923F8A0071EF991BACEC9551993531310C79870";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_877D0B2A571C2BC8BC30ADB875"] = "_encstr_B605208522EB7FD8C72F309BEFE1B099438DE887BAC2DFA3BD535120EF0868EFCAB7";
}

enemies_validate_life() {
  scripts\cp_mp\utility\game_utility::_id_12C10("_encstr_A7EE0FE3BB593A1C48B68DD5AE585F3225", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_920D1AA7081FE397C3407F2F90385F3AD3112D91E1A33BF12841672B", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_B49F18FD153A2D2EB707C88837F6666162FDE571E1F2F116D816", 1);
  scripts\cp_mp\utility\game_utility::_id_12C11("_encstr_99291CC83F37405922F7696D37AA17D09F5630E22963800E1AF7912F6AD7", 1);
}

enemy_ai_enter_alert_due_to_grenade_explode() {
  level._effect["_encstr_AF2110A4732963A30710BA42C02F9DFFA06D"] = loadfx("_encstr_8293303B69608F0A2CE1F73799F8D23128B0F20343D0896228450B9BDF7D3A7EA83EAF0A98D05F6AD47F0BA7AF2516BEA862");
}

onstartgametype() {
  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start))
    level.debug_vault_assault_retrieve_saw_obj_start = [];

  level.debug_vault_assault_retrieve_saw_obj_start[level.debug_vault_assault_retrieve_saw_obj_start.size] = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::init_safehouse_gunshop((-32000, 53750, 2266), 16000);
  initspawns();
  level thread trace_to_eye_weight();
  level thread _id_1338B();
}

enemy_goto_struct_on_spawn(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

  if(!istrue(self.pers["_encstr_BDA8133693AB43A9ED37B818EF1BA09B333DA53DAF"]))
    self waittill("_encstr_96DE0EC7C2820B1A5B27F650A30ACB57");

  wait 1;
  scripts\mp\hud_message::showsplash("_encstr_B4B526281BE98F69FF356DE318E796610AF3A898A3BE1DE6E34AFDD1E14BD901397B2B285A556B79");
  self waittill("_encstr_97FC14C8B7EB77CA8D6CB76BACF5B91C8D85DC3459CD");
  wait 2;
  scripts\mp\hud_message::showsplash("_encstr_B8911D894ED7CE58D6CA47BC0756BE47E4AEC6DABB58C9AFDDCAD836BD6B59");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_877D0B2A571C2BC8BC30ADB875", self, 0);

  while(!self isonground())
    waitframe();

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detachriotshield(self);
}

enemy_fallback_logic() {
  if(isDefined(level.numendgame))
    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::startendgame(1);

  level.numendgame = undefined;
}

_id_11B80(var_0) {
  return 1;
}

_id_11B16() {
  return 1;
}

vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.showheadicon = 1;
  return var_1;
}

registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();
  level.vehicleinfo[var_0] = var_3;
}

vehiclespawn_littlebird(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", var_2, var_1);
}

_id_14266(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_2, var_1);
}

vehiclespawn_jeep(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_85DE05A6B2AC0E", var_2, var_1);
}

_id_14263(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B", var_2, var_1);
}

vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", var_2, var_1);
}

vehiclespawn_tacrover(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A120A1D8536F5E4ED3BB293", var_2, var_1);
}

_id_14267(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_99C20BA548E9F27A61D897932B", var_2, var_1);
}

trace_to_eye_weight() {
  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  if(getdvarint("_encstr_AF0121C8DF22A68B82258094F17BDB089167B8E0C7CBB9651A8D901D92A31FD0FF3758", 1) == 1)
    registervehicletype("_encstr_BAC20FBEE6F88945F163A37BD68409923B", _calloutmarkerping_isdropcrate::get_health_multiplier_relic_mythic, ::_id_14263);

  if(getdvarint("_encstr_91E61EB96CE47D168D8D7BDDBECEB21AD236362BD78D2D47A31BCAFA4C2D4EC8", 1) == 1)
    registervehicletype("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", scripts\cp_mp\vehicles\little_bird::little_bird_getspawnstructscallback, ::vehiclespawn_littlebird);

  if(getdvarint("_encstr_8E2421DCD8E4FAC236C6F6BB7DD9B21A5A6CB1CAFA635AE83AD8B2D7132D93C8BE5BCE", 1) == 1)
    registervehicletype("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", _calloutmarkerping_poolidisdanger::x1stash_detectplayers, ::_id_14266);

  if(getdvarint("_encstr_A1C2169E4BE3C6F32DFA38F0A1C3A37827F3A91D9F576B15", 1) == 1)
    registervehicletype("_encstr_8C190467402B", scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, ::vehiclespawn_atv);

  if(getdvarint("_encstr_AA8D178EEE138F01449360A8777659394A16891D492AB3C920", 1) == 1)
    registervehicletype("_encstr_85DE05A6B2AC0E", scripts\cp_mp\vehicles\jeep::jeep_getspawnstructscallback, ::vehiclespawn_jeep);

  if(getdvarint("_encstr_82AC1C8231C807427991FFE78F1C4A784899FD8F2E10C1BAD885F7EBD3C6", 1) == 1)
    registervehicletype("_encstr_9A120A1D8536F5E4ED3BB293", scripts\cp_mp\vehicles\tac_rover::tac_rover_getspawnstructscallback, ::vehiclespawn_tacrover);

  if(getdvarint("_encstr_8FD01DCDB14EF5B0B1B1BDBBD73BCAA1A536C6CAD7DAF6A37B39D85E368DCA", 1) == 1)
    registervehicletype("_encstr_99C20BA548E9F27A61D897932B", _calloutmarkerping_poolidisentity::_id_11D5E, ::_id_14267);

  level waittill("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  wait 2.0;
}

cargo_truck_mg_reenter() {
  level.vehiclespawnlocs = [];
  level._id_13ACF = [];

  foreach(var_1 in level.vehicleinfo) {
    switch (var_1.refname) {
      case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
        var_1.vehiclespawns = run_spawn_module_till_kill_trig("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_B87B11439AA9512A79A760E17BE35A272F5FBF");
        break;
    }

    foreach(var_3 in var_1.vehiclespawns) {
      var_4 = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[var_4] = var_3;
      level.vehiclespawnlocs[var_4].refname = var_1.refname;
    }
  }

  _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::_id_13E0C(level.vehiclespawnlocs);

  if(0) {
    foreach(var_8 in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(var_8.origin, var_8.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);

  if(0) {
    for(var_10 = 0; var_10 < level.vehiclespawnlocs.size; var_10++) {
      var_8 = level.vehiclespawnlocs[var_10];
      thread scripts\mp\utility\debug::drawline(var_8.origin + (0, 0, 1500), var_8.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  var_11 = 0;

  foreach(var_13 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_13, "_encstr_9775086022BE1B413B8B").size == 0) {
      continue;
    }
    while(var_11 < level.vehiclespawnlocs.size) {
      var_8 = level.vehiclespawnlocs[var_11];

      if(isDefined(var_8)) {
        if(var_8.refname == "_encstr_BAC20FBEE6F88945F163A37BD68409923B") {
          level._id_13ACF[var_13] = var_8;
          var_11++;
          break;
        }
      }

      var_11++;
    }
  }

  scripts\mp\flags::gameflagset("_encstr_B1DD16DBEDBD326B601E32FAF168A6491E7F2743A9ED0B5D");
}

_id_136AA() {
  var_0 = [];

  foreach(var_5, var_2 in level._id_13ACF) {
    var_3 = level.vehicleinfo[var_2.refname];
    var_4 = [[var_3.spawncallback]](var_2);
    var_0[var_0.size] = var_4;
  }

  level._id_13ACE = var_0;
  var_6 = getdvarint("_encstr_8FD61FAAF0FB8748C35FD36DB06122687D4270E9F35B4048AFCD7AF79A48BBD8C3", 120);
  var_7 = var_6 - var_0.size;
  var_8 = 0;

  while(var_8 < level.vehiclespawnlocs.size && var_7 > 0) {
    var_2 = level.vehiclespawnlocs[var_8];

    if(isDefined(var_2)) {
      if(var_2.targetname == "_encstr_87D2116BDE47F627D85E6C6395AFE60EC2EEE6") {
        var_3 = level.vehicleinfo["_encstr_99C20BA548E9F27A61D897932B"];
        var_4 = [[var_3.spawncallback]](var_2);
        var_7--;
        var_8++;
        continue;
      }

      if(var_2.refname != "_encstr_BAC20FBEE6F88945F163A37BD68409923B") {
        var_3 = level.vehicleinfo[var_2.refname];
        var_4 = [[var_3.spawncallback]](var_2);
        var_7--;
      }
    }

    var_8++;
  }
}

cargo_truck_mg_removegunnerdamagemod() {
  var_0 = level._id_13ACE;
  level._id_13ACE = [];
  level._id_13AA7 = [];
  level._id_13ACD = [];
  var_1 = 0;

  foreach(var_3 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_3, "_encstr_9775086022BE1B413B8B").size == 0) {
      continue;
    }
    var_4 = var_0[var_1];
    thrownoffhand(var_4, var_3);
    var_1++;
  }
}

thrownoffhand(var_0, var_1, var_2) {
  level._id_13ACE[var_1] = var_0;
  level._id_13AA7[var_1] = 1;
  level thread _id_14505(var_0, var_1);
  level thread _id_14506(var_0, var_1);
  level thread _id_11ECF(var_0, var_1);
  level thread _id_11ED0(var_0, var_1);
  level thread _id_11ED1(var_0, var_1);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var_0, var_1);
  var_0 setscriptablepartstate("_encstr_9A2B0A12F03587575B7BBEA5", "_encstr_AB0703DBB9");
  var_3 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_5 in var_3) {
    var_5 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", var_0.health);
    var_5 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", var_0.maxhealth);

    if(istrue(var_2) && getdvarint("_encstr_87A327D71B537F63CD95EEE4FC937B37FB10472FE82EAABAE121769EEDA3C2DE4311C3BFD063F1C305", 1) == 1 && !istrue(level._id_13DF4)) {
      if(istrue(var_5.delay_enter_combat_after_investigating_grenade)) {
        var_5.setspawnpoint = undefined;
        var_5 thread playerrespawn(1);
      }
    }
  }

  _id_1402C(var_1);
}

_id_14505(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0._id_1441F = 0;
  var_0._id_14421 = 0;
  var_0._id_14420 = 0;
  var_2 = getdvarfloat("_encstr_AB2B1F6BDE7AF13533CFE7FFEF2A7EA90736136643D150E07ABBD78FC7A2C89BDD", 15.0);
  var_3 = getdvarfloat("_encstr_9ABB204BFE5AD11513EF879F8F4A5E89E7D6F34663B170C09A9BF7EFDFD2ADF0ADAD", 30.0);
  var_4 = getdvarfloat("_encstr_84ED1D23792E6703B0C35353AF40CA1FDC51BB69430F1B7DB0CD4F1F957812", 45.0);
  var_5 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_7 in var_5)
  var_7 scripts\engine\utility::ent_flag_init("_encstr_856017021FF2776133CDFF3331218B1193232F2F729941DF32");

  while(isDefined(var_0)) {
    if(istrue(var_0.stop_pressure_sensor)) {
      waitframe();
      continue;
    }

    if(istrue(level.group_unset_jugg_standstill)) {
      if(!var_0._id_1441F && getgamewinnerprop(var_0.origin, var_2)) {
        showsplashtoteam(var_1, "_encstr_92452EE552C920A7A75A8BD2F37F70705ACD6F4FFF2EF0E0A732631E4A0F08807220D5CF9116E833DB4AFE810227D668");
        var_0._id_1441F = 1;
        var_0._id_14421 = 1;
        var_0._id_14420 = 1;
      } else if(!var_0._id_14421 && getgamewinnerprop(var_0.origin, var_3)) {
        showsplashtoteam(var_1, "_encstr_A1AF2F65BE5124595A49DB07832877AB4A2BCE3297F07BA0AFDE6FF6CA3BEF1FDBF9A557A2A88C7B7E0A37ADFF985CFD05");
        var_0._id_14421 = 1;
        var_0._id_14420 = 1;
      } else if(!var_0._id_14420 && getgamewinnerprop(var_0.origin, var_4)) {
        showsplashtoteam(var_1, "_encstr_88F42C26C9FACEC2B5B2D1971C2BEB1D395DD85BEE854EF57616B97DD29B7D0B1C1C39F60B6C8696CD3BBECC5839");
        var_0._id_14420 = 1;
      }
    } else {
      var_0._id_1441F = 0;
      var_0._id_14421 = 0;
      var_0._id_14420 = 0;
    }

    var_9 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
    var_10 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
    var_11 = getdvarint("_encstr_8A841ADF5BAAC915E37371787B87CE1147BF2577C55930502F4A0963", 0) == 1;

    if(var_11 || distance2dsquared(var_9, var_0.origin) > var_10 * var_10) {
      var_0 thread midpos();

      if(level._id_13AA7[var_1] == 1) {
        level._id_13AA7[var_1] = 0;
        var_5 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

        foreach(var_7 in var_5)
        var_7 scripts\engine\utility::ent_flag_set("_encstr_856017021FF2776133CDFF3331218B1193232F2F729941DF32");

        showsplashtoteam(var_1, "_encstr_BD442C3127EB9D2CDA56E8CBC1597D3A275DB16DDDB0C97DD99534A5B11B56FACD38B0BBCDEB1996CD5889632B91");
        level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A62A17CBE589CA03E8400FB783A1EF420F8D94025FC5D24DB1", 0, var_5, undefined);
        level thread[[level.updategameevents]]();
      }
    } else if(level._id_13AA7[var_1] == 0) {
      var_0 notify("_encstr_B49411F36A9B8328354D9FD771DA015D03424B");
      var_0._id_128AD = 0;
      level._id_13AA7[var_1] = 1;
      var_5 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

      foreach(var_7 in var_5)
      var_7 scripts\engine\utility::ent_flag_clear("_encstr_856017021FF2776133CDFF3331218B1193232F2F729941DF32");

      showsplashtoteam(var_1, "_encstr_96382B369B18BFA7A8C9913BC037D6359B131FD01BBE18EF34EA84AAAF79BB2E602BE8C458CF2A3DE3261C6BF1");
      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BD17167DC8DC78A6ED89E64BB04E303DFF452D735B7A9BF0", 0, var_5, undefined);
      level thread[[level.updategameevents]]();
    }

    waitframe();
  }
}

midpos() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B49411F36A9B8328354D9FD771DA015D03424B");

  if(istrue(self._id_128AD)) {
    return;
  }
  self._id_128AD = 1;
  var_0 = getdvarfloat("_encstr_91911D4B1146FF9B187BFBCB47B822B7EC4972927911AF9958BBE3F709582A", 0.05);
  var_1 = self.maxhealth * var_0;

  while(isDefined(self)) {
    wait 1.0;
    self dodamage(var_1, self.origin, undefined, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");
  }
}

_id_14506(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0._id_120B3 = 0;
  var_2 = getdvarfloat("_encstr_8BA51E33AAA3CF2CD083D3189F2F3BF7B8F742977D6380EBD18FFB2BE5E287BB", 15.0);
  var_3 = getdvarfloat("_encstr_84681B82CF8BCF1B5E4BEECF5BF89AB715A83E0F286B6120BF65C161C7", 5.0);
  var_4 = var_0.isempty;
  var_5 = 0;
  var_6 = undefined;

  for(;;) {
    if(!var_4 && var_0.isempty)
      var_6 = gettime() + var_2 * 1000;

    var_4 = var_0.isempty;

    if(isDefined(var_6) && gettime() < var_6 || var_5) {
      var_7 = 0;
      var_8 = undefined;

      foreach(var_10 in level.outofboundstriggers) {
        if(var_0 istouching(var_10)) {
          var_0._id_120B3 = var_0._id_120B3 + level.framedurationseconds;
          var_7 = 1;
          var_8 = var_10;
          break;
        }
      }

      var_5 = var_7;

      if(!var_7)
        var_0._id_120B3 = var_0._id_120B3 - level.framedurationseconds;

      var_0._id_120B3 = clamp(var_0._id_120B3, 0, var_3);

      if(var_0._id_120B3 == var_3)
        var_0 dodamage(999999, var_0.origin, var_8, var_8, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3");
    }

    waitframe();
  }
}

_id_11ECF(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = getdvarfloat("_encstr_BD4721B9364E7D8EE457C65BDD58C9AF4658B62C9DB27DD185ADB2B9AFDD967391B7BB", 5.0) * 1000;
  var_3 = undefined;

  while(isDefined(var_0)) {
    var_0 waittill("_encstr_B2310D943398AE674DEE4B0270958B", var_4);
    var_0.lastdamagedtime = gettime();
    var_0 thread connected_search_node(var_1);
    var_5 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

    foreach(var_7 in var_5) {
      var_7 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", var_0.health);
      var_7 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", var_0.maxhealth);
    }

    if(var_4.meansofdeath == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3") {
      continue;
    }
    if(isDefined(var_3) && var_3 + var_2 > gettime()) {
      continue;
    }
    var_3 = gettime();
    var_5 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");
    showsplashtoteam(var_1, "_encstr_92D32A5DEA41A83F3FD2F35A6BF7F8E8A245E7C777B648686BCA8840628BADF9BBA661431A9128C50BA2E108");
    level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BAB3151BD3A8D4F3384D79E0D8D85F2E3F99F588AFEE27", 0, var_5, undefined);

    foreach(var_7 in var_5) {
      if(!istrue(var_7._id_13DF3)) {
        var_10 = game["_encstr_813F06832D8A18FE"]["_encstr_835E12D9CAAF3BAD931244B77295ADF781B00A89"].size;
        var_11 = randomint(var_10);
        var_7 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_835E12D9CAAF3BAD931244B77295ADF781B00A89"][var_11]);
        var_7._id_13DF3 = 1;
      }
    }
  }
}

connected_search_node(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_B8CF0D31994FEF6A64BAFF60420B8C");
  self endon("_encstr_B8CF0D31994FEF6A64BAFF60420B8C");
  self.showquestobjicontoplayer = 1;
  _id_1402C(var_0);
  var_1 = getdvarfloat("_encstr_B2AF220E512049EC7E1386336B1B0216508B988EEFC6C858A9055102A509383CC5E8A305", 15.0);
  wait(var_1);
  self.showquestobjicontoplayer = 0;
  _id_1402C(var_0);
}

_id_11ED1(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(isDefined(var_0)) {
    var_0 waittill("_encstr_829110FBAB98D28AA55BF737B3D653397091", var_2);

    if(var_2 != "_encstr_8EAF11EB3877BA03B238F1E5C9981703B76872") {
      var_3 = rotatetowithpause(var_2);
      showsplashtoteam(var_1, var_3);
    }

    _id_1402C(var_1);
  }
}

rotatetowithpause(var_0) {
  switch (var_0) {
    case "_encstr_9A5C0FE613B3185B619883F4F6C1731A3D":
      return "_encstr_A1D52CC4E4EBCE2CB6B28E97C156D78E27AB36B5DD2C937D3B2B862DC636CAF58539B57B39FA57073B270B8CACC8";
    case "_encstr_AFDA114793F6831AF27D168DA32D3B0BD1AC23":
      return "_encstr_96932E31C97D3B855BAC1D5E38597DE84E5D36D6BBB04EBE3BACA1B46CD8ACD7E84EDBC186CBFA0B1BE84B9D2CE85632";
    case "_encstr_92CC0EC5392869C9B611EB63D8A3FA3C":
      return "_encstr_9BFC36638B710F6B4D2DAB88E0DF77812B75AA483C892259A06AA2035EE09150E9C74A65B932BAD15FAAD2D3B968CE28378B9C48C87128DD";
    case "_encstr_88AB11564E1A6B3BE8A79FB73449DB032C274D":
      return "_encstr_91412D3276A6D71E9B1073BBA0D3D9D3BB5DBBA30C895BA98578BAB210298FC7D1CF1232AD70A7EB7150630AD00387";
    case "_encstr_ABF40FA3E09808FA7328154D306B62AD20":
      return "_encstr_88BF2CFAFBE9779FA0C1C830A1319FBC559B8E8F8FDBF5694CE013278A499A0FBB5D22D241384710E85E08D83898";
    case "_encstr_8891134727DE831AE57D85B65BEDFAE42B33D263D8":
      return "_encstr_83AA2D5EEE075A7128EFAC805B70F9459BE3FFBFA8927A594598F98277E017A9401BAD23F363C793D270E2ED69F7E1";
  }
}

_id_11ED0(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_4 in var_2)
  var_4 scripts\engine\utility::ent_flag_init("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2");

  var_0 waittill("_encstr_AD75063D571AE108");
  level._id_13AA7[var_1] = 0;
  var_2 = scripts\mp\utility\teams::getteamdata(var_1, "_encstr_9775086022BE1B413B8B");

  foreach(var_4 in var_2) {
    var_4 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", 0);
    var_4 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", 1);
    var_4 scripts\engine\utility::ent_flag_set("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2");
  }

  showsplashtoteam(var_1, "_encstr_A98227D8E5F95F4B2255630BD89A9E8B3A052630CBEBF3B7CB1548D2F742F70EE557566BC53FB339AF");
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_A97712255F4A7BC8B4870E61AF73A82ED2D78B99", 0, var_2, undefined);
  level thread[[level.updategameevents]]();
  _id_1402C(var_1);
}

run_spawn_module_till_kill_trig(var_0, var_1) {
  if(level.mapname != "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    return revive_icon_color_keep(var_0, var_1);

  var_2 = level.teamnamelist.size;
  var_3 = 0;

  foreach(var_5 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_5, "_encstr_9775086022BE1B413B8B").size > 0)
      var_3++;
  }

  var_2 = var_3;
  var_7 = 360 / var_2;
  var_8 = (0, 0, 100);

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE") {
    var_8 = (0, 0, 100);
    var_9 = 5000;
  } else {
    var_8 = (4000, 10000, 100);
    var_9 = 40000;
  }

  var_10 = scripts\engine\trace::create_default_contents(1);
  var_11 = [];

  for(var_12 = 0; var_12 < var_2; var_12++) {
    var_13 = var_12 * var_7;
    var_14 = anglesToForward((0, var_13, 0));
    var_15 = var_8 + var_14 * var_9;
    var_16 = scripts\engine\utility::drop_to_ground(var_15, 10000, -20000, undefined, var_10);
    var_15 = (var_15[0], var_15[1], var_16[2] + 200);
    var_17 = spawnStruct();
    var_17.origin = var_15;
    var_18 = (0, 0, 0);
    var_17.angles = vectortoangles(var_14 * -1);
    var_17.targetname = var_0;
    var_17.vehicletype = var_1;
    var_11[var_11.size] = var_17;
  }

  return var_11;
}

revive_icon_color_keep(var_0, var_1) {
  var_2 = [];

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_2[var_2.size] = (-2533.7, 54787.8, 934.125);
    var_2[var_2.size] = (19455.7, 47380.9, 703.631);
    var_2[var_2.size] = (29881.1, 34508.6, 431.924);
    var_2[var_2.size] = (15321.8, 32020.1, 1408.69);
    var_2[var_2.size] = (38053.6, 17970.5, -250.489);
    var_2[var_2.size] = (-2885.36, 17654.9, -319.88);
    var_2[var_2.size] = (-26271.7, 23710.6, -457.159);
    var_2[var_2.size] = (-29644.1, 8657.81, -314.751);
    var_2[var_2.size] = (-16638.5, 3580.88, -318.745);
    var_2[var_2.size] = (400.686, 4022.38, -316.36);
    var_2[var_2.size] = (14804.4, 12316.5, -331.905);
    var_2[var_2.size] = (32217.4, 7072.95, -551.75);
    var_2[var_2.size] = (59228.9, 2347.17, 13.1114);
    var_2[var_2.size] = (43521.9, -4206.88, 239.839);
    var_2[var_2.size] = (20831.1, -7073.38, -423.882);
    var_2[var_2.size] = (5014.32, -12777.4, -283.875);
    var_2[var_2.size] = (-15914.1, -10012.7, -282.887);
    var_2[var_2.size] = (-29018.7, -13662, -153.498);
    var_2[var_2.size] = (-23250.5, -28965.7, -121.878);
    var_2[var_2.size] = (-6069.22, -32071.6, 289.89);
    var_2[var_2.size] = (7777.69, -28194.7, -152.361);
    var_2[var_2.size] = (20365.9, -24552.9, -246.891);
    var_2[var_2.size] = (32391.8, -29483.2, -565.484);
    var_2[var_2.size] = (55082.4, -22175, -363.307);
    var_2[var_2.size] = (50004.4, -32146.2, 1124.23);
  } else {
    var_2[var_2.size] = (-2533.7, 54787.8, 934.125);
    var_2[var_2.size] = (19455.7, 47380.9, 703.631);
    var_2[var_2.size] = (29881.1, 34508.6, 431.924);
    var_2[var_2.size] = (15321.8, 32020.1, 1408.69);
    var_2[var_2.size] = (38053.6, 17970.5, -250.489);
    var_2[var_2.size] = (-2885.36, 17654.9, -319.88);
    var_2[var_2.size] = (-26271.7, 23710.6, -457.159);
    var_2[var_2.size] = (-29644.1, 8657.81, -314.751);
    var_2[var_2.size] = (-16638.5, 3580.88, -318.745);
    var_2[var_2.size] = (400.686, 4022.38, -316.36);
    var_2[var_2.size] = (14804.4, 12316.5, -331.905);
    var_2[var_2.size] = (32217.4, 7072.95, -551.75);
    var_2[var_2.size] = (59228.9, 2347.17, 13.1114);
    var_2[var_2.size] = (43521.9, -4206.88, 239.839);
    var_2[var_2.size] = (20831.1, -7073.38, -423.882);
    var_2[var_2.size] = (5014.32, -12777.4, -283.875);
    var_2[var_2.size] = (-15914.1, -10012.7, -282.887);
    var_2[var_2.size] = (-29018.7, -13662, -153.498);
    var_2[var_2.size] = (-23250.5, -28965.7, -121.878);
    var_2[var_2.size] = (-6069.22, -32071.6, 289.89);
    var_2[var_2.size] = (7777.69, -28194.7, -152.361);
    var_2[var_2.size] = (20365.9, -24552.9, -246.891);
    var_2[var_2.size] = (32391.8, -29483.2, -565.484);
    var_2[var_2.size] = (55082.4, -22175, -363.307);
    var_2[var_2.size] = (50004.4, -32146.2, 1124.23);
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 = scripts\engine\trace::create_default_contents(1);
  var_4 = 0;

  foreach(var_6 in var_2) {
    var_7 = scripts\engine\utility::drop_to_ground(var_6, 10000, -20000, undefined, var_3);
    var_8 = (var_6[0], var_6[1], var_7[2] + 200);
    var_6 = var_8;
    var_4++;

    if(var_4 >= 5) {
      var_4 = 0;
      waitframe();
    }
  }

  var_10 = [];
  var_11 = level.teamnamelist.size;
  var_12 = 0;

  foreach(var_14 in level.teamnamelist) {
    if(scripts\mp\utility\teams::getteamdata(var_14, "_encstr_9775086022BE1B413B8B").size > 0)
      var_12++;
  }

  var_11 = var_12;
  var_11 = min(var_11, 25);

  for(var_16 = 0; var_16 < var_11; var_16++) {
    var_17 = spawnStruct();
    var_17.origin = var_2[var_16];
    var_18 = (0, 0, 0) - var_17.origin;
    var_17.angles = vectortoangles(var_18);
    var_17.targetname = var_0;
    var_17.vehicletype = var_1;
    var_10[var_10.size] = var_17;
  }

  return var_10;
}

remove_hover_direction_and_try_issue_retreat(var_0, var_1) {
  var_2 = [];
  var_3 = 3;
  var_4 = 360 / var_3;
  var_5 = (0, 0, 100);
  var_6 = 1000;

  for(var_7 = 0; var_7 < var_3; var_7++) {
    var_8 = var_7 * var_4;
    var_9 = anglesToForward((0, var_8, 0));
    var_10 = var_5 + var_9 * var_6;
    var_11 = spawnStruct();
    var_11.origin = var_10;
    var_12 = (0, 0, 0);
    var_11.angles = vectortoangles(var_9 * -1);
    var_11.targetname = var_0;
    var_11.vehicletype = var_1;
    var_2[var_2.size] = var_11;
  }

  return var_2;
}

validate_and_activate_stations(var_0) {
  if(!isDefined(level._id_13AA7))
    return 0;

  return scripts\mp\utility\teams::getteamdata(var_0, "_encstr_8A2A0B936CCCC3078547970A8B") == 0 && (!istrue(level._id_13AA7[var_0]) || istrue(level._id_13DF4));
}

_id_125F7(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("_encstr_95891233AB8F29F50393D1D8596B251062118F8D"))
    return 0;

  var_0.victim thread playerrespawn(0, var_0, var_1);
  var_0.victim thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, var_1);
  return 1;
}

playerrespawn(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_B1E80FD9BAB1B076EB2C5DE87BF5EE5A37");
  self notify("_encstr_85310ED0E331628363AA85963A0AFFC8");
  self endon("_encstr_85310ED0E331628363AA85963A0AFFC8");

  if(istrue(level.gameended)) {
    return;
  }
  if(istrue(level._id_13DF4) || validate_and_activate_stations(self.team) || scripts\engine\utility::ent_flag_exist("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2") && scripts\engine\utility::ent_flag("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2")) {
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_13DC2();
    return;
  }

  if(getdvarint("_encstr_937B16E66C4E7D89D6DED7ABE62BFA37C12CBBB9FA99D287", 1) == 1)
    self endon("_encstr_B4A11DFE52B90BE8B4BFC088EFE8A16F92B661F36FC2F995876738C01F04F9");

  var_3 = level.checkpoint_objective_id;

  if(istrue(var_0))
    var_3 = 0;

  var_4 = getdvarfloat("_encstr_92A9225776A20F086D77C1FA08D2430953F04EE75377238872837981A8DD78BF28A3725D", 5.0);

  if(var_3 < var_4)
    var_3 = var_4;

  if(level._id_12CB4 != 0)
    var_3 = 0;

  scripts\engine\utility::ent_flag_init("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  thread kioskfixupproneplayers(var_3);
  var_5 = var_3 - var_4;
  var_6 = var_3 - var_5;
  var_7 = var_3 - getdvarfloat("_encstr_836B22D789622F86887031A3A5A6499227E06F844684118E579B535BE1FFF0D1F94A07ED", 5.0);
  thread patchfix(var_7);
  var_8 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2", var_5);

  if(var_8 != "_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2") {
    thread _id_1400C();
    var_8 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2", var_6);
  }

  self notify("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");

  if(scripts\engine\utility::ent_flag_exist("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2") && scripts\engine\utility::ent_flag("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2"))
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_13132();
  else if(scripts\engine\utility::ent_flag("_encstr_856017021FF2776133CDFF3331218B1193232F2F729941DF32"))
    scripts\mp\utility\lower_message::setlowermessageomnvar(79);

  while(scripts\engine\utility::ent_flag_exist("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2") && !scripts\engine\utility::ent_flag("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2") && !level._id_13AA7[self.team] || scripts\cp_mp\utility\player_utility::isusingremote())
    waitframe();

  if(scripts\engine\utility::ent_flag_exist("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2") && scripts\engine\utility::ent_flag("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2"))
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_13132();

  if(validate_and_activate_stations(self.team) || scripts\engine\utility::ent_flag_exist("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2") && scripts\engine\utility::ent_flag("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2")) {
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_1, var_2);
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_13DC2();
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
    _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
    return;
  }

  var_9 = getspawnpoint();
  var_10 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_9);
  var_11 = level._id_13ACE[self.team].origin;

  if(getdvarint("_encstr_A69D166B46DACF52A7B74FD7339D037227F39329CA20A30A", 1) == 0)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  scripts\engine\utility::ent_flag_clear("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self.force_players_out_of_vehicle = [];
  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid() && isDefined(level._id_124E7))
    var_9 = scripts\engine\utility::getStruct(level._id_124E7, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagwinnerrespawn(1, undefined, var_9, 1, var_10, 1, undefined, 0, 0, 1);
  var_12 = vectortoangles(var_11 - var_10);
  self setplayerangles(var_12);
  self notify("_encstr_A507113995371C2C77DCFACE2D59EEAF9B2BA3");
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_B8350FE0F4011BF7A6A9FACA8B4BB204A8");

  if(isDefined(level._id_13ACE[self.team])) {
    var_11 = level._id_13ACE[self.team].origin;
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", level._id_13ACE[self.team].health);
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", level._id_13ACE[self.team].maxhealth);
  }

  level thread _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_140B1(var_11, "_encstr_9695073995D94BD959");
  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  _id_1402C(self.team);
}

kioskfixupproneplayers(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
}

patchfix(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self notify("_encstr_8A4D10990B46598ABD74CA0B39B4DC76AA38");
  self endon("_encstr_8A4D10990B46598ABD74CA0B39B4DC76AA38");

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  if(validate_and_activate_stations(self.team) || !level._id_13AA7[self.team]) {
    return;
  }
  var_1 = 1.0;
  thread fadeoutin();
  wait(var_1 - 0.25);
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::ending_fade_in();
  _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 2);
  wait 0.25;

  if(validate_and_activate_stations(self.team) || !level._id_13AA7[self.team]) {
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
    return;
  }

  if(getdvarint("_encstr_AC7823E8FF0286ADB285F8F59A6A8F4B688F4098A7A17849DAEAE9F3F2232B30AEDFB028A3", 1) == 1) {
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
    var_2 = getspawnpoint();
    _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_2.origin, var_2.angles);
    scripts\mp\spectating::setdisabled();
    self.trial_moving_target_think = var_2.origin;
    self.trial_other_team = gettime();
    scripts\engine\utility::ent_flag_set("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03");
  }
}

fadeoutin() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  var_0 = scripts\engine\utility::_id_143B5("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527", "_encstr_856017021FF2776133CDFF3331218B1193232F2F729941DF32", "_encstr_B1E80FD9BAB1B076EB2C5DE87BF5EE5A37");

  if(var_0 == "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527" || var_0 == "_encstr_856017021FF2776133CDFF3331218B1193232F2F729941DF32")
    self waittill("_encstr_A507113995371C2C77DCFACE2D59EEAF9B2BA3");
  else
    _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);

  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
}

_id_1400C() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8EF11C0E84607851BDBFB45E487540AA6F88930A35727A6781FA1981E7C8");
  self endon("_encstr_A282165BB8FBE88A4F90792B0D19428360D0778B2B1124E2");

  for(;;) {
    if(scripts\engine\utility::ent_flag("_encstr_8A8C2381D372DB4002E2D1EB92F91898496F05016F2BA9783B8258603D9F40CF02EF8DBB03")) {
      var_0 = getspawnpoint();
      var_1 = gettime();

      if(var_1 - self.trial_other_team >= getdvarfloat("_encstr_8E5722D07AD2EF19EF0FC8D60807634571D2C8B0226ECB719F176BC3FE7B2E29A7DA3090", 2.0) * 1000) {
        var_0 = getspawnpoint();
        var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
      }
    } else {
      var_0 = getspawnpoint();
      var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
    }

    wait 1.0;
  }
}

initspawns() {
  level._id_1365E = getdvarfloat("_encstr_8AB51172D82A2737B00ED03556285ADAD779EB", 2500);
}

getspawnpoint(var_0) {
  if(!isDefined(self._id_12AB3)) {
    self._id_12AB3 = spawnStruct();
    return pre_race(istrue(var_0));
  }

  self.ti_spawn = 0;

  if(isDefined(self.setspawnpoint)) {
    var_1 = self.setspawnpoint;

    if(!istrue(self.setspawnpoint.notti)) {
      self.ti_spawn = 1;
      self playlocalsound("_encstr_83B70F9BD01FCB77A177ACE716AB1F535D");

      foreach(var_3 in level.teamnamelist) {
        if(var_3 != self.team)
          self playsoundtoteam("_encstr_83B70F9BD01FCB77A177ACE716AB1F535D", var_3);
      }
    }

    var_5 = self.setspawnpoint.playerspawnpos;
    var_6 = scripts\engine\trace::create_default_contents(1);
    var_7 = scripts\engine\utility::drop_to_ground(var_5, 10000, -20000, undefined, var_6);
    var_5 = (var_5[0], var_5[1], var_7[2]);
    var_5 = var_5 + (0, 0, 1) * level.endsuperdisableweaponbr._id_1365E[self.team];

    if(getdvarint("_encstr_AC0D163F1BCB177905537808893620D77B7869C1A8B62BD4") == 1)
      thread scripts\mp\utility\debug::drawline(var_5, var_7, 15.0, (1, 1, 0));

    self._id_12AB3.origin = var_5;
    self._id_12AB3.angles = self.setspawnpoint.playerspawnangles;
    self._id_12AB3.lifeid = self.lifeid;
    self._id_12AB3.time = gettime();
    scripts\mp\equipment\tac_insert::_id_13681(0, 1);
  } else if(self._id_12AB3.team != self.team || self._id_12AB3.lifeid != self.lifeid || istrue(self._id_12AB3.updateclientmatchdata))
    return pre_race(istrue(var_0));

  return self._id_12AB3;
}

pre_race(var_0) {
  var_1 = level._id_13ACE[self.team].origin;
  var_2 = scripts\engine\trace::create_default_contents(1);
  var_3 = scripts\engine\trace::ray_trace(var_1 + (0, 0, 10000), var_1 - (0, 0, 20000), undefined, var_2)["_encstr_BD260953AA97E3F014279D"];
  var_1 = (var_1[0], var_1[1], var_3[2] + level._id_1365E);

  if(istrue(level._id_13ECD) && getdvarint("_encstr_A7051F03FE7D57FB230BCA98308F8B376D153BAB2AC3FDDF893837CC41AB3B6F3B", 1) == 1) {
    if(istrue(level.group_unset_jugg_standstill)) {
      var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
      var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
      var_6 = var_4 - var_1;
      var_7 = distance2d(var_4, var_1);

      if(var_7 > var_5) {
        var_8 = vectorNormalize(var_6);
        var_9 = 0;
        var_10 = 0;

        if(level.br_circle.circleindex == 0) {
          var_11 = level.br_level.br_circleradii[level.br_circle.circleindex];
          var_9 = var_11 - var_5;
        } else {
          var_12 = level.br_level.default_class_chosen[level.br_circle.circleindex];
          var_9 = distance2d(var_4, var_12);
        }

        var_13 = level.br_level.br_circleclosetimes[level.br_circle.circleindex + 1];
        var_14 = var_9 / var_13;
        var_15 = var_14 * getdvarfloat("_encstr_B4AA245AE910DF3B4E9BE7CFB7FF6367B8B1D2E2C160A641A957CFF783135A91F05E8B2CF818", 10.0);
        var_1 = var_1 + var_8 * var_15;
        var_16 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
        var_17 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

        if(distance2dsquared(var_1, var_16) > var_17 * var_17) {
          var_18 = vectorNormalize(var_1 - var_16);
          var_1 = var_16 + var_18 * var_17 * 0.99;
        }
      }
    }
  }

  self._id_12AB3.origin = var_1;
  self._id_12AB3.angles = level._id_13ACE[self.team].angles;
  self._id_12AB3.time = gettime();
  self._id_12AB3.team = self.team;
  self._id_12AB3.index = -1;
  self._id_12AB3.lifeid = self.lifeid;
  self._id_12AB3.updateclientmatchdata = var_0;
  return self._id_12AB3;
}

_id_144F4() {
  while(!isDefined(level.players) || level.players.size == 0)
    waitframe();

  var_0 = 1;

  for(;;) {
    waitframe();

    if(getdvarint("_encstr_B46B187B31B3D7733B3DAF1A8B830381B119A02CAF3BA99F9F95", 0) != 0) {
      var_1 = 1000;
      radiusdamage(level._id_13ACE["_encstr_8E8405EA382B2A"].origin, 1000, var_1, var_1);
    }
  }
}

beacon() {
  if(!isDefined(level._id_13DF9))
    level._id_13DF9 = [];

  level._id_13DF9[level._id_13DF9.size] = level.players[0].origin;

  foreach(var_1 in level._id_13DF9) {}
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

stoppingpower_givehcrdata(var_0) {
  level.scr_animtree["_encstr_A937066AFF52FA4F"] = #animtree;
  level.scr_anim["_encstr_A937066AFF52FA4F"]["_encstr_A7890BD19CD536B6F52393B738"] = % _encstr_8FAF236BE0BEADD65A1BDE6499AFB35D37E695E4F5464E7B83FAB06C43B039D896AC986618;
  level.scr_animname["_encstr_A937066AFF52FA4F"]["_encstr_A7890BD19CD536B6F52393B738"] = "_encstr_8FAF236BE0BEADD65A1BDE6499AFB35D37E695E4F5464E7B83FAB06C43B039D896AC986618";
  level.scr_anim["_encstr_A937066AFF52FA4F"]["_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA"] = % _encstr_88952BD607BE6BDAA5B1BD19CCEB3BEA7337CA93BEC893ED1C7D0BB1342C4E1B4BCA136606F5A34E5AB65BCA91;
  level.scr_animname["_encstr_A937066AFF52FA4F"]["_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA"] = "_encstr_88952BD607BE6BDAA5B1BD19CCEB3BEA7337CA93BEC893ED1C7D0BB1342C4E1B4BCA136606F5A34E5AB65BCA91";
  level.scr_animtree["_encstr_B8650ACAF940B1FAF32B6B27"] = #animtree;

  if(isDefined(var_0) && istrue(var_0)) {
    level.scr_anim["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_A7890BD19CD536B6F52393B738"] = % _encstr_8CDB1D1F490892C1089B555E96E81D3BE089FB9FF150EBB950814E64CBE855;
    level.scr_animname["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_A7890BD19CD536B6F52393B738"] = "_encstr_8CDB1D1F490892C1089B555E96E81D3BE089FB9FF150EBB950814E64CBE855";
  } else {
    level.scr_anim["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_A7890BD19CD536B6F52393B738"] = % _encstr_9BCA21E77B61A9D06438F0664727070F90F3C00DA99AEAD8D3CE709750A708E1EDE8ED;
    level.scr_animname["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_A7890BD19CD536B6F52393B738"] = "_encstr_9BCA21E77B61A9D06438F0664727070F90F3C00DA99AEAD8D3CE709750A708E1EDE8ED";
  }

  scripts\common\anim::addnotetrack_customfunction("_encstr_B8650ACAF940B1FAF32B6B27", "_encstr_AB9915680FB3E9BB68E5C4E951710934CB976871B7AEB9", ::_id_121C2, "_encstr_A7890BD19CD536B6F52393B738");

  if(isDefined(var_0) && istrue(var_0)) {
    level.scr_anim["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA"] = % _encstr_AF2525503BE987698320E0EE37BFD36541E220B8D3311921EB59FE53F54B196FF32B6020BAD779;
    level.scr_animname["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA"] = "_encstr_AF2525503BE987698320E0EE37BFD36541E220B8D3311921EB59FE53F54B196FF32B6020BAD779";
  } else {
    level.scr_anim["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA"] = % _encstr_AF4A296B83D7DADA96B1ED91CCAFD9ABB9DC564ED723C9DB0ED738164E2CD80DAB4795D7D1C95AB6ADB223;
    level.scr_animname["_encstr_B8650ACAF940B1FAF32B6B27"]["_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA"] = "_encstr_AF4A296B83D7DADA96B1ED91CCAFD9ABB9DC564ED723C9DB0ED738164E2CD80DAB4795D7D1C95AB6ADB223";
  }

  scripts\common\anim::addnotetrack_customfunction("_encstr_B8650ACAF940B1FAF32B6B27", "_encstr_AB9915680FB3E9BB68E5C4E951710934CB976871B7AEB9", ::_id_121C2, "_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA");
  stoppingpower_loadoutchangeremovehcr();
}

#using_animtree("_encstr_810A1AEA3847B3D39854493595C316A9992BE66BE3D770C29F5B901A");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

stoppingpower_loadoutchangeremovehcr() {
  level.scr_animtree["_encstr_ADA706A3E4BA1BB6"] = #animtree;
  level.scr_anim["_encstr_ADA706A3E4BA1BB6"]["_encstr_A7890BD19CD536B6F52393B738"] = % _encstr_A21F1FDA13D62AD097D9B0457F3F2CCB5B2DFFE289EB0AE030D6DB27CAD1380FCF;
  level.scr_anim["_encstr_ADA706A3E4BA1BB6"]["_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA"] = % _encstr_A65827DA1CEB6BD64B8DDEC866EBB3ABCDE62BE4EB32277B0EAF6BB596D8DB2333BE8E4E966B5B2B23;
}

_id_13DE4(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::ter_op(istrue(var_3), "_encstr_A7890BD19CD536B6F52393B738", "_encstr_9573131BB3473ED051E49DAF1889F07E9FFAB0A1BA");
  var_0.animname = "_encstr_ADA706A3E4BA1BB6";
  var_0.should_display_reinforcement_called_icon = 1;
  var_0 vehphys_forcekeyframedmotion();
  var_0 hide();
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_5.angles = var_2;
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 = undefined;
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_7.angles = var_2;
  var_7.animname = "_encstr_B8650ACAF940B1FAF32B6B27";
  var_7 setModel("_encstr_A2811E4BB898A0697B13B561891592BFA168B7AF2BD00F63BBB6FE66E31B4B4D");
  var_7 scripts\common\anim::setanimtree();
  var_7 unmarkkeyframedmover(1);
  var_7 hide();
  var_8 = undefined;

  if(istrue(var_3)) {
    var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
    var_8.angles = var_2;
    var_8.animname = "_encstr_A937066AFF52FA4F";
    var_8 setModel("_encstr_954624A0420C69F69741199821EF1BDF364AC8908BA503493E233F9033BF666F9EC3906812FA");
    var_8 scripts\common\anim::setanimtree();
    var_8 hide();
  }

  var_5.vehicle = var_0;
  var_5.parachute = var_7;
  var_5.carrier = var_8;
  var_5.objent = var_6;
  var_9 = gettime() + level.frameduration;
  var_5.endtime = gettime();
  var_5.vehicleendtime = var_9 + getanimlength(level.scr_anim["_encstr_ADA706A3E4BA1BB6"][var_4]) * 1000;

  if(var_5.vehicleendtime > var_5.endtime)
    var_5.endtime = var_5.vehicleendtime;

  var_5.parachuteendtime = var_9 + getanimlength(level.scr_anim["_encstr_B8650ACAF940B1FAF32B6B27"][var_4]) * 1000;

  if(var_5.parachuteendtime > var_5.endtime)
    var_5.endtime = var_5.parachuteendtime;

  var_5.carrierendtime = var_9 + getanimlength(level.scr_anim["_encstr_A937066AFF52FA4F"][var_4]) * 1000;

  if(var_5.carrierendtime > var_5.endtime)
    var_5.endtime = var_5.carrierendtime;

  var_5 thread _id_13DE5(var_4);
  return var_0;
}

_id_13DE5(var_0) {
  scripts\common\anim::anim_first_frame_solo(self.vehicle, var_0);
  scripts\common\anim::anim_first_frame_solo(self.parachute, var_0);

  if(isDefined(self.carrier))
    scripts\common\anim::anim_first_frame_solo(self.carrier, var_0);

  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    self.vehicle.stop_pressure_sensor = 1;
    thread scripts\common\anim::anim_single_solo(self.vehicle, var_0);
  }

  if(isDefined(self.parachute)) {
    self.parachute show();
    thread scripts\common\anim::anim_single_solo(self.parachute, var_0);
  }

  if(isDefined(self.carrier)) {
    self.carrier show();
    self.carrier playLoopSound("_encstr_A51F19A7D36A1136C0E36775134B1D666727892B0AC9FF5B4BF771");
    self.carrier setscriptablepartstate("_encstr_BE2908C47B90B4630EFB", "_encstr_AB0703DBB9", 0);
    self.carrier setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_AB0703DBB9", 0);
    thread scripts\common\anim::anim_single_solo(self.carrier, var_0);
  }

  while(gettime() <= self.endtime) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle.isdestroyed) || gettime() >= self.vehicleendtime)
      thread _id_13DE6(self.vehicle);

    if(isDefined(self.parachute) && gettime() >= self.parachuteendtime)
      self.parachute delete();

    if(isDefined(self.carrier) && gettime() >= self.carrierendtime)
      self.carrier delete();

    waitframe();
  }

  thread _id_13DE6(self.vehicle);

  if(isDefined(self.parachute))
    self.parachute delete();

  if(isDefined(self.carrier))
    self.carrier delete();

  self delete();
}

_id_13DE6(var_0) {
  self.vehicle = undefined;

  if(isDefined(var_0)) {
    var_0 vehphys_setdefaultmotion();
    var_0 thread _id_13DE9();
  }
}

_id_13DE9() {
  self endon("_encstr_AD75063D571AE108");
  self physics_registerforcollisioncallback();
  waitframe();
  var_0 = gettime() + 5000;
  var_1 = undefined;
  var_2 = undefined;

  while(gettime() < var_0) {
    if(!isDefined(var_1))
      var_1 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
    else {
      var_3 = vectordot(self vehicle_getvelocity(), (0, 0, -1));
      var_4 = (var_3 - var_1) / level.framedurationseconds;

      if(isDefined(var_2)) {
        if(var_2 - var_4 >= 300) {
          _id_13DE7(self.origin, self.angles);
          break;
        }
      }

      var_1 = var_3;
      var_2 = var_4;
    }

    waitframe();
  }

  self physics_unregisterforcollisioncallback();
}

_id_13DE7(var_0, var_1) {
  self.stop_pressure_sensor = 0;
  playFX(scripts\engine\utility::getfx("_encstr_AF2110A4732963A30710BA42C02F9DFFA06D"), var_0, anglesToForward(var_1));
  playsoundatpos(var_0, "_encstr_97AE1496EEE0D76C2699C07D239CF6E0FAB6AD961BED");
  earthquake(0.3, 0.7, var_0, 800);
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0);
  physicsexplosionsphere(var_0, 800, 400, 0.5);
}

_id_121C2(var_0) {
  var_0 playSound("_encstr_813B1A207707BFB6CBD331B131EAC0182E5834EAE518517333036B2D");
}

showsplashtoteam(var_0, var_1) {
  foreach(var_3 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"])
  var_3 scripts\mp\hud_message::showsplash(var_1);
}

manage_fakebody_hides(var_0) {
  thread _id_13DF7(var_0);

  if(getdvarint("_encstr_B1991C485FA22621E3E3061A7B8A756E0AFFD8409F5AFEE7AB8E85135592", 1) == 1)
    level thread toma_strike_watch_owner();

  if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_BA32084FFD08358F1C99")) {
    level.disablespawning = 1;
    setdynamicdvar("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A5B70A7E58D31199826EB896", 1);
  }

  scripts\mp\deathicons::_id_12BFD();
  scripts\mp\flags::gameflaginit("_encstr_B1DD16DBEDBD326B601E32FAF168A6491E7F2743A9ED0B5D", 0);
  level thread cargo_truck_mg_reenter();
  scripts\mp\flags::gameflagwait("_encstr_B1DD16DBEDBD326B601E32FAF168A6491E7F2743A9ED0B5D");

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!isalive(var_2))
      var_2 scripts\mp\playerlogic::spawnplayer(0);

    if(istrue(var_2.delay_enter_combat_after_investigating_grenade))
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(var_2);

    var_2 setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
    var_2 setclientomnvar("_encstr_82D30EBA5AF5899CEBB473662D36CA23", 1);
    var_2 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
    var_2 thread _id_13919();
  }

  wait 2.0;
  scripts\mp\flags::gameflagset("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  foreach(var_2 in level.players)
  var_2 playsoundtoplayer("_encstr_A3400F5DBB91A331699ECAB9A35C0ADD9B", var_2, var_2);

  wait 2.0;
  _id_136AA();
  cargo_truck_mg_removegunnerdamagemod();

  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 thread _id_12095();
  }

  level thread _id_144D7();
  scripts\mp\flags::gameflagset("_encstr_95891233AB8F29F50393D1D8596B251062118F8D");
}

_id_13DF7(var_0) {
  foreach(var_2 in level.players) {
    var_2 setclienttriggeraudiozone("_encstr_96BE1849327B0D186ADB176BE09379C7E74F2B3BD9BF30C084A4", 1);
    var_3 = game["_encstr_813F06832D8A18FE"]["_encstr_A132104DA6FBC64AB722E39B962B7DF22B21"].size;
    var_4 = randomint(var_3);
    var_2 setplayermusicstate(game["_encstr_813F06832D8A18FE"]["_encstr_A132104DA6FBC64AB722E39B962B7DF22B21"][var_4]);
  }

  wait 3;

  foreach(var_2 in level.players)
  var_2 playlocalsound("_encstr_85951A5A366D79F2DB6107138090A421235EB2C2078FF2344140270B", undefined, undefined, 1);

  wait 0.8;

  foreach(var_2 in level.players) {
    var_2 playlocalsound("_encstr_83761ADC1BE4FAC4E4BED2CDCC4B36D74DD5B5C1AF371DB4E6CEACE4", undefined, undefined, 1);
    var_2 clearclienttriggeraudiozone(3);
  }
}

_id_13919() {
  var_0 = spawnStruct();
  var_0.origin = level._id_13ACF[self.team].origin;
  var_0.height = getdvarint("_encstr_954E22E3B9EEA7C370039393EF0B8A5F9BF0DA1B40CF237120318977C5C954FF334942A3", 3000);
  var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_0);
}

_id_12095() {
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  if(!isalive(self))
    scripts\mp\playerlogic::spawnplayer(0);

  if(istrue(self.delay_enter_combat_after_investigating_grenade))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self);

  var_0 = level._id_13ACE[self.team];

  if(!istrue(var_0.should_display_reinforcement_called_icon))
    level thread _id_13DE4(var_0, var_0.origin, var_0.angles, 0);

  getspawnpoint(1);
  var_1 = anglesToForward((0, randomint(360), 0));
  var_2 = getdvarint("_encstr_998122D32ED3E78B7520B2CAC8ABC22F6837416CB3D953195F209A0328FFFD932176D5E4", 500);
  var_3 = getdvarint("_encstr_954E22E3B9EEA7C370039393EF0B8A5F9BF0DA1B40CF237120318977C5C954FF334942A3", 3000);
  var_4 = self._id_12AB3.origin + var_1 * var_2 + (0, 0, 1) * var_3;
  var_5 = vectortoangles(self._id_12AB3.origin - var_4);

  while(self isinexecutionattack() || self isinexecutionvictim())
    waitframe();

  waitframe();
  self setOrigin(var_4, 1);
  self setplayerangles(var_5);
  thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::parachute(undefined, 0, undefined, 0);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
  self.plotarmor = undefined;
  self clearsoundsubmix("_encstr_978411ADABD7963049F44F4DE228916CD70299", 1.5);
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3", 1);
  self notify("_encstr_97FC14C8B7EB77CA8D6CB76BACF5B91C8D85DC3459CD");
}

toma_strike_watch_owner() {
  var_0 = [];

  if(getdvarint("_encstr_953D26DC6CC9FA47E4ABD8B6DDC239BEE42B3885B44EF5CD3A2C3AD2F6B97D7B13D4AC6C8E96CECA", 1) == 1) {
    _setdomflagiconinfo("_encstr_86421DDD855EE07BB4733AFA39B21C589639AF378EB0E8A5F6DCF52D91B159", 1, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_88631C98C9F7D60BD6937E6FBFBC1F3555C9D1D0F9055937EFEF6C69A024", "_encstr_A27C2B9B73771AA03EC82B9798D178C2EB186399EBB772F6466013271048374A9D382A8FCFDBAA126EE0434B08", 0);
    _setdomflagiconinfo("_encstr_87201F3B571BEB9FD888D37780B15822937689B24553E3D1209087B758AE154B53", 1, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_88631C98C9F7D60BD6937E6FBFBC1F3555C9D1D0F9055937EFEF6C69A024", "_encstr_99452D10AC1F1037E9A95A5F20A8FAEDA22D80B677C24F7AC95BCB4788900BEB43418B4B6B5FAF28DF58B0E1BF06D0", 0);
  }

  if(getdvarint("_encstr_9713216EB193D7D19CAED8B6DDB04E7D4ECA0E585AE4FA914B6E2CC4D856AF33969C59", 0) != 1) {
    var_1 = getdvarint("_encstr_830B2042F108C7D3B6630FD79FD77B0FD0993A4E2860BF8A03475BBFBB9042617861", 90000);
    var_2 = relic_steelballs_stump();

    foreach(var_4 in var_2) {
      var_5 = init_track(var_4, sqrt(var_1));
      var_5._id_12C35 = var_1;
      var_0[var_0.size] = var_5;
    }
  }

  var_1 = getdvarint("_encstr_9B5F1F16768B172BD24F88D05F1923DF731F0F974C234F51A17F3818AF0FD9DBCB", 90000);
  var_2 = remaphardpointorder();

  foreach(var_4 in var_2) {
    var_5 = init_track(var_4, sqrt(var_1));
    var_5._id_12C35 = var_1;
    var_0[var_0.size] = var_5;
  }

  var_1 = getdvarint("_encstr_879221B91BE47DD1E4AB6C6DEE16C9BE39AC072CB4C9F591A5E68ECD5C7DE67BE48EA1", 90000);
  var_2 = reset_use_trigger();

  foreach(var_4 in var_2) {
    var_5 = init_track(var_4, sqrt(var_1));
    var_5._id_12C35 = var_1;
    var_0[var_0.size] = var_5;
  }

  var_1 = getdvarint("_encstr_9BAA21CD3693D7D1E4BA8DB5EE0BE4F593950E2C2DE4F519B4CDD19B17BEE6DEBAE80D", 90000);
  var_2 = rooftop_objective();

  foreach(var_4 in var_2) {
    var_5 = init_track(var_4, sqrt(var_1));
    var_5._id_12C35 = var_1;
    var_0[var_0.size] = var_5;
  }

  level._id_12C36 = var_0;
}

_setdomflagiconinfo(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.waypointcolors[var_0] = var_2;
  level.waypointbgtype[var_0] = var_1;
  level.waypointstring[var_0] = var_3;
  level.waypointshader[var_0] = var_4;
  level.waypointpulses[var_0] = var_5;
}

init_track(var_0, var_1) {
  var_2 = undefined;

  if(getdvarint("_encstr_953D26DC6CC9FA47E4ABD8B6DDC239BEE42B3885B44EF5CD3A2C3AD2F6B97D7B13D4AC6C8E96CECA", 1) == 1) {
    var_3 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0, 0, int(var_1), int(var_1));
    var_2 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_3);
    var_2.pinobj = 0;
    var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    var_2.flagmodel hide();
    scripts\mp\objidpoolmanager::update_objective_position(var_2.objidnum, var_2.curorigin + (0, 0, 60));
    _func_421(var_2.objidnum, 1);
    var_2 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_86421DDD855EE07BB4733AFA39B21C589639AF378EB0E8A5F6DCF52D91B159");
    getbnetigrbattlepassxpmultiplier(var_2.objidnum, 2000, 2500);
  } else
    var_2 = easepower("_encstr_922818F9A67B530B1F7F7B507205E36064CD0E7860D1490887E6", var_0, (0, 0, 1));

  var_2.inuse = 0;
  var_2.trial_target_flip = 0;
  return var_2;
}

relic_steelballs_stump() {
  var_0 = [];

  if(level.mapname == "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE")
    var_0[var_0.size] = (1850, -50, 0);
  else if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0[var_0.size] = (-18964, -22238, -165);
    var_0[var_0.size] = (5507, -29862, 62);
    var_0[var_0.size] = (-21604, 1168, -254);
    var_0[var_0.size] = (-6975, 19920, -262);
    var_0[var_0.size] = (-28578, 46653, 2746);
    var_0[var_0.size] = (-3099, 56987, 678);
    var_0[var_0.size] = (19946, 3582, -390);
    var_0[var_0.size] = (16578, -22869, -146);
    var_0[var_0.size] = (46055, 24809, -342);
  } else {
    var_0[var_0.size] = (-18964, -22238, -165);
    var_0[var_0.size] = (5507, -29862, 62);
    var_0[var_0.size] = (-21604, 1168, -254);
    var_0[var_0.size] = (-6975, 19920, -262);
    var_0[var_0.size] = (-28578, 46653, 2746);
    var_0[var_0.size] = (-3080, 56856, 678);
    var_0[var_0.size] = (19946, 3582, -390);
    var_0[var_0.size] = (16578, -22869, -146);
    var_0[var_0.size] = (46055, 24809, -342);
  }

  return var_0;
}

remaphardpointorder() {
  var_0 = [];

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0[var_0.size] = (-30563, 3055, -232);
    var_0[var_0.size] = (-21165, -15396, -246);
    var_0[var_0.size] = (-27563, -2557, -256);
    var_0[var_0.size] = (-22268, -27419, -82);
    var_0[var_0.size] = (-9895, -34131, 218);
    var_0[var_0.size] = (10254, -20711, -231);
    var_0[var_0.size] = (4552, -14424, -229);
    var_0[var_0.size] = (-11881, 1482, -262);
    var_0[var_0.size] = (-18095, 6481, -262);
    var_0[var_0.size] = (10306, 14001, -270);
    var_0[var_0.size] = (17112, 2074, -534);
    var_0[var_0.size] = (33549, 26531, 627);
    var_0[var_0.size] = (44925, 17451, -308);
    var_0[var_0.size] = (45326, -265, 20);
    var_0[var_0.size] = (5317, 24973, 50);
    var_0[var_0.size] = (47951, -9453, 154);
  } else {
    var_0[var_0.size] = (-30563, 3055, -232);
    var_0[var_0.size] = (-21165, -15396, -246);
    var_0[var_0.size] = (-27563, -2557, -256);
    var_0[var_0.size] = (-22268, -27419, -82);
    var_0[var_0.size] = (-9895, -34131, 218);
    var_0[var_0.size] = (10254, -20711, -231);
    var_0[var_0.size] = (4552, -14424, -229);
    var_0[var_0.size] = (-11881, 1482, -262);
    var_0[var_0.size] = (-18095, 6481, -262);
    var_0[var_0.size] = (10306, 14001, -270);
    var_0[var_0.size] = (17112, 2074, -534);
    var_0[var_0.size] = (33549, 26531, 627);
    var_0[var_0.size] = (44925, 17451, -308);
    var_0[var_0.size] = (45326, -265, 20);
  }

  return var_0;
}

reset_use_trigger() {
  var_0 = [];

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0[var_0.size] = (15625, 36254, 1510);
    var_0[var_0.size] = (28400, 39129, 762);
    var_0[var_0.size] = (-7544, 33510, -10);
    var_0[var_0.size] = (25786, 20693, 1383);
    var_0[var_0.size] = (-13791, 46397, 1833);
    var_0[var_0.size] = (3195, 50010, 1120);
    var_0[var_0.size] = (-24770, 34814, 390);
    var_0[var_0.size] = (-4988, 16480, -214);
  } else {
    var_0[var_0.size] = (15625, 36254, 1510);
    var_0[var_0.size] = (28400, 39129, 762);
    var_0[var_0.size] = (-7544, 33510, -10);
    var_0[var_0.size] = (26074, 20938, 1384);
    var_0[var_0.size] = (-13791, 46397, 1833);
    var_0[var_0.size] = (3195, 50010, 1120);
    var_0[var_0.size] = (-24770, 34814, 390);
    var_0[var_0.size] = (-4988, 16480, -214);
  }

  return var_0;
}

rooftop_objective() {
  var_0 = [];

  if(level.mapname == "_encstr_8CD508CA98A70FAFC01D") {
    var_0[var_0.size] = (18940, -24914, -199);
    var_0[var_0.size] = (13021, -35175, -422);
    var_0[var_0.size] = (37931, -30644, -513);
    var_0[var_0.size] = (54024, -23960, -83);
  } else {
    var_0[var_0.size] = (18940, -24914, -199);
    var_0[var_0.size] = (13021, -35175, -422);
    var_0[var_0.size] = (37931, -30644, -513);
    var_0[var_0.size] = (54024, -23960, -83);
  }

  return var_0;
}

_id_144D7() {
  if(getdvarint("_encstr_B1991C485FA22621E3E3061A7B8A756E0AFFD8409F5AFEE7AB8E85135592", 1) == 0) {
    return;
  }
  var_0 = getdvarfloat("_encstr_B4621C1B30CDF1F353AD736344D9230935E8B3B2D865B99BE9167B65D043", 0.025);
  var_1 = getdvarfloat("_encstr_85441DD36730717B961B8A7223672B3968C36849EBD889D7B013E2EB2B4FAB", 1.0);

  for(;;) {
    foreach(var_3 in level._id_12C36)
    var_3._id_14073 = 0;

    foreach(var_17, var_6 in level._id_13ACE) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_7 = istrue(var_6.showquestobjicontoall);
      var_8 = 0;

      foreach(var_3 in level._id_12C36) {
        var_10 = distancesquared(var_6.origin, scripts\engine\utility::ter_op(isDefined(var_3.origin), var_3.origin, var_3.curorigin));

        if(var_10 < var_3._id_12C35) {
          var_3 _id_11B13();
          var_3._id_14073 = 1;
          var_8 = 1;

          if(istrue(var_6.showquestobjicontoplayer)) {
            continue;
          }
          if(var_6.health == var_6.maxhealth) {
            continue;
          }
          var_6.showquestobjicontoall = 1;

          if(!var_7)
            _id_1402C(var_17);

          var_11 = int(var_0 * var_6.maxhealth);
          var_6 scripts\cp_mp\vehicles\vehicle_damage::_id_1413C(var_11);
          var_6 playsoundtoteam("_encstr_847C1770E738DED95BF1252E53322F06924740B807E296B153", var_17, undefined, var_6);
          var_12 = scripts\mp\utility\teams::getteamdata(var_17, "_encstr_9775086022BE1B413B8B");

          foreach(var_14 in var_12) {
            if(getdvarint("_encstr_BDD929EB4E8D492BFA18FBBAABB27DB966ADE0BB9383E7DA8825D757787CC7BA997D4FABAFB9F19D595BA0", 0) == 1)
              var_14 scripts\mp\damagefeedback::hudicontype("_encstr_A53F0A838B7D471490138184");

            var_14 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_9A7918AED2FA9827BED12B586BBEB1B09B0DD738DBC6AD56E837", var_6.health);
            var_14 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_860D173348C8E3F28991E5E94B617E3706C029CAD1388F6F68", var_6.maxhealth);
          }

          break;
        }
      }

      if(var_7 && !var_8) {
        var_6.showquestobjicontoall = 0;
        _id_1402C(var_17);
      }
    }

    foreach(var_3 in level._id_12C36) {
      if(!var_3._id_14073)
        var_3 _id_11B0E();
    }

    wait(var_1);
  }
}

_id_11B13() {
  self.trial_target_flip = self.inuse;
  self.inuse = 1;

  if(self.inuse != self.trial_target_flip) {
    if(getdvarint("_encstr_953D26DC6CC9FA47E4ABD8B6DDC239BEE42B3885B44EF5CD3A2C3AD2F6B97D7B13D4AC6C8E96CECA", 1) == 1)
      scripts\mp\gameobjects::setobjectivestatusicons("_encstr_87201F3B571BEB9FD888D37780B15822937689B24553E3D1209087B758AE154B53");
  }
}

_id_11B0E() {
  self.trial_target_flip = self.inuse;
  self.inuse = 0;

  if(self.inuse != self.trial_target_flip) {
    if(getdvarint("_encstr_953D26DC6CC9FA47E4ABD8B6DDC239BEE42B3885B44EF5CD3A2C3AD2F6B97D7B13D4AC6C8E96CECA", 1) == 1)
      scripts\mp\gameobjects::setobjectivestatusicons("_encstr_86421DDD855EE07BB4733AFA39B21C589639AF378EB0E8A5F6DCF52D91B159");
  }
}

_id_1338B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_8BA62433AAA3CF2CD083D3189F2F3BF736E3532B7F579E47CBB9AB3F65F2B7D9CB98F7029462", 5);
  level._id_13DF4 = 0;
  level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");

  if(var_0 > level.br_level.br_circleclosetimes.size - 1)
    var_0 = level.br_level.br_circleclosetimes.size - 1;

  var_1 = 0;

  for(var_2 = 0; var_2 < var_0 - 1; var_2++) {
    var_1 = var_1 + level.br_level.br_circleclosetimes[var_2];
    var_1 = var_1 + level.br_level.br_circledelaytimes[var_2];
  }

  var_3 = gettime() + var_1 * 1000;
  setomnvar("_encstr_8AE30F9D40CF7F2340AB17B919F730F2DE", int(var_3));

  for(;;) {
    level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB", var_4);

    if(var_4 == var_0) {
      foreach(var_6 in level.players)
      var_6 scripts\mp\hud_message::showsplash("_encstr_8A95289ABACE587A6A3DFD2A735F098013DDA874DB46D3183E37A203A9C9139FFB9B77C4D2D1A7C6FF93");

      level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_BE6B131C3D989830516526C8B890CFD5618FAE997A", 0);
      level._id_13DF4 = 1;
      setomnvar("_encstr_8AE30F9D40CF7F2340AB17B919F730F2DE", 0);
      break;
    }
  }
}

_id_1402C(var_0) {
  var_1 = level._id_13ACE[var_0];
  var_2 = 0;

  if(isDefined(var_1) && !istrue(var_1.isdestroyed)) {
    if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_1, "_encstr_A7B606DA83796F4A"))
      var_2 = 1;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_1, "_encstr_851904B59B34"))
      var_2 = var_2 + 2;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_1, "_encstr_A19A0772BF43C35FD9"))
      var_2 = var_2 + 4;

    if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_1, "_encstr_9BB4074B8EEF3942D8")) {
      var_2 = var_2 + 8;
      var_2 = var_2 + (var_1._id_13DDF << 4);
    }
  }

  if(!isDefined(var_1) || istrue(var_1.isdestroyed))
    var_2 = var_2 + 64;
  else if(istrue(var_1.showquestobjicontoplayer))
    var_2 = var_2 + 128;
  else if(istrue(var_1.showquestobjicontoall))
    var_2 = var_2 + 256;

  var_3 = scripts\mp\utility\teams::getteamdata(var_0, "_encstr_9775086022BE1B413B8B");

  foreach(var_5 in var_3)
  var_5 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_966115DD134E2B022730DA9210CF7AEB618E554DBD303B", var_2);
}

brmini_initdialog() {
  var_0 = level._id_13ED0;
  level.br_level.br_circleclosetimes = [level._id_13EC8];
  level.br_level.br_circledelaytimes = [level._id_13EC9];
  level.br_level.default_player_connect_black_screen = [1];
  var_1 = level.br_level.br_circleminimapradii;
  var_2 = scripts\engine\utility::ter_op(isDefined(level._id_13ECF), level._id_13ECF, level.br_level.br_circleradii);

  if(level._id_13ED1) {
    level.br_level.default_suicidebomber_combat = [0];
    level.br_level.br_circleminimapradii = [var_1[0]];
    level.br_level.br_circleradii = [var_2[0], var_2[var_2.size - 1]];
  } else {
    level.br_level.default_suicidebomber_combat = [0];
    level.br_level.br_circleminimapradii = [int(var_0 / 2)];
    level.br_level.br_circleradii = [var_0, var_0];
  }

  setDvar("_encstr_81041B6ED8E4AF98937D5BEDCEB4B9B3D7365A27D8B156BED8BDEACD3A", level._id_13EC3);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = level._id_13EC0;
  var_8 = level._id_13EC5;

  for(var_9 = 1; var_9 < level._id_13EC3; var_9++) {
    if(level._id_13ED1) {
      var_10 = scripts\engine\utility::ter_op(var_9 + 1 < var_2.size - 1, var_2[var_9], var_2[var_2.size - 2]);
      var_11 = scripts\engine\utility::ter_op(var_9 + 1 < var_1.size - 1, var_1[var_9], var_1[var_1.size - 2]);
      var_3[var_3.size] = var_10;
      var_6[var_6.size] = var_11;
    } else {
      var_3[var_3.size] = 57300;
      var_6[var_6.size] = 10500;
    }

    if(isDefined(level._id_13EC2)) {
      var_12 = scripts\engine\utility::ter_op(level._id_13EC2.size <= var_9, level._id_13EC2.size - 1, var_9);
      var_7 = level._id_13EC2[var_12];
    } else
      var_7 = max(level._id_13EBF, var_7 - level._id_13EC1);

    if(isDefined(level._id_13EC7)) {
      var_12 = scripts\engine\utility::ter_op(level._id_13EC7.size <= var_9, level._id_13EC7.size - 1, var_9);
      var_8 = level._id_13EC7[var_12];
    } else
      var_8 = max(level._id_13EC4, var_8 - level._id_13EC6);

    var_4[var_4.size] = var_7;
    var_5[var_5.size] = var_8;
  }

  _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::open_teleport_room_door(var_3, var_4, var_5, var_6);
}

enemy_damage_monitoring() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getdvarint("_encstr_AC2E25B9C6C9AF3AE4578DB5EE8539AFD29B5A8E2D0BD8D7B14BE4D8D8ACEBD9C29C4BB09BC695", 10000);
  var_1 = randomfloatrange(var_0 * -1, var_0);
  var_2 = randomfloatrange(var_0 * -1, var_0);
  level.br_level.default_class_chosen[0] = level.br_level.br_mapcenter + (var_1, var_2, 0);
  level.br_level.default_class_chosen[1] = level.br_level.br_mapcenter + (var_1, var_2, 0);

  if(getdvarint("_encstr_BE851CF37E20A8A5F52BC117A3096E610F209B7FCAD2FFE0EB5A66F80260", 1) == 1) {
    for(var_3 = 2; var_3 < level.br_level.default_class_chosen.size - 1; var_3++)
      enemy_failsafe_ifonedidntspawn(var_3);
  } else {
    for(;;) {
      level waittill("_encstr_8B580EE6AAA7B1337ADA90D0F1D2D3AB");
      enemy_failsafe_ifonedidntspawn();
    }
  }
}

enemy_failsafe_ifonedidntspawn(var_0) {
  if(!isDefined(var_0))
    var_0 = level.br_circle.circleindex + 1;

  if(level.br_level.default_class_chosen.size <= var_0 || !istrue(level._id_13ECD)) {
    return;
  }
  var_1 = level.br_level.default_class_chosen[var_0];
  var_2 = level.br_level.br_circleradii[var_0 - 1] * level._id_13ECC;
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_1, var_2, 0.8, 1.0, 1, 0, 1);
  var_4 = vectorNormalize(var_3 - var_1) * var_2;
  var_5 = var_1 + var_4;
  var_6 = getdvarint("_encstr_82321CE61B93FA47E4D51BADEE589CFA8DB4276CD895FAC18546C8A537EC", 10000);

  for(var_7 = vectorNormalize(level.br_level.br_mapcenter - var_5); !_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_5, 1); var_5 = var_5 + var_7 * var_6) {}

  level.br_level.default_class_chosen[var_0 + 1] = var_5;
}

enemy_close_in_on_player(var_0) {
  var_1 = level.br_level.br_mapbounds;
  var_2 = level._id_13ECE;
  var_3 = var_0[0] < var_1[0][0] * var_2 && var_0[0] > var_1[1][0] * var_2 && var_0[1] < var_1[0][1] * var_2 && var_0[1] > var_1[1][1] * var_2;
  return var_3;
}

getgamewinnerprop(var_0, var_1) {
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_4 = var_2 - var_0;
  var_5 = distance2d(var_2, var_0);

  if(var_5 < var_3)
    return 0;

  var_6 = 0;
  var_7 = (0, 0, 0);
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = level.br_level.br_circleclosetimes[level.br_circle.circleindex];

  if(level.br_circle.circleindex > 0) {
    var_13 = level.br_level.default_class_chosen[level.br_circle.circleindex];
    var_6 = distance2d(var_2, var_13);
    var_7 = vectorNormalize(var_2 - var_13);
  }

  var_8 = var_6 / var_12;
  var_14 = level.br_level.br_circleradii[level.br_circle.circleindex];
  var_9 = var_14 - var_3;
  var_10 = vectorNormalize(var_4);
  var_11 = var_9 / var_12;
  var_15 = var_0 + var_7 * -1.0 * var_1 * var_8 + var_10 * -1.0 * var_1 * var_11;
  return _calloutmarkerping_handleluinotify_enemyrepinged::_id_127DA(var_15);
}

_id_13DF8() {
  wait 5;
  scripts\mp\utility\sound::besttime("_encstr_858C0E939A3799EBB8E0104F038A7B63");
}