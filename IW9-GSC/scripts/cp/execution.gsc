/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\execution.gsc
***********************************************/

init_cp_execution() {}

execution_debug(_id_CB325DDB4A764623) {
  items = strtok(_id_CB325DDB4A764623, "_");
  _id_ED553C0E628507CB = strtok(_id_CB325DDB4A764623, "-");
  params = strtok(_id_CB325DDB4A764623, "&");
  player = undefined;

  if(_id_ED553C0E628507CB.size > 1) {
    _id_992D4A4D67CE8BA5 = int(_id_ED553C0E628507CB[0]);
    player = level.players[_id_992D4A4D67CE8BA5];
  }

  switch (items[0]) {
    default:
      level.players[0] scripts\cp_mp\execution::_giveexecution(_id_CB325DDB4A764623);
  }
}

create_execution_devgui() {
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Neck Stab\" \"set scr_giveexecution neck_stab\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Throat Cut\" \"set scr_giveexecution throat_cut\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / execution_default_west\" \"set scr_giveexecution execution_default_west\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / execution_default_east\" \"set scr_giveexecution execution_default_east\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Charly / Execution 000 Baton\" \"set scr_giveexecution execution_mp_western_charly_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Charly / Execution 001 Pistol\" \"set scr_giveexecution execution_mp_western_charly_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Murphy / Execution 003 Baton\" \"set scr_giveexecution execution_mp_western_murphy_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Murphy / Execution 004 Pistol\" \"set scr_giveexecution execution_mp_western_murphy_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Otter / Execution 006 Baton\" \"set scr_giveexecution execution_mp_western_otter_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Otter / Execution 007 Pistol\" \"set scr_giveexecution execution_mp_western_otter_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Wyatt / Execution 009 Knife\" \"set scr_giveexecution execution_mp_western_wyatt_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Wyatt / Execution 010 Cattle Prod\" \"set scr_giveexecution execution_mp_western_wyatt_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Golem / Execution 012 Knife\" \"set scr_giveexecution execution_mp_western_golem_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Golem / Execution 013 Cattle Prod\" \"set scr_giveexecution execution_mp_western_golem_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Domino / Execution 015 Knife\" \"set scr_giveexecution execution_mp_western_domino_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Domino / Execution 016 Cattle Prod\" \"set scr_giveexecution execution_mp_western_domino_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / D - Day / Execution 018 Hatchet\" \"set scr_giveexecution execution_mp_western_dday_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / D - Day / Execution 019 Martial Arts\" \"set scr_giveexecution execution_mp_western_dday_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Alice / Execution 021 Hatchet\" \"set scr_giveexecution execution_mp_western_alice_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Alice / Execution 022 Martial Arts\" \"set scr_giveexecution execution_mp_western_alice_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Raines / Execution 024 Hatchet\" \"set scr_giveexecution execution_mp_western_raines_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Raines / Execution 025 Martial Arts\" \"set scr_giveexecution execution_mp_western_raines_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Bale / Execution 032 Sambo\" \"set scr_giveexecution execution_mp_eastern_bale_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Bale / Execution 033 Halligan\" \"set scr_giveexecution execution_mp_eastern_bale_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Minotaur / Execution 035 Sambo\" \"set scr_giveexecution execution_mp_eastern_minotavr_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Minotaur / Execution 036 Halligan\" \"set scr_giveexecution execution_mp_eastern_minotavr_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Rodion / Execution 038 Sambo\" \"set scr_giveexecution execution_mp_eastern_rodion_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Rodion / Execution 039 Halligan\" \"set scr_giveexecution execution_mp_eastern_rodion_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Syd / Execution 041 Karambit\" \"set scr_giveexecution execution_mp_eastern_syd_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Syd / Execution 042 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_syd_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Yegor / Execution 044 Karambit\" \"set scr_giveexecution execution_mp_eastern_yegor_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Yegor / Execution 045 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_yegor_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Kreuger / Execution 047 Karambit\" \"set scr_giveexecution execution_mp_eastern_kreuger_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Kreuger / Execution 048 Brass Knuckles\" \"set scr_giveexecution execution_mp_eastern_kreuger_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Grinch / Execution 050 Machete\" \"set scr_giveexecution execution_mp_eastern_grinch_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Grinch / Execution 051 Rungu\" \"set scr_giveexecution execution_mp_eastern_grinch_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Zane / Execution 053 Machete\" \"set scr_giveexecution execution_mp_eastern_zane_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Zane / Execution 054 Rungu\" \"set scr_giveexecution execution_mp_eastern_zane_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Azur / Execution 056 Machete\" \"set scr_giveexecution execution_mp_eastern_azur_default\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Executions / Give / Azur / Execution 057 Rungu\" \"set scr_giveexecution execution_mp_eastern_azur_variant_1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

_id_94C333BD965E6685() {
  while(!isDefined(self.operatorcustomization))
    waitframe();

  self.operatorcustomization.execution = "execution_000";
  scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
}

_id_66C4C8A999A309A8() {
  self endon("disconnect");
  self notify("execution_swapExecutionsAfterKill");
  self endon("execution_swapExecutionsAfterKill");

  for(;;) {
    _id_6AEC809BE13C61CC = self.operatorcustomization.execution;
    self waittill("killed_ai_via_execution");

    if(scripts\engine\utility::cointoss())
      _id_6AEC809BE13C61CC = "execution_00" + randomintrange(0, 9);
    else
      _id_6AEC809BE13C61CC = "execution_0" + randomintrange(10, 16);

    self.operatorcustomization.execution = _id_6AEC809BE13C61CC;
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
  }
}