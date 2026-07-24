/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_titan\shipcrib_titan.gsc
*************************************************************/

main() {
  scripts\sp\utility::_id_1263F("shipcrib_titan_jackal_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_dropship_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_prime_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_prime_in_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_bridge_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_bridgem_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_exterior_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_jackale_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_hangar_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_halore_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_bridgee_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_mezz_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_vr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_ambient_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_ambientmr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_titan_ambientml_tr");
  _id_0EFB::_id_FDB2("shipcrib_titan");
  _id_0EFB::_id_FD77("shipcrib_titan");
  _id_0EFB::_id_FD73("shipcrib_titan");
  _id_0EFB::_id_FDAE("shipcrib_titan");
  var_0 = scripts\engine\utility::array_add(level._id_FD6E._id_30B8, "shipcrib_titan_dropship_tr");
  var_1 = ["shipcrib_titan_halore_tr", "shipcrib_titan_exterior_tr", "shipcrib_titan_bridge_tr", "shipcrib_titan_prime_in_tr"];
  scripts\sp\utility::_id_F343("titan start");
  scripts\sp\utility::_id_1749("E3 Bridge", ::_id_5FA7, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("no transients", ::_id_30B6, "", undefined, []);
  scripts\sp\utility::_id_1749("nextmission", ::_id_BF99, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("blackroom", ::_id_2B4D, "", undefined, var_0);
  scripts\sp\utility::_id_1749("bridge", ::_id_30B6, "", undefined, var_0);
  scripts\sp\utility::_id_1749("bridge no screens", ::_id_30B7, "", undefined, var_0);
  scripts\sp\utility::_id_1749("armory", ::_id_224A, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("flight deck", ::_id_6F23, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("jackal land full", ::_id_A247, "", undefined, level._id_FD6E._id_A248);
  scripts\sp\utility::_id_1749("jackal land bink", ::_id_A246, "", undefined, level._id_FD6E._id_A248);
  scripts\sp\utility::_id_1749("jackal launch full", ::_id_A24F, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("jackal launch bink", ::_id_A24E, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("dropship launch full", ::_id_5E30, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("come about", ::_id_11958, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("ftl", ::_id_11976, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("approach", ::_id_1194F, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("admirals office", ::_id_30B6, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("titan gl hangar", ::_id_1197D, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("titan start dev", ::_id_1199D, "", undefined, var_1);
  scripts\sp\utility::_id_1749("titan start", ::_id_1199C, "", undefined, var_1);
  scripts\sp\utility::_id_1749("titan bridge", ::_id_11953, "", undefined, var_0);
  scripts\sp\utility::_id_1749("titan bridge ftl", ::_id_11952, "", undefined, var_0);
  scripts\sp\utility::_id_1749("titan lv_elevator", ::_id_1198F, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("titan armory", ::_id_11951, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("titan airboss", ::_id_11949, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("titan dropship", ::_id_1195B, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("transient: preload cost", ::_id_1195C, "", undefined, var_1);
  scripts\sp\utility::_id_1749("transient: sa free", ::_id_1195C, "", undefined, ["shipcrib_titan_hangar_tr", "shipcrib_titan_jackal_tr"]);
  scripts\sp\utility::_id_1749("transient: mainline free", ::_id_1195C, "", undefined, ["shipcrib_titan_hangar_tr", "shipcrib_titan_dropship_tr"]);
  scripts\sp\utility::_id_1749("sc_sa_assa", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_sa_emp", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_sa_vips", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_sa_wound", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_asteroid", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_mining", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_spacestation", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_titan", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_wreckage", ::_id_1199E, "", undefined, var_1);
  scripts\sp\utility::_id_116CB("shipcrib_titan");
  scripts\sp\maps\shipcrib_titan\gen\shipcrib_titan_art::main();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_fx::main();
  scripts\sp\maps\shipcrib_titan\shipcrib_titan_precache::main();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_anim::main();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_lights::main();
  level._id_111C3 = scripts\engine\utility::spawn_tag_origin((296119, -198227, 26699.7), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_sctitan_sunfx"), level._id_111C3, "tag_origin");
  level _id_0EE4::_id_FDDB();
  setsaveddvar("r_spotlightEntityShadows", 1);
  scripts\sp\load::main();
  scripts\engine\utility::flag_init("jackal_valet_ready");
  scripts\engine\utility::flag_init("moving_to_mezz");
  scripts\engine\utility::flag_init("moving_to_bridge");
  scripts\engine\utility::flag_init("xo_on_elevator");
  scripts\engine\utility::flag_init("ok_to_move_to_flight_deck");
  scripts\engine\utility::flag_init("airboss_player_on_ele");
  scripts\engine\utility::flag_init("airboss_mco_on_ele");
  scripts\engine\utility::flag_init("return_elevator_can_move");
  scripts\engine\utility::flag_init("player_getting_in_seat");
  scripts\engine\utility::flag_init("player_in_seat");
  scripts\engine\utility::flag_init("boggs_prepped");
  scripts\engine\utility::flag_init("brooks_prepped");
  scripts\engine\utility::flag_init("kash_prepped");
  scripts\engine\utility::flag_init("brooks_ready_for_takeoff");
  scripts\engine\utility::flag_init("kash_ready_for_takeoff");
  scripts\engine\utility::flag_init("mco_ready_for_takeoff");
  scripts\engine\utility::flag_init("player_entered_terminal");
  scripts\engine\utility::flag_init("player_gesture_done");
  scripts\engine\utility::flag_init("adm_brief_done");
  level._id_C67F = _id_0EDE::_id_C67F;
  level._id_E366 = scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_1DBF;
  level._id_13567 = "shipcrib_titan_vr_tr_loaded";
  level._id_E3FB = "shipcrib_titan_exterior_tr_loaded";
  level._id_C68F = 1;
  level._id_FD69 = _id_10A3::_id_3B9D;
  level._id_FD68 = _id_10A3::_id_3B9E;
  level thread _id_0EE4::_id_FDAF();
  level thread _id_0EDC::_id_BBAC();
  level thread _id_0EDC::_id_448B();
  level thread _id_0EF0::_id_FD9F();
  level thread _id_10AC::_id_97A5();
  level thread _id_0EF2::_id_9A41();
  precachemodel("axis_guide");
  precacherumble("heavy_2s");
  precacherumble("subtle_tank_rumble");
  precachemodel("equipment_industrial_weapon_mount_01");
  precachemodel("helmet_hero_protagonist_desert");
  precachemodel("body_hero_protagonist");
  precachemodel("head_hero_protagonist");
  precachemodel("pack_un_jackal_pilots");
  precachemodel("hero_jackal_helmet_a");
  precachemodel("equipment_lunar_spotting_scope_03");
  precachemodel("veh_mil_air_un_dropship_seat");
  precachemodel("veh_mil_air_un_jackal_landed_03b");
  precachemodel("vr_goggles_hero_xo");
  precachemodel("weapon_vr_rifle_wm");
  precachemodel("viewmodel_base_viewhands_iw7_desert");
  precachemodel("body_hero_protagonist_vm_legs_desert");
  precachemodel("default_character_shadow");
  level.player _meth_84C7("lastShipcribMission", level.script);
}

_id_2B4D() {
  scripts\sp\utility::_id_11633(getEnt("blackroom_start", "targetname"));
}

_id_30B6() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  wait 3;
  level _id_0EF3::_id_FD78("admiral_main", "sc_titan_adm_bridge");
}

_id_30B7() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level thread _id_0EF5::_id_FDF5();
}

_id_224A() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  scripts\sp\utility::_id_11633(getEnt("armory_start", "targetname"));
  level thread _id_0EEB::_id_60FD("gravity", "Mezzanine", 1);
}

_id_6F23() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  scripts\sp\utility::_id_11633(getEnt("flightdeck_start", "targetname"));
  level._id_EFED = "safe";
  level scripts\engine\utility::delaythread(0.05, ::_id_E3C8);
  level _id_11996();
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  wait 5;
}

_id_A247() {
  var_0 = _id_0EF9::_id_FE03("jackal", "return_crane_a");
  _id_0EE1::_id_E3D9(var_0, "a", 1);
  var_0 = _id_0EF9::_id_FE03("jackal", "return_crane_b");
  _id_0EE1::_id_E3D9(var_0, "b");
  _id_0EE1::_id_E3DA("top");
  wait 5;
  level notify("start_klaxon");
  level thread _id_0EE1::_id_E3D1("a", "full", 6, 5, 7);
  level thread _id_0EE1::_id_E3D1("b", "full", 6, 5, 7);
}

_id_A246() {
  var_0 = _id_0EF9::_id_FE03("jackal", "return_crane_a");
  _id_0EE1::_id_E3D9(var_0, "a", 1);
  var_0 = _id_0EF9::_id_FE03("jackal", "return_crane_b");
  _id_0EE1::_id_E3D9(var_0, "b");
  _id_0EE1::_id_E3DA("airlock");
}

_id_A24F() {
  scripts\sp\utility::_id_11633(getEnt("flightdeck_start", "targetname"));
  _id_0EF9::_id_FE03("jackal", "jackal_bay_1", "player");
  level._id_FD6E.jackals["jackal_bay_1"] _id_0BDC::_id_F48D("crib_launch");
  _id_0BDC::_id_137CF();
  level._id_FD6E.jackals["jackal_bay_1"] waittill("launch_ready");

  for(;;) {
    level _id_0EE0::_id_E3BE("jackal_bay_1");
    wait 1;
    level _id_0EE0::_id_E3C3("jackal_bay_1");
    wait 2;
  }
}

_id_A24E() {
  scripts\sp\utility::_id_11633(getEnt("flightdeck_start", "targetname"));
  _id_0EF9::_id_FE03("jackal", "jackal_bay_1", "player");
  level._id_FD6E.jackals["jackal_bay_1"] _id_0BDC::_id_F358("crib_craneride");
  _id_0BDC::_id_10CD2(level._id_FD6E.jackals["jackal_bay_1"]);
  level _id_0EE0::_id_E3C4("jackal_bay_1", "launch_tube");
}

_id_5E30() {
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  scripts\sp\utility::_id_11633(getEnt("shipcrib_titan_dropship_start", "targetname"));
  level thread _id_0EF9::_id_FE03("dropship", "dropship_bay_2");
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
  wait 1;
  level.player playSound("scn_ship_launch_alarm_lr");
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.3, 0, 0, 0, 14, 14, 14);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread _id_0BBC::_id_4265(["back"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\utility::play_sound_on_tag("scn_ship_launch_bkdoor_close", "j_lowerbackdoor1");
  level.player playSound("scn_ship_launch_move_01_lr");
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597A, 8);
  wait 7.4;
  var_0 = 10;
  level.player playRumbleOnEntity("heavy_2s");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.035, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_5EE3["dropship_bay_2"] linkTo(var_1);
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos2").origin;
  var_1 moveTo(var_2, var_0);
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
  wait(var_0 * 0.75);
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0, 0, 0, 7, 7, 7);
  level _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 8);
  wait 0.75;
  wait 3;
  level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C playSound("scn_ship_launch_door_open");
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C, 8);
  wait 7.4;
  var_0 = 11;
  level.player playRumbleOnEntity("heavy_2s");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.025, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  level.player playSound("scn_ship_launch_move_02_lr");
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos3").origin;
  var_1 moveTo(var_2, var_0);
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
  wait(var_0 + 0.75);
  var_0 = 7;
  screenshake(level.player.origin, 0.05, 0.05, 0.05, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 14, 14, 14);
  var_1 rotateTo(var_1.angles + (0, 90, 0), var_0);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaythread(0, _id_0BBF::_id_F459);
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C, 8);
  wait(var_0 + 0.75);
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0.35, 0, 0, 10, 10, 10);
}

_id_11958() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level scripts\engine\utility::delaythread(7, ::_id_4416);
}

_id_11976() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level thread _id_4416();
  wait 35;
  level thread _id_0EEE::_id_FD89("titan", "retribution", undefined, ::_id_496A, 7.15);
  wait 15;
  level notify("ftl_3_sec_left");
  wait 3;
  level notify("ftl_stop");
  wait 1;
  wait 15;
  level thread _id_0EEE::_id_FD8A(1);
}

_id_1194F() {
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level scripts\engine\utility::delaythread(3, ::_id_496A);
}

_id_1197D() {
  level.player _meth_82C0("fade_to_black", 0.05);
  setomnvar("ui_hide_hud", 1);
  var_0 = scripts\sp\hud_util::_id_48B7("black", 1);
  var_0.foreground = 1;
  var_0.sort = -1;
  var_1 = getEnt("gl_hangar_start", "targetname");
  scripts\engine\utility::delaythread(0, scripts\sp\utility::_id_11633, var_1);
  scripts\engine\utility::waitframe();
  level._id_EFED = "combat_vr";
  level.player _meth_818A();
  setomnvar("ui_hide_hud", 1);
  var_2 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player _meth_823B(var_2);
  level.player disableweapons();
  setomnvar("ui_hide_hud", 1);
  scripts\engine\utility::noself_delaycall(0.1, ::setomnvar, "ui_hide_hud", 1);
  _id_0EF8::_id_FDFC("spawner_omar", "omar_armory_moveto2");
  level._id_C47F _id_0EFB::_id_EB8D("titan");
  _id_11996();
  _id_5EA4();
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(level._id_C47F, "dropship_ramp_idle", "stop_mco_loop");
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_1E0A();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_21AF("close");
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("flight", "Flight Deck", 1);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  level thread _id_0EEB::_id_60FD("return", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("apc", "Flight Deck", 1);
  settimescale(10);
  wait 3;
  setomnvar("ui_hide_hud", 1);
  level.player clearclienttriggeraudiozone(1.0);
  var_0 scripts\engine\utility::delaycall(1, ::destroy);
  var_0 fadeovertime(0.5);
  var_0.alpha = 0;
  settimescale(1);
  var_2 delete();
  level.player unlink();
}

_id_1199C() {
  level thread _id_1199F();
  level _id_11996();
  level thread _id_AE03();
  level thread _id_0EF7::_id_FDE6();
  level _id_0EE4::_id_FDD5();
}

_id_1199E() {
  _id_0EE4::_id_A919();
  level.player _meth_84C7("scTitanFirstPlay", 1);
  _id_1199C();
}

_id_1199D() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_0EE4::_id_A919();
  _id_1199C();
  level._id_EFF2 = 0;
}

_id_AE03() {
  thread _id_FE06();

  if(_id_0EFB::_id_9CB4()) {
    level waittill("shipcrib_sa_setup_complete");
    _id_0EF8::_id_FDFC("spawner_salter", "return_sa_salter_start");
    level._id_EA2C linkTo(_id_0EEB::_id_7976("return"));
    thread _id_F8EA();
    level._id_EA2C _id_0EE5::_id_202D(4);
    wait 3.5;
    level._id_EA2C _id_0EE5::_id_10FC4();
    var_0 = level._id_EA2C scripts\engine\utility::spawn_tag_origin();
    var_0 linkTo(_id_0EEB::_id_7976("return"));
    level._id_EA2C linkTo(var_0);
    var_0 thread scripts\sp\anim::_id_1EC7(level._id_EA2C, "shipcrib_stand_idle04_exit");
    level waittill("shipcrib_sa_start_complete");
    level._id_EA2C unlink();
    _id_302F();
  }
}

_id_1199F() {
  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("shipcrib_titan_prime_tr");
  scripts\sp\utility::_id_12641("shipcrib_titan_bridgem_tr");
  level thread scripts\sp\utility::_id_12643(["shipcrib_titan_bridgee_tr", "shipcrib_titan_dropship_tr"]);
}

_id_11953() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_0EFB::_id_9CB4();
  scripts\sp\utility::_id_11633(getEnt("titan_bridge_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "shipcrib_titan_bridge_salter_wait");
  level.player _meth_84C7("scTaughtOpsmap", 0);
  _id_11996();
}

_id_5FA7() {
  level._id_5F98 = 1;
  _id_11953();
}

_id_11952() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_0EFB::_id_9CB4();
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  _id_11996();
  _id_4416(undefined, 1);
  level._id_C671 = undefined;
  level._id_C6AA["retribution"] _id_0EDE::_id_C66C();
  _id_30AC();
  _id_0EF8::_id_FDFC("spawner_salter", level._id_C6AA["retribution"]._id_10E52["xo"]);
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_5CFC._id_C6AC = scripts\sp\utility::_id_10639("optics");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_5CFC._id_C6AC, "SH4_2_1_SH_TTN_BR_PRE_DO_prop_OPS_idle", "stop_optics_idle");
  var_0 thread scripts\sp\anim::_id_1EC3(level._id_EA2C, "SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop");
  var_0 thread scripts\sp\anim::_id_1EC3(level._id_76FB, "SH4_2_3_SH_TTN_BR_OPS_NAV_ftl_drop");
  var_0 thread scripts\sp\anim::_id_1EC3(level._id_1044B, "SH4_2_3_SH_TTN_BR_OPS_BSN_ftl_drop");
  var_0 thread scripts\sp\anim::_id_1EC3(level._id_5CFC, "SH4_2_3_SH_TTN_BR_OPS_DO_ftl_drop");
  _id_3088();
}

_id_1198F() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_0EFB::_id_9CB4();
  _id_11996();
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_sotomura", _id_0EFB::_id_EFDB("boats"));
  _id_0EF8::_id_FDFC("spawner_salter", level._id_C6AA["retribution"]._id_10E52["xo"]);
  _id_AB12();
}

_id_11951() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_0EFB::_id_9CB4();
  scripts\sp\utility::_id_11633(getEnt("titan_armory_start", "targetname"));
  _id_11996();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_1E0A();
  level._id_FD6E._id_111D6 = 6;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
  _id_0EE6::_id_2201(["iw7_m4"]);
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6("iw7_m4");
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6("iw7_m4");
  level._id_EFF6 = 1;
  level.player _meth_84C7("scTaughtVR", 0);
  level._id_FDFA = "titan";
}

_id_11949() {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_0EFB::_id_9CB4();
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
  _id_0EFB::_id_FDD7();
  level._id_EFED = "safe";
  setDvar("loadout_chosen", 1);
  setDvar("loadout_shipcrib", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hide_hud", 1);
  scripts\sp\utility::_id_11633(getEnt("titan_airboss_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_omar", "omar_armory_moveto2");
  level._id_C47F scripts\sp\utility::_id_51E1("casual_gun");
  level._id_C47F _id_0EFB::_id_EB8D("titan");
  level._id_C47F scripts\sp\utility::_id_DC45("raise");
  _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_titan_armory_airboss_elevator");
  level._id_828C scripts\sp\utility::_id_65E0("waiting_for_reese");
  _id_0EF8::_id_FDFC("spawner_sahora", "shipcrib_titan_airboss_sahora");
  _id_11996();
  level thread _id_0A2F::_id_12642();
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_1E0A();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_21AF();
  level thread _id_E3C8();
}

_id_1195B(var_0) {
  level.player _meth_84C7("scTitanFirstPlay", 0);
  _id_0EFB::_id_9CB4();
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
  _id_0EFB::_id_FDD7();
  level._id_EFED = "safe";
  setDvar("loadout_chosen", 1);
  setDvar("loadout_shipcrib", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hide_hud", 1);
  var_1 = getEnt("shipcrib_titan_dropship_start", "targetname");
  _id_0EF8::_id_FDFC("spawner_omar", var_1.origin + anglesToForward(var_1.angles) * 200);
  level._id_C47F scripts\sp\utility::_id_51E1("casual_gun");
  level._id_C47F _id_0EFB::_id_EB8D("titan");
  level._id_C47F scripts\sp\utility::_id_DC45("raise");
  _id_11996();
  _id_5EA4();
  _id_496A();
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  scripts\sp\utility::_id_11633(var_1);
  _id_0EF8::_id_FDFC("spawner_sahora", "shipcrib_titan_dropship_sahora_start");
  level._id_EA29 thread _id_0B6A::_id_EC0B("shipcrib_titan_dropship_sahora_end", "hm_grnd_grn_kneel_idle_01");
  _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_titan_armory_airboss_exit");
  level._id_828C scripts\sp\utility::_id_65E0("waiting_for_reese");
  level._id_C47F thread _id_5E8E(_id_0EEB::_id_7976("gravity"));
  level._id_828C thread _id_5E81();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_1E0A();
  level thread _id_E3C8();

  if(isDefined(var_0) && var_0) {
    return;
  }
  _id_5E80();
  return;
}

_id_1195C() {}

_id_BF99() {
  _id_1195B(1);
  wait 1;
  _id_5E93();
  scripts\sp\utility::_id_BF95();
}

_id_11996() {
  _id_0EE4::_id_FDC0();
  level thread _id_0EDE::_id_C66D("retribution");
  _id_0EFB::_id_986C();

  if(_id_0EFB::_id_9CB4()) {
    level thread _id_0B20::_id_5A52("bridge", ::_id_307C);
    level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3A31);
    level._id_C6AA["retribution"] _id_0EDE::_id_C66C();
    level thread _id_10AB::_id_300C();
    level thread _id_FE07(1);
  } else {
    level thread _id_FE07(0);
    level thread _id_0B20::_id_5A52("bridge", _id_0EF7::_id_30AD);
  }

  level thread _id_0B20::_id_5A52("armory", ::_id_223C);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A73);
  level._id_C671 = ::_id_3088;
  level thread _id_11998();
}

_id_FE07(var_0) {
  scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), &"SHIPCRIB_OBJECTIVE_OPS_MAP");
  scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), &"SHIPCRIB_OBJECTIVE_GO_TO_JACKAL");
  scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), &"SHIPCRIB_OBJECTIVE_ARMORY");
  scripts\sp\utility::_id_C264("OBJECTIVE_TITAN");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_TITAN"), &"SHIPCRIB_OBJECTIVE_TITAN");
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), "current");
  level waittill("opsmap_selection_made");

  if(level._id_FDFA == "titan")
    var_0 = 1;
  else
    var_0 = 0;

  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"));

  if(var_0) {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), "current");
    scripts\engine\utility::flag_wait("armory_chose_loadout");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"));
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_TITAN"), "current");
    scripts\engine\utility::flag_wait("player_in_seat");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_TITAN"));
  } else {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), "current");
    level waittill("shipcrib_jackal_launch_started");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"));
  }
}

