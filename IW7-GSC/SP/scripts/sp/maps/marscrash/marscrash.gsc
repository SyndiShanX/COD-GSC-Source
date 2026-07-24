/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrash\marscrash.gsc
***************************************************/

main() {
  scripts\sp\utility::_id_116CB("marscrash");
  scripts\sp\utility::_id_F343("crash");
  scripts\sp\utility::_id_1749("crash", scripts\sp\maps\marscrash\marscrash_intro::_id_481B, "crashed", scripts\sp\maps\marscrash\marscrash_intro::_id_4816, ["marscrash_vista_tr", "marscrash_playspace_tr"], scripts\sp\maps\marscrash\marscrash_intro::_id_47F7);
  scripts\sp\utility::_id_1749("walk", scripts\sp\maps\marscrash\marscrash_intro::_id_10C8A, "Aftermath", scripts\sp\maps\marscrash\marscrash_intro::_id_B1FD, ["marscrash_prime_tr", "marscrash_vista_tr", "marscrash_playspace_tr"], scripts\sp\maps\marscrash\marscrash_intro::_id_3B77);
  scripts\sp\utility::_id_1749("dropship_approach", scripts\sp\maps\marscrash\marscrash_intro::_id_10C24, "Dropship approach", scripts\sp\maps\marscrash\marscrash_intro::_id_B1C6, ["marscrash_prime_tr", "marscrash_vista_tr", "marscrash_playspace_tr"], scripts\sp\maps\marscrash\marscrash_intro::_id_3B57);
  scripts\sp\utility::_id_1749("kashima_death", scripts\sp\maps\marscrash\marscrash_intro::_id_A546, "Kashima Death", scripts\sp\maps\marscrash\marscrash_intro::_id_A53E, ["marscrash_prime_tr", "marscrash_vista_tr", "marscrash_playspace_tr"], scripts\sp\maps\marscrash\marscrash_intro::_id_A53D);
  _id_D83F();
  scripts\sp\load::main();
  _id_D704();
}

_id_D83F() {
  precacheshellshock("player_limp");
  precacherumble("subtle_tank_rumble");
  _id_0BA9::_id_3994("un");
  scripts\sp\maps\marscrash\gen\marscrash_art::main();
  scripts\sp\maps\marscrash\marscrash_precache::main();
  scripts\sp\maps\marscrash\marscrash_fx::main();
  scripts\sp\maps\marscrash\marscrash_anim::main();
  scripts\sp\maps\marscrash\marscrash_intro::_id_9ACD();
  _id_9809();
  scripts\sp\utility::_id_1263F("marscrash_prime_tr");
  scripts\sp\utility::_id_1263F("marscrash_vista_tr");
  scripts\sp\utility::_id_1263F("marscrash_playspace_tr");
  setsaveddvar("sm_sunSampleSizeNear", 0.5);
  setsaveddvar("r_sdfShadowPenumbra", 0.2);
  setsaveddvar("r_umbraMinObjectContribution", 10);
  setsaveddvar("r_spotlightEntityShadows", 1);
  setsaveddvar("sm_roundrobinpriorityspotshadows", 6);
  setomnvar("ui_jackal_load_ui", 1);
}

_id_9809() {
  scripts\sp\maps\marscrash\marscrash_intro::_id_9AF2();
}

_id_D704() {
  _id_ABE0();
}

_id_5F26() {}

_id_5F20() {}

_id_5F1B() {}

_id_1723(var_0, var_1, var_2, var_3) {
  if(!scripts\sp\utility::_id_C268(var_0))
    objective_add(scripts\sp\utility::_id_C264(var_0), var_1, var_2);
}

_id_ABE0() {
  _id_1723("OBJECTIVE_SURVIVORS", "current", &"MARSCRASH_OBJECTIVE_SURVIVORS");
  scripts\engine\utility::flag_wait("dropship_triage_callout");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_SURVIVORS"));
}