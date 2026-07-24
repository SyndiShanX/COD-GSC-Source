/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phparade\phparade.gsc
*************************************************/

main() {
  scripts\sp\utility::_id_116CB("phparade");
  setsaveddvar("sm_spotDistCull", 500);
  setsaveddvar("sm_sunSampleSizeNear", 0.25);
  setdvarifuninitialized("dont_load_nextmission", 0);
  scripts\sp\maps\phparade\gen\phparade_art::main();
  scripts\sp\maps\phparade\phparade_fx::main();
  scripts\sp\maps\phparade\phparade_precache::main();
  scripts\sp\maps\phparade\phparade_anim::main();
  _id_0EBD::main();
  _id_0EC3::main();
  _id_0EC9::main();
  _id_0ECF::main();
  level.player _meth_82C0("phparade_UNHQ_hallway", 0.0);
  scripts\sp\utility::_id_F343("Office");
  scripts\sp\utility::_id_1749("Office", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_C358, "", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_C34D, ["phparade_base_tr", "phparade_office_tr", "phparade_ride_tr"], scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_C341);
  scripts\sp\utility::_id_1749("Exterior", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_6A39, "", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_6A35, ["phparade_base_tr", "phparade_office_tr", "phparade_ride_tr"], scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_C345);
  scripts\sp\utility::_id_1749("Rooftop", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_E6CD, "", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_E6B1, ["phparade_base_tr", "phparade_ride_tr"], scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_E691);
  scripts\sp\utility::_id_1749("Dropship Entrance", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_5DD3, "", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_5DD2, ["phparade_base_tr", "phparade_ride_tr"], scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_5DD1);
  scripts\sp\utility::_id_1749("Ending Scene Hat Hair", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_6354, "", undefined, ["phparade_base_tr", "phparade_office_tr"], undefined);
  scripts\sp\utility::_id_1749("Ending Scene Full Hair", scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_6353, "", undefined, ["phparade_base_tr", "phparade_office_tr"], undefined);
  scripts\sp\utility::_id_1263F("phparade_base_tr");
  scripts\sp\utility::_id_1263F("phparade_office_tr");
  scripts\sp\utility::_id_1263F("phparade_ride_tr");
  scripts\sp\load::main();
  _id_CAD7();
  _id_CAD8();
}

_id_CAD7() {
  level._id_11937 = 0.05;
  precachemodel("p7_desk_metal_military_03_tablet");
  precachemodel("body_hero_protagonist_vm_legs_naval");
  precachemodel("equipment_industrial_tool_caddy_01");
  precachemodel("nopack_nohelmet_shadow");
  precachemodel("head_hero_xo");
  precachemodel("head_hero_xo_dress_whites_hat");
  precachemodel("head_hero_xo_qss");
  precachemodel("veh_mil_air_un_retribution");
  precachemodel("veh_mil_air_un_retribution_interior_01");
  precachemodel("veh_mil_air_un_destroyer");
  precachemodel("veh_mil_air_un_destroyer_rig");
  precachemodel("veh_mil_air_un_destroyer_periph");
  precachemodel("veh_mil_air_un_cruiser");
  precachemodel("veh_mil_air_un_cruiser_periph");
  precachemodel("veh_mil_air_un_cruiser_periph_details");
  precachemodel("ship_exterior_missile_pod_a_rig");
  precacheturret("cap_turret_missile_barrage");
  precacherumble("steady_rumble");
  scripts\sp\maps\pearlharbor\pearlharbor_un_building::_id_C9E6();
  scripts\sp\maps\pearlharbor\pearlharbor_un_building_fleet::_id_C9E5();
  scripts\sp\utility::_id_16CC("small_long", 0.15, 10, 2048);
  scripts\sp\utility::_id_16CC("small_med", 0.1, 5, 2048);
  scripts\sp\utility::_id_16CC("small_short", 0.15, 1, 2048);
  scripts\sp\utility::_id_16CC("medium_medium", 0.25, 3, 2048);
  scripts\sp\utility::_id_16CC("large_short", 0.45, 1, 2048);
  scripts\sp\utility::_id_16CC("large_medium", 0.45, 2, 2048);
  scripts\sp\utility::_id_16CC("mild_long", 0.22, 30, 100000);
  scripts\sp\utility::_id_16CC("hard_long", 0.25, 10, 4096);
  scripts\sp\utility::_id_16CC("small_very_long", 0.1, 15, 16384);
}

_id_CAD8() {
  level.player takeallweapons();
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  level.player disableweaponswitch();
  level.player allowdoublejump(0);
  level.player allowwallrun(0);
  level.player allowslide(0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_48BF();
}

_id_F55C() {
  var_0 = self.weapon;
  var_1 = self.classname;

  if(issubstr(var_1, "ar")) {
    if(issubstr(var_0, "ar57") || issubstr(var_0, "ake")) {
      return;
    }
    var_2 = scripts\engine\utility::random(["iw7_ake", "iw7_ar57+reflex", "iw7_ar57"]);
    scripts\sp\utility::_id_72EC(var_2, "primary");
  } else if(issubstr(var_1, "smg")) {
    if(issubstr(var_0, "erad") || issubstr(var_0, "fhr")) {
      return;
    }
    var_2 = scripts\engine\utility::random(["iw7_erad"]);
    scripts\sp\utility::_id_72EC(var_2, "primary");
  }
}