_id_11998() {
  scripts\engine\utility::flag_wait("shipcrib_titan_prime_tr_loaded");
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_fx::_id_CD74("vfx_light_exterior_wall_flightdeck_01", "vfx_light_exterior_wall_flightdeck_01");
}

_id_4416(var_0, var_1) {
  var_2 = 1;

  if(isDefined(var_1))
    var_2 = 0.1;

  level scripts\engine\utility::delaythread(3 * var_2, _id_0EEE::_id_FD8B, 2 * var_2);
  level scripts\engine\utility::flag_set("skybox_stop_rotating");
  var_3 = level._id_E35D._id_3BB6 scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_10288 linkTo(var_3);
  var_4 = 30;
  var_3 rotateTo((22, 22, 0), var_4, var_4 * 0.5, var_4 * 0.5);
  var_5 = var_3.origin + anglesToForward(level._id_E35D._id_3BB6.angles) * -130000 + (var_3.origin + anglestoup(level._id_E35D._id_3BB6.angles) * -120000);
  var_3 scripts\engine\utility::delaycall(15, ::moveto, var_5, 60, 30, 30);
}

_id_496A() {
  if(isDefined(level._id_FD6E._id_49A2)) {
    return;
  }
  level._id_FD6E._id_49A2 = 1;
  visionsetalternate(5, 3);
  level scripts\engine\utility::flag_set("skybox_stop_rotating");
  level._id_FD6E._id_11948 = scripts\engine\utility::spawn_tag_origin((472, 64, 238), (0, 270, 0));
  scripts\engine\utility::exploder("titan_approach");
  level._id_111C3 delete();
  level._id_111C3 = scripts\engine\utility::spawn_tag_origin((296119, -198227, 45799.7), (0, 0, 0));
  killfxontag(scripts\engine\utility::getfx("vfx_sctitan_sunfx"), level._id_111C3, "tag_origin");
  scripts\engine\utility::noself_delaycall(8, ::visionsetalternate, 4, 1);
  var_0 = getmapsunangles();
  var_1 = (-32, -17, 0);
  setsuncolorandintensity(0.854, 0.886, 0.627);
  lerpsunangles(var_0, var_1, 10);
  level scripts\engine\utility::delaythread(15.0, scripts\engine\utility::exploder, "window_fog");
  level scripts\engine\utility::delaythread(20.0, scripts\engine\utility::exploder, "cloud_layer_mid");
}

_id_A80C() {
  level.player endon("death");
  level endon("bridge_scene_started");
  thread _id_48D0();
  _id_985F();
  _id_985E();
  _id_0EE1::_id_E3DA("airlock");
  level thread _id_0EE1::_id_E3D1("a", "airlock", 5, 5);
  level thread _id_0EE1::_id_E3D1("b", "airlock", 5, 4);
  level scripts\engine\utility::delaythread(2.0, ::_id_A824);
  level waittill("jackal_elevator_finished");
  _id_E42B();
}

_id_985F() {
  var_0 = _id_0EF9::_id_FE03("jackal", "return_crane_a");
  _id_0EE1::_id_E3D9(var_0, "a", 1, "dismount_shipcrib_moon");
  var_1 = _id_0EF9::_id_FE03("jackal", "return_crane_b");
  _id_0EE1::_id_E3D9(var_1, "b");
  var_0 _meth_849F(0);
  var_1 _meth_849F(0);
  var_0 _id_0BDC::_id_A110();
}

_id_985E() {
  _id_10755();
  _id_10756();
}

_id_10755() {
  _id_0E4B::_id_8E06();
  _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_titan_jackal_airboss_watch");
  level._id_828C scripts\sp\utility::_id_65E0("waiting_for_reese");
  _id_0EF8::_id_FDFC("spawner_salter");
  var_0 = _id_0EE1::_id_7C10("b")._id_A056;
  level._id_EA2C linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "jackal_idle", "stop_loop");
  _id_0EF8::_id_FDFC("spawner_kloos", "shipcrib_titan_valetA_start");
  level._id_A6F4.team = "neutral";
  level._id_A6F4 scripts\engine\utility::delaythread(8, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("shipcrib_titan_valetA_wait", "targetname"));
}

_id_10756() {
  level._id_1312A = _id_0EF8::_id_FDFC("spawner_valet_b", "shipcrib_titan_valetB_start");
  level._id_1312A.team = "neutral";
  level._id_1312A._id_1FBB = "valet_b";
  level._id_1312A scripts\engine\utility::delaythread(7, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("shipcrib_titan_valetB_wait", "targetname"));
}

_id_48D0() {
  level waittill("dismount_shipcrib_moon");
  _id_A1E0();
  level notify("dismount_shipcrib_moon_complete");
}

#using_animtree("jackal");

_id_A1E0() {
  scripts\engine\utility::flag_init("dismount_started");
  var_0 = _id_0EE1::_id_7C10("a")._id_A056;
  var_1 = % sh4_3_2_ttn_land_plr_exit_jackal;
  var_2 = % jackal_vehicle_dismount_01_port;
  var_0 _id_0EE4::_id_F93C(var_1, var_2);
  level waittill("jackal_elevator_finished");
  scripts\engine\utility::flag_set("dismount_started");
  _id_567F();
  var_0 clearanim(%root, 0);
  var_1 = % sh4_3_2_ttn_land_plr_exit_jackal;
  var_2 = % jackal_vehicle_dismount_01_port;
  var_0 _id_0EE4::_id_68D1(var_1, var_2);
  level notify("player_jackal_exit_complete");
}

_id_567F() {
  thread _id_5692();
  thread _id_569E();
}

_id_5692() {
  level._id_A6F4 endon("death");
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_1 = _id_0EE1::_id_7C10("a")._id_A056;
  var_0 scripts\sp\anim::_id_1F35(level._id_A6F4, "jackal_dismount");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  level._id_A6F4 linkTo(var_1);
  var_2 linkTo(var_1);
  var_2 thread scripts\sp\anim::_id_1EEA(level._id_A6F4, "jackal_dismount_idle");
  _id_568C();
  scripts\engine\utility::flag_wait("return_player_catwalk");
  scripts\engine\utility::flag_set("jackal_valet_ready");
}

_id_568C() {
  var_0 = _id_0EE1::_id_7C10("a")._id_A056;
  var_1 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  level.player.helmet unlink();
  level.player.helmet linkTo(var_0);
  level.player.helmet._id_1FBB = "jackal_helmet";
  level.player.helmet scripts\sp\utility::_id_23B7();
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_2 linkTo(var_0);
  var_2 thread scripts\sp\anim::_id_1EEA(level.player.helmet, "jackal_dismount_idle");
}

_id_569E() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_1 = _id_0EE1::_id_7C10("b")._id_A056;
  var_1 notify("stop_loop");
  wait 2;
  level._id_EA2C unlink();
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "jackal_exit");
  level._id_EA2C _id_0B6A::_id_EC0A("shipcrib_titan_jackal_salter_wait");
  level thread _id_A81C(level._id_A6F4, level._id_1312A);

  if(!scripts\engine\utility::flag("return_player_catwalk")) {
    level._id_EA2C _id_0EE5::_id_202D(4);
    scripts\engine\utility::flag_wait("return_player_catwalk");
    level._id_EA2C _id_0EE5::_id_10FC4();
  }
}

_id_A824() {
  level.player scripts\sp\utility::_id_1034D("sc_titan_slt_Youbeengettingblood");
  level.player scripts\sp\utility::_id_1034D("sc_titan_plr_Nope");
  thread _id_A81E();
  level.player scripts\sp\utility::_id_1034D("sc_titan_slt_Whyarewetalkin");
  level.player scripts\sp\utility::_id_1034D("sc_titan_plr_Beenalongday");
  level.player scripts\sp\utility::_id_1034D("sc_titan_slt_Nothingalittlecaffeine");
  level.player scripts\sp\utility::_id_1034D("sc_titan_plr_Youknowit");
}

_id_A81E() {
  var_0 = _id_0EE1::_id_7C10("a")._id_A056;
  var_0 _id_0EE4::_id_CD5D(%jackal_pilot_camo_change, undefined, 0.5);
}

_id_567E() {
  level._id_828C endon("death");
  level._id_828C thread _id_B000(level._id_745E);
  wait 3;
  level._id_828C scripts\sp\utility::_id_77A9(level._id_745E["fspar3"]);
  wait 2;
  level._id_828C scripts\sp\utility::_id_77B9(0.4);
  level._id_828C _id_0B6A::_id_EC0B("shipcrib_titan_jackal_airboss_wait", "stand_hands_tied_idle");
}

_id_B000(var_0) {
  level._id_828C endon("stop_lookat");
  wait 2;

  foreach(var_2 in var_0) {
    scripts\sp\utility::_id_7799(var_2);
    wait(randomfloatrange(0.7, 2));
  }
}

_id_E42B() {
  _id_9868();
  scripts\engine\utility::flag_wait("return_player_catwalk");
  thread _id_F220();
  _id_CDE2();
  scripts\engine\utility::flag_set("xo_on_elevator");
  _id_E448();
}

_id_9868() {
  level.player clearclienttriggeraudiozone(1);
  thread _id_F957();
  scripts\engine\utility::flag_init("returndeck_walkntalk_complete");
  scripts\engine\utility::flag_init("return_elevator_arrived");
}

_id_CDE2() {
  var_0 = 1;
  _id_CE92();
  level._id_828C _id_1375C(level._id_EA2C, 180);
  _id_CE93(var_0);
  scripts\engine\utility::flag_wait("returndeck_walkntalk_complete");
  _id_55A1();
  _id_CE91(var_0);
}

_id_CE92() {
  level._id_EA2C thread _id_0B6A::_id_EC0A("shipcrib_titan_jackal_salter_elevator_wait");
  wait 1;
  thread _id_6254();
  thread _id_E46E();
  level._id_828C thread _id_0B6A::_id_EC0A("shipcrib_titan_jackal_airboss_wait2");
}

