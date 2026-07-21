/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\vehicle_mp.gsc
***********************************************/

vehicle_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8AEA073693CA16D12B", ::_id_141BF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_888E0BC69CCA85A32B318547B2", ::_id_141C0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8E761050226DB3F317C63DABD4B3FB03958A", ::_id_141C1);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_8F471472BFB1A1B955F655C833C49B09537A903B940D", ::_id_141C2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_BECC055CF3811A", ::_id_141C3);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B6D611B3F8019447480DE7D99013071ABB701B", "_encstr_88C5055208731B", scripts\mp\vehicles\vehicle_interact_mp::vehicle_interact_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_88C5055208731B", scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_830C0ECECA434BB11B56F5D6D23759E6", "_encstr_88C5055208731B", scripts\mp\vehicles\vehicle_mines_mp::vehicle_mines_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8ECE0E33605963F754AB679E9A3B8B6D", "_encstr_88C5055208731B", scripts\mp\vehicles\vehicle_spawn_mp::vehicle_spawn_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_88C5055208731B", abandonedtimeoutcallback::_id_14127);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_866E0F7047AC0B0F63CF7905394923A4B5", "_encstr_88C5055208731B", abandonedtimeoutdelay::_id_14161);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF40102C3DF078AE8463F9B8814F5B99E112", "_encstr_88C5055208731B", _encstr_8E99299B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB090263F1DFE25007B391C7A0843A14A3C2::_runpurchasemenu);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8D6C0FD0DD2B5BCE0DAA07E333C0737B51", "_encstr_88C5055208731B", scripts\mp\equipment\trophy_system::trophy_watchprotection);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_993F1C6B20D95C8F7045AF9CE6380BA44381C2B3D08595DFAFBF8A877523", "_encstr_88C5055208731B", scripts\mp\equipment\trophy_system::_id_13DD6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_82801EC35AABB318E59D4F01920D488B5790DB2962B3FD113860213FBBF4E840", "_encstr_88C5055208731B", scripts\mp\equipment\trophy_system::trophy_createexplosion);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B8A716E847BC384A61F8BFECEBC898A3A04F78F0B1D27D71", "_encstr_88C5055208731B", scripts\mp\equipment\trophy_system::trophy_explode);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_88C5055208731B", scripts\mp\vehicles\technical_mp::technical_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_AF390B295782C3585F1B21D8C4", "_encstr_88C5055208731B", scripts\mp\vehicles\light_tank_mp::light_tank_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_88C5055208731B", scripts\mp\vehicles\little_bird_mp::little_bird_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_88C5055208731B", _x1opsnpcwaittilluse::xpperweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_88C5055208731B", scripts\mp\vehicles\tac_rover_mp::tac_rover_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C190467402B", "_encstr_88C5055208731B", scripts\mp\vehicles\atv_mp::atv_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_88C5055208731B", scripts\mp\vehicles\large_transport_mp::large_transport_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_88C5055208731B", scripts\mp\vehicles\cop_car_mp::cop_car_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_88C5055208731B", scripts\mp\vehicles\pickup_truck_mp::pickup_truck_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_88C5055208731B", scripts\mp\vehicles\cargo_truck_mp::cargo_truck_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_88C5055208731B", _waitforlui::get_last_stand_id);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_88C5055208731B", scripts\mp\vehicles\hoopty_mp::hoopty_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_88C5055208731B", scripts\mp\vehicles\jeep_mp::jeep_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_88C5055208731B", scripts\mp\vehicles\med_transport_mp::med_transport_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_88C5055208731B", scripts\mp\vehicles\hoopty_truck_mp::hoopty_truck_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_911904464232", "_encstr_88C5055208731B", scripts\mp\vehicles\van_mp::van_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86510C82737817CD40B38B720A15", "_encstr_88C5055208731B", scripts\mp\vehicles\apc_rus_mp::apc_rus_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_99C20BA548E9F27A61D897932B", "_encstr_88C5055208731B", _x1opsplayerredactalltacmaplocation::_id_11D6A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BDC80A5437EAD749519A6068", "_encstr_88C5055208731B", _x1opsassignnpctoteam::bot_item_matches_purpose);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_83F40783ADF1D14AA3", "_encstr_88C5055208731B", _validateitempurchase::create_vehicle_interact);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_88C5055208731B", _x1opsnpcpulsecheckteamnearby::startdisabled);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_88C5055208731B", _watchtoautoclosemenu::get_random_primary_weapon_obj);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_88C5055208731B", _watchforcircleclosure::get_player_aggro_score);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_97AE0AF6E0959BEB4D2B95C1", "_encstr_88C5055208731B", _x1opsunassignnpcfromteam::_id_1210B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_88C5055208731B", _x1opsplayerunredacttacmaplocation::_id_120DC);
  scripts\mp\vehicles\damage::init();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_init();
}

_id_141BF(var_0, var_1) {
  var_0.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::_id_1414E(var_0);
  var_0.health = var_0.maxhealth;
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registerinstance(var_0);
  var_0 enableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");
  scripts\mp\vehicles\vehicle_occupancy_mp::vehicle_occupancy_mp_updatemarkfilter(var_0);
}

_id_141C0(var_0, var_1) {}

_id_141C1(var_0) {
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_clearoob(var_0, 1);
}

_id_141C2(var_0) {}

_id_141C3(var_0) {}