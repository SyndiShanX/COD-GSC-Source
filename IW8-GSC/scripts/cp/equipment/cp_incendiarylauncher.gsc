/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_incendiarylauncher.gsc
**********************************************************/

function strike_scriptorigincreate() {}

function oic_guns(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = strtok(var_0, "-");
  var_3 = strtok(var_0, "&");
  var_4 = undefined;

  if(var_2.size > 1) {
    var_5 = int(var_2[0]);
    var_4 = level.players[var_5];
  }

  switch (var_1[0]) {
    default:
      level.players[0] scripts\cp_mp\execution::_giveexecution(var_0);
      break;
  }
}

function init_defend_global_spawn_function() {
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Neck Stab\" \"set scr_giveexecution neck_stab\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Throat Cut\" \"set scr_giveexecution throat_cut\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / execution_default_west\" \"set scr_giveexecution execution_default_west\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / execution_default_east\" \"set scr_giveexecution execution_default_east\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Charly / Execution 000 Baton\" \"set scr_giveexecution execution_mp_western_charly_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Charly / Execution 001 Pistol\" \"set scr_giveexecution execution_mp_western_charly_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Murphy / Execution 003 Baton\" \"set scr_giveexecution execution_mp_western_murphy_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Murphy / Execution 004 Pistol\" \"set scr_giveexecution execution_mp_western_murphy_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Otter / Execution 006 Baton\" \"set scr_giveexecution execution_mp_western_otter_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Otter / Execution 007 Pistol\" \"set scr_giveexecution execution_mp_western_otter_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Wyatt / Execution 009 Knife\" \"set scr_giveexecution execution_mp_western_wyatt_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Wyatt / Execution 010 Cattle Prod\" \"set scr_giveexecution execution_mp_western_wyatt_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Golem / Execution 012 Knife\" \"set scr_giveexecution execution_mp_western_golem_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Golem / Execution 013 Cattle Prod\" \"set scr_giveexecution execution_mp_western_golem_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Domino / Execution 015 Knife\" \"set scr_giveexecution execution_mp_western_domino_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Domino / Execution 016 Cattle Prod\" \"set scr_giveexecution execution_mp_western_domino_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / D - Day / Execution 018 Hatchet\" \"set scr_giveexecution execution_mp_western_dday_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / D - Day / Execution 019 Martial Arts\" \"set scr_giveexecution execution_mp_western_dday_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Alice / Execution 021 Hatchet\" \"set scr_giveexecution execution_mp_western_alice_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Alice / Execution 022 Martial Arts\" \"set scr_giveexecution execution_mp_western_alice_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Raines / Execution 024 Hatchet\" \"set scr_giveexecution execution_mp_western_raines_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Raines / Execution 025 Martial Arts\" \"set scr_giveexecution execution_mp_western_raines_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Bale / Execution 032 Sambo\" \"set scr_giveexecution execution_mp_eastern_bale_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Bale / Execution 033 Halligan\" \"set scr_giveexecution execution_mp_eastern_bale_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Minotaur / Execution 035 Sambo\" \"set scr_giveexecution execution_mp_eastern_minotavr_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Minotaur / Execution 036 Halligan\" \"set scr_giveexecution execution_mp_eastern_minotavr_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Rodion / Execution 038 Sambo\" \"set scr_giveexecution execution_mp_eastern_rodion_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Rodion / Execution 039 Halligan\" \"set scr_giveexecution execution_mp_eastern_rodion_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Syd / Execution 041 Karambit\" \"set scr_giveexecution execution_mp_eastern_syd_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Syd / Execution 042 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_syd_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Yegor / Execution 044 Karambit\" \"set scr_giveexecution execution_mp_eastern_yegor_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Yegor / Execution 045 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_yegor_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Kreuger / Execution 047 Karambit\" \"set scr_giveexecution execution_mp_eastern_kreuger_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Kreuger / Execution 048 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_kreuger_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Grinch / Execution 050 Machete\" \"set scr_giveexecution execution_mp_eastern_grinch_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Grinch / Execution 051 Rungu\" \"set scr_giveexecution execution_mp_eastern_grinch_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Zane / Execution 053 Machete\" \"set scr_giveexecution execution_mp_eastern_zane_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Zane / Execution 054 Rungu\" \"set scr_giveexecution execution_mp_eastern_zane_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Azur / Execution 056 Machete\" \"set scr_giveexecution execution_mp_eastern_azur_default\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Executions / Give / Azur / Execution 057 Rungu\" \"set scr_giveexecution execution_mp_eastern_azur_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
}