_id_CE93(var_0) {
  if(var_0) {
    var_1 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
    var_2 = _id_7B74(var_1, level._id_828C, "elevator_depart");
    level._id_828C _id_0B6A::_id_EC0A(var_2);
    var_2 delete();
  } else
    level._id_828C thread _id_0B6A::_id_EC0B("shipcrib_titan_jackal_airboss_elevator", "stand_hands_tied_idle");
}

_id_CE91(var_0) {
  if(var_0) {
    level._id_EA2C thread scripts\sp\utility::_id_10346("sc_titan_slt_letsgetuptotheb");
    level._id_EA2C thread scripts\sp\utility::_id_77B7("move_up");
    thread _id_CD2A();
  } else if(distance(level.player.origin, level._id_EA2C.origin) > 400) {
    level._id_828C _id_0B6A::_id_EC0A(_id_0EFB::_id_EFDB("return_elevator"));
    level._id_EA2C _id_0B6A::_id_EC0A("shipcrib_titan_jackal_salter_console_wait");
    _id_1375E(level._id_EA2C, 400);
    level._id_EA2C scripts\sp\utility::_id_7799(level.player);
    level._id_EA2C _id_0B6A::_id_EC0A("shipcrib_titan_jackal_salter_console_exit");
    level._id_EA2C thread scripts\sp\utility::_id_77A9(_id_0EEB::_id_7976("return"));
    level._id_EA2C thread scripts\sp\utility::_id_77B7("move_up");
    level._id_EA2C thread scripts\sp\utility::_id_10346("sc_titan_slt_letsgetuptotheb");
  } else
    level._id_828C _id_0EE5::_id_202D(5, "Nice work down on Europa.");

  scripts\engine\utility::flag_wait("return_elevator_arrived");
  level._id_EA2C _id_0B6A::_id_EC0A("shipcrib_titan_jackal_salter_elevator_on");
  _id_FA25();
}

_id_E46E() {
  level._id_EA2C scripts\sp\narrative::_id_10348("sc_titan_slt_BossChasesupportprepped", "moving_to_bridge");
  level._id_828C thread scripts\sp\utility::_id_77B7("salute");
  level._id_828C scripts\sp\narrative::_id_10348("sc_titan_gbs_AlloveritGot", "moving_to_bridge");
  level._id_EA2C thread scripts\sp\utility::_id_77A9(level._id_828C);
  level._id_EA2C scripts\sp\narrative::_id_10348("sc_titan_slt_RogerthatThingo", "moving_to_bridge");
  level._id_828C thread scripts\sp\utility::_id_77B7("salute");
  level._id_828C scripts\sp\narrative::_id_10348("sc_titan_gbs_Illholdmyapplause", "moving_to_bridge");
  scripts\engine\utility::flag_set("returndeck_walkntalk_complete");
}

_id_6254() {
  wait 0.75;
  level._id_EA2C scripts\sp\utility::_id_7799(level._id_828C, 2, 0.5);
  level._id_EA2C scripts\sp\utility::_id_13861("on", level._id_828C);
  wait 0.5;
  level._id_828C scripts\sp\utility::_id_7799(level._id_EA2C, 2, 0.5);
  level._id_828C scripts\sp\utility::_id_13861("on", level._id_EA2C);
}

_id_55A1() {
  level._id_EA2C scripts\sp\utility::_id_77B9(0.75);
  level._id_828C scripts\sp\utility::_id_77B9(0.75);
  level._id_828C scripts\sp\utility::_id_13861("off", level._id_EA2C);
  level._id_EA2C scripts\sp\utility::_id_13861("off", level._id_828C);
}

_id_F957() {
  level thread _id_0B21::_id_5A43("deck_return_elevator", "locked");
  level thread _id_0EEB::_id_60FD("return", "Moon Stop", 1);
}

_id_F220() {
  level thread _id_0EEB::_id_60F0("return", 100);
  level thread _id_0EEB::_id_60FD("return", "Flight Deck");
  _id_0EEB::_id_7976("return") waittill("move_finished");
  _id_0EEB::_id_7976("return") notify("doors_open");
  level _id_0B21::_id_5A43("deck_return_elevator", "open");
  scripts\engine\utility::flag_set("return_elevator_arrived");
}

_id_A81C(var_0, var_1) {
  var_2 = _id_0EE1::_id_7C10("a");
  var_3 = _id_0EE1::_id_7C10("b");
  var_4 = var_2._id_A056;
  var_5 = var_3._id_A056;
  _id_0EE4::_id_984E();
  level._id_1312A thread _id_0EE4::_id_CE73(var_3, "entrance");
  thread _id_0EE4::_id_DC44("jackal_bridge_02");
  scripts\engine\utility::flag_wait_all("return_player_catwalk", "jackal_valet_ready");
  var_2 thread _id_0EE4::_id_B0D6();
  thread _id_0EE4::_id_DC44("jackal_bridge_01");
}

_id_1375C(var_0, var_1) {
  while(distance2d(self.origin, var_0.origin) > var_1)
    wait 0.1;
}

_id_1375E(var_0, var_1) {
  while(distance(level.player.origin, var_0.origin) > var_1)
    wait 0.1;
}

_id_2BA9(var_0) {
  self endon("death");
  level.player endon("death");
  var_0 = squared(var_0);

  for(var_1 = scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin); var_1 > var_0; var_1 = scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin))
    scripts\engine\utility::waitframe();
}

#using_animtree("generic_human");

_id_CCC4(var_0, var_1, var_2, var_3) {
  self _meth_82AC(%add_gesture, 1, 0.01, 1);
  self _meth_82AC(var_0, 1, 0.2, 1);
  self[[var_1]](var_2, var_3);
}

_id_EC05(var_0) {
  self _meth_82AC(%add_gesture, 1, 0.01, 1);
  self _meth_82AC(var_0, 1, 0.2, 1);
  wait(getanimlength(var_0));
}

_id_40B0() {
  _id_0EFB::_id_FDBA(level._id_828C);
  _id_0EFB::_id_FDBA(level._id_A6F4);
  _id_0EFB::_id_FDBA(level._id_1312A);

  if(isDefined(level._id_745E)) {
    foreach(var_1 in level._id_745E)
    _id_0EFB::_id_FDBA(var_1);
  }

  if(isDefined(level.player.helmet))
    level.player.helmet delete();
}

_id_DB82() {}

_id_E448() {
  _id_9869();
  _id_0EEB::_id_7976("return").trigger waittill("trigger");
  scripts\engine\utility::flag_set("moving_to_bridge");
  _id_0EEB::_id_7976("return") notify("doors_close");
  level thread _id_0EEB::_id_60F0("return", 64);
  level thread _id_0EEB::_id_60FD("return", "Bridge Level");
  level thread _id_CDE0();
  level thread _id_F8EA();
  _id_0EEB::_id_7976("return") waittill("move_finished");
  level _id_0B21::_id_5A43("return_elevator", "open");
  _id_40B0();
  _id_302F();
}

_id_9869() {
  scripts\engine\utility::flag_init("exiting_return_elevator");
}

_id_FA25() {
  level._id_EA2C notify("stop_loop");
  level _id_0EAD::main();
  level._id_EA2C thread scripts\sp\interaction::_id_CD4B("titan_returnelevator_react", undefined, 1);
}

_id_CDE0() {
  level._id_EA2C scripts\sp\interaction::_id_9A0F();
  var_0 = _id_0EEB::_id_7976("return");
  level._id_EA2C linkTo(var_0);
  level._id_EA2C scripts\sp\anim::_id_1F35(level._id_EA2C, "return_elevator_performance");
  level._id_EA2C unlink();
}

_id_F8EA() {
  level._id_BF2C = scripts\engine\utility::getStruct("newsguy_spawner", "targetname");
  level._id_BF2A = _id_0EF8::_id_FDFC("spawner_marine_casual", "newsguy_spawner");
  level._id_BF2A._id_1FBB = "newsGuy1";
  level._id_BF2A _id_0EFB::_id_FD6F("lounge");
  level._id_BF2B = _id_0EF8::_id_FDFC("spawner_marine_casual", "newsguy_spawner");
  level._id_BF2B._id_1FBB = "newsGuy2";
  level._id_BF2B _id_0EFB::_id_FD6F("lounge");
  var_0 = [level._id_BF2A, level._id_BF2B];
  level._id_BF2C thread scripts\sp\anim::_id_1EE7(var_0, "newsguy_idle", "stop_loop");
}

_id_CD2A() {
  level._id_828C endon("death");
  wait 3;
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_828C, "elevator_depart");
  level._id_828C _id_0B6A::_id_EC0A("shipcrib_titan_jackal_airboss_wait");
  level._id_828C _id_0EE5::_id_202D(5, "Nice work down on Europa.");
}

_id_E44B() {}

_id_302F() {
  _id_955C();
  level endon("entering_bridge_scene");
  thread _id_EA66();
  thread _id_DB83();
  thread _id_CDAD();
  scripts\engine\utility::flag_wait("newsguys_complete");
  _id_CDF3();
}

_id_955C() {
  scripts\engine\utility::flag_init("newsguys_complete");
  scripts\engine\utility::flag_init("salter_atBridgeDoor");
  scripts\engine\utility::flag_init("salter_nagged_bridgehallway");
}

_id_EA66() {
  level._id_EA2C _id_0B6A::_id_EC0A("shipcrib_titan_lounge_salter_wait", undefined, undefined, undefined, undefined, 1);
}

_id_137CB() {
  var_0 = 0;
  var_1 = 3;

  while(!scripts\engine\utility::flag("exiting_return_elevator") && var_0 < var_1) {
    var_0 = var_0 + 0.05;
    scripts\engine\utility::waitframe();
  }
}

_id_CDAD() {
  level._id_BF2A endon("death");
  level._id_BF2B endon("death");
  level._id_BF2A endon("entitydeleted");
  level._id_BF2B endon("entitydeleted");
  var_0 = [level._id_BF2A, level._id_BF2B];
  level._id_BF2C scripts\sp\anim::_id_1F2C(var_0, "newsguy_performance");
  level._id_BF2C notify("stop_loop");
  level._id_BF2C thread scripts\sp\anim::_id_1EEA(level._id_BF2A, "newsguy_idle", "stop_loop");
  level._id_BF2B thread scripts\sp\anim::_id_1ECC(level._id_BF2B, "stand_idle_4", "stop_loop");
  scripts\engine\utility::flag_wait("newsguys_complete");
  wait 1.0;

  while(distance2dsquared(level.player.origin, level._id_BF2C.origin) > squared(200))
    wait 0.05;

  level endon("early_end_broadcast");
  level._id_BF2A _id_0EE9::_id_CD78("sc_moon_un3_ihatewaitinman");
  level._id_BF2B _id_0EE9::_id_CD78("sc_moon_un4_grapesarefuelin");
  level._id_BF2A _id_0EE9::_id_CD78("sc_moon_un3_readytohuntsome");
  level._id_BF2B _id_0EE9::_id_CD78("sc_moon_un4_yeahifeelyou");
  level._id_BF2A _id_0EE9::_id_CD78("sc_moon_un3_whatsupyougood");
  level._id_BF2B _id_0EE9::_id_CD78("sc_moon_un4_stilltryintofig");
  level._id_BF2A _id_0EE9::_id_CD78("sc_moon_un3_screwthatimread");
  level._id_BF2B _id_0EE9::_id_CD78("sc_moon_un4_idontknowman");
  level._id_BF2A _id_0EE9::_id_CD78("sc_moon_un3_whatdontyouknow");
  level._id_BF2B _id_0EE9::_id_CD78("sc_moon_un4_weretrainedtore");
  level._id_BF2A _id_0EE9::_id_CD78("sc_moon_un3_butyouknowwhywe");
  level._id_BF2B _id_0EE9::_id_CD78("sc_moon_un4_yourerightyoure");
}

_id_DB83() {
  level._id_EA2C thread scripts\sp\utility::_id_7799(level._id_BF2A, 1.5, 2);
  wait 2;
  level._id_EA2C scripts\sp\utility::_id_77B9(2);
  wait 2;
  level._id_EA2C thread scripts\sp\utility::_id_7799(level.player, 1.5, 1);
  level._id_EA2C thread scripts\sp\utility::_id_10346("sc_titan_slt_illhangbacknon");
  wait 1.5;
  scripts\engine\utility::flag_set("newsguys_complete");
}

_id_CDF3() {
  level endon("entering_bridge_scene");
  thread _id_EACC();
  _id_EAC7();
}

_id_EAC7() {
  level endon("entering_bridge_scene");
  level._id_EA2C scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_77B9, 3);
  level._id_EA2C _id_0B6A::_id_EC0B("shipcrib_titan_bridge_salter_wait", "shipcrib_stand_stationary_talk_idle_02");
  scripts\engine\utility::flag_set("salter_atBridgeDoor");
  level._id_EA2C thread _id_0EE5::_id_DB62("entering_bridge_scene", level);

  if(!scripts\engine\utility::flag("salter_nagged_bridgehallway")) {
    level._id_EA2C _id_0EE5::_id_202D("stand_idle_2_left_reaction", "shipcrib_slt_letskeepthisonatight");
    level._id_EA2C scripts\sp\interaction::_id_DE14(400);
  } else {
    wait 3;
    level._id_EA2C _id_0EE5::_id_202D(2);
  }
}

_id_EACC() {
  level endon("entering_bridge_scene");
  scripts\engine\utility::flag_wait("bridge_hallway_commit");

  if(!scripts\engine\utility::flag("salter_atBridgeDoor")) {
    scripts\engine\utility::flag_set("salter_nagged_bridgehallway");
    level._id_EA2C scripts\sp\utility::_id_13861("on", level.player, "right");
    level._id_EA2C scripts\sp\utility::_id_10346("shipcrib_slt_letskeepthisonatight");
    wait 5;
    level._id_EA2C scripts\sp\utility::_id_13861("off", level.player, "right");
    level._id_EA2C scripts\sp\interaction_manager::_id_45A6();
  }
}

_id_3A31() {
  level thread scripts\sp\interaction_manager::_id_C9C4();
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3A32);
  level _id_0B20::_id_AB71(self, "right_push", 0.4);
}

_id_3A32() {
  level thread scripts\sp\interaction_manager::_id_45A9();
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3A31);
  level _id_0B20::_id_AB71(self, "right_pull", 0.4);
}

_id_307C() {
  if(!level.console) {
    while(!scripts\engine\utility::flag(level.script + "_bridgee_tr_loaded")) {
      waitforalltransients();
      wait 0.15;
    }
  }

  level notify("entering_bridge_scene");
  _id_0EDB::early_out_broadcast();
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_EA2C scripts\sp\utility::_id_77B9(0.33);
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  level _id_0B20::_id_AB71(self, "left_push_long", 0.4, ::_id_307E, 1, 0.6);
  level._id_EFED = "inside_slow";
}

_id_307E() {
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C683("solar_system", undefined, 1);
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C642();
  level thread _id_0B20::_id_5A52("bridge", ::_id_3080);
  setmusicstate("");
  _id_0EF7::_id_ADF7();
  level _id_30AC();
  level thread _id_10AB::_id_300C();
  level thread scripts\sp\interaction_manager::_id_F2A7("nag", "opsmap");
  level scripts\engine\utility::delaythread(0.0, ::_id_309C);
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_titan_slt_whereareweaimin");
  level._id_76FB scripts\sp\interaction_manager::_id_DB7B("sc_titan_nav_Whereareweheaded");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("titan_sc_slt_OpsmapsupdatedLets");
  level thread scripts\sp\interaction_manager::_id_E815(45.0);
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_76FB, "SH4_2_1_SH_TTN_BR_PRE_NAV_steeldrag_idle", "stop_gator_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_1044B, "SH4_2_1_SH_TTN_BR_PRE_BSN_monitor_idle", "stop_sotomura_loop");
  level._id_5CFC._id_C6AC = scripts\sp\utility::_id_10639("optics");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_5CFC._id_C6AC, "SH4_2_1_SH_TTN_BR_PRE_DO_prop_steeldrag_idle", "stop_do_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_5CFC, "SH4_2_1_SH_TTN_BR_PRE_DO_steeldrag_idle", "stop_do_loop");
  wait 0.75;
  level scripts\engine\utility::delaythread(0.5, _id_0EDC::_id_2FF7);
  wait 1.5;
  level scripts\engine\utility::delaythread(3, ::_id_3085);
  level._id_EA2C scripts\sp\utility::_id_415D("casual");
  level._id_EA2C thread _id_1F39(var_0, "SH4_2_1_SH_TTN_BR_PRE_XO_intro", _id_0EF1::_id_7AED("salter_opsmap_reaction"), "opsmap_salter_react");
  var_0 notify("stop_sotomura_loop");
  level._id_1044B thread _id_1F39(var_0, "SH4_2_1_SH_TTN_BR_PRE_BSN_intro", undefined, "opsmap_boats_react");
  wait 2.5;
  var_0 notify("stop_gator_loop");
  level._id_76FB thread _id_1F39(var_0, "SH4_2_1_SH_TTN_BR_PRE_NAV_intro", _id_0EF1::_id_7AED("gator_opsmap_reaction"), "opsmap_gator_react");
  wait 3.3;
  var_0 notify("stop_do_loop");
  var_1 = ["titan_sc_un2_telemetryislookinggood"];
  level._id_5CFC thread _id_1F3A(var_0, "SH4_2_1_SH_TTN_BR_PRE_DO_intro", var_1);
}

