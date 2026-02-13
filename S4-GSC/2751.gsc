/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2751.gsc
*************************************************/

_id_10152() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "create", ::_id_1014D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "createLate", ::_id_1014E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrame", ::_id_1014F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle", "deleteNextFrameLate", ::_id_10150);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_interact", "init", _id_0ABD::_id_100FC);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_occupancy", "init", _id_0AC0::_id_101DA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_mines", "init", _id_0ABE::_id_1014A);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "init", _id_0AC2::_id_10285);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_compass", "init", _id_0ABB::_id_10014);
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_damage", "init", _id_0ABC::_id_1005F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("technical", "init", _id_0AB9::_id_EFFA);
  scripts\cp_mp\utility\script_utility::registersharedfunc("light_tank", "init", _id_0AB4::_id_93FD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("little_bird", "init", _id_0AB5::_id_957D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("bronco_sfps_mp", "init", _id_0AAC::_id_2C18);
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "init", _id_0AB8::_id_ECDD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "init", _id_0AAA::_id_1E5C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("large_transport", "init", _id_0AB3::_id_8EDB);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cop_car", "init", _id_0AAE::_id_3D43);
  scripts\cp_mp\utility\script_utility::registersharedfunc("pickup_truck", "init", _id_0AB7::_id_B0A0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck", "init", _id_0AAD::_id_328E);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "init", _id_0AB0::_id_7A08);
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "init", _id_0AB2::_id_8BC4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("medium_transport", "init", _id_0AB6::_id_9CF9);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty_truck", "init", _id_0AB1::_id_7A2C);
  scripts\cp_mp\utility\script_utility::registersharedfunc("van", "init", _id_0ABA::_id_FFA7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("apc_russian", "init", _id_0AA9::_id_1996);
  scripts\cp_mp\utility\script_utility::registersharedfunc("s4_tank", "init", scripts\mp\vehicles\s4_tank_mp::s4_tank_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "init", scripts\mp\vehicles\open_jeep_mp::open_jeep_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "init", scripts\mp\vehicles\motorcycle_mp::motorcycle_mp_init);
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "init", scripts\mp\vehicles\cargo_truck_susp_mp::cargo_truck_susp_mp_init);
  _id_0AAF::init();
  _id_0AC1::_id_10227();
}

_id_10153() {
  _id_09CC::_id_1988();
  _id_09CD::_id_1E4F();
  _id_09D0::_id_3283();
  _id_09D1::_id_3D38();
  _id_09D2::_id_79FD();
  _id_09D3::_id_7A21();
  _id_09DB::_id_EFED();
  _id_09D6::_id_93D5();
  _id_09D7::_id_9571();
  _id_09DA::_id_ECD2();
  _id_09D5::_id_8ED0();
  _id_09D9::_id_B095();
  _id_09D4::_id_8BB9();
  _id_09D8::_id_9CEE();
  _id_09DC::_id_FF9A();
  _id_09CF::_id_2C0F();
  scripts\cp_mp\vehicles\s4_tank::s4_tank_init();
  scripts\cp_mp\vehicles\open_jeep::open_jeep_init();
  scripts\cp_mp\vehicles\motorcycle::motorcycle_init();
  scripts\cp_mp\vehicles\cargo_truck_susp::cargo_truck_susp_init();
}

_id_1014D(var_0, var_1) {
  var_0.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::_id_10042(var_0);
  var_0.health = var_0.maxhealth;
  _id_0AC1::_id_10229(var_0);
  var_0 _meth_86FE("killstreak");
  _id_0AC0::_id_101E5(var_0);
}

_id_1014E(var_0, var_1) {}

_id_1014F(var_0) {
  _id_0AC1::_id_10220(var_0, 1);
}

_id_10150(var_0) {}

_id_10154(var_0) {}

_id_10151(var_0) {}