_id_307F() {
  level notify("entering_bridge_scene");
  level._id_EFED = "inside_slow";
  level _id_0B20::_id_AB71(self, "left_push", 0.4);
  level thread _id_0B20::_id_5A52("bridge", ::_id_3080);
  level thread scripts\sp\interaction_manager::_id_45A9();
}

_id_3080() {
  level notify("exiting_bridge_scene");
  level._id_EFED = "inside";
  level _id_0B20::_id_AB71(self, "left_pull", 0.4);
  level thread _id_0B20::_id_5A52("bridge", ::_id_307F);
  level thread scripts\sp\interaction_manager::_id_C9C4();
}

_id_4454(var_0) {
  level._id_4451 scripts\sp\anim::_id_1F35(level._id_4451, "SH4_2_2a_SH_TTN_BR_BRIEF_COMM_station_respond");
  level._id_4451 thread scripts\sp\interaction::_id_CD50(level._id_4451._id_9A30);
}

_id_1044C(var_0) {
  var_1 = level._id_C6AA["retribution"]._id_EF67;
  var_1 scripts\sp\anim::_id_1F35(level._id_1044B, "SH4_2_2a_SH_TTN_BR_BRIEF_BSN_station_respond");
}

_id_7715(var_0) {
  var_1 = level._id_C6AA["retribution"]._id_EF67;
  level._id_76FB thread _id_1F39(var_1, "SH4_2_2a_SH_TTN_BR_BRIEF_NAV_outro", undefined, "opsmap_gator_react");
}

_id_188E(var_0) {
  self endon("death");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_RainmanLieutenantSalter", level._id_188A, "retribution_bridge_speaker_monitor_main");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_ImsureDoesshe", level._id_188A, "retribution_bridge_speaker_monitor_main");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_thefsparwasahighly", level._id_188A, "retribution_bridge_speaker_monitor_main");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_desperatetimesc", level._id_188A, "retribution_bridge_speaker_monitor_main");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_Excellentkeepitbetween", level._id_188A, "retribution_bridge_speaker_monitor_main");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_Justgotauthorizationfrom", level._id_188A, "retribution_bridge_speaker_monitor_cic");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_LowTerrainsforshit", level._id_188A, "retribution_bridge_speaker_monitor_cic");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_youlllandatransport", level._id_188A, "retribution_bridge_speaker_monitor_cic");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_affirmativethis", level._id_188A, "retribution_bridge_speaker_monitor_cic");
  level waittill("speakers");
  level thread _id_2FEE("sc_titan_adm_GodspeedTopCatout", level._id_188A, "retribution_bridge_speaker_monitor_cic");
}

_id_188D(var_0) {
  level notify("light_admiral_video");
  level _id_0EF3::_id_FD78("admiral_main", "sc_titan_adm_bridge");
  scripts\engine\utility::flag_set("adm_brief_done");
}

_id_3077() {
  level thread scripts\sp\utility::_id_12651(["shipcrib_titan_halore_tr", "shipcrib_titan_ambientmr_tr"]);
  level notify("bridge_scene_started");
  level thread _id_0B20::_id_5A52("bridge", ::_id_3080);
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level._id_C6AA["retribution"] thread scripts\engine\utility::delaythread(1, _id_0EDE::_id_C670, "down");
  level thread scripts\sp\interaction_manager::_id_11037();
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = _id_0EFB::_id_7D7A("admirals_office");

  if(isDefined(level._id_FD6E) && isDefined(level._id_FD6E._id_5D89))
    level._id_FD6E._id_5D89 delete();

  level thread _id_0E79::main();
  level thread _id_0E7A::main();
  level thread _id_0EE4::_id_E37A();
  level._id_30BD notify("stop_ffa");
  level._id_30BD thread _id_0B6A::_id_EC0D(_id_0EFB::_id_EFDB("sysend"));
  level._id_30C2 notify("stop_ffa");
  level._id_30C2 thread _id_0B6A::_id_EC0D(_id_0EFB::_id_EFDB("nav3"));
  level thread _id_4416();
  scripts\sp\anim::_id_17F6("gator", "vo_sc_titan_nav_allhandsconditi", ::_id_7713, "SH4_2_2a_SH_TTN_BR_BRIEF_NAV_intro");
  scripts\sp\anim::_id_17F6("gator", "playanim_SH4_2_2a_SH_TTN_BR_BRIEF_COMM_station_respond", ::_id_4454, "SH4_2_2a_SH_TTN_BR_BRIEF_NAV_intro");
  scripts\sp\anim::_id_17F6("gator", "playanim_SH4_2_2a_SH_TTN_BR_BRIEF_BSN_station_respond", ::_id_1044C, "SH4_2_2a_SH_TTN_BR_BRIEF_NAV_intro");
  scripts\sp\anim::_id_17FC("gator", "playanim_XO_screen_01", "salter_screen_01", "SH4_2_2a_SH_TTN_BR_BRIEF_NAV_intro");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH4_2_2a_SH_TTN_BR_BRIEF_MONITOR_intro");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_CACE["nav"], "SH4_2_2a_SH_TTN_BR_BRIEF_NAV_phone_intro");
  level._id_76FB thread _id_1F39(var_0, "SH4_2_2a_SH_TTN_BR_BRIEF_NAV_intro", undefined, "opsmap_gator_react");
  level._id_5CFC thread _id_1F39(var_0, "SH4_2_2a_SH_TTN_BR_BRIEF_DO_intro", undefined, "opsmap_drops_react");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH4_2_2a_SH_TTN_BR_BRIEF_XO_intro");
  level._id_EA2C setgoalpos(level._id_EA2C.origin);
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "SH4_2_2a_SH_TTN_BR_BRIEF_XO_screen_idle", "stop_salter_loop");
  level._id_30C2 thread _id_0B6A::_id_EC0A(_id_0EFB::_id_EFDB("nav2"));
  _id_0EFB::_id_7D7A("retribution_bridge_speaker_monitor_main") _id_0EE4::_id_FE0D(260, undefined, 0.4);
  level._id_30BD scripts\engine\utility::delaythread(2, _id_0B6A::_id_EC0A, _id_0EFB::_id_EFDB("drop"));
  var_0 notify("stop_salter_loop");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH4_2_2a_SH_TTN_BR_BRIEF_XO_screen_01");
  level._id_EA2C thread scripts\sp\interaction::_id_CD4B("sh4_2_2b_sh_ttn_br_brief_rs_xo");
  level._id_EA2C thread scripts\sp\interaction_manager::_id_12753();
  level scripts\engine\utility::delaythread(0.4, ::_id_188D);
  level._id_EA2C waittillmatch("single anim", "play_adm_screen_arrive");
  wait(getanimlength(level._id_EC85["admiral"]["SH4_2_2a_SH_TTN_BR_BRIEF_ADM_screen_arrive"]));
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH4_2_2a_SH_TTN_BR_BRIEF_XO_screen_02");
  level._id_EA2C orientmode("face angle", level._id_EA2C.angles[1]);
  level._id_EA2C scripts\sp\utility::_id_F40E("casual", "shipcrib_stand_idle05_vig_02");
  level._id_EA2C scripts\engine\utility::delaythread(1.25, scripts\sp\utility::_id_10346, "sc_titan_slt_Paybackisabitch");
  level._id_EA2C scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_10346, "sc_titan_slt_activatethecombat");
  level._id_1044B scripts\engine\utility::delaythread(5.0, scripts\sp\utility::_id_10346, "sc_titan_us2_Ayesir");
  var_2 = 2;
  scripts\engine\utility::flag_wait("adm_brief_done");
  level._id_1044B _id_0EE5::_id_10FC4();
  var_0 scripts\engine\utility::delaythread(1, scripts\sp\anim::_id_1F35, level._id_1044B, "SH4_2_2a_SH_TTN_BR_BRIEF_BSN_cic_arrive");
  level._id_1044B scripts\engine\utility::delaythread(getanimlength(level._id_1044B scripts\sp\utility::_id_7DC1("SH4_2_2a_SH_TTN_BR_BRIEF_BSN_cic_arrive")), scripts\sp\interaction::_id_CD50, "opsmap_boats_react");
  wait 0.5;
  level thread _id_0EE4::_id_E381("sc_titan_world_cic_briefing");
  level._id_EA2C scripts\sp\anim::_id_1F35(level._id_EA2C, "shipcrib_stand_idle05_exit");
  level._id_EA2C.a.movement = "stop";
  var_0 scripts\sp\anim::_id_1F0D(level._id_EA2C, "SH4_2_2a_SH_TTN_BR_BRIEF_XO_cic_idle");
  level._id_EA2C scripts\sp\utility::_id_F40E("casual", "SH4_2_2a_SH_TTN_BR_BRIEF_XO_cic_idle");
  level thread _id_307B();
  level._id_76FB _id_0EE5::_id_2037("opsmap_gator_react", "sc_titan_gtr_illletyouknowwhen");
  level._id_5CFC _id_0EE5::_id_2037("opsmap_drops_react", "sc_titan_dpo_shiftaccuracyis");
  level._id_4451 _id_0EE5::_id_2037("opsmap_comms_react", "sc_titan_cmo_communications");
  _id_0EFB::_id_7D7A("retribution_bridge_cic_lookat_center") _id_0EE4::_id_FE0D(340, (0, 0, 0), 0.4);
  level._id_30C2 scripts\engine\utility::delaythread(randomfloatrange(1, 3), _id_10AB::_id_300A);
  level._id_30BD scripts\engine\utility::delaythread(randomfloatrange(1, 3), _id_10AB::_id_300A);
  level notify("shipcrib_play_cic_briefing");
  level._id_76FB _id_0EE5::_id_2037("opsmap_gator_react");
  level._id_5CFC _id_0EE5::_id_2037("opsmap_drops_react");
  level._id_4451 _id_0EE5::_id_2037("opsmap_comms_react");
  level._id_1044B thread _id_3091(var_0, "SH4_2_2a_SH_TTN_BR_BRIEF_BSN_cic_01", _id_0EFB::_id_EFDB("cic"));
  scripts\sp\anim::_id_17F6("salter", "playanim_SH4_2_2a_SH_TTN_BR_BRIEF_NAV_outro", ::_id_7715, "SH4_2_2a_SH_TTN_BR_BRIEF_XO_cic_01");
  level._id_EA2C.a.movement = "walk";
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH4_2_2a_SH_TTN_BR_BRIEF_XO_cic_01");
  level._id_1044B thread _id_0B6A::_id_EC0A(_id_0EFB::_id_EFDB("boats"));
  level._id_EA2C _id_0B6A::_id_EC04();
  level._id_EA2C scripts\sp\utility::_id_415D("casual");
  level._id_EA2C _id_0B6A::_id_EC0A(level._id_C6AA["retribution"]._id_10E52["xo"]);
  level._id_EA2C scripts\engine\utility::delaythread(0, scripts\sp\utility::_id_10346, "sc_titan_slt_Letsleap");
  level thread _id_308D();
  level._id_1044B _id_0EE5::_id_2037("opsmap_boats_react", "sc_titan_bts_terriblethingshapp");
  level._id_5CFC _id_0EE5::_id_2037("opsmap_drops_react", "sc_titan_dpo_accuracyestim");
  level _id_3088();
}

_id_3088() {
  if(isDefined(level._id_FD6E._id_5D89)) {
    level._id_FD6E._id_5D89 delete();
    level thread _id_0EFB::_id_FE0C();
  }

  level thread scripts\sp\utility::_id_12651(["shipcrib_titan_dropship_tr", "shipcrib_titan_halore_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_titan_mezz_tr", "shipcrib_titan_hangar_tr", "shipcrib_titan_ambient_tr", "shipcrib_titan_vr_tr", "shipcrib_titan_ambientml_tr"]);
  level notify("bridge_scene_started");
  thread _id_0EEE::_id_25B3();
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_C6AA["retribution"] thread _id_11978();
  level thread scripts\sp\interaction_manager::_id_11037();
  level thread _id_0EE4::_id_E37A();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level thread _id_0EEE::_id_FD8B(0);
  level.player playSound("shipcrib_titan_walla_pre_ftl");
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(2.5, _id_0EDE::_id_C683, "ftl", "titan");
  level notify("ftl triggered");
  level waittill("ftl_linkto_done");
  level._id_30BD notify("stop_ffa");
  level._id_30BD thread _id_0B6A::_id_EC0D(_id_0EFB::_id_EFDB("sysend"));
  level._id_30C2 notify("stop_ffa");
  level._id_30C2 thread _id_0B6A::_id_EC0D(_id_0EFB::_id_EFDB("nav3"));
  level._id_FD6E._id_7498["freq_min"] = 12;
  level._id_FD6E._id_7498["freq_max"] = 17;
  level._id_FD6E._id_7498["pitch_min"] = 0.45;
  level._id_FD6E._id_7498["pitch_max"] = 0.65;
  level._id_FD6E._id_7498["yaw_min"] = 0.45;
  level._id_FD6E._id_7498["yaw_max"] = 0.65;
  level._id_FD6E._id_7498["roll_min"] = 0.8;
  level._id_FD6E._id_7498["roll_max"] = 1.0;
  level thread _id_0EEE::_id_FD89("titan", "retribution", undefined, ::_id_496A, 7.15);
  scripts\sp\anim::_id_17FC("salter", "FTL_end_3_sec", "ftl_3_sec_left", "SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop");
  scripts\sp\anim::_id_17FC("salter", "FTL_end", "ftl_stop", "SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_titan_slt_alwaysboatstake2", "salter_tells_boats", "SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop");
  scripts\sp\anim::_id_17FC("gator", "vo_sc_titan_slt_Awayinfivefour", "salter_pa_jump_line", "SH4_2_3_SH_TTN_BR_OPS_NAV_ftl_drop");
  scripts\sp\anim::_id_17F6("salter", "vo_sc_titan_slt_Standdowntocondition", ::_id_EACE, "SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop");
  level._id_EA2C thread _id_1F39(var_0, "SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop", undefined, "opsmap_salter_react");
  level._id_1044B thread _id_3091(var_0, "SH4_2_3_SH_TTN_BR_OPS_BSN_ftl_drop", _id_0EFB::_id_EFDB("boats"));
  level._id_5CFC thread _id_1F39(var_0, "SH4_2_3_SH_TTN_BR_OPS_DO_ftl_drop", undefined, "opsmap_drops_react");
  level thread _id_1197B();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_CACE["nav"], "SH4_2_3_SH_TTN_BR_OPS_NAV_phone_ftl_drop");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH4_2_3_SH_TTN_BR_OPS_NAV_MONITOR_ftl_drop");
  level._id_76FB thread _id_1F39(var_0, "SH4_2_3_SH_TTN_BR_OPS_NAV_ftl_drop", undefined, "opsmap_gator_react");
  var_1 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("SH4_2_3_SH_TTN_BR_OPS_XO_ftl_drop"));
  wait 7.15;
  physicsjolt(level.player.origin, 501, 500, anglestoright(level.player.angles) * 0.2);
  level waittill("ftl_stop");
  level.player playSound("shipcrib_titan_walla_post_ftl");
  level._id_4451 _id_0EE5::_id_2037("opsmap_comms_react");
  level._id_1044B _id_0EE5::_id_2037("opsmap_boats_react");
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(4, _id_0EDE::_id_C696);
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level scripts\engine\utility::delaythread(4, _id_0EEE::_id_FD8A, 3);
  level._id_30C2 scripts\engine\utility::delaythread(randomfloatrange(1, 3), _id_10AB::_id_300A);
  level._id_30BD scripts\engine\utility::delaythread(randomfloatrange(1, 3), _id_10AB::_id_300A);
  level waittill("salter_tells_boats");
  wait 1;
  level._id_EA2C thread _id_EAC3(var_0);
  level thread _id_AB12();
}

_id_1197B() {
  level waittill("salter_pa_jump_line");
  level.player scripts\sp\utility::play_sound_on_entity("sc_titan_slt_Awayinfivefour_pa");
}

_id_11977() {
  self._id_7488 thread _id_0E46::_id_48C4(undefined, undefined, undefined, 45, 750, 50, 0);
  self._id_7488 waittill("trigger");
  level notify("ftl triggered");
}

#using_animtree("player");

_id_11978() {
  var_0 = self._id_EF68;
  var_1 = % sh4_2_3_sh_ttn_br_ops_plr_ftl;
  level.player playerlinkTo(self._id_1339A, "tag_player");
  level.player _meth_823C(self._id_1339A, "tag_player", 0.05);
  self._id_1339A.origin = getstartorigin(self._id_EF68.origin, self._id_EF68.angles, var_1);
  self._id_1339A.angles = getstartangles(self._id_EF68.origin, self._id_EF68.angles, var_1);
  self._id_1339A clearanim(%opsmap, 0);
  self._id_1339A _meth_82E2("single anim", var_1, 1, 0, 0);
  self._id_1339A thread scripts\sp\anim::_id_10CBF(self._id_1339A, "single anim");
  self._id_1339A thread scripts\sp\anim::_id_1FCA(self._id_1339A, "single anim");
  wait 0.1;
  level notify("ftl_linkto_done");
  level.player playerlinktodelta(self._id_1339A, "tag_player", 0, 15, 15, 15, 0, 1);
  level.player _meth_8392(0.2, 2.2, 0.6);
  level notify("player_ftl_ready");
  thread _id_0EDE::_id_C658("SH4_2_3_SH_TTN_BR_OPS_PLR_ftl_keycard");
  level thread _id_11979();
  self._id_1339A _meth_82B1(var_1, 1);
  wait(getanimlength(var_1));
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C670("down");
  level.player unlink();
  self._id_1339A hide();
}

_id_11979() {
  var_0 = level._id_C6AA["retribution"]._id_EF68;
  var_1 = level._id_C6AA["retribution"]._id_454F["captain"];
  var_1._id_1FBB = "shipcrib_cap_console";
  var_1 scripts\sp\anim::_id_1F35(var_1, "SH4_2_3_SH_TTN_BR_OPS_PLR_ftl_table");
}

_id_7713(var_0) {
  level.player playSound("sc_titan_nav_allhandsconditi_pa");
}

_id_EACE(var_0) {
  level.player playSound("sc_titan_slt_Standdowntocondition_pa");
}

_id_EAC3(var_0) {
  while(distance(level.player.origin, level._id_EA2C.origin) < 180)
    scripts\engine\utility::waitframe();

  thread _id_1F39(var_0, "SH4_2_3_SH_TTN_BR_OPS_XO_to_plr_ops", undefined, "opsmap_conn_react_alert");
}

#using_animtree("generic_human");

_id_AB0C() {
  level._id_1044B endon("death");
  level._id_1044B scripts\sp\utility::_id_10346("sc_titan_abn_threedecadessinceweve");
  level._id_1044B setanimknob(%facial_upbeat_idle_boats, 10, 0.05, 1);
  level.player scripts\sp\utility::_id_1034D("sc_titan_plr_TrialbyfireNassir");
}

_id_3085() {
  if(!scripts\engine\utility::flag("shipcrib_titan_dropship_tr_loaded")) {
    return;
  }
  var_0 = getEnt("shipcrib_titan_bridge_mccallum_dropship", "targetname");
  var_1 = var_0 scripts\sp\vehicle::_id_1080B();
  var_1 vehicle_setspeedimmediate(100);
  var_1 notify("stop_kicking_up_dust");
  level._id_FD6E._id_5D89 = var_1;
  level._id_FD6E._id_5EE3["bridge"] = var_1;
}

_id_309C() {
  level endon("exiting_bridge_scene");
  level._id_3014 thread _id_309B(undefined, undefined, "shipcrib_brdg_srvr1_salute_01");
  level._id_3015 thread _id_309B(undefined, undefined, "shipcrib_brdg_srvr2_salute_01");
  level._id_3016 thread _id_309B(undefined, undefined, "shipcrib_brdg_srvr1_salute_01");
  level._id_30C4 thread _id_309B(undefined, undefined, "shipcrib_brdg_door1_salute_01");
  level._id_30BD thread _id_30A0();
  level._id_30C2 thread _id_30A1();
  level scripts\engine\utility::delaythread(10.0, _id_0EF0::_id_FD75, "navigation");
  level scripts\engine\utility::delaythread(10.0, _id_0EF0::_id_FD75, "tactical");
}

_id_30A0() {
  self endon("death");
  thread scripts\sp\anim::_id_1ECC(self, "shipcrib_brdg_tac3_salute_idle", "stop_loop");
  wait 3;
  self notify("stop_loop");
  thread scripts\sp\anim::_id_1EC7(self, "shipcrib_brdg_sys3_salute");
  wait(getanimlength(%shipcrib_salute_reaction_l90_01) * 0.5);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  _id_0B6A::_id_EC0A(_id_0EFB::_id_EFDB("sysend"));
  level._id_FD6E._id_300A["taken"] = scripts\engine\utility::array_add(level._id_FD6E._id_300A["taken"], "sysend");
  wait 20;

  while(!scripts\engine\utility::flag("allow_bridge_ffa_move") || scripts\engine\utility::flag("bridge_ffa_in_transit") || distance2d(self.origin, level.player.origin) <= 200.0)
    wait 0.05;

  thread _id_10AB::_id_300A();
  self waittill("sceneblock_reach_finished");
  level._id_FD6E._id_300A["taken"] = scripts\engine\utility::array_remove(level._id_FD6E._id_300A["taken"], "sysend");
}

_id_30A1() {
  self endon("death");
  thread scripts\sp\anim::_id_1ECC(self, "shipcrib_brdg_tac3_salute_idle", "stop_loop");
  wait 3.5;
  self notify("stop_loop");
  thread scripts\sp\anim::_id_1EC7(self, "shipcrib_brdg_tac3_salute");
  wait(getanimlength(%shipcrib_salute_reaction_l00_01) * 0.64);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  _id_0B6A::_id_EC0A(_id_0EFB::_id_EFDB("nav3"));
  level._id_FD6E._id_300A["taken"] = scripts\engine\utility::array_add(level._id_FD6E._id_300A["taken"], "nav3");
  wait 21;

  while(!scripts\engine\utility::flag("allow_bridge_ffa_move") || scripts\engine\utility::flag("bridge_ffa_in_transit") || distance2d(self.origin, level.player.origin) <= 200.0)
    wait 0.05;

  thread _id_10AB::_id_300A();
  self waittill("sceneblock_reach_finished");
  level._id_FD6E._id_300A["taken"] = scripts\engine\utility::array_remove(level._id_FD6E._id_300A["taken"], "nav3");
}

_id_309B(var_0, var_1, var_2) {
  self endon("death");
  self endon("stop_ffa");

  if(!isDefined(var_0))
    var_0 = 0.0;

  if(!isDefined(var_1))
    var_1 = 0.2;

  wait(randomfloatrange(var_0, var_1));
  scripts\sp\interaction::_id_9A0F();
  scripts\engine\utility::waitframe();
  scripts\sp\anim::_id_1EC7(self, var_2);

  if(isDefined(self._id_10C01))
    thread scripts\sp\interaction_manager::_id_CE40(self._id_10C01._id_EE92);
}

_id_1F39(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("bridge_scene_started");
  self notify("stop_animsingle_then_gesture");
  self endon("stop_animsingle_then_gesture");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_0 scripts\sp\anim::_id_1F35(self, var_1);

  if(issubstr(var_3, "opsmap")) {
    if(self._id_1FBB == "salter" || self._id_1FBB == "gator" || self._id_1FBB == "drop_officer")
      thread _id_0EFB::_id_CD3F(var_3);
    else
      thread scripts\sp\interaction::_id_CD50(var_3);
  }

  if(isDefined(var_2))
    thread _id_0EE5::_id_202D(undefined, var_2);
  else
    thread _id_0EE5::_id_202D();
}

_id_1F3A(var_0, var_1, var_2) {
  self endon("death");
  level endon("bridge_scene_started");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_0 thread scripts\sp\anim::_id_1F35(self._id_C6AC, "SH4_2_1_SH_TTN_BR_PRE_DO_prop_intro");
  var_0 scripts\sp\anim::_id_1F35(self, var_1);
  thread _id_0EFB::_id_CD3F("opsmap_drops_react");
  scripts\sp\interaction_manager::_id_DB71(var_2);
  thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
}

_id_3091(var_0, var_1, var_2) {
  self endon("death");
  level endon("bridge_scene_started");
  self endon("stop_bridge_scene");

  if(!scripts\sp\utility::_id_65DF("bridge_scene_end"))
    scripts\sp\utility::_id_65E0("bridge_scene_end");

  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_0 scripts\sp\anim::_id_1F35(self, var_1);

  if(issubstr(var_2._id_EE92, "opsmap")) {
    if(self._id_1FBB == "salter" || self._id_1FBB == "gator" || self._id_1FBB == "drop_officer")
      thread _id_0EFB::_id_CD3F(var_2._id_EE92);
    else
      thread scripts\sp\interaction::_id_CD50(var_2._id_EE92);
  } else if(scripts\sp\interaction::_id_9CD7(var_2))
    thread scripts\sp\interaction_manager::_id_CE40(var_2._id_EE92);

  scripts\sp\utility::_id_65E1("bridge_scene_end");
}

_id_307B() {
  self endon("death");
  level endon("shipcrib_play_cic_briefing");
  level._id_EA2C endon("death");
  wait 30;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_titan_slt_captainletsget");
}

_id_308D() {
  self endon("death");
  level endon("ftl triggered");
  level._id_EA2C endon("death");
  level._id_76FB endon("death");
  wait 30;
  level._id_76FB scripts\sp\utility::_id_10346("sc_titan_nav_fulloscillationcapn");
  wait 60;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_titan_slt_letsgetunderwaycaptain");
}

_id_3092() {
  self endon("death");
  level endon("ab triggered");
  level._id_EA2C endon("death");
  level._id_1044B endon("death");
  wait 0.5;
  level._id_1044B scripts\sp\utility::_id_10346("sc_titan_us1_sergeantomarssetup");
  wait 5;
  level._id_EA2C clearanim(%shipcrib_titan_talking, 0.2);
  level._id_EA2C scripts\sp\utility::_id_10346("sc_titan_slt_notgonnaleta");
}

_id_2FEE(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_1 thread scripts\sp\utility::_id_10347(var_0);

  var_3 = getEntArray(var_2, "targetname");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_4 + 1 == var_3.size) {
      var_3[var_4] scripts\sp\utility::_id_10347(var_0);
      continue;
    }

    var_3[var_4] thread scripts\sp\utility::_id_10347(var_0);
  }
}

_id_30AC() {
  _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_10E52["nav"]);
  level._id_76FB _id_0EFB::_id_FE0B();
  _id_0EF8::_id_FDFC("spawner_drop_officer", level._id_C6AA["retribution"]._id_10E52["drop"]);
  level._id_5CFC _id_0EFB::_id_FE0B();
  _id_0EF8::_id_FDFC("spawner_sotomura", _id_0EFB::_id_EFDB("boats"));
  var_0 = _id_0EF8::_id_FDFC("spawner_comms", "homebase");
  var_0._id_10C01 = var_0._id_907D;
  var_0 scripts\sp\interaction::_id_9A0F();
  var_0 thread scripts\sp\interaction_manager::_id_CD24(85.0, 50.0, "titan_sc_un1_Signalacquisitionisnice");
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_ftl1", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_ftl2", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_ftl3", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac1", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac2", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac4", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac3", "shipcrib_titan_tac3_start");
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys3", "shipcrib_titan_sys3_start");
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys1", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys2", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
}

_id_AB12() {
  _id_AB0B();
  _id_0EEB::_id_7976("bridge").trigger waittill("trigger");
  stopcinematicingame();
  level thread _id_0EE6::_id_2201();
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6();
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6();

  if(!level.console)
    waitforalltransients();

  thread _id_AB10();
  _id_0EEB::_id_60F0("bridge", 75);
  _id_0EEB::_id_60FD("bridge", "Mezzanine");
  scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_ADB1();
  var_0 = getEnt("titan_bridgeelev_player_collision", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  scripts\engine\utility::flag_set("moving_to_mezz");
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_1E0A();
  thread _id_DD6C();
  scripts\engine\utility::flag_wait("bridge_elevator_floor_level_03");
  level._id_FD6E._id_111D6 = 6;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
  _id_0EEB::_id_7976("bridge") waittill("move_finished");
  level thread _id_0B21::_id_5A43("mezzanine_elevator", "open");
  level._id_1044B unlink();
  _id_0EFB::_id_FDBA(level._id_13E12);
  _id_0EFB::_id_FDBA(level._id_76FB);
  level thread scripts\sp\utility::_id_12651(["shipcrib_titan_bridge_tr", "shipcrib_titan_bridgem_tr"]);
  level._id_EFED = "inside";
  _id_2207();
}

_id_AB0B() {
  scripts\engine\utility::delaythread(1.5, _id_0B21::_id_5A43, "bridge_exit", "open");
  level._id_1044B notify("stop_bridge_scene");
  wait 0.05;
  level._id_1044B scripts\sp\anim::_id_1F35(level._id_1044B, "shipcrib_bridge_stand_console_transition_out");
  level._id_1044B.a.movement = "stop";
  level._id_1044B _id_0EE5::_id_10FC4();
  level._id_1044B notify("reaction_end");
  level._id_1044B thread scripts\sp\interaction::_id_9A0F();
  level._id_1044B thread scripts\sp\interaction_manager::_id_11048();
  level._id_1044B _id_0B6A::_id_EC04();
  wait 0.05;
  var_0 = scripts\engine\utility::getStruct("shipcrib_titan_bridge_ab_elevator", "targetname") scripts\engine\utility::spawn_script_origin();
  var_0.origin = var_0.origin + anglestoright(level._id_1044B.angles) * 100;
  wait 0.05;
  level._id_1044B scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_10346, "sc_titan_bts_yesmaam");
  level._id_1044B thread _id_0B6A::_id_EC0A(var_0);
  level._id_1044B _id_1375D(var_0, 150);

  if(distance2d(level.player.origin, var_0.origin) > 335 && level.player _id_9D65(level._id_1044B)) {
    level._id_1044B waittill("sceneblock_reach_finished");
    level thread _id_3092();
    level._id_1044B scripts\sp\utility::_id_7799(level.player);

    while(distance2d(level.player.origin, level._id_1044B.origin) > 275 && !level.player _id_9D65(level._id_1044B))
      scripts\engine\utility::waitframe();

    level._id_1044B scripts\sp\utility::_id_77B9(0.7);
  }

  stopcinematicingame();
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  level notify("ab triggered");
  var_1 = _id_0EEB::_id_7976("bridge");
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_2.angles = var_2.angles + (0, -90, 0);
  level._id_1044B scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_13861, "on", level.player, "right");
  level._id_1044B scripts\engine\utility::delaythread(3.3, ::_id_AB0C);
  var_3 = _id_7B74(var_2, level._id_1044B, "leave_elevator_performance");
  level._id_1044B _id_0EE5::_id_202E(var_3, 5, undefined, 1);
  var_2 delete();
  level._id_1044B scripts\sp\utility::_id_13861("off", level.player, "right");
  level._id_1044B linkTo(var_1, "");
}

_id_5B37() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::draw_angles(self.angles, self.origin, (1, 1, 0), 10);
    wait 0.1;
  }
}

_id_AB10() {
  scripts\engine\utility::flag_init("boats_leave_elevator_done");
  _id_AB0F();
  level._id_1044B.a.movement = "stop";
}

_id_AB0F() {
  var_0 = _id_0EEB::_id_7976("bridge");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.angles = var_1.angles + (0, -90, 0);
  var_1 linkTo(var_0);
  level._id_1044B clearanim(%facial_upbeat_idle_boats, 0.05);
  level._id_1044B thread _id_CD6E(var_1, "leave_elevator_performance", "shipcrib_stand_idle05_exit", ::_id_2C01, "boats_leave_elevator_done");
}

_id_CD6E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getanimlength(scripts\sp\utility::_id_7DC1(var_1));
  var_0 scripts\sp\anim::_id_1F35(self, var_1);
  self setanimknob(%facial_upbeat_idle_boats, 10, 0.2, 1);
  var_6 = scripts\engine\utility::spawn_tag_origin();
  self thread[[var_3]]();
  var_6 scripts\sp\anim::_id_1EC7(self, var_2);
  _id_0B6A::_id_EC04();
  self.a.movement = "stop";

  if(isDefined(var_4) && scripts\engine\utility::flag_exist(var_4))
    scripts\engine\utility::flag_set(var_4);

  var_0 delete();
  var_6 delete();
}

_id_2C01(var_0) {
  if(!isDefined(var_0))
    var_0 = 3;

  while(!level.player _id_9D65(level._id_1044B))
    scripts\engine\utility::waitframe();

  scripts\sp\utility::_id_77B9(0.7);
}

_id_9D65(var_0) {
  var_1 = scripts\sp\utility::_id_7951(var_0.origin, var_0.angles, self.origin);

  if(var_1 < 0)
    return 1;
  else
    return 0;
}

_id_1375D(var_0, var_1) {
  while(distance2d(self.origin, var_0.origin) > var_1)
    scripts\engine\utility::waitframe();
}

_id_7B74(var_0, var_1, var_2) {
  var_3 = level._id_EC85[var_1._id_1FBB][var_2];
  var_4 = getstartorigin(var_0.origin, var_0.angles, var_3);
  var_5 = getstartangles(var_0.origin, var_0.angles, var_3);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4, var_5);
  return var_6;
}

_id_2207() {
  thread _id_DB68();
  _id_2C03();
}

_id_2C03() {
  level._id_1044B endon("death");
  scripts\engine\utility::flag_wait("boats_leave_elevator_done");
  level._id_1044B thread _id_2C04();
  level._id_1044B _id_0B6A::_id_EC0B("shipcrib_titan_bridge_elevator_bottom", "shipcrib_stand_stationary_talk_idle_05", undefined, undefined, undefined, undefined, undefined, 1);
  level._id_1044B _id_0EE5::_id_202D("stand_idle_5_left_reaction", "sc_titan_abn_sergeantomarshouldbe");
}

_id_2C04() {
  self endon("death");
  self clearanim(%facial_upbeat_idle_boats, 0.05);
  scripts\sp\utility::_id_10346("sc_titan_abn_followmeifyou");
  self setanimknob(%facial_upbeat_idle_boats, 10, 0.05, 1);
  wait 3;
  self clearanim(%facial_upbeat_idle_boats, 1);
}

_id_DD6C() {
  thread _id_9840();
}

_id_9840() {
  _id_0E5C::main();
  _id_0E5D::main();
  level._id_A04F = _id_0EF8::_id_FDFC("spawner_mech_jack", "titan_jack_start");
  level._id_A04F endon("death");
  level._id_A04F._id_1FBB = "jack";
  level._id_A04F _id_0EE5::_id_202D("hallway_jack_europa_blended_react", "Sir.");
  level._id_A04F waittill("interaction_done");
  wait 0.5;
  level._id_A04F _id_0EE5::_id_10FC4();
  level._id_A04F _id_0EE5::_id_202D("hallway_jack_europa_blended_react_2", "Sir.");
  level._id_A04F waittill("interaction_done");
  level._id_A04F _id_0EE5::_id_10FC4();
  level._id_EC85["jack"]["jack_idle"][0] = % sh3_15_eur_arm_hall_jack_idle;
  level._id_A04F scripts\sp\anim::_id_1EEA(level._id_A04F, "jack_idle");
}

_id_DB68() {
  level waittill("start_armory");
  _id_0EFB::_id_FDBA(level._id_1044B);
  _id_0EFB::_id_FDBA(level._id_4A69);
  _id_0EFB::_id_FDBA(level._id_A04F);
}

_id_F70B(var_0, var_1) {
  self waittill(var_1);
  scripts\engine\utility::flag_set(var_0);
}

_id_223C(var_0) {
  var_1 = spawn("script_model", level.player.origin - (0, 0, 128) + anglesToForward(level.player.angles) * 256);
  var_1 setModel("body_hero_protagonist");
  var_1 attach("head_hero_protagonist");
  var_1 scripts\engine\utility::delaycall(3, ::delete);
  level thread _id_0EE8::_id_F9E5();
  _id_0EFB::_id_FDBA(level._id_1044B);
  _id_0EFB::_id_FDBA(level._id_A04F);
  scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_4054();
  _id_1063C();
  level scripts\engine\utility::delaythread(2, ::_id_2244);
  level notify("start_armory");
  level thread _id_0EE6::_id_2202("titan_start_bg_weapon_racks");
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A7("titan_start_bg_3d_printers");
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A7("titan_start_bg_3d_printers");
  _id_10BA7();
  _id_4053();
  var_2 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_2 scripts\sp\anim::_id_1EC3(level._id_8604, "terminal_intro");
  level._id_8604 _id_0EFB::_id_EB8D("titan");
  thread _id_0EE8::_id_1F7E();
  thread sc_titan_dof_blend();
  level waittill("skippable_cinematic_done");

  if(!level.console)
    waitforalltransients();

  var_3 = level.player _meth_84C6("equipmentState", "coverwall");

  if(var_3 == "locked") {
    level._id_D9E5["weaponstates"]["coverwall"] = "unlocked";
    level.player _meth_84C7("equipmentState", "coverwall", "scanned");
  }

  _id_62A8();
  thread _id_DB89();
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  level notify("start_titan_armory");
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_21AF();
  var_2 thread scripts\sp\anim::_id_1F35(level._id_8604, "terminal_intro");
  level._id_8604 thread scripts\sp\utility::_id_10346("titan_sc_amo_primedsomechoicehardware");
  level scripts\engine\utility::flag_wait("armory_chose_loadout");
  _id_2A52();
  level notify("titan_start_bg_weapon_racks");
  scripts\engine\utility::delaythread(0.1, _id_0EF7::_id_CD9C);
  level thread _id_0B20::_id_5A2E("armory", "locked");
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  setmusicstate("mx_176_shipcribtitan_weaponpickup");
  thread _id_CD8E();
}

sc_titan_dof_blend() {
  thread _id_0B0A::_id_583F(0, 80, 6, 175, 200, 6, 0);
  level waittill("skippable_cinematic_done");
  wait 5.0;
  thread _id_0B0A::_id_583D(1);
}

_id_2244() {
  level _id_0A2F::_id_12642();
  level thread scripts\sp\utility::_id_12651(["shipcrib_titan_bridgee_tr", "shipcrib_titan_exterior_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_titan_dropship_tr"]);
}

_id_1063C() {
  _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
  _id_0EF8::_id_FDFC("spawner_omar", "omar_armory_moveto2");
  level._id_C47F scripts\sp\utility::_id_DC45("raise");
  level._id_2219 = _id_0EF8::_id_FDFC("spawner_marine", "armory_enter_crew_1");
  level._id_221A = _id_0EF8::_id_FDFC("spawner_marine", "armory_enter_crew_2");
  level._id_2219._id_1FBB = "crew_1";
  level._id_221A._id_1FBB = "crew_2";
  _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_titan_armory_airboss_elevator");
  level._id_828C scripts\sp\utility::_id_65E0("waiting_for_reese");
  _id_0EF8::_id_FDFC("spawner_sahora", "shipcrib_titan_airboss_sahora");
}

_id_4053() {
  level.player _meth_823B(getEnt("shipcrib_titan_armory_end", "targetname"));
  _id_4052();
  scripts\sp\utility::_id_11633(getEnt("shipcrib_titan_armory_end", "targetname"));
  self._id_5A3C.angles = (0, 64, 0);
}

_id_2A52() {
  level thread _id_10C6D();
}

_id_DB89() {
  level waittill("fade_done");

  if(!isDefined(level._id_FDFA))
    _id_0EFB::_id_F59B("titan");

  _id_0EF7::_id_CD9D();
}

_id_4052() {
  level._id_2219 delete();
  level._id_221A delete();
}

_id_10BA7() {
  level.player _meth_82C0("shipcrib_titan_pre_armory_bink", 0.0);
  thread scripts\sp\anim::_id_1F2C([level._id_8604, level._id_C47F, level._id_2219, level._id_221A], "titan_armory_enter");
  level thread scripts\sp\utility::_id_C12D("armory_cinematic_skip_safe", 5);
  level.player.disabledweapon = 1;
  level thread scripts\sp\utility::_id_CE10("sc_titan_cutscene_omar_convo", "armory_cinematic_skip_safe");
  level.player scripts\engine\utility::delaycall(1.7, ::_meth_82C0, "armory_bink", 0.75);
  level _id_D04D(self, "titan_armory_enter", 0.4);
}

_id_62A8() {
  level.player clearclienttriggeraudiozone(3.0);
  level notify("titan_start_bg_3d_printers");
}

_id_BC4F(var_0) {
  level.player playSound("scn_shipcrib_titan_post_armory_plr");
  self unlink();
  scripts\engine\utility::waitframe();
  var_1 = level.player scripts\engine\utility::spawn_tag_origin();
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = var_2.origin + anglesToForward(var_2.angles) * 30;
  self playerlinkTo(var_2, "tag_origin");
  var_2 moveTo(var_3, var_0, 0.0, 0.35);
  wait(var_0);
  self unlink();
}

_id_F529() {
  var_0 = getEnt("at_terminal_trigger", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("player_entered_terminal");
}

_id_13688() {}

_id_D04D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  if(isDefined(var_4)) {
    var_6 = var_1 + "_open";
    var_7 = var_1 + "_hold";
    var_8 = var_1 + "_close";
    var_1 = var_6;

    if(!isDefined(var_5))
      var_5 = 5;
  }

  var_9 = _id_0EFB::_id_FE02("player_rig", var_0.origin);
  var_9 hide();
  var_10 = spawn("script_model", (0, 0, 0));
  var_10 scripts\sp\utility::_id_23CA();
  var_10 setModel("body_hero_protagonist");
  var_10._id_1FBB = "hero_char";
  var_10 hide();
  level thread _id_2240(var_10, var_9, var_1);
  var_11 = [];
  var_11["door"] = var_0._id_5A3C;
  var_11["player_rig"] = var_9;
  var_11["hero_char"] = var_10;
  var_0 scripts\sp\anim::_id_1EC1(var_11, var_1);
  level.player _meth_823C(var_9, "tag_player", var_2);
  wait(var_2);
  var_9 show();

  if(isDefined(var_3))
    var_0 thread[[var_3]]();

  var_0 scripts\sp\anim::_id_1F2C(var_11, var_1);

  if(isDefined(var_4)) {
    var_0 thread scripts\sp\anim::_id_1EE7(var_11, var_7, "stop_loop");
    wait(var_5);
    var_0 notify("stop_loop");
    var_0 scripts\sp\anim::_id_1F2C(var_11, var_8);
  }

  level notify("door_lerp_finished");
  var_9 delete();
  var_10 delete();
  level.player unlink();
}

_id_2240(var_0, var_1, var_2) {
  scripts\sp\anim::_id_17FC(var_1._id_1FBB, "hide_viewmodel", "hide_viewmodel", var_2);
  level waittill("hide_viewmodel");
  var_1 hide();
  var_0 show();
  var_0 attach("head_hero_protagonist");
}

_id_222D(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag("player_gesture_done"))
    scripts\engine\utility::flag_clear("player_gesture_done");

  if(isDefined(var_2)) {
    if(isDefined(var_3))
      scripts\engine\utility::delaythread(var_3, scripts\sp\utility::play_sound_on_entity, var_2);
    else
      thread scripts\sp\utility::play_sound_on_entity(var_2);
  }

  var_4 = 0;
  scripts\sp\utility::_id_D090(var_0);

  if(isDefined(var_1)) {
    var_4 = var_1;
    wait(var_4);
    scripts\sp\utility::_id_1102B();
  }

  scripts\engine\utility::flag_set("player_gesture_done");
}

_id_10CAA() {
  _id_CD8F();
}

_id_CD8F() {
  level._id_C47F endon("stop_armory_scene");
  var_0 = scripts\engine\utility::getStruct("omar_armory_endofbink", "targetname");
  level._id_C47F scripts\sp\utility::_id_51E1("casual_gun");
  level._id_C47F _id_0EFB::_id_EB8D("titan");
  level._id_C47F scripts\engine\utility::delaycall(0.05, ::_meth_82B0, %shipcrib_titan_armory_booth_mco_enter, 0.4);
  var_0 scripts\sp\anim::_id_1F35(level._id_C47F, "shipcrib_titan_armory_booth_mco_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_C47F, "shipcrib_titan_armory_booth_mco_idle", "stop_loop");
}

_id_CD8E() {
  level._id_C47F _id_0EFB::_id_EB8D("titan");
  var_0 = scripts\engine\utility::getStruct("omar_armory_endofbink", "targetname");
  var_0 notify("stop_loop");
  var_1 = level._id_C47F scripts\sp\utility::_id_7DC1("mco_console_exit");
  var_2 = _id_0C4C::_id_6F41(7.0, 0.0, 37.63, 0.0, 1.0);
  var_3 = scripts\engine\utility::getStruct("omar_armory_moveto1", "targetname");
  var_3 thread scripts\sp\anim::_id_1F35(level._id_C47F, "mco_console_exit");
  scripts\engine\utility::waitframe();
  level._id_C47F _meth_82B0(var_1, 0.23);
  wait 11.0;
  level _id_0EAB::main();
  level._id_C47F thread scripts\sp\interaction::_id_CD4B("shipcrib_titan_mco_armory_exit");
  level._id_C47F thread scripts\sp\utility::_id_7798(level.player, 4.0, 0.7);
  level._id_C47F waittill("interaction_done");
  level._id_C47F thread scripts\sp\utility::_id_7799(level.player);
  level._id_C47F thread scripts\sp\utility::_id_7792(level.player);
  level waittill("armory_exited");
  level._id_C47F scripts\sp\utility::_id_77B9(0.5);
}

_id_10C6D() {
  level thread _id_21B0();
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  level thread _id_F529();
  level scripts\engine\utility::flag_wait("player_entered_terminal");
  _id_CD34(var_0);
}

_id_21B0() {
  level._id_8604 _id_0EFB::_id_EB8D("titan");
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 thread scripts\sp\anim::_id_1ECC(level._id_8604, "armory_officer_intro_idle", "stop_griff_idle");
}

_id_DB72() {
  wait 22;

  if(!scripts\engine\utility::flag("at_terminal") && !scripts\engine\utility::flag("armory_chose_loadout"))
    level._id_8604 scripts\sp\utility::_id_10346("titan_sc_amo_Readytochooseyour");
}

_id_CD31(var_0) {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 notify("stop_loop");
  var_0 scripts\sp\anim::_id_1EC7(level._id_8604, "armory_officer_intro");
}

_id_CD34(var_0) {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  level._id_8604 _id_0EE4::_id_86E8();
  level._id_8604._id_110C9 scripts\sp\utility::_id_23B7("griff_weapon");
  var_0 thread _id_21FB();
}

_id_21FB() {
  level._id_8604 endon("death");
  var_0 = [level._id_8604, level._id_8604._id_110C9];
  var_1 = ["armory_ambient_vig_1", "armory_ambient_vig_2", "armory_ambient_vig_3", "armory_ambient_vig_4", "armory_ambient_vig_5", "armory_ambient_vig_6", "armory_ambient_vig_7", "armory_ambient_vig_8"];
  var_2 = var_1;
  self notify("stop_griff_idle");

  for(;;) {
    if(var_2.size == 0)
      var_2 = var_1;

    thread scripts\sp\anim::_id_1EE7(var_0, "armory_ambient_idle", "stop_armory_ambient_loop");
    var_3 = level._id_8604 scripts\sp\utility::_id_7DC1("armory_ambient_idle")[0];
    wait(getanimlength(var_3) * randomintrange(1, 2));
    self notify("stop_armory_ambient_loop");
    var_4 = var_2[randomintrange(0, var_2.size)];
    var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    scripts\sp\anim::_id_1F2C(var_0, var_4);
  }
}

_id_21AE() {
  wait 84;
  level.player _meth_82C0("armory_bink", 8);
}

_id_FC29(var_0) {
  level._id_8604 playSound("scn_ship_armorer_foley_01");
  scripts\engine\utility::play_sound_in_space("scn_ship_armorer_foley_01_spkr", (763, -417, -794));
}

_id_FC2A(var_0) {
  level._id_8604 playSound("scn_ship_armorer_foley_02");
  scripts\engine\utility::play_sound_in_space("scn_ship_armorer_foley_02_spkr", (763, -417, -794));
}

_id_11995() {}

_id_11993(var_0) {
  level._id_8604 thread scripts\sp\utility::play_sound_on_tag("titan_sc_amo_fullcomplimentofweapons", "j_head");
  scripts\engine\utility::play_sound_in_space("titan_sc_amo_fullcomplimentofweapons_spkr", (763, -417, -794));
}

_id_1A73() {
  level thread _id_1A86();
  level thread _id_5EA4();
  level.player setstance("stand");
  level thread scripts\sp\utility::_id_13C3C();
  level.player _meth_82C0("shipcrib_titan_armory_pre_hangar", 0.0);
  _id_0EE6::_id_2200();
  _id_0EE6::_id_21A9();
  level notify("armory_exited");
  level._id_828C scripts\sp\utility::_id_65DD("waiting_for_reese");
  level._id_828C scripts\sp\utility::_id_415D("casual");
  level._id_EA29 scripts\engine\utility::delaythread(0, ::_id_1A80);
  level._id_828C scripts\engine\utility::delaythread(0, ::_id_1A75);
  level._id_C47F scripts\engine\utility::delaythread(0, ::_id_1A7E);
  level.player scripts\engine\utility::delaycall(1.6, ::clearclienttriggeraudiozone, 0.75);
  level.player scripts\engine\utility::delaycall(6.7, ::_meth_82C0, "shipcrib_titan_platform_ride_down", 3.0);
  level.player scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_D090, "ges_safe_door");
  level _id_0B20::_id_AB71(self, "titan_armory_exit", 0.4);
  level thread _id_0B20::_id_5A2E("armory_exit", "locked");
  _id_0EEB::_id_7976("gravity") notify("doors_close");
  level._id_FD6E.jackals["jackal_bay_3"] _id_0BDC::_id_A07D();
  wait 2;
  level thread _id_0EEB::_id_60F0("gravity", 26);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck");
  _id_0EEB::_id_7976("gravity") waittill("move_finished");
  level.player clearclienttriggeraudiozone(4.0);
  _id_5E80();
}

_id_1A86() {
  _id_0EFB::_id_FDBA(level._id_8604);
  level scripts\sp\utility::_id_1264E("shipcrib_titan_vr_tr");
  level scripts\sp\utility::_id_12643(["shipcrib_titan_halore_tr"]);
}

_id_1A75() {
  self endon("death");
  scripts\engine\utility::waitframe();
  var_0 = _id_0EEB::_id_7976("gravity");
  self linkTo(var_0);
  self.a.movement = "stop";
  var_0 scripts\sp\anim::_id_1F35(self, "airboss_elevator");
  self orientmode("face angle", self.angles[1]);
  self unlink();
  thread _id_5E81();
}

_id_1A7E() {
  self endon("death");
  self notify("stop_loop");
  self notify("stop_armory_scene");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  scripts\engine\utility::waitframe();
  var_0 = _id_0EEB::_id_7976("gravity");
  self linkTo(var_0);
  var_0 scripts\sp\anim::_id_1F35(self, "airboss_elevator");
  self unlink();
  thread _id_5E8E(var_0);
}

_id_1A80() {
  self endon("death");
  scripts\engine\utility::waitframe();
  var_0 = _id_0EEB::_id_7976("gravity");
  var_0 scripts\sp\anim::_id_1F35(self, "airboss_elevator");
  wait 2;
  thread _id_0B6A::_id_EC0A("shipcrib_titan_airboss_sahora_end");
  scripts\engine\utility::delaythread(5.5, _id_0B6A::_id_EC0D, "shipcrib_titan_dropship_sahora_start");
  scripts\engine\utility::delaythread(5.55, _id_0B6A::_id_EC0B, "shipcrib_titan_dropship_sahora_end", "hm_grnd_grn_kneel_idle_01");
}

_id_1A81(var_0) {
  level._id_EA29 scripts\sp\utility::_id_10346("sc_titan_sha_Sixsettojet");
}

_id_8A92() {
  var_0 = _id_0EF9::_id_FE03("forklift", "airboss_forklift_a");
  var_0 thread _id_0EED::_id_730B();
  var_0 endon("entitydeleted");
  wait 0.1;
  var_0 thread _id_0EED::_id_7309("airboss_forklift_a_cargo");
  var_0 _id_0EED::_id_730A("airboss_forklift_a");
  wait 0.5;
  var_0 _id_0EED::_id_7315();
  var_1 = 160000;

  for(;;) {
    if(distance2dsquared(level.player.origin, var_0.origin) >= var_1) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_0 _id_0EED::_id_730A("forklift_deep_backup");
  var_0 _id_0EED::_id_730A("airboss_forklift_a_return");
}

_id_8A93() {
  var_0 = _id_0EF9::_id_FE03("forklift", "airboss_forklift_b");
  var_0 thread _id_0EED::_id_730B();
  var_0 endon("entitydeleted");
  wait 6;
  var_0 _id_0EED::_id_7309("airboss_forklift_b_cargo");
  var_0 _id_0EED::_id_730A("airboss_forklift_b");
}

_id_5EA4() {
  level _id_5DA2();
  _id_0EF9::_id_FE03("dropship", "dropship_bay_1");
  level._id_FD6E._id_5EE3["dropship_bay_1"] _id_0BBC::_id_C5F1(["left", "right"], undefined, 1);
  level._id_FD6E._id_5EE3["dropship_bay_1"] _id_0BBF::_id_F458();
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F458();
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_106BA(1);
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F37F("left_01");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("loading", "sctitanload");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("tactical", "scrunning");
  var_0 = getEntArray("dropship_unload", "targetname");
  scripts\engine\utility::array_call(var_0, ::linkto, _id_0EEB::_id_7976("dropship"));
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_B348("hangar_marine_idle_ml");
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_1DDC();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient::_id_21AF("close");
  level thread _id_10A7::_id_8A6A("hangar_hustle");
  level thread _id_8A92();
  level scripts\engine\utility::delaythread(2, ::_id_8A93);
  level thread _id_0EEB::_id_60F0("jackal", 10);
  level thread _id_0EEB::_id_60F0("apc", 15);
  level scripts\engine\utility::delaythread(16, _id_0EEB::_id_60FD, "jackal", "Storage");
  level scripts\engine\utility::delaythread(36, _id_0EEB::_id_60FD, "jackal", "Flight Deck");
  level thread _id_5EA6("middle_01");
  level thread _id_5EA6("right_02");
  level thread _id_5EA6("middle_02");
  level thread _id_5EA6("left_01");
  level thread _id_5EA6("right_01");
  level thread _id_5EA7(1);
  level thread _id_5EA7(2);
  level._id_5E1A = scripts\engine\utility::spawn_tag_origin();
  level._id_5E1A.origin = level._id_FD6E._id_5EE3["dropship_bay_2"]._id_4D94._id_F08B["left_01"].origin + (0, 0, 10) + anglesToForward(level._id_FD6E._id_5EE3["dropship_bay_2"]._id_4D94._id_F08B["left_01"].angles) * 16;
  level._id_5E1A linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_1 = scripts\engine\utility::play_loopsound_in_space("shipcrib_dropship_warmup", (1969, -268, -1125));
  var_1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_2 = scripts\engine\utility::play_loopsound_in_space("emt_dropship_cockpit_radio_lp", (2069, -551, -1084));
  var_2 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_2C23 = _id_0EF8::_id_FDFC("spawner_boggs", level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_2C23 _id_0EF8::_id_FE00();
  level._id_2C23 scripts\sp\utility::_id_DC45("raise");
  level._id_2C23._id_1FBB = "boggs";
  level._id_30F6 = _id_0EF8::_id_FDFC("spawner_brooks", level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_30F6 scripts\sp\utility::_id_DC45("raise");
  level._id_30F6 _id_0EFB::_id_EB8D("titan");
  level._id_A538 = _id_0EF8::_id_FDFC("spawner_kash", level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A538 scripts\sp\utility::_id_DC45("raise");
  level._id_A538 _id_0EFB::_id_EB8D("titan");
  level.player.helmet = scripts\sp\utility::_id_10639("helmet_desert");
  level._id_C47F.helmet = scripts\sp\utility::_id_10639("helmet_mco");
  level._id_A538.helmet = scripts\sp\utility::_id_10639("helmet_kash");
  level._id_30F6.helmet = scripts\sp\utility::_id_10639("helmet_brooks");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EC3(level.player.helmet, "player_helmet_on");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EC3(level._id_C47F.helmet, "mco_helmet_on");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EC3(level._id_30F6.helmet, "brooks_helmet_on");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EC3(level._id_A538.helmet, "kash_helmet_on");
  level._id_C47F.helmet linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_2C23._id_113CA = scripts\sp\utility::_id_10639("tablet");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(level._id_2C23._id_113CA, "dropship_start_idle", "stop_boggs_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(level._id_2C23, "dropship_start_idle", "stop_boggs_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(level._id_30F6, "dropship_start_idle", "stop_brooks_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(level._id_A538, "dropship_start_idle", "stop_kash_loop");
  level._id_FD6E.jackals["jackal_b_dock_vehicle"] thread _id_A0C2();
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 6);
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 scripts\engine\utility::delaythread(30, _id_0EE4::_id_A25C, "unload_ground", 6);
  level._id_D03F = scripts\engine\utility::spawn_tag_origin(level._id_FD6E._id_5EE3["dropship_bay_2"].origin);
  level._id_D03F.angles = (0, 20, 0);
  level._id_D03F linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  playFXOnTag(scripts\engine\utility::getfx("vfx_dropship_main"), level._id_D03F, "tag_origin");
}

_id_A05E() {
  self waittill("reached_end_node");
  _id_0EEF::_id_15B0(["jackal_bay_1"], "air");
  wait 2;
  _id_0EEF::_id_15B0(["jackal_bay_1"], "nitrogen");
}

#using_animtree("jackal");

_id_A0C2() {
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread scripts\sp\utility::_id_C12D("jackal_loading_gantry_stop_random", 25);
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 scripts\engine\utility::delaythread(25, _id_0EE4::_id_A25C, "unload", 6);
  self waittill("reached_end_node");
  self setanimknob(%shipcrib_veh_jackal_lean_wheel_rotate, 1, 0.1, 0);
  scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::_meth_82A2, %shipcrib_veh_jackal_lean_hatch_center_open, 1, 0, 0.25);
  scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::_meth_82A2, %shipcrib_veh_jackal_lean_hatch_left_open, 1, 0, 0.25);
  scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::_meth_82A2, %shipcrib_veh_jackal_lean_hatch_top_open, 1, 0, 0.25);
  _id_0EEF::_id_15B0(["jackal_bay_2"], "air");
  wait 2;
  _id_0EEF::_id_15B0(["jackal_bay_2"], "nitrogen");
}

_id_5DA2() {
  if(isDefined(level._id_FD6E._id_5EE3) && isDefined(level._id_FD6E._id_5EE3["dropship_bay_2"])) {
    return;
  }
  _id_0EF9::_id_FE03("dropship", "dropship_bay_2");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("loading", "sctitanload");
}

_id_5EA6(var_0) {
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D(var_0);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EC3(var_1, "seat_ff");
  var_1 attach("pack_un_jackal_pilots", "tag_jetpack");

  if(var_0 == "left_01") {
    var_1 hidepart("tag_screen");
    level._id_5D80 = getEnt("player_dropship_seat_bink", "targetname");
    level._id_5D80 hide();
    level._id_5D80.angles = var_1 gettagangles("tag_screen") + (0, -90, 0);
    level._id_5D80.origin = var_1 gettagorigin("tag_screen") + anglesToForward(level._id_5D80.angles) * 0.15 + anglestoup(level._id_5D80.angles) * 1.1 + anglestoright(level._id_5D80.angles) * 0.24;
    level._id_5D80 linkTo(var_1, "tag_screen");
  }
}

_id_5EA8(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_10639("dropship_seat01", level._id_FD6E._id_5EE3["dropship_bay_2"] gettagorigin(var_0), level._id_FD6E._id_5EE3["dropship_bay_2"] gettagangles(var_0) + (0, var_1, 0));
  var_2 scripts\sp\anim::_id_1EC3(var_2, "static_seat_ff");
  var_2 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
}

_id_5EA7(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F088[var_0] = scripts\sp\utility::_id_10639("dropship_seat_mount0" + var_0, level._id_FD6E._id_5EE3["dropship_bay_2"].origin);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EC3(level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F088[var_0], "seat_mount_ff");
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F088[var_0] linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
}

_id_5E80() {
  level thread _id_5E85();
  level._id_C47F waittill("trigger_mr1_mr2");
  level._id_30F6 thread _id_5E86();
  level._id_A538 thread _id_5E8B();
  level._id_2C23 thread _id_5E83();
  level._id_5E1A waittill("trigger");
  level._id_5E1A delete();
  setomnvar("ui_hide_weapon_info", 1);
  setomnvar("ui_hide_hud", 0);
  level scripts\engine\utility::delaythread(10.0, scripts\sp\utility::_id_9145, "fluff_messages_boost_engaged");
  scripts\engine\utility::flag_set("player_getting_in_seat");
  level._id_C47F thread _id_0EFB::_id_FE0B();
  level._id_30F6 thread _id_0EFB::_id_FE0B();
  level._id_A538 thread _id_0EFB::_id_FE0B();
  _id_0EF8::_id_FDFC("spawner_ethan", "shipcrib_titan_atom_lounge");
  level._id_6754 _id_0EFB::_id_EB8D("titan");
  level thread _id_5E93();
  var_0 = _id_0EFB::_id_FE02("player_rig");
  var_0 hide();
  level._id_D267 = var_0;
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EC3(var_0, "plr_enter_seat");
  var_1 = getweaponmodel(level.player getcurrentprimaryweapon());
  level thread _id_5E6C();
  level.player _meth_823C(var_0, "tag_player", 0.4, 0.2, 0.2);
  wait 0.45;
  scripts\engine\utility::flag_set("player_in_seat");
  level thread _id_5E88();
  var_0 show();
  var_0 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_0 attach(var_1, "tag_weapon_right");
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player _meth_81DE(53, 7.433);
  var_2 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D("left_01");
  level thread _id_5ECE();
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_2, "plr_enter_seat");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(level.player.helmet, "player_helmet_on");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1F35(var_0, "plr_enter_seat");
  level.player _meth_8562();
  level.player _meth_8573("default_character_shadow");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaythread(13, _id_0BBF::_id_F459, 1);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaythread(14, _id_0BBF::_id_F596, "on_random", ["left_01", "middle_02", "right_02"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaythread(16.5, ::_id_B501);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaythread(17, _id_0BBF::_id_F596, "on", "right_01");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaythread(18.5, _id_0BBF::_id_F596, "on", "middle_01");
  thread _id_F606();
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0, "plr_seat_look");
  level.player playerlinktodelta(var_0, "tag_player", 1, 40, 40, 20, 20, 1);
  level.player _meth_8392(0.2, 2.2, 0.6);
}

_id_5E6C() {
  level.player._id_110C8 = level.player getcurrentprimaryweapon();
  level.player allowcrouch(0);
  level.player scripts\sp\utility::_id_D090("ges_quick_drop");
  wait 0.25;
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  level.player disableweaponswitch();
}

_id_F606() {
  wait 13;
  visionsetnaked("shipcrib_dropship_lowlight", 0.4);
}

_id_B501() {
  _id_0BBF::_id_F454(1, "int", "scrunningscreen");
  var_0 = self._id_4D94.lights["int"]["scrunningscreen"];
  var_1 = 1;
  var_2 = 2;

  for(var_3 = 0; var_3 < var_1; var_3 = var_3 + 0.05) {
    foreach(var_5 in var_0) {
      if(!isDefined(var_5._id_DC62)) {
        var_5._id_DC62 = 0;
        var_5._id_93F1 = var_2 / (var_1 / 0.05);
      }

      var_5._id_DC62 = var_5._id_DC62 + var_5._id_93F1;
      var_5._id_DC62 = clamp(var_5._id_DC62, 0, var_2);
      var_5 setlightintensity(var_5._id_DC62);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_5ECE() {
  wait 12;
  level._id_5D80 show();
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("sc_titan_world_dropship_screen");
}

_id_5E93() {
  if(scripts\engine\utility::flag("shipcrib_titan_vr_tr_loaded"))
    _id_0F2D::_id_12BA8();

  _id_10AA::_id_A315(_id_0EFB::_id_FD9C("jackal_service"));
  _id_10A3::_id_3B9E();
  _id_10A2::_id_1A5E();
  level._id_E35D._id_47D9 delete();
  level._id_FD6E._id_1912["all"] = scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_C47F);
  level._id_FD6E._id_1912["all"] = scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_6754);
  level._id_FD6E._id_1912["all"] = scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_2C23);
  level._id_FD6E._id_1912["all"] = scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_30F6);
  level._id_FD6E._id_1912["all"] = scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_A538);
  _id_0EFB::_id_FDBB("all");
  level notify("stop_creating_forklifts");
  _id_0EFB::_id_FDE8(level._id_FD6E.jackals);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_209C);
  _id_0EFB::_id_FDCD();
  level notify("screens_stop_thinking");
  level._id_E35D._id_6A38 thread _id_0B51::_id_5155();
  level scripts\sp\utility::_id_12651(["shipcrib_titan_prime_tr", "shipcrib_titan_prime_in_tr", "shipcrib_titan_mezz_tr", "shipcrib_titan_ambient_tr", "shipcrib_titan_ambientml_tr", "shipcrib_titan_jackal_tr", "shipcrib_titan_halore_tr", "shipcrib_titan_vr_tr"]);
  wait 1;

  if(!isDefined(level._id_5947))
    level scripts\sp\utility::_id_BF97(undefined, undefined, 0);
}

_id_5E85() {
  level endon("no_dropship_breadcrumb");
  wait 60;
  level thread _id_0B6A::_id_EC02("shipcrib_titan_dropship_breadcrumb", 1);
}

_id_5E88() {
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597A, 10);
  wait 9;
  level.player playSound("scn_ship_launch_alarm_lr");
  level.player scripts\engine\utility::delaycall(2, ::_meth_82C0, "shipcrib_titan_dropship_fly", 3);
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBC::_id_4265(["back"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\utility::play_sound_on_tag("scn_ship_launch_bkdoor_close", "j_lowerbackdoor1");
  level.player scripts\engine\utility::delaycall(1.3, ::playsound, "scn_ship_launch_move_01_lr");
  wait 2;
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.3, 0, 0, 0, 14, 14, 14);
  wait 1;
  var_0 = 8;
  level.player playRumbleOnEntity("heavy_2s");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.035, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_5EE3["dropship_bay_2"] linkTo(var_1);
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos2").origin;
  var_1 moveTo(var_2, var_0);
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
  wait(var_0);
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0, 0, 0, 7, 7, 7);
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 5);
  level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C playSound("scn_ship_launch_door_open");
  level _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C, 5);
  var_0 = 10;
  level.player playRumbleOnEntity("heavy_2s");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.025, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  level.player playSound("scn_ship_launch_move_02_lr");
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos3").origin;
  var_1 moveTo(var_2, var_0);
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
  wait(var_0);
  level.player playRumbleOnEntity("heavy_2s");
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C, 5);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0.35, 0, 0, 10, 10, 10);
}

_id_5E83() {
  self endon("death");
  scripts\engine\utility::flag_wait("player_enter_dash2");
  level notify("no_dropship_breadcrumb");
  level thread _id_0B6A::_id_EC03("shipcrib_titan_dropship_breadcrumb");
  level._id_5E1A thread _id_5E87();
  level._id_FD6E._id_5EE3["dropship_bay_2"] notify("stop_boggs_loop");
  level scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_set, "boggs_prepped");
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_2C23._id_113CA linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D("left_01");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0, "dropship_board");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(level._id_2C23._id_113CA, "dropship_board");
  level._id_2C23 scripts\engine\utility::delaythread(12.5, ::_id_5E84);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1F35(self, "dropship_board");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EEA(self, "dropship_idle", "stop_loop");
}

_id_5E84() {
  self endon("death");
  level endon("player_in_seat");

  if(scripts\engine\utility::flag("player_in_seat")) {
    return;
  }
  scripts\engine\utility::flag_wait("player_near_boggs");
  scripts\sp\utility::_id_10346("sc_titan_bgs_gotaniceaisle");
  scripts\engine\utility::flag_waitopen("player_near_boggs");
  thread _id_0EE5::_id_202D();
}

_id_5E87() {
  wait 1;
  _id_0E46::_id_48C4(undefined, (0, 0, 45), undefined, 70, 4000, 60, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

_id_5E86() {
  self endon("death");
  level endon("player_in_seat");
  level._id_FD6E._id_5EE3["dropship_bay_2"] notify("stop_brooks_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1F35(self, "dropship_enter");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(self, "dropship_idle", "stop_brooks_loop");
  scripts\engine\utility::flag_set("brooks_prepped");
  scripts\engine\utility::flag_wait_all("player_really_enter_dash2", "boggs_prepped", "kash_prepped");
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D("right_02");
  level._id_FD6E._id_5EE3["dropship_bay_2"] notify("stop_brooks_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0, "dropship_player_enter");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1F35(self, "dropship_player_enter");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(self, "dropship_idle2", "stop_brooks_loop");
}

_id_5E8B() {
  self endon("death");
  level endon("player_in_seat");
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D("middle_02");
  level._id_FD6E._id_5EE3["dropship_bay_2"] notify("stop_kash_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1F35(self, "dropship_enter");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(self, "dropship_idle", "stop_kash_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(var_0, "dropship_idle", "stop_kash_loop");
  scripts\engine\utility::flag_set("kash_prepped");
  scripts\engine\utility::flag_wait_all("player_really_enter_dash2", "boggs_prepped", "brooks_prepped");
  level._id_FD6E._id_5EE3["dropship_bay_2"] notify("stop_kash_loop");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_0, "dropship_player_enter");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1F35(self, "dropship_player_enter");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(self, "dropship_idle2", "stop_kash_loop");
  thread _id_5E8C();
}

_id_5E8C() {
  self endon("death");
  level endon("player_in_seat");
  wait 7;

  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) < 40000 && scripts\sp\utility::_id_7951(self.origin + (0, 0, 50), self.angles, level.player.origin) > 0.7) {
      level._id_FD6E._id_5EE3["dropship_bay_2"] notify("stop_kash_loop");
      level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1F35(self, "dropship_player_nag");
      level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EEA(self, "dropship_idle2", "stop_kash_loop");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_5E8E(var_0) {
  self endon("death");
  level endon("player_in_seat");
  level thread _id_8AA8();
  scripts\engine\utility::delaythread(1.5, ::_id_5E8F);
  self animmode("noclip");
  var_0 scripts\sp\anim::_id_1F35(self, "dropship_walk_up_ramp");
  self._id_DD4C = 1;
  level _id_0EAC::main();
  scripts\sp\interaction::_id_CD4B("shipcrib_titan_mco_dropship_react", var_0);
}

_id_5E8F() {
  self endon("death");
  level endon("player_in_seat");
  thread scripts\sp\utility::_id_77B7("move_up");
  thread scripts\sp\utility::_id_10346("sc_titan_usf_FormupLetsgo");
  wait 1;
  self notify("trigger_mr1_mr2");
  wait 3.5;
  thread _id_5E90();
}

#using_animtree("generic_human");

_id_5E90() {
  scripts\sp\utility::_id_10346("sc_titan_usf_KeepittightKashima");
  wait 2;
  scripts\sp\utility::_id_10346("sc_titan_usf_Noshameliberatingsome");
  self clearanim(%shipcrib_titan_talking, 0.2);
}

_id_5E81() {
  self endon("death");
  _id_0B6A::_id_EC0A("dropship_airboss_end_elevator");
  thread _id_0EE5::_id_202D();
}

_id_5E92() {
  screenshake(level.player.origin, 2.75, 0.75, 0.75, 0.75, 0, 0, 0, 8, 8, 8);
}

_id_5E89(var_0) {
  level._id_C47F notify("stop_mco_loop");
  level._id_30F6 notify("stop_brooks_loop");
  level._id_A538 notify("stop_kash_loop");

  if(!isDefined(level._id_30F6._id_86E9)) {
    level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EC3(level._id_30F6, "dropship_takeoff");
    level scripts\engine\utility::delaythread(0.5, scripts\sp\maps\shipcrib_titan\shipcrib_titan_anim::_id_110C7, level._id_30F6);
  }

  if(!isDefined(level._id_A538._id_86E9)) {
    level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1EC3(level._id_A538, "dropship_takeoff");
    level scripts\engine\utility::delaythread(0.5, scripts\sp\maps\shipcrib_titan\shipcrib_titan_anim::_id_110C7, level._id_A538);
  }

  if(!isDefined(level._id_30F6._id_8E05))
    scripts\sp\maps\shipcrib_titan\shipcrib_titan_anim::_id_8E05(level._id_30F6);

  if(!isDefined(level._id_A538._id_8E05))
    scripts\sp\maps\shipcrib_titan\shipcrib_titan_anim::_id_8E05(level._id_A538);

  level._id_6754 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_30F6 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A538 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_C47F linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_1 = getanimlength(level._id_C47F scripts\sp\utility::_id_7DC1("dropship_takeoff"));
  var_2 = _id_0EFB::_id_FE02("fake_player_rig");
  var_2 hide();
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EC3(var_2, "intro_dropoff_scene");
  var_2 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level scripts\engine\utility::delaythread(var_1 - 0.25, ::_id_5E92);
  level.player scripts\engine\utility::delaycall(var_1 - 0.5, ::_meth_823C, var_2, "tag_player", 0.4);
  var_3 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796E();
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_3["right_01"], "dropship_takeoff");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(level._id_6754, "dropship_takeoff");
  level._id_6754 scripts\engine\utility::delaycall(25.2, ::playsound, "scn_ship_dropship_ethan_enter_seat_tablet_up");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(level._id_30F6, "dropship_takeoff");
  level._id_30F6 scripts\engine\utility::delaycall(13.0, ::playsound, "scn_ship_dropship_brooks_enter_seat_tablet_up");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(level._id_A538, "dropship_takeoff");
  level._id_A538 scripts\engine\utility::delaycall(5.9, ::playsound, "scn_ship_dropship_kash_enter_seat_tablet_up");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_3["middle_01"], "dropship_takeoff");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_3["right_02"], "dropship_takeoff");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(var_3["middle_02"], "dropship_takeoff");
  var_4 = getanimlength(level._id_C47F scripts\sp\utility::_id_7DC1("dropship_takeoff"));
  var_5 = var_4 + 0.5;
  level.player scripts\engine\utility::delaycall(var_4 - 2.3, ::playsound, "scn_ship_launch_mtl_rumble");
  level._id_2C23 scripts\engine\utility::delaycall(19.0, ::playsound, "emt_dropship_cockpit_radio_prelaunch");
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaycall(var_4 - 5.0, ::playsound, "scn_ship_launch_engine_windup");
  scripts\sp\anim::_id_17FC("omar", "pvo_sc_titan_plr_Boggsyouregofor", "nextmission_ready", "dropship_takeoff");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(level._id_C47F, "dropship_takeoff");
  level._id_C47F scripts\engine\utility::delaycall(26.5, ::playsound, "scn_ship_dropship_mco_enter_seat_tablet_up");
  level._id_6754 scripts\engine\utility::delaythread(18, scripts\sp\utility::_id_10346, "titan_eth_yesstaffsergeant");
  level waittill("nextmission_ready");
  wait 2.7;
  level._id_5D80 hide();
  level thread scripts\sp\utility::_id_BF98();
  wait 1;

  if(!isDefined(level._id_5947)) {
    setmusicstate("mx_342_titan_intro_stinger");
    level.player _meth_82C0("fade_to_black_minus_music", 0.1);
    level.player _meth_84C7("scTitanFirstPlay", 1);
    scripts\sp\utility::_id_BF95();
  }
}

_id_5E94(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F456();
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
  wait 0.1;
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::delaythread(0.05, _id_0BBF::_id_F458);
  var_0 fadeovertime(0.1);
  var_0.alpha = 0;
}

_id_5E8D() {
  var_0 = scripts\sp\hud_util::_id_48B7("black", 0);
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F456();
  var_0 fadeovertime(0.05);
  var_0.alpha = 1;
}

_id_12915(var_0, var_1, var_2) {
  level._id_E3FC = getEnt("retribution_tug", "targetname");
  level._id_E3FC._id_5BCA = getEnt("retribution_tug_driver_node", "targetname");
  level._id_E3FC._id_C93A = getEnt("retribution_tug_passenger_node", "targetname");
  level._id_E3FC._id_5BCA linkTo(level._id_E3FC);
  level._id_E3FC._id_C93A linkTo(level._id_E3FC);

  if(isDefined(var_1))
    var_1 thread _id_12916();

  if(isDefined(var_2))
    var_2 thread _id_12917();

  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  level._id_E3FC.origin = var_3.origin;
  level._id_E3FC.angles = var_3.angles;
}

_id_12916() {
  self _meth_80F1(level._id_E3FC._id_5BCA.origin, level._id_E3FC._id_5BCA.angles);
  self linkTo(level._id_E3FC._id_5BCA);
  thread scripts\sp\anim::_id_1ECC(self, "tug_idle");
}

_id_12917() {
  self _meth_80F1(level._id_E3FC._id_C93A.origin, level._id_E3FC._id_C93A.angles);
  self linkTo(level._id_E3FC._id_C93A);
  thread scripts\sp\anim::_id_1ECC(self, "tug_idle", "stop_loop");
}

_id_12914(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  level._id_E3FC rotateTo(vectortoangles(var_3.origin - level._id_E3FC.origin), var_2);
  level._id_E3FC moveTo(var_3.origin, var_1);
  wait(var_1 * 0.95);
  level._id_E3FC rotateTo(var_3.angles, var_1 * 0.05);
  wait(var_1 * 0.05);
}

_id_E3C8() {
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25E();
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread _id_0EE4::_id_A25E();
  level._id_E35D._id_AA5F["jackal_bay_3"]._id_7691 thread _id_0EE4::_id_A25C("unload", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_4"]._id_7691 thread _id_0EE4::_id_A25E();
}

_id_8AA8() {
  self endon("player_in_seat");
  wait 2;
  disablepaspeaker("pa_hangar");
  wait 1;
  enablepaspeaker("pa_hangar");

  for(;;) {
    level.player playSound("emt_ship_hangar_pa", "sounddone");
    level.player waittill("sounddone");
    wait(randomfloatrange(6, 10));
  }
}

_id_FE06() {
  wait 2;
  setmusicstate("mx_169_shipcribtitan_ambient_01